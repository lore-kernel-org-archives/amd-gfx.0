Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8515D15D96
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 14:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9284B10E108;
	Mon, 21 Oct 2024 14:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uXKzmntT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625C210E517
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 14:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvHBCpnGMBR8iI5ydtJkcD9XsNVr3wBk/avdktrvwX+vXgXi4K1YJaHghPLbUwnVzmmXtniOsFji8xRlytN5c5o+rdl0gQsfpYcJ1b/ogeg8SofKOydfkscY0xBFAjfEyy0UTtheZkjuOYbQjnbJTwNNrqYAX/HrKTWGNDhIcfUxMmNIlNajajuyEO87ofXZ1vW0MrQRxd31UN57Hz9BVX/I3sQPkOyHWNNBUAv0KZc6XIEb1zba/O1qomTAa7BmtImICjwNKF8rfrIvs/4CI36R5p6LrzOcTUrnDpmz5m+ZBXzy7ZtSovWNLSsRzwTvqtic2vOY6xj00G5fUnv2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tMz5A8hfbRi8Nqoq6JwQhjAbczQk1CPjWefA4M2WuE=;
 b=t9kEg0efLZU8TFrOgpTFsRY6wzH/CikM+NGhUlebNeDNWUYw3c0y8Y9V1BAGrM8I/VbztrW3+65F1XWLO5mpZiWg30u0kX9ozf2ECk3OnAvflu6f7FVX/wlTsE6LVdj2jmvKPg3O8OvrkA2L2vLq7+VxvjShSeOXu89NucxyBQUNTMYyBX9m/OOJrrkg4ZykKTO5WrkMDL0uL6ryW84oTbU7zrL2nE08s87eoAmmBVBsfJrpBWJHXlSLNi8wwV7k66O+gNXarqjhmPGO+XJmCO/1iXtY8jXfsCYLH73Ab4mnZ4WZLnbs77IMhChfsZvjr8e3tROC39NLE23juISoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tMz5A8hfbRi8Nqoq6JwQhjAbczQk1CPjWefA4M2WuE=;
 b=uXKzmntTMePHkMtecN8pssHJ0H3PIOcI1Ex6uMmzo0GpfWpZAdQQsYh3d1XZmcOAvw2lg4ks82bTOXq13tco8YgD0OC78h911T00pvDbyE1AXuOlvkJVFttCnY+pezr4pnkZmAlQdGCQ2Sj+Ngy5Q6WiGWkAvfca4gmLKchcnZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:07:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:07:09 +0000
