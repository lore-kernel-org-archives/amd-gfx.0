Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878EDCE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3AF10E426;
	Wed, 20 Sep 2023 03:18:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CBA10E426
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSoQAl2rlq7/ZCzhT9YI/YIjL31kHWCzcAqEcZSx7I5wCNuTuRcZNZzVUOIUZ2UNlZEH+E/0vbT0+VOCeJWlOc0mvSx2BvLwFlrtq/tJ7AeLF3aAsdQ5F4Gw67fcM2/e6ILvBahJ3DdEyX6pIb8N7gw9n80wtrwcBo/jOjVfqvBsKC9bMxb64DSwK5OtMASKr09gZqpH7VHXT02g9Lxu9wVECJ8aZdv8d5shDGqNpDjNUsRQPv0h1Q03+6/UD16lc+NnkLIavOVconCL+6AQm/J3MLM8zZcvIv8ZSNnK2xi8ZNtp05M3BPNumJJq1QKWIYIyHqunmQ1ovmi4F7QiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xFDID2C08HdFKgP8yK5PCVw04eVuE63A3fI8oE7swc=;
 b=ghJVSf/YP/YZSeSxg+AlsA5TAJ9Jqr9nX/IBT1sqK16FZOFJ7Dl3v8i7fvJ3/hUsEa7+TgXrgUKY8pwC22+uIm93OMWg5qGqr44eIvbWiJYa3WKi8/ROdWHxXim4y0Ek0fY4BoGM2YPm5PfrCWSCq6z8OpEb6efF3c+RdbL11MoDtdXYiYaoM2UMVhXr2BALhbBVKzNe9o0o+9yfO+3ZaqddzLTUezBYOvRCLqHhsQV3OXgBTf9Yxxhzn6Yw3yg9Ey/GXPiumThtPO1TZvmWi3tyzdprhxu7X11NSKtsQUU+pe8H5x1oFvfaYbOCAXH6eZGt+/qhrztp3BQqI4RKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xFDID2C08HdFKgP8yK5PCVw04eVuE63A3fI8oE7swc=;
 b=BOsb5Blrcll26op9J88D+U+LEmKDpgFoCYFfzo6JiI59rK9cWuJPJTYPrCC3krwE0+rySXSLu5tHQvO+EZEUtEraEExH50Abk28Rd6SkZD3VkeSnnLwuWw2q4ODwDbsSlJZa+cDc60T3q1hfvTUbMr4QZTxX8Q46n6iAR/MhCrA=
Received: from BL1PR13CA0287.namprd13.prod.outlook.com (2603:10b6:208:2bc::22)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:18:11 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::77) by BL1PR13CA0287.outlook.office365.com
 (2603:10b6:208:2bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:18:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:18:05 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:18:00 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amd/display: reset stream slice count for new ODM
 policy
Date: Wed, 20 Sep 2023 11:16:08 +0800
Message-ID: <20230920031624.3129206-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH0PR12MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: 2498cdb8-ca41-474d-ac6a-08dbb98837bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIKrjU/TgYSqX/MPwRC90P32olytn8gKZWqs2W2JOVKux106B/nrMbfXO4AzA/kRfYGupOcC51Shx4hccSYaJKIcmKc1/OJBBiqEV624Nw3/p/wsVTiQ0ccA9PYrsDQjLKvp6V7bUqXKc2EKOx9b+zWj/FjtXtP3W+4sRtVZaMorpLJ42vRjVVaJCCQWkYA7mCPS32FN17NcPfCRvKB7sZ+BiK1y1KQnAdYjTq53M0+eg0GIrVeb/NZVJIlzRKyUO+r7PavOuLm0T5+CTuvu4KimoGJaI2US5GVcfL8+RWPCn/LQH7L0BpqommHRMxct4HNvg/lvwItdJVrAl3N/LkBhGsli2zM1QFbrQUiGWtAq+9CQ6AnPuKZ33jI4aXIZYJ8Nxmv/y+KKL1XDdlsfUgPZ7PgWeHi/VAkl3ygIICU7qGWiLX5Th0WAdy2K3URezESlnXd1SMiao5eLD90RSEqyigGNZtzZngECcDn7hPHa9DTpGQhXqkD03sJaMibzdX0NDdOlW5GP/2rkbSDqEdD2mjo4wmVK053Zh/WG8Iik7kjzEWz7doGkvFxyrqaQHFwStPTCjZJXRv/0xJtRcE0dCAucVk28qzaNsaG53Q14sdZWxRLbY0bYHgVcr3nCxCgnqvHTfGJCJ3ZOVoG1yuCU1GVS+YF0iMnw0hkH+OIFFiN6WAuG5PNQQbL/C05EBtohzHv6IeAwPGraJHYsWuPGPGJAfTIjBMqoYC7kYqbEoYdf/5f7DI+Cgs+ZF1/dZTUgJj7uVk+1gJWqEG1NMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(478600001)(36756003)(26005)(426003)(1076003)(2616005)(336012)(83380400001)(82740400003)(81166007)(356005)(47076005)(86362001)(36860700001)(7696005)(40480700001)(6916009)(41300700001)(4326008)(5660300002)(316002)(54906003)(8676002)(70206006)(70586007)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:18:10.4456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2498cdb8-ca41-474d-ac6a-08dbb98837bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
ODM combine could prevent us from supporting more planes
we will reset ODM slice count back to 1 when all planes have
been removed to maximize the amount of planes supported when
new planes are added.

[how]
reset ODM slice count when all planes are removed.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 5810cf78cf29..436892450936 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2874,6 +2874,15 @@ bool dc_remove_plane_from_context(
 
 	stream_status->plane_states[stream_status->plane_count] = NULL;
 
+	if (stream_status->plane_count == 0 && dc->config.enable_windowed_mpo_odm)
+		/* ODM combine could prevent us from supporting more planes
+		 * we will reset ODM slice count back to 1 when all planes have
+		 * been removed to maximize the amount of planes supported when
+		 * new planes are added.
+		 */
+		resource_update_pipes_for_stream_with_slice_count(
+				context, dc->current_state, dc->res_pool, stream, 1);
+
 	return true;
 }
 
-- 
2.37.3

