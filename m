Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9051DC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 18:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365C910E4AF;
	Mon, 10 Mar 2025 18:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="IrpTGvsG";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8029F10E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741627800; x=1742232600; i=natalie.vock@gmx.de;
 bh=FhNFxFo2nhgc2jfvyISFM4BS0OZs1Ox8tnLWpoS92gY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IrpTGvsGxlKqvnkPwTOaaBEmBAy14qR7uNEIsPptjF5pQBv9Fniu9xd7ircLZEXN
 dbweaqg3TsCDbqLW2D+CqvC7x0g8xb6lLOWDdkKBp4I8II1J3PRKMhzDtaiGdhinL
 iRQOn/FEmW/VQWSPD7PR2/hwo8dvG29GgIPPgOpZJ5VnOaeQe/4b73AoiQ6Fp787b
 X4Ud5Wg2V9FbRqfGuT2tYGDeg5X7rlXHBMwqFAsssYKLOp7Jt1QbWPDZSN+wXK5xZ
 8UheZeiRvq2/bgrnOwjk6kcTV/qDk+9qD8sWXb39gtsRTQZ415zyM6u2Ew4a3VBQ/
 T6sk1gSTiLZH4wg36A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.3] ([109.91.201.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1tL8192XsF-00jxM8; Mon, 10
 Mar 2025 18:30:00 +0100
Message-ID: <ae4084f2-a34e-44db-936f-be4f8204e7ea@gmx.de>
Date: Mon, 10 Mar 2025 18:29:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Allow buffers that don't fit GTT into VRAM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Ivan Avdeev <1@provod.gl>
References: <20250306170118.40238-1-natalie.vock@gmx.de>
 <43becf25-ad3b-4aae-9919-a74feede06a3@amd.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <43becf25-ad3b-4aae-9919-a74feede06a3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xb9GDpJ9M/uzXmHyVlJeRAp+JktY20o0WoZKr7mcUmJOUNzdwLv
 XPJdWaWm7JrlOSc6tHN7qVNGipUDFUBypSgvzo364QFFhPUrrmE4x8+GRCHhOQEzAkCtmLP
 p0gHTDl1phZBFwrhz1r1pD4R6k5UCmGMCjJy9M8a9aVkFmS+gsH0aNcR3V8kpXNxQuK2TVC
 ihfVMNWF40ZwLN4ACa8ZQ==
UI-OutboundReport: notjunk:1;M01:P0:hsy/B2Lz+CU=;UGZKjOL1VyQfPjNd9MVxlkQCf7q
 MfR8H/KUEQR6jAuaYkQvoaihJnPw85c+Fqyuv5EfOp1x21fmE5I62DrkvqflCzOCYo9ZOiEKo
 tq2mqam2tyuCcKtPtLgp/1v/qgwTfEi01HfHRzLVMZJQSYunc0st7RM7g7QujxJ3UbSxT/8Ev
 JCpuLKw/ICJzznA32gVxpR9EXVrw4w58zepEbJbTN0+AH1mXEBt3JesaFGmy/+7ijZ/xsnOjt
 zCLzKylwU8V5WqY1V7xE8bBYpLp+xEcgA22kivmFs/AWsRgX1hx6JoZbtjZtDBt2LBxQ1QwDw
 ecxQDM6orscSQx3pM+bf+TOSohu+Z1c3jyfXYDzMYlH97Sq5HzcKbWXFc78rDwbJwCUQDHbKE
 J0qgngeCiV6puf7bQfy1Q2SoMB1oEmSyzIIY0gBfl6IkEWWLeIDlva3iajb9B64j89k7i9zgK
 za2mb5K2piHUYqWCQdQEKc3LUSC2RmhugaJSMQGZA/1A0yvRYaE3W9vPOVXSwaLfm3mjhc6lM
 cfGTYVltdDVgyyshuTax+zeOqlEP4XkdpiUEDPlmnXd8uLOdg4R96y114tXyep9ZuUO+jJr0b
 cQlyMUE6e2Dwn0MUXlDUejeNmw2gZc2sZwswkO5M8Ah9z4qy9N1AVL8EmvN5qrCF9nMRFKUcr
 MN5rgxoatLIrY9pdXKMnPwHt/NjKe5sHDV7NrZvwKWjjpJYaqr/Hbbt5uYJ04OsUM8Z5p7Yor
 WlLvFjw3oP+zomRdCF5jJ7SumP2O5plRVS+j5JpCsucjzCG7JddoA8Y1OSjyokCCvj8oy4l7A
 pHqWp9N8rv3mciYiuDJM29n0iWcJBiJh3xbzSDeawb+epENd4oDiIf+TnGQeoOH3UlKcs7r9S
 R5WZZ/fUNE7sL7TzN3tEfwKOpLUfhwPQLc3ncB6nPc8EbTkeuRUNprsjBYSWIwy+2de3HAjcy
 Ip22uF+iOYQncwdcDaNNz+Wo88Jn3YPEE9XCchPPqfgmVj0j1ASF3zUGBrchu5TVgnKPVy2nb
 P9otCpHj9o8PxaxbcTVAaFaOEW+Lsvxcsub+vyp2h0TegmJMriPdBLrWxwowu2t9JmqRyutjm
 kDzgwoaEwMn+XmqYDf2QP2ms7/vkJi9O+jbLhIedNBo++/X4wt2Y/ZqqO3+YXkGNgF78R20Y4
 u7ZDnUQLS1auEuQLY/j4X8vjwy/sud/WtqbJuG8sEiSmWZ/fHp+Rn7PtKBZV+YUlNVH5uJ/Nc
 MK33LsBJDNqR/Otr81wiRXpdFN4yHmJ4dIrGA6o8GSiFKdh38lRhVYtW1B4SEnvAYlqAemdq9
 Y+UQf7dywOzdtYuVQzVeo17GbeYc/6AizNmJXYjCmK8KCTl0jgv7oXxlQbrVbYBmOO3iFr3MF
 0um5Mq8AVQ/XuMGlFdObm0MHR8R7w6EvlvuZ4S1qjFGG64BfMZKDf6uLk2
X-Mailman-Approved-At: Mon, 10 Mar 2025 18:05:36 +0000
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

On 07.03.25 09:39, Christian K=C3=B6nig wrote:
> Am 06.03.25 um 18:01 schrieb Natalie Vock:
>> When userspace requests buffers to be placed into GTT | VRAM, it is
>> requesting the buffer to be placed into either of these domains. If the
>> buffer fits into VRAM but does not fit into GTT, then let the buffer
>> reside in VRAM instead of failing allocation entirely.
>
> That will completely break suspend/resume on laptops.
>
> we essentially need to always check if a BO can fit into GTT.

Good point, I forgot about suspend. But as you say, we always need to do
this, even for VRAM-only BOs. I'll send a v2 for that in a minute.

Thanks, Natalie

>
>>
>> Reported-by: Ivan Avdeev <1@provod.gl>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>> This originally came up in https://gitlab.freedesktop.org/mesa/mesa/-/i=
ssues/12713:
>> The crux of the issue is that some applications expect they can allocat=
e
>> buffers up to the size of VRAM - however, some setups have a
>> smaller-than-VRAM GTT region. RADV always sets VRAM | GTT for all buffe=
r
>> allocations, so this causes amdgpu to reject the allocation entirely
>> because it cannot fit into GTT, even though it could fit into VRAM.
>>
>> In my opinion, this check doesn't make sense: It is completely valid
>> behavior for the kernel to always keep a VRAM | GTT buffer in VRAM.
>
> No it isn't. On suspend the power to VRAM is turned off and so we always=
 need to be able to evacuate buffers into GTT.
>
> Regards,
> Christian.
>
>> The only case where buffers larger than the GTT size are special is tha=
t
>> they cannot be evicted to GTT (or swapped out), but the kernel already
>> allows VRAM-only buffers to be larger than GTT, and those cannot be
>> swapped out either. With the check removed, VRAM | GTT buffers larger
>> than GTT behave exactly like VRAM-only buffers larger than GTT.
>>
>> The patch adding this check seems to have added it in a v2 - however I
>> was unable to find any public discussion around the patch with reasonin=
g
>> in favor of this check.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++++-----------=
-
>>   1 file changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
>> index d09db052e282d..b5e5fea091bf1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -555,27 +555,25 @@ static bool amdgpu_bo_validate_size(struct amdgpu=
_device *adev,
>>   {
>>   	struct ttm_resource_manager *man =3D NULL;
>>
>> -	/*
>> -	 * If GTT is part of requested domains the check must succeed to
>> -	 * allow fall back to GTT.
>> -	 */
>> -	if (domain & AMDGPU_GEM_DOMAIN_GTT)
>> -		man =3D ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> -	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
>> -		man =3D ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>> -	else
>> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMA=
IN_DOORBELL */
>> +	if (!(domain & (AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM)))
>>   		return true;
>>
>> -	if (!man) {
>> -		if (domain & AMDGPU_GEM_DOMAIN_GTT)
>> +	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>> +		man =3D ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>> +		if (size < man->size)
>> +			return true;
>> +	}
>> +	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>> +		man =3D ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> +		if (!man) {
>>   			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitializ=
ed");
>> -		return false;
>> +			return false;
>> +		}
>> +		if (size < man->size)
>> +			return true;
>>   	}
>>
>> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMA=
IN_DOORBELL */
>> -	if (size < man->size)
>> -		return true;
>> -
>>   	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man-=
>size);
>>   	return false;
>>   }
>> --
>> 2.48.1
>>
>

