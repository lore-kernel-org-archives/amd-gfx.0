Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B242C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 18:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8577910EB49;
	Wed,  1 May 2024 18:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A7yzqEov";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8661123ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 18:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiljUycjLSHdJNHN+3inEU4z0Vvj4Ty3/0ucmQKManVymGGTYJpJ6zJ5yp17yt6f4ecFDs3pclKkJIRSc7t2nN9aoCHVdi0EiQCzNa5rz54Ap5iJRCYSkn7VGSGcTlcbdV58lLPB8rsV3AHnQLXX6EmL/ZJlaarMrl5IPfuJnarsXrUh48YL+6Et85aXmU0PHP3QjOVkt24Uq7NKPDGfP2bUT7003acU0ULkyHzNuNIdNXnTwGa2X2lwjdMdcXbpFEdB6zAVjs874XbUFXRC7kYIC5sfCntX3BRazFzG/GbtxnmR6zrcQF7tBzRY+//5l++aaLcmJfpOIQ+Gos9f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYCjfmVO6QtyYjFRhXJzqesEhSl4gbF/Z1pAsShyQ+g=;
 b=NjLbGtF4gBrAnSz37qIMULZmMWDJqEMEXzDvJpeH0pKM5nnGZbI/Ae2q6Bmo6xZ8H4finNu2k93IdbSmYgaOqKVGsTHbok7Npg6Br0wHZUAQ5fHY8O0w663fXHEXLwVoZG8SYUxIxhq22DKTJhepRWedsgCjRD2ds09Zg8saO8Q4PjBV3rnyVe0XeVNCAexMl/4M0jRJJTqxY8EPl21cdjV9MIWu6e5hzDRNM8izDATlo2bVVURapdwFbdcuMB/Vh1p6GKifR2f7Z6ogyD6MxWdRvC/jyI7Saw7+/IxF1Tfwq8x+GjFAJg/odXgKM/pvHqW8/1xS8EPAJQ86D4aiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYCjfmVO6QtyYjFRhXJzqesEhSl4gbF/Z1pAsShyQ+g=;
 b=A7yzqEovMm5Lvy+W/99xTb0Xlc0sYM5EuyIOY0NMEYlEcZK/liMq/L7aL8eizUWmmFh+5scihFJSqFLSmwWDPwsFdlVdD040APH6mf9Lu39cB5NO2332NkpkRJzPP/4BouB/s3NUwmOUgIWVk6SV6UtjE5T5m9ZO3i4lJC3jYB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 18:59:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 18:59:37 +0000
Message-ID: <78000261-387d-4794-ace1-c72865d95475@amd.com>
Date: Wed, 1 May 2024 14:59:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
From: Felix Kuehling <felix.kuehling@amd.com>
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240430232901.2878169-1-Ramesh.Errabolu@amd.com>
 <5ec8572d-1eb3-4475-b953-2f70f5df9493@amd.com>
