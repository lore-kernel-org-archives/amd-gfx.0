Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04659C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 14:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A1410EA99;
	Fri, 11 Feb 2022 14:19:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C0D10EA48
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644571343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JATPSfuuIzbUvjucn3mqiTWieLFcGsiKYRvySMK0CuY=;
 b=MJpWt3UCHCojLJ61Oy4FxeI3nWm2lR3SDqgRdLOZuLP2DU9xFQI6WuMHrwvhQ2fhJ3OGKx
 f80iuS1QZtfj7+w5ilVOmkPpP9rInhpVe4lD/vStp1kb+XVqk0GGFOK+OLWhTinSSnJdhc
 HmJUy8TUSrR/YWk+dUb5GwCAG67Xw+U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-5qXKHflxO8uezhNmKMA88Q-1; Fri, 11 Feb 2022 04:22:22 -0500
X-MC-Unique: 5qXKHflxO8uezhNmKMA88Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 ho37-20020a1709070ea500b006cd51be5cd8so3841718ejc.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 01:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JATPSfuuIzbUvjucn3mqiTWieLFcGsiKYRvySMK0CuY=;
 b=YksuGzkkRiWYxo2KPVZMUCvdJtmKpIS19rLK+gr2W3om6dWtOAZvfR0xjb0piEzwZ6
 TL4a6h8Yan7gMKaRKmrdK3pL/dziPCR734xeDUhOqh4YnADog2O7xo7roTFPsgGwv83V
 AtSG9ZYMLCkSkcGugMnlAJO9O58egRccW9XPs70M731m6DSGOxcLUDSJCT5F29LrfB6a
 nc83wy/QfrRbK98XtdELrzd879dFU/ntCHWl6KtRxewNSKCs+E2fBhRaFxnhvNZE4H2e
 NNZ6IRJfLdaVvBeHFgwM2+Nz5ob5brETBPqkMxoEu/IEcAeFZkxzvtNHMUxcimtT5jRF
 KrmQ==
X-Gm-Message-State: AOAM532CQq/GjlJx0npgHtg+s2R9SSDd7vU9TurvWTsNLnkHvQwbTRQv
 o7U1whD8AeAV9sGg6yQI5HLwpcRUquPU5lujoR9GcNfwXWZOsoS6Qg9FdPla6aXMxpKDGoYoCKT
 /IGNeZULoSoS5DP9WSsJTMzl2Rg==
X-Received: by 2002:a17:906:9741:: with SMTP id
 o1mr634480ejy.452.1644571341198; 
 Fri, 11 Feb 2022 01:22:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJzLEHrlpWTVVnLCXx+X1wR5IUJlkBcCT7V/xFq7SwXUygMIWI6NCaHgu9RUznaxy1V50DlQ==
X-Received: by 2002:a17:906:9741:: with SMTP id
 o1mr634448ejy.452.1644571340909; 
 Fri, 11 Feb 2022 01:22:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1?
 (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
 by smtp.gmail.com with ESMTPSA id y22sm3647503ejm.225.2022.02.11.01.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Feb 2022 01:22:20 -0800 (PST)
Message-ID: <aa1f140d-0f1b-852c-da8b-75e437537ef2@redhat.com>
Date: Fri, 11 Feb 2022 10:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 8/9] platform/x86: amd-gmux: drop the use of
 `pci_is_thunderbolt_attached`
To: Yehezkel Bernat <yehezkelshb@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-9-mario.limonciello@amd.com>
 <CA+CmpXtah8AeVehExk0+eagyP=DQOPEy18DW3t2rQ0ZjyMk-Rw@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CA+CmpXtah8AeVehExk0+eagyP=DQOPEy18DW3t2rQ0ZjyMk-Rw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 11 Feb 2022 14:19:18 +0000
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
Cc: Michael Jamet <michael.jamet@intel.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Alexander.Deucher@amd.com, Mika Westerberg <mika.westerberg@linux.intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2/11/22 10:00, Yehezkel Bernat wrote:
> On Fri, Feb 11, 2022 at 12:43 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Currently `pci_is_thunderbolt_attached` is used to indicate a device
>> is connected externally.
>>
>> The PCI core now marks such devices as removable and downstream drivers
>> can use this instead.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>  drivers/platform/x86/apple-gmux.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
>> index 04232fbc7d56..ffac15b9befd 100644
>> --- a/drivers/platform/x86/apple-gmux.c
>> +++ b/drivers/platform/x86/apple-gmux.c
>> @@ -596,7 +596,7 @@ static int gmux_resume(struct device *dev)
>>
>>  static int is_thunderbolt(struct device *dev, void *data)
>>  {
>> -       return pci_is_thunderbolt_attached(to_pci_dev(dev));
>> +       return dev_is_removable(dev);
>>  }
>>
> 
> Maybe it's only me, but isn't it a bit strange to keep this function named
> `is_thunderbolt` while it's actually about being removable?

The comment above the only caller says:

        /*
         * If Thunderbolt is present, the external DP port is not fully
         * switchable. Force its AUX channel to the discrete GPU.
         */
        gmux_data->external_switchable =
                !bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);

So IHMO keeping the name as is is fine.

Regards,

Hans

