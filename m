Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52902C54E5D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 18:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD21210FA85;
	Thu, 14 Mar 2024 18:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ME2coXtC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE2F10FA85
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 18:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0DCXhuICRNHD+Hj4g0jxFN2e1DwdxzByb3Us6pX/T5LnozSecVD+BWp8htsvvTVtWq0YcwQu3rzbb8QYWhCTTHmGq5YIX/XVVLnRn+DUBFActC7NGSAKI8w5KFaXt7Cy0FDTa8iFCU1hr8N+EHt1QQ8IFOHYKqix/tLdd0ZaU57Rm2Ix5FXFecKjgFyiuBqB9tw+fPtG407ZofC1ERepXk03EELgMHGsm8GuELC5927nTE4lpNMupjr2dGvpPZ0qJDWHI6fSMlmNIYvxFRGSNRnw0bNBf8RSjtDeIAJDZYl0f2JVx8ZtP2p+38hkvrr3zbtfzwaXTKRyDc2/ZJ1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oChDlPtDWVlDQjRE5CzBqLsDTVOrFLas+sU4dfEoDw=;
 b=bUwoxiRGdZy2DU+RSXz8Osri6ZVEcymTBvw8VvvibL2L4n+XqVS0YYrZlALenOX9bmLuGtbBZLo5ijdO0uqyOVRRfXhFNcrr2Tyv0X+42E6Bu2LuMniiBDRzUoWdE37o1DKeokmU4vyfhBmD0t/g4xduodL5v0Qs6JkoMbfQnNqoUIJj6YqYOiyjgQL8Sx+hJNY8P51+lZglafV/DQDl6jp/Pn2UyTUldQ9meNwGBrQxlmFpMXFCB+eejI8FxWaoT/bb4TxDv3w0gLRQTgUCzOzzT5p44N2t8QmVD8SiqfPG6IjHWW9sdAJcXzAd5kYwd/hZNBqaIURRtI/9MoRncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oChDlPtDWVlDQjRE5CzBqLsDTVOrFLas+sU4dfEoDw=;
 b=ME2coXtCzVE9PySMTMMVb0cMhQdwSvTKGu8SdR+3k1LGt9is5S3JsWZvxHeh44hFFf+UmpkpP2au4exAZ2caBabBYPwPv1q96BffTYSWbK1UiSSKEXMDE6iPUW1T4clDK0LWo3h1Rl3aUH1JH7eIUKT1an8XE8FDvKMmwJ4YiG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 18:38:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 18:38:46 +0000
Content-Type: multipart/alternative;
 boundary="------------UZWVbQHvjP7EPsyyWq6S9pdu"
Message-ID: <fb614992-7dfb-4339-a8d9-9faf5afb1c93@amd.com>
Date: Thu, 14 Mar 2024 14:38:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Check preemption status on all XCDs
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jay.Cornwall@amd.com
References: <20240314160029.623784-1-mukul.joshi@amd.com>
 <20240314160029.623784-2-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240314160029.623784-2-mukul.joshi@amd.com>
