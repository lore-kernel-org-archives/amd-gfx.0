Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4AEC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 13:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9291210E301;
	Wed,  8 Jun 2022 13:40:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5AF10E301
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 13:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FduwgUTBF4k5nsI94wvnW+4i9uR4GZifD2z5E0ISHnsOFzQJBa2JY17HLwUozRg/KYdJjFsPuYb9gqxqafP59b20Jq6mrPg8JyIGEojMhqI/tMC0XMFm2dmvaJwpvf3NF4MB8bAvykUqIiYxXotnMt7A8nwOIlDxBo8DqCzWMdBwxQ/yHmixljhxK6Vv5Nur28qKXN8/YEZh0bmqmo5pP0dt1zDTbFM0T2e2beod5gFc50pSNLBfUmUb3N0twdXAvdJ9zLIOZ/uOs+V6q9eVIiV80W18D8tZTOFZsn5/IjgF9Zb8clIs9NwVDlOQvJdOd3A7tr8DtshYb9Enpr80yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpSJg1zAV6p1GcREJSkpR0TWvT72EwqTrU33kbarR7M=;
 b=bL0ly6YU1zyqPfZctwXjwCHy4VezloSjuSgGug42uUGsm+WsBL9tjSn0QhLCR6+w0AkfzydIl0PRDASqrI6YTgt7D5wDEqsxduYMs3C4AJ6lSDj7RSXr7pOiz5Z19oCbpwAKKfRzxBNL0Hvfozqe3HPIoPZgCsaS/+0CTnwtzdVtSEZAxkZl7N2/80eKU5mzH1TnKkyYn+hTz5sZyjgkPSQZN2l02aYQPCS69zdKRVvbS6RtYdmRxaGJQwuSYKVfoQbvVKG02H/wqfyXfXlP7c8CtM8HxT2bf+skcrAkkdTgDuvG8IKGbo1h5HeZjT9j1Gs5Vl7F7n/7NRFt53PF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpSJg1zAV6p1GcREJSkpR0TWvT72EwqTrU33kbarR7M=;
 b=E4ehSR6RfFH+1Nw1hUxsPqbt2kBI5F90dz5WjbZSuQzEmBK9JujQFfGOlCnNMkL9/pvxcflgjSYi0lRPBWjGeAFtjaMH8c4cpDfcnLMYPwfmWAp+zFz1E/ZrRaEoJItpwODrHGdI9aqeKEzJIy0HbNVUpHEWF3J3kIFB6ff0HYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 13:40:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 13:40:07 +0000
