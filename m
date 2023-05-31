Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C365C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE4C10E1CC;
	Wed, 31 May 2023 14:16:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2145910E1CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMMzJDVG8xhN/StOrFS/aACEY7rF8DYy4OpHojwFnduHddVQ+eVy9PHV8isnCe0rVQErNsG//uTv05rBr4hsrMT3qlgROxBML5X+V6LauhRQAAz44NJAy09S0ku8xOph0PMxw2d4GNxvBv7/gKF7YthYuM21GbMjHtQPc0qV/God5xTmUtdrtFs8EoVARzlUnvTtbbW71a4FBxqkado6ovVtG9jbVAjgVuLRfDw1gIKAyCBD2sHIM9EyfHDBVJB2v+uoDyuk2rEeUzf6lUr3cmv6lFyaDkQv6nrhUw+0Tlb2HI4Oypn/eschgYpGMntXCzZMuO8EWohCqm9nJm5EMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3Xyp0pi/zasc428zf+Vtq91Lq9QTPBg0vyRQ0hjHRg=;
 b=gSqKrOIpuY7ruvPbupAg/S++pfU4Cox+gM6MSHTyOJKVJYqBXA5PtS4ZXATkRPc8vB4cwK4vhMA+jAbArdSCzUDIaH8cB2dV3TZgA159Pt2WeolV92xZm28F9qE2KUZ1m3Nv6C+e8XP17FtWR43fMhyz6N0s6Tx7t1qo1+8Z4V7SnfFPZHwpZBUk/RKoXicLyETq4DaKGEd/cxiXPoH9yFL2E9K+y0lVqrvabXWneWY7n0HGp7ZnpDaF4w6G7Q0bZt6K9NNQGNDRZ/DA+NA4FEQ8d9Ntuz4uXMRCgeyd57H6Ai8nOp3Cu2iB6inQWxFUNiPlr9+DhJFuJI9zwrxarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3Xyp0pi/zasc428zf+Vtq91Lq9QTPBg0vyRQ0hjHRg=;
 b=0eofTcYC7tBK358eMLEhSdCXF7P1sqXzrjgH4v8wgEc2o5Ngl5Jh+co6W5vDRdE4shDTbxc3NVYCMR9h065F3FsG+OYOBL3zeWYx04jenmUaCbRd2NYP5BBWmAf+6lAn8Ts/rssMjLfNQIAEmV1MLPT4ogei3nYdhTjgF64waaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 14:16:46 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 14:16:46 +0000
Message-ID: <b82a67cd-a968-ae44-c466-a97958e66897@amd.com>
Date: Wed, 31 May 2023 10:16:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Fix up kdoc formatting in
 display_mode_vba.c