Message-ID: <d19b821d-4768-4338-98d1-40950956cbf4@amd.com>
Date: Mon, 21 Oct 2024 19:37:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use SPX as default in partition config
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Asad.Kamal@amd.com
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Hao Zhou <hao.zhou@amd.com>
References: <20241014091911.3036389-1-lijo.lazar@amd.com>
 <a4287c13-6006-4739-a2f3-8c14cd085f05@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <a4287c13-6006-4739-a2f3-8c14cd085f05@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c0cf66-7995-474a-5224-08dcf1d9a6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVg1VUErbHZ6U3hQbUpidC9CNnVJUXY2OUUxSFRtTDZCRzduZW9FeFRja2Fk?=
 =?utf-8?B?UE9Ha24wbDNhckNUUXhaUnR4d1V3M0dUNHVlRzFpb2xZMVcwZEJXajViRnNN?=
 =?utf-8?B?UUcrUHU1cER4aEtWaStmTXpUdGJKL3pNNU8rRzFQMS8xZVZ2U1VnNllpT29F?=
 =?utf-8?B?eG9WYXVRRm5Mc3ZCaXkrcmxoeDZKSXU4aGNJaDRhNGxYZGhxV05aYS9BWmY2?=
 =?utf-8?B?T280cUJGbTZoQWpReThwRE5nb2Q0WndxdHY5MEhOTWhqTDN0UmVWU2pyeWVU?=
 =?utf-8?B?eklxQ2Fucyt2RmV2Wi9NRll2Vzd6L2crVkNOL2NHbDFjekwxVVRuNVg4NUdK?=
 =?utf-8?B?d2pnS3hLWHJ4eUs2UXp5Rm9xV2Y3dGk4dEQwL2p2M0dzTi94cEZ6V3hZaGRR?=
 =?utf-8?B?THVJZ3dwckt1RVFFQVI4cmhMb1BhZnNlYUVRZVFodFRnUExNelNiWnJJWDdS?=
 =?utf-8?B?aEI1UFpNYjRTaFlEcDlZS1llY0cxemJoQjBaU09mRGNTcTh5RkZUNW5vZ0Vn?=
 =?utf-8?B?ZjRPM1dYOUp3dFJGcEFSLzJLM3VBdmY1MWJpZ0pUTWc0UmdsL2I5bDY3RFI3?=
 =?utf-8?B?RWZPMVlweFN6dEVjNk1Dd0dBUVZOYm9EajRRTVIwY3dNOFR4TjJIQUhxcU5D?=
 =?utf-8?B?dGQ1Y3V1YXE3dmNKei9zUlBkYmxKVzNOT2Y3QXZ0R0R0RTIzTTVycWRlejla?=
 =?utf-8?B?ejE3V0hkNytTdnRvOXQ5Skk1ZzIxYVo0K3pORlYwb1RaL1lUSUc2MGFMMHll?=
 =?utf-8?B?YTgwaDJ5NnBPTTltWDNLc2hkSXBJa1B0NGxBZXV0by81NE90dFQraXdVa0Iy?=
 =?utf-8?B?UjJYSDkvUXlhTGV5WmtOZnF4UVlIcVF2YmdiYjBQY1JzSkJ3R0RHWE9zL0Nm?=
 =?utf-8?B?UndFRTVvVUFXN1RDblVBSFhNa0E0TkErM0dCQ2ZoTTVpSHlRZUN2clFBbHVw?=
 =?utf-8?B?QVluQXNrZTVWUjdwRWU0OW84OUV1a2lmQWp0RG9RdHg2N3REOFVmdFJRb3hF?=
 =?utf-8?B?SUVLM1VqbEppbVpzTnNlM01XYXhHYzRTeVBNZExiWWZIM2pkODF5VTMveldu?=
 =?utf-8?B?ZlZBMXhXNE1tclBMS2t5RjNkVUFWUWZXVzFIS3ZqTllxR016Zm94eGNZRkZJ?=
 =?utf-8?B?T3ZPU3pUd0F6MTdUbWNqNVord2pTOWN6M1c2UCt6ZVNnV0YwZW5sVHhaUEVw?=
 =?utf-8?B?SENiZUxBVlNzQVlEWjM2b3lNVW1NdUVZaW1WNTRPeWZIQWpEUnZ0bTZaNUhE?=
 =?utf-8?B?eTR5RkNaZlV3S3hlMVQrUUFrbE15cmJzeXpWWnZ6QXBxTmYwS20rcDlDS0ZU?=
 =?utf-8?B?aVovbzBqRGIxMmdGaktSU3V3aEM3VjBEZXJ0anlLcjNSTkVzVkxFV3RBV0Fy?=
 =?utf-8?B?emNlV0xzRkNVMlY4MjFpcjRMQytTQjVaN0Q2NjRobFlrVm1sVnNFWEN4bkNq?=
 =?utf-8?B?QzNSNDI1dkVVZ2IzdWJaZFZYSERvYms4Rk9jYzh2RGpSUGg5aENJMERTeTVF?=
 =?utf-8?B?SGs5MmxKaUVLaWJGY2R6MHp3YXRjY2ZDS1FFRmczZmNvMXdQK2Y3Y0xZalVD?=
 =?utf-8?B?Rk9ObWh4QkhrLzduSml4S0w2R21ucXZxeHVOK3FXcElWWnN1YkpESmFVVEZ0?=
 =?utf-8?B?V3gvNEd5UTZiaGhHeTdhVEw2VnJKcjM2cm5LajhMK3lDSFVkTEo1MTF3Ty9U?=
 =?utf-8?B?QlNKOUs5TGx1bzVVa014VUhXTXkzOUhaOE11S3gvNVRyQWs5Z3VYRkJrWlEx?=
 =?utf-8?Q?7bLVbBDQTuigmY2jbX2NR5wSrBO32VXIuSe/Qb4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ovN1dPcmpTYlRxa0lTZ2IvSE5zWjJtc1NGS29hYStxcjQ3bFdqTDNoSHJn?=
 =?utf-8?B?WDA1emlWaE1JVC9WUW5xNmNSazh6UVcyTkI0bVdNNVBnbUljVHdaUmhHTUd6?=
 =?utf-8?B?MHBNUXJueGtHdUZiVXBjbDNLdEVSMU1sUGcvRm9Qb0FQSktQZnVOTmxVU3RQ?=
 =?utf-8?B?bUozRkNFN1VwdTVBSlIwMnIxaTc1Q1BDZGl6L1B1aHpwb05OaTNwQ21uOTRT?=
 =?utf-8?B?d3RJcHZTejYxd3dFRFN6VTVhb1hVQk9tMGgwSnh6VUVXTGp4aXVUNjN0d1NP?=
 =?utf-8?B?RHBOQnhCSTRQcHdHRnJhMVp5bko1UHF1U1pIVmJ2NW1jRlNjdHYyTXErVGFQ?=
 =?utf-8?B?SkViV0tLYVlORVZDRmtjTUd6VUlHbTZHMTk0ZGpzYnJhUDBBWVdHaGEwK2Uz?=
 =?utf-8?B?N1V2K1pFY2ZPMU1yZ1d0L3Z2akhjelpZcmx2THZNYVVZazZZMGplYVZLZEF4?=
 =?utf-8?B?TGNRK1BiTm5Dem1iaEFiSTdiNC9Ga0ZPSDNlaW8xeHIyV0xwS253akZBaFM5?=
 =?utf-8?B?eExUYmZ5bjhTa2JIeGNGZk1xMXVGcDk0OHAwLzNVaThKTmJVMTJJL2lRa3ly?=
 =?utf-8?B?UW5scmFnUmRteVpMMlRJUUVUcFRTQ01yQmRXaGhEYnNMazdSOUYyNkxZWFV1?=
 =?utf-8?B?SWlMcTcrdloya2NUWU5rd3dhcjVSQUZsSXk3NGV4Z3VId3dyQ0djUmtybVcz?=
 =?utf-8?B?MnErbGRPd0dMRHpleThvREwzU3J0VXRmQVZRbkdvbUUyamRFY05YRkNqeHN5?=
 =?utf-8?B?SlUxOVhVem1meGdMa1A3VTY0UCtFRloramt1UThrMzdmVjlac1EwU3hPS01m?=
 =?utf-8?B?V1ZySkk4Ly8vNzFtWG01cG9FZWxHNzFrdTl6VW4rOW1MdUo1bkhSU3pRcnRF?=
 =?utf-8?B?ZWFwQkFmZGZmU0RUcVcrQTJ4TE4xVHlHODRHRE5mZkpPamNlb2xnZ2Z4Rmh5?=
 =?utf-8?B?cG1pVUhHZkg0alEzbldJdSt2WUJVbmorQUNBYlNoaVpWVlVLNVlobi9wUFZs?=
 =?utf-8?B?VzgrMXNEMXdQbHI1ZitTbm96QTZ3TVFqODNkbE9PMWlaTklQZXF4MHVLVWtm?=
 =?utf-8?B?amh0N29KVHRUd1AvMnB1cFRqWG5Ia0ZPcmtHUEVWNmxkdVdLUkI5QXV2OU5X?=
 =?utf-8?B?SURLdEozUkZvNTUrUC8waDBrektoUmVSUHRrdkZNaU5jN3M0ZCtjcGlCU3Fs?=
 =?utf-8?B?U2p5RVJSa0dIQ0JpQy81NE1ya2JBeWU2VWF5cG8vbjBydk9PUDJweHllallq?=
 =?utf-8?B?bHQ0ZFlLWTBnaHpZQWh3VlVNcHlFejN1MDRCRXdrYW5laEYyeEEzTnFtdHpS?=
 =?utf-8?B?ODNZY1VvenUyVjYxTmR2N2RGUmVIS2J6eTdrcklmNmFmbW5ENFVPNHMxWS8w?=
 =?utf-8?B?dEx4aTZBa25jNHN4L1dWbFo3R0N4dzA5dWNKR0FqV1ozTlY0bXBlY2NjOU5E?=
 =?utf-8?B?RERkOWF2U1ZCL2VQT1hHZ2FBak9INTZvbEQ0N1dNRUFoYzNJTlZvYWhJemg0?=
 =?utf-8?B?VXU5WVpWb3Y0bTI0S25uZTNXZW5zQVEvZ2p4cVlBYmFhdGlBQU1zenNpUkFv?=
 =?utf-8?B?d0E0Mjc4ZTJ6azU3SG1IbTloemg3SjRYQW5jS3BUSjlVdHdab0NMQll4N0pL?=
 =?utf-8?B?Tk5Ja25wUjMvRzY2Zjk5RHp0L1BicksxczllZkI2WkJNSjlpMlNoMHNteldK?=
 =?utf-8?B?V1QwUFpXQUc3UDV2cGVkeGk1Y1hzMkQzNlBZUkhUa2JQN0FNR2hIcmZoSk0r?=
 =?utf-8?B?U0VPR2NWOFFmSjJKWEpPZGgxRldNNlAwMnlLaXRBOEwwZzBKejRma1lxb3Nj?=
 =?utf-8?B?ZkMvVU1PZk5OMkc5YVZXRUFNRFZZeWFyaXdBSGhNcUdrSlJQYzZCaGN6NmIv?=
 =?utf-8?B?QmVjbUIvZkRKODNzWFlWUE96OFMweXhEUzl2UVdtUW51MGdQWWJUdDhiYi82?=
 =?utf-8?B?QmVsb1VpeXJUODhYUmp0Q2g1YVJPeTlweEJrTlFJU2tYczZOUndrUkd1cnJh?=
 =?utf-8?B?RGxpU0hkRkJobTdFYmpCNEVFZUtGRjlsaE9PTUIvNzNCM0ZVMVp2bjRmUlZk?=
 =?utf-8?B?eURQclBuaFh0MG1ySDFmeVlhVGkzYWFoUHFlRzBHNzh3RWFvazcycWxEbzlO?=
 =?utf-8?Q?9qLvlXrL0zijS48gmfXkhjMTJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c0cf66-7995-474a-5224-08dcf1d9a6a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:07:09.0111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VqXmRsWT6O5Jl9tkHGDkSW+Urwglsgf2/8+LxZqMmbkXzWf+vK2gYlxV+SQbeKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024
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



