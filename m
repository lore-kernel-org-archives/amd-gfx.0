Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4BFC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 145E3112536;
	Thu,  2 May 2024 16:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XqRowJ/X";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAF7112536
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coy+y3ZcN1sqVHWNDkKsquJvZXItQhh2/6PolN5xaFUK5j2VETYoIKB5bnwhs53N4Cj2gFVvzBryYm4ocowUo6/wnjDR4AepSVKP3WOq+pDXnbTVEDgbIzBkUgXvSdeDvIu+r+vASX2IppYzzXOdtRxTp/qqQ9QOxTt5y4tg/ln+FO59YB/S+oOIP9SqU6hyD5vPlqP4UqFnCOYAbgDvFWYUL64oO67fYlRiLVnV7a8VbmsIcb/OSLoVq5lhnLN47a2BNe3jQq4c0zT2UseJDqpJUo3a0QxfRjJPDo1p1YIo0eTNYGT0E2CvV3UEF4Hm8ERnw/M4aJ9bOj5DFZX/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqTQ9u188X54pob74u6b7M+I0ReEfn1uyGwzO7HOhHU=;
 b=T4T7f8U8Ez9WDhSXrz3e+csoQFFbh6542dgGAcSc+2Yv0y+2I7L+iFd1Yw6m+2qXd+t2lDW2/k2lf53j8x26tW2Ymq3BAaZhUaJ6THIMHB2eTHLteK4GktIOop1s7YLwJeXmsv8its+qwqHECi2CLE1eebRqn+7rHaPjXjpNjc+uqxs2BJuyWrGs0qOcMGoRV9EcjK8nrSWpypn9tdAtPl4HWKZwb5M5HHQI3O9Otozfle0rrbnJX1/RKaDGSmJYHFW1HrDa0zMx0C3S6U9WlfgZRdc9HTV1sPgGY5mozd5Y235z+e8zX6mgNsqC9youaS31M9z+nK109Et1aj22IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqTQ9u188X54pob74u6b7M+I0ReEfn1uyGwzO7HOhHU=;
 b=XqRowJ/XkJlKFwgixxNwZXg9oB9zWJ7CBCYqzKkUKuajoqYmSBrCjEj5Ulh36HtlbDhQIWdYepm2VKsB9SZLYaR8wOkvfbQjcFdYMXowukBXEbSQnXoIE0N5o+TISZoR7SJiyzOSx2UKARJuwHgl6TV1Pw/D/f8vAqKGlA8i4Qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 16:19:14 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 16:19:14 +0000
