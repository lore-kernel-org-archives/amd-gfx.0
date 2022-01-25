Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACDFC5DF62
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 23:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB51010E167;
	Tue, 25 Jan 2022 23:35:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52B110E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 23:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG86yQjeCCgv3tLs0aVQR7GVqBmLAUHGnZ+lIKfet2rvul43I3ha87O8vbXjHl3oCljXkFAJctfr29UIYv9QBQbymMcXbqTQE0gc+XCvbk0GcewpAXk8aXrQTjwE1ooMpcVJcXVfpbYKFYluGNvtolKfdV7CxNnP23PUEtd5X2s/fLV/fbPJKeN7wVvCj8ZVvidLXPwNZBtT5EFzOHZblmcdMtr0zCyrA3P7XHfNIxtGjnDfHXW9ibvj2yc+R8sF8HepZCjIvpwu87HHzk5QN2HBYW7Typ9i2HaOQlXhITiN87zHJDAFbJ/muIQmp7QumfrYJLQQKRnnCU9VvSbZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOyHhFG4IkZ7b7d3CBfBejYvbmMsV0Oersm5Tfqm4cw=;
 b=lxZPOhD4h2vCznejD5yMdiUuktdKR7U/5DDnYqgtgRsGlKRza2rxyBc8FVbggVUXEywDcyD8G+qcNpW1O3k9z8WIRBvyMHwuy5ZZW3rEB47CcrL1SlxSfxoYNDX5hPPD4dWxfPmRUYaCiSd6TNHljPguDcmACX33P90NNWUFCZKFDFgrxwA7Rja0KSzla1HHZu99JGBHPgYzrYibEcW+mnjUi+SWTW1HwkMGxpz3ZSY1wBeTWUG16mdtr7WYPRMjMjWqFEgromdYfa6cMm9YoRrXK05Cql5zqJSYcmK7f21mHVFwM+H1E0jgOoA+M0UqpNBTXR+QX6+BUZxw7ECGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOyHhFG4IkZ7b7d3CBfBejYvbmMsV0Oersm5Tfqm4cw=;
 b=Kf+DqgGxAxXvJyWVIs7D2hPINcEfVDoK9JaqT6P+YGq+tH25PdWinPP7JcODa9TeVUqQaYlYIVH+ls3WaLPKUsNlzWXN8S/zLi7GjrGUH6M1YSI/MB5PbZlK4Ft27j4yp+cH1s4/Q5AZregi8wWRV1fFDqJdIAoarswqUavkxck=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 23:35:42 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::da) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Tue, 25 Jan 2022 23:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Tue, 25 Jan 2022 23:35:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 17:35:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] display/amd: decrease message verbosity about watermarks
 table failure
Date: Tue, 25 Jan 2022 17:35:47 -0600
Message-ID: <20220125233547.31314-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32c9dbba-cdd3-454d-f86d-08d9e05b6697
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2381D01D1997CED4CE177395E25F9@SN1PR12MB2381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaxnD8lKaAK/wNXRMBsnJlwC2BunyREHkEq6UwkrQIDc4v27Z5Qq8pVz38cTqL4ADVxtdkux1Yf2i+lg8yApkarP8WBOogH47QBMBGSAWf4zBM++Fg8l7xL25Rgd2kb47KHkcf4DbLAs7sijGtFsQXPjfyEwI4Ep3sNajflixMEKF76u6d8fujqI7yR2IqTzguUKxI79fJD4VjgPnHs8sdvrng0xMKLR9CXeXOL986evwCisHnUnJI1iDev37It9zkUlTDeZN7NlGzVkBnIw7olf+pmVfAJbkLYgmrnCMDqnGduCokO5GxulYm93hYK/u0+bVAmoltt5kD/UrESRbgxcFy8bgw9um5qx0PJA7VYI1+Z3MjDkdWhHIhiclUs8pmgG1LxPyFGohguIi+g0oguxXKidyxRU53SGxN9po4XY031uYBc66fEAAfE/RA5xyYz2p3BaUz+7Q9m9TowxEZn1xdC+nXdbL+I8ru3zQJsIerIkXnm5Z7xbL9s9af+wWJZbs/PwIuDtnf6qBH64Z88AQkUCl8+/vpjQO8vEgRNYPaeTDowEvVvosC/wCSJLxuSutMNxNPrc6A+cIpuPwAClxArp2580r9lPkbt57CUOKdL6Jl5qrLIWitvoAXl/r1J3j8HoVYjezsZGzuqtmodUYoIbZubpMG8fZQX/FIhMc3zMq56yH0JhigOLWFQumJe7we3X9gjPSypJux7P1X9BClT9RncTaPXZ9iGrvxptbgdH3N0WWaX5yA4Aup8IYlpTOeee8z25rs4p3OnelppgGeDVVTeMQo4668K4UF4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(47076005)(86362001)(356005)(36860700001)(7696005)(82310400004)(186003)(70586007)(83380400001)(508600001)(6916009)(336012)(1076003)(4326008)(426003)(16526019)(36756003)(40460700003)(26005)(19627235002)(316002)(54906003)(81166007)(8676002)(2906002)(2616005)(5660300002)(8936002)(44832011)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 23:35:41.7048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c9dbba-cdd3-454d-f86d-08d9e05b6697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2381
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
Cc: Nicholas.Kazlauskas@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A number of BIOS versions have a problem with the watermarks table not
being configured properly.  This manifests as a very scary looking warning
during resume from s0i3.  This should be harmless in most cases and is well
understood, so decrease the assertion to a clearer warning about the problem.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 162ae7186124..21d2cbc3cbb2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -120,7 +120,11 @@ int dcn31_smu_send_msg_with_param(
 	result = dcn31_smu_wait_for_response(clk_mgr, 10, 200000);
 
 	if (result == VBIOSSMC_Result_Failed) {
-		ASSERT(0);
+		if (msg_id == VBIOSSMC_MSG_TransferTableDram2Smu &&
+		    param == TABLE_WATERMARKS)
+			DC_LOG_WARNING("Watermarks table not configured properly by SMU");
+		else
+			ASSERT(0);
 		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
 		return -1;
 	}
-- 
2.25.1

