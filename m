Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6D7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 18:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB6A6E098;
	Wed, 24 Nov 2021 18:59:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88056E098
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 18:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv/fknooM7BVmymVuHXZN9SCkJCnSy1/wOSxSB0O3j4PA4cdERwe5ZsRzMXIiIXBadWmcOzXRg60PPtJ50dfdP30HOSxJT3LVySHaMMQV8Yn9fIu8IxXmE7XuA8onjdyYrkTp2U3BIeXKh18hQaG3oG24UABlFsTYEDM0x6yUxaykD19kfT+gXgCpTYV0Wqh2nDvmulLRhG2oQQ/lPJe/+ysB6aZRCLWnp0q6I+UocEffx2AR/BhcWGzJlylq9Ijs8ASIhVSmzuGbLhpXGue8XuOnHJXjtVweOErH4a8IHBAP/1965sexyje9l4scvSvR320PXtTNg55iByBnj6akA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSmBSn+cmMazk1fUiXRxH4tTL8mDoveUMjm/4TsMKZ8=;
 b=ZOsGlGZgsxUY8BGPmCsRo8qKcNCUT7ikDNdR7zguB5WQGt38jrHliSuJKLuoi+dbND9IJ3psqt1kphX3FD+OF0frEgexGza+wtYNET69Y1fTxGx1PtdIZhA8mXoCJrJwU9Txr7ngfiIhZQPo9nSC0Dn5hb+/f1T1nuybEGkV7koGpy/0RVlfVNfJxFChehpfalfDR5+ylqNbUgNx2hovXCQc0elOssqXE+vcfMLrIIJwXS4z+HeJofvLjt2FHo/LmNkMbtvyNQGYbkuxc9fb7Uq+IrdTE9Ch5jxL0ZEWtZpzhjXrICb4SLo6DH+79VcJumLw4IVvEYwduP8T0117Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSmBSn+cmMazk1fUiXRxH4tTL8mDoveUMjm/4TsMKZ8=;
 b=LvH9+nS62iwdEXNxzMx05ZGPPl51EoVqhZvr8B+0ouIOiYFqgbqweJaDwdNyR+0E34uNgHjqOpsU4yqHYvTR9g9NQOte7kFNtpL7rXl4ALxm5fXzqSFypUT2YG3yuZyZup9webj3VqLgMIiKnOVqU/q5EzlcjP68+nt/85T73SA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 24 Nov
 2021 18:59:44 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%5]) with mapi id 15.20.4713.025; Wed, 24 Nov 2021
 18:59:44 +0000
