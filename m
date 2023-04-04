Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB41C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7CF10E2B0;
	Tue,  4 Apr 2023 16:21:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5989610E2B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vje/aekOU1okKvqFpBX6U7ZInHILrQ/0cHu3E8/KkYqR6jHrizh/DUfXMLTAHDZNJSIdNXeRCKqbn+90G+bHxD0HxP8MNOafTW5fogiS0kLMd8SftKCEJvjTHFPi7GQ7+QWtYufBn4laHsfWzv5qDuG7e++2XNfB04FdnxdvOnqg7K0Qzhj+0fGxX2XYPvu1Vx01VZWZW3Dc9kyLtj0jEUvIkvDcvmwwg6cKnMio+vRfILhUM0QgmOt5krfm9j/v679CyC2YFkt6XeM5t5WQFFbgXHyvEF6rZ/KENokKE2Vufr6JUMWZlKcasq+ik78fGvbE82mgvdTQUg6L5wHQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl5pHxDkDiwy2gJKL5Zl8m8Ewrd7OZswv96aZOniHnQ=;
 b=nperdCAJUfATsRcnDlxNUBnJGSnPlG3KFM24dprxNaHtI7h/BH3BXhr1Jk6JH698ngObQUjRLXnU792w6TM0pCDVOt/pSrck17bA25t+K5QFP3oa6ZCPCig11v/g1kGVTm7SmkIIdGjkgmZ8vth1gq5/XYj7gSgoGEm41yjVdfR+sr5T5/v97Eion8IgawQADTmFRhy2Fc/8iqYZ2KqAKJZRJfm8uK0nUxZu7AquZ6eEg8zKAAzoZQh7X6l/+cD9uyXy7KsiRE5Sf7jqII0ZOhMktsjJ3JcF7Iom1Y8m9anzpvoYJ92m/bVLwyaRAwI4zIlmOyPj/DSknO63Rr+u1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl5pHxDkDiwy2gJKL5Zl8m8Ewrd7OZswv96aZOniHnQ=;
 b=wqyoIVi66vt8DjsAPNE6rNIX2T6IrJ65JXS4Wvjzp/Sp94T5hyvjyUfoUKP8DBMedeHQyOPGEcQTWeZwRyv+ckb28yNpmzgsvZ8q/L+c/FEGVFlAZWnL/oilx1tmQ96tqRHlNqeOnv/tmx+tycB9/+/KEMEzGb9GQABEjndfoRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Tue, 4 Apr 2023 16:21:41 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:21:41 +0000
