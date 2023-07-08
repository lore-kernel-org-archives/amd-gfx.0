Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE115EB64D9
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jul 2023 00:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A8310E632;
	Sat,  8 Jul 2023 00:25:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2C610E632
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jul 2023 00:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtrOJhLCqvyV2NYuB+qct48x+rLMFmRY3ArGxBpCTToDc8FRi+1adGq8/VNxeceMr4WTmYzErV9EFlBhZokTZWsYvjP5OpaoVL0/0KrIHrxPruSvMV3eiZ3wMypepV8nRtS2qYTW4fzT6Cc7aW297qNAM32k81mvGVvBt8SUJrqbT/FLyB52SXbsuSrvwgvAIvZA5QimmBKK1VyZtFzFFoHu9Ih0TuJqv5ckQnQtsZFJprlRMgH4Mb+pg7uTCbUYES5f2CnNOfLNgxxGGAKXY576IVpfQJjnS1CUGUdYTBQwxwIGHtyPdHIquuoi3ZSzHPaQdsX/pG1sGG11GyIvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJMnmiSmQTk2qVHmi0fjKNs3O6JrEM+oya7l8/OVjIA=;
 b=XdzYg2h+LH1xyfNyHmpoSps/TNdHBptd/bvKWoJdEc/3sNlUf4Tycl5I/foIBWclwEj1Bo+TebrsUXuZysESTUkFk1DIMHig7NW/PopWoajKzBYyNg0jsKxz92O6/jqQBFJpB0vmjj52rkjzC7fX1sa+Y4SvBH/YHhwDSzJdp8bYK+AlzQNVMeKKXc/3C2wI7NM26+ET4JOwR1jVVpxP0+vCddrrkMPS7v7w7kvctr/gUTv8sTTlzSaFlZNaLGrW8gZSbEWGDhdt47pNLIx8QyyO1x705KjAOB3pCI7E7+V2b2I6u21i5wMy2qaRCz3a34R/Fr/etKjb1GUIl22ClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJMnmiSmQTk2qVHmi0fjKNs3O6JrEM+oya7l8/OVjIA=;
 b=BIJxEgFdrPqGYmSU3JaYNoEFzmeJ3coomyST8JvfhBGSVzHPo+ATPfbfhs1NzGShdipWBuA+yTYpAYwi2wBLG+U0UrFDviuQi6wb1Ru0tH4L3rFOZ1kz1+ZwsFqZmS+OadN9Hoy6ojNOjTnTfgZLHZk7trX8ivO0meHn08iLtfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 00:25:14 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d798:c26b:8d50:aa2c]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d798:c26b:8d50:aa2c%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 00:25:13 +0000
Content-Type: multipart/alternative;
 boundary="------------Gg2otEp00RvUB12JkuHMXtVq"
