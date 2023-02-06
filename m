Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBC4C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 20:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E47310EA4C;
	Mon,  6 Feb 2023 20:42:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E1510E439
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 20:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx8SlY9ew/yEQvtjm+/GxuMsZCbAL/B3jvzcCQ96HN9HtxIAawakFa/hIAJDEFo1+zHYmPps2oFWW3nN8jSv665MIBpLMwOzWcWae9tV4Ku+7eheZwbasSHBAtoR4OtQJKkDDCZwk+PFSKsI0lV2q9OSj18+Hoqc9CFt7N96e9UeBwo8J3GMcLXtxubzN2emhs1D+g6+qcwJYFaONpAJDlJxetJSmDt8Jfjz+LXtjy5+fPlAib5Xf+PpKA8W7fK8kukIHBdBPk3wKY0WYGrhaUsC1ozQAVyqCkeFdLanqfxBvuEu+4tD3f1OOq94HfT57yCbAUZTQSbSIn65W6VhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn2arOlp+KN1WBAERPNbR+bc3s5uIslteHE28QSZfpc=;
 b=mlT8Z+g8hD45F7Q6QS9srOfMd2QlxF/QLIynv86aNjyZLK2AqWEOOl3fXh8jkSGiL530452zhvj1J8SVhKafaXo4301ncosEVJk7gc3ktzK5GslBJsnsTPZNahS58OTwqfK7pX+F0Gu/+MLfEs03yn83W7Bf2WkmOqsLxT9eJijunU1JVOfSyOLsOqho9ABeP1IOYGwZ5wBjIBODxyzC1KwfsopC4EvIgcOOcm8LQbuisSPbZxgBPb7VfpKPKVURvI/JV+BglxhJY6KQsu7hgSc5RFw++CCkQ6vPMGGIcFOlVYtlQc8EOOgUN7NMaJ/6AYl6r5dRNhc/9XRcbP1ETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn2arOlp+KN1WBAERPNbR+bc3s5uIslteHE28QSZfpc=;
 b=OQglD+Ip4OVRWP6wp22XVaWA89Ejwplz9bCxjGVvu7Io5DV7VDJbFvK/ckiSDMadK0iU4Uh/UHgOZq63KHY9K4eElhcJWT+zFtSy/KI+lZEEvUWVUREoV4pkinXNiYEpI8KzHTY7C8vRQHhI7ZcnfhTztTv1pmlJBMQm79xmyrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 20:42:35 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 20:42:34 +0000
