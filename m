Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFEFC61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Feb 2023 06:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5B210E157;
	Sat, 11 Feb 2023 06:35:08 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A36710E04A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 23:30:39 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id b5so8267543plz.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 15:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEj/ZRqPDHV3euzaw9BypxOqQolHXZURobYLo7ytqXI=;
 b=k6bTErh6BD3tS2w9e8Y+lmT5iUB/rtXLoMAdR6LQzp/Hj0e8QI0Doow4kLuhK/WVgD
 EEhawPGKaxLdC1cWeVTpWQ366TQHM9kxQdfoBTFb8tKkvKgat540Zwf86/3PxIQnLaKc
 ZxnB5LgADmHaXuFnIC8qZk9RdoX+8AaOxk33PGVjllCKwNssPXtXUtDsPDha4+gHOKOB
 HU/vHVagW/39wK2GwRnko1YXPQzur36hnYF2VqKM9BN9JtJYyzjzRUy8yVoq8tWe0C6A
 pRjr5rFimvBwWTcr7VUz1wiUYak6x+b3yr1l0EVG7v9wJc0EFvnlbIL5+7jgznUeZOz/
 RFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEj/ZRqPDHV3euzaw9BypxOqQolHXZURobYLo7ytqXI=;
 b=2V12T4Fo5mj9Xchrn9Q5U3+JsFFOkfUgxS7hkuww+zs2YSj21pRB0fsoEzmivzTvM6
 Tqsnk3QYJ50+HTVesDFVp51LwQCCK1Dc6kGNlbBiTkOxmZdg2r3+VNyP4yCjbZ3Dr/77
 jN5dtfB1K41wflWzyuBc3qJTUi6562cA1hxzscdoCMPjOSbNCRogHLeTGJV6+4cD6fh9
 sYNUlXsvpsJTMm5TYBawMqzRgfqcAW3lPhqWLSrqxWI8s0GSa3oAlRxzC6N4LX776vK4
 PyH/eLtFXIOQwP+TSIcc966C7t7vUQ5Ap8WkCrUWYR8SPR/koMynxhgdNAIwmUsholEZ
 hd8w==
X-Gm-Message-State: AO0yUKU/npgwcsguMpqGov1tMeqA0z7wke1LtHKMrXc2ox1hxCV+4r0T
 BT2ESdYPGRw05SuT3KfCiW0=
X-Google-Smtp-Source: AK7set/cBhHgTRDkorSIdrM2NOdlYlVW66+6n2lvyjBtTHp7SCfKc/citVEd3wdFWlNuqWSayBvocg==
X-Received: by 2002:a05:6a21:2c8b:b0:bf:1b09:5cda with SMTP id
 ua11-20020a056a212c8b00b000bf1b095cdamr13393488pzb.12.1676071839038; 
 Fri, 10 Feb 2023 15:30:39 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a63b006000000b0049f5da82b12sm3456028pgf.93.2023.02.10.15.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Feb 2023 15:30:38 -0800 (PST)
Date: Sat, 11 Feb 2023 10:30:24 +1100
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
Message-ID: <20230211103024.2a204487@redecorated-mbp>
In-Reply-To: <74e3c9ae-b1f1-1e7b-4af1-56f918471b36@redhat.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-2-orlandoch.dev@gmail.com>
 <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
 <74e3c9ae-b1f1-1e7b-4af1-56f918471b36@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 11 Feb 2023 06:35:05 +0000
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
Cc: alsa-devel@alsa-project.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rander Wang <rander.wang@intel.com>, Lijo Lazar <lijo.lazar@amd.com>,
 platform-driver-x86@vger.kernel.org, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Evan Quan <evan.quan@amd.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 amd-gfx@lists.freedesktop.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>, Mark Gross <markgross@kernel.org>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 linux-kernel@vger.kernel.org, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 10 Feb 2023 20:19:27 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/10/23 20:09, Hans de Goede wrote:
