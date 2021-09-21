Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C40EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C2460527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3C2460527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A8D6EA92;
	Tue, 21 Sep 2021 18:08:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46DE6EA32
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arpiBMgioD2m13PElfQ6YIVpTv6kaiF4bBp+sAQESYeAeENuRWXq3mWg97F/e4Yfle2zrBO4ya5lptr38hrBblSfEjZqw2a17GJC1LtPt4fzXrCHV/afr9Fs3TJQOjaJH931b26jHPNqCi30JGAVlK+efojKG1wafjsi86Muvj9fwcnzPmLXd2dRn1PAbJ7c/L/kOyMiOTTJPYQecJHv5CyQKezQIs8hS41zVH4J3yMME6q6tgJK9/qGwYVAONLqenvgc7R7njTy7vN1Uv9kdBcutsRNWPCbuN4YLQ37wC/TyVyoH4Kvbf3xGUTxUD/rSqscLnLy3x/i00NfDnU3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=IU6RpdW+FHM2ZRxzlBrGBaFjU9xzv5rl/B2z5GKB0ZI=;
 b=hQkbftN4k3A0QQABH+9ZsdWAdlwngpix7j9tWO5j0Jd2X0nAOfN8r/8gfWlQ137wl1qFoF1R/9+QjWHLqtKJ9w4ikWk2CnAJ1h9qL1hvdn7mq/X+8cgzDVW5A+X/TQiwW76hThW68yvO/dn8NFTWwTK4TkI6ikDHkmn7T8sjjvT7AVZ9bBSNVm7bLugHKudt7NRREsvn7KyJK/PB/c8oWaJw/GcXvUOOBIAPF/bAvddmsgeMEWuF3KYMa9yXCkYdQriWbBPqh+rZYUXa1lCpdcvaW1Bq1vWqKslWQ2QOpW1TI72SQ1w7n2kArgwfFyCdjjbdcpsDTSj0bGQS0plTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU6RpdW+FHM2ZRxzlBrGBaFjU9xzv5rl/B2z5GKB0ZI=;
 b=u0mi/eUvUGS02/c1sWnSA6JF9D/Djo0HLtQXcGo4V/VcaGAcA/5Aa5ZPhgRgxR75CJgIdG0f4ZRpmR0asFgERePkcwi4+UdpC2xeNFCVdED2Ctu6fPQZZGJB+gQBL5vSCTNoICeSKYigR0T67QzgzGwMFWuRW9Z08wR8byB+qYM=
Received: from DM3PR14CA0127.namprd14.prod.outlook.com (2603:10b6:0:53::11) by
 CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:06 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::b6) by DM3PR14CA0127.outlook.office365.com
 (2603:10b6:0:53::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 47/66] drm/amdgpu/amdgpu_vcn: convert to IP version checking
Date: Tue, 21 Sep 2021 14:07:06 -0400
Message-ID: <20210921180725.1985552-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c8aefa-e352-44d4-9fcd-08d97d2ac17e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5474:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5474143F7D943613B8085847F7A19@CO6PR12MB5474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaueM2jXX4pUbWwTIb6qp1CHgCy4CzMZB9SmOyQU3AHlZ95Ay5DNnWz+2jACffnYm8KFpFXzvvyWsoFCs8u2xLSTrdwYSArPDUrxmEt67Xssbw+chm56ktdV22l/Liw9egkkSjUePkbhJOO/oddhDuctE/qxdJCZ/BF2z33v6IGTdEQ9IxQL2mlte3/aC8zrslUftUN/zfCw3qjVmgauwOecjWuqJPqWbREeLKDpNBVEA27S7cXpLnFm6+ACCeuaafkgdbM5LUm1niiRmKBi/ctiCGkcRZgIjtOR+4Ziv9y8z5rZbNKroPyNkSFkzIojPD4hJ4aaAdUY0aP2vhg/1Vw9KJ/RkkhBOsoigqGa94R2/i8YN3mhdtExSrk0qMQ3LSc7/kzqojahpAFPYsmSA0LCsSkNmX5QNzcDYtWJthfcqj8tq0s/umK0fThqMUqN3Xm5lTmG18q+l/G0Aapqz/j5m0SXzpSZt9H2w36gnz446YS45LJwJnxp6Sql6z7c5OaTOhH5ZLK4z3mqqBst+zhVrRL3gLBQeXD6PwwLQSnw4E39Wi+L7zH7DNmMyurouQzc2opuj1ejs7J9M6I5L+E0K0zh0nuv+bjj2D64egGpkr7xMhGspt6LLVqKdJnBGgpMwEeg8OMTAM5484IK0T7n1bPBckLVmczdocK28hfrGsG+XqWXvvMUlyvU2MBw1NJVxwBcN95OzzUPlRk1jDQ0OuxKUUMmQ/4ULHLApB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(47076005)(2906002)(336012)(316002)(8676002)(5660300002)(26005)(356005)(508600001)(36860700001)(16526019)(6916009)(86362001)(8936002)(70206006)(1076003)(70586007)(36756003)(83380400001)(81166007)(186003)(2616005)(4326008)(82310400003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:03.7235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c8aefa-e352-44d4-9fcd-08d97d2ac17e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate
IP version specific features.

v2: squash in fix for navy flounder and sienna cichlid

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 47 +++++++++++--------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b60b8fe5bf67..9724f5f5f702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -86,8 +86,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
+	switch (adev->ip_versions[UVD_HWIP]) {
+	case IP_VERSION(1, 0, 0):
+	case IP_VERSION(1, 0, 1):
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			fw_name = FIRMWARE_RAVEN2;
 		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
@@ -95,13 +96,13 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		else
 			fw_name = FIRMWARE_RAVEN;
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(2, 5, 0):
 		fw_name = FIRMWARE_ARCTURUS;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(2, 2, 0):
 		if (adev->apu_flags & AMD_APU_IS_RENOIR)
 			fw_name = FIRMWARE_RENOIR;
 		else
@@ -111,58 +112,52 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(2, 6, 0):
 		fw_name = FIRMWARE_ALDEBARAN;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_NAVI10:
+	case IP_VERSION(2, 0, 0):
 		fw_name = FIRMWARE_NAVI10;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_NAVI14:
-		fw_name = FIRMWARE_NAVI14;
-		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-			adev->vcn.indirect_sram = true;
-		break;
-	case CHIP_NAVI12:
-		fw_name = FIRMWARE_NAVI12;
-		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-			adev->vcn.indirect_sram = true;
-		break;
-	case CHIP_SIENNA_CICHLID:
-		fw_name = FIRMWARE_SIENNA_CICHLID;
+	case IP_VERSION(2, 0, 2):
+		if (adev->asic_type == CHIP_NAVI12)
+			fw_name = FIRMWARE_NAVI12;
+		else
+			fw_name = FIRMWARE_NAVI14;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-		fw_name = FIRMWARE_NAVY_FLOUNDER;
+	case IP_VERSION(3, 0, 0):
+		if (adev->ip_versions[GC_HWIP] == IP_VERSION(10, 3, 0))
+			fw_name = FIRMWARE_SIENNA_CICHLID;
+		else
+			fw_name = FIRMWARE_NAVY_FLOUNDER;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(3, 0, 2):
 		fw_name = FIRMWARE_VANGOGH;
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(3, 0, 16):
 		fw_name = FIRMWARE_DIMGREY_CAVEFISH;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(3, 0, 33):
 		fw_name = FIRMWARE_BEIGE_GOBY;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(3, 1, 1):
 		fw_name = FIRMWARE_YELLOW_CARP;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-- 
2.31.1

