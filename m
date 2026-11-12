Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B869606A33C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xn7mEP1V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E096410E598;
	Thu, 12 Nov 2026 09:25:31 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8473A10E552
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 09:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTVYvNnbEDQRc7MK6HBhM2pTsWjdx2zy9+2IZbOZBnhVueQVMRMA/TDciJ+OWZ7lRW8uO/7BQYO2/vr/WzmYDNkOXtQ5pT9pLDFtrBtDfbyQahbMFG/Z+YAUwxbAmGXXORytMtCtd5E+xAaeHKH8NQpzvCVHlUu4GMwzJVdPHqTsdm04qY5++3GsS1sbiG3deoH6YYkrajoJIsC89fk6fjOsxxmO3KFxdm+w2M1S44twovCIu4goB7GrM48nIz2egtGpP8uYM2SRGzMvxOX8NDtShOFv+LU3oFlG8FPbMX6EzPL4Q67kdPfXHGgjbZDbW6mn/3+kKKDvtFWMyBQx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0NkU+7GOZUxoA447lzNWZ4xrboELHX5woGT+cKa9JA=;
 b=DBS5VrozEJBLlFKv4y5E8QCJow/I9G8A4Wb1owGcmFA1H+PItLvTxqXsvgcHrmzPSe2EqMhFUyUWdZZgJU180qqktha/pmvzMU0s4tOK4Jf6p3mH7GBLB0sb0yh+62vOtj+tMadDbdNrOY4BGtdWxgJ4OPerAIaQrUKRYkhH/arRlPHU9XSR6YFoa0niqI/zBLd/L/NiHbG5/IBykWoPbvD09MhAdPqUSdJJj/NiqFVjz7N+ke/bLTq2x7LRP10fdQ7MItiEB4tpq4pOlm/DfD5+h2V8Tu3zowsaRw4Ip/BH+4Ql/exY4kTdHP0kLnIzjbuit4fMvFzBaotf83scBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0NkU+7GOZUxoA447lzNWZ4xrboELHX5woGT+cKa9JA=;
 b=xn7mEP1VVEd70Kc8FMBN6LlIqTbpab2IgtKSmYuW9DPDBEs7Ivxl47sUVm9CvKpW8CIheTj/Vy62NLULYD+tzxFCC1kn7W2aDmvHmdByfHZ8P6nDHgJIBG+Bw5bcAMTPRjUPPMMsDHybb74PmZQXX85K7xbNVodQKIeriIn5b8g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 09:24:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 09:24:08 +0000
