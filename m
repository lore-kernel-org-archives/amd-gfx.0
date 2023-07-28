Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D60C41513
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 06:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F244010E055;
	Fri, 28 Jul 2023 06:49:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA2210E055
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 06:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7VWHq2zetwRylVeVTFOAQ4qV3qP8V8ZX5/eN6wa2HAocq9QL1iL0e8kxsFyemIzjs9ghSDQVrKC6TvBGE+vGjcHKbeyczZZN9eRmCrDLH1KQ3ihYD6LU+OSc7fHLjU6ZnmgKi2y1r1r60p3QlVsJykXGWAhJUxN4QAgCPDzmpZxYnKF97NPRGhG6QEhmLJhVHvJUpR4irRRliNB4OzxVJ5JdAIX401WdQQBUC+9r4/4RuebxRMEzwvEwkizpEoCNoIVlKrfs1VYmVDuX5oyGWJEYZ9nS6+lSDdGxaI7vFGrgNjVQeEaNhhfgrrxbvXwxFzuVco7cZEZBKYbBDivVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGoqoX+9WjWBrMA3Y4FJ03Z0lWf3l+FFJ9LwdcP1nH4=;
 b=cx5E3OGEoJGjVrcFjRDfVDrNgmSKnKvhJk38T1k4irXWvUSWvo9Hidp+mfBuDRmXmFSUACo6Fz5tQMpH1r4i3mc/puNHcDEhxTd/lWYs2U72rnS9I3fwBH861WnRy+u44s7V5i5utGejXnLJB0bgTxd18REGqjAjigsAWpqx4d+z2G9ochmN7R5t4O4HuW4NtCKIVv1u/sIDT1lc5bHIQzQarjvPAtY8TFePzPen4VUOI2iqsC1VRJXAB+9B/hBdq9326956uPdX9FMB+8nep5ZVWjGov3Q4H+UcmXkN7yHURG23dxboscFihsIH1DPVcpwsSERPwVBL03dzTMllNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGoqoX+9WjWBrMA3Y4FJ03Z0lWf3l+FFJ9LwdcP1nH4=;
 b=AKFhB7LwNHrDav4BEy6tUcpdZs3DBk3Md5HhodKhlVSF0u7xePu0G/xUkBtlCc6VGiwRiDFdX3Eqv7oHB07q1g5dumerlxZzkcO8SWPcyvbXDGZmQyF+9usAoIG4lHxdx+U0cwjV2EXmJXCff1JAJdUUfDEaqcYmmb87FvzBBLw=
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:49:45 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::2e) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Fri, 28 Jul 2023 06:49:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 01:49:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add pcie replay count callback to nbio
Date: Fri, 28 Jul 2023 12:19:10 +0530
Message-ID: <20230728064912.3652140-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: e5603e01-db8c-4cdf-e4f5-08db8f36d43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NAyvlp+/jfN9tNWQ3FIgHfUKXPhj/eGsJ26WR6CPBXW0jLUFVI+vjN44qmYBbNZi6Aaybf0JQZ6acQoLGpXZTLQwsY+5tah4pftjnbjzCKCyqFMX4iNv0Oh+84NxsMrLX8SeN+9ZerTzhH4Lmr9VO0cb279GFxnNEcnvwoFLcPa0zFJ4zyLeCzVQEzrJvKZt6q2dJ34729LLvm1fEJHPW34wVzHDm2Qaf4IdYbP2YSvCTMUrg5ukrGBcwtfRU9nLThDZO+7wVb5Ehj/VDWLmaXqLDkgP066Kj+KoX3VjZoQa/3VpDTJizSE47kIrwPCGbIDv5w5XrgKGMf14eEWTSUloPanAfnr3PW59mjvncOvB3tnfoAYbJA76NMKstr84MNHWTC1pC7Ye1dLmIEz/kFGdD23ER1UNTrkLtGPuQp/f1XKw07A+iOUBHjdX91TlVQfNmQhIyhUO6XSPBc/sElb5VUlYsJRMFvh6TCqnktq7M9Ln/bPquahjpJUB3z31J9zLV0GjsFHMOoymEjDZ98MzKHOMAsMW+cAE6EbBH4HciWgetjVqWCT49Wh2V2L74TPd4xTo6SQvZ4CbakMxteI9wuOMUWV+NlhDqEpxJj0HVXTPLd85AZDSrDIgHNHKX+VjLPGo1XkynbH22aHgCzz01iPTWiMt6rTOjv0giC6u5ivPYPLzI9mkUFxFigq55C0Gio5ADQE28xAuydwle21n4+ZjVRw/1fX5Bkjhxd+6udR4XNBCI7xj6C+v/vztNqqUZxGaA1dNW+ydrxIXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(26005)(356005)(1076003)(478600001)(82740400003)(16526019)(336012)(186003)(81166007)(6666004)(426003)(54906003)(7696005)(2616005)(47076005)(4326008)(6916009)(83380400001)(36860700001)(70586007)(70206006)(5660300002)(40460700003)(44832011)(41300700001)(316002)(2906002)(8676002)(8936002)(40480700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:49:45.4017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5603e01-db8c-4cdf-e4f5-08db8f36d43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a callback in nbio to get pcie replay count.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index a3bc00577a7c..d085687a47ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -45,6 +45,14 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev)
+{
+	if (adev->nbio.funcs && adev->nbio.funcs->get_pcie_replay_count)
+		return adev->nbio.funcs->get_pcie_replay_count(adev);
+
+	return 0;
+}
+
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 8ab8ae01f87c..e352db9baaed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -99,6 +99,7 @@ struct amdgpu_nbio_funcs {
 	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
+	u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
@@ -112,4 +113,6 @@ struct amdgpu_nbio {
 
 int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
+u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

