Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25D3CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 17:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7879D10E877;
	Wed,  8 Oct 2025 17:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="STsHZlhx";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA2D10E877
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 17:12:12 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2697051902fso62335ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759943531; x=1760548331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yynVz2QoxeVL65TH+GlJK8DmzKS1ihQ7h9erHobNtcI=;
 b=STsHZlhx1z+wq94AIsQhNKbJ9Vh77obKdSyVNroiiVct5Jhn27f/930DFIO/8hzTet
 Ck5ZVeSHSPwwV7+cj93JI9OEYZH0Cgm2UKcQMyPX0UhJmiWJQtYaFHl/+vKMBWROmPu/
 NcdEbmT0WLQRB5bbWLrUq2oO1yzLSVfp7ew0JoQdg7YUGj6dp37bFZhFQVwX9cUxL/FC
 SZN1FNEQrYUdJ4zI2mxnXuFGEa0+dfvVe63D/rhWNQDi6BdRpmk7c6RzENPT1jBUvy24
 7z0MIOV9Wm9huTuwTji6iiFaDa5EyhHgY0xNDnr/CQiJ3BH3h/8fkOSFXluIRdj7/3jb
 wxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759943531; x=1760548331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yynVz2QoxeVL65TH+GlJK8DmzKS1ihQ7h9erHobNtcI=;
 b=HOzNZF8n+EKdM8LeBa2x11SCHfEQTdHkVVUFejBVX7pFwToP9OzKpb6xkEM3j9DEyo
 Pg2p1L5s6rHqsn0/O7b7LeqSsVzP2Lvrok/xhjln6neGt5RxmAy0v7O1/ZWy8K/xfFmV
 mWlljWO1qdEVGI5WO2+qpM4M1rOaA7y2ecCLvlREA/CjqxlArVxk1zA/cuuuF82Dstdl
 McLBpOX3HLvBf9AwlWvAOuUGPB4YYGUqnAz/WSEd/Tiau2e7wV0uhgWRskAonsarKs2G
 tEckj/fugXHbr6CepKcijGOXt9LalpyclietMvp9yMoM9iiCos9XcdPzElv+56zM0y73
 vInA==
X-Gm-Message-State: AOJu0YxrD4huMOvfvocAPCjbQRcmoyShcSyS/Te/QAvrzoVMQpCb2SoC
 dIjTIsFAnu2HtiWDtxzGV0q7quuTyh5Csa2uhZLK3Nm4XQz49iVr8B1Wy6E4V3gjzLrspTIalGU
 etpifqNCtu+aqL9HFY+v6LEqV5TUxbgpQ6wxQ
X-Gm-Gg: ASbGncspMyeRwoG+QTG9J0QKFsrgpnRkOTBQbyZjLCaYeM6bM3F/MUncgKs0wn9vLV9
 0M3xwDRjE3ssf2fqGs40JTxZL5p2Z4U3j8G91llf5oR8TSVdC+EZ3jMZ6yQeILvOI0b5B6W7y17
 KP5ExDgJ0bUZ7zWMbNwk/WRF76v2IBbLCfJ9zVMQURYK1vA82xJFnHlYJ6TD4w9D0JZs8Fggu/4
 wLNcOctszEuAQmOBbuub8LiBJv7iXD4M92CLbK4Ng==
X-Google-Smtp-Source: AGHT+IHcGqBcPKvKNQ5kxxlb3CJFZUQHxZbItCgXKUpbnH8tbX3w4tlhEQ7VAWXnGA7+hqMx+lLh9nrwwZ1E8gdYTVU=
X-Received: by 2002:a17:902:e88a:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-2902726664dmr29269285ad.4.1759943531547; Wed, 08 Oct 2025
 10:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251008164408.850834-1-jonathan.kim@amd.com>
In-Reply-To: <20251008164408.850834-1-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 13:12:00 -0400
X-Gm-Features: AS18NWCplSFoK9X9c7_OmA6ss7NA1dRMTuICkD6MWldRDQlMfUeAWxl0Zw5Te1s
Message-ID: <CADnq5_M_Rk9KX_5Vw+3pxPfrReKqhtF5rn+1P2LidFSJ5y7Wzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 8, 2025 at 12:51=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.com>=
 wrote:
>
> The driver currently only checks that the MES packet submission fence
> did not timeout but does not actually check if the fence return status
> matches the expected completion value it passed to MES prior to
> submission.
>
> For example, this can result in REMOVE_QUEUE requests returning success
> to the driver when the queue actually failed to preempt.
>
> Fix this by having the driver actually compare the completion status
> value to the expected success value.

This should be correct as is:

*status_ptr =3D 0;
...
api_status->api_completion_fence_value =3D 1;
...
if (r < 1 || !*status_ptr) {

Alex

>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index aff06f06aeee..58f61170cf85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -228,8 +228,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>                         pipe, x_pkt->header.opcode);
>
>         r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> -       if (r < 1 || !*status_ptr) {
> -
> +       if (r < 1 || *status_ptr !=3D api_status->api_completion_fence_va=
lue) {
>                 if (misc_op_str)
>                         dev_err(adev->dev, "MES(%d) failed to respond to =
msg=3D%s (%s)\n",
>                                 pipe, op_str, misc_op_str);
> --
> 2.34.1
>
