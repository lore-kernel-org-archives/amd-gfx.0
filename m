Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE07EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B5310E3E2;
	Thu,  6 Jul 2023 13:29:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C5A10E09A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/CQwqgU+Z8mfvmVH3rPjTB0IM56jzfOmwXOrZQyCqxejif5W/bu50d2saTpBLSMgNd/2VqPwJ1rx4AOKMN5mPx7FVn5PYC/a6Fmly2Y7SaV580g0oZqO5oe/3jFdembYjoaaz0UJUzgOLFaCcIniWYSdtdkn+UXeWs41/6yu/Bw6mbNH5tlKc8lSfTSKvpG1kV9rjiLiUv/9q4mL/9aHiAg8TM+8G+Rz/6dB8n3eHckJAACsiKbllakg6psCy6Ovrk6G/1LI5oib2NpEl2vfza7eqS43hrpdArWZtKRbI7fK8buw0NHZWyaNO94s0zeCI43zumoqMIBrtlZIzT5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRjfqAZ7IM2n8Q4XK30PiDWkl4K2dVTAishXiIzAvzY=;
 b=EYaHkCZGq7wxuTvcNie5TOu9OzC+gR91tqeiGcSU1jIEewYzwA03bCm9NrbTPyw0t4HjhDmlrhdGNeFeqsciHIl3L7Qdw2VOiMxD5e+JbK3uEByWMt9AlbVC2qrU3Ww29FPt3JI+pIZwJmZkTbDdPsy7bbAckw/uO6q/0GSFBtSz+3niczUOI2bo9EW5Ha2OeV4AlkzdGW1+YPHEMUbew4sC7KfdfTnkLr3Eh3lWuuSVF5DJ2kKriDy1KHkVR8vDeSQ+aaPuMf+2LmdtRSlVCKZdKEqXIh6LCiWJ7GkElozCuak/eUrCtNd8xo+Ws26fazXWL4BZDw7PESwd0rtnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRjfqAZ7IM2n8Q4XK30PiDWkl4K2dVTAishXiIzAvzY=;
 b=SsxkJRIrkfjUBHk2Jow+5mzTZH3M4Fc6xH32TRAIp7dt+mnYsNMHevcVEr0kUqfr8gwr1GessRmzrYnb1t7/ge/1PxGHDe91ZGdmkiqbx/P4LHFY8dhqr7Bjvm7TvtfyWu8t5//s7U6kdr+0Hq9gPcCl3cSt2/Gj1Wf/QFfdXYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:29:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:29:01 +0000
