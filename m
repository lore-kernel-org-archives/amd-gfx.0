Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9F1C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 16:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6468410E293;
	Fri, 10 Feb 2023 16:10:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1E010E28A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676045237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlezyZ0ctjzjBsdQv4yB2m2kychWterO+IryIxlv3FU=;
 b=g5ml9bXE8mS1NxP86hPI2/QgAGsfbqg6eGbCakKvi8KVWMWWln0MeRJkI2jK9/qrVIskaB
 torVeLE3NwvZMS4mPZk7WNzszCiCqNJ03f0Rwlae9kzeX7t9s5dq3NNaUmUpIJvNDe65u2
 zp8xIYmqNqezxVgpBca1/XiPDt0ATfw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412-bIYx1Gp6OO23CMUDwv5jTQ-1; Fri, 10 Feb 2023 11:07:16 -0500
X-MC-Unique: bIYx1Gp6OO23CMUDwv5jTQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 s20-20020a05640217d400b004ab46449f12so1706476edy.23
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 08:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BlezyZ0ctjzjBsdQv4yB2m2kychWterO+IryIxlv3FU=;
 b=3rSCDisZqdMkeTbLMMUMbrRSZQSU1lDlFd1dP9gy0wSgGocB7wNeZJvrfJUDHe2Qpo
 qys9Bcf9OYAxloVUygMYCkH9j80rGQKXXi3P0asTM4ZMn/qDsuCQlwmAdcgMolUJZV1t
 0IxMBAES3IJ7Cb1UNz/nH23XKASCYo/Ap74vEA6a8QTA0EaEfroiMRnggF+gl6Np/Cgo
 CmTpOcXMPQGXhgc+tGulAN21Xru9BReWMYUPQLl+yKq6H76PQUHv7Fkt7vpjWTdRm5IS
 b1asg9jYBcbkTJZPAU4mCn3fA9kE5BVAxSv04CF9dm4degOuafSXbjbiZhesZNhb0GfP
 pnDg==
X-Gm-Message-State: AO0yUKW2Vnz1RL7h+D7GesH+fJ2IGXVk8sjw2ZNaHMpbrZyjzlfxG7Dz
 /J7oIjTyBUj2GIUqDYntXXGmpNqH1gautJLhx52CLgdebd7sj05tyulABCAB1D7pNq7Vu2Ggu05
 m6nwtfVBCY1fWzh68YQv9BQfoag==
X-Received: by 2002:a17:906:6a20:b0:8af:33f8:dcb3 with SMTP id
 qw32-20020a1709066a2000b008af33f8dcb3mr8867483ejc.57.1676045235446; 
 Fri, 10 Feb 2023 08:07:15 -0800 (PST)
X-Google-Smtp-Source: AK7set8xLB5+EcBlsR4FtkzhXIqY7I7EBw8qioq1VaRXVB+Bc7ZWbenCJq8C4WMCGwJXM+0m0vfbkw==
X-Received: by 2002:a17:906:6a20:b0:8af:33f8:dcb3 with SMTP id
 qw32-20020a1709066a2000b008af33f8dcb3mr8867452ejc.57.1676045235208; 
 Fri, 10 Feb 2023 08:07:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a170906858700b00883ec4c63ddsm2586397ejx.146.2023.02.10.08.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Feb 2023 08:07:14 -0800 (PST)
Message-ID: <b3a2d525-b30c-164c-705c-97fcb0016540@redhat.com>
Date: Fri, 10 Feb 2023 17:07:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 9/9] drm/amdgpu: register a vga_switcheroo client for
 all GPUs that are not thunderbolt attached
To: Alex Deucher <alexdeucher@gmail.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-10-orlandoch.dev@gmail.com>
 <CADnq5_PVsrk4+K45kVgU=r98B9GgC2CxbC8AvGUXRtv2sZAHPg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CADnq5_PVsrk4+K45kVgU=r98B9GgC2CxbC8AvGUXRtv2sZAHPg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 16:10:44 +0000
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
Cc: alsa-devel@alsa-project.org,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Rander Wang <rander.wang@intel.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Evan Quan <evan.quan@amd.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, Yong Zhi <yong.zhi@intel.com>,
 Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>, Mark Gross <markgross@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Kerem Karabay <kekrby@gmail.com>,
 platform-driver-x86@vger.kernel.org, Jack Xiao <Jack.Xiao@amd.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Aditya Garg <gargaditya08@live.com>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2/10/23 16:53, Alex Deucher wrote:
> On Fri, Feb 10, 2023 at 3:04 AM Orlando Chamberlain
> <orlandoch.dev@gmail.com> wrote:
>>
>> From: Kerem Karabay <kekrby@gmail.com>
>>
>> Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
>> vga_switcheroo") made amdgpu only register a vga_switcheroo client for
>> GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
>> register, but don't have PX. Instead of AMD's PX, they use apple-gmux.
> 
> Is there a way to detect apple-gmux instead?  Otherwise, we register
> vga_switcheroo on any system with multiple GPUs which is not what we
> want.

Yes since 6.1.y (either stable series or just take 6.2.0) the apple-gmux
detect code has been factored out into a stand-alone
apple_gmux_detect() helper inside:

include/linux/apple-gmux.h

For usage outside of the actual apple-gmux driver you can simply
pass NULL for both arguments.

This was necessary to reliably check if the apple-gmux should be
used for backlight control.

Note there also is the older apple_gmux_present() helper, which is
already used in some drm code. That function is not reliable though
it detects if the ACPI tables contain an ACPI device describing
the presence of a gmux, but it turns out even Apple has buggy ACPI
tables and the mere presence of that ACPI device is not a reliable
indicator the gmux is actually there.

I have not changed over any of the existing apple_gmux_present()
users for fear of unwanted side effects...

Regards,

Hans




>> Revert to the old logic of registering for all non-thunderbolt gpus,
>> like radeon and nouveau.
>>
>> Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
>> Signed-off-by: Kerem Karabay <kekrby@gmail.com>
>> [Orlando Chamberlain <orlandoch.dev@gmail.com>: add commit description]
>> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 2f28a8c02f64..0bb553a61552 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3919,12 +3919,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>>                 vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
>>
>> -       if (amdgpu_device_supports_px(ddev)) {
>> -               px = true;
>> -               vga_switcheroo_register_client(adev->pdev,
>> -                                              &amdgpu_switcheroo_ops, px);
>> +       px = amdgpu_device_supports_px(ddev);
>> +
>> +       if (!pci_is_thunderbolt_attached(adev->pdev))
>> +               vga_switcheroo_register_client(adev->pdev, &amdgpu_switcheroo_ops, px);
>> +
>> +       if (px)
>>                 vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
>> -       }
>>
>>         if (adev->gmc.xgmi.pending_reset)
>>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>> @@ -4048,10 +4049,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>
>>         kfree(adev->bios);
>>         adev->bios = NULL;
>> -       if (amdgpu_device_supports_px(adev_to_drm(adev))) {
>> +
>> +       if (!pci_is_thunderbolt_attached(adev->pdev))
>>                 vga_switcheroo_unregister_client(adev->pdev);
>> +
>> +       if (amdgpu_device_supports_px(adev_to_drm(adev)))
>>                 vga_switcheroo_fini_domain_pm_ops(adev->dev);
>> -       }
>> +
>>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>>                 vga_client_unregister(adev->pdev);
>>
>> --
>> 2.39.1
>>
> 

