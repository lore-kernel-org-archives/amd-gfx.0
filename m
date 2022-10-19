Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B1BC43217
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 14:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F0F10F24F;
	Wed, 19 Oct 2022 14:41:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A42110F24C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 14:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVAMZ8MSHv0j21mWMIT3q25N/rfcOjcpAgBMs8PFBcziQ9qpe71CbXAh8KU49mzfhjsHgGRunIbCA5BjYxohL7s4masMZ5nUcC+mTrg3S1iL+2XHIgNx0Ka1xOBQIHpmfGn9SlEiqB70Rz2LSJLKZP2/q8BC/2Aq+TeIiJk8HUkdBkM5xdCzHH0v2jY39zwEv5sSdOWV3ez7ZqGeob9nB3YAT+9LCFEEKcVylqx/25jN8hFUcZjnniY2gFa/430Xtc3qUOdo0e53y+Gn/RRlYiV4saHVyqTEByARhYWOm2bgKakV48ptMshErX4eA4Jm0D3RJR6alnr6IgkDInsonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GHgOyfxXxEf123JEJhD/bZsfIoK5QByDF5cmIljiaU=;
 b=j+epfp0z6w08/qgVVIFPNP0zU4vVQok0NRUtZ/oxyqM6XTjV35opBx33dxsynpFPm1TYTT8Z0C/6zimlEsab3SdMCycl3OWQilhvEXgAX/WGLUENPwdLINce8IL3FqiYMxXjaB190x1AKNfAGU//6Z33iBBjc9TPPOqWs0SrX862VJL6uITQrgCv1RjK1BCPxZzLoBpt9VcNXJthiavQKGCJE6RtdSSxDlHEPLJieYM3rN+kxwWf5WaM6LbtyuYfzRJTAhjbMoVr9Y2+u6RNJqTx+RmeskaWZDheHL6J3tRInUmeBXP/MLbYuGsRzhr6GWhhdl5gB9sm19kiserqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GHgOyfxXxEf123JEJhD/bZsfIoK5QByDF5cmIljiaU=;
 b=4V1+c1iuGSivSfIbcLz1x8qlrz6DdOOOf4pqrdny1Rk2QGrCm8VhFef9yLqpzcSTrVviok00XT3yMq2klYLWnbH005/KIOf7crg/XuDCBdZ/OQbxqw3yeM5l2ZkJsCsfwiPklsMt3kvCSjc1pS7UmkYGf4qR3qh+A1MLfWZ9Tjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 14:40:57 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::8bd3:e54b:2f15:989d]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::8bd3:e54b:2f15:989d%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 14:40:57 +0000
