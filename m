Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B394C5CFEB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 06:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC8210E1FF;
	Thu, 13 Aug 2026 06:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YM1VwMTs";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7193610E1FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 06:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiKj26SjigELrQzcvEfWjquupn2F4EWEFmufKXLb/U+sOZ0/9yLy7pYbQaL5lq5l9E3cKTdBjZZAHo09tJu9JECsbHCs8dPo7VDrb3yQ4reWKWixcYBYhmqwNbRdq4K2TAzKEmncovqamEPsa9ZaRoo3Zss7Po2D3JpMA07cnbQ5dbn7CGGhviQu8wEVVzg4qSQYYH2AamJ7Q9Korjws2TclSRjZsjJ/hkh9uoSU8GGQLvfW1W9eEFVHii0pubTiL52hO+tPheVgk7PRUeNwZ1bcpxTIqO1RVdDqad95a9WI8HjUp5wIQtZY3uWrPnwWCe3PD0WQVfKo5XL1GzdVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtDV+h5SCGcBxog5vae/nzvyXhk4BYCxiaTtkwl21ZQ=;
 b=HKQQ5beoRT8KTB8qlMVp60zpmrV8wgjO2TLXGOZSOaWG3c+fyjh9Te6vpTCc8YISZhgZ56JMq2EsS27Rhw8mVorzSmvz5SDVTHB+wrphE6rJ1Kv6d+/EqgCM+BlBT7PHIILrxbZlE9DhxjPk9l9le6f5++Fg2y97cPpdUNz6KAgt9JAIWzXpO2fF1nI4u4jyX7AE/dkaTbo5kBj/1wL5HiSlYrBwNdL1gXu+hVQptLIsyo1lFOmX8HJuxQj8/T7GI1tdRrdioNAG6grI8VZ+Jim7U6M5i2eNmrrL4AlrjbL01TSKwRytZFFUpZSfy+4+i8oDez6cvxUBoulRY0hDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtDV+h5SCGcBxog5vae/nzvyXhk4BYCxiaTtkwl21ZQ=;
 b=YM1VwMTs4bbp32OZCex6Un2bf6fWvsuIxJxyX08LJtp2F0k2ZZSX+BNI7qF+PswYDQbcW3PDG56OyOkiq2peX3s+i955tu7xZutH08d6RzZ2uBi3PjZ3u92hA7AK0+FfevdwR25QZlpSxTBClm4tk5uJRMWr+VEhvOSE36AmuOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 06:21:33 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 06:21:33 +0000
Content-Type: multipart/alternative;
 boundary="------------FbBlHFvZ0BgSzreCD1dQEl70"
