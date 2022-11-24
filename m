Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30F5C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 16:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1C710E0BC;
	Thu, 24 Nov 2022 16:25:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1095410E0BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 16:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXFyVM5kUqwnUlLOVWhU1PMbxulfC0AMv1y2cKNB83W14xwDyiFZ/CAofyA3T+LivIXWioQLe3C8mhM3TYSCPKE7ujVVkAltIi2orsZC8KDTZiQ8IrBq+h2YHzqyz+yH8K+I3xxT5Htt6dcX8BOkd3Lp/DC8Dxz4vEwzqn+u3mARW9GC885Uj0RKZSPDJJ6U2t23Ff054n6T5Jk0zc9j2h5TOroOSR3XqhfNSO78FxvHeh5BNSPVkvOAg04UAj5iMUw95jlLc1lG4WSSrG1m/DULF8zqiS8vn5ZsT61p75npbxh2gOs1F7HwuPs0KQKZNN6YnuT418XKlIza5NWvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifZuxKvRiMmf4Q3QxqHluhfUThs5KyCe6eyCl1f2i84=;
 b=IBN5hJ5A4hiZYo5XuQKcU8fb19AY1tLgmxY1CqSnQXPaMSpADZvNNc9cxwq/2wQX8k/9GCF5DlfsQfjzNoApe5BCuAsBfvgo507GI0YRlZnURrS8sFh8Yz00S7uYowApEn8Z9jCAOEUayhz7kXKvWAgHFcSrMI/v+Y7Aw2aP66vsB1SdiBkVXCk3hFSgx4unC/1rpYdKpiW5gzg4/GYaC8s/6svg9TbBDrE/YTfQ86z/wav9s6z6Xb23zatviiW3lo6KoT0PvZDUG5uSzXRhk4TA8TsBq6uB/gabCyHSdwtHbtBvM1hNRwUcan/IoMhZHriRQXcmYLQY6XpMlCem1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifZuxKvRiMmf4Q3QxqHluhfUThs5KyCe6eyCl1f2i84=;
 b=mWTDaS+F5DWF1ViTOAx/TyAEvcD35gfmyiwNLvWx+wjQdkUeRlWq5lC9NSFfoiKNPm3wxxoinX8bGFk+v+Kdy96rZ9myy8qCMeMd5ke9bNryzkY+8Sub/FzL8AkT3Dc347R2XHK8etF5o6HUQAuCxYRLWq1YNUV9EWGkiDkOjjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 16:25:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 16:25:08 +0000
