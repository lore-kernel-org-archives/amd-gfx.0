Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9AFCD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 12:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD7E10EB9B;
	Thu, 18 Jun 2026 12:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aEpJ6LbC";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59C310E3EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 12:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCnfGCZR6NNYpsPAgt0woogA05MWcBgQ/a1pgIBPFWg+3/F1s4jKj8sweyBF+xBM+gnNIbBaSwOsIsIqHz2bpKV1HNyNURE5wsu+u5C6QISYkN7Alrf4i2suEs+CFl8rGcGG3XmOKbjtc62pX8kkfKaihqcs4bZo4azLgNRR3ewnu3PnNp8lz1Pzs+HEWUAzMNuFHCmJXc+I71XTuyPhyfA6e5UfXMSdIauAh/2izHiO/1h6tUyXIVOkleY3/zLyf1JhcYXoYyc/eJyIX11NA2MMDD/5qpFsQxqCafmaov0i5tggCt8BsOkXK3cn91pYmnLpPOYYRAw1hXEmwVNotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zLOfuiEZJQh2F6B0ejfQrtKNf8XRNZYKBM8snMSViQ=;
 b=GpoRsH1c+ogNv/ucW28aboKZ9injVRU31inU7x7T+U8Gypzvi8Ctol7COsNS+lWEm/w3PSm5Yj/6nYHdQyI4YdjlmyoJfhVb92P45TQiu1SSVpBNyXddOinJEapHodWIk8vIkflPZxpkQRfqGUD6bImbFZsN+q2HvVysrwJNl0U7jnvM55unh7bR6JlCPSKXPvO/b5Dqma136a1RcHP2wZcBA7j9E9i3+ESZa2V2UnSOqQ5FYJfYxqNU1TNmQdAjANV5cROyraM3MeuhC3zK+JV8WuxCmebOga759QwOt2CwACLSa1t9ApW+oR4bNs1xhFvkR7eeVAxepaCDB4N46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zLOfuiEZJQh2F6B0ejfQrtKNf8XRNZYKBM8snMSViQ=;
 b=aEpJ6LbCZg6Du697fVWUwzgOrcngZUVCDG19o7grel/Kc9aEVzCVcfG503Ml18zCIg4I+52WLPdD9ny1Yk+CVvkuysaBdDwfVKVk+JcsrdDEfRRv7t1ASAFJ+JUoyp6RarWO+y3ErvjEprLa1v5+HSrIWWP4j3jCg1HvljwlJvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 12:42:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 12:42:34 +0000
