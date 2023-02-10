Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0647BC636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 19:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893C310EDEF;
	Fri, 10 Feb 2023 19:45:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B66F10EDF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676058243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LqEMVOprqbRcgnb26iJyeC9PYlAfqxHL1qiXDXu+U9A=;
 b=P8WLh9PFrk2I+PvjtW8GLHlFnXyL9ra6RxE3iSmIbD5dDc9aNFu8rsqxRzHf8qCLf1mYXz
 3ueZ3PohLxF74l/FsGaL3lUGcuWmxGKK4MFl3Gjxu94aKwdMVMmeXV0u+BNH/zqIkmFCAW
 P5tXJo9a1QcVrz3efMZ6J7ZQrZXTjG4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-ZSvRRJ_NNwGwlRK2z7YoLQ-1; Fri, 10 Feb 2023 14:44:00 -0500
X-MC-Unique: ZSvRRJ_NNwGwlRK2z7YoLQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 d14-20020a170906c20e00b00889f989d8deso4163494ejz.15
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 11:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LqEMVOprqbRcgnb26iJyeC9PYlAfqxHL1qiXDXu+U9A=;
 b=0vBnRo4x9N1kMZBF2THcpaFFIpz3ZagKcGx/XTIP9LpRT5S12h49va9ZFhY4ngxqDv
 8IXeCGiMKo9NjUyDVkQ6Z71RpzsQHY3DZ78IkEAr8WUD611xzUdXscsCH1QRgVAawSW3
 3wF5sZ6PKTULGXX/WQCslYa4FcalBwnODuwF+FcltYrQC8fxYAFzX/LUfUy+x8Szdt6S
 LHMA4IqrPxvWVblLnU7MXDqwWVLs8ECILb83+1d3TTR7vhDi+hNCWotTG+ln/GFZ2Mh+
 iyteYHV9exurf61AeRZyb9lPEG/F+wQr81/sF0zDN7rClOhbuxgsx2lkYTHbX9ZFvZOs
 Q66A==
X-Gm-Message-State: AO0yUKXrtQBYRZdooCleX97g/TzgfrBOcbZeDT/S8Nu8Cam3DSZH8ayU
 qAl8EF33u7M8nkX2L4Cex/czKONKW0p9zC/VS3du6n26QZptAV79AXX3Vx2NYc5O/wnkjcQ7wRu
 vtjYXKofvL6FzcF69ud01TZ+iwQ==
X-Received: by 2002:a17:906:a1d3:b0:878:7cf3:a9e7 with SMTP id
 bx19-20020a170906a1d300b008787cf3a9e7mr14861839ejb.65.1676058239628; 
 Fri, 10 Feb 2023 11:43:59 -0800 (PST)
X-Google-Smtp-Source: AK7set9tc5ya+xq3T9ohLhPWkzaq1RTuRLg/Wi00GiP7Oc96aPjNzatgLBaKs4/WUVNxcjQaldtHxA==
X-Received: by 2002:a17:906:a1d3:b0:878:7cf3:a9e7 with SMTP id
 bx19-20020a170906a1d300b008787cf3a9e7mr14861809ejb.65.1676058239467; 
 Fri, 10 Feb 2023 11:43:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a170906c09400b00872c0bccab2sm2786828ejz.35.2023.02.10.11.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Feb 2023 11:43:58 -0800 (PST)
Message-ID: <ee952253-9ee4-aa81-fefa-609cbf6e1e2b@redhat.com>
Date: Fri, 10 Feb 2023 20:43:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 5/9] apple-gmux: Use GMSP acpi method for interrupt
 clear
To: Orlando Chamberlain <orlandoch.dev@gmail.com>,
 platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-6-orlandoch.dev@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230210044826.9834-6-orlandoch.dev@gmail.com>
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
> This is needed for interrupts to be cleared correctly on MMIO based
> gmux's. It is untested if this helps/hinders other gmux types, but I
> have seen the GMSP method in the acpi tables of a MacBook with an
> indexed gmux.
> 
> If this turns out to break support for older gmux's, this can instead
> be only done on MMIO gmux's.
> 
> There is also a "GMLV" acpi method, and the "GMSP" method can be called
> with 1 as its argument, but the purposes of these aren't known and they
> don't seem to be needed.
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 760434a527c1..c605f036ea0b 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -494,8 +494,29 @@ static const struct apple_gmux_config apple_gmux_index = {
>   * MCP79, on all following generations it's GPIO pin 6 of the Intel PCH.
>   * The GPE merely signals that an interrupt occurred, the actual type of event
>   * is identified by reading a gmux register.
> + *
> + * On MMIO gmux's, we also need to call the acpi method GMSP to properly clear
> + * interrupts. TODO: Do other types need this? Does this break other types?
>   */
>  
> +static int gmux_call_acpi_gmsp(struct apple_gmux_data *gmux_data, int arg)
> +{
> +	acpi_status status = AE_OK;
> +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +	struct acpi_object_list arg_list = { 1, &arg0 };
> +
> +	arg0.integer.value = arg;
> +
> +	status = acpi_evaluate_object(gmux_data->dhandle, "GMSP", &arg_list, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("GMSP call failed: %s\n",
> +		       acpi_format_exception(status));
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
>  {
>  	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_ENABLE,
> @@ -519,7 +540,10 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
>  
>  	/* to clear interrupts write back current status */
>  	status = gmux_interrupt_get_status(gmux_data);
> -	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +	if (status) {
> +		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +		gmux_call_acpi_gmsp(gmux_data, 0);

Ugh no, please don't go around calling random ACPI methods from untested
firmware revisions / device models.

ACPI code (even Apple's I have learned) tends to be full of bugs. If we
did not need to call GMSP before then please lets keep not calling it
on the older models. Just because it is there does not mean that calling
it is useful, it might even be harmful.

Regards,

Hans






> +	}
>  }
>  
>  static void gmux_notify_handler(acpi_handle device, u32 value, void *context)

