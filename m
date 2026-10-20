Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523DB606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KCk5DR/u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE6110F5B9;
	Tue, 20 Oct 2026 13:55:20 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C227C10EBF1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgdgqnhUoEV2RCPr0kAiDBKm/uCJoWE9CYumwWeaXkr3VcM48+Mf5Q3WSRBevpnZ+ayLTYM5qJDxaIKs9m5MvTSvlWfSI5Dnq+acIcAzaWu3re0VyldrKBegR4F+2fiVC8BEKYAmu0Tv79iB6vudcVMX0lEqQ9Q4WmMZgPwALniwLBpGRZl5DCgTd97S3FH3l+kooleml1rymBHcJ+wPDVBWEXRKpvPaDsPBSXCrKGBNrwlUSSvrYOJVqwMjGhpf1tcuvcGbDIx4wNkwuZPH7Qh+lUWrxTnDIy4LSNSgfLsxT51NW6y6r+b36fLv7QoflQm0eK5qvNgUNoaEDnpczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bE2KAAEUwkQ4VPZoXuxfJ10xpeuUxeFzi5S0nk5vCU=;
 b=LI+BldY4TL3q+7vZ3dZx/iNeMIxg+YyW8W61nrWA0XwY5WewTWmiYyM7QdC4LSn4cci/iqrtM5qJFd8i7nNP64ZZOuUtqDaoGJ2hrfYvjemP3ZHyqfKMdXlk/krO6GSHp5FrJSEbg/D4JxjtYB/dQi7yLqG/oDwTO0pCLqGR3UJ20duhnPPvRwg1gVJlT7x7+iCGFpNOUs5/ZUlVAIXUBEhex67H2qGlowZWw5o47pnYi+MXhkS3rcz36ZakEfboFRGPflGkV8WZ2PkCOTzQ8FvYqotIw293+z4VAiLSTHmiNgRsLNSY5StLZl481I76bSxOE+6HnxOBPw1es7xYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bE2KAAEUwkQ4VPZoXuxfJ10xpeuUxeFzi5S0nk5vCU=;
 b=KCk5DR/uEcqucJBB6bv+SHmvjjuhM0ZykdmMhOPpGL7eXgYcDkmbb5FXaKGTMhVlZiqI+RkPUdOAloenUoDw1AO+yoqJ7Pu2gRn/0UHNEMEXfBbZg3u4G0a7h7rpD0qeEpJy3i1BmQCfiUp6e8Z4GN0ZLyS82ZdX8WnVwqQTGnQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:55:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 13:55:09 +0000
