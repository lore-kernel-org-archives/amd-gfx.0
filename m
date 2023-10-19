Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECE9CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 03:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B6010E092;
	Thu, 19 Oct 2023 03:39:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4A010E092
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 03:39:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1mLH0SQuNH/9U3AEPJywILGYNIQEjxe1YmCLLxbSkXFFzqpBgLYpPKySacPMquPio3ywAxiRTW1L4lXbR3WD45kAwqw/7Q4xD1vQ7BJ7jGEb3fqIwrQHixbc+xjd7ytGtm2cCAGcvigXe+VdTS1Iu4uzSMrbuZ+HMxIW5ocdNiZ1gkxE0AKUiq14QRgMSmTh02svOQOpkMlA8Sl9gDhXjc2y8mrT5FpztklUmSofMPe/0JMVQoBfe1Wps09Bifut1IIdqIPO/7swzclc9d2qdX7q4aoBABHm0nlPzTfcDWR+8TXvI2H/JIQO4Nkb6NIyBaK0AFGY7wGWca9qV0SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA+EVoyTELGq4o0tJ2s59PNt8znqpZtHhNch3WLTpbY=;
 b=cLyXtlTrszNULi9epOVdbAA+Yqqfxpdo2ik3rmCmLaPIaEqgZV62/7I2rL/KZhbMBJX6IUmvDxhdX8mygRfEXYlgRy/ZeP1fMqz3YoZKBL2ZVUC18lChXvJXGf0aRQXJ+rJWp9EQ4R8rQNEvhBPvjztvWZhNsgDGxLk6SN8ewKXNyhD8VFkDi5VKQzkxImxZzt7+avT6GuOPKCMgHaKA5M3S9+w2Kf6DYuGuO1KZziyPHly22jJgYOVoJ5AKawLhEgly5qZg76GJ2hkTauTpwPbMEd/BXwRad8zGHXVBrJrWO0k/3pFCSFxtUYsnE1rek9LT/A7Eh0rSLx0QfG0MwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA+EVoyTELGq4o0tJ2s59PNt8znqpZtHhNch3WLTpbY=;
 b=vYfZ1Emonqhp2k0Y4cZkEZ0gqTlELpnPH/FziOZo8TAEbqwpYFTKx41FekvvHQwO9wet7cC+TCq7W70feLx5dOvsPBAnE3ah14imv41JSF1mK38+IGeXz4Fjx8z6Tb8ngqH1BnqBWgSdqz7/1igzSxFPr1/VAfJaI7JXeHw57w8=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 03:39:05 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c3) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Thu, 19 Oct 2023 03:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 03:39:05 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 18 Oct 2023 22:39:04 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: drop unneeded dpm features disablement for SMU
 14.0.0
Date: Thu, 19 Oct 2023 11:38:45 +0800
Message-ID: <20231019033845.3184809-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 3141fc4c-6a3e-4659-3740-08dbd054f1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWJHNGXlky0ll/hxiS6DWpu2pzYhrV7NaupVYRBlQfpHYjuzDT/1fv3L5j4sVu+MYsSQHT8DNRm9ADTEe3uwbxBz0QdH1mKIzHqCBFO3NBBezYaXXsGmBBgXF9FFyvaVtWSrSzIk1XQAAoH3IvLizZUpw3T1MjIwQojvkbMPD6nrADKx57l6pmvHlvWHokgT4QFCJPEnIdExh+HvtVcoClzxnYiAa33SbVkqCPavzBWUoxiaUpSSK9nT1JbuVFnVswYnCjt96xAUtmsedE7cU4qIJlwxT1oxPtZCXDH9RysBKLsbvfMy/rIwYwL0bTthRG5ANLj/2i3TtGKyWLkKSxxq1/f/ROXpehul9YumC/IGIxqFQcTfuKo9MIetqrMFFf77t1mbfrIkxTb0of9+cP6g+QgOA+BN/Lug9yUUgdPuWiS1hDSfNKCmyuO9IlzKGe4shogy2uhKmd+5vGwUQY+e3kHd2a48hov2S1tg8motteuO+OOHk0D2rRyroBQr8iTgNxOi8Swhq/y2LGMebcYUcSqDNikiwEFwKxicWEVozADO102LdmuHx6VM8B8tWERb9DNgXjcpvJY7jTvIrV9LM01w085ry34Zrmef41lGarh5WSfF4NFZdG/tlAX4frVwqw5zI/5ebbacGUBxqRLu52q/PAwMC4EkeakDmN1rKQvku9AGJqIKmixiChFhJyxf5eHw/CEk5EsyzEh45Hv35YGEe2lfx5qEpjEtiSsDw4esK1EhtXEJKvBXwgsQrzqv9N/dmd7TJE2c3mc8Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(40470700004)(46966006)(36840700001)(316002)(6916009)(40460700003)(356005)(81166007)(70206006)(4326008)(83380400001)(36756003)(70586007)(40480700001)(8676002)(8936002)(41300700001)(2876002)(2906002)(5660300002)(1076003)(16526019)(2616005)(478600001)(426003)(336012)(26005)(36860700001)(82740400003)(6666004)(7696005)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 03:39:05.6633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3141fc4c-6a3e-4659-3740-08dbd054f1e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

PMFW will handle the features disablement properly for gpu reset case,
driver involvement may cause some unexpected issues.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7c3356d6da5e..ace71abbbcf6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1677,13 +1677,14 @@ static int smu_disable_dpms(struct smu_context *smu)
 	}
 
 	/*
-	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
+	 * For SMU 13.0.4/11 and 14.0.0, PMFW will handle the features disablement properly
 	 * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
 	 */
 	if (amdgpu_in_reset(adev) || adev->in_s0ix) {
 		switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 		case IP_VERSION(13, 0, 4):
 		case IP_VERSION(13, 0, 11):
+		case IP_VERSION(14, 0, 0):
 			return 0;
 		default:
 			break;
-- 
2.25.1

