Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315EEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 01:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8116410E736;
	Thu, 27 Jan 2022 01:48:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCB810E736
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 01:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYbtM2nze5ItC1PXRo92HArhmnDOjtw+ofxioOcbNdnrbz6ANTPRW73cwN1lHrM65vOAuG8y2Ca3XfdJTCAbIeKbEx4gievEFvqrmTcth62kpCuMD+SojxLzJT/sE+NFSPOlza1wRNo57BgrXmXf16k2cVAezFN6w8IS0XcuUMIQoylMU4PuQGQR/lm6lq5kY466Qm6Kk7I+DalnFLGNWPbyokj8pTL/kQO9ttJdf4sIMRFvtaBMQVOC6jTLwdt+DagOWcrKJE3wxtZ3GxTMEAYKfpY7s99R285Hg9h3pStp6PDVOtKEz2lxQEfBhwjP3gNyG477U0OawgiBeNOhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmvrd1H0AauDDY3j3WIiavRRDBgdcFrf4bucDo2vLzo=;
 b=Mo5YqjCYeSj6mMn0/lj3AxVCq1L/QviEcndLrT8JWlZbqM+Xjcl0cAhTxNd3NDI0hnT5tQupK2PICU0YixoxpkPQ8xMQ+dnoKATVqB7NMYeiei6UM68A9JdNryZkdioClDphy0qDs3kqYWdwyacWS9mAl6jHt5ls5hAl7cdyQiwc6M4Kzm57ZZI76i4DYgu4wSxNzOAjORKZAhhEBfPNIdhHVwukeJJ7I16MCou6q0fWClwGcgSb3Z1duXlBCbo+0nDBa3OR5nKv6bJAaV80G+qdoMKg5aHAwwrogj2u+bzAOx67BaEjr/1tEkEDlPXZOx+ltoZZdi2+msjvnI2J6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmvrd1H0AauDDY3j3WIiavRRDBgdcFrf4bucDo2vLzo=;
 b=Dm88MfU5Hp1JqMx1fcYpeNOEF7UlsSvLJXWxFi15DEuBBUPt8tFvbYibliNOB+SY1AD/tQGeHp9wcENGDru9w2mtEIaRczdMZjpBex8dSt9tGZVymDLY5ARe6n85imi4YxFmychyJa1lPgbQ2Hx2vhiZsg6VGjQoKnIf/gZ6e74=
Received: from DM5PR21CA0033.namprd21.prod.outlook.com (2603:10b6:3:ed::19) by
 CY4PR12MB1719.namprd12.prod.outlook.com (2603:10b6:903:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 01:48:56 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::f) by DM5PR21CA0033.outlook.office365.com
 (2603:10b6:3:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Thu, 27 Jan 2022 01:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 01:48:55 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 19:48:51 -0600
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add 1.3.1/2.4.0 athub CG support
Date: Thu, 27 Jan 2022 09:48:06 +0800
Message-ID: <20220127014806.2592589-2-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127014806.2592589-1-aaron.liu@amd.com>
References: <20220127014806.2592589-1-aaron.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a59a589-e627-4896-c150-08d9e1372dca
X-MS-TrafficTypeDiagnostic: CY4PR12MB1719:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17192207CC475B9E013D9F39F0219@CY4PR12MB1719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10iHL8Ga6GiWGRpPJNqJW1w5UNbYiJAnLTevXWijbfO0CrbfW8LgLs63pkcqM3hWVI9zeKv+z9EekYUE/pwHKHFxdSVvX+unb/vIuDdL2+3wC3shtx5MkK9wQa50gZkxBP1ERDBPL1DyK1krufYjxk0Z5Mod8hkYNLJOuHy+00M2s8jLvUjg5e6TGy3ac5gEz90ETlQXfBgZ1A5tfqFe+HazqHANp4nx+6KxvAXLXsQjzsBT3xOv4t8/HoDodjn2mftcnjQWZyoBhP+ezvKKNVJbos6lpkA9v756AyJjZrqEVOt7bKGHGkrNcAeh7om3RiKX7kSjmAEZJ+56IeZIKOaevY2zfP2aDoqwyRPdpaViiOg8OPV28K6G0Po7w2OFyyUILHChtQqAdLicQpxZRR2guwMC8jAtSiNRxHrxxuuHy2Ra38tUGMQ6HKErzZ+vS333JySApdfris9UqN4cozK0xqyMTBFlJHe2Er2pTiW7hrUY6TUpkI4l7+FGsLeIglexy+Ajk/EdCfQd8FtKwKdGhyfLhRBWilpq50YPH0bcUYC7ehm1UWMMW/XqHEqaWxcm9HFQ60H2J5pyQZEZFJp1iGNFd2J/BEtqAYAnmh66dc6/jhmNZZV90/LVq4lHYhPgTGJDmKFNv/Nm+xHeuam8uyYmZFjXaa0nC9HPUZkMbJH0qnTuIfK582H8PNQ7GOgWvv8XINBbiZyp3kjeDIiCIfTtoSHnV3YyYzXJcCRTT3yP8HsJ449GQ07+N4EGWeX0kreCA7FOXhyhGdRz7BAkMDyjkyRUJtnMwAz69y8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(316002)(4326008)(1076003)(54906003)(86362001)(40460700003)(36756003)(81166007)(36860700001)(186003)(6916009)(8936002)(426003)(82310400004)(6666004)(336012)(70586007)(8676002)(44832011)(2616005)(508600001)(16526019)(70206006)(47076005)(7696005)(5660300002)(356005)(83380400001)(26005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 01:48:55.6099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a59a589-e627-4896-c150-08d9e1372dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1719
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds 1.3.1/2.4.0 athub clock gating support.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
index ab6a07e5e8c4..a720436857b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -78,6 +78,7 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev,
 		return 0;
 
 	switch (adev->ip_versions[ATHUB_HWIP][0]) {
+	case IP_VERSION(1, 3, 1):
 	case IP_VERSION(2, 0, 0):
 	case IP_VERSION(2, 0, 2):
 		athub_v2_0_update_medium_grain_clock_gating(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
index 2edefd10e56c..ad8e87d3d2cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -74,6 +74,7 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
 	case IP_VERSION(2, 1, 0):
 	case IP_VERSION(2, 1, 1):
 	case IP_VERSION(2, 1, 2):
+	case IP_VERSION(2, 4, 0):
 		athub_v2_1_update_medium_grain_clock_gating(adev, state == AMD_CG_STATE_GATE);
 		athub_v2_1_update_medium_grain_light_sleep(adev, state == AMD_CG_STATE_GATE);
 		break;
-- 
2.25.1

