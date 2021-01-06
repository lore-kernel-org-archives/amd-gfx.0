Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E558C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 17:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A77622EBD
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 17:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A77622EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9099B89C52;
	Wed,  6 Jan 2021 17:08:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FF389C19
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 16:57:01 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A4AD23137;
 Wed,  6 Jan 2021 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1609952221;
 bh=WvzulPCfl4OvSPlT3PJkpE9WM+heraZbDKTzB0kCHgM=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=jcqz5jY55DFtsUMLD29xLz+MsKgj0Ncvf6NigrSNZaoXkCS5EgqfimKUE/G9VzXJE
 7iLIRJ6xolRghugWsHzxkyO7CaP9jU2k2MCRUCA7jLrxvxWAfKI/jNTl8f+krBqZBf
 ls5uipqCUd6xWH1Osdk3MlQjtZsk5ttm+F46gCaU=
Subject: Patch "Revert "drm/amd/display: Fix memory leaks in S3 resume"" has
 been added to the 5.4-stable tree
To: alexander.deucher@amd.com, alexdeucher@gmail.com,
 amd-gfx@lists.freedesktop.org, andre@tomt.net, gregkh@linuxfoundation.org,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com, oleksandr@natalenko.name,
 stylon.wang@amd.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 06 Jan 2021 17:58:05 +0100
In-Reply-To: <20210105164545.963036-1-alexander.deucher@amd.com>
Message-ID: <1609952285148253@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Wed, 06 Jan 2021 17:08:35 +0000
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
Cc: stable-commits@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


This is a note to let you know that I've just added the patch titled

    Revert "drm/amd/display: Fix memory leaks in S3 resume"

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-drm-amd-display-fix-memory-leaks-in-s3-resume.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From alexdeucher@gmail.com  Wed Jan  6 17:47:17 2021
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue,  5 Jan 2021 11:45:45 -0500
Subject: Revert "drm/amd/display: Fix memory leaks in S3 resume"
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Stylon Wang <stylon.wang@amd.com>, Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Andre Tomt <andre@tomt.net>, Oleksandr Natalenko <oleksandr@natalenko.name>, stable@vger.kernel.org
Message-ID: <20210105164545.963036-1-alexander.deucher@amd.com>

From: Alex Deucher <alexdeucher@gmail.com>

This reverts commit a135a1b4c4db1f3b8cbed9676a40ede39feb3362.

This leads to blank screens on some boards after replugging a
display.  Revert until we understand the root cause and can
fix both the leak and the blank screen after replug.

Cc: Stylon Wang <stylon.wang@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Andre Tomt <andre@tomt.net>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1434,8 +1434,7 @@ amdgpu_dm_update_connector_after_detect(
 
 			drm_connector_update_edid_property(connector,
 							   aconnector->edid);
-			aconnector->num_modes = drm_add_edid_modes(connector, aconnector->edid);
-			drm_connector_list_update(connector);
+			drm_add_edid_modes(connector, aconnector->edid);
 
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,


Patches currently in stable-queue which might be from alexdeucher@gmail.com are

queue-5.4/revert-drm-amd-display-fix-memory-leaks-in-s3-resume.patch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
