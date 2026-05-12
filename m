Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C15CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 10:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D389C10E155;
	Tue, 12 May 2026 10:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JEnvNNPw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE53310E155
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 10:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9fQUq8tGXX9v+zKwBT8mUq5lOdCpmpZnaFhC+b9qO8lnDQ8ExAh+w/yP8+HIDFnrkUXLLtWDEtlN55WrLedLGDPSTlNRLyPK/BNEKwo0VqSb/qxmZTM8t65SXb3BwbB8I+yefwCnnL0s03d2yrW6872whaHP5Q23Rn7EjEF/8hVf4o9fuMWeqO8NFWHEc1Z7BNxy9CwUmJbOAda1OvQIkMQ33ElE9H+ig4CZG4MAqGqa+JQ3D4OCawdO6kKQFq2YwUNoJ4FqkHYRoWjE+pfu+fb/C8/31yZ8HplRzmWHo+uIln5MT23++MErCzem+YWefuElnfIzSSiJTEP0/gXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M81fxNg89/hDqGWopk0VjlALGgZRt3XZjBzPv0M27sI=;
 b=n/sMwMG4XdZc9bTlLUzlR4mva/lB9Qu18+V4dZrO2aRaQnzeG5Hj9OLMrida/SpMo0Pe/0dXGq6P3ptcyttodHUBSI3r8C0oO4rtPLZrh2+p6z78acR+cGCJ/OaA+J3KS1exkJMpslXebm96tOpd+eIpvr7NgwCjvi42XPlo8+cSwjBYDGLkdArbZTOfphTqf6qYuQ6YXWOzQn5/jASBQfSM+IYAe869aJjPLnhIXq4MQyJVbeT5apXyMZSLnI/kq3UEUr09joEutts5yD/g/ZfRoVL6GZvrlEW+bgBXk/AXOmhtbc/Wo+JUegIVaK9O5iGXIaPqwRzGEACzGim2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M81fxNg89/hDqGWopk0VjlALGgZRt3XZjBzPv0M27sI=;
 b=JEnvNNPwi4PuUP6V8S0XUIskP1/NVvH7N5EdVRQV2enOrq8nb7etmwFrTXdwMqbTJGQniS8g29U4a/4oOYuxRqbT4l75nWgFoKeTwwFndh77reBqRy+u92Sy2ChFoGR9Jv4UQq8M99AwlBNGpeQIkGDOSOD8KNn5XpJWg3pUPUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 10:39:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 10:39:30 +0000
