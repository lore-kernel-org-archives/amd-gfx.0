Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FF6FD8FC2
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 15:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911D310E979;
	Thu, 26 Feb 2026 15:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ZdxPZHE";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D81410E979
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 15:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBb1kTqqubfGCGxLLA3yWUBk95YevfkEf1Y2q2EKqLbPjEjaH2FTAOAuJiAvjNA9P/d2uOL1iorm3xP7R7qdK0/K2Pa/KhmFgPsU+MFGpDW33sBn2ZFJL5O8779Jz7qDQw1MgGNLCS8Svue2KfrWUr0QDY3IzOegxqFA5qoMqjepnMcrXkJb2h6kNJqqgebimteOgCf/56FWPBANbnLcpqWUNuw5RHN8/9zTpB5BcIhuAQtMMdpwcpOiHkgU/apYNgWPX48GJh1HY36SzPUtPc68uKRUs+R6pP710y8317Gagd1HGG3uL7eukaoONV0X9hUEGGUewEfzubhqL2Zfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t4vgAkOp4X7inpz+PuEOHaUSqZIXkVcxIEqpO6iHp0=;
 b=XEjnz+bDaRnLg+q0S4Lk/bzBjIDH/hXRJe2c2aAds3SCF16HVwWbesvhrbG+uwJc77T9C7jU5h40doe8ng88ONGkv8+nrDS8MSf0j59gg+gCDAnwrH1Nh+hpOwJF5JhgXufidqYjL1r+LtLH5MxlkNFNUSCMv2muAKvu0fAOiACuboFAtYrv7SinbUNJpPZFftkTRUX0njWKho0HvICdy+Aeu7dyvEeHOk8/jIZJ/kxGt0J51ZNN3Z6ePAHqjlOsQ4AB77xk3VbmI7eWClmX/fIfpaX0ZShTyRJYH/sykTRq8yohbd4b6U0fZnkb0xcgatSQjgjO4vvJj77GNT6k1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t4vgAkOp4X7inpz+PuEOHaUSqZIXkVcxIEqpO6iHp0=;
 b=0ZdxPZHEfNEcIKmPVuwnw3uxH3fL4Kpr2dY9tbeAprL1QH3MLcOVZJ1brbWwut2RMWXwUb7aNiehAFfkMlOn6kED+V0+KjSHLf7EA4n/cg/mtTJ84zm2safUJt1j+zRj9/9nkLHdoladc3nv7fezx3rpEADmabQl7TRTZyWrg8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:05:25 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 15:05:24 +0000
