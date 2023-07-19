Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D965C001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 16:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFBA010E4EF;
	Wed, 19 Jul 2023 16:55:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B9210E4D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 16:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG9N3D6f6/FP1NG132GIrrTB1VdoUgSXNI7QruPEuPruoMpR80iOcZIn+6rdzbk5R/72RkbbKa7NPS/NGE6uLC4tg53RT3KrMA5UHNty35Sx2tDXmaV0eoMl+OX3ZqP9w1j+fWrjiwzF/mvJ+kItXxrcODsXZP+hWVXU+jK6/8sY6x6BFOM1ruq+ke2HA8UPDNmCubfmFL4nFzqzuCP0tBeg3FfCyLpwUuncz4LSp+nOT80A7Jx18hs5eO9nhftxN8iaepUkwflJ0g62vs87fsp/kQ2jpbLfBfL/FMRpcAe+KT7aMajFCYaU/MHK2f1C7zu0AyjYKMzm7h6fdpuZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrOoHN8EB+Vn+CdZ5C2qKb46WI63fFV6XMdWDqcCPjA=;
 b=AcSqJ8JlSzv4Piabli3IjYak7dqCxv72qliu3m9rhTUGKQW3j97mq2IwDxaqfAcihtUgq+SfwquABIWAogV4mrXMXjPnntFkZ4Kup0tBlKNHFrgK/EGQrEerskPDK1SEDEEJEgH6nQttxNdnPQ+OBr1916Pqx1ZNPrQZA2LM16x+PK8LPsBKm1vIBRzmymEsJ0BE1g86UI6ztlw+0mQoh6emO/o49nNm7onNz7M7QqfrLh4PT5oukZMA6NLEV0/P+1DBanVNI3QVW4wxxDc4+V3pPWBVNjGXANrAb2VtsH8k+kyBuOZkBgy6oq1mj4/u43bAnnxMzCPqRKWpeSVgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrOoHN8EB+Vn+CdZ5C2qKb46WI63fFV6XMdWDqcCPjA=;
 b=PxPm1jpewZg9to+Wyc6FXWSelLu6Fc6m7SIHoLHdPa4fHsmaKXhI9ZjRa8iQZkiU3hDCCL0L7fOxA611rHH0VX9pxk9ZlrZyNA7j0a1bvW74HXDCvbhzMacST4Prjnwy0B13T841hkc9/a1AJN3J9TFYN0OF1BlRQ3iB6zsFhJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 16:55:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 16:55:47 +0000
