Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B31C4708D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 21:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AEB10E141;
	Wed,  7 Dec 2022 21:34:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C502010E141
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670448729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O54su66YMwrnLOZNslYM9ezQO8/3y0DK5VsFhhbAWKM=;
 b=f/MzVNmR0JLVbg91d84Rds3Lrm7siRpmc6jRN657EheGjgQ2QE/BAtcsHE8D46/5gPsasD
 McCIFKzkTHnlbB7JsxplsHRLIibRwVHEv3x3gtIGApTsXwTs4iYSAdbQfU3qIZ/W9bNnFa
 b4i8/NMLhsy3eu3o6PsbQckU8NZKEX8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-shOg8UVKOsynChpxKaMZMQ-1; Wed, 07 Dec 2022 16:32:08 -0500
X-MC-Unique: shOg8UVKOsynChpxKaMZMQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 nc4-20020a1709071c0400b0078a5ceb571bso4043595ejc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Dec 2022 13:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O54su66YMwrnLOZNslYM9ezQO8/3y0DK5VsFhhbAWKM=;
 b=yTQZ1dAM++WOa/RG7iPZC2xTiZ7228xQNn0h+AgnmqCPoIIJZeLy56f22+1RD+XFS8
 QWYgTrrwNS+zBl3u9WDpK0NuQPcKXtO8PR1fh8u0Oj6E+nErJTchS1TiW2MHavPYv8Vq
 o7h+Cl28v4WBj2pdOtJ7ZEQPfjnJpgzsEnQ8DzgjXpMF9GdnmVe4ZW1oQhyoPuVXsWuU
 KDmE2T6i3k7ZqyvRYhSlEy9jlLHythR4MVKyuhI6B2y7iDniVcgbsony+DaXIbonm13Q
 GocWQQZf9cCBBJI/yr8sEGxTktdfS/n6ELlN8vrYSmJIMJCPz5kiBCBzyYmfA0jX7Ce4
 odYA==
X-Gm-Message-State: ANoB5pktz6O83pUHGV1GJMSx+UG9eX35AGzCD/IMAUAiw5/VIIeRyYrO
 V4Lx5jsFhptDg88j0zskDVyJPna4nZmDMLKGKvBr5vbu2p4jWPiw8tukKZSxSxPwHg0bpGQy+BF
 9esnif1aB6oGrcc15BbINkxBbcw==
X-Received: by 2002:a17:906:6149:b0:78d:a154:ae with SMTP id
 p9-20020a170906614900b0078da15400aemr61835183ejl.259.1670448727077; 
 Wed, 07 Dec 2022 13:32:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4/VdLbEomoIXolnYGvgQJrd/6ZotF4DzUhWc53/saDBx87RpgaFv0w/2lXTqRzt8hJ1v8qbA==
X-Received: by 2002:a17:906:6149:b0:78d:a154:ae with SMTP id
 p9-20020a170906614900b0078da15400aemr61835170ejl.259.1670448726789; 
 Wed, 07 Dec 2022 13:32:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170906300c00b007c10d47e748sm2227775ejz.36.2022.12.07.13.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Dec 2022 13:32:06 -0800 (PST)
Message-ID: <0d958ffb-88a6-cef3-d885-b1e0fd00c3fb@redhat.com>
Date: Wed, 7 Dec 2022 22:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] Avoid creating acpi_video0 on desktop APUs
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Daniel Dadap <ddadap@nvidia.com>
References: <20221207193134.763-1-mario.limonciello@amd.com>
 <58ca6ed3-527e-8eed-0c50-64689e464fb4@redhat.com>
 <0c0b2a2c-7e70-50b4-c8e1-ef5e97447217@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0c0b2a2c-7e70-50b4-c8e1-ef5e97447217@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Dec 2022 21:34:28 +0000
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
Cc: linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 12/7/22 22:21, Limonciello, Mario wrote:
> On 12/7/2022 15:04, Hans de Goede wrote:
>> Hi All,
>>
>> Mario, thank you for working on this.
> 
> Sure
> 
> <snip>
>>
>> Note that the problem of the creating a non functional acpi_video0
>> device happened before the overhaul too.
>>
>> The difference is that now we have the in kernel GPU drivers
>> all call acpi_video_register_backlight() when they detect an
>> internal-panel for which they don't provide native-backlight
>> control themselves (to avoid the acpi_video0 backlight registering
>> before the native backlight gets a chance to register).
>>
>> The timeout is only there in case no drivers ever call
>> acpi_video_register_backlight(). nomodeset is one case, but
>> loosing backlight control in the nomodeset case would be fine
>> IMHO. The bigger worry why we have the timeout is because of
>> the nvidia binary driver, for devices which use that driver +
>> rely on apci_video# for backlight control.
>>
>> Back to the issue at hand of the unwanted (non functional)
>> apci_video# on various AMD APU using desktops.
>>
> 
> Thanks for explaining.
> 
>> The native drivers now all calling acpi_video_register_backlight()
>> gives us a chance to actually do something about it, so in that
>> sense the 6.1 backlight refactor is relevant.
>>
>>> To avoid this situation from happening add support for video drivers
>>> to notify the ACPI video detection code that no panel was detected.
>>>
>>> To reduce the risk of regressions on multi-GPU systems:
>>> * only use this logic when the system is reported as a desktop enclosure.
>>> * in the amdgpu code only report into this for APUs.
>>
>> I'm afraid that there still is a potential issue for dual
>> GPU machines. The chassistype is not 100% reliable.
> 
> Have you ever seen an A+N machine with unreliable chassis type?

