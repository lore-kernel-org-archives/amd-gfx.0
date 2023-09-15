Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A836CD37AC
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 21:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F3010E682;
	Fri, 15 Sep 2023 21:06:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5FA10E682
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 21:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrUnjAFuFGNfYXxmEkfeSph3VaSYv0jlCkWNS580J5+AGMjitaqRS60Imh9yrrlzCqJw47Ig2sgP69cAUc6VG2b7ZvwlxTIncA3aNdwdGSQs2hE1eoyB54EZv4Tjz4spNP4NhQIrewJRDWLrUN1T2pHhNKw/z5ONHm7CcZ3llIRSeU4U7UwzFXjBMNUq/5TXHvuadQMNk6rwtts3MjtWZx4fabASKGn4ty6rv15+3x/A4vMlJf8ZS0roUcJ3+pweseG2snBo1wgwcey7iH2pcEpRIjApfQ9WUO1v4eNek0UqaxbUSUZUnMV039oVeCPIPeBaf5RIiBxw7c4g1qpjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plVj8h4lFFBo2hcaRj9CNPDrvinH87F0QUoAr0gSQMc=;
 b=OWTeOU6anAwZwBTl097jFHCQRHjo2m5UHm7Z2t6NTNgxWNelGEzmv66mpl1Kqc60xlE0/uuSUZv6uz8ivP7H9vobfows062CNfwby7F/TF9TOdWJoINJRhi6p0XrEH8gbg7We+VFDbC6RHdaTQ6OEd043m5fxaPz3fcLVfMnUxCwYlw9TyBxcjORKmgnZVAwGNS7TYzGA0Jhcd2O37zAxG3zMC5lG9isJee4wyRFZrmbASTtWevUvU5tBtj2UVY2mufDgvFjOIEnGgEIKwMja+60WtdkMRmipCpNlpfS6m6DAwapylVTzhgDOm4Sn4EsD/ymjikmcN3E7rsXqntVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plVj8h4lFFBo2hcaRj9CNPDrvinH87F0QUoAr0gSQMc=;
 b=Al5k3j/0tjRA61ShyE+VZMupKU0jJ1zsQbcTVvVx8gijhJF6UiJLC1Zt9j0Szd/EpXrPLszs1WlDaHTlRD3wzIuvTKRQRmcBVIEfclDfCPjFzQcLc3uk5tn+uPEoHeCLd51uHMcpAU5iYe2RmzgPy0wbEOK7BZKmee4aLLJb/wI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Fri, 15 Sep 2023 21:06:11 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::5502:371d:cbba:aed]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::5502:371d:cbba:aed%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 21:06:11 +0000
