Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B24DCFB449
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 16:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1C38825E;
	Mon,  7 Oct 2024 16:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k11NdY1O";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145B78825E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 16:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL6VGzEDpHAZBAzOi+aFj1ZdcCdihJVFLL8glkGIeHi9qhQXx6C0MrB9n89R+Y2/TqdggNgiY+M7oQX3/s/g8JfRSDFePJlfPXE3VFCcx4E+FCwbc+Wd+YJ2VgnRyS24s0ojMw8I7ZCeQDbcWi8vWOPK1bwr1i41h9eGqsggjlzw17AJlI0qywQ3tfjze+2fuSDyDP48sNF2YGDm5dhKCMDsOJlweQrhF76hton+Qkub/L0R13n2EVw84iJIdFXIXROWay9PhFl8a+M2VMhtxwx1J0TEnxJFPby5tj3WUBJm1mn/9JwTjxpy0gyzLJQ7k3OqHK8z7gmsRNvzo033mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivqjUtemSmcl+sCdSNKrNPtUhxm8N39vOeu8J+j7yp4=;
 b=CBPnbbBOP9v9NK5IM540+ElxJ07VB3Ivqo5dDmCg2tz8maeqAsYyFF7aTV/wWSgStpI2pwNzZhF3F/SFTjTVI5sKWKCWSM/JeS+1uq1C1Aw7Rg2nXUbcAjfSUiThuG7cAN8NFMJooBoJoy03TPZyTraoLXJoIuQvLRYOJLkL0wEXJZfZrb+PPIDQuX/38wGCGN/DFBFZHTrgw2oxQ7AMFfub+0IV1y0bVaQM9PxifVrhuLb+6i1YmVOKgmiYIjGuWH7NCvm369nOm0w/oku8u/dmGVXlvNygVywm/l0UekKH3EcRdmYw+djT2vLxdbQGYCYVf+cuBeR/e8Sr7Pws+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivqjUtemSmcl+sCdSNKrNPtUhxm8N39vOeu8J+j7yp4=;
 b=k11NdY1OzNzu2BNj4XPIWBVzhbD74dDrEEA1OZ9QZlUqWjtLXt9WADUhuubzmkDNLs2XlR7ojLS31L0p1tMChn0oPO70aUSr6q13P2kfmFnZ1YUFRiGZu3gOKJ/jexDpuK5nSZrTKMZZkB3kQY844kLM860VG0VUfzAMYeOjouI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.22; Mon, 7 Oct 2024 16:29:11 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 16:29:11 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: move error log from ring write to
 commit
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241003082853.236479-1-sunil.khatri@amd.com>
 <93bae257-6288-4ac2-8b3a-2d2163c5babd@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <86f42836-564a-6408-0492-1efb5612a81a@amd.com>