Message-ID: <d2a07581-dae9-45ff-909f-a87795e0b472@amd.com>
Date: Thu, 18 Jun 2026 14:42:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: amdgpu_userq_restore_all return errors on failed
 bo reservation
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260618105158.93562-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260618105158.93562-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba48db8-2a4c-4b0f-7814-08decd3711dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aNEEk4yJfRR9wpdaF0ko+CZTFxEuQslflvMn/QHaaU1Dns+rD76ppoX+I79Uh4FICAznCUeUG6vZ+Ru3gDc7+Zm8AZTcX4zNNX6dh1smgs/nj7KjDjN7DGD+zJUTfBxW9Xgx2bMm/vsrPTFFI3OYjvD1xUuAdhSa7mz6YAoYv+fna+4wO8CqPxKdf5O+0D8K9ZRqAOHAc3Oa6VYLk9a9A5q3lgnvg4g5NrE49p+XnA0wQSbxZLd5mBMkRzngJ+h/E4gEO3AT3ZdWPsKmnvYAt5Q8L73Wn9e1aGZq6inme0JW3dkvwsRjaBSCWF+4u0R7041GWM5Y0dciYFmaEPtvQBAOJFF+9H5D7NIgC9/Z6v+2zYQNaS/us+IeSbZI2o2kF/siKahcfL4EESJKvJ4dSmZGX0N26ItCw/T77TsEyKRyuY5IJzBelU2w6GT3kl57XWX8/mqOHiRrY4xQ83TeHUtlFhu0Q2cZie6wfJ7jTGFordp7JqHFaB4trYOXevVRmVWOtiHwAU9Jh/RZCMB4wLeUz8ykcHsXinezGPv6HciTFhFTq7TYdtE+attA29AZ/zOstsv4pWHZbiq2dgoBhuWKi5vjwcQYiCzbNXZh8HjQ2R5RN7WIDAb5dHyNxT6jc9gPKbeNu9SBKNyhzzY1bRtRAcsxbM2wlRkQrAUAE4IzlslYU5ElsgS2WzwmWxDa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBEK2t4L1BxdWRzUFVZd0RJUUpqUHU3NFEyTGU1bXRUSVBVdVg5U1hwd0xD?=
 =?utf-8?B?SlphOS8ycFFGcTJrQmwwMXBFNXdjaHdySUp1NmNBVDhnQXk2THNTRGllRTZZ?=
 =?utf-8?B?S0I1QnVXSXZlOTR0ZXloTUd6SVpmQnQ4SnhtRUhxODQ1b2FOd2pqeVJxYkVj?=
 =?utf-8?B?R1lVVXNMWTA5OTRsZkpkcXVrV05WaGVscmpBUFZWTUFGL2djYUtmTmhxNWFx?=
 =?utf-8?B?c09FMDBZaEhQcXZ3LytyQXAyUk5WaFJ4SER3aXBlNkFoVlROYllQdVJNUFR0?=
 =?utf-8?B?VGI0Q0FEL1VONm9SaGVzeE84K1Y1cVJRUkJva1BFTXlOKzcvakFtS25zTWta?=
 =?utf-8?B?a2s1YWFiNnhLeXdzK2JqVVkzM3JTMjZ3dDFkUkV1S01JaFlyVGtiS0QrVkFH?=
 =?utf-8?B?djZJMWJFbWt4NUR3QzYwUXJYSExsWlBMck5ud2dGWHRGOGZINlRHbTVJMUZu?=
 =?utf-8?B?SzQzVm15TUcvSk9NSkRJWHJMSmczVHRWZ21Ma05FK3IvZ2pjUTZONnBlb0x3?=
 =?utf-8?B?cXJSVzJndUZXektObFN2ZElZek5INUhOdStQSTJEVHdVSERDZjJOdmdOU0N3?=
 =?utf-8?B?RWVYMXNreHVWaStvZE05NW9EVktRNU82NHBKcE1JdldDd01xUThCNXpvcGYr?=
 =?utf-8?B?clVqTGpPOFdRcVF0ZzI5ZU1sVTJxV2hycDI5OS8wQjNMVWMwNDg0QjBOUUdM?=
 =?utf-8?B?Z3hjZGV4bFlIQmVVWThQem9Zdk5la2ljdjk5MUZDL0Rob0tYSjRIK0ZXNWdu?=
 =?utf-8?B?M0VpNCtHYUtKRUw2ZnBzNmJxbmxoY1VKQ2ttZ3BPbjRhMDNmV0lGeEdKZnFs?=
 =?utf-8?B?WngwRWRoVzFDSnBBRXNZV0tnekIvTmZwYmJyMWw0YjA3MVBFeTlWbWlOQzBz?=
 =?utf-8?B?czVhK3N5SXpSc05Edkl6b3dFRlJxT3h3MEFzanZCdk0zWThGR2lycFdQSElj?=
 =?utf-8?B?ZGxITU9pK056N0dXc0tuWWNhSmhoZ2xVaUVqNEJ4QjI3WFMrbkFxeFI4Q205?=
 =?utf-8?B?M3B6Yk56VWZFam0ybDM3T0doSm9tVEZ1R2VJTDZQNEZkMEFXZFZaK25LWm8v?=
 =?utf-8?B?L3lUQXBuRWgzU2ZYditaV0Fqc21BRFcvQjRwYnZvMmUwMWxqNGJEdnF6clZ2?=
 =?utf-8?B?YzY1OE1XRlhuMGJROENJbjFhTWNDTVBMYU4xMmZPVlVnY0tneTFkdG1PRjNk?=
 =?utf-8?B?VlI2ZDV6QmtKR0h6QkZITFdnNXZoNzRqd1AwbzlRdG5mdzYwVnczdGlQOGhX?=
 =?utf-8?B?MUwrc2wrbjEySE5ib0NDUzhPOGpLR2MvMzFqVThDdmpWZUFsb1dSdXRBTEJj?=
 =?utf-8?B?UnVVTFBMSjJIOEdtREZsS005UjhaNXBCM0Zaa0VyelIyVGovNmRGQUI4UEZj?=
 =?utf-8?B?YjhpYzdzVHVHdFpzZ1dXR3R0Q3ptTDJyNmcrSUpobXA1NC9abG9GNGNSS243?=
 =?utf-8?B?OVFqY1RPRVA1N3V5bEdSUEhYOTR6WWVoWnIwK01kOG1aZ3ZPTmdwbk1ibzlh?=
 =?utf-8?B?dlFEMFlwMTdBRzdXaHJidGtXNVI3UDgrdHU2dDhIYS9UYjNFbWgyRlY1UkNI?=
 =?utf-8?B?L2hKenlsUmNGNGJZSDIxU0NCcFpWK3pkdG5pdHpCNjFucmh4akdPWUlUNk8r?=
 =?utf-8?B?L0VsNW0zL1UrNVFlMThmb2J3Ri9Kd0ZBQ21RclkzMVdsZkYybEtwdmRZNGdw?=
 =?utf-8?B?RTlGSDZGMWpmN3loNmlmeFlWTG1Ea3RIYUdVdnhCVnZqQVg5SDhzTGVESW1D?=
 =?utf-8?B?alMrTzlBTy9aYUtTdjdTUEoyYWFVdk9rK25XQXhERC8ybnU1TFZ4cWFETklP?=
 =?utf-8?B?bmR5ODBIR1puQ0hDOUdsZ2FWeE1EVTlhQlc1RzBJR0Qwb0s0SVNyQUYxUjVs?=
 =?utf-8?B?dmJUUmlXdC80ZkNZYkQ3OXFJajJVelVhL2UxY1VDb2tqcFdYMFZNOTZNeWx0?=
 =?utf-8?B?dlVwUGcvUmlkOHd1dCsvVXF3Vk5VUVZ4S1dlQnJLMUd6TjJLT3N0UTlLRW9X?=
 =?utf-8?B?d01GQ0xpQjZQaytsWEx5K3BPcHh0OHRnZEpaWG10Q2FzWXhQK1ZsTTV5N3pr?=
 =?utf-8?B?aE42WjFrWUtxZmNkeWlzNGk3QUVlaDNxVy9OblczRzU5djQwUXhCQ3BkOW4r?=
 =?utf-8?B?dFg1ZG15eFRPMGlFNFFWaVN6bFJ0MlZUTStMc3hWaWRSdDF3ejltYTBFV0Qr?=
 =?utf-8?B?YXl0b2VXVGNUQTJXdXRVTW0xWStiU3JFUHNEOTV6V2VwWSs2WnQrcTQ4V3VG?=
 =?utf-8?B?YUN5bEh3VjYzUUpQSTYrcUdOWVJIeEowSWZIZDFFZEhVY3l5VFMvN3RxTHB0?=
 =?utf-8?Q?mWGb+rPCdOfxs8LWh9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba48db8-2a4c-4b0f-7814-08decd3711dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:42:34.1213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZC2liALMOv2o1qOcKZL/M/6pfLbzIb2VZksciffqot0WYklqPSFK6GUTB3M22MrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
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