Message-ID: <28e8c90b-0ca8-6c66-0ac5-18277aa0ddf3@amd.com>
Date: Fri, 15 Sep 2023 16:06:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/amdkfd: handle errors from svm validate and map
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230915132804.20813-1-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20230915132804.20813-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0212.namprd04.prod.outlook.com
 (2603:10b6:806:127::7) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: d39859e3-2093-4872-2d13-08dbb62f968e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ypxXmOHSoPQuWgpSTT46pnWX89gLzDqrXLRlVv2LBmcJi6PsoNICQAtOnPfRxtHG/U6fvVfaQsPcDwKtGb/vUPyY2dBdK7Pfp6V3DT3SbvO635HFT4pqQKE8MbJCX5MCXmBrpvsjbAzgPArsI+XLSBQ/+igzYctQaZ766WQGTt01CCF+27hOgbNeyJq6L6+L1qP+vaRWrYLqH2TkVJKLokoN/equD3sHmJ0ftRFbzMECuu0GVTK0e0q1+SSV817WTkIx49BKunjH0EKuRe77GcRpSbWAAU2L5rMx6HuUQaL6jIjon3MEIT+otpqOKWhqG4gG8FJj/tm8QvMjCY3XnomRK8Hhqqe/zarC/T+1KEhBPY7+Im1mtA1x+2aZdbSHcUrycewWxoVqHs9vvX+8PEmKu2kgLaKoQJKR9SGcYhIbQAdHvuB7PVizLe22MLIcgkvXtrpkXf6QU6Mlyre6byCiH1BzCrdbISrTTD39gjo7qEoYGCckMkOm5q5mTAkgDvJXZzR25y4zdxOdfL9nrzJfkQlW134uv1OSxZ14YjJEZPpNy60WGxFj5JlzX+NBBGk3ErDdUmiCqMbR3wxw9bHfh87Xtw1tIPNzdAwFb8M5oEXOtzGniD709VU6pe8qKATGQJJyDapY3T8SxoLBNZBjWVoPsZ+rWpLzzbL5iufO953uLhTjn3QehkqRmOH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199024)(186009)(1800799009)(8676002)(4326008)(316002)(41300700001)(66556008)(66946007)(66476007)(6666004)(6486002)(6506007)(53546011)(478600001)(2906002)(15650500001)(36756003)(8936002)(26005)(5660300002)(38100700002)(83380400001)(86362001)(31696002)(6512007)(2616005)(31686004)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVTNjdhcTM2bWxuOTdEZkR3YmFMMXJFcGhHMFBjZWJVUjZnV0ozeXFOWXlI?=
 =?utf-8?B?TmFydjQvZGxwWUlLeEJ5MmxiMGc3allZZ3dnSUpwWG9ZVmZ5MW9LZndFcElM?=
 =?utf-8?B?NFE4UWlOUzRnM09sVHhnejlLTDlMNXc0cytkMkRpcUIrdlFRNlMvNTBiUm81?=
 =?utf-8?B?YlRqMy8zeTlQbSthNUwyT09zZFN2elkrdElvWG1XV1NaTUJJRHJqdDFuY0g1?=
 =?utf-8?B?YTQybW5UTlpNSEhSY1NidTVIWXkvWTlLWFoyQy96bk1mQXdNMlZCV3YwYmZY?=
 =?utf-8?B?UVNRVzFick1qSEtaUENtSHFSWjVtenNqeWZpNU1ZK2RkU0czVHJ2RDZxZ2hk?=
 =?utf-8?B?YTlOL3h5RVJ0WWlpUW9uTDhlbzcycFE5SjdWVGtZMjVyUXFnVlBQWUNvMnNY?=
 =?utf-8?B?dVBKZmNta0V6cmV2UnpUVkwyblN5S1ZFZ0xZc1B0cFViOVkvcXRuU2c5M1dS?=
 =?utf-8?B?UmhMRXg4S2dQVURBWGwzQ1llamJ3Z3F4cXFyTHRyTU9oMGdMMkFqNXJ4d1FX?=
 =?utf-8?B?MFhVSDErNXJiT25LdlcwbmFMM1BXSlZXM3oweE9DN3F0MDFxQjVyWk5nZGJh?=
 =?utf-8?B?Rk5rdUwrd21DdzFnTEt6K2U1RzQ0YTJJdEJ6dUVqQUp6Z2lDMjIrK2lnN1Rh?=
 =?utf-8?B?OTlUQUZYWStjUlBjVlZ4RGJaY3pidU5PYkgvdjZJRE9qdlkxbFlnclE5N3c2?=
 =?utf-8?B?YS9tUGtDVjlVeU5SbW8zOUprcUxHRnlhVzlpL3NHZnp2V1hNREdVNUhQYVlQ?=
 =?utf-8?B?MkNVWE9rZmJ6UlhXYWpIWGlTWEFWL01zUVNaR1ZyWjJHSmcwNXFacmJLRHow?=
 =?utf-8?B?enRhUXRhM1p3QVBJck9jQUV2bkRRcE0rTXBQeHg0d0t3c0pyVGxvZHREazVx?=
 =?utf-8?B?RnV5OWV3RVJjZm1NU3BSbXlQZE1XSkhZRm9iREVBcVpqbFR5RWtwTWdqZm15?=
 =?utf-8?B?SStCZjlEZXZNN3U1QzVvS0dvYXZVUEszb1c5WU1NVUc0QUdzV0VQOWFRMFpR?=
 =?utf-8?B?eC9QZENOMXU4ZS85M2hvUWpLbThGbldzd2hVS2Z5a3FqYkhoK2ZBUHBsSHhh?=
 =?utf-8?B?YmtDbzgvZ0hjYUp1T2dTK0tkeXdYdDRJTFBiK1o0TmRrMExWcUxLUmVzQkNa?=
 =?utf-8?B?QWJDRDlxRU53SXhRU2tOeWNOazZFK0pXRUZSRHB4NzFVOFUydThSZlpvZnBk?=
 =?utf-8?B?R2JNeXhDOFR6SnNicDVOa2xRbTc1SEk0ZFVhVy94dXpib081eDZXYTdlQ0ov?=
 =?utf-8?B?bUlXcUw2MEE4bVY2Tyt2M2RDZXE3UlJhVzVTWnpQTnVIYVZJdFJGcG1OTTIx?=
 =?utf-8?B?ekV1K3luWEEwVG00SmFVS0VHUG9LSkJkWFBRQUdvSUlkNklQQjNBQmxoR0NV?=
 =?utf-8?B?aWFWa090Qm5VNXRQdUxKQzRoS296SVdiNFoxTVRxZi9hZnNmNFNXS2c2azR3?=
 =?utf-8?B?bU1yMGZJYjVYUkltVFNSdjZSTEx1b2EzL3RuRFNHMXd3SnlxWmlwN3UyQWtk?=
 =?utf-8?B?VjdhS2dvaEV4RjlvWWNKSlU3MFpEdlMreTJpZUp5dWhDNnBxSXZWV2UrcGd6?=
 =?utf-8?B?RE1IdFF0V1kvMFpCYlRwanRZb1lxOExaemlGbG0xL2FZdGRtQVh2NkVsZXRX?=
 =?utf-8?B?cVAwOGxwek45QkhwaHNnU0JYbzhrdGh5eHRQL1c0d2x0R3JMbGwvcFlObW1v?=
 =?utf-8?B?WlU1bjNmUExpYTgwQllURGxYQks0c1FPZnVFdjB2TWhnZzhXMU1RL3FhaW1W?=
 =?utf-8?B?T21BSmEyUFljUmFOY1d1eXovRlRHVVVUeUFNTFpOVnM2N0NmNU5zblppMlpO?=
 =?utf-8?B?UWJ1UTRCaXZmV1JHT0NBZWhSR3V4ZTlrSWpYS1VOTUUrZ1Vlb1VIaVBWUHhU?=
 =?utf-8?B?TmF3NVhMd01DdHRQZjcvQk85VkJhNm8raXlmcmxYQ0cvZFZZTERTazc1cHV6?=
 =?utf-8?B?SThLTW5IcktTeExmWVpGVVZBaHBMcFEvMG5qTkdmRzhRV2pmUktDMURzSmI3?=
 =?utf-8?B?aHJKVUFGb056VGJsYzArS0xvSnFrVzNCNTlVVlJmS0FYNTYvL2t0U1RkNkZS?=
 =?utf-8?B?TXNmYmp1bHYvVnB5cGt4QjlQbml4SzNxaTNiYVIwdldlWmRjYWNNeXVBN3N4?=
 =?utf-8?Q?K0Z4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39859e3-2093-4872-2d13-08dbb62f968e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 21:06:10.9899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEn1EkLwVJxTV0Mnl597qZ46vDCbw7zMAZDyQsfNy4iAHM+zlU2tiOIErOOw+i9q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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
