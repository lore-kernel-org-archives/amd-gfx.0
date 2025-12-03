Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04C1D1BDC2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 17:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB8310E806;
	Wed,  3 Dec 2025 17:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDUycY9l";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E307310E194
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 17:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLNlrFXTRaelgb5B1fqLSU8yJOSysGJqAIssKwc9mYFjT9e/FPVuPETEUZQ/BJ2kN1bvkI95QQkZoQ3QH1FoznF+kp1IDZ6eEmXnFtkGgjnyyj6F3og38QusHHAonSuow3W8RsU0GtJpvakBxHIbrR/kIzJar9ICQ3Bt+rFqJDyjV+/D7JNRkYkWGZChxJYyOIdakrSp7mI1GzS0lUntfUKq2DLrMpaQyVLilD1ZRZM7t4+ss5dyag2Y3rXKb8SpwrL1RHYoHnjRZN/Bso5xwuNoaRBRhC66rIpeg6pN/+DA75yPHvncsunnejyNWcEEF+ggEEqByoWLPDJrXf4Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StWIS/o8s9sFPAUc2qi5225il9ypPyt7bYNZqbtm+ns=;
 b=yFnLEVkuuowwOXtQ6+QKhOKkGxfbcJGf+H8z+iKFDxj5Z88APgrFbVVY4HyQdSz1cSlIO1/1ibQOm2ifDJPagxcFWETiZDcSrfRN8TMMuu30yqrQouvmM98EWMyKVP7X0fpxym226JUrXpDGOtAsxEIVXKQyCVJSW9nDUFJaO47GvBT2AXfybAzjFTxds4arOfeTc3lIo8+SOJ9E+cAA3I2xlRx8M8/5qL1YbL6+LxFBdLI9MyrU4w8AMdXADCYHlYOL3BEB2ewdmoPkw7Ta3TFd5J2it2kt3AA7EGfV4pdVYL0uOFzBkmYNdMmZlVuOnT/SRRYjwKWBs6l+UhJMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StWIS/o8s9sFPAUc2qi5225il9ypPyt7bYNZqbtm+ns=;
 b=UDUycY9l+QTQcli/04xViWKAU7DKdrOA7me/tVlyELP0iun6XjtLPrahlVHnMSyt2Diyk+MSrv7WCZuQg+DYzNz0hTOtu3OmmrXv0C0QHqXmlw97owuh2Wqn3Eu3bQP7xNlp/SH6sayO2cxLbQUZpp9qWhg0caRaF9xELnxJcnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 17:55:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 17:55:30 +0000
