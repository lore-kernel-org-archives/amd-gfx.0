Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0A2CAC5AA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 08:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAA410E88E;
	Thu, 25 Sep 2025 08:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BT+RlzaG";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB5210E891
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 08:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izH/7KeFBd+fy8sv/VWXWDXPStgG1GU3+JG5LtclRs+jprNHNwCC4NPOWHV6/uJnJApsZOlt+ggFJBlUydzehrLhb4M+tmMQSKctb61F47gcYCMDLOCGKtHkcg1F6QUvsT02yTclha9HIcYwqJ7W2CyTtjS6JYYxhQ1acbcZWARBh5Lm9SjuFs31oV12RDP2B+sc+V8QkA5ckjAizme3WUrV1HDlisRMqIKgyilipu2XUgNLKJd9IZGWO59Vy8p+3tpp1ZQ+a8AtHLSd2fXAGN+OhmjHktBnz1Bp9uNVw1c6qgwz6y1Io028HCNOZwUoNUWxp/wO9FJMBG7vv70l9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvHQgR/0wXg6bSaO1h8bcY03VP+kNgbA/540A43vcXg=;
 b=xLsyKHNMorM5beBY2RpQPIhktr4fM94OmO8eeYMYEDtwyEKQliZbDoT2jGO3YxXiYyPKkFzkPQUgfMTxFap/vgc0flgQKQ8uxKMFMXJrofURrrha0wv5gQRzGR6M6wZdsVapLEckX534bDY9bEXOShEpnOeHksXxL+cf71sH3Bp6AxBS7BEn2gJBTQfmq46S3isrRGU247w6EAV5NzucpVBnaoEL16oEvfriHFNuW3zHYRh7NPRqWWCD/FZAiiXmI5Nup0yULFJMiKpz3W0lPQwHwSt43E8wV8Ki56cHqPSx0Vr/dSEZt4c8of4PC00iSaVbWaCnQrJYHiMS/N/YVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvHQgR/0wXg6bSaO1h8bcY03VP+kNgbA/540A43vcXg=;
 b=BT+RlzaG4j2ZvBiKq8nUz5RR6Qd2BYvZXgx8yKFKVFYe1j947Ubjh85dRXRsyxbHDcgVs0ZSJLWZIwIEwRlFi7Ill3KMX9d9zE/THnNqKtcXn75ePq8QjulJqktdlnJ0wDDwdtmgCyWYcSt1Vy0pLPb+gT8nVJH1lEGY5hzjiZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Thu, 25 Sep 2025 08:33:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 08:33:26 +0000
