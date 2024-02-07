Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C1EC4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 22:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E38810EAA1;
	Wed,  7 Feb 2024 22:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LcimvevB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA31010EAA1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 22:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC8W9U9egBJBH88y2YoE0chwBwV/2QOLEOj/+S0cpL1FiluaCoWskl7Nlq+4zWQxHtqUVcmFzPOApg2UvrE3+iJMM6TOMjEvosGU2EGz3w5vmGCKpzcvC1zvEh6DHKokQNih7mFsOKr7oRN7SqkeVfZ/yRQxD3WGnk2tAQlGPHvG7UwD3G1Z8bM0EN1oAPjfBnQX3nNwC9lnGJElD5Auux4/94/U31UHMpNABoGjTWbJPWUobG2uD/2P0ZxfnYhSR3Ne8gQ2nz/DkdGMmBazdcMEk7Fmc5HIswXc5LRk8MrmSVnJ7G6YfaIwMHCU2qUGYMCcMMvqrc/E1dwM0Ye8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WMWMZhUadAfBvZZYSwQFbHCrxvxFfXKwAqj5Sj8rRk=;
 b=G3VyZIlSQkQMHXXd/fiqUYh3nUfT6ctjQfw52qf4O7RHvXqJMsg+whMpYeWxAtxf4CsZYrUFFeIVyIH6C2N6f1/F0au06xVPtTRRhXh8Ji26fhpVc3w3B/RUDYkLg0doWPmYfTzuMIYYX9aba+kii+QPkroy7Y41hncODsJCzkxK2uGFSq1K+4JG+8EjC2zBx++u43OmY/Jzv6t+Vo1RkqXKi2bkUaLD7MkoLrR+WAeIZAcbAVI+zr5UV8AX6o5GUq3rXgBJbr9WqsswPhK50eizCKSOuhytg8dJuGKDk4YDJ1I7Z2mb61GKPpFeR9JFaVcKST0gT8vN7QmLKTHZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WMWMZhUadAfBvZZYSwQFbHCrxvxFfXKwAqj5Sj8rRk=;
 b=LcimvevBO+uSwIFqFoFPplt/bCSK5Fom5/omy252V1pi+6HiZ9Cvu464GzgBR5pANSOMIsUqH46KDxeUQS5OQJ4hjuop/WfBo63hlNMge6PayW8/IWA+nXdu2jX+12aU2Pl9Xe1BuNEvuZfKmyp6wquFC03xBRnOWPbfb8YbaIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 22:36:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 22:36:09 +0000
