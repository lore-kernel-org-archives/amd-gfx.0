Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8186C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 13:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA7390514;
	Fri, 22 Jul 2022 13:17:43 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334C48FF98
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 13:17:42 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id mf4so8577606ejc.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8O/Lowp4UCQeUTL2u5dR4+bCnN306GyFrNzt3fdoQC0=;
 b=Kt58Mu/axyfcuw92DL4oxCsFU3glCiTXqmSEjTIVvEgLkmSCxrr3wAxUaRyjQO5xO7
 qq7GRC09B9TKdclGQdFeQEFVmK/x4NXbDstg7RPzaPiaBZHxjg4mD65tPyCXha6h1wWT
 8/yZ/4n5ZrXshIAN55zssfpSyVWWiOOiQ1k6oeTD8KbStRMl6c+P9z5FbZYi4yfHoQnV
 EYH84qyU1HhOAhhUKGv+M0M12YdRkCTwGJ6S3FO+PtossjwDhXQQcbxyVnzrby6XdNdS
 b5a7jFxwCkR5iYjc1qtrSJoY5Cq2FIMvib7o6+yEhgj3j421LAtEkOhy8yWZh5SzZz61
 JJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8O/Lowp4UCQeUTL2u5dR4+bCnN306GyFrNzt3fdoQC0=;
 b=T7Pl7TOmCdz9orqRA2kDs6Do3xgcE+COpCWB9XLdVck0oX18l3xzABpiFNexWsQkOJ
 BCXGS+7L7dfhxvH0xqjLwTtedcFU/OeU6ykRoZqSFOaTEchuW8U0AUjMZ4X2E9IpTYch
 X8ifphVFHcRu0+Qewe2cqVmtX0tyoRqUr1sJ1uCBP/ZaPRJcP/hhrF4Nwaw3RDEUXb6H
 eNFz0i+ZvVWWuzWqt87UZDFiWEwuaQXYXArVvZSPctG13bV9qgbxHVIgxaSLJ9BH7g8L
 RFr/0yY7dj8N7zHHnz3f2uowwMlGASAVbFTmU91KZCCOwmKokrArD4zRR6TU9GC2I27a
 5UcQ==
X-Gm-Message-State: AJIora+UVvhHG/uNaH7xzlMpR9Nr+1QY0glwpBa1QZNrvB8Yt+GvtRm3
 vyut5wJlJQz70hthE/C+w/hK2lSu14li2vNwnDgAziCGV6w=
X-Google-Smtp-Source: AGRyM1sfTLu3Qs4nqMEUO3DQ2qVW/0gKMzO5f0RDfzuD/qhqGuIiqEylmhbhhC3me6H89AEdI9bqz0S2TjCaLYnrHyU=
X-Received: by 2002:a17:907:2722:b0:72b:6a93:bf9a with SMTP id
 d2-20020a170907272200b0072b6a93bf9amr449394ejl.424.1658495860714; Fri, 22 Jul
 2022 06:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220721095210.37519-1-horace.chen@amd.com>
 <20220721095210.37519-6-horace.chen@amd.com>
In-Reply-To: <20220721095210.37519-6-horace.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jul 2022 09:17:28 -0400
Message-ID: <CADnq5_PNO6b0k9qH5q2gPCfwb=vt4LjNytJSN7UjP6-m0EKgYg@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: sriov remove vcn_4_0 and jpeg_4_0
To: Horace Chen <horace.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 21, 2022 at 5:52 AM Horace Chen <horace.chen@amd.com> wrote:
>
> SRIOV needs to initialize mmsch instead of multimedia engines
> directly. So currently remove them for SR-IOV until the code and
> firmwares are ready.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f559fda2811f..3f7e1d683df3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1900,8 +1900,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>                 case IP_VERSION(4, 0, 0):
>                 case IP_VERSION(4, 0, 2):
>                 case IP_VERSION(4, 0, 4):
> -                       amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
> -                       amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
> +                       if (!amdgpu_sriov_vf(adev)) {
> +                               amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
> +                               amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
> +                       }
>                         break;
>                 default:
>                         dev_err(adev->dev,
> --
> 2.25.1
>
