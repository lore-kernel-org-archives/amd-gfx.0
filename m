Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00029C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DFA207D8
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QKMjRyz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DFA207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5084D6E429;
	Tue,  2 Jun 2020 15:50:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3B76E429
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 15:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Why8VB+0bLZ4Xvbtq7GJ7YEiiUE7UVram3s01AEasaR07X7llXrets24QcxRUc6aI3sYPpa9joaw/uouKZliqZmj2ocnU04uyatQ3TfzMdYVA90Ytd0643U+Q4f8GKNGO0wRyBbrc57Fip55HpisHHDrtgORJ1aa+30/y38ycsLzbhU9qT26VR4e/U3U/yHvkcNNJXPUsgJQ5A4kZjRQzeT/waDlWdzZeOr/CIXdtzytK6UCfUTqSDeqyEkXeAeiFOQu4JqhAUOC8/N85Zy566sBlxlsBxU3ABG+D5hoZVZEIIesayXFjj6zMXi4pJTyp1BQ2L7B0lovZO3IxYkn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+puQtboVhhCLnYk/J/+zbZfq9K2MTv0dV6/0ZpZj0M=;
 b=bBDSIXWtaziHvh6WEACIUFyDELZ1RvtinVBaiA42ZmDvuwOomk32CpydVG5kVRnwUJ2tZMLsaLpKN84aJRxjO6WU2btiuapObd/H51uMTs8rv/dFOSJwpLE+djyJD/6KnW2uCCHaZ+QAUtf+eubJZRrJENVnWPcLsuATuZR8n3ZIk692jn2zqSYOi5uOmd8TNxFgm919Oyrr70ykUOOFCLA7FzOMaTwewTNlE36rm6w97nuejfP0mhU4a11u083WPEJPlfmf7JOYBLfeT0cD62M59zcTlJ9sX96gY1YFma9+UM3xRcOb3zLLzxJAcWQirtjwac3IPUl1KuVvyQRaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+puQtboVhhCLnYk/J/+zbZfq9K2MTv0dV6/0ZpZj0M=;
 b=QKMjRyz6c9b83ma3n325XAYg1yWkN2l/yu5+37SLLQEA8II5DVGdzfUYrYMn1M8RnSgJ1EcYNwb39Wq5MlI/eFWvi/fPgq74eqsCddVj9EWNKqxHCMN5oe1txj+RzAEnEXlz4VSPG9Bs/2CwbP3F8qigxDYlIcbHp4kSpD4Bu1o=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 15:49:58 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 15:49:58 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for
 Arcturus v2
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for
 Arcturus v2
Thread-Index: AQHWONzII5zRf3UpekyoUS+ynQic16jFZyIAgAAQ90A=
Date: Tue, 2 Jun 2020 15:49:58 +0000
Message-ID: <DM6PR12MB3721C99E47D82ECA96DAB1EF858B0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200602125302.1839-1-kent.russell@amd.com>
 <20200602125302.1839-2-kent.russell@amd.com>
 <CADnq5_M0oOET5cDPR-+TCtS4B_V=SzeGq36m_0hJxGvZc-aSiQ@mail.gmail.com>
