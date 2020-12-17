Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11021C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 19:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9113C239E4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 19:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9113C239E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADB78930A;
	Thu, 17 Dec 2020 19:14:45 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A898930A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 19:14:44 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id s75so118890oih.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nFYoh8qdL+WZDgMajHDkUaQqLMbZjgo1+LlZTaJU174=;
 b=WqpIyl7PUzujiYPG1qbyhKr8PPykbZslFrP+GNdtLGb77eE7QguzH0MalYolCO/oBt
 taQsh3d/rU/RHTXl2UgeX57PS7fO6sq5GAlQFuHGf2NnelMW/iSuUpTtgLiIF7+HFynn
 0YzPxheo/CSh9iPeKoGAlPPd7m1/pGt267XI2XE5+NP+kTASxeFlfSoHZKhyCVXdh0N0
 4Sr2cYftG7v/l04bwucGBwXzM/gAbmbcZYfdwalZxVXJBKCRFFGoNV7MTAhJI5KIXd8G
 Br/xTrx37O+8PRH1APyDftZZ15Hz8Ai4dEghxBZjMEhLXtPkS7cMxjwzNNEhqmlC7ug6
 GESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nFYoh8qdL+WZDgMajHDkUaQqLMbZjgo1+LlZTaJU174=;
 b=LfMAl4/vTPzcdXgwM9g2aBTQeVZArtzuE2WyFM9071rQunK+qRKbbLyIA9cvyivPMt
 5pEe/TqG8PgujSc95zIgaUNj8yU3wx3i9lBCN8lCefUevdGqo/fXpoBkfjuJGyz3LiSM
 3c6BzZRD7QlgUruAnwMucIAx2TM9t//GXK013HpZcnC1qgZzrWgq+CDcIA04iPtvJ1f4
 oQA2fqqTlksijDumsw1BoTy/3+kHJ3pGO2fHmtgNC+csQuZVi/gf8pQw2WpfIO+ujZs5
 b3pfNvKLvQ3+kwPLuEh/ZvqQM7W993J6jmJ1KPJmg4hm2rRtLFsiKw2heia/MPZPKMsc
 cALA==
X-Gm-Message-State: AOAM5330Of/jRKjJhSZdA7+ylbHeonWtwcFrJ+yYzk1c7SbZdBfw341Z
 Pflpzu3Q/xSAlIAbwD6Ks7PZpgwmyxBfQfCDJXQ=
X-Google-Smtp-Source: ABdhPJyJT5CYdKJiXv7cNoRILVLrt0SNRn5yqVWHONdEjX5tIvGH7y2NVn0uHhrnRlKbTvkWGkykNM7gxr2u1faRToM=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr452563oib.123.1608232483717; 
 Thu, 17 Dec 2020 11:14:43 -0800 (PST)
MIME-Version: 1.0
References: <30c555d1-e019-3668-c35b-021003e2a6e2@computerix.info>
 <20191021114731.GZ2819@lahna.fi.intel.com>
 <f5d7c7da-c7f3-df87-75b9-48db12f640fb@computerix.info>
 <20191021130541.GG2819@lahna.fi.intel.com>
 <cebaf35c-a5f5-94b1-7ccc-0e9636c95bc3@computerix.info>
 <20191021162022.GV2819@lahna.fi.intel.com>
 <313ae966-aae5-92a9-4eeb-02fec9cc43d4@computerix.info>
 <1bd561bb-593b-0576-93b8-eb70f37dcf79@computerix.info>
 <CADnq5_NYLyazVT5pEVyVHA6ZMoPA=4QrCw7MTAYx-rj7JTOPyg@mail.gmail.com>
 <4a478649-5fa1-b29e-40e3-b2843460a1c9@computerix.info>
In-Reply-To: <4a478649-5fa1-b29e-40e3-b2843460a1c9@computerix.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Dec 2020 14:14:32 -0500
Message-ID: <CADnq5_PpqxXcM7VXTnzTj_SUF+tx5Fe1FgbT4DVN6B4jpVGXfw@mail.gmail.com>
Subject: Re: [bug report]: Black screen in 5.10
To: Klaus Kusche <klaus.kusche@computerix.info>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 17, 2020 at 1:14 PM Klaus Kusche
<klaus.kusche@computerix.info> wrote:
>
>
> Hello,
>
> On 17/12/2020 16:17, Alex Deucher wrote:
> > On Thu, Dec 17, 2020 at 10:15 AM Klaus Kusche
> > <klaus.kusche@computerix.info> wrote:
> >> With kernel 5.10.x, both the internal notebook display and any external screen
> >> become black (or go to the "off" state?) when the kernel boots
> >> (one or two seconds after the VGA text console is shown),
> >> and the system no longer reacts.
> >>
> >> 5.9.x is fine.
> >>
> >> This seems to happen as soon as the amdgpu kernel driver loads/initializes,
> >> even in pure text mode (VGA console or framebuffer), without starting X.
> >>
> >> Dell Precision notebook with
> >> AMD Radeon (TM) Pro WX 3200 Series (POLARIS12, DRM 3.39.0, 5.9.15-gentoo, LLVM 11.0.0) (0x6981)
> >>
> >> Tried all combinations of DC/non-DC, FB/non-FB kernel configurations
> >> (even happens when configuring Amdgpu without framebuffer!).
> >
> > I think this may be the same issue as:
> > https://patchwork.freedesktop.org/patch/408230/
> > Does the patch there help?  It's already on it's way upstream.
> The patch fixes it. 5.10.1 works fine for me now.
>
> Will 5.10.2 contain the patch or shall I skip 5.10.2 ?

Not sure.  Depends how soon the patch makes it into stable.  If not
.2, then hopefully .3.

Alex


>
> --
> Prof. Dr. Klaus Kusche
> Private address: Rosenberg 41, 07546 Gera, Germany
> +49 365 20413058 klaus.kusche@computerix.info https://www.computerix.info
> Office address: DHGE Gera, Weg der Freundschaft 4, 07546 Gera, Germany
> +49 365 4341 306 klaus.kusche@dhge.de https://www.dhge.de
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
