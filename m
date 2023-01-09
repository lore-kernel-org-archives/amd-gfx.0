Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C62DC54EBD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 20:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF8510E486;
	Mon,  9 Jan 2023 20:18:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9243D10E514
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 20:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SITONfCsXkaAPLyVuYDOSasxy5ZL4GdVQwv9NXsWJ892w9T2d/9GxpiAD3nrHrtOi5F5jPx4h8UKzAgMQX9d1P6EELQYMyWPuxWAFVT0pxGS6NVqRUZkKWd+kW2dpCj8nOqEWkfcaoodjNXZXSZwN2pN5O+SBiaYeivaQ71rtr6MJ7WXKFY+OPXqqrMtx8ZdQUzh/G7yHIW4AZLfSXutKZiLocv00WQc5e5UoB4a7FVL565lZXvIn9Lqmfs8caq0Z5YW2uJVKGUgFxN3zxVldQ9/NZwLikW/ESFPHTI5pWk8h1ZRlZJzZ66Qq6Gi0PXTB72Bd917r4Hb6D2jrvgFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aomg+Hr1KO1lExyq9LAOzOKMloOlYoKLYgyQxGoxYdI=;
 b=GekpTyockoXvH/I5/b2V7J/QRDsUI7fsjtY0STFxM2pU6bEOhw2lsXhfaSEmNY3mEzMHI1l82OlJoImIYBEi2icdUbD+0FiKycQ/KfB7MnDuTR2sBAnfTyMM1BqXlaikZyl59V/faWUuv0IpZlVtVmFTrogWh3XVTlhsqLc/5n+8NQl8uQPB+Bz4ziGgYdvzFSaUeN94fMAupF/R+DhWqoNk/olXXJXGFZDMQFgxhFbZyyaLsX3CE03lKHaqMR+KBQCmOEdFLi8OoKUd2uex7ag0IFAyG1HKk36UJDBLXaq0yWEEo9knWCkoLH4Jg1jifwQ0YK+qLMSFLDLKhGw9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aomg+Hr1KO1lExyq9LAOzOKMloOlYoKLYgyQxGoxYdI=;
 b=evq9mOp+h/Mwofa1QHFXRpaAc7tJrl/GuIHnDWTBGYDySq49d9iqloMIwKYPy5b4FXR4PXNROVnSObw2fNl0SotnlVWk5uaDv1TSaEeRpQXCKt69IE4cPIYX8zb2YUxcUiqG7PoATUl+qVuzt6D0Ra0qkQxNWZKQyAM73JiVCDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 20:18:40 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1%9]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 20:18:39 +0000
