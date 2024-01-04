Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674BEC47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 14:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25EC10E496;
	Thu,  4 Jan 2024 14:18:38 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9373510E48F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 14:18:38 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dbcebaf9a9so292673a34.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jan 2024 06:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704377918; x=1704982718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFyeXzhcbf6RF19nq9A7WS0cTvtT8nPdsRm5jwN059o=;
 b=PzyPMVWxu5MnoroCWj4j7F3XprFjWVuqEXNz9lHBh4jbSWVYxXhgiC9gEa1ylO3xNY
 djREkggkQZfB2/fF6xz8y5Fx36KOYLWz0tV+N3s3x7+5/WqmPA2FOQEvWg/qtlPQOcw7
 ZeT3vz/KsfojvHy1sH69QFhfHtMXHYUxeoJ0IQgCHfFKb5TsrlHVUWQcOEHdwvGZxkJm
 l+Jcn2aEegU3i4sdOKuhyXTnv9Vsr+Hrw10P6GHFNdpVqMNocGn6U5rhyALTd0vvm30n
 exLLENzyFM0ta/eDhDhitP4ZiGSMLNBkZ91PekDXKXpGOA1MpEplti54rV8XSB7fWWP7
 gbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704377918; x=1704982718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dFyeXzhcbf6RF19nq9A7WS0cTvtT8nPdsRm5jwN059o=;
 b=mOOLXkN7y1DPCShN6jwwyaNUkIFYDLpQ6aigvuPNhWJdsJlTLMeGqvofc1nktanHWZ
 xqyN7SEX91qWjdLwAvQDjF10DqhpRKdtj61gDzbFU5SKhMQtW+YY6CUxT48focmLtT0P
 VNvQtR5AVbEp0wHZVF6EdBIsABOl3RXmFkmzFC6WnCpUYhKoz8CYFkubbinHyqxxGd8B
 7DTHVTVD8GWgO+1nHypaeknSNQyjzcaE/GpzJ4plcMQFbRwQPTFnTW8D+TKJ6bWHHJS+
 SOwOwizDuNPw5ncrVVfFJYw+FIgfSQ/DmOA3gbAPyDEim+Yhhq7pdjH95Y/skAKyPVry
 pNHg==
X-Gm-Message-State: AOJu0YytqcZbBJ2rYorIKE3JlCsmb2sbG2uqIONmMgqb79sdT6CfrGCY
 5cESOKvBl3Rg9UaHagFrpwvrkuaH2jNzzrof7Ns=
X-Google-Smtp-Source: AGHT+IF2g/vnSg4G/PQnBqjngB7mQMKX7TCJXLT/8jbh/wxNUj4p2qkPo2DDtF2Dco810VcBirdLvUHWBwacZIsN8BY=
X-Received: by 2002:a05:6870:c68a:b0:204:60fd:8112 with SMTP id
 cv10-20020a056870c68a00b0020460fd8112mr655975oab.14.1704377917683; Thu, 04
 Jan 2024 06:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20231226100425.3129745-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20231226100425.3129745-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jan 2024 09:18:26 -0500
Message-ID: <CADnq5_PjarkOhAs2wseVwgGg-ubGskP7REh=Bp3rUN6HJ+05Tw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Release 'adev->pm.fw' before return in
 'amdgpu_device_need_post()'
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 26, 2023 at 5:10=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
> 'adev->pm.fw' may not be released before return.
>
> Using the function release_firmware() to release adev->pm.fw.
>
> Thus fixing the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post()=
 warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Monk Liu <Monk.Liu@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>    release fw needs to be done only FIJI ASIC (Lijo)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 4b694696930e..33f37efaf373 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1544,6 +1544,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *=
adev)
>                                 return true;
>
>                         fw_ver =3D *((uint32_t *)adev->pm.fw->data + 69);
> +                       release_firmware(adev->pm.fw);
>                         if (fw_ver < 0x00160e00)
>                                 return true;
>                 }
> --
> 2.34.1
>
