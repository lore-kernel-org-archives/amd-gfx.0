Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D5BC04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 11:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CD610EB11;
	Fri, 17 May 2024 11:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ILoys5is";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE6F10EB11
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 11:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzVjzcs7SI88YFXgS2hy8qvdBbEZW1NvfbZ6Ca+jqmsWPplt51wYQ643VW2L+TUwbcWK8Dy0W0g+c0NJpl2/KhwgluzB086MOdhNxmijSVJQ8rNU0vPXb7Nt1KePYlNiuDydlA3DW2emOUPe1A27bPmSAJquLFpTERfDlxXmV8hPaoevvkz+//Uv6V9QgQ7ENaRj9IFPu7k4+6DCYnt1oGB0KhkR9gKXPjET4T/7phAzhu+zkCXa3Dme1rK/t2jMxgVBoBOimILJy6YE9kdBoa2umqkBjRxH6NPfEWGrc+9TgCHcxwzbWxro4J2G19BBm0uM/DSAdqJOTbvdmEbT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH4wjyoey03YJNyuqaH0GSekaxMLRaZ48cKfie52fy0=;
 b=OwIQ/ixVUhjCanUYo7ZJ1qG8d1E+/ETeCL8HvQ01H0+XQ4cGxDbcKUSCacpLv6OwZjrPUVDpA5odq9/N4jpr94QImzhczpmEgc0MnKiUNUmcZOAUHb7DTjj+XJ06conGnfbyYuQL077cr7IFp3xOKb4fjpdT/OskyD4/MdHdP8H+X0MjKG+c3L96paA/WvuY2xWtF2+QErjRfa4esaVTfuA+CDMD7vxF9bsMuFO0o5YGifzvg1QVVQUi3+JXlMMO8OWCtw5/H/GrwpUvcgEH34iNhUWRseqhuB2Q09BE/vhsXFMtZinEPME+q1jBoyN9muYEf2pl3pCeXa6RCg/2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH4wjyoey03YJNyuqaH0GSekaxMLRaZ48cKfie52fy0=;
 b=ILoys5isCEuJqk5BYWJDyos1MHE8dxIeDl4GX7JNdtZfeayB0+1U5q4shM2AYi3fZUw+tZaLZisuP35NAU4W4ivYHlCz1cPAtDcuKXwdRuXbxnTWWLLIBA1SMRZCBpTF7RAw/QH71kWdeTMM2M95HxamqAe4Ji1Y+0SJul7f3MQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 11:02:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.025; Fri, 17 May 2024
 11:02:23 +0000
