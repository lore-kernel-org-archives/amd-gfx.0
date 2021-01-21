Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6CDC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 16:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9FA206D8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 16:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9FA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8DB6E910;
	Thu, 21 Jan 2021 16:31:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652F46E910
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 16:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYk2Sda3YKSkZ8G02bEcFyydGr7IZistNNoKT2qDLg9jRHPbckD1Md5abcGk9fpYtCYzGA1UMDxdyynsVJpGM+GxO/4jTEziQaJqZfCQDkEAEnfFqzJsPbwNKvkQxSpzL1SOaeCGmy4t+rQkqHxtbYdIZCdk+5PMlvWKGVUlo6CKK5pJrwv7LoKRrrWoXri63Tr+RfreBPdJzPIvNMWrRfZ0HjhnvrqvgHvbCdKIZqNXzZDDBUpI8ObYmbLsz3evjriwxoXbUdDjuJZcgxNzCq6m1O+lKv+lKkiqRIgoNlJhdcvRO+s8BXUwKSZLIGrpcATbYTuIaI4czARDl83yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWkmB94Gszvq9qqxHNKF7RSVURqXzNEY74kW6Gd1QYE=;
 b=jiRUY7DquqH1WGqKafwAIL/fjKIC5HYSK1lWBu+Rxnl3NnG3a0Q/B5YyAJyIBKklnkEXBxx87G1cUBWxiVhoj5+Zr6l7/HCAiRv5Hn/yTLoJPVwO+d5UOJvfLDXS8x3k46q1IPG7PlzoJF8bgmNT3aazmBFhb8/CpXSFb2Nttspq05isJhPpVVDd+ZxiUm6QkW1SA/DCYfbukiBjwr56HIhTjKFvAlTD7R/m+nMhfpT8DW84xXEY4/ZoSGDTYZaitV0x3up8ClH+10pD2f/7w5qgfa1HPZN7Ukv60lhsMQiMFuA1hkMRWNyeKqdlrPkKYNB6gAbiPQZN68VWLfCgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWkmB94Gszvq9qqxHNKF7RSVURqXzNEY74kW6Gd1QYE=;
 b=AmmofI38ldZRCFO6QUvaBMWpWNjOEqFhpZm4S7OHure2e6oy6vVTWX/pfROnht9ULbqIZAvZtbsB8YG4FrkqbsaDL1ac1rk0c9t3HHNdY5+K4rgwMzsf58504dVhP+vZaeAeWHW8n5z96uCkrKZUp4wLeEAkWZLt3BkhX2Judts=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0061.namprd12.prod.outlook.com (2603:10b6:301:52::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 16:31:51 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6%7]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 16:31:51 +0000
