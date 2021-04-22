Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40433C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31196101B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31196101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E976E15A;
	Thu, 22 Apr 2021 13:15:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5A56E15A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 13:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdD9VHytt7y3zXTkv/4fYLxOzBN8jLmLT9zNnDs3MqEKIK17R49rZF7ZPmDFgY1eMf0OaNI7LigBrjspl5zDVcU80dIJf7lPFX3kjm406QnAvXA+CpaeQFKN2MIeNVgrqssAR2MFsqtskjWMlho5EonFYrjKvbDZHurBy3rIzfqGDPWdzETadGCQKxsU3XTiJUvEtHsde12gZ9TY43E9Bw0Q0LMz21mdoVfyt20m9iZrsLoCOExTTVZSXZHMvruyDsYFvakJT2yNfI+krHnMX2g/gIqYu84wHyPeEtK3IJxRMsCnSJwLNvMaPpogiQjoajXw94OTX5wPozHQVriNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3pR7HT5aXPmntaiPsImaOyEKBWdvotgw7VzjVoEZYE=;
 b=O2VXaKk5E9Ne5WEG5sXRPQPI2I3V1xGMK4iOlscISbxFOrT5Wwyknf58oivflV15uNsmZHCoAdZXtjEjy2D8TBtGvW47GPeQDWbdHNwrD6P0fHdK8+plxEP9GzV6ye8EMtPZY+tzNyLIWlK+iTaXPna3VEwQqKJViBhMHnBqTzhvUorhP9Ns4wtSRTXSaelBHfuUyxvVOSD3zgnaSOpZtEzaTARDgnwbJdZXU7e+RvEV9O07BzZdL/CE0DedvTmWRbRuLU7qrA23sy7Lp+IXXcD1MMFMqm7ycg0AUthEZt+jEtgkWAR7IjTt3d7e9WgXvFaRlyK8gihM0t5AyYOVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3pR7HT5aXPmntaiPsImaOyEKBWdvotgw7VzjVoEZYE=;
 b=1OUhOOshgpP6tytQL/5W4Xjkyc4Eb0o1BET4hvK5VW6NtwNCZPksPe1FCrW2zAa6F0UgqWOtyXAIn7BA482IC6naV3QJLp/KHvh8hr2IrRmMWs0e+yvJfP6lM9CgKFQGNB4/zUMlzGy7E6bgb0ts5O3MYngxIttxwUate46yfy4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 13:15:19 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 13:15:19 +0000
