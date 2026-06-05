Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A9BCD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 18:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59D410E734;
	Fri,  5 Jun 2026 18:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LsrXpUeV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60DCF10E72C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 18:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+EgHBleOwNIblSIzpNFjxjoaxiPJyE9hCTOInNMfifE2/EkOtniJyznukwD3rH6I8A+UvI9LSTWLMS21Y2TZfETFMI1WscWwW/ZXOqhffi3od6AHRo0JbWfHPxw7EtSEWmH3Bp4xZ33GaZvsyEzj7AszH78tcBGYuvN0h2Li0gaoR26+3+D6uCacMWNVuxAySlcvJxemWa2pj+ttdDcUSze7h9Uu+5JzECr1BeSxtcjru4gJDlypmqQ83ax6gpvsUrVff/MOKucJLUXxwSPRtYKKzl/3AuHkP24O1e7Pn3KwzaA5M5gLQeCJGd90GFDAVAtLbYAZjIePDIrXPQipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fxZ4+xvYO45uu6aweJm4CN58TLpmzrgbzy0rPDs4xQ=;
 b=YwVSaAXk6BrgooLpqfhdEbxwCijVG635QHptFP6zqVfIbV958tzt6JzmSsvZQaz6JDCZFMnnGEOAOWzLeo/8sATxNJ8p/JMuXXZGYQIe6YtEfzXzazeU1kYcyRmWTmd4CV2TLrm8Qcx6dMBOTPcMP2Qiyb+IaUC86FRk0rlBCQNX37tb2tb9WkibQSYtTccSg92hRUgEUyhIu91n0DsB9CY+i+a6/qZPvMI9xXAsvHZJPTski5oaxjZ3x2aG7eHmKCctSTFL7nclUOVReG09rRsbFU9bWOM9vyqRY+JDgTzTwtXhWwf0HN80l0ZJY3AnU3CXJujO5T9MlkQ9wod++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fxZ4+xvYO45uu6aweJm4CN58TLpmzrgbzy0rPDs4xQ=;
 b=LsrXpUeVeujElLS+8e0lrE4bjcGIKuGl8iJJTmnNbC7KP0TP1jgGdj8y6KPZzjA65OX2816X+whRpx//0gpfzenNXabNJq6EDIqySWBFzpB8Szm8RqeRP6KdwN1YPXm2uc5Yw7/qS6XdmYvWHsmzZVJMN664l/rkHMQDem8fZ+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:26:05 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:26:05 +0000