Message-ID: <11b95b0b-e39a-48f3-f773-71fd0246394e@amd.com>
Date: Thu, 2 May 2024 18:19:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 14/14] drm/amdgpu: add kernel config for gfx-userqueue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-15-shashank.sharma@amd.com>
 <9fec4ce7-6814-4abd-a14f-5f4b9034f204@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <9fec4ce7-6814-4abd-a14f-5f4b9034f204@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0088.eurprd04.prod.outlook.com
 (2603:10a6:803:64::23) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: e58d2026-e72e-4931-cca0-08dc6ac39b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mi80R1NMalRXNlhXR2RPem5lT1c5RXpIVG1QZ3kvNGUwZnhBQ25TdWM5S0hy?=
 =?utf-8?B?dzIxSWpkK2ZudkdmdTkvcHZZa1o1TzZtMlBzLzBuZ21ySHJKcDBBb09JMWR6?=
 =?utf-8?B?THQ3NlcwcVVlN2hMY1Rpb1dOeDJWM3NucXZ5b3hjVG5YOXlwZTd2c2xuK053?=
 =?utf-8?B?T2ZRaTYrckoxZlNUM2VkM01UbWg4dU1oVUh1R0p5RzlyR0hBZDk3WFd1V1lP?=
 =?utf-8?B?NUJCay9hSGpkNEh4SlNBbkk1eDhoNGVCL1k5bnBNWVVrL1d6TWVyb3FLQldM?=
 =?utf-8?B?UE9PamxZMXJjcHpXT2FPNFhqcGh6V0l3M3NTSUtkMFlFWXljRm1JMTBaUVVL?=
 =?utf-8?B?clduOEppMzI2YXloL3ZXS1FjcWEyTUN1WVlqRlVILzRXeTI0QnB0TG9BNlpw?=
 =?utf-8?B?RkNqdkpINjN4bVEwNDdGM2I3cGl2V2RJVU42MGFMK1FLUDZkMFdOYVJEQnpj?=
 =?utf-8?B?K1o0SEMwNnhCMkhhNExCRjVWVi9sb0ZhTlRGVUROMldOUklISUJkOGV4SUdQ?=
 =?utf-8?B?dTBISVhJK0lnN2xEdDg2Wnk2eDYvWG1sMTIyVzg0a2QwN1NjRk9SVGM0RENi?=
 =?utf-8?B?TjU0Ky9lS3Y2VDVJa2Nza0NpbDlHVHVEVi9kSExienBENW85REE0d3dQM1Jt?=
 =?utf-8?B?bkovbEc3LzhKaFJYVmRyTllYcnBuWitDZTFUTjcrQmw2K0EvcnNjRlRPaEts?=
 =?utf-8?B?OUxKeFJ5T2lBNXVCL1BmOHpMV1ZpZkkwNXVTb05XbU4yVEwwTG9RaEptRGVv?=
 =?utf-8?B?QW5DL3VRMFh4VzJ3M3dpd0NFb0UvbnNHMTM0d1RYOHdBdGxmOUNLV2NxU0VL?=
 =?utf-8?B?WElzTTBIZ0Y2Qk14RlVVWE9CQUxSYXpIVlVRbHNpU2ovQjFRREdXYTJlbGtJ?=
 =?utf-8?B?cTU2MkF0ckZkenRkWXlqSEhJUUhCa1pKN2F2dndlTnUvalgxK3JLeDRibEtp?=
 =?utf-8?B?NEhqUkdQdWJhcjlmRmk3RmRsUk1jL3M5RGYwSEFlYjlYR1lUZzZMczliSVp4?=
 =?utf-8?B?bStsdVpCZVNZT0ZDWjcvZ0Q3OXFoZFIwMXJqMDlsQ05jaFo3M1FVYWhRZmhm?=
 =?utf-8?B?Z2U0S0dIMUIyYzFicUdBTlRGZHBPZWVKM29OR2tDekx0Rm1COVpXQTFuMHFL?=
 =?utf-8?B?L0RvL1NvSHo1Tnd6dlZMbmxRWS93N0NtbGdpY256WGtwUXg2SXc1cDVFN0x0?=
 =?utf-8?B?WXdkdUxOT0w4NjlzUzJBVWd2WVhkTGhLdTd3dDZhcVRnSjNqL2VzeFBvYXYz?=
 =?utf-8?B?cWpzSnV0dHlXZkpaZUprOU5FaUZhekpKaWwwRFhhMkZKODVXV1RRQ2dDUjk0?=
 =?utf-8?B?ZEFOajYzL2poWVZNMUFFVXhHeUdoTEpJaG1WcmcxT25pNU5iNEFrWG9UdFZ4?=
 =?utf-8?B?Q2ZXMGtPb1g5RVhwdGVWLzlXNzlvMFEyeHBCRTJMd0pBckRwSmFkdnBrZ1BQ?=
 =?utf-8?B?cGFTQXNySWtycjBkd09RWUdSTStwaUxneDFiZTRSTC9TRDB0ZlZIWXZJVVND?=
 =?utf-8?B?S09zRmZwMVRJam9YT0MwM1VlOE9iU2g0VFZIR3RLVTUrN3doZUdZU3hkeVBz?=
 =?utf-8?B?SlZNN3RWbHBRVmIyOWZ6alUwTy80UDVrZlp2VEdLR3F3TGdhT3hlOHRxZ0gx?=
 =?utf-8?B?d0FjVW9RQS9oR3lyQjVaSDhsODhZTTNRWmt2em9sUGZiNnduVjlTMWdaLzQv?=
 =?utf-8?B?QmJoMUpONVhBNWw4eThlaDJiQ09hZzhCRVVNa2k3Z3JZL3gySXlKN01BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEdrVXRCbkowQkZ2NHlLRDFrb0pGaHZuL295YVdaYXFSb0RqUnRTWVhhY08r?=
 =?utf-8?B?dktDVzFTemlDendZZVdwR0dINEhPVmFlM3ZzcDVHbTE4Qy9RbHU5MzBZbS9w?=
 =?utf-8?B?OHdPM2xCR1VwRk44ZDFYZkh2Q2xxQnVCNHJxbUlYbnBsTEk0Mlk5Nmtlalpl?=
 =?utf-8?B?Rzk4bmVPNVduaFJadDg1cUNreWd2VUtlbFF0Y3lPM0RIUnRWV1ZoWUsyYXlO?=
 =?utf-8?B?ZS9KL1U5eWQyMXBmN2tVREl1bmFIN3NPSjFPMGloTTFHMHAvbUJHU3VIKzFs?=
 =?utf-8?B?ME9pYXRIWTZsVVhPUkFlTUp6UEphSFNUT0dOZ2w1TkRsazlXRmpBT05LbTdZ?=
 =?utf-8?B?Z2JBcWVJcmZkK2Z6cmZUMm5idHVrZ0NkTFJzdEZPUXFQcjZ3dDNwQVltdWt4?=
 =?utf-8?B?Y0VKRVVnWmFmYUpDUzVCQjNiaHZ5blpqeHg1MkNNVXNSaUV5NG1tMzdaVFQ5?=
 =?utf-8?B?QUVqeXdBZ0xvL3FJNXZ6dmx0MWVTaUFrbGcvV2V4M01FTm5aQUxDVGxQUnhJ?=
 =?utf-8?B?Zjl5RlQ5K3p1MkFvckhTVzJoVzdBck5hazZneDBpbkJmcWNZaG5JOFA3cmQ5?=
 =?utf-8?B?ZWwvWWRVdVViQWFPN3o2a01GaGJYeHdWc3h1bm90TmhZZXM3NVJJbEtWa3dU?=
 =?utf-8?B?K3RpcmY4YnNISmgvWHY2b0V2aDkxZWJEVkVsK2QvOE5PVVF3djV6dkRwbjdS?=
 =?utf-8?B?VkEvUExMZUQyMUZKbk1PVEdORVJmRlRWY3EwL3c0bDRFKzZYUGpUays5a3d5?=
 =?utf-8?B?am1WNHl5RzR5Smc5b3c3d3NSKzZNRm5haDZ1bXlGbGVkRlFjNHZzcFA2WkdX?=
 =?utf-8?B?eHJpOFJVVVVTN1VxUHRkT0RLNFV4SW92aFFXZ2hmZDR4ZnpOMjVJRXB1cXAy?=
 =?utf-8?B?OTdjM3BEblpxN3BLN0QzVmI1VU5DR3Y0YU9zZ3ZiSWtHVHBmSXptNXF5U1Uy?=
 =?utf-8?B?dE55cS9mREFvaDZFZ1ZsOC9hWk1aWGFkUUEvZU5CWHI3YzNYemdIZGxjWW5a?=
 =?utf-8?B?TTFUUEN5ajgyaHVrSnNzUWh3NnV6a2FHblVMTlhpbWNKSXVqc3M3cVdJaVJB?=
 =?utf-8?B?YTQybEFNWU1jZHRsZWswWFBxMDcvWGU3TmRtYnNVblJMNUlrVzU0SXZzK2c2?=
 =?utf-8?B?bHpjUjZpQ0FEMlhwd1YwR0M2WWxVM3BSUzMyTmdOMGI4aXlZRXhqYzViSlNh?=
 =?utf-8?B?blNxMEU4K0Y0bFRSd1pIeEhGUkFmaWZScExNZlBHeVNlR29mWkhjNVhPN01o?=
 =?utf-8?B?NGtBVnZSYWN2cE9abXI1VnBEcjh0dUhkMGNvUklFRHZOTjkvK0lpanBrRzA4?=
 =?utf-8?B?V2NpdXdQTlRWVTFNY0d4UzRidUwxYnhtdm5CRzFlekdFNWVsU3RkR3QwSm5L?=
 =?utf-8?B?TkUyYi91LzZOQWNVUDNtaDBZQWZoWjdvUWZVRUxKdTk4bHJPaGtBRDV2ejlh?=
 =?utf-8?B?VWRMbkxUbEM2MUcvcXpML3E2a0ZEN2VPbDB3dGlQMkwrT0RUbmt1czhmalI3?=
 =?utf-8?B?VG91ZE9TVThhSjBNQVFmZTZPVHJ6bzN4S0dNWkhYajBSeVhjdUF0Z2oxMC83?=
 =?utf-8?B?Y1ZKVkRQREdsWXdVTkVaenlZUnRyaHBEZlNRYXF1MjRQaXNXdW5sOXVTV3F6?=
 =?utf-8?B?a0s2cUFsQzM0cHNhUnV0ak02YVNaOGIydzdlOWJIY1BkNzV1Um44K3M3MVAv?=
 =?utf-8?B?LzVRdkNDL0E3SUZ0ZksveDgrVFFKdWFacm5UV3hQTEpiMHBOL2tzK215NmRQ?=
 =?utf-8?B?T1dpb3FETllCeHFtYklURk9PMStrVkNTK3pzU3piTWF0NFJvUnJjcE9EaTE2?=
 =?utf-8?B?L3h3aVJTSUdTT25IczFQRXpqQlVVcGl5SkRGZDV1NWtzd3dOMXNBUU5KNzFK?=
 =?utf-8?B?NFdNd2VlRlF4ZTVOYUpybUFLMnd0MHlYdTFFUUFyUHUya1JtV2VUR2dWNGJ6?=
 =?utf-8?B?VWU3WG5ndmRMRlRsRjgvWDVHbktMTE45MFdYNnNQOFVFNGxWc0NGVTR6a1dG?=
 =?utf-8?B?dm5ZQ3NvL2tpa01MQ2xNelNWMUltY01DRVZoZ2g4Tnd1c2ZCdmx3ak5BM016?=
 =?utf-8?B?SGVZc1NJdDVZdmFJYXZvRmdpSERNb0tVUHpSdTRldGk5TXVlRVF5eEIzQlFy?=
 =?utf-8?Q?8sv82UZLlvZVCVkD0i9XtjqzK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58d2026-e72e-4931-cca0-08dc6ac39b66
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:19:14.1075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1AXzeGa1Bsoq52ZpqgxS5aaqRCZQr+UNP1Ii7gai4LrqV1+hoj5TjcMm589KSdWd5N0/N6ZN5uBMpTzUmXy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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


