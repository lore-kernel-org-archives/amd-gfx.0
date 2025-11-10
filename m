Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDAFCCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 14:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358C510E3D2;
	Mon, 10 Nov 2025 14:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3u9QdhQ4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE4310E3D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 14:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gL4HWEIwDrB4H78RokOjw6LrF6I0zvNMy3Fiq1hG1rd6q43l4wEgbJGMcFNajImAzeJOqkMbokBFjoxab4RAFbO346/I/zFsP14MkUTqyrjrPaAmd0a/Nd0O7ba8kqXLlDqs/bxSIcmsnfP7jC7fNoJIRGOMyVS9RH+uXS/QmqLvnMJOKFmlVXD3L+Mnk7pp+cpSU+vRjTDaIl1Rrd1s7YNR8xZL89yPxR6r9/ZWgvbvurqQF1gzsidIvLhHAQhn1QL2xrkAbE4Fgedu5gw+gLMDgbDH0diZTkR7BqzgdCL/zi+sGmsEVsusXJO/Qi+883WvCeBCn06bzMcSeBWSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2p0hgDTPHDT6XHiK870dfqDjcDSGSR+/OjQ0UxD4H8=;
 b=LK3eqdQ0CDB+d2OywqrRimgVvhPqJYPQ1dY1Dp5a4apGhSHJU41D2zeHf8YUpgWuBbxxoC67cmrB/mYJtvFC5IG5hqG6ROSw283pMb/Cve0vTLt1K8X6e6XhUzLXuC+S7AJhg1ySyhK05zgI+0Uh9iWsRUBGlZLyLH+Y5kWmVK2T14zyOs9xgZUV6VbQoMy8yGoS9cxDc81XYvhFnmYCzDOEVAO7anOxSVGlDa4exsX+taNRvei9yQoDxlLa8/tePf5p6UYCXd037I0ls0zxnaLLGFEtx6u99mnx+J96BOo6OGPx5UvEqQclLClfH6CkOD3sz90ECw6uTSU7HjSvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2p0hgDTPHDT6XHiK870dfqDjcDSGSR+/OjQ0UxD4H8=;
 b=3u9QdhQ4pZXhqNebY5uzwJIYNxf54kKcJ4w+3wnRLPoOAABrxwhZEIxPG3FVq5za/6vbd0LBwPqYRI7x2QxfuokuwQRDTQ7M0UJyX7Ng8Th1FaAx2njLNWYjNEUuFv884h2+dw2me6hL9ab+tgz2wgci+8FpaEOQF606VCTuiJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 14:16:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 14:16:25 +0000
