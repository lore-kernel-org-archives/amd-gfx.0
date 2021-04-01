Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F2C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCB36101E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCB36101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 693426E02C;
	Thu,  1 Apr 2021 19:19:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971D66E02C
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 19:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnMGrmQmIBYLM9FkUvtEgrX18wglTAuOk8oCMf8CMyiI0hX6/XoU9al3l9l2w0JVd9YZ6hEqPmuUs8Liwbnf0Kzg3dteR56D1vC4JG4MiRuWnyiMjQD4/Oeu8LLIIFGkhMTQeKcRnO3AHGGtj4A2rBuXTYM79Re3aJwXYHKsY4cn55u3ytMSepPj+/HBngXdMsP3+teBMFJa1ITrx4z1f0tz0Bw7fQl+mz6fNiaxGSEHyYAGMxY98By/RbPXtDXOqVBQXtrHvEB62o8FBySFslEnilmURPYOyuhNLdNWVpfdjhKWAPzq0jIs857DwqVjoIm13QK1csgxuaEYdqe8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFckzwPwqXvh6YvPq9QPv9UaKvxApz6vM4yG1xbmIgY=;
 b=AnmbiF+lvlV7LDYfYCDfsCqPlbJFx8eQq6aBoRxAyd/iCb69k7bXeMZ0NF8Kda35ENnWmbXiihOdnF4qAFcFDFX2M9aDzW/c+KNYU9g+HHLxUCBAe9+tHiDklbrY8h+cGSru+R1Btb9HrgYxrSgWq+nZZyPXuD+1hrtc3QDChJipObVhTwfoJGYW7+HeAdgt808T7GDu25qCES/dfPsrxC9SL/yrf5+Ua0vnHuQTMa1q0Ki9xG0VEg+qFUh7BvXlN3mvDnnT2Pk3fzeI+k+XGsj+vL2DRU853gugDgVuk3AATRBd0mQKf2JkFPrYqhvmsL0PqOQGWlFl9hovI/FAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFckzwPwqXvh6YvPq9QPv9UaKvxApz6vM4yG1xbmIgY=;
 b=PepG86vNt41JsXb9vGCRkJUlY41vlqYBo6YtUTU1bq8Jsy1PBC/UcvX8QDnSxmY4rOlA1SK3/iUF9rIocZtDwXKOsW/HCy0KS3aM41zLLyApqo1q+hrpQ9WtWDxfzGz0eKTk9Q9vFfbXuu02yYkS26wh+6X34avuOBKEj1odfhc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1902.namprd12.prod.outlook.com (2603:10b6:300:10d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 19:18:53 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%8]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 19:18:53 +0000
Subject: Re: [PATCH] drm/amdgpu/display: guard ttu_regs with
 CONFIG_DRM_AMD_DC_DCN
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210331022810.2590493-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <d36aaabc-6bda-9757-a99b-31c1088a373f@amd.com>
Date: Thu, 1 Apr 2021 15:18:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210331022810.2590493-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::29) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32 via Frontend
 Transport; Thu, 1 Apr 2021 19:18:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45eb3093-da49-49f5-7556-08d8f542fd09
