Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077AAC88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 17:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7996710EF69;
	Thu, 17 Sep 2026 17:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pmw2nss+";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E587F10ED6A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 17:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmCEPAnP+EAnEqlmu/dF0JIbUSdYhc472EuNYcbhdX7XqpvWG2RySE2Hz56ZnKZ2Qgv4lj0KobvIFeTOop98GtLcvNYlzM4jMwsIYJe0bVOr69PRR3sp3KA4nxKu2PLFqvXLVLvZRBIEYHQCoFX88IRuNN+lwRZjxEX8aUGaEl6c0TnTsi4ij1DiWm7OC1qZGsaYNTkyt65GRNg2l0pjUW1ZZVmsmSVZbxsUHIaqAlZJwlRS+VFxK2udUjVP6reJoHsDXheK790RIO3yHbsJcmhYVLpOmXqtges5OTxfPLaixJna6MhQSYmQB31p6usc7S+I7aUQVf4OGAuJVygxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvMbiVStVtQtvc5DHEkyZFh7+sIvYDwU7DMsNbY/m80=;
 b=UrtX8+dnwcO95I50GK/aGgj431O8+X1+YDE65nIXgbOAiHEVNRzsiwwrl5qzuuAxmsVuCG0Ab9Fjw/LYrWaaVPEnD5N+w+1A5GaY31mns2TQ3+lhqZRroJOL2OUgOuci3vuRDeaP0buAqNFa2yZdZtY1n7+zgag4CxEU1u7VSreBlEjIeaGiAET+mZnZOd18x/IpHBZ6DQz5fMx21NNa57/vpqRMcZ0DK/pxuBeuAJoXnNZ2ukjSnE1Mdyu9x8/9Lod4q6oFo34xpRoA2g20rfmdNHXc2luXm6wyTdY2lyogaz78J+eLenBWPDSESn9T61LDCRGSwwlRt7uojbMjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvMbiVStVtQtvc5DHEkyZFh7+sIvYDwU7DMsNbY/m80=;
 b=Pmw2nss+t4te/iqVZYaDmDCIqLgYsla8RXG4ECO2px851vMkgmrksIZLOmkCx1hHymwfoLPcLJ1tJ76WkEWdhfh+oDMimwGPM0EYOG2IDmIN9m8BSI79fimYSZcDejS6tFGRPWNAUmpGCyQnhmjdDSxe66huYXapmJiY0/Ra9H8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 17:00:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 17:00:02 +0000
