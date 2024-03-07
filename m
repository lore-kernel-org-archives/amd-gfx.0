Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52929C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 12:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7BA10F0C9;
	Thu,  7 Mar 2024 12:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EDFo/BAp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D918D10F0C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 12:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7HQqIAkcMmYODvEm+2fitBbAZp/FzF7WK9Zmyc19RofH1iUdSIFLevx8zP4FTFq0mVHGn7zjoHYkfFC7oJ6PS4WMXzT70fNX2tPiJhuNFQA30Fs3yP5qh69W8BFqPrOJRxJL11nmivZnIXe7wPEoqY1l/ekI9cbeyOQrqEG6tJtpm2XPnyfrasaf1yljEiQwKZ1O1F0wOkfHBBKnl9uBWsvOQ31ligXPmeFdpGcVBcgHRZhCXXRNhYkMR9h889AsFIewJfgQ2PQi9mHTYWzsc36DaSny97jF8NTr/f+rGT5Nhvtqw4/47kjJo2yI2zPD7CjOigkXGmN3QSdr23Vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dd9iNM3vKH8yrQTQCP4xTtJjjXYm/NAR1FT4ioHjcLU=;
 b=PsCnhByMK8gqSsP2a3bBltS7zfFkvYeBERSkpDY1l93TbnVhDKWCE4q/JSeRBv2Hw7LPlRwMgjxDQC9bxDJa9ydBGK71GLcP2pRouXQcCwJxMUN2kOf0lRptdCScd3SmGaYIjQQtEDBeC5hZVBhNPE+pIt9lxWBK5Q1wdPR/qBo03ZN/4bA/a1iWryvJSC6uUQkkLJ9zP4Uzr2BhLdeMtHo+UOkN9cZmNJ7rSha6CnQM/XQ7SR54qA4jy+SggAfKvfO0d2nkvmU3jBaQMYTS8Z6fOmp53FKCBt/m4MRQJIib1/Jg8u3rfU5VDb4TglRVoiKSCeMk/zDTkK15JktURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd9iNM3vKH8yrQTQCP4xTtJjjXYm/NAR1FT4ioHjcLU=;
 b=EDFo/BApetzwqY30gHUMA8nOZltf+AJ1sbq9kjBAZuIG1m62wC+wife4cJUsZjy/oFJGptOKhhb+ZdJdDpM3QPDoNfxc8HQ3yl5k9iCuN5V2iRaTaenN1whukojfy/3mhdi3mTKav01E9IrUM3HbNZ8uS37PaAI9IBcicwIWsNs=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 12:59:30 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::a1c6:58af:2578:8ff6]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::a1c6:58af:2578:8ff6%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 12:59:30 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du, Xiaojian"
 <Xiaojian.Du@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add the sensor value of VCN activity
