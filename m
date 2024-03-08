Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11869C54E58
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 14:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32081120B6;
	Fri,  8 Mar 2024 14:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RN1a66c+";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00789112160
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 14:30:27 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1dd70a43f7dso2621765ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Mar 2024 06:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709908227; x=1710513027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAQDD3+MtaHdwr4iNybahx5ntwNaJj1mD3fCVoMolRI=;
 b=RN1a66c+9HFfLBVHr8V30fxaZqzVy0tSwqSCMogige3chiXsMp/LpkY9T/j5Cvz7TJ
 Pi7fsmjCq6AlM/YlxKNnczBQ3XJFA54fXyf+m7zSvebf9c05adW3f1k4VnnPELpmTqAR
 iG2K4YewRvCJmHBEEuVGGYK8fXT3gvZn7BpS0DljgJb9vhsPEfBpI/PxUGg4I6Te2KIL
 7s4q+6yz5et+efeoF8wrwaF0oc8RaWozRxnOk8Y1GRK41pA/Y3E5VPW17GRXFE1u26wJ
 PPOoYujWQfcqPIhYGbgZehXLaa5wCpuSUSaJMnrT8FdDcAT0GYIeQ+VLVUf9+Hdseprk
 sgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709908227; x=1710513027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAQDD3+MtaHdwr4iNybahx5ntwNaJj1mD3fCVoMolRI=;
 b=P/mMGXUcBBvBoamNGybpM1/68fTBiPEGv5UmxLnmTHHrToGD4UpntXFKt5V4m7OMG2
 4aSkv8r7Zo3bO/egBYrsPI+AIM+8eXGQmEN5BIQfnCr9M/+y2HY8gAedPEsy7mUrs2U4
 JzsL5ECREVuFL05HpR+T3lOiCBWiSciGj3WScXR6zHMBkgqL8cWwTNPLQKLj9J2Epwzc
 9CtyFa1CupYGNRBMrRZFDSiINq9nxEO5rCevFKfyUX9wwHMYKVQ+4CR4VIpg12UHMqGY
 A/0mxVfdvWdzGH/+jnQHWQxp/Bl4/W22xKnEnd/spFMJeOdS5x26/Y+h350Ge1G2PMQE
 1+Gw==
X-Gm-Message-State: AOJu0YxMMAVISY/QLdhGw5EfENCN5IWGzur3Vk5WfZQ3j5pgOlFak/Na
 PblJ1d4HQShLcS1D0b+UbgFgFNNbZfybbT7uuxqUdx4qVnwqSqkDkkXrk8LLnPOoogzky5I98KH
 DIS4i72XM+S2At11s2x671gSc0pQ=
X-Google-Smtp-Source: AGHT+IE8Z3vKLL3tfTEIwY/dA+oAW6fulj2Iw57UwGHQF3NfPMdk++2fYmhln+Xv1AwYjYZk80TvgsQgK9j7MskFyUM=
X-Received: by 2002:a17:902:bf01:b0:1db:4941:f703 with SMTP id
 bi1-20020a170902bf0100b001db4941f703mr10316081plb.15.1709908227079; Fri, 08
 Mar 2024 06:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20240308032527.1031907-1-li.ma@amd.com>
In-Reply-To: <20240308032527.1031907-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Mar 2024 09:30:14 -0500
Message-ID: <CADnq5_Nyfh0pMcCx4JiqwB2Vqk4XGWerOW+KoOYbwtrz0AuzYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable smu block for smu v14_0_1
To: Li Ma <li.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 yifan1.zhang@amd.com, lang.yu@amd.com, tim.huang@amd.com, jesse.zhang@amd.com
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

On Thu, Mar 7, 2024 at 10:43=E2=80=AFPM Li Ma <li.ma@amd.com> wrote:
>
> add smu 14 support for sum v14_0_1
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>i

I think we should hold off on this until the rest of the smu 14.0.1
code lands.  Otherwise we'll be enabling an incomplete implementation.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index a07e4b87d4ca..54a0414f22f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1896,6 +1896,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struc=
t amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
>                 break;
>         case IP_VERSION(14, 0, 0):
> +       case IP_VERSION(14, 0, 1):
>                 amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
>                 break;
>         default:
> --
> 2.25.1
>