Message-ID: <5d947a69-d77e-0a5d-5581-1ed4aedec6ec@amd.com>
Date: Thu, 6 Jul 2023 15:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 05/10] drm/amdgpu: create context space for usermode
 queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-6-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706123602.2331-6-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d806dbf-1077-49fd-e2ed-08db7e24f5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVYZhrtCbFet2JFUDr5YsuGxC3aD6tmgrvu9B+W6b74VOOoWvOsUjf8M1XfOxRDE9c2CtFtmwWvUL4FuaXQHQ6h72hnuGexAuIjdDi2UQG2xCELA3Iicdi1amAKKEhwqZM1yJrXY6U+75o7PRI7dCW+34sJqcIloVzUfei0H6uqCaXW2x4e1blR246yGNgLC4oxLfBs4V3/C1tYLPl7CMAbJlsOnb24Fm2Qwjj97p016ORz7CVz0jt8Lga4oiA5GxWkdPNCH5cyuBQrKEWMt22h2d8cBHGM8r9h+5+idtd+rlYOJmOP91Ivy0kAHkokzWrmokFXabQodjBTlSX3UijvGqXqVgvjPBbPRZ3bO4Ee1qs8ZQ+pbefaRSzpbkxyoornIgKuuASJVIMM/hVspj2vb0MW6MyPVLmoDqLc9AHPBTi4z8nIm5Xk5c+Nw/Buu+2Z/zbDpa/E+8qvcdtre7MhDj1M5DxDic5jVyWoeDJtT0Xr3Sot1PN4yGi3gSKAfnpu0ITCD60tOnhmWZ+mjk4bnCGfZUY1mg5P6obMW/UU1MmnfhEeFoz9EeTRTB3IvDM1FamMrqdMznn5MXL8Q2r6xA5wIy0nvtq9NknRQDFsG9ZSOkHHOiuDvYC5Bwcdduk9PCL9jxQXmjbEQ7z/PlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(31686004)(31696002)(316002)(36756003)(86362001)(38100700002)(66946007)(66556008)(83380400001)(6512007)(186003)(2616005)(6506007)(6486002)(478600001)(6666004)(8676002)(19627235002)(41300700001)(4326008)(8936002)(66476007)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3lNTk92TjNlZDN6TnhRUzlTdEVnbVZsTTZ6QkZpais3TlZWWlVmVEZJOThK?=
 =?utf-8?B?T2FVWmNXT2tpQVNtOVhIVEdPWVp3bjJ1R2VselVnRUhmcXI2TXJYK2FOZmp4?=
 =?utf-8?B?ZXlFWjczSU5nMzZHV3dUUlUwcVRRQzFHdEJEekJtbTFxSkF1aEFTZ2QvRkFl?=
 =?utf-8?B?cTJDeE9DTTllSGt2V2VhYzZPc2RtMjQyL2VIejFNdU5MOHFkQTRJc0t2U095?=
 =?utf-8?B?K2lNemYxV1B6akd1ZDQ0enY4ZmJ0dkRuNVhTVmV1QXRSRCt3ZEQreU5nb3FS?=
 =?utf-8?B?bDJTbElUa3crMzhhQVBHaUZCUnpwS0dkaExoMTRZYkFiNHlKN2JTNVpXa0RE?=
 =?utf-8?B?R2p6clF5SDl3Z0JaSTBZbEdNd0xpcG5IYXBkaUN4d2EyYjF0ckpselhMSG4w?=
 =?utf-8?B?UDFsSjkrd2phdGxERXVJQytoRjlOSEVtaXlDdTQvNlN3UnhUTjcraWVETzRK?=
 =?utf-8?B?QmVua24xa3F5WHBiWEhBR29LMXA3TjhUamZPM2xqeENKVmdtNEVibVVGSGJZ?=
 =?utf-8?B?TjNDNzVjZ0R2QTY2dEJqYTZORnJId2ZEd0JFZHZWZ1BRRFFFR25uVVBXQlEv?=
 =?utf-8?B?dlZzMHc1Tkk1R2tZbHRkRlpSVlo1NEk5bE5tTjhWWGhoT2xQNFpicmVpSnp0?=
 =?utf-8?B?QStSMkpTbnp5elVERnlkWVJDU3EzOFlXZldqRFlqMXhpdUZDMmZHOTEyb2t1?=
 =?utf-8?B?c3BhSWRWeWxnV05iNlFpbVc1dWY0bG5xV3ZUbTNKcndWRjJHT0N6UVJJczcv?=
 =?utf-8?B?SFYxZXNBZlZGRFg2cmtLQk9DcktjMDlrVFpDeFRmeEtJaE5TS005ZU5HckpU?=
 =?utf-8?B?YXMwR2I2b3owbUNFS1NQN0pZazZRVEllU2RDNjkwZXhXNHlFSjhFQ255bFZX?=
 =?utf-8?B?L2UreEMwWU4wdmg0THE1UU1STUtBN2lkemg0UTRLdENJTDBMU0RXSmxxb2k1?=
 =?utf-8?B?aktWSlZFaDIvK1hBZVhGWHpoUjQ4cW80Wkd4ejVVbDMwRm1VVWZqVTBhZVdj?=
 =?utf-8?B?OWp3VEFxMi9xTE8vVXZKMCtORW4wS1JxNUVvME5CUlJydnRuU0xhZGVXb3Rz?=
 =?utf-8?B?SzBQcWJsTVAwNSt0Q2xUdUxKOUR3bUZLMmdVWnB4ZVVtK2h5SGlFUDhQNEdT?=
 =?utf-8?B?RlJDWlAwRWVkNjIyWTRmMUJrL1RUMGoxNCtBdllNRG5pVnpDVXR0dFFqYjda?=
 =?utf-8?B?aW5zZHhuR2FDYU9reGgzRXJIdE5NeVFvSTR6eUFyOGtCSGxTNlpId0c0YUdr?=
 =?utf-8?B?U2R6QjNZdWdBOEk4aXdUY1JQeFI5dkxDTm9OcFFNaGQrQ3JCVFpnb0tOTzMy?=
 =?utf-8?B?WXAvVTg1bVNzMjh5azVkdkc5QXRVNk54VEwrTGszOWtDWlhKT2ZDNFdERHFU?=
 =?utf-8?B?d0oxYW14MkhKRGVKalBTTXhOWUI4cUtLN3dxQnFDL0xiWG9sTTM1ZVkzMmJ4?=
 =?utf-8?B?bSs5TVY3UGRGN04zU0JMWXlWaXRpeXRnTVJEZW1SUzQzQ3VqNzVPVHhaYjZQ?=
 =?utf-8?B?dkViT0xEQTlYTituZi81eUpLUjkxS2VxeTl6WkVRT2tKbGVBOHUybFcvMnpX?=
 =?utf-8?B?TjNxUERnMkkweVRUK2JEUjhiSktWa0RualFFakE4RjBvaTVoYWtFUmhtcFFY?=
 =?utf-8?B?SWxhOCtYUHh2NW5zL1c5aWxiTTJaU2phM2RjMFlObEo1cGRERHlDNDgwUVFU?=
 =?utf-8?B?bk5qdDRWcTY0WnV3Z0l4eWRWanNBc1FJSmVLNUZPeVhUMDIvN1RIRStnbFBB?=
 =?utf-8?B?cHdZcE9vcjdoZnBoeXdCVVZkQ0R1TFBSNU5EaktDMEtkbTljZnh1ZjNZWHpz?=
 =?utf-8?B?R2lJVUxJNjZaU1pHMitZR2tKM1VlVHhHaUNRR1NpRG1Ma3h2QnBRU2JhMzF0?=
 =?utf-8?B?NHFuS2wwaWtSUUoxS2VvY2h6Z0tCMGUwbVJyZktWSVRwYXcyaE9ZbXJiZG4v?=
 =?utf-8?B?YThHMzEzNjNwVVV1Q0c2Y05xdit0cHhLQjd2dVVkUHdJeXFib2hmMlJrOUl3?=
 =?utf-8?B?aUwraTdyUDF5VGNrL2pYYWhhcDBNbklIdTdwcDBITHFkZXcrUklXNFB5aUJE?=
 =?utf-8?B?bUxSUnJpV2ZoRWVScWZrYzlsQUI0OFQxdEtUUWJoT3o1S09reUdNTkVGYlow?=
 =?utf-8?B?OGZUVElDSk1MK2N5R2tjVnNkaDRyQ3hvamdLeTFsUGsvaFlHNW1zNGpMbmRy?=
 =?utf-8?Q?cID8dgK8+UnpWWfP5g/H2tDEBkawpBqied+VMcIwKtOv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d806dbf-1077-49fd-e2ed-08db7e24f5a3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:29:01.0963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ewsxf1jCN4sAx0JIDcmoTCs25kDyzfhdLsrWgrLjz8UL0ui5CCdgPwNeHv7W9gSp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
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
> The FW expects us to allocate at least one page as context
> space to process gang, process, GDS and FW  related work.
> This patch creates a joint object for the same, and calculates
> GPU space offsets for each of these spaces.
>
> V1: Addressed review comments on RFC patch:
>      Alex: Make this function IP specific
>
> V2: Addressed review comments from Christian
>      - Allocate only one object for total FW space, and calculate
>        offsets for each of these objects.
>
> V3: Integration with doorbell manager
>
> V4: Review comments:
>      - Remove shadow from FW space list from cover letter (Alex)
>      - Alignment of macro (Luben)
>
> V5: Merged patches 5 and 6 into this single patch
>      Addressed review comments:
>      - Use lower_32_bits instead of mask (Christian)
>      - gfx_v11_0 instead of gfx_v11 in function names (Alex)
>      - Shadow and GDS objects are now coming from userspace (Christian,
>        Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 62 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  4 ++
>   2 files changed, 66 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index e76e1b86b434..7d3b19e08bbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -61,6 +61,9 @@
>   #define regCGTT_WD_CLK_CTRL_BASE_IDX	1
>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1	0x4e7e
>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX	1
> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
>   
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
> @@ -6488,6 +6491,57 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
>   
> +static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +					      struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
> +
> +	amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
> +}
> +
> +static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +					    struct amdgpu_usermode_queue *queue,
> +					    struct drm_amdgpu_userq_mqd_gfx_v11_0 *mqd_user)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
> +	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
> +	int r, size;
> +
> +	/*
> +	 * The FW expects at least one page space allocated for
> +	 * process ctx, gang ctx and fw ctx each. Create an object
> +	 * for the same.
> +	 */
> +	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
> +	       AMDGPU_USERQ_GANG_CTX_SZ;
> +	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &ctx->obj,
> +				    &ctx->gpu_addr,
> +				    &ctx->cpu_ptr);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
> +		return r;
> +	}

