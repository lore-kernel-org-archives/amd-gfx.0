Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBFFC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 17:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D365310E10B;
	Thu, 21 Dec 2023 17:06:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275BF10E10B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 17:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/BKBFQ0Ax/7UZ8Ktz/XCBQzHpMcTK7JX14JWrgBUTCfpJy3iqX3w+1r5mLcAww6VexFPsIDsaaexMHFnl8T1NB9GyWGtb7miN+s0FJ3n8J00l6tBIaUZEB3zebVQiVzDhDUmJ7y2ZaFh6YNF7i+MoSHwozJGSp2Ukt+tp1Jj6tuKPzSoBlJOG5FmNpqZHy8NntJUMlxJw4xHJ0X9ImNOKqeNdee7lIen6uzEahPmlk3JRLF/9p8K4j+356cV1Ol7oPFG/XR0uLV35b9u8CILNRjg2dEYdcTJD5rKhyPD0fMZO+CWhlQKyrnpvl/MKf7PIySNuGkxZyiJkzCwj4Y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNLbkK+sLHlymc88Ndr+6VMmVP9sBXUoQnD8Ed77bBk=;
 b=k6zIefLQptHzoMoXJPQxZkty86Q80YWo8s6VOp3ZBtQG0QnaGdod9iudbTpUMb/JRCi2aeRJ+KhFOI3PDnAwtTcde7ZMUD5e3sLHf2haBNKNWKc4+iWfC1AG9PQE+2lGzL+UUhpHQcFpgue3YdJdqb376KgG8G/RSko+wfgyz8QHk7s/ThD6flTq9HjM0IKbJsqqOQ5leKgq6p+pNbxpRA1C213Z9oCHVboo+rgnkoMVFQbYbRK009Q7sz0JPGKh751bMG694+9cGBTED7kPtc+0zx1MGK4dPgkon9eFXscESw6E8nmLRp/4rAor7qVxaZLvIS1097kIYW0ngSXmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNLbkK+sLHlymc88Ndr+6VMmVP9sBXUoQnD8Ed77bBk=;
 b=YvQJMg81Awz+Mo0EcljfLAm30aKkos60IdLL2yeqd4oxNkbj8mgyGi+9SWs+rpy4yIkE339YQiTNWFI7gvZ45a13523fd0CvkvElIosA3ZpWFT7jmqnqYjCOZNQhpBMTGBsRjinZKd3Kv+OuR2Ye05DWsjpzd/wlkhiKJq7Da9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 17:06:06 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::194a:56d:a41d:3c79]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::194a:56d:a41d:3c79%6]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 17:06:06 +0000
