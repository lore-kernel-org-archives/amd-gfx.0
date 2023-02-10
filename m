Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACDDC636CC
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Feb 2023 06:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CF010E0FE;
	Sat, 11 Feb 2023 06:35:09 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F6A10E00D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 23:44:17 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id v23so8315623plo.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 15:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fkgsxRENqDGY4Cx9OetnsnXOp7kcAjPGOLFEpEWjd0=;
 b=KRnLdCGKanNL32fQh/xTC6YfrzvHoVrAuvdlqUn8gz9KtQ6kEIikF9agEYTH/nkD9I
 +f1Z3ClUcIEMEAHfPBRhDTJSo3uPBKbl3f7/jFLw2bY4TxW7Bm6UWqw33nGLENs1iwTU
 pTsi3mzYraAaSaLs1V32CNl4eowASkrb9uZUN/d0hfu1gb3M4FUeKI9uBUGt3Gop8wUY
 heys1xn5s1uHSh5hUM2uYGy8MBe9cF+rjcpj3nN+keMRu1PV2lhgbrsqaQf2HvUOB25I
 nCnQekfFR/zPKtoFAqjOE/cf3CZHZTSnTSqA0aHoWWLeMBVplj1T5HOd3KEFZXfb6LsZ
 ICuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fkgsxRENqDGY4Cx9OetnsnXOp7kcAjPGOLFEpEWjd0=;
 b=nLfTzeOYa9kniLF6FVkX9Bjeqw+IvkPgmjkWMPDIB/5o4BXjWFl4/dX1N8xyVSHNwE
 2HO1//DBcByw2GyKXUcek5a7+JTfMzfZ/CeTSfF6/3ni8pGHClxnW17k1jCJpmspDuU/
 hdtcxBHhmFjcbeMQGVRhsBuqH1zT4ulU3/bzmLxrI9Pkl/Fuhs34eTV1WWeSHKngEuGE
 of3LwD+4muc8vm8TrqxM9korpDbqPysWLDCjblyVRqvnTwB4DEGMkkZ1fD03cK4RP/Dr
 WsxbNNSLF+vHynFBxMvtolx/iFxOOwdyr0plXRWueG5VdYm9Hb7G7dLOK1Xu6EufSKeF
 T0fQ==
X-Gm-Message-State: AO0yUKUa4M/8GneX/SIOTDMM4yyDZ0AejuHjHwCrc2LV/KuOGhN5S7Yq
 Y9cyrphju68aMHYge4A6Y3g=
X-Google-Smtp-Source: AK7set/G6ky42GLQnLyHdqv5qMLFqaHFxufO7S4Mi7zI8257Or5oq220KUSdFMmRb1folKNGA9afxw==
X-Received: by 2002:a17:90b:3852:b0:230:1acb:191f with SMTP id
 nl18-20020a17090b385200b002301acb191fmr19593287pjb.32.1676072657179; 
 Fri, 10 Feb 2023 15:44:17 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a17090a604300b00230b091288bsm3519570pjm.7.2023.02.10.15.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Feb 2023 15:44:17 -0800 (PST)
Date: Sat, 11 Feb 2023 10:44:03 +1100
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH 7/9] apple-gmux: add sysfs interface
Message-ID: <20230211104403.53017f26@redecorated-mbp>
In-Reply-To: <86054431-8d45-adea-121d-ff39d04d95cc@redhat.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-8-orlandoch.dev@gmail.com>
 <3e6c6cba-ad53-d380-a028-840fb19dbfcb@redhat.com>
 <86054431-8d45-adea-121d-ff39d04d95cc@redhat.com>
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

On Fri, 10 Feb 2023 21:23:15 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/10/23 21:15, Hans de Goede wrote:
> > Hi,
> > 
> > On 2/10/23 05:48, Orlando Chamberlain wrote:  
> >> Allow reading gmux ports from userspace. When the unsafe module
> >> parameter allow_user_writes is true, writing 1 byte
> >> values is also allowed.
> >>
> >> For example:
> >>
> >> cd /sys/bus/acpi/devices/APP000B:00/physical_node/
> >> echo 4 > gmux_selected_port
> >> cat gmux_selected_port_data | xxd -p
> >>
> >> Will show the gmux version information (00000005 in this case)  
> > 
> > Please use debugfs for this and as part of the conversion
> > drop the #ifdef-s (debugfs has stubs for when not enabled)
> > and drop all the error checking of creating the files, debugfs
> > is deliberately designed to not have any error checking in
> > the setup / teardown code.
> > 
> > This also removes the need for the allow_user_writes parameter
> > replacing it with the new kernel lockdown mechanism. debugfs
> > will automatically block access to writable files when
> > the kernel is in lockdown mode.