Message-ID: <112b2c43-b3e7-1abb-e000-075f693bf011@amd.com>
Date: Mon, 6 Feb 2023 15:42:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: To fix sdma page fault issue for GC 11.x
Content-Language: en-US
To: "Ji, Ruili" <ruili.ji@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230206125812.1554992-1-ruili.ji@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230206125812.1554992-1-ruili.ji@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: dd80a0f7-db5e-4a0e-5f5c-08db0882aca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbfKWrPnjMckzzIaE9Y+pjLSujFjNTPl6Hi3HVlyces+FAXUa8mBVIeHrfnBwIknJLKXCWcqVQKqyU6xZ065HqXtrX22dTssWxU8kHIsItPc7bRtnfJRXqYgsp0Sf2zKtJrnKz6K6aKho88JD+xQXW4deGLLwrDTTFZRC4krhKVKfu0voekLLWgsiyd52TkaWif2n7iMlq7ZHc+DoFWDBpz87fzftR/pSUcyYR/n4uI+jN9YnH1Y3dyCM0j3BydaYqmFu+jKl399OOHIaFAMkgN+1hyLQ9OY6wtd22SOSR9L9DtaZ7w4nNuIO+LCnKeHD+Q9GIRjbiVTFO2l6d9Cr+LwV6dO/gBled34k/5gLuzvji1mQLPx/jPY7Zee5Bi/1ay/622pkF3PopcXB6/I5mPISgBbZZU9vLAGwqGt+PvnFU3sYl+A74e0nfethNdrNI68AostIq7uh1XNKEuqW28uF6+a1OjKf4FJ0HH+c0G37HseGZnNvmmWOS7X7b39x6plD9WffsA7PUWWnBZmm5ZmJmBeg/6SlPx4e35WOPMe35yZZTMa1J0MedzVe9xQ3f9QqIvr0ungRgTamePp0Ig01QMNHroGiUvKttEzMciec81LDFP/f4UJnfw8C3khZLi+cAOzUVZfyr/pnEajiefZfMXPAK9jC6qtPsgRdN5ZS621cmB0++UExlZzKf2qj9qWj8s+gVkT5gI/gKy9M+kQpN3xe0cthTOX6MZ2mzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(31686004)(36916002)(41300700001)(36756003)(83380400001)(6512007)(31696002)(38100700002)(86362001)(26005)(2616005)(186003)(53546011)(8676002)(6506007)(478600001)(6486002)(316002)(66946007)(8936002)(4326008)(5660300002)(2906002)(66556008)(66476007)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azN4YkJkbW1YOHJ6RitVVU1OZGJDTm13cjJwRXFXK3IwUjkvQ2Foenc3SkpI?=
 =?utf-8?B?RUFUUVZ6LytrM1NGd0srUWwrdUJmdm1nMTNoQXg2SktiVmpoeUk3bXZ6dWJh?=
 =?utf-8?B?Wi9NY0lQUXV3MDJqM28vYklvNFIwQWVNSGlBUUlZaVA1aHlvQUdmRGlVdDFE?=
 =?utf-8?B?S2FKMW1EOXgzRFh5S1VTYXlUKzFncXNhWGN4blJ1RUYzdEVlZmVXR3JTaHdU?=
 =?utf-8?B?UGp4V3pQWWZqMDZRa3pwNERKQk5VMG80RWFNYVp4dHRQWkx5b1AvZ1NQNzk1?=
 =?utf-8?B?UGVGNE1xdjdEMWpzY0JkZzZCWDJHT0xERlV4SXNtMmdxTzJtblBTSXZkV3lQ?=
 =?utf-8?B?L0pDb0FKUzJpcmlESER4ZWJjSk9TUGlqUFhLMHQydzFDM2p0RXdGWTk2dVYy?=
 =?utf-8?B?OC9DUUtwRlhqa0ZTRmdsUmlYNlpuRHExYXBwWDJHSytueWtXTzMxQ3RreTQw?=
 =?utf-8?B?NWYyVFVPNnlBa2o5dDlJTVlaaEwvTHBhTW14UjRZZ0tha0tTblJsQkhMelZD?=
 =?utf-8?B?ZGR4MmV0cXJCR1BLL2M0STl0T25rWi9WdDE1RWlRYnA1c2JRSUpqQ05ITHRO?=
 =?utf-8?B?cHBDQlNNZ2ZnRTR2Y0ExNnlTbVk5NUlpc1Vjb1hwNHc4TjF4VEZwQTkrVnZx?=
 =?utf-8?B?ajFWVkgrZy9aZENDaEM4c1E2S2U3MTBLdCtPYkE3SGhxZE55Ym1xOW11aGFq?=
 =?utf-8?B?SG5FUEU5QzNYOURMbGYvNzdyM3czV09UMnREV0llUGh4d2RGZDlQVGp3UTBl?=
 =?utf-8?B?REN1QWFrZWw2OU5oaVFKRDFyMG84dUNmOWRyVlJodndvVUE0dGtQMWRNSUho?=
 =?utf-8?B?enQvZStrUGRyaWZqWkhFUllLUVlPOG54alkvVWhGbFZHWkFWVUhQdHZxUU41?=
 =?utf-8?B?OWxTM0ZpbURaNTJ0TVRnZGNYTDhvUzRWSWZMVzY1TGRRWDRXNjdvQjV6Ym9q?=
 =?utf-8?B?cjlJWkVtNkRUa1ZDeFU5T3k0NHI0S20wTnFrQWJFRzI2bUw4Q1dtMzBpL0Fj?=
 =?utf-8?B?RlNYdjYxdzYzT0xnNlFDaGVueDk3bDl6WXY0d0hTbFBSbW5MU0hVZjhzVThE?=
 =?utf-8?B?akFlcm1CckV6RFFqMUNPa3FsaWFlenROYXJJd0ZhZkNJQm5qTnVzSnN3NHdH?=
 =?utf-8?B?U1pWRFRIOS9KZDZyS2ZrSDFicjlOb1RKdDNPY2JNOWFER0dTL1EwNkZrZ0pq?=
 =?utf-8?B?VjlsTmNCRUR3aEtBNUt3ZnNVdDRweFROL0tteDhEQWhQNnIyY2hydCtGZVZl?=
 =?utf-8?B?MWlnM2RJckRYc0tQbWRzR1VsQUY0N2JoUFRGOFlIdERXOUtVZE5OUEswS29D?=
 =?utf-8?B?bC8xWklIOU94MFVlTXRBK3NyMzhqcW1FWHovVVQ2a3F3VUFyR1d6SHJiRWRo?=
 =?utf-8?B?Sjl3Q2ZESlJOVVY1RktlMWE0cFpuV2RKZndJd2JLV2JlZk5Qd0RqS0dGVWxM?=
 =?utf-8?B?eUNwT3ZpeFZib3VmZHhWZDg4ZkdadmJYcjNFakl0dWE0czRXVWE1b3FzQTBp?=
 =?utf-8?B?Q0FRcFJCZlF3dGtuVFVINXkwWlgxY0lIZERJbHRMeHV3MXVsUDJCWXhRSTZo?=
 =?utf-8?B?b0ZtSlVJQURoZGhlN2xTZXJxaVpZSUlOT1htM1hMUjRwRjlXbzJ2elYzVVZS?=
 =?utf-8?B?OHhGejFhc0NnU3c3c0QxMUZ0ak43Nk9OMXQyYWozNzF6RzQ0U01acThrS1pm?=
 =?utf-8?B?RlpVeFZneGFHYytmYTNNczhFNU5WMS9WRTFjY0sxdkhCOXlOY1h3UWZFOXd1?=
 =?utf-8?B?SVZiNytrajVPN0VzYjBmOUNRdC9Ddm1tQ2hKVkJCRlNRZ0EzajJIWUNkYXlk?=
 =?utf-8?B?T1B1Y3VFQ2ZsRkk1d3dtdWdhRVVuVnU3RFI0emZwNWkyZjQ1aFJkZG1oTG1T?=
 =?utf-8?B?c3o0Z0JKQTA2cWlXUDNraVl3c3ExT2J4cjRCQURlbTRDVStVTVl4elRoVHFi?=
 =?utf-8?B?WXhMbTZGRWZiNm5Lei9qV1hEdXJqUUh2U2d2eUhkM1hJS2R5RnVBbDdIdDFo?=
 =?utf-8?B?cEdtTng5djluTXFUcWE1Y0FidnVFaU5DanpQTklrekhQZG1iR2tPSCtTZCth?=
 =?utf-8?B?aEF0WGZWcVRQc1JGTndtZlZSc0RBLy95U1R3MVpneS9lTWc2UUNOTkxhVVJt?=
 =?utf-8?Q?Ja8pvA9+w+pgTAAVRHJLXGBdS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd80a0f7-db5e-4a0e-5f5c-08db0882aca6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 20:42:34.7019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRx6yK8Cqy6l+TqN4LaTGOzGTgktBAkZViw3kyAfd/9PEjuLCIjmPPUIbOW/wSnZ3RNK58A6Mb9wv8SpdcT7qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com,
 Ruili Ji <ruiliji2@amd.com>, Aaron.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-02-06 07:58, Ji, Ruili wrote:
> From: Ruili Ji <ruiliji2@amd.com>
>
> For the MQD memory, KMD would always allocate 4K memory,
> and mes scheduler would write to the end of MQD for unmap flag.
>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 +++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 12 +++++++++--
>   2 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c06ada0844ba..d682e6921438 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2244,10 +2244,22 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
>   	int retval;
>   	struct kfd_dev *dev = dqm->dev;
>   	struct kfd_mem_obj *mem_obj = &dqm->hiq_sdma_mqd;
> -	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
> -		get_num_all_sdma_engines(dqm) *
> -		dev->device_info.num_sdma_queues_per_engine +
> -		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
> +	uint32_t size;
> +	/*
> +	 * MES write to areas beyond MQD size. So allocate
> +	 * 1 PAGE_SIZE memory for MQD is MES is enabled.
> +	 */
> +	if (dev->shared_resources.enable_mes) {
> +		size = PAGE_SIZE *
> +			get_num_all_sdma_engines(dqm) *
> +			dev->device_info.num_sdma_queues_per_engine +
> +			dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
> +	} else {
> +		size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
> +			get_num_all_sdma_engines(dqm) *
> +			dev->device_info.num_sdma_queues_per_engine +
> +			dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
> +	}

This function is needed mostly as a workaround for Arcturus firmware 
limitations that doesn't have enough SRAM to store 64-bit pointers to 
all SDMA MQDs. When using MES, you can probably just use the generic 
allocate_mqd/kfd_free_mqd_cp function for SDMA MQDs. And you don't need 
an HIQ MQD at all, as far as I know, so you could skip 
allocate_hiq_sdma_mqd completely if MES is enabled.

Regards,
   Felix


>   
>   	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
>   		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 623ccd227b7d..ea176a515898 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -66,15 +66,23 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_dev *dev,
>   {
>   	struct kfd_mem_obj *mqd_mem_obj = NULL;
>   	uint64_t offset;
> +	uint32_t size;
>   
>   	mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
>   	if (!mqd_mem_obj)
>   		return NULL;
> +	/*
> +	 * MES write to areas beyond MQD size. So allocate
> +	 * 1 PAGE_SIZE memory for MQD is MES is enabled.
> +	 */
> +	if (dev->shared_resources.enable_mes)
> +		size = PAGE_SIZE;
> +	else
> +		size = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
>   
>   	offset = (q->sdma_engine_id *
>   		dev->device_info.num_sdma_queues_per_engine +
> -		q->sdma_queue_id) *
> -		dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
> +		q->sdma_queue_id) * size;
>   
>   	offset += dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
>   
