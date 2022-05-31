Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E53C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842DF10E19F;
	Tue, 31 May 2022 21:15:05 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D778C10E19F
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 21:15:03 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 w19-20020a9d6393000000b0060aeb359ca8so10434675otk.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YIAlLs8QzI/tbDBAr3JXM8TZDV227NgOGkAwmAlY420=;
 b=KspHddQDo7i98XIaGvCi/IjV3SF9amnkvR4tid0NTwtK8UjRMiY5YiCxxZ/K7XYeqw
 L95RjJHm3R0IaldZmpmsNfIY8tNHjh6AVhK1TqeJeB8Kma3VVRWpg8CvKl5APgpTFQr5
 wsc5C84W2XJGmROh5n/cVb/7Cx6hsy9WtGPNcd171dIvkE7XL1gumXj1unEmgqcsdf75
 wfD0aAJimMrp5ZPDZn27ZDefZPVilJARm98MLsoy00jT0H6hXhDqJ8qz7YOp2X2YCHCF
 2yw2FMOPlr/ZAzjXvEnFpPYoiz1Ft1zN6DnSly8tN6AWRZMMM/ymohteKRvq/kqVTdQT
 XI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YIAlLs8QzI/tbDBAr3JXM8TZDV227NgOGkAwmAlY420=;
 b=W4fbhlYvdvJ84xaTrIHoPbfoePFDe1c4BduylIFGvD23LlNT7D4lWDZgzxjeulBCkO
 kdpIZZ2ujegPJGBmoyrLTpeie0QyxnNjonfQk9UpVPkCgVGkWcOjXix7UTNCPIKzLadM
 LGeGBybQnWgP+agfb28lmGRzxHHhc9ROqwAs8Yju0Ow0kRb/Cyl/eAF3680d9YQyOba1
 wuRrGicvZ7btiLNBcipAPALuykeeeXoamN8suv82cfSt2SXpPJ0z7sipsvXv9s7gBHgQ
 D7LMru0BrPCWn4gj+Ubexdl/jzRvMt6N7cHZMk2btfrdOikDJw9aTG6T7l1FyAJRbgJH
 p2Pg==
X-Gm-Message-State: AOAM533DUvDDIB7GD+45B+O5uBe2E0/7IQTN9saAfiO8tJl1AUjlAgjA
 iUtJ9pGJ4z7h2TYqpPdkEMAhsKdpz5ctZkwh7gPQcH15ack=
X-Google-Smtp-Source: ABdhPJxd1qaztt1qj7NdwvETtkAaEgRz/G5WpRpn35+LegBaokygVWdWggEAnRHRWRjINNetMEt5iVUWTM6t1FXHJGw=
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id
 b24-20020a9d6b98000000b0060b0c54e22bmr18159980otq.357.1654031703092; Tue, 31
 May 2022 14:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220526175747.3044318-1-alexander.deucher@amd.com>
In-Reply-To: <20220526175747.3044318-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:14:52 -0400
Message-ID: <CADnq5_PwgiJHCHxKOmHT3TBB60=JoqHRBqq=XOdmUE2k=Kp-pg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Tim Huang <tim.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, May 26, 2022 at 1:58 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Set the default reset method to mode2 for SMU IP v13.0.4
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 9e18a2b22607..a400f5273343 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -310,6 +310,7 @@ static enum amd_reset_method
>  soc21_asic_reset_method(struct amdgpu_device *adev)
>  {
>         if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
> +           amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
>             amdgpu_reset_method == AMD_RESET_METHOD_BACO)
>                 return amdgpu_reset_method;
>
> @@ -320,6 +321,8 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
>         switch (adev->ip_versions[MP1_HWIP][0]) {
>         case IP_VERSION(13, 0, 0):
>                 return AMD_RESET_METHOD_MODE1;
> +       case IP_VERSION(13, 0, 4):
> +               return AMD_RESET_METHOD_MODE2;
>         default:
>                 if (amdgpu_dpm_is_baco_supported(adev))
>                         return AMD_RESET_METHOD_BACO;
> @@ -341,6 +344,10 @@ static int soc21_asic_reset(struct amdgpu_device *adev)
>                 dev_info(adev->dev, "BACO reset\n");
>                 ret = amdgpu_dpm_baco_reset(adev);
>                 break;
> +       case AMD_RESET_METHOD_MODE2:
> +               dev_info(adev->dev, "MODE2 reset\n");
> +               ret = amdgpu_dpm_mode2_reset(adev);
> +               break;
>         default:
>                 dev_info(adev->dev, "MODE1 reset\n");
>                 ret = amdgpu_device_mode1_reset(adev);
> --
> 2.35.3
>
