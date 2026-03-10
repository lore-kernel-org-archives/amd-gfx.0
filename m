Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2475FEA854E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 08:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DFF10E67C;
	Tue, 10 Mar 2026 08:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=wbinvd.org header.i=@wbinvd.org header.b="Na5xSi4+";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26AFA10E651
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 05:54:36 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-127380532eeso1156308c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Mar 2026 22:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wbinvd.org; s=wbinvd; t=1773122075; x=1773726875; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AZrje2kJSd9Bh+vOqAe83fHEY512zOk+rc8eCAn6ioA=;
 b=Na5xSi4+kfDDOwlfSI3/D0wQPOuCZws8RWg9iJpxp7FLoTHZskMHTebsa4VgH0rfa6
 Rc2YwODn3RmRWh1A+vPcXfvG6z/ES9URMpev4sL1deFiO4QBZcL1IcWhu8MilrxD841R
 a6RmjoCPWQpPWAdE9OkQnp/swyvKsrf7rRn1KKB427p7WMGxYZG2A0rVSBZNVVAXRm72
 goQI76GkG3EA6q1F530qnvUG32Ab+knvx1SczsoFhr3tFY+J3wuw0hYXof5BHlySHgdj
 FvBnh1TQGopSUCNz0GfqioB+EdN9UeHXh9Yj/aJZnoAGas5zNZ70BGVJMotDB/6bgeYw
 DxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773122075; x=1773726875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZrje2kJSd9Bh+vOqAe83fHEY512zOk+rc8eCAn6ioA=;
 b=Q4GzvG+8yy2jSDhiPWX9z9U2+FROh1US1tfjqZt/6HWIUHTFz+erm7Pe2X6WC54DnA
 FiLAkjke4rMR4xwYGY4KZMnFHMET2Xy0S75L0z6HLC/whR3Rbfav61UKcuVZJ74yrdmA
 C4GxQkj6O9IX+Q0ybF6nA3PttXD5/uGSCBon4j6sK2tGNcdANFhQA69BaUUjr6p5oUkX
 gMBMSBmtc43SWwT3OmIyemI1wmP0FR/tsafYIdSuaxVcbwgbSimY1qn7oMUzHsWZNDZE
 rKEeCIvaXH8whZUFhjf+SPARG9cD3FA1uE68jSv7yp86mtoRaEZCxcntMSgHoFqHP8IN
 HKiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhe3SBuF1ibpjCjo/iT3XX8jsgEz1+GxcFOjJjmr8icaaYAlHcAwGzpxqOSWAtlu7y0EtWC68F@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA0PLMdZv3DtZkG5IRknAz+DDBftWq8q/wsQ+s5qMLFFHzKnVY
 Y33AVXvnsy830aOn2vBVPxplYmNpdMKkh+4J4fhtxl18PBde0BB3NCwJ7k+32MBASJA=
X-Gm-Gg: ATEYQzzMuQwkPNfmDnRCN7tJ7YShl1LvhhmTL9It8jdr8G1hYjXaJE6njlZvB7IS28q
 lXcalYj4qhj/DNGija5HcigWkp5vSy1U8lhDg0p3wghis/YXvEE+8PIkk9BsMAScv7WTSNmVHun
 4U3+cQcA9ler3BgJyOJWZaUEZTAe2EjImiBUTlv5OWZbf5WJvsvY6fYiTpGPr+ZVXqtJ/9ROXnp
 CyucsRMe54ezDQMY8qwXTME+WPSuG7p+pWr3gpLMK1g+o2kgrzND5F3YUgPzrpP35hypkzYRnkK
 64QlJZf6OcpVgQSdAKV1oAuS6TD9kQWzw+QYFtsli7/6945vGgsDMmWfDhkgvqdGwudP0su/Vm4
 5ajfIi0dGITozXqi8XC7qxayusxPZdpL6Hwo2yrOVjt+N26ZrTD2kTliD8JD0gSYdmInrZLThy1
 UIrmFzy5cyVlzRGyu6XOr42OfX
X-Received: by 2002:a05:7022:23a9:b0:11a:49bd:be28 with SMTP id
 a92af1059eb24-128c2d8ff9fmr6043992c88.4.1773122075270; 
 Mon, 09 Mar 2026 22:54:35 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:d3b:fdd6:c26e:df86])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128d989cd36sm7603986c88.1.2026.03.09.22.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 22:54:34 -0700 (PDT)
