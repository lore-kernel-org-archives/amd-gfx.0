Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E86ACD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 14:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3C510E583;
	Tue, 19 May 2026 14:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2fdLWSHB";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC4D10E583
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 14:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsjpG6SQbrFa4ppKOzy6EEG8SlQsVWwUTL4FFTzYGwfFKyajrmpGwo+g3fEUSkkegHOTkaz2Ppbl94FwM8gJZKAMOjGWmoScUTmvFb7xOIX+AzV5jGPRjg9zE0EMdsVRn42BDBojgh/PZ50GdL3g5Wl8vaUaHIveI+MQ/a/7HNd3ZdC0Fc92J3gfpTyaOaA57TDr0yH8yigKAPIaykH2z5ty8v8a3pDsIYZ8X7VmDyDHPnJmWfY1acdz3uK3x8kpXwt95SbMq+X1Xxbd/20MQ07mM12hsJ5XkFx4qlq6F9uwJpGcT72CEqSHFRrxCawu19lWA/lnM7Qwr9Gwv6mrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVzMqw1KhEuz9pMzhUQJiOjEzUtgYCm4ycLz92Z3CP0=;
 b=oZN9bJ46caydfPSvUs63Uc6NQONgKw2D5JD963aQ5Psdssg1Z9lfNxp+4N16H+E+8w+16P1qmw7uffRbN7dteP86TJ+DE1/jBNn2BVOnbdPT3r4UPZLUZbSdry9vStvsb+zCk5QA6PTIlF3bkQ/WAHNGDPKru9PfHj9cbEvXN/HrwQrPGeYLfg0dMfdT/JTfXLqfDXbGwWCTbleKQBkuLhfWYXeWKl0AyPhOnL7I8dlxAhGYZMMwnkSYrqQO2H040ykGf0druowbJEwapEenEnp0F1PRWciI7RV1hGbYV74+lRhEAIjcuUePMvXUlWRIEZmiR6OAvA24V7Ph4dGFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVzMqw1KhEuz9pMzhUQJiOjEzUtgYCm4ycLz92Z3CP0=;
 b=2fdLWSHB2iLGcGtDAIAeKFbijj5oB4NyknTUpsTqRGxv8BXrz9wKXBAtQbPEMKPhBu62QxEMafOTe/P3aO0eOnb1lN/o+JOTyjPK/uQrVG0I22EMINBy4VjysT01eg/LkQfDc5o1QGqLiZ4Bo455zCVYI1IGgTe76Kh4qMeusIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 19 May
 2026 14:13:30 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:13:30 +0000