Message-ID: <8333ede5-3833-4465-9eaf-ab9d1b75ca89@amd.com>
Date: Thu, 12 Nov 2026 10:24:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear the entire mapping when partially
 unmapping
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261111-amdgpu_partial_mappings_fix-v1-1-02c5dfa20889@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261111-amdgpu_partial_mappings_fix-v1-1-02c5dfa20889@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b1faee-142d-482a-406b-08df409eb41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6MSC4xVdQYTsh4Iwvp1NeRzAztM11cM8T9VCyeKtDYiUHM4y47q91Uj1g4r0spo40SVv8D2XHuOqcx6PzQMsJbdsFjMs+yXJ57UOLYqpNmGDgrliCv3LEeb5D5zjTmhEKKTfiHKOB0NGuF36KdOqZoE3WK0dQ/DKvQSsJoP1H4Q/Y20b4An1thYX0XNPu3Xq2oTGRsIJD+4RzVrbWeWH/cYxIH+DPqyUSlV8EQNbS+9chcY4RzkFPRIWsxJjPnss87tdmVkkIwfwHNDZjM+9CqUvC2ROoMjp8eNkswjtWcXdcTpaKMVX8lxWyOwOlflOnJ1qciDg22f13pKqzWlTnZVZqCUvOmJ6cKqiVVr77qIzSEM3+jeADGg4qfnjaFZzrprThN3IiD9m8Jzv21/Ht9osKz7iOlCAI05vQD8u4Eg8w4SjULm8jK9wtVgWYeuXvaRfMg1UexatiBSDYGIRwGGF7Ig6xcPzcg4a08e8n/dSHXI6Rj5FnBATziV+ymDGbMtgsZvaRs/pIPHocObFMHPw48CY1u59uvjJa4jKSZ+TbkOHx7euHp0u+dcq1uzTqcUsGOcFNbEJCY+kr8KUafcmce+sP3GtkAi+2bRBg389Uo83o8zrbYZTJNcHsXSZVeR8h0H2R4em8CxZk0g2PbGjSzfcPpIDe2HWRgwZYBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tlg3VCtscUVic2hmWHJDaEhFTDZFd2ZpTlBjcytWWDRqVGFKUVlORzZpT2dz?=
 =?utf-8?B?RFFscFhtamJoalZ0ZEkrZUZ0ZUE3VGZsS1lXQ2pINUxUaWV0T09jSE9rbUtx?=
 =?utf-8?B?Q2V1M25ZRWhnc256U0g2Z3h6c0xvMUNzaHZMSGtGQ3luT2RhNnJaMHk4cGxS?=
 =?utf-8?B?V29KYmx2NTA1bU0rWjVucFd0NEVEZEVUaU1ES2c5cmczZlRVUGxML0Rremcy?=
 =?utf-8?B?WTAxMG9NQ3RmUi9uWXoxMlEvZy9yd1NidzhTTmZoUDFXRXF3MkdHYmczUTRp?=
 =?utf-8?B?V3JvRnJhZmlTRStwTTdEcE10VmRncHV5U25BZ21qMTBDNnZJaXBjK09OeWFB?=
 =?utf-8?B?V1p5WUVqUzI3ZXFPbHFmOEtUM2l2RzVzK05XaVlieGxZTFd6MXNZYXNEREFs?=
 =?utf-8?B?VnpMVmhZR3diT1p6L3l4SmJ2anlreHdNOVR2aXZlUWZJUzZHeDllcytwU0ZY?=
 =?utf-8?B?cXdDZkhjcXZQVVJOcmhkTHJVVlJnTWtVRnZKUERnWUpkQTdiRVE0MzdHYng5?=
 =?utf-8?B?MjVnaThPOW5lODdnYlI2MVE5cktoV1BCYjJvcElBdkZXTWVzQ0NaVlJoaUhs?=
 =?utf-8?B?eTJySnlTa0dYd1JkTng3T0NzQlYwSE51cXpYNUhyQWs3MjRxM3R0cHVHZ2lt?=
 =?utf-8?B?cVlSdW5YNDc4cGhBTS9ZZmFvcUhiRHl5UDF3SlpTdGNiUGNYOEhLVjdIWitW?=
 =?utf-8?B?OUVTN1JVcTd0YjlNdE9rOUErUUFQK0RzT2JWbE52aVhMekZBaGlZM1FLS3dK?=
 =?utf-8?B?NGRIUXV1bFM3blNPMzhLRXVEcDlrMk9GZjZjZmo2OFk0Um1QN2RNamVqejhz?=
 =?utf-8?B?NHNZTE5BQTh1U09Qc2t6T3BPcjd3dVFPWkJJL2RzYWEwQklwWVl6TjUyeG1T?=
 =?utf-8?B?UzErVU1NelhnTVI5WjZxTDNDUWVUcTB2NkttY29TQkl5S1ZvWDVOQzIxN3BZ?=
 =?utf-8?B?R1VkK3QyWHplSGRFTEV1WmMrelZGamxvNS93bVRkNENGTk5wOUxheXR3VkVv?=
 =?utf-8?B?b3RtNXFHSkZLU1U0cVhsd2Y0KzhOSGJQU3pNQUJIMzBQNXREZ0h1V2srQ1Ru?=
 =?utf-8?B?Q0huVjhBbVJCRUs3QUUwWVpkeXQ0a3BwcXJ0R0FqRFZITVFCdzU1QlpybXBL?=
 =?utf-8?B?cDRSSXVNc25LQnJwRWJ4NnYxaDVmdU93dDJWcGNvNWFLVVZCRWh5TFNPMnJZ?=
 =?utf-8?B?ZWUycU8yQXVQR1d0eGQ1QzZJNThlMlEvTlFQSUpCdzF4RG5QNHkzWm5GSUpy?=
 =?utf-8?B?eHBGdjBjc1hIL2ZQMm02MnU4OTdJYzJjcVV2cURrMFMzb3FrVE5JYUZqaGto?=
 =?utf-8?B?bk5PYTE2YzJUL1N3Mzloelo3b3dPSWowNnZZR2JPbWNBdGlscnZnYXNQVlpN?=
 =?utf-8?B?VE1HUW1aN1VSOTV5NTNINnFwQnBPMjVkTk9nT0R6cU15bGQ5U3RWSlhiaWU4?=
 =?utf-8?B?OGxkRWZDZUdWSktVUkpjR20rczVycWJYZlFTcXFwTHg3SzdQUmswOWtmZ01W?=
 =?utf-8?B?YmtOMlo2azg2cCtmZVVIcXBEVi9rSElQdnVOVWdhYzZsOUVIOXA4T3NEYk10?=
 =?utf-8?B?dzUySzNaMUhsbGJFY0dvTWtReVdha1RQM1J5UGpaV1I3dUl6aCsza1FKWGtq?=
 =?utf-8?B?Tk9VSk93UHZsek4zYUJKR01wWjdjbWtRcDh5RVEzN2lWODU0a1p6ZnRvaW15?=
 =?utf-8?B?enpUcWNPVDZwM0VSc2pjWC9aWDhTakNITU4vRHp1d2QzMTk5cWswRzczb2RC?=
 =?utf-8?B?UjMzSXl0VDltZ283NzQwUUgvWmVwZERqZTcxWGxhcFlsQk0vNU5JSyszelhM?=
 =?utf-8?B?aDBzN0RyOTJDZGQ3Skd0VGlPdzlEdnoyd25XUG90TTA2UGVjR1MyS05JRXVE?=
 =?utf-8?B?anlibkJxQ1lCRzllckZoZDQ5QkE4d3JPTkc3eUhOdzJmN0F5V1JoUDFxVmdj?=
 =?utf-8?B?N3ovMEhvWjllL1QwS1hKVHoxeEYzMmdyL2FjalpQRFZnejFQRldpNE9HU2VW?=
 =?utf-8?B?dUZNTXJZTFVVbGNxcHpFb2VrMkMxR041NUZPdjRkczBXemx0UHYza2NMRnMv?=
 =?utf-8?B?QlpJR0VFMUMyQnhYRHZkdEdhTzFrSXNYNHptNGVBOUtRRlZoS0lZYTltK0xG?=
 =?utf-8?B?cnpxRjJCU2VObE9XR3IyM0ZiY3RBWS9NdHhlMlZVcGZWZXY5SjQzZU1wSG11?=
 =?utf-8?B?TGdSU01ETzdJcnczUVp0N01HL09lK2FrQWVINVFEK0NCMkZtMWhQeU1SV1lk?=
 =?utf-8?B?TDlZd094dzRxZm5BdUtaYWxJWGxwYkJscDlwZ1dSTG9SaEVvakF4RTEzZXQy?=
 =?utf-8?Q?2+6tJJTdzY0ADose7M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b1faee-142d-482a-406b-08df409eb41f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:24:08.2657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iut+IIlmZvT9nhCJ+RBO5OH39TmbkTFgtpZpSF/OZ7rC929+4SrHj2uQN9n481oG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
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

