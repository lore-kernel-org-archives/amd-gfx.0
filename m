Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E920DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 18:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7147D6E06B;
	Wed, 24 Nov 2021 18:52:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA5B6E06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 18:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EErCdqykC2tyFw+T9mQ14/bGqI6qfLLulXiMN6OEw2XpczNYMyCDrLOre/+gPvcJyCV9gHEfWEH6pPhHTER+/RCdrR6cSqZNk+3wqNUJ4geS+mQyg4Bhm8w5lY+DpZj/VHqhZaqCCgaXugdX1R9Kjq/ZTYCCNw0QjorouciCv+BuO+Ji5NjfQ26npF8Hfpjmi0r1jCGBpwWRSnqGsyhvp18irVctdjf/LOpW6uwJ1yyxIAVJEPFLM6kMAb7zap0zcThVlpZpyFTawkI1DnS3V/pHi8IpkxDQEohXE32D8XuIu1fCE9mJMJkqpJ3LxANmjVYMU70XMdxpXfvDilmkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLQdtVQdHdUwyUC1PionLFN1UA3iXwedfn1BJ+MS2xc=;
 b=HSlMJvAsncf+qwYIytDZ/ruDqa5koEFu1o0y7sTdzGCbr+T7dQPYSdgt8JWG8G460yFsY6RkPTJz82z/QkSqm+8kycJEZ8xmRqrPyenb/GJMquK3BMv+wq0ufuHBM/Uis5SnMpTAUz2jDrGGjVbRMYEY3TKNLHNajiEhpHq3+qVPx+7Vx1c+iIxCeetQ7MRCotai6sIGYWK2ptnbXGjbKysmrrh0m/h4Iz5FUhRwNzxZd4cwuTMsv276xSWQrWX+5OS4uUMXltz/if9v5WyUh2XhE4vyU02ZpUtHrPW6fgMlrPdpyj0wDbpxbpO5eHY/2yGe0C24ASu6BJufyqiwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLQdtVQdHdUwyUC1PionLFN1UA3iXwedfn1BJ+MS2xc=;
 b=ZEyprXGov9NK8CBTYb6peKEANalKbh1+pRzf6+Dbdqe3FNS4r9pMKy8pCbGu8hHopUcygTeP66IrS8otmIITos7+JOfG9YhqmIj5L2/FY4/2bJH4c5Of9a7b7mzSgYRgUFK8ZlbjwaL4OGWHeT3xJBD4UeQHNfXlP2fXAgpvVBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 18:52:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%5]) with mapi id 15.20.4713.025; Wed, 24 Nov 2021
 18:52:35 +0000
