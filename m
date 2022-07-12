Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F7EC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 18:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E241E95C61;
	Tue, 12 Jul 2022 18:31:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BFCC95C61
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 18:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrrLp0HMCfvPfkUwJuIGIu5K9YbOph+qglSFjaZZieKDQNqgkHpoFkwC73lsBeklI/TFlaNc2pdfWKXW996DYLLgc+jt2JNUeZB50qxLCqE+ghmYVOcZ0IxR4eNCL6sCeiN0b04to97ZNciPmyHJTAVdsqm4lfEj/mzS9Xq5JJDTOvyPQxj5LxMeYUe5BOmqf95Ob3gYjhRlykK6NjslasYEYmX2v2urx8zgF205htbVwf4V7WIbvUAJB75hIRxfyYe42yrc4U+4rNLx0e8d3uOv4/a4TBS2DUchpvObkX47Fq5XaV8ae731i7fjciL2ZurQbuXGN7uOmxJbVu6V3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmNqUeRw3AaIX7ZzR4YD/6DwrNDEDkDlgCAB8gskN88=;
 b=fZFmbGC7n6BTryWdSlcw+qtIHusI3uxYGYA3nBxkbTIiILi3dlpljmv+JCB7Br0/Fp/MHVWYmnrn5I6THC43iCERW6UBhvt7wfsDWBupxeEOKGjIYKDRig2B7KQmvhLofetB3rZBk4cFI0Hb4a/vwUAEbCMwxyrAUdyZIYCjrZtbO9RqITV7krrwoajuTe5zFnnzyH4pBo8JVs1zAsDg56c8HN6Zuap4P9HfXhBsdDk+YrAiBEhGLFdBtqgijp3NE4ycjeZW9MFanMB9Oy/+Xj2KrwgIwuFy5RYrVJWeXkj5w5/4l0vIVMr56ynV1RXiiALbtDbUQv4Q9yaK0Zae8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmNqUeRw3AaIX7ZzR4YD/6DwrNDEDkDlgCAB8gskN88=;
 b=Z1xsCcvukLYlwMB25XGyuXrEx0hGQzQIAoxs2pREyp4cCMJm4puB5UmONkKaQstvqR5I4ukFvNHt3umuvm9VDST5XeBHX9B//qhRrakX0ZN/G7rIlpa7sIcuhRA1PXxN2Sij93klrPhqFJnq+2EfZ1bldJtKL6xpZLT7yUG/i4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR12MB4662.namprd12.prod.outlook.com (2603:10b6:4:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 18:31:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 18:31:18 +0000
Message-ID: <45c83d58-1d82-9461-1233-af495fce834e@amd.com>
Date: Tue, 12 Jul 2022 14:31:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: Ensure valid event timestamp for
 cursor-only commits
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?Q?Michel_D=c3=a4nzer?=
 <michel@daenzer.net>
References: <20220711145131.712825-1-michel@daenzer.net>
 <CADnq5_PhLo4wX8vT3ZddxJ5qL0WonxOVRgou+12XtWpiM4Kwrg@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_PhLo4wX8vT3ZddxJ5qL0WonxOVRgou+12XtWpiM4Kwrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::27)
 To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4735cf89-64bc-4053-f0ad-08da6434b5d1
X-MS-TrafficTypeDiagnostic: DM5PR12MB4662:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQH8g8ruHMMlxNJpYgcm6WKunJW1uJEfweoEN+ZtJi6hVgGSQWzHpYHpdWR0T5+lGU4nrWgI9RPdlvzEGgN7gZXzOGP5XcecKDILT+6ACcUgC5LkJhNIRiXwG2z0+mnNqyoInrKLVMgNjjk9XlKN2iiwh2eGpWRzvq3T4bbgqXsXXXtCiteODZon/fKLrvB6UmWO3CgmUV5t/VPyG2/OXH4A4dwSUpdvDUDRz8Vvqv3p17kHMPEvN6TGueIcbowMOcyZR5wZiUs/nsqePuWf5ZN0PrwnQQb432U2tgSiYYsKJPo9Qe9+FqklpjP86M2CXV3DB+ITK0I8+0BfhwvjzUcGrxUInqWWPwm1DIksgfAZPKud70wZnAQ4lLYQNj9sx3Iuwd/XIXa+o4HXq8QQXPzNIcNZiGHy3a1dVLMnNIjU3/1JR+e03tpRg8U0poJLAfc1SVWbOAGTPUtQDutzUPF7GUSA5a+dG07YabLlCg1axHUADZ+iJRl6k85PXjiZYqIJpJ5prEdhQyjHUtiyvknXWhXPGdSLzeTVHFPaBgvSa3LKfyRrDtsTkisZ/GQLsVm45pvEwF7CcD9E6gSfG/bSpSj9kcKrHt8VPV3Zcr2Iv1xFLWVsG8I9lpmORMA88Lh3wN63KYUZPN53bLo5WZ0sps6fmzvvS/JHryTTWYeV0sLYFkns3bhYpTb7RkNgzVhngU62gnmTglM5+TgEi1WD0slVHQ1v+MDCWElWjyZfRL4lhIdnMRSU0cGJZkLr4ua3hcVP8Q6GrCZmdfBMkweeVAP2tHcvFqd2bFIFyB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(36756003)(26005)(66574015)(31686004)(6512007)(6506007)(66946007)(66476007)(38100700002)(66556008)(8676002)(31696002)(41300700001)(186003)(6666004)(53546011)(4326008)(86362001)(6486002)(316002)(5660300002)(83380400001)(2616005)(54906003)(8936002)(966005)(110136005)(44832011)(2906002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEhDUnFwYjMrcG1OQjBjbWhTTzVpelRlRzdnSTMzMERXVFpiM3FBS2hZdlBD?=
 =?utf-8?B?MWN3bEdWSnBiYWFmMEExaWswb3JYT2M4ZFpQN1JlMTNBZUFESC95NGl6UkJY?=
 =?utf-8?B?MURPL25TT1JFMlo2bldES21ONUdPQmlMYTMydEVkc0pzdk85Y1BoMXZNU0xB?=
 =?utf-8?B?dW9OdGtnNFVnOVluelRxdm1oYm9JSEVOSGM2Q05XWG5HbEVJZUtJT0d3SHhh?=
 =?utf-8?B?WWkraUJmSG5WbDlGdHhCT1p5N29Ta1R2Y2h5WHQ1MWY4c05VU0pPUi91Rkpo?=
 =?utf-8?B?cXlVOFYrZEhxazFWRUwveWQzT0REOTgyR0NNNCt1d3ZYUW9VM0VKN0JsVHJ6?=
 =?utf-8?B?MzgrRlI0enRFN1dlOGRscnd3clhsdllzNzE5dkJEaHR0TFBuVyt2b1Axakx4?=
 =?utf-8?B?ZDZIdGp3Ni9kU3Q0dHlQQTh4THdOOFQxeUd3cU8rY3pBUysyQzd1K0pKYmpB?=
 =?utf-8?B?bFBRMmVGRTVjQlBLU3l0YStUZU1Gelp4c0xYNGtsV2hLWmt4TWVzTkwxbVEz?=
 =?utf-8?B?Z3BqWnZYbUxraXY0cExOU2RYYVg0OUVRWXIyT1ZWWFRvZ1hSWm5vdkpNTE9H?=
 =?utf-8?B?Vk9xTUlQRUsveFZnNHRvbzJMcjRyOWVkUmVLR2FhWklJRkovb1NURVJITW9U?=
 =?utf-8?B?c0YyMUZtV1FrUzc2a2taOCtJRDdSTjk2MEJaMWFhQkdHenJrN3Y0UUR3NFRp?=
 =?utf-8?B?WExCU2hwcVNRN1BiS1RwMTM3cVY0SGlPbW0vazBNZ3BrbHA4MU5maTd6WmIz?=
 =?utf-8?B?WmFLV0o2Qmk0OG5NQVd5dVN1eUZqcVZWRW45Yk1GUXFXY2FzeiswV3dwSk9a?=
 =?utf-8?B?akVsZXN0eTdyUkV3ckRvbmdyVFBTR3J3NlQycHhsMGFqckMzdWN4Qk9ndHlC?=
 =?utf-8?B?MlNuNGt2SXllVE9jOTlNYmlQTjZVVVc3TmdVblVCT2xuWXVKSWp1MGVya0hM?=
 =?utf-8?B?azdGNFk5MU91c3k3NWkwekkvbmw3QjUvWkkvUVI2WWFONXBUZERCSDNpUFJS?=
 =?utf-8?B?SnMxUTlmbkdnTlNNL0cxYjRYRW1ULzMwQzhnblJnQlZOclFMOXVvNkNWZWdk?=
 =?utf-8?B?MWdYTE84azZVaFR3cFV1eWNtaWdOMHRUQ2V0QUtoaE9yNTRGTzlVNnBYZTZS?=
 =?utf-8?B?KzZQNTdKUXFjT2htNllBNCsxQWFWZVgxanhkOEVHSTE0RTAzZ2xzT1Bqd3hr?=
 =?utf-8?B?czZTWWtkODdNbThHT0E3aXZqL0Q3R3ZpYTJ5RG5YdmFDcDM0dno1Um9WL2hi?=
 =?utf-8?B?VGNpRXA5aUl4ekVxZGJRNXZ2RHZjeTVXMkpmZFFoeHh4TkVEVUJla0txbmMz?=
 =?utf-8?B?NHd6ZHZxcUdWaWxsZWpFMkh4ajl1eGl4d2JNa0xUYzdDc0s5MElvM1BmQ1lx?=
 =?utf-8?B?N3ZmeTFVaUlXc0ZlQzFoU0pVazMvMjR2UStmTnk5UDJRQ0RBd2lZQXl4VFpU?=
 =?utf-8?B?czd4cGc1YmNJbTNKcG5tWm9adFRVMHE2UWRsdmNDZXp1UXJrdUkzc3JHbjh2?=
 =?utf-8?B?SG9EbkJDVkxkRThFam5LMU1rVFFVNkpmNDN5MVQrUVA4T3dtZ29UdWNIOG13?=
 =?utf-8?B?WjZXZjVaTWlTdHJYT2NRRUFQaFRpOTJOZnJ1SGlPS3JocGpZUU5XMXRhWmpn?=
 =?utf-8?B?VHd2R0xZakNWR0lXR0xrYVp5cW55OVRsKzVRZ2lHYVVydVN6R3FZQ0U4TW9I?=
 =?utf-8?B?Ky8ycnlKcnBJZ3VYMlJKSWFlTVdNNXRYak9IaTQxOUxIQkYwRHpacTVZQ0tx?=
 =?utf-8?B?d3V6dnVYVzdnTUVwdXRidWFwYy96ZE1oNEpjZ2o2dmtCeXhObktUMFpFQjhF?=
 =?utf-8?B?VlZUb0VZSGlyeVB3ME1TemtzUDI4UXFLOElLYXJEWHVsRGRjMTgrVmpBWGhF?=
 =?utf-8?B?dVdaR1lYM3MrR2F2MUVaR2NHWnpCTkIwcVU5V2E4c3Y3OVFlcElQVjNnK3Bz?=
 =?utf-8?B?VldaakJLR0d5VUZrSzRoWGNwaERPZ25CUlJaNDltSHF2WmNBYmFtaHhKUnZW?=
 =?utf-8?B?QWpkbm5vTnJTemJzNWdVOXpsYkZDdEIwY1YrOW5iMlVoMXZJMktiT3NRbWJE?=
 =?utf-8?B?L1JRV2V0Y1A0WmR3ck8rMVl4MC9kOWhxbnJXbzZjK2JOU2NpUzJlMG5qNThF?=
 =?utf-8?Q?k6CS0H3qDQ/3AqK6ZxwY8XFXF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4735cf89-64bc-4053-f0ad-08da6434b5d1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 18:31:17.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/SCatRFGJdLpDvhhKJStinaXJ5d2IU/0j2lpRijrQFFSLusWFPO/mXqzCXuiPFoLa0X91SM2HwLAZkS4ASdvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4662
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
Cc: Leo Li <sunpeng.li@amd.com>, Dor Askayo <dor.askayo@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-12 11:23, Alex Deucher wrote:
> On Mon, Jul 11, 2022 at 10:51 AM Michel Dänzer <michel@daenzer.net> wrote:
>>
>> From: Michel Dänzer <mdaenzer@redhat.com>
>>
>> Requires enabling the vblank machinery for them.
>>
>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2030>>> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> 
> This looks correct to me, but it would be good if one of the display
> guys could take a look.
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 

Looks fine to me.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Alex
> 
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 +++++++++++++++++--
>>  1 file changed, 40 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 9dd2e0601ea8..b0667e2f3fdd 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -462,6 +462,26 @@ static void dm_pflip_high_irq(void *interrupt_params)
>>                      vrr_active, (int) !e);
>>  }
>>
>> +static void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
>> +{
>> +       struct drm_crtc *crtc = &acrtc->base;
>> +       struct drm_device *dev = crtc->dev;
>> +       unsigned long flags;
>> +
>> +       drm_crtc_handle_vblank(crtc);
>> +
>> +       spin_lock_irqsave(&dev->event_lock, flags);
>> +
>> +       /* Send completion event for cursor-only commits */
>> +       if (acrtc->event && acrtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
>> +               drm_crtc_send_vblank_event(crtc, acrtc->event);
>> +               drm_crtc_vblank_put(crtc);
>> +               acrtc->event = NULL;
>> +       }
>> +
>> +       spin_unlock_irqrestore(&dev->event_lock, flags);
>> +}
>> +
>>  static void dm_vupdate_high_irq(void *interrupt_params)
>>  {
>>         struct common_irq_params *irq_params = interrupt_params;
>> @@ -500,7 +520,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>>                  * if a pageflip happened inside front-porch.
>>                  */
>>                 if (vrr_active) {
>> -                       drm_crtc_handle_vblank(&acrtc->base);
>> +                       dm_crtc_handle_vblank(acrtc);
>>
>>                         /* BTR processing for pre-DCE12 ASICs */
>>                         if (acrtc->dm_irq_params.stream &&
>> @@ -552,7 +572,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>>          * to dm_vupdate_high_irq after end of front-porch.
>>          */
>>         if (!vrr_active)
>> -               drm_crtc_handle_vblank(&acrtc->base);
>> +               dm_crtc_handle_vblank(acrtc);
>>
>>         /**
>>          * Following stuff must happen at start of vblank, for crc
>> @@ -9134,6 +9154,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>         struct amdgpu_bo *abo;
>>         uint32_t target_vblank, last_flip_vblank;
>>         bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
>> +       bool cursor_update = false;
>>         bool pflip_present = false;
>>         struct {
>>                 struct dc_surface_update surface_updates[MAX_SURFACES];
>> @@ -9169,8 +9190,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>                 struct dm_plane_state *dm_new_plane_state = to_dm_plane_state(new_plane_state);
>>
>>                 /* Cursor plane is handled after stream updates */
>> -               if (plane->type == DRM_PLANE_TYPE_CURSOR)
>> +               if (plane->type == DRM_PLANE_TYPE_CURSOR) {
>> +                       if ((fb && crtc == pcrtc) ||
>> +                           (old_plane_state->fb && old_plane_state->crtc == pcrtc))
>> +                               cursor_update = true;
>> +
>>                         continue;
>> +               }
>>
>>                 if (!fb || !crtc || pcrtc != crtc)
>>                         continue;
>> @@ -9333,6 +9359,17 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>                                 bundle->stream_update.vrr_infopacket =
>>                                         &acrtc_state->stream->vrr_infopacket;
>>                 }
>> +       } else if (cursor_update && acrtc_state->active_planes > 0 &&
>> +                  !acrtc_state->force_dpms_off &&
>> +                  acrtc_attach->base.state->event) {
>> +               drm_crtc_vblank_get(pcrtc);
>> +
>> +               spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>> +
>> +               acrtc_attach->event = acrtc_attach->base.state->event;
>> +               acrtc_attach->base.state->event = NULL;
>> +
>> +               spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>>         }
>>
>>         /* Update the planes if changed or disable if we don't have any. */
>> --
>> 2.36.1
>>

