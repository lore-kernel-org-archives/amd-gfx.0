Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A246CCF6C1F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B8FE10E56B;
	Wed,  7 Jan 2026 09:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jpmr.org header.i=@jpmr.org header.b="ZKKVPMzL";
	dkim-atps=neutral
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93ADA10E0D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 07:38:19 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mslow3.mail.gandi.net (Postfix) with ESMTP id 1AE9C580B37
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 07:32:26 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 841CB4432E;
 Wed,  7 Jan 2026 07:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jpmr.org; s=gm1;
 t=1767771145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fSapxs77yYYm6PZjVymHtglDpHxRSFSHm71N9x5zTt0=;
 b=ZKKVPMzLtReVzmJlkRmG2zeAmqKxCkDW7//CGmpheFB68lYHHbyjeJeOZgWhVmPLMOpA6U
 UE5My+VvxmoB3qUtTXs1A7PCTImOCVIi8IpP7nJccaK/AJ82krKgzXeVtJq36tvuIdBzOW
 mD+zVbQsd03tTYfV0b+kNAvTNJYmJksv+sbhWdpPS5axkfkNURip0KSNWvnVGP23Pny0A4
 CTLwfcLFJAIaYl7RcFpTsV0afvDEt2qH9gAm82WblM7Azf4pVTq5qT6goVSzKVcEE6CrRI
 CptWZ8bTFn+6PP61sBVG9CrpDBwRV8NRQcbv6US++cf9I/kUw9WuyMs29CfVHw==
Message-ID: <d6619cc9-11c4-4d8c-804d-ca90b4d9ddd1@jpmr.org>
Date: Wed, 7 Jan 2026 08:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20260106131921.801193-1-Prike.Liang@amd.com>
 <DS7PR12MB6005F5FD54C06298CB3B60EFFB84A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: fr, en-US
From: Jean Philippe EIMER <phil@jpmr.org>
Autocrypt: addr=phil@jpmr.org; keydata=
 xsBNBFhemDABCADDqdnsqW69Sm6RInzBLbg8JVbuNaxBXhNk7rLeTbtkMBB7YEh8BT/skVJ+
 4rwsSt94do3R3dLx4D1DFKfEbq2J9u04h+eIAzBN7MtCpghGwAga/aSxcB/HU898iogdgww+
 hLTK0nVuLFt8lI3GqtmexXq7yGGENlsuD9xCXTOve2Jg14La+KLClQPA+oB5M6uoJeqHV8dH
 MV1ZdYz6lUgfX4HoNrAH3W1zotQQk3RztD6lPet2cKCE0VfBpokDTA9uDJe3ZqueE01I319N
 DSF418oPq+bEjOWodiMVlS/ahXIUinG9b0k6NezqcdH6dXCo3FFqfCNE4mbFYbuCHvirABEB
 AAHNGXBoaWxAanBtciA8cGhpbEBqcG1yLm9yZz7CwI4EEwEIADgWIQQAdpPnfLL4es8lmH9Q
 ytldc+Iw2QUCWF6YMAIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRBQytldc+Iw2b1q
 B/4yS8oz761Vs51oSQ/F1/srj9+btAZT+ecinNqCfNqLXsaCerlD7U3aufch71sklmLreKE6
 /Tn0XCUuzY1ArOb+Dx3BS3RKEzZlyvHSliRwMEvo/euHchD7bJU+xI7h0/nkhbTT6KsBKpyv
 GYaIiE3aES52mvzijk8eQxif9GMx6hFpFeMWQQwjtezbhStl0sl/CWRkCJt7aZ5VCnfezMnf
 NTkwtdPR/RqSFT0zB8QfVkl/nq+csNc/Y6zDLliWT8Q3Sm3GFFKahbry5vHan1+fuzBcwa7U
 BlJPHoLqyHeA2BAX5w6fBDpj7tB7cNpp21jMf/Bhb/B+fjvPerzuxc9mzsBNBFhemDABCADp
 q8CnJI+02+CP8WOJ+5cMCdNnBnU8UpX866GJsL+Dkfa+O+9bqdlOdDQIU12eGSDpQMGnaEr+
 srlE0a3xMzBa9oVQ8uqXVBjubrEIhfz8FWPO6IM6LaPByG01TxBDZrIkMGD+wekbBdCkFcEM
 1QUf0G4kPBmYQw+lkal8RZ1nVQgqMG/T6b+Qz7/BcXSaqgN+pt9IWlN9Kqx2uUKpidd5U59X
 au3in0GPxNeO2rjBoF3jGEo37KmR95ZQAps3CRk4qWAE5JCearESbv7+zRDAll7iluuiojsu
 3QPSdbwn3kInNxvMWWEEPq+BgHnAcH9tiVuHiXyXLcpOsSVUJ7+RABEBAAHCwHYEGAEIACAW
 IQQAdpPnfLL4es8lmH9Qytldc+Iw2QUCWF6YMAIbDAAKCRBQytldc+Iw2foSB/sEJ1YT3203
 kBJXASYt1b9ULb3TlwOL3zntN+PFJ1J8e+JvHC3X47dJ2FUi8MY/HEtRaQX4YMwUlxcK7AG1
 Yb1CiIaKD3CA9u8mMgEcUGt/w2Q/ROojkgEDAFP9KahY1Ar20UKN3dQJwYGhLZWCQTDCiCSN
 IjHSTeqAHCQSztLAQx8p7RV6kXLUZjIg+ekW/CPqI9EPNJWU7hMCAt4RGetnpIVd/5l6NFs8
 edzTUrMl99zVSISCoemKWjiF1Pa0lWYu1JQGLzT+jboefSegCUs+u4C+dp9gaLkCd4bxBE/o
 L8YyKVUHGX2YdjSDIoKRxA9EJrGR3vv281oYybIhjtpR
