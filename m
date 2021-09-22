Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D7DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35D160249
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A35D160249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186D76EC18;
	Wed, 22 Sep 2021 15:21:34 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EF56EC18
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 15:21:33 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 c42-20020a05683034aa00b0051f4b99c40cso4055552otu.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e53o8BTTMpWGc/YFimYF1BKmO44erYRBoEPAE/EpAac=;
 b=QI0o0KSfdqc4r+v2goWEj+AoUkbZioNEEUbOJTndmxYBzfdYnsX1joJlWuUU4hqFvV
 iUSNB3tgrzO6m7Bgm+6wqy5cIvvBpmbRPFAuDKGE5nfKDGIFy1jrxFenWXEDL3QJz8Me
 hULflgBdF8e/D2OBsp4pEkS6R7I+/RSfOyQk4cGWINp63UU5f6lsQ1T/DTBA+9mhQDQT
 Waa0fSpnmIGPzqGmmW7XKFvU0TmpSCJ2PkMoBAuRzeLtgPSj1tB1zD8phk9WxYwib8iA
 iJEeqFywNVL0vkOXhWh3cJaZ2ZbIOyXc0pWxjmqpa/mYp2eGo4BQBAO/dLDrOcFlxPdb
 OpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e53o8BTTMpWGc/YFimYF1BKmO44erYRBoEPAE/EpAac=;
 b=YlZLfSdHwh+S3CowZ3PUYBZR3cC5hX5w7XhP/oIbeQH8FKdJ53dtO6Ovd7/kDpOEnR
 1mDW0Ma9TgeTTDrrzJxTi8bjo4ym0JzVC5E7NswzfOZjB6DnI3lzu27fWSpomIfkNxEm
 0TPQ/E4TMDixElqBI/h5hwA0mMqobMZZYDTwebW+nMM+nRjqxLXTqbwPvZlqBLHzGg2N
 mt8FSYvBbGG3DC4+rdVpcamZ+IbPxvOpX5PZ+XGvv1bJWG8PfXuXy/yLnSzv277L9Vkl
 gbzsusnaV0DxUpCT4yie2m5vbgAUaoVbcFiGVPQBgv8qOyu37WOc9e2XvX9TCfs60BpR
 5YTw==
X-Gm-Message-State: AOAM533wTPk4BAPY25PVuVoTqCYMTFhB9G4ZBMnf20LejGYO2gU67uWB
 K+SzH0xiIcxNu6LxqJgYU01A05YHMtyUtzpr6XI=
X-Google-Smtp-Source: ABdhPJzIKfC3cDeNw7QNJAOVBPahhhv1Y8CMHnxcntCshxLx+wXC7SIUjILMdRiGRrs+hk/FW7tns00Bj8LeRg5KT3A=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr365741otd.200.1632324092204; 
 Wed, 22 Sep 2021 08:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-29-alexander.deucher@amd.com>
 <deee930b-0214-e165-e23f-93a6ffd150a0@amd.com>
