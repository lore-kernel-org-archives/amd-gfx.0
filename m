Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D92DC48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B9761375
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B9761375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A818D6E529;
	Wed,  9 Jun 2021 10:44:32 +0000 (UTC)
X-Greylist: delayed 312 seconds by postgrey-1.36 at gabe;
 Wed, 09 Jun 2021 10:44:31 UTC
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563FB6E529
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 10:44:31 +0000 (UTC)
Received: from mail-02.mail-europe.com (mail-0201.mail-europe.com
 [51.77.79.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4G0Nrp0f9Hz4xMPX;
 Wed,  9 Jun 2021 10:39:22 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="qoM1SvR1"
Date: Wed, 09 Jun 2021 10:39:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623235156;
 bh=LjUJ5eqlBd2mywiTIMnBvU4gY15eyVm9VKwLqlUHyDs=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=qoM1SvR1chY4aMoFXIu5gvOcCT9TvqHrBYg859V4Xi+ALpzg3EAU0YglQq6bqkF8C
 Uhq9ieBotf95IbFp6Gg5D5JzF089FFOd40jkE3uI7fNXMFC4pxSeXlHe+iFMB1DPW3
 W+MvTIsGmkdfsCmYI5Jq7XPNuIEmPC+mVrMAsz/EnXnj791wlQgsGHuGUklkyUHnrG
 Hh27/BJX6wOTf9+Nk3PzdvzVOLMY5ySucHlz9GBrLpABDI8/3Mup2f7/ysEtdDfcX2
 VdCu1MS7IvXETlU5VpaS5gerzpebKxyVG5UDshb+DWRCqeTHD7snxQJR2BFp3tX0dY
 Kaq5Ccfi2qy+Q==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 0/4] drm: add per-connector hotplug events
Message-ID: <H6LOTVFhdBPSi5N5zQIYRvkif2VhbZgfDIyWTvdSrY@cp3-web-051.plabs.ch>
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: pekka.paalanen@collabora.com, michel@daenzer.net, daniel@fooishbar.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When a uevent only updates a single connector, add a CONNECTOR property
to the uevent. This allows user-space to ignore other connectors when
handling the uevent. This is purely an optimization, drivers can still
send a uevent without the CONNECTOR property.

The CONNECTOR property is already set when sending HDCP property update
uevents, see drm_sysfs_connector_status_event.

This has been tested with a wlroots patch [1].

amdgpu has been updated to use these new fine-grained uevents.

[1]: https://github.com/swaywm/wlroots/pull/2959

Simon Ser (4):
  drm/sysfs: introduce drm_sysfs_connector_hotplug_event
  drm/probe-helper: add drm_kms_helper_connector_hotplug_event
  drm/connector: use drm_sysfs_connector_hotplug_event
  amdgpu: use drm_kms_helper_connector_hotplug_event

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +++---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  4 +--
 drivers/gpu/drm/drm_connector.c               |  2 +-
 drivers/gpu/drm/drm_probe_helper.c            | 20 +++++++++++++++
 drivers/gpu/drm/drm_sysfs.c                   | 25 +++++++++++++++++++
 include/drm/drm_probe_helper.h                |  1 +
 include/drm/drm_sysfs.h                       |  1 +
 7 files changed, 54 insertions(+), 7 deletions(-)

-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
