Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71458C001B0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D192F10E515;
	Fri,  7 Jul 2023 07:17:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944BC10E515
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQtW3XOGvNAXurJAA5JOnaW78IH/W+KjQM5I4iBADkvRxXm1yAZg2ijHiv9XSRR2ooygV2RM5Ryd0Z49/rdvDwd3ncFXEqhU+yB0rk77GB0c6wJkIplR4eovqe3ZGsLYxsoOCvxvd6yZ3th0IRDxvxgzzIanjEGkV+7FUt6kpORc1wWbOjg3VnHNzEMO2kVl5h+YnwP2K6ZJSmYOdFTIne5rqMLjYVitzagE9jwXd8BNARbYByaBwEJkOy7nQ9CvsBNGOqV4Sdy2q7cl6Dv18XBgVueFDfv5obLnAPb1pAXV3QigjAbiUoO34s50S+tj1yX3isUBRCeOO48EMuECog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3otQuEGtQnV961hZersjUcZNZWLabK1l7t38ZENdd5A=;
 b=DQnf3d1gyjIIctxrmVF8Tob0LokB4RkV1CuXshM3WlvMlHzUMAg0AO6g9n2rjMGiFTEQO7CYJvqJVIvaNEYuGnksG/BwbYaW4mJFpJ/AAs5+OMen9thk6pBV6BLF0hQ0Wa4MGDdtuneA9Xhu+k5/ZIMY/0nbAIe+ygA8HspvdEIktkF8Vd8628N3FAx/+xtv3nVghMQvLLOV/k6bRZMBmvth0zsycUJ6aunG/lpDqTHm0kuEhGI1x36lcGsFpUK0JGR4UsN7v0+yJOu8YYfxFBcyh8N8iN/Lv6Tve1mf7bDD7xGW4Em0XiBOd/WAmRtzfGMJlZI+mtVpkE+BTZcgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3otQuEGtQnV961hZersjUcZNZWLabK1l7t38ZENdd5A=;
 b=radb6aDBiKzwZCR96HXy0DvmxZ9UYrrE8gMt/0IyD0yy/etwYTOeCGD0sUG9K2mjA7qGa+8/JSMHEDbgM2rDh5JRABNIWopx3arJj21PciKYnZn60okLv+Gis/xhCxN06+eB6Yy7hhbm+YAyX8vKMFqJ0GlCTxyN6KoEowot1Ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 07:17:20 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:17:20 +0000
