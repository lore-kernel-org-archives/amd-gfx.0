Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C4FC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A7110EAF8;
	Thu, 20 Jun 2024 16:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u0OAcOo+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A388410EAF8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+KnBk0bC5v6AZBAVjgYHLqL40ld6NVRhgub/cEUteowggYsS9+6ZiIA2OUFeioS3AuAxoadB5YxRG/aljkn1yadeyRsqZt28kyqd8uxYdYBkNuruooI2JdsEHkAe//Ass0U/5Mg6//REEW5JTc7yaWTGtGeFvRwSBDg01XPeIofRcErqyLGiOQBS248AMtLSUUGf6wcRqQiYEQfrnSBoKfzOVnjyQV4/kQCONBfVEebBcrKyD83vVk3bM0CcQN4txCG5oObHHD1NtbndM0aL2Ey1Ds8I7jk7CA/F7XRkesfJ04yw/3SnRCePipAfwE11yWlt6FGDSYtsxBaRH2cVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJEJ8iIOnA3k7Zg+9aVCldEtu6pGhadPn0SfMGwCBTk=;
 b=bAxyuJOiEIxInQrkMRkotf12DEISGzvSuRYxxC1iqvUBKN+tESbhzVfNQQoKit5xw3pYYhjqxIgitjQ7wZXYXie5jOVgXXU6AhJmh5Sn1b/fPFN+xIV9XQPrChpzlWXblfaPHfWgQJn5/znGaTkRV3wf+J/MY7Ee288coZmsCzDf29NHzmyCNSGUtQ8IuYiOzCTBWeluRFjDwngdtm/hjqgOTWoL6rtJhI7GUZbJGZTtZNVp2igu7rIMNvi7X37t9NfJGHdQj8tpAW66pHonMrVUuRs0Qqlv7VFkpz03CWol11XiUSUw/AJ14+wJ8mY2MuY9LWR1Sr3sENJI/DPG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJEJ8iIOnA3k7Zg+9aVCldEtu6pGhadPn0SfMGwCBTk=;
 b=u0OAcOo+aX3h7ZktDn+9EYdzU7dv/PvNsUpmk0rZ2dmWjwi8kocTWmhV6kuENQmWR0tmp8J5dpNX5oPHL2o00GvNkaUXYYLTi4qMby0ttBHu1bZt0F1QvaRYMXfabbZRmhDONCpVmR2qoxQ+ezZpPJT1RRJ+rCJKTAacUrRwGh0=
Received: from PH7PR10CA0003.namprd10.prod.outlook.com (2603:10b6:510:23d::24)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:15:13 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::31) by PH7PR10CA0003.outlook.office365.com
 (2603:10b6:510:23d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:15:13 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:15:09 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 13/39] drm/amd/display: Check and log for function error codes
