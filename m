Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE45C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 19:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4404810E669;
	Tue,  7 Nov 2023 19:32:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A9210E669
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 19:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8SDgIzJ1709ZKBBn+s4qZNjiqGVIh9mSJV893uhqmSFCACM6JHhi0LpZYwtNWCYtMHuLSy0JRbLiixdSVGkt7Mz38lnCtM88RRD7ptdfIK9A1mLzR3lpLjsgy6c1YQneU5mRzSZoy3xmvP10T1cnwtQQRuoguZiZpFncG8cO6MkNpOcLdje3LY24Add/pJ8n0xHh7wTjwll9gL2gI57tG0ZwjIgZDUWpHwlegET5qs2ASD0wM7d0UOtLHPAYWt4Zg9nm01VmJPBPNdWUS1upZALSOB7h+LPYxx3C7vZqWBGzCFv4PQaoQiLN9HuyNdCZGK4KdbKc+revBW/xH7wsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHxLldoBvt/TUzybDlEHJrlZrY11nMCaa79XbICyy9o=;
 b=HQPoFLrCm0L8UvfemzQmR8/0obVPAyF1nZvx2hdHzLdLvvZmMIlbBkHkzs6CvSLQcqoDTe2ysPjihAHhjJl9DxO4h6LgDecuZwlMBsYHBAkiuZjf0GG14vK66/jUV3fUTAlVkl5xKalGOan1d6T9VFHyukUI9xCE/NWue30S2T6+5p3ZmmFnPMCJMrhODezaSFnsSrN8Qp4e0fPf6mxENfIS0iUzXHXUCoYaBsJUaEbPlokvM1PZVkaKMfOHAnJNI/BeSwIrHLnwNbYbpKhMUgrg6mdZJ8HTQX/1njC16y/JcOgDHK+m86o90Ut88jgvxrqKjfUBaL1IExQt+eD9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHxLldoBvt/TUzybDlEHJrlZrY11nMCaa79XbICyy9o=;
 b=EoBNyZaZfpn6qAmefUtuiirnpW7mrH1UG/7dZr9CSqD9+82u3dHZ0Vkb8ucdtmFNj9y6CSi/R0+KBvm/IyZuupVT4l5gO5aZcovekcAuzmIcp0UvFAox1QABtILaFrXj8Sf79SYpYJTmXK5YcG3KCFgASNVIHB4hWWxYPfKjsvE=
Received: from DM6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:5:134::22)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:32:07 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::65) by DM6PR13CA0045.outlook.office365.com
 (2603:10b6:5:134::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Tue, 7 Nov 2023 19:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 19:32:06 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 13:32:05 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip PCTL0_MMHUB_DEEPSLEEP_IB write in jpegv4.0.3
 under SRIOV
Date: Tue, 7 Nov 2023 14:31:35 -0500
Message-ID: <20231107193135.2360-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ac9eca-4d6a-4d89-5483-08dbdfc83a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNyucG5qBzlV1JDyV0FDS/DrZRagpvpd6ZRlWUW0xv962/Pengg8+pxo1OAXo8kfhL31UWJVs0BLnow5F9DadM/IwU+18sAe7SgAG9zU2uU+wfzk1ijEOxYQFwBXyjLzT0dA13tM2QVCD/vE8TrEnIvvs/gxYQEBeWH0fyip0RWeiS7BqIg/Krq39rPWYc2IjUp4H/UmKAALYN3O6VbjZMBF4FiC/EWRZGUM30b97XkYtJLN/z+TL5jxt1JBM7oJY0vFuMle8DHW6UEPfoS252RlRTC/kHpEI4PWrXYyYGecTTV/WwkvnnTaRCKOvoneU4tcIznoXnl9l+aHNp3+cYHdJWkJoRD/NNDjWKMPP9wGGBhFHyj5UHEvIrbqRQATeR2cyOb4fvC10Wen0dYGaalFjBw2hYsAqqIObdJXVOmERxtwZGPWgFndKoZJUthk9q6lsr1hSFIgORn0QYyqJqjE0MJ3eL16ZH5GLvQsGOIzITPynLeezXRCoPSgkj3L9nlNMb8A7ywc+2BH2aZzMREvInlfRrEORH9MqM7nT/szFMY4VTWp6DAGFBR0ULsVkMb5q6v7CwryJWpHr5ypvUrOgPzzDzsM+EYTgyzdB4qVuevyuTxh8XvopoVX7GCJ/en3McaCOgltSwfp4p9EIwOtwyiYnmGOnv6Q69FBvT2pZ1wJ5pksAYO5MWg+/6gsZvoenoKcVyZ2+XZcRbGbI2wH6A2HnEtNGmaKuAQXGNZTdmBXSx6Fh+WCKG1p/WSAlNWznaLliL4EsGw0II+WUh2cGGuRVPYUyjKhoJHAbMiDQDTAWS2jMPixyiVryeE8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(40470700004)(36840700001)(46966006)(83380400001)(70206006)(1076003)(26005)(70586007)(2616005)(426003)(336012)(478600001)(16526019)(40480700001)(8936002)(6666004)(4326008)(8676002)(316002)(54906003)(6916009)(7696005)(47076005)(36860700001)(40460700003)(41300700001)(5660300002)(82740400003)(81166007)(356005)(86362001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:32:06.9865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ac9eca-4d6a-4d89-5483-08dbdfc83a7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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
Cc: samir.dhume@amd.com, Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PCTL0_MMHUB_DEEPSLEEP_IB is blocked for VF access

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 355d25fd6169..165448bed6c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -652,9 +652,11 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
  */
 static void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
 {
-	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
-		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
+	if (!amdgpu_sriov_vf(ring->adev)) {
+		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+			0, 0, PACKETJ_TYPE0));
+		amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
+	}
 
 	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
 		0, 0, PACKETJ_TYPE0));
@@ -670,9 +672,11 @@ static void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
  */
 static void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)
 {
-	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
-		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, 0x62a04);
+	if (!amdgpu_sriov_vf(ring->adev)) {
+		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+			0, 0, PACKETJ_TYPE0));
+		amdgpu_ring_write(ring, 0x62a04);
+	}
 
 	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
 		0, 0, PACKETJ_TYPE0));
-- 
2.34.1

