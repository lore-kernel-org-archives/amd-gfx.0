Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89095C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 09:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C78C10E502;
	Mon, 14 Apr 2025 09:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ff/rbbz8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30C610E508
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 09:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjHdCpTXbHZEaSvEv+c1dHJtnoOa4wPDu3ZEsX00395iwpgXHnujzH6iARM05c/GSsbbLNOaOsEoSvS8W6T91gv2CGsj0wHThi43u8zgROwsdyjwulKPK1ekmoe1ICvxEVqXzH3UMROjSUlQYjKI2do+wMylCOSil2pY3RSDJdTEBPLb4x0IqJZYIM0DIMwmrFpfMaoX/CCyWJxhBDdZQZpGiLKZRWmnUbtf5d/5GFAcUWJLvcf6MghI0MAPrnGKa7tW+VJLxCIvP0pgEw9R5lBMUG4Jz3SZkoAZmRef6nu+WWcRJtzy8nbSvIArDSmlUwYW+Nij11LAz4vIWg2cWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DltZzubCxVzWmVoNfaPnyypUlCUAadTGakfmOYB/pY=;
 b=fCM2T60416h9Qvrv/yMygBiGPhwIb9/Z/yFHhyVQ3uuHj47B6mVSSEUNLkCWYVCqq2Sqxbns3kQ51Po3jLZWR07znkAedxpZGCNc6NL3AMgXLPtb5Ss+TDAf9V6EumdSCRg4QMrcWrY3QVrf83j5ND8e4vSnwcQ2GslaODVh43IzW7US8mvpajrnzyZJ/g3EFG3LPP07995GNpqiIr4C8AZdP0/lKQijnEoleMMUwhOaXvph5HGLTvZEfcdp1+Hzte3qUTWKG64wdUG3hKwgeFji6KhQfXryMiyC3nQeFtMyr2jpcLAybtx+9SiIOdhW65OqnGt0RaF903f61vk6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DltZzubCxVzWmVoNfaPnyypUlCUAadTGakfmOYB/pY=;
 b=Ff/rbbz8PirnKwqIrAT7KX/JzKh4ISfqjNQvjBeq/PwSRj4zTGRnAAaDO+atjQgSzMnw6mUZDn3QimUkOq5e59sdmcbYyRE5x3jl5bJJkaJjYaHGybRIcvIqRD5qG03HUAnEgf8sl8W5zEp2jF+Vh26MEAo6Fa8Gp+Rh1yyhnSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 09:42:48 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 09:42:48 +0000
Content-Type: multipart/alternative;
 boundary="------------4jUUCfEPdK5BEeRMh7zYwZi2"
Message-ID: <4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com>
Date: Mon, 14 Apr 2025 15:12:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: properly reference EOP interrupts
 for userqs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250413160608.2198429-1-alexander.deucher@amd.com>
