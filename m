Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6880CE728D6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 18:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDFB310E1A6;
	Fri, 29 Sep 2023 18:30:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A495D10E1B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 18:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPZ8hznFJIq/GpSa2E3L2n/OrrfLjnbAkxCpVSsZHnWLVdfZ+ODHlw8JW1MZ5x7JvSzi12MJ5gRiwUU3S9awPZB5xAvu8L+4+UTeg8utbcF83o9SGNnZZzzfPcyfUjvZRmtMbkJGiy/1a2Sw+OO5JyrNtLadhybYLpBhsRpxdu9uDQ00Xn6yybYdLrEWCENlK/RH4AaLaznTt924HD5q5f6qhqzhZdpDSZyJN9PbKuVUjEf9rPX/h/gdnvbxOqnYowOwdCsMYqJ/ZmyhJKBB+Wqp++OyuLT3sCSHE2IYEiZd3YCsfPv3+AOV3GdKKupAUBjEguaU4q97GE+cJLY8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiJqUUngSZWCOMzUsobtMV9z26WC04t0Ue3PGxXkbCQ=;
 b=Gd9TpLWbNhjjwvuPqmUdqM/ZRAVjpY3qcozxPB9xDf960/kpFkZWmUhSmrAIjixbU0kTMeYrc6OPoYrzlelVPNdH/ApA24dw4ogGG5f+8XK/1MaVnDAwFeDnOOCIjkP3ac7tGforzkhkZp1sGp1QpbAl7QjBRlcQo+TUbr6ToZHJRaBPv1kodRdavMSI8DBTYHKhmyo0bVm0eS1hUpF/pjkMz+5JPD5fRB+SkGe78aevULyQBv3wlxE6qDvhaEK8vk4fiajIOVFcJ3agTPJMOAi+wvs7fhSU806OGsL7MlENFRoGRfaGwVIixFMiB4f8ozCf+FrLlSARo+qkgJqeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiJqUUngSZWCOMzUsobtMV9z26WC04t0Ue3PGxXkbCQ=;
 b=dyPFGVxj3iwazLERfdpChOFWQjJChY9++S5PowvaaJMFd5SvdgosNsfRLi7nfZPEtEXxu4rfqcoMZSK5Illz09TK3bRLJjQoeQqPve23EenodmUymqRi8UJGAwb8t43A6xrfi+vI77edCppt5fDETAveTeR2ZLnIUlgL52Z7BjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 18:30:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 18:30:38 +0000
