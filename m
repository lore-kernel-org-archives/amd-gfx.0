Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520B9C49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 09:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1246109F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 09:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1246109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC22089D49;
	Mon, 21 Jun 2021 09:47:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE7089D49
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 09:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbu3sFHJ96JAzwFe6OlyesD9mtH3Dv9MJe8fJLlRcBf5j0bX39VvDGRKTHwZQ6QIkl4X/JcxGIQfof8Hsk3ny8eqFw01ARdJ7UwBp4tmGU5+YcsvU9iZ+BZ2W6XIrV7fqxeuRHx6bmFrVT8OxhZY1wHTOAIdtTfUPfLzHQJiKdHNmrMLQ8bLPX6fKSFOuBHDdCuahovQDYeE/hJD8fdwF28DAMVAtyx1RjPlH+Yp86JYn5N/hrx917zNwpDDGegIvdjZAonGitQC0wPKXSG2BFLoCYT0j2ulQ4/el0XLsw4o795D+zDzjipPcJT1J9uuw6aQpuHnC9rWxhUc/7W1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENiqBZ1f7r4i1mq5ghwbvWePFZKo3nkwnBckFVL//7E=;
 b=bDabdALbrcanJkp5081TsgyxJeEGounGTl6xbZ4n7UMgWk+sIjk70XehxCd/hZjWIhxVYfZqW0o96+tu1WVwoOGPcmP9fmIxPvxkU9odBGPW8xgkVzKfqkRAspGUFbjhb9zYOJiwoTKYL0OXKqvBT6FZ5x6DuPirtrvnuzkdZeqxwo0sdJvzK76G9PWrEakk4W50CGbbkIrDbYoVTstpzAKUS1EAmm+luYKWgKPjUwnSuUt4MUEFBztKOWuysddNe7yA4ALAovAlKvQ2JSEUCQvTBzUvWHzPC+U5KN2x9UhKs55iPEGhrGlBexq8pBc5KcKvf9bvZjBvvnQZndmVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENiqBZ1f7r4i1mq5ghwbvWePFZKo3nkwnBckFVL//7E=;
 b=gZAZSDI7OArXw+cqm/JZIpnVtNmMGmXEBK9E3LnPUPcKxgIeIhMOFaltTS8VVEZIH4TmuLBAoQQwUuwjyJNSA50Pm1C3TBUaKJnLJiKK79NnW2SovUYNssAMClNVFavaPwq4lZDwPOzZpWKTr5AyjdCpC52xIQZ5QrGaizBc0gU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 09:47:24 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 09:47:24 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add helper function for vm pasid
