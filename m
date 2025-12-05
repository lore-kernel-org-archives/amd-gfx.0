Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CBED3B7E1
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Dec 2025 23:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A2910E309;
	Sat,  6 Dec 2025 23:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nullable.se header.i=nat@nullable.se header.b="SlFJMW2P";
	dkim-atps=neutral
X-Greylist: delayed 2706 seconds by postgrey-1.36 at gabe;
 Fri, 05 Dec 2025 18:25:51 UTC
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com
 [136.143.188.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9DF10EB95
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 18:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1764956441; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nhR9dTOPnSX2BEous16Y8SjYqMHBdxmFRl0RlRStWKv0JNEd4yR4lOQORLOnKROPiQ+dBjQEXZrSk8uqoN+KTOrUG39FZ00E2W/Qqg2zX92DbidTrPamoBzwWChb+1AXe5XyCLEOauVDHL5tXomsTIVU0Gz/KqATUcvZD2rkPa4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764956441;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mkIHMraBDWEJXM7kEFq2rAKphDmExXZtgJrg5N1Xj1g=; 
 b=JCEyfqFf0m9afbbB3ZifpmcRH7VxfFZoDbFZlqVyzQHHk/V9YkciljHH107mbwZ40I3ePrFLIMt4HeyxGaxEVJRaDb91aVH/wlJpwUABt3X4wgB0q612oUbqqIC4kaGAStq45OCgX2I9vf5AVag+Jr9Nodtrw7UQfdbzMWdCjfI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=nullable.se;
 spf=pass  smtp.mailfrom=nat@nullable.se;
 dmarc=pass header.from=<nat@nullable.se>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764956441; 
 s=zoho; d=nullable.se; i=nat@nullable.se;
 h=MIME-Version:References:In-Reply-To:From:From:Date:Date:Message-ID:Subject:Subject:To:To:Cc:Cc:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=mkIHMraBDWEJXM7kEFq2rAKphDmExXZtgJrg5N1Xj1g=;
 b=SlFJMW2Pws34FNUhR1sSDz2JbxpK1jKl0tXz6eZogU26bXhut0NQGXA92PXqmyO3
 IMORP9JUjEehsqvOyELaV+YoMwweAqXWJDu4UiWH/mkarJ2w/L/RyNMSR1cnE0xijbN
 AhwSAYCSrvq3gv2YFcK7ASoPxk5zotcpgwd/9B39StiWy1gafjPRKszmNPsk5ztG391
 YHQhJo0qRrhTRlm8lLUG5+jPY2XIwZs883l9hhISy2CSQqeiTaDmHRYUPewuCsr4Lu4
 L2K1UaZyGcPtfccRu82w/jhJr0EHxVI8jhnZot+Tw9EyOVTfygd69T1SjuvA6Wy/PBD
 ApilD4sltw==
Received: by mx.zohomail.com with SMTPS id 1764956437500506.3092789076437;
 Fri, 5 Dec 2025 09:40:37 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3437af8444cso2063629a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Dec 2025 09:40:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUXBC2jS09HmlLrV38zI0zKShK79Su0YxxW4rTUJP5mj0dKsf2RINeuLJ3hIMaBlcGCeFcMIT+s@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6d/pwcwDjZb20s0chtMhkZxROU9caIN9hVAqov8s67QlKos6i
 zXVC3IWbUUE2cOJAtC/X4sfdb2dqJzM7E5scICeNQ5nVPL1uR7HvZVfp/ePy7RLYa47jw596gWw
 FrxBumO3TuAPOyN8k0R9jGhVOyxans4E=
X-Google-Smtp-Source: AGHT+IEngTUUVfDb+YLvZVmdgMSvFDMV5pfxvvFF8cPWTE8meK5MFuG7XKwY3fpqzmzNFNEpvLSGf19bAmNweHLIH/I=
X-Received: by 2002:a17:90b:53c4:b0:340:d1a1:af8e with SMTP id
 98e67ed59e1d1-3491270ef84mr11330206a91.37.1764956436840; Fri, 05 Dec 2025
 09:40:36 -0800 (PST)
MIME-Version: 1.0
References: <GVZP280MB0725CCBA01C7021B957C708097A7A@GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM>
 <0e54d5d4-602b-43df-8107-159c4b6e02c5@amd.com>
 <GV3P280MB0724F50FE60963B5D5A73C7F97A7A@GV3P280MB0724.SWEP280.PROD.OUTLOOK.COM>
In-Reply-To: <GV3P280MB0724F50FE60963B5D5A73C7F97A7A@GV3P280MB0724.SWEP280.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Natalie_Klestrup_R=C3=B6ijezon?= <nat@nullable.se>
Date: Fri, 5 Dec 2025 18:40:25 +0100
X-Gmail-Original-Message-ID: <CAFR8Y_hAbhPP6ikgnSp7cahVs3poTMiVmoEYQ+UK5n-3TfS-BQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmbY1U59gvqIVcKuxOlFCoB3p13KYRSAPHsqS-ioKI9Mv2tE6JGH3RK8XQ
Message-ID: <CAFR8Y_hAbhPP6ikgnSp7cahVs3poTMiVmoEYQ+UK5n-3TfS-BQ@mail.gmail.com>
Subject: Re: Fw: linux-stable 6.17.10 (and 6.18.0) regression - broken
 DisplayPort MST/daisy chaining
To: alex.hung@amd.com
Cc: natalie.roijezon@appva.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Mailman-Approved-At: Sat, 06 Dec 2025 23:00:10 +0000
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

Thanks! Filed a bug for it now:
https://gitlab.freedesktop.org/drm/amd/-/issues/4756


On Fri, 5 Dec 2025 at 18:00, Natalie Klestrup R=C3=B6ijezon
<natalie.roijezon@appva.com> wrote:
>
>
> ________________________________
> From: Alex Hung <alex.hung@amd.com>
> Sent: Friday, December 5, 2025 17:45
> To: Natalie Klestrup R=C3=B6ijezon <natalie.roijezon@appva.com>; amd-gfx@=
lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Re: linux-stable 6.17.10 (and 6.18.0) regression - broken Displa=
yPort MST/daisy chaining
>
> Hi,
>
> Can you file a bug to https://gitlab.freedesktop.org/drm/amd/-/issues/
> so it's easier to track this issue later? Thanks.
>
> I will forward this to patch author at the same time.
>
>
> On 12/5/25 07:26, Natalie Klestrup R=C3=B6ijezon wrote:
> > Hey,
> >
> > After upgrading to Linux 6.18.0 I noticed that my daisy-chained display
> > setup (Lenovo ThinkPad P16s Gen 4 AMD feeding 3x Dell U2424HE monitors
> > over USB-C for the first, and then daisy-chained MST between them for
> > the rest, running at 1080p@120Hz) would no longer work:
> > displays 2 and 3 in the chain would just show "no DP signal" errors
> > instead.
> >
> > The same problem also happens on 6.17.10, but 6.17.9 is fine.
> >
> > I bisected it down to
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c?h=3Dv6.17.10&i=
d=3D18030e84cbda014787369b6d4cde8404fa2d08fc
> > and have confirmed that it 6.17.10 with
> > 18030e84cbda014787369b6d4cde8404fa2d08fc reverted runs fine again,
> > and is able to feed all three monitors.
> >
> > Now, obviously the patch exists for a /reason/, but at the moment it
> > appears to just be trading one miscalculation for another.. would it ma=
ke
> > sense to revert it for now?
> >
> > Happy to (try to) assist in troubleshooting, but I'm also woefully
> > underinformed about what the numbers are supposed to be instead.
> >
> > Thanks,
> > Natalie Klestrup R=C3=B6ijezon
>
