Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE47C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7579112C17;
	Tue, 16 Apr 2024 12:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K0eq2ziv";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E99112C17
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 12:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9aPxMPO7D+ge3nE+SG9g9D2/QEvHiZ2PgOGmH+heIgUuBOk58chZtICuLFdCKfZ8bv5MNXHb/nFYz/EPCDJENB5I6qYiWUNkDoqBNbWI4lMWW6sNxgD5+GsBKsBbrRcQwocTXFf3au7B/nuNTEnWDrl3XqS3kaebQfy2X0Y4Z95PXhjEO3F2mBmW1sLXX3yfVi1zY7uHHuCA53j7LaF+LZCctjjDMUl5FhK2iQFghDLNsux/2cWD0dw8/lh03HQQIf0IwXQbkoS7RAwAPY/twYwjFPfFtZtSngTzjm2ncX+UIacTqAX0zcRdv4aN3KB7Yy8iNMrv6RVOR+JtMC7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fCw9nyHEJr1/8RrvPSLR0NXIBtN10dm+sbhOm1qAqM=;
 b=agavPRzn8v+zICtZh7ksfA8E6qaFD2DNB7vUzipr3ohDbi4CAGTQWAy7cflyPqZa+qHjTb5+npvHZ5LWRBQbmg48Kx77jLqeTNinKcZ8T/RmvQcFYooVoGj4JYRz/HBNYxGETczpQt1MSSxUbRhQkDr02o7FIVl4e5Ri85tW2tjyEm2CwOB0xnkmusNcBlQKfm1xtGuMKF6MIHxcAWboDu43IJLJh4HDoanhcA4XdFxeuR+fYB9oq6qQlRQL7n39U4xjE34K7QqchcpqdyxAlEWddtt/SgMOOdAv/xP25eC713SyEfmBrQYNuOGI8EBSs1vz/1YbW10TjzttSbzBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fCw9nyHEJr1/8RrvPSLR0NXIBtN10dm+sbhOm1qAqM=;
 b=K0eq2zivTY7+Dz1lSsowf9GUBUt/dXb+EPEj+xfn2aSXes/HFPhRR7i1UTZZqhaGH3GOi4P2w9Mt61j1WUkVZuuiXVFu5yL6zOrBgbQN22jEqg84TNUNfF7HP7BN2Mcas5rLQ3/mJuH2rhZxfFPzyrnFDBAXYSwGBzSKxZp1Ig8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:16:21 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:16:21 +0000