X-ClientProxiedBy: YQBPR0101CA0250.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: ef50ccbf-3a17-46f2-116b-08dc4455fb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGRzHqWZpQmSm4JHIyWY2qQ+ajr7rnz+81W9IzahiDYmSWkatAumGfO9wwbSR6OZXh55UZrHSjW7BL1ljhd6v6elvIW+UlVbsKNwynSj2f0GCj6FtAyZTGTHOu8MEqr9BMg9xR1Ot8lCh+pzPwsINIH74BU2ysGLD3m9ZhlrlvD+dRUNH6SvZjZe+WsLgB4hXDr2YjHltWxG8mkzUHs51V7EjQDdxrlKfocY5cV4wFcoFRMCWTDUs8YNo/Jj4imUY/O3o01kin8jZV6GH5zHTKQODSzp6BHUinOZOf5a5kc/pHiE06wudMtFkvARt0oE1bJgw3VPkwWL8aT6jiWj1BPmLLYyF3WlyRskfmOqjo7dtX5sV+DPnv5EALr9CSvDBhTFpfOIT0bzSfzUfO+gwboCmj9mQdsbnL0p6DTvnHVSC+1an988DE/S6+7YOxLO7cxW8yVBNlD0k12ICb/LNSlsmBGNWHYa5xjH8v3Dq/QqMl8AWfXCSAGxC5sQXPoSx0xIM5Mtlk815YboFNRWKnqXX5hiincTpsHMP09Qw/uKQFMS3qFbsRSa4HEmskW1wbm0vZG5iBdps3SEQrJtEmOGkt5Xr3LnBtvtJ9NFPNdVsDcpw6SgkqT8wPTcAjj6YHnFztJAQQf+6WPfIleQUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTkxQTZCNkg3N04yUjlZSVh1ODNQQVEwdnR5ZmR2NUIzUXkrYjZtSXc1QnVW?=
 =?utf-8?B?L1FvQVlkVXMrMkdkYXZXM2pzRERxeEEvemhrbDZ3TGRyZi9nblNZNXNNQW9E?=
 =?utf-8?B?RVJ6RUlmNHlCRDdCelcxN3IyQmlhaHlrNG9NeU95VGhGa3BHS1lFMUZtTmYr?=
 =?utf-8?B?WmtxNG1pRUZDeDBBOVcvR0REOEhKL0NFOFJFVHdmblU2Sml4eGxubmIxblNG?=
 =?utf-8?B?T2JYY2Q0ZjUzSU1zelNrZkFzYjR0aVVzVGVxU1dMTDZtNVlDTUFnMHNZREZT?=
 =?utf-8?B?S0FVenBOTjVwOGlKUVhBeUZWMlYvODN1dW5FSVptUjZVb0JuNjRjNlJoMFdV?=
 =?utf-8?B?ZnZMVjdZYzRkL3cySk9NRUJLK3gyc2xLM1N6aXMzK1R2M3hjZEhxZnl4RTNu?=
 =?utf-8?B?aDZNVFUwaDVBendPbEp5QkJFT0tXcTdhb1ZmY21BckxPR1dBMTNOd0NSSnBy?=
 =?utf-8?B?UzhhYnNkTVozMHZtdVVSSEpiMmcrNHN1QURnaVVxUzJkMFJ0MVdVRDVZTmFx?=
 =?utf-8?B?THFDOWQ0ck55SjdVc2NvSmdtdHZBU25WQVNmRFRVTVVOeVAzVWZCRmFEcVR2?=
 =?utf-8?B?U1RwdjRJUlcrVjRYSnA2eStyV3ZPbGI3b0pvbUVSdUxQUUNZUTl6U1NjZjB4?=
 =?utf-8?B?dThvSGdFNXNoNEpyUkZnRElqTm9uYWF5WWtYTU03bUhpRmtHWjBYMzhENCtZ?=
 =?utf-8?B?UTNhUk9ON2I2UzNyN3dNZjgyaDl4eVRhUDNWY2xVK1RUMHJhd2xuMEJiOWll?=
 =?utf-8?B?S1hmc2pJa2V2NUpLL1E4Ui8zWmo3cTRxQ1FPbXN6Z1NSUzd1ZGFOdURyTWh6?=
 =?utf-8?B?NzlST3dkakNSOXVHZE5sN3dVWWhaYytucUZoRFNxbnpPSmJXZ2YwRnh1YUhv?=
 =?utf-8?B?ZGxrWk5KaDVhTXNDREhyQWJlT0x2K2hpTjB0YjJBL1UxZzl4WmZTSjd3TTFB?=
 =?utf-8?B?SWdPaHQ2eWxGSjZZRXZkbGx0bHJGQ01vRzVOOGtjZTYrV3oxTzJtLzVOWXVF?=
 =?utf-8?B?WXgyMzl4cFBLaDJvS1FSazhTNXlNYXZEdllZUHhNSmhJRHBDc0o5Zzl3b1dJ?=
 =?utf-8?B?bi9WeTdCRWRXNkg3cituM2diU2Rlc1VtWVZ4L2dvY0V4czFGZlRaSmVVY0Y1?=
 =?utf-8?B?bGlud3hlb2VZeDlKVEhTcDJPYi9qZVlpK2NXZW9BM294cGpLendocnJpNjg1?=
 =?utf-8?B?THlWNEpUY2RGQmIwZVpiaktJRnEvU0VXMU5Da0JaTitvdHpSZ29hMHVVd2tX?=
 =?utf-8?B?R0diOUZCRW1oSmZaYlNxUmVXbHVVWitMZEdwZmF5emNCNVJ3NGlTMFZxRi8v?=
 =?utf-8?B?QmhwdGZ6b2JMYloydlA3TGdWbExNdVJzeGZNQnNJS3dqU2NGS2hiMG1VejRk?=
 =?utf-8?B?Y0NHa3ZKbTFadHJ0N3dJV1ZnVENlZkVkUisxNWx2RUFmUHg3b1JYbGtkWmM0?=
 =?utf-8?B?VzEvbXRSaEhXRGNrWTdiUjZ5ZldWbmlEZEVKZ3F0ZENCR1lISlNVTGdDRjh2?=
 =?utf-8?B?NXcrQmtXeEZYZ2dIemJoZDFZbjZyakdxVnlYQlQ3TnJ5NE1kRUFyWWhmWjhJ?=
 =?utf-8?B?enl0T29jRFhlbWJrSVMrSE92WVZRSkhId2xHbThzSFN1aTJnQzRydmk5aFdB?=
 =?utf-8?B?RXA3QW11OUlmekJUSDdkbDM5K2hHbjhyM1dkU0xkTDJiU0FiWmJUbkh0TUxG?=
 =?utf-8?B?bXZXOFl5dUI1ZVRLcnZoUmJuZk1yRTFRME1ESDF6WDMzekVhall2aEZJSXd3?=
 =?utf-8?B?eHg2Y3FJOGtWM2d6OWg0emVVTkxGMlpBZUJmS2I1OXU0ZWxwV1NKY3IzSTdO?=
 =?utf-8?B?N2ZRck1pRU9FeFJtQlgyM2NmRDlLWC85U1creTVxVnF6bHNVd3l6MmJpdTZr?=
 =?utf-8?B?ZTlvMzYyOVNXQnZCVUVpaEtEdUFFYithd3JZM2JQV0hsZ2R5U0J6N1FjdmtL?=
 =?utf-8?B?SU5ZN2N4YW82VzVwVG9JK0IvOSt0aXVDVk1rck5xc1c2T0hxYVNjM3l5Q1VE?=
 =?utf-8?B?cEcvUGRLa0cveHhXek5mdlpwWkFoYzhielh1NU84bUkyTTVIRkY5TzFUNjMy?=
 =?utf-8?B?anprTXRVa3VUcEh3WDBIejl1YVgwT3c0RFdxakFKN0x6ei8wd1FoS3hGNEx2?=
 =?utf-8?Q?e3fTOSHiZU3rF9g7cQb7kL8Pe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef50ccbf-3a17-46f2-116b-08dc4455fb90
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 18:38:46.4516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxMsAWpzpTkyDMdCDeo7vQiMsxpIU00Mi3AFdnLqLoNHCtq9OOLYQTX6kxArTzjLCHkDUZM0wChMf4C/BToOoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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