Date: Mon, 9 Mar 2026 22:54:32 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Charlene Liu <charlene.liu@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, Alex Hung <alex.hung@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [REGRESSION][PATCH] drm/amd/display: Fix uninitialized variable
 which breaks full LTO
Message-ID: <aa-yGMPCWwkjXNAb@mozart.vkv.me>
References: <ef7266eb7802ce6d68ebd9356477e9671f0c94e0.1773116305.git.calvin@wbinvd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef7266eb7802ce6d68ebd9356477e9671f0c94e0.1773116305.git.calvin@wbinvd.org>
X-Mailman-Approved-At: Tue, 10 Mar 2026 08:25:11 +0000
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

On Monday 03/09 at 21:24 -0700, Calvin Owens wrote:
> Commit e1b385726f7f ("drm/amd/display: Add additional checks for PSP
> footer size") introduced a use of an uninitialized stack variable
> in dm_dmub_sw_init() (region_params.bss_data_size).
> 
> Interestingly, this seems to cause no issue on normal kernels. But when
> full LTO is enabled, it causes the compiler to "optimize" out huge
> swaths of amdgpu initialization code, and the driver is unusable:
> 
>     amdgpu 0000:03:00.0: [drm] Loading DMUB firmware via PSP: version=0x07002F00
>     amdgpu 0000:03:00.0: sw_init of IP block <dm> failed 5
>     amdgpu 0000:03:00.0: amdgpu_device_ip_init failed
>     amdgpu 0000:03:00.0: Fatal error during GPU init

In case anybody wants to poke around, I uploaded the binaries here:

    https://github.com/jcalvinowens/lkml-debug/releases/tag/000001

You can see in the diff of the disassembly that the "missing" piece of
dm_sw_init() reappeared after reverting e1b38572:

    https://github.com/jcalvinowens/lkml-debug/blob/main/amdgpu-lto/not-working-to-working.diff

This is my bisect log:

    bad: [1f318b96cc84d7c2ab792fcc0bfd42a7ca890681] Linux 7.0-rc3
    good: [05f7e89ab9731565d8a62e3b5d1ec206485eeb0b] Linux 6.19
    bad: [1c2b4a4c2bcb950f182eeeb33d94b565607608cf] Merge tag 'pci-v7.0-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
    good: [6589b3d76db2d6adbf8f2084c303fb24252a0dc6] Merge tag 'soc-dt-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
    bad: [a60f627cf4ab474aebf15f62c55eadabab9780da] Merge tag 'amd-drm-next-6.20-2026-01-30' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
    good: [83675851547e835c15252c601f41acf269c351d9] drm/xe: Cleanup unused header includes
    bad: [71573db5ad74b2087a4688cd1dda73ff082620f6] drm/amd/display: switch to drm_dbg_ macros instead of DRM_DEBUG_ variants
    bad: [3235a5b72317be613b69e22c3b2c9f2bec546253] drm/amdgpu: Update MES VM_CNTX_CNTL for XNACK off for GFX 12.1
    bad: [e1b73b64271d706079370b58b81292dafd373163] amdkfd: remove DIQ support
    good: [2634ef1b8c00207dde5101e926241957aa5652b8] drm/amdkfd: Fix PTE clearing during SVM unmap on GFX 12.1
    bad: [af441be8b75deb93ded51c54b9a2ba1e048b1c91] drm/amdgpu: add support for sdma v7_1
    good: [69249b477b95f91e56bb19ec53707253899458c4] drm/amd/display: Move dml2_validate to the non-FPU dml2_wrapper
    bad: [ec62b7ded978957ec74add4c1feccc986e2baeef] drm/amdkfd: Uninitialized and Unused variables
    good: [c7062be3380cb20c8b1c4a935a13f1848ead0719] drm/amd/display: Correct DSC padding accounting
    bad: [d28e92093ceffb424b9b0e36bbd391c83b1cfe78] drm/amd/display: [FW Promotion] Release 0.1.37.0
    bad: [e1b385726f7f7fc75b6cd3c2216430de8a625a2d] drm/amd/display: Add additional checks for PSP footer size
    first bad commit: [e1b385726f7f7fc75b6cd3c2216430de8a625a2d] drm/amd/display: Add additional checks for PSP footer size

Thanks,
Calvin
