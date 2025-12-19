Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21CDD74960
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 07:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5560510E060;
	Fri, 19 Dec 2025 07:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HPS2i+a7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3411810E060
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 07:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glT019P6hUtTG8Y4gBCDn+hHFU5J/RnpWRpDqcaihyLs0hmc2ALQ4QvFzTIeLylx8b+I87DwvtIdAhUMbmLL7TFR+fwHMC2kpuctHAIV13W3NniDiuLuxSHd6FZmB4lQCTy9JXx5SBqLjMl24ajOBqi/GXuLRwZ3y7jA3Pc5Ct3uDkinS6hbYCymoL3h5Dz2s5+3tYIzICc1jPkvmvgSNgNRFV/tb79fI/pNiOuMR02AugFTiNKm8bxw/AD7NoyGSXCuUcTHtSA26ZH490CaRTDek4o9LqBx/ZqpFxsKDPbwdahBYNg5tm9s7S4evMOJwbMgjVclqJ4SbYfCnYYmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMnCcsZVqQX8lAuquDPi4hHYSPD0Gw7MZfRY1uk/px4=;
 b=VMvR+rokJtkIfnDBtp6dAF/BEmLHOkid5Aa5NHWnwWfwtb5r//suM8R6rVxYGR1MJ3Hj+14PeugOBWwAUEGG7BBYftnoR+EUb+XEGjqnbshZfyxCVGtWiNBPniQBKGvbESj8J+NYRf7jFrO4r2vO5GNXlbEVgFvZ3lx3QwOzQLlgn9KDL0srjQJI9RuZ6BPonXnG7KXahPv3QXhmeYJSROOiYPb/+XrRNcpvH8jsRtuI1PPAGYMgqiV8UEs73CwuT78ukHIH8XZuNScDR6wrI/lQoXIz8mBilkBBdDXnDijWcTKdTAo6gptZmIIfSnLThJQl0eWCCoMQhQriVtecgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMnCcsZVqQX8lAuquDPi4hHYSPD0Gw7MZfRY1uk/px4=;
 b=HPS2i+a7Z0uliRxq+rsx25Yur41eUqRG8InVqNzKy3s8DPUr281+e/vHMqSnKJKqAWJayDfW6PhgGUDokaPQCe8otGILzBpalBjJlLvXxTAd1mdY0Atl9szbhjTjq4TlpqGS3jqUBl0vUbhLOb40gmAXc2/Qg5Fu3+aRuQkh8Vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 07:49:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 07:49:38 +0000
