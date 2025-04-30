Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78638C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 14:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA8810E7D3;
	Wed, 30 Apr 2025 14:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHfSgUAS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F88410E7C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 14:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn6bqhp5ujLvr8v1etpSB/IPFifu9SKSiDFffGEX6wzhb0G3EuXafORX4QNReAOAuyGzRisF2pVQSI6P4VkOCpD8/opRzbBeNyb3SRv3Q8Ad4j5NKOZJufzuZ3rMpUksYzMF9eZuRYsWAZ1ojRxSN+3KhPME/Ko1qOFi38DOrLDXsGxGKjHYXlsHsYMksQjaqd0Ag8c6MMthp4ibj9hnECrd/jL+BJPPaq0tqR7s36ad8KH983WF7oGsoIDmDeG3a+hIfMyCRmAx8/AsTXyRybohPMzah7taUv8HwDhS2cZo2S01eVsm6moZu2YR0jMvNM1GxSx6GacSbyRiZgjL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvBH71QSMcy/NROcslrmQ/QwKvYIPEgAhipWuHnUnjE=;
 b=yEB+KQvORDKydGLQEVXtegnOU8+CO9BdM3wDrTfxyEu0rqVtYQK74Z/WDwkpAx9FCYQuwcma953d+VMwbwQOmNfgbtEtMCvAYhPsnCU0sYDAvdbjwLZIRpM6TNns130SnNqGfyCkwly31wfEINfsaBzo/5yiKpZSrrh0svD7VxhibMJmpIJZmV3FHnHr29cHrgEKpI+xqHPN5KaWHdUh3FRS7CQAgfFISpEA8fHEW0m93FR/xqNgFaTNVmO1R2gTCn7cNmbE9Qn8aDrqWdYe7ZRo8O2Boz0g1BQhSJUyHlBlNCMa/FXh+bVO/jK5PE9wih98MS+f51exkzIugJr3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvBH71QSMcy/NROcslrmQ/QwKvYIPEgAhipWuHnUnjE=;
 b=gHfSgUAST3a1e5PNNBDBWaxpNSB6UzBaJIcTUIN9Zumpae17aQKBLIUDGY1CAHkKIeQ2PPbsMKb2JjX2dkXxtANaedWsFtFvs5GXQjw50raEoQUaaSy3JbQC2VT3e0a81NbqmiJYP5m7mE6csfhYmwnEE93tG7hBHRK99Bu19b4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 14:41:01 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 14:41:01 +0000
Subject: Re: [PATCH] drm/amdgpu: properly handle GC vs MM in
 amdgpu_vmid_mgr_init()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Arvind Yadav <Arvind.Yadav@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250430133405.2592112-1-alexander.deucher@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <0e16f4ac-6df9-a66f-eeb1-19cc545d69ab@amd.com>
