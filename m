Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98197C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 18:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0983A10E3D1;
	Mon, 27 Nov 2023 18:40:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AFD10E3D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 18:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APaD2ucUZXM3ilIJAI+ZuUE9200KEO/hC5xibn6srKELrjlvDDoxpjACbJh1RD9ekUdYvo/GXlg1EEoBBYrnO70OkxO91ZKnmPbBJ8w4fhBUuVSaeuoOQhg4QIEcWo8PUgNy+qfKDMiC1F3PTo7FG5a7lVipfwTn0T1G45djwgE5s7ZLUWFIdODu5a3TDwbszv40AR+mbQFUMgr+ZdGreifHWczkg86qXafFVvvc0icMvqZFTxYLCob6UqTceihP/v3JPiT3kFg1YrlAXvlydBsEs/RmWwp1iEjrWM+tkR9aTK0OA/ySXNi3+ygjKdMnyRinX7x2rQVZy9grjnmCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BceoZAOih0P0mgyWRQE6Mk6OEXrZ+s3BJTw5EMrRkYA=;
 b=Sa+pRHlM63TRdwPJMS7/9X3fUP4s6JSwq2jloNaWlxpJsyCv6WDCOTa2pvtgTJhlATmSqJmsS7X3e5dXbrY+WogJXKp1m+xeadYpu8YQ/gSx9OAe+/gnqz8FpfM0hTiF+KdjvM2W1eeZVW4ItAyKDQu8QUrBiYJZsTECVCILytFVfUzy0aiTxXcfUxs17xBsjvZ/VMRm26lKUN/Oq5E4RbBCsqbRiF1cX7RyGbAP56K2PlLfy+njfHp+NvZ0jr+BKp8Kj1Pb85H4DzWjlFVjH/Ag56dK0YNb6JeuAadIUxOSC5tFQ+/ZlKNG2nHNaGmzPx/Ao6sqEU1iWQjxYMkXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BceoZAOih0P0mgyWRQE6Mk6OEXrZ+s3BJTw5EMrRkYA=;
 b=ckGf5Mr8M9wJWQmK8jAYGkYJGpyo/uDDa5R2syIaafhVp1oIJou6bKobYIwZ16zGRbLQAa0v5tSqkmKmTSDr7vGXPZ2vVVv9KGA1i5NnGiL/X+5KcstXg0An+C/7kmJZuM2ibgI6O5awXFTG2QIhQVj2kAVUdUdApvdB6ExwDUs=
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 18:40:25 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::76) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.26 via Frontend
 Transport; Mon, 27 Nov 2023 18:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 18:40:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 12:40:24 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Enable PCIe PME from D3
Date: Mon, 27 Nov 2023 12:40:01 -0600
Message-ID: <20231127184001.3306-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 906a5883-7278-4252-a2b6-08dbef7851e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDhCDw48pWG0fxDKtJ+Q7b/oeJDQuaWCD8qV4jBxF9qDNqR68gkZhtehmsYBR0MzGUO0nNsyhUzR2bsG8oUhAW155tZI+t3RSIDA8F9r+GeMqCJ+jzga9o3pk1RUy180CJ/j4aHMfbqa9sCd0f8tySnPwdEKs8EnIjBXi/TYwfWeTOSrtSCTCGNO4gS0YQtx3xAAqiey00NygjNb5XHJ/XEGRLZcpNxp0tZxxwE7/mZIMwbS2I6HqYJdCTMjCBXxxK5ZPWXX7ladD/MJaikhHBq+A4fJipGik1pZc25FHEZBH8IDFljzSxZE559BEbUJmEyN8HI1aU1U1cH+/iVRYw83EBbZZNOuCyXar7uy0qCskorUodrPHQSdnnHBSbH89bqL6gVqgknF34/SK7uAmAlvNiMc2RJ6Fkq6fjiImWljzuxqIEu4BfBBWkCa46A8KH27uGz8OAtkAL1knSjoCNdBznewBXw8jpjaa6+kgctUravtcbkAzG4pKBbwSvVRJZAYCbM2NMfGSmDaCmOlUmTTSqWMd1zfr4+I4C4fxQxAbKeDM3O8wrC/SQs9d/rgq6QFspWlGBhMl4bePaF7WErRyjP6/3yAGZJUXbNDmZ2ErottdeQjSjVtziA5vETiSndztboAI3j269xV+mdg4mBo6WMTrL05EjFpon2/Td4humWSzHO6sq4Wq8F8KtqqvvM1vOZq3y8xPoHDlrLXYRkztqKZ7Uogbk6bUPUrb/nli5u19Av7MiAjlTeohv7Y12o8fxthIpXymAfY57NI9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(36756003)(86362001)(1076003)(81166007)(356005)(47076005)(4744005)(83380400001)(5660300002)(336012)(426003)(82740400003)(16526019)(26005)(44832011)(36860700001)(2616005)(40480700001)(2906002)(7696005)(6666004)(8676002)(4326008)(8936002)(40460700003)(478600001)(70206006)(70586007)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 18:40:25.1212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906a5883-7278-4252-a2b6-08dbef7851e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When dGPU is put into BOCO it may be in D3cold but still able send
PME on display hotplug event. For this to work it must be enabled
as wake source from D3.

When runpm is enabled use pci_wake_from_d3() to mark wakeup as
enabled by default.

Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5d009175318e..08763f6de482 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2263,6 +2263,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
 
+		pci_wake_from_d3(pdev, TRUE);
+
 		/*
 		 * For runpm implemented via BACO, PMFW will handle the
 		 * timing for BACO in and out:
-- 
2.34.1

