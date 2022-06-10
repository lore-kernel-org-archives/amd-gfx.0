Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1F8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 06:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E54812B2BE;
	Fri, 10 Jun 2022 06:26:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6211412B2BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 06:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayAokhQkMlgqbIgcWHKLa8x9PQ3Lrcpt3Yp8xjr7O4O1s2rk8YsQ6JFCJK0vwWWNiVe2Lb09I1x2K2AKejgXmGCtLw/g0YehCBYnfBOtuypo+pQfuwnTNwiOH0/wQYNgeKi7FQj80cpCJ5qKH2kggvvd7sryXAF5ZePUaWPyVJCtbuyZoJxWwhYRrDG7/psT+g/JVZMPXlzSumZj0N2w5TnXPB2LXFKNVkekg9XZsZgyOX8YhNR593gKGrBHS3C3XLwSZyWnSvmuabqs8H8BXwEH3oX5mDZxiWmVeCcxBLNiibfauSb315kVZZKOgApNiSY1YI5fHaNIEPG8DEzBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzlr0c3tSod1FJQ+/U8L1BFWQzF8DqTATVky7e2k3fU=;
 b=bqyU2byX9pLsuWZMomiB+R2aSO6bLG9ZtCknPkJFYuiuif3v38A/R4RxkgLNC8giYxey07cjz/kn2BjJienty1mB3tr4V7OYtxTZzfWjQ3HjFd8Br0G7SqZfehtAKauF232COHHcnt3yPB7TCbKv1AYBgGRZk/UUAq29F9R7oTiv70zj/vn1gyzp7vhXQsV0tK1dnEP+FD0ixbzIjWdADXrtuSlPqu0Hljdy+OgP+DQvPD63OTdP/uCXEw6npsWpAaUy9HrgTkVfGOtSbeBT9Rf2McJE2AgKkWZME5gsjIhR4EOncA5jEQ34hEvalOnbqth9eDhiEL4YJB0CS5uE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzlr0c3tSod1FJQ+/U8L1BFWQzF8DqTATVky7e2k3fU=;
 b=nSSKxAP5HjRbvy/2IdIAVmpdE9XI/EeS4jjiq8omgbq4OxOxgxt0+36YG72+qRmbMogKfwvURcN8+IxWHhdtFeII869YXXaK/9JFNxwSd2cDTWwY9Ai+nw6z+ZS+i1r8lO+cXgW203tsO4fh8tub/lkEYsVWBeUYWFU24qxdp1M=
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by DM6PR12MB2889.namprd12.prod.outlook.com (2603:10b6:5:18a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 06:26:13 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::7) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Fri, 10 Jun 2022 06:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 06:26:12 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 01:26:06 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: enable UCLK DS feature for SMU 13.0.0
Date: Fri, 10 Jun 2022 14:25:38 +0800
Message-ID: <20220610062539.3666611-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79661f71-ba3d-40c1-8041-08da4aaa1d8c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2889:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2889C5E00B3F60F1B6BF2DA1E4A69@DM6PR12MB2889.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THyfyDHZI8c6qh97i07dFB9iVUrHrbPjo71GfQjD2kQt3RvOv0Wwzr/Mxynio1hWHszvF+KZtPQE01rHYFStOo2hXZqSqlhZdK7MTr6D8qrpbBUSHGXoxrYDOBQ6TT1OoTAMdHo1aG7DsmrF2zB2J8Jp2VrJ6qoCW451SWhHzVo5bJmkUNJumcZd03njGzrl1UZvoznj6ZnZh18gDwye1LycMUGf+jZnFwVUn+h6vKoF7kR06ViWwep9qC6mzrz8U8SQ4eHrtZ++9YDU5my6I0WG91O9kJBFjhHC0MIMvu2ewQRhr+fy+yYYe92IBccDwLySAwNArwxu0kE+NGbjWlzHerEPseciqHm49nItliUpnO4sJ6271Y3+PBFLhCLjn3EAlxBRwFBoy63JnvdDb9IhmJUrSx3D/Mixx8ZAoeEeTLre5I1omKFWdWgckY3vaFdcu0y19DblSmU3kLELO37qdmtBLjKiecQXLSzPl9Gxe0bqgZmGGkXZUd/gh/AgpRHJSIfBpvhh48UDMKEPzdpJ6p1FOdVYjwJe43ZaEbN7rFmlayV0h/g4PeOZaj8BIObNfpfwx54NvreOl6HRN/BsOluY/qjzbHxz2fhk+RBe8taUOSl/KAIBfiSd91yIwEy8L6wbxS3cXj6ANqn+mRFBezu75tJ5SPEtJBGhyyuJjnNwbVlgaERj92elfuYd2nUZEoUe4MfJKCeRX5HDhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(16526019)(186003)(336012)(47076005)(356005)(1076003)(81166007)(36860700001)(426003)(8676002)(40460700003)(4326008)(8936002)(7696005)(44832011)(2906002)(36756003)(316002)(70586007)(82310400005)(4744005)(70206006)(54906003)(6666004)(26005)(2616005)(6916009)(508600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 06:26:12.5583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79661f71-ba3d-40c1-8041-08da4aaa1d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2889
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The feature is ready with latest PMFW and IFWI.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I0b1ea6a32bc092eec4b95118a1442597688ee8d0
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fda89e309b07..495713e4ebd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -306,6 +306,8 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_CTF_BIT);
 
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_UCLK_BIT);
+
 	return 0;
 }
 
-- 
2.29.0