Message-ID: <aac33cbc-e01e-43cf-ae9e-15550155c754@amd.com>
Date: Thu, 17 Sep 2026 18:59:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Reserve eviction fence slot during userq
 rearm
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
References: <20260917153404.17610-1-vitaly.prosyak@amd.com>
 <20260917153404.17610-4-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917153404.17610-4-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: c26bc421-8bc5-4a70-7219-08df14dd1d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|4143699003|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9TTaH/M2jV1+pWesF7lJL+jvRVxZTizN92n7ICKvCCRap4h8Yr02vSPX5UicKLWmVAjvEnhGdAs4Z8Yo14j2rPF0AkqGdz6t/2mJSkockXWDXkygUfFc2B7DNRF2q4vPZ4np2h9xAxxQM7ZeZzjLMGA4W06TnJfq5yCY5vGSM7O5XhdrZpQhksjjOJuF+Drynf+aCMDdDkdXjJnv7RkQE39/jeavk6VgVjqQS4KsLKQGRrKOzsIPra9zYE4SX70EJEkmE60G7qiIge4k/1duE7O77/LpddIC6Zq3gQ2zkoKg/AtD9LwQvh8iq1nG+AA/4cQFRewqBQwQgVYr2/sEr0/SLE37pMkuDRl6uUjSUjyg8ZDvsiLhq4aOzWSuJCEO5w3ghk1eNERP4aEqqCbHwb/tspIKuIztprzNcFvl8k47jURbsS7jULfXV5Oeu8SBE0MXT1NllXnkA3BpHliNtLfkDjZhbfvoRtor32gwSciLfcsjEruiSiCWqcSKsJB3IgtGO3mSJzzw/TELyUHEq8ESRJJ5ouKBTh8vmSOLYWD8ZN3GsIsBqMWzUYmDWAcrxAQtF6KJub92yUQ2//pYT5pjGCcgw9pYdw6q0VUvqUmnxTGw2jUSo9+X+12m42297lS87n1t9whSroDAAqmowUe2EkmPeuuqeCctnogTiDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9LcFVoQzJFczNndDlURU9Td01sUkRtQnVkMWRvUXZVc3gvUEFyZVEwNnVU?=
 =?utf-8?B?OHBRalpXSkJETUNnNDZnZ2JDenkzNm5ZSGk0Vkt0YWVjdWVwWk85SzJoOStD?=
 =?utf-8?B?UlU5eTdCYlZ2V0VrUzU0anFXaklBRDE3YlM0ZFlCNng1Y2tidjFCK1hrZHJJ?=
 =?utf-8?B?RHlIcGNMckoybkkraWZaK2pPVlV2eVVTeXM3b2R3T3QzczBvWVdvMWo4SHpC?=
 =?utf-8?B?RkFvdGd1L3RzMzlIUjZoZlMvTGN4bjUyZmZKYWRmc2I3VUQ3ZlBZakpveW52?=
 =?utf-8?B?VzJPUVQrZm5CTzVOVTBQQ2t1emp4N0RlbHdETWRycGg3eGxwT0pzalFHdk9h?=
 =?utf-8?B?ai95YXkzckI0dFhla1EvMWU0VExpUzNZNU1WUnJQVHA5UFRycVltQmp3Z3Fp?=
 =?utf-8?B?cnFmbVZiN1FuVk9hMkpEdXM4WmkrMmU1MEM4TDUrMmJtN0pIMGgwbEF3WTF3?=
 =?utf-8?B?S0dqMzFteWRtSGMxeTFWQ1kxaVRrZnJscHJ6aGFleWRsWkRaZVE2bFBKSXo2?=
 =?utf-8?B?eFVmc05sM3ZpWkVKbVdPQlBvVTVMeFBmMWIvQU9ZM3pZYXUvMnAvY2xQMHNH?=
 =?utf-8?B?dW9mdkNrblR1MzgwYUV2Yjl2YlJ6THk3K0NEY2paa1M0emg0cjY5c0hkTzJP?=
 =?utf-8?B?TmE3bnBnL0NoSWVuNitmd0czM2txTTVKQWJJV2JzbS83K0ZIVlpNNUJ0VFRn?=
 =?utf-8?B?cGEzR2RSZGVKQkNENnJnVjIxTE5hcTZ2MlhxZ0IzMnVjSDVBYVVlREUzUUJI?=
 =?utf-8?B?ckM0NEJrVlNvQWlncFZhSlROSXp0anBCNkJTRTIvZXlVVmZhcXAxRG9nenV5?=
 =?utf-8?B?akNXNnVZTEdub2hZSjRydlRNeWw1d0FFZm9RR0V3d1FObkZEVjdFcHIvZkU3?=
 =?utf-8?B?L3pUMHJPbGNQMTB1dGprc1BPbmpLWFZ6MU9BdTc0RStrMC9XRVVFeE1ic3dD?=
 =?utf-8?B?Y0hjN0VJMEh3VXhGK09FdC9HY3lBSDBFRDJ4dHZTQWN5Znl3cUw4aXNzZFNw?=
 =?utf-8?B?ZlFwUGdRcVlwVXBUekgraWpPQUpDTWF3Sm52RlZFRzA5QnloVDMveXBnUEs3?=
 =?utf-8?B?cEJJVkJHZ0JISkd2VzNSZCtoekMxdDhYZ3l3WE5PNkZrNUFxSFhVVVFSVnBs?=
 =?utf-8?B?QUsyOWE3MThUTGo3bm4reUJxSlFsVGc0NDllbVd1WUhzU2FrcUIwUExnOW5L?=
 =?utf-8?B?YWkyZVRqS2t0SjBIMjFBWUNJYUxpNXhCUXliOTQ5TDE5RmhPYU5peExWOG1Q?=
 =?utf-8?B?MjhkUzZJZHZrNXQzaE16WFEvV1VHYXkvVnRNYWVoUEJrSFhDV2dmL0VRVE8z?=
 =?utf-8?B?TmVwU3dOUGx6NmtPTHZEQm5GZndFc0FOSlRpZTNQNGlFOWtSL0ZhbFpsaExB?=
 =?utf-8?B?QmtIZVg2VElrd3VwQ0N5NDZ4ejB5Q3JhUFd3Q0RReWtQYkFuckNReEprWW1R?=
 =?utf-8?B?ZHBqblU1c1VKUHVQOVR6akpYbEZGVWUzQTFoaEdyN2lURTZ4OEI5d2JFRThX?=
 =?utf-8?B?VXlwSjdxQ2h6dUk5d1lZTUZqMGFEYVJoSmJuTUJnVEtMTXFLMzUvTGVQdVVH?=
 =?utf-8?B?TG54eEZHaVgyS2xwUlJZM3E1VUJFSGZXbjhhTGdKcEgyUm44alpkMWx1NEJs?=
 =?utf-8?B?ejdzakFtUG9IdDdnNU9kQ2xHenRtVkpaNTE1WENONzFLeXlsbU5xdFhDMDhD?=
 =?utf-8?B?RDZxZ0FBcm5HWmd4QXNwNS9vSGUzOU9CYUlnc3ZMQkNUQjVXa3JCeFdLc0th?=
 =?utf-8?B?K1BJaFJQOWo2UVgrTXJ0T0s1TjdaNkdGb1Q5K2F5WXNpK0FoZW1YallWMXpq?=
 =?utf-8?B?aEJIMjFtU1hOQjRCOGVjWEU2THU0RDlsR2VPNXVsUSs5cVlUWEJZYlFQeDFL?=
 =?utf-8?B?dStOOFVxOWRyZEdMZ2RLUGw3NHhWRVVjRyt0VVlBcXAwUnE1Qzl1aWJwR3Jh?=
 =?utf-8?B?WkNNMnE2T05wV0tENUNCb0xjOWlPVThvZ0FJYi9HbXNwdGZQQWdpQVFsVnJt?=
 =?utf-8?B?WnlhMWpuM2IxYzE1NEwzbEY4TjV6SjVoY1Bsays1aGVHTkxIY2dTNHdwZGRq?=
 =?utf-8?B?RU9JV0tVM3lHcnN3QjlzSkNCeDFGVW5HZnlyd3N5RDlEQUFiNjRrSGVSaGE1?=
 =?utf-8?B?dUxPSnByNVlRNWdMODZhSEYvenV6a1hCTGk3c1gyVkcraEVrV1N2U0hROGJt?=
 =?utf-8?B?RUtaM2tXQlhHNXFIMEQvTWthcjkvR3RBcEp5dS8xOW5VOE5OZHhnUGRJZEw2?=
 =?utf-8?B?ei9heGZQN2NoSThBT0VPZE12V2ZJVnF1dXI4ZGtLN1JMNFlabHJRTUsyU2ta?=
 =?utf-8?Q?Z1CKEgIxYdzBxJtATZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26bc421-8bc5-4a70-7219-08df14dd1d1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:00:02.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93qC2hhtFyEh7HQy9heWA1ZYxN5wtwMstScHMpBTbaXIAWI5uLBXZxu0zUO6JWQU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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



