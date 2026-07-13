Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA78C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 07:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B5210E57E;
	Mon, 13 Jul 2026 07:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="VXP6N2/D";
	dkim-atps=neutral
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3C210E539
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 03:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783914256; bh=nRbRtd6EjC6Q9aDrOqRzPNz8a1z9mL4Jo3aID1frTFg=;
 h=From:To:Cc:Subject:Date;
 b=VXP6N2/DBVTDCGuw6RwAJOSZ6+SD1DhOXh1bCsYVhAaCKmefKBZbqrAfq1mcpNgun
 BJ/rvNOMUhNTrvZ8xxSQN5lVMBSpNUjnWSsDq6Ok4/hfPCsUCmj6ley3pRKp9u+ASz
 QUcWNqaF+I4FUlPZjM+tvE0rahj3K7TDNpGuk7RE=
Received: from localhost.localdomain ([116.128.244.169])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 31FB822D; Mon, 13 Jul 2026 11:12:31 +0800
X-QQ-mid: xmsmtpt1783912351t3x0q34hi
Message-ID: <tencent_E261113F418E454CE1ECFA60DB8BD5F38305@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeEHRYbnd/pCkieRJtFwR2zQsL3LmBrRy6L9G/L0++oGEhsEIBdE
 q5a/ZlkcbMJFlku7pI+l8p0Y/+crsioIxYWyBiv2AeFdhSp5f7u6admslJssjSmuzPh+lLEsHyVC
 tizqs24bThotFtP9a37jOIsL/DYcLqcAR9aUIMbb1OuQR79DpY/n9Q+HdQCgPXK91xJcHfyKZdrZ
 eOQZgsYY5zND3vf7V5GO0MZbifzKj45pIEy1KbdUAqy5tzwP7WZHSWE5l3dylwjkKk4YWBCLQyYJ
 oSXT3kyQNmW0PTZ5c2UuQZ58/geW/tD73azypxLUIcpzYLiy4stSD6GrxvJLDJ2ZUjI8ZcB18YqC
 GcYl3HnVMUsAqa/LEbyZIc4sQc7Xrq/VtofBLeOubQs3Brb8ZtZ34uqGC09p8UAVt5MDNwIP4SXV
 zFve4aPmzazHhZtnHTAAK8BYG3NQIwiO0AdY4/MSCo9/hMBfMAKGC0bRaqfFt8WUT/7kcNIx92ww
 Bj3OCDWiqBFEMRnToSsBHvS91aL2drV8VwrV5t9D5DijUr54JgH64yWiAH+tgam063zOOKLcoEXg
 E5q1trn9XuP8mrhqVmjhLAcye7n43nqQmC8elHDaW0jXfuEk+AS5Wg/ueGXbFoK7G7Yy3uMrRxCW
 4xFoRX8FnTXp5nl3cRDOTfbgtPM+dF5g4D1l2a5U6itK6WUxljNa4KES6d+W/Jehs4CIRvFlEKw1
 36P6UWP5wmbifO1keE85kq9JTWkKRKzuZ7LURmqoCqyKMILITSgPs02lVMjs5TnNVqsxUGNftEi+
 uJdAZIvhzb6ggwahPQyH3akSc5Ma8yBRqq9MntCdP5J/9fUQQI7NvVMCPYvVMkb97SWaw+rFvvRw
 foQeoA6q+CfyAVlSvXRureLVFzxvadzPnSz9/+/r7rVofhBXxu1qtLVOQkV4hpu8lmQk6zO/5Hsb
 kjo5DrM6SeBRErKSe9QF9sPmwoyW5deFcfrpQyEeg8gkRJpF6vf7OOZuApbKpYeXI8Soiv0YdBzw
 YdmxlYc6mlRM70rWn2TOnfdVygeUFMj3ApdfS9mw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: 2681643870@qq.com
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, oushixiong@kylinos.cn,
 yanglinlin <yanglinlin@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] drm/amd/display: fix __udivdi3 link error
Date: Mon, 13 Jul 2026 11:12:28 +0800
X-OQ-MSGID: <20260713031228.196070-1-2681643870@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:30:54 +0000
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

From: yanglinlin <yanglinlin@kylinos.cn>

When compiling the AMDGPU display driver for 32-bit architectures,
the linker reports undefined reference to `__udivdi3` in functions
get_dp_dto_frequency_100hz() and dcn401_get_dp_dto_frequency_100hz().

This is because the code uses 64-bit division (/) on 32-bit systems,
which GCC cannot handle directly and instead tries to call the missing
__udivdi3 helper function.

Replace the raw division with div_u64(), the kernel's standard 64-bit
division helper, to avoid the link error.

Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>
Reported-by: k2ci <kernel-bot@kylinos.cn>

---
v1 -> v2:
  Adjust overflow‑check condition: change INT_MAX to UINT_MAX and add 100ULL suffix,
  also reorganize calculation order to avoid potential integer overflow

 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 7c293917e6fd..ecb8493ec523 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1229,9 +1229,9 @@ static bool get_dp_dto_frequency_100hz(
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
 			if (modulo_hz) {
-				temp = div_u64((uint64_t)clock_hz * dp_dto_ref_khz * 10, modulo_hz);
-				ASSERT(temp / 100 <= 0xFFFFFFFFUL);
-				*pixel_clk_100hz = (unsigned int)(temp / 100);
+				temp = clock_hz * dp_dto_ref_khz * 10;
+				ASSERT(temp <= UINT_MAX * modulo_hz * 100ULL);
+				*pixel_clk_100hz = div_u64(temp, modulo_hz * 100);
 			} else
 				*pixel_clk_100hz = 0;
 		} else {
@@ -1285,13 +1285,12 @@ static bool dcn401_get_dp_dto_frequency_100hz(const struct clock_source *clock_s
 		 *     - target pix_clk_hz = (DPDTO INTEGER * DPDTO MODULO + DPDTO PHASE)
 		 */
 		temp = (unsigned long long)dp_dto_integer * modulo_hz + phase_hz;
-
-		if (temp / 100 > 0xFFFFFFFFUL) {
+		if (temp > (UINT_MAX * 100ULL)) {
 			/* pixel rate 100hz should never be this high, if it is, throw an assert and return 0  */
 			BREAK_TO_DEBUGGER();
 			*pixel_clk_100hz = 0;
 		} else {
-			*pixel_clk_100hz = (unsigned int)(temp / 100);
+			*pixel_clk_100hz = div_u64(temp, 100);
 		}
 
 		return true;
-- 
2.25.1