--------------UZWVbQHvjP7EPsyyWq6S9pdu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-14 12:00, Mukul Joshi wrote:
> This patch adds the following functionality:
> - Check the queue preemption status on all XCDs in a partition
>    for GFX 9.4.3.
> - Update the queue preemption debug message to print the queue
>    doorbell id for which preemption failed.
> - Change the signature of check preemption failed function to
>    return a bool instead of uint32_t and pass the MQD manager
>    as an argument.
>
> Suggested-by: Jay Cornwall<jay.cornwall@amd.com>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 18 +++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  4 ++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  4 +--
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  4 +--
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  4 +--
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 25 ++++++++++++++++---
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  4 +--
>   8 files changed, 52 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 1ce398ab0b3d..151fabf84040 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1997,8 +1997,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	 * check those fields
>   	 */
>   	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
> -	if (mqd_mgr->check_preemption_failed(dqm->packet_mgr.priv_queue->queue->mqd)) {
> -		dev_err(dev, "HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
> +	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
>   		while (halt_if_hws_hang)
>   			schedule();
>   		return -ETIME;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 050a6936ff84..cbec8c87c984 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -290,3 +290,21 @@ uint64_t kfd_mqd_stride(struct mqd_manager *mm,
>   {
>   	return mm->mqd_size;
>   }
> +
> +bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
> +				   uint32_t inst)
> +{
> +	if (doorbell_id) {
> +		struct device *dev = node->adev->dev;
> +
> +		if (KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3))

Could this be made more generic? E.g.:

	if (node->adev->xcp_mgr && node->adev->xcp_mgr->num_xcps > 0)

Other than that, the series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +			dev_err(dev, "XCC %d: Queue preemption failed for queue with doorbell_id: %x\n",
> +							inst, doorbell_id);
> +		else
> +			dev_err(dev, "Queue preemption failed for queue with doorbell_id: %x\n",
> +							doorbell_id);
> +		return true;
> +	}
> +
> +	return false;
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index ba3eebb2ca6d..17cc1f25c8d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -119,7 +119,7 @@ struct mqd_manager {
>   #if defined(CONFIG_DEBUG_FS)
>   	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
>   #endif
> -	uint32_t (*check_preemption_failed)(void *mqd);
> +	bool (*check_preemption_failed)(struct mqd_manager *mm, void *mqd);
>   	uint64_t (*mqd_stride)(struct mqd_manager *mm,
>   				struct queue_properties *p);
>   
> @@ -198,4 +198,6 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev,
>   uint64_t kfd_hiq_mqd_stride(struct kfd_node *dev);
>   uint64_t kfd_mqd_stride(struct mqd_manager *mm,
>   			struct queue_properties *q);
> +bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
> +				   uint32_t inst);
>   #endif /* KFD_MQD_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> index 8f9f56f7a8b0..05f3ac2eaef9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> @@ -206,11 +206,11 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -static uint32_t check_preemption_failed(void *mqd)
> +static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>   {
>   	struct cik_mqd *m = (struct cik_mqd *)mqd;
>   
> -	return m->queue_doorbell_id0;
> +	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
>   }
>   
>   static void update_mqd(struct mqd_manager *mm, void *mqd,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index d4cf7d845928..2eff37aaf827 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -224,11 +224,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -static uint32_t check_preemption_failed(void *mqd)
> +static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>   {
>   	struct v10_compute_mqd *m = (struct v10_compute_mqd *)mqd;
>   
> -	return m->queue_doorbell_id0;
> +	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
>   }
>   
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 2b9f57c267eb..68dbc0399c87 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -278,11 +278,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -static uint32_t check_preemption_failed(void *mqd)
> +static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>   {
>   	struct v11_compute_mqd *m = (struct v11_compute_mqd *)mqd;
>   
> -	return m->queue_doorbell_id0;
> +	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
>   }
>   
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 7c93a0932677..6bddc16808d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -316,11 +316,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   }
>   
>   
> -static uint32_t check_preemption_failed(void *mqd)
> +static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>   {
>   	struct v9_mqd *m = (struct v9_mqd *)mqd;
>   
> -	return m->queue_doorbell_id0;
> +	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
>   }
>   
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
> @@ -607,6 +607,24 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   	return err;
>   }
>   
> +static bool check_preemption_failed_v9_4_3(struct mqd_manager *mm, void *mqd)
> +{
> +	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
> +	uint32_t xcc_mask = mm->dev->xcc_mask;
> +	int inst = 0, xcc_id;
> +	struct v9_mqd *m;
> +	bool ret = false;
> +
> +	for_each_inst(xcc_id, xcc_mask) {
> +		m = get_mqd(mqd + hiq_mqd_size * inst);
> +		ret |= kfd_check_hiq_mqd_doorbell_id(mm->dev,
> +					m->queue_doorbell_id0, inst);
> +		++inst;
> +	}
> +
> +	return ret;
> +}
> +
>   static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
>   			       struct kfd_mem_obj *xcc_mqd_mem_obj,
>   			       uint64_t offset)
> @@ -881,15 +899,16 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   #if defined(CONFIG_DEBUG_FS)
>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
>   #endif
> -		mqd->check_preemption_failed = check_preemption_failed;
>   		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) {
>   			mqd->init_mqd = init_mqd_hiq_v9_4_3;
>   			mqd->load_mqd = hiq_load_mqd_kiq_v9_4_3;
>   			mqd->destroy_mqd = destroy_hiq_mqd_v9_4_3;
> +			mqd->check_preemption_failed = check_preemption_failed_v9_4_3;
>   		} else {
>   			mqd->init_mqd = init_mqd_hiq;
>   			mqd->load_mqd = kfd_hiq_load_mqd_kiq;
>   			mqd->destroy_mqd = destroy_hiq_mqd;
> +			mqd->check_preemption_failed = check_preemption_failed;
>   		}
>   		break;
>   	case KFD_MQD_TYPE_DIQ:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index dbc868e0363f..c1fafc502515 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -237,11 +237,11 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -static uint32_t check_preemption_failed(void *mqd)
> +static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>   {
>   	struct vi_mqd *m = (struct vi_mqd *)mqd;
>   
> -	return m->queue_doorbell_id0;
> +	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
>   }
>   
>   static void update_mqd(struct mqd_manager *mm, void *mqd,
--------------UZWVbQHvjP7EPsyyWq6S9pdu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2024-03-14 12:00, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240314160029.623784-2-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch adds the following functionality:
- Check the queue preemption status on all XCDs in a partition
  for GFX 9.4.3.
- Update the queue preemption debug message to print the queue
  doorbell id for which preemption failed.
- Change the signature of check preemption failed function to
  return a bool instead of uint32_t and pass the MQD manager
  as an argument.

Suggested-by: Jay Cornwall <a class="moz-txt-link-rfc2396E" href="mailto:jay.cornwall@amd.com">&lt;jay.cornwall@amd.com&gt;</a>
Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 18 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  4 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  4 +--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  4 +--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  4 +--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 25 ++++++++++++++++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  4 +--
 8 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1ce398ab0b3d..151fabf84040 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1997,8 +1997,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 * check those fields
 	 */
 	mqd_mgr = dqm-&gt;mqd_mgrs[KFD_MQD_TYPE_HIQ];
-	if (mqd_mgr-&gt;check_preemption_failed(dqm-&gt;packet_mgr.priv_queue-&gt;queue-&gt;mqd)) {
-		dev_err(dev, &quot;HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n&quot;);
+	if (mqd_mgr-&gt;check_preemption_failed(mqd_mgr, dqm-&gt;packet_mgr.priv_queue-&gt;queue-&gt;mqd)) {
 		while (halt_if_hws_hang)
 			schedule();
 		return -ETIME;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 050a6936ff84..cbec8c87c984 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -290,3 +290,21 @@ uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 {
 	return mm-&gt;mqd_size;
 }
+
+bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
+				   uint32_t inst)
+{
+	if (doorbell_id) {
+		struct device *dev = node-&gt;adev-&gt;dev;
+
+		if (KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3))</pre>
    </blockquote>
    <p>Could this be made more generic? E.g.:<br>
    </p>
    <pre>	if (node-&gt;adev-&gt;xcp_mgr &amp;&amp; node-&gt;adev-&gt;xcp_mgr-&gt;num_xcps &gt; 0)
</pre>
    <p>Other than that, the series is</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20240314160029.623784-2-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			dev_err(dev, &quot;XCC %d: Queue preemption failed for queue with doorbell_id: %x\n&quot;,
+							inst, doorbell_id);
+		else
+			dev_err(dev, &quot;Queue preemption failed for queue with doorbell_id: %x\n&quot;,
+							doorbell_id);
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index ba3eebb2ca6d..17cc1f25c8d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -119,7 +119,7 @@ struct mqd_manager {
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
 #endif
-	uint32_t (*check_preemption_failed)(void *mqd);
+	bool (*check_preemption_failed)(struct mqd_manager *mm, void *mqd);
 	uint64_t (*mqd_stride)(struct mqd_manager *mm,
 				struct queue_properties *p);
 
@@ -198,4 +198,6 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev,
 uint64_t kfd_hiq_mqd_stride(struct kfd_node *dev);
 uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 			struct queue_properties *q);
+bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbell_id,
+				   uint32_t inst);
 #endif /* KFD_MQD_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 8f9f56f7a8b0..05f3ac2eaef9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -206,11 +206,11 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	q-&gt;is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct cik_mqd *m = (struct cik_mqd *)mqd;
 
-	return m-&gt;queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm-&gt;dev, m-&gt;queue_doorbell_id0, 0);
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index d4cf7d845928..2eff37aaf827 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -224,11 +224,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	q-&gt;is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct v10_compute_mqd *m = (struct v10_compute_mqd *)mqd;
 
-	return m-&gt;queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm-&gt;dev, m-&gt;queue_doorbell_id0, 0);
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 2b9f57c267eb..68dbc0399c87 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -278,11 +278,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	q-&gt;is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct v11_compute_mqd *m = (struct v11_compute_mqd *)mqd;
 
