Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97121CCD186
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 08:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2564D10E109;
	Wed,  8 Oct 2025 08:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tu6aqlZJ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBCB10E109
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 08:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqYmNlrDBITz9VsCbW5kRIm09EPau96ETZnh6JA28cd/YDZjUsjEZJ0eHL7TxR7Yf/PVXJkxqQibPTJCAfzS1utSu0L+JKu9bfYrusBpkbGX39DfIMO9KF3VLbSifKXpdkrxyw8cLHb4HDBSMxiJWWuvcJeGZZBsq1Y89Ks0x2i6hc24m5PFOTxkKtHFfTziG0a9E5x6AJEmyg/JL59KogT64NIObvTR5IOd0Bt7SjTf/BaYsoU8lwCfMAge9HHQibmecSUJ64ifZ6ZmFsBO8oaKlj5ewUuxDIIvpJxJgjyem75QmL/JDkVUzWMukRtdsRlwxkFHWqD9CQidLPF24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7eRKCvwXG1WUMsmxgn3h0KiK2zqbDHridRfItSqP6A=;
 b=Ksr6mEGmV2cu1uTi6QWzB5zihokyRRrpgy7PtqSmYVYeIMDFui0WspTPFyAG+1RnybY/BKltizQzF6TLt2TdY7x83mNouCuwbLvaTOoZasm10Z6PeljD99g2N4Pah38XdbVTVkQqxWfWGGTHQkgs2fq4RUf9BmPyqU+zJWg1i9Ygx5t8Qu5coaMw0dSOFw9MWadtZLIZgzBZxlK1jl3CdrlkypzSCA2cZWoVGvXyax2bg5CfJ1EkgTFt2J0qsSphiQEQVx3VqvJwkqKAt7d7FhTWMtH9tfPWS4PBK9fz6FIjCQl0MX79x/ee0w1bFvUjlblzsPerGrFB1I0YEyDeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7eRKCvwXG1WUMsmxgn3h0KiK2zqbDHridRfItSqP6A=;
 b=Tu6aqlZJNYu2RLeLd/ETaxINIs+S36RwSb4UGhKPdMaXxCiLZulVUCsw/ZlOGEl1su2g76+5/cwusjkWfNIFXny/vAM/bQDiUTWEDB6/UUnRzCcUoTnPm5a5UKortPgrEeY6t/wO/RBxoEwhkw6jb4ZFmQQYtdyJCqO1RhE5GQs=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 8 Oct
 2025 08:10:37 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::28) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 08:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 08:10:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 01:10:34 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Reorganize sysfs ini/fini calls
Date: Wed, 8 Oct 2025 13:40:14 +0530
Message-ID: <20251008081016.3411285-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: b51a02a7-8eec-482e-6e80-08de06422962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oH/PUjXRVfnstEqaUYctV5JCNYMCmsnNJdgQ71sKuXKMtA7bztObuGaSOrtO?=
 =?us-ascii?Q?kPqM99uZN8P9b3yNBnr8boLQyXePEPyttyGCP0VDHxQ7R1SxaCmfbLOH8ebn?=
 =?us-ascii?Q?UAxz1zYOItzK61xpp0s03RoCANAvXqaywELYi+Mw6w94mRQEkOQwcXTYA3cc?=
 =?us-ascii?Q?DGIn2jq7LlNMgL4eDXn5+SNWSrv2y4GvwKO8L8aS2oCU9kfxBHvUEmfROPjl?=
 =?us-ascii?Q?lwf1FMCu4F+R6gmlI1TqAEY9mJTzshFDaBY2cX7U9/EWq/V8S9dgRITTWFHR?=
 =?us-ascii?Q?c944IeK2PgFAHQVlW/9IvWZaw66YIAYpgWprBjEGKkMOZsmzXm5/emQDnLfX?=
 =?us-ascii?Q?p15JgiOcTLQ1+h57sQL5uOjzjGwjX9UML9vpys91DkAXrg91MLeV/ERnOn+L?=
 =?us-ascii?Q?qY3pWfdaB2FzRVlzECrNVilizxsdfs5+NVUXVkMC4TMbtJBwWepUPfC/62fu?=
 =?us-ascii?Q?NcN7g28Yt5mlKhfaUU68OSohHdO3v0sFnwqilYPRW7Zhu4vr1YVcOUrlcNcU?=
 =?us-ascii?Q?UEfuEntsggRsWftC3yTXJeKTzL6fQv/rVHMK8ewf2S1n6K7ekxwI7xkep9PN?=
 =?us-ascii?Q?zMG5dho8BY5w6tzHSAKxTvO9qvmYvIzWJMpO2JGXpEpErLTeLbovkpHGtTce?=
 =?us-ascii?Q?9SU4MfTynwpNUWQ/TEb444gumfdM9RWBajAA8SFKT4tCer9F8mqNF4iyxZJC?=
 =?us-ascii?Q?L4VSIIBx/CTwa2ddtNODUtqVvpCQ3DEL67L4efRTyDDd6kXSLL+lhHdutSmf?=
 =?us-ascii?Q?NG7Pyon37tCLGj5pHQ+bOwAXOdehL16+hKOOMU28zv+uFO73nWNs4lyiTzKw?=
 =?us-ascii?Q?zGux/nr2vIEX6f8AQp/VHfZ1azmQcPm42Pu1VqZEw8gwWatwrie3G7tun5+U?=
 =?us-ascii?Q?G/5N+PCfotbSPNlL/1Tef1rzYZX96QvKqfTma+zAxFZGVx22jpU7ztcwfB29?=
 =?us-ascii?Q?Ja3KrR0dfBw2jSlhDN8bH91/L6sKFWrM9ZZZNGFDfU5V3tRi5npNP+pfunU7?=
 =?us-ascii?Q?xZsdqJ93vDBzOkxrYY7tzB92Rh4VWfIWU0JpgXPH8c/hEYQnaLUV1onrWmHm?=
 =?us-ascii?Q?JTxdLiDyNbZAKBoJ3J84Mizq27nIVjS9WCapqrAyumK51/HkZVbV/2jT0xCQ?=
 =?us-ascii?Q?I0rGB1/NJ2f1r039Bc5iaQvmRndzoSYFfCV2Vx2Hyz9uz8sNLVI0VnfDS8rA?=
 =?us-ascii?Q?4ZmttBuxHRBSUO+H00vuYr2JREfZr82zpn4wIJCxUl1dgUbbmyyZiRL+q5Qt?=
 =?us-ascii?Q?G/T/3MEWADSyKyBvn9s55YNvbD1SsJFjJK1HYFp4kDKHY+JCmcEnHdVN4nTF?=
 =?us-ascii?Q?b0d0SZC5EGAQlWcAVjyFqQYQ5ufZ4GrIVrC/uWymXobqK81wNzBNdZZ3epD1?=
 =?us-ascii?Q?7SNX3X90B213pLZprwQBoA9+uk7Gx6/0ZwVB2YOnI0QtGgb+3jXiZ6/ZCVNm?=
 =?us-ascii?Q?kdtIJAgKHrMmEOOc8WuDuCYQgJEFT3KhQlNs8yqn8dc4h2pHipkUOJ2aVPb5?=
 =?us-ascii?Q?/1Yxbfe7EVE7ZqJr2qKkYSJFJIVO56fQitGmGzVpTcLM/KWAS/Ep8np63d4l?=
 =?us-ascii?Q?HM1X8PztpzLkJ4RfdUQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:10:36.4560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51a02a7-8eec-482e-6e80-08de06422962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A
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

