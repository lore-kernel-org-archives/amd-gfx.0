Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82B9CCF9F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698F310E760;
	Wed, 29 Oct 2025 08:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Ho1g30O";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B7D10E75F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE45/zQzr/xRY+DI1+Wk7XNivGCgrwmnLVf7uO5n17IqMHm08BZOyrgeafo0laiMzSzfz4EuTAdOakqc/CAR46Ybcb0FXs69p9CiF8dw0pNI18TaYVOCRkwKVbZPn8MO2vQXr+GZ4BaWxmuW+VtM5yClN1purmwf4TkXS8ZoXRr/VPPOa+LK8lIgzb1b1miyHdC2ITUzod/JG2DvN2e5B+g+z49hCXT+fDns+V8mOSQdVUaP8GjMRWD8klza9x7hiOXTNhTBgmU1IqSIcW01IoAOrMSEmPJSLbCmrgIcLnRPGinPfHJmGFeSnRL23ctjFlTW5mHE58/tz6CzeAm40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgxnC6RbmpnHdjC2VniT2oKhflNBlNEWV7WPbuf4u2o=;
 b=mQOZR+DZxbFN9DzOcpaYbAU/Q3kiTr6jfZQccVxZjtcbfYujL+/C0Hqk3NVptNCGneUkNRGY42d3CvqdblCZyNQFRyRhjOdOMqEGfoMZ09VTG+tCqbrm5wN8j33SxAyg+y/6AdriFmMILyOsJbZ5Fc4MFPKu72bt5B4tR3OoN6YGVmcx78QRXbcgnZdgsJg1S+Aijhgkz9vikfl5npxAZ/nkJSVQ/Bd1xjUTzGqAFwyxXkcH7HwKE04mUUaVYxBSG/gAVBC8xrATQgtkwECCq32wKyvJD+NDTNevnKuGVXRjbL/JPgymhK6YGh2dSQAP+wZGeKH3YOBnbIOoTVT9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgxnC6RbmpnHdjC2VniT2oKhflNBlNEWV7WPbuf4u2o=;
 b=2Ho1g30OJ/wJMtKmMVZHxrY2EFc1lL8IR03nRvNi21SbuaM8/4RDKD5vYDZ99k/DRCenSk90jcrtUcYE+oVoKfczvaih9gyBokslb332kO86ApoznNJk+CrJctKZxNXgaSMM1vzCKe8lej+cxAwltQNNK+3rEIu+spNT/UQbQ68=