In-Reply-To: <CADnq5_M0oOET5cDPR-+TCtS4B_V=SzeGq36m_0hJxGvZc-aSiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-02T15:48:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fecd9c3f-e0f9-40e5-8019-000088e4f49c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-02T15:47:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fd8c9d49-d79f-4e01-9455-0000d0a6a68f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-02T15:49:56Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: eae53749-627d-4a82-9654-0000240a985e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:aecb:89d3:2a74:6d44:185a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 409da4c0-c5af-4b40-6f49-08d8070c9a47
x-ms-traffictypediagnostic: DM6PR12MB4332:
x-microsoft-antispam-prvs: <DM6PR12MB43326559F379DB3C95836052858B0@DM6PR12MB4332.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUF0CRLTo3MHgDvstD79/vdy6uBO+zCCg2i8ZydLlXlBBM1+mHsSwqFgurRq1s5C/ueEcToHj0NJw8mXzC1pPpkWL2pLhNoaScIIR6Ev9k77K/MsOCQ9QwPEx/Pwf1zJmtAQMfUYdv1/KmeM119z+UNciaJLV8c5XM4zfNCM/4i5RRk59PAJHv/FRlPY5CwxDb9PSS9+flpJQajKEF/s6sqv0zjnSix9J0TKVUaS2/c4jVTq+hkETdP67ptjltTwSmvReiwa/W95gvTpMOKMzwa3WB9OGnipYCv0TxukxiG6zUogdzroWZxgHNeyAAjnr1QM0s6d98Pyb+4sEwL2LLZgdN6Gudy2qzJZkonO3JdkboiDkhfj3+KtFCFJ1adQKZPsP4ZpW7+dhzPMYBosPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(8936002)(186003)(4326008)(2906002)(8676002)(83380400001)(83080400001)(71200400001)(6916009)(9686003)(55016002)(316002)(66476007)(66446008)(66556008)(76116006)(66946007)(966005)(478600001)(45080400002)(64756008)(33656002)(53546011)(7696005)(86362001)(5660300002)(52536014)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XH0GMpWpN5QPAtFs5vvJiEUx9JJmt0KbYP3yK+GovFeifCwtLVsdXWdrgV+kDb91nFyWPiTxQi7BeDmVdO5lvNVSBMllUlXhXfv67LlMHY+uDgSKw/4urXC02wgyv8WzwIGSaDIItVpMScsf3fnDrK2vXvtn4W8hWtL7wBVBgESbT5+qV2QsrehSrfBgoG9RIGf1wai/zcMglk0GSdgTHO/5l3SL6J2buUYGCKvWJXkYNe9XCyYuODKLlT7J5W75AvhpEcxPBTs1oC04mKdYTeVcAyby13dn0VDwXB0lWR8+BYQ0+QEKwy4QoMjPV0PMX4o+M9kqpvoIF6Dw4aqBoSl241+N1zrHOTBXpucUoAQLUQ5iuDWam/aPxtFtvZ+yZHYVN7HtpUX075av7v7Kb0nYJCzJ7kK0cx9EadyfwgwQobFHpiApMrLAlNXHSY8SJ10xRrxbKmX1U0fHOmg3CtoujruTUt7I7E/tOU6FME9sJodEPKL0hIg+f2T546g0qSUyiwxrl5AxIvy2wjrPIEhEDt7Ow6ODLVagrrbiAGtShd21MhtMPNLeR7yGeRst
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409da4c0-c5af-4b40-6f49-08d8070c9a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 15:49:58.0720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+0KtGnoi7sdGdC4EEnv7L01zCFqZdQvNvfcqU9ECDkzKFqDAs0l3uMxeJ1LFVIPGogMUWkMD+f7zhot9e4TXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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
> Sent: Tuesday, June 2, 2020 10:45 AM
> To: Russell, Kent <Kent.Russell@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id and serial_number for
> Arcturus v2
> 
> On Tue, Jun 2, 2020 at 8:53 AM Kent Russell <kent.russell@amd.com> wrote:
> >
> > Add support for unique_id and serial_number, as these are now the same
> > value, and will be for future ASICs as well.
> >
> > v2: Explicitly create unique_id only for VG10/20/ARC
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > Change-Id: I3b036a38b19cd84025399b0706b2dad9b7aff713
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  4 ++-
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 ++
> >  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 32
> +++++++++++++++++++
> >  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
> >  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  2 ++
> >  5 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > index b0dff9ecfb88..b2cdc8a1268f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > @@ -1940,7 +1940,9 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
> >                 if (adev->flags & AMD_IS_APU)
> >                         *states = ATTR_STATE_UNSUPPORTED;
> >         } else if (DEVICE_ATTR_IS(unique_id)) {
> > -               if (!adev->unique_id)
> > +               if (asic_type != CHIP_VEGA10 &&
> > +                   asic_type != CHIP_VEGA20 &&
> > +                   asic_type != CHIP_ARCTURUS)
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
> 
> As I mentioned in my previous email, I think these functions would be better
> worded as "get_unique_id" since we are fetching it from the hardware not
> storing it to the hardware.

Sorry, I missed that in the previous e-mail. I'll do that now. I was torn between get and set, since it gets it from the SMU, but it sets the variable, so that decision helps for clarity. Thanks!

 Kent 
> 
> Alex
> 
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
> nt.russell%40amd.com%7C06d9eed695b04346a48408d8070397ef%7C3dd896
> 1fe488
> >
> 4e608e11a82d994e183d%7C0%7C0%7C637267059312215967&amp;sdata=Se
> XIr7DB5A
> > Vc%2Fk%2B6bFd448Ydvt%2F%2BKKWJHMd6MkQLL1I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
