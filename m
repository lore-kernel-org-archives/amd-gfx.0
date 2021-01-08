Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75083C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1223D2368A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1223D2368A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D95D6E7EA;
	Fri,  8 Jan 2021 10:03:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D496E7EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 10:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT0c94I30FATCq60phHbt9E3Jx1TkYljubYI+UbE9Vezd6nCznAstfoSXgL6d6eIFeTOkjdFEdQMUGTM2wo9v4MLQMupYylIXKoAATP9ED2jzswkllsqeDBUKgfwem/l3NhOmnvCgj7Lf5SsbBCPiJ0XdP4WmqUfJ3+Qfk4x542sQfyn95NLCGc2B4ON91VRyJ86LU8ZttvgVPWSlCTHgvOLfPdKlqyqeFBEszAnjDaYAozs6mURse0kywAlxye70ry6e0IL3acOncHkfY80V2SSiRzs46Z7lfrSihqinn2rRG7TzzF4hFfJEI9RHoDx6WpZ+gLwH40+56kqfFcJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNzfcI0FbeSFafgNaJvVAdUtkj9kDShoH7Vpk9ATC+A=;
 b=XKo+j4DJADNTAYlKfr2Tv2gshiaK8BdwvHt/oECV83Y72rGQQnBlwAOzrQKq4wqR87dzi7DijZaH/xD6s9E0NzxvKw7sObtecTWTy2vqlDJbAwhOMq6HU/cUc9/HI6hRZyEiMXxNgc8dmgPrlFCGtoneYgoGKnbEflwiwGjyrKVdlNmPA6t4YKrLKzsXgVVMP9LNXM2Zdt4ZL3/EOgv1dDxCRuftwjcBJjvEs5Ah8/wiT7xeAbkNm3lRiHZbnrbQcxivp75U6sAaJZQNvS9gP8F7mImoH0GJg76MM9yaaWZDvKBfx12+fQggXZfff7ckzJQBRt/vOl6Dvpu/7xcj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNzfcI0FbeSFafgNaJvVAdUtkj9kDShoH7Vpk9ATC+A=;
 b=LIZXP2dWlSmPby4MletHiO/KI4ejAu3ayMb0/xzxpZxu4rm8jDrbz6z6qMoANV3Dz00byQzxi9dhADWc0LH26n+HfD8AH0wW9RRueaMNyoanBp6iABignfXgAQ+yc4nwMMksD1XOxX+CUdk/Kgtj0Q2JVaSY0bkOxt02LHmkJ6k=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Fri, 8 Jan 2021 10:03:55 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 10:03:55 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/7] drm/amd/pm: implement the processor clocks which read
 by metric
Thread-Topic: [PATCH 6/7] drm/amd/pm: implement the processor clocks which
 read by metric
Thread-Index: AQHW5ZwXprfyVQZCsE2H/V5m7LWjT6odf5NA
Date: Fri, 8 Jan 2021 10:03:55 +0000
Message-ID: <DM6PR12MB2619256973E6EF00A3041301E4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
 <20210108085507.1164588-7-ray.huang@amd.com>
