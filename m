Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FBEC00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 14:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928E910EEEE;
	Fri, 29 Jul 2022 14:30:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9E010EEEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 14:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmaGYhErNYmGnRTDUaaNQztMKHpexxDnv6jYQ7TwuMXRTXq5PwBZd/gqBnZaCVejlwx2sUEYtMPn4h3zixzFPTl0YOhtSWRkzEXDuhgz4MwYbD2Ao+PcKXA7T1co9552FzUsiPjcNFgdZcA6XsjJItIxl0TB3SQnKkM56TMkxVy1Af8jcuU05217FbOOjH5TUB2FaZoIQ3/yrnFxyij908Ro2TGWTHD/V2etFZheLZbin0FNDmqmtPeslnfysazj6kTLZHjCpsE3N9NUAzbU7Ruw8rK31Mw9bOgSedzP1kDU0uiiFfB3m3Xb63r7MKVoX86eJ4P1Ts7AerQ17HF12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiNjU/ry0jTAhGVhLtbRdPnzY8dwppYrs1QFOwJM13Y=;
 b=K8J7kdfMTHUt3rcWAwid3qGcHgVOs7qRCaVrKIzbjm36ZahbIbAPdH1cEv5HCEhUUicZn01U1YZowIGCJFM4tIFiEdpXTL9dx6G0p9m8RvM5eL0sALLx4vmlcBCksyWnaJLvMnU1T1gE8gtIXFlHWKw7atJR1lTZ3Hmby+re/MJuJaEbUOWW50BxiN3TwCxlQmsqaHZZdCc7adEWk8GY3Ja1IJ84IYLZs9hAS84yHIWnj5oyXajK3c0AmfqA99/tImUVzz0/Ham9Ke2Gc5qpedIB5i08dQQmMmBDJzoghikbsNC6SgAXxtwZNToE5AG/di5OyxGD5PvxDet69pLMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiNjU/ry0jTAhGVhLtbRdPnzY8dwppYrs1QFOwJM13Y=;
 b=dRM0+mr1HKk6klpaQ0dAeJVw3TAOkNS5WPlp9tGHscqzx3pjFvj5wEwMUnyoTyrHMdqrePRz/eIHVQ0DyQhDDZfNs6Z+vZ/EoMqtWImFKRrAH+aIKduKscOcfNVrKvNu43F2IBjJXT/vLjS/bHE6GBwMORCldhJMvV1ogFFumYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN6PR1201MB0097.namprd12.prod.outlook.com (2603:10b6:405:54::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Fri, 29 Jul
 2022 14:29:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 14:29:58 +0000
Message-ID: <372aafa7-5a75-2b61-01ad-45d5271b56ef@amd.com>
Date: Fri, 29 Jul 2022 10:29:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] drm/amdgpu: Pessimistic availability based on rounded
 up allocations
