Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251E2C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E27510EFFC;
	Thu, 30 Mar 2023 19:43:20 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1407B10EFEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKtf57Ung3vo7rVCBZnp/cDJeSpFUS8z94rvyMemC9+wqurEV1k7SKCIzo9SOcLd2ox4uWeLLOWCAYq/XgyNMvCFrwk6uutcYFXreFGW7wZPh+JW4kdpbWDpM72+lpYvGGiyBeyBEBNhF3LAUB94g4i3Gp5oM1STPoa+sBZ3Lj/D5P4JRykg+z1wUvgypR3p3G6e0KDhMTHlCClcP7AbRIGFGRYFX/1UiHup/9Srmd6uz25oE9iKgANpcMHGThCL4b96qdvcDRJMCZqf2tFumXEtEuHH4Ns+GC1tq21EGE+Kf7zHPq5yQXDZC2pWHslrc3Av7SzspqZoyIbpqrr/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxpBcOjO3hprFSBK5T/cpPkIKNBLUJ2WVkB99NLgiR4=;
 b=cYD3Kox0UsTkvHC3Tj5Mp3xp95YLtZVwQySKp95c/0woOjQl0WIcQS90jaK8grWMflq8CZRiBoz0DKME8uQH4l9PB0FOMOTZYgNY6sjWxHVswS1fYGr9fwuAKSifv7lVuET8UrgpVrltPlxGtOuXIrYYdYjV1o0vEGwrsZabmqRcP+3lXBW7KCLqZlwvH+safdi/GGiwCROv4NuxscKRAPUw0ibnRC8VHvLwhW94V77Kaeo08PItEx9pP9+IrAqzcklc8awcfcvGsciLpC7wHpjOPcNoueu24id6w4PnK6t66lnoHQgwQXYzBXhlJ9f/C0kvNqZWWMEZ0AJYCZtnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxpBcOjO3hprFSBK5T/cpPkIKNBLUJ2WVkB99NLgiR4=;
 b=Wne18guF7nPKoEWKEomLOMQZOPLbZiRtViMzAiEf+Kcsrx9dqW5itFk8a4O0Ld0DBC7CI9voAy5PV2RJl/cCJR76hIZ3MZlL7YfhXu+JEIAHyvjC9SmozQ38XD1MsB3fdaLK5x7N01XFfm3+DLrM3uTEVzd/QRmbOjk0yKejbfM=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.27; Thu, 30 Mar 2023 19:42:53 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::7b) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/23] drm/amdgpu: set MTYPE in PTE for GFXIP 9.4.3
Date: Thu, 30 Mar 2023 15:42:19 -0400
Message-ID: <20230330194234.1135527-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: bcca3e6d-a81b-4fdc-18a5-08db3156f3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwrjQEBkFrJok7/zqVQ8LADJAeTPo9ZRB3YosFc5hNMu+qth4M5jbRTO7HETPSDa01BoG7KsTVAIu4c0o8eUlHnE1XGiEqE8qx33TwolMwuwPMwAYEuE7haWJhaj3CC0xctgi0ZNL8wRcTLYetLH7+dwR8cVvUu6wPqZ/IhsMyPn9hDmGshQNNRV2FOaj25yBKyokojS7n8kS6N2iqEEwXYudtkerZekG6fSV7qqYWto0hi12f/PnKSQUcFN4CnFQufjsn+f+7FomyXc+jl6XQJU73kWHDOUtaNgtpELg/A0HxBPmMrqwZ/D6h0nXdQYGsMv+oP/xyahr/U2QH8B9H+Y/WXpwMWY4aOlL3sON9jg/0VpussQNTmd7kDXmyp61VljdBBm7JUp2jyDLIlPAIUUcKj+V6Ck5+PDtpUKmcSQsn3m2QNXIK/XDmMozbC+P853TN68d2DVJmZb5YFr/QVuvMYwLjnUVlQO1pQ3pGHtf8e4uUmUaB0bcZLP9+uGJkJBXoa6pzc93k+P5Ya2+9TLpL5rjAvvRXJrtHcS4dyVGEWj/iCLBrH16I3bGgeY+Nj4BK1ho6rW3G28Bi5ZUbQ0j3+BBXqJbdLqZWGJLILCTr3M8hp/68DB4rrKPIqeclce6h5c/au0MFwjvW/QiViNhcnjxsfrVCxOsh/6ojRitmVlBynjtNPyggyJKR7yg809NERb2fnQvGebSmYfjryqUNRBs1uZ7jwQjyYAxlQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(54906003)(316002)(40460700003)(86362001)(82740400003)(2616005)(47076005)(2906002)(336012)(8936002)(5660300002)(70206006)(6666004)(8676002)(356005)(83380400001)(426003)(41300700001)(7696005)(36756003)(81166007)(6916009)(186003)(1076003)(4326008)(82310400005)(26005)(16526019)(36860700001)(478600001)(70586007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:52.9856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca3e6d-a81b-4fdc-18a5-08db3156f3d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Graham Sider <graham.sider@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Apply the GFXIP 9.4.3 specific snoop and mtype settings for various
scenarios such as APU, APU in Carveout mode and dGPU mode.

Note: This is expected to change due to:
1 - NPS > 1 support in future
2 - Hardware bugs found during initial asic bringup.

Cc: Graham Sider <graham.sider@amd.com>
Cc: Hawking Zhang <hawking.zhang@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 40 ++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e719b7737111..da1c7ec3f0a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1155,7 +1155,6 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
-	case IP_VERSION(9, 4, 3):
 		if (is_vram) {
 			if (bo_adev == adev) {
 				if (uncached)
@@ -1189,6 +1188,45 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 			 */
 			snoop = true;
 		}
+		break;
+	case IP_VERSION(9, 4, 3):
+		/* FIXME: Needs more work for handling multiple memory
+		 * partitions (> NPS1 mode) e.g. NPS4 for both APU and dGPU
+		 * modes.
+		 */
+		snoop = true;
+		if (uncached) {
+			mtype = MTYPE_UC;
+		} else if (adev->gmc.is_app_apu) {
+			/* FIXME: APU in native mode, NPS1 single socket only
+			 *
+			 * For suporting NUMA partitioned APU e.g. in NPS4 mode,
+			 * this need to look at the NUMA node on which the
+			 * system memory allocation was done.
+			 *
+			 * Memory access by a different partition within same
+			 * socket should be treated as remote access so MTYPE_RW
+			 * cannot be used always.
+			 */
+			mtype = MTYPE_RW;
+		} else if (adev->flags & AMD_IS_APU) {
+			/* APU on carve out mode */
+			mtype = MTYPE_RW;
+		} else {
+			/* dGPU */
+			/*
+			if ((mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) &&
+			    bo_adev == adev)
+				mapping_flags |= AMDGPU_VM_MTYPE_RW;
+			else
+			*/
+			/* Temporarily comment out above lines and use MTYPE_NC
+			 * on both VRAM and system memory access until
+			 * MTYPE_RW can properly work on VRAM access
+			 */
+			mtype = MTYPE_NC;
+		}
+
 		break;
 	default:
 		if (uncached || coherent)
-- 
2.39.2

