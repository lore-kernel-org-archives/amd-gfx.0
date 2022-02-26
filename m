Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EABC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6F510E2B6;
	Sat, 26 Feb 2022 15:42:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2489A10E2B6
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey74k9GZrcR6BVx0cXw7zFAs3rWYEUi0FmmgVaL6FVUtmTortfteuc2/Oc0WkNrjEiIgfI2j6T541cvs5mqhKEQsErGsAyblXaATa97J+JgA0OZ1VXgHE5y+mS76PGRd9jK3I4S+ZbWepmRp5AHPedCLFobF8xt2H1OMbEotS8OdHRGvw53KInA4JecsMelr27Nl24jRMOGFrsCjDJzqPGG/KRDHruLXQcvB+OHPAicoc71xu04ol1OMlaWjOQnYGeG5RZSVwAaXfmhlQul3dCRmpIKSaQ9F0pLvPVEXAy8uA5+zI8R7mIH5m7pD1eblmsaxy4RkhxDcC9QM4nGkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPP1I8nCP7BKbGV/qe8nOmteXSg9EU/GKPZJDDEmjlM=;
 b=OsGXhM3PIzdTRspSR+oxDXzFu265Pb9rm96f0cTsQwgi2r4LeT8kIdn9sMbw0yDR6cd3WFWKqupHzQwzPYz++UJEi4CyjeF7k6Mf09thmRQmMBsMPzqxDRl+knSGzrmTdDUqSvbiHvmbQM6aF/Zk0ZVntldFD4dLVs4bFRenmFe1e9lf9+vCP9Gu6Uzlb6Mof7AmyLoIHcd0RpYkHpqRW9usi0f9PeL6/LodaNntxEbkztZk9VNxXy8/IcphswI0qtTUHGYBBsLd94LdmsxQi/TS2qR/GtnjXyhKVNukMAmek+Q2cGH/+uAfl9GU6YjgJEZar4sD7+Pm3VSTgtjYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPP1I8nCP7BKbGV/qe8nOmteXSg9EU/GKPZJDDEmjlM=;
 b=B4Spx4sbOX/4ZiELiXl7DF45oy98uyvQpq/I9jyu/eM90/jHzrK5AmKbAwJ2s/rOSDT/uGOV0Zj7PIvLdUth8kuvHb5BeNY+U0IvGEBtOqx5wbZ7NbnjzAzBno5++1tVynj5PEXKm09eyLg4t75s2IIgYFT83zWt3xggqN1FY/w=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Sat, 26 Feb
 2022 15:42:22 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::c0) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:21 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:42:17 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Pass deep sleep disabled allow info to
 dmub fw
Date: Sun, 27 Feb 2022 07:41:13 +0800
Message-ID: <20220226234117.3328151-11-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06813e67-b950-4f5d-d2ba-08d9f93e948c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4454:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44544601E91DD120C4AA5C03F53F9@MN2PR12MB4454.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fq6au1Uk+qi5E5+N1hA9Z1uTSAOcRreJ/0MqIRxOc45eOCpPAHE6Kj2tu6CBTj/FepFziYtSFL/Du0SCSodjyDqqTs3FcCg69oBShmvNpS1Wfgzn+P92Y0BxcbUH59C6gECP5Q02x6Y5+s4C1+xz7tMVgFSPsZZoXoNpfKZLWP06S2AgIDKtYmGL+5I2cUnlaSby0OFIT/eCF2JW0d4jkGDuclU/uWzECUbG0zjKktIY8vrUgpHe1xHaSUVfebng5EehVNdyzM4DpXjim7Jz5qry2ycl9iYxqzEYurNn9Ulzy4qREL6zvrixe9tONW1mWlL85ff8WjDX5qlOQdAmeRICu0RPp4LSJhTOLywTJ3aWADOy1VQy9rQZ6pSFzEGTN2OIHyG3pAFWwyjM4I4Mn4fvRUo1Yr8R54SNbkcjlFPSvFOuY2/bzd1MM5+ouqzO0ynNqFFN0NMj9Vpa2O0u/d0e5w+YBzt5hke0BficlTPcZ388lZgeinmclpRnN1xY1pfwyd/sazrRZ23uNliVKfCLfe/HcFAexFuar/xE+YeYNLkx5zf3wx8RoySImaviOjAsm1X8jD6b4HE4As72rhwrGuLJ4s9lXOFQKtjfSVlcoLEo1y384A7O+PmMcjpib+9ZxGmWapAxlZT48YSyCYbVEGN/me9bGsbpHdnP2/d1HaqStQXGqI76dzGeJjNE40xZr8ptSbS318B5TqJAaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6916009)(316002)(54906003)(4744005)(5660300002)(86362001)(70586007)(70206006)(356005)(81166007)(2906002)(4326008)(8676002)(36860700001)(82310400004)(6666004)(8936002)(47076005)(7696005)(36756003)(83380400001)(1076003)(2616005)(508600001)(186003)(26005)(40460700003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:22.4243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06813e67-b950-4f5d-d2ba-08d9f93e948c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Robin Chen <po-tchen@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Robin Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <po-tchen@amd.com>

[Why]
The deep sleep mode need to be disabled in some PSR scenario.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7c8b6e1a9c9e..febdc5d00a70 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -354,6 +354,7 @@ enum dc_psr_power_opts {
 	psr_power_opt_invalid = 0x0,
 	psr_power_opt_smu_opt_static_screen = 0x1,
 	psr_power_opt_z10_static_screen = 0x10,
+	psr_power_opt_ds_disable_allow = 0x100,
 };
 
 enum dcc_option {
-- 
2.25.1

