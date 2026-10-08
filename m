Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC1ECA600E
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 10:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78B610E7AB;
	Thu,  8 Oct 2026 10:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rMz5MHT9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68AB10E7AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 10:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itAmOzuOhH9CQEN2MfriBdFW4LoZDotfoTs6290RebRImuUxfvxzP+xML/R4+Nhc4oN8pkH6RkAn2bhzi3fd2BrffSEHeXDZlmIVM2F/xFtW+vRqgN1xsCc44SddjIyjzWLHN7+JKIN7iLElesZFMGeLTDtt8uKVfI04G6pWTJEq2nu/WYhGm7WdwouYsk7+U0UwwgFjmOvk3/Bbcvg+Lb/thmiAEDjSTsRYO0bka18hfhZiV7ANwnsQW1zLg8an5hRE8q0GwNfpNg4ij1rDmvpX0isqcHE6Jv5tnmqYzyq+xPKNqZT3HwP8zT/Nys+QVUHkxNY/zGxR1Dr/T4om4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74l2yVcLV9yKfa/Tgn9AkiRWMpUoR//IHQT6ynBRjGY=;
 b=O2zN5xLmpEFtSEOrJRDczZB7AEqiLyWyX4MMVhJlM27yQ/JoSCFlZC8lrUOtsM7MtdF4tHCMZJpyZ0QfnENB8iQt681AOrg26oTnkIxnbi/eqCB6DZ/WhL90AYdk23EOog/XnjnBrhcX7Uxtz+5YdbEwY1JP1psAePv8T/kXfLs+gbfjRibE6s80oKqooAEZ/xfVWegmNHct72/vx2UPYGld5bhYiQ7vh9U2vykOCzmi6GFDwiag1IFxig0KzdkJ4OIdhsXL/Tr5qOevrhAwtrxvWUaKAjfxtZMOZAA+bithZYGk79guAenAq4vdWxE58e5m1qe9qyvweQrkGxjoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74l2yVcLV9yKfa/Tgn9AkiRWMpUoR//IHQT6ynBRjGY=;
 b=rMz5MHT9w13+gOQwMGEgBi6xaY3ZeaNklzVxQKpceV3kT2a45GeCW6y8BfFboEtjDk6Omi8hLjwXNNNlfcKKLm8i1u9AipVrfwDvjXnM4G2NRpU2DCdTrLucS8q5AVHvOwLd6f2/2RXAn6q+ToUsOsioEEw5/uiyUG3ix+lW4Mc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 8 Oct
 2026 10:06:19 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0472.015; Thu, 8 Oct 2026
 10:06:19 +0000
Content-Type: multipart/alternative;
 boundary="------------9VAO0n4Qjm0mBAvxyQqjB8Iu"
Message-ID: <e1780cde-9ff2-46f3-b722-ee02b18d1ddc@amd.com>
Date: Thu, 8 Oct 2026 15:36:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: rename first_kfd_vmid to
 first_userq_vmid
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261008065234.2945047-1-sunil.khatri@amd.com>
 <592cb596-a16b-4ac7-a365-7cfaffe05cc4@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <592cb596-a16b-4ac7-a365-7cfaffe05cc4@amd.com>
