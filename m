Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E6606A31A
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Oct 2026 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RqSgEFOj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6293B10E8FE;
	Sat, 31 Oct 2026 01:47:30 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D8210E8FE
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2026 01:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyN3amOiQn7x8KMKUV+aEtawPfkIP9SAO0VZm5l03vDOHC3WT6NaIboD75iquASouTYpnX4unxDOzuDtaFZ4eaaHq4I1WVci5JT72nOHGUI7KePECiuF0I68r2L49AIylHjaGk31B9pOqlkSegIVGAMjVGrqC+ff5jc25vcN/OP0e9x1tRZonW8l3vVzg+9i7JHt36SNtl4N7qm2YJZ70wrI0fOqSvIFBHR89EEcjvXRQX0d7YvB3TD1NjVkzogHX7sW7dcXv+GkAMRXL7rRIaPsOeoGHXKCilEmEM0QBa5Nd/AqbWCH033PoS7ddghUJlq98tX7K3ieYRwtT8Tj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEIam2Z/Vq+DfYom09TA5hqVP3zX6KIeq14VT3T6ClU=;
 b=OCSJCErkvk8pLFkLthCg/M5esR2EgV2F+0qLjz946actuGxrkPe+4zgrgYkE4q5SGsTxTDBxty5dtHf/3f1XMwbc/JJ+LPIXuvzgGEPGyAms9Ov704Z3hr5fONcIhkXtI2TMffCX/f2vBTU8E6Is2+8nwsHqxbrT2o2lMfmO4slCDOpnsnxbNg3ltyyGZzYDHkgp7r/QCm6jVScMsssWNlEdrSdaBCbNlkxe/ZyeR5lnHh9T2ECYPOIPDwJqLJAq+jt4cHTmvurwohgbbPlY3xkEITX5QIEASww2NwpLpGvy3hNBzN4vzB5/0O/wpIDzAkYMb8KHyNOX4y50Kzm38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEIam2Z/Vq+DfYom09TA5hqVP3zX6KIeq14VT3T6ClU=;
 b=RqSgEFOjzzA8vlKoh9IVtSNopv2NS+/9xbi7Tpv9/5alEcGc63uHOmeEPUtMRQp2wG3Q2WgzaLYHA6+ilfzDeqQ9QxRyoDoOJ7qg0TpzWyozFnwe3z0PK5ZIBKUNQnxWTebpujWPgxwGMh46Q8Cl/6DKlOIJZNhC1TVQyPqQhok=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by BY5PR12MB4052.namprd12.prod.outlook.com
 (2603:10b6:a03:209::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 01:47:20 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 01:47:20 +0000
Message-ID: <384d2df7-b031-4b4e-954e-05e5cca83ea4@amd.com>
Date: Fri, 30 Oct 2026 19:47:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Drop clock requirements on DCN32 when no
 displays are active
To: Misha Nasledov <misha@nasledov.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20261019234232.33760-1-misha@nasledov.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261019234232.33760-1-misha@nasledov.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: c16040d5-0cf6-45bd-70d2-08df36f0e6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|56012099006|11063799006|261026140227099003|261026121527099003|10067099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Jsthm0bj+k4pemHqaDmXh6hn/5lCToX5eruXEsCCGHqPL/GBwg47Gk/lhDgzLHLMyvLfV0F+xJNioKrEZZD+fTP35avhex/8PyQHxMQLESpoJcy7cVWUX/QikS2p5almfV7u+8BpmaTos6k2AZat5FqVCOPM+Pj9iSpZnG9OT6M6x1qfcHa6E7PAf4EcX4d1p7+FPi8Fk9ku4HrDwbNgO4RQ10pNEj4jRGCgfg1zO6lARak2rTxhW0vKXxqmJh16eJxsen96IZlSjhMikHO7sADwjtWmw0KInjcT1Fh7u2YmhPEzuPOZoGA07+kpzl5sdQW2dQMn2iO9HfrlPxsjpPoHZwxR0hv+5nA+oAZjPgvOzzL65JkAlSqMq9avsp+PHJWzLs5ax0sioqksXTULJThGY+9AAqQJw0mwWdKatIdl1Ij27fWu3O4W3ySmgWUaABUI0KnUgJTwBVkVDmHqJrvC98lqsoIyTymgZhRmnZSZGPQyRrqBqzfCfndS32jK1RciFNKVd3FxsconOIs8NA1zbLUVfutb8XzJ2BpCOtq7SgGUR5mGhCnNMGjj7Y7X787bJ8NLb5GaRMzCg5UK7gXteoej+2yxEdXP7GYs/SjatJnJm3Qc6kZ8TC4CMGCq4KANQ6AibZsUkc4PgQaNPxZA2WsnXFdqrIBTUolgo6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(10067099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aksvTCs4ek5hcllzR01aQUdzVmU3U1psczFQZm02akxRejltMDA4bnZWY2Zq?=
 =?utf-8?B?S3VnZnJQbGQxU0lSd0hSQ0dFTy84d3NHMjQ2aUo3R3hxQ2tLN1hpMDJlN0ZG?=
 =?utf-8?B?N1M4QjF6ODZFcE5ad1pMR2dFVmIzM052TWZOcjFKakcxK2M1b3lETjJqazk3?=
 =?utf-8?B?Y0J4eUUwR2tXMEJ4bWErUDNVQmNENkF3ajE3SjhvTzBSNmdpQXEyVkp1bDg0?=
 =?utf-8?B?MVpYRmFLWHE4MWRBV0ZsdWxnQmdwOGR5VnNZTU1QbUh4WXhPUkI2QmNsRzZW?=
 =?utf-8?B?a2xmNHFQUlFpTmswYTUzTnlCcjQrbkN2ZmlKYmpqQ0lBSU1kQ0dYUHBLeDN2?=
 =?utf-8?B?ZVlIakF1NzIwQWkrSXREb0Jvd1dzMTNzUDZTNm9PZEs0QlFuRjhpOWhVVy84?=
 =?utf-8?B?aVQrUklONEZ1eVVzN3c1SmozV09kS0xBcWxZNkcyVVJ5MHJ0L3lvSU5CaEcw?=
 =?utf-8?B?eTR6WGw0YlVEa2tScnJSZk4rQlVDbDJQRExoWXpLWTRJYTRGcVNyWE01Z2wr?=
 =?utf-8?B?VzBReFRJKzYzNGFxZEZoK1l0eGROKzNmaXpabGhTQnFGejIweGxOWnRKWFR6?=
 =?utf-8?B?RDA1TjZtUGg5VlhOTnF6NUpxcnIzUi91b1RlU0dHR1lQcFBWR2hMYmNJL3NT?=
 =?utf-8?B?dmxrV0xENkVVQXNwclFxS2Z3Nnk2RmtiRW5iTDhOQzFDNXd6M3R2Z25yTzg5?=
 =?utf-8?B?bzNxUTdlbkJiaDJ4czlLTmZWWDIwWEl6UjE0cmtEVG5SS21RR3dDcU5ZV2M5?=
 =?utf-8?B?V3RBVVUreHIyQk5yVUNXNGNLMFdqZVExZ0dZTTJZSG1RZzFGMnE1bE1RMGh0?=
 =?utf-8?B?SjZYenI1UW9EWDN5bkZRczl1VXBEZHJMbVBFTDd1U0dycUhTRmV2eGltRHFE?=
 =?utf-8?B?MGNuWFRGYWh3Yi81YjhrSWxlZURMcVZXUllBclAxRDN6cmtVTHVob3NpTHVT?=
 =?utf-8?B?R0RmWDROdnBJV0lDTnNzbno4c2tnaFZYVlRMeTloc1V6cldld0Zta2J1ZCth?=
 =?utf-8?B?d3UyUlpxYks1SmhvaktWWWZTSFd0NHd6dEgvbzlmWklpdnd1UTFlNXhJeWNE?=
 =?utf-8?B?SGdTNmxaR0MwaG1SMk5yNE9zQmprZGRzT2NQQ1lwQ211ZmpuRE16T0tSSDJJ?=
 =?utf-8?B?UUZ0ck12M0F6SmpJYkF3OENsRFRnZXB5YjFpbVVDRXBRcjJrOFdQL3VKYm04?=
 =?utf-8?B?bFBOekpNWHVzN2NvY3BXVGNZWlFRMi9aYlZIekdJY0k2UUZuRytMemk1WFRO?=
 =?utf-8?B?L2RvUmZpNXdGRHRuWEV1VStWcFlQSmQvYWpXdmE2bGNkZ2hITktmMjdwSVc2?=
 =?utf-8?B?RjJsRStlTEZubU5PcXphQ1JVV2Ivb1MvQ01iUlBPbXVVdXVtdklVQXZIWmdL?=
 =?utf-8?B?OFUvK1pXQ0lSMWdjVTRLV0Q0eXVldGRWTUNaR2RZckVHTTN5Yjk1RHhWdGVl?=
 =?utf-8?B?M1Blb096OHpXYkhkWEE3MkFnaEdnbzFvNHlzZDZ4Q1RTaEVvUG5MOVpWcnl0?=
 =?utf-8?B?c01xQldzOThPMFBTcE42UDA2V3pWR0NQUE5sZG04cCsrbHVqWnpDMFd0WDJB?=
 =?utf-8?B?eXlRRmlVSXpXN1ZvUFdyR2NEZm93cGszUTFoL3VEOTM4M0psamlMcFdsUVd3?=
 =?utf-8?B?VTE4dEt4RWd6VHhWODdxTnhtQzRFV0h1alZsTHJmelM2SHAvYlNNcWJnNnZK?=
 =?utf-8?B?ZWduNzAxVEtGYnNQSzhRbDlQVmZId2FQSHIvUlRXQ0xENUVXT1h2WTRtbWtP?=
 =?utf-8?B?cDEzWFZ5eTk5ZjZrZ2hNVlU2Tk9nVVJpNjlsMjZSMlYxMnowTEZobUt5dXJJ?=
 =?utf-8?B?RUYxRlg5VkVHN0VodnJrOE8yVHNQQnoxWnFSNjNmYWZLRS8zczJBZXRQcU5x?=
 =?utf-8?B?dkV2OFBjYUw3ckdicW5wSGd2bW83OHdhV3NHSUt2clVzc0tJM0NjajJLS0t5?=
 =?utf-8?B?ZGVUblNkaGRWSjhqdGxXTE9NS1hLTWJGelZqd3FIZlc2T0JkSUNYSENGSEdo?=
 =?utf-8?B?c3EyTDkvY0JFdVhQcW5TVld3bmYvSytUQjVWSmY5U21yT2haNlhjN01VRERx?=
 =?utf-8?B?NjZsc3RaZVdmekhIR0VUak9vWStzK1huVE5YZlBXQjZaeThNMHV4TW9hZ2JT?=
 =?utf-8?B?NDFsRjVTWXZnNkZTcG5ha3VuQjl4YUg0cDZYa0JCd2FYK1gzTmgrQ1JMQVpm?=
 =?utf-8?B?WTkzZmlkVVRNV3U2YklJVVdLb3J2TDNnQk5WS3BnazBiUXNXcC9Fcitmdjl4?=
 =?utf-8?B?cE4wSHF3dHpkR2NEOEs1UHRpbzFmL2FEOWRLYWFhZVJyQ056NFZRYVpUakFQ?=
 =?utf-8?Q?IikoqP6S9tIO/IpSzQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16040d5-0cf6-45bd-70d2-08df36f0e6ad
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 01:47:20.0828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXzjVK9K+pdS4opcV34KR015kOpnJwDwVw9IgBv7bsR4DxTkCDRYQ0jKPxHeUUpY25c/dOnPRztCRa0FlFLneA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/19/26 17:42, Misha Nasledov wrote:
> [Some people who received this message don't often get email from misha@nasledov.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> amdgpu_dm builds the new dc_state as a copy of the old one. When the last
> stream is removed, dml1_validate() returns early on pipe_cnt == 0 and
> never reaches dcn32_calculate_dlg_params(), so bw.dcn.clk keeps the
> dramclk/dcfclk/fclk requirements of the display that was just turned off.
> dcn32_update_clocks() then keeps those hard minimums applied.
> 
> On an RX 7900 XTX this leaves UCLK at 456 MHz and DCFCLK at 637 MHz with
> the monitor off, and the board idles at 28.4 W. With this change they
> drop to 96 MHz and 145 MHz and board power falls to 15.3 W.
> 
> Reset the clock requirements in that case, as calculate_dlg_params()
> already does when no HUBP is active and as the DML2 path does for
> stream_count == 0.
> 
> Signed-off-by: Misha Nasledov <misha@nasledov.com>
> ---
> Tested on an RX 7900 XTX on v7.2.11, where the patch applies cleanly.
> This version is against amd-staging-drm-next.
> 
> I used an LLM to help trace the clock path and draft this change, and
> I reviewed and tested it myself.
> 
> DCN 2.0 and 2.1 (dcn20_validate_bandwidth_internal() and
> dcn21_validate_bandwidth_fp() in dml/dcn20/dcn20_fpu.c) and DCN 3.0
> (dcn30_validate_bandwidth()) take the same pipe_cnt == 0 early exit, so
> they probably keep stale clocks with all displays off as well. I've left
> them alone because I only have DCN 3.2 hardware to test on. I'm happy to
> send the same change for them if that's wanted.
> 
>   .../display/dc/resource/dcn32/dcn32_resource.c    | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index c9eba16ef359..c22ffbe74d9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -1941,8 +1941,21 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, enum dc_valid
>          out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, validate_mode);
>          DC_FP_END();
> 
> -       if (pipe_cnt == 0)
> +       if (pipe_cnt == 0) {
> +               /* The context is a copy of the previous state, so without this the
> +                * clocks the last display needed stay applied with all displays off.
> +                */
> +               context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
> +               context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
> +               context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
> +               context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
> +               context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
> +               context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
> +               context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
> +               context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
> +               context->bw_ctx.bw.dcn.clk.num_ways = 0;
>                  goto validate_out;
> +       }
> 
>          if (!out)
>                  goto validate_fail;
> --
> 2.55.0

