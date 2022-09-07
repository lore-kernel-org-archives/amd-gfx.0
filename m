Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFEEC54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 21:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90A110E8CA;
	Wed,  7 Sep 2022 21:26:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F62910E8CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 21:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB3i6zvFFskYb/5l0p4/COJc3vpIRikirujN38TaEO+hCLK8U74JnpmDWOpTv/V2VWD+3kvzz93+zUWDMr6lSiV3BPfA8Ieg/l1Ld5hfuMlbL1/0vhvkEeVwVWhUhAX3hgzfvmKvr2S5EtdJdU8Z557qR/QtchzJPd9rL5nrZERT1wSB4CrG+U9yJr87VXuPwA16QJLlNL3Ix+yj4tRibzPqDYuT2toKh6WZ+7UeUhpJy5GgEDbl/OmwaiJqaFfioJSMW/X7kt5nMnYdatF9fg8XUknRSwwIFK2rEBjNEEAhhhpzQGxK1e6d7Hy0LtX8ShMDKCVwl6dVKTkXLCxs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsDkr3e+udwp5GErYBSEkn55TTqx/7/cUK9OMw0BmpQ=;
 b=CS9SdxqmgYNlj8OsOHXpFwjeazmrDJJRdkxpydlg4PtBWtXoKhjhcqNIroB780YHi/sEuMGUbHlDO2Z0yO2z0fJNjFk+m8aG9XaXZrzJBP3H5uVr/xgiLAh9zdX4H3fAPRHq3w0hqhqMuz5Cmq2+KOP3ERzv2HDkV0wMFX35N4ppM7QLOe/d9ZvCw35woVTCUbGazqQywAJXiEYYblsrzW3suvpt5oXKCm4Hih5mTS2qdgWcxUKkv6oVfKuHGRC+Cmfw+TduyTDVBDIiXTMlbBzOTAHwK8O5YmWTmzP5NNwfBqtL2YCn54wqCZeQvPSoAMBfbGzMK6NmngYU89hdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsDkr3e+udwp5GErYBSEkn55TTqx/7/cUK9OMw0BmpQ=;
 b=jL5cMO+imHpwr0IeqcYoW+lbdpqRXLzyh/rgwUDszEQR2VOZvczPpgvlBvJTt9pYOrPN/lWOOP4gsfqE/M4lir7Y83D59PQLoPCGt4nNlExYDRwASx170j5hxsLnS7qb7zOg7a4s0yN6n733wQxzYk8leakVf7DEPgzDDqrQvA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Wed, 7 Sep
 2022 21:26:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 21:26:39 +0000