In-Reply-To: <DS7PR12MB6005F5FD54C06298CB3B60EFFB84A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: phil@jpmr.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvgeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfgvrghnucfrhhhilhhiphhpvgcugffkoffgtfcuoehphhhilhesjhhpmhhrrdhorhhgqeenucggtffrrghtthgvrhhnpeetvedtffejiefgieevieehhfdvlefhhedtueehgffhteefgefhueeuledujefhvdenucfkphepvdgrtddumegvtdgrmegstdelmeelfedutdemmedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmegstdelmeelfedutdemmedvpdhhvghloheplgfkrfggieemvdgrtddumegvtdgrmegstdelmeelfedutdemmedvngdpmhgrihhlfhhrohhmpehphhhilhesjhhpmhhrrdhorhhgpdhqihgupeekgeduveeugeegfedvgfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheprfhrihhkvgdrnfhirghnghesrghmugdrtghomhdprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheptehlvgigrghnuggvrhdrffgvuhgthhgvrhesrghmugdrtghomhdprhgtphhtthhopeevhhhri
 hhsthhirghnrdfmohgvnhhighesrghmugdrtghomh
X-GND-State: clean
X-Mailman-Approved-At: Wed, 07 Jan 2026 09:14:38 +0000
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

Since 6.17.11 and 6.18.1, the patch 'attach tlb fence to the PTs update' 
(commit b4a7f4e7ad2b120a94f3111f92a11520052c762d) provoked a kernel 
crash on my system with an AMD SI graphic chip.

I confirm this 'validate the flush_gpu_tlb_pasid()' patch solves this issue.

J. Ph.

Le 07/01/2026 à 02:50, Liang, Prike a écrit :
> [Public]
>
> Add Jean
>
> Regards,
>        Prike
>
>> -----Original Message-----
>> From: Liang, Prike <Prike.Liang@amd.com>
>> Sent: Tuesday, January 6, 2026 9:19 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
>> Subject: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
>>
>> Validate flush_gpu_tlb_pasid() availability before flushing tlb.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index cd4acc6adc9e..f871f1693483 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -780,6 +780,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
>> amdgpu_device *adev, uint16_t pasid,
>>                return 0;
>>
>>        if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
>> +
>> +             if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
>> +                     return 0;
>> +
>>                if (adev->gmc.flush_tlb_needs_extra_type_2)
>>                        adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>>                                                                 2, all_hub,
>> --
>> 2.34.1

