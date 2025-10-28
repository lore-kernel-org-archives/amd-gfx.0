Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D85FCCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 12:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE38110E3E8;
	Tue, 28 Oct 2025 12:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GvApsIoP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A4710E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 12:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiWbBgwclzRMtq8q8oQ5sC5LzsNEGtE8egd11TlWjShFt6kMQN3gp8ksEOpZyiWYQHIcniy2RBGXydM+fmSb+xzNbHZ+rFNh9xPpBp4hu+Lrg4kjlbH++bf9pcbVfqpVCeAyQkhm5TW0D5FOTR2WOWy4LLPndORRsOqcXz/jR6xgfnfOqIJ8GQwAL0xfSB4jFCbdyIm9p5qn7xj28rs8svMnXqJfVZ0UjRnVDt7rpT14ePEICQPxkGgLzpHcxP7gYXoWE/t/rWAt+1vU5X/hH+KGEubCxmnriR+RkXW47JmA7t6fZYfJ129TdZ1D6py3uAYKJpJbh9HAyH3e8vcC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQE1JfYsKVVEU14T6eEU6aHVQbuurEOkjmT/KXOsuns=;
 b=ViGDUW8VbT96ZGDCnvSzd3wBH5TihDwMl/gtDWGKXHftRSPkXP5QTyUGXe+XUufMWyJQAH8VZQl7FIT1EJ1/atyL+B79UIrvXlJ8jBjKBxgOoGPbiB7yuUZlT70Em0r53bSdTLMuHVEvRzzzFvZoJOknTcZbrlFzIKE6zrIwpZlyEs1MB4kmmWW4fghrLML3nPWd03wvT3lQu+20bZSMRVOmLnxSIQ46vQMdL4QIBpVWqvjXwOP57T9LsnvgeOWYXajjr75mJ12bU6dfv2BG5UdvMkEbf+7Ku1OyWCKZ6Jx5D+OCZsnlP28zbwZG3Ub/g8YYbTETENByYqLqOUbKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQE1JfYsKVVEU14T6eEU6aHVQbuurEOkjmT/KXOsuns=;
 b=GvApsIoP/phXMo9imMjD5CYURlPbj8Uhw11OI29HpK/ihi+4d38g9dN77n4tD03epCOwJGjTe7mE1Nk2ia9YY6iK59ppq8+Z7AIEabV9cf5VcLDgzG1EUaLBrCCsyaKqDwWx324xo2rHK6P0NEcIP/NJ8gUWzdyOrwiFV/2ajhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 12:53:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 12:53:32 +0000
