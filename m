Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A7FE7FDD8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 21:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC4EB10E2E8;
	Mon,  2 Feb 2026 21:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I6TRApKJ";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D9F10E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 21:17:37 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124a946a340so186831c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 13:17:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770067057; cv=none;
 d=google.com; s=arc-20240605;
 b=i3UiTNYHugOoWwgzusEMfi4oceAjUH0+6Vh6lj6tHNtMnsAgvncLsLHQL0vwtiuMzO
 SPPjxFEejWTONS7u+jTzfrE+kiDsBgfvwztf4nrH6QkRSFf3qxFUKIilPKMrK/pZ4cA+
 iwmrK/rt4qXRjmqnQYvTzegwPZIDBfTE5OQ9/L7ECkRRFh7kteWFUNEn8ESf6aInVuG5
 3i9mIPFsPTSobKyz4Tle6OWmR0I+YS4bQSeFLIjZP9sUt4NQSNQumKkUQOo63blI06YF
 1zCJX8Ap8Injn5NjpnxaAabGVPAnHA9kNBn6gb+hmE8TLKG7CHJZRSWJMLXJk3joLCx8
 SB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0SV5lFQVLfq6lTta1wvkYu3u85qntqubps/Gd8zU+so=;
 fh=jrj2zacaXiuElwmT/59HCjZUVEPuL3U3OF0ylmi9raM=;
 b=kEe/EXZl83P5tiJj600eLmb+f4GmcjDLO5mxvDEb44rqSv5XdDUOY4C4YOd0PCBsay
 fabbXuHovGa5fmaw2vPhsj8MKAzA2l6UiAPPTIbowefI4Gz5rN3OlxJdkGGyAb5dPGCt
 nsPTZclZ1iQln6o5+FRkICiuhodpW4KZO5rGcE2G7BPtUIOg43FrK86wZWAVe7HdPDb8
 IihHuutVWtznbQ/aLhUmoYeZS5kbz79Nsyt4Q6VFJ68fzrKLgm56zCGLLtW3P309EAVH
 GOzXhVt+xXuWChI4MTjyvEvm3NE5eVc8YwB6PdEX7TEhqN+7YHyuatqQyqlCOcwKDWkS
 hFuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770067057; x=1770671857; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SV5lFQVLfq6lTta1wvkYu3u85qntqubps/Gd8zU+so=;
 b=I6TRApKJcMkwps0r88HyOj5WKTr4EMbbAg9u3unDTiegUYO6HbrDPEcNFdhjm8xUss
 A6EhKmFKHP7miGk5Udv2IH1kGi5/iOYcKLfHfL+Ev2DAWgv68iLcCCmUacxva8ihZY/t
 A8FHYrXmXvUZDyLfqaqu3DSQbnmGtxvrSesuA4vHXPVh+GnUSHcterRX1gbdnMYgTxef
 7UNdq0AvYuNYhQfMtSbwfSo+kqZ3PI76MIfO0e3SCeCQ1fl7gfp+GbAWGr9oYhLrZhvY
 B0nAbfEd1ZEHy95wtw+d07LLsZdE/jCLJswIJeaISd7kmZa91Qvz3hPXsBgmNAIa21Oc
 d8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067057; x=1770671857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0SV5lFQVLfq6lTta1wvkYu3u85qntqubps/Gd8zU+so=;
 b=WXyDJR8bUlLUUogk5X/sKUL6PUNEPBxP2QJpDW1TtwTb6mdQFwsz8O10/VCDQfcecV
 VkDBK5pDwr4oYrN9/NLRiPEc6SoZO5RRlqwdlk7coKtDZgoMPbU/KcCCgOPjh2iIdrxr
 CiaozANTCb088ENWgjcCR0D7p21N4ZIDTq//K24jni/Cm3KzJlDM42L9b0UOS9FQdk9w
 T7r+s4TaiR8XqM+q25zE1whWx9nk/TlkyqiAf+EJ1xb8GkUkaVzCl/rQVXaUqYEFgnQy
 8efINEZYH6Bxn5+N1GGMNzO1VxuslzdHDpFE7pFnb2F1hzirk4NBbFBkFPjQb18Tw2gJ
 Ynxg==
