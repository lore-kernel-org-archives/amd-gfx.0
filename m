Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4815AC433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9EA21D95
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nsmk6x72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9EA21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AC66E1EC;
	Tue, 28 Jul 2020 07:41:21 +0000 (UTC)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3E989B68;
 Mon, 27 Jul 2020 20:52:37 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f1f3e880000>; Mon, 27 Jul 2020 13:52:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 27 Jul 2020 13:52:37 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 27 Jul 2020 13:52:37 -0700
Received: from lenny.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 20:52:31 +0000
From: Daniel Dadap <ddadap@nvidia.com>
To: <dri-devel@lists.freedesktop.com>, <intel-gfx@lists.freedesktop.com>,
 <nouveau@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <bskeggs@redhat.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <david1.zhou@amd.com>
Subject: [PATCH 0/4] drm: add support for retrieving EDID via ACPI _DDC
Date: Mon, 27 Jul 2020 15:53:53 -0500
Message-ID: <20200727205357.27839-1-ddadap@nvidia.com>
X-Mailer: git-send-email 2.18.4
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1595883144; bh=ToIQEjlgFve/1Ok8c1QkB5teD7B7RcE0x+dy+ukqER0=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:X-Originating-IP:
 X-ClientProxiedBy:Content-Type;
 b=nsmk6x72MtOpw7DZZhpxDM9QikLxW4k2f3aRxKBa+MN4u2i2Hj1NDgb3KLsuDdSmt
 jmlgPI3lmkmL2aSnU6hmujy8vjgUbPxbT/UxN3FaogHNbjK4rxy8uEhbCeNotRcMxF
 fbPsJJEq0ZmCDpeyUomyJye+UYUJGqAoxlIklx76UrWnqtwAQKPDYWVKdBw5t7QHuz
 P5Bkvi9AA41Q7u+tKWFn2B2c61g+7ATW9anHkgEbqhp8x6h2ywQgZptVtz5ck7wKuB
 HkYt2Ys6EDLSCp7CEIdPF38asQROt2ITUl0NQFkB/Y3mvRpg/5hkHHrAoJL0j9HUQW
 7vaD96Mf01eOg==
X-Mailman-Approved-At: Tue, 28 Jul 2020 07:41:20 +0000
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
Cc: Daniel Dadap <ddadap@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some notebook systems provide the EDID for the internal panel via the
_DDC method in ACPI, instead of or in addition to providing the EDID via
DDC on LVDS/eDP. Add a DRM helper to search for an ACP _DDC method under
the ACPI namespace for each VGA/3D controller, and return the first EDID
successfully retrieved via _DDC. Update the i915, nouveau, and radeon
DRM-KMS drivers to fall back to retrieving the EDID via ACPI _DDC on
notebook internal display panels after failing to retrieve an EDID via
other means.

This is useful for retrieving an internal panel's EDID both on hybrid
graphics systems with muxed display output, when the display is muxed
away, as well as on a small number of non-muxed and/or non-hybrid
systems where ACPI _DDC is the only means of accessing the EDID for
the internal panel.

Daniel Dadap (4):
  drm: retrieve EDID via ACPI _DDC method
  i915: fall back to ACPI EDID retrieval
  nouveau: fall back to ACPI EDID retrieval
  radeon: fall back to ACPI EDID retrieval

 drivers/gpu/drm/drm_edid.c                  | 161 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c     |   8 +-
 drivers/gpu/drm/i915/display/intel_lvds.c   |   4 +
 drivers/gpu/drm/nouveau/nouveau_connector.c |   6 +
 drivers/gpu/drm/radeon/radeon_combios.c     |   6 +-
 include/drm/drm_edid.h                      |   1 +
 6 files changed, 182 insertions(+), 4 deletions(-)

-- 
2.18.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
