Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B62CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FD061168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1FD061168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8844B6EA94;
	Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAAD66EA3D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OatvHbJbZFElygleexDzs2n/66HHAKVfrfmaWoc/zjsJRedZ62pbHz4Je1bp109UmNDJRUSsPyvJqc+PBK9Uvrd0FUfoZtvmxWrjyuQebuGi9h/sv82e/kaEps70oRtA0Ps0CYkathV4BtKsY1fD0jrRueXpjQl/hrCD+ufh8F3yV0tvnocGpgo9foRViFeKQTV0c3AEstKI+kao/OyVmE/lV2tuCE+A6izKEQcdp8Rk9XLtUQolmq+RNUH2aVGXnzCmOTxjp8uBPZsdJKJsYFB3KUiPYThy9gPpM20FFkiBt4I7AUfMbk0p9gCwsWizMYZ52N36d33OujTDbWMcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=I7T1H2Qixm5meh735RNu5M1OfLKCuXPz52CuK8ehIdM=;
 b=XgoLg+N5NmrBWC7wV2zcoir2iTM1EbyU47kh4H3Uo2z16OmZB0ZJ79e4zIZvQplXjmmmdaMfIMQVXTXqcbhnjIlpN8rGv/CzUbm+tgTjOJ54umnrweHKWwR8r9S/JrWyEPG05BsHB9Dgku8urnq4Yx0klalNQ7KRfv+4dAWy2jvg/UEhjDx0y/0NVCV0AsGQ/wpaCpIAIPCjlqdLyrXPMd5niSt0iWy91wcRAcWWSLxwaLNk3jsIfAMXMCONNDO/Mx7NPgmWJkX8KQA7bVLcOy+SuwvPqD07QvaaaJoywLvjvZ+otfz+M/RyhcNl4M05t72vMYszAPC722YMyEYZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7T1H2Qixm5meh735RNu5M1OfLKCuXPz52CuK8ehIdM=;
 b=wsvdzUnjexu4Iew/huZqvuykwnfTTw4eeMScdtrfOUwmuCAJXxne3rH8Yrv7LclhVSUIHMxlqGaHH36RfkjlYjxMsFhlGDf+1w0pWaBQs9E2UpwtK4HYXEU/3MlbEuC1t4dVsBQjA0kipTxA8PiZ9rPAOtcZrDgCsNaCNuLoGsg=
Received: from DM5PR11CA0007.namprd11.prod.outlook.com (2603:10b6:3:115::17)
 by MN2PR12MB3069.namprd12.prod.outlook.com (2603:10b6:208:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 18:07:52 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::36) by DM5PR11CA0007.outlook.office365.com
 (2603:10b6:3:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/66] drm/amdgpu/athub2.1: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:40 -0400
Message-ID: <20210921180725.1985552-22-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ccb3e690-4174-4d13-b278-08d97d2aba9f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3069:
X-Microsoft-Antispam-PRVS: <MN2PR12MB306965BAE47A719B112C863BF7A19@MN2PR12MB3069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vm0t+N1et+wKJHnOgbBi1LG9oURpiOFLx2G3hmh1eKnYI5PV4rJ/oiNwQj1BaZN6CwmLhsuSqNNUrGQaXCO6QA1jSuYSCnFDYNHzI7PaFboNipx3X2IiMAKfj2OukHUW8E3JC6PMinepPl45o7Sw8BEnc5+vhwmoGoPEskRg3b63lu8Nwq8JDRu1liw57J2oE1crqR0HvGngopqh0wNIzVvPpRD1A2hbGhH/HZzE9xMmN5mIJZAne9mKe7G5ejIxEfQKyPtEG8kb5mnnLeMHNglz4YgiS72/ihTU7nHdTK31+/OI9LYHyOLs1wKBKgvPJGHvv2qUixegcTIDWVd+OSR641uiPipwaVBgIIX1iKs9GFlabFZey4+ybdO5A+ONLwYD6eb5m5OEB3Cf3ihNg7wuQWG6/REEDMHfIpwamWMZ1JkP/VLQ9upaC2GAV89XTjE6OhQ0EJJg4/JFB0XMuQRNEHCcQl5QzF1BcXsce0nrU1DJHRcL8/N8gP3EB4Zy6aEWa95vIJ+SQQFgX5VhUjEsaO7QABdJ5qQ0cNmIWuFHO67m469ozPpPq6AdSTBGyVWHHI1vSZoZ6wS2wnXRn4WloMUdSoaiy6mZ16w31hMx2mSndxQ0z1t2MfeJClDn5wUGwHa0DbLzq+p08ipLTlr+JCqlS2cShkVY36nJPFCkYu9hHed+fkqEQHd6L1P8PNZG+Tifaa7YzYWshTBfylfIq5+O7JEvNYh/0QgPmoE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(4326008)(6916009)(8676002)(2616005)(316002)(2906002)(8936002)(47076005)(83380400001)(7696005)(16526019)(186003)(36860700001)(26005)(426003)(82310400003)(81166007)(1076003)(36756003)(70206006)(5660300002)(508600001)(70586007)(356005)(6666004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:52.1952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb3e690-4174-4d13-b278-08d97d2aba9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
index c12c2900732b..0fbeaf05204e 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -70,11 +70,10 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[ATHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		athub_v2_1_update_medium_grain_clock_gating(adev, state == AMD_CG_STATE_GATE);
 		athub_v2_1_update_medium_grain_light_sleep(adev, state == AMD_CG_STATE_GATE);
 		break;
-- 
2.31.1

