Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F2C2D0C0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 03:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF96206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 03:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4Ja7PhgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF96206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FBF6E08A;
	Tue, 24 Dec 2019 03:06:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770080.outbound.protection.outlook.com [40.107.77.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149D96E055
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 03:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c60zxH6O0ZGyaz6hOk+Zwm+9KaIyZbWxAVEH1j9SaRlp0d5xPrL5XLS0a2OOYLq7pJFh6tJHkRxvTbP4OP9HzJFGBXiBLuQD3ecu2xVZreYpZxC7LOAsnw0mnwTrdH2m3qcHjKLksAj1A+KIOz3csQYk9dvX+T99Ii3kEd0I9X+duLyuG1NH/dUg3quRsi5x2qThe2dp/4dPQFTXVsbgRhWoWGU98BzrKj7QQT0ViyacMO4qXhd8G+F8PFJdNJUXKb0cis6svWcsvCiUZB6555fgJM9PGBXuJt6f8cdjWLdIFW+uUhmoMnTJ6iThNMGz7odUYOvQOvBncrubeY3DlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64TkEKVaWCls+OXpwtxMFRHnYcM4t5Rx5SBygQGOwk8=;
 b=X/gxvdeoVtQlyMZNLpN7Ah/+AmAtWDtiPqO6NUQKOFloS0aFxLgckdtRTNEaNfOU2dBmRa39Uw2WUVMKWC5zf1aa+FtUhgXAaSwxKNV1mugbNGCDbnNSPTRX2oNCfs5p9ByLVXfXhRJCduDlwU6CklfkEVrKJX8JB9ajkhwJXnj1ZdH2mf2wKyWC2YP6h68b9EugXun5G7MIX1R582BX0u4fjX54ZBIfCKRAWV0B2WGBWsFjTYc20Z03Tvs3XFDRR9P+VghsuSqNNyItwVojRyeWOcC4tq/x4juc+79+JQDz+aC6DmEgqIfqQhCXSYV92Ms5ldRcg3Ut+alhgM/DDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64TkEKVaWCls+OXpwtxMFRHnYcM4t5Rx5SBygQGOwk8=;
 b=4Ja7PhgTbRIYLb7xoCws0UIcgU2xHmIg30pYQIM9OGf0hj4Sr2ezP75WpCH0NdqNiMN9JNh+jr+xXalxS+ZQ36nb5e8AIAhbsCcrrZVKKRBeAY9cokNy8CoCG7oVMRTBrkxva6Uk/ijxciND6/zUhTzs7LkrE73PIUSsHUIN8U8=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3183.namprd12.prod.outlook.com (20.179.82.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 03:06:01 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 03:06:01 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/powerplay: support custom power profile setting
Thread-Topic: [PATCH] drm/amd/powerplay: support custom power profile setting
Thread-Index: AQHVuWfC+gKObCWjMEmTPXZHm/tWzafIHUoAgAB9aPA=
Date: Tue, 24 Dec 2019 03:06:01 +0000
Message-ID: <MN2PR12MB334443A4A4B0081EC825C20DE4290@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191223080518.28754-1-evan.quan@amd.com>
 <CADnq5_NwvBtvXk0yUBZm=vQfaX65_Ha+bD+LwZXL8F=YKBwmGw@mail.gmail.com>
In-Reply-To: <CADnq5_NwvBtvXk0yUBZm=vQfaX65_Ha+bD+LwZXL8F=YKBwmGw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a8d94146-e1cc-4abc-bb71-0000aad50798;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-24T03:03:46Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 916c99cc-4b06-43f7-e4ae-08d7881e34ce
x-ms-traffictypediagnostic: MN2PR12MB3183:
x-microsoft-antispam-prvs: <MN2PR12MB3183694C9D92BF3D6D19EE28E4290@MN2PR12MB3183.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:265;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(13464003)(52536014)(5660300002)(2906002)(86362001)(76116006)(66556008)(66946007)(66476007)(6506007)(53546011)(64756008)(7696005)(66446008)(26005)(186003)(71200400001)(19627235002)(81156014)(8676002)(8936002)(81166006)(316002)(9686003)(55016002)(45080400002)(478600001)(966005)(4326008)(6916009)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3183;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymCf0XcrgCgHxHd8SueKKUcDQYOwy5FSVjQEkicGLrEQMb1vXC92/VuVWrawp27OvPS3CW5swlFnk/zWcufmXtjOmvKMk+Sqfis3phrQbAceYJC5w1c1acyD/aylYBRs7yRjUtKNaQ4YCnxNP9gIEVEUaUGgpgGE9DmpcMJcF2CmwXQ6jbOkCFHKoEeGx1wVqMHhaPPJpXWi26V9SULf9qfIorr9hbaEVfJyqxAjuTUJbE4JfPevmwGym7TvTbAqjhQJzdrtq2Zj8ws/tE/OQpBQCtGZG+FHgdvh5tsPc9WbFn61B+ZcEuFf9qTj4CIqA8jt+z5ftDWn8o3GOQKbUvLUcZR4Sa7aFtAFRk+ODhuB88/0+V4Zm+Xvt3D1fbnj0snQGAf8+yGlU81AK+b1F5+vpA7evsa9to50zeffv0EQwv9f0dD5bh3wgmdhRdEcQsZpJtXf+6RW0VAPvA4Okybia9IMEk8kEJ++AIAvCIiob3pgd1ZRUO+FSLJzTVZLgtyLb5ar/prWOodLqgBza1w3o09w32UYoIgxnlBPbKSluepsTV37e+QwTjIr1rrN4WQgTjkdikd7EX9QrpFt+2RDyhSPIMJyw0SXXsDL0sBWWUtUNEfJEJi0eGFXJyJClcmWwq9zS20bD4EATWkMpg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916c99cc-4b06-43f7-e4ae-08d7881e34ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 03:06:01.0866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xss2VddLcwYqBMliZFHj0Yma5HhJx38sbarvgJFFmDuY1gQzHIrmhkC4CFtI42kb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
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



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, December 24, 2019 3:35 AM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amd/powerplay: support custom power profile
> setting
> 
> On Mon, Dec 23, 2019 at 3:05 AM Evan Quan <evan.quan@amd.com> wrote:
> >
> > Support custom power profile mode settings on Arcturus.
> >
> > Change-Id: Id14f9a1cced41433b7487f447c452f8852964891
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 132
> +++++++++++++++++-
> >  .../powerplay/inc/smu11_driver_if_arcturus.h  |   6 +-
> >  2 files changed, 128 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > index 9610b9b8a54c..043ac2ab0496 100644
> > --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> > @@ -179,6 +179,7 @@ static struct smu_11_0_cmn2aisc_mapping
> arcturus_table_map[SMU_TABLE_COUNT] = {
> >         TAB_MAP(DRIVER_SMU_CONFIG),
> >         TAB_MAP(OVERDRIVE),
> >         TAB_MAP(I2C_COMMANDS),
> > +       TAB_MAP(ACTIVITY_MONITOR_COEFF),
> >  };
> >
> >  static struct smu_11_0_cmn2aisc_mapping
> > arcturus_pwr_src_map[SMU_POWER_SOURCE_COUNT] = { @@ -302,6
> +303,10 @@ static int arcturus_tables_init(struct smu_context *smu, struct
> smu_table *table
> >         SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS,
> sizeof(SwI2cRequest_t),
> >                                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> >
> > +       SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                      sizeof(DpmActivityMonitorCoeffInt_t), PAGE_SIZE,
> > +                      AMDGPU_GEM_DOMAIN_VRAM);
> > +
> 
> Is freeing this handled properly?  Assuming that is ok, the patch is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
[Quan, Evan] Yes, that is well handled. smu_fini_fb_allocations() is responsible for reclaiming all the tables.
> 
> >         smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
> >         if (!smu_table->metrics_table)
> >                 return -ENOMEM;
> > @@ -1314,6 +1319,7 @@ static int arcturus_get_power_limit(struct
> > smu_context *smu,  static int arcturus_get_power_profile_mode(struct
> smu_context *smu,
> >                                            char *buf)  {
> > +       DpmActivityMonitorCoeffInt_t activity_monitor;
> >         static const char *profile_name[] = {
> >                                         "BOOTUP_DEFAULT",
> >                                         "3D_FULL_SCREEN", @@ -1323,14
> > +1329,35 @@ static int arcturus_get_power_profile_mode(struct
> smu_context *smu,
> >                                         "COMPUTE",
> >                                         "CUSTOM"};
> >         static const char *title[] = {
> > -                       "PROFILE_INDEX(NAME)"};
> > +                       "PROFILE_INDEX(NAME)",
> > +                       "CLOCK_TYPE(NAME)",
> > +                       "FPS",
> > +                       "UseRlcBusy",
> > +                       "MinActiveFreqType",
> > +                       "MinActiveFreq",
> > +                       "BoosterFreqType",
> > +                       "BoosterFreq",
> > +                       "PD_Data_limit_c",
> > +                       "PD_Data_error_coeff",
> > +                       "PD_Data_error_rate_coeff"};
> >         uint32_t i, size = 0;
> >         int16_t workload_type = 0;
> > +       int result = 0;
> > +       uint32_t smu_version;
> >
> > -       if (!smu->pm_enabled || !buf)
> > +       if (!buf)
> >                 return -EINVAL;
> >
> > -       size += sprintf(buf + size, "%16s\n",
> > +       result = smu_get_smc_version(smu, NULL, &smu_version);
> > +       if (result)
> > +               return result;
> > +
> > +       if (smu_version >= 0x360d00)
> > +               size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
> > +                       title[0], title[1], title[2], title[3], title[4], title[5],
> > +                       title[6], title[7], title[8], title[9], title[10]);
> > +       else
> > +               size += sprintf(buf + size, "%16s\n",
> >                         title[0]);
> >
> >         for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) { @@
> > -1342,8 +1369,50 @@ static int arcturus_get_power_profile_mode(struct
> smu_context *smu,
> >                 if (workload_type < 0)
> >                         continue;
> >
> > +               if (smu_version >= 0x360d00) {
> > +                       result = smu_update_table(smu,
> > +                                                 SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                                 workload_type,
> > +                                                 (void *)(&activity_monitor),
> > +                                                 false);
> > +                       if (result) {
> > +                               pr_err("[%s] Failed to get activity monitor!", __func__);
> > +                               return result;
> > +                       }
> > +               }
> > +
> >                 size += sprintf(buf + size, "%2d %14s%s\n",
> >                         i, profile_name[i], (i ==
> > smu->power_profile_mode) ? "*" : " ");
> > +
> > +               if (smu_version >= 0x360d00) {
> > +                       size += sprintf(buf + size,
> "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
> > +                               " ",
> > +                               0,
> > +                               "GFXCLK",
> > +                               activity_monitor.Gfx_FPS,
> > +                               activity_monitor.Gfx_UseRlcBusy,
> > +                               activity_monitor.Gfx_MinActiveFreqType,
> > +                               activity_monitor.Gfx_MinActiveFreq,
> > +                               activity_monitor.Gfx_BoosterFreqType,
> > +                               activity_monitor.Gfx_BoosterFreq,
> > +                               activity_monitor.Gfx_PD_Data_limit_c,
> > +                               activity_monitor.Gfx_PD_Data_error_coeff,
> > +
> > + activity_monitor.Gfx_PD_Data_error_rate_coeff);
> > +
> > +                       size += sprintf(buf + size,
> "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
> > +                               " ",
> > +                               1,
> > +                               "UCLK",
> > +                               activity_monitor.Mem_FPS,
> > +                               activity_monitor.Mem_UseRlcBusy,
> > +                               activity_monitor.Mem_MinActiveFreqType,
> > +                               activity_monitor.Mem_MinActiveFreq,
> > +                               activity_monitor.Mem_BoosterFreqType,
> > +                               activity_monitor.Mem_BoosterFreq,
> > +                               activity_monitor.Mem_PD_Data_limit_c,
> > +                               activity_monitor.Mem_PD_Data_error_coeff,
> > +                               activity_monitor.Mem_PD_Data_error_rate_coeff);
> > +               }
> >         }
> >
> >         return size;
> > @@ -1353,18 +1422,69 @@ static int
> arcturus_set_power_profile_mode(struct smu_context *smu,
> >                                            long *input,
> >                                            uint32_t size)  {
> > +       DpmActivityMonitorCoeffInt_t activity_monitor;
> >         int workload_type = 0;
> >         uint32_t profile_mode = input[size];
> >         int ret = 0;
> > -
> > -       if (!smu->pm_enabled)
> > -               return -EINVAL;
> > +       uint32_t smu_version;
> >
> >         if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> >                 pr_err("Invalid power profile mode %d\n", profile_mode);
> >                 return -EINVAL;
> >         }
> >
> > +       ret = smu_get_smc_version(smu, NULL, &smu_version);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
> > +            (smu_version >=0x360d00)) {
> > +               ret = smu_update_table(smu,
> > +                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                      WORKLOAD_PPLIB_CUSTOM_BIT,
> > +                                      (void *)(&activity_monitor),
> > +                                      false);
> > +               if (ret) {
> > +                       pr_err("[%s] Failed to get activity monitor!", __func__);
> > +                       return ret;
> > +               }
> > +
> > +               switch (input[0]) {
> > +               case 0: /* Gfxclk */
> > +                       activity_monitor.Gfx_FPS = input[1];
> > +                       activity_monitor.Gfx_UseRlcBusy = input[2];
> > +                       activity_monitor.Gfx_MinActiveFreqType = input[3];
> > +                       activity_monitor.Gfx_MinActiveFreq = input[4];
> > +                       activity_monitor.Gfx_BoosterFreqType = input[5];
> > +                       activity_monitor.Gfx_BoosterFreq = input[6];
> > +                       activity_monitor.Gfx_PD_Data_limit_c = input[7];
> > +                       activity_monitor.Gfx_PD_Data_error_coeff = input[8];
> > +                       activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
> > +                       break;
> > +               case 1: /* Uclk */
> > +                       activity_monitor.Mem_FPS = input[1];
> > +                       activity_monitor.Mem_UseRlcBusy = input[2];
> > +                       activity_monitor.Mem_MinActiveFreqType = input[3];
> > +                       activity_monitor.Mem_MinActiveFreq = input[4];
> > +                       activity_monitor.Mem_BoosterFreqType = input[5];
> > +                       activity_monitor.Mem_BoosterFreq = input[6];
> > +                       activity_monitor.Mem_PD_Data_limit_c = input[7];
> > +                       activity_monitor.Mem_PD_Data_error_coeff = input[8];
> > +                       activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
> > +                       break;
> > +               }
> > +
> > +               ret = smu_update_table(smu,
> > +                                      SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                      WORKLOAD_PPLIB_CUSTOM_BIT,
> > +                                      (void *)(&activity_monitor),
> > +                                      true);
> > +               if (ret) {
> > +                       pr_err("[%s] Failed to set activity monitor!", __func__);
> > +                       return ret;
> > +               }
> > +       }
> > +
> >         /*
> >          * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> >          * Not all profile modes are supported on arcturus.
> > diff --git
> > a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
> > b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
> > index a886f0644d24..910226ec512e 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
> > @@ -823,7 +823,6 @@ typedef struct {
> >    uint32_t MmHubPadding[8]; // SMU internal use  }
> > AvfsFuseOverride_t;
> >
> > -/* NOT CURRENTLY USED
> >  typedef struct {
> >    uint8_t   Gfx_ActiveHystLimit;
> >    uint8_t   Gfx_IdleHystLimit;
> > @@ -866,7 +865,6 @@ typedef struct {
> >
> >    uint32_t  MmHubPadding[8]; // SMU internal use  }
> > DpmActivityMonitorCoeffInt_t; -*/
> >
> >  // These defines are used with the following messages:
> >  // SMC_MSG_TransferTableDram2Smu
> > @@ -878,11 +876,11 @@ typedef struct {
> >  #define TABLE_PMSTATUSLOG             4
> >  #define TABLE_SMU_METRICS             5
> >  #define TABLE_DRIVER_SMU_CONFIG       6
> > -//#define TABLE_ACTIVITY_MONITOR_COEFF  7
> >  #define TABLE_OVERDRIVE               7
> >  #define TABLE_WAFL_XGMI_TOPOLOGY      8
> >  #define TABLE_I2C_COMMANDS            9
> > -#define TABLE_COUNT                   10
> > +#define TABLE_ACTIVITY_MONITOR_COEFF  10
> > +#define TABLE_COUNT                   11
> >
> >  // These defines are used with the SMC_MSG_SetUclkFastSwitch message.
> >  typedef enum {
> > --
> > 2.24.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cev
> >
> an.quan%40amd.com%7Cc291ae2fc8ad4b4c095208d787df37bb%7C3dd8961fe
> 4884e6
> >
> 08e11a82d994e183d%7C0%7C0%7C637127265093035498&amp;sdata=hqgAJP
> %2F9vIG
> > H8%2F2D6XgpyqtVXkMDeXpeK44aN8k9Xw4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
