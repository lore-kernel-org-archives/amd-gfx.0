Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F9C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A467D20702
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canned-death.us header.i=@canned-death.us header.b="auoMC9Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A467D20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=canned-death.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443A189791;
	Mon,  9 Nov 2020 08:59:18 +0000 (UTC)
X-Greylist: delayed 308 seconds by postgrey-1.36 at gabe;
 Mon, 09 Nov 2020 06:04:58 UTC
Received: from metis.canned-death.us (metis.canned-death.us
 [IPv6:2604:180:f1::e7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76735893A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 06:04:58 +0000 (UTC)
Received: from theia.canned-death.us (metis.canned-death.us
 [IPv6:2604:180:f1::e7])
 by metis.canned-death.us (Postfix) with ESMTPSA id 2D1F1C0071;
 Sun,  8 Nov 2020 23:59:47 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canned-death.us;
 s=metis; t=1604901587; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:content-transfer-encoding:in-reply-to:
 references; bh=+DJUMlx20YneqOku7rjfBa/DCPfE9P0rZzAzITILXCE=;
 b=auoMC9LuzmKmKkqfkkreERJ0qNjyPZ3aT0Gq217+z7nruO1F5O+iJC3+FqL8Ef7TU6bkc8
 dN59mVhMG7agL15N2xnM4whxj3RVFUTPiviWSms4L8blAVYOC/+sOnNYGkpvMk77GxFjJO
 nt36nKhYOrXYwli6JuUO0d1FZHA7bZj8SFamirfpYH5WIGshYTwK2qmQHllRkDrj0mtFKO
 mj7PC6R5dCJ94OS49jEKlVpAO0g/Wk5RFBzxlbNcSU2A1eRDe7iYwhn0cNVfCf1akq8QOZ
 gDE9pUV3Z1PvbY91dpRS6iBLXNT+zWcs3Nw/zcZqV2TSfpH7Qaa+3ZGl9f2MEQ==
Date: Sun, 8 Nov 2020 23:59:42 -0600
From: Lee Starnes <lee@canned-death.us>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, stylon.wang@amd.com
Subject: [PATCH] drm/amdgpu: update connector num_modes
Message-ID: <20201109055942.GA23784@theia.canned-death.us>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=canned-death.us;
 s=metis; t=1604901589; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:content-transfer-encoding:in-reply-to:
 references; bh=+DJUMlx20YneqOku7rjfBa/DCPfE9P0rZzAzITILXCE=;
 b=7EmhOiGqF0R2KGeYO9z5Eupw61P8afut/3MSkZnwdkZwVzSuZQKu4WePo81phh315Z68dJ
 1OiXiqMfenzt/lioPOyTXn+OKltozOr+oTSFr59FvQL+S7yYBT/bbGfCMNdZOzft04nzf8
 gq3x5Rkw2DL3yyP0jINB1MqNSZ1jZmfY9MoKgVu+7+pvGdR/A53t8vz3dL97e/AEomE2p3
 TCb50+xUxYFJ9KF0LPgnXENycnghtiIQcepE/c0eNZTFsuVK52ZgwQLY/GcyR8SxPUBJEr
 unf0hofgeXKMwVSh7DVSaJZq2HcVy7W5YLMHFE8ltEZylQMRSJ/YUK7E+IxoKg==
ARC-Seal: i=1; s=metis; d=canned-death.us; t=1604901589; a=rsa-sha256; cv=none;
 b=tpaDbhHKlSEn0C5R464cHBVX1B/D/ntWi6ywOPSsVQXvaVpvR2ozYwcFGnXOc8Vt6KmS+57dyZ8NitCxcuLuBTM/JmVQh6m0vo5sob9Z/Utq6TiBhMlr89ABejeYMlAvCToB1gNL1sLW1K9lApycBxwVwxCKB8qMIF5ZH9x4avcF3NF/NxcxfBTdyvrGL36ExaBMtqd0sXTLH3A4RK5N3MzsvDB5GsDw83sviuuj5m/xAs1zaRykUpWg+GptxCQcRAJakbgRIf81pzed56zz+Y9izBS20xk2sFAj6To3QDZRnh7ZFCJcUXuA1xRED2tO3z4rpn7A4x+OUZxn3DpZfg==
ARC-Authentication-Results: i=1; metis.canned-death.us;
 auth=pass smtp.auth=lee smtp.mailfrom=lee@canned-death.us
Authentication-Results: metis.canned-death.us;
 auth=pass smtp.auth=lee smtp.mailfrom=lee@canned-death.us
X-Mailman-Approved-At: Mon, 09 Nov 2020 08:59:16 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdgpu_dm.c, amdgpu_dm_update_connector_after_detect calls
drm_add_edid_modes, but it doesn't update the struct
amdgpu_dm_connector's num_modes like other places that call
drm_add_edid_modes do, so drm_display_modes allocated by
drm_add_edid_modes will never get freed. This causes a memleak which was
reported as https://bugzilla.kernel.org/show_bug.cgi?id=209987. It's
severe enough that it caused my system to OOM and have to be rebooted
several times.

The commit that causes this was backported to 5.9 and 5.4.

Fixes: b24bdc37d03a ("drm/amd/display: Fix EDID parsing after resume from suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Starnes <lee@canned-death.us>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e93e18c06..06fe24a9d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2281,7 +2281,7 @@ void amdgpu_dm_update_connector_after_detect(
 
 			drm_connector_update_edid_property(connector,
 							   aconnector->edid);
-			drm_add_edid_modes(connector, aconnector->edid);
+			aconnector->num_modes = drm_add_edid_modes(connector, aconnector->edid);
 
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