Not specifically. I just know from experience to not
rely on chassis type.

E.g. I would not be surprised to have some of the desktop-replacement
class laptops from e.g. clevo which sometimes even come with
a desktop CPU for moar power, have their chassis type wrong.

Granted those are not using AMD APUs (yet), but that might change
with the ryzen 7000 series where every CPU is an APU too...

> Given Windows HLK certification and knowing that these are to
> be based off reference BIOS of laptops, I would be really surprised
> if this was wrong on an A+N laptop.

I agree this is unlikely. But I have seen all sort of wrong
chassis-type settings in devices which are not from the
big OEMs.  And AFAIK these sometimes also play fasr and loose
with the Windows certification.

>> Lets say we have a machine with the wrong chassis-type with
>> an AMD APU + nvidia GPU which relies on acpi_video0 for
>> backlight control.
>>
>> Then if the LCD is connected to the nvidia GPU only, the
>> amdgpu code will call the new acpi_video_report_nolcd()
>> function.
> 
> + Dan Dadap
> 
> Dan - the context is this series:
> https://patchwork.freedesktop.org/series/111745/
> 
> Do you know if this is real or just conceptual?
> 
>>
>> And then even if the nvidia binary driver is patched
>> by nvidia to call the new  acpi_video_register_backlight()
>> when it does see a panel, then acpi_video_should_register_backlight()
>> will still return false.
>>
>> Basically the problem is that we only want to not try
>> and register the acpi_video0 backlight on dual GPU
>> machines if the output detection on *both* GPUs has not
>> found any builtin LCD panel.
>>
>> But this series disables acpi_video0 backlight registration
>> as soon as *one* of the *two* GPUs has not found an internal
>> LCD panel.
>>
>> As discussed above, after the backlight refactor,
>> GPU(KMS) drivers are expected to call
>> acpi_video_register_backlight() when necessary for any
>> internal panels connected to the GPU they are driving.
>>
>> This mostly fixes the issue of having an acpi_video0 on
>> desktop APUs, except that the timeout thingie which was
>> added to avoid regressions still causes the acpi_video0
>> backlight to get registered.
>>
>> Note that this timeout is already configurable through
>> the register_backlight_delay module option; and setting
>> that option to 0 disables the timeout based fallback
>> completely.
>>
>> So another fix for this might be to just change the
>> default value of register_backlight_delay to 0 for
>> kernel 6.2 .  This is a change which I want to make
>> eventually anyways; so we might just as well do this
>> now to fix the spurious acpi_video0 on desktop APUs
>> issue.   And if this does cause issues for nvidia
>> binary driver users, they can easily work around this
>> by setting the module option.
>>
>> Or alternatively we could go with this series,
>> reworked so that calling acpi_video_report_nolcd()
>> only cancels the timeout.  This way drivers for another
>> GPU can still get the acpi_video0 if necessary by
>> explicitly calling acpi_video_register_backlight().
>>
>> Personally I have a small preference for just changing
>> the default of register_backlight_delay to 0, disabling
>> the timeout based fallback starting with 6.2 .
> 
> How about we do both?  Then you can always restore register_backlight_delay without risk of introducing
> regression of acpi_video0 coming back to desktop APU's.

Doing both sounds like a good idea, I like it.

It would be great if you can rework the series to just cancel
the timeout from acpi_video_report_nolcd() + add a patch
to change the default register_backlight_delay to 0.

>> I did not do this for 6.1 because there were already
>> many other backlight changes in 6.1, so I wanted to
>> have the fallback behavior there as a safeguard
>> against things not working as planned.
>>
> 
> If you're open to my idea of both since I'm already
> touching all this anyway I am fine to roll that change
> into another patch for default of 0 too in a v2.

Adding the patch for default of 0 sounds great, thanks.

Regards,

Hans