Message-ID: <4f58703b-f74d-4897-b100-f1e867297184@amd.com>
Date: Wed, 7 Feb 2024 16:36:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd: Stop evicting resources on APUs in suspend
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
References: <20240207204103.82789-1-mario.limonciello@amd.com>
 <20240207204103.82789-2-mario.limonciello@amd.com>
 <CADnq5_NZWoO_0tXx74P785H75ZBJph=nF_5XbAqkpBEztK9vSQ@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NZWoO_0tXx74P785H75ZBJph=nF_5XbAqkpBEztK9vSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23)
 To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8fc822-0907-4007-d255-08dc282d2de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiPIkAdKoaisCYzDdVvMqS5VZX3XTB2o254NsRNL+dDOh7ixrsl+6XHf9jzmdX09cPCnfBLyFua9ZwTUQyR04w6DhYECK1/PvFhcc1FKvVz9x91atJLm1+30nWsr2RJHeV4LFK//zMBT6aYb4w98JtzcO2d0KI905+3tad5jEvj9tMx/XqrGAdoYq1fs/WktySPeLRGZvZXheGATt8h9eRwtUkjkYiJzCX+lQSX/3B+jdGZ19aS+Son/jjCgMrCIbZfKkD/Q9BGIgg8bLt4ajBFRVkVhrEoHm1j/kMUnof22PJXxGqbeYN8DKShujEZRjhGwGRZ0uBcDZp3gEH7SiTEUwXNBnk8G5IYOBToFGZLxxWQxiPEbLLU99Rhf2/M1ywWHput0QyLa1BacbTQgM0QI7MUI4HFRUw1IPIWAbD8CpqK2Ryjve3RJOUZ/9ngjT1Wujr21eN6s32K+vbBWDmwoDDMZw+62JgVw9E3ZI8ySBquD2ChVgo9hCzbwbsUnesbL0y5ZJJpizVbqeAdgUUanldFdSHUTZ/e7DbtVkZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(31686004)(478600001)(6512007)(53546011)(31696002)(86362001)(36756003)(966005)(6486002)(44832011)(316002)(66574015)(83380400001)(26005)(2616005)(15650500001)(5660300002)(66946007)(66556008)(2906002)(8676002)(6916009)(6506007)(66476007)(38100700002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjRodWhYY1grc1RVRW9iWVorSDVYUGdmaGIwRHNORU43WlJSMXFneFZsNWF4?=
 =?utf-8?B?QTVmYmZBbUVDbkZqM1VwY2ZNQWJBcXd4OWNKL3hVb245UytlM3Z0ampyUWdC?=
 =?utf-8?B?YlM5MkN1em53NzV0bTdlQlcxUlBUYUpwa21kMzVHRHpzV3YyTkNrZ3JpcWNB?=
 =?utf-8?B?VWU1cWw1YWhrK3hncXlSY2pQZmdBc1NiNU80T0ZQYkdhRVVJRWFtdXcvbnRB?=
 =?utf-8?B?TlJCUjdoQTlSQU5uS082TVpVK2NSTVRXL1lyVkZ0YW12K0ZESTl5T0cwelQ4?=
 =?utf-8?B?d3hlUlptVXU3ME1peUkyRW1DbUNNVkxZS2JtK2tHTW1hQXYveDNxNkQ2N0RG?=
 =?utf-8?B?SWVISXBhQjJPN0xVdjFnN1ZoTEswMlZRRXJKRDZGVlNTVVM4d1pqajllSUJr?=
 =?utf-8?B?SG9yVW44TlZ5L2ZuQXZvVEhjMDhsNkRseFFmenpvbDczZTNybysvTEh4Ymtk?=
 =?utf-8?B?aWJTTWVqMTJ0NmQ1Uk5Oa0FrTFZZdXpHZDZiUDNYd0Y1TGNWYzArVStETGYr?=
 =?utf-8?B?RmNNRE9HTmpKK1Z2Z0NIeFZwczlCREpSUE05aFZJWm9Ob0VJNms4QUF3eGdO?=
 =?utf-8?B?Z01VWGQyL0pObnlyeUYxbWlPMVdhNjcwY2dnVlNUNHZqeFhXcXZUampMNUJT?=
 =?utf-8?B?QzRSQ2c3cXlyMDd2KzdMcHZOUmEzM2V3allrbld6WmhBZ2hRN3BkT0wyajRU?=
 =?utf-8?B?Q2NDS1lsWW16MjRLU3QvWmlLL3pUY0E4a1NmNWMwTERDT0Zuek0wQm15TGpG?=
 =?utf-8?B?Q1BXa2FDQktHQTRuZTBTaHcvRDIvY211TDZGY1lyTGNlWHhVTTNlMURVSlZR?=
 =?utf-8?B?Q3o5eVEwS3JlcWZpZVlyc1VSN0tVV0RWQ3h6RGNuYU9Bd2dRYUNYdmdpVzVL?=
 =?utf-8?B?ZHpzUWUvUW0xelJsSmlQVjY1YVdCeUl5bTRlbWs4SGltZWlidEkzNGtsMlhS?=
 =?utf-8?B?bFdselBLSjdldVZuMXR5Tko5MjBRcU5SYkVQM2x5V3NkZllnRjBSV3dKWmpN?=
 =?utf-8?B?OHVhRTNkbW5JQ3M2MWFmWURqaENCdzFlTkg1YklZSGsyb21rbFVQd1pnUFVX?=
 =?utf-8?B?Vm5odGxaTGdUdkk3cWR2VG1DdlZXYzZtd2NhelhLK1pXM0FoWUFHKzY0OFVx?=
 =?utf-8?B?VnlhT1R1N05aQzdzbWNSKzZpV25ESWJsUmZ1cFNmVlZFVEFJcTQzRTl0dmE0?=
 =?utf-8?B?SEpjMGVGWklQaElHVWtSWHhncWVyK1FoMTE2a2pJakRDNno1OG1EcVB1RXNH?=
 =?utf-8?B?K1QzbDJmYUlNaHdLVFlRQ1gxMHFRSkVBV3FNTTkyQjNkNlpUb21JRHlDSXBx?=
 =?utf-8?B?S3JPRk5zUHVQdHBOUEgweUp1S0p6V1pQemFTdTZEYUhROVNrREdFUUhSVHRN?=
 =?utf-8?B?ZExUVGRUeDdtejJabnlSaERIdTY5enV0WlRYZE8za1Iwbi92cHFqU0RxSVBR?=
 =?utf-8?B?UUNsL24wd2EvS1NYNUh6TjhrNk04Q0JRRi9TcGxNL0U2NGVUZ0NNNEczNjV3?=
 =?utf-8?B?U1Z4d3lQc3ZCZVNGL3R4cTQ3SlB3UUVseGZmRXkyNjJJazI1N1N0U2dvcm1s?=
 =?utf-8?B?d0dabWQ0b3VKWElyQW4vZ3RkU1FrSEVCWXRKOUp2ZGlSUGJjNHhZV3JuaWxy?=
 =?utf-8?B?S1JRQVZBQjg3UEt2Y0IrWFlXekQ3SU5VOVBMek9IcWYrZGE0MEsycUxwWmsz?=
 =?utf-8?B?TEhsS2pRakNVaG5QMm5KWXpnYjFoS2ZXcHgrSDNnTEh2SGhzM0dyVEtMWElV?=
 =?utf-8?B?K0wxMFVkSnFBSkpzZWVxd0VxcHAwV1BVR1U1Z0wrcWsyWEY0TjIxN2swM0pY?=
 =?utf-8?B?RlBveUhCbTNXQXgrVjJxSnpadjZVeVd6MjlmVXlUYnEvN2M5UUpFNWV2TUlq?=
 =?utf-8?B?UWl5Ym0wR1JDNS96WmhZMHBCQm1yTmwzMzFaSkRTOXRBQmlQNUZqYmpEWE9y?=
 =?utf-8?B?WXhWTHczTFdCQzQwU3RXMTIxLzNxWm9VTTZXb3RhTHBWQVAwNDRqTWM2VmRJ?=
 =?utf-8?B?aGIxNmdIZzNad1A0ek1Yd1hVTWtaWnpoakNKWnRqSkhENHF5WFpqeG44SFRS?=
 =?utf-8?B?YThvQW80bDFiWmNaVXhHTUlqSEVYNWdBWmZBdm9tYXc3cnBzS0l2ZldIclJu?=
 =?utf-8?Q?QwKUbDDSmwTVGRXwXYhpXvccT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8fc822-0907-4007-d255-08dc282d2de5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:36:08.9600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJzWqj3gt1cSwtaQyC3rX8UsrBMUluHuR7YdebEEjWOBT3+HzN0srp18rUs3HxF22bS5JoQlHl5E9nY43nM78w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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