Message-ID: <aafdbd13-594f-4f21-a1ea-2dcff8fd6945@amd.com>
Date: Tue, 19 May 2026 10:13:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix a vulnerability of integer overflow in
 kfd debugger
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260512150535.75401-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260512150535.75401-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: d88f22cc-31a4-43ab-0feb-08deb5b0cd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: LR2Z+WZ7Y+YvvjZgWc18wlmQ12YvoXYvve9fPP4YC0J5pyaxLDdky4bKhd5aHq19zZYzlgJVhvYybR8XrPVw8mSYXuHovXEEgDi9LeH3AzdRAsqV4/bYOVb4sqbNPxrh08+x3HiJVBQfyl3XX6QOyLgj3Jyw9RR5G2LMnfL42YryTH1hLaoI0I597Qn+zZ1l4oL7hAi0P5Frx2mSjFLqrfJIYUnn0hAZx8HtVOYZfG8ZW7qJIjsVU3EijiDbxy8LlwD7OgGT6r5MlewhDcxKqS9hlWTigHEq5QRUNF2jsjWdr1gk1p1sKog3UV3km4TDFMSX4pFhfVHl4rPl/2RgUTZn7mTfDJwZsBP+2guNp2+Rkv3r85iT+UTZ//vFn5+S5CLs6l4fbVoKZZ5NLDOZQik4e/i2KstQ3OLM/4kzUHZfSFmC9PmwNYA59WPfcnwI7Kx4S6Q34em1S1gu7846XH8TPUo3CqL88EmKrAkxbNf2vxw5c5EVPpL53hsKC2am4Wb7+i7qo+q59yjK89sCUpRWQJHwWMk6xehTLjfNGYFsu+yazWY3/HiqCg3C+7miMq9TgN5UFHtnLvsSoX5wg4HtSZXc5GKIESYK+kqxdpWqpCrRjbDAdb5P0+6QQyorQo90DB08Fr6zXt4luO5zyqGatM2GiqrftXntn42A380cx6J7XkrbNuBu+zOjUdGU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3JPSDlNbVB2VGlDQTRzVHlnbHBWek9kWFRBRmM1aUZRVnBiR0I5SVhWUDNN?=
 =?utf-8?B?RnZxNmZVUk9GcVBCeEZFV3NJN2hIMFV2VzJmYjVoZUl4TG8xVEUvb2RuMVNX?=
 =?utf-8?B?bEF1cysrMFgyd0dVYzh6aXgrTjVwVVNtNmRTV0JYc0pxQk1OOXRzdTdweEZF?=
 =?utf-8?B?U21NSkR0NGpvREZIRElybU1Bd1JFYXpSYnFxdDdzQVhQNTJQdmZ6Y0gvbkFH?=
 =?utf-8?B?Z08xR09SaVpzNjRVc0RyZnZ0anZmMlNFa2lneXpQN1RTL1ZDZXhFeDh0MG1Y?=
 =?utf-8?B?S01OK3MrNTM2NjVIeCs3VnJUTXVCWmNmYVpmYlpKSTBYdnk1ekdxeFp5TFdZ?=
 =?utf-8?B?UExZV2NwbjRvY3FwRm5CSVZPSkMrTVlxYUhNWXVTVGExTVZ6Y2ZBdHhPQ2l5?=
 =?utf-8?B?enp4MDlvOXlvOVl2eTVmTnVLcVpKVXZBWUFxekplMmZ0bzBGS29uYXU2eVJn?=
 =?utf-8?B?S1k1a05FSE9od3pxdkhQdUJaUFZ3ODNiRjB1eG83N3BVWXpCVitWYTJUWUVI?=
 =?utf-8?B?UlgwWm9kTnZtRDVVR1BYRndtWnM4NFZGalViVVB0eFBkY3BuNEFTQ1BhQkhv?=
 =?utf-8?B?N1kreDhjU1NPNFZuUUlGMjB2UE5tT2RwS1BSaDg0aWQxUTBWQ3pvSXBYaXIy?=
 =?utf-8?B?Uml5YWNGTXhDRys4bmZhSXpFYkNaNTM3ZDdxM1JRNjJvbWNOTU5vQlBMUUJi?=
 =?utf-8?B?eTNmTmZHVE83TjVkaVZVTzN1TURWa2tpT0l1N2szSVdDR3Z6dExVZS81NEFv?=
 =?utf-8?B?Q2FDZEZBSXhZbk95OUVoaHFMN015MW5CdFdIdFNIakdTaElTMkZhajRCMnJP?=
 =?utf-8?B?ME5zY1laN1oyQS9GN0NDM1BDR3FEWGdGa0dMSm1aMi9qOUFyekplTXRnS3pD?=
 =?utf-8?B?ckRNaTZtVU5hOUpmK1pwbG05OHoxZ3JJenRjMWFwaDR2bDdpY1ZjZXhZTDhW?=
 =?utf-8?B?RXZMT2N3WVlaN2p1V2FoeWZzUklzT0hxN1pldU5YZHJHY0wwbjJYclRXaytH?=
 =?utf-8?B?Y05KbzVLeHgvZys4UGVyUHg4TDJyWEYzbVdWS2lobjd1VUszeXVtQnZCTTcx?=
 =?utf-8?B?QWYvUUQyNlZnV004anlVa2tiNTFxOHZUR1RUVm9zSlNrclZ1aFFQZy85bUUx?=
 =?utf-8?B?NjlKSVpuRXlCSmhZRFF6NnFMc2hIZ1JoZWxLaXNVM2xrR2JBTEhwRXdGdGlN?=
 =?utf-8?B?bWxQWjc0VDMyMmVheE5OKytKRk9aQlV2WTZaZEpDSmFiY2hwVVRyUUY2SnpE?=
 =?utf-8?B?YWVMTm9JdS9GdXFoZWIwN0RWTnk3NHUzc3MrdmlmZWUrMFNiYWVLbW5wYWEv?=
 =?utf-8?B?anErZTg4aFRaQjFWdXB0ZmVMNVJuTFhYRy9IZUgxZm5qYUpCMjdnZWoweGx3?=
 =?utf-8?B?bTRCK0IrR2JNblgwS1FLeUdKTktQK3Q5bVYwT3ozOS9EUEJySVJ0VVZrUHhY?=
 =?utf-8?B?L0N2ejNoemFwc0ZyN015bVh4UGsyWDNIaVl4YWdZZG5iVjlWWXJqV09kZnNP?=
 =?utf-8?B?NFNhWXA5d1JBNjBqZ2dKdHhrTkZ6dy9WbnllZGtrNWhBek1TeEs2OXlrTWFw?=
 =?utf-8?B?NkhDMGxqWDNRS0lHdXVFbjhLUXkvRVN2QkRHbEZ6SEpuYTByckEzUjVmMGhj?=
 =?utf-8?B?dmFhY2hNcVBqWFd1MWhYbEovK2tRakkxMDFpUmR5Zk1RdGE1Zy9EMnRKWXND?=
 =?utf-8?B?YnF5RmEraXdIKy82eHp4clNmZnBZQUs2SDRReVZWajhiRGM1UjY3cE90cE5x?=
 =?utf-8?B?SXpMcGcwbEZYcnNWME5oRUFTdTFGUjBNSzdIRlJ0bUFFVVU0R0xoMDNLVXpY?=
 =?utf-8?B?TVZGV0h4NDdQQ1BXWTU0bmJrOXkzNEpTYWRZRGxYU2R3Szc3K1V0WXRmTnFR?=
 =?utf-8?B?eXgwR0JoQjBoUGtCRjdrZmxGK1pBVUZDUXhFRE42ZlNCNU1VT1B2M1k5QjZS?=
 =?utf-8?B?WHEvZzhCK0FBZTlUOWZyeitSQ2E2R1c2M2JqUk1CbHRRNDNhelRxdkl3YmUy?=
 =?utf-8?B?cFNXY3gwdlpEM01YR1hwWG82RFVUNWdsTHkyelFlNnlncWV0eHFZbDRPU25U?=
 =?utf-8?B?c3R2dFFBV3VZdXFOdWRlbExvdmd3S2RabUFCSFVFOWd0OUJmcGVjZjJHYUhX?=
 =?utf-8?B?b0VCbm1VcFVvMFJOOGU5L2RWSkVKaFBSN2J4WVladjNjQzBxVmh1QVRxeHlF?=
 =?utf-8?B?NzVpTFd0TWtNWUYvT21ZRVFrdHNqWGw3S0c0NVErTXQzdDNsUlAvS0RBVTFs?=
 =?utf-8?B?Nk9meTZWaDRBcHViOVNibU1pMk1hbDFackZoMVNaYVN0QUJtNldxVDZLRVlr?=
 =?utf-8?B?OVlFSXJ4ampMVGMwY25tSldIMjdLNytKd3dPUTNhRUVhdDc3NHJ3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88f22cc-31a4-43ab-0feb-08deb5b0cd9c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:13:30.3536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6dzF639BDDNQFnE5RTuxcXl6k54jx119lRXc6D6Cvb+4ekIFLiX5GZbVk+v3pR2XrkwzZcyHRqFymzmg2tPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
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

Ping ...

On 2026-05-12 11:05, Eric Huang wrote:
> get_queue_ids() computes array_size = num_queues * sizeof(uint32_t),
> which could overflow on 32-bit size_t build. using array_size()
> instead, it saturates to SIZE_MAX on overflow.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2e6923528342..b34f29501ff8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3468,12 +3468,14 @@ static void copy_context_work_handler(struct work_struct *work)
>   
>   static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
>   {
> -	size_t array_size = num_queues * sizeof(uint32_t);
> -
>   	if (!usr_queue_id_array)
>   		return NULL;
>   
> -	return memdup_user(usr_queue_id_array, array_size);
> +	if (num_queues > KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
> +		return ERR_PTR(-EINVAL);
> +
> +	return memdup_user(usr_queue_id_array,
> +			   array_size(num_queues, sizeof(uint32_t)));
>   }
>   
>   int resume_queues(struct kfd_process *p,