Message-ID: <b110e60d-8f0a-7ce6-5e88-0f7beff66533@amd.com>
Date: Wed, 24 Nov 2021 13:52:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/display: update bios scratch when setting
 backlight
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211124163612.2728640-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211124163612.2728640-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0251.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0251.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:66::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Wed, 24 Nov 2021 18:52:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3476f485-a51a-44ed-17bd-08d9af7b93f0
X-MS-TrafficTypeDiagnostic: CO6PR12MB5428:
X-Microsoft-Antispam-PRVS: <CO6PR12MB542808CF37843B5C62037CA88C619@CO6PR12MB5428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1pjCjwT+TABUpDC2JwHOkiMIrzTfCYTPxdt2YwCeXhXtLIJQvX1uLrsELTO65LAfon1WbFEu2bDAeDnDm2GDIbj0wKRhfW2nFNiPy03lpLm2lejx5srtPNomozmAcQ1Dm3H1x6H1rTCqY/goU+2QUn6YfXvirWp+swbhwhVJrsUx4toDpfRlYnoT/0ebN21ykyLsaLZ2TXF1vb/lMhoWx15GjYHQYiJntSIDy9Ce9058iIQELtuOQqJc2nxsicb24YJf0SO7HaWnitbSYC3OlbP0CPRL5zwdrpp4SsB9UPcxyzuMjS6tvigtVNWiGY7kqv5nv4noW2ZHbygBiNoUW8QyWBU0XWeOWhr31Z+58DGmQKfLOkFPEuh5G1BH4K4AwM+qQgYl3qe+QQuRh3J2JpiZYnAkOzAHXFqNbCEXC951EQig7wj8b/NESLK5zZ13ooIn7TnWGBJTXT3D90k+lV43OR2c5moTwiIwv7b1qbDAFPgJO1TeAtC4Dkbrb3vmsuDvSQ8oed0TPBUI+N0xMPDSof2ih5tCEhY2saIJ4ZPwPDonV8aBS+eYWtsg5gsSGACyVaUAOnKvlit+7dIgS1L7Nxet4MkRaXnFJarc87iJhiC5HKXEMcEu2bm9Ig8DHxpD2bs1ai0+EKe7IjyhYvNbXApRz3yKBSW9VGJNxt0p72AxQz2A6PEwbIXXgCufSeBFVlG0+nAEkyhCpUQfgsZB4tcYb7U5lQXtJuOAyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(38100700002)(86362001)(36756003)(44832011)(508600001)(966005)(16576012)(53546011)(8676002)(316002)(66476007)(4001150100001)(5660300002)(83380400001)(956004)(2616005)(15650500001)(2906002)(26005)(6666004)(8936002)(186003)(66556008)(66946007)(31686004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEp1Rzg1OUJaYXRnakdXSTcweFViUFRxTDBYT202cHl2SW5JdW9lNkpYSDFm?=
 =?utf-8?B?UElJV3YwWkd5Zk5mQUVnM0NxUzEzbmZCbDJ0NmJ3aWg0bXNJN2ZJOWNrZVdx?=
 =?utf-8?B?ZUxJendEcEQ5OWsvTWRYTFhLQ3RCbGZqL3RvZzdDNEFaQ3lkb1pzUFU5a1I0?=
 =?utf-8?B?S1ppRGVUOFRDbkNsMVY3TnBjTlJONkxXVjhGQ0tLcnVOajhwVDFjSWFGcWd3?=
 =?utf-8?B?SEdmYUFwa3pGT3E3ZytScVZuLzc5UXRhZDJaUFpuczREOHB1YWRSemNZblVI?=
 =?utf-8?B?UGlIcVZ3NWhRV0hkRHBOSXNZWExwSW96NThkTEp5VDFycEdRUkdxUm5RbTUv?=
 =?utf-8?B?RXovQmJCWVlVaUxMUDhLTXNNT2VnUCtzZkhyb1VSODd5K0xKTS9vK21uMC9U?=
 =?utf-8?B?Y3BYQmhDTkNDbTMrYjJYV29VbFF0WjBKU2RIbjN1OUt6VWZMV3kxU2pnL0lj?=
 =?utf-8?B?UnhMTjBtSUhTZ1JSdVhIWDFFcmRwMWhEQjJpUk1icVNRV3FwVi81emZrRURr?=
 =?utf-8?B?S2s4S2xBYVh5VncxZFU0Wk1ST25oL2VUL0ZzRzExamVydW5KQ2FJOUdTTWlm?=
 =?utf-8?B?STkyQm1LRlJmQXlSZy82T0RKVzF1UHIrd3l1S1FPcFhTcm9tRGFTS3FWZjlE?=
 =?utf-8?B?WGVCb1BuZW9QR214Q1d5NnZWeDNveEdtcEIyS3hjMFBQdWJhU2RZb1dNMUQr?=
 =?utf-8?B?TndmR1B3ZFRmYTRMbURBUFFvY2VuNSszcGdzbGtrMS85dU1OUjBENE1YTkVj?=
 =?utf-8?B?OUE2Z1JKY0Z5NVpJSi9nRmw3bDg4TFd4N1NDN1F4ZlpoQkhPSEl5eFBJVjlE?=
 =?utf-8?B?T2F3K2o5U1FKYUdlNE5sb2tlamdWeVdjLzhkTm55Vkk4dW9pMHFDbG9uN2xE?=
 =?utf-8?B?VGlEMEpuTHc3UkdVM2VueDN4WGxmRnFJbnBVUVlRVW9zZThxY3huYzNyRkc5?=
 =?utf-8?B?Z1poYXZsTWtyOHNzM21oRGozcHlkOU15dStLd2phK1lUYUNKQkxVSWFmN3do?=
 =?utf-8?B?SjFNc2x5TFRLbG5GZWFmeVk0V3pnZmJDM0hFdlEydldnczYxZ1RxNEFHcjY2?=
 =?utf-8?B?VSt2UlM5bUxZSno0TWdmVUpkUmZCSW5MYUM1Z055Vk9zby9rL3YxZG5ZMmlN?=
 =?utf-8?B?QjUvRVpaRnRaSk9sTWFHN3NubEFBLzdDRTVPalVEcy9ldHBIUFB3UWxjM0Fv?=
 =?utf-8?B?NnFPUGw1Vmo4cFlxcll5T3IyUVdPUjdOWjRZdDhQeDQyK1JST3FZdHVzYm5p?=
 =?utf-8?B?emt2ZVcwRFFiclpLSjZRazlCUEhLMmsxMEU5ZXlPdGhJWEYvWS8vdUVtOHBs?=
 =?utf-8?B?cFRpQmtEcnoxdnY2UmJkZTAya3JrQ3dJM2lJRnJ0UjFXKzVtWFpXTHV6VWdC?=
 =?utf-8?B?OGpQV2FiNWdEcFNFSzR5OUMvS29hVVozR1RSK2I3akIxblhMWkxtNUpzUndE?=
 =?utf-8?B?aFVxeTlVanFIeEsydngxQ2gyRVpNdmF0eVNaUUFNNzAweEVyV3AyWUpiaHNM?=
 =?utf-8?B?bTJEdlBFbTYxaVdjVlNNZ0dnSTFaLzVDTkxUTHBWaERWSjRHWURTMmE2M3pQ?=
 =?utf-8?B?NTVMa3M2R25HVCt2alRZaXlPNWRvWVBlVjFhWU53TmIzQU1lMnh2NVJibmV5?=
 =?utf-8?B?bldzdUdwUUNQOXgxNm4rL01qY2M5NHJmOEdLWm1RNTFvakZwVzlNQlo2bVRB?=
 =?utf-8?B?SVZaS2VRODVPblVEQnlFdy9ocVZhYXpoTytwakg4SC9panp1ZVpsYUlTRzl1?=
 =?utf-8?B?ZE5DQXVmRW90L2R1UFVhTUltb3o0dkdOb0p2R3pTM2ozUGwyYTNOOVJDNVJo?=
 =?utf-8?B?bnljT3BDVWlVWFNhWjJHQkhIQmM1TWUxYk91dzd5cEdROWwxWmRYRkVBclJO?=
 =?utf-8?B?QUZOcUE0aEFWNC92K1Z6ZWFRRCtadDBsRGljWE51enA5ZmluSUJaZkV0Ylln?=
 =?utf-8?B?UmtSSEZGZklhblRWRHQzdFJoeTZrTmxoMk0zT3NWNlcwRkh3eHoyOWoxOHl4?=
 =?utf-8?B?c2JBdk4wMFkwenhuTm1hRjRzcnpzL283aVRNdE9WSlV1eDQ0UHFMQXJST3Ry?=
 =?utf-8?B?UmtqU3VhVEhNWWUrQllOL1QxRmpqNHlub05wWjNud1NoNDExamh6TXR6NFV4?=
 =?utf-8?B?ZmZQMUp5aVYwRWJMa2tKZUx0S1Z6UXNMa0U1MjlSM01Jb2xtSHJTNHl3ZTVN?=
 =?utf-8?Q?rAi1bijAEf3K42kzCUyOKw4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3476f485-a51a-44ed-17bd-08d9af7b93f0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 18:52:35.2029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXOfs/jXXwn/VbLeuEy3S4bFaXOLW9GhpjtyshdRnamQaxlYCGRcECghrHOKC15Z9wmOpasnol2yrCO0mlbmwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
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

On 2021-11-24 11:36, Alex Deucher wrote:
> Update the bios scratch register when updating the backlight
> level.  Some platforms apparently read this scratch register
> and do additional operations in their hotkey handlers.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1518
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Maybe dce_driver_set_backlight should handle this but doing this
in amdgpu also works. I don't know if I have a preference either
way.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c      | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h      |  2 ++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 96b7bb13a2dd..12a6b1c99c93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1569,6 +1569,18 @@ void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
>  	WREG32(adev->bios_scratch_reg_offset + 3, tmp);
>  }
>  
> +void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
> +						      u32 backlight_level)
> +{
> +	u32 tmp = RREG32(adev->bios_scratch_reg_offset + 2);
> +
> +	tmp &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
> +	tmp |= (backlight_level << ATOM_S2_CURRENT_BL_LEVEL_SHIFT) &
> +		ATOM_S2_CURRENT_BL_LEVEL_MASK;
> +
> +	WREG32(adev->bios_scratch_reg_offset + 2, tmp);
> +}
> +
>  bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev)
>  {
>  	u32 tmp = RREG32(adev->bios_scratch_reg_offset + 7);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> index 8cc0222dba19..27e74b1fc260 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> @@ -185,6 +185,8 @@ bool amdgpu_atombios_has_gpu_virtualization_table(struct amdgpu_device *adev);
>  void amdgpu_atombios_scratch_regs_lock(struct amdgpu_device *adev, bool lock);
>  void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
>  					      bool hung);
> +void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
> +						      u32 backlight_level);
>  bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev);
>  
>  void amdgpu_atombios_copy_swap(u8 *dst, u8 *src, u8 num_bytes, bool to_le);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 40a4269770fa..05e4a0952a2b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -51,6 +51,7 @@
>  #include <drm/drm_hdcp.h>
>  #endif
>  #include "amdgpu_pm.h"
> +#include "amdgpu_atombios.h"
>  
>  #include "amd_shared.h"
>  #include "amdgpu_dm_irq.h"
> @@ -3918,6 +3919,9 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>  	caps = dm->backlight_caps[bl_idx];
>  
>  	dm->brightness[bl_idx] = user_brightness;
> +	/* update scratch register */
> +	if (bl_idx == 0)
> +		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
>  	brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
>  	link = (struct dc_link *)dm->backlight_link[bl_idx];
>  
> 

