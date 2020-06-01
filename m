Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10788C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 17:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C8920734
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 17:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZdZVrXga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C8920734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789F689F75;
	Mon,  1 Jun 2020 17:39:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B039289F75
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 17:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo+3TMK3YE4WmE4K03uj5yGWptYU9pgKkMu57OM74RG9QsoOHcUiMJU9tEo4U9HGYGxczpXh5PnrXVf+HUuBt4fDpAV6UqljKmYAQ5I8+6WQQVDGexOp1y5OcxzsckVsl7BLrbxmV5rRyA2K5dGxzB0jPSVn0ws4HeSC76W7fwAfJjjDrxoKE29IOsheF9yMOJPkMYRM7D8j9TkK0QZ4yxR83qZXTuLkaXCxY25WOCSSsi4Hix80oUA8PbMTtD24ayYpJ7BU9Ul76D3jmXxMWSMx5otozcXlwR3XD+jhEzeZUik2OBK9FUsiwhZPqVd9t/vTiu6kfgRVITNnZiOMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWXxJAHjqIkH12lJ7yo75ynxy7NYBRv43ZgyMKRp2N8=;
 b=bx209n1ikCG1OuzUI7KRr3JJmfDcE7ofl7koTD0LwaTHBEO51wH8wOyjTPY3MEMafVs5Kxx3AUWNc1HOGAmldN2lj2mvcZRrnl0XdvOBUcUWWGXvGtebGWgNXIu/eGDI5vdfdIXpjOhtyRxLfk2TIeoSZ5FrXO/q6k6IPXgEdEGmkGOxLaobnJrmz3q+19ZsoPi5/0n3pNI0Cge2aE4etfqAtHM/Ai7c2NpZmSTxRso0fulUD/q4ZdBwgQ3JwZXUVEWUUuIZlpPjmD0LubDE8z/EWISYA6RbQRjIsrQ75vrY6lx3nIq+rZNuQdSb7v8fWqP2DrbcTum+YW13yszT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWXxJAHjqIkH12lJ7yo75ynxy7NYBRv43ZgyMKRp2N8=;
 b=ZdZVrXga1Kpb1shA/pDO7b+YKaVMD+SBv8Gr1jDRRsEr2HUOc5BcJGBhanRoTzZATNBOt5sBJKr/ea6vE7P9xN6P6Cug42nQkiwpbaJkA4Kn6r4mB89cSxw1DRCL1M+pY0cdgn4Ogl7168GIjaPY77o4PEnfHtpbKjOTa6cmJvU=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Mon, 1 Jun
 2020 17:39:21 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 17:39:21 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for
 Arcturus
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for
 Arcturus
Thread-Index: AQHWODoRbsZPeFCBrEW7lHT6QoCyjKjEBWiAgAAA1iA=
Date: Mon, 1 Jun 2020 17:39:21 +0000
Message-ID: <DM6PR12MB37219A4921822371C79C5F3B858A0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200601172818.5560-1-kent.russell@amd.com>
 <20200601172818.5560-2-kent.russell@amd.com>
 <CADnq5_Nz-yYJtWbcGXmnq7Bw541qiq+rPwkNaKXCwLMzoogzKg@mail.gmail.com>