X-ClientProxiedBy: PN4P287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::12) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb7d596-973e-4d15-cf80-08df2523cc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|4143699003|6133799003|10067099003|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: Ps00ua4U79rZLIGZuJ/S28lrpWuv2eWpSM01FXEiXLZdBm24u+hr724p1TPvKw3/B5AH0xPv0vI9n2LDzshJUz6jWtKs/uz+QoRbvFVqjOlkaUCGJRYsXP3j1GL2O/RMbZ6Bxk4LzvTvS1FYnUEYbCtWUdgyS9eLqQDLJ0GQLWih/hMe9Y2S7l+Yk+k/pcWbjjNT0A9BUeXC/MQ8fPr6FV+in5uqRcHnrZBZ0+mdJydpUkUyFqOp32AWLmtX5K/c25qZAsish8faxxXzTv+kb74EaS7Z919rWmjsIKuF8CuIb7Hz2eirZIs2hqV+V1/quSOd0mCdA7u6nTNaXK1XhHdKygSSu6zsMEd5xqKIav5xk0Qgt82pBFt62l/A8Z81+DSHXVqObZZnUFQiQEdtAD++V1/gTx5hT4m697AOw4ub+/lrQAXFHgBq/HG93v5wFO0tCt1wjsjiaSKMwpy8iiWZalhPhFuinxmHPl/pOaPLLKkTvLYJYZ4ici2iQj2Zu9kQcPFqhqSIAKYBTDPRX41u46FxcU6/WmNVJzbhdRwk/n+thtvzVNCNgVf9wla9Bb0Inr4RYSLt3+PeO9x5iHFTTjm88KhZr2IpQsJfheIxbzSOXZUxk1/QfMl9Re+4q3+KWwMzCG+L11NNKX2pUXTdhfFredkqUYRof/XN0QE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003)(10067099003)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDlBRTcrOG9McndQQUl2N0E0NnR5dDEyV3V5RE9zWC9ZSFRoSUp2c0hMQ290?=
 =?utf-8?B?YS92NHRyWlIrZWEvOHdjZjBlbmhCMzR2Y3dPc3ZPWHJRNysvektPQmdSelhq?=
 =?utf-8?B?bGFTMS9JdEJGbkJ5SHZkNmNXYkVRVUp2NFlWZW5NTXNuUkFBMWxqc2JuZVAv?=
 =?utf-8?B?MkpzOUlLRnNHVk1qWVFTbHFxdWhsU3I0eFpHaW0yOHJ1YVhFMVA3QW5PR0hv?=
 =?utf-8?B?OU8zeWNQaUduTHZWS2VOTHY4ZzZLSGdhTk9PR3ZvejRLZitOQTUwL054b3c5?=
 =?utf-8?B?NktpV0djZ2owQnpvSmZMUFVaTXJ4enUxWXZFVERpVlFhYVBnZlhHMUtzVjdu?=
 =?utf-8?B?aU9pOTc5aVpyMmpGckVKWnVuK2ZhSXpWeEEydzJGTVdzVy9wQ2g3QjlUSzFH?=
 =?utf-8?B?T1JBRi9tZXprSGlGY0NGckZxMEpKVmhWVExmeGozUFlpQjh4aGJkaUVEV1Vl?=
 =?utf-8?B?UHQvNVk3YXhhMUo1Tm4xZ0NmcWFHRVRET3UyUGxESGdIMjA3VXN0YkFQc2cx?=
 =?utf-8?B?M2sxMWtsc2J4TkgrVW1RRkhrL3NURkxHV3ZOa2JvYTl5dHBJcW5CN3ZWT0x0?=
 =?utf-8?B?UW1BU1VKVGwrUS9kem1RMm5jNzNqeUVBZjNmbU81NXo3NTEvRVNxdCtsNWwr?=
 =?utf-8?B?RTNUSEpRVy9NbGJWdW5CT0k1TjFyVEFoRUNTYmJ1am9idXIvc08yM0lQZUtq?=
 =?utf-8?B?cTBQdWFhRFhYaTBaY0VUWnVncHp2SE8vcGViaEZvb0ExeTNZdE5mUGRRdGY1?=
 =?utf-8?B?c0ZZRXdzeGFBanR0SEFIRk5PSi9zRW9xZ2h6a01MOVAxbFpvMm1hRFhTM29z?=
 =?utf-8?B?Q2lqTWlwWVlVNjVHOWJDT01kUElhWmtXNW1wcjJjdE1mWllxcDFXYTM5TWtl?=
 =?utf-8?B?MFRoL2RIZmw2KytwRjZPK2R3NEhFTzZGSGpzdWJWa2JPSWttVmZtdTg1czVB?=
 =?utf-8?B?L1dkZGNwaWQrZy9jOUJsZzNsNGNrVDJOWjlzMWhtREhDOUNRQ1NmbWtKendw?=
 =?utf-8?B?RFk0bWJxNTV3Unk2R0VBRWxKYUtidzg5V2ZaY2tleHhzRkpTVnBJRU5PWUFM?=
 =?utf-8?B?bEVaV1E0RVZNMjhTbFczK3J2bFBWOXduMmtldjBPbWd1N3RXRWRkR2VEZ21C?=
 =?utf-8?B?Vi9BWTdoaytsN29PUWNqc08rSmpZUGpKZU93S0E0MGdNaWFEY05EaFlrQUpj?=
 =?utf-8?B?RXc1TFpodUNHM1dzdUZ4aU92dW9oZ1hnRTY2bmhuaEUvUjN4WFpoelN6YmJr?=
 =?utf-8?B?YXhURVpiRXpPQ25XTjZMdnNjVjNBZWxpWFcwSEtpUTdtdzE3bEc1ZTVOMUdx?=
 =?utf-8?B?dGpQTWxZU25YRWdySG9rS01SNndLd3M0ZThvQnRJa0hZa0c0WjZ1bXd5QjBH?=
 =?utf-8?B?M0QvZUg3UEFVNFJJalg3eldmVXpycUdlSmlWSVFnR3J1bVFRL25wcVo3anND?=
 =?utf-8?B?Y0dmaHZSSWtLS21NWlRGMnFQdnZiaXUwaWZPRHE4dWxrYVBPZTZPWE9ZbGxl?=
 =?utf-8?B?cFhqbjNzVDgrUUVqL3BxRjVVM3hyN3A5bC9nV2xxNXhQaFJEenkzT3d3eWc3?=
 =?utf-8?B?MktYQXJGaGpGWGk0NmE0OEQ0V01jUmxaR01TOVVDTDdaaExnYkpMdzlkeEp5?=
 =?utf-8?B?NnVhaUtjN2lOWnNCeVJ4SFhzV1BvaldoSHhBMEVHZGgyTHJreUVuTE1iVDVU?=
 =?utf-8?B?ZWxKRHlHOUhRVHk2N3dqaElFM2FNRHptT3VMNUxqSHcwL3pvbGV3UkdBNVhh?=
 =?utf-8?B?ZXlzOFloM0xhYS94V0ZZNE1kL1FMbHhMcUVXdEczK2M5QkZCQmhBb1NJWHFo?=
 =?utf-8?B?MGwwdDJENFZpRVMxUTJRTVBETG9nbEkrcG5ZdXd6NVAzOEpFMW5ZT2l2amRy?=
 =?utf-8?B?N3VraHJiUTBRTFR5OWZxNit6N0RCRVplRG5XK2JCZVQ5ekw3QU9JRldPR0c1?=
 =?utf-8?B?bmNmRUNaN2RzRG1GdHd4VFJzdWYzV3h0UDY0dWhQQUJsczh2QVcyTm5RSTJW?=
 =?utf-8?B?cXpYRWM2T3dsWXVMck03NFFiUEZTK2VKTjhFa09INmxUMTh1NjZZMW4ycmtN?=
 =?utf-8?B?c0k2bmpHeVJyaUo3bGU3dmlya245UEplU1kvOUdNRjNubE5sS2hZdHhXd2Fu?=
 =?utf-8?B?UGc3ZTN6V0FtR0N4YktBMWk2M3RpNDVZeklsTGdmVXVvbVpFY0Vvakw3eXpa?=
 =?utf-8?B?RkkyemUvaWVyeFVSQ1dEbTZHMldpVkRlVFdNZE1URlpBMkNWNUY3NlRKVndr?=
 =?utf-8?B?VjJheXMzSWtDWkx0cXkrekhIREVMOW4wcDI2dGtDeTBGK2RQa01XdWZsTUxW?=
 =?utf-8?B?c1hiNkZMa2tIWGFKNkpoM3AvNTR0bDdraVA3Ui8vNWxwR1RWSVdSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb7d596-973e-4d15-cf80-08df2523cc1b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:06:19.2407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGk8rSbD3L5F2vzS6MPDER5r0iqNms5yJTM/xAPZQhHpOQXlfYnC9fkXVgxuQ+h+7U/Wlk36wg3vnbHk6+7YfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

