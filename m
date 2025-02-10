Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8D1C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 15:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4386010E1EB;
	Mon, 10 Feb 2025 15:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3yLr/Q+z";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2488D10E172
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 15:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjp7uUWcIKSJjgyDvf3DQpYC176Ec2Slr9yIZFPgQ6pnLkrZ34CjWabdGzQypt24ZFEjnQiCRiCYDCftBrYYnRhkoEQjUICeQWu2eltRMeFY2tZjT2SZuajc1g8eb0Rm3kK7irBhTyeNCJKOdCbpc4eXB/tuUYzqeV06Yj1f4wTePEEeFATYSQbrBZQ3xIwQQQtMOn4dyqcH9eW5EKaopEjiqEPZXPfLjXPo9/EW0t4m3C9XT9CAzpj9txT1J3G0vLU7er3OcYpbd+KpmuUwNaESVUaR+nQGxccZMD6Rb7N7sSMJk2m54Xwrby2RS4uxMvt2sOJN2Im6GlniRmmomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTonanoK5TwCiYeeIXmXFCTD6hn8QWXW1VI2LfBnkiI=;
 b=c/JCbrIpFN4PbNX6tGrMOoRHYHcljR1e7rTS/r2SeUwBvL9TuHAXt8I/B7AvfSSOH5xcRTSEQmBd0MsEwDYCFhBRkxC1St4r0kqKUNfq2EyGULB+PROynHaBW0dDFi0XI1v/oo0iMU+11QWokMKIfzY/lQ6Sf9dScW36NBO3SlbqZzzdg+P/+ZYjQ9dQu8tWyTaMH6X/hP9XBko6myz0j4dERq1oUtJ1M/IOal0i8QaMiI7D6jBTPEpL2yJMowT6/qmYR58SBdb2HyrRVRqAJbBpDJO0YNX9a/LwmMMvlCZ763dpik4ZYCexGuz6AOgmmmxgC/pdsAaEJ2j4w+DISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTonanoK5TwCiYeeIXmXFCTD6hn8QWXW1VI2LfBnkiI=;
 b=3yLr/Q+z9b/Wy67SDhuRMacg6pbgq0/zJewTukOZvCYsAMaOYEsH/JNfHZqe0P9ULmAZFQRAruhePnH1vOLw5ghQ39Wcc1VI9kWPXFI3x0cqfzB1z+dHfzb9jsJyy8N4G03AfV3A2PLvrxw1xWdY+HamuXvGa1h8HqpIWm8Q4VA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Mon, 10 Feb 2025 15:39:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 15:39:15 +0000