Message-ID: <57ca3087-8fde-4b05-9167-1de24db529d7@amd.com>
Date: Thu, 25 Sep 2025 10:33:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix locking around amdgpu_vm_set_pasid in
 driver open path
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250925062800.2817390-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250925062800.2817390-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 56bfeb97-e3e9-4a03-a568-08ddfc0e3292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3pyK2wwTnZ0eTZyWU5iQ3JLdVBqSkFWT1AzVlFNa0pMUFFGaVlJcnJrK0l2?=
 =?utf-8?B?RDhIekYrT3ZqSU50SnNrS0Q2VnBLeGtYalpKejlxLytNOWphbDdEMlN1UUEz?=
 =?utf-8?B?ZDNIUi9odUZNLzk5RUZQY1VSQW5BZGdCTW1wNG00RlBUb0FKcWdsV0NsbSti?=
 =?utf-8?B?RW5LR3RNWFZCRWxpNWtjQ3dTOEo3Q0Q0L0ZPMERjYjA1WFRMeU5BaWlUeG4x?=
 =?utf-8?B?SnprQkpaR2NvNlRQTDNYRi9TeHZRbWlzWXBnNjlORlZXYjRhZGo2ZXlWMWFN?=
 =?utf-8?B?Z0orQmlzYVNZd3NqNkE5citpcGVLUC80MUZvRkJQMGd3em1GRXV5NlNUbXE3?=
 =?utf-8?B?WnlwcUlMT1pEbEZQenZidFZiZXJLYnRUeFRmNGcrMFMvZlFROEtpZ2lnTW91?=
 =?utf-8?B?b043L0FCREkxd1RLcVA3SlB5cjdwTGRsL2FnZ1QvcmptS1BLWkZ6UmNxd0Jm?=
 =?utf-8?B?Q0Q4VGFCLy95SlpBN1I0T3BKd2l6dDhlWUpyZERQd3Rnbmk3cHA4K0UwUVk1?=
 =?utf-8?B?RkM1VitBSEFpMlBrWkJVSjJORnVCak9xczFZYlRFamg4QXVCM2o1QUdtS3J0?=
 =?utf-8?B?K2IzYmNpSk5XOEJIV2lmMDYyTGh4aWNXWjZqejI0eDYzTUczNUFmbzNYdmx5?=
 =?utf-8?B?Y093OGh0c2RMUDZnOHEwdGVZcWNFMUhSVTNUOVEvZVRYNkp5QThQdCt2dVVZ?=
 =?utf-8?B?Y1RnUldwdXlnZC94bTdick8vbTBFeFNSdTcwYThjOC80b0FZQ20wV2FtaHRV?=
 =?utf-8?B?RHpkTmNGQ0VnMCs1THdWZWFZMjhHVXZsMVFSM0NGcjZ0dkF6ZUwwLzlnQ3pv?=
 =?utf-8?B?RHFPTllYc3RaREpMNHlLaFFxeFRtelNoOFRvZ2h2bEp0Z2JETk9JalZFQmd3?=
 =?utf-8?B?MUN1UE5xeExlMUY4SWFjbEJ2T2w2RW5wRVlRTjgxbFRyNHdLTDZ6RlNOejIv?=
 =?utf-8?B?Q0xNTmZrenhEWm05VFhpU1lrNzk1RlVvMlV4dzBWV3RkWGo4SVN5emc2di9r?=
 =?utf-8?B?Nm1pZFh4RFRzSEtqbDBuUjB1aXg1YzVBQ1FTU0xpY2p2KzZMWkJrdC91TnVq?=
 =?utf-8?B?M041ZmdpeG9xTFZPUUhMZzcyNDdRMFRUVlNlc1lPTE1ySGlsMlMvbkc0Qjdj?=
 =?utf-8?B?a250YkkrUExFWUFIdHNmODgxRStyMXBZYTFzTzREWGNPSTJGZ1NlOW5YSVV3?=
 =?utf-8?B?MGJYRUZFanUxMEtLQWlaUis5cUFQYWlEU1dVamJxV3U0NjlqQ1JCdkljYzhT?=
 =?utf-8?B?V2lKUzhCT2FBOXRJOVQ4clYwRStKMWVhZi9IclhtemNuK3puQUxDb2NGVkRK?=
 =?utf-8?B?TmVLVTB4cldLd0RnU2NhLy9BTnlROEJhbmx2WnFJR0pLWnhHR1ZzMHQ0ZTJp?=
 =?utf-8?B?NXZOSjBsUVk0VkR0RDVaREE3a1hzcnBxR1pjYXBBcmlseTNFUGlUcEtUMTE0?=
 =?utf-8?B?bmFNcWdqYm1kTDgwejhxYVdKOEx1eHcvT1ZjV2l6YWsvbDBsVWYxZkN1UjMv?=
 =?utf-8?B?a2tJNEpZNGlkNEpCNUExRDVlazhVQzUvQmtKOCtYVFdiZy9NekxTZ202cW44?=
 =?utf-8?B?R2picDU3S0dDS2R0aE9TbkVHNHFydDdqOU1TVE16cWR4N3o5OW9SRFZEQVp2?=
 =?utf-8?B?bHdrTmVNQkMwWW5sOG1sbloza1Axb2E3anJINXJzWXo0bml6anNNblRUQXhn?=
 =?utf-8?B?SDJmd3BSeVYzbWsxTy90aENyT216K3N0Y2FIKzBxZmd2VUsrTkZIM3ZwcjQx?=
 =?utf-8?B?MHFoemlOOE01Y2xuNzdPL3hxbW9ZZVVrZnFGdzdyN0cyMHUxa3h5TVEwNG1z?=
 =?utf-8?B?Yk9RYUJheUxoU2FtelB6QTB4RHNBZmpHa2JWK2dDOHpkczQxb3l4L1lCaHh6?=
 =?utf-8?B?emMvRThsMDB2RVhXNnUrTURmNGFTQVNhNStRR0VLdEdocDhpN01CYUU3NHE1?=
 =?utf-8?Q?pbVv47UeDAM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V210YU9KOHl5eWZzdHhRYjBzZktXcnFSVFZEN3F0Q1hITEl5UFZiZWxJN0tS?=
 =?utf-8?B?ZWN3RXhQb3FrcllYbEVuVjRENk41NGJzOGU3d1VwVXdCdFdQbVZ4Mkd4VENZ?=
 =?utf-8?B?MVphTDFDditQZThSRm5heHphamVaeEE4bUJvbWpIb2JzUEhTaEVXMWlHb0Iv?=
 =?utf-8?B?MldoWElEam9nZEMrdm04V09ZY1A4RHRoVDFpOGZ0NHNEbDBJejlYMllRTUFl?=
 =?utf-8?B?bFI2V0phZk9GVThOM2t5SWxPK0xoZDdBdXNFSmV3aWMweGJqTmN2cy80OFZK?=
 =?utf-8?B?d3JFU0luRVdtZGViM1RtWUdOYitYZWFPWU1YVjlMVnYwbVR5NHQ1V0E1WWQz?=
 =?utf-8?B?Z3M1eDJ1cEJvRnZuZ2QvM1NpWlp2anFFejBlSmcwNjI1RmtML091dGtmQzRU?=
 =?utf-8?B?K3NmV2srMUJZa0hKcXRmMlRySTZzcUZKeXFaL2VyQXpDVWhHQXIyUEJhOEZY?=
 =?utf-8?B?dVRtWlVaZmVZZmxiazk0UUhyc1pFMmFQS3NSYmRhK0VTcG9WaEppTS8wSFpr?=
 =?utf-8?B?VHd4RGR3VGlsSHdEOVUwVkRtZkhqQy9OcTRiUXNPVXBOQlZzQmE3T3NmZkVm?=
 =?utf-8?B?NnFwTExJWTl5VU9CR2tUeFVtWkw4Q2E2cnJRRmNtTy9QS2pMVDlJdE5UaVB2?=
 =?utf-8?B?eVdKUkhBWHVlL0VBT3AwMnFBZVJ3V0pHcEZmMDF2ejROK1Z2VVBrWHlnTmF0?=
 =?utf-8?B?YitqeWV1WG5GQ0FYVGRsZDgrWVlnUWdHTFRJckxZdFdXbEhtM0tSL1d6a0lC?=
 =?utf-8?B?RmxDbklJN003NjBWdG9EZXN5eXY4SFdiVkNjTUlITHVMd0JTWis2VEppaGlu?=
 =?utf-8?B?NDQrcFFnU3ZneE1qV05nWUd3UFp4NkJnRlp0akhDSFVOaWFiS2lzVSszVmpQ?=
 =?utf-8?B?QlJla2dLVFNFY1pwNXFIVThSSHZ6L2VYb1hNZmN3M1ZhWm1LVllHZUxha3hu?=
 =?utf-8?B?MExuNDlVdFlPZ3cxR0cyZ0RLNEZFMzd3Uzlid1hkTG1QNkF2UnhHZDZDd3dh?=
 =?utf-8?B?WDJnSDg1TWgwaTlKWDNoUytxQi9hZ3U5dmFCOU1ML1hUSHNhY1hZZGwwb01a?=
 =?utf-8?B?eVNsWkdxTi9MelNYejNvclZhcENxcjVQTXg2TUFQbHZabW1XSHNjVEhUMFVF?=
 =?utf-8?B?UXpuejROSHkwKzNWVnA5RFY5ZEw2aEJhOVZLNVYrdHBMRHJKNzhUYnBFeGFu?=
 =?utf-8?B?bG9GeUVqZGRnTFJpdElHbHJyUUNjOElIbEFPbHZFYkZlMFAvZjcwdURXVzc4?=
 =?utf-8?B?MDF3cHB5SjlwaFMzMnZRYVc4cDVrTlhDK0Nja3Q1SGo5elpjRFVPTDJSOWw5?=
 =?utf-8?B?cmdOQkVXUEVseTNpSzRFdGJtcGk4bERMMkJYMzVnUlRTYUN5aHlZNmdqMnp5?=
 =?utf-8?B?cyt4SnhhYnk0VHl1SG1ZZlRXa0ozcDg3Y01jMDNWWnQ0a1FMRnB3b0NKSXlV?=
 =?utf-8?B?RXBRajVWc2ZDOE5PaTdiZGIrLy95NTNybmZPendVT2ZkSWpjTjdNZEdKd2I3?=
 =?utf-8?B?UzFaZGV3a3YydnNiSjNxSHVRSUYyUmJZTGg2SmxST0RWYU9yU3RSdzdYbjFp?=
 =?utf-8?B?Zm1ON1BObURUWlhuMWNhWkl0RVdZN3NXS2RWNlczSlpwTjdMOHVNOURiQlM1?=
 =?utf-8?B?S1h3Wk9hSWlTRThpa2g0LzEzVjVPYlNIUXdsQmNXaTRZK0Rza29OYU9NRWZN?=
 =?utf-8?B?ZVR1NWdnZ2Rjc1ZZUGFSRDFWSGIzeERRYkZ2NWdURFFOai9DQnJjM0huZnRi?=
 =?utf-8?B?SHV1UTNWeUJNdnIxWGZQdStEb1phc2RoZnZPYURYQjJiMlJjS3MrWTJrTjQ3?=
 =?utf-8?B?eWxVMnVqWjI3QkVCN2hKbDNHRXV3b1VlVmpNbVZzUUk2SVVwUUxnamhRYmFS?=
 =?utf-8?B?R2g2RkhpNWFJR3BWWWoyV2hhbUlSRFB3ei9FNkd2bkszU3o3WjRkdFIxVTAy?=
 =?utf-8?B?YlNjL2luT2lLTWVvUXM3LzMveWYycFdKT2E2ZnRPRmZna283S0JGQW40T0hD?=
 =?utf-8?B?YVp5S2JLRkhNZWduWXNhMmtuWlZjMnlDTlE2dkN6K1FhMW83c1ZvelBrMVJJ?=
 =?utf-8?B?OFBRNlA4RDJtL3BhNVVUWEZRRjBML0RGMVAyS2NzTEdKSm16Vm5OcmFkK3Bt?=
 =?utf-8?Q?YsFnkBtgamHlnPtldXudJqn3F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bfeb97-e3e9-4a03-a568-08ddfc0e3292
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:33:26.8963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyPD5/cIRGDvUk9II+h7vvTVXohnaCn6Zd/hCQo3VH+BCmgEpIt5+bZ/maYO9Shb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

