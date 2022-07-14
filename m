Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA8ACCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 15:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FDF113963;
	Thu, 14 Jul 2022 15:40:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51582113960
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 15:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHpIVHYPHzLvtut7dCvV4SkmI5vQ1uD3+M8xTfRnN2ryMfw0/n2FDvjk+b2510MSWEl15iQIPBbN+SjMCdbcA4QvlCNd8h3EL3D/XfAJ2Id13GnrA0yZJyEZrMLPrWpnaH+AZ79/9KsOWAM9j7FxhfH+nztsJBqyIkbpzqEJp3g8hdd1/JV+8fQpDNL8jMXx9dvs+J3i95unXmQTHgymPo348pP2YG2cyFe+WaokGdXOd/RIVIwz4bwru69Fj6XP5ENt+0d0LJX/lphTAXTu8AoAoFQ3L3WjDcBtEjVfOOCXumC7TQet2zMChyK27P0UxnGHmFwdXAIm553g9BlF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohwAzxIlKN4BtL/ldzg5H7QOQNCBKuP2cGgvZD61ATc=;
 b=i+NyHJLYSnDIGBUoSJMJgcp8r9G/4q2YzluvJCgHdbcF4C8Vn4MVs3T36AftjQ3W91sBU0bnnAmn8X1f8SBR6xWOrCIITfaF6V3MDdsq0CHP+IIU++NrRAsEsxxE05UL0InIEVmpupyzq6YkKhEWv4yN5SYyyNo5W1UOUnRucYmBCuoH87KquYm+u5PoRGgIkfIvY7OLQKMPps4DQOnEYjj8WJDOURs/knqoXX+Va3fFRDldcA1hj6dIRZqO7gbkaP/C+oKY+DWeNrZ67LDztIyLU2B9Qoyr9X/p5+1CW0hfGvXUiQySl5+dB9O3MWEsQRO4tB8xfFEZMWYPoyUABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohwAzxIlKN4BtL/ldzg5H7QOQNCBKuP2cGgvZD61ATc=;
 b=RKgQRJ+uv7mMVJZa/kDFuRpmOQLzemKAfoTmXCFHXtM6loqwomT4oo5ZBesUPr9qCFIO0vF69qkSrFlbz/cVcm5mO0DZqA+NBJqz0hUvmmdBMnt+GiWiaIIJ7WRMjkNi0tB+MYfdLGvto+dmL9V1vP6OyjNmcT+dSG1yvLxQEhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 15:40:40 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::40e5:7df9:d8d9:4eb1]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::40e5:7df9:d8d9:4eb1%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 15:40:40 +0000
Message-ID: <84aed2fb-6bcb-b8f8-100e-b65209e4873b@amd.com>
Date: Thu, 14 Jul 2022 11:40:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 07/10] drm/amdgpu: move setting the job resources
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com, timur.kristof@gmail.com,
 andrey.grodzovsky@amd.com, Yogesh.Mohanmarimuthu@amd.com
References: <20220714103902.7084-1-christian.koenig@amd.com>
 <20220714103902.7084-8-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220714103902.7084-8-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::28) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6addf1fc-d11d-4ddd-4d95-08da65af3443