Message-ID: <b78063a2-0356-4e21-8050-71085a559634@amd.com>
Date: Tue, 28 Oct 2025 13:53:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdkfd: clean up the code to free hmm_range
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251028121330.3023032-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028121330.3023032-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae81e30-a023-4616-3871-08de1620ffb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVZQZEdpNFhHSWEvcnlQOVRYUWdXUC82TWF3SG9nZFNxc3FpZ1ppYjk5c3RD?=
 =?utf-8?B?NW4wL3VWNDVuQjFkL0p1bzNrd0dnQzJ4TVl2aDVBV2xFVTZvM2J5aCtWQktO?=
 =?utf-8?B?SmliUmsrSWRwMGZmeXNpSVlUMjdXa002OTRuVUNLcFoza1kvL3prSmtYbTFp?=
 =?utf-8?B?emVvdjJUbnZhRkcwK2Rva1VEU0RyWm95Umh4RUppRUFCYm12TFA3N2k1eTRR?=
 =?utf-8?B?VlBGdU01LzZ4TEszeWd3ZFZVdnJwYUExcjgwQUMvSmJUYmozV0pnSFJPbVFi?=
 =?utf-8?B?WUcrT29iMklSYlU3ZzcxY0Y5YXNESkhoa0RYRnAydGdrWFhEVjFBNVBGSmps?=
 =?utf-8?B?ZXRKSEZLaE1PVnJ2WE1Qd3hjLzQ1Z3FWYTNoTXRmdUJJT0kzYWwvd1lwNkZj?=
 =?utf-8?B?QW9ud1BwS0xKT3pRVDV2UEFGQUQ4dm9PbFpuOEhxVFdnTDFKWEhWcnpKUk5Y?=
 =?utf-8?B?TGVLVmllVENWMHNTQWdqMWpjZThBOTVHT2dia0c1UFE0bGtrNzQrMkpRR2ZT?=
 =?utf-8?B?ekc4Z3JPR2dxdjhheGhLRUgvbUVOQW1USG5LeElhNkVkaGRBRm9zVUxTeEll?=
 =?utf-8?B?T3dRSjNRTnA3S3J0c3czYmZEbEhrWm9pL0pWdGpOcnJ2enhFV3JqTDduRjVw?=
 =?utf-8?B?ZnErM0hBVlpkQ0tPcS9uakxoQ3YydU1yOEN3Tm9oSEZnRnRBbzBXdS9WZUdT?=
 =?utf-8?B?akNMR1ViSnhoWlVmalBZeWxYZGh3MzdpY25wa3QyeDB6UTN3UkFaYVVScVRH?=
 =?utf-8?B?ZmRNTkFZM3cybFMvWExCSTNCakEwbFdEMldDZUNuaTBDZXozQlJuMHNFc3U1?=
 =?utf-8?B?QjlydVc4Y0JENm9BbFhGS21HL05YQ3pPZFc4bWo2c2FLblA4KzdxMWVLS1dD?=
 =?utf-8?B?bnN0RGpCcG96Y1d5b3BqbFFLYjRPWW5RcWFPTFQ5RmEwaUN1dkZTM240emg0?=
 =?utf-8?B?N0Uza0dSWXNQRXAvMlFVUnZvVXdPT1d2OEpQaFR0K2tzaXM2UjJYdWNzOHJG?=
 =?utf-8?B?aW5Za0cvRURHMmt3MlFjLzRWNk1QaG9wT0FtaEQ3Q1p3ZGQ1clFOblVkcWU5?=
 =?utf-8?B?bGRiYzJRWWhsdUZ4K0FjMXM5cHdGNEY4NjhmSVBMMUdubGo5OUpDNy90YnNU?=
 =?utf-8?B?TE5HQ3hZbnU1WVQ4MU9ZSzd1bGtPdDRBQTBzTG84WXJwSXQvdEVCaTRYeldK?=
 =?utf-8?B?aFgvbXdnanRUZk1uWjY2SnpBR2UwTzN2QlpXSnZVaWFUd01yUkxaTGhrQkNQ?=
 =?utf-8?B?cVoyOUx1UTNzSmRtVTlqUlMraHZoWmtCNXJ4YmxjaFI2cHFVZktLaHBRVmxN?=
 =?utf-8?B?b1NTaUJaQlhsU3F3b0hpT2tmSmhsOXd1VjRCMTlSRy9Pcmtpd1pQVzIzdzI4?=
 =?utf-8?B?ZDFYUStON0lXc1VnM1Fzc1hCREN2NURzOUtzRi9oUmZpdFhJTnJZMTZwQ0RY?=
 =?utf-8?B?cFNQaHNLL0M0YTNvUnBxVHhWL1NaU1h4TTdkMTdnZVd6Znoxa0crVlI1bTRS?=
 =?utf-8?B?bGJhMUJxaGsvRjI3bGdiN2tIcFBvRjhSMG1VK3FMbWtOSVZpQVlBL254YWQ3?=
 =?utf-8?B?Ny9wVFFVYXJseXg0cXZVOG9wWlJrSUZTWUZMYmlGMCt5YnBnZ2hBWUhJcEpn?=
 =?utf-8?B?b1QrYmNGcmJ5UE5nSERteVcxQ0paL1ZueTFFUjZxOFR6WUtEdzhyZGlJTFg4?=
 =?utf-8?B?V2tuMmVPQlIvUGkvbDBsekdrUEJqbjNIUE9SUFVzL0dOdi9GWXYvaGw0TmRF?=
 =?utf-8?B?WDRmTEh5T21VcEF4Uk1LNnR6RTZyb2JQcEdIRFZlVWszbTM0d1lZL1dvNFZZ?=
 =?utf-8?B?WGtSWk9MWW1ndnl5UytxYmZjTFRzajY2eEFNVnZLdVdwQTc4V25kRkdXRU1P?=
 =?utf-8?B?MVJaNHN5N2lnN3ZtQW1wWlR5QXVBakdMSzMrV050QUhhWXdKWVE1cGR0WmlJ?=
 =?utf-8?Q?wSduukLV85lWPePgYG7iBfwZGv4nQu/T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTg4UzdHV05NWENxSDFDWG5TTzFmeE9Vc3ozdzUzTWcwNHpXT08yNlpTRExX?=
 =?utf-8?B?TEVOdTJ4TmVpMEFzcUR5R0xBb1gydURaeDR0SHRiUkNQVVExaExMeHl6T2hC?=
 =?utf-8?B?VmI5YzFIR1NoaUpVeER5U2V4a1ZrUXFQZ2Z0bkNpcDU5L0JHd1d5MjVxS1lk?=
 =?utf-8?B?ejUyTjlLemtFZFRoc1hMcHhKdjUwRy80MjZqYys0M2dTSUNGZGlnNythYXlj?=
 =?utf-8?B?RTBudlB2bGVhRW4vb2xNSlJ5VENLcXJkVnJ0NjhwN0hZUGIxZGpJRmw2T1ox?=
 =?utf-8?B?RitFSDJNQmFnbFBLTlNmbjFaTTdiSGpFNFJ4SjJjVEZoaURaNUFJVHQ4VGVa?=
 =?utf-8?B?MzV1c0ZLWDJxMXdzT3g0enlNYUtpMTRTWjA1VFk1ZHEzeFJZcDRpSjU0SjZs?=
 =?utf-8?B?U2Z2ZDhheWs4Zi9vd1V3elk4NTh6RHlPQTdjT0h1SkFnLzhYalM2NGlRR3Yv?=
 =?utf-8?B?UjltVERFQ01tN0R1UUYrWXpzeTZsSHV6Qk1EenVPUC91TDVhcWVxVy9wekJp?=
 =?utf-8?B?ZlZlUGw4R0d1Q1EzTG5ib2JQc2tMVTJneFJ6WHNsU1YyL3I2ck5nWW9rZ3NC?=
 =?utf-8?B?UkVNVzBxNWdCSzErdkdha2ZFMUZHYlBNbjNaeWxFQ3NpNCtYdTgycHo5K2E4?=
 =?utf-8?B?R1VYTGRCdWNJRGhRNEZoYjl2MnZEUWhVRTdINzJTU2lBMHJyZ3lDMXgxaHdF?=
 =?utf-8?B?Wkx3OWJvaU9xazI2VEwyRnJpUVFMLzQvS3ppZDdSTmkyV3UzVy9YMVhiUVdH?=
 =?utf-8?B?SWZTY3JqejloWEg2VGJBSDg3MHhqWWVva3QrMUpQcE1kN2puZjR0aXA5MmpL?=
 =?utf-8?B?U3hiNERMeS9mMWdIMFpkQ0pHSzhIQnlNb3ltTzhjRTQ0RUhoMm84M3ppWEFR?=
 =?utf-8?B?MHJ0UXowY3krdE05aUVzd2tiVDFuWlJvbit3M0hNNEp4Ky9EMDIwOTcrNTBH?=
 =?utf-8?B?citSZExXSUVkSnc0ci9LK0M5YzRScnlZWUViNFRKVWp6UlhKVEpIVkh2elpj?=
 =?utf-8?B?M0dTYURyN3Z0Uy9HbUFrQ213T0lKZ2w5ZDN6Z1UyaFhxdW1YZWNoM1o4UEcr?=
 =?utf-8?B?R0ZZVXNkWGJxRmNNV0ZqTDlHQmNEc2FmNzlpak9iTU5NOU40QVA3bU1ka1pS?=
 =?utf-8?B?dU9oOVgxWXVYOGRKbTVtUU43dHlQWWFqaVhGMFRyK2ZOMk9NeEpzQ29jcTZD?=
 =?utf-8?B?SFFaSzdneHFRQUphd1NJYUZWVEtIdXB5Y0hhSnZmeDN5RzRYQjA4c3V4bWl1?=
 =?utf-8?B?cm9ncVZ4OC9YeENwNnNieTdMTU1NTUNkUmQ1N1ZURzVLQyt3dmxWWmVBZWpt?=
 =?utf-8?B?T2pPSkpNbC9xTVNjMWtRMEJxOWs1RnNScklGOVZ4L2FPWWZYSkVybjlMMjlP?=
 =?utf-8?B?SzF3UTVwbjhwWUU3cldGNStBL3p5V25GOHVHMTg2bXFRTmlaS2M1bDJTN3h6?=
 =?utf-8?B?a0hIdTRwYkNaMWU3SmE5YWYrd0dqbmR2OUNUTC81UWc0L0VEazQ3eEY4WHk0?=
 =?utf-8?B?QnlhUkVCcEo2aEFRVzdhcFNKTE53ZzdYc001Z254UlJtRTdBMVBlVE1pREdG?=
 =?utf-8?B?V3orbzVnS2Q2WDV3NnZMMXI3Y2ZyRVNHMmhvc0ZPL1pMNW02a3NZUU43M3Y3?=
 =?utf-8?B?UitCSmlFUG5JK0lpbDVFMDBFczN4WVBCZmpPV0U1SDh4emcwUE5pdVlNa2Zm?=
 =?utf-8?B?bURpV1FRT1RXU0RRcTJsaHZ0ZERJdnRRRlJCODFoZ241STdHM0l1a0VjWWsx?=
 =?utf-8?B?QXpOTFhscFBoQ2R3MFppcmpJazBsNTgwUHdzNzNXbXVqV0FHK2svOFh1Z1Y1?=
 =?utf-8?B?VmJYVW1MQUpDK1JlOEZ4RTRGMi9kOFFKTklTc0hSMjJpVXNQUXdXeWpqRXlR?=
 =?utf-8?B?NHp0QTdGUFpBaXNTcWJTR1Y1ZWgySktYdEN4MjBoOVZPazVmbDBpUlE0R04w?=
 =?utf-8?B?UndsUlNWUEJqc2g2MGJQQU5PMWVQR1lkSG05MU1XL245OHkrM2V4Q203VHMr?=
 =?utf-8?B?TE5HNVE2UUdBRUp4OVFrOTVJVDRUTnZwT21nenZ3SmFFclZ6UlFxWURQSVJw?=
 =?utf-8?B?VTZuTTNwSForaFVKSjE4aU93Ymtpa1lYOUd5NWo1ZCsrdEhLUFc3R3hwYzVh?=
 =?utf-8?Q?1qSA1SRForJSvQ9/a+NMn4H2v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae81e30-a023-4616-3871-08de1620ffb0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 12:53:32.0011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRo6E/UCaf8wtvbPoAI+wsxh9HT4t8PFq+YDBHqOe32HjE82W4f40VtNJKSYd2CR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
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

