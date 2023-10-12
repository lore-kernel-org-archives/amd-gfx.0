Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05520CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 07:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02C010E42B;
	Thu, 12 Oct 2023 07:35:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46EE10E429
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 07:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH0lAJku/XNzlIvl69B5hzdNSN0F+86KRGUGY5iJVttXomHO8TWfCRujew1T8VP4D+ojV3AF4HcayWaEpYqLtnqKfCjPLarn+AVRZNctMCXX4S6NkLzLHarixffBgKceHjCd7tK8ANcA8UqHL4Lx7rG3SfzAlunPKk5T2lQYYNrd431nROo7mnWX57MYhO13GZ5d1fwl3W1n66hSL5Owb4PLZ4yngD47pHveS5XTUZkljj+6wIZZrvHEFqn24ogzzbjlSuoeXU9juc8GduWeVO9H57t7ya9t80z98kK2f8c6aXvZwF5bNUsu6DY5Blg1wXWp0pQXY6qlJJWGMMiZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8heyl4BJPxHlWkMwbcdmXrocPi2LBvJwxDRxcRJAfM=;
 b=EnnGRJvEn0VFT6IlCsPG2n5NtR2S64aZ5jBSz5QyXruXLvCd4CB/5WcRjnE5DdrD+Gn8W0yqqBLe6zn2KsJD7zC+nK2GaTLzedAht6BfJAuh7qp8R93iadIll7zkfRbyn4yx25yU4F9XDuXi8CfL1vmYl51FQsQl0ubc9uITxQ0RNRWmyEY3WD0aDtGld0eig6V7+UTu1RscC6VUSEx3Irnyjq5mqyotYsdRjS4Ok2q1xLOZzkqgawmKaT6SfR8GYRapxhAqwACRxZbGlcxOSucqistFvLLyWfjpmiervneB0cZIFCoo4IZtYJyv7kDowuxlRvokV8kkngwMEAj+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8heyl4BJPxHlWkMwbcdmXrocPi2LBvJwxDRxcRJAfM=;
 b=3gXjOCPeDKKlt7Y0FYF5dTZF3fJsrM97VqkuKGQeT+beG9ADnuYdVitb3Kq38B1MdvRYSb1S6TWOADXFTwxRQ9gvcdzdXK0u0uLc0b1el9vwq7h2rmb6fKR1oVcgOA7MOFo/X0/PbDAPQPD0MSoZBCqkn2Mj7fivkJGkXWiFC0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 07:35:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 07:35:22 +0000
