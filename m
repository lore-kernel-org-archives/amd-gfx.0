Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B50EEAA41
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 13:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D6010E293;
	Thu, 14 Sep 2023 13:59:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2135410E293
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 13:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwJDaeBhrCgbLAnLZw155MR4jHVwzU5asklZMGuP8STJV6zoXnnsAx3Men5bORLP3/dCJHdE6XAUMJI3qQtI3A/xOa7PQI+z7PS0fjFrysbH/MlZCVzF1e6UyfepFeq0eQZ4jLPXMoQ18DZYeuWJ6VTwd/pqPqRl7UxEYD5wrQKukSdxSK0A71kWSA0/PyrMUyrXhsqm4geHrcO1I2BsLoOa4cboeWx7QNgGQ9yP+F0+5RhWYapeNrAV83gk9VHmpR5Bok1oYZGUWO/DpklIEpMtYUdsBD0k2htxdognuBTrDnpiREfGFW+FB4ralG92SqkYrAJAPv2UMI/0YefNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZmwHD5PV/e99UWAjT3QGRxvc7zBPgvxxQo0q90MFRg=;
 b=YX+6Uy5Uo0HnnnfvytqgSCEZC1W8SOzKa39SNCol0UdRCTtYubBUNd1/enLq/1FlebaucCoAU2iXs/GVp9K9W9vGmRdXaJa5xEbIQ6u9k81GB4vGuaf2T1qBDWjzocDLeWX1GuNQsegemDNVep46RhB+s2+HO/SzdKDaQq/6X49+vAsNp/ByQ1EfMWqKBaR9KQIoUER/3EMxXpYJT7021Sj9PPCy2h9kpW8NUXWmw32wleDASHPFPzRaP+HbpFJiXCJHtf+JWSZMHF92AXYzlwXrg/fMvKqqvs+C3dJ5dHTj7XA0qxLLPEZ4F5ruyPSjQZaXG//W4nAemvkpS3bVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZmwHD5PV/e99UWAjT3QGRxvc7zBPgvxxQo0q90MFRg=;
 b=YQcKv96r0rg2QgL95/as/A74m3oSYBd6J/eGCZmI0Cs3ytTZnX18aCT+4LYQoOpxYGUh9CRhKXPJUl+tXu5DlMqYpBCTiRlsP9I1AWdA4Ep0rlWnM+wwQHenONYnc3AFMPhzGKLbc34ZFCxUG2goGD2gbEt5cZ9TP1FyImcFAAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 14 Sep
 2023 13:59:19 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::6a01:3c08:d06b:9567]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::6a01:3c08:d06b:9567%5]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 13:59:19 +0000
