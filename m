Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED8ED374AE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB46A10E865;
	Thu, 17 Oct 2024 16:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HQOHKO5J";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E36310E865
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bENq7P4qRRLfVwAQ8ocMDtie4uFWufn6IfSGvJI1yp+E38prKyOVi3FOP6mt9j2AT7V0R5qVdHTR2ASia0PJawCRGVpf6ZczOKF7V5mfihi0a1K94A2n0maOQqbCBqRLJcTUzL5giAcMiqnb2P8mLH4+zEGDZCEDQIaRrl1WDhGoctWmjdNaey1dRq+ijZEaYPAab8Dm6u0RKpW68we2yuIDMMYf4aeAVCtO9h0Iw0WQwuHaTlM56zBwl73zGfgYHZTrnCdloVDAtv8QH2cXQ8OjAjLUVPSHp3BtxKhftJFRt9RR5yiqCPAkxmUDltagupXwLMbuCmh5ySLt5kICqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guZ6mGinpQTZFgwX+gLocxOFLglh2tjIcYGPExcNW1w=;
 b=BhtcfkxYji1/3VNljHi652RlLpsyTpvcbFmQmkwOWYdKkbIaN3vjTa7Uj88IMc3ngeRqo2leHx3MJveOEgyEvtchEQ4qunOQagsk1X+8oE0HR3fE+BMmgTMHFtD44lkhUCCfqkei0lsLXC1oFBgDpiIiKIIwqoYWBkwKdRfxqOP8L2keC2/jUBlsxxgzGTgsWLTKbcVt9PXgKxdFwV2DbnY8RuXtAXQ2eeAEiOD/3IR2x7vxJBXx9AaNtGakKVxrYg7IrKI7N0fD6D80i4deqXZ6aUW7UG2akYhjTmgIV4W35E9IXndVLfe/a9kArrzDL9K4bo33wqvaMi/4vLc+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guZ6mGinpQTZFgwX+gLocxOFLglh2tjIcYGPExcNW1w=;
 b=HQOHKO5JRaF9LVt8Am4i38L/VB+rv3dSa5/AY6ElIAZnKsKb86+SL5Zn+mmfzkeuunlmGuaDLkIHlHUQnJYN7iuKcXYukCTRzKNivIPveQuE6XIErcAnQVzLUFVWRDHC7UJtzE7iiJgzNGlQWf3TgG85mqLVI5mVCWFWmUM0zBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:03:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 16:03:35 +0000
Message-ID: <6cea0d97-3e39-4a16-8b4b-798d439b7bca@amd.com>
Date: Thu, 17 Oct 2024 12:03:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdkfd: add/remove kfd queues through on
 stop/start KFD scheduling