Message-ID: <5d6f5153-628a-47fa-be0c-eae8f2851113@amd.com>
Date: Tue, 12 May 2026 12:39:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: update the vm task info during signal
 ioctl
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260512103208.1012595-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512103208.1012595-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:408:e5::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f2c7bd-ae95-458d-64ba-08deb012bf27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dspnCjSgEuv4obYcGiqsBiKl14l8XTUUfa/+9tlUpGGm7L7ZdWri+h1KftJJDdMB+/HjKmllnUK7i5c1eSgg95IGdKzznm5yHlKN9/PwJMRq5/q+K8wqLf0gwqCQPrSYUZUQpA1iYg7o/ZLJvnpEhLC5kJDN4w/6t39RwC4aMz0pniL8SeCofXeqBkMrMFszMI9tfZCyWlZHSEm8fP4TGEszt2VwKllVFjCcZ4YZfMSLwgE3hlCtVqrnJ4thIQitX5qxywPCBS2k91MOOKpX3luO93vF+Q9+7q1Xq9EEA3ZzU5X8Dm4HQ9QAKW6Y3R61jQWZLSh8+nrXAyJektn6+Ns4nyoz2pilMoFTd/v8Vg2fxfQ/fRh9Q8iCxhIcbSNMylKVOb4wxF8JztxRdvlBJh56ca6EYTxWaDNVbVsyfHpx7TxYY0v1TAjcvOv70DdyGRXEVj/4gpQKAtoadR6DecFiLM91S942+K5pwWywyxCrdYAjzqhHjCTyj+hMsLQI8r/o8sQqoSjRLHqjSvJfISsA8sSzAyrF6hyVDdYCeFGbgaEqu9b8snOsmFg/jjYLPLCKZUnc3T/gdJnSzQCGET+oWBVpVwKa1t7NyTRXevTiu8eT86QuqpnzYTnOhvHIanU4upRrjT62FpYTF6CkenNsZnmGYYIx2PzuZTMc2j3hi/8XRSwjiHEL1LAfyIgc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1psRUhqSHh3VHBZejNMMWxRbjJiN0I3bUNlTWpGWmxHekZ2NURxT3lPT2Iz?=
 =?utf-8?B?NVVSdm9aaldIQ0dLVnVpRHROSzVYVlBJL3NPTnhOc3NTcmJSZjhrbnZEZyt0?=
 =?utf-8?B?Q0k3eWF4RWdsWDhIZlNiUjFDcEQyQXZhdWxncW40WjNyS3BnNDZGUml6Q2Yy?=
 =?utf-8?B?TEZNK1gwaTFDZ3hDNEFVVTBDWUNOQVNEem5rWmowejVUY05vbGZZc2tzL2ds?=
 =?utf-8?B?c1RFRUdqMUNGNzVLUnlQNG9mcXBXU1ZUc3JiZzVDSmJ2OGx3a3RsSnNDdkZq?=
 =?utf-8?B?Umh2QnB3YmVLV0JyN0NSY3F0d3ZoV09CWUc4WXI4R1haWE1OMk11QUFZVFVl?=
 =?utf-8?B?YTVSMkZZazVwN1V5SUVXdDJyWnNkY2tLVDNLQWo0OGE2ZzNpSXI5V2duWlZT?=
 =?utf-8?B?eUJBNmY0TGVLT2h1K2QwVG91QkRqQUdjQnAvcnVGTE9WdUx5eW9yL0ZFVWNW?=
 =?utf-8?B?Ym1hcEdrNHVPUFVQZDh2SnB6dWNvbE11OXBwN0lrRzV0b0VoNXE2V2U4YUl4?=
 =?utf-8?B?R3dVcEJKSVpxMUFiNmt1dGdwWFpXWXZCY1dGTENRbzJHNjg4Q05zaHUxbmlJ?=
 =?utf-8?B?OWZ0dEI2dG0ybXlYRjNHS1ptaFVleXNNNE5BTnJPQ0pJc0JIT25GNWYwaFhv?=
 =?utf-8?B?TENkV0UrRmMxSDNDQW04S0xLK09zNzdheXJQVkR4cE5VY05Cd052QUt2dUIv?=
 =?utf-8?B?NkZIWCt3VDI5dDZLVzJjUEQ0cytNUmRXVzUzOWdaQVdCclRtdWpsTFF0U3NV?=
 =?utf-8?B?VEVkQWF2cXhjTEFhUDlLWmZUakRlUHlRc3JkeE54WVloV1FQaTlkU2VuQWR1?=
 =?utf-8?B?VTg1K0haTmdWRXhaRy9yVmR6RjNtQmZrV1NyYVVqbFF4NUhieFpWYjJlK04r?=
 =?utf-8?B?dVk2aFlaY25RV2lZUFVrcVZGTEUxWUNGN0hnZExhSW02OTZleUo5d2IyNWo4?=
 =?utf-8?B?VkNneUNodXQ1MFIzM2w5YjNGNzQ2SW1JTjNHOVRDZUxwZ0Y3SWZvQTdEKzYx?=
 =?utf-8?B?SCtBVHJZNUUxZ2JNYVUxTWExcisvZWpCMXFnbVp6NVFac2FwTzBNK3lEZ1RD?=
 =?utf-8?B?QkpGUVlraTVib1I4RlJDUWZZRVRURDlucG5mUnF0aUtPQkNJbnp2N3FxWlZu?=
 =?utf-8?B?aVZqc2lCQTFMa3lzczlyVzA3YzF1S2tBS0RFako1SVNJVHVtbHN3VDNhUTR1?=
 =?utf-8?B?cWdvbHZHQUNZbENZeitJdGhvUjZCTjBXRytPV0hJTlVId3l6MXNWUmY2bjJE?=
 =?utf-8?B?d1c4alJGUm96cG53eEh5TUJjZ25zd1NqTERiWUhCL3FFZWJlNTNMMDRpRlJn?=
 =?utf-8?B?ZjhOTUlDQ3ZTZmsxbWJicWp0NElNUFR3cHlsYVBiM00yQ1cwU0ZjckovNDM4?=
 =?utf-8?B?eVowZ2pTRkp3UzR5Q1JEQVVWWHEweEMvVWFiOGdzWmlRcmNMcVQ3S3JGOE42?=
 =?utf-8?B?UG9QTFZnNFh2bHJ6TDZreFZWWU9lQjd2R2YvOEVSSllmNDRUb2pJK24vcnNO?=
 =?utf-8?B?NE9DNHROaW1QRm15Zlc1d1E4c0dhY2pOb0RaZ2wrN1grZGU2NXA5YSt4d0Yw?=
 =?utf-8?B?cURGZmhrbVozOHZzN0wrQS9uSWhmYUVrYmR6eVYzM29hbmRhM2t3NHJLTmZj?=
 =?utf-8?B?LzQ5NFA4MlZPTE1zZ01pVXNHcmF5TXNobnh0eHk1aHk2MS9WNGIrVnVuYU1q?=
 =?utf-8?B?UEo1TFBBdElWRHdielBaSWExSVN1M2xVSEx1YXBoOWJIMUlzLzEwL3ZXY2Iw?=
 =?utf-8?B?WTRsWXdYc1RwV2lnbG1USWFyek9RSm1lbFhSZFNJOTUrVEd2ODNSYjJsZVU3?=
 =?utf-8?B?aWlCcjNVTHZMTnF5RVhYMkZTWHU0YldsQ0l3STNxeEdSL01lQzZqWURiRGxT?=
 =?utf-8?B?cEdleU05UFBBdExDREF0bm9aT213OGMzd1p4OTZuWkYzRzRKdkV5emdLanVt?=
 =?utf-8?B?c0RleEkvRU8rTEIzOFpyY1krMHpGdURrc3BIS1ZDaXprL0NJSVN4RlRZZFhP?=
 =?utf-8?B?eHdYVGQxSDJVRnU2WEI0WXF0M1VUdHZEb3o5SndHV3F1WkFKVVRUTWVCNFpY?=
 =?utf-8?B?VGZqN2dKQmU2d1lSWWhMcVRwZTk0bEt5LzZJMzE2dVBmWDVOR1B4OG9meDFO?=
 =?utf-8?B?bFZqelp6SEVvSGlZRDhNUGpZK3plUGE1MnVHNFVzdCtkTmg0NkU1UnBpa2pZ?=
 =?utf-8?B?ZHBMM1NpWk1LQ0VORnlpdTdsUlZ0S25EbjRiVGczSFRRQ3M2eDdUNHRLTjU4?=
 =?utf-8?B?aW9BUldpK0hzYkpFRDRhSC83T2JWSlFHb214ckhxYkRrQWFPY0FvL2xnL0Ey?=
 =?utf-8?Q?EnZCoVGZZtZ+Cwle0c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f2c7bd-ae95-458d-64ba-08deb012bf27
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:39:30.5620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4hKIlXQuxL7tIMPuZdLYcO0QU5YyMiBem4ADuNnlFYUv0BFNU9+7gJpqqwmTzTO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

On 5/12/26 12:32, Sunil Khatri wrote:
> Pagefaults does not have process information correctly populated
> as vm->task is not set during vm_init but should be updated while
> real submission. So setting that up during signal_ioctl to get
> the correct submission process details.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 008330a0d852..1dcde9b35f8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -514,6 +514,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		goto put_gobj_write;
>  	}
>  
> +	/* Update VM owner at userq submit-time for page-fault attribution. */
> +	amdgpu_vm_set_task_info(&fpriv->vm);
> +

Doing that in the signal IOCTL is probably a bit overkill since it is used quite often during the lifetime of the queue.

We can't add it to the userq manager creation because that is often done by X/Wayland instead of the final application, but I think we can just add it to the queue creation.

That should always be done in the process which is going to use the queue.

Regards,
Christian.

>  	r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
>  	if (r)
>  		goto put_queue;