Message-ID: <d2318d74-6dd6-4d25-aa4f-1b1bebf8fc31@amd.com>
Date: Fri, 17 May 2024 13:02:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240503091500.7768-1-tursulin@igalia.com>
 <48fd5f77-9a5f-43a3-8009-e1655cb447bc@igalia.com>
 <7361a70b-656b-4de3-bf63-5a913bdfc5fe@gmail.com>
 <76dd9099-568a-4b80-9d70-57dba6578571@igalia.com>
 <7da37cf9-b007-459f-991e-bbcae28933d4@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7da37cf9-b007-459f-991e-bbcae28933d4@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf89618-dfe4-439f-eb93-08dc7660d454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjNKaTBMV2dXR1RncnVkcXBzVmdzeXBTcWxDZ3d2NEc1dGx5Y0k5aDZQblo5?=
 =?utf-8?B?bm5WaExlMzExV002cjNidm83RWlmVkpQSFE4cWJLbFh2ZDZ1a09kSTdtbmt3?=
 =?utf-8?B?K2tuT3N2UnpkVy9TVUNORDB0RzZMTU5NZHUxbmFEYUdIUXl5VXhKYmFWU1ZH?=
 =?utf-8?B?NjlZRlRjL2ZrcE5Gb1podHJrRXRGcFREUHhQTkRvaGdZeHFmVG52VkNKR3VL?=
 =?utf-8?B?UXRzMFNxV1BvOU9BRjJ0QWZVb1hOWTVCTEcyMGxSbFlqd1VIN2doVEpVTFZO?=
 =?utf-8?B?OXI1TFVDSm5qOXRSZjM0UVBMM0M5WmpCVTdwOVk5b3VzaWhsRHhmWm9SNjlT?=
 =?utf-8?B?bG9kZExQcFFSS3l2cTVnQWEvUUE5bmpCcGxZN3VaNWhkSU5jMS9Udk5ScTBI?=
 =?utf-8?B?dzdab094a01CV3daLzJVQkNmcmZCOVpLUk1mdjhNYjhlU25WdWNoQTVUNENN?=
 =?utf-8?B?c3ZEOHNDN0VOQjRBZC9tRjZ0dFR1QUFPT0JJYW1YQzhVTldVb2xqcEdiL3Q4?=
 =?utf-8?B?YStJM01sTGlPcm5RZnFIV2cvMTd3VVROZnFDQklIS2FEdW9xVUhqdVdyUkFz?=
 =?utf-8?B?VmE1b1Y4bUxmR05hUFdTMkdIU3lzTkdZU242TTlacDdZb0pLbHlUbTZ3OUYw?=
 =?utf-8?B?b1pWdnpBSS82ZWRhdm9kYVZDcVZlYmkwbUYwRi9SMHpOc3I4M0dmVHMyNXNj?=
 =?utf-8?B?aWp1ZGQrUElkM2pTUG5WbFpDRGhORjhvNjltVDZHYjFDYUFUU3VMc1JVSEpy?=
 =?utf-8?B?bm1ybkU1N1JmWWJYeTJRS0ozTU9YMCtvQlFNeHJiZHdVWGF2SmFGc3Z0K3B3?=
 =?utf-8?B?VnE4eTV5a3dtS1JBOVFNWnlMeTJhT3g0Mks5UXV5ekxLLzFkL0l1L3BwdWJU?=
 =?utf-8?B?WUd4UFFzanBTZlhXWEE0eXdSaVJiTkVZblprbkFXcGxNdkNWUE16R0hXZVNO?=
 =?utf-8?B?UVk2S2xEcUFjTVBsdGwyelN2OW5Ha2xPYmNaWkNCaXQrWFpsaEl4ZlVDZDVm?=
 =?utf-8?B?eSt2Y2lJd0ppdjNCNi9tNzM3anprM0ZhQy9pMkw4SWpkQ1BWMDRmVzhqVnlo?=
 =?utf-8?B?aFIrT28vMXVGSnRLREhSTG1QVFFKdjB6am4wY2tLQ2RlbVZrN2xwbGhMNytx?=
 =?utf-8?B?MHhvTmN2b2NlVkFVaE1yTy8zOWdhQmRlUWUvY29yRkhpK25jODExOXZRT2M1?=
 =?utf-8?B?Mkp6ZHZmMnVmMnd2WU8weFFXbi8ybnR2cXViVG9wMmFzMWE3YXBRYUtVNFhn?=
 =?utf-8?B?eDVtbTk4N0tjYy9Yb0t0bzZSMmpNUVJiYXJGTFhGYVpmVVlydmMyVHhmbk9F?=
 =?utf-8?B?b2hlajNOaW5zelFLaXpmNVhYdlBzUG1TQ3FSWkQ4UzVPYnI1N2gxRWZLbSs2?=
 =?utf-8?B?bXF5L1JjQVdzelJxSzU2SHFhWDRKSjdzazBXMStldlhDaHZ0WjU3YVdzUXJZ?=
 =?utf-8?B?MFRGMTYxYmN3QSt3eTE3Z0crWnkwYkU1RVdTTyt1aTVkenFjZDBRdSt0U3Bw?=
 =?utf-8?B?VlkvTmlTUzdSSHN0WFZnbXJCeC9wRXRoRkZqcHMxd0wxNGhQb1ZaK2RYSHE0?=
 =?utf-8?B?VWp3Vk9pRlRCc05oUVZHOEQyc3U2b0E0YzduY25aNitvOXoxSzRDcy9Ud3NW?=
 =?utf-8?Q?YGoQxwCF+ZL3UQSyVV5xZWgS4576WxdUrvRxtonLN3ms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Y0RWNTZzUrMDJQMnNZend3VGZoclg4L09lUXZXOHdrbmhkTUsxSzVKNTRl?=
 =?utf-8?B?UlIrWmhIZUVmS1RSWHo0Zy92SmkrcUFvVDVLeWxiY3V5TVRDUFl4cWY3ekZT?=
 =?utf-8?B?ZXdZMTZLZHE2bkhoU3N4L2d2a0wwZ1F2VnhZVTZWR2ovNXNYWDdsZmdVUmph?=
 =?utf-8?B?R3ZmTCsya3N5OWFmQ0dldng2WmhqOU5RQng5Mk9USnRXRldQQ1dXeFQwVDRh?=
 =?utf-8?B?Q1BHb1ZTcTlrVDJ0a1hqWmlsdGk4UkloSVhkdEFEMWc4TTZwUzlzcFNvYVcv?=
 =?utf-8?B?Vmp0VG5jY3paZEdTaWV5L043c1RGdUR4c0xJeUh4WTQ4VnM4dnlxZnpnc3RB?=
 =?utf-8?B?RTVPNm9lS2lES2xJTEorbUFybi81SisvL1ozZk5mNjZWMDZVUWtQUWZjUFJj?=
 =?utf-8?B?YnB0czJQM2l3Q1FHamw2WnFkR3hXUG5WZGViajZiT1A5MGVKdGFyUFphMEZG?=
 =?utf-8?B?K0tTbmVTS1ZCazN0NTlRck0zNG1FSm5PT1l1Z1dEbnVVdUtrbmVsemlCRWdh?=
 =?utf-8?B?WUZXN1ErK281MWdyWkc3cEE3QkpRMEdtVDhzTDB2c3V3Qk1JMEVHa0VjekNY?=
 =?utf-8?B?NEQ4QXNINzB1OVVXQ3VwL09HcTdieWRiSk9ORG9lWWRHYU81WUc2NGhqcGlw?=
 =?utf-8?B?Wmt4Z1hscmFCY2MrTXJlSVBlK21QK2QvSFpUVndXL3FxY3locXVvL283bTJW?=
 =?utf-8?B?VFpRdHV0SENuV1F3STZ0Z3FwWVhZeW9zbllFSkdVL01qRE5wd0dOVHU4SzhW?=
 =?utf-8?B?UTdxNXhYYlp1N0JoTGFMM0hYZUg0eWtsSVAvOTVnVEZZc3I5N2VEOS85czEv?=
 =?utf-8?B?Y2hwdzlZQlR6a3dZTWpIa3BUcFhwMFB4dnFlWFF4L2twMkhaeExVdkh6QXkx?=
 =?utf-8?B?S2poUWFpTEVmQ1Q1QXZPeDFjcXF1dm4wY2h3ajFWd3lCckNOK1Y2eW9nOTh3?=
 =?utf-8?B?bzRCSkw5SDhtcW42b3IyY01hSTdGbHBDd0VYQXVuNHVJN0g5Z0VMdlhSMWZm?=
 =?utf-8?B?SVoyYTRxWkt3Q2U0NllNSTV5VFVqS3FEc0oyQjZSd0ZSbVpPeUhHODlmMHBi?=
 =?utf-8?B?eUNPMndqTG5YVzVxb2x2YUhCRngwRHhEUDg0TXQ2eVFVcTY3U2tCeVduZkxw?=
 =?utf-8?B?Wmw3TFM2aXhTckwzelB0TDc2dDVLOFZDc0RIZ3ltYjV5Sm5XcmVPQUlFbFpt?=
 =?utf-8?B?M2kva0U0MjU3VlU3SGYxYm9GQndaN0FxRjJzeit1ZU1BdUQ2UUhDN3JPeSt2?=
 =?utf-8?B?Q3kyNjFCa2NsLzcvN0cvbFoydHg3a0l6eENKSmpjaStnMFl5b0RzK0FaNzQ3?=
 =?utf-8?B?MmxmcEFsU3FqclljWmxXdy91Q29PUC92WVNmSzhwckdPUWVRZkE5NDdKNSs0?=
 =?utf-8?B?Sm9mRWZKV1I2emFEazRwWnhDVngvU3V4TXAxQmZNampiRVJRWXlFUitoejNn?=
 =?utf-8?B?VW5MUGN1dWFYQ1hhS0I4eUZxV0pKOFBYUGVkNnc1ODc2QUY0SEhFR2ZUMUk3?=
 =?utf-8?B?N21UZE12Q2ljaGw1NktITkc3aWVqVjgrZWNoT2RjQUpmVjRKVmh6UXJmMmFK?=
 =?utf-8?B?Umxtd3F4b0pERUpiR0dXTWd4VkdJNlVuSGJhQnRLVlJVOFhiNzZ2WG5iWEc3?=
 =?utf-8?B?V2lES1lra0hOa21uTUpuY0paOVdadldoK3ltdDJMWStZMnBhdnc5YnNEMFdr?=
 =?utf-8?B?blk5d3NBUklCMENIUGVsRXFuOW9WTGZqV3g0NmgwUDdraXlBNmpxdFVoVGZs?=
 =?utf-8?B?TnZPSUZyd0E1WmlOeDBYNDhoaVNLbFZVK3dNQ3h4YUhEcXhVYUhEUXRPRFNT?=
 =?utf-8?B?Q3RIMGZHUFVQSzVEbVVnMTdaUHp3a3VvVmtjYUNyYUNDYXlSYzJvc2FFdjNL?=
 =?utf-8?B?ZElQTUUvZ1VRdDJ0MUs5K3hMZHlHcnVIWVQyRnNZWU1waXJnTVloN3ZaZTM2?=
 =?utf-8?B?Z0dLK2xiMiswa3RqSE9hZEFqcjNtamFGMnlKTXo4QllkcllCZHNLSEhSS2F2?=
 =?utf-8?B?ckN3RTR0THFPSmc2cktTTS9JZU9ZazY2Z3R1RWY4K3d1MU9HYkFPYUpZTm1i?=
 =?utf-8?B?TWdjY2RGR2lKVE5KUjNaR0N4QWdTOHFJTm9NUy9EU21tTkxoaktLTWdGZjRp?=
 =?utf-8?Q?ou+KMy7JWZSQCTKkJipkPUOjp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf89618-dfe4-439f-eb93-08dc7660d454
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 11:02:23.4152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4eQCWhUyGq0R5Q4QH/iYZh3N0StTtZefm0sMal3G+0EZDOIvPD2trjrTlTNltre
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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