To: amd-gfx@lists.freedesktop.org, Shaoyun Liu <Shaoyun.Liu@amd.com>
References: <20241017014449.643036-1-shaoyun.liu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241017014449.643036-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: a1313ada-d0c9-4aae-27dd-08dceec54158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak1iS3dqQlprMFBCWjkvdzY1WmExUmxUU3ZNWS9OM2w0NkdzMG5lQjllVnM2?=
 =?utf-8?B?eXE5S0xJUXdhL05TN0krcm5XdGNxKzhFVFo1YnZrZ1lDRUdEVWJOMW1FR0ZX?=
 =?utf-8?B?QS8ySWlTZEpkME1ZNml6OXpLZVRnUE1UaGh6WVBjYjdWcStNYm54MHlkTS9C?=
 =?utf-8?B?MHpnVDJuUG83L3hKWFE4M1JOb0pKcFFKR0hlYTRHZnE0eU1qQTlvSXB5bnNq?=
 =?utf-8?B?L2pTNTFDbmlqTmlnWEdyN05hWWhydUJXdy8wTGVLTnNMUmpOeW5VM1R0KzBq?=
 =?utf-8?B?OVBZU2ljYzF2emtuNU9qR1pBSklWWWdUbkNFVzRhZmo1c0ZWYS9peXJGSllN?=
 =?utf-8?B?UVU1WCtqUDRobUpKRWttOEwzTHhMVFpsNjFBZHd4VS9sOHhHZkZvbWU1aU1L?=
 =?utf-8?B?VGp4ME5tTmpsQXpiUzBMNGg0cUZ5TGhndzBYY3VuS0NYWmxpR0hScWJ2d1d5?=
 =?utf-8?B?NVRCYjJYQXJwUFl0MjFnVHQ3WVJBdmpVbmpwTDhRNWoxcDgrMGdvQmxsUnRh?=
 =?utf-8?B?WVU5dnBTWW9wR0RvM3lNT3RZTlRteStvS3RMY0YvNXVlSUJOVzVEZnFocGxQ?=
 =?utf-8?B?TnMxalNFRGpLSGFZWjA5MloxbHBYZzQwc3UxZGlvVHNla1BER3dRMVVweCtU?=
 =?utf-8?B?cUF1dVl1d1JPbVNlTWdsdlJIeWJEUHE5S04zTm1sY3pIRWdBbVE5Vk91RXNX?=
 =?utf-8?B?S2twcnpCYm11N1Q3czBBa2hOOCtnRHRrZG45aVZhb3pnNXdGakVLNk9FYTk3?=
 =?utf-8?B?VGE1MjdwYjRmdElMOXVjVTRxdUplc0o1SUpvSFpjR0Y3YXVjWllrV2hNUUhF?=
 =?utf-8?B?YXhXQXpYUG53a0FHcnBNUThBSFZMQ0hjdlVVU0paSWZBNjFIQXFidktlMm9w?=
 =?utf-8?B?aDdmcFpBUWN0a2ZuZ2txMldVaEpueUFlOUFSVEh2MzJ1dHdaYVdhVUM2eW9i?=
 =?utf-8?B?aEVkeFcrV09yVVEwMXV3QWVRQlo3UFhPSGxqWlVzc2F2djliU2JNUy8wMkp5?=
 =?utf-8?B?NzltSHk0Q3g2SG5pMkFkNTlnWjZWU1laanJnNkk0Y0hIdEwyR1pPaHEyQkpC?=
 =?utf-8?B?SjkrL3E4cllVT3MvUVFEL1pNdDh1ZUphRmxraDRyeG4zQVhCc3lvL09lclds?=
 =?utf-8?B?WWpkL3FEd3pLMXdXQkdSeVYva2FINmk0VldxMmZmWVdlTERTN1Y5NVlmTExp?=
 =?utf-8?B?S1JBZGVGTGMzaGg4emszdjJXRy8zekRpZm9kMTVRL09ZZll4ZTRrVnlhMnRk?=
 =?utf-8?B?S1RBY3l4Wi93Tmp2ZmhlTzE5STZURjArWEx5MWxsdEw1UkNmMGNxMDg0cVZy?=
 =?utf-8?B?eS9GOHZ4dnNRblpoVnp2cndnL2F6Ynh6ZVkvUnVEaTFLNkZHK3IrWjRDdXlp?=
 =?utf-8?B?R0tTRWRFUUpiT0w1KytrUERwVmx0UVhPRUUwVlBMaktPK3VqVWRhcDRCY0Ft?=
 =?utf-8?B?d3Vkc0E2dzZNUTB6cnYxWDNJR2daeFJJRk9sUytGTUZGYWdBb3hBR0pnSWlG?=
 =?utf-8?B?Mng2aEd2M2d1R3UycGtJaG5JTGxXUXB5Si9qekN0VHhaclE2S1dmWmlCMlds?=
 =?utf-8?B?UHY5UmcrRTRsZEkyWlF0ZU1JSTN3Vlk3eWtHOTJlSzBUUmJ0QmRvaExORlM2?=
 =?utf-8?B?RWVhSEc0SVhyU1MvRW5TcXBQTkNweDFwZmFpVXZ3OFpyekZFVFVMdkVwcFNU?=
 =?utf-8?B?M0ZUSWVzZ2tnUGNiZGdEWGFIellBKzJkbDk5a2J4L280Zi9MUUR1V0tsOEFu?=
 =?utf-8?Q?60iIIQJnzfzAkANpIKtfcc/HgubozBgaXhYB3e4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRUZUs1Wko5NTh1YWxnYVVTYVhGc0RpcVh6eDE2QmRtSGpiVnZxbzc1ZWc2?=
 =?utf-8?B?RTlHTTNVVVVueENZaVg2S0hBV2pVelY1WjBlRGQvZ2prRm1xL0VMTEJ1VEtU?=
 =?utf-8?B?VlVPQU5oTHVxQnBqamZHdi9RdGlpZGtkWElRZWxjWmtCamdVVnpuQTkxZnlp?=
 =?utf-8?B?M1JRYkRtQVZWVkYrbUx3MHZUWDFXd2EwTGdzNW9KcXBTQjBSRFE0a2srQzdt?=
 =?utf-8?B?NmN0b0JKWkRzUmtKOW9nZDlXODRia1pMYk4wK1Yrb2x3VjdaSlZ2TVNZaEVt?=
 =?utf-8?B?RmNxL1FCOFpOcXlhRVRLdnN3eDNtRGNRTkZWS1QzYVJCdnhuZy9MZWtkaCtI?=
 =?utf-8?B?TmY0ZTFJOG9aaDFIdDQyMG9VTG9Id1NMUTRpMnkxL0l1aG9LNGV4bHpJOTFo?=
 =?utf-8?B?UFRXR1Bsd3pHeVNGaHNqeDVpek5SbjlNV3RsZWU4UGlPSEtGNTlVSGMrTXIv?=
 =?utf-8?B?TVo2RnZEaVV5VnRuM1ZSRUdGVlY1NlQxMTJWdGpsYXdMbEx2OGVHYlhENlB2?=
 =?utf-8?B?Nml1eDVkTklkNmhGUGZBZUZrNGNVRVlXcTBQQ1hha3pzOXF6eW9NUG8wN3R3?=
 =?utf-8?B?QkNSRmgwOXdSZ0pSZGFCL2lwOFBQektqYVM0UDhodU5qQzFQd0krK21zb3E1?=
 =?utf-8?B?TENGRW9oY1J2NXpnTHVPbHNEWHlKSzBUU1p4YnJTY0NUVzlCN1EyZGphWjlB?=
 =?utf-8?B?YlBpQThpd3dsd2JiU2lRV2k4ZVFhUXg4YVoxRVMwL2loakdEd2RlbitUMHpU?=
 =?utf-8?B?Vys0cGR0SWJoakMyQmJBd0kyOVJGTE5lZ0FLMFMvR096anhRTVdDZ3A1Sll4?=
 =?utf-8?B?andGSzJIU01WRTlZN2s2dlJJclR3bVNwYlptUmJ5UnhhZ2VIQmRpWi9zbThy?=
 =?utf-8?B?bVkvYXBxR0dOVWFQb0RPQ2JUUkNndUdJUFRLNXBwY3F3ZGE3QnZ5RXFxM1pE?=
 =?utf-8?B?V1RLR1dxcUNkQ09iZUtPcG05VzIyblErbkZUdHdBZWRIcXdZQ3NqSStMYnlM?=
 =?utf-8?B?QWZiUmN0b2FLZEJkN2k5TVU0TTdFZXNacnRSYjBPZ09Ka3pVSG92M1krdHhG?=
 =?utf-8?B?TDhHNG5PcnNFRzBuU1FlQ1BjYUJuWXlGTVl6MWFsNDNVblc2OGI2eDRNQnNM?=
 =?utf-8?B?clYvU0l6N2pqUDF3QVUwUUVTWVZhS1dyTkVsVWdJdENmN2hic3krNmJ2TWxW?=
 =?utf-8?B?TTQxaDFkWEtyUDJIN0FkcnphSmE4eEo0emhqWGlVWWU2UmNiOTgvMTk0U214?=
 =?utf-8?B?cW9OdFYvVk1UaklGSjVsVmlmN0VkS2ZSbnk2NFU0VlprNEd0Mk05dmdFRXB1?=
 =?utf-8?B?eEtsczQrK1kyMENmUVBLSnJaM1VlcGRjUFhZUXdQWTdFdmFUSGFUSmRVWHJi?=
 =?utf-8?B?bXFYaVI5TUhiS0plejdUVWVjMmF2THdpOE9xTkwxdkF1NTVQUFhPS2tZc1lP?=
 =?utf-8?B?QVZuUzJZSTNRZll1RVZ4Tjh6dE9vbUZtTHlrRnFHeFVzc2ZOL1czOVNhbmxI?=
 =?utf-8?B?bHlMVXZwVDlaWUE2TWNFVkcxMHV2aUg1bEducERselNzSnoxcmt0QzlreHMz?=
 =?utf-8?B?a0huWS9nNU9IbG1VNHdZaGwrVDNwQ25rSXBsSlhrL2lQOG9lSU9xaGEzd3h6?=
 =?utf-8?B?S2o5VXp5UXVyR2ZtNnp4QTBTTUVFQi80eUlkYnBUU0x1RXZFdEowZ3Q3VGg3?=
 =?utf-8?B?cVlWVURTeHdreis2TXU4ZUtxeVdHZkFCSTZneFdBUzl5UGE2Smh5WGdsYVNp?=
 =?utf-8?B?a0NDUktRWVRjbUJocDh1M01abnRzaGZMM0NMTkkvZmVpWFlEWWZQQklZem5v?=
 =?utf-8?B?MTE3UkZBVFRpUVNTdDdSVDd0YytJTjVzS2EzM1JhKzNySm9HWUI2V0g5Z1BK?=
 =?utf-8?B?THdyQTJoQkFZYUxpQllINzhMQ0ZrS3JSZFZXdGc5TWVCeWJER281d0d4Vk1U?=
 =?utf-8?B?WnF4Q3JrOWExM25hWGM4MUdETSt3UFFSU2tFVHpIdjV5MGdaTnFuejY4STVQ?=
 =?utf-8?B?YTNyOFh5M1llLzA1ZFNXRll1bWQyOW5FZ1ViNGpGemI1WEhRTlRTcTRtSncw?=
 =?utf-8?B?QWNRYUZnMkRiV2lpdmh1MjliVDFSNktZUGpycGxXbE9hMzJRZExQWmc0NGwv?=
 =?utf-8?Q?NsFtBSrVAvLyOBvr7tGKy91pP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1313ada-d0c9-4aae-27dd-08dceec54158
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:03:35.3748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/yLUztYTU/e4Sq9liCmsGd3G6IK2/pofLzYoFlqPUz3inzJs/o4fAUMlpFk/5WKc/oMuqpyQ85Ivn1bd3svig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
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


