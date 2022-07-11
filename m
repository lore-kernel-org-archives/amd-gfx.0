Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BCECCA47B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 01:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E759A92DD3;
	Tue, 12 Jul 2022 01:06:34 +0000 (UTC)
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E949281D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 22:35:16 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mx.kolabnow.com (Postfix) with ESMTP id D8F2B41945;
 Tue, 12 Jul 2022 00:35:13 +0200 (CEST)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
 message-id:references:in-reply-to:subject:subject:from:from:date
 :date:content-transfer-encoding:content-type:content-type
 :mime-version:received:received:received; s=dkim20160331; t=
 1657578913; x=1659393314; bh=eZR9x3aS9DWJ1nxj7rQJ1dUuePxk57tQ+p6
 jn6NRlk0=; b=RGDPll3iIKjPNwPQAoa5oOqRKgWQvZIu7jI4OIaxqmDNjtvYHno
 tPjro9KSQv4NoaohRTzbsf8zENEFmyrt+eAqs13sz2Og2liJYF2BTK6woY4zcgX5
 rfmG2pBAiq/iwp4lJI8+vXpfb2ZT37QzP0nMGwcH2EC4XYBcadKuz96RI3kCp9Jw
 ug4gCGgu0pm/caigFOSHyomPKE6O8lYn63il0MQG1MM7/hXRkUsUMYG8AuXkG91Y
 wHc3mxWXGcn5MUtejPH32vR9onnMFQrRVDHOVbd3WPo3ikK0GoGJuoGrZzoMWD4h
 S8znBTjt0X6blELMRUZvLPCvAHPp4HCH0y4t+I7YalbklxPbu8fbruLFLikRYvwf
 QDVKg7rmnnYPQl6Lxmdc22Oq9JS7mJlcGc6ygfm9L5p0eymofJ6yheO9jpWZw4xA
 HEavgrAVdHbwiBYWw2Ei4tYtLQSz6UeLQFTeEjH4lC7H9ipGjPP2bSMT13u1muKI
 KhNBhQp7teFynowzs5gk6fPgo57jBRyDQSQyvPcm1f26ulT/DEjYAf5MPFAGE9/T
 BGQu2Lg65jhJVISu85KGA8K0eGNWS7yKMujPgvYrEYY+oTpt9bf1uAVQ3b6SY8cf
 CRTabGHRumJ+fHAnpFTI1HNjza+EFd6KfUYExsw0RvPkWzqoFapjEoZE=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ak4vt4zTfD7T; Tue, 12 Jul 2022 00:35:13 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by mx.kolabnow.com (Postfix) with ESMTPS id D204540E50;
 Tue, 12 Jul 2022 00:35:12 +0200 (CEST)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id 81DAC6461;
 Tue, 12 Jul 2022 00:35:12 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Jul 2022 14:35:11 -0800
From: "Mr. B34r" <mr.b34r@kolabnow.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Prevent divide by zero
In-Reply-To: <5fe781cf-8731-1e1c-3c2c-b8957770276c@gmail.com>
References: <20220709023125.75039-1-mr.b34r@kolabnow.com>
 <5fe781cf-8731-1e1c-3c2c-b8957770276c@gmail.com>
Message-ID: <cd39e86c11dda19046388ca62bed3e3b@kolabnow.com>
X-Mailman-Approved-At: Tue, 12 Jul 2022 01:06:33 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 From: Yefim Barashkin <mr.b34r@kolabnow.com>

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

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5f8809f6990d..69cebdb58c04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1236,6 +1236,10 @@ int smu_v11_0_set_fan_speed_rpm(struct 
smu_context *smu,
      * - For some Sienna Cichlid SKU, the fan speed cannot be set
      *   lower than 500 RPM.
      */
+
+   if (speed == 0)
+       return -EINVAL;
+
     tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
     WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
              REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
--
2.36.1
