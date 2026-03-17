Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C930F33807
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EE710E34A;
	Tue, 17 Mar 2026 07:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nNSSxRxX";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BDB10E34A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRK4x0ewG1z9ubbTxCVNP1Sqk35dmUeQ1Noa8QWDDNtXxqDLLCboxnk0L9K1hrq4JwmGS+HI6Kp0o+07JKsPtBhtS/QZhgFxduyQp3BFmpO5YMcKvcuYqjsWe87Z/mIhrQIqVzF3JEBdcq+GgQZ23yciHufueIPnc1KmnoKZpAmNbuQ1Wxrx8V6w/hFkU3AneDUuobl6m5fYM4YaKYeO27NBnM+1lO5OUBDV4A7NcXpXGdWaoNWPEB2yq9KnqVOdoaXcRcAE6o8ukRiaB2lzkHIBfiLh6qs1f2MbJPBfXF6V18BYqpKzri/u1LDFDnGwRwvCLFTje0+uslglRhVRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej32vkZQSA5XE4MJ+8fRRFpCCu0ki6NfVyXTsFJ3C6c=;
 b=bRUEOyJI9zXNn7qjLmIch5v4el6n5+JWjzYcSqNBwG8Req44XNOsKMy71/RUoHlpmW1hr7bXy4vxZTvoWnWBmShDkT01UtTf6ri8+VDACYHIk7qsDoLX3xKSaBAse1pf9TGACyJJ6vTXlaTUaITTBNKoveiz71FfDLRpXVHkoN8dSwTXfDkkmtUDHUv0GUGpFtKV/b4HfAZ5fqFcUzYqWTMG02OuMgX5uRANBAseKrEazLIPzk/8rC8/+tmaIsepr0njMfk7bLZcw9Pnglj52QLJM6UIIA1X2Ovd79E80BUvsehUpwBNEBP6h9ONT5UEtMtcnSm79Eir08qwQ4ZI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej32vkZQSA5XE4MJ+8fRRFpCCu0ki6NfVyXTsFJ3C6c=;
 b=nNSSxRxXFG/R/TO6niZgvh7AKXigQ5SI6nxossxIsOJ/jJMMlK7ZFXv6ccVZ7FPbcr1mtG2105PiWHP18JnuVIhwMHkSltxxjlDXGA49l6eS0LsNAY2uVR4iKjl1SS/eeK10j0ONAYoW5jNmLvlRErXZ0+X3gnS2aZUCRm6ooSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 07:07:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 07:07:39 +0000
