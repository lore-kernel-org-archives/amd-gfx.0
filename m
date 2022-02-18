Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E8EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DF310EE6C;
	Fri, 18 Feb 2022 16:59:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B95210EE4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6FGe83YhuqDgNzDbSk8Wb1ef1rDsV9MoOu8JxSvFfeR5UJjovVOjTt5G6bhwR9xxuzgDFjMho4VuOnF7tbO97roPxQ7MRZDnQL/EN0UtGG+Etf1n+zQNQ57QL1d/gWegN9WdKVreWkn5FxXiQqvBtovzxZVc9FAcoM6KA3zxLYJjNEPraZltIqONFFD7b+quPfiziq5DWWoK+6Gs+roSCYbPtBF85VI/0BZLZX2qSjCsKyoNGuEH+K19xUb98gR85NQpapiMrkMWArRWeYPnZasCqbTpfbCyr8yG+yW1NPZsp1QV/HZQHeAyvXBH3RIBvYmNs3viMGIkTx3tKOisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30NxEQfN6Rtm0W3xFn2GRx7yc7pM+Rv6ifTpB1RYeUs=;
 b=KVtTF1E3KgfhKVUTGkAicavhobvD3qqULxVkG5tWkh1fZZB2f/j7dJcpJy8maoSbaQT8uKvhE8CFEMsEI8egsk/bwor1xrW/QUNTikCN58aqPfp7sXpgjgpL2j/iBu9g9dnTP0tuSu43s5ZbEn/4wYLhRmsbzvt0eaKb9mZJ7TuxgDr4JOEQ4pnEV5RkxQ+FB8BoeOsS+XIq/lQ0hVu0OTV+6EPQ76a/TS8qGqNlliZrzYMuYELNdtmdX4Sf2CBN1uKBbg3z6KXsUrUVgpvPvIbVWb1P/Tbd5OGipGruDufcaRlAKSoxuopJgL6L3tnLl5DVRJLtoRlsKFTXEtrVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30NxEQfN6Rtm0W3xFn2GRx7yc7pM+Rv6ifTpB1RYeUs=;
 b=PQf4w4MRBaeXuP/vbdYBNGRO44N1c+p8roZI0vgBzQhTMUa1FVRfSAad5iNOmB7JLyCl1xmPdgquzPZzDnT5A+Z0OdiLG1l4S0L/9+96fdHPa5zWoEFc109Gosyg9N9CAOsvj+k8R08mdfq0MjIniQNrSvdiE/s5eoeq0z6uun8=
Received: from MW4PR04CA0347.namprd04.prod.outlook.com (2603:10b6:303:8a::22)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 16:59:11 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::e9) by MW4PR04CA0347.outlook.office365.com
 (2603:10b6:303:8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: Add DCN315 family information
Date: Fri, 18 Feb 2022 11:58:44 -0500
Message-ID: <20220218165854.1417733-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218165854.1417733-1-alexander.deucher@amd.com>
References: <20220218165854.1417733-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c33f05d-bec2-4478-725e-08d9f2fffc19
X-MS-TrafficTypeDiagnostic: DM6PR12MB4188:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB41883196D3AEFCEB625F5C29F7379@DM6PR12MB4188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i20ZtnHTzc7HAGF7XtHQOy8SZlBW2suY2tdnLAzSPlDXJm2azs/kuYmcNBWT2MF0SMxVJvevwHLtaSaz84CloDnP9elI0c9tE/F7ztt4HNsSKy2BMTl5sZTq1aQsuNyahM+lrCVOH9DSc6g0WLVxSdUp0Q89bvq2i4sOCnNQsx7NMUK9O8WLHqXExhjH866TGasyZY+cWONPsMjRXbbP52awZgHe6mbdXVKtUt4VCmxywsHBYwi4T8PC9xqai43Jgabr8nqRK8deuZWcmC4bjT4chlpNe9NoMzGixMH6/G2/rwaDUUF16gOEqG29SLKdFaACo6q1kvRHLYhEgG5ft4GPb6jU49yk0R6t7cDsPwPmiDOxqhqAOZWwWwF/7nlp22hUovsE08aP3B7qvMolukC1C/CVDkJj8iW+SRFANF1xyQRN0R4XmiClpsNEQZk/Pin1MOYbyrp9erLkerU2N9H5EKjb1r3Tud/dphDr/qMhFRntJmKVxc9q3IAcQ6hZKmLfiLGvkqNyXvAWIZPLyvlSfaSvRv+FLAZ23EYyiYiCt77sGlbSUv5BRFRk3rfMwTDdl0VhZ0OPpzCFgDRF1Ss74CL6GbtoeUpZmeOb7Bq+LYp/aGpsEYT4Ed+5QMbW77+tHFvxY+hw0bOveyzmcxWUE9vzpeOGtla5Wv4aeiNnXv2+ToN+gmnxyfnDB8Y6aOIcRyJEDOJy9Xn+7qRAlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(2616005)(508600001)(82310400004)(2906002)(8676002)(4326008)(70586007)(70206006)(7696005)(81166007)(426003)(16526019)(54906003)(6916009)(186003)(26005)(5660300002)(336012)(47076005)(8936002)(86362001)(316002)(40460700003)(36756003)(36860700001)(1076003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:10.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c33f05d-bec2-4478-725e-08d9f2fffc19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 6 ++++++
 drivers/gpu/drm/amd/display/include/dal_types.h   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 9646dc83941f..42bc04377ada 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -235,6 +235,12 @@ enum {
 #define ASICREV_IS_YELLOW_CARP(eChipRev) ((eChipRev >= YELLOW_CARP_A0) && (eChipRev < YELLOW_CARP_UNKNOWN))
 #endif
 
+#define AMDGPU_FAMILY_GC_10_3_6                     149
+#define GC_10_3_6_A0            0x01
+#define GC_10_3_6_UNKNOWN       0xFF
+
+#define ASICREV_IS_GC_10_3_6(eChipRev) ((eChipRev >= GC_10_3_6_A0) && (eChipRev < GC_10_3_6_UNKNOWN))
+
 #define AMDGPU_FAMILY_GC_10_3_7                151
 #define GC_10_3_7_A0 0x01
 #define GC_10_3_7_UNKNOWN 0xFF
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index 8ddb25519880..bf9085fc5105 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -57,6 +57,7 @@ enum dce_version {
 	DCN_VERSION_3_02,
 	DCN_VERSION_3_03,
 	DCN_VERSION_3_1,
+	DCN_VERSION_3_15,
 	DCN_VERSION_3_16,
 	DCN_VERSION_MAX
 };
-- 
2.35.1

