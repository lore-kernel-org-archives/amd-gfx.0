Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8192C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 01:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A189C22E00
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 01:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A189C22E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3616E3D8;
	Thu,  7 Jan 2021 01:39:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEC36E3D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 01:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBKof4UBW8Ky+YmfFTorYTBtk1/sDHd7sccmu9InXgrNHxFsosP2QzBGngp5X2hyNQS3+LKEOWIZunWPSYySbMe7Lgv2MyEvY9G/XAVSpVOzSIEuegj38bSTvKtkoazuY163ArP3M/ZTh4onFYp25NxUkeEA8v3q1Ygy6FiAwcNxoFpkIMKXngRlsnZ7nAQ/R1QRyQe190vQtEpnCl/pV1xnxjwcSehpXH4q8YjSCZ2K+QPt6SuzBpf58It25Q1/pIPoCUUaNIjyzM4thORFgbI22j56HZbGkuUOkes1ocGB6v1aNk+2CSuF1gTfL6r0m2rJ04YouzwDPfCrbJcPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLSI3MIpSOCdiAjifd22NPPEosEhIY/uOZqxflVmpX0=;
 b=npkdypM0SqsISntd3IFzVAp++zOiWiKErQAnAKwYVzyWD22KGYnsQMhA3MjIMA0Jb0n/4UkxriyizXzrCKwU3UtXB4ZL2dUieUMzCT6pEiy71Od+6WVCf1EcK2AMKJvW7Iy206ktGUm6yFSpFDQZVvj0pc+6FuF4j6c/pnu5oBlcmthlQohEB1wd+fZmZnTWMdz8rbOvZ6Xewn0AxgEWDITtoI5eVJnu4+qPoiW+l06h2gT943Je8rK7ecxSuHD4N634S5wtO5QfHzy5J8BnsvWyYblWQVuyG+LK8pbZbcpz+6RGCLmyGISszaqI88V3MUnHu0NVk/7segBicFLpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLSI3MIpSOCdiAjifd22NPPEosEhIY/uOZqxflVmpX0=;
 b=GhOADuaqVqjGhoc5upmetTxGaPu90V7APotHYQUJgrTd3tVseQshdIGAMj9EyYtDjuepmTunXQvsHLOpo8BaPrplHnGMbeQQLaAxN5w/qJ60NgDd1D45a6JCEZcxp3FFBbV+XgbAvdwUn0Xz01Hqc3pZFQrNfGWSOfyRlMtShtg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3084.namprd12.prod.outlook.com (2603:10b6:5:117::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.22; Thu, 7 Jan 2021 01:39:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 01:39:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Taylor, Ryan" <Ryan.Taylor@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add swsmu init documentation
Thread-Topic: [PATCH] drm/amd/pm: add swsmu init documentation
Thread-Index: AQHW5IY1Nnm4qMATeECkUfnnBO9AYqobYoJA
Date: Thu, 7 Jan 2021 01:39:38 +0000
Message-ID: <DM6PR12MB261953BEA8C1B8D67E81CADCE4AF0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210106234459.34325-1-Ryan.Taylor@amd.com>
In-Reply-To: <20210106234459.34325-1-Ryan.Taylor@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d57045a5-96b1-4dfc-b9cf-db87ea0b3fdd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-07T01:38:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4c14a19-3b9a-440b-36d5-08d8b2ad18cd
x-ms-traffictypediagnostic: DM6PR12MB3084:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30844DCFE1A743D7D4691AFEE4AF0@DM6PR12MB3084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BJGXAV9lrhSP2M5gZudckC1f0znb/oKXintRxgoqscsuo9D7MCWatz9IzQhezk2xHMsGbQ5ygLShyrAsNM+IBHAL5B7b/OTZMw75qgtMtsZbx48wWK15OLxnHTKGGZi++hmmkS/gg6vXVbH4ZJLflI5Zr4i8mCenoJCiT3LT7BJKyWN2r1F8eHRKL0+CB0VbeQqjoPXgVZM6gp2z4vhWMx0L4PJIxZTMozDMhHWsINC0pNfyBuUQ0d7/cR/qFZg+ci0jXpTHTLt/oyh2rUoIxhHLHM9742flRbUXDpPwDmGrRtExsMEG2tIvP9l0CNxcuvU3vmG47JmQZYWrT8cRZmft9PdGlEm41bpOvG8rChiPq4jNdZmz2eoSRpC9/OpTMRlSNv2oFlAAHOZPZKcnZIJXwlOloA98LmLfp6CH4Q81TMsFKEDEFi8lsA3DDj8p9cNRO0/Kl9vm3QGma9aVslHeMCu0zF6y+xJDi7STrnc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(966005)(4326008)(6506007)(316002)(76116006)(33656002)(7696005)(8676002)(83380400001)(8936002)(2906002)(5660300002)(52536014)(86362001)(45080400002)(66476007)(478600001)(66556008)(66946007)(64756008)(54906003)(66446008)(26005)(186003)(55016002)(9686003)(110136005)(53546011)(71200400001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FqyykOUjC4/WErNbQJ64zKgqAeGOQmDO+D61TRt8XiX32gn5H7KzabN0TAt9?=
 =?us-ascii?Q?XrBV9ChTmZeCmr/pNUOOe8jGD1jaUthxZEk9kaBPovDHEYKBWdBaDQ294SkS?=
 =?us-ascii?Q?PmaF0cvlwPo2kMkcgcJ8puSnr4xOuRkotdbkTNFPp9Ahv3Hh/VWW6xnWfWVL?=
 =?us-ascii?Q?BqGTRfsPm/pj67iigCNOZtFJWxQ8NzgI571Z0WgAChnagJmLGymZYZsYGUc5?=
 =?us-ascii?Q?MqxMJkwMkG4iRQpnEaAl4chUROXyjI35EPNs2OQ7DKd3r2JM3e/MWDMH7Q4L?=
 =?us-ascii?Q?NpwPJ/gVzL6BwVPJzYiHPyEtlBppqUQcRZ0V/XtpzSTZ8fbnAQi3xUWmWRDQ?=
 =?us-ascii?Q?FXZL2TUaG/NUkOVVh+v0nkTkhFiDweWJbGU8r8lTD6RLCdi+dVYa/ik6axvS?=
 =?us-ascii?Q?IHeXT5y5VL/etZ8Xa7WULqUIV9+F1w7Jd2BqPzBMLXqawPSiXb6xAO5wzsj1?=
 =?us-ascii?Q?04Smdv5LGTDWFLkcio+mYJja0wCETNu6D2MENdZSTjm71K02MSgNn+/nqUFX?=
 =?us-ascii?Q?3NkDrE1ayb1Ag9vyJS/CC6YSOFmyGbBRirRPKUpMyP9+KyPT4ax2wbTCyhL6?=
 =?us-ascii?Q?jbmTlxVk5LWFQHJtIyhxOlCDW8rgP08JKxiAPc/ZIfM1N6w736L/SQGttErm?=
 =?us-ascii?Q?jIQRLEZZyd5sjg9wdgYtgC+GXncD/Tk42Zh8RZZWAdWUFRAZ/4wUi8/rpgGJ?=
 =?us-ascii?Q?k82oXuOiWOT9hH0m0NNufs3mRSFlwRm63fsxV+ZO4TrZgSju1isEG9B2Bi/d?=
 =?us-ascii?Q?kBOe8890JNmRZcqbx0+dd/Zc4W0i68MdvC5cbLnuSzq+SL5lnOsv5+BFijD7?=
 =?us-ascii?Q?yUMl2oct3DwWuD/TtbIprXG97PR0QVPpJiUv9HRv5iNjpCxEVuv0w6xL6YHa?=
 =?us-ascii?Q?Zeawx4Qygr9SfTO7dO4kdq8HSQzwt1TLFcnq/LgP9yXEN8rO/iWeCXycr9OX?=
 =?us-ascii?Q?egDXX9r7TQuo7Vi3jPWDdHT60FbX1wk56ZOfY+B+VgY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c14a19-3b9a-440b-36d5-08d8b2ad18cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 01:39:38.6444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBSAsmx6JfzQNVHIhbqdBplf2ewdf1l6NwTvF4+L+MrwM8XYFdsJtgAJzmQQIq1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Taylor,
 Ryan" <Ryan.Taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ryan Taylor
Sent: Thursday, January 7, 2021 7:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Taylor, Ryan <Ryan.Taylor@amd.com>
Subject: [PATCH] drm/amd/pm: add swsmu init documentation

Documents functions used in swsmu initialization.

Signed-off-by: Ryan Taylor <Ryan.Taylor@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 94 ++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d80f7f8efdcd..82099cb3d00a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -376,6 +376,15 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 return ret;
 }

+/**
+ * smu_set_funcs - Set ASIC specific SMU communication tools and data.
+ * @adev: amdgpu_device pointer
+ *
+ * Set hooks (&struct pptable_funcs), maps (&struct cmn2asic_mapping) and
+ * basic ASIC information (is_apu, od_enabled, etc.).
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_set_funcs(struct amdgpu_device *adev)
 {
 struct smu_context *smu = &adev->smu;
@@ -417,6 +426,15 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 return 0;
 }

+/**
+ * smu_early_init - Early init for the SMU IP block.
+ * @handle: amdgpu_device pointer
+ *
+ * Perform basic initialization of &struct smu_context. Set ASIC specific SMU
+ * communication tools and data using smu_set_funcs().
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
 static int smu_early_init(void *handle)
 {
 struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -424,10 +442,12 @@ static int smu_early_init(void *handle)

 smu->adev = adev;
 smu->pm_enabled = !!amdgpu_dpm;
+/* Assume ASIC is not an APU until updated in smu_set_funcs(). */
 smu->is_apu = false;
 mutex_init(&smu->mutex);
 mutex_init(&smu->smu_baco.mutex);
 smu->smu_baco.state = SMU_BACO_STATE_EXIT;
+/* Disable baco support until the SMU engine is running. */
 smu->smu_baco.platform_support = false;

 return smu_set_funcs(adev);
@@ -472,6 +492,17 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 return ret;
 }

