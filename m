Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549E0EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 15:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF9610E6AF;
	Fri, 21 Jul 2023 15:47:59 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CEB610E6AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 15:47:57 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a479e7a37dso1461453b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689954477; x=1690559277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85BEVu4yQdhInWHjBPNn/bUdJhVBiL/B5hoGlXbtQnQ=;
 b=UfU33fGHSy87HgdkmMlQAqg9vR7xlzd5Vcw+ZqIUVoOhV5ImK5apggHbgJ/etBauaU
 ptl/07DxVUxNst/MyBPQz7NI55XahpK8pXEia7IqBFWm1Oqo9YcSUGQbziudnlIXRWDl
 AKhgxvHZ09sB6i/rNb8++hvXuuAKD2KRP4T2U3hfXc3R7dzw253q1neb4J/2hlV9LloW
 BixP+2CmYaKXqp0lseNCN1lSojUIiTkWD6rHfzBDxDFpAT0bnLbKqiOqre0LPdUzlkOA
 rwToD6c4Jdrytl3eehvcdbnrZYs4dcXCinzdSHlIWvdA5ca1LTr9t1KA4KXc2PO9jUFF
 v8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954477; x=1690559277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85BEVu4yQdhInWHjBPNn/bUdJhVBiL/B5hoGlXbtQnQ=;
 b=koZjzGMBSercmEk7dy2JWzO5Lwai5aTBZOcqQv3DX9OUexBliuH/+HgoCmM6tAEiWJ
 jUOZk+sWVB53dPJlKoJXsoTt0tEBxKhcAellzywYmRMia7kld0NIH1kdd+rxQHarFt3n
 0K/o12pnM5lbymJ8g2O7N9jkgsaqFIitwpsSQHs5Vm1jG5HObYhUjAn5Aq1GNwhvyhtx
 rQfuc2GzpZHr0YQq4ygfdpnJWV0MDWaJWZmmFqA5VFkk+Au/SZsK1FcQ5giihhN4YUsH
 S5QCbkSigQbwoxEnVH+uuGbM+rXVVp6yOUaOIkYQiHVNWOScb44nQJloqb8EGS9J0O2X
 KaQw==
X-Gm-Message-State: ABy/qLZORS95+vHzrubPORyj1nhpEpzU21onxYygKGw/Y1KWgnG/fIk+
 eASYM/GNbaDZww06sPoGuaj3q1ZOHNHl93seMFU=
X-Google-Smtp-Source: APBJJlE/RRfy/2JXiahuX+7/L9bWZm70AmvtHOV5SKdDHjS9uJ2Ijtsve26XT3f2xiOGU5p0ojQ03HpKbWXRlIhi4JE=
X-Received: by 2002:a05:6808:14c9:b0:38e:a824:27d3 with SMTP id
 f9-20020a05680814c900b0038ea82427d3mr3154456oiw.27.1689954476846; Fri, 21 Jul
 2023 08:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <0a4b4a77-75e0-4a1f-a944-6ea5c75a2bb9@moroto.mountain>
In-Reply-To: <0a4b4a77-75e0-4a1f-a944-6ea5c75a2bb9@moroto.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Jul 2023 11:47:45 -0400
Message-ID: <CADnq5_Nnok5tPbcuVqTJX+t3u4mdTFFjiC60et=19O7=Rt5T+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Unlock on error path in
 dm_handle_mst_sideband_msg_ready_event()
To: Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Alan Liu <haoping.liu@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 21, 2023 at 10:57=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> This error path needs to unlock the "aconnector->handle_mst_msg_ready"
> mutex before returning.
>
> Fixes: bb4fa525f327 ("drm/amd/display: Add polling method to handle MST r=
eply packet")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 1abdec14344e..943959012d04 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -707,7 +707,7 @@ void dm_handle_mst_sideband_msg_ready_event(
>
>                         if (retry =3D=3D 3) {
>                                 DRM_ERROR("Failed to ack MST event.\n");
> -                               return;
> +                               break;
>                         }
>
>                         drm_dp_mst_hpd_irq_send_new_request(&aconnector->=
mst_mgr);
> --
> 2.39.2
>