Message-ID: <748a0cfc-528a-43af-9dc7-59d58428962a@amd.com>
Date: Fri, 5 Jun 2026 14:26:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: allocate lockdep mutex on the heap to fix
 stack overflow
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, vitaly.prosyak@amd.com
References: <20260605091322.144703-1-Prike.Liang@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260605091322.144703-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::27) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: ef927aa8-eff0-40be-4003-08dec32fe794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cL2ZnhkN1QJ9LNWE2qkuJhfX4eYAsj+XIU2LFZ9PUb3aNTStJVd1czZf5wzPIQIlT/6vViG6n0OG1cz3bcOUo14UplsDcwRwd1uRdx4Xuh3hynnqjTJQjvzv1525q2jxmxHxKeCUUqTVJil8ORLLx/tvaA6VLen8pmI1K0Nv7SE8i9G7T5dV2x9kEXlWbHLI2Sw+dqspsr0FHETWmFrHEEGSNx9XOB5Mr99PA1f4bkIHQq2V2HtFJmoURuiLy2LOJDE0EA2lcw3zqNSle4ydLzy50enLpghG85vzkQq7chpq4JknAU4nLCAPosCozn9ZanwWz9yQt/d4pSY223TvwRMtq6CtpHBcVR/oumrkCEWsRs+4qnOWmFawxm4rU03ogB0vQMObyrcGfYQeNur3pK2YMYjF4fE/voRXP5R6HZR46fxqBT3YyiF68/vdinm4TDavN/TBm4IDLtbWPoc5GQEvP+DNQ+F1GXv4RKxHD5lsHT12gfYKa0mHtGvaI5juoqEK6YSWPnFFK4Xj0zp5P6wvsrwFfi5APsTrUd60wToMJIPY4gOnJVJMbRas09jvp216XGy20ILDZ7T63d59/qTC855vlkBl/jWhuN5FFgo4t+DJAOpXgBuruGsn5BUT+j8Ycu3w5fsj8a5Lg99d3tNsVwxif+kdp/pO2tD9Yg6v6RjwDcGjHoasbTMsVzJY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enBNOFNtWUFkakNEd0ZKK2xOeVd3cmUwTHk4MWRuYVZoZzFFOEJKKzdKNnBP?=
 =?utf-8?B?Z25HdnZsTzJJQUpWc0hnSmdyQk1LaVJOb1VTUXp6TTU4ZXdTZmxNcVFZVkVo?=
 =?utf-8?B?Z1hmZHVMbGN1MFcxTUhKSUlXOWZZbzdsb0dzRzZXSjMzeUlVcnJheDB4d0hz?=
 =?utf-8?B?U1FOcWF0bXRJMTg4K2tlK0l3Qm12TDFwMUtnOGxoVUJWR053eGJVcm5mRFJX?=
 =?utf-8?B?WXgzcGdpaEhFdHFKa0xOR05xNUxqV0xyS2s1RXhrdFoxRE5IUWFMY1kwNThz?=
 =?utf-8?B?LytOK1hJRStuTThIWFY3M2xhVkxBR1ZWeVBxbkN1c3dwVUo5eUVNTVJSVUZV?=
 =?utf-8?B?Um9CK1o1c0ZBTFZNSFRiSmFhVUhkalljSzVrRVhUTHgxN0tvMUduMWJoeE1D?=
 =?utf-8?B?T3JZWmFiMkxGREQ4QjFsZnpjQ1ZBSEVPRVRpNDdvdHhNOUZnR3hWdjh4NTdO?=
 =?utf-8?B?R1VXcGc5aXFKdUF1UDg5YlRrSHczZjE1M0lxMEordGN6WTdYMVJ0UGZjSXRn?=
 =?utf-8?B?aGFrejhQdmgwblB3TDRKM085YXRPRkd4RXArNkdPWU9mQTBaMDg4VGlrMFMz?=
 =?utf-8?B?MnN0TEhCZVE5d2xVL253QnVNZGtLT2FyWndiQ0pHYmJxa2F6OGRQZTVyQ1Fv?=
 =?utf-8?B?RVhUaFhmazdiL0VydjdzU0NJN3ZjWkFGR0EwbUZ0TUJwQnV0ODQ5WUxma2Nl?=
 =?utf-8?B?aXEvM2VWdHFuOWV2d29CeVdWS3NQT21CKzMrZ2NEeXhHdU42TkU0VlNpdzNa?=
 =?utf-8?B?RmJsMmVKRTBxVWxucnJia2QvR3FocVFzTGpOTXhNcDMrY1NKYXZPSmNndXoz?=
 =?utf-8?B?d21xVzFjTmdpVTdLakNkZ1hvWXFXbWx6V0xFVWZnRWpWZWFuUFVvaitKSzd0?=
 =?utf-8?B?SkhSMU4vVFFmU1hBcWRhMExPdlJmckpTbEd1MlNwWUNUbGV0bU8wOUxxNEZi?=
 =?utf-8?B?TmNrcCtBbUozUnM1NFZrOFB4eVJweWVLSTNsUDk2NHZxb3JacndtYkYyR2lL?=
 =?utf-8?B?R1dRazlBQ1lSK01lOWhYVmY3WHNsb25PVWpuSlRxZy83anhWc1RKRHZiNFhs?=
 =?utf-8?B?R29DbDNEMnp0dkZsUkpUVkp5dVMvOVhjelZZUkpJVWI2L1BTTjBxQStKQ0VC?=
 =?utf-8?B?aFNpU05Kd1dmMzlJazIxcjYzTVhPa29vTjByZ3pWNkRmRVZFWDZIeHA4NU9I?=
 =?utf-8?B?c3BLd0w5cEFwY2htSFo1S3RtNWFkdWlUaDJaYXZVTjRMNzYzV011bDdzYkVa?=
 =?utf-8?B?VGJSMkFxYlpQUktvby9rV0VKRnkwMmRsaHlOWEErYzFuY1dBNmNYR3BRNHFs?=
 =?utf-8?B?UXYxaFF5cU9iN1RlbUNaNWtibUwwV3k3eDMrK2FXTEpJSmg3bFA1cHhoK3dr?=
 =?utf-8?B?VzVhR2JWQnUxOHZvTVlGZWRIRnAxbnQyWTE1V1BSaVlxM0dpQUZBZ2dNWVpP?=
 =?utf-8?B?UGl6Tkw3eXV0aU1OVUNRZkpOb1dOdWh6K3hkcFdERy8zU1pUUy9KZ21DS2FJ?=
 =?utf-8?B?bmd1Ty9rRVA3aTdMVjc0UGU4dGR0VngyU1R2YVQraVBWZlUwSUhvTGdWSGN5?=
 =?utf-8?B?UUppeVNLRWNPSkI0TnpEQXdxUmlTN3Y4S1dYeTRIV0IxKzlnQlMyR1FyYmlX?=
 =?utf-8?B?VThva2JUTml3RlZsekNqV01ESlpzTVBUZ2xEQ1RPK2RIQ2VWLzRCNmRsUHJT?=
 =?utf-8?B?V1hZMTZLSVBJdWdxZERRWW5MR0l6MVJXSXVqa21TVWhnVzUxZzQ1ZmNsZzRC?=
 =?utf-8?B?RURyOFVjRzI4eDU1YnZVaXBHbTNDallyclE2VkVPcFA4N2FKcjRGKzFkeHlz?=
 =?utf-8?B?RTdnS1p3VmJ4d29lVHFUMkc3eXpiSUlaZG80Qm5YTVMycHJRVm9YWXhDYzlT?=
 =?utf-8?B?aWJqMnRzWDdyZlB3c056bzR2Z3oxQlJkWHJCaENXRUYzNDBDNSsrNzlOYkFx?=
 =?utf-8?B?Mno2NGdOc3laeVpRSjdUODBGNlBlb1N6dFFkUDJGbys0VW1YeEw1TDR6WE4w?=
 =?utf-8?B?NHZiYThaSXE5ZDRiZVNpWndBRFlIaVpDU2VHTTVESytMbmVRaE1sY0EvMHNw?=
 =?utf-8?B?Tk1jOG9HTnNrYWFiYXhQeW1Rb3pyWDgvYWpBYm13V20xR0FpM1UvVjdYTWpt?=
 =?utf-8?B?dHBUajE0K3hXMzF3TG4wQ05HUk53UjJpYndRMzljV21wWk5rZUVLNlpFcksy?=
 =?utf-8?B?cS9zU1JGWUVzdWRwSlNhRnR5a0R0WWJ2MEJ6dWthbVlBRHZhbTQ0TnlDbytZ?=
 =?utf-8?B?eXl5aU4yOHJyZlVJbENGQnVHb3EzalZtN01obkFxMVVTMVM5R01iamcxU0VF?=
 =?utf-8?B?WXFYRXFxaWVGWlpmM1NaeUF0NkhVelJlNXBPdStxY1BmY1FxdENrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef927aa8-eff0-40be-4003-08dec32fe794
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:26:05.1899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo5TOJ1ezXjW/zNPdOzcE1AcMUHjxe8RXeeszheyla70C0MJLBNWgTcZYxyRCFEDl7C/xxZxH+z3PnCbIwBM1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
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


