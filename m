Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A39CAC5B0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 21:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE6110E064;
	Thu,  2 Oct 2025 21:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yAzJ2ZJS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B0710E064
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 21:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr91mIz4gdUIKqjQGcKue+Iv2qPFhaZU5ElSwhtZFQIt18u+XPtaJubVSCtd6Aqbmpof7IAZdEA4weiGome5s77pjp0ZbnymPC/HlLAUaZL5CRZAqKqX6ZzKTcngxu4BSV+L876tm7OzwpgPp3n4oSObTxhkt16j6dwjISgcm0XNrG/73Sos7Hjb9jqZHGHvrodnjnomF+QImNIAMSDabxo48BMR8LqfdrSJkdrl/YSWTdbi0HAGEdkgnaTCfPZb/Jnvomsnr57XFusvnZIQN1bv+9E/GPmYQttuZV/OGJ5R62Smej2W2BqHPhU6hB2tHFbBU/ybjtDYqcVnIA+QPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB0rf3DQ/StzcUR+5YIWQkv1MyBJHImqHHThDtNiYVM=;
 b=XRhQApat1ST1pt/gwuI1TbE1PcNqHRVPN88OqqJ5fRZ3IaEivGTIuoX8b0ARZxCT7cvUVnHQRdi6FMooM+R1t5KevWTy3eUf5PiWDkPHRJrRK7TFrbTI9i8TXQLG+CY4r3asZigrC2EhyZy/Izv8bTTLmUg3HYbDaWIfa7FjUR4fT3apf8gQa+2WtsiApsau9YrJbb7qelLXypGiLDMBI2fxvUy2RQ5QAoDpP8GDEb8bFxNOW6nlwsVG9M3Ulq2fiCKuwDtEQjvtq6eBJ77vRNcR5yQjZ5LKxDrk2Vzudo6mp8EF77+T9cWBwPEjJtYaCGEeiMI96m2vAbnw/IgSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB0rf3DQ/StzcUR+5YIWQkv1MyBJHImqHHThDtNiYVM=;
 b=yAzJ2ZJSlA18lf+m18JuQ9ScAA9MaFNDJtlxMqNGga2/GOctGmg07aReqqpMdMLEKd3/NxjdHprO9kJ40PmOM2Gjn6CYMXPMxUr29L8GOn+uT01SDzpICEQqcDGOvWmDxLTcu8l4m3TED5U6v5YdIa2DV6guPfPI8Fk1iZyuy2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.16; Thu, 2 Oct 2025 21:48:54 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 21:48:54 +0000