I'll change it to use debugfs instead of sysfs in v2.

> > 
> > Regards,
> > 
> > Hans  
> 
> p.s.
> 
> I just realized I forgot my usual thank you for contributing
> to the kernel reply to the cover letter before diving into
> the review (oops).
> 
> So let me correct that: thank you very much for your work on this!

thank you for maintaining and reviewing!
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> >> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> >> ---
> >>  drivers/platform/x86/apple-gmux.c | 129
> >> ++++++++++++++++++++++++++++++ 1 file changed, 129 insertions(+)
> >>
> >> diff --git a/drivers/platform/x86/apple-gmux.c
> >> b/drivers/platform/x86/apple-gmux.c index
> >> c38d6ef0c15a..756059d48393 100644 ---
> >> a/drivers/platform/x86/apple-gmux.c +++
> >> b/drivers/platform/x86/apple-gmux.c @@ -66,6 +66,11 @@ struct
> >> apple_gmux_data { enum vga_switcheroo_client_id
> >> switch_state_external; enum vga_switcheroo_state power_state;
> >>  	struct completion powerchange_done;
> >> +
> >> +#ifdef CONFIG_SYSFS
> >> +	/* sysfs data */
> >> +	int selected_port;
> >> +#endif /* CONFIG_SYSFS */
> >>  };
> >>  
> >>  static struct apple_gmux_data *apple_gmux_data;
> >> @@ -651,6 +656,121 @@ static void gmux_notify_handler(acpi_handle
> >> device, u32 value, void *context)
> >> complete(&gmux_data->powerchange_done); }
> >>  
> >> +/**
> >> + * DOC: Sysfs Interface
> >> + *
> >> + * gmux ports can be read from userspace as a sysfs interface.
> >> For example:
> >> + *
> >> + * # echo 4 >
> >> /sys/bus/acpi/devices/APP000B:00/physical_node/gmux_selected_port
> >> + * # cat
> >> /sys/bus/acpi/devices/APP000B:00/physical_node/gmux_selected_port_data
> >> | xxd -p
> >> + * 00000005
> >> + *
> >> + * Reads 4 bytes from port 4 (GMUX_PORT_VERSION_MAJOR).
> >> + *
> >> + * Single byte writes are also supported, however this must be
> >> enabled with the
> >> + * unsafe allow_user_writes module parameter.
> >> + *
> >> + */
> >> +
> >> +#ifdef CONFIG_SYSFS
> >> +
> >> +static bool allow_user_writes;
> >> +module_param_unsafe(allow_user_writes, bool, 0);
> >> +MODULE_PARM_DESC(allow_user_writes, "Allow userspace to write to
> >> gmux ports (default: false) (bool)"); +
> >> +static ssize_t gmux_selected_port_store(struct device *dev,
> >> +		struct device_attribute *attr, const char
> >> *sysfsbuf, size_t count) +{
> >> +	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
> >> +	u8 port;
> >> +
> >> +	if (kstrtou8(sysfsbuf, 10, &port) < 0)
> >> +		return -EINVAL;
> >> +
> >> +	/* On pio gmux's, make sure the user doesn't access too
> >> high of a port. */
> >> +	if ((gmux_data->config == &apple_gmux_pio) &&
> >> +		port > (gmux_data->iolen - 4))
> >> +		return -EINVAL;
> >> +
> >> +	gmux_data->selected_port = port;
> >> +	return count;
> >> +}
> >> +
> >> +static ssize_t gmux_selected_port_show(struct device *dev,
> >> +		struct device_attribute *attr, char *sysfsbuf)
> >> +{
> >> +	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
> >> +
> >> +	return sysfs_emit(sysfsbuf, "%d\n",
> >> gmux_data->selected_port); +}
> >> +
> >> +DEVICE_ATTR_RW(gmux_selected_port);
> >> +
> >> +static ssize_t gmux_selected_port_data_store(struct device *dev,
> >> +		struct device_attribute *attr, const char
> >> *sysfsbuf, size_t count) +{
> >> +	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
> >> +
> >> +	if (count == 1)
> >> +		gmux_write8(gmux_data, gmux_data->selected_port,
> >> *sysfsbuf);
> >> +	else
> >> +		return -EINVAL;
> >> +
> >> +	return count;
> >> +}
> >> +
> >> +static ssize_t gmux_selected_port_data_show(struct device *dev,
> >> +		struct device_attribute *attr, char *sysfsbuf)
> >> +{
> >> +	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
> >> +	u32 data;
> >> +
> >> +	data = gmux_read32(gmux_data, gmux_data->selected_port);
> >> +	memcpy(sysfsbuf, &data, sizeof(data));
> >> +
> >> +	return sizeof(data);
> >> +}
> >> +
> >> +struct device_attribute dev_attr_gmux_selected_port_data_rw =
> >> __ATTR_RW(gmux_selected_port_data); +struct device_attribute
> >> dev_attr_gmux_selected_port_data_ro =
> >> __ATTR_RO(gmux_selected_port_data); + +static int
> >> gmux_init_sysfs(struct pnp_dev *pnp) +{
> >> +	int ret;
> >> +
> >> +	ret = device_create_file(&pnp->dev,
> >> &dev_attr_gmux_selected_port);
> >> +	if (ret)
> >> +		return ret;
> >> +	if (allow_user_writes)
> >> +		ret = device_create_file(&pnp->dev,
> >> &dev_attr_gmux_selected_port_data_rw);
> >> +	else
> >> +		ret = device_create_file(&pnp->dev,
> >> &dev_attr_gmux_selected_port_data_ro);
> >> +	if (ret)
> >> +		device_remove_file(&pnp->dev,
> >> &dev_attr_gmux_selected_port);
> >> +	return ret;
> >> +}
> >> +
> >> +static void gmux_fini_sysfs(struct pnp_dev *pnp)
> >> +{
> >> +	device_remove_file(&pnp->dev,
> >> &dev_attr_gmux_selected_port);
> >> +	if (allow_user_writes)
> >> +		device_remove_file(&pnp->dev,
> >> &dev_attr_gmux_selected_port_data_rw);
> >> +	else
> >> +		device_remove_file(&pnp->dev,
> >> &dev_attr_gmux_selected_port_data_ro); +}
> >> +
> >> +#else
> >> +
> >> +static int gmux_init_sysfs(struct pnp_dev *pnp)
> >> +{
> >> +	return 0;
> >> +}
> >> +static void gmux_fini_sysfs(struct pnp_dev *pnp)
> >> +{
> >> +}
> >> +
> >> +#endif /* CONFIG_SYSFS */
> >> +
> >>  static int gmux_suspend(struct device *dev)
> >>  {
> >>  	struct pnp_dev *pnp = to_pnp_dev(dev);
> >> @@ -846,8 +966,16 @@ static int gmux_probe(struct pnp_dev *pnp,
> >> const struct pnp_device_id *id) goto err_register_handler;
> >>  	}
> >>  
> >> +	ret = gmux_init_sysfs(pnp);
> >> +	if (ret) {
> >> +		pr_err("Failed to register gmux sysfs entries\n");
> >> +		goto err_sysfs;
> >> +	}
> >> +
> >>  	return 0;
> >>  
> >> +err_sysfs:
> >> +	vga_switcheroo_unregister_handler();
> >>  err_register_handler:
> >>  	gmux_disable_interrupts(gmux_data);
> >>  	apple_gmux_data = NULL;
> >> @@ -877,6 +1005,7 @@ static void gmux_remove(struct pnp_dev *pnp)
> >>  {
> >>  	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
> >>  
> >> +	gmux_fini_sysfs(pnp);
> >>  	vga_switcheroo_unregister_handler();
> >>  	gmux_disable_interrupts(gmux_data);
> >>  	if (gmux_data->gpe >= 0) {  
> >   
> 