In-Reply-To: <deee930b-0214-e165-e23f-93a6ffd150a0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Sep 2021 11:21:21 -0400
Message-ID: <CADnq5_MgT8Kn5bUTFDjaaHhTFKXGi9MRK+sJCqPfdv-NZi5Vcg@mail.gmail.com>
Subject: Re: [PATCH 28/66] drm/amdgpu/nv: convert to IP version checking
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 22, 2021 at 3:32 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 9/21/2021 11:36 PM, Alex Deucher wrote:
> > Use IP versions rather than asic_type to differentiate
> > IP version specific features.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/nv.c | 75 +++++++++++++++++----------------
> >   1 file changed, 38 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> > index 0dc390a7509f..57be517d70bf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -180,8 +180,8 @@ static const struct amdgpu_video_codecs yc_video_codecs_decode = {
> >   static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
> >                                const struct amdgpu_video_codecs **codecs)
> >   {
> > -     switch (adev->asic_type) {
> > -     case CHIP_SIENNA_CICHLID:
> > +     switch (adev->ip_versions[UVD_HWIP]) {
> > +     case IP_VERSION(3, 0, 0):
> >               if (amdgpu_sriov_vf(adev)) {
> >                       if (encode)
> >                               *codecs = &sriov_sc_video_codecs_encode;
> > @@ -194,29 +194,27 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
> >                               *codecs = &sc_video_codecs_decode;
> >               }
> >               return 0;
> > -     case CHIP_NAVY_FLOUNDER:
> > -     case CHIP_DIMGREY_CAVEFISH:
> > -     case CHIP_VANGOGH:
> > +     case IP_VERSION(3, 0, 16):
> > +     case IP_VERSION(3, 0, 2):
> >               if (encode)
> >                       *codecs = &nv_video_codecs_encode;
> >               else
> >                       *codecs = &sc_video_codecs_decode;
> >               return 0;
> > -     case CHIP_YELLOW_CARP:
> > +     case IP_VERSION(3, 1, 1):
> >               if (encode)
> >                       *codecs = &nv_video_codecs_encode;
> >               else
> >                       *codecs = &yc_video_codecs_decode;
> >               return 0;
> > -     case CHIP_BEIGE_GOBY:
> > +     case IP_VERSION(3, 0, 33):
> >               if (encode)
> >                       *codecs = &bg_video_codecs_encode;
> >               else
> >                       *codecs = &bg_video_codecs_decode;
> >               return 0;
> > -     case CHIP_NAVI10:
> > -     case CHIP_NAVI14:
> > -     case CHIP_NAVI12:
> > +     case IP_VERSION(2, 0, 0):
> > +     case IP_VERSION(2, 0, 2):
> >               if (encode)
> >                       *codecs = &nv_video_codecs_encode;
> >               else
> > @@ -511,14 +509,15 @@ nv_asic_reset_method(struct amdgpu_device *adev)
> >               dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
> >                                 amdgpu_reset_method);
> >
> > -     switch (adev->asic_type) {
> > -     case CHIP_VANGOGH:
> > -     case CHIP_YELLOW_CARP:
> > +     switch (adev->ip_versions[MP1_HWIP]) {
> > +     case IP_VERSION(11, 5, 0):
> > +     case IP_VERSION(13, 0, 1):
> > +     case IP_VERSION(13, 0, 3):
>
> Odd. Two cases replaced by 3 - are there two versions for YC?

The versions of some IPs changed with newer silicon spins.

Alex

>
> Thanks,
> Lijo
>
> >               return AMD_RESET_METHOD_MODE2;
> > -     case CHIP_SIENNA_CICHLID:
> > -     case CHIP_NAVY_FLOUNDER:
> > -     case CHIP_DIMGREY_CAVEFISH:
> > -     case CHIP_BEIGE_GOBY:
> > +     case IP_VERSION(11, 0, 7):
> > +     case IP_VERSION(11, 0, 11):
> > +     case IP_VERSION(11, 0, 12):
> > +     case IP_VERSION(11, 0, 13):
> >               return AMD_RESET_METHOD_MODE1;
> >       default:
> >               if (amdgpu_dpm_is_baco_supported(adev))
> > @@ -1042,8 +1041,11 @@ static int nv_common_early_init(void *handle)
> >
> >       adev->rev_id = nv_get_rev_id(adev);
> >       adev->external_rev_id = 0xff;
> > -     switch (adev->asic_type) {
> > -     case CHIP_NAVI10:
> > +     /* TODO: split the GC and PG flags based on the relevant IP version for which
> > +      * they are relevant.
> > +      */
> > +     switch (adev->ip_versions[GC_HWIP]) {
> > +     case IP_VERSION(10, 1, 10):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_CGCG |
> >                       AMD_CG_SUPPORT_IH_CG |
> > @@ -1065,7 +1067,7 @@ static int nv_common_early_init(void *handle)
> >                       AMD_PG_SUPPORT_ATHUB;
> >               adev->external_rev_id = adev->rev_id + 0x1;
> >               break;
> > -     case CHIP_NAVI14:
> > +     case IP_VERSION(10, 1, 1):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_CGCG |
> >                       AMD_CG_SUPPORT_IH_CG |
> > @@ -1086,7 +1088,7 @@ static int nv_common_early_init(void *handle)
> >                       AMD_PG_SUPPORT_VCN_DPG;
> >               adev->external_rev_id = adev->rev_id + 20;
> >               break;
> > -     case CHIP_NAVI12:
> > +     case IP_VERSION(10, 1, 2):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_MGLS |
> >                       AMD_CG_SUPPORT_GFX_CGCG |
> > @@ -1115,7 +1117,7 @@ static int nv_common_early_init(void *handle)
> >                       adev->rev_id = 0;
> >               adev->external_rev_id = adev->rev_id + 0xa;
> >               break;
> > -     case CHIP_SIENNA_CICHLID:
> > +     case IP_VERSION(10, 3, 0):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_CGCG |
> >                       AMD_CG_SUPPORT_GFX_CGLS |
> > @@ -1139,7 +1141,7 @@ static int nv_common_early_init(void *handle)
> >               }
> >               adev->external_rev_id = adev->rev_id + 0x28;
> >               break;
> > -     case CHIP_NAVY_FLOUNDER:
> > +     case IP_VERSION(10, 3, 2):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_CGCG |
> >                       AMD_CG_SUPPORT_GFX_CGLS |
> > @@ -1158,8 +1160,7 @@ static int nv_common_early_init(void *handle)
> >                       AMD_PG_SUPPORT_MMHUB;
> >               adev->external_rev_id = adev->rev_id + 0x32;
> >               break;
> > -
> > -     case CHIP_VANGOGH:
> > +     case IP_VERSION(10, 3, 1):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_MGLS |
> >                       AMD_CG_SUPPORT_GFX_CP_LS |
> > @@ -1182,7 +1183,7 @@ static int nv_common_early_init(void *handle)
> >               if (adev->apu_flags & AMD_APU_IS_VANGOGH)
> >                       adev->external_rev_id = adev->rev_id + 0x01;
> >               break;
> > -     case CHIP_DIMGREY_CAVEFISH:
> > +     case IP_VERSION(10, 3, 4):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_CGCG |
> >                       AMD_CG_SUPPORT_GFX_CGLS |
> > @@ -1201,7 +1202,7 @@ static int nv_common_early_init(void *handle)
> >                       AMD_PG_SUPPORT_MMHUB;
> >               adev->external_rev_id = adev->rev_id + 0x3c;
> >               break;
> > -     case CHIP_BEIGE_GOBY:
> > +     case IP_VERSION(10, 3, 5):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_CGCG |
> >                       AMD_CG_SUPPORT_GFX_CGLS |
> > @@ -1218,7 +1219,7 @@ static int nv_common_early_init(void *handle)
> >                       AMD_PG_SUPPORT_MMHUB;
> >               adev->external_rev_id = adev->rev_id + 0x46;
> >               break;
> > -     case CHIP_YELLOW_CARP:
> > +     case IP_VERSION(10, 3, 3):
> >               adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> >                       AMD_CG_SUPPORT_GFX_MGLS |
> >                       AMD_CG_SUPPORT_GFX_CGCG |
> > @@ -1247,7 +1248,7 @@ static int nv_common_early_init(void *handle)
> >               else
> >                       adev->external_rev_id = adev->rev_id + 0x01;
> >               break;
> > -     case CHIP_CYAN_SKILLFISH:
> > +     case IP_VERSION(10, 1, 3):
> >               adev->cg_flags = 0;
> >               adev->pg_flags = 0;
> >               adev->external_rev_id = adev->rev_id + 0x82;
> > @@ -1374,14 +1375,14 @@ static int nv_common_set_clockgating_state(void *handle,
> >       if (amdgpu_sriov_vf(adev))
> >               return 0;
> >
> > -     switch (adev->asic_type) {
> > -     case CHIP_NAVI10:
> > -     case CHIP_NAVI14:
> > -     case CHIP_NAVI12:
> > -     case CHIP_SIENNA_CICHLID:
> > -     case CHIP_NAVY_FLOUNDER:
> > -     case CHIP_DIMGREY_CAVEFISH:
> > -     case CHIP_BEIGE_GOBY:
> > +     switch (adev->ip_versions[NBIO_HWIP]) {
> > +     case IP_VERSION(2, 3, 0):
> > +     case IP_VERSION(2, 3, 1):
> > +     case IP_VERSION(2, 3, 2):
> > +     case IP_VERSION(3, 3, 0):
> > +     case IP_VERSION(3, 3, 1):
> > +     case IP_VERSION(3, 3, 2):
> > +     case IP_VERSION(3, 3, 3):
> >               adev->nbio.funcs->update_medium_grain_clock_gating(adev,
> >                               state == AMD_CG_STATE_GATE);
> >               adev->nbio.funcs->update_medium_grain_light_sleep(adev,
> >