Message-ID: <c8ee9e71-459a-89b4-2cb6-d447fd608f44@amd.com>
Date: Thu, 24 Nov 2022 11:25:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 07/29] drm/amdgpu: add gfx9.4.1 hw debug mode enable and
 disable calls
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-7-jonathan.kim@amd.com>
 <0e6d5813-7031-451d-be18-da08f6632530@amd.com>
 <CY8PR12MB7435EA10BED86766770CB5A3850F9@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CY8PR12MB7435EA10BED86766770CB5A3850F9@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0017.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: dd918552-a57d-49c6-18e6-08dace38738f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGEMMP8H/hI1LhUzrqsK4dZp6fUEQ5M7Fk7YGAqUstPHY1VZlaLxSYQ54WHY39n6r1rvSa7mGwMdaPMxIw55KADDQ4k6KyZMfWs3SYTSAvjRvsQz4Hu/Cx//P14/9ByMIlUfeSwszqbXrn0wU/GIlVsg2rJ5c8R1asloIcSIhxwNa3FQ+CJQHmBWZWGf1auXCW7lI7VQvsrpuJXcchI5OtxdvVtIIiT8T15r/ZX62E/x8yLZZ18GN39l0UhpmPAv1rkdJa0SZ302VoF+phOh41lsgWwkMCDet+RBE2zfKvgTbj7UKbHmTmqn0Vcp+v5fmol9L/sP0d2/g4bLM+lL0ZPWWmjWONjjLePMyqvaXMoHKfWwykjHCZb3Z/rQ9syniHEOOAhvY1vXySsKSN8KzZppuRHIfqL/zDgVjcYzaxa845pimxdF8bs3bDuaRaIDqtP4QXmJ6BdQ5muwzBtlEQ8JWiZr+QqBIm3pYeOJj5eOELeHMcPJaWCTAqI7MRX2+Lz28+hEyRzGuAqgMsTdAeWIWxHEcZwBpSXJKT6vbgGMsR82mCH+zEomODs/kqgwU5KBHiJp4wHRU1YiCFtLacoxZxqr3GZ+BNhIqpqs3Afzda+SoQSsk3637pmEnaox7JAzqTQKegiLDxBlHyIapWc5o40PnPwzUN0shomsPaDVggoVD0Gp4VxW4Eu2t4h8ZgcxECKgzcXuC/VTowa8pSORUyD19U24RKC4AaITiRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(6512007)(26005)(36756003)(31686004)(110136005)(38100700002)(41300700001)(8676002)(66556008)(66476007)(66946007)(86362001)(31696002)(6506007)(186003)(2616005)(53546011)(478600001)(6486002)(44832011)(8936002)(316002)(4001150100001)(2906002)(83380400001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTcrTExkKzRwNTVpd2x2empQYVJvR2xXZ1FBdTJsUDNNcGhPTmFlcXRyWVRi?=
 =?utf-8?B?Qnd6SlpZTmFEVXc3V0ZNbGoxdmRNNjE4TUw3cGs2R0NhWjFCTURPVGx0WUZj?=
 =?utf-8?B?STJoejVReDhaNjVQZm1BcjBreFFXZ29Jdm9TV2V6aE9LVnBVWUJSeUNBNkxC?=
 =?utf-8?B?a1Z1K296SktNSFJpTVpRUVdLeFhPVEg4cFpHaTFmYkI0TXc0eWtVTE9iZnhj?=
 =?utf-8?B?S2JsS2NyTzQ5ZEM3TkhNSVYrNFNKcW03NTd6N1U0Y0lXOUZESk9EVVlHUFBG?=
 =?utf-8?B?ZXBqRTVEWGxVL3VZcEtZQ0EydWpRL2pPQkJHN1ZuTW1zbWI0ZHJPb1JSc2pW?=
 =?utf-8?B?M2tuWGsva0gyTkpjNVpQL0NLMUhEQ0pnaXBMM01hLy9KeFBaSm5FOFBOU0NN?=
 =?utf-8?B?Z2phdFA1akRSeVJ5VzhDZ3JPNzVYZDZtOElKeEVjdHhYUkxiWHJlL0pZMkp5?=
 =?utf-8?B?eDJJRDJkbFo0RWlIUG51c3d1T3loNWhKSm5QTnpBRWM4NitKK0FIbytWZFQr?=
 =?utf-8?B?UlZQY0RobHUrdTdwbThqaGkvb2xrYkJQU0dVYnM1U3o5MVRYd3Yrb1RwN1F5?=
 =?utf-8?B?aWVXcENDWmFBdk5qamRMUys2YWRCOWM2TzNKUnQ0anA3Z21WQ2pITUszMW1h?=
 =?utf-8?B?Y21PcXJNYzdjR1ZzWG1vWVM3VFFObGtIWjVleGk5RCtXQnF2dUNVSmZCTXdl?=
 =?utf-8?B?VG9nM2ZDZklvdmROM2w3bHprVk1tOUx1dndrUjYzVFpHUzU0RUNRL25kNVdK?=
 =?utf-8?B?ZVJPRGMvYzVRWDhncnNSc1cyZVVDTDlMTEhyZE9hdjZXUXVWbk9ka2hzUytM?=
 =?utf-8?B?SVVJc3U5cWNDcmJLaHZIZkxYQk5qeGUwYWYzUllLQ3ZTRmNUd1crc3c2b1VJ?=
 =?utf-8?B?K21vRFZ1eHBRNjRuNlkzbDE4YjFZb1V4b1E4YmhOajNEbEVoYUxwOEFvWVMz?=
 =?utf-8?B?cmhDSWRtTlpsTmJkcGFaR2daTjdYUFFPQkI1OHNxUkxJNVUrNkJLRGNFOUUw?=
 =?utf-8?B?YllKa0Ric2hsbVFUTlhhblRaTVpGZUQ2aG1IQXh0T0w1OXNZKzlFTkRwMHJU?=
 =?utf-8?B?N2VSSlBXWlF4bGJvV0N6c2dodEJuc085RDk4dTZqMkFpME1yaXNkZjNFTlVK?=
 =?utf-8?B?S2hBZTRMY3pwY1FOVms0TEppcTF6TGpXazFWb3BBR0lCcFQyREVxeTljWUVZ?=
 =?utf-8?B?Qk91YjhNbWo5QUozR1BIQkRmZGtVOXVDRkFuYTVQR25hVjVYQXJIMHVGWE81?=
 =?utf-8?B?Wm5PNVROZVJPeS9nMS8ybUNDTzBVcUZjZHA0UzhaSUxkZXBqai9NT3EycHZI?=
 =?utf-8?B?ZDJYcVg0TUUrelNoMVo5eXRMOEhiYUJvTnRXM1Nsa2g3eG5QVzRaem4vWjRi?=
 =?utf-8?B?a1NYU2x0WXpCVzB0QmJHaE12QkdRTFNGU0ZrRUo5Ny9iQVloNXR4TStrZkxu?=
 =?utf-8?B?bjJ2cGFlaW9xVmJuZ3NWVTYwWUpXd0JWaWRCTnlnclVRSWpScS9scFBjUDVL?=
 =?utf-8?B?RG8yMmlmRHZlTDV1d2V2ZmhkTURJVFluOFRhVDlFbnE1TWp6dEdWRFZQcElT?=
 =?utf-8?B?azRacGlObGxPU01XQS92L1o5cFhIbUx1WlVrVStiNFVneFZCM0tKTEhFNnJj?=
 =?utf-8?B?S0puYmpwTVh5R2Z6Z0F6UUlDSTBWamwzNVhGQitpRFZBUklWenBZUFBLcVEw?=
 =?utf-8?B?ZW9Zd1BDOGhGV1dOSHFnalR2T3Fzdkloankxd042dTBrSVczNy9SS0k2WkR2?=
 =?utf-8?B?R3htRkFuVXRFT2hPa0QwY1JBVlEzRHUxNnhoNXZoNDF2eTR4dHB4d0VaYWVV?=
 =?utf-8?B?NTV3eGYrcmEzUXBEaHJ0bzBKelNhRjJYWWI0Tm5HMWlIZlZGMlRBQWp0cFhM?=
 =?utf-8?B?M2Z4c2cxS0duWnM1dElpR21PQUVqVEdUaDhvQzhHMndhWEx3eW1KTHJjNlps?=
 =?utf-8?B?ZUhFdjRsc3pmcUFwdTJ1VFZNMmdoTXkrUWVhVDFUTWFEbW5iTDVSSnVobUpF?=
 =?utf-8?B?VVFiYlQxT01ZcDBYc2UyUmhrdFhxd1ZKL3hLOVpZd25nTUY0eWhyNjFkWGtz?=
 =?utf-8?B?SjR6aUN1SDJnU2hDbTVHOFBWdnZ2YnI0dUdSeUNBTE4wdU9OcGUvaG1DNHRa?=
 =?utf-8?Q?2tBDZiqeCoKxLRyrwquMykJJJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd918552-a57d-49c6-18e6-08dace38738f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 16:25:07.9689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4x+6PKG6fjw5EmVid1N/QzohB65zRHDqflJsRKBXtADp2+5StGNBWKDtNgO/9xYMEKlihP+oWgDCbU8f+2wmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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

