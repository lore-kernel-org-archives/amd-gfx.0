Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AFDCD484D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 14:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F24210E7DD;
	Wed,  4 Sep 2024 14:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SvJ6Ttgx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9B410E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 14:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwaAWvlhTr/FV/sHgUNE3cB5LWzhIuE7SZa3v2uCKdao+CCTNaMSpIicb4Puo9AF5iN+EkXjNT8n93ht93uOiOzIkUE0+0zylsYggpC2MBTu5Z8UG0j3+IiqZTqmQZRIJS1BvSWJQD0QUXGNOQ2K9icKsHLvtOPgBccT5IpB3sFLf5OOSwxU6vaLnNVjyUWVuB/V5xk4IwPkA1CBq8QHNBF/NZ8n5dkR0pxq39mAyMdVQvrOdXgQTvhHHA5KxK5DPANdK4JK/HrdLYdiRrK85tQmC14m/eeCaI3odsJJ4NynFM/jMHaYmfM1/p39Z9+YezR10pr9SAjvvxiagSTr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAuSWAb0cSGq9G95WttfNwk49ff0GNSebj66wGirCXM=;
 b=tAlO5dU7ZnLftGkwagPvFy2h9llxBlVqKCqW17SQLkByRQsXw10DqOYsrls9GaUJFxxw+iRBP8GwnLDOH7OTI5/LHaM33ORlQ8eEJInlT5WvyEzEHOFhhoNd4lHdd8+KnQMl1bxvb/ouvn9MBTNmh1rfqLxnySPp0uVezSZD7KSBNG/KApQtupahgKlj7SH9aNjQFRK8JuS5p5JilRxasSZTJ1XzgvkFDY73hkcsSF4wW4b643YFKA8Z4FWlCNb/J8rU0Z9wuxfLhnVPGNcUG17Gj69m7MRuiGp1ZSUVN+/CQCV40vBrgsvTFITSf33jujKeR9bS6heyyVI3aH8LyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAuSWAb0cSGq9G95WttfNwk49ff0GNSebj66wGirCXM=;
 b=SvJ6Ttgxn/4AUe2QTz2E953IH6TTRz/pPFT6fh/DDBricF92PBrvjT20r9G9rvmIkFJSxB1uKSfOHKq3LZ5WbTfoTcoE7vvKX7XP+ArVYUtCpi2W0Xaa6D0m7kTPEKzuQ0U4+Se2Ch8qGmtSOygcA0A9T5dpZuBg36dF8Tv+MP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Wed, 4 Sep 2024 14:41:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:41:09 +0000