Message-ID: <349230de-3b2c-49f1-bc0d-8244cc2e6bdf@amd.com>
Date: Mon, 10 Feb 2025 21:09:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] drm/amdgpu: Improve SDMA reset logic with guilty
 queue tracking
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 Jonathan Kim <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250210095629.2748149-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250210095629.2748149-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: fde3bee9-d7a2-4a74-9137-08dd49e91310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eENxeDlkbHArVXpCWG9jalYxYXVtSllpaGVEVjV0K0NwZG9wWHBrRmdhTU00?=
 =?utf-8?B?aE1yd3I0TkZEdUk4VlZyNGhTeUI2cm9NUDk3amM4MTc0TUxQOHh2aVJsbHUx?=
 =?utf-8?B?TE5FRnNqYnZFUWhxekJEWGhMam91Q3dXZWVFVjdaR0FBcEw3NllGT3FCa080?=
 =?utf-8?B?RkpkdGd3YVdpYVd1aWhBRXh2VmJKekd5eWJMSXVyc0xTR0VpTHlLeWNLK0Fx?=
 =?utf-8?B?Nk5RQVlzNysvMU1MamJweHBxajkzWVZYd21zMFUzSDkvNGlIOStRUVg0R21m?=
 =?utf-8?B?TFRtZU1qZ2Q5S0JKUkZXcDZpeGJkQ0M4Q3VobForM3N6VVVUc3h1ZmF4MjNt?=
 =?utf-8?B?QWJFV3c1V3cxNEhRS041N3RtRzNzZDFpcmxKRkR1cEJGaXVwTDA4dDgzR3ZD?=
 =?utf-8?B?OWRuMDNZWEd4SFhJTE1nQnFtd0tIYnZWb3BmUC9RamNSeTdaUFE3M0pWMG1K?=
 =?utf-8?B?R2V5SndkanJKQXpyVmRPaFFrOW5lc0xtSTRtNUJvdTFPV0M3YU5tQy9uNHhW?=
 =?utf-8?B?MGdvSml1b0pvU05pVkpFaTdRWEZQTlo0QktNV1hzQkQzQkkzRHpIUnVQUFUv?=
 =?utf-8?B?RXBxRk9NMGI2ZmFjdW1TWUhZUEtZdWpZK0syVlEvUkQ1eTFPL2JXYlMzeVR5?=
 =?utf-8?B?T0t2VGxiNVNZNlVXY3J3Q0J4QXdYMVhpblFDQjBZUnMvTkpCL1BzTnBiTGhm?=
 =?utf-8?B?aHlJRmU0NGZGQXlMU09PSGFXbkhNaGFwQy9NRVh6dGUzam5WMVI3bGI4cFZG?=
 =?utf-8?B?WGo3ZXpQRlhsd0ZLdkNDRVNYbU52dE9sb1ZOVmRRUnF5QzRzdzI1ZzJmeVpv?=
 =?utf-8?B?K3dxSDZLdVM0S0lNWlpNQ1FLUTYyTDlJK2dTcHFqYnQ1OTRFOXpJUE4yYkRk?=
 =?utf-8?B?MTZrOXp5enRwTnN5c1FMK0M1M1M0TEFHaHhodjhxTjN5NjNmZitSalFxVHRD?=
 =?utf-8?B?V3Z1bUI4NmRmTUNoM3dlK2hITDAvTTU3eEhxMVMzaVViVVhjQkVnR0dkNDFi?=
 =?utf-8?B?dmtUaUhaRE1xenRUTjRDdm1keWVzRjlJRW5ZN2FXbFVhRUJsaWM4Y0VCWVFq?=
 =?utf-8?B?SHBURzZxTERQYzBsNGNsbHd1d1g5NFBTK3ArMVRQVDRlRFJmZnp2UTlsNC9q?=
 =?utf-8?B?RWpJL3BFZlIvOThaOU1BbGZNZkk0VGdIV1BXRTlaMDZ0NkNWMDhlSk5lbGM2?=
 =?utf-8?B?YzJOTEJkVWJieDBmK1FXRENmTXpBMzlOeWhhNVpKOTNDZ3BYYU9VTEI2UUhX?=
 =?utf-8?B?aWxuQ3RFWGlKckY2YUNEVnNENDUzMHRSR1NSNU5rQzIyWTJLbGZVRXNwbi9S?=
 =?utf-8?B?eS9YUE1kRm9ueE0vdjIvWEJ1WUJKNlhxNy94QS9uRmgwMXhLN2Q5T09uSnli?=
 =?utf-8?B?VmVJN3IwTktUb29IdjRtUHRXUlYvaW5oTjNhcXpjQWRhQXQvQUI3SC8rKzJa?=
 =?utf-8?B?OStacXZDZWgxVkx1em1yZThyRnJrMVpwd0xzNmJsSFBYR0k4MHF6MzVlMUlI?=
 =?utf-8?B?SkhKNWI2aUlPMUo2Y3VsSVFyZ2I2bEowL0U0OEZYMGkxYndhSy9abVNHMWJx?=
 =?utf-8?B?anBERnhjSjhVNnltQjlwOTRGNWt2Q3pFWXpoNjNLS2p3cnNxNUhVRXVTZFpm?=
 =?utf-8?B?MjQ1RFZnMXdBTUkrNFB5SUlNR3BPcGY5cFVQY0hTclAxbm5NeUx5ZXVnQ0V5?=
 =?utf-8?B?eTdwUTFCNGdsaVk1V1dldE9IYVhiVUVNTENnYUJ5VUl1NStoNXZsV2pFMmdi?=
 =?utf-8?B?cTB1WTRUWmFPZWlmOTg2NThSUFBXL1g1TjBQUEpaWWRET2xFTXh1UVBHSUhk?=
 =?utf-8?B?UzlGVC9LVWJmMlgzRk9ZMnRrL2ppQmpEcjdlRElPYzlKSW1CU284cG1yS3Ir?=
 =?utf-8?Q?6Stb2BeqYqrkB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEswRWVRZFkyTnNSZHRNWVdIbndTdVJrdFFCcFZkYzk0YjVXZWJreE1LUkNH?=
 =?utf-8?B?TjM1bGp2TkdNanBaVjIzcFRUdWpoVFZHR24yZG83a00xWitRcTBOa1Y4Z05j?=
 =?utf-8?B?R0t3c2tEN1BRM0FzMVpUSk9BZTJTd0ZmNzZzWjEzWVlWa3dibHFjblN2MllQ?=
 =?utf-8?B?TUhFcUtCM2M3bDVZWllla09LbHlRekFSZXhscXJiYTZmdnJ6eXpSYW8wM0tK?=
 =?utf-8?B?QXplUmpkNXpxV2RGMlJEemRRS2I2ZHFtN01PSVFLSnROMDRqS1QyaTMxV25y?=
 =?utf-8?B?UXU0NWxTT2pQMVVhSzlaeGgzRzZiWno3MmxGL2QyODQxQUdPdHUxdnlqUmZn?=
 =?utf-8?B?S2hydE9FZEl5NlBaQVlQaCt4bW52R3J2RjNhNEVTNjRqM1ZzZXpXaFZIYnpX?=
 =?utf-8?B?ZHBqUzM3ZWVmcGk5U2I3emF2dXVvbWZlN1gySysreVo3TmYxSGtJbFlEd1Nx?=
 =?utf-8?B?cWZmS055U0pJdGVpRTd5SjZ0WmNsUFJKY1ltRnBCVGc5V1FRYUphTmc2UGpt?=
 =?utf-8?B?a29tOEJaRE1jOEpzZWlsdUk2VEtCRnd4SmRCcXhrWTJKRllEaVBmeVlnSGJq?=
 =?utf-8?B?c3plMnlLUXJ4MVBwNVBPWWhla1lxek1VamcxbjNsMkZVY2Q0UHZPdTNMWVcz?=
 =?utf-8?B?S2FTbFVHRVpzVzdDc3RVU3VCMXMrSmwvN1RCWUJnOXVNVmJwdG9zQVhGY3Yw?=
 =?utf-8?B?ZVA0RFJqWno0S0dCaThRRGR3QnYwRXJtL0lxUEEvbVlDT01BM2R0U0RiWVRj?=
 =?utf-8?B?WHJLK1NjVWpDNE9BVVJNY3hlZEF0MUxMTFJtMndpRWRLK2hFM0EwdHg3U01H?=
 =?utf-8?B?VGdCT05OcGFJdTk0Q1dxanBydVFvcXovcWhyMm5nclJubE1vTEJnbGVjbGRi?=
 =?utf-8?B?NWNjZGFXVzA4RDJnMW44YzlHVlFVUnNJWXJ2VC9RMXFaTGgwR0l6SExwZXNJ?=
 =?utf-8?B?c3djNnlhYmVhZEdZanZtRTk0TUk1L05rcWE4eEEySUZ3M2hzZkZSdENMUjZ4?=
 =?utf-8?B?ZnE3UC9WTEZWdmZhTzRzYUZPQkRkMVQySUxyeFRKalNNQUJzdmV1R3FwOUVB?=
 =?utf-8?B?blpBd1JMRnFYNkliQjBnSjBURXpkNUROMU9ZMmRQbXJmUE0ybkdsM0NSbi9i?=
 =?utf-8?B?ZnFwclFBbjJJbDFQMlVGYmJOZFNscC81dUZYMnR4ekdZNjE0eG90NlNxa0Vo?=
 =?utf-8?B?dmtzY1F6SVJjbG1TT2Zra1Y4Rm43bXVoOEozQ3hsS0xndE1tanFETVFzdjIv?=
 =?utf-8?B?aXIyRnQwMFdXWHU3UTcvNHJpdS9PN2pEb0RMeWFjaFBQMXh6N2dYQ1JoSldW?=
 =?utf-8?B?TkNta0NOcXllYWVNUmFlZHN3STAwT29SenRXSlkrZHF0L3FEN2UxVU1JTEpj?=
 =?utf-8?B?VnI5UTQ0NXpTR3lqNEplNElrSGN6VFFQZjBTVnVadjZaZ2pacjk2bDRLd3RF?=
 =?utf-8?B?aUhGMW1YeUZFaVpMbnIxd3BiSXQ1QnUzK2xGZlF5NFNCYkhOSVI0bzFUN0Zw?=
 =?utf-8?B?b1lKYnBvMFZQS3FoRG0vWTR0WnpaMjNmTysvL0FPLzRPZ2xaQW95QXNPUkJN?=
 =?utf-8?B?Q1lkYmxzWFdQUEY3R0tnSFFkbmpjSXRJSWxhaE1Zb2JzbW5pZEJNQUJYZkZu?=
 =?utf-8?B?cUxYNHpDQmNXNU43YTBJSkRrTHhVNnBtNE9LVjRVaHlsc0R0NzN4OTBzYTlj?=
 =?utf-8?B?YldIdWpKckZnY053UDkzNThYenJsQ2twS0owaWhmWk53ZHd6VjFZUUpmNjV6?=
 =?utf-8?B?WG80cGR6NDkrZktnRGFES1kwTDRTSWRxSWNMMDhvUVNJQ092aU9FZm0rSFFB?=
 =?utf-8?B?YVdKcnZZNjB6TCtjWnJGdlR3MHVSVXdRTXk1bzFUYXlra1A3ckEyQ0xRb01C?=
 =?utf-8?B?R1BxQy9mcVdsTWRydDJLbVVpaGVScXhCVXZYbzgwMEVXWVFTNkRQNTdDMHFJ?=
 =?utf-8?B?dW9Vckw5SmJBMEpWNEp6UkwxQ3ZJaXlrM1hqTy9UY3Qxdis0WThTOXFVaUcz?=
 =?utf-8?B?a3Y0R0p0eExQUjFQVW0raTY3MjFCM0xBVEV0bXIzQmRXN1QyL3Q3bU5DdGJQ?=
 =?utf-8?B?YXp4ZWp3dHhiTzBQTFlFeGJ2eGhDejA1TjlJYnJua2tQTWRBZXUwc2oraWFY?=
 =?utf-8?Q?Y6wx6zEhgI9rxzLC/UraPdAaT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde3bee9-d7a2-4a74-9137-08dd49e91310
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:39:15.6659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUL0FopthVjTeIEmQLfy0RZz8EXnjhvFMp6u8Qx4E3xDQo7ifZq2gqZ4XSWbMSVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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



