Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468E5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 15:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C2E10EED4;
	Mon, 25 Apr 2022 15:29:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC3510EED4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 15:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhyaD76FGrGuHwxFxNaem1TsOoYBcWjWgC1u/SyFvnuihhJVlQwcgtjl3H+HlvTZP751Qgx6rPsHrkEUzp8PZpFNUuykIICvv0hpz86xWGdUSs7J16uRRcQboHCx60GkNkywWXGLCMKrUKPpFzTasPLp7+R/nlgRo1Bfs7BZ8DFG/twtNl595Q3SCBqyQl+enr3MmszYKomjG//zCMVPySvXipYl5AXuEBxggU2e7d5TQuDcz5tFgT0iH1/7tq8IZxIlSB8jOnuJUhGDKKTdjfAMZiwzQMIcDM72UeSNOiUd0V/N15j81aCo68Js1j2T/HcEVGjSRb3Vq1Kkdw2ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKByQPmRbBxzLkz+yEYOV3xLCUgaiE/kqNE1EXImKKo=;
 b=NDSFoJOwZdTXuM2tOaoBlYmXvg0uVTaguqoaDL/fln/2lVb9QYF+CuUc+txyaTUBBXZJSf9o8u3WEzJh+4F+SK+UCvlHaBwacetp7WWY7BAmhE1AZmFlD+JAehQQEDRKzXdx2K2/0pj99gh49UoiXb0Q5MPPFLh25v7uA0mVHzgVFmJjsVJTM5ucsonVAgAxl61vIlTFufSwFnp8e/sMVnhXsTSoRt2w6q5ed2IVfiFMTSETmnyFrifGtMdkes9tuumNe3mflKndAi8dLHnmgmDQEunucvl1ZKfu7WC38bYguVKcBoXQEpxZljfiFQi8OBbYvVPasKxsxE2ZaKsLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKByQPmRbBxzLkz+yEYOV3xLCUgaiE/kqNE1EXImKKo=;
 b=t1LKogQDqRgC6lSThq2Tvu3SmdqJWibsYN1Ws1nwv71w4GE9OFlh6q9bbApygHP3HGzpqPP3uNYMe2fWk3mPzGNRzcFUix7k1//bV93oZjB2+1mK+rtFD2gsVxC32H82Fed1LYQCI8oqHGPu1gGJOUrF9n8Wio/XejYZWyUt7xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 15:29:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 15:29:03 +0000
Message-ID: <6c8a5640-363c-ed42-f261-740e38530e6c@amd.com>
Date: Mon, 25 Apr 2022 11:29:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: replace VM fault error by info logs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220423022445.7238-1-alex.sierra@amd.com>
 <f0e62c2b-a715-932f-891d-b4c80b395911@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <f0e62c2b-a715-932f-891d-b4c80b395911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20959a56-9c0b-42a1-5a50-08da26d053b6
