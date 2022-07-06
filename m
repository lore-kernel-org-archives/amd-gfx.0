Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F829C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 17:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44AB11A141;
	Wed,  6 Jul 2022 17:58:26 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D9211A141
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 17:58:25 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7691961FC5;
 Wed,  6 Jul 2022 17:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EAFC3411C;
 Wed,  6 Jul 2022 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657130303;
 bh=bqx3+veRRV0NTTNeX3+xgaMUVCqe7pwRf1/yFdXaytw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CpNZi3eXrrN4bU3L52BgBmeCj9LuknwLJdpWzFZrJC7zeUu2wZEER0Ran7FMp/0lT
 attw3QRFmI9y1wuk6Sr+RChzKN2DCjqPqSYqoEhrJntCvEkbEXZWI4gcxUO9Jg0wII
 BMC5zvsOv3L4guVK3aJOUvna2AI6ezRm5tYJuzPGxR1cvq0XftygzbOhwABklwewDy
 02+WjByf0PBdNFyZu2X3FjBmrPV2VvI+GwRtGIuNiNHwbLs3vWrXbpl6PXjqqHVCYL
 Xd2FSxhh33L7+6zV13qKAanVpGTJm+d0PXNqAmbPmeRv1zFqGgO9bF+bwH/mMa24t8
 TvcqELIbRuyzA==
Date: Wed, 6 Jul 2022 10:58:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 02/40] drm/amd/display: Add SubVP required code
Message-ID: <YsXNPayfiUGS67i0@dev-arch.thelio-3990X>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
 <20220630191322.909650-3-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630191322.909650-3-Rodrigo.Siqueira@amd.com>
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, llvm@lists.linux.dev,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 pavle.kotarac@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, hamza.mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 30, 2022 at 03:12:44PM -0400, Rodrigo Siqueira wrote:
> From: Alvin Lee <Alvin.Lee2@amd.com>
> 
> This commit enables the SubVP feature. To achieve that, we need to:
> 
> - Don't force p-state disallow on SubVP (can't block dummy p-state)
> - Send calculated watermark to DMCUB for SubVP
> - Adjust CAB mode message to PMFW
> - Add a proper locking sequence for SubVP
> - Various fixes to SubVP static analysis and determining SubVP config
> - Currently SubVP not supported with pipe split so merge all pipes
>   before setting up SubVp
> 
> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Acked-by: Alan Liu <HaoPing.Liu@amd.com>
> Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>

This patch is now in linux-next as commit 85f4bc0c333c
("drm/amd/display: Add SubVP required code"), where it causes build
failures when building for arm64 with both Clang and GCC (see bisect log
below).

Clang shows errors during modpost:

ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__divdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "fma" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixunsdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

GCC shows errors along the lines of:

In function 'populate_subvp_cmd_pipe_info',
    inlined from 'dc_dmub_setup_subvp_dmub_command' at /home/nathan/cbl/src/linux-next/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:675:5:
/home/nathan/cbl/src/linux-next/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:603:91: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  603 |                         (((double)dc->caps.subvp_prefetch_end_to_mall_start_us / 1000000) *
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
  604 |                         (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/nathan/cbl/src/linux-next/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:604:63: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  603 |                         (((double)dc->caps.subvp_prefetch_end_to_mall_start_us / 1000000) *
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  604 |                         (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
/home/nathan/cbl/src/linux-next/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:602:72: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  602 |         pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
  603 |                         (((double)dc->caps.subvp_prefetch_end_to_mall_start_us / 1000000) *
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  604 |                         (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  605 |                         (double)phantom_timing->h_total;
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I initially reproduced this with Fedora's configuration [1] but it
appears that allmodconfig should show it as well. Our CI also shows
problems for ARCH=riscv allmodconfig [2].

I am happy to test patches as necessary.

[1]: https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config
[2]: https://builds.tuxbuild.com/2BZS5HPSuDdoMFw6mxjG2ZmT441/build.log

Cheers,
Nathan

# bad: [088b9c375534d905a4d337c78db3b3bfbb52c4a0] Add linux-next specific files for 20220706
# good: [e35e5b6f695d241ffb1d223207da58a1fbcdff4b] Merge tag 'xsa-5.19-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect start '088b9c375534d905a4d337c78db3b3bfbb52c4a0' 'e35e5b6f695d241ffb1d223207da58a1fbcdff4b'
# good: [1a4255ede07a967e57115b54da5bd4b571d22a8c] Merge branch 'for-linux-next' of git://anongit.freedesktop.org/drm/drm-misc
git bisect good 1a4255ede07a967e57115b54da5bd4b571d22a8c
# bad: [756b44529e2ab179e4dd6f6358b5c351e1bbe5d3] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect bad 756b44529e2ab179e4dd6f6358b5c351e1bbe5d3
# bad: [f26873a2fc786251765db3e0ced8e1424b862059] next-20220705/sound-asoc
git bisect bad f26873a2fc786251765db3e0ced8e1424b862059
# good: [fc34ece41f7183d522d15dc4189d8df6e8e23737] ASoC: Refactor non_legacy_dai_naming flag
git bisect good fc34ece41f7183d522d15dc4189d8df6e8e23737
# good: [3d313f09f31490cec9d5251b59adeb6542c944cc] drm/fourcc: fix integer type usage in uapi header
git bisect good 3d313f09f31490cec9d5251b59adeb6542c944cc
# bad: [a41afb357f09cde0714db9d590458c7bb6d90ca2] Merge branch 'for-linux-next' of git://anongit.freedesktop.org/drm-intel
git bisect bad a41afb357f09cde0714db9d590458c7bb6d90ca2
# bad: [88ef4c5bb36bf60b317b74d8652c7766c9272a7e] drm/amd/display: Apply ODM 2:1 policy for single display configuration
git bisect bad 88ef4c5bb36bf60b317b74d8652c7766c9272a7e
# good: [ff15cea338d2c78e0086d55c8a9dd637a5dd3ccc] drm/amd/display: expose additional modifier for DCN32/321
git bisect good ff15cea338d2c78e0086d55c8a9dd637a5dd3ccc
# good: [414e9f520e897818302a6b1729aa2dad8cc928ca] drm/amdkfd: Asynchronously free smi_client
git bisect good 414e9f520e897818302a6b1729aa2dad8cc928ca
# good: [4bdb9d6501763e83bacbf26846754c567773a1fb] drm/amdkfd: simplify vm_validate_pt_pd_bos
git bisect good 4bdb9d6501763e83bacbf26846754c567773a1fb
# good: [e72f03f4bdc4f3a251343cf343bce28c28cbac2a] drm/amd/display: Add missing registers for ACP
git bisect good e72f03f4bdc4f3a251343cf343bce28c28cbac2a
# bad: [90f33674a0756a6f0907b8f6350cec3f7be4032c] drm/amd/display: Prepare for new interfaces
git bisect bad 90f33674a0756a6f0907b8f6350cec3f7be4032c
# bad: [85f4bc0c333ceed24cbc9f69a2a77fab1ae3d4d1] drm/amd/display: Add SubVP required code
git bisect bad 85f4bc0c333ceed24cbc9f69a2a77fab1ae3d4d1
# first bad commit: [85f4bc0c333ceed24cbc9f69a2a77fab1ae3d4d1] drm/amd/display: Add SubVP required code