Date: Wed, 30 Apr 2025 20:10:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20250430133405.2592112-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BM1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::22) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: e692fd9e-7e0b-42ca-dbda-08dd87f506f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEV1VDl1VDlHdTc0MHRPcjBmTCtvSGVaWEt1YlU5T0tPeWVJYzFPMzBTSXlT?=
 =?utf-8?B?bXM5cUhqMjQzcEFQRnAwcStKL0lhV1ArcEdaSFJ4MXpuZllDQU5UMi94WE1w?=
 =?utf-8?B?QW5KTERvbldqMTN1TmdveENaK0lFQThRRytSN0VZTUpuV3BuYnZPTVlZbW1p?=
 =?utf-8?B?bDVmczNQUmtqSHpqMnBnT2xUOHJmamZYQnlQbkdNOUQ3NEcxQ0dTVnhUQS9J?=
 =?utf-8?B?Rkk1L21ycU0wME5HbjNUeDZiQXRaRDBpamltUWM2SVU5aE83Zk8vK2hISWVp?=
 =?utf-8?B?dGt6Ym9aTjVVdE9hVExIRWw0elpyYkFsV2xIMWhsNHZDZmxnMkpGM0FXcEhE?=
 =?utf-8?B?T3cwSFJJRkg5Wjk0clRkQ3pqVXNiU0Fib2xjM1JtU3pSS2tOTVlDWC8zZWRk?=
 =?utf-8?B?c0dkbDhyVWJOZEhNUmdpakZNTVdzemJDSE5zOWkyeGlVTStZa0w1SHhkNnlH?=
 =?utf-8?B?SklSRk81b24yQzdwUVFMcVJhamhvUWM4aU50MzA5L25xZDNSNnZSZHpMRUtO?=
 =?utf-8?B?R0NlakhFdzQ0aWUvQkJINTkvaXVZNXNiTU1hVjVLMFVRZWYya1gvRU5mUyto?=
 =?utf-8?B?bEtBdDViZWtHTURVY3BtTTQwd1hDYm5vZXJjeDRuejN4VC9KZk1oWmROQnlU?=
 =?utf-8?B?OVhVaWFIais5TGxUeHAwaGJCNFV4cXVkV3M5K2tzWklFU1RiWHBmT1dIS3Q3?=
 =?utf-8?B?QkEwNGwwYkJ2UzdkUmx2cHpZdFcxOTd3TG5IM1llOFhYVHQ1am10RzVQMlB6?=
 =?utf-8?B?M0ZyVkhQNExrSFVKMnBoMVNQcDFISWlVR0w3aHM2QXBNWS9LSWlhRE93dUpW?=
 =?utf-8?B?VmhEcjN0UFNrTWFTSGRlQjU5Rk42d0dycVBTNnBxSzRrb3VxRmw4VUNNeGRI?=
 =?utf-8?B?VzM4cTd6a1E0NXpzbDcxYlB5cm5Bc2pWZWgzWTBWL1lPSXdWK3JOZ21qaHEv?=
 =?utf-8?B?V1d6NEJZdm0rejJIY2lHRGs1ZUliRENtcnBBdmhyNjAwYnV5ckpmUloybzhs?=
 =?utf-8?B?LzBReDdGdHJGR0JWdVptQUVhNWN1NVY5LzBjM1U0Q3p2elFyNWJDalZSWWhG?=
 =?utf-8?B?N3RNZmsreXdRTXkxK3V2d251TFFEN2tQM3RGN1k3NFN3cndpbHJmTGlMVkdQ?=
 =?utf-8?B?eDJoN280d1pGNEZjM2NpY0dSQlZWcHJxR0dlRHhobWdqbm53ZjN6aHpZRlFD?=
 =?utf-8?B?S0RzdTVsU3hjem1NUzJjRmZkdnBaLzhPZ1JkYkc2Y2tkSzE0ckc5Y0lsbWFN?=
 =?utf-8?B?N0h1THU0T21BM2xGU1JnSGVHM3gvSVRKZERNN0hjZ2VOaTV6UDdKMERuN1Bu?=
 =?utf-8?B?TG9oYzRBRkNpY09jUzhUcEJpU1lqRzZuWHB0cU5mRXBHeTl1cHZYc3BVemdR?=
 =?utf-8?B?ZVN1NXllTlRTQ3FIbjB0TDlycjc4WXdjN3cxbUJNMXJLYTdscWdBOEhPWUwr?=
 =?utf-8?B?UmhwQXQ4VEdYRlZTTnJpaUI0amlaMVpneThPVjVkdTVVRG1TcXV2bEVKR0dr?=
 =?utf-8?B?VHdoRDEzMUVjSlYvT2xjYmZSVUJEeHU1dFJrYUpBM3NTSU1tb0FwamQyWXRo?=
 =?utf-8?B?SzVpRkRGVnAwSmFiaXRrYUprYjA5aXAyUXhGVDJMNTI3cWk1OHV4eGlvLzNn?=
 =?utf-8?B?RXIxSWIxV1E5ZERERXFUQUZzdTA2Q2RRd0ZubXFlNVphSGRwQ1BaY1hnazli?=
 =?utf-8?B?aEFUOFdSYjM3Q0JEU2xnMzFnSy83Mm9PR1FmTmtiTElaS1pQVi94TzlKU0Zq?=
 =?utf-8?B?M3lKSkdoR25Gc1B5SUtJeFlpdGdEZ3AwbTEzRXRBTEtibUFPZGU0YkszVVQr?=
 =?utf-8?B?Z3lmbFBFY3g4WW1rMW5pSE9oTEtCUy9rSDR5OEFCWHVlVWtvcVlvOVE1cnkx?=
 =?utf-8?B?WitzNWFBQk5IbmJSaE9CSEs0RkxJOTI3RnQ4aEhjUk4zUEJKODhCTUNBcDJN?=
 =?utf-8?Q?xKBHDxV/T+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEI4RmJCN2FQY1lxNXJDQ09NUnZ3ZGc4cjFPOTZocCthREUzK2J4aU94QXBM?=
 =?utf-8?B?eGIwSDJwT2tlUTBoOU04RFl5SkxBTmVHejZramhDQ00zdS9mSzhnTGVBVFBj?=
 =?utf-8?B?T1k2eVRaekpRS1UyME9JY2lWZHpCTGhpeGVEbmgrZjFSYVUrSy9CRWNib1Uy?=
 =?utf-8?B?U1RBd05QeVpsWFNIRG1Nc252REpDdngyQU5NMkhmWDhBMU9sQmY3NHVCZzgr?=
 =?utf-8?B?S2xBMGZDU0prNmdRenE5L1VKWkw3MUMxNTRRL2NwMlZZSkxQQ3FlN3N0Y1V4?=
 =?utf-8?B?TGhsYjRBbU5FN3hnMEVVSU1NMUswYkM5OTZGVkYvQjE2Mk03U2ZSTUxzZlMz?=
 =?utf-8?B?andjeWhZNlIxRW4wQXVEWEMxVXgyNWVhK2ZNYTVYRzJ6SUxiUU9PbjNTb2dV?=
 =?utf-8?B?Q1lRYzNTV2c1cFdzWnpJcW10TDUwcWxJZnNSNGpSK3RkUEtIaGk5c0lJMmdQ?=
 =?utf-8?B?cVZBWlUyV1hPbVVjekE1YWZYNDEveU9ycFFYWm9lUjhTaklhd09pRmpSUFpv?=
 =?utf-8?B?bFQyRmxiWXRkdGtWMTJCQTFDditGbTRscEFVUGZUazR2YThyNDIzUjFSRVpz?=
 =?utf-8?B?UzlBaFRVS1UzdDlOWEg3YlZIQ3Nib0Fxekg1cXovNlg5cmM2VTdUdDU3Y1ph?=
 =?utf-8?B?MFo0VVdDVkRQMktaTEtKWlRmWW9paWg5OVRsYkwrMlpRTWQyMTVlZVpJMVZy?=
 =?utf-8?B?Vzk3SnBjOVBQZ1dzNEx1M254V3NHK1gvSTFsZDZXWDc4R1ZhaXhGSXgvdnZL?=
 =?utf-8?B?V1NVOGM4d3Vzb05yMk42RHNkMENQSU94bExmSW1qUERrUU5zdG81MnVLNm1Q?=
 =?utf-8?B?Vkl6M0V6SzNxQXFBSHZjOHBYQ0VzWVdkeWl6dnh5K05SOVVWNVBGbDlyUDdh?=
 =?utf-8?B?dHV6dmZJNjA2cmNOeHNLNmd6Z0JtaFFKRFlvWDU2TDRRZHRPN1dWZkl4SFd3?=
 =?utf-8?B?aWg5aHN1ZmtOcUpZa2JZWHd2Rkp4UGxEaDFBZzNRSWZROUMwQThPMzdTN0tx?=
 =?utf-8?B?ODZOT08zQnk4M0FDRlVSZllycmYvMjcyMEIyM0V0aDZzTnk2YVpaOEpIYjZQ?=
 =?utf-8?B?SjhRQXk0eDZBaTFPdnJJWGxhNnhGelk4cFNMUmJYZTZLdkd5M0xDWjJZK2F1?=
 =?utf-8?B?ekhUeUF2cXI1NHdGT1EzTzdRZy9MOHVVS1FiTThtZHluZ3VpUVNUQ2pvWVYy?=
 =?utf-8?B?ajV3SzBCSEtOY3FVdkdmcU5GOTV5STRsK01PZjV5cVlzMEpVekdCSHZnTHlR?=
 =?utf-8?B?MUszRmFaV0wvSmc5czhGY3pLZnF1UmZlbzBIbFJkTVduc0c5a2tIblJpbWNm?=
 =?utf-8?B?Vkd1U1lEdVBKZXNJc0c5RDBveklROEpqYlUxTCtCZ2dSVWtHenlqN2FrN0Rw?=
 =?utf-8?B?SzZ3bzF1KzhWb244QTJLdCtMRGp4ckxnRkJCcjVranRrNG9kY1pEeVB5OExx?=
 =?utf-8?B?S1RDWWJuQW1HL2VVdExtRTlLck1waWhENFk4VVRCSEpwZVJqQW1MSHlZanVQ?=
 =?utf-8?B?cEJrQ1Zua21WWExoYWpPK3JkSHRCRnd2cnFwMG01VUt6YktNeVgwMGlOTDBY?=
 =?utf-8?B?UjFmK3JtVnVsblo2eXkzT0NTd0l5Q29scXhhSit5MWdLb2p0ZEIyYU05a1gv?=
 =?utf-8?B?Y1l0dWNPVE5jUkxOOXh2VWFRb2VSY2VlSzdNNFkrS3BIMTBSaHRuSUE0bmh5?=
 =?utf-8?B?eWRteWY1SlVKN09MMmkrR3crUWp0T3RkWWtPbzZ4TTVscW1CeWdnZXVoUVpO?=
 =?utf-8?B?RU1ZdFZzUGEwMENmb3J5TGdBRkxOYjFJK3hzSGloV0k4Qm95Q1JDZHRWbndx?=
 =?utf-8?B?VHU4cFliMjI3dUZzL2dHUzJmRFp2b0dPckZibG5uWmMxU1BQKzdGRW5IdmJH?=
 =?utf-8?B?ODVUZ0dhdG1ISzd4OVpPVmtreE1xMGNtSitLY3NVUnIxU2dlT293aFdlOVlk?=
 =?utf-8?B?TmZJcWdjRkZIcTlhQ2d0TVJ4NzVLWFhzWTNpakFKL3Vxdjd3NjFvQUdVbkM4?=
 =?utf-8?B?WkU4c2tsWkM3VThDZW5hRWx2cGlsY3BsTXN2NW52Zm1TSzVMV0NOZzJoS1g5?=
 =?utf-8?B?TzJFaytJNS96bVhBWlI5WEpBbCsvK2d0ajA4aGRiTVRldy9Jckk4Y2w3STZt?=
 =?utf-8?Q?tJwA2neAxLQYF46b4wIB0+tIb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e692fd9e-7e0b-42ca-dbda-08dd87f506f7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 14:41:01.2304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qVemiN0nzGy1Q5tj2Ag+IRBpi1v71t/5Vb2GW7YxuKGvSAPywcNUQ2lrnLZzyNLe1O/6DyR+dTwEBROt+Yv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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

