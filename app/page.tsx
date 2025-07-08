import Image from "next/image";
import Header from "@/components/Header";
import Todo from "@/components/Todo";

export default function Home() {
  return (
  <div className="text-4xl">
    <Header />
    <Todo />
  </div>
  );
}
