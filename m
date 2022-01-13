Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C256C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 08:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F080411232F;
	Thu, 13 Jan 2022 08:03:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB9711232F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 08:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2luVRqiKoKDDJMbgeZ+kOy7P6foNTwAj5LEzDZIFevhVvPO5YzPfKwBp6cP6y6TVkCdrua86rfwm122U8USBIsUnUY3pvmr73Bzh7n+tQ5r3DDyVbSQCtTx89FyXfOnqHFR+H1jSDrES9PaWfG9cr9oj3qX9mJTVJiSij2wqTmkJ9v3tblgh5nM2SFsijMai7ZMr+BcqZ1HOrv1RD0ho2aC01SM1X+T0Uo8mTo686De2+VIJXy/cxiq73wARy+ZYDro0IJsMOdAFjkWjNFm4iRshrLZGah8QMr9UY+NQ+e9H/MqNXw02fzivGcH1RWD7mTxqHIKB1517tTfABCL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhj0hp246p6pL4F2EF9fIdijs+4d5Rj/vSor2bUXdjE=;
 b=nyXcOPLqHRImkQNQSKFt2yiozTzAKJd/NV5RX0XY1VocSOlOrKaZV5q7xFIIM9qJvY3Q40QM9xR8VdMpTJAqCjxTZKGZ3nZnw4JqY3wpY/P8krcEvMAuyW62a6Xi45SJ2fxJH36/8gDXS9+TktIuyDD60g3IbupSu/ptsShWCr+yDQ4MP8jQ3CVSZ/tAwsLA3UFa91/fB5tHyl0pnNVec1SN1LiMrjv9NxVgBoM2Urx/xxyTOijIr08K4DLDHL3+pPx8NiK0iM3Gp09wX3j/5KlZasrk2Iutn3kaEa4j8ohVHdi+ZE6O6cvB1adLFxtvzqoknpBCjVz5lkZbXjHfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhj0hp246p6pL4F2EF9fIdijs+4d5Rj/vSor2bUXdjE=;
 b=aJquPNendwwy0BsvT7R2hcF+IlOxv0m98gPiGwiOryJa4RTI35cc2aWfWJnzNFrDe6GIjIhpKipaUaQ2SlEk7CyCr/NG09LeLc1pJLC/o0KaZqTQ6bjpf9XIHPm4c4Dq6hRY9MXN3UwfAaDqf2cHrP1PLEYyB3CvkTWLdtoeMYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB1644.namprd12.prod.outlook.com (2603:10b6:4:f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Thu, 13 Jan 2022 08:03:11 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 08:03:11 +0000
Date: Thu, 13 Jan 2022 16:02:49 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add vram check function for GMC
Message-ID: <Yd/cqSyOWt8Ye7UL@amd.com>
References: <20220113074526.29827-1-Xiaojian.Du@amd.com>
 <20220113074526.29827-2-Xiaojian.Du@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113074526.29827-2-Xiaojian.Du@amd.com>
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f29bb8a-a9e8-4441-ad3b-08d9d66b247e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1644:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB164420BA2502525BAFD5E295EC539@DM5PR12MB1644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WCE14U38HyohhE/mQyCooOt7yxL7jxdC5X4A3jROZaMl9uP/nMG1NAzacSiNRw7ZaSpvlZIFoWT6mPB0kRj1kTq7X6Qw4z6DV82QgIRIv0j25mLuEzRCcg5wiScSYgIEuX7DKgGXzVXGlkbkhiquaY4iie88ReciXU9VY0OnlR+cHmf1RjHrCqSbZ7aYfDcJYpZcYlcfrGB4KVCn+cuH60vTnKxzD4yM4KT2wG36+oZDOSJlpAidrxf2YKfr6A5SDT7+sDhVxQu8kaAiMVOO6EvxI59EAlG03Ae7kXmIFTRBU/EmVjJLKXpNhqyLtVzCDKvb2qlOFOebhg3hfQbQwXlSbuOZgn8ATk2IyIKhePHhGqnKFWjKwFTSimY+lZwVkSsbYj27Hl+Vs6tABtt7c8RhIiFDnaeNd4SlWq7LzeAm41/XmguPugM/ETzZEIS6qBsXBLfSpyp/3Y3m0k5/wTzqIvJTNglbpMbyg7DNIErFeU3h6ph1C4POogOtxTE5a6RIdm+aQ2wvR0sZOUWk1iXXCufu41YO5VdkLTvU54Ckp7T6gtIg1l3y96iwgOPvsmH+GOArNIqD628bf4XMHnTSREp9tfPI3/Rh7Ox6YhY9Z2LarOpnRCRRj+IQHzweQEdYyYISiV4/JGBU3znPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(6512007)(54906003)(6666004)(2616005)(86362001)(36756003)(5660300002)(2906002)(508600001)(66946007)(8676002)(37006003)(316002)(6636002)(38100700002)(66556008)(6486002)(4326008)(26005)(6862004)(186003)(66476007)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U8lbDHzWxMPh1AsdaHW2u/EmuUChwKSOYLX6HHF4lTkyjWyy7ZILvhOeQMZG?=
 =?us-ascii?Q?+w+4y2c3cOwFJVSj91lKq0CoUCtDAxVG61H5YzIfzvZHnHgUZBdKNRr+iFr3?=
 =?us-ascii?Q?zwwOnHOwCiR++AbIBRcJif6hq9aAltuzPE5eOlm0GZT8631SBneKDH84ghYw?=
 =?us-ascii?Q?AQz5CJa/e0n5bRrYz4neIStSz9+A1Z8bG+iwa89eqxfHwmfqtpqQSFHrCo9g?=
 =?us-ascii?Q?q/CJIc4d/y1JdTDLXW5xnI+1FoVzX38Goghx8aoaN4wEsIc9kgUXyamIo1U5?=
 =?us-ascii?Q?0YqUC6sRMQ7HcF9W4ccOwgzmVmGOLw2Eyvkc8WPzrpizt0A/3GW1ZSaxFUhT?=
 =?us-ascii?Q?rRQ+2AkgMo/go8ZkIVSgg1vUhCHBfBNg5J0mf6wW0ktKAmkEhA3pOef0Yjuc?=
 =?us-ascii?Q?Sq2BSNnhyh3TmYjJwbmmWlIpLPz4Kx6n3cnLI4danrvMFPUhHnUdR/QlHN+E?=
 =?us-ascii?Q?ev7CbzG0qoi32C1ZIwBCnP65MTHCzMhOs9yxRF1G8Nfs51mnJLwFCyHVPver?=
 =?us-ascii?Q?852ixDdZEdc2odYhORolnnnjzWjM9rwsTBmu0UH818GBj13q5qEMx8GAfKD3?=
 =?us-ascii?Q?T+wUcDt+at/Xa2r5BHGh5sxL2yFnefUUVSiMSoHgpv1QQ79hXnWMOxqTb2ON?=
 =?us-ascii?Q?c1hHkvmJkRmHQsEGXOz1tKZ6YZa7hujb0e5FtdHRWNi7uUWq8gqFFmkY5iI9?=
 =?us-ascii?Q?CoG9rTp0DgAUNGVCs2GWpphL9QbQp1R3JhurVv/yDMLBOBdCK4yji16v0nuC?=
 =?us-ascii?Q?f9M5I4FCZ8/pGDo6waANbw9kg3LBSsLQiZWzwRy9RGQVRatuTB67yw+RvssR?=
 =?us-ascii?Q?DZc6S3tJ7ozu40P7SfUto5ZbswIwFtOrVJmLL3Wp6hClJa48YaulZCJCL6PG?=
 =?us-ascii?Q?8cz/mA9DojzyjqCdRAa5sZU4vcbRQBSuCBTf7cEg+n0aGj2+6PHqw2b90vu4?=
 =?us-ascii?Q?LuqPBoxTrmRJIF27eWZE4vSZke3k8FQ2mTI81E0MytGE7re6/wyWBg4P4rLX?=
 =?us-ascii?Q?tWRmsgO/tro3cCo9nX9UwFuD+3XvaqkpaeoJ2MrqTqr7XhhrcFfql4uhbBk2?=
 =?us-ascii?Q?QIaSFuUFFhY3JAAExbEl4rEDqHjHXtSyrxttYdgDwW4hxhx8diRJSZcYAfIi?=
 =?us-ascii?Q?CW0N5R7dX1vl6ztpoA6dOdNoGlBg0j+jWkkTZuyZmN4BhPYSOVIK4vqltQMg?=
 =?us-ascii?Q?bOahy32hPHTQmZJN75S4na6K9V+PiaAA3LvlKOYhi4fJCUxkZb5H9mdjtBk4?=
 =?us-ascii?Q?r71xx18orRVNuUCNpvD2snVpsgIZ9PKTHpTpaIVHr3+0wID91ZQuqZvpbuLk?=
 =?us-ascii?Q?wZXNRfmeLu5Ff0LEjslRiOfn8nr6Z9S7JjA/xESlfk38QsaNNcKyTHs3UOur?=
 =?us-ascii?Q?X1L15fS1+ELVr/aP8Jcw5s9iKBe5dSWn70H225XEpn04ztz6jtMNTfvFYNEY?=
 =?us-ascii?Q?sjL1e09akrk7AJVg0fkJog/oYK8FuGq4KOPg+mZEP4OCM8J7Oa8mKOOE/8o/?=
 =?us-ascii?Q?+d4/LzBDYnSR0LFvTWTXSs5atThTKiL2Si3JxvxIKow25ZbyBc/fOLnGK2QG?=
 =?us-ascii?Q?nvDvm8pPkHyN04JCbXPK4bjMjyI/BxM49cWHAoIFGlNzN/AUj7gVc0ULkIA5?=
 =?us-ascii?Q?13+YiQIJZI58pE7/Bq6n7ys=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f29bb8a-a9e8-4441-ad3b-08d9d66b247e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 08:03:11.3012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RScFMwqxcEwo5Gl+KkiS1aFu4/J78JwhlUxcJIcqzaxY6uIuYMinHZVaSWK42sc3PJ9Z0G8lhUz6YnIGoEcwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 13, 2022 at 03:45:26PM +0800, Du, Xiaojian wrote:
> This will add vram check function for GMC, it will cover gmc v8/9/10
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 42 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  8 ++++-
>  5 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 83f26bca7dac..dbc0de89d7e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -833,3 +833,45 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
>  		break;
>  	}
>  }
> +
> +int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
> +{
> +	int ret, size = 0x100000;
> +	uint8_t cptr[10];
> +
> +	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_VRAM,
> +				&adev->vram_bo,
> +				&adev->vram_gpu,
> +				&adev->vram_ptr);

