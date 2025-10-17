Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D288BCCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 17:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599C210ECB3;
	Fri, 17 Oct 2025 17:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EfY0Wmij";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468B610ECB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 17:33:15 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-290bcb326deso3392925ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760722395; x=1761327195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkACIkLh3m/QcMeTkoNdFNpMKhxK8QrXoeSkhzyHmmE=;
 b=EfY0WmijQaaZBwxLCzkMslw17aE9kavQ2lSnUMjzLLw+fm+eDDyyXI7pzLMmp3M/uK
 u5tc1sVwvtv2h5glYL7OYIDacppo7abl9ZiVdKtZKyRr3RtczYvI/CUPeHaGaQQdZjMr
 T+znSZJQtf6Y14BYS/slmLLz9zqDb3WB6gE23Qe/mCCx5K5rSIlpdoSHqC8Rut0rUv1I
 zHNnK10IRiVtoFr9kUJJdKsCNdMGg8h7LP/0d7pr115ONMG4gFh3ORUWwIP0lpuZpWnV
 4yxryI8SBhiB4SdIg+4PaKniDkmHTMlMgTZ3BhSnw12QgHXXTTN296qIONIY6/4wHdK0
 C78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760722395; x=1761327195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkACIkLh3m/QcMeTkoNdFNpMKhxK8QrXoeSkhzyHmmE=;
 b=nu/4MlzdoJ35g89W49ZUBaIMmCZbiDigPetcmmDEuRZ55zx+p2qWJqUPc5AfxVRK4O
 rDgy8DsDMqWGZkop9TWuIofXfxNBYl/Ntg7txptPzgaiOOts06OjbZ869ItLWlfy5bm2
 nloUijcOKqCHy3Pkyywily+1xGzUHt0TEbcWQ0bYdeacDQUcP6ICSZH/xn3aYU9oCnnu
 d5zRgFANKtIyElHJVP6EyyY27uLn353yMcP6djHfq97ZlPdft+0LkdHu0kAYsvpOYHE7
 ssRApFOtgFaHoipGsk0ousOSrVJUi5gBEJYozzh2t1eZzB2NNDbgRkxEnfQ57Koj4wzF
 kBSw==
X-Gm-Message-State: AOJu0YzVXzm/h7dzoQpOqlEy73pL3AEhPDS7KkxaLYNaVwJQqgFSsHa8
 +Afe9MMxXo3czRP0c1CCpZk0aU6G25wOnTvNKGcau2ozehlQpnH58KsiBnsW1NbjMWOQosq+uaQ
 SdqtnC4om2ml22EqkIJahVAQVg0i4k+M=
X-Gm-Gg: ASbGncszZ1bAlYowLDkSrT6MlK9mOwpHEs22mCDfxIJPr4BGFwuulZJtawOGeSomQ2C
 PkEpjrdeG7oNlWoxHcgeC/TAi4vMt3Dm9HfLwj6Q31pCX2YUE6koI+XXKpocA0AiG5gnXDb+wGk
 sv8OwMSFmMUht43RPxp6dsTvJEGfRiKkbrw1RSPsqeyUigWbF5z6xxEEEBtJk6hXwLbHjdTczgi
 qk6/jeT/mIFnWDnv4BAs6+GKDy0JK9HKaG9vfnHKrnOBXdCsM291rR21hM77tnJ7bwHsIs=
X-Google-Smtp-Source: AGHT+IGOFMk11I9SM7PeKxG7mjEUcYKIHhoMB2eFHA/o0ESZkHL+KoYk4FI/gXdX3Clfrxd6kRcl43hiBfd+1DwLbdU=
X-Received: by 2002:a17:902:f550:b0:290:aaff:344e with SMTP id
 d9443c01a7336-290c9d07528mr33879235ad.2.1760722394680; Fri, 17 Oct 2025
 10:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251017043209.3591423-1-lijo.lazar@amd.com>
In-Reply-To: <20251017043209.3591423-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Oct 2025 13:33:02 -0400
X-Gm-Features: AS18NWBZCzCf9HlHkDSn3hIcIp0kvL5jDy-c6wYV6wEiP9FohfCTUFJydqxJL0s
Message-ID: <CADnq5_OKu_e+Qm7QuVT81eUO1KatP6n5b+5iWDNB68-_C_hr3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove unused members in amdgpu_mman
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Oct 17, 2025 at 12:41=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Discovery related members are now part of amdgpu_discovery_info.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index aaa3d8c7172b..054d48823d5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -83,9 +83,6 @@ struct amdgpu_mman {
>         uint64_t                stolen_reserved_offset;
>         uint64_t                stolen_reserved_size;
>
> -       /* discovery */
> -       uint8_t                         *discovery_bin;
> -       uint32_t                        discovery_tmr_size;
>         /* fw reserved memory */
>         struct amdgpu_bo                *fw_reserved_memory;
>         struct amdgpu_bo                *fw_reserved_memory_extend;
> --
> 2.49.0
>