Message-ID: <be92ca16-443a-478d-96dc-c83318df3670@amd.com>
Date: Thu, 13 Aug 2026 14:21:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: allow profiler process reenter
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260806084312.79422-1-lingshan.zhu@amd.com>
 <CH2PR12MB94573C6D5DD3480E33E6463F8CDC2@CH2PR12MB9457.namprd12.prod.outlook.com>
 <3f62daa5-7c4c-476b-b692-0cb544e3d2a3@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <3f62daa5-7c4c-476b-b692-0cb544e3d2a3@amd.com>
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: dfca35ea-4d30-457e-50c4-08def9031ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|5023799004|11063799006|10067099003|6133799003|18002099003|22082099003|4143699003|8096899003;
X-Microsoft-Antispam-Message-Info: jSB9MOiGVmqrtfgQX4uvj0JAwiKjOR31OPzEWLYpz2eDsnI6tBAuHklsQUTRncGvP2u+IgpknMjdOkCcKSSk+eTHYBomNHh23z8uMDtYRxZ6Mdq5qSP4M8OrxdfuYsG+MdVYVOzV5zTJ0YOKwDQlpnpTptlCSW6iuL+tDNW+mUHuxEF3XeWp/G7TlTWOBivwP3DipGRPZZtS0FRmdUS2wQtHTFkjNa5dFTdLjuF/wDQmKrDu5Yd9e0Jx1nO2XgSAAi7Mbe/E2lz1RzbCtwwrt5vDI48YA271Npmw1enmtwh8MdIsAbmxP3TmE3FIzBMJfgNu9TtK7SINaalqgML/p/3+IKjrhDHKAqacOgm5FVYN1dOLeBDUF+mV2lkmkpKdyfoO2h/0OekEMAQVsFgbM/t0ZkQqrYtFyj52X6Rk5wbj422sJZ8GHMKZ4S2CMAeVnOcrAcaFCIZx9rN3aQz+6aW4PCI3rHTmZYssk96IO1uVF3lopxaqebMECJZeo4TtKnrKMgpqLsAkpi06IitF1Rxr/VSONzvN6EjpPVPsCP6v5NjrH4Iq6zerwOcYs68juntmW6sYSKiWSLqDJr5qsXYhglSsAo7jfsA71iPB2WtrV6Zus5wUlWLOrNWfYjkdVATF0sZrFS/Fafo4VH2N9ZBZDUA504eQY9rfWHGE7Uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWowcTRvN0tpMUIycy96eVFnVllRR0IycEs3aEFCUjFLTnRtZ2FOd3BSMFhh?=
 =?utf-8?B?TUVQS0JaUWhPTldVSEpueitxRE9rMUIxcHAyL3hXRks3ZXE0djBGTGFDNmwv?=
 =?utf-8?B?VVlhRVNOUHdlNFlESHcyMk9wZ3VjaElVVWZIUmFPQ3BCUFk2WjlVeEloTjB4?=
 =?utf-8?B?T09WaG1ONklzZGlIUEJuR3FzNlUrQnBGUTNHR1N4b0pGcjJHYWp4ZXBuU1Bl?=
 =?utf-8?B?NkxPZW9DRGNvR212L1JEZDNnT1pITzJxQkJxaHYzem12R0JHRjBrRkpuSDBZ?=
 =?utf-8?B?Kzd0dUlGWm1FNXJuRENOMEQ1b1RsTHNjK01JZ1dXWS84T29kNlhDRUdiRnk1?=
 =?utf-8?B?Y0wvVjBRRjgyT3FTM0RncmwzU0M3c0lZbHdMcTBjd3pIbXArcVBEUVZUamFi?=
 =?utf-8?B?YmJTYmRPelpOQ0NQaDdxMks5OWFleC9RYVIzTUdrdSs1YWpNNXh5QTlpa3VS?=
 =?utf-8?B?UTJNMEd0M3ZmdDJ0c3hLSjRKOW96SXNnN2UvTk5CQW9UT094UXpBQ2Vhc2d3?=
 =?utf-8?B?dVE3dDBKYjFXZkFDdDBLcHFjWEgyVzR6cW1TTkdRME1LNDZJWjBsWGh3NndS?=
 =?utf-8?B?c0JTUlhNaDNSODI0eFNncnB6eU5aaDF3MUN6VVh6dXU5OXk4OGxwRGxJcnNZ?=
 =?utf-8?B?K2JVU2l3V1hPdG9YQkFESE1IeFJubHpyUWhkTnlFTjY0M1Y0QXdrNkVPTGpZ?=
 =?utf-8?B?bWdlSU5URjNzMFdwZVkwcGRZTEx2UVJkTDIwaGxjWU9YaVNaMkJnWEFOMFY3?=
 =?utf-8?B?bXExbEt3azhwdCtaMTR6dkNRMGdITHhwMkNzN09uWnM5MzV3cTRzemg1bWR6?=
 =?utf-8?B?SGZySW5IZFFLdlF5WEJ6eUlwczdob1Q2NWg0R1ZBYXBLYWN6LzFRcmUzNzBH?=
 =?utf-8?B?MjBkMk9id2JzZGlTU0QzalBBMUlSSnZMREVPKzdNU0hudWpkMGpUUUNNMVAy?=
 =?utf-8?B?a0NPTkxzUmsxdGovVkszYmdlRDNWU293ZzBYVGVkU0lOSXhvZ3VLYnR6RzU1?=
 =?utf-8?B?OHhVUVg4djJkdW5aVmhzMHd4OUlyMTNFTjVjcldxbUFiZ2cvUmJCdy91MUxE?=
 =?utf-8?B?UisxUFN2TkRNZjhjWWt3dXlZR0RQLzY0OEMwb0h5TXJ1WmU4b056QW1zOCtz?=
 =?utf-8?B?b2xOd3FmVkQxM0M2L3RnbkRVcG9lR0hUMHlkOEtKYklkUldKR0I1S2NFUGYx?=
 =?utf-8?B?WDI3S0xYNndCcFZwSW9xdmRYWWtQbmd4VGhrSk9Hc0xsN1FsMU9lMURnd3kr?=
 =?utf-8?B?U0NOS29zWEZDeDlmdVYyU2NGeVhwdWM4UUtsT3RQN3FIT3d5OFZMYkJiT3dY?=
 =?utf-8?B?MURiVXNsMU5hY25nNVpHS2FtR1doMTJsTU1sRjhHK3ZIVkxWK1hlQ2dMcmkz?=
 =?utf-8?B?c0R0OHQxU25VU25DT0VzN2ZjalppM284dlFHMVBVWC9IZkxJVkluRU9veXB6?=
 =?utf-8?B?Vy9QSmZjalIyckpIZDhzT3h1OFp0dTNRWGRiWHFDbzhSNVpYV3dWQkRrQ2p3?=
 =?utf-8?B?VXBKWkdUTFNzK0NhU1orODI4VXBDZk5Sb2tqNXBqVnk1U04xZEs0RXp4VGZ1?=
 =?utf-8?B?eXNocjdsd0MvKzdRYlo4MEgzZ1oyQndlWDBWa1puczBpclFrNElQNnJDbTZB?=
 =?utf-8?B?VThrMzBDaTUxZmdycmdlQ3U1ZXJzSE56MVdUMGxQQkxhRDNnV2lHUnR4M3pI?=
 =?utf-8?B?SmpIRURYSFpsUktWU2dQOVMyMDY4bStNUVE5RWRXNzJGMXhSYnZPK0JtTysv?=
 =?utf-8?B?WHgyVnBHMlBIRWFRTUNEMkZmVG9sU3dLTUNKdGlhUDRxRVdsOStGSmNIc3ZC?=
 =?utf-8?B?Y0hnZDVqdjl2SkhvOGFPSU0wRHk0SnBOcFJXZHhXbzdsTnZSRmtDM2lUQllx?=
 =?utf-8?B?YUsrOFpmbnZ2YTcxZkdWdmNlY1Z0dmpzUms5WHJ0ajFFc3doUEF0U29tZmIz?=
 =?utf-8?B?MWF0dFM4MExYYngwSm44c0hPT0RxbUdSK0hYQUYyZHhZZGp3RnQzcGVxamVz?=
 =?utf-8?B?YW5VQzJ1R283Ky9RdlNYem5zQTU1U2hhKzF0cVNubURNYjU0cFhJR2dvNDU1?=
 =?utf-8?B?elJaQUpPcnloNk1YZ05HNzN0alFLd29iUktoYjRWWmtXbDRCOElhUmFPK2VU?=
 =?utf-8?B?NVl1akhBejRESENDN2ZuN0N4ZDhWL1FTK3VwLzJ0Tkd1bkRrb0RFZXNHTy9j?=
 =?utf-8?B?RUt4VWVKOWx6VDAyY2RnL1lud1hIMnFSSnpUY1czK05ncU9iK2FGbDFlZ1NQ?=
 =?utf-8?B?RG03Q0RlcWhZMzJ2bWNhTTY1ODdhNHhHL3ZHdThIck45VVcwMWFUQXpXdWF6?=
 =?utf-8?Q?tb1OngGsfluChfHEqj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfca35ea-4d30-457e-50c4-08def9031ee9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:21:33.6071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3jIwftVm0xaSODb1cwpFmt59tukTD+6Qfj276BGJytr5r0KXvjB/01XyazIeSLFUw/Q4qMO9M/hmn+BUwccLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
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

