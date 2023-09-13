Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382A8EDEC5A
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 14:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC4910E4C8;
	Wed, 13 Sep 2023 14:26:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6424010E4C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 14:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPlYp61Le1w+WMJNUk3ncz2W6HVbBWKCGJ856fI//p6KliFVUmm9LgqJ9JXdXyjphpllqJNMdXr/CgzWxGzqzf6q1D4S4EQqOQNPpzaDnMr2voMTlx3/dll1SZpfeda6U+yEY6cstOQhkVhEv875Iua43cdbJgohgIf1t2DNPp/K/tysUG+mvYy1fGUmg4H/QmxEolALVg3M+l3HOY2CqaRvpWXcWO4NmpP4wcRZ0X/hVEzAftud5dXqkek/IesHsVzzIuJw+P+SIrQl3rEQk3cU7vhrO/Gxx/wGKMgJDGcLzCL8n4fXpb5+/A6YR0W56QndazJ/PxWtONSpRxZ9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkSg4DnwDQH4zr4zb5SQ82RDdpUKMwsXcW8arX64BKA=;
 b=ogIIlA5ceBJI62Ua6AstvJXw2vD/jV8DBsSFk8orceA9ivhlJ1kFOrXoetm/K3LBZ3dajBfVZ/3c7+eKgtlo3TY3xMsYqENmHM/FYB7sYwz2v2X5MEvPLPIJH/IeIQbctKl2NaDdGXE1exsHRYGhT/1GbyRdIlbwVtbM8gcsJg7rXxxTQKR6OfJnWZ3HyU0kg4c4xIZumlweWDtG1jv5ArvFPaYMFCWxk2oqFYCIRZh7tR39DdO+dyCwVNBkTGGXMtAO1wpylUlXtWw+jmxOA56DGOFf/nbbFaaenJNa/VQjfOaUkpc8uzzxFEDalcTFpRob9ef1V9VIsKi91rd8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkSg4DnwDQH4zr4zb5SQ82RDdpUKMwsXcW8arX64BKA=;
 b=NOd0EP5BH4j58F65JkExJ1MjzFFEoXq73ZsPrRmJR1gNRJRFbadUhrBsH9d++6fn8IBFhuI79SSnZkgJ69utDkWx35RujNn+pV6/qgYf7cWczGh82+WdEmpZc6ir0UQwMrrbpY4jZQKqreU9Zmnp02AIFSCh/jc1Am8jWkneB4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 14:26:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 14:26:08 +0000
Message-ID: <9cd887e7-8c68-6895-3402-f02f290d7beb@amd.com>
Date: Wed, 13 Sep 2023 10:26:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: fix add queue process context clear without
 runtime enable
