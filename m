Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3229A10D14AC
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 13:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A674910E6BB;
	Mon, 30 Mar 2026 13:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fIz7Al96";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3E810E6BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 13:16:31 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so39827775e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774876589; x=1775481389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1C10NA1cQG8ePlBzaiPYyKeha1tOz/zSCaYB7MJP6w=;
 b=fIz7Al96nJmqtovj7LhL+Jr+9QW8NiyhKBI6GqEJyO7rshjyr4s8TNBMhjGTKq9rEq
 ly3k/4acIKuz+zKOJIMsDfNoI3o23S9Uwqxy3jWhzTDmLVQKsx6xy7phEtXRB8k0iX5r
 p07BIjw7npTPHKTHBKGdLW1ghFF+umddFoTFnBjtnXbHKNIWZwi+558DST5c/vQNHVl+
 wUVVTMW1H+fAUrm0pmWc7RhdubIn1bHiRTJqLrdqny38GPSjA2CiC+mZG76KfrRRz1G1
 wdqGv15U7itYA/XKDBLWV1eB+A2y2M/mWqlDqg/GSBzDlo8q5IEyJbko3PPNCVbRX3l5
 3I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774876589; x=1775481389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a1C10NA1cQG8ePlBzaiPYyKeha1tOz/zSCaYB7MJP6w=;
 b=cfFT7b2wYUGNbAHC/gAmYwJalDj646+mT/yvMB76ROVcuL1LTsEFXaqtTGidZTTF29
 0hLrk+1SRcX3EwobHg6ItYIY+Psc1sy0xLgBYTwREWUGH2mHTVwG73LRKBzvH/XpvUXy
 E7UrXEUOD+95kXvY/vEdD7DZuyLvdTpC/dUeU8Ac5B8DIReIlVVU+c8rsx4K6icWwjcV
 WnLX72iGLteTP0jlwQToAwf3uTFG4VICKyy59D1U+VdD0ng+P9rEBqobOPC+/uVDFQPS
 kIby8ph+guUcvGOxRD7zfEhFsxcVNb6m8gc4gnJsUhz5zYms7ABpjPeG0fVCWkq8vIFI
 LNQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ9wjcHv2R4VsDEzDRLf6sITwOis3YVORjTXnxjZtLc4JOLNt6saMB4ND+Lc1iNzd12FGSTzJw@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn+PbQBQxLj7y37aYjfMQIqxOrudcUAhPvDAzo8pV6Lv5Go1Nf
 LfLrNCBtXI8bYo0NtIu2MU/evd0BukpS7EJelKfB22XTSkzgUvgN2bPH
X-Gm-Gg: ATEYQzxBHQtkIwE4xFDh85Y08US5W+hCf1OMvplppdCWS0FMVu4lMXJl/sCWK5MsiLr
 0rvH1QOpJXZh+KQCBM8R1LJV8+tqPe5tAvfmsVPjeB4iNgAt4854TEMpj3dcBMHokp7j6GBWrJ1
 KAGeISRWrvEXmf+yc1iSlB7gWZGRjtSfblBAFiiJ1lB/bRdHRhOTxfG0xv2Vx28SR3hNTmu0jJ/
 ZXZptvhjzZQx2fw29jCJLWU2MeLmywOIEQHZkaqV28J3h40dm3IfXBGoDskCQfbeObcvcZntKWs
 /B/VDXlt+2jzXVG3TWLyvTKRwYbLEZp1kz69jNEDdw6RAAdvbVnjpXFY6FMGAHYNMykKzZgIsg+
 KqQSViTnQ47T4njrmJyQ0mh+5zJDLlaF0Ha68B9FzaE2l8FVh7+DfFyqCPzaFLKD4u7yGMpA784
 CRu6aa6jKYNAjLJHTBrsRgbspaWdI1YHrOlFtLsDr+wKJrgssKbfe1pyeEeViiqUN0dem94igk
X-Received: by 2002:a05:600c:1393:b0:485:3c8f:e4d9 with SMTP id
 5b1f17b1804b1-487280a09a2mr210977455e9.26.1774876589201; 
 Mon, 30 Mar 2026 06:16:29 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4872718dfdfsm78504085e9.30.2026.03.30.06.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 06:16:28 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: stable@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
Date: Mon, 30 Mar 2026 15:16:26 +0200
Message-ID: <2312151.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <20260326234716.16723-4-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
 <20260326234716.16723-4-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Summer Time =
Rosen Penev=20
wrote:
> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
>=20
> It already didn't work on DCE 8,
> so there is no reason to assume it would on DCE 6.
>=20
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This patch is incorrect and should not be backported.

(Note that the error is already fixed upstream. For stable kernels IMO it's=
=20
best to drop this one.)

> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
> df69e0cebf78..7dc99c85b8ea 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc,
> struct dc_state *context)
>=20
>  	get_edp_streams(context, edp_streams, &edp_stream_num);
>=20
> -	// Check fastboot support, disable on DCE8 because of blank=20
screens
> -	if (edp_num && edp_stream_num && dc->ctx->dce_version !=3D=20
DCE_VERSION_8_0
> && -		    dc->ctx->dce_version !=3D DCE_VERSION_8_1 &&
> -		    dc->ctx->dce_version !=3D DCE_VERSION_8_3) {
> +	/* Check fastboot support, disable on DCE 6-8 because of blank=20
screens */
> +	if (edp_num && edp_stream_num && dc->ctx->dce_version <=20
DCE_VERSION_10_0)
> { for (i =3D 0; i < edp_num; i++) {
>  			edp_link =3D edp_links[i];
>  			if (edp_link !=3D edp_streams[0]->link)




