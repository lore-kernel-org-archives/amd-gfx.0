Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E511C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7EE61037
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F7EE61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED6D6E811;
	Thu, 26 Aug 2021 12:01:53 +0000 (UTC)
X-Greylist: delayed 7068 seconds by postgrey-1.36 at gabe;
 Thu, 26 Aug 2021 12:01:51 UTC
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BC36E811
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UieUs3nFXbPqvp8UCaMFpjHJVr/L56huC9yWIYBkTOyNa2QSKtOneHqJVgyvWTwko7PljFaA1IxZ4Ft/hbrWSOqQJ2AbiexyRvQOhgPP4a+lIXYr027hYANo/HJ5JFlHx1QfS8WR/W1gy5dsOiOJq99TsddVyFwxfjeoAbDPQ9BCO0LRS68McHW9a37GRa3f8U2egJTS8jGfu136OWo0Hcvw0ulBZHFk7RRQJThTrDzYmIyJq9gyLDjiv+u02H3DxsKMQQMEITZ5GGNq56PgsenfzxUpHfrRDcxFAgwzuHCl1e0HrL3d4RskzKMI7/M2UrDSJwOAXfhPfpjcjH2Oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWsva6o6eEA1Q4ZKcgw0WmtdU91Q3GcV2EMHwHGOm4A=;
 b=Ia+v6gLD9LPd6eorr+foQGdl6G9XWDfIJRxtReUFkOWheBZJ38+JjldMqGMZL9lcqlfqncb1IkUULo/F6Knumd3lq+O0dQkMwR3290VRFkk22j0f5zIXX72KLGjqGD3FayvC9AxaJoBF2akPkQZ/at7p1NWfI4o28Nypcqspko781gxTkG0QQeAFfLT3u4vqEhBGZ+RMm3DI5CYMCpTcn4NsEnupbL+FaDZWASu96X3v7ARg9iLFkzeNGkV7FT77adm3HnbcJr2c+ew0drNjNdqRh89jkObHnj3UU3qZTS2HpMkkZL0m0ASru81YcE2v9pNgaqSZI4dAzMKJypT5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWsva6o6eEA1Q4ZKcgw0WmtdU91Q3GcV2EMHwHGOm4A=;
 b=OoFISAXgWjiSfy8k5NQpz7E3eSHMoHUFpRCN1biA6yGA82/n5a70SybgqxmRbZYCAa+1uxHAD8OOqHZBodiorw8DlOMTWQoLL71I5Ft8+MZa5dn+m1CE4edHQaTzUtHQyR5uaeDsJMZn4ctRpbUvWGwEjNOewNxVMVOq8y3adfA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 12:01:50 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 12:01:50 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu:schedule vce/vcn encode based on priority
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 shashank.sharma@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-5-satyajit.sahu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <e36f4512-3025-6abc-3afb-27d26e102be9@amd.com>
Date: Thu, 26 Aug 2021 17:31:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210826071307.136010-5-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::10) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 12:01:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a932b7-40ba-4f60-2308-08d96889492e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5191921B960B8AE6A1DE2BB697C79@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsBCJBnhHHEHSxiTPPo1LblCrAI4zUkH0JuCDcq7cRWfdOQ7m5yIe+v9sXPfstMWS5ThApRBiv56Q0x+I8L56/FIPul2GK4urvJ683XskaLKtg8r7xJ+kFr5BB8vVXjO/yvVq2HhXIfLfX0ePHx75v0CJU6ioQjePqeX4AW6SIrpVaOGiMbIRq76qPhiqrSJrKw7cDMLenZA+abFjZvKyvn60g2FnZGKGkbQkHBTHYpV2A8juYEjGsBxemcRQe3oY4Kl3LlNhfTsc2M6NPUmdlliuj6QY1FzieP2CXgP0KzP9IlsD87NBvbCm2bIWU7baQlNJZpT5A68mVFubVqG7Rmt38uzmxQ5jV43yyYC07ThvGMxCBOG4HwVPY51QKNhJAEcya1g83nxu9pOc5IRCFkN5VC1H5v2hOBPU7i+4bNeT+NIWSyHkVf1AsEjU7Av9oY4Mq7rYIJvG0A3lu8joII9Et3aBxdAyJqiXrReMbLLqF5qYB+5/mEvflCVT93HSn0bGjBZ0T9VAg+L26J1Vn37wDLmmW6CtVEnQ1ORN7664122homRLpsmzkz9zwvvbhwdrLIDOfdGi6r/hkBedwtKtsE2L548cRG1TrztFGEm5uodG2PS2YBIxr4faBvsZwnFiXeKXxNvKIJByiE1w40fboVQjhYlh6ZrEetgpLmlqa87z9Uq1NUdV3d4hgnB+yk080nsgODa+jMlprevWwXC/i8tu6e2exZDgCgVq7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(4326008)(66946007)(31686004)(53546011)(66556008)(66476007)(186003)(16576012)(8676002)(26005)(6666004)(38100700002)(478600001)(8936002)(2616005)(956004)(86362001)(31696002)(2906002)(6486002)(36756003)(316002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVg0d3JmR2NpU2doeS9zOXlvUzhIZHQyWnN3NlhVampJZVlOMUlaMGFGcDFP?=
 =?utf-8?B?d2NjakFWYVk4M1hXSGtyb2NNemZrVlk0SC8yR0hOdWI3eDM3c0lGNzZ6UG16?=
 =?utf-8?B?OWo4akdSblljZFNabjZ0NlRQZUcyOHRNemlOV0wyMXBzMmNHUXluQ21VN2Yw?=
 =?utf-8?B?UXRMeGhBektMbW95a0w3Q05pY2IwU3ViSGdNaDd6SzNhT2h2ODVYOFlscisy?=
 =?utf-8?B?eHEwOUFZSm9YM3N2V1BVY1RYOXhER3B1MkpMclpUSDRGUFh3d3c3VzBEbUcr?=
 =?utf-8?B?aWxhVkk1RHNUMDEyeFJ2SWVTSUwxL2FEMHlXb0dlQ1dBNG51VVlrZThmYk1l?=
 =?utf-8?B?M01WdUtKNFRUalVtWUtoL1BWdVc2WlBaSlBmT1JkSWlqS2FEbUlHMC85WHNS?=
 =?utf-8?B?MGpCSlkyN055MngyNFJGcG1IMDdVL2t6YnNXdjIycHNXTk1HN2NPVVZSRmZx?=
 =?utf-8?B?UU5VN1RWczdNWDlja2JCdDNmWHNlQmRmdzVXb2ZCSkRXNk9aN2c4UVpXV1RC?=
 =?utf-8?B?V0JibnJjNFBkQUlQMHlROXB1NGVEZWxyU0x6VmpCZWQ1bzBkWVZLY3FBZmZm?=
 =?utf-8?B?NGdNK0Q2YXJMYWk4SlFNd0g1cEZZdC9kVkErK0dVNWVnVDM4STA0ckRpOHZY?=
 =?utf-8?B?TmZKUkxObDBJM2g1b0dSckhIYzIxTmg5QUpqbW9tR2NFQk40UURNU2MxRjhU?=
 =?utf-8?B?NkR6SDdwR3AwaHIrVWVCSUR3VnB0emtyeUl1eFgvSWVreW5pd3luTlY4cjNQ?=
 =?utf-8?B?MXBIZFB5K056SnFVbFF3VFA2cFFyN1E4SVYyN0FVajFmWjFJNzZGM05TYUkv?=
 =?utf-8?B?SVNFZzZ2dXdYNWJkeXhkN1MxRTFIZGl5bVlQV3E2VXhkM2pyTHBibHhjYXFO?=
 =?utf-8?B?enNLRUg1WjVRMld6UTZxSkJjZ3JBWFFGUi92azdSMXgvbC8yZ2F4b2tQcWk0?=
 =?utf-8?B?WEhQYmtNTGNJeXM0NkNua2RMMjRIV05qcHBGTHRHeGduY01OYU9nVnl2SlNy?=
 =?utf-8?B?bkNnRVJOUW9YUURTWWFpbWlrdGwvY1hWWWNtbjRsYjRwdEFma21Vc3VsZWNN?=
 =?utf-8?B?clJwT2o3STR0TEptZ2VqRDBBd3BoU1NUZjJMc2tmSHNzMDNPelJGNnVNSWpH?=
 =?utf-8?B?ZUdURkN4cmRPY0hBTkFqcjlmTXVOVEFBb1BwUk90NFlDclU0VlE1TXBwRTB5?=
 =?utf-8?B?aVJTWXFVTjFWQWNvempIdzk4RkErM1JpSzlWd2xMVWN6SnluMW5Ic3lERWZw?=
 =?utf-8?B?Y2ZsbmZJQjBCbnpwai9nNWJHSEdUdlF0dHVJZ3RZd0xBNXZtUTZ0YkZNdmhX?=
 =?utf-8?B?OHFUQktqaDhjWHowM0hyZndjMDhmdXpvZVE3bnVwdnd1TDQvRjYvZ2ZMVDZ6?=
 =?utf-8?B?eDdnZGQrN21EZFNjYTc1NHFLNEo3VmVPc1hjbEpTOHQzOGlMd1p4NzRkM3ZT?=
 =?utf-8?B?ZkNZemtkaTJrRDhOYUZoL3k1UnNENzRCcFRMbndpQ25tNmNmWERJWFNHc2Uz?=
 =?utf-8?B?UlRWTExHZm9XaCtKSVNCM2dQU2pYWDdWRFpDcjQxbGtxUnN2R2pWWkpXMklL?=
 =?utf-8?B?UkJieHNkRG45Y1lmN1lyTlorY1FmUXRRajU1WDgrVFFQRU1ueFkybTFaeVln?=
 =?utf-8?B?YVluV2hGa2ZxSDN1RnFUaFpMWmZlMFNHRm5EZHpWT09tQ21RZ2dwQWYxaUlJ?=
 =?utf-8?B?YTcwNWd4VUZycE1sVlZyNE92K3RvNWhEOUQwcnVTRGE4T0lSRzQzZE85aHRm?=
 =?utf-8?Q?UZMA1ZooirAL9SNAX+rDrGxrzybzVjwnOjR+i8t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a932b7-40ba-4f60-2308-08d96889492e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:01:49.8717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my3Nf8ttufi5AKoLUwvgPzKwPzCIMkOMPMUW/KypStkMw9NtVGXhO5I6yUAng83A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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



On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
> Schedule the encode job in VCE/VCN encode ring
> based on the priority set by UMD.
> 
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c88c5c6c54a2..4e6e4b6ea471 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -120,6 +120,30 @@ static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>   	}
>   }
>   
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(int32_t prio)

Well, there it is..enum gfx_pipe_priority. I really thought there is 
some type check protection from compiler, looks like implicit conversion 
from integral type.

Thanks,
Lijo

> +{
> +	switch (prio) {
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> +
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(int32_t prio)
> +{
> +	switch (prio) {
> +	case AMDGPU_CTX_PRIORITY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> +
>   static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   {
>   	struct amdgpu_device *adev = ctx->adev;
> @@ -133,6 +157,12 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   	case AMDGPU_HW_IP_COMPUTE:
>   		hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>   		break;
> +	case AMDGPU_HW_IP_VCE:
> +		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(ctx_prio);
> +		break;
> +	case AMDGPU_HW_IP_VCN_ENC:
> +		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(ctx_prio);
> +		break;
>   	default:
>   		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>   		break;
> 
