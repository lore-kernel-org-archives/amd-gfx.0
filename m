Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BC6CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 22:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0927910E04B;
	Tue, 19 May 2026 22:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yca8UDj7";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E8110E04B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 22:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUtrby8nDbmKPTbNWBu7r1IclVTXA+GSo1taAF5PrOSN3zSxFMVNjNdssqVSPSgQy2PvzV3NhcOc6z2H0Dn95VfHhd1HTcXZd8Le6wZdGjQC266CS/U9LtGeKZihyhVaXqBy/sUV614m1Zro9Les7SxrKZt3P/CmYSnS+Y1JWY+N4EX6kmKYly9SgGKVnxqTQ5SCnSXp5ql4vQ7vvgjRLh3ytdr7AaHCEEhGxwCvrZnrAIfeYPrL7WCQ8pHgB1FoS/JwKebxVp4YtFu1+eGwTLPkLsW7l3joyBnoHY+/Eu4ZaW9JEE0PTsCCQBnfykF96Mqf4LhM1MVkDckUyO++qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+86hJ30fC8dog5yQaxbsvE861hIycwWHISIQ3HhLC+U=;
 b=mUKtOQc8nbrc+cxv/nzp9K9dnLNEh/4UXAl/JUCVlQYImRlnxE6f6Dcu1CXFdr3Q9XUCPCfWmkpHexAWfJYs2YHiqFcuxH9IXmBZ9Y4128S6FLeuD/8NIHkokaVZ16S8PTItqRWAdz4Ccn8QxfGl045DheY1JgxTwzTG2tCXX7dkO0USR40rrx2XR87TF+9Bkp0+eeXpasIxjXaRMAEay0Fq6JVBKRrSUDC1+BRL+t5YH5euBjbZBIyJLLDedlEFcPE98zJ6Aahd4zdWHTydWjLM6xz7cPSpnR3bSVIgKl03m0vgwj7wq9sN7sCqGYI7YOpCAKC444BxYJo0o6BzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+86hJ30fC8dog5yQaxbsvE861hIycwWHISIQ3HhLC+U=;
 b=Yca8UDj7KFVTiTgczu3AyOa9VQNosnqXIAHj82f3xNoESxCiYC+HtF1n9OzWaSbH4cGOk7X1jU8wV4Qq5L7m87DCLDSA3I6DOeB3pYixeH5awDTOUWqs0er+NncrUp4X2MG/sb/YFFaDPOt5HB2MzjFUpiGSA2oq55u66pSTz9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 22:18:20 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Tue, 19 May 2026
 22:18:20 +0000
Message-ID: <67b8b972-5b1f-4de5-871d-a9b65c2e5279@amd.com>
Date: Tue, 19 May 2026 17:18:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Revert "drm/amd/display: Restore 5s vbl offdelay
 for NV3x+ DGPUs"
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, michel.daenzer@mailbox.org,
 alexander.deucher@amd.com
References: <20260519220529.202096-1-sunpeng.li@amd.com>
 <20260519220529.202096-2-sunpeng.li@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260519220529.202096-2-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:806:d3::35) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b7f803-89a8-45c0-ddd8-08deb5f488b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|4143699003|56012099003;
