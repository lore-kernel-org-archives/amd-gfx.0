Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF6BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 03:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1D310EA82;
	Thu, 24 Feb 2022 03:46:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E5D10EA82
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 03:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxiT9fPvic9wK1wpndv/anujeMMXii51iixvP3HLHemqnJQR4BHI4pgpGS3/AXTmx3YZnRS+BbnJaZX+u+3MvwtXlRzyYypcNwxxTtdXfaS1PpYXpulFtwtuOSb3x17Mi3L+oguS2fOUMcBaJ4ggCTEEv21sqqKR9wLMV9y0JfYDuP05gnAeEydtmJW0UsHHNQHqpjcAtQ/9Igjg3F73Tq15TgfsAAEeohN9xN1ZnIldF0EL0GJTmB0IhO0SiFCYz3BEoIOXVrO6d7VgR+9EkPZsvXwBPGwPUNGBKn7W3wRb4tLfB0EFFO8qWPVcUlJo0E1LScYyR7OyZYOTWU//Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75Aza7VJTvVpbH+Es9I4VX3ZE4ugljw06wPdfY5gYCY=;
 b=Yr5m+wyFHwSAW1gEqdU5+jJAZK8HO6ZPp0dj2XsgQc5JgVHFAqVygQHHFTOsSj7zmNkQkeOX2353/G9gaSyEwEVXu4KFfZGwUBFH1/ofK9+Lki0iIcbfbhG/7QmNth4J/MjnNrxyezVcDKMoStiJKc+l1+g+a8+r6x0hkCo0buNC9Wj9kJ2uPom5+lpmWEFIrY9OznnxygEQWo4TKxC8ddk6n2NR4GDjkWeNg8n0Haul0xomfhGtMIeEtnyGOk4KVcmckvK0bI4NtrbrtmTTXr6kHE5ywiBkNGGnL538HKTNfpSZCaN3P6gpIV7dvd5SzdF4JMtSbqmatliGu/ToSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75Aza7VJTvVpbH+Es9I4VX3ZE4ugljw06wPdfY5gYCY=;
 b=4OSg/jPSPI3uUe+2b7W8RA6QhXX3ziJOCegMP19tlKkqHvsEwYvo/tPf22RQukaysqldJhl058YZG0S6C0ZoNJsot4kwo19NGhZjWGvEP7HaVRf01ICrqJksg00jCiCyqyFIiqicHXBX9F8cTIcpKIm+ywTPKupe5+xIeM6cLuk=
Received: from MWHPR18CA0025.namprd18.prod.outlook.com (2603:10b6:320:31::11)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.19; Thu, 24 Feb 2022 03:46:27 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::29) by MWHPR18CA0025.outlook.office365.com
 (2603:10b6:320:31::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.25 via Frontend
 Transport; Thu, 24 Feb 2022 03:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 03:46:26 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 21:46:23 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix mode2 reset fail for smu 13.0.5
Date: Thu, 24 Feb 2022 11:45:43 +0800
Message-ID: <20220224034543.1631630-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7933fd25-5dff-4795-dad1-08d9f7483bff
X-MS-TrafficTypeDiagnostic: DM4PR12MB5963:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB596382135278AF0CD98006D9C13D9@DM4PR12MB5963.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU+w40YoJZ3Yq197iO++stwNzj/lqGSCWNLDZasqOiSEQcFyHwtD7nDMe9/iBUHLK9bU5YQc+qrjg92OzNsmcpi7y/1Nb8se9dhfoEDJ2co2xULnGUuPhqlZS2e/lPuMvMt06x4XQuOPmRHQZMdUVWLjvehGMSXoVszOZ+UlEHy7h8Zxwj0Ajec3/q7HT/bLK9IQ/GNn8UF2WXGHdfxlj97+Y28s071bZydJOrDhu3jzq15TZZcY8l1a/CaMDR7OZC9TGtayIF4UgoCLnwvhu0NfqynJbQrAgyHvvU1MWfdTCyhi/1n821aGizR8zKZzEzzOZKiBOg4fRoWwjz+qSpLSndfBgdhQlS0552xqd4DT/4Lo+XVuqF4LYv258RUjm3uRaAsPWGwTyQaqwrgwnKQ7M+omYEcTMkrQ4Dnz4E6qSjJdRfd59nUGyK1BSoLViO2SBZZRkl7GeYsXqTXe4T8lmATA/X+fug9UJXBI0dau5V+VaN9NjzLq4W06H73u09qGOoQjHuDbs7C0Y0ptY/+tnamhJhs51sBTMJn2HbtchYuOquAP1ZGSLJdSAQoGqD9yuWrmnUAcUynHf4Fb4WoxrZJRxA07SiUDWLMS5etBqx5OnAxHcBUXhUbbRSm5AW2r3WvEzqoNN34iOIgNtcFjw3K1eV1qrCOHoy4fPQUJaPt4Hm+hFbSi1NnyCA1ZFsQXO28472pYjFp0l+Btsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(6666004)(40460700003)(6916009)(47076005)(86362001)(54906003)(7696005)(70206006)(426003)(186003)(26005)(36860700001)(4326008)(82310400004)(8676002)(316002)(356005)(2906002)(70586007)(8936002)(83380400001)(2616005)(81166007)(5660300002)(508600001)(36756003)(1076003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:46:26.4090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7933fd25-5dff-4795-dad1-08d9f7483bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU MSG index should be used as parameter.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 093b9144464b..8ee5bcb60370 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -245,14 +245,9 @@ static int smu_v13_0_5_post_smu_init(struct smu_context *smu)
 
 static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
 {
-	int ret = 0, index = 0;
-
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-				SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
+	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index, type, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to mode reset!\n");
 
-- 
2.25.1