Message-ID: <53020703-3a73-7089-342e-dbf2cb265401@amd.com>
Date: Wed, 24 Nov 2021 13:59:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/display: update bios scratch when setting
 backlight
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20211124163612.2728640-1-alexander.deucher@amd.com>
 <b110e60d-8f0a-7ce6-5e88-0f7beff66533@amd.com>
 <CADnq5_PpWO3Qui3kyjBP-+sTa7SaAbpFYaapKgTd3uP1bq5c3A@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_PpWO3Qui3kyjBP-+sTa7SaAbpFYaapKgTd3uP1bq5c3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 24 Nov 2021 18:59:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b84472-195c-433b-7928-08d9af7c93f6
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5460DD11BD0AC090C46CFE5F8C619@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NkPG4JgJjcNYrHizuBLOTM3+izUGJmsoAH0h8eESTW3Zx+mqgOI75FKZ8PEtVNOipXLRTc3BENaXzuau543M1kYSg/skogREA5sidfBdV+DG7mPHZAg9Lcrwvx22j5TWQUrt5MSkJBulYIvQJuVCJ65TaAPTig9elMXgg7ncFgvtONDtHUXNczXPVoe0O5pBCF29lJuhOx0gf5zuaMBJU7mPTfKRQq5jKrpp/9N8Xsz4ubJXnFFWTZzDrCYhRHKJoW8aIn2SkRH6u+DtwC7KFcsDb5Zn7fpjpM92AoxCDRIg/WdirW8Bg7CCcGGJEztK0h+suBYp6oblV0O9SunGR7hJUkn6Q3e4m589GIs2u5acHCBtGOlfcVyqKe5JVQ/cc48xQpMdrfGPOXI/d1TbqnvEowr6ywBCI2epcN3xMqccZn4qLwAvtOspyYUgt7fN87Tl0SKUwk3zlU+xhY7kyfjwlMmolV19EFT4mh4qi2tehfPVSyG6GA+ljAOpBkstCGp//fXOIldr0Bi2sIboBzMjgKFQx3GQX7lHPHAchZmGCJTHZrkhhNJl0nKOjAKxZ3hympO36xroPpO7aw4kJ0FPeWjdQ6R8hdKoml8z0esANVj2+J/n0H+H0zA5ZP+IrCQoFS89YsBrjk75eYyhPeS7MrrLzd7H6mWGnnlpdEJmj4DJCTwRyWdsyZ5B63vH/g9kI7GFaB7I4JCIci83sbi2+HrmPE/qrLcjDfU515BAl3aZ9opE7Q+8Shuh23R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(86362001)(83380400001)(8676002)(36756003)(316002)(966005)(53546011)(31696002)(4326008)(66476007)(66946007)(5660300002)(4001150100001)(15650500001)(6486002)(508600001)(956004)(26005)(16576012)(6916009)(8936002)(54906003)(66556008)(38100700002)(31686004)(2616005)(186003)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2F5NFNNT2dUN3lTSWllZ1AxR0t0S1ZMQndKR0FIZEhSNlZLSzdDNFlOTUJ2?=
 =?utf-8?B?VnZWR3YxcEhLclJpSlU3Ry9vdFhHdFVwLzF6czdnVE0yRkNCTzlZTFhKbmZk?=
 =?utf-8?B?QUQwZk0xbXRZOG5ycDB5Z3FjWVNJMzVEZWl4U3lFdGV6R2VNTjQybm1ZZWhJ?=
 =?utf-8?B?M1RpQmFLTFVvT1QwUzh4NWkvODVycGorSWlyOTZSdGpjbDZEMksydlJsMHJE?=
 =?utf-8?B?bUgwbExqd3lrTzNrZUhrSGlIcWJBdFFNVjJBM1F2eGZlZnZjWG1acmxsM2RY?=
 =?utf-8?B?ejRhVzg1RnpLVDBoWGRGaC83cnF0NTZQeE5qbG9HRmhJajUybG80ektZaXR3?=
 =?utf-8?B?SHB6VGtwSXdSWlY4NGozRVUwOG4wR2dndG5EWFZXeWhXTUx5b0FqT1ByM2ln?=
 =?utf-8?B?U3FiSE1HYTN4Q3N5SDV6Y2tsZ0lmS1hNTkRRam1tSHdsNG0wU1Q4V2ppdzN5?=
 =?utf-8?B?YjV2ajBuWDVsUVhVYUd1L3pRRjBZZHFOYUViV2RYaHQwK3Nodm9yWGdQelVt?=
 =?utf-8?B?R2JJcytnUGNhMm9LaUJoK0lxTFlNOEk1eFJaQXpXdHNYRVFxM1hvSVlPYUVP?=
 =?utf-8?B?alZqaWFuZFpvRWVPdlQ0aVZNVkRIR3hiaWdiZ0FCYURLT0FEZzVFOUJ4NXBQ?=
 =?utf-8?B?YXFaWkUxUVdyZlZiRHg4QURRbGZGNXB6OFNQMUZ6cEtqeVBaV3dvVWVlbE4w?=
 =?utf-8?B?VnFjcTA1bjZFTTRWSUJSNHRKNTl1UitjZ0psT2MxdEF1Y3VSRDRlaXBDMWVE?=
 =?utf-8?B?YUc4T2RsSkFMeW1qSytiakdRTExMbDBMcnJhK2VBYkU1VnZRdGZsRk5rU3lq?=
 =?utf-8?B?eVErZDN6UndvVUhiTExHWlJVSlYwQXYrekFsZkNMNFBXRSs0MFVUam5YMUpj?=
 =?utf-8?B?U1R1V3dyTW14U0l4L1ZQUGp1VHY5R2FNdUZqanNVODF3OTJtM1BLK0dscUZy?=
 =?utf-8?B?U2xRc1VoZ0p2NEIwekZqYmg5T3p0RjN6ZVlmbEZncGtkRk5pMWROZWFkYkht?=
 =?utf-8?B?SnJCTzJsQUh1SU5sQVZRMEZHQ2pORGMzNjJnVlYvTHZEL2ZGRnlFVEVtRWRL?=
 =?utf-8?B?SE9hdm0xUHgxZzBzdzFZVG04K2x5UW5TZVJpazhIRytEVnR1bjdXNEdoRTVw?=
 =?utf-8?B?SHNhVzNBN2tGczR5Nlk3OVlPZzIyajRIWFNqZlB1V3QwamJOSERsVzd2M1Uz?=
 =?utf-8?B?MTRBcWZGN3pQUGhyK0wrODFuZHFyc2k1M3grZHNsWElPMFlXRzNhNFdrUndX?=
 =?utf-8?B?ZitIWG11cFlrVmxYYnRDQUFiNThaMnBKbnZoeVBkZG9BVzcwZzB2TjNNY0R0?=
 =?utf-8?B?cHhNbUIwUm45d25nbS95clJRVkthOEUzaDMvU01BSWZKcUk2MFhIMFRGbWg0?=
 =?utf-8?B?OHhXZGQwc2YrQXR5RzA0aG5KOFNBYlRnS1I5Qkk4WDhnT1VjUE9LMDJBTDVa?=
 =?utf-8?B?TnIvU3Qxblpvd0h3VFl4Sk9SRWpVU3NOZG9LMmpoTFRycS9TNzYvWXlpZUNr?=
 =?utf-8?B?ZGtpWmZSeE1vT2VzRUpCc0c3YUVzN0tVZjhWckk1SXVJVzRScTh2aG1NUUdn?=
 =?utf-8?B?R1VkTGZJY2pTZkx6RzRmWGh6N2p2blZrNjVOMDAvQ0lrNHJiTUtDbXRDNGU5?=
 =?utf-8?B?YlB6S2wyOS8rQ09QWEFZRFZqZWRiV29TajkzSnllaE85M3dKSDZiaHRmUW9r?=
 =?utf-8?B?MW5JTXhPdURNVHBJeHI5eGxNV3QxUkIzS0FxVUU2NTRyREVzQXp6cXQ2S1U4?=
 =?utf-8?B?bGZSQ1ZXMGErek4vUFU2K2RWZHZ1U1lKTENuWDhBY1FFRkd3RUw2VHgxSDF6?=
 =?utf-8?B?cEIzM2JJcEZMRi9mV2VDM1JRVUFTQitLNGtKWEJZektMcEJCMURGNEs1WmVr?=
 =?utf-8?B?VERkd1RpbVFHYkFsSkxKNENzbDVuYlM0WE9kejBOTEt1UVdzb01qREZvV0Ja?=
 =?utf-8?B?emVQaWRLb2hkZWRoV24zSDJsZUlJVmFreUo1NWcva1pZL3BCM1JtbHdyM2Uy?=
 =?utf-8?B?ZUFaQjRNS1BmVlZ3cW9GelB0ejlhTzVjKzlKVHFiUjdmUGM1ZTR5Smx5VnZ4?=
 =?utf-8?B?ajQwdURxUnM2UlNuRUtvdkVhcFUyckdvT0dLcnJYc1NDcEpYaUo0Rlgrc2Jm?=
 =?utf-8?B?ZjlRaU1VT204TXU2MU41dkRjTGp2MkkvTVFBMEQ2am9TZmN5ZE9qOUFSVmx4?=
 =?utf-8?Q?U1ldS1bBXN46vIqk/w/WycA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b84472-195c-433b-7928-08d9af7c93f6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 18:59:44.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oHrv9UJTH8nl3b9iCtfJwwPvYlXR3hagNPwxVdnUtr/dgdg6OOkF34LLeSsycS7mrephkDheQaW097xamfQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-11-24 13:55, Alex Deucher wrote:
> On Wed, Nov 24, 2021 at 1:52 PM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> On 2021-11-24 11:36, Alex Deucher wrote:
>>> Update the bios scratch register when updating the backlight
>>> level.  Some platforms apparently read this scratch register
>>> and do additional operations in their hotkey handlers.
>>>
>>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1518>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Maybe dce_driver_set_backlight should handle this but doing this
>> in amdgpu also works. I don't know if I have a preference either
>> way.
> 
> Might be helpful for other OSes unless they handle the bios scratch
> registers some other way.  Also does dce_driver_set_backlight() handle
> OLED and aux controlled backlights?
> 

No, that has its own codepath and other OSes tend to always use the ABM
path which uses DMCU/DMUB for programming backlight. I'm not sure if they
let FW handle that or deal with it in the DM for the OS. Hence your approach
is possibly more sensible in amdgpu.

Harry

> Alex
> 
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>
>> Harry
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c      | 12 ++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h      |  2 ++
>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++++
>>>  3 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> index 96b7bb13a2dd..12a6b1c99c93 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> @@ -1569,6 +1569,18 @@ void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
>>>       WREG32(adev->bios_scratch_reg_offset + 3, tmp);
>>>  }
>>>
>>> +void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
>>> +                                                   u32 backlight_level)
>>> +{
>>> +     u32 tmp = RREG32(adev->bios_scratch_reg_offset + 2);
>>> +
>>> +     tmp &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
>>> +     tmp |= (backlight_level << ATOM_S2_CURRENT_BL_LEVEL_SHIFT) &
>>> +             ATOM_S2_CURRENT_BL_LEVEL_MASK;
>>> +
>>> +     WREG32(adev->bios_scratch_reg_offset + 2, tmp);
>>> +}
>>> +
>>>  bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev)
>>>  {
>>>       u32 tmp = RREG32(adev->bios_scratch_reg_offset + 7);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
>>> index 8cc0222dba19..27e74b1fc260 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
>>> @@ -185,6 +185,8 @@ bool amdgpu_atombios_has_gpu_virtualization_table(struct amdgpu_device *adev);
>>>  void amdgpu_atombios_scratch_regs_lock(struct amdgpu_device *adev, bool lock);
>>>  void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
>>>                                             bool hung);
>>> +void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
>>> +                                                   u32 backlight_level);
>>>  bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev);
>>>
>>>  void amdgpu_atombios_copy_swap(u8 *dst, u8 *src, u8 num_bytes, bool to_le);
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 40a4269770fa..05e4a0952a2b 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -51,6 +51,7 @@
>>>  #include <drm/drm_hdcp.h>
>>>  #endif
>>>  #include "amdgpu_pm.h"
>>> +#include "amdgpu_atombios.h"
>>>
>>>  #include "amd_shared.h"
>>>  #include "amdgpu_dm_irq.h"
>>> @@ -3918,6 +3919,9 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>>>       caps = dm->backlight_caps[bl_idx];
>>>
>>>       dm->brightness[bl_idx] = user_brightness;
>>> +     /* update scratch register */
>>> +     if (bl_idx == 0)
>>> +             amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
>>>       brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
>>>       link = (struct dc_link *)dm->backlight_link[bl_idx];
>>>
>>>
>>