X-Gm-Message-State: AOJu0YzWZw+EnmdAx8Qq3EHBbBvFt3M6uZwa49tQZwQGwfsZ8FSBlPez
 U8fkQVp+fD6l3MUIRVEYy/iJra100QVXQ0EX+jXgESN5kTJf2SgbY+W5MZhqjBFfsozs1luKLUQ
 CCsDKDTmKXlvhumwbX6kp9/t4nSeLch0=
X-Gm-Gg: AZuq6aK+jUZitx8/DU4TkW3uWnAyORF3oF+XzPRRntNHE1yUHpRjz27xu/TYtHWscGq
 Cgtqx64UKWP+U85EmEx2PmFtziIY7pGHlan/0taOQn7f1I9m2ny8osNoLBexVHW6A5oW64zfkz+
 97b6N57HTt/3NI69og5QxhmWmthV8xQQgZoBZt9ALs2qmaxgAextNQ3oQ49mZ8nhCXSmmbLHnuG
 JMiFqsXP3PlJl8966tPOvgzARJ+kzQKtE973m+7Vt9dVUkHBnU17OrkI5blPCIQg9QT6J56
X-Received: by 2002:a05:7022:ebc5:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-125c0f79ed9mr3335378c88.2.1770067056675; Mon, 02 Feb 2026
 13:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
 <20260130084137.2906792-10-lijo.lazar@amd.com>
In-Reply-To: <20260130084137.2906792-10-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 16:17:25 -0500
X-Gm-Features: AZwV_QhF_mg-NgggkzPwWaMDQNzOx_Thf5Qf0GEtiCm3Pj5nuq8gT_pKC0OHiUw
Message-ID: <CADnq5_PAMVoC_mo-_jFZPktCrA7yZN8oWm9vcqkRet3h+_qPdA@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] drm/amdgpu: Add ioctl support for cwsr params
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.YatSin@amd.com, 
 Lancelot.Six@amd.com, jonathan.kim@amd.com, Jesse.Zhang@amd.com
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

On Fri, Jan 30, 2026 at 4:22=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
> address for save/restore buffer, and size allocated. They are supported
> only for user compute queues.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++++++++-----
>  include/uapi/drm/amdgpu_drm.h              | 11 +++++++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 71a323ad1ac6..9d77f72c4773 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -349,17 +349,20 @@ static int mes_userq_mqd_create(struct amdgpu_userm=
ode_queue *queue,
>                         num_xcc =3D amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>                                                          fpriv->xcp_id);
>                         cwsr_params.ctx_save_area_address =3D
> -                               userq_props->ctx_save_area_addr;
> -                       cwsr_params.cwsr_sz =3D userq_props->ctx_save_are=
a_size;
> -                       userq_props->ctl_stack_size =3D
> -                               adev->cwsr_info->xcc_ctl_stack_sz * num_x=
cc;
> -
> +                               compute_mqd->ctx_save_area_va;
> +                       cwsr_params.cwsr_sz =3D compute_mqd->ctx_save_are=
a_size;
>                         r =3D amdgpu_userq_input_cwsr_params_validate(
>                                 queue, &cwsr_params);
>                         if (r) {
>                                 kfree(compute_mqd);
>                                 goto free_mqd;
>                         }
> +                       userq_props->ctx_save_area_addr =3D
> +                               compute_mqd->ctx_save_area_va;
> +                       userq_props->ctx_save_area_size =3D
> +                               compute_mqd->ctx_save_area_size;
> +                       userq_props->ctl_stack_size =3D
> +                               adev->cwsr_info->xcc_ctl_stack_sz * num_x=
cc;
>                 }
>
>                 kfree(compute_mqd);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index c178b8e0bd3f..41a155fe2c01 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -460,6 +460,17 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>          * to get the size.
>          */
>         __u64   eop_va;
> +       /**
> +        * @ctx_save_area_va: Virtual address of the GPU memory for save/=
restore buffer.
> +        * This must be from a separate GPU object, and use AMDGPU_INFO I=
OCTL
> +        * to get the size. This includes control stack, wave context and=
 debugger memory.
> +        */
> +       __u64 ctx_save_area_va;
> +       /**
> +        * @ctx_save_area_size:  Total size (in bytes) allocated for save=
/restore buffer.
> +        * Use AMDGPU_INFO IOCTL to get the size.
> +        */
> +       __u32 ctx_save_area_size;
>  };
>
>  /* userq signal/wait ioctl */
> --
> 2.49.0
>
