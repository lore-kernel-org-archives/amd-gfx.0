Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EDCC3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 13:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857BB10E384;
	Wed, 24 Jul 2024 13:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Uxe0M+P";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B311610E384
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 13:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rx8UzsyFM8pON4mekMMltIVqF5Iq39MQ6wzx8LTgtFPdXlxPDO3CvkzLBRJBRZMaaaGVc0qFCyTDg/MAQwSD6wt+6ORTztQJ73u+p0ADBWdO7wFhHDm3Fop/tIR4jXV6y5hViozMi3ZYizZzkgdAIKvRK5M5Rge+MKir4gY6IkkTtPnoXb9zuUkZgnxFWl3R9GYZ/R+fQOfNHJ9VLXbFSSNE29FW+gDlWtih/c+/UWAnJTUnl0f5mUbM2193/6ZTPVdKvNOlRaseOzBC4Hwd70bvaarY5vUaELT4F3WgB7Aw6GJK0+xt4GIzJbV3PtdW6j0TaWD+WVj4yRXLKLluGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vGEfzDfuzwF9do9HwzetoscPW0uSUrJxVEZxzZ2+7k=;
 b=E9N46krNLqm9FHnHdgCOhBMYkAgatqIrGsR9hiG5D7/SEFSYuGI7maq5hWNjRRoLHUq8EwSPohCyc7vTuOg7/5vWNn6niIiIXgaD6NWTfTgtLv/EehRtwYCfmF+mU4cOco/+hAm8xOYSmFewK2mBD00XE7+gchFpCmvF8SY520CEmxW9UGF4Sn1lD9QHKKlWWIfSPiMXUW+y7KqBOgogAPRI7Jd9+ux9kdD/PkOi1nOrVhK7ihMj2vZP2/WRuEUIOZWwfzJWcPp2ZYacBl0vOsjZv9YwpfjU6RVkIBXeiYpEq2CHBPvfaa7j5knUZ+jwHrPB2hUEEoC4eQFBo2QrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vGEfzDfuzwF9do9HwzetoscPW0uSUrJxVEZxzZ2+7k=;
 b=4Uxe0M+PzgDCTkDI2iBOWdNH7XyQjyHJJVfx8nR0r85krgpMxun9yuxYBxIbbx535fDJ7H5R5BUkbkB1ZahnByTaIppdA6qGsDcjiekt3gG/Wj5WDrsf6hb3oqi1/GKlQdvNFoqMR4f7QdyDvoqv01A1fTxHb6szcxvMTXAtrj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 24 Jul
 2024 13:58:18 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 13:58:18 +0000
Content-Type: multipart/alternative;
 boundary="------------LYkOQCAUM9PzuiLEbOP4YMrz"
Message-ID: <054a813f-8310-466a-9fdc-a3be0cdc4ee8@amd.com>
Date: Wed, 24 Jul 2024 08:58:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Change kfd/svm page fault drain handling
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20240719221738.26840-1-xiaogang.chen@amd.com>
 <6b475d85-12ee-3732-4d96-05647374d773@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <6b475d85-12ee-3732-4d96-05647374d773@amd.com>
