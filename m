Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393F0C7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DBA10E5E0;
	Thu, 24 Aug 2023 21:58:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4771D10E5CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDfAWLPWc9M+Cp1tLZQhaUJGYYk1gzE+SqFmAfOEojJbzcT8iwa8fpzFgisxVcE/n7L1Tzk+BPvZza8OPNrZLOGonWzLC1LT6hhmgBTmZREJqqCooje4V4yHshYjrxT9zX5Tvw5wnxr8VtcCQAKCqVgz6vvl3pyXX7iitQQu4VRY7SmF3G5eYhq3lVNfs+GT4Ol+vMUk7f3oap9gADZagVzsb843FvZ3tGEUIvyjvt0uiPYtF4bwwckkyBYG9f+Ktgr17ULxzSIryk1HoYS7tXVSIze1DQQXROld/XkhKCQPQ3EZWW7rxwvPCKlqYCEDCi1adCdC4Fyre9FdxXXagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxU4wm0/cmGyupXJ5vmaa7d4TZ0FD3GuFczVpZhZg7M=;
 b=RGetL8W6Ze3tMsSOV0GRb8f8+IUWr86DaVxvZNkx1P4yz5ievMh9GSrK/yatnEVmkv73rvwE87VLYGgYKF/5kfJvTIzem+hohjxmjL8fUd0T1rxKeMODtAYjJP8WqajL11wK90jswaJFwZ4DydkggsSi/HSPh4qDrKCir2bAvWlatqpENXAJuGlGZxvhpcHK1jedEgsjFoEkqH+lOyTGIlRLKHLvlK0tAF5CwlLGDMLd9lU/hYmoHWaal9PYBynkIajiBNtUPtpyVhAb+jZ8B3pKOhSzLa/IXAbPZcYZ/T/IjccpuCrmco9J+ZxLSgfQp2xJC9fOQO2SPsqmV0Okww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxU4wm0/cmGyupXJ5vmaa7d4TZ0FD3GuFczVpZhZg7M=;
 b=5iC6cnLEL5maMzxD0c5ffO+cqkM+Rdtf/TvnHJu3oKuEn2jKPGSP1A7vU/I9YhPO5p/cH7dCM8OD+CrzMe353bQtN5NB82kEk3B9ggAc6fP47/m6NH60i1+3G521xvRTn6uXvL/LxWgiatI0LfjSPiw8y1Xp9R3SZXZ8xFAkIGE=
Received: from DS0PR17CA0007.namprd17.prod.outlook.com (2603:10b6:8:191::14)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:52 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::96) by DS0PR17CA0007.outlook.office365.com
 (2603:10b6:8:191::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amdgpu: add UMSCH firmware header definition
Date: Thu, 24 Aug 2023 17:58:25 -0400
Message-ID: <20230824215835.2740115-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 4939c4c5-eac2-4d1c-470d-08dba4ed4db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94jqJFbbRWvyVnVsGrWg8DN7EwJmIVg0QSJF4B8I8N2+oRmEWZa2jUX2FyCE76P+hjY9rPHrFUYREz/GqeXLBLsk1Gtu/nvuZ8A/T65UK3xmg+w8M0mvePZaKxM8DgFLxxFBAdGo1olXiV+4VW9XUWzwq3r2FemtE57wA4NqYloEOluIURGmTntXRgVyaw6Ai+eNrcuHkRjEUmWRAKkU/45fMfbYIS/+tsYonNUFEE+w2hf627kFsksdW/e4DuiMg3eVubpralbAoHjYvxNXD8lfX2zsfJuyeJ6KtA2FF5ljo4WssAqJbxilvU6KtVHJOh3xGoqwnnyn29Lzw+/DFbXSedt0gf1xXSSxlIje7dYZQuWVzvvnbyFTjPwutXao5NJdl0iNeFG5YSA3W0nLZtLYbT1IB4ItR/QpoeeA37g9oy7vSXdziyWEsI6ySHUREE54cqMTVrj+UTSmiHJD4M1d43qUgaJCip2Th0TsY1yFuwEiJec1lVe2bevMS6j4CJ+kTxeJH3hwOoMkg1NbIPyoqb2UMAyQVWRJrfaYq8WyX1xkWwBtolKfviNvLwrqPlq2lkgpA5epW6ngkGUnyJAEdtZhgPOYtoRqleCVrJ45t6laiTJh5aOeP3Xjwvuo2gt+PC10sUPU/nLX8ovSCkzxHRxylqDD5EyGfUG+jScGipKgLWvrz16PJKvktQj9+fBiGQTFtQYkAtAQud5DPtqPWq5zkACeL2CDvD/tY3gBjBT/hCgUMrKjcYJ8s65ZHAYD1QOf1T7MXs/0s6Natg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(7696005)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:52.0024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4939c4c5-eac2-4d1c-470d-08dba4ed4db7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add firmware header definition for UMSCH.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4db6d0090893..e153dd3d6b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -328,6 +328,23 @@ struct vpe_firmware_header_v1_0 {
 	uint32_t ctl_jt_size; /* control thread size of jt */
 };
 
+/* version_major=1, version_minor=0 */
+struct umsch_mm_firmware_header_v1_0 {
+	struct common_firmware_header header;
+	uint32_t umsch_mm_ucode_version;
+	uint32_t umsch_mm_ucode_size_bytes;
+	uint32_t umsch_mm_ucode_offset_bytes;
+	uint32_t umsch_mm_ucode_data_version;
+	uint32_t umsch_mm_ucode_data_size_bytes;
+	uint32_t umsch_mm_ucode_data_offset_bytes;
+	uint32_t umsch_mm_irq_start_addr_lo;
+	uint32_t umsch_mm_irq_start_addr_hi;
+	uint32_t umsch_mm_uc_start_addr_lo;
+	uint32_t umsch_mm_uc_start_addr_hi;
+	uint32_t umsch_mm_data_start_addr_lo;
+	uint32_t umsch_mm_data_start_addr_hi;
+};
+
 /* gpu info payload */
 struct gpu_info_firmware_v1_0 {
 	uint32_t gc_num_se;
-- 
2.41.0

