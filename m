Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613CFCF9C73
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 07:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7BB10E391;
	Mon, 23 Sep 2024 07:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="CWOpYmeQ";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1F710E178;
 Mon, 23 Sep 2024 01:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=Pt0WPR8fxCskuWATQR8jQ+bzmSIw/orFdDqhyOGiFD0=; b=CWOpYmeQmkYyShRe
 7wR9xNcMxD/jEYYqTyCIoduT1/egBW3Rdwwxi8Qiia7zmKl3IuvY9/XzXv+pSkfSnbN7lN/uCXmjT
 jCfqyGtTo7LLMeUTjT1MLh1BxGWjQqU2quTGKZxsCdRqvvtA+5slcPbydmCHEopQs5lZsfffJCngx
 W6t3wesWpqhN2eiAAbxwIiQsdZyF/B5C1ZUraPnXaOVia3F8CqzV+gn0bbT5d7nVqUgomcPeshjyW
 1Hd7liy4YErIJW0Irj9wCrEQbV/Mbgteg6kfljctfZ0K6Ok/7es89GNHl5sgneCSTd07zRT67KtM4
 Uu274Nfmk2JD5s9CXg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1ssXoq-006k2k-0B;
 Mon, 23 Sep 2024 01:24:52 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/5] AMDGPU deadcode
Date: Mon, 23 Sep 2024 02:24:41 +0100
Message-ID: <20240923012446.4965-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Sep 2024 07:25:17 +0000
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
  This is a bunch of deadcode removal in amdgpu;
some of the functions are ones which were previously
used but haven't been for a while, others are functions
that were added a few years ago and haven't ever been used.

  There are some others that I've not removed, which have
been added in the last few years but not been used,
I was worried maybe there are patches in someones tree
about to use them (e.g. amdgpu_lsdma_copy_mem, amdgpu_mes_reg_wait,
amdgpu_ras_unbind_aca, amdgpu_seq64_alloc, and
amdgpu_xcp_prepare_resume) - I'd be happy to take those as
well.

  One other thing I wasn't sure of; I removed
amdgpu_device_ip_is_idle
which has been unused since about 2016, but does that make
the 'is_idle' methods unused or is there something else that calls
them?

(Sent from this kernel booted on my RX550 GPU)

Dave

Dr. David Alan Gilbert (5):
  drm/amdgpu: Remove unused amdgpu_device_ip_is_idle
  drm/amdgpu: Remove unused amdgpu_atpx functions
  drm/amdgpu: Remove unused amdgpu_gmc_vram_cpu_pa
  drm/amdgpu: Remove unused amdgpu_gfx_bit_to_me_queue
  drm/amdgpu: Remove unused amdgpu_i2c functions

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 --------
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 12 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 24 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 10 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 12 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 25 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h       |  4 ---
 9 files changed, 100 deletions(-)

-- 
2.46.1