Message-ID: <75dd7b72-99db-4886-b7e8-87aba18d182e@amd.com>
Date: Mon, 10 Nov 2025 15:16:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] drm/amdgpu/vce: Clear VCPU BO, don't
 unmap/unreserve (v4)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
 <20251107155745.8334-6-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251107155745.8334-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0691.namprd03.prod.outlook.com
 (2603:10b6:408:ef::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 5233edbf-8274-40f1-acf2-08de2063bb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDdQY3g5MHhvWTZvRVExSEJzVWhYaW1sSmlzQnp6Ukw3eGlHdjE4b0I4dXJq?=
 =?utf-8?B?Rkc1MERSMDRtZHhsRUI4SzRmZEgxNDRVOHI2Rko5S0IzVXZIL1dIeFNZeEZB?=
 =?utf-8?B?VW9SLzVSejJRYjZYMTAwbExTdzZZWFQxcHJ3MEZvSFpvbTU1RmIwSEZ5Witk?=
 =?utf-8?B?STdFNEhHR1o3djR4THRvK25VcWErNkpGbk03MDNSNW9JZ0VNalFZbkl5cDFi?=
 =?utf-8?B?MnY1MnhzU3k3MEg0UWtEMGZxSGxtMXBLNjc5bHBpYktUNXJhclBMTmNsZ2Zl?=
 =?utf-8?B?VTJCbmkzSy9Sdk9xRTVvQm9ZajVFZ1gvelBBMkM3azJETU91dGRpYi9KYVAw?=
 =?utf-8?B?VTBFRFdlUmk2M0Q4eEpRZXFSaWVmMHBCVlVNTXp2QXNRcVlWVkNDTkFXbXdl?=
 =?utf-8?B?VFdzR2lIS2kxVHJ5cVBpMTA3Vk5xQTdYTTR3U2ZxSW1OZ2lzTE8rQ0RLNStX?=
 =?utf-8?B?Z1lSK3ljWjFNSFc3SEJLVUY2ckREWFNRRjlxWmVqTnMyc1NlOGp1SVc2WTRP?=
 =?utf-8?B?N0NENEYvUjRpNFpTUXF1V1Rjak5HT25Yd0JZVTFUcUtZalFub3NlbkdRcWFY?=
 =?utf-8?B?VE1xTUtMSXpXV09weUVvVU9Rb3MzeU53c3hJY1ZXdm51bGQyZFdNRFRqS3Nz?=
 =?utf-8?B?WlRPRDlNOHFubzFHeVlGS0R1MjBqY0IrTGFQeDkzMVg3REpRQ2RLM0R6MVU0?=
 =?utf-8?B?c0pJclJJaUNkdGYvYnZubHFtOHh2dXRhZ2EwdTE0SVhwVHdtYTNBczMzSExN?=
 =?utf-8?B?NDB3dUpiS1ljMnd5OTE4MGZvOVVSeDBWUWNFWTBUM2NKbjltaUlYUFBJOEQ1?=
 =?utf-8?B?SFhRSTFOaGx5WWVrRHQwb01FUGtaYXgyUHFJTllUTDBmaUNUMXg4NXBkVjNZ?=
 =?utf-8?B?dFVpTFVWS2F2ZDZmZnliTVR3bFh1UVBJY1RDUlhEMEVBY3lyTlRZYTNEdWMr?=
 =?utf-8?B?NkRZMktHME1QajAyYUhqd1QxbWRVb0ZKN21acmloRWM0NDRwaWRTSzFwNHFu?=
 =?utf-8?B?MXYzdjFqLzh6VFpkaWVsc2ZHUWE5Z09LNndtOUFWaGloOWRaK0lTM3Fvdkh3?=
 =?utf-8?B?eGhVSFRtNGV0MFl5K0pKZFU4R0RMRStzVG5rMzlnVFR2dXRtR2VDUlM3cGZt?=
 =?utf-8?B?UDFiWjBDTkFhZ1FiS0xIRmJYWEdHZFBTczJkMjFoc1JQM1BHOUE5YTE4T2xO?=
 =?utf-8?B?azVxVEFpVVBVWVNYNmplRFlncWdaZjJUWDc2SlVPM0Z0bjFHcVRzVDdBaDJi?=
 =?utf-8?B?dW40eHl0SFpkejg1ZWJmcDJ0UGkycHJUTEZGWWlhUW5ld2VrSDBKRXR1UUM5?=
 =?utf-8?B?a3VyZlpCWTdOUTc4VnQxR2RISjdQdkZTbitNalord2d2Z2U2bDJZanUzSzJ6?=
 =?utf-8?B?YUREemV4Z1Z5OUFuc0U4SmsyeHc1REZ0TUV0KzhhSmhIZDNkd1UyUExsSFJN?=
 =?utf-8?B?djgwRk52RCt3NDNMRmdyS2R3Vm9ESzJWa004M2Y4MUt4ak5qQXlRdDBXZGx0?=
 =?utf-8?B?cjJSbjFvTkI2NmRmbW51eEhvckJrNmlZSjFsdW1UZEFEVmhoWUNCM0ZTWCtJ?=
 =?utf-8?B?SzRYcDM4UGFZckJ1VTBaNzJLdkMrenAxMENMYlM3SE8vT1Y5T2w4eHFEdkt6?=
 =?utf-8?B?S0pQaTVzQUxEdDYvT0x1cHpsakowcHZvSXFyT1JSV3hiYkcwYjh6a0g3dEpt?=
 =?utf-8?B?KzUyWC9MR05KYkhHU3p1L1lVTmJNZndtcVZwN081L0pDUDk1aWN1aFpJOWpH?=
 =?utf-8?B?UE95UHVRK1JuQ3BoY0xWNnRxbTRIQUJXMUY2Z1NsaStFVXZZUVQ3ditFY2NS?=
 =?utf-8?B?aDhPWXc2NXhVRkx2VDlMUFVJRDN2cncwekE1dUQ2WnNTQVpleFVMNHlJaCtC?=
 =?utf-8?B?ZTY1RVRRMEF2SER0cExGeFZsMzVqeGhnNVFJMzlSRjdVOGNBRnZCb0plM0dh?=
 =?utf-8?Q?qxttyDLEoQbQ0KkzkMOdIyC++Yr8r7nx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFA0dGQwR2ZYNHJiaGJldzFNTzFwdVRBbXNuTGYxQlNjSkxiUUhNM1RPdDhD?=
 =?utf-8?B?c1gyNGxxVXRpSDFVdzhsY2hyd3JQK1dZRVhISmtqaS9rOFFKR05pRWJYSUtq?=
 =?utf-8?B?ZjIzNjAyNy9hb3BCZHkxSStoUmY4cHMreU5mSms1ZytGanRpOHlZUG5LalBY?=
 =?utf-8?B?ZUE1NVE2UUgwQjQyWFFteGVydzdvQWFtRmU4NXEzazRwRGI0OWVlZjd0aHdH?=
 =?utf-8?B?c3NhMFgxWmFSaGZ5YlBGQjR6T29zaFpjMW1oSmU1SkNHdGI2V1lEL1VQNE0z?=
 =?utf-8?B?clpHY0h0Ykk1VTZxencvWnFVQSsrZWZGZ3liZXh3MmgxZG84SnhpUGJhUE12?=
 =?utf-8?B?VWFPQXREZnNxUllPYkd6Y3ZyUHNaVi9UODlnN1A0emlQa3k4MFF6WGZsQ29T?=
 =?utf-8?B?aTlzWTJPMXhoL0RoYXFXSTRNc2ljTXJQNnlhdzMwdEducU1wVFNheEZDMHpi?=
 =?utf-8?B?bXdUekhDcXFCK1lzV1Rqd2tRMHBZRmRPOWtFMFI2dERGZGZSbUg1Y2lFRWJ2?=
 =?utf-8?B?TW5SSHRzZWplNlFjRjNFM0gzZkt3alhOSVV6QUZWZWQvYVg2cjVDTitGT00r?=
 =?utf-8?B?aGR5RTkyVXM4c1NWZjJiRTVoSFVKeFJDNVozMERSR1Y0WTR0cjMxSkpSWW1V?=
 =?utf-8?B?T3lJdTBsekpaL2xTS1NweGhRa2V6R0tocXc5TGZkby84ZXpGTi9BQlZXaEtH?=
 =?utf-8?B?dXZremx2Y1N6TkNSR21UelRybGc3ZjEySHpMd05qWVhVWmlNUjFhY1czQ3JB?=
 =?utf-8?B?TFFJUXBOTFdFbWVreHRiQW1uQ2I1Uk9VREI1aWFWc2V1aEhnTzh5blRrK0hI?=
 =?utf-8?B?MzFPbDd3ejE0N0tEWHBSV0ZFSmtqOW4rcU9hQkdrakRIeWF2cWpSaXFMNzVq?=
 =?utf-8?B?V1ZNNUptN1FxRnNmVzR3SVBYa1pkd2gxR1psTi9MOEJZaStCZGJnTjlLQzBw?=
 =?utf-8?B?YWNCeHd5aVlveDdxVExoN0h2UTRuQ21yN20wQjFOUnBWNkhmV1VjNmNFMTI5?=
 =?utf-8?B?TUtlbnc3VFNKaloyOElaTmZaTGxLMEtXc1VjMHZNUWpROXpiSXorSHM3dHJS?=
 =?utf-8?B?QWNlakhGeXVWMitENzdhQm1GcW5OWmZNQUpCaThYakRHNDdjUmtOSjh1bks3?=
 =?utf-8?B?VnNkRFZCck05R2pFbTNURW9ZVDZUV2ZQckZNMG00WlozUHJrRWkzNzV3bXZR?=
 =?utf-8?B?d0FLMUdKd0NPYWxQOGZGam5FZVFvQTQ5SlF3VTkyM1BDSHdDdWNiVERybzZZ?=
 =?utf-8?B?ME9hZWNXTkUyMlBzSTM4Q1h5RTBRYk1QYzk1QlJlbkZZby9uQk1nS3BkN1pr?=
 =?utf-8?B?SXU4Q2QyS3hnZDJ0KzA2bGdpVmVHM0lOcmU2aXNLLzdNaDBETE5PMlU3T2tw?=
 =?utf-8?B?TWZ4SEpGbzc0QnVFd2w1SGpsNUM4bVVqdW4vMnVBN29JVDVGVG5ibXdQUmNR?=
 =?utf-8?B?bGZmWTgxcXFsWXNsQWlsV2lacWw3RU1QNHpQUFE4elNiV0Q5MlBoNWQyQVVv?=
 =?utf-8?B?bXZYa2NNZzkzSVV1MzdRcTVCMnRmZ1lJQ0lFUFh3anBxdzUyMDQvWmVxVmJI?=
 =?utf-8?B?YU9GTmZlMFlvcC8vKzM4YlNLdm9vY2x3SGdBV0FZZkJsaUhlRmlOeWtpOXpr?=
 =?utf-8?B?RDZMNmtWNjYxTVp1c0FVY3NqRXNVK042b01lSTZYOGQvSHl5VkI3QUFPamIw?=
 =?utf-8?B?ZU12Z1ZZaCtxdFBiOUhNanZSSDZHREhuVVh3R0Q3Y2xoRHpKTzhkY2tYWURZ?=
 =?utf-8?B?T1FCYVNvYlJ3OXd4VlkyVXprUGVwV291Z2NhVGxpbUJFOGFjVlE3Tm15WGlR?=
 =?utf-8?B?UzJxcjhRU0RyNmtDNFc4b2I5RVNHbTcwdFRrQ0hUbElWVVJkUGJqRE1kajZ0?=
 =?utf-8?B?TjFCODJnaUFRZTZLcHJ4bFV6bHRTZ01QMDhvNEcyTmRWSGZnYTRvVG1pTWNm?=
 =?utf-8?B?WHRUNDV0Y1ROMzhVZk1DS3kwZFBpY3QvblVqRU1LZFp0ekNIVmhFcjNtQ1FX?=
 =?utf-8?B?OW8yTXh3TTZZVmFpSk1sZjVzRmNiMFdvY2drVGd5ZHk1NlI5YlhDbmgrcDlm?=
 =?utf-8?B?YXp5UTdhVWxCZExJb3QzNXZTY01oeVpaZEo3M1lmbHRmckV1R0Y4SWZkd0t5?=
 =?utf-8?Q?QGCmiYvnElLoQbMgPYjzj5vJG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5233edbf-8274-40f1-acf2-08de2063bb2c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 14:16:24.9623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA/YUdA/x6JpkUKgaRXjcWEqf3fFpVIbrYjjSDCXUUYajkPMXCAcWrWc/15l0S6B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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

On 11/7/25 16:57, Timur Kristóf wrote:
> The VCPU BO doesn't only contain the VCE firmware but also other
> ranges that the VCE uses for its stack and data. Let's initialize
> this to zero to avoid having garbage in the VCPU BO.
> 
> Additionally, don't unmap/unreserve the VCPU BO.
> The VCPU BO needs to stay at the same location before and after
> sleep/resume because the FW code is not relocatable once it's
> started.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index c4e9d1862108..3a986e3589a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -314,40 +314,23 @@ int amdgpu_vce_suspend(struct amdgpu_device *adev)
>   */
>  int amdgpu_vce_resume(struct amdgpu_device *adev)
>  {
> -	void *cpu_addr;
>  	const struct common_firmware_header *hdr;
>  	unsigned int offset;
> -	int r, idx;
> +	int idx;
>  
>  	if (adev->vce.vcpu_bo == NULL)
>  		return -EINVAL;
>  
> -	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
> -	if (r) {
> -		dev_err(adev->dev, "(%d) failed to reserve VCE bo\n", r);
> -		return r;
> -	}
> -
> -	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
> -	if (r) {
> -		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> -		dev_err(adev->dev, "(%d) VCE map failed\n", r);
> -		return r;
> -	}
> -
>  	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
>  	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
>  
>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> +		memset_io(adev->vce.cpu_addr, 0, amdgpu_bo_size(adev->vce.vcpu_bo));
> +		memcpy_toio(adev->vce.cpu_addr, adev->vce.fw->data + offset,
>  			    adev->vce.fw->size - offset);
>  		drm_dev_exit(idx);
>  	}
>  
> -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
> -
> -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> -
>  	return 0;
>  }
>  