Thread-Topic: [PATCH 1/2] drm/amdgpu: add the sensor value of VCN activity
Thread-Index: AQHacGy99h6dWL8zBECGEkE41AlXM7EsPL+g
Date: Thu, 7 Mar 2024 12:59:30 +0000
Message-ID: <PH7PR12MB5997B0E47A5DB32F55E7E64D82202@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240307085124.354075-1-Xiaojian.Du@amd.com>
In-Reply-To: <20240307085124.354075-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CYYPR12MB8731:EE_
x-ms-office365-filtering-correlation-id: eeb768e1-5c31-4cc9-6310-08dc3ea66d65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q3wUUpqacHIapHuMRhROyCQ/ZFQa7CvdSPna5I5Zv48qav9uZX8Q9G9jKYVfwSOpjG53v9HMccgb71WIjRjhuZE+vCnrvPJpIp44VJiuFsrOUHx8av1WZenW3scGwiyCJOr+HB4sVMqNNiie/lCR6tXNLPSREoK7rKKGdN/wTsc5I/2ohxtZhpZ0poOR/IIWGXS18r/JGxAoosag4OwvexR/rpt59rpF5GU9HYbnORJZdjRFk6cwBmQCdi9WXhJz/8ez0p2XGCtpj7k3U8Z+BAjlTAqAY3HHuSG1Apa1jZLlstYD28Gk+WIfErY+yTW/BH+0D7agudN+Re4nw0DIWaO9/QYSLoqguAtUNWPTJr1ai0kH2T0Cr9nXRDLW2vRb71zTX3lwDk5Qh/bGkSh5GziZQ89EQjIJj2ZUbG7c3YGZavKPgXC9VeUzQN1iEpEeyRXm8bOF55xdTbkQdVMcfIUO9b9Hf8iXieDRkQicEPWxyMmJZ2Kz+kFVKE1EiZqNoz/hc6zJPhp7OWI0c0yA0x1hIb9zsPSpnd2cWtjPBHz8KxdQc4cF4sAaFRk0KrQgcBYHlA6XICwWvt0MDRtaGTEf/bABD+4a4p0afGZTEDsbRVRzV6Vb+kI7ayAD9rgYLj/xQZuCYXTQJkxR4OwzB8aCzflz2mS/AL555xfFsAvtWwZm0M82ZC/5OfxTE1FUySLdkIJUlqybLzoJL8R0Ng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FMJAAH6qpUVH5z9vhD3IT07qbmyZhhGbHeX2eI9tVSWLE6qnFIRTe3uabWE0?=
 =?us-ascii?Q?qgal8WsMEfvSwvhxbPjyXcgqu39aZ/d8gqlXXH9/ZS41JOglE2QuJVO67Wvl?=
 =?us-ascii?Q?/eeXn6GEGJHB25y2OjsQXd/0XAXJQ4ta1v4Z+6lAuyuTqGVSpgrNLJzL3HrS?=
 =?us-ascii?Q?JRWgYC51ZG3/arbBSgSzLKeOZgOMhT2ocaBfZMhTBy80cpgaDhG+J5v6bUeb?=
 =?us-ascii?Q?3NKfxV7ik19QV+3RXXv1VukB8v2ux4FwM7HGA17wU+36HVLs1C0WiTwFpVWE?=
 =?us-ascii?Q?M8fHJPlcaj++WFd9hOzx8VASSkiPMXL6ETMrWhhAAkQdQ7F7sVxCmnSnk28/?=
 =?us-ascii?Q?Pj5/NLQu20U/RMaAlm+dryU0P8KO5OtUNM9n9abqYUd/BOt3dAup+KGWn6Yf?=
 =?us-ascii?Q?9qGCzcPnNMbz/gLSmJaK+BkCyXOOQD70Bt+SwA0pYHNN3KQG42kiNXFF/n81?=
 =?us-ascii?Q?mI6aOMAz/CMV2pnCtvtiuYfQoh67A4W4NbJlxecap5yDZpp38wJmXlQ7ynaH?=
 =?us-ascii?Q?w09hVkXGIBkrfbw3LWpz9vZxNfLH0fBPw55ziO2aAMuSkhmq6fHrFJu66myK?=
 =?us-ascii?Q?JLXKD/pArxJsW7iQcAXlbcH9qMRXOaF6RGseb0MdhKduxcOA+xyJpTvUuetw?=
 =?us-ascii?Q?I+b4b4RLu213HEDkIhDXPsel6Ypae6GiqVgcJcTSzFUFegza38Ezh9oo3i7g?=
 =?us-ascii?Q?nCsMDz1wO/11i7tGryPWMZxP0azS5AWUBUzNJRoQzZkCZFi2cGsksK9Ru1Jc?=
 =?us-ascii?Q?c9Pkp07oBfvl3CcGB0zR1xkWP6T+zxINj01gqve1T/RzJenny7nUO4Ufj8Bg?=
 =?us-ascii?Q?x8vWmep2/Xztgs338pY2XDFN6w1DR+EOQTkfHa1JWgp/yK+2gNiSrdY/4P7h?=
 =?us-ascii?Q?fqGIdPpdZRUL1C97zuqyHEeIIKCtOxaycYHhSNnyRNt+iuRlFRY9CXOHuVrG?=
 =?us-ascii?Q?XII8pbiHBvnVqx4vKv4NJIa7PfhipSAno3FlRsUiljDb1gRHreiJOEM+WtJ1?=
 =?us-ascii?Q?o8LLj1Z7il1lGLERbeCBa/1fuR3Fl2YNvOL7M07TJvK95Q+e3+j4FCj2Rqzr?=
 =?us-ascii?Q?sRqLVwb3kxY1uD0b/T1cW0oyMaZiGBHuQ0okNTlywRkQuI0nGqtpRhtBi3BW?=
 =?us-ascii?Q?e/cqyOTTCGhck0y/49d6kP9eSQGRA4lJI8mQV6txkPrSCqKViVcjd+IlxQzh?=
 =?us-ascii?Q?WkcZHwvuf2CJWU4hdj45x4f7Jbf8Xlm3WrFCBGy2vdvDfYlamtdPMgGwlIl0?=
 =?us-ascii?Q?58zX1ZLXS3ovO2KYjIxLSkRsydXRk2+QVjhXYIgCw7MooyOfecpsaNpquHlJ?=
 =?us-ascii?Q?rQt/1xo1mgUAwOhS+my8B7H/N19PHPy1Y5FmJLLj3u2zU6GtkhavSfmBX7Wr?=
 =?us-ascii?Q?djLABHN/JraMfAX2rg12MzonN4QJtch0BsSlCL4nr7eq1Angb1D+tuZy1Xt8?=
 =?us-ascii?Q?qnlbYYB6/ZC4TilmCbU1UfWkRYH1bCiT+gTW6PsKPWuFeCNpsE6nZUvjdv4E?=
 =?us-ascii?Q?//aDXQ6unN1tF02nymuc/Zs2vPL4elCofOfROnm77LGFNPlBk+lYYfQUZ8zc?=
 =?us-ascii?Q?PsTan+lROWW+WVD2Qqg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb768e1-5c31-4cc9-6310-08dc3ea66d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 12:59:30.0496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaI2DHtWybSlzWOtB4+KyuNiW2BeXi+lV7fkYxnzb+WYHNF/0eqovDZngtr+i0hf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
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

