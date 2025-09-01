Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F41FCA0FFD
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 08:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4ED10E3AB;
	Mon,  1 Sep 2025 08:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDbimu1h";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E9010E3AB
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 08:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bkm2fQzwZ4nuOHjqV0gIU8IgwttuYPtnYZIBV5JPnLYafd4IT8DmJ2WxvZwDKmgNTuHRqxfkGh9mqTSBW2rb1HEUzH0MMFUXFNn69YlX/kkm+Rd5xrDS2VN00N9m6DB+CcaitKP5yaI6PAL/2p8A2BScrZsveQv/bGm35mGI5Orx7HQBlDukJF4gnOQtAiAjDEsC5mHOlO/WggOJauPK8Jhhnrua+TgG+bE1ID66pGCyongy1oqYWXyValmbahJnutWu4kgT6vwKhRqvQe+QZUooqchX0HzlDtTxev+tC21GbCC3I+E+TrsJO93kNVmzM82Z451h7mROkL1NuKD7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqw+RNFbR5bTH4CNDN+PCookZ1dlb3zj9/D3ZQ/5PF8=;
 b=b4zjWzpZTiphI1jCg9gD6ttMA14gG+e0YMgrHmnGBxWnfjfGmSjibTTVxCu8wEDqk8BOIvILcjuOXnnFPz+eACMbXKwiF2mM5SaT6akabY2QTR8NS8FLh87rmag+ppeJNDqSGijqRjeaxMuT0lQ0A6gEHubf30EA6kBayaSG/+SRd7kEzWHENm5YMIpMXMcHjbVq8s2ItJuoNIKeGNyS4DtY7/F4s5acRYYddiee4Suvm3oGKAwZFM3AC4CjpHcoTsGfkcWf4aQUZcEH6xfnGHN+v/17Wh2teMjCMfOmuLp1xZS0DioV6xg4jKPusD1X1yv/T2CDkpF1vh1Id3RWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqw+RNFbR5bTH4CNDN+PCookZ1dlb3zj9/D3ZQ/5PF8=;
 b=yDbimu1hG0u8k06kVwghNQN/oXAoFJlUzKFydE0rIsCawLR9v69DFFz+3QM6wGeGTBykYmZNV7suGAqyranSBNT8+Pj10NmY3CEskzzuBIgmxIMNThqQnAsBCnho/rU+M7eyv6hyDZsEW4plMsMT/c2cN1TpYKujfR3NwOFbfF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 08:38:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 08:38:20 +0000
