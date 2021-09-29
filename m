Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBABC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 15:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292C461262
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 15:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 292C461262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3CB6EAB5;
	Wed, 29 Sep 2021 15:24:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5526EAB5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 15:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyAWKU+23Pnyr7qcRfscRPoGz+pGG0LRkXWwvnLTXbVQKdAjD1AAe5guAYTxSc0lMvAU80MXEOMHTvfY4UaOevqyTZRByHUDuZyClHdXJcnhXa1bwNDY5wdZ1zT5sVhCRq/MAVoagBgBdaxnqEbc1nuKSIemZKUqkXy3iL/0t41/eEhLr1eRQ0p2wXAy1kKoUcfal+5BHeqKkwoUOMuvzYeNmO3tJOjLbv+Rh09u6V1ClWvPmhEvlK6z2EGT5XPrPCmidnOefQjc9pqy8C+iYMNFRf4xuvp2qMastAMAfHxoO2f8O/I4f5H3M/rrL/hy3JS+/7DJ+CkzqM+JHbl2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=74NazJogReFYiduBVtGjTiE3KbAe9a+xZWqmgwt0cs4=;
 b=cj7JA60uJe2I5W4DDlTSY9izRX7TU8InOW9CwF8l0qf4qcxmSGPq2TlrbaT2YB1JApWpzSpUwf/LpYyc9hrVTBiYJIWN7xlcxOfI+BiGtzeMGU3N8MhwoYkEE+sfrQkiC3wluXkhfuo5Ddiv4Sqp4ECFPYgm+n5RYLyWULoq4urEvtPcihySEcNGDrqrtDm7cliinhHIyQ1Il6yXbfiBiVaFkGqTTUE5AQxW015VH1IT2Su8gwBaKKAqib0B9Yee3lBZo3SiboovEdgLxa3H3Lu+JlFV0v7K0yN4dZbVCvL6lmIHZxZhdrk1SxjgVTieMzE1yKinHKzOHEIrWd1Dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74NazJogReFYiduBVtGjTiE3KbAe9a+xZWqmgwt0cs4=;
 b=C9sBDV6Aa3ro2d96stczDZdcY6ewesEHZW7ms18TI74onEkhYEp1kNdxKNKD5x1jxQ/tVUTQSBIcsvMVDyoInrqV7sHXRS98CLX50fv8qu374BuWIw9IlmicWImvoLVD3Hsw58YIhd6hVw3l4Exmz49SD1XA2MJDIJDNqGB0W+I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 15:24:45 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%6]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 15:24:45 +0000
Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20210929082212.1806312-1-lang.yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2ccb1777-ca8e-5a39-5311-3262c1cba608@amd.com>
Date: Wed, 29 Sep 2021 11:24:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210929082212.1806312-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::40) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Wed, 29 Sep 2021 15:24:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69b67db6-8d1c-4d66-878d-08d9835d4433
X-MS-TrafficTypeDiagnostic: BN9PR12MB5036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50364BADA5440D1ABC74AD8492A99@BN9PR12MB5036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEP7Ah2G+3E6WzveEGrUdPXBrv5PcD38P0KX42HczFM7vajJY2s720Tzx9DATiwu27ESjhRTbr4gtlBY9H8xSYO3+GxJsK6Z5VLsA/VCsJuyYE5kQZZZELch8TkVsrJLXbyrZPozN7AT2AmOisxLy5L3/VIU0rcyuL2f85tWiv6IbAOLx6h/0vmI2OUPYnFXiQYvQMyPgAQ0OsLORs/d28NTRFtIMvySLa8uZvzKY4OeuIVbl0DswtP5KuJlcpZBmfuMneEJszZilwX8A+lTpF0cSp1cmFuY7vHCAvv2L46nqAknOYNN/qnMRyczeyJtKne8BxO1sg5dl2eqGWD59mijjk3ORimJ72iw8LZ6v9uAwFOUK67LSHBuVAU/Ps7i3XnWW7yshQGgb6KxFi+hG6ZdJvKXNU2XBTd6fFLTh20aNM81crX7kQEHPCLqk7GbXaO3qy+XNcb0mbatNI/uG61KqJvj8HCGP1nn3M8e7puQUZ/6Cb7fa9OD9kABx/4dCWxbcZguzcqjaKps6OftA3S8InYqrtUwJZ9nGGQU58rn+dP+rPE31mNi7hxZGfPOw7A337JEcXN9l5yQ9UTv3M3FPqGjlJ7IaScNtzsbHx7LnhkgQwhD3Fl6GWEynfZOv6UvL+5DaDboYSSM3Rl9mONTy/4qwEGCvMG3HtXn0omInKYQWcF/lwnD6p3QTLfUatBZcqwaeI5ZKs3MDnM82I0e0JEe6n2ZBvb5K9E+PxT7HaaiCSZPzrO1yKP/OTvO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(2616005)(83380400001)(66556008)(2906002)(66476007)(956004)(86362001)(31696002)(6486002)(36756003)(54906003)(5660300002)(508600001)(31686004)(8676002)(4326008)(44832011)(66946007)(316002)(186003)(8936002)(26005)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SENQTXJLM3N0TDdZeXpNZlhEeTBSM3dBc3V6dm8vd1RjWE0wU205eUdKcUZp?=
 =?utf-8?B?WHBXTEVkbC8veUo5dUNnajBkTjgyQks3TzVpbENFUEE3YVdaNWhQWE1Qbjh1?=
 =?utf-8?B?cjN3QlRJS202K1Y0WnJkdVkyWVVXQURxeTlGVk10OW81S1lYV203c2VVSFI3?=
 =?utf-8?B?TlV1TmZIbm9WOFlWazFGRlVURmxRbGpMUHM3SWg2cmV5YkVoMmh1cGtCdW5n?=
 =?utf-8?B?MnljMDNuaUVwc2cvQ1A0MjE4Z0d2Wmw2SHZnVmNuN1ZCZitwOTRXbkE5blBz?=
 =?utf-8?B?dUNqZWF0UC94c1JYc2dmc3ArdG0ybmwwMm5kVlpxVXptNzEzMFpBak1FNU1F?=
 =?utf-8?B?RFBCNTBmdmJINVZaZU9wZy9SYWI4TGo1TnF0Yk5wVnlLWWZJK3A5SEk1ZFM4?=
 =?utf-8?B?SkNNSEpQSjBCVmxrVDZuK0hRWm1PTGFuNTdaN0ZVbDZjeWxHeDF0UVJQMFlz?=
 =?utf-8?B?YnJIOUd0bGN0anQzb09Ydk5adW9Gb29Lazlrako1WUVDUkhWS3BBUGdTbkNi?=
 =?utf-8?B?bFEwaDR1ZlJOVmh0QkxWcU1pUFhiTXF0b1FBYUhCdk9Xa3czMkpkSUhmWlNL?=
 =?utf-8?B?NENZdE9VUVk3aFVtcXU1Z2FPYWxsQVNUTkV3SXlPNG1WaERxVHViOFNjYmFI?=
 =?utf-8?B?NnA4UXBGZzBVTkhRQlY4amRkaUgrSWpiRGZuMGRna1Y2aXNGM05aanVMU3A3?=
 =?utf-8?B?WXFUSjVuZy9UR1dEVVl6TURCQUtDc2hnV0UvRXVXTkswbm5zcEV1dEdMTS9i?=
 =?utf-8?B?dU85Z1UvOEhFNm1xSFdkVTFta3BJdzRKd1poaDJhTHZ0STEzdkoyZzM4a3g0?=
 =?utf-8?B?S2tzSVFYS2tMS0NIdWc1QVRCcXlENFIySzlucXd4OWowRzlnYVBmL2ZDaXRR?=
 =?utf-8?B?cWt6bHB6YUllTEhVK1hNQ09BU1NmcjMvUUE2SVpxSk05WlR0aW5LMzRPcUgw?=
 =?utf-8?B?c2NRb3JVR0Y2NzRlVFM1c3REbHhkODdZMzM2UWpleVVadmgrVHJmL2tIaTF0?=
 =?utf-8?B?NFF2NEZ5Tlg5aHkrU3A3b1Vsbk5pRUdDcVQxbEJwTzdKRWZaNHVyKyszNmpK?=
 =?utf-8?B?ZWVTS2ZVOUJveG5WME9zTVdVV3N3TGZHbkEzNVEwYUg4TXBDN0k3VTViRE9B?=
 =?utf-8?B?SHJKTDhVdVFpZ2Jwcmo3NlRjWjRCaDNlVnd1TjdPVklUd3ZCcnl4T0tZbzE0?=
 =?utf-8?B?cnlMWVJGdkUyVEZwbGhwRnd5dzVYd0twNk45Uk9yczJrUThFKzFuOU5xdjBq?=
 =?utf-8?B?QmFvRHFvdWVac2JqaEJ1VVNYV0sySXBJNG1KOUttYWxsbk1PazYxWG1mdjdB?=
 =?utf-8?B?SjQ4M2NOaDJvdmpUVk9vZjRqL0Z1cWhoZ3VkcmtxWmM3TFVnZkhPTVpuRW14?=
 =?utf-8?B?UjZHQUhTM2NOYmZ2dFFneXRmdnFzb29NeWtaSU9RaXo0bGc4TGpoYS83SHJN?=
 =?utf-8?B?bFpVbTJFTHJpMGpKbkdJYXFOeTFyTjVjaFRQWFpWK1B0SWJzWHJnbGo5a0Ex?=
 =?utf-8?B?RkpBcWpiV3lrQ2tyamR3NUg4TGJkT283ekhFRnpWd0FwYjZPVjZ3ZFhoSUJk?=
 =?utf-8?B?Wm5DT3RXclpaQmtVSUlGVTltYnB5RUF4V0gxYWJWRkE1cHNaYmhSbEVTQlF3?=
 =?utf-8?B?SExJQ0IwL3U0U1R4U3VsY1ozQUhWbDIrVFFzWElmRDgyWVBvdmtHUjhVelFY?=
 =?utf-8?B?R21xWnN2azNFUFZBNzEyT0JweE1kd3JKREYySElyWkJ2VUluengrTDZMRHFa?=
 =?utf-8?Q?7fpRlg8k5g3NaQj4rGD5jmFUPeRmmoNWNQOFZE+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b67db6-8d1c-4d66-878d-08d9835d4433
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 15:24:45.0285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dncK4QGlUqF0i5CDf3Fi1w6n2FbzGKblGt9PR+LNffY95SSKJ+gA5r23ZjnqTlFt3pqEKlLvcGTcKGOvWXgIPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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

