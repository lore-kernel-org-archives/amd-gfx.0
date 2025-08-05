Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BB8C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 13:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C647B10E275;
	Tue,  5 Aug 2025 13:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dgKlQkrf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A877110E273
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 13:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7mn7q2jdBcXsTPa+Zd/l3QUkUpchUnAiMNnnUVUnuI1F491Sd+kRlIJSSqwTONO8H4/Gn+0Yfdc48g5ENWgqeaz7rRoKy8by4IGPB75imEvb5RsRyFjaUuzbdfto1bVt5VzyEE4/4OoLbFLOQFqJQOVqJfK2P8KWQloXC6nqo0ilJES/5Q12upVxWhYvHP1n5GMQ3o7wDpFDOZuvXQLQp1VyNwKodNkVjuIljirm/BaKcOqbmRMXq1kncF4eFOtgL3ZCWSaR/ScdSZAPf03WAgI+uxqWF2++wPRwXgW51bvUmzPXPDsUrB/tpVdEqgjDhF5UxZYkADDmzIrfUQPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKwRi90VqQJgzoB13Oyx3h3uJPJAq52La2uN9zf/TCo=;
 b=bvD2nicYRXb9jvBeyinxk0Ccl2lD1YqmbeDDUCm3lmMcaEgXW3KOoMj+/F2n0ix8MyAvw9qKrASS5wzpla+m2TV8Prc1+xJy7kAR7d85ZB9CG07z0ABkqALArOMYr7VzkEoHqd9BTJx2LMmKY9OokqE8tbLHbbUK0auX5/+UNwkCk7w/8j8SMn3viVRIqUtk6h+Ge050/bRWitJrvk+FzPmovI/f/O0ZbB32nP3inRZBdbHpG0xwTunjqACADVsOlPzpCnlHQhZ4X3mx8r1NDqkzvZKYmm0R94w9u3Kk2sSNa5B2xG6ouQjXU9A9cwokYEGQS0nFYHQHyvtv79mHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKwRi90VqQJgzoB13Oyx3h3uJPJAq52La2uN9zf/TCo=;
 b=dgKlQkrfzDYsZ0UGf73Wn0He9BrhvorV8ntsNFiCtN1+qn2ujfaXijAe8xQDsvH7Nu8tMohLrN8TaFID9LNegHFr4vtyivrzFwwafRs2xEFs3nJ7tKIAPqCs9IsgHmrfLNAbzlH7ICEcvIFgrSWKOuX2+4h/ZF8ALDZulDK8QUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 13:15:00 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 13:15:00 +0000