Message-ID: <0acad980-066c-4ec8-ad9b-aab5add1f376@amd.com>
Date: Mon, 1 Sep 2025 10:38:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP
 Placement
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
 <20250829135523.4032168-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250829135523.4032168-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:23a::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e933ec9-d588-44f0-72b8-08dde932e7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0Z0R29wZW9XWTF6WmJ0SitPZ21ZaDhaWmExQkZUNG5KZE82ODdIU1VQSU5o?=
 =?utf-8?B?MkluSnJuSVJOSEZ1eHN0ck8xYjBXMUIvYWx2RU5va2VYWXJQdFJ4NTNqSEhP?=
 =?utf-8?B?REFzL1ZDUWNOc0tPb0xRK2RLeGhIcXNqd0RxUERkWUhkbzFJdjZEckU1WG5q?=
 =?utf-8?B?YWxIeVh4clFzdE1NZlFHY3B6ZTdqOFE0L0UyMW9UbnB5aWNnZzdlTjF2bWdR?=
 =?utf-8?B?MDZhSG9CcXE0dFpBWHh4Nytpd0V3d0g2MHdXWi8vOFJPRHV4YmVHcXdMVEQr?=
 =?utf-8?B?WTdrWHdvc0JTZlNRZnZLODZNL1hXWldlSjhJbDFhOGppVUhYSENMOTNqWlVq?=
 =?utf-8?B?V1BzcnNkdDhyZEYzNmRtY2FCRlRkUWVjK1RIRVI3RGV0SUpaNkIvNVloV2Ru?=
 =?utf-8?B?TTRnQVlUL0pSM2lQbTNHYlIvRmlFK2FkUUx2Sit1ZWFGK2JMZ1FoeDNGc0Zs?=
 =?utf-8?B?L1BUY2NPK2YxTVhCRUxPeGhVaE9LMWkvZ1V4Sk0wUGEvUGRPVUJuY2k5a3Zv?=
 =?utf-8?B?WHI1YVFWK1h1aHZ6UFltV0RuS0tnNGtyVnhTYWJuNE5YRm1QMVNmNHJTZDN6?=
 =?utf-8?B?Zkt6SUxyWk8vK2ZsU0N3enI3dDMxa2E1K1p6bXNzUEZqb201b0tmeHB6clpp?=
 =?utf-8?B?QzJqRllwb1NNRFNCMVNrRjZ2QXkrM1FzdWRNNWVlNjI0ZUt5S09QSmNDSFpT?=
 =?utf-8?B?SzZseHdrcnNqa2ZGd24xUUk5cjNqVTdWK2M3U2dWWkpGeVFJY096MWNOMDRu?=
 =?utf-8?B?YUo1NlJGN0hKZ1paeS9FcU5yTU80VGRWK2Y1dDZoejZrYXVrZURFaGlXQzRl?=
 =?utf-8?B?WGg0WVJFV1pQOXRaTTh1WmMyWTFOK01jdllwZWl0dXBhNUNHWEVWeDlXU2dJ?=
 =?utf-8?B?Wnd2a0ZGcFFEdW1LUENxMkoyQ3dvTExKbjdwS0twZjFCSFZWWUhsM0J6WW5L?=
 =?utf-8?B?L3E0M2tkSkNKNkwyOFFHdGFPSkFHak82VHBEQ01CaVk2b0dLVFo4Y2drbmtE?=
 =?utf-8?B?eExZendHUC9raUhPRVF5cFJadnFuMElsSG1PeUE1cE11anUxWHM5RzB3M0pU?=
 =?utf-8?B?QVVYdFB2TGF6dVFDTlZFUnZieUt2b2ZoQjA0RHpiOTFGQ2JMRWJlVVdOQ0ZJ?=
 =?utf-8?B?Y1RsYmcvZk82Q051V3ExTFJmSmIxYnZkbUJnQUIrcjRXQVB6cTNCalRxd2w4?=
 =?utf-8?B?RmhxSnJjUjZMRXVRLzhGdUVDQ1hBMHZ3K0N2VkpDcWlmN25Ncy9yRWYvT3V3?=
 =?utf-8?B?L2EvNUM0TC9ZeXYyekcrdVRtMDdWTndMOFhWczUwL0tmb2xBNFZ0VnZ1V25l?=
 =?utf-8?B?M0JmWE1WQW5WcFo4YlNIc2VtbHRPbGpFNXgxVzcwRlhaVEZCQmZVZi9JdnN4?=
 =?utf-8?B?UHFqK1gzVkZmaW5iMjBOK1ZiM1p6dWxWV1BHUUsydDB5SGl2V3lWZ0NuVFJ0?=
 =?utf-8?B?bmdsMkpZZHJGRFdRNkVSZVAvSFBySGVGUjlEMXc2ZnI4NUs5elFvanE5dE1M?=
 =?utf-8?B?enJFSFllZUdUYnJYaGFpUXZEdjBEVEs2Mk1iV21EZ25JdHRueEkvRzNNK3JY?=
 =?utf-8?B?ZGtkckdOVEFqT1A1Tk53emRIaGxWRlo4enhTNjhTUy9HTjZPRkFuRTZjMFRw?=
 =?utf-8?B?bDFkcVZ2U2dzb2FhVkJMdi9qK0UxUE43aGY0NFI4WlJ6ZC9uVFNzcjl5S0hz?=
 =?utf-8?B?dGs1NWVVM1YrRFVsWkZVaFhGRCtGeldZNjF4YU55ckxkTXBMMDRBT2d4TGZt?=
 =?utf-8?B?dktPRGxOYytYU2JYZEExWEVSUHVkZTJiWTZkYVduNjhXblNsckNoUnVQUFFu?=
 =?utf-8?B?dExmN1hkQ2g3a3EzMVo0UWVnc2N4VHdBb0NpWGg3alZXK3huR2FqMXczRWFF?=
 =?utf-8?B?VjVPSUp4Wjk1RWZhdjBUTThjZFdXOVZDdjEyRGZST09QV3p2bEpPMG1kUGlq?=
 =?utf-8?Q?rOiPz+ogwlQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEIyTlBYTTM1QTBrUmg5VDFXNW53QTFqOXErYjRJNnUyMU1URGxJNGM1WVpR?=
 =?utf-8?B?czJwc1I0S1hJdHdsUjNFaG94UjdNNFdrZ0F1eU0xYWxMV0hqYUgzQlBvZTRa?=
 =?utf-8?B?TE1KQW5KRjRtZEsvYkdyR0ZzUm10cnVDcmEzMTFEY2ZjOWFabUdZQklMT0Nw?=
 =?utf-8?B?VlNmUkZpblRRM0NESkhPZ2JNZDI5TTBoWEUxZmNSTDFNOXJuUzB5dXkzb01z?=
 =?utf-8?B?SnRVUjRtY012RlVmMDdlVVY2dDd0bnREUytweVRjUkt1MzlUOHFFcDNINDZv?=
 =?utf-8?B?a3RQOERBVmxkMnV1dmFIaTVZM1kycVBVWEgzK29HNU5TbndSeUp6L3dzOXpu?=
 =?utf-8?B?aVFPTHJINTVHYmdaQ21rY2ZrcWk4czJJN0l4Y2R2TE9LRk5WYk5aT3RBa3kv?=
 =?utf-8?B?WFpaL2xuSlNraVZjTEYrRi9jM1BXM3RvMEV3YkQ2S2wrdk93SXNON2pqMXdC?=
 =?utf-8?B?YndGK00xMkYxdHFxWjFOejlzZ2d1QitXZTMvcHU2SEd0eFRUanpxVEtxZ3Nj?=
 =?utf-8?B?NGRGY09ibUNwNi94MlNtMWxhOEhONVR5Ti80SWJCT2czcXEwOXFiV3RtLzJF?=
 =?utf-8?B?bU1qQUhKUEFUNGJJWjdiVWFsUGt4ZkVTMTZ1Q1J0MzdHTnUxOGFLdFJlQm9i?=
 =?utf-8?B?aGMxUzBRdm9FOXVybTNoU2ZscHJ5WHlyNjZ0T3FRNWpYTlBVeHZnZUc2enhy?=
 =?utf-8?B?STMwOXpFUkdWZmMzQ1JhR2pWVWJyYXBiTmtaRnBLdUhwRm82WUh4b2IrdXN1?=
 =?utf-8?B?OWVpLy9lbjVzSEVFYnNSeVBLMXFQSEZGL1N0UnlTWENoc1UxKzA0NHhrMjBU?=
 =?utf-8?B?amVSYXVxNkhjNWN0Umh6ckZVeW1lK0tuMW5taTV4SlpKcmx0bzJKMW9ObmdZ?=
 =?utf-8?B?SHEzdEdFZ2duc2hsUlFBOEI5MS8yYm9LZkxuSTNaNCtweUFQN2JNaThCdGpw?=
 =?utf-8?B?UCtkK1FsMlM3Sm5iaEZSbU9oczVIUWFHcFNMOVArY2NNTHJiMFpTN2tpZll4?=
 =?utf-8?B?Z0tCaTZjRHdrMjBnZ0g1ZGY0M1kycnRiN3NBS1hCSE81VjlQL3lPN29HUm1m?=
 =?utf-8?B?WEVyUWZJRkNIM1dZaGQ2NHlCY2dIMEV0UHY5aUZZcGp1UTVWMmFPNUN3L1h1?=
 =?utf-8?B?OTFmNmhLRjFZRnpWNDRCL2dFRUZVc2dxdE1GcXM0Tk1LeGd1cEV6TlFWanNu?=
 =?utf-8?B?WThIWkVjQTJsYkVQR092TVByeVp2Y1o4b3Q1bWNYRGZMUGNtTFFBdkVmZXZX?=
 =?utf-8?B?S3pMSUVzbm5TNDJETExzdkpXaFB0OGY2RTEya29SSU1SSG5UR3BiUjlsSkN3?=
 =?utf-8?B?dTJ1SjFob2pXZ0tVdUlvSDVRTlM5b2NXaTgrVlpmZTdFSzZUeDZGdDdzYlhq?=
 =?utf-8?B?RmpYRThHSVdNV3FyM2hlWi9wUVZNdnJsdlZpRHBvN1BXOWozRlowUlU0eTQr?=
 =?utf-8?B?Qm1VNFpEMHQzUXFvTlNLSkFWS3RzS0ZDYjlKUjhuT3VZbm5DZ3BYcSt3a0xk?=
 =?utf-8?B?cFZzcGxqS2FlNCt2ajRmeUVuTXY3SEdBelByOFkrKzZ5MWU5VmpVb1c0R3NZ?=
 =?utf-8?B?c2w3WWwrUnpIZmNzOVJYRnV2N1ptK2pvelBKRUN1NVJLV2Y1WnRjcjU1ZGxQ?=
 =?utf-8?B?Z2tVSWY1SlZhdy9HK1c0dEI0WU9xUFVNK3JVQzd6elRXK254ZXpaK2VxeTFS?=
 =?utf-8?B?OXpoVERKQ1ZjOW1lQ2JBL2N2TVVxbEM5a3Q2TlZyNFh1cDRRT3BwTXlKdEp5?=
 =?utf-8?B?Qjl1aXF4cGQ1MWN6QzBYS1VSQi9Xek93a1JNWGZ0THpVdHIzQ3l2dnMyanZt?=
 =?utf-8?B?bkdvZGcvWGRMMTBrV0N5dCtNSitta0FaQ0M5cWNaMXdHdGhjZkFNa0VyY2Ew?=
 =?utf-8?B?cU52aEU4cVpTN1ZUdTJ3ZlhpK1dDQ2IzNWFOOVlKZTVhM01SN2hBTGVKQ25q?=
 =?utf-8?B?cmlBQmhFMlNFU1dka1Q5cjk5V3cvYVFWdElIM1dKT0Z1Q2wrV0UwMTh0QW9s?=
 =?utf-8?B?N0kxQ3lYZjFxL2Y4TE14dlljZlU5a090eDZRQzZBRlVocXpOcmNObnNjb2xM?=
 =?utf-8?B?ZVlyRmMxZjF1OUJ4U1Y4eEJIbjBTd2l1TFdDU3dndEJ1ZFBubVprdkI3djc1?=
 =?utf-8?Q?TITg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e933ec9-d588-44f0-72b8-08dde932e7ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:38:20.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgckKx/KEbmP2FQxu1t0A5AcQGaJJ9q2mwDdtcaMSxmJOBBK7vstih3ssEMgqQjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
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

On 29.08.25 15:55, Srinivasan Shanmugam wrote:
> Introduce a kernel-internal TTM placement type AMDGPU_PL_MMIO_REMAP
> for the HDP flush MMIO remap page
> 
> Plumbing added:
> - amdgpu_res_cursor.{first,next}: treat MMIO_REMAP like DOORBELL
> - amdgpu_ttm_io_mem_reserve(): return BAR bus address + offset
>   for MMIO_REMAP, mark as uncached I/O
> - amdgpu_ttm_io_mem_pfn(): PFN from register BAR
> - amdgpu_res_cpu_visible(): visible to CPU
> - amdgpu_evict_flags()/amdgpu_bo_move(): non-migratable
> - amdgpu_ttm_tt_pde_flags(): map as SYSTEM
> - amdgpu_bo_mem_stats_placement(): report AMDGPU_PL_MMIO_REMAP
> - amdgpu_fdinfo: print “mmioremap” bucket label
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2309df3f68a9..bb17987f0447 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -34,7 +34,8 @@
>  #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>  #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>  #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
> -#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 5)
> +#define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
> +#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>  
>  #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>  #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2

