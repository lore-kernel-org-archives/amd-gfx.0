Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADC6C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 19:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9D410E5B2;
	Tue, 31 Oct 2023 19:15:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3ADE10E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 19:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Q6BOkMMZCqc1XnqSkLPB4hogrk53MGf1yr89vr0pKl+a7fFkRYzogk57OvnpCtXAQMI/vUqaq0Skg8nZ1Z0NS1/5Q7ke5fA0Uvcwd7bYI9OLv5wXPDhKhDH6FnyYu0t8xoqsMwhz09ON+we4bi58SLxafl/Otxc2+gXbmOA0gNqGQOJgqlaG+pOckBuORYy0PQqOHUxYzPcXaMgD5fUXnwJeTqZC5agxOOyTPsBZZmpaSVJZxbqlJXJVCsmjVQldZVpjwaqNftOQm5UF/xW/7EIt3N6zcK/h+DoOfH+6QxPtAy3AfSG+3DydtcFN4zzBz+wTghFyQkEB+4tHoU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsMpX8HMt82Iyg0l4bA32dlVdM1K2YBO5mU+5tqa8Hw=;
 b=UqPCUMaBUQ1j1bX8hsyiQ1rXW+zt0sv2KU+DMAFs5MT0A4ra3Bh7MuMXZpssP8kF17af/dx3bc5LqUcmY9GBJaQqJUKw2XbJ11yOqonuXBkGjvZZCEDWz9flxYx2EPxPIORL2QXistXKhDkBnXeIESp3gSzfVKXDuElsq8jUEjH2YOOPzuvojTVHEG3d1OsRRWENMOljjI0tSDcrqVGS4Olax0NI80Z2n0sh/wzRBiVlw7hhXyF6TWTIMVI6U/Ehuz2ChYwYGXw1o5sOg8UQA4fMOf2vXFVE/7wgC3GsSWqfPrePCkYReM65YbDkkFkycSUi8cMfonRSMm3Cp5jv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsMpX8HMt82Iyg0l4bA32dlVdM1K2YBO5mU+5tqa8Hw=;
 b=orHtYgoH1QJAkTJQyJqI20UMPC9UbC5eXQ5HyLhV9cmmkU11GRwQB+apmnnVijP2ymXs3JHj9mTdvL2VcYosss/amSFFf6N/rso5tSYRf5tMTqhWtxbvVt7qubUYGdjZvQ5xqJOg6n+dftdWcz0coD8rJHvDyAC6n1YDQJkZJB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 19:15:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 19:15:08 +0000
