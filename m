Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70518F01815
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 09:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A35810E1AD;
	Fri,  6 Mar 2026 09:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jqzeCvY6";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE27910E1AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 09:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjJgR29ZFrfTIY+tN1zfdOBvj1Mx6DEbPDaxPFa/Rm6Tj1HnNMz2enzbM/7kU3KHNUctV4ubZZ14bjofIzeYocEnc3wIMC4lLOcSqhC3Y+ypQOWKigGDPSQ0qP6a6xExa2ai+VbajogXSYGioQS6NA3cE9Nmb9QIbUjvyQq6b4oui7FRr5Z9vM0ZH+/IMWgVXSqsoctkleu0JkIwSdNOESzVpY098weh8aOVg5/MhYo65P8isrwtOXD8TwcS5hEutc3onLZ2TTMxcHBXHSXtEx1KPZ/kU7bJpZhC57V0L+VVf43yonOAPGdCix9h2Z/axOpF5YxfrFk4T+iVyZbc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vttNQwzlq9EPjt40V8x8yvqudrfbVcXC/gX9V1j/+GM=;
 b=L+xOqAxC1vnyMmgHXxCP4/hmVOCJdpNKiv5ObZplaHGM9Hn/glE5z+7BLyKbAwTI/yxlM5kNPyiJgJrhIkRQqmaOm4ORCI8FDX5bPEUCma9XQ4bHIdg5zVYTQXRAUfsD2H06jb+1v2nL8+fQE/8mySm/8Zj0xz2ZZ+bqMmEi6yhvnBsyA4bB9Qzexixz3bmMkP0vP80joX5YIJW1Tkz0KYRFub3BBx0rj9shkasoAJyNveEo92Xz2aCM/OeOrzbjjmFHf7dk8EAn9mns6SsTVrw55SauWT21PmprALkkicCQ5n03CRfJxw/JceANpr7YZuELtelUn0189gv56AGF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vttNQwzlq9EPjt40V8x8yvqudrfbVcXC/gX9V1j/+GM=;
 b=jqzeCvY6pTl+f1skS98D+pbw0FZk5vgdANEBwmRJ9gISh1qON3hq5AMrfFgmY0D64bID/ZcGS2RxzK3lSFjIvLtsbDqlbVcADff3Mwb+TOJT0i3t8KSO7VPxp+xdep40ajBmqw/hAXr2hmkoJa21rpLCUsOXCQcT5t8yI09shqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 09:21:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 09:21:48 +0000
