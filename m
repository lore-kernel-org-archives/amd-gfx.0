Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38B2C197A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 15:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCDD10E413;
	Mon, 20 Nov 2023 15:40:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAECF10E395
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700477283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fmHCyTLsVBo0Kc83TqxxdVsk2B46TkdS7UkGLyTjj8=;
 b=bfwB025oHthyMqE4lM2yJJIMs2CU7LGJf3mwtCfwX5m8s7BaSSfkncurhDtTJUnqc23ATi
 Dk4EmROb5e4WXtw6fhnDwkc4bc7IgzS81zlW7bVoR0zJDD2R3K1YCT86S6EdgTT0YNfMqW
 Sx1hoXx1yvHzh+vs8Sf6SCkaMYG+V5A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-96YOpiMPNgq8n5A94PwfIw-1; Mon, 20 Nov 2023 05:48:01 -0500
X-MC-Unique: 96YOpiMPNgq8n5A94PwfIw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5411d71889aso3152988a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 02:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700477280; x=1701082080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0fmHCyTLsVBo0Kc83TqxxdVsk2B46TkdS7UkGLyTjj8=;
 b=PzYLP3XuvKrmCTi3GvUTgzjdonmoQviGEYS3cIthqkHv/TjkITsxSi+2orEpZNSz1R
 mqc93f3wWgOhI6oaY83x2tmlANgFGouORfMM8q547VW4akyb10K23hEATEflhkby/bOQ
 Vf5l56sl9H2C16bhn7tQ/bcxfs2xeL+CEgpMPFvT9+Pu3Njs4l/49HXmy0frbC0iQN5P
 a174koZNFkkiBVT4WpZ5bf0aColjWAbi16X+WN/y8eBwyeDJ5WbTBHbbNjNnu6IL+nAV
 mFR+rNGWZz+utHJHRQaZ2kwrDY/H+OQVP66NCuVF5mE5rwdIECFWUzGuCgWgLin9S3BW
 eD5g==
X-Gm-Message-State: AOJu0YwRizwiDf1Gnj2XTEtJotVpyZFmrgrvzF9ZaH9c057XeerWl4TN
 Af4d7hCgRwq65gKz5NPtEsaKwydN+0aCcgnB00cKCOrOXvAi8yfuLtat7psMnT8rdk0Psc/fLcc
 tYcrgio4triq9OxZZP2pKv6CY4w==
X-Received: by 2002:aa7:c702:0:b0:548:b824:1cb8 with SMTP id
 i2-20020aa7c702000000b00548b8241cb8mr1156618edq.38.1700477280745; 
 Mon, 20 Nov 2023 02:48:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOKYlrVDNsMyV/4F65dLvuDm38zuCaU8IqDF/1O3DU8ss3iUrOKIxHJ5ajO+kL3lmaO+RtpQ==
X-Received: by 2002:aa7:c702:0:b0:548:b824:1cb8 with SMTP id
 i2-20020aa7c702000000b00548b8241cb8mr1156590edq.38.1700477280434; 
 Mon, 20 Nov 2023 02:48:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 u24-20020aa7d998000000b00548b55f5ffdsm1059461eds.16.2023.11.20.02.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 02:47:59 -0800 (PST)
Message-ID: <e74b7896-2915-47bf-803e-25897cbb8eed@redhat.com>
Date: Mon, 20 Nov 2023 11:47:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/9] platform/x86/amd: Add support for AMD ACPI based
 Wifi band RFI mitigation feature
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org, lenb@kernel.org, 
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexander.deucher@amd.com,
 Lijo.Lazar@amd.com, mario.limonciello@amd.com
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <20231017025358.1773598-3-Jun.Ma2@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231017025358.1773598-3-Jun.Ma2@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 20 Nov 2023 15:40:24 +0000
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
Cc: Evan Quan <quanliangl@hotmail.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 10/17/23 04:53, Ma Jun wrote:
> Due to electrical and mechanical constraints in certain platform designs
> there may be likely interference of relatively high-powered harmonics of
> the (G-)DDR memory clocks with local radio module frequency bands used
> by Wifi 6/6e/7.
> 
> To mitigate this, AMD has introduced a mechanism that devices can use to
> notify active use of particular frequencies so that other devices can make
> relative internal adjustments as necessary to avoid this resonance.
> 
> Co-Developed-by: Evan Quan <quanliangl@hotmail.com>
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

<snip>

> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!adev)
> +		return false;
> +
> +	if (!acpi_amd_wbrf_supported_system())
> +		return false;
> +
> +
> +	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +			      WBRF_REVISION,
> +			      BIT(WBRF_RECORD));
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_producer);

So until here you use acpi_dsm methods (1), which matches
with patch 1/9 which says that both producers and consumers
use a _DSM for WBRF.

1) With the exception of the weird acpi_amd_wbrf_supported_system()
helper.

> +static union acpi_object *
> +acpi_evaluate_wbrf(acpi_handle handle, u64 rev, u64 func)
> +{
> +	acpi_status ret;
> +	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object params[4];
> +	struct acpi_object_list input = {
> +		.count = 4,
> +		.pointer = params,
> +	};
> +
> +	params[0].type = ACPI_TYPE_INTEGER;
> +	params[0].integer.value = rev;
> +	params[1].type = ACPI_TYPE_INTEGER;
> +	params[1].integer.value = func;
> +	params[2].type = ACPI_TYPE_PACKAGE;
> +	params[2].package.count = 0;
> +	params[2].package.elements = NULL;
> +	params[3].type = ACPI_TYPE_STRING;
> +	params[3].string.length = 0;
> +	params[3].string.pointer = NULL;
> +
> +	ret = acpi_evaluate_object(handle, "WBRF", &input, &buf);
> +	if (ACPI_FAILURE(ret))
> +		return NULL;
> +
> +	return buf.pointer;
> +}

But now all of a sudden you start calling a WBRF method
directly instead of calling a _DSM by GUID, which seems
to be intended for consumers.

This contradicts with the documentation which says that
consumers also use the _DSM.

And this looks a lot like acpi_evaluate_dsm and
... (continued below)

> +
> +static bool check_acpi_wbrf(acpi_handle handle, u64 rev, u64 funcs)
> +{
> +	int i;
> +	u64 mask = 0;
> +	union acpi_object *obj;
> +
> +	if (funcs == 0)
> +		return false;
> +
> +	obj = acpi_evaluate_wbrf(handle, rev, 0);
> +	if (!obj)
> +		return false;
> +
> +	if (obj->type != ACPI_TYPE_BUFFER)
> +		return false;
> +
> +	/*
> +	 * Bit vector providing supported functions information.
> +	 * Each bit marks support for one specific function of the WBRF method.
> +	 */
> +	for (i = 0; i < obj->buffer.length && i < 8; i++)
> +		mask |= (u64)obj->buffer.pointer[i] << i * 8;
> +
> +	ACPI_FREE(obj);
> +
> +	if ((mask & BIT(WBRF_ENABLED)) && (mask & funcs) == funcs)
> +		return true;
> +
> +	return false;
> +}

This looks exactly like acpi_check_dsm().

> +
> +/**
> + * acpi_amd_wbrf_supported_consumer - determine if the WBRF can be enabled
> + *                                    for the device as a consumer
> + *
> + * @dev: device pointer
> + *
> + * Determine if the platform equipped with necessary implementations to
> + * support WBRF for the device as a consumer.
> + *
> + * Return:
> + * true if WBRF is supported, otherwise returns false.
> + */
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!adev)
> +		return false;
> +
> +	if (!acpi_amd_wbrf_supported_system())
> +		return false;
> +
> +	return check_acpi_wbrf(adev->handle,
> +			       WBRF_REVISION,
> +			       BIT(WBRF_RETRIEVE));
> +}
> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_consumer);

So I would expect this to just use acpi_check_dsm like
is done for the producers.

> +
> +/**
> + * amd_wbrf_retrieve_freq_band - retrieve current active frequency
> + *                                     bands
> + *
> + * @dev: device pointer
> + * @out: output structure containing all the active frequency bands
> + *
> + * Retrieve the current active frequency bands which were broadcasted
> + * by other producers. The consumer who calls this API should take
> + * proper actions if any of the frequency band may cause RFI with its
> + * own frequency band used.
> + *
> + * Return:
> + * 0 for getting wifi freq band successfully.
> + * Returns a negative error code for failure.
> + */
> +int amd_wbrf_retrieve_freq_band(struct device *dev,
> +				      struct wbrf_ranges_in_out *out)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct amd_wbrf_ranges_out acpi_out = {0};
> +	union acpi_object *obj;
> +	int ret = 0;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	obj = acpi_evaluate_wbrf(adev->handle,
> +				 WBRF_REVISION,
> +				 WBRF_RETRIEVE);
> +	if (!obj)
> +		return -EINVAL;

And I would expect this to use acpi_evaluate_dsm(), or
preferably if possible acpi_evaluate_dsm_typed().

Is there any reason why the code is directly calling
a method called WBRF here instead of going through
the _DSM method ?

And if there is such a reason then please update
the documentation to say so, instead of having
the docs clam that consumers also use the _DSM method.

Regards,

Hans