On 2024-10-16 21:44, shaoyunl wrote:
> Add back kfd queues in start scheduling that originally been
> removed on stop scheduling.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++--
>   1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b2b16a812e73..437ed0ae6e76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -204,6 +204,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   
>   	if (!down_read_trylock(&adev->reset_domain->sem))
>   		return -EIO;
> +	if (!dqm->sched_running || dqm->sched_halt)
> +		return 0;
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>   	queue_input.process_id = qpd->pqm->process->pasid;
> @@ -272,6 +274,8 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   
>   	if (!down_read_trylock(&adev->reset_domain->sem))
>   		return -EIO;
> +	if (!dqm->sched_running || dqm->sched_halt)
> +		return 0;
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>   	queue_input.doorbell_offset = q->properties.doorbell_off;
> @@ -292,7 +296,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	return r;
>   }
>   
> -static int remove_all_queues_mes(struct device_queue_manager *dqm)
> +static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct device_process_node *cur;
>   	struct device *dev = dqm->dev->adev->dev;
> @@ -319,6 +323,33 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
>   	return retval;
>   }
>   
> +static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
> +{
> +	struct device_process_node *cur;
> +	struct device *dev = dqm->dev->adev->dev;
> +	struct qcm_process_device *qpd;
> +	struct queue *q;
> +	int retval = 0;
> +
> +	list_for_each_entry(cur, &dqm->queues, list) {
> +		qpd = cur->qpd;
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			if (q->properties.is_active) {

You could reduce the level of indentation below by changing this 
condition to

	if (!q->properties.is_active)
		continue;

Other than that, the patch looks reasonable to me. I assume there is no 
other way to tell the MES to stop scheduling user mode queues.

Regards,
   Felix


> +				retval = add_queue_mes(dqm, q, qpd);
> +				if (retval) {
> +					dev_err(dev, "%s: Failed to add queue %d for dev %d",
> +						__func__,
> +						q->properties.queue_id,
> +						dqm->dev->id);
> +					return retval;
> +				}
> +			}
> +		}
> +	}
> +
> +	return retval;
> +}
> +
>   static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> @@ -1742,7 +1773,7 @@ static int halt_cpsch(struct device_queue_manager *dqm)
>   						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
>   				USE_DEFAULT_GRACE_PERIOD, false);
>   		else
> -			ret = remove_all_queues_mes(dqm);
> +			ret = remove_all_kfd_queues_mes(dqm);
>   	}
>   	dqm->sched_halt = true;
>   	dqm_unlock(dqm);
> @@ -1768,6 +1799,9 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
>   		ret = execute_queues_cpsch(dqm,
>   					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
>   			0, USE_DEFAULT_GRACE_PERIOD);
> +	else
> +		ret = add_all_kfd_queues_mes(dqm);
> +
>   	dqm_unlock(dqm);
>   
>   	return ret;
> @@ -1867,7 +1901,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
>   		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
>   	else
> -		remove_all_queues_mes(dqm);
> +		remove_all_kfd_queues_mes(dqm);
>   
>   	dqm->sched_running = false;
>   
