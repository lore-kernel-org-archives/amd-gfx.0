Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286D6FF885A
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 22:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC9810E89D;
	Mon,  4 May 2026 22:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iPSt5/1D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B7310E89D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 22:55:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DF1D60125;
 Mon,  4 May 2026 22:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58800C4AF09;
 Mon,  4 May 2026 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777935318;
 bh=GCZjVXztUXpk9sXFWNySAQb0yq79NvEMe81mTVjaUyM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=iPSt5/1DwvuuqYBL4COxhjDJUPhFYZIzqEEb/8rYPp3fkTgQg47DKd1WQPky6LiSP
 LpPtJeAhwVlb/mGqLhKzro2fu2elzJo5Nem0xd2LJplye5sInST85+Pl9dUhB1V4fr
 KZV6RfgrUvXazRYqJnb7+t0ORCVMjliwl9QArg3vVYgRw7ZVOR/oJdzKhASBijjoHp
 v00V8RSWsaqKoFFXd8ePhjnE53If2L4wAlPjCShHqL3/Hr7G78pK5t5K3kFS9ayeu+
 iwySSerhUDkhJp1i20XkFeRrkS2DhzbyR/49Z15xsoBFb8ev73XZtY8PTAL8l/vZSP
 7TORBXpMJ7C5A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id 4A3A8F40084;
 Mon,  4 May 2026 18:55:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-01.internal (MEProxy); Mon, 04 May 2026 18:55:17 -0400
X-ME-Sender: <xms:1SP5aTU5lUqjLvq1X60BeJ_5mzGiUVBnLQNoCoTYUTYEg3wXB8ozSw>
 <xme:1SP5aWbNWWGLZcVpvVx62wiTt_B_MH4fqfB4G8UIPi6a3F1QbpqEHD9F-DBFtD6PR
 AkkH_aeDk957nQ0M7yE3V3DUSUKImNI1h5M-HNbKX2OjwSfLnxaCek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddttdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
 uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
 jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
 qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
 gurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
 thhtoheptghhuhgrnhihuhdrthhsvghnghesrghmugdrtghomhdprhgtphhtthhopehrrg
 ihrdifuhesrghmugdrtghomhdprhgtphhtthhopegrlhgvgidrhhhunhhgsegrmhgurdgt
 ohhmpdhrtghpthhtoheprghurhgrsghinhguohdrphhilhhlrghisegrmhgurdgtohhmpd
 hrtghpthhtoheptghhihgrhhhsuhgrnhdrtghhuhhnghesrghmugdrtghomhdprhgtphht
 thhopegurghnihgvlhdrfihhvggvlhgvrhesrghmugdrtghomhdprhgtphhtthhopeguih
 hllhhonhdrvhgrrhhonhgvsegrmhgurdgtohhmpdhrtghpthhtohephhgrrhhrhidrfigv
 nhhtlhgrnhgusegrmhgurdgtohhmpdhrtghpthhtohepihhvrghnrdhlihhpshhkihesrg
 hmugdrtghomh
X-ME-Proxy: <xmx:1SP5afF7Dozjg3cJNaHAqqWFmzvj8XDKdJivjuYstIV3WIEYIu7QtA>
 <xmx:1SP5aWtg5mzhVV4aIskpP4Wzw_AI2M411JtKD5hMVeihty25XpLa3w>
 <xmx:1SP5aXTPIbJAfaPZSoL9Rb87VKu_5RG5GACrjZHPAqkbsJK_rL-Lpg>
 <xmx:1SP5aYOwHiuzhx7gTEgI0BPlmuZrrA-ktr0HjgQl07nUkIfAoGo1fg>
 <xmx:1SP5ad7eldUd8lxkFin3K04S_2JpGu4ERc-rpSxTf7EuhWFl2zq2Uj8P>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 25671700069; Mon,  4 May 2026 18:55:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 05 May 2026 00:54:56 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "ChuanYu Tseng" <ChuanYu.Tseng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, 
 "Aurabindo Pillai" <aurabindo.pillai@amd.com>,
 "Roman Li" <roman.li@amd.com>, 
 "Wayne Lin" <wayne.lin@amd.com>, "Tom Chung" <chiahsuan.chung@amd.com>,
 "Fangzhi Zuo" <jerry.zuo@amd.com>, "Dan Wheeler" <daniel.wheeler@amd.com>,
 "Ray Wu" <Ray.Wu@amd.com>, "Ivan Lipski" <ivan.lipski@amd.com>,
 "Alex Hung" <alex.hung@amd.com>, "Rafal Ostrowski" <rafal.ostrowski@amd.com>, 
 "Dillon Varone" <dillon.varone@amd.com>
