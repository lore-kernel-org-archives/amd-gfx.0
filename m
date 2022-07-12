Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13352C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 02:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8306093131;
	Tue, 12 Jul 2022 02:16:26 +0000 (UTC)
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CFE14A32A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 02:01:40 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mx.kolabnow.com (Postfix) with ESMTP id 53BE742C4A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 04:01:31 +0200 (CEST)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from:received:received:received; s=
 dkim20160331; t=1657591291; x=1659405692; bh=9373dOjQFwyAO8ZIVpX
 ypZ1TXvmp4AjO3xpGDve+CJk=; b=2bf4bcMCia6qBl0X8tQgubb0JmEuo/e3Gib
 HRCMhhMPKdc0H01f4eP+w8hdJTrDBoOAzZiPfgZXrP0A0A7/OusIxbiSQJl+u2IX
 +yUOOM9tGDBot/2q2Z3qnyXAL7N8pLk60Kg0s8Pdhely6/l50jgE/b8SfP+WhEd3
 BQ++7V/Oc0nLo9ix3MPYrRBA/RzOBHzqFkv/5vbBVJ+NZvUMxPXpGv65WCqnbPaR
 ZFERScCnJ0AZdd2JfWLCUaOUSedy3/nUUOa946SlMvovQ2ncqq9xuzL7PjWoB+Wv
 e0H9wLRq2B0jk8/ipJ8MXgWUyZf2RR/t+scNriHF27+vf0faVHFYW+0bLwI2+yLl
 a75UwlNdSAZ7JPtXfLn+DMh6TkT4+1OriDyCFrfn9ZRp7+fZdPilYErYwWRWAGAi
 5CrzDAYzJe8mstosyaoXCKkk2+A+CIJeOesWzlz4Jqsure2rszNWCBKr56xdKZ+h
 itlzW3OFXAyXwRLxsNdPYaUFGoXclY4PQ7krTwrD0nx/PBlp3kdbWX7Q/NdA+CUF
 bSLPlzANuN0oX5ulcpTEUe7b5ei9Whjuo/odl8FUGXGbUzL/+gKBuHzyqzxhZ8bi
 xLw/G4siMIiR5a1S6/t1wlAsr3LEBWloy05wvxix2p6D2FA9HFxsavVVyhfLvzZY
 u7eP5064=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1StCxet8_Pey for <amd-gfx@lists.freedesktop.org>;
 Tue, 12 Jul 2022 04:01:31 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
 by mx.kolabnow.com (Postfix) with ESMTPS id 0E367421DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 04:01:20 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx001.mykolab.com (Postfix) with ESMTPS id 537EAFD8B;
 Tue, 12 Jul 2022 04:01:20 +0200 (CEST)
From: Yefim Barashkin <mr.b34r@kolabnow.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Prevent divide by zero
Date: Mon, 11 Jul 2022 18:01:06 -0800
Message-Id: <20220712020106.46730-1-mr.b34r@kolabnow.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Jul 2022 02:16:25 +0000
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
Cc: Yefim Barashkin <mr.b34r@kolabnow.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

divide error: 0000 [#1] SMP PTI
CPU: 3 PID: 78925 Comm: tee Not tainted 5.15.50-1-lts #1
Hardware name: MSI MS-7A59/Z270 SLI PLUS (MS-7A59), BIOS 1.90 01/30/2018
RIP: 0010:smu_v11_0_set_fan_speed_rpm+0x11/0x110 [amdgpu]

Speed is user-configurable through a file.
I accidentally set it to zero, and the driver crashed.

Signed-off-by: Yefim Barashkin <mr.b34r@kolabnow.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5f8809f6990d..69cebdb58c04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1236,6 +1236,10 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	 * - For some Sienna Cichlid SKU, the fan speed cannot be set
 	 *   lower than 500 RPM.
 	 */
+
+	if (speed == 0)
+		return -EINVAL;
+
 	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
 	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
 		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
--
2.36.1

Sorry about the mess with my name and formatting. It should be fixed now, hopefully.
