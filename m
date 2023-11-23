Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786F3C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 19:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE4010E345;
	Thu, 23 Nov 2023 19:27:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E04410E340
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 19:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCvIws6VL1j+prgSc18E9ql6RSX9Fuw0EUqGMEmYgwpZahLw0yrZpmaorRhdlu425omMaMx0HNGUlZ7mx+XEAgh6/xSYvDg27ge+n7WkdaOi3x4NmGi0tTOxAT5WobiMxyQ/oTu2shVMOm4S9NIcQrSAqaAzilNMqpZcDjPkuyq+x5+74KPAFJGPzhuEqXLR8wByQjeZB/8u3n7NjESp6eOgf9Fncvjb0hU6YDr2AbMRTXu856ukFzdpmG2hMowRZBas79FSoVjm7/ZbWNjvsG4m/96aO1b5QWZT0kEiclSiwTYXozyCY3jSkK3WYcBcmWubVnId1hyxKcSqHUXQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pI92N/RkyPGtKMN8kTPMsKxqzspULqj4HUdGVQDKGQ=;
 b=U05oMfNSJ/rm/XLyRygLeeWHqiYWbH8EMNe1R/nzM9BAjx4aF4ne4yyFcRANmqjozj28r1FhJN/8eRgYXlYQTvFzARuAvE71+YB4z2vgxHaDYsstc+0P1/sC/JC/gywv2iCZXN3aVmlKvkdCRqjBkSok3T/6VBc+lqjjvv8v/Tjeyokfe8bBHHeGtEJC4AVy4QxuRuUPnxSDCbVmJj8NtBK42UuUGvCYpSxHpcI/OIX9SeAS5c+YtTvizAnawcnrWdqIOcEjR+Nr38h9e3Pn2GyMHhTNhvnHeE6xGAEEXBLQdBP4dEgqdY1AoRoc3JMaUJx6WlIBNp3mGpC3N87LKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pI92N/RkyPGtKMN8kTPMsKxqzspULqj4HUdGVQDKGQ=;
 b=gBcMTCf4o8y+ylM+MM1YhbX9swKCzutjtkwLWkGgP4ml0sqKcc/bpUBK8sp1g+NkEgI3oigsANSd5SNGOS3Cgz0MIckUZm0R9xwTq+Z3cB263cNsTeMCyfTM2SkPu9xhhoSIjbJaR8EJaQ9Sd1IQ1ZA2wE05EN2AeLb2SmhfpHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 19:27:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 19:27:45 +0000