Message-ID: <c64191ca-f17b-01f2-54df-63d4c3e4f890@amd.com>
Date: Fri, 7 Jul 2023 09:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 09/10] drm/amdgpu: cleanup leftover queues
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-10-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706123602.2331-10-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 0300413a-3fbf-404f-48c8-08db7eba33db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xt9C6e35avP8Fzp28betuw+fTkUB93JJsS3xRE7rEqllPQldXN6MXajVkD6Qu13GcN9PVNfpo/BfSIqJGFdpM4cFiQuLE1BSKhwmIDhmHKc5GsneHMi1GZ63OOslrH7d1YVWQ1vHPI+m334OKZyz/5NN31mWZ7Sq9d9DXve/QOxKR24Itxhyeqm4EiDDtKCjV4ZCE9p4MWz6N0f9gcWEC6NJQZQVItsLyFE9vKzj9cEiSoHI+7FXYJwfQoDvEpK26UkX8T+lPqftotXHCISV2p5LiIyq6VajkJZps0spTcfhFUQeiZBUil25T6glyoOFiJsw2+tFU5gp2ZqirTx0GchSzP8QTIqp6Fn31ja2m9JsIHmcFaSo7cJY2udMGG3+PpxBVWDvSQRjpbf7nP+11TEZI7WVCfLI0SXZyANV/BZNki63ZQlmCreH+6tkUvKOmHg1BtFe2vs1iAg8vbXUMQMO+NySZEvQQKxD/8kDRQrrvqcHOr02IS1RQQEPJXFFQq33MaR1g4mF2kJOpA6PPrMwfT2ics7N2aB+eO+COXCG1+dnm5llcIpo3bfw//3i2/Ass6lu2xVQ9OwRm7QUr4kV+lZpk7l3fDAAXBcdqNkdrxcUPx1YchP7DbVoCxPxI3n1pgnc41M6yZ4/NBk7Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(8936002)(5660300002)(478600001)(8676002)(66556008)(66946007)(4326008)(316002)(66476007)(2906002)(41300700001)(54906003)(6486002)(6666004)(6512007)(2616005)(186003)(31686004)(83380400001)(6506007)(31696002)(86362001)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm5obFVOTi9XZHZNSFFsSjR3ZUswanVSTEJ5bThuY29tZ2ZqdGZ4U3hlRmQv?=
 =?utf-8?B?U0t4UVU0bHlvN0xsdmRveGhLeVBmVkdJYXNPbFZKdEprdGVaR2l1L1pldVRN?=
 =?utf-8?B?L1VJR1pxb0pvUm9uL0kyc1BrbVZzNWg3ZXBRRSt6UjBKR3FuSGpwWklCempB?=
 =?utf-8?B?VFJhVlI3NkF3K1E2RjNJWVVhZ1ArUnRodEYzNHQ5UlFiRWw4NjhnbUVkbU1G?=
 =?utf-8?B?L2JaRmcwQWY1dWZnMlBiOHgxTjNoNjNCaXZPQ29ISW5NYkhDYVZRcmM5MDZ2?=
 =?utf-8?B?NHVPT0ZCVUczeU9wVis1TmVsdmxwVkNIWEZnQ3IreHVHdlhackpGaC80cVdT?=
 =?utf-8?B?bWtjdlVhL1ZETHo4bnNJbitvZDJDeUtXVkRGOEVIa2hHdG5pRmx2V0pSMXgx?=
 =?utf-8?B?Zkl2QVJJMTFBcVI2Z1Rzc3dyQjZCalN0TEpVRGN4ZGtDbnVDK1lSaDkxQ3I3?=
 =?utf-8?B?dW5SYVY5S3hGTmZYSXVYRURLTTJhTXRCUkg1TUk3cHZGQWNnNDhtRXB3Mzk3?=
 =?utf-8?B?WkVXRUx6bmhGSU5FZ0swVndzMDZsbFJTdkpLUElGWVFkVStSNUdGZnExWE5T?=
 =?utf-8?B?WlpLTWFjODJFQVRQQ1ZrdVJheHlJa1E0TGJhRWR4NCs5OS82d3dZWWZ3N2tr?=
 =?utf-8?B?eUtha2M5Rkh6QXg1MXJoak1sTzRIQ1FScEpJd0MyblhERkxWc0RLblVzN0Zz?=
 =?utf-8?B?ZE13SjZIK1gxYTRuaXJxcVNBV2VxZ0lEV2U4R2N5cTFsaWRocG0yeWFVYlg3?=
 =?utf-8?B?eUY3V2xNampoRWpnV1pNMWEvbWxaRFpKTFVOMUpzeXNyOVhnUVcvMFNEU2tJ?=
 =?utf-8?B?N092WXB6UDZwZHk3MVd3bXk3VUhlMHJKSWI5WFlvb09NYWNGbjltRDNwcjVv?=
 =?utf-8?B?eGdqVHorbW5VWEYxVmRxNWdvRUgvQk5Mc3p6NHdaUW5GNVA1VUxRZXphYkRK?=
 =?utf-8?B?MmtNeTFDdXZzNjhYclgyN2h0d05FYzJZMWUwNHh2S2hnOWZjVWdndkdHTXE0?=
 =?utf-8?B?MXI2T1FoWlovdW81eldMOHhvL2RFaGU0aTVjcTdwalluSUZNL0lSSGJkWFpz?=
 =?utf-8?B?ejhDaXk0Y09Uc2JzcHVpUndkYTltNEE0RmxuS0pQclNuRHlveFdsYU9RZTFq?=
 =?utf-8?B?eE5xL3ZxVnA5OUlVLzFxazJYbFpHZXRYTjdlT3EwNHYwTEJLM0FFVTRqeUw1?=
 =?utf-8?B?Q241ZnZIb2dtOVVOU05uUVhhaTk4elBLRGJhVXlYaWxySEZIU1liclNhNW1I?=
 =?utf-8?B?UU1Xdi95am8zUlpjMkVoaStZMTExaUU4ZUhVNjcyMTRGdGwxc2tDRy95Q1ZG?=
 =?utf-8?B?ck1TbmZEdjRCdUloY2d1dzhWL1owWVZWeXpuRCtSYW1ubWFMMzRjWGZ1NEtQ?=
 =?utf-8?B?bjB5WTR0UjVJU0VVUUY1aysvZmFkblJJNGxwMStLYkNUZS9ibllyK3BKcEt1?=
 =?utf-8?B?MjdSMnd6V1NnZ3QyVEhoZXhZK3V4MUNwZ1BjLzRLZ3ErSHI0M1N1V1RibDhz?=
 =?utf-8?B?ZWN2WmxrZjFZY0U5b09XWlpqSkduZzVqRVhqRnRWemwrZXlJNWp6UkxRakRJ?=
 =?utf-8?B?K3JKVmorOGxBdmZtYXg4Ujg0MEEyVEREUEY0VEVGWC8yWnEvL2dLWWNkR293?=
 =?utf-8?B?VUllOGNDUU5sck9QUEtXZDBtcG9CdnhMOWM2bjl0Q2tmWitlYUlUaXpxbVg4?=
 =?utf-8?B?MHg1by91eGJ2MTdJcCt2bXZEVXp5b0RsUVphZnQ1WTV3a0ZsaVdFM0tpeXNP?=
 =?utf-8?B?SmdJNE0rcTJCK2F3TncveWZ4SDNHeXZ4a3pLSjNKSWdVVG9GUkY2VmhkQ2Zu?=
 =?utf-8?B?TXBSY3hWZUh2Z2J1QlVyOEJFbjEyTmJLdDRZdE95TDNrSXB0bmNFMHR0dGkv?=
 =?utf-8?B?Zkt5OFpuSnpZcUxMUTZyNkZJazJJeWt5VTgyOXBldTlDMFB3dlhtTWcwWEc5?=
 =?utf-8?B?TDBrS0NGRzlVWHU2Yk0zQlBXT2lyNXRtWjlaS3p6elpsQ25scnFIQmV4SEJr?=
 =?utf-8?B?ZEFkQVlZRjRZTkhmSlMxeERFWVRSU21BeVdneGdwOFI1UllwQTFuVWV6NWJx?=
 =?utf-8?B?ZUtvTE16N1dEaHMrRmhjQk16cEZxODZ3cnF0YlNXNmU1TUxaaDAzelk2ZmZq?=
 =?utf-8?B?cWEzQ3hvNG9rUlg1NWl5K1ZyWVFoTWZBWkVvaGdhcEtBanJialorOEVXQjV2?=
 =?utf-8?Q?PDLU+kRcmjgtB5DAR0/YZ5l6CFa4ebP3KziAV6BfT5aJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0300413a-3fbf-404f-48c8-08db7eba33db
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:17:20.4892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Noe8C6SL5avGl/zogdZVocx9/MNIjWCIM+hr7kp7GDLe1sCYTpkIPM4pfdzfHiat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 06.07.23 um 14:36 schrieb Shashank Sharma:
> This patch adds code to cleanup any leftover userqueues which
> a user might have missed to destroy due to a crash or any other
> programming error.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 31 ++++++++++++++++---
>   1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 61064266c4f8..6e32e2854a58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -57,12 +57,23 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   	return index;
>   }
>   
> +static void
> +amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
> +			 struct amdgpu_usermode_queue *queue,
> +			 int queue_id)
> +{
> +	const struct amdgpu_userq_funcs *uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
> +
> +	uq_funcs->mqd_destroy(uq_mgr, queue);
> +	idr_remove(&uq_mgr->userq_idr, queue_id);
> +	kfree(queue);
> +}
> +
>   static int
>   amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   {
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> -	const struct amdgpu_userq_funcs *uq_funcs;
>   	struct amdgpu_usermode_queue *queue;
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
> @@ -73,11 +84,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   		mutex_unlock(&uq_mgr->userq_mutex);
>   		return -EINVAL;
>   	}
> -	uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
> -	uq_funcs->mqd_destroy(uq_mgr, queue);
> -	idr_remove(&uq_mgr->userq_idr, queue_id);
> -	kfree(queue);
>   
> +	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   	return 0;
>   }
> @@ -193,8 +201,21 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>   	return 0;
>   }
>   
> +static int amdgpu_userqueue_cleanup_residue(int queue_id, void *ptr, void *data)
> +{
> +	struct amdgpu_userq_mgr *uq_mgr = data;
> +	struct amdgpu_usermode_queue *queue = ptr;
> +
> +	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
> +	return 0;
> +}
> +
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>   {
> +	idr_for_each(&userq_mgr->userq_idr,
> +		     amdgpu_userqueue_cleanup_residue,
> +		     userq_mgr);
> +

Better use idr_for_each_entry() here which avoids the mid layer function.

Apart from that it would be nice to have to merge this patch into the 
original one adding the user queues, but really only nice to have.

Christian.

>   	idr_destroy(&userq_mgr->userq_idr);
>   	mutex_destroy(&userq_mgr->userq_mutex);
>   }