Message-ID: <9dfc91e3-650d-4ad4-7501-96aeb73c0cf8@amd.com>
Date: Tue, 4 Apr 2023 12:21:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-5-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v3 4/9] drm/amdgpu: create GFX-gen11 MQD for userqueue
In-Reply-To: <20230329160445.1300-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::8) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b147c6-c366-4177-8710-08db3528ac8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRPo635wRI1MFYN0I8tyh+aNY8XSXOfEE0vyk4w2t/wKUPHUPAM4LMH/kVOWmMi0+LGgVaqGQ8a7z04/27VKHBo0Bct/v4JEWRr79rAdK3y7beEET9oTR9w3bHdSDvcPSeP/jSfdKIeeu4XT8k2e9QoN7v0Tjgy28yktrrZUgzs6QNXRoqzY1dUbwZmrNiItrle7aFTDL1GL+VTPQ6vVd+fFTWMCV33JiecWHA0+/gcPVHd05DcKtVLIoyA+/ZVzjmvE+XRbNYcGmYLRng7gzM0Q/GAOFLWOH9BA8jcFnrsvQPFZJUUftq14Yy2XQfeUfVPUDPBwbCEUOo5ZVIGuPVFrS0TZfoJwtzDvuERTXR23ws2fgCgjgtiR5YDzGwUk0nIAvaYsayj798Q5WjcbRHV0pdKrdiyRLWzMkc0FT6O1JikhOcXBuCmQ1Nsq41I+IBD2eqGz5BXT5t4WDS9IKp9sIvvIJe9lSpzdk/3Ueo4C/nVER8trv49htepM6S0h32qumKTD74Shz0e02MqXGu7tOW1MGfW334UGBtmfRbwDuKlVhgH1jrC5v2GYupl3PuX2xIpr/AwrFXkiTOUGgkj1ALGydOIcbBVc3ScbpOtieoJMMgBsZOL3uS7NXITgHEX3faAwAidFW6P/5hq7x5la5gNWtRoSL0Zk2ycCnJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(31696002)(36756003)(38100700002)(86362001)(2906002)(6506007)(966005)(6512007)(26005)(53546011)(55236004)(6666004)(66946007)(41300700001)(66476007)(8676002)(4326008)(66556008)(44832011)(54906003)(478600001)(5660300002)(31686004)(8936002)(316002)(83380400001)(6486002)(66899021)(2616005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0YvR1NhZGg1R2hpT3lWV0dESWw2VnBrd2pzTHNhNmI5SEQ5b0YzWFRkVU1u?=
 =?utf-8?B?eGcvYTNtSUszUWJYZFFGSVZnSm5mYTYwYzhIRStIWGw0TitpMW8weU5nUllq?=
 =?utf-8?B?Nng2T01aL2w1TkFZeERCUG5nZWY5VXFjc0RsaHVOTjlnaXJxSlFiWTlURDhO?=
 =?utf-8?B?MHI5QUJwWk9BbjNNWmtoekVZb2xoTVRPYUQzeXh3TEVJeFg2OVNCMFBtSkRX?=
 =?utf-8?B?TWNISkVSanhJQmxUTmQxNDR1bHBpZy9nczAwbkZUMGNhK05lb2dXYWFvb1Vn?=
 =?utf-8?B?TzhNayticnY0SmhPQUR0UjFzb3JZME9yRTFTZHlHS0xkWDdwSGtkQkhRNnpC?=
 =?utf-8?B?SzA2b1FTYmwxcEpBaG9jY0EvTUpwbWNPU0NlWVNnVVJwbHYyR1c2YUJPRXFx?=
 =?utf-8?B?L3c2Z3VaTjdQc1RPUFNNNi92Y2xUM2N1YXArcHVGUDNVMUExdTFpdUE0S0lK?=
 =?utf-8?B?N3hCbXAva1Nxb2Zwd2NPNHJORXdIellZbjlNcWZYeEk2SGZjQ21rbWtmYkd0?=
 =?utf-8?B?QldXTElmajlYMzNGcGNxb1FWVjhHY0JWZFRQQ204V0d2SHF6RXJCQ3lOeUgv?=
 =?utf-8?B?ejdvcFNjUkRYeW9TZTFFSUp4czIzUVdtM2R4TTJjanp1TEJ6blJrbHVaWjlq?=
 =?utf-8?B?V2I3N3RQTmFiakt2d0xtQzgxeXc1cFR3Rm9MaHJtamtVTWNkL3U3WitVMHBT?=
 =?utf-8?B?bU92YzR4QlduSER3Y1ZiNm9Ia3dRbnhOVUM0YmdFRUU2dVB4K3pnZUZWaTNv?=
 =?utf-8?B?ZmhWUXBHUlFHZ3E4ZUlFeXdZTjFoQnNrcUlERGFOSmx5QWFoR250NWNCdm9D?=
 =?utf-8?B?RVZCK096czg5RGd5N1VrMkRxYWN3M3R0Kzl5V0ZMTFIyVVZheWo4Y0FKUFdx?=
 =?utf-8?B?ZzJJaDZoTm9RSERER0NQRVp1TVBHMUZVeTZUdDhacHVJUzd6SjUvaDJaZy9C?=
 =?utf-8?B?Mk9LVWY5aEM2WHppYnFnQitWVmdJN1dGSnllYkcybC9WYm1JRE9najdmWDJp?=
 =?utf-8?B?NFN4L0JaV1VRemo3RVpQb0dRMEFsWDhiZEVNVFdBMlk1VWs4enJWaHAxbnAx?=
 =?utf-8?B?VzBZcFUyU3BLcWhzNXhKQnVkL1JRU2JXSTFvL0MzUnhNNzM5YWtlemw3THN0?=
 =?utf-8?B?R24xQnRYQVNSR1pIaDdOYnZ5Z0JQbWxSSWsyWHNDd09sUjBGcS9jUlpCNVVW?=
 =?utf-8?B?cFZvZzdqbnFWVHh2bUZ1UWkvQlkwYXMrQUpFV0xCVEF2QXhMZGUxMkwzSXMy?=
 =?utf-8?B?T1paUTV1S014Z2g2NmpuaG5JTUhjVVhVUEMwbW9FVWxwSDluYkRDVStUTzRB?=
 =?utf-8?B?TXhDN3p1R3psNmF0ZENTdmgwQVBQRkpoUDZ3NXVVaDlYaVdndHFiWjlPbkNj?=
 =?utf-8?B?Y1dlSmxubzA0bnRBTzArWkwyYyt6bnZwRFZDazl3ejVBNndXWkxCTjR6YjJv?=
 =?utf-8?B?SnhPb3lTdFJqQ1lpYjB5aFZjbmkwRWN0UUVxTTZTeW1UM0lUSHd1cHh0eTls?=
 =?utf-8?B?aE0xSmJhbXVJTkJBdlA4ZUZSelcvaEt0aVJBSGlSeFRCYUtZKzhvbld5UFJk?=
 =?utf-8?B?ZC8vczJGSFpBN2tla01JaG1JWmNKSUJQUWJvY3ZHTmRDYVJxY0NaRzdOYjNk?=
 =?utf-8?B?dkk1V0F1UWVZeHBGZ2FQT0h3RkxENDhySk9oZ1l0VGcvTjNDQUF6eEl1aFFq?=
 =?utf-8?B?K2ZSTCtNUHVGNHVHUmcxNDYwaEN3ZGZFYlM3bnJvbEhad0dJQ3FGcTVwSFZW?=
 =?utf-8?B?dXYya3BxYnFSN1pSVzB3MlhSbjgwazF4dllVZytJWFZqQWZsUGZlTUVVVDNF?=
 =?utf-8?B?SjlEU3RlaGNNdWF0Q1ZwSnFBU2JmcFpQL0tWbDREaFVKaWpMV1hjczViaXdE?=
 =?utf-8?B?Rm14U1RyYXFKblRlemZNMXhlVWdXSXgzbTVJemk0K1VIVDBFSkN0WE5hSERx?=
 =?utf-8?B?L2VValdUSHcyRGhzOGZVR2o0YnBURmtyNUx4T0hmcW44dy82MzVDcmJIam04?=
 =?utf-8?B?a3JSRERkL0hBTnM5M3JHNFMzQjJIM29UWkYzVGZLdjlBR0lHaHF2ZmEyRWEy?=
 =?utf-8?B?RVF6ZEhIa2RlckRYdElmd2dwaTduUlN0MjBrcGdic2NTVnBWOFdBU1JaWUdR?=
 =?utf-8?Q?kX/SCoYP+RcAFuSJzns+1N+UI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b147c6-c366-4177-8710-08db3528ac8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:21:41.4310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt7cU0dsFY9c+51M7okf0rJ59XKy9yGy+tLQuWnmFgw+b/9D+EQ3CYgGSPWMoCr7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-29 12:04, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
> 
> A Memory queue descriptor (MQD) of a userqueue defines it in the harware's
> context. As MQD format can vary between different graphics IPs, we need gfx
> GEN specific handlers to create MQDs.
> 
> This patch:
> - Introduces MQD hander functions for the usermode queues.
> - Adds new functions to create and destroy MQD for GFX-GEN-11-IP
> 
> V1: Worked on review comments from Alex:
>     - Make MQD functions GEN and IP specific
> 
> V2: Worked on review comments from Alex:
>     - Reuse the existing adev->mqd[ip] for MQD creation
>     - Formatting and arrangement of code
> 
> V3:
>     - Integration with doorbell manager
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> 
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---

Don't break up the Cc tag list and the Sob tag list.

Check out the following resources:
https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs
https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format


>  drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 21 +++++
>  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 84 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>  4 files changed, 113 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 2d90ba618e5d..2cc7897de7e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
>  
>  # add usermode queue
>  amdgpu-y += amdgpu_userqueue.o
> +amdgpu-y += amdgpu_userqueue_gfx_v11.o
>  
>  ifneq ($(CONFIG_HSA_AMD),)
>  AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 353f57c5a772..052c2c1e8aed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -81,6 +81,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>          goto free_queue;
>      }
>  
> +    r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create/map userqueue MQD\n");
> +        goto free_queue;
> +    }
> +
>      args->out.queue_id = queue->queue_id;
>      args->out.flags = 0;
>      mutex_unlock(&uq_mgr->userq_mutex);
> @@ -105,6 +111,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>      }
>  
>      mutex_lock(&uq_mgr->userq_mutex);
> +    uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>      amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>      mutex_unlock(&uq_mgr->userq_mutex);
>      kfree(queue);
> @@ -135,6 +142,19 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>      return r;
>  }
>  
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> +
> +static void
> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +    int maj;
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
> +
> +    maj = IP_VERSION_MAJ(version);
> +    if (maj == 11)
> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
> +}
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>  {
> @@ -142,6 +162,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>      idr_init_base(&userq_mgr->userq_idr, 1);
>      userq_mgr->adev = adev;
>  
> +    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>      return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> new file mode 100644
> index 000000000000..12e1a785b65a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "amdgpu.h"
> +#include "amdgpu_userqueue.h"
> +
> +static int
> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
> +    struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
> +    int size = gfx_v11_mqd->mqd_size;
> +    int r;
> +
> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_GTT,
> +                                &mqd->obj,
> +                                &mqd->gpu_addr,
> +                                &mqd->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
> +        return r;
> +    }
> +
> +    memset(mqd->cpu_ptr, 0, size);
> +    r = amdgpu_bo_reserve(mqd->obj, false);
> +    if (unlikely(r != 0)) {
> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> +        goto free_mqd;
> +    }
> +
> +    queue->userq_prop.use_doorbell = true;
> +    queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
> +    r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
> +    amdgpu_bo_unreserve(mqd->obj);
> +    if (r) {
> +        DRM_ERROR("Failed to init MQD for queue\n");
> +        goto free_mqd;
> +    }
> +
> +    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
> +    return 0;
> +
> +free_mqd:
> +    amdgpu_bo_free_kernel(&mqd->obj,
> +			   &mqd->gpu_addr,
> +			   &mqd->cpu_ptr);
> +   return r;
> +}
> +
> +static void
> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
> +
> +    amdgpu_bo_free_kernel(&mqd->obj,
> +			   &mqd->gpu_addr,
> +			   &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
> +};
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 7625a862b1fc..2911c88d0fed 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -27,6 +27,12 @@
>  #include "amdgpu.h"
>  #define AMDGPU_MAX_USERQ 512
>  
> +struct amdgpu_userq_ctx_space {
> +	struct amdgpu_bo *obj;
> +	uint64_t gpu_addr;
> +	void *cpu_ptr;
> +};
> +

Code is very readable when the name colums are aligned:

struct amdgpu_userq_ctx_space {
	struct amdgpu_bo   *obj;
	uint64_t            gpu_addr;
	void               *cpu_ptr;
};

And for the rest of your patches.

Regards,
Luben

>  struct amdgpu_usermode_queue {
>  	int queue_id;
>  	int queue_type;
> @@ -35,6 +41,7 @@ struct amdgpu_usermode_queue {
>  	struct amdgpu_vm *vm;
>  	struct amdgpu_userq_mgr *userq_mgr;
>  	struct amdgpu_mqd_prop userq_prop;
> +	struct amdgpu_userq_ctx_space mqd;
>  };
>  
>  struct amdgpu_userq_funcs {