Message-ID: <12373fb9-a6bd-908d-b37c-1a583da4d576@amd.com>
Date: Fri, 7 Jul 2023 20:25:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks for GC
 v9.4.3
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230707174648.146441-1-jinhuieric.huang@amd.com>
 <20230707174648.146441-2-jinhuieric.huang@amd.com>
 <CY8PR12MB7435CB35A4EED90C5DADDA3E852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CY8PR12MB7435CB35A4EED90C5DADDA3E852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA0PR11CA0114.namprd11.prod.outlook.com
 (2603:10b6:806:d1::29) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a35ef88-286f-4f06-7d72-08db7f49cba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJp6x/sy/JNClJLdzCDOUg0mIVM81ZXbjepiOtsfojjR3ceC9vtkktoDEhUeWJld3pPk2WEYEUG5IWmxBDuqyNoG4CH16vGvfE04XqkwfCzJL4ujI8Sl/IsB2ZOt91MHfrUQ9mkXcaq0zncyyfS12HDkOL9MdsfVsT4W2Uqz0jm9Sg49K5EDsLG/549tuGK6wyFezi/ATsHNx9pMnxqF1yB6ndIHmB0hBuQuj1hGZEpu0Z/nRj72SmBOtPBbLWykzkIQLkiFWHU1xz1PiAwQsDGWiUl4mrbo24HE8sJ+tmpHH7GgFjtDTPvFfpoYNH/fIqOecHcPykDSbLoFeurPL+qKtby0zhbVm/aZhzHESMGx+E5mbOUPxTHKW0yqTOlWd5uYF+5lRweN+O1Strl5QBfsCYrzZmeU9Pk8//jzsqKXMi/RQKeC48KUXGA5Gp8g0L6CkIrIZruCJdMyk1IP2FyplSYdm7pjQFUgYuZjHinw2EeP/6Awfie4LOT1KoSKlSMtqJaY2uLPT/bypQrqujSANlko87lZzmIdNEhbxtjFHUeSCtSWx09hq6nqd0dPFKAVgkJReGMKZOEpJWpqKhKujsYZkLHc1UMQ4OOY+jS2FrERPVi3ALjJK7BM1evPV8IuviS6ivqa+G53Ou2Mvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(6666004)(33964004)(478600001)(6486002)(110136005)(6506007)(26005)(53546011)(6512007)(2906002)(186003)(66946007)(30864003)(41300700001)(5660300002)(66556008)(316002)(8936002)(8676002)(38100700002)(66476007)(86362001)(31696002)(36756003)(83380400001)(2616005)(31686004)(66899021)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXU0ZFRTakhnVEdwWEU1QVVBa1E2UisxU0pBbktRWGFvWjBMUnUyeWI4cEZp?=
 =?utf-8?B?Q0ZSYlBIQTBRdTRuVnpMdHpQUEFCL1Z6dlk4TTBpcER1TUJHMkR5MjMwcjJj?=
 =?utf-8?B?elYwd05MK1BIMTgvNVZ4VGdVa2JKZ1VqeWJWQ0ZiN3oyelZvS000K1R1aVhi?=
 =?utf-8?B?ZlNDaDMwSVhxa3JHR01COXk2RTVKMVBONmN3RXRXUWZGMm1yVXcxWWJ3K3RC?=
 =?utf-8?B?NC9MQWpGTGxiU21yTU5kYW83bTdEOTZ5TjdmYzFZQ0NDYWphbEV4Z1FPS1NK?=
 =?utf-8?B?L2dLUFU3Ym1BUHBEZ0VaWmRlUVlaQTZSWVIyNzFRS2ZDSVVVU0pObXZ2WUtR?=
 =?utf-8?B?MjJ2TVpZdFRmbUhOVmlyUmd2N1VJQjQ2VEVMTEhuUFBBRVFXVk1kNDN2V2JV?=
 =?utf-8?B?dWlGL2lmVFBlNDhsS0NiSEZzN0EwRVpmR1NlS2VWa25ha2lBdm9WR0tPY1FN?=
 =?utf-8?B?UWd3M01NbUxTaXhCREFoT1VYQWtyd2ZWb3RGUmxWa2FJTVVHQWNreVR2aEVQ?=
 =?utf-8?B?VXE3QmNiaWxBUHZLNkFxRXhXQUhLR0VHYmtOWCtBRGg4a3ZCSmR2Yi9rRjJx?=
 =?utf-8?B?U0xseGtrNWZzMEw4NGl6d1VENTc4eFI1MHBjTFpJZkt6N2xQTEtOb0x2UzBU?=
 =?utf-8?B?TCt4dm5ma1dQK2hLYUVMRTNNTnVaSGdIOCtzRDB5dXRpUnpFRUJFK05IS2ZV?=
 =?utf-8?B?UklmRVFkY0JlTHdXdzFDWk9haXZKbmNqQkw3NlhEd3Q3SDlUZzZieTFXRmlE?=
 =?utf-8?B?eGozZTZSeWxFcklsOWZidjRVWlF3TkhwczZNUk9EUThwdW5OQWNKTnR2Q1Mx?=
 =?utf-8?B?SDE0S2p2dHhMbnlER1FIaG1lc1p0SWVMV0NUREY4eTBIalBGbllmYXY0d1Z4?=
 =?utf-8?B?dnpsUlhiWFdXSjIrNVNqaUYvUG1GRTR6UXJGVzFWM3pPUDFSTENlQ2VoenE5?=
 =?utf-8?B?TmxsNHV3V282TitqTVpDQ2VaN3ZvMzc0em1WTEhmRGVXakxQZWtabnVPV2VB?=
 =?utf-8?B?Sm5YOWtSMlkva3phbDBLNnhOQk54d0N4NkdzQVd4cFkvc25aZlQvVm1HT1gy?=
 =?utf-8?B?ZStkMDZTcW5iY0pGU1EvMFE3eEVCbWNTd3Y0QzRMOXJCOTM3UWIvZU5vSU5R?=
 =?utf-8?B?SGNaNldSckh3Um1FYTBRcTFNRDRwZGFwL2ltOXozUkcrY3JrMjhIdVdpaDN0?=
 =?utf-8?B?cnE2bnhIbTNwcVB5Y1ZaUVlac3J1WCtrL2xtNk55OUpmQ2JqUnhCTmJoTVBW?=
 =?utf-8?B?QzJpS3lyaUpmSzV6M3VNNUo5VDNVMWZQcWVzL1BrMDVLRkpOVE9Odm1OUWRp?=
 =?utf-8?B?NTJOSTdhemxMbE1jY3Bob3J3QXJTUDlVZDlqZUd6R1A3QUpsSGZFQ2IzOStP?=
 =?utf-8?B?NlhmTVJkMVlGVVp5ZXUrTVgyMkhKSko5WTN6ZGU3WFF4YU5ob0JEOFJydVJY?=
 =?utf-8?B?S2JYb2RkU1B4dEw0WjI3alMxdTN0SzNTY25KV0cvaHY1QmpTUW1TM01oZ21w?=
 =?utf-8?B?UUdKbkVQQlVzZlJ6MmpFdTBjOVZyQU9xT1A0QmlLNnpoVVBQc1hzMkRUaWNr?=
 =?utf-8?B?KytnZjB5UERQVWpDdC9odFo1emRxVDNQTllXSEp4a1Z2NlFWbXVoRHlZLytw?=
 =?utf-8?B?Q1ZOL2QwektiS3B4ditpcWJLMDk0Rm5YTjg3VDZ3SU9yTkNwTFFVSzErRDdQ?=
 =?utf-8?B?NUJMd1hVbGk1a2k1ekpMeGlJWllQUXp3OWlNSVo2ajMxV2dQUjdvT2VoZlJ5?=
 =?utf-8?B?VXk0RkIydk5ua2ZBSU9EbTJmYjZjNDB6dEZXeVh0TGw4ZGpNa1ZQMCs2VFNt?=
 =?utf-8?B?T0FXNytMZ2R6d21sRlZFZEgrSkhLbnFUU29GbkFvRXhMdjg0WE9qR0JySkln?=
 =?utf-8?B?YmZDWG9CSEpZRnErQmpBVWNWYVBOSHBrM2pQWnZuVVpBUTlwd256N29KSW5J?=
 =?utf-8?B?YlltL2ZYa3RrWllKRFBCTUNXRE1tbEFKSm1TSWNTSG8zQUp2UFg3YnpDOGRY?=
 =?utf-8?B?ZE9KcHA4dndwM3BNdmlSK205SW9WMVlyMStaV2MrUHVsOWNhZXdoQmtGczRP?=
 =?utf-8?B?L2wzZUlReFBVWStvYWtGUXNHajR5dVJwOE15dVRhZmF3TFB2T3pPZ3ZXY3dX?=
 =?utf-8?Q?mHEKymxtuQHGn4dqN6fTdofn8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a35ef88-286f-4f06-7d72-08db7f49cba0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 00:25:13.3317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqZ9UT50nrq7mtPCAArUZtaC3Gy66qmbFC9hHSAuwbFJsXzczfE2VxcvCTAfcUWg+NwRqHOkZaUbJ0qXnwgnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