X-ClientProxiedBy: SN6PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:805:f2::36) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 995a4171-03e5-4d49-ee8c-08dcabe8aba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUk3R3FxOGQ5VHM1U3hTZjA2QXdUMXNFVmY5dHpMVHpjQ25VRkJnRk9qeGNG?=
 =?utf-8?B?S2ZLTVVmcVVzMmlpd2V2Zkg2Z3JCdkdVMWZ1QWYwUkJEUXY2dzFkU0R0YVJS?=
 =?utf-8?B?R0lwTWkxOFVNZ2YzUkNCOGJzdTQvVnFKOTRlbThCMkdYVVZTdDRXVGhWSGgx?=
 =?utf-8?B?aFpYZ2I1THhwYjFyekg3c1lCbkwxeGRqRklLMmcxZ2Uxem84ZmZVQjVFM25C?=
 =?utf-8?B?WXc3cC9saEFZd0hhNHRXQkRndmx2ako5c1kreithNS91b1YvUkxJa3NXTzRP?=
 =?utf-8?B?VWVtaHBBZlhMcEJtRjVXcDBvS00vSTBiVThzdkREdFB5M3VEWmRyb0FZbDE2?=
 =?utf-8?B?WXhFaGpFQTl0RlZWeVVqK3kyajVvTDZQS0FsNlZmTDkyY0lDdHArVkwyZ3lU?=
 =?utf-8?B?QzdkcE05anAyTDVtNlA5ZWc4UEtuSzVhaExVcWFWN2pjQlBvMi91UUtzRWV2?=
 =?utf-8?B?T1FETkppbWpjYldKTW5pRUxVTnZuQ2NpY1RaRHFRd0krUXp6ODJrT25SdFdn?=
 =?utf-8?B?Tmxvb3ZSRFppeUY4cHc3ZS81Y01zaG51TFlodHIzMVFsc0piK1pGbWJrY1FI?=
 =?utf-8?B?NFc5cDVjbTA1YjZIcTFTdmVnQ2E4VXd6V0E1ZGQxanFFaXlFb2UySlFHdndy?=
 =?utf-8?B?eW9nK1hTcnRHL3J2RllseC9aRXlQQ1dKVk1yWXJkeDlwdUNneFFDYmoxVVNK?=
 =?utf-8?B?UE10V2RCR3dBVk9WZlU1YWd5Nk4rWTFFeDBKUXJHRUhZRUp6RlM2cUp4UUl1?=
 =?utf-8?B?Y3c3Z1NBVStGNmJMTlZ6RUtnTTJCRzdCRWY5YWhjYVdOQ2hlV1c4LzNUQ1JP?=
 =?utf-8?B?amVqdWdqL1hTc3A3aXh0UDcwQTh3Wk92T2l5clNJaFJCNTFlalZjTGUrdzVq?=
 =?utf-8?B?TTB5RVZrTXhyYXhvVzA4MkpIM0svbG1RVUxudE52QnI4OTFqUGlpN2RueXpY?=
 =?utf-8?B?bTEzOXVBWXpJTGVwU1Q4NFJBb3ErOStxazBvYWdwUE92Mnd2a0tTb1M0RDlY?=
 =?utf-8?B?TnpkM2RaVTM2d01oS2U2K2FBdFJYaGdlMGFQa2RIRE5INXg3b05qQjFVV2Uv?=
 =?utf-8?B?eEpEVG5Fb3cvbHBEL0NtRGJKcHZSTDM2NHd2UzFrYTRGUE5sU0Q2a3d3QVhy?=
 =?utf-8?B?Wm5FOHAreHZNeDdVZm5PVDJCYWZ1VGNYbmxQalY3dFlTVjZBdzlIWlhnV2VY?=
 =?utf-8?B?UkxiVDZCYi9wNy9weGpTVWY4eWlwUjlONUY2K2ljK3Y2TkJ6K2JjazdBRWdE?=
 =?utf-8?B?Y1U5bWc2OGJvaUsyRUU4R0FaR1pnMXJVSThIQVZ4MXMvTVVZNHRGZWZER3Va?=
 =?utf-8?B?ZDlqbFkxbmtJREVYbGl5cFZROGFqNnZ5NnNrWnlGa1Q1Ky9lUWZXY0U1SnA5?=
 =?utf-8?B?U1VpYURTSDhnTTVpTGJDVS95RGkrUmhocWk1MHZqMkk3YUJRZFZiRVZQVWxM?=
 =?utf-8?B?b2tieW5nTE1GbFl4U0s4RFhyaktDWnV6SHRyRVoyZlQ2SE9QT3FnNERybkYy?=
 =?utf-8?B?bXdaMDFFVmhJZFZSV015WG1TTmN2b1FXNDhvTWJzYXNwWnI2QzVmeE9PZkov?=
 =?utf-8?B?T1ZjbjFwOXRSbGhkenNUSUxmLzJpK0pqZERZblVrcnVUNk1XWG5aaHZUOEgv?=
 =?utf-8?B?M0p3Q0tQMjZBNmoxQVNXdmp1VVBVbjl3WWJlR3RBZmRObDNDZDRGU0liSlF1?=
 =?utf-8?B?dmk3S1djSFgxaFdSZUR0aHJtWmZzb0FkcTRjWFNmVVljMTQzNXFlT1RsQjB5?=
 =?utf-8?B?MXRVNDI3OFhzdldnclkrYlJFNDhwQUFmdWVVeUlxTzhaeGdYellDUW8wUnI5?=
 =?utf-8?B?eElQbXV3MnlESmZMdW5sUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZLZTNzbmZHV1BCZGp6cXVDU2FJWEF0MVhnKzhWYlFmMkF2TExSUnFHUjI3?=
 =?utf-8?B?SjNXelV5OGdMQlYyU0dycXBsVTNLZlBtTU8reUZjT2xkUVFCZCtyUU9CNEhD?=
 =?utf-8?B?ZU9GRUo4am9VK1Y3OCszN3BwNGhQOS9KNHZHWVFrZHNndDhmZVg5YmdITlpj?=
 =?utf-8?B?MTZmYWNWVHU3Nk5KbzVaM3NzcTBVbll2OUJjcU0zQjJJdk1FM3pxWUp5SjVu?=
 =?utf-8?B?NU9IZXhFblVWTzh6VU5FTFY0SG1lS0VvNmYvWUdzU2psMW0rTUxVdkJJbHAx?=
 =?utf-8?B?V2ZEVlVjUjZCYmlQTDgxZ2g2cDhna21Ud3RtSWZPVzQ4aWlEc1E1cjhDTkZz?=
 =?utf-8?B?ZWtTOEEzUGNCb0k5ZjJnQ0ROV0dYYjZCOVJ3dHVGTStIQ0UwNUw3cUZsdEQ5?=
 =?utf-8?B?enNDWXhPZExWRXJRZE4vRmYva21DT0RtT2JRS05wcWgwZVJmNUZZY1VRK1Rp?=
 =?utf-8?B?ZEk3L1ZSNVF3ZG1RcnpMSGpaZGJBdGwyaGtVbzFML0taVjZzN2s0TzV4YXBY?=
 =?utf-8?B?bUU0bXF6R1Npd3h2dHpYdkZWalpYY013akVGVlBoajBuaTczZGdmd3ozcVlk?=
 =?utf-8?B?Y1ltVWRTdElWVnJJSFF4cVhtWUNlbkVZSkgwa09lWnBLYU5ZWGxIRTREZnNz?=
 =?utf-8?B?dUY2Y1g4cGJkUWtDTGFZYUtQV0lvZ2dlRDZYK3VrUzE4UFAyTjRJamlXemM1?=
 =?utf-8?B?WkNwNUVQS3Y4bUZTTU9WNE54S3NrU25jTkRjNzVMc0RaTGc5bE1URDVta3cz?=
 =?utf-8?B?YThUc1prcnVEQm1RUEdNRE5PeThOSXAwNkdTSlVTWTBKcGhYRy81K2FLV0NC?=
 =?utf-8?B?a3VxYzU4VmRNcjAvbSs2d1M5c2tuVmd0VVByU1VpcEtqUjhoRUJRZGJvcVNM?=
 =?utf-8?B?VHdLUWJRNXRBV2tSdGRwd205aDFhMCtZQm1VYlVWV2ZpRzRWK2tEZTFYMFdY?=
 =?utf-8?B?WjRtNGl1dXBYRmUrVFBsMWhIMVp4U3NLM0VUMEdyQ0p1QWxBSjM0UUlGZFh5?=
 =?utf-8?B?VldRcEdMOUdYeUxLN21GU0NDdVdHeUxpRHV3ZlkyRWdNVmM5dVhQbW9HL28r?=
 =?utf-8?B?VjVWd1VVamMvU3pzM1crZWRzcmtvdmtZU2FwdVVudUh4MFF6c2ZhT2I0YXdE?=
 =?utf-8?B?c2lSYjNnWW1VY1hWZjYzbUNNV2Ewd2VwM1JrWTFKRmRaWmwvYTVad0c0V0RS?=
 =?utf-8?B?S1VTWStuS0hrQ3ZWQXlTYmIvdXYzd0NESGtLaituOEtpckZ6QnQ3cG5vWnU4?=
 =?utf-8?B?anR4WkhsU3RaaEJOWU4wTFBYczdTTEVOMHFWZzlCYnFtTkpOUHl5eVp4eTZ3?=
 =?utf-8?B?S2c3L01CZUdoaDdxRzkvakMxSUoyT0dodEZCM1oyYmN2ejF5SHhWa0R4d290?=
 =?utf-8?B?NDh1aTNwbHZwZmw5T0J6SUZjTFMvV280SGNmeVZPZHhsMDQ4cUducldQRmNM?=
 =?utf-8?B?RnJlSURKcStEYzBzNG1nUlNGbnlzbkJhcm9heUN4T09GeTZkeldOZExqbzV2?=
 =?utf-8?B?RUZPSDZSWEFmS0xlcjJCcEE4czRuVi9SNCsvQzg0Y0UrRTBSdDFGM0lZaDg5?=
 =?utf-8?B?QVQ5dHRIRitzcS9VZVZKNk04ZEdnRDBZcUZVY1hvYmJMckh5OU1iTHF5TDdS?=
 =?utf-8?B?Z0FVTjlCb1BSWDBxa1ZKK212RW1kVUcweHZjMG96aVRid1g3ZlhlVHB0dklz?=
 =?utf-8?B?NUloTWtVanJscjlLcVVFVldOdEVyTXB3a3JnTW43OHZWWHNaVnMrRE5ueHVD?=
 =?utf-8?B?bzdOdDdBL21lanhtMVlTVmovaVdvQTNxNWpCaUhXZXVPQnllei8wQzQ0NWY2?=
 =?utf-8?B?NzViNGhwTS9QNTZLWU1NZVNZM0I5UjZwVzZtS1crZ255cG5PWnhBejVUVlNh?=
 =?utf-8?B?YVQreTdLb1l2dE56Vld1dkxiYTJ3dURjaERuTmEwY3ZtSnk2bUVQaCtjSTRH?=
 =?utf-8?B?QWszNmVXN0Y0cXB0SWtSKy9JZHEvWkhaY245L2EyeVpqUGxwWTNPcytKZXBs?=
 =?utf-8?B?dzBKTnA0NXNuVjI2d2lMb0pQVTdzSWhkVEY1bXBCanlYK21QN01HY1VGTk91?=
 =?utf-8?B?ODB2ZTlpTXNad1o5aFRVOWp0aEZUZVY5cEVXaHdWN1p6VlRYZjZCV3VWTngz?=
 =?utf-8?Q?3Gbg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a4171-03e5-4d49-ee8c-08dcabe8aba6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 13:58:18.2145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIuqFGqbEhxjfcm0X6EvGZ/V0It12HBZCneTYTYLTsytUzlsao3qodE6Iw9bZT62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
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