Cc: alex.sierra@amd.com, Felix.Kuehling@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/15/2023 8:28 AM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> If new range is splited to multiple pranges with max_svm_range_pages
> alignment and added to update_list, svm validate and map should keep
> going after error to make sure maps_to_gpu flag is up to date for the
> whole range.
>
> svm validate and map update set prange->mapped_to_gpu after mapping to
> GPUs successfully, otherwise clear prange->mapped_to_gpu flag (for
> update mapping case) instead of setting error flag, we can remove
> the redundant error flag to simpliy code.
>
> Update prange->mapped_to_gpu flag inside svm_range_lock, to guarant we
> always set prange invalid flag to evict queues or unmap from GPUs before
> the system memory is moved.
>
> After svm validate and map return error, the caller retry will update
> the mapping for the whole range.
>
> Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from svm validate and map")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>   2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5d7ba7dbf6ce..26018b1d6138 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
>                  }
>          }
>
> -       return !prange->is_error_flag;
> +       return true;
>   }
>
>   /**
> @@ -1724,20 +1724,17 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>                                            ctx->bitmap, wait, flush_tlb);
>
>   unlock_out:
> +               prange->mapped_to_gpu = !r;

I do not understand why set prange->mapped_to_gpu here? It handles one 
vma, not for all prange. If there are multiple vma and first vma handle 
is ok, and second vma handle fail at amdgpu_hmm_range_get_pages or 
svm_range_dma_map, you would get prange->mapped_to_gpu be true, but only 
part of pragne got mapped, right?


Regards

Xiaogang

>                  svm_range_unlock(prange);
>
>                  addr = next;
>          }
>
> -       if (addr == end) {
> +       if (addr == end)
>                  prange->validated_once = true;
> -               prange->mapped_to_gpu = true;
> -       }
>
>   unreserve_out:
>          svm_range_unreserve_bos(ctx);
> -
> -       prange->is_error_flag = !!r;
>          if (!r)
>                  prange->validate_timestamp = ktime_get_boottime();
>
> @@ -2106,7 +2103,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>                  next = interval_tree_iter_next(node, start, last);
>                  next_start = min(node->last, last) + 1;
>
> -               if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
> +               if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> +                   prange->mapped_to_gpu) {
>                          /* nothing to do */
>                  } else if (node->start < start || node->last > last) {
>                          /* node intersects the update range and its attributes
> @@ -3519,7 +3517,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>          struct svm_range *next;
>          bool update_mapping = false;
>          bool flush_tlb;
> -       int r = 0;
> +       int r, ret = 0;
>
>          pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
>                   p->pasid, &p->svms, start, start + size - 1, size);
> @@ -3607,7 +3605,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   out_unlock_range:
>                  mutex_unlock(&prange->migrate_mutex);
>                  if (r)
> -                       break;
> +                       ret = r;
>          }
>
>          dynamic_svm_range_dump(svms);
> @@ -3620,7 +3618,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>          pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
>                   &p->svms, start, start + size - 1, r);
>
> -       return r;
> +       return ret ? ret : r;
>   }
>
>   static int
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 9e668eeefb32..91715bf3233c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -134,7 +134,6 @@ struct svm_range {
>          DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>          bool                            validated_once;
>          bool                            mapped_to_gpu;
> -       bool                            is_error_flag;
>   };
>
>   static inline void svm_range_lock(struct svm_range *prange)
> --
> 2.35.1
>
