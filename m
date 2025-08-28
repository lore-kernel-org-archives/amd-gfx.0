Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6DEC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93DA10EA40;
	Thu, 28 Aug 2025 15:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6XElXmR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BC610EA40
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Deqr6NzJUJ4AzkPpvA6y0rvdrJ+i3eRyT/KgZFCpUOWySf77p5nAlSoQz5/MS6R6w/aogpf0wkiC3xSD6XA4JBU+X8OSYxZevnjffSR89woQjDIGTl7uNjvzd7f7SmHpwOP8ck0gj3A14+0HGels2vr2aca/BqcPXSaAa9WW8gB1NcpepozFcOzF1Zhc96RQohha7BBs/R2Mw5bgM+aKnc/5IpVxUl7mGCh7gawxHP5io0H7WhHmLfhLJdlf9HXTJR7vpoluQK57Lsvht/nwp/YCa1leRqviNLkaKiJDnXK2imKrUmgVRcCWNW9Ntzi5dFHXCUeSfL5/s4XkcWZjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN2M0gHrQXESoC+EtP4N5zf71wA7cEX+PupZ7tBsCE8=;
 b=y2VRNKXEQymmIKj2hBNii9313JxL4sQCfZha8ridRBh3q5l/uVFMbU7SqudtRcioS/oVC8eOF5qnxZ+j3a5/1CVapSD/X6QKKLSFs2fkXG8X8KxuiNcpaOAcFjzZA+AHbztManMhGDLvUyDpRvn6s25kDd5SholpMFChN33KShvZy4Pc/cLYp0gdJ+O2c5RevJ9EX3XEASH7gt3qN+2W0hUfjdjB2s8LajJyZgbrUIn/VCmXWmUXFu6kdFt8fGq3Lxzp3W2DIMO8VVyCmN1NZv6PfLpzbLBh2WlmvGv//92hf90RiLJ07IiK/N5g1kaa6+9NHLrTmxlevm8JudoI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN2M0gHrQXESoC+EtP4N5zf71wA7cEX+PupZ7tBsCE8=;
 b=J6XElXmRRrOsVLckkPxKN5wkKG4QDVXb2nXlSor59Waqnfze70Ji8Rg8RUv1mn1qlhJQNgEaBakpu1rSe/jr925XRWHEiPYWBLYli61rZcyaYXquuDgJ/4Nvia35It1MGI2XfXhXz8pBvDG4ULNXI0jra49PfXz4l4cdL/dlZYE=
Received: from BN9PR03CA0591.namprd03.prod.outlook.com (2603:10b6:408:10d::26)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 15:48:48 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::4f) by BN9PR03CA0591.outlook.office365.com
 (2603:10b6:408:10d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 15:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 15:48:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 10:48:47 -0500
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 08:48:45 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add vbios build number interface
Date: Thu, 28 Aug 2025 21:18:28 +0530
Message-ID: <20250828154828.2263644-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 098cf0ae-aeef-4873-d950-08dde64a60c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJ4TnEupU7SfFV1gIGnUncpXpFx+l1X05Y+6qFwCSl6/1xTg7ZeMiQL1/yqE?=
 =?us-ascii?Q?QTJ5mUXREe5UTBKEf3s2xh8TTNcKx99djNIL02cn8DMBgG2G6dK1YNKOFaUd?=
 =?us-ascii?Q?LVKm1WPiM+QFJjcYBbPCcz1S7T39f/fAoK6hdeFP2bUBALPUJDk/k+lOgggw?=
 =?us-ascii?Q?IM88z2WgvQ6cwhr1sCyNda4nt34unrmRffyTPsGvpXTPonQB3ks35aUkDKA5?=
 =?us-ascii?Q?MdRMeRza/GFwUHxHogUHPv2ccX2zX2pjz6cpI/iRAbq9OPSkoyWOjo3Ejvwa?=
 =?us-ascii?Q?KbqMsVi2LwPpmzUWUJERWd5xtUgJBiWxC0v3SV/d3+wirr/KTbs1ZKOLWygy?=
 =?us-ascii?Q?8IPdtOClwrI+zEGaNIEuFXIBDv9FU6Lyi2nYYfVU9z61Qxr8wpnFWaU6H0NP?=
 =?us-ascii?Q?EH1IagkdWtiP20/HcVlC6ZumMe7/hN8qtXhl6ACXrB68EBgjDWt0zz7YUkab?=
 =?us-ascii?Q?Wm7gsKrqn8/LrncWpPTK9Ss2wLURym8EAr4Coeyi+NUJb1/HiQaq5PVA2tvi?=
 =?us-ascii?Q?y6Q0Xa2XSzU11kfTec1+R6MWj+A3PX2QYCFD1Z2f5T+5DLqVUK5q7/rkfYU/?=
 =?us-ascii?Q?0zoFktWvwk2si7qADK+JMM8yr3ETvovtDXvV1NDIkEbHVSIcopKZCE9zu/2R?=
 =?us-ascii?Q?V/F8QpjvHLT95SwNY1ZWMvx97MbhCP5iCfiZvVERP58M1fSVl2DS/00MM3GO?=
 =?us-ascii?Q?Z88+uEG2b0wO50EfG3kqql6MoABuMN4pXpJqJWN3JvNxoM11k7HV3i4YTchO?=
 =?us-ascii?Q?8Kr1zLf4S5keIuHQMaN0fk1nUnami4jFSEzOykWdBSzMiwNKr2W2413Mdq1p?=
 =?us-ascii?Q?3seNE6/SclsMLynCwj2ATY2A8rSyI8z2TPA4W++UdbbBLayoCstR7+bJSqIV?=
 =?us-ascii?Q?Qfti5DDUKaSCkARwljojhlbYUaLPF1CvlhiR2r3C4ZQfUmxdHHR9z7JjWD+w?=
 =?us-ascii?Q?YqyA4A8RBhp7U0Fu7hunbub8sOKjsZgZ9bnffEiNEN9lcShiz7h5SjM1OEmf?=
 =?us-ascii?Q?nnf1eKhVaj7kyiSWtGHi2KlifmE2g0DCejqIwi7Ul9ZgQ6sPApy8A2+mWHS/?=
 =?us-ascii?Q?MFagPkN1c0LbvRDwbW0n/PUruHdlCLFQxO60/bq/W9++M9t2vagr41cZHpZr?=
 =?us-ascii?Q?Sw8+W2Ld7DahpZ0rfnaD5OAgozHWzhPzu2WM18A1wKAD2FmTUAD8lxlzwCfu?=
 =?us-ascii?Q?zZZxzCuzaxrjr4YT1KQHPNEP9EWCV1BsAEQlSyhTnC8rdpUIGExJpGrlzIQz?=
 =?us-ascii?Q?VTyuF8nSHHJuhpX6Ma02Sj/ZmwZ/zPlKXEDO3TB+35nc84QaOArimCPujEAz?=
 =?us-ascii?Q?4c/Q81gXYkmVLMhC0eDN+fWrcQ95nHcs/Hq05zd1v00jJqPQoy55ORSeDqBM?=
 =?us-ascii?Q?MtLx5Hlcq7DUDazmVrVvXW2uASrSoYeSG3AIfhvKEyrR/6zPS0oyUkR1fchp?=
 =?us-ascii?Q?KETFeonqRGU7VC7AApGgDCR5O3aZMSdy/10yA8zGlbelzAc0juJC64dOXbHf?=
 =?us-ascii?Q?Fyset1snsd58NqBbjIVZtCtic5rgml9msEip?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:48:48.1846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098cf0ae-aeef-4873-d950-08dde64a60c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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

Fetch VBIOS build number from atom rom image. Add a sysfs interface to
read the build number.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 33 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/atom.c            | 22 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/atom.h            |  2 ++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index e476e45b996a..9dfdc08cc887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1816,16 +1816,43 @@ static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
 	return sysfs_emit(buf, "%s\n", ctx->vbios_pn);
 }
 
