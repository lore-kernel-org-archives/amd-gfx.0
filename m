Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7467FC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 08:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16D210E384;
	Tue,  9 Jan 2024 08:31:47 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA70F10E384
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 08:31:46 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e4582ed74so19373555e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jan 2024 00:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704789105; x=1705393905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rn81nneouBWFr4SZjlBf+I4Wq0V5K933l5iMICD0kbQ=;
 b=kv2Y/BfgC/FsPXYoeXAXFTW1HQCIGZ5YQtWWg7hYW2fCCJ7IGK01PEXY1g7TMzdTri
 DdPGSAOdvfrkz0z215bTIKelq9u/ZJaYmnSQop3xd+VZ44rc1du8IRcj8wdP6hzLyTni
 f4YQo4exmxl2gqEYBzxC7zhTAVnEhPTUsGmlISP+c2I/fnT3Vl5/N3aCdkOSYghmepY+
 BYRsjZ4SGHgX19n76dneHlMsOMx6OweHwAdaUfCFgi8iN2WPB08w03wh+1fvjO45Fb5F
 f+6D1x5gryEb25TV5eLoc+azj+EbeduIXZhM7qlfr8NRfkQiN5CXjrsy3Zex/JTS0jeh
 KSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704789105; x=1705393905;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rn81nneouBWFr4SZjlBf+I4Wq0V5K933l5iMICD0kbQ=;
 b=sNv7RdNaPzUf/mZcb7ztdLTrPwrEdsKVrM4rfrX02nCGyvaGhHvixYnpUW8fvfOdVQ
 +asou7VRrb/L4gYnNDsaI/i7FJwlTSxcYQV7xMEvxFBEXFr0V78l3jZUR8/GDrla6PQx
 gNiKJW5gi3F2XmsaU5//4vpZDsjUReNlqq/iBdWABpd5R3ZxNvciSdLxTD9OEie/tRfC
 J1JCphnb7a96GNb7Y6VUXjgoSPUhSECpXLNx+yK8AJySLFSYTvHpvsfdHFOTC/OBvH/O
 5jJ87+q2EK+XhM1qwZXm2m1SjhjntsL3LCbcpHws7yjK5MvaCks0rnZzYhN1otcSPPMZ
 Pbnw==
X-Gm-Message-State: AOJu0YzDj612LLkJMAQDN+Ei277gWfxEyUvoYjD5feRcZH16OR3bdVTN
 N56sBFTGLAUOREy5a/8EKV0=
X-Google-Smtp-Source: AGHT+IE1VaQeXILDAEg3VVHBW2C/2cK3V7+X3RGTIed0KVEDhvsnalpY7/KsGql3WEQPX6hYgBcQVA==
X-Received: by 2002:a05:600c:511c:b0:40e:424d:5888 with SMTP id
 o28-20020a05600c511c00b0040e424d5888mr1068494wms.7.1704789104879; 
 Tue, 09 Jan 2024 00:31:44 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a05600c3ac600b0040c11fbe581sm2568188wms.27.2024.01.09.00.31.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 00:31:44 -0800 (PST)
Message-ID: <43e7ff66-f6cf-4804-ab90-ee14546dc4b3@gmail.com>
Date: Tue, 9 Jan 2024 09:31:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Documentation for RGB strip on RX 7900 XTX (Reference)
Content-Language: en-US
To: Alexander Koskovich <AKoskovich@protonmail.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <1b679a75-27ee-4682-8bf1-c0defcd9e949@gmail.com>
 <x5k4aAAKV_idHdVtHJSqsc8HjaGPyGe36A9cpXQl_tBbqgHrQ8TaVKm_zoQRodcwfFuGUj4GnnNASL5a7SKfL1H-NH5X4ma5G_vRkXSG35o=@protonmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <x5k4aAAKV_idHdVtHJSqsc8HjaGPyGe36A9cpXQl_tBbqgHrQ8TaVKm_zoQRodcwfFuGUj4GnnNASL5a7SKfL1H-NH5X4ma5G_vRkXSG35o=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.01.24 um 09:23 schrieb Alexander Koskovich:
> Thanks for the info, will take a look.
>
> Also just to clarify, this is the first party AMD 7900 XTX, not a third party AIB (e.g. Sapphire, ASRock, etc).

Yeah, but that doesn't matter.

For the reference designs AMD basically just says how it should look 
like and then somebody else stitches it together. The handling of for 
example how connectors are detected is still the same.

AMD should somewhere have detailed documentation what's on that 
reference board, but to be honest I have absolutely no idea who to ask 
for that. It's simpler to just look into the tables used by all vendors.

Regards,
Christian.

>
>
> On Tuesday, January 9th, 2024 at 3:02 AM, Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>
>
>>
>> Am 08.01.24 um 23:32 schrieb Deucher, Alexander:
>>
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx amd-gfx-bounces@lists.freedesktop.org On Behalf Of
>>>> Alexander Koskovich
>>>> Sent: Sunday, January 7, 2024 11:19 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Subject: Documentation for RGB strip on RX 7900 XTX (Reference)
>>>>
>>>> Hello,
>>>>
>>>> I was wondering if AMD would be able provide any documentation for the
>>>> RGB strip on the reference cooler
>>>> (https://www.amd.com/en/products/graphics/amd-radeon-rx-7900xtx)? It
>>>> looks to be handled via I2C commands to the SMU, but having proper
>>>> documentation would be extremely helpful.
>>>> It depends on the AIB/OEM and how they designed the specific board. The RGB controller will either be attached to the DDCVGA i2c bus on the display hardware or the second SMU i2c bus. The former will require changes to the amdgpu display code to register display i2c buses that are not used by the display connectors on the board so they can be used by 3rd party applications. Currently we only register i2c buses used for display connectors. The latter buses are already registered with the i2c subsystem since they are used for other things like EEPROMs on server and workstation cards and should be available via standard Linux i2c APIs. I'm not sure what i2c LED controllers each AIB vendor uses off hand. https://openrgb.org/index.html would probably be a good resource for that information.
>>
>>
>> It might also be a good idea to look some of the ATOMBIOS tables found
>> on your device.
>>
>> Those tables are filled in by the AIB/OEM with the information which
>> connectors (HDMI, DVI, DP etc...) are on the board and I bet that the
>> information which RGB controller is used and where to find it is
>> somewhere in there as well.
>>
>> Adding Harry from our display team, might be that he has some more hints
>> as well.
>>
>> Christian.
>>
>>> Alex

