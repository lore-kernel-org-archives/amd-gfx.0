Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C0C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 16:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14ABB207D2
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 16:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ABB207D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6915A89C7F;
	Wed, 27 Jan 2021 16:06:54 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6423F89ABE
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 16:06:53 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB390207CC;
 Wed, 27 Jan 2021 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611763613;
 bh=TBiVdWNTKBxGL5C6wtlgzd2GcCfyPi02KPshb6e+jeM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=SwdW0TktI9sBGvj6wz48I+buvaYvvjBOEypEw/ZV2ww9FFDfZxnAGUAOYBsHJaQxp
 uDCXnm7Y+Jlrlc7jPCntfC2SL8P8hVVBCnQoM4Ofm7akEEs7sCb8FDdwizdwt/ZMKk
 mJ5JOz+P/5vXPVkMmhmarNNeAC0/beYCn+jrKBH2g3ywi5AjgVSPW6yiEmS14yEXXF
 e+FcRZYhqDtVorRN4HUjqYEwhBD/3XLdd/3foTCO8RcZevxQOPEG+oI1kzwI9MQneg
 /fw7BNKdhDJQJHg19ZxYWSFIvMzaWoSrEZNtzkkXXfgBoAlg74ErtyHhaKqOvFRoEW
 CT9VTuVNEoEFQ==
Date: Wed, 27 Jan 2021 10:06:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
Message-ID: <20210127160650.GA2991034@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ir4=urUviCR_4N96revWZkHVDyNNUiaJ3jjGzpX8zLVQ@mail.gmail.com>
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
 acpi4asus-user@lists.sourceforge.net, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Takashi Iwai <tiwai@suse.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Jaroslav Kysela <perex@perex.cz>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Corentin Chary <corentin.chary@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 linux-spi <linux-spi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 27, 2021 at 04:44:02PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 27, 2021 at 4:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Jan 26, 2021 at 02:23:17PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > The double negative makes it hard to read "if (!ACPI_FAILURE(status))".
> > > Replace it with "if (ACPI_SUCCESS(status))".
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >
> > > This isn't really an ACPI patch, but I'm sending it to you, Rafael, since
> > > it seems easier to just apply these all at once.  But I'd be happy to split
> > > them up into individual patches if you'd rather.
> >
> > Thanks, everybody.  Rafael, I'll just merge this via my tree to avoid
> > burdening you.
> 
> It may conflict with some janitorial stuff I'm doing, though, so
> unless you've already applied it, I'd prefer to take it via the ACPI
> tree.

No problem, it's all yours!

Bjorn
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