-	return m-&gt;queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm-&gt;dev, m-&gt;queue_doorbell_id0, 0);
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7c93a0932677..6bddc16808d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -316,11 +316,11 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 }
 
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct v9_mqd *m = (struct v9_mqd *)mqd;
 
-	return m-&gt;queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm-&gt;dev, m-&gt;queue_doorbell_id0, 0);
 }
 
 static int get_wave_state(struct mqd_manager *mm, void *mqd,
@@ -607,6 +607,24 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	return err;
 }
 
+static bool check_preemption_failed_v9_4_3(struct mqd_manager *mm, void *mqd)
+{
+	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm-&gt;dev);
+	uint32_t xcc_mask = mm-&gt;dev-&gt;xcc_mask;
+	int inst = 0, xcc_id;
+	struct v9_mqd *m;
+	bool ret = false;
+
+	for_each_inst(xcc_id, xcc_mask) {
+		m = get_mqd(mqd + hiq_mqd_size * inst);
+		ret |= kfd_check_hiq_mqd_doorbell_id(mm-&gt;dev,
+					m-&gt;queue_doorbell_id0, inst);
+		++inst;
+	}
+
+	return ret;
+}
+
 static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
 			       struct kfd_mem_obj *xcc_mqd_mem_obj,
 			       uint64_t offset)
