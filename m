Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4178E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 14:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733FE10E316;
	Tue, 14 Jan 2025 14:05:05 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id AB5BF10E2B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 13:30:51 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8Bx364JZ4ZnAD1jAA--.23578S3;
 Tue, 14 Jan 2025 21:30:49 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowMDxfccGZ4ZnEiYiAA--.3726S2;
 Tue, 14 Jan 2025 21:30:46 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] drm/amd/display: Harden callers of division functions
Date: Tue, 14 Jan 2025 21:30:35 +0800
Message-ID: <20250114133035.20178-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250114132856.19463-1-yangtiezhu@loongson.cn>
References: <20250114132856.19463-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxfccGZ4ZnEiYiAA--.3726S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWry8uF1ktw1UJFWUCFWUJrc_yoW5GF4fpa
 13GFyUXryDZFZ2yFZ7C3W7WFZxAa93JF4v9F43Cws5u347Zan8urZ3J3Z5Gr429rWIyF4a
 vFs8GrWjqF1vyrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
 XwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
 xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
 14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ceOJUUUUU==
X-Mailman-Approved-At: Tue, 14 Jan 2025 14:05:05 +0000
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

There are objtool warnings compiled with the latest mainline LLVM:

  dc_fixpt_recip() falls through to next function dc_fixpt_sinc()
  spl_fixpt_recip() falls through to next function spl_fixpt_sinc()

Here are the call paths:

  dc_fixpt_recip()
    dc_fixpt_from_fraction()
      complete_integer_division_u64()
        div64_u64_rem()

  spl_fixpt_recip()
    spl_fixpt_from_fraction()
      spl_complete_integer_division_u64()
        spl_div64_u64_rem()

This was introduced by a change in Clang from a few months:

  [SimplifyCFG] Deduce paths unreachable if they cause div/rem UB)
  https://github.com/llvm/llvm-project/commit/37932643abab

The current ASSERT() and SPL_ASSERT() do not do anything to prevent
the divide by zero and the rest of the code does not either, this
is the root cause.

The callers of division functions should be hardened against dividing
by zero to avoid undefined behavior, so use the new added ASSERT_BUG()
and SPL_ASSERT_BUG() to stop the control flow if the divisior is zero.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Xi Ruoyao <xry111@xry111.site>
Suggested-by: Rui Wang <wangrui@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/lkml/20241220223403.GA2605890@ax162/
---
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 88d3f9d7dd55..f78c6702bc42 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -51,7 +51,7 @@ static inline unsigned long long complete_integer_division_u64(
 {
 	unsigned long long result;
 
-	ASSERT(divisor);
+	ASSERT_BUG(divisor);
 
 	result = div64_u64_rem(dividend, divisor, remainder);
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
index 131f1e3949d3..b3e6840e4715 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
@@ -29,7 +29,7 @@ static inline unsigned long long spl_complete_integer_division_u64(
 {
 	unsigned long long result;
 
-	SPL_ASSERT(divisor);
+	SPL_ASSERT_BUG(divisor);
 
 	result = spl_div64_u64_rem(dividend, divisor, remainder);
 
-- 
2.42.0

