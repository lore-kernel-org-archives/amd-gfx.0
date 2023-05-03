Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F410C77B78
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C616C10E2EC;
	Wed,  3 May 2023 15:02:33 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA4C10E2E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:02:31 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-38e975c853cso1782501b6e.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683126151; x=1685718151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMhmkdzDhFCznPp2OMfKXw8Z27Gtff5284DqcZhpMoM=;
 b=lMadOY+LK6Zu45kOhM8gyDaOC5b3Dgf1R4qZImSkuXhsIfqlMYUMcFIbDmyfPoTcnP
 E86+HecEgHB+YkzYHXPjaO6HT0oSW4LxKxkdCuGzElH1X6vTG7ABWA1Hfv4C4qj+KlNQ
 MEcOcgtAPEPUU+gHfQrYOj4RT7ioex1jcontPJP8xqW3xwy+V0Oi0YMdnHZ/axmqKBfQ
 FOlUI6RQJNGi/KL1t7wGI86S5/K+ak2qR1F3iWj/jvXx/dOg1xPitxyaMH+nOOi+r/ZH
 pzo/QCG4Z4ZabO5na3ux74I7z7oPAAw8cdOzMrqm+SSSREw+qhJ1iKxc/fNHQlW/6BSj
 fAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683126151; x=1685718151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMhmkdzDhFCznPp2OMfKXw8Z27Gtff5284DqcZhpMoM=;
 b=CRmKVxdbqE2fkAf4of2hYmzhtV7pjyptF0HNGCHN2uuw8Bt3tXIRTDkK2gsLPIV89w
 DGW45lZmf2tZiMa1AlfweVQx9+BV1x6ef+2RgnNvj/U9SQe/cRHDDTYwHQyyc5q1+dtH
 7rfEo1jZ+LMSjoKIOGDJJPeKHLSD1wHextymbEZVLdvWw2wFSMAtb/eoMk6gXbKALs1S
 tkXlTnuD/ycBTMkcTMgvu0A2K8GAGWp86Cej8gSnsR6HcOSotKwiBHMe0LfNSbd5Iq0r
 oHspnWHTzDg+L6k/KRr1DJB1YuiQltfP89TRaZ1bVPBE5o09nr3uA0QAtrzBTq3JCJGx
 hpZw==
X-Gm-Message-State: AC+VfDxPBTbrjGB52MN1eREvvgFOmMjjp/hQ3rpFNPdXRP+ODDfsCXeY
 4fskCUpYdGm49LD784oR/SxpvCJQflAi6iEVmbfkmQoc
X-Google-Smtp-Source: ACHHUZ6wFER6V3GFP+wwLderoGuLjEPaUeUvFToV3Uy3cOFBeJtdIU6fM7rojvc2CsBUdcwGF9e9dWAJVwgtZfxYfPE=
X-Received: by 2002:aca:1c18:0:b0:38d:ea6c:66a1 with SMTP id
 c24-20020aca1c18000000b0038dea6c66a1mr132628oic.35.1683126150694; Wed, 03 May
 2023 08:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230427183429.599578-1-alexander.deucher@amd.com>
In-Reply-To: <20230427183429.599578-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 May 2023 11:02:19 -0400
Message-ID: <CADnq5_PU-jyoadJzF7cs1L9KQ6q3bPzvbESTx__BbjTs75ET3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: drop invalid IP revision
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Apr 27, 2023 at 2:34=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This was already fixed and dropped in:
> commit baf3f8f37406 ("drm/amdgpu: handle SRIOV VCN revision parsing")
> commit c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
> But seems to have been accidently been left around in a merge.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 0ba013275dc1..76ceca05452e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1939,7 +1939,6 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)
>                 case IP_VERSION(3, 1, 1):
>                 case IP_VERSION(3, 1, 2):
>                 case IP_VERSION(3, 0, 2):
> -               case IP_VERSION(3, 0, 192):
>                         amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_blo=
ck);
>                         if (!amdgpu_sriov_vf(adev))
>                                 amdgpu_device_ip_block_add(adev, &jpeg_v3=
_0_ip_block);
> --
> 2.40.0
>
