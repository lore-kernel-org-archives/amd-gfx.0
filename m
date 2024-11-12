Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBB6D41D57
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 06:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65EB810E07D;
	Tue, 12 Nov 2024 06:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Ywos/Ls";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FD510E07D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 06:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/DO2/KzzscdwyU3QQCAeV9itrwZ88OQXfS2sHjK4aNa5g71IYguqhFe3s3KFqPt5Cl04MyDB0bNDX+qIPf3aI6gkeWcgoJLiucK4h15IcR/es+lOEWdEAMzIzXE2hhjaxVH3cmsq0fptp+RDRWewdVVxgqAMYlyQz79doOryToeTj7nA9tm0ayrX6h9QvAN/VxAYwSquuTNok2WFnmRpXl2O6LvC4ZCWNF6Yk+vW3BRCx5d4zHAfCEj95Cp4D85Guyol4RbhENdW2I8dGeop/j2Z0POY3Hru0U4dGOFAaJ6meuH3w6hU2oa0DvXiQ/KwkHTsXq5eH8d4Di5RHz5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmEvdqfw+npZFqKIKCzRu+jHxnu9bq4CN3juBdw+tDs=;
 b=FY1HYOEONV2+tNE9A+JVIXod/++nUT6gcLENFGa0cT/dgwroILwnQFCP1NO21vSj/HFp0AaQDUJW7WUuDpnvnm+9HttQ1K1rpxKUCpvmJk5Vq7prqZavlMgDYJKvzeHqBtRDP+xJ4dRUEFbjz4x/zYEHYlwt+YXDAfWzuH0qBAqRG4ec+QPkdWFqzB+EBjPZWu8E6SdXMDaYVExdEGE9O/FbwN6Jxo+LbN0NIby380bMucuMSPhWI3we59UFVhZjcX0y2cE9Q/s00GfJQYSoGI6Gt9T6OFOu723n0FlpZUw59y4sx6PuAmhTm9fYMq1WwUt2lqAXgEW/PPE7Q8BYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmEvdqfw+npZFqKIKCzRu+jHxnu9bq4CN3juBdw+tDs=;
 b=3Ywos/Ls8rNJ+MSfAh8pwAG97ncDaNXDH++hSlrB1C/wm5X82cjhi7V88MTlPJKUa7GQ7jWgqlzAi3P7+i/R5mFaDG2cq07UKqvAfYNv86GESJxQRDe3vtCX+JLnB8946jxB15l40T1rqwMtQ3iYYZ/JDdg2HjaVeGHyA37Nl0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 06:18:23 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 06:18:23 +0000
