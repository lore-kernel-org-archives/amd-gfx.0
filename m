Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B9AC88E65
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A9E10E9D3;
	Sun, 13 Sep 2026 20:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eb3OlRyO";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB7010E165
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Sep 2026 20:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO9k+UFSirRpX8mXyN0BB5EHeuoi4Mmzz9B8PbvrVx2SxsYx7xj35xlqjysVtGWoMn5aqFN2qdYWUTU1HKfL+gMp+5q/nhozMMyQq+5RHkBvgU98Fp42sDB4Ac5rnGJb2CCpJ4m8mNEKaqdmjRwmIOn1e+TNYPGNm+bK6f+yoJzsLbuZO9RnkDWQYTjQj/jfSA/Pk/Pdh+MWrNDT1z3UKytVGG0wBLBvWenqJgaeYHlmO/ZtXfAajpurWvp+HvJUTDvSgSQ7d3dlFLyKbGHiE90D1R3jpcwi42hspe6SK5hPFd2Ny4rzSa00EHLh+X9dZ0seHy0njcSG7RYXrHP0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RXF8HDXGZGtPJiuRsFcdisuIic1udo6Yp6IjMl3OIw=;
 b=Sn9tzLbC/s3uzjwLah9WrXWHCrBvnXSxcLrhvgQkXWz64jaIlhbmzX4TQcsBch0/bZNAx85Td7fQvuzJeK1W49ZfSBc5PPeQzYU620VYRUks5ihNmm8bRJmEvg6lxJoUIPAQwyr+6KfcqqkjOzm0whVAYAaIyV36G30muiDfx7f9YzGrx7JI09IhneIzcRCX1ZzHf2x3ZmPTn9Kcz4dkGAWLXe5+Y1iZjN8rKyJki77fNOYcgVJe587sb6o7t7fHF5NUAaLaO3p9KvdeE5+1FbT+CTBG/Vn/vArxwt5nlR0ncu1oI5aXYeV19XOT1wocxDwo1272ZEnzfulEandhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RXF8HDXGZGtPJiuRsFcdisuIic1udo6Yp6IjMl3OIw=;
 b=Eb3OlRyOn6YAvySQNbZ6SYqmraP0pDRlMFhU5DWEDhFxZUHMyuG6DtkSFmClBGddteWFFjODmp0nG95803x2sd/Xg7eo4TB3iBbj9fF/zlO3j+ostLmTBkqC3P7lkaDP3XtXXVN/t6p42tE+3HvgYJ+TLTh+6Djl2Hx1jEsWzxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 20:53:13 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%5]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 20:53:12 +0000