Message-ID: <d7552977-3152-4744-85b9-987df7402778@amd.com>
Date: Fri, 6 Mar 2026 10:21:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] drm/amdgpu/userq: defer queue publication until
 create completes
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306080417.1798029-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260306080417.1798029-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e543069-87a5-4fe5-3dd6-08de7b61cb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: qr1jrjswR5sZP4Kd7ZSsccwDTp5HmQcfHRwWrsdCAWovOi/Ij/sfXHzlkca0MkPCmwdUFVLOqZSJBMnyGlooTRqii5oqHDlGEfJ2qFUtHcRVKfDCqbmfuV7I3Zs3fO2vL32M7E0g3nQ0a3SG2XWWcTqlb98i4yNxvUKA3aGsrOkhm8rqC3sKDGIlaG7W23Wf1IHm7B29e5PIt4LTskDg0TJ6bwTgfpKEzwA3cDLB/2rA1AVE/1txcFgqJYN7Mj2OnGc1ta7LuY5unZ+FAzgodRopL7i4ZDCro1vlnuB1nDxXc7S1E6n9/GMF+LSXpgSiYUT1VEMp1uMBAoOpXn9D1BAjg13yYPL7fiTkX0z/3ABDaOqkNQE9PUHbNpj9jSkN0005ASizgg6kJpL5+cvpLeIN6hHG+kXbKInmfjLIfeakGLRvigP/wRud3HtBiXHv10Sy7QCMbu0yM07Xnh15TuscunaUN/8GoZPDCWUmaFngbN7kUD6mnwAUAbS676TSTtD7xQWRArbVKYlSZR4mSEgCOsUc1yjDp1D9Z65/n6AlFBut0Ps3WhaGdGVmoMQXRyiQJ9yJq3nK2+R4TRnyqhqksXAK2R+o6+qZ7WxiMA/qLYxcvwBC+3/76rymrZNrG3iq6JOK9tzac5e8D51jtYZmuLPOqtl/RM1QHr/Yla8dglD/AdFWyVv223Dz4/LMjdv9bknl0U72Q/ufuYrT2w1AyO589yjga2BSTb1XOLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1VtVEkzWkdyU0lrRW8wRXFrV1hzTEpoYUNoSFpXSWVvdERPY0didkJ4SXEz?=
 =?utf-8?B?TE5MV0hFcnh1TElRbS9sajRCR05henoySENvRHN2Mmtpa2lUMXFlVlhBTDZM?=
 =?utf-8?B?YU9reXVma0dUMEJhZDVnWDFnZytRelROMG15ZWFNWlJZRVJnakxTWitTWlBO?=
 =?utf-8?B?dy9FR3ByS3VXMkFaTTF6ck9XWVgwSTJrczdWNXQyQjRBNnYwV2dFWWVBakp3?=
 =?utf-8?B?MGprb2R1elA2eHVVSGNoWS9vMUMvY3Q1SGhtWEg0ZW9WZVNLSkRLM2xDaEFL?=
 =?utf-8?B?QkJVdDF0Wk9Kdy9iSkI2MkxTeGtoUEpSaW9QT0J6Q2RSanZqb290T1hXMGNq?=
 =?utf-8?B?R1dOR09UWG9JOXZrRjM3Ym9vc1dOYmlEOC9MQVVYNDZmek05SDg3WC9pOEVE?=
 =?utf-8?B?NjhZdzRtN0tVK1pEd3ErTXNpZGFJb3NhZTlmZWtlVG8ydEpsbFhjK0JTRGxC?=
 =?utf-8?B?M09iTVB1enJHaTNTM1phc2dveTZTWWxwa3ZreTlzZHRRNDBPS2dmdzdRVDk5?=
 =?utf-8?B?QkZqd0NkdFRHc3Rpb2ZkWUg0bVhnY1AvaUY5MGdKU3FkRjg4bG9ONDE1Y3Jk?=
 =?utf-8?B?VGRKQ2tvSHpDNENPWEN2emtRVzRUaldCdFhTank5QktnWGwra3lsams5OVJS?=
 =?utf-8?B?UWpmTkkvMzYxOXdBV2svWGhYTXBYelA1UW94eDRBc2IvTFBPL2YxOVlUdXQ0?=
 =?utf-8?B?WXhzZ0JuN0JLbHZyWi9wTlR4ZjhzWXIrdlM3b1hRMDRwczlWREw0S0VqU016?=
 =?utf-8?B?R2RVT0J1NmhKSHhvRDljR0d1MEpYYUMrUXFFVGZJZkN6VjNRQU9vaXZJcFdG?=
 =?utf-8?B?VDVLYlBGMGl4N2RmTVZteW8zaG9YUWxJWTZNSmlzYUd1TGRBd2I3cy82Y2dG?=
 =?utf-8?B?emQra3B3ZklJQTVFTjZLRVV3TDhCZlJOaWErMEt2TUMvMmVVcUhDVm0xV2pj?=
 =?utf-8?B?UUhObVpvOFAzSHJpbmIzcWhYM1F6YVpSS1I0NGE0SzUzc0JIMHhLdUQ5QUJZ?=
 =?utf-8?B?UW9GVjJsQjVZNUJQMU5WeTJQZ2VleXhmVXVUL2dpK0dDaWxkV1l1a1VwNnJz?=
 =?utf-8?B?dTF3NU9FcDNVWWgycVprL0N2VlByeWR5VjRyMHpoaFpwNnRIbzR4cWU2Qkcy?=
 =?utf-8?B?M0o5cVIyUWloOUd2NDU4UGVKQ3VkRlNxWm4xTlhKbndJOGNtbVAwOHhreVBu?=
 =?utf-8?B?czVkYmlMdnhRRU8vY2VNRlovb0xveFEwYXl3bHdjVUhuVjdTQmJ6bCsxRkxt?=
 =?utf-8?B?OVN2VFBOTURWSlBJSzB2UStZOFd4dXJqZzVHKytZc0FWL2RoT1N4Q3JkYVZZ?=
 =?utf-8?B?SDE0ZFlzM0w1a01yVGVDYW56My8yMmxCZlJxaU1kc3BSVnRPTWs0djZhOHoz?=
 =?utf-8?B?MHB6Wk9KOUFpMis5TTdheW92bm53RitTZjRNb01FVFZlSGcrSjRaN1FtOGNX?=
 =?utf-8?B?b3B1ZnVjeDJ4Y29WcDJNL0FHUC80SnBjU1BqZENkdFpOd2tmaFE4aVRPbjZO?=
 =?utf-8?B?bUptODM2MVNFUGJuY3FEckk5SXBKbGhZMjYzcUgrdXJzdjh0a21CcEEzNzF1?=
 =?utf-8?B?SUczM2h6a095ditXQTR4TThBaEZPM3hJcSs1TjBZOHJidFE4SFczTFBHSXZn?=
 =?utf-8?B?UFNsMXl6YkdBSENRWTBYa2dJU01oZm04T3hDUWpJaFZOSlp0TUpBK2trUjJF?=
 =?utf-8?B?YnJxdGhKR3ljcEZRQ3hQOE13amZ3WmdtaWlsajBYc3dZT045SzNDRHZtY2VF?=
 =?utf-8?B?YTA0a0lKUWwwYzdHNzdwNDFIYmZ6T001SlJaWmg3TlNBTzg3Smtxb1RHc1E0?=
 =?utf-8?B?MFZDZlgrWHd5UGloaUZXc2dIdUZYcS8rcmp3akdnMjFxbExZRzVrQTJ1V0Fa?=
 =?utf-8?B?U1V5dldrRXE5MDVCUzVKckgreEtQcXhNZW5yZGh5QlZ4cGxxVDVmVlQzSFVD?=
 =?utf-8?B?NGVEVlQ4S0YvY2JtQmV4U1ZoY0pEejhUbGQrTGFnRXp1clRqVEVXUWkybmph?=
 =?utf-8?B?SXVBVEduQnYzV0RVejBJYWIwQk5mZHRxZzYycnMwT3oxTkh6cUZnR01qUWww?=
 =?utf-8?B?M1dHNW5VVVN5bGRlaDZ1THBzSEE1QWUrTlJyL29ralRMNUNSZ0RJUlA3ZkpV?=
 =?utf-8?B?RXFZUW9GaC9QOFZVOHhMNFlwdUI3ejBvS2xBUTgzYTQxSTAwQk5KajRZMFI4?=
 =?utf-8?B?UVRoTFVtZ2R4RjUyeWZWSm1lMzRhWTMwNWoyS0R0cjA4MUQzTE90RE1adVR0?=
 =?utf-8?B?Wjd1SHNHNlpCK2RsWnZ2a08rMVQrTWlvNDd1VWkzWHprS0kyazVjakp1Y2Fl?=
 =?utf-8?Q?dv6szZqnAFAviI1KwC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e543069-87a5-4fe5-3dd6-08de7b61cb10
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:21:48.3513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb5iWM9rGS7UHRqyKsy7WGlAe+Pz87TT5g3AX5+yCWLmiIWdG0Y9y+MuvZp+mul6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
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