Message-ID: <a3dd1b0e-bf2c-4dbc-95f6-d3f7d7e69bc7@amd.com>
Date: Thu, 23 Nov 2023 14:27:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: SW part of MES event log enablement
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Shaoyun Liu <Shaoyun.Liu@amd.com>
References: <20231123191215.1041677-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231123191215.1041677-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b810206-4dfa-43fe-13e7-08dbec5a44f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTms3hJa8P8Az46i2WOX2v8STgXumiBZ3X2YSH9Ax0yQg4WcKstB8rtA/WF9EnyhzyGLfeRoFpfatOZ5wzeicf2pwVchHEr9fr/rVkXafWI6Bi/AJ5X9RqgOh45PyxzXKzuZcymSQWc+tCe+EXG/QT3SJ7yaZF9zLt5B1w8F9eMe2gOPEbGoRi1LOUjv9thXZEIBW9cQP9URGKttJzteWOXvDKdyfSM7+OeTcXf5nYN+qsOvXj8rhmOyHx3x46hVJnXTtKWYiJKYwOQiPVsFE7JHkrLCaSbKIqlFAIWjxCSscRsonwVNLIjBSGu75a0PeBu92A7bGx1DH+YU050FEF2aJQI6n4MYEjDH9DOD2T1pqNLLuYa3eCHoXH9V6Nodv7pgvRyrcZS59aSSbEtEfogaD0ON4+LnJvKPAZbP3LG0B6fNSsvTcCuCcn2Vbh4CXTD0TWj6nM5Cf1Z0Jn34BSfHZmA3sLqj75jCDrNLdGbbHBpPti9FMGxuLd1V1SdNDhwI6q1RzNpJFnoxd3k+B1ZhSdpPnWs6Gh37jCF+JmEOh0tmXPOR5kz2Ux1L0wxMuqPZ6D+SaSuMZX07XMBb25va1M77fbUZYXVoHIiArKW8G6A233Xkv7pltf1KGfFsUnzninQpQsk+ri7z8f3pPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6512007)(2616005)(26005)(6636002)(37006003)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(53546011)(6506007)(36916002)(4001150100001)(44832011)(5660300002)(41300700001)(2906002)(86362001)(31696002)(38100700002)(36756003)(8676002)(31686004)(8936002)(6862004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFVEQ2hLTmJlMVk4RzN6UlhpWmlvMGM3S2VhQThuN0UxRVY3bW1CVC85T3Vo?=
 =?utf-8?B?aG5SRkM1UlZ5RGJLb0pBNG9VOXZvU3dncm1naWc2TzkzZldCQkJVdlRZdVNB?=
 =?utf-8?B?NC9DcXBsUW55Zmo0bFBWSHpCWFdSOVZFRGlCWHkrZWFxTDRLeDkxNkk5dlQx?=
 =?utf-8?B?RWxER0xiNmdPUlNPSHA4YnRxM1UvSEQ4M3ZJd2ZzWVkrN1pUMURPdVdDMDRM?=
 =?utf-8?B?aGFIRWloVmdFalk2bis2WVdldlc3aWNDdGRQQkRZQ0JRL2ZXVU1yTks3OGto?=
 =?utf-8?B?M2dIb2xJdDdHdFlka3J1b2RZWDgxbXQybWFVNlBGMjFUeHBOR1lSSkgrZWM0?=
 =?utf-8?B?NGdzRElVeHY5TVBvZnBIRDdIZjlpNjF3SEE0ODlscm51elZOaDZ5UE5wQXhB?=
 =?utf-8?B?NmVXcHhpbmNTZDBEWVdOY3IxMTA2QXFsbWRYR3l0eSsyMjRSZ0IyWjFldks3?=
 =?utf-8?B?aEVYZVlHM29Cc3hleWV4TXFGQ01Gd2Iyd0lDbVd0NDlMUG5kREJaSklzMzVN?=
 =?utf-8?B?Y0tKM2IxaGQyTGNJeFlPQjNrc1VOQ2tGaFNLQVpqakgwRzdaenpjUGxWNkJR?=
 =?utf-8?B?V1p4VTdGZ29FVHordzhjQWNuUW5UUWs2eFd4NVNrbW01M1A4bXBxcW14UDdU?=
 =?utf-8?B?Y3YrSzJJV0txazJ0L045RExxQjR5YWV4VGtBT2Q5WmYzZ1dFSkxDWSs3UnBX?=
 =?utf-8?B?aUZqWE8way9PRm5Tb0gzazJUSjJkYXRGYmRDb0FNNktRSnI3T2V2alR0RTJC?=
 =?utf-8?B?aFhlanpzcm5QTi9kSnlwNVFCanI4b1JjOUlnTGl4WXVYN0Y1SFNUWWJjbkpX?=
 =?utf-8?B?MW4vdnB3dGw3bDJqL3RUUStvY1RjSDJHVE9PZTBqdE1pOUR3ZFdiYy9nWGx1?=
 =?utf-8?B?WmZDcGhwRG5vNVJEZXF3dzlKM2ZpQ0tFcnAya2ZVZGZXZ1lWUEM4eUZ0M2tI?=
 =?utf-8?B?TUNhUmtPZStEcHdBcDFjcmkwK2h1c2hzU1JLdkhhdHdGeDNCOXJhL2VIQ1lC?=
 =?utf-8?B?bktUVjNWYlJaVFpVVWpsdVBmMW9Eb2lhOWV4RzE0dFowNWZFbWVuUGZwTUd4?=
 =?utf-8?B?Rm9xRnJINmxPZ3FWVGFzcXdqUkRHTVd5aGxrZWtidUlmOHFmWDFuTE10K3JY?=
 =?utf-8?B?bERWQ24rekpEWlNxdlVhbC9iL2VmTFBrb0ppU2xibC8xK05qU25CcUx5YlVa?=
 =?utf-8?B?UGt3K1N1VFFqakN0cnJtZHRxeXJRY3pIWmtic2E1THlKSlBqdmNhZ3hGcUl5?=
 =?utf-8?B?VEdKaUtWMTZBdkI5aGZDMjNrVThZcG5nR043czh6b3Z4WnNpczBzaDlmSnNi?=
 =?utf-8?B?Z3JJRDhWWVM2cUZFSmlHY09OVE9kakhEL2VraTZtaGlseEpSbW1LT3k0ampE?=
 =?utf-8?B?cWFvTElaUVFoUENwQnc3NkxzN20waWI0TE44Q0RUbjduOVA3K0EyVzQzM1cz?=
 =?utf-8?B?em51K0YrajhuUzVzVUphZTZoZGFqNEcwZU84am4wQ2xpdVczZktnRU50WXdq?=
 =?utf-8?B?WkVDZHJVazl5V3paaWtIRURmMlFOMW15RlR2eDg5MHAwRy9wODVuNjlMOGlj?=
 =?utf-8?B?Vk5idHdYMXZQUndHVnVlWTJ1TWszMGhZZ1lwZlY5OVl5cWZKa0lZSE1MQ0dy?=
 =?utf-8?B?YmxvV2Vpd01QVG0reDBYNDFiUnJlaEtEVkdTeXUyYUJOcit0M25CMENwNkFB?=
 =?utf-8?B?Rnk2OCtOUmNMREtXbDFKWno3cXJpQ1hKcVUreGJuTG9USjhxQWIxeXVKZWZj?=
 =?utf-8?B?bnRJNG1VZ1k3ZlJWR2FUdU54WDF1c25odUpPdXRPR2FsYkVGVXd0dFhJMlJG?=
 =?utf-8?B?Z2YxYTYzMUNHVndkSWhmSmRHU1hmcEtQWHhkWVhteG4xYkYvWDNibWxWYXFj?=
 =?utf-8?B?TWROV2ZXVUthaUo5N0xsc3lnRjJDcW5tRndrK1ZJOEZNQktoZWFDbXdMZkh5?=
 =?utf-8?B?NktZNFRMSEk0ZGhQT1labWowOWVVVjdMS3RCeVA0RG1Ja3FTc2FZbEt2VXRP?=
 =?utf-8?B?YVMvN1FEaXorRS82eU0rS0lybU9ITGZ3N3owUmdnS1pOQlIrQ2ZZNEpHb2Vy?=
 =?utf-8?B?UDFvSlA4R3M3L2xNdjgvNFhSQTRXOWlBeWZVaXBLT0xKb1RqUXJBdUpwamR2?=
 =?utf-8?Q?1WtePBtHpbEr0EWzP9iC9jpXs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b810206-4dfa-43fe-13e7-08dbec5a44f8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:27:45.3417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUx7wVqrbGSbx2+wg77OeaT7oa79cJgUxy3Lps8b01Qf1shC9gNSfeG6X82YjGde9u9YDu0NP4oZzIpHtqbFSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
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


On 2023-11-23 14:12, shaoyunl wrote:
> This is the generic SW part, prepare the event log buffer and dump it through debugfs
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     | 61 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |  5 ++
>   4 files changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index a53f436fa9f1..8b2cbeae99ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2140,6 +2140,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	amdgpu_debugfs_firmware_init(adev);
>   	amdgpu_ta_if_debugfs_init(adev);
>   
> +	amdgpu_debugfs_mes_event_log_init(adev);
> +
>   #if defined(CONFIG_DRM_AMD_DC)
>   	if (adev->dc_enabled)
>   		dtn_debugfs_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 371a6f0deb29..0425432d8659 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -32,3 +32,5 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 45280fb0e00c..b7af24d7db0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -97,6 +97,26 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
> +{
> +	int r;
> +
> +	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &adev->mes.event_log_gpu_obj,
> +				    &adev->mes.event_log_gpu_addr,
> +				    &adev->mes.event_log_cpu_addr);
> +	if (r) {
> +		dev_warn(adev->dev, "failed to create MES event log buffer (%d)", r);
> +		return r;
> +	}
> +
> +	memset(adev->mes.event_log_cpu_addr, 0, PAGE_SIZE);
> +
> +	return  0;
> +
> +}
> +
>   static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
>   {
>   	bitmap_free(adev->mes.doorbell_bitmap);
> @@ -181,6 +201,12 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	if (r)
>   		goto error;
>   
> +	r = amdgpu_mes_event_log_init(adev);
> +	if (r) {
> +		amdgpu_mes_doorbell_free(adev);
> +		goto error;

The usual preferred way of goto-error handling would be to add another 
error label and do all the cleanup in reverse. Then just jump to the 
correct error label depending on where the error happened. So here you 
would goto error_doorbell. See below.


> +	}
> +
>   	return 0;
>   

So you'd create another error label here to handle the doorbell cleanup:

error_doorbell:
	amdgpu_mes_doorbell_free(adev);

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   error:
> @@ -198,6 +224,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   
>   void amdgpu_mes_fini(struct amdgpu_device *adev)
>   {
> +	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
> +			      &adev->mes.event_log_gpu_addr,
> +			      &adev->mes.event_log_cpu_addr);
> +
>   	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>   	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
>   	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
> @@ -1483,3 +1513,34 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>   	amdgpu_ucode_release(&adev->mes.fw[pipe]);
>   	return r;
>   }
> +
> +#if defined(CONFIG_DEBUG_FS)
> +
> +static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
> +{
> +	struct amdgpu_device *adev = m->private;
> +	uint32_t *mem = (uint32_t *)(adev->mes.event_log_cpu_addr);
> +
> +	seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
> +		     mem, PAGE_SIZE, false);
> +
> +	return 0;
> +}
> +
> +
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
> +
> +#endif
> +
> +void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
> +{
> +
> +#if defined(CONFIG_DEBUG_FS)
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +	struct dentry *root = minor->debugfs_root;
> +
> +	debugfs_create_file("amdgpu_mes_event_log", 0444, root,
> +			    adev, &amdgpu_debugfs_mes_event_log_fops);
> +
> +#endif
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index a27b424ffe00..894b9b133000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -133,6 +133,11 @@ struct amdgpu_mes {
>   	uint32_t			num_mes_dbs;
>   	unsigned long			*doorbell_bitmap;
>   
> +	/* MES event log buffer */
> +	struct amdgpu_bo		*event_log_gpu_obj;
> +	uint64_t                        event_log_gpu_addr;
> +	void				*event_log_cpu_addr;
> +
>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;
>   };
