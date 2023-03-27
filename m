Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F2EC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 18:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF39010E37E;
	Mon, 27 Mar 2023 18:42:08 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCCE10E37E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 18:42:07 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-17aceccdcf6so10271901fac.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679942526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLqRL+GduVToT0LH5XcyIJMVhrCIJDoubeUUYSb9eKQ=;
 b=owihmBIKEBIFIzDSYRzcfeOaGM3bQEbpDLj7Xq9QzOSUJ5XTpWNOPp0Q2uWuY2diVc
 mrwTvQtjMAW9G4slwDnj75YzP1JycdTQxAybDogDCU82sWsRlYA0mGxRdt3CaPsshNXn
 Pql0r6c6f4PUJSPDq8ZTw4goPfpjoYNXtfFyetp+RE0VkNt3X7s2/SyNnGxlUoEMIsxX
 LJg2U/undCAhzbXbWeqCA2T+a7OSBhuNljjyVJLO8RR3IW3pY2Rp7S85S2q1kLPGpb1B
 Bviu02t8JdCc8AzEApiFQ61bAyIrIp1nJI0At75Bqv21jT3AbAJC1kWVIcuwE0P7Wmfo
 dmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679942526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLqRL+GduVToT0LH5XcyIJMVhrCIJDoubeUUYSb9eKQ=;
 b=Rf8jytgLvZtamfv+XY11LC+1SEOYVb2uH3ILrYlTTWjmkK2lqo+102d8lqcJ522wz2
 RC1i/WfBTFPTWhP5oTN3biW6ycj/f+l5AVu5TUZYU8XizRHHQ2gQok/M8j+lIiA0a1Xx
 HNMKN5/nZgYMZ9eN/R9vEMjkTBBugbxkodM0Uu7snt2Ly+CNWFjPdobm4kfj/cXH2zcT
 nxLvvwwlu+rP1dGhjCE0St6YAR4eIThSFEqSaNlsBPxao6Fj1hnml3BA3hPdkcbbf97k
 UNhVoJonmdD/V1xUx9oHLou64Og8nidhCZpghK+McrL0nk7+vL3v4IyeLYaUvTHVSD0Q
 jRrw==
X-Gm-Message-State: AAQBX9ew0jrCcFQoDXK+ZOsHBqzVBiLcpOwhxe/eNwqZkvEWwnfFR+0w
 s/tOd92aKvZzpUfv2WcP7qhHSCresvzkCUgIb6IvFSud
X-Google-Smtp-Source: AK7set+htAGoikSL5vOA23t7AWRni04xTRUdr7jSrMKv15sH2wIQNJacKQyrOjBYYadexYzcqb/8el/RhlAHm1wqht4=
X-Received: by 2002:a05:6870:f816:b0:177:aa31:79d6 with SMTP id
 fr22-20020a056870f81600b00177aa3179d6mr7148008oab.4.1679942526624; Mon, 27
 Mar 2023 11:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230327181040.1972784-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230327181040.1972784-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Mar 2023 14:41:55 -0400
Message-ID: <CADnq5_PkQyPDk7xTEOTs7anXKZz+GKBkBn8N8hLukrPVuFLkTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove initialisation of globals to 0 or
 NULL
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 27, 2023 at 2:11=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Global variables do not need to be initialized to 0 or NULL and checkpatc=
h
> flags this error in drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:
>
> ERROR: do not initialise globals to NULL
> +char *amdgpu_disable_cu =3D NULL;
> +char *amdgpu_virtual_display =3D NULL;
>
> Fix this checkpatch error.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 917926c8dc5f5..ece8033dbad29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -149,8 +149,8 @@ uint amdgpu_pcie_lane_cap;
>  u64 amdgpu_cg_mask =3D 0xffffffffffffffff;
>  uint amdgpu_pg_mask =3D 0xffffffff;
>  uint amdgpu_sdma_phase_quantum =3D 32;
> -char *amdgpu_disable_cu =3D NULL;
> -char *amdgpu_virtual_display =3D NULL;
> +char *amdgpu_disable_cu;
> +char *amdgpu_virtual_display;
>
>  /*
>   * OverDrive(bit 14) disabled by default
> --
> 2.25.1
>
