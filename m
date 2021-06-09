Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D6AC48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0986139A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0986139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 299266E406;
	Wed,  9 Jun 2021 21:23:27 +0000 (UTC)
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19996E406;
 Wed,  9 Jun 2021 21:23:25 +0000 (UTC)
Date: Wed, 09 Jun 2021 21:23:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623273803;
 bh=O59p1XnGFmzprEBJ1OBmXfghWF/+Fzjmwvd7LymMVa0=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=nQdklizb32UffrfpcVdBwM+QM0V9W/Oq6YVf2bfljWBA3cJG33B9HwI10ATflH+wM
 lsS39ryKHSMQeVAAHi9VoV4OsYjlqdsUXMw5tEcvT8w9NPAlgWQ7IKiYXD+n+cpOs6
 /ixJcT9tZzBLPcivL+C58UVjLFeaoAefEzYbkixOjc0AfCeXpLNUsf4kCp1ZS9qXIv
 9ZccMkydHhriMR7s5kFVqtvHDf/4EQPnnfJwhC4Ct7uVvPlzr56ReMxoEwGeRd2N2O
 KdH/DtCGCYpQ8bA6mhgpwRg4aWKHXJin64RiAFgFeqSy2hwUceMP6avtKNNVHsbuGT
 64lkURxsdqETQ==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v2 0/7] drm: add per-connector hotplug events
Message-ID: <s5D1m6hjidKxuxaN6qpewqhxco48P4poVuMf1zi4qA@cp3-web-012.plabs.ch>
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
 daniel@ffwll.ch, alexander.deucher@amd.com, harry.wentland@amd.com,
 intel-gfx@lists.freedesktop.org
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

amdgpu and the probe-helper has been updated to use these new fine-grained
uevents.

[1]: https://github.com/swaywm/wlroots/pull/2959

Simon Ser (7):
  drm/sysfs: introduce drm_sysfs_connector_hotplug_event
  drm/probe-helper: add drm_kms_helper_connector_hotplug_event
  drm/connector: use drm_sysfs_connector_hotplug_event
  amdgpu: use drm_kms_helper_connector_hotplug_event
  drm/probe-helper: use drm_kms_helper_connector_hotplug_event
  i915/display/dp: send a more fine-grained link-status uevent
  drm/connector: add ref to drm_connector_get in iter docs

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  4 +-
 drivers/gpu/drm/drm_connector.c               |  2 +-
 drivers/gpu/drm/drm_probe_helper.c            | 42 +++++++++++++++++--
 drivers/gpu/drm/drm_sysfs.c                   | 25 +++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c       |  2 +
 include/drm/drm_connector.h                   |  5 +++
 include/drm/drm_probe_helper.h                |  1 +
 include/drm/drm_sysfs.h                       |  1 +
 9 files changed, 79 insertions(+), 11 deletions(-)

-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
