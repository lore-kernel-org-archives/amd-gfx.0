Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0446C3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 21:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867C7246A2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 21:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pza41Bci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867C7246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF36F6F4E0;
	Fri, 28 Feb 2020 21:41:28 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A606F4E2;
 Fri, 28 Feb 2020 21:41:26 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g83so2706591wme.1;
 Fri, 28 Feb 2020 13:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0By8f+MxDiJ0Cz4wnSfyKLOQx46zxHQzS4Vy6usWnKo=;
 b=pza41BcishAV48XmJgtNV8YeYoHrt6Ui4urvtfUgh+VaPPSkQdfxVDV+RcKkUjZcwM
 w90ejUurSSGEpwoA3AtXtgWYMofiVQtUl0JktUhxzXFTXtkrOScSwAE9j6NQcvy+ISws
 hAAG5mOV7p1PaidQUGxwmwtE3jnMRU+3nck8J4VtO2WctZeo7EzOWFbPCQaoSXFLtwjr
 GMsoUIrewRk79ju0OO2WXoumHjga36k8RyuteF5Gos5/CjZnO3RZNV0Up0Qfnfzlvyp7
 HLzAvA/HEwyhD9kn4DIy4diX90iPdsmyaTDDker+duZQsJ7SewCdtNjMh3jnEpHX9Wx+
 q4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0By8f+MxDiJ0Cz4wnSfyKLOQx46zxHQzS4Vy6usWnKo=;
 b=ZC+fG+vkfvKRs1crl1QrPHt84FGTgBXcQvBHmZXhalaRIjdNbBGpwB2alugw7Va1q9
 yZ8UJif9SnFBlGb406rqrTW4twe7KwnaiF9AWsd6XMlDPrAAte8O8r72MgH7QTEJM2tl
 cuosPNV3yxmG77wmHSxj2tqsnsnCwjIBHe80tJ1qnx3C6W7dueav3XGuR/GG0ltQQ3v1
 zPjE0FozDPzscx61tmpyew8rGfGqi7Lj1NkdctBc4Tl872mJ8994u7TofVyV+Htijn9Y
 1tJ0W8diMdIpidYcTRQpuPv3Vn0YXUba+8cqTIh4oB6vNLmhQrPgHrpSELZGAvEsIeZV
 6mmg==
X-Gm-Message-State: APjAAAW4DEL+S/Menj+LOAd/HDHkDvwycW4IteiUIgQIEJtoB3xiPDBW
 5yfDich07bBDLxVS4YIFggV9Bfbk2ij1C/CdPFE=
X-Google-Smtp-Source: APXvYqxzO0vfPEN/rsFxTjBlZFpnfDR5Z+wNZIe+DdLkFTUae2s+J0duL2MALfE87H6Tz9w+gILiIa+sWVaP7uzQVfw=
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr6604315wme.30.1582926085504; 
 Fri, 28 Feb 2020 13:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20200109152028.28260-1-mario.kleiner.de@gmail.com>
 <20200109152028.28260-3-mario.kleiner.de@gmail.com>
 <9238371c-fc93-2a65-c3e5-df6b3d1270dd@amd.com>
 <CAEsyxygx+2p+i91bvYBLVfq-9qog-SLQ_KdHBTmSyq4Zfr09jg@mail.gmail.com>
 <6d481758-d0d9-8911-1473-4257b74a1e97@amd.com>
 <CAEsyxygQff4kcOweR_PTKSMf9wss5i+nGA=BwiUjSH+V-MXXAQ@mail.gmail.com>
In-Reply-To: <CAEsyxygQff4kcOweR_PTKSMf9wss5i+nGA=BwiUjSH+V-MXXAQ@mail.gmail.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Fri, 28 Feb 2020 22:41:14 +0100
Message-ID: <CAEsyxyjHPMM=NcShaZRLCEfbS0xE042YcL5EU+_0CcARhg+Dqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Allow current eDP link settings to
 override verified ones.