On 3/6/26 09:04, Sunil Khatri wrote:
> The userq create path publishes queues to global xarrays such as
> userq_doorbell_xa and userq_xa before creation was fully complete.
> Later on if create queue fails, teardown could free an already
> visible queue, opening a UAF race with concurrent queue walkers.
> Also calling amdgpu_userq_put in such cases complicates the cleanup.
> 
> Solution is to defer queue publication until create succeeds and no
> partially initialized queue is exposed.

Good work.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 67 ++++++++++++-----------
>  1 file changed, 34 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 7d2f78899c47..937403beacdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -758,7 +758,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	const struct amdgpu_userq_funcs *uq_funcs;
>  	struct amdgpu_usermode_queue *queue;
>  	struct amdgpu_db_info db_info;
> -	char *queue_name;
>  	bool skip_map_queue;
>  	u32 qid;
>  	uint64_t index;
> @@ -848,32 +847,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto unlock;
>  	}
>  
> -	/* drop this refcount during queue destroy */
> -	kref_init(&queue->refcount);
> -
> -	/* Wait for mode-1 reset to complete */
> -	down_read(&adev->reset_domain->sem);
> -	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> -	if (r) {
> -		kfree(queue);
> -		up_read(&adev->reset_domain->sem);
> -		goto unlock;
> -	}
> -
> -	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> -		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
> -		amdgpu_userq_fence_driver_free(queue);
> -		xa_erase_irq(&adev->userq_doorbell_xa, index);
> -		uq_funcs->mqd_destroy(queue);
> -		kfree(queue);
> -		r = -ENOMEM;
> -		up_read(&adev->reset_domain->sem);
> -		goto unlock;
> -	}
> -	up_read(&adev->reset_domain->sem);
> -
>  	/* don't map the queue if scheduling is halted */
>  	if (adev->userq_halt_for_enforce_isolation &&
>  	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> @@ -885,28 +858,56 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			xa_erase_irq(&adev->userq_doorbell_xa, index);
> -			xa_erase(&uq_mgr->userq_xa, qid);
> -			amdgpu_userq_fence_driver_free(queue);
>  			uq_funcs->mqd_destroy(queue);
> +			amdgpu_userq_fence_driver_free(queue);
>  			kfree(queue);
>  			goto unlock;
>  		}
>  	}
>  
> -	queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
> -	if (!queue_name) {
> +	/* drop this refcount during queue destroy */
> +	kref_init(&queue->refcount);
> +
> +	/* Wait for mode-1 reset to complete */
> +	down_read(&adev->reset_domain->sem);
> +	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> +		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> +	if (r) {
> +		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");

This should actually not be printed in the logs. At maximum it is a debug message.

> +		if (!skip_map_queue)
> +			amdgpu_userq_unmap_helper(queue);
> +
> +		uq_funcs->mqd_destroy(queue);
> +		amdgpu_userq_fence_driver_free(queue);
> +		kfree(queue);
>  		r = -ENOMEM;
> +		up_read(&adev->reset_domain->sem);

I was just about to write that this screams for goto error handling and then saw that you do exactly that in patch #2.

>  		goto unlock;
>  	}
>  
> +	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> +	if (r) {
> +		xa_erase(&uq_mgr->userq_xa, qid);
> +		if (!skip_map_queue)
> +			amdgpu_userq_unmap_helper(queue);
> +
> +		uq_funcs->mqd_destroy(queue);
> +		amdgpu_userq_fence_driver_free(queue);
> +		kfree(queue);
> +		up_read(&adev->reset_domain->sem);
> +		goto unlock;
> +	}
> +	up_read(&adev->reset_domain->sem);
> +

>  #if defined(CONFIG_DEBUG_FS)
> +	char queue_name[32];
> +
> +	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
>  	/* Queue dentry per client to hold MQD information   */
>  	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
>  	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
>  #endif

A separate function for this would be nice to have. E.g. something like this:

#if defined(CONFIG_DEBUG_FS)
void amdgpu_userq_debugfs_create_queue(..)
{
...
}
#else
void amdgpu_userq_debugfs_create_queue(..) {}
#endif

Apart from those nit picks looks good to me.

Christian.

>  	amdgpu_userq_init_hang_detect_work(queue);
> -	kfree(queue_name);
>  
>  	args->out.queue_id = qid;
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);

