Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F49C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B175010F460;
	Tue,  3 May 2022 20:37:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C1210F45F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxxLDe93qxE04yiJi6rKuwSN2frxx8lDykJN8Xoj/41ZafIADPLJgVLCNxSoRcFbqbOrrEBVO7FuKJ2CjTS73KHICZ+Y3To0yNrfPvU4osD1UOyfVOnyinSCZOCeitkj25JvIOYohiqivxPYZiO5FJ7NN66w8InPynzBsXZvTYNt0Dr2gIoum70sG0AzdyynthD2detf7fyIqN5EdN1IG2l1uZRuRfvmOKkakZ15djXx4Nkbp5sjKMOSIqQHoz5hpA7p/nQDzHlcY18loBDWCsoPX7Wti0xfuNFxg3++vPY7l47+0Csp3VC2WqphZTq1/S6dHUBxOSLEsAJmHdjm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mESwlQ1Tl5wHp9uH3BYYDoKSZEJzhdyYewFAJJmYuxQ=;
 b=LUE1dPxF0CAqU+kaXj29KN8KYagSfB/cI2paY2T8H0j1hI56jrM4VOwkJcoyNr6sSUaXG/MJikRvNiLrXXIAebJTMKxggZ6n7EwYWS19uNpBPZi8H/RCA4/VdGnc21OwXeooyvLQcqoin+oiaDjN7S0ZtI6qzoMVaRCB63+ozESeb8+ip86a0WvuUQwHAroipe+L8rdCPD7jdpAyHajJbaB3Xll70qVXVuN5xzUIwKX08FOQh01GFlB7qCXUIeuBpR9wK6G+sBMKHSEiYrT832/2hm1tp1VCO8LK4YQwRhC65NPKt3zpHYp5dhPp0jrrlcgXHEjjgW4GaUXB7TrYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mESwlQ1Tl5wHp9uH3BYYDoKSZEJzhdyYewFAJJmYuxQ=;
 b=Alof6WkW4ec0zB48K9CcUDmm725CBW3e+RhTza4sKfT0yY/PPAxJXqJXlsx5/Hctlc298uvqnYois4I1gIkTO7pAtTjlSCUF1nrhZ2/4QZy6ZfnXPfVHHGaS62+iLzJwQZb4NQfyaPg9M8Lw6jzwpTwFWXHfx3WahavajOHEVcM=
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by BN8PR12MB3043.namprd12.prod.outlook.com (2603:10b6:408:65::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:37:38 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::77) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/26] drm/amd/pm: enable fclk,
 vcn ds and df cstate for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:00 -0400
Message-ID: <20220503203716.1230313-10-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 83a903e0-d042-46f2-3634-08da2d44c2fb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3043:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3043E4ABDB21F49680A27B78F7C09@BN8PR12MB3043.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTT/n3yC0LkIUyzobHePhRbkWOzLKUju6lvLHuFrElA2yZnbpE/v4OUsuq35mAp7wCUltlIw+PWgo9p2oMumjodIETlITlRzpFEkg8TqdxCfQ7atwL7rO3ttAzR2D0siZTaJeUMjlYxFNTics683XwAGKiMCYx+mkcwr+qdXnDl3xE6PN3t7p32lBjezP7ooGqXAqj2F0KrRZoEC/m4SM46TQhFoLI/UpLUOxwlyjU4/3otC6TTRmNPMMzWL4/MwX6jjmqFSoCSDIflIUEPiRFGCbhkNfxpKo/AGUvWlq3LOgXaIFJZuVj4l9cdF2TD6JLw4QUd059CDpN9rmBd+rcX90BDbwKpHEoC1/ueurQiB0C45PBmIfrTpQ5wUkfOHiZLz3zA+b1WCy30mOHzISq7HWKsZM71T6TIY4o/C3wJ0UnCVnJWpWbcsJILn9EsCdZONRdRFyRRHhimYKtVEqmVJ2XkFXxJ7Vw2Fmv9n1tT1EB0R8TfF46nDNcYmC3nyuUeuundr3hdwET8IRut4y1Mc9FBPgVviD+naGmLpiFrQN8qtXnyB7PMOBrJ7oshGDeImZy9xalzlVhoGKBQ4ma7AZNwe0wYIvnzQMxTxzm9mJBVrfdu2wa4pEBSpukDGLlO/EyyiMYX0zINwAzBPgi1eiVUf3+jDAb+eTC3FJzekV3CF4qP1OZ8yfXWj5ZeR3ra5VrxsdKSCgtdoV7DG2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(26005)(7696005)(6916009)(336012)(2616005)(47076005)(426003)(16526019)(54906003)(1076003)(8936002)(70586007)(70206006)(4326008)(8676002)(6666004)(356005)(40460700003)(316002)(5660300002)(508600001)(2906002)(86362001)(81166007)(36860700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:37.6741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a903e0-d042-46f2-3634-08da2d44c2fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3043
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

enable fclk ds, vcn ds and df cstate for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 12862866cf6a..710e66b38577 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -178,6 +178,9 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_VCN_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_FCLK_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DF_CSTATE_BIT);
 
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
-- 
2.35.1

