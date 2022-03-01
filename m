Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384E9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 16:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05C910E5F3;
	Tue,  1 Mar 2022 16:01:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7C210E5F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 16:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGXedJZ+a0qyuPc9lo1G+NSPbd45cAJqHpayC0isUiyrJC6+GCZKRkPpPQg+SwYETx8ATAxMGHCK5/qRUDJXgmC00X/bYNbw9nBabBi+LPM7aCSeaWAWx6swLAIQN3OwPEfSTqJy0OUlua7iAkxEvuuZ/Pzn9+Bja3bTf5/dwhSiLsWzO55A5etTZZSqgFhzEhq/3id7UgNqYjCQCW/mBi0TmflfXt1I+PelSMzKvkSUc7f+DK+IxlVeLeHVogECMyB8HqU34cQU9qQitkHKXO9rF+0cL6hjURsshDGwutbolmhVmcFqJnubxuf1HAhb1EinexE0FSzMx3XP+KNSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PN8+qyxE00SOKyA8rLHvCYGga29AhZoSOS43IgGhiQ=;
 b=hQ4S7w02Oop6xqFmEUQEb+ehW1rbgw97b15PzX+WkVUTaXwI6vKP4/BRrl6vh+NY+E3yft1CYUW4C8lJDG0F7MP4zlBbJI06VnKbSIUWyMhZvBbKszGBgCM83Ry2X5nbqBD0xPlEuTHnnpG3sqKnXic1wEJluA2KEueRxb2eWZbjT5qVFsq5JUHMpmsyB2vT3a3H8qhKlf0noj2nbyjBkl2EIjKYHmICKX3Gf2ZhbngH5XjfF4rJ4/PT0YfgG2EFUtutl/5R7AekAtXUCDuN74jxRaalNI4X2BqCWkpaH0Kq4FPD0pt34+ASItuCGX7i3z+lr/MlnL/dPJUZRhblwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PN8+qyxE00SOKyA8rLHvCYGga29AhZoSOS43IgGhiQ=;
 b=Ninc993d6OfCwAoga3QvOM7d/N57Dfu5He25fSyjwNWJq7h98TDNX0oUCI0F7mOICXZQDbagoiHKgAEuQwxoTB2wIQ+PfqLE3jMtKtrR16gjKnGXU1gaFIAsJgc9UrLtPP9cr6fNaRqNZlE9dDVIUzSQZXxRRYvl51twbyCtY4k=
Received: from DM3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:0:50::32) by
 MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 16:01:29 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::a5) by DM3PR03CA0022.outlook.office365.com
 (2603:10b6:0:50::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Tue, 1 Mar 2022 16:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 16:01:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 10:01:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/gfx10: drop unused cyan skillfish firmware
Date: Tue, 1 Mar 2022 11:01:13 -0500
Message-ID: <20220301160114.1404305-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301160114.1404305-1-alexander.deucher@amd.com>
References: <20220301160114.1404305-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6e7837a-ccac-47ab-7bc2-08d9fb9cbf2a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4421:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB442117016D788ACED842FB71F7029@MN2PR12MB4421.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NL/6iYDeWF4fg1goIjZD5tNYtpQ7XouPDnH55anl/Mxf1YORybz2s4qtIFn8e/s8xVfFfqvDJR2Hep0zFwLv1Lumm41pKqmtx3ZjCJNPQMf7cZj3HBOh1SR0v6XPQO+TKt1swO4jQtzZnxxqzSKEDqzL1JJxNMqYS2kt110T7RfvY65D+a0oaHVLliXrzO+hq4VSZpaGkj7isHH8PgPpMh7OIaIQJSQBt9cTSabEjvkLYWvtLnUP70nVoikeYMsTBGsve8epX2L8dqENH4Z/oiwFSWzMdcTYxHVCDVafFsgeue0znb9Hbq1xDWBr5soEa49K97OR1z0r35KwNhj7OOMVTaIP4wH0Iwp+iDOUQrjz4EYC+f1T9jmGnds+L0YD4Fyb4U5PcgfumdxirW8vBBGqu0xB4RfZZ2W73QIqDjr6TN/CowCnwROcV0aajW7zOyCXLIr/90WY9lj0URnJim5EH/dRdUE4MJw/5e1YUX0/N18d/flIwmxovTEPhQGePVrBddgYNPxGpHSTi8ombto4MGkW2Zr/VHij2wZ/OrdUgyHkyXkfllDeObPvKi6PdNvPJ3MaFlcn2ct7h/gAkPDpfzTQAqpV72Od3qzMFW9CQ3sCLAyFvFJ8kDgrkQKKLKjNiytWgaIid3eJmAe9TmWGGlIuG7qZDCM8FIWD9qRny3+NOOTQP7MWBBzpo4gPKMfUqpcv3oOl4IN0XdmKRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(81166007)(6666004)(8936002)(36756003)(356005)(36860700001)(40460700003)(47076005)(83380400001)(508600001)(336012)(6916009)(426003)(1076003)(86362001)(5660300002)(316002)(16526019)(26005)(186003)(82310400004)(70206006)(70586007)(8676002)(2906002)(2616005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 16:01:28.9088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e7837a-ccac-47ab-7bc2-08d9fb9cbf2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leftover from bring up.  Not used anymore.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 90158289cd30..0f350a5c4bf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -250,13 +250,6 @@ MODULE_FIRMWARE("amdgpu/yellow_carp_mec.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_mec2.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_rlc.bin");
 
-MODULE_FIRMWARE("amdgpu/cyan_skillfish_ce.bin");
-MODULE_FIRMWARE("amdgpu/cyan_skillfish_pfp.bin");
-MODULE_FIRMWARE("amdgpu/cyan_skillfish_me.bin");
-MODULE_FIRMWARE("amdgpu/cyan_skillfish_mec.bin");
-MODULE_FIRMWARE("amdgpu/cyan_skillfish_mec2.bin");
-MODULE_FIRMWARE("amdgpu/cyan_skillfish_rlc.bin");
-
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_ce.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_pfp.bin");
 MODULE_FIRMWARE("amdgpu/cyan_skillfish2_me.bin");
@@ -4043,10 +4036,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(10, 1, 3):
 	case IP_VERSION(10, 1, 4):
-		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
-			chip_name = "cyan_skillfish2";
-		else
-			chip_name = "cyan_skillfish";
+		chip_name = "cyan_skillfish2";
 		break;
 	case IP_VERSION(10, 3, 7):
 		chip_name = "gc_10_3_7";
-- 
2.35.1

