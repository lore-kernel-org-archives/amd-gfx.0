Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A3C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 12:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A23764F18
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 12:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A23764F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8926E580;
	Wed, 17 Mar 2021 12:50:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865EF6E506
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615972801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISzfzQ/IPmRhET4/orSoWQRmEwqfjZENnnmDXST1Uxo=;
 b=Bg3pTb3MIilyDcwqP6U9jZOCVGOxj/XNnNeVXjdIzS7a3zEn8pYA6M745sysNb7BlOhqtJ
 nToWrCMG/dCxsiiyhBrPWbnDwhWSfm9A7Ss4iwEI94oTfvmZUn/DK8clS4y8Qtr1yx7n0P
 /o9Zq3fWAkHBtLw+VJJ2+0OjPmJziN8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-wZHK2vjdMXWP1dLcBs-o1w-1; Wed, 17 Mar 2021 05:18:54 -0400
X-MC-Unique: wZHK2vjdMXWP1dLcBs-o1w-1
Received: by mail-ed1-f71.google.com with SMTP id m8so13338193edv.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 02:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ISzfzQ/IPmRhET4/orSoWQRmEwqfjZENnnmDXST1Uxo=;
 b=Idll/WaFvlG8dgi44oQubC9/xAbtvNVB2QCRnJErvLgJqjSBq/IdO1JELsNHHl9hO5
 qXwdxWkPK78MzZw9p6UJax6oVtT8ugLrTFCE12UQdInjiZKz6A9NgeePM3y+12lbv2m0
 GID6qEIwp1Oz1phtmJ5EZs+99fcqKmO+DPsEYDBGTorhEu3fC/njGcum1hEb0IxZ6b1J
 3UnmmuRlnWn9ytF0K32KQu00F/EHlZTarsvF/HYE61p5nd5UsVy9MksUKVsEMUCA8T0F
 A7Ru7QcuoHRDbU84Q/gq9pQV8rWFitV4gbujQss/m2gbJhVv6OqH+WpSD8avgsV6cKTb
 elCQ==
X-Gm-Message-State: AOAM532lNSuW/1pAOv1KyZmLG8xvBa+kqJiFrffZTf+iyDoMCND1Mfkf
 bri0ORUPJn6Xiuu5kSF/++cI3rNZIKUbwmItdrpInVROt+YSwJM5JxmcKywUBuiuVykv1tu5h1X
 NELzn0ya/aAxkpbXg1D4FmYaWfw==
X-Received: by 2002:aa7:de11:: with SMTP id h17mr7803123edv.83.1615972732941; 
 Wed, 17 Mar 2021 02:18:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5Vki1f67c1FvqFX0zNMhqPKCumzQRxBE+S3SHqyz4ykhSOy+E0AHoUnmgPJw848Jpcto+7A==
X-Received: by 2002:aa7:de11:: with SMTP id h17mr7803108edv.83.1615972732779; 
 Wed, 17 Mar 2021 02:18:52 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id r19sm12071627edp.52.2021.03.17.02.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 02:18:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] platform/x86: force LPS0 functions for AMD
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org
References: <20210316194639.287216-1-alexander.deucher@amd.com>
 <20210316194639.287216-2-alexander.deucher@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <de19e30b-e910-5ef5-53ec-bddb4d865489@redhat.com>
Date: Wed, 17 Mar 2021 10:18:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316194639.287216-2-alexander.deucher@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Wed, 17 Mar 2021 12:50:47 +0000
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
Cc: Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
 Marcin Bachry <hegel666@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 3/16/21 8:46 PM, Alex Deucher wrote:
> ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD are supposedly not
> required for AMD platforms, and on some platforms they are
> not even listed in the function mask but at least some HP
> laptops seem to require it to properly support s0ix.
> 
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> ---
>  drivers/acpi/x86/s2idle.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2d7ddb8a8cb6..dc3cc021125e 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -317,11 +317,16 @@ static void lpi_check_constraints(void)
>  	}
>  }
>  
> +static bool acpi_s2idle_vendor_amd(void)
> +{
> +	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
> +}
> +
>  static void acpi_sleep_run_lps0_dsm(unsigned int func)
>  {
>  	union acpi_object *out_obj;
>  
> -	if (!(lps0_dsm_func_mask & (1 << func)))
> +	if (!acpi_s2idle_vendor_amd() && !(lps0_dsm_func_mask & (1 << func)))
>  		return;
>  
>  	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);

Skipping the dsm_func_mask feels a bit wrong to me. The commit message talks
about there being a need to unconditional make the calls in the case of the
ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD calls. Maybe instead add a "skip_func_mask"
boolean parameter to acpi_sleep_run_lps0_dsm() and set that to false everywhere
except for the 2 ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD calls ?

This way we can control when to skip the check on a call by call basis, rather
then always skipping it on all AMD systems.

Regards,

Hans


> @@ -331,11 +336,6 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
>  			  func, out_obj ? "successful" : "failed");
>  }
>  
> -static bool acpi_s2idle_vendor_amd(void)
> -{
> -	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
> -}
> -
>  static int lps0_device_attach(struct acpi_device *adev,
>  			      const struct acpi_device_id *not_used)
>  {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