--------------FbBlHFvZ0BgSzreCD1dQEl70
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Felix,

Yes I agree the user space may be buggy, and the kernel should be robust.

Even though it is named locking, it is actually a reservation, not recursive locking.
The kfd_process that successfully invokes the ioctl reserves the device as a profiler. 
So when a user space locks the device multiple times, it does not increase any reference counters, and doesn't need to unlock multiple times.

Multiple times lockings from the same kfd_process just keeps the reservation, it still reserves the device successfully,
so IMHO kfd should return 0 other than -EALREADY, which is a negative error code.

By the way, the function is declared to return uint32_t, which is definitely wrong, because the function may return errors, for example -EBUSY.

Thanks
Lingshan

On 8/13/2026 12:27 AM, Kuehling, Felix wrote:

> I suspect this won't work correctly. If the profiler locks the device
> multiple times, it probably also unlocks it multiple times. But I see
> no reference counting being done, so this may result in a situation
> where user mode locks twice, and unlocks once. Now it's lost the lock
> but it was still expecting to have it from the first lock operation.
>
> I suspect that this is a user mode bug, and KFD is working as expected.
>
> Regards,
>   Felix
>
> On 2026-08-12 03:14, Zhu, Lingshan wrote:
>> AMD General
>>
>> Gentle Ping.
>>
>> Thanks
>> Lingshan
>>
>> -----Original Message-----
>> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
>> Sent: Thursday, August 6, 2026 4:43 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org;
>> Zhu, Lingshan <Lingshan.Zhu@amd.com>
>> Subject: [PATCH] amdkfd: allow profiler process reenter
>>
>> profile_lock_device() currently returns -EALREADY when the current
>> profiler process requests to lock the device again. However any
>> negtive values here are treated as failure, so this causes rejecting
>> a profiler operation even though the caller still owns the device
>> locking.
>>
>> This commit fixes this problem by returning 0 when the current
>> profiler process locking the device again.
>>
>> This commit also changes profile_lock_device() to return an int value
>> other than uint32_t, because it returns negative number when fail.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 309510e23315..9acd5c91e51c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3329,8 +3329,8 @@ static int kfd_ioctl_create_process(struct file
>> *filep, struct kfd_process *p, v
>>          return 0;
>>   }
>>
>> -static inline uint32_t profile_lock_device(struct kfd_process *p,
>> -                                          uint32_t gpu_id, uint32_t op)
>> +static inline int profile_lock_device(struct kfd_process *p,
>> +                                     uint32_t gpu_id, uint32_t op)
>>   {
>>          struct kfd_process_device *pdd;
>>          struct kfd_dev *kfd;
>> @@ -3365,7 +3365,7 @@ static inline uint32_t
>> profile_lock_device(struct kfd_process *p,
>>                          }
>>                          return status;
>>                  } else if (kfd->profiler_process == p) {
>> -                       status = -EALREADY;
>> +                       status = 0;
>>                  } else {
>>                          status = -EBUSY;
>>                  }
>> -- 
>> 2.53.0
>>
--------------FbBlHFvZ0BgSzreCD1dQEl70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>Hello Felix,

