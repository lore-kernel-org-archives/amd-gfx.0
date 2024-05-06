Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28798C25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E02112308;
	Mon,  6 May 2024 18:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bX8pxDKp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2620E10F9A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeHYv6CDvfJypaUZLIX1DlOtOGwzebwVtdG2XYsPvhNNTDNb9/taGQZJor0wgazaFBSyAJH8LBXmRUm8VRsoLry6k56tDZwQAuFUeea68ZeQ0eg29q7lN8nVCGRj9ash6B6b1kjw8F6aWPvXcHRGu+kuYMS6nVUH99TVrWjqCM7y8JBzA2Y+pd2jo58xfBC9ey2Pi7lz//wZk0KzdEJ6T1GSXJSlgTUVilg5WcqFX/ZPnR5H9QuK58JhuYuHAQHC8/NxQYd1K1zDYXa/YhTZDaoEBtRFkAOzKh6ZEzXAULdcal3zEZjSnHjWc+Dfl2HW/eewztR0qQ4huBr77wl5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htMLH3IQF1SFLgmXMTgUfeY9eNw7l8kOi/DtqM6JuXg=;
 b=TVGBudw/kD+wVFiIsJwjCZlo9Y4XSft9TVNRVfZkOob8jPWaH+tyrhQ5uV+4qpAq7iIN0pkgJDtPvNe45BmrgczVogdmX+eXQK682Efy6EYcD/3U3nhRI9Nq2wwovyeJ5CW3G09BUNCC5eGaKoIi34KPnXsrNj4WT9eb2A+YPXSRq8Vn1QJsVFK/3dRQmXqiqg0jPty47EGbn23D2QXIPzivbxYf2y8q7hbDr+axgQsP8WsoP3h5yB493MHlokY/h7azBpxCNeZ/HZt+kB/7TCskQITasitTmwIVYXEqu72O1BQ0XDAW/5Hn249tHSb52HA4QecQYXH8StTRo9/rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htMLH3IQF1SFLgmXMTgUfeY9eNw7l8kOi/DtqM6JuXg=;
 b=bX8pxDKpsUcQjOQt75Wlo+HICmijueHPT2/iBmQFgWUB/gq/gy+IE7eM20qXoe7KOLPO7Jouzzq4KJmozd8HFfrEWQzj5rGhU9O4Cmfpa55phR+q6+eDMw9jg7SMUlKYeswHpG85VpvKi2mhCZxvR17EIrRHvsnUDTkqCRoaUwg=