Content-Language: en-US
In-Reply-To: <5ec8572d-1eb3-4475-b953-2f70f5df9493@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1956dbfb-7198-4d62-583a-08dc6a10d919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE51Q1RWSjF0U1B2aE1mdVJJdVpXZm96RERvcGVnRkN3YncxWEN4WmtIRFhM?=
 =?utf-8?B?Q3prRndTV0VMNXZkKzZIbVI1T1ZkejhpZFU0VXlYK0RlZE9GNWZTcWl0STFv?=
 =?utf-8?B?OHJsa2xpL1JQdjkvY09xNFlaUkJTMVdZV1lBcTNCOTZsdDhOaFVCRFdHamNP?=
 =?utf-8?B?b09KMU9DMlQ3SXR6ZmgyZnlwdFVHSzZnbjZNWEdMM3gzOUZ3Vk50WXpmMmhz?=
 =?utf-8?B?alhFa0VFVCsrdjVxU053RnJnUitTdzhLanhPdVpHamswWm5MVk1QVXNja0c0?=
 =?utf-8?B?Y01pSEEwUnVHdUJBUzh4WHJXK29PbXNCcDZpM3Rjb2lFaFhkazEvdFMvTzNT?=
 =?utf-8?B?d3JNeVZHSGRCSGpGTUd6VGQwNjFsRnI4dExMRlFoUDBKemdVbnc5eVV1S1M5?=
 =?utf-8?B?UWM5U1BrdUE4eUpDYmt6dStoKzZDdUc0aDF6VUpzWVN6OStZOHJkUEVldERP?=
 =?utf-8?B?Ulptc1BqVkd1blQ4eHZpdFZVSy80Mm80Ulk0R2Zxd3B0d2ZtSFJka0REekMv?=
 =?utf-8?B?ZHZ0V3FRUm9pSGl6OWl5dlhGV0JzdjlhaExxS0JLWTNldlRVdEU0TEZGemJq?=
 =?utf-8?B?VTEraE1sTFp2eEFqU09zMmtMSXJUNjE5QUdTQmdGQmUyUmRjRDN0U1AyTDVo?=
 =?utf-8?B?STQyT1NIWEEwQ2hiUEdxNjlBZ1ErMnQvelFjSzZ3c21GQ25BOGhxM2JMVWdS?=
 =?utf-8?B?V2dieEk3TlF1RFVPRXJkMHFXMmxGMTVDeWJuSFdmK0UwSVVta213TE5LbDRh?=
 =?utf-8?B?anJzeHo5N01qOG9QNlpXTGhCOWlxT1N3U3hXdHR3NE1MTVdzWE9PVlVwTnhh?=
 =?utf-8?B?N2tFTURHYi9ubXhOYnJra0RoNWFWR0pRMG45UjZ1THRQUWsrRTBKRXhraGN4?=
 =?utf-8?B?c1QrbmI1MXI0TlJSQ093Mk1HYnBiQzR5MXlVOHpka3JObEFHQnlWUE9aNVZ0?=
 =?utf-8?B?TWlKMGduMGN5R0x6RVBIM2NZdDdWc2ltc3YydVAyS29ZT3d4YTIwTjJTTjdW?=
 =?utf-8?B?MXNvVmhIMDRZY2Z4R1MydEdCU2FnOHllOHBsWExRcW0wUm9JNU5GVERTMElJ?=
 =?utf-8?B?eFBaVXZZanJZUDBiUWVHZElON21nOVhvRTA1VmZLSTRoUVNNR2pOa2tpbWxS?=
 =?utf-8?B?ZDkraVRudTIrVElhYUpQZCs4RlY5WHZIRUtLYTF0SHloWGZHQ1BQRUh4M2ww?=
 =?utf-8?B?Wk83ckNuaFZFaXdybkxHSWJmSnRGZHJaenJJNkI4OHVTRWhvK2FkUG1NS3Qx?=
 =?utf-8?B?VXJEQWFyL091YVZJNEtmTTdQNlhhdW5tcXhUOFV4Uit1WmxHTkRnWjROcThF?=
 =?utf-8?B?Nml1SUJKS2gxUk5pTWhUUFpPbVhPM0FRN1hrZTFJaE1FZHBITFBDT1RHM29H?=
 =?utf-8?B?WlhMR0hNVWY4UVdQQ3BQV1c0V21UdEpJOUNaV2dSbDBZNkYralh6dkZraURJ?=
 =?utf-8?B?RHdGR2ZNMktDMjVaUTVOOHY4alV3ZFUyRkpnUGxnckE0V0Z5QWZoWUZXem1V?=
 =?utf-8?B?dHJaT1dTQWg3a2pKeHU1b0lYSC90cUJRV3dDNG5hanJWTlZZTXhITHRHcU5N?=
 =?utf-8?B?MktXQ2dwa2hhZHpjZm5zSHpHRWRaVFJQejdvOU05cFNUd0QySERxeElTRlVQ?=
 =?utf-8?B?dHVsbWFNWTlndWUzc3NLdGJJK0UrN0NhSE96dklXU2c5SzFJcGNUMmI2MXcy?=
 =?utf-8?B?aTFsdWtIUU1RS2l1bnpldGU5KzdhY1ZyTU4rL3U4MHFxalRycmRKTndRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTVjL3orZDQ2eFBNM1Jvd21RTEVVTXQzWkYzOG5RWE02eWRZaklMWUVQMnVl?=
 =?utf-8?B?Y1podExsNy9DNDZXSUx1OFhoRnR4N3lEeHZvcURHZU0xKy9WZVFwYkI4VnNJ?=
 =?utf-8?B?bEhxeElINEZzb2JqSml6V2U4R0JpbEREK05ZUTZSZG1zZ2o0bTA1S2NjUDFn?=
 =?utf-8?B?amJONnZhOUJrcHpudGNDR0lFK3E0d1pzMUI0ZEsyelAyVHBweVdNN203NFhJ?=
 =?utf-8?B?NVJNcWdFb2VJR0NjbjJIVjhYQWpabHZxOUNxNTJENU9DOGpGSEZMSC9xUG5D?=
 =?utf-8?B?NWxVY1VPMTNnSzNGVnJEczdWNXNOVVhSdVovYk96QUVHeWRSSm9ycDRzY0Nt?=
 =?utf-8?B?MzJtWmNETDJoMWYrd2xRWmtndEorb3NxdWx6MHgvVUpqTlZna3h2Y21pa3Jr?=
 =?utf-8?B?cXhCS1cwVHRRNVNWZ2xhcktiQ09yOVZCUUtMbVk2TlVURytzMDg5Uy9jejdU?=
 =?utf-8?B?M0QvVkxoYlZZSU4xSVlaSzFMQTdZRGhZYjdMdGdlUjdESHQ3Z1gxckZucGY2?=
 =?utf-8?B?NHVFTEw4bFIzM1pyY2tFQmtrMW82aVFhU1NsR2prZnVrUTVCM0hNZUR0TnFa?=
 =?utf-8?B?azFJR0lqMmVvMXVFUy9UN01KYnY0MVFySTR1UDZ4NXRCNlM3TkFRUmFwRHh6?=
 =?utf-8?B?a1FkNDFIbHBjTWdrSGcwSjA5dURlTnRrcWZRYlpQR1FoamJkandTSjBEN2RQ?=
 =?utf-8?B?MkZZSUZxVTZWWGIydTgrYkdGTEtScnRyY0tMdlVGUERsaFhXME1xWkhkS2Vv?=
 =?utf-8?B?MW41YTBDRVEvV1VHS2dVNmprSmYwbEp1blNNUERBK1BwUlphTnp4eWV4Rmkw?=
 =?utf-8?B?Lzl1N3U0dG9CVzlQRHY4eStxdHJIcWVsK1dwVTdHaFFXTTZaYUJsMUxGb3dI?=
 =?utf-8?B?MU9USWNVZkN0L2JHOFF4QW4xN1dwTCtkVjN1SkRDTC9xWk9aaVBVcnJGaW8r?=
 =?utf-8?B?bG1VY0hPeUJWeHZVUjN0eTU3M256cEw5T0xoNjAxTzI2YnBlaU5INGNYTHNs?=
 =?utf-8?B?RU9RUFF2dXZ2N1ZoSytNTFovYmpMakdnZUNJaEJiREpGV1VXelN3dDY4NTZ5?=
 =?utf-8?B?dmxlOWVDWFUwK25LTlptbHh5cmRzRTErcXB0ZWFuT0UyRjJuV0psYVBWNUZM?=
 =?utf-8?B?ZDdLRnZTZnJTTlFLakVOWU8wVHQ2cGFQRU02TEJLWHR0MklmT1k5emZtZjRp?=
 =?utf-8?B?WUlCd2NCSkxMN2g5YkZLanI3K2lpRnhUR2JPZVJWSEhCaGlSbnEwZ3VlbVJP?=
 =?utf-8?B?WVlXREZMNy96cVdHdGJSN0NGT2E2eHgyQlpYSVZYL0ZZK09PbTJ1eWEvUThh?=
 =?utf-8?B?ODF6ZDk3SXJ4dFNZK3RVZ3RSaWxyYktzK1JLZ2w1TDMyZ3BZNUR5Sy9ZTG15?=
 =?utf-8?B?c0xuVDJQWUR4QXFOVFpleHRjVE1aN1JXM2Q5MCtxU3BkWk1SUzJDc2c2a3Fl?=
 =?utf-8?B?cXY5N3F2cU5RRFFtYWJlRzBNVW9jNW43TS93MlMzcXNEQll1ZFVlb01uSTdS?=
 =?utf-8?B?L1lXbHZFWW5HQ2c1SnZMMGlVUFFIQXZ3QU93MkQzemxpUk9razF4eXpEN0JJ?=
 =?utf-8?B?eTR0ZnRObkVMNGVDTTNyKzJaOURLTHFPWkpzN2lpTWpldm56UmZvcmZvaHdO?=
 =?utf-8?B?ZThxMG92QXVqSVB5cGxjb1ZvdmxWMkxYbHdlYjBJWnhKQ2xCZWJUVWlIcWxX?=
 =?utf-8?B?L1BINXBsTk1wbWZQVTN6aklET21mMUdEMUdPUGU4dW9sZjZCbUI2NTA3NEdl?=
 =?utf-8?B?SStxS09WM2ROOGlMMDQwV2NMNFh6Q1ljMnFtZ2VuaWFDWXFudEFZOVRLcnpI?=
 =?utf-8?B?b29nRlhZb1VvNC9HeDV5MDYzeGYzL1lhN0poc0g1dnNFR1NTUm5SWDdmem9Z?=
 =?utf-8?B?SFRiUnRMKzV0REtGL1dwRm1ZTThZbDdiek5xWEhTSklOdkFjUkxEMWJYOHJ3?=
 =?utf-8?B?MVdla04rei9lTkE2RXZ2eFkvNzkxYm9MT3ljbmhpUWt3NzFMQjZ0SUd1M242?=
 =?utf-8?B?THZPek5MK2FjMnhRQXZFNWhza3hJZUNvMmV3SVV4QXFSM2NCMFBBSXZsV0pT?=
 =?utf-8?B?RmhXeDdkM0Y2THV2dk9pak52L0xud0ZZbzBRMFpTMmVvSlJPNlMwM2lvTnRq?=
 =?utf-8?Q?xk5+fA5iEJH9Cz5N9m3Lm8Sig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1956dbfb-7198-4d62-583a-08dc6a10d919
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 18:59:37.5464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k25/bFEDLJxLZnrKgSC/wFrqOlxFc/IMiiLKvRlqeyb8AyS8k6frdYZTjQ1F/grwDOP/FSkB+VYoieCfFUgjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
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


