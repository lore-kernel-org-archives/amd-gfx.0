Return-Path: <SRS0=J5eG=D2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5AC433E7
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 01:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38FA222C3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 01:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wPnqdD20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38FA222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A306E154;
	Mon, 19 Oct 2020 01:41:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989926E154
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2020 01:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDVrwRHh0i5dC5E95uQwdRz+Wp6c0bFap7PFYsf5ZRznIOxrhxXEW/muqlWAW1tU6E/xHpHsbGCSYQd9dVRljLVsx53KMXOrlhNdOWl/WxsABY+xda2AGJzRCHorJxMB3gRnIjQMwd24KsnTitwlvujuq4Uir1B53uDBgzTbls5IBTLrtHKIySgFFVq7c/C4YyhdlfkGq2iTIrt9jPd7dC+E2pTD+5bxJ6sJZ385wCKZqsPczJtqIKajrFHDBs2YOI+Qm41BUbN8jzHDAe6kryKmPPWLJcT8h7xb8XCWDa6dXbOwzspLFM8NMXdg508KzfW2qWToomCcxx6rV5Ulug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVLPLKSVLtepPAGJVlCdHL0u1Ff4oBhgEcnkfu97qFw=;
 b=R8XkpPywh5BwAu5g4T/SOm5HADNF+mJAZ6f+gD6WkBQu3XjvinJ0vP1sH8UgYBoL/BXkM3KSiC7+zFB639WzB1flIFBQjs6qMaeSmc3cG8TpqywihTVQZPp3IAlkAZH6f100VTQeaqv6dm9cKm8OytrbrLl9LzNSxMSGf2PWZTjAZh6XH5Oj+m3BDlu+biQu79X9FhzhFAfKwYkTJsFqKVbaNq1Ou2j/GdhNb6VaHTiI0k9ChY35h1KoBg0pK5k/zlOzggbQ7mpuSTRR2gcrq+/rpu8NRjF+DsU4XbRI6CE/2Dd7m+58sDUKqz7cXJRdoaE80dqyc4gMGkdF0hd//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVLPLKSVLtepPAGJVlCdHL0u1Ff4oBhgEcnkfu97qFw=;
 b=wPnqdD20H7/nMdNujXC+oiAQDB5jp0MS36YMTk6U/TGCi6oMgz6MGKKTUb33zeN6TN1KQcewRQYMl+dKykGmsLPHjyRAcGN9iyMb6nJ3b5YxEda8tLq6T8HpH8qVsiI/mIWDmFWbxgH5XxaM9DMloA1MIe5FF0gezufnzGXnBFU=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Mon, 19 Oct
 2020 01:41:01 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::2c68:c110:d658:f219%5]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 01:41:00 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: add amdgpu_gfx_state_change_set() set gfx
 power change entry
Thread-Topic: [PATCH 2/4] drm/amdgpu: add amdgpu_gfx_state_change_set() set
 gfx power change entry
Thread-Index: AQHWo53LuDEmdK7oQ0a9H1TL60M0KamaiAMAgAOgCZA=
Date: Mon, 19 Oct 2020 01:41:00 +0000
Message-ID: <BYAPR12MB323834BAEEB5F82AC0DA63D2FB1E0@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
 <1602840103-21053-2-git-send-email-Prike.Liang@amd.com>
 <CADnq5_Pqa_60zia9ZFK=crMTQsTZvVe9iBAh4neFAk4VBr_Ggw@mail.gmail.com>
