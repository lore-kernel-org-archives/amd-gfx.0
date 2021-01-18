Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCECC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 15:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63A4223DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 15:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63A4223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF636E2F2;
	Mon, 18 Jan 2021 15:23:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52A86E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 15:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfWg4iugKCfaiGMYkmpVnNzukkk1IGHyArGhgWg/6JfpxiWutYRfoONBJ5SSRhjqoKsOE5ydQCGeVSdhJd/A/9rHWBfCP/+BDI0efUTQGvbNRQKdRauRpwoTUNvY92g+bMKLrUZdbOfHW6Gd/TlZVZ4znAW1HHL6LZtJG4ONa+vsaVSTy3uPAnXfbtsdaX4865vXjEiB9dG764oTRwJdcbAPIZHh1PRDE54G6BO22fX1JSIkZgSVB38m8iGkl9b6BEwN/FTnWRKp1gaL1cYDpNN1K8n65u8WUPtxfvENc4n9jtxzYCLpSTEBokfSv5pJdgeIsYO4gfBn4fC32+9d+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZqzEHvpTeoLlsyaEnG2vYlQ1octPdkYpcgSwH4nFNo=;
 b=cYCvLFzyqyyaaSbZLhYZit/YjOvFnhDbXptAyPH2+4DRX93cM5dlgIyE5vQ+kjQfJd0S44t75aAnHNOJXGgqHrk+fQPUPI8JzQiWpVUUWedE9dqVUKFpTBDeVNz8SQaricPVDu4uxwcg/O9xeZhycnU8AUJAKq7t36YerDnv91XO4xgvdxn0LgcnhiQ0QyFeMO+1fme2sn69NRt2Mx/1mTWDv/qfZStYDzxDCGQPB3PaVqGNxnzdl3eO5O3DHNp+WaH7lcFSwyry2gqXjIPlr9EMFz1GUzgRRfaXIStCrZFOhTzykM9Vr09jRkZUf/DRRYqHT/6sWzQRiDZye6kY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZqzEHvpTeoLlsyaEnG2vYlQ1octPdkYpcgSwH4nFNo=;
 b=wKZqZn0nLgPJRex0fruYS1hEpqfGG7FzV3Z3ci7Isc5V6Y/9nzqQYknYKk13WAHQN34u3KQpe6plDbn00Nf/Yhu0GTNufNSph5aLXLWvNHaeg76CTtwel63epYMiKW8Vp95GPQzKx8fWt8DL9gUjt8CUvBU5yNi6EkDz3SN6i6A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1806.namprd12.prod.outlook.com (2603:10b6:300:10d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 15:23:53 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::172:235e:14a4:bdc6%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 15:23:53 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: Tune min clk values for MPO for
 RV"
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20210118110341.489585-1-Pratik.Vishwakarma@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <d671be6f-4e8d-3d92-fb53-c0102702e7f7@amd.com>
Date: Mon, 18 Jan 2021 10:23:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210118110341.489585-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::30) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Mon, 18 Jan 2021 15:23:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1746bc9-0e90-4200-fe64-08d8bbc510a5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB180696337ABFEBAC7B8FB41C8CA40@MWHPR12MB1806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:217;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fbrBjyoOibjNaPRbQAZhZOdc+ye4GxgXrkcdmRA+SkgYkA46DItRtDYayGuE65Zu3+z+kweCe1d3rjfuBW6sg7Od5FJcMo6/pnyaoybwkiUG6t7+EQAt6s5VVLSFVvYYWMmp9gMA11HNnDLRDeACdztS9Ce6cyufK8Yt/KsRnXBz8yKaYR98lY56alaoq6hOEg/B/FRUIo9ilSBZ5eVl9dIH9sFvlvZiuaQ0IkXUXCpFKDhsVrpg7YyyekV0KRn/8dFdlsazERKIp/8z1mcpKLR07pFaYj27xZrztECiptkzUSfEHcNRMR+Vg48eDFHyxItdZESrguFqB413v7rua9FfF9LM8jS8/fg9o5F+KmfTS73defwckQ5bocACogf+NETG2PUHDRonRbp+H7vnLrIu7il7RY4FePUWINVueH6/W8XJjL8byedJpXQMNAMJoZ4m7vKKcPxEpm9dAtPIUMP88IScMqsm17JAUgX11k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(83380400001)(8936002)(6486002)(478600001)(5660300002)(44832011)(52116002)(956004)(53546011)(26005)(16526019)(66946007)(36756003)(66476007)(31686004)(8676002)(86362001)(66556008)(316002)(2906002)(16576012)(2616005)(186003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWVQVTQwWDdoNDNobDZDT3ZMZjlzaDJlRi8zTVlGU0VmWVJYVm1PVFZwNVNB?=
 =?utf-8?B?THN6QnBBbE1pQWdYWHFzLzIvRy9hek05TU5saHR3cDJmNXhCa3dCWGdDK2hw?=
 =?utf-8?B?MnZSVksxUXVLa0ZZZDlpdndMZFFxMkUrekQvVGxjY2ZBazcrbTM5aEVRSGg4?=
 =?utf-8?B?V1NCV1BXSHZPOWdocko3YXlLUW9CakRKSzJmMjFkYks4em9zU3FiMzlOTjNY?=
 =?utf-8?B?WkZhS09QYk1XeVBYemRsUUcxUjVVQXIxOWJwU2g3Skg1VGFzUFFZUG5jWHNi?=
 =?utf-8?B?RjBwK2ZsNExqUVRKbVJjaGJqd3dmdDNnbXBaZXRGUkZ0ZUUyWk1jWHQ0bkEw?=
 =?utf-8?B?eW1sR0V4OExBeVpIWEdBcjd6NTRUdWU5SjVoMjNLMFdQU0IrbXFnZEovMmlC?=
 =?utf-8?B?d3JYMkc0K3ZDN2w4YkZzb2dPUWtDWUxtaUM0U0poRHVoSG1VOENDYUVDTDlH?=
 =?utf-8?B?akkwZXA0Q2wzNkR2Uzkwd1JsM0p3NncyK2pTOGRwOEJrTS82TG5FSUI3R2Rk?=
 =?utf-8?B?TS9lcXR3dkNRbzBVWFFLWTIzQjlFWWIzSnF6dTd6QnNJNVNHNk03K2k4R0th?=
 =?utf-8?B?OTlYWjZsaHNZbmszaVlCaHZzS3dhL0hzaTUwQXczNFZXRThVTXQvdEVaZm1I?=
 =?utf-8?B?NlducnJOTFJLODNNOG03RWoxVUdBQnFGcTgvVE02RFE1bjdmbTRhV0w5ZTZx?=
 =?utf-8?B?U2YwUERxaGc3V0RseFNzYmt1SFlseER3VnFBUnYyaTNLcEtzQWQ2TzJqRU82?=
 =?utf-8?B?TW1aWHdIVkhsMFFXbzlyam9lQTNuRmhVZENrdCtIQnNaRE5RME1EYU1laEVw?=
 =?utf-8?B?WDNZcnNnbmZsRmY4S0dnQkNuU3M0aVM2em5KMFdPaS81Z3haUXd4RWtKNjQr?=
 =?utf-8?B?MndnMHUwRUY4bWR5WDNtamthTyt4TmRSVlJhVmUwakhiZ2JWSm1pWnBEZ0RO?=
 =?utf-8?B?eUdTOVNaNkltS0NpS3Q5SmtzbTl1VFVnZFVNQmpwQkpMTnI0VnlZZHAyMVhG?=
 =?utf-8?B?RWdwNCtxWWFWVEtYc3RFaVd3M0JFSGZDTzkrNllQaW9MME44dEVkK1pLTVE0?=
 =?utf-8?B?anBCbC9mSlRWNmJCa3F6L2xIUFdoZXNxNmlVamI2YnE0ZHUwZ09rL281Nk9Z?=
 =?utf-8?B?Y2paSXFXbkYySWhtMW4vY0tHR0c5ckg1aVVOVkY4ZkNxd3RNNTNWVjlOa2FO?=
 =?utf-8?B?RGx2TnZqdlhidSsvdjRsMXk1ZEQxUU04YmllY041cUV5cGpnOWc4VkovZ0Fh?=
 =?utf-8?B?Q0l6MUgwT3dXZTV4UGJON0Q0QXVpWHNqNVRNL0xGTXBtdjQ4akMwSi9sc3M4?=
 =?utf-8?Q?a0oqzQ6cskOUx5ICf4XsZb9WQ4+bwcW5Bz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1746bc9-0e90-4200-fe64-08d8bbc510a5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 15:23:53.7590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N37akGW68TyiVB98zjVXwpFSBGi1wJOfFt0ehgA7nHohB+RxtlsnydxCuTDgcwcikaFlFqmkds240SdY77INyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1806
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

On 2021-01-18 6:03 a.m., Pratik Vishwakarma wrote:
> This reverts commit 6f3fca64cfb91fedf9b34ea27b2581e88d48c9b2.
> Flash line issue when MPO enabled on idle screen was fixed by
> commit 9d03bb102028 ("drm/amd/display: disable dcn10 pipe split by default")
> 
> This patch is no more required

Do you have additional details? I'm curious how/where this was fixed, or 
why this is not required anymore.

Harry

> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
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