On 9/17/26 17:32, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> A user queue restore can rearm an eviction fence after the BO reservation has been unlocked.
> Since dma_resv_unlock() discards unused pre-reserved capacity, a BO with no remaining fences
> can reach rearm with max_fences equal to zero. Reserve one fence slot immediately before
> attaching the replacement BOOKKEEP eviction fence. The BO is already held by the drm_exec
> context at this point, so the reservation remains valid for dma_resv_add_fence(). Keep the
> reservation in the rearm path rather than hiding it in amdgpu_evf_mgr_attach_fence(), so
> the caller-side accounting remains explicit.
> This fixes the dma-resv BUG_ON at dma-resv.c:319 and the resulting crash in
> amdgpu_userq_restore_worker. The earlier root-PD and WPTR-caller reservations are reverted
> by the preceding commits because they do not cover this reservation lifetime. Validated with
> repeated amd_deadlock runs, including the userqueue restore reproducer.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Change-Id: Id156389c1b2193fc3e1354acd5194f756faf39c9
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index a0802012de49..6c1f994ea78b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -125,6 +125,7 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	struct amdgpu_eviction_fence *ev_fence;
>  	struct drm_gem_object *obj;
>  	unsigned long index;
> +	int ret;
>  
>  	/* Create and initialize a new eviction fence */
>  	ev_fence = kzalloc_obj(*ev_fence);
> @@ -146,6 +147,13 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	drm_exec_for_each_locked_object(exec, index, obj) {
>  		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>  
> +		ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);

That doesn't work like this.

The problem is that dma_resv_reserve_fences() allocates memory and that in turn can invalidate the eviction fence we just created again.

The patches you want to revert actually look correct to me. The fence slots usually needs to be reserved directly after we locked the BOs.

Regards,
Christian.

> +		if (ret) {
> +                    pr_err("userq evf rearm attach failed index=%lu bo=%p ret=%d\n",
> +                           index, bo, ret);
> +                    return ret;
> +                }
> +
>  		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
>  	}
>  	return 0;

