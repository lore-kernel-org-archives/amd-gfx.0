Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61643C2D0D3
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D422465E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z5V5ALxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D422465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBAD6EC36;
	Fri, 20 Dec 2019 14:30:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F3176EC36;
 Fri, 20 Dec 2019 14:30:06 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3EB692465E;
 Fri, 20 Dec 2019 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576852206;
 bh=sHjZ0qd5CcSPOObcmrHAKFInCpvRbkdMC8s7KO+CHkk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=z5V5ALxhRGdU5APeRX2NEJSWEaMnZHnXmrNURuFnS0YH9zPxr16ZLW7Fe3zysD5wn
 wZDmwV5aixgI3p1WtNUykJbSUDLPhM0zLVMJ93CK7p3OAFI0VNecA7cNGi+ycQdVXZ
 e5qVDMbQ/p4u7cPHdYg5fiSz6JGDZ4qOSrMAOgek=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/52] drm/amd/display: Fixed kernel panic when
 booting with DP-to-HDMI dongle
Date: Fri, 20 Dec 2019 09:29:10 -0500
Message-Id: <20191220142954.9500-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, David Galiffi <David.Galiffi@amd.com>,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[ Upstream commit a51d9f8fe756beac51ce26ef54195da00a260d13 ]

[Why]
In dc_link_is_dp_sink_present, if dal_ddc_open fails, then
dal_gpio_destroy_ddc is called, destroying pin_data and pin_clock. They
are created only on dc_construct, and next aux access will cause a panic.

[How]
Instead of calling dal_gpio_destroy_ddc, call dal_ddc_close.

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ca20b150afcc2..6cb91a8eb2e0c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -373,7 +373,7 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 
 	if (GPIO_RESULT_OK != dal_ddc_open(
 		ddc, GPIO_MODE_INPUT, GPIO_DDC_CONFIG_TYPE_MODE_I2C)) {
-		dal_gpio_destroy_ddc(&ddc);
+		dal_ddc_close(ddc);
 
 		return present;
 	}
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
