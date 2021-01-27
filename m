Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED68C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 17:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658F364D9E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 17:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658F364D9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A9B89EBD;
	Wed, 27 Jan 2021 17:44:20 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FC689EBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 17:44:19 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id a109so2524701otc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 09:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iHVRlfV9EQu4gPj5dVenKguyA2U2WXu41Z7MOBH2q+k=;
 b=cu27sYshY637bTqiBmeFUiL5BLBGZz6vHk8vjJSHrLXDykhIbj97Lhde6Tad2ncTQc
 AzC64qdCBThojFD/OTb0QmOw3ItmOtvQxSzGP3FHynykDJYvkcrEqhOltD31eLJr37Lv
 yChlXYIbTMWtHQLpm271I/54qwimpjWwaBaRaQWp/3BqjwbkcK/BXIhClw3gOXYWsW1O
 we1De/PaDzjRHwSp7v4DVAAMzECD7FcBlUqHGHVosuMUBtY7ZASVSwbMuP1YdenaBBIy
 TOYzVOEMtClMhRtrlm02AlFiS5Jwz8VUZjybHv2hJYIw9E8zQgG6s67TqDbaUVHBXqg6
 axtw==
X-Gm-Message-State: AOAM531nd40bSIw3iQQp3N/Bf5iqOe3AoXR5icdqDt+5PvbFhovEsGsr
 zZTsVaSKKi8Qq65/QiN4jzCo4ifQE25gMrBqF94=
X-Google-Smtp-Source: ABdhPJx3wpBSkXPSpXDG6M0ltMbmguxQMImznzdVeAu1VT6FKAr93J3QfMztoWACmNnTeM4RMvDtc7yrOgIFRwkLX6w=
X-Received: by 2002:a05:6830:2313:: with SMTP id
 u19mr8675107ote.321.1611769458811; 
 Wed, 27 Jan 2021 09:44:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0ir4=urUviCR_4N96revWZkHVDyNNUiaJ3jjGzpX8zLVQ@mail.gmail.com>
 <20210127160650.GA2991034@bjorn-Precision-5520>
In-Reply-To: <20210127160650.GA2991034@bjorn-Precision-5520>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Jan 2021 18:44:07 +0100
Message-ID: <CAJZ5v0gmP2QBmMWkdVaGy+j6+FFPH6VGfRMU9ncz6m4BhBPgFA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
To: Bjorn Helgaas <helgaas@kernel.org>
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
Cc: linux-hwmon@vger.kernel.org,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Jean Delvare <jdelvare@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, acpi4asus-user@lists.sourceforge.net,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Corentin Chary <corentin.chary@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 linux-spi <linux-spi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 27, 2021 at 5:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 27, 2021 at 04:44:02PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 27, 2021 at 4:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Tue, Jan 26, 2021 at 02:23:17PM -0600, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > The double negative makes it hard to read "if (!ACPI_FAILURE(status))".
> > > > Replace it with "if (ACPI_SUCCESS(status))".
> > > >
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > ---
> > > >
> > > > This isn't really an ACPI patch, but I'm sending it to you, Rafael, since
> > > > it seems easier to just apply these all at once.  But I'd be happy to split
> > > > them up into individual patches if you'd rather.
> > >
> > > Thanks, everybody.  Rafael, I'll just merge this via my tree to avoid
> > > burdening you.
> >
> > It may conflict with some janitorial stuff I'm doing, though, so
> > unless you've already applied it, I'd prefer to take it via the ACPI
> > tree.
>
> No problem, it's all yours!

Applied as 5.12 material with the ACKs, thanks!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