In-Reply-To: <CADnq5_Pqa_60zia9ZFK=crMTQsTZvVe9iBAh4neFAk4VBr_Ggw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=be15457a-1c4c-4631-b7cb-8d0449750f4a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-19T01:32:01Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcd690ce-4dfe-49b3-00f1-08d873d008b0
x-ms-traffictypediagnostic: BYAPR12MB3285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB328523744C7C6149AF999AFFFB1E0@BYAPR12MB3285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lATJXVZcWqXBWkJdLJ4Yrk8+uERJPHk3jSkos0fq7HbktjzYoqCqND09W3pcIpQRNPmFvDqn8ty8umQWw4yG6LpyYCvlBYdYV587xuFYRQl5iq2H4qwqqLkZavj8tibsGt3dZbgqUOUpRMgsCrdJlQJzHkwFJt5+wx3zEftbHRHk2cBxvxpS3L0MHnNGciG85Dv2S0X/TSTY/CoVs7u37AyCN+5DkzUHMch+GuSF1Es0IUCqXtjPFkECHfAvT5UFrqj0JCK31vqY5ysDKdqaJJTfHnveIb9mX2Br3B4bXRPFfgCoeJgaMCBUYxwzOJyx0/qJnLzqALf/Jj48oHNLY12g+V1oBcpKxZDkMMxkWYJ1h3JOeljmtJISAAM3JKRMfUs5FTrqcWV6xjiiFVk9rg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(4326008)(66556008)(186003)(8936002)(66446008)(53546011)(26005)(54906003)(966005)(316002)(64756008)(66946007)(66476007)(33656002)(6506007)(76116006)(8676002)(45080400002)(478600001)(5660300002)(19627235002)(2906002)(86362001)(9686003)(71200400001)(83380400001)(55016002)(52536014)(6916009)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: z2KE9uV+yy9S7Hf6TeFRyK0YN6aOWXduEt9G8fJMf3HF1jS21Syil6Ti0xicvo5t2GZP+Jx1/yCyBJfacHZHLpQgBR+kiQGVcIL8BQ1KXi/TrKVt8pgc7tSDperUMownQISm6iZf45/k6eWFLbTb/efyNOIaip+2W6oNQYTpbCcuGuXc0YlZhVIk33q+u6aJTYNvyNMomIPILlEv/5Y2hULCUVPoOr9BE0Z49KiJBf0U+JflcMoROj1rwnBfgbFkSaKfvP7R+BgK/u9eOJGbE6L/ZqDyavKr4xf7SbD8OpEhwO7q78vSC7PyDhXaWB7BiDDof4uwyzhqQDyr+I/5GYmkD7B8Y+IhAD7VzC7Sv8IlJfQvcfQ2Y9vDKlIpZQy8HMvRu2dxdThBYccE4HaMxaHcDBXAgvzIWzL3TdiZECZTBDNiAfHBK8CbYfy8Zy3+5WA9pJ41WeR6QiQUvAKxi6RzSljrnKZN0P8a1KjdCSTheQpY0AgM0RvVXu5HKqhzbg5C2GWCsz1PchV/wbf7ATIYXwwCzECs2tLuMFaXskeJEoV5F4jX3DF3pUpLdRoPgzsZyfAFdiXCsXU1Ro5aleC6tbBdJSB7BwWvnV+bagP9M99rtSMUxBu0iJRgMVKegWfzNW3c5odGWpjxI6sarA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd690ce-4dfe-49b3-00f1-08d873d008b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 01:41:00.7790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gXanTNgHCl50GZQvNwvZGojxMYt2InsjsLOfHIk4zf/8f35BHnf4KIVbj5MzAb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3285
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Saturday, October 17, 2020 2:10 AM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: Re: [PATCH 2/4] drm/amdgpu: add amdgpu_gfx_state_change_set()
> set gfx power change entry
>
> On Fri, Oct 16, 2020 at 5:21 AM Prike Liang <Prike.Liang@amd.com> wrote:
> >
> > The new amdgpu_gfx_state_change_set() funtion can support set GFX
> > power change status to D0/D3.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> I presume we'll need something similar for renoir?  That can be a follow up
> patch.
[Prike]  Yeah, so I have drafted the invoked function amdgpu_gfx_state_change_set() outside of the powerplay driver for common use. But until now haven't checked s0i3 on the Renoir/Cezanne yet and if needed will be implement it in the Renoir SMU driver.
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c           | 20
> ++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h           |  7 +++++++
> >  drivers/gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
> >  drivers/gpu/drm/amd/powerplay/amd_powerplay.c     | 20
> ++++++++++++++++++++
> >  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  9 +++++++++
> >  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h         |  1 +
> >  drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h      |  3 ++-
> >  7 files changed, 60 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index d612033..e1d6c8a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -789,3 +789,23 @@ void amdgpu_kiq_wreg(struct amdgpu_device
> *adev,
> > uint32_t reg, uint32_t v)
> >  failed_kiq_write:
> >         pr_err("failed to write reg:%x\n", reg);  }
> > +
> > +/* amdgpu_gfx_state_change_set - Handle gfx power state change set
> > + * @adev: amdgpu_device pointer
> > + * @state: gfx power state(1 -eGpuChangeState_D0Entry and 2
> > +-eGpuChangeState_D3Entry)
> > + *
> > + */
> > +
> > +void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum
> > +gfx_change_state state) {
> > +
> > +       mutex_lock(&adev->pm.mutex);
> > +
> > +       if (adev->powerplay.pp_funcs &&
> > +           adev->powerplay.pp_funcs->gfx_state_change_set)
> > +                       ((adev)->powerplay.pp_funcs->gfx_state_change_set(
> > +                                       (adev)->powerplay.pp_handle,
> > + state));
> > +
> > +       mutex_unlock(&adev->pm.mutex);
> > +
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index d43c116..73942b2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -47,6 +47,12 @@ enum gfx_pipe_priority {
> >         AMDGPU_GFX_PIPE_PRIO_MAX
> >  };
> >
> > +/* Argument for PPSMC_MSG_GpuChangeState */ enum
> gfx_change_state {
> > +       GpuChangeState_D0Entry = 1,
> > +       GpuChangeState_D3Entry,
> > +};
> > +
> >  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0  #define
> > AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> >
> > @@ -387,4 +393,5 @@ int amdgpu_gfx_cp_ecc_error_irq(struct
> amdgpu_device *adev,
> >                                   struct amdgpu_iv_entry *entry);
> > uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
> > void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
> > uint32_t v);
> > +void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum
> > +gfx_change_state state);
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > index a7f92d0..e7b69dd 100644
> > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > @@ -284,6 +284,7 @@ struct amd_pm_funcs {
> >         int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *input,
> uint32_t size);
> >         int (*set_mp1_state)(void *handle, enum pp_mp1_state mp1_state);
> >         int (*smu_i2c_bus_access)(void *handle, bool acquire);
> > +       int (*gfx_state_change_set)(void *handle, uint32_t state);
> >  /* export to DC */
> >         u32 (*get_sclk)(void *handle, bool low);
> >         u32 (*get_mclk)(void *handle, bool low); diff --git
> > a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > index 7e6dcdf..4f319be 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> > @@ -1321,6 +1321,25 @@ static int pp_set_powergating_by_smu(void
> *handle,
> >         return ret;
> >  }
> >
> > +static int pp_gfx_state_change_set(void *handle, uint32_t state) {
> > +       struct pp_hwmgr *hwmgr = handle;
> > +
> > +       if (!hwmgr || !hwmgr->pm_en)
> > +               return -EINVAL;
> > +
> > +       if (hwmgr->hwmgr_func->gfx_state_change == NULL) {
> > +               pr_info_ratelimited("%s was not implemented.\n", __func__);
> > +               return -EINVAL;
> > +       }
> > +
> > +       mutex_lock(&hwmgr->smu_lock);
> > +       hwmgr->hwmgr_func->gfx_state_change(hwmgr, state);
> > +       mutex_unlock(&hwmgr->smu_lock);
> > +
> > +       return 0;
> > +}
> > +
> >  static int pp_notify_smu_enable_pwe(void *handle)  {
> >         struct pp_hwmgr *hwmgr = handle; @@ -1625,6 +1644,7 @@ static
> > const struct amd_pm_funcs pp_dpm_funcs = {
> >         .switch_power_profile = pp_dpm_switch_power_profile,
> >         .set_clockgating_by_smu = pp_set_clockgating_by_smu,
> >         .set_powergating_by_smu = pp_set_powergating_by_smu,
> > +       .gfx_state_change_set = pp_gfx_state_change_set,
> >         .get_power_profile_mode = pp_get_power_profile_mode,
> >         .set_power_profile_mode = pp_set_power_profile_mode,
> >         .odn_edit_dpm_table = pp_odn_edit_dpm_table, diff --git
> > a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > index c9cfe90..3f354da 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > @@ -319,6 +319,14 @@ static bool smu10_is_gfx_on(struct pp_hwmgr
> *hwmgr)
> >         return false;
> >  }
> >
> > +static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t
> > +state) {
> > +       struct amdgpu_device *adev = hwmgr->adev;
> > +       smum_send_msg_to_smc_with_parameter(hwmgr,
> > +PPSMC_MSG_GpuChangeState, state, NULL);
> > +
> > +       return 0;
> > +}
> > +
> >  static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)  {
> >         struct amdgpu_device *adev = hwmgr->adev; @@ -1394,6 +1402,7
> > @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
> >         .get_power_profile_mode = smu10_get_power_profile_mode,
> >         .set_power_profile_mode = smu10_set_power_profile_mode,
> >         .asic_reset = smu10_asic_reset,
> > +       .gfx_state_change = smu10_gfx_state_change,
> >  };
> >
> >  int smu10_init_function_pointers(struct pp_hwmgr *hwmgr) diff --git
> > a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > index 15ed6cb..2c9580b 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > @@ -359,6 +359,7 @@ struct pp_hwmgr_func {
> >         int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
> >         int (*disable_power_features_for_compute_performance)(struct
> pp_hwmgr *hwmgr,
> >                                         bool disable);
> > +       int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t
> > + state);
> >  };
> >
> >  struct pp_table_func {
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
> > b/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
> > index df4677d..4c7e08b 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
> > @@ -83,7 +83,8 @@
> >  #define PPSMC_MSG_SetSoftMaxVcn                 0x34
> >  #define PPSMC_MSG_PowerGateMmHub                0x35
> >  #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
> > -#define PPSMC_Message_Count                     0x37
> > +#define PPSMC_MSG_GpuChangeState                0x37
> > +#define PPSMC_Message_Count                     0x42
> >
> >  typedef uint16_t PPSMC_Result;
> >  typedef int      PPSMC_Msg;
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPr
> >
> ike.Liang%40amd.com%7C8dc3fa74b20d4fae604708d871fec9f9%7C3dd8961f
> e4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637384686409368549%7CUnknown%7
> CTWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> >
> 7C1000&amp;sdata=sB%2FuFIiWFJ5nRsVYfRbfGZYszehIDAlhzZE5Okx4zTk%3
> D&amp;
> > reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