X-MS-TrafficTypeDiagnostic: MWHPR12MB1902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB19028D5A485D0BCAE22DD4CD8C7B9@MWHPR12MB1902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQSQ7u4aXmRGfOJOprUoByNOaWFeI2rPLGaFTcTHoIWif58VvSg+3iZsQdr9Ac+5xsBUcbIKJxSa7DnbSWWoaoNSGvp4sc5vp6L8bx7TDoZobyVRL5oTpW2pbb2H+ZqoDryoScAmiC7eiDoAAb96WlKuhFmjQwzhr9ohOWERRZADiq867M6dUgn6JJtqcStwUZDnlURrTLch++j4kyhLRQPt7N3p7j5JzK5Ks8RvXfdnrLGvmZ2XSL6vIrDsoDh0NYUreU79WDhtvL4ix5rpJ8Te//k/kqdXZVn3yGZh+grFJsZJNmm3jF/L5zFFdLWjqe0icS4hUpzB0uPs7QJX+bamPkQn1KgrpueNzDhz3DERZ9DyOkpv1E+53EJtRsOaBqx9Z9DlhZGgYaaMrTtZ9gOYLa+pIQv+VdlE5ZvfWNUxl/wis/2dyz9m064052j9CcCkRmi697CnjEa/IE2ce6Y9XixyHCAkJGcT2FOjvWmo5gBrWNf1WLvZFkUUMnQZ+dkHbFZDdUkPLKF6JCRY+fXVImMDCKf1XIJE4Lq4ct5+sm5nZZe9rRhYUngNbedzTKp2k1HJbZQet7FrPg1BqnCr853K6iUH+iB9YpsmwUJg/oTSGsS+AVucdOCLLWA02agj/vJVvwWGCbXHAJWNb0+NWR0LdaY45fYainRantzgrygyQH9k+2ZSmy4CQzZOHBd8JdWkH7EK+31ssswGoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(2906002)(4326008)(66946007)(66476007)(5660300002)(66556008)(38100700001)(956004)(2616005)(16576012)(8936002)(36756003)(478600001)(31686004)(83380400001)(54906003)(44832011)(26005)(186003)(6486002)(53546011)(31696002)(8676002)(86362001)(16526019)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDB2UkJuMEtBblQwZ1AxRlJlLzZUOTFGZ20xZXdZaWVMNXhNdXY1YmcxUmkr?=
 =?utf-8?B?L2NkWlpkb1JSNTJobVRBSGJlRncvekwvdmVqMFJNU1ZaZWNXdEI4TlRGRFRo?=
 =?utf-8?B?bzl3aElZVExqYW5raFlpc0tmais5cGFXVFVwV2xVUTI0WlZxVkJsNkQzbzda?=
 =?utf-8?B?b2RrS1VyNWpTRjhlczk2RGYzSWFwNm9lcTcvb1JQVjFKdEwzSFBNTm81VCtN?=
 =?utf-8?B?WkxreUxHZmhWbVY1ZnpEYkR4YWE4RVoya0xodWZiTDdqMEZmVmo1Rkk2NEd0?=
 =?utf-8?B?Zk1YcFhDMHpjQ2FEYSswaU5nelEzbFBzYVBWQnYyZVBOazU5Zjk0NjEzczJ3?=
 =?utf-8?B?c1hCWXVQc3NsUUlOZHdObUdKbUthTjFyay9LdFhZWkx1UzJhUjljcytHQ3hi?=
 =?utf-8?B?Wm5sSml2K21ZenlUNmtld05CSHhVMll1VkNrWFhxL2dQSXhXL3JDcVdmRzVz?=
 =?utf-8?B?bGRSZ0NhWFZJNkdrS2lHRkxUK3VJeXlBeElHOURob0pRMmJKNmNMS2VuWFFS?=
 =?utf-8?B?U1FKVkx4bHNkOUsyR1VseHUzREJsWEI3RldqVXcxYUVEUE9BVytZTjloOXJZ?=
 =?utf-8?B?TDlGaSt5TVY4cXJreU9GTkR4Z3YwemtQb2laWlk0Qk42UDZpeXNER213akNX?=
 =?utf-8?B?a1pxRjJDNFlTeDErem82QjVDdlNHMjZPc3BpckxXYml6SnVrRmVzb0w3cVdD?=
 =?utf-8?B?S1pMaEVzVE91SmhYeWZNRm5KTjZXdzU3NC80dmttdlZZMi9KVFdpV3BxWGtn?=
 =?utf-8?B?RkROQis1cnVadVJ2OXpGM2M1UGFicW0wMXNMYXZhakwxci9DdFBKaEhNeXlO?=
 =?utf-8?B?dTBEUmFPN3RYYTQ5WWpvNUZxRmtrdjdtOTFWNHpwSkxwa0lVOEdYQkVCcWtm?=
 =?utf-8?B?ZjNXUDI4QTRSRklPa0djbEswQzV5M2lDNEtkZTE4bVFDUm5sUk1tMGkwVlRx?=
 =?utf-8?B?NUxQNHJmSEg5VTNUSTJLWDJLY21zWWhkWHkzWjlXVXpGNlVlTnowY3FwYU1u?=
 =?utf-8?B?YjJWKzM5S1FCUHdPc2tkRzRKc2pDSFdwMWZQVjBSdWR6WE5KcnQzNkVBcUl2?=
 =?utf-8?B?cVVRQ0NlSFpnNUhEWk9uZXVoRmRCZUtOV0NyTHM0QXpnak9VTlhtSTl3OUdY?=
 =?utf-8?B?YzJyYjZkK3IrU2lCZC9XbnlXc1ZOb3BKYlJadzR2S1VZU3JJQXVyVHFvQ2Jm?=
 =?utf-8?B?SEloMHVELzIyVWt2QTZYTk4wUE1qQmxXbmRIUXdZblZjRDVySmZPRmJiK1lB?=
 =?utf-8?B?UXkvUjFoVStxWGhBRUZTQ2dSdWg3YkhWVkVwQS9hTzMxUjRaeU1yRCsxL0Zu?=
 =?utf-8?B?TlRNb2NQMS9BSUFoWE1sYnNZTXVRUTcwY3c2RlcvSStOS3Uxcmwrc3JzVWNn?=
 =?utf-8?B?OXhlRXpOdjNvRlB0M0FtOXNSRUVDT1JKL040RkozTlFGeVV6Q0pWblJDNEZZ?=
 =?utf-8?B?SlUvbDg3V1pDMzVBdjl0V2VYckdDVFdpcG4xdDBISmJsMllFTjVCcXNEMEND?=
 =?utf-8?B?b3YxUHBrNm9zWm5HQ01YTXhTSTJRSzZCN0RsT0lhd0RZZ3NRaCtsaVdlTk81?=
 =?utf-8?B?WkFENmo3QWtvVjhzNThYWGk1SUJMd3Y3SG9NZFB3YmJuVE83TnNxOXFCUlE1?=
 =?utf-8?B?MThTUW1GbmhhODkyTWJDQ1pVY0RWK1lPaktnNnFHNXdWdG9hdGtGcXNqakdI?=
 =?utf-8?B?MmRIbitQUXlhOExuelREVFZ6VnEzSHVKbkpyWm0zbGZOUlJBMHNNN0Vhaldj?=
 =?utf-8?Q?JYk0V6B4ZZNzu/NKk/UvypwwHFBboTQ1bq5TSMI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45eb3093-da49-49f5-7556-08d8f542fd09
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:18:53.7027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUCZfFU2fOOY9s9KXDc/hQ1A/Dec1x+uBpT3Q+dDNrI+hcVxVQ5Nf1JbfzlbMiJDtyrNdHT6xu2BKbTvaXkAWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1902
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-30 10:28 p.m., Alex Deucher wrote:
> Missing check for CONFIG_DRM_AMD_DC_DCN.
> 
> Fixes: 752106f5c5cd ("drm/amd/display: Set max TTU on DPG enable")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index d9ab134a178f..a270879cbaba 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2599,6 +2599,7 @@ static void commit_planes_for_stream(struct dc *dc,
>   		}
>   	}
>   
> +#ifdef CONFIG_DRM_AMD_DC_DCN
>   	if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
>   		struct pipe_ctx *mpcc_pipe;
>   		struct pipe_ctx *odm_pipe;
> @@ -2607,7 +2608,7 @@ static void commit_planes_for_stream(struct dc *dc,
>   			for (odm_pipe = mpcc_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
>   				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
>   	}
> -
> +#endif
>   
>   	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
>   		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
