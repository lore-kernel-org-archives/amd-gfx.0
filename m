Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3C4C47DD9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 15:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2771F10F2BF;
	Mon, 22 Jan 2024 15:00:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1927E10F2C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 15:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/VJGIZUVy7plNpwUKq6sECBs3/o9jM9X5UXGl/JRANLrEU1e0BqTTWQuoCLG3nz3jScjuHQzY5DXsHmgSF8dCE8/LUaQNWxn7u3F2QEiorLcTS77lVeZEO2kmlJx5S7r4yjghmD5ZAZf3D0qRxMg7TFO4KnWu8rSIvPO0HuIo0QzCclI+zuULBdPx/B2Dm/vd0lERtjsw1IX5UPYf6u5LYRKk/+TSFsWETwFavcc/Jtj2NR4AaRJXnWSyK5yI3KEsMUWboOklCFWcMKI+qvs4OFMQhNrMX80FqiJXtur3ra4PcUX2Fa+UimEAA/3OOMBkhf1MSlhfRsaU6A5o3vBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmh1aJVGtQV0LQ/yqaCY5TUv7I2rS+3i1sInTPSI/mI=;
 b=Wo4nXZ75hhhL3jKMlPiBwaodlNK16FqQBjbVDI5SRckYRGYrSFUfXr7i7youp1MIkinMxOATN9fmZCGkLj3kLN7aZGcEmEgNY/QVIokRLsqNxGl78/gT9OaXqucJ1JDr2osnYuWgT1yVrFunWQLJ9Nku/drWv34rc/mNJXe6O8x94JlMcDYVBJ1s/Gr2gJI3jm3QwGYdTxIbI0jX8s3jr2QkxzTvZ/ZvcLT3pyuZWVCLL48P2Gz3P4iLKIWpLDIOHokQVRBGb97NZM9T9b7pnrw6Vj+bDUN7LnMqf3Jlyk3X/3Nx3SFQa6upM819TZndAqlXGraYYfc99LFZuVCnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmh1aJVGtQV0LQ/yqaCY5TUv7I2rS+3i1sInTPSI/mI=;
 b=4RsLQcumqvH6pPTI7GOIEix3n9srHVJ8SjvtVAB86qavD4zTe6C9nbYUFY5tWDg36PGest6VamJs/SiT/t9/7kMJbrD/s6a0oaQtYQrLwaW7tSMUXCDLyqjVJe6+/YDdK42xdX3a/GxiwsK8W2w1e6DKE+aXag27HMgn1cdc38o=
Received: from SA9PR13CA0078.namprd13.prod.outlook.com (2603:10b6:806:23::23)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 15:00:21 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::aa) by SA9PR13CA0078.outlook.office365.com
 (2603:10b6:806:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16 via Frontend
 Transport; Mon, 22 Jan 2024 15:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 15:00:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 09:00:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: covert some variable sized arrays to [] style
Date: Mon, 22 Jan 2024 10:00:01 -0500
Message-ID: <20240122150001.732948-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CO6PR12MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: d35a10ff-5fbf-4655-019e-08dc1b5ada98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qVpaSow/7v0nZLKK+pnrKBDxKRzKxud4cP1z59X8lVliA3JSU8B594slDm2GFASjjzrJb8HJ1jYKdzHBxSLsth9Umrn3hPT+HoYRCKceDrTcBEQzUu8Zi5rCkt+V+zInFeDQKKTAeUTofdTMKB7ZtB7J1LOT1tneToyZbOq9T3ioU+SX7NX2kexY+T1rfMg9v7F0aI/O0nnd3TQSKrBdv3CEmbfiU+Dmf1AvYKiPNPTm2HGwprJ8EpoosyOCstTPhYUZO6AwFF44Y0oDywVZkcMLQmGRdCMcfLMPIgSqWiYEdzBBoz8sbZloPK8+i6fuMi1PNkyqQ7HVqD/MOgIeIwrTFGLDshf1DNsX+8yOYofHj3fcyin0tmoP57v81l2gDgIsZVu7gu1C2E0S84sPbTAT13QsJUxaFj0K+yv7d5FTJeMdMeWgagQDha3nPLIRo50I+igxoOZGTrOeLe1aXPvfm+NG+tFSmmJImZ3Yf9C9Jn5JwtNEd31Pfnycz5DjneMx4YsO3nP9eB+ye1tclImXbJcYLYe90+441Q7IsrflX7g4i7BEZqfW7cnXJzaowM7PjVvkJUiQlWx+vV56GesGizkJW3YY3lVM8+A29ZvwtRO8TMImI7kUJnPC0B2BCEctz0Oq+EbcMfwLLH3BmrO2WbQTZrndaVhw4YQPyP9LEgxfL8DJtcgapEGsatpZhvG4h0g2VvyiapUE/6ez9K7tNuveOx5WWUCOAAozxi931K/mlyi0gX9Mhbez6Izy4uL3XVluYN0nOnRZR1pRCtpGj3U0OqHWoZiMrCijOc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(26005)(1076003)(2616005)(7696005)(426003)(6666004)(336012)(36860700001)(5660300002)(83380400001)(47076005)(4744005)(2906002)(41300700001)(966005)(478600001)(8936002)(4326008)(8676002)(70206006)(70586007)(316002)(6916009)(356005)(36756003)(86362001)(81166007)(82740400003)(16526019)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 15:00:20.7544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35a10ff-5fbf-4655-019e-08dc1b5ada98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace [1] with [].  Silences UBSAN warnings.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3107
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/pptable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index 5aac8d545bdc..ef3feb0b6674 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -491,7 +491,7 @@ typedef struct _ClockInfoArray{
     //sizeof(ATOM_PPLIB_CLOCK_INFO)
     UCHAR ucEntrySize;
     
-    UCHAR clockInfo[1];
+    UCHAR clockInfo[];
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
@@ -501,7 +501,7 @@ typedef struct _NonClockInfoArray{
     //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
     UCHAR ucEntrySize;
     
-    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
+    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
 }NonClockInfoArray;
 
 typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
-- 
2.42.0

