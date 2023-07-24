Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9363C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2622610E303;
	Mon, 24 Jul 2023 12:58:43 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F64F10E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 03:00:07 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R8Pz85mJwzBRYmS
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 11:00:04 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690167604; x=1692759605; bh=i+p/J1h3q36a6g/06IhJYB84+UE
 C0xOcZ6JZkjXA3Lo=; b=zyFTQMQq5GOQoYlTCR5I+7oPveMvveOovQtM7Rff+om
 DyXmsLei68gN9hJ2ptbkpEuZf7wAo++qV3ce3so4nWhPmhzR+Vd2w1G5Bs5Gp/p0
 3jQu4rPbGo/yUCwxf8ieknGFSGa84PR6zasPKHytbDDinRxtEodebFZj+sg+czyK
 pG8bLaxgAPixnl8hjXXU/JMVZzya3MKL+WFjx7pnY0rzzgoxhNyITGhWiDPNLcjQ
 QJvNHpBuyz0H0oVgkMky7easjRKEFYdOwdNPLkJpiLz93uyAHqEHstW9HIiTp/Wj
 7fxOyMhcK+3UQC9rTjtxckrYO4p6B/pzeZuR2DYQrHw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id dy7X2iykx3nY for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jul 2023 11:00:04 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R8Pz83VMpzBRDsQ;
 Mon, 24 Jul 2023 11:00:04 +0800 (CST)
MIME-Version: 1.0
Date: Mon, 24 Jul 2023 11:00:04 +0800
From: sunran001@208suo.com
To: airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com
Subject: [PATCH] drm/radeon: add missing spaces before ';'
In-Reply-To: <20230724025911.7528-1-xujianghui@cdjrlc.com>
References: <20230724025911.7528-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <6c16a6c089033849af90ad35fe86515a@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:33 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ERROR: space required after that ';' (ctx:BxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/radeon_vce.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vce.c 
b/drivers/gpu/drm/radeon/radeon_vce.c
index ca4a36464340..d1871af967d4 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -95,7 +95,7 @@ int radeon_vce_init(struct radeon_device *rdev)

  	size = rdev->vce_fw->size - strlen(fw_version) - 9;
  	c = rdev->vce_fw->data;
-	for (;size > 0; --size, ++c)
+	for (; size > 0; --size, ++c)
  		if (strncmp(c, fw_version, strlen(fw_version)) == 0)
  			break;

@@ -110,7 +110,7 @@ int radeon_vce_init(struct radeon_device *rdev)

  	size = rdev->vce_fw->size - strlen(fb_version) - 3;
  	c = rdev->vce_fw->data;
-	for (;size > 0; --size, ++c)
+	for (; size > 0; --size, ++c)
  		if (strncmp(c, fb_version, strlen(fb_version)) == 0)
  			break;
