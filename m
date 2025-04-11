Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65425C369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0199110EC45;
	Fri, 11 Apr 2025 17:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uo4AvqbB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD1610EC45
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTtK5PFuR+e+ubdjfmWYeILqOu+YMX4aR6pDTV2h5t0AMVMj9u7RiIrdTXAmc3ECOCQ1IYz5F87m8VaxrQNZAx4YwJ7aXgI3jfJrCyIFvTLaH9QxNuku+VOJxBDEhID2R4J4IgJVnwPNWwjHNeBjLer2UQE9L3emeSmax6cNPjeB1btbnTH7htuQKkVMtSGl/bYlxU4nlKpjsNNi5e8Wb0dAoOtrI/RsO9eUdV0m/yj7akDQQCJEHS9baoJ2lpXgGNfRDYET0ULPbYEZxlHlRfN2SD8tSqA+UbxvnJ4Yfu7sSCUpMhVOooNIK+OFcELCQ1xpepuHTJEPRbEJoV4aKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpApf5msM7PL2M6OCw/te9zWv5Me15VFuohiEE6j/V4=;
 b=NtqWb/Wr2q7AmgJ4si0bDQmuMdtSpvJPx0Ga8P6sW/0/hirtwIcqOSmgNisVMZ/QPa9st23k5JSDLDqZMHDDBorP6ldeiGS4C7hgjfk2bdW8Y1AxdOsYk35a4t5N3uG8nySJjHFVw/A4cuS38F+WFzH+ITgHyCRwm5gy9b93RdqGSPDvznvx8gEaCMu712U2hQWyu8PaANlwmsbT7zP/sChUNOHdMmurHNGWag+B75pbttnFHv9K8mSPAUTwDSNxj1TQ7SccbRnErgUosslyHtRF8xCdcTRGF7KUUvC2DWRP+a+WwHkcydXaLIgiAiOUvKeP8kmYX19Q2cRdmj7dEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpApf5msM7PL2M6OCw/te9zWv5Me15VFuohiEE6j/V4=;
 b=uo4AvqbBcHXuf0o0fy9kUC+VDys3T7Ecdpo/t16VX7jwoWlNDQLUGtrkw1trrgiERrZdpQHH7HnR+tphIjubvK7cP6TGCRtK7ZCJMClLoQRBz4mJ4hiTJD+WPBR+Pa2q0lyZSgSoPF0Mg3aEy0V6d8AHPQJzTsT8yncYRlgcQsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 17:26:52 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:26:52 +0000