Message-ID: <245994d1-e4a6-4ef5-9446-1e30d790ee93@amd.com>
Date: Fri, 19 Dec 2025 08:49:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] IDR to xarray conversion and some small cleanups
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0424.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 716de2ff-387b-4556-df38-08de3ed3292b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDU3YWtrcGFqeWtzK0ovZFVqUFczVTd3ZlBHS0JBZEk5OHhDRlRybkVHMHRy?=
 =?utf-8?B?RjRIS0Z6TGZvY1VNQUltK0JxcDRKWWlZVDFSaU1yWjJxcjJkekRCTjlON1Nw?=
 =?utf-8?B?dDdlZzdoYXFIK0lnZXd2RWE0TWFINi9NS2d6RGdMcUNQamxoSWFUS1cyb0Iz?=
 =?utf-8?B?MXY3OGZsQlUycVprSDczbDJJSjlUTktYdnZOWmpYUEUrdzdOL0NxWkhnT0hj?=
 =?utf-8?B?bC9Ic284bGFuM2dOT1hsTkxpbTMwNUVvN1p5VDdNNlJwandwb0ZGNnVNRVBC?=
 =?utf-8?B?ZzlqNzd4NFU1cWNjK0JlQm9waE81WlB6VEF1QUw1dUMyK1RVbzU0NnpNL1A0?=
 =?utf-8?B?elBrTysweU8zQlRUUFdYU2oxeSszdTNhZEg1QXArQktIaU5uK2lib1NBWVc5?=
 =?utf-8?B?UU1pd2d3TzNwaHJtemZueW1PMDNkK3psT085TmRabGJFZ3B6dk1EZnZmK3Ev?=
 =?utf-8?B?Nk5TSEhndUhGQzZIVm9NN0pmdjRMQ1c2Qjdoa29RQnh0QjJCSDFhTy9FbDdV?=
 =?utf-8?B?TUkrelNUd09ZSVZhczAzeXRra1ZYMXNFWnQxWGdVRmw5bXZBZEo3Rm5BSUNy?=
 =?utf-8?B?d3FVaTRiQkNFc3hUc3RPU3ZEZjJQZGxKaW9MYjZzL0dJdDVycHhqT0tpejNZ?=
 =?utf-8?B?d1Y0bk0yN20yNlhFUk9sTS9UVXdrMWNtbUI2WDd1Q0xHdTFkT1JibE1heGdo?=
 =?utf-8?B?UnZKa24rcnhLb1lXSnZqMnNlVDlWRXFTeXR2U2tORHN2ZUhKOEpsYng1dmtj?=
 =?utf-8?B?L010cEhuVzZIbnVGZlJjR29Ha25sQ0Q1NGl2NGZoVmFjcG1WRlkrZ2d4K1hC?=
 =?utf-8?B?UzJwbVFJTE5IOTd6OFZuNFNTaXpaNFZ6N25TaTdVZnVqelYzR3VrVTZmS2t6?=
 =?utf-8?B?a1R5eExVb2UxdzNCRWRKWFJISGRSZml0TjRtWG9WRlFudWZYMVZtZy9IQjlr?=
 =?utf-8?B?cUFKUy9yR09jNG9abmJGdmFaMXJrV1g2eUdVNkJrQkNlaUhkeUNJcTI1M09B?=
 =?utf-8?B?UnhYK0IvOHJWNnppL3hUQlBBS2xoSktvWG9DSVY3Uk9PZGZSZy80a04yOGE0?=
 =?utf-8?B?a21LY2ZYZzZabGpITERpTC9xdnR1cnJ4c1BPTS9RVFdmTkZoVzA2WXRrQ3M3?=
 =?utf-8?B?aHFGNWtGa0RydFltSVBRSHJGaWRueWlTZWRDTzBmUzY1TzJYa2QyaVVKRWxB?=
 =?utf-8?B?bHJDYTNuaGZkU21YdzUrUWhBMk1jbFBDYUZDVTRBRVhHeHhGdGFMZlJ4c2FC?=
 =?utf-8?B?UkRva3Y5Z3RLTTgzcHplVndHVERUeXZwa0t1RTQ0a2FrLzlSRWVYQWVjdWwv?=
 =?utf-8?B?VjFZZm56R0RMeVRLK1dPcEdTVXJkNFdwRVZJaG1Ra3lBMGR4V2dMVU1BcUZP?=
 =?utf-8?B?UVZDUlJoNWNkOEd0cC9EdjVIK0Nmc3lFWDdSR0wwNVh3T29DWXdOTlVNL0Uy?=
 =?utf-8?B?cVJQdjNncjNOM2kwZUQ0bGlxOVV0RzAxSVdDWnZFU3hKamM4QnNOVnNzRmdi?=
 =?utf-8?B?U2ppNUpsR1JUdGs5NEJUS25hYm8xK3ZWdTNiWUtEOHVKTDg5RVNkZlpUbE16?=
 =?utf-8?B?UlFXMWYycFh4eGRQYk1LK2RwQXNHNnkxMlF6bEs0VEw5MWhKdW0rbHhHY2Ix?=
 =?utf-8?B?WjlEakNid1J1SWcrQzB4YUJENUZ6dmxLVGYxWERCNU5QcE16dGpzRW5HZHl1?=
 =?utf-8?B?c0NNNkl3VEZUdm11WEpkWng3aGgvcUh1WUZSOElhMitTampwU3VsbkdKNmYz?=
 =?utf-8?B?Y3JEWHNZaUtWY0RtRUwzRjBhWTdIOEJEaHB0emZIMmF4M2FvWi9CNDl2bHVN?=
 =?utf-8?B?ak5ncjhoWG9pZHc0WGFyUm5lTkpXQmxCNEdUMWlJSEpBVmFuUFUxc0pQRDhQ?=
 =?utf-8?B?Q1lnZkQ5L1diN2R0a0lKOFhUdEw0eWxOaGJDVTV2TEFnbHdKSU10djMrK2ND?=
 =?utf-8?Q?XKlHhdrXrsumXaOx9423K4lols1AL61T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEFpWExRSlF3ZklNZkUrcUVOeXh0YVQ0WHd0TVhyVEZkOFNVaVJwL29ZaWdn?=
 =?utf-8?B?bFZiTm9ZRUtxYW5XZXFjUTNpWEY5RlVhd01CaWQrZlZUZUF6Qmx0bDRsLzFn?=
 =?utf-8?B?RUVsOS8yWndFRnR1K0Y4R0E1YlJNTHc0RnU0dXNyRGNtZS9rOGgrbHJqb0hn?=
 =?utf-8?B?YkVCcDZaSnlCNEcwb0N1VDF0cmRTQlA5aDZOVjZrZUVlZmJjY05vMkxSVjNk?=
 =?utf-8?B?MzRqWmR5SkdIUGM4WDB3ajFnVG1xdFFQazVuNEozYWcza3JTZUhOeHMwMW5m?=
 =?utf-8?B?SGxIcDRjM01rUE0xM2NzSEtrVG1LUHRjSmNVRGc5azl2RjBMb0kzRktHZTdN?=
 =?utf-8?B?bnB1NkNSQ2E3YWVUSDMxbHU2SEJiZHNZRkovS3lIdjI1aHdMVlUzT3huelBS?=
 =?utf-8?B?c3M3NXRTWkhxd2REQTI0T044Z0ZZVWhMQ3p4OTdXenNiRjRZclVlOVNubEJL?=
 =?utf-8?B?WllLV2xIaStQZmxka2toZTg2Lyt4ZzRpWUFyRmVmRG0zWnptcXFCVFhnMW0x?=
 =?utf-8?B?SkNGNXAyY1RXcFNNMXV3T0FrMjFtMlNhR2F1MkhyalV1cmZBQzAvNmg3a2lK?=
 =?utf-8?B?YXo3TjNjNGZ5NFpyT1NwYmdVS1d1Qm1hei9qWmNzM3A3UnlCUE8rdjJ1N1Q4?=
 =?utf-8?B?b3U1c01EZU52L0IxQUFkYXRyMm5qR1Axb3llMi8vUWFZODEwY0IxdzgwL1lQ?=
 =?utf-8?B?TnlRNkZzM0F3Uk9Kb2pqbERUZnlFS1ZPNUNPeWl3eUUweXZibUV5UXNkRU5w?=
 =?utf-8?B?eEZLUHUyOWE1MUl6VmJENk5vVm9NeWZLRHpBNEk2bG5Ia1k1bTNkN29ZMmNT?=
 =?utf-8?B?azdYRjNHSVNwcGdPTitVQTlnd0kwSy9iS0h4ZUQ5cnJxeFkzRGI0MUNuWnk2?=
 =?utf-8?B?VXVvZFdERUhEYUJIWThnakkrRkJiaDFTTmR3cGdYRzl4ZEo1TTdZUmdmSzhS?=
 =?utf-8?B?WGtRZTVJbUgxYXhFanNEK2c3OE0yNlV4VHIvdGNRLzNROXR0L2hqQ21RZzZF?=
 =?utf-8?B?Rmo2K3N3UVc4Nm1WWTUrVi83dUViNzZzcWFjb1VyQnFpZWVCbjRhRk1jTzFy?=
 =?utf-8?B?ZXZkZm9xaVNKU3dJZ2wyYzJQbjVpMS9SZGNjNFdtNnBDbU9WQWlGVnh5VzJO?=
 =?utf-8?B?RUpNdnZ0RXJvTUt4blhYM0lWVlF6NVlLVVpDSFlNS2haWjZ4V0VJQWw2ejJY?=
 =?utf-8?B?TzRlWG8zR3FYV2ZnbW96RFRFT2NReDkydkxKb1l1OEpwdEIra3pjZDhjWERw?=
 =?utf-8?B?U1dDUTJDSklCazdaNDJHTVpBMy92WW43VVVRcmtZQ2xnUWRWTHFoeWt6L3ly?=
 =?utf-8?B?SnhMTkhPK0FGNUg0Rk1JRU8vdEdrSVBPSGdvU0o4K3NqY0tXZEFPZHNyKzJ5?=
 =?utf-8?B?ZTYzOGYzVDRURXJ4V3Q0VDA3UTljT0hoZUQyN0tFT044OVVjeTBYUGJ1aVZJ?=
 =?utf-8?B?cjkyTU8zZlZ4aTlZVXAydEdjU05xZXVnM1JEWjgvQVhmR2dTeEJDdllDLy9V?=
 =?utf-8?B?WWQwVXlONTFSZWxXenJ2R2IzTFZLcDU4dnhUNVhEallKU3Mrbm80WU5IaWQz?=
 =?utf-8?B?Q0hMRjRlWGtkNFNlck5CcUFxZE1uckQrbTlmWDB1L3p2TU5pVXVjbk56ME4x?=
 =?utf-8?B?NjFVbXZsdXgzaFVHc1BNQ0wzVFo5bUpLMlh3bkVzQ01KSEZ0dktwZXUvbkgy?=
 =?utf-8?B?SW0rY20zWUhCbkpEaVpxMzB1c3YwVUdKSC81NStmelpzNTgxRXZ6YXQrS0Zy?=
 =?utf-8?B?WUxLR2g1SldrOGJncUNFbzBickxaSVFaTDNkbTFZY0VOZmZvRmhONURQKzB2?=
 =?utf-8?B?MFF5UkczM1BFOXNreUpNSlFOTlNPa01GVTdPdmUwZFY1SzMrczhVV0k2VUdz?=
 =?utf-8?B?NXpJNW92cGFRWHlRdHZldDJtR1dFb3g4bGI2dHJmbm5ZT1BzSkNGdGxWSlRw?=
 =?utf-8?B?cVZhNEV1RjdiQTVxa0Ixc1VjVlNKU0VHT3l3d0JRS1JmNXcxYk1qVmN3aHBB?=
 =?utf-8?B?RElHVTMxVlZBS29jUmNmSndHZjczbm9rT213KytodmxRdlBXcllyV0R5alpw?=
 =?utf-8?B?VHN1RTY2SEZZYlhMMzJIMUdHMEFaWUNVaXVmd3NsaHEzYTBmWnVHQnpTeWRh?=
 =?utf-8?Q?d8jNVX4tyxm/2q/aVrbP7oAbO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716de2ff-387b-4556-df38-08de3ed3292b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 07:49:38.5026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3j7ZutvoqZLcYpZop2o4igq7q0H9JVzhPIiMDcfmO1QafTRhT2n31E8gmGmYLJQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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

On 12/18/25 16:04, Tvrtko Ursulin wrote:
> RFC because the context conversion needs a lot of scrutiny (and passing through
> the automated test suites), while the bo list changes are perhaps a bit of a
> bike shed, although they do result in less lines of code and hopefully easier to
> read.
> 
> BO list sorting is really independent, as is the IDR MES cleanup (which could as
> well have the warnings removed). Just say the work and I can easily split them
> out.
> 
> Series has been smoke tested, including lockdep and game + desktop workloads so
> at least shouldn't be too obviously broken.

Oh, yes please! Some of that stuff was on my TODO list ever since amdgpu existed.

Going to take a look right away.

Thanks,
Christian

> 
> Tvrtko Ursulin (5):
>   drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
>   drm/amdgpu: Remove output parameter in bo list handling
>   drm/amdgpu: Simplify sorting of the bo list
>   drm/amdgpu: Convert context manager to xarray
>   drm/amdgpu/mes: Remove idr leftovers
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 140 +++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  17 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  58 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c     | 117 ++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h     |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  11 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     |   9 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c   |   8 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  18 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  18 +--
>  12 files changed, 160 insertions(+), 248 deletions(-)
> 

