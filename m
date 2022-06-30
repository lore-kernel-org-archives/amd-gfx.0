Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D35C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198BF12AC19;
	Thu, 30 Jun 2022 19:33:40 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416DA12AC16
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:33:39 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id d2so62494ejy.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+cIlGY0YAHlVqZzF5yCXNk/+WTFptQ8D1I4O5n6RSAE=;
 b=Xgp261uvbEj7mby/vx4ng0qJLq4MYelcwBJtlNjdy4Kd2mBa9KX9WP924nAIfe98p1
 irkGI5jjHopYYrR2sxAZtHz5Vjtpkw1263W45AlGgAayAFKUDfR45WC/jgYUiPdOIUoh
 yan+vEatZrTWfsS12A357UZvRlaouKf9MJw6VJ54ROIsXA33iDknSeGFH3tldp35GG9z
 NGX+V/VbrXRIOyw5LyLnxMZ3Cw5o2KF/xNzSMJmNpve05FQK303l72fVkED4A5iE8QTf
 xlq9g6S2jJiq5FzbHoH8SSzZVIX7kEoC0QklQ5csD7YGgetEQbEsL05CcQCrxabJZwTi
 +wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+cIlGY0YAHlVqZzF5yCXNk/+WTFptQ8D1I4O5n6RSAE=;
 b=g21sDuGIztB6ZApYatyySEmPpZDUJW29vIwTLWHHfe/P2BDitTO76QnIVUebVF1KQD
 wqpE5eTPBR4M69tNLwRJmZQox1icCZxSqff64+UCedyiTJ8QBSr0s1mLJlFqc9Y88Cev
 FIR3x1IBynMKo5GscOuKyn7nxnmbmywIa5hqJwdE3IqcyvjD5dgNYhBLYQW/atfKS5ZW
 QsDzu50r/YwmdzkgtwiGX7ifLgNot1cTG+YvRW+fENhe1xrRJ+SBXglswns+p8D9gVgF
 4He9IJKGLBHnpDrg9/jnGEWKGnF4b3m7zIYC7To96s+YHXMmrFXxm82FJyqhG3qjuWpa
 Jl4Q==
X-Gm-Message-State: AJIora/WBpqkv8es63/EZm77mQ1Cr1YMuUp0A4e+oz784cNqjd9MqHoB
 r5n7LqoqiLasCfEjT4vsZ8Fot0IU3JMXMyuQeD8qHBm+
X-Google-Smtp-Source: AGRyM1t3DF+yk87jaZns2BfTd97jIGEZgwN7ABHyr7Z//716EHnX4kpTip1Gv1yd5hLv2DQxfQw1jsIJ0NucEGqaEaI=
X-Received: by 2002:a17:906:5253:b0:711:ee52:764e with SMTP id
 y19-20020a170906525300b00711ee52764emr10710279ejm.171.1656617617831; Thu, 30
 Jun 2022 12:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
 <CADnq5_ND=YHJ_gTx5VLOx7zJzRbaZmCQHA2uo5HZHBrjzvyDMw@mail.gmail.com>
 <7eaf9676-b6ac-c2d0-2950-da7ffb31848f@amd.com>
In-Reply-To: <7eaf9676-b6ac-c2d0-2950-da7ffb31848f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jun 2022 15:33:25 -0400
Message-ID: <CADnq5_MX4jKc5cQxUQKLg2D9woE+omSXvgjPr+q25MXJcQrnHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add debug mask for subviewport mclk switch
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 30, 2022 at 3:28 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
>
>
> On 2022-06-30 14:28, Alex Deucher wrote:
> > On Tue, Jun 28, 2022 at 5:26 PM Aurabindo Pillai
> > <aurabindo.pillai@amd.com> wrote:
> >>
> >> [Why&How]
> >> Expose a new debugfs enum to force a subviewport memory clock switch
> >> to facilitate easy testing.
> >>
> >
> > Is the debugfs support already plumbed in and this just enables you to
> > use it?  If it's in debugfs, do we really need a module parameter to
> > enable it or can it just be enabled by default and used via debugfs
> > when needed?
>
> Sorry, I meant to put in debug mask, like in the title. Will fix that.
> There is no debugfs associated with this change. The change in DM is
> enough to enable this.
> >

Thanks.  With that fixed,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> > Alex
> >
> >> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
> >>   drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
> >>   2 files changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index c9145864ed2b..7a034ca95be2 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -1559,6 +1559,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
> >>          if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
> >>                  adev->dm.dc->debug.disable_clock_gate = true;
> >>
> >> +       if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
> >> +               adev->dm.dc->debug.force_subvp_mclk_switch = true;
> >> +
> >>          r = dm_dmub_hw_init(adev);
> >>          if (r) {
> >>                  DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
> >> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> >> index bcdf7453a403..b1c55dd7b498 100644
> >> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> >> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> >> @@ -247,6 +247,7 @@ enum DC_DEBUG_MASK {
> >>          DC_DISABLE_DSC = 0x4,
> >>          DC_DISABLE_CLOCK_GATING = 0x8,
> >>          DC_DISABLE_PSR = 0x10,
> >> +       DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
> >>   };
> >>
> >>   enum amd_dpm_forced_level;
> >> --
> >> 2.36.1
> >>