Message-ID: <2b9db2e8-7715-43d1-9431-26d326d519ae@amd.com>
Date: Wed, 4 Sep 2024 20:11:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix a call trace when unload amdgpu driver
To: Philip Yang <yangp@amd.com>, Asher Song <Asher.Song@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 alexander.deucher@amd.com, felix.kuehling@amd.com
References: <20240904080420.559277-1-Asher.Song@amd.com>
 <1f702f8b-d454-d806-af9e-32c469280652@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1f702f8b-d454-d806-af9e-32c469280652@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 15640d44-f1eb-4ee4-1073-08dcccef9d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dndGUHE2UUEzMjdkYUY1ODZQTUU3Nm5iMkRXOTFXUStWbFQvRjRBeW4rR0xz?=
 =?utf-8?B?RWluL2laR1gwZU16Sm1LUm8wY2NwTzBDaGNRaHV5WUdKL2t5OVlDVW9EZFYx?=
 =?utf-8?B?TWNmVVNwV29ieTY3WC9Tcjg2SXJ3d053L2FaV3hjRWxsTWhLNnl2VEJyQWtx?=
 =?utf-8?B?NHVKZW42MEF3Y3FQeUtsc28rKyt0Uk1JQ3VCOW9McE5yQmFQQmdwd1VCa053?=
 =?utf-8?B?U1lGUnB2cm9GYjVXZG5uSGxqM0pvNWhDT2hKZnl2dGFrRDJwb3dSYkoyc3BU?=
 =?utf-8?B?ODRINlZ4MGI3UnJMV0FUVUhCVTdYc21DdFJET0s2dHNhN0VkZFBZTE1RQlVq?=
 =?utf-8?B?Tkdib1R2d0JZdm5YOTVsd0EySHBrUkNIOFE5UzFJRnJ1WHFKaWVtWk9yUlk4?=
 =?utf-8?B?RUNWM1BxUFRVYTY0WERUSSs1R2VNVGxQNXpFM09KSlN5UTZzS3VJSk80S1Js?=
 =?utf-8?B?bTloUG9kUWYrd2RSajFoZ1lWam9vZlBZZVhaWWJnOHlYNU9nd0dNVkNUS2F5?=
 =?utf-8?B?Z1A5dklWTGN6QXkrRnVOaHo4aDlTOUhSVmI2VHV2Q2dCYThRUDdnZHJxd1ZT?=
 =?utf-8?B?WUI5aGJKZEtZVDlTdVlFaEQ0UmRZUm5samFsVnRoZTlnUDEvMEhUbDk3c1Ri?=
 =?utf-8?B?UUkxZ1BYUWtmRGN5VTU3WmFWTU8vR0txTG5BS3IvMVpuMUNnbTJlQ05ncnlG?=
 =?utf-8?B?TW5jSzBWdlRaRUdHYlR1ajlGZ0REbEdFRTNTbnZiUnQ5WEtaa0djYnhrbDhW?=
 =?utf-8?B?RTB0UDZHQSszanN2R2JOVmpuSUZJTml2Rk9CU0RTNUVmWHFRdjQ0RkY5Rk5P?=
 =?utf-8?B?OGd4dWxHY3ZRTXBjTFAxRzdNYnVpSUtJbGxmODJtRG5lT2N0UFcvQXk0dXZV?=
 =?utf-8?B?dUh0c1crd0VNSUovai8wQ29hM21RZm0zMU9FNjVLSmcycjVKSDAveTI4Wkpp?=
 =?utf-8?B?T2RRSlNTREp6UGlMQWxjWnpIVlVadHBhNTg2Tm5xRmZnOVM1VDVQSFI1Mk5V?=
 =?utf-8?B?L0U5N21NUWhsMU1TOXoyTTdpZmd2UzVsODNlT3QzUk9ZcnViODEyaVJtSnkv?=
 =?utf-8?B?YkM1Njg1aDVmZ1kxTFJadjJwWGhmdDEyM0pVN0JBMUttajJtZ3VCT2tabHg3?=
 =?utf-8?B?a1Uxd1FNdEFxdkZ1M1NzSGZoUjZhM2JzQ2R1V0sxOGpOeXRDb09uYnFDQzVr?=
 =?utf-8?B?RUdkVlc2dHNNNUNYV3lBY2NVaEIvOWdiRkg5Ui93eXAxeW0yd2VnUkFqODJJ?=
 =?utf-8?B?RlVPV0U1RmJHK3FHMmQ1TE45OTFENzYrTHhjdmlkV3NiR3NpcU82L1JSK25u?=
 =?utf-8?B?dXFwNUg4N2RPd2lPd3FtS1Q4VWpvS0w2Zy9yNUhTeHJKZVJOL1BjeXlKMjFI?=
 =?utf-8?B?U0dCMmxiR0IzUnpNVjh1eU1yeFQ1Q1V6emZxMHhNTHhmeGZnUWZpbDZVYmM1?=
 =?utf-8?B?cHVldC8vdGV0N2MvY0JrbkpZdlV4UkQ4alZ6a3pKRjcxTko3SWxSekxLL3Vt?=
 =?utf-8?B?eTV6S0xmVmxQelptNVkrOW9JcDlvNXUyd3V6MWJWdHlqdnhSUEk0QXdPQ1ZL?=
 =?utf-8?B?N0tMREpvMGhUSk9vcGVpd2RpQjl2WWdpNm44RTYvRUtERHRPcng2ZmtBR2Np?=
 =?utf-8?B?TlhoaVB0YWF3bU1hZ2VDRjJIdjcwZ3pPaWpoQkRodHhURWFsWnNHVGhtd1Vj?=
 =?utf-8?B?SG9Fdis5VlJUZmJ1L0xiZmdERTNqSGtHbkR5WmlEWDZ4bG5IVGdDUkdzZlVG?=
 =?utf-8?B?OEU2bTVvcXB2OEZFb2tEYW1vOGx3Q3FtcXJoL3FoV0xDR2t6OUl5VDhhSmln?=
 =?utf-8?B?Mm5nVHkxeml0Q0tMN3VTdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDQ4Q2kwTnVobVVZaElBUmd4cmQwUWtzVUdQcGphNEF4RzRzR25idjdXQ0JW?=
 =?utf-8?B?ZVdTVDdLSCtCL1phVWJkQ2VVckVGeGNwRWJNMU1uWlpwV0huOEtjV2lDYjAr?=
 =?utf-8?B?KzNlc2lyWmJSbjlGZ2pMeHcwQm9ya3NvdDNETEluQWJJNlZPWTZ4REwvbitm?=
 =?utf-8?B?NlpYcjNoMU9qd2kvRkVTZ20xL1ZZc283eWtOdGsvY1o4WXJuNGRZUDJDd2tB?=
 =?utf-8?B?UjVVVHZGOXhuYVdCajB1YW40N01WY1I4QnpCRkJsVlFYUjNoOVo3UkxFREVa?=
 =?utf-8?B?UXo3dURUbHdKMUNmY0VsWjNMeXhhcW9wbTdNVFI5SHI1K2NRRytwNlU2d29v?=
 =?utf-8?B?dHNRRXBqUEJuby9nVkVMQy9rTGRUNVRsWktaUTREOVB2MDZQckdXcHdmRGky?=
 =?utf-8?B?eSt3b1doZnNmZm82OWF1aWR5NmhTRkl4REx4YUR2N3U4NW8wdzlZZElyekdW?=
 =?utf-8?B?bmxLdzlzY0FDVjlpbjYvZGt5Q0Z1RnZCRUxVWU4xK044L0Uzb2RDQ0dYOGRl?=
 =?utf-8?B?ZEdlTFh6VTRPN0JDR1lXd0YzWFhFb0p1VjhhNmhtRmNydzNXODc0SVdXbHBj?=
 =?utf-8?B?LzdGYmxjcjU2aXJRMWw1N1U3S0w1NmloYnBrMXpENEczWTRGOVhWR0FpeEtN?=
 =?utf-8?B?Vk5PRDVCS0lybWNwaVlTQTcrNjc3cFdhL0taczF2ZDhTZEtLK253dHFtTlpG?=
 =?utf-8?B?Q1JKUXRVZE1FeURqYytxRlBHUmIrbktjbVgxWnZ1K2lHMGR6V0ZuUEJoSFVY?=
 =?utf-8?B?cHlCTTBxTlE0YmVFVVBBOEJtd054QmN0YjArbVdIbXprODRHL21sNEhGeGEy?=
 =?utf-8?B?WVcwMzUxM1lNLzVWV29yQU9iQkRCb01tc1VqWGZJQWlUYkEvSlpSTE1adTlG?=
 =?utf-8?B?VlNlMzFsd1ozSDdyc2duT04rb3QvQmp4YnBWMytqZy9tcTBZVTdxSTZ2VUxW?=
 =?utf-8?B?NVpud1AxbmxpVytrRU9wT1ZkL3dsWlhyREdmV2RIYnRHU0psa3Jabkp1a3Er?=
 =?utf-8?B?eE45bVlQT3UzMlBTS3NBMjFzTnl0MzFKcjQ4Vmx4cDNROE14YkVrNUxHbkxB?=
 =?utf-8?B?TmZWVjVsVThsbzExa29RNVByYXhTdkY4bnI4VjhVcy9xY2JvdU9TY0JUbGFU?=
 =?utf-8?B?bHBWZVBtNlpTdXBRREJpajV0TzVvM3pPV21RZS9Yei9IeWpUTktuTmJMUkxk?=
 =?utf-8?B?YjM1cWl5NlhHTG13bGE2T3I3ZnhSKzhYWlIyY012b2EwTnFoUk1yYzVLZk10?=
 =?utf-8?B?VHlrWHZTb1J6SzExaDhud1d6TnZCNEVsMzRONUEvMzJUamxEZkdPYnd2Z21m?=
 =?utf-8?B?UXVRRnlzeldEc3pFOXdBUndycmVzazJib0xiOXBDSEtQS3lJRC9JRXY0NHdt?=
 =?utf-8?B?UGorZ0NwSXAvSkI5TWY5QUQyNGxRNFAya1dIVXZwK3hwbE5JSzV0bzhpTG9R?=
 =?utf-8?B?b1lQM3dNVHpvSHBPdThKQVYxL2w5Ym4rUy83c2gzSTJHY1pETmx4OVN5TU9S?=
 =?utf-8?B?SEpNa2xuZUdwYnBEMVhSS1M4TllqUG9TcnF2NTNUcVR6c1FpRzNISmNXT01K?=
 =?utf-8?B?QzI2UjA3YW04OFcwV3VvK0pIRDAvMk15alFpY2U5Q1Iwa1NaTTM2OUJsb0Zl?=
 =?utf-8?B?S1lDUUp6ZXdqNVBvVU0zK2ppdEtwemV5YU5QMnBEd0JJMU9IQ1Z4QzZ0NVBh?=
 =?utf-8?B?K1ZCNUgydEFPTjhiZ250MXlBQkpZVWM4V04xdmFBZkV0eStMTDk3SkJucDdC?=
 =?utf-8?B?aWJ6REwvdkRqTlA2dEV1S2hONEFyTWcwSXVCMkNCbzZiazB0MUZlZmFnT2Mw?=
 =?utf-8?B?T2t3YVgwNVovT1YwZEJlTE5UVGFqRUU4M1FoaERTZ24yc21NMkc2QXpqTXpS?=
 =?utf-8?B?U3JxOWJoa1NaSHJwYnlyMG05ayt1ak9leDh6SEljbkd3bXN1UXNQbXVoWUlK?=
 =?utf-8?B?NjBwdGx0ZTBxcXdLZ1hHUXVMUy80NzdDUy83Sks1WmNTWkozQWJPODdHalJG?=
 =?utf-8?B?MGlTcjFtMTFkcVpHS2wwNEY2eGNPTmx2bmQ4TWhmbnNWUjFDd2UyeEZFVmtG?=
 =?utf-8?B?V2FURmZYM3R1U1NLSEdBeE1xSkFnRkRCM3FTZXg3WTdRbGMySnBuTFczcjEr?=
 =?utf-8?Q?PJ1nZL9hpwH08jbphPIqHFntw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15640d44-f1eb-4ee4-1073-08dcccef9d8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:41:09.5490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2A+pb85YOKSAS7HpX6NMQwe2WzlGWIkkP1QNEoDbmUWrofR6djnCeuX6gkbSrGrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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



