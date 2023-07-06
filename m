Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F3BEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C40A10E3E0;
	Thu,  6 Jul 2023 13:23:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758EB10E40F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGt88qRsDugBSmwB9QpKjSZXfaA1W8Y5VEedogwT8a/Igg3w5t1K42IvzmMoB3vckcxwKsM3iPxZbRFeamn0f6Swv+pzK6E6gwCfLA7j+c4NL/yvE4YAKqStR2WkKrhnlQYChVc/QCpFAiQclf3kGpqGP8qMd+pzLBSrcJVvpOoeebvbLd6384H14J0xNd8JhJ8hJl5ZozihU97Cqs7k0j5fe6vlajgP4/pYVNmsZZ3DiHeZCuugePzGkgpf2kbsXjaCrUssn8TEE2t/cCwu2mFXo0Lb0+MXwqt5+u/Yo7eBn2uc7LJdxbNgfGQtBaybNIFpTtoo67pKLpW+p0fEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akCan8ZqxtjI6AVRzYlx8CYxRiNjOLzd1dJhvH9a258=;
 b=SfiTQDwTyqOZSKi0bF1kH+lN1nf5nnD1FJriNIBM78AUQnoYauKDrpblok45OCVkbJ2xngm1O4b1JFiP7hC/vF5PpJwho2kZk41YmzE8bdv5IyWOCub0z2+X/VAuBWG2hmKnLsjLWuayB8BF0r+mBehrT/9gdz9hMEtk4i3pn2K3aiZYTwopOQL+RBgY9BG/M326abksbn7vFfGb/i3YQPaUOnKAVhijx1D4dle+Wcy5Edo8hDVxZQazTIJOxHkKJgvX1se1jstSSTntOz0p+gQGHO2RBRnPVtfzVnfaKZsijpDttBWxO925woja4CDP0zkpFhiKVnzGe+HPRKRK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akCan8ZqxtjI6AVRzYlx8CYxRiNjOLzd1dJhvH9a258=;
 b=cUU4MiTA6UXCaKLNpWp2G+aEHel10z70iK7GjwVmRvvNZhcg0pVmkHLzQIFhmjrCqvy240Fwpve5adiRIeU9dSXiki5oCXLkDOCmbvycOu+0FBfZTqUSkNWocUYjQhg3tJ2DZcI76dexGIvh9+NwVx88R3AiXubIltiyBrCciQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:23:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:23:00 +0000