+
+/**
+ * smu_late_init - Finish setting up the SMU IP block.
+ * @adev: amdgpu_device pointer
+ *
+ * Setup SMU tables/values used by other driver subsystems and in userspace
+ * (Overdrive, UMD power states, etc.). Perform final SMU configuration (set
+ * performance level, update display config etc.).
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_late_init(void *handle)
 {
 struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -514,6 +545,8 @@ static int smu_late_init(void *handle)

 smu_get_fan_parameters(smu);

+/* Sets performance level, power profile mode and display
+ * configuration. */
 smu_handle_task(&adev->smu,
 smu->smu_dpm.dpm_level,
 AMD_PP_TASK_COMPLETE_INIT,
@@ -601,7 +634,7 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 /**
  * smu_alloc_memory_pool - allocate memory pool in the system memory
  *
- * @smu: amdgpu_device pointer
+ * @smu: smu_context pointer
  *
  * This memory pool will be used for SMC use and msg SetSystemVirtualDramAddr
  * and DramLogSetDramAddr can notify it changed.
@@ -701,6 +734,15 @@ static void smu_free_dummy_read_table(struct smu_context *smu)
 memset(dummy_read_1_table, 0, sizeof(struct smu_table));
 }

+/**
+ * smu_smc_table_sw_init -  Initialize shared driver/SMU communication tools.
+ * @smu: smu_context pointer
+ *
+ * Allocate VRAM/DRAM for shared memory objects (SMU tables, memory pool, etc.).
+ * Initialize i2c.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
 int ret;
@@ -799,6 +841,18 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 mutex_unlock(&smu->mutex);
 }

+/**
+ * smu_sw_init - Software init for the SMU IP block.
+ * @handle: amdgpu_device pointer
+ *
+ * Configure &struct smu_context with boot default performance profiles (power
+ * profile, workload, etc.) and power savings optimizations (powergate
+ * VCN/JPEG). Request the SMU's firmware from the kernel. Initialize features,
+ * locks, and kernel work queues. Initialize driver/SMU communication tools
+ * using smu_smc_table_sw_init(). Register the interrupt handler.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_sw_init(void *handle)
 {
 struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -820,6 +874,7 @@ static int smu_sw_init(void *handle)
 INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 atomic64_set(&smu->throttle_int_counter, 0);
 smu->watermarks_bitmap = 0;
+
 smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;

@@ -914,6 +969,18 @@ static int smu_get_thermal_temperature_range(struct smu_context *smu)
 return ret;
 }

+/**
+ * smu_smc_hw_setup - Configure SMU hardware for boot/resume.
+ * @smu: smu_context pointer
+ *
+ * Configure the following SMU hardware parameters: voltage frequency curve,
+ * power play table, features, system PCIe capabilities and shared memory
+ * locations. Use the configured SMU to setup thermal interrupts and populate
+ * the DPM tables. Finally, prepare the SMU for display component
+ * synchronization.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
 struct amdgpu_device *adev = smu->adev;
@@ -929,6 +996,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 return ret;
 }

+/* Disables display tracking. */
 ret = smu_init_display_count(smu, 0);
 if (ret) {
 dev_info(adev->dev, "Failed to pre-set display count as 0!\n");
@@ -991,6 +1059,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 if (!smu_is_dpm_running(smu))
 dev_info(adev->dev, "dpm has been disabled\n");

+/* Get the system's PCIE capabilities. */
 if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 pcie_gen = 3;
 else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
@@ -1061,6 +1130,16 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 return ret;
 }

+/**
+ * smu_start_smc_engine - Start the SMU engine.
+ * @smu: smu_context pointer
+ *
+ * Load SMU firmware if not loaded by PSP. Verify that firmware was
+ * loaded successfully. Check SMU firmware interface version (version mismatch
+ * is not a critical failure).
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_start_smc_engine(struct smu_context *smu)
 {
 struct amdgpu_device *adev = smu->adev;
@@ -1095,6 +1174,17 @@ static int smu_start_smc_engine(struct smu_context *smu)
 return ret;
 }

+/**
+ * smu_hw_init - Hardware init for the SMU IP block.
+ * @handle: amdgpu_device pointer
+ *
+ * Start the SMU engine using smu_start_smc_engine(). Setup SMU configuration
+ * information (pptable, boot values, features). Configure SMU hardware for
+ * boot/resume using smu_smc_hw_setup(). Get table of maximum sustainable clock
+ * speeds from the SMU.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_hw_init(void *handle)
 {
 int ret;
@@ -1112,6 +1202,8 @@ static int smu_hw_init(void *handle)
 return ret;
 }

+/* APUs boot with several components turned off to save power. Enable
+ * these IP blocks so that APUs are in the same state as other ASICs. */
 if (smu->is_apu) {
 smu_powergate_sdma(&adev->smu, false);
 smu_dpm_set_vcn_enable(smu, true);
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C872614db498249c8847b08d8b29d55e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637455736122825324%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lGQlId1bjXKw66d1aS4aQ5jskShhXjiDowhYiPRXhkE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