On 2/10/2025 3:26 PM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This commit introduces several improvements to the SDMA reset logic:
> 
> 1. Added `cached_rptr` to the `amdgpu_ring` structure to store the read pointer
>    before a reset, ensuring proper state restoration after reset.
> 
> 2. Introduced `gfx_guilty` and `page_guilty` flags in the `amdgpu_sdma` structure
>    to track which queue (GFX or PAGE) caused a timeout or error.
> 
> 3. Replaced the `caller` parameter with a `guilty` boolean in the reset and resume
>    functions to simplify the logic and handle resets based on the guilty state.
> 
> 4. Added a helper function `sdma_v4_4_2_is_queue_selected` to check the
>    `SDMA*_*_CONTEXT_STATUS.SELECTED` register and determine if a queue is guilty.
> 
> v2:
>    1.replace the caller with a guilty bool.
>    If the queue is the guilty one, set the rptr and wptr  to the saved wptr value,
>    else, set the rptr and wptr to the saved rptr value. (Alex)
>    2. cache the rptr before the reset. (Alex)
> 
> v3: add a new ring callback, is_guilty(), which will get called to check if
>     the ring in amdgpu_job_timedout() is actually the guilty ring. If it's not,
>     we can return goto exit(Alex)
> 
> v4: cache the rptr for page ring
> 
> v5: update the register addresses to correctly use the page ring registers
>       (regSDMA_PAGE_RB_RPTR) in page resume.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 10 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 96 ++++++++++++++++++++----
>  6 files changed, 106 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 100f04475943..ce3e7a9d6688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -102,6 +102,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		return DRM_GPU_SCHED_STAT_ENODEV;
>  	}
>  
> +	/* Check if the ring is actually guilty of causing the timeout.
> +	 * If not, skip error handling and fence completion.
> +	 */
> +	if (amdgpu_gpu_recovery && ring->funcs->is_guilty) {
> +		if (!ring->funcs->is_guilty(ring)) {
> +			dev_err(adev->dev, "ring %s timeout, but not guilty\n",
> +				s_job->sched->name);
> +			goto exit;
> +		}
> +	}
>  	/*
>  	 * Do the coredump immediately after a job timeout to get a very
>  	 * close dump/snapshot/representation of GPU's current error status
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index a6e28fe3f8d6..20cd21df38ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -342,6 +342,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	ring->buf_mask = (ring->ring_size / 4) - 1;
>  	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
>  		0xffffffffffffffff : ring->buf_mask;
> +	/*  Initialize cached_rptr to 0 */
> +	ring->cached_rptr = 0;
>  
>  	/* Allocate ring buffer */
>  	if (ring->is_mes_queue) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 04af26536f97..182aa535d395 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -237,6 +237,7 @@ struct amdgpu_ring_funcs {
>  	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>  	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
> +	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
>  
>  struct amdgpu_ring {
> @@ -306,6 +307,8 @@ struct amdgpu_ring {
>  
>  	bool            is_sw_ring;
>  	unsigned int    entry_index;
> +	/* store the cached rptr to restore after reset */
> +	uint64_t cached_rptr;
>  
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8864a9d7455b..02d3685d10fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -474,6 +474,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
>  	if (!funcs)
>  		return;
>  
> +	/* Ensure the reset_callback_list is initialized */
> +	if (!adev->sdma.reset_callback_list.next) {
> +		INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> +	}

Keeping it in sw_init looks just fine.

>  	/* Initialize the list node in the callback structure */
>  	INIT_LIST_HEAD(&funcs->list);
>  
> @@ -513,7 +517,7 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t instance_id,
>  	*/
>  	if (!amdgpu_ring_sched_ready(gfx_ring)) {
>  		drm_sched_wqueue_stop(&gfx_ring->sched);
> -		gfx_sched_stopped = true;;
> +		gfx_sched_stopped = true;
>  	}
>  
>  	if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ring)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index df5c9f7a4374..d84c3eccc510 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -126,6 +126,9 @@ struct amdgpu_sdma {
>  	uint32_t		*ip_dump;
>  	uint32_t 		supported_reset;
>  	struct list_head	reset_callback_list;
> +	/* track guilty state of GFX and PAGE queues */
> +	bool gfx_guilty;
> +	bool page_guilty;
>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c297b4a13680..ad30077ade6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -671,11 +671,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
>   * @restore: used to restore wptr when restart
> + * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -710,10 +711,19 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
>  
>  	/* Initialize the ring buffer's read and write pointers */
>  	if (restore) {
> -		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> -		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> -		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> -		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +		if (guilty) {

Keeping an intermediate variable like u64 rwptr could simplify.

if (guilty)
	rwptr = ring->wptr;
else
	rwptr = ring->cached_rptr;
> +			/* for the guilty queue, set RPTR to the current wptr to skip bad commands */
> +			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> +			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> +			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> +			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +		} else {
> +			/* not the guilty queue, restore the cache_rptr to continue execution */
> +			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->cached_rptr << 2));
> +			WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->cached_rptr << 2));
> +			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->cached_rptr << 2));
> +			WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->cached_rptr << 2));
> +		}
>  	} else {
>  		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
>  		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> @@ -768,11 +778,12 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
>   * @restore: boolean to say restore needed or not
> + * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
>   *
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -789,10 +800,19 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
>  
>  	/* Initialize the ring buffer's read and write pointers */
>  	if (restore) {
> -		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> -		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> -		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> -		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +		if (guilty) {\

Same comment as above. Shouldn't the guilty state be reset post queue reset?

Thanks,
Lijo

> +			/* for the guilty queue, set RPTR to the current wptr to skip bad commands */
> +			WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, lower_32_bits(ring->wptr << 2));
> +			WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> +			WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, lower_32_bits(ring->wptr << 2));
> +			WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +		} else {
> +			/* not the guilty queue, restore the cached_rptr to continue execution */
> +			WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, lower_32_bits(ring->cached_rptr << 2));
> +			WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, upper_32_bits(ring->cached_rptr << 2));
> +			WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, lower_32_bits(ring->cached_rptr << 2));
> +			WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, upper_32_bits(ring->cached_rptr << 2));
> +		}
>  	} else {
>  		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
>  		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> @@ -968,9 +988,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  		uint32_t temp;
>  
>  		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -		sdma_v4_4_2_gfx_resume(adev, i, restore);
> +		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_guilty);
>  		if (adev->sdma.has_page_queue)
> -			sdma_v4_4_2_page_resume(adev, i, restore);
> +			sdma_v4_4_2_page_resume(adev, i, restore, adev->sdma.page_guilty);
>  
>  		/* set utc l1 enable flag always to 1 */
>  		temp = RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1480,7 +1500,9 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>  	if (r)
>  		return r;
> -	INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> +	/* Initialize guilty flags for GFX and PAGE queues */
> +	adev->sdma.gfx_guilty = false;
> +	adev->sdma.page_guilty = false;
>  
>  	return r;
>  }
> @@ -1606,6 +1628,34 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
> +{
> +	uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
> +	uint32_t context_status = RREG32(sdma_v4_4_2_get_reg_offset(adev, instance_id, reg_offset));
> +
> +	/* Check if the SELECTED bit is set */
> +	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
> +}
> +
> +static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t instance_id = ring->me;
> +
> +	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> +}
> +
> +static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t instance_id = ring->me;
> +
> +	if (adev->sdma.has_page_queue)
> +		return false;
> +
> +	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> +}
> +
>  static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -1616,11 +1666,29 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id, int src)
>  {
>  	u32 inst_mask;
> +	uint64_t rptr;
>  	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> +	/* Check if this queue is the guilty one */
> +	adev->sdma.gfx_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> +	if (adev->sdma.has_page_queue)
> +		adev->sdma.page_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> +
> +	/* Cache the rptr before reset, after the reset,
> +	* all of the registers will be reset to 0
> +	*/
> +	rptr = amdgpu_ring_get_rptr(ring);
> +	ring->cached_rptr = rptr;
> +	/* Cache the rptr for the page queue if it exists */
> +	if (adev->sdma.has_page_queue) {
> +		struct amdgpu_ring *page_ring = &adev->sdma.instance[instance_id].page;
> +		rptr = amdgpu_ring_get_rptr(page_ring);
> +		page_ring->cached_rptr = rptr;
> +	}
> +
>  	/* stop queue */
>  	inst_mask = 1 << ring->me;
>  	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
> @@ -2055,6 +2123,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> +	.is_guilty = sdma_v4_4_2_ring_is_guilty,
>  };
>  
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
> @@ -2086,6 +2155,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>  	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
>  };
>  
>  static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)