Content-Language: en-US
To: Daniel Phillips <daniel.phillips@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220729031612.120310-1-daniel.phillips@amd.com>
 <20220729031612.120310-2-daniel.phillips@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220729031612.120310-2-daniel.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cdd4858-1365-40a0-3fbe-08da716ed06b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0097:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBXGN5WplRswufkElGDQKm04qThTBDxBDx9mVy+u9FSyd0AJYcMZqo4FUYRq5A3tsoHaGpiJvWKLtAuj117AbbOd3iB0ewYMVnO5PDlw40nbxYR4hQ4Z+iv8gvEmqyZmMwC89c61JpkQbj1UgVU/2zb84Bq01qhTqj+Y83zxz5N+HnY7CXq2DPwHqFRBWLMCydK4oFnYS+6KnRudrTbZedRhdPiRp0m3DTtpNkzdFle9etVayheWncPNoguIKJiqS9RlQN4RTrTUBRORUm3pHuMOT7EkJYb6mDxbV/6e6vIHx6IKkDm2dZttmM8yac1K1r/8aryEXEPent9LD7XbO0/CvQcsY6l74qGIM0E4j4Dx0NVaiMevJR+fpNaePlGTpChrJHG3p/a6Anu60JILy/At25Bmp5GDC71vVOx3P493mif37HtxczsI8ad9SpP7a05oAjlKDUBrvgQe2UngtHVt3jtoMXl6gIrzmiDq0VpU8iiDexOhV5qxxoIUmZ6JKkeLq8lii3FH53A00oLj3eh1gptgwclXoN4qFTRdfO7Gzpd1c/Jc/vw32CUfks63d/2ugMfRDW8X3cInjS5gSDngkHFtxYmrxAE598hP/kVwcR6RvPQA6EMpFdH1Up/cMZur7j2mfN0FV+8Tn8v+4sA3CUqn2XOGWcOXnFQK1SSNDx11qXvqB9sNxatSZqhafkeXSy3hJHWZIJFm5G82KuGITPwQJ1VLCQCblxA14MxHzE0cck46syCqGYvPSNxc96Hrj5VE2q7LNLrLdcWGqjfWAXtveyOYUpLL06FeJ/vtiKQMkeldKzyPsRhNmbwsVbTy/13apkAiJ7nqTf+pPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(186003)(2616005)(8676002)(66476007)(66556008)(66946007)(83380400001)(31686004)(86362001)(31696002)(44832011)(36756003)(2906002)(38100700002)(8936002)(5660300002)(41300700001)(6486002)(478600001)(6512007)(316002)(6506007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnNrb2lmandEeGMyQ3A5K2dySjN2aktvUEI0VUNTRFhoRzFhWFZ2Y1JnT2xq?=
 =?utf-8?B?M3d6L2VZVXhxVFhaS0dPeERzOWxFWUpZaEJNbWtTenBoN2RnRHp4bTlJNEt6?=
 =?utf-8?B?eHZuMkpDeW1kT1FZRml4VENiS29TaUxubWF2K1d5MkU1QjV1aUdDQUR1WUt5?=
 =?utf-8?B?VGt4ZkpTcStpZzFGYlJxUDBKYVNrZGhQaEMzVHhKeXBtaG1wN1R5NmJDWk5n?=
 =?utf-8?B?MVpjZnRaOWwxNkYrd0xBcHVEMG5FNTNOMmhmL0Y1cDNIZTNRcVRzZCtVVDVJ?=
 =?utf-8?B?cWswYW9SYUdGb2NONTVtdHFIVEg3VytjMXBOMmdGY1R4MU9pRzJHMFJnQVVZ?=
 =?utf-8?B?YjlJYm0xU1NDMktwTCtlWndBamxPVnRoS2lCOXk0MGJOR0JJaVR5aU9uWkZ5?=
 =?utf-8?B?TEJPb2tmV01SRloya0JiTUNlSFlNSWJUb2VvV2lxaTIxVU1qaWwvU3dkQ2ty?=
 =?utf-8?B?NWdYVzNUVW9lOUUrRHB4MEdEdDBwN1IrNjFxWUgyaThYejZUTlRZRVdBeDNF?=
 =?utf-8?B?NnJ1ckVLWUJwNVNyc2RBak5HY2dnQWVGNno5THJIUVJEWGJqb1VQL214ZXAz?=
 =?utf-8?B?cHZ5T2IybGltMDFUTTFmUGhiSmtPdEtiOTdvY2xUK25rOVhmdEppODgvQ0RH?=
 =?utf-8?B?NDdvalVsMForcHVBSlZSSFloWEtjb1JlaUN4TlVWWVJCcU5uRUlmMjhLMmpu?=
 =?utf-8?B?RHBsZDYzMkxsVkp2RjNLRlRQYkRSQmppNzM5RE4wUW4zb2l1cm9LbWpiL2F4?=
 =?utf-8?B?VDBLYmYzdUtKM1JRV3FvYUJIcm5sOFl2RUYzdjlSamxnbWUrZUxYdFM4Vk10?=
 =?utf-8?B?WWkzN2JsZExrV0wwcUs4dXNYdXk1cTVtZnFTUnUrc0NFQ3Q2ODlTWmMzdm9M?=
 =?utf-8?B?RHpwekkvc3U5YlZzZ2FCM3F0cTNHNU5PWEZJdzdWNzg5bEpjdHJ3UmNpWXpr?=
 =?utf-8?B?SGs5WUI5ZERmZE5yTlpiMHJnNXVwem8zdEQwaHpQUEJoaHRsWXlvNzNPRjBi?=
 =?utf-8?B?aE1IMkdoaTN1Ly9rV3RBek94dXY4cUxLTEFSUkZveVV0b2Jtd0RLbWNHcW1L?=
 =?utf-8?B?WVcycWc5T251MzB4dlhlU2RVb2pwUXk3T1JNSkRrTjcvWWdQdzkxeE9vYjcy?=
 =?utf-8?B?ejE2bXJIRHUrR1ZQT1NwMVhEdWtNTXk4MlhxbHhweURwS1JyaVNqaDMvcFhL?=
 =?utf-8?B?RTF0QmpoUXFYWStIblQ1TXo0NTk0T3dOVkVNdFYyeWxrNWREblpXZFdWWHNF?=
 =?utf-8?B?Z3NYQ1ZKMEV2U3FWUytyRzNLcjBkTzlYcWFEN1hFL2hES2l3eWdvc0lFN001?=
 =?utf-8?B?SDkzdnJxS3MzVkNiQzVOVXlMOWFFMEVWUkt0OG10MzloK0FhSzhVY1R0cW1P?=
 =?utf-8?B?cjdsOVZnQTZqbjZMMk03bzU2MUM2dXBSVlk3Q2p2K1o2VnhHazczUm9SNFd0?=
 =?utf-8?B?Vm8wRnNYb2x3cFF6TDJtaGNhbnI1TlkyNUFjaEprVzVRMjVmTEplUkpOSDh1?=
 =?utf-8?B?TjB6TXpkMTVxWWcyZndONml6ZlgyTkVlZ0h3MURrbDNTVGFEUVE4cjJqS25s?=
 =?utf-8?B?SkxNWjk2dDliVHVLTHQ2V0wzd0l0QThJSy9jTTdiTFVIM3ZGTy9VdDJKZ3ha?=
 =?utf-8?B?TERzQlBmejhmek55d2dJemtZbTE1UXFqZFU1a3VVbTV4V3JBK201cE5hZW9W?=
 =?utf-8?B?V1dndkczRXdVUmo4Z095UlN1ZUhuVUE3Z1JEOE1CdWlXOVZKOStBRzQ1UExp?=
 =?utf-8?B?cUxVdDVaZExwVkZxT3JFdkRqdTRtNkF6NUUvZ3pqV2FDOG5jWU5Bd0RkNXkx?=
 =?utf-8?B?THNCVC9ya2h5cXJ0eEJKYjRQckdzODVzWHREYmpROVdMSmVTQUdwRUZwODVO?=
 =?utf-8?B?aUthU3dvdEpQVXc4bUxmclVPcWFYdGsvOGhIQUw1eXIvK2VLOGRNTGpERW1U?=
 =?utf-8?B?MmQ4WDR1Wjl6eDVtajJyZW96N1liTHZyWFlQR05yWDB1K2NCT2VDNXVyRmEr?=
 =?utf-8?B?bFpkOGlqTnAvWUM3Z05uQXJMT0JEVzBTZjhpK055VEp5Z3laRWRnR1hvcFdu?=
 =?utf-8?B?Rk1RM25oWjZrY2p2L3BpemdlNUpHU0JSN05PMFY2TWNzNHMvRmd0M05PWHpE?=
 =?utf-8?Q?xcsJFMvkyYRYARnNyi754m6iu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdd4858-1365-40a0-3fbe-08da716ed06b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 14:29:58.5095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rK+t21R3+RUtsSlHptzyyFd3EU6bzydYq+p5xR/cTrca8v8uKI3uaUaFG0LnirvWA5TcnZ+p5MwnkPlXepBD9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0097
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

Your patches are missing Signed-off-by lines. If you use "git commit 
-s", git should add those automatically for your convenience. Other than 
that, the patches look good to me. With Signed-off-by added, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


Am 2022-07-28 um 23:16 schrieb Daniel Phillips:
> Seperately accumulate a statistic of rounded up allocations to use
> to report availability, with a view to increasing the likelihood a
> buffer object can be successfully allocated at exactly the size
> reported by the availability API.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 73bf8b5f2aa9..781274be5f27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -96,6 +96,7 @@ struct amdgpu_amdkfd_fence {
>   struct amdgpu_kfd_dev {
>   	struct kfd_dev *dev;
>   	uint64_t vram_used;
> +	uint64_t vram_used_aligned;
>   	bool init_complete;
>   	struct work_struct reset_work;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 014a594899fb..e5ea897f56bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -181,6 +181,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	 * memory, TTM memory and GPU memory as computed above
>   	 */
>   	adev->kfd.vram_used += vram_needed;
> +	adev->kfd.vram_used_aligned += ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
>   	kfd_mem_limit.system_mem_used += system_mem_needed;
>   	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>   
> @@ -199,6 +200,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		kfd_mem_limit.ttm_mem_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		adev->kfd.vram_used -= size;
> +		adev->kfd.vram_used_aligned -= ALIGN(size, VRAM_AVAILABLITY_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		kfd_mem_limit.system_mem_used -= size;
>   	} else if (!(alloc_flag &
> @@ -1644,7 +1646,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>   	size_t available;
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>   	available = adev->gmc.real_vram_size
> -		- adev->kfd.vram_used
> +		- adev->kfd.vram_used_aligned
>   		- atomic64_read(&adev->vram_pin_size)
>   		- reserved_for_pt;
>   	spin_unlock(&kfd_mem_limit.mem_limit_lock);
