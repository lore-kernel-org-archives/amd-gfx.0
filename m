Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153DCC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9799910E265;
	Thu, 30 Jun 2022 18:24:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A446110E265
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBJE2VLJNmptYgqrEQTL3gTj5K/dcKRf8r7xcEfu3XwyGOhkHs4TaFAqswtn8G20koG8NAKam3at1E5alRxj3JjJzDiDoYvJnuYom3l+GIPskzX/OdCFhsapGjFV4tmV9UFaPKsi4BYJrTHit/9+A1SjHGZtNsUsa8lmZzi4dduAZf+h1o6W4N1g8dYLpQ3/X/4TqNDPrNh1qd0T46NCHQasC95UP2sPbHrj+CgSbNCE3IyvT+ijBtG+W5qF7RkcfeLpWNQtHUVfG8+Q/XpZrsb/nJtOPHM2/SaWu3qZOUtruPTJ3jbB9oFptTxKutybo97sASNVvcC3lurFDJkXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1/3DHMh0G4zsbM4wlR9eORtGifilroA8cc/sTSPM0k=;
 b=b+dkxg8SQb4DtM2pbZr1TWpJ075o5W53LAk+usCXIMvaSfZt6YYHwoTPqpSAoraS4XArBGNInAn4VAEb/6jEf5XY+V6NvE+GrHg2OgtPlGMfAM75oYl1fhPuGfWBRmfkEu8AX2GQ00sOfPgdXhlrK2U9Wm5K74WAXAzIt6tR4Pflu2kEalYEGdetEo1NO7BoBpcL2gdCiYAYKrdPf1YmaYq1Dy6nIBf5RZI23eU4ijT6kFhGMMJXvC+d0F60tOgYWEcAZHQP6ac/8C0NrtvFcWSwb6F99o0H7AVpGBrFgrJDV0OUBypWj4MRoPKmLZf1ePNRY1DH3q3z9yve6rfS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1/3DHMh0G4zsbM4wlR9eORtGifilroA8cc/sTSPM0k=;
 b=ZbonsMK9l99ggov21avJ71DFrKwfY8r7yAF+GBRfi7h7x2wpsUs0Hxqg+1euzUU/TCCYAElsAhL5m1ez4Q9EyRHoLlff6/i9yjWwW3PldpKLZraOW6fpS5h17dauSMX9oi7PRW7L7kEWZ/C7R9lp3SdR4jW+xW3W4LrxdIWuCOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Thu, 30 Jun 2022 18:24:40 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 18:24:40 +0000