Message-ID: <8942a78e-4946-4a86-a8d1-1324ec7c7f4d@amd.com>
Date: Thu, 2 Oct 2025 16:48:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: svm check hmm range kzalloc return NULL
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20251002174307.10583-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251002174307.10583-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:6e::13) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb223be-b55d-4fc3-96a8-08de01fd7b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2poWTJhcHZrSEk2QnJFR0JCSkdWd0Z1NVk4R0FNMlE0aWlqc0FoL1o0SzFG?=
 =?utf-8?B?UWZRRnlkdzdSaGZ6NkJHdmVZOHJDWnBXaThZaE5EdHJaT2dGdllkUGVLdjVP?=
 =?utf-8?B?eFp4RDNjeFViZ2FrUDVBaGZKZjZwTXNoTXZxZG1xczhyRjNsSElDQlN3OEV3?=
 =?utf-8?B?ZkdlZkltTEhjNVFvNWFKSVJWcklOOG1oREc2QlhJMUJSeHZLVHdseHc3TTJV?=
 =?utf-8?B?eTVrNGF2cG1oemJWS0F6TXZBTUY0MUdUNy90SXdyOG0zN3hSRWF5RHZUWTh0?=
 =?utf-8?B?WHA4OGoxVE1qMEFMNFg2eFU4a1V5WCtuQTZwWTYxRk5STlMyREg3UFE0U1Vs?=
 =?utf-8?B?NjlMVUZDUGpCcjN5THJtaXdmMFNBcVhRdXR1SFB1SDcwYmRLc3Y4K1ljWWZX?=
 =?utf-8?B?MkJudmRnZnpKRlFHdEQrak5wSU5BOUxnSWlmeTFHVkV6NG50M3pDTXZPNW01?=
 =?utf-8?B?ODFtNDI5RFV0dElzd1ZvcFhBaktSd204QklOa0M1RDY4Skp0bVU1Q1Q1NTM2?=
 =?utf-8?B?MDFBeHV5TGdWYUMyQjAwblloRWxjQzU1emd2MW1mbi90YkxoTkJ6UkN6ZUZC?=
 =?utf-8?B?aktXY1VIK0Q3enlHdGV0bHZaVWtTNjdHZzNNQTlrOVRMa2pabWs0VEVyYlpl?=
 =?utf-8?B?NldQZTZySFNyQnlPTktqYXRMR3ZZcEtWd2VCZ0hHdkF1aXZmWnA0MExYcmt6?=
 =?utf-8?B?Y0NIMTJld2ZmZXM1aXlzK3lZY3lKVEg4ZWptSzhPMGJqS3hwUzMyTUpnN0Js?=
 =?utf-8?B?YVdsVmtLdlBuNUkzVWRQUFdQVlZkcTV1ejlUQUxJZkwyQitBYXptSjFFMGRB?=
 =?utf-8?B?TFpURjRlN1l1UmZlMUtQeVdOWWkrTC9UTG9Dd05lWXE3Y1RMN0pLMXdBL1Zv?=
 =?utf-8?B?TDRuTVZQcFduRzl3UlJZSllDajgyTG5YU3lNaEFEbWl6QWEzY1N1ZWdqZndP?=
 =?utf-8?B?L1Axa1k4NHlLSnE1dS8rYmNDa0F5UGtjcnVMckFLaHQ4VnRtR0FGWFlHTVlq?=
 =?utf-8?B?ai94bzNuelBZbGFuQjBXdEtnUU0vejc2WCsxMG9QdjN3dkRSN0RxZWRQZU1x?=
 =?utf-8?B?THRXdFZubjR6TitqV0cxdUU3MzhHUEh1c2xTT3d3emR4NFBHM2FlZnhSL2Jp?=
 =?utf-8?B?WTlkYmFEaW0wbGN3Q0hrNStGZi9lWUUxTHFidG9DcjMrTEhBcEF1QnFwYTYx?=
 =?utf-8?B?b3dtbndJSVZvaVBlUHpLbjF5Y1kwVGM4SDNvR3JGa285UjR6VllYVDc0Z0dp?=
 =?utf-8?B?bmhMbEZvdlVDSFA2cjNBblJsUG01NGFFTDNTZklWZWQ2K1VDMk1hcGdWTDc2?=
 =?utf-8?B?YU90M2poaHg4S1Y1bnZCU0dlSDZSZWFSMUEzTXZKRW1sc2htdzRSODBQMkxj?=
 =?utf-8?B?aUwrd0NJcUlSVlRtOTdNSnh6WEFjTU1xQ0Z5d1hrMWdQdHoyWnJIV0pWNnBo?=
 =?utf-8?B?cVQ1MXc4WHd4RlBSemdJcXJDUkhBUnM0a3FxZ1RuVjRMRVB3NnEzMFBBcDlv?=
 =?utf-8?B?REYvNlBjQ1BCWTJEbjNMazZmczdXMGtSalFsSWh5eVlRZTFra1pVclROVitM?=
 =?utf-8?B?VmFTcDRrZkhlM0pJa25xSSsyb3gwVVFHYlN1YWJyV1RPYk1GQjZmQy9BZ3hE?=
 =?utf-8?B?TmQzOEplVDI2TXVXNGhWdmdySWJRR21TeDhwTnZ4b1pENXVYVzZqZ0FvOWdS?=
 =?utf-8?B?eFdnVHpDb2JRUWp6dlpVZHNQcGN2VHNQcHVKQk0xbWlJejh1Z2orL3RBc2xX?=
 =?utf-8?B?Y01lYTl1VEpoMjVQNGFMU296S1dXNjg5TEJQRHFQQVJ6aENvSkZEeXNSS2oz?=
 =?utf-8?B?ZldCQ3dpREUveXNTdEZDUVRDRjA5RENtd3ZrK3JDcEVBVmdhWTNpQkZNK1Nr?=
 =?utf-8?B?UHFNNVpYcEo4M1ZTQnIrbzdqY2tyV0dNNjlHQ1E1QnhGMkxhK0Ezd0hrME5t?=
 =?utf-8?Q?uzWjxkxOFzFuLP+PAXQoIxGcJnbN1fJM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzhTQ2RQTGxZNWpUL1krMGRZc3RuREpWc3R6eWx2b2MrREM4UWxOaFZZS0tx?=
 =?utf-8?B?TDQ3V3ZFTFZ2NzlmODhMYnVBamdnMXpaM1prajYwdkdCaVZHUThNMnBzcS9r?=
 =?utf-8?B?emlhRFNUL3BPc1VLdGd1Tnh6OHFiRGpQbEEwT1UrQldPUXU4Z1Zvb09Ga1c3?=
 =?utf-8?B?MEdZeURBamtuYTZ4R0tLTkF6UHJiNlZiblpMVHpBd05zV2ZqSHJ0MXMvc0ov?=
 =?utf-8?B?V0NnNnJUYmwvN2Z3L1NRSkJMTjI2ZklZQTI5RjEyZ1orU1FxRUVQK0pGbVBz?=
 =?utf-8?B?bzcxTHhmTFhOR1pFeGdwVEtOUzdVTVlEaCs5aG1VdWdvUk9Xa3ZRUlJXVXd4?=
 =?utf-8?B?UHVBcTBvRXVNRGp5bzg4YmxaZzBDc3VaS0p5WFZkeG16RkI3RDFSTXRYaU5D?=
 =?utf-8?B?RDVhaVIxUm1laWllV2MwQUdxbWhlT0JRckpDVTBXNjgzTm8vemwrbnBkZlVa?=
 =?utf-8?B?aFdONUxLTi9mNGdONG5PWTNhT3RYTUNkeXk4MitGemRrZnFmd2xYd0IvemxT?=
 =?utf-8?B?dGNPK05zckI2bWJuQTdnbEw3eDRtRklXK3VzSUticUlla1kvMEFwQkdDMEVU?=
 =?utf-8?B?NTBFSWtxV2I5VnZvNm05akJEcU9tUVpPZjVxalBDUEk2Znd1SU4rcEozZHJP?=
 =?utf-8?B?dUt1SFBrRWtoWFBYcEJVekpHUTlDRDc1aFJHaWZMODZYV1hpL3I1TTE0L0pZ?=
 =?utf-8?B?RTRTcjNra1NBSkJYdHNHUnR6emRHK2JYdFJWM2N4L3RuTnpMRWtQcnhIZjBB?=
 =?utf-8?B?TUhnbjcvQStmVDBmaGVnOEdhNFFkK2orZHN2SjJWZHVRdGljVFdYTUVqdWpV?=
 =?utf-8?B?Yy80cjJ6UFdxNUl1UVJ4TE5EeU93Zy82OEZXNWFJS0VOdGxXTklDdGJsU2lS?=
 =?utf-8?B?QmRjQ3EyODFaWlUzRDFQM0s5QWZzdGJkS0FVNkxQMno5NU9MenEwRjZNMDV1?=
 =?utf-8?B?NmRoQ2YyVDBuZ1ZXNXdWdFIzNG1QeXlXaUwyWWdDT1grZ1liZXhidEt4VVlC?=
 =?utf-8?B?VmhJYWVNeTRkWVRDQmNkcFYzZWd0SXJRVzQzNDd1amhubzl3aTRBYjRGZnEy?=
 =?utf-8?B?aXl4OGlsaGVUQkg4ei9xYnpnSi93SXB6V0JWQjBReEtFZGRJZG03WlcwVjRl?=
 =?utf-8?B?bkxZWktxdDVoaW9ON21CbnpIOERXV2c3U3hablhNSlkwSDJkckhDaHNVRkZ4?=
 =?utf-8?B?U1VmQ295RXl3MFFKNHQySnQ1SjdJbXRxWGZiTDVHZCtPZG9Uc1huWlk0RHpY?=
 =?utf-8?B?aEkrUzdXQ3QrNEpIRWdpa2ZEd25sdTVKSE5QUUZkbkdxZjhXQlVzeUdod3Yv?=
 =?utf-8?B?dkppZUJERGkvRnBWNXl5MmF2SnE1ZGY1azQrK0kvR0tpaHdNQ0NhWkhBdnF6?=
 =?utf-8?B?SS9rcVB2ZldPWHhNTUNzbm5EZURIN284bWRDNXBGbmE3ZEJvUVIrRFFrV09V?=
 =?utf-8?B?b1VqSGxnTERwU2VaSk5pODFwWE1zOUpGdmJzZzFTNmJLRXczb2ZMY1AvUW5M?=
 =?utf-8?B?Vi9tbmUxcHRWd3o0NEhES1ZKNFJnYlJPZmlZcWVsT0o1TEQvZDE2OEkwaGhP?=
 =?utf-8?B?ejBoQlcxVTJzMkpyUFByZ2NibWZGbnlLVUZWSFJabGtsaDZST05TSWwwL2pr?=
 =?utf-8?B?S1dMb1hESFN0NjBXUXZIb3pKLzlqOStuekRsTVU4Ny93ei94VENFblA2eUgv?=
 =?utf-8?B?ZTREMGY1M0NHdTJWMi94a1pZK0wraEVzdXpjczFyTUVjSWpMa1hsMW52MGdo?=
 =?utf-8?B?dnVRY1A5dWMzOFF4bTZrQ0dsQ0dRWjNBd2pMc01kWTQxRUw2Y1hrdVF6Zy84?=
 =?utf-8?B?eGE1dStYREZhUDNRelFNWXdROWtVSkt1aVBqZGhGb3o3SkJIVkFJbExRNG90?=
 =?utf-8?B?bU4wem8zRzBOM2hFL3dTYTl4Rk9YdFAvWENEdEw5S0pQQkc3THJCem9FY3pK?=
 =?utf-8?B?dE0xaHRHTXoxTlZTZFJBNmFCc2Roa0ZwNXdvWlRMQVZ6bjFIWjJaQ0dzS2x5?=
 =?utf-8?B?YjlRNGdlcmN6Z1I0cTByNXo5eWtjM0lNQnhnSTcrNjcyVE1OTkVFVFlwTmpl?=
 =?utf-8?B?NHVxa2JEMC9CSENudkMzaWlCMW9rckprdzlKVWNsd1Jrc1JnL3M4V01hSkdZ?=
 =?utf-8?Q?a4sI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb223be-b55d-4fc3-96a8-08de01fd7b21
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 21:48:53.9558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBpSyKoJZM1gqsv4yXX7KEwwUX6+q+ATortBZPR9pC7Q5Bgmz2PgyL7muWKbOfgK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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


