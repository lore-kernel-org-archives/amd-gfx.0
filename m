Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93982C02185
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 14:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3670710E31C;
	Tue, 14 Jan 2025 14:05:07 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9B57E10E2B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 13:30:19 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8BxTKzpZoZnzTxjAA--.9103S3;
 Tue, 14 Jan 2025 21:30:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowMCx2sToZoZn2SUiAA--.8565S2;
 Tue, 14 Jan 2025 21:30:16 +0800 (CST)
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
Subject: [PATCH v4 2/3] drm/amd/display: Add SPL_ASSERT_BUG() macro definition
Date: Tue, 14 Jan 2025 21:30:15 +0800
Message-ID: <20250114133015.20002-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250114132856.19463-1-yangtiezhu@loongson.cn>
References: <20250114132856.19463-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx2sToZoZn2SUiAA--.8565S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryfurWUKw13Kw43XFW8GrX_yoW8GFWkpw
 1kWrn8uwn8Ja17K343JF18CFW3Z397JFW7X3sIv390v3W8uan3Z343JF4ftrWxWFWSka4r
 J3Z8WrW2qFsFyrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
 XwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
 xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU25fHUUUUU
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

In order to keep the current ability for the aim of debugging and avoid
printing the warning message twice, add SPL_ASSERT_BUG() macro definition
to harden the callers of division functions.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h b/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
index a6f6132df241..d31988c647e5 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
@@ -11,18 +11,29 @@
 		kgdb_breakpoint(); \
 	} \
 } while (0)
+#define SPL_ASSERT_EMERGENCY(expr) do {	\
+	if (!(expr)) { \
+		kgdb_breakpoint(); \
+		BUG(); \
+	} \
+} while (0)
 #else
 #define SPL_ASSERT_CRITICAL(expr) do {	\
 	if (WARN_ON(!(expr))) { \
 		; \
 	} \
 } while (0)
+#define SPL_ASSERT_EMERGENCY(expr) do {	\
+	BUG_ON(!(expr)); \
+} while (0)
 #endif /* CONFIG_HAVE_KGDB || CONFIG_KGDB */
 
 #if defined(CONFIG_DEBUG_KERNEL_DC)
 #define SPL_ASSERT(expr) SPL_ASSERT_CRITICAL(expr)
+#define SPL_ASSERT_BUG(expr) SPL_ASSERT_EMERGENCY(expr)
 #else
 #define SPL_ASSERT(expr) WARN_ON(!(expr))
+#define SPL_ASSERT_BUG(expr) BUG_ON(!(expr))
 #endif /* CONFIG_DEBUG_KERNEL_DC */
 
 #define SPL_BREAK_TO_DEBUGGER() SPL_ASSERT(0)
-- 
2.42.0