--------------LYkOQCAUM9PzuiLEbOP4YMrz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/23/2024 4:02 PM, Philip Yang wrote:
>
>
> On 2024-07-19 18:17, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
>> not handle any incoming pages fault of this process until a deferred work item
>> got executed by default system wq. The time period of "not handle page fault"
>> can be long and is unpredicable. That is advese to kfd performance on page
>> faults recovery.
>>
>> This patch uses time stamp of incoming page page to decide to drop or handle
>> page fault. When app unmap vm ranges kfd records each gpu device's ih ring
>> current time stamp. These time stamps are used at kfd page fault recovery
>> routine.
>>
>> Any page fault happens on unmapped ranges after unmap events is app bug that
>> accesses vm range after unmap. It is not driver work to cover that.
>>
>> By using time stamp of page fault do not need drain page faults at deferred
>> work. So, the time period that kfd does not handle page faults is reduced
>> and can be controlled.
> This simplify the retry fault draining and support the multiple 
> processes correctly now, some nitpick below.
>> Signed-off-by: Xiaogang.Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 111 +++++++++++++++++--------
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
>>   7 files changed, 88 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 3abfa66d72a2..d90b7ea3f020 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>    * shouldn't be reported any more.
>>    */
>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>> -			    u32 vmid, u32 node_id, uint64_t addr,
>> +			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
>>   			    bool write_fault)
>>   {
>>   	bool is_compute_context = false;
>> @@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>   	addr /= AMDGPU_GPU_PAGE_SIZE;
>>   
>>   	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
>> -	    node_id, addr, write_fault)) {
>> +	    node_id, addr, ts, write_fault)) {
>>   		amdgpu_bo_unref(&root);
>>   		return true;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 312a408b80d3..1d6a1381ede9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
>>   void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
>>   
>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>> -			    u32 vmid, u32 node_id, uint64_t addr,
>> +			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
>>   			    bool write_fault);
>>   
>>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index d933e19e0cf5..5cceaba6e5c4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>>   		/* Try to handle the recoverable page faults by filling page
>>   		 * tables
>>   		 */
>> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault))
>> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
>> +								   entry->timestamp, write_fault))
> indent should align to the start bracket.
ok.
>>   			return 1;
>>   	}
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 350f6b6676f1..ac08d9424feb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>>   			cam_index = entry->src_data[2] & 0x3ff;
>>   
>>   			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
>> -						     addr, write_fault);
>> +						     addr, entry->timestamp, write_fault);
>>   			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
>>   			if (ret)
>>   				return 1;
>> @@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>>   			 * tables
>>   			 */
>>   			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
>> -						   addr, write_fault))
>> +						   addr, entry->timestamp, write_fault))
>>   				return 1;
>>   		}
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index c51e908f6f19..8b8d5ab9da76 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -850,10 +850,13 @@ struct svm_range_list {
>>   	struct list_head                criu_svm_metadata_list;
>>   	spinlock_t			deferred_list_lock;
>>   	atomic_t			evicted_ranges;
>> -	atomic_t			drain_pagefaults;
>> +	/* stop page fault recovery for this process */
>> +	atomic_t			stop_pf_recovery;
> This flag seems redundant, as timestamp is 48bit increasing and 
> amdgpu_ih_ts_after handle the wrap around, so always use timestamp to 
> drop retry fault.

This flag notifies page fault restore routine to not process page fault 
for this process. It is used here when getting current time stamp at 
each gpu's IH ring, then unset it. To make sure page fault will not be 
processed during time period when get current time stamps, though it is 
very short.

And this flag maybe used in future for general purpose that we need stop 
process page fault recovery for some reasons.

>>   	struct delayed_work		restore_work;
>>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>>   	struct task_struct		*faulting_task;
>> +	/* check point ts decides if page fault recovery need be dropped */
>> +	uint64_t				checkpoint_ts[MAX_GPU_INSTANCE];
> I think it is safe to not use atomic64_t.
not sure what you mean here: you do not want use uint64_4, or 
atomic64_4? I use unit64_4 here. And as you mention below, will use 
WRITE_ONCE/READ_ONCE on svms->checkpoint_ts[i].
>>   };
>>   
>>   /* Process data */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 407636a68814..9dd28d06ea2a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>>   {
>>   	struct kfd_process_device *pdd;
>>   	struct kfd_process *p;
>> -	int drain;
>>   	uint32_t i;
>>   
>>   	p = container_of(svms, struct kfd_process, svms);
>>   
>> -restart:
>> -	drain = atomic_read(&svms->drain_pagefaults);
>> -	if (!drain)
>> -		return;
>> -
>>   	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>>   		pdd = p->pdds[i];
>>   		if (!pdd)
>> @@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>>   
>>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>>   	}
>> -	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
>> -		goto restart;
>>   }
>>   
>>   static void svm_range_deferred_list_work(struct work_struct *work)
>> @@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>>   			 prange->start, prange->last, prange->work_item.op);
>>   
>>   		mm = prange->work_item.mm;
>> -retry:
>> -		mmap_write_lock(mm);
>>   
>> -		/* Checking for the need to drain retry faults must be inside
>> -		 * mmap write lock to serialize with munmap notifiers.
>> -		 */
>> -		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
>> -			mmap_write_unlock(mm);
>> -			svm_range_drain_retry_fault(svms);
>> -			goto retry;
>> -		}
>> +		mmap_write_lock(mm);
>>   
>>   		/* Remove from deferred_list must be inside mmap write lock, for
>>   		 * two race cases:
>> @@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>>   	struct kfd_process *p;
>>   	unsigned long s, l;
>>   	bool unmap_parent;
>> +	uint32_t i;
>>   
>>   	p = kfd_lookup_process_by_mm(mm);
>>   	if (!p)
>> @@ -2455,11 +2439,49 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
>>   		 prange, prange->start, prange->last, start, last);
>>   
>> -	/* Make sure pending page faults are drained in the deferred worker
>> -	 * before the range is freed to avoid straggler interrupts on
>> -	 * unmapped memory causing "phantom faults".
>> +	/* first stop kfd page fault handling for this process */
>> +	atomic_set(&svms->stop_pf_recovery, 1);
> this flag is not needed.
As above, this flag used here to not process page fault during time 
period that get current time stamp of each gpu IH ring.
>> +	/* calculate time stamps that are used to decide which page faults need be
>> +	 * dropped or handled before unmap pages from gpu vm
>>   	 */
>> -	atomic_inc(&svms->drain_pagefaults);
>> +	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>> +		struct kfd_process_device *pdd;
>> +		struct amdgpu_device *adev;
>> +		struct amdgpu_ih_ring *ih;
>> +		uint32_t checkpoint_wptr;
>> +		uint64_t checkpoint_ts = 0;
>> +
>> +		svms->checkpoint_ts[i] = 0;
> don't reset it to zero.
ok
>> +		pdd = p->pdds[i];
>> +		if (!pdd)
>> +			continue;
>> +
>> +		adev = pdd->dev->adev;
>> +		ih = adev->irq.retry_cam_enabled ? &adev->irq.ih : &adev->irq.ih1;
>> +		if (!ih->enabled || adev->shutdown)
>> +			continue;
>> +
>> +		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> +		/* Order wptr with ring data. */
>> +		rmb();
>> +		checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
>> +
>> +		if (adev->irq.retry_cam_enabled) {
>> +			ih = &adev->irq.ih_soft;
>> +
>> +			if (!ih->enabled || adev->shutdown)
>> +				continue;
> this check can be removed.
ok
>> +
>> +			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> +			rmb();
>> +			checkpoint_ts = max(checkpoint_ts,
>> +						amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
>> +		}
>> +		svms->checkpoint_ts[i] = checkpoint_ts;
> WRITE_ONCE(svms->checkpoint_ts[i], checkpoint_ts);
> Use WRITE_ONCE here and restore_page use READ_ONCE to sync up the 
> timestamp update.
ok
>> +	}
>> +	/* resume kfd page fault handing with time stamp checking */
>> +	atomic_set(&svms->stop_pf_recovery, 0);
>>   
>>   	unmap_parent = start <= prange->start && last >= prange->last;
>>   
>> @@ -2900,7 +2922,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
>>   int
>>   svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   			uint32_t vmid, uint32_t node_id,
>> -			uint64_t addr, bool write_fault)
>> +			uint64_t addr, uint64_t ts, bool write_fault)
>>   {
>>   	unsigned long start, last, size;
>>   	struct mm_struct *mm = NULL;
>> @@ -2910,7 +2932,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   	ktime_t timestamp = ktime_get_boottime();
>>   	struct kfd_node *node;
>>   	int32_t best_loc;
>> -	int32_t gpuidx = MAX_GPU_INSTANCE;
>> +	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
>>   	bool write_locked = false;
>>   	struct vm_area_struct *vma;
>>   	bool migration = false;
>> @@ -2930,7 +2952,29 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   
>>   	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
>>   
>> -	if (atomic_read(&svms->drain_pagefaults)) {
>> +	/* kfd page fault recovery is disabled */
>> +	if (atomic_read(&svms->stop_pf_recovery)) {
>> +		pr_debug("page fault handing disabled, drop fault 0x%llx\n", addr);
>> +		r = 0;
>> +		goto out;
>> +	}
>> +
>> +	node = kfd_node_by_irq_ids(adev, node_id, vmid);
>> +	if (!node) {
>> +		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
>> +			 vmid);
>> +		r = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx)) {
>> +		pr_debug("failed to get gpuid/gpuidex for node_id: %d \n", node_id);
>> +		r = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	/* check if this page fault time stamp is before svms->checkpoint_ts */
>> +	if (amdgpu_ih_ts_after(ts, svms->checkpoint_ts[gpuidx])) {
> if (amdgpu_ih_ts_after(ts, READ_ONCE(svms->checkpoint_ts[gpuidx]))) {
>>   		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>>   		r = 0;
>>   		goto out;
>> @@ -2952,13 +2996,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   		goto out;
>>   	}
>>   
>> -	node = kfd_node_by_irq_ids(adev, node_id, vmid);
>> -	if (!node) {
>> -		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
>> -			 vmid);
>> -		r = -EFAULT;
>> -		goto out;
>> -	}
>>   	mmap_read_lock(mm);
>>   retry_write_locked:
>>   	mutex_lock(&svms->lock);
>> @@ -3173,9 +3210,11 @@ void svm_range_list_fini(struct kfd_process *p)
>>   	/*
>>   	 * Ensure no retry fault comes in afterwards, as page fault handler will
>>   	 * not find kfd process and take mm lock to recover fault.
>> +	 * stop kfd page fault handing, then wait pending page faults got drained
>>   	 */
>> -	atomic_inc(&p->svms.drain_pagefaults);
>> +	atomic_set(&p->svms.stop_pf_recovery, 1);
>>   	svm_range_drain_retry_fault(&p->svms);
>> +	atomic_set(&p->svms.stop_pf_recovery, 0);
>>   
>>   	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>>   		svm_range_unlink(prange);
>> @@ -3197,16 +3236,18 @@ int svm_range_list_init(struct kfd_process *p)
>>   	mutex_init(&svms->lock);
>>   	INIT_LIST_HEAD(&svms->list);
>>   	atomic_set(&svms->evicted_ranges, 0);
>> -	atomic_set(&svms->drain_pagefaults, 0);
>> +	atomic_set(&svms->stop_pf_recovery, 0);
>>   	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
>>   	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
>>   	INIT_LIST_HEAD(&svms->deferred_range_list);
>>   	INIT_LIST_HEAD(&svms->criu_svm_metadata_list);
>>   	spin_lock_init(&svms->deferred_list_lock);
>>   
>> -	for (i = 0; i < p->n_pdds; i++)
>> +	for (i = 0; i < p->n_pdds; i++) {
>> +		svms->checkpoint_ts[i] = 0;
>
> not need to init 0 as kfd_process structure is from kzalloc.
>
ok

Regards

Xiaogang

> Regards,
>
> Philip
>
>>   		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>>   			bitmap_set(svms->bitmap_supported, i, 1);
>> +	}
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index 70c1776611c4..5f447c3642cb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>>   			    bool clear);
>>   void svm_range_vram_node_free(struct svm_range *prange);
>>   int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>> -			    uint32_t vmid, uint32_t node_id, uint64_t addr,
>> +			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
>>   			    bool write_fault);
>>   int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
>>   void svm_range_add_list_work(struct svm_range_list *svms,
--------------LYkOQCAUM9PzuiLEbOP4YMrz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/23/2024 4:02 PM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2024-07-19 18:17, Xiaogang.Chen
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com" moz-do-not-send="true">&lt;xiaogang.chen@amd.com&gt;</a>

When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
not handle any incoming pages fault of this process until a deferred work item
got executed by default system wq. The time period of &quot;not handle page fault&quot;
can be long and is unpredicable. That is advese to kfd performance on page
faults recovery.

This patch uses time stamp of incoming page page to decide to drop or handle
page fault. When app unmap vm ranges kfd records each gpu device's ih ring
current time stamp. These time stamps are used at kfd page fault recovery
routine.

Any page fault happens on unmapped ranges after unmap events is app bug that
accesses vm range after unmap. It is not driver work to cover that.

By using time stamp of page fault do not need drain page faults at deferred
work. So, the time period that kfd does not handle page faults is reduced
and can be controlled.</pre>
      </blockquote>
      This simplify the retry fault draining and support the multiple
      processes correctly now, some nitpick below.<br>
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Xiaogang.Chen <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 111 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
 7 files changed, 88 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..d90b7ea3f020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context &amp;&amp; !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&amp;root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 312a408b80d3..1d6a1381ede9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..5cceaba6e5c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, 0, 0, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, 0, 0, addr,
+								   entry-&gt;timestamp, write_fault))</pre>
      </blockquote>
      indent should align to the start bracket.<br>
    </blockquote>
    ok.<br>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap=""> 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 350f6b6676f1..ac08d9424feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			cam_index = entry-&gt;src_data[2] &amp; 0x3ff;
 
 			ret = amdgpu_vm_handle_fault(adev, entry-&gt;pasid, entry-&gt;vmid, node_id,
-						     addr, write_fault);
+						     addr, entry-&gt;timestamp, write_fault);
 			WDOORBELL32(adev-&gt;irq.retry_cam_doorbell_index, cam_index);
 			if (ret)
 				return 1;
