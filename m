Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21EECAC58E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 17:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4950810E995;
	Wed, 10 Sep 2025 17:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ga3trgjr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1397C10E995
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bNYajzSiw9nd/fcWlbW86GqWWMgzvUddJjf56L+zroU=; b=ga3trgjr+7lWEhIxMfXiNMdxPE
 ChaiXX5x6lgYD1p5Y82yZ61gxbNwBSwad4M/TV/yrjDoz7MSGKapTI0mGlsC6awV3OiEWkKuLyoIg
 8dL6YJ6GemStWpDy/ccdw8/ixln6K0JVKjQ4zQctgsCJmZW1FFLMFsc+KFTkZMyzCvuwry3D0Q97O
 MoNPrurZxhIt3O2C1Nks2J16JyGr516JqzEZk+BTQ90hypDdeIeyYlHRZwnIH/X8ZDJ08kAMIoi7y
 NfEGw/4Zt6Lf55yXQJY9coTbcOlIitzrOGILi03kDhEH2cF8xSmjdLHXoXYRh3gs6R+86LqVztPph
 YdgHb6DA==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwOrj-009URG-Vl; Wed, 10 Sep 2025 19:44:20 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 00/10] Use devm_i2c_add_adapter() for amdgpu
Date: Wed, 10 Sep 2025 11:39:33 -0600
Message-ID: <20250910174350.2729341-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
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

When discussing the load/unload issue in amdgpu and its fix [1],  Robert
Beckett suggested the use of devm_i2c_add_adapter(). This function is
part of Devres [2], and it simplifies resource management when the driver is
detached. Aside from reducing boilerplate, it also reduces maintenance
effort and minimizes the likelihood of future load/unload issues
associated with i2c.

With this idea in mind, this series replaces all the i2c_add_adapter()
and i2c_del_adapter() with devm_i2c_add_adapter() in amdgpu. The first
patch is focused on DM, the second patch focuses on the generic
amdgpu_i2c, and all the other patches are part of the SMU (they share a
similar code).

[1] - https://gitlab.freedesktop.org/agd5f/linux/-/commit/89923fb7ead4fdd37b78dd49962d9bb5892403e6
[2] - https://docs.kernel.org/driver-api/driver-model/devres.html

Thanks

Rodrigo Siqueira (10):
  drm/amd/display: Use devm_i2c_add_adapter to simplify i2c cleanup
    logic
  drm/amdgpu/amdgpu_i2c: Use devm_i2c_add_adapter instead of
    i2c_add_adapter
  drm/amdgpu: Use devm_i2c_add_adapter() in SMU V11
  drm/amd/pm: Use devm_i2c_add_adapter() in the i2c init
  drm/amd/pm: Use devm_i2c_add_adapter() in the Arcturus smu
  drm/amd/pm: Use devm_i2c_add_adapter() in the Navi10 smu
  drm/amd/pm: Use devm_i2c_add_adapter() in the Sienna smu
  drm/amd/pm: Use devm_i2c_add_adapter() in the V13 smu
  drm/amd/pm: Use devm_i2c_add_adapter() in the V13_0_6 smu
  drm/amd/pm: Use devm_i2c_add_adapter() in the V14_0_2 smu

 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 18 +++-------------
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  5 +----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++-----------------
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 19 ++---------------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 19 ++---------------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 19 ++---------------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 ++-----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 19 ++---------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 ++---------------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 19 ++---------------
 10 files changed, 20 insertions(+), 153 deletions(-)

-- 
2.50.1