Message-ID: <908fbfed-7d21-4588-9c22-d976d985af93@amd.com>
Date: Thu, 12 Oct 2023 09:35:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Find bo_va before create it when map bo into compute VM
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231011233630.32205-1-xiaogang.chen@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231011233630.32205-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: a004b2c7-1f0e-4d4b-6546-08dbcaf5caa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAIhpbCpPvK+66XLZul5qvJAkx1s1U6pNrz6CK4B+pjEzMvx4SifrZYOngaoS//JCUwS2otAA8vt+TSMvhaB0Y8w0/kjq7Zuvix4nqYnlqlpK35pTy1Mh/2YtOgQTUsPpuvUERxYufbYWWFwacaY9mkBiAKGaQJj//OsK1EAAnzyXqStjpaxTNFqH1ltKkPJygJYggS+TG53wDlw3SWNE3LiD4Hy+fsvBH8hC+h5EKW4tjZDBE/pxA0r2i71LqW6gNSjq6PsHOZEtJ2hSUSTEgceTfpNEtGXYo/wQv653tB/R2iMuJ0KrRR2ZT8Ef2GdcaORvtksmkp5OZWa2aVh+/pQ3sD5RxEO4nDdXvl36cLtErGxH3HaZdyq1+7KleFZScz4xkkFL0DQErA2QWZ7ObyjQp3lQissORP9FbanHV5ZRBzpd9TuYitxwRCT8Q+MrMB/7C14NH+3zq4djQoyTZpO2hnoVKsv2VvoFTHghUefieF7/8+v21kbSPgytVLPhkZf2Z9Sz11Sg1CmvUy4/ZMUeiANz6NYZSEIo5BgpJtSa/Tsntt6Ld1qHbX/w6/o5MjXnkEFaBeOlcCgfEBNvZnKoCsR9IJofQY6IlryoI4E33g4oSgWYoo2RqljAdgfZUHQUcSkHbDLKAMLWRNO4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(478600001)(66574015)(2616005)(66556008)(66476007)(316002)(83380400001)(26005)(54906003)(66946007)(8936002)(5660300002)(6486002)(41300700001)(4326008)(6666004)(6512007)(6506007)(8676002)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJvQ3NIek5KRzdXbzJUcTZDSDJweVhES0o5eHFYZHpHUUNVUkNnNnFsM0Iv?=
 =?utf-8?B?aFFFdU1XMFpUQzVnMUZtTTErWXdROGNJZFNRLzc1Nms3bGFSanAyc2M1NGFI?=
 =?utf-8?B?VU5oeWpLMktZWEg3MER3enU1Zm9FbkZ2RUpkcy95cmk0Rk5HMzhMQ2hiYUIz?=
 =?utf-8?B?NHd5UU91ejVvenJIWkY2aHVsYUdWQ1VoTEpkb0VZeVVuR3JINFBobXdEcGdQ?=
 =?utf-8?B?WGxPUUdoS0lVS29qNnJhWnBLZmNWZWlBU2xUVm93aGVlYzQ4aklsUVpqak9S?=
 =?utf-8?B?bFZUaFNBbjYyY3FVZTUyU0QzTnpDbXNBV1NBOUhWNWhISzlpNEFESzgrdFpW?=
 =?utf-8?B?c05KWFNUYThlUlN0VDhsTmpFOUUwQWQwamhRNUh6T2pLdEoyZ0pRdVBvQ21n?=
 =?utf-8?B?cE04UnByQU5ZNi93aFozWkNydCsvaWY3YW56VHJyYTJlZmVCWGVuZEw5R250?=
 =?utf-8?B?dGhHeEsxeE5tT3o2SkNONzI3S0Q1bXRNQnl1bk9TR3lqTjBHcVczYUxNekU5?=
 =?utf-8?B?bTJwODdJT0RQNHhGZTd5WmNNdjR1M0pQenR4MFBiOHFLUkpOcmpEQ3oyWTNV?=
 =?utf-8?B?NkpwU0hmWU8xdyt3WUhMWTNCTnE5a0dMbTNzMFowUUR1NlRtR2lLQVBnTklP?=
 =?utf-8?B?d2NtN3gzWFFuTUtzc00zUGFMMTEwV01EOEtnRG94RnE4cjhnU2RYdDJiNjBJ?=
 =?utf-8?B?ejJ3K2h1NTJneWgrUVd2ODNMZW9JRDRzcWZicENtRHNlVlVHc2ZUcVR0V3Jz?=
 =?utf-8?B?bW54cEEyL0k1NHBRNzI5SGdHSXE2NVZNTTVCdER2QVhtRk9TOWFDeVlTdXBB?=
 =?utf-8?B?cGhSNjRzYk5NMGNweithbHozOHpZMjZQVHIvZ1dKamdzVEltNittbDZhbUlN?=
 =?utf-8?B?aFcwc3FSanpPQUpZZVRYVFZ2Nm1UalA4T0x4VEgzZ29OWVcyKzFWWGxxaVlI?=
 =?utf-8?B?Z0ZiRnNOaTljdDhBbmFlVWZFcm8wQ2dET1FhWkNWb2drS3UrQmpQaFR6cFda?=
 =?utf-8?B?T2dueFRKbEV2RnVHR1oxNFFYREt6L2FYNElPNFQ0K3dUN2ZvaVU4UVhXVThY?=
 =?utf-8?B?SVBqK2Z5SGkybWg5VUY0ajY3TlJpZmFLZjg3UTZnRUNFYmJiRTBGL1JudVA1?=
 =?utf-8?B?MUo0SjJUTzZ4Y0psVDMySWEyL2FGeUJ2NC9MczI0aE9jYVhlNVlxdkk3bU16?=
 =?utf-8?B?QmhxUEF5UzBKMnBTZmhLMk1HNStvQWtqU0VLUmtGempvU0ZsQi9ZYlVKTXov?=
 =?utf-8?B?S2c2VEl1YzUycnNoYnVhY0xOZkFUR090L0lEclMxNHduU3VYa1UzYWFSbHFN?=
 =?utf-8?B?cTE1ZU1pN2lGSzdNRnlRaE10amNzaERuVEVGNVpQWHlXUllNQTQ2VjZzQW90?=
 =?utf-8?B?dEVHaXFiNnJMdDMxbm8vUEgyNGRSbS94eisvdFZFUy9uVkYwS1RrcUNDTVA0?=
 =?utf-8?B?NEUxNDVibGEvTHJNNzRzVmhBNUU4NVQ5T2RPNmhEMkdTTlM4RU1Jbys0WU5C?=
 =?utf-8?B?MnUweEFIQm13b05idSsyRExubTd5WmM3eXZqTVgrZXI2WWZrQnU4WE1pUksv?=
 =?utf-8?B?emlwSHM1Qk14WUFGZEN1Z20zQVFaSlVmZUVVYTFHdnZ2OWtreE85cGQ4NWVu?=
 =?utf-8?B?MDQvaG44Z04yZUg1d09mWHl0MGZpNEFzK21LVkJXa0tkZk9DV3lIdXhRa2J4?=
 =?utf-8?B?NXVERGgzNmlCNTBFQ29hSnlSVHFXeTVHRmFXc2hKQ3VFT3d0SFAwQVlGbldo?=
 =?utf-8?B?Qll1VWFINXFWVzU2YWc0eEszQVNhTFl1V2lNeDJvaUVVRFNaRzdlRDBhOWtl?=
 =?utf-8?B?bmlIUmovUlIwY1pvU29qK2hseENWL1FTYmVISS9oOVFkU1hPaXMxbXhtVDVT?=
 =?utf-8?B?UHNZWmJxeFlEdzlsdlc4TmRuN3BkYUJ0YXA5S1VMNk9TRW1uKzM2K3g3Szha?=
 =?utf-8?B?c2J4bXhjcDljYldGTW9tNkJBS3JUWllaMG80RExRNWZoYll4bCtJbWxPRG9l?=
 =?utf-8?B?OVo3NlppUUd4L1AweThWdzQrcUF4ek1wVlhTQkZnWC9zOE8rcmVJUEtXc1M2?=
 =?utf-8?B?cmFuWmpyMk9lT1RuYURycUZXazRpeFdiMEhZOXRhQkNqaGdTYXFlVjYxeWYv?=
 =?utf-8?Q?spjTn3OFdP/tDAKCgV9cV4yew?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a004b2c7-1f0e-4d4b-6546-08dbcaf5caa3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:35:21.9831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdCfxDKWG+8au9bVN7ZsBipZil6KEiiuvJDtj2tVvVTq4y+yPSRmRk7sebpI2E5+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The subject line somehow got messed up. There should be an drm/amdgpu: 