X-ClientProxiedBy: PN4PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fb381f-d827-4927-5494-08dd7b38b763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVNSaGxPeXB2QzFZR0RoMHY1MGU5YmduOFZRcnJYM1ZjejVUQk1lL3BDa3Vp?=
 =?utf-8?B?RExCQ1QwNmpQUjBoVERhN3U0QU53QklIZmYrTW5tMmx0dDVKOElqbkhMNVVp?=
 =?utf-8?B?cXEzS01QRE1QcW9nSGV5ZHJUYkxwNGwyYjltb1JaelgrZTdvNUMvWE9JYXcy?=
 =?utf-8?B?MmVIL2VMRE5MY2UyTHVVMHpxL3NhOTYzSlFoS0RVeFUrQTF2ejhiZDlrOTds?=
 =?utf-8?B?SldOTzNaYWNGTVhXNG1VRzZMKzZwck1PdHNvQ1dGM3Z5Z0N3NGxuNDNlcXE4?=
 =?utf-8?B?TVN6dC80cnlnaXlYbnp6cHc4ZGpkYktKSXBNRWxpc2FWMWsxczhNWEVZSjJQ?=
 =?utf-8?B?Y2ZSMnRoVHBiMGNEemdBWFJBelJWaGR4eUR1Y3JzTXNCS1A4YVczQ21CVWxq?=
 =?utf-8?B?K2YrdllTQ1RidFQwVjFHRFFlb0tnQU01VDQxRUxlTUcrMUhlRmkrd1ptY3JD?=
 =?utf-8?B?Z2FrWkZTM2RZaDh5TjRJdytzeUJuRmtIeFl5VkVQb1ZkcEtIUVM4QmFGMWY3?=
 =?utf-8?B?UVhrS01IaTB2VEdmTHZhcE42ZHRnemxtUUFpVEQwOHlmUzB5ZDJEQUdqUVk3?=
 =?utf-8?B?a3k5VkQ4QS9oTVU0QUVMckVFQTk3WFd5Z2tGR3g0bW1rQTJrUTFkWkZRa2tE?=
 =?utf-8?B?OExiT3hNSWpCd1JvTlFDSCtHb3JoblgvWVpMV2VWT0ZFU21rMGxNTDdqSXVH?=
 =?utf-8?B?L3puYUM5YURjc2pVMXRlNmZtQU1zcktJYUxyUTVqZHpmL3RnaFBjSG1YTElU?=
 =?utf-8?B?WDZkMmw0UTJJS1Z0KzM1ZjNJeFdmQVZKb3dhRHMxSk1sUjI1cVowTGJiQTEv?=
 =?utf-8?B?RjF4b0N1ZUxIYVp1aEh3dU8xV3lOK1QyTEI0UEhyb3VaMURlak5lMnBjRE50?=
 =?utf-8?B?UHA2SFo0RXVmOWQwc21Qd1hvKzJSbzZnNW1UeElHdkJUbTdvWnM1bFpOa1hq?=
 =?utf-8?B?M1l2NjkxU2tzUDRwaDllV2RIOStIVE5hNFZFZGgwamt0dngwbWlxdndmbVIz?=
 =?utf-8?B?NktKVDdyK1RNT1luZGRVcXZoR1ppcnJTNkV0ZW9KSjY3dUFSSitoVGFXM2JM?=
 =?utf-8?B?WmwyUXVhakplckhXQUQ1WkdVdzYvV0t4OEZTT1JmZmtjb2lmRXpKaEd5TU9R?=
 =?utf-8?B?SnI0NjZ2TGQ5eWRySWVNSmJOWDRycmhaWU5mYStjUFc5R2gwbnlvamNxMFBW?=
 =?utf-8?B?dUtNbFplR2xSSEg4R0svNEE2SktWdTZRS1RqNllxMlZ1Nlo0dGVGdnZBOC9a?=
 =?utf-8?B?Q2VYUlREamZDZCtVNUY5MGtqRjlMdkZXQmlXeVVqRGhuMmFLalkyU0JrVDRD?=
 =?utf-8?B?VzFkSDQ1eEZDSmRUQXBncmR1d0lBUDFJMjg3eTlBOFdMZ1hDTHlweUx3Y21N?=
 =?utf-8?B?T0ttRGUzYi9uYlp1UXkxVnM4cHBHZERScU95c0tMeXMyU2htQlRGNUlZWFZ3?=
 =?utf-8?B?eDZRaFllYUQ3dGh0MHVNR1FFbXFpL2JPTyt1VXB3UnJXT2EzVkF2eGhOQzV4?=
 =?utf-8?B?d3d4U1RJTlpkWXovaUVZczlsL3FQYzRKMW1OT2lwdWxTQnFTS3k4R1dsQWJ5?=
 =?utf-8?B?VnIwNS9qTjNiMDRrWnBQSEN6ZVAyMVBUcU1iWFZTMklwd2F3VktHQ0N1aFZp?=
 =?utf-8?B?RHIrNldxZ1hJb0I3c01zaXNzWVdNR2I5TTlrSml0bk1OZUxHd3l2Y2w2dVIv?=
 =?utf-8?B?TFFlVEFVYTd1YWZSN0NDYUZ4cjgyMDd3OFgwdnRpY3VNWHovS0xKOXZla2pM?=
 =?utf-8?B?NHlhcFVzOUtIR3ZBbWlhcHFzUXFTc0xzL3Y5endVNWU3WXpHcWF3amxBbG5i?=
 =?utf-8?B?cGJCTEtwMGx0UGZQTjFFOUQxT2dLVlN1cUpvV29NeFc5dTZ3bXRCZG9zQlEv?=
 =?utf-8?B?ZTg0bDlKZHRHU1hidVZlWDBFbnFuRGhmbk4xMlRqaHZrUEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2l0eWJxdmRsSVdueWpDeGhwOGVFVVorMWNBeVl5T3p6UnhhRGFLZzRKZk5Z?=
 =?utf-8?B?b0YzVGJhSUpUQ2tXNDcycHJQMStnQlZWanFNM0Q2ZU9KWlZRWFZ3WU9weVgx?=
 =?utf-8?B?Z2U4K0JGVmJzVU0zd3Jaejhyc3N3WWJ4YTI0Smo0Ym5yY3FOTWs2T2MyalBQ?=
 =?utf-8?B?YzdZVHNKSWJIQXBLM256bTNBMXdyaTdZRXBoZXFWSVFHQitHaWgzTi9id0VB?=
 =?utf-8?B?aE5DYlpLWDc3eC84K1pRZXRmRmw1UTdtbDJhYWdENW9CWEpCVW0yMzFCS0w5?=
 =?utf-8?B?a01aV1RLTmF1c2VmaWZUTlF6ZFNWcUJmb2RuOFY5UUx5KzdCcS9hMFBaQlZI?=
 =?utf-8?B?b002VDhzcVBxemYwS3dsUC9qTVhQRlFEaGtUU3dpVlc2MkE2Y1lMMUhQTlFm?=
 =?utf-8?B?OWlEaFdnVmtyNTlEVERHaHNrZkNtalNJRS9lWGxMT0EwZUpkaUw3REQ3WTlW?=
 =?utf-8?B?S2xuNlk3bUxRaHA4T1pac1FuY3VOVEVnQWl1WS9ITDVnNVpQVmwyeFBkZGIy?=
 =?utf-8?B?UitWTDN5M04zN1BBMXQ1N3RkZGxOK0ZrbUxKeDZ6N3BRSURYMEJrTWtmaytu?=
 =?utf-8?B?dkcvaUo2b1QrK2pZV3ZQeUJhZkExT3BCa3N2Uy9BQmdqUCszVGt1Tit6cDdL?=
 =?utf-8?B?R2Q4bkFVMWt6WGx5ZGRPNll3bDM3dnJZRjJHaWxJNnR4UWV1aFNGU2dCMTRz?=
 =?utf-8?B?akpMR2x3NW1INTZGR3RVYk50bnRjZ1lOa2hIMnpqc3Z2U2dBVld0eEIvdW1V?=
 =?utf-8?B?eFF4R3RYZ2VKdUVHRFlHN3FJV0V6aTgxNnVwUTB2QnY3SzlaRm8zd3VFR2Yy?=
 =?utf-8?B?UytJQzBVT3AvOHJnQjk3dEk5Z0VPL0VWUzlYSEpVc3hTQkZ4OGI5ZXlrTUdS?=
 =?utf-8?B?WHlsY29OUTZJVVZSODZnV0N1VEZ0WUU5ZUtZU3J3SVorRStmZU42a2dkc2JV?=
 =?utf-8?B?QTBMaXI2UWxzTUZMU2NXZzBMUmJPcDlRTVFIclljNFNtNEZteWdrT3lTZmYx?=
 =?utf-8?B?ME0yRGovc3NsaCthdHF5UFl5QVJnMUorMmZBdHE4MlJtVlJKZTFvL1ZKaXJv?=
 =?utf-8?B?ZTJJSHJYa1BMUGw0bTdlMWdSemx0clA1ZHRNYmtBQi9IREV1VDIwRGdEbGZx?=
 =?utf-8?B?M3ByNVVXV0JtUU10T1RnK0wrVmYyeUFUbWtBQVpzaXlrOEhPNTRvMS9GbzVt?=
 =?utf-8?B?U1p2eHdQdUVKakRWU2xaTWlkZVQ2TzVxNlFacTVDWC9jMlRQbDhPa3pvMW9B?=
 =?utf-8?B?QnNnWGN2SVNEUDVvTEcxNFZKUjR1clNrWVlXVnJZY3M2UzN5dmNTY2N2MlVW?=
 =?utf-8?B?NFFUMTVsaUhTdjZMMHVTUXBPa2x3WUFHYmpBMGZrcXI0eDZKaWFkdEJsUXRJ?=
 =?utf-8?B?VFpKL2hwU1NSUFVLNW4wcUh6ZWplYVMxSEtxZ05zSGxQR05reFlTODYwakpU?=
 =?utf-8?B?aXRsMTM2bmRvZDBKa3pSc2tRQVZlKzBUOUE3TEV2U2pzcG45dFVkZm1qQjRx?=
 =?utf-8?B?ZlBlTVlsWlNmYmZhaUk5eDFHV2NwQ2lXTEVMT0JEWXAyekdkWS9IRTFGWDBa?=
 =?utf-8?B?TkNEeGhlWmNDak5SMzNJMGdPQzk5b09YanNYVVlxMUgxZEc1ZlFDV1hMK1h2?=
 =?utf-8?B?N0JzREg3SW96NDFYdTF0bDk0VDdhRkcvZ3BGOHk5bUxZb0orMVh3WWJyYlpM?=
 =?utf-8?B?RTFPSjR6djNIYTBpTm9jSFdiOGJvdDFEd0NGdXlScCthZDRUcHNUKzlmNTZQ?=
 =?utf-8?B?KzVmU0RGck00cEsyamVPbjJBV3loaElwcGpGRmovQXh2eFduWHc0QkJtOTVW?=
 =?utf-8?B?Ym45YzFBRnN0aXJwRTJ1YTc1VTk3ejVISDVLMEpYc2xxWlAza3lDNEExb0Q4?=
 =?utf-8?B?RmNSdTR2a3BRNVp2bmdLS09RL0lPT2tiUjhoSVpwUjBjM244Nm9QVlpLUDRP?=
 =?utf-8?B?Y3FnaWxIMHVHYU5udS9qazNrejhNUDh1NE44UHhocmd4QXl4TlZoVVlGY3Jh?=
 =?utf-8?B?TnZ0azlCQ0NWdXZlT0gvSjZybkZYUktieURQeTVxS05iN1RnaW9ZcEFXdzBH?=
 =?utf-8?B?MlhKVUovbnM2WDVXY0NkNVBnSmEwc2xwMXlEb3I4ZHdrYkxxWUsrOXMwSzJE?=
 =?utf-8?Q?qXFC2raVHW2iTNx8f/a1fjhes?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fb381f-d827-4927-5494-08dd7b38b763
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:42:48.4370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uIgLI3+iKWMVBqdzK3JxgHT860eXCylbuvWCmIuVCryPi2FKZZJKJlvuL5nwQTRHpMDpsuNQEY+bI//WEPHdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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