Message-ID: <fbe5588e-751f-1753-5a85-00b82318cb91@amd.com>
Date: Thu, 30 Jun 2022 14:24:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/amd: Add debug mask for subviewport mclk switch
Content-Language: en-US
To: alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org
References: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:208:329::8) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b1af09d-13a1-4ea1-d824-08da5ac5cc12
X-MS-TrafficTypeDiagnostic: DS7PR12MB5887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PM/BEJOUMkU1z1wQ0wgkIcxh3CgQEpdS+m7mRm09XUctb8D7LVgnwabzw1i3IV1awyv3hUDtobyiQpMR6Bx3apZKv2eM018xL0FUMDsIsQ9MKQL/tk+4BzsMFFob/7iX5Wv0YhQ7gegZ7cCckFgRMsA9W44FHlFbONGcrwQAypxZ51Tu/HXUD8OaP3ZLRkGeR6QjuMximIlP5PAqaZ36I+JMGbxom01MrM5TOvrnjnikrLP3kd/e7UQi+dxJXSoZf7NsTtQ8gv8lUcYhjA1KPnhR7NjYfVfDjhPIe9ieAjWoRoP9AXNao38METFYxKPmlY+dutaqhae0TLEU9lAHYKGnRPkANaRlMDfUG/BWfGViki9/B2g1AiCF7pzQFxlZjUcS2t5WWHYS0dBWEQ4yziY7AAWwOZwuUtn78YceUFYiVRgV2rLnx44APllchI3efzVAI11ZgRjoZmWtOX2aAbV+yh/a0ai/XAzl0vspB81MpOGK/Q02Fa1nsnleAIoZgv1eeh2r8BdigyMlg895PanRtNBtS0K78oymQYl1dnMVRgAkgdM5MDsl1BJQUWidHXnwpobW+fFwmf3pYzBRS3/+MmATiq2ktGJF2pjTSnTfpnkM6J8KJhqUte7A26yd2w8m0tNenMRE1A9aSyvK8z/rcwC1e4xpnQhjvD8RtdjeCJ9v+PnnmpcE0Lm1UrlWmoyxglH6mZp1C2QmW82briEM5u5p0Fr47YsMH3O9EaZGv8A2j2JlyxNj8IyLYAGMgtAJeqxEZllxDroGs7KcdMb1N/KOi8BtdQlMquKaTYDQbu1cCneDXpjr6361hYfQkufznZqzpg4pyO5zBrEwKSpSup6lr2bEWuG1vFaokBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(2906002)(41300700001)(44832011)(6506007)(86362001)(53546011)(36756003)(316002)(38100700002)(31686004)(31696002)(478600001)(186003)(5660300002)(6486002)(83380400001)(4326008)(8676002)(8936002)(2616005)(66556008)(6512007)(26005)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2swSVlzdFRsQzYvK3ZtOGN2WkZ0ZVc0TFA1MVp4OUtBRGhmUGlhQmZVZnRa?=
 =?utf-8?B?by9VZWtUUUZOaG0rN0tQL3JxOE1WcjdkWVZCMG80RmxGQkR3RUZGUE5UM0Q1?=
 =?utf-8?B?T2MzeGFuU3BDcGhyaHlhY0ZJMnBxVUlrMHBpRXZGUnNUUzNib2ZyVHVTWmti?=
 =?utf-8?B?dFlEYVoxT0I2UFdaVzIzaVRUbFdkV25sRVd1ZGFLSWlpVCtlb1JzWFVoVDJo?=
 =?utf-8?B?Zm44eThKdGJsRis3QThnQlp2Zzhkak15NWFRN2V1VGxRLzY5ZHNtMmVibktX?=
 =?utf-8?B?bjBtcFpqYUFoR0NaYi9yNVQranVuTGxacldNODN1cUh2elExR2VSWlZncm15?=
 =?utf-8?B?OUJoT2JpQ1g4YllobUFqeHZmNS9DR3VyTy9ycDVGb0JHWFF2V21iZzFXRitu?=
 =?utf-8?B?eGRsNU1YVE1SV09QQ1pEQjNSYUdoTXdCcmlSR05GM0VSZ0E5YURabXkvOUQv?=
 =?utf-8?B?YTR1N0k3YzkrMDd4bkw4Wlh6Z3FxcVRrNFdXSmROQVc5TU43V2xDMVFUTUxl?=
 =?utf-8?B?ZFdFc1ZET1B4SkJ0cUtyOG9wbncrbnZKYkVPOUwzdzJKalF2ZmlBNFR3S1ZJ?=
 =?utf-8?B?NndZTW10TUUxcXgvZmlkcmJCbFExVFNZczBkdWtSNVB2am5PVnNQZzFKS1hZ?=
 =?utf-8?B?Ukd5bU5vZlgvVTdyVThMSVpLMkRkMVR5TWN4ekl6cE1qNWVmeGR1QlEzNUdF?=
 =?utf-8?B?bnUyelBQVkVRZDB4QWR2UDl4U1AyWUVDa2E4aGFqbjA2b0NEZDE1ZEorNWZE?=
 =?utf-8?B?TllDd2ZZRlkxYU93cWtlS3pUTnE4LzdIbkYyd0lsdnVzOVN0QXNHL1duN0h0?=
 =?utf-8?B?VndCejdRMFlHUXcwWnpQSFJsZnNaQlZWZnNMa1FTYmJZRzN6azA5dWI2NklG?=
 =?utf-8?B?Z0RORktzcUtkdHdsdkRiR2UrNjFjeEU3dFAvZ3o0UXErRGQ2ZS95elkxTU5s?=
 =?utf-8?B?V3hGa0xVVzYySjZjSW83L2QvMlpWZlgydUVQZEJ4MDZRNTJBclVBd3V4QmFu?=
 =?utf-8?B?RzZTc1M5VnFvWGFiTHQ5NUdJUWVtaHg3dElQRG1hMmNmbHNKY3VOQ0VBUndo?=
 =?utf-8?B?aDkrL253NVhzSmdzRUYzUlAyMk9Ma0dTcG5pUjFTaTdGUkhpNXFUVGNlK01t?=
 =?utf-8?B?VFU0dEdML3JrNnRudEp0TTFvdXFlVFQzV2ZEZ2hNQWQ1akhBK2FqVmJsODVO?=
 =?utf-8?B?bURMTlREYlIwZnVxQ2RzQzZzT0s5WjR6VjlOVlRGcllrUFNscVNIcTBqYWJQ?=
 =?utf-8?B?YWNEdHprQUt5MWxlTGhZWVQyQ21mZkVSMVN4d3U0bG9VOFpVdEpzV2lUcVVD?=
 =?utf-8?B?b0JTd1M3Rks2U2gyQ1E5N0luczE5Mmk4VmN2RTBoenVVRTVSc1ZxVG5lN1RQ?=
 =?utf-8?B?THJ6VVRWTXFTMXFBYzlBQ2Faa0Q1a1dnT3U2RlBCVGVNelF3ZDcxOHJSV01J?=
 =?utf-8?B?Q2ZxOEdTN05JZ2tKSXZnNEFDRGVkTnJtOVdtTWFVRzFZdm5tN2VtYVp2L1JW?=
 =?utf-8?B?M2dPbTllQ01EejJZNEUwVjlhVEQ3L3RRQmljMkgwZFg4bS9OSG5Ga2l2cFNU?=
 =?utf-8?B?dmF1aTVyVXRCNEQ5bC9aR1NONEdGWmpWS3hENTNYZmNxQkROMm13T2l3cytS?=
 =?utf-8?B?SGsrY0s2NE04WXNGNEluczk3SDF4Q3dGTXJvYTZkTmpGSjM3alMzekpKblZS?=
 =?utf-8?B?NGszSFMwYjd0OU9XbW9FUmdkSnJGUUNVVVRBR25BdlNaTG00THB6OFg0V2w2?=
 =?utf-8?B?eTJRbmgySUlzNlhBYU9YYW9TdEc0WThGeWduZ3ZHSjVsRE9iWGpzblJiTTlj?=
 =?utf-8?B?c1VORTNJRG5TWlpmM3A0MHZoTCtBY2tSeFpUaVlhZE9lTXlwbW11UEx2d1FC?=
 =?utf-8?B?QTJ3b0ZVR3VsOWRSV3l4NDN3M0R3ZjlLbW1YTHpIclR6R2VPaU1QLzU4Rllo?=
 =?utf-8?B?VG5rZmhJZHZhV21nMVI2NkxINGdTaUdIaGRnQjBrT01sL2V2NFcwVkFzdzdz?=
 =?utf-8?B?bXpxbmVXc1dKRGlPL3M2Vjh6L3dFb3RteW16MVBWYjFmc3VqcTZpSk1qSkdy?=
 =?utf-8?B?Y1laYXlhNXQ0b1AxQ29XVmFTVlFjVkFmWVJqbUs0SG45Q3BCRHNwRnZvMWJq?=
 =?utf-8?Q?o0eh95vx1dHdcidJzZME/e8Tn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1af09d-13a1-4ea1-d824-08da5ac5cc12
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:24:40.7690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpPmXkLgvhBtIn08MywgzLrhQJoLrFWMXzi3weVLBFK2OXCWUZQEtrnhFLVV6573cgQY1KR3C2GkLSxxGIIDfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping

On 2022-06-28 17:26, Aurabindo Pillai wrote:
> [Why&How]
> Expose a new debugfs enum to force a subviewport memory clock switch
> to facilitate easy testing.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>   drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c9145864ed2b..7a034ca95be2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1559,6 +1559,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
>   		adev->dm.dc->debug.disable_clock_gate = true;
>   
> +	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
> +		adev->dm.dc->debug.force_subvp_mclk_switch = true;
> +
>   	r = dm_dmub_hw_init(adev);
>   	if (r) {
>   		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index bcdf7453a403..b1c55dd7b498 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -247,6 +247,7 @@ enum DC_DEBUG_MASK {
>   	DC_DISABLE_DSC = 0x4,
>   	DC_DISABLE_CLOCK_GATING = 0x8,
>   	DC_DISABLE_PSR = 0x10,
> +	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>   };
>   
>   enum amd_dpm_forced_level;
