Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7F4CDDE69
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 09:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E3310E8DF;
	Thu, 24 Oct 2024 09:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GpthoKcZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C357110E8D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=irN/m7+j5Rbd4thxCQWxZ23RA3Hl8dPFeetJOMivJew=; b=GpthoKcZljXKJJfmfYSMo6COwZ
 faUoGpCA5omxNCD2L7ehLwn/CWtzTRjO/yC6Flgh1J3cntvaIeX3IfKz/gWoTdqJ3fKRdBbH39GUG
 mhLo+Ob3oUCT1PQeu8rSFdrSGSAJvipJ8oucr2TsP/fOZIUAPnU++tNw+0guqTr0+exSnDMD4cCVr
 aMRpsL7xIvFlQy8adAOnFR/xO5W1FIsuUeFoEyfYfm8BnjNMAQmlPpeyTIWi0p+0if8k+wQY1GAzT
 tobnM/fqvBpHCQUNh1t5QkIH7A4gtNhLeME1ybBnw+ypUM2PwWdR0Sd70lwTbToutsaPFw1HS1cht
 wlYd+Ybw==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1t3u4H-00ERF6-F8; Thu, 24 Oct 2024 11:23:45 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 0/4] fdinfo fixes
Date: Thu, 24 Oct 2024 10:23:37 +0100
Message-ID: <20241024092342.98760-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I included two Teddy's patches which have been reviewed and acked and IMO makes
sense to pull them in straight away.

Then patch three does what Christian suggested - stops reporting GWS, GDS, OA
and DOORBELL TTM regions as 'CPU' memory.

Last patch is RFC in case there is value to expose the above mentioned as their
own memory regions. Looks questionable since I only see all zeros so not much
value for a lot of new text to parse?

$ cat /proc/1967/fdinfo/4
pos:  0
flags:  02100002
mnt_id: 24
ino:  1181
drm-driver: amdgpu
drm-client-id:  30
drm-pdev: 0000:04:00.0
pasid:  32785
drm-total-cpu:  0
drm-shared-cpu: 0
drm-active-cpu: 0
drm-resident-cpu: 0
drm-purgeable-cpu:  0
drm-total-gtt:  20 MiB
drm-shared-gtt: 0
drm-active-gtt: 0
drm-resident-gtt: 20 MiB
drm-purgeable-gtt:  0
drm-total-vram: 155068 KiB
drm-shared-vram:  13584 KiB
drm-active-vram:  0
drm-resident-vram:  155068 KiB
drm-purgeable-vram: 0
drm-total-gds:  0
drm-shared-gds: 0
drm-active-gds: 0
drm-resident-gds: 0
drm-purgeable-gds:  0
drm-total-gws:  0
drm-shared-gws: 0
drm-active-gws: 0
drm-resident-gws: 0
drm-purgeable-gws:  0
drm-total-oa: 0
drm-shared-oa:  0
drm-active-oa:  0
drm-resident-oa:  0
drm-purgeable-oa: 0
drm-total-doorbell: 0
drm-shared-doorbell:  0
drm-active-doorbell:  0
drm-resident-doorbell:  0
drm-purgeable-doorbell: 0
drm-memory-vram:  155068 KiB
drm-memory-gtt:   20480 KiB
drm-memory-cpu:   0 KiB
amd-evicted-vram: 0 KiB
amd-requested-vram: 155068 KiB
amd-requested-gtt:  20480 KiB
drm-engine-gfx: 19291217545 ns

Cc: Christian König <christian.koenig@amd.com>
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>

Tvrtko Ursulin (2):
  drm/amdgpu: Stop reporting special chip memory pools as CPU memory in
    fdinfo
  drm/amdgpu: Expose special on chip memory pools in fdinfo

Yunxiang Li (2):
  drm/amdgpu: make drm-memory-* report resident memory
  drm/amdgpu: stop tracking visible memory stats

 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 23 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 24 ++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 11 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 11 +++++++++-
 4 files changed, 25 insertions(+), 44 deletions(-)

-- 
2.46.0

