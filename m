Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545CBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 16:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1ACE8F2CA;
	Fri, 22 Jul 2022 16:22:48 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8FE8D116
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 16:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKdWFl81raD2yuYpLk09IxP+NnxL1DjcNbVmSkdURu7QZUlsjqEy/pbmBz1jsmcBHc/4g4tDFZVj2ZpLPg41jygjzD4sGfYtzdvSDs8ffml6IQ7iXkIjF1RwE2rcO+E7s3WGIZLeJFR+nqxH5BbUY4ORVF42hlrvfnZKbNdXyA4VWUD9ho/L4bbB/goqt+AobgpMwAt3hrhmgnopA8sJoxovp4O6iAXRNnv6Lm31NRtqUIhj8gtDwkc43qIVqV2qGQ7KtZFgMCxyNKtDhIMVaBdI+nDmY72970pxmey27FlTKIE6sYj+cN3XUg3LLJg1/8Do5bLOwh0mXy89ATv+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCNpyw+Gvq41inyqjOIRxsTR5Zf5qHHJC3QjK70FX88=;
 b=VqsSrsocU2FGbRPbeFOeAmSjGcGp2J+gj9LlCsInqmyYP0OGrJy4YdCUUUjCIYxxVgGRR0GiAskjA6wXyv+jmCDeQv90m7ISiC3bXRFmXuSYEcH78z5JuBkCy56lRIlSczhIyXskyzZxz4dAVCUJtWSDXlaiCp5RRQXRjBhM/7H+JM9/arTlE518tCa3f26pcWrCT56zd+XJUEMTw/MvS/kcNAISJsub8UuKmNm5zD3Xc2udnx0F0ud1u01kj5ViKLL45+WJFMEE5NKRYRnW3d5Tv59w+J7esPfPJ9Ct7+YC9jnZy5X+40e+VQiU5uQTj47nTgh286biUKVf37LPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCNpyw+Gvq41inyqjOIRxsTR5Zf5qHHJC3QjK70FX88=;
 b=aA1vRzPcjDL5GK3GnS9sOb3I9sXmHDzRh8iwiuVy7/BKk0WtdaiiXJigvr8R3oL/DYhNXSifPzMFgr8MdlYK4nAJA6a9mr/lWIo4BoV/cJfVu1RcpM2BS0KMIqU/br/qT/pIvF37yebTK4injPsX+WmnvlDRzwhDRpJshsgow+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BYAPR12MB3288.namprd12.prod.outlook.com (2603:10b6:a03:130::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Fri, 22 Jul
 2022 16:22:42 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 16:22:42 +0000
Message-ID: <34dc6cbe-a6c5-bb5b-1d58-185ff854a169@amd.com>
Date: Fri, 22 Jul 2022 12:22:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/5] drm/amd/display: reduce stack size in dcn32 dml (v2)
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20220721051305.1356754-1-alexander.deucher@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220721051305.1356754-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:610:52::19) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 796a215e-3c3c-479b-5088-08da6bfe66e6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3288:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDs6vChxUqPqLVyKrarFMNWesWu49AEETOdSNdFeUi7nFE1IxVDJj2DqWhSJspOjzrnRA0zTilLIo/eh4qpOKiNnKGgL/oVBfduwUmOHIH2KKK7fYDeI3aDSfmIPtIkngABmIhKuY1520X6rCUXLbMWa0OAbsR40hJ9p+VnA2qR5odXHiVsA1IG6K9uLlDu41O7ZKePUQ9HG/RDRD03571eteka1BODax0DoDNhG1bywVd7rCQxHV+Y77q/rmUlQrgGzTWKP2km8QqII7j9P0BwYrAYLZrr2Ca/Y4jksNrPNgPA11478n1QhmW/QHgcr/duNJmBtfUY8MiCPuApRz/QaNTCXfuVJKCEGhxsJuF3inNzZkuI9WA6/wg8/TGA6Of0ZB2ngTmal965nsjsNKbzSM7VeqISjsmmMUuk+2Y2eeErDBtGFRxevFNxydQw4ksspzzmVrq4ECLxPog6mQhFStNL/6H0kTbGStPbwqicmYr+VJLUXzc2mbevJVZApRT1gmuDERD8zQ5P/qx4XWCtijApeWrI51uYNJ1yIqvCb/TityA0V3N7RLM/MIfCr/jP0ABi8XQGrBt7VWSi6NDm+OgvduzI9/FMVxU8n2Xzx6ICTlaCSK11f1ZmdyhaeyJVrLww9xxpZTrQaEtPG5Y1chGPVMlTgG2Wqd3BJd/lZcs7vkDYGE9j/adxYk9JNiFlzDMACuKqhp9hEMHZVF8QLHjJ0XkNaoemToQJpkmTd8ohGFelyMFuORWirKXR7iOswB7hfe7EzS6jU+zbOagVhsBdAtoUAifE2Y/x7XdVMqj0nyWgP3r1aQbMNfvOgpnrOq0Jlk2R98H+8GPkKmIIGYFJIds84pEGRaGrNhRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(4326008)(8936002)(30864003)(41300700001)(66476007)(316002)(6916009)(54906003)(8676002)(66946007)(5660300002)(26005)(2616005)(66556008)(6506007)(83380400001)(6512007)(2906002)(53546011)(186003)(86362001)(38100700002)(36756003)(478600001)(6486002)(31696002)(31686004)(19627235002)(43740500002)(45980500001)(559001)(579004)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWEyR2U3V2x3RkpDS3E5MUpFRnlGa2dOTWRJZmpxbFhOVndDU1BkOTFheW5t?=
 =?utf-8?B?UjQrS0pHSThVVitUUHBySFR3UmdqSWZsb0ZGd0lmQnI2dkF6OEY5eTR4Ump5?=
 =?utf-8?B?bGhwYzJRUVd5N0RTaVF4VXpHSlppcVgrTWRFemM0OXI3dVBJclF2KzNPTEVx?=
 =?utf-8?B?SFpkeDF1RGFpMXhLanhJdFdneVYvYjVScWMxbkFJbkF4cFFseG5pV3hnNm82?=
 =?utf-8?B?Yy82RTNFcWNXUEluQVN4L3VrMU9WNHl4MkxJbFZiei9OOXE2WTMrZGJxMU1h?=
 =?utf-8?B?Y1Q0R0ExRkFMbGR0eDhsandUUDhhM005bnRRcXNtSGpad1gxaUhXQ2IrWVA2?=
 =?utf-8?B?VXdtQkxtdVlvWkFJRHJmNGE5NnlCVkZSMzh3N05QbEZKQnNJbDBCWENSc2tT?=
 =?utf-8?B?djdvamh1TXFTMk5MMFNjWHd6eWsrVEJJZ2IxbmxlMXoxYmpuQ0pBZ3Y5QW1I?=
 =?utf-8?B?aDlZMnlaVUk1Z1FJUGVFRUxON2RYczQwTUJ2WVhZTVVZblJhZmF3NkNONDln?=
 =?utf-8?B?QnordkdhdE9KQWNraTdRMm15aTVrVit0TzRpMC8ycmlvb0t4K3llbnJSbTlO?=
 =?utf-8?B?N3YxNkcwOU80S0c3UE5rV3B1T0tJT0JjSkt4N3dLVGpSUVc5L3NDMVNRbUlw?=
 =?utf-8?B?MnR1QlhwVEhNb0phdnBJLzVFTHQ5dkQrdGNUdjM3YVZZd2VUUTl5Q2xYNjk1?=
 =?utf-8?B?aE4wYWRWR2ZrMjB4bzQ1S2s5dTZUTlZuZDRiaFNIVlZWcmxwblNpMUxxNTBJ?=
 =?utf-8?B?cXh2bnVGYmhXR1lwNFdzYldMWDRxb3pUTnRRZXFlaWQ1T3laQnIxdndxS0di?=
 =?utf-8?B?bkVWMGh1M3N0WW1hdXpnbXFJZ0dXaXIwVHVCUzdBakRhMDJMcU1jNTQzWUtR?=
 =?utf-8?B?SzM0UU9YckZZVDIwdzRLNUVBamgyQ0FkT3hYclZqdkxJdXZNM0UxNlU2TW94?=
 =?utf-8?B?WFpTYUdqc3ZSQUQzTWwwK29JRHkzbjEyVmpKQWxOZEFlbW8xbHNUQVZoSWR0?=
 =?utf-8?B?N3RDT2d0NjIvVU1zKzVGckgvTzFNOW1FQ0pRbWRwdkVtUmtiQjEvdVg3MW1D?=
 =?utf-8?B?ZGlId05XTUpjNHNZcUo3SGJvZ04yYVdQejlTQzYybXBheS92RGhrYmtSS1Rn?=
 =?utf-8?B?b1JTRFd6aUNML2JpekJwaVhxQkVDV0Z6ZzZzaXE3T09wMWNJMzVrK2tXTXEz?=
 =?utf-8?B?OGx2WENmOHhBQXFLWGEwVGd4cjJjNWdHU01QWlZDcUsraktUd1ZnbE5xZmli?=
 =?utf-8?B?VlJBall0Q2hhTm5acG5obktsOFh3VEdmYmdDbEU4WjA5dlJ5bzE2Q0pidzc1?=
 =?utf-8?B?RlU4WTArelRKMVcrcERzV0w3cEU4WHlkL2dpR2pnWER3YTdyYnF0K1lBWEQ1?=
 =?utf-8?B?TFNqSlAxTWR4WTlnTkpnVllyUEFLRWJIUmdjZ01YeDZJWkFWQ25kNElBV3dI?=
 =?utf-8?B?SFZNZE9yMldtU0JoOEQzQVFQTnl2eUZiNmU4b1ljbGZUZEkzV29aazk0Zk9t?=
 =?utf-8?B?d0hsa1FMekhMN1RRa1cyenVtTm13dVNVQ1VFUGpWQ1ExR2xZN25tVjU0Y0dG?=
 =?utf-8?B?elEvRXpOZDJCdDNUa29hakF0QkZrdE9CN0NVMzRMUW5SRjd1MnJPOHpZWUpM?=
 =?utf-8?B?Z1V0MTMvMkFhbjA0NEtUZHpXcHpneWN1c3ZFRTZFT2Mwb3U1N0E1bzEva2Uz?=
 =?utf-8?B?RVBQcU1zNzlkV0NpRTVvVnZpNGJIb0JyRW5qSi8xNFI3NCtzNTJobkNmc2xV?=
 =?utf-8?B?Q3NpL1Y4ZUVJclcyWVZRVENlcUJDV1I1djZybUJWd2JaWVluU0hrcWd5UHZF?=
 =?utf-8?B?aWpuOEozUU5QSEs0OUt6VWFZSkg4MGxKY1pjeGRBSUFvTXp0NDFiSXNjK1RW?=
 =?utf-8?B?N1k5cVZXL2FQVGhLTmRvWWdZeURmRk0xNnIxRzFJT1hUTmlHMytVbDg2Wkhu?=
 =?utf-8?B?SStwa29LbWpPcFhmUVpOYmJqeWlBdUtaRUVEc1lQcWdTU3FYTThocGJkSkkw?=
 =?utf-8?B?MHArQUZZb2Y3Q0s2T0tyd3NGQ1RpTmlMSXNXeE9OSzFudlllRjYyTmx3Qzg1?=
 =?utf-8?B?VkZvQmhYOThCSUttY3I1YW1UaU9WVGg1V1JNcHIxdjRUQ0poaU96ck4zbkxx?=
 =?utf-8?Q?oCXDJpVvjCqjBUWTS+KyyogUu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796a215e-3c3c-479b-5088-08da6bfe66e6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 16:22:42.1081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUO/tv7fUE65vwuabuPYMVcqSBYSm1oNF1EGjdtbVqEwUCsppZqWb0Riq48Io2doGbXaXyDvVwTTMSnLPzxYxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
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
Cc: Alex Hung <alex.hung@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-07-21 01:13, Alex Deucher wrote:
> Move additional dummy structures off the stack and into
> the dummy vars structure.
> 
> Fixes the following:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1659:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>   1659 | }
>        | ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>   3799 | } // ModeSupportAndSystemConfigurationFull
>        | ^