Message-ID: <68fdee87-ca03-db91-62b8-fa6123140a80@amd.com>
Date: Wed, 19 Oct 2022 10:41:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/amd/display: Rework comments on dc file
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221018202759.1999835-1-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20221018202759.1999835-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:610:56::21) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: f6054cb9-f20a-4b80-6b4c-08dab1dfeeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVcxXHLbKUW/09eYJ9A+jSWy484rtmiMklJV53YiHO6tQGx6tDNololpIlIMkTBW4WRaIEIsLSginXHTaSOMdWBEvkWrWa4leEsdNfILpAKoc4rmfAUiKHlx6TOv1vuQInpyL/YFqu4gxsDGphQBSD7aZ4t8Bb2aKum7dA7M82RImw5jd1nEOqj2g+iUURsj6C5how1nX8qbm8PArl4ML7JB3SiXSY6UQWkPlmi72YcJqIR/fittsOrZ+QpENZjP5f/uCcA90jRrL+Ak0AAxRHUxnayS9H0oM5Jr/ExkCPnD3qvf1fm4XDjSyL+TO5mhveuRICCMRt6YxQqjLDMHPOZBDgYenhN7O9tV81lRMsY3jKnpA9ISc3RknWkOKf+Sq92BJjNzvnCOr6rmt4ULEu7vXw5YJPE/xkcpXi/2B639FUZCUu6VKvOa8i8FRqATqtlD8GGlKi3Qrs97rS6qnGNByOfy5saIk4x8QcGLiK811Lcpb87jHlU1agI34M/koCPQFA06R0yzZSfGZVj3W7eEgrtVFWXuaBiIvYlyhvg/AIkAfDtwMtGgc0N8jALbwcawLlFMWqGixKd7LfZs/a6NYQaHn7gDAdM1A9xlk+lQB+SN5BGUHxjThZH3kM6ss69z9OGgEGjTBe0LoV9C7bt02ZC3Cn8kZWhnUtpeGe9gBjZLHoEHNKCM47jQzj8GUSVPFP8b/AkJZQSdK3mSxW3B5ZNZsTqBgYCAzsEbfD81tW3QsbkM9VAhFZrzSTIHn8oIYA4VVrmMIGCGvJ+/0thfBYRa7k4QCnC+8xwSd0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(53546011)(2616005)(6506007)(66476007)(26005)(66556008)(66946007)(8676002)(30864003)(2906002)(4326008)(316002)(4001150100001)(44832011)(41300700001)(36756003)(8936002)(478600001)(6666004)(31696002)(5660300002)(6486002)(6512007)(31686004)(86362001)(83380400001)(186003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDZMZzZ5VVBnTmk2T2xzZEo1dnNyeFU5ZHVRdW9qZ290ZVlWVEtXTEJMMUQ1?=
 =?utf-8?B?K3FtOU5mVVVoc3RiaVhTditGZ3h4NTA4M3hKdXpvbHBsUE00SGJoZHBTbC9X?=
 =?utf-8?B?UzBtaE1ZYzF2QXY0cmpXbnRnUXBGRmd2Wk5oV0MyTWFTUG81TmVLeXQyTDVH?=
 =?utf-8?B?MGVFSGJFSVpBR2JwSjZIUGh1dllKNXBBNDUrL3c4Y3d6NDdtbnV3R3pYSXBx?=
 =?utf-8?B?bkRSMnpuUVZUM3NXVVpRaTZKQkNTWkErSGRaeHl1cDAvN3U0ajlsSURNY01J?=
 =?utf-8?B?K01QZEZLTTVWRE9WN3RBWmZlMElwNU9NZlE3Z0VkN21OWVlNVUpqRGk5OXlQ?=
 =?utf-8?B?MXVnb29hQ05yMWlYUHZURXI1eE85Ukd3TmkrakE3MkkrMjAreEZpQU1mL0s2?=
 =?utf-8?B?YWtnUjVyeDBsVGdPWVpkVUlzTkFkdmVWMGZ4SjdiV2U2Z0VJcFdvTWpoYjQ2?=
 =?utf-8?B?NWpLSXR0MjRMNXhsM1dYQldObldoZkRpWE1qSDViYllVSkRDVjlzQnppUWdr?=
 =?utf-8?B?NWIwUDl6d3M5MWdkYkRFZnNSeFJJZUN0SG16SnZlWkhiNXpsOUdsSWpURUpz?=
 =?utf-8?B?OTNzaWRCbTZaRi9oa2JiamdLcG5tdkNKbGViK05iMVpBRFhwSkt0ZXNicEwx?=
 =?utf-8?B?Nzd5U3QvTEIxRHJHUXRGdmdlWUhNdUp6a1BDdG9YTXI5ZWRiWE5RdVVveDB1?=
 =?utf-8?B?U3FEQ2RlMmJ3QzJpTElpcFZURWk2bjlDNlpPcTN6azR5c25TNlQydDRZUVdB?=
 =?utf-8?B?TFBzdTNoSlNoblZVemovdko1Z1FEbTlvdXlOSVFuS1JMRFQycE1BMXFTazQv?=
 =?utf-8?B?cFJBSmVsWFZZSEN2Qm95N0Q1eVN5ZnFsUktyaU1INGhwaDRWWHBjaTVGNXY1?=
 =?utf-8?B?eEdTdmVGOG1pbk4vMHpVSDhDb2FYY0o1ODI4WnVUTnFkQno2VGpVamV0YXdm?=
 =?utf-8?B?eGhoSXJ6SGUrUGR2RUZjMU5vN2hNczNPZmZxakF0SmtpcVBKR1VtbU82M3BD?=
 =?utf-8?B?V3NVdmFjaDRscFlkSGIvLzExMHdvb01kUTd6am51b0Y2YSs1WmVHWEdHeWtF?=
 =?utf-8?B?WCtZVndiYk5kcldnQkFQUVR1R0UzR09EV09zMjNEUmtjOXVVK2lkSENFYXo1?=
 =?utf-8?B?RDFoVndTL3lQMHd3NzkzUEt2STg4UTdMWVVhbTNyTzNKRUpsWHlxakMwcm5Y?=
 =?utf-8?B?bUFzaUVxVzZVbXNxbXFMZXdEaURBTi83T0dwTGpvWFZQc3ZwWlZPcDBRTUE0?=
 =?utf-8?B?OE5xMng4RDEvWWdJOUpEWlBlcW5OYkpBTzEzWEpoUlhXSDFMekpuNDZIZUY2?=
 =?utf-8?B?M3dOOTkydnlkVmVzMThaZWwyTndzcTAwZUJTRUxXQ2tVN1lrcEJnaG8rTXc1?=
 =?utf-8?B?Q1pZZWJHbmFEMDZZZGgyR0taUUU1UzlTTVNmSHRmaS8xZExqcUZDajVwQUFq?=
 =?utf-8?B?VEFxa2psQmlHcHNDajJWZDNoazlveDFmT3VJUWhrMDdCOUVYbmtOQUlTNzRQ?=
 =?utf-8?B?TSt2MHJKWVRlNlBFQ3d3NFppbHlzajAvSVJPTkttR0liY2NEV3dmZU5haHFQ?=
 =?utf-8?B?U2NYemVaa3gxMWt3bm1UN1laNEJXTXlEYkJUcTAvQm9kaW9mdFYwSGlMS3dE?=
 =?utf-8?B?MzcrMUxnRVpocHh5bCtsMGdXWVNhUTQzTml2UW9VNVAzSVhxNTVMWU1JOXls?=
 =?utf-8?B?TWhRT0dvTFVsMzc4cC9xQmIxQWR4OWY4UWUzS3ZwSGJIcW9ObnNPSHhrRnNS?=
 =?utf-8?B?cVkzY0h2TU81TktpNElFRU9URFA4UFNrYnRuTkhIR2swM0s4WVc2SlRiQk8y?=
 =?utf-8?B?NnJpM1FsTDhJbGhiTzlyVTRER05zaVlHYjJtZHJQbm4rcEQ0eXJKWmtQUTcv?=
 =?utf-8?B?TlhFN1duci83RjgzcXpEQmk5S1pqVlVJRWpTd1k1c0JkZFVMKzRLNTdScFpt?=
 =?utf-8?B?WkdJZ3R3SjV2cnF5NFZrQWcwbjVBckxOZ04vdXR3RVkrTzQrRDdBcEt4R2I2?=
 =?utf-8?B?MjA3cW1FaFJmV0RaSHhJTEUyTEpBSTRXZFRMdEEweGp6dEZDckdDcGpqNU5F?=
 =?utf-8?B?dEpYRGZzVCtVSitjM3ByaXNRdFVkOXY5aTN5OGdzejdnQkR4c1YrZGZ6OEtR?=
 =?utf-8?Q?XJSSW4630qQmN+7rUyyIuqEqM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6054cb9-f20a-4b80-6b4c-08dab1dfeeda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 14:40:57.0868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6l15IX8gb0wJL82jYRS8pCwlv8JSHWMpVz+rrTkgR4imPfJI/ptX8o556df2kRRIRuVTUaESxmlHS1V7Pgy6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
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
Cc: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-18 16:27, Rodrigo Siqueira wrote:
> The file dc.c has multiple comments that do not follow the kernel-doc or
> are made in a distracting way. This commit alleviates part of this issue
> by reorganizing some comments inside the dc file.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 161 +++++++++--------------
>   drivers/gpu/drm/amd/display/dc/dc.h      |  32 ++---
>   2 files changed, 70 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 2858917a66be..d446e6098948 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -135,9 +135,7 @@ static const char DC_BUILD_ID[] = "production-build";
>    * one or two (in the pipe-split case).
>    */
>   
> -/*******************************************************************************
> - * Private functions
> - ******************************************************************************/
> +/* Private functions */
>   
>   static inline void elevate_update_type(enum surface_update_type *original, enum surface_update_type new)
>   {
> @@ -421,18 +419,14 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
>   }
>   
>   /**
> - *****************************************************************************
> - *  Function: dc_stream_get_last_vrr_vtotal
> + * dc_stream_get_last_used_drr_vtotal - dc_stream_get_last_vrr_vtotal
>    *
> - *  @brief
> - *     Looks up the pipe context of dc_stream_state and gets the
> - *     last VTOTAL used by DRR (Dynamic Refresh Rate)
> + * @dc: [in] dc reference
> + * @stream: [in] Initial dc stream state
> + * @adjust: [in] Updated parameters for vertical_total_min and
>    *
> - *  @param [in] dc: dc reference
> - *  @param [in] stream: Initial dc stream state
> - *  @param [in] adjust: Updated parameters for vertical_total_min and
> - *  vertical_total_max
> - *****************************************************************************
> + * Looks up the pipe context of dc_stream_state and gets the last VTOTAL used
> + * by DRR (Dynamic Refresh Rate)
>    */
>   bool dc_stream_get_last_used_drr_vtotal(struct dc *dc,
>   		struct dc_stream_state *stream,
> @@ -1209,9 +1203,7 @@ static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
>   	PERF_TRACE();
>   }
>   
> -/*******************************************************************************
> - * Public functions
> - ******************************************************************************/
> +/* Public functions */
>   
>   struct dc *dc_create(const struct dc_init_data *init_params)
>   {
> @@ -4552,21 +4544,17 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
>   		dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching_shut_down = true;
>   }
>   
> -/*
> - *****************************************************************************
> - * Function: dc_is_dmub_outbox_supported -
> +/**
> + * dc_is_dmub_outbox_supported - Check if DMUB firmware support outbox notification
>    *
> - * @brief
> - *      Checks whether DMUB FW supports outbox notifications, if supported
> - *		DM should register outbox interrupt prior to actually enabling interrupts
> - *		via dc_enable_dmub_outbox
> + * @dc: [in] dc structure
>    *
> - *  @param
> - *		[in] dc: dc structure
> + * Checks whether DMUB FW supports outbox notifications, if supported DM
> + * should register outbox interrupt prior to actually enabling interrupts
> + * via dc_enable_dmub_outbox
>    *
> - *  @return
> - *		True if DMUB FW supports outbox notifications, False otherwise
> - *****************************************************************************
> + * Return:
> + * True if DMUB FW supports outbox notifications, False otherwise
>    */
>   bool dc_is_dmub_outbox_supported(struct dc *dc)
>   {
> @@ -4584,21 +4572,17 @@ bool dc_is_dmub_outbox_supported(struct dc *dc)
>   	return dc->debug.enable_dmub_aux_for_legacy_ddc;
>   }
>   
> -/*
> - *****************************************************************************
> - *  Function: dc_enable_dmub_notifications
> +/**
> + * dc_enable_dmub_notifications - Check if dmub fw supports outbox
>    *
> - *  @brief
> - *		Calls dc_is_dmub_outbox_supported to check if dmub fw supports outbox
> - *		notifications. All DMs shall switch to dc_is_dmub_outbox_supported.
> - *		This API shall be removed after switching.
> + * @dc: [in] dc structure
>    *
> - *  @param
> - *		[in] dc: dc structure
> + * Calls dc_is_dmub_outbox_supported to check if dmub fw supports outbox
> + * notifications. All DMs shall switch to dc_is_dmub_outbox_supported.  This
> + * API shall be removed after switching.
>    *
> - *  @return
> - *		True if DMUB FW supports outbox notifications, False otherwise
> - *****************************************************************************
> + * Return:
> + * True if DMUB FW supports outbox notifications, False otherwise
>    */
>   bool dc_enable_dmub_notifications(struct dc *dc)
>   {
> @@ -4606,18 +4590,11 @@ bool dc_enable_dmub_notifications(struct dc *dc)
>   }
>   
>   /**
> - *****************************************************************************
> - *  Function: dc_enable_dmub_outbox
> + * dc_enable_dmub_outbox - Enables DMUB unsolicited notification
>    *
> - *  @brief
> - *		Enables DMUB unsolicited notifications to x86 via outbox
> + * dc: [in] dc structure
>    *
> - *  @param
> - *		[in] dc: dc structure
> - *
> - *  @return
> - *		None
> - *****************************************************************************
> + * Enables DMUB unsolicited notifications to x86 via outbox.
>    */
>   void dc_enable_dmub_outbox(struct dc *dc)
>   {
> @@ -4718,21 +4695,17 @@ uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
>   }
>   
>   /**
> - *****************************************************************************
> - *  Function: dc_process_dmub_set_config_async
> + * dc_process_dmub_set_config_async - Submits set_config command
>    *
> - *  @brief
> - *		Submits set_config command to dmub via inbox message
> + * @dc: [in] dc structure
> + * @link_index: [in] link_index: link index
> + * @payload: [in] aux payload
> + * @notify: [out] set_config immediate reply
>    *
> - *  @param
> - *		[in] dc: dc structure
> - *		[in] link_index: link index
> - *		[in] payload: aux payload
> - *		[out] notify: set_config immediate reply
> + * Submits set_config command to dmub via inbox message.
>    *
> - *  @return
> - *		True if successful, False if failure
> - *****************************************************************************
> + * Return:
> + * True if successful, False if failure
>    */
>   bool dc_process_dmub_set_config_async(struct dc *dc,
>   				uint32_t link_index,
> @@ -4768,21 +4741,17 @@ bool dc_process_dmub_set_config_async(struct dc *dc,
>   }
>   
>   /**
> - *****************************************************************************
> - *  Function: dc_process_dmub_set_mst_slots
> + * dc_process_dmub_set_mst_slots - Submits MST solt allocation
>    *
> - *  @brief
> - *		Submits mst slot allocation command to dmub via inbox message
> + * @dc: [in] dc structure
> + * @link_index: [in] link index
> + * @mst_alloc_slots: [in] mst slots to be allotted
> + * @mst_slots_in_use: [out] mst slots in use returned in failure case
>    *
> - *  @param
> - *		[in] dc: dc structure
> - *		[in] link_index: link index
> - *		[in] mst_alloc_slots: mst slots to be allotted
> - *		[out] mst_slots_in_use: mst slots in use returned in failure case
> + * Submits mst slot allocation command to dmub via inbox message
>    *
> - *	@return
> - *		DC_OK if successful, DC_ERROR if failure
> - *****************************************************************************
> + * Return:
> + * DC_OK if successful, DC_ERROR if failure
>    */
>   enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
>   				uint32_t link_index,
> @@ -4822,19 +4791,12 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
>   }
>   
>   /**
> - *****************************************************************************
> - *  Function: dc_process_dmub_dpia_hpd_int_enable
> - *
> - *  @brief
> - *		Submits dpia hpd int enable command to dmub via inbox message
> + * dc_process_dmub_dpia_hpd_int_enable - Submits DPIA DPD interruption
>    *
> - *  @param
> - *		[in] dc: dc structure
> - *		[in] hpd_int_enable: 1 for hpd int enable, 0 to disable
> + * @dc [in]: dc structure
> + * @hpd_int_enable [in]: 1 for hpd int enable, 0 to disable
>    *
> - *	@return
> - *		None
> - *****************************************************************************
> + * Submits dpia hpd int enable command to dmub via inbox message
>    */
>   void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
>   				uint32_t hpd_int_enable)
> @@ -4863,16 +4825,13 @@ void dc_disable_accelerated_mode(struct dc *dc)
>   
>   
>   /**
> - *****************************************************************************
> - *  dc_notify_vsync_int_state() - notifies vsync enable/disable state
> + *  dc_notify_vsync_int_state - notifies vsync enable/disable state
>    *  @dc: dc structure
> - *	@stream: stream where vsync int state changed
> - *	@enable: whether vsync is enabled or disabled
> + *  @stream: stream where vsync int state changed
> + *  @enable: whether vsync is enabled or disabled
>    *
> - *  Called when vsync is enabled/disabled
> - *	Will notify DMUB to start/stop ABM interrupts after steady state is reached
> - *
> - *****************************************************************************
> + *  Called when vsync is enabled/disabled Will notify DMUB to start/stop ABM
> + *  interrupts after steady state is reached.
>    */
>   void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable)
>   {
> @@ -4914,14 +4873,18 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
>   	if (pipe->stream_res.abm && pipe->stream_res.abm->funcs->set_abm_pause)
>   		pipe->stream_res.abm->funcs->set_abm_pause(pipe->stream_res.abm, !enable, i, pipe->stream_res.tg->inst);
>   }
> -/*
> - * dc_extended_blank_supported: Decide whether extended blank is supported
> +
> +/**
> + * dc_extended_blank_supported 0 Decide whether extended blank is supported
>    *
> - * Extended blank is a freesync optimization feature to be enabled in the future.
> - * During the extra vblank period gained from freesync, we have the ability to enter z9/z10.
> + * @dc: [in] Current DC state
>    *
> - * @param [in] dc: Current DC state
> - * @return: Indicate whether extended blank is supported (true or false)
> + * Extended blank is a freesync optimization feature to be enabled in the
> + * future.  During the extra vblank period gained from freesync, we have the
> + * ability to enter z9/z10.
> + *
> + * Return:
> + * Indicate whether extended blank is supported (true or false)
>    */
>   bool dc_extended_blank_supported(struct dc *dc)
>   {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 0757ca449290..d9f510b4e848 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -56,9 +56,7 @@ struct dmub_notification;
>   #define MIN_VIEWPORT_SIZE 12
>   #define MAX_NUM_EDP 2
>   
> -/*******************************************************************************
> - * Display Core Interfaces
> - ******************************************************************************/
> +/* Display Core Interfaces */
>   struct dc_versions {
>   	const char *dc_ver;
>   	struct dmcu_version dmcu_version;
> @@ -1000,9 +998,7 @@ void dc_init_callbacks(struct dc *dc,
>   void dc_deinit_callbacks(struct dc *dc);
>   void dc_destroy(struct dc **dc);
>   
> -/*******************************************************************************
> - * Surface Interfaces
> - ******************************************************************************/
> +/* Surface Interfaces */
>   
>   enum {
>   	TRANSFER_FUNC_POINTS = 1025
> @@ -1363,9 +1359,7 @@ struct dc_state *dc_copy_state(struct dc_state *src_ctx);
>   void dc_retain_state(struct dc_state *context);
>   void dc_release_state(struct dc_state *context);
>   
> -/*******************************************************************************
> - * Link Interfaces
> - ******************************************************************************/
> +/* Link Interfaces */
>   
>   struct dpcd_caps {
>   	union dpcd_rev dpcd_rev;
> @@ -1467,9 +1461,7 @@ struct hdcp_caps {
>   
>   uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
>   
> -/*******************************************************************************
> - * Sink Interfaces - A sink corresponds to a display output device
> - ******************************************************************************/
> +/* Sink Interfaces - A sink corresponds to a display output device */
>   
>   struct dc_container_id {
>   	// 128bit GUID in binary form
> @@ -1552,9 +1544,7 @@ struct dc_cursor {
>   };
>   
>   
> -/*******************************************************************************
> - * Interrupt interfaces
> - ******************************************************************************/
> +/* Interrupt interfaces */
>   enum dc_irq_source dc_interrupt_to_irq_source(
>   		struct dc *dc,
>   		uint32_t src_id,
> @@ -1566,9 +1556,7 @@ enum dc_irq_source dc_get_hpd_irq_source_at_index(
>   
>   void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable);
>   
> -/*******************************************************************************
> - * Power Interfaces
> - ******************************************************************************/
> +/* Power Interfaces */
>   
>   void dc_set_power_state(
>   		struct dc *dc,
> @@ -1641,14 +1629,10 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
>   void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
>   				uint32_t hpd_int_enable);
>   
> -/*******************************************************************************
> - * DSC Interfaces
> - ******************************************************************************/
> +/* DSC Interfaces */
>   #include "dc_dsc.h"
>   
> -/*******************************************************************************
> - * Disable acc mode Interfaces
> - ******************************************************************************/
> +/* Disable acc mode Interfaces */
>   void dc_disable_accelerated_mode(struct dc *dc);
>   
>   #endif /* DC_INTERFACE_H_ */

-- 
Hamza

