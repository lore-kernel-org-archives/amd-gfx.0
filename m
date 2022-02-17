Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEB4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 15:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA2910E338;
	Thu, 17 Feb 2022 15:51:48 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A75910E338
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 15:51:47 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id r27so45421oiw.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UdV3hFuj5NlhQcY893fy+cS0jeu6vcwZ7hqAkbbJXjY=;
 b=llldqhHduSeBHO9qCbxU9jDBesd+RGdW8lmcTFkcnrWCyH29CCYj1/9QRsLIqFkjAM
 hEcMN/LF9lGgRWnO5a+/SoHCZML6Z7srbGTlyceyuLwlGDn2he6hN1UL2Ajy15owX6wK
 u8jr0tBSfXDB91ZdgldzmVY06ifAWp2yovBc1ONZ2/27AYVzSKEwp3E8v2/0ei9CySsn
 DGOXFRahmhYhB+sWUI6S0nPH4l6qqGj8oP1TqqNRtM7WrqbdLL22oCkL939DcTHJTSFk
 0H5ITEHYOiaXn27qP8YTcSW/tBia73/TfUmLm361U6b1Bp4GkpEU/u/F/TqZkrVR0Cd2
 aPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UdV3hFuj5NlhQcY893fy+cS0jeu6vcwZ7hqAkbbJXjY=;
 b=PXVoyzz3pwMvunonuephI6qDmVWn6aqTgroBDs6LILVK4FjXS2KfjTbWhK6a27c6uv
 fAni5PeXQ3QggyDbvjIjYWXvCQDFLp05M/ZoEpM1JhvzNfM+DjCo4Ke/yaXQE50wfoqb
 684vZNk+l/rIR5qHpVLz1uMubsRlz5oBkml56NjqxRW+fKV7WwfUzI2WjXx8V3e96YmP
 Gjfq55ScRVAWma0hkbV3dBvqBnzccX5IofVMMmB2HF8lN8WtSnsZyZmbeJZoTIjHrxVF
 ByBq9Ya7WagYBhBJPCWwVX4WwD4ra3VeXel+sGD3+8Fh7rHdRvKgxCwdZwxgY2amtdc0
 rPFw==
X-Gm-Message-State: AOAM5333lqGyM+Vpw65ljP+5QvWf7FLtatbqwQ4B9uhCQa3RoZFPgVxv
 nPH5K9ipqYX0gymzei9q0vsarG6IycB5+okoihmwTE+g
X-Google-Smtp-Source: ABdhPJwF5xSlDcJz7rHhnIvr1FDWqwEsdxx0dOID26Lp4V4d24m2urFilw4WZwnBf7F8NLzEPf87JAyWFtbrGbUlhPM=
X-Received: by 2002:a05:6808:f8b:b0:2ce:6ee7:2c99 with SMTP id
 o11-20020a0568080f8b00b002ce6ee72c99mr3102531oiw.199.1645113106875; Thu, 17
 Feb 2022 07:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20220217152412.825286-1-jdhillon@amd.com>
 <20220217152412.825286-2-jdhillon@amd.com>
 <5ac96026-1dd1-7c8e-b18a-5ec4a0631147@amd.com>
In-Reply-To: <5ac96026-1dd1-7c8e-b18a-5ec4a0631147@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Feb 2022 10:51:35 -0500
Message-ID: <CADnq5_PqUZqjsyYnKu4vYn6xygKAwaQg1ecrX_YPzhG90HnPuQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "drm/amd/display: extend dcn201 support"
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Solomon Chiu <solomon.chiu@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Jasdeep Dhillon <jdhillon@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <agustin.gutierrez@amd.com>, "Kotarac, Pavle" <pavle.kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 17, 2022 at 10:26 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-02-17 10:24, Jasdeep Dhillon wrote:
> > This reverts commit e4a10691948030fc92b11b563cf62144d8d7cb8b.
> >
>
> It would be good to have a commit description here that mentions
> that this is reverting the wrong device ID definition.
>
> > Signed-off-by: Jasdeep Dhillon <jdhillon@amd.com>
>
> Either way, this is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
> >  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > index a2a25d444574..0d0df7271732 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
> >
> >       case FAMILY_NV:
> >               dc_version = DCN_VERSION_2_0;
> > -             if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_1400) {
> > +             if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_143F) {
> >                       dc_version = DCN_VERSION_2_01;
> >                       break;
> >               }
> > diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> > index a8dcd6d439c6..e672be6327cb 100644
> > --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> > +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> > @@ -212,7 +212,7 @@ enum {
> >  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
> >  #endif
> >  #define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
> > -#define DEVICE_ID_NV_1400 0x1400
> > +#define DEVICE_ID_NV_143F 0x143F
> >  #define FAMILY_VGH 144
> >  #define DEVICE_ID_VGH_163F 0x163F
> >  #define VANGOGH_A0 0x01
>
