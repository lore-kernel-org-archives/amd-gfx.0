Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC3EC36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 21:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB50E10E4D9;
	Mon, 24 Mar 2025 21:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5OCukNRX";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CE510E363
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 21:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZtdBOz1OQSMjZPfKRpZwAusdQYNwvlFu9avKz7a4g+6ezGNq0Krikhgpbn7txBfb+/qRT1mdJCRKyr1n352vS1ZLaKzx8xIFPUsoXtHj7MrK3TXIMOYvbi/cL5kJDa8WQ77d+02NLD4GzdWEFIfptXsLVgRJfqxPEEHstMWAGMPHm8LNr09jKKGcodATwZiSLHPfhTKBM2rUH06XsTEWa3LUL9kPTKcENrdZK9ZDCoKHbtwFbhAEKYpbjEUF+uq3Yj4yw5j7RsRWEBAEGXMFARis7Fn00UVZtuwNdAc1sCxCv8n58vWmhzdCkaU2q/IuSCQ6FxK6U7bSrBxkFIAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDzTPu2yiH5M0DkFwviunrQd6+vNgoom5ao3LCStwOU=;
 b=J3NvQ8fMvVGbkqyyuJ66dOXKxskv/qZP35tZ9pqcV8uPHfm8OfaCDXUbPk0PhsIVQ22i4NOY+WkKwfzgaAGMBR8PwNGlv1lXAccmW09NpZyai5Wtl3A2IVv/84/q1QID1+N/MYkVAuve6ZAQ764j2zCewR3eZK1hypthayFpfP6KDOmMJ+5zgKrFuXVGT7E14RnoGfiOADMv+Ec7orO6mDV++sWyR415a/2vYqJOWk7ZN6OXLPyVXQqLjuDZ6MWl2WjyUpsklB+QYiqthoHAtqERcdCQhUNy9Mrs/b5kDBA3X5h8MjpN+V/VwUKkV8IS+9VfZwTl05lWn/rNiigiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDzTPu2yiH5M0DkFwviunrQd6+vNgoom5ao3LCStwOU=;
 b=5OCukNRXkvui773bvG6nfnkVhFdZT4al/3wtakVTy3w3sSDDmQmnwumuvWKWrtIxgIHpHJtuq/crh1ImHYJQqckuligA4DeXlpq1PFaWDhqpFQB4Ei/NkS6w7jXzj34mQJsOJ26sonEj+6/Lud+RYsspwJ/NBtDAERCTrMrfKdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 21:07:20 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 21:07:20 +0000
