Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B880ECA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 22:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E6F10E9E9;
	Wed, 10 Sep 2025 22:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KFD4dYJk";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8204C10E9E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 22:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp0j+EEVaRdMJ7JmEW5wO/vWLtMD/FeltCjXPB4Yr9HtaT8yj/S7RhEn5V7en7ORpPEgUe9aC6I+GFLe/QEypF4u6azV2dsLi/kAQcfEdBQq1rxsVnJTiBJrfHI5l94DXVzJ2bqR6IuE61/NrNfmra95jLYBEnHu/uC9NSoTV+ZEYjWAhkHh4m3HTH+rYEOZGFYhzaIHzqHdL3ztJBoUoB76ldULjjMcUQBYlCESisGiLM7BTtTFy727usqPgJ3ztSbn8RpmG+dqePh9OQ9qbzJNvLXlBeMupaDA9mhCnlwFRAMB9LQhderCJ9ONdL7/U7v3jhDlC4iFQujDKy2USQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXOAHvSewxjzXH9V/CVK1kt84149o7p1q58EiYLydx0=;
 b=r4EMYMjdKKbvGhpGTPXJDovGEL2yO/XBoaVO4fkkZLWmCcd2HRkTNDPB98+LKLetWV10qx53oitrbAu5tIi7pCo2EUIgHawpm1KVHaw4Hcjs1/98vh6+93h71KczSnJ4J/hCBf8Wy+YYltUiZTYiH2VCia0IPuvA1NqZ0TOvbxcE2viNRiekg/317S0tEVGDz5LasolC5l/fApp2u5UDtsVWSKPB+rV+ud0T/QDY8sDlWHQeXCI4c0aarm44BnRHavJW/zPnwUWSyQ9N7/8I/RM5YCv2ebDJODegOYwdu8WN8+IMlzhaJKdCEwK7fk6ILUZdWkU+trE6VEwIX2wysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXOAHvSewxjzXH9V/CVK1kt84149o7p1q58EiYLydx0=;
 b=KFD4dYJkW5hL8ZKFBS38siBq/9iFo8C3zTX/rxaaR2fuUON8azm2+RRJZ8HrBqjgBoe5JllBxx9PxtGNBjv5WGqhrfYtAqjmmH8c+xI5DXhLdl19tRm9BVimsDUDFAgQm8HLCrjW9WKcAAFNMHM5bruzX2hKA9pwDDARmkN3W1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 22:05:02 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 22:05:02 +0000