Message-ID: <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
Date: Thu, 6 Jul 2023 15:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706123602.2331-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 717505db-e60d-41a6-8f86-08db7e241ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tv4a6BSByiCMKYxgHhfDARgMZUuhNv/5lpmfF3KbB7PntCLKeN/CFOBS8YoiTW3K61JTdqcFtCTLXxVy4Xo5RgtdqMKDR5oNzmt4SkNKfWA9Iw5e7EdtHSNMxcqqU7ft9QrojxEYiUOUtSB/BPs9U44Z9We9I6AUlwBaLu9Xa2+rW5Lyb9LwcnKbeZrLYR20zrBnj5TA5hpfGmF7u+0AhWHU55/xxSG6h4m547bEIqtusx+xKVYLBiUZQkkkALVT/W7GUDAv/s/ZxCwt0XBFQV5lA8g6jrUxKVsfG/YgpyKUkDEVEtxoo9h3QYsbTJkrtFNcwAYm77Erdmb/IM9TnaaCCkJJLMHBgGxuEU+5V9A9fkwnwJUF5PiUl/FqTs5zxUAROUGIcFpZNfKHoN6gQLGtEcXfMVGyZywU8PLZv1rZwxYX9H14GkLbCoFpKU4XVCExQm9UR0MXNNgYVOGXGa0Q7bLgEBEmksDzpPlna6UQzw+hBxMRwdiFcOqF3DA8k7Q3EjrnSncUwUZQsdTp4xj6LaU8WawpuVShionKRRjrC2P+xx6JZ7xdsf3f14M9l5aYe6bxrT7591euWh09OgPN9olWIJQmwJgp9M/+NrMAgDommPLnLp1rDO+Dr4OVHyBFQd2ljxkjxv0IBxMFvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(31686004)(6666004)(6486002)(478600001)(6506007)(6512007)(186003)(4326008)(36756003)(2616005)(83380400001)(66476007)(2906002)(66556008)(66946007)(86362001)(5660300002)(31696002)(316002)(38100700002)(8936002)(41300700001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emlwUDZWM2N1S0hiMnlzMFJpWUYzamg1LzlSNTN2VzBRV1FmaExiZElGZktG?=
 =?utf-8?B?dDlMUG9Yc1ZTTFNtU2x0NjVZNlZPU0hXMkQ0bnNZVGl3K3RYemYyNlZhNXND?=
 =?utf-8?B?OUh6d3ZNT05jbGdkeCtlRWR0RUwrc0pnWFA2RVhtMFIwaWZXZ09Yb3hRVEY5?=
 =?utf-8?B?c0JmVjV5Q1NKYUxEU1hUWmpkS210c21vSGt3WlR3b0xzeUFGb3RsSXRReS9o?=
 =?utf-8?B?T1lBVmk0a051RnJwVFlaa0xJT2FPMUpDbGVCbERtMHE4c2I4eFVqU1FQVU85?=
 =?utf-8?B?TU1SWWtvaGhHYjFBZkdiRThVWVZYb1RXOW1ycEdBTzhXbFRVQ29OUkVSZG1V?=
 =?utf-8?B?K2tVTUorYWhsaWJTLzBwRzAxTDBjRStnWWRGRHcyM2hmVXZnZ1pjUHRyT0FJ?=
 =?utf-8?B?RUg4VVluZDE4RW5wTlhod2dvalJsVk02OTVEY29UZkpOSjd2KzZvUWo0bDBz?=
 =?utf-8?B?MXV0VWEzdGFXS3VKRFpvSjFXeDNad29TZGVLcytmZkI2VVhhWGlQMm92YmFZ?=
 =?utf-8?B?YkVveDVRUFYwbk5uRjE1M0p2YnBoUGRlbDZWNFNEYzRxbHBnRzNlZUxXWDI4?=
 =?utf-8?B?eHJyVitveC9zTjhzMTRFRzA1Q2tVeG1DTzBGR3dHaURIZlNmS0JzU2ZtMmdl?=
 =?utf-8?B?QmdUOUgxcVVhQ0FTNTh3a1N0REQrTURWNnpKYW5OMGs3OThOVkRkT0RMREtl?=
 =?utf-8?B?TjR5b2hzY1h1ZHBUWCtVWEhMREFHS2I4L3hOdVBYdkpMcHBkUTJQR3F0SGZ6?=
 =?utf-8?B?V1RBeE9SU2NCY3l0VkpNNzhiVTNSWXFMN0dsUzNXOFI4c1FYZXlxeVdxVWRS?=
 =?utf-8?B?dk96T2l5djR0clhQamdQcXhmN1pvL1dGVWcweFQrU0gwYkRrOTJ1OUpJMmFj?=
 =?utf-8?B?NkQzU2l1VlRIeFVpczVGQ0pQMnk0VHBVUUsxQnJBc2VhL21MQlpobngrTHR0?=
 =?utf-8?B?d0NaOVh3NmdOL3NZdWZaQ01RWEVwa2lIbFAxVTBHZXE1dWZNR1lla21ZVldl?=
 =?utf-8?B?M3ZvamJ4M002bE1YOStldUh2VnNJRCswOWJIbnhNK0xoOEpUYUZ6VlZsUW9R?=
 =?utf-8?B?akFEajE2UXNJSWtjUEFDSXdkYVNURzJPWVJwMlAzK0NXWml3WCtsWjg1WXUr?=
 =?utf-8?B?LzFwVEdqWUR4YTczSnRILy9jWWpzUS9hMlJqdWZZUk1VYXo5WkFkdFRlOHhM?=
 =?utf-8?B?RXUvWlhxUFZCZmZQdlpYaWRVc1VwZEYrN1BQOTlGZmpUNUs2bDF2VnIyTVVl?=
 =?utf-8?B?RllLVHNaek5Qa0xReWpVK3dWcC9xaFR4MFlUdkFtSkNRWVo1cy9xcU9hL2dP?=
 =?utf-8?B?U0ExcFliZzhUbndTTUMyYUJIeXVEYmQramVHemxSWFZIaFV6S2kzY1N5S3Fm?=
 =?utf-8?B?VXJ0TWZZL2xFYzRQWENrckllN2JsZ1VCV1dKQkpCazd3Z2JvZy9yWFlTdkdj?=
 =?utf-8?B?S3YxdktCY1JuSnFEa2tEOUpuVUpMZThpQmV0MzYxcGp0eUFYZGR4TG5qV2cy?=
 =?utf-8?B?VUUyY1lLcllBODBibUpOYmtQczlmcTBXQ2Irb2dwZ1dHOEVsTjdMVDR6dllC?=
 =?utf-8?B?MVQxQ0lzbVJjYVRIT3RpN05VcDJNSHJmclhLRDliV3diODNwTUVkR0QzZEV1?=
 =?utf-8?B?K2UxamV0SWhnTXRTaHBpR1RwVVdsQnM0blZVTUJNbUdKTlBDaGJVZlhUamVk?=
 =?utf-8?B?OFpySVdUN3RENDJqVnJPVW5OSWNFSlkvMC9PeVg2ZXhTcE1EcFRVM1pOOXB3?=
 =?utf-8?B?dlJnMTlnWC91SzFYZHhpM0xJVmhLeTZFQWlVRW5xZzVnZ3FYbGM5RzNzZlBq?=
 =?utf-8?B?RlM2SEVCZ3J1MXlmVno0eUhQY1JTR2FkdTFDZzFPTE5KSVFCQzVHNm16YnUx?=
 =?utf-8?B?aUk5Q3JBR0xQMHJYblRERGtGNzg3NTF3Yno2bkM3NlJQdTVQZHdZNHVHbmEx?=
 =?utf-8?B?MUUydXZmVWd6YkM1QVhkR0RyejJRdXJmbUpsMndYbEtaQ04wclo5ODFja090?=
 =?utf-8?B?M2YxbGxtVEtQVXdnbWF1QlQraWE2WXZYLzhGSmpUbUpSTnJIakNIT1E0ZHdk?=
 =?utf-8?B?UG5rV0RwRDBBZ1NGa0ZaVUVDUms4bmxzbkYwWUZpVzBQU203K09nNHR2ZUo4?=
 =?utf-8?B?MjUxYVFqVm5aUzFmTkJyT1pYTCt1MzRRRjk5cHlPY0dCQkkvRFBFaC9PUTB5?=
 =?utf-8?Q?+w9aR3aoWHy2ZoAo2QlTGwa+gUOxLTe5/NLil0riz+4n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717505db-e60d-41a6-8f86-08db7e241ef2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:23:00.8737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itrOKLeuoBP/ZZYdDqeBVfzNmjWTWc6mDHGzyiD1NMHSFKv3sXRe7Cyit8SqsT7j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.07.23 um 14:35 schrieb Shashank Sharma:
> A Memory queue descriptor (MQD) of a userqueue defines it in
> the hw's context. As MQD format can vary between different
> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD handler functions for the usermode queues.
> - Adds new functions to create and destroy userqueue MQD for
>    GFX-GEN-11 IP
>
> V1: Worked on review comments from Alex:
>      - Make MQD functions GEN and IP specific
>
> V2: Worked on review comments from Alex:
>      - Reuse the existing adev->mqd[ip] for MQD creation
>      - Formatting and arrangement of code
>
> V3:
>      - Integration with doorbell manager
>
> V4: Review comments addressed:
>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>      - Align name of structure members (Luben)
>      - Don't break up the Cc tag list and the Sob tag list in commit
>        message (Luben)
> V5:
>     - No need to reserve the bo for MQD (Christian).
>     - Some more changes to support IP specific MQD creation.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>   3 files changed, 96 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index e37b5da5a0d0..bb774144c372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> +
> +static void
> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	int maj;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	uint32_t version = adev->ip_versions[GC_HWIP][0];
> +
> +	/* We support usermode queue only for GFX V11 as of now */
> +	maj = IP_VERSION_MAJ(version);
> +	if (maj == 11)
> +		uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
> +}
> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
>   	mutex_init(&userq_mgr->userq_mutex);
>   	idr_init_base(&userq_mgr->userq_idr, 1);
>   	userq_mgr->adev = adev;
>   
> +	amdgpu_userqueue_setup_gfx(userq_mgr);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index c4940b6ea1c4..e76e1b86b434 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -30,6 +30,7 @@
>   #include "amdgpu_psp.h"
>   #include "amdgpu_smu.h"
>   #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_userqueue.h"
>   #include "imu_v11_0.h"
>   #include "soc21.h"
>   #include "nvd.h"
> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.rev = 0,
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
> +
> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
> +				      struct drm_amdgpu_userq_in *args_in,
> +				      struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_mqd *mqd_gfx_generic = &adev->mqds[AMDGPU_HW_IP_GFX];
> +	struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
> +	struct amdgpu_mqd_prop userq_props;
> +	int r;
> +
> +	/* Incoming MQD parameters from userspace to be saved here */
> +	memset(&mqd_user, 0, sizeof(mqd_user));
> +
> +	/* Structure to initialize MQD for userqueue using generic MQD init function */
> +	memset(&userq_props, 0, sizeof(userq_props));
> +
> +	if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd_gfx_v11_0)) {
> +		DRM_ERROR("MQD size mismatch\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), args_in->mqd_size)) {
> +		DRM_ERROR("Failed to get user MQD\n");
> +		return -EFAULT;
> +	}
> +
> +	/* Create BO for actual Userqueue MQD now */
> +	r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &queue->mqd.obj,
> +				    &queue->mqd.gpu_addr,
> +				    &queue->mqd.cpu_ptr);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +		return -ENOMEM;
> +	}