Message-ID: <e38a6e0a-34f1-45db-bebb-f260eba421ec@amd.com>
Date: Mon, 24 Mar 2025 17:07:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: increase max number of queues per process
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com
References: <20250324172540.128507-1-jinhuieric.huang@amd.com>
 <CADnq5_OKVowRi_ivnE4O0NDPLCW3RTq4LKM-1M86hUnDcbB8fQ@mail.gmail.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CADnq5_OKVowRi_ivnE4O0NDPLCW3RTq4LKM-1M86hUnDcbB8fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::22) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0bf85d-11b6-479b-38a8-08dd6b17dd68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFE3V09LK3ZiUjM4WkJuczNvWGtUSCtlbkxpd3FHbzQwczQxaFVDb3FPTHVE?=
 =?utf-8?B?Y3pDbWl0NGR3VFVaQnNWeUlXZjhYSW9qRVdzTlJaNXFPejExazdjMFc2RzlY?=
 =?utf-8?B?K08zOXUvUFZMekNYVDV0NmtQZnVjUjA5eUk0d0lEdStHayt1eXJ5TnlCZExD?=
 =?utf-8?B?UENjU1Z6Njd2WHc0TG9hZXVnam5uRVRvMWZzT3lZY2tTT0xucnJxbm82UlRB?=
 =?utf-8?B?c0RPbXpZT1k1UFN0dGZDSm0vc2U4L243VmtXekRmazVxdks4RkNGcXpPTlV5?=
 =?utf-8?B?bnJJemlaZElmTm44M0prcFVQR3VJOGVhT21MaGZXUFZRblhoTUhiS0MxQmlw?=
 =?utf-8?B?eXljNmVXTERoWkpQZkNIU1VYdUtGQ1JwUWRRbVdPenU3TDNnN2Q3Sm9ESXor?=
 =?utf-8?B?aWMzQTNjNlo2Q2hRVnpaVjJCamJZUEJZSE9YU0RPbTc4S2tWd0lFdmQwZmJC?=
 =?utf-8?B?UnRVbzlyWnRKVUp0Sy90Z08wbVhjaWFxcnlrL3Q3MjlmMldKTEJVTjJsWUpC?=
 =?utf-8?B?NmlhTHMvQ3VQNUVoN1BCaC8xb3N5aDdFdUJ2bnh0Q24xZlpCZEJSbEdxbzM0?=
 =?utf-8?B?amNFakc3MWJrMTVkbXJrM0YveVJ4cXZSS1RJbGM4QmcrU0dDMUN1KzYxamhX?=
 =?utf-8?B?R3ZtcXliYW5kN05JN2dxWEpnUU1ma0gwWkc3S1ZJV25SaUZzeUFFWThFMExX?=
 =?utf-8?B?UHhHWEI0T1VrSDZ0Y0tYVWlUQkdSTjZtZU9OamRxYlh5TEFqRk03WUJaK2pn?=
 =?utf-8?B?ZmFjYlFkRnU2RE9vSVNFN3YyV3NjK09CT0tiMTg3M0hyNnpSbElldWhSVjNp?=
 =?utf-8?B?Nzk2S1VzbHZiUE5oVzNGZk54L0JkcmxFWkliaDBsZXl2VlMwa0wvK1BqS29K?=
 =?utf-8?B?YkRSc2QzZ25Sc00rSDlSVDlSbVUzekdmZXFOSENaNWt5L0lKYzBHZitEeng0?=
 =?utf-8?B?aFFTeHZmYXZ5eHRkRWFpQmpNWUJLTmszM3ZHTVdXU1FQYk9zTXRidzQ1RTNv?=
 =?utf-8?B?K0dMU2FmbGJXTjJ4RmVuZlNLNEE2NXU0YnRjNEY3cWNUUFBBdDdEdmxySTZk?=
 =?utf-8?B?ZkIwcEpuS1Z0NFpQL2tLMENub3JWMDRJeHFrWlVUcGZRaTEra1RXM0lqZjJo?=
 =?utf-8?B?ZFRwL2Y3Zzg2b29hMDZPeVR0cXRtK1JRS3Yra01QdFlTNmRFUkZKRHhOditj?=
 =?utf-8?B?MHhON2dwNGIwZXIxdkVyMjFtajRtNngzbyt5U1FWK25oZWVQdlU0ZlVtUWVi?=
 =?utf-8?B?RHUyQ1dSTDB1RmEwclF5VUo0NUtiZUVLRGptY2NYajhES0hITDJGMm9RV0d3?=
 =?utf-8?B?bkFxWm5YVGRzTGJqVTRNb2thWWRIMEcrOWRaaEpFMmtWWWFLeTRDd1FScHV5?=
 =?utf-8?B?a0tUUHZ4eEZzUUlVUFdzSG9PSVNseGpPNnA5TnpsblBCc0ZIdS8zQXU2SjRl?=
 =?utf-8?B?RWNTV3B4M2p2NmZoRWI0YnBheG0rWHo2MVpESXptQWM2TzFlM2IrK20rOUxo?=
 =?utf-8?B?SW9hU2RicEl5OUpqSVVJc1V6Lzh6Y3I4dTVpQkorNk9uaDNiOGU2T2N6Skxt?=
 =?utf-8?B?QXI0OXM1aERvTXRscEFuMll0WE9GZHJsZGNGTEYyZXlPbWtZYk9oRkdtbUoz?=
 =?utf-8?B?SkxvbjNPKzRqakFSb0c4OU9BZ09IcVV6TS83djBzVlRCTUMxaGlQeTA3eG5p?=
 =?utf-8?B?OWNXK2RoWFVNT3RQTVZpVGhnS3VUVi95RUpoQmlnYXg5WEdzcWFBZElnaldG?=
 =?utf-8?B?bDJTOHFYa2g2UUdEeWlDMUdPOURqV3RpTDlHTW9MMXo3ZUVsMFFqbnBvbEJy?=
 =?utf-8?B?emRiSkRhLzV2M3M4SjZZSTRYRnIyNnp3MGJMZG9yWnJLNThxVDdZa0o5SXh2?=
 =?utf-8?Q?uinmV9wDb5InE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJiOS92djJTYTZzOXpPRU42Nkg1QnNmSDQ2Y1UrMFgvUG9wOHRFeWdPSWxo?=
 =?utf-8?B?N2prN0tBenpxcWd0eW1ZbE5keEFuaVRGTllHKzErVGl2QnhCRUw1MGlMeHht?=
 =?utf-8?B?WlVDNWlYYlpNVVBQVjN4SHJ1bnF4dWUxelUrRXhFTm9aSXBlMFVlN0JoMFJ2?=
 =?utf-8?B?aXkvaElsRWNlQWNNRnBYNDhBdlorRVpEYVl4Z1d6UVR4dkJJcHUybDU3MDkv?=
 =?utf-8?B?Uyt0TWZQMkRSQU1YMzJTS2UvZ21yang1T2Q2aDRDOWJ4TGl0VjRJMjdqYnFG?=
 =?utf-8?B?WVFjVDhrbmhRWWZXcTlpcVJ1Z0VCdHI2ZHhDSXV2MVlRWVBzN0p1MVgyM0Nl?=
 =?utf-8?B?TXRqWEZhNnltRDZEektBOVBJdzR5cml4R2RjV3pxMDBINndmaG14VUJKOFZK?=
 =?utf-8?B?LzkzN20vVVBscGF6NG1NT2I1WmVsNko3STk1dTQ1RSthdDdUREJ0YmFMUFVm?=
 =?utf-8?B?V2phTVg5ZDA4dzVFZ2ZhdHZ6ZUoyQkdzdjEwQ2FieWQ4WXJiSUNkazROSys4?=
 =?utf-8?B?OWEvNk9PWkNKM3MvSHhJVEVZTWEzWXFpcUdKbEtIbWZqWUppSExHYTNuRkNw?=
 =?utf-8?B?UkdwSGZicVVBUWhkUDQ2cXJETGNSWjBMT0pyNnV6MjN5eUUzRFM1NERwbUR3?=
 =?utf-8?B?UHcvM2tXY3hwUlBRMlJickxXZVB1T0xlREZIV051Y1hOYzBMdHpWeVBzLy9C?=
 =?utf-8?B?TXFOZzVlZjczUlVMdnVBQmtGUC80TzZLNGorblllNitJemk1SjBBNTc4L0Zi?=
 =?utf-8?B?VkFueVp5Y2QxM3NTOFFZL2RVeCsyRFNPM2JMMUtWVXp6MU1HTE1aNkJLOWN6?=
 =?utf-8?B?bmhFRXM1V0hEN1NWWVRMTmJualdJRUZYbEhJbUhBeWNYbXQ3MXI0M0xJaklw?=
 =?utf-8?B?bDFiSWF6Wk5zWmoyNUU1ZUtIUjd2bk92eTA5b1dKM0dZSHN3M2N0WWJVM0xB?=
 =?utf-8?B?S2Jlb0VtemFETHVKcVE4VzhLYmdaTnU4QytZMkRBYzhDWHRuY2EzOXZlNlJS?=
 =?utf-8?B?K2RPNjdMS1dTTGJQcW13LzFjZ3V4cmJRQ3VtM2lYazhobU5jMVN6emVLWXph?=
 =?utf-8?B?VGdoL3B2RVQwR3JUL1Z0NGVWSkZ2ZjlmOEk2YUZJV1I5MVJ2cmZtTFdvd0lo?=
 =?utf-8?B?ODJPM1grem1CL1UwYjFlZW5JaGtaWVhzZmw2K0I1VnRoRHBYZTE0blVPbkJQ?=
 =?utf-8?B?SVF6OXhERnVZcVArVUpqbzN1MzBFWlJvT292WVIzcm0zMnNuQ0hsVHhsUFJh?=
 =?utf-8?B?SWFlZGVteUdLbUtsbjU5V1ZjWmwwemUrTm5ybjBURXgveUthUkVsNXR1ZVgy?=
 =?utf-8?B?OUNmTE1Tb1FEZHg1Zk85YmY5aUxBTXNHcWZNV1UxcFMzK1NmVjk0V0ZLR1d0?=
 =?utf-8?B?VDRJZGVxemM0a1hWOGxqUVhUeW9qQjB1SktEMU1rUWFJNXh1Wlh0eDB3cDlC?=
 =?utf-8?B?ZlphSUx4UHJ3WGM1dXpuWmVvVlc1N0swNWNFS3dkS3JVcUhGeElyeDI2ams2?=
 =?utf-8?B?bVRDWDIxeWdCOGxteExQRDM2TVZ3bEtndDFQOEZ6RktJZUFoT0RSVG84RTR4?=
 =?utf-8?B?REFlMDd3YytsTVJEWEY2RHRwc2kxN1greitHUC9KckZKVHBoRk9BUWRMdHFV?=
 =?utf-8?B?QVV3UXBBcFBpb0dCNUdubWlHcnFySUR5ak9kL0F1ZVlKbHN3VWtSRGhjVmFH?=
 =?utf-8?B?L0Nwa2dWSWRvVG83TTM3QXN0amhzMnhhRGVSWGovSFVMZ2VzaU9BaEgrNHlV?=
 =?utf-8?B?OEZQOWdYREtRL1hZS3JRUHFEd2VpQWsrOHk0N1lubFhOVmFVSzJPTnBKdmg3?=
 =?utf-8?B?ZXlvT1ZNNG9xOTIzbVN4VDVFMWV6UjY1TkJTM05UVVVpd2N4YlpSaDNlTkJC?=
 =?utf-8?B?MmF3emZiVWJKaXZSMWhyRXJWbDQ2ZmtiaVlueFFxK1JEeTg1a1JFb0R6UTVX?=
 =?utf-8?B?QXVCVVdxM3VqL2tIZUNrYmMzdWZsMHNOSFJ0VUtiWDNZM1ZDUnplUXlzVjBp?=
 =?utf-8?B?SGJjdFF6NnRsNE5HZVM5TDFTNHdSVzIvU05adTQ1bkRoR21FZ3Rhd3hUVDhW?=
 =?utf-8?B?TDVDaWlwRWtKTlBvRCsxaHZLYVV4ZHpvWE1BOGNyWlZ1VjFsTnNaRkJDN3Ry?=
 =?utf-8?Q?hLu9O2YkOtZL7OtTY2Y+wI3ko?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0bf85d-11b6-479b-38a8-08dd6b17dd68
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 21:07:20.1510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzOH8pdDHPov4OUSP76khZdpbTHubddtU9RYGBHN+tZ6ZDuEEv5cNCzH2IkaH0/X3tWd43D8MDDDYAlCeojs5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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


