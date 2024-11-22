Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F388E69183
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 17:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225F610E180;
	Fri, 22 Nov 2024 17:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R4vrvq3i";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C623A10E180
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 17:00:18 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7247888f092so273012b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 09:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732294818; x=1732899618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2D50zqRCceUtlENR+EtBPWXD2SJ+8zh+9af3fElw6/8=;
 b=R4vrvq3indh96xMmctjflD54dxgdoi7XDIjnDxIp/20/6LC66vn/BRyRdqtz/tt7Em
 5YABImpIUI7Ido5SQMlqnbVkvPEyux+JCQQsyx9DrNcg3PodnRVm1yUrTT4jmeWgnDlm
 pQN4DXymBJg6EW0N0+WhnKn68+2z875SC6KK8JUdjYY+9HbarZ3+sx3jxzlaP6DsJpaQ
 nKSLmrcHh24IysXuUXCnMZAOeSrkWlce8gmUTRmrYoCG1Pw7emEshMcilPmvIoTkAx05
 Ko+XEZPu2HM2Scn5SlJ95MB1kig3Y89w+YRMnLotzuCVjH9Y5GqBOmCkynS1/zmxyQ/U
 hWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732294818; x=1732899618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2D50zqRCceUtlENR+EtBPWXD2SJ+8zh+9af3fElw6/8=;
 b=XA0L66unoYAspU+RUAzbLwQj0plyRUdumHALy7tVb+hyEmKyoyrPYfZ5+xHn2R8QeE
 1v4c/U5MBxU/ciXOHq8IkbmNCTdX2BQSuJPfdNCNmMPQduSYaYDrxGKb2GEmVg0b9qCo
 mWOTkJlE7ry9XEhWmWPze9dYzgJjTSfNMT7gqvUQrO9eNAP2cu6K7DpFbR7NpCgyS8xs
 vSjUKWhoRWCYZMOHiWABqTe/rJqJl7wIpOvqtEzy1b4938slCHVXToo4CkihL1RZlwQT
 FbCQLE74e5emLi/PopN6/01UC2VYddj47zBYcbNfyYjVzzxseFtK2fGjkWrlsMox+Iyf
 9u3g==
X-Gm-Message-State: AOJu0Yw/4wRGWhG6tU9LibkyK4Jr3R/IT1by+tacz5vfgBsqtRbv7iia
 UPgqjfEGsBshtELkryyPDDBoj8X+E57ieXoALxN61Ma00qknTFMW4H7VEVeXmDr/LalTgA67K0j
 T+rnZJPcm/omK9ILBG/hlV2M/jgf5pA==
X-Gm-Gg: ASbGnctzmdg62JduE609vhvnRYY+qCvfIBwj5U4DqI3vdkOjj6B5nGpmX3xXCEH/HvG
 hpsksBJ26yN6BRH/t02LT+fQn4CT14HE=
X-Google-Smtp-Source: AGHT+IGm9rulcpEagCPzS9BdybXKbTPHnr/N0rMMwvMWIKL6gBnprHDNycf7axD3PINAKq5UgJx0QZk7UIYDYX3HQwE=
X-Received: by 2002:a05:6a00:9299:b0:71e:6650:60f7 with SMTP id
 d2e1a72fcca58-724df677f84mr1907921b3a.5.1732294817641; Fri, 22 Nov 2024
 09:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20241122155004.3565-1-mario.limonciello@amd.com>
In-Reply-To: <20241122155004.3565-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Nov 2024 12:00:06 -0500
Message-ID: <CADnq5_MY8kwafb_-YxB9vBNyHe-j3tq-gu1SsLrBSz67C95vSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd: Invert APU check for
 amdgpu_device_evict_resources()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
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

On Fri, Nov 22, 2024 at 11:17=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Resource eviction isn't needed for s3 or s2idle on APUs, but should
> be run for S4. As amdgpu_device_evict_resources() will be called
> by prepare notifier adjust logic so that APUs only cover S4.
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> --
> v2:
>  * New patch
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 11d344166ba7..d511ba949dff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4744,8 +4744,8 @@ static int amdgpu_device_evict_resources(struct amd=
gpu_device *adev)
>  {
>         int ret;
>
> -       /* No need to evict vram on APUs for suspend to ram or s2idle */
> -       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
> +       /* No need to evict vram on APUs unless going to S4 */
> +       if (!adev->in_s4 && (adev->flags & AMD_IS_APU))

Will the in_s4 flag be set at this point?

Alex

>                 return 0;
>
>         ret =3D amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
> --
> 2.34.1
>
