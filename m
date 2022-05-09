Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D401C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 04:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48AD112095;
	Mon,  9 May 2022 04:48:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7774112095
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 04:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl0nRRdjAEeDvFbUTdWHMIMZWGoz4UfI0J22C/TLwWs4SbVU0IFlbl3zkO7RzwZ7BbRjyZSzehWn9mtPWuBjoOrdA89xZLVDhIz80+xUhSmLCmPLGX0JBJtf/2lleFcdM7BzgxJqhPkMO+5P4ZU/UuP4aLQ4QRxikS51pbHWYN6CW5dQbhcTmspZI0Y77E5i3X8ZnXP621lu7lp2b5u5WkH2MWyP6PxiJYwG5k03DCGlQHTOXTedFk6pB6Ve2p6n3MJn67SsNQfIMyCKjxsrxBLZeb4gnCm234sprVvscYMAq/3DiLEQaKOnVFydMy5p5pv5NsQE40R3keIIKN5O3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYC5sVgjB/l2in81ofqgTGcCfiyLODS90BfTnIparEY=;
 b=Aw6t5GlVduIGMqQgSNaB8Xo/8zdTo1r+ZMh/ouasiDpI82aPP2DQU1k2Sa5YfPpyZn6grO4IhfnHGxYNKB5esSlYXyoUtML912BM+gAXyj5h1omqsHGr9RLwbxMjtKjV6Zn5uaqc0PA9l9sdLOq6SoZc/lTf8P8s3yRo7uc45Zj58W60QluA2CLgpZgOwVJXK691+MK+CZKmNP/9q2grToC3tSxIZVDYV8R6qKJ267k1/J9nLwBnMMBfnPWmQJnxjrzA6vHJZdBJLwBuoKxSHCyhYO2q6TjpfdlKmwOO4JPFKnuN7eL4NnrN6bCK0KSLWlqfgXfWUaIdkN98KHP/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYC5sVgjB/l2in81ofqgTGcCfiyLODS90BfTnIparEY=;
 b=MoUFZ5yQNT2xR37vbijaQ20ROvLBohlsGMQhRKndE+H3oGA1PjZrfMhr/yvGqV2qj5LUQnzlfod9rkLD0UUk8rnx0oZycWg1kYf18KI/uhuM3KAtrsUdEHEt/HwPUc8DBZch1/mv+gYrx7awGV5zaoLHrKev3jVDOM4Ry4oixEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 04:48:09 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.021; Mon, 9 May 2022
 04:48:07 +0000