Message-Id: <2c3edb6b-fb1c-4b5c-90d4-48d2aba7c986@app.fastmail.com>
In-Reply-To: <20260326030153.406612-24-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
 <20260326030153.406612-24-ChuanYu.Tseng@amd.com>
Subject: Re: [PATCH v2 23/30] drm/amd/display: Move FPU Guards From DML To DC
 - Part 1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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


On Thu, 26 Mar 2026, at 03:57, ChuanYu Tseng wrote:
> From: Rafal Ostrowski <rafal.ostrowski@amd.com>
>
> [Why]
> FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code that
> can manipulates floats. To do this properly, the FPU guards must be used
> in a file that is not compiled as a FPU unit. If the guards are used in
> a file that is a FPU unit, other sections in the file that aren't guarded
> may be end up being compiled to use FPU operations.
>
> [How]
> Added DC_FP_START and DC_FP_END to DC functions that call DML functions
> using FPU.
>
> Reviewed-by: Dillon Varone <dillon.varone@amd.com>
> Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 25 ++++++-
>  .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.h    | 17 ++++-
>  .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  2 -
>  .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  2 -
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
>  .../gpu/drm/amd/display/dc/core/dc_state.c    | 75 ++++++++++++++-----
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   | 13 +++-
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  3 +-
>  .../dc/resource/dcn35/dcn35_resource.c        | 10 ++-
>  .../dc/resource/dcn35/dcn35_resource.h        |  1 +
>  .../dc/resource/dcn351/dcn351_resource.c      | 10 ++-
>  .../dc/resource/dcn36/dcn36_resource.c        |  4 +-
>  .../dc/resource/dcn401/dcn401_resource.c      | 30 ++++++--
>  .../dc/resource/dcn42/dcn42_resource.c        | 25 +++++--
>  14 files changed, 169 insertions(+), 53 deletions(-)
>
...
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
> index 4e921632bc4e..5e95419d3798 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
> @@ -28,15 +28,30 @@
>  #define __DC_FPU_H__
> 
>  void dc_assert_fp_enabled(void);
> +bool dc_is_fp_enabled(void);
>  void dc_fpu_begin(const char *function_name, const int line);
>  void dc_fpu_end(const char *function_name, const int line);
> 
>  #ifndef _LINUX_FPU_COMPILATION_UNIT
>  #define DC_FP_START()	dc_fpu_begin(__func__, __LINE__)
>  #define DC_FP_END()	dc_fpu_end(__func__, __LINE__)
> +#ifdef CONFIG_DRM_AMD_DC_FP
> +#define DC_RUN_WITH_PREEMPTION_ENABLED(code) \
> +	do { \
> +		bool dc_fp_enabled = dc_is_fp_enabled(); \
> +		if (dc_fp_enabled) \
> +			DC_FP_END(); \
> +		code; \
> +		if (dc_fp_enabled) \
> +			DC_FP_START(); \
> +	} while (0)
> +#else
> +#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
> +#endif // !CONFIG_DRM_AMD_DC_FP
>  #else
>  #define DC_FP_START()	BUILD_BUG()
>  #define DC_FP_END()	BUILD_BUG()
> -#endif
> +#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code

This looks wrong to me. If _LINUX_FPU_COMPILATION_UNIT is #define'd,
it means the code runs within a DC_FP_START/END pair, and so doing
nothing will not re-enable preemption.

I think this #define should probably just be dropped. If that breaks
the build, it means the code is already fundamentally broken and
needs fixing.