To: amd-gfx@lists.freedesktop.org
References: <20210617130334.15366-1-nirmoy.das@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <5745d21a-93e2-4446-3299-f7a807136817@amd.com>
Date: Mon, 21 Jun 2021 11:47:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210617130334.15366-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f20:ce00:b0ce:3f62:a5c0:b64d]
X-ClientProxiedBy: AM0PR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::16) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f20:ce00:b0ce:3f62:a5c0:b64d]
 (2003:c5:8f20:ce00:b0ce:3f62:a5c0:b64d) by
 AM0PR01CA0111.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 09:47:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08f724a5-46f2-4d2b-7800-08d93499929c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB513470F0EC951E1D877D1EDE8B0A9@DM4PR12MB5134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lxpW9LYr77UD0rPAahLHkKK/os335etR9YjCsvlHHWEPj1NsunOqEdbTqSoV5YIKZXeVoBfdEzbuq4HJXkkW606W1rPUaTIMhqidHE1uRd48Ud+xf0GuU7zqRlNlc49R6L0TTzKLGG3rrzKtGQX9rHTMAQunHCh49EZcYnMWAzNyW5PIjmaSHK2O2WCxW2Gredpvss9I23HJE6tLB2Qp2cg3M99he3zQ1w5K9itdq8by0YI1qLNxT72ltD/FL5Lp5r7nvLyhrN7FP+ChhIuvGV+ufKGKxnvNpetM5HPsSJtEqYGYkFX/RMJwPX5MY+yfB8O77zpS0Q/xqooaLjzwG85vvLiOW62OILWDNbNf7wNkoO10JuoIxBNX6KM2pL0+3OfhDx1hQvXkGxyp7++eouzNR9d0bN+NfZ0Hfzhi5oDtRV77i+oP4Astm/QsTdiv9+wpdsz+rThRJY2lFoRazuhTdhvWiGgK3iKdfI5jmP3QfBG8gHJQrwyrvr2uTlfRxvCt5dmgkl1ySMAGYRnKZfPSV6zZF9/3Yn1kCgYewNtTL+6lh4TfLIblH4L3KNFeYwAqBMa5rcB2muIZygU85xZqu61jkQb5mN1mbug+lBdIFYEJrxBRQ0vYeFB09G8w7opz+vnuxgigMSb3c8yRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(2906002)(36756003)(31696002)(6486002)(5660300002)(86362001)(38100700002)(66946007)(66556008)(30864003)(66476007)(4326008)(2616005)(478600001)(16526019)(8936002)(8676002)(53546011)(52116002)(6916009)(31686004)(186003)(316002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2c1THF1SUluWUg5YmdobHY5MTNrS1ZBRXU5N2pSZ2ZuQ2Z1NHJ5ZXg1amVz?=
 =?utf-8?B?dG9aRml3QnU1OW9ybFB1SFFHRDJINVVQVlVXeGxmZEkvVlc5UDBhaHJvMldj?=
 =?utf-8?B?TkVoSzJEOVh2dEorTEN4blhOK2xJczRLcm1KOGpQaTFJV0IxaXlwWkQrTkFU?=
 =?utf-8?B?NURUcFlGeXRWeXBoeVNoYXNzV2RUS0xacjg0bnY4SzZtWXY0S1RVcWJNTHhY?=
 =?utf-8?B?VFh6N1p3MHdOdnhxZlBmV2VWc3BwSkMzNTVuOGZwK1ZBQVJrejN3em1uL1Rx?=
 =?utf-8?B?SHVHMmVCenJ6anR6UHZXSnRTUjZGS3ZodkhNQlFIOEduZXZpajFOQ2VacGdD?=
 =?utf-8?B?dHRMenB3TEJlUFlpYnZZTWwzTElBT3VaVnJBbTNZMW00VGxWOCs1akdUQUJq?=
 =?utf-8?B?bERsb0pHeFRqSFdOT0lFcnJCNm1XS0JmVXM5eEtnYnZjMmtEZTZRaldzeG92?=
 =?utf-8?B?UzJLSFlURjBJbkFpTUZGSzZUb1BhVU1DalBHNnFyaERyVnVyUEZGdktIWGxC?=
 =?utf-8?B?Z3k3QmZtZGxCRUdKNDk3WGk4ampQZkxSaXF2dTZPQW0vYjdjWTNURGJoSi9Z?=
 =?utf-8?B?WThjc1p3WTJxVFNjU0M0bnREdGFNcGdVWS9yYmJRUDRXajhlakkrRDJ1Y0Fq?=
 =?utf-8?B?UmUzcTVwZWZ2bStRSjJqNUlML014T3lpUGpWckw2dCtDbEZGOVNUNWRBK3Z4?=
 =?utf-8?B?RHNaYkt3SW03QnVrOUNDU29mMkMxNXdldU82eHdBRVNZc1NkVW9HYmtkdVY2?=
 =?utf-8?B?NkV6QUJGc3JVWk5NRHp1aUwyT3R6NmRpKzRBU1hRdW5TOHlGL3RRY1NSRGZ3?=
 =?utf-8?B?dGZXTGZNOFo4b0N1N1RESm9yTCtKMzZWNTAyb3g0eHFab25tOVkrcFhOYmRT?=
 =?utf-8?B?alJOSUphSGVHeVFaT01kd2ZxdWwzV3k4dktIOXlnTzBhZFpwK1NJRE0xL2dF?=
 =?utf-8?B?aS9waVE4c2dEWm9mMUpvOWxwRWNKUW9XV0pmUGVSV0ZrTmg1TDYxbEhwMmM0?=
 =?utf-8?B?VGFXSWNxamhSb1V1RUt6WjVoYVNVTldzeDJPZCtXbi8xQnFLUFFtWTkydC9s?=
 =?utf-8?B?eUY5NWp2a1ZpOXR1ei9ZT2ZyMUp1RGdaYUM1SkprYnRQUFpFZ0NLTDBTR0VN?=
 =?utf-8?B?SHBkOXg5dVpaeDRLc0hnODlZUXZ1Q0c5akpzeU5abkhOWjBTZG1hZjFMTGk4?=
 =?utf-8?B?VDA1Y3p3cGxGL3hzUFlzVHZKRHJnR2tzMXkvcXNHcWlLUDhwZ0N5QVc4MWZK?=
 =?utf-8?B?S1R3b1VVOVRmdkg4NnlOYkdTbzU0SS81aFpTcFh4UFRNZ2lOR3VwUlhHUW11?=
 =?utf-8?B?OVo1aVg5TFN3cWJoRnVhZmcveHVmV21oMkVuVXRwZGVhMjlDT0tQWXlBWk1i?=
 =?utf-8?B?S3pOb0p1bnpzQ3o5em5NN051RmNDYWtZMFFkbkFFdXVrVFkrNzNvamQ0UzNQ?=
 =?utf-8?B?SE9wUTVEbTM0RExodEIvSU1QMEJpVzZ0UUp2THVMczkrSWVRRW1qb1BaaytQ?=
 =?utf-8?B?b1YyRW9GQjJrZndWOWtveXowMmZMYW5CdnlEM2tzVk0rRTBzTHdYUGpZZXZi?=
 =?utf-8?B?andRR2xPeFkzUUdCS09mdDduRmJrYlhTcStZYWlOQ0NGWGtlQUFCVnNINnVF?=
 =?utf-8?B?RnNLNSthbnVOMGJoandFZVJBZ3BUYmJCajdhRDBvRStySi9CQTBMMXIyd1I2?=
 =?utf-8?B?ZVF0UUZGMlp3dmdiaU5CaW4yaFJDcmdSL2ZWYUVJTkJjdUtNb1Jtak5Kb2Qr?=
 =?utf-8?B?M2dQcERhbHVoRFBtS1BBeXRCVFFla0hjSytsQWRZL2lHa2pwSFNNVkxuM1N6?=
 =?utf-8?B?aW1obXJUbWtTOE5RcHdFeUVnZ2xFQmpzOCtBT0NMS3pXRXNCZHFya2xhN05R?=
 =?utf-8?Q?Zo2/raY8QYpq/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f724a5-46f2-4d2b-7800-08d93499929c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 09:47:24.5029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0+19Zg9WgT7FKJHHXlO+Qq54hfKwWASTlpExep6HktFNb5luwpREmKhzrLzigH7zjlsQI4gcIyP4VYQAfqHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping.

On 6/17/2021 3:03 PM, Nirmoy Das wrote:
> Cleanup code related to vm pasid by adding helper function.
> This reduces lots code duplication.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  17 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 176 ++++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   2 +-
>   3 files changed, 96 insertions(+), 99 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cbb932f97355..27851fb0e25b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1149,7 +1149,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_fpriv *fpriv;
> -	int r, pasid;
> +	int r;
>   
>   	/* Ensure IB tests are run on ring */
>   	flush_delayed_work(&adev->delayed_init_work);
> @@ -1172,15 +1172,9 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   		goto out_suspend;
>   	}
>   
> -	pasid = amdgpu_pasid_alloc(16);
> -	if (pasid < 0) {
> -		dev_warn(adev->dev, "No more PASIDs available!");
> -		pasid = 0;
> -	}
> -
> -	r = amdgpu_vm_init(adev, &fpriv->vm, pasid);
> +	r = amdgpu_vm_init(adev, &fpriv->vm);
>   	if (r)
> -		goto error_pasid;
> +		goto free_fpriv;
>   
>   	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
>   	if (!fpriv->prt_va) {
> @@ -1208,10 +1202,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   error_vm:
>   	amdgpu_vm_fini(adev, &fpriv->vm);
>   
> -error_pasid:
> -	if (pasid)
> -		amdgpu_pasid_free(pasid);
> -
> +free_fpriv:
>   	kfree(fpriv);
>   
>   out_suspend:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63975bda8e76..562c2c48a3a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -87,6 +87,69 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> +static int amdgpu_vm_pasid_alloc(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm, unsigned int pasid)
> +{
> +	unsigned long flags;
> +	int r;
> +
> +	if (!pasid)
> +		return 0;
> +
> +	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> +		      GFP_ATOMIC);
> +	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	if (r < 0)
> +		return r;
> +
> +	vm->pasid = pasid;
> +	return 0;
> +}
> +static void amdgpu_vm_pasid_remove_id(struct amdgpu_device *adev,
> +				      unsigned int pasid)
> +{
> +	unsigned long flags;
> +
> +	if (!pasid)
> +		return;
> +
> +	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	idr_remove(&adev->vm_manager.pasid_idr, pasid);
> +	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +
> +}
> +
> +static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
> +				   struct amdgpu_vm *vm)
> +{
> +	amdgpu_vm_pasid_remove_id(adev, vm->pasid);
> +	vm->pasid = 0;
> +}
> +
> +static void amdgpu_vm_pasid_free(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm)
> +{
> +	if (!vm->pasid)
> +		return;
> +
> +	amdgpu_pasid_free(vm->pasid);
> +	amdgpu_vm_pasid_remove(adev, vm);
> +}
> +
> +static struct amdgpu_vm *amdgpu_vm_pasid_find(struct amdgpu_device *adev,
> +					      unsigned int pasid)
> +{
> +	struct amdgpu_vm *vm;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +
> +	return vm;
> +}
> +
>   /*
>    * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
>    * happens while holding this lock anywhere to prevent deadlocks when
> @@ -2859,17 +2922,17 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>    *
>    * @adev: amdgpu_device pointer
>    * @vm: requested vm
> - * @pasid: Process address space identifier
>    *
>    * Init @vm fields.
>    *
>    * Returns:
>    * 0 for success, error for failure.
>    */
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
>   	struct amdgpu_bo *root_bo;
>   	struct amdgpu_bo_vm *root;
> +	unsigned int pasid;
>   	int r, i;
>   
>   	vm->va = RB_ROOT_CACHED;
> @@ -2940,19 +3003,15 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		if (r < 0)
> -			goto error_free_root;
> -
> -		vm->pasid = pasid;
> +	pasid = amdgpu_pasid_alloc(16);
> +	if (pasid < 0) {
> +		dev_warn(adev->dev, "No more PASIDs available!");
> +		pasid = 0;
>   	}
>   
> +	if (amdgpu_vm_pasid_alloc(adev, vm, pasid))
> +		goto error_free_pasid;
> +
>   	INIT_KFIFO(vm->faults);
>   
>   	return 0;
> @@ -2960,6 +3019,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   error_unreserve:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
> +error_free_pasid:
> +	if (pasid)
> +		amdgpu_pasid_free(pasid);
> +
>   error_free_root:
>   	amdgpu_bo_unref(&root->shadow);
>   	amdgpu_bo_unref(&root_bo);
> @@ -3039,18 +3102,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto unreserve_bo;
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	r = amdgpu_vm_pasid_alloc(adev, vm, pasid);
> +	if (r ==  -ENOSPC)
> +		goto unreserve_bo;
>   
> -		if (r == -ENOSPC)
> -			goto unreserve_bo;
> -		r = 0;
> -	}
> +	r = 0;
>   
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
> @@ -3088,19 +3144,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->last_update = NULL;
>   	vm->is_compute_context = true;
>   
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -
> -		/* Free the original amdgpu allocated pasid
> -		 * Will be replaced with kfd allocated pasid
> -		 */
> -		amdgpu_pasid_free(vm->pasid);
> -		vm->pasid = 0;
> -	}
> +	amdgpu_vm_pasid_free(adev, vm);
>   
>   	/* Free the shadow bo for compute VM */
>   	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
> @@ -3111,13 +3155,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	goto unreserve_bo;
>   
>   free_idr:
> -	if (pasid) {
> -		unsigned long flags;
> +	amdgpu_vm_pasid_remove_id(adev, pasid);
>   
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
>   unreserve_bo:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
> @@ -3133,14 +3172,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
> -	vm->pasid = 0;
> +	amdgpu_vm_pasid_remove(adev, vm);
>   	vm->is_compute_context = false;
>   }
>   
> @@ -3164,15 +3196,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		vm->pasid = 0;
> -	}
> -
> +	amdgpu_vm_pasid_remove(adev, vm);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
>   
> @@ -3334,16 +3358,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>   			 struct amdgpu_task_info *task_info)
>   {
> -	struct amdgpu_vm *vm;
> -	unsigned long flags;
> +	struct amdgpu_vm *vm = amdgpu_vm_pasid_find(adev, pasid);
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
>   	if (vm)
>   		*task_info = vm->task_info;
> -
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>   }
>   
>   /**
> @@ -3380,24 +3398,16 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   {
>   	bool is_compute_context = false;
>   	struct amdgpu_bo *root;
> -	unsigned long irqflags;
>   	uint64_t value, flags;
>   	struct amdgpu_vm *vm;
>   	int r;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> -	if (vm) {
> -		root = amdgpu_bo_ref(vm->root.bo);
> -		is_compute_context = vm->is_compute_context;
> -	} else {
> -		root = NULL;
> -	}
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> -
> -	if (!root)
> +	vm = amdgpu_vm_pasid_find(adev, pasid);
> +	if (!vm)
>   		return false;
>   
> +	root = amdgpu_bo_ref(vm->root.bo);
> +		is_compute_context = vm->is_compute_context;
>   	addr /= AMDGPU_GPU_PAGE_SIZE;
>   
>   	if (is_compute_context &&
> @@ -3411,12 +3421,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unref;
>   
>   	/* Double check that the VM still exists */
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> -	if (vm && vm->root.bo != root)
> -		vm = NULL;
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> -	if (!vm)
> +	vm = amdgpu_vm_pasid_find(adev, pasid);
> +	if (!vm || (vm && vm->root.bo != root))
>   		goto error_unlock;
>   
>   	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ddb85a85cbba..ee994e21dffa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -376,7 +376,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>   void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>   
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