Message-ID: <98c9d511-e590-4a70-9b41-d42196b812bb@amd.com>
Date: Wed, 3 Dec 2025 12:55:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Move gfx9 MQD to VRAM domain
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-4-Philip.Yang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251201142838.1516452-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 156e0f9f-87cd-42f8-5771-08de32952625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFhoT3l5WlQxQmhqb2g3N3BIM3h4b1RJaXRPZ3Z0SEpNV1p6RTFQM3BhdG9p?=
 =?utf-8?B?NWZabUxGSWVxL0lCUWdHa2l3MSswem92bTUyTjNJZzhUK0dkV29hZDBmSFdp?=
 =?utf-8?B?dW1HV1RwUE0xQmQrVmJ0aXo3SUFERGptTytYOWJoQitKMmgzYU9lS3Nnem1h?=
 =?utf-8?B?SGk4a2VHdWFvWWM2dWVnYjRYWStQbHBydldWY2l1L3dNdGpTYXVWRXNvbmNJ?=
 =?utf-8?B?emd0YTA3eXpTZ29HTTNNcnlPYjk0bjdCamMrYVFmVFhDUG5VQkdhSTlwdG9t?=
 =?utf-8?B?MkJyUlJGSTNNY3k3UGk0NkRSR3k1RGorQURKSlZpTGIxcitVZGNSbXN2WVd3?=
 =?utf-8?B?SnZnZ2hpWisvS0JnWGpsbnhFSnJEcE9oWTFlQ085TC85SGxiTm9JRWEwSU5O?=
 =?utf-8?B?emZHUFBiV2FDdFJtQTBBRDFMMEtmTEtDYjZUMkZUSGlUWXlEZFNJSmdITnlx?=
 =?utf-8?B?NVczMUxheHUxUC9BczVDeTBBaTI4MXdYci8vVE43KzV6UThjWWVpVmdsYklI?=
 =?utf-8?B?SUVBVnhCUk1xQnd3TXNiWDgwdW12Tjh2MTdmOTgwZ21WUnVpN1ZybjZzOHRk?=
 =?utf-8?B?QjdpTUcyZXpPWGMvdmIxdVRIVU1mSWQ5cHdwL2JPNmQrQW1JVkw3bDFJaFBo?=
 =?utf-8?B?NG8vSy85M0lWMHEya3JvRUpTZDVuNFJTemUrS2NoQVNhek51YmhPY2JMc1BM?=
 =?utf-8?B?TGZydnVoSERqNW5JdnRkSlgyRTlqSTdmaVJhNVdmdmxhTzZaNUR4Y1BjN3M5?=
 =?utf-8?B?RDdJRmVZWHpsMnZwT0JjanEwQ0VkNXdsTGc5QmZ2cEYwalpEelc0Nndnc2Uw?=
 =?utf-8?B?Q1d4VXNqc2lEcklqUW1VMVIxZllXekpLT0t1allsTTkzSXpsZWZRaUdxOUdO?=
 =?utf-8?B?NGdpUWdqTGVtcFJBem1tbnJmS3JpRjhvQjdnaThWWlJ4anNRcU16ek5SeVJu?=
 =?utf-8?B?QUZyK1FXU3Y0S2x1dFd0Y203bDgwYndhSzFxYnNnOTRFNDNtVjRuM3hvQWVh?=
 =?utf-8?B?YXl3QmpWSTBSNElaUnVzV1pDYS9iQ3dCWFc4Z3FyNDZYanZxUkg1YUt5UC9E?=
 =?utf-8?B?emRMcFN5Sk5Jemw5bkZjUmRwOTF1WUZTQlpPNUlDSDlDSmlDNFNraG5CSEFB?=
 =?utf-8?B?SDBZcU0rMkFDYTdKL3ZuZWFZQ1RLOHIwQ2pLcEhwajh0VU1wbFo3TmI0Ky9m?=
 =?utf-8?B?RmdDc1VxL3RPSEpROC80eDExaDJoN0N6UXMxaXBzcVlzOFFXOEk2M25xWUds?=
 =?utf-8?B?QlAyc0twb0EvcloxdC8rOEVvOGU2QStIZko5TzJURC9nYjZUaW5KL1QydEhR?=
 =?utf-8?B?bnhXU1A4bG56UTJEWGNxeWlqclg4SkErUGZubUVyaThiN0QzTFlWdVRucmhj?=
 =?utf-8?B?dDZZY2tQK1lMSjhEWENjVkJ4dFZ3dGpvcldFZHpMMUFIclVRdHRGc1gxWHhZ?=
 =?utf-8?B?NTd5K0FnTlFmVnRvR1JOS25lSDdyZG5tNmxyYm55S3JYcXpQd3p3TGhaeDh2?=
 =?utf-8?B?Rzd3anYwcGlmNGhBVU1kSkhyK3pMdGlFTkhWdU9rQkVTbWpZRFRWMklCOFNR?=
 =?utf-8?B?NUtZbWFwS3pxL0hybFBNWjlRTGR0bUdCcFVyY3Y4S1oyVmpzb1lyWWRUbnQ2?=
 =?utf-8?B?cHlkMzFQYVVTUE4zN0dtUDdXaHBSVklJNmgzOTd5aGx0YXdIc2c3Q0VqWkNJ?=
 =?utf-8?B?ZW1lOUFiRWtxM2RQVUM1eDV3Y3VOY2luZFQvbVpLZG1tVGJuWlNJUjd3Rnkr?=
 =?utf-8?B?cDlCQ2FYWGhYeGgxWGhodUlySVNEQkFqMnNOTVVSOWI4aVR1WlhhNDM2VGZL?=
 =?utf-8?B?THl3NjYvaDFFdzdGalgzeS91NjlhUlI3R2kzcnRBcnpzOUpLL1NKSmIrZnc2?=
 =?utf-8?B?YlVxR0kxTms0YllyNW5WeEo0SStTZjRhNkNCQ29wYzJFb2szcEtvemJURTFG?=
 =?utf-8?Q?L0q89HRxRtJQ5uGrmAwznsQuxlCWOm3+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGwvZHRMdGNZTndDUUUwVGprc0RnWEVtNjVNSS9JR2xGUGFLb1pBU3BKTkF1?=
 =?utf-8?B?RVlNRW9yQ3MvOEFhQ01qdmlSQ1NMUFJWVEVlQk5OZUlpckNYa3oxQWkxdTIw?=
 =?utf-8?B?RTYrZmRwblZVYlJUeWY0UW1BZzNiUSswSTNDTHljY0JuVkhCT0hLWDhwNUFK?=
 =?utf-8?B?T1FKZXdISHBXUktxVktybzRwRGpBaUVzODgxVHFGcWxXL2oxMXRZeE9BbWJJ?=
 =?utf-8?B?QlhTRmJmaHg3OHpiTVRVVUhaMmkvMytVbDFad05SUkFGamRUQmROTWZ3eHJK?=
 =?utf-8?B?dmNRclRTWEVzaWNHY004RktZa0puZnRBNzBqRU1JRmlZcldHZUdKbzBqVTN0?=
 =?utf-8?B?YzBzU25UZ1hVNGg2Q1R6aXhBV2lOdFpkUkJ0THgweFY0cFRlWjc5M1lRWm9Y?=
 =?utf-8?B?SUN0V29TZklsUXhQWlUrQ096RXArVmpoZ2kwY3gxMEhWaFdJeUptU3YxZ2pP?=
 =?utf-8?B?OUQrTlVEZk5Ha3ROWWVrQlpqZ0ovQUt1emVlS0pEUzBSeWFhUGxpN3c4RTBn?=
 =?utf-8?B?eGNTZ0liNGJqczJvTG5jSWFYVVgxenNwZmUyQjhwMlVGcGY3SWs3K0JFY205?=
 =?utf-8?B?WGZDV3lndjlJMXZwUDFQTnh3NjQxZk9TYkEzZ2J2eXZuL1ZCL2pDQkQzcVA4?=
 =?utf-8?B?aXFTY1JMMS9JRTlmS0RnTHBDeldBbFNZZzljQ1l6cUJ2NW0zb2FKTy9rQi95?=
 =?utf-8?B?bjZkS3pMWjlJUkNldXFWL2NMVFM4NS9DS0k3OUQ3TVNlZTNOL3dRcHZpOFFm?=
 =?utf-8?B?TzlxVHQ5SUxKN2ZyQnhucjlleTdHZW9VNDhOV21Nb1U2Uko4M2lKMmJ1bmFJ?=
 =?utf-8?B?Y2crcGQySEdVSHYvdkxYRENVb0QwUXpGcGs1ZHpvSWpmVmsydllqRmx3d2tL?=
 =?utf-8?B?b0pKbDlScUJmNWhFL3BrNmNWYnVxVjFFRFpORXFLczZSWUdybTJMSkZDZ0lQ?=
 =?utf-8?B?emxicHJLOUdIbGMxaEZrMDV6MDIraUkxV2E5aEZ5TnRYekFaOTlJUjZHMFpT?=
 =?utf-8?B?TWFrNUN2Z2lyUTdRL1VBM0J2TGdYRmlrMENuV1owVVVlK1N1YjJpSzVKQzdu?=
 =?utf-8?B?RkZnaXEzblk0Tmdyb0FtUTZXRG12R2djRjVFdFNHNHFydVhJcS84eUlzamhk?=
 =?utf-8?B?NmNVemNiZ09EUGUydzNHeE83NGlCc3BvQVpNSlBhRUJDMlVBNk1Qb0tDQUxR?=
 =?utf-8?B?cnBuRHBpL2ptNitTSzN0eG5mVklBT29xb29kRXl5LzlHQ0hldWhBU3FQQlFH?=
 =?utf-8?B?TkFRREFVeElrYlU1bUF3YVJnN2VBVDNtdW8rODJMbW9laHJLL01oSWwrUkVP?=
 =?utf-8?B?R0tERHpERWhxZk1GTHZ3VERhdkJZWDUra1piY3AyWmxRNXZtcTNzZTlOUDkx?=
 =?utf-8?B?WllKNzdWdG1WMEo2L2wzSUFnelJnKzVLWGV1VXVEYlJMUXBLNVN3Tk5UTzlU?=
 =?utf-8?B?ODBLVzg1dDdiejE5NHBISzJvellwVXFEVm1US1VmendsOEdySUtaMTFnc1Jm?=
 =?utf-8?B?MjVjNUpLM05mT2ZwQWFJdW9QNDVvRmtKVktRU2VhTFZGSEhkVGxpTEUrUTUw?=
 =?utf-8?B?SWNhUDhod3NBSFZiOXJQUER0dC9sR0JOUm9uMWd2OEYwS0ZmT2RzMTJZYi9m?=
 =?utf-8?B?NTg0SGlycU9DUFBuT1lUaC9uYUNhVmxuUGF2NGdISG1ZWlRzSXJONXVnaExJ?=
 =?utf-8?B?SGFCVzBRTE5yUkZsenQ4MWhnZ1R4dkNybzUrcjdvc1JIT0V0VnBpQ09mTFFS?=
 =?utf-8?B?a1Q2T0U4aWlvZmRHOEJwamlEeWZwcEI4dE5wM2dqVlVYZkxkRmJFN3Zud2c3?=
 =?utf-8?B?eGc1ZWNtaUZWc1VLampIUXNjTFp0U1hnMTdWb0VTNWZoVTd1M3NDYkNCNG85?=
 =?utf-8?B?ZTRiZW4wUVFBOWlWK1BTYlVLZWNGL0wvQUozT05kTFcyb0N2ek9JanhDVWxM?=
 =?utf-8?B?Sk5CQkdlWjB6MExodlQraHg5TmlPTk5qQlNkbkhEZ2NMQWFjZU55S2lmREJI?=
 =?utf-8?B?ZmZLaFdyRzVJTEFIV1JhWm4yOGVHQW5OUy8vK0kxRlhuOGdSTG13MFEvYkh5?=
 =?utf-8?B?VEhoYVR6VzNyUUdmV214SXZCU3BGQmJpSCtXRWZmUllTVElDUVA5WXBLeHZ5?=
 =?utf-8?Q?JOUyBZkqQA6K45+VyDHwzEMH2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156e0f9f-87cd-42f8-5771-08de32952625
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 17:55:30.6038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHQIHQOKYrSh8vx+NURQ83eIcBIYZngtnL0lHmmzIOWWoB5io90gWa5OaR9MqFm9fhAwYuxaOkqI7RlW1MuU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
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

On 2025-12-01 09:28, Philip Yang wrote:
> To reduce queue switch latency further, move MQD to VRAM domain, add
> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag to allocate contiguous pages
> using one buddy block.

Why does it need to be contiguous? In the next patch you're mapping it 
in the GART anyway.

Regards,
   Felix


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 9cd1660b8f60..c11e37915365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
>   	bp.size = size;
>   	bp.byte_align = PAGE_SIZE;
>   	bp.domain = domain;
> -	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> +		   AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = NULL;
>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index a489d43d5f64..c6945c842267 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>   			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>   			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>   			NUM_XCC(node->xcc_mask),
> -			AMDGPU_GEM_DOMAIN_GTT,
> +			AMDGPU_GEM_DOMAIN_VRAM,
>   			&(mqd_mem_obj->gtt_mem),
>   			&(mqd_mem_obj->gpu_addr),
>   			(void *)&(mqd_mem_obj->cpu_ptr), true);