--------------4jUUCfEPdK5BEeRMh7zYwZi2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is how i see the future of this code and we can do based on it now 
itself.
disable_kq = 0, Use kernel queues.
disable_kq = 1, Use User queues.

In case of kernel queues we should not be even calling 
gfx_v11_0_set_userq_eop_interrupts at all. Instead its better if we add 
a this check "if (adev->userq_funcs[AMDGPU_HW_IP_GFX])" before calling 
the gfx_v11_0_set_userq_eop_interrupts. I am assuming there wont be any 
mixed use of kernel|user queues together. Let me know if you think 
otherwise. Regards Sunil Khatri

On 4/13/2025 9:36 PM, Alex Deucher wrote:
> Regardless of whether we disable kernel queues, we need
> to take an extra reference to the pipe interrupts for
> user queues to make sure they stay enabled in case we
> disable them for kernel queues.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7274334ecd6fa..40d3c05326c02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>   					      bool enable)
>   {
> -	if (adev->gfx.disable_kq) {
> -		unsigned int irq_type;
> -		int m, p, r;
> +	unsigned int irq_type;
> +	int m, p, r;
>   
> +	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
>   		for (m = 0; m < adev->gfx.me.num_me; m++) {
>   			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
>   				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> @@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>   					return r;
>   			}
>   		}
> +	}
>   
> +	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
>   		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
>   			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
>   				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> @@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>   			}
>   		}
>   	}
> +
>   	return 0;
>   }
>   
--------------4jUUCfEPdK5BEeRMh7zYwZi2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>This is how i see the future of this code and we can do based on
      it now itself.<br>
      disable_kq = 0, Use kernel queues.<br>
      disable_kq = 1, Use User queues.<br>
      <br>
      In case of kernel queues we should not be even calling <span style="white-space: pre-wrap">gfx_v11_0_set_userq_eop_interrupts at all. Instead its better if we add a this check &quot;if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX])&quot; before calling the </span><span style="white-space: pre-wrap">gfx_v11_0_set_userq_eop_interrupts.

