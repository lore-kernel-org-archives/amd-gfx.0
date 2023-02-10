Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B93C636CC
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Feb 2023 06:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E389410E11C;
	Sat, 11 Feb 2023 06:35:07 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7975910E00D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 23:37:11 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id 16so4551325pfo.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 15:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWl59Xq4HhZJNA/74ztn8Fz0mUv6Fs/PnU96YJviPtI=;
 b=eWV0M6rGtsHugvA38QqBpUL6jZ4y3mJzobxzFGiKGdTQNp2DYSntYK8fNimGGqSQG3
 v1URcOI0nGZ1/5TGJU4dqMNN0DJxIJ0uM4RokG2TRfHGuj5xlO84qXVGFdSjO+O54Geg
 7GsOk6Yj8pJaVWTcJG1de4lfsJ3gH1OShZrBNpbODHTlSWXeMhbmu3f65mM1QZYVFCIv
 4hvVqBnxmKH6VZ+tNP3BQHxQ0KIlFS7H1alY+jmoagEd/KhnLzqQ0toWliT5JA9sK9sa
 yQjxaTUBmPu4eclYjhf0zO5B1fdePRn/78QzQnXl3qUDNnYPDxsp/AtjsBh4MZEVPZro
 QMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWl59Xq4HhZJNA/74ztn8Fz0mUv6Fs/PnU96YJviPtI=;
 b=3CIm70w1NDiUxIXn1pdAZq6m++CAqyu7aC8No/8AELg0f6XznwUBcRxFuxPyJh2y1d
 0ROrGdcWTw8FLHtlm+gu2HDB8CKcawbw7LsNFZ33bqtunKd9pawIWKuC05/nxT2hy07/
 +5EHAjzuTdGrLFa/v7LIo+U9rmUwkmwdqHtYSuojJrvLQSMW63wQuVz7HJijk1wpaQvu
 Xdb+HRPXlEGRiBbxI4DR1fqLciddI0MTkKkO0E/JlANzLezX8VQp84c6HFVT3j8i1ReP
 myA2pQxCrMSf7PVuHegDiq3BVY3hZAz9pyBDbsRDMaD7jj2o3XjUBW7TiefVvzpXZqtb
 fMPQ==
X-Gm-Message-State: AO0yUKVFYUg2w0pHeT/BcwC8f1F2V+maAocEdfDf1A/oS0lupiUQnnnr
 tRfLx/m2+AP1MyggjBzKgPg=
X-Google-Smtp-Source: AK7set8/KTxG0Ml6oxWb6/Y9VAH38w4uk9BRJXkFZ7hYp7F15/mhAqCM06D1a5AHUz8YnhSy937ZjA==
X-Received: by 2002:aa7:93c2:0:b0:5a8:4459:384d with SMTP id
 y2-20020aa793c2000000b005a84459384dmr8724287pff.3.1676072231023; 
 Fri, 10 Feb 2023 15:37:11 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 f16-20020aa782d0000000b00587fda4a260sm3776296pfn.9.2023.02.10.15.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Feb 2023 15:37:10 -0800 (PST)
Date: Sat, 11 Feb 2023 10:36:57 +1100
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH 2/9] apple-gmux: consolidate version reading
Message-ID: <20230211103657.53108b64@redecorated-mbp>
In-Reply-To: <f4992ffa-68db-7f8c-b92d-a0e1348a7839@redhat.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-3-orlandoch.dev@gmail.com>
 <f4992ffa-68db-7f8c-b92d-a0e1348a7839@redhat.com>
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
 Lijo Lazar <lijo.lazar@amd.com>, Rander Wang <rander.wang@intel.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Evan Quan <evan.quan@amd.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 amd-gfx@lists.freedesktop.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Bokun Zhang <Bokun.Zhang@amd.com>, Mark Gross <markgross@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Kerem Karabay <kekrby@gmail.com>,
 platform-driver-x86@vger.kernel.org, Jack Xiao <Jack.Xiao@amd.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 linux-kernel@vger.kernel.org, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 10 Feb 2023 20:41:19 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/10/23 05:48, Orlando Chamberlain wrote:
