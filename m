Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864EBC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D58F10F43A;
	Tue,  3 May 2022 20:37:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFB710F459
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of7fmZo1hs7FRx7uJvd3KotO2sCZfFqSvEZbyh6zyB9Ydye8haqlKn++MrKDGkAZR1V+/BZYdERcJYPv9UiYJvAZpqD9KYN1yL640picpu78W2y0ylyH5FYSG31uPqrGwpYuPzLiaf1foVLMsUGshrZeWaVGhFbZfg+KYTfP0IuHaIrxbgRsu9fgwQ3+NsngDeAD2kZSqIGR/jJo/CjiIa9QpXflL9yZCV/QqFz+ah2FQkvDhv6Nv8sSCOuoOSdekGMoD4gRWSyRMwJK5fFK9xRLuN/oKpHZRPGL9L6F9uPkp9HXB0iYksO3E9AnWJQWBhIITjqWUTPEWZkh2O+adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ6E3Z6msZmzWFXRp18pg5PBw9u7pIVUgFkMX9AaskI=;
 b=ItuNEzLHZ/TIsZ7nm1/DxexSltNLxw3ABpo/HO71xSFvm2fpN5Imy5F2J8bqcWTsU+izdeejBeVXogMpkAE6f0OKNdLHU+jkDFgm2oFJkEzJVoLbWI7M3g19/i/ZyegrCwdhwfmtMvm+yLsv16uxGRhKxtxl+qyO6rk/D/c7wCzEKH9KJmqF6mL3Wj36/YabJ60ksqZqGzY69P0YmLIEBCX8VGLFyT+lQzNS+9ltpYzqe6keFYlVHu1uLy6kFe9Av9FQAt6PnFxUbOR+85/zaRJn+jEW9YW2CnG00acXu5Ys+p5pb6qG3kJJ5mI01GxjU1ZoFFJABV1zSDvgjzfLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ6E3Z6msZmzWFXRp18pg5PBw9u7pIVUgFkMX9AaskI=;
 b=tG7pCGgVGujp/Czolvdcb7ldFJWa8J41pjNbR4qeDlvi4M20ewwk1m3Y4HpuJi6T6XncsVAy3WR0PPmWE1QkEuB/HBnnN+JxJ5k9plsQ2m8XhSlsKO9wVhQMCe6npvGrm+Pj5Yl/Gx7bK437v5BLcEB92PMN0HGOYwvKucjDH0c=
Received: from MW4PR04CA0123.namprd04.prod.outlook.com (2603:10b6:303:84::8)
 by MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:37:39 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::f7) by MW4PR04CA0123.outlook.office365.com
 (2603:10b6:303:84::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/26] drm/amd/pm: update the features for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:03 -0400
Message-ID: <20220503203716.1230313-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8afcde38-11f6-4406-36dd-08da2d44c406
X-MS-TrafficTypeDiagnostic: MWHPR12MB1663:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1663DD92CB31026F692A88C6F7C09@MWHPR12MB1663.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdJ+A8Yi8qi0q2Z18PtnhtYcSEhOvQQaT/a0MzRpAWlvpQX+RU80oyzuhssIw9JYacYWL9Hkp1wyi3s+8p8HGdkT5X77gm6KJTJUINAV/wANmmFNDfq5rUA9OKHDQPQtXHzTUDw+/vAT842bCrm6KUvLtehPZLOdeeSh0nJtbnzaYzxNjiHrYokSF/ajWND+M68QGdq5gww/2td0gly9xwEkVRYws/eXk+JrtHN/NbAWazLHVCjriN7dzuY8t2L4fFx1mEAjFWVLK24XvrxOhjlV8D00cbOWU+sHpIlWbJYB4yW0FTeO4ORCUEIpUXhuRI4/bsx/Zk+6ZHxS44sFLOEk5bEYKPd8ZdgdM75fa+1ynxf0Nr0yW3Ei+2IW9aJFF4NcikQ4a2SIQSZ+9Af3sRxXevYrCKF7xIngSr4rxz5aqDmkRRDkNPMGnm1yJOlJ3ONIJ4yo5ZS4N0d5cdydAOUKT0KBLdrah4aHAGVr12FWUGMZyEbRkE3gPtLLscXUhz0wc6LBSVJOcL1g0EEwMDVNjwVA6Ju1iH62yIrw+oedzUaQfev1LfKen3hYH6Su5hzl1TBrSct2GHSX8JQ+RgZZIxJNQFQalcjLjo5XncrYLKe8J7AAuBM3i0wkCTuV8ZfF0JIX+lTdIfk5BqBL6ZYhu+OgrHb6W2wLIpHFw5dbteNqqI+ZkkLitVfB00BxtL18Xwzxt1Qlg/Eil3o0kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(81166007)(186003)(7696005)(2906002)(426003)(6666004)(2616005)(47076005)(36756003)(16526019)(356005)(82310400005)(8676002)(4326008)(8936002)(26005)(508600001)(40460700003)(86362001)(36860700001)(5660300002)(336012)(316002)(70586007)(6916009)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:39.4239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afcde38-11f6-4406-36dd-08da2d44c406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
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
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

Enable socclk ds, dstate, mp0clk ds, mpioclk ds, gfxclk ss,
memory temperature reading, athub and mmhub pg.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f899cd483ca8..ece0cb276aca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -189,6 +189,13 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VR0HOT_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_CTF_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FAN_CONTROL_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXCLK_SPREAD_SPECTRUM_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MEM_TEMP_READ_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DSTATE_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_MPCLK_DS_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
 
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
-- 
2.35.1