Message-ID: <4d3e76e0-51ae-4e07-bd41-5b272cd44466@amd.com>
Date: Tue, 12 Nov 2024 11:48:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth Feng <kenneth.feng@amd.com>
References: <20241109053148.13617-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241109053148.13617-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 658d4e34-9b4a-4313-244e-08dd02e1cf5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2EybVRrWWVGNHUwUVdDR3JiRFBKUjZDWm5MK2p6VXFJUy9nZ1V6T3pwanB3?=
 =?utf-8?B?ZUh6OUQ5OTQ5akJhelJQa0RYUlB2TndFQTFtNkVkNWtJOGd4RVRDUHhjaE4z?=
 =?utf-8?B?SUp5N05vNjJSM1JDVWNwdVo5R1QrZTRtOURYZE9CZC96L1IzWklYeHBvUnZ4?=
 =?utf-8?B?M1hHMFlHbUc0K2FOWktERGNkcjRyZ0xTazdNWjhFejJUdUhQLzJtQ28rVlhG?=
 =?utf-8?B?S2R4QkRJMkIvRnMwcnBhRHVHdXBWTkwzNEtlcVY1cTBRd2RyOGg4SDk1OXN4?=
 =?utf-8?B?eUdhd0JYVmwrOGtXK3RZUGxNOXZhNjRBOW1qQkk1WCtmOFB3dWk2WmdLTnpr?=
 =?utf-8?B?WW5rTjNtcXowVjd0bGpaVmNSYlZXdWQyTHprS3RBb2ZSa2t4TTBwOFJUd1FR?=
 =?utf-8?B?S3lzRStzVndQUWlwZDZiWCs0Vjc3WW1nNndRODZIRk9iUERnM2JCNHBDSEg1?=
 =?utf-8?B?OXZTNnUxbzRZSHdhamhKZENLUXowWnpmbDZiUUsxMmsvdzVweUozQytzNnRv?=
 =?utf-8?B?bTZKUEVvaGh3cFFTRXkzekdPK3JSSHE0M1VVT1NoQzd6SHNvZUp5anpPcUVw?=
 =?utf-8?B?NEdSbkN2K1p0K2t6QmVzS1JtUjhoUERmcWRadEJtYlM0Tnl1MHlLVEJWYjRM?=
 =?utf-8?B?M3YwUnBkSkZONDBDUWJSdUkwRXBLZ0VtUzN2amw1ZWl0ZE5XMy9IQkJqeFZm?=
 =?utf-8?B?QmI4dDZ0MCtsdTB5WlV6YW1KaXVyVnJHZHdmSFg5OUM5b3NQVUlPeTZaM1hX?=
 =?utf-8?B?SnV6clcrUTJqZ2JFL0wxZkpYaHJrdlVUMngvZ3JGakVuU0RLSXlQb1VwVW9i?=
 =?utf-8?B?b3ZvOVhYOEFJdTBCRVJTMUZ4Q2VWVk5VTFZtdHVTYVF4OEFNWDBFSGgyWjhQ?=
 =?utf-8?B?blRXMVh2SGlJWldqV1l6TGpFUUUwWjAwbjg3VjA2NGs5cm43T3NpWjJjUUxx?=
 =?utf-8?B?dGYwTXRGaklwNW9GQ1RXa0NPT09pbmxTblZFTktCV29EZmJpZTQwdVF1czN4?=
 =?utf-8?B?N0dBdENJc3FKZDBZNDN1dnk5ZkV1dUlZTnZ1NWpOelhHWWVWTVF4bmVLZTBh?=
 =?utf-8?B?WjhwUGdxN2J0cG1hRVZxQnFsNVFwVmNuTnA1U3FKdmJXVTNheXczejNwNFVs?=
 =?utf-8?B?WlprUkRmQkgxd0luL1J6eUkwQnhENEZwbHZYb0VvdmlWdkhrR3o0OHlSK3Vu?=
 =?utf-8?B?aTAvdTVOL2EwR2F0OGRxYUFCbXFScFFMUXpUUktqZ1JvUXdKMjdVV29FenB5?=
 =?utf-8?B?STFPeVFGWkJycU8xY2FCN1F1L0RmSUUvVkdZeVROMmhBNGJXVzBBQjl5REZG?=
 =?utf-8?B?RUpyd0p0SGRhYitaelpucGpGYTJPNmhnUzhSOWs0UnM3dy91ZS9SSklZRlNv?=
 =?utf-8?B?ZHg0RGwyOE42L0dtM2J3L2lIYXQxRGVQNlBkbEVTMW1XQUN0TWxXWllkL0tm?=
 =?utf-8?B?bk5tTEpkYWFLeFdWZzlsbnRIbm12d05wN3hpajBEeHZSVkRudDhjZnA2cmtZ?=
 =?utf-8?B?cjl2Y0YvSHlqWWtLOEo1QkpFYlhTN1R2SzUvaCt4Yjdna0VJZE1PMnErem50?=
 =?utf-8?B?NGdZUHJSVWgxNVJIc3RxTnk3aExMYm1RbTBnd1VST1FwMHdMdzl6Vnh4OUFK?=
 =?utf-8?B?bmhFQUtObVZ2UXZaeXF2Sm1BNU1LaHB2QlBlWmp1czRxNTk4M0xHYzZ1aGIy?=
 =?utf-8?B?ZGxmK2FldHNKQWN2SklZcVQ2RERYWDFHUDg1aVlMTCtUYUFvL09tWDN4Nmhx?=
 =?utf-8?Q?D50b+3oUWB5fImz61s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDJzSVBCYWh5SU5EMjRaUVZlZmZqd2hKdWpCa3JrKzBjZW03S0FjNmp6d0Mx?=
 =?utf-8?B?MzhIUEI1TkhMbkFpbWx5ZCs1c1ZTendFcFhnWStBMWVBaFc4bGV6M2NzUk9K?=
 =?utf-8?B?alZqbWoxd2hLNUdCODJ0bWsxUmdEYWdRQk0vRFlFdElzWkl2ekNGUGs4OGpx?=
 =?utf-8?B?U2VyNjJUS3p2VlA3azc3KzlOWVdSbDl2b2FIN1REbTh5RzRPbTBXQzlYZTl2?=
 =?utf-8?B?bjJrb25nOFoyUlcxeGx3WHJTNFhpblRIVW51Tmd4OSsvRk1ZSlhSekx4YWNJ?=
 =?utf-8?B?QXR5TDRra0VuTEpUenFsc0l0bFNtVm9nZm1EdC9VNWZvZ2NnZzdtRUJjOVJy?=
 =?utf-8?B?MFhyM1RyR3pBaFp4U1lBTlpIODRhSjhNQklzUXFianRzQ3VXZGRvdWszY1Bw?=
 =?utf-8?B?ZStzM0VZRGQwSlpCeWhOUWhCZEMyTk1zTm40VXViTnBNbGJ1R09OQ2VJZXpw?=
 =?utf-8?B?bnk2SjZncTAweXBDajRZQ1ZYcEJXMFVGc2ppL0l2Vmc0bDVvNUNZNzVVc0NE?=
 =?utf-8?B?MU1Jd3AyaGdSNXdTeW9TV2FWc01rd2ZPS05UMFRTTzBGSjB5d2RWWlUxTUJu?=
 =?utf-8?B?VVJ6a1FwclZuVmk1a2NNVm84d2dJZktFVUk0cnl1OXNkMi9WczRIR1F2eUNB?=
 =?utf-8?B?ZzlNN1NVN1BIZC9qUHo0ZTJCbWg3NXZ6cXpONlNLNzJLWkZraFljK0FiYjZ2?=
 =?utf-8?B?MDgrRFhXTUdMYUVaNjB5Yy9OWDVPYlFMa0g4NTlDdFROWFRVZzZPeWluSUdx?=
 =?utf-8?B?algrQWNLZXRUc0t5bzREYndNdHBiejg3OEFOVE9XcFJDQk5Wajd5YnZUU0NK?=
 =?utf-8?B?VGZ2TlRpY2lJNjNERHNEVjlKbHRJUEpSUWp6S2hkNVhKcWlkUzNFTmhrMU5k?=
 =?utf-8?B?OFo1WU1sNTdkc1c3OXpFRCtaa3NFMTduTDNXanJTS01IQjlFUm5pN1E2Q2Fm?=
 =?utf-8?B?ZmZUbmw4KzR4aGp5WExtaUNjOGI4NWJFRVQ0enJFblFCVm13d3ZwKytCbjl4?=
 =?utf-8?B?QWRYcks4cFlKR2x5YVM0ei95VDY4aXVySyt4R1JEamw0YzRyR0NreUx1M0h3?=
 =?utf-8?B?dC9WaEkzUDFhcTZBMFB2YWRlakI5bURRcUNPWnNsQmxSbTRJYVZTY0ZKTEFI?=
 =?utf-8?B?aDh6TDY4bmRKMUVwVzlRN2hQWjZ1S20xUDNjUTcwOWo5ZFBFNGxhczhORVRk?=
 =?utf-8?B?V2JmSmU4dVg3QXI5T3FIelZVRVR2L0ZEQXlaT0VLSFNGTnhvK0JwdUphYTZK?=
 =?utf-8?B?MEV0NWR3bGhoNENmVDhXaHlEeEsxUHNBcG5oMjJoTUcyV0tNS1FIVHQvWXFH?=
 =?utf-8?B?ZDZjSzYyY29DUEQyaU1BK2YwYkxzOWw4N3VqelN3Y0JhOFErY0Z6OUMrSXgv?=
 =?utf-8?B?RmVQbjBDQkh2Kyt1c3RSSUtrM29sUDN2OFFnQXEzcnpaNm9mVjRQekF0VmZl?=
 =?utf-8?B?MzBxT1pTMmlMeEVqcjBhVGhWR3lCQVZLV05DVVMvemFudnpJb3NScmlDZzBE?=
 =?utf-8?B?Ni9mc0t1cytsVURzUjErRUVOREFhWGI3Mk5WS3FPNCt2K1Q5SmlkK2JFMkFq?=
 =?utf-8?B?ZVB0NWcyMEJWYU1OYlVCSnRGOTFaSEFlbERaWnZVdk51TysrbjJqM2pBajJa?=
 =?utf-8?B?QzlGaGQ5M09zRVkrKzl1d0ZiWXdlK2x0SlFUZk9qbWdtQ09VNi8yMlJkL3c3?=
 =?utf-8?B?TnZLTFlaNVdJR3lpdHF2SDRMU3g5NlZzQTF4NTZKWW5GdjZWOFp6SFVUUnJI?=
 =?utf-8?B?Qms0MVVRb21Qc1hjdDRoZWFnWXlGNUpUa3N2NXg4ajdMK2hGY0VmRWNJdGJt?=
 =?utf-8?B?bThZWTBUYjRzVDFMbVQ3bmVxdEpQS2ptV2dlY3cwV0h5ODJMeTFOV3lMLzVS?=
 =?utf-8?B?TGJ6ZC85VjJicEpoeVJScnlhZUxIdU5qKytyZGlEdjVHNSt1K0hjYzZmSTZK?=
 =?utf-8?B?VDRVeDRSWVorZHI5RHliTzdRK1UwOVRRYVZrMWZkQVRhZkFubnRmMkl3bnhR?=
 =?utf-8?B?dVBOS2tJWTJRSFUvYVdjeHpldGZ4VFVudFJxQnFaZWhCNk80VkRRa1M3TlFl?=
 =?utf-8?B?MFkrUExqWElLUlNISkZnWndYZjVRd1hRS1V3YUFYMlBmcFdQMyswTDNOaVE2?=
 =?utf-8?Q?3o8nGw/NkI2R/vULi33kcw4rL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658d4e34-9b4a-4313-244e-08dd02e1cf5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 06:18:22.9841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTaLOWsIx9R/0xnxzeNuM7CMDhjGgqnnLT0U8l7y8Q3iY4Dr3PJ+IdbKI4n2JbZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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



