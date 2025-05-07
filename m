Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF60C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E43110E908;
	Thu,  8 May 2025 13:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="HxLHpG/B";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6389210E867;
 Wed,  7 May 2025 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=tv/2C9kUFFhHmEsxaXVMRgJCCX3yR9ZaEvaUp7YMgy4=; b=HxLHpG/BEFH0fRxN
 Y8S5kO07JOHJFj8IGSF/Zhv6Utf7x5Vy5jTplODz8KX6ynXlXWRHKoggTt63gMBIpt7PC3SDw6MP8
 SQcSwdWR1Vb8PnouPSTZ58XtFQzavVY7dBLI6FmB/PyZ4CnfjUe05lm8o33HdrgHKVPxdfTMxMjNS
 YsOumqCgsE1nVTtQforqRMMwBLEJ6D+vZZNevTp9rMQu1IxHpHyO2O/swMQEctZ+kl2bH2t7McHDG
 7mCGid/rV7efGXLMEK1HWVdSqfopzzLWtt9B1AR0Mc/5QtraUAkzR7RrseGlOQ5cyPuTzRayIsEl2
 q4aEyx8dlsXwzFPsPg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1uCi9S-002EIU-0H;
 Wed, 07 May 2025 17:01:46 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, kenneth.feng@amd.com, christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] AMD gpu deadcoding (S more)
Date: Wed,  7 May 2025 18:01:42 +0100
Message-ID: <20250507170145.102508-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 May 2025 13:02:11 +0000
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  A few more AMD deadcoding patches spinning out of the
questions I asked, and Kenneth answered.

See:
  https://lore.kernel.org/all/DM4PR12MB5165D85BD85BC8FC8BF7A3B48E88A@DM4PR12MB5165.namprd12.prod.outlook.com/

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  drm/amd/pm/smu13: Remove unused smu_v13_0_init_display_count
  drm/amd/pm: Remove unused smu_mode2_reset_is_support
  drm/amd/pm: Remove remainder of mode2_reset_is_support

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c           | 13 -------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h       |  5 -----
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h        |  2 --
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  6 ------
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c  |  6 ------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c      | 12 ------------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    |  6 ------
 7 files changed, 50 deletions(-)

-- 
2.49.0