Message-ID: <ebef9ae2-6b9d-7bd9-5b30-8935009b3260@amd.com>
Date: Mon, 9 Jan 2023 15:18:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Add sync after creating vram bo
Content-Language: en-CA
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230109192743.133767-1-jinhuieric.huang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20230109192743.133767-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 448ef86e-2d75-4094-c36d-08daf27eb245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSNBHL+TKLnUNa1AUodbIZ1zWpiiBGzSKom48mgMsm9BUTFKDKyqS5+0XYblMmQvYppNWiBr46yNEJbnX03L6UrhORBPu2nugRdXBmBdGZ1Tbigah0pw4idwPGvrML0eJLnl7xYvVdZSdwxD7H1e8WX6v/WqXC+sNuP+p9SYrZGpxYB8/0KAOgjGOEBaR9NmC8xR/5YxerWOuzgOjh+WE5par4oKDtmrQzsrxoyEP5sY3OlgOvS6//acxo8tX+I2JyH0Je9rCxUGWlcKnSGtb/iZHr6tvrRKxBBPRW41V2jw7B2dSYeTOJ7VcuS7NseaOWJ9MtZ3YVejbBuNClA9cd3bPkFkdquAsYQq7xwHuArefHbcS4nz5RIJ1SoeGXEgTCK50UvKhQIOW5Z2Dk6B0g5ZBGoMB8km6TdXuhwWKCX06vIcL5NIMFJlkWQrtbdML9NPbLs0iAhYRwlUN50HpasCtZ99JlwFZc+lKvzXEtBi8khJIG/YV7OcWwtOwjxepOLTVEcpX5GLrdUVs5zGv+K4UwdC0UX+XdFh01lrWneLFnaDm+AXq1RN+FbhCKH1q7pSKie/t2FW/nqeQHFmfQ+W26O9tQV1EbqOhhO0WgtrVNoSkr5M597sMcpQ38OhBqhb9dRjeJvyPQxRRyIWTMKaHklxlbImrHWGI27c+zTJWNcjt6BnmBKee2niuZvIXc8BCB7x772wh0NcFoYWBS2iHKkY5J1CQboRhcFTYZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(6506007)(38100700002)(53546011)(31686004)(2906002)(478600001)(6486002)(2616005)(26005)(186003)(6512007)(5660300002)(316002)(8936002)(36756003)(31696002)(41300700001)(8676002)(66946007)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGV1UmRpaWl5WUJub0srMUVsK1U2VHZtU0cwb0VPMThIbUFFU2VXcVRYM1BS?=
 =?utf-8?B?Qm1yUTJDUzlqVGt4ZjZoUGRKYjlYUVdFbnFBeForRUF0cUVCaTVlcjNueVE3?=
 =?utf-8?B?WHVxbXNYbnY5Q2NRenM3Rjl5YXdvNldzRVYzNGFMSit5UEVvSTlFZEJ5U1p1?=
 =?utf-8?B?TFluUGZQK29QUFd1V2NXell2bW1GM0hwbG9tTGVHbURJWFJTRDNiMXlUNUdh?=
 =?utf-8?B?Z0JLM0JqTXN3U3pZNU1Sanl5ZGI1bnFmZUNjT0JoTUNNMUpKZWpxRVU1ejEz?=
 =?utf-8?B?ZmRMc3ZuNVNDdFV3TDBnd2RsTGo5K2VXUUN2enl0MnJUWFJ6cHBrM1NhV1FD?=
 =?utf-8?B?U0hZeFk2QWU5OFBhYWFjcnNJaURGVUpjZTBwVWRXb29IRFpxZFBRcVd0eTVS?=
 =?utf-8?B?Tnc1TmowdTBQOWNqbFU0QS9MZjZrQjhtRzdVQ3VFMTFPNlZSb1NIVVlGOCs5?=
 =?utf-8?B?VTdtTVFIQWxDbGZGOWRDRk9ieXc0WTUzSmgrSXNCMHVtdkd3WEtEYURKcXN5?=
 =?utf-8?B?OXFObHFoN0h2RVh0cVVsNGFVYS8rVXBxU2xQS0FEZnh1NWF0OFdoNWZjdlBL?=
 =?utf-8?B?c3gzdHhPVDVZb0lnVTF2YnZtamc3YWExdTg1TVkyQ01vSUF5MnQ4K00vNEFj?=
 =?utf-8?B?U2ozYUJMTFBSS0prUzArMFdpMjVtbUlYV2NMMFU2S0xHTU56eW9yelRHZEdO?=
 =?utf-8?B?NVd0b3VHamkzZktuaEVXdXhEcmlNcEJjZ3BDMndSY05lTVh4ZWZBcFhGSlVV?=
 =?utf-8?B?NTBESDBCY1laRzBlN1QyTW1WMURBNmR6R2g5VUVpTy8vbGN6b0lKYTFBdzNH?=
 =?utf-8?B?RHR0YzQ2dUFyM2NJbkt2NEFjL2ZRUmxKSUdhQVJKekljZ3g2Wllpb3pHbVFK?=
 =?utf-8?B?ZFl4MUlXSnorMnNZNlhpQnVSa3VpdGVQRlJDWVBGbjhOUzVGWGZ6SkZsSDFC?=
 =?utf-8?B?Y3pFbkdmQ1hJVXJEWDltSWIzMkZmbmJCNGl5WkR4ZUlzQ0x2RnpNeTFka2Rt?=
 =?utf-8?B?NzRmOVkvR2VaMjE4ZktPZ1NzbXc2UnF4Z1VINkV4RDBKd1J4LzhneCtaRTA5?=
 =?utf-8?B?cXBHZTVmZ3NUV3VnY1EwZ0dUWWRrYlZnbzYweWJDY0JXMlF1cXJkcGVXeVJv?=
 =?utf-8?B?ODNMSVQ0bWV3dk1uZG9PY0hYbVJRZFlQNzhWazdMbm9KSFZBNkdvdE9hSzhv?=
 =?utf-8?B?aHk0ZG15akxJY3cvNVpCQ0hEcW55K0RicTRyRVRuK25zazRmMG9lWlo2WkV2?=
 =?utf-8?B?Ulk2SVBmeG5jUTc2Y0ZscmdDT1E3VU5WUVZySUxvalVuQ3g1ZjZpY05aNVZQ?=
 =?utf-8?B?NVFXNElpc3BvQ0JzSjlmbXlHS0RKdGYreSs4bDc1WG45cEZWUWFSZnppbXM1?=
 =?utf-8?B?Vk9BYmhCd0pJK3o2ZjRiWVRPUWVEbWs0N1VrUnN3VzBOVGFYZkxyRFA0UHhQ?=
 =?utf-8?B?VUEzdTdaS0RickdDV1dUUzNZL0ZEVENmR1pxQXcwVkZHOHZsQVlmSlNGSFl6?=
 =?utf-8?B?UWNMaDhQekk4MXFiZGFkNFdEaVY1L0pIa1ZpMWszU3JndFhtQnRFNTZEZlNS?=
 =?utf-8?B?RWNjUU1EU21TZFAwODVSQTNocXZ0c0QrR3kyWjlzRzVvV1p5U0lJVG1XNkt4?=
 =?utf-8?B?MzJYTElaRndxRFpSazNXMXlaNUdidHhDWTYzU0tuSExSYTM2OWtVQXZNVWVl?=
 =?utf-8?B?OTRsVk9MU3BJMllYeGtKeHNnWUdBenIxMHVwY2YzYXVQaW1NM0JHZWpGZWlx?=
 =?utf-8?B?NWYzOHBPeGx5Z1FSdHRkVDZkK0UyTnFVcHNmMGp6VHpwUGhqZWtFS3U5czMr?=
 =?utf-8?B?c1phRU41RzR5MkxMTVlKZEhLTXZyYlVXbDlRRndUQTlGTTlPUEFNM05MaHJL?=
 =?utf-8?B?QUtLdkFGU1JJYkpjcmIxT0RZN2pIUmF2aTNORzVqZ3JnWWljRWFDdExCVmVE?=
 =?utf-8?B?Ym5zTGoxY29wY0dDeVhjVjA2S244RlhIVk0rN0h1UGV3R1JKcVBDcDhNbjVv?=
 =?utf-8?B?S29nd05mY3l1alV3a2I2RDRmcFIvbEdMekozQ0dkVU9NVmI3TkNWd1pTd1Bx?=
 =?utf-8?B?a1YzQXhiUmRiOGpWM0Jtb0tZOHgrby95UVVCR0VqNDRhOWRVd1d4QVpldEZr?=
 =?utf-8?Q?AaF0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448ef86e-2d75-4094-c36d-08daf27eb245
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:18:39.8626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezLD0Q6TT8Ygs5F5qdRPUOq82hfIa5IK6aTlPqx54MiSbHkGEdzoJUqyOZP3ETNl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
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


On 2023-01-09 14:27, Eric Huang wrote:
> There will be data corruption on vram allocated by svm
> if initialization is not being done. Adding sync is to
> resolve this issue.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b8c9753a4818..344e20306635 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -574,6 +574,13 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
>   		goto reserve_bo_failed;
>   	}
>   

Thanks for catching this bug, we could optimize as clear VRAM is only 
needed for partial migration, ex pass the clear flag clear = (cpages != 
npages) from svm_migrate_vma_to_vram -> svm_migrate_copy_to_vram -> 
svm_range_vram_node_new.

Regards,

Philip

> +	r = amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> +	if (r) {
> +		pr_debug("failed %d to sync bo\n", r);
> +		amdgpu_bo_unreserve(bo);
> +		goto reserve_bo_failed;
> +	}
> +
>   	r = dma_resv_reserve_fences(amdkcl_ttm_resvp(&bo->tbo), 1);
>   	if (r) {
>   		pr_debug("failed %d to reserve bo\n", r);