@@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			 * tables
 			 */
 			if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, entry-&gt;vmid, node_id,
-						   addr, write_fault))
+						   addr, entry-&gt;timestamp, write_fault))
 				return 1;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c51e908f6f19..8b8d5ab9da76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -850,10 +850,13 @@ struct svm_range_list {
 	struct list_head                criu_svm_metadata_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
-	atomic_t			drain_pagefaults;
+	/* stop page fault recovery for this process */
+	atomic_t			stop_pf_recovery;</pre>
      </blockquote>
      This flag seems redundant, as timestamp is 48bit increasing and
      amdgpu_ih_ts_after handle the wrap around, so always use timestamp
      to drop retry fault. <br>
    </blockquote>
    <p>This flag notifies page fault restore routine to not process page
      fault for this process. It is used here when getting current time
      stamp at each gpu's IH ring, then unset it. To make sure page
      fault will not be processed during time period when get current
      time stamps, though it is very short.<br>
    </p>
    <p>And this flag maybe used in future for general purpose that we
      need stop process page fault recovery for some reasons. <br>
    </p>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t				checkpoint_ts[MAX_GPU_INSTANCE];</pre>
      </blockquote>
      I think it is safe to not use atomic64_t.<br>
    </blockquote>
    not sure what you mean here: you do not want use uint64_4, or
    atomic64_4? I use unit64_4 here. And as you mention below, will use
    <span style="white-space: pre-wrap">WRITE_ONCE/READ_ONCE  on svms-&gt;checkpoint_ts[i].</span>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap=""> };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..9dd28d06ea2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p;
