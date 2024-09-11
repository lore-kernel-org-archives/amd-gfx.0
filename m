Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD979EE01F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 06:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A42310E9C2;
	Wed, 11 Sep 2024 06:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fIy7eJis";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2845B10E9C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 06:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyBeapjxxTK8ui2kUCkTDlGJCLIGFA+0ffP1qLrxEtb1HQSewCvDt+CBlaKnJxG+tSvfQjFdM8ZzVHCLvkJB7nwApMcdFArxJLG1GNp6qTqdc3L9qnXIIxDQVmn31PI9d9BZNaFPhLbJNuaYt7nOIozraGUVq1Lc8JUEpsjwoeFDhAkeos+eJIDtKihvXa65eDlrcu244WmiOEdXK1bUZPANY4gifTOWrJxpNka+zmOe0YE0KXH7M8bAIz9tdFh69UbDCCngiMRvTCsi6DlO7XdyIn8G27bzCiP1/GenRcDjbBYhaAMePWu8bWcYl+v+13mDV4UxyzQt2LZfa4RFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07Vw5ETBz5dAzFIljQR0+g2RGIqSSDxfNJ7cj48k768=;
 b=kE6+DZZJJne7v6wRPip3OF90PsGTaqU7ej+Yaz9zcGK5cQPSsHkfJl9pkyyR2dHTcxtd10GYc/UYUqzAXTy/R2JNuVFkS3l7+o/5WwsCNkBbGAaBj37RSy7t7ZUtxZfXyS/SFTrznRfM+r6mYjZptjGcdaUs4TnMbwNwylmMlY7ryk+cACmS+/QbE1+uNYWc1obKoZTfrj0YZcwkM9H29PETCvnaGYnYL6xa7hXebsfA6AOcoqeR9kRSfYoRXV1jf9jrBDOdvZCmPcITvkoA1qh/VVFiH5s93VVGtxQ0fEq8w4UkE1XF7Td7eNLqwjtJetiwrX666bExpNsUo8cWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07Vw5ETBz5dAzFIljQR0+g2RGIqSSDxfNJ7cj48k768=;
 b=fIy7eJissN12x7Jon8BAGdQpj3+ZlSOLFCEtjIwz8PCat6vA7adoUHFEI9AeRJiDXfUvrm3CsLwM+P8zu1vT2njvVrnWbMuMvIETuYPClMrlDIydu1Im2MU9pw/SN9SYjkdSuQcQa1D1VcPAKC4hsLlkdPm6kfQ0Jc9pqi8GFiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 06:03:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7939.025; Wed, 11 Sep 2024
 06:03:43 +0000
