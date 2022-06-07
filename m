Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D40C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 14:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBC210EF0C;
	Tue,  7 Jun 2022 14:00:39 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8299310EF0C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 14:00:37 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 61-20020a9d0bc3000000b0060b9bfcfe76so12951461oth.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g8qHb2y+TPBShs9EKwB0/tMjSo850QszdyqQE7Vn4o8=;
 b=UfYO4Lj6JxAAeEJRyslOOYVDf/G42ofTANuPtOqzk0HIVDDJQqERPU5zC32OYGItWs
 AJc1gnzmbdOoYOAPE6pU+czklEz28wR94OVmuYDgkNFqsojCEFU65cppoDqCEEhrpBXT
 rPPD+ZsgF4zQQcLS4DPmFxebzuTbx23P6+VsthHk5i1cSCBhIbCruMCTn2Po4aFPE7st
 2IOQXEH8fmz0OO00ehLJB8spiDB2VfuYYrkzVxBrV4MMIBxnyz45up1u5x9dVJHa6Ffk
 XKfZMR2yQwnsTPFd+tKbRcDx1EkzbJtKQI2mxHbqaJvH8ZU2Deps2d8neyt6MujsvCo9
 vToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g8qHb2y+TPBShs9EKwB0/tMjSo850QszdyqQE7Vn4o8=;
 b=68Ky25xjTn99TZ8lUzd4SbhsElz5rumr4nYaxquwVVCP8z54QNgLIl0+9ryR47V3m9
 iQKTo6t63/IM1P/QkphnRa28+yV35iwhZ5wR6t34s/vMN9H5mYfE0TxMd6hoZ6jnZxK0
 WVBnlyWbfe5QaGvLsw/d2MKIBQUx8O+cW8+yBaBnEgH9BE0GLkRmDWB5D3sgp0tM7RlZ
 1Jz6kP/3tbCPRa9nsrDHFPVK+Y68vuc5Z3FErhx9Ae+LZUPpqpBCA9ggCbZ0+zjzTyDP
 d2yD/gJHmiGXXCm+iO83NeCcVB/zdZwop4i8g46r8ek9TutAdIq5Ayl92+CF/qXhpo7C
 Ab3w==
X-Gm-Message-State: AOAM531v2/4Gp04GSr7MRGG0VcN0Ci8VzX8hIu+bMC71Hp+Lo1o9x3uD
 s3sTy/DSxGdmofVkwXji61iFFLxDJfh/IjQX6wo=
X-Google-Smtp-Source: ABdhPJwNpE0V5kzdN1VRrZ5qoB1YU3SXZaz8pHKsGtvBhn9dwDfIsFeP1NulOlIlDPYDauhJQp3yvyBcnCiWs7FMqSg=
X-Received: by 2002:a9d:7853:0:b0:60c:2ab:624d with SMTP id
 c19-20020a9d7853000000b0060c02ab624dmr2859842otm.357.1654610436635; Tue, 07
 Jun 2022 07:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220607082636.847593-1-chandan.vurdigerenataraj@amd.com>
In-Reply-To: <20220607082636.847593-1-chandan.vurdigerenataraj@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jun 2022 10:00:24 -0400
Message-ID: <CADnq5_OUvKuW0Z70km1HTFqn8KyZ0LXhLfm3mVqcDiHfUL2=EQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: Fix compilation issues
To: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 7, 2022 at 4:27 AM Chandan Vurdigere Nataraj
<chandan.vurdigerenataraj@amd.com> wrote:
>
> [Why]
> Getting below build errors:
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1419:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>                 default:
>                 ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1535:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>         default:
>         ^
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:3276:20: error: variable 'v1_5' is uninitialized when used here [-Werror,-Wuninitialized]
>                         for (i = 0; i < v1_5->number_of_path; ++i)
>                                         ^~~~
>
> [How]
> Fix compilation issues
>
> Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 3540b46765fb..25791ed0559d 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -1415,7 +1415,7 @@ static enum bp_result bios_parser_get_lttpr_caps(
>                 case 5:
>                         result = get_disp_caps_v4_5(bp, dce_caps);
>                         *dce_caps = !!(*dce_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
> -
> +                       break;
>                 default:
>                         break;
>                 }
> @@ -1532,6 +1532,7 @@ static enum bp_result bios_parser_get_embedded_panel_info(
>                 default:
>                         break;
>                 }
> +               break;
>         default:
>                 break;
>         }
> @@ -3251,7 +3252,7 @@ static enum bp_result get_bracket_layout_record(
>         static enum bp_result result;
>         struct object_info_table *tbl;
>         struct display_object_info_table_v1_4 *v1_4;
> -    struct display_object_info_table_v1_5 *v1_5;
> +       struct display_object_info_table_v1_5 *v1_5;
>
>         if (slot_layout_info == NULL) {
>                 DC_LOG_DETECTION_EDID_PARSER("Invalid slot_layout_info\n");
> @@ -3259,6 +3260,7 @@ static enum bp_result get_bracket_layout_record(
>         }
>         tbl = &bp->object_info_tbl;
>         v1_4 = tbl->v1_4;
> +       v1_5 = tbl->v1_5;
>
>         result = BP_RESULT_NORECORD;
>         switch (bp->object_info_tbl.revision.minor) {
> --
> 2.25.1
>