X-MS-TrafficTypeDiagnostic: PH7PR12MB5655:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5655C0A12578D56B2596BA3792F89@PH7PR12MB5655.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91N0hsmzyZgTZMzO181E8XMSUmFdWgnkOS1R7/+DLMqFkY5hkF5QjEUOWXtYg44DurYVSj8CCdpMJ91+E1ystePtEqL6Fr3V8uk09hkhR1i5cTSaFDUu4Fmj4CEtdDDuc/6fhY07J/LNa7wuQJjK2jdLFvYQh4fQrQPmc+v1QjgwuGzoPMSEWiOGgs8aMG5BYRepbaaH/9HpebXDzY+C2ShIlGk3k5P/TRypqh5dPm4BaT72W0blqdrusWOtPsEYsbt9shVELRSQtt/3o1mTsdXLjKGZhf3bU7B/Zn5/3CvLxGpFTu8yhInxb2TkvMpvEwmGsQutMrzuF3XjfktJjad+xqGuCGBbeIlOzurpKYZRpYxeyep7QiNu+9GwJHeWGBbPsrsqtMyAXoXzIm4CSrYRF814PzFDrrew/orgphy4/vEqTLmeTqkh+48gGn9u8FSvNWNRIWIASFW+jQefu3YTzQPTJJCkUZls9BhRMdM7EvH+zFYRtUnu0oSCmv7nYYfwUSdp6lDPjor2ZkCqeRFeYem6k1KLkMzrA596EiNyjvPksfFJsZFjGRzZV+QN+QmEsMIIC+tTg85ngXfcWVScSniRGmLeDRv/sz7kVxsKCRWRitX4PcLGMYWdmh4ZwJBytQcqBmLZxIPXkOY6sMpJGkKofC4Uqh2Z7Ri3bOoSTxLBjjM5iT6n4FCs8vliHlOUlnrw0KGk6UFlpvMgW/dnJgxZEQrZhnIQ/KiYoZ9zAIuMH3YAl0Bj4xb7N3FZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(8676002)(66574015)(66946007)(8936002)(6512007)(83380400001)(508600001)(6506007)(6486002)(86362001)(2906002)(44832011)(5660300002)(2616005)(26005)(31696002)(30864003)(186003)(38100700002)(31686004)(36756003)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25vTWpEaFJoMzdBbGRxekRzbGE4cko1bFh0bmh3T3dxb29hc2YyYnVpSWZM?=
 =?utf-8?B?cUNRZFlIZmRNYi9mM1NrRXFTUmFGSS9RRitCWnFHRE02M0p0alpJYnBSeDFv?=
 =?utf-8?B?cXRCczdKWVFvdnRZWXBtYko3aUloWjJrR3psOHpLL0gyVW1TKzVxSnlmSFhH?=
 =?utf-8?B?V2ZyZHFvcUJNZ25LQmtSMEVuMFZuWEcrWmJldjNlMTc1bTNFc3MxQ2x5N2Q4?=
 =?utf-8?B?OVZXQnhnempLU0ZSdzFmTzIrWm1qaDVEaTNwZTZwWjhhK0NGbnRkbGZ1bkc0?=
 =?utf-8?B?TEExNng5OERVOWhCR1FPcUtTcTl0NW04d0dIYTVNbkgwL1JxMkhWd0w0dTZp?=
 =?utf-8?B?UW5GV2NsWURJTW5RTXZLR2M0V0ZtOTZpWnIxWXVUZTQvVjlRMklXbU9mSXkr?=
 =?utf-8?B?TExtVHR3eHp5dXZtdWx2RkJ4SGR0c3VVK3NBK09GNm5HbFE3Q1RXRlUvQ3pP?=
 =?utf-8?B?eHlhUVJSeDNkL01VUm9hTEc2SW0vUENqVms4YXkyTUdUN0hucVVIZ2ltMC91?=
 =?utf-8?B?cXl0ZExmUmh1QURVbGZRVXE0clAzSDMxbnpQbWgzcXZ1dXFEV2FoU21hT0hI?=
 =?utf-8?B?UHJ2Mk5ZVFBDRFUwVDNySlphM1VjL3VpOVY4UmtsRitaMjcrWnRUNS9md3Vq?=
 =?utf-8?B?WUQ4YWdJamVYeWxDOU5tcm80czVvb09qcS9YSGlIRnFZa3F6WkNtalE3RUFa?=
 =?utf-8?B?ZGNYT3BVWU1pRmh4TGZ5M2FURjVSejlPOGNpbEFmdFMrKzRJYmI3bTY4UG1j?=
 =?utf-8?B?Y3BDVmk5UVdnTHhndmEyMWwvZWZvSzNvK3VUS2w1M1ZUUXhTMkhQT3l0cEhu?=
 =?utf-8?B?dGoybzJLOEhVOHpSVnZpU29GV0F3SFBaT094bFo4OHA1SEtjMEU4QmMzWTZm?=
 =?utf-8?B?SjVQT0w2ZlNGNllGQ1FETzlRZ2RwWGkwRlhOQ0NMTmVxS3R4bGdBKzZHL3U3?=
 =?utf-8?B?cmNMd2FlcncxS2ZjVTd0ODFLanNwVmo1NHZCdGJXcWtWYzd4Mzg1bnBVajdQ?=
 =?utf-8?B?cnBrRkFyZ01FaXJmaHlMZWJIdWErSDhhamFQY2ZuS1NRQXJQTVpqWndsbDlm?=
 =?utf-8?B?bVFjMm5Tai9qRnNWTWxROHQ1bmdmcGcxazYvM0VNeUVGbDkvRGZ6YXdrN1ho?=
 =?utf-8?B?eWRQT2NrYmJNYllsSUlFd2RVTGZwSlpXUys2ZTl4RE5mc1pFaGJRa1BkMWs3?=
 =?utf-8?B?NWQvWDZEVjNjdHU2OXllUGJnTW9tOWJFOTVHV1Y4enFid0pEV0hhSDJhQmc2?=
 =?utf-8?B?cEg1QUhnWjZqWjRNRnI0VWdEMGVqM0RtYm5XYm53dFB1QkZoeTJkaitOVlMv?=
 =?utf-8?B?MjMrd3gySmJKU3hzZTJhS1NxaUVpQjA4dDhML2V6TjR0VHozQ2VEUE5UaWt1?=
 =?utf-8?B?aG40dG9BSVJONXhiS0VZdUV1b0J3WFRRRXFpWHZjYlIwRHhmQ3MzMCtLc0xn?=
 =?utf-8?B?YXNmVWpaeGcybnZtY1dGSkh2SGFQQlgvWEJHbXJjK3V2eWFQYkwzNFJ6ZXFo?=
 =?utf-8?B?RDN4VklwV0tEWTRIdFo0YXYzN2VkSmFtWXY2ZkRhVjl2eWNMbUhLOXlKMkxS?=
 =?utf-8?B?RUVCektMa1o0UWdqbVRsVlRET2dKSkFFRjk5cDlkY0RBdXhta25jODRqM2Vn?=
 =?utf-8?B?Z2V5MjVXZFBYVmVwYjBGUTdwbkdhQ2Z4NnIxME1YTnNOcmZJZzZqU29QT2tn?=
 =?utf-8?B?ZFFLdEFzeGtGYS95eWxPWnl5V3MzZVBnd3hzMWZFWHJnMktZV3FNN3NZUVBv?=
 =?utf-8?B?aXA5ZjdySW1SUURDZmhiQ1NNR245eXFJT3pROFpuMXhMbVpQRVM4dVpTTmhZ?=
 =?utf-8?B?NElJMThrcWFNTm5mRnh6dU1Nbk5qSzJhZE8zdEo4c2pxTDA4QTFQdzV6Y3RO?=
 =?utf-8?B?SnRQK1ZkRGtyNGxpWVZZcWlFeFhhVTMxbjVQYmdMcDFWVktFNFNqU0RPR2Nt?=
 =?utf-8?B?WTJuMGlLd0tJT21YUktCN1pvc2dUODJYN1hMR081b29SUWgwb0wzeVNvSTlB?=
 =?utf-8?B?Vjh1ZjkxdjU5N2MxaGNIUW03V1RVZWtXUDZ2eThPQmpHc1ZzQUhMUFBiYWNx?=
 =?utf-8?B?VzVIKzNqT25HRXZPNGE2aVNlbTloN0owWHFVd1VTMG5KWmhGREVCbHJadGJ2?=
 =?utf-8?B?VjFNdkRtS240R1luM29WY2RYM044SG9YeDhSdFJGaitZZlNPTWo2MjdBR251?=
 =?utf-8?B?UGVscUJReUYwZDNQU3ZoSzhjRFkzd2w5ZkMwaHJsajIyUmNxaGY4UlhSMmd1?=
 =?utf-8?B?ZWFXTm5PaGI0RkNjM3pwbzR3WW1VRFpsTWRQdzllSzBFQk1OenlSZGhpUGZ0?=
 =?utf-8?B?Tk5wbnhxcERqVlRNczJBRURMZDB0MG53NzBqWFNqL2svdlVIeWpPdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20959a56-9c0b-42a1-5a50-08da26d053b6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:29:03.4932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0l3FDDwY8RcLqEfmaWnlRyi1i6GbtKuHWwWmySFW/1PokDgAaPb1YY6KBiN0n24y2crC5dwbOTq7dJxCVGW0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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

