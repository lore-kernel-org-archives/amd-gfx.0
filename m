Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA5AC761A6
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 14:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2AA10E222;
	Thu,  6 Apr 2023 14:09:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53B810E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 14:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEkaOtvfUTj0iWGujVJ8wVSLgCDXSg23w6bpvP51lcaKIt8+2eOc8ntSEr78l8SRSwewhDay2FlkOrHeHXLpYpdPI1S4w9e9nuC5J3CW6gQx1VW/ghTt642nMBbOmbOUWtTLeRW7l79dyoNv+bqqWpd3o6JfG2YoF1RzW5Sdk0K3HqjHunHNxkXpFfHdKNit+DgDFEbj4ZqHqAYfWEfOUexMjAszNawiA/TIribQfS3B0rKnUavlAmMgVkLQ+w70dQlPUEr1L4PWA1hEPZcSFK5xqe1x+hkL5Ge+UccyKBbGWk8pqtl6eIh6P7VbSMTsL/RzwXs9+iHiNoOk44zVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NifTbAnkHug511cKR/wBXwneqJkazss8mt4L23clEo=;
 b=gcD54yQzSMTMzIBSqijosPFKnMdy9Kamu7A7WBLPHpBfJ3UsRxdff78/WjmF4QLy7wiwFrkVmIEdtp0CO3URiJrdhALu94teWoHJGv7JfphhUZwHR5fQsmCvsstEJJxge6u5OC/ZtY3v1R73Yw/lluAWIRUAJPN7YxcZwZrF3b4TtI36EgNVaUW2oTxsvQFwL3qpKD9qsdP+ARpUhUjfn1+RWrqcqe6/L+rxoTkuh5Jg2m6OP5hR0DIgc3p8UyyYoh0eNPGyJ8jC3Yr0yc9NYF8wf/JPrNyzTiGWYDr9AM+ItS8gsjcpwmnk6Ow5CdmzbhXiHCKPqcYSu8Vlbo9xGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NifTbAnkHug511cKR/wBXwneqJkazss8mt4L23clEo=;
 b=4o84TaiOwj1Jwid6z+Hg1CnRuWkFbQdJ12RY7jUf4HJRrJZdsmp+lgk6qqUGsK6ZkqtQ8Y802w6ly8wEbdobEDFS/8SbfYLmjt2P36Bed6QpKnJ5Uc9i8PA1oJVpjqlpWl31K9K837K7WbWxY1Fgp5a5yrwi+3FG33yrNgjvgxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 14:08:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 14:08:58 +0000
Message-ID: <005a0f80-d009-79e1-c019-58ef63692eca@amd.com>
Date: Thu, 6 Apr 2023 09:08:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 1/2] drm/amd/pm: Add support to check SMT state
 periodically