Message-ID: <ac6616ed-7f03-4a63-80c0-42619d46ec2c@amd.com>
Date: Wed, 10 Sep 2025 17:05:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/amdkfd: peerdirect support address lookup
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250905024505.142456-1-David.YatSin@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250905024505.142456-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:805:ca::40) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d990dd2-bccf-4067-88f5-08ddf0b61750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enIxZ3NPR1FJb2V2L0l0Y3hNNEt4Yms4dkxzcy9VaXFFY2JtRjR6WDV2UjNO?=
 =?utf-8?B?b1hISDZOUWhQbWt3b0lsMjJUUzh5dWRRSEVMVHk4NGxzL0w2cUptYXp3OFY1?=
 =?utf-8?B?WVR4bTVBMGZLd2tySis3UEFqZUZNM0FUa0JsanBKN2tHMlR6YTdXczdrV3ZX?=
 =?utf-8?B?SnB4U2hiTmNacVpJdFpCcDJTcVM0Qzhpdy9wQWJyNUQvSlpRdUYrQ2c4RlZw?=
 =?utf-8?B?UzBJY3pyeTh3N0xZdjA5eE1XcVBoS044VDZBRlZscFFKSkZlbjZGRHNRbGQr?=
 =?utf-8?B?UUZGK2ZGYUdSeWQrNDYzTnpKcE1PWVNHSHp1aXpGOUtNOUd3TlhjMjFoVHBH?=
 =?utf-8?B?UmdXWlhvRmpzQkYyYVI5V2lQVW5yOUVUZmVrUmxTYXVOUjI5MVBvMnpwL3RW?=
 =?utf-8?B?d0gxTUFHcUdIbTRma1gvZ01nSDQzeXBWMVowdm9tRVAzWDJhVDYxaTMwR1Ar?=
 =?utf-8?B?RCtWMEk2WllmV2ZPekxNY2k4UU1uNkk1VUZWNjFIRXNEU2k5c1RNd2ZBTG5L?=
 =?utf-8?B?UVdqTk1URjk0KzlXUEZCTm5VOVM0MjhNR3ZSWnVPdmhZN20zVGEreXlYRkdG?=
 =?utf-8?B?RHphRjJ4ZnBZOVZBa3UxTGVXaHZsbytwR1h1QlJHcnhsV2pFYXR5TjhjdUc5?=
 =?utf-8?B?RFlyWjBnMVFXWVJuMmMwRG9EWVBzQ1E5b2ZGRDlzRmF5NFRDUHdjZk9PME9i?=
 =?utf-8?B?V1N3cDF2VVdWTE1TSE50NkpxR0ZjZWZRTDRPampNeDBaaUpYWm5yZHJoLzZS?=
 =?utf-8?B?Z3p3UmpRTUpmZlBzZ1FLUXlQc1oyYkk1SXJvT0cwNlpFVXZFOGtYRExkUEpY?=
 =?utf-8?B?L3Q0c1R5UkpNZXMzaWUrTXI4Vkh2NmhuUnY1THN4S0JNbURadktBR0VnZUhG?=
 =?utf-8?B?bjVBcXp4T1IvblhRODRNZ0Q2R0ZLSWp1MUhlSmJ2S0xrdThGN1kxTFp3YStm?=
 =?utf-8?B?bThUeDJzQWZidHp5S0o0RU5GN2R3WE9vdHpOa0FUb05CYk13ejRINXRWM1o2?=
 =?utf-8?B?d1JvTWR5aVptY3VNYXk1K0syTjV6Rmh4aXZoay9TMzJLKzVsaEFmaHIwYnpC?=
 =?utf-8?B?QU5mNnd6RGVEMFlKRnpZMWs0bHBva1UvUExvbmJKbXh3M1hUenRDekNmNjVl?=
 =?utf-8?B?djJoSXJOVVVFcW9UVmI0UWtIeW9PU0oyQjFvTzNLc1dtMDlsK2FlaU5pb1pl?=
 =?utf-8?B?S0xnM3BDUU4vOGNIVE5GcFVEcVhleC9WdjFTVm03VkdnRXFyUUlDTXB1YUN1?=
 =?utf-8?B?ZitHQmVpZnJzSmNyWmg1KzhDd0NTa290VUtQTEpuYmFkVjVzd1N5VHN4RDdN?=
 =?utf-8?B?aG5nMjk5SnowUzRHWTFVVHpCRUVHY0hsa3pPUEFyT3NncCtOU3ZFRm1xaUVr?=
 =?utf-8?B?ZW1NQ3VuQStkRW9xUE5sbk0zWlJXb0RqZGpSM2FpdzZMYk1TT3RMd2ZLQWZP?=
 =?utf-8?B?TW1iU3ZpMWxVcnNseS9QWlo2RC9XKzM1RkltckM3eGREUC85SURubGdtNFBi?=
 =?utf-8?B?WEtKcThNM1BlWjcwbmFCenJxTUoxRXRidkNXQ2lvOUNseG94NGFDRUZJR0hk?=
 =?utf-8?B?Y3R1MDBPZjkrS1VRUURFVjNSRnNPYWtEdm13Z3ZVbXNWUmZ5ekR0bmIrbjF0?=
 =?utf-8?B?c1MrWTUrcWF5WFdWZHlDTnJWOTF6UlU4UWhieGlZOU1SQXd6blZWNXVaNTdY?=
 =?utf-8?B?dnFoeGRydnYrZHFSNjhiVGdsaVpvSWV4WXRodHUwZDV5NGNPZkI4NkJWY1hF?=
 =?utf-8?B?R3E0RlFZblMvNXgwaEhFTnlLL2hkUDJUMWk2WHlQOUZPekF2RVU4YjExd2RC?=
 =?utf-8?B?WSs3WWtFYmJ0VTFMVVBFWE9ueEdnTy9BSWV4Yi9UWjBsUXhMbVRpVm15SVFL?=
 =?utf-8?B?Njd3bjBJUVJoY3BiamJiOVRKZzZJWUVFWUhKQWpPQkdZd014WnE3dEV0cW9w?=
 =?utf-8?Q?eGSRAS57uzs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0VQODVmZmVJeCtMYXY4MmNsVFJURkxTd2hEZTA2MEVUSEIvek1FZGRCUkFh?=
 =?utf-8?B?UnpiTWxsN3J4VVZJQzlpdjc3SFVoYUVETHV6elZxdThjQWJ4YlEvR3JOWFNK?=
 =?utf-8?B?NkVUdzY5WmtvazVkVVZ0ZFVyd2pVakNzaWpFUlV0K2Y2UDJvekZ5ZzRaSXZQ?=
 =?utf-8?B?cDZpREhYVVNrQWRtSEI2MDNaMWN6dkU0WDRDeWRzS2Fmc3AwbXExWXZVUzVN?=
 =?utf-8?B?ZkxwcGE5b0xBems0NVVLa0tCSXZ0KzJmZzA0WHJRY2k1WnZ6bFdzck55ZGEx?=
 =?utf-8?B?MEFDSDlqb05HeG9OUnd4eW02UXZLQ29OOFRnU1Rya2ovcWozZ2FrYmYvSmJq?=
 =?utf-8?B?cThmSmtUeXNNNG1MeFJ3bkM5TXRGMndPUnA5RHBGNlZLMUZkTElLaStXUlB4?=
 =?utf-8?B?RnRrbUFMcFJ0VGtFNjFCSnhiQjVsY2RYeHJUbVBsN1NDbXdkOERDNnZ3M2dR?=
 =?utf-8?B?ekJ1S1VkTFFUMnE1dVY5RUQ4M2pLelpLMS9RRllsRW0wcGdmL2RUK01vTk1W?=
 =?utf-8?B?NGJjeHN2aW1iOTVHNHhyNWkreDMxdjNleHlZb1JLMWJ1NXgvQ1doOVFFcnB0?=
 =?utf-8?B?UEE1cDlCZWw4dGp3Q2VHb1A4VnFubHZ1dnNLQmYyM1BuaDJ1MHZkY2NRY2Ux?=
 =?utf-8?B?azl6OUhGSUtkNVlxWXpadDNydnJaS2xYeDBRWHBQaStwTGhNMXRXL3UyaXFN?=
 =?utf-8?B?SVNzQkpWMDQ5TG9rYWRTR05FZ3g2M0U3d1lQbzRDY2Rob2h1TXBENU90Q1RQ?=
 =?utf-8?B?cFZyQjg4Z0Rpc3pieGVEUTNRNkV2eWtLUEo3dFFlNmpRRlVteVpobUJrdVVB?=
 =?utf-8?B?L2c2ZVg3cnFhRnNTN2xOSEgwZTVLSHRZY2o4T3UrWTBsclE1UE4wQTRYdzV5?=
 =?utf-8?B?ZE5lc1Z2ZHlkU2p6WXlUUUQyRXF2d2dzaHJkSzFBZnNiYzFxMTRnakV2c1Rq?=
 =?utf-8?B?NjQzUHpGNm9tMG1ncUVCYURpTXJpbEYzQjF6eEtaTHY2SFlPTnJ1ME5jenJR?=
 =?utf-8?B?cHhpUDVEVjU2VDBpSHZtQjU4d3lNT3RoVG43cG9yVmtFUGhndWU1RGcweEVG?=
 =?utf-8?B?SnYzR3RnOHIveFR1dDhieWorak9RYU43L2RzMlUzUm9DYzZQa0p5WlVnN2xQ?=
 =?utf-8?B?Kzk5aXkwdVlmNGcxQzZHMTZLZDVacTdBN2J4bkZpTnNVZXJoc2d6VUlydVFh?=
 =?utf-8?B?Zmhpd2paVlZNQWdQTmtlVVhPUWM3NEtBcVQxZm1abENPbkhwZzMzMnhidVp1?=
 =?utf-8?B?c0Jsckh0UVM3YnpDamlGTUV6WWprN25VbGV0OVNEWDREZlVQTCtpNEdpcUda?=
 =?utf-8?B?RW1FSi95azVDOEdjNDY4d0xncUtibExlOTZuNmtVRVJLbkV2UGZHTVMzUU5q?=
 =?utf-8?B?ckJxL2Z2a0ZZb3dlUEN6cDI1aStmVEdka0tFa0lWZmk1OGIxYjZWcFRlWmda?=
 =?utf-8?B?Q0tNSUt2cm40NXlEUHNTdkI3SVQxdGRxeVNBSjUzV1BYbWg2ZG5GbW5pZUIr?=
 =?utf-8?B?WkhZRjNRS3dUczFUK3lLTkRkV1NneElsamx6M0NxdXBJay8zSWdYU0Z5b3JY?=
 =?utf-8?B?S3JzL3IrblZzY3cvY3o5MTFtSVBsUm92MWpkMmdyYnVBWWp3Nk1uMnNUT3NE?=
 =?utf-8?B?djZaVC96YktjYkRHNzFkWGt4Q1Q1RHJNdUgyY0JZQ0RPWGRHRUtlb1FGVFdU?=
 =?utf-8?B?TnNmbjJNRFJlR1JjcGRXWHFYcElEbi9JUkY4L3hKLytiV3NUM3QwdGt1RlJP?=
 =?utf-8?B?TkkzT05aa2d6ajBiMUFkYmlmbGRGQ0lybmJMV2toODRyck1RRUxzdFNvUlh1?=
 =?utf-8?B?ZjlnUmNIK1N6Wm5SYnlVakphQzRWOE5wUUNmczY5VnVNRDJEd2FBNEt1THlT?=
 =?utf-8?B?azlxTHF2VXpZS0duU0VIS1REQkU1T2tvcjNrdzhMM29ZeGp2UGpiK3M2S2x4?=
 =?utf-8?B?MDk1UkpIT3VoR2pMbXZxVmZMSEp1VFJwVmpEWFo0ZWNlSldNd2hWMVZjb29j?=
 =?utf-8?B?Tjd3UmJsVCtHM3MwUUFQSFVOREg1VENYQ1pid1dTSXJPQU9nWi9ST1hESjhk?=
 =?utf-8?B?bkc1NzBVbkhPRlMyK0VtREttWVZXRVMvSmJMSDlJeFAzUlRQWm9JcERUQVQw?=
 =?utf-8?Q?hJJw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d990dd2-bccf-4067-88f5-08ddf0b61750
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 22:05:02.4453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4LtnGKWLHWDywrp+pJnD6ZMWt3PJq4yUtk8boRlh//RgHZdZ6WKh3k7LA8GG5dQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641
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