+static ssize_t amdgpu_atombios_get_vbios_build(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct atom_context *ctx = adev->mode_info.atom_context;
+
+	return sysfs_emit(buf, "%s\n", ctx->build_num);
+}
+
 static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
 		   NULL);
+static DEVICE_ATTR(vbios_build, 0444, amdgpu_atombios_get_vbios_build, NULL);
 
 static struct attribute *amdgpu_vbios_version_attrs[] = {
-	&dev_attr_vbios_version.attr,
-	NULL
+	&dev_attr_vbios_version.attr, &dev_attr_vbios_build.attr, NULL
 };
 
+static umode_t amdgpu_vbios_version_attrs_is_visible(struct kobject *kobj,
+						     struct attribute *attr,
+						     int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct atom_context *ctx = adev->mode_info.atom_context;
+
+	if (attr == &dev_attr_vbios_build.attr && !strlen(ctx->build_num))
+		return 0;
+
+	return attr->mode;
+}
+
 const struct attribute_group amdgpu_vbios_version_attr_group = {
-	.attrs = amdgpu_vbios_version_attrs
+	.attrs = amdgpu_vbios_version_attrs,
+	.is_visible = amdgpu_vbios_version_attrs_is_visible,
 };
 
 int amdgpu_atombios_sysfs_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 427b073de2fc..1c994d0cc50b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1494,6 +1494,27 @@ static void atom_get_vbios_version(struct atom_context *ctx)
 	}
 }
 
+static void atom_get_vbios_build(struct atom_context *ctx)
+{
+	unsigned char *atom_rom_hdr;
+	unsigned char *str;
+	uint16_t base;
+
+	base = CU16(ATOM_ROM_TABLE_PTR);
+	atom_rom_hdr = CSTR(base);
+
+	str = CSTR(CU16(base + ATOM_ROM_CFG_PTR));
+	/* Skip config string */
+	while (str < atom_rom_hdr && *str++)
+		;
+	/* Skip change list string */
+	while (str < atom_rom_hdr && *str++)
+		;
+
+	if ((str + STRLEN_NORMAL) < atom_rom_hdr)
+		strscpy(ctx->build_num, str, STRLEN_NORMAL);
+}
+
 struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 {
 	int base;
@@ -1554,6 +1575,7 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	atom_get_vbios_pn(ctx);
 	atom_get_vbios_date(ctx);
 	atom_get_vbios_version(ctx);
+	atom_get_vbios_build(ctx);
 
 	return ctx;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index b807f6639a4c..825ff28731f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -37,6 +37,7 @@ struct drm_device;
 #define ATOM_ROM_MAGIC		"ATOM"
 #define ATOM_ROM_MAGIC_PTR	4
 
+#define ATOM_ROM_CFG_PTR 0xC
 #define ATOM_ROM_MSG_PTR	0x10
 #define ATOM_ROM_CMD_PTR	0x1E
 #define ATOM_ROM_DATA_PTR	0x20
@@ -151,6 +152,7 @@ struct atom_context {
 	uint32_t version;
 	uint8_t vbios_ver_str[STRLEN_NORMAL];
 	uint8_t date[STRLEN_NORMAL];
+	uint8_t build_num[STRLEN_NORMAL];
 };
 
 extern int amdgpu_atom_debug;
-- 
2.49.0

