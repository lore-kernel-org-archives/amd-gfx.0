Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C986C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 19:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36BC10E2AE;
	Thu, 24 Feb 2022 19:13:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A698810E2AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 19:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7MVdzaf0tej6/OZiRCVCS/ZDILF7IMndtbN8mg2fVtITZs3orsadI9s4STd8pSn9rfwpxgfkC9uDOANc/Q+5Hht0LD3kCov9hElLMnJMiZd2X/fifMFKZBIqFFDMlRCjdVA52JMDC0H0ALcIcnAYZElfhqx9vulum8wHP7b7pxeKHKLwp/4TbbldzuTECD9HZMWquGbwFK9ckVG/EWvAZGdhJuUo9dg34nJDLBiUyeSWoxf3ycXd551gvhgeCpgPQ4yxGEeKJpyt4oUSq0DBQiQOxWT5WdJfiARGfnGJ+7G4YzmkwAFal2U1yyMzyab7CyB5vXpjEMZwVchGQGu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvqUPhLSLGTWb3uOwujrUkm1OsQw2vs1YYe5+b8Msnw=;
 b=isEaAAM/UpqpXJbBDYjxi+ZK4Z8aQ9b7NKUir7N45IYWV8NRg37Btp+qcJAjy9jh3zv6hh2crmDG9ai6JLvXMTN1Y8qpVsmVRWESGTMqV+zMZxiBYeB667STOdoirXdV8b8eDFPNi5oaOVnZFyKUQrXoYaQnhyr5Ssgxf4inLG4E+fq3xnNIAClkQde4nDo54t7Y/1/ccjx1l5nJc0+H4lMkDNBeuueweA7+Tm8DoU7V0245YiODAj8erDGnCDhKaFtecoaODtxCfiEBWL3FaVMNi0a+MnXYGB3e1Zr6Sir5ZBDt51qskE6SBXl7LsSwYOj9thCti4bHy7FLb+FT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvqUPhLSLGTWb3uOwujrUkm1OsQw2vs1YYe5+b8Msnw=;
 b=ECkoe/1xCSuJGyzeUZP+VCz44ZvUulHmpgto4484N+ivsSS1NN7XL92wtc6HATLIUluFrVXCNRVGcDeqeZi7igDPspHI/DWILQCbQucrzSc4V2IxHn//y2c2H62FeOi6I2wAojikiG1YedpQ7UhaxlG4d37/Fh5YmCvwLRW2iWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BYAPR12MB3573.namprd12.prod.outlook.com (2603:10b6:a03:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 19:13:54 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%6]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 19:13:54 +0000
