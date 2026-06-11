Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6FFCD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 09:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF1A10EDD6;
	Thu, 11 Jun 2026 09:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVYqInL5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6117310EE0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 09:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0mLOmIyaxxq1QvoMR0badrdzKSukaTyeTyvApWZNmLGv3WqGTISnP3ZTue/yU4oafawYdrc1ECHZhrKwWMnrcTqRZVWN7aqJ/ua++cHkudSIxhulJjurgH3v9sbNtI4uinchNhAVQViHFQZo6OwFXJQOwGDz5F5NjK/VP4VaBLp4zgGxBd3Sk9wn3FjIVETHv+dR6eH+fHfTecUIik3S4WBG3YLWlyw1JU9WAzfxKhQWoLCZe1BkjbaVlfQwZF4dHnoRyftQ+dC+Mv/DKSKbqi/QEYz3t16rv7iIExX4JMdlcAmyikZwne4zejyQGlZ15VhpzVoYdExfbnhjCFd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvK6VoyWs2xjxY8HXd68nAAne06R2Qo65Qjoj/Be7O0=;
 b=EGKFNH/mvTH8NruMp7uILt8hGP0QEP5Rh2ZZg3I/JNOpViuMtg0kWI4VcU4YsFcQAxOAgO3O6H88uk6PL+7kwtWZ0bdEJWufkxuZ5Uldv4xtuU7xH5doNrewfaH/oNYzP8mVa3BqIqYkVg8AM4GruneAiBDU3GP7OWBguqvcmkAzmQuquj9t8a2P+f+eMiiIsQ3F8dA8rtWiICHz7VWj8yzUV3tneAz9LlzyqVf2fsF8qUNtlXRO7KerxGB1pvigBJo4wH/2JEPmHk2Jy50RwYmVgqIs+A0G+U3Fz+lQxMosZvYdaWq2YNZGutucsneK6hSMEVAODivLQfi85fc6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvK6VoyWs2xjxY8HXd68nAAne06R2Qo65Qjoj/Be7O0=;
 b=UVYqInL5dT5lOFrO6oCSy2EkEvAVttylFQ9m4wKS5pnbo/Zc9R+zlpS87ywkVYsKkQGNox2Nt+8FgWmQx69DwRGVY45CRxpmxIMWIo+UuVM/Dgmet2WfaFJIhOENUbTbsNgkAvwH8fV7mWAdllhXLn2YouYtQmesKHsY/+q62h8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 09:58:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 09:58:42 +0000