--------------9VAO0n4Qjm0mBAvxyQqjB8Iu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08-10-2026 02:45 pm, Christian König wrote:
> On 10/8/26 08:52, Sunil Khatri wrote:
>> The boundary VMID is shared by KFD and KGD MES user queues alike,
>> not just KFD, so first_kfd_vmid is a misnomer. Rename it to
>> first_userq_vmid. Pure rename, no functional change.
> I would make that a mask as well in the same patch.

Do you mean me to merge patch 2 with this?

Regards

Sunil Khatri

> Regards,
> Christian.
>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 6 +++---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 6 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 6 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 6 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 8 ++++----
>>   18 files changed, 42 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 3391e8c77f13b..38eef8e7155aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>>   {
>>   	if (adev->kfd.dev)
>> -		return vmid >= adev->vm_manager.first_kfd_vmid;
>> +		return vmid >= adev->vm_manager.first_userq_vmid;
>>   
>>   	return false;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 9cdd8870960a6..d2414b4656805 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -652,13 +652,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>>    * @adev: amdgpu_device pointer
>>    *
>>    * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
>> - * first_kfd_vmid, shared by KFD and MES user queues.
>> + * first_userq_vmid, shared by KFD and MES user queues.
>>    */
>>   static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
>>   {
>>   	adev->vm_manager.vmid_uq_mask_gfxhub =
>>   		((1U << AMDGPU_NUM_VMID) - 1) &
>> -		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
>> +		~((1U << adev->vm_manager.first_userq_vmid) - 1);
>>   	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8e478d3bda1ac..4c407d705d0c0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -383,7 +383,7 @@ struct amdgpu_vm {
>>   struct amdgpu_vm_manager {
>>   	/* Handling of VMIDs */
>>   	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
>> -	unsigned int				first_kfd_vmid;
>> +	unsigned int				first_userq_vmid;
>>   	bool					concurrent_flush;
>>   
>>   	uint64_t				max_pfn;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 33403e16df5ca..cd1f01604c4b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -5214,7 +5214,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>>   	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		nv_grbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>> @@ -5227,14 +5227,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	 * access. These should be enabled by FW for target VMIDs.
>>   	 */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>>   	}
>>   
>> -	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
>> +	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_userq_vmid,
>>   					AMDGPU_NUM_VMID);
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index d5f428ac19bf3..7d66f41aa8957 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SCRATCH_APP_BASE;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		soc21_grbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>> @@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	 * access. These should be enabled by FW for target VMIDs.
>>   	 */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 420ce997bebc7..9245fc1c95767 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SCRATCH_APP_BASE;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		soc24_grbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> index 4498e253846f1..4b7f90fa203b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> @@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>   	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>>   		/* CP and shaders */
>>   		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 549d1239e326b..0bdb800dafc64 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>   	sh_mem_config |= MTYPE_NONCACHED << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		cik_srbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
>> @@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>>   
>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	   access. These should be enabled by FW for target VMIDs. */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>>   		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>>   		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index ab4123ddbb942..403ed29e7c0b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		vi_srbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
>> @@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>>   
>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	   access. These should be enabled by FW for target VMIDs. */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>>   		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>>   		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1678015ce5a97..231dacdf16548 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -2610,7 +2610,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		soc15_grbm_select(adev, 0, 0, 0, i, 0);
>>   		/* CP and shaders */
>>   		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
>> @@ -2621,7 +2621,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>>   
>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	   access. These should be enabled by FW for target VMIDs. */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>> @@ -4933,10 +4933,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>>   
>>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
>>   		gfx_v9_4_2_debug_trap_config_init(adev,
>> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
>> +			adev->vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
>>   	else
>>   		gfx_v9_0_debug_trap_config_init(adev,
>> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
>> +			adev->vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 01ed1701c781a..1479dbc20c706 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>>   		/* CP and shaders */
>>   		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
>> @@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	 * access. These should be enabled by FW for target VMIDs.
>>   	 */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 490b4c4eb662a..259aca57a3ec0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -869,9 +869,9 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = 8;
>> +	adev->vm_manager.first_userq_vmid = 8;
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      false);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 3cdc7893587a1..daec00725b969 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -854,10 +854,10 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
>> +	adev->vm_manager.first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
>>   
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      false);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index fcc1d580fa946..f3e9759833b77 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -997,19 +997,19 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 */
>>   	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
>>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
>> -		adev->vm_manager.first_kfd_vmid = 3;
>> +		adev->vm_manager.first_userq_vmid = 3;
>>   		adev->vm_manager.npa_vmid = 15;
>>   		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
>>   	} else {
>> -		adev->vm_manager.first_kfd_vmid = 8;
>> +		adev->vm_manager.first_userq_vmid = 8;
>>   	}
>>   
>>   	if (adev->gfx.disable_kq)
>> -		adev->vm_manager.first_kfd_vmid = 1;
>> +		adev->vm_manager.first_userq_vmid = 1;
>>   
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      false);
>>   
>>   	amdgpu_vm_manager_init(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index 71409eb718d39..2fb3b0687ab70 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -824,12 +824,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = 8;
>> +	adev->vm_manager.first_userq_vmid = 8;
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      false);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      true);
>>   	amdgpu_vm_manager_init(adev);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index c95e097241bf8..1208822b6ef8d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -1006,12 +1006,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = 8;
>> +	adev->vm_manager.first_userq_vmid = 8;
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      false);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      true);
>>   	amdgpu_vm_manager_init(adev);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 8d8a0775878ff..b21dc8fc6a9a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -1121,12 +1121,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = 8;
>> +	adev->vm_manager.first_userq_vmid = 8;
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      false);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      true);
>>   	amdgpu_vm_manager_init(adev);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 85ba228f002d0..f9d2e82c34793 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -2030,9 +2030,9 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	    adev->jpeg.disable_kq &&
>>   	    adev->vcn.disable_kq &&
>>   	    adev->sdma.no_user_submission)
>> -		adev->vm_manager.first_kfd_vmid = 1;
>> +		adev->vm_manager.first_userq_vmid = 1;
>>   	else
>> -		adev->vm_manager.first_kfd_vmid =
>> +		adev->vm_manager.first_userq_vmid =
>>   			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
>>   			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
>>   			 amdgpu_is_multi_aid(adev)) ?
>> @@ -2040,10 +2040,10 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   			8;
>>   
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      false);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> +				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
>>   				      true);
>>   	amdgpu_vm_manager_init(adev);
>>   
--------------9VAO0n4Qjm0mBAvxyQqjB8Iu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08-10-2026 02:45 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:592cb596-a16b-4ac7-a365-7cfaffe05cc4@amd.com">
      <pre wrap="" class="moz-quote-pre">On 10/8/26 08:52, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The boundary VMID is shared by KFD and KGD MES user queues alike,