In-Reply-To: <CADnq5_Nz-yYJtWbcGXmnq7Bw541qiq+rPwkNaKXCwLMzoogzKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-01T17:39:06Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3cec6669-a794-4092-8d97-0000099dca8a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-01T17:38:46Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e8d7c21f-86f6-45e5-a3d0-0000d60c59ca
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-01T17:39:19Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1261292c-57e7-4433-a7a2-0000f7b53171
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:aecb:89d3:2a74:6d44:185a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cc8befd-e59b-4c34-cfca-08d80652b804
x-ms-traffictypediagnostic: DM6PR12MB4091:
x-microsoft-antispam-prvs: <DM6PR12MB4091E99CDCD2ACDF7D2B6A85858A0@DM6PR12MB4091.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /proeRf2HWeZhnrgvzd3oQXBt6J+tqQUH9zFhiOvTroMqzjNoumEQ8hBdY/+nUwB7b0R6uLx62/EmcOD0g2gLIVh0PlZPipfGffAvM6il17Gf7J2pY/6W3Cu0t6/er50r6HLyBfEChJN/aiLw5TYL1DXm8rLHGtbAiuFa1Ar4hX2y4mwxeJCDlxGHiGHKdfdPnYH8bsa6ar4IZ05zCKSi3wdMdtF5sqvFbrDmdBpD6w8NiF3xVttRrAsKRiR9a/XBjTuIPLWLVUvbLjH/vrGQOK1mWJtAR6Oh6pI3VhwJRomDg0wXWOhWPcr0xIhPCgC/0iGkBptrKA6XBpzr+wryekkOw0TA92N49Ex38O9IMYZndNfR3R6Mx9iO3QWDIxx5Bc1Eb+T5JeHYLsZR/b7Kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(2906002)(45080400002)(76116006)(66946007)(66476007)(66556008)(7696005)(9686003)(83380400001)(6916009)(66446008)(64756008)(55016002)(6506007)(53546011)(5660300002)(966005)(186003)(83080400001)(86362001)(4326008)(8936002)(478600001)(8676002)(316002)(33656002)(71200400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RNlX35Icigpk5b502Ed8YChTGVgF+CEKhKWn8kr47dwzqfGfnIIzHz6OgVDaU0QcoPTGR+60bTAsTn8RYsrLFhabSzhNbgoT49Jrk8HHWOuXIm9nUk28N/All3A0ypK76qkmkDYo1P7roff0JtLAYQDyfD3dnlcvuOuJFS/2LP8QZw9dvggXfssmKKQYNfU95eGOF9efHRGlKLvP8zvWM/J+KZgpqelfSQE+BqskuLUVMl0zh6I1OkAVc+zYwP37w+whlBx3uczbnCxC8WfmjExSgOJQA8VwPdcTGkr3FUj8CJjbR666lms0a8bjR4EDsTI0fznE5RWeILgSShca0Ghprw6i/LlLV6Nt6gNHKUXs00EdlfXi8gAC7J+NkiMBOBiR3rwtyi/S9DfDfPGQhwBGPS7ttRStSv8dxdqooJ+PlNJjFd+FXhA50rvpfOisCo3JKEBbAdVkzxQOm/GoQft+GCZEh9UMlkvXaXWeMXONh389Xney7eHke3rFNjj7dl/gRqUGFizIvFlSQzAanyQBT82boHOEIqdz9s9VN1QVI9V2MUnzw/gz2cYqcH/J
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc8befd-e59b-4c34-cfca-08d80652b804
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 17:39:21.6753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/6uF1EiK+9E8mM6K7+Jaiv06ZY9JtOdxZXLpfW3ZV2hqA9TiZuXSrJvpdFCwoX1XP3nAskGR7dwwZ8PorW8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Monday, June 1, 2020 1:35 PM
> To: Russell, Kent <Kent.Russell@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for
> Arcturus
> 
> On Mon, Jun 1, 2020 at 1:28 PM Kent Russell <kent.russell@amd.com> wrote:
> >
> > Add support for unique_id and serial_number, as these are now the same
> > value, and will be for future ASICs as well.
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > Change-Id: I3b036a38b19cd84025399b0706b2dad9b7aff713
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  2 +-
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 ++
> >  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 32
> +++++++++++++++++++
> >  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
> >  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 ++
> >  5 files changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > index b0dff9ecfb88..9136d9022c51 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > @@ -1940,7 +1940,7 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
> >                 if (adev->flags & AMD_IS_APU)
> >                         *states = ATTR_STATE_UNSUPPORTED;
> >         } else if (DEVICE_ATTR_IS(unique_id)) {
> > -               if (!adev->unique_id)
> > +               if (asic_type < CHIP_VEGA10)
> 
> Will this work properly on navi and APUs as well?
It will, but it's not implemented yet. Currently it will just be an empty sysfs file.


> 
> >                         *states = ATTR_STATE_UNSUPPORTED;
> >         } else if (DEVICE_ATTR_IS(pp_features)) {
> >                 if (adev->flags & AMD_IS_APU || asic_type <
> > CHIP_VEGA10) diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > index 5294aa7cdde1..7946fd8444a3 100644
> > --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> > @@ -793,6 +793,8 @@ static int smu_late_init(void *handle)
> >         if (!smu->pm_enabled)
> >                 return 0;
> >
> > +       smu_set_unique_id(smu);
> > +
> >         smu_handle_task(&adev->smu,
> >                         smu->smu_dpm.dpm_level,
> >                         AMD_PP_TASK_COMPLETE_INIT, diff --git
> > a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > index d66ac7457574..855e609650d9 100644
> > --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > @@ -2262,6 +2262,37 @@ static void
> arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
> >         i2c_del_adapter(control);
> >  }
> >
> > +static void arcturus_set_unique_id(struct smu_context *smu) {
> > +       struct amdgpu_device *adev = smu->adev;
> > +       uint32_t top32, bottom32, smu_version, size;
> > +       char sn[16];
> > +       uint64_t id;
> > +
> > +       if (smu_get_smc_version(smu, NULL, &smu_version)) {
> > +               pr_warn("Failed to get smu version, cannot get unique_id or
> serial_number\n");
> > +               return;
> > +       }
> > +
> > +       /* PPSMC_MSG_ReadSerial* is supported by 54.23.0 and onwards */
> > +       if (smu_version < 0x361700) {
> > +               pr_warn("ReadSerial is only supported by PMFW 54.23.0 and
> onwards\n");
> > +               return;
> > +       }
> > +
> > +       /* Get the SN to turn into a Unique ID */
> > +       smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32);
> > +       smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32,
> > + &bottom32);
> > +
> > +       id = ((uint64_t)bottom32 << 32) | top32;
> > +       adev->unique_id = id;
> > +       /* For Arcturus-and-later, unique_id == serial_number, so convert it to a
> > +        * 16-digit HEX string for convenience and backwards-compatibility
> > +        */
> > +       size = sprintf(sn, "%llx", id);
> > +       memcpy(adev->serial, &sn, size); }
> > +
> >  static bool arcturus_is_baco_supported(struct smu_context *smu)  {
> >         struct amdgpu_device *adev = smu->adev; @@ -2416,6 +2447,7 @@
> > static const struct pptable_funcs arcturus_ppt_funcs = {
> >         .dpm_set_uvd_enable = arcturus_dpm_set_uvd_enable,
> >         .i2c_eeprom_init = arcturus_i2c_eeprom_control_init,
> >         .i2c_eeprom_fini = arcturus_i2c_eeprom_control_fini,
> > +       .set_unique_id = arcturus_set_unique_id,
> >         .init_microcode = smu_v11_0_init_microcode,
> >         .load_microcode = smu_v11_0_load_microcode,
> >         .init_smc_tables = smu_v11_0_init_smc_tables, diff --git
> > a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > index 5bb1ac821aeb..bfa5211de079 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> > @@ -495,6 +495,7 @@ struct pptable_funcs {
> >         int (*update_pcie_parameters)(struct smu_context *smu, uint32_t
> pcie_gen_cap, uint32_t pcie_width_cap);
> >         int (*i2c_eeprom_init)(struct i2c_adapter *control);
> >         void (*i2c_eeprom_fini)(struct i2c_adapter *control);
> > +       void (*set_unique_id)(struct smu_context *smu);
> >         int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks
> *clock_table);
> >         int (*init_microcode)(struct smu_context *smu);
> >         int (*load_microcode)(struct smu_context *smu); diff --git
> > a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> > b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> > index 6c59eeef2590..125d976215a6 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> > +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> > @@ -218,6 +218,8 @@ static inline int smu_send_smc_msg(struct
> smu_context *smu, enum smu_message_typ
> >                 ((smu)->ppt_funcs->i2c_eeprom_init ?
> > (smu)->ppt_funcs->i2c_eeprom_init((control)) : 0)  #define
> smu_i2c_eeprom_fini(smu, control) \
> >                 ((smu)->ppt_funcs->i2c_eeprom_fini ?
> > (smu)->ppt_funcs->i2c_eeprom_fini((control)) : 0)
> > +#define smu_set_unique_id(smu) \
> > +               ((smu)->ppt_funcs->set_unique_id ?
> > +(smu)->ppt_funcs->set_unique_id((smu)) : 0)
> >
> 
> I would call this get_unique_id() since it's fetching the id from the hw rather
> than setting it.  Same comment for the device specific functions above.
> 
> >  #define smu_log_thermal_throttling(smu) \
> >                 ((smu)->ppt_funcs->log_thermal_throttling_event ?
> > (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cke
> >
> nt.russell%40amd.com%7Cdd77d3b285a04b19a3c108d80652189f%7C3dd896
> 1fe488
> >
> 4e608e11a82d994e183d%7C0%7C0%7C637266296955676858&amp;sdata=Uq
> sOnA7TwH
> > OpbvyyqfeJm3yveVpgaLnN4sF0Q7lOCJo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
