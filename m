Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959D5C49EA6
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 11:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD846124C
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 11:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD846124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49A46EAC1;
	Thu, 24 Jun 2021 11:20:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BAF6EABE;
 Thu, 24 Jun 2021 11:20:24 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40412613C5;
 Thu, 24 Jun 2021 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624533624;
 bh=yeBxxI9RxIG1SBqoCQkOp8CWXVUmYQbT3KrhCdThdUQ=;
 h=Date:From:To:cc:Subject:From;
 b=h/uUXhqyme6NlwDRYS288PXCjbfgX3cO68nvhdbShTtcWiUCCFVN/lpxUTNwaT6Ng
 Co+4182vvnP77I/IlfJZ6NjSZ2eamUoa3E8ymWMJ48XG5VzmPhppOlNSO3U5daWq6/
 cmNoJp5UixUE4C1nhdTB1Li4yaf67syfRxE1fz1gUPjDR3tybyc7VTn1AHiEbpdad5
 Ca1ArlpbK875RpjhW+HaDyzuVVpUT9Pe9bFEF9DLGjGvPgx8xF67PrwNXJ1cq1GKgs
 ViBHsz8iDe1bOUepqReha5pnu8MO5nQ7IL8uAeGYK9SJjMmq5vQEPMV1tAwiqyBpvB
 fDDhfVaY6xwmw==
Date: Thu, 24 Jun 2021 13:20:21 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@linux.ie>
Subject: [PATCH] drm/amdgpu: Fix resource leak on probe error path
Message-ID: <nycvar.YFH.7.76.2106241319430.18969@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
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
Cc: Vojtech Pavlik <vojtech@ucw.cz>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiri Kosina <jkosina@suse.cz>

This reverts commit 4192f7b5768912ceda82be2f83c87ea7181f9980.

It is not true (as stated in the reverted commit changelog) that we never 
unmap the BAR on failure; it actually does happen properly on 
amdgpu_driver_load_kms() -> amdgpu_driver_unload_kms() -> 
amdgpu_device_fini() error path.

What's worse, this commit actually completely breaks resource freeing on 
probe failure (like e.g. failure to load microcode), as 
amdgpu_driver_unload_kms() notices adev->rmmio being NULL and bails too 
early, leaving all the resources that'd normally be freed in 
amdgpu_acpi_fini() and amdgpu_device_fini() still hanging around, leading 
to all sorts of oopses when someone tries to, for example, access the 
sysfs and procfs resources which are still around while the driver is 
gone.

Fixes: 4192f7b57689 ("drm/amdgpu: unmap register bar on device init failure")
Reported-by: Vojtech Pavlik <vojtech@ucw.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57ec108b5972..0f1c0e17a587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3414,13 +3414,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
-		goto failed_unmap;
+		return r;
 	}
 
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
-		goto failed_unmap;
+		return r;
 
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
@@ -3646,10 +3646,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
-failed_unmap:
-	iounmap(adev->rmmio);
-	adev->rmmio = NULL;
-
 	return r;
 }
 
-- 
2.12.3


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