Message-ID: <acb0deb6-9cd9-0a48-93c3-93b71fbaa7e6@amd.com>
Date: Thu, 24 Feb 2022 14:13:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/amd/display: Fix DC definition of PMFW Pstate table
 for DCN316
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220224182426.1399145-1-sunpeng.li@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220224182426.1399145-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::48) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30f22471-088b-400b-4160-08d9f7c9cc19
X-MS-TrafficTypeDiagnostic: BYAPR12MB3573:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35736854C4440E11D83C852B8C3D9@BYAPR12MB3573.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MK0i9unuXgDKWQ6z5SMxgEA4N7LEezyktOSTdXK46ctPLheMLZXivnjEwy1aaIpVunQkoq33plVGYdUy+6uByVlK45fyzLUNBTOEROx1cuSf3hmHTKlZmWZKjL3OEB6O0sKVehhtYjshFu/i/Xp0yeyIsGqQuSdlix/EncJ+0SLIeSqzygCyjcxNMmZz+rLKqw00Rfb6ExD07SH+2K+W09lgiNhkzc6/zQRRLy5RMSpmmdxy1XxftYk5TDRouOTHP91I3fCe0H51Rk9NY/hJWSvT+/uSbKkYY7JlJEbyBrZweY8hndm7uO475Gc/bXyR/cWeif+9/qFrBNa0OKXk2o6097GgHJAQY65OvqB2HwTNkCEncIiLj76T1o+owJjgFJ7VgtOIhcvu67JnXtxQXREYDzoH4RKRWMl/T2NrMiXmqn4weHdrfwGQuHMCZ7K7t7BDKuH/Hfx8m4vePeng1+9AZJG0qfo4wZ2/Xwm0Fh9giThbY97YkugRYk43dXKmKegn1ucT4yHEOQDFWBXfXWxdw0Qg8s+xaJvc8p2M7rJ/P66vgvDyl0gw7hCqleXfzxp+WCGCeoKlzLCCL7VEi5PIcnE9sB8OwFuT5S8uXbyaujxU4vxQEgWL9AHs6J7vV1ucecNR9JdWi1l7ksQkH8u8LgEGBzKXNW7cOACkjHVw9zPUcLYk515Uji3GJskN1vtU0b1xk6k1IzIh4KEGk2znh/hk4U7ADV2ctU0XxkalqYrSIGPPOvNqHpn3h+i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(31686004)(6512007)(66556008)(8676002)(6486002)(66946007)(36756003)(6506007)(8936002)(66476007)(4326008)(38100700002)(508600001)(5660300002)(26005)(2906002)(83380400001)(44832011)(186003)(2616005)(316002)(86362001)(31696002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3h2blZUY291OE85TkFWYThuZTFzaCt4eGlRUWNEZm44M2ZnZ3J5TDFJOEVx?=
 =?utf-8?B?UkxZMkZlNFU5MVZlQ1N0NlBzbGJjRmlBcVdZZWFWeE1ubTJ1dzlmVFA0SmU5?=
 =?utf-8?B?VHU2Z1I5SFlRVGpidHdOaWE0THAxTlQrd3JpdGNrS3lSRmhNL3Fmc0w3Mklj?=
 =?utf-8?B?ajE4ajQ1MlNWRkRVbUU0WmNoRmVSSTNVaEw1S1ZWai9rYkRCcmJvWXpGNlhE?=
 =?utf-8?B?VFpKY3E2cDFFZG9qWW9NcENqaWk2aUFKQmErWUtGSEtTN3FNY0FrMzlBTzVv?=
 =?utf-8?B?THYwR0JqSWdXYldYUTFiaHB6SUlNeHdGZFNBQmxEMldSa05IM0Z6ZXl4eS9v?=
 =?utf-8?B?eW5ORWRkcGEza0tTT2NsUFB4SVY0WkNvWVRwajE2WjFFay8rcXphaHRKaGE1?=
 =?utf-8?B?cUJVYWs0bGp6c2lxN1JhcUFWb3lkRlQ0dTZIL2VMQ04rREpvSWJEZjZidjdX?=
 =?utf-8?B?OTczUTBOWVUvREhGQUpMcVo2M0o4eXJ5V09EeXhRQzF0cEloT2t3QjF6cGpD?=
 =?utf-8?B?V2VPZW9hRkF1QkJBcU1HUk52bTIvOW1iM0k5NFgyYmYyb1JLNDV0anJHdzFj?=
 =?utf-8?B?L2tjaExJSHQzQzF1NnVGR0ZKaFpUSmgvNHRsWW9JMWVoTEJyUFhQYmwvZE9l?=
 =?utf-8?B?QmcvREt5czRtckVEKy9CZUNSN1FrR2FNUy94djBIWm5JQ003cVhNaFJtb244?=
 =?utf-8?B?QjU2a1EzckZqSE8wMCt1WHlnNDA4MnlaQnN6RkpYVXYxdEhrL0tCREtqdlR5?=
 =?utf-8?B?V25FbFM4NFJpLzRvcXJQdEtrdGc1T0V0dGpFSlgyUXJtQ2ZuTTNhM21ZK3Ev?=
 =?utf-8?B?elhyM2VLa1d2SkVKeCtJZktvbndXbXlpdjFkOXIxWGxoS05EUER3K2p0WVgx?=
 =?utf-8?B?aUh5b0xaenp2RHc3S0NLSDRvdW9UYUtNMG5pY0VpbERJRW1GY052VWsyV3gw?=
 =?utf-8?B?OWpwUWJBSTZ3RjBERVRsQmJnN1BpUU9Ka3NnM1hNenhUeE8xeEIvdVRPbnNP?=
 =?utf-8?B?SFp4dlorL3hKY2VzSjFURFAwRVdzdHVRcndEYTRNK1VtTkhaTzhjTDgyRkJ4?=
 =?utf-8?B?N2g1ckg5bzlPRis1akZNMHIxTW81VFNhYzNqOXFlNjJHb2RudXJITllVMno5?=
 =?utf-8?B?QTNiWUFHOEJScmNTUWRZR0ZJSVdvU0RGZ09XSFkrQXZyMkN0NW9ndDYvenpr?=
 =?utf-8?B?OG9yUE9jbGRFNklLRzNtMUFhbGtGTEl0Z2ZWb3F4bDlMbUxVaVF3QndxV2Ju?=
 =?utf-8?B?V3hJREdZL0V1NVVBM2ZtcmlVWFRtdk9tSzJTYUZ3S0NyMFFpdzNwMEZoWkhW?=
 =?utf-8?B?YlNTSFZhREpHS09PNmkxZExEcGNGaFRiR2crZnU1dmdkMC9EUUZrOVpBU2sr?=
 =?utf-8?B?MlFyNjBpeHNRd2U4emhKUHNpSDI4L0J5a25YWDN5WHhZbDF4NDMwR2NFU1ZZ?=
 =?utf-8?B?WTloWDdmV1poVjdUK1pQMldKdTZMYndMR1F5QXliN1M2SE1Fa1Z0M1RMbTl2?=
 =?utf-8?B?L3RpTC9vL2NDNkxWOWtBUDdGaUhvVUl4M2MwdkQ5VThkWHNDWUJZZXpZYno0?=
 =?utf-8?B?VXRxSHB2TUlCclRGVVRzOGNKS05WR2I4M3hyNlVTcTEvNGw1SjBYQVpBUXN2?=
 =?utf-8?B?a3pXSzNEYW9uUXNsNHZQMDFWOGIzamx5RGx0WnZYWnZBMFArSXRTZXREZEdF?=
 =?utf-8?B?Mk5pbFUzQW5lQnhRdkFwcklvTTQzMWoyMUNFQUZUUGViWjgrU0t0ZGJlZGpz?=
 =?utf-8?B?NnN4MXJ5VWUyZzlhTDlhM0UyeHFzTnR2b2xhNE5OQjI5dmJjejRBY3JLL3BD?=
 =?utf-8?B?ZmtwdEo4cUZDU1Zma3BVQnkxV2lEMjRQSG1KaXo0K0JXUDNabUIwcXRSRUt4?=
 =?utf-8?B?YmpieU1WL09IWlV0dC9FMUh5dEJ3YVV6Q1NERkFKQy9UQTVKOXA5SlFWZHRh?=
 =?utf-8?B?cjlLNGlMM3Y3b3J6YlI1SnBaSytFMnkvOXNEYThQRDJzdXE3QkdRUHBqMWlO?=
 =?utf-8?B?UzU3Y1ZJVjUvYUVIZjllOHdCT1pLdUdTK3YyNkhlTmZWSmpmOGMzMFBTeVhY?=
 =?utf-8?B?S1dxWG1LQ041Y3UvaTZLWEJWY0UvTHViOXRqOHNxclRWdzl5WnlCdmJvNytK?=
 =?utf-8?B?eUI0ejdoeEpPT3lNZXhIRy90UFRCQ0w1YXFlVDczNy9tUEFuWVlBQnY5MmtX?=
 =?utf-8?Q?xOoFSXdDvL+q7WnKVxTp1H0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f22471-088b-400b-4160-08d9f7c9cc19
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 19:13:53.9341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Eb9NzlaD8bRG2TNpjo2qyCqFSaJEFgFf2okG4x/mG7pblHY/4W+29P+qfjVAseGlVlN56vH2NZ9V/vQ5W/TMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3573
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-02-24 13:24, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> During DC init, we read power management tables from PMFW. This info is
> exchanged in the form of a binary blob inside gpu memory. In order to
> parse the binary blob, the correct struct needs to be used.
> 
> [How]
> 
> Fix dcn316's definition of the DfPstateTable_t struct to align with PMFW
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c    | 11 ++++++++++-
>  .../drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h    |  9 +++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> index 02a59adff90d..c940635b7a74 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> @@ -530,7 +530,16 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
>  		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
>  		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
>  		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
> -		bw_params->clk_table.entries[i].wck_ratio = 1;
> +		switch (clock_table->DfPstateTable[j].WckRatio) {
> +		case WCK_RATIO_1_2:
> +			bw_params->clk_table.entries[i].wck_ratio = 2;
> +			break;
> +		case WCK_RATIO_1_4:
> +			bw_params->clk_table.entries[i].wck_ratio = 4;
> +			break;
> +		default:
> +			bw_params->clk_table.entries[i].wck_ratio = 1;
> +		}
>  		temp = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
>  		if (temp)
>  			bw_params->clk_table.entries[i].dcfclk_mhz = temp;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
> index 4c6b202fe622..658b36d0e107 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
> @@ -57,10 +57,19 @@ typedef enum {
>    WM_COUNT,
>  } WM_CLOCK_e;
>  
> +typedef enum{
> +  WCK_RATIO_1_1 = 0,  // DDR5, Wck:ck is always 1:1;
> +  WCK_RATIO_1_2,
> +  WCK_RATIO_1_4,
> +  WCK_RATIO_MAX
> +} WCK_RATIO_e;
> +
>  typedef struct {
>    uint32_t FClk;
>    uint32_t MemClk;
>    uint32_t Voltage;
> +  uint8_t  WckRatio;
> +  uint8_t  Spare[3];
>  } DfPstateTable_t;
>  
>  //Freq in MHz