On 10/2/2025 12:43 PM, Philip Yang wrote:
> Add hmm_range kzalloc return NULL error check. In case the get_pages
> return failed, free and set hmm_range to NULL, to avoid double free in
> get_pages_done.
>
> Fixes: 29e6f5716115 ("drm/amdgpu: use user provided hmm_range buffer in amdgpu_ttm_tt_get_user_pages")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 8c3787b00f36..e8a15751c125 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1736,15 +1736,20 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   				continue;
>   			}
>   
> -			WRITE_ONCE(p->svms.faulting_task, current);
>   			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> -			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> -						       readonly, owner,
> -						       hmm_range);
> -			WRITE_ONCE(p->svms.faulting_task, NULL);
> -			if (r) {
> -				kfree(hmm_range);
> -				pr_debug("failed %d to get svm range pages\n", r);
> +			if (unlikely(!hmm_range)) {
> +				r = -ENOMEM;
> +			} else {
> +				WRITE_ONCE(p->svms.faulting_task, current);
> +				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> +							       readonly, owner,
> +							       hmm_range);
> +				WRITE_ONCE(p->svms.faulting_task, NULL);
> +				if (r) {
> +					kfree(hmm_range);
> +					hmm_range = NULL;

How it avoid double free hmm_range? Currently hmm_range got freed at 
amdgpu_hmm_range_get_pages_done. You free it here, then 
amdgpu_hmm_range_get_pages_done would not free it. if do not free here  
amdgpu_hmm_range_get_pages_done would do.

And besides free hmm_range, we also need to free hmm_range->hmm_pfns 
that is done at amdgpu_hmm_range_get_pages_done.

I think the real problem is hmn_range is allocated and free at different 
places. I do not know why.

Regards

Xiaogang


> +					pr_debug("failed %d to get svm range pages\n", r);
> +				}
>   			}
>   		} else {
>   			r = -EFAULT;