or drm/amdkfd: prefix.

Regards,
Christian.

Am 12.10.23 um 01:36 schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> This is needed to correctly handle BOs imported into compute VM from gfx.
> Both kfd and gfx should use same bo_va when map the Bos into same VM, otherwise
> we may trigger kernel general protection when iterate mappings from bo_va.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Reviewed-By: Xiaogang Chen <Xiaogang.Chen@amd.com>
> Tested-By: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a15e59abe70a..c1ec93cc50ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -832,6 +832,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	uint64_t va = mem->va;
>   	struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
>   	struct amdgpu_bo *bo[2] = {NULL, NULL};
> +	struct amdgpu_bo_va *bo_va;
>   	bool same_hive = false;
>   	int i, ret;
>   
> @@ -919,7 +920,13 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			pr_debug("Unable to reserve BO during memory attach");
>   			goto unwind;
>   		}
> -		attachment[i]->bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
> +		bo_va = amdgpu_vm_bo_find(vm, bo[i]);
> +		if (!bo_va)
> +			bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
> +		else
> +			++bo_va->ref_count;
> +		attachment[i]->bo_va = bo_va;
> +
>   		amdgpu_bo_unreserve(bo[i]);
>   		if (unlikely(!attachment[i]->bo_va)) {
>   			ret = -ENOMEM;
> @@ -943,7 +950,8 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			continue;
>   		if (attachment[i]->bo_va) {
>   			amdgpu_bo_reserve(bo[i], true);
> -			amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
> +			if (--attachment[i]->bo_va->ref_count == 0)
> +				amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
>   			amdgpu_bo_unreserve(bo[i]);
>   			list_del(&attachment[i]->list);
>   		}