Message-ID: <e83526a5-2ff0-48b7-9a42-6b297bf2de6b@amd.com>
Date: Tue, 17 Mar 2026 08:07:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
 <20260317011713.1812421-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260317011713.1812421-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: ba01b409-b8fd-48a4-8949-08de83f3dfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WwaolS75AV6PrPOfNM+n7n0sCmJpXOP+1pRxi+kPDaTeb1DIcUKGXcUU2Ecwci+xQQ2fYFB3OHIT0ocCfVoYw3h+zLzw/BKhlk+kTQKYpiLZbDSpIi6XvwJ0zF6yYbMREyfhXpM/2Og2NmZuCmMw0GGDttlN1GTvbONv3S414X5mBnYsYN4JW8gFlaM86sXp8I7i3UZYRTyPy9Ca9OpApekKr8HI6AtqpEq7kA5XR6pArkhKJIRSleaYl0V8zQRujERGXPjuCmp13MmiTWIwdS+rIa9aMa7JdgUEMwSVQ7fVzjfKvxi7myp9yVQN0jw/BGIQqgAYakwsbu/X8lxQkIV57LaVyxUCZ3XvSUL9xhmD/j+OY4RNVvcv6XiRWB7jzC2qOrgSgd6IaBFj3RYC7cnE0/LT7V5+gE8UKQXVbgGvFBwowKncQKqo8gu8ucGCQ7MQ63gvtO8aiaVFo+DUTmfZT+8iujw2yfa1/sMLAAf3dr0a78ZcB7+q7QLhLBGapylE+KKhY4vp0uzNTWELoEO4LM1gY/94P339E67HEyuX0qEzSlXW2CbmsUnSQWnLCmW4DM+bPf83oe+TPdNXxb5hICE3MFCk98wLDOyYix6JJrBmb3RamAP/wd8W4Urk6Z3uYc0XNlq+WmVTlGaMcOLpqAe4uKQvHwL7ISau+GuIwL2Oq+hIF68sTGgxQZrXrBWdhaHfqsp7QuQOHsqqtclzJniXWfZUg+jYbWJFtww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhsWllGNm4rQ1Z3T3lOTkF4NFVkb3doRUZEQjNDZkRicSt1ZzFpd2tsZzFl?=
 =?utf-8?B?YXpqa0lRRFJhVEhEbWJRLzk5Nm83Q2JFRENjN3hZR0VnWWpCTWZMa3BrUUVl?=
 =?utf-8?B?MHYzOGZYbEtTeDZqRzFvN2xqSUYwUUFwYWV2eE5sbCt1eEVPUmhvSzc1ZVZB?=
 =?utf-8?B?UXF5VGErOGdIeDFPWXdsRUxKeHdLU2ZiSWdRZFVDdUtiRW9NVTdic1VKa3hF?=
 =?utf-8?B?UlF6Z2U0b1lMTXUra3FKNDF0ZGQ4bThMQ3ZSVHF1NWdTK2ZyZ0QrRjZhU2Q4?=
 =?utf-8?B?cjRLT0tibSt4VVlVZmQzOVY3LzJiaXM3VEo5YzRXWmhGYUh2aDZINHlsL2Nu?=
 =?utf-8?B?bG9TVWdEZnJUTkQ1ZklwMmxVdStxeUhvbWk4QVFqUkZrVTV0UUxocDFGRDJt?=
 =?utf-8?B?V3NIZDhMU1hReXlrK3FQZHduT0lrYXk4QTk1a3lOZjZ5ZzVQMUJLYWdtYlVO?=
 =?utf-8?B?aDZLY2wySXc4SS9HU3ZqYzZMcXZ1NjQ0ZnJ5ZXNQZWNHQ3NuTFlYd3JnYUZj?=
 =?utf-8?B?V2VLT2cyZk9odXA2VmhTOUNJQ21QdGhKUVVoeXczb0ZOUzNaWTFab0xmREFP?=
 =?utf-8?B?NzFISERXZFRPYlh0YW1BRVpzeFBYWmxka1pzcTc5K1RkNUl2bkVPa20rbk4w?=
 =?utf-8?B?NVRNblpINnB3OGw5dnRzVDNZOU9RMk1yTXNFenRWUld1cFNEUkdtdjRYMS85?=
 =?utf-8?B?Y2tsRklib1NoeUtFcjdUbEdIaEJmTlI2VUVZUGJRdXkwMmdPckZ1VVg2V0h6?=
 =?utf-8?B?Z3VMenU0VTVLZTBZMDgyQXRrVzBRMUdpQ0JBWW8rMjFnVHFpMmxoa0dxUzA4?=
 =?utf-8?B?Vm4yb0o2cUloN1ZhcHNTN1Z2SHE5VUdUTXNRWVhlcGNSSVJoTGhjUENYZFVR?=
 =?utf-8?B?TGhLVmtQcnJ6RSs3UXVjTFJnZFFEd20vS0poN1VLazJZTkh5RkdKME9SRDVM?=
 =?utf-8?B?T3dHTFBZWGhvTGt2d21NRkhRZFQ1MlFrOHljSVh5cUt3amxsR3dNMWFiZnU3?=
 =?utf-8?B?ZzExMXFyVzlyWjJsNWtBZ1prZVBVMWN4SnRzQkVXRlJwYmR0Y3lETEZRaUpt?=
 =?utf-8?B?aHd2NzJKT3BpSEp2MlNoZFB1UkdYamhjT3NPNldwWGdUQ3B5WUdSQTRhUmd2?=
 =?utf-8?B?WkZ1bUs1OHFsRUd1SWpwOExKb0pOTFdJTG1JaDV2Y2JjVmtURkJGYWU3bDFO?=
 =?utf-8?B?RzlyTGlGVStrV0tEVFpoNnVweEpyYUVlRXAyeFk2bTBORkl6cCs1Qmg3dXl6?=
 =?utf-8?B?ZXAzMStkdmR2cG1pZlEzaTdZMWgrSFRBZHhaanhiR25JeGJqSnNyMzJXZEFk?=
 =?utf-8?B?VWgxNkxaZmFRdGcxd2FRT01xQVBHTi9QdlZUWURZWWRva2g0TUtpQ20xVDZN?=
 =?utf-8?B?OTFDcS90MXFlRG5XcEN1ajhaU0tCTUxKcGZnV052RDRTZVMwQjViVXBLQmZQ?=
 =?utf-8?B?d1MwWW9KQjE1enR5YURnSzVDMHhxT0gwbkdWOGtpU3AxWGRaK01wWDRTcmxR?=
 =?utf-8?B?ejhvM1dpMExXcUF2K1U0b0hhVGZObTVuOHJENHVLSTVxMGZPUUxBZjc3WDkv?=
 =?utf-8?B?MUE0ZWgrWmVka00vSVEyUUs4Y3N4WWZxNUY4YzBYTUlraUsrcnJhTkYvaity?=
 =?utf-8?B?aXpkRXBlYXd2aXUxTkF3dkdsTmoxL1VXZkZQS3FMNmE3ZWs4Z1BOeHQ0Tkd4?=
 =?utf-8?B?ZVg3QUdXdHhVdUxXYjNJRkxZemRQcGlJbDZoZDBOQjVINWc0cmN2UCtub1Bn?=
 =?utf-8?B?MmhhNTFKcHI0L01kK3FaMXFnekY0bVZrN1FZUVIxb0JwMXkrT0YvQUp1bXA2?=
 =?utf-8?B?QlREaEI0Z21wYS9xV3kwNnJ0WStUWTFEbmp2Sjh2K0l5M1ZsUllKeHVQbDA1?=
 =?utf-8?B?SC9xcnlDNmRSQkd3M0Q5dGpBQUEyY3pMQ2hQMjJxS3c3ZHJwa0gvc3pISXNJ?=
 =?utf-8?B?VVgrRXovT1d3UTl0OHVadGRzbXM2RGJsaksrM1NPNkYvbTlzQmszbmVMUStn?=
 =?utf-8?B?T3psR3VJaU1xaUhzUFlEUS94MzFFSUF1N3pCK1pnMU5jUWhjaDZPRVJXbFpU?=
 =?utf-8?B?RHUzVW0wNXM1YlJVa0x0dG9Lc0YvZE5GTVpYS1RQNUxieUI1clZsTXdXOGFx?=
 =?utf-8?B?VEZDZE5lZEhFK1QxQmdlU0Q2Zmc3WldoUEErR3A1Z0JTekxaMGQ1REkxcEly?=
 =?utf-8?B?VlNJajdPaFFCSGNMNXEzdnB3MllUSjgyWFVuZ1BjcytNbDRuSzFFOGlCL1NB?=
 =?utf-8?B?SzV1UXpaWExzQXhQTmFJY1o3cG11d3NIMDIwK0xPOFFIVVNlUFp6dTlKM1M1?=
 =?utf-8?Q?OIRtVSN0WL+jhpo/K8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba01b409-b8fd-48a4-8949-08de83f3dfc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:07:38.9987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WU3XNO8F3qo2Ajkhmnzm9A/lA+Ifufqew34TmQvJlCiFF/dogV7ItGmnnSShBRua
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
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