X-MS-TrafficTypeDiagnostic: PH7PR12MB6491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEEYWjf/HKlwlWQCXu3jZSIyHpoB4RTp6oA9u+tHnxrKYmLatnj8hQwgp0Uo81IBgyB23+fBd3WSkoAX1xQRi/ZnCLHINpIME9JdSs5Md5HfahIaJ1ePSBNO3WZa6VoZcl01u6ZDHZzNy6HYZg3E7c57+15cxJa3Cj2fpz03bv7cAhdItP9XhQNz134zojJBopS0TebxJlCuGY0oE75FMBPpdOfQNqwhG3VmUuIjlP995w/nhkgM3AAnWhh1Nzck/ef4V7wJ128JICSPjeNIlMzEqR+fgxl2bEoGSX0UUNEXogzHe8BHnHwTrOUlaAdX7x7jWaM0xAFQUkcYEj+wfsYRzfTCemwJS2J+0GLtb2w+DQzmd3G97FeUI6XyQrJGE38+vn0pJxANIP2gx8rf7bnunnqpyifBGyNP7NUSSBwIbQkDaqZRdFeO2GDVod15ZlCw8ZbWBcGrptKK8xnLfd3UEvryV/vepJgrlIKMputPXg0JkhjLHZboa/Dyq6OdGe36qumVJOfoEJN4+a6TgQgvVRfRNY+xpHDK2Xp23YVejstkV+L8Bpm5ekoxwvFwXeyrhS1JaHs3ymDysHB4I4ffTYC9PfE7qxNPmG6regNEESLklrYJInBQkjw/1H4xFk2zFWr1V2W6rdzV7E2vgI5DI7+s6sxcTyFn+AumD2oCXeHVqhSVROw92dDdknYSG7gOvIV6PaFGnb7o9gRl4E5Ny8hZB7GYvRSXsu8/QViOE0bMqgyZm7eHLdVyyqoOicytrfdM4Y9YQHUnMhCQLqQdpR3E/vG3i0zy8eG8yjJne0LbAPcPE8H0PINk88vmHhjlqeP6yr5ozdvkaiufJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(8676002)(66476007)(4326008)(66556008)(5660300002)(38100700002)(66946007)(2906002)(44832011)(66574015)(83380400001)(8936002)(2616005)(6512007)(26005)(186003)(6506007)(6636002)(6666004)(41300700001)(316002)(478600001)(6486002)(31696002)(36756003)(86362001)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hFSU4ySjFaTXFFK0JWWnhnVEU2TzhpMTIwNEtLMWk5NjM1VWRjT0hWQ1J0?=
 =?utf-8?B?Y2x3TEJYUkl4RTRGQXRQTVBPZHlPbmw5K2hXNlo5K0hmNHBOY1R0aFJjSExa?=
 =?utf-8?B?NUxyR2dqUFcvSlRNVFlTVUppYlZmenVsZ051YVlBRDMwenR6ckpkYWlDaE8v?=
 =?utf-8?B?STBqek1Da2JweGh3QmY0L2ZEbTR5Qks1WXNkYi9jNk5vNWN3ZU1DajFYdmln?=
 =?utf-8?B?dHBrVFJFVGVGS2dvR3o1VjZ1KzdNTHFVcWw0QWpzbnAxWlBNU2svNUtaS25u?=
 =?utf-8?B?N21aVi9WYS96NUplZzV6di9FSHd3SHA5eTZ0UG5DMmp5T203cjlOdE92WEJB?=
 =?utf-8?B?ajRNMkRNNUQ2YXkwdzRqdVpocFZHak9sN29TRlNLcUVUalhaRFhYRXV4ODFn?=
 =?utf-8?B?ZUplUzVUU1RDamxBNm93OFg0WXZkb1JRQmtWUTFKYW4xbHdwc1d1MVRJak5S?=
 =?utf-8?B?Z1c1UU5pbDhJdTkyU3dGbVY0a1NGZlZYNnlDNStzY3R0VkRMeWJhMHIzQWV1?=
 =?utf-8?B?K3pDTUZXcmdIcnZGZzZtUVlaOENLT08wNG1PSFQraHlJRWh4bHdNVmozU1F4?=
 =?utf-8?B?UE4zdWVicmdoSlhFUHJna1padU1vZkh2dzlqY2E1RVpUYVkxeHIxWXZHMU11?=
 =?utf-8?B?NktzdU0xRzU2T2lLZnRVVTEwcjIyK2ozcnV6WStMbDhiTTR4ak8vN0R2K2tV?=
 =?utf-8?B?VDBvNUxaSnh1QzlyV3ZnL2FocVR0UWlYVjE3NVltdmhTRTBIZklGU1JoMlhO?=
 =?utf-8?B?L1M3UGFOWkpCeHAvV0VKKzJaOHN0SFQyU0t0QXVYU1JDY1AxU0F0MHNmZk5S?=
 =?utf-8?B?bExDVGRhTWVsMjNEbjVSa2FDcis5czd0VWZ0by8wdU1VczhoaklYT1hnWmVC?=
 =?utf-8?B?WUtCcStuN3ZzQ3NIMWhYVTBhOUVUM0kwdTlueU9FMXZqWWk5Zk5OWE9za0hK?=
 =?utf-8?B?ekpoSHRsVkRDUEJqWmozR2J0NlZ4VDhJU2k5TW9PR2thdU9wZGtxNTU1czM0?=
 =?utf-8?B?ODF2WG9JR250U3VLUm1KeTZMUDFlTmx6b2tGdkJEZ04zc2I1WFdGdzh1cjdt?=
 =?utf-8?B?OUN5T3IxamdqTFp0RFIrcmZDY0lKaDE3cVBVdXp5VTNsb3NHMVFkaHBFbElE?=
 =?utf-8?B?SmE3cWpRRWtTN0tuejB6QkwvVnZhSE9hZW15VGE5RDJJNHBZc2Z0d25YLzZs?=
 =?utf-8?B?amtpTTJJNXdCOXhLR1BJbE5PS3dlOGFoamxob2syTitmZzMyL3J6Rklxdk9E?=
 =?utf-8?B?aHprUjB4QWxsQzI5aFo5aWpwNTZCK1BjV0VJcnEwV3h5N0tVUk1KcElUWjNx?=
 =?utf-8?B?TXI0Q3hpUnpmWDUxckxNM2IxbzhVa3AraUJzRkpEcmlnMGc5a0xJNldUS3k4?=
 =?utf-8?B?NFo4c0dtd290WUNnOURScnA3c0NCdi9waEprMURjQkxSWnNxTGk0MmNVUXEv?=
 =?utf-8?B?elpiUmsySEpPQnROL2o1Z2xnNFlCaVQycnk1eWJUWEVKVDFxd3BHUVdIL2Jx?=
 =?utf-8?B?Q1JBemFYMnF3UXVXa2QxaC9mRDBESlZsdjdSZHM1L2JUbzMveGdXVFVKRWZG?=
 =?utf-8?B?cDZnWTJWRnRzTk5EbVpKZC8yQU1lTXlLUDhieEU2RDFFdEs4Vys2QVhzMTJ5?=
 =?utf-8?B?OThRWTZVcTBlOGZuNXNFZ3JKNzk4R1hETVNXd29EREttUXdqdVJVQlNpT0hD?=
 =?utf-8?B?VGJTeFY3RkV1OUx5dkxPczFMczROYUJpelRzWm1ucUhUZG51RTVRZSt4L2tv?=
 =?utf-8?B?ZkFJRFg5Mm9iNGd0MWpOZ1pPK0dPWDhjYXVYVCtieDZnamROeHJ5L0tuSnYv?=
 =?utf-8?B?QWc5THNkWDRHZGJydUFQVEkwdFhIUG1IVjRwUHZzdDIzdDZVK0N6Z3oyd2E1?=
 =?utf-8?B?M1Z3VS9lQUVWL09PZGJ5Y29LbjFuZFpKTVFsRkI2R3YvL3owczkwbUVxcHZ4?=
 =?utf-8?B?RDMwd2thOURvQ0owV3Y3NDJTSGZQZ0FtV0NGSk1xcFlyVGtLQ2VGb3J0RzB6?=
 =?utf-8?B?YzRrSmJxRmxFV1M2aUtkYlBMRENLSE0xTDh4L1l2bVRrS1JpNmJQMGVjVHZV?=
 =?utf-8?B?bTdpRHRzRklrOUpvNnJPaEE4V0NxV0JidFI5Y1pqK3lBSmwxbnN0RjU0SkNO?=
 =?utf-8?Q?LTk0W6KZKgVtCHWexI2uxig+Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6addf1fc-d11d-4ddd-4d95-08da65af3443
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 15:40:39.8729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLNO/VfUYqmjmJekCgLATyaFXe2COqogHQosbYToFeCeu28ZkqHwuYyCr6HsBgMC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2022-07-14 06:38, Christian König wrote:
> Move setting the job resources into amdgpu_job.c
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 21 ++-------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  2 ++
>  3 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index dfb7b4f46bc3..88f491dc7ca2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -828,9 +828,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct amdgpu_bo_list_entry *e;
>  	struct list_head duplicates;
> -	struct amdgpu_bo *gds;
> -	struct amdgpu_bo *gws;
> -	struct amdgpu_bo *oa;
>  	int r;
>  
>  	INIT_LIST_HEAD(&p->validated);
> @@ -947,22 +944,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>  				     p->bytes_moved_vis);
>  
> -	gds = p->bo_list->gds_obj;
> -	gws = p->bo_list->gws_obj;
> -	oa = p->bo_list->oa_obj;
> -
> -	if (gds) {
> -		p->job->gds_base = amdgpu_bo_gpu_offset(gds) >> PAGE_SHIFT;
> -		p->job->gds_size = amdgpu_bo_size(gds) >> PAGE_SHIFT;
> -	}
> -	if (gws) {
> -		p->job->gws_base = amdgpu_bo_gpu_offset(gws) >> PAGE_SHIFT;
> -		p->job->gws_size = amdgpu_bo_size(gws) >> PAGE_SHIFT;
> -	}
> -	if (oa) {
> -		p->job->oa_base = amdgpu_bo_gpu_offset(oa) >> PAGE_SHIFT;
> -		p->job->oa_size = amdgpu_bo_size(oa) >> PAGE_SHIFT;
> -	}
> +	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
> +				 p->bo_list->gws_obj, p->bo_list->oa_obj);
>  
>  	if (p->uf_entry.tv.bo) {
>  		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 36c1be77bf8f..3255b2fca611 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -129,6 +129,23 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>  	return r;
>  }
>  
> +void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
> +			      struct amdgpu_bo *gws, struct amdgpu_bo *oa)
> +{
> +	if (gds) {
> +		job->gds_base = amdgpu_bo_gpu_offset(gds) >> PAGE_SHIFT;
> +		job->gds_size = amdgpu_bo_size(gds) >> PAGE_SHIFT;
> +	}
> +	if (gws) {
> +		job->gws_base = amdgpu_bo_gpu_offset(gws) >> PAGE_SHIFT;
> +		job->gws_size = amdgpu_bo_size(gws) >> PAGE_SHIFT;
> +	}
> +	if (oa) {
> +		job->oa_base = amdgpu_bo_gpu_offset(oa) >> PAGE_SHIFT;
> +		job->oa_size = amdgpu_bo_size(oa) >> PAGE_SHIFT;
> +	}
> +}
> +
>  void amdgpu_job_free_resources(struct amdgpu_job *job)
>  {
>  	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index d599c0540b46..0bab8fe0d419 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -77,6 +77,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>  		     struct amdgpu_job **job, struct amdgpu_vm *vm);
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>  		enum amdgpu_ib_pool_type pool, struct amdgpu_job **job);
> +void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
> +			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>  void amdgpu_job_free_resources(struct amdgpu_job *job);
>  void amdgpu_job_free(struct amdgpu_job *job);
>  int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,

Regards,
-- 
Luben