Message-ID: <e2feff81-0a1b-0cea-50cf-b5ae8995d83c@amd.com>
Date: Wed, 19 Jul 2023 12:55:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230708165748.31355-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230708165748.31355-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3ccf30-956e-43d2-1bbf-08db8878fff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TtLQdBPBMyRCEa2N26AOCMytR0BhJn4x7lF0FE9a8OP4Y5lsxdl1p3J4E90rxKf2OpeGxIQ+B5n/5FR24qGCJDf+91rNLKiBRfeCjMUWSKncIcrhw+OGsljBD5NNWfbTKy4rQ63ilsPSmkuJVZdPGTsDut3SQmJT7hAnYc/lYgWHJrsRXfpA60tx9qKemqNqRNpfSYbwuokoKTuKbzk2oh2KRFBkQsgk17VI8jlUuZMpDUMbDLu7PUV3Jt3fsjcY7QjPphPt/MS4TmVnjxd+IYzcasHhy5WFWqgZTtmnesq3RFlj1lxQygEHibw/V9oms82WXh2tKXv9TeDWcIqe9fBfH2ShmoL3a5OaF71IDbM0pPsZ6ImoSnLznOBdSqUgDvYAtUUPjtF2OHbP8wdHuB5SyTgW1vu8Bw5jmSB9i+4kFVbzvVN+MTU1umsw9FT/ADStMn4c/5U7n7fYlgpMyY5/sdZFIQFr6Y8qHasD/chZylUYB/7iSQGJAm71ObxYv/CRVAvtDULNEVMZGaFixxpPrleDjtd4Qtq822MRCLPxhIp0Q5EV2laMnj3QHOUpeYd+VBBAZJHD30tf1Fc8P+s8wUR92cudC0fpqga2Pq2RsduULg1WVhPuOxZuc8xsPQdAexDvDNdB2zwnNXyjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(66946007)(44832011)(66556008)(6512007)(6666004)(6486002)(66476007)(2906002)(316002)(8676002)(8936002)(4326008)(36756003)(5660300002)(6506007)(2616005)(38100700002)(186003)(26005)(41300700001)(86362001)(478600001)(83380400001)(31686004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJxTFBNcHBlSWd3NmlmU29HaldZWkNCalVxWEFaL3B2aWwwcGpjT1JGakZG?=
 =?utf-8?B?b09lU1FvVnFmRVgxdzRnOVowcUl0K2xvOXIwUHBWNWhaa2JsZ1pUODlmSGZJ?=
 =?utf-8?B?Q0wwR2dpL1FjQWZPeGFCZ0ZYRDZOdnNyWmF6d0IycTZGUjczMjZabCtNSU0w?=
 =?utf-8?B?Z1p2YnY2WUdnZHhxeU1iMXVaMktqTDcvaVRONmxPZE8yeGk3ZjRqUjBma21s?=
 =?utf-8?B?VkZvWlJ4TDZmWWN2bXg0Y0dHbFhXemlqbGFpbll1eGlONjk4VDNrWkJlcmFq?=
 =?utf-8?B?SDlmcEZmb0dXVHlXMUtiaS9ESHFKcTdEYmF6c3NuZTNNRjBYNnhvS29nRlpp?=
 =?utf-8?B?R1BFeHRBajkyeFM0YnA1UGg2Njl2NE9oaTF1SFgzcml5UWtRYnhQbm80SXlP?=
 =?utf-8?B?TEtQd0dBbVE0MmdNUWhCTEQ4ajFZb2xyVXByYUJKbnNlUkxJcE1ObE5JTHNT?=
 =?utf-8?B?TXFrMTdUckNZVmNGRlNML0RpblZxdzRtdTdTY3BRcXQrVU81T01KRW1VMGJT?=
 =?utf-8?B?cW5xYTd5Z2MxTUZoL29qVTdMT3pHOXIvUERybGJ5ZjZXMGQ3ZXBBRHEvVjA4?=
 =?utf-8?B?L3dOR09SZzhVN2VyQzZzU0tpS1NzRHZxQ29yT2lJendWSHlEaU1EcjdsY0ZB?=
 =?utf-8?B?ZXkwV08wdVRhRW1oNUJIeVEwVmNjbXF1ZGdKSlZ4NUNPeVpBcVBPRVdjZG5r?=
 =?utf-8?B?aDdxRXZUdEw2TUJRSC9tM2xnT1ZpYmIxbHJWT29XWjRCVTc3cFlJa2RlMVZq?=
 =?utf-8?B?aDdoQnNFaG5hbHRvK1M2SHQ0WUdDWTRrS0JtNkhqaXpBdUl4blJVcXNBNmJY?=
 =?utf-8?B?TzdlZHhlQ2JlN2QvNzAxdW1lMEJsdGRFNnBtaitMVkxuOEtpWTltdlFWbGJR?=
 =?utf-8?B?ZWJTQlA5V2JDYUg1ejlyV29JZ1czdk1kbDhvQ3VBRHpwdkRXZVNMbUZKRmN5?=
 =?utf-8?B?Z1hiNnNPMVVsUlF1SDMwSGRrb3BCZEpxaldGc0o2K2FVRjIxRmluN3pEMUl3?=
 =?utf-8?B?clBhc3RnWXUydENhcjN2U25ZMnBhUEF6Y2N4b3Rtd1BFcFExa2lHcVJYcldo?=
 =?utf-8?B?YUdha0xEVkF3R0xudnpPUEhHZGFvRWEwYjJ5RnVqVzhXTEFsdVZtVXljYzMx?=
 =?utf-8?B?UGhLcVk5Q2RGVTNYa0kvbVRVMTZFSXZKUE9mWjdpdlh5dTEzRWk3QU1oVzBw?=
 =?utf-8?B?OFJac2hyNmNhbmpFYjJrYkFRVDZlK2hPQzFHVnJGejJ0ZjR2MXA2eDBrMWJv?=
 =?utf-8?B?QnltSFBpNGtYNGhXWjNoZ3lsczNmY2U0VWwvMTdEdmN4eGR0SHhXMGtwMGky?=
 =?utf-8?B?L29RUy96RU94K3lCdWl5QXEvcHlBd1JtVzJZcFJCYitxbFpuczdwL3c3T1lM?=
 =?utf-8?B?NURpYkR4MUJwdDQzbVZmMGljMnZRclZ4MHE1YU5BOTQ4NllJTFpaODFBWElu?=
 =?utf-8?B?cGFIUXNSb05SK2NyWmczbnZGc3BXSHAxZmN6RnY5aVEvbFRXdnJHZlIyNkRi?=
 =?utf-8?B?amVFa3NUeHZld21CMWxUb0ZmVlU5d2hSTW5SVWtSWkdiL2NHN0wxTHJkZzk1?=
 =?utf-8?B?SlBzQjV6dDZWY0RHYVE5U0I0NW5HVGJMZjAxN0I1VnVOZUJCL2ZBU1c1ZW95?=
 =?utf-8?B?c0pFN00xNjhqeEFUT01NSkJydzJ2QnY1SHRtOXpvSUZXbDZyYW10eU1yMC9C?=
 =?utf-8?B?RzZERVJiSDVGMDJMd2RZQ29FQytTd09BSldIVXhXbkxvQkp2T2xteUtlVDVH?=
 =?utf-8?B?Q1FDdnZmV0ZtU2o2cFlPQVNKTFgvcTV3Y1I1dGV2L2FOL3l6cmVjY0VwcFMv?=
 =?utf-8?B?K2N3dlFrQmVsTkkrSFJ1VENUYS91WjljVUFCb0Q4cWQwTDdJdWQ5bEVNQkIx?=
 =?utf-8?B?SUhVVkdHRjJ3cWJhZVpQUzU1VDJSZlhPWml1b29JRHAyaHZVaVFSendHVmZu?=
 =?utf-8?B?dDNEbVAwTGtZdGgvYUcrelhwL09uczBxQktubWo4QXRYcmFjVWt5UUdseGFV?=
 =?utf-8?B?cm5ON2NRUUpIUDk4MWJneEsvajlhN2hBcUZGOFhVdFN5RFd6dmo0cnpFUExF?=
 =?utf-8?B?MXR4NWJYMEJsaVVyOWJyUmx2VXU5SXJsVGQ0TWxrM081bjVCZXIzRXJDdTMw?=
 =?utf-8?Q?hmA3rZS1SYiiddSCsFueiJEqn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3ccf30-956e-43d2-1bbf-08db8878fff4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 16:55:47.5833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrgtFybB43uIZMNX+GeXfH7TyhQArkjhZ4UQinTo0bpcun9mokQoy3oTO7NQ8gM0w6vNUc5m8HM1G2Gtt4JyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
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
Cc: Philip.Yang@amd.com, jakub.kurzak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-07-08 um 12:57 schrieb Alex Sierra:
> svm_range_debug_dump should not be called at all when dynamic debug
> is disabled to avoid iterating over SVM lists. This could drop
> performance, specially with big number of SVM ranges.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 479c4f66afa7..4fb427fc5942 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -821,7 +821,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
>    *
>    * Context: The caller must hold svms->lock
>    */
> -static void svm_range_debug_dump(struct svm_range_list *svms)
> +static int svm_range_debug_dump(struct svm_range_list *svms)
>   {
>   	struct interval_tree_node *node;
>   	struct svm_range *prange;
> @@ -847,6 +847,8 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
>   			 prange->actual_loc);
>   		node = interval_tree_iter_next(node, 0, ~0ULL);
>   	}
> +
> +	return 0;
>   }
>   
>   static int
> @@ -3563,7 +3565,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			break;
>   	}
>   
> -	svm_range_debug_dump(svms);
> +	pr_debug("%d", svm_range_debug_dump(svms));

This is a bit hacky. I would use the way dynamic_hex_dump is defined as 
an example for how to do this without the dummy pr_debug and without 
returning a dummy result from svm_range_debug_dump:

#define dynamic_svm_range_dump(svms) \
	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)

Then instead of calling svm_range_debug_dump directly, call 
dynamic_svm_range_dump(svms).

Regards,
   Felix


>   
>   	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