To: Harry Wentland <hwentlan@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 8:11 PM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Hi Harry
>
> Ok, back from various other emergencies and deadlines, sorry for the
> late reply. I also fixed my e-mail address - it was mistyped, causing
> all these delivery failures :/
>
> On Thu, Jan 9, 2020 at 10:26 PM Harry Wentland <hwentlan@amd.com> wrote:
> >
> > On 2020-01-09 4:13 p.m., Mario Kleiner wrote:
> > > On Thu, Jan 9, 2020 at 7:44 PM Harry Wentland <hwentlan@amd.com
> > > <mailto:hwentlan@amd.com>> wrote:
> > >
> > >     On 2020-01-09 10:20 a.m., Mario Kleiner wrote:
> > >     > If the current eDP link settings, as read from hw, provide a higher
> > >     > bandwidth than the verified_link_cap ones (= reported_link_cap), then
> > >     > override verified_link_cap with current settings.
> > >     >
> > >     > These initial current eDP link settings have been set up by
> > >     > firmware during boot, so they should work on the eDP panel.
> > >     > Therefore use them if the firmware thinks they are good and
> > >     > they provide higher link bandwidth, e.g., to enable higher
> > >     > resolutions / color depths.
> > >     >
> ... snip ...
> > >
> > >
> > > Tried that already (see other mail), replacing the whole if statement
> > > with a if (true) to force reading DP_SUPPORTED_LINK_RATES. The whole
> > > table reads back as all-zero, and versions are DP 1.1, eDP 1.3, not 1.4+
> > > as what seems to be required. The use the classic link bw stuff, but
> > > with a non-standard link bandwidth multiplier of 0xc, and a reported
> > > DP_MAX_LINK_RATE of 0xa, contradicting the 0xc setting that the firmware
> > > sets at bootup.
> > >
> > > Seems to be a very Apple thing...
> >
> > Indeed. I think it was a funky panel that was "ahead of its time" and
> > ahead of the spec.
> >
> > I would prefer a DPCD quirk for this panel that updates the reported DP
> > caps, rather than picking the "current" ones from the FW lightup.
> >
> > Harry
> >
>
> How would i do this? I see various options:
>
> I could rewrite my current patch, move it down inside
> dc_link_detect_helper() until after the edid was read and we have
> vendor/model id available, then say if(everything that's there now &&
> (vendor=Apple) && (model=Troublesomepanel)) { ... }
>
> Or i could add quirk code to detect_edp_sink_caps() after
> retrieve_link_cap() [or inside retrieve_link_cap] to override the
> reported_link_cap. But at that point we don't have edid yet and
> therefore no vendor/model id. Is there something inside the dpcd one
> can use to uniquely identify this display model?
>
> struct dp_device_vendor_id sink_id; queried inside retrieve_link_cap()
> sounds like it could be a unique id? I don't know about that.
>
> My intention was to actually do nothing on the AMD side here, as my
> photometer measurements suggest that the panel gives better quality
> results for >= 10 bpc output if it is operated at 8 bit and then the
> gpu's spatial dithering convincingly fakes the extra bits. Quality
> seems worse if one actually switches the panel into 10 bpc, as it
> doesn't seem to be a real 10 bit panel, just a 8 bit panel that
> accepts 10 bit and then badly dithers it to 10 bit.
>
> The situation has changed for Linux 5.6-rc, because of this recent
> commit from Roman Li, which is already in 5.6-rc:
> 4a8ca46bae8affba063aabac85a0b1401ba810a3 "drm/amd/display: Default max
> bpc to 16 for eDP"
>
> While that commit supposedly fixes some darkness on some other eDP
> panel, it now breaks my eDP panel. It leaves edid reported bpc
> unclamped, so the driver uses 10 bpc as basis for required bandwidth
> calculations and then the required bandwidth for all modes exceeds the
> link bandwidth. I end with the eDP panel having no valid modes at all
> ==> Panel goes black, game over.
>
> We either need to revert that commit for drm-fixes, or quirk it for
> the specific panels that are troublesome, or need to get some solution
> into 5.6-rc, otherwise there will be a lot of regressions for at least
> Apple MBP users.
>
> thanks,
> -mario
>

Ok, just sent out a patch with a specific dpcd quirk for this as:

[PATCH] drm/amd/display: Add link_rate quirk for Apple 15" MBP 2017

Tested against drm-next for Linux 5.6, works.

-mario
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