Date: Thu, 20 Jun 2024 10:11:19 -0600
Message-ID: <20240620161145.2489774-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea2fcd0-5240-455d-815a-08dc91442a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YfOMF9XsI+LYQD6iYsTzwghRh0KAHWflSjLzEkMb/JzxeN/iji8xu3AOEFYZ?=
 =?us-ascii?Q?ryxfK4YpNxKbjPZVfdRbv8mfGR7VHjd7X5uSd4TsXirjv0NwWBiUZVPa+6E5?=
 =?us-ascii?Q?W/7gf/giMM+Akt4Bm33PfvlVVS53NHHl7deposic7qU9qUTxV2u6QGc4P4RL?=
 =?us-ascii?Q?fSd0RnNRwuPIWr+O0ETfbibjtKox9ySXUaoMFXcv50b7pkBQC3r6VMLrvtrs?=
 =?us-ascii?Q?BrDKqmmJz/eEWAwtwSZ7M8hgVK/x0pOOH8frdhwgqNK5mOjC3r3e3Vx22FFO?=
 =?us-ascii?Q?jvkLooaL95CCfvduFWHL++fIAwoKWvTH0tB1t3FLkA2io1wiAoSrK5cVQCbg?=
 =?us-ascii?Q?FhpTF+Jw0H8QFZjTt0j7Tm+0+9mqLKWfOQsX7NRVQuB5AT8MpKDMPSPvW8F+?=
 =?us-ascii?Q?HYhkSaVK2DvGkJQBY2kPoPt/SGOvcve3T/fS+x7891TLLsZZk96oX0EirwA9?=
 =?us-ascii?Q?e/Unbx8r3KoxXCy7XJNodPC9bMzfUi4LGzhs4EppAm/zkJ4NM+hUeXM5z0cA?=
 =?us-ascii?Q?vyt3aUHahmB3gBJt8SS4u07uhgRPjs9D2XpDiVPwJWxOUf/xt6IGlVC3Sy/u?=
 =?us-ascii?Q?Nfs951Bpmw6HEzsWMBCnvL3mItL1YgwWZeFh2LOoE8G8H2V4vsmxwtMyDDjt?=
 =?us-ascii?Q?AFU4lYluHdvKYDL/sZQlln2EMThyZG02zoyPG8TMA1Xq2dkyqUq1tGOs4j0M?=
 =?us-ascii?Q?YRMH9nDZr6NKD9k2QT+qMpXhQ5B7z5n/IrmAyUGLDPgmI4lQ8vVxcjZq5Lim?=
 =?us-ascii?Q?DCjz9T5WhjLkzbfO3Y5+3XV9PNFiirwAy40Pxb3twHVJ2W0qJ4fmwzF3TnN9?=
 =?us-ascii?Q?HrSptUY5YyicC5VV/XRsjvDL8B7GWDNwhI5VNNHSs05I9fdQ9v3NQlXbTFI4?=
 =?us-ascii?Q?4+lfEojNxumEV59xr7WKE3iMom8KQRz4Tw/O9nVBew3Sca/kozdze9Kdq+i+?=
 =?us-ascii?Q?YdXqBiiYS9CStxGZvO46sl8d4X69nHy1G0Ac7rjiyfcWoGHRdGWE2nnb8z6k?=
 =?us-ascii?Q?nMwzP8rfo9ve79iw8aU6o1vH+5sArdBsK9aEEfTsr29l+hNTiNlJhS7P2sxi?=
 =?us-ascii?Q?1PUkmMajWL+ObA/b1q+ARmHgNzKaqMHG5rmgWNbilt14s6K4CbfOkDQtTXyI?=
 =?us-ascii?Q?FHDlC2vXAcfhTLWAwQ9LJQosd9uzd80XBcJtx0J1DUAEkGbx28adS/wm2JRt?=
 =?us-ascii?Q?v/b6ZmJtayFgvfC6CjtfjO0NbrJmFh3JmVj9DqCdWNM9ju1A5eSwvSuSXO4F?=
 =?us-ascii?Q?VQhT8kWDCFs4IWY/rQCuMTYbwZCq+wQ0G2xNg2Ua9vGkKoeWY5a9Bb09tfXe?=
 =?us-ascii?Q?ho8Z7xHsfMmTYLivnLKBFampTlh6QjWOjv5TFahPHYFkfpoEChryXBQYIouo?=
 =?us-ascii?Q?05r4uFUf0UcWUUDFHEeRDWkPZrOpeRZQkpZ2jdcJ+TduCko8dA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:15:13.3122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea2fcd0-5240-455d-815a-08dc91442a67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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

[WHAT & HOW]
dm_dmub_hw_init and drm_dp_mst_topology_mgr_set_mst can return error
codes and errors should be reported.

This fixes 2 CHECKED_RETURN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 5 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 60404385d4d0..590e899ae3d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1302,6 +1302,7 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 	struct dmub_srv *dmub_srv = adev->dm.dmub_srv;
 	enum dmub_status status;
 	bool init;
+	int r;
 
 	if (!dmub_srv) {
 		/* DMUB isn't supported on the ASIC. */
@@ -1319,7 +1320,9 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 			DRM_WARN("Wait for DMUB auto-load failed: %d\n", status);
 	} else {
 		/* Perform the full hardware initialization. */
-		dm_dmub_hw_init(adev);
+		r = dm_dmub_hw_init(adev);
+		if (r)
+			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 717d97191dda..62cb59f00929 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3795,6 +3795,7 @@ static int trigger_hpd_mst_set(void *data, u64 val)
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
 	struct dc_link *link = NULL;
+	int ret;
 
 	if (val == 1) {
 		drm_connector_list_iter_begin(dev, &iter);
@@ -3806,7 +3807,9 @@ static int trigger_hpd_mst_set(void *data, u64 val)
 				dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
 				mutex_unlock(&adev->dm.dc_lock);
 
-				drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
+				ret = drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
+				if (ret < 0)
+					DRM_ERROR("DM_MST: Failed to set the device into MST mode!");
 			}
 		}
 	} else if (val == 0) {
-- 
2.34.1

