Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4C1EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 15:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BE710E5AD;
	Fri,  7 Jul 2023 15:06:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D09D10E5AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 15:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7MlJBYHnQCmD7OmL7uxjk+FW0W7GiR6+aT019m1EY8l+fmo/wy3GdXcrAVLapejjKAfzSKSf+zPG+pPPJCphBezJW5OVZ21oTDOK3y4v50yJ8aqH8IGvoUXE4tZdfQFmHqcyBHGsrgOY5Acd4VATNfNU8/Jt8RcbYRJ1X/DDMiNGBWriXj3qsrT/Hbt154Hfo+bpUKdnZZh2/l2z6vuFuRFYZZhpujPLabn8NG7a/IHSaHP9P31NH8lzmOkFzi1yTB30/SFQurDC8xxvDgnv8ZkpJcgefKQLeJm2SVIbtOqg2LUW/ZqlcO39WOiphPDY+QfinFcmf3ODG1ycGfMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhXtzzrPRkn+COn2xqnKMhvwxH1gxaB7JkvnRwWUfjE=;
 b=Pu5uY85Ie6A7OP1G3O17CcpjSr8+0dP+FlZdb/eZm1xReV8atGj+ezShXR6HxTxLAjrMcXPzyP5QkidgJE5JrllIvQkWdKU79mlD/QtncRc2oBXRIoHMwHOfTNQUbJsZPPsPxQYiCujY7y7y8WccKmjXDACjjzQqMr9ICIODJ94Ra+1ty1R/X7Oup40Qm4tSqiepteGc6y1pjipvAIq0SBn3llIG6A6lxItJURxN154AeaveqXHtFFzv6GqIeE5p6tJRd+/nOH6io0x4CfY4p9fkH/9k4vtCViqyL54dmoiv57t/wTXgHeux7S/xPRowcIdSMwdTKiW1bbzh8GDulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhXtzzrPRkn+COn2xqnKMhvwxH1gxaB7JkvnRwWUfjE=;
 b=W0YFzlvfJZ5kLeWGDYeAYZiihZhsKcfIdt/66z488klnAjmayWve/u7yZ7d+2jFF/j4h76VYUXC1iY3JMstaGCGumhLnjT6LR47ogk5TVLNW4GGnnCBWnWxnzBLJcOCo11B1BX3sZ0KaGMIp7fQY1GBugAuJWvBFDH+kUhLFofw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:06:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 15:06:40 +0000
