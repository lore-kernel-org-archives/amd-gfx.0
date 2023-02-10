Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324D8C636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 19:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE13E10EDF0;
	Fri, 10 Feb 2023 19:45:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7859896EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 19:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676058085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrfOu3qaR69ccH7DuaoAFvxzQf97CmjDnDorDQCgmI4=;
 b=FWJvDZwuFqFXgJypApKMEai6lzQuVxlc+MLRGqK/WA6HP97LlofS58KqaWGdbApy7UH7i7
 w5IWPwU9ClKbSOi/OiMwfHtZA9dq9xQcpX+Oe2YYm90jzGleQEDDTWlPxcBsugovnodt3L
 QE2LqCJIXfVcUreZ2bI5TtLkvHPy1zo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-sZ3ZxV1rNdChhhafCQmUvQ-1; Fri, 10 Feb 2023 14:41:22 -0500
X-MC-Unique: sZ3ZxV1rNdChhhafCQmUvQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 eq22-20020a056402299600b004ab4da4a530so1415123edb.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 11:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lrfOu3qaR69ccH7DuaoAFvxzQf97CmjDnDorDQCgmI4=;
 b=NpGegGbJC/ekUz9DH71F39VzUo2+BJYiipsOxmjaK4CnQ0dWIBbgjnzYQDwOcBz9SI
 ugoO7Z9hmbidCi+rk6V4ROA6L6Zdm9yQKVqlJnVpdZlFkcRg06Aj/Vv4Mtg11cXVPaJx
 NmgLU6LUS5cQKpOt9kyXGi/7O/jhGIsgbhhdcgkMzVojTdfY85p+2LbGIDzSsagaK6eW
 wVGmBb7Kth1PYZbsn0+GNoJb2Ka1rf2H3hy0fY47YmkYZpVZQfTcGUyQYqjHzXzEJlV1
 AYSNB2ILzPFEBLdTR1KqxtEYF/0m7mryHQLxa6Y5T5AaX9FvM7zObcpl6Ijvho9nCjrw
 XrKg==
X-Gm-Message-State: AO0yUKXcqk/7oYaupUMPKOBFOL3de5pu4snyPzzHi2/jtpBTWKsu3jDP
 1g18C9Hip7LXuwadV4ZR5L8hG2hQfasyNPGC16lbRGsnrnK5FXej+wJNz51y1vD//J+2uTXUKPW
 4QCLwKiZnKW+wIdoE9XckTZq99w==
X-Received: by 2002:a17:907:9484:b0:878:509f:798c with SMTP id
 dm4-20020a170907948400b00878509f798cmr20702893ejc.4.1676058081364; 
 Fri, 10 Feb 2023 11:41:21 -0800 (PST)
X-Google-Smtp-Source: AK7set8TTPRmaKf4d7r24Su7XzcDrt+64y6chZ0ujIOQt9F+tOX9hkZWuSzrrt1tNe/19CqcVroqsA==
X-Received: by 2002:a17:907:9484:b0:878:509f:798c with SMTP id
 dm4-20020a170907948400b00878509f798cmr20702858ejc.4.1676058081200; 
 Fri, 10 Feb 2023 11:41:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a170906150c00b00888d593ce76sm2789667ejd.72.2023.02.10.11.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Feb 2023 11:41:20 -0800 (PST)
Message-ID: <f4992ffa-68db-7f8c-b92d-a0e1348a7839@redhat.com>
Date: Fri, 10 Feb 2023 20:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 2/9] apple-gmux: consolidate version reading
To: Orlando Chamberlain <orlandoch.dev@gmail.com>,
 platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-3-orlandoch.dev@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230210044826.9834-3-orlandoch.dev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 19:45:00 +0000
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
> Read gmux version in one go as 32 bits on both indexed and classic
> gmux's.
> 
> Classic gmux's used to read the version as
> 
> major = inb(base + 0x4);
> minor = inb(base + 0x5);
> release = inb(base + 0x6);
> 
> but this can instead be done the same way as indexed gmux's with
> gmux_read32(), so the same version reading code is used for classic
> and indexed gmux's (as well as mmio gmux's that will be added to this
> driver).
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 14 ++++++--------
>  include/linux/apple-gmux.h        |  6 +-----
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index e8cb084cb81f..67628104f31a 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -580,15 +580,13 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  	if (indexed) {
>  		mutex_init(&gmux_data->index_lock);
>  		gmux_data->indexed = true;
> -		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
> -		ver_major = (version >> 24) & 0xff;
> -		ver_minor = (version >> 16) & 0xff;
> -		ver_release = (version >> 8) & 0xff;
> -	} else {
> -		ver_major = gmux_read8(gmux_data, GMUX_PORT_VERSION_MAJOR);
> -		ver_minor = gmux_read8(gmux_data, GMUX_PORT_VERSION_MINOR);
> -		ver_release = gmux_read8(gmux_data, GMUX_PORT_VERSION_RELEASE);
>  	}
> +
> +	version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
> +	ver_major = (version >> 24) & 0xff;
> +	ver_minor = (version >> 16) & 0xff;
> +	ver_release = (version >> 8) & 0xff;
> +
>  	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
>  		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
>  

The problem with this is that there is nothing (no known register)
at address base + 7 and now you are reading from address base + 7
here where before the code was not, we have no idea how the hw
will respond to this.  This should be pretty innocent but still ...

> diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
> index 1f68b49bcd68..eb2caee04abd 100644
> --- a/include/linux/apple-gmux.h
> +++ b/include/linux/apple-gmux.h
> @@ -67,7 +67,6 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
>   */
>  static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
>  {
> -	u8 ver_major, ver_minor, ver_release;
>  	struct device *dev = NULL;
>  	struct acpi_device *adev;
>  	struct resource *res;
> @@ -95,10 +94,7 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
>  	 * Invalid version information may indicate either that the gmux
>  	 * device isn't present or that it's a new one that uses indexed io.
>  	 */
> -	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
> -	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
> -	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
> -	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
> +	if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {

Assuming we can get this tested well enough that I'm ok with the change in general
please write this as:

	if (inl(res->start + GMUX_PORT_VERSION_MAJOR) == 0xffffffff) {

Which I believe is what you are trying to achieve here ?

Regards,

Hans



>  		indexed = apple_gmux_is_indexed(res->start);
>  		if (!indexed)
>  			goto out;