In-Reply-To: <20210108085507.1164588-7-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1903eb50-f584-484d-a3f1-2ffce4d74c03;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-08T10:02:39Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11b2f2a8-87df-4d37-24e0-08d8b3bcb597
x-ms-traffictypediagnostic: DM6PR12MB4957:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB495770EA9D7FEF8755AFDE88E4AE0@DM6PR12MB4957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LR2yhedUChP2wR5O9Ukk+SBVnx6du5PBz0O7MG9z3IcypDyu08cREP1dapY2nLed30qs7ghTClq8RxCGERq+z0tMs5/xhGI8hnnSbbRe384mN/bixa+Aaauvy39m3zjGhmCBkKXiN/qCwegjW3kivVjUWInep+mqs8LU2UuiOQGg/32LnS5zCx7nnHGMWZQMew/lrn0+VnyHO6UHszYAIUwQgInRNaP+gFJ282EnLzu3FrW+lTRAGIq4WmGklLbUeKzYi0ChTWdj06oZ4E/5dcpdRjOzctN5PgGbDy4RKzSKKzTSazU/yyiqvK3R3Gwlu+j47mjfYjiN8EKcGULl1gEJFPxS0TXHMnST/ZS6VMQSVTpmEfoGUnXw9IbeABE3n5+OAWvk4ffOT1zYdQyySC0DYdqyICbSUrz7ydJKT0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(66446008)(64756008)(66556008)(86362001)(66476007)(5660300002)(966005)(66946007)(45080400002)(110136005)(26005)(6506007)(186003)(53546011)(33656002)(54906003)(52536014)(316002)(2906002)(4326008)(76116006)(9686003)(83380400001)(7696005)(71200400001)(8676002)(55016002)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZkCaigMqCMTdUaLQP370H1FXvLRK8d0sD5hif/WB2Nj6cXBAmu9O2NzaubPv?=
 =?us-ascii?Q?47DmsZgEVyyxCJwu9lc7G7YpF2iw+d7jqSAoUKcxnU2OX9f+BbPR/eEjUmv6?=
 =?us-ascii?Q?xxbo2pafQaTN9rXlJb0i3DEumPhAtK/eU0AEtq7lf+MkgDYZiE6iBOMjg5gh?=
 =?us-ascii?Q?ChhdVsdDwodEMTCb78YoT0gm/6f1ByDuExmod6HSxKM72Sh7tveb5EETdzo5?=
 =?us-ascii?Q?geOnnbm/ZEI7goObhT6EUv8BRU7ZoRfeMzxRdqXHvitTb9Q6r+uVQIeXUfL4?=
 =?us-ascii?Q?FhIOQu4SLDLx3xn4AG6leP0XIPMqkeoMTW6z/F4fvRZR+Q0LlEaoiJOlZ8Gs?=
 =?us-ascii?Q?8uAtM9RxJqOyQ7G8S269AAdKAaMWwJEYVJVFHYWPtyFCkt1DXIPm38+xHsD4?=
 =?us-ascii?Q?xc+mrC2lfR8yxYEOoMWSXVVUT29JiFynFhQRt13A4Wyc6VqIQso9m+a2Zvb+?=
 =?us-ascii?Q?f8JTtDk6eh54fYGM9elrDYZDZC+bcUjn9pR841SR+sB2h0FIrqU7C0z/z3IV?=
 =?us-ascii?Q?s+Tg+Et0tW8bevvfO+XzAyYmoBmIaTZg3FMzMclvbNSLC1PddcIlHaXea5vd?=
 =?us-ascii?Q?aTUS0SLRgS91e/g81jQ/9a0qy+4EOnJKDPL5OxUPNz8atRSJ9Qbv3DJ21TXm?=
 =?us-ascii?Q?NkGeghbSmKEvF2a6AvBrMS7twWxbJphexEUJ/qzAbHKExUVPV7scvfryKuAX?=
 =?us-ascii?Q?lSJaBNT5hDxu40RhQxs5iOKd8gfwDnVgFo/bdhuR6gQDSVwPZyc8mYtUOZu8?=
 =?us-ascii?Q?rrOh0EhRxE2zqivSVDsWFzw/p2YKPOglhbFcCkcYbBM0KC2kJGIBeZbRD5LY?=
 =?us-ascii?Q?TNWroZEd1ne6+NeTcxM25qk2VcvjgA1BQI/QPudF7jucWiVKAn+cwKH2IV5b?=
 =?us-ascii?Q?OKUEgOdGP2gzGMbOA26zKvc+cTdhdUnh/aNfI5cpOtVusmHkh0r7+9uTiECl?=
 =?us-ascii?Q?tR0TgZgCxCdtdFNq8nqNR/MnWPVeu13RjccEMWKhBeg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b2f2a8-87df-4d37-24e0-08d8b3bcb597
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 10:03:55.3311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6O+WtfA121hsjz++PnpY3yQiLkgcx9xtQNbRaH7cZtAYWC4oLCAeh4emrwo/SDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hou, Xiaomeng
 \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Patch1, 3-6 are reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Friday, January 8, 2021 4:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH 6/7] drm/amd/pm: implement the processor clocks which read by metric

