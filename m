Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22426C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 18:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A586410E764;
	Thu, 30 Nov 2023 18:54:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5BC10E76A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 18:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1G3KgheWb/aXGBz7Vbrvi6TFJT3Cc+U8NC9N7p8wKRnRimKcBZxHEJbYp7x1H9+owW6qfHrr4+vpNsf+6FTDYpHSHDnMbBozM5CiFXYw6xwWAgEOnjXpDoW8Q9mkw2r4V9E5iUR8ykXgEmEgGb3j4XJEwgfGGnRgBmrFRJEh9j5ezlHC9A+3nAd7cSL/B1O5daul1A+Ppl+upa/D+lOWh4Ww2JmRPdapUiEz4K211LblJZCL89H02T7CR1qyf5BQkB7z9M2aXsMTyrCO2z/wNTaMUosjOqlCvJkxz51XRh7icrwC8+bQMUD7oeJ8zLWdkEUhZIHwcdXsvwK7/GG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beZSCExb3h0ZPql+MdpWfXpcfqYpA823PDjmIfZEUw8=;
 b=I8r85GETbnSQ77DddJPtAK2pzbWVMKPYKdzC2yAG7J0Sp911RW+p1YUCYZAEQzLqwIoA74f6mexTmeB1b8FJcFx+e2KrNDT5hoA2lEo2/MdnKcJ/46/2q+K7v2oU9shGv8PKTTrULg78ZCiwRwrhTDYAf6DKV8I/e5FKnV4RcC4a+MYrIiFEPemI7DOBPYgWps0Yflskf3VlJ3onTDjTmfh80GEuPmr4gbH27efeo6SHlNrjWRWF3LSnfvCyvySXdpJZ4lSrOa4s0jHCvZ63KkReEaAr4H4G0aFDbE6VYNovl+EI69MLZVYNiHMxqUNBMT6RdPKzQ19CJYqYV0RcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beZSCExb3h0ZPql+MdpWfXpcfqYpA823PDjmIfZEUw8=;
 b=qNaTF4G1ERSsiagpXfaE1VWUYfh3zN1lMPXkzsteXn6tXgD01BOhwETvhJPoT6UuQiPOmJftzdHehohChK55lGN84DCzP7t6Ze1HzT5dao8b6mU8rvVQdsFVrnEPsYvVCGuAxGxXTNStCV3YnGxtsbdDwxSPqsNGHsPjAZXiox8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 18:54:25 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 18:54:25 +0000