Message-ID: <b8bb7c32-6045-4793-a059-2e6175db0f11@amd.com>
Date: Sun, 13 Sep 2026 16:53:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] drm/amdgpu: serialize userq eviction with GPU reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20260902125001.621629-1-Prike.Liang@amd.com>
 <20260902125001.621629-7-Prike.Liang@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260902125001.621629-7-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0334.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::9) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c774c1-beab-4bc5-642a-08df11d90688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: C4le5rarsVb3/lMs3ZGx7nj5t0/KKnWYzsKxfX19tetPyR1xscxvT4FAPPzZpDYSx6xKpjLItgX8Yxe0iZPlbCBdNm/zP91/F60nuhQ1cCUx0Lys/3Xw5Osh4etkeNRS+dlZ48ViuchV/iSFPYxa4QQyFDNHMVG4ID6VSsQuT8NYZg3Uoa3OOMP1kts3yvbUvHQA4fDlGddb6RW/JyrHi7PlpCiUtuDiASEMPeQGXVUARSjwVvLESVinDY9wCZO6MRm1MJu98AtYUEtX0+HTmBXXiEwVcWgc3N2tK17xUFtJE+iJnKrSqYnEZptiWtstnVVcTyfWAZJF01mDY22Y2/t7aXXiNhKKq/KaOKCA0e3ZQSh2Tm/J00On20uW7hwSsxZ+E2K92msE389u8kB8DAdvLu+a3SPvDs2HNKVFmtx8/G8nY/Fm2JiiQbDnvP2biINwxOFYnJz7Pf69QC81/3zGkp2nQJpcuxSshWljGRxMII8EnhGu5h75feXFUKFYfsY26e0jMhj7synR2M+HQrk5XayCAxjD9Fo4UcZFw4v4WV/x91HzULmjhxh1enxmM70W8XRyp9cl6TSxKshnZ2GM5nq61UgyRkxhqzgwzTQdEgzaaiw5JPNFQZnC85tilQx0pTNtZRp37az5mtb1FOWb4W6ezzXxxq90LC5pjkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0xHRjNpd01sbTd2a3FXK1RoUGR3TE5DaXUxRmxKbWROK1JzRjFWZDVMWEZs?=
 =?utf-8?B?L1dKdjZpbk5RSFVCZFdhUUw3a2t3Y1NVTDN1L3VYdmRyWGRnTmQxVjBLK0cz?=
 =?utf-8?B?VUhlUy9TQnJpYmZ2K0JJL2ROd3FlMDRRNzYweFFFQjZtc2xKWW1TZE03UW8w?=
 =?utf-8?B?dy92M3d3QnRTUlh0VHlzN3VJWmRNMlIwOTFJQ3ZvVnpnOVlNTW1SOC9MZ3Ir?=
 =?utf-8?B?dmxkVGhaYlR1ZHh5eVJRNk1La01uL1BxOTZWZE1ic3hGQTRRTnpDRjhacWEr?=
 =?utf-8?B?eVJKQnRSbC9mVnYzT3ZjaktvMVdZTmFEb0FMT3ZIeVo0U3A1WWNuVVM1WmMw?=
 =?utf-8?B?bUhIbTY2TDJWcUVqUHNIc1BvOHR1Z1RtRlNlQzZPUlZNSmJzNlFsNTkzTkdj?=
 =?utf-8?B?VkNYejFxUUhNWDJXUHBITGJRa2NsZU90YzV2ekN2Qlo0UGpKQzhKck9nNHRT?=
 =?utf-8?B?cFlCYlFneWQrc3d5WTM2OWhySW1HNWpNdVJiQWhIQ1l5SnVYSlAvUEtLd0dz?=
 =?utf-8?B?UXBYSFJJcEN0aXhxSFB3ZzR2MkJkSVhRWE9aYWYrTG9iR1BnMkFCbTNWRXEx?=
 =?utf-8?B?TE51bU4zeXNVOHBIUUxWWHhpUjA2bmdGR3doa0trcC9jaVFOL2lsQjVJYTIv?=
 =?utf-8?B?TzFRUGdBejBUNEJqM3ZFN2dNZXdhc0tTVmY1YXBNeTNBODdFK0x6blFyc0ZF?=
 =?utf-8?B?aVdMejFGVlE4UW5BMm1leUdUSmtUNkVNK3dIdVBtMFFWdVA3K2djMkJ6Y2pm?=
 =?utf-8?B?SnkycUFUQWlFZ0QrTlpJY0N0ZENWZGV4ak5IL3dRMGE5TzRPbmt2RnFha09K?=
 =?utf-8?B?QmhHL1I2Wk16c3duWXRXVEpPSGNsRTI5eFBFWlZYSEpvRUE0eFgwSWVGZmxU?=
 =?utf-8?B?cElaVGdGbzdWZGRqclNsRk5XRGxxL2pab1lPSjdQR3BQUHRXU3M3T2NQbEdw?=
 =?utf-8?B?dDNUVE0vVnhDeFV1SDlQbUdqNlp0K3kxcHJPbDRuK0RwVG9sc3RmcDFlcW81?=
 =?utf-8?B?bXhoVld3UE9zS1JNbWtHS25MVUIwMXdQU3AzS29jK0VTUzhvdHo1OTc3NmQr?=
 =?utf-8?B?R3hEdkxNRTQ0TysxY3ArOUh1UWJhQzh3a2FYT2RCMjA3Rm5zcmxNTXhQU0gy?=
 =?utf-8?B?cU1aOEhqdFVWL1RMeUpsZVFTdHNVZXJ5Qzl2aGtOWkszRTNKc3ZKVlY4clA4?=
 =?utf-8?B?dFB6T2RoUWJpQmpxdjJrQmVoUFF2em52SUU2YkdZTkdxcHRsQzRPT0RXYmEr?=
 =?utf-8?B?YTBwQ0YrSFNERlFOWjlGekV6TlRTaTA2WHBWRmJHN0pHdGkxSEtHcW02dlBM?=
 =?utf-8?B?a0s3ZCtvRzFOUGY4eFdkZkV0bGhqcXMwdHFFY0lmMDNsSUgrMk5WTDUrbHhW?=
 =?utf-8?B?UndkcFBqak1yckNmV2JNa0krbXNYVHQxVU10K2cyWTBYMmVKQXNIeEZpZGpw?=
 =?utf-8?B?VDJOYzVqUis2aFRwUXZOKzRSdEtnbUNIQ0E3aDFUVUdEUUdvMVFGR3owaHpl?=
 =?utf-8?B?Q2FRS2l3SHRheCtORnRObXUvVldreG9IUXZuNDFFbG9KWFlHSTRJMXd3Sm1S?=
 =?utf-8?B?QkdQNzZXWlJ3VFlCdHp2VjhZRkY4YVV3d2dLd3VKbHNFVE8rZ2crK3Y2Sngz?=
 =?utf-8?B?cU5PV2pkb3RrNjdRbm9sQ2JlTDVPN2RwV3VUUHBUbnRJNmJKN2pBcEdqalNr?=
 =?utf-8?B?Q3JoMnlyTWhaTzIrMUYyOG1qOTA3b05ZcEtIQ1R2YWNzRlpmYUo2QVJ5OEp5?=
 =?utf-8?B?STU4bHZMQ1hmWVF6SC9ia2k2bW9qWU1hc1Q3dzZta1NqVXJXbm5TUGVLcVM1?=
 =?utf-8?B?azNSQUpnaVREa2hCUkVaeUd6OSt5SVJROXJ5YzRSaGJhcSthS2xIWlowYU4r?=
 =?utf-8?B?RmhUeHVrSmhjbnkvQVZjanpEYjJiempEYmErVUF0V2krQU1nWG1jam9pd3pn?=
 =?utf-8?B?ZDZiaCtwQUI4ZUZyTCtLWWJ4Yjk3ZytydTJtY3FoQWJvUUprbWVxdldTZkRO?=
 =?utf-8?B?Z0JxVGNsaVR2R0VYQVZhaWd2cFpLTGpZbHVUS0IzYzU0WmFua3hsY0pIZXp4?=
 =?utf-8?B?aTlaTVJsY2dwa0JmMFFOMDNwaW93ZlRQZjNZZzJlbmtzSEZLSDFrZ1hzc2lp?=
 =?utf-8?B?Q25PRmYvTndieXl3WXlhVUVVWEVkejZ6TUxnZllqSGM2RWVlWU1IY1BRRHF3?=
 =?utf-8?B?UUZTV1krRiswbmpoNHBTS2MrRVpPc05Wc3JlS05JaVB4Nnd4cGJ5V3NNOHI3?=
 =?utf-8?B?ZTdpY1Jqa0UxTThLc2NKSzZQZEw0aEVaUTdsb0lUOWY0R08rVWxBYzdJa25I?=
 =?utf-8?B?N3JNajE4VlhNd0Jyekd1N1QxU2txRHd6TXkvVWZNQnNRQ0pJTjNrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c774c1-beab-4bc5-642a-08df11d90688
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 20:53:12.6603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cePBb4lWmHfuiwIVjhAO/Q0xDIfhIG1pkAQtzHEo/5fDtjK3s5NvuuZX2CvDWTzc6Wfpem7QFARY0NpDnvz5Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
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