Message-ID: <47fd2548-9ced-4e5a-b20b-1113929c9fbf@amd.com>
Date: Tue, 31 Oct 2023 14:15:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [3/3] drm/amdgpu: add a retry for IP discovery init
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231027154225.1662448-3-alexander.deucher@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231027154225.1662448-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 662dfb08-3a98-4fd2-40e3-08dbda45b274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NCfcqTDt2HkRhIbEGQCoxu1P/k8G6W4f6NFEqf6H6UNg+G8JpGOLF4yrwXUzAB9uzvw1GFouuJHwSGiNXUqEQjh+V0H9A0dJAdIbnkwUpSExsG3zQRgfu+6FA6+yDqXokhlUVk0itbQFY9g+QADa+/p9ezcMS8xnNj+TNYdjvTYBbvYYTMvb4BjiDg2OIZpmUrLhp/uSlhlyR0bY4sTMpQNTwdWc7uaoM+tqm/QPxcXjMUBJDVTxeFHhRRZwR6/UhVB8ixQJzd9IThHI+ndCwYeK+uFluzd80MAdmPYWJdvR3PBuIL89S4DtGUyySv328X/B0/r6CB3bIahKqN95xfmOy2bR2cISGF0UClmhTPXfrmGHgtM6Lb2PuxLPh/ShbMuLKLEo/KyGKo0+AVCKeKfDhBx2f+deWxSubgnVSAeWVUn2YSxj6HwnogFJRh9SyAyeB8zDrzMTpsia0vsHY/KXL1rbVkPBDhhHJ936rtztJLTZhPI0cNe2yNmdItyjwjqMstXEO73Eme14sogZEzu7XfGm8XTUp42GA0N/0fcXpO8s+AEAQnVflbFU9xxYgX4zKxn1XsaK1A8Uh5C106NGx5zDr3MZVdeoB3NUNXTRl+SZcl9D52vTQqmS+AT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(26005)(53546011)(6506007)(6512007)(38100700002)(86362001)(31696002)(36756003)(83380400001)(8676002)(2906002)(8936002)(31686004)(44832011)(5660300002)(316002)(66476007)(66946007)(66556008)(41300700001)(966005)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRna3F2UVlmVGp0dEZsVTVNRzFmY203Wk55Z2FTZ1NmUTY0NTBtRk4wcHU3?=
 =?utf-8?B?Z3JZRStzYmNhWjhyL2p3bWVVSTBKUTJ1SEJGVG1reDFzUnBWelRyaDFQR0VX?=
 =?utf-8?B?d2Z4RGY5ZWpPY2ZDK2ZaL1pVREhhazFJazRIRTBpNmZ2cStvQ2o1clg2NVlT?=
 =?utf-8?B?ai9tK2IyUUhBNlpDSTZiRWRpSWQ0WUxkT1RNYmVHY2NmYldhcEZoYlZSb2xs?=
 =?utf-8?B?by9vTjZNTk5PakVXK2NMN0xiYmt1ZEhUdVZTaEVYcWpoNTgwOXJDY0ZVREdr?=
 =?utf-8?B?YTdaTzNOVnppaGlEOU0ycDBDOWZqN2JVeGtKeTRGVjlGSTZRQVFCbDdDOTQv?=
 =?utf-8?B?TWpqTjNYMHd2RElyT3BkbThMd2ladGFYYzN5NXppN002Nnkra3Z2OWJqeG43?=
 =?utf-8?B?cWtXLzZQc09wTnZMS0xQLzQrazdDczJ6NDdzNWhrdTRablhTSVVJQW5rM3hi?=
 =?utf-8?B?QU1YdzlUeXJQUWVjOXB0TDVGNzQ1MTNxeWlpSGxNczRpMFp0WFdVWmpkR3F4?=
 =?utf-8?B?TTdQT29LeHhiSk9iT2k2U0F4dGFDU082UTdXVnJRLzE5anFMa0xiRkEvaC9P?=
 =?utf-8?B?YTFBamVFSTF0NjEwN1FScUhZR1NNSmY1eXRLaWpiVmkzS3Z0SWhMaTZtQXR1?=
 =?utf-8?B?TmlzeUNQUEZxcExjM241c1c2MGNPQkR2cWhJNXI4QzVzTlV6ejBwTFZMMjdh?=
 =?utf-8?B?Yy9WSTN5Q3NlbTJOcnJ5MXBoVVBsYVpBdm5aRHJNTlNEdlZSOGJIWVRscnM3?=
 =?utf-8?B?R0NrNXR0OTlZY3ZabW01ZlBtbWZSSnltV0hJUzFtOTJWUjcxWjdvdElvZjF4?=
 =?utf-8?B?SWQvOUhkMEtoRHk2R2JQMlRpZlhrMHlLRlZOeEZjWDk5YlVXSjFGTEorOWJX?=
 =?utf-8?B?YzlMdzZ1eERsMzlTSUl2R3hrRlp4d241bzR4Rk1kMHlHLytpRkNzOVZUWFdP?=
 =?utf-8?B?LzNnZHFBYTVGTk1sSEc1VjJSTUxVa1diQXJDUW5pcjFwM21zVVpMcWM2b2t5?=
 =?utf-8?B?Qit1ejFOcDlzNVNSRk0yQXRxMktYUWxXVUh2L1laVFVIbmRBUnVxYUVhQ1dW?=
 =?utf-8?B?bFlqMmFGeUtkajVVMFdxTk55dGhJa1NCUi9OdEtQUjMxZThaanhtSmpQR0Mz?=
 =?utf-8?B?Q0ZUem5XWFU3NHlyZ1d0VDBKT21tN3Juc0hQZnM5VXpKcDhQOFcxMVpKV1lk?=
 =?utf-8?B?VVEycTBlUmdLU3pycTVBbVdnWGcza0FPZVNOdDMvb0x2Y1pzdk96VWphWGdw?=
 =?utf-8?B?RTc1TTVwMGo5dlh0TFZkeEs1NnVOcDNkSXJ6T3pMRUFyejh2NEhKY2xpT0xM?=
 =?utf-8?B?MjhWY2V5MDRhbE1EREFjeWRoMDdkejR5RlJhdHFSS25aQjNQMVJZTUg3enhv?=
 =?utf-8?B?SDN5K3kwYWFwZjIrVTZFdmVDM3g3NlVoNWV0djZXbmRkZEtLNHhRL0Z5RE9h?=
 =?utf-8?B?YXB5ai9QU3Q1R2IyT3g1bTV0bWtaRm9KN0JLVmpxTCtqRlY5NW5jL1JVL2U1?=
 =?utf-8?B?SzB2MWY3ZlAvN0w5YUtkTUljNDJCVy9Ld2FwaXNCRlorRGxWZ2J1ZWpkSXht?=
 =?utf-8?B?ai9WKzhpUy93RFRFZHdLTkV4SnBEUzZHOUlKT2lKY1czL0hnODZUV1dJcXZT?=
 =?utf-8?B?M1pDNUxYajkxMDEzeWQ0TWhaMU9KaEVPUWw1c3grdWF4c2RXazVrQjZIZmpJ?=
 =?utf-8?B?QVYwNkN1K0E5c2FaNjZGWUpMS1NvM2VzQ2Nrb2t1WE50NjdJR2E1a2J2TTBn?=
 =?utf-8?B?TGRzK2tpSmc2VUN3WDd0ZE96eDV1enh2cFBjSkFsaVg2VEVwaVh4cVJhSEZR?=
 =?utf-8?B?QmtJeHI3YStCWHJNY09PR2lNaXFyTUoxVGczYzRLK0h5ZkZyS0hXbE1zK0xp?=
 =?utf-8?B?Tm9VQWxWY2tkc2ViRW9TREh1WGFLQUJZbnRFNE5xTnZ6NXpEclJTS1VEQURT?=
 =?utf-8?B?VVN4RkJDcWs2NlNGWjVEOC9SS0NBQU1xdG05Mnkrc2dCL3hMTi9OcGtuN0J0?=
 =?utf-8?B?ZEZUVThGOEp4TmF6cWFIVUJ2dHArbDRNNFZXbEV4dDJtVmhmb0JwL2ZSbWZk?=
 =?utf-8?B?dS9CZDlsM3MveHRscHpuRjBycStxazRVREhtY1YveW9xQzJrOEY2YTBTZzhz?=
 =?utf-8?Q?1xdgVnVRAdBhmXkcM3jlrGocr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662dfb08-3a98-4fd2-40e3-08dbda45b274
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 19:15:08.6942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGi5E4buijhKo05EZd+H6DfIApEn8yiLOhDMip7wHAhBe6ZrWneDkdWUsXMpoJrSIF+r3UE7tShQkdIy/ZvpsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
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