Message-ID: <f08aeb2c-6244-e791-de30-acacd606ee1b@amd.com>
Date: Fri, 29 Sep 2023 14:30:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: ratelimited override pte flags messages
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230928222212.17006-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230928222212.17006-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0214.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: b3088dfa-7a10-489d-d44e-08dbc11a2d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUpzdeU1xKLrH9PuqUAxvZKX5HatKvJFSJCgNrn1WZXOwoyOgNIg7PLjYoVCUC5akkWjzA1DpD2yG2Wo/NRQn7P153aizC6wdvGn8LwCKv4uiTFCJFYwcgGSnBvLV3Dxex7V8fRSVbeaaRS+GQy63l6Ur5k0zjEGZEui7sgr3V1szcvxry9pFVCLYTb3bmHPtRQF1hJe0XDOkFwe8nCJNwk0uhwnAda18ABlgeEgoDfPWakXCxbkF+qxPRQ0SfeKRFt29PRkuEsPcUnOeqpq55jtd++JWREe8wf0j31rtf7ygzo+bhs9dAN671+tCiP48ht/atlXWi1/whuynamM1yeVBImUFRYjPWUestjy8T0MxpQ3RrzRQK/46ED61R2BmOvmu38l7MTnyBsqQS8ZfCwXjdLlbbx7bS39MatOaA+yoRxeoEZJbWIaxa5zMwUVjzrAzC2WsVV4Qfj2W3F3T9CAP+SxRmmVPzGP0H04+c7HRjZ10/VUPiuTZOXfBx3knuwH+3Pt6MgRPtDcN0LP/rMpZfvEzPemaa6IJEKLn4l34jvIVxYzZDfTeH2etGv1VfnU5fE0rVQbEUPCNdULiDsI+K/xK2ib8BlvR+IU2rqVnP8yBtE+KO5WS37UeKeQSys6bsZhVpoo+W0eMm7aAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6666004)(2616005)(31686004)(2906002)(6512007)(316002)(66556008)(53546011)(41300700001)(8936002)(5660300002)(15650500001)(36756003)(44832011)(86362001)(66476007)(6506007)(478600001)(36916002)(31696002)(38100700002)(26005)(83380400001)(6486002)(8676002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXpFNjhadzRlUmk1SXhoQTVUZUYwNUduRmEyd3JjbVMyekUrSlphekU4OTQz?=
 =?utf-8?B?dzhpRUVFU2QySU14ZGwzQ29COUhub2orem14MGNLd0VxNE9hR0xYRTUzRThh?=
 =?utf-8?B?WVRVNGwrRHQwWjdhd1oyTkV0MmEzVUVSdEJkU1ZRZVVxUWg2MUpPTjdVMFcy?=
 =?utf-8?B?YmdmYzQ1TGoxT0RxREVyZmxQT0M3d253amp4VUxQb2hoazRocCt6SllYSnRU?=
 =?utf-8?B?aU9wS0RhMHU3VWU2bXlqZ3poZHRwOVdOazQ2TjNLdzAvc1Y4UVUzekM3WUxS?=
 =?utf-8?B?Zm1UTUUrOWF0dnhpb2JUWDgzK2xuT0hvSTRqUHM2WllBZUlmU1l5YnY5MkRD?=
 =?utf-8?B?TnVkM29ZeVpkb04rRWxkZjErTGJMQm4xUmNkL0Z6SEdyUE5qSWc2d1gzbW9I?=
 =?utf-8?B?N3cxbGdzbEgwZ0ZlTmF5OGhSclJKOUt1MnNXNjFPd2JZc3NkOFM2UDc3cS9l?=
 =?utf-8?B?VG1qNFhlSTZoMEsvdVpWNmpjNFJoYTJZSXRJc0RxNTQvelNjNjZ4dWx0NVNk?=
 =?utf-8?B?T05SaVcrMUNIWnhaWnpiQUtZUjVia2hrRUhLcnJxUnRlRlh5ZTM1RGo2ZlVQ?=
 =?utf-8?B?NTc3UnZWMDAzL0pqUXlScVBpN0RyRVRZbTBySGdSazA2bDN3OTExS0xSZzF5?=
 =?utf-8?B?VnpzSGtYVnFhRU9uK3cwR25kNEZwY0FUUjhqcCs1VUxta3RKYXkwZFBPMWNu?=
 =?utf-8?B?RWRBVytJZ2Ywa3FkYXlETFIwTFBKOS9mTHloZmNrV2JJcVcrMENlR09XRFB6?=
 =?utf-8?B?c0hBTnhGZXh0WElqLzhtdDZIWXBEVzlFM3ZhZ3RUYllEbTM0RDNIakU4a2gy?=
 =?utf-8?B?SGFRZVpJVnozNWNvS01lQUpsa0VrYmVteWVWeU5CTmw3UzlIeTlLbDY1R0pr?=
 =?utf-8?B?Tkl0TmtJSXNXWlhMTzBLMjRudmp3NWNJbkxub1Z6bitGQkN4dFFZT1hUMUxN?=
 =?utf-8?B?WWxFRUp3TEZjVkU1dElMMVB5WEJ0VEJsRDd4L2hVV2p5citsUkZDZS9iaWMx?=
 =?utf-8?B?cDNmV1A2WWJ0MTZGelZGaUZqWmkyY0RzQTVaZ1k5VENFdHplQXlrWUNPQUp6?=
 =?utf-8?B?YndrS05VMlFFUTdld0ZzUHp2T3VLU1hkTC9WVnBXbTQxZHQxaGZOL1BjNUxj?=
 =?utf-8?B?R3lPZ0VYMllmQjQ5WEV2U1JadHUzRWVCQWlxcXRvRktqcXNJV3Z2OTBBbklw?=
 =?utf-8?B?TithTVJjMHNSSk1ubXFKQk1qcENvd291cmg1Nm40THpRUXJLbnFTMkdKRVQz?=
 =?utf-8?B?akhhckg3aCtKRC90RWtPTDBhTGtSN0lCOEh2WXkySE55QUNBays4QTJUbHo3?=
 =?utf-8?B?cm9DaUdLU1JtQVFZVjVzSUlUMTJSczVnbkl1WEFIL1hEWGtiOVhlUlY5Nm9r?=
 =?utf-8?B?NVVGRWxxQTYrS3JzL01IUnFVUGxuRGVJWkhkclBhSm8yaW5HRzJ5OGh5U1lV?=
 =?utf-8?B?Mk9vRkFZMnpnK05vbCtob05oOWNEWW9ZMUtEdWxFazV4UktpbUdvcER5K1k4?=
 =?utf-8?B?N3c4ZUZGUFo0cHkrWFRGZlVKSDlHNU1GeFoyeVRIQ2RJUER5V3k2d1pvNHRl?=
 =?utf-8?B?SnBBTmlwOEtPWVU3Z1NjQUViR05nMWZyMHhBYXhWaG8vdTRtR25naTA3dTJ6?=
 =?utf-8?B?Rytyclh4ODlXdmUzWjdlaGFXVHRMWkV2OWxNRWE1bU1sV21pbEl3bnVmZUhv?=
 =?utf-8?B?UUhZd2pGYy9SMWt5QU9LOVM4QmxnL2NHS0Fua0FXeGVVd05TbjVhblJmY25o?=
 =?utf-8?B?MmFEVzIrWE5Gem0zL0dTckkwUlJ4amV3VVY4c0dqZkZ0MnZTT2lIWmxTdkVB?=
 =?utf-8?B?U1h0ejNoNWdmZjIvUjVxekhTWkRxZE9UcXJId1RVN0h6MkVQRTNOMUdYWmN6?=
 =?utf-8?B?VlBjSFdUMlluYnEzekw3MjM4MHRENDJ2WkkxcW41cU5qOG5BY2pXdldOd2Rt?=
 =?utf-8?B?V2JEUXRDcmpPTmZqZ0tPZzNGaGxlRFJ4cUNIaGZUVmJVeFFhRnFncW5HbzFW?=
 =?utf-8?B?bkdqZGttKzhFdmxVSFU3U09kSjdWa0pBRlNXNkdFbHJzeUJRbzU0UDBVQ21U?=
 =?utf-8?B?ZldBWWZvTENDWTRvakd0VWtUYlpqOW1JTVFqSlgzY2o1Sit3cXV1NUNSdGNJ?=
 =?utf-8?Q?v8BHEiHzqyxlBzJqpoHeUcmjQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3088dfa-7a10-489d-d44e-08dbc11a2d70
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:30:38.0544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B/FAJD5bY+w/iej/kV9zMFzDzfsmpZjATmt0EEekiPJh5HxWUmznEhT6JW9v2/WZEBIVDkkMUQPCM7ki/M8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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

On 2023-09-28 18:22, Philip Yang wrote:
> Use ratelimited version of dev_dbg to avoid flooding dmesg log. No
> functional change.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
>   2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 96d601e209b8..6d2878684287 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -848,7 +848,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
>   							 addr, &flags);
>   		else
> -			dev_dbg(adev->dev,
> +			dev_dbg_ratelimited(adev->dev,
>   				"override_vm_pte_flags skipped: non-contiguous\n");
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 6b15677c0314..ad0d63472e17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1244,7 +1244,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   	 * the DMA address.
>   	 */
>   	if (!adev->ram_is_direct_mapped) {
> -		dev_dbg(adev->dev, "RAM is not direct mapped\n");
> +		dev_dbg_ratelimited(adev->dev, "RAM is not direct mapped\n");
>   		return;
>   	}
>   
> @@ -1253,7 +1253,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   	 */
>   	if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
>   	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
> -		dev_dbg(adev->dev, "MTYPE is not NC\n");
> +		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC\n");
>   		return;
>   	}
>   
> @@ -1264,7 +1264,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   	if (adev->gmc.is_app_apu && vm->mem_id >= 0) {
>   		local_node = adev->gmc.mem_partitions[vm->mem_id].numa.node;
>   	} else {
> -		dev_dbg(adev->dev, "Only native mode APU is supported.\n");
> +		dev_dbg_ratelimited(adev->dev, "Only native mode APU is supported.\n");
>   		return;
>   	}
>   
> @@ -1272,12 +1272,12 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   	 * page or NUMA nodes.
>   	 */
>   	if (!page_is_ram(addr >> PAGE_SHIFT)) {
> -		dev_dbg(adev->dev, "Page is not RAM.\n");
> +		dev_dbg_ratelimited(adev->dev, "Page is not RAM.\n");
>   		return;
>   	}
>   	nid = pfn_to_nid(addr >> PAGE_SHIFT);
> -	dev_dbg(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
> -		vm->mem_id, local_node, nid);
> +	dev_dbg_ratelimited(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
> +			    vm->mem_id, local_node, nid);
>   	if (nid == local_node) {
>   		uint64_t old_flags = *flags;
>   		unsigned int mtype_local = MTYPE_RW;
> @@ -1289,8 +1289,8 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
>   			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
> -		dev_dbg(adev->dev, "flags updated from %llx to %llx\n",
> -			old_flags, *flags);
> +		dev_dbg_ratelimited(adev->dev, "flags updated from %llx to %llx\n",
> +				    old_flags, *flags);
>   	}
>   }
>   
