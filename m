Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC609C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 14:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A94110E045;
	Wed, 20 Dec 2023 14:06:30 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A86310E0E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 14:06:28 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3364c9ff8e1so477679f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 06:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703081187; x=1703685987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CDVPZ8hDOQoXwOv7U3NTl6AHUOGWxhGnp0qiseqmqKs=;
 b=SnPk6xOIYEobX2ht5/U+NtyWF2uwEGBhQX5sbkawJWeHPVf0CNDOdhPfxKqb2MkbMc
 AmGOaZDvOa0Xp4gKxTCDdzBtAFKDOVu0a3DG1RBPjTYn8wQuT3F8AcxYGtN9XQt2QIqO
 O08PI828FFBj5mxGLQt6bS87N2LXS0Izp7QKMVb6x8xrgYnHurH1MexeuqwbuVMwzgy+
 9u+g7ynXRDsMBJFieGSEJSmuq55y/WpCySVr3LILvHToOXrpXu6ECiEjB2DRpdW/Ltjt
 wZSdEMGpa9ZOSN7JxsrtE+osNJmTsD4i5tLH+/jGcUISpcP69i2mEY6gYNP4ekHOcbW9
 wvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703081187; x=1703685987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDVPZ8hDOQoXwOv7U3NTl6AHUOGWxhGnp0qiseqmqKs=;
 b=XI1vPMDJUljWXw8lULx5Z6VBvftSro3fKYOvP4/OWC2aHVzhC+/lh5MQyV3duSAS/Y
 Oxuq89tdzKEjDpN8dKdt4Iy8HUnlTvdQhjJq9cxRf/7gBiExlXFQnfG7l+4lmDPp1p6P
 kXI7LUjxJ9IrllCNfdHDKBOChNb89GhN7Mlr8o1oXZqsZdOrqanCXyOoSbVdHsGbDhPt
 L2mzrvUtQ4cEij2Ixp4rik4s9oyxdPNXmKgoq8wfGywK/Lp6cHtHrGeAg1phZXzYmUSf
 MzTNPLJX6brFCVcl+UyAG7DOQ6oNuFKHFSVVbWAcEkKaKiGgHsJ7cLLT5FTIy5dMrd1x
 r4vg==
X-Gm-Message-State: AOJu0YyNHV4JnC69Jn4LA10o+Y6tLUVcBOy/70lucA+OYKZy/2GwHO0o
 so6dJBSMRqG9pocplrQFYIc=
X-Google-Smtp-Source: AGHT+IGiNP88855IZh3fi+E/A15IS95a329VqHC9sBXuK9hPgRgrTQRvPcEFPU7fw5uPNSJGjB/K8w==
X-Received: by 2002:a7b:cc8d:0:b0:40b:5e56:7b6e with SMTP id
 p13-20020a7bcc8d000000b0040b5e567b6emr1436322wma.183.1703081187246; 
 Wed, 20 Dec 2023 06:06:27 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a05600c4f4100b0040c03c3289bsm7374405wmq.37.2023.12.20.06.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 06:06:25 -0800 (PST)
Message-ID: <46bf9893-f31e-47cb-84a3-c609d13e3a65@gmail.com>
Date: Wed, 20 Dec 2023 15:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
Content-Language: en-US
To: "Xiao, Jack" <Jack.Xiao@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20231219092340.1601929-1-Jack.Xiao@amd.com>
 <CADnq5_NAzBZj+SXc7iY5ZWUgxGCmt3A+PsVRRx59YWx4=toXYg@mail.gmail.com>
 <PH8PR12MB68417ECCDF64B44C09248DF3EF96A@PH8PR12MB6841.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH8PR12MB68417ECCDF64B44C09248DF3EF96A@PH8PR12MB6841.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well not the reset lock, but there should only be a single reset queue 
which this runs on.

Regards,
Christian.

Am 20.12.23 um 10:49 schrieb Xiao, Jack:
> [AMD Official Use Only - General]
>
> It's already protected by the reset lock. In my understanding, soft reset should not run in parallel.
>
> Regards,
> Jack
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, December 20, 2023 1:04 AM
> To: Xiao, Jack <Jack.Xiao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access CP_VMID_RESET
>
> On Tue, Dec 19, 2023 at 4:30 AM Jack Xiao <Jack.Xiao@amd.com> wrote:
>> It's required to take the gfx mutex before access to CP_VMID_RESET,
>> for there is a race condition with CP firmware to write the register.
>>
>> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index bdcf96df69e6..ae3370d34d11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -4518,6 +4518,22 @@ static int gfx_v11_0_soft_reset(void *handle)
>>                  }
>>          }
>>
> We probably want a CPU mutex or spinlock to protect this as well unless this is already protected by the reset lock.
>
> Alex
>
>> +       /* Try to require the gfx mutex before access to CP_VMID_RESET */
>> +       for (i = 0; i < adev->usec_timeout; i++) {
>> +               /* Request with MeId=2, PipeId=0 */
>> +               tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, 1);
>> +               tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4);
>> +               WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
>> +               if (RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX) == tmp)
>> +                       break;
>> +               udelay(1);
>> +       }
>> +
>> +       if (i >= adev->usec_timeout) {
>> +               printk("Failed to require the gfx mutex during soft reset\n");
>> +               return -EINVAL;
>> +       }
>> +
>>          WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0xfffffffe);
>>
>>          // Read CP_VMID_RESET register three times.
>> @@ -4526,6 +4542,10 @@ static int gfx_v11_0_soft_reset(void *handle)
>>          RREG32_SOC15(GC, 0, regCP_VMID_RESET);
>>          RREG32_SOC15(GC, 0, regCP_VMID_RESET);
>>
>> +       /* release the gfx mutex */
>> +       tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, REQUEST, 0);
>> +       WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
>> +
>>          for (i = 0; i < adev->usec_timeout; i++) {
>>                  if (!RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) &&
>>                      !RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE))
>> --
>> 2.41.0
>>

