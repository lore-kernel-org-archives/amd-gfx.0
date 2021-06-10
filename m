Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BBBC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 19:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5D5613DD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 19:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5D5613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B486E0C5;
	Thu, 10 Jun 2021 19:54:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 679436E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 19:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvl7w4RYwCulPWZ2RiWnt0mQESNosAyoJUg9ajNnSrBWhPQvevR0C9okgFZMWfrVMn/4R6zxGRUeyZxc1SpxQY4VjvZUqcUAhj6H67XTLGvPSadIZWWso7nkKYIFCTqVZtqelqV5gFiilSE7YJGDy+jHsupty6ejiJxDoDQW9o8FDV0AEYQ3fi/ozBsSduj9nZzQFNHf3wqXsr1fR9LxD8zkTCHY+lGremLxDO9d2lVRC3cPYYn/f29/blyRoTxnPvlOc88EPKmHk0/2NFNHOGkU7RRAUFQKONQV+Thum9JTE1GnrMZ7N3M0e+aXC1pUZdpSHnHeWbTezn0LHlG8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqzOG3V6A61X+XTyV36tKsrkELsYcbBFXrwYudabZvE=;
 b=GtDwKFZkGaDn61oOZXL1flIZdKFVU6S1eg1LA0FxoxsbgkKS7q/MpFL6WD1jQtqCEgt9H70ZRdi9Pd8F96KCJDT4DEPssRCTnxrDoKKjhAI0t9LofI+Bf1tPF1v3z+m71a38pQY3x3xFXtQrgIJm48qNQO9/JZ9JaqvPlhKjHdGzPcwiocNdJVUI/7quxB2U+XKbasM1F7Odllpxu/DdrfcbPrG2XpVClk8xeLufUd8s3chREbnYm+5ZTrpKv/jClvP6G5CfYvUC0EKq5r2haSjV2bGEpWGhKd3WkadUyGTH8CZDqKSOSADF2VPrGg254Ta0WMTdskTvgZerqPd7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqzOG3V6A61X+XTyV36tKsrkELsYcbBFXrwYudabZvE=;
 b=SFq13EQ6n1+m84n1M27CNh/7ypg2xCOU1lZVCVTOLeS/+k07j7vdsWwVG0lnDySfuUpVjniF2a6e64Z9VfL11r+XYoDKKzZ6QTjvgMleurX2m9riOzV0UuMBCUX2lVDiLmib4Ur8EIkjI+AJGkTmOroAHPdm23+DjSWviPIRm6Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 19:54:55 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 19:54:55 +0000
