Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1A2C02190
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 11:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D530010E7B9;
	Wed, 29 Jan 2025 11:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pdghEV0C";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E7A210E7B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 11:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wG7sNBuAedYeigzXhReVvBVyqJZ4Apno0pqFedOR5NyhHCTitLbNKwCfzMjEU14yAgkehFy9nbfZIqkQkrUZOJ6uWXum//LtnHiuQqKlSOxObr7lyObWGbSTofzkU1wMOKr8AT/PHUOn8T2mhDwkY0EodX/a+MXeRFL6cx/udy5MR39hjNRRK4LaEfHNoMgSC+DvNYbQIKOjLYFHQiWgGUXhud2Y2aC+COWtgkY4OIIq9jkeZPxhzvijn7GVpRLIQJgnovdOnjW6Bephd49r6D8Ria4HCY2GyTS6drT18R8rGLrH+TdnrUm9q4puuxFR1yCk+EezaLEQ3/S1d6URdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrNiK5JGVmVehclArmTrexcU2RvwsIKzsElKuxYljO0=;
 b=MUfPx+W6I86ajNzSOCeZPzr/Bx97M/8hQO28HTXXakDM2VcFzAA8h0sn6n92Wc+U5Keih2Fd5dr/2jVsJrLFyZih/tLlrNX8FZ+2WEs1DJDhBGIzeJgJTR7VrZFlcTlDsg5c+NF8L9N7OStiHSRlCC0O2RLBDqbCfvfJHcfbFkSR/UFbXhm0Vgaf7eYJIPVdwen+BUwNe9DvW/6UE0/FYBrCu+tTmbgXq+EIfBJ6oK0WQ8EsKxhnYD1jS4aB+sVhd4dt6tkcV/j/zMPi7xlg1YeXeV6fmqWgZFGmNeXjZli98/vEf6wzAME6YDQ6O18hQR01Ti6Vk09rlv8+0/9Ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrNiK5JGVmVehclArmTrexcU2RvwsIKzsElKuxYljO0=;
 b=pdghEV0CgCTP7X8FvEvX8IbRhCvLvyxq1k2y7EKRWrdIYs0GS4SjcMk3DlDwUIsOrGqzYIOzH+sr5tSF8yxvghXJN96gGoNM8RLjVBm06PDKs05brVEkt4i5dT0IxdYabriGcPG1Yu+TRUzjobBDt9rZ0fNKid93/ruAbOkzJ+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 11:33:55 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 11:33:54 +0000