I think I asked that before, but shouldn't this stuff be allocated by 
userspace now?

Regards,
Christian.

> +
> +	queue->proc_ctx_gpu_addr = ctx->gpu_addr;
> +	queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + AMDGPU_USERQ_GANG_CTX_SZ;
> +
> +	mqd->fw_work_area_base_lo = lower_32_bits(queue->fw_ctx_gpu_addr);
> +	mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
> +
> +	/* Shadow and GDS objects come directly from userspace */
> +	mqd->shadow_base_lo = lower_32_bits(mqd_user->shadow_va);
> +	mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
> +
> +	mqd->gds_bkup_base_lo = lower_32_bits(mqd_user->gds_va);
> +	mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
> +
> +	return 0;
> +}
> +
>   static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   				      struct drm_amdgpu_userq_in *args_in,
>   				      struct amdgpu_usermode_queue *queue)
> @@ -6540,6 +6594,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   		goto free_mqd;
>   	}
>   
> +	/* Create BO for FW operations */
> +	r = gfx_v11_0_userq_create_ctx_space(uq_mgr, queue, &mqd_user);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +		goto free_mqd;
> +	}
> +
>   	return 0;
>   
>   free_mqd:
> @@ -6552,6 +6613,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
>   {
>   	struct amdgpu_userq_obj *mqd = &queue->mqd;
>   
> +	gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>   	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 240f92796f00..a5cdb319193d 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -40,10 +40,14 @@ struct amdgpu_usermode_queue {
>   	uint64_t		doorbell_handle;
>   	uint64_t		doorbell_index;
>   	uint64_t		flags;
> +	uint64_t		proc_ctx_gpu_addr;
> +	uint64_t		gang_ctx_gpu_addr;
> +	uint64_t		fw_ctx_gpu_addr;
>   	struct amdgpu_mqd_prop	*userq_prop;
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct amdgpu_vm	*vm;
>   	struct amdgpu_userq_obj mqd;
> +	struct amdgpu_userq_obj fw_obj;
>   };
>   
>   struct amdgpu_userq_funcs {