> > Hi,
> > 
> > On 2/10/23 05:48, Orlando Chamberlain wrote:  
> >> Currently it manually flips the byte order, but we can instead use
> >> cpu_to_be32(val) for this.
> >>
> >> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> >> ---
> >>  drivers/platform/x86/apple-gmux.c | 18 ++----------------
> >>  1 file changed, 2 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/apple-gmux.c
> >> b/drivers/platform/x86/apple-gmux.c index
> >> 9333f82cfa8a..e8cb084cb81f 100644 ---
> >> a/drivers/platform/x86/apple-gmux.c +++
> >> b/drivers/platform/x86/apple-gmux.c @@ -94,13 +94,7 @@ static u32
> >> gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
> >> static void gmux_pio_write32(struct apple_gmux_data *gmux_data,
> >> int port, u32 val) {
> >> -	int i;
> >> -	u8 tmpval;
> >> -
> >> -	for (i = 0; i < 4; i++) {
> >> -		tmpval = (val >> (i * 8)) & 0xff;
> >> -		outb(tmpval, gmux_data->iostart + port + i);
> >> -	}
> >> +	outl(cpu_to_be32(val), gmux_data->iostart + port);
> >>  }
> >>  
> >>  static int gmux_index_wait_ready(struct apple_gmux_data
> >> *gmux_data)  
> > 
> > The ioport / indexed-ioport accessed apple_gmux-es likely are (part
> > of?) LPC bus devices . Looking at the bus level you are now
> > changing 4 io accesses with a size of 1 byte, to 1 32 bit io-access.
> > 
> > Depending on the decoding hw in the chip this may work fine,
> > or this may work not at all.
> > 
> > I realized that you have asked for more testing, but most surviving
> > macbooks from the older apple-gmux era appear to be models without
> > a discrete GPU (which are often the first thing to break) and thus
> > without a gmux.
> > 
> > Unless we get a bunch of testers to show up, which I doubt. I would
> > prefer slightly bigger / less pretty code and not change the
> > functional behavior of the driver on these older models.  
> 
> A quick follow up on this, I just noticed that only the pio_write32
> is doing the one byte at a time thing:
> 
> static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int
> port) {
>         return inl(gmux_data->iostart + port);
> }
> 
> static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int
> port, u32 val)
> {
>         int i;
>         u8 tmpval;
> 
>         for (i = 0; i < 4; i++) {
>                 tmpval = (val >> (i * 8)) & 0xff;
>                 outb(tmpval, gmux_data->iostart + port + i);
>         }
> }
> 
> And if you look closely gmux_pio_write32() is not swapping
> the order to be32 at all, it is just taking the bytes
> in little-endian memory order, starting with the first
> (index 0) byte which is the least significant byte of
> the value.
> 
> On x86 the original code is no different then doing:
> 
> static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int
> port, u32 val)
> {
>         u8 *data = (u8 *)&val;
>         int i;
> 
>         for (i = 0; i < 4; i++)
>                 outb(data[i], gmux_data->iostart + port + i);
> }
> 
> So yeah this patch is definitely wrong, it actually swaps
> the byte order compared to the original code. Which becomes
> clear when you look the weird difference between the read32 and
> write32 functions after this patch.
> 
> Presumably there is a specific reason why gmux_pio_write32()
> is not already doing a single outl(..., val) and byte-ordering
> is not the reason.
> 
> Regards,
> 
> Hans

Sounds like it may be better to just drop this patch as there's very
little benefit for the risk of causing a regression.

> 
> 
> 
> >> @@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct
> >> apple_gmux_data *gmux_data, int port) static void
> >> gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
> >> u32 val) {
> >> -	int i;
> >> -	u8 tmpval;
> >> -
> >>  	mutex_lock(&gmux_data->index_lock);
> >> -
> >> -	for (i = 0; i < 4; i++) {
> >> -		tmpval = (val >> (i * 8)) & 0xff;
> >> -		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE
> >> + i);
> >> -	}
> >> -
> >> +	outl(cpu_to_be32(val), gmux_data->iostart +
> >> GMUX_PORT_VALUE); gmux_index_wait_ready(gmux_data);
> >>  	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
> >>  	gmux_index_wait_complete(gmux_data);  
> >   
> 