On 11/9/2024 11:01 AM, Alex Deucher wrote:
> smu->workload_mask is IP specific and should not be messed with in
> the common code. The mask bits vary across SMU versions.
> 
> Move all handling of smu->workload_mask in to the backends and
> simplify the code.  Store the user's preference in smu->power_profile_mode
> which will be reflected in sysfs.  For internal driver profile
> switches for KFD or VCN, just update the workload mask so that the
> user's preference is retained.  Remove all of the extra now unused
> workload related elements in the smu structure.
> 
> Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 108 ++++++------------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  11 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 ++--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 +++---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 ++--
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  24 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
>  12 files changed, 132 insertions(+), 170 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c3a6b6f20455..162a3289855c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1268,9 +1268,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>  	atomic64_set(&smu->throttle_int_counter, 0);
>  	smu->watermarks_bitmap = 0;
> -	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->user_dpm_profile.user_workload_mask = 0;
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>  		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
> @@ -1278,33 +1275,12 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>  
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
> -
>  	if (smu->is_apu ||
> -	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
> -		smu->driver_workload_mask =
> -			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> -	} else {
> -		smu->driver_workload_mask =
> -			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> -		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -	}
> -
> -	smu->workload_mask = smu->driver_workload_mask |
> -							smu->user_dpm_profile.user_workload_mask;
> -	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
> -	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
> -	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
> -	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
> -	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
> +	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +	else
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +
>  	smu->display_config = &adev->pm.pm_display_cfg;
>  
>  	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
> @@ -2252,24 +2228,23 @@ static int smu_enable_umd_pstate(void *handle,
>  }
>  
>  static int smu_bump_power_profile_mode(struct smu_context *smu,
> -					   long *param,
> -					   uint32_t param_size)
> +				       long *param,
> +				       uint32_t param_size,
> +				       bool enable)
>  {
>  	int ret = 0;
>  
>  	if (smu->ppt_funcs->set_power_profile_mode)
> -		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
> +		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size, enable);
>  
>  	return ret;
>  }
>  
>  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  					  enum amd_dpm_forced_level level,
> -					  bool skip_display_settings,
> -					  bool init)
> +					  bool skip_display_settings)
>  {
>  	int ret = 0;
> -	int index = 0;
>  	long workload[1];
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>  
> @@ -2307,13 +2282,10 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  	}
>  
>  	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> -		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> -		index = fls(smu->workload_mask);
> -		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> +	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> +		workload[0] = smu->power_profile_mode;
>  
> -		if (init || smu->power_profile_mode != workload[0])
> -			smu_bump_power_profile_mode(smu, workload, 0);
> +		smu_bump_power_profile_mode(smu, workload, 0, true);
>  	}
>  
>  	return ret;
> @@ -2333,13 +2305,13 @@ static int smu_handle_task(struct smu_context *smu,
>  		ret = smu_pre_display_config_changed(smu);
>  		if (ret)
>  			return ret;
> -		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
> +		ret = smu_adjust_power_state_dynamic(smu, level, false);
>  		break;
>  	case AMD_PP_TASK_COMPLETE_INIT:
> -		ret = smu_adjust_power_state_dynamic(smu, level, true, true);
> +		ret = smu_adjust_power_state_dynamic(smu, level, true);
>  		break;
>  	case AMD_PP_TASK_READJUST_POWER_STATE:
> -		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
> +		ret = smu_adjust_power_state_dynamic(smu, level, true);
>  		break;
>  	default:
>  		break;
> @@ -2361,12 +2333,11 @@ static int smu_handle_dpm_task(void *handle,
>  
>  static int smu_switch_power_profile(void *handle,
>  				    enum PP_SMC_POWER_PROFILE type,
> -				    bool en)
> +				    bool enable)
>  {
>  	struct smu_context *smu = handle;
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>  	long workload[1];
> -	uint32_t index;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
> @@ -2374,24 +2345,15 @@ static int smu_switch_power_profile(void *handle,
>  	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>  		return -EINVAL;
>  
> -	if (!en) {
> -		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
> -		index = fls(smu->workload_mask);
> -		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -	} else {
> -		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
> -		index = fls(smu->workload_mask);
> -		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -	}
> +	/* don't disable the user's preference */
> +	if (!enable && type == smu->power_profile_mode)
> +		return 0;
>  
> -	smu->workload_mask = smu->driver_workload_mask |
> -						 smu->user_dpm_profile.user_workload_mask;
> +	workload[0] = type;
>  
>  	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> -		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> -		smu_bump_power_profile_mode(smu, workload, 0);
> +	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> +		smu_bump_power_profile_mode(smu, workload, 0, enable);
>  
>  	return 0;
>  }
> @@ -3090,21 +3052,25 @@ static int smu_set_power_profile_mode(void *handle,
>  				      uint32_t param_size)
>  {
>  	struct smu_context *smu = handle;
> -	int ret;
> +	long workload[1];
> +	int ret = 0;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>  	    !smu->ppt_funcs->set_power_profile_mode)
>  		return -EOPNOTSUPP;
>  
> -	if (smu->user_dpm_profile.user_workload_mask &
> -	   (1 << smu->workload_priority[param[param_size]]))
> -	   return 0;
> -
> -	smu->user_dpm_profile.user_workload_mask =
> -		(1 << smu->workload_priority[param[param_size]]);
> -	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
> -		smu->driver_workload_mask;
> -	ret = smu_bump_power_profile_mode(smu, param, param_size);
> +	if (param[param_size] != smu->power_profile_mode) {
> +		/* clear the old user preference */
> +		workload[0] = smu->power_profile_mode;
> +		ret = smu_bump_power_profile_mode(smu, workload, 0, false);

What if internal driver call has set the same profile preference? Once
this is done, that setting is lost. There is a check to make sure that
user setting is not lost, but the same is not done here and cannot be
done with a single profile mode value.

Thanks,
Lijo

> +		if (ret)
> +			return ret;
> +		/* set the new user preference */
> +		ret = smu_bump_power_profile_mode(smu, param, param_size, true);
> +		if (!ret)
> +			/* store the user's preference */
> +			smu->power_profile_mode = param[param_size];
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index fa93a8879113..cd2db06d752b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
>  	/* user clock state information */
>  	uint32_t clk_mask[SMU_CLK_COUNT];
>  	uint32_t clk_dependency;
> -	uint32_t user_workload_mask;
>  };
>  
>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
> @@ -557,12 +556,10 @@ struct smu_context {
>  	uint32_t hard_min_uclk_req_from_dal;
>  	bool disable_uclk_switch;
>  
> +	/* backend specific workload mask */
>  	uint32_t workload_mask;
> -	uint32_t driver_workload_mask;
> -	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
> -	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> +	/* default/user workload preference */
>  	uint32_t power_profile_mode;
> -	uint32_t default_power_profile_mode;
>  	bool pm_enabled;
>  	bool is_apu;
>  
> @@ -734,8 +731,10 @@ struct pptable_funcs {
>  	 *                          create/set custom power profile modes.
>  	 * &input: Power profile mode parameters.
>  	 * &size: Size of &input.
> +	 * &enable: enable/disable the profile
>  	 */
> -	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
> +	int (*set_power_profile_mode)(struct smu_context *smu, long *input,
> +				      uint32_t size, bool enable);
>  
>  	/**
>  	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4b36c230e43a..1e44cf6fec4b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
>  
>  static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  					   long *input,
> -					   uint32_t size)
> +					   uint32_t size,
> +					   bool enable)
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
>  	int workload_type = 0;
> @@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  		return -EINVAL;
>  	}
>  
> -	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
> -	     (smu->smc_fw_version >= 0x360d00)) {
> +	if (enable &&
> +	    (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
> +	    (smu->smc_fw_version >= 0x360d00)) {
>  		if (size != 10)
>  			return -EINVAL;
>  
> @@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  		return -EINVAL;
>  	}
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					  SMU_MSG_SetWorkloadMask,
>  					  smu->workload_mask,
>  					  NULL);
> -	if (ret) {
> +	if (ret)
>  		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> -		return ret;
> -	}
> -
> -	smu_cmn_assign_power_profile(smu);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int arcturus_set_performance_level(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 211635dabed8..d944a9f954d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
>  	return size;
>  }
>  
> -static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int navi10_set_power_profile_mode(struct smu_context *smu, long *input,
> +					 uint32_t size, bool enable)
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
>  	int workload_type, ret = 0;
> +	uint32_t profile_mode = input[size];
>  
> -	smu->power_profile_mode = input[size];
> -
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 10)
>  			return -EINVAL;
>  
> @@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>  				    smu->workload_mask, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 844532a9b641..4967e087088b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
>  	return size;
>  }
>  
> -static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
> +						 long *input, uint32_t size,
> +						 bool enable)
>  {
>  
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +	uint32_t profile_mode = input[size];
>  	int workload_type, ret = 0;
>  
> -	smu->power_profile_mode = input[size];
> -
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 10)
>  			return -EINVAL;
>  
> @@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>  				    smu->workload_mask, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index f89c487dce72..b5dba4826f81 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
> +					  uint32_t size, bool enable)
>  {
>  	int workload_type, ret;
>  	uint32_t profile_mode = input[size];
> @@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  	}
>  
>  	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> +	    profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>  		return 0;
>  
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> @@ -1080,18 +1081,18 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  		return -EINVAL;
>  	}
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>  				    smu->workload_mask,
>  				    NULL);
> -	if (ret) {
> +	if (ret)
>  		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
>  					workload_type);
> -		return ret;
> -	}
> -
> -	smu_cmn_assign_power_profile(smu);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 75a9ea87f419..2d1eae79ab9d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_context *smu,
>  	return ret;
>  }
>  
> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int renoir_set_power_profile_mode(struct smu_context *smu, long *input,
> +					 uint32_t size, bool enable)
>  {
>  	int workload_type, ret;
>  	uint32_t profile_mode = input[size];
> @@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  	}
>  
>  	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> +	    profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>  		return 0;
>  
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> @@ -891,17 +892,17 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  		return -EINVAL;
>  	}
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>  				    smu->workload_mask,
>  				    NULL);
> -	if (ret) {
> +	if (ret)
>  		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> -		return ret;
> -	}
>  
> -	smu_cmn_assign_power_profile(smu);
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 80c6b1e523aa..3cc734331891 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>  
>  static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  					      long *input,
> -					      uint32_t size)
> +					      uint32_t size,
> +					      bool enable)
>  {
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +	uint32_t profile_mode = input[size];
>  	int workload_type, ret = 0;
>  	u32 workload_mask;
>  
> -	smu->power_profile_mode = input[size];
> -
> -	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 9)
>  			return -EINVAL;
>  
> @@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
>  	workload_mask = 1 << workload_type;
>  
> +	if (enable)
> +		smu->workload_mask |= workload_mask;
> +	else
> +		smu->workload_mask &= ~workload_mask;
> +
>  	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
>  	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
>  	     ((smu->adev->pm.fw_version == 0x004e6601) ||
> @@ -2658,25 +2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  							       CMN2ASIC_MAPPING_WORKLOAD,
>  							       PP_SMC_POWER_PROFILE_POWERSAVING);
>  		if (workload_type >= 0)
> -			workload_mask |= 1 << workload_type;
> +			smu->workload_mask |= 1 << workload_type;
>  	}
>  
> -	smu->workload_mask |= workload_mask;
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					       SMU_MSG_SetWorkloadMask,
>  					       smu->workload_mask,
>  					       NULL);
> -	if (!ret) {
> -		smu_cmn_assign_power_profile(smu);
> -		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
> -			workload_type = smu_cmn_to_asic_specific_index(smu,
> -							       CMN2ASIC_MAPPING_WORKLOAD,
> -							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
> -			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
> -										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> -										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -		}
> -	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index c5d3e25cc967..1aafd23857f0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2528,22 +2528,23 @@ do {													\
>  	return result;
>  }
>  
> -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> +					      long *input, uint32_t size,
> +					      bool enable)
>  {
>  
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +	uint32_t profile_mode = input[size];
>  	int workload_type, ret = 0;
>  
> -	smu->power_profile_mode = input[size];
> -
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 8)
>  			return -EINVAL;
>  
> @@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>  				    smu->workload_mask, NULL);
>  
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..695480833603 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1719,21 +1719,22 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>  
>  static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  					      long *input,
> -					      uint32_t size)
> +					      uint32_t size,
> +					      bool enable)
>  {
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +	uint32_t profile_mode = input[size];
>  	int workload_type, ret = 0;
>  	uint32_t current_profile_mode = smu->power_profile_mode;
> -	smu->power_profile_mode = input[size];
>  
> -	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 9)
>  			return -EINVAL;
>  
> @@ -1783,7 +1784,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  		}
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +	if (profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>  		smu_v14_0_deep_sleep_control(smu, false);
>  	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
>  		smu_v14_0_deep_sleep_control(smu, true);
> @@ -1791,15 +1792,16 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -										  smu->workload_mask, NULL);
> -
> -	if (!ret)
> -		smu_cmn_assign_power_profile(smu);
> +					      smu->workload_mask, NULL);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index fd2aa949538e..63c4f75fa118 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
>  	return ret;
>  }
>  
> -void smu_cmn_assign_power_profile(struct smu_context *smu)
> -{
> -	uint32_t index;
> -	index = fls(smu->workload_mask);
> -	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -	smu->power_profile_mode = smu->workload_setting[index];
> -}
> -
>  bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
>  {
>  	struct pci_dev *p = NULL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 8a801e389659..1de685defe85 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
>  int smu_cmn_set_mp1_state(struct smu_context *smu,
>  			  enum pp_mp1_state mp1_state);
>  
> -void smu_cmn_assign_power_profile(struct smu_context *smu);
> -
>  /*
>   * Helper function to make sysfs_emit_at() happy. Align buf to
>   * the current page boundary and record the offset.