Am 16.05.24 um 14:21 schrieb Tvrtko Ursulin:
>
> Hi Christian,
>
> On 08/05/2024 09:26, Tvrtko Ursulin wrote:
>> On 08/05/2024 06:42, Christian König wrote:
>>> Am 06.05.24 um 18:26 schrieb Tvrtko Ursulin:
>>>>
>>>> On 03/05/2024 10:14, Tvrtko Ursulin wrote:
>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>
>>>>> Help code readability by replacing a bunch of:
>>>>>
>>>>> bo->tbo.base.resv == vm->root.bo->tbo.base.resv
>>>>>
>>>>> With:
>>>>>
>>>>> amdgpu_vm_is_bo_always_valid(vm, bo)
>>>>>
>>>>> No functional changes.
>>>>>
>>>>> v2:
>>>>>   * Rename helper and move to amdgpu_vm. (Christian)
>>>>>
>>>>> v3:
>>>>>   * Use Christian's kerneldoc.
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 41 
>>>>> ++++++++++++++++---------
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
>>>>>   3 files changed, 29 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> index 67c234bcf89f..e698d65e9508 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> @@ -174,7 +174,7 @@ static int amdgpu_gem_object_open(struct 
>>>>> drm_gem_object *obj,
>>>>>           return -EPERM;
>>>>>         if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
>>>>> -        abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>>>> +        !amdgpu_vm_is_bo_always_valid(vm, abo))
>>>>>           return -EPERM;
>>>>>         r = amdgpu_bo_reserve(abo, false);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index 4e2391c83d7c..d451ff9d5af4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -333,7 +333,7 @@ void amdgpu_vm_bo_base_init(struct 
>>>>> amdgpu_vm_bo_base *base,
>>>>>       base->next = bo->vm_bo;
>>>>>       bo->vm_bo = base;
>>>>>   -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>>>> +    if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>>>>           return;
>>>>> dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>> @@ -1101,13 +1101,13 @@ static void amdgpu_vm_bo_get_memory(struct 
>>>>> amdgpu_bo_va *bo_va,
>>>>>        * For now ignore BOs which are currently locked and 
>>>>> potentially
>>>>>        * changing their location.
>>>>>        */
>>>>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
>>>>> +    if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>>>>           !dma_resv_trylock(bo->tbo.base.resv))
>>>>>           return;
>>>>>         amdgpu_bo_get_memory(bo, stats);
>>>>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>>>> -        dma_resv_unlock(bo->tbo.base.resv);
>>>>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo))
>>>>
>>>> Beware the logic inversion here - luckily no one merged it yet! I 
>>>> will send a respin..
>>>
>>> Let me know when that is done, I was about to merge it.
>>
>> First three patches in the series 
>> https://lore.kernel.org/amd-gfx/20240506165959.50648-1-tursulin@igalia.com/ 
>> if you can pull it from there or I should resend standalone?
>>
>> Please double check it though. Sorry about that I am so used to 
>> pre-merge CI we have on the i915 preventing silly mistakes such as 
>> that one.
>
> Small reminder on the above since you have been out - are you okay to 
> pick up the first three patches from 
> https://lore.kernel.org/amd-gfx/20240506165959.50648-1-tursulin@igalia.com/, 
> if they still look okay to you? Or I should re-send them standalone?