-	int drain;
 	uint32_t i;
 
 	p = container_of(svms, struct kfd_process, svms);
 
-restart:
-	drain = atomic_read(&amp;svms-&gt;drain_pagefaults);
-	if (!drain)
-		return;
-
 	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
 		pdd = p-&gt;pdds[i];
 		if (!pdd)
@@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;, i, svms);
 	}
-	if (atomic_cmpxchg(&amp;svms-&gt;drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			 prange-&gt;start, prange-&gt;last, prange-&gt;work_item.op);
 
 		mm = prange-&gt;work_item.mm;
-retry:
-		mmap_write_lock(mm);
 
-		/* Checking for the need to drain retry faults must be inside
-		 * mmap write lock to serialize with munmap notifiers.
-		 */
-		if (unlikely(atomic_read(&amp;svms-&gt;drain_pagefaults))) {
-			mmap_write_unlock(mm);
-			svm_range_drain_retry_fault(svms);
-			goto retry;
-		}
+		mmap_write_lock(mm);
 
 		/* Remove from deferred_list must be inside mmap write lock, for
 		 * two race cases:
@@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
@@ -2455,11 +2439,49 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n&quot;, svms,
 		 prange, prange-&gt;start, prange-&gt;last, start, last);
 
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing &quot;phantom faults&quot;.
+	/* first stop kfd page fault handling for this process */
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 1);</pre>
      </blockquote>
      this flag is not needed.<br>
    </blockquote>
    As above, this flag used here to not process page fault during time
    period that get current time stamp of each gpu IH ring.<br>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
 	 */