Content-Language: en-US
To: Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, evan.quan@amd.com
References: <20230406124514.2906870-1-WenYou.Yang@amd.com>
 <20230406124514.2906870-2-WenYou.Yang@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230406124514.2906870-2-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0054.namprd15.prod.outlook.com
 (2603:10b6:208:237::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: db47340d-fdeb-448f-a9a7-08db36a876c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsm1ZqoofPgAgWYjv4Al6T0pQcC+b3VA/6nu2tMMeN0eef6BbD6ZjdrIvX83bkNQx7Y+ZGVoGU3tekpSq59PeAmemhvMspJ+lfrygRheZfvChiwk339wOnuCXX7HK3RuovK+t6fhCwAm+oWSdy2WdS+8pe0jU6CDO3/1r1KP9CfP0UbrcssRoPLn82gG+umelN2P+mFP+Kci9KU9PCA/iJlxqX0mJl+a1bAo2k3Sft34MJx25d7IcvtSjs1wSTRmFI0RS0f/a/zzyEErMXe/fSXAk/rb3dKXTqpBB17Kf39AWXDXYun8WMW2KyOXX9xuAcxF0BBYVZhnQMEUV8aBuKBPoIyLeY93AM/wfbJSxFafed57vKeZ4xsbVJXaUhO/yJaDvT9F9D9wpfQKq/QCs0GaIN1GjNlDX4Q38pZsDLYyHG7S7EKz3pirfICuyH9PuWJdhlVodxwNY4D2m0EDwL+hB5UauiXDkzshu2ZoRUmn1t/W2oIWfaSDg4BvgZueRC/a/78pJ1IR/MSHKaycz640Bc3jH3UbuOkQ2eWXZD9KvQ/HqHTCB0oIfo+Lu3Jlo1idWZdBIpyzmxSoW5BwjUr7J0oJc/0FJ7KmKjrm/wMnCMr7+Sw3kHH+zWzJ7uCQr95CTfqgQ9bc220jjq3v1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(6486002)(6666004)(316002)(6636002)(478600001)(66946007)(66476007)(66556008)(4326008)(31686004)(41300700001)(8676002)(31696002)(38100700002)(5660300002)(8936002)(2616005)(36756003)(2906002)(86362001)(26005)(83380400001)(186003)(6506007)(6512007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW1kZDN6MmdVWktDZGUrVERVYUhnY1MzZ2MwMTZPZ3A5T3BpbVJtakZEYW9v?=
 =?utf-8?B?NXJTa1VTR0tRQnhuTWtnV2FsYXRsM2dQQVI4b2kxQVBxdzVxQVk1blJTSlRF?=
 =?utf-8?B?YWJqK1FzaDdTNjBTZ3hCOThHWFN1NlpKZ0RucldtaGtKQk5mV3RKKzE4Zysr?=
 =?utf-8?B?QW5HSU9nZUhMT2pMMGhlWlk0ODlKb2U4M2t3eWpDMjBrUXFYT1VGZkNqamUw?=
 =?utf-8?B?UHh3ZG91a2hNZDN4Rzk2WjIySy9BVXlSN05jQWpzdUFjbVdrNWZqNmhHSG1t?=
 =?utf-8?B?bi9JOVBoSnFQK0h4R05UOTl4TVdKQmltL1Q2ZklrTk5SRWZBb0VjTnNVNUFM?=
 =?utf-8?B?QkNBRXQwRTRHbElkT1c3ME84a0hHeEwrSERhemV5T21PejAyZDN0dDZ3NEN6?=
 =?utf-8?B?dzduZC91MndXSHhlNElua24vOEdLdEdOOFdIcFZNeDU4bHdQcmRXMExadWVn?=
 =?utf-8?B?QU5Eb0w0ZENBUFFTU1V3ZjFkQytySVRqYm53TFpUdlp2ZHVlcjZpUFJZRTJY?=
 =?utf-8?B?VEZTZU5XRVVJRUREbStNZE5PSXpmcGVTVnVEVzQzcUJkVi8rQVFtYnVVdmVK?=
 =?utf-8?B?L3N4T0Q1aGNxUHIxdElpeFRNLzlNaU5VcXh2cXZOaGwyWEsvUytjY2d5UDd5?=
 =?utf-8?B?eUNJSnY3RVFkb0JQRE1JKzJSaWs0MUtaU3JJNGIrczVVWWdOQjRRdk9jbGtm?=
 =?utf-8?B?ZXNiTnVQRldMako4bmIwbmhBTmttdUt2T0RXaHY1cXZUem5YUXo2WmFPa0oy?=
 =?utf-8?B?cXJuTWlZQmNHQWxLSnUrQjdheElsN1V1Nm9GSjlUUnRXTnNMTG1yU2Y2V2ti?=
 =?utf-8?B?MkVrOWFXbStZUnZLVDFKYXVWUWs0cXlFcDVOR2VZSzcwVEF5VXN4WEZCK3h1?=
 =?utf-8?B?NE9ydlgra3VhZ2tqTzVBQlZSZ2pKdGlZWk9vTW54NW4zZEtyN3pabnhsMVh4?=
 =?utf-8?B?SGRuTitXMWhkbWswRkxnbnlwTTlEZzk3TDhPL1BETno1NVd6Y0V4UU1nSk5h?=
 =?utf-8?B?UUpTTGoyQzRoVjBjakdpM3ZHZ0M0QVJ2TjJDT1VRKzBLbTJIRTNVUmNCcnpn?=
 =?utf-8?B?eFZEVzA1U0VOQ1U5d3I4b0s3eFZEdmtVRlJEK0xDV203YXBJUnI5MHFSU0ht?=
 =?utf-8?B?UmwxWmpCdGJXRmxYR0wwbnp1Q1FuUDJFUndvZHN5MU5VUlprSE82MnJOVDds?=
 =?utf-8?B?THo0VTJPblBUMnBLQWw1bUtDSXBOT0wxMVljL3ArUkt3NytkTkRoUyttWVEr?=
 =?utf-8?B?QWRzc2V4SUdMdkRqelhrN3hoaTdUSE1IVS9CRGRsZ3BCRHhTT1c4cmJ3UW54?=
 =?utf-8?B?RzlNTjNBbGFPbm9wVjROVHpJNmo5dUhPQks3dnJhaUJXZ3c3QmptNHV6TWxo?=
 =?utf-8?B?NjVkUHNzRmFRb0hENytjckVNdHM4b3crZW40R1V3RGNjK1dGZnVVMlpFa2d2?=
 =?utf-8?B?aUxsenNlM0lyc2drS3FwekUzRDFkZk9Fd243ZUgwdUttZXR4TkdoUXNzdFJj?=
 =?utf-8?B?TEE1TmFQZmxqN3M2NzZQRlNSa3YvQmFYYXRCRUlGUE1SNXNaN1Azb0U1S1ZM?=
 =?utf-8?B?VFE3eWtWRGN4cXRsY2hjQThBUjhHTGlvamhacWl4Sy95T3BtQXVpRVVrN3ZB?=
 =?utf-8?B?M2dPOHpoeVlpUDRIY2I3UTZLSlN6anQvN2EwMGhMNjZZNzJraWo2cTVGbE4y?=
 =?utf-8?B?TXVZRkJ3RUtDY3hseWF4WktGMVpVUjlPWHVlVGIwS3cya3RwOVBORjVPcUhO?=
 =?utf-8?B?OVp5Ym0vYVlzZHRvMjRFWFhrZzlMTW5RdlJlQlRqWDYxVFpTVGg1ay9aa1lG?=
 =?utf-8?B?eXVjenlsV2xJRXBJbTRuSjg5a3RhYVIyQ29kYWROeEU4OElDZG1aLysyNUFX?=
 =?utf-8?B?S1NaZDFPRFladGlYMmVZdXN5dDJ6RVIvdXp0Q1R0RlJOaklJNGpRaWRNeENw?=
 =?utf-8?B?UVRGc3B5QmxRSTBCcUpxOElmOCtiNmQ2eWNKQytBaGQzaEc5S21leUx2NERq?=
 =?utf-8?B?TUthRzhlbnNUMTdoQVVxckpGWXNCNWcrbzNrRGF6cDgrTG5TZmxMNVQ0YmV1?=
 =?utf-8?B?b3ZFd2RoTTRCOWZaUUYxM3RxVGpDUit2Zytid01vS3h6ZFd3d0tUVEVCTmVK?=
 =?utf-8?Q?GxU6R2uFv7MEOi2dLo46Zk+OQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db47340d-fdeb-448f-a9a7-08db36a876c8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 14:08:58.0048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6x4oEmGCFEtVSyMCh2lXhKEjlHqvGwQVTNFYkll5dUvOjmUDiRMhEa8DEJUGXBWpIajnMJiQ/QqhbAJH+H2/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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
Cc: kunliu13@amd.com, ying.li@amd.com, weiyuan2@amd.com,
 amd-gfx@lists.freedesktop.org, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/6/2023 07:45, Wenyou Yang wrote:
> Add a timer to poll the SMT state periodically, if the SMT state
> is changed, invoke the interface to notify the PMFW.
> 
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 ++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 44 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  5 +++
>   3 files changed, 57 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 09469c750a96..fc571c122e87 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -566,6 +566,9 @@ struct smu_context
>   
>   	struct firmware pptable_firmware;
>   
> +	bool last_smt_active;
> +	struct timer_list smt_timer;
> +
>   	u32 param_reg;
>   	u32 msg_reg;
>   	u32 resp_reg;
> @@ -1354,6 +1357,11 @@ struct pptable_funcs {
>   	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
>   	 */
>   	int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +	/**
> +	 * @set_cpu_smt_enable: Set the CPU SMT status.
> +	 */
> +	int (*set_cpu_smt_enable)(struct smu_context *smu, bool smt_enable);
>   };
>   
>   typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 3ecb900e6ecd..b0e0c6664ac3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -26,6 +26,7 @@
>   #include "amdgpu_smu.h"
>   #include "smu_cmn.h"
>   #include "soc15_common.h"
> +#include <linux/sched/smt.h>
>   
>   /*
>    * DO NOT use these for err/warn/info/debug messages.
> @@ -1058,3 +1059,46 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
>   
>   	return snd_driver_loaded;
>   }
> +
> +#define TIME_INTERVAL	200
> +
> +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
> +{
> +	int ret = -EINVAL;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
> +		ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
> +
> +	return ret;
> +}
> +
> +static void smu_smt_timer_callback(struct timer_list *timer)
> +{
> +	struct smu_context *smu = container_of(timer,
> +					       struct smu_context, smt_timer);
> +	bool smt_active;
> +
> +	smt_active = sched_smt_active();
> +	if (smt_active != smu->last_smt_active) {
> +		smu->last_smt_active = smt_active;
> +		smu_set_cpu_smt_enable(smu, smt_active);

You're ignoring the return value for smu_set_cpu_smt_enable.  If the 
message failed to send that means smu->last_smt_active will have the 
wrong value and the message will never attempt to send again while in
this SMT state even though the timer triggered again.

I think you should do it like this:

if (!smu_set_cpu_smt_enable(smu, smt_active))
	smu->last_smt_active = smt_active;

> +	}
> +
> +	mod_timer(timer, jiffies + msecs_to_jiffies(TIME_INTERVAL));
> +}
> +
> +void smu_smt_timer_init(struct smu_context *smu)
> +{
> +	struct timer_list *timer = &smu->smt_timer;
> +
> +	smu->last_smt_active = sched_smt_active();
> +
> +	timer_setup(timer, smu_smt_timer_callback, 0);
> +
> +	mod_timer(timer, jiffies + msecs_to_jiffies(TIME_INTERVAL));
> +}
> +
> +void smu_smt_timer_fini(struct smu_context *smu)
> +{
> +	del_timer(&smu->smt_timer);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index d7cd358a53bd..928dd9e30d83 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -127,5 +127,10 @@ static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
>   
>   bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
>   
> +void smu_smt_timer_init(struct smu_context *smu);
> +
>   #endif
> +
> +void smu_smt_timer_fini(struct smu_context *smu);
> +
>   #endif