Message-ID: <c87204db-e32c-0ce4-52d4-c893196183af@amd.com>
Date: Mon, 9 May 2022 10:17:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 1/2] amdgpu/pm: Fix incorrect variable for size of
 clocks array
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220509035838.17410-1-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220509035838.17410-1-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 199408e0-26e6-46a0-97f0-08da31771c51
X-MS-TrafficTypeDiagnostic: MW3PR12MB4492:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4492D0ED855971437A8A0CF597C69@MW3PR12MB4492.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VySBLRx7PS39B9tGz43km2ARH4O7T6tClXep/RdxO751+Y98a+HaWzfhKm1ero0xd9FPyBPV/DiQztm+izBkErLsXjVY0SAp/lYYLjNUilLoQjroBn18T9DMtMfIntmZRLyMTfz6ZmRYWo8lbDYK+HVZaLpYTK1XwUk8xMJDAJ60mwrhxvDhziy2y2+cGb+8C+el7pc0s+WBtW3a5K0s+9FyGj6DA2VTaMjsBWNPsoxCOWKpUVrSU4wLTqPXbe2GVtVuCgiXPcUn+H4VASPLS9o2eWoCF/avOFQPb1w9kiDcSsltHf9sMOz2vhf0ehuoZrZkLXEj8DKyOuvFQHsrMEOmzYgYipdgImjA/1+M7FhuJFM+ftrNe95PoMWvVIqxBfjUC+Lg1ZRKgi1cijRfgxxGf2R4Bkqv13MCYYzx4UyJCb23aRsZmytODLu+rFRrfw6TfJnd4/FafIR7Vt24uURW9Jtx8w0tND9HZ6f0MvWt4AYkUmrVlgJ4/toji3aEyEBqKBXRHXCeQfL8aWjvgWY/YswajX0+9CKPN7YxpR7N8GpQitDDnDg7fX581vK+NVYo6a48DHjO/ymky2S25D9BM7ed3hI3hbweqwK2Fp/MDRM4r/8NNz6gEzPZ4UbX1mHj0B+65UqNQGw/NjAO5d/+g9LIS1rwsMgg2w2upcOZQIE1686xiVqgfH8TWHB+H3bNqvMh5znJO+CyvEIw4eHjuPO3o96Np1d+9rAA3+Wh3CWziwjcfzlVHKjSD8pP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(83380400001)(2616005)(5660300002)(186003)(316002)(8676002)(66946007)(66476007)(2906002)(4326008)(66556008)(31686004)(36756003)(8936002)(86362001)(508600001)(6486002)(6512007)(26005)(53546011)(6506007)(6666004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFDaVRRbUgwL240MkJaWmRUOW5VSFF4M1VJS1EvYnl2clQyclhDdTIwLzQv?=
 =?utf-8?B?a3JNOXFObnZrZ2lBNUJEa1ExQkhtQWhoL0RVVk1pS0dVV2lpcVNLNkhBTGxR?=
 =?utf-8?B?VlRhT2UxalA1ejEyS0RhbjZmUk5ra2pwM2dRbXptUnJ4V2FxVjFhN1pMcjRz?=
 =?utf-8?B?S1VKTXNyZXE2OGNKOWNSYkFqemNwNVczU0ZWMFAxQlQwa2hYQkRWMUpHUjhs?=
 =?utf-8?B?RzlsZnFibFpjK3VKaXNQREJOMW9EdE9mTWpNMlMrazhVZU5sRWVhMU9wa3JZ?=
 =?utf-8?B?Y2RYSEk4Y3NKeE95MEFKSjU4bFNKUXU3dFpGUXVYR0plU2NUc2hVWWxVTGJk?=
 =?utf-8?B?SldoRVd2bFdNZ2U4YmJlL1dMS2dhaWhDNmJCaWd3VzlJV2NpRHNRbXRSL2po?=
 =?utf-8?B?ZEp4T3psMEtDTDZpR1Y3aHF1aENiY2hMZkpTbmk5ZlFRdDVKNHJqL0YrKzgw?=
 =?utf-8?B?MUxmdXBpUnBqQkVRTEJoWWc5UXl2THd2bHhOL1R5NXQ2RDMyd3VEclYzK1JV?=
 =?utf-8?B?Rjk4djVuZG9haEpTNFVPMmU1SzdUYzY2WGExWVFOejRZNDkrYnUvOFh2ejZ6?=
 =?utf-8?B?RTZuNjlCa25ONWZ5aVc3clZjSjQ2OHVjVXNpcThLVW5HNlUzZWRITHR1NDZy?=
 =?utf-8?B?cS9ISitYMnlRRklOM0JxRVdXc2F2QTUya2FEaWoxRVJZNzFGSE8xTngwS3hq?=
 =?utf-8?B?UWc3Q08yaU5UMXpBNDUySVYwZDJYU0hpcXc0TzZCbG8wSUc2bkhEZTR3bkpl?=
 =?utf-8?B?UFdZcEhwRm9vVWgxZFplZXVIR0N2azJFbmZsdUdzZGloWUhyMmc4K2ZoaDU1?=
 =?utf-8?B?Nk5tU05xRlQrK3ZaNnRiaVdxUmhTdTRKbXkvSjdvd0k1UTFCYyttL0ZyWnZG?=
 =?utf-8?B?SnVsTFJydU1CaFk4SmZmdWdZNmZQVUNaR000aTZnS29NVW05S0ZxNjhFM1BD?=
 =?utf-8?B?MFpURk1TdlRqdGwzR1o5eno1T3ZFVFZqTzMyR1dHZWxPeHluVFhpRnM1MHRs?=
 =?utf-8?B?RUtPQk8yMDhzY3p0bHU1VWtzMUdqVkRqV3JKMHcxc05Vb1BhekJqUCsxSWQ1?=
 =?utf-8?B?RWJMd2JtbFBScFRha1N3WllqeXhTK3hMeWRYN2laUHVCZGtia00zMU5QVG9O?=
 =?utf-8?B?K05FU0V3Y2VJUEJYWE1Ebzl1Tmczakp6Wk4ybDczb29xclVVRnhUNDFyN1Ux?=
 =?utf-8?B?eGMxUHhmdDdsclB6aFQzV3pQQVBSd2orMk94SHN4WEJqK3VMdG9tTC9YNU9R?=
 =?utf-8?B?U2FMYXpGQnhMK3h6SVhodXo4d2MvVGc5Ri8wQjdFZW9acWM2VHpERUhURWxn?=
 =?utf-8?B?MlhFWEhlbi9sL1FWR2I1U0VpVHlHMFRadXhaM2Z4dlNIckVyVm9ad0tha0Zu?=
 =?utf-8?B?d0x4N1hFUkJjS29XeU56N21zdHE1MlpSR2hOUVdnRXRTRHhoWWZDb1Rjd0Zq?=
 =?utf-8?B?WUFRaE5jR0xzZWpqVGhyMWhDRU91eHJWNloyMkc0b1lybU5ZOGxvQ05NOGIx?=
 =?utf-8?B?TUQrVGlqNURiSWxoQTNxejVyS3VUSXVWcUNkUzNvUkJNdUVNNmxVZk0xNmsw?=
 =?utf-8?B?djV6S3RJN2xaZHBReFRXN2FzMWo1c0ZVMFRMbXJndnYwSkY5MXhTaUhlRzQw?=
 =?utf-8?B?NE5oUnNXMUxJdHFHQjZORU9TT1JkQmg0UlIzdXpzbVpUTTFHYmFPM3czMUIz?=
 =?utf-8?B?dlJoM1VQMHhJcGd3bncrd20zNFBnYWV6aEtFRlNBRG1pWHhkOXErSmFWQURj?=
 =?utf-8?B?TDdYZ1VRMUU3bDVQUDY4elZFYW54cUFMd0VDSURHT0pQaVRHdEFza2NoZU9J?=
 =?utf-8?B?MUtJYXU3RnVGQWdYRFJPKzk0UjlhS1hkMldNSXlaWUsvL0ordlV6bE1vdWFh?=
 =?utf-8?B?R1QxN0EzWGtIVURPcGpnL3AxZnlpaHV5djA4V01WaGhBOTJjeXRSUzgvUzNa?=
 =?utf-8?B?OFFzSUdWbDdnZEVPWVE5NENuK0RRSCt4d0VOT0pQam1IRFAzT2dUdDZ1dTNj?=
 =?utf-8?B?RWhIVW1OR3B6VEFKSkJrYWhRZGNOUlJBcUZDUFMvL1V6ZEdUeXlSUUFVSWRh?=
 =?utf-8?B?RzMvV25wMEZKSFRDL3BDNEI0bEpVMHpMWFBudkc4bTUzM21RNW9KajFCNXdr?=
 =?utf-8?B?TkkyUnlxeFpkZGIrV1gwU3I4YitPNUoxdUR1NUgxUzFKazhFNXR6Qi80U25a?=
 =?utf-8?B?Tk1EWklVby9Ybmw1Z3dwT1g4R2c2dzQzalBKZWw3bklwSEZHZHFLMVBrYnFx?=
 =?utf-8?B?ODIxVVd1MlFmQmVsdWVqQzRGTXRudzUrUENXUms2RE5ZYnAyMTR0VHFYb0wv?=
 =?utf-8?B?WnlWMU01ZVd4WGhjeFRkR3BqTFRWZ2w0NzBlT2s4MFpBSEJSSENPdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199408e0-26e6-46a0-97f0-08da31771c51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:48:07.5918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW5GiIzEiJ1xM1vIMqOXvHyKM99T0G4265sCaqVC2Hr0nu+9ErNqESz7XBDUfvz+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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
Cc: Le.Ma@amd.com, kevin1.wang@amd.com, kenneth.feng@amd.com, evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/9/2022 9:28 AM, Darren Powell wrote:
> Size of pp_clock_levels_with_latency is PP_MAX_CLOCK_LEVELS, not MAX_NUM_CLOCKS.
> Both are currently defined as 16, modifying in case one value is modified in future
> Changed code in both arcturus and aldabaran.
> 
> Also removed unneeded var count, and used min_t function
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 9 +++++----
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 9 +++++----
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 201563072189..bdd1e1a35a12 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -573,12 +573,13 @@ static int arcturus_get_clk_table(struct smu_context *smu,
>   			struct pp_clock_levels_with_latency *clocks,
>   			struct smu_11_0_dpm_table *dpm_table)
>   {
> -	int i, count;
> +	uint32_t i;
>   
> -	count = (dpm_table->count > MAX_NUM_CLOCKS) ? MAX_NUM_CLOCKS : dpm_table->count;
> -	clocks->num_levels = count;
> +	clocks->num_levels = min_t(uint32_t,
> +				   dpm_table->count,
> +				   (uint32_t)PP_MAX_CLOCK_LEVELS);
>   
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < clocks->num_levels; i++) {
>   		clocks->data[i].clocks_in_khz =
>   			dpm_table->dpm_levels[i].value * 1000;
>   		clocks->data[i].latency_in_us = 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 38af648cb857..6a4fca47ae53 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -549,12 +549,13 @@ static int aldebaran_get_clk_table(struct smu_context *smu,
>   				   struct pp_clock_levels_with_latency *clocks,
>   				   struct smu_13_0_dpm_table *dpm_table)
>   {
> -	int i, count;
> +	uint32_t i;
>   
> -	count = (dpm_table->count > MAX_NUM_CLOCKS) ? MAX_NUM_CLOCKS : dpm_table->count;
> -	clocks->num_levels = count;
> +	clocks->num_levels = min_t(uint32_t,
> +				   dpm_table->count,
> +				   (uint32_t)PP_MAX_CLOCK_LEVELS);
>   
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < clocks->num_levels; i++) {
>   		clocks->data[i].clocks_in_khz =
>   			dpm_table->dpm_levels[i].value * 1000;
>   		clocks->data[i].latency_in_us = 0;
> 
> base-commit: 8bb14fbec5ae45c31cbefe217db2418cc683612f
> 