On 25.09.25 08:27, Jesse.Zhang wrote:
> The amdgpu_vm_set_pasid function now requires the VM root PD's dma_resv lock
> to be held, as enforced by the amdgpu_vm_assert_locked check added in the
> lock refactoring.

Oh, that was probably just a copy&paste mistake on my side.

The amdgpu_vm_set_pasid() function is called directly after amdgpu_vm_init(), so you actually don't need to hold the lock (because nobody else can use the VM at that time).

We have removed the use case of KFD using a separate PASSID. So the function could actually be merged back into amdgpu_vm_init().

Could you take care of that?

Thanks in advance and sorry for the noise,
Christian.

> 
> This patch adds the necessary dma_resv_lock/dma_resv_unlock calls around
> both the initial amdgpu_vm_set_pasid call and the cleanup path in the error
> handler to properly satisfy the lock assertion.
> 
> Without these locks, we hit lockdep warnings or potential race conditions
> when modifying the VM's PASID mapping, as the underlying VM state changes
> must be protected by the root PD's reservation lock.
> 
> Fixes: ebe038089be("drm/amdgpu: revert to old status lock handling v3")
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8676400834fc..e411dccbe612 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1386,6 +1386,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  {
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_fpriv *fpriv;
> +	struct dma_resv *resv;
>  	int r, pasid;
>  
>  	/* Ensure IB tests are run on ring */
> @@ -1425,9 +1426,14 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (r)
>  		goto error_pasid;
>  
> +	resv = fpriv->vm.root.bo->tbo.base.resv;
> +	dma_resv_lock(resv, NULL);
>  	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
> -	if (r)
> +	if (r) {
> +		dma_resv_unlock(resv);
>  		goto error_vm;
> +	}
> +	dma_resv_unlock(resv);
>  
>  	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
>  	if (!fpriv->prt_va) {
> @@ -1470,7 +1476,9 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  error_pasid:
>  	if (pasid) {
>  		amdgpu_pasid_free(pasid);
> +		dma_resv_lock(resv, NULL);
>  		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
> +		dma_resv_unlock(resv);
>  	}
>  
>  	kfree(fpriv);

