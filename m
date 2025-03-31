Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C394C36014
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 14:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF1710E5CB;
	Tue,  1 Apr 2025 14:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ekvieKhs";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DCB10E123
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743426239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4culuXjcgmXNKuzg57/s8f15AmqI9BMZ7nG6QaACzLE=;
 b=ekvieKhshM5QnKI6JreNxq68sd+bY+K7UAva6iGLv1KT9NTN0say6OYeOhFn/72B4GI2jF
 JaFtycbuviivTwtfUsxB038W2yiUk46fSqvFqfef7yQKH2ICQVGvFPVp2Y+179qVac9WA6
 jd3Wz2d1ytuIT6JoMaR1Iv1Y+C27iM0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-ZouywSM8M8q402qZWfPHyw-1; Mon, 31 Mar 2025 09:03:56 -0400
X-MC-Unique: ZouywSM8M8q402qZWfPHyw-1
X-Mimecast-MFC-AGG-ID: ZouywSM8M8q402qZWfPHyw_1743426236
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e82390b87fso4164844a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 06:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743426236; x=1744031036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4culuXjcgmXNKuzg57/s8f15AmqI9BMZ7nG6QaACzLE=;
 b=lNwu5Ei+sja0sNlr9xMSL+VXZfDfTqUSgjQ3QgyDv/AlMvm4Te+4ST0bOYUmNdVwA8
 hodEN8Z00KF+wPQ81DMuKqnPL4jHmR5lhliymF86LqIa1xdfdnVmiom87MzOa8wb2Zxg
 uVEG9rnFmnKBu3hmZpD3+Z2+hi00epkEruXkSAYUpiOoJyXJxVma0dNTr1GkLHZ64SEu
 dU2pi4ru6OwEwufwlkN/zlYLJSN+FmKOsWBKOxr5B7Nw0vqKPTLpWZq1wZBD3VUdvw0p
 EBciShspcfEimzRNrR4+lPcEmQgsFD6x5J99riRMeNSC7U79HnZNT3/oz5FZSh6yXEKS
 E9Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXAV9N3cPCdg022APEbtvfWpZZT3aP9bxKV4EwejpV7pSrVpb8XN9AN62hc5gqp+DYPdPJnEB8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxRAtq/YnB1G64GZy/J2h37f4GARxY26yiznOQRJkf9MGMornn
 Y3gIrcaorXjzP2YCoTzDIDDU50o7K92j4cZFJyhSHc/G//asG5uTw/YadDOQLgj2NtSUc0fkPw3
 ZevZcG20Q4cKbyE/HM3kx0RaL1GJY6cesZ1C0W/rYHCs2gq0PEg8uiw1uHqCsfvU=
X-Gm-Gg: ASbGncuXSFeMO0mop8OdFo+tFiYLaUCEzMlLaWbvBzKyYPkCA1TjhDG/i116f4wt6xA
 193lcR7mgrhCGB+jFVTJf68dHfzpXpgDvDqgi1GozYylyQoE5J5DrYFtscJ+T1wgoEDnL0ATnWy
 Kv2cCkG+G5hAGB/z2/sbCZSnQJgtLEU+LGvhYnRJc3yzJ7ZxUYRfiDNqdeJPw8UgAVYLDLNGg85
 Ypa5LSEub/I1q5dVYiX3IdqQho+5WAvutfTh0qqX6hReStHqfAFU8SRDAsJqZ5Y8sWs3+dWTgh0
 BI77a8CVx1O2RyUFNexJMxi0OS10H0r5yI1iIrUKlc7KPx4vKrxQYFfwbIeMdIa1XczL+e/ktMi
 i4+4JionCqNthHeZM/vAnPURllvz4aO3hRfEIpRajFzwCsY2ScpbR7ui5uiSocGBBGQ==
X-Received: by 2002:a05:6402:2811:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5edfceacc98mr8444257a12.13.1743426235571; 
 Mon, 31 Mar 2025 06:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAeVVOke/LS4lE00zJMWgP3UdiPgSf/VxY+uNdgJT2WpOp2xnEI7her8oYxikVPibhMjwtDQ==
X-Received: by 2002:a05:6402:2811:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5edfceacc98mr8444194a12.13.1743426235114; 
 Mon, 31 Mar 2025 06:03:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edcaac38f4sm4949440a12.10.2025.03.31.06.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 06:03:54 -0700 (PDT)
Message-ID: <d3dfe61a-1d4d-4aa6-870c-61249799e6da@redhat.com>
Date: Mon, 31 Mar 2025 15:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: "Rafael J. Wysocki" <rafael@kernel.org>, Gergo Koteles <soyer@irl.hu>
Cc: Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
 <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qvrX9-0OMrpCk-4nbx38OMyfPI4jihj68CNHPk7Jh_c_1743426236
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:10:13 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 31-Mar-25 1:46 PM, Rafael J. Wysocki wrote:
> On Fri, Mar 28, 2025 at 10:09 PM Gergo Koteles <soyer@irl.hu> wrote:
>>
>> The _DDC method should return a buffer, or an integer in case of an error.
>> But some Lenovo laptops incorrectly return EDID as buffer in ACPI package.
>>
>> Calling _DDC generates this ACPI Warning:
>> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
>> found Package, expected Integer/Buffer (20240827/nspredef-254)
>>
>> Use the first element of the package to get the EDID buffer.
>>
>> The DSDT:
>>
>> Name (AUOP, Package (0x01)
>> {
>>         Buffer (0x80)
>>         {
>>         ...
>>         }
>> })
>>
>> ...
>>
>> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
>> {
>>         If ((PAID == AUID))
>>         {
>>                 Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
>>         }
>>         ElseIf ((PAID == IVID))
>>         {
>>                 Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
>>         }
>>         ElseIf ((PAID == BOID))
>>         {
>>                 Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
>>         }
>>         ElseIf ((PAID == SAID))
>>         {
>>                 Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
>>         }
>>
>>         Return (Zero)
>> }
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
>> Cc: stable@vger.kernel.org
>> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
>> Changes in v2:
>>  - Added comment
>>  - Improved commit message
>>  - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu/
> 
> Hans, any concerns here?

No the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
>>  drivers/acpi/acpi_video.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index efdadc74e3f4..103f29661576 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -649,6 +649,13 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
>>
>>         obj = buffer.pointer;
>>
>> +       /*
>> +        * Some buggy implementations incorrectly return the EDID buffer in an ACPI package.
>> +        * In this case, extract the buffer from the package.
>> +        */
>> +       if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 1)
>> +               obj = &obj->package.elements[0];
>> +
>>         if (obj && obj->type == ACPI_TYPE_BUFFER) {
>>                 *edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
>>                 ret = *edid ? obj->buffer.length : -ENOMEM;
>> @@ -658,7 +665,7 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
>>                 ret = -EFAULT;
>>         }
>>
>> -       kfree(obj);
>> +       kfree(buffer.pointer);
>>         return ret;
>>  }
>>
>> --
>> 2.49.0
>>
> 