X-Microsoft-Antispam-Message-Info: TyocP1q5Lu5oaGK1wcd64wexqwtNQJp5fu7ioDWpDLrS4RcbMKQFANOHFg0zVSM36wza7YHlHgeqSv28bxnKT1vM8oTxM4fiMV2vRpqonCZd+0Va2RdWutPrDktrMrr2j8jDPyZM9DHkcBMG2sxuPXzXZSx79EuZSTZw+P1dyEHn+HGcpPowOVR/3XZstO0m45f9N++Lsxnex4GgZDJgnoLhTrduQFreGH3Qw1ddXTMVXtaZGV4Z18ZY3k8Oqb9RXsZRujXKFulc/9xUgqfox7w8aGV+aLFw6Wn9AsafL35i6DhSUTX7BkF6KQSrwylxaHJSCXl56chOrAC+YhQN040cYwjQmljbni3ul+FD6YACRVYNpydK31HVX+t06ggwuSsc9mw6vvTd9mKQewmP6YuUChyri5IfkKdry7IIT6T1NcLbIeTwoRsvCMgxL/WnU08W8jY8ZPXWc+oIvfr1hdfrIggxQ4SjSxNlxjFh7r38vtxnLeHUD/SCyHc1Uk42Z/4ZaOysxwE/n0UeDnbJ/7AfboByFEknqww6Dc83pO9qJDWJnrBL1MkU+yrPJnA9DI1HaucYULCE9wQFvceqtpInjAlk73W7Pq72XuxxRpDd9UaRcZa6ECdLOR8VKqM/fKLi1/ChVtrnj1oQ6MKJbFBkOxbrgWxR3tCXRzuedl9AhHlemlz6JILOlNZRYRjVagnuvqDuKXy4osO1qeBg9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB999147.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy8zbzhTakdCeWl2TU9HS3VtVzB3U0xVQTdQM3BKQ2ZUTWs2WWw4cFN3KzZ4?=
 =?utf-8?B?UHRiQ0FUOVUxMDRIWkRXR2FYRkVPTnBTcHZsanVEWWtGNG9NejJ6dWJrdjZM?=
 =?utf-8?B?OFQ3R245MDNXYW15Myt0eEFZQ1N6Y0lrVm1LUjhRVTBNZHV5N0ZZYjZUR2Rr?=
 =?utf-8?B?MVdTcndPR0tGam9kNUtCdk5kalZwK3k4UXRQVi9iTjNpMTB1eTFoSmpJVTQ4?=
 =?utf-8?B?aHNOYmVJMUxCeDBESDVzL3B0WTBjTGNXbmlRQjd3NU52ZVNWWmhnY1hJRlpB?=
 =?utf-8?B?M1hudnFneVBrOGVxQmN1YnhGZUhlYk1jYVZkQU9mTVR4aG84R05RMnhFbUNR?=
 =?utf-8?B?RXpZcmdMSk9GZGZDRjlULzZuNDFPUUJNMVVHRUUwQlNNSnBjTXBPdHBhazdt?=
 =?utf-8?B?SDRzUXp3aGkzT3VYbThBZzVrY013bjVJcG9ramZONDk0cXNnUEEwclNaVkMv?=
 =?utf-8?B?SW1DWXA5Rkk3U1BOWUh4b2pIRERNdVdUUms0MEQ5ZERYTWJHNzNuNDc5eDlt?=
 =?utf-8?B?UWpXcEJCbkhTRWp5SU5KS3hEUGdCL21jUnFiZ1NjU3lzb3dvWW02ejFacnRY?=
 =?utf-8?B?UU1qMjh1ZDFCWHQ4N1dPMFpjQk1ObXRWRFBOSkZBRU53aWdnQVk1OXhRYXFy?=
 =?utf-8?B?cElPTlJnWEwyTHN5eXNzTUhkMkRmcGZOYmtHVmM4MTd4K3JZamNpeGMvS21J?=
 =?utf-8?B?dFBmZDQ1MVIrcU9vZXVKdWcxYWxUN3EwV1h1QjYxZjdISnFickx2UUV1N3Q3?=
 =?utf-8?B?VGpqZC94YWlQQkJMNlg5VTFDeFhPWVo2ejhiSjkvWHNnVStNOUtIVWdsNFhi?=
 =?utf-8?B?MEVpSmNLcjFYNURodk1RUTFoWWlzRk85OHhVTm00Mm5qejM0TVZWM2FWTHYz?=
 =?utf-8?B?SFZtb3RPcmFHc3UyQSt1L24wSVE5Q2JWeWdkS1VkNEI5VXRSQmx6V2IrNS9O?=
 =?utf-8?B?bWNkN1IvNzMvVHQybTg3ZzRhUnpJMEJLVDd6dGltamJaakpaYXNnMW5VYVYw?=
 =?utf-8?B?TDE0YWRZcVZmMTVLeDYwTHJtZTZSc2tQUlF1WERpRlRlVVNuSVByczFPWWxN?=
 =?utf-8?B?dm5FRkhDcHM1WFJVRERqaVZLM1VLZFlvQmNRVThKRW1nRGJjK3Z6R3lvd2hS?=
 =?utf-8?B?dlZISnlvNFREcUlVejRLZFhxWldYaEppUUtPQ1BLUlJuNUV1TFV4TzRxU0pH?=
 =?utf-8?B?ayt0VjZudmtPYm5yanhYWHIxcjVHalpNdm9xMGdFZ3Zqc3h0L2dJS3IrUjEz?=
 =?utf-8?B?TU1pMGFTK1hCRXFIMkxIYWJScXc2bFVpd0FTbVhpU3RtZENYdnQ1VDAwWno2?=
 =?utf-8?B?cEdhTUJJVm15UUZWUUtCd05EcjBIR0tGY0Q2K21LSzRLVmRqV1N0eDZoQVo2?=
 =?utf-8?B?RFlJYUp1R1JpNlQ4WjZmUlVjY0R4djhGTXNEclpvVUZaY0x4azM2REZtU3hh?=
 =?utf-8?B?a3lDWnlaUThLcWU2T0Q1ck1JWmtJV1Zpc29iMUtiOGdFdm9oamNBa1RKQ0V4?=
 =?utf-8?B?NU93ZEZjUW1hOS93NmU0dkZtVlcrOTNNOGVscGgwYm9SSEU1WEtEZzdTNE5h?=
 =?utf-8?B?RmFWbk9Vem9yNHVzYVdOa0ZLS1cvTU1GZm5LL0NGcW9uNXNoeXpiZG9ScGtV?=
 =?utf-8?B?cytMdnROTXdIMk9vMjNZZDJXWCtJa0hqNjBsRDEvSWhhQlRMR2JGdDMrcnhw?=
 =?utf-8?B?anVlT0hpU1dNZWE2ZUpseGUrNUFqZGdmUXJSM2FEYXlHdTN4L1VSTnNKeXVr?=
 =?utf-8?B?MGFIeDJzVG1yNkl2Ly9iMTJuWmZxbHZOZWl1VmZpczRiOWJSYnhwQXhmaVBa?=
 =?utf-8?B?cit6V29ZbzNqa1FoS0JNZ2lBbXp4bHRxMHRHNGJxRmpJZkcvdjBtT1Q1UDlQ?=
 =?utf-8?B?cmtsTUF1ZWp6Qmc3SlIzdVUrSmI4WGdla3pvUFNoWlowV1NLaWs1TXRpSHFL?=
 =?utf-8?B?OGowaUc5bHRFODNrZEd5dUFDRnR3L3VqWVA2TGk4WU1DN0x4SWJhRDA1RkRw?=
 =?utf-8?B?aXgrOGNEZzFwVGoyRXRJTGRuS2F1N0M2eW5FdWs4NFZLTkZVYXVXWmt2dXJ0?=
 =?utf-8?B?VTFOVG1NYVhZMjloWFlGMDJXOHlQR2E2UEVlYVpvOEZYaDlrTU4rZUU5Rncz?=
 =?utf-8?B?Y1dVR0U4dUlBWW1pMkQ4UGdZNGcrZWFNUE84Mmg2bXUyLzFEaHYzdUNEUnZ1?=
 =?utf-8?B?Rm9pb3JVbVJSdkZWU3Q1MXVRdjZDaVEyS3lhdWl1SFpCbGVJaXpXdnZ0aVBL?=
 =?utf-8?B?eFFXTDZyRi9aUkVyZHVXd0VtQVpUdUZFR05KeXRZY3RNdG5BU1NkU1BuZGNr?=
 =?utf-8?B?T0dVZnpreUlqSG9TSEdTcDV2b1EzeEdSVWxtTmVDa1U1NlBwb2t2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b7f803-89a8-45c0-ddd8-08deb5f488b1
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:18:20.4947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+fWFhD3RhwyufP3F3bDT9kMdZX8KiNhVwTuxMshFRHv9hNBt3HCdVsBRVcIE2QU1j2+9NmKtpRmAtkjd+hFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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



