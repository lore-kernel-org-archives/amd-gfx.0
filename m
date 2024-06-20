Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2422C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 13:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D5F10E9C2;
	Thu, 20 Jun 2024 13:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="K/sKH87e";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="83Z5I+Of";
	dkim-atps=neutral
Received: from bunu.damsy.net (bunu.damsy.net [51.159.160.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B65B10E9C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202404r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1718888843;
 bh=VRjgbaJvXiQu57FaBme/ybK
 YQ8/6jVTS2rK9wIrZwCw=; b=K/sKH87eh+BBW1/Bu9hblJ0RbuO/XtE9QEu5jIYLPuD0rUFcPI
 y3BCCaFg8YOCIX0iSATr39nx9p8nbTHwIlbFHfoAqG4DLtk2chAPqZaQbj6E6/RovTxzoOc3XsG
 +F7qx55858I09a64IVmu1HcGDQmL2KRsSGYEXZ5/z76VV1/fVI09v2NfN+x1IJfXS3h9cbO2X29
 OgrNJbzLRreyYf/orDO8Ye4qlUoeJQa2k/OzH2Z15dBJ4TT+Ek243MMAaQLbD8j1OfJXkWh7szE
 XoX2swJqMsYViI11Qkf5gC5bQPhzTDhKvGulk65+dQ2Ba/PsIXokfoHUtLXLAOxf8iQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202404e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1718888843; bh=VRjgbaJvXiQu57FaBme/ybK
 YQ8/6jVTS2rK9wIrZwCw=; b=83Z5I+Ofg/0vv19rFln/Re20gpNPIaeZbMNPVu6AogtWsK+qxq
 D822/1K7OulPIR28LLq1m2B3dq/1kJ4thnDg==;
Message-ID: <13cb8811-4b42-4bfb-a5cf-04046dcdb070@damsy.net>
Date: Thu, 20 Jun 2024 15:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: add AMDGPU_INFO_GB_ADDR_CONFIG query
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
 <20240618153003.146168-5-pierre-eric.pelloux-prayer@amd.com>
 <CAAxE2A6sQrU94uisM00kZs=P2pguTcQJjEtUX_Gum_vPjZ2J+g@mail.gmail.com>
 <bbe4d387-ca6a-44a5-a143-dae794d23312@amd.com>
 <CAAxE2A5CNoErNMU_qOS+OK7yGSoMUGwpLL2kRVF_bAqnyhj4Lg@mail.gmail.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <CAAxE2A5CNoErNMU_qOS+OK7yGSoMUGwpLL2kRVF_bAqnyhj4Lg@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Both versions are fine by me, so I'll update the code to match whatever 
you agree on.

Pierre-Eric

Le 19/06/2024 à 20:44, Marek Olšák a écrit :
> The INFO ioctl was designed to allow increasing the sizes of all info
> structures. GB_ADDR_CONFIG isn't that special to justify a separate
> query.
> 
> Marek
> 
> On Wed, Jun 19, 2024 at 5:31 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> I would try to avoid that.
>>
>> Putting everything into amdgpu_info_device was a mistake only done
>> because people assumed that IOCTLs on Linux are to expensive to query
>> all information separately.
>>
>> We should rather have distinct IOCTLs for each value because that is way
>> more flexible and we won't find later that we have to deprecate fields
>> and work around issues because of legacy hw.
>>
>> Regards,
>> Christian.
>>
>> Am 19.06.24 um 02:34 schrieb Marek Olšák:
>>> I would put this into drm_amdgpu_info_device. That structure can grow in size.
>>>
>>> Marek
>>>
>>> On Tue, Jun 18, 2024 at 11:30 AM Pierre-Eric Pelloux-Prayer
>>> <pierre-eric.pelloux-prayer@amd.com> wrote:
>>>> libdrm_amdgpu uses AMDGPU_INFO_READ_MMR_REG to fill the dev->info.gb_addr_cfg
>>>> value.
>>>> Since this value is already known by the kernel, this commit implements a new
>>>> query to return it.
>>>>
>>>> The libdrm MR to use this query is:
>>>>      https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/368
>>>>
>>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
>>>>    include/uapi/drm/amdgpu_drm.h           | 2 ++
>>>>    3 files changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index f51f121d804e..403add7f05af 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -117,9 +117,10 @@
>>>>     * - 3.56.0 - Update IB start address and size alignment for decode and encode
>>>>     * - 3.57.0 - Compute tunneling on GFX10+
>>>>     * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
>>>> + * - 3.59.0 - Add AMDGPU_INFO_GB_ADDR_CONFIG support
>>>>     */
>>>>    #define KMS_DRIVER_MAJOR       3
>>>> -#define KMS_DRIVER_MINOR       58
>>>> +#define KMS_DRIVER_MINOR       59
>>>>    #define KMS_DRIVER_PATCHLEVEL  0
>>>>
>>>>    /*
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index b32ff6e1baaf..dbb05d51682b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -1256,6 +1256,10 @@ static int amdgpu_info(struct drm_device *dev, void *data, struct drm_file *filp
>>>>                   return copy_to_user(out, &gpuvm_fault,
>>>>                                       min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
>>>>           }
>>>> +       case AMDGPU_INFO_GB_ADDR_CONFIG: {
>>>> +               ui32 = adev->gfx.config.gb_addr_config;
>>>> +               return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
>>>> +       }
>>>>           default:
>>>>                   DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>>>>                   return -EINVAL;
>>>> @@ -1310,6 +1314,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>           case AMDGPU_INFO_VIDEO_CAPS:
>>>>           case AMDGPU_INFO_MAX_IBS:
>>>>           case AMDGPU_INFO_GPUVM_FAULT:
>>>> +       case AMDGPU_INFO_GB_ADDR_CONFIG:
>>>>                   need_runtime_pm = false;
>>>>                   break;
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>> index 3e488b0119eb..680492cd73d8 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -933,6 +933,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>>>    #define AMDGPU_INFO_MAX_IBS                    0x22
>>>>    /* query last page fault info */
>>>>    #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>>>> +/* Query GB_ADDR_CONFIG */
>>>> +#define AMDGPU_INFO_GB_ADDR_CONFIG             0x24
>>>>
>>>>    #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>>>>    #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
>>>> --
>>>> 2.40.1
>>>>
>>