On 6/18/26 12:51, Zhu Lingshan wrote:
> In amdgpu_userq_restore_all(), when failed to reserve
> a bo, it should return a meaningful error code other than
> "false" that means SUCCESS, which is wrong.
> 
> The caller should not ignore the return code of
> amdgpu_userq_restore_all as well
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 95b680fc88c5..8b14870afbf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -894,9 +894,9 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  	unsigned long queue_id;
>  	int ret = 0, r;
>  
> -
> -	if (amdgpu_bo_reserve(vm->root.bo, false))
> -		return false;
> +	r = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (r)
> +		return r;

Good catch, but that amdgpu_bo_reserve() is called here is a bug in the first place.

The call to amdgpu_userq_vm_validate() must be moved into amdgpu_userq_vm_validate(), right before we call drm_exec_fini() and the manual call to amdgpu_bo_reserve() here dropped.

Otherwise we have a small windows where we drop the BO locks before starting the queues which could make the VM invalid again and cause all kind of issues.

Regards,
Christian.

>  
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	/* Resume all the queues for this process */
> @@ -1133,7 +1133,9 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>  		goto put_fence;
>  	}
>  
> -	amdgpu_userq_restore_all(uq_mgr);
> +	ret = amdgpu_userq_restore_all(uq_mgr);
> +	if (ret)
> +		drm_file_err(uq_mgr->file, "Failed to restore user queues, ret=%d\n", ret);
>  
>  put_fence:
>  	dma_fence_put(ev_fence);