Message-ID: <3f65ec1c-1da5-4d9b-8e26-d678a014eb79@amd.com>
Date: Wed, 11 Sep 2024 11:33:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx9.4.3: drop extra wrapper
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240910144957.2728976-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240910144957.2728976-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: b49b9162-fae0-46f7-7ee3-08dcd2277d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWpiZnI5L0Y1Qmx0SUVZZnZjUjlDZ2VYUnR3MFJWK3AxdjI4SStGT2tBMEgy?=
 =?utf-8?B?a0pBMjBqMEEyNGE1NTRMdFduS2UvWS9udnFBL0M5WHdmMTM3R2tTMEU4Unln?=
 =?utf-8?B?NVZzbGtiMWRwTStYeEU3Y3JiWVBoWTIrQWJxOURqNGNKR3pRczQ2Rlo1RkNT?=
 =?utf-8?B?UkpIQlduNFkvNk1rOVNPb3hIR1hBSVEwS0FrT3FsVzJ3ZUhuZWpZV1h2NitV?=
 =?utf-8?B?T3p4KzdINnQ4QWl0OVBzWkI3V0RRNTNONG9JMGFVWXRiTTVGbUZJblA5Tmt4?=
 =?utf-8?B?eFk2OTJxMjdpU1BhNnRFbHh3RVRIT0R1Z1dFWE15TDUxSHdObFdXQjAxdTNU?=
 =?utf-8?B?WTBSMXdvYzBYWVhEakphdGFvRWplQVA2NXlxeHNPd0hPeHhvSzRsbE12VEtY?=
 =?utf-8?B?NGMvMkRKc2ZXUGwxMW9RQjYwT0RCOGdZQXpPRkxpbk16cVYyc3NkSDdIZjZs?=
 =?utf-8?B?c1dWTktKVFFJZnF0dFFOc2d3TG9ZSFE2TXNXQ3BLY3R5SmdKY1AveFVpQU1I?=
 =?utf-8?B?djJvQStOclZvQlRpUEtWZmdEMW9wdlBCNmxEb2NvSXJsK0pQTlB1Y2ZRNnpC?=
 =?utf-8?B?c2lYMytQcDBQR3pwcHFjK1NmTS96MUthYlhVbytJOUhQaVRmVjlQcE81SndL?=
 =?utf-8?B?STdXSEo3TEhhTHB4cUt2QWM1RGt5cGQxZWNEYW9mNERXbkt6SzVHQko2SFlT?=
 =?utf-8?B?MUZGOHBQM2NCSUMxY0ZTTGcxNE9keXNIdXFBYmVaREF3QnRKUVdNNDlIYjBu?=
 =?utf-8?B?OHFlemcwQVhlTEFMN09lVmxsRkJ4M1NSY3VnbUhWdDMwRjA2ZHRKT3V3SStX?=
 =?utf-8?B?aXlpSWFZL2tocVZSU3JybGNKSUR0TEFMcFFZdXJMTnoyOUZiaHU0SS82bHVt?=
 =?utf-8?B?ZUZJZk1ram1zMTRCanBsb21mTk9WL0JLSUd2anMyN2oweDQxRnhJV0owRnZt?=
 =?utf-8?B?Qy9rU0NHWWpzeWE1SXIrbTUzd0liOUhyMHlPdFRCaUpSTmcvZ0RqZ1dNMFVQ?=
 =?utf-8?B?UVBRcFlLSzRSM0FhL3dRZDl4K25KWFJJRHZsVkdpS0pGRkJ1MEwwN01tejJq?=
 =?utf-8?B?dEovZUxLd1Q3TzBQWE9EZ0pRSlphWFJzTk9SMHZwUHNPcDN5UmFJVlFTY1pJ?=
 =?utf-8?B?WkFRYVZzTlhSeXZSdTBCbDBmYm44QW5aOGI0ZWZZZlhKVHRuZ3dLWTNwTjJM?=
 =?utf-8?B?cldVdTkyV0tZMUQ4d2NtQitCRmZYd2RKQXY5QkRWQTJYeEZRM0F2V05IUEJ1?=
 =?utf-8?B?dzREZ2xVclhKQ2RhWGh2SXQ2bklia1UvM2lpaVlVMW1JMVdHVGR5VmljbzBt?=
 =?utf-8?B?UzJmcllJYlEvRGxDM0c4MFNtS3o1R3h4M29reTJHSzI2blVTeEpDQjlXRWYz?=
 =?utf-8?B?WllMZWFnd3h1V002WTR3SmFZSlhPY2NDL0FvTVdCUWJKVVp1aVhoV3ZjVGRj?=
 =?utf-8?B?ZUJVUk00VUdrb2xTZG9aL2JmbVExSzR3TUJPb3hDYk1NS2pUQjVscnZSWU5t?=
 =?utf-8?B?NnlFd2NTNmRLSGFaNnJtZnVZV0lkckVKWGV4MWNJZjY1MHBuMmtzYXkzZEhB?=
 =?utf-8?B?QTdUUWozQnA3UFM1aDFvZms0MU5yRDZobFZWYmcvaUh1cUVSaS9yNlo4ZHNw?=
 =?utf-8?B?UW1TaHF1WkpTcFY0N1NPVVl2YW5sVkdoMlFGUXZWeFdINEdybmdCRWhLcTFj?=
 =?utf-8?B?dm02ZU9IbXNpdmVieXhlSER6MTl2dmVIRHR4bTQ1R0ZrbDZYQVdNVmQyV1ZM?=
 =?utf-8?B?c1BOTjBiWU9MNkV3akhHL2UrNndnbDlFUDM4c0lwekxWQlhzcnVuK1RYMTFt?=
 =?utf-8?B?S1V2bGkzWWxVeU9Ia1pjZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGw5TDJFcmJMd1A1Z3NvaXhRTUlBeXVnRXJYcGwrYUt3NTA5QXA0TVZJZ0hY?=
 =?utf-8?B?RWJ3QkRjbU9DV3NQNXlzOHg2WHl5cytLWnFyRk8zQmRCT0F1N1ZabjBUL3No?=
 =?utf-8?B?Z1R1TWZ5WlhRYVIyRlNzZ3Y1RkozR0R6RUhmay9XRzdZa0RiVkY5RWVLckZq?=
 =?utf-8?B?T3U2bUNnaVlUdEcwSkF5bHZBc1VPUXNsVEc2VUpkYjh4U2tnZ04rVndNMkd0?=
 =?utf-8?B?VnFPNythc2IwRStjY004Ykd3YmwwTEUzSlJBaTROcHloUmQ0RERqL1RodG84?=
 =?utf-8?B?aXRBbWQ3MjRUdEs5c2RCOE95M29aSmZOWnhna1k4NUZUczBtWjhSNkpQeU9O?=
 =?utf-8?B?dEt6V2lYV0IxUDRTM3JEalBNdEk2SWM0Z21mQmdIR2R0Z2NkWitWUXJMdDZi?=
 =?utf-8?B?b2lHR29YMmxtQjg1WVVFWEdJVEFPYnZndkJXNFBJUUZhZ0N1QUtwMlhKeTR0?=
 =?utf-8?B?aU1JVXQwNzd5SXVBL3pyV1l0RHVUMTJkWmNZdHdKOFZWMVQxblQxcnRQTzdm?=
 =?utf-8?B?bEpiZ1pZWUZMTnNpODRNMDVoenA2RHlvckc5Zm9GZzNBaWJjRFpRL1MrRUZy?=
 =?utf-8?B?OHVpR3pBbXpTMitLM1k1YWpScnVhWFNMZ1I2TTJYQ3VrakhtTjIrVVltcWJy?=
 =?utf-8?B?cUFXNUVWK0cvdjl1ZmdOYWZiRyswZFNLeFZxbnlPUERBMzNaVkxFeUNTNnF6?=
 =?utf-8?B?b3lPbTN5MVUwelljVUF0aU9aa24xTEorUVpBSzV0TkhPM2x0dDZlc05xbC8r?=
 =?utf-8?B?RUNxa2hYaVJKdkYzcGtpcEFwODNoQklBT2JHN2p0bUNGbnNnMFRnekV3RzVq?=
 =?utf-8?B?QmJWQnRNMVZ6ZGFrK2phTkp0alE4anBzYjBBblZrNE9SV3FmUlBtNjd4ZXcw?=
 =?utf-8?B?U3ZJZUdkdk50TEliamt1ZkQ1UFFVZ0ZON21Md3VBZzluUHdrZnhJRW9rMkhH?=
 =?utf-8?B?ZDNTcTNhbWloZEIxSHJGb1RvMmJ4Q040bEQ4UENyU3ZDZ1ZsSTk3VnJnV1Q0?=
 =?utf-8?B?V045eDBQZ2dnNjZ2VlVQc2dDaTBjZ2IwNUtqSUZ5V1AxelVxZ1kyY2tzWkNP?=
 =?utf-8?B?SC9hS2pIWFk2OGxkY05kbmFGaGRWNU9SMzRwaTZpelJPTTMxK3Y1NUhPSDZj?=
 =?utf-8?B?WUJOSHFZNW1GdFJQNjdBMWVsZWE0QkhaV0Z1VENOdjhxNGphcmhGUUd0ZUdo?=
 =?utf-8?B?ZlJDd0R0Q0FCR2xHaTlJazR2Y2tlRXhzRlY5d0p4N1ZFYWxvaWRYR2UwbjRi?=
 =?utf-8?B?WEsrMi91QVM5S09LNHQ3cXMxSnc3K25DUGdyY2E1NjJoakt2SkdoNEZvZHl3?=
 =?utf-8?B?ZlBicnkyU1RMRC8vZEZyeEd3bUJnK3F3VCsxRDJOc1J3V2txQUNkci9Pa1F3?=
 =?utf-8?B?dkx4WDZUR09uSjhRNDJjeWhURk4yeHZZbGxQekd1Z0h4Qkw5MVdpSXZ3RTdC?=
 =?utf-8?B?M0plMUViY2tSWnd2bFYxNE5UV2tUenh4bUptckpLdlZIWGM3TlFWcm03clR5?=
 =?utf-8?B?aDRRTUpmZmQxSHArU3Z5QUk1d2ZtSVltVDNkNU52YzJDM3BnNG5MS3RnU2xp?=
 =?utf-8?B?NGRQQXY2OGhZRUxiUG0wM2NOUHJTZEhYeDF0SkU4R1ZtOUxxSTRmWmRZUXlM?=
 =?utf-8?B?QU9nOTNTbVhPV3dKWTNXRjlDRU52cmtFOWVkS2tZcit0OFF2eGFHMmVjRGpw?=
 =?utf-8?B?S3VQYzNoWEVwVmdMVHgzbGdpZjBKOU9ZQXQ3WDY4UzVJUjBtekZRRS82OUVv?=
 =?utf-8?B?VTBCOUIvWFlldzJ1dThFdkRHRHMzS2RXaERKM3kyTmp1VnhlVnQ4cGdNV3pU?=
 =?utf-8?B?V2gwZmQ4OTJZVUJCQWJ3MmR4MWwrQngxZ3o4KzVaTVdGQTQrUUIrUDRTVVdr?=
 =?utf-8?B?V1ZWcEsvb3hlS05JVXZvcytUVE1MRWs3LzBhVWZwTVp3SnJiQkdDT21TUndv?=
 =?utf-8?B?WEZWbFFDL0pyQ3VtUmg0WEFXR0FwUWlidU14WTByWDB3S2wvejgrNmJNdytI?=
 =?utf-8?B?MGUxS25QVUFUb2hQU3R6TnVqOEhITTVjaHFrbXNuSWNoRXJvaGFYZ1F2Zkd0?=
 =?utf-8?B?ZmlBaUp6U3d1L3hJaGFhV29wYTRBenU4OFpVbS9QV1VIemtXbFNzQThkNzQr?=
 =?utf-8?Q?jBYA/AdGxqrAQQPfMm10QzAAq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49b9162-fae0-46f7-7ee3-08dcd2277d57
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 06:03:43.1451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MFIRYbywUUuVYcPF8WuFNkHavWqtfU3RFjkqCGHfwNSVkXGPcAEQjqp33whXUaL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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



On 9/10/2024 8:19 PM, Alex Deucher wrote:
> Drop wrapper used in one place.  gfx_v9_4_3_xcc_cp_enable()
> is used in one place.  gfx_v9_4_3_xcc_cp_compute_enable()
> is used everywhere else.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 408e5600bb61..b940d2ad57db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2299,12 +2299,6 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> -static void gfx_v9_4_3_xcc_cp_enable(struct amdgpu_device *adev, bool enable,
> -				     int xcc_id)
> -{
> -	gfx_v9_4_3_xcc_cp_compute_enable(adev, enable, xcc_id);
> -}
> -
>  static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
>  {
>  	if (amdgpu_gfx_disable_kcq(adev, xcc_id))
> @@ -2336,7 +2330,7 @@ static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
>  	}
>  
>  	gfx_v9_4_3_xcc_kcq_fini_register(adev, xcc_id);
> -	gfx_v9_4_3_xcc_cp_enable(adev, false, xcc_id);
> +	gfx_v9_4_3_xcc_cp_compute_enable(adev, false, xcc_id);
>  }
>  
>  static int gfx_v9_4_3_hw_init(void *handle)