On 9/4/2024 8:08 PM, Philip Yang wrote:
> 
> On 2024-09-04 04:04, Asher Song wrote:
>> In some APUs, the bo type of GART page table is ttm_bo_type_sg.
>> Those type BOs is released by bo->delayed_delete which is added in ttm_device->wq, not released immediately.
>>
>> To make sure all the ttm_resource is released before ttm_resource_manager is finilized, drain the workqueue in ttm_device.
>>
>> v2: move drain_workqueue to amdgpu_ttm.c
>>
>> Fixes:d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Asher Song <Asher.Song@amd.com>
> 
> Acked-by: Philip Yang <Philip.Yang@amd.com>
> 
> Most likely this will fix another bug caused by race condition b/w GPU mode 1 reset and delayed bo cleanup worker.
> 

Unfortunately this won't - sw_fini doesn't get called during a reset.

Thanks,
Lijo

> Thank you.
> Philip
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 5c938ff0bf48..cbac21df5c47 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2461,6 +2461,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>  		drm_dev_exit(idx);
>>  	}
>>  
>> +	drain_workqueue(adev->mman.bdev.wq);
>>  	amdgpu_direct_gma_fini(adev);
>>  	amdgpu_vram_mgr_fini(adev);
>>  	amdgpu_gtt_mgr_fini(adev);
