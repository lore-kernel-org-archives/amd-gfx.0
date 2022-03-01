Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03D8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 12:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BFA10EAC7;
	Tue,  1 Mar 2022 12:30:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CDC410EAF5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 12:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPU0LZfEKEIWC7YlDn7AzRsEl9GflFIujlHcKpytLzaUv/RSRojSs83zOrj9zjHeVtfK20CO7ftbiFoLDzPg3jkOxFWPGGbU1WqWRMqkdL15HyS+aB3fDIoIPprLSCgQXDhLCWadwRNuYIhK5ZLA6ZDaSzw73+IGpNRn4xMJplTwKIoTfldw0tonuXP53M6QaHKO6bOO1FGJSNSJYGKdDxdwxpeFuvKT+gb9pt3BNvHfb15+2iADhz1ptTgPpjiRlU+bOI4PSxPigxXTFL6JICngilOu7EvSa0mgzqrvfaKOW0H/hDXYO7tRa2vUb+YXNFksyTnyvGk/j9ZKkeJCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EsPBWIFzoyGSO5jB8R5Luj+ZBFZavrUxst0w/GDkPA=;
 b=OCBbia4iHTY79TTrZR4a9ByMFP2YjCMytYANKHHmHQ9JHiTkuQ8ze7ZcNyYkS5yugR95UEk3WKsnc5BiQxhGut5+9085kwe8b9jkBcZiD9DV6NKQQT6dgaU4sGSiTpqNh+P7KjzFhH1m0nmesOWOM9QfMmGnJ3yiX9l1TnWV1voMKy/4CWsjG5C3rsQHCIQ4Q+aH80YW+znScgg3/6K3eHyKYz0vIqnRWsHOpq48X3+SiW/5vjVDTCK8y/+oCVFqu4Dnmr5KvOmPz/ZXBO71PgF7nXm/kv8kibKwwPwqQhNjpRScT82NcIsKnoiGRF3/WuPY0BtQW6640FtzzOXoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EsPBWIFzoyGSO5jB8R5Luj+ZBFZavrUxst0w/GDkPA=;
 b=WmMlYewdpP5xRFCsDcqHLGdQTGlSXRtFGGyTlY5Mp7WAAP7G2+JxiApM+dN3GUZxeEoE4+3QqjAiTiQu66Aoa74rE9WNQAZv3H9CRFjVNwuhTIqK30VHW6zQWM0fF7icj6XZcy88v5cLVxgeSoJdfdtF9gK+ynOvArCDTBF8vD4=
Received: from BN9PR03CA0522.namprd03.prod.outlook.com (2603:10b6:408:131::17)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 12:30:47 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::77) by BN9PR03CA0522.outlook.office365.com
 (2603:10b6:408:131::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 1 Mar 2022 12:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 12:30:46 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 06:30:45 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/nv: enable clock gating for GC 10.3.7 subblock
Date: Tue, 1 Mar 2022 20:28:12 +0800
Message-ID: <1646137694-12053-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08f95296-4be0-4dd3-66e3-08d9fb7f4fe8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4149:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4149AFE448E27D4BCF92BEADFB029@CH2PR12MB4149.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjBXcrUMBCzjRcZjLewxh+2ivPCppRNLm2oteJIlKOD2C4TkYoWCIW0EvynA9JuI3M73tzIrMJSMZbkVLX2CKIbRKdYZdnrIQXd+n/UGfuh2FCPvBtq2p7TB+qmQMvYWTBT9m15RakdjNV6bS4SaK2rAimrDPK/GP2GREmPfaoEr9SctBlITQlKhsnA1YUeWaTU4gRv2mUHlgNqipdVHskeHJLjvU1HAWm5EHYn3Mv52l3/cttyOn+XhgSshZCItWuVV+6K0mSxM0Rd4SN2sBRtIcuMWCG1dyqGuxi8Lq4D9NfhFgI+GoyE32uJnCknIrV8rd6/JwzNNPWBDH3i2ZSzRIvW0Wc2uZUhOY2Rtl+Qisk/48bCXYGpfz+8JMk3vSljIWXVJ8z3Quva6TzQKB0d574G1pfPnR47E3Clh0/WFByyKZSoRijl8vn6QJZAOPFrZmxYe95jh2hfDvVCvCCGzrbr3Y3EjQJ3oxJNNsCOQ7Sg420KIIvD7jtc0rK+9zr735Zt/0z3JcITQqDmVwyuK88Zc6ArzUbm+MSfm9fyvMFDInVy12/j/aQaLLnRHcYHmBPgmng4T4zuwA86Bb299E9JKgNeDaeVlPnTgpBWzT6QFJ8vI+NJSfjNNCOGp+Nh75nHUAmGMOCAxrkwGzd+15WcrWhzN9WgpfIGZM9E/Tj2hhcv5YeYcfz7l5ZKBN7hWQ9+cpCLzblWXLGDX4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(81166007)(6666004)(82310400004)(2906002)(86362001)(83380400001)(36860700001)(4326008)(316002)(8676002)(47076005)(7696005)(70586007)(70206006)(40460700003)(54906003)(5660300002)(356005)(16526019)(186003)(26005)(8936002)(6916009)(508600001)(336012)(426003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 12:30:46.9059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f95296-4be0-4dd3-66e3-08d9fb7f4fe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will enable the following block clock gating.

 - MC
 - SDMA
 - HDP
 - ATHUB
 - IH
 - VCN/JPEG

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index f6aeef759ee1..05487894120a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -946,7 +946,17 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
 			AMD_CG_SUPPORT_GFX_RLC_LS |
 			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_FGCG;
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-- 
2.17.1