Ah, thanks for the reminder. Totally forgotten that I wanted to push 
this. Just done so.

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>>>>> + dma_resv_unlock(bo->tbo.base.resv);
>>>>>   }
>>>>>     void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>>>> @@ -1203,8 +1203,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>>> *adev, struct amdgpu_bo_va *bo_va,
>>>>>           uncached = false;
>>>>>       }
>>>>>   -    if (clear || (bo && bo->tbo.base.resv ==
>>>>> -              vm->root.bo->tbo.base.resv))
>>>>> +    if (clear || amdgpu_vm_is_bo_always_valid(vm, bo))
>>>>>           last_update = &vm->last_update;
>>>>>       else
>>>>>           last_update = &bo_va->last_pt_update;
>>>>> @@ -1246,7 +1245,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>>> *adev, struct amdgpu_bo_va *bo_va,
>>>>>        * the evicted list so that it gets validated again on the
>>>>>        * next command submission.
>>>>>        */
>>>>> -    if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
>>>>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
>>>>>           uint32_t mem_type = bo->tbo.resource->mem_type;
>>>>>             if (!(bo->preferred_domains &
>>>>> @@ -1640,10 +1639,9 @@ static void amdgpu_vm_bo_insert_map(struct 
>>>>> amdgpu_device *adev,
>>>>>       if (mapping->flags & AMDGPU_PTE_PRT)
>>>>>           amdgpu_vm_prt_get(adev);
>>>>>   -    if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>>>>> -        !bo_va->base.moved) {
>>>>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>>>>>           amdgpu_vm_bo_moved(&bo_va->base);
>>>>> -    }
>>>>> +
>>>>>       trace_amdgpu_vm_bo_map(bo_va, mapping);
>>>>>   }
>>>>>   @@ -1942,7 +1940,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>>>>> amdgpu_device *adev,
>>>>>           if (before->flags & AMDGPU_PTE_PRT)
>>>>>               amdgpu_vm_prt_get(adev);
>>>>>   -        if (bo && bo->tbo.base.resv == 
>>>>> vm->root.bo->tbo.base.resv &&
>>>>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>>>>               !before->bo_va->base.moved)
>>>>> amdgpu_vm_bo_moved(&before->bo_va->base);
>>>>>       } else {
>>>>> @@ -1957,7 +1955,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>>>>> amdgpu_device *adev,
>>>>>           if (after->flags & AMDGPU_PTE_PRT)
>>>>>               amdgpu_vm_prt_get(adev);
>>>>>   -        if (bo && bo->tbo.base.resv == 
>>>>> vm->root.bo->tbo.base.resv &&
>>>>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>>>>               !after->bo_va->base.moved)
>>>>> amdgpu_vm_bo_moved(&after->bo_va->base);
>>>>>       } else {
>>>>> @@ -2037,7 +2035,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device 
>>>>> *adev,
>>>>>         if (bo) {
>>>>>           dma_resv_assert_held(bo->tbo.base.resv);
>>>>> -        if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>>>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo))
>>>>>               ttm_bo_set_bulk_move(&bo->tbo, NULL);
>>>>>             for (base = &bo_va->base.bo->vm_bo; *base;
>>>>> @@ -2131,7 +2129,7 @@ void amdgpu_vm_bo_invalidate(struct 
>>>>> amdgpu_device *adev,
>>>>>       for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>>>>           struct amdgpu_vm *vm = bo_base->vm;
>>>>>   -        if (evicted && bo->tbo.base.resv == 
>>>>> vm->root.bo->tbo.base.resv) {
>>>>> +        if (evicted && amdgpu_vm_is_bo_always_valid(vm, bo)) {
>>>>>               amdgpu_vm_bo_evicted(bo_base);
>>>>>               continue;
>>>>>           }
>>>>> @@ -2142,7 +2140,7 @@ void amdgpu_vm_bo_invalidate(struct 
>>>>> amdgpu_device *adev,
>>>>>             if (bo->tbo.type == ttm_bo_type_kernel)
>>>>>               amdgpu_vm_bo_relocated(bo_base);
>>>>> -        else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>>>> +        else if (amdgpu_vm_is_bo_always_valid(vm, bo))
>>>>>               amdgpu_vm_bo_moved(bo_base);
>>>>>           else
>>>>>               amdgpu_vm_bo_invalidated(bo_base);
>>>>> @@ -3006,3 +3004,16 @@ void amdgpu_vm_update_fault_cache(struct 
>>>>> amdgpu_device *adev,
>>>>> xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>>>>   }
>>>>>   +/**
>>>>> + * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
>>>>> + *
>>>>> + * @vm: VM to test against.
>>>>> + * @abo: BO to be tested.
>>>>> + *
>>>>> + * Returns true if the BO shares the dma_resv object with the 
>>>>> root PD and is
>>>>> + * always guaranteed to be valid inside the VM.
>>>>> + */
>>>>> +bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct 
>>>>> amdgpu_bo *bo)
>>>>> +{
>>>>> +    return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 54d7da396de0..ec688a47dec1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -561,6 +561,8 @@ void amdgpu_debugfs_vm_bo_info(struct 
>>>>> amdgpu_vm *vm, struct seq_file *m);
>>>>>     int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct 
>>>>> amdgpu_vm *vm);
>>>>>   +bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct 
>>>>> amdgpu_bo *bo);
>>>>> +
>>>>>   /**
>>>>>    * amdgpu_vm_tlb_seq - return tlb flush sequence number
>>>>>    * @vm: the amdgpu_vm structure to query
>>>
>>>