On 9/4/2025 9:45 PM, David Yat Sin wrote:
> Add look-up for the BO by address. This is required for memory
> allocations where the virtual address are reserved outside of
> KFD and then later mapped to GPU memory.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 41 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  5 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c | 61 +++++++++++++--------
>   3 files changed, 83 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 81afeda39667..37a2beece6ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2667,8 +2667,49 @@ int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma)
>           vma->vm_ops = &amdgpu_ttm_vm_ops;
>           return 0;
>   }
> +
> +struct amdgpu_bo *amdgpu_bo_from_address(struct mm_struct *mm,
> +							unsigned long addr,
> +							unsigned long *offset,
> +							struct amdgpu_device **adev)
> +{
> +	struct ttm_buffer_object *bo;
> +	struct vm_area_struct *vma;
> +	struct amdgpu_bo *abo = NULL;
> +
> +	mmap_read_lock(mm);
> +	vma = find_vma(mm, addr);
find_vma finds mapping from cpu vm, not gpu vm that the commit message 
indicates. The addr needs be mmaped by drm into process cpu vm, then 
find_vma can find it. Is the addr here has been mapped into cpu vm?

> +	if (!vma)
> +		goto exit;
> +
> +	/* Confirm that this VMA belongs to amdgpu */
> +	if (vma->vm_ops != &amdgpu_ttm_vm_ops)
> +		goto exit;
> +
Is this patch supposed to be sent to this mailing list? The code here is 
for RDMA support from kfd. I think it has not been upstream.

Regards

Xiaogang


> +	abo = ttm_to_amdgpu_bo(vma->vm_private_data);
> +
> +	if (offset)
> +		*offset = addr - vma->vm_start;
> +
> +	if (adev)
> +		*adev = amdgpu_ttm_adev(abo->tbo.bdev);
> +exit:
> +	mmap_read_unlock(mm);
> +	return abo;
> +}
> +#else
> +struct amdgpu_bo *amdgpu_bo_from_address(struct mm_struct *mm,
> +							unsigned long addr,
> +							unsigned long *offset,
> +							struct amdgpu_device **adev)
> +{
> +	pr_err("BO from address look-up not supported\n");
> +	return NULL;
> +}
>   #endif /* HAVE_STRUCT_DRM_DRV_GEM_OPEN_OBJECT_CALLBACK */
>   
> +
> +
>   int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   		       uint64_t dst_offset, uint32_t byte_count,
>   		       struct dma_resv *resv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 747c9669069a..9fbff8dec861 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -175,6 +175,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev);
>   void amdgpu_ttm_fini(struct amdgpu_device *adev);
>   void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
>   					bool enable);
> +
> +struct amdgpu_bo *amdgpu_bo_from_address(struct mm_struct *mm,
> +					unsigned long addr, unsigned long *offset,
> +					struct amdgpu_device **adev);
> +
>   int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   		       uint64_t dst_offset, uint32_t byte_count,
>   		       struct dma_resv *resv,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c b/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
> index ed93247d83ca..3341f40f2a23 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_peerdirect.c
> @@ -170,9 +170,13 @@ static int amd_acquire(unsigned long addr, size_t size,
>   			void *peer_mem_private_data,
>   			char *peer_mem_name, void **client_context)
>   {
> -	struct kfd_process *p;
> -	struct kfd_bo *buf_obj;
>   	struct amd_mem_context *mem_context;
> +	struct kfd_process *p;
> +	struct kfd_bo *buf_obj = NULL;
> +	struct kfd_node	*dev = NULL;
> +	struct amdgpu_bo *bo = NULL;
> +	unsigned long offset = 0;
> +	uint32_t flags = 0;
>   
>   	if (peer_mem_name == rdma_name) {
>   		p = peer_mem_private_data;
> @@ -187,34 +191,44 @@ static int amd_acquire(unsigned long addr, size_t size,
>   	align_addr_size(&addr, &size);
>   
>   	mutex_lock(&p->mutex);
> -	buf_obj = kfd_process_find_bo_from_interval(p, addr,
> -			addr + size - 1);
> -	if (!buf_obj) {
> -		pr_debug("Cannot find a kfd_bo for the range\n");
> -		goto out_unlock;
> +	buf_obj = kfd_process_find_bo_from_interval(p, addr, addr + size - 1);
> +	if (buf_obj) {
> +		offset = addr - buf_obj->it.start;
> +		bo = amdgpu_amdkfd_gpuvm_get_bo_ref(buf_obj->mem, &flags);
> +
> +		dev = buf_obj->dev;
> +	} else {
> +		struct amdgpu_device *adev;
> +		/* Memory was allocated via KFD without address, then mapped later */
> +		bo = amdgpu_bo_from_address(p->mm, addr, &offset, &adev);
> +		if (!bo)
> +			goto out_unlock;
> +
> +		flags = bo->kfd_bo->alloc_flags;
> +		dev = adev->kfd.dev->nodes[bo->xcp_id];
> +		drm_gem_object_get(&bo->tbo.base);
>   	}
>   
> -	/* Initialize context used for operation with given address */
>   	mem_context = kzalloc(sizeof(*mem_context), GFP_KERNEL);
> -	if (!mem_context)
> -		goto out_unlock;
> +	if (unlikely(!mem_context)) {
> +		if (buf_obj)
> +			amdgpu_amdkfd_gpuvm_put_bo_ref(bo);
> +		else
> +			drm_gem_object_put(&bo->tbo.base);
>   
> -	mem_context->pid = p->lead_thread->pid;
> -
> -	pr_debug("addr: %#lx, size: %#lx, pid: %d\n",
> -		 addr, size, mem_context->pid);
> -
> -	mem_context->va     = addr;
> -	mem_context->size   = size;
> -	mem_context->offset = addr - buf_obj->it.start;
> -
> -	mem_context->bo = amdgpu_amdkfd_gpuvm_get_bo_ref(buf_obj->mem,
> -							 &mem_context->flags);
> -	mem_context->dev = buf_obj->dev;
> +		goto out_unlock;
> +	}
>   
>   	mutex_unlock(&p->mutex);
> +	pr_debug("addr: %#lx, size: %#lx, pid: %d\n", addr, size, mem_context->pid);
>   
> -	pr_debug("Client context: 0x%p\n", mem_context);
> +	mem_context->pid = p->lead_thread->pid;
> +	mem_context->va = addr;
> +	mem_context->size = size;
> +	mem_context->dev = dev;
> +	mem_context->offset = offset;
> +	mem_context->bo = bo;
> +	mem_context->flags = flags;
>   
>   	/* Return pointer to allocated context */
>   	*client_context = mem_context;
> @@ -223,7 +237,6 @@ static int amd_acquire(unsigned long addr, size_t size,
>   	 * by AMD GPU driver
>   	 */
>   	return 1;
> -
>   out_unlock:
>   	mutex_unlock(&p->mutex);
>   	return 0;