I am assuming there wont be any mixed use of kernel|user queues together. Let me know if you think otherwise.

Regards
Sunil Khatri 
</span></p>
    <div class="moz-cite-prefix">On 4/13/2025 9:36 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250413160608.2198429-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Regardless of whether we disable kernel queues, we need
to take an extra reference to the pipe interrupts for
user queues to make sure they stay enabled in case we
disable them for kernel queues.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7274334ecd6fa..40d3c05326c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 					      bool enable)
 {
-	if (adev-&gt;gfx.disable_kq) {
-		unsigned int irq_type;
-		int m, p, r;
+	unsigned int irq_type;
+	int m, p, r;
 
+	if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX]) {
 		for (m = 0; m &lt; adev-&gt;gfx.me.num_me; m++) {
 			for (p = 0; p &lt; adev-&gt;gfx.me.num_pipe_per_me; p++) {
 				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
@@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 					return r;
 			}
 		}
+	}
 
+	if (adev-&gt;userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
 		for (m = 0; m &lt; adev-&gt;gfx.mec.num_mec; ++m) {
 			for (p = 0; p &lt; adev-&gt;gfx.mec.num_pipe_per_mec; p++) {
 				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 			}
 		}
 	}
+
 	return 0;
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------4jUUCfEPdK5BEeRMh7zYwZi2--
