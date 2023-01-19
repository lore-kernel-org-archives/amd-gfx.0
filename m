Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FC2C46467
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 19:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0577F10E9B1;
	Thu, 19 Jan 2023 19:00:26 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A2E10E9B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 19:00:23 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-15f64f2791dso3647682fac.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mxKKO/1nlfXluHwY2jiJ/vVtXmkE4xrUDsakKJES4xM=;
 b=eCiAZcZF5ESPyttEe8Xtzvwc+6kt3KTds2GTKYZyo1ygj6MJEJEudVqNrVj54eVDUL
 df204qzn5dya44RF3Dmw2mlq4grwM5VxlBi+9nF+fr6QOuyqA0thvH2WCoNq/QWs3l3p
 MLNgUtj5T1tTyt2HANI/hWN69xU5p67iPSqHzuPbgTMhbFA6FOV8KWJsQq0c1H+33OBK
 ZficWDE1LB8r0erwiczjqik+12GsJXbSeFW74ktpRCGLkZRWYmuZ7D7jZKANAfX+CQeq
 LEDGPBp2GG/gMrIaog1F6ivKG+mIQo6OdKhQmbL0Z+p1odPw/U+qxKN1G9CwPRf1yhpx
 tlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxKKO/1nlfXluHwY2jiJ/vVtXmkE4xrUDsakKJES4xM=;
 b=w49prj8aA2XxSID2jt40GgCEzrJLIkf0cn+1xvuEGUEp1srTjFmcK58TSqIqAVn3RA
 Y5GpbrwOHB6MCWtyvZoEACz/luy+8xy016o0Fvvkj10EOgc3EJ1a8ReKmNkycq7y/A8P
 qanSc2ejiqtfOAmDqL7PJ6VTr0TJs7SjBDOa0o/ScCLDhBog+vf37/esPOhm/yLfpbZE
 Grckj4q59FZ7d8mAkukcbgLyb3ohdJXBSIoWHA3othm4jRHwZrTkjuHKFltLX2XEU1a1
 fPQRobQI2Dvs42J31W+BmA6hbs4He1bpaLTuupSzg6bPIPQ7FRLqF2QFSzIMMx7tczbq
 +8PA==
X-Gm-Message-State: AFqh2kqVa624m1shWoO3uaLInFd/WHoCEjBKOmDKxA8xzVC6WayNUXy+
 nxqOfma2VhHBFnTYM1sN8raF9pnzApSNC8QZPE0=
X-Google-Smtp-Source: AMrXdXvz0dVYM4iEaTpzAbATEQSwKvW5Wp4K8rw6jbxwDFVvUAim+i0PqUagvL6LoAwbUPyHM4h/BsSC7lAK4ArzhRE=
X-Received: by 2002:a05:6871:4593:b0:150:d9aa:4011 with SMTP id
 nl19-20020a056871459300b00150d9aa4011mr976446oab.96.1674154822973; Thu, 19
 Jan 2023 11:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
 <20230110165535.3358492-22-Rodrigo.Siqueira@amd.com> <Y8kYKwU1Ky/b+3LW@wendy>
In-Reply-To: <Y8kYKwU1Ky/b+3LW@wendy>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Jan 2023 14:00:11 -0500
Message-ID: <CADnq5_M2Q+Z9NHCksR10nummiX3zkakVnB+WHGV-UcK_OeP0YA@mail.gmail.com>
Subject: Re: [PATCH 21/37] drm/amd/display: move dp capability related logic
 to link_dp_capability
To: Conor Dooley <conor.dooley@microchip.com>
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
Cc: stylon.wang@amd.com, Harry.Wentland@amd.com,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Arnd already sent a patch to fix this. It should show up in my next
drm-next update.

Alex

On Thu, Jan 19, 2023 at 1:55 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> Hello!
>
> On Tue, Jan 10, 2023 at 11:55:19AM -0500, Rodrigo Siqueira wrote:
> > From: Wenjing Liu <wenjing.liu@amd.com>
> >
> > Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
> > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
>
> I haven't done a bisection, but I am getting build failures due to code
> added by this patch (d5a43956b73bd in next-20230119) when running
> allmodconfig for RISC-V with gcc-11.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:233:21: error: 'union hdmi_encoded_link_bw' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>
>   233 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
>
>       |                     ^~~~~~~~~~~~~~~~~~~~
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:233:42: error: parameter 2 ('hdmi_encoded_link_bw') has incomplete type
>
>   233 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
>
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:231:17: error: function declaration isn't a prototype [-Werror=strict-prototypes]
>
>   231 | static uint32_t intersect_frl_link_bw_support(
>
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c: In function 'get_active_converter_info':
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1125:76: error: storage size of 'hdmi_encoded_link_bw' isn't known
>
>  1125 |                                                 union hdmi_encoded_link_bw hdmi_encoded_link_bw;
>
>       |                                                                            ^~~~~~~~~~~~~~~~~~~~
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1129:101: error: 'struct <anonymous>' has no member named 'MAX_ENCODED_LINK_BW_SUPPORT'
>
>  1129 |                                                                                 hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
>
>       |                                                                                                     ^
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1125:76: error: unused variable 'hdmi_encoded_link_bw' [-Werror=unused-variable]
>
>  1125 |                                                 union hdmi_encoded_link_bw hdmi_encoded_link_bw;
>
>       |                                                                            ^~~~~~~~~~~~~~~~~~~~
>
> cc1: all warnings being treated as errors
>
> Thanks,
> Conor.
>