On 2026-09-02 08:49, Prike Liang wrote:
> The eviction fence suspend worker can submit MES REMOVE_QUEUE packets
> without holding the reset-domain semaphore. If GPU recovery starts while
> the worker is running, both paths can access the hardware concurrently.
> This triggers the hardware-access lockdep assertion and can submit a MES
> packet while recovery is resetting the device.
>
> Try to take the reset-domain semaphore for read around userq eviction. Do
> not block on it while holding userq_mutex because recovery takes the reset
> semaphore for write before acquiring buffer reservations and userq_mutex.
> Instead, drop userq_mutex, wait for recovery without holding any other
> lock, and retry the queue-state checks after recovery completes.
>
> This makes recovery wait for an in-flight MES eviction, while an eviction
> which starts after recovery waits without introducing the reverse lock
> dependency that caused the reported circular-lock warning.

It only changes amdgpu_eviction_fence_suspend_worker(). It adds
reset_domain->sem around the evict path only.

It does not touch amdgpu_userq_vm_validate_and_restore_queue() or
amdgpu_evf_mgr_rearm().

Eviction is now serialized against reset, but restore/rearm
is not. Same worker, still unprotected.

Thanks, Vitaly

> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 2ea8553c82f0..93307cbf55dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -67,10 +67,18 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	bool cookie;
>  	int r;
>  
> +retry:
>  	mutex_lock(&uq_mgr->userq_mutex);
>  
>  	/* Fence waits are not allowed in a fence signalling critical section. */
>  	amdgpu_userq_wait_for_signal(uq_mgr);
> +	if (!down_read_trylock(&uq_mgr->adev->reset_domain->sem)) {
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +
> +		down_read(&uq_mgr->adev->reset_domain->sem);
> +		up_read(&uq_mgr->adev->reset_domain->sem);
> +		goto retry;
> +	}
>  
>  	/*
>  	 * This is intentionally after taking the userq_mutex since we do
> @@ -81,6 +89,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  
>  	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>  	r = amdgpu_userq_evict(uq_mgr);
> +	up_read(&uq_mgr->adev->reset_domain->sem);
>  	if (r)
>  		dma_fence_set_error(ev_fence, r);
>  