On 3/17/26 02:17, Jesse.Zhang wrote:
> Tighten the early parameter checks in the USERQ SIGNAL and WAIT ioctls:
> 
> 1. Validate num_syncobj_handles against AMDGPU_USERQ_MAX_HANDLES in
>    addition to the BO handle counts that are already checked. The UAPI
>    field is __u64 but the driver stores it in a u32, so the comparison
>    must happen before the narrowing assignment to prevent unintended
>    truncation (e.g. 0x1_0000_0000 would silently become 0).
> 
> 2. Reject inconsistent pointer/count pairs where a non-NULL userspace
>    pointer is provided with a zero element count. This is clearly
>    malformed input and returning -EINVAL early gives userspace a
>    deterministic error rather than silently proceeding with empty data.
> 
> No functional change for well-formed userspace callers.
> 
> v2:
> - Reworked commit message to focus on parameter validation correctness
> - Updated code comments for clarity: describe the type width mismatch
>   and why the early check is needed
> - No functional changes to the code itself
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index fad595401a77..575dd58ed152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -480,8 +480,25 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	if (!amdgpu_userq_enabled(dev))
>  		return -ENOTSUPP;
>  
> +	/*
> +	 * num_syncobj_handles is __u64 in the UAPI but stored in a u32
> +	 * in the driver.  Check all three handle counts against the
> +	 * maximum *before* the narrowing assignment so that values
> +	 * above 2^32 are correctly rejected instead of being silently
> +	 * truncated to a smaller (possibly zero) value.
> +	 */

That is completely unnecessary, just reduce the variables size in the UAPI as we already did for num_syncobj_handles.



>  	if (args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> -	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> +	    args->num_bo_read_handles  > AMDGPU_USERQ_MAX_HANDLES ||
> +	    args->num_syncobj_handles  > AMDGPU_USERQ_MAX_HANDLES) {

You don't need to check num_syncobj_handles here.

Regards,
Christian.

> +		return -EINVAL;
> +	}
> +
> +	/* Reject non-NULL pointers paired with a zero count. */
> +	if (!args->num_syncobj_handles && args->syncobj_handles)
> +		return -EINVAL;
> +	if (!args->num_bo_read_handles && args->bo_read_handles)
> +		return -EINVAL;
> +	if (!args->num_bo_write_handles && args->bo_write_handles)
>  		return -EINVAL;
>  
>  	num_syncobj_handles = args->num_syncobj_handles;
> @@ -639,7 +656,23 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		return -ENOTSUPP;
>  
>  	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> -	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> +	    wait_info->num_bo_read_handles  > AMDGPU_USERQ_MAX_HANDLES ||
> +	    wait_info->num_syncobj_handles  > AMDGPU_USERQ_MAX_HANDLES)
> +		return -EINVAL;
> +
> +	/* Reject non-NULL pointers paired with a zero count: the pointer
> +	 * is meaningless and indicates inconsistent input from userspace.
> +	 */
> +	if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles)
> +		return -EINVAL;
> +	if (!wait_info->num_syncobj_timeline_handles &&
> +	    (wait_info->syncobj_timeline_handles || wait_info->syncobj_timeline_points))
> +		return -EINVAL;
> +	if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles)
> +		return -EINVAL;
> +	if (!wait_info->num_bo_write_handles && wait_info->bo_write_handles)
> +		return -EINVAL;
> +	if (!wait_info->num_fences && wait_info->out_fences)
>  		return -EINVAL;
>  
>  	num_syncobj = wait_info->num_syncobj_handles;

