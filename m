Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15CAC4829D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0D6112CA7;
	Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="urvFuE3B";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC9A112717
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZhIncy7ZBWoov6QunjuSOWTaHp6yZnhXXfDsFPZdbOj3oyEbLZG90Lg7xFPjdqMSB/hHqlGHdROjh3rorJRAtbm149aNmIDz0O9Bssejv6p6sxuyEHBoP+PE4b7HG4q70/U4+cz/4rBVOC+QrRyQRo4dVblkUK09li36hS99+vFHN5D+Z1L0DFsFEBKQMCg9012sYZmkKFx4G+6gH8RKBe1YZJNfIAaVCX2h7nWsH6AOr/vxz1L3Ij7DdW/YNU9ein9Az6k3wQI+rKZ64nW2fA0eAxeZS3ahxx55xSr3T1Fux2dJJAYEzNDhcEHa0uXFHcTKfZU5GYT/RowC8l68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7Kfcp+Ryfi+EnI3yswkSvihGx2kCW+P2vTKcmvVkLk=;
 b=Osj+N7fMzCPghvg+WoaAQYLJzCST5ujOxzo8XbQiKn5W4OAGgx6sBlgk/YaYVujp42jNdnRXcV1iZoNWyq4sgry92ZNyTGpD+YrjA7oL8bmph8QEGzLuMOC0Uy7sfb1PbnKHxX4saGZ6aJJX5Bj3QxXlRxyz99N3ad2qkSXDWVwIa4Tx79SSy2feifjPfIrJFsUwjmWC+rVn2Dlmyd3qxM2nkAuCm7KPk3hCvaNSlTJO/5xfDuIuWq0Qv6y+xOvHaMgX2y5963ZKZDifZu1dYlyEyIthgXHdhtlY4JB9W4Yu5a87xlO80phmuwufSfYFI3et6yOxlWmauQUbmrPgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7Kfcp+Ryfi+EnI3yswkSvihGx2kCW+P2vTKcmvVkLk=;
 b=urvFuE3BoBo9uMoh5jStvQTnaEhjPx+iU4LtyeKC6EnW7VjNRUAXAdl/P/HR5cf4HuaRfNO4UAz3mW1lT6HJZ39XKgDciDrTvIz2MGiJCqUX9b5mIb0TvVOwqBlDsfnug4nz5iWl3/Ls+F4HNgqEJchoxvuPr/+X6aqAqbuZ5bc=
Received: from SJ0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:a03:39f::24)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 15:59:44 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e1) by SJ0PR03CA0229.outlook.office365.com
 (2603:10b6:a03:39f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:39 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 17/24] drm/amdkfd: add setting trap pc sampling flag
Date: Tue, 6 Feb 2024 10:59:13 -0500
Message-ID: <20240206155920.3171418-18-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: b8822d3b-3efb-4e1b-437e-08dc272ca283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG1lSE9eoNYT27qFVhmwqzdL+X56NlTBb2FHXAQIIYSJnOxlZgOO7SGi2CqYykc6UN8mZo5WhDM/c7Sf9RIEZut+EfK9qdali/tU+vNVt66D2cOenPto4mTcdq2stf63lS+FJXf9GUaLRoCnHzpstsq8i6l722CtC/AUgj00v2MTq1HCyUHbaOrn1pJm82abjAD/C1lZz0Z8TZoDHupinihj6Tqvh2YbV+fcw2H+XOE6INu6tz1CdEWng4drEzRNVFSHRaRenpVNl1aiV3K6Y52/S2nN2Cs7rhvdWEWkhSHDSNYUtRkrsHTxvSPQRhhNy+HPVQOtx2BY8IEr2eD7ybtZICn47PJD7GrzUH6YsgptFEdpDtRhqSJeDqNTKhSFf2Bnt0oq1gms84BDSjBhS2Vb72CXivlY6PqWpb1QEnXb7s4ec7iamC+/mdBZRRyiGk7zzviy5OLe/KZzQs6o6Csp6mvnqNo7fUFOXK3iMnmZxhVq8tzjTp1ybF5zHhuXNUoPhPaxqKu4qmzploBLYhG3G2XamtE+dG2IwqUVI+u4X3t3Ri7b+mz6KrExhiL0eUslPP4ZtoIHl1328ZAzbrYsZ9ui14XwTLbxM9/Sf8GNrFfhbsfFKXPBs1got68HiosNKbBpNtJTrhNYCn/PtXf8Mqo67e8NtsZlyxYiw7t0hpHZNzdWMoJwItl4INRTSU3z6HJrcECe2B6GAft8wwHZCp9gBrfwk/YzgXdQpQimo5skYVFEhJi4TaqXVKhh6E/41OSMCGlgIzEK24+Duw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(7696005)(16526019)(6666004)(26005)(1076003)(4326008)(8676002)(86362001)(5660300002)(70206006)(47076005)(426003)(2906002)(478600001)(70586007)(316002)(6916009)(356005)(54906003)(336012)(82740400003)(81166007)(2616005)(36860700001)(36756003)(8936002)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:43.7073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8822d3b-3efb-4e1b-437e-08dc272ca283
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

Add setting trap pc sampling flag.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2df240518d1f..5a7805147da0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1198,6 +1198,8 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tma_addr);
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled);
+void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qpd,
+				     enum kfd_ioctl_pc_sample_method method, bool enabled);
 
 /* CWSR initialization */
 int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 3e3cead6ccf8..4a450abf9fa9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1463,6 +1463,19 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 	}
 }
 
+void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qpd,
+				     enum kfd_ioctl_pc_sample_method method, bool enabled)
+{
+	if (qpd->cwsr_kaddr) {
+		volatile unsigned long *tma =
+			(volatile unsigned long *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		if (enabled)
+			set_bit(method, &tma[2]);
+		else
+			clear_bit(method, &tma[2]);
+	}
+}
+
 /*
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
-- 
2.25.1