Using amdgpu_bo_create_kernel() for the MQD is most likely not a good 
idea in the long term, but should work for now.

Probably best to add a comment here that this needs to be improved.

Apart from that looks good to me,
Christian.

> +	memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
> +
> +	/* Initialize the MQD BO with user given values */
> +	userq_props.wptr_gpu_addr = mqd_user.wptr_va;
> +	userq_props.rptr_gpu_addr = mqd_user.rptr_va;
> +	userq_props.queue_size = mqd_user.queue_size;
> +	userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
> +	userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
> +	userq_props.use_doorbell = true;
> +
> +	r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize MQD for userqueue\n");
> +		goto free_mqd;
> +	}
> +
> +	return 0;
> +
> +free_mqd:
> +	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
> +	return r;
> +}
> +
> +static void
> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_userq_obj *mqd = &queue->mqd;
> +
> +	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
> +	.mqd_create = gfx_v11_0_userq_mqd_create,
> +	.mqd_destroy = gfx_v11_0_userq_mqd_destroy,
> +};
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 55ed6512a565..240f92796f00 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -29,6 +29,12 @@
>   
>   struct amdgpu_mqd_prop;
>   
> +struct amdgpu_userq_obj {
> +	void		 *cpu_ptr;
> +	uint64_t	 gpu_addr;
> +	struct amdgpu_bo *obj;
> +};
> +
>   struct amdgpu_usermode_queue {
>   	int			queue_type;
>   	uint64_t		doorbell_handle;
> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_mqd_prop	*userq_prop;
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct amdgpu_vm	*vm;
> +	struct amdgpu_userq_obj mqd;
>   };
>   
>   struct amdgpu_userq_funcs {

