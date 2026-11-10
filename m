Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF8606A339
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MetTAo7a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DA810F67C;
	Tue, 10 Nov 2026 12:26:50 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9AC10F672
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 12:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Katq78GHcvdmfPCuhOwZwm7o9v3fFOmJ/NSWQCENthFjf/fFnMSGyWZMFobM/6y0Nnfk3DK5njDab44nk1PFx5RXSHKZMOAw65Dx/qNXHFzalOhZOJFnv41SOCtj3Y/faYssEpTSTqxZhQ4LYvs2678V4w7rN/36SyydToi0lioChY19/e0bwbrbm/cRSTmNjl3LwhyCg0Rt5zRiGE5m009YvyippcvTcWDjqNAr/QuylS90e6FVrwvClsblNuq265pHMA9Bpdiadt1XyEJ9PXG3EA6+bZRr2rLqiehrksg4QlX3c4wHpNp+OU2IchncosQOsk6DqzGYedUC5/9cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhe1TN/jmpb3u85jUwI4vIstidGC4GlWx6wSjvqqJBQ=;
 b=FkFWwraMatzGSGm0LyiEUrCAZXUriogW1E5DLPGlGCLVvxZNI5KVsGG1hjzdyIIamK5oViBpVTBWLsTkXVigpa5lU0thRkDy2x8Mgg9EtHeMFBrGPDTsokx5r2vP5f1C8j9/1l/LzmMq97058LlO3OKSbxtkXQ7vwxKKFzC5jEY12iSQbGjKMrvaprAFQdpdmBZzpvCGc0oErI0rod8Xahm7cU5/+MQxyq7UJfPHnDVUUAAU/VsXJlT1Tojm2hhrNEBCeuNozNW7Jy6t+YUvAMs1f/AcBJWPPf4ZhQxF/Ldwmj2Vhre9Aa/UYVuYcy/1glStFvqPlVJ/Ec9f4BACfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhe1TN/jmpb3u85jUwI4vIstidGC4GlWx6wSjvqqJBQ=;
 b=MetTAo7aHwpD4Zb0IbiX385VLFuuVWTu3AvUG9J7W0sB32rlqrqy0gd8TJ0NaGoeA5qf+UjDhq216icTN3IHDYi0dfjzRPHbXU4J8jgHcmmg27k1/FjA3UkL5EFkjMqspDyoHuPXsJ74KpOSChY4dXNZZfpe6Le1vOMAzBOBj5U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:26:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 12:26:41 +0000
