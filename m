Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6B21062896
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 12:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C1F10E8E4;
	Wed, 11 Mar 2026 12:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Lw7H8qza";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF3910E0C6;
 Wed, 11 Mar 2026 11:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773228678; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JSArfLD4jgpSVHwjpj1Sn7tv/97+gfgMJD36dQ1Paqec7i1DSa9hSv5XE3u1VwN75ShpvCm6UcIke0s6YaAFkQbwcxVDndarq4Nkxo4muW9rwSN0DBNRUKqWT23ssZxsjJzMTWygItb0OgCZrYz5z3HBLngoio36xODXud8bAXE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773228678;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=50uzYTbpVvvXsT3rwXsdiRDmltOZSZR7FTmYv8Uef4w=; 
 b=Gy0KwnPMPYLjXHCTHDZiPpRiZpWBr2ILS1dV0eq342fbkqs639m3kIRIhatzjkYx2rHEGCbhm3VzBuHxodKNxPO4fpIClCArohPt1waVphurpNjfrHyC/+cRI4xN9qtY9OD/2eKZKW6f+rN00SJkgYtZ7080i+ywv3AwFkCTwhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773228678; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=50uzYTbpVvvXsT3rwXsdiRDmltOZSZR7FTmYv8Uef4w=;
 b=Lw7H8qza+fJPmUm+ui/UCbewHXUTzqRuGixOGL2QEfqtfA82/UMxsm5WvdDf4mKU
 98kIfB6ptyS+isbkHI+weMTGoNzTazzmiM7cJE7EwRFZM7Q3hy2DwwyU/3JZv0o72h0
 gMgimuE6QyMfKG6dGk6q5FAtR7xSgDsRZ4Hy/wR4=
Received: by mx.zohomail.com with SMTPS id 1773228676838358.78205415632567;
 Wed, 11 Mar 2026 04:31:16 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v4 0/2] Add "link bpc" DRM property
Date: Wed, 11 Mar 2026 12:30:54 +0100
Message-Id: <20260311-link-bpc-v4-0-51775e964720@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXOzQ6CMAzA8VchOzsc40Ph5HsYDmUb0rgx7ICYE
 N7dRfHU/NPml24sGEITWJNsjMyKAf0YozglTA0wPgxHHZtJISuRi5pbHJ+8mxTXAnpVXEpQRc3
 i+USmx/eXurexe/KOzwMZ+ANlJqTMKnkt8jS7lDXPuAPCJaSrBX1T3lroPEGqvDtEMq8l/jT/W
 NZBMDxuHc5Noin6OJ2Pydp9/wASfdygzwAAAA==
X-Change-ID: 20260309-link-bpc-d0afc475ac49
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, kernel@collabora.com, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 11 Mar 2026 12:54:53 +0000
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

I'm taking over this series from Marius Vlad.

The series adds a new "link bpc" DRM property. It reflects the display
link's actual achieved output bits per component, considering any
degradation of the bit depth done by drivers for bandwidth or other
reasons. The property's value is updated during an atomic commit, which
is also when it fires an uevent if it changed to let userspace know.

There's a weston implementation at [1] which makes use of this new
property to warn when a user's requested bpc could not be reached.

[1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850

---
Changes in v4:
- Throw out the workqueue and delayed work item
- Remove the drm_connector_update_link_bpc_state function
- Reimplement it by updating the property and firing the uevent in
  commit_tail
- Check that the provided max_bpc value in attach_link_bpc_property is
  within the expected range
- Clamp the connector state's link_bpc value between 8 and max_bpc so
  that no value outside the declared range is ever written to the drm
  property
- Update and reword doc strings
- Add an amdgpu implementation
- Link to v3: https://lore.kernel.org/r/20251022162843.1759-1-marius.vlad@collabora.com/T/

Changes in v3:
- remove VRR mention from commit description (Ville)
- add DRM_MODE_PROP_IMMUTABLE to flags (Ville)
- provide helpers functions for drivers to use (can be used by other
  types of connectors, not just HDMI)
- send uevent informating userspace when 'link bpc' connector state
  changed (Daniel @ https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850)
- added missing doc entry
- Link to v2: https://lore.kernel.org/r/20251006083043.3115-1-marius.vlad@collabora.com/T/

Changes in v2:
- replace return with EBUSY if connector already exists (Dmitry)
- add i-g-t test and an implementation for Weston (Dmitry)
- re-wording patch description (Jani)
- Link to v1: https://lore.kernel.org/r/20250801101750.1726-1-marius.vlad@collabora.com/T/

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

---
Nicolas Frattaroli (2):
      drm/connector: hdmi: Add a 'link bpc' property
      drm/amd/display: Add support for 'link bpc' property

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c   |  2 +
 drivers/gpu/drm/drm_atomic_helper.c               |  9 +++
 drivers/gpu/drm/drm_atomic_uapi.c                 |  2 +
 drivers/gpu/drm/drm_connector.c                   | 86 +++++++++++++++++++++++
 include/drm/drm_connector.h                       | 16 +++++
 6 files changed, 129 insertions(+), 1 deletion(-)
---
base-commit: 9a6bac4a4a289d3ac043f885758d208ccf07f149
change-id: 20260309-link-bpc-d0afc475ac49

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

