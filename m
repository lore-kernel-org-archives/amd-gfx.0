Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F1DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 15:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3452710E8C6;
	Tue, 29 Mar 2022 15:10:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F219810E8C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 15:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIcziiSRPlpguSRCmZMmKnTVcgNshJvYreJzZGFe2SQ95hniPndI17441SnqMBxG86IGVxl5RQ1cs3t0kioENk00uAHYV7K0Ea3FhULr0SUD3ECfx4N5Aqk75gWGOa5B10ROTfOxhOBhL6zy+VAiB+rrqj8gSst29P2ZpiBFKRippSi0pl5RnvHGD2nsx/9lsDiZ3jxhRuUBjJ+c5P82ZJElCRO/xiE/dtzv2UKXJMrJ9tJlGjVIhaYeUVUMopoOQlVmcTUC7bgqkFSvOQ21lSxvV7IhMWMCk5vqz3fac3W1rCmaweI/g8gG826DYrm38jgd7RjkGOmEXb3fi9HfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XWZPoDMzmC4K5nD5l/eas0neHFZevOY8bjx7X01hgY=;
 b=kS7i+rWHlOAC8jZVe1M3dS5xho1pPTwEQGOffyuIeBL3xLBTP1zcXd0gd6aTgeoPonYLh3yW/ATRJOVkon+BSNLDsRzpTA2rs3SG1VUH1qdfSfahjjsoEDvo4BA42DlCIdBGmklivo4DUvRSGtvLKsNndRAHNNQa2V+OZgzctwas6XbEYBW8BzqHa64F/45IPyPPh0TPBQml6ROFt2ggT0UFU3Z9anN7YdzXJVtESHrSVbbDVM9wodeSlsreRFYqaDTjPQYxagFhDx71Sk7Xk41/Ecu2AKmAh3Vu+XcfISTCmKtBUn7xwbTpkh5IVCFAAwbHuyZqLvpb53Dpy+E3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XWZPoDMzmC4K5nD5l/eas0neHFZevOY8bjx7X01hgY=;
 b=2mUV1XW1Np/Wpv7MaSbRc66gChR6MrcaUoKeS/i/2hEiYkcKjKowrmDFiXlCnFVjBBVkrpjkX+joBEql/Lh8cp/IjQn+My4A8RVM73igjqdWidfYzbN0Fp57ldbiVQ3E9bn8vhlmFA4pdaflsQnwTWKnbwNFLqgWg2Y+me+WzqM=
Received: from BN8PR04CA0012.namprd04.prod.outlook.com (2603:10b6:408:70::25)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 15:10:06 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::a3) by BN8PR04CA0012.outlook.office365.com
 (2603:10b6:408:70::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Tue, 29 Mar 2022 15:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 15:10:05 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 10:10:03 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Add UNIQUE_ID to MetricsMember_t
Date: Tue, 29 Mar 2022 11:09:49 -0400
Message-ID: <20220329150951.1311452-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329150951.1311452-1-kent.russell@amd.com>
References: <20220329150951.1311452-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c886c7d-f073-44f5-5f2e-08da1196350d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4301172FBD19C3179BEF7650851E9@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHLSDD1vtZSwWdCVG2Fm3/wyEjYsY1/JOrdZfAy7MlyAe2ujElzNbNtv9xkWfSbv6deUk6UUYV0qnNPAkvm4ysAj0204HIlYtwvCs89Spmbc4fFWqaAT2NauvP095WDQHz1c66HEJOEUuJIl0SUCVIaKnM6JH5ZiofTsP2Ro7oSn78XBXxp/0sAI5Sewz/DvFrR65XD9ki4IV1yoftQiGgVYW85te16sE+/T/VWovDMQVAvAJwXavQYMO4orLNLJN4VgndEVSf6cx8e0Ony9VAeIG4IlopMx7T983VQfok5TREU/GM8/UzWi/bcWnsbCP12f8cKUHDuKyQOSJCvawQN9tw3yw5pE+C/JN8JXIGRjDXnxGpiwg9gfcRIQbLnKCBe+6pbxPG4kEn1DhR3mbdaMMmi7XHSIpXztKcPxffsdSveUhxUOiQdWv6tTLP9C8dZ0GwopDri0WznZQUkygv1KfypVr2iNkQVbF3kZG7ybD5K3tJLv86n7E7hCs6uU54PIyp6b93w4yFzZKB/uSRafKLbMCbejTMyGgRlBg3HUxxH1JQoistu+MTPxtVgIHfFTKMtod5Rdom75oepq+0bxCsZPt/SdDpqkmoeiMd/3uWrIRUUR5OPKJh/GD7MKQQZXIqve4LN/dsACFUwFo+mHd3V6hg4xNXbiXKldE2ewYSqZluV/6o1SUbY45R5SKR1YLVW2IkwOKbdGNeJaBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(44832011)(86362001)(8936002)(82310400004)(26005)(6916009)(36756003)(2906002)(356005)(7696005)(5660300002)(16526019)(40460700003)(70586007)(81166007)(508600001)(4744005)(316002)(426003)(2616005)(6666004)(8676002)(47076005)(70206006)(4326008)(36860700001)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 15:10:05.8556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c886c7d-f073-44f5-5f2e-08da1196350d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will allow us to use the generic *_get_metrics_data functions for
ASICs that support unique_id

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index ef57b6089c69..46e34ed8a3c8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1333,6 +1333,8 @@ typedef enum {
 	METRICS_VOLTAGE_VDDGFX,
 	METRICS_SS_APU_SHARE,
 	METRICS_SS_DGPU_SHARE,
+	METRICS_UNIQUE_ID_UPPER32,
+	METRICS_UNIQUE_ID_LOWER32,
 } MetricsMember_t;
 
 enum smu_cmn2asic_mapping_type {
-- 
2.25.1

