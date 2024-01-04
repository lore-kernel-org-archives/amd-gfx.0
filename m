Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B72C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 09:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B3D10E42F;
	Thu,  4 Jan 2024 09:27:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0A110E464
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 09:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmDBFfoyvhyaswSwMWzfU0kLKmDG+7x2h/Xjrjmk7eHIjtQqlloMLW00OLxuJd5SbexEjOtpv7wniB1ZJ+zDaxh3uU7Pqs48yzUviFRbwYkRb2Ns7QMaszu1K55Y+/IMRZxtFb8NSBp+XXRdJ+cuCzWhWnBGdW1RhFXcUbxQjibbrTA6caQ18lwj/OoSvQkRIUyBnaB02boLzNW3cUWLLurHYvG4F3eeqpE1ho3fzVWocURoZejBVNbM73vtC3NTnQ1T7nB1IscWf0x+3rS7R5saTiSQ1rNhqccxa+r3jtKQFy78m5qaDMY0vNpXa6Nx7ZkFpNPZvbYKBrE3dygNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGqGuzV2JS7Arx31X2B+U96CaJXznjmGo6i39D1owMY=;
 b=g4LlEiMIdwTJhLKQac7Q09g48HaGoDxi81poFd3UNHuqg3BC2zfq09dND6TL10a/DafpQqsGsoLj0P2jrfTr/+WFnc8skAr7vE2TtMg7oikFa81emNvP42v+P6t3oX8yJCrBRTc/4fBFD4fXSfrtSRHmYxSKm41kG6E16KKyp4rjsPDaB2PmYJ/kqCgxft+zyARNGGpBAmpGtiDmkwN2AXrQMu367LEVs4lrwHtnHiilM01lX3oc5vu/Zq35+tR+/DNIhoV0nQxQRCXmZdpbyQEWKKiLvrmwyxUAYAuUlh6UVcap/m+LL0VLDnK2HXjSuWGDWp8w/WIBX+JFhsLIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGqGuzV2JS7Arx31X2B+U96CaJXznjmGo6i39D1owMY=;
 b=RaLxAsAjkYWdojRpJys1CyO20ABLgcNEsIdpG4pJMI7eJ6YKZ0JNHSOnaciBkKBqtsdH4SHTab4cthSFV7X3GtoGmO6fbv5lBTdjzfvzJVRRyAUqE97iyflFvRxwyI/fCGZM74Aee0wpH9rIq1jobi38+jMEmxlwDVPawbrtmP4=
Received: from BYAPR21CA0020.namprd21.prod.outlook.com (2603:10b6:a03:114::30)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 09:26:54 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::38) by BYAPR21CA0020.outlook.office365.com
 (2603:10b6:a03:114::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 09:26:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 4 Jan 2024 03:26:50 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix '*fw' from request_firmware() not released
 in 'amdgpu_ucode_request()'
Date: Thu, 4 Jan 2024 14:56:37 +0530
Message-ID: <20240104092637.2353130-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5a5341-277b-4b0b-a390-08dc0d074a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: burzXANTktuJxjSDvtuHBkmpMq1pfZJRFI8fGJ5rvzZHjbXWjTQ+ae1onSbdwmBd1E7mix6nCFbpq9hep8YCc2brNsVPjuZCCYNtaOJMD4bunBMtphJaG8h9jHxyErq6pMj6sPW90Yinudn9zJw881VUNGwvUR5cfJVCPXHDSYUAUhdB3Ltblp6xU5B6u6jqnAM0KiWod8sy396yn56YntO7C1T1ot9VcwVyT4QHLYh9HFw3gD88qMruzaVrtVB5H+PwMRDR9w2TVM7HKwNlrM1XcwLIC7diSk/rZwJlHNLWdJbaoCkQeqlT2n1aj7ElfkWEOM0NP+KOa43X+xZOJAh22opTnn6Q+GXxDOd2H4CfhJbUT8aQSnewRp7JV+R68a+28dliuJoJshmVtOUOgb7neI9VLhSFaPjdaP+rJNwMoRvnNY0HVBm5JTakLFfKsaJtUcwlk4ysnmiEG/O3T2ug+RugUA+ZZY8G7jIR3UguHOHCN2F9x+duO1ZyG3lmBkkyfOPVB0ubHRxYx6r35PIvnX7/rPpJkUedRiPQXwYxqjhEWQ+C939sx8rXFeTDy92qfMvUFONLyzSmB9BythzNN+5pfhQ8lXcbJsl5NLemLiiWKmwpowrDK5uWE/B3FTR0dNJlULssm4Z8JpwonznQlYVKiLthoLRrE/d6Soki2yxSOWGYjMkxx2KYuPKL6omf09+c+1AIfVfrDzvmJkEDdie4svQlbhx0G/zejxqV73JWqxxG2y23ucJbut7tRbSGemHMJOmNrwqCMIlcfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(44832011)(4326008)(5660300002)(8936002)(8676002)(36756003)(2906002)(41300700001)(86362001)(7696005)(26005)(2616005)(81166007)(356005)(6666004)(478600001)(82740400003)(40480700001)(36860700001)(47076005)(1076003)(40460700003)(83380400001)(426003)(16526019)(66574015)(336012)(70206006)(70586007)(6636002)(316002)(110136005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:53.9802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5a5341-277b-4b0b-a390-08dc0d074a4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:1404 amdgpu_ucode_request() warn: '*fw' from request_firmware() not released on lines: 1404.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
   - Fix some indendations.
   - release the fw only when ucode validate fails.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 1f67914568f6..d30c39cd8bb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1395,12 +1395,15 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 			 const char *fw_name)
 {
 	int err = request_firmware(fw, fw_name, adev->dev);
-
 	if (err)
 		return -ENODEV;
+
 	err = amdgpu_ucode_validate(*fw);
-	if (err)
+	if (err) {
 		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
+		release_firmware(*fw);
+		*fw = NULL;
+	}
 
 	return err;
 }
-- 
2.34.1

