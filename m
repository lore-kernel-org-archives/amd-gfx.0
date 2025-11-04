Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADDCCCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323F910E527;
	Tue,  4 Nov 2025 06:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LZ34E1UJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AD610E524
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8Hbo1l1cokS3E6ikAiSfXPlyLe0wE7bU4wDEUxs9ANDR4XiGiWlCIMggTcP4krn/+NhDKhESFQpR2vWXwLFzo37oYskFVyYhlbLspO9hd8WqJiiDYGTGZ6zdg6ugdu0zCiMlKhCzYcFMXaVO7j/jZ4Uo/VvNiOI/MjYdf477spCsnEiCOY4GfGlRGCp0DrEtkLuu3ZiYNtsjG4nA6bzwGDA3wOi0JBNPC6qZJ0lNq2o1HV/brDCouGAAncIytL/LZiHWz+0JvVXETJJt6izw2HaDdEADZEoyH4dwBQDWhOhiNoHJSSzUVMSKF8NeFHNQK3vLPUw5jdgGilHpL5hYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXdZDFvE+uU/74J9L7sMJolC9f4qUWSGo+HVpw5iIG8=;
 b=hfjCAOpLyQj7F7wgQJ7uTMPAEnEOUeXTuFQRkrbLqyinPjAkf8GY/eMKu7RXYANM1v7NakXZk8EKRbpm8ZYTSy25nztR9cg4U9WY9RwMqAxrVCdB4Ho9ZPbnMWLji43HMy43tRjgp7zPgcvADWfWn0uFpPNtPo2pgHCH2/OIY7pYGPRYCKU83BGaZZR+7Q60H2tvzqPTuadqLDYKWHjGOMibWiCkdcgb1m57YxnSVDVP1zmSoT0R+/BPcpTyvM0vXEJeSdfDU1S7zi10PEX3JEgmhM1urcGj3hCaL1J69swTxD1vc7e19AnBZ5WW/2mAq7PSdG8lilXf4zIqcysD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXdZDFvE+uU/74J9L7sMJolC9f4qUWSGo+HVpw5iIG8=;
 b=LZ34E1UJqpCnCsgDvA7SXxHymXLfXxLTF9OChOzmKqyegtTRXRN1dxNmw5HOuzsuQI4y+q5FkrcIajpM2s6bCr6PfgCmUQH4xId+0SEdfZT+674nWuLz5I6hVVqzuVv2wiz99zbso17eL8Tes7GODN562hC1EXkvlL0vtQB7SEQ=