On 2025-03-24 15:32, Alex Deucher wrote:
> On Mon, Mar 24, 2025 at 1:26 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
>> kfdtest KFDQMTest.OverSubscribeCpQueues with multiple
>> gpu mode fails on gfx v9.4.3+NPS4+CPX which has 64 gpu
>> nodes, the queues created are 65x64=4160, but the number
>> 1024 0f KFD_MAX_NUM_OF_QUEUES_PER_PROCESS is not enough
>> and test fails at function find_available_queue_slot().
>> So increasing the nubmer will make the test passed.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index f6aedf69c644..054a78207ffe 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -94,7 +94,7 @@
>>          ((typeof(ptr_to_struct)) kzalloc(sizeof(*ptr_to_struct), GFP_KERNEL))
>>
>>   #define KFD_MAX_NUM_OF_PROCESSES 512
>> -#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
>> +#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 4160
> Doesn't this limit have more to do with the number of doorbells you
> can fit into a 4K page?  If you only allocate 4K for doorbells how can
> you increase this?

The doorbells size is allocated dynamically as multiple pages based on 
KFD_MAX_NUM_OF_QUEUES_PER_PROCESS in KFD. Currently with 1024 of this 
macro 2 pages are allocated, and after changing to 4160, 9 pages will be 
allocated. Please refer in function kfd_allocate_process_doorbells().

Thanks,
Eric

>
> Alex
>
>>   /*
>>    * Size of the per-process TBA+TMA buffer: 2 pages
>> --
>> 2.34.1
>>