On 11/11/26 19:28, Thadeu Lima de Souza Cascardo wrote:
> When we partially clear a BO mapping, we only add the partially unmapped
> region to the freed list. That will update the page table to clear that
> mapping and leave the other endpoints mapped.
> 
> However, we move the endpoints to the invalids list. When later closing
> that BO, it will simply free the mapping and not clear the GPU page
> tables.
> 
> Drop the optimization and clear the entire mapping from the page tables.
> As the endpoints are already in the invalids list, when that BO mapping
> needs to be accessed, the page tables will be updated.
> 
> Though that may clear, then write page table entries and even lead to
> new page table allocations in certain situations, those would already
> happen in the clear path.
> 
> When measuring a given workload, it was noticed an extra allocation in
> less than 10% of the cases, but no noticeable extra latency. In any
> case, correctness is more important and this fixes the scenario
> described.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a99c2ef14be9..808b77083a5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2108,12 +2108,6 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  	list_for_each_entry_safe(tmp, next, &removed, list) {
>  		amdgpu_vm_it_remove(tmp, &vm->va);
>  		list_del(&tmp->list);
> -
> -		if (tmp->start < saddr)
> -		    tmp->start = saddr;
> -		if (tmp->last > eaddr)
> -		    tmp->last = eaddr;
> -
>  		tmp->bo_va = NULL;
>  		list_add(&tmp->list, &vm->freed);
>  		trace_amdgpu_vm_bo_unmap(NULL, tmp);
> 
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261111-amdgpu_partial_mappings_fix-c48d729ef590
> 
> Best regards,
> --  
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 