Subject: Re: [PATCH] drm/amdkfd: Add memory sync before TLB flush on unmap
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210610190009.202645-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <c644357a-9343-64ab-4886-a5a6972d3053@amd.com>
Date: Thu, 10 Jun 2021 15:54:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210610190009.202645-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::14) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 19:54:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dee0a938-54e1-4d6d-036e-08d92c499e20
X-MS-TrafficTypeDiagnostic: BN9PR12MB5178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5178F3E5AFF535A0B8CBA5ED92359@BN9PR12MB5178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSXPtiQxcPOM/l4zIRdv92TrMgLQ9enDEkh6ZTIr6GPA5fTpsSEH8AKJBb22gswIZKfrstc0xsbI6aKSsZlImXx4lz4HOV3TwByBXscxdP/G4HDrBCW9hOiWgLqdlDn2rB0NwGhKZ6NwAeoBOlpWC4QhhgGCJSi+PClb1NHn77fvjZDrBN/v86OEzYNSzLhW5duTIQ/z7qNnXbpaQD1ZOylaDKqc92EZJ+MbYy4eB78jk/IOMNqHsyUNfieJo4ZruNWXg9wX7ESnTLkPKlNkn5vGOJVYnIgEAtUFNjV4wLVdDyL/Xgf2CJpMIFfQZjzy2wHdgV0WhiHQ5NzYOuJHUOQ/h1yjkGRQLEq+LPu+UzO7hO3qXOMKOkRG03q/9ZLqMwT8iMfPwxEy9cE0lm8drJoccQ7MXXCJiHWJVnVZwcPjeT+15ZlG+dRdaRON391s9LW7FwE8ud8Dm/jEtF6TnuhcCWFz3vS7qUXJ+cul+t3QGGbleOkw1yf8b3uw53DpE7pWEKNekYFNnuZKwJzTyn4UY49iSh8F7+6GalxMLKKHfYkbSpug6p+sNC6X6xTxU+7803e5DYHe78munL+HZExrwCEZwXE4riOOkypzmg3/xc2fOQbXno+K6sBjhaDqNYze4zZFu7mKMRlrfDaNdGst8pwNsIpCG9XFwiG0JAThWwbe6WY9VrNNS6/Ai/z3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(16526019)(26005)(186003)(8676002)(53546011)(66946007)(8936002)(2616005)(66556008)(956004)(31696002)(66476007)(86362001)(38100700002)(5660300002)(316002)(16576012)(2906002)(31686004)(6486002)(478600001)(83380400001)(36916002)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVRRbzdvbXBudklHc05CdDE4VWZUNHJxSlBIbDUyT0QwYWVNeWtwUncvdXNv?=
 =?utf-8?B?cWZ0VG1nNWV3M2hNdVBtUXIrbFk3ZWxRUTMyRVpCUjZ4VDVxaTFnbVVvRVkr?=
 =?utf-8?B?M2o5MUlrUmhDeHhVTURqUEJuVnBCeWVoaUtoZU5Kelp4NXNLODBaTmtyOVNx?=
 =?utf-8?B?UkI5a0M4TkxwU2xwNmM5MDdtMWdWV1ZrenpJRURvbWZ4SnE2aENBK2R1RUVQ?=
 =?utf-8?B?Z0s3NzV0dVdBL24wUmZhdm9jWTBXdU9FRUFZeW9MclZ1cUtVbW1BNnROdS9x?=
 =?utf-8?B?L1MzNTRya0J5SEpaMTZZZUFMcVZva0FrWWptOFRUam54aFZiN0pLdHp5THNF?=
 =?utf-8?B?UjZwQ09IM285K3ViSE1aZ2trc2VBai9SM3lwbnpKVTd1MlNRRWw5MW5KaHFy?=
 =?utf-8?B?VnJiaGhvVDNyR2pFeDl1Znh5ZkFsSUdzNUFaMGgyeUc4RG9mdDFybk9YWmtD?=
 =?utf-8?B?eVpYK3ZLcklyUnIxOGd5Y0d4Wlo4TDZ1d2FjZDZsOHZwRURXWkk2ZHBPZ3h0?=
 =?utf-8?B?L2dYeitUSGZKQVErMDN0cDE1R3NRRVd6NmFWZ1BYdm51TjFxOTk5eTc4L1BE?=
 =?utf-8?B?eDhkazlScTArTWMrNDBJVlp0VERPTnVtSUZyd1VDdlNvQnMzZVhrWjlqWmNu?=
 =?utf-8?B?cm5WWkNPdHB6Z3VnVkJGQmZlZVFWTTM5QVFMNVVuYldZMEo5Qk1wdDhTYTgw?=
 =?utf-8?B?L0l2dGozdkxKd2pvQWd6TW1QVmIveHhFVG93citPRncvM1BpeUtBQTIyb1V2?=
 =?utf-8?B?RjJXMEtwSERoWWtzRitNK0hURUJwTW1WQklWS285WTluWmxQd0NNS2d0VVlF?=
 =?utf-8?B?SWFONmFXTXlMdTR4Q3owTzJZRmFWaXJXbTVjRThHRUhpYy9sYTBLc04xWUxC?=
 =?utf-8?B?KzBDZS9DQ1FEeVRIUTZQOS9HUThibThwbUpCcGY2dUxFQ2hRUEFZRTJMWVVo?=
 =?utf-8?B?RGR4eGV0VnZIU21jVEZvQ3FYQVRmZlptZnpsWXZOaW9hdCtiZi8vMXVjMlNS?=
 =?utf-8?B?L2RXV3ZNRElBcGdmOVRBOGJmVGUxSVVoZDZmd0szZ3pacW5RSnhtR3dxZHl6?=
 =?utf-8?B?THp6c21XY3dKdlJwZHNoeGNjaDhkMVJXcURpcnRqWEVhYnI4Z0pMUGo1OG1D?=
 =?utf-8?B?RGVvT3dIN0JSbXVsVHZrNXgxYitMZTZaQzJqZE5ZejV5OHhNNmhnV2RLMGx3?=
 =?utf-8?B?VEF1SjByV204WEpVUVhUbkRldWdVaDdiTmJZZHlxYXNvbHRKalhrbFN4dkdZ?=
 =?utf-8?B?UTlkUlU2L005VzlOeVF3S3lLS3dUaGkwSGduZU9oZyt5aTE0SmJYNDNoK1d3?=
 =?utf-8?B?NVZwek53UU1va0lGTmRPWnJVQVNxVWNOZlIwTzI4VkRKNEluLzlqaHpDSWdn?=
 =?utf-8?B?ejFHZ3hVUzg4em1qY1NsbU13UVdpZVppSUtGRVZoaXhRcjB3Y0RkZDFySVdQ?=
 =?utf-8?B?S1U0aEMzUVNmaDVHQlZURmRoSDcyd1RkZjRCSithd2gyanRxMUpCczVYWHdJ?=
 =?utf-8?B?N1FCWHJGV2ZBNE1tb2FkMis1OFdwTGhwRlFpM2hEUFN2dWJ1Z0hyRllPNHhH?=
 =?utf-8?B?SXpCZGNlYmwvczRZLzJ6WGs5aGwxUVBkc0tJdDVLWFJUUHAwWDZ0WHV1TjNF?=
 =?utf-8?B?enY3dXlyWHl3TmJwVE5XZWFYdk01bzJHalkvUGsrKzlDY0lndEU1bEZkenFX?=
 =?utf-8?B?ZXRXdUhRN0g5aHpvbW82Nm8xQWQ5ajgwK1lDWk51NUZGaUYvODlyZkNyT0dz?=
 =?utf-8?Q?E1K3hBNEw/3nobrytyz4yn8akP69Y13e9r6Z+zp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee0a938-54e1-4d6d-036e-08d92c499e20
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 19:54:54.9277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K96NeEgA/VnSY9kHbwqZQmXXm4yxFVdicUa/m18kLlarxr2P8E4fehUjhjQOcaSRnBfKKHyvkznvg63Xk0UOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-10 3:00 p.m., Eric Huang wrote:
> It is to fix a failure for SDMA updating PTEs.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 +++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 98f1d2b586c5..17d0a318b708 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1766,14 +1766,33 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			amdgpu_read_unlock(peer->ddev);
>   			goto unmap_memory_from_gpu_failed;
>   		}
> -		kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>   		amdgpu_read_unlock(peer->ddev);
>   		args->n_success = i+1;
>   	}
> -	kfree(devices_arr);
> -
>   	mutex_unlock(&p->mutex);
>   
> +	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd, (struct kgd_mem *) mem, true);
> +	if (err) {
> +		pr_debug("Sync memory failed, wait interrupted by user signal\n");
> +		goto sync_memory_failed;
> +	}
> +
> +	/* Flush TLBs after waiting for the page table updates to complete */
> +	for (i = 0; i < args->n_devices; i++) {
> +		peer = kfd_device_by_id(devices_arr[i]);
> +		if (WARN_ON_ONCE(!peer))
> +			continue;
> +		peer_pdd = kfd_get_process_device_data(peer, p);
> +		if (WARN_ON_ONCE(!peer_pdd))
> +			continue;
> +		if (!amdgpu_read_lock(peer->ddev, true)) {
> +			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> +			amdgpu_read_unlock(peer->ddev);
> +		}
> +	}
> +
> +	kfree(devices_arr);
> +
>   	return 0;
>   
>   bind_process_to_device_failed:
> @@ -1781,6 +1800,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   unmap_memory_from_gpu_failed:
>   	mutex_unlock(&p->mutex);
>   copy_from_user_failed:
> +sync_memory_failed:
>   	kfree(devices_arr);
>   	return err;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
