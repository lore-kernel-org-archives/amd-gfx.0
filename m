Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46487C27C40
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D2810E5D3;
	Thu, 24 Aug 2023 21:32:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2D410E5C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFChM9mWnV+ojp6ywiBnsELZN5LvcKX5vSj9oFmZjWa4DpTpbaJxSPheSVzCqQCCRuFUSB5ZChi1unEKeSxq0Uxdelr+e/nTvche1RKWM5w8up5sJEVikwaCIm6R1ptf+32UivYAGHLz3bMiDrXpdYm9OCVRY6mlW8Cz8flAMLV2zeKSpotOlI91Y6Unwodft9zs3BMvVu6eHAbQ3p0IolbySemi43++iJErVkXiU/acvvSSihX8MPhELrzZJDMlT8JvSaZJXveUfvJ7a90TnK8/7aujuAUWEpEetif5igc+aCfNVjccvsCdmuyPuwteOG5F6up/e6pdUmcbcE1Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/Nb4Jm7j7qPIM5Eb1yHtPJl/0EE88anpMWpLTfV1Wc=;
 b=K2Cl2NfceMPAaXL1bRroUCBxRR8UAIsyz0dvesiXQgnqK/SY5yD9GhrLkNThsdEa1/w51rRkojJYAzJeWsHDDkpoRnov0/oozsZydsXfgqeG86w9Z2rVjv8DnCsafHJYXTrXkKgYTe5nF/7cDhusDvPugo+JAZdqC4uJwiB+OrSnFXK207r+N6kHqYzKW+zyPN16EF3L2h/k+sy0dP3cwExOmGpdMuu9HV4Ug2E+hOjkpelUDWnq9O1VgonjWQ77gI4+81Hx+fGNa9hREYZRCqRSXPkcsqPZP6HdPsdxi+9lne9DEThvua1LZ4sTWu8GI4Nzsmkkyx48fARLbkOBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Nb4Jm7j7qPIM5Eb1yHtPJl/0EE88anpMWpLTfV1Wc=;
 b=yaG/q+jXWO0TuFKYbW9JQ95zKSa5u806iCa6W37VGWP2ylw7P3gU2dnW1K7xwrwCQcpdi5Z8HRsaS1iCMebTGovjeV9oWqR3da5K3JOSxUzSFAcVJImYTKTfeiaefb9CuR1XnmEf67ifxLb3ZLLRrQXnr2lzK9b6ZYYmpi7j1Xg=
Received: from SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::33)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:54 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ed) by SJ0P220CA0022.outlook.office365.com
 (2603:10b6:a03:41b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/21] drm/amdgpu: add nbio 7.11 callback for VPE
Date: Thu, 24 Aug 2023 17:31:22 -0400
Message-ID: <20230824213127.2725850-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 85796058-7490-4d05-1745-08dba4e98931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oglXlQvguYaPt0MTz+3gBqfvtEOY5i+D7ZtN49cmUgvDTdttWPjA3l7LDOl7pl15O+0jGSoemvVnbz6wsOEMy5tsF9VyCDUkne5LFKHozQRmtUbXueUr6dX1+VwnZCBtlldCmXLwJckBcM3Z/ht/Mkvsd0QNU/geU7dD0BcF1y4BwNLQWZQFXk2zW6Zas+ip4QSk3IpxDxr772dK8hD4E1DNVoflOT2B5PwMB/vO2GEpI/mHjCWsKiNnOS981e1fhn5p92wgN9QMRlOm5u0j2EO7EEoDaHIEvjTZ7SlyApQUyf9GrCM+72P/01z3KQhoRkeor3lkLd7nskoZclZYEzBCfWzkE4D8PeSgsEuDCvhQgRaKQrQJ1XL/zP7TnYaRc+6qTKgUKIjEopwMBvt1wFrOWsp35/lEb36QPO0O7ZhId+/RSKev1QWcZsk1MEXr36vjGucLvggSqY+GmyLlSR8DUtu0v3qlTrQPwWhUG9tA2aJxegyKV+q/xsbXjyYvFsZE3PhBj1rGZCadZ02RHsrLUW+aEuOyUddJgzlTw8Cd1fNoq7IjR20qub5N8UW+zEWWqyCVSvJA2iZmwddII4PrpJYAMN9QRWQOGvk88PB+HbnPYTUcAosJXZzbQck6fSxoqk2YIehoGiyEqU2LmwYrmkph7MbA4jNoabvvivKr/cEQ/sBVABoo67VitRsLdtMUMSXYuJU7yipoyIQsWy+Df+stMdaNxI0YibKX5g+Gs4JmYkt8p0BzIUR4/K3Up1STVs2HNpLISbTEaZsfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(81166007)(478600001)(40480700001)(16526019)(26005)(6666004)(82740400003)(41300700001)(7696005)(86362001)(2906002)(356005)(4326008)(8676002)(8936002)(83380400001)(2616005)(40460700003)(5660300002)(47076005)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:53.7525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85796058-7490-4d05-1745-08dba4e98931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add nbio callback to configure doorbell settings.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 7c08e5f95e97..5318f9c269c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -79,6 +79,29 @@ static void nbio_v7_11_sdma_doorbell_range(struct amdgpu_device *adev, int insta
 	WREG32_PCIE_PORT(reg, doorbell_range);
 }
 
+static void nbio_v7_11_vpe_doorbell_range(struct amdgpu_device *adev, int instance,
+					  bool use_doorbell, int doorbell_index,
+					  int doorbell_size)
+{
+	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VPE_DOORBELL_RANGE);
+	u32 doorbell_range = RREG32_PCIE_PORT(reg);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VPE_DOORBELL_RANGE,
+					       OFFSET, doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VPE_DOORBELL_RANGE,
+					       SIZE, doorbell_size);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VPE_DOORBELL_RANGE,
+					       SIZE, 0);
+	}
+
+	WREG32_PCIE_PORT(reg, doorbell_range);
+}
+
 static void nbio_v7_11_enable_doorbell_aperture(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -235,6 +258,7 @@ const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
 	.mc_access_enable = nbio_v7_11_mc_access_enable,
 	.get_memsize = nbio_v7_11_get_memsize,
 	.sdma_doorbell_range = nbio_v7_11_sdma_doorbell_range,
+	.vpe_doorbell_range = nbio_v7_11_vpe_doorbell_range,
 	.enable_doorbell_aperture = nbio_v7_11_enable_doorbell_aperture,
 	.enable_doorbell_selfring_aperture = nbio_v7_11_enable_doorbell_selfring_aperture,
 	.ih_doorbell_range = nbio_v7_11_ih_doorbell_range,
-- 
2.41.0