Am 2022-11-24 um 09:58 schrieb Kim, Jonathan:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: November 22, 2022 6:59 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 07/29] drm/amdgpu: add gfx9.4.1 hw debug mode
>> enable and disable calls
>>
>>
>> On 2022-10-31 12:23, Jonathan Kim wrote:
>>> On GFX9.4.1, the implicit wait count instruction on s_barrier is
>>> disabled by default in the driver during normal operation for
>>> performance requirements.
>>>
>>> There is a hardware bug in GFX9.4.1 where if the implicit wait count
>>> instruction after an s_barrier instruction is disabled, any wave that
>>> hits an exception may step over the s_barrier when returning from the
>>> trap handler with the barrier logic having no ability to be
>>> aware of this, thereby causing other waves to wait at the barrier
>>> indefinitely resulting in a shader hang.  This bug has been corrected
>>> for GFX9.4.2 and onward.
>>>
>>> Since the debugger subscribes to hardware exceptions, in order to avoid
>>> this bug, the debugger must enable implicit wait count on s_barrier
>>> for a debug session and disable it on detach.
>>>
>>> In order to change this setting in the in the device global SQ_CONFIG
>>> register, the GFX pipeline must be idle.  GFX9.4.1 as a compute device
>>> will either dispatch work through the compute ring buffers used for
>>> image post processing or through the hardware scheduler by the KFD.
>>>
>>> Have the KGD suspend and drain the compute ring buffer, then suspend
>> the
>>> hardware scheduler and block any future KFD process job requests before
>>> changing the implicit wait count setting.  Once set, resume all work.
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>>>    .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 105
>> +++++++++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   4 +-
>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
>>>    4 files changed, 110 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 0e6ddf05c23c..9f2499f52d2c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1034,6 +1034,9 @@ struct amdgpu_device {
>>>      struct pci_saved_state          *pci_state;
>>>      pci_channel_state_t             pci_channel_state;
>>>
>>> +   /* Track auto wait count on s_barrier settings */
>>> +   bool                            barrier_has_auto_waitcnt;
>>> +
>>>      struct amdgpu_reset_control     *reset_cntl;
>>>      uint32_t
>> ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>>> index 4191af5a3f13..13f02a0aa828 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>>> @@ -26,6 +26,7 @@
>>>    #include "amdgpu.h"
>>>    #include "amdgpu_amdkfd.h"
>>>    #include "amdgpu_amdkfd_arcturus.h"
>>> +#include "amdgpu_reset.h"
>>>    #include "sdma0/sdma0_4_2_2_offset.h"
>>>    #include "sdma0/sdma0_4_2_2_sh_mask.h"
>>>    #include "sdma1/sdma1_4_2_2_offset.h"
>>> @@ -48,6 +49,8 @@
>>>    #include "amdgpu_amdkfd_gfx_v9.h"
>>>    #include "gfxhub_v1_0.h"
>>>    #include "mmhub_v9_4.h"
>>> +#include "gc/gc_9_0_offset.h"
>>> +#include "gc/gc_9_0_sh_mask.h"
>>>
>>>    #define HQD_N_REGS 56
>>>    #define DUMP_REG(addr) do {                               \
>>> @@ -276,6 +279,104 @@ int kgd_arcturus_hqd_sdma_destroy(struct
>> amdgpu_device *adev, void *mqd,
>>>      return 0;
>>>    }
>>>
>>> +/*
>>> + * Helper used to suspend/resume gfx pipe for image post process work
>> to set
>>> + * barrier behaviour.
>>> + */
>>> +static int suspend_resume_compute_scheduler(struct amdgpu_device
>> *adev, bool suspend)
>>> +{
>>> +   int i, r = 0;
>>> +
>>> +   for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>>> +           struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
>>> +
>>> +           if (!(ring && ring->sched.thread))
>>> +                   continue;
>>> +
>>> +           /* stop secheduler and drain ring. */
>>> +           if (suspend) {
>>> +                   drm_sched_stop(&ring->sched, NULL);
>>> +                   r = amdgpu_fence_wait_empty(ring);
>>> +                   if (r)
>>> +                           goto out;
>>> +           } else {
>>> +                   drm_sched_start(&ring->sched, false);
>>> +           }
>>> +   }
>>> +
>>> +out:
>>> +   /* return on resume or failure to drain rings. */
>>> +   if (!suspend || r)
>>> +           return r;
>>> +
>>> +   return amdgpu_device_ip_wait_for_idle(adev, GC_HWIP);
>>> +}
>>> +
>>> +static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, bool
>> enable_waitcnt)
>>> +{
>>> +   uint32_t data;
>>> +
>>> +   WRITE_ONCE(adev->barrier_has_auto_waitcnt, enable_waitcnt);
>>> +
>>> +   if (!down_read_trylock(&adev->reset_domain->sem))
>>> +           return;
>>> +
>>> +   amdgpu_amdkfd_suspend(adev, false);
>>> +
>>> +   if (suspend_resume_compute_scheduler(adev, true))
>>> +           goto out;
>>> +
>>> +   data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CONFIG));
>>> +   data = REG_SET_FIELD(data, SQ_CONFIG,
>> DISABLE_BARRIER_WAITCNT,
>>> +                                           enable_waitcnt ? 0 : 1);
>>> +   WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CONFIG), data);
>>> +
>>> +out:
>>> +   suspend_resume_compute_scheduler(adev, false);
>>> +
>>> +   amdgpu_amdkfd_resume(adev, false);
>>> +
>>> +   up_read(&adev->reset_domain->sem);
>>> +}
>>> +
>>> +static uint32_t kgd_arcturus_enable_debug_trap(struct amdgpu_device
>> *adev,
>>> +                           bool restore_dbg_registers,
>>> +                           uint32_t vmid)
>>> +{
>>> +   mutex_lock(&adev->grbm_idx_mutex);
>>> +
>>> +   kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
>>> +
>>> +   set_barrier_auto_waitcnt(adev, true);
>>> +
>>> +   WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK),
>> 0);
>>> +
>>> +   kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
>>> +
>>> +   mutex_unlock(&adev->grbm_idx_mutex);
>>> +
>>> +   return 0;
>>> +}
>>> +
>>> +static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device
>> *adev,
>>> +                                   bool keep_trap_enabled,
>>> +                                   uint32_t vmid)
>>> +{
>>> +
>>> +   mutex_lock(&adev->grbm_idx_mutex);
>>> +
>>> +   kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
>>> +
>>> +   set_barrier_auto_waitcnt(adev, false);
>>> +
>>> +   WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK),
>> 0);
>>> +
>>> +   kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
>>> +
>>> +   mutex_unlock(&adev->grbm_idx_mutex);
>>> +
>>> +   return 0;
>>> +}
>>>    const struct kfd2kgd_calls arcturus_kfd2kgd = {
>>>      .program_sh_mem_settings =
>> kgd_gfx_v9_program_sh_mem_settings,
>>>      .set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
>>> @@ -294,6 +395,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>>>
>>        kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>>>      .set_vm_context_page_table_base =
>>>
>>        kgd_gfx_v9_set_vm_context_page_table_base,
>>> +   .enable_debug_trap = kgd_arcturus_enable_debug_trap,
>>> +   .disable_debug_trap = kgd_arcturus_disable_debug_trap,
>>>      .get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
>>> -   .program_trap_handler_settings =
>> kgd_gfx_v9_program_trap_handler_settings
>>> +   .program_trap_handler_settings =
>> kgd_gfx_v9_program_trap_handler_settings,
>>>    };
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index a0e5ad342f13..8ed1b5d255f7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -2424,8 +2424,8 @@ static void gfx_v9_0_init_sq_config(struct
>> amdgpu_device *adev)
>>>      switch (adev->ip_versions[GC_HWIP][0]) {
>>>      case IP_VERSION(9, 4, 1):
>>>              tmp = RREG32_SOC15(GC, 0, mmSQ_CONFIG);
>>> -           tmp = REG_SET_FIELD(tmp, SQ_CONFIG,
>>> -                                   DISABLE_BARRIER_WAITCNT, 1);
>>> +           tmp = REG_SET_FIELD(tmp, SQ_CONFIG,
>> DISABLE_BARRIER_WAITCNT,
>>> +                           READ_ONCE(adev-
>>> barrier_has_auto_waitcnt) ? 0 : 1);
>>>              WREG32_SOC15(GC, 0, mmSQ_CONFIG, tmp);
>>>              break;
>>>      default:
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 56ad38fcd26e..efb81ccef8f5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1946,7 +1946,7 @@ void kfd_suspend_all_processes(void)
>>>      WARN(debug_evictions, "Evicting all processes");
>>>      hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>              cancel_delayed_work_sync(&p->eviction_work);
>>> -           cancel_delayed_work_sync(&p->restore_work);
>>> +           flush_delayed_work(&p->restore_work);
>> This looks like a sneak bug fix. Should this be a separate patch
>> independent of this path series?
> Ok.  That should probably be fixed in general.
> Back-to-back KFD suspends/resume calls can result in asymmetrical evictions and restores if scheduled restores are cancelled on suspend.
> The bug just happens to get surfaced for mGPU GFX9.4.1 debugging, because debug attach forces that scenario.
> I can send this out as a separate fix that's not related to this series.

I agree.

Thanks,
   Felix


>
> Thanks,
>
> Jon
>
>
>> Regards,
>>     Felix
>>
>>
>>>              if (kfd_process_evict_queues(p,
>> KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>>>                      pr_err("Failed to suspend process 0x%x\n", p-
>>> pasid);