Message-ID: <322db93d-8098-4776-94dd-58f95f964dfd@amd.com>
Date: Thu, 30 Nov 2023 13:54:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereference at hibernate
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231129003509.246035-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231129003509.246035-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0396.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: e11c1b7c-39ec-4fe8-7f22-08dbf1d5c596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xC80chL02zW59Yn56yNVGC6G33RBFADPxDEUNoFHxSMuVwBf4ZGzNzHZmUfaGXpgSFvZyO0c8q5CjeSIk0+9h+uvaP0LJMUncXQbl4ML63O0VvTqDnqY2CrnV/1MGarHoPNqIPNeixuQz5eliv0oJRaia4WNvHKv2GWfDQNvcTTGO6H1alIds2wC72xQiWcwewEJcjLUwrzdNoD+ua4bF++DTWMDZDOnfytxh9NMBEcLZDzf9+pXID6sBRu6B097cBS1Pugdze+X02IyE9XW+/EFwMQHSzoFdA8BWS8jRbRKwt381tDthXAwliladx+diI9J2+sKXadET7eeVx/k2XPpb9b9Ya3tJCaputVtQhhbjKq59fn03Y4ROaJoEpgIsF/BtrcuPzTpXZMqK303Vay0nDJ3gz3iqNCSWoPL7SDAWg7DMlnYMp+8tXNuqFIvwdUQsfo1KdjxLSfwU1pyUFE6HY5RCBdGHpKLNiBfeh9C7Gd/g3IP+nxGSAwOje9qTwfA+bvA3td7+ikO/18Cf5cIX/QixmeCD7FQWjTp94eBnJQNyJngtjYiAjEOFCaKIU/AOUEknxtivudMb+Ldu1kkzIPfwUeP1cgMu3fdHIgO9XiYToPa5jb0ZLz+UU5CSYdQbkrqkc/+f5neygwsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(66556008)(8676002)(8936002)(316002)(31696002)(44832011)(66476007)(41300700001)(6486002)(478600001)(966005)(36756003)(4326008)(66946007)(2906002)(5660300002)(4001150100001)(38100700002)(2616005)(6512007)(83380400001)(6506007)(53546011)(6666004)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU43K3hQNmV5Q1VuUkEwTVRjcWdnSXY5WmMyWDdtOFVjR1ByUG84SWVxNWFS?=
 =?utf-8?B?T1hjT3FCakw1WUdtRHkyZzZVc2laTXQveXVOMjVucHVjSnlEdlVFOW9vZGJa?=
 =?utf-8?B?Q3duNnAwM0ordGtTeC80b2RRc0FxNkM3VVRtaFFMaWVxaDMxVmQ3bTdHUlRR?=
 =?utf-8?B?NUNiUDBkdER1ekh1Sms2M2JzZjRZdDU0U25oMXhUd2FiOWFMOHRzaXp3ek53?=
 =?utf-8?B?Vkdka1J4RmJLUFZjVGpCNUtMNWh0WUNmVEQ5VDJCT1ZVUXBjRWZOU3c5d05j?=
 =?utf-8?B?ZGNhWXlYcGduZHRvKyszaG5tOWUxS1lnSlpqQ0cwbndKdGkxUFA3a1BZNWJk?=
 =?utf-8?B?YzFKRi9sZDhhQzQxMnZFSllaY1hDUjZNRzh5ZnZuWlFKZ1pkbWtVajFGS2FC?=
 =?utf-8?B?Zkk5T3VKRUZOSXhrTFFwKzVJWG1WZEJsY3VqVldlZDhNcjZRVjNhbktoaDZh?=
 =?utf-8?B?a1A2WS9jT3g2cFpyMGpRdUpOb21zeWw0MTRyeUlTcVdDSTRxRGUwcm1pYVky?=
 =?utf-8?B?TVFzNWZTS0NSM3RXcnJhbVduRW5NRlY4NnNGaWk3NkoxOUdwSyt0VWgvakZJ?=
 =?utf-8?B?c1NuSy94OFU3bWZ5OUNvRUdrV2JEWEJkazRZdy8ydjZVL3Z4ZVV2L0NYTmdB?=
 =?utf-8?B?TitRZXBxS204L1FBeG1YWUgwblIwVEFMM0FmcUZ3VkdIZkNoSWZBanp0ZGFq?=
 =?utf-8?B?Um9SR25ucFY2VDI2eEptSENUSVZsZTR2dGpqdW1jNVkrd0xibmZmTTNnYUFJ?=
 =?utf-8?B?VDc4ckpKS1I5U0gycmFFbzBNakhBc2RtKzNJWUZRVktCNjFYMDBFWEVIREFO?=
 =?utf-8?B?NWFvckNITmtReTlEbjB5MmxDMTVmQmxqWmFiWnZRUzlad015U2hiTWpDeVl0?=
 =?utf-8?B?eHdwTlJ0Q2JoOTBWMXJYT3FhKzRUQUtIcStSaEdwSWZ4SFYvR3Y2V0x0UFAz?=
 =?utf-8?B?U2dRLy9uOTgxOVRGRHpCaHJZa0s4ajl1cVZLQUs3bHpXZmYra3UwbjYwY1hS?=
 =?utf-8?B?RjJocXRJWlFxeTYrbStXV2ZSOHR2MDhRc2txWW1jbzk4Z01Nc0xTZmgza0Jq?=
 =?utf-8?B?ZXpDOVNlNXlHTzNSOHQ2bWF1Vzk4R1V6QngwalVmSk1ZOFJyaGdod2d2VmFy?=
 =?utf-8?B?SDFPZlBTU0V5eDJSWlhlSlNqMzQ4SkVPbVhpZHp3aExYVHN5OTRzWCt4L2lw?=
 =?utf-8?B?dkZnbnhQeHZoOGdHb2V4cUh3MTJ5WUV2a3FGQmY3aldVN0s3ZXNxSG1VSS9R?=
 =?utf-8?B?dFpuQ1lENWFwakRFYjRCSnBTRW9yT1hiUlk2VHNIQ2pCWFNNcCt6UkpxTFNE?=
 =?utf-8?B?RUE0UjVBQ01wdmZ2L1lTUlhnSTJ0cWZjMm5lNzgzamhJNnNCd0xTaG5lOXhv?=
 =?utf-8?B?bW9rM29XZDNmM1ZpaWJKOWlrTzlGTXBNZGxVVHA1cnBSQlFFVm9uUUxQM3VB?=
 =?utf-8?B?bm5JTC9iTStweW9FcS9wbVcwY1JLQ1hheWFveityRjRHUmZyOE9zYWw4THdo?=
 =?utf-8?B?K1lEQmxwaDB5M3d0Zy91NDJuaW4xUktDTUE3a3lEcHo4cndQVU5IUC9OK3RJ?=
 =?utf-8?B?T3VzbDA5Q0R3M2F0akFKTmFtYkZWRy8yWjllbnpsWjdJRXRITktiaHQrU3lw?=
 =?utf-8?B?YUl4K1N3OUZ2UUxvVG0zYkNKRmZ0cFo5ZGs0Sy92aS96blNlU29ZSUNRWlFN?=
 =?utf-8?B?N3JUSC9Ya0JXK1VqL1c2WlZKNDhiZ3VGVWxnN3JzdFE2Wld3bW1nWjM3MEdq?=
 =?utf-8?B?UmpVRTl4UGJjSWpvei9UTDh6SUdPWWJIUlQ5b0g0emxlVWFwdE5sdXN3QzRW?=
 =?utf-8?B?TStBdU5XMm5EaWpzMTRmVTN1T0cyakRRMkRtcEdVcXZ0ejF6d0ZpcmpmVWtN?=
 =?utf-8?B?YXhrOE9sVmFsUFlRTEpxZkNiOEFNVnA3b1hIQ3pUY2trRGxzYTM4N2sxYlFr?=
 =?utf-8?B?OUwxd1JKRnpTS0FyckRQOXBwdWI3WUNURStPa0Z6dW5iT2FYWERuckNRTWR5?=
 =?utf-8?B?UWpWVFdjWlpVTTl1am9XV1hQU1AxS3B0QkRMUlI4TzM4Y2VWVUVzdFYzOGlK?=
 =?utf-8?B?RUJpQlpCZWdTSDVRZi9BNURMcmhiVmdaUW9vb0FjcEthU3hueW9pVG5Xb3Fl?=
 =?utf-8?Q?Cl8u4LVoMwdw8a6nEDspRJBfo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11c1b7c-39ec-4fe8-7f22-08dbf1d5c596
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:54:25.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w253tT13Qj+L6jHH6lqsCCjox/wwu23plKXWhaHcKf10Wlx954YqBOGM2kuFeE+lfi2Tl9qi7b+fNVWwYlhdhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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
Cc: Rodrigo.Siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-28 19:35, Mario Limonciello wrote:
> During hibernate sequence the source context might not have a clk_mgr.
> So don't use it to look for DML2 support.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2980
> Fixes: a2815ada8616 ("drm/amd/display: Introduce DML2")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index f3a9fdd2340d..e1c02527d04a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -4554,7 +4554,7 @@ void dc_resource_state_copy_construct(
>   	struct dml2_context *dml2 = NULL;
>   
>   	// Need to preserve allocated dml2 context
> -	if (src_ctx->clk_mgr->ctx->dc->debug.using_dml2)
> +	if (src_ctx->clk_mgr && src_ctx->clk_mgr->ctx->dc->debug.using_dml2)
>   		dml2 = dst_ctx->bw_ctx.dml2;
>   #endif
>   
> @@ -4562,7 +4562,7 @@ void dc_resource_state_copy_construct(
>   
>   #ifdef CONFIG_DRM_AMD_DC_FP
>   	// Preserve allocated dml2 context
> -	if (src_ctx->clk_mgr->ctx->dc->debug.using_dml2)
> +	if (src_ctx->clk_mgr && src_ctx->clk_mgr->ctx->dc->debug.using_dml2)
>   		dst_ctx->bw_ctx.dml2 = dml2;
>   #endif
>   
