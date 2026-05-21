Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848E2CD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 08:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE3210E461;
	Thu, 21 May 2026 08:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JsW+IMCq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5099910E461
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 08:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ2cr4P7kRDRJnQwvIe5EO0quVwWJLrbHnbn3J3nWbf3BSeCPY2WdufkqrF51h6gaw4CIlQRb+xycvkQNvVsDK9whPDSuI4tqfFzxACZhY9eXrxBi5i5+qRNeL9yD7RxXAMxMnIaL7OWJXNXnyD7pJvldt/QKb4cThgjMxK+dFxBHTc7PMggWXR08rKnDIMgY7vAeud2syQ2bBTh/st81R07ZASbxL6L2fu1C5fUg/UCkvIJJCJMy20NizhuUWfsrcnzEaa4c/sFmQx0U8ooQ6T6qa91en9e0d4jqhg9Fc4wdvb33JmOuNYmshjEUPZ9NmZiT0p5symvNooG59Tocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21zEpUX+hbf0Fbuy1cmkSDCiSASa3Gk/mb4VrJF224Y=;
 b=IVpjwfzn3XFUWRmi4CYwZsB+kZCw4Qmbw8kFkscCfdwOWPzyfxcr3J15vKkNnVtF5Wtk/bQNyrF7driZewMbcIi+VIMCyiS8iX6eIQQiMLN/nNjTamnB1OFu2Z+2kcRk48Ir8QMX8Bj5BXrMvfsYmsRp8o3Q+a2i2iArNVk+FX+sldwMZJTs6qWouU/u7Cb5aIE4KKSw99KT28P/rpaZfWAyS2vGRwlGESobUPhNT++NiQikORJWSqAZfzmJmdvR7Q6mdqsvQoMC6L8KQnqVAi8XrDH4xz9BiIfIiBlrnSgpvn970JI8MhiLUa2DfaIbWTrwI/8othXl3HDvosxvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21zEpUX+hbf0Fbuy1cmkSDCiSASa3Gk/mb4VrJF224Y=;
 b=JsW+IMCq1PpeQWQwBtNWIAEBu3BlBpnf97aOdkFUYKkEHGAF5zMvdJp0UNlTw8LP/DPqCwdsH9q9qH1R53HffruYyrfMpA/2hsMLhZT2DFEpeeNETnLnmhxtO4IYZYM4eE5zE9nHNc8U94gHD021PRxRwJzPkJTtRdxu3eGvkpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 08:27:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Thu, 21 May 2026
 08:27:55 +0000