On 02/05/2024 17:22, Christian König wrote:
>
>
> Am 26.04.24 um 15:48 schrieb Shashank Sharma:
>> This patch:
>> - adds a kernel config option "CONFIG_DRM_AMD_USERQ_GFX"
>> - moves the usequeue initialization code for all IPs under
>>    this flag
>>
>> so that the userqueue works only when the config is enabled.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Kconfig     | 8 ++++++++
>>   drivers/gpu/drm/amd/amdgpu/Makefile    | 8 ++++++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
>>   4 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig 
>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> index 22d88f8ef527..bba963527d22 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> @@ -80,6 +80,14 @@ config DRM_AMDGPU_WERROR
>>         Add -Werror to the build flags for amdgpu.ko.
>>         Only enable this if you are warning code for amdgpu.ko.
>>   +config DRM_AMDGPU_USERQ_GFX
>> +    bool "Enable Navi 3x gfx usermode queues"
>> +    depends on DRM_AMDGPU
>> +    default n
>> +    help
>> +      Choose this option to enable usermode queue support for GFX
>> +          workload submission. This feature is supported on Navi 3X 
>> only.
>
> When this is for Navi 3x only I would name that 
> DRM_AMDGPU_NAVI3X_USERQ instead.
>
Noted,
> And since we enable/disable GFX, Compute and SDMA I would drop "gfx" 
> from the comment and description.
>
Noted, I just did not want users to get confused with KFD queues, hence 
added GFX.