Received: from MN0P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::6)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:58:21 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::7a) by MN0P222CA0001.outlook.office365.com
 (2603:10b6:208:531::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 06:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:21 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:19 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: add wrapper functions for pmfw eeprom
 interface
Date: Tue, 4 Nov 2025 14:57:40 +0800
Message-ID: <20251104065745.1737050-5-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f376c49-e30f-429d-dded-08de1b6f8a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?333qFjGKzRw+M5Hc4AJ4CnjaBsd6Lp3XVfPo92ifzTpcu8PRH/MvRh04f51z?=
 =?us-ascii?Q?BFe2zELeIqTmh8jdKc5h0aftihLNlV3P6Rp9ViChmKPi9jrcGJZ8nAGknsVp?=
 =?us-ascii?Q?v9hP83eUsD20PDLamy5YH+t2c3QLk+jasoDz7h8Nt9NwuCMPgDpxyChQLbSb?=
 =?us-ascii?Q?d/VrqlB4bnkY+CboFwOs+3JBohlaBoT/MFVTLNRns4jV0n2TYY8BIv77hACq?=
 =?us-ascii?Q?1+ZhM67pKodE58iACh4CnzsqsfAxnfFK+emSZHuZr+VqUfQRl2CaDLJHauFm?=
 =?us-ascii?Q?6pJX4UoVjWq9sgDjRfQGCCb0XAKq/d96yBaGpswmdkkhXqFCyZgTcXArzn/V?=
 =?us-ascii?Q?VC3n6LudoQQKbclDK0BlRZXBvKa+r5WWV0M0ksqvIjWc2VrIW8I7VxEcANz0?=
 =?us-ascii?Q?iTYCYiaVDoFVZSzrfflnP294j30aIOwQcvVV3ZjwFmLHWxjiRtK4imWjcuET?=
 =?us-ascii?Q?O0uNW9YMu0BtRMxfDw/4kdPZqJ7DgfZQNsJz+2L3bSXL2156n34I79f7c9eZ?=
 =?us-ascii?Q?/TLSbxzEYFazlbhnYF0aUfwawkOeT7YxN5ejUAfdBNHzqXJS1DXLk99zOge1?=
 =?us-ascii?Q?L2BNbd/iIAp8tqS0HpsvKb8aldJPDEqhLjCRTWNTMkRf7KSNlbtag+EMZE7O?=
 =?us-ascii?Q?f+U6yBFozKYnYmViuava8KsO4pD3WoT8cnB2f293PVJc5TzIpwttFM2OFZN/?=
 =?us-ascii?Q?OlSf7T1Ek53zZEDDV0p5bm5BteTxvHz5FPjMS/xHmND177TWHv1g0HSWSwjg?=
 =?us-ascii?Q?OsHLEvFZ3bWsHBT6Sca/+c3FonZz1HtuJQpydUVNqqbj/EqkKL7QWqoBETqt?=
 =?us-ascii?Q?OdiFaKiO7gTwDpY6XE/aVV8NHn6R1hlyMcuYPJ4VAYSGynmIXetkzCDB41O2?=
 =?us-ascii?Q?WrbP7bh/KRn90BOBAOM/h6EL4IfnGugPx3PbxiOAFJ8iTyqYN/PQ9jVIG8cl?=
 =?us-ascii?Q?S7djmh/3fhE+gzV/wPj2CBFntyfNZ2Ibock4wBJMIulUaygIxIIeFMi6/FtH?=
 =?us-ascii?Q?CyjlceIG5bXYADp6owXZxSY62/VzzMQmAkFAwzJIt421d5ImF9QB8rjdyEMo?=
 =?us-ascii?Q?+ZSnk9bE42l3dG2nuGWUZk74qKRiodAYNJDEFXos1lHwMqu7GC26PY8U6tm1?=
 =?us-ascii?Q?J/aaPBS3xC4TH3p6jR+rbeOvmrt7qsvYGguI2wG34ejywkc88+gp4ZCwUIpd?=
 =?us-ascii?Q?Z7O7aVt533+z47YjMvOQvX6Y88TvssndqvcjndcWoC18kdZIHdeeCUhMRih+?=
 =?us-ascii?Q?2FlzfAFuBxPGqkYWD+jmFUDsyGFMAKVgOKzPHYLRVJKbdptFw0xAtRl1ZxVF?=
 =?us-ascii?Q?T8k+LQpeIFgHO9fd6VXMpQH3wvWa1Cg3MTjHkoQ4eFfhF3C3b5cdFVr+7iWY?=
 =?us-ascii?Q?aFoubTU+xyHAkHrqOJUDxrqwWNW+QIVpRRpDOAZ5tey37KSF9m2s0pxCQ0in?=
 =?us-ascii?Q?NbIC0hnaktD0EG0P3r5/PwxRXhKluDU6oMWlhfQiqPL2OYu2FrYCEXs7F+sF?=
 =?us-ascii?Q?buNGRVo/+7w4cC+QIEn0jgv/4JR2yntwAd3gLMoyFnFeAy2BQ+Obs/+wu1JW?=
 =?us-ascii?Q?satjbaWgB4T+ZjB/Hts=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:21.2642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f376c49-e30f-429d-dded-08de1b6f8a8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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
index 89d0def82797..258ff0f121a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1609,3 +1609,101 @@ bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
 
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