Message-ID: <b847852f-17e2-561b-a532-910415650658@amd.com>
Date: Wed, 7 Sep 2022 17:26:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Patch v2] drm/amdkfd: Fix CRIU restore op due to doorbell offset
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220907194324.22235-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220907194324.22235-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:610:e7::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 962279fc-6de7-4e5b-ecce-08da9117a6db
X-MS-TrafficTypeDiagnostic: DM4PR12MB5818:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1HloYPtOjQEXYE0syziqMQF//knfB1DA+XNxs4EZzJoRIXZd/bfViDlxbtnn5uzVkI82yT/NEFvJovipfhLM7ech5S2lLFitFFC6rEhqeE/2DznjnHMl1ThywF6vt6iWUQThXPyreCddArbb0nR7D/laBOne71d2Hn+8VkLh/vX53/hr6fy6bd2M31oEbi/+fLPkkdxuu6+ySeMfpGqM46Mpy+ShmsKEwL8ppEM/pbH/iVchuikVvGcTdmZjM/nYvVKlZUcD9mJb+FmAeCJdiTl8QNZE27aYbbiqOTy9IMgUYqPnaO//0gX72MvAMkLwJa5xCeHJyJSloOC9/5jebWv0pJqHBAX/d11mDKTxief9XfH73AI7K/59LYiSDKKM73dNk05H/807Lkc4al+tvj9qBo2gZ8GTKAqTYw4Gdp/A355nNKXROISo0FWDlKbfs8OHcu2OwKTH+b8KfbpD6n05bqRm5gRGzcanXU+Jhbsqc1ljDmAMOg985n/37LZBJQk2L1fMreVKSZzle5du74xyBpIj+QyyQvAk3hUAPqasvoDyWo+VvUy/+Ryfwj7yOJ1UlDRxBzYgi91uTvbOLG1xkn4f9/Pbqb9DJxMBvbU7zv+KQ3s9Cyx1JZVkrSeMGopXS56Xzuef619XiY3CPcX/shp3K5Hlu7578mNocAmXhzQCttT+VtpYADzjKeVJF1rKnLCY4dFxqHsUmOQISdcR063uueWffP5FkDUv2y84VD3WvPRA/qpmvxNGbGrepKzPP4wrrSiQbjFkgu3+Iscygz47oLMKD2uY2KI/qs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(2616005)(2906002)(44832011)(8936002)(5660300002)(38100700002)(53546011)(6486002)(478600001)(36916002)(6506007)(4326008)(8676002)(66556008)(316002)(31696002)(66476007)(66946007)(26005)(6512007)(186003)(83380400001)(31686004)(36756003)(41300700001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdBL2MzQnl4NE5VSW51L0p1U09xYzdVN3NJSHh5RnZRZG5VeFdPRHBTRXZE?=
 =?utf-8?B?bmt3SE9XTVN5L0lidlZTbmt3aER3VW1KeHpWdCtrUnFRZTdGbmRTdnhVUXps?=
 =?utf-8?B?SmI5aGU5VkJ1anNqU3g5a2ZGeDM0TXJ6VWxhVm9xMFBNaHNJS0o4a1UrckM3?=
 =?utf-8?B?QjAxaXE5Y1ZNdTFYUE00SWYveFY4dGZ6UjJMS2R1YjA2WUdITSttSW1tRUV4?=
 =?utf-8?B?Vk11YWE1VEtkU0dmTHlBNGdPVGRkdnlpZEdnNFN4V3htbURLTGZnMWFyRTBL?=
 =?utf-8?B?MGtrMU5FU3lVZDhZTW5NVVpWZURPeVFUSXJkcDh4dkd3ZzBwOXVVWFFFa29m?=
 =?utf-8?B?OFFBTVBzOWQvNXFrVHpQOW9kRWdLSnFobTFTSkFGV0hNZlNxaTRBSXhrdUJN?=
 =?utf-8?B?cnpMUWFJNUxRWFk4bDg4eFJHVE9PTmFFR3hJVzRrS203RnhjSTZyNXJuSERR?=
 =?utf-8?B?VUt0bEVROFdWSXdDRVN4UVlrYjcyeFQzNjZQS3phWVhvMGgrZUlnV3RqQSs3?=
 =?utf-8?B?bFd5RzVteXF6TVphbjM1cXpOVmRsMERuak1iQkphYjg3MVlnRnh5dFJTb1lZ?=
 =?utf-8?B?aXF1MUJUOEdtVkxKNGR5VzFTN0ZZbW5neHpZQ0VyZnR5cE96KzUwV1lxS1BI?=
 =?utf-8?B?bkh3NUszUi90UmM0c0VKb0pmeVZhK3JabVZDR1R5K1lDUExqSVpvZGFCQzFa?=
 =?utf-8?B?SEJZdk8rN0lHcGtwbWFKTmdPRmVZaW9tcFExazhneFJQek9nSUxkd29FMXR2?=
 =?utf-8?B?RS9vaUhSL1c0U2NpQUlMNDhOcUtDZlYwc1k1b0tYOUlhZDQzelFjRFVwdVQw?=
 =?utf-8?B?bk93cEk0U2xYeFJOeXVWeXp2bUkwQ0FGd3U0dkVIVWowSmVaYnF4MHBrcHR3?=
 =?utf-8?B?d0EzZGxWZGljeVF1NWVXMWFCckpLbVJTNmNFSklsUFdZNWVPMGE0WXNRZVZH?=
 =?utf-8?B?b0NMMFg1Z3ZEQ2RpbmxiZW53ZWxKTzhlS3g3Z2NDdktzRFJzRTAweE0zT1lj?=
 =?utf-8?B?Z3VscmpmdjVITWc0VWNDK3N2UjBvYyswQXhMaVJhTUJrRnBuWlBQb3hDU2pi?=
 =?utf-8?B?elVDbWpIaEJBUmpmSG9WLzE3am1QdDViczg0QUxzWmVvT0pucXhpWmhiYVox?=
 =?utf-8?B?Ykhpd25XOUNMazR0QmJqWGRqbDZac0hGRGhKc1BHY3lab0hvWHZnUXl5TnJX?=
 =?utf-8?B?bzhpMnVuTkNUTmwxWjFKakMwb29qSWhCNFhDckRqRGVoZjVrampFOGJsVWJC?=
 =?utf-8?B?S1RtR1M5bVYrbSs0TFlhbmRaaFJuVTM5M3pCM3IvcmE2VXMxdmQ4SUE0UGFq?=
 =?utf-8?B?bEdUektrbXN6ZzR0MWgvMVorU3V4K29LNjgraTVjK3o4ZzJRYWRPVW04SkY1?=
 =?utf-8?B?NU14RS9DUjRXUTRIN1FSSTBRZWpSWHFSSWVKYWo0SzUxbWN3VjEwNTNKZkpX?=
 =?utf-8?B?MUdXMVVQdE5BWVpadEltRHorTGhaSFZUSDlEejUxOVJiQjFSVFkyb2Y2bFd0?=
 =?utf-8?B?QnBsaHRUeDJod1gvK2J6K3dMbVFHKzZ2M0NvaERQNGNFdEx6RytaMmxOZm1q?=
 =?utf-8?B?QlJhanhyU2tLQ0N5Y3JLck9uQnBtTjBRRXpMUWtlRFY1Um1oRUxqcHQzT21S?=
 =?utf-8?B?TVNOVHhZRUFjRmhWdkpCZ1Q2M3JrbGl6NHREZXJoMmdpbnBKRkFQRnFlakxD?=
 =?utf-8?B?a2JETk43Zm1MejZRalpRYVlRSEdwQTVjaTAyMVZzYmZJOHY5TGJnblN2MlJS?=
 =?utf-8?B?dkV6RW5LbU01ZzhrNTExMW1aMnBhd1FXQVJuTTYwTWc4cXYzQU5uS2FwbTN2?=
 =?utf-8?B?aUpKQUdMaVBqNWI5YUowbU9iTlQrUU9CQnJGdWpSamNnMFFlbllIZXYxWE0z?=
 =?utf-8?B?c3U1aVJ1K1dEU2k5cHYwdFFZbmlwdVRnbmV3elAzcDBZZndCc0VFTlYvRVYx?=
 =?utf-8?B?YW1DTVVwV25ib0I5NGtiMHFVcTFlME5TN3RUS2Q4ZElLK1pKNDJzZFhvSHVL?=
 =?utf-8?B?ekRLZGFTOHZIS29uS2l6OVowb1JqTE9GWUYvSnJPekpiekNtNGZjNlI1S1lW?=
 =?utf-8?B?VWF0UlFWZWkwZUxGRVVmWnM2ZWkrWmJWNGEyWURmT0NRem83NFd1VmVWZUZB?=
 =?utf-8?Q?Y21CQd9V3/4Ja1u5DtykuFZn4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962279fc-6de7-4e5b-ecce-08da9117a6db
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 21:26:39.7771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsDHPKuSzXj+BQBBlTpt2WwyDnegWKIIzptclSitZNfoR3whdyX44nEtmqguHdga52Ax2YFMn+1MXdHH17mimQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-07 15:43, Rajneesh Bhardwaj wrote:
> Recently introduced change to allocate doorbells only when the first
> queue is created or mapped for CPU / GPU access, did not consider
> Checkpoint Restore scenario completely. This fix allows the CRIU restore
> operation by extending the doorbell optimization to CRIU restore
> scenario.
>
> Fixes: 'commit 15bcfbc55b57 ("drm/amdkfd: Allocate doorbells only when needed")'
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks!


> ---
>
> Changes in v2:
>
> * Addressed review feedback from Felix
>
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               | 6 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c              | 3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 7 +++++++
>   3 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 84da1a9ce37c..56f7307c21d2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2153,6 +2153,12 @@ static int criu_restore_devices(struct kfd_process *p,
>   			ret = PTR_ERR(pdd);
>   			goto exit;
>   		}
> +
> +		if (!pdd->doorbell_index &&
> +		    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
>   	}
>   
>   	/*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index b33798f89ef0..cd4e61bf0493 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -303,6 +303,9 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_inde
>   	if (r > 0)
>   		*doorbell_index = r;
>   
> +	if (r < 0)
> +		pr_err("Failed to allocate process doorbells\n");
> +
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6e3e7f54381b..5137476ec18e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -857,6 +857,13 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   		ret = -EINVAL;
>   		goto exit;
>   	}
> +
> +	if (!pdd->doorbell_index &&
> +	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
>   	/* data stored in this order: mqd, ctl_stack */
>   	mqd = q_extra_data;
>   	ctl_stack = mqd + q_data->mqd_size;