Message-ID: <43c9c48b-e6f4-474d-9d6a-1e6af205fe6a@amd.com>
Date: Thu, 21 May 2026 10:27:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/userq: move mqd_destroy to later stage to
 keep core obj valid
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520121019.2581398-1-sunil.khatri@amd.com>
 <20260520121019.2581398-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520121019.2581398-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faf4acc-bfeb-445d-d336-08deb712db8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 8YC/H/kRGs3m6AHH6ZZKDz/WiPesK9pB5ypHzRQnoyIsXoEuuZVvhViUduaX70aVq1d2dr2/9hI8n6y2KGenMjxYvpv9RA3Mj8NIc+1c0TFSK1X70ZO4JXqotn1uvQIU1d8eriblGgQ+9gQW21P4SKzx07X0YA3VeNCIzrP73vE+6xmrvGpKZm0HncMj0WZIc2st46saTox/yzoPukuABMVThd1vICUKI4BpEvgXYsddMdy9U/Ulz2mPKWUGsx4rBsVaGUk+PXjXpjT0MEsGICTC/wEmAa/Kg2+pNYlMvAHm2ZBadQzGKfoNDa6Doohw2mtkue3nWyDDetOUjv82jTMOPI/5E7n1S7BLnGon8/XG5KdVJzJzOPzs1V+F43oLfezuudi+sONWx9xADjMjUmXSaTzHX7LB3zLCaHluR4bV+UNePML2a+MPAi8C5lAeHEiTv2O6yBhb0a/wGKOkKNDIODR0FbVei9jegN1zPXk7/GwsUx88IrBei0V+OTgdiEiSncwMzWfb3tKPlJFnMeY8n4BiuNS4VOEX8gYJt7WlVBWv3tjUqGbSmF4wZeO74ZdrWwYnS5rIPfoUA+i6AHhpaVeZh8yyUbZ5Sjhrs37Emg5X2O7sftZs7WJ47eKGKpsPsQoBRoS7K+SXMFdtecQSdkg7h56vpaWZd78QQZ9QZMBXNNdy1MWA5De38Y/8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNocU90WXNrbU1iekNNcTlPRmY1TXhDQVIyNXU5cXBNeEd5NFFOaTdzTWUv?=
 =?utf-8?B?RWZWa1FZYysyTjV6VVBYS0xvd2djOTAzWXk1dzV3ZUY5aWxMdk5aYXdKUXpJ?=
 =?utf-8?B?WU9uN213ZWFLTldCa1p1THZvNmc2aFErcDkvYksrOXhoc21tekUwREJlaWVG?=
 =?utf-8?B?WFZwRXRPYjhSYktBRU5heTJHKzh4dk1xWW5kS1dMbmpCendyOTF5QmtmSEZv?=
 =?utf-8?B?Sm8yTzZhN1FvVWM4QzQvTkloclNGZm9McG45TE5SbS90YlFabFVOekx5dm55?=
 =?utf-8?B?Skw1aUxHWEtjbm1VUDAyMThjaUhTYy9CL0gvT2V5WklIUnY0cWcxd1F4Uldz?=
 =?utf-8?B?RlQ2d3ltRHg2aHpoeXpnQnduOExBR2FxRDJ5WXNXbGRSdFRKL1dOcTNqOUxh?=
 =?utf-8?B?QWY3REp6T1NmaUlrTUVLb2dLVFRweHNFVHRxVTZhSXpSR3JqNzZZejZjc2RG?=
 =?utf-8?B?dUZQZDFBaVB1cmpzeVNqaHplZEYxdWJOb3dIM05sajNNQmRya2JjVmFRanJt?=
 =?utf-8?B?Wk44K3FrRTFGeWxHWEVMZFIvcEIvdlBSaEJxYjJYSXgxbUVzaGN6NVUyOXE1?=
 =?utf-8?B?QnZKaDF5cDVRc3ZtNWs3ZnMycmQ2YTdBdWJLN0pYY25WUlFnaU9GVlcwVnc2?=
 =?utf-8?B?eXAvUHNOUHNSSGd2a3NXY0hpL2dGZ1FvUGowYW9JeURDSmdlQjVMTjViVkNp?=
 =?utf-8?B?UGtEK2hBWm42V0VoZmUwUnk2bHBGdGdjVFFaZFA2UWhMd3E5RGdWRFlWVE1H?=
 =?utf-8?B?cUNmeW1EL3ZYTzVpUERkYU9HRkxkNXlJb0drQS8zODRWZ2NlSkhKK09Sa1p2?=
 =?utf-8?B?L05hTmpMVzFPNmdnOVZjbzNENWpnR3Zpb3hETG8xa0hRM0RpdXBlSExJdDAz?=
 =?utf-8?B?ZGdhR3RvdjZ3ZW5GWGcySUl6WUhQNGhIRi8yS2JmMmdOZ1VaRXZsSXZieUZZ?=
 =?utf-8?B?bmtOOEdXVnVqa3R3dUJGdW9zVU55QVFqTXJzWVBSaXBvdk1YRDRLRm1ydkxw?=
 =?utf-8?B?TTBubmxvUkIyYThWa3g3WTZHdFpPNEs1N1JKamJXanhieWoybnVCaVpRYjVM?=
 =?utf-8?B?V1ZDUUs0U0VNQUIzRGNJNUt5OHg2RmZPVllIalR5SkVCME4yK1RVSDNiQXlS?=
 =?utf-8?B?dE1oeXpMN1Y3ZElEWUVzSXMyUVVhRDNzc1l5Y3lGWmZ6QkJ1VDlMRzJkWnNl?=
 =?utf-8?B?T2xzTi8ySTlJTEs4ZGZyVmxneDRsUU5MbW1MVjhtUHdydDhHTHN3OVREeWs5?=
 =?utf-8?B?b3pTbDJJQXREVGhOM0l1cFpNbmRGQU43cVRtbUdsVnRNbHlNbklSVkp2V2Z6?=
 =?utf-8?B?T2M1TGpvL0JKNWwrSWlFcGppN2dzSkorTGlzUEdpcFArYmpvSG1hTjFjRk5n?=
 =?utf-8?B?cHh0NmFzbFJHS29UM0l2dVhtRUpGbmpSTlBYMHFObCsxY3R4VUNmemlTV3dV?=
 =?utf-8?B?d3h5cW1NWXRIbUVjUDNKckt4dFJDM1V4UzhDMXZNYnFrZnFqdjBaekliS29O?=
 =?utf-8?B?b296U2cxVHc2dVR2UFU5YVFkd1lVY0JRWlVHMTZaNjM4R2FhdWUrNTJSNFY3?=
 =?utf-8?B?eFVsQlZvUWw3YnprQkZuUXpYSjhEN3FhSm5LclhHUmp2eUhidldvWm9XWWUx?=
 =?utf-8?B?bUxQMmJuMjFTVVNsaUpzZG1naGNmeVcyR2NmQUMwcEw1VnlvZmFSSDVWMzNT?=
 =?utf-8?B?Q0VnU2hwY01qckIxSUFyeDVCSkhxY0FudVZiL2hCckhCeEJRUklkaVFWM0pG?=
 =?utf-8?B?S1hLbE01ZGFSQ0xlZ3M3SWJZMVNXODBoMmttbUF0VFRKR3BHa250Q2tsQlYz?=
 =?utf-8?B?aEJyeWlGUnpoK3lqRCtjY1B3L1JkeEsyRVZTNkhqWG9XdW5JL2RkTytOZ2JJ?=
 =?utf-8?B?SjVSdGpGZ0Iyb1p3UEthWDd4YXVaRTJCSGtGb2VURDR2OU5kM0NxaE94YzRC?=
 =?utf-8?B?Y2gyQnlkeCtVQUJRNG5vcjJoalNTMkZ1amdXOWNwVXhWWDJoOHhqVGRWbFpI?=
 =?utf-8?B?dUJnUERjYXhaMnBRL0lVbDZEV05HL1pLdC9xNUhMdUEzYmZhUkJSaEY0S0VI?=
 =?utf-8?B?ZGdURXJCaWVhTFZBTFYxT25qeWhPUS8wYlcyVkRNeEVFSTBkVTduTjBIblJL?=
 =?utf-8?B?R2c5OGlxUzZFTEcxVURCQTU2enI0dmQ5eXR6eDZ5NlRRVXpHUVZKcEJ4dzQ0?=
 =?utf-8?B?YW5aaVZBRGp5enNSM0lLZkxnckhCTDFjL2NRMlJDN051QjcrRXF6Ny9SMnpt?=
 =?utf-8?B?V2hzVUpoUHhrQ3F5WVJRQy84WmwzNjZrUjlXTVdoWWpkUGZOU1RSaWdtTWly?=
 =?utf-8?Q?QgRtGqYQ6w0QYxMEjD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faf4acc-bfeb-445d-d336-08deb712db8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:27:55.5592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nniz/PM4ZnAjhXB07wfPN+kod2rwzGYFQNpdJGE22nkycMxAtxyQWreC9MUtD7uQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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



On 5/20/26 14:10, Sunil Khatri wrote:
> mqd_destroy cleans up the queue core objects like mqd and fw_object
> which are needed for any pending fence to signal properly.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index eaaffcdd6960..8cc3c8e7e166 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -417,12 +417,10 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  	struct amdgpu_device *adev = uq_mgr->adev;
> -	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>  
>  	/* Wait for mode-1 reset to complete */
>  	down_read(&adev->reset_domain->sem);
>  
> -	uq_funcs->mqd_destroy(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	amdgpu_userq_fence_driver_free(queue);
> @@ -543,6 +541,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_vm *vm = &fpriv->vm;
> +	const struct amdgpu_userq_funcs *uq_funcs;
>  
>  	int r = 0;
>  
> @@ -567,6 +566,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	list_del(&queue->userq_va_list);
>  	queue->userq_mgr = NULL;
> +	uq_funcs = adev->userq_funcs[queue->queue_type];
> +	uq_funcs->mqd_destroy(queue);
>  
>  	amdgpu_bo_reserve(queue->db_obj.obj, true);
>  	amdgpu_bo_unpin(queue->db_obj.obj);

