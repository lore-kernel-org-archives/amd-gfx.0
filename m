Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E396CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6F010ED20;
	Tue, 19 May 2026 13:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gdQJgRzk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE24610ED20
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzlZH6D1LpooE/7cH18kpY958lz6dcOcdz9l/4cTVX6mm/UtgKLpWwSswjB2CVhJN2sPpXldSxo1BMvYvIPaMvMIZPKWE8ZQORG4aVk94SwaTyWlBH0LtAkc8WMahW+w6Pu5X9YRcnpKUnd08/2jonKQPbnoOWKKFFxghlaRdFjLMYpnPnzE+ov3LfKH6AjE+LkD+ZUzGlbhGNdTu1+7BdH9R+MQyFrM1WdF8GvyHGxP9RSpbYXY4PrF8FolzDFuydl6x5ekEiDpcWqGBLXAZxRo4IJSF9kYp746VfooVFxosQXe9sciuR/t+qn0dyhpBLGUYq227So8Xq49IyWP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yu35N9AWettRw9QXfpUPQqsnFqWyw2Zwqtd5aCP4cu4=;
 b=oAmvtDWhicnMkZAZpVA7xM65fdQ3QXyU7RrB6841ZUOuyJdCQM18XJZbMMXWr8TZBPnNkLnu8+QsfR6xVJ87RwRySxczSmDQv14OcXH2PwNLIrhMLE3bS1+OAzKJ+sX8veH8EmKaGcbZLNQCBQy1rePp4cJOM+ZpM/fCQyYtWEEII2uizfL+m0NQafMFiKRa8Y5XTGMAqLXaT4Yd1t7NHsoS9O+k9DeftU+lPuetngjBf3am5Jce5i+i6/IPPl7wcZvoquyKxbO/TlWKApQouIP94A91ZmK1OZjP5W95N0h+EtLHsqUAY4oH9wr9GjvPGHhDPBqCgTizmbQ7Nd0UZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu35N9AWettRw9QXfpUPQqsnFqWyw2Zwqtd5aCP4cu4=;
 b=gdQJgRzkjFurxZL/FS2Nx+RG6Vy7W+bXPgZEyuCilWiM51F4v7Mnvu01vLaodWApf1oZQl9zQdCIMjs2OO22eHbLREKyjTkh3NijOCVgbiS4x1U4fGbYVSLQ+FfSW9kCRubnQbGpXCH0u1gMdenSPFc70pBLEK1kEjIqlr3cMFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 13:54:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 13:54:01 +0000
