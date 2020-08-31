Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FC7C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3813520866
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 21:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTv55kk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3813520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E517C89CD3;
	Mon, 31 Aug 2020 21:53:29 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E07E89CD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 21:53:29 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a17so6530095wrn.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2RlpK2mOz+CLkXDK/vQTDlGCb8Ek+r+SG2m7l5STfrY=;
 b=GTv55kk49l9nzMD7ymcU/A26A29z0hXDV6cMZLqxFYhKrzDIqyOfkPxhg19X+VrKsM
 L4VTS0A1mCdYz0mnjY+lhzPFwwFNMRF5gdL+lhGCjO/f9i+H6aAhwmhAX6LQyN7eIzan
 eCBjPpvJI1+yWQozrRI+TqTcSPrxo090B7NCtY7TLJjEtVHkS5SRyb0UJ6racLjD5u/X
 ELrokGHcJtcCpnMW7n7kiqer233teUTv+BfzICtDlDd/tMWI6x1oQrD1BzwDXrncKFL/
 WLnLB1a3eAzUuXrsIEJ65HmfcG+7U+5fPm5ks7c2vsguKA+skgFD2qgD9FVp6Orq+/Uu
 v11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2RlpK2mOz+CLkXDK/vQTDlGCb8Ek+r+SG2m7l5STfrY=;
 b=m3sEvWZMnt7DesjjP21N2rJ+D57LhNuE3Uq6PDLHTvEPP2ZXRCfxHlNVbsMTDCLYQC
 +UCausmT3t+h5H6wPE+DGhnFXtQ1TkENpxrEvxtKRuiHLPJoDpW1MTSXOHSDDQz4g3dZ
 +G4Qyin1IkvNgMeopgQrwhclPAQyynf9N2fYgod5TEzWKwRk3Lww6g2j5tP/KlBWojTf
 1rvM+2M1w15wR60rN7dtpXFignd/oArcjCFwVpIF6ZWhTdFaHOXfkw4oEAHx42uKyHr9
 7q7zTBjbqUlTb+eLaFGuUnyHsvmcqpa1hB0IQwpnBtpJnMzynhOyVLMryXdqLBVnhtXV
 ZYIg==
X-Gm-Message-State: AOAM5307F9aQV70DCrLqWtTFXt0OLWIcn2qT7vvDhkaqQlCOzb2yBJe8
 p4m9+FfsEm/IvuU6T8kCnq7wo4HpY3+RecoXAJ4ONCcn
X-Google-Smtp-Source: ABdhPJyvFb2BlwiTjbnAIMTwULHzXhI33bNqdDWzK/1Um+jfdlADpYUNNTiAkBCEKhUC2xa9QqGXouY2dc1mqlutiXQ=
X-Received: by 2002:adf:f290:: with SMTP id k16mr3635557wro.124.1598910807966; 
 Mon, 31 Aug 2020 14:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200831104553.10207-1-nirmoy.das@amd.com>
 <CADnq5_P=LUjg4GubYdFFSBM+aXpkxOJ6yoD_2iNLNMSe_Vyzrg@mail.gmail.com>
 <0162c712-a0cd-78ee-0e87-6a612a1e81cb@amd.com>
 <CADnq5_MMKrR=TMF=-YcUM60eJO=osVB9N=H+hM93Pak=VXLBvA@mail.gmail.com>
 <00075962-70ba-a7b6-82d4-448b97ae5c99@amd.com>
In-Reply-To: <00075962-70ba-a7b6-82d4-448b97ae5c99@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2020 17:53:16 -0400
Message-ID: <CADnq5_NR8zY_aHPcZ39fGk_4-TFfWOPcHiT8wUCuxfjxYN=YNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Leo Liu <leo.liu@amd.com>
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
Cc: Nirmoy <nirmodas@amd.com>, tiancyin <Tianci.Yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 31, 2020 at 5:50 PM Leo Liu <leo.liu@amd.com> wrote:
>
>
> On 2020-08-31 1:39 p.m., Alex Deucher wrote:
> > On Mon, Aug 31, 2020 at 10:55 AM Nirmoy <nirmodas@amd.com> wrote:
> >> Hi Alex,
> >>
> >> On 8/31/20 4:17 PM, Alex Deucher wrote:
> >>> On Mon, Aug 31, 2020 at 6:41 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
> >>>> UVD dependent jobs should run on the same udv instance.
> >>>> This patch disables gpu scheduler's load balancer for
> >>>> a context which binds jobs from same the context to a udv
> >>>> instance.
> >>> typos: udv -> uvd
> >>> With that fixed:
> >>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >>>
> >>> Does VCE need a similar fix?  What about UVD_ENC?
> >>
> >> I am not sure, can you please confirm this.
> > @Leo Liu can you confirm?
>
> Vega20 have 2 UVDs and 1 VCE, so UVD_ENC(AMDGPU_HW_IP_UVD_ENC) should
> need the same fix.

What about other chips?  Didn't CZ and tonga have two VCE instances?
I guess any engine with hw contexts needs this.

Alex


>
> Regards,
>
> Leo
>
>
>
> >
> > Alex
> >
> >>
> >> Nirmoy
> >>
> >>
> >>
> >>> Alex
> >>>
> >>>
> >>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 +++-
> >>>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >>>> index 59032c26fc82..7cd398d25498 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >>>> @@ -114,7 +114,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
> >>>>           scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
> >>>>           num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> >>>>
> >>>> -       if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
> >>>> +       if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> >>>> +           hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> >>>> +           hw_ip == AMDGPU_HW_IP_UVD) {
> >>>>                   sched = drm_sched_pick_best(scheds, num_scheds);
> >>>>                   scheds = &sched;
> >>>>                   num_scheds = 1;
> >>>> --
> >>>> 2.28.0
> >>>>
> >>>> _______________________________________________
> >>>> amd-gfx mailing list
> >>>> amd-gfx@lists.freedesktop.org
> >>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Caaf07c8faa4d46f0b35f08d84dd4e875%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637344924116323889&amp;sdata=kvny71irAythb60XTzLHokUD7ZifHAKkTND8zSNs3T0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