You'd better implement 'update_attr' callback function to make sure that th=
is node is only exposed when it is valid.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiaojian=
 Du
Sent: Thursday, March 7, 2024 4:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add the sensor value of VCN activity

This will add the sensor value of VCN activity.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 36a5ad8c00c5..8a180592e123 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -150,6 +150,7 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_VCN_POWER_STATE,
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
+	AMDGPU_PP_SENSOR_VCN_LOAD,
 };
=20
 enum amd_pp_task {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 2cd995b0ceba..602dfa37ab64 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1581,6 +1581,30 @@ static ssize_t amdgpu_get_mem_busy_percent(struct de=
vice *dev,
 	return sysfs_emit(buf, "%d\n", value);  }
=20
+/**
+ * DOC: vcn_busy_percent
+ *
+ * The amdgpu driver provides a sysfs API for reading how busy the VCN
+ * is as a percentage.  The file vcn_busy_percent is used for this.
+ * The SMU firmware computes a percentage of load based on the
+ * aggregate activity level in the IP cores.
+ */
+static ssize_t amdgpu_get_vcn_busy_percent(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct drm_device *ddev =3D dev_get_drvdata(dev);
+	struct amdgpu_device *adev =3D drm_to_adev(ddev);
+	unsigned int value;
+	int r;
+
+	r =3D amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VCN_LOAD, &v=
alue);
+	if (r)
+		return r;
+
+	return sysfs_emit(buf, "%d\n", value); }
+
 /**
  * DOC: pcie_bw
  *
@@ -2121,6 +2145,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
 	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEV=
F),
 	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEV=
F),
+	AMDGPU_DEVICE_ATTR_RO(vcn_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEV=
F),
 	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -4365,6 +4390,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file =
*m, struct amdgpu_device *a
 	/* MEM Load */
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_LOAD, (void *)&val=
ue, &size))
 		seq_printf(m, "MEM Load: %u %%\n", value);
+	/* VCN Load */
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCN_LOAD, (void *)&val=
ue, &size))
+		seq_printf(m, "VCN Load: %u %%\n", value);
=20
 	seq_printf(m, "\n");
=20
--
2.34.1