Since we only use vram_bo/vram_gpu/vram_ptr only one time in this function,
we won't need add them into global adev structure.

We can define them as local variables in this function, after finish the
vram verification, the buffer and local variables will be freed as well.

Thanks,
Ray

> +	if (ret)
> +		return ret;
> +
> +	memset(adev->vram_ptr, 0x86, size);
> +	memset(cptr, 0x86, 10);
> +
> +	/**
> +	* Check the start, the mid, and the end of the memory if the content of
> +	* each byte is the pattern "0x86". If yes, we suppose the vram bo is
> +	* workable.
> +	*
> +	* Note: If check the each byte of whole 1M bo, it will cost too many
> +	* seconds, so here, we just pick up three parts for emulation.
> +	*/
> +	ret = memcmp(adev->vram_ptr, cptr, 10);
> +	if (ret)
> +		return ret;
> +
> +	ret = memcmp(adev->vram_ptr + (size / 2), cptr, 10);
> +	if (ret)
> +		return ret;
> +
> +	ret = memcmp(adev->vram_ptr + size - 10, cptr, 10);
> +	if (ret)
> +		return ret;
> +
> +	amdgpu_bo_free_kernel(&adev->vram_bo, &adev->vram_gpu,
> +			&adev->vram_ptr);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 82ec665b366c..f06af61378ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -343,4 +343,5 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
>  uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
>  uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>  uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> +int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3915ba837596..5e407c88c8d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1048,6 +1048,10 @@ static int gmc_v10_0_hw_init(void *handle)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gmc_vram_checking(adev);
> +	if (r)
> +		return r;
> +
>  	if (adev->umc.funcs && adev->umc.funcs->init_registers)
>  		adev->umc.funcs->init_registers(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9a3fc0926903..6c94a9712a3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1241,7 +1241,11 @@ static int gmc_v8_0_hw_init(void *handle)
>  	if (r)
>  		return r;
>  
> -	return r;
> +	r = amdgpu_gmc_vram_checking(adev);
> +	if (r)
> +		return r;
> +
> +	return 0;
>  }
>  
>  static int gmc_v8_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ce7d438eeabe..1ea18b4ff63f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1771,8 +1771,14 @@ static int gmc_v9_0_hw_init(void *handle)
>  		adev->umc.funcs->init_registers(adev);
>  
>  	r = gmc_v9_0_gart_enable(adev);
> +	if (r)
> +		return r;
>  
> -	return r;
> +	r = amdgpu_gmc_vram_checking(adev);
> +	if (r)
> +		return r;
> +
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.25.1
> 
