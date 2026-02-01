Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E61E73146
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 08:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCFA10E3B7;
	Mon,  2 Feb 2026 08:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IlCqh/rI";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8524B10E0BE
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Feb 2026 19:05:47 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so49779425e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Feb 2026 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769972746; x=1770577546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbZr1S0wq4DvIcJzyCdoWjIoy42MmQpxH3r9aw2Tp3g=;
 b=IlCqh/rITl/hoopH4CgXtDNqbdW31H1XKX4xWHrBZBHWyh3VuZvG5QpInsRLnWoB4b
 YbvycPnFqCRyHULpzebUN8qf9zYEJBpGRGFqGRwJoDBBShHPN9XA2RNqcMN1tJKgZite
 fbLi+bRYZU8l2lHcRLf1YUFS0NSPoO5EgKI0w/t4sa6ZI18NMuRn8/E33JUP1+KVyRCL
 oaHsnc+Gnj3Lmq8ZLYYlOvuvRYdaV84jlZEoavVPVADum9Xi6SIzgvfSUIAAWRr+XKsZ
 sYR08SKa0Pr1axaqAFS1JXDw3lTjZVm69ZpW8g9kcVRu1xwS2bRMnR2UHR1vAorW9XcC
 x3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769972746; x=1770577546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EbZr1S0wq4DvIcJzyCdoWjIoy42MmQpxH3r9aw2Tp3g=;
 b=oZaWVDnBvS5FEH46mODagDQJSY6fsl5Xn4gS4y/xF4I+HqZ+3d4LS9NGkGkwB1+54M
 BF+Q/cpRjenUskLJ48CrlrnBz7QTM7yQM/wgjU+QfSiSzo4cpmmqSC/JQFxRqylR4JN+
 14+b93wd7/Lx3V56HC4/EFWQWi8L5uApOfk/iv8TBNFBgRu/0VSJwObV0OjRkneZBGIy
 0aYSVNFlFAkYRdrC3ismrehsP7fLCZL+Q26JtZ3aJ7+yj1/7LgRiYDrsTo7SsLfW46FL
 PYKlCgOLpU7er8AsneHVHMkmRY+rpLgIuQ6Y+mP1AAan9kJJ3iZL3wxYz+tFQjAOCW0y
 1CtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoFMnZXGR1zV4vsElXYqLUdLumU3hX0Kx6L9+qMCxY9k2626PCSaa4FYLF3HA/sYIwWCiFuIy0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIsAw5bxNiJxEjj0ZnE07WHYJlgFD6gKrgG5HDr6yrIAhCGxup
 bFpv2FLNK6W36kCia0ZZhmPO09+TRb0IP/WE/Mli7xq4QBVFrvDDOBpF
X-Gm-Gg: AZuq6aJaBr6efX2YfeJt+jBLpqx1R0bu9FSmZYL4LYJiS73IkFGPRWnOCXX7/q1Z0H1
 e2i1V5A+KZrG6e7NLKT5YFus/P5abQgmV6uF3es68i8IsewypeY9CUMbu6V/biSwx3vYiTiOV65
 kt6Vr+1vxb5tCcYlmiCRg9cZkeqIt9ilwP6KZKmtmVdvY3qferT1FDD47t7GwPUm8G/JU+NwfDK
 xf1Sj7oxrZqAvih3xHvFshyS8jPUWHOnUgJfWNVARt/rdEUwGUvF38K7wpe7+LvUkEJf8/GJEXX
 +ny9exgvciArxgreKy3kD0k7ND4D4s2nsHe/9M1eGaYWtbgoDxmb/MwMm0dNPPkrSDtFOBgAmLz
 j2q7cjpTdN98+K9NF5wn68f2fZdEDtMRdFTI7HDObmtDNlyPK/8XUJE/ETdIAMK9cBLwvrkkmKn
 LVyylKmANNaFui946CHCF/viD2Cqi41U0U2uzMMw==
X-Received: by 2002:a05:600c:4f8a:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-482db4568dbmr127721945e9.2.1769972745714; 
 Sun, 01 Feb 2026 11:05:45 -0800 (PST)
Received: from ionutnechita-arz2022.local
 ([2a02:2f0e:c200:300:376f:7d7f:40e7:f1de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4757sm39596541f8f.5.2026.02.01.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 11:05:45 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: alexdeucher@gmail.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 ionut_n2001@yahoo.com, linux-kernel@vger.kernel.org,
 sunlightlinux@gmail.com, superm1@kernel.org
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
Date: Sun,  1 Feb 2026 21:05:36 +0200
Message-ID: <20260201190535.18575-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CADnq5_MSvWLVqhgkdaYn6bjPC2L2=jf5v=h3n1cx=ZYgnXLQPQ@mail.gmail.com>
References: <20260126194057.7376-2-sunlightlinux@gmail.com>
 <CADnq5_MSvWLVqhgkdaYn6bjPC2L2=jf5v=h3n1cx=ZYgnXLQPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Feb 2026 08:55:02 +0000
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

Hi Alex,

Thank you for the quick response and for the information about hibernation support.

Here's the stack trace showing the call chain when the TLB flush failures occur. The issue happens in two places:

1. During resume (hibernation restore):

Call Trace:
 dump_stack_lvl+0x5b/0x80
 amdgpu_gmc_fw_reg_write_reg_wait+0x1c7/0x1d0 [amdgpu]
 gmc_v9_0_hw_init+0x2e2/0x390 [amdgpu]
 gmc_v9_0_resume+0x26/0x70 [amdgpu]
 amdgpu_ip_block_resume+0x27/0x50 [amdgpu]
 amdgpu_device_ip_resume_phase1+0x55/0x90 [amdgpu]
 amdgpu_device_resume+0x69/0x380 [amdgpu]
 amdgpu_pmops_resume+0x46/0x80 [amdgpu]
 dpm_run_callback+0x4a/0x150
 device_resume+0x1df/0x2f0
 async_resume+0x21/0x30
 async_run_entry_fn+0x36/0x160
 process_one_work+0x193/0x350
 worker_thread+0x2d7/0x410

2. Subsequent failures during command submission:

Call Trace:
 dump_stack_lvl+0x5b/0x80
 amdgpu_gmc_fw_reg_write_reg_wait+0x1c7/0x1d0 [amdgpu]
 amdgpu_gmc_flush_gpu_tlb+0xd0/0x280 [amdgpu]
 amdgpu_gart_invalidate_tlb.part.0+0x59/0x90 [amdgpu]
 amdgpu_ttm_alloc_gart+0x146/0x180 [amdgpu]
 amdgpu_cs_parser_bos.isra.0+0x5d6/0x7d0 [amdgpu]
 amdgpu_cs_ioctl+0xbd0/0x1aa0 [amdgpu]
 drm_ioctl_kernel+0xa6/0x100
 drm_ioctl+0x262/0x520
 amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]

Error message: "amdgpu 0000:04:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706"

Full dmesg log available at: https://gitlab.freedesktop.org/-/project/4522/uploads/6a285ad2e24f4807e5d75c3f4ed5a7a1/dmesg-dump-stack.txt

Regarding the hibernation support issues you mentioned - I understand the limitations with secure boot and VRAM eviction. In my case, I have secure boot disabled and sufficient swap space, so the primary issue I'm encountering is this TLB flush failure.

I'm happy to test any patches or help with further debugging if needed.

Thanks,
Ionut