The core processor clocks will be stored in smu metric table, then we
add this runtime information into amdgpu_pm_info interface.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 25 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 11 ++++++++
 5 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 270f8db5115a..57b24c4c205b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -103,6 +103,7 @@ enum pp_clock_type {

 enum amd_pp_sensors {
 AMDGPU_PP_SENSOR_GFX_SCLK = 0,
+AMDGPU_PP_SENSOR_CPU_CLK,
 AMDGPU_PP_SENSOR_VDDNB,
 AMDGPU_PP_SENSOR_VDDGFX,
 AMDGPU_PP_SENSOR_UVD_VCLK,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 97c669dd4cac..a5be03aa384b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -36,6 +36,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/nospec.h>
 #include <linux/pm_runtime.h>
+#include <asm/processor.h>
 #include "hwmgr.h"

 static const struct cg_flag_name clocks[] = {
@@ -3621,6 +3622,27 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
  */
 #if defined(CONFIG_DEBUG_FS)

+static void amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
+   struct amdgpu_device *adev) {
+uint16_t *p_val;
+uint32_t size;
+int i;
+
+if (is_support_cclk_dpm(adev)) {
+p_val = kcalloc(boot_cpu_data.x86_max_cores, sizeof(uint16_t),
+GFP_KERNEL);
+
+if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_CPU_CLK,
+    (void *)p_val, &size)) {
+for (i = 0; i < boot_cpu_data.x86_max_cores; i++)
+seq_printf(m, "\t%u MHz (CPU%d)\n",
+   *(p_val + i), i);
+}
+
+kfree(p_val);
+}
+}
+
 static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *adev)
 {
 uint32_t value;
@@ -3631,6 +3653,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 /* GPU Clocks */
 size = sizeof(value);
 seq_printf(m, "GFX Clocks and Power:\n");
+
+amdgpu_debugfs_prints_cpu_info(m, adev);
+
 if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK, (void *)&value, &size))
 seq_printf(m, "\t%u MHz (MCLK)\n", value/100);
 if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK, (void *)&value, &size))
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index a9622b5e9c7b..97d788451624 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1122,6 +1122,7 @@ typedef enum {
 METRICS_CURR_DCLK1,
 METRICS_CURR_FCLK,
 METRICS_CURR_DCEFCLK,
+METRICS_AVERAGE_CPUCLK,
 METRICS_AVERAGE_GFXCLK,
 METRICS_AVERAGE_SOCCLK,
 METRICS_AVERAGE_FCLK,
@@ -1250,6 +1251,7 @@ extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;

 bool is_support_sw_smu(struct amdgpu_device *adev);
+bool is_support_cclk_dpm(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_sys_get_pp_table(struct smu_context *smu, void **table);
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d80f7f8efdcd..22868ad87628 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -288,6 +288,20 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 return false;
 }

+bool is_support_cclk_dpm(struct amdgpu_device *adev)
+{
+struct smu_context *smu = &adev->smu;
+
+if (!is_support_sw_smu(adev))
+return false;
+
+if (!smu_feature_is_enabled(smu, SMU_FEATURE_CCLK_DPM_BIT))
+return false;
+
+return true;
+}
+
+
 int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 {
 struct smu_table_context *smu_table = &smu->smu_table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 233c6e4ddd01..63be82386964 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -34,6 +34,7 @@
 #include "soc15_common.h"
 #include "asic_reg/gc/gc_10_3_0_offset.h"
 #include "asic_reg/gc/gc_10_3_0_sh_mask.h"
+#include <asm/processor.h>

 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -285,6 +286,10 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 case METRICS_VOLTAGE_VDDSOC:
 *value = metrics->Voltage[1];
 break;
+case METRICS_AVERAGE_CPUCLK:
+memcpy(value, &metrics->CoreFrequency[0],
+       boot_cpu_data.x86_max_cores * sizeof(uint16_t));
+break;
 default:
 *value = UINT_MAX;
 break;
@@ -1113,6 +1118,12 @@ static int vangogh_read_sensor(struct smu_context *smu,
    (uint32_t *)data);
 *size = 4;
 break;
+case AMDGPU_PP_SENSOR_CPU_CLK:
+ret = vangogh_get_smu_metrics_data(smu,
+   METRICS_AVERAGE_CPUCLK,
+   (uint32_t *)data);
+*size = boot_cpu_data.x86_max_cores * sizeof(uint16_t);
+break;
 default:
 ret = -EOPNOTSUPP;
 break;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ca57b119517c043e0ee2e08d8b3b3387e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637456929628573264%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7fGIbxa6tc5305qiStYRlRNait7FaRWXdkCAB%2Fn8Oms%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