-	atomic_inc(&amp;svms-&gt;drain_pagefaults);
+	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+		uint64_t checkpoint_ts = 0;
+
+		svms-&gt;checkpoint_ts[i] = 0;</pre>
      </blockquote>
      don't reset it to zero.<br>
    </blockquote>
    ok<br>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">+		pdd = p-&gt;pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd-&gt;dev-&gt;adev;
+		ih = adev-&gt;irq.retry_cam_enabled ? &amp;adev-&gt;irq.ih : &amp;adev-&gt;irq.ih1;
+		if (!ih-&gt;enabled || adev-&gt;shutdown)
+			continue;
+
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		/* Order wptr with ring data. */
+		rmb();
+		checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+
+		if (adev-&gt;irq.retry_cam_enabled) {
+			ih = &amp;adev-&gt;irq.ih_soft;
+
+			if (!ih-&gt;enabled || adev-&gt;shutdown)
+				continue;</pre>
      </blockquote>
      this check can be removed.<br>
    </blockquote>
    ok<br>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">+
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			rmb();
+			checkpoint_ts = max(checkpoint_ts,
+						amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+		}
+		svms-&gt;checkpoint_ts[i] = checkpoint_ts;</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">WRITE_ONCE(svms-&gt;checkpoint_ts[i], checkpoint_ts);</pre>
      Use WRITE_ONCE here and restore_page use READ_ONCE to sync up the
      timestamp update. <br>
    </blockquote>
    ok<br>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">+	}
+	/* resume kfd page fault handing with time stamp checking */
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 0);
 
 	unmap_parent = start &lt;= prange-&gt;start &amp;&amp; last &gt;= prange-&gt;last;
 