Subject: Re: [PATCH] drm/amdkfd: add per-vmid-debug map_process_support
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210422022415.48407-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <449af30a-4884-4942-7ee2-a854262c2657@amd.com>
Date: Thu, 22 Apr 2021 09:15:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210422022415.48407-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 13:15:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2528865-1219-4492-b961-08d90590ad18
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB412626851D23A2C953CDAD2392469@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FI54wPeLCF/6FOWpBBGIAb1tmx7JQ9qrkL2S/7wGKNwecLZQwG8YKZSFiacc5JPnMjYEpKOz78xKEQSeMxIV1xXikdJtNOZpBWkbB3J2hqn445EC70dN8Vyn9oHYWpMeV8xBPvPzNzAygZiwxaZ2JSF913r7s6YZnCAY/PlQ2QEw8tn8/v+XAkV2DWNgNKFAD7XN9P0xVRaZy+CEgSMF3wnUDe1lBX4Hu4Y/boNy6gsEfiqadDuS3+3MIe8uiBw9/UVyp4hmtlaM+eTakeS4+HKkVZ3xeS/zIcidozJQ80JPssqvXkGpFJHfGYJpYOO4tfbyCtanDe8slEUsZS9nCb+4LQAJsDSkhNN/vWlKkSh4X1ZEC/unDlgjrMFru6lYaXS0jSw9NoSMVShOde4uoG8gIEmBGykhucyVJJUMG6QR+FdPojs74bZE14d88QYyy6WUpgmkHcLQO0pTq7i8oz4iaemrtvUbkzz+dvX2i+8PFzG0HVDs+HMQiteR370vBWUVp/gx5asmam5jUFG8gqsT3SE1zPZbyoyS7tHwYmsTU/1poCMVxQI/fO/PMQS5inJ4JMHYANFatVQ6Q1gnBN4FXU04/hdD5WZQWbQnXmUX+jU5Eu0SyB29N6qXVG+ZbYC8ev+K8Soa7nHvj+tsT+rZPRW2dVOblJbqEdycAqhApvDwTKQLoW+zl0toVHtX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(396003)(376002)(366004)(136003)(186003)(16526019)(2906002)(8936002)(2616005)(66476007)(16576012)(30864003)(8676002)(956004)(66556008)(478600001)(316002)(38100700002)(5660300002)(44832011)(83380400001)(31686004)(26005)(31696002)(6486002)(86362001)(36756003)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ang3TFowR1BoSXQvNVl4cGs3QytTRDlBZ0tHZzRuS05ubU5pbUFCUmhmcnEx?=
 =?utf-8?B?L1Q1UTI5cDdlTGUvOUtDVXlMZVRlQllFY2hrUkNxb1U3VVk4WTVoUkJBdllt?=
 =?utf-8?B?UnhSRnc1ZEFOYVdGUTFwVXdnMTB2b0lJZmcrWGZBaWd0WlZqd0tEVXpCWXFH?=
 =?utf-8?B?cWhCT01iUTU0dEE4WFFrcTJIejVHWWd0MTFtbDdnK3krdUVDK1FZaUdLU05p?=
 =?utf-8?B?UFZSdzdQRWcxbjk0NDVxRHA1Tk43NDV0Z25ZeXZrUks0ZVJ4QVh0ei9NNzZB?=
 =?utf-8?B?d3BveklIUVhVZjJVemorSnBNUWNvc1JvNDI3WTc4VXRLNDRNakhocTg2dmNk?=
 =?utf-8?B?WEpFMVM2bXBuRHlTb0cyQnlGcWZoQjBBYjBkV1ZwN0lTelRRVkZDYWx5UlVS?=
 =?utf-8?B?YUhMYVdxelBQRGFRRC9IcGVMU1o3QWI5akpGV1pMU3hZWElvOXVoeXZWcTBz?=
 =?utf-8?B?SE5XWG4xTVdKa3kzMjlTd0NiUEJnSzZUTnhXeWkxYzRMaDdHUnpzT0xIc29k?=
 =?utf-8?B?M1ZFQlhVSWFJa3hSRVdSZElhaExWeUsvbUFpM0hnb284ZCsxZW1heVFObHl0?=
 =?utf-8?B?Q3BqYzRsN0tETG9QcmxDaXZBMHJMT3ZYR2V5TWZSdlJiL2djQS9seFdYenBZ?=
 =?utf-8?B?d3RoREpWNW9IZEt1Ykc4OS94VXZrOCtia2lITFpqbkhDTjNXaGNpK0RBTHda?=
 =?utf-8?B?NXJjN3hjdE91Z3F5YU9XVG1MN2RhUkRFejVKMG1ucG13Yk54Yy9zVUsvbTIx?=
 =?utf-8?B?SkRkS1k3VFZYc3p4U2xXMnFiNEJHbjB1UVk3Q2RyaXBkcFpoVEhQM1hzNnZQ?=
 =?utf-8?B?YmdtNUhxL0JNUnAwYlNVZnIySnlGR3RaWU5GQzJNcHk1WXFJMXRtZHo1VlJl?=
 =?utf-8?B?MlplbGtPNmZESEJtU1loenExVWFjZ0Z3VGRVd2VQUHlaTkluSkhuWHM5ZjJp?=
 =?utf-8?B?NkpBMEE1L2RCMUkwMURwL0hPKzZOcEVWaHU0SEV4bnh6YmdUOExxT1BaMisz?=
 =?utf-8?B?YWZjQ0pFdTM5M3BnK1BCR0ZaaFBVcVBNbG5zUTFka2NDaktnaEpIa2VhMlRS?=
 =?utf-8?B?LzNFeVZUTitaOUxPR05VQTk2czNWR3R5dmoyNzhvMDYvajBCd3ZBQVhnMnVP?=
 =?utf-8?B?VU9FaldKTHc4bFpqN0V1cW1XYWhDZFV5NkJyTDkvbWsrYVRZakhONUthRzNH?=
 =?utf-8?B?UFB1ZUNIS3NLbnMvMDU0ZzMrZVVFcHdBNDR6YUtpOVRTYmtrQm9rUjhYUU16?=
 =?utf-8?B?NC9ZZnpaS1NpWTNuWnU1aGsxMHZXQUVDZGF6dHNjaEZZSDlmbDhzSVF2V0NZ?=
 =?utf-8?B?aUFFQnBRa2d1eVQwbVlJS09xbDV4NjRVaFZXQzFkR1F1TjZ3cFJxMnNnOGwv?=
 =?utf-8?B?WXM3dEVSY1Z6OHlpOWYrRkhaTlVsMjg3MDNkaU5aRjNrUXdyV3ZlbWtHdGNF?=
 =?utf-8?B?UTdMN1U2cUJsSE9DNFMzcjZ0cHBraUZjMHI1SVJmM0xtaml0amZ5cGZpT0RH?=
 =?utf-8?B?UWdlRXpZYWZFWHRFNGtJb3FMbVlPMWw0Zi94UW1mOVVSZlh5ZUY0TXVJTVds?=
 =?utf-8?B?ZDl1M0phL1Q5S1FQSEptNmllRkhaRytyZERGelFxcGF2Ym5lMTk2NmZ3UE9a?=
 =?utf-8?B?UW9HTUlBeWJMUEVLUzZ6TjBpYkt1MysyUFVFaWljSGRIY0FLeWxad2FKaGJs?=
 =?utf-8?B?cmNjYkF1amhOTFprWklXd0NVRVdVd0FLOHB3YXU1NVFyQjBuaEZveU04Mk5Y?=
 =?utf-8?Q?rUrzVicK1ycfLcOtWhSlq36TTsMDomFiY0B0ZKf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2528865-1219-4492-b961-08d90590ad18
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 13:15:18.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFElVc0hGAVjpdLkqQHJJz6sQgWqoa47g0SJbUoVkvHrzXBj/B5qk+2mWB/8p+YrfRShaUoISGCi6LrAN6Ljsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-04-21 um 10:24 p.m. schrieb Jonathan Kim:
> In order to support multi-process debugging, HWS PM4 packet
> MAP_PROCESS requires an extension of 5 DWORDS to support targeting of
> per-vmid SPI debug control registers as well as watch points per process.
>
> v2: align upstream with internal new MEC FW
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  9 +-
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 58 +++++++++++-
>  .../amd/amdkfd/kfd_pm4_headers_aldebaran.h    | 93 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  5 files changed, 161 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b31bae91fbd0..348fd3e49017 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -26,6 +26,7 @@
>  #include "kfd_priv.h"
>  #include "kfd_device_queue_manager.h"
>  #include "kfd_pm4_headers_vi.h"
> +#include "kfd_pm4_headers_aldebaran.h"
>  #include "cwsr_trap_handler.h"
>  #include "kfd_iommu.h"
>  #include "amdgpu_amdkfd.h"
> @@ -714,7 +715,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  			 struct drm_device *ddev,
>  			 const struct kgd2kfd_shared_resources *gpu_resources)
>  {
> -	unsigned int size;
> +	unsigned int size, map_process_packet_size;
>  
>  	kfd->ddev = ddev;
>  	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
> @@ -749,7 +750,11 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  	 * calculate max size of runlist packet.
>  	 * There can be only 2 packets at once
>  	 */
> -	size += (KFD_MAX_NUM_OF_PROCESSES * sizeof(struct pm4_mes_map_process) +
> +	map_process_packet_size =
> +			kfd->device_info->asic_family == CHIP_ALDEBARAN ?
> +				sizeof(struct pm4_mes_map_process_aldebaran) :
> +					sizeof(struct pm4_mes_map_process);
> +	size += (KFD_MAX_NUM_OF_PROCESSES * map_process_packet_size +
>  		max_num_of_queues_per_device * sizeof(struct pm4_mes_map_queues)
>  		+ sizeof(struct pm4_mes_runlist)) * 2;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index e840dd581719..0ce507d7208a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -242,7 +242,6 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
>  	case CHIP_RAVEN:
>  	case CHIP_RENOIR:
>  	case CHIP_ARCTURUS:
> -	case CHIP_ALDEBARAN:
>  	case CHIP_NAVI10:
>  	case CHIP_NAVI12:
>  	case CHIP_NAVI14:
> @@ -252,6 +251,9 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
>  	case CHIP_DIMGREY_CAVEFISH:
>  		pm->pmf = &kfd_v9_pm_funcs;
>  		break;
> +	case CHIP_ALDEBARAN:
> +		pm->pmf = &kfd_aldebaran_pm_funcs;
> +		break;
>  	default:
>  		WARN(1, "Unexpected ASIC family %u",
>  		     dqm->dev->device_info->asic_family);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index e3ba0cd3b6fa..7ea3f671b325 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -24,6 +24,7 @@
>  #include "kfd_kernel_queue.h"
>  #include "kfd_device_queue_manager.h"
>  #include "kfd_pm4_headers_ai.h"
> +#include "kfd_pm4_headers_aldebaran.h"
>  #include "kfd_pm4_opcodes.h"
>  #include "gc/gc_10_1_0_sh_mask.h"
>  
> @@ -35,7 +36,6 @@ static int pm_map_process_v9(struct packet_manager *pm,
>  
>  	packet = (struct pm4_mes_map_process *)buffer;
>  	memset(buffer, 0, sizeof(struct pm4_mes_map_process));
> -
>  	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
>  					sizeof(struct pm4_mes_map_process));
>  	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
> @@ -73,6 +73,45 @@ static int pm_map_process_v9(struct packet_manager *pm,
>  	return 0;
>  }
>  
> +static int pm_map_process_aldebaran(struct packet_manager *pm,
> +		uint32_t *buffer, struct qcm_process_device *qpd)
> +{
> +	struct pm4_mes_map_process_aldebaran *packet;
> +	uint64_t vm_page_table_base_addr = qpd->page_table_base;
> +
> +	packet = (struct pm4_mes_map_process_aldebaran *)buffer;
> +	memset(buffer, 0, sizeof(struct pm4_mes_map_process_aldebaran));
> +	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
> +			sizeof(struct pm4_mes_map_process_aldebaran));
> +	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
> +	packet->bitfields2.process_quantum = 10;
> +	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
> +	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
> +	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
> +	packet->bitfields14.num_oac = qpd->num_oac;
> +	packet->bitfields14.sdma_enable = 1;
> +	packet->bitfields14.num_queues = (qpd->is_debug) ? 0 : qpd->queue_count;
> +
> +	packet->sh_mem_config = qpd->sh_mem_config;
> +	packet->sh_mem_bases = qpd->sh_mem_bases;
> +	if (qpd->tba_addr) {
> +		packet->sq_shader_tba_lo = lower_32_bits(qpd->tba_addr >> 8);
> +		packet->sq_shader_tma_lo = lower_32_bits(qpd->tma_addr >> 8);
> +		packet->sq_shader_tma_hi = upper_32_bits(qpd->tma_addr >> 8);
> +	}
> +
> +	packet->gds_addr_lo = lower_32_bits(qpd->gds_context_area);
> +	packet->gds_addr_hi = upper_32_bits(qpd->gds_context_area);
> +
> +	packet->vm_context_page_table_base_addr_lo32 =
> +			lower_32_bits(vm_page_table_base_addr);
> +	packet->vm_context_page_table_base_addr_hi32 =
> +			upper_32_bits(vm_page_table_base_addr);
> +
> +	return 0;
> +}
> +
>  static int pm_runlist_v9(struct packet_manager *pm, uint32_t *buffer,
>  			uint64_t ib, size_t ib_size_in_dwords, bool chain)
>  {
> @@ -324,3 +363,20 @@ const struct packet_manager_funcs kfd_v9_pm_funcs = {
>  	.query_status_size	= sizeof(struct pm4_mes_query_status),
>  	.release_mem_size	= 0,
>  };
> +
> +const struct packet_manager_funcs kfd_aldebaran_pm_funcs = {
> +	.map_process		= pm_map_process_aldebaran,
> +	.runlist		= pm_runlist_v9,
> +	.set_resources		= pm_set_resources_v9,
> +	.map_queues		= pm_map_queues_v9,
> +	.unmap_queues		= pm_unmap_queues_v9,
> +	.query_status		= pm_query_status_v9,
> +	.release_mem		= NULL,
> +	.map_process_size	= sizeof(struct pm4_mes_map_process_aldebaran),
> +	.runlist_size		= sizeof(struct pm4_mes_runlist),
> +	.set_resources_size	= sizeof(struct pm4_mes_set_resources),
> +	.map_queues_size	= sizeof(struct pm4_mes_map_queues),
> +	.unmap_queues_size	= sizeof(struct pm4_mes_unmap_queues),
> +	.query_status_size	= sizeof(struct pm4_mes_query_status),
> +	.release_mem_size	= 0,
> +};
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
> new file mode 100644
> index 000000000000..f795ec815e2a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
> @@ -0,0 +1,93 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*--------------------MES_MAP_PROCESS (PER DEBUG VMID)--------------------*/
> +
> +#ifndef PM4_MES_MAP_PROCESS_PER_DEBUG_VMID_DEFINED
> +#define PM4_MES_MAP_PROCESS_PER_DEBUG_VMID_DEFINED
> +
> +struct pm4_mes_map_process_aldebaran {
> +	union {
> +		union PM4_MES_TYPE_3_HEADER header;	/* header */
> +		uint32_t ordinal1;
> +	};
> +
> +	union {
> +		struct {
> +			uint32_t pasid:16;	    /* 0 - 15  */
> +			uint32_t single_memops:1;   /* 16      */
> +			uint32_t reserved1:1;	    /* 17      */
> +			uint32_t debug_vmid:4;	    /* 18 - 21 */
> +			uint32_t new_debug:1;	    /* 22      */
> +			uint32_t tmz:1;		    /* 23      */
> +			uint32_t diq_enable:1;      /* 24      */
> +			uint32_t process_quantum:7; /* 25 - 31 */
> +		} bitfields2;
> +		uint32_t ordinal2;
> +	};
> +
> +	uint32_t vm_context_page_table_base_addr_lo32;
> +
> +	uint32_t vm_context_page_table_base_addr_hi32;
> +
> +	uint32_t sh_mem_bases;
> +
> +	uint32_t sh_mem_config;
> +
> +	uint32_t sq_shader_tba_lo;
> +
> +	uint32_t sq_shader_tba_hi;
> +
> +	uint32_t sq_shader_tma_lo;
> +
> +	uint32_t sq_shader_tma_hi;
> +
> +	uint32_t reserved6;
> +
> +	uint32_t gds_addr_lo;
> +
> +	uint32_t gds_addr_hi;
> +
> +	union {
> +		struct {
> +			uint32_t num_gws:7;
> +			uint32_t sdma_enable:1;
> +			uint32_t num_oac:4;
> +			uint32_t gds_size_hi:4;
> +			uint32_t gds_size:6;
> +			uint32_t num_queues:10;
> +		} bitfields14;
> +		uint32_t ordinal14;
> +	};
> +
> +	uint32_t spi_gdbg_per_vmid_cntl;
> +
> +	uint32_t tcp_watch_cntl[4];
> +
> +	uint32_t completion_signal_lo;
> +
> +	uint32_t completion_signal_hi;
> +
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a1ddcf6446db..64552f6b8ba4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1088,6 +1088,7 @@ struct packet_manager_funcs {
>  
>  extern const struct packet_manager_funcs kfd_vi_pm_funcs;
>  extern const struct packet_manager_funcs kfd_v9_pm_funcs;
> +extern const struct packet_manager_funcs kfd_aldebaran_pm_funcs;
>  
>  int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm);
>  void pm_uninit(struct packet_manager *pm, bool hanging);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
