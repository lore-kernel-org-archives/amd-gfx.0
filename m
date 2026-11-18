Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98524606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GCYQlMjP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371E610EF3A;
	Wed, 18 Nov 2026 08:39:26 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F46910E230
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 08:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGy4tE0F+8n21QTnlfTHWnCOZI0lvK/jyqV3VEwoKkZxlKbwlFTUq/neX0g/DH0b4C2EboE2wlnOSrwcAKXoRNvhGP5L2PrQGUekQsDWvh/MQgHa6obo9VOCjqVkbAFhuL8WLarCXkw8Hh5UQvGpg2pU+5ACfFAiWrfmyRDqGqVd/79s+hK5uSqXOVP5UkdbhUQ0Mb+jedZUTzMwAR1TOEjoF7H1Ig0UxoeqodYDxkVbnfjIGLAnIGnKGOT8FFZ6sARbhMvDnO7xpv6YdgWIH5U0IoBMFCtIjoNdPbphsr3VYBCobybp9GxIJ9avVFm3FuGJ9jeWwfVD0cg8L+YjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeF7TUe9X9/AIlcmwoOyqgBxSbS+VYCr/X98kyNUgJ8=;
 b=IU2gV36WNUZKKde/ad3cLSOYXArb0LULr+yF/8mZiM9lnxrbf1dUdzif3nAWHfrvncjVUaed7vDatyXzW89XJYoi0ugkDiFhYHlmzy7skRiXcFdAaVr6r2NYnCRt+p+EfTpzGQWbGCVwyXzDL08k42olYkCreVqzY92ukA98uGJwJ9havioEEbmPOlEEBJAdiO+yFzzYMrmDc7jC/BrSihw06OhFnYYrdjmMW4lzPr4Tb2p8iA2732YfXJ5jngbqqwST6nlM5s3Zl6Txw6Z79FuBFBIucddm1qyAyhsCEcNLyemYLfYmMW7zBnuJQ3a/SGNo/obDx0SoFiVCkSgEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeF7TUe9X9/AIlcmwoOyqgBxSbS+VYCr/X98kyNUgJ8=;
 b=GCYQlMjPBM2ap610snTSXXRw8pK5UxSv1H8qR+sGwThpqQzEVcB5UA/ZolupcbKpMEcJR5eM4m40Pi02VXSDXtfta/z8fBu3tuFmxGlYt4gAL0kuQTreAn/rECfpVPjX4sJSUabzueWog4RsKGffWOgLqaKxP3y13SdezlnBmSw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB999094.namprd12.prod.outlook.com (2603:10b6:408:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:39:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 08:39:17 +0000
Message-ID: <54e51223-26e1-465a-8d6d-e4ebf4110c87@amd.com>
Date: Wed, 18 Nov 2026 09:39:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/5] drm/amdgpu: restart VM updates around
 page-table allocation
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
 <MW3PR12MB4572986213556B63A708CA4F9E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB4572986213556B63A708CA4F9E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB999094:EE_
