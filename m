Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A9EC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 18:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3966711B545;
	Tue, 19 Jul 2022 18:31:21 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9FF11A102
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 18:31:18 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id b11so28779849eju.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XCskh6yRk6lfp9CkZcY1gmNpxO9iIqKylSGgCMn/XKI=;
 b=AR3EUA1Sz18lDluv5cs1+XTX7Tu46xxQUQIV4kS6VdguXvl05N9uFG/pNcghDJg/dV
 e7BG8ndS8Asn2X1FkZztXcHDU0Uu4OH89f6+2t7DGlwmlV5yJoAGPQXny146Cg6nOjRJ
 kkRCOx3UoPQvmo6VMJGuuYjweD5vh6nd8hzR0KldRMvBIbjarzYrPawTG6tb60kzS4ow
 ed3E273BolZhrfRct8KpcV1fh4GBpnD37xOi3GT2ZUgsx9T3/wIX15Eie29zuvkaysD/
 AiFFGsx5sb4g89kcPWR4xKPTAaKBOGZ3nEPzE05I717gVKTFUFV6bDYmejbwQo6p3cYg
 nh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XCskh6yRk6lfp9CkZcY1gmNpxO9iIqKylSGgCMn/XKI=;
 b=qCOqLDWAj6ZUmyJq0Ti4okwggMj+NPR6VyakrdOztOl9s0zJdUd7aE272M3xBtnRLE
 QTbuzIa1TkMcrzUEAhq6HSPkFIQFwv7FxyqhIr9CtepNeKVCGpIUR/sa6IjXVP/hY+cH
 t7KGOH+aeuOzcWRYCjRxJJsd+ZPDw7K6fUvh8BJQ2mGwIQfEKWvRrC6b2Fe+6PJSwr+j
 LiaChhqk43z4sF0TiUD7A+MM19CgBUBSSaL/55cMfvwp9KJY3njaRMTqvMxk4Qn04shZ
 e2++KMl6s4+Ugzc4gnofCBDUObVk7t35BEZYSQYw+639Cml7vDznS4kSBzI3SwvTAlLw
 MVlQ==
X-Gm-Message-State: AJIora9H+prDa5O90+LeOBbotD9at8w1njU4H3eIdLBp5baw1pHJgtX6
 RgAXDnToc1TeQbN/ElCe44sQjXY/rd9FsgSPKsmPDh2K
X-Google-Smtp-Source: AGRyM1tsdWnrGWTTj/Yq2NZKBanCjXFbLedTf9SdezGRGeXftlHvhJ9VisO8vwwuBqA6yJ1PAhu/NZ2P2yZrAXwiVKo=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr32310824ejk.658.1658255476515; Tue, 19
 Jul 2022 11:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220719182646.23049-1-Roman.Li@amd.com>
 <20220719182646.23049-2-Roman.Li@amd.com>
In-Reply-To: <20220719182646.23049-2-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Jul 2022 14:31:04 -0400
Message-ID: <CADnq5_MjU_Lv3EZFkE552C8X75S+Wm96Vm+-QtMzVH_syLheYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add dm ip block for dcn 3.1.4
To: Roman.Li@amd.com
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
Cc: Alexander.Deucher@amd.com, nicholas.kazlauskas@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jul 19, 2022 at 2:26 PM <Roman.Li@amd.com> wrote:
>
> From: Roman Li <Roman.Li@amd.com>
>
> Adding dm ip block to enable display on dcn 3.1.4.
>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 0ba56e2ebf09..242d1847c4aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1716,6 +1716,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>                 case IP_VERSION(3, 0, 1):
>                 case IP_VERSION(3, 1, 2):
>                 case IP_VERSION(3, 1, 3):
> +               case IP_VERSION(3, 1, 4):
>                 case IP_VERSION(3, 1, 5):
>                 case IP_VERSION(3, 1, 6):
>                 case IP_VERSION(3, 2, 0):
> --
> 2.17.1
>