Yes I agree the user space may be buggy, and the kernel should be robust.

Even though it is named locking, it is actually a reservation, not recursive locking.
The kfd_process that successfully invokes the ioctl reserves the device as a profiler. 
So when a user space locks the device multiple times, it does not increase any reference counters, and doesn't need to unlock multiple times.

Multiple times lockings from the same kfd_process just keeps the reservation, it still reserves the device successfully,
so IMHO kfd should return 0 other than -EALREADY, which is a negative error code.

By the way, the function is declared to return uint32_t, which is definitely wrong, because the function may return errors, for example -EBUSY.

Thanks
Lingshan</pre>
    <pre class="moz-cite-prefix">On 8/13/2026 12:27 AM, Kuehling, Felix wrote:
</pre>
    <blockquote type="cite" cite="mid:3f62daa5-7c4c-476b-b692-0cb544e3d2a3@amd.com">I suspect
      this won't work correctly. If the profiler locks the device
      multiple times, it probably also unlocks it multiple times. But I
      see no reference counting being done, so this may result in a
      situation where user mode locks twice, and unlocks once. Now it's
      lost the lock but it was still expecting to have it from the first
      lock operation.
      <br>
      <br>
      I suspect that this is a user mode bug, and KFD is working as
      expected.
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      On 2026-08-12 03:14, Zhu, Lingshan wrote:
      <br>
      <blockquote type="cite">AMD General
        <br>
        <br>
        Gentle Ping.
        <br>
        <br>
        Thanks
        <br>
        Lingshan
        <br>
        <br>
        -----Original Message-----
        <br>
        From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
        <br>
        Sent: Thursday, August 6, 2026 4:43 PM
        <br>
        To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
        Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Kuehling,
        Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
        <br>
        Cc: Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Zhu, Lingshan
        <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
        <br>
        Subject: [PATCH] amdkfd: allow profiler process reenter
        <br>
        <br>
        profile_lock_device() currently returns -EALREADY when the
        current profiler process requests to lock the device again.
        However any negtive values here are treated as failure, so this
        causes rejecting a profiler operation even though the caller
        still owns the device locking.
        <br>
        <br>
        This commit fixes this problem by returning 0 when the current
        profiler process locking the device again.
        <br>
        <br>
        This commit also changes profile_lock_device() to return an int
        value other than uint32_t, because it returns negative number
        when fail.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
        <br>
        &nbsp; 1 file changed, 3 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index 309510e23315..9acd5c91e51c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -3329,8 +3329,8 @@ static int kfd_ioctl_create_process(struct
        file *filep, struct kfd_process *p, v
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        <br>
        -static inline uint32_t profile_lock_device(struct kfd_process
        *p,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpu_id,
        uint32_t op)
        <br>
        +static inline int profile_lock_device(struct kfd_process *p,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpu_id, uint32_t
        op)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd;
        <br>
        @@ -3365,7 +3365,7 @@ static inline uint32_t
        profile_lock_device(struct kfd_process *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (kfd-&gt;profiler_process == p) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = -EALREADY;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = -EBUSY;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        --
        <br>
        2.53.0
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------FbBlHFvZ0BgSzreCD1dQEl70--
