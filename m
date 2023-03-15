Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B44C6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 08:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ACD010E969;
	Wed, 15 Mar 2023 08:25:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6ED210E917
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 06:05:50 +0000 (UTC)
X-UUID: 83be105869334413b89539de83e3bf84-20230315
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20, REQID:b3c59e09-d586-4e2f-bd85-d480c4de6ae8, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-INFO: VERSION:1.1.20, REQID:b3c59e09-d586-4e2f-bd85-d480c4de6ae8, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:0
X-CID-META: VersionHash:25b5999, CLOUDID:cd596b28-564d-42d9-9875-7c868ee415ec,
 B
 ulkID:230315140542ANP1KDHL,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
 I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 83be105869334413b89539de83e3bf84-20230315
X-User: lizhenneng@kylinos.cn
Received: from [172.20.124.41] [(116.128.244.169)] by mailgw
 (envelope-from <lizhenneng@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
 with ESMTP id 101849547; Wed, 15 Mar 2023 14:05:42 +0800
Subject: Re: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20230313025648.3103971-1-lizhenneng@kylinos.cn>
 <20230313025648.3103971-2-lizhenneng@kylinos.cn>
 <DM5PR12MB2469106B445537FF8F7EBA19F1BE9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <BYAPR12MB46140D57681AA4BC9E42E3DA97BE9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <DM5PR12MB2469D03BB7F3A698DDE6B16AF1BE9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: lizhenneng <lizhenneng@kylinos.cn>
Message-ID: <7744ad94-26ad-a960-707c-97b98f1ee75b@kylinos.cn>
Date: Wed, 15 Mar 2023 14:05:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB2469D03BB7F3A698DDE6B16AF1BE9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailman-Approved-At: Wed, 15 Mar 2023 08:25:34 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023/3/14 下午5:27, Chen, Guchun wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, March 14, 2023 5:07 PM
>> To: Chen, Guchun <Guchun.Chen@amd.com>; Zhenneng Li
>> <lizhenneng@kylinos.cn>
>> Cc: David Airlie <airlied@linux.ie>; Pan, Xinhui <Xinhui.Pan@amd.com>;
>> amd-gfx@lists.freedesktop.org; Daniel Vetter <daniel@ffwll.ch>; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
>>
>> [AMD Official Use Only - General]
>>
>> Hi Guchun,
>>
>> This patch doesn't look correct. Without dpm enabled, temperature range
>> shouldn't be set at all. The patch posted by Zhenneng is good enough or
>> better to skip late init altogether as it remains an empty function with that
>> patch.
> My intention is to prevent setting temperature range again in late_init, as in hw_init prior to late_init, we have configured this range and set dpm_enabled to true already. Also this is a draft patch:)
>
> Leaving a NULL function in late_init looks good to me.

To be consistent with previous code style, such as:

static bool si_dpm_is_idle(void *handle)
{
     /* XXX */
     return true;
}

static int si_dpm_wait_for_idle(void *handle)
{
     /* XXX */
     return 0;
}

static int si_dpm_soft_reset(void *handle)
{
     return 0;
}

static int si_dpm_set_clockgating_state(void *handle,
                     enum amd_clockgating_state state)
{
     return 0;
}

static int si_dpm_set_powergating_state(void *handle,
                     enum amd_powergating_state state)
{
     return 0;
}

We could  use "return 0".

>
> Regards,
> Guchun
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen,
>> Guchun
>> Sent: Tuesday, March 14, 2023 6:35 AM
>> To: Zhenneng Li <lizhenneng@kylinos.cn>
>> Cc: David Airlie <airlied@linux.ie>; Pan, Xinhui <Xinhui.Pan@amd.com>;
>> amd-gfx@lists.freedesktop.org; Daniel Vetter <daniel@ffwll.ch>; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
>>
>> Will attached patch help?
>>
>> Regards,
>> Guchun
>>
>>> -----Original Message-----
>>> From: Zhenneng Li <lizhenneng@kylinos.cn>
>>> Sent: Monday, March 13, 2023 10:57 AM
>>> To: Chen, Guchun <Guchun.Chen@amd.com>
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
>>> Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-
>>> gfx@lists.freedesktop.org; Zhenneng Li <lizhenneng@kylinos.cn>
>>> Subject: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
>>>
>>> During reboot test on arm64 platform, it may failure on boot.
>>>
>>> The error message are as follows:
>>> [    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]]
>>> *ERROR*
>>>                          late_init of IP block <si_dpm> failed -22
>>> [    7.006919][ 7] [  T295] amdgpu 0000:04:00.0:
>> amdgpu_device_ip_late_init
>>> failed
>>> [    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU init
>>> ---
>>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 12 ------------
>>>   1 file changed, 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> index d6d9e3b1b2c0..ca9bce895dbe 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> @@ -7626,18 +7626,6 @@ static int si_dpm_process_interrupt(struct
>>> amdgpu_device *adev,
>>>
>>>   static int si_dpm_late_init(void *handle)  {
>>> -   int ret;
>>> -   struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>> -   if (!adev->pm.dpm_enabled)
>>> -           return 0;
>>> -
>>> -   ret = si_set_temperature_range(adev);
>>> -   if (ret)
>>> -           return ret;
>>> -#if 0 //TODO ?
>>> -   si_dpm_powergate_uvd(adev, true);
>>> -#endif
>>>      return 0;
>>>   }
>>>
>>> --
>>> 2.25.1
