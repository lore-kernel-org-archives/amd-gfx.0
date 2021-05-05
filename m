Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD7DC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C1661078
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C1661078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388856E48F;
	Wed,  5 May 2021 13:10:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8016E450
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 09:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620205211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOOxG8KwNMz1eFISDrmtfXXoZ2NzbYcR1eDNGbXkN5M=;
 b=iFbpT+rkSj0LwTyEuPoGbLP5D4na0hcCrRDehTfWMyFcFxrT1pVxMsVPpeBoLfGN3YMs4D
 h/UbsfZ66UQtZl5VfZsFxPcPIIBs93nntO/GLIb4qT1MD0UEClKhrZSZyTSjm52ryzHosG
 0v+5p7WzBpeRAOXiOnT4lF+32pUX5rY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-Lnwfpw2yOQqlLnC3H-Mf3Q-1; Wed, 05 May 2021 05:00:09 -0400
X-MC-Unique: Lnwfpw2yOQqlLnC3H-Mf3Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 w20-20020aa7dcd40000b02903886b9b0013so506206edu.22
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 May 2021 02:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nOOxG8KwNMz1eFISDrmtfXXoZ2NzbYcR1eDNGbXkN5M=;
 b=hAKBA7wz9RslMGrK+F4k4BnEtfWGNxpOF4+Q1vLrrPY76zN9lSr0lRvSBGFRXHV32S
 Ok5xhR8ja25Px8Y/g/tv46y4v8yZUBMU9r/pa2JD0W3rYyIaJSXyzsZmAXO6b1I3FcIO
 0feuFJ9OztK6fPdcitmdwjXXnI19IqMsqbs+97eDar4mtyqwOEDkzVHQOet4EX3feT06
 Nc+YBKsJCbYKgOpDciLt4DMWXiyxF7wD6QvnxBRnybNsf+3VU6mAe99xkywlJM1JC9p2
 LAmx2q7fVwKmh8V0EjQ/tNdKNqLU+B79Vm3ubqyeKlOrO4Bam9PIE8burEpHi04ZUz7k
 Zkhw==
X-Gm-Message-State: AOAM530RJXX50HbOeoDb7X9Jp3yjeNadpp9kLYv+496TVX5HpfmH7d8R
 noiOzEFtYyJwlnyZWgqsjnncQU6khQ1k2br25Hx6YrXyyo6UzvCi49l45vb6Lxk5upZ1VjppUZC
 JFakB7tyrzuIjBKl4Uii8qTGvYg==
X-Received: by 2002:a17:906:e88:: with SMTP id
 p8mr25443078ejf.31.1620205207994; 
 Wed, 05 May 2021 02:00:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJTLyyjLte+decu+WLdsqi+cR0B42grizYAH0vUZ74jz9Rb2rhoCs6M4/f1HwDK9+GA0/7wQ==
X-Received: by 2002:a17:906:e88:: with SMTP id
 p8mr25443055ejf.31.1620205207823; 
 Wed, 05 May 2021 02:00:07 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id a22sm15599349edu.14.2021.05.05.02.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 May 2021 02:00:07 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add missing LPS0 functions for AMD
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>
References: <20210504221140.593002-1-alexander.deucher@amd.com>
 <BYAPR12MB2693F7109BC8E7EF9F672A16E25A9@BYAPR12MB2693.namprd12.prod.outlook.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <22c1b9a9-8167-5e4f-6ff7-278c386cc423@redhat.com>
Date: Wed, 5 May 2021 11:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2693F7109BC8E7EF9F672A16E25A9@BYAPR12MB2693.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Wed, 05 May 2021 13:10:12 +0000
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>, Marcin Bachry <hegel666@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 5/5/21 12:33 AM, Limonciello, Mario wrote:
> [AMD Public Use]
> 
>> Subject: [PATCH] platform/x86: Add missing LPS0 functions for AMD
> 
> Rafael might be willing to fix it up on commit, but if you end up needing to re-spin
> I think technically this subsystem prefix to match other stuff committed to this file
> should be:
> 
> "ACPI: PM: s2idle:"

Ack, please get the subject next right time. I was about the put this in a folder
with patches to apply to the pdx86 kernel tree once 5.13-rc1 is out, but this
should not go upstream through the pdx86 tree at all.

Regards,

Hans



> 
>>
>> These are supposedly not required for AMD platforms,
>> but at least some HP laptops seem to require it to
>> properly turn off the keyboard backlight.
>>
>> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
>>
>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Marcin Bachry <hegel666@gmail.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>
>> Dropping patch 2/2 for now.  This patch fixes several
>> systems and doesn't appear to cause any issues.
>>
>>  drivers/acpi/x86/s2idle.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index 2b69536cdccb..2d7ddb8a8cb6 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
>>
>>  /* AMD */
>>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-
>> 932122d37721"
>> +#define ACPI_LPS0_ENTRY_AMD         2
>> +#define ACPI_LPS0_EXIT_AMD          3
>>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
>>  #define ACPI_LPS0_SCREEN_ON_AMD     5
>>
>> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
>>
>>  	if (acpi_s2idle_vendor_amd()) {
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
>> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>>  	} else {
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
>> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
>>  		return;
>>
>>  	if (acpi_s2idle_vendor_amd()) {
>> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>>  	} else {
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>> --
>> 2.30.2
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