Am 2022-04-23 um 13:54 schrieb Christian König:
> Am 23.04.22 um 04:24 schrieb Alex Sierra:
>> This is not a kernel error. These logs are caused by VM faults that
>> could not be handled. Typically, generated by user mode applications.
>
> Well it's still a hardware fault which should be logged as an error.

At least in ROCm compute applications, a VM fault does not take down the 
hardware. It only leads to termination of the process that caused the 
fault. It's very similar to a segfault in an application, which is not 
considered a HW fault either. Other processes are completely unaffected. 
The cause of the error is typically in user mode. I think the general 
policy is, that user mode errors should not spam the kernel logs with 
error messages. The messages are useful for debugging application 
issues, so it's good to have them. But IMHO they should not be error 
messages. Such messages often lead to spurious bug reports against the 
kernel for things that aren't really kernel issues.

Regards,
   Felix


>
> So I'm absolutely not keen about reducing it to just an information.
>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 14 +++++++-------
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 14 +++++++-------
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c    |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c    |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c    |  8 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 20 ++++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 14 +++++++-------
>>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 14 +++++++-------
>>   9 files changed, 52 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> index 6e0ace2fbfab..c226a4803086 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> @@ -79,25 +79,25 @@ 
>> gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>       u32 cid = REG_GET_FIELD(status,
>>                   GCVM_L2_PROTECTION_FAULT_STATUS, CID);
>>   -    dev_err(adev->dev,
>> +    dev_info(adev->dev,
>>           "GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>           status);
>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>> +    dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>           cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : 
>> gfxhub_client_ids[cid],
>>           cid);
>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>> -    dev_err(adev->dev, "\t RW: 0x%lx\n",
>> +    dev_info(adev->dev, "\t RW: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, RW));
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> index ff738e9725ee..fdcca1477592 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> @@ -82,25 +82,25 @@ 
>> gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>       u32 cid = REG_GET_FIELD(status,
>>                   GCVM_L2_PROTECTION_FAULT_STATUS, CID);
>>   -    dev_err(adev->dev,
>> +    dev_info(adev->dev,
>>           "GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>           status);
>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>> +    dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>           cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : 
>> gfxhub_client_ids[cid],
>>           cid);
>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>> -    dev_err(adev->dev, "\t RW: 0x%lx\n",
>> +    dev_info(adev->dev, "\t RW: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           GCVM_L2_PROTECTION_FAULT_STATUS, RW));
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index a455e59f41f4..864fcc0edb90 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -148,14 +148,14 @@ static int gmc_v10_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>       amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>   -    dev_err(adev->dev,
>> +    dev_info(adev->dev,
>>           "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, "
>>           "for process %s pid %d thread %s pid %d)\n",
>>           entry->vmid_src ? "mmhub" : "gfxhub",
>>           entry->src_id, entry->ring_id, entry->vmid,
>>           entry->pasid, task_info.process_name, task_info.tgid,
>>           task_info.task_name, task_info.pid);
>> -    dev_err(adev->dev, "  in page starting at address 0x%016llx from 
>> client 0x%x (%s)\n",
>> +    dev_info(adev->dev, "  in page starting at address 0x%016llx 
>> from client 0x%x (%s)\n",
>>           addr, entry->client_id,
>>           soc15_ih_clientid_name[entry->client_id]);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index ec291d28edff..3d830fd7706b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -620,7 +620,7 @@ static void gmc_v6_0_vm_decode_fault(struct 
>> amdgpu_device *adev,
>>       mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>                     MEMORY_CLIENT_ID);
>>   -    dev_err(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s 
>> from '%s' (0x%08x) (%d)\n",
>> +    dev_info(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s 
>> from '%s' (0x%08x) (%d)\n",
>>              protections, vmid, addr,
>>              REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>                    MEMORY_CLIENT_RW) ?
>> @@ -1083,11 +1083,11 @@ static int gmc_v6_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>           gmc_v6_0_set_fault_enable_default(adev, false);
>>         if (printk_ratelimit()) {
>> -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>> +        dev_info(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>               entry->src_id, entry->src_data[0]);
>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>>               addr);
>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>>               status);
>>           gmc_v6_0_vm_decode_fault(adev, status, addr, 0);
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index 979da6f510e8..1f3ceb03b47b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -781,7 +781,7 @@ static void gmc_v7_0_vm_decode_fault(struct 
>> amdgpu_device *adev, u32 status,
>>       mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>                     MEMORY_CLIENT_ID);
>>   -    dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at 
>> page %u, %s from '%s' (0x%08x) (%d)\n",
>> +    dev_info(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at 
>> page %u, %s from '%s' (0x%08x) (%d)\n",
>>              protections, vmid, pasid, addr,
>>              REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>                    MEMORY_CLIENT_RW) ?
>> @@ -1286,11 +1286,11 @@ static int gmc_v7_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>           gmc_v7_0_set_fault_enable_default(adev, false);
>>         if (printk_ratelimit()) {
>> -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>> +        dev_info(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>               entry->src_id, entry->src_data[0]);
>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>>               addr);
>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>>               status);
>>           gmc_v7_0_vm_decode_fault(adev, status, addr, mc_client,
>>                        entry->pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 382dde1ce74c..5be3f4f77c49 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -1021,7 +1021,7 @@ static void gmc_v8_0_vm_decode_fault(struct 
>> amdgpu_device *adev, u32 status,
>>       mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>                     MEMORY_CLIENT_ID);
>>   -    dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at 
>> page %u, %s from '%s' (0x%08x) (%d)\n",
>> +    dev_info(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at 
>> page %u, %s from '%s' (0x%08x) (%d)\n",
>>              protections, vmid, pasid, addr,
>>              REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>                    MEMORY_CLIENT_RW) ?
>> @@ -1466,12 +1466,12 @@ static int gmc_v8_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>           memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>           amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>   -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>> process %s pid %d thread %s pid %d\n",
>> +        dev_info(adev->dev, "GPU fault detected: %d 0x%08x for 
>> process %s pid %d thread %s pid %d\n",
>>               entry->src_id, entry->src_data[0], task_info.process_name,
>>               task_info.tgid, task_info.task_name, task_info.pid);
>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>>               addr);
>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>> +        dev_info(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>>               status);
>>           gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>>                        entry->pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 22761a3bb818..98c8de7307be 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -582,14 +582,14 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>       amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>   -    dev_err(adev->dev,
>> +    dev_info(adev->dev,
>>           "[%s] %s page fault (src_id:%u ring:%u vmid:%u "
>>           "pasid:%u, for process %s pid %d thread %s pid %d)\n",
>>           hub_name, retry_fault ? "retry" : "no-retry",
>>           entry->src_id, entry->ring_id, entry->vmid,
>>           entry->pasid, task_info.process_name, task_info.tgid,
>>           task_info.task_name, task_info.pid);
>> -    dev_err(adev->dev, "  in page starting at address 0x%016llx from 
>> IH client 0x%x (%s)\n",
>> +    dev_info(adev->dev, "  in page starting at address 0x%016llx 
>> from IH client 0x%x (%s)\n",
>>           addr, entry->client_id,
>>           soc15_ih_clientid_name[entry->client_id]);
>>   @@ -611,11 +611,11 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>     -    dev_err(adev->dev,
>> +    dev_info(adev->dev,
>>           "VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>           status);
>>       if (hub == &adev->vmhub[AMDGPU_GFXHUB_0]) {
>> -        dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>> +        dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>               cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
>>               gfxhub_client_ids[cid],
>>               cid);
>> @@ -648,22 +648,22 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>               mmhub_cid = NULL;
>>               break;
>>           }
>> -        dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>> +        dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>               mmhub_cid ? mmhub_cid : "unknown", cid);
>>       }
>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           VM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           VM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>> -    dev_err(adev->dev, "\t RW: 0x%x\n", rw);
>> +    dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>> index 636abd855686..ec8c8b2cab36 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
>> @@ -150,7 +150,7 @@ 
>> mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>       rw = REG_GET_FIELD(status,
>>                  MMVM_L2_PROTECTION_FAULT_STATUS, RW);
>>   -    dev_err(adev->dev,
>> +    dev_info(adev->dev,
>>           "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>           status);
>>       switch (adev->ip_versions[MMHUB_HWIP][0]) {
>> @@ -169,21 +169,21 @@ 
>> mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>           mmhub_cid = NULL;
>>           break;
>>       }
>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>> +    dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>           mmhub_cid ? mmhub_cid : "unknown", cid);
>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>> -    dev_err(adev->dev, "\t RW: 0x%x\n", rw);
>> +    dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>>   }
>>     static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device 
>> *adev, uint32_t vmid,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>> index ff44c5364a8c..72dda850e7d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
>> @@ -87,7 +87,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct 
>> amdgpu_device *adev,
>>       rw = REG_GET_FIELD(status,
>>                  MMVM_L2_PROTECTION_FAULT_STATUS, RW);
>>   -    dev_err(adev->dev,
>> +    dev_info(adev->dev,
>>           "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>           status);
>>       switch (adev->ip_versions[MMHUB_HWIP][0]) {
>> @@ -100,21 +100,21 @@ 
>> mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
>>           mmhub_cid = NULL;
>>           break;
>>       }
>> -    dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>> +    dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>>           mmhub_cid ? mmhub_cid : "unknown", cid);
>> -    dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
>> -    dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
>> -    dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>> +    dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
>> -    dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>> +    dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>>           REG_GET_FIELD(status,
>>           MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
>> -    dev_err(adev->dev, "\t RW: 0x%x\n", rw);
>> +    dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>>   }
>>     static void mmhub_v2_3_setup_vm_pt_regs(struct amdgpu_device *adev,
>