Message-ID: <b0ed1688-5a38-4ead-93ab-efc316b764c5@amd.com>
Date: Thu, 21 Dec 2023 12:06:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Address function parameter 'context'
 not described in 'dc_state_rem_all_planes_for_stream' &
 'populate_subvp_cmd_drr_info'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20231219070154.110759-1-srinivasan.shanmugam@amd.com>
 <20231221162841.1382315-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20231221162841.1382315-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::41) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: cc33c5ee-8f14-4142-6d49-08dc02471e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LznCWL3pr9vk+XMObEWzRwofTs1xPktBBmeFyunpWnk75OWf9/5PM6btYYEYTc+YmSfNL6cYLr6OVdyX4Orkb3O3xWNEabM1QK1qoykgutQKr+G7/UEZOYCfPke+bHmgF7+y1JQ1seee/WnS3tQ5gRW6fRDRI1KYHLPezKa1eSP4qUbG/YZP3xgahtpWojyF5PIxFX2eM81Iw0JouSSGKpgt7k5EpnIS3EBar8V5mKxchksR8fo9FNXZai8ZhEmFQlURM7PhvCWBPAyfFDNsqodOpa+aaYUM4r8ntBM+O60IQs80yvm/Y7KApbkM0HfZIc2auwnn38XevaWDdvusD7Cwra7/z+AYLQ+VbWxg8Zq3QeuCZfm0g9dU7vDKy2O73oSQS2REgwKgB9U6TXKEmvaQvu5lfgDmMA6xc3JUmySW9U7enycsuFsqePDZWsCydAaq2wOWVKeMKAWfjo1f8Y6YFAltU53YGsjDZGvb5yHVuW00fjTxBgCK7jz58VrzQJ1DtYluSP8MaW3nrLqjdQIOV/6G0fTbB7w0J6ql8wA4FxQHv9X4gXAWu0NQzZc+uv4robKmfoXdRcKvl9LvnD6KDm2PY6DcHT7nEIUKV+bBnsRA1tAHLU8ZwsezXUqTBu8F5rqoWK/nuiAGtVOiJwlDZH7a9je9enHDrMolpN8ZxWJkUZ18qS8/YNCY6SbN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(478600001)(6486002)(31686004)(38100700002)(26005)(83380400001)(2616005)(53546011)(6512007)(6506007)(4001150100001)(2906002)(8936002)(8676002)(4326008)(31696002)(36756003)(5660300002)(41300700001)(44832011)(86362001)(316002)(66556008)(66476007)(54906003)(6636002)(66946007)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d284MW9ISW9CTG4wVW83cnVPNXBCdC8xelNFS2p5UkozakZMckdhaVlvR1l0?=
 =?utf-8?B?ZWRDYTVidVE0Z1FzS0gxZzUvOEI4dmNUeHMrcUVvcTBLTXRaSmtwaGxLNHNB?=
 =?utf-8?B?SWxSa2lLTy95ZFR3L2VuckgrTlQyZkFpdmE1S21tK0tLRVdXbmJmU245Z0VH?=
 =?utf-8?B?NWpudDN2RHVSKzU4VHI4aTJ1b2ZTK291ajlwR1VsQXMyd3NFSjhUWC92NGNu?=
 =?utf-8?B?NlpvV09TcjREc08yZlU5Y25HU0JYNFlKNDAyckdqR0lPdEdPT2grMGdnblo2?=
 =?utf-8?B?NlJ5OTlQK0xwQzRuVG5hRUoyb2JBVlYzdXlDSDc3Z1dqbmRDTGRuVk9xMTA3?=
 =?utf-8?B?MEZFbCtNU0VLRmJHalJucEVzYW1NL1BrSEtaOUNFamdsc1lOUG84MnBLQUJS?=
 =?utf-8?B?VllPYlkrMzJDRFZldzUwSHJYM09zUytBZXRUY0wwajY0bWl2ZnE2dlRieWlp?=
 =?utf-8?B?UHJFNmxpRE53ZXdtUlBFcWNnbkZrRiticmVrVWJHdmd1ZVJ6OTE5ZnRSVlZt?=
 =?utf-8?B?eGFaam55TmhDUTUwTGpGSHR4OUd4bkErajNiQ0l2Z0JJeTlubmp6d1E1UDBU?=
 =?utf-8?B?QXhSTFc0azVkb2tJYWNuZ0RLdHMwa2JTRk9uMXYzVDFzb2dTVHdLMit1YUli?=
 =?utf-8?B?L0FZVk1tNjJvSUJlZ2orbm4zdEJIWDltbGdMZnppOW56UDFacGh0Ymp5K0tI?=
 =?utf-8?B?KzVveUx6Y1BBSUJLcVBYNFhVNlFxdzFLZHNadTJlUWR1MjFLRytVSTFMbVo4?=
 =?utf-8?B?V1h0ZHhieG0xSXp1bzhmQXZWR0JnWGRFTVlQOWVaMmlVd05DOWZOdllpeGdU?=
 =?utf-8?B?YWR2VjhmMU9xK1ZBbXdwMVZrcW5YYVEzcHRycStiajJCaWN2RDVhWkZWNkVP?=
 =?utf-8?B?c1BDSjFmM0toU2ZyKzIzdEF3VFprdzZ2eEVXZFB6ZWIrRXFzYTdXeEZUc1J5?=
 =?utf-8?B?Znh2Nk5rTUYydFBPZHdhVXZpVWFGWWZpb0xkMlBNTWNudWUrNFJBVXZaWXlm?=
 =?utf-8?B?RUdadUtNVDF5T2dYSCtHZDEwT3pmbXAxaWJoUkFITXd0d2Z2aUlSL1A1c1pn?=
 =?utf-8?B?Y0dZVnR3UjQ4Z2lvY3hSQmRYU2ZlalRFTE5mVDZVUHFLM2NacXVSZTNPbU8w?=
 =?utf-8?B?TnJNejVlSzRWeVJJMzQ4R0wrSTFpVThaT0VCdDFTRld4NHQxODlWVDQxR3ZL?=
 =?utf-8?B?R2ZmUHg5blFJY0VzSDJWTHI0SXFQQUk4bTczbmt0dG9QUVV5bWJIUXg3blF2?=
 =?utf-8?B?ZHo5dW9zM29lREd2emVHRDN1YXFrMmM3bUZOS3h1ZVR4ZzVzNGNWZWNXQTcz?=
 =?utf-8?B?bWZhc0lRQktzc1VOYVpsaDB2ZjI5ZTRCeE0zMFBQZ3JwMU9XbnYzMStCN2tn?=
 =?utf-8?B?MnRDSFl1QlErbko4ZG1tK0ViMmp3YzZIVm1uRGc1K1JUVXgrS2FJT0huZzB6?=
 =?utf-8?B?eG5UZjNjZjcvL09XMzhLMzNoS3JRdzI0dGt4Y1dscXNmR0lrRVJIRWE3YnRZ?=
 =?utf-8?B?Q09OakdPZ2R4c3FNYjdVcU5xaGJUWm40dlNnOEZpbEZyRlhVK1pMVmZOeUoy?=
 =?utf-8?B?SGJUYm45OW01QXJQWDJqUXRiRjl1TFJjNkRpR0M2elhINXhXdURLRkZ1SDdm?=
 =?utf-8?B?UVlBV0MxNWpNaGN4L0RSMHI5R0xEQThSSFEwc3RuR2lySVBxcFh3d3hrM1BW?=
 =?utf-8?B?Qmt2Mkoxd0xOanlsb1AvU2EzaFZRZ2t2ZWc5L2pTTWkvcWFMblk0OGpIZWRx?=
 =?utf-8?B?WWdzUktoMFdpSGlXRzM2MGdGd0RZMUx5TjUrNG40ck1ZQ2IwczRQclJJNHFp?=
 =?utf-8?B?N2VUUkdFc29tV1IvOWhPeDk2cnpkMWJDSHEvL1VHZFN2T2VHVGh0YmJrOXhh?=
 =?utf-8?B?Q2tvR2tvOUE5WEtOTGl1dHh0TGZMTFZ2T3FVaVFCZUdaQlBJZmJIemZQb0ls?=
 =?utf-8?B?T1RiejFsTVhLclJ3eDJpQ1B2MEg5NVlrb0Y4dG9pMVNMSkI5ZzFKVGZ2dEdt?=
 =?utf-8?B?Q2JSME9TZlJUcTY3Ny9FNEorUGtOT2FFalYvNFVHbllSWVV4U2FpYzM3djJi?=
 =?utf-8?B?aFE5cDZXdjhHZU9DWm1WUE1iK0dTbCtDanhLSXB0M2xUTE96aFZ3N3d5ckox?=
 =?utf-8?Q?ys0NYGl0rEAYaTkIlK0pR/YJY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc33c5ee-8f14-4142-6d49-08dc02471e9d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 17:06:06.1241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ibdd2hZmqKWWNyOcUAAKY1+cKnpTD+UckSvRWj1i1BrTleuboyHFqgPUN35hUAViWK6MXxGTggrHOORx1eQX6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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