Message-ID: <ac27896c-2215-458b-86f0-1ae1ce9a771d@amd.com>
Date: Thu, 11 Jun 2026 11:58:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/5] drm/amdgpu: Add helper to access the fpriv
 eventfd manager
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260611072644.2856170-1-srinivasan.shanmugam@amd.com>
 <20260611072644.2856170-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611072644.2856170-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c45f0c-eb79-424f-19c8-08dec7a004ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nWUyHtH7Mwpd5u/S9p+8d9+DNcWEp/+NgLVLimQFUTsJGmALuejV7SVCHqnkfzNgDcgCzp24zFnK+MXfSZ06ss0tlcXCX1wbiRUC54HawQgABN5LjolAXUF9HiEdOuxtemiXWKn8/2VqJT0KjfcDNQOYqN/RBmb3Gs2a27YDkxS0G5wdQM4T2wY2xcdJO8Wq4J6A0YoZpCuO2/SOwSNj4KvGWKP41LMi2ru3yBlGTCnqKdFsQbB9FTh3RpWuUCncEJHd57FKIZ+SXW+cX2f0F5v4WlA89381biu+YxNTyuyfS2N3VorFtaevxPCxkFjctYeilqmPjxLFisHGq4MEdRYWZaRxN5bcQ/FhUMc4xOa0hWJF34BTx4CVlZjz9MrhjUmenAzIyjfYdLvUde0smuPjPXasnT52TfOabr7o0vo6ps55ZnuqIXhZoeTj+OFBvkdn37Rum4OCmtNdSCxyWGxoDduHeIoEHvw4HK4Cr7avfcKr1A0c94vsFQQhNwDTIgkTJmJj9YITtuOlCUC8sUoRdUR8GI8P0peHfmQpRQ46/lJ5dGqAFKR4jnDsZKFefzqvQjGYSy4BSvF2Vtte6q/caVkOtaNF1KTsjuaisfYmWRezV2YajJF72S+BshhSbp8kSDt/Dv7wqefjxoleCnFII5RBIIkS9D0XMAhSXxzvA45euvWXltsImz+CZOu7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlqY3B4eVhpRUlKMjF1V2NRcG5OSisyc2FOK3BlT0daakZDbzFMZWMrWnpt?=
 =?utf-8?B?WnI3RmJrbzR2ZDlBU1FZVlVnMGFGdVlSdUhBUzh0NnhuQ3cvbmNyMUl2VVJZ?=
 =?utf-8?B?NVh4ZFFPOUYvaHVSL2JqWHhSZDQxa2IvanJHZHpqaFdYSXpmcFd4VlJ3bHEv?=
 =?utf-8?B?UlY1MUg0cGxWMEFKTEV6T1A4YkRJVWpEMTRKamNBSTVKR2RWeUZwWHZoSGV4?=
 =?utf-8?B?TWRnSzBhMUEzOEtYWUptM1ZLSy91V1J4dEFNdGtPakFpSlpFc2h3bzF6Q1lI?=
 =?utf-8?B?a3oxVytQU1NrWG8zb3RMa3RJbDIxOXQxd21iS1VZSldCRXJRM3NyZVJJOUdW?=
 =?utf-8?B?eGZkUzYrM2Ribzlmak91alQ3MW1mM3ZnU2cxRUhVMkIvTU5GL1RXOTNyamU4?=
 =?utf-8?B?OFBTQ0FrY0hDT2p0ZWhJNm83ZGdpbXlBclBMVGRtWVF1WVliMWhGdVVsMmxE?=
 =?utf-8?B?ZnJnOGRpTmNUeE9iRTRJQ2hhU0tHdTI1YXhqTG5NelJ0eWlwY3dhU3pyWExI?=
 =?utf-8?B?UkdEc1VwZWhaTHhrVzgzZ09kclRLaGtISXBxSWludGZ6dXVja2M0VXhPa2c3?=
 =?utf-8?B?ZnRDQXBlU2pzdDJTSCtoeXRwYkMra1Y4bkhJOHlMcUsrQjBXYmJXRnNMTmk5?=
 =?utf-8?B?L01MVUZuV0hVSkJMaThTdVFRaVR2TG9QZmExOUozb2tCL3V1TnE5QjkwOXpE?=
 =?utf-8?B?aTJabUdqR1I4VUxMVWh0cWtINks4c0ZLVkRQaUFrV2RNQ05MLzlHVzVqRkdz?=
 =?utf-8?B?ZS9lS3ZaK0NTakwrczhzejlMd0xQS1EyR29yZ2xXOUcvczBGRUIzMi81ZDVO?=
 =?utf-8?B?czQ0R0ZSYmxOb3J0MlU1TUgyMTNzRkRxUjhmTzZlaUN3OHVBWXlMSHArdjVk?=
 =?utf-8?B?YkVzMWlVTUJIUEtLOGdMUCtWMHV5RTRwN2lKeEZMUS9jbUhkNVROcDdRcjc3?=
 =?utf-8?B?WjViemk2UWtVcVIzZHFTYXZEemNjS1pYZGZ0RjFpZ0lHKytId0xCalNJd1V3?=
 =?utf-8?B?RCtEWmZaSWxaQzVtMzVxMWVuQWFqZzliWWVXRUsrbHRYWkEyVjNGdWs5dEdk?=
 =?utf-8?B?dW9wTTl6WGhRdzMxT1g5WEo2ZVdsbnhSdnpFYTUzQkFabjlzUTFPVVlFcEpD?=
 =?utf-8?B?d2Q3TzEvRjdPQ3VJQlBqWCt3N0pLdXhXZDJ4Q0duRzhYVTBuZzc3dXFCeUM1?=
 =?utf-8?B?RkpqZzFEcEtkL092aFBGVmt6L01uZDNuZTNhZFZ4ZzEyOGNRNnhuVGlPcllJ?=
 =?utf-8?B?c2xGVmoyN2ozcGRQRmoxd3FVVnpYaCtFZjJkWUdXR0FBUFdYUVl6U0U4RmZh?=
 =?utf-8?B?Y1Jacy82SjBvMDYvSmlwc2I3YktVNElCVlh5Yk1RWFc0d2hQTmliWmZvUm5o?=
 =?utf-8?B?SEQ0c3BvSm43b080aWszZ0NRTzdYQWlaWGJXdEVPRUx6eEI5c1YvOUViaTFK?=
 =?utf-8?B?cjQ5MFA2N2NmZFl1Z0lFS3NCWGd4aGFsMlpZdm5scjNhN2UzZUREdmhDV1Ix?=
 =?utf-8?B?MDZHdVdJZnlmdW00dVFtVjM0enphU1Z0SDBOMzdtaklPV2FlU3lpbnJFdHVW?=
 =?utf-8?B?RnY0WW1iNk8vYmREdE1zWXFKaUlZMnpRV2dpdGVqTjVKSXhseStLQVBreGlW?=
 =?utf-8?B?Z1VDay84djJjNzJiSDJQOW9DN2ErMmZ5cGxkOFc0UGFRa0lXeGNaUk0xNXJF?=
 =?utf-8?B?NzhKOXgyMGdaS3d3SWM3TGYrMHJkWjR0Q1NFdThaRE1ENUhMRGRKMjFqcGwz?=
 =?utf-8?B?enk3bjgwMmNWK2NUcXMxd1lybUg3RkFrV1Z3VXRJOEpTdlNsL293cmxzL3BZ?=
 =?utf-8?B?dkRqaDhuT0V5eFJBTmpPWnpNb0hTdStuc3RTNk81cTRtK2FjYk9kOU1zdllB?=
 =?utf-8?B?cERyQTh0MnFJYlUrdW5HVllwTCtvOTRFdDF3ajhmQ0x0RzJMUTQxZ3FuNjg5?=
 =?utf-8?B?czJKdUM1R0dvUWhIM24wK25XV0Z4YThYVmkrdUw4bU11dWpLUks0Y1ZoUzd5?=
 =?utf-8?B?RE1MbnBoRzFiakxMSXRFTDhDOTNtSE9GQlQ2dUt3MkIxVk9XTkY5MmZrV0pt?=
 =?utf-8?B?dGdyamtUVjJxdnlBLzYxZ1F6SjdWR1lmQ2NVd0FmMnZCUXNlckxpY1ZSTFls?=
 =?utf-8?B?S1RBU0hrZzdHeVB5ZFlETjBmRXVxZGQ0OHdJVnpIZ3p3clY1NHN5REU5ckgw?=
 =?utf-8?B?ZHNDNC9ONXRpYkVXM3JzdnFIOTdwK3pJbU5PZTlRNGdlWjc3VG5vOCsyNkIr?=
 =?utf-8?B?eDBwcHVNWWZPTFFISWx6ekplZThjZS82cit6S1lXZ041VFJ4WThheHlhak9U?=
 =?utf-8?Q?KIyyw3g9RLxXHsbUaG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c45f0c-eb79-424f-19c8-08dec7a004ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:58:42.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6a5OKmtB73YBth2nWeY3nnl/rnpbJhY08jDyTWxP/z/yKSiPaBZw0alaYLUBbDfv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
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