Message-ID: <60af8fbe-9ffb-a1ac-8e62-245f8086e744@amd.com>
Date: Tue, 5 Aug 2025 18:44:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: Fix double-free of vcn dump buffer
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com
References: <20250805122513.1769120-1-lijo.lazar@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250805122513.1769120-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::10) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: e01cafc0-1c6a-42ac-70ae-08ddd42214af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVg4VFlxNkdnOXpQb29PL3cyV0VIQ2txZ0hBRGRxZDlHOXVUZllQeHJyUXYx?=
 =?utf-8?B?dmRPc1oxb3pvNkFMNGl5OFFoSGpvSC8wWUJhYTVacXRaWS9DdTNHWDFockRi?=
 =?utf-8?B?N0R5d3MwWVFwZmlsZUQwMmhFS0ZRMUNLMi9Ydll2U2kwWFZRV01iMTg3VUJB?=
 =?utf-8?B?MlBKZC9OTFJSWkw2UWlZQWoyd2VZRCtTM0NRRDZaYzh0R1I4akdaWURTS2tU?=
 =?utf-8?B?LzJoMjkxWTluVzFkNWVzSGlGTjNlOVlVYUU3N0J3azBDR1VlREtxbWtwK3o5?=
 =?utf-8?B?ODBmcWs4c3ZRRkhIdGVsY3BlTmtRNEpYeXRQN29qbkhhbzV6UXdBM21xSStk?=
 =?utf-8?B?Qk80L2pWSnYwenAvRHBlUWZrVFRNbkJxWEZyNnlwYXpJN244WG5menVpblhU?=
 =?utf-8?B?Tm1JSnlCdnc5V2dWaUVjT1FWanVYSjhYaEQ4R2xDd1dhVkh2empQNDhnVmU3?=
 =?utf-8?B?dXdpMkE0eUlSaGVXRmo5a1JsY3ZFRFJNa2JCaXJhUjAxMHZOeW5YZWJFQnRU?=
 =?utf-8?B?TEI4QVQzMGl0Nzh3R042WEwyZzU2Qitzb1NMc2FqdHczWVl3RENyR2h5S2Nk?=
 =?utf-8?B?STNwNDIvbFlneUVQaENtQ1V4ZHdNOURCQ2VKaVRVMmFDMkZreFAwOUpLQ01S?=
 =?utf-8?B?Z0dFaW5mb01SYlJ4N0RYaldxYm8ySXF0WGpGc3ZHdVM2Q213dmZzUjh3blpy?=
 =?utf-8?B?MkxRbnhtRVBBdGhZUW5veERYd3dqYnE2WEdPYjFWdmw1Y3VXOXlTc1RicjNQ?=
 =?utf-8?B?WkFncDRqcUNXZGhuanNzaWc1SjYvdDlsQ2o2YVBXaGF3U3lDdk5xeVpLRHdT?=
 =?utf-8?B?UDVtT3lUSTZCMVZqRWlCR3ZWbmRlRm0rUHRWYng3VVVSUkRCSTdZWjlXTlh1?=
 =?utf-8?B?MVVyNVkvc0FwNDZLdFh4MEppNHd1ZDdKOU40L0dSa3FESUxKVDdnc3llOGhC?=
 =?utf-8?B?MGZNNVMzK05vbGJ0YVZHNHRDdkZvUis1Wm14OTVMMkVRM3RncjdHNUQ1M1JR?=
 =?utf-8?B?WkMvOHUvKzhXdTNId08rK2cxVVBoUUl0d1dNbzJJb0VhL20wVnVnTTZtMm8v?=
 =?utf-8?B?ZEZFbGtiY2xENVZ3UnJ1OUJwT21YTThBb2l2UFpWUExreGFHdmU0LzJKZnBv?=
 =?utf-8?B?Zkk3VzV6TkVkUGsvWjFpQWxDYUF4OXdLYnBDK005REhSdU5uYjZWUFdpcW8v?=
 =?utf-8?B?d0pHQlErd1I0NTUxNDB6T0dSWHJQN1Y1S2ptTDl6aUZEWmRmVmUvLzloS0Fm?=
 =?utf-8?B?MFBxbFFONnI0UW1UK01renA5Tis5VHNWMG1nS3N4REVmamd3cHJWblYrSHBq?=
 =?utf-8?B?alY0TkQzSms5Z3NDZWFUSWQwWTBXRm00WTczd2k1dmF2N3l1S2pUelpYdEZh?=
 =?utf-8?B?ZWJXTDA5QkkzRmFCNVpDQ3pXRWdid29GL2d0ejMwOFRBa0pLVjB0NXN1S3Nr?=
 =?utf-8?B?bWxXRU9UYSttbFh1Y21xekdhdnlBMzJhTlFOcVpsU1lNTkZGckNWQy9seWJ6?=
 =?utf-8?B?bWpHVVR1WmhNeFdrOS9JQ08rdWhrT2pOY25XQWhDTjc1WFIzaTNSdXVGRG10?=
 =?utf-8?B?OE9ReUkwelkrbk1SM3oxUDUyaUZXb0YyTXloTGZia3dPcGIzMURQNi9lUFFK?=
 =?utf-8?B?cUVySC82MkYrQzhtSjNrNW9kb1VyTDZtcnd1RlZ0aWpXeWtDblIrODJRdUVv?=
 =?utf-8?B?N254aW9DRnU3bGh6eUwrOGxOTVU0dE1NelNJb2dsdHdhQ0syQTZQbmtWMjc1?=
 =?utf-8?B?RDlTZkhqd0lRNmZJTDdDcXNodVF4Y0k4bUdkZ0pJYnNrQi8welN1UTNWK081?=
 =?utf-8?B?WHd1cWc3VjM1SmpZSkoyQnkrQitwbUFvL2hwNFUyam5EbUI1UmRvUktXSit2?=
 =?utf-8?B?ZjUxcGpTT3d2NGttV1ZyYjFBTmo2cHB1QlY3eTZTNkMrWXU1bUN4Sk80dHNj?=
 =?utf-8?Q?RZPcIOjxLDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBTQi9ySURRWlAzSXBWblY4Vi93WkdSR0pzSklPY01BcUpwNjRNdVdQRjdv?=
 =?utf-8?B?T1J4aStwallhNWR5SVprQ1RuQzBESkRjVXptcmRrN1RYZjdpQmx4K2NZelFT?=
 =?utf-8?B?VjNpdkt4TG0yUGNFOUZWczBiNVcxNS9zMnhDS3ZlV0VjR0RLeTRVdXFLbzFM?=
 =?utf-8?B?QkVuNnJIT2xMNXpGY2grMmNWQ0U0UVM1eDE0NXhBOHhuMnhlaWt3cjZkeEhm?=
 =?utf-8?B?ODF6b2xkbEkvbjVLQXRGbEozMHBkNjJQM1hpYkUraWR0WkxncnEwOTZxYmFF?=
 =?utf-8?B?bmtscWI0Y2hKYmZBSXJUL3NTUEJNZ05iam1QSGNUV0ZrclBKWmFNaXJYSzR5?=
 =?utf-8?B?azJEQmIxd3ZZMjIzdXdPUmZUQ1YvTXM3MWlFWlBPQ0F2N2NTS3VUM1RzWllF?=
 =?utf-8?B?QW50VmZMcWx2U1pmeHNPNWZJNkRWNldkb1lBSEhhQTFBQ2liVnorTHZXN3g3?=
 =?utf-8?B?YzNianE3NTVueXR6b3Z1MnVSQXovSXhEZlZ5Q01nVDhMYnlYZ3Nzekp1Slp5?=
 =?utf-8?B?b3pCNEdqUHFtSk1YRnJGcVJhaENiYjJtVkhuVEduUERnYzBvR3I0a2RtTks5?=
 =?utf-8?B?R1Z4UHBFbE1pMHltOGVUYWdBLzdRcW9sZU5zM3FnWUQ4QjViWFpaT01oU09E?=
 =?utf-8?B?UkdWeWdMSlQrUnM5REl6dFBUNE5Gc3BvSWM4M3JCTk84QzhYK1REbXJFU1pr?=
 =?utf-8?B?b3NLVnZBbkphclFZOGdDN0N3TC9lbVhBZDg4SGdEZGZ3ZHhBZnVuN01iajZN?=
 =?utf-8?B?eWZoa1JGU3had0d2R0NwSXlmYUdhQjBQamo3NU1LR01uTzZOZ01uZWVXTlRO?=
 =?utf-8?B?Z0VZblVKSGZpY0piSXlPbWpuSm9Ta2grMlpFakhRNmNZTmNTZnQ0ZFhJTk91?=
 =?utf-8?B?L1FYaWErNmREMVFleCtZNDFwYTI1bStOZStxcnJHWUNHWTE1WXo1aCtlNi9m?=
 =?utf-8?B?a3EvSFlDR3J1bERFMW9DOS9Za2dpVE1ETTZtUTNFTVJ5RWozdTJMNERrcndn?=
 =?utf-8?B?Uzk4SDBpZ01LRTk4OHZWTFFwNHlqc3NsRC9aV1JEN0RhZ0VjQlNjaWQ4TGN0?=
 =?utf-8?B?aWppOW44QVpLdEpXQ2pVVDhpaHdreHhaZWF6NmkvSFVsSUxkSXo4MWlFaTNi?=
 =?utf-8?B?UkRSMWdPVVVhZWVIUDlNdkllbEh6bGJtTnFJeHFxVG90VmFWVkFnQy9UMHpH?=
 =?utf-8?B?R28xVjBkVkZsK29RbFNzSWNBRjJlK3g3Q0p3bElpV0E5aENMS2s2dXZpNGZh?=
 =?utf-8?B?UExVVS9ySnFncUlyZXpuelUzazBIRDloWlVqSnlpOWVkU1prL3ZTOTZxeWxa?=
 =?utf-8?B?YkZxVk1qYnIzYllsR2ozcTYwN3IzbDljcjRLeGFsL1BIbkI4SUxYWm9ialBW?=
 =?utf-8?B?Rm1yeXdwOG5kelZ2VkJyUU0wTzJacTRzbU9kaU9majhwNlJkZ2lWbU53MjNu?=
 =?utf-8?B?TW5jZk85M2pEOVd0a1pLc29BRlV5QVpHLzY5ZjZFbXFZd2Y5amhveDRpcGRy?=
 =?utf-8?B?Zm52c21QQXMwUWZDOHlRbjh0TWhxM0JDZGwxN3QxSDROc21hRlVoTXJtWVUz?=
 =?utf-8?B?OHhON3JKYndhSkxOcFRQVlY0NWxVL3J5L1JLVHZiMElGbGNWeTFUREZobHBB?=
 =?utf-8?B?YWozUlg1dGl1Rm40dFVaUVFLSWFlbEN6Yms2dXhpbjNFTWUxODlaS05YSHpr?=
 =?utf-8?B?dTU2QjJzZ3JNMmRyeWlKeTlsYzVkNHhwRGZHWGFTY3FJNGh6c3oyamQvb1lH?=
 =?utf-8?B?cUdadjQ1cFpZU3craVpEemlxcHRpV1AxTHJOcG41b3NTVzVyZkxCYTJYZWN4?=
 =?utf-8?B?bUxIUzgra0xKLzlMTXZIdllRZUlsUFpxWHZoZ2NQZVdScUVtMW1zQ0x2cC9O?=
 =?utf-8?B?cFhEcjBxTWMycGJ5ODlPVW9jRFppOVdjTGs3TWQyS3Z0Ym9qOUkrQS9rQURp?=
 =?utf-8?B?bU40QXRnU2N3YkVuQ281NkZwcTByVjZnR0syTlNuRjdNQTdaQ1orNVdyb0VK?=
 =?utf-8?B?eWNyT29XdW1DT2dVYnZhaWN1VkZBcDdLbmxmZ215UVYvS1JTZWRhT25JT0d6?=
 =?utf-8?B?YXNFK2Q0NUtJVnE4T01YTmpXVS83TGJNUzc0bGhrUkY3NC9wOUswd0dQZ3Vz?=
 =?utf-8?Q?GZhhEs7Y2NteIMUAWuIP1PMtM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01cafc0-1c6a-42ac-70ae-08ddd42214af
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 13:14:59.9068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSY9ggXyg0K5vwKYBzy3EP32r3mPJ7kEBC9Iwh0k6+Nxa9fE0vYX7x7vXNVZHv2+yYRXyQKcJwbIXBXsy4p2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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


This patch is:
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>


On 8/5/2025 5:55 PM, Lijo Lazar wrote:
> The buffer is already freed as part of amdgpu_vcn_reg_dump_fini(). The
> issue is introduced by below patch series.
>
> Fixes: 699853ae00ca ("drm/amdgpu/vcn: Add regdump helper functions")
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 1 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 --
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 --
>   4 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index b497a6714138..050a5411aae5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1549,6 +1549,7 @@ int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
>   static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev)
>   {
>   	kfree(adev->vcn.ip_dump);
> +	adev->vcn.ip_dump = NULL;
>   	adev->vcn.reg_list = NULL;
>   	adev->vcn.reg_count = 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index ff2a85619f23..95173156f956 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -354,7 +354,6 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	kfree(adev->vcn.ip_dump);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index c6450ed65c12..019bd362edb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -280,8 +280,6 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	kfree(adev->vcn.ip_dump);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f785467370d9..75c884a8f556 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -275,8 +275,6 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	kfree(adev->vcn.ip_dump);
> -
>   	return 0;
>   }
>   