I also thought for previous patch but else was doing that.  We can use 
something like this.
just alternative solution.

if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0) ||
         (!AMDGPU_IS_MMHUB0(i) && !AMDGPU_IS_MMHUB1(i)))
         id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
     else
         id_mgr->num_ids = 16;

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 4/30/2025 7:04 PM, Alex Deucher wrote:
> When kernel queues are disabled, all GC vmids are available
> for the scheduler.  MM vmids are still managed by the driver
> so make all 16 available.
>
> Also fix gmc 10 vs 11 mix up in
> commit 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when disable_kq=1")
>
> v2: Properly handle pre-GC 10 hardware
>
> Fixes: 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when disable_kq=1")
> Cc: Arvind Yadav <Arvind.Yadav@amd.com>
> Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com> v1
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 12 ++++++++++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  2 +-
>   3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 359c19de9a5b9..5dd78a9cb12dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -576,8 +576,16 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>   		INIT_LIST_HEAD(&id_mgr->ids_lru);
>   		id_mgr->reserved_use_count = 0;
>   
> -		/* manage only VMIDs not used by KFD */
> -		id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
> +		/* for GC <10, SDMA uses MMHUB so use first_kfd_vmid for both GC and MM */
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0))
> +			/* manage only VMIDs not used by KFD */
> +			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
> +		else if (AMDGPU_IS_MMHUB0(i) ||
> +			 AMDGPU_IS_MMHUB1(i))
> +			id_mgr->num_ids = 16;
> +		else
> +			/* manage only VMIDs not used by KFD */
> +			id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
>   
>   		/* skip over VMID 0, since it is the system VM */
>   		for (j = 1; j < id_mgr->num_ids; ++j) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 7648e977b44bc..a3e2787501f18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -896,7 +896,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * amdgpu graphics/compute will use VMIDs 1-7
>   	 * amdkfd will use VMIDs 8-15
>   	 */
> -	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
> +	adev->vm_manager.first_kfd_vmid = 8;
>   
>   	amdgpu_vm_manager_init(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 7f5ca170f141a..917d894a1316a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -828,7 +828,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * amdgpu graphics/compute will use VMIDs 1-7
>   	 * amdkfd will use VMIDs 8-15
>   	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> +	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
>   
>   	amdgpu_vm_manager_init(adev);
>   