X-MS-Office365-Filtering-Correlation-Id: fabd991a-5be1-4481-063c-08df454f6e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|6133799003|261009223027099003|3023799007|4143699003|11063799006|56012099006|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: myzJ9UfOWf62lYwNpxKaHPwwrev56YUqF+3m6wUM+YqM+Mmbi14oolgj/p+lkjqBdu2JMwGRR2uz18CR9Jlj/zP5mmMx4GECfUsP26OYYUTf9fWEhMDmjQRwhUNC6T6gYVwFO+Qpq7y/ifhEmDUqvIgzJ1Bs1swalXteeq5UQLUwHm67XwjY19A0ZlEEWhFru7tqNxzx5QDiU8hJLykVaOs915+wWMdjQvA7BA/Aq1/4fSCYex8oRU8tVL6JBUfE17gZbq7WoQ8WsRtJigDBfV/E/E/+EGSKascU8Xh81L07/MQFKEMHXZBrPtzNXMbUSWyk7YlicVVRWKmSg7tLK1TEiERKnTab2RsbMJ9s1HE6D5tpc1XLtzDfRYoyZFQSN8GlzJRJuogHSjKvmgc/UyQ6CnvHiIoVd2Yk6+G22M7sOFbgFllu67F5UhOXfaUtLj9xlJhzO4giUJ2MdHTyGDgcFswA4WKOt8VpfQ1LaURnJ7Sq+n1Cbqx3NBm5+iZVIKJDQqiKA3tTbkn2e40mp3jR3vWaFIj3V2ir+gvXgVEjKWm50sBG/WWJ+uCc1AqBrhh6nvt5uNeXxqN909qqsxHemRJXExe+xCsKq7jbzoN+vxkuqhacLjIPXJivbbY5/sTUcFAn3BY24+EiOAcNMARfa9S019uMwHfR/FRX/KU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(4143699003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEMzdjQrSDVDSmFsakRINDl0dXVVYkhXMGpndUZKRmJxWHZaQ0tCZWh0SCtO?=
 =?utf-8?B?Y055bzMyQzlsV00rRVZpU1dDODZSNmVPWjN2OXhlQVJKSXJPeDZZa0E5ck5K?=
 =?utf-8?B?Uk5FRnVsU01BVm5WbTFxVkRBelMvMy9JV0U0MnBDYzhFRDdTSEc4c0Rudkgw?=
 =?utf-8?B?Rm5KdFhPK2RWN1gwMlNVU05KdEsxVEUxSzJYanlWOUZMMTdMRyt2Wkt0SjNl?=
 =?utf-8?B?ZzlYWUV3MmlmNUV6RFA5cE9rVStaWGZESTFudThYKzYrRmhEVk1EZnFHbnI1?=
 =?utf-8?B?dVNncFgzdlFBaFNTNXdnMkw3ZzM0ZmJ4VDlvb1BGU0hFeDNJd2lJdWxFU09F?=
 =?utf-8?B?bFgvY2l0L0txaXJIcWEzTUxZeVJCQVk4YWhVYkVxMFRidUFCZG5RWHpzM3RZ?=
 =?utf-8?B?MUQ2a2Q3UUtOazJTc0g5dllvT3I2ZDRpcm9GVDJSeUt5dFRlY3VlKzVSaE14?=
 =?utf-8?B?U1lUZ3ltczViRmFiczRrTlhtTVFOOUtvUTRjZ0cyU0JJcVRHY08xL0RNYmFF?=
 =?utf-8?B?YmlCR2VWck9xTHBlbHUrMFZMUTBKOFYva09XVUlGN2p2cnlIQWVWZ3ArZGhy?=
 =?utf-8?B?Mk4zVTJiSFBRWGc1bFhnNThrVjFoNWZWd2hobCt0Z1ZENzl2eks1QTcxMmta?=
 =?utf-8?B?cW1YdGYvZ1g2WlUxWUNXc1FaRFRYb2hNZWNkL25HdEpBamJYUUEzc3dkbHZu?=
 =?utf-8?B?V2ZBSlJUTWUrZlhHdVdQeEFTb3k1QkZUUDZnK1VUblZBWU1kNm5WUElsWmlZ?=
 =?utf-8?B?cWRYdDVCaEE0dVBzRG1SSzFsUk12bVRMM1JwWlZxeDJLa2hWeWNhQkJwRFVq?=
 =?utf-8?B?TWNqQVFlaUs4czZmeEQ0MkNHcTcwMGhpS0VKSmh5TDlmM2I2d01rRmxwTVU3?=
 =?utf-8?B?YllSclg2OVFlYXhRbVJpTDg1SitOeG4rMWNuSXhBckpjaE5tV2sxZytGaFdp?=
 =?utf-8?B?dVAxMWZ1SXBWLzZoQzhlaTZXT3k0UllWZThNeUZ0RFBkMUV6R283SE5HcGJ2?=
 =?utf-8?B?MloxNmd2d2laN3JSZTN4dTl5clRENENET245cDhNSStTRllnOUR5NGk4U1lL?=
 =?utf-8?B?N0hVUXVCZGxsRmtHWVltM1B3VVprazc5OWVqODZLakRFUlg1TXBXZnlTYnVX?=
 =?utf-8?B?V1g2MEhuNXJHMzJ2a0hHbGhTeW9NOEUxYXV4cjEramY3cTdUZTRxYm9SazRQ?=
 =?utf-8?B?bUxmeXRTUjlBYXo5bE5LbFc2NlNZVmxzSkFNVU16aDN5Vm4rdmQ3eGpBamYw?=
 =?utf-8?B?ZXpuV3dRTlppQURaNDJDTEREUDNxNW51WHVjU2g1NmRRRHB2c2V4QjFJam5q?=
 =?utf-8?B?OWJKMkVVQTRJMmdqVWIrZ05vdzd0V1R3NVpkbzdBNWhGdHRDbU5YVWo1OFVL?=
 =?utf-8?B?TjVxRDVjbjFJZnpXSEdpMWVkRmdXTnhHZEI0V3BraHB6R0lxaTl4REhsdTFw?=
 =?utf-8?B?Q2lhQUZwTExzZE85V201dHJJR29hcFJTZkJyaUpsbHdXM29CNDVMQW9NTDlq?=
 =?utf-8?B?SEQzZmsxRTFlZ0JIVDRyMDRML1ZRblVlZ0dyY3k2ZDZhR1BxdHBzNFR0TVF4?=
 =?utf-8?B?cFlCUys2cE1xdk1nRWF1enU4OTNEM29TVkxjWGdaOGxlWTBVZkl0eW14djFO?=
 =?utf-8?B?S01ia1dqVVZpcTliaWowNXQzdFJtNTI3YVBIbUFTa0ZVWlNMa29aOUJpaUpZ?=
 =?utf-8?B?UTlxKzNJYkRFZjBPM2VuSk8xdlFoOS9rSkhnVVNrSXkzRE9jQ21qNW5XMU8r?=
 =?utf-8?B?WlhwRmxuUHBYMDZzVWJlN0JJOFNZYUdicXkwN1ArUEM4a3lDZ2F3aVl6L2VI?=
 =?utf-8?B?aEZIeVpsOFhkU3hBL2tpNERVYllVTFNqN3hPblBJZndyV3Nra2s0bU5GYkNJ?=
 =?utf-8?B?cloxTkgwSkM1M1hQc2NuT3lheWxrN0pieEtVUHdtc1FEdTh0aFpsenRwWTE4?=
 =?utf-8?B?MGs2TUV0a1ZCNHhxSyt4M1VIYi9jNCt1cWVTNG1uZ2s5dHB0a2RZUGhRMzRE?=
 =?utf-8?B?N1V1T05OZFp4UjlZWm9nVGtDYmxVblFZVU5hd3V5M2dtRklUWGhkNGI3Qm5s?=
 =?utf-8?B?ZVg3ZjhEWHpySzBISkR5SzNLL0c0QTg5b1pxRFlUN3JSeHVibjRaVEcyZHJx?=
 =?utf-8?B?dno0dFcxV3VIdDZNZXVWOTk1K1FWUUR6a2pUbzZtMUdQQ2hQVkI1ZU8zdUpR?=
 =?utf-8?B?dUkvNWFNdm5VeUZuUEd3MVpocFY5TURUZUorWStqcXE2ZXBkSVR6M3RoSVgw?=
 =?utf-8?B?djd4czFZRC9wcTFnbGI5a3FnS3VFc3RybGRINmVxeklxbGZSemVvZjZVcE4y?=
 =?utf-8?Q?5B3D/y7Y8kYt0zC5k/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabd991a-5be1-4481-063c-08df454f6e8e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:39:17.2986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69RcgrNeCWmxycLMKKcP5ho+tVdNTfoFbGLHm4Uf/mxJCxrEX4XCsGHEhtC/GfE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999094
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 12:40, Mu, Zihao wrote:
> From: Zihao Mu <zmu@amd.com>
> 
> Commit the current phase before dropping the eviction lock to allocate
> a page table. After clearing the new table, prepare another phase with
> the original sync and the context's original job ID.
> 
> The eviction lock prevents table movement during a prepared phase.
> pt_alloc() drops that lock for allocation, so it must end the phase
> first. pt_clear() validates the new table before its own prepare; the
> outer prepare then covers move dependencies before resumed writes.
> All these submissions preserve immediate and use the same entity.
> 
> Finish the nested clear's current job even if its update fails, keeping
> the original error. An empty job is freed by commit; a submitted clear
> completion is already transferred to the range context for finalization.
> 
> Keep an initialized table installed if the outer prepare fails. Failed
> initialization uses the existing teardown prerequisite, rather than
> introducing another copy of that fix here. Existing tables still return
> without ending or restarting the current phase.
> 
> Signed-off-by: Zihao Mu <zmu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       | 8 ++++----
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3f3c5a82fc1..df65e02bfa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1204,6 +1204,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	params.vm = vm;
>  	params.immediate = immediate;
>  	params.pages_addr = pages_addr;
> +	params.sync = sync;
>  	params.unlocked = unlocked;
>  	params.needs_flush = flush_tlb;
>  	params.override_pte = allow_override && adev->gmc.override_pte;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index 9bd71f4d5b9..cdf14f69376 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -87,6 +87,11 @@ struct amdgpu_vm_update_params {
>  	 */
>  	struct dma_fence *last_update;
>  
> +	/**
> +	 * @sync: original dependencies to preserve across prepare calls
> +	 */
> +	struct amdgpu_sync *sync;
> +

That is nonsense. Only the first prepare call needs the dependencies.

>  	/**
>  	 * @num_dw_left: number of dw left for the IB
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 7b7a576d95f..1a2352c8c8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -426,9 +426,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>  				     value, flags);
> -	if (r)
> -		goto exit;
> -
>  	vm->update_funcs->commit(&params, &vm->last_update);
>  exit:
>  	if (last_update && params.last_update)
> @@ -532,6 +529,9 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  	if (entry->bo)
>  		return 0;
>  
> +	/* Allocation can add move dependencies while the lock is dropped. */

No it doesn't. What can be is that we have more page tables clears but those execute sequenctially with the PTE updates.

> +	p->vm->update_funcs->commit(p, NULL);

We need Thadeu's patch to ignore commits with empty IBs for this to work correctly.

Additional to that the returned fence parameter should be dropped from the commit function.

Regards,
Christian.

> +
>  	amdgpu_vm_end_critical(p);
>  	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p->immediate,
>  				&pt, p->vm->root.bo->xcp_id);
> @@ -558,7 +558,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  		return r;
>  	}
>  
> -	return 0;
> +	return p->vm->update_funcs->prepare(p, p->sync);
>  
>  error_unpin:
>  	if (p->vm->is_npa)