Message-ID: <b066a12f-8dd0-407d-ae46-33fc82a7f3ed@amd.com>
Date: Wed, 29 Jan 2025 17:03:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
 <20250129084643.507727-3-sathishkumar.sundararaju@amd.com>
 <7ec91b45-2c09-4d90-9d8d-b8e1582c3f29@amd.com>
 <760a02eb-867e-413f-bf50-090a58d8926c@amd.com>
 <7ec53510-84cc-4f97-a7c8-8e10d388a0f1@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <7ec53510-84cc-4f97-a7c8-8e10d388a0f1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0253.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::7) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: d059cfd5-29c3-40db-e511-08dd4058cfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzBmckJ4eFg2SjQ0NEV5TU5zSCt2dXozdFNMY1ZNNHUrZDhwT2lpc2tLT0ZF?=
 =?utf-8?B?QUZ4clB5NjFQNkxSc25PaUpvMUNTMTE1SXFqbm9zY3Y4UC9wRkF5ZEJtb0xv?=
 =?utf-8?B?Ty9DWUpEQmhuTk1BVmJxR2ZjbTIyanRxRWVLd0JHeHpzZjc2S3hWY3VpV3F6?=
 =?utf-8?B?NmhwU3pNU21YMUdrR2xKU3dCd3pDYzd1QUlSU1JKSVdlWW1MY0JkTVJaOVVp?=
 =?utf-8?B?czdJWGlvVmZ2emVhMnZEUW1GNVFQLzdrVFlkZ2s1RGJSeGpydjVtSG1LaVJQ?=
 =?utf-8?B?NlFlZEVoeTF6emY2cU1LYlNwVXVQZitpcUNpMjIzci9GZVd0cEgxWjF3K01n?=
 =?utf-8?B?OEJiUnRlMWtnN0FJT3hjRVBUNFl4SFhHTHY3YTdORHkxQnFwbmNSN25PbGcw?=
 =?utf-8?B?Zm5LcHAydkVPTUhnYmlXMGx4UFRaakpKdFFkZnM3QjMweGpsVC9NWkt1V1hO?=
 =?utf-8?B?Q0ZqM2VKN3JpR1MrUG1Bbk12VTQ1R0FZVHU0WDd4MFNXMmxRWlJibU9yM2Rk?=
 =?utf-8?B?L2RwT096L043Uk1LcXZxcUVkYUlNTWUzRDhPSG5HNE5IUXcwUG45bWpIS0wv?=
 =?utf-8?B?QktJTVc5SVhlalIxWk9raFgrLzZFTVoxeW9oZ1A0WkpPdW5hNjVUVGRGaTBG?=
 =?utf-8?B?RmpRNFdWanIxZ3lzb2RVRmI1azNvbUUrT0JHWEl0RXhCUUZVemVkeEQ1VGJ0?=
 =?utf-8?B?dCt0SThCZlFjeGxHUHk0N3BtZldoNU5ZN3RubjZWSWlMQnE0WFJyRVMxSGNY?=
 =?utf-8?B?bUtWZU9rK1A0TmlqY1h1eitKWXJ5cVRmak5KYjZSQ3NqenZ3VjVmRDlTYk9S?=
 =?utf-8?B?VnFDZUkxcjVhNXZpbUI1V0w3Sno0NnBsbFZvblIvd2pWZFhGeEJCSzhvNE9J?=
 =?utf-8?B?Z21OdkFqb1ExeExtWW5ka0I2cXAyU045dXUyUlhvNTIyMDhMTDJLUWlyR04v?=
 =?utf-8?B?L1NSamNidjY0UExDN0dUeWhEUys1aWVWK2tZamMwTElkQ0kzdEJEMjZUS252?=
 =?utf-8?B?K0U0MW9tMGhKUzA5U3dLRUlDVHJPVGVOSU16VSt2bG0xMTdveWo0TjUvclZE?=
 =?utf-8?B?cGdZZXZPSmFNTVJYdGlmM0VsYUkwbDhHR1kxRnFjNHFXdnEyT1VtRHJnYUYx?=
 =?utf-8?B?MkNiTDlseUxacHRkeGdxNklLZ1hSVUdCYXJPcW42cFZvS2JzY1JiTGxIbWRF?=
 =?utf-8?B?a2dGWW5yQmQvTlRLd0toNVRqNUt6ZURJQmFCYWdxeXNUd29lZ0Q3WThMeDdy?=
 =?utf-8?B?ZDZmclJwUWNZdDVndkU2NWowdEpnVzBjalZ4UENjeXV0aTFicXBFeFhWcVFY?=
 =?utf-8?B?NXVWYW9hRzJqdldCR0NaWjZNWGkxVDJXRTFVMUJ2SXRnWnRzejE4U2I5WHpl?=
 =?utf-8?B?M1ZnTEkyVHQ1RWVkTU1scjRMTUFZc1BRbVBHY1VOdVdHMzZFcVU5VW9zRHdo?=
 =?utf-8?B?ZExpUFlIeHcrblJ1eWNPTkE3RWJoTktnaHprWXlReW41TW1DRkE4SmRvaHFi?=
 =?utf-8?B?aWFaZ3pyWHFQcUtyT3YxdHdjK0svcS82ODQwUVhkRnFJOXJ0c1dwRkdFenNj?=
 =?utf-8?B?V3RLclRRY0g2Zk11dGwzbGVwQVJTRmIzQkhRYzh2SzlGY0VQelNlRnEvMkR2?=
 =?utf-8?B?MVJ5KzdsUE9QcklkMFlyLysrNzV3V0ZsRWpqN2dqbzczZ0VpbklGaG9CbXJn?=
 =?utf-8?B?L1J2ZmE1UDJ5UG1aUmNOVVVZOWQ1ckdYaEowME5OcGhXSUhZTXVEMUpJSUNX?=
 =?utf-8?B?WlpFOXNTbDh0ZjRHS05UbHZ6Y2c1RHRPZ28vajNiNDVidkowMU96c3pPcHRG?=
 =?utf-8?B?T2FlUzBDNGJrUGFySXZGMzRxRVVxanBVd1FSUlNlRmdVMEdMYW4wbDVhVGJ3?=
 =?utf-8?Q?g2vYqPH5qFg4W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBVcHZSZzNZQlFxcGhOZFJzeW94MTBrNnhFMWVSVVZYS3Vib0R1SlJXQnJW?=
 =?utf-8?B?R041bjdHWFAzRTB4OTJCU2FWNG1BTUxBTWJCOWpmYWNlQXVJUkFOOVMxYjNC?=
 =?utf-8?B?TWlldnBFYTRkZFYzdWpwenRWVWpRa2Q5NFBpWmNNMitpM3NhWm1pcHVvbDcw?=
 =?utf-8?B?R1ZKSTRKdG5TbGlCZUxBRysyeU5OUHdndVgyTnJ4eG9FRnFlMU9WVFlaUDM1?=
 =?utf-8?B?c0Z1Mi9XMWMwMmhkOWRiUUR4UVhvUHBCcFVGYXRKS1lIcFhWSUdQUkMyQzVi?=
 =?utf-8?B?VlFGT3F0SUlyb2pIanBmWXFNbmdoay9mMmxlKytOZTFKSnV6cnpXY0o3QTVR?=
 =?utf-8?B?YlE3QW9WSjRjRWhsWlo5SzRKRXdHamdsZG5UeW5PeGJtaUlWRThsd3NWOXNa?=
 =?utf-8?B?OEsxWTc2dVBXT0hsZU52ZnpzZDJYNFNxOXRLTFlTUzBsMUZqWXVFSGZ2b0lM?=
 =?utf-8?B?K1FNbkFXTXNRVmVJZFprZjlSdCtUOVJsU0s5MC93eEdaNFh2UGljK0JBTUhu?=
 =?utf-8?B?THp0TTFySmJxVWdOQVJCVXFMa05wekhzSlpLdHlSbm1HTXFFVXV6UTZLb2Yx?=
 =?utf-8?B?aWdGeFBkd0V5OVhzQzRQWmtZcjZWOG1xcTRtZTN6YU9qbjl5OGVhRFpNQU5T?=
 =?utf-8?B?azBRQjV4aHljUFQ4SVpGa3N4ZzUzRVYyTCtBVzZmakQyc2FYaDVJekhaelFT?=
 =?utf-8?B?U2hwcENGaURGMzBvK3N1L2x6SlBTTXdDNENvQXpsOUhiVXd3NnNud3RRMlIr?=
 =?utf-8?B?dWtUK1NZeTd0ZWFBZmZYYmtBdTNmNDc5ZlJaN2twUTYvVllrL1duMXNSVWY4?=
 =?utf-8?B?aGFCRWFiREdMZzlNOFdFK1NNM0FyM0d0U00wZm9ucTJJVU9Pa29EUkZ4UWdq?=
 =?utf-8?B?RXVwQnFydVZ0SDBBa3lXS2FNZnZ0eXBlaE5tK2RyczJlQW1hNWIrZkIvZCtv?=
 =?utf-8?B?VGh4STJwd0hqems1QUxDVEltZWE0WUxJeUI2ejdhdlc0RnZubStibzc0YjVZ?=
 =?utf-8?B?elhhZTNvVFo1RVk5bEcxRHB1TjlQWGZVTDc3SS80WEREUFgxN0pKN3o3SzBs?=
 =?utf-8?B?ZjhtR2VSNFpENS9tNTZLZDM0MnRHejI2dEx3b0hTZFNvUmp5MFJNY1F1anpZ?=
 =?utf-8?B?Qmp2N0dJaDBVVGhVM3RJbWh4ckJWc2Vra1BqN0pxSWtBWGRuSmVENUFzbmk3?=
 =?utf-8?B?UUM5ZDdQY0hXN284bGhsZ2w1YXo3YWZrcjFUaHlvWDZ4TkJDN21ac3dnVjhS?=
 =?utf-8?B?c3JZd1FHdURQL0ZSMTN6OHVHK2QvcjltTHV6eFdHQlc3bDVoODNGTlJrYlFy?=
 =?utf-8?B?dFEvK0crWC96SlBxY2VZdGgrZndlZlFMYURJZUJDY0JTTEVDY280ZHR2NDJ1?=
 =?utf-8?B?bmN4QTk4SzZWbkF1cGpybTJITDN6V2J1aGxTQ3FDdlZjVndpU1NBVTd3ZnF0?=
 =?utf-8?B?eEhxU3Q1UzRLa3YxVXRJbUxJWWw3NEhaZFoxbFBBYkpTOWUxdC84b1NRcVhJ?=
 =?utf-8?B?SEx3cTlzMXU2aTVxSkYwT3AvYWdCT28rSHVHckV6WE14bmdIUlo4RWs2VnZD?=
 =?utf-8?B?K2V4SUFuL1FZVkVER3lLdzlCbkEyVldxWEpneTQ4cG9oaFp2dmhCdXhIVStp?=
 =?utf-8?B?Wngyekp6YjNUYkc3VUoxQWRCWWw3aUtOcEFMSlhnK3Q2ZkZvMTlFNDJWbFZT?=
 =?utf-8?B?ZmN6T2lpQmRlQ1FnSW5sdGNXWHErdnNDSWVCMWZ1VnNwbGNUbDlFTFZscyt3?=
 =?utf-8?B?UzJxNWJCUTVXbmE3OGc4MUFobi9ib0EvMVNsemFUMDRuRkwxSllNakI3Wm5j?=
 =?utf-8?B?NnZ2Nk9mRXp6OFd5K2k2T1pZcHludEZmYi9Ga1lWMlVscXBGbmxKYml5amVH?=
 =?utf-8?B?Y05YTkE5cXM2ZzJDeVlRblMrWVNNcmN0SnkzNEFCWG54R1QycTFTSmpXTHdY?=
 =?utf-8?B?Y0s3WHBtOTVLdVdpdTFNRVoyc283anNiS2w1K3p6ODRrNGwyUHRvREpyZzQy?=
 =?utf-8?B?YnBJZ1lhdGE3eTRHeEhGY1UyYzJjS3ZGZXB0N3RGOWFYUXQxUzB1OS96V3RL?=
 =?utf-8?B?NHJHUnFra2dkQXhpTVlBT1k0QnJxQzlXNjBJZm1RM1NKQVBFS2tmaUNNb0l5?=
 =?utf-8?Q?R5AAI+8H4OZbsCnK48BcWiViz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d059cfd5-29c3-40db-e511-08dd4058cfd6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:33:54.7629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXJL/ioWvu6h6j2UuydqeBkTzzRksQCZjo21ATwtzF+VIywU0GQt5LSAx3cOMkDZ1hPriY6G4vIr1u0T9i2+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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