Message-ID: <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
Date: Tue, 10 Nov 2026 13:26:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu: handling PTE backend update errors
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ca9ed9-fbf7-4b56-172d-08df3f25dfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|5023799004|11063799006|22082099003|18002099003|6133799003|10067099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: Gg7z2+TUyH1B4csQIF4tM+PZZkZzd29InMtscZ753NDHFQ6JlWfse1PZTFlX37Ma34X18WS4QcTUBsnEi++UloYBvH+MovmPE7WJyHeObBJZg380o8Twf/ak4sQJ0uCilUAy0Y8SJBPlW1ZHK3P0vLbdajTgQbxwXBC8Yz/9ht4kE6z1KPCKh+fW2FHqLf5JtYcZyKy9vYbK518vUSD0Gc2NdwOXpjHPDHTc2FNmH7jpFXhnZk/VpZUDhjFWs3gZZLAkFO9UdKYsGnU1qjBEIvyCrP3ECJyD7Sohm7KWOjphSGQwQ/KgBUx4xW3bD28MgrHLh5pRwv+242dhUNs2XA5pGspzQyG9PvYksbn8/XRdqDsE8HmnfZI1dswtCuLsSAXCeiLGrjfk9fxl3MTBBxOEuaC/m2AhfXsD4bQcFJpIiaj63VIUxmKFFj43umtBkU+38wHN6u3yuPsTMtphEba+2eX81KPQzYBJC9yBYi0LQ/F6aaNBroNa/+x0xvea6cMpmttLJc341P/jydDebNJu1RnQjikBXZUrrmQVp6vkDn4HN+HSrleZG8bk5Dc2n/M5hqfcIJhOFfstgyHyXWoYWWmNIw14eETj//PzYb5MSgPSnY5Yj49jIVfxMjET
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU9xSFo4WllDVGdvQ29hWTF6RkZGR1pqK2hicHcreWZjcjUxR2lpd2k1ZWRW?=
 =?utf-8?B?S0ZKdXE1alNmS0VZUkdENE43QU9kQTE1eUcxU3dYUFUvWFU2RWg2MXQrK1hh?=
 =?utf-8?B?SWZBZnkvcnhERjkvVDIrN0lLQ2ttRVFjbFVLZkE0MWZrandyRkdqbEE2UU1V?=
 =?utf-8?B?TlNtT0NRdS9iakxvTHhlQ2ZOcmlCbnRvMzZna0kwSVdYVnMxTjROQmpIM1hF?=
 =?utf-8?B?YzNWYitRVDhIOEFOZjgzVDdHUzNEOXZhY0FyaC8yR3JmbjNicXpQd3FhVVlK?=
 =?utf-8?B?L3k1NEZuUXorelZZTWFFdTJPUWtzZ0kxUHM5YkpNdzVnZlgvamlrRSszclBS?=
 =?utf-8?B?U3F4emhnaEYzbVA2UEYwTGhaQjJmU0swT0dySVZrRjN5RkYyT1pMN1Q0U2lD?=
 =?utf-8?B?d0lPa0gzU3AvckJBWDhscDBablFRUWdHeXlqb1NmMVFNeXpoUWNLNStkNXA4?=
 =?utf-8?B?SkE4V1lXeVBocFJPOXRMVHNOaTQ4T2hKVmFjaDIxRTJFRHYwckxxL2FBY3FE?=
 =?utf-8?B?QlloNUJSZmYwTVlGQjU5YTV2blo2SWNTbktYNkxPYVhGYm1IaWUxNUVoMFRH?=
 =?utf-8?B?VCt3bHU3c0lxbFAwUStJTjgzV2Y3eVpaV2lJUHg1WjFpRG8vd2VRTVNtMStq?=
 =?utf-8?B?V2JEbFo0T2tmcmNvdWxTMmM1aDF3VThVMXk5d3NVZDM4Qis3WU94Sk9BVzhp?=
 =?utf-8?B?TUhtVjliUWhNOUs3R0JTa2owQ1ZUb2RBNjU4SnVWQjdKM1EwdUQ2VGZkQjVr?=
 =?utf-8?B?VFozdmRFYXB6aTh6OGNEblA5TUJpY1JzUnpMa0lIRkJxWDFkRHVDbmxrU1d2?=
 =?utf-8?B?ck5leks4OE5FcXpKbnFBL0xYNjVIWlFEek5lcExnWGZrV1lHc3NwU1cvZ09P?=
 =?utf-8?B?TE9ZT3FHbEpDL3FJaVVKb0xTOTdNOWpsWk5Xd0IyRXRlYVpncVcxRS9Zb1pn?=
 =?utf-8?B?UWZnVWNyMVRGSTRheGcvWjBlVEx6bzBnQTNQM2V1WkhtK3VxaWQ4WXhFRnhr?=
 =?utf-8?B?WndzL2tBUm4zc2pJRno0VTk1NE1STVJnVlBFNXliSFg4cnBPTldVelk0VkRJ?=
 =?utf-8?B?MUljSlZQZEVFT01DMm1jSmp0UGZkSzRacG92b3BKZ0VObEgvTUFRVmdRNURV?=
 =?utf-8?B?WkZCQjlRT2dTV1dEOWdjY3dVaDNISmY2SDV6cjdNUWtOTzMwa2d1ejBXTVBu?=
 =?utf-8?B?aG5PeCtScktDbmwvUjRXTEtNVDBQNUhCOVp2Q054NjZzd3I3UURTcVNKTGl1?=
 =?utf-8?B?djFMUlc4OFRWalM2Z0VXV3YzR28zblhzcHd3SlY3RnJndmU5UlF6TkFvY3pT?=
 =?utf-8?B?dUhFTUhjL0h1T3dvTysveUVQYUUxUGVQeTVVeWh3MXpKdjMyL3FFUDlDTGNT?=
 =?utf-8?B?WllMTUpoY2RURURQaE5FNVBmMTVXcTIxQW10V0MwTjBzcFlaWDJjbDBoK3Fm?=
 =?utf-8?B?N0dOeENDRWRQQ3c0cEU2L3NOYVBWK3UvdTluTndrN3ArTmdVbVpxdXg5MXR5?=
 =?utf-8?B?bDU3UUxNa3QzSVc5V1kvNU1JekZodHRBTi9BRmhBak9YdTZQRTZTWlJNOEpq?=
 =?utf-8?B?dXRwMjJFQXQvUE1zdzZUQVZ4T1Rwd0NZaC9obUhKZ21SQWlCOS9DNUV4NTNL?=
 =?utf-8?B?WTJCMGliMHdxNnJqSUxEbnM1T0tVbFF3VVl3NndDRm94WnBFL2pZUjQ5NkV6?=
 =?utf-8?B?ZWVwTk5YSHFpVGtMUGZBb2N2RUJqcUllaUF0UVl6Mm1yU2J2ajRjL0xQRDVW?=
 =?utf-8?B?TWpTdlBPRGFZTDdMNmZtVHk4SEFERkVPTVREVVNtSWhLQ0Y4OTRTY3VEYkx6?=
 =?utf-8?B?M01MN0ZjbWtQM1dBT1I3cDFjaEM1VmUvd25MMFErK1FvV1dqUlNFMUZNeGg4?=
 =?utf-8?B?QXBud0ZMNzJtSnRwa29CeFpLanRkSUNoSExnWXhxbEZwcUU2NU1nbmk0N3gy?=
 =?utf-8?B?aVEyeDViUGk1aGduSThjOGFnZllaT3gxM3E5UkV1OEszQ0xiSFF5NHRsWEFm?=
 =?utf-8?B?cVNhamJzNHBwWnBvemdhdzNRWE9tTEFmNE4zdS83ZGNxTVhOeVlhZGpDUnVF?=
 =?utf-8?B?R1h3L1JRTGF5MHpoZXZpY1FjbmU0TnlhcDJ0U1FidDZZd1lXSEtxT2tWd3d1?=
 =?utf-8?B?VkN0UGZxYzdxTVV4dWdXdFZ3a2tGcU1tNjJSbUlEMTRBMGdyeVRTUXdCZllq?=
 =?utf-8?B?UitOQVNOVEpvR2xPdU5GUjlmeURtcTZvdGxtckdOckFTY2RoYWJlb0d4NHpr?=
 =?utf-8?B?K2svd3RycFhXS0pXd21CeElQWEhRd1ZWSitIZXNkWUlWWmVORDFsaDhpMVU5?=
 =?utf-8?Q?vZ9xuGRUarm7unkLAz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ca9ed9-fbf7-4b56-172d-08df3f25dfdc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:26:41.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IvMHS884qBEceTzf34UhLZMKAbwsRioN1vt5PNWp4goj5oBhywyPDAPoEiN2K/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 11:29, Mu, Zihao wrote:
> From: zihaomu <zmu@amd.com>
> 
> Hello Alex, Christian and Cascardo,
> 
> I would like guidance on propagating PTE backend update errors and how
> that should interact with the no-fail unmap contract.
> 
> At drm-amdgpu-next commit 5349075eac14, the void helper
> amdgpu_vm_pte_update_flags() calls update_funcs->update() but drops its
> int return value. The CPU backend can report an interrupted fence wait;
> the SDMA backend can report a dependency or replacement-job allocation
> failure. The PTE walker can then advance past unwritten entries, invoke
> the backend again, and return success for an incomplete mapping.

Yeah we need to remove those error codes. PTE updates generally can't fail.

Regards,
Christian.

> 
> The illustrative diff below returns that error and stops the walker.
> It is not a complete fix for merging: propagating failures also needs
> correct finalization of partially written PTEs, pending SDMA work, TLB
> handling and the stack-local tlb_flush_waitlist.
> 
> The local RFC has two cleanup prerequisites adapted from Cascardo's
> September series [1]: handle missing/empty SDMA jobs, and finish partial
> range updates while preserving the original error. The ignored backend
> return was also raised by Sashiko in that discussion [2]. I am not
> claiming the earlier cleanup work or the observation as new.
> 
> I have excluded the earlier mapping-retention proposal, which Christian
> explicitly NAKed [3]. amdgpu_vm_clear_freed() remains unchanged, and a
> KFD caller still discards its result. The remaining contract questions
> are therefore important before proposing this for merging:
> 
> 1. Should errors during clear/unmap be prevented or completed inside
>    the backend before the PTE walker can propagate failures?
> 2. Is there a current map/unmap split or successor series that this
>    work should be based on?
> 
> On the native base above, isolated models using extracted functions
> passed 5 PTE, 17 range/finalization and 2 SDMA ownership scenarios,
> including baseline failure and deliberately broken controls, with no
> ASan/UBSan reports. GCC 13.3.0 compiled amdgpu_vm.o, amdgpu_vm_pt.o and
> amdgpu_vm_sdma.o with CONFIG_DRM_AMDGPU=m. These are modeled errors and
> object builds, not live kernel fault injection or hardware validation.
> There is no claim that this resolves the original GPU queue stalls.
> 
> For background, the earlier vendor-tree PR is [4]. Its four commits
> are not the proposed native submission, and the independent CPU fence
> scan optimization is outside this discussion.
> 
> [1] https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg635900.html
> [2] https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg635904.html
> [3] https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg638593.html
> [4] https://github.com/ROCm/amdgpu/pull/243
> 
> Signed-off-by: zihaomu <zmu@amd.com>
> ---
> Illustrative error-propagation diff only; cleanup prerequisites and
> agreement on the unmap failure contract are still required.
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index c73eb416c0e2..d9cfced93081 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -701,12 +701,12 @@ static void amdgpu_vm_pte_update_noretry_flags(struct amdgpu_device *adev,
>   *
>   * Make sure to set the right flags for the PTEs at the desired level.
>   */
> -static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
> -				       struct amdgpu_bo_vm *pt,
> -				       unsigned int level,
> -				       uint64_t pe, uint64_t addr,
> -				       unsigned int count, uint32_t incr,
> -				       uint64_t flags)
> +static int amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
> +				      struct amdgpu_bo_vm *pt,
> +				      unsigned int level,
> +				      u64 pe, u64 addr,
> +				      unsigned int count, u32 incr,
> +				      u64 flags)
>  {
>  	struct amdgpu_device *adev = params->adev;
>  
> @@ -735,8 +735,8 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>  	if (level == AMDGPU_VM_PTB)
>  		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>  
> -	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
> -					 flags);
> +	return params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
> +					      flags);
>  }
>  
>  /**
> @@ -812,7 +812,7 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
>   * Update the page tables in the range @start - @end.
>   *
>   * Returns:
> - * 0 for success, -EINVAL for failure.
> + * 0 for success, negative errno for failure.
>   */
>  int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>  			  uint64_t start, uint64_t end,
> @@ -921,9 +921,11 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>  			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>  						    min(nptes, 32u), dst, incr,
>  						    upd_flags);
> -			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
> -						   cursor.level, pe_start, dst,
> -						   nptes, incr, upd_flags);
> +			r = amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
> +						       cursor.level, pe_start, dst,
> +						       nptes, incr, upd_flags);
> +			if (r)
> +				return r;
>  
>  			pe_start += nptes * 8;
>  			dst += nptes * incr;

