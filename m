Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBB2C636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 19:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D99810E071;
	Fri, 10 Feb 2023 19:10:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5626510E071
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676056205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wlj+JXAcWLxYE86Ug6fMhTbOB35cUlXqEJcONrx83sg=;
 b=Tc6cpIDGIA8fdEuxfG8c5gyffYUQM4CHZn1+2kAXfc6pr2t++yb+3ti5lgzN7hCPzpU1tc
 IFXarLnJknbanD4rnSUqVKjH5iZRQ3Ybvt2Pc3IfhhPfqDlh3cRvUUJZC79laJ2orZTGZK
 7hwHK0sH1Mv6o4xZZN90RmkkKChHl5Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-sw4EgqxRPMm28pb8cb8BIA-1; Fri, 10 Feb 2023 14:10:01 -0500
X-MC-Unique: sw4EgqxRPMm28pb8cb8BIA-1
Received: by mail-ej1-f70.google.com with SMTP id
 d14-20020a170906c20e00b00889f989d8deso4120838ejz.15
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 11:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wlj+JXAcWLxYE86Ug6fMhTbOB35cUlXqEJcONrx83sg=;
 b=AKE/ddtcUhH9mH3n7XDXrE+n411r3az3k3t58QGQr+tsJ/ew5VidmTRiWLo3K1CGCR
 Zs2783UgXvaEAxbO3P9EXi/Vvh7SUJjyg5xJZLQEOG6IJpah4QUnBTowr/WBOX7zYIvD
 xyV/9hQM87IskBzgKau2X9KAi0kO+jgnQiO1TMBWniezmJrrns16UGX8FhP7KCze5nfO
 tdhxKPxBR7WP5ZaGZbv0nAHvVom0vKcllIip5T7DI/jV0x9gYPYGqtrFYngb63L4jfco
 ZIxRg0Z+TBEAQRy6mTu7Zc+vRsVc8c+YZQXltpcqbjzxdumZAII8PLVqj4EA4UvJ82Ix
 qjHQ==
X-Gm-Message-State: AO0yUKUaOf7QroYpaUmJKNTeOejifZDt0+C3uaKTFAOK9ezZuNkbm6os
 OgvY7BtiK9pf3ShxdcuhF2KbJ+ZOKgWQCpR25OrKfY39ZKZSbRA5z9JGX4zKqdOd9xbbdH1rJNk
 1h71WsPMS5++MqH4X+2vfIriBuQ==
X-Received: by 2002:a17:906:308c:b0:889:14ec:21ae with SMTP id
 12-20020a170906308c00b0088914ec21aemr16104696ejv.32.1676056200869; 
 Fri, 10 Feb 2023 11:10:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/bQ30pqtJ+DR8BHDulCT6yJnSnGVJYAXD4vakdG0Yio03S4TdacumZBH+AU7G5YgQxaLn3ig==
X-Received: by 2002:a17:906:308c:b0:889:14ec:21ae with SMTP id
 12-20020a170906308c00b0088914ec21aemr16104674ejv.32.1676056200632; 
 Fri, 10 Feb 2023 11:10:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a1709063a5700b0087bcda2b07bsm2697548ejf.202.2023.02.10.11.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Feb 2023 11:10:00 -0800 (PST)
Message-ID: <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
Date: Fri, 10 Feb 2023 20:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
To: Orlando Chamberlain <orlandoch.dev@gmail.com>,
 platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-2-orlandoch.dev@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230210044826.9834-2-orlandoch.dev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 19:10:42 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rander Wang <rander.wang@intel.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Evan Quan <evan.quan@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>, Mark Gross <markgross@kernel.org>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2/10/23 05:48, Orlando Chamberlain wrote:
> Currently it manually flips the byte order, but we can instead use
> cpu_to_be32(val) for this.
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 9333f82cfa8a..e8cb084cb81f 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -94,13 +94,7 @@ static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
>  static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
>  			     u32 val)
>  {
> -	int i;
> -	u8 tmpval;
> -
> -	for (i = 0; i < 4; i++) {
> -		tmpval = (val >> (i * 8)) & 0xff;
> -		outb(tmpval, gmux_data->iostart + port + i);
> -	}
> +	outl(cpu_to_be32(val), gmux_data->iostart + port);
>  }
>  
>  static int gmux_index_wait_ready(struct apple_gmux_data *gmux_data)

The ioport / indexed-ioport accessed apple_gmux-es likely are (part of?)
LPC bus devices . Looking at the bus level you are now changing 4 io
accesses with a size of 1 byte, to 1 32 bit io-access.

Depending on the decoding hw in the chip this may work fine,
or this may work not at all.

I realized that you have asked for more testing, but most surviving
macbooks from the older apple-gmux era appear to be models without
a discrete GPU (which are often the first thing to break) and thus
without a gmux.

Unless we get a bunch of testers to show up, which I doubt. I would
prefer slightly bigger / less pretty code and not change the functional
behavior of the driver on these older models.

Regards,

Hans



> @@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct apple_gmux_data *gmux_data, int port)
>  static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
>  			       u32 val)
>  {
> -	int i;
> -	u8 tmpval;
> -
>  	mutex_lock(&gmux_data->index_lock);
> -
> -	for (i = 0; i < 4; i++) {
> -		tmpval = (val >> (i * 8)) & 0xff;
> -		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE + i);
> -	}
> -
> +	outl(cpu_to_be32(val), gmux_data->iostart + GMUX_PORT_VALUE);
>  	gmux_index_wait_ready(gmux_data);
>  	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
>  	gmux_index_wait_complete(gmux_data);