I will update the patch with both the changes.

- Shashank

> Apart from that the approach looks good to me.
>
> Christian.
>
>> +
>>   source "drivers/gpu/drm/amd/acp/Kconfig"
>>   source "drivers/gpu/drm/amd/display/Kconfig"
>>   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index a640bfa468ad..0b17fc1740a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -184,8 +184,12 @@ amdgpu-y += \
>>   amdgpu-y += \
>>       amdgpu_mes.o \
>>       mes_v10_1.o \
>> -    mes_v11_0.o \
>> -    mes_v11_0_userqueue.o
>> +    mes_v11_0.o
>> +
>> +# add GFX userqueue support
>> +ifneq ($(CONFIG_DRM_AMD_USERQ_GFX),)
>> +amdgpu-y += mes_v11_0_userqueue.o
>> +endif
>>     # add UVD block
>>   amdgpu-y += \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 27b86f7fe949..8591aed9f9ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1349,8 +1349,10 @@ static int gfx_v11_0_sw_init(void *handle)
>>           adev->gfx.mec.num_mec = 2;
>>           adev->gfx.mec.num_pipe_per_mec = 4;
>>           adev->gfx.mec.num_queue_per_pipe = 4;
>> +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>>           adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = 
>> &userq_mes_v11_0_funcs;
>> +#endif
>>           break;
>>       case IP_VERSION(11, 0, 1):
>>       case IP_VERSION(11, 0, 4):
>> @@ -1362,8 +1364,10 @@ static int gfx_v11_0_sw_init(void *handle)
>>           adev->gfx.mec.num_mec = 1;
>>           adev->gfx.mec.num_pipe_per_mec = 4;
>>           adev->gfx.mec.num_queue_per_pipe = 4;
>> +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>>           adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = 
>> &userq_mes_v11_0_funcs;
>> +#endif
>>           break;
>>       default:
>>           adev->gfx.me.num_me = 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index 90354a70c807..084059c95db6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -1267,7 +1267,10 @@ static int sdma_v6_0_sw_init(void *handle)
>>           return -EINVAL;
>>       }
>>   +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>>       adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
>> +#endif
>> +
>>       return r;
>>   }
>