Message-ID: <cebd6011-33cf-4513-925f-cb82005009de@amd.com>
Date: Tue, 20 Oct 2026 15:55:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Simplify amdgpu_ring_init
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
 <20261020132739.31852-4-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020132739.31852-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 39dfeccc-0add-450c-38b9-08df2eb1c0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: xMLeLwSG3UNmQ4T0mW3Ksly/QrKN5KrL3EL6xW9ibYw8CxZXHRBR3CEZ0C/QXuxRmx1+S0b+UdBmOjHrExfZU0W5RZRIfGzsrVDF4FGNegVvHzPnj1sEeyQD55Ch23o0Nvgqmgh0C/5fKSUrcmh3nJ2neFH+5EF1Tdbvj0j/e3tDyuxUpkZGaqbleBMuYuC2+3UNGqIFKJrq5PXXoPD8+EvQXf8CPO7TQ2p7BJV/dCpsC/GoyP8+5vawqoyonLTk+vglaMaUcbHoKACC8IjYuahu3tc0sVY0mEL+5XozSPo9LPVcRJHzvDU+gwbp/y3QD/qgaVMxHA9aUyTZU0smEyScHXMYjgDhs7lIAdnHuKDyB0ixaUn/PyqWSHCI/VMg2eXVWJo1Q9bEeGfROGb32vl++iM/o01mXumwwMFqcUfZT4n8ylQ0orGVfuJLyPl24gPaiXoP0Prji9OudWXFQ/rngNR65IqGC8LAPday07+Fss2qAfMd74Jp435ILqlMIVda7AKHaFUZGNmpf8kpVAM8Wqc8eTZxvDxDbooRwaaoNSss478KcFArWHOaycQaYrgHIUxznWK6pgEnEai3JJwVuMyYEVfm5Z169ayeDrQ9hp84EDx5EZkjskhpOtrv9jqy+Lm3fv1IrBS+vo2NjTzEWYtRlTS5HgsQjOQXN9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRmVDZJNmp0S3kvWlphRytsaFNteTdxZmtxTDFjODJsWGNQbXBiTm4ybWRW?=
 =?utf-8?B?a0xoT1NBLytHc2ZKRXg2bnVqNVpQTjRMM01xQWpoM3ZucE9nR2JTVDRmWXp1?=
 =?utf-8?B?TjJleWRVOFlLYU9IbXRsUFpMWEc5eEo2d3A1eHk0VjJxV0ZzbURjUUZhY1ZQ?=
 =?utf-8?B?UzZnR25yOFRheTI3NU5sUmhwSEVsSWE0RWFJVFVUeWEvNW02L2FEdFpuOFNH?=
 =?utf-8?B?V25EMWE0cXpYQk93aDkvNnM2NkFRcytlTWxEd0c0T0w4cFNXS0I3SjJ6Ykc2?=
 =?utf-8?B?MjJFVHduQWJzb2tZb3hNKzVFTk5vQW1xRzFDSHBQdXlYbFBJdVlpb1BWenB5?=
 =?utf-8?B?eFJvUncyaGpSV1hybE5KVWdiZnVsOGlzQXBLRVFkd2tmTjIxeFZUaGlKREYz?=
 =?utf-8?B?RUtIeSt4Z2hZa1lDZVlUd20ydHpCY1VuV1Y4Rys3RjNLeU5VTlFWNWFYeHdz?=
 =?utf-8?B?K3RKN2o1eHFSMGFleTBUaUJxQ1pUYUc0eGxkSEp6WUhZMnc4a2k5UUk1ZFE1?=
 =?utf-8?B?dTFiNEpycFlWZXl1VkRIYmtNVFBTekNYMlNvb0dSL1A1emNYcDE3aHBJVy9W?=
 =?utf-8?B?RkZUdXRUdHcyMFgweVdOdlVqSmQ4VmVWWWlOSzFjYVkzei94dHdlZjBGakcy?=
 =?utf-8?B?S0tzR3FOUWdmVTAzeGYzYWdReG5HbXFZRENXNGxxa1hZR0xObmNOODE4dm1i?=
 =?utf-8?B?dEJ5elRlcTFMZlpjUFhyaE9WOEtoV2hKL3J5ZGw1c3BjaVpEUVBPdWhzVUdt?=
 =?utf-8?B?NHVDQVJVejVSczM4NnVOQWZhc1JJRUxNUEZOZFE3eXEyUDlvYTZ6SnhrZ0tx?=
 =?utf-8?B?ckloeXNYTHFKazR6RG1LdUFLYmZKQURDZks3SzB5VlBYREVGdUV1ZnZCSVVw?=
 =?utf-8?B?bmt6Sk1VNElvM3hJTXVSc2U2a3RWMjNuOUUxTkl2VCtOVEVHek9BeFlsRTVB?=
 =?utf-8?B?STBUMmhyV05KUVR1eFdEb1V1Wmt6VWlzcmV6VjJrQ1Vrd1VRNkFNSFZLMUpQ?=
 =?utf-8?B?QUJyZnl5OEl1VXI5WnVWRnh1RG5SZVFkazZYSW1LM2w2N2JLYlBGenppVDJT?=
 =?utf-8?B?d3dNZWREakErK3p2TytWLzZNVUx0ZTZmOWptb0oxSGo1RlI5YVlwTkR5bVRY?=
 =?utf-8?B?RVc5cVRab2s2b1F3eThXMW5TQldQbU01Z1RNcnlMeWRPNjJvVitEeGlHQkMy?=
 =?utf-8?B?TTB2ejF3a05vUVd6L1FUOXRMUVhXNmwzVjVRNWtHNWt5VGJ5Tk1pbWE4VWdQ?=
 =?utf-8?B?OU9JT0x6dDU2U1cwVTdNcXFHdUZZUjhYVUxtaE56bjhPT2xXbDZDeDlseDVu?=
 =?utf-8?B?SWlESEZ5Q2JMUXRMRDZhb1M1MmtISmdnNkorRDYwUWRadXRaRnhVTnNwSVFs?=
 =?utf-8?B?UDVvc2ZiTzNhc1BRZU9YaVlaQStaZWR6UUZjMmpvRmwxWmRITUprTlZzMXBS?=
 =?utf-8?B?WXVMT3Z4dWJTQ3hSR253ODRpUHFMbkMrbTk3cG04WjRxbEpZNGNXK2F3bmY3?=
 =?utf-8?B?ZXFwd0JyOUJZNVZXZzVmemFVV2hFcjE2Q2R5dFNJZE41WDhqNGNQMFY2V0J3?=
 =?utf-8?B?ZTg2alZMckwwZkRHWnRNRzRMM0lFUFZDR2xEYXpJNHM1dG81SWZYbTNDUVBE?=
 =?utf-8?B?NGJ5TTdGOWxqOXcwNkd3VTlwZjhMTEhWVXNMbmV4N0VETVVQTUZlWXJuQ2NF?=
 =?utf-8?B?ZzJBcFk5NjVHaHUxejU1UDRtbHl6MXFIK3VqTlNrYnVNUzVXQitaVklWb2N3?=
 =?utf-8?B?WXEvZ3p3bklnRVl3MmhEY3I0WHFyeXlxUGV1SDVJekhKZUlBRnFnMjNYVjA1?=
 =?utf-8?B?UmxSR25ybUJ1N3VyR2MrMkxBK3EzNGpNcjZJSFVVdzdZNUJoTHNiZFJqMFVq?=
 =?utf-8?B?VDZ3Y3FxSnJweGt6UzBEUllaektNWmVjaWgxbWk1RWRoZU4wNysza010MlNL?=
 =?utf-8?B?M2o2SlNSc1hDZDd3RWxSbUZDQWN6bGEyNTh5aUhkQWR3TFk3WFBhbG04cGNW?=
 =?utf-8?B?S1NxQ2p3S3JOOVc2WDBHSEIrSzUrYWplb2l5eTNRZVphR2Z2VEkvU3k0SXEv?=
 =?utf-8?B?dk45N0xydVpLakxtbG5kUGJOMHpla3psbGtsbkx0eXltbTRURTh4WUw0SXlX?=
 =?utf-8?B?bXhabkhTak5BL1oyVDF4VVRVcEtJQUdOTWNMcysvUG51THFEVWQwWDFWa0ts?=
 =?utf-8?B?WTVvYXNVVU1ZSEhWWUtZcVhsbThSOXZGYkd5WklYSzRwb0R0aEpUNGoyS0t1?=
 =?utf-8?B?NW1uQWFqR3psUXJlK0xTYUpEVEVzNWVGdmtXWTYrYTUxd0xKOFVXZWxQWU9x?=
 =?utf-8?Q?jQhbZu87lsqCHCpafi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dfeccc-0add-450c-38b9-08df2eb1c0be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:55:09.0470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmq1TdIg1CAbXQ/h2OBZL5OMwNAJsI1+rVj698RJ/npsMtmND2Bo/xVGShbTBb/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 15:27, Tvrtko Ursulin wrote:
> (Too) many times I grepped the codebase trying to figure out who sets
> adev->gpu_sched[hw_ip][hw_prio].num_scheds and this time I decided to make
> this greppable by avoding the fun pointer games.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 227734541316..7b67e8cecca2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -213,11 +213,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  		     unsigned int irq_type, unsigned int hw_prio,
>  		     atomic_t *sched_score)
>  {
> -	int r;
>  	int sched_hw_submission = amdgpu_sched_hw_submission;
> -	u32 *num_sched;
> -	u32 hw_ip;
>  	unsigned int max_ibs_dw;
> +	int r;
>  
>  	/* Set the hw submission limit higher for KIQ because
>  	 * it's used for a number of gfx/compute tasks by both
> @@ -359,10 +357,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	ring->vmid_wait = dma_fence_get_stub();
>  
>  	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
> -		hw_ip = ring->funcs->type;
> -		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> -		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
> -			&ring->sched;
> +		struct amdgpu_sched *gpu_sched =
> +			&adev->gpu_sched[ring->funcs->type][hw_prio];
> +
> +		gpu_sched->sched[gpu_sched->num_scheds++] = &ring->sched;
>  	}
>  
>  	return 0;