--------------Gg2otEp00RvUB12JkuHMXtVq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for your review. The prefix name change will be contradictory 
that new functions prefix name is different with existing functions 
prefix name. Are you sure it doesn't matter?

Regards,
Eric

On 2023-07-07 19:52, Kim, Jonathan wrote:
> I would change the static prefix names from kgd_gfx_ to kgd_gc_ to 
> match file name and specify it as the target GC version.
>
> With that fixed and assuming grace period instance fix ups will follow 
> after, this patch and series is:
>
> Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
>
>
> ------------------------------------------------------------------------
> *From:* Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> *Sent:* Friday, July 7, 2023 1:46 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan 
> <Jonathan.Kim@amd.com>; Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> *Subject:* [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger callbacks for 
> GC v9.4.3
> From: Jonathan Kim <jonathan.kim@amd.com>
>
> Implement the similarities as GC v9.4.2, and the difference
> for GC v9.4.3 HW spec, i.e. xcc instance.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   8 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  27 +++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 166 +++++++++++++++++-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   3 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   6 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   3 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   3 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   3 +-
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |   3 +-
>  10 files changed, 213 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 60f9e027fb66..a06a99c5d311 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -23,6 +23,7 @@
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_amdkfd_arcturus.h"
>  #include "amdgpu_amdkfd_gfx_v9.h"
> +#include "amdgpu_amdkfd_aldebaran.h"
>  #include "gc/gc_9_4_2_offset.h"
>  #include "gc/gc_9_4_2_sh_mask.h"
>  #include <uapi/linux/kfd_ioctl.h>
> @@ -36,7 +37,7 @@
>   * initialize the debug mode registers after it has disabled GFX off 
> during the
>   * debug session.
>   */
> -static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device 
> *adev,
> +uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
>                                              bool restore_dbg_registers,
>                                              uint32_t vmid)
>  {
> @@ -107,7 +108,7 @@ static uint32_t 
> kgd_aldebaran_set_wave_launch_trap_override(struct amdgpu_device
>          return data;
>  }
>
> -static uint32_t kgd_aldebaran_set_wave_launch_mode(struct 
> amdgpu_device *adev,
> +uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
>                                          uint8_t wave_launch_mode,
>                                          uint32_t vmid)
>  {
> @@ -125,7 +126,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
>                                          uint32_t watch_address_mask,
>                                          uint32_t watch_id,
>                                          uint32_t watch_mode,
> -                                       uint32_t debug_vmid)
> +                                       uint32_t debug_vmid,
> +                                       uint32_t inst )
>  {
>          uint32_t watch_address_high;
>          uint32_t watch_address_low;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
> new file mode 100644
> index 000000000000..a7bdaf8d82dd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person 
> obtaining a
> + * copy of this software and associated documentation files (the 
> "Software"),
> + * to deal in the Software without restriction, including without 
> limitation
> + * the rights to use, copy, modify, merge, publish, distribute, 
> sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be 
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
> SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
> +                                       bool restore_dbg_registers,
> +                                       uint32_t vmid);
> +uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
> +                                       uint8_t wave_launch_mode,
> +                                       uint32_t vmid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 5b4b7f8b92a5..543405a28b19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -22,6 +22,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_amdkfd_gfx_v9.h"
> +#include "amdgpu_amdkfd_aldebaran.h"
>  #include "gc/gc_9_4_3_offset.h"
>  #include "gc/gc_9_4_3_sh_mask.h"
>  #include "athub/athub_1_8_0_offset.h"
> @@ -32,6 +33,7 @@
>  #include "soc15.h"
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> +#include <uapi/linux/kfd_ioctl.h>
>
>  static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
>  {
> @@ -361,6 +363,156 @@ static int kgd_gfx_v9_4_3_hqd_load(struct 
> amdgpu_device *adev, void *mqd,
>          return 0;
>  }
>
> +/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
> +static uint32_t kgd_gfx_v9_4_3_disable_debug_trap(struct 
> amdgpu_device *adev,
> +                                               bool keep_trap_enabled,
> +                                               uint32_t vmid)
> +{
> +       uint32_t data = 0;
> +
> +       data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
> +       data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
> +       data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, 
> EXCP_REPLACE, 0);
> +
> +       return data;
> +}
> +
> +static int kgd_gfx_v9_4_3_validate_trap_override_request(
> +                               struct amdgpu_device *adev,
> +                               uint32_t trap_override,
> +                               uint32_t *trap_mask_supported)
> +{
> +       *trap_mask_supported &= KFD_DBG_TRAP_MASK_FP_INVALID |
> + KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
> + KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
> + KFD_DBG_TRAP_MASK_FP_OVERFLOW |
> + KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
> + KFD_DBG_TRAP_MASK_FP_INEXACT |
> + KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
> + KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
> + KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |
> + KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |
> + KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
> +
> +       if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
> +                       trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
> +               return -EPERM;
> +
> +       return 0;
> +}
> +
> +static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)
> +{
> +       uint32_t trap_on_start = (mask & 
> KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;
> +       uint32_t trap_on_end = (mask & 
> KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;
> +       uint32_t excp_en = mask & (KFD_DBG_TRAP_MASK_FP_INVALID |
> + KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
> + KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
> + KFD_DBG_TRAP_MASK_FP_OVERFLOW |
> + KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
> + KFD_DBG_TRAP_MASK_FP_INEXACT |
> + KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
> + KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
> + KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);
> +       uint32_t ret;
> +
> +       ret = REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, excp_en);
> +       ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, 
> TRAP_ON_START, trap_on_start);
> +       ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END, 
> trap_on_end);
> +
> +       return ret;
> +}
> +
> +static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)
> +{
> +       uint32_t ret = REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, 
> EXCP_EN);
> +
> +       if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START))
> +               ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;
> +
> +       if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END))
> +               ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
> +
> +       return ret;
> +}
> +
> +/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
> +static uint32_t kgd_gfx_v9_4_3_set_wave_launch_trap_override(
> +                               struct amdgpu_device *adev,
> +                               uint32_t vmid,
> +                               uint32_t trap_override,
> +                               uint32_t trap_mask_bits,
> +                               uint32_t trap_mask_request,
> +                               uint32_t *trap_mask_prev,
> +                               uint32_t kfd_dbg_trap_cntl_prev)
> +
> +{
> +       uint32_t data = 0;
> +
> +       *trap_mask_prev = trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);
> +
> +       data = (trap_mask_bits & trap_mask_request) |
> +              (*trap_mask_prev & ~trap_mask_request);
> +       data = trap_mask_map_sw_to_hw(data);
> +
> +       data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
> +       data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, 
> EXCP_REPLACE, trap_override);
> +
> +       return data;
> +}
> +
> +#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H - regTCP_WATCH0_ADDR_H)
> +static uint32_t kgd_gfx_v9_4_3_set_address_watch(
> +                               struct amdgpu_device *adev,
> +                               uint64_t watch_address,
> +                               uint32_t watch_address_mask,
> +                               uint32_t watch_id,
> +                               uint32_t watch_mode,
> +                               uint32_t debug_vmid,
> +                               uint32_t inst)
> +{
> +       uint32_t watch_address_high;
> +       uint32_t watch_address_low;
> +       uint32_t watch_address_cntl;
> +
> +       watch_address_cntl = 0;
> +       watch_address_low = lower_32_bits(watch_address);
> +       watch_address_high = upper_32_bits(watch_address) & 0xffff;
> +
> +       watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +                       TCP_WATCH0_CNTL,
> +                       MODE,
> +                       watch_mode);
> +
> +       watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +                       TCP_WATCH0_CNTL,
> +                       MASK,
> +                       watch_address_mask >> 7);
> +
> +       watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
> +                       TCP_WATCH0_CNTL,
> +                       VALID,
> +                       1);
> +
> +       WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +                       regTCP_WATCH0_ADDR_H) +
> +                       (watch_id * TCP_WATCH_STRIDE)),
> +                       watch_address_high);
> +
> +       WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +                       regTCP_WATCH0_ADDR_L) +
> +                       (watch_id * TCP_WATCH_STRIDE)),
> +                       watch_address_low);
> +
> +       return watch_address_cntl;
> +}
> +
> +static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct 
> amdgpu_device *adev,
> +                               uint32_t watch_id)
> +{
> +       return 0;
> +}
> +
>  const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>          .program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>          .set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
> @@ -380,5 +532,17 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>          .set_vm_context_page_table_base =
> kgd_gfx_v9_set_vm_context_page_table_base,
>          .program_trap_handler_settings =
> - kgd_gfx_v9_program_trap_handler_settings
> + kgd_gfx_v9_program_trap_handler_settings,
> +       .build_grace_period_packet_info =
> + kgd_gfx_v9_build_grace_period_packet_info,
> +       .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
> +       .enable_debug_trap = kgd_aldebaran_enable_debug_trap,
> +       .disable_debug_trap = kgd_gfx_v9_4_3_disable_debug_trap,
> +       .validate_trap_override_request =
> + kgd_gfx_v9_4_3_validate_trap_override_request,
> +       .set_wave_launch_trap_override =
> + kgd_gfx_v9_4_3_set_wave_launch_trap_override,
> +       .set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
> +       .set_address_watch = kgd_gfx_v9_4_3_set_address_watch,
> +       .clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8ad7a7779e14..fd42b524a161 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct 
> amdgpu_device *adev,
>                                          uint32_t watch_address_mask,
>                                          uint32_t watch_id,
>                                          uint32_t watch_mode,
> -                                       uint32_t debug_vmid)
> +                                       uint32_t debug_vmid,
> +                                       uint32_t inst)
>  {
>          uint32_t watch_address_high;
>          uint32_t watch_address_low;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index e6b70196071a..306ea176032d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -44,10 +44,12 @@ uint32_t kgd_gfx_v10_set_address_watch(struct 
> amdgpu_device *adev,
>                                          uint32_t watch_address_mask,
>                                          uint32_t watch_id,
>                                          uint32_t watch_mode,
> -                                       uint32_t debug_vmid);
> +                                       uint32_t debug_vmid,
> +                                       uint32_t inst);
>  uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
>                                          uint32_t watch_id);
> -void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, 
> uint32_t *wait_times);
> +void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
> +                               uint32_t *wait_times);
>  void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device 
> *adev,
>                                                 uint32_t wait_times,
>                                                 uint32_t grace_period,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 91c3574ebed3..77ca5cbfb601 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -743,7 +743,8 @@ static uint32_t 
> kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
>                                          uint32_t watch_address_mask,
>                                          uint32_t watch_id,
>                                          uint32_t watch_mode,
> -                                       uint32_t debug_vmid)
> +                                       uint32_t debug_vmid,
> +                                       uint32_t inst)
>  {
>          uint32_t watch_address_high;
>          uint32_t watch_address_low;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51d93fb13ea3..bb496e818d52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct 
> amdgpu_device *adev,
>                                          uint32_t watch_address_mask,
>                                          uint32_t watch_id,
>                                          uint32_t watch_mode,
> -                                       uint32_t debug_vmid)
> +                                       uint32_t debug_vmid,
> +                                       uint32_t inst)
>  {
>          uint32_t watch_address_high;
>          uint32_t watch_address_low;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 5f54bff0db49..4e8aa0432e8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -89,7 +89,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct 
> amdgpu_device *adev,
>                                          uint32_t watch_address_mask,
>                                          uint32_t watch_id,
>                                          uint32_t watch_mode,
> -                                       uint32_t debug_vmid);
> +                                       uint32_t debug_vmid,
> +                                       uint32_t inst);
>  uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
>                                          uint32_t watch_id);
>  void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, 
> uint32_t *wait_times);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index fff3ccc04fa9..24083db44724 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -466,7 +466,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct 
> kfd_process_device *pdd,
>                                  watch_address_mask,
>                                  *watch_id,
>                                  watch_mode,
> - pdd->dev->vm_info.last_vmid_kfd);
> + pdd->dev->vm_info.last_vmid_kfd,
> +                               0);
>          amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>          if (!pdd->dev->kfd->shared_resources.enable_mes)
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h 
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index d0df3381539f..30d91d2ffe4c 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -315,7 +315,8 @@ struct kfd2kgd_calls {
>                                          uint32_t watch_address_mask,
>                                          uint32_t watch_id,
>                                          uint32_t watch_mode,
> -                                       uint32_t debug_vmid);
> +                                       uint32_t debug_vmid,
> +                                       uint32_t inst);
>          uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
>                          uint32_t watch_id);
>          void (*get_iq_wait_times)(struct amdgpu_device *adev,
> -- 
> 2.34.1
>

--------------Gg2otEp00RvUB12JkuHMXtVq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Thanks for your review. The prefix name change will be contradictory
    that new functions prefix name is different with existing functions
    prefix name. Are you sure it doesn't matter?<br>
    <br>
    Regards,<br>
    Eric<br>
    <br>
    <div class="moz-cite-prefix">On 2023-07-07 19:52, Kim, Jonathan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY8PR12MB7435CB35A4EED90C5DADDA3E852DA@CY8PR12MB7435.namprd12.prod.outlook.com">
      
      <div>I would change the static prefix names from kgd_gfx_ to
        kgd_gc_ to match file name and specify it as the target GC
        version.</div>
      <div><br>
      </div>
      <div>With that fixed and assuming grace period instance fix ups
        will follow after, this patch and series is:</div>
      <div><br>
      </div>
      <div>Reviewed-by: Jonathan Kim <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a></div>
      <br>
      <br>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Huang,
          JinHuiEric <a class="moz-txt-link-rfc2396E" href="mailto:JinHuiEric.Huang@amd.com">&lt;JinHuiEric.Huang@amd.com&gt;</a><br>
          <b>Sent:</b> Friday, July 7, 2023 1:46 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Cc:</b> Kim, Jonathan <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>; Kim,
          Jonathan <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>; Huang, JinHuiEric
          <a class="moz-txt-link-rfc2396E" href="mailto:JinHuiEric.Huang@amd.com">&lt;JinHuiEric.Huang@amd.com&gt;</a><br>
          <b>Subject:</b> [PATCH 1/4] drm/amdkfd: add kfd2kgd debugger
          callbacks for GC v9.4.3</font>
        <div>&nbsp;</div>
      </div>
      <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
            <div class="PlainText">From: Jonathan Kim
              <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a><br>
              <br>
              Implement the similarities as GC v9.4.2, and the
              difference<br>
              for GC v9.4.3 HW spec, i.e. xcc instance.<br>
              <br>
              Signed-off-by: Jonathan Kim <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a><br>
              Signed-off-by: Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a><br>
              ---<br>
              &nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c&nbsp; |&nbsp;&nbsp; 8 +-<br>
              &nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h&nbsp; |&nbsp; 27 +++<br>
              &nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c&nbsp;&nbsp; | 166
              +++++++++++++++++-<br>
              &nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
              &nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +-<br>
              &nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
              &nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |&nbsp;&nbsp; 3 +-<br>
              &nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |&nbsp;&nbsp; 3 +-<br>
              &nbsp;drivers/gpu/drm/amd/amdkfd/kfd_debug.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
              &nbsp;.../gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
              &nbsp;10 files changed, 213 insertions(+), 12 deletions(-)<br>
              &nbsp;create mode 100644
              drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h<br>
              <br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
              index 60f9e027fb66..a06a99c5d311 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
              @@ -23,6 +23,7 @@<br>
              &nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
              &nbsp;#include &quot;amdgpu_amdkfd_arcturus.h&quot;<br>
              &nbsp;#include &quot;amdgpu_amdkfd_gfx_v9.h&quot;<br>
              +#include &quot;amdgpu_amdkfd_aldebaran.h&quot;<br>
              &nbsp;#include &quot;gc/gc_9_4_2_offset.h&quot;<br>
              &nbsp;#include &quot;gc/gc_9_4_2_sh_mask.h&quot;<br>
              &nbsp;#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
              @@ -36,7 +37,7 @@<br>
              &nbsp; * initialize the debug mode registers after it has
              disabled GFX off during the<br>
              &nbsp; * debug session.<br>
              &nbsp; */<br>
              -static uint32_t kgd_aldebaran_enable_debug_trap(struct
              amdgpu_device *adev,<br>
              +uint32_t kgd_aldebaran_enable_debug_trap(struct
              amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool
              restore_dbg_registers,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              vmid)<br>
              &nbsp;{<br>
              @@ -107,7 +108,7 @@ static uint32_t
              kgd_aldebaran_set_wave_launch_trap_override(struct
              amdgpu_device<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return data;<br>
              &nbsp;}<br>
              &nbsp;<br>
              -static uint32_t kgd_aldebaran_set_wave_launch_mode(struct
              amdgpu_device *adev,<br>
              +uint32_t kgd_aldebaran_set_wave_launch_mode(struct
              amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t
              wave_launch_mode,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid)<br>
              &nbsp;{<br>
              @@ -125,7 +126,8 @@ static uint32_t
              kgd_gfx_aldebaran_set_address_watch(<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_address_mask,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_mode,<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid)<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst )<br>
              &nbsp;{<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_high;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low;<br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h<br>
              new file mode 100644<br>
              index 000000000000..a7bdaf8d82dd<br>
              --- /dev/null<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h<br>
              @@ -0,0 +1,27 @@<br>
              +/*<br>
              + * Copyright 2023 Advanced Micro Devices, Inc.<br>
              + *<br>
              + * Permission is hereby granted, free of charge, to any
              person obtaining a<br>
              + * copy of this software and associated documentation
              files (the &quot;Software&quot;),<br>
              + * to deal in the Software without restriction, including
              without limitation<br>
              + * the rights to use, copy, modify, merge, publish,
              distribute, sublicense,<br>
              + * and/or sell copies of the Software, and to permit
              persons to whom the<br>
              + * Software is furnished to do so, subject to the
              following conditions:<br>
              + *<br>
              + * The above copyright notice and this permission notice
              shall be included in<br>
              + * all copies or substantial portions of the Software.<br>
              + *<br>
              + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF
              ANY KIND, EXPRESS OR<br>
              + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
              OF MERCHANTABILITY,<br>
              + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp;
              IN NO EVENT SHALL<br>
              + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
              CLAIM, DAMAGES OR<br>
              + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
              TORT OR OTHERWISE,<br>
              + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE
              SOFTWARE OR THE USE OR<br>
              + * OTHER DEALINGS IN THE SOFTWARE.<br>
              + */<br>
              +uint32_t kgd_aldebaran_enable_debug_trap(struct
              amdgpu_device *adev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool
              restore_dbg_registers,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid);<br>
              +uint32_t kgd_aldebaran_set_wave_launch_mode(struct
              amdgpu_device *adev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t
              wave_launch_mode,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid);<br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
              index 5b4b7f8b92a5..543405a28b19 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
              @@ -22,6 +22,7 @@<br>
              &nbsp;#include &quot;amdgpu.h&quot;<br>
              &nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
              &nbsp;#include &quot;amdgpu_amdkfd_gfx_v9.h&quot;<br>
              +#include &quot;amdgpu_amdkfd_aldebaran.h&quot;<br>
              &nbsp;#include &quot;gc/gc_9_4_3_offset.h&quot;<br>
              &nbsp;#include &quot;gc/gc_9_4_3_sh_mask.h&quot;<br>
              &nbsp;#include &quot;athub/athub_1_8_0_offset.h&quot;<br>
              @@ -32,6 +33,7 @@<br>
              &nbsp;#include &quot;soc15.h&quot;<br>
              &nbsp;#include &quot;sdma/sdma_4_4_2_offset.h&quot;<br>
              &nbsp;#include &quot;sdma/sdma_4_4_2_sh_mask.h&quot;<br>
              +#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
              &nbsp;<br>
              &nbsp;static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)<br>
              &nbsp;{<br>
              @@ -361,6 +363,156 @@ static int
              kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void
              *mqd,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              &nbsp;}<br>
              &nbsp;<br>
              +/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */<br>
              +static uint32_t kgd_gfx_v9_4_3_disable_debug_trap(struct
              amdgpu_device *adev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool
              keep_trap_enabled,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              vmid)<br>
              +{<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data = 0;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
              TRAP_EN, 1);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
              EXCP_EN, 0);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
              EXCP_REPLACE, 0);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return data;<br>
              +}<br>
              +<br>
              +static int kgd_gfx_v9_4_3_validate_trap_override_request(<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device
              *adev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_override,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              *trap_mask_supported)<br>
              +{<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *trap_mask_supported &amp;=
              KFD_DBG_TRAP_MASK_FP_INVALID |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_OVERFLOW |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_UNDERFLOW |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_INEXACT |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR
              &amp;&amp;<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trap_override !=
              KFD_DBG_TRAP_OVERRIDE_REPLACE)<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EPERM;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              +}<br>
              +<br>
              +static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)<br>
              +{<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_on_start = (mask &amp;
              KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_on_end = (mask &amp;
              KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t excp_en = mask &amp;
              (KFD_DBG_TRAP_MASK_FP_INVALID |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_OVERFLOW |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_UNDERFLOW |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_FP_INEXACT |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL,
              EXCP_EN, excp_en);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL,
              TRAP_ON_START, trap_on_start);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL,
              TRAP_ON_END, trap_on_end);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
              +}<br>
              +<br>
              +static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)<br>
              +{<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret = REG_GET_FIELD(mask,
              SPI_GDBG_PER_VMID_CNTL, EXCP_EN);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL,
              TRAP_ON_START))<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret |=
              KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL,
              TRAP_ON_END))<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
              +}<br>
              +<br>
              +/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */<br>
              +static uint32_t
              kgd_gfx_v9_4_3_set_wave_launch_trap_override(<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device
              *adev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_override,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trap_mask_bits,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              trap_mask_request,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *trap_mask_prev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              kfd_dbg_trap_cntl_prev)<br>
              +<br>
              +{<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data = 0;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *trap_mask_prev =
              trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = (trap_mask_bits &amp; trap_mask_request) |<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*trap_mask_prev &amp; ~trap_mask_request);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = trap_mask_map_sw_to_hw(data);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
              TRAP_EN, 1);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
              EXCP_REPLACE, trap_override);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return data;<br>
              +}<br>
              +<br>
              +#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H -
              regTCP_WATCH0_ADDR_H)<br>
              +static uint32_t kgd_gfx_v9_4_3_set_address_watch(<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device
              *adev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t watch_address,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_address_mask,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_id,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_mode,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t debug_vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
              +{<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_high;<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low;<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_cntl;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_cntl = 0;<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_low = lower_32_bits(watch_address);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_high = upper_32_bits(watch_address)
              &amp; 0xffff;<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_cntl =
              REG_SET_FIELD(watch_address_cntl,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TCP_WATCH0_CNTL,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MODE,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_mode);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_cntl =
              REG_SET_FIELD(watch_address_cntl,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TCP_WATCH0_CNTL,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MASK,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_mask &gt;&gt; 7);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_cntl =
              REG_SET_FIELD(watch_address_cntl,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TCP_WATCH0_CNTL,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VALID,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC,
              inst),<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regTCP_WATCH0_ADDR_H) +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (watch_id * TCP_WATCH_STRIDE)),<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_high);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC,
              inst),<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regTCP_WATCH0_ADDR_L) +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (watch_id * TCP_WATCH_STRIDE)),<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_low);<br>
              +<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return watch_address_cntl;<br>
              +}<br>
              +<br>
              +static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct
              amdgpu_device *adev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_id)<br>
              +{<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
              +}<br>
              +<br>
              &nbsp;const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =
              kgd_gfx_v9_program_sh_mem_settings,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pasid_vmid_mapping =
              kgd_gfx_v9_4_3_set_pasid_vmid_mapping,<br>
              @@ -380,5 +532,17 @@ const struct kfd2kgd_calls
              gc_9_4_3_kfd2kgd = {<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table_base =<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kgd_gfx_v9_set_vm_context_page_table_base,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_trap_handler_settings =<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kgd_gfx_v9_program_trap_handler_settings<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kgd_gfx_v9_program_trap_handler_settings,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .build_grace_period_packet_info =<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kgd_gfx_v9_build_grace_period_packet_info,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_debug_trap =
              kgd_aldebaran_enable_debug_trap,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_debug_trap =
              kgd_gfx_v9_4_3_disable_debug_trap,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .validate_trap_override_request =<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kgd_gfx_v9_4_3_validate_trap_override_request,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wave_launch_trap_override =<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              kgd_gfx_v9_4_3_set_wave_launch_trap_override,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wave_launch_mode =
              kgd_aldebaran_set_wave_launch_mode,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_address_watch =
              kgd_gfx_v9_4_3_set_address_watch,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .clear_address_watch =
              kgd_gfx_v9_4_3_clear_address_watch<br>
              &nbsp;};<br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
              index 8ad7a7779e14..fd42b524a161 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
              @@ -886,7 +886,8 @@ uint32_t
              kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_address_mask,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_mode,<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid)<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
              &nbsp;{<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_high;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low;<br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h<br>
              index e6b70196071a..306ea176032d 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h<br>
              @@ -44,10 +44,12 @@ uint32_t
              kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_address_mask,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_mode,<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst);<br>
              &nbsp;uint32_t kgd_gfx_v10_clear_address_watch(struct
              amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id);<br>
              -void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device
              *adev, uint32_t *wait_times);<br>
              +void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device
              *adev,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *wait_times);<br>
              &nbsp;void kgd_gfx_v10_build_grace_period_packet_info(struct
              amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              wait_times,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              grace_period,<br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
              index 91c3574ebed3..77ca5cbfb601 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
              @@ -743,7 +743,8 @@ static uint32_t
              kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_address_mask,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_mode,<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid)<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
              &nbsp;{<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_high;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low;<br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
              index 51d93fb13ea3..bb496e818d52 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
              @@ -822,7 +822,8 @@ uint32_t
              kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_address_mask,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_mode,<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid)<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
              &nbsp;{<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_high;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_address_low;<br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
              index 5f54bff0db49..4e8aa0432e8b 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
              @@ -89,7 +89,8 @@ uint32_t
              kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_address_mask,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_mode,<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst);<br>
              &nbsp;uint32_t kgd_gfx_v9_clear_address_watch(struct
              amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id);<br>
              &nbsp;void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device
              *adev, uint32_t *wait_times);<br>
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c<br>
              index fff3ccc04fa9..24083db44724 100644<br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c<br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c<br>
              @@ -466,7 +466,8 @@ int
              kfd_dbg_trap_set_dev_address_watch(struct
              kfd_process_device *pdd,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_address_mask,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *watch_id,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; watch_mode,<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              pdd-&gt;dev-&gt;vm_info.last_vmid_kfd);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              pdd-&gt;dev-&gt;vm_info.last_vmid_kfd,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(pdd-&gt;dev-&gt;adev, true);<br>
              &nbsp;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
              (!pdd-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes)<br>
              diff --git
              a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
              b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
              index d0df3381539f..30d91d2ffe4c 100644<br>
              --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
              +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
              @@ -315,7 +315,8 @@ struct kfd2kgd_calls {<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_address_mask,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_id,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              watch_mode,<br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid);<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              debug_vmid,<br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst);<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*clear_address_watch)(struct
              amdgpu_device *adev,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_id);<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*get_iq_wait_times)(struct amdgpu_device
              *adev,<br>
              -- <br>
              2.34.1<br>
              <br>
            </div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------Gg2otEp00RvUB12JkuHMXtVq--
