Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6EDE77184
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 11:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2D910E931;
	Tue, 17 Dec 2024 11:26:33 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7CE1910E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 01:21:35 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8BxeeA3z2BnHpdXAA--.39842S3;
 Tue, 17 Dec 2024 09:09:11 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowMDxPEcyz2BnXNeFAA--.16436S5;
 Tue, 17 Dec 2024 09:09:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/9] objtool: Handle PC relative relocation type
Date: Tue, 17 Dec 2024 09:08:59 +0800
Message-ID: <20241217010905.13054-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241217010905.13054-1-yangtiezhu@loongson.cn>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPEcyz2BnXNeFAA--.16436S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr48Ww13Xw15uryfGFyrKrX_yoW7Jw45pF
 srC398Kr4Yqr1xWw42ya1kWrW5Gan7Wry2qryDtryrZrZFqw15tFWxAFZ8Ka1UXwsYgFWx
 ZFnYgw17AF4qv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Mailman-Approved-At: Tue, 17 Dec 2024 11:26:25 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the most part, an absolute relocation type is used for rodata.
In the case of STT_SECTION, reloc->sym->offset is always zero, for
the other symbol types, reloc_addend(reloc) is always zero, thus it
can use a simple statement "reloc->sym->offset + reloc_addend(reloc)"
to obtain the symbol offset for various symbol types.

When compiling on LoongArch, there exist PC relative relocation types
for rodata, it needs to calculate the symbol offset with "S + A - PC"
according to the spec of "ELF for the LoongArch Architecture".

If there is only one jump table in the rodata, the "PC" is the entry
address which is equal with the value of reloc_offset(reloc), at this
time, reloc_offset(table) is 0.

If there are many jump tables in the rodata, the "PC" is the offset
of the jump table's base address which is equal with the value of
reloc_offset(reloc) - reloc_offset(table).

So for LoongArch, if the relocation type is PC relative, it can use a
statement "reloc_offset(reloc) - reloc_offset(table)" to get the "PC"
value when calculating the symbol offset with "S + A - PC" for one or
many jump tables in the rodata.

Add an arch-specific function arch_jump_table_sym_offset() to assign
the symbol offset, for the most part that is an absolute relocation,
the default value is "reloc->sym->offset + reloc_addend(reloc)" in
the weak definition, it can be overridden by each architecture that
has different requirements.

Link: https://github.com/loongson/la-abi-specs/blob/release/laelf.adoc
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/decode.c           | 17 +++++++++++++----
 tools/objtool/arch/loongarch/include/arch/elf.h |  7 +++++++
 tools/objtool/check.c                           |  7 ++++++-
 tools/objtool/include/objtool/arch.h            |  1 +
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index b64205b89f6b..02e490555966 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -5,10 +5,7 @@
 #include <asm/inst.h>
 #include <asm/orc_types.h>
 #include <linux/objtool_types.h>
-
-#ifndef EM_LOONGARCH
-#define EM_LOONGARCH	258
-#endif
+#include <arch/elf.h>
 
 int arch_ftrace_match(char *name)
 {
@@ -374,3 +371,15 @@ unsigned int arch_reloc_size(struct reloc *reloc)
 		return 8;
 	}
 }
+
+unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table)
+{
+	switch (reloc_type(reloc)) {
+	case R_LARCH_32_PCREL:
+	case R_LARCH_64_PCREL:
+		return reloc->sym->offset + reloc_addend(reloc) -
+		       (reloc_offset(reloc) - reloc_offset(table));
+	default:
+		return reloc->sym->offset + reloc_addend(reloc);
+	}
+}
diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
index 9623d663220e..ec79062c9554 100644
--- a/tools/objtool/arch/loongarch/include/arch/elf.h
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -18,6 +18,13 @@
 #ifndef R_LARCH_32_PCREL
 #define R_LARCH_32_PCREL	99
 #endif
+#ifndef R_LARCH_64_PCREL
+#define R_LARCH_64_PCREL	109
+#endif
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH		258
+#endif
 
 #define R_NONE			R_LARCH_NONE
 #define R_ABS32			R_LARCH_32
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d8668ae0f599..cff7416b207e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1943,6 +1943,11 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
+__weak unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table)
+{
+	return reloc->sym->offset + reloc_addend(reloc);
+}
+
 static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			  struct reloc *next_table)
 {
@@ -1971,7 +1976,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (prev_offset && reloc_offset(reloc) != prev_offset + arch_reloc_size(reloc))
 			break;
 
-		sym_offset = reloc->sym->offset + reloc_addend(reloc);
+		sym_offset = arch_jump_table_sym_offset(reloc, table);
 
 		/* Detect function pointers from contiguous objects: */
 		if (reloc->sym->sec == pfunc->sec && sym_offset == pfunc->offset)
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 396f7c6c81c0..089a1acc48a8 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -98,5 +98,6 @@ int arch_rewrite_retpolines(struct objtool_file *file);
 bool arch_pc_relative_reloc(struct reloc *reloc);
 
 unsigned int arch_reloc_size(struct reloc *reloc);
+unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *table);
 
 #endif /* _ARCH_H */
-- 
2.42.0

