Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E35C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9576393B3A;
	Fri, 22 Jul 2022 20:34:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295F393B37;
 Fri, 22 Jul 2022 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Edk6LP53p+loikQVsyEVEqo6R6YSj5UL3s0D/QImZU=; b=XHvQODn+amREJW7cT7O29IPI6v
 xjPm9oiaRqc4tn78T/ooJJ+k0VBlXPyAN2LhbrFyxRekFrYr3NKsk5fcP0BZK2JVMWcPXqs7av8Ml
 2S6b/G8O33keCKnXn1hHtiiHYO4N57JDCn3oSHzNe9KeCduvutTh2ZCeODf+6NMZdnaX2unc1YpaB
 jvwEqE2QXuQ4I80xBvTQRGrMom/r4/tQRFwaCYyzWZ20ezgGRdtNwJs4qtr/o7uYmiDfHsfXgoPTc
 cPQfEJJg3NL+YcOqtBXICEr5/G3s3VVhXwNyqO5g8fF9wjf1eBtH9PqBNIBGgZBUQvKirEzURed67
 Iwt/SBKg==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oEzLe-002fLB-Tr; Fri, 22 Jul 2022 22:34:11 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 'Pan Xinhui' <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tom St Denis <tom.stdenis@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 0/4] drm/amd: Add more GFXOFF stats for vangogh
Date: Fri, 22 Jul 2022 17:33:43 -0300
Message-Id: <20220722203347.70176-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 kernel-dev@igalia.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series adds new logging features for GFXOFF available for vangogh
and documentation for it.

I've created a small userspace program to interact with this new debugfs
interface and it can be found at: 

https://gitlab.freedesktop.org/andrealmeid/gfxoff_tool

André Almeida (4):
  drm/amd: Add detailed GFXOFF stats to debugfs
  drm/amd/pm: Implement GFXOFF's entry count and residency for vangogh
  Documentation/gpu: Document GFXOFF's count and residency
  drm/amdgpu: Document gfx_off members of struct amdgpu_gfx

 Documentation/gpu/amdgpu/thermal.rst          |  14 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 168 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  39 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  14 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  45 +++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  34 +++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  22 +++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  92 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
 13 files changed, 439 insertions(+), 7 deletions(-)

-- 
2.37.1

