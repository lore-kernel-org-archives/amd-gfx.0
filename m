Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677F8C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A4C10E829;
	Thu, 18 Jan 2024 14:34:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A6410E831
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQURUETaNoDQitShevdVjCrW6Up7bKTkiveVL+N1DVvqIieCeA0s2k1he/bFjewxgRuEKSmZWcS3/55LFUewJAq6qyVCRplR6JYRcIMvKgIRXedveMVGcRLrwT2iIazgzVhTi4Mp65yUYeDXBD3X4IbkR8oNV69TYld61xNrToF+3hHhF4OrDGfAPCppEq1fnkYUclPho6T4XwgcyFY9kT8cnGXlIjKvmV1rDOYGU/D+iIJbZdujVKgoDYRTUa09xni4gUJ8C7K8IojJS1B9JX9DGepTR7HvAdQ/jFfSuo9QicJJr7R6aPidToRWuf/6ZVLps85xWiC9zj3fn3j/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+u4fZbn0NfP7KT+sGav+V1dLLg8jhRTMZDhi64sWPw=;
 b=IAIsASUwK7tFKziNFNzzqSgnXEaJPJJgXjN69EZw7YY6/FPmSLujFu1mJAhgQVSBBi5AuUuAwOtZi7XWmHk+4IRY6BzuvVWziMmn9HelMong2+MOFbmgijZOYjVbq7OnrOv6QiDpKzKltBez+HKv/ME25L7Oq3kSpxaePQoyjBKarNC7/ydy5Vk99vlYFRAnJeW9fnKJA1IFTn9iy9BCxNNuy8aNMijwoVRJWaGI2OzY+94zlbqYpFXMxbJu6YMubgg10DG+6dbEchx4XbqVQbZjm7bKU7bGT8yd1/1U63kcwivYTMal9IMM4gkNmd4fYhbXazKPhT347GYyDpml2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+u4fZbn0NfP7KT+sGav+V1dLLg8jhRTMZDhi64sWPw=;
 b=NjYXwmc2zbJLRLRm2pSrczTh1AXh/bCu6qpbs87cFs9MsBYBxvm4RxGsaT8Of1BUCrakSWnzhkp+bOkvJd23jFLebyPBDfvQqZCG4HYJoRcZXdmpS68VGhFMgrPC1pxr0woORmPngovRbsmD4KypvqX6+aXoe5o4GQ/sp2BSH00=
Received: from BYAPR06CA0037.namprd06.prod.outlook.com (2603:10b6:a03:14b::14)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 14:34:48 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::7b) by BYAPR06CA0037.outlook.office365.com
 (2603:10b6:a03:14b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:41 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:41 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: add power_state and pme_pending flag
Date: Thu, 18 Jan 2024 09:33:54 -0500
Message-ID: <20240118143400.1001088-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0715e059-f614-4826-049a-08dc18329f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kAurZZXLb8KeBTqxrYBQqPjXXosNkOI1YaVEUL9BOSbgm9zMbnzrn4osNJfVAvbHBhhOqZFFbOe8fE1AgdKntrz0Fb654xAkjuIcSAKxaHA8cmfw0onIBIxliGZomyL3+uE4C6uv4zlOvK1nf+wuQKWhK13eCGfl5ELKlu2j71QQf3hmr6i2VhMS1ACOAhEwkzkev5OREYtbqnazyW3IljoB/r2/fIIxZmYNXiPhjuggYtypc3cOqBvghQpyn58NdCahOOJCACAswRHEZCfOUxroq1HJkcHA8sVMhtmg9hjsTDMybPFhwyhWViaEbh6dnRiArq/9yOiWBcFr9nv8BY0hMV7tNSA240De4/ZuPDHHn8tly4Q/+Whhf7dont7Bus4NevfgjwbplDOJB3j7JYDpHSTRkWqwjRlDakgK4gdoBnPmwpj2epofQmZ2xjavWHvCmdfeOwbPrzbrvrvbfH31S6e73tAsUGwvPkRb3qr06Vo3Bmar09CrASFj4AzcE8VXi6vlfw4r9FhE42a6+maWnv4Mjl/GMflp7L1UjsPHN24X/oKEm6nVdZielFVAAUiX0q7zVLVk1kMhjOhc+mX34PvHMvjWnrjagxpAy7BOsdBq4ih65/CaUPgwEAuleF2pWXifrKMLinHyr8DHyXfF5JgIWR2HuGKuVT+6xXiY+55riK0dCLPIDlysESTc2+ajiRHH6conTh1uMkRGdkg64ZLJEZcJUbX2bELRtCmIW41qU3sEGMvyMfjErV02wt9uECUsvKAXuZ1PIAM9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(70586007)(70206006)(316002)(6916009)(86362001)(54906003)(478600001)(6666004)(7696005)(2906002)(40460700003)(40480700001)(36756003)(36860700001)(8676002)(8936002)(5660300002)(4326008)(47076005)(26005)(1076003)(336012)(426003)(2616005)(2876002)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:48.2153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0715e059-f614-4826-049a-08dc18329f86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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
Cc: Charlene Liu <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[what]
Adding power_state to dc.h and pme_pending flag to clk_mgr_internal.h

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                      | 1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e338576f95a9..cb1899772426 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1069,6 +1069,7 @@ struct dc {
 	} scratch;
 
 	struct dml2_configuration_options dml2_options;
+	enum dc_acpi_cm_power_state power_state;
 };
 
 enum frame_buffer_mode {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index e668cc21cd28..f4d4a68c91dc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -356,6 +356,7 @@ struct clk_mgr_internal {
 	long long wm_range_table_addr;
 
 	bool dpm_present;
+	bool pme_trigger_pending;
 };
 
 struct clk_mgr_internal_funcs {
-- 
2.34.1

