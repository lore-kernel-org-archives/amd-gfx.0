Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4EEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 18:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46D36023D
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 18:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E46D36023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810ED89A0F;
	Wed, 27 Oct 2021 18:22:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D154589DA8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 18:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXAk5gdF5BL6IduiXqHPqfc8R659ydw0Zn9HCc+Bl6/iibemQUjKY8lb+FS6vhRPfg975/ozGn1tM1pWjUHDhcWoqAr0MoKB3lw7FZE2vGeUtQNc4E+s1t9P5Hpw5HooCl6DxR6eHdksSNMom/aPEKJLQ+8y8Ra5kOpzI1BZYWxA07NcYeCWeFHchh4kxV4grfzZVcBEsDZMC29VSfqSFtar3lH8jQWFHnV8X55QMaGO+PM/es3r1nTDD69b0VcLy+/GZCG96+YtCWOoJZMoMCHtuJWhK80tf90mIr3jVtY7kWqsLcjR4Ik8IlA2dnB2lPAUOBKr34KG+Jf68bVY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90PJHwR/hvT+HUflb/BybkzjNTU8J34KWX0Otrk9ZD0=;
 b=VIpCBcM3aUEWO1d3Gb4egrFIZ1vP/HFIwkxAc3tRG9Lg8x/L605obHv6c/+orDFR5A5v926caB/p51AVd/mm2S2vy0uGgxKYlMakYDlnA5caKhOMKgsAjJkEyWTk9ipXJj8Ndg0HcRf6YktUKzEexPdFxKh4/7y9dErALBqNfuwJ6eMc2ywLSL+rxcWWXB8JU5wZwv2k0niOyeKvKM1DWBDofwP5FJ0RAK+4682jkbPeBSdJeeGozeSX1wS9Q2AzWO+MqP6CTyoFIVy0YJz6PZ3+ELr+U5Dfixx7JZnTgPNE1R81ThCsIg3zGmc08iXoNvD/uvG+fqq9tzwUPmLIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90PJHwR/hvT+HUflb/BybkzjNTU8J34KWX0Otrk9ZD0=;
 b=TdKad9l1EcPCQW7vQuwNe7ON//tmakDyyryn6pTKfWl7JBeWPzcpg/zcvOSroleDh7CjKiXLYwJbxiPioJllmRSzV2M9pJXfo0WztGIeuc3iEENksaMyw6c5MAQ+zOvNzwqydFBX/ofVN6+zJAAhzrGuMu8CJB3JFa5H2Z6TXfs=
Received: from MWHPR17CA0061.namprd17.prod.outlook.com (2603:10b6:300:93::23)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 18:22:29 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::54) by MWHPR17CA0061.outlook.office365.com
 (2603:10b6:300:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Wed, 27 Oct 2021 18:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 18:22:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 13:22:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc6: fix DMA mask
Date: Wed, 27 Oct 2021 14:22:12 -0400
Message-ID: <20211027182212.1484689-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b57bd4-3319-4c02-0e13-08d99976bbe0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125FC5566C55B17BD114E5EF7859@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTLW0BxrE8r3C+l4awNv4WO3a85f9MMFJYg6SoeZgROdSoCYVh/fDkvtiToNLhPOv7kLzw3qpxFHhQpHyODBbT9EEOP/6su2l1G1QnSOXJxCEzbc5OHJoeG/57g1VrA/wEzyNrCVFIXxFLkProfZ/eKOIzaemFmScGOHLIKhO3+1lN4DXu8arY6yMruGjjEPNjZUBO3rn7BbDPLd2zBa/YO06R82ExHNzfukwHm7YV+AmPX7EvwtEy/tdpZuEsueKfcJL1afz3aKbyf8wn1FT5Kyfro6f0d36DdAd9C+da6OWONNtYA8S7jS42AK+nXTkW7t7zAAfWcYibnWT0Hsmdi6So41Gy+AQYQCzD8ShuUk4H8Q7YhapvSYs18tNDvgytVevHxSrj//SV4cvSPuL/qB7B2oIRaySx2lAcbUcqFTIn6hIucRMGh1N7hqUT4QUPEPiCSiDNB0yQ8/DbsTNEufCeLnxP3AnrxlpzGnLr6ErRowfD9vQKE7h6BK49O8/dDYMOHFqJSEyhfoB993us3347Rv2bIOcNLpluPCm0VeztefQIvLH15q4TfPIugpRFXRPNQXNIFIzJ6brZ9xx01Kpi/KwIDIXdPcjRg8mGq96/+PQr4XY8W8cjDVXpTGdmKlJRcfk8/iX3HVTEA8jVAoM80zxNKyNzU5D+ulxPPE6pNbUmBUBqBXxMZGqQYVslDi2ypnb7HK5ExjVb08Ab9w9BhOBxNBugDNka8g5tc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(426003)(2616005)(7696005)(1076003)(36756003)(47076005)(4744005)(8676002)(8936002)(508600001)(6916009)(2906002)(82310400003)(86362001)(316002)(81166007)(4326008)(186003)(70206006)(70586007)(5660300002)(26005)(16526019)(36860700001)(356005)(83380400001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 18:22:28.5320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b57bd4-3319-4c02-0e13-08d99976bbe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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

The DMA mask on SI parts is 40 bits not 44.  Looks like a copy
paste typo.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 0e81e03e9b49..a9354cb2d639 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -841,7 +841,7 @@ static int gmc_v6_0_sw_init(void *handle)
 
 	adev->gmc.mc_mask = 0xffffffffffULL;
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
 		dev_warn(adev->dev, "No suitable DMA available.\n");
 		return r;
-- 
2.31.1

