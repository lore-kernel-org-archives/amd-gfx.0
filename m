Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104B9C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 17:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D2020678
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 17:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIM7hCJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D2020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9348F6E161;
	Mon, 31 Aug 2020 17:40:11 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619C96E161
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 17:40:10 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id z1so3309018wrt.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D5Sz1T4u58QFVfzzHR9a7DZctXiKgzf+RCLqYe7ZAMo=;
 b=HIM7hCJP2mu7ewfEdCy306YT1MNi5wJskU4H+lltCcl93P8m0HdzRzUht7Cx/pWdnP
 waA0bqbmj10DJ3G/dQMd8quOz0Di+EWZqt61wRKCi7n/tJdZPPeMKxJosLOCgjANYnIs
 vQivRBEMea1ni9iQZzZyLBzHIdDFQae/IAehVwdLjbOM881DvIPrKgircA0mxeoOX0sZ
 x686eAIHM+AybK/uhxxCf8HIVEAm5FGcRoI+sUZpbkM8lOeqeIFR9XFkjsPrjBM738hp
 MYLqN9uYBxwGz/Az/czRYx42wcV4vjCmYFBcba4hkHnEQogph9A9IVhEPwcv16ROCIVw
 UzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D5Sz1T4u58QFVfzzHR9a7DZctXiKgzf+RCLqYe7ZAMo=;
 b=TgpZNQOaKBtkqPiG0XPsmuhCVzglX5ePCPYrdXUr1dfieH2IbzThjvET9p04UeUVj7
 hekuIkbRNF8Mh/FTA05N1O4mxt6HgqIPN2iW4wBOh83hEjnTt3hqR1bh/znjOPktBV53
 6kMngiC6+sHfx0nOgj8ahq9qsepig3x95fCZ1ltyXaZoAwql38YLLnDVVdrMNLyW5ewU
 Pex49XDygKG6wupJqnueMLFn3P1TPZn/VwXOfLu1vZdLe+wVS2jhD2XlmV9Hx5idOn0f
 zgAA6Bas6/QJFZ21Nzz7zAkaxMyRzMvaxyxu+Jpzza4IV9wpKg0JppYAJX3xX8WiwEXp
 xRdw==
X-Gm-Message-State: AOAM5306qvv0hQ0LFlcRMzcHnNR6y8hMmmZr0BLPX/O1t+6j0QDZzJ3J
 TZcQYf7zbbIoImPopo3T9Dfae2WTfSJ1xLC4gFE=
X-Google-Smtp-Source: ABdhPJzg/a0890NoeWER6Wy0XWgl9Jj/OKRno8+xPCo3e3kfTxET5la9hJ3wFx9bnbNsZgAmWeJBIspf77YJzKHEKbo=
X-Received: by 2002:adf:f290:: with SMTP id k16mr2808687wro.124.1598895609075; 
 Mon, 31 Aug 2020 10:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200831104553.10207-1-nirmoy.das@amd.com>
 <CADnq5_P=LUjg4GubYdFFSBM+aXpkxOJ6yoD_2iNLNMSe_Vyzrg@mail.gmail.com>
 <0162c712-a0cd-78ee-0e87-6a612a1e81cb@amd.com>
In-Reply-To: <0162c712-a0cd-78ee-0e87-6a612a1e81cb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2020 13:39:57 -0400
Message-ID: <CADnq5_MMKrR=TMF=-YcUM60eJO=osVB9N=H+hM93Pak=VXLBvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd
To: Nirmoy <nirmodas@amd.com>, Leo Liu <leo.liu@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, tiancyin <Tianci.Yin@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 31, 2020 at 10:55 AM Nirmoy <nirmodas@amd.com> wrote:
>
> Hi Alex,
>
> On 8/31/20 4:17 PM, Alex Deucher wrote:
> > On Mon, Aug 31, 2020 at 6:41 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
> >> UVD dependent jobs should run on the same udv instance.
> >> This patch disables gpu scheduler's load balancer for
> >> a context which binds jobs from same the context to a udv
> >> instance.
> > typos: udv -> uvd
> > With that fixed:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Does VCE need a similar fix?  What about UVD_ENC?
>
>
> I am not sure, can you please confirm this.

@Leo Liu can you confirm?

Alex

>
>
> Nirmoy
>
>
>
> >
> > Alex
> >
> >
> >> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> index 59032c26fc82..7cd398d25498 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> >> @@ -114,7 +114,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
> >>          scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
> >>          num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> >>
> >> -       if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
> >> +       if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> >> +           hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> >> +           hw_ip == AMDGPU_HW_IP_UVD) {
> >>                  sched = drm_sched_pick_best(scheds, num_scheds);
> >>                  scheds = &sched;
> >>                  num_scheds = 1;
> >> --
> >> 2.28.0
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7C6a3e9061d2f043783ea408d84db8a04e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637344802648079859&amp;sdata=C7lkg97j7F6Kq1Vz7L79TbEDvfQm8QS3PUhdHfQ3Rcs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