Aggregate sysfs ini/fini calls into separate functions. No functional
change.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 88 +++++++++++++---------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a899fb4de29..7e428e7bffd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4384,6 +4384,55 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 		dev_info(adev->dev, "MCBP is enabled\n");
 }
 
+static int amdgpu_device_sys_interface_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_atombios_sysfs_init(adev);
+	if (r)
+		drm_err(&adev->ddev,
+			"registering atombios sysfs failed (%d).\n", r);
+
+	r = amdgpu_pm_sysfs_init(adev);
+	if (r)
+		dev_err(adev->dev, "registering pm sysfs failed (%d).\n", r);
+
+	r = amdgpu_ucode_sysfs_init(adev);
+	if (r) {
+		adev->ucode_sysfs_en = false;
+		dev_err(adev->dev, "Creating firmware sysfs failed (%d).\n", r);
+	} else
+		adev->ucode_sysfs_en = true;
+
+	r = amdgpu_device_attr_sysfs_init(adev);
+	if (r)
+		dev_err(adev->dev, "Could not create amdgpu device attr\n");
+
+	r = devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
+	if (r)
+		dev_err(adev->dev,
+			"Could not create amdgpu board attributes\n");
+
+	amdgpu_fru_sysfs_init(adev);
+	amdgpu_reg_state_sysfs_init(adev);
+	amdgpu_xcp_sysfs_init(adev);
+
+	return r;
+}
+
+static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
+{
+	if (adev->pm.sysfs_initialized)
+		amdgpu_pm_sysfs_fini(adev);
+	if (adev->ucode_sysfs_en)
+		amdgpu_ucode_sysfs_fini(adev);
+	amdgpu_device_attr_sysfs_fini(adev);
+	amdgpu_fru_sysfs_fini(adev);
+
+	amdgpu_reg_state_sysfs_fini(adev);
+	amdgpu_xcp_sysfs_fini(adev);
+}
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -4812,34 +4861,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * operations performed in `late_init` might affect the sysfs
 	 * interfaces creating.
 	 */
-	r = amdgpu_atombios_sysfs_init(adev);
-	if (r)
-		drm_err(&adev->ddev,
-			"registering atombios sysfs failed (%d).\n", r);
-
-	r = amdgpu_pm_sysfs_init(adev);
-	if (r)
-		dev_err(adev->dev, "registering pm sysfs failed (%d).\n", r);
-
-	r = amdgpu_ucode_sysfs_init(adev);
-	if (r) {
-		adev->ucode_sysfs_en = false;
-		dev_err(adev->dev, "Creating firmware sysfs failed (%d).\n", r);
-	} else
-		adev->ucode_sysfs_en = true;
-
-	r = amdgpu_device_attr_sysfs_init(adev);
-	if (r)
-		dev_err(adev->dev, "Could not create amdgpu device attr\n");
-
-	r = devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
-	if (r)
-		dev_err(adev->dev,
-			"Could not create amdgpu board attributes\n");
-
-	amdgpu_fru_sysfs_init(adev);
-	amdgpu_reg_state_sysfs_init(adev);
-	amdgpu_xcp_sysfs_init(adev);
+	r = amdgpu_device_sys_interface_init(adev);
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
@@ -4961,15 +4983,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	}
 	amdgpu_fence_driver_hw_fini(adev);
 
-	if (adev->pm.sysfs_initialized)
-		amdgpu_pm_sysfs_fini(adev);
-	if (adev->ucode_sysfs_en)
-		amdgpu_ucode_sysfs_fini(adev);
-	amdgpu_device_attr_sysfs_fini(adev);
-	amdgpu_fru_sysfs_fini(adev);
-
-	amdgpu_reg_state_sysfs_fini(adev);
-	amdgpu_xcp_sysfs_fini(adev);
+	amdgpu_device_sys_interface_fini(adev);
 
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
-- 
2.49.0

