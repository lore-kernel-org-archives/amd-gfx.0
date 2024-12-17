Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79F8E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 11:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C7A10E938;
	Tue, 17 Dec 2024 11:26:36 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4BD8510E82D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 01:17:35 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8Cx7642z2BnFZdXAA--.1146S3;
 Tue, 17 Dec 2024 09:09:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowMDxPEcyz2BnXNeFAA--.16436S4;
 Tue, 17 Dec 2024 09:09:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/9] objtool: Handle different entry size of rodata
Date: Tue, 17 Dec 2024 09:08:58 +0800
Message-ID: <20241217010905.13054-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241217010905.13054-1-yangtiezhu@loongson.cn>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPEcyz2BnXNeFAA--.16436S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw4DWw1DJrW3AFy8AFy7Jwc_yoW5KFyUpF
 srA3yfGr1jgryfJwnxt3W8Wa98Gas7WryIgFZrtry8ZrW7XrnxJr4IvFy5tF10vw4FgayS
 gFsYgF1UJF4qywcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
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

In the most cases, the entry size of rodata is 8 bytes because the
relocation type is 64 bit. There are also 32 bit relocation types,
the entry size of rodata should be 4 bytes in this case.

Add an arch-specific function arch_reloc_size() to assign the entry
size of rodata for x86, powerpc and LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/decode.c | 11 +++++++++++
 tools/objtool/arch/powerpc/decode.c   | 15 +++++++++++++++
 tools/objtool/arch/x86/decode.c       | 13 +++++++++++++
 tools/objtool/check.c                 |  2 +-
 tools/objtool/include/objtool/arch.h  |  2 ++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index 69b66994f2a1..b64205b89f6b 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -363,3 +363,14 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->cfa.base = CFI_SP;
 	state->cfa.offset = 0;
 }
+
+unsigned int arch_reloc_size(struct reloc *reloc)
+{
+	switch (reloc_type(reloc)) {
+	case R_LARCH_32:
+	case R_LARCH_32_PCREL:
+		return 4;
+	default:
+		return 8;
+	}
+}
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc/decode.c
index 53b55690f320..3c95dd74fca0 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -106,3 +106,18 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->regs[CFI_RA].base = CFI_CFA;
 	state->regs[CFI_RA].offset = 0;
 }
+
+unsigned int arch_reloc_size(struct reloc *reloc)
+{
+	switch (reloc_type(reloc)) {
+	case R_PPC_REL32:
+	case R_PPC64_REL32:
+	case R_PPC_ADDR32:
+	case R_PPC_UADDR32:
+	case R_PPC_PLT32:
+	case R_PPC_PLTREL32:
+		return 4;
+	default:
+		return 8;
+	}
+}
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index fe1362c34564..fb9691a34d92 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -852,3 +852,16 @@ bool arch_is_embedded_insn(struct symbol *sym)
 	return !strcmp(sym->name, "retbleed_return_thunk") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
+
+unsigned int arch_reloc_size(struct reloc *reloc)
+{
+	switch (reloc_type(reloc)) {
+	case R_X86_64_32:
+	case R_X86_64_32S:
+	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
+		return 4;
+	default:
+		return 8;
+	}
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f64435ad3514..d8668ae0f599 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1968,7 +1968,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			break;
 
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
+		if (prev_offset && reloc_offset(reloc) != prev_offset + arch_reloc_size(reloc))
 			break;
 
 		sym_offset = reloc->sym->offset + reloc_addend(reloc);
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index d63b46a19f39..396f7c6c81c0 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -97,4 +97,6 @@ int arch_rewrite_retpolines(struct objtool_file *file);
 
 bool arch_pc_relative_reloc(struct reloc *reloc);
 
+unsigned int arch_reloc_size(struct reloc *reloc);
+
 #endif /* _ARCH_H */
-- 
2.42.0