On 1/29/2025 4:15 PM, Lazar, Lijo wrote:
>
> On 1/29/2025 3:51 PM, Sundararaju, Sathishkumar wrote:
>>
>>
>> On 1/29/2025 3:20 PM, Lazar, Lijo wrote:
>>> On 1/29/2025 2:16 PM, Sathishkumar S wrote:
>>>> Add devcoredump helper functions that can be reused for all jpeg
>>>> versions.
>>>>
>>>> V2: (Lijo)
>>>>    - add amdgpu_jpeg_reg_dump_init() and amdgpu_jpeg_reg_dump_fini()
>>>>    - use reg_list and reg_count from init() to dump and print registers
>>>>    - memory allocation and freeing is moved to the init() and fini()
>>>>
>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 80 ++++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 10 +++
>>>>    2 files changed, 90 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/
>>>> drm/amd/amdgpu/amdgpu_jpeg.c
>>>> index b6d2eb049f54..0f9d81e27973 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>> @@ -452,3 +452,83 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct
>>>> amdgpu_device *adev)
>>>>                device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>>>>        }
>>>>    }
>>>> +
>>>> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32 count)
>>>> +{
>>>> +    adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
>>>> +                     sizeof(uint32_t), GFP_KERNEL);
>>>> +    if (!adev->jpeg.ip_dump) {
>>>> +        DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +    adev->jpeg.reg_list = reg;
>>>> +    adev->jpeg.reg_count = count;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev)
>>>> +{
>>>> +    kfree(adev->jpeg.ip_dump);
>>>> +    adev->jpeg.reg_list = NULL;
>>>> +    adev->jpeg.reg_count = 0;
>>>> +}
>>>> +
>>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block)
>>>> +{
>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>> +    u32 inst_off, inst_id, is_powered;
>>>> +    int i, j;
>>>> +
>>>> +    if (!adev->jpeg.ip_dump)
>>>> +        return;
>>>> +
>>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>>> +        if (adev->jpeg.harvest_config & (1 << i))
>>>> +            continue;
>>>> +
>>>> +        inst_id = GET_INST(JPEG, i);
>>>> +        inst_off = i * adev->jpeg.reg_count;
>>>> +        /* check power status from UVD_JPEG_POWER_STATUS */
>>>> +        adev->jpeg.ip_dump[inst_off] =
>>>> +            RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[0],
>>>> +                               inst_id));
>>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>>> +
>>>> +        if (is_powered)
>>>> +            for (j = 1; j < adev->jpeg.reg_count; j++)
>>>> +                adev->jpeg.ip_dump[inst_off + j] =
>>>> +                    RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev-
>>>>> jpeg.reg_list[j],
>>>> +                                       inst_id));
>>>> +    }
>>>> +}
>>>> +
>>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>>> struct drm_printer *p)
>>>> +{
>>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>> +    u32 inst_off, is_powered;
>>>> +    int i, j;
>>>> +
>>>> +    if (!adev->jpeg.ip_dump)
>>>> +        return;
>>>> +
>>>> +    drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
>>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>>> +        if (adev->jpeg.harvest_config & (1 << i)) {
>>>> +            drm_printf(p, "\nHarvested Instance:JPEG%d Skipping
>>>> dump\n", i);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        inst_off = i * adev->jpeg.reg_count;
>>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>>> +
>>>> +        if (is_powered) {
>>>> +            drm_printf(p, "Active Instance:JPEG%d\n", i);
>>>> +            for (j = 0; j < adev->jpeg.reg_count; j++)
>>>> +                drm_printf(p, "%-50s \t 0x%08x\n", adev-
>>>>> jpeg.reg_list[j].reg_name,
>>>> +                       adev->jpeg.ip_dump[inst_off + j]);
>>>> +        } else
>>>> +            drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
>>>> +    }
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/
>>>> drm/amd/amdgpu/amdgpu_jpeg.h
>>>> index eb2096dcf1a6..02886ec4466e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>>> @@ -92,6 +92,8 @@
>>>>            *adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;    \
>>>>        } while (0)
>>>>    +struct amdgpu_hwip_reg_entry;
>>>> +
>>>>    enum amdgpu_jpeg_caps {
>>>>        AMDGPU_JPEG_RRMT_ENABLED,
>>>>    };
>>>> @@ -137,6 +139,9 @@ struct amdgpu_jpeg {
>>>>        bool    indirect_sram;
>>>>        uint32_t supported_reset;
>>>>        uint32_t caps;
>>>> +    u32 *ip_dump;
>>>> +    u32 reg_count;
>>>> +    const struct amdgpu_hwip_reg_entry *reg_list;
>>>>    };
>>>>    
>>> Thanks, this is almost there. Personally, would still prefer something
>>> like below and have an instance of this kept inside jpeg_inst (though I
>>> see your point that jpeg_inst doesn't have an instance id and this will
>>> also mean duplicating list pointer/num reg info in all instances).
>> The multiple copies is one reason I am trying to avoid this approach,
>> and we can still print only
>> the affected instance registers in devcoredump in the future if support
>> for it comes up.
>>> amdgpu_jpeg_reg_dump {
>>>      u32 *ip_dump;
>>>      u32 reg_count;
>>>      const struct amdgpu_hwip_reg_entry *reg_list;
>>> };
>>>
>>> Ignoring that -
>> Thank you, would prefer to have single reference of the reg_list/
>> reg_count and use inst_id.
>>> With the current way,
>>>
>>> amdgpu_jpeg_reg_dump_fini() may be called from within sw_fini(). Just
>>> wanted to keep a wrapper fini() func to make sure all is cleaned up.
>>> That would avoid calling this from every IP version.
>> Can we have it the current way instead ? as few ip_versions do not
>> support devcoredump yet and calling
>> reg_dump_fini() for every ip version irrespective of the  support is
>> redundant, if we add that in sw_fini().
> Just add a check for reg_list being non-null and that should take care.
> Then this doesn't need to be taken care when more IP versions are added.
> Also kfree on NULL is harmless.
>
> Thanks,
> Lijo
Any init() caller should be responsible for calling the corresponding 
fini() as well,
it is either good to have both amdgpu_jpeg_reg_dump_init()/fini() moved 
inside sw_init/sw_fini
or leave it to the helper function consumers to call both init() and 
fini() themselves.

Regards,
Sathish
>
>>> Apart from those, leaving it to Leo or someone else from JPEG to take a
>>> look.
>> Okay, thank you.
>>
>> Regards,
>> Sathish
>>> Regards,
>>> LIjo
>>>
>>>>    int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
>>>> @@ -161,5 +166,10 @@ int amdgpu_jpeg_psp_update_sram(struct
>>>> amdgpu_device *adev, int inst_idx,
>>>>    void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>>>>    int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>>>    void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>>>> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32 count);
>>>> +void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev);
>>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
>>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>>> struct drm_printer *p);
>>>>      #endif /*__AMDGPU_JPEG_H__*/