not just KFD, so first_kfd_vmid is a misnomer. Rename it to
first_userq_vmid. Pure rename, no functional change.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I would make that a mask as well in the same patch.
</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">Do you mean me to merge patch 2 with this?</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Sunil Khatri</span></p>
    <blockquote type="cite" cite="mid:592cb596-a16b-4ac7-a365-7cfaffe05cc4@amd.com">
      <pre wrap="" class="moz-quote-pre">
Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 8 ++++----
 18 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3391e8c77f13b..38eef8e7155aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 {
 	if (adev-&gt;kfd.dev)
-		return vmid &gt;= adev-&gt;vm_manager.first_kfd_vmid;
+		return vmid &gt;= adev-&gt;vm_manager.first_userq_vmid;
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9cdd8870960a6..d2414b4656805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -652,13 +652,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  *
  * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
- * first_kfd_vmid, shared by KFD and MES user queues.
+ * first_userq_vmid, shared by KFD and MES user queues.
  */
 static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
 {
 	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
 		((1U &lt;&lt; AMDGPU_NUM_VMID) - 1) &amp;
-		~((1U &lt;&lt; adev-&gt;vm_manager.first_kfd_vmid) - 1);
+		~((1U &lt;&lt; adev-&gt;vm_manager.first_userq_vmid) - 1);
 	adev-&gt;vm_manager.vmid_uq_mask_mmhub = 0xFF00;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1ac..4c407d705d0c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -383,7 +383,7 @@ struct amdgpu_vm {
 struct amdgpu_vm_manager {
 	/* Handling of VMIDs */
 	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
-	unsigned int				first_kfd_vmid;
+	unsigned int				first_userq_vmid;
 	bool					concurrent_flush;
 
 	uint64_t				max_pfn;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 33403e16df5ca..cd1f01604c4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5214,7 +5214,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES &lt;&lt; 16);
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -5227,14 +5227,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
 
-	gfx_v10_0_debug_trap_config_init(adev, adev-&gt;vm_manager.first_kfd_vmid,
+	gfx_v10_0_debug_trap_config_init(adev, adev-&gt;vm_manager.first_userq_vmid,
 					AMDGPU_NUM_VMID);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d5f428ac19bf3..7d66f41aa8957 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 420ce997bebc7..9245fc1c95767 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc24_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4498e253846f1..4b7f90fa203b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 549d1239e326b..0bdb800dafc64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 	sh_mem_config |= MTYPE_NONCACHED &lt;&lt; SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		cik_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ab4123ddbb942..403ed29e7c0b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1678015ce5a97..231dacdf16548 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2610,7 +2610,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
@@ -2621,7 +2621,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
@@ -4933,10 +4933,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
 		gfx_v9_4_2_debug_trap_config_init(adev,
-			adev-&gt;vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+			adev-&gt;vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
 	else
 		gfx_v9_0_debug_trap_config_init(adev,
-			adev-&gt;vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+			adev-&gt;vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 01ed1701c781a..1479dbc20c706 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
@@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for (i = adev-&gt;vm_manager.first_userq_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 490b4c4eb662a..259aca57a3ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -869,9 +869,9 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
+	adev-&gt;vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3cdc7893587a1..daec00725b969 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -854,10 +854,10 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = adev-&gt;gfx.disable_kq ? 1 : 8;
+	adev-&gt;vm_manager.first_userq_vmid = adev-&gt;gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index fcc1d580fa946..f3e9759833b77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -997,19 +997,19 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		adev-&gt;vm_manager.first_kfd_vmid = 3;
+		adev-&gt;vm_manager.first_userq_vmid = 3;
 		adev-&gt;vm_manager.npa_vmid = 15;
 		mmhub_vmid_mask &amp;= ~BIT(adev-&gt;vm_manager.npa_vmid);
 	} else {
-		adev-&gt;vm_manager.first_kfd_vmid = 8;
+		adev-&gt;vm_manager.first_userq_vmid = 8;
 	}
 
 	if (adev-&gt;gfx.disable_kq)
-		adev-&gt;vm_manager.first_kfd_vmid = 1;
+		adev-&gt;vm_manager.first_userq_vmid = 1;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 
 	amdgpu_vm_manager_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 71409eb718d39..2fb3b0687ab70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -824,12 +824,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
+	adev-&gt;vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c95e097241bf8..1208822b6ef8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1006,12 +1006,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
+	adev-&gt;vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 8d8a0775878ff..b21dc8fc6a9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1121,12 +1121,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
+	adev-&gt;vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 85ba228f002d0..f9d2e82c34793 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2030,9 +2030,9 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	    adev-&gt;jpeg.disable_kq &amp;&amp;
 	    adev-&gt;vcn.disable_kq &amp;&amp;
 	    adev-&gt;sdma.no_user_submission)
-		adev-&gt;vm_manager.first_kfd_vmid = 1;
+		adev-&gt;vm_manager.first_userq_vmid = 1;
 	else
-		adev-&gt;vm_manager.first_kfd_vmid =
+		adev-&gt;vm_manager.first_userq_vmid =
 			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 			 amdgpu_is_multi_aid(adev)) ?
@@ -2040,10 +2040,10 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 			8;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev-&gt;vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------9VAO0n4Qjm0mBAvxyQqjB8Iu--