Message-ID: <7031b353-22ee-4784-a7d4-ce224e9423d5@amd.com>
Date: Fri, 11 Apr 2025 22:56:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] drm/amdgpu/userq: add helpers to start/stop scheduling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
 <20250411141228.2722962-8-alexander.deucher@amd.com>
 <837e1e3c-cbce-4d55-aa47-b6a35fdc104f@amd.com>
 <CADnq5_PTJTv9H5hwMEnBFAq68o-qKEqFiDdT6WbjbMCZMJKQcg@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_PTJTv9H5hwMEnBFAq68o-qKEqFiDdT6WbjbMCZMJKQcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 086b36bd-2b8f-43b9-64ab-08dd791e02e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVc5cHIrZ1pDYTE0S1VJa0xndjBYVnVIM1JMOTQxUGhtd29HQ1NnemkwdE04?=
 =?utf-8?B?RFN0MitIV0ZoMkE3bkJSakdQdmdyMnNjeFQzbEJhSUwzYzZybVo4bFB0SWpT?=
 =?utf-8?B?OEZ0cGVWNzBZVVkzcUpHNHVwODE0WU10ZkoxZFNIdk1yMDhoU0FhSitLT2l0?=
 =?utf-8?B?cUxyRWlFTXZjcktkQ3ZVZW96YkRoRTlSaGEwdGZNOHh3NGpVa0FLS2R6NWx3?=
 =?utf-8?B?SmJuY3NHWlBSUG44M21aSFFOU1E1WE9URlM0eUdOSGE5d1FGZVRyQzdOdjF5?=
 =?utf-8?B?dUY5M2JyZFU5MW5KQnE3d3Q2MmxDYXAzWFRMU2t1SjJQTXZJL3hjTG9tN2ZQ?=
 =?utf-8?B?MnJKMmh5bTZEZlU1WStSY0RrMlRlRWdpMmNzM08rOWMweDZITy82ajRMQnY1?=
 =?utf-8?B?dFFNbndwVDdWbEdjOG1LTkVia2M3K0JlQ1NyZDdtaVFZc3AzdDZUUHVZcFNN?=
 =?utf-8?B?N3RLbENoa1BVNFNhQXM5UCtqaXFxeFFuTG9NYzB1NkIzdEZhQlF1SFdmcE1l?=
 =?utf-8?B?RnF0UGFJRklXWUh2MmZPLzNsM25CT2JSc0hVdXFqUE9ydVdwZG41QjFjaTc4?=
 =?utf-8?B?WXpEVXpmdHFxc09vKzJMZ0YwQTJBRmZ1cW1sNG1wYzlkTnB3aVdKc0pZdVFi?=
 =?utf-8?B?a2JUSTUvb01rTEFKeHJFcklFMjNjOHkwWFRpc2UvUE5OUzc5NytmR3hMVXQ5?=
 =?utf-8?B?dEdzTU5zZEtiK2gxVERDQlNtTW84Zm9LRy9TdGJpdStaRWhGMDNFVFg2QkI2?=
 =?utf-8?B?NFd2YU44RkZlcmF5aWpzQnNrUXR2ejFTY2FJaFlhQUI4c1BBRHJVRXRxeTRm?=
 =?utf-8?B?b1ZoZitkVHd1MEM3WDRiYU55aFg0RDJvcDVwQXVtZEhyUVBRVCtMbVg3VUNI?=
 =?utf-8?B?bTdRcmZjV2JxZnhkMHlIMmNkaVFtd3BoTlVhMHRvNW9OMjFZZXpmNjAwalQ2?=
 =?utf-8?B?b0NzSlBVNUFYdE12UEFVLzJPTEtHNUhXZ2pJd1p3WHZKOVNKSG85bzhnemh6?=
 =?utf-8?B?TFlENzJIS1Q3QkxvaDR0SFNKT3FVK1lTQmtZMnNDVFpjbUxkdWFtTzJoZnVv?=
 =?utf-8?B?L1IvTEJhUTY1K3NNd3phK1gvM3ZHMGZLZmNBK0F4SzhJZXFQcFJKQ3pEN0JI?=
 =?utf-8?B?R2JGTTM2SS9VOE1ydGJ4cHZ0MnNaczUwUThBbnlvbCtmUmQrSWZYdysrR2NR?=
 =?utf-8?B?UlFlYi9IbFZFTWVSSmVFd0FLaUtIb0N6VERYdU9DelhicUZaNStrZ0xGVlRk?=
 =?utf-8?B?ekg1RWFjMnRBNG9LeVJraTlYZG9idklFNnZsZ2VjaXdQZlNDemczRnRzK3Nq?=
 =?utf-8?B?MnJUZUp3bk9VakM3UjRMU2d2c3lCMmJKc3ZxYVVzR0VPcU1sKzhTVTJGRnN5?=
 =?utf-8?B?TlRPRDFjQlRyZWczRmpoS0VtWS9VS0tnZmx3cHVXTEtHbUJBT1BRZVpTNFpk?=
 =?utf-8?B?ZjV5YWZhTDlpbUpFY2Yzb3dRb1QvclVWbEl5MHMrNE9CM2NlaDNPRW5scUpv?=
 =?utf-8?B?aDhNOFFTM25ETTd3TDhZZ0grY0RWeVJSZ3djWXJWVjhoWkRXZ3Bsa0k2NmF2?=
 =?utf-8?B?MWI1bkx0VzhjOVBBdlNKU3RxN3poNjh0KzZ0Wk5ZY2ZCcTRyeDZabnlUejhY?=
 =?utf-8?B?cTBiS09adzBKRjJnVU9IbFJBazIxdnJ2ZmJEWlNUczZBS0xaZ05kbWd5VHhK?=
 =?utf-8?B?RitsbGEwdUgvWlVDRVhYeFBGazdqbk80emxKUFBQa2NNMXYzYXIrQURtOFd6?=
 =?utf-8?B?emc5VU91QTYrZkt0d2duc24yU2t5Z2ZVdkZYOXEyZVdkRHRxRnh0MWVkd0hL?=
 =?utf-8?B?YmtXenk5dFlSTWNrMmM4Y1o4clRtSTFMU0NJQUVMbjZVSG4wcjVPVjNQV3Yv?=
 =?utf-8?B?QzBsQXN5WGdUUXdQVlhLMmF1cGsyK21TTHhTYzRVTjQ4czNEd1ZxdFl1SU0x?=
 =?utf-8?Q?SUGDmn2gpys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBlUHp6WVFsQmdoWWxMKy9hUlJrME1nMkVxMHRJdEFJSmF3NEFRakdYMjlO?=
 =?utf-8?B?Y252bHlTUE9EU085T2xCMmtwL0l5SlBOaFF3Z09IMXp5ZHFlL0FQMHZIekp4?=
 =?utf-8?B?K084a05XQWh3aXZRMFFFWERIZDRUaDZyMXRWZzU1MlkzL2k4c2RSQ21adzBC?=
 =?utf-8?B?eU1XQlFlTUxLRy9XZFBiTUlkNkhQOUE4VmtqM1l5dFdNN0Q3K2l1R21WY1lR?=
 =?utf-8?B?MDZ3SHBZZ1ZHTXpzRWMwV0MveEFYZDNYbXNrWE5SZStUbzkrVVVHMllCTk1y?=
 =?utf-8?B?ZmkvUm9BaHBhRnliNjJjMHFuVm1wc21OZHpOMzA0TTJURi96SnJzNm1SMlVy?=
 =?utf-8?B?TXVOdHdlSVl0SFQvVlVrRS92T2VqdWJ6ZFNMWGg1NFNWTFF5UlZIeTVwVU5L?=
 =?utf-8?B?YXpyTmpCeHozMmdpaFo5T2hkQ3p1MEE2ZWZFSXNOWGhDNERuUUJWK1I4OXM3?=
 =?utf-8?B?dHNqMVUxbm9lcWRXWWNnWjVFUmM2VGF6U2k1N2hJUzFueHh0bW4yaTNxaHU2?=
 =?utf-8?B?Y1JUNHhCeUhxUDRzYXh2dUZwdlVqOFk1VEI5eW1Bdnl1SFIwaWlQMm1GRmlk?=
 =?utf-8?B?MVhHZjRjL0RKR0VNbXg4YmRWUXgrZ2s1MXRROUJEVzg3OG5YRnYzRnhjYmNn?=
 =?utf-8?B?c21UT0JMaDdGMHlRV2VFajlHQ2lka3BnbDRuZGRaclJIOU9idlArbi8xUGFE?=
 =?utf-8?B?WFZLRHVxWFdPNzkzNEV5OVFkVGVIYTZJN0kwSVFPTFBML2FwV0puUFp6RlZy?=
 =?utf-8?B?RHZCNHpmMUxqK1pobUQwWjFpMUxmYjBiZUZndERCNDlyeVhLRFM2UFkxelNw?=
 =?utf-8?B?ekJMY2l4WGo1bW5yYS85VHVNNll0d1puejlWazVpOWtKZ3loT1pOaDVQTVV3?=
 =?utf-8?B?SWtHbmNBR1dHMWUzSlF0cVBMbVVTRXdkZUxFU3QwZFhabjVVWGJUT09xaG00?=
 =?utf-8?B?WS9VMWlsQ09mSjFNdzNKL1J1K0U0V0MxdmlreVZTbEN4YXlIOXFmSzY1WW91?=
 =?utf-8?B?c1BBL2ZuZFJBN1p3SW44M2RPOUdlRWduRWN2d21Ra1JWVERHUjNZTWE1ckVQ?=
 =?utf-8?B?VTN0Wk1BVnMyQlk1Sk5HL2xTOVRGa1FIVk1yVi9BdHVIOEpZdkMvbTJCU0Rp?=
 =?utf-8?B?SHZHWUNpK3lpVWNPNUZsbmpSMjhmelhXRW43L3JLNzR4bG9pcFZCcURpRzhZ?=
 =?utf-8?B?bStUdkNJL3pvbjhwYS9XUWhHakpOYTZHb3FTN05JOFhTM0pmT0FKRTRwMlVF?=
 =?utf-8?B?elNhRlplczlLcXlBcDVpck5KUy9UTEtzUk51T0wvSytQS0JlaUE3dE5xOEhl?=
 =?utf-8?B?UW9UaWlNbUJuSnlSYnlBVy9ybFd6bFRhV2lvYzhxdE5oS3FqWEhHZFl6MXFH?=
 =?utf-8?B?VVRRS0lXL2xlVHpGb1lLVkoyYVlKMlZQOUJCUVU0KzI4TDhnenRNMk55ZEpG?=
 =?utf-8?B?Z0FRNTMzajBTZmJpUjI2WmVZTjNpbUhpZytBS2V6Zkp2MldITmhFRW1oQUVu?=
 =?utf-8?B?U0pta1RpN3krZEMzSFpDUStyL093a1JZcXFPSGdOa1hsSGhacGlVQ0s2ZjA4?=
 =?utf-8?B?M1l1YUhIV3FOUUpNTk1lMXpsK2U2alJQSTYyUGVyd3I2cWJvUnFacXBmRFBm?=
 =?utf-8?B?bDI5TE9QKzdpb2pOQlM2bFZTWVFoc3pZMDZsaXZvRmxKYUJiM1ppbENIZ0Nh?=
 =?utf-8?B?UlBVNVNpaE5mRHVvK1psTDZ0S0lQWkJnSm5mUkVkWVNZZFdSSmx3TU11LzdW?=
 =?utf-8?B?dXBMRmhER0dxSnVhdlppSjVVM3p3NGdNVlZQTE1EcWFIZjhkSXJVL29QZlVL?=
 =?utf-8?B?ZUJDYjgwcmYxdzNlZkI2SGFjUUxGWUQzZS9jcklUZ1Job0JybW02Z0lmWkVU?=
 =?utf-8?B?dGlaSEIvMmo0eXN0b1RESDJtWFFNcWNOWUdzZjVBSjBsSnBkRFd0aXFaVDlp?=
 =?utf-8?B?MkV1aWpjR1FWSm80dVdad20zMnBQNU9Nbm1ZR01QV290M3ZKeDA2aWFuYjEy?=
 =?utf-8?B?NmpZV0VyVFp1MjFhdjZralFady9pakhaNTZWYy9OK1ZmbWdCYjF2ejJmOE5Y?=
 =?utf-8?B?dGk0UGJOMEpBYTJjekwwdXpXYitIMU9RRkxUdndYZDY5a0J5NUp3cGgwcHc2?=
 =?utf-8?Q?tvUFJ97AS1SPMqFYvWbUZLGyV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086b36bd-2b8f-43b9-64ab-08dd791e02e6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:26:52.2106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IylFEqGuJkgcde7g3DD5NdqgVFB7EgdKtrbD8UYOracyLLP8ECioPRn5RSexc42URh6iolyz+fF3/jQhvEp65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
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