Message-ID: <5383bac8-c097-4975-8022-181d1d2f0877@amd.com>
Date: Tue, 16 Apr 2024 17:46:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear seq64 memory on free
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240415184837.299965-1-Arunpravin.PaneerSelvam@amd.com>
 <662576a5-4597-4a3e-bead-4b80852eb19c@gmail.com>
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <662576a5-4597-4a3e-bead-4b80852eb19c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::20) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: e96addea-5ef0-4a4c-35aa-08dc5e0f070b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 890x2b2YmrD/Mj79tZNCNNHPv9NT6wivRiPKPrcNfzKagmzOK9dhrIuhB0AQoOOMhHxWUKy96CMxtLayuNwfFED7mdtg6Bkl5HM2ugz1H7k4XcqxGXMzYbcmBHFUfzCkEY7qP4Y9uVqgIZQfSzNbMpYlC5TmTYVnU9W08O8/Vs9f4P4fpWyC1kj/bTxmR3bYxIjAs0hxsicvyIqNnEZiEEHvKcS4trprqsOAAiY06MGz9urWe6/1NuIE+QGgxDOD2ocdlXqgH4M6fAKneHyiAIXMJlR1DN9FJlZJlWq+N6/1TBWXQySTkP7MvglbNxju5ZxvspF5rEzxYVJtZUxj8t1wdraPHPZr4ROn0s6JDasTVuyUcgYth+UFGf/pru7UOgZZVNCECT+iBQZF9sP3owMrLVwuZsgxQ68/eMn73zfFUklqtiC0YnqZtCH3EYFEud8bI7sG7YiL4MzTS4MQADHXOsLC9I4uLoL/O1/I68CVs0ddbna219mGvaHkpOxytVQibRSagmbBLN2ubZViemjSfHBXp2wwTxU+WuiS1UyPP1RqLc/qoQOheAw/rZX2rDMwsZTlrubCI6NneiHglPxyqgroQM2L4s/PQnQb/WxdDO0xn7eAGxemCE+HzrnBWpOLknii3ihmHB5qSts1iVXbyyJyH953dveZcMNaPE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTZycENpMi92ZEoxd3NJR1pDMS9xbEpDWDU2dFQwbFpxTU5TMzllS0JpeWQ0?=
 =?utf-8?B?UEtLN2hJdTBvSWtMblZhend5RWdQaWdOUnR1eXZhTnBLcEhVWHBESnBZRHNY?=
 =?utf-8?B?eXhyc0o3WUN1YUVFUVZ3MUJDMFVMcnBITUJTZ1htREVaVWpHOUV6V0QrNi95?=
 =?utf-8?B?WVpnWFM5SU5pTmdxS2NjdkNXeFVHdXJ2U0NqdkMxNy9PbmN5aFdkcFBYN0pK?=
 =?utf-8?B?WDF0RGhDRzdvQ2E4dUQ2U2YwbXdjZjRCaklHSEJZUmg2SXRmbjIwYkhBeXZh?=
 =?utf-8?B?VVdOanIwWXMyVGw5dC8xcTZ1TnNJdjJmRGJyS0t0UVRlZ3dZRHpNdk5BNXA2?=
 =?utf-8?B?emhxSHhzNmxqZFFBNzZ2bUo2VmxKMWg3dVZZdmh6dE9CdFBWS0JXZTJPeHNT?=
 =?utf-8?B?dktGRGFxOHk2eDdzUlZIUGNMSktLeVNNcUM0MHBjVFd6WkVLM2RNOE05bWhZ?=
 =?utf-8?B?bXN5NHhWQ1RjUEMxRnZ0VHFGNXR3OUdlRlNmRTFkRy9PTC9LZWZudGxUNzFl?=
 =?utf-8?B?S0czajF3NkFHY1Z6L2g5K2hLc1I0d1oydFNNcTlDYUd6aXdCOU45a0R2WEY4?=
 =?utf-8?B?T055SEtEMzIyOG9ORlZqd2hhNjQyb2xRejkvTHp4ZFNZdy9obk90T3VsL29U?=
 =?utf-8?B?SHJJaFdUeUxNU0tnYXVSdjJJWFpIK2k1bmZBQ08wTTBwb1dHOHVGaUxQdDR0?=
 =?utf-8?B?ZHFLOVJKMG14cmg5ZlRHNTJ6L0NPbU1PRERUckFleWk5dVhURGFGQ3JlTWdk?=
 =?utf-8?B?RVR3ZGZISW53eUNoL3FRU3JMWEJESzFmWWFtZi9ibGh6ZGtMVXB1ZXRvc1hw?=
 =?utf-8?B?NXY1NUswbDEyQk0yUFFJZU1OMHd4REI4U1BpZncrb2pUaHBGWUI3Z2FOS1A5?=
 =?utf-8?B?QmRHZlFoMWJ5SjNvV294L2IzOTY2RktzZFBPQnJOT0dWTVhVcUplbmpuRTY1?=
 =?utf-8?B?VlJia3VLYzRhdVhiZE13WE5qN3FJTWxMOXZ4UVFMcFpucFlJbG5YNkEvbTc2?=
 =?utf-8?B?dnBiSk0xVlNSMjFwS2U1RFpsNzdsZjRDYnBhQS85UVlVTm1KbCtyYldmNllI?=
 =?utf-8?B?Vmh2RXhRbUV4UzQ2TWlOVVdUS0NKaUNYQTFESTkwUnM0VTROTTRiMXFPZk1v?=
 =?utf-8?B?Rm0yUExvWHhpNnNZNDhXWjh5dVNDRU11WjBpSVdvMUZhTnh4cCt2RDJoakFK?=
 =?utf-8?B?azZUaVBFR2VVM0c1b1NFWExSNDlCbUxvWUU1U1djdU9nVy9CamllRDRWaisy?=
 =?utf-8?B?bFlSMEVlQmdFQ29vWi9PdlhvRHdma2tkN09xdnhzRXg4NTEzeDFHTnY5bGtF?=
 =?utf-8?B?K0ZpZUZreEVOYUt0bE5aREl6V01SVFZOVDJweHZVZnhaT2Rra2xlaDRTM2Y2?=
 =?utf-8?B?amJHOFBuY0dPUFVRMVJhV0tHRjkySzZVeDlvaVZzTG1ac3I2RUIxTkpjVlNP?=
 =?utf-8?B?K0p1RzFDWXVRNURwMFVxdGNLcWx4QlpMVTZwTkZ5OTlvZUVpR1M2RnkwQ2tJ?=
 =?utf-8?B?QlBYMjhSdDZLOUF4RTFtS00rRnFYL2tzbGlIK3p5bzJPd2FlUnZDWTBjU25t?=
 =?utf-8?B?UEhqb3FPd2ZYQi9pcnhmWkdHcDN5MEUvWlpZZmxFdzVOOGtiSG5kZE9BdVBi?=
 =?utf-8?B?RG5kNzIvaVE1K2taRUljdUVTTDRmL05SY0NxMUNDakNKR0JGemhmc01tejd0?=
 =?utf-8?B?MWFpV1cwbWQ3WFkwbjlTeTVOS085RXpvdEJJMDM0eDFEOEExWmg5bTJhQ3Jz?=
 =?utf-8?B?aGxiUElQTVVlUytpbXdtTCsxRUI3Y2w2UEkydzZmVy8wYTlXZW83Z25LOXkz?=
 =?utf-8?B?YTB5ZWlTMWVyQ0tMakF0ZWlQazYrQlFCZWd0RmpNUStkcmJPTWtscGl1L0M5?=
 =?utf-8?B?OTkzdndGNnR0VnNQZm9JUEsrQVJKeWNoK1YyODNFTXFBRDEvWVZ5Z2lEak5o?=
 =?utf-8?B?SXVPOFdBMjlBSzg5elk4ZHF1cmtyZTN4OVRTWjhjMmFFTWM1Q3B1WDF3eEFU?=
 =?utf-8?B?RWdWWE9MS1AzNWRjcWVubndjOFZtSXNuL2pDWEp5UXhiamRWdkdVeXZZK3ZE?=
 =?utf-8?B?UUcxR0tRR2tQcmoyUmtQSTVoYnNGZVRKZlBEeDBEc1I3eDc3aG9vZ01JUjV1?=
 =?utf-8?Q?K8nkT06Cts2wPIOQXzSgAT87i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96addea-5ef0-4a4c-35aa-08dc5e0f070b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:16:21.7286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtbOjOQOalVsj5ngGKDs8FRyk2aWfbYFl5szOhJuUXUr5xSLKDkW0eiRDu4qXobdiccEN1ywSC4V9fh59kLRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

