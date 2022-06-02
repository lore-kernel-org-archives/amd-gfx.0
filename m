Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97136C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 20:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E89011378E;
	Thu,  2 Jun 2022 20:49:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BFE11378E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 20:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuOpA8SeBoB2frN1a/esCWGguofc69oAT7vO9+3pkI6cDDMLzJx5G8S9+7v3Vhb0lVDQy0ZB3g8fGb8IWyt7HVExwAKOypspN+LL8kK4RCm5rtvJ6sYTyxcAaEToO5G9FLjyi4xG9nGCiuxuQFoCNpz1ZfGnMpsexw7ceKlj9szRLSN1HTwvjCZDcbTh1GqnVTaXEIsmeLvW33t4IBY5n46DFhBw7VKjtibRZ9itAw2hsg0zMV+vtzcexLVM3/adUSLjk/CJLFjgOXMqVPAzR3QXfJhwxN4NAUI5mu0Hcq/Ly4BRdLXJz9FiA5eA7HiO6Wz7IBvoYangR5UUaI8jgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj2Q2ayV58lp8jCgvWwFxXsDBcOIxx2ltoh5BSJv1dM=;
 b=OFnLGprIw/HtH6iKABK0vdIPtmQQgdFuwCVZq3bRgFW+2aVqyrvBSXmgOZEA6cmFHlJ0v+Nri68sAo2XFGRQ+75Cjhy+qzxoD4L1UJ+B71rjrQVTCgSVf8zn3rCTUuKZY5F7E0wEOjEzF0bxmxtH9tHL+sxkJyosFhgaEgwUm5vYSP364sC1bqd4sA3h2w37NyuTNF/wS7/suBfZuBVrjiysyTM/ueAsQ6lyQdRL7lt19eLs+1vg1F/YJsfRVLLaztbJU0Bgi4ZiNYHUikIn9Sqoxu31F3GWH5x9K4vGn4SbV6UCBvIqJuLUIanfkbfB2STKUUVw2bu9K7kgGrMFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj2Q2ayV58lp8jCgvWwFxXsDBcOIxx2ltoh5BSJv1dM=;
 b=4BfantIdm1hCOAYWqR9hIXXwSRzCpflXYwiH0D0hZULXyxzncU5M68+BLQlv2IQy74VO0rlKM/DTC5ZDVJQFETZedybHx0SPoYbEvGPdGD9h82H1c4CZpggT/pCKhxghpmKJi4qmB0VCql3UAvqVG3eSPQiVII0NkXjc9Zh5cxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB3481.namprd12.prod.outlook.com (2603:10b6:5:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 2 Jun
 2022 20:49:24 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 20:49:24 +0000
Message-ID: <6ed8ce38-1653-225c-10d9-f7e4fff5adbb@amd.com>
Date: Thu, 2 Jun 2022 16:48:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] drm/amd/display: pass panel instance in dirty rect
 message
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220602180347.754067-1-sunpeng.li@amd.com>
 <20220602180347.754067-4-sunpeng.li@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220602180347.754067-4-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff41f58-af7f-4b35-26f8-08da44d9602f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3481:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34810CCB0723967F24A68AC58CDE9@DM6PR12MB3481.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfIX1FH/J3Qo7FbZ5tzDmwXFGhY4RvXrw2cYoY6p8cCB2ii3gj4Tc0coC5C/mIRuyeVzgE1DdctleUi/HMfEkaEVP/qVA2mz5qoI/z58lXoXB2+ElgwV99bWKCSJyYwSJlBJiNlm6cpPG1Pw8aQOpL57H0VnlNWvw+XiCyxbyIOh0HTXDPkSMwDhYKEK64GQdniBVzErHpZ7GKaeniKHC0jRN78U7PLEr3wjpY7DhgseQ10IVEeaVvjwrptNZsB5RoOmjg61dviv8CgM3kfV8HhikqklJCyDg3HVAtf/HLnlwX9IWeYXZ8A1tRoI6TzC2H+PUT7n+EgSz0hBR5weghf8WK2O2oyZw8AYdu0gcgB604C5kxBQyyTrTlK+sItzzpjLRghlc4+qseAYJkJ+bcWyPmNDfrOoUF7ceZYgshyE0y2zh43dvi1HnUzN95Vq9Bcqf7/QgAc02oobkaFmt3I3V9M3WLVEntu+b/lbunhsaQyd/rdkcGhCIlf2O197mDEFcbU4XOsL9+Pnb6EY53a2E+aWuX0NbJl8WUplreGR0ZfMlWJ748xRQON8eYWBVaiSz+D2T2CDRIafvCDnajd9Me5lWNUzMmVkXy5nmEz16Ze6CDCOgeIo+IfEvk/UkGf9NmcB0sYGa61gIzWyJ3x+1wvf2BeZ80/6/6m8jVn4P+MFfGuxIcJBz9+C5C/42I8qnoU4naoIBiETHM7GyFEEdBbZ2acRDYIW/mYNtUFp8CosYjzEbYJ664Fx75v8GcJf79dfqMnUdEHXi30YJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(8676002)(44832011)(4326008)(66476007)(66946007)(15650500001)(36756003)(508600001)(66556008)(316002)(6666004)(6486002)(2906002)(8936002)(38100700002)(31686004)(186003)(31696002)(26005)(53546011)(6506007)(86362001)(6512007)(83380400001)(5660300002)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlVJUkNDV2l2RmFWY3RqQmhKZmVvWnhaS3pXYWxYQUZlUVp4N0xVdnZUb0Mw?=
 =?utf-8?B?S3M3aUZzOUI0TmNURXIwOFRxRVUrWjIrVVhsNm9TTytZdkVwMWtNYUJJUldl?=
 =?utf-8?B?aE1lOENqWHl0cmpJQXZ1QkJqWW56dmQzSllQYmNqc2tPUlIrOWNqNU1GK1Jk?=
 =?utf-8?B?citkZkFYOVVOSjVkNGFhSEtiS2RCejVmK0svaWsxcklxTWRMOEE5aGE0QnlX?=
 =?utf-8?B?NjBMQjF3MWhSYTZ4T2NnTVF1WmRSSThsYnJQQTlUd2MxRTFxSXNYNDZmdG05?=
 =?utf-8?B?NVZkbjJxRnNOem5yVHNZVWVIOE9UKzhsRllZcVlMY2NoNGl4M0g1NXoveUE2?=
 =?utf-8?B?TTFxRk9mMEhIblkzZnFlODQweDd4UXNMSDBrSHJDTFpvVEk3YXFyTUFrSEtv?=
 =?utf-8?B?Q2FQYTBUV1p6dDFxUUJTN3l4b0J0ZisyRjYrMnNqNjVFSkFBT0Z0cHV1Ujk1?=
 =?utf-8?B?Z0puSUlycXUxUjU3dXRsTmtrMDZuNzRSM1dVUDZ2OHM0T0RaYXFnOVBrNk00?=
 =?utf-8?B?Ni9hYXVYMUJ1OGc5NGorRm9mWHFTNlR0K0llN3R2ZUoxTlBTNFUwcFBPblVr?=
 =?utf-8?B?RGhqSjgza2s2UGs4MzRPYVkyS0hDQVZpdUcxLzEvWEdwaVNwNFo3QkhSYVVI?=
 =?utf-8?B?SWpXSGcrVzU1OXdxRkJCUXAwa3lvL0p1Y0tmRjdpWjJWU0tWM0JPZ0cvZTZ3?=
 =?utf-8?B?OGRZd041Z1pwcTNubm45dkhoWHNYMTZrSmNhNDJ0QmpJMk5rOUZaS205WUhS?=
 =?utf-8?B?UTRGaTRZY2Q3Nm42d0QvL0liZVI4MzUzZ3RvZE9lN1BYL0ZvOS9iM1ZPMU1T?=
 =?utf-8?B?eUdKdDlZUzdiWW1qSUtpRlQzYUFEOVd3R3dMRUhoajdpcTlmT3ZFblZMNitH?=
 =?utf-8?B?N0ZHazFYd0ZISmVVUEJXS3ZnK204NnlEYnZGbERVOTdHTko4S0huaTY3T0I5?=
 =?utf-8?B?OHJaV2cyRGc2Q1RBa1JGdjcwa3JsRENmNTg3cVQ5cHE5TEhaaG9lejM4R0Nu?=
 =?utf-8?B?a2g4VUFRTGpOQVhpa05EbTAyekhheDNRL1IyQndVcElvU1M1Vy9xY0pRQjN0?=
 =?utf-8?B?MVNIZ2txWnlYMnIrQmV2QzVyODBGMFZrNWkwNGVaMVQ0bFg1N3ZYZG10bDBW?=
 =?utf-8?B?bEd6bUNDRnA4S216cWNaMWVWTi8xRTlIcTBJUC8vZU1rU1l6aWJvdEdoRU1S?=
 =?utf-8?B?Zk9CeHJWMUFZQ3doZ0ZvQ3ZONG1PdStTZ05CazVxL0ZYZ1lWaGtoQS94WXFL?=
 =?utf-8?B?YmlUeVFlcnBPb0h1RzRvTVhRcU9jUmdlK1k3WHdWbHR2N1RMblc4dVAwd0hP?=
 =?utf-8?B?SWhWZCtTb2IwaDJzeDNJUnM4UmFDc2R0c1pqN2M2R3R2SzBvbnFMTHJFR0xU?=
 =?utf-8?B?eUxkeXY2SFRiU3UvZnlaVlI2UG94elNYMEQ4dzlFSW9IbnZ3Rzl4UWN6MnJl?=
 =?utf-8?B?UGFGUjk4bkE1SklRaVlxcE9wSjdOc3pUbEdzcHhEMm9Nd0V6NzZRVlhCcW5y?=
 =?utf-8?B?Q01KZVVMa3dSOExSNC9QQUprYnpCVEhrUW1PRmpsbUlHZlFtanFJNG5rcGFC?=
 =?utf-8?B?ZllwTWRaclBVZEpSWHdzNXJMSDFnekZ0bWhPL0dXei82N2Rpc0h1TngzejFR?=
 =?utf-8?B?eU45VVJkcFNWTXh4RUFJbGtPbXlWRzFwVGtjV2VvaVQ1L1ZEWDNKWFg3M2xW?=
 =?utf-8?B?TDVlUkRqeHM3dnA4U05Kckh1R1hIWHlNOUJCRnY5WldCWTZBSW51N3FXYWlS?=
 =?utf-8?B?Vk1MSnpqTGhXOU1wOW9WbUxkclhCYVQzZmxWbWswTnNzVUlKNExqRUNvY0FP?=
 =?utf-8?B?dXhLZ2QrQlJXSUNLTEp1bzl1RlNTUU9MeDVycStkQnpJcWMzaGZqRUQ4c1NX?=
 =?utf-8?B?T08xOUQ1eVNEMUJ0TXFNZVVLUnNOZ21Wa3RDWFVTS1RpVmFod2d5cjNmTlQ1?=
 =?utf-8?B?cmxTNmtGeTljTlovYitMTXRzdU1Ha01Jd3A2cDlaNVIwTjNXOUk1bTJlWCsw?=
 =?utf-8?B?Q3V2ay94MEQvTHJXbDJ4cVBJcGRkbmR5QnZuWHVkcWZNcDhuN1B6Mnk0Q2NG?=
 =?utf-8?B?ZjZHZlp5dXpmMnpuUGdWT28wbDRvRmd0U29ubDllUlB6WHpaNnRhaGhNbldK?=
 =?utf-8?B?NFkwSWlRTkdPTEhMd0d1UnFkNTlwTkZOM1gxbklVMFI0MndJcFZTdi9obUh1?=
 =?utf-8?B?NDZ5UnpqeHc4anN4dkNOaEl4WmlGUWJHVkdnNk1od2FHOHAzMERTYTNXRTVK?=
 =?utf-8?B?QTlFT2ZJWURWV1l0d3BYT2F4VlhRcVh0bVBYL1RXT011cWppbnVqRHkzTTJQ?=
 =?utf-8?B?L3c2UlRJQlhQUVdpUmVHenc0MDVVUThKbm1kcVo0VlRaK0NCKzBLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff41f58-af7f-4b35-26f8-08da44d9602f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:49:24.0202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cj1nQbvNdHfQlYU6uLNSwEHetBsRDrGyKjztlZ2Yej7YKp8d+O2y94DhRXGOv38JwmcNcCJt9crxmTL2siyWTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3481
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
Cc: alexander.deucher@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 dingchen.zhang@amd.com, roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-02 14:03, sunpeng.li@amd.com wrote:
> From: David Zhang <dingchen.zhang@amd.com>
> 
> [why]
> DMUB FW uses OTG instance to get eDP panel instance. But in case
> of MPO multiple pipe indexes are passed to updated the same panel.
> The other OTG instance passed would be ignored causing in DMUB not
> acknowledging the messages.
> 
> [how]
> Add panel instance to dirty rectangle data and cursor update data
> structures and pass to DMUB.
> 

I'm not entirely following why passing the panel_inst solves the problem
that is described.

> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>

This says the author is David but it has only Mikita's sign-off.
We need David's sign-off as well.

Harry

> Acked-by: Leo Li <sunpeng.li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index d4173be11903..31d83297bcb5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2837,10 +2837,14 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
>  	struct dc_context *dc_ctx = dc->ctx;
>  	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
>  	unsigned int i, j;
> +	unsigned int panel_inst = 0;
>  
>  	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_SU_1)
>  		return;
>  
> +	if (!dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
> +		return;
> +
>  	memset(&cmd, 0x0, sizeof(cmd));
>  	cmd.update_dirty_rect.header.type = DMUB_CMD__UPDATE_DIRTY_RECT;
>  	cmd.update_dirty_rect.header.sub_type = 0;
> @@ -2869,6 +2873,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
>  			if (pipe_ctx->plane_state != plane_state)
>  				continue;
>  
> +			update_dirty_rect->panel_inst = panel_inst;
>  			update_dirty_rect->pipe_idx = j;
>  			dc_dmub_srv_cmd_queue(dc_ctx->dmub_srv, &cmd);
>  			dc_dmub_srv_cmd_execute(dc_ctx->dmub_srv);