Hi Alex,

I tested this change via our CI and conducted some smoke tests, and 
everything looks fine. However, this series does not entirely fix the 
dml32_ModeSupportAndSystemConfigurationFull since Alex Hung, and I can 
still reproduce this issue. I notice that 
dml32_ModeSupportAndSystemConfigurationFull almost does not have local 
variables, which means that moving the other variables to the struct 
will not work anymore. I'm working on the fix for the missing issue; 
I'll try to send it today.

Anyway, this series is:
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks
Siqueira

> 
> v2: move more stuff to dummy structure, fix init order (Alex)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   .../dc/dml/dcn32/display_mode_vba_32.c        | 411 ++++++++----------
>   .../drm/amd/display/dc/dml/display_mode_vba.h |  36 ++
>   2 files changed, 217 insertions(+), 230 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index e9204c711cb9..9c2003fbe8fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -65,6 +65,12 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   	int iteration;
>   	double MaxTotalRDBandwidth;
>   	unsigned int NextPrefetchMode;
> +	double MaxTotalRDBandwidthNoUrgentBurst = 0.0;
> +	bool DestinationLineTimesForPrefetchLessThan2 = false;
> +	bool VRatioPrefetchMoreThanMax = false;
> +	double TWait;
> +	double TotalWRBandwidth = 0;
> +	double WRBandwidth = 0;
>   
>   #ifdef __DML_VBA_DEBUG__
>   	dml_print("DML::%s: --- START ---\n", __func__);
> @@ -710,11 +716,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   	NextPrefetchMode = mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb];
>   
>   	do {
> -		double MaxTotalRDBandwidthNoUrgentBurst = 0.0;
> -		bool DestinationLineTimesForPrefetchLessThan2 = false;
> -		bool VRatioPrefetchMoreThanMax = false;
> -		double dummy_unit_vector[DC__NUM_DPP__MAX];
> -
>   		MaxTotalRDBandwidth = 0;
>   #ifdef __DML_VBA_DEBUG__
>   		dml_print("DML::%s: Start loop: VStartup = %d\n", __func__, mode_lib->vba.VStartupLines);
> @@ -723,41 +724,39 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   			/* NOTE PerfetchMode variable is invalid in DAL as per the input received.
>   			 * Hence the direction is to use PrefetchModePerState.
>   			 */
> -			double TWait = dml32_CalculateTWait(
> -					mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
> -					mode_lib->vba.UsesMALLForPStateChange[k],
> -					mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
> -					mode_lib->vba.DRRDisplay[k],
> -					mode_lib->vba.DRAMClockChangeLatency,
> -					mode_lib->vba.FCLKChangeLatency, v->UrgentLatency,
> -					mode_lib->vba.SREnterPlusExitTime);
> -
> -			DmlPipe myPipe;
> -
> -			myPipe.Dppclk = mode_lib->vba.DPPCLK[k];
> -			myPipe.Dispclk = mode_lib->vba.DISPCLK;
> -			myPipe.PixelClock = mode_lib->vba.PixelClock[k];
> -			myPipe.DCFClkDeepSleep = v->DCFCLKDeepSleep;
> -			myPipe.DPPPerSurface = mode_lib->vba.DPPPerPlane[k];
> -			myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
> -			myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
> -			myPipe.BlockWidth256BytesY = v->BlockWidth256BytesY[k];
> -			myPipe.BlockHeight256BytesY = v->BlockHeight256BytesY[k];
> -			myPipe.BlockWidth256BytesC = v->BlockWidth256BytesC[k];
> -			myPipe.BlockHeight256BytesC = v->BlockHeight256BytesC[k];
> -			myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
> -			myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
> -			myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
> -			myPipe.HTotal = mode_lib->vba.HTotal[k];
> -			myPipe.HActive = mode_lib->vba.HActive[k];
> -			myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
> -			myPipe.ODMMode = mode_lib->vba.ODMCombineEnabled[k];
> -			myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
> -			myPipe.BytePerPixelY = v->BytePerPixelY[k];
> -			myPipe.BytePerPixelC = v->BytePerPixelC[k];
> -			myPipe.ProgressiveToInterlaceUnitInOPP = mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
> +			TWait = dml32_CalculateTWait(
> +				mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
> +				mode_lib->vba.UsesMALLForPStateChange[k],
> +				mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
> +				mode_lib->vba.DRRDisplay[k],
> +				mode_lib->vba.DRAMClockChangeLatency,
> +				mode_lib->vba.FCLKChangeLatency, v->UrgentLatency,
> +				mode_lib->vba.SREnterPlusExitTime);
> +
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.Dppclk = mode_lib->vba.DPPCLK[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.Dispclk = mode_lib->vba.DISPCLK;
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DCFClkDeepSleep = v->DCFCLKDeepSleep;
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DPPPerSurface = mode_lib->vba.DPPPerPlane[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockWidth256BytesY = v->BlockWidth256BytesY[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockHeight256BytesY = v->BlockHeight256BytesY[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockWidth256BytesC = v->BlockWidth256BytesC[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockHeight256BytesC = v->BlockHeight256BytesC[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.HTotal = mode_lib->vba.HTotal[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.HActive = mode_lib->vba.HActive[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ODMMode = mode_lib->vba.ODMCombineEnabled[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelY = v->BytePerPixelY[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelC = v->BytePerPixelC[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ProgressiveToInterlaceUnitInOPP = mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
>   			v->ErrorResult[k] = dml32_CalculatePrefetchSchedule(v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.HostVMInefficiencyFactor,
> -					&myPipe, v->DSCDelay[k],
> +					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe, v->DSCDelay[k],
>   					mode_lib->vba.DPPCLKDelaySubtotal + mode_lib->vba.DPPCLKDelayCNVCFormater,
>   					mode_lib->vba.DPPCLKDelaySCL,
>   					mode_lib->vba.DPPCLKDelaySCLLBOnly,
> @@ -906,8 +905,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   #endif
>   
>   		{
> -			double dummy_single[1];
> -
>   			dml32_CalculatePrefetchBandwithSupport(
>   					mode_lib->vba.NumberOfActiveSurfaces,
>   					mode_lib->vba.ReturnBW,
> @@ -931,16 +928,14 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   
>   					/* output */
>   					&MaxTotalRDBandwidth,
> -					&dummy_single[0],
> +					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_single[0],
>   					&v->PrefetchModeSupported);
>   		}
>   
>   		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k)
> -			dummy_unit_vector[k] = 1.0;
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector[k] = 1.0;
>   
>   		{
> -			double  dummy_single[1];
> -			bool dummy_boolean[1];
>   			dml32_CalculatePrefetchBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
>   					mode_lib->vba.ReturnBW,
>   					v->NoUrgentLatencyHidingPre,
> @@ -954,17 +949,17 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   					v->cursor_bw_pre,
>   					v->prefetch_vmrow_bw,
>   					mode_lib->vba.DPPPerPlane,
> -					dummy_unit_vector,
> -					dummy_unit_vector,
> -					dummy_unit_vector,
> -					dummy_unit_vector,
> -					dummy_unit_vector,
> -					dummy_unit_vector,
> +					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
>   
>   					/* output */
> -					&dummy_single[0],
> +					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_single[0],
>   					&v->FractionOfUrgentBandwidth,
> -					&dummy_boolean[0]);
> +					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_boolean);
>   		}
>   
>   		if (VRatioPrefetchMoreThanMax != false || DestinationLineTimesForPrefetchLessThan2 != false) {
> @@ -1047,8 +1042,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   			}
>   
>   			{
> -				double  dummy_single[2];
> -				bool dummy_boolean[1];
>   				dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
>   						mode_lib->vba.ReturnBW,
>   						mode_lib->vba.ImmediateFlipRequirement,
> @@ -1072,7 +1065,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   
>   						/* output */
>   						&v->total_dcn_read_bw_with_flip,    // Single  *TotalBandwidth
> -						&dummy_single[0],                        // Single  *FractionOfUrgentBandwidth
> +						&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_single[0],                        // Single  *FractionOfUrgentBandwidth
>   						&v->ImmediateFlipSupported);        // Boolean *ImmediateFlipBandwidthSupport
>   
>   				dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
> @@ -1089,17 +1082,17 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   						v->cursor_bw_pre,
>   						v->prefetch_vmrow_bw,
>   						mode_lib->vba.DPPPerPlane,
> -						dummy_unit_vector,
> -						dummy_unit_vector,
> -						dummy_unit_vector,
> -						dummy_unit_vector,
> -						dummy_unit_vector,
> -						dummy_unit_vector,
> +						v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +						v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +						v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +						v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +						v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
> +						v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
>   
>   						/* output */
> -						&dummy_single[1],                                // Single  *TotalBandwidth
> +						&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_single[1],                                // Single  *TotalBandwidth
>   						&v->FractionOfUrgentBandwidthImmediateFlip, // Single  *FractionOfUrgentBandwidth
> -						&dummy_boolean[0]);                              // Boolean *ImmediateFlipBandwidthSupport
> +						&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_boolean);                              // Boolean *ImmediateFlipBandwidthSupport
>   			}
>   
>   			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
> @@ -1157,22 +1150,17 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   
>   	//Watermarks and NB P-State/DRAM Clock Change Support
>   	{
> -		SOCParametersList mmSOCParameters;
> -		enum clock_change_support dummy_dramchange_support;
> -		enum dm_fclock_change_support dummy_fclkchange_support;
> -		bool dummy_USRRetrainingSupport;
> -
> -		mmSOCParameters.UrgentLatency = v->UrgentLatency;
> -		mmSOCParameters.ExtraLatency = v->UrgentExtraLatency;
> -		mmSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
> -		mmSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
> -		mmSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
> -		mmSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
> -		mmSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
> -		mmSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
> -		mmSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
> -		mmSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
> -		mmSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.UrgentLatency = v->UrgentLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.ExtraLatency = v->UrgentExtraLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
>   
>   		dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
>   			mode_lib->vba.USRRetrainingRequiredFinal,
> @@ -1190,7 +1178,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   			v->dpte_group_bytes,
>   			v->meta_row_height,
>   			v->meta_row_height_chroma,
> -			mmSOCParameters,
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters,
>   			mode_lib->vba.WritebackChunkSize,
>   			mode_lib->vba.SOCCLK,
>   			v->DCFCLKDeepSleep,
> @@ -1227,12 +1215,12 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   
>   			/* Output */
>   			&v->Watermark,
> -			&dummy_dramchange_support,
> +			&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_dramchange_support,
>   			v->MaxActiveDRAMClockChangeLatencySupported,
>   			v->SubViewportLinesNeededInMALL,
> -			&dummy_fclkchange_support,
> +			&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_fclkchange_support,
>   			&v->MinActiveFCLKChangeLatencySupported,
> -			&dummy_USRRetrainingSupport,
> +			&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_USRRetrainingSupport,
>   			mode_lib->vba.ActiveDRAMClockChangeLatencyMargin);
>   
>   		/* DCN32 has a new struct Watermarks (typedef) which is used to store
> @@ -1494,9 +1482,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   
>   	{
>   		//Maximum Bandwidth Used
> -		double TotalWRBandwidth = 0;
> -		double WRBandwidth = 0;
> -
>   		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   			if (mode_lib->vba.WritebackEnable[k] == true
>   					&& mode_lib->vba.WritebackPixelFormat[k] == dm_444_32) {
> @@ -1590,9 +1575,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   
>   #ifdef __DML_VBA_ALLOW_DELTA__
>   	{
> -		double dummy_single[2];
>   		unsigned int dummy_integer[1];
> -		bool dummy_boolean[1];
>   
>   		// Calculate z8 stutter eff assuming 0 reserved space
>   		dml32_CalculateStutterEfficiency(v->CompressedBufferSizeInkByte,
> @@ -1645,14 +1628,14 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   				v->meta_row_bw, v->dpte_row_bw,
>   
>   				/* Output */
> -				&dummy_single[0],
> -				&dummy_single[1],
> +				&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_single[0],
> +				&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_single[1],
>   				&dummy_integer[0],
>   				&v->Z8StutterEfficiencyNotIncludingVBlankBestCase,
>   				&v->Z8StutterEfficiencyBestCase,
>   				&v->Z8NumberOfStutterBurstsPerFrameBestCase,
>   				&v->StutterPeriodBestCase,
> -				&dummy_boolean[0]);
> +				&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_boolean);
>   	}
>   #else
>   	v->Z8StutterEfficiencyNotIncludingVBlankBestCase = v->Z8StutterEfficiencyNotIncludingVBlank;
> @@ -1668,32 +1651,18 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>   
>   void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>   {
> -	unsigned int dummy_integer[4];
> -	bool dummy_boolean[2];
> -	bool MPCCombineMethodAsNeededForPStateChangeAndVoltage;
> -	bool MPCCombineMethodAsPossible;
> -	enum odm_combine_mode dummy_odm_mode[DC__NUM_DPP__MAX];
> -	unsigned int TotalNumberOfActiveOTG;
> -	unsigned int TotalNumberOfActiveHDMIFRL;
> -	unsigned int TotalNumberOfActiveDP2p0;
> -	unsigned int TotalNumberOfActiveDP2p0Outputs;
> -	unsigned int TotalDSCUnitsRequired;
> -	unsigned int m;
> -	unsigned int ReorderingBytes;
> -	bool FullFrameMALLPStateMethod;
> -	bool SubViewportMALLPStateMethod;
> -	bool PhantomPipeMALLPStateMethod;
> +	struct vba_vars_st *v = &mode_lib->vba;
> +	int i, j;
> +	unsigned int k, m;
>   	unsigned int MaximumMPCCombine;
> +	unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth;
> +	unsigned int TotalSlots;
>   	bool CompBufReservedSpaceNeedAdjustment;
>   	bool CompBufReservedSpaceNeedAdjustmentSingleDPP;
>   
>   #ifdef __DML_VBA_DEBUG__
>   	dml_print("DML::%s: called\n", __func__);
>   #endif
> -	struct vba_vars_st *v = &mode_lib->vba;
> -
> -	int i, j;
> -	unsigned int k;
>   
>   	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
>   
> @@ -1945,7 +1914,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			mode_lib->vba.Read256BlockHeightC,
>   			mode_lib->vba.Read256BlockWidthY,
>   			mode_lib->vba.Read256BlockWidthC,
> -			dummy_odm_mode,
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_odm_mode,
>   			mode_lib->vba.BlendingAndTiming,
>   			mode_lib->vba.BytePerPixelY,
>   			mode_lib->vba.BytePerPixelC,
> @@ -1973,35 +1942,26 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			mode_lib->vba.SingleDPPViewportSizeSupportPerSurface,/* bool ViewportSizeSupportPerSurface[] */
>   			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1][0]); /* bool           *ViewportSizeSupport */
>   
> -	MPCCombineMethodAsNeededForPStateChangeAndVoltage = false;
> -	MPCCombineMethodAsPossible = false;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage = false;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible = false;
>   
>   	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   		if (mode_lib->vba.MPCCombineUse[k] == dm_mpc_reduce_voltage_and_clocks)
> -			MPCCombineMethodAsNeededForPStateChangeAndVoltage = true;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage = true;
>   		if (mode_lib->vba.MPCCombineUse[k] == dm_mpc_always_when_possible)
> -			MPCCombineMethodAsPossible = true;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible = true;
>   	}
> -	mode_lib->vba.MPCCombineMethodIncompatible = MPCCombineMethodAsNeededForPStateChangeAndVoltage
> -			&& MPCCombineMethodAsPossible;
> +	mode_lib->vba.MPCCombineMethodIncompatible = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage
> +			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible;
>   
>   	for (i = 0; i < v->soc.num_states; i++) {
>   		for (j = 0; j < 2; j++) {
> -			bool NoChroma;
>   			mode_lib->vba.TotalNumberOfActiveDPP[i][j] = 0;
>   			mode_lib->vba.TotalAvailablePipesSupport[i][j] = true;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC = dm_odm_combine_mode_disabled;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC = dm_odm_combine_mode_disabled;
>   
>   			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
> -
> -				bool TotalAvailablePipesSupportNoDSC;
> -				unsigned int NumberOfDPPNoDSC;
> -				enum odm_combine_mode ODMModeNoDSC = dm_odm_combine_mode_disabled;
> -				double RequiredDISPCLKPerSurfaceNoDSC;
> -				bool TotalAvailablePipesSupportDSC;
> -				unsigned int NumberOfDPPDSC;
> -				enum odm_combine_mode ODMModeDSC = dm_odm_combine_mode_disabled;
> -				double RequiredDISPCLKPerSurfaceDSC;
> -
>   				dml32_CalculateODMMode(
>   						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
>   						mode_lib->vba.HActive[k],
> @@ -2018,10 +1978,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
>   
>   						/* Output */
> -						&TotalAvailablePipesSupportNoDSC,
> -						&NumberOfDPPNoDSC,
> -						&ODMModeNoDSC,
> -						&RequiredDISPCLKPerSurfaceNoDSC);
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportNoDSC,
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPNoDSC,
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC,
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceNoDSC);
>   
>   				dml32_CalculateODMMode(
>   						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
> @@ -2039,10 +1999,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   						mode_lib->vba.DISPCLKDPPCLKVCOSpeed,
>   
>   						/* Output */
> -						&TotalAvailablePipesSupportDSC,
> -						&NumberOfDPPDSC,
> -						&ODMModeDSC,
> -						&RequiredDISPCLKPerSurfaceDSC);
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportDSC,
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPDSC,
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC,
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceDSC);
>   
>   				dml32_CalculateOutputLink(
>   						mode_lib->vba.PHYCLKPerState[i],
> @@ -2060,8 +2020,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   						mode_lib->vba.NumberOfDSCSlices[k],
>   						mode_lib->vba.AudioSampleRate[k],
>   						mode_lib->vba.AudioSampleLayout[k],
> -						ODMModeNoDSC,
> -						ODMModeDSC,
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC,
> +						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC,
>   						mode_lib->vba.DSCEnable[k],
>   						mode_lib->vba.OutputLinkDPLanes[k],
>   						mode_lib->vba.OutputLinkDPRate[k],
> @@ -2075,21 +2035,21 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   						&mode_lib->vba.RequiredSlots[i][k]);
>   
>   				if (mode_lib->vba.RequiresDSC[i][k] == false) {
> -					mode_lib->vba.ODMCombineEnablePerState[i][k] = ODMModeNoDSC;
> +					mode_lib->vba.ODMCombineEnablePerState[i][k] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeNoDSC;
>   					mode_lib->vba.RequiredDISPCLKPerSurface[i][j][k] =
> -							RequiredDISPCLKPerSurfaceNoDSC;
> -					if (!TotalAvailablePipesSupportNoDSC)
> +							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceNoDSC;
> +					if (!v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportNoDSC)
>   						mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
>   					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
> -							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + NumberOfDPPNoDSC;
> +							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPNoDSC;
>   				} else {
> -					mode_lib->vba.ODMCombineEnablePerState[i][k] = ODMModeDSC;
> +					mode_lib->vba.ODMCombineEnablePerState[i][k] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ODMModeDSC;
>   					mode_lib->vba.RequiredDISPCLKPerSurface[i][j][k] =
> -							RequiredDISPCLKPerSurfaceDSC;
> -					if (!TotalAvailablePipesSupportDSC)
> +							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.RequiredDISPCLKPerSurfaceDSC;
> +					if (!v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalAvailablePipesSupportDSC)
>   						mode_lib->vba.TotalAvailablePipesSupport[i][j] = false;
>   					mode_lib->vba.TotalNumberOfActiveDPP[i][j] =
> -							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + NumberOfDPPDSC;
> +							mode_lib->vba.TotalNumberOfActiveDPP[i][j] + v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NumberOfDPPDSC;
>   				}
>   			}
>   
> @@ -2124,7 +2084,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			}
>   
>   			mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] = 0;
> -			NoChroma = true;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma = true;
>   
>   			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   				if (mode_lib->vba.NoOfDPP[i][j][k] == 1)
> @@ -2134,7 +2094,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   						|| mode_lib->vba.SourcePixelFormat[k] == dm_420_10
>   						|| mode_lib->vba.SourcePixelFormat[k] == dm_420_12
>   						|| mode_lib->vba.SourcePixelFormat[k] == dm_rgbe_alpha) {
> -					NoChroma = false;
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma = false;
>   				}
>   			}
>   
> @@ -2145,15 +2105,15 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   
>   
>   			if (j == 1 && !dml32_UnboundedRequest(mode_lib->vba.UseUnboundedRequesting,
> -					mode_lib->vba.TotalNumberOfActiveDPP[i][j], NoChroma,
> +					mode_lib->vba.TotalNumberOfActiveDPP[i][j], v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NoChroma,
>   					mode_lib->vba.Output[0],
>   					mode_lib->vba.SurfaceTiling[0],
>   					CompBufReservedSpaceNeedAdjustment,
>   					mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment)) {
>   				while (!(mode_lib->vba.TotalNumberOfActiveDPP[i][j] >= mode_lib->vba.MaxNumDPP
>   						|| mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] == 0)) {
> -					double BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
> -					unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
> +					NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
>   
>   					for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   						if (mode_lib->vba.MPCCombineUse[k]
> @@ -2161,13 +2121,13 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   							mode_lib->vba.MPCCombineUse[k] != dm_mpc_reduce_voltage &&
>   							mode_lib->vba.ReadBandwidthLuma[k] +
>   							mode_lib->vba.ReadBandwidthChroma[k] >
> -							BWOfNonCombinedSurfaceOfMaximumBandwidth &&
> +							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth &&
>   							(mode_lib->vba.ODMCombineEnablePerState[i][k] !=
>   							dm_odm_combine_mode_2to1 &&
>   							mode_lib->vba.ODMCombineEnablePerState[i][k] !=
>   							dm_odm_combine_mode_4to1) &&
>   								mode_lib->vba.MPCCombine[i][j][k] == false) {
> -							BWOfNonCombinedSurfaceOfMaximumBandwidth =
> +							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.BWOfNonCombinedSurfaceOfMaximumBandwidth =
>   								mode_lib->vba.ReadBandwidthLuma[k]
>   								+ mode_lib->vba.ReadBandwidthChroma[k];
>   							NumberOfNonCombinedSurfaceOfMaximumBandwidth = k;
> @@ -2233,28 +2193,28 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   	} // i (VOLTAGE_STATE)
>   
>   	/* Total Available OTG, HDMIFRL, DP Support Check */
> -	TotalNumberOfActiveOTG = 0;
> -	TotalNumberOfActiveHDMIFRL = 0;
> -	TotalNumberOfActiveDP2p0 = 0;
> -	TotalNumberOfActiveDP2p0Outputs = 0;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG = 0;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveHDMIFRL = 0;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 = 0;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs = 0;
>   
>   	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   		if (mode_lib->vba.BlendingAndTiming[k] == k) {
> -			TotalNumberOfActiveOTG = TotalNumberOfActiveOTG + 1;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG + 1;
>   			if (mode_lib->vba.Output[k] == dm_dp2p0) {
> -				TotalNumberOfActiveDP2p0 = TotalNumberOfActiveDP2p0 + 1;
> +				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 + 1;
>   				if (mode_lib->vba.OutputMultistreamId[k]
>   						== k || mode_lib->vba.OutputMultistreamEn[k] == false) {
> -					TotalNumberOfActiveDP2p0Outputs = TotalNumberOfActiveDP2p0Outputs + 1;
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs + 1;
>   				}
>   			}
>   		}
>   	}
>   
> -	mode_lib->vba.NumberOfOTGSupport = (TotalNumberOfActiveOTG <= mode_lib->vba.MaxNumOTG);
> -	mode_lib->vba.NumberOfHDMIFRLSupport = (TotalNumberOfActiveHDMIFRL <= mode_lib->vba.MaxNumHDMIFRLOutputs);
> -	mode_lib->vba.NumberOfDP2p0Support = (TotalNumberOfActiveDP2p0 <= mode_lib->vba.MaxNumDP2p0Streams
> -			&& TotalNumberOfActiveDP2p0Outputs <= mode_lib->vba.MaxNumDP2p0Outputs);
> +	mode_lib->vba.NumberOfOTGSupport = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG <= mode_lib->vba.MaxNumOTG);
> +	mode_lib->vba.NumberOfHDMIFRLSupport = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveHDMIFRL <= mode_lib->vba.MaxNumHDMIFRLOutputs);
> +	mode_lib->vba.NumberOfDP2p0Support = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 <= mode_lib->vba.MaxNumDP2p0Streams
> +			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs <= mode_lib->vba.MaxNumDP2p0Outputs);
>   
>   	/* Display IO and DSC Support Check */
>   	mode_lib->vba.NonsupportedDSCInputBPC = false;
> @@ -2269,8 +2229,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   	}
>   
>   	for (i = 0; i < v->soc.num_states; ++i) {
> -		unsigned int TotalSlots;
> -
>   		mode_lib->vba.ExceededMultistreamSlots[i] = false;
>   		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   			if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k) {
> @@ -2441,12 +2399,12 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   	}
>   
>   	/* Check DSC Unit and Slices Support */
> -	TotalDSCUnitsRequired = 0;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
>   
>   	for (i = 0; i < v->soc.num_states; ++i) {
>   		mode_lib->vba.NotEnoughDSCUnits[i] = false;
>   		mode_lib->vba.NotEnoughDSCSlices[i] = false;
> -		TotalDSCUnitsRequired = 0;
> +		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
>   		mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = true;
>   		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   			if (mode_lib->vba.RequiresDSC[i][k] == true) {
> @@ -2454,33 +2412,31 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   					if (mode_lib->vba.HActive[k]
>   							> 4 * mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
>   						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
> -					TotalDSCUnitsRequired = TotalDSCUnitsRequired + 4;
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 4;
>   					if (mode_lib->vba.NumberOfDSCSlices[k] > 16)
>   						mode_lib->vba.NotEnoughDSCSlices[i] = true;
>   				} else if (mode_lib->vba.ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_2to1) {
>   					if (mode_lib->vba.HActive[k]
>   							> 2 * mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
>   						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
> -					TotalDSCUnitsRequired = TotalDSCUnitsRequired + 2;
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 2;
>   					if (mode_lib->vba.NumberOfDSCSlices[k] > 8)
>   						mode_lib->vba.NotEnoughDSCSlices[i] = true;
>   				} else {
>   					if (mode_lib->vba.HActive[k] > mode_lib->vba.MaximumPixelsPerLinePerDSCUnit)
>   						mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i] = false;
> -					TotalDSCUnitsRequired = TotalDSCUnitsRequired + 1;
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired + 1;
>   					if (mode_lib->vba.NumberOfDSCSlices[k] > 4)
>   						mode_lib->vba.NotEnoughDSCSlices[i] = true;
>   				}
>   			}
>   		}
> -		if (TotalDSCUnitsRequired > mode_lib->vba.NumberOfDSC)
> +		if (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired > mode_lib->vba.NumberOfDSC)
>   			mode_lib->vba.NotEnoughDSCUnits[i] = true;
>   	}
>   
>   	/*DSC Delay per state*/
>   	for (i = 0; i < v->soc.num_states; ++i) {
> -		unsigned int m;
> -
>   		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   			mode_lib->vba.DSCDelayPerState[i][k] = dml32_DSCDelayRequirement(
>   					mode_lib->vba.RequiresDSC[i][k], mode_lib->vba.ODMCombineEnablePerState[i][k],
> @@ -2576,8 +2532,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   					mode_lib->vba.DETBufferSizeCThisState,
>   					&mode_lib->vba.UnboundedRequestEnabledThisState,
>   					&mode_lib->vba.CompressedBufferSizeInkByteThisState,
> -					&dummy_integer[0], /* Long CompBufReservedSpaceKBytes */
> -					&dummy_boolean[0], /* bool CompBufReservedSpaceNeedAdjustment */
> +					&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0], /* Long CompBufReservedSpaceKBytes */
> +					&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean[0], /* bool CompBufReservedSpaceNeedAdjustment */
>   					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0],
>   					&mode_lib->vba.ViewportSizeSupport[i][j]);
>   
> @@ -2942,7 +2898,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   		}
>   	}
>   
> -	ReorderingBytes = mode_lib->vba.NumberOfChannels
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes = mode_lib->vba.NumberOfChannels
>   			* dml_max3(mode_lib->vba.UrgentOutOfOrderReturnPerChannelPixelDataOnly,
>   					mode_lib->vba.UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
>   					mode_lib->vba.UrgentOutOfOrderReturnPerChannelVMDataOnly);
> @@ -2998,20 +2954,20 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			&& (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame));
>   	}
>   
> -	FullFrameMALLPStateMethod = false;
> -	SubViewportMALLPStateMethod = false;
> -	PhantomPipeMALLPStateMethod = false;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod = false;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod = false;
> +	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod = false;
>   
>   	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame)
> -			FullFrameMALLPStateMethod = true;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod = true;
>   		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_sub_viewport)
> -			SubViewportMALLPStateMethod = true;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod = true;
>   		if (mode_lib->vba.UsesMALLForPStateChange[k] == dm_use_mall_pstate_change_phantom_pipe)
> -			PhantomPipeMALLPStateMethod = true;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod = true;
>   	}
> -	mode_lib->vba.InvalidCombinationOfMALLUseForPState = (SubViewportMALLPStateMethod
> -			!= PhantomPipeMALLPStateMethod) || (SubViewportMALLPStateMethod && FullFrameMALLPStateMethod);
> +	mode_lib->vba.InvalidCombinationOfMALLUseForPState = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod
> +			!= v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.PhantomPipeMALLPStateMethod) || (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SubViewportMALLPStateMethod && v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.FullFrameMALLPStateMethod);
>   
>   	if (mode_lib->vba.UseMinimumRequiredDCFCLK == true) {
>   		dml32_UseMinimumDCFCLK(
> @@ -3025,7 +2981,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   				mode_lib->vba.SREnterPlusExitTime,
>   				mode_lib->vba.ReturnBusWidth,
>   				mode_lib->vba.RoundTripPingLatencyCycles,
> -				ReorderingBytes,
> +				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes,
>   				mode_lib->vba.PixelChunkSizeInKByte,
>   				mode_lib->vba.MetaChunkSize,
>   				mode_lib->vba.GPUVMEnable,
> @@ -3088,7 +3044,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   					/ mode_lib->vba.ReturnBWPerState[i][j]
>   					> (mode_lib->vba.RoundTripPingLatencyCycles + 32)
>   							/ mode_lib->vba.DCFCLKState[i][j]
> -							+ ReorderingBytes / mode_lib->vba.ReturnBWPerState[i][j]) {
> +							+ v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes / mode_lib->vba.ReturnBWPerState[i][j]) {
>   				mode_lib->vba.ROBSupport[i][j] = true;
>   			} else {
>   				mode_lib->vba.ROBSupport[i][j] = false;
> @@ -3130,9 +3086,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   
>   	for (i = 0; i < (int) v->soc.num_states; ++i) {
>   		for (j = 0; j <= 1; ++j) {
> -			double VMDataOnlyReturnBWPerState;
> -			double HostVMInefficiencyFactor;
> -			unsigned int NextPrefetchModeState;
>   
>   			mode_lib->vba.TimeCalc = 24 / mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
>   
> @@ -3172,37 +3125,35 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   					mode_lib->vba.UrgentBurstFactorChroma,
>   					mode_lib->vba.UrgentBurstFactorCursor);
>   
> -			VMDataOnlyReturnBWPerState = dml32_get_return_bw_mbps_vm_only(&mode_lib->vba.soc, i,
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.VMDataOnlyReturnBWPerState = dml32_get_return_bw_mbps_vm_only(&mode_lib->vba.soc, i,
>   					mode_lib->vba.DCFCLKState[i][j], mode_lib->vba.FabricClockPerState[i],
>   					mode_lib->vba.DRAMSpeedPerState[i]);
> -			HostVMInefficiencyFactor = 1;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor = 1;
>   
>   			if (mode_lib->vba.GPUVMEnable && mode_lib->vba.HostVMEnable)
> -				HostVMInefficiencyFactor = mode_lib->vba.ReturnBWPerState[i][j]
> -						/ VMDataOnlyReturnBWPerState;
> +				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor = mode_lib->vba.ReturnBWPerState[i][j]
> +						/ v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.VMDataOnlyReturnBWPerState;
>   
>   			mode_lib->vba.ExtraLatency = dml32_CalculateExtraLatency(
> -					mode_lib->vba.RoundTripPingLatencyCycles, ReorderingBytes,
> +					mode_lib->vba.RoundTripPingLatencyCycles, v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.ReorderingBytes,
>   					mode_lib->vba.DCFCLKState[i][j], mode_lib->vba.TotalNumberOfActiveDPP[i][j],
>   					mode_lib->vba.PixelChunkSizeInKByte,
>   					mode_lib->vba.TotalNumberOfDCCActiveDPP[i][j], mode_lib->vba.MetaChunkSize,
>   					mode_lib->vba.ReturnBWPerState[i][j], mode_lib->vba.GPUVMEnable,
>   					mode_lib->vba.HostVMEnable, mode_lib->vba.NumberOfActiveSurfaces,
>   					mode_lib->vba.NoOfDPPThisState, mode_lib->vba.dpte_group_bytes,
> -					HostVMInefficiencyFactor, mode_lib->vba.HostVMMinPageSize,
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor, mode_lib->vba.HostVMMinPageSize,
>   					mode_lib->vba.HostVMMaxNonCachedPageTableLevels);
>   
> -			NextPrefetchModeState = mode_lib->vba.MinPrefetchMode;
> +			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState = mode_lib->vba.MinPrefetchMode;
>   
>   			mode_lib->vba.NextMaxVStartup = mode_lib->vba.MaxMaxVStartup[i][j];
>   
>   			do {
> -				mode_lib->vba.PrefetchModePerState[i][j] = NextPrefetchModeState;
> +				mode_lib->vba.PrefetchModePerState[i][j] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState;
>   				mode_lib->vba.MaxVStartup = mode_lib->vba.NextMaxVStartup;
>   
>   				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
> -					DmlPipe myPipe;
> -
>   					mode_lib->vba.TWait = dml32_CalculateTWait(
>   							mode_lib->vba.PrefetchModePerState[i][j],
>   							mode_lib->vba.UsesMALLForPStateChange[k],
> @@ -3212,34 +3163,34 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   							mode_lib->vba.FCLKChangeLatency, mode_lib->vba.UrgLatency[i],
>   							mode_lib->vba.SREnterPlusExitTime);
>   
> -					myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
> -					myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
> -					myPipe.PixelClock = mode_lib->vba.PixelClock[k];
> -					myPipe.DCFClkDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
> -					myPipe.DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
> -					myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
> -					myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
> -					myPipe.BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
> -					myPipe.BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
> -					myPipe.BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
> -					myPipe.BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
> -					myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
> -					myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
> -					myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
> -					myPipe.HTotal = mode_lib->vba.HTotal[k];
> -					myPipe.HActive = mode_lib->vba.HActive[k];
> -					myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
> -					myPipe.ODMMode = mode_lib->vba.ODMCombineEnablePerState[i][k];
> -					myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
> -					myPipe.BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
> -					myPipe.BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
> -					myPipe.ProgressiveToInterlaceUnitInOPP =
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCFClkDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HTotal = mode_lib->vba.HTotal[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HActive = mode_lib->vba.HActive[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ODMMode = mode_lib->vba.ODMCombineEnablePerState[i][k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ProgressiveToInterlaceUnitInOPP =
>   							mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
>   
>   					mode_lib->vba.NoTimeForPrefetch[i][j][k] =
>   						dml32_CalculatePrefetchSchedule(
> -							HostVMInefficiencyFactor,
> -							&myPipe,
> +							v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
> +							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe,
>   							mode_lib->vba.DSCDelayPerState[i][k],
>   							mode_lib->vba.DPPCLKDelaySubtotal +
>   								mode_lib->vba.DPPCLKDelayCNVCFormater,
> @@ -3298,7 +3249,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],         // double *Tdmdl_vm
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],         // double *Tdmdl
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[2],         // double *TSetup
> -							&dummy_integer[0],         							    // unsigned int   *VUpdateOffsetPix
> +							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0],         							    // unsigned int   *VUpdateOffsetPix
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[3],         // unsigned int   *VUpdateWidthPix
>   							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[4]);        // unsigned int   *VReadyOffsetPix
>   				}
> @@ -3427,7 +3378,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   					}
>   
>   					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
> -						dml32_CalculateFlipSchedule(HostVMInefficiencyFactor,
> +						dml32_CalculateFlipSchedule(v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
>   							mode_lib->vba.ExtraLatency,
>   							mode_lib->vba.UrgLatency[i],
>   							mode_lib->vba.GPUVMMaxPageTableLevels,
> @@ -3501,7 +3452,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   				if (mode_lib->vba.MaxVStartup <= __DML_VBA_MIN_VSTARTUP__
>   						|| mode_lib->vba.AnyLinesForVMOrRowTooLarge == false) {
>   					mode_lib->vba.NextMaxVStartup = mode_lib->vba.MaxMaxVStartup[i][j];
> -					NextPrefetchModeState = NextPrefetchModeState + 1;
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState + 1;
>   				} else {
>   					mode_lib->vba.NextMaxVStartup = mode_lib->vba.NextMaxVStartup - 1;
>   				}
> @@ -3515,7 +3466,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   							&& !mode_lib->vba.ImmediateFlipRequiredFinal)
>   							|| mode_lib->vba.ImmediateFlipSupportedForState[i][j] == true))
>   					|| (mode_lib->vba.NextMaxVStartup == mode_lib->vba.MaxMaxVStartup[i][j]
> -							&& NextPrefetchModeState > mode_lib->vba.MaxPrefetchMode)));
> +							&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState > mode_lib->vba.MaxPrefetchMode)));
>   
>   			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>   				mode_lib->vba.use_one_row_for_frame_this_state[k] =
> @@ -3591,7 +3542,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   						&mode_lib->vba.Watermark, // Store the values in vba
>   						&mode_lib->vba.DRAMClockChangeSupport[i][j],
>   						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single2[0], // double *MaxActiveDRAMClockChangeLatencySupported
> -						&dummy_integer[0], // Long SubViewportLinesNeededInMALL[]
> +						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer[0], // Long SubViewportLinesNeededInMALL[]
>   						&mode_lib->vba.FCLKChangeSupport[i][j],
>   						&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single2[1], // double *MinActiveFCLKChangeLatencySupported
>   						&mode_lib->vba.USRRetrainingSupport[i][j],
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 6e61b5382361..492aec634b68 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -196,6 +196,13 @@ struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCal
>   	unsigned int ReorderBytes;
>   	unsigned int VMDataOnlyReturnBW;
>   	double HostVMInefficiencyFactor;
> +	DmlPipe myPipe;
> +	SOCParametersList mmSOCParameters;
> +	double dummy_unit_vector[DC__NUM_DPP__MAX];
> +	double dummy_single[2];
> +	enum clock_change_support dummy_dramchange_support;
> +	enum dm_fclock_change_support dummy_fclkchange_support;
> +	bool dummy_USRRetrainingSupport;
>   };
>   
>   struct dml32_ModeSupportAndSystemConfigurationFull {
> @@ -211,6 +218,35 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
>   	double DSTXAfterScaler[DC__NUM_DPP__MAX];
>   	double MaxTotalVActiveRDBandwidth;
>   	bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
> +	enum odm_combine_mode dummy_odm_mode[DC__NUM_DPP__MAX];
> +	DmlPipe myPipe;
> +	unsigned int dummy_integer[4];
> +	unsigned int TotalNumberOfActiveOTG;
> +	unsigned int TotalNumberOfActiveHDMIFRL;
> +	unsigned int TotalNumberOfActiveDP2p0;
> +	unsigned int TotalNumberOfActiveDP2p0Outputs;
> +	unsigned int TotalDSCUnitsRequired;
> +	unsigned int ReorderingBytes;
> +	unsigned int TotalSlots;
> +	unsigned int NumberOfDPPDSC;
> +	unsigned int NumberOfDPPNoDSC;
> +	unsigned int NextPrefetchModeState;
> +	bool MPCCombineMethodAsNeededForPStateChangeAndVoltage;
> +	bool MPCCombineMethodAsPossible;
> +	bool FullFrameMALLPStateMethod;
> +	bool SubViewportMALLPStateMethod;
> +	bool PhantomPipeMALLPStateMethod;
> +	bool NoChroma;
> +	bool TotalAvailablePipesSupportNoDSC;
> +	bool TotalAvailablePipesSupportDSC;
> +	enum odm_combine_mode ODMModeNoDSC;
> +	enum odm_combine_mode ODMModeDSC;
> +	double RequiredDISPCLKPerSurfaceNoDSC;
> +	double RequiredDISPCLKPerSurfaceDSC;
> +	double BWOfNonCombinedSurfaceOfMaximumBandwidth;
> +	double VMDataOnlyReturnBWPerState;
> +	double HostVMInefficiencyFactor;
> +	bool dummy_boolean[2];
>   };
>   
>   struct dummy_vars {

