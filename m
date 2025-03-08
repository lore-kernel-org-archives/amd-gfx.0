Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E881C282EC
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Mar 2025 14:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1E810E11C;
	Sat,  8 Mar 2025 14:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Gpp1sjSx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB6710E11C
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Mar 2025 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VlclST51KS5onWqpqx1/hgzM9UAUyL0Oni1lz2ll1Qo=; b=Gpp1sjSxIdCvhIxk7O1grYW4lL
 9CMMH5WJs9NDqX0r1B05qE4XZOcCYGEsFK3OVYrBnj9rgUTkSPwkjD9kLBbiXxZuwP3ZaqMjRVnY5
 j+VCkO36MdNmlLl6gA7OePBPBj2ITdGYPPEVUuJ4O7rZMrjxEUBQAvjJKqhulk/wbK5HTjIEswUS1
 2PFZBWygGaGOTDD928xuHhxWxEzwWwouHF0jQWXoa3wdnlq5xat5y9lNJZp8vi4v4i7ByjryKYplE
 /HuU8tY0YYOBzw2cq9WLQ6wEOcU11Ljc4fMjeYP5vKZbm6268g4B84WEYwMpK1v/FavQzexLXBDEe
 MXCCWh/g==;
Received: from [189.6.35.67] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tqv8c-005pIP-Th; Sat, 08 Mar 2025 15:26:57 +0100
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, mario.limonciello@amd.com, alex.hung@amd.com,
 siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [RFC PATCH 0/7] drm/amd/display: more DRM edid common-code to the
 display driver
Date: Sat,  8 Mar 2025 11:26:04 -0300
Message-ID: <20250308142650.35920-1-mwen@igalia.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I've been working on a new version of [1] that ports the AMD display
driver to use the common `drm_edid` code instead of open and raw edid
handling.

The part of the previous series that didn't make the cut was to replace
the open coded edid parser with `drm_edid_product_id` and `eld` data.
However, when addressing feedback I ran into a design issue in the
latest version because I was trying to not add any Linux-specific code
to the DC code, specifically, DC link detection. In short, we have a few
paths in the DM code that allocate a temporary `drm_edid`, go to the DC,
and back to the DM to handle `drm_edid` data. In the last version, I was
storing this temporary `drm_edid` in the aconnector, but it was
erroneously overriding a still in use `drm_edid`.

In this new version I allocate a temporary `drm_edid` in the DM parser
from raw edid data stored in `dc_edid`, which was actually extracted
from another `drm_edid` in the previous DM caller. This is a workaround
to bypass DC boundaries and parse edid capabilities, but I think we can
do better if we can find a clean way to pass the `drm_edid` through this
kind of DM -> DC -> DM paths.

I checked working on top of Thomas' work[2] that replaces `dc_edid` by
`drm_edid` and adds this DRM struct and its helpers inside DC. The
resulted changes work stable and as expected[3], but I believe that
adding linux-specific code to DC is not desirable.

Siqueira and I have discussed other alternatives, such as updating the
DC code to match `drm_edid` structs or checking how well the change in
this series could work with `drm_edid` as a private obj[4], however we
would like to know AMD team's opinion before making this big effort (and
probably noisy change). The main goal here is removing `drm_edid_raw`
calls and duplicated code to handle edid in DC/link_detection that can
take advantage of DRM common-code instead.

Please, let me know your thoughts.

Melissa

[1] https://lore.kernel.org/amd-gfx/20240918213845.158293-1-mario.limonciello@amd.com/
[2] https://lore.kernel.org/amd-gfx/20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net/
[3] https://gitlab.freedesktop.org/mwen/linux-amd/-/commits/drm_edid_product_id_v4
[4] https://gitlab.freedesktop.org/mwen/linux-amd/-/commits/drm_edid_priv

Melissa Wen (7):
  drm/amd/display: make sure drm_edid stored in aconnector doesn't leak
  drm/amd/display: start using drm_edid helpers to parse EDID caps
  drm/amd/display: use drm_edid_product_id for parsing EDID product info
  drm/amd/display: parse display name from drm_eld
  drm/amd/display: get panel id with drm_edid helper
  drm/amd/display: get SAD from drm_eld when parsing EDID caps
  drm/amd/display: get SADB from drm_eld when parsing EDID caps

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 85 +++++++++----------
 2 files changed, 42 insertions(+), 45 deletions(-)

-- 
2.47.2

