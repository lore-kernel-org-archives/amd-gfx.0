Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0CEC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 07:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192E2B40E1;
	Fri,  5 Aug 2022 07:24:06 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613808FBFD;
 Thu,  4 Aug 2022 07:35:11 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id z12so14084711wrs.9;
 Thu, 04 Aug 2022 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc; bh=5EU04U6zAYyIYzGGcwcDfmg2hMhuz1M0NEedR2ivuW0=;
 b=RszuOa+odpEaiEJy45G5YW+s0j47TpRmy+lEDVUwPVP6JcsPJrwMo8tspfvRb7fMre
 W99E7nWmRNZSwcQhGwF7U5/tPYQqr8NnwO1Jj52xEZHtAju58FkRMFQifV7yjHz4R7uZ
 m+nMVKawX5MR5rLXmzXaeUmOP9JPQ/GTqa8O616Ny/hVj/FzIVxzhR4i5VxzKP4Uxs2N
 NNcVAj7HwHwKi4SGOn+kAUk7hOVyYV9XW6b6mu/ZbjjRwmTOHtMXIMuyrNK1WhC89ZXv
 +7u8jVSkbkWWd/rROPN/oXOkKdOy+nWLplYIFpAPipSroyvbydNn4zA69ceObU+QdJu0
 2W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=5EU04U6zAYyIYzGGcwcDfmg2hMhuz1M0NEedR2ivuW0=;
 b=hNI4SrBFyTzk9nR3IIvFNZXQ0ZDM0f4YnUD0dGHoPid/hLn0rB/lpsg/UHYfcCqYBv
 Vj+aDeoV9L1LzXtdUbhO7gbAc4xQmNRs7RTELMHxQx8kpaGcVgr3jbpTmHy4a7XCZqxR
 gQVe1wTwEPGoehXseVXHb7EndGYtLRijF/p+eH33ByXh8LIPFofgw+QKSrc7woJVHj/w
 Jb6LbBECZNaWAXGjBeq6ue4Vpa0H2Zjr23eiI5Osy8RVEH/mgzbDlcFAq9BIoVS5ZCI5
 ZSGyZfqF8I2yFupXC7N6NN9KBtN4/jKXxxaxT27pSrueTEx2UlIFZWr3O3IHVJs68Djm
 E3kg==
X-Gm-Message-State: ACgBeo3qmDyTDNC3acnLRfQ20YsNLFDqWYBXNi6viysnMnBU3YlbS/+L
 +3Wc1GCKdhPVmMglWkudAAE=
X-Google-Smtp-Source: AA6agR7QyZrRl97ERrAkEom1RkOvNNl2TGMuPIkZIfvXeehObd0r+4cGJ+S6KNmKW/eNfqqc4NTEgg==
X-Received: by 2002:a5d:64c1:0:b0:220:83fd:521e with SMTP id
 f1-20020a5d64c1000000b0022083fd521emr435672wri.428.1659598509871; 
 Thu, 04 Aug 2022 00:35:09 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
 by smtp.gmail.com with ESMTPSA id
 d14-20020adfe84e000000b0021badf3cb26sm309913wrn.63.2022.08.04.00.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Aug 2022 00:35:08 -0700 (PDT)
Date: Thu, 4 Aug 2022 08:34:58 +0100
From: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To: Chengming Gui <Jack.Gui@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: mainline build failure due to 6fdd2077ec03 ("drm/amd/amdgpu: add
 memory training support for PSP_V13")
Message-ID: <Yut2otE1h2xtC79o@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 05 Aug 2022 07:24:03 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi All,

The latest mainline kernel branch fails to build for alpha and mips
allmodconfig with the error:

drivers/gpu/drm/amd/amdgpu/psp_v13_0.c: In function 'psp_v13_0_memory_training':
drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:23: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
  534 |                 buf = vmalloc(sz);
      |                       ^~~~~~~
      |                       kvmalloc
drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:21: error: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  534 |                 buf = vmalloc(sz);
      |                     ^
drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:545:33: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
  545 |                                 vfree(buf);
      |                                 ^~~~~
      |                                 kvfree

git bisect pointed to 6fdd2077ec03 ("drm/amd/amdgpu: add memory training support for PSP_V13").

And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.

--
Regards
Sudip
