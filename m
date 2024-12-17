Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AE6E7718C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 11:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B68510E92D;
	Tue, 17 Dec 2024 11:26:29 +0000 (UTC)
X-Greylist: delayed 444 seconds by postgrey-1.36 at gabe;
 Tue, 17 Dec 2024 01:16:35 UTC
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 27E5610E634
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 01:16:34 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8Cx7640z2BnCJdXAA--.1144S3;
 Tue, 17 Dec 2024 09:09:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowMDxPEcyz2BnXNeFAA--.16436S2;
 Tue, 17 Dec 2024 09:09:06 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Date: Tue, 17 Dec 2024 09:08:56 +0800
Message-ID: <20241217010905.13054-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPEcyz2BnXNeFAA--.16436S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur48Cr4DurW3Wr47KFWxuFX_yoW8ZrWfpF
 WUCrZ8Kr4rXr97J3srJ34YgFW3Jw4xWr1IqF13Gry5A3yUXw1UJr4fAayDtF1jg3yFgFyI
 qF4rWa1UGF4qyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=
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

This version is based on tip/tip.git objtool/core branch [1], add some weak
and arch-specific functions to make the generic code more readable, tested
with the latest upstream mainline Binutils, GCC and Clang.

The first 6 patches are preparation for patch #7 to enable jump table for
objtool on LoongArch, the last 2 patches are small enough to fix objtool
warnings "funcA() falls through to next function funcB()", one is under
arch/loongarch and the other is under drm/amd/display.

v6:
  -- Add arch_reloc_size() for x86 and ppc.
  -- Call arch_reloc_size() directly in add_jump_table().
  -- Refine arch_adjust_offset() for LoongArch.
  -- Rename arch_adjust_offset() to arch_jump_table_sym_offset(). 
  -- Get each table size of rodata in time for switch table.
  -- Update the commit message to make it more clear.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=objtool/core

Tiezhu Yang (9):
  objtool: Handle various symbol types of rodata
  objtool: Handle different entry size of rodata
  objtool: Handle PC relative relocation type
  objtool: Handle unreachable entry of rodata
  objtool/LoongArch: Add support for switch table
  objtool/LoongArch: Add support for goto table
  LoongArch: Enable jump table for objtool
  LoongArch: Convert unreachable() to BUG()
  drm/amd/display: Mark dc_fixpt_from_fraction() noinline

 arch/loongarch/Kconfig                        |   3 +
 arch/loongarch/Makefile                       |   6 +-
 arch/loongarch/kernel/machine_kexec.c         |   4 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   2 +-
 tools/objtool/arch/loongarch/decode.c         |  28 ++-
 .../objtool/arch/loongarch/include/arch/elf.h |   7 +
 tools/objtool/arch/loongarch/special.c        | 159 +++++++++++++++++-
 tools/objtool/arch/powerpc/decode.c           |  15 ++
 tools/objtool/arch/x86/decode.c               |  13 ++
 tools/objtool/check.c                         |  28 ++-
 tools/objtool/include/objtool/arch.h          |   3 +
 11 files changed, 251 insertions(+), 17 deletions(-)

-- 
2.42.0