Content-Language: en-US
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913015205.3173952-1-Jonathan.Kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230913015205.3173952-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 49848ed3-2855-4341-8661-08dbb4655f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwW8t44lgmsE6EyMwOyKWIPWWyBCUI4UB1xThSqCw3CQsbYQCJC+SA1SALzL6D1QeCIpGZxurXgHXUjfsVF8CAimfaqjKbBFG1pYhw0E8S3UkEuGm5gRp9kXIUiHB/FhT+GcDD61fd7ziDDjqNUWRV6Co3WlLdHPiF9FBnOSEZ4GcxmDH2c9Abzp5jLu8YwfVTFoNXSKDAwHlsb2JJDzWQo+jQL28QiaILhoM6wlCg2AqgdGv2CTJyUOyCm09P1ueX7Q6VuXkB0vON/hx/cTMrKX3haDgW9QVz81L6h8q8go/aXvVgbsi253Q2VbutG5JZ/9yCDOMcBjCvOT5uO1OJpVaGaUt0LeXwLhXVGjZExkupn5xHUNgEAfewES/lE2WlovDtsH9Y1LuNU1KKCb4t3VvlNG94GIMULN5Ih2hKN6NY2mBzv8wGdbW9hGgy9TYQB2CFqZavJsdSDuJxMVWKxUUrWxeHT5/dGoSnuA/LAhX/KunL2cEb3t3XSDBAAOrvhmsqUX5J90BJUWpgH3i/9p9DYRi3qAQyaKl4ELjT14ywbSAIy5QaL+ZOB9CEiTEn43M/XSLUQETvyjs9C9mggrBRFiXoZvGxBU5I4RYR9iJ5/MYLj7f9ASIawF1gEsuaUYaW9782aUH1oNiRfiwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(1800799009)(451199024)(186009)(6666004)(478600001)(6506007)(53546011)(6486002)(83380400001)(6512007)(2616005)(26005)(2906002)(41300700001)(66476007)(66556008)(316002)(66946007)(5660300002)(8936002)(4326008)(8676002)(44832011)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmRXTXpjQXRGT3d4UzYxcVQrNGMwNTRycDVhbFh1UWJwV1d6cDF6N3E0ak1I?=
 =?utf-8?B?WEI5MS9rRGxqaTJTdHlaZ1NxZXFGQ01pTlZMUjVGdjJobG1NVGdLUWJlYmFL?=
 =?utf-8?B?YmJwd0pkSDRHLzBsNm5EOERrTXpXT04rL3E5U1dtenZjYUpLa3RqeEZCeGlV?=
 =?utf-8?B?Uk1Dck5LNXpIR1ZQNzRYL1RvWm1xQUVRZGlIVGpieHJXOGI3OXRJRjcrdW5K?=
 =?utf-8?B?c21mTE5zUy9LekhKQnRrY09LSDBXZFQreFRlMVYwYzhFSkkrelkyL3pUc2Z3?=
 =?utf-8?B?eFF3Z0w2K1JDU2NmRGdqOVVxVENBVVByR3RRQnhURm4xMUM3Y2pub2VuYXNr?=
 =?utf-8?B?TnRMRnpJcVI5N29BM1dvdi9WcVZzYjBLSklqaXQyK1B0N3JMV0hqdzkvanRG?=
 =?utf-8?B?YUZUQUFZLy9qR2RBRjRjQnVYY0lBVDhVNTFJUWlVNklJK0JiYmhtbzVSK1Zz?=
 =?utf-8?B?emdlbGU5WGpWSDdNZUc2WnJXMVlsbVVsODJBUHV0UVRQNkVndGdseU02R1My?=
 =?utf-8?B?NklERER3NHhZTk9OWit5NVJkVWRBYUl3V1U1d20vMUxwZjBCNk9nUG9xNXpl?=
 =?utf-8?B?TzM0VzIrVFFjNS8rZkJ2azRoZlNJWVBLZ2M5L2RSdFo3WFlLR0FwUEl1T0tv?=
 =?utf-8?B?TERVR2puU0N5amRkb0dOSldSWlNTa1RBaE9aTjk2SGpFOXAyNFoyR2J4dDJ6?=
 =?utf-8?B?a1h0UjhlbzgyOUNOZzlvVzJoQXRwU1RrQ1JSRlRHZU9SMlhEd3ZUZzB1eGls?=
 =?utf-8?B?YVgxRmFVRC9UbGd3elhUa25tNkc1UmNSYlBjblNIdDZ1VzFZV1FQUytuR0Z2?=
 =?utf-8?B?VFNPNzdnbVZUWXdqRjZYSkc4NGtiYTB5TUpRZWxWN0FmdGtjSlhFNDJMdVM5?=
 =?utf-8?B?L1hJN241am51NnNmRGpLY0FrOWV0MHNBK1JIYm9OTE1TczZ2dElJQmtFcUVz?=
 =?utf-8?B?VUZwclY3SG5jc2Q0RktWb3JSRjZiQVArd3RRV24vaUxpWkl2OURuUnQ5Qys5?=
 =?utf-8?B?VnZEc1MrU2J4Slg5QVJqQmNHVkp1ampEclVuakRDaStINXhHRVZ6aTNJaTha?=
 =?utf-8?B?T0JOcXF2bTl6S3U1SDBoYmVoU3NSeVB4ZldYTFNUczlXbzAwSHMvVDB5QnZJ?=
 =?utf-8?B?YWFzeDg0b3NFOXU1cS9TMEIyb2JtWngvVS9aZnpXL0lQdit2QjdZUGVIYWZl?=
 =?utf-8?B?NGtYZTBYaUduUTJHc1JJK09ESU41aFUvTEVoRWJiZGg3eGZ2THMraHZ3T3Q3?=
 =?utf-8?B?VzJvTWU0N21oZlVvQWFjR3dDVVlaSE1iakpBMHM5aUt0SDVndHQ4L3BsVHBT?=
 =?utf-8?B?Q2RnNmRUbjBtcWNXc1RBMFRFUERxeHBSSnY4bTlCZ3pMSlVZRGo2ZlczMVhm?=
 =?utf-8?B?WTBPZjd1aXJhYWdtRjNIUFB3V01ETVJWb2Fqd2hrOURUV0FsU1RyRlAvWFl0?=
 =?utf-8?B?SGg3RW1RNXVWR2Q1WDdOTVdjOXpibjNZaXFzVktqNUhyTjVZRm5wRUM0L0pX?=
 =?utf-8?B?VEZ3b2NBSEczZ1Z0aVZValpZdWFkdmdrdlVUakYrYVZWaDlrWjk3SkJZdmU2?=
 =?utf-8?B?ckwrUlZyYlgxU2RnQTBnOVBxVGZEYzB3UHB0RnVNc3J5b3JvL0lqVTA4SE8w?=
 =?utf-8?B?MDlEa3o4dmMzSk14NldUVFhSbVNqV2xqZWpsRmpaSWVGOGplMjBXUUhBWk9j?=
 =?utf-8?B?aHJPVWczelpSQ2hENVBLMVRHUnNGZnFmbWFWbm9qUFJZSUlsUHFZZTJXL3Zq?=
 =?utf-8?B?eDJrblVxclBjQUF3dTJDMWJleXExbnZuelc2aURGSDhZK3BJenJIanNxKzFM?=
 =?utf-8?B?THJXeEF6TWZYUkNwcjZKMzNWalhPSUFZcXhtT2wweHRqb0Y4QVRzTm5MN2dh?=
 =?utf-8?B?b0orSVc0a1pHTS9OM01lZjdQNDNEeWErV05ZUUNRRUtFT3VCVE9nRFcxcjdZ?=
 =?utf-8?B?bnFYMUY4QUpqeG9kUW00OFgyWStzOXpmdG5wV0lDRExFUVU1SGY0OVcrYzlF?=
 =?utf-8?B?ek1pSzF3SDRNVlRSZDJ6dFlTdVNRL2ZQRGR3a0FSWWN6bHVqM3BpbzRuR0hJ?=
 =?utf-8?B?aEdlc3g3VkVsUFdHSVJGUThTMERhZG8veHhGSG9KMEg2MFhNb1Z3dkpzNnRP?=
 =?utf-8?Q?hlwbicF6Ht7wjS2tN/ny3/yNN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49848ed3-2855-4341-8661-08dbb4655f2f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 14:26:08.6497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crQHgVR4FZnuAsi7QDsU9IpQbHZgyQLsGXJkfSwFQkgucVmAmNdKN9kJxdAxzdMFXhz0Pr9xsWQfP49VEW+cXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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
Cc: JinHuiEric.Huang@amd.com, Ruili.Ji@amd.com, Shikai.Guo@amd.com
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

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


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