Message-ID: <9d29e0b1-205c-43c1-9707-ba9709f35418@amd.com>
Date: Tue, 19 May 2026 15:53:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] drm/amdgpu/userq: add amdgpu_bo_unpin when
 amdgpu_ttm_alloc_gart fails
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-5-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519111801.1435954-5-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 04329c0c-01b2-464f-6d55-08deb5ae151e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: YRmHB1AX7ByNEvg7GXY0+OOhJryPLE5dNjkmjbuEnrwq2cD2fAXhAYhzey8rbx9YjN6D1eVx43ENQbTioQRf6b9oUB7UOAnAgXBs1FRXVrkuhBe+jjw68kSPlyg5y3MjPMltvr4+9D0vpcDbVrMld5pHUWj+VR59M1olIuHvz91ijH2iTwDNcpEn1I/2NuUyWvq8sBDAiPao6PqSGVcqEXrJn08KJQo5kzWFn+d1QJuhgjloATJoxBnD7lAg3OPE64joFOwdU71jLybLlFv3P+KvOr8Sj8CEzoOVyqdvt+gDmOwrHHsAEJjRIxC/u6CUaReqk/eAFxIuJysrTPJmi3f8K7GjD6+sPPCOsOLGEgj7cNkY5G9CllNOw/+GiHQtKS+xSLI5R5MlKgqiwPPyK/cR8vBvnSrKMSCsvFWmtQgUbhw1JF5d0YyOwx5nh3JICB9lRsCrQ1Sa42QOszl0g9m4Rx+LINAFyUbbf2bZCODJnC13aSENcBwJzSBYnv/3YbyZ0Uqn4am21a7m9pilQW4T5p9200eth6SzFc32+YR9k46trEp2qOSRmP+V5ge6N1czCZmh7Mj37j0AHgX4IsXP5FEWvEPuW6HX66+1wd3CydgshWZrI02d5aujKLNHKNUOlhc7J7J4jWegUZKez8tNp05L71TyN2F2WPz5ipeUUdUJYQ0UIO4Y2P5IBZUg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dwbmduTUt6anEyb1ZXUzNlL3FFNVptaDcydDhyYkZ5YUtYUFRUejZyZFk2?=
 =?utf-8?B?NzUzOTlUWU9lSWhyUFo2Yk9YcXpMaEZrbytBZERvTitmQVFtcWZGOFQrazBt?=
 =?utf-8?B?aUNaelJQWU5kK0tDdW41M3NkWCs4VnJnOU9kdHhOUzJqU3dCUGZkRHN2aDcv?=
 =?utf-8?B?a2JheXVKWkliYUNsSlluSUYrcHU1S1pJdjR1WEV3UjZFc2V5c2UrdzJ4OENE?=
 =?utf-8?B?Vm1Cemxremk4clZmNU42eGY5NU9nYy9KVGpOZkVZeFlLd0U5VytuYzA4YWdL?=
 =?utf-8?B?YlVubE5IeG8rUk44SzdqV294V05jYmxMaVhubklERWVQbFpGdGZFZWZ3dDRa?=
 =?utf-8?B?Z0grUmZ0emZUR0tiZGJFcDBRMlBPVTBNUEhuQ3pmOTh4Y2NzYy9PMytWa0Ny?=
 =?utf-8?B?aS9BRDVTaTAwQ0VXUlhxRkt1Yk1PQUtKbkZHL1AzcHB6NnFvVUE5Q2grNkJZ?=
 =?utf-8?B?K1lpYTl2Y0VFODMzK0hST3E5NG1jRDNCZThSYmltbUtnY081YlJhbFdDMzlS?=
 =?utf-8?B?bEFzSzhlRjBYYkFIK2Q4aTRYTXpxUFM1TTBCeXcyc2dja3V5SnJvOHJUUm1r?=
 =?utf-8?B?MjE4dC9DMVF4ck81Nlp2L21QNU85dmFmci9FeE9iOXVDZ1VkRWVYWEcwOWho?=
 =?utf-8?B?aHNaZUJjcnBFR3BITEMxOFAwYllMcFMvYzJ0ZGVxaVB0WDFUSEFLTG1VY08x?=
 =?utf-8?B?ZE9FcmxMZkd3Z0pGV2RDbmF5TlBKUmJMWEtHbjYwcldVd0dXK0xZY0h0Qkp6?=
 =?utf-8?B?aVNCeXFEZEZRSCs4bmdXTFEyaStWZk1QS3dhNmNhYWhmc3I0MkFORVFvREhv?=
 =?utf-8?B?QjJJRDV1NWNNck50Tjlma3llNEoyaEtBbFVLWWlsYzMzRjl3YkttN0F4eC93?=
 =?utf-8?B?aklaaUJmT25EYkMxUjZESEpwaGxWZVZtdmRhMG8ybW5IR3BabTBCaUdpSHph?=
 =?utf-8?B?dERYL3kxcG5wVVMraFU3ZDRHWWp2Ny9hWEROODRobkc3MlQ2MHQ4Z0t5Y05R?=
 =?utf-8?B?UUE0NHpOY2hqdFhKZG4xNHEzVWNTL1JJeGJZSDM5R2tiNXNIelMvR3FFY0JX?=
 =?utf-8?B?RmdEQ0ZlVnVSelY4bEtuamtPVW5pVFVIcjdrVkFoVlN4Zjl5cUFTZVV4UDEr?=
 =?utf-8?B?QnFHWUJxZzEycnJ4WWxMZHgybkVVeGc5Z1JoTWJQNXA5MlVyYmNRZkZBVlg3?=
 =?utf-8?B?Kzc0c2V2SjdCc3QwdXFmYm9mNi90RmZDMmRieFVZVzVySlNvWVp3a2lVQXM4?=
 =?utf-8?B?TE8zUEQ4eDRxTWJucGFPN0NoQndVREhZM01sVVVTQTIyb3FlZHBXWHhuNm1C?=
 =?utf-8?B?OTJ3RzhCUmhwSlFlRURaNzl6VjRzc0k4RlFnNjBkanRTSHZUeE5yTWxKTTMr?=
 =?utf-8?B?bjhWQ0JJVmh6M0ZzSUEvOExLeEthZ1ZPMTdWcEhITFEyNXhzS1BNcVZWSjdY?=
 =?utf-8?B?ekw2MXJzNThYNjVKSDhkbEJvdmtSc1ptNWM3WTVVWDYrREFvUVVsOWxUbElj?=
 =?utf-8?B?K1dFMitXM0w1UVQ4Qi9GcTFkZUN2ZXJadHVsS0RaVnAxdG9jeWlFYVhpZWUr?=
 =?utf-8?B?WWlDVm1YVzd3V0FrOTdqcHA5Vi82QzdmMkNZKzUxKzdlU0ovTmhrdDV2ZEZn?=
 =?utf-8?B?QXpiYXR4Q0xDQXZqK1FnT3dTRUFjOEZrd29aOGtjbXl0QjRPMG4yM0tXOVFz?=
 =?utf-8?B?N2hMNjd5Ky9FMkJ2ZHRQRys5dzlGOEdRamhxcXhFcE0zYUo5UWdRb2NsMkx5?=
 =?utf-8?B?R1B3Y0VCZzJCQ1FseW5kQW9VZHRlTW1XckRYWjNwMk5ySHAwREh0U0xhL1VE?=
 =?utf-8?B?cngrQUlDVUFoamh4ci96d2I0MThvaDNxL1ZIL09tTnlseU16dW1LajBmVHBL?=
 =?utf-8?B?U2tucCtWSHp1Z0p2SG1kelBBcytQdWpjU3BVaFZsVFZPVDhFT0JGMHVTRWty?=
 =?utf-8?B?d1BvTGVid1ZBNk9Vd0JlcVZuNDVBb3BDZndPSHdCYTY1UmplYmJtazU2YllX?=
 =?utf-8?B?cGM3QlZqSG93Ri9yNElVbTMwbGUxSUVoMVdMMXFFNGpIN08xNUNyZzVnWURC?=
 =?utf-8?B?ZzY2eU9LTmlxcUZvZS80TWV2ZVFhNlhhVCtSeVhXWkJJZVc0YWJWelVRZlN1?=
 =?utf-8?B?TTFqVlQ5ajlrVzdXOTEvNGZETVRkeUFMeVBNUVppMlEzQnFNb09zOVMzcVlt?=
 =?utf-8?B?NWQ2ZmpFcTRsREZvNGlvazJZTERSRktRa1ZwMzlaazhWNlFlOG5QYUYwajN0?=
 =?utf-8?B?UFpUd09OTHJtZnFaVG5TaEFkZ0ppZVAvY3RxcjFGdmNyOHFsV1ZuclZpQU4z?=
 =?utf-8?Q?sJGQwXBkgHd8maBBMQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04329c0c-01b2-464f-6d55-08deb5ae151e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:54:01.8000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59vK+HMthf1co7h44nDcvkga6zgcwHG62jnF9TVCwq24nyZe2DMcaqB5cnNOMJGl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

On 5/19/26 13:17, Sunil Khatri wrote:
> Unping the wptr_obj->obj when amdgpu_ttm_alloc_gart fails.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 14db2124ff81..2d95203ec58e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -81,7 +81,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  	ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
>  	if (ret) {
>  		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> -		goto fail_map;
> +		goto fail_alloc_gart;
>  	}
>  
>  	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
> @@ -89,6 +89,8 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  	drm_exec_fini(&exec);
>  	return 0;
>  
> +fail_alloc_gart:
> +	amdgpu_bo_unpin(wptr_obj->obj);
>  fail_map:
>  	amdgpu_bo_unref(&wptr_obj->obj);
>  fail_lock:

