Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9F1C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 08:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09552068E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QKQvPZn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09552068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73426E2DA;
	Fri, 14 Aug 2020 08:10:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1916E2DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 08:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwkPIKMTLitBcKyif7VC6hw4VbchY3IxCEwpjyJVChzT8Sa1Mz1K13GLaJOHRYwHGdJiTcJRHMZZ5PX2q3BNPv9aYWaj3V2Yt9Q5byHDvYXiqhXow+2z3//eXStUSX0kHiX9YlSZH2VGX0x3aKM+BHcvOFIlNfgD2ic5k5nqpyewqNNSAQRUvpByYV8CUTcnVf+TzDQqrqxjerXI8LsXAuJoJZUpRqZ/bzUaPRmjOboN2RVK19iJMiU8UQpagQVi1Fo7+7lhPTHUnQdZx1bh9v6La+t4DMFrDFGPCtXPg9Y0WfHl+ys7oM8OBuxKF8VNwADgGPzJtI7KaAXed9aLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAyx3rRj3HDsJxmEyfHCtR5unUzP8UwqSMB64psWiSw=;
 b=AK2Uo/bpz/LcWvLhprFOTArv4sO6jIMbZhDnz1mSazAyFDYIk2vvat13w4RODRfLEXtiaQyRwV/4d/+ZcmAsHKmcf/8Sn/g1mZl73WJzOvgKKBiDPvoE3cFaNHVM4znbqdC4/Kaaj2Cf1rMC+Dlr/IxtRXW1AVcmxHQ6LccV/Ku0iHuLseG+K17UjeOt+YDD1nlVjb/THUY4PBzmKSFhV/OXwxIuhXIZ99HQa5+QzvDVXeCfgZu+fzwniimGjnCP4TfK2WO5Q1Y6LRbzu7Uj/U17A2fuhVFFCInIyXzKl5rebSbcP0deH9E5ie2Oxhf/jXh+f3+x9xZK2/3i+90JWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAyx3rRj3HDsJxmEyfHCtR5unUzP8UwqSMB64psWiSw=;
 b=QKQvPZn2lrFrIad6qXnlZLnTN2547nrP4wRgVs1jCdDgwXKqWsvfwOWg/sTd4HJcQvAwKMeZ6d4O7/EjY2IckBvbBz/h2G+2lIq9/k6JF4yUQwGMECmMcc8Mg3D4GmvHpspuUXaAUruXF93DBP9DuZdpT/zcZgG9M11OyUW//KE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 08:10:27 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.020; Fri, 14 Aug 2020
 08:10:27 +0000
Subject: Re: [PATCH 4/4] drm/amd/powerplay: put those exposed power interfaces
 in amdgpu_dpm.c
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Das, Nirmoy" <Nirmoy.Das@amd.com>
References: <20200813090819.32115-1-evan.quan@amd.com>
 <20200813090819.32115-4-evan.quan@amd.com>
 <90cf2433-2c27-5a76-d08b-6838a6aa8c88@amd.com>
 <CADnq5_PyXxBssM7kY8Z=5YDSV18OOb5kP_ammSt4sO+R-dmjxg@mail.gmail.com>
 <DM6PR12MB2619C61D59A39EFE8B5FE6BDE4400@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <24994b8d-f99f-658f-2fa8-321f60cacaa3@amd.com>
Date: Fri, 14 Aug 2020 10:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB2619C61D59A39EFE8B5FE6BDE4400@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.108.42) by
 AM0PR07CA0008.eurprd07.prod.outlook.com (2603:10a6:208:ac::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.13 via Frontend Transport; Fri, 14 Aug 2020 08:10:26 +0000
X-Originating-IP: [217.86.108.42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7c6b6de-421f-4086-f9a6-08d8402980c6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23739F57F7CF8FAFC4A0232F8B400@DM5PR12MB2373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1+xs8z96mZ5y00bUHo7/KQy+YU+a/zaL7Vqpli9W63kvTRgiz/K11Lwl3nb2Fl/BWnHj3VOXUd1dd03ROC9bb1RWFyHQ1uER12qoDW7I78ND3qe8DbDpMfnCoNKIZUsK0N7jZ0O8+QYXpMuBcW70+rFoOAvkecc1gChgVFM4b3K1qQcGjOTSDdX8/P1jkuVW9NIX/masQ5acS5zheop59qBuyikQvqwCX7C68xSWqyCy7DBNBT1kDTxHq1vNzDTEJlj9hgY8dH2jW8gJW/YZZ6THNvYkZI22EG7rq9vVNOP6/Tilsz2eugpK4XCIB4Pz+LHrGSzmm3h9HVwFZbv1rfaJPUp8bKh37Ro3Axfz9cuaZcdp2WvysTMqLpLOXkpbQoukTO5rpMsaHTzjlNDneFFmJmWfjWKEOtCwDwkjGWheV18awU9dGoM4OPiMyXX+8jwuzu6dd384OGCczv+yaaFlyuuKgHAEiNxtEoafKpgk0VXFv6kICsDwUMeZq6t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(26005)(6486002)(31686004)(31696002)(5660300002)(36756003)(83380400001)(45080400002)(2616005)(16526019)(186003)(30864003)(6666004)(316002)(8936002)(53546011)(956004)(52116002)(966005)(4326008)(66946007)(54906003)(478600001)(6636002)(110136005)(66556008)(8676002)(2906002)(16576012)(83080400001)(66476007)(31153001)(21314003)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JHu8yKazZa/e4TArh+EKvqZLDcU+3jNncOY63ubYFxgdk0thMlC9syW6Mv03034dClDr4qoCW+WFSXx12M4xDiiZvKlKfHI62Qyqbjs9vl6NZS88lrMXC021CRK97ewr2IbkbcwmDMialMf1Mh+LEdSPLxH7VQ+jUhpL1qNiF31phRGSJr47xqt/As9FO+gvR2hmESxHZ0sLS4UeN4Zi/BtgZeKlbnVmkX0A950KRnxVqbAbc0RUA4f6WzS67Jk3Oa1YmWtJpuDRAuszWRyvDw0JSfy09uC3a3Nvg7q32u8NMEHXWbxb8FeGEgXD+Q9BWA3TNBWwp7eK7PkikaX2fyA+QHBZ17NBIXrSwMkmXuMD6Md1Mq/jzD2IkCYROiJYji2dLd4rPxMgIPEriO3P6YDcqT7A0BEU68ziqLf9tjGhu9Cr+ODHNErn4RO24kmx5RW9Vg3KCtXJUiIPuPilbuKLRbBDEWW2liPebJkuWyjdJmDsg072GkZbfFaE0KuXe/64s0LqLwecNwNY1qSY8wrWDmC/PjV4z+ImuSJG4iciS+10wfGbqFCZxQYMSdA9o6OFGP2hjj+dsmRWP51HuK+rz2wy6QMyGRWAgx+2jJklAJLrxNiqGfEzL9qMyQvPORdF1IKUxDLnQij06a3OBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c6b6de-421f-4086-f9a6-08d8402980c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 08:10:27.6792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CngwCwpFiFcCRnzE4WbUqb4sP6Z2FTpXxvS29518PjrBfQ+/wGnpSdF5VNOyml8IbL8MuEIfUrIHyVMriY4m6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/14/20 4:56 AM, Quan, Evan wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Yes, I would like to make another patch to address Nirmoy's comments.
> @Das, Nirmoy is that OK?


Yes.


Nirmoy

>
> BR
> Evan
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, August 13, 2020 9:54 PM
> To: Das, Nirmoy <Nirmoy.Das@amd.com>
> Cc: Quan, Evan <Evan.Quan@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 4/4] drm/amd/powerplay: put those exposed power interfaces in amdgpu_dpm.c
>
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com> Nirmoy makes some good points below, but I think those should be a follow up patch as this patch is just moving code around; no actual changes.
>
> Alex
>
> On Thu, Aug 13, 2020 at 6:52 AM Nirmoy <nirmodas@amd.com> wrote:
>> Acked-by: Nirmoy Das <nirmoy.das@amd.com> for 1st 3 patches. Check for
>> below for
>>
>> more comments.
>>
>> On 8/13/20 11:08 AM, Evan Quan wrote:
>>> As other power interfaces.
>>>
>>> Change-Id: I5e3b85ae21c4b1d0239f54fa75247b33cfdb7ddc
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 425 ++++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h |  14 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c  | 423 -----------------------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h  |   8 -
>>>    4 files changed, 439 insertions(+), 431 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
>>> index 2198148319e2..e114b5cbd8b0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
>>> @@ -28,6 +28,11 @@
>>>    #include "amdgpu_dpm.h"
>>>    #include "atom.h"
>>>    #include "amd_pcie.h"
>>> +#include "amdgpu_display.h"
>>> +#include "hwmgr.h"
>>> +#include <linux/power_supply.h>
>>> +
>>> +#define WIDTH_4K 3840
>>>
>>>    void amdgpu_dpm_print_class_info(u32 class, u32 class2)
>>>    {
>>> @@ -1262,3 +1267,423 @@ int amdgpu_dpm_smu_i2c_bus_access(struct
>>> amdgpu_device *adev,
>>>
>>>        return ret;
>>>    }
>>> +
>>> +void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev) {
>>> +     if (adev->pm.dpm_enabled) {
>>> +             mutex_lock(&adev->pm.mutex);
>>> +             if (power_supply_is_system_supplied() > 0)
>>> +                     adev->pm.ac_power = true;
>>> +             else
>>> +                     adev->pm.ac_power = false;
>>> +             if (adev->powerplay.pp_funcs &&
>>> +                 adev->powerplay.pp_funcs->enable_bapm)
>>> +                     amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
>>> +             mutex_unlock(&adev->pm.mutex);
>>> +
>>> +             if (is_support_sw_smu(adev))
>>> +                     smu_set_ac_dc(&adev->smu);
>>> +     }
>>> +}
>>> +
>>> +int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
>>> +                        void *data, uint32_t *size) {
>>> +     int ret = 0;
>>> +
>>> +     if (!data || !size)
>>> +             return -EINVAL;
>>> +
>>> +     if (is_support_sw_smu(adev))
>>> +             ret = smu_read_sensor(&adev->smu, sensor, data, size);
>>> +     else {
>>> +             if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->read_sensor)
>>> +                     ret = adev->powerplay.pp_funcs->read_sensor((adev)->powerplay.pp_handle,
>>> +                                                                 sensor, data, size);
>>> +             else
>>> +                     ret = -EINVAL;
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +void amdgpu_dpm_thermal_work_handler(struct work_struct *work) {
>>> +     struct amdgpu_device *adev =
>>> +             container_of(work, struct amdgpu_device,
>>> +                          pm.dpm.thermal.work);
>>> +     /* switch to the thermal state */
>>> +     enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
>>> +     int temp, size = sizeof(temp);
>>> +
>>> +     if (!adev->pm.dpm_enabled)
>>> +             return;
>>> +
>>> +     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP,
>>> +                                 (void *)&temp, &size)) {
>>> +             if (temp < adev->pm.dpm.thermal.min_temp)
>>> +                     /* switch back the user state */
>>> +                     dpm_state = adev->pm.dpm.user_state;
>>> +     } else {
>>> +             if (adev->pm.dpm.thermal.high_to_low)
>>> +                     /* switch back the user state */
>>> +                     dpm_state = adev->pm.dpm.user_state;
>>> +     }
>>> +     mutex_lock(&adev->pm.mutex);
>>> +     if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
>>> +             adev->pm.dpm.thermal_active = true;
>>> +     else
>>> +             adev->pm.dpm.thermal_active = false;
>>> +     adev->pm.dpm.state = dpm_state;
>>> +     mutex_unlock(&adev->pm.mutex);
>>> +
>>> +     amdgpu_pm_compute_clocks(adev); }
>>> +
>>> +static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
>>> +                                                  enum
>>> +amd_pm_state_type dpm_state) {
>>> +     int i;
>>> +     struct amdgpu_ps *ps;
>>> +     u32 ui_class;
>>> +     bool single_display = (adev->pm.dpm.new_active_crtc_count < 2) ?
>>> +             true : false;
>>> +
>>> +     /* check if the vblank period is too short to adjust the mclk */
>>> +     if (single_display && adev->powerplay.pp_funcs->vblank_too_short) {
>>> +             if (amdgpu_dpm_vblank_too_short(adev))
>>> +                     single_display = false;
>>> +     }
>>> +
>>> +     /* certain older asics have a separare 3D performance state,
>>> +      * so try that first if the user selected performance
>>> +      */
>>> +     if (dpm_state == POWER_STATE_TYPE_PERFORMANCE)
>>> +             dpm_state = POWER_STATE_TYPE_INTERNAL_3DPERF;
>>> +     /* balanced states don't exist at the moment */
>>> +     if (dpm_state == POWER_STATE_TYPE_BALANCED)
>>> +             dpm_state = POWER_STATE_TYPE_PERFORMANCE;
>>> +
>>> +restart_search:
>>> +     /* Pick the best power state based on current conditions */
>>> +     for (i = 0; i < adev->pm.dpm.num_ps; i++) {
>>> +             ps = &adev->pm.dpm.ps[i];
>>> +             ui_class = ps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK;
>>> +             switch (dpm_state) {
>>> +             /* user states */
>>> +             case POWER_STATE_TYPE_BATTERY:
>>> +                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BATTERY) {
>>> +                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
>>> +                                     if (single_display)
>>> +                                             return ps;
>>> +                             } else
>>> +                                     return ps;
>>> +                     }
>>> +                     break;
>>> +             case POWER_STATE_TYPE_BALANCED:
>>> +                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BALANCED) {
>>> +                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
>>> +                                     if (single_display)
>>> +                                             return ps;
>>> +                             } else
>>> +                                     return ps;
>>> +                     }
>>> +                     break;
>>> +             case POWER_STATE_TYPE_PERFORMANCE:
>>> +                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
>>> +                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
>>> +                                     if (single_display)
>>> +                                             return ps;
>>> +                             } else
>>> +                                     return ps;
>>> +                     }
>>> +                     break;
>>> +             /* internal states */
>>> +             case POWER_STATE_TYPE_INTERNAL_UVD:
>>> +                     if (adev->pm.dpm.uvd_ps)
>>> +                             return adev->pm.dpm.uvd_ps;
>>> +                     else
>>
>> We don't need the "else" here.
>>
>>
>>> +                             break;
>>> +             case POWER_STATE_TYPE_INTERNAL_UVD_SD:
>>> +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_SDSTATE)
>>> +                             return ps;
>>> +                     break;
>>> +             case POWER_STATE_TYPE_INTERNAL_UVD_HD:
>>> +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_HDSTATE)
>>> +                             return ps;
>>> +                     break;
>>> +             case POWER_STATE_TYPE_INTERNAL_UVD_HD2:
>>> +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_HD2STATE)
>>> +                             return ps;
>>> +                     break;
>>> +             case POWER_STATE_TYPE_INTERNAL_UVD_MVC:
>>> +                     if (ps->class2 & ATOM_PPLIB_CLASSIFICATION2_MVC)
>>> +                             return ps;
>>> +                     break;
>>> +             case POWER_STATE_TYPE_INTERNAL_BOOT:
>>> +                     return adev->pm.dpm.boot_ps;
>>> +             case POWER_STATE_TYPE_INTERNAL_THERMAL:
>>> +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_THERMAL)
>>> +                             return ps;
>>> +                     break;
>>> +             case POWER_STATE_TYPE_INTERNAL_ACPI:
>>> +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_ACPI)
>>> +                             return ps;
>>> +                     break;
>>> +             case POWER_STATE_TYPE_INTERNAL_ULV:
>>> +                     if (ps->class2 & ATOM_PPLIB_CLASSIFICATION2_ULV)
>>> +                             return ps;
>>> +                     break;
>>> +             case POWER_STATE_TYPE_INTERNAL_3DPERF:
>>> +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE)
>>> +                             return ps;
>>> +                     break;
>>> +             default:
>>> +                     break;
>>> +             }
>>> +     }
>>> +     /* use a fallback state if we didn't match */
>>> +     switch (dpm_state) {
>>> +     case POWER_STATE_TYPE_INTERNAL_UVD_SD:
>>> +             dpm_state = POWER_STATE_TYPE_INTERNAL_UVD_HD;
>>> +             goto restart_search;
>>> +     case POWER_STATE_TYPE_INTERNAL_UVD_HD:
>>> +     case POWER_STATE_TYPE_INTERNAL_UVD_HD2:
>>> +     case POWER_STATE_TYPE_INTERNAL_UVD_MVC:
>>> +             if (adev->pm.dpm.uvd_ps) {
>>> +                     return adev->pm.dpm.uvd_ps;
>>> +             } else {
>>> +                     dpm_state = POWER_STATE_TYPE_PERFORMANCE;
>>> +                     goto restart_search;
>>> +             }
>>> +     case POWER_STATE_TYPE_INTERNAL_THERMAL:
>>> +             dpm_state = POWER_STATE_TYPE_INTERNAL_ACPI;
>>> +             goto restart_search;
>>> +     case POWER_STATE_TYPE_INTERNAL_ACPI:
>>> +             dpm_state = POWER_STATE_TYPE_BATTERY;
>>> +             goto restart_search;
>>> +     case POWER_STATE_TYPE_BATTERY:
>>> +     case POWER_STATE_TYPE_BALANCED:
>>> +     case POWER_STATE_TYPE_INTERNAL_3DPERF:
>>> +             dpm_state = POWER_STATE_TYPE_PERFORMANCE;
>>> +             goto restart_search;
>>
>> I think it will be a good idea to move restart_search block to a
>> function so we can easily
>>
>> rule out any infinite loops with "goto restart_search" usages.
>>
>>
>>
>>> +     default:
>>> +             break;
>>> +     }
>>> +
>>> +     return NULL;
>>> +}
>>> +
>>> +static void amdgpu_dpm_change_power_state_locked(struct
>>> +amdgpu_device *adev) {
>>> +     struct amdgpu_ps *ps;
>>> +     enum amd_pm_state_type dpm_state;
>>> +     int ret;
>>> +     bool equal = false;
>>> +
>>> +     /* if dpm init failed */
>>> +     if (!adev->pm.dpm_enabled)
>>> +             return;
>>> +
>>> +     if (adev->pm.dpm.user_state != adev->pm.dpm.state) {
>>> +             /* add other state override checks here */
>>> +             if ((!adev->pm.dpm.thermal_active) &&
>>> +                 (!adev->pm.dpm.uvd_active))
>>> +                     adev->pm.dpm.state = adev->pm.dpm.user_state;
>>> +     }
>>> +     dpm_state = adev->pm.dpm.state;
>>> +
>>> +     ps = amdgpu_dpm_pick_power_state(adev, dpm_state);
>>> +     if (ps)
>>> +             adev->pm.dpm.requested_ps = ps;
>>> +     else
>>> +             return;
>>
>> nitpick:
>>
>> if(!ns)
>>
>>       return;
>>
>> adev->pm.dpm.requested_ps = ps;
>>
>>
>>> +
>>> +     if (amdgpu_dpm == 1 && adev->powerplay.pp_funcs->print_power_state) {
>>> +             printk("switching from power state:\n");
>>> +             amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
>>> +             printk("switching to power state:\n");
>>> +             amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested_ps);
>>> +     }
>>> +
>>> +     /* update whether vce is active */
>>> +     ps->vce_active = adev->pm.dpm.vce_active;
>>> +     if (adev->powerplay.pp_funcs->display_configuration_changed)
>>> +             amdgpu_dpm_display_configuration_changed(adev);
>>> +
>>> +     ret = amdgpu_dpm_pre_set_power_state(adev);
>>> +     if (ret)
>>> +             return;
>>> +
>>> +     if (adev->powerplay.pp_funcs->check_state_equal) {
>>> +             if (0 != amdgpu_dpm_check_state_equal(adev,
>>> + adev->pm.dpm.current_ps, adev->pm.dpm.requested_ps, &equal))
>>
>> We don't need that check as amdgpu_dpm_check_state_equal() should not
>> modify (default)value of
>>
>> "equal" on error.
>>
>>
>> Nirmoy
>>
>>> +                     equal = false;
>>> +     }
>>> +
>>> +     if (equal)
>>> +             return;
>>> +
>>> +     amdgpu_dpm_set_power_state(adev);
>>> +     amdgpu_dpm_post_set_power_state(adev);
>>> +
>>> +     adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
>>> +     adev->pm.dpm.current_active_crtc_count =
>>> + adev->pm.dpm.new_active_crtc_count;
>>> +
>>> +     if (adev->powerplay.pp_funcs->force_performance_level) {
>>> +             if (adev->pm.dpm.thermal_active) {
>>> +                     enum amd_dpm_forced_level level = adev->pm.dpm.forced_level;
>>> +                     /* force low perf level for thermal */
>>> +                     amdgpu_dpm_force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
>>> +                     /* save the user's level */
>>> +                     adev->pm.dpm.forced_level = level;
>>> +             } else {
>>> +                     /* otherwise, user selected level */
>>> +                     amdgpu_dpm_force_performance_level(adev, adev->pm.dpm.forced_level);
>>> +             }
>>> +     }
>>> +}
>>> +
>>> +void amdgpu_pm_compute_clocks(struct amdgpu_device *adev) {
>>> +     int i = 0;
>>> +
>>> +     if (!adev->pm.dpm_enabled)
>>> +             return;
>>> +
>>> +     if (adev->mode_info.num_crtc)
>>> +             amdgpu_display_bandwidth_update(adev);
>>> +
>>> +     for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>> +             struct amdgpu_ring *ring = adev->rings[i];
>>> +             if (ring && ring->sched.ready)
>>> +                     amdgpu_fence_wait_empty(ring);
>>> +     }
>>> +
>>> +     if (is_support_sw_smu(adev)) {
>>> +             struct smu_dpm_context *smu_dpm = &adev->smu.smu_dpm;
>>> +             smu_handle_task(&adev->smu,
>>> +                             smu_dpm->dpm_level,
>>> +                             AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
>>> +                             true);
>>> +     } else {
>>> +             if (adev->powerplay.pp_funcs->dispatch_tasks) {
>>> +                     if (!amdgpu_device_has_dc_support(adev)) {
>>> +                             mutex_lock(&adev->pm.mutex);
>>> +                             amdgpu_dpm_get_active_displays(adev);
>>> +                             adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
>>> +                             adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
>>> +                             adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
>>> +                             /* we have issues with mclk switching with refresh rates over 120 hz on the non-DC code. */
>>> +                             if (adev->pm.pm_display_cfg.vrefresh > 120)
>>> +                                     adev->pm.pm_display_cfg.min_vblank_time = 0;
>>> +                             if (adev->powerplay.pp_funcs->display_configuration_change)
>>> +                                     adev->powerplay.pp_funcs->display_configuration_change(
>>> +                                                                     adev->powerplay.pp_handle,
>>> +                                                                     &adev->pm.pm_display_cfg);
>>> +                             mutex_unlock(&adev->pm.mutex);
>>> +                     }
>>> +                     amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
>>> +             } else {
>>> +                     mutex_lock(&adev->pm.mutex);
>>> +                     amdgpu_dpm_get_active_displays(adev);
>>> +                     amdgpu_dpm_change_power_state_locked(adev);
>>> +                     mutex_unlock(&adev->pm.mutex);
>>> +             }
>>> +     }
>>> +}
>>> +
>>> +void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>>> +{
>>> +     int ret = 0;
>>> +
>>> +     if (adev->family == AMDGPU_FAMILY_SI) {
>>> +             mutex_lock(&adev->pm.mutex);
>>> +             if (enable) {
>>> +                     adev->pm.dpm.uvd_active = true;
>>> +                     adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
>>> +             } else {
>>> +                     adev->pm.dpm.uvd_active = false;
>>> +             }
>>> +             mutex_unlock(&adev->pm.mutex);
>>> +
>>> +             amdgpu_pm_compute_clocks(adev);
>>> +     } else {
>>> +             ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
>>> +             if (ret)
>>> +                     DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
>>> +                               enable ? "enable" : "disable", ret);
>>> +
>>> +             /* enable/disable Low Memory PState for UVD (4k videos) */
>>> +             if (adev->asic_type == CHIP_STONEY &&
>>> +                     adev->uvd.decode_image_width >= WIDTH_4K) {
>>> +                     struct pp_hwmgr *hwmgr =
>>> + adev->powerplay.pp_handle;
>>> +
>>> +                     if (hwmgr && hwmgr->hwmgr_func &&
>>> +                         hwmgr->hwmgr_func->update_nbdpm_pstate)
>>> +                             hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
>>> +                                                                    !enable,
>>> +                                                                    true);
>>> +             }
>>> +     }
>>> +}
>>> +
>>> +void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>>> +{
>>> +     int ret = 0;
>>> +
>>> +     if (adev->family == AMDGPU_FAMILY_SI) {
>>> +             mutex_lock(&adev->pm.mutex);
>>> +             if (enable) {
>>> +                     adev->pm.dpm.vce_active = true;
>>> +                     /* XXX select vce level based on ring/task */
>>> +                     adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
>>> +             } else {
>>> +                     adev->pm.dpm.vce_active = false;
>>> +             }
>>> +             mutex_unlock(&adev->pm.mutex);
>>> +
>>> +             amdgpu_pm_compute_clocks(adev);
>>> +     } else {
>>> +             ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
>>> +             if (ret)
>>> +                     DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
>>> +                               enable ? "enable" : "disable", ret);
>>> +     }
>>> +}
>>> +
>>> +void amdgpu_pm_print_power_states(struct amdgpu_device *adev) {
>>> +     int i;
>>> +
>>> +     if (adev->powerplay.pp_funcs->print_power_state == NULL)
>>> +             return;
>>> +
>>> +     for (i = 0; i < adev->pm.dpm.num_ps; i++)
>>> +             amdgpu_dpm_print_power_state(adev,
>>> + &adev->pm.dpm.ps[i]);
>>> +
>>> +}
>>> +
>>> +void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool
>>> +enable) {
>>> +     int ret = 0;
>>> +
>>> +     ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
>>> +     if (ret)
>>> +             DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
>>> +                       enable ? "enable" : "disable", ret); }
>>> +
>>> +int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev,
>>> +uint32_t *smu_version) {
>>> +     int r;
>>> +
>>> +     if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->load_firmware) {
>>> +             r = adev->powerplay.pp_funcs->load_firmware(adev->powerplay.pp_handle);
>>> +             if (r) {
>>> +                     pr_err("smu firmware loading failed\n");
>>> +                     return r;
>>> +             }
>>> +             *smu_version = adev->pm.fw_version;
>>> +     }
>>> +     return 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>> index 5a2344f839f2..dff4a5f99bb0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>> @@ -548,4 +548,18 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
>>>    int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
>>>                                  bool acquire);
>>>
>>> +void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
>>> +
>>> +int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
>>> +                        void *data, uint32_t *size);
>>> +
>>> +void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
>>> +
>>> +void amdgpu_pm_compute_clocks(struct amdgpu_device *adev); void
>>> +amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
>>> +void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool
>>> +enable); void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev,
>>> +bool enable); void amdgpu_pm_print_power_states(struct
>>> +amdgpu_device *adev); int amdgpu_pm_load_smu_firmware(struct
>>> +amdgpu_device *adev, uint32_t *smu_version);
>>> +
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>> index 1705e328c6fc..9874f947e2ad 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>> @@ -29,17 +29,14 @@
>>>    #include "amdgpu_drv.h"
>>>    #include "amdgpu_pm.h"
>>>    #include "amdgpu_dpm.h"
>>> -#include "amdgpu_display.h"
>>>    #include "amdgpu_smu.h"
>>>    #include "atom.h"
>>> -#include <linux/power_supply.h>
>>>    #include <linux/pci.h>
>>>    #include <linux/hwmon.h>
>>>    #include <linux/hwmon-sysfs.h>
>>>    #include <linux/nospec.h>
>>>    #include <linux/pm_runtime.h>
>>>    #include "hwmgr.h"
>>> -#define WIDTH_4K 3840
>>>
>>>    static const struct cg_flag_name clocks[] = {
>>>        {AMD_CG_SUPPORT_GFX_MGCG, "Graphics Medium Grain Clock
>>> Gating"}, @@ -81,45 +78,6 @@ static const struct hwmon_temp_label {
>>>        {PP_TEMP_MEM, "mem"},
>>>    };
>>>
>>> -void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev) -{
>>> -     if (adev->pm.dpm_enabled) {
>>> -             mutex_lock(&adev->pm.mutex);
>>> -             if (power_supply_is_system_supplied() > 0)
>>> -                     adev->pm.ac_power = true;
>>> -             else
>>> -                     adev->pm.ac_power = false;
>>> -             if (adev->powerplay.pp_funcs &&
>>> -                 adev->powerplay.pp_funcs->enable_bapm)
>>> -                     amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
>>> -             mutex_unlock(&adev->pm.mutex);
>>> -
>>> -             if (is_support_sw_smu(adev))
>>> -                     smu_set_ac_dc(&adev->smu);
>>> -     }
>>> -}
>>> -
>>> -int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
>>> -                        void *data, uint32_t *size)
>>> -{
>>> -     int ret = 0;
>>> -
>>> -     if (!data || !size)
>>> -             return -EINVAL;
>>> -
>>> -     if (is_support_sw_smu(adev))
>>> -             ret = smu_read_sensor(&adev->smu, sensor, data, size);
>>> -     else {
>>> -             if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->read_sensor)
>>> -                     ret = adev->powerplay.pp_funcs->read_sensor((adev)->powerplay.pp_handle,
>>> -                                                                 sensor, data, size);
>>> -             else
>>> -                     ret = -EINVAL;
>>> -     }
>>> -
>>> -     return ret;
>>> -}
>>> -
>>>    /**
>>>     * DOC: power_dpm_state
>>>     *
>>> @@ -3636,338 +3594,6 @@ static const struct attribute_group *hwmon_groups[] = {
>>>        NULL
>>>    };
>>>
>>> -void amdgpu_dpm_thermal_work_handler(struct work_struct *work) -{
>>> -     struct amdgpu_device *adev =
>>> -             container_of(work, struct amdgpu_device,
>>> -                          pm.dpm.thermal.work);
>>> -     /* switch to the thermal state */
>>> -     enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
>>> -     int temp, size = sizeof(temp);
>>> -
>>> -     if (!adev->pm.dpm_enabled)
>>> -             return;
>>> -
>>> -     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP,
>>> -                                 (void *)&temp, &size)) {
>>> -             if (temp < adev->pm.dpm.thermal.min_temp)
>>> -                     /* switch back the user state */
>>> -                     dpm_state = adev->pm.dpm.user_state;
>>> -     } else {
>>> -             if (adev->pm.dpm.thermal.high_to_low)
>>> -                     /* switch back the user state */
>>> -                     dpm_state = adev->pm.dpm.user_state;
>>> -     }
>>> -     mutex_lock(&adev->pm.mutex);
>>> -     if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
>>> -             adev->pm.dpm.thermal_active = true;
>>> -     else
>>> -             adev->pm.dpm.thermal_active = false;
>>> -     adev->pm.dpm.state = dpm_state;
>>> -     mutex_unlock(&adev->pm.mutex);
>>> -
>>> -     amdgpu_pm_compute_clocks(adev);
>>> -}
>>> -
>>> -static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
>>> -                                                  enum amd_pm_state_type dpm_state)
>>> -{
>>> -     int i;
>>> -     struct amdgpu_ps *ps;
>>> -     u32 ui_class;
>>> -     bool single_display = (adev->pm.dpm.new_active_crtc_count < 2) ?
>>> -             true : false;
>>> -
>>> -     /* check if the vblank period is too short to adjust the mclk */
>>> -     if (single_display && adev->powerplay.pp_funcs->vblank_too_short) {
>>> -             if (amdgpu_dpm_vblank_too_short(adev))
>>> -                     single_display = false;
>>> -     }
>>> -
>>> -     /* certain older asics have a separare 3D performance state,
>>> -      * so try that first if the user selected performance
>>> -      */
>>> -     if (dpm_state == POWER_STATE_TYPE_PERFORMANCE)
>>> -             dpm_state = POWER_STATE_TYPE_INTERNAL_3DPERF;
>>> -     /* balanced states don't exist at the moment */
>>> -     if (dpm_state == POWER_STATE_TYPE_BALANCED)
>>> -             dpm_state = POWER_STATE_TYPE_PERFORMANCE;
>>> -
>>> -restart_search:
>>> -     /* Pick the best power state based on current conditions */
>>> -     for (i = 0; i < adev->pm.dpm.num_ps; i++) {
>>> -             ps = &adev->pm.dpm.ps[i];
>>> -             ui_class = ps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK;
>>> -             switch (dpm_state) {
>>> -             /* user states */
>>> -             case POWER_STATE_TYPE_BATTERY:
>>> -                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BATTERY) {
>>> -                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
>>> -                                     if (single_display)
>>> -                                             return ps;
>>> -                             } else
>>> -                                     return ps;
>>> -                     }
>>> -                     break;
>>> -             case POWER_STATE_TYPE_BALANCED:
>>> -                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BALANCED) {
>>> -                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
>>> -                                     if (single_display)
>>> -                                             return ps;
>>> -                             } else
>>> -                                     return ps;
>>> -                     }
>>> -                     break;
>>> -             case POWER_STATE_TYPE_PERFORMANCE:
>>> -                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
>>> -                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
>>> -                                     if (single_display)
>>> -                                             return ps;
>>> -                             } else
>>> -                                     return ps;
>>> -                     }
>>> -                     break;
>>> -             /* internal states */
>>> -             case POWER_STATE_TYPE_INTERNAL_UVD:
>>> -                     if (adev->pm.dpm.uvd_ps)
>>> -                             return adev->pm.dpm.uvd_ps;
>>> -                     else
>>> -                             break;
>>> -             case POWER_STATE_TYPE_INTERNAL_UVD_SD:
>>> -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_SDSTATE)
>>> -                             return ps;
>>> -                     break;
>>> -             case POWER_STATE_TYPE_INTERNAL_UVD_HD:
>>> -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_HDSTATE)
>>> -                             return ps;
>>> -                     break;
>>> -             case POWER_STATE_TYPE_INTERNAL_UVD_HD2:
>>> -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_HD2STATE)
>>> -                             return ps;
>>> -                     break;
>>> -             case POWER_STATE_TYPE_INTERNAL_UVD_MVC:
>>> -                     if (ps->class2 & ATOM_PPLIB_CLASSIFICATION2_MVC)
>>> -                             return ps;
>>> -                     break;
>>> -             case POWER_STATE_TYPE_INTERNAL_BOOT:
>>> -                     return adev->pm.dpm.boot_ps;
>>> -             case POWER_STATE_TYPE_INTERNAL_THERMAL:
>>> -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_THERMAL)
>>> -                             return ps;
>>> -                     break;
>>> -             case POWER_STATE_TYPE_INTERNAL_ACPI:
>>> -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_ACPI)
>>> -                             return ps;
>>> -                     break;
>>> -             case POWER_STATE_TYPE_INTERNAL_ULV:
>>> -                     if (ps->class2 & ATOM_PPLIB_CLASSIFICATION2_ULV)
>>> -                             return ps;
>>> -                     break;
>>> -             case POWER_STATE_TYPE_INTERNAL_3DPERF:
>>> -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE)
>>> -                             return ps;
>>> -                     break;
>>> -             default:
>>> -                     break;
>>> -             }
>>> -     }
>>> -     /* use a fallback state if we didn't match */
>>> -     switch (dpm_state) {
>>> -     case POWER_STATE_TYPE_INTERNAL_UVD_SD:
>>> -             dpm_state = POWER_STATE_TYPE_INTERNAL_UVD_HD;
>>> -             goto restart_search;
>>> -     case POWER_STATE_TYPE_INTERNAL_UVD_HD:
>>> -     case POWER_STATE_TYPE_INTERNAL_UVD_HD2:
>>> -     case POWER_STATE_TYPE_INTERNAL_UVD_MVC:
>>> -             if (adev->pm.dpm.uvd_ps) {
>>> -                     return adev->pm.dpm.uvd_ps;
>>> -             } else {
>>> -                     dpm_state = POWER_STATE_TYPE_PERFORMANCE;
>>> -                     goto restart_search;
>>> -             }
>>> -     case POWER_STATE_TYPE_INTERNAL_THERMAL:
>>> -             dpm_state = POWER_STATE_TYPE_INTERNAL_ACPI;
>>> -             goto restart_search;
>>> -     case POWER_STATE_TYPE_INTERNAL_ACPI:
>>> -             dpm_state = POWER_STATE_TYPE_BATTERY;
>>> -             goto restart_search;
>>> -     case POWER_STATE_TYPE_BATTERY:
>>> -     case POWER_STATE_TYPE_BALANCED:
>>> -     case POWER_STATE_TYPE_INTERNAL_3DPERF:
>>> -             dpm_state = POWER_STATE_TYPE_PERFORMANCE;
>>> -             goto restart_search;
>>> -     default:
>>> -             break;
>>> -     }
>>> -
>>> -     return NULL;
>>> -}
>>> -
>>> -static void amdgpu_dpm_change_power_state_locked(struct
>>> amdgpu_device *adev) -{
>>> -     struct amdgpu_ps *ps;
>>> -     enum amd_pm_state_type dpm_state;
>>> -     int ret;
>>> -     bool equal = false;
>>> -
>>> -     /* if dpm init failed */
>>> -     if (!adev->pm.dpm_enabled)
>>> -             return;
>>> -
>>> -     if (adev->pm.dpm.user_state != adev->pm.dpm.state) {
>>> -             /* add other state override checks here */
>>> -             if ((!adev->pm.dpm.thermal_active) &&
>>> -                 (!adev->pm.dpm.uvd_active))
>>> -                     adev->pm.dpm.state = adev->pm.dpm.user_state;
>>> -     }
>>> -     dpm_state = adev->pm.dpm.state;
>>> -
>>> -     ps = amdgpu_dpm_pick_power_state(adev, dpm_state);
>>> -     if (ps)
>>> -             adev->pm.dpm.requested_ps = ps;
>>> -     else
>>> -             return;
>>> -
>>> -     if (amdgpu_dpm == 1 && adev->powerplay.pp_funcs->print_power_state) {
>>> -             printk("switching from power state:\n");
>>> -             amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
>>> -             printk("switching to power state:\n");
>>> -             amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested_ps);
>>> -     }
>>> -
>>> -     /* update whether vce is active */
>>> -     ps->vce_active = adev->pm.dpm.vce_active;
>>> -     if (adev->powerplay.pp_funcs->display_configuration_changed)
>>> -             amdgpu_dpm_display_configuration_changed(adev);
>>> -
>>> -     ret = amdgpu_dpm_pre_set_power_state(adev);
>>> -     if (ret)
>>> -             return;
>>> -
>>> -     if (adev->powerplay.pp_funcs->check_state_equal) {
>>> -             if (0 != amdgpu_dpm_check_state_equal(adev, adev->pm.dpm.current_ps, adev->pm.dpm.requested_ps, &equal))
>>> -                     equal = false;
>>> -     }
>>> -
>>> -     if (equal)
>>> -             return;
>>> -
>>> -     amdgpu_dpm_set_power_state(adev);
>>> -     amdgpu_dpm_post_set_power_state(adev);
>>> -
>>> -     adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
>>> -     adev->pm.dpm.current_active_crtc_count = adev->pm.dpm.new_active_crtc_count;
>>> -
>>> -     if (adev->powerplay.pp_funcs->force_performance_level) {
>>> -             if (adev->pm.dpm.thermal_active) {
>>> -                     enum amd_dpm_forced_level level = adev->pm.dpm.forced_level;
>>> -                     /* force low perf level for thermal */
>>> -                     amdgpu_dpm_force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
>>> -                     /* save the user's level */
>>> -                     adev->pm.dpm.forced_level = level;
>>> -             } else {
>>> -                     /* otherwise, user selected level */
>>> -                     amdgpu_dpm_force_performance_level(adev, adev->pm.dpm.forced_level);
>>> -             }
>>> -     }
>>> -}
>>> -
>>> -void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>>> -{
>>> -     int ret = 0;
>>> -
>>> -     if (adev->family == AMDGPU_FAMILY_SI) {
>>> -             mutex_lock(&adev->pm.mutex);
>>> -             if (enable) {
>>> -                     adev->pm.dpm.uvd_active = true;
>>> -                     adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
>>> -             } else {
>>> -                     adev->pm.dpm.uvd_active = false;
>>> -             }
>>> -             mutex_unlock(&adev->pm.mutex);
>>> -
>>> -             amdgpu_pm_compute_clocks(adev);
>>> -     } else {
>>> -             ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
>>> -             if (ret)
>>> -                     DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
>>> -                               enable ? "enable" : "disable", ret);
>>> -
>>> -             /* enable/disable Low Memory PState for UVD (4k videos) */
>>> -             if (adev->asic_type == CHIP_STONEY &&
>>> -                     adev->uvd.decode_image_width >= WIDTH_4K) {
>>> -                     struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>>> -
>>> -                     if (hwmgr && hwmgr->hwmgr_func &&
>>> -                         hwmgr->hwmgr_func->update_nbdpm_pstate)
>>> -                             hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
>>> -                                                                    !enable,
>>> -                                                                    true);
>>> -             }
>>> -     }
>>> -}
>>> -
>>> -void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>>> -{
>>> -     int ret = 0;
>>> -
>>> -     if (adev->family == AMDGPU_FAMILY_SI) {
>>> -             mutex_lock(&adev->pm.mutex);
>>> -             if (enable) {
>>> -                     adev->pm.dpm.vce_active = true;
>>> -                     /* XXX select vce level based on ring/task */
>>> -                     adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
>>> -             } else {
>>> -                     adev->pm.dpm.vce_active = false;
>>> -             }
>>> -             mutex_unlock(&adev->pm.mutex);
>>> -
>>> -             amdgpu_pm_compute_clocks(adev);
>>> -     } else {
>>> -             ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
>>> -             if (ret)
>>> -                     DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
>>> -                               enable ? "enable" : "disable", ret);
>>> -     }
>>> -}
>>> -
>>> -void amdgpu_pm_print_power_states(struct amdgpu_device *adev) -{
>>> -     int i;
>>> -
>>> -     if (adev->powerplay.pp_funcs->print_power_state == NULL)
>>> -             return;
>>> -
>>> -     for (i = 0; i < adev->pm.dpm.num_ps; i++)
>>> -             amdgpu_dpm_print_power_state(adev, &adev->pm.dpm.ps[i]);
>>> -
>>> -}
>>> -
>>> -void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool
>>> enable) -{
>>> -     int ret = 0;
>>> -
>>> -     ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
>>> -     if (ret)
>>> -             DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
>>> -                       enable ? "enable" : "disable", ret);
>>> -}
>>> -
>>> -int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev,
>>> uint32_t *smu_version) -{
>>> -     int r;
>>> -
>>> -     if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->load_firmware) {
>>> -             r = adev->powerplay.pp_funcs->load_firmware(adev->powerplay.pp_handle);
>>> -             if (r) {
>>> -                     pr_err("smu firmware loading failed\n");
>>> -                     return r;
>>> -             }
>>> -             *smu_version = adev->pm.fw_version;
>>> -     }
>>> -     return 0;
>>> -}
>>> -
>>>    int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>>    {
>>>        int ret;
>>> @@ -4028,55 +3654,6 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>>>        amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>>>    }
>>>
>>> -void amdgpu_pm_compute_clocks(struct amdgpu_device *adev) -{
>>> -     int i = 0;
>>> -
>>> -     if (!adev->pm.dpm_enabled)
>>> -             return;
>>> -
>>> -     if (adev->mode_info.num_crtc)
>>> -             amdgpu_display_bandwidth_update(adev);
>>> -
>>> -     for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>> -             struct amdgpu_ring *ring = adev->rings[i];
>>> -             if (ring && ring->sched.ready)
>>> -                     amdgpu_fence_wait_empty(ring);
>>> -     }
>>> -
>>> -     if (is_support_sw_smu(adev)) {
>>> -             struct smu_dpm_context *smu_dpm = &adev->smu.smu_dpm;
>>> -             smu_handle_task(&adev->smu,
>>> -                             smu_dpm->dpm_level,
>>> -                             AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
>>> -                             true);
>>> -     } else {
>>> -             if (adev->powerplay.pp_funcs->dispatch_tasks) {
>>> -                     if (!amdgpu_device_has_dc_support(adev)) {
>>> -                             mutex_lock(&adev->pm.mutex);
>>> -                             amdgpu_dpm_get_active_displays(adev);
>>> -                             adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
>>> -                             adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
>>> -                             adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
>>> -                             /* we have issues with mclk switching with refresh rates over 120 hz on the non-DC code. */
>>> -                             if (adev->pm.pm_display_cfg.vrefresh > 120)
>>> -                                     adev->pm.pm_display_cfg.min_vblank_time = 0;
>>> -                             if (adev->powerplay.pp_funcs->display_configuration_change)
>>> -                                     adev->powerplay.pp_funcs->display_configuration_change(
>>> -                                                                     adev->powerplay.pp_handle,
>>> -                                                                     &adev->pm.pm_display_cfg);
>>> -                             mutex_unlock(&adev->pm.mutex);
>>> -                     }
>>> -                     amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
>>> -             } else {
>>> -                     mutex_lock(&adev->pm.mutex);
>>> -                     amdgpu_dpm_get_active_displays(adev);
>>> -                     amdgpu_dpm_change_power_state_locked(adev);
>>> -                     mutex_unlock(&adev->pm.mutex);
>>> -             }
>>> -     }
>>> -}
>>> -
>>>    /*
>>>     * Debugfs info
>>>     */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
>>> index d9ae2b49a402..45a22e101d15 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
>>> @@ -79,18 +79,10 @@ struct amdgpu_device_attr_entry {
>>>                             amdgpu_get_##_name, NULL,                  \
>>>                             _flags, ##__VA_ARGS__)
>>>
>>> -void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
>>>    int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
>>>    int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
>>>    void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
>>>    void amdgpu_pm_virt_sysfs_fini(struct amdgpu_device *adev); -void
>>> amdgpu_pm_print_power_states(struct amdgpu_device *adev); -int
>>> amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t
>>> *smu_version); -void amdgpu_pm_compute_clocks(struct amdgpu_device
>>> *adev); -void amdgpu_dpm_thermal_work_handler(struct work_struct
>>> *work); -void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool
>>> enable); -void amdgpu_dpm_enable_vce(struct amdgpu_device *adev,
>>> bool enable); -void amdgpu_dpm_enable_jpeg(struct amdgpu_device
>>> *adev, bool enable);
>>>
>>>    int amdgpu_debugfs_pm_init(struct amdgpu_device *adev);
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
>> an.quan%40amd.com%7Cf9fcda91b3c64a60a4ba08d83f904d77%7C3dd8961fe4884e6
>> 08e11a82d994e183d%7C0%7C0%7C637329236297410452&amp;sdata=dxfigPWqRxyc4
>> 88M%2BE4L5RfbODakgzSRyYxnX0rA0Ak%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