Cc: Dillon Varone <dillon.varone@amd.com>, amd-gfx@lists.freedesktop.org,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <jun.lei@amd.com>,
 Srinath Rao <srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-12-21 11:28, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:524: warning: Function parameter or member 'state' not described in 'dc_state_rem_all_planes_for_stream'
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:524: warning: Excess function parameter 'context' description in 'dc_state_rem_all_planes_for_stream'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:540: warning: Function parameter or member 'context' not described in 'populate_subvp_cmd_drr_info'
> 
> Cc: Dillon Varone <dillon.varone@amd.com>
> Cc: Jun Lei <jun.lei@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinath Rao <srinath.rao@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_state.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> index dd52cab7ecdf..460a8010c79f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> @@ -511,7 +511,7 @@ bool dc_state_remove_plane(
>    *
>    * @dc: Current dc state.
>    * @stream: Target stream, which we want to remove the attached plans.
> - * @context: New context.
> + * @state: context from which the planes are to be removed.
>    *
>    * Return:
>    * Return true if DC was able to remove all planes from the target
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 1d315f7cdce3..a59b982e99bf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -519,10 +519,11 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
>   /**
>    * populate_subvp_cmd_drr_info - Helper to populate DRR pipe info for the DMCUB subvp command
>    *
> - * @dc: [in] current dc state
> + * @dc: [in] pointer to dc object
>    * @subvp_pipe: [in] pipe_ctx for the SubVP pipe
>    * @vblank_pipe: [in] pipe_ctx for the DRR pipe
>    * @pipe_data: [in] Pipe data which stores the VBLANK/DRR info
> + * @context: [in] DC state for access to phantom stream
>    *
>    * Populate the DMCUB SubVP command with DRR pipe info. All the information
>    * required for calculating the SubVP + DRR microschedule is populated here.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
