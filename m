Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD44C88CB6
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 14:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E2110E24C;
	Mon, 12 Jun 2023 14:00:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99DC10E24C
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 14:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlpQ1zkLXWNtHC+RzCwMOEfO8jXJkztmQH1pnVVZzJTmx2sbbp8/8IaHS60rpO+EbYeb0MinfqHGmUEBHCMMr5Bs0ompdANPm1wujSrl1IrSD4W35VFQzUgseHyKcJ+ezDtyl05UHuI534G+b0X7VkslmE9UPlrO3sS53drNK7QeFVPByjcWveXG3Wef8g1VRneb7hD80BklTqEvxwSJR8tv48NJHWsUTfaILo1yYJId9riPZv0YgRpCVcqUBhjv+nzm5fCe1dmLNd4x6gcB/Miln/biluytaBSL9MC7uQJwE2Wsj0yLiAZVNpwn0pXMg7V6ZDcjzhCJYZmCdkxhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USlluUIDmo/hUdrulUTlL2ktUngT8oER7ilNcYJUfoc=;
 b=bg+Qw8sDMxrYz9dN1x3vbyHKVB8D7K5fkc/PJVLUz/ovGfvVGlyzGd/b/Cpw0bm44IAZN+Ls3N4zIywnBKFNA9gvS1UiB2B/IsDEfrK+8nylwvj3QcdZSi9eHgnoOBnHITROWUeu+w4EdnAJMr5I40XseT3d++VpVNovu0mq8TUv8FRP7KFKhBGqW7Bo8tObVrKmVOPYa+H5e6U+4KeNjxRgaQQyl/UZYYS2M0VlrljerPTfB+Rl/OIZlwobtPaE9DKukxLhUU9bEKNtUjCEv53fHvtzkFlwvBqS9eeUiQQHAhVvklgA0toBjg4qJsXGUURB7zCxKjb6dlU9QKYY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USlluUIDmo/hUdrulUTlL2ktUngT8oER7ilNcYJUfoc=;
 b=Vc9GG6x4543doa6kmo7sFoIwx4eeWqeim/QGej8/LApEFTh0rvWW7KMjnXn3srpbQc+jHlEXF91O1y0qfgc9Y6ONkeP8d08NBwJ1IqPQjkl2HGDn6VsFSmPQSz+zqUUYOrN+h6rf//vOWkAMRfKJGeoUtT7iGJUxGuBhcbGn1Iw=
Received: from BYAPR21CA0022.namprd21.prod.outlook.com (2603:10b6:a03:114::32)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 14:00:36 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::f7) by BYAPR21CA0022.outlook.office365.com
 (2603:10b6:a03:114::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.4 via Frontend
 Transport; Mon, 12 Jun 2023 14:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 14:00:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 09:00:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: fix dpms_off issue when disabling
 bios mode"
Date: Mon, 12 Jun 2023 10:00:19 -0400
Message-ID: <20230612140019.720959-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: a1740cd0-13f1-4add-5ab3-08db6b4d65b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt8sDeXDXEmp0vzsuLHdUylIU5XEgA/9IerEBv7M8ebi067kHef6Oy9EUMvVcf9ECix9QEeREK5liHJOUXXp2NHxr5pM22iDb8xuZJ6h4/xReMywwpnjVmnErEPhx1DHl4a5IK5NCvBswg4n2RWIrsKvLAG2XC2IQbyPdqbtkx5JM1ud095z1VLcNyLuliIYJ5lX5uzpQniZn8IrI6a8za2PHyUieKcz+yKSNBM2qOi7EcNdF6064m9XjTVhGxYzuutt+uDlA29YR5MdVTKSgcW2Nw0asfD0vvgIqb1uXUnp7hZh60eJzkIgXx9m70rHKroqHsdpe/CRrPqvpHkCqR7naOS+xWOYVtkmNwIdpSyisRJwryLMtojhVzvFA8uc2uU0GxtdIlY7KSDpnnlW75uxGu4HsjvuBr+MNkiXLrHSt6BEVL3Soab+16znmkwjAr7VivZiwTuxZrS07lwjeXo8z6ievmn3o+2/mTLkgFpUlD9rrmp9dwJagKLTgH546y6GFaW7gJ/LFBChjaDztaxZP+70qLgST79R0QYbnc81pyS7TZPw6RJoTLnHvYjQE9l0n56vrdiG1sOMGs+62AqaXX4M900CNRRr84pGmYokuT4VEaniuzDi+ZSUmkBiWvjL8Y2+pBDs92wOlAh7gJ3SNGpOCBJN6GwhHEYFyOIzOBsEWdjw23y5/JQynK2xRUJf+ZE+7XsZN7q9nZbv4wATQediH2k7//4BsKCK5HQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(47076005)(36860700001)(426003)(336012)(83380400001)(70206006)(6916009)(70586007)(6666004)(7696005)(26005)(966005)(1076003)(478600001)(54906003)(16526019)(186003)(2616005)(2906002)(8936002)(8676002)(5660300002)(40460700003)(86362001)(36756003)(4326008)(82740400003)(81166007)(356005)(41300700001)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 14:00:36.4204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1740cd0-13f1-4add-5ab3-08db6b4d65b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Zhongwei <Zhongwei.Zhang@amd.com>,
 Mike Lothian <mike@fireburn.co.uk>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 58e67bb3c131da5ee14e4842b08e53f4888dce0a.

This patch was reverted, but came back again as
commit 58e67bb3c131 ("drm/amd/display: fix dpms_off issue when disabling bios mode")
Revert it again as it breaks Asus G513QY / 6800M laptops.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2259
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Zhongwei <Zhongwei.Zhang@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index be72e03cdf92..5d3d61faeb28 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1296,7 +1296,7 @@ static void disable_vbios_mode_if_required(
 
 					if (pix_clk_100hz != requested_pix_clk_100hz) {
 						dc->link_srv->set_dpms_off(pipe);
-						pipe->stream->dpms_off = true;
+						pipe->stream->dpms_off = false;
 					}
 				}
 			}
-- 
2.40.1