On 6/11/26 09:26, Srinivasan Shanmugam wrote:
> Provide a helper to retrieve the per-file eventfd manager associated
> with a user queue manager.
> 
> The helper resolves the eventfd manager through the existing drm_file ->
> driver_priv link instead of storing an additional eventfd manager
> pointer inside amdgpu_userq_mgr.
> 
> This keeps the ownership model unchanged and avoids maintaining
> duplicate references between USERQ and EVENTFD state.
> 
> v10: (per Christian)
> - Remove the extra eventfd_mgr pointer from userq_mgr.
> - Use the existing drm_file link to access the eventfd manager when
>   needed.
> 
> v11:
> - Replace defensive NULL checks with WARN_ON() for conditions that
>   should never occur. (Christian)
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 99c711ddf71e..427c09c83d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -34,6 +34,25 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  
> +/*
> + * Get the per-file eventfd manager associated with this userq manager.
> + */
> +struct amdgpu_eventfd_mgr *
> +amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +
> +	if (WARN_ON(!userq_mgr || !userq_mgr->file))
> +		return NULL;
> +
> +	fpriv = userq_mgr->file->driver_priv;
> +
> +	if (WARN_ON(!fpriv))
> +		return NULL;
> +
> +	return &fpriv->eventfd_mgr;
> +}
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>  	int i;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index d1751febaefe..8c4b55517a0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -183,4 +183,6 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  
>  void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  					struct amdgpu_bo_va_mapping *mapping);
> +struct amdgpu_eventfd_mgr *
> +amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
>  #endif