Message-ID: <61ed0d54-8997-1468-6267-03441a0e7074@amd.com>
Date: Fri, 7 Jul 2023 11:06:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Increase IH soft ring size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230707141452.10908-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230707141452.10908-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 984eef64-0913-4ef2-b551-08db7efbc4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIYZQxX6Gr0sm9ilJfoyg+cxy0XWsh9lseCvwOECWMnAmV5mIhcPOjH8arRxZzdczMUgsjuFSIyRMmRD8bPX4sZlkBmdXEo2JfAe7zYXoRqQNpkjttQQ6ZfuHLHp/23UTG8PAxbXXwpq+WljpX4Pr/CMUHX1UoX1jXMPUpQ1KeXQj+xGXen3KlDV/zLu6JknROw8ZedW/NrTVuexXeTPwLmxw0g9Ndbas+/42u8s3mldIDV2NyWqZ90O6AZ/YrhGalGRsYEgetDayWHRW03bOhmSKFCHxEa+45PB/1VtleSfv4Ginq8YMKJ84Tu4RFQSP9oyBCJ+m5vN6Pzufc4ebd++E9Yu19m7pi9wwfOgNUFbQeFkIHBDgAM4ErFIGeVDCmP+YWMQr4AqJ7zexryhc0nTUHYWw70IyxvUBPo/wJoLoEjR/1rYJdgbexOfoHWic3q7ounaKhnSlgQpOL1cLQVCCn/DrxFbs1SLodXfw8iq0uXQwjflw314R8bGiLTYw8o7/iteIWRTtjQYVZjJ5w6BWHcbL/mKtuNJiLsCOv30ZCOeoF8jlCm0ERwzALDAIXC6JZXOlUvoofHkdePqcbJT7V//Db6f4GFsBSNcR/8hs4w2IYiYpYWUHqhgT+Tbo8NXhf6CqB/5/oSNUGUgVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(44832011)(41300700001)(5660300002)(31686004)(6486002)(316002)(2906002)(8676002)(8936002)(66476007)(66556008)(66946007)(36756003)(478600001)(6512007)(6666004)(186003)(31696002)(86362001)(4326008)(2616005)(38100700002)(83380400001)(6506007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWo3UFM2blJ2aHRZMkRkMWRhN1MySHM2T2FCckpra2t3OWdldlBIWHVuWVo4?=
 =?utf-8?B?YndWNlp2RVNMRmsxMTMzYVJiSEJnUmVIeXFnZ0FXNHpsdWNYeEhoN2ptMzdt?=
 =?utf-8?B?ZG03QmI3YmpCS2RFRkRHQjc2RE9iK2JHZk1OMU41YVdCYnpadU5zRjU0TGtJ?=
 =?utf-8?B?dGw5RE1CeU45OTZYU0xKdDRjUk80QzJ2RU5wWmJYZWNiWEl0MGRNd0c1THZi?=
 =?utf-8?B?NHNOZzdkWFJLN1AyOC90eGVoVmNkbFFvNXkyemJ6NkN2OWMrRW1pdEgrWTNE?=
 =?utf-8?B?eTdNdVd0ZE8xV0NESU01cmdZZHN5UHMrV2dwY015T0w1VDVOUE91c3NpTzA3?=
 =?utf-8?B?aG1MWisybXd5MlVGb0dpdGlBNStNM0R6azZSMTBUakhSQUtRYWxUZ2lReHpB?=
 =?utf-8?B?MmxhcVBHeWl0V3BNLzU5OUpsM01KcEpZQzR4aUJyV1FJRkNjZG04SHU3ZUdz?=
 =?utf-8?B?RjA0MjY2RmZFdDR3czJKMWtPWmFCTlN4TW80MzduMktzZEl2aGRUcmVvZ3BL?=
 =?utf-8?B?bUpycU1XTmVYRzFSL0N1LzNsT3hUTG16aDFUYjlGQXlDZ3VFSHBNS0gvdEd6?=
 =?utf-8?B?MTh0K05tYnFJeVNnb0ZyN1JKUlFPc3ZVTm1TaVRBallkeEJrTVNLblJZZXZv?=
 =?utf-8?B?NmJvdGk1THBhcitQMHFxVCs5QkhGd2VTbU1JTG54dHJCbk5YUHdybnlvZUda?=
 =?utf-8?B?dTUwR2k3a0QvVUVsQU9haS9zWVpjTmpTYTJDRDdSVjlpV0dNbmJVbk9vQ3lv?=
 =?utf-8?B?NzRWT1Y0VFpSdy9QRGdLeVBtNTFGUGVrUm11YlVadFdkWmtZZ1ZFVEo5ZlBn?=
 =?utf-8?B?ZnJVT2JJdDIxVERSK2ZpdUdpTXZER3V1TjFDT1JIcnlwcXhaN015V1ZEcXdh?=
 =?utf-8?B?UTFHOXdrSkJVbGxncjAvbTRqVm1vL0xmYjdyYlJOU1c3OG5ySk9oTG1Lb01C?=
 =?utf-8?B?V2pxYlRGdFp6RERSaUh2dFhtNk5jYVVnSVVkbHNJTC9PWnZOUE5KUHoxeTFI?=
 =?utf-8?B?QVFVc25rZ1ZuUjkycjg5NVBaSXJvdXRsL1NKYm9sMVN4a2t6cXUzenZpcjVs?=
 =?utf-8?B?STZVQWgrcVYrRldkT1NHMXZGU1pBU0dUV0h0MWJNczFjV1VRcXZXV1NzM3Ra?=
 =?utf-8?B?YVk2OU41VDJiV3JoOVlLU3p3bEFHZEpSb3FnMytuRkppTDVKWkZhOXlZYTQ1?=
 =?utf-8?B?MGQ3WmlLQS9EbkRRU0ZNM0J5R0NsRzlQTGtkNjBJOUxvaXIvOXdPVk5yNlpa?=
 =?utf-8?B?ODE1NkhqcWlvYkdCUWMxbFFHU1pTMHJTSHRaSVhrYTYxRzVkQ1dvUGh1ZjFx?=
 =?utf-8?B?Z0I2a01xV29PUGVDZzZ4Tkk0SEtUYjE4WHdSZGJaYVRyL0NER0xrc1BaT0NH?=
 =?utf-8?B?SDRSSU9IQjFRYWQ1UmJJdy8wZWwxK0hGK0VtZmFIVjlKR2NNaVpEdjgvci9K?=
 =?utf-8?B?WE0reW1lQUtiM3lJTS9QRnJHdzBJa2MvY1c3RnZ0VHRVR2NucVA3Sm5DNmk0?=
 =?utf-8?B?MjBtQnhIamx3UkFNajFiT1plU3Rsa2J2OHp0YzBwS2w5V055a3AwdVhQY3d6?=
 =?utf-8?B?Q0JMb2E4NzdUSW1zMStYTmU0WUx1THZDbElpRWhoY0pFWHlVZWpNWDJlS2Ji?=
 =?utf-8?B?bmFqMUlPcVBzajVPWmcxN2c0dEk0RzdsWmJwdEFHNk5rYjJ4Y2lmcWc2dXhN?=
 =?utf-8?B?ckhDMWJiL3Y2RjdRMGZ0YmJPSUhDNVQxVzdXMzlxRlFRY29uaGx5eVNHM1JI?=
 =?utf-8?B?ZFF6Ymt4S1NFYytLa0w4Y2JSYVJNR3VNbENScmppV1grRXhCY0ZzdGVPNmN0?=
 =?utf-8?B?NHU4U0J0ZDIxZHp2QjhPUG5zak1KdlIwL1BjNkVxV2FEd3liVFJzRUxqWThq?=
 =?utf-8?B?c0M0WVdVU0dRWWxyWjh2dWpaQkxjY0tTSktNWWJrVlhDNDRrblVIZSsxdjB3?=
 =?utf-8?B?SkVzUkphdzZ4NUZYMlJVV0FZODU3bFZWMEFLZTBMeTJLa2c4MVI4ZzVyVHZM?=
 =?utf-8?B?NllldW56RlVxdm43QXNzTkV4bVRtdjhNNFU3SmZOMHgrZUVxUnRhaFVUN3hn?=
 =?utf-8?B?a2hSMUV6M1pUSmlFd0FQRk1ibXp3MXhsUUhlWVNsZjEvUDFIWThrTmZSK1hO?=
 =?utf-8?Q?GYpKDFYyUwQFlOfniNErH/8lb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984eef64-0913-4ef2-b551-08db7efbc4c3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:06:40.7826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9hgprOmWVA5t+jYc9kyehFJxeUinvpEh5WT2aCZVXaO0P3tKtNUQW0/1xm/R90n7+wO9e9l4F4llB55X1NlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
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
Cc: mukul.joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2023-07-07 um 10:14 schrieb Philip Yang:
> Retry faults are delegated to IH soft ring and then processed by
> deferred worker. Current IH soft ring size PAGE_SIZE can store 128
> entries, which may overflow and drop retry faults, causes HW stucks
> because the retry fault is not recovered.
>
> Increase IH soft ring size to the same size as IH ring, define macro
> IH_RING_SIZE to remove duplicate constant.