Hi Christian,

On 4/16/2024 2:35 PM, Christian König wrote:
> Am 15.04.24 um 20:48 schrieb Arunpravin Paneer Selvam:
>> We should clear the memory on free. Otherwise,
>> there is a chance that we will access the previous
>> application data and this would leads to an abnormal
>> behaviour in the current application.
>
> Mhm, I would strongly expect that we initialize the seq number after 
> allocation.
>
> It could be that we also have situations were the correct start value 
> is 0xffffffff or something like that instead.
>
> Why does this matter?
when the user queue A's u64 address (fence address) is allocated to the 
newly created user queue B, we see a problem.
User queue B calls the signal IOCTL which creates a new fence having the 
wptr as the seq number, in
amdgpu_userq_fence_create function we have a check where we are 
comparing the rptr and wptr value (rptr >= wptr).
since the rptr value is read from the u64 address which has the user 
queue A's wptr data, this rptr >= wptr condition
gets satisfied and we are dropping the reference before the actual 
command gets processed in the hardware.
If we clear this u64 value on free, we dont see this problem.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> index 4b9afc4df031..9613992c9804 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> @@ -189,10 +189,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device 
>> *adev, u64 *va, u64 **cpu_addr)
>>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>>   {
>>       unsigned long bit_pos;
>> +    u64 *cpu_addr;
>>         bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
>> -    if (bit_pos < adev->seq64.num_sem)
>> +    if (bit_pos < adev->seq64.num_sem) {
>> +        cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>> +        memset(cpu_addr, 0, sizeof(u64));
>>           __clear_bit(bit_pos, adev->seq64.used);
>> +    }
>>   }
>>     /**
>