Received: from BN9PR03CA0747.namprd03.prod.outlook.com (2603:10b6:408:110::32)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 08:48:19 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::f7) by BN9PR03CA0747.outlook.office365.com
 (2603:10b6:408:110::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:19 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:17 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: add wrapper functions for pmfw eeprom
 interface
Date: Wed, 29 Oct 2025 16:47:47 +0800
Message-ID: <20251029084751.1701305-6-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029084751.1701305-1-ganglxie@amd.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 287f3573-96e6-44c0-e65c-08de16c7e8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?me3yCH/jXihVsQLRRIacVmVzOGS/jUBh8oYeVretxp3cEqc1q0aZkM633U6l?=
 =?us-ascii?Q?CycjlamFcvi67pAikb97gyr4tsjwerLTgrP/NOH+kVvcDBDTh4qSGzCk0SJw?=
 =?us-ascii?Q?xcOT1id8TBCjFeNxZtL82oj2X1SDeOnfQKAU7eBx48ZuCoyWnvmoC9y6fJUC?=
 =?us-ascii?Q?gY/Q2UcTjhwNLr8SiUmvOP5arKmgxAO/W4z3ApUllLTP8if5kPCEjlkny4c/?=
 =?us-ascii?Q?iWuxvwSHzoWmonM/OsWR9glyKgTon/prpvS3T6EcHGd0710Xqz7RvoKF4D66?=
 =?us-ascii?Q?LQaSd5+mn9RYdAUwTsL00mbOPSXtsHq8Z0BC9jkqkS6zXuJU10GL13ygx1ti?=
 =?us-ascii?Q?324gvyiOSSrYxx89XhvbL1Sx5whY3d87fmcUFbzNP5JUgZnE/x2gxLiTzvCP?=
 =?us-ascii?Q?jtVTOmEEp/W2V5mMSPwa9knCB5NJixN+0qyNLKnDo5TDNeTmdSM1R3iHSJN8?=
 =?us-ascii?Q?8KF+lZGoiDgLzNzfKdo8fXMLw8F0t2Y2jTAcdb+s5j5Cb5t8o2KTLYRZYcQd?=
 =?us-ascii?Q?4lB67m1EeKhL9hZMEUOuvVk+XHZTk6WUEXir2FakUhMwpIJqxGFvlvSsd164?=
 =?us-ascii?Q?5i+OWgU8xd2gBloHI/7vUCm2akQebYZOJNs+D/0FjshRZIuLG8cRGfRd4zbi?=
 =?us-ascii?Q?JGBzrUPXc7PnmIGeWCo0UWXja2g2K8Cr66SJZi1IFGugazy70vInBSTrKVVH?=
 =?us-ascii?Q?kZw2NKdDDjWsh1wHca+9OP7zM4s2ftER30dSHNkIa449dIiUfgg9HPj0h0yZ?=
 =?us-ascii?Q?3kYKOVjmtRO8zkbBvNzUJiEAnyYCvj5J+2sQhMFqQfxszEO+MfhK6SKNI+Ux?=
 =?us-ascii?Q?5BZudN49bsRwNGvVlgYLszfzx7BuPAmG6Up5kfbFNM2tTRbd2fga8jLt3YDi?=
 =?us-ascii?Q?K7U5S0PT0zkifugPtJUYBIvJeFex4FtKkwsm8YST9SNZRKdUy+Qs62TZQm+o?=
 =?us-ascii?Q?/UuoB8p4ykN/Jr/yn7YOHz2OEujCcPNI4ru4XQUt4BhX2dG7M7UhwR20tJFC?=
 =?us-ascii?Q?+1b4wv2kUfZMvMLU/twtssxJaCWSmQvvPlyxB9nj2XeNA33P6g5z0czgLySq?=
 =?us-ascii?Q?D98gI+a9FlxMwrao3hFWrVQ637MP40Voh9LwueaZ/q2Un8AVeb5Vsmxp0YJ7?=
 =?us-ascii?Q?UYwUwls3NHchIeiT39VjjGwBnEdajPfpig1DvliDtmckrJ/NE1tRgu5CthFV?=
 =?us-ascii?Q?f/Kh14OxQJ/OHSbzVr8OesSSOfpgoX5LbzNCQ5GPJImP+tSuEtFhL/FXsjch?=
 =?us-ascii?Q?Twtvfq6svwbf5ssUSkZva8P0GGogqzYWQhqQF/U8t++ijL+20+L5B/fAHRrd?=
 =?us-ascii?Q?HAA43mXPRhuGAcyfHigbUO3kik9uGYljFSHmyC4w7cqBp38lzjJJUpCQOjAz?=
 =?us-ascii?Q?5b1BiCoYGPzfKJlMbn6b1njE9qAZdkSEfTdhUNBrJCfMi8WP90/QFvPYhwbO?=
 =?us-ascii?Q?AIPVzA6NL/ziTmUkfobqonirfCjYHJGSj8EF/Lh9PpwytMOoQj9Q/Fz+vYFS?=
 =?us-ascii?Q?AWQEuksiN3zE6Q9HkjRys7Ka2YqzG3XaKTsoK88Tux4pkcZpWD1sqXC6u+ej?=
 =?us-ascii?Q?JpbYHQB/OEsFbI75RZI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:19.3472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 287f3573-96e6-44c0-e65c-08de16c7e8d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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

add wrapper functions for pmfw eeprom interface, for these interfaces
to be easily and safely called

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 98 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    | 21 ++++
 2 files changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c38d88a60c41..8533f1b6ebe5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1608,3 +1608,101 @@ bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
 
 	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
 }
+
+int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
+				     uint32_t *table_version)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_ras_table_version)
+		return smu_ras_drv->smu_eeprom_funcs->get_ras_table_version(adev,
+										 table_version);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
+				     uint32_t *count, uint32_t timeout)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_count)
+		return smu_ras_drv->smu_eeprom_funcs->get_badpage_count(adev,
+									     count, timeout);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
+					uint16_t index, uint64_t *mca_addr)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr)
+		return smu_ras_drv->smu_eeprom_funcs->get_badpage_mca_addr(adev,
+										index, mca_addr);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
+				 uint64_t timestamp)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->set_timestamp)
+		return smu_ras_drv->smu_eeprom_funcs->set_timestamp(adev,
+									 timestamp);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
+				 uint16_t index, uint64_t *timestamp)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_timestamp)
+		return smu_ras_drv->smu_eeprom_funcs->get_timestamp(adev,
+									 index, timestamp);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
+				    uint16_t index, uint64_t *ipid)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid)
+		return smu_ras_drv->smu_eeprom_funcs->get_badpage_ipid(adev,
+									    index, ipid);
+	return -EOPNOTSUPP;
+}
+
+int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
+				   uint32_t *result)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return -EOPNOTSUPP;
+
+	if (smu_ras_drv->smu_eeprom_funcs->erase_ras_table)
+		return smu_ras_drv->smu_eeprom_funcs->erase_ras_table(adev,
+									   result);
+	return -EOPNOTSUPP;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index feff46b22b6f..cfbd402ddea2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -165,6 +165,27 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
 bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
 
+int amdgpu_ras_smu_get_table_version(struct amdgpu_device *adev,
+							uint32_t *table_version);
+
+int amdgpu_ras_smu_get_badpage_count(struct amdgpu_device *adev,
+								uint32_t *count, uint32_t timeout);
+
+int amdgpu_ras_smu_get_badpage_mca_addr(struct amdgpu_device *adev,
+								uint16_t index, uint64_t *mca_addr);
+
+int amdgpu_ras_smu_set_timestamp(struct amdgpu_device *adev,
+										uint64_t timestamp);
+
+int amdgpu_ras_smu_get_timestamp(struct amdgpu_device *adev,
+							uint16_t index, uint64_t *timestamp);
+
+int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
+								uint16_t index, uint64_t *ipid);
+
+int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
+									uint32_t *result);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

