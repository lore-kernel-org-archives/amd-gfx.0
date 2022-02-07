Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40044C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 23:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87AEF10E393;
	Mon,  7 Feb 2022 23:24:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F95710E1A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 23:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjZEKVIpWWCzzs20ULOuzJqDEGNXsNKPiJhPHW2islH1pRPzv2RsBt/SmLgyFkiXIeYX96XL0padXBBNmdDQ2KyPnhX9sEO080qAt4f1Y8vYJWCbV5stEYjo7ecFmGzP71ES2hmeOCfDL76iMLffD272JOGxeuri9gXZh1Aoq+g24KW3B1Vp/OmMepp5n4q8GWMbLlepn2K0btbhLtNDvdYUsXtSVqBX765fccdVKzDA1dZzlpKa4r4CQsEMECet5ML6NBPqStlQZhXivVqALk0ZrHzViyQHElp0SllDVekFvw3GfnRZR6pLQ1BCwhudA9jbUv6+SUB7q2s3jeBbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFqyX/83sryafFo4jZ0KeexxQ48WERZs2XhU4U5cfdo=;
 b=EX1urqAeFT7vNXq4D/6qUJtDbo6cFFZkG8NOqglb3PrppI1HEfIQH6x9T+p0XJq0pPjYwqrsBIqS0CntQ2ghlst6xQoveb2VVSCMD+/vEJjY7ZUw8X9VaoBSw/KnKws91c7fXYd41ZWBN2m9F57zLhEaUwNOfjVi6wpMNFubCIvZZW9GHcPzAGf1rYmcp5Veb/5ceIP2HWqTQNW4XTEKjWU9lHheSm24T6gVfV/nZExFoS8e+Efffxsb5y0uJNV1hi+CY2cwjXXH23Ks0hnu4t90qSRIw79C33huFn/YLcgSEmLcSlCKgFMDQ6Stx62O2W/L3Ks/TNybpvTbDVPBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFqyX/83sryafFo4jZ0KeexxQ48WERZs2XhU4U5cfdo=;
 b=XDrb9NbwMpr43EwpnPhfKpthynbTkTxcp8pdm9uVxJdVdiJgokE+13rwaPCcm1J40iBsLxGUff/8FCL2ilVYfRCU/Wniqe+oYap5ftuOQf3mSaUAFus2gxvIUHmEex8d9aFYYXGevR5Qjd4OL2ihGekzOI1xEIwwywq2ohlfg8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW2PR12MB2508.namprd12.prod.outlook.com (2603:10b6:907:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 23:24:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 23:24:11 +0000
Message-ID: <8f7f2fc2-0512-2af3-b629-c18df962e195@amd.com>
Date: Mon, 7 Feb 2022 18:24:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 3/3] drm/amdkfd: Consolidate MQD manager functions
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220207195351.11640-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220207195351.11640-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ba33bc5-4d45-42f1-4b06-08d9ea90f254
X-MS-TrafficTypeDiagnostic: MW2PR12MB2508:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB250830E61B2B099686D69B42922C9@MW2PR12MB2508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqB5nWFgLsOF7wA7p6gUQXftYufznz8DHK6XdKbzqhFlAZiyc93Xluf+UAMqxO1spQxDO2INPCSUrvJ6MHvEC0rl5XvxckL1UYugtg6mTJD20XgzL4bzhp1SfvCXuR7jtNrimoaQXu0WXBi8HNxU6TB8q7aMATAoqwG0HAHuwIc8G8Z43YxGYCiyKMmTAN2yoZeAi21R2lyAawFxqbEzPKNO/TDvu6zKuSzsU+3MCPQlhbW804VBqh8KFADb4CctE+h6jLayvLHzufrK+aCMFvYTxWgEjNfWIGIxMVau0FtXlJ9OmhIFIDSAbWQr7JCeywNM2n2Z0Pwrk5tt+UkFnP/ZK7tvjrTZEki2hXCf4FUn0yFBR2HehcCYf3lBTU1ODItBW9f+c+o3lHYfDAcrnWCILYVieJhcq4J5Bl/eGKui6OPhm1J7i05FEzQUfkV59F2TDkyzgecNTg+sSeqjvuVt+XfoMf2S+Cri0C1xuMNIb01Eg5miJaRpxnQyBq4k6TjpRda/YRitw6S7YO7ATaFQ7DDn3Ew1N3phIYDVkuMbnyUZBE5y/egP0eRxTzJ5w2Cx2lVCTpwWdV9tEgqhfa0y3j2H2UvQFEiwKYZqLC3zLhLeQUrLak+wyL7NQKVKLc3K9tQbOxU09PSgMRS8MMxShnkM/gw/kGlBBqumu92h/r0wFcrK0w9aUJFQsM3g3BXYIbtYTPmkegl9VD/B6+hX8p+DhdMQTHs1M8/scIu2IS2iRQmd5NESikr8n8Ur
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(44832011)(86362001)(2906002)(83380400001)(316002)(30864003)(31696002)(5660300002)(186003)(2616005)(508600001)(26005)(31686004)(6512007)(6506007)(36756003)(6486002)(8676002)(8936002)(66556008)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUI4aC9OcXBPRCtYZGxDRy9uL3BEb1V0MVllYlQwaFViSmdXZVBwSmpsemJ6?=
 =?utf-8?B?amh5ZXNoeVkrUXlIV0tHMkQwZldHWXRvbWdOWFpZa1dNMElyMlpCUDVvbG5P?=
 =?utf-8?B?TTNhdk04V3B0STBncHdtYnZ1L0ljSzYyRFEwaHJOSGZmSmk3QVhwdmpuMklE?=
 =?utf-8?B?T04reHQ2a2QyYVZWeVdGRGhmTWJBRjNERy9kVXBpT1pyVjNYTDFoSzJCOHVo?=
 =?utf-8?B?ZVFTdHlNSFh6VlFxNXpOTDM0Sklic1ZVSWpQL2VzSU90VEdHMFN1NlR3RUV1?=
 =?utf-8?B?RGlrUmI4VlFNZEhZQUEzaGcxdUlRZWdTS2pJd0Y2MXY5NVlOazBvKzVkQm5j?=
 =?utf-8?B?ZGNoSzVUZW93WFRpekQ5ZUtveWppQUt5ZUcxU0E3bEVHcitRd2NEL3hidEk3?=
 =?utf-8?B?Y3NiUjV5QTFlLzRmSEVMdURocXJDUzg0dWF5aGV5WFJuSlBjVGVkbDZUU1Vt?=
 =?utf-8?B?Q21RMmJhRTA3bFlwSGNvR2czSVA0OFZWVnlPT0hXV0MvNVQ1QmdFOFlJTjBm?=
 =?utf-8?B?Tzl1aUZ4alEvQ09RY2ZIZERmeVVLd3E1SnJyYXBUcjhoQUhJWnpuRU5iNWxS?=
 =?utf-8?B?dlU4RVNDdGlBRlRyaUx0OXFKMnhxWXgrSW1FN2I2Q1NvN0tKTjVDek11dEha?=
 =?utf-8?B?eXdCV0tINm9td1B6ZmpWMm9SYlRTaXJ2Ylp0YjBrUlRZSkd2dFVwa2xSMFdL?=
 =?utf-8?B?Q1REV0ErTlJQc0lrV1pTVmZpK2Nnaytoa24ydWd0REZMOWJCNDB6aWYwanBm?=
 =?utf-8?B?M1NJRjRLZEVsZytETnV6TG9Sa0Rpa3hNNHEyd1c2TWRhdVIzbFRiNmhqZE1r?=
 =?utf-8?B?OTNGN0FOaEQ2ZXRSNXVqWGloMDBMWmhkZWVCa09qNkg2WFRrSUcxelZKS1dE?=
 =?utf-8?B?STRCdWllSHdIa29MTnM5WUF5bHFFSjA5R1V3OG9aZ0tudWtZdkVSd29VOGhy?=
 =?utf-8?B?N3pJemdTN3QxQTVDQ2JmaHdPaXlVTExXTjAwbTVqNXkxOWorNmEwMVBsLzY2?=
 =?utf-8?B?SkJKSVFjZ0YramsxTTI4T0dNd2xkcVM4SWErOUpkRDFiR1MwVVNXQkZHOWVQ?=
 =?utf-8?B?dVhOcjlhcFd0Qko4NFczenM4TndZcmNpckFmMXY4TTVWQW84eDZjS2s1OUt2?=
 =?utf-8?B?VG9zOW9EL1pRVXY4R0V1WWIzZkJINkJ0cUY3UGVwS2d0QWlpNEVLTTA4U2Ji?=
 =?utf-8?B?aHhsbXNFVVFSRzl2MzB4SHlyQzhYdXNuMFl6SU1qcHRManNzUXpmalE3eTVt?=
 =?utf-8?B?ajBDTTUyQ0RQK3p0K3RGNnJteWg0RWJmYjNsbzJCSmpmMVQzZTE0ZUhSb3Vy?=
 =?utf-8?B?S2Y5bWRjUGhabGpaYjVCdURqaGhCaE55Y1J4UVNqclhTaVN5TGtRMWFMaHVZ?=
 =?utf-8?B?T1JsYjZ3aVFoczcvUW5lZ2YwazM0VEJnb1NsdTNnUTk5TVJNRHZ0Y0VneTQ4?=
 =?utf-8?B?VUx2bW9qWVUzSHlQM3gvUjNLSVFYQjl6U0FXZWQvczNZRVJxQ1lBNjVKTE9J?=
 =?utf-8?B?dDJYQkQvNGF3QlFnVnpDWTFPbHJ6R2d6SXV2SXJ3V21pRVFlQU9tay9lZVFC?=
 =?utf-8?B?T0dpTDBKR1Q5cEJuYnJoVUM1VmxDNndBUi9hTks1L0pNYjhjU09vd21qdmww?=
 =?utf-8?B?RHd2WUtPYWt3THNMWVlTZlJEWUFzMWhXM1g4NXZkZ1JyRFA2WVFRNkVSSEo4?=
 =?utf-8?B?MkNIdGxOM0hrd0VQQWsvYlhVUDQ4NE01UlVidG1vanlGU2xBOVNDa29RRVZr?=
 =?utf-8?B?bTZETzhtNjA0bEpGaWFTTmpUTDJJMEhBZEwrM21mSVcrMDJKVktHNUpaUEJP?=
 =?utf-8?B?NlhicDBNeFYyclBUMWFFLzNrR0FvNm8zR2lYQ3ZnazNwQ0YzM0NSMVNFN2ov?=
 =?utf-8?B?SFFGYnF6MzMwbjZhTk1FUU5wSjFGZEd6QWMzN09MMnRENGZsQVdFWUhPRkFI?=
 =?utf-8?B?eWFkSnNCYm03Y2cyQVBpbThXOXdtbEhpR0JteG1QQ1JuSXhoaUJWTEFDTWU0?=
 =?utf-8?B?ak9TeUpmU3pGNmxPV0dPZ1l2WVlYRUNzM2VGVyt4Mk9VQzUrK2tIYjF5bU4x?=
 =?utf-8?B?SWdLdDZiMWh1TWQ0Mkd5aVJseTBEMWwzUXViV2E4Ly8yYWZobkVoQk9QWVRR?=
 =?utf-8?B?TGZha0RkV2dVejRHQnZoZGc5VTQrWXU5THBzWUNiWDJpUnZwTGpRT09uSSsy?=
 =?utf-8?Q?fjUarX5AXeRNhMc+d7i/u10=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba33bc5-4d45-42f1-4b06-08d9ea90f254
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 23:24:11.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWAwxKaAzyHt4e/K1dtFlF8v71htxyqfavedE0w6W/7XIFhZaUgXTC5GAm0vPx1SMwnq8jumSp88o8N86gk6pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2508
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