On 10/19/2024 12:46 AM, Felix Kuehling wrote:
> 
> On 2024-10-14 05:19, Lijo Lazar wrote:
>> In certain cases - ex: when a reset is required on initialization - XCP
>> manager won't have a valid partition mode. In such cases, use SPX as the
>> default selected mode for which partition configuration details are
>> populated.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> Reported-by: Hao Zhou <hao.zhou@amd.com>
>>
>> Fixes: c7de57033d9b ("drm/amdgpu: Add sysfs nodes to get xcp details")
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index 111bf897e72e..83a16918ea76 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -606,7 +606,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct
>> amdgpu_device *adev)
>>   {
>>       struct amdgpu_xcp_res_details *xcp_res;
>>       struct amdgpu_xcp_cfg *xcp_cfg;
>> -    int i, r, j, rid;
>> +    int i, r, j, rid, mode;
>>         if (!adev->xcp_mgr)
>>           return;
>> @@ -625,11 +625,15 @@ void amdgpu_xcp_cfg_sysfs_init(struct
>> amdgpu_device *adev)
>>       if (r)
>>           goto err1;
>>   -    r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr,
>> xcp_cfg->xcp_mgr->mode, xcp_cfg);
>> +    mode = (xcp_cfg->xcp_mgr->mode ==
>> +        AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
>> +               AMDGPU_SPX_PARTITION_MODE :
>> +               xcp_cfg->xcp_mgr->mode;
> 
> Shouldn't this depend on the memory partition mode as well? You must
> have at least as many compute partitions as memory partitions because
> each compute partition can only use a single memory partition.

This is not dependent on the current/active compute partition mode. It
is to show the configuration (number of xccs, vcns, shared etc.)
supported for a partition mode. SPX is the default partition mode at
boot up. That is used as the default mode.

It's not a strict one-to-one, a compute partition may use other memory
partitions also non-coherently.

Thanks,
Lijo

> 
> Regards,
>   Felix
> 
> 
>> +    r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
>>       if (r)
>>           goto err1;
>>   -    xcp_cfg->mode = xcp_cfg->xcp_mgr->mode;
>> +    xcp_cfg->mode = mode;
>>       for (i = 0; i < xcp_cfg->num_res; i++) {
>>           xcp_res = &xcp_cfg->xcp_res[i];
>>           rid = xcp_res->id;