On 5/19/26 17:04, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> Now that proper fixes have been found, let's revert this workaround.
> 
> This reverts commit 751414c12388ff2b475e15c15d3c817dcf563635.
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Unless it "actively" makese the problem worse - could this be the last 
patch in the series instead of the first?  This will make things cleaner 
when it comes to backporting.  IE backport the fixes, "then" revert the W/A.

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4670252ede244..be9c4e094d8ec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9518,21 +9518,9 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>   	if (acrtc_state) {
>   		timing = &acrtc_state->stream->timing;
>   
> -		if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
> -		      IP_VERSION(3, 2, 0) &&
> -		      !(adev->flags & AMD_IS_APU)) {
> -			/*
> -			 * DGPUs NV3x and newer that support idle optimizations
> -			 * experience intermittent flip-done timeouts on cursor
> -			 * updates. Restore 5s offdelay behavior for now.
> -			 *
> -			 * Discussion on the issue:
> -			 * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
> -			 */
> -			config.offdelay_ms = 5000;
> -			config.disable_immediate = false;
> -		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> -			     IP_VERSION(3, 5, 0)) {
> +		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> +			   IP_VERSION(3, 5, 0) ||
> +			   !(adev->flags & AMD_IS_APU)) {
>   			/*
>   			 * Older HW and DGPU have issues with instant off;
>   			 * use a 2 frame offdelay.