Message-ID: <67429762-b975-85a7-8535-927fc5913674@amd.com>
Date: Thu, 14 Sep 2023 09:59:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: fix add queue process context clear without
 runtime enable
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913015205.3173952-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20230913015205.3173952-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::34) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dc7163-f5e6-420f-2816-08dbb52acaa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAvUqhoI2vee9OkAyHoeMjXj2NPZflQnUNr4fX5jyHF0UtKxAX99i5twNQCWzPcXP0csLA8rmixz/MN4AdunWUNuDe8KepywGkwat9CAvUPs8RZch2ks7QvzDtJFZ81cNsq9J7JK5WsG/StLbtRxAIgJP0tPtNcn/ZRSOrG72SwlV3iQlkPbGf509MGCMUAIHEouqZn/Mb9AslX7o/7NTNqdQ0NQW5W0qP21b6djvpbMAXEbZI5QsWgKrOyFLHEEM8Gp4aHB4NRFrT9cz36cZdy1nUVGELXssr14UvBwLLgrJu0TpH6EBxlVA/ZDlht+kYLvbxzC+jldJUts0FtOMHA29PZGtCMTvctHvMAZd0Drn96NqM+/4qgvAYICZDnM/+nMR1LQGE2EMSPPGexlWJbb0TTzw4i5C0x1v34AhqwmMqTgeOdJE0UoezEQCBFLmE+xYL/7F7YxZJNWVs3ywBpJUO1CWe11NS2Ish0wIuDPZZ+ITrzyrE3FZEZ8cBy0QMdsfceCL87X2R5XUA6WRgNna9ulpt+y0+76Gt9ZM4OLCupxeWusRxzJAgo9sbKHVzQTtYR3C24g9NCKRqi51KpPL5lqfxtgmhA3O2unU9uO/jX/QYXpn8dYn8HZ/B99+tfzdDES8gxyPFluOx/c2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(1800799009)(186009)(451199024)(2906002)(31696002)(86362001)(6512007)(53546011)(2616005)(26005)(36756003)(478600001)(6666004)(6486002)(6506007)(38100700002)(83380400001)(41300700001)(5660300002)(31686004)(4326008)(8936002)(8676002)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0Q2SkVoNXVqQnBMNnZQd3ZYbzIySEthcHVYQlNtWU1kWHM1Rll1cXl0QU1w?=
 =?utf-8?B?ZTBmWGhyZitXSm45enovdE9XSG8wYmpoUVZzTmkrcm9rRTlVb3BhZE1rWXZH?=
 =?utf-8?B?dEVFVkdHMkJERFRFdHV2Tm1XZXVUUmpFWXpTUGhhbFhVWWdlWFJZQ3VCakRN?=
 =?utf-8?B?V1BnQzJ6QUlSTitmcDlhZkdMZG9mdHRXNCtvY3lrTVgxL1MwUk85YUdyMnRZ?=
 =?utf-8?B?enhMMnBkTDNGSGgzOTIzWWJod3Y4c0NqaWtTUUp5MmwyaHVNU1dwQ2N3QS9G?=
 =?utf-8?B?RFFaaU8ySjRUSTh1a0J5c1FXcTJxbnk1NHhuWGR6TS9Vb25Pa2RLd1FqUFgy?=
 =?utf-8?B?Q0d1M3hRS3ZNTjBhWElhUnZHRFptaHFjeW95QWxuQ3NrMHpIUFVabk9DZVJQ?=
 =?utf-8?B?U253K1NoNytaZGljTnZmZlM4bjcwQmp2T0hsMkJuck85UWVBWG5MRmhQK3hI?=
 =?utf-8?B?WERQM2czL3JHUnc5aElVVmM0RmZkVGdsRTNjcjZxeW5abEtTN0s2U2Qvazh6?=
 =?utf-8?B?U0NOejEvT3RpclIybjZJb1ppbHA1R3NObmYyKzNvVEJMdjNEMlpXRHVKMjdJ?=
 =?utf-8?B?Z3BFOTcydlc2M3Q5M1RzR3FvM2ZxRGRvY0xFNTk2akg4SWZtV0t5aEFmbmR6?=
 =?utf-8?B?N3ZuV1FRRG1PNnd5MVlBK1ZDeTR3Z0YwNCtNL29CUjBWTkRNVytjbjZSV3FL?=
 =?utf-8?B?QjBrOEF4RG1KWEZaQmdPRGprZk1VRjRzNXJZbWJhUFIxS2IwdFlvWkwwK1B5?=
 =?utf-8?B?azdlWmxDYVhMbWlWVVp3Vm9ORWxKOVMwUUM4V29tSjBZaU5UZWRmNmxyTkhM?=
 =?utf-8?B?d3hFQnV1UFVZYW9YQWZoU1lWamRVN1ltQkhHSnM5RFZzT0tBTTViWkdPU2V0?=
 =?utf-8?B?cDBNMXdiWWY2bjUwQTFRdi9uWFQvdUFOemE5ODBCY0xYNGR1L0NwQjBWNXlY?=
 =?utf-8?B?eTlQbnYyNDU0b0JlNGJ1TlRkcnkrNFZ2NkFHakJHNUxWQjZ1a0RialBJMko3?=
 =?utf-8?B?WHB5N1MrYzJGZjJmU2p1TjlGUWF1UCs5WkhjT1owcVZKL0VCc0gyUWtLNUdR?=
 =?utf-8?B?dHhNQXU5eXJ5Z0F3UEFzZVVIazBzRGZOK2twaDdqR1RicEhFOG1OMUtzdWxt?=
 =?utf-8?B?c3JyYVRkQjdpLzAwL1gweWh3RThtMzEzc3hzWU83S05SVkhDbGlPZlFJVnl1?=
 =?utf-8?B?MXFyT2w3R2h4TFB1TWIwTmE4RzV5K1NyVThvWUVobDN4Sy9BQjZwMWdxa1dX?=
 =?utf-8?B?NUk5U1QyazlETFduRFFib3IydVBpb0ErYjVkamdqS3hCbGg1dlJJN3A1NStp?=
 =?utf-8?B?RTZ5NXJhQy9lSHRsT3hrM0F6QndyRThyNEdYOUs3U1ZacityUmpGMkEvWkdk?=
 =?utf-8?B?RkRodTUvbXpId2tSWG1mSWptSlM3dWNUSFZISGNsb2c4bkxIZmNLZkt1QzAr?=
 =?utf-8?B?K05RdVhTSU03V3dyMnR3czkrc3p4dUYycHFVMzdEbFlvZzlQZmJkZmpkZ1BN?=
 =?utf-8?B?UjlDbk9IYlVoWlB5azIwajdPUHNWaUZhZXFndzRGU2YxTXZTUWZNSERwcmw2?=
 =?utf-8?B?UkJOSFJIUzA2TFlLNnQwMnpwaDE2aFdlMGRwTVRxY3Rrclh1U0gvTzc0NWFV?=
 =?utf-8?B?QmF0MVlMQkFONGFUUzViQm9EcENYODdiRkM5K25rU2JFOFN2cTFMTU1QS0lt?=
 =?utf-8?B?a0dqZUt1T1grN3hja1ZWVlRhVWUyZHd1NXczSk0rTXRBNnNMQ2JOczNreThw?=
 =?utf-8?B?WFowYzFLRSsxb3BYRVozODVmei91c2ptVGdoYWNOSWJIamc0WWlQMEE0RmNY?=
 =?utf-8?B?dGRYWDhyUFFXMU5iRmRRTW1LYkRBcDN5ZExQYXErK2VIdWFaK0Fqa001NnRo?=
 =?utf-8?B?TXNQVFYxOFNOQ3V5cGFxVXk5eXlkbHo1WkFJcWhjTENUcE4xNWx2NTJQanVn?=
 =?utf-8?B?WURKS09acno0UENlRFVmTGw0Y2xjdmxMN2FSY2hhdHZEQlphakkxVHEzbENk?=
 =?utf-8?B?SStTTDNXSUIyOERNaiswOGc3aGt3amd6YUM5MUNjS3ZZM1dQdU0xTXM1NWZL?=
 =?utf-8?B?YTA3emZLUllyTk9icGlmd3Z2bDBMcUlIOC95VHhZb0pqRnFONnRnMkVhN2Fi?=
 =?utf-8?Q?vVYo9jbvAR4Ln418sPjAbzOH3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dc7163-f5e6-420f-2816-08dbb52acaa4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 13:59:19.7845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 950S6yOmF5GCuL9XtdpHtY20wKvYOvv6iDDjn4swzhQqYd08j63CFWAIjq0JZhc09S/RzbHYdgHGJJ2dlsUO6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
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
Cc: Ruili.Ji@amd.com, Felix.Kuehling@amd.com, Shikai.Guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-12 21:52, Jonathan Kim wrote:
> There are cases where HSA runtime is not enabled through the
> AMDKFD_IOC_RUNTIME_ENABLE call when adding queues and the MES ADD_QUEUE
> API should clear the MES process context instead of SET_SHADER_DEBUGGER.
> Such examples are legacy HSA runtime builds that do not support the
> current exception handling and running KFD tests.
>
> The only time ADD_QUEUE.skip_process_ctx_clear is required is for
> debugger use cases where a debugged process is always runtime enabled
> when adding a queue.
>
> Tested-by: Shikai Guo <shikai.guo@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6d07a5dd2648..77159b03a422 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -227,8 +227,10 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
>   	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
> -	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled ||
> -					     kfd_dbg_has_ttmps_always_setup(q->device);
> +	queue_input.skip_process_ctx_clear =
> +		qpd->pqm->process->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED &&
> +						(qpd->pqm->process->debug_trap_enabled ||
> +						 kfd_dbg_has_ttmps_always_setup(q->device));
>   
>   	queue_type = convert_to_mes_queue_type(q->properties.type);
>   	if (queue_type < 0) {