On 2024-05-01 14:34, Felix Kuehling wrote:
> 
> 
> On 2024-04-30 19:29, Ramesh Errabolu wrote:
>> Analysis of code by Coverity, a static code analyser, has identified
>> a resource leak in the symbol hmm_range. This leak occurs when one of
>> the prior steps before it is released encounters an error.
>>
>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 386875e6eb96..dcb1d5d3f860 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1658,7 +1658,7 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>       start = map_start << PAGE_SHIFT;
>>       end = (map_last + 1) << PAGE_SHIFT;
>>       for (addr = start; !r && addr < end; ) {
>> -        struct hmm_range *hmm_range;
>> +        struct hmm_range *hmm_range = NULL;
>>           unsigned long map_start_vma;
>>           unsigned long map_last_vma;
>>           struct vm_area_struct *vma;
>> @@ -1696,7 +1696,9 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>           }
>>           svm_range_lock(prange);
>> -        if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
>> +
>> +        // Free backing memory of hmm_range if it was initialized
>> +        if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range)) {
>>               pr_debug("hmm update the range, need validate again\n");
>>               r = -EAGAIN;
> 
> Nack! This can now override other error codes that aren't meant to be 
> overridden with -EAGAIN.
> 
> I think a better solution would be to just revserse this condition to 
> ensure that amdgpu_hmm_range_get_pages_done is always called:
> 
>          if (amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {

Correction: You still need the NULL check:

		if (hmm_range &&
		    amdgpu_hmm_range_get_pages_done(hmm_range) &&
		    !r) {
			...
		}

Regards,
   Felix

>              ...
>              r = -EAGAIN;
>          }
> 
> Regards,
>    Felix
> 
>>           }