Date: Mon, 7 Oct 2024 21:59:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <93bae257-6288-4ac2-8b3a-2d2163c5babd@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: 967be5fa-d4c1-4cc4-ba5b-08dce6ed2cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1RFMG5lQVJScnNGOElhRVhEd2MycmR3SGtBM3NQV0R3a2xTbitnaTZXZmY1?=
 =?utf-8?B?eTByKzI3djJMdlVaWmxEQlgrN3U3Wm5RQXRoV05taXVxblBoNmdWUEZoV3Fu?=
 =?utf-8?B?ZEhhRkhzV2FGYVJpWmloVkJkdEpLUmF5VlBzaHBqbUcrNUY4RFVGdkJkZTBj?=
 =?utf-8?B?SjBDdlViMCtJYzlGMmIyYXlYZ09hS0djYVpXMGtVN3prdVBjUkVEbG5sTFk3?=
 =?utf-8?B?QTJkOXFVZmtOaHo4NVEvdHVJeUZwc3BhREppMmtoNHI2dFlRVjV2R3hRemZP?=
 =?utf-8?B?UHJ4aGQ2VWFYVjFJRXMvWUttbkNRY3RmbjN1bU5CZ3hUSmpoa1dZOWxTVlFC?=
 =?utf-8?B?WEM3L0w5NENjSWRwcXREbUpsaFFzY21GSFZZZ1NIM2xubW5XNktrWE1vOFoy?=
 =?utf-8?B?c0pvajZ6VDEvY0ZhMXFXSC93TUVEcGlZZEtBOVRJODk1K1VsdUpWZExlRzlT?=
 =?utf-8?B?V3dzYkRaM29kT2Zya1pJUVl6U3ZVNkJaR3c1VWhyMHJlS1ZUVWpYWmlZYmI0?=
 =?utf-8?B?aEwwUVJZYXZtQTVMMmFZZTRGVEpJYUVOL0VBTFBwaW9IUkNTWEduL2FnbjRO?=
 =?utf-8?B?eU8ySkE3ODhjWWdJazh0Z1ZIZE05VGRDSCt6dlF5YldHL2xrQVJFTVpZS1lX?=
 =?utf-8?B?MHlOdCt1aWVqdURWc1c5bzNPSFduNmVvZHZzYTFzcEhWdHFVYXRPV1BRelJy?=
 =?utf-8?B?bStELzI2WUt5eFdZL2EzVWROVkJpY3JVSVpULzVTTjk0VjJUTEhQVmdTOVUw?=
 =?utf-8?B?WkYwQ3ordzN4T1JFaGZYMFhuaFVkZ05ORmxoZnFuam9tR2xxWkoxTEZ4L3VN?=
 =?utf-8?B?R0NXM0ZtR2pNZ1NUOWZpVTRCSjhMRW4zc1FkNmJHeFNjNm1pVklJN3dpYW1T?=
 =?utf-8?B?WlRqRlpoblZSbm5sd0hPM21kMlJ5REVUVWoyRlJPQzdQZXpIa1E4MWkvZ1pU?=
 =?utf-8?B?eFRoekxudU95QzdUL2Q1eEtIbW8yamdBMnhONmFKNFNkdXFlQWNzRXlTcFpY?=
 =?utf-8?B?bXBYWHcwaEJGeTBaODZDSHdYOTd6YkZYNEJrb2h3QXFrNWE5UDF5cUwxQTFK?=
 =?utf-8?B?aXBoVmR2VlB2TVNuNXB2SDNVQWtkdVZrdWdrWlBBMUNBcnNOTFJ3L2JDZFAr?=
 =?utf-8?B?RDJXQk1iS3R6c1Q4N2xQSmdueEVPNG85SHlRNGkrR3U0ZVBhdFRiYTFHK0N0?=
 =?utf-8?B?ZTdhSkpzdmg5YnNLdjFHREw1amxSLy8zcmdIc2dlQlkwWGhXajJGV0cxUXpi?=
 =?utf-8?B?M29VZ3VNZW1UMnR6YkNmREFRZEswSFJpbG0yV0lMZXUxNFdxb28zeWNaV1J0?=
 =?utf-8?B?cG5lbmJKRXU0OU5xdTdoMGo5dkhoTjhSUC92S1dqMjdHaURDbkxUV0Q4OFZr?=
 =?utf-8?B?bnlCWmNyeGdMOGVScWhYRTV2Nmdzd3FrVjNkTjU1NkNud2cxR2VabGN4dDBM?=
 =?utf-8?B?VGxRTXZPU3crTGdMbjZWa0xlMTFKL0pFWnMxZk83VnJxVm5FbHJVS2ZmTWtZ?=
 =?utf-8?B?bWpCdUUrTUwzVEppNEhONTN6MHgvUGJMdyt1cVczRzBpVU4wTk5xM1pGa0VP?=
 =?utf-8?B?T3lPU1oyM2pCN2VSL2JlTEhPSnBicXpGclo3aHpTODFlbTBuajJMRERheWZv?=
 =?utf-8?B?bnJxSnoza0JvY1lYc3lBOTlqWnF3V1VJTkx0QkZaajFqRFZzTW0xNDNoVXl3?=
 =?utf-8?B?TVE0K2ptNkladmExUmkwbEZYVXQ4aTN4T3I1aFNoOFFQeXJBT1VVTFBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnVudyt2L1Jjd3RSSFpDTmpaL1Q3dTZ2MGFjWjJ4ZzBza2lzWG02NmlQSVF3?=
 =?utf-8?B?UmsrMmFmZHJrUDBHeHorWWdwUFpONmRWcExFV1diV2R5WG9jWGgyNkY1WlRi?=
 =?utf-8?B?ZGNET0Yvd1hqcTczUGs2VWNycGR5a1F3b2VFNWYyR0ZhemFRMHlvY0IrU2p2?=
 =?utf-8?B?R0xGM0JaSDhQTm5KVm9jOFFEZ0pHREpNakdhVzU1RjFVSk12MldWZyswdTl3?=
 =?utf-8?B?eGF3aUh1ZEFwdzJ2Y3QrMnRpVnl5ek9BWnpYL0VHbkJuWkxWWlhqVm5aTUFF?=
 =?utf-8?B?Tlh6Z211UFRFWXhQVm1yWVFHWWhCeGczaCtSSTBXWmo1Ky9WZDhEaC9zd3p0?=
 =?utf-8?B?SnFwakZIc0xqSDI2b2JwdWxqSkswMGVqME9WUUUrODQySlJBU0FaQ0VieWJP?=
 =?utf-8?B?QkpLblZVdmpxU0ZRbEM4b1l0ZGlJNm4zVlc3RE9hbEwzM01YbmptR3JUTDU1?=
 =?utf-8?B?VjNORjh0ZnQ5TkQ5REtFUHRCN0VtNjl2T1BBcUR2TzAwSWtVaXJ5YklsWjEv?=
 =?utf-8?B?MGVnK1B2LzNJQVRjZkZLOWxFVmRmZUFUc1NyU1VEWXB0a01ESUFhbnFWa3F0?=
 =?utf-8?B?S0JiVlo1TmFoakVDY0kvQ1pXbXArbFJ6M3VLSWFiU3RscUdqbEVORWdZUFBV?=
 =?utf-8?B?enFZTVRKejYyMXNKNFZGQ2ZCUGVSeDV2bGpBMDZEdzcwd0NWNGl5TlBmVTd5?=
 =?utf-8?B?L2Rhais2Y3kyRzhaQzNoamRPdm1OaEl2dW9qM0JhME55WlZYamphL3Bkc09Y?=
 =?utf-8?B?b3duR0k1VUNsc2Jac1QzRXhPNXNHT2ZLTmRRelc0ODZTNXgvQVMrRnQ5bk8w?=
 =?utf-8?B?WjhHZHdzOU9oZlMvLzBubjR1eVlMUlRGalU4TmxxQ3NIZGc0VmsyRzN5cDlC?=
 =?utf-8?B?MWhpR28wU25uV1FhYjR2aytvOFBrM2piNjZxOXFnR0F1akNlWHo2WUtnMm50?=
 =?utf-8?B?RTlBdXd0ZnZ1QWZJN1ErdzdlMjZrQW1rTlYwTWpBdnA1SmFuS1RpVlErQTV2?=
 =?utf-8?B?cFhJMzZwRHhKZlVXY0t0TnBISVl6MGxIYmdHYkh1UVhGMjIvQ3h3dTRJUmNt?=
 =?utf-8?B?OXJqNDlIeHB4MENya04xbm5wRVdYdWoxWWZtWG8rWDVpaGhyaHJtbUQ5VzhT?=
 =?utf-8?B?RmxaOVlMOEFsalZsT1FzT1Z0ODJYUGR2Y09VaWZiWXFOcy9mdDM3S3Nqd2JY?=
 =?utf-8?B?TStUUkpyVGZXZzkzcW9HMlZ2cDJaZERvcldSMlpGY2J2N3dpMGVVdnlDQncr?=
 =?utf-8?B?c2tIbi90U0pFMzdYVEJqNVk4eVFHM255S3hqS2F5UGpxVlNEZDZDQldSYThE?=
 =?utf-8?B?SXBNaE9XUVJtYndWWXAxTnBNMzcrNURBbEFJb25JOVNkeHE3S3krRUNhVXRm?=
 =?utf-8?B?SzQyODlrNnlzWVFuR2hUUlBkZldqeDVLN2hIeG4xUGl1V0pPcVNXand6NEdB?=
 =?utf-8?B?bStUd1dERkF2YkxtUlMxMGQwWVR6MWxuN3d5SmNVNUMvK0ZFMU9lSnkzTlkw?=
 =?utf-8?B?R0NKM1pTMEdtRGdqai9hS0tEYVdUUXZZZE9MYlMzQVllSE1jVUtDZDNaKzdD?=
 =?utf-8?B?M2EwTzFrYm9xTHo2OWZlNU45R0RoZG1qTGc4UXQxMVJTaHdVOXowQ2lIL3Fp?=
 =?utf-8?B?U25PSFBvdG1iNXBvNnlKMW8rU3gzVVA2N1VNYVNiajAxWHQ1bmZ5cERLR3E4?=
 =?utf-8?B?WWR3eElaSVB0SGxWKzNRc3dPNlI2bmQxVzRjMUMwUGFpM2pMM1NwdTdqNjhS?=
 =?utf-8?B?dW9PNTdqdU8wT1NhMkhkdEVvZHh0d2NBY09WQ3lFR2NZcFdvd1NaQkpKNHdZ?=
 =?utf-8?B?ZzhNcWRiOHV4bjh1Um96Qjc5dy9FK3I0UnNIQWYycHQ0QUg4WlBua3FnNnFv?=
 =?utf-8?B?cm04azNkVTFZRmwxdVQvY2RWSThlMk1kK25XbzFOQzloRytWVEh6SmF6Qzlh?=
 =?utf-8?B?S3VYUXlUNzNlU2NRS2tSRHV3eCtUMi9QejZkRHArb2p4QlU4UURzd003UVFE?=
 =?utf-8?B?b2g1YjVnc2RieGFDdEIzUU9vRkpQcDBuQmdib0FPNnhKUDRnbjZJa2JGTGRO?=
 =?utf-8?B?dkZvOUhIWFNlWHA1RmZmc1REL2hDcGRQWEMyaVAyTUdMMTN1amJ6UWcxQ3Mv?=
 =?utf-8?Q?8Ad9yRJ70kVNvNAij87e/eipj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967be5fa-d4c1-4cc4-ba5b-08dce6ed2cda
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:29:11.7118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzIQT5Zf9pCD/LTV2NpXixjH/4BieU1TWqWgcTo1KUKGnmGVbGuM0pNCUOoCDIt4cIgfWbH/xgxANg1V4/TSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
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