Am 2021-09-29 um 4:22 a.m. schrieb Lang Yu:
> If user doesn't explicitly call kfd_ioctl_destroy_queue
> to destroy all created queues, when the kfd process is
> destroyed, some queues' cu_mask memory are not freed.
>
> To avoid forgetting to free them in some places,
> free them immediately after use.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  8 ++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 ++++------
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 4de907f3e66a..5c0e6dcf692a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -451,8 +451,8 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
>  	retval = copy_from_user(properties.cu_mask, cu_mask_ptr, cu_mask_size);
>  	if (retval) {
>  		pr_debug("Could not copy CU mask from userspace");
> -		kfree(properties.cu_mask);
> -		return -EFAULT;
> +		retval = -EFAULT;
> +		goto out;
>  	}
>  
>  	mutex_lock(&p->mutex);
> @@ -461,8 +461,8 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
>  
>  	mutex_unlock(&p->mutex);
>  
> -	if (retval)
> -		kfree(properties.cu_mask);
> +out:
> +	kfree(properties.cu_mask);
>  
>  	return retval;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 243dd1efcdbf..4c81d690f31a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -394,8 +394,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>  			pdd->qpd.num_gws = 0;
>  		}
>  
> -		kfree(pqn->q->properties.cu_mask);
> -		pqn->q->properties.cu_mask = NULL;
>  		uninit_queue(pqn->q);
>  	}
>  
> @@ -448,16 +446,16 @@ int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
>  		return -EFAULT;
>  	}
>  
> -	/* Free the old CU mask memory if it is already allocated, then
> -	 * allocate memory for the new CU mask.
> -	 */
> -	kfree(pqn->q->properties.cu_mask);
> +	WARN_ON_ONCE(pqn->q->properties.cu_mask);
>  
>  	pqn->q->properties.cu_mask_count = p->cu_mask_count;
>  	pqn->q->properties.cu_mask = p->cu_mask;
>  
>  	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>  							pqn->q);
> +
> +	pqn->q->properties.cu_mask = NULL;
> +

This won't work correctly. We need to save the cu_mask for later.
Otherwise the next time dqm->ops.update_queue is called, for example in
pqm_update_queue or pqm_set_gws, it will wipe out the CU mask in the MQD.

Regards,
  Felix


>  	if (retval != 0)
>  		return retval;
>  
