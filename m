Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F77C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B2510E1F1;
	Thu,  5 May 2022 20:08:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81F110E1F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQxjgvEe3cRho44ftZMSAAH/rz4U78468ySxF3pOg1fXM/2EUBshbfVjINdMQxkKXKhwHVQgnenmwy0YosPahG/OHbse4MqjPkb6kwBceO40hvJHd3N8S4tFhSoZccOi/lULl57ImOnj8U7xnQ6zHG5vpml65+C1w9SweFuLV2Cv6rHmxT6Xv8dOWwxy4XANNXHH2Z6TlgWRtZpPl6sTXYYGkPI2krdfjeD4qWyqnWaNT49yTOAqv7Zo5Mi5NGIp8C5H0f5S6PtrC/KPFyzy4oQ0AIExn3VVaPtUsJiy8JeVN/loUllp8mbmrsOTaVRPDjhJpdd9f/FywOctZmGhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAYeMFrXyW6fY1L1sZbJwoE9f8GE5n0YioJYbT8j3pI=;
 b=GKuZvKqBdsWhsH1yjftooiN6aPg8eWeYrCepAMMpLv/eSl7ABYU4ZukwZ+S7vpXA5grrdWZOS3ALLSWqKie5W6tW6vJl/Z7Y5YPIl4y+qDGmBy15SWUFqlGElxQcBZBLaFCI7ghRW0fyHas048j5RfC/ChthgYvDnB+lBVFUuFLToJ8GBPMbh6wdUlb7lXFmqa9fHgA1h96rKCJe6KX4JWhtzxLVwUT1nRjVuDLDHNOeP0PdayU9ROpr51kCwzbnbxhKtt0vH3+skFrMNx789hRBKib5NzJZwmEqDEMPStVrb0mOLmLI/qwMqeDWGw8O73IMiw6Toea6WdV2SWHiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAYeMFrXyW6fY1L1sZbJwoE9f8GE5n0YioJYbT8j3pI=;
 b=ow7SVeaY0d8t4mgu/Zm6VRRT79rw6rLWzzBjlUYr2MtitlJbZRendXFG4P7rkJ9oQftWNFRwXC/3q4I81gN1e4CWVjUIgPrMzVN7d3QEhljEH3M7nWUfh12nPMUW2wWlo/FsEG6+2TX5l9LsihJE3EfmOINo5wo9h1Vg47ZR+aQ=
Received: from DM6PR06CA0055.namprd06.prod.outlook.com (2603:10b6:5:54::32) by
 DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 20:08:29 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::34) by DM6PR06CA0055.outlook.office365.com
 (2603:10b6:5:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 20:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable lclk dpm/ds and BACO features for SMU
 13.0.0
Date: Thu, 5 May 2022 16:07:37 -0400
Message-ID: <20220505200750.1293725-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75f78a32-fc3b-4699-463f-08da2ed30594
X-MS-TrafficTypeDiagnostic: DM4PR12MB5867:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB58678DAC1CE900880EDB8979F7C29@DM4PR12MB5867.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqR3CLiCHwFvYPGhnoVuMiLwhbRIa9PkBa3Y21ns5rO404gNIsKz6bAZzDj4VUj5+eSoKGJiOvMVA2I+96KCaq9R686J062EoD2VJT3yN1kQLgQEnrQtAM0W+ZlDuVkK5cQRP4BL9JSFHLe6nPKdgjR2kAePiKf3iGz2TzkBOSlXXV5az82k1sSkdVxIoOixODax2zFBAud9oNSdJocochpSe9FUVYYluRRWwTkTpoehKKr6pduzN8xhGevavC83LzTKtgmRoUs/3BX0JnuE05cWmpXEalbLX9smZp5xS3VNB22JbdDtm1hk6/HfvXalgQcJ3ldA32+yeORj3yeHPdqHwEZbvw0B7hQPuDmRHtplI2u2xvPEEB602kyXXR1euDN2H55NDlcZriLl9XvnrWmQI4TqLJ4fA45hLS5J1HSgpuDKLqF0pK0mLC8B+uFBNIO/l4tAkkRySVHW9diJVAiN4fnzbEojApXUyy2JUd4w+cZBQIHT9aMqpmIizMseAOyIavJ1dh1HyJEWNhYFGltCe210kABZHuGOonhAiTu3aJyh0Nb1X7zEsMKotu1ORu2EKiVFBpO6YkFNfuwP+h6S/LAQzNe5AA5gAPwptlQttBiQMfF9pDnyBDJs1PxcNvARmCu3dTT07jrCSv3dCDCnKNulV25VMlF0waVY7MxTkhhpT7gBQD6QKggeRTnDNiX0qSlocTUrpxpOEQuOpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(70586007)(4326008)(70206006)(8676002)(5660300002)(8936002)(54906003)(6916009)(508600001)(82310400005)(36756003)(2906002)(36860700001)(26005)(86362001)(6666004)(7696005)(1076003)(47076005)(336012)(40460700003)(2616005)(16526019)(186003)(426003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:29.1833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f78a32-fc3b-4699-463f-08da2ed30594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable those features supported by latest PMFW 78.34.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b595497e9bf5..71312ed26fb9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -256,6 +256,13 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_DCFCLK_BIT);
 
+	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK) {
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
+	}
+
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_BIT);
+
 	return 0;
 }
 
-- 
2.35.1