Subject: Re: [PATCH v2] Revert "drm/amd/display: Tune min clk values for MPO
 for RV"
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20210121045155.6099-1-Pratik.Vishwakarma@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <647a8847-70c4-a853-fec1-ff8aceb4635c@amd.com>
Date: Thu, 21 Jan 2021 11:31:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210121045155.6099-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::14) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTXPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 16:31:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2795257-2571-49e3-dfd8-08d8be2a0e7f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00616894F32C6D519871F0E68CA10@MWHPR1201MB0061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AW2D8QLrbzFKegig7+JBssxvwX2DMtX1J6ekkCdqSfPpQqFNuKaEWuIgYi0U3s4/5Do+emyS4X+fWLaVXOhA1/0RjKUBrHKRPeGmPgDFzlBnlLKebeCClufWTG1ql9M+Bd7oNhCZVIwYKe+M5ijS7BY4jMvnPmYSw1sO4HpJYxDdPcKKXCIrbAiqoPfmGF+nW3gB10pRC32aZnpMd8fQE1tjjQatt1MHwq3HYDPow8D0rWXJeQp2/cLlaT1ohQ9Ic5+3tjSkSTFwnvaQMp2uJFgT+gq8SjuNHfgUQaqcbpy2sCD85+tkuI9voIVVjYYyQNTyQ8azz6uebO/wgCFw4XOs+tTOmEaWg/su6KTWv4wz6Ri4nIPTmOEhE/IRyC9uIDCnvm0O8fqRjvLQ+uZtR0cOAer9i4Vu31qO/M+kjQ7EmCrTCQbo9TPZQ2trKq8dKs2w65ZGy8N6QMeDSLAWU0DTskNrm50ziwnrONr0fmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(86362001)(2906002)(16526019)(316002)(5660300002)(52116002)(31686004)(26005)(44832011)(53546011)(36756003)(478600001)(8936002)(2616005)(6486002)(83380400001)(186003)(16576012)(66946007)(31696002)(956004)(66556008)(66476007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlV6Tm1pRC93Z2pKd1FaU0M1dDJBYTBweDQwSEwwWEU4b3dvczNXSGpsNDY4?=
 =?utf-8?B?VXFhZFZPMURSTWhISmZnVXczUmhydnZRWmM0S1V1bFVaYnFBbXZ6ckxxZVNo?=
 =?utf-8?B?UitnamRMT3pPUE9QY2pIa0Q3N2Y1L2NiWWZoTDBaZXNnakp1MTlIektyeFJ1?=
 =?utf-8?B?cHpOWS9XWW5vY2ErL1FUUXlrcmlHWTlxTFpVaWRaWjhSQURiWk55SzlHYXBW?=
 =?utf-8?B?MFVjdXlLbTB1UksxanlFRFZJZ3krK25IdnNORVdrSlNCREpTNVBONWU0TWJN?=
 =?utf-8?B?bEpFVWFHbkpaKytObm5RSmR5RER0NzljTDVsbHYyVCtyU3V1WjJoaS9oWUdY?=
 =?utf-8?B?TEJKdkxGcHNhSnFzR1NQeWdMMW0wLzZDN0VKS29Ub1E1MVN2U3pRcXhyend2?=
 =?utf-8?B?bDB6MFNMZjM3TGcyOHNrTEVyNSttU0VmYzRyaHpsTGNWUHQ1aVdXUWtXMTcx?=
 =?utf-8?B?RkxZOUt1VXdVZHc0RTRJYXJ4T0M1bS9LZFU4Mmh1K2x5eWFWZ2NVV25ZaW1W?=
 =?utf-8?B?ZHB5RDVJWDZ4RU1nY1ZYYWJYSEtqakhqYjNIVVdJVWpqNG4xdVpJcVdXdWs4?=
 =?utf-8?B?VkU4RTQ5cWlqSms5bkpTek5lSmJNblhZZWZZTjcxUEwrN1JRODNuWmUrU2cx?=
 =?utf-8?B?UFBPRnRhVXNIRTVTS2gxS0d0cHp6UWtURVpqK1EvMW0yVDVRZW1vUUEvam90?=
 =?utf-8?B?YmdEUVl1MWNzbHpPbmlMWFRzMGpURnpwRk05UjNhOXlJOXdHL0JBZG9xVkl6?=
 =?utf-8?B?U1FZL0NaR1owSDZpa1NlMklqVzlvYzBXTGR6WjVRSnk3TUlUZGQyQVFhcHBo?=
 =?utf-8?B?cW1zMkFiOC9jbUlaZVVJcExsTW92a3JmQW1FcUk5aWF6aHFyLyttV1l4Mldr?=
 =?utf-8?B?aDc5ODVJSTZoQkNKL1prVHlRdHJ5MTk2cTJ0TnRVY2dYOXNxaENKanYvZGF2?=
 =?utf-8?B?ZzZ2Q25nTnZBc01hL3JtM1hHeEZDWWJNRHZJaTVjNlA5U1Vkek5CRm9UdWpP?=
 =?utf-8?B?SmxXMldQUWo4bENEM0ZqODkxN3JmL1RML1NOZkRIb1BMZmtyVnNSWlovUE1L?=
 =?utf-8?B?dTI2MVFmbnVvdGdXRlJDZElGZ3Byb2EvNW5ENFEwcm9TSXBLNWN5RHFlSHdx?=
 =?utf-8?B?OUNPMWI2Y2RONDJpQUFqZnY1OGNmTVY0SzgxUGg2cXFvL0c2MHdGZnUvOXRN?=
 =?utf-8?B?RVV6ZUZ3TTlWRDdOK0Fwbldpb2dRR0ZNN1lndHp3dnBEejYzcEpDdXI1cklw?=
 =?utf-8?B?MDlCZkxibXUzMHE1SXNmT0RIMEhUeHNkRzVlWXpwK3RhUUp1KzNxaGg1QS92?=
 =?utf-8?Q?VUtMlnlJ/dXqkM5x2Fu08u2BSAeZ8pstAx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2795257-2571-49e3-dfd8-08d8be2a0e7f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 16:31:51.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk6vd2xtSSniGJCFK3o/eVPMNF09uMfIiyzuO5BAx9qw1+eeNk2dpYsbda1Ite1L19tCO/blqCqtipIyVLBYcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0061
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-01-20 11:51 p.m., Pratik Vishwakarma wrote:
> This reverts commit 6f3fca64cfb91fedf9b34ea27b2581e88d48c9b2.
> Original issue of flash line when MPO enabled on idle screen
> was fixed by raising clocks. This had negative effect of extra
> power being drained. With the upstream commit 9d03bb102028
> ("drm/amd/display: disable dcn10 pipe split by default")
> flash line issue was fixed and had positive effect for
> battery life. Hence this patch is no more required.
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 30 ++-----------------
>   1 file changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> index 75b8240ed059..e133edc587d3 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> @@ -187,17 +187,6 @@ static void ramp_up_dispclk_with_dpp(
>   	clk_mgr->base.clks.max_supported_dppclk_khz = new_clocks->max_supported_dppclk_khz;
>   }
>   
> -static bool is_mpo_enabled(struct dc_state *context)
> -{
> -	int i;
> -
> -	for (i = 0; i < context->stream_count; i++) {
> -		if (context->stream_status[i].plane_count > 1)
> -			return true;
> -	}
> -	return false;
> -}
> -
>   static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
>   			struct dc_state *context,
>   			bool safe_to_lower)
> @@ -295,22 +284,9 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
>   		if (pp_smu->set_hard_min_fclk_by_freq &&
>   				pp_smu->set_hard_min_dcfclk_by_freq &&
>   				pp_smu->set_min_deep_sleep_dcfclk) {
> -			// Only increase clocks when display is active and MPO is enabled
> -			if (display_count && is_mpo_enabled(context)) {
> -				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
> -						((new_clocks->fclk_khz / 1000) *  101) / 100);
> -				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
> -						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
> -				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
> -						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> -			} else {
> -				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
> -						new_clocks->fclk_khz / 1000);
> -				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
> -						new_clocks->dcfclk_khz / 1000);
> -				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
> -						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> -			}
> +			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
> +			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
> +			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
>   		}
>   	}
>   }
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