As discussed offline, dropping retry fault interrupts is only a problem 
when the CAM is enabled. You only need as many entries in the soft IH 
ring as there are entries in the CAM.

Regards,
   Felix


>
> Show warning message if IH soft ring overflows because this should not
> happen any more.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 5 +++--
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 5 +++--
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 5 +++--
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 5 +++--
>   7 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index fceb3b384955..51a0dbd2358a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   /**
>    * amdgpu_ih_ring_write - write IV to the ring buffer
>    *
> + * @adev: amdgpu_device pointer
>    * @ih: ih ring to write to
>    * @iv: the iv to write
>    * @num_dw: size of the iv in dw
> @@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>    * Writes an IV to the ring buffer using the CPU and increment the wptr.
>    * Used for testing and delegating IVs to a software ring.
>    */
> -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
> -			  unsigned int num_dw)
> +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> +			  const uint32_t *iv, unsigned int num_dw)
>   {
>   	uint32_t wptr = le32_to_cpu(*ih->wptr_cpu) >> 2;
>   	unsigned int i;
> @@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   	if (wptr != READ_ONCE(ih->rptr)) {
>   		wmb();
>   		WRITE_ONCE(*ih->wptr_cpu, cpu_to_le32(wptr));
> +	} else {
> +		dev_warn(adev->dev, "IH soft ring buffer overflow 0x%X, 0x%X\n",
> +			 wptr, ih->rptr);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index dd1c2eded6b9..a8cf67f1f011 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -97,8 +97,8 @@ struct amdgpu_ih_funcs {
>   int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   			unsigned ring_size, bool use_bus_addr);
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
> -			  unsigned int num_dw);
> +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> +			  const uint32_t *iv, unsigned int num_dw);
>   int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>   					    struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 5273decc5753..fa6d0adcec20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>   			 struct amdgpu_iv_entry *entry,
>   			 unsigned int num_dw)
>   {
> -	amdgpu_ih_ring_write(&adev->irq.ih_soft, entry->iv_entry, num_dw);
> +	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
>   	schedule_work(&adev->irq.ih_soft_work);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index b02e1cef78a7..21d2e57cffe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -32,6 +32,7 @@
>   #include "soc15_common.h"
>   #include "ih_v6_0.h"
>   
> +#define IH_RING_SIZE	(256 * 1024)
>   #define MAX_REARM_RETRY 10
>   
>   static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev);
> @@ -535,7 +536,7 @@ static int ih_v6_0_sw_init(void *handle)
>   	 * use bus address for ih ring by psp bl */
>   	use_bus_addr =
>   		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -548,7 +549,7 @@ static int ih_v6_0_sw_init(void *handle)
>   	/* initialize ih control register offset */
>   	ih_v6_0_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index eec13cb5bf75..df33db6fd07b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -32,6 +32,7 @@
>   #include "soc15_common.h"
>   #include "navi10_ih.h"
>   
> +#define IH_RING_SIZE	(256 * 1024)
>   #define MAX_REARM_RETRY 10
>   
>   #define mmIH_CHICKEN_Sienna_Cichlid                 0x018d
> @@ -565,7 +566,7 @@ static int navi10_ih_sw_init(void *handle)
>   		use_bus_addr = false;
>   	else
>   		use_bus_addr = true;
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -578,7 +579,7 @@ static int navi10_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	navi10_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 1e83db0c5438..c9b37983a18d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -33,6 +33,7 @@
>   #include "soc15_common.h"
>   #include "vega10_ih.h"
>   
> +#define IH_RING_SIZE	(256 * 1024)
>   #define MAX_REARM_RETRY 10
>   
>   static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
> @@ -485,7 +486,7 @@ static int vega10_ih_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> @@ -510,7 +511,7 @@ static int vega10_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	vega10_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 4d719df376a7..06d4176e4c68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -33,6 +33,7 @@
>   #include "soc15_common.h"
>   #include "vega20_ih.h"
>   
> +#define IH_RING_SIZE	(256 * 1024)
>   #define MAX_REARM_RETRY 10
>   
>   #define mmIH_CHICKEN_ALDEBARAN			0x18d
> @@ -539,7 +540,7 @@ static int vega20_ih_sw_init(void *handle)
>   	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2)))
>   		use_bus_addr = false;
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -565,7 +566,7 @@ static int vega20_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	vega20_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