> > Read gmux version in one go as 32 bits on both indexed and classic
> > gmux's.
> > 
> > Classic gmux's used to read the version as
> > 
> > major = inb(base + 0x4);
> > minor = inb(base + 0x5);
> > release = inb(base + 0x6);
> > 
> > but this can instead be done the same way as indexed gmux's with
> > gmux_read32(), so the same version reading code is used for classic
> > and indexed gmux's (as well as mmio gmux's that will be added to
> > this driver).
> > 
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > ---
> >  drivers/platform/x86/apple-gmux.c | 14 ++++++--------
> >  include/linux/apple-gmux.h        |  6 +-----
> >  2 files changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/apple-gmux.c
> > b/drivers/platform/x86/apple-gmux.c index
> > e8cb084cb81f..67628104f31a 100644 ---
> > a/drivers/platform/x86/apple-gmux.c +++
> > b/drivers/platform/x86/apple-gmux.c @@ -580,15 +580,13 @@ static
> > int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> > if (indexed) { mutex_init(&gmux_data->index_lock);
> >  		gmux_data->indexed = true;
> > -		version = gmux_read32(gmux_data,
> > GMUX_PORT_VERSION_MAJOR);
> > -		ver_major = (version >> 24) & 0xff;
> > -		ver_minor = (version >> 16) & 0xff;
> > -		ver_release = (version >> 8) & 0xff;
> > -	} else {
> > -		ver_major = gmux_read8(gmux_data,
> > GMUX_PORT_VERSION_MAJOR);
> > -		ver_minor = gmux_read8(gmux_data,
> > GMUX_PORT_VERSION_MINOR);
> > -		ver_release = gmux_read8(gmux_data,
> > GMUX_PORT_VERSION_RELEASE); }
> > +
> > +	version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
> > +	ver_major = (version >> 24) & 0xff;
> > +	ver_minor = (version >> 16) & 0xff;
> > +	ver_release = (version >> 8) & 0xff;
> > +
> >  	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major,
> > ver_minor, ver_release, (gmux_data->indexed ? "indexed" :
> > "classic")); 
> 
> The problem with this is that there is nothing (no known register)
> at address base + 7 and now you are reading from address base + 7
> here where before the code was not, we have no idea how the hw
> will respond to this.  This should be pretty innocent but still ...

That makes sense, hopefully someone will be able to test it.

> 
> > diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
> > index 1f68b49bcd68..eb2caee04abd 100644
> > --- a/include/linux/apple-gmux.h
> > +++ b/include/linux/apple-gmux.h
> > @@ -67,7 +67,6 @@ static inline bool apple_gmux_is_indexed(unsigned
> > long iostart) */
> >  static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool
> > *indexed_ret) {
> > -	u8 ver_major, ver_minor, ver_release;
> >  	struct device *dev = NULL;
> >  	struct acpi_device *adev;
> >  	struct resource *res;
> > @@ -95,10 +94,7 @@ static inline bool apple_gmux_detect(struct
> > pnp_dev *pnp_dev, bool *indexed_ret)
> >  	 * Invalid version information may indicate either that
> > the gmux
> >  	 * device isn't present or that it's a new one that uses
> > indexed io. */
> > -	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
> > -	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
> > -	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
> > -	if (ver_major == 0xff && ver_minor == 0xff && ver_release
> > == 0xff) {
> > +	if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {  
> 
> Assuming we can get this tested well enough that I'm ok with the
> change in general please write this as:
> 
> 	if (inl(res->start + GMUX_PORT_VERSION_MAJOR) == 0xffffffff) {
> 
> Which I believe is what you are trying to achieve here ?

Yes that is a neater way of doing what I was trying to do, I'll use
that in v2.

> 
> Regards,
> 
> Hans
> 
> 
> 
> >  		indexed = apple_gmux_is_indexed(res->start);
> >  		if (!indexed)
> >  			goto out;  
> 