@@ -2900,7 +2922,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2910,7 +2932,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2930,7 +2952,29 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug(&quot;restoring svms 0x%p fault address 0x%llx\n&quot;, svms, addr);
 
-	if (atomic_read(&amp;svms-&gt;drain_pagefaults)) {
+	/* kfd page fault recovery is disabled */
+	if (atomic_read(&amp;svms-&gt;stop_pf_recovery)) {
+		pr_debug(&quot;page fault handing disabled, drop fault 0x%llx\n&quot;, addr);
+		r = 0;
+		goto out;
+	}
+
+	node = kfd_node_by_irq_ids(adev, node_id, vmid);
+	if (!node) {
+		pr_debug(&quot;kfd node does not exist node_id: %d, vmid: %d\n&quot;, node_id,
+			 vmid);
+		r = -EFAULT;
+		goto out;
+	}
+
+	if (kfd_process_gpuid_from_node(p, node, &amp;gpuid, &amp;gpuidx)) {
+		pr_debug(&quot;failed to get gpuid/gpuidex for node_id: %d \n&quot;, node_id);
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* check if this page fault time stamp is before svms-&gt;checkpoint_ts */
+	if (amdgpu_ih_ts_after(ts, svms-&gt;checkpoint_ts[gpuidx])) {</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">if (amdgpu_ih_ts_after(ts, READ_ONCE(svms-&gt;checkpoint_ts[gpuidx]))) {</pre>
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap=""> 		pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
 		r = 0;
 		goto out;
@@ -2952,13 +2996,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	node = kfd_node_by_irq_ids(adev, node_id, vmid);
-	if (!node) {
-		pr_debug(&quot;kfd node does not exist node_id: %d, vmid: %d\n&quot;, node_id,
-			 vmid);
-		r = -EFAULT;
-		goto out;
-	}
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&amp;svms-&gt;lock);
@@ -3173,9 +3210,11 @@ void svm_range_list_fini(struct kfd_process *p)
 	/*
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
+	 * stop kfd page fault handing, then wait pending page faults got drained
 	 */
-	atomic_inc(&amp;p-&gt;svms.drain_pagefaults);
+	atomic_set(&amp;p-&gt;svms.stop_pf_recovery, 1);
 	svm_range_drain_retry_fault(&amp;p-&gt;svms);
+	atomic_set(&amp;p-&gt;svms.stop_pf_recovery, 0);
 
 	list_for_each_entry_safe(prange, next, &amp;p-&gt;svms.list, list) {
 		svm_range_unlink(prange);
@@ -3197,16 +3236,18 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&amp;svms-&gt;lock);
 	INIT_LIST_HEAD(&amp;svms-&gt;list);
 	atomic_set(&amp;svms-&gt;evicted_ranges, 0);
-	atomic_set(&amp;svms-&gt;drain_pagefaults, 0);
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 0);
 	INIT_DELAYED_WORK(&amp;svms-&gt;restore_work, svm_range_restore_work);
 	INIT_WORK(&amp;svms-&gt;deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&amp;svms-&gt;deferred_range_list);
 	INIT_LIST_HEAD(&amp;svms-&gt;criu_svm_metadata_list);
 	spin_lock_init(&amp;svms-&gt;deferred_list_lock);
 
-	for (i = 0; i &lt; p-&gt;n_pdds; i++)
+	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+		svms-&gt;checkpoint_ts[i] = 0;</pre>
      </blockquote>
      <p>not need to init 0 as kfd_process structure is from kzalloc.</p>
    </blockquote>
    <p>ok</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
      <p>Regards,</p>
      <p>Philip<br>
      </p>
      <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap=""> 		if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
 			bitmap_set(svms-&gt;bitmap_supported, i, 1);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 70c1776611c4..5f447c3642cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t vmid, uint32_t node_id, uint64_t addr,
+			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------LYkOQCAUM9PzuiLEbOP4YMrz--
