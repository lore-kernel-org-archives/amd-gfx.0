Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7ABC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Jul 2022 08:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8732310F75E;
	Sat,  9 Jul 2022 08:03:05 +0000 (UTC)
X-Greylist: delayed 390 seconds by postgrey-1.36 at gabe;
 Sat, 09 Jul 2022 02:38:15 UTC
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C9610E47F
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Jul 2022 02:38:15 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mx.kolabnow.com (Postfix) with ESMTP id 0CD171AE2
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Jul 2022 04:31:43 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from:received:received:received; s=
 dkim20160331; t=1657333902; x=1659148303; bh=VJ6yiy8i99arnaulci+
 5ayLbaDa3keFl6W1FqsvCIDs=; b=vuYMRAgWHEW8+E8Zgk/hjN0ep+wBv8AUreX
 T1r9mOkjsEHo5voH7aK4HyKscFD7J1W4/iio3BdEoLr5NqjTed4GzFga0dooQ1iZ
 UhaS7VOlESaYeCzbLxK04MjdFVKRNrLmJu883ZKk0O5RagBr3ozdOJm/dW/6kvon
 h469PqRQSRQcmveFvhDBaBxy0qlsQr3h5jPrren1iHzo1jgYu8eLAWLzFGPX0mu7
 +P76kuErxuczklvG8bXVF7oKZmJuUfYZ3yMdPpLzavVhjaS4IW7Xxf8rla6HGNIc
 /Q472h1gA2s3B/VP2u1JuR/ydUU/ntKt4UWOBd+9KvIrPOffmzcqbxVCXdIHjR3I
 woCn4PomQfm+59EAAXN2/nr9Y08GDE7lwytrHNfo7lEZ+/Xrb06ypyGJMPAe/ByT
 BTAN1W6tUeA5xRmpZvg/Y092hicVmmuXNwIUFbQ7qHDALp1tv7eXb6nNSyLyxgpD
 hUDjJxUbyRS+uPwA5ZRiuCVQOUGnA1i8FDPMkzhQbEnLx+wNXTWYE7H0NawsEUvE
 m+OMnLVFZJu36YMfgY9Mx9qZxQhzlGkH+KWe2cUe/akTKOQYKSLIuCj2zcXZ5mNE
 1q/5lAouuh0hFYYuhJzeIYARPQn8kTt4b5x/arWvoGSUdcW+acZmV1lbmk508pPn
 1I7+uvKM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rUqpR1ppK7fm for <amd-gfx@lists.freedesktop.org>;
 Sat,  9 Jul 2022 04:31:42 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
 by mx.kolabnow.com (Postfix) with ESMTPS id C1B6E13BC
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Jul 2022 04:31:41 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
 by int-mx001.mykolab.com (Postfix) with ESMTPS id 2CD4D8ACF;
 Sat,  9 Jul 2022 04:31:41 +0200 (CEST)
From: "Mr. B34r" <mr.b34r@kolabnow.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Prevent divide by zero
Date: Fri,  8 Jul 2022 18:31:25 -0800
Message-Id: <20220709023125.75039-1-mr.b34r@kolabnow.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Jul 2022 08:03:04 +0000
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
Cc: Vannoonnoo <mr.b34r@kolabnow.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vannoonnoo <mr.b34r@kolabnow.com>

divide error: 0000 [#1] SMP PTI
CPU: 3 PID: 78925 Comm: tee Not tainted 5.15.50-1-lts #1 5c320a339f0e397222fdfc9449eff04c0b12ea83
Hardware name: MSI MS-7A59/Z270 SLI PLUS (MS-7A59), BIOS 1.90 01/30/2018
RIP: 0010:smu_v11_0_set_fan_speed_rpm+0x11/0x110 [amdgpu]

Speed is user-configurable through a file. I accidentally set it to zero, and the driver crashed.

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