Message-ID: <ce38161a-5745-aa97-ff20-d568d1d646fe@amd.com>
Date: Wed, 8 Jun 2022 09:40:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] drm/amdkfd: use existing VM helper for PD and PT
 validation in SVM
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220607095947.120493-1-Lang.Yu@amd.com>
 <20220607095947.120493-3-Lang.Yu@amd.com>
 <bed3638b-5b84-e7a4-669e-0c930b66ad60@amd.com>
 <YqAHxfxEX1bitk96@lang-desktop>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <YqAHxfxEX1bitk96@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a63557b4-b12e-444c-ceb1-08da495466a5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4223E575F0EE6CE983C8D52F92A49@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaiUOmQlcEv6j569GNUj008+pb3klTJuIob+NRZM0xxY1GFWxNXsxCWmVQwRNFLn9TlLmqVhlXLNRkWnjxF2sW4fSOQpOrV9brtm0jDFvWX/Xp48mSskXyZyR9q5al2CpmempmBul2vjHcfuMjvzB4HYxAVutr9+NE11xp8cGl7KO8if3wyk9sEnyBzGFvO/ZEsi1wQ2U57dfxI+yFmA6z0WeLmV3+5+fkUtXexISFVL0O3S7GmN92wFcsSv+Se/+IgohkXNnDk7j5jj/2G5teXCDaTwh8bGMFTiA/SjtPBKWLO/jbPNlzpdtgODEXjc8e1YXK9Z0vRDfdtMkM1/DsGCe8420NmZCxW0fEjg2S8521QHKJ7NSufcodo1qFyt4CL5CM54Zz2Xa51pJJenWrHOSmVrIgsDrfo9I97PGE8CEYma2ZXdUm21DyEbwnvLMY76qrTO0apnU1hWOiXL4y0Q1vGSMID0GSyEoPR+tR7OCjF+ZY/Ldtht/EPvtZbqj6I4Rxt024rk35oo5s1bxEqEUGu3d9WaBF4vihrYrKvk3VWMBbidQDU7XthjD8/xg8yW16cZlM9Q+5nWx82b2FU/VVXycL+vSe6RTfFB2SGI84LFVYYBVtJdHnwSMeTxywv2wCEyrCDPQgnqU+rlAifG2ExIbmuwwEThfwUKSg2RsQjPTjIj+/bmygBY+cYLjhQ1agLyiWbpvYBWWis6ITVFh/kbemv3KKZU2tUuH/dWoss37Gm6iLqJrRZde6da
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(316002)(44832011)(31696002)(4326008)(6486002)(6512007)(2616005)(38100700002)(86362001)(2906002)(186003)(6506007)(36756003)(66946007)(8676002)(6862004)(66476007)(5660300002)(31686004)(6636002)(508600001)(37006003)(54906003)(26005)(83380400001)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFhhdVBvbzZoWHY0WlZOa25UVEVUN2ZsUVJOMUtwUGUrVE1OYU91aXgrZzZx?=
 =?utf-8?B?RFBmdkNFdmNTdEFQSEF0dGJuWGRtMy9ZaVpBQWYyVnJYS1BGSDhYeWpwajBI?=
 =?utf-8?B?dy8xeVZiaWJYY3hHa3QyOTJwd0g5QWxEOHJtYXJQQUVZTThoeXNsditFSjVr?=
 =?utf-8?B?SEJXSDRwaGcxY0tWemJDSlpCQTlibHN6amlvOTJRQjNPSjROR3RON3VvU3Ar?=
 =?utf-8?B?ODNUemlVVXRhWk5RdWFPS1BLaEZZUFhoOThOY2FhOEVtbkRzMW04dlhzM0Zu?=
 =?utf-8?B?TWhDMGZjaEtDRGhSaUhmS2ZmaEg3cVFRUks2R0VUdCtYbVJldnFuNGdDN1dr?=
 =?utf-8?B?MU04dkgvUUpWbndXMHUwY256V1pPUEtLcWttZlJXUXduQnAxTXB4d2RpVWNP?=
 =?utf-8?B?MzBqRS9DZ0lybHN0VnRHYjVQU3F2MkR3c3BDbTc1QVJkNkdBVjFNbGZzcmRK?=
 =?utf-8?B?Yi9ZaTcrZ0NjdytDalF6dGtOcXdjUFAwVHRONHcyYmJwT2RIdk04ZXh3Mnl0?=
 =?utf-8?B?ZjZNV2dpTkdQaUh4TEo0RVc2cm9pdDFteWtwZUR3RXZZRnNIVytSSE1CbU5z?=
 =?utf-8?B?MTFpSmZEMXl4WURKT2IrWktwekdCOXdHRnNIazZTd1k5SCtKaXc3M3FYbEtS?=
 =?utf-8?B?aEgyOG5uQXBIZEVzbmttZm9VdlEzdWROK21uNjB3ZFlEM0Y3em1tTk8yMklJ?=
 =?utf-8?B?SG5NQlNrRDh1K09tbkR1NVZZTGd6cXVVaFkwdHJveVRnY3hmakY5eGl4Um1E?=
 =?utf-8?B?QWdkNW15YkU0RHRjYnlaV1FSUzFCM2I2MXNUUHVNTE9vWEZlZytJZ2VrVE9Y?=
 =?utf-8?B?OGFKcTB1Mm0xZnA3YlVobTZQMWJTV2x2Z1RYQ1lwN1RxR0d1RWpZMXFPMkZD?=
 =?utf-8?B?OEFNSnVlZWdINXhHbmo1MUdvT1kzditic0pMSi9DbkdreHBNeTF4ZVZkYUI2?=
 =?utf-8?B?U3JLQWYyQjhsSmgzRmpUU0cyaDEva0RtYU5rQnVvWU80QXJoL092Z09YYmpr?=
 =?utf-8?B?RTUzK1htR2Jmb0ZzNk1xbVpyemNSQnFNWllURmJSN21tTW9QSGJaTXVyTkF0?=
 =?utf-8?B?VHRIYWlJdVdtdEgvUGtmaWEvVFplK1B1aEtTWFNkWVpkZFBsTVVFcmtuZmtH?=
 =?utf-8?B?ZUdpSUVRM3BrUHdLb3dURldEWVVzVEhSaTEweW5nS01JL3lLSWZBdHZqS2xL?=
 =?utf-8?B?WlFHR08xNDcrRTBNckl3Ti9qL0RWSmQ4c25hTXhaOWJucFd3eWZMN3ZiOUhk?=
 =?utf-8?B?Q011dE1WK0J3Qk9qbG56RkxxSnNSaUtFTWIzaWlFZ3V2Ym01MGwreGdQSEsv?=
 =?utf-8?B?STBJamxWVW1tNXpnVWtsMFJVclY2M1FRa2cxY2h6cGR5K0dzOXJtYlNNcURN?=
 =?utf-8?B?ZUFSWFJkZFNlZU1zQ3hmeVgwMzBDQ2dSZTlWUUxRclFxejQ4QWRRdlZyb1lW?=
 =?utf-8?B?M0ZtRk1ZZllJOFpjTFQ2YnlwSmpiVWV3YjNvNmFRT0U0b2lsbVNmbzJiRTUy?=
 =?utf-8?B?WDJpU2VKYUZwN2VYWW9OQmZZWFNJQUxQOTM0dDRMa1BDUklXYkJqZkdsb2xq?=
 =?utf-8?B?OCtKVzVPb3JBRVoyNi9Na2ZadHZrbmwybm9PelB1OE9uc2V1YUVCWmtUTzdx?=
 =?utf-8?B?OHpSS1dEZmllY2p4bk5SSVpiU1JyV3M5b3hEYkZkcjIzWjFXYndSOTlydUt1?=
 =?utf-8?B?OWxYaEpRako3blRJZ1h0WThZMkRNNmY3dzByYkMrcmFjSER5S2NmNFg2cjF3?=
 =?utf-8?B?QmoyRU1GY2ZkbUZmKy9nRUdUUDQzWDRiMEZUZDRubGY5Wi9WNm1WRTlGN0o3?=
 =?utf-8?B?U05YT0FzZjNSVWZiOTk5YWZHaUh0TnNZTVNBaExReTNPdXhIMGxmK3BLdklp?=
 =?utf-8?B?eG81Tm9jbUJVUUpJODUrYVRYZ0hvRmpray9sMWFsdW1vdlVJTHg0aURJZWE4?=
 =?utf-8?B?dXRHRkZ4UTJGK2tDYUw4OXN3cFBKcWgzODJSOWE1YTRLbk9oZnpjTXQydHln?=
 =?utf-8?B?UVBzU1owaXlGNTE3MUJBSGNhUTh2MDM4NWd3VzJwRE03VmwzSlpST2hQblBx?=
 =?utf-8?B?bm1HM3ZoN3lrS015M3FlR0JXTlFVREh5MGs3dmJRQmRob3k2MVRYMUJzT0V5?=
 =?utf-8?B?V2E0NVA5UVBsaGllVC9WbWhyMU1qZ2xpQjZaNlF3eXNVVzVUa01Ha3NmdmFn?=
 =?utf-8?B?dXZ1MExMQ3N5SStoM1pZVzA0SWFhYnZvMFBaZTdQUktBYkpkMllBT1NHTzRm?=
 =?utf-8?B?d1pRSlhTT05ZRlZxbkoyWEE0R2RVY25mQitpaWloYnR3OHNJQXNTV2QwOXE3?=
 =?utf-8?B?UU9WQlV5ekxWVUN3TEVzT3NlWXdzMEpCbVZoRkxGT1p1bUQ2TlJtdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63557b4-b12e-444c-ceb1-08da495466a5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:40:07.5988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEfvnAjXVRKFmH4COIrq10UVwgCA6RMIFmbNiy+fw6TEHMPh9AgqFqNrXK1L2LGBrCR8VY99KBaZVIHBOUWfZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-07 um 22:21 schrieb Lang Yu:
> On 06/07/ , Felix Kuehling wrote:
>> Am 2022-06-07 um 05:59 schrieb Lang Yu:
>>> This will remove some redundant codes.
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> The redundancy is quite small, and amdgpu_amdkfd_gpuvm_validate_pt_pd_bos
>> and amdgpu_amdkfd_bo_validate are quite a bit more complex and handle more
>> different cases. Someone changing those functions in the future may not
>> realize the effect that may have on the SVM code.
>>
>> I'd prefer to keep the svm_range_bo_validate function in kfd_svm.c to make
>> the code easier to understand and maintain. If anything, I'd move it closer
>> to where its used, because it's only used in one place.
> Thanks for your comments. I got it. By the way,
> is it necessary to update vm->pd_phys_addr here?
> I noticed that vm->pd_phys_addr is updated in
> vm_validate_pt_pd_bos()? Thanks!

It's not needed here. The only time we need to update this is, when we 
re-enable queues after a PD eviction. This is handled by the PD 
validation in amdgpu_amdkfd_gpuvm_restore_process_bos -> 
process_validate_vms -> vm_validate_pt_pd_bos.

Regards,
   Felix


>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +------------
>>>    1 file changed, 1 insertion(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index d6fc00d51c8c..03e07d1d1d1a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -625,15 +625,6 @@ svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
>>>    	return kfd_process_device_from_gpuidx(p, gpu_idx);
>>>    }
>>> -static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
>>> -{
>>> -	struct ttm_operation_ctx ctx = { false, false };
>>> -
>>> -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>> -
>>> -	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>> -}
>>> -
>>>    static int
>>>    svm_range_check_attr(struct kfd_process *p,
>>>    		     uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
>>> @@ -1428,9 +1419,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
>>>    			goto unreserve_out;
>>>    		}
>>> -		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
>>> -					      drm_priv_to_vm(pdd->drm_priv),
>>> -					      svm_range_bo_validate, NULL);
>>> +		r = amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(drm_priv_to_vm(pdd->drm_priv));
>>>    		if (r) {
>>>    			pr_debug("failed %d validate pt bos\n", r);
>>>    			goto unreserve_out;