On 10/7/2024 7:18 PM, Christian König wrote:
> Am 03.10.24 um 10:28 schrieb Sunil Khatri:
>> Move the error message from ring write as an optimization
>> to avoid printing that message on every write instead
>> print once during commit if it exceeds write the allocated
>> size i.e ring->count_dw.
>>
>> Also we do not want to log the error message in between a
>> ring write and complete the write as its mostly not harmful
>> as it will overwrite stale data only as GPU read from ring
>> is faster than CPU write to ring.
>>
>> This reduces the size of amdgpu.ko module by around
>> 600 Kb as write is very often used function and hence
>> the print.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 --
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 690976665cf6..05b3480ecec7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -141,6 +141,9 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>>   {
>>       uint32_t count;
>>   +    if (ring->count_dw <= 0)
>> +        DRM_ERROR("amdgpu: writing more dwords to the ring than 
>> expected!\n");
>> +
>
> Oh, I missed this on the first review a count_dw of 0 is actually ok 
> since that means we have written exactly as much dw as estimated.
Sure i will replace it with below code

  if (ring->count_dw < 0)

Regards
Sunil khatri

>
> Regards,
> Christian.
>
>>       /* We pad to match fetch size */
>>       count = ring->funcs->align_mask + 1 -
>>           (ring->wptr & ring->funcs->align_mask);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index f93f51002201..af8824e8da49 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -377,8 +377,6 @@ static inline void amdgpu_ring_clear_ring(struct 
>> amdgpu_ring *ring)
>>     static inline void amdgpu_ring_write(struct amdgpu_ring *ring, 
>> uint32_t v)
>>   {
>> -    if (ring->count_dw <= 0)
>> -        DRM_ERROR("amdgpu: writing more dwords to the ring than 
>> expected!\n");
>>       ring->ring[ring->wptr++ & ring->buf_mask] = v;
>>       ring->wptr &= ring->ptr_mask;
>>       ring->count_dw--;
>
