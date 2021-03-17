Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB05C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 12:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086C064F18
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 12:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086C064F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC2D6E546;
	Wed, 17 Mar 2021 12:50:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE566E50B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 09:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615972580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezgL+/5ajoQ5DL0i1PwRjRopGxlsHomHBU/6UBrTjAg=;
 b=PZedBeeSP/ZSt+iYybg+CgvPVy6GNW5c0tUbF9PfNMYswIgrhXzXU54q3ftadDffpds0ZE
 9I2IcPulH4m8zmIePWYtgc2sd8ZqkZq8NXmdpYKbVXmuQNdRG+rCimxu1WWrH4mIVG+xTm
 UTQLVamZMHuD0Y557J517zGb4x0hWkM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-PmH3I7QOPmerTZVS_gVyIw-1; Wed, 17 Mar 2021 05:16:18 -0400
X-MC-Unique: PmH3I7QOPmerTZVS_gVyIw-1
Received: by mail-ed1-f69.google.com with SMTP id m8so13335282edv.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 02:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ezgL+/5ajoQ5DL0i1PwRjRopGxlsHomHBU/6UBrTjAg=;
 b=uCIFcdJMTogCPHzpIV6bhnXAa2HzSxpg9opQUX6kvRyT2GXx01Q+VMA0KG7TVoMeQa
 Qr7PruxSu15qxgMfFHtSQXL/98SQrl9Zi/6RHZizzLMu02/ShUgKeLYkrM+WAwjIi3Dd
 hrWtonchLaAwWYiPMEH3gA1SBP6mLTd16Px6i3H2l2+C7lqpvDJcepfM7GhX7KkjHlFn
 j78Imo8pxl8SZ7D1snHHwlLXguFqMEaKL9N6oOHS6WhRcPrNiM0ogLLq9FrjLgxXV12v
 Hm2mruCt/jy/378ITOkqCYd7eFt4QupAowYaOb6IQD75kskAc74DtCQ3ctm/DbfXovpY
 08Qg==
X-Gm-Message-State: AOAM532KNN2ILGA7vEaeDOn33XBSuCllXCSywOCI83FGf0VW7gPmaSAm
 Z7XJXbhGggy5h3TS/hU2rpqk/a4cBFnwwEUGPRP2gptQ0QWMX2H/D6BbxjqoOm+xPPgLZusezx6
 6V64AsJr5Hl/TJUzX1ogOmRr8ZQ==
X-Received: by 2002:a17:907:a06b:: with SMTP id
 ia11mr33927479ejc.294.1615972576886; 
 Wed, 17 Mar 2021 02:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7jjpdDMxbW+XNL49aWfAClHqnec+uYzupjWEAOvDPK/ZPxcHSEt7GO1YyJ3VmFRx/bEKccQ==
X-Received: by 2002:a17:907:a06b:: with SMTP id
 ia11mr33927469ejc.294.1615972576738; 
 Wed, 17 Mar 2021 02:16:16 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id g21sm10944066ejd.6.2021.03.17.02.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 02:16:16 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform/x86: Add missing LPS0 functions for AMD
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org
References: <20210316194639.287216-1-alexander.deucher@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <904272c4-1f8c-366e-953a-af1d747fed1b@redhat.com>
Date: Wed, 17 Mar 2021 10:16:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316194639.287216-1-alexander.deucher@amd.com>
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
> These are supposedly not required for AMD platforms,
> but at least some HP laptops seem to require it to
> properly turn off the keyboard backlight.
> 
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/acpi/x86/s2idle.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2b69536cdccb..2d7ddb8a8cb6 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
>  
>  /* AMD */
>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
> +#define ACPI_LPS0_ENTRY_AMD         2
> +#define ACPI_LPS0_EXIT_AMD          3
>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
>  #define ACPI_LPS0_SCREEN_ON_AMD     5
>  
> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
>  
>  	if (acpi_s2idle_vendor_amd()) {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>  	} else {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
>  		return;
>  
>  	if (acpi_s2idle_vendor_amd()) {
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>  	} else {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