Received: from PH1PEPF0001330C.namprd07.prod.outlook.com (2603:10b6:518:1::1b)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 18:46:00 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF0001330C.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:45:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 05/14] drm/amdgpu: add set_reg_remap callback for NBIO 7.9
Date: Mon, 6 May 2024 14:45:30 -0400
Message-ID: <20240506184539.1669157-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: c391a628-343d-4ac6-4504-08dc6dfcc5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?btiTvruROhnu0dQdy8KW9wiKVtTWwIEi3a3jQsQvHlMJYBf0NU6Cuv7ypeLs?=
 =?us-ascii?Q?BoV0LaGdtjRKHQ7SBECgT4iygWEcdK5kIjKKAhNLizHOMFZ4YrxQ3gR6r9A2?=
 =?us-ascii?Q?VfSJ1esfP5y3N3ZCdBlp/J2ao2Safb47kFp/VOou3HnaBR//rzqfplcWLkIs?=
 =?us-ascii?Q?Wfd/TbqPBGVU5++KXk7ow+Hx0TjNleaB+1O5CsY5zqb7axXJksTFLb7r6vnv?=
 =?us-ascii?Q?Hg0dxygXu1zjQhSIPdPJ9d7L8XRVQa6emM4q+L+NZBdJx9E6CV7O2ey/8iC9?=
 =?us-ascii?Q?6wwYdnlcXiG+HnCqlVCAhxgxk5UivzGbRFufQUIbLvI26DN1wN4douSpXmTx?=
 =?us-ascii?Q?GGxwMfSeurNVVkVFUqBbaF/K280lI4scHzV0k/9MGEcBZMfG7AqOltX3/h0E?=
 =?us-ascii?Q?E71tqlPKl1S2c56fj0fkXV8g29HXDsVDms83UVChKiQeFLQjhYEw9jy3p6Yt?=
 =?us-ascii?Q?6nAw08LuhXs4fH007doCgdtXwTVOIZCLQwN36Uyf56lH/M1N3pMxRsjklYur?=
 =?us-ascii?Q?QPKWV51ookhWZu0awGLLW3M6KgIbbovJ53k8RL5zAxf/7pGrmtHQoaqs6mk+?=
 =?us-ascii?Q?wbT5/0oNsvKtkkJo5xGLN33dFhyl1OyNwD9VDL5ZoAZ2wZmbvOJt5ErtlqPE?=
 =?us-ascii?Q?TPCDYGdHh7fVFQI+Tvlp2b3qTqRXVcMFxjLIT+IDoFoSzbristwcVInChASA?=
 =?us-ascii?Q?ZgVi7YP4E3e5DSvP6DnOBoBdLWkPaRokmePX8yBV/H0gZKTB/XnAqtdbTPPu?=
 =?us-ascii?Q?sfIizy3StSSMFjPd7/i+sEaUwhwGD9EWKO3+mQXMNnzroXhumjvI1CSeYGGI?=
 =?us-ascii?Q?8rHInIWTZON3e/Pf9fJxbZKpjc9lZhef0cQ87g7zx695VEhtj65NhT//V3na?=
 =?us-ascii?Q?Ugp+o0A1qvzGrM4Dqc3ORW3wY5rcNfzvMymhtH2kEviLnntagedTq/nj+nd3?=
 =?us-ascii?Q?/7nxJV36PDQCJFMlojAk7Vs43SXVeh2o2xA1TASQ/KBvKpMmP2D9qpA/PybQ?=
 =?us-ascii?Q?almlJT1P6RANEFyimmPOBmbKpnBb9YB469CdXK/uJNh74WaFq3n4HcTo2Zwm?=
 =?us-ascii?Q?LECnpmbecyAFLVK0zR3NKUKbL8yDBYJCVVKvo9W9/T0Q/ZJVq2D74BBPvZ4P?=
 =?us-ascii?Q?iczCeJxv1O/riHS65zprYTx/oxED0yYrWs6ynXU7dIU63LsCyM3pA7HjxXLK?=
 =?us-ascii?Q?19cgQoKhY2HSo6590iQ1o/Tw1SP71VLgdHMpIIn/LeoYdseD4oVuAV59Rixe?=
 =?us-ascii?Q?eHbvCumSOs1w0LTbArfOsHDFg7KlRsJB5WUa8pNpUNK4P8p+ASAzUgfEIhau?=
 =?us-ascii?Q?iiU5Mff4rweH4Dd1naFChAitx4QOC+0HUKla2LCNcQhHZklvKKQnZqnt49lw?=
 =?us-ascii?Q?h7kEQvsJI2uWj6lXmYvoaoI72jZB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:45:59.8481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c391a628-343d-4ac6-4504-08dc6dfcc5ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

This will be used to consolidate the register remap offset
configuration and fix  HDP flushes on systems non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 40d1e209eab7a..c2e78294c4fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -475,6 +475,23 @@ static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+#define MMIO_REG_HOLE_OFFSET 0x1A000
+
+static void nbio_v7_9_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(
+				NBIO, 0,
+				regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
+			<< 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_9_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
@@ -499,6 +516,7 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.init_registers = nbio_v7_9_init_registers,
 	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
+	.set_reg_remap = nbio_v7_9_set_reg_remap,
 };
 
 static void nbio_v7_9_query_ras_error_count(struct amdgpu_device *adev,
-- 
2.44.0

