Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19208C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 07:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949D010F071;
	Mon, 17 Jan 2022 07:27:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC8010F071
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 07:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSlnkT7xJm74zKFsoJNSxA71qd2szXS2deMjIQX+ay1A7GRnqygiwJgDogtvwnDJiNNOmqBqoucwBc+v74qi8vTJVIBvMg/CpmOscQC2X3+PKu705hq8sECzoZjIV57gB3A5C7GaY0m4ZUTtOZg0hmX+TXMlONb49HUhOUxZyWC09wPpZIu0p9qs1XL13ZDovvibzJ/AMjYVCcw1SapU9o/QzdsROI3lQ6sqOT1bkBLu1Jc6KWi5Gbb2d6Vr/2U7U8OoLM56lS+vXnLIrasRJlL+vqu1mdxM2lqX0hqcIMG+3O538OrmLA2vLRS+a7SJ0DGhx6blc8jNWZHJicncrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diyDXom/T202QrbrbH/d/QGTr+M3F2IHsuNYWsMBVkA=;
 b=L5Mc8CDvEF2VoBKjwG5tQnhyB7QGHRmTmPy58V33vffDoVVtKmdi97S9ETGPMl94mUs7DDvn4FmRBjWN6jzjZwXtHxowOQfirsXLbtFCZ1BBVViLtoLEewTFplDKTfdU3s7AJ/eqq4E3ZeUomCAVs9NNOqfUF/jJMXSu3pMwlkZ30rXKKys5JQCt6LpaQirMGH8v7PIOC2yTCQNlY+MrskSu9WnpgJSx6rJ1Q4gMEAB7uznhAAC2RcxEpBQIhUN0UpdeUJo8QqZScCM+6w3F56pOz8f2UE/YcZqp/BXU+QsF5tlfHPXCK6zGPeq2VidKjf4urbsCXRnH82vjWs4oJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diyDXom/T202QrbrbH/d/QGTr+M3F2IHsuNYWsMBVkA=;
 b=XnDfWxdMRzRARF77Y0BEdZzdYdKuFxB/H0kY+PLi8kSekne7hdJwqUEq1HmkgcW2RPapl0pYQs7EGqt+0QaPjCG5KQg8JQk2mL7TXd+fpfWNXfDppdTWunG7z7cJlWb6GEJvZ6nHC6+0c3Zs8WMoisupxzdbwzuo4H7aclg8GTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MN2PR12MB3968.namprd12.prod.outlook.com
 (2603:10b6:208:16f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 07:27:19 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 07:27:19 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
Date: Mon, 17 Jan 2022 08:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::43) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5611b9-9b78-4bc8-f3f9-08d9d98acb5c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3968:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3968008E7F89338C71564F9883579@MN2PR12MB3968.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orV+VWEhKvF9jjPwCIPMZALRqHBWoA/Fmw9THYN6DhycWLAT2BcS2psSGTM3hMe7nBJ5G56ffs0nZyFynKXTuQ0/hP6Qs0GTffZayxdgjho0128WeMIvQDfuhI4DyPKqb5N5qtYdrOpVy34m5JfuytmSLcGds9QaGcR2u2+hpzsC5Mriub9LiHsttkN0g1qIbVhxewITo72NDvSD2/LT0zOrNqNJLmVeBsNd6igW7+LDAO+3t5EPsfPMKnJPOF6vTJLzG2FvdYD73xvgdXTG+XkaoH8IwHza4ew+fsZzl+Z6rFx+5fZYw6AC3Po341KknOZGvU+kC6XAqi0dnDc0lfz7fIMnJd4WWB8EkaiVmbUnGf5r68kUcbYAXu/qKoI8WX83BLt9fvVHwI+K2cnHWDE5oyJH+PSBcwgsgppWiOCg7vWlkMkyNHqQx7ykzD2nmnS7R5dJw+7NOV8s29emGnm2mSyCUUFiia+zFyAi6+D1Qu2IEyy00vfSb5JD7wlfEP0T4auqNOf5fdtJTJt3JRiREJTJFtFNvce2GntU6EIcMQw9rsnPEE65u4JoTtWReRWNunIeELxg+dafYaXrFxi1OLB8YgqNz0E+t6TYrw0vsO3ldUvjdegKuk0oLRdu0Ad3TxEL1vS+RUQFYPY7OpVIDdbx6k2yrFUrsDmveCnJYelVOWussyd3Ui3WMvm8xJUrb5NBa4uXV/u1aTOXWAMI7MbcBh4L8bWwHESocFMaIbK3X9XnUk1XiYm5DogU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(83380400001)(38100700002)(6512007)(66476007)(4326008)(8936002)(26005)(66556008)(186003)(6506007)(2906002)(6666004)(6486002)(508600001)(316002)(31686004)(31696002)(66946007)(5660300002)(36756003)(86362001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXo0djNLeVZVbi9BaEx4R0JEYjFHTGphczl3ZlhTTi9zRTVSOTI5eDlqR2dj?=
 =?utf-8?B?YWVSa2MzSmZjUU9nMlAzeG1UbWpoblFmMUlReXQwbWcvU2VPY1NXT2Q4TWlG?=
 =?utf-8?B?bGJBeVUzaDNVdXNZbUpCbTdHY0hBQTRoMFZqUmptNFlES0Z6MlZ6QTB2Zlgz?=
 =?utf-8?B?QllFVXByRjEvMnB3eVBXWHdMUXpYNWpRdmlzbEFCYUw3VS85SjFZTEVFb1Zw?=
 =?utf-8?B?dHhPc2pTeUx4R2ovak5JRWpUSXZralJaeGpKSkJEMGIxcDdqQWFYWTcrZFMv?=
 =?utf-8?B?aEJNd0dDVjRDYlhOeFBvbU5mcXdjbVEwU1VYaitOWFhYNVYrY3RLbitPNHE1?=
 =?utf-8?B?Vzhmc0pHUStTaExiWkJsdHYzZW82Z1F4dEUxNGpXZkdRNWJKdjU5S0Z2OEx4?=
 =?utf-8?B?VE14eWRSbVBwV25JMkl1ZVoraldKdTVwQlc2anY0TU54Mko2UlZuVXhVRi9T?=
 =?utf-8?B?WnEya2ZxVG4wYVY3YWJUWHp1cER0cFZ2MEZEOWx5VDNuclh3cWVCbi9RZm1k?=
 =?utf-8?B?N1BkNU5lcmlEcjN0dHdBVm0wWE02V3ArR01pNWQ4UGp4U2pBZWhmYTNrYlBy?=
 =?utf-8?B?bUNMMFVBamhRZHhrSFlHbDdNdzJSdjJpOVlqbGFjaFY0Q0ZaWW8yc3ZjMVJO?=
 =?utf-8?B?RU40ZXNzWHg5RDNLSEZNVEd2SDZRbTdhT3gyQlNsbmJXT0Zad2luTzFONzMr?=
 =?utf-8?B?Z3dKRmdWc3M1dHhHL3MzTXgvSEZodE92c3NpVWc1cjBhNk5OeGFYV05aOVlT?=
 =?utf-8?B?WVJhNlNNRXFvRGZ6bU9ueWd2Y1o3NzFHdDNpYzFsREJqakh2VG9KeU9PS09T?=
 =?utf-8?B?SzRJY1ZJNEpSTG1nSzQzbEM0RVlTMkc1NVJoeDJ4NWg3VkthWVZzdHhDbWU2?=
 =?utf-8?B?TGVselRBZ1llZGVBV3JHQzU3T2xZR3NWUko2RjhtVzBMRGwyYlBjb2J4RktT?=
 =?utf-8?B?SzliRktkV1lwY0Nkb28wU1pZOGpHWlJtdmRLTmRYMkp4c0RJZnl4bTQ2Z2V3?=
 =?utf-8?B?aHFIbWFQNlNhSWpmVitpaFdZWHh1dXVHdGdXMDh1bXoreHVEbk1lSlhTMjNy?=
 =?utf-8?B?WmZQS291RkRpR2IrbGNCS3MrYzcyalJqekxDRmFwYkhBeGxGdlBwTHUxbFVY?=
 =?utf-8?B?S2hzaXg3OXVENzRFMTZSTUJyRW5wZmVyRnUyNFZjdnNVVU5tZFZlekdCOGN5?=
 =?utf-8?B?aHowa1AxRXN6b3Flc2YxTGhzV0tXVktBZ2xWM211azhac3M0bnd5WEdrM3J3?=
 =?utf-8?B?MmI0VkNUSkFiNUpkRWRYQWIxUUNwUjlhcW1mM0c2eEF5Sjl3Ukl4bVVBYUpO?=
 =?utf-8?B?bkN6elRnckJ1Vko5SXBSRVordkRzY1FEWTIwNFdNTWFUUmFVVjE2di8rYm5K?=
 =?utf-8?B?MmtnVTFiSlk4VFdOcGRGWHp2RTE3aWZscGNNMnNKajJHTzBYd3BHTE9oOCtF?=
 =?utf-8?B?NWZ3cmF5Q3BxVFZTS3ZKY1lhS2ZpRStCc3NyOWcyUHY5S25JM0UvZFVXamtZ?=
 =?utf-8?B?c3BrWkIyMDdadUNVaEFFR2JpQnZTeCt6Y1VicUUyakFyWGhoOWFBUGpVK0Rk?=
 =?utf-8?B?eCtzeWg3dzdGUjRXMjVreXBSMzlxUXBEbFVTY2NtbDJBcWhDS25EKzliN0t6?=
 =?utf-8?B?dGY4czU4bHJCcTFlZkVpMlZjcU9FWGNtdmc5ZXJOQU1yRlRWZm0ySVJ4aDdI?=
 =?utf-8?B?a2RVcS9JRUE3U1BiRkRsY0wwVVV5bThDRmJGQlNXeWtCUHgyUk10UnBzT2VU?=
 =?utf-8?B?bWc1Qlg2QlU2RERHK09WWWNCQkhXV3kzMmZWUmpGQmNXK2R2d05DUXFxd0Jk?=
 =?utf-8?B?REFDRERTdmprV0l1Ykp1UU9tekE2SEJpZVFsVmpqSXkxenRMTGpObGdjTmVZ?=
 =?utf-8?B?ZzExRU5QUjFZZUJDZEVKdGpXQWlSbjR5OFhTcXpWT3M0cUthTVo1b3o3Tm1B?=
 =?utf-8?B?TmdRdzV5cG5sd1NIV05WdWtQVW1GdUhzSTZCdGRJQk5XZHJScEJOYmVqQzFs?=
 =?utf-8?B?aVRvMmpjZERQVHg2d2g3bU9ZcThjZnRVNTRrQWVFdmxpMzlXbTd4TVhGOEo2?=
 =?utf-8?B?MlN3TXBXZ2Z2VWcvMnRQR0hxaDZadFY1akNzVnNZUWE5eWdlVkdSMUVQVDhC?=
 =?utf-8?Q?+Zy0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5611b9-9b78-4bc8-f3f9-08d9d98acb5c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 07:27:19.3028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koIOBJGrAy0beXRK5wG/11gV3baRyPTXPG65j/f7ApT52I3dgJN79uHFObnze3Bf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3968
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.01.22 um 07:33 schrieb Somalapuram Amaranath:
> AMDGPURESET uevent added to notify userspace, collect dump_stack and trace
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 45 +++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 2ec1ffb36b1f..b73147ae41fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -529,10 +529,55 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   	}
>   }
>   
> +/**
> + * drm_sysfs_reset_event - generate a DRM uevent
> + * @dev: DRM device
> + *
> + * Send a uevent for the DRM device specified by @dev.  Currently we only
> + * set AMDGPURESET=1 in the uevent environment, but this could be expanded to
> + * deal with other types of events.
> + *
> + * Any new uapi should be using the drm_sysfs_connector_status_event()
> + * for uevents on connector status change.
> + */
> +void drm_sysfs_reset_event(struct drm_device *dev)

This should probably go directly into the DRM subsystem.

> +{
> +	char *event_string = "AMDGPURESET=1";
> +	char *envp[2] = { event_string, NULL };
> +
> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);

As I said this approach is a clear NAK. We can't allocate any memory 
when we do a reset.

Regards,
Christian.

> +}
> +
> +void amdgpu_reset_dumps(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	int r = 0, i;
> +
> +	/* original raven doesn't have full asic reset */
> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
> +		return;
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
> +			continue;
> +		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
> +
> +		if (r)
> +			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +	}
> +
> +	drm_sysfs_reset_event(ddev);
> +	dump_stack();
> +}
> +
>   static int nv_asic_reset(struct amdgpu_device *adev)
>   {
>   	int ret = 0;
>   
> +	amdgpu_reset_dumps(adev);
>   	switch (nv_asic_reset_method(adev)) {
>   	case AMD_RESET_METHOD_PCI:
>   		dev_info(adev->dev, "PCI reset\n");