Content-Language: en-US, en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20230530190814.3116237-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230530190814.3116237-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0313.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::26) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d776ca-9f91-446e-0a13-08db61e1aa4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9DoJfliJ9ZSMVagaL16MsPkowWVN3lZJ1lcwZIP6iyDhUAMKIRHli5Eh33+5iEszcGtaPeEeLrWJOEqd//EhiHWS4XgaRfjgf1s3/CgWI/WavSoFGoUSrG3khJGjmeDaKEpyURIfk4kPxTW7zuhOXB1voscrt9VQMI9/xX6RJ9t90M3bG0PmCYABdwIgKIPzFlf2WtDaYc+lycAG6kL/Ml7nIE/rNmZ5Ad0NbV210cntL8LiL/gjua0HoB2VbYpF6J+MQBbwT0Hm7P6SFZ3X/okVT+gujfPh8ecWDtrsu3r01p4oxfCe6jOp+y3peiluSHmibOD0CLr6UuYHHUkLaO+sYAGPOeg8u/VXqcqmTDuuHVZbZUdu1tuX+k7kHUWT5fRCeqUKQVrT7klVaE9oXCpLpxcAYbxegx6V7Rxh2Q5EQr5/E+KSAzR0Ih5k/uqTcn6lZ9silaApWu++keEjVAe0dRTJ1tlgwzNBVHs037sauMLvEirRGyrnWs1QtisZNVmHHnzIfQDzpEExtPYGkmM7Hk5joCrirwRmsmqyRd6/pqz6cdIUTWlYGzEm3ptkCth9e9fKOgrA5jxg9HTkxFw2jx5KX6ajKuqYE7/jlg7Yb53xJegrn28JKhPViVIOu6Bxga118iLgsHVMzDglg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(186003)(36756003)(5660300002)(6486002)(38100700002)(6862004)(37006003)(316002)(86362001)(6636002)(66476007)(66946007)(4326008)(66556008)(41300700001)(478600001)(6666004)(31696002)(8676002)(53546011)(6506007)(8936002)(6512007)(44832011)(83380400001)(31686004)(2906002)(26005)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1XVzNmSndoNUFNRjNOaFFmR3AwZnJZZWp2SzJ6MGs4aWhpTTh2cW9obHFn?=
 =?utf-8?B?TkRjL3ViZjN0MGlNd2FPd0xkNTFDNE43dnkrVXhHL1lZUmRwM21kbFhHYjR1?=
 =?utf-8?B?dkU0dmJpVUJwZFpxUmFjMDVEbXlzanB2WEtQcFRBZUtqd0N3eWxKdm4rQU5X?=
 =?utf-8?B?WitCa1M3Rnd2MndjTmlJTytoREhDRXdBamhndjN3ME1JTC9RYlpLa0ROOEhJ?=
 =?utf-8?B?U3RjZFByNDlDVk1BcXdGQlNiQ0FPbnRyOExoQU9jUzJ0MVV0Wkt1K3F1dzdS?=
 =?utf-8?B?dWtRRGw4UXdHTWE1cmVkcE9JTEhWNHhJYUE4VkNMcGx1V3N1aGVabEJDUWda?=
 =?utf-8?B?ODNhU2NQYmRVSllPNWdhbHlVakx6M2lyZ3lsbHF1MTh0Mm5zSWZTelZvQ3Qr?=
 =?utf-8?B?SDZvNC80K2ZGRFdjOWwrTitMS3J2eFhpUndrTUhxdXFNZWVCOXJkaHluQkRh?=
 =?utf-8?B?bWJReWVrb2s5QU5IVTR4dGp1cEZmUHpyR2N1REdkUWhDdTc5UFZuVVlhUy95?=
 =?utf-8?B?ODdnMXZMZDJBV1BoSDBZKzRmTVJuQUhaZVdDRWJqdUExbEJleFFFNVY3ZW1E?=
 =?utf-8?B?L1FkVGFNc0ZtSGVnTVdWNThISE9oc21FK3REVlRpRmYxaUxvME5uTnQrd0k4?=
 =?utf-8?B?UTNnQmJwNmtEQ1lGaUljaWMrSFFWdTFDZGpwUEZWT1RONWovQnJnUi9oUkd6?=
 =?utf-8?B?bEtNVXloYU5VSTFCeDJpVVhTVW1lZlVaQ0h6emFVK0VEaFVVN1hMZ1RMdWUr?=
 =?utf-8?B?bk5CZWJBaFNwbG82NHpTeUk1enBXK1JEc0dpT2hMUUV0Mm51MUhjNHFkNGZS?=
 =?utf-8?B?YWc5eWJIVDJPWEFkbUU5ZVhlcGNSZkhDYWpMQktrbGx1ZlY2MmJncEYzNmFD?=
 =?utf-8?B?ZlloejNScjJtdDZCU2xGbFltVGsyYTNFaDVDcm5RQmU3eTExdUcwK0tSZkdu?=
 =?utf-8?B?SC9TSWhTcHJBZzZqWjMzSlZqbmEvRHV3WGplVGNzamlMd0doL0ZYaE1UV2Y4?=
 =?utf-8?B?MnpCRmh6YzhIMFJTNExjK2lxRy93UkxxdUtDYU1TN1hxaUhFZVA2UkdVdS9Z?=
 =?utf-8?B?QnNPaWhBZ3pmSm5zUFY2S0hGZ0x3c2tuSlAranlrRjlEcVowaDFZNWdIaGw3?=
 =?utf-8?B?MEhoTHZsY3hIanp4eUxBZnRTcm9Vdk8ydEFoWkpEaUg2VEt0RCt0cEpXckFC?=
 =?utf-8?B?VnpBa09qMm5LSUt2ak5wWUZvMFRGTkxvbmh4MzUvK1QrTG1VSi84YjZVTVBz?=
 =?utf-8?B?MHNyNWR3YmhqWmNtM1VJVUl0eTh3Y21sNCs4aDN5a2FaL21qT0tGMkpsQW5I?=
 =?utf-8?B?YzNQUkZjejlzQ3RjYlMxK20wdzZPWnhXbUp4b1NRcmZieUZHcGlEeHVBOHl2?=
 =?utf-8?B?QTBCVlA2cWhmYVVCdlRRSERWZitvWGgzdytjQjBOUXBmQjB4elJSb212d0Q2?=
 =?utf-8?B?TUZXTHh1WEtKNEhIbmR0M1JERE1XUVhMSk4yYy9LWlNUakdZOWEzRndkVEVT?=
 =?utf-8?B?TThZT1F3UG9NQ1d5d1VVNjBQR1BrRUdFcndwMytaZFFOVkxURWN1b09sUjFX?=
 =?utf-8?B?ek5Oc3ZNY1N1c0lJbjZicUR2NC9OcElNYmVDVE9RWEpCUXVJMWdKc1AycFpk?=
 =?utf-8?B?eDhiN1dXRjlMOThXbDhFS2dHdXpkaENPWm5pVEpqY0ZaOWJJeERXMlZJeEYr?=
 =?utf-8?B?a3JXbWdteUwvc2d5WEFmLzJrUlh6a0orbmc4T3lva3U2dWVkYmRIUU5wODZB?=
 =?utf-8?B?MUJkTmEzNU94OTBlQzFVVktZRlhxRzdsQmZ3a3phaWlZSHowdFVwOThXNjRB?=
 =?utf-8?B?Z1U5SjR2UEhLNTlGWVV0cWYrMjRwcDJXNGh3TFdGS1REZFpkbWdSbzdZb0l3?=
 =?utf-8?B?TW9pYVdWT00rN1BadFZsQzBTMXlNbXBtcFFmWXh2S0RXRTJPZEZMOSt4L3hD?=
 =?utf-8?B?RmxkVk9HSDhnUUhWcFJJUEIwTGVqQ3RaakxxSVRjK1pyMS9Oamh4QlM2ODhV?=
 =?utf-8?B?WXVYNW9lWkNYMUxRRUpRbFd5N0YvdDVMemYvL0JudGdaOWRPUkxUQ1d3d2Zr?=
 =?utf-8?B?Rm9RNVdUK09tRG1xTWsrbjlPbVRrUDBMWkljMjFIUjFXMVYwczNQWU9ZOVc3?=
 =?utf-8?Q?lKAG8hiYuwHM0J2csO2cVNA0R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d776ca-9f91-446e-0a13-08db61e1aa4a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:16:45.7616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgd9UhATZi6im7JRhf4/cksvTps4qLkFyKoQSrlFwPEfDFfpuRafVjx14o50vuVx/sLB2LVVSX1C/co0THt3Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 5/30/23 15:08, Srinivasan Shanmugam wrote:
> Fixes the following W=1 kernel build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_vba.c:936: warning: Cannot understand  * *************************************************************************
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> index 2f63ae954826..9a3ded311195 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> @@ -933,18 +933,16 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
>  }
>  
>  /**
> - * ********************************************************************************************
>   * cache_debug_params: Cache any params that needed to be maintained from the initial validation
>   * for debug purposes.
>   *
>   * The DML getters can modify some of the VBA params that we are interested in (for example when
>   * calculating with dummy p-state latency), so cache any params here that we want for debugging
>   *
> - * @param [in] mode_lib: mode_lib input/output of validate call
> + * @mode_lib: mode_lib input/output of validate call
>   *
> - * @return: void
> + * Return: void
>   *
> - * ********************************************************************************************
>   */
>  static void cache_debug_params(struct display_mode_lib *mode_lib)
>  {