On 10/27/2023 10:42, Alex Deucher wrote:
> AMD dGPUs have integrated FW that runs as soon as the
> device gets power and initializes the board (determines
> the amount of memory, provides configuration details to
> the driver, etc.).  For direct PCIe attached cards this
> happens as soon as power is applied and normally completes
> well before the OS has even started loading.  However, with
> hotpluggable ports like USB4, the driver needs to wait for
> this to complete before initializing the device.
> 
> This normally takes 60-100ms, but could take longer on
> some older boards periodically due to memory training.
> 
> Retry for up to a second.  In the non-hotplug case, there
> should be no change in behavior and this should complete
> on the first try.
> 
> v2: adjust test criteria
> v3: adjust checks for the masks, only enable on removable devices
> v4: skip bif_fb_en check
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 +++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 5f9d75900bfa..9ca4d89352d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -99,6 +99,7 @@
>   MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
>   
>   #define mmRCC_CONFIG_MEMSIZE	0xde3
> +#define mmMP0_SMN_C2PMSG_33	0x16061
>   #define mmMM_INDEX		0x0
>   #define mmMM_INDEX_HI		0x6
>   #define mmMM_DATA		0x1
> @@ -239,8 +240,26 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
>   static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   						 uint8_t *binary)
>   {
> -	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> -	int ret = 0;
> +	uint64_t vram_size;
> +	u32 msg;
> +	int i, ret = 0;
> +
> +	/* It can take up to a second for IFWI init to complete on some dGPUs,
> +	 * but generally it should be in the 60-100ms range.  Normally this starts
> +	 * as soon as the device gets power so by the time the OS loads this has long
> +	 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
> +	 * wait for this to complete.  Once the C2PMSG is updated, we can
> +	 * continue.
> +	 */
> +	if (dev_is_removable(&adev->pdev->dev)) {
> +		for (i = 0; i < 1000; i++) {
> +			msg = RREG32(mmMP0_SMN_C2PMSG_33);
> +			if (msg & 0x80000000)
> +				break;
> +			msleep(1);
> +		}
> +	}
> +	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
>   
>   	if (vram_size) {
>   		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;