Message-ID: <5b409ab7-7c63-4020-8d96-461cb649ecaf@amd.com>
Date: Thu, 26 Feb 2026 20:35:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu/userq: change queue id type to u32 from int
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260226074241.3150441-1-sunil.khatri@amd.com>
 <CADnq5_M7B++68+Kgo7Eb+y-mco=P9Ov4JT=2HkrubFNYxRVBVw@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_M7B++68+Kgo7Eb+y-mco=P9Ov4JT=2HkrubFNYxRVBVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 843918c4-4727-48bd-8279-08de7548779c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: cWapZWHOWj//VcQV/S0oR1YCNp072uJvS5jVzzNlRMRhz3rFUuLXMxrXqgDQkNW288y4SAu60+pcglXgiGX5h5rPQsVhJEkOrQLBgnyuIT/R23nmnNlSkxm91elvLSuMKRZG3FbovVRbpyiCxtuwA+nG97zqufzAhbNIdmd54wu5aVvZF3tGJioEo23Yju27K/pFrjBRqJN7NSrfiEdXgxIL5WAoYJXdFv93BylmX4xE6iUGmVoK2Bt+ojs99kUINDBVxi5Ksr0FhVuSHgQ8BFtL03lo0XNjjUu5a0wXVCp/3xVbfxT6Pff25UIqtbCJl5M38u57ajQa+BEz2sqYTXi0dW56+MntKQ9SJIIwOkzPhJBd1JHdwDlEZHknmcE+SIlTZ4UnmWfDNZ0Kka35J+ZOLJGl7VprAeXQhE1Rb4nywmI/6zCgulblba72yYq8EeTNetILnVk20sC8K+7kMHyVkMdOjSKz9Vdlx26iCzRIBVO1NWhPOpGHDG3M3LKaXNckHRunVw/Q7m2waDT8MxN39jipOoe4wK8h0TVOf5E7R/mgMPwi8lWNtvWx3+PDxUOujvw3eCJeiVlha3xws5NGsvhrslCTkUfNZXcQastYWxOvsjBPnL9GPuRNOyperopgH9uRuLY6MyKtfpt5a8+ufKLCXpDKBON6iERN9aKu6j+kMyImoi0ZsyqF5Fvi0G6GULPeKPkKb596ar60c+7puLIg/bpwsUrog7FcpXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui8zazVYMnNhM0lTVWNuWmRKeWcvZkdMUCtBMVhqSE1EQk1JZ0wwWUcxM1FX?=
 =?utf-8?B?eVVCOUJoeXVEcEM5WG5DbG1STHd4ck5XeStXZ05VZm9tdU9UakhnbXFFOFNV?=
 =?utf-8?B?TUNHdW4wWi9JU0NCUnV5dnppK1hVTjAvc2hkb0FCWjRoS3JzbE5ocGRhbjlZ?=
 =?utf-8?B?WCtrQ0VEVzRVdTMxVVhiUmprampHbmtNZzNEUXBXTXQya2R0UFRyNFoycERP?=
 =?utf-8?B?Y3JXbS9Wc244WnpNL3kxbzd1Mm9hcStGSS9GeFRYME1XdmptaFNRMXdEVVZP?=
 =?utf-8?B?QStRa1dHbm1OYzZ3OEh1MjNaZlVoR0VyRU5xdzRaU3hiMzNvcHRiSnVZdXRY?=
 =?utf-8?B?dHRWUUNjRDJiQlVEQzcvSzdWMzJ4S1QzUEtkZEFlMDBXYkZrMlVEN3VXdDBx?=
 =?utf-8?B?bFU5Z2I2OVU0T1VzUVlSN0VlT2c1Z2loT3NmWU1BRzZDSHpsc2d1YTY0VEx5?=
 =?utf-8?B?c0VtOVBLcW1CQ2lEb0hYOXJub0lSRTg0cEpsRDhjYkxVaUlUU3prV2RKK3ZV?=
 =?utf-8?B?a2tSYllRemU5Sjg5SEQxNlkrdTJnSUFGY2h6VHJ4dDIwYzJVTm9vTjFKc21K?=
 =?utf-8?B?Nml4NlpHTjBXaEkyMkdWK0VZSUR0K2xyc1pBOTAwODVxRU5MNU5xYm1qNXVL?=
 =?utf-8?B?S0V2V1hYN0grc2N2NlI1MFNPUldKSVQvYmFYYnYrdHZoa3FnZ1pWRXlINUJp?=
 =?utf-8?B?YWlpZTJlcTJlWHdNbmdqKzJRZjZ4Vm1ZZm15RVpYNUh3VURrRS9yV3hCaXBj?=
 =?utf-8?B?L0JwSTNGcjdmVDJoVmxyYmZoUGdLSFVaaEdRWXR6S2grVjQzVHB6VUFBbHdi?=
 =?utf-8?B?UW1iajlML2pyNmowSXpzQWlFejhCZ3NDVWM3bHFTamRSMzRGL1dQN2E3RFI0?=
 =?utf-8?B?SDI4Q2JwbWppSnhkL2RYdmY2WUU2R3k3NVk2VVZZM1dRemRra2pqSVhFYjd5?=
 =?utf-8?B?VFlUVlh3K3FyQjJEZmE1TFlEVzFWekVFamR2RWNKM0hRWEh4RUJJL0NxaU10?=
 =?utf-8?B?L2R3ZnV1UElMWkhTRnFPWVV2QTNyMm5tT2FIaDB4SjQrK0dMSTgyV0pWeWRk?=
 =?utf-8?B?SjZ5ckZRMlV3THlFa2NMc0Y3ODhTSjBBS01UVVVOVTdIang2NHRKZFNDTmpR?=
 =?utf-8?B?Ykp5TUN1a0FxbDcrRUpPeFIrY2ZWTGZxaWhKYkxySGVOUzBCcjk1am85NG5Y?=
 =?utf-8?B?OGFUek9vZjRZK2hsWlIwV0ZrRmdTcW41VHFrRlZDdDloV3k5VXcyd0V1eGVX?=
 =?utf-8?B?QkZpSFpSWGxpZ1FLeWplZFZkNENncWJJaVh3R01NakdIWlU4VmRkOGtBN3VH?=
 =?utf-8?B?bFNJQ1VJc1BvN05jMkQwQ2l2dTI1VTBhZFNBSUdUWFFPL1M3T3kzMWovUlY3?=
 =?utf-8?B?VkZIVGd5U3BBczAvVmhNd2FaelRjRFoyTm1hZ3NSRGVrSWhjZHJ4bU0wUDRu?=
 =?utf-8?B?VE02a05Nc2R2K2duQnN6R09TQnlBeEltOEt3SXplV25idXBaM3dra2p2czQ0?=
 =?utf-8?B?RjZwRGdDTkl6LzY2YlJ1VnpwOVdPbjA4OHAxbVJGRkgycWFpMnlsRXJ2Wjgr?=
 =?utf-8?B?MGQvMTFEOUhVMERiazE4Z0diOVcyVkN4Smtjc2pOelltUmpzbTZXMGpjKzB4?=
 =?utf-8?B?ZkhUODF6QXp2NU9rbXVLaHR3cEZMM0dmV1A0STdJbTlhNDNQVnhyb3FUR1BL?=
 =?utf-8?B?bGdmWStkMzVWMmsyanFoNGNqcENQYUNpUTJYbFNOWFJHcXhHN1M4WHpRbTUw?=
 =?utf-8?B?dUtkTDNzRXcvUjA4eXdERXlTRnVlZnV2MU15NXdmZy92UEVUdldra1VzS2ZD?=
 =?utf-8?B?Ry9paFMxVUVsSzhFeWJaSjV3YSs4MitCQjNESkp3bnR1bnprUmxCR3k3dnh6?=
 =?utf-8?B?NXpJSVIwWmdlaWtrYUNJa1ZSekZ4UWN2YVA3WjBvZWZHRnh2NDZLSTdlUkhX?=
 =?utf-8?B?bGJ2OW1oNHdSL1lhTElTYXFBbmRlUVRzd01mck9LS3NGSEVvWXlqcnNDbkEr?=
 =?utf-8?B?UCtPZzlFcVBTcFMwcXFEUkNXTndyb0V0R21BQ29RMUZnTTdDUWFtODlQaUho?=
 =?utf-8?B?aXQ5WUg1M0oySHc2RjhoVllkRHpxTFpnRCtMNFNzekZPWVpQNjlaTmt6eklG?=
 =?utf-8?B?NUh3RGx2a0NhTzVvOFpMalBEeVJNamNDOTFZb3h5VFF4UTU5cTFMN2w0b1Nj?=
 =?utf-8?B?cVBwVm1PNFRoZ0c2OHFTWmNIZ0JZSnBkc3VVY0QwMnhZOGpzRndmSnRHd0J2?=
 =?utf-8?B?aHp6UHpWanM2UkF1WmFOdElrTmc1ZFp3NlE5YURXUEpZaEdVR1owWTNsbG5D?=
 =?utf-8?B?QzloVnozQUVseWprVjRPWC80TldVR3Ezd01nV3hSenNyWk1VVHlSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843918c4-4727-48bd-8279-08de7548779c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:05:24.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+gV0Q2DQ9m2fdWjjH4VuxOHqGp4SgJQfxBIgHDhnYIOcIMHk4DBTuuoa0MA8mk7diH9rxleH7pxhCEmchebyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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


