Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FD5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 23:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A088989E52;
	Mon,  7 Feb 2022 23:23:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF4910E1A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 23:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTWSX8aLF1O1pyUIphAVp42nb99+7Bx15u5+vLtMuYocftFf6D6FS/euxMKCCoJxP/sVQ3TkPojYamckeU8uoBJh7a5KwK8lx3gsEqM8QUQDWm67xPzoZcKHcAmEvUTEABnr78IlyzhAQufzJRsJK26+o2dZM8GcLoaap5Pd1VDNVjcoZfrW52gPIawxClyO09fUgUkeWsla3vhUtz4ivqFIzq4+Fbo7jqnF1TPs5j96nDwV1YuBWLVAANtITMbY3UHAiNSuuYvlEJbTXea5voYLeuIyUQzwLOO9fBsZgtAQZSHYKrsEtFS79CfympXl77UZ+FRiHMVh3+XfqHGmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZKqjLgjjJfTFTifQYgyGgvkQdOj4iIaKuzsOdhoG1A=;
 b=ml1r3T6h6PwYXIvlHPdHgdw1mRjNVZx2Wg9Dl69RU8NTkVYUZ/apCHqxFoEn5ZxjQPoqDo25OMwSPTqp8wZ+N8hfZ3AGEd2qD21kKaTfa1HmYIcW3p/aOgxyIz9v4lXgU8ERLK7chEOpHKpVnbwQAekVKbjVM4lZerVpSn0YK8vNIn4738aGgC7pkiFXg5xRSmUcBlZ5N0+9rPFjfc2w+aVUKi1nXBkVA3rttef1dYlLFphfQ8bpt3h03ql0Rsut03n6cRZBWvvg1dtRZCaehw8NUAI9KPA5mg+znLy46RNs0QRAgHftXksqAoocpx2rl536whNImM0a7L5pOBkdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZKqjLgjjJfTFTifQYgyGgvkQdOj4iIaKuzsOdhoG1A=;
 b=zz6N76TLhU5+RRrPVxXL/l8ww8gyPxjjpDA/S4C/u7AsEd+quljgAaOcPALuVfgQiFuVwMBuICZ4DoQ4VFXcWtDEEL4/ysQ8so07p5uSnlOdgs0DjX1yikTCIv+29yQFJBjL0MULIPrZfuiD/vHWb2itz5CWeENDL3X7Mbi8V/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 23:23:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 23:23:52 +0000
