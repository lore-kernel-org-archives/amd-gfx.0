Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83CBC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A67710EE88;
	Thu, 30 Mar 2023 14:20:51 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C1310EE76
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:20:47 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 cm7-20020a056830650700b006a11f365d13so8771467otb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680186047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rYiaO0VQeOoofLR0qzkYw1w7HBedC9p0jjwZ3g7568=;
 b=m6f/CfittP5EKhticYPgk+6wzrrf5NFTOPLFcGeWzswm6nva+opxD6IvBEV00+TeRW
 KO7lW7noN5NSsDyBhOsuSiYT07eVpoM3HhI/jqZ9yl4GmUSrRYnL/OvBF4NX30dsFsvV
 GHRSHZpKwAoZ6amaphvv3gIy3eZXKLGo9SHzMFRC4TyyGZ2W9UmrwpT5LoWWLXBqgEnv
 lo8L1S2+al0QMRvowQym+KGi7y2lKB84v72NDUDS9Bz4gNlf7VCJ3tQJyq5/L02fbB4L
 n1g5IMwR2FrGJXUH7I8/kP2OSAIXoFwnWjBUZQs2zBWCWONAwR7au8sK7RNM8q/iBF6Z
 wiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680186047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rYiaO0VQeOoofLR0qzkYw1w7HBedC9p0jjwZ3g7568=;
 b=CBzh0jehB3FZkIZtzkrHmlYoHktt+6B/uBmfgOow9UIOVY0yj1y0ZC4o8BrqEV/s+f
 8/vm03cvgdY6ce1nQAyVdlvZr2k5ym2CyzzV5y1XOOqb6nrdeG8RFZyk1V0XDArU9XpH
 I66iCWQXunsutLyeQba5QIAeEt/XoN3qHv2VNRwgoIilegVrs8AG89/rTImLUC4wCmar
 xvXfXW3FUsj5W8T7KoZlsWQd/G/8gnAoaF6HyG07ePH2UU3XzDX6nTU5br1HmeP1Ara3
 5izXwsUMbir5+hcsL5z2EgzNoMYymQotFwODUW79pxyZBnT3uC+Q6L4vKxUAC2SafyIn
 0haA==
X-Gm-Message-State: AAQBX9e8x9+i3P2yYNj6yw0YDcLqzvUGfozn10SawUBSKC9dvjteWtQ8
 0ogQv29rmsxa9IZccGx66MyZKHzoJ/rCn+zgq650jUd/
X-Google-Smtp-Source: AKy350amXaeOfL6sLYQTw5Rg1m76OD32Fwt+lHk2QNtj3FwvO/O6lfGg6Rw3QN2tE9K3X5PVPGHOY0za8JfyblyBcNc=
X-Received: by 2002:a9d:6c5a:0:b0:6a1:7f22:a821 with SMTP id
 g26-20020a9d6c5a000000b006a17f22a821mr335931otq.3.1680186047068; Thu, 30 Mar
 2023 07:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-3-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-3-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 10:20:36 -0400
Message-ID: <CADnq5_NKXAESwLgP9qT=En8YYzVMEyuDJZ3Sjeyq3iHoNJGxqQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] drm/amdgpu: include protection for doobell.h
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds double include protection for doorbell.h
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_doorbell.h
> index 12263986f889..6064943a1b53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -21,6 +21,9 @@
>   *
>   */
>
> +#ifndef AMDGPU_DOORBELL_H
> +#define AMDGPU_DOORBELL_H
> +
>  /*
>   * GPU doorbell structures, functions & helpers
>   */
> @@ -308,3 +311,4 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev=
, u32 index, u64 v);
>  #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>  #define WDOORBELL64(index, v) amdgpu_mm_wdoorbell64(adev, (index), (v))
>
> +#endif
> \ No newline at end of file
> --
> 2.40.0
>