On 26-02-2026 08:30 pm, Alex Deucher wrote:
> On Thu, Feb 26, 2026 at 2:42 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> queue id always remain a positive value and should
>> be of type unsigned.
> Does it need to be a u32 or can you just use an unsigned int?

UAPI, where we are returning the queue id is u32 and based on that i 
changed this to u32 only, but i guess unsigned int also should be ok.

whatever you suggest is fine for me.

Regards
Sunil khatri

>
> Alex
>
>> With this we also dont need to typecast the id to other
>> types specially in xarray functions.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index b700c2b91465..e07b2082cf25 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -447,7 +447,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
>>   }
>>
>>   static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>> -                                int queue_id)
>> +                                u32 queue_id)
>>   {
>>          struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>          struct amdgpu_device *adev = uq_mgr->adev;
>> @@ -461,7 +461,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>>          uq_funcs->mqd_destroy(queue);
>>          amdgpu_userq_fence_driver_free(queue);
>>          /* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>> -       xa_erase_irq(&uq_mgr->userq_xa, (unsigned long)queue_id);
>> +       xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>>          xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>>          queue->userq_mgr = NULL;
>>          list_del(&queue->userq_va_list);
>> @@ -471,7 +471,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>>   }
>>
>>   static struct amdgpu_usermode_queue *
>> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>> +amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>>   {
>>          return xa_load(&uq_mgr->userq_xa, qid);
>>   }
>> @@ -625,7 +625,7 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>   }
>>
>>   static int
>> -amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>> +amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>>   {
>>          struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>          struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> --
>> 2.34.1
>>