Am 2022-02-07 um 14:53 schrieb Mukul Joshi:
> A few MQD manager functions are duplicated for all versions of
> MQD manager. Remove this duplication by moving the common
> functions into kfd_mqd_manager.c file.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> v1->v2:
> - Add "kfd_" prefix to functions moved to kfd_mqd_manager.c.
> - Also, suffix "_cp" to function names shared by CP, HIQ and DIQ.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 63 +++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  | 27 ++++++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 76 +++------------
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 85 +++--------------
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 92 +++----------------
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 75 +++------------
>   6 files changed, 136 insertions(+), 282 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index e2825ad4d699..dd99f23e24f1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -173,3 +173,66 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   		}
>   	}
>   }
> +
> +int kfd_hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> +		     uint32_t pipe_id, uint32_t queue_id,
> +		     struct queue_properties *p, struct mm_struct *mms)
> +{
> +	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
> +					      queue_id, p->doorbell_off);
> +}
> +
> +int kfd_destroy_mqd_cp(struct mqd_manager *mm, void *mqd,
> +		enum kfd_preempt_type type, unsigned int timeout,
> +		uint32_t pipe_id,uint32_t queue_id)
> +{
> +	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type, timeout,
> +						pipe_id, queue_id);
> +}
> +
> +void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
> +	      struct kfd_mem_obj *mqd_mem_obj)
> +{
> +	if (mqd_mem_obj->gtt_mem) {
> +		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, mqd_mem_obj->gtt_mem);
> +		kfree(mqd_mem_obj);
> +	} else {
> +		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> +	}
> +}
> +
> +bool kfd_is_occupied_cp(struct mqd_manager *mm, void *mqd,
> +		 uint64_t queue_address, uint32_t pipe_id,
> +		 uint32_t queue_id)
> +{
> +	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev, queue_address,
> +						pipe_id, queue_id);
> +}
> +
> +int kfd_load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> +		  uint32_t pipe_id, uint32_t queue_id,
> +		  struct queue_properties *p, struct mm_struct *mms)
> +{
> +	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> +						(uint32_t __user *)p->write_ptr,
> +						mms);
> +}
> +
> +/*
> + * preempt type here is ignored because there is only one way
> + * to preempt sdma queue
> + */
> +int kfd_destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> +		     enum kfd_preempt_type type,
> +		     unsigned int timeout, uint32_t pipe_id,
> +		     uint32_t queue_id)
> +{
> +	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> +}
> +
> +bool kfd_is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> +		      uint64_t queue_address, uint32_t pipe_id,
> +		      uint32_t queue_id)
> +{
> +	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 23486a23df84..21851110f9eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -136,4 +136,31 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   		const uint32_t *cu_mask, uint32_t cu_mask_count,
>   		uint32_t *se_mask);
>   
> +int kfd_hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> +		uint32_t pipe_id, uint32_t queue_id,
> +		struct queue_properties *p, struct mm_struct *mms);
> +
> +int kfd_destroy_mqd_cp(struct mqd_manager *mm, void *mqd,
> +		enum kfd_preempt_type type, unsigned int timeout,
> +		uint32_t pipe_id,uint32_t queue_id);
> +
> +void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
> +		struct kfd_mem_obj *mqd_mem_obj);
> +
> +bool kfd_is_occupied_cp(struct mqd_manager *mm, void *mqd,
> +		 uint64_t queue_address, uint32_t pipe_id,
> +		 uint32_t queue_id);
> +
> +int kfd_load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> +		uint32_t pipe_id, uint32_t queue_id,
> +		struct queue_properties *p, struct mm_struct *mms);
> +
> +int kfd_destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> +		enum kfd_preempt_type type,unsigned int timeout,
> +		uint32_t pipe_id, uint32_t queue_id);
> +
> +bool kfd_is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> +		uint64_t queue_address, uint32_t pipe_id,
> +		uint32_t queue_id);
> +
>   #endif /* KFD_MQD_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> index 96e3303fa27c..06aae5df6a37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> @@ -156,13 +156,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	mm->update_mqd(mm, m, q, NULL);
>   }
>   
> -static void free_mqd(struct mqd_manager *mm, void *mqd,
> -			struct kfd_mem_obj *mqd_mem_obj)
> -{
> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> -}
> -
> -
>   static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
>   		    uint32_t queue_id, struct queue_properties *p,
>   		    struct mm_struct *mms)
> @@ -176,15 +169,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
>   					  wptr_shift, wptr_mask, mms);
>   }
>   
> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -			 uint32_t pipe_id, uint32_t queue_id,
> -			 struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> -					       (uint32_t __user *)p->write_ptr,
> -					       mms);
> -}
> -
>   static void __update_mqd(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q, struct mqd_update_info *minfo,
>   			unsigned int atc_bit)
> @@ -271,15 +255,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> -			enum kfd_preempt_type type,
> -			unsigned int timeout, uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type, timeout,
> -					pipe_id, queue_id);
> -}
> -
>   static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
>   {
>   	struct cik_mqd *m;
> @@ -351,35 +326,6 @@ static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	qp->is_active = 0;
>   }
>   
> -/*
> - * preempt type here is ignored because there is only one way
> - * to preempt sdma queue
> - */
> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -				enum kfd_preempt_type type,
> -				unsigned int timeout, uint32_t pipe_id,
> -				uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> -}
> -
> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -
> -	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev, queue_address,
> -					pipe_id, queue_id);
> -
> -}
> -
> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> -}
> -
>   /*
>    * HIQ MQD Implementation, concrete implementation for HIQ MQD implementation.
>    * The HIQ queue in Kaveri is using the same MQD structure as all the user mode
> @@ -460,11 +406,11 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   	case KFD_MQD_TYPE_CP:
>   		mqd->allocate_mqd = allocate_mqd;
>   		mqd->init_mqd = init_mqd;
> -		mqd->free_mqd = free_mqd;
> +		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->checkpoint_mqd = checkpoint_mqd;
>   		mqd->restore_mqd = restore_mqd;
>   		mqd->mqd_size = sizeof(struct cik_mqd);
> @@ -478,8 +424,8 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   		mqd->free_mqd = free_mqd_hiq_sdma;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd_hiq;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct cik_mqd);
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
> @@ -489,11 +435,11 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   	case KFD_MQD_TYPE_DIQ:
>   		mqd->allocate_mqd = allocate_mqd;
>   		mqd->init_mqd = init_mqd_hiq;
> -		mqd->free_mqd = free_mqd;
> +		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd_hiq;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct cik_mqd);
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
> @@ -503,10 +449,10 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   		mqd->allocate_mqd = allocate_sdma_mqd;
>   		mqd->init_mqd = init_mqd_sdma;
>   		mqd->free_mqd = free_mqd_hiq_sdma;
> -		mqd->load_mqd = load_mqd_sdma;
> +		mqd->load_mqd = kfd_load_mqd_sdma;
>   		mqd->update_mqd = update_mqd_sdma;
> -		mqd->destroy_mqd = destroy_mqd_sdma;
> -		mqd->is_occupied = is_occupied_sdma;
> +		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
> +		mqd->is_occupied = kfd_is_occupied_sdma;
>   		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
>   		mqd->restore_mqd = restore_mqd_sdma;
>   		mqd->mqd_size = sizeof(struct cik_sdma_rlc_registers);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 0cc8679c24fa..88228009ded4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -154,14 +154,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
>   	return r;
>   }
>   
> -static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> -			    uint32_t pipe_id, uint32_t queue_id,
> -			    struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
> -					      queue_id, p->doorbell_off);
> -}
> -
>   static void update_mqd(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q,
>   			struct mqd_update_info *minfo)
> @@ -233,31 +225,6 @@ static uint32_t read_doorbell_id(void *mqd)
>   	return m->queue_doorbell_id0;
>   }
>   
> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> -		       enum kfd_preempt_type type,
> -		       unsigned int timeout, uint32_t pipe_id,
> -		       uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_destroy
> -		(mm->dev->adev, mqd, type, timeout,
> -		 pipe_id, queue_id);
> -}
> -
> -static void free_mqd(struct mqd_manager *mm, void *mqd,
> -			struct kfd_mem_obj *mqd_mem_obj)
> -{
> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> -}
> -
> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_is_occupied(
> -		mm->dev->adev, queue_address,
> -		pipe_id, queue_id);
> -}
> -
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   			  void __user *ctl_stack,
>   			  u32 *ctl_stack_used_size,
> @@ -352,15 +319,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	mm->update_mqd(mm, m, q, NULL);
>   }
>   
> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		uint32_t pipe_id, uint32_t queue_id,
> -		struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> -					       (uint32_t __user *)p->write_ptr,
> -					       mms);
> -}
> -
>   #define SDMA_RLC_DUMMY_DEFAULT 0xf
>   
>   static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
> @@ -390,25 +348,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -/*
> - *  * preempt type here is ignored because there is only one way
> - *  * to preempt sdma queue
> - */
> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		enum kfd_preempt_type type,
> -		unsigned int timeout, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> -}
> -
> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> -		uint64_t queue_address, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> -}
> -
>   static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>   				void *mqd,
>   				void *mqd_dst,
> @@ -483,11 +422,11 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
>   		pr_debug("%s@%i\n", __func__, __LINE__);
>   		mqd->allocate_mqd = allocate_mqd;
>   		mqd->init_mqd = init_mqd;
> -		mqd->free_mqd = free_mqd;
> +		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v10_compute_mqd);
>   		mqd->get_wave_state = get_wave_state;
>   		mqd->checkpoint_mqd = checkpoint_mqd;
> @@ -502,10 +441,10 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
>   		mqd->allocate_mqd = allocate_hiq_mqd;
>   		mqd->init_mqd = init_mqd_hiq;
>   		mqd->free_mqd = free_mqd_hiq_sdma;
> -		mqd->load_mqd = hiq_load_mqd_kiq;
> +		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v10_compute_mqd);
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
> @@ -516,11 +455,11 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
>   	case KFD_MQD_TYPE_DIQ:
>   		mqd->allocate_mqd = allocate_mqd;
>   		mqd->init_mqd = init_mqd_hiq;
> -		mqd->free_mqd = free_mqd;
> +		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v10_compute_mqd);
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
> @@ -531,10 +470,10 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
>   		mqd->allocate_mqd = allocate_sdma_mqd;
>   		mqd->init_mqd = init_mqd_sdma;
>   		mqd->free_mqd = free_mqd_hiq_sdma;
> -		mqd->load_mqd = load_mqd_sdma;
> +		mqd->load_mqd = kfd_load_mqd_sdma;
>   		mqd->update_mqd = update_mqd_sdma;
> -		mqd->destroy_mqd = destroy_mqd_sdma;
> -		mqd->is_occupied = is_occupied_sdma;
> +		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
> +		mqd->is_occupied = kfd_is_occupied_sdma;
>   		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
>   		mqd->restore_mqd = restore_mqd_sdma;
>   		mqd->mqd_size = sizeof(struct v10_sdma_mqd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 87da4329dbf2..dff58ee53557 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -204,14 +204,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
>   					  wptr_shift, 0, mms);
>   }
>   
> -static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> -			    uint32_t pipe_id, uint32_t queue_id,
> -			    struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
> -					      queue_id, p->doorbell_off);
> -}
> -
>   static void update_mqd(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q,
>   			struct mqd_update_info *minfo)
> @@ -285,38 +277,6 @@ static uint32_t read_doorbell_id(void *mqd)
>   	return m->queue_doorbell_id0;
>   }
>   
> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> -			enum kfd_preempt_type type,
> -			unsigned int timeout, uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_destroy
> -		(mm->dev->adev, mqd, type, timeout,
> -		pipe_id, queue_id);
> -}
> -
> -static void free_mqd(struct mqd_manager *mm, void *mqd,
> -			struct kfd_mem_obj *mqd_mem_obj)
> -{
> -	struct kfd_dev *kfd = mm->dev;
> -
> -	if (mqd_mem_obj->gtt_mem) {
> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, mqd_mem_obj->gtt_mem);
> -		kfree(mqd_mem_obj);
> -	} else {
> -		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> -	}
> -}
> -
> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_is_occupied(
> -		mm->dev->adev, queue_address,
> -		pipe_id, queue_id);
> -}
> -
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   			  void __user *ctl_stack,
>   			  u32 *ctl_stack_used_size,
> @@ -422,15 +382,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	mm->update_mqd(mm, m, q, NULL);
>   }
>   
> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		uint32_t pipe_id, uint32_t queue_id,
> -		struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> -					       (uint32_t __user *)p->write_ptr,
> -					       mms);
> -}
> -
>   #define SDMA_RLC_DUMMY_DEFAULT 0xf
>   
>   static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
> @@ -460,25 +411,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -/*
> - *  * preempt type here is ignored because there is only one way
> - *  * to preempt sdma queue
> - */
> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		enum kfd_preempt_type type,
> -		unsigned int timeout, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> -}
> -
> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> -		uint64_t queue_address, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> -}
> -
>   static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>   				void *mqd,
>   				void *mqd_dst,
> @@ -551,11 +483,11 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   	case KFD_MQD_TYPE_CP:
>   		mqd->allocate_mqd = allocate_mqd;
>   		mqd->init_mqd = init_mqd;
> -		mqd->free_mqd = free_mqd;
> +		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->get_wave_state = get_wave_state;
>   		mqd->get_checkpoint_info = get_checkpoint_info;
>   		mqd->checkpoint_mqd = checkpoint_mqd;
> @@ -569,10 +501,10 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   		mqd->allocate_mqd = allocate_hiq_mqd;
>   		mqd->init_mqd = init_mqd_hiq;
>   		mqd->free_mqd = free_mqd_hiq_sdma;
> -		mqd->load_mqd = hiq_load_mqd_kiq;
> +		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v9_mqd);
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
> @@ -582,11 +514,11 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   	case KFD_MQD_TYPE_DIQ:
>   		mqd->allocate_mqd = allocate_mqd;
>   		mqd->init_mqd = init_mqd_hiq;
> -		mqd->free_mqd = free_mqd;
> +		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct v9_mqd);
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
> @@ -596,10 +528,10 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   		mqd->allocate_mqd = allocate_sdma_mqd;
>   		mqd->init_mqd = init_mqd_sdma;
>   		mqd->free_mqd = free_mqd_hiq_sdma;
> -		mqd->load_mqd = load_mqd_sdma;
> +		mqd->load_mqd = kfd_load_mqd_sdma;
>   		mqd->update_mqd = update_mqd_sdma;
> -		mqd->destroy_mqd = destroy_mqd_sdma;
> -		mqd->is_occupied = is_occupied_sdma;
> +		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
> +		mqd->is_occupied = kfd_is_occupied_sdma;
>   		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
>   		mqd->restore_mqd = restore_mqd_sdma;
>   		mqd->mqd_size = sizeof(struct v9_sdma_mqd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 137b208135a0..86fc5decacf0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -259,31 +259,6 @@ static void update_mqd_tonga(struct mqd_manager *mm, void *mqd,
>   	__update_mqd(mm, mqd, q, minfo, MTYPE_UC, 0);
>   }
>   
> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> -			enum kfd_preempt_type type,
> -			unsigned int timeout, uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_destroy
> -		(mm->dev->adev, mqd, type, timeout,
> -		pipe_id, queue_id);
> -}
> -
> -static void free_mqd(struct mqd_manager *mm, void *mqd,
> -			struct kfd_mem_obj *mqd_mem_obj)
> -{
> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> -}
> -
> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_is_occupied(
> -		mm->dev->adev, queue_address,
> -		pipe_id, queue_id);
> -}
> -
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   			  void __user *ctl_stack,
>   			  u32 *ctl_stack_used_size,
> @@ -385,15 +360,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	mm->update_mqd(mm, m, q, NULL);
>   }
>   
> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		uint32_t pipe_id, uint32_t queue_id,
> -		struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> -					       (uint32_t __user *)p->write_ptr,
> -					       mms);
> -}
> -
>   static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q,
>   			struct mqd_update_info *minfo)
> @@ -422,25 +388,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -/*
> - *  * preempt type here is ignored because there is only one way
> - *  * to preempt sdma queue
> - */
> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		enum kfd_preempt_type type,
> -		unsigned int timeout, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> -}
> -
> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> -		uint64_t queue_address, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> -}
> -
>   static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>   				void *mqd,
>   				void *mqd_dst,
> @@ -514,11 +461,11 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
>   	case KFD_MQD_TYPE_CP:
>   		mqd->allocate_mqd = allocate_mqd;
>   		mqd->init_mqd = init_mqd;
> -		mqd->free_mqd = free_mqd;
> +		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->get_wave_state = get_wave_state;
>   		mqd->get_checkpoint_info = get_checkpoint_info;
>   		mqd->checkpoint_mqd = checkpoint_mqd;
> @@ -534,8 +481,8 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
>   		mqd->free_mqd = free_mqd_hiq_sdma;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd_hiq;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct vi_mqd);
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
> @@ -545,11 +492,11 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
>   	case KFD_MQD_TYPE_DIQ:
>   		mqd->allocate_mqd = allocate_mqd;
>   		mqd->init_mqd = init_mqd_hiq;
> -		mqd->free_mqd = free_mqd;
> +		mqd->free_mqd = kfd_free_mqd_cp;
>   		mqd->load_mqd = load_mqd;
>   		mqd->update_mqd = update_mqd_hiq;
> -		mqd->destroy_mqd = destroy_mqd;
> -		mqd->is_occupied = is_occupied;
> +		mqd->destroy_mqd = kfd_destroy_mqd_cp;
> +		mqd->is_occupied = kfd_is_occupied_cp;
>   		mqd->mqd_size = sizeof(struct vi_mqd);
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
> @@ -559,10 +506,10 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
>   		mqd->allocate_mqd = allocate_sdma_mqd;
>   		mqd->init_mqd = init_mqd_sdma;
>   		mqd->free_mqd = free_mqd_hiq_sdma;
> -		mqd->load_mqd = load_mqd_sdma;
> +		mqd->load_mqd = kfd_load_mqd_sdma;
>   		mqd->update_mqd = update_mqd_sdma;
> -		mqd->destroy_mqd = destroy_mqd_sdma;
> -		mqd->is_occupied = is_occupied_sdma;
> +		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
> +		mqd->is_occupied = kfd_is_occupied_sdma;
>   		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
>   		mqd->restore_mqd = restore_mqd_sdma;
>   		mqd->mqd_size = sizeof(struct vi_sdma_mqd);
