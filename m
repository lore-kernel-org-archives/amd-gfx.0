Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AAFFF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 13:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C9C10F332;
	Thu, 30 Apr 2026 13:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dZQFEAu5";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BBF10F332
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 13:19:43 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so606058f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777555182; x=1778159982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/4v1r8MF7GDXD4pKlMtYyt2PHC0hli42HFWXrDxv5g=;
 b=dZQFEAu5noFY7MNQLuEM1zpxVqDDnLVfcYAupj4Q/t82vKpcMNm0TX20iKWElZzpz3
 DuDvbeE0Q9KpEg25D7fdUiZMPGXFmNcIZkJj4adjdIaHcFkv3WWnFv/cIWx7zx8KuaVp
 cnK99zj5MNAnDWfCw/MgU9Ekx+60CML5GRidH8uoEpO8V7JmoyddkeyeB74w52UpmPZy
 3LWia5+fT5CULZRS3erRd8rofdZr3MiiO+mTDOz/ezXcEw/h1NViO65sRmiBDzCqApiI
 6nX0+pnP7myOPqAs8Q0AoFgRNrKbNK+YcuGd0rJwKx15ciYOOLyZ/hbIJ8Pk+cACpbcn
 yESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555182; x=1778159982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L/4v1r8MF7GDXD4pKlMtYyt2PHC0hli42HFWXrDxv5g=;
 b=WhWGEr1hIekGZfvyQhJ0a0nENhxA9KHJ/VGCbadO8XgJK3DKxOQTpb0494nYLVazsa
 Dk4Hj93iK5BYI6OmyaXl36bTGGajcLkr/9T+tQeJJ/5FQBpvJBftfGMdvz5nhDgOFPnR
 YAFnLljN0yPVhpxlh8SS9bCMViFS152pVpCvcfA5rz5bmOLHL5fZcGcCBEFedf9uI7mE
 Ay55R7zD22ENdNURAfpxfmjVp8s6obZag7kucEQcIbEbEhAgIz+jQa3LxdgykGVVQLyn
 07qJbt9RRaGSsPsldcE7SgDB6SKtiBeUydfjxpc2pYpgWam0ObAzKxhPvgSvGVtA09iU
 VNMA==
X-Gm-Message-State: AOJu0YxXifDSvdglFBkOGqFwVpqozP0ZJTw3oQqOJcbMZ0qa5K7aIxT9
 9gEV38pWpD8c44eWrPhDf6P4KJrWP3QRxeB4EPu9aBIF/dZzlcC9rwEUfKGqxA==
X-Gm-Gg: AeBDieu1oUgfcQCqfjYSqSkYSn8icRcalzGBsvQUG4xNdewgdM63peRnboLKiDXqI6u
 T5X0Yl6geYvtGLYjLcZ1QfKMWcX7JrosLBUY52HLutjBk1Ua3tiUNEV1rJrYonvgO3aUs6OOlqL
 Q7EZds8fE+uYu+1wJvuFfXvRn70tyMjxyUZU6X/7SCxDfX6upzD6PXO/jBDvBpod13velsMxPor
 Pdgq6TwLFlkYcMFfWJXSlW+7IZyyTbHOueE/v9tF9uPTkc12MBIrJhOSegtp0Wjo8eIuGWe7I8p
 0QeRoF6I5ad/2DizqOKyFN1OJxNOWq6QlHHbrJtoJqFBuQmdp5frQNc8msmdETQgJ1AuoLckbO8
 mEkvksFy4CRuap9/D128Yb2z9yWAlygoLkSh40XV1ceNmvVOWhEE6h1n0mosKItFadgvqQrxcmO
 a3gosgF22fPuF902bYspMAbdD9EedhGPTYjpSPWjt/fXhSbkM+FTEE1C+bemckQ6E3JziJrocyl
 J48xh7SOInWl3g=
X-Received: by 2002:a5d:5d10:0:b0:448:9299:14bc with SMTP id
 ffacd0b85a97d-4493a45dd1bmr4716991f8f.0.1777555182199; 
 Thu, 30 Apr 2026 06:19:42 -0700 (PDT)
Received: from timur-max.localnet (netacc-gpn-7-154-214.pool.yettel.hu.
 [176.77.154.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7218622sm13052432f8f.21.2026.04.30.06.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 06:19:41 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/pm: add missing revision check for CI
Date: Thu, 30 Apr 2026 14:20:52 +0200
Message-ID: <2343400.vFx2qVVIhK@timur-max>
In-Reply-To: <20260428145620.1480646-1-alexander.deucher@amd.com>
References: <20260428145620.1480646-1-alexander.deucher@amd.com>
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

On 2026. =C3=A1prilis 28., kedd 16:56:18 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Alex Deucher=20
wrote:
> The ci_populate_all_memory_levels() workaround only
> applies to revision 0 SKUs.
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/1816
> Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr
> (v3)") Reviewed-by: Kent Russell <kent.russell@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thank you Alex!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
for all 3 patches in this series


> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c index
> 69d8b05ef2457..6e89a032e3dcf 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> @@ -1333,8 +1333,9 @@ static int ci_populate_all_memory_levels(struct
> pp_hwmgr *hwmgr)
>=20
>  	dev_id =3D adev->pdev->device;
>=20
> -	if ((dpm_table->mclk_table.count >=3D 2)
> -		&& ((dev_id =3D=3D 0x67B0) ||  (dev_id =3D=3D 0x67B1))) {
> +	if ((dpm_table->mclk_table.count >=3D 2) &&
> +	    ((dev_id =3D=3D 0x67B0) ||  (dev_id =3D=3D 0x67B1)) &&
> +	    (adev->pdev->revision =3D=3D 0)) {
>  		smu_data->smc_state_table.MemoryLevel[1].MinVddci =3D
>  				smu_data-
>smc_state_table.MemoryLevel[0].MinVddci;
>  		smu_data->smc_state_table.MemoryLevel[1].MinMvdd =3D