On 4/11/2025 10:22 PM, Alex Deucher wrote:
> On Fri, Apr 11, 2025 at 12:17 PM Khatri, Sunil <sukhatri@amd.com> wrote:
>>
>> On 4/11/2025 7:42 PM, Alex Deucher wrote:
>>> This will be used to stop/start user queue scheduling for
>>> example when switching between kernel and user queues when
>>> enforce isolation is enabled.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 68 ++++++++++++++++---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
>>>    3 files changed, 64 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b156e31ac86ac..30c485f529d17 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1249,6 +1249,7 @@ struct amdgpu_device {
>>>
>>>        struct list_head                userq_mgr_list;
>>>        struct mutex                    userq_mutex;
>>> +     bool                            userq_halt;
>>>    };
>>>
>>>    static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index aa7222137c31d..e93e390f4e301 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -335,6 +335,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>                goto unlock;
>>>        }
>>>
>>> +
>>>        qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>>>        if (qid < 0) {
>>>                DRM_ERROR("Failed to allocate a queue id\n");
>>> @@ -345,15 +346,21 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>                goto unlock;
>>>        }
>>>
>>> -     r = uq_funcs->map(uq_mgr, queue);
>>> -     if (r) {
>>> -             DRM_ERROR("Failed to map Queue\n");
>>> -             idr_remove(&uq_mgr->userq_idr, qid);
>>> -             amdgpu_userq_fence_driver_free(queue);
>>> -             uq_funcs->mqd_destroy(uq_mgr, queue);
>>> -             kfree(queue);
>>> -             goto unlock;
>>> +     /* don't map the queue if scheduling is halted */
>>> +     mutex_lock(&adev->userq_mutex);
>>> +     if (!adev->userq_halt) {
>>> +             r = uq_funcs->map(uq_mgr, queue);
>>> +             if (r) {
>>> +                     DRM_ERROR("Failed to map Queue\n");
>>> +                     mutex_unlock(&adev->userq_mutex);
>>> +                     idr_remove(&uq_mgr->userq_idr, qid);
>>> +                     amdgpu_userq_fence_driver_free(queue);
>>> +                     uq_funcs->mqd_destroy(uq_mgr, queue);
>>> +                     kfree(queue);
>>> +                     goto unlock;
>>> +             }
>>>        }
>>> +     mutex_unlock(&adev->userq_mutex);
>>>
>>>        args->out.queue_id = qid;
>>>
>>> @@ -720,3 +727,48 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>>>        mutex_unlock(&adev->userq_mutex);
>>>        return ret;
>>>    }
>>> +
>>> +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx)
>> Did i miss something of the param "idx" isnt being used in this function
>> ? Same is applicable for start shed .
> It's only applicable for chips with multiple XCDs,  gfx11 and 12 are
> only single XCDs so it's unused for now.
>
> I dont see a way to handle multiple XCDs with this function and might need redesign. I am assuming that with an IP with multiple XCDs we will have multiple MES hw too and we need to choose which MES unmap we have to call isnt it?  Also unused variable might be a warning too.
>
> So you want to use idx later when we have a target which needed that support and till then keep a version without idx ?? Anyways it looks functionally working Reviewed-by:
> Sunil Khatri <sunil.khatri@amd.com>
>
> But some explanation in commit message for idx or may be just here is good to have.
>
> Regards
> Sunil Khatri
>
> Alex
>
>> Regards
>> Sunil
>>> +{
>>> +     const struct amdgpu_userq_funcs *userq_funcs;
>>> +     struct amdgpu_usermode_queue *queue;
>>> +     struct amdgpu_userq_mgr *uqm, *tmp;
>>> +     int queue_id;
>>> +     int ret = 0;
>>> +
>>> +     mutex_lock(&adev->userq_mutex);
>>> +     if (adev->userq_halt)
>>> +             dev_warn(adev->dev, "userq scheduling already stopped!\n");
>>> +     adev->userq_halt = true;
>>> +     list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> +             cancel_delayed_work_sync(&uqm->resume_work);
>>> +             idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>> +                     userq_funcs = adev->userq_funcs[queue->queue_type];
>>> +                     ret |= userq_funcs->unmap(uqm, queue);
>>> +             }
>>> +     }
>>> +     mutex_unlock(&adev->userq_mutex);
>>> +     return ret;
>>> +}
>>> +
>>> +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx)
>>> +{
>>> +     const struct amdgpu_userq_funcs *userq_funcs;
>>> +     struct amdgpu_usermode_queue *queue;
>>> +     struct amdgpu_userq_mgr *uqm, *tmp;
>>> +     int queue_id;
>>> +     int ret = 0;
>>> +
>>> +     mutex_lock(&adev->userq_mutex);
>>> +     if (!adev->userq_halt)
>>> +             dev_warn(adev->dev, "userq scheduling already started!\n");
>>> +     adev->userq_halt = false;
>>> +     list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> +             idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>> +                     userq_funcs = adev->userq_funcs[queue->queue_type];
>>> +                     ret |= userq_funcs->map(uqm, queue);
>>> +             }
>>> +     }
>>> +     mutex_unlock(&adev->userq_mutex);
>>> +     return ret;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
>>> index 381b9c6f0573d..fd0542f60433b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
>>> @@ -114,4 +114,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>    int amdgpu_userq_suspend(struct amdgpu_device *adev);
>>>    int amdgpu_userq_resume(struct amdgpu_device *adev);
>>>
>>> +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
>>> +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
>>> +
>>>    #endif