On 2026-06-05 05:13, Prike Liang wrote:
> Replace the stack-allocated amdgpu_lockdep mutex with a heap allocation
> via kmalloc to fix a stack overflow caused by the large struct size.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 93 ++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h | 12 +++
>  2 files changed, 55 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> index d5d71fd7c70d..c13bfaa3dfa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -13,6 +13,7 @@
>  
>  #include "amdgpu.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_lockdep.h"
>  
>  #ifdef CONFIG_LOCKDEP
>  
> @@ -84,72 +85,65 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
>  int amdgpu_lockdep_init(void)
>  {
>  	struct amdgpu_reset_domain *reset_domain = NULL;
> -	struct amdgpu_reset_control reset_ctl;
> -	struct mutex userq_sch_mutex;
> -	struct mutex userq_mutex;
> -	struct mutex notifier_lock;
> -	struct mutex vram_lock;
> -	struct mutex srbm_mutex;
> -	struct mutex grbm_idx_mutex;
> -	spinlock_t mmio_idx_lock;
> +	struct amdgpu_lockdep_dummy_locks *locks;
>  	unsigned long flags;
>  
> +	locks = kzalloc(sizeof(*locks), GFP_KERNEL);
> +	if (!locks)
> +		return -ENOMEM;
> +
>  	/*
>  	 * Initialize dummy reset domain
>  	 */
>  	reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE,
>  							"lockdep_test");
> -	if (!reset_domain)
> +	if (!reset_domain) {
> +		kfree(locks);
>  		return -ENOMEM;
> -
> +	}
>  	/* Initialize dummy locks */
> -	mutex_init(&userq_sch_mutex);
> -	mutex_init(&userq_mutex);
> -	mutex_init(&notifier_lock);
> -	mutex_init(&vram_lock);
> -	mutex_init(&reset_ctl.reset_lock);
> -	mutex_init(&srbm_mutex);
> -	mutex_init(&grbm_idx_mutex);
> -	spin_lock_init(&mmio_idx_lock);
> +	mutex_init(&locks->userq_sch_mutex);
> +	mutex_init(&locks->userq_mutex);
> +	mutex_init(&locks->notifier_lock);
> +	mutex_init(&locks->vram_lock);
> +	mutex_init(&locks->reset_lock);
> +	mutex_init(&locks->srbm_mutex);
> +	mutex_init(&locks->grbm_idx_mutex);
> +	spin_lock_init(&locks->mmio_idx_lock);
>  
>  	/*
>  	 * Associate dummy locks with the same class keys used for real
>  	 * driver locks. This ensures lockdep connects the ordering learned
>  	 * here with the actual locks used at runtime.
>  	 */
> -	lockdep_set_class(&userq_sch_mutex, &amdgpu_userq_sch_mutex_key);
> -	lockdep_set_class(&userq_mutex, &amdgpu_userq_mutex_key);
> -	lockdep_set_class(&notifier_lock, &amdgpu_notifier_lock_key);
> -	lockdep_set_class(&vram_lock, &amdgpu_vram_lock_key);
> +	lockdep_set_class(&locks->userq_sch_mutex, &amdgpu_userq_sch_mutex_key);
> +	lockdep_set_class(&locks->userq_mutex, &amdgpu_userq_mutex_key);
> +	lockdep_set_class(&locks->notifier_lock, &amdgpu_notifier_lock_key);
> +	lockdep_set_class(&locks->vram_lock, &amdgpu_vram_lock_key);
>  	lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
> -	lockdep_set_class(&reset_ctl.reset_lock, &amdgpu_reset_lock_key);
> -	lockdep_set_class(&srbm_mutex, &amdgpu_srbm_lock_key);
> -	lockdep_set_class(&grbm_idx_mutex, &amdgpu_grbm_lock_key);
> -	lockdep_set_class(&mmio_idx_lock, &amdgpu_mmio_lock_key);
> -
> +	lockdep_set_class(&locks->reset_lock, &amdgpu_reset_lock_key);
> +	lockdep_set_class(&locks->srbm_mutex, &amdgpu_srbm_lock_key);
> +	lockdep_set_class(&locks->grbm_idx_mutex, &amdgpu_grbm_lock_key);
> +	lockdep_set_class(&locks->mmio_idx_lock, &amdgpu_mmio_lock_key);
>  	/*
>  	 * Take locks in the correct order to train lockdep.
>  	 * This establishes the dependency chain.
>  	 */
>  
>  	/* Level 1: Global userq scheduler mutex (outermost) */
> -	mutex_lock(&userq_sch_mutex);
> +	mutex_lock(&locks->userq_sch_mutex);
>  
>  	/* Level 2: Per-context userq mutex */
> -	mutex_lock(&userq_mutex);
> -
> +	mutex_lock(&locks->userq_mutex);
>  	/* Level 3: MMU notifier lock */
> -	mutex_lock(&notifier_lock);
> -
> +	mutex_lock(&locks->notifier_lock);
>  	/* Level 4: VRAM allocator lock */
> -	mutex_lock(&vram_lock);
> -
> +	mutex_lock(&locks->vram_lock);
>  	/* Level 5: Reset domain semaphore */
>  	down_read(&reset_domain->sem);
>  
>  	/* Level 6: Reset control lock */
> -	mutex_lock(&reset_ctl.reset_lock);
> -
> +	mutex_lock(&locks->reset_lock);
>  	/*
>  	 * Mark potential memory reclaim boundary.
>  	 * GPU operations might trigger memory allocation/reclaim.
> @@ -157,36 +151,35 @@ int amdgpu_lockdep_init(void)
>  	fs_reclaim_acquire(GFP_KERNEL);
>  
>  	/* Level 7: SRBM register access */
> -	mutex_lock(&srbm_mutex);
> -
> +	mutex_lock(&locks->srbm_mutex);
>  	/* Level 8: GRBM index access */
> -	mutex_lock(&grbm_idx_mutex);
> +	mutex_lock(&locks->grbm_idx_mutex);
>  
>  	/* Level 9: MMIO index access (innermost lock, spinlock) */
> -	spin_lock_irqsave(&mmio_idx_lock, flags);
> -
> +	spin_lock_irqsave(&locks->mmio_idx_lock, flags);
>  	/*
>  	 * All locks acquired in order.
>  	 * Lockdep has now learned the valid dependency chain.
>  	 */
>  
>  	/* Release in reverse order */
> -	spin_unlock_irqrestore(&mmio_idx_lock, flags);
> -	mutex_unlock(&grbm_idx_mutex);
> -	mutex_unlock(&srbm_mutex);
> -
> +	spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
> +	mutex_unlock(&locks->grbm_idx_mutex);
> +	mutex_unlock(&locks->srbm_mutex);
>  	fs_reclaim_release(GFP_KERNEL);
>  
> -	mutex_unlock(&reset_ctl.reset_lock);
> +	mutex_unlock(&locks->reset_lock);
>  	up_read(&reset_domain->sem);
> -	mutex_unlock(&vram_lock);
> -	mutex_unlock(&notifier_lock);
> -	mutex_unlock(&userq_mutex);
> -	mutex_unlock(&userq_sch_mutex);
> +
> +	mutex_unlock(&locks->vram_lock);
> +	mutex_unlock(&locks->notifier_lock);
> +	mutex_unlock(&locks->userq_mutex);
> +	mutex_unlock(&locks->userq_sch_mutex);
>  
>  	/* Cleanup */
>  	amdgpu_reset_put_reset_domain(reset_domain);
>  
> +	kfree(locks);
>  	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> index 04adb58665bf..8bff09bd2dbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> @@ -9,9 +9,21 @@
>  #define __AMDGPU_LOCKDEP_H__
>  
>  #include <linux/lockdep.h>
> +#include <linux/mutex.h>
>  
>  struct amdgpu_device;
>  
Hi Prike,

Thanks for the fix -- the heap allocation approach is correct and addresses the stack overflow cleanly.

One minor suggestion: could we move struct amdgpu_lockdep_dummy_locks from the header into amdgpu_lockdep.c (inside the #ifdef CONFIG_LOCKDEP block)? Since it is only used locally in amdgpu_lockdep_init(), keeping it in the .c file avoids exposing implementation details in the header interface.

With that change:

Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> +struct amdgpu_lockdep_dummy_locks {
> +	struct mutex reset_lock;
> +	struct mutex userq_sch_mutex;
> +	struct mutex userq_mutex;
> +	struct mutex notifier_lock;
> +	struct mutex vram_lock;
> +	struct mutex srbm_mutex;
> +	struct mutex grbm_idx_mutex;
> +	spinlock_t mmio_idx_lock;
> +};
> +
>  #ifdef CONFIG_LOCKDEP
>  
>  /**