Message-ID: <058bba6c-4bc3-7090-4ac3-612ff811f358@amd.com>
Date: Mon, 7 Feb 2022 18:23:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 1/3] drm/amdkfd: Fix TLB flushing in KFD SVM with no HWS
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220207195237.11605-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220207195237.11605-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5e34f07-39e9-47eb-c812-08d9ea90e6ea
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB522308ACAD84586658E88692922C9@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJxW2WhQxX0KkUsPCynG3PK8mQZW1/Km19AiL1mzXq3nVZez8D1jARvZ+Stei/7JgI3SKdz9cmC9DJRj7gJ+rUPS/fAeAkkM2pJ0oxhWohoPlB88EMtZdODA1dPcc3NzXnMie5XcMnQezRTR8NzQ6cGJKBTz0eD+jJz4+ruQtMD29ZmdoYEwh4dyGZdCoZKR+OoZSVxQ7yVIYDUKCW0q6znJKi+SX515dhOwnk8r738VBZjazlBtaBofLNNwaLrrelnh8GBVWlp5zWtJNKlPYJb2ZPqPdNV5vgGgshHI6KRv97Xx5mxTn++zY9EPFpED1/DeFliaSHQ8OmPOJtpPogyauRfMCbzKsQcsxzRdDRJiTK0aLyFLg6lc+uGGEVVzBB9kVzLG9HeAvwqKUckFSMoevehlkTN0QRhatOA78RayN2RHwo3Gc/MWkaAvcCGnAXPcUBLG+xSlSGkpcrQoDx8Wf4GB3OUTB0RVfrTXpA+webRLoEE0YJlCIu7NZIMdNGkOjQ1BTNJ8QyBxrgyuaheC1g8rpda9h0bu1HQ0q2VuCIPcU9D/Tc615JhQLhQJ0EmDEhq2fBpz9fJpCw9EZuSQTMDoWsoQJSGU3JphEagVOfVgtog5SpzDr1rykrWYYFiU2NGbO0U8hgMevPE8qkleTmv0yOT334clDvVOanFKP4BOQ85VRq/T2ylRtdtzp3tZ1/t+tA1xWNX3GcX+YDn2Xynhcu7ulX+DJgRkwqGQ89mDiDuJUNIbvZFoH4sN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2906002)(36756003)(31686004)(5660300002)(38100700002)(44832011)(66556008)(66946007)(8936002)(66476007)(8676002)(4326008)(83380400001)(6512007)(31696002)(2616005)(316002)(508600001)(6486002)(26005)(6506007)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzR1YVcrMUFDVHo4N0FoWENTK3AvRWpmSHMxUW1XL2QwU3RHN2I3dmdmS1Ns?=
 =?utf-8?B?dkFpeEptNjZKdXBZTlhPalBEcDNna0RRQ0ZKZmtsRVZKYVBUQlpjY2JxbGNY?=
 =?utf-8?B?OUVKV1F5ZVBYd2VwOWNvNHBtYjdsamtvY2FsaG53L2M4MjZXNCsyNVNNMEdj?=
 =?utf-8?B?Z29EMlNKWlp5am85RmN3anpiYUNnMUs4WEpCTTlvbmJ4YWFNY21tZlpVdUdT?=
 =?utf-8?B?Qzg5Y3JaWi91cjc2QlpqYkpjUzVnamZPU2VjK09YMVRKMGNRMXRITUJ6dXg2?=
 =?utf-8?B?ZXJuWHZhZzk4NXc1R3E3dWF1V1VDUjVaSzRVTkx1Vy9GMHlQY2xXMFNxOEpB?=
 =?utf-8?B?VlByMWNtSjFjbkFnTDlYUW1rMEk3NlppUE5XRUtXQStoZ3pXbWt6eHlTOWJi?=
 =?utf-8?B?ZHg5ODFFVzRpM0NqeVIzbzhBQWgvMW1nUXF1QTB0eXkyOTRPMWtCSjhBamRm?=
 =?utf-8?B?NC8xUVQ2MkV6TEJoVDE2Sy85Q0RLdTRkR3c1ZTU2NWJ0QzZIQVBQcEFvMklM?=
 =?utf-8?B?RlhqdG15dFB0VDZtcmxSVnR4Q25zZnB4Qi9MVWRPMmZtNWs5dFBrU0R5YzZZ?=
 =?utf-8?B?a0FqbWM3OGUxWEl4RjNIQVIyejAwdnJuTSt6NlVpY3ZiYnZxczhodTN3b01z?=
 =?utf-8?B?QTBuSUYwdW53TkVtVjQwTit1SU4vSVhycG4xT3JVeEtDdVFEd2dCS2x3bGl2?=
 =?utf-8?B?QktMOW54cmJZcUNEN3U2aXdUMFN3Z3E3WEVkVUNNUFFCUXJkbjlyZFh0eW9U?=
 =?utf-8?B?SmhEOWdUTU9JZEM3Q0o4ZFBtUkVJQ3BXbjd6Q0ZabXVpdkNDT25tQnN0ZXcy?=
 =?utf-8?B?Tnd1L3ZKZDNWbVpxSzBqcXRyQ0tTR3oxSUJTMWIyVEV4amJ6eGlDazFPZTFh?=
 =?utf-8?B?KzdYM2c2V0k2cDJnOUc2Mk5CZDhvNlkyMHZxREliZ1pHU0JGeTBMQ2t6ODFG?=
 =?utf-8?B?TWpBWjNMQ0k3TjJHUFl6MGUzVk9RbHM2UmdVL0FVb1c2SlhNSXBOdmdYZjlK?=
 =?utf-8?B?TUVoSmVJMVhMR3k3VWFNRXA4WjhNank0SmtsQ0ZVVVlqemdmTXlXMTV0S3JX?=
 =?utf-8?B?dXBzdEw0MFc5Vy82RDFoazV3UVQwelF1VmxaMEZNTmdmclE1WmxaM0RReGxk?=
 =?utf-8?B?QzFPWVF3NGFoc296SWFUY0hZZUxLQVlTdjZXWkp0bW9sWHJBM3Rlbk1ibnhp?=
 =?utf-8?B?b3Y1cytQTUY0YTVrN2x0bzZTQzJuYXlHNDQwZWJlYlZ2c1lJQ1JONEFmVG1R?=
 =?utf-8?B?c2oxZ3p1NUFYdEdkTDRQd1NJQmlRUUtMOWhITmowU2xmUFk5TXFjNzJVa2Uv?=
 =?utf-8?B?WldJTmNpb1B0M1VBd01meHdaRWQ2WFpyUEJqbmFxWEMrNlFPVHk5NVVURVUw?=
 =?utf-8?B?ektQRWZZMUd4ZGZFNlV2M01RVnUybnBCNE5seDRtQ01lY3loUkwvMmFOSk00?=
 =?utf-8?B?bVo0RnZEanhMTng4L0FxVlhsS1NKQlpOQzVVKzhMVktvU1hmMjJIUTdBSE9B?=
 =?utf-8?B?QjBENWxTSHljUVVmejhvemMvR2U5VDVWRG5yMzFUT0tWbWFRT0w3MXdqOHpv?=
 =?utf-8?B?QXVBV1VCYWY1YkwyUmpOc2NmV2dHUi9GR3IybDMyVW9GSVhTMWE3OFgweTI2?=
 =?utf-8?B?bVNnQkRQcW1Id0toSXhyR0RoWlJTOXRGbGNqYnYzS1RjU2JSZ0pWa05UU0gr?=
 =?utf-8?B?RW80Q3dzNk1TNVp2b2piS0pzY2M2OWU3TytlWmJwcmZzaVdkYmYzMVg1MXJE?=
 =?utf-8?B?Z1N1UVRyclowKy94MkM3d1Q0WHEyWnNXcmZuOXVjZytLTUhiM3cycGJZamZ1?=
 =?utf-8?B?amxRdTlkbW9rYld2MDNHMGdGUEdYK0NySEJPeU16WnI2UURDOXlKNXJXc2k3?=
 =?utf-8?B?dGVXcmtUS1hoMDJBU0hibHlRZElrcGhiZ3dlSWJUbURGT0lpNmtrNmpqdnpH?=
 =?utf-8?B?NDRtdThqT0NNcmFQaFFoUTBiVnhlNUNLTFdUM2JiTEJqUWpwZ0xGSnRsWC85?=
 =?utf-8?B?Ymt3Q1M4dW9ablZUaWxkaHJTSTA3OXBCQUJTLzA3MWlnMlA4ODk0dmtoK2Fl?=
 =?utf-8?B?aHFXeHhKSFFVRWh5TElSanhUczBOaHVscTBZK0JjblRCSmJBUmFmMTR6RGZM?=
 =?utf-8?B?WmlFNlkyR2RWN1N6ejg2TXI4Sk12SHFHMDR4UjYzdmVxZ2FXMFRSMy9ld29R?=
 =?utf-8?Q?sut2w+u49l5nBdlQCDSrzr8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e34f07-39e9-47eb-c812-08d9ea90e6ea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 23:23:52.2315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1DlCAAnTqKIIKkCqEwfJR4s/MBgvjTpjbIjBt7v25HcsIWS+102exghAJMN/t01nRvqj9QzCOdkFg2UA0kPzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-02-07 um 14:52 schrieb Mukul Joshi:
> With no HWS, TLB flushing will not work in SVM code.
> Fix this by calling kfd_flush_tlb() which works for both
> HWS and no HWS case.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> ---
> v1->v2:
> - Don't pass adev to svm_range_map_to_gpu().
>   
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 41f03d165bad..058f85b432b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1229,18 +1229,17 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   			if (r)
>   				break;
>   		}
> -		amdgpu_amdkfd_flush_gpu_tlb_pasid(pdd->dev->adev,
> -					p->pasid, TLB_FLUSH_HEAVYWEIGHT);
> +		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
>   	}
>   
>   	return r;
>   }
>   
>   static int
> -svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		     struct svm_range *prange, unsigned long offset,
> -		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
> -		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
> +svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
> +		     unsigned long offset, unsigned long npages, bool readonly,
> +		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
> +		     struct dma_fence **fence)
>   {
>   	bool table_freed = false;
>   	uint64_t pte_flags;
> @@ -1248,6 +1247,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	int last_domain;
>   	int r = 0;
>   	int64_t i, j;
> +	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
> +	struct amdgpu_device *adev = pdd->dev->adev;

Minor style nit-pick. It's more readable when longer variable 
declarations are at the top. Other than that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   
>   	last_start = prange->start + offset;
>   
> @@ -1305,12 +1306,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (fence)
>   		*fence = dma_fence_get(vm->last_update);
>   
> -	if (table_freed) {
> -		struct kfd_process *p;
> -
> -		p = container_of(prange->svms, struct kfd_process, svms);
> -		amdgpu_amdkfd_flush_gpu_tlb_pasid(adev, p->pasid, TLB_FLUSH_LEGACY);
> -	}
> +	if (table_freed)
> +		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>   out:
>   	return r;
>   }
> @@ -1351,8 +1348,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   			continue;
>   		}
>   
> -		r = svm_range_map_to_gpu(pdd->dev->adev, drm_priv_to_vm(pdd->drm_priv),
> -					 prange, offset, npages, readonly,
> +		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>   					 prange->dma_addr[gpuidx],
>   					 bo_adev, wait ? &fence : NULL);
>   		if (r)