@@ -881,15 +899,16 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd-&gt;debugfs_show_mqd = debugfs_show_mqd;
 #endif
-		mqd-&gt;check_preemption_failed = check_preemption_failed;
 		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3)) {
 			mqd-&gt;init_mqd = init_mqd_hiq_v9_4_3;
 			mqd-&gt;load_mqd = hiq_load_mqd_kiq_v9_4_3;
 			mqd-&gt;destroy_mqd = destroy_hiq_mqd_v9_4_3;
+			mqd-&gt;check_preemption_failed = check_preemption_failed_v9_4_3;
 		} else {
 			mqd-&gt;init_mqd = init_mqd_hiq;
 			mqd-&gt;load_mqd = kfd_hiq_load_mqd_kiq;
 			mqd-&gt;destroy_mqd = destroy_hiq_mqd;
+			mqd-&gt;check_preemption_failed = check_preemption_failed;
 		}
 		break;
 	case KFD_MQD_TYPE_DIQ:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index dbc868e0363f..c1fafc502515 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -237,11 +237,11 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 	q-&gt;is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-static uint32_t check_preemption_failed(void *mqd)
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
 {
 	struct vi_mqd *m = (struct vi_mqd *)mqd;
 
-	return m-&gt;queue_doorbell_id0;
+	return kfd_check_hiq_mqd_doorbell_id(mm-&gt;dev, m-&gt;queue_doorbell_id0, 0);
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
</pre>
    </blockquote>
  </body>
</html>

--------------UZWVbQHvjP7EPsyyWq6S9pdu--