On 10/28/25 13:13, Sunil Khatri wrote:
> a. hmm_range is either NULL or a valid pointer so we
> do not need to set range to NULL ever.
> 
> b. keep the hmm_range_free in the end irrespective of
> the other conditions to avoid some additional checks
> and also avoid double free issue.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ffb7b36e577c..fb3daa7cd326 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1744,11 +1744,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  			else
>  				r = -ENOMEM;
>  			WRITE_ONCE(p->svms.faulting_task, NULL);
> -			if (r) {
> -				amdgpu_hmm_range_free(range);
> -				range = NULL;
> +			if (r)
>  				pr_debug("failed %d to get svm range pages\n", r);
> -			}
>  		} else {
>  			r = -EFAULT;
>  		}
> @@ -1767,14 +1764,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  		 * Override return value to TRY AGAIN only if prior returns
>  		 * were successful
>  		 */
> -		if (range && !amdgpu_hmm_range_valid(range) && !r) {
> +		if (range && !amdgpu_hmm_range_valid(range) && !r ) {

Extra unnecessary space here before the ).

With that fixed Acked-by: Christian König <christian.koenig@amd.com> for this patch here and rb for #2 in the series.

Regards,
Christian.

>  			pr_debug("hmm update the range, need validate again\n");
>  			r = -EAGAIN;
>  		}
> -		/* Free the hmm range */
> -		if (range)
> -			amdgpu_hmm_range_free(range);
>  
> +		/* Free the hmm range */
> +		amdgpu_hmm_range_free(range);
>  
>  		if (!r && !list_empty(&prange->child_list)) {
>  			pr_debug("range split by unmap in parallel, validate again\n");