On 2/7/2024 16:34, Alex Deucher wrote:
> On Wed, Feb 7, 2024 at 3:48 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> commit 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
>> intentionally moved the eviction of resources to earlier in the suspend
>> process, but this introduced a subtle change that it occurs before adev->in_s0ix
>> or adev->in_s3 are set. This meant that APUs actually started to evict
>> resources at suspend time as well.
>>
>> Add a new `in_prepare` flag that is set for the life of the prepare() callback
>> to return the old code flow. Drop the existing call to return 1 in this case because
>> the suspend() callback looks for the flags too.
>>
>> Also, introduce a new amdgpu_device_freeze() function to call at S4 and evict
>> resources in this callback so that APUs will still get resources evicted.
>>
>> Reported-by: Jürg Billeter <j@bitron.ch>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2271038
>> Fixes: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Add and use new in_prepare member
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 ++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 21 ++--------
>>   3 files changed, 48 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 5d5be3e20687..f9db09a9017a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1075,7 +1075,8 @@ struct amdgpu_device {
>>          u8                              reset_magic[AMDGPU_RESET_MAGIC_NUM];
>>
>>          /* s3/s4 mask */
>> -       bool                            in_suspend;
>> +       bool                            in_prepare;
>> +       bool                            in_suspend;
>>          bool                            in_s3;
>>          bool                            in_s4;
>>          bool                            in_s0ix;
>> @@ -1462,6 +1463,7 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>>   int amdgpu_device_prepare(struct drm_device *dev);
>>   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>>   int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>> +int amdgpu_device_freeze(struct drm_device *drm_dev);
>>   u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
>>   int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>>   void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 2bc460cb993d..0a337fcd89b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4492,7 +4492,7 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>          int ret;
>>
>>          /* No need to evict vram on APUs for suspend to ram or s2idle */
>> -       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
>> +       if ((adev->in_prepare) && (adev->flags & AMD_IS_APU))
> 
> Could probably simplify this to:
> if ((!adev->in_s4) && (adev->flags & AMD_IS_APU))
> 
> Then you could drop the in_prepare variable.
> 
>>                  return 0;
>>
>>          ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
>> @@ -4521,10 +4521,12 @@ int amdgpu_device_prepare(struct drm_device *dev)
>>          if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>                  return 0;
>>
>> +       adev->in_prepare = true;
>> +
>>          /* Evict the majority of BOs before starting suspend sequence */
>>          r = amdgpu_device_evict_resources(adev);
>>          if (r)
>> -               return r;
>> +               goto unprepare;
>>
>>          for (i = 0; i < adev->num_ip_blocks; i++) {
>>                  if (!adev->ip_blocks[i].status.valid)
>> @@ -4533,10 +4535,46 @@ int amdgpu_device_prepare(struct drm_device *dev)
>>                          continue;
>>                  r = adev->ip_blocks[i].version->funcs->prepare_suspend((void *)adev);
>>                  if (r)
>> -                       return r;
>> +                       goto unprepare;
>>          }
>>
>> -       return 0;
>> +unprepare:
>> +       adev->in_prepare = FALSE;
>> +
>> +       return r;
>> +}
>> +
>> +/**
>> + * amdgpu_device_freeze - run S4 sequence
>> + *
>> + * @dev: drm dev pointer
>> + *
>> + * Prepare to put the hw in the S4 state (all asics).
>> + * Returns 0 for success or an error on failure.
>> + * Called at driver freeze.
>> + */
>> +int amdgpu_device_freeze(struct drm_device *drm_dev)
>> +{
>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +       int r;
>> +
>> +       adev->in_s4 = true;
>> +
>> +       r = amdgpu_device_evict_resources(adev);
> 
> Won't this be too late to allocate memory?  Doesn't this need to
> happen in prepare() even for S4?

Hmm; possibly.  I'll swap it back with your other suggestion.

Thanks
> 
> Alex
> 
>> +       if (r)
>> +               goto cleanup;
>> +
>> +       r = amdgpu_device_suspend(drm_dev, true);
>> +       if (r)
>> +               goto cleanup;
>> +
>> +       if (amdgpu_acpi_should_gpu_reset(adev))
>> +               r = amdgpu_asic_reset(adev);
>> +
>> +cleanup:
>> +       adev->in_s4 = false;
>> +
>> +       return r;
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b74f68a15802..fc9caa14c9d6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2456,6 +2456,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
>>   {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>>          struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +       int r;
>>
>>          /* Return a positive number here so
>>           * DPM_FLAG_SMART_SUSPEND works properly
>> @@ -2464,13 +2465,6 @@ static int amdgpu_pmops_prepare(struct device *dev)
>>              pm_runtime_suspended(dev))
>>                  return 1;
>>
>> -       /* if we will not support s3 or s2i for the device
>> -        *  then skip suspend
>> -        */
>> -       if (!amdgpu_acpi_is_s0ix_active(adev) &&
>> -           !amdgpu_acpi_is_s3_active(adev))
>> -               return 1;
>> -
>>          return amdgpu_device_prepare(drm_dev);
>>   }
>>
>> @@ -2488,6 +2482,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
>>                  adev->in_s0ix = true;
>>          else if (amdgpu_acpi_is_s3_active(adev))
>>                  adev->in_s3 = true;
>> +
>>          if (!adev->in_s0ix && !adev->in_s3)
>>                  return 0;
>>          return amdgpu_device_suspend(drm_dev, true);
>> @@ -2528,18 +2523,8 @@ static int amdgpu_pmops_resume(struct device *dev)
>>   static int amdgpu_pmops_freeze(struct device *dev)
>>   {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> -       int r;
>> -
>> -       adev->in_s4 = true;
>> -       r = amdgpu_device_suspend(drm_dev, true);
>> -       adev->in_s4 = false;
>> -       if (r)
>> -               return r;
>>
>> -       if (amdgpu_acpi_should_gpu_reset(adev))
>> -               return amdgpu_asic_reset(adev);
>> -       return 0;
>> +       return amdgpu_device_freeze(drm_dev);
>>   }
>>
>>   static int amdgpu_pmops_thaw(struct device *dev)
>> --
>> 2.34.1
>>

