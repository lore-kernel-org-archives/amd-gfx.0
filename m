Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0143C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 01:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E706E10E230;
	Wed, 12 Jan 2022 01:42:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82FC10E230
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 01:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIqVUJDo+hPLSoxngZEGGewR89Imdx0r0MslhhJmuQE+ZT1O2KbfXPNs+jQpB4IVCt5IJWmWHr7w50unotsxCafpI2z/BYUHhYGbDeeebhAbAwR2kcUWRmrJM07a55cVC33S1HYNw1pPDQjN7ZIMIYa4cm6kQbGZQn3UXh0shezlzs38Nx6cezDBFVw4u4su5buY5UWrNjbgV0ebG2/BY1hVWb0KiHgGMcFNPXR7WqoNgnQcpVcz83awdnO9/jLrpFDdx6/FGWtH+qdV1qrttl7ZL0/AuRvr3RIj3kwFKSHS4/d1Eiv9+eI+AUW5f0ipwmacGymmd6v03ObOoaGbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W401W9gPpHG97LO4C0MGqMtr8gyHDSFMA1QBjcPZ/Q=;
 b=QcYd+Vv8GXSbEAnVwUzW/LJcxY3GRXEXuxalzcv7+IyT4a4DX3CrDBZryZsxj4I7hVXcuwuIXzNjjAW9nTbnoykZhY67H9EmZNaNMdWL1F8DUtNZghMM5FunqtnzNLJgZTe+A6XiRZYpZPtcz8RKYY/gDuMQ06FcQ0YdvOMbWYQbA5n583NThACenj5x5ktgOClUAqKDqf+vGjbmmufGhrRvPu6gGVyolNqohhVUOkZnYS9Odu8IUNjEdcYanXyajBroTJCgHLLRJh0V3KhDHU+cUJsXtoGX6sJJ8DI7Jb3ulxR9vg2kn/WLtda68DUiPB4JaK21PQPEN3jeDfC1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W401W9gPpHG97LO4C0MGqMtr8gyHDSFMA1QBjcPZ/Q=;
 b=AKK0D9+H/o/hnSi5CR4ARMYNDPKRhrDg1VricAQG3mtLKNydY+LUUBIPuMzw4JgVUXlg/rFdcFCHqv6HDFOhitXESoGjVR0LjyWVcggG5mKuF/zHoawNEM1JtFiP+gKeOVYwSREgnGMFahSYOsB6LbwJ7KXRLf5zVEZZ4eWc7zg=
Received: from DM5PR06CA0052.namprd06.prod.outlook.com (2603:10b6:3:37::14) by
 BN6PR12MB1426.namprd12.prod.outlook.com (2603:10b6:404:22::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 01:42:48 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::d8) by DM5PR06CA0052.outlook.office365.com
 (2603:10b6:3:37::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Wed, 12 Jan 2022 01:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Wed, 12 Jan 2022 01:42:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 19:42:46 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 11 Jan 2022 19:42:44 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions
Date: Wed, 12 Jan 2022 09:42:43 +0800
Message-ID: <20220112014243.6959-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c223f05-2265-434f-1cfc-08d9d56cd685
X-MS-TrafficTypeDiagnostic: BN6PR12MB1426:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14261C77A69B9CA0FCD086069A529@BN6PR12MB1426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHdQ57pf3QZOj8dTCnHAw94otsRYZQ0B24hVsxjSuTt0mzGJ1aIIgQ2KqVV2yRPpiGLdXDd4r5VwlPiK9edkcbGBN0r5hPqyk6Mfh2E//D5JRQ1VnThSotH2iy25yLemx1iGlpoiDlCRd9tE63uXtGE59kd1eshKkvrrBlE+mSYHhSvBwdbPSUKsuDw6k5PN/zvnSnbTeBvyJJALoQXGwKi2rjRR5IMOGPk3t2JUUhzPEvGnGlIvSPMjb9WsKGDXO1sTbLkaxisJuBfy5bqwTsjMlv3mnwrNl/GyzhUzlwLwImuGX0rJv9pVOFUfq7WXUkGKkAzMkvih9/YIbJMlQU7cMF5Hb4+RYVMiMBJ2lNXLkjg1ZKMMGFEOUgypvsu5KEh256Oor2KrsnQz7O3nuO+6K5v7d4KqO87/NSypkt+b5KmzgisuPbwD8lUMmcSwbsv7Tivqc74rabN50JAq8pQBAJtT2993fkGTQj/afY/p7PS22G3vdQa+KoOtB0M57Wo8ubHS3zSU1xg8TaDWwHA+wlP5TQU/XQw5Nw8z0sCvWvZ76J+OPDq8v7S4Avg6rlF9phgki/VP7cnRLy+RgKONRND9mjhfV0euXGG8I3QfkRJgIZ1tIXrkB5ka2hM4ZiS5sHDEyZNd7ZOcTU4qut+3GA5HKbZVBpKn5oB4OOtVpOaliuaSVOdEGtHarI+nsKz9Uf8nPyzqolLWS5h+sTeeDLcRfu5KPion6a9hsjmBUJLb+SmYfsaCyvOn9rBIOTYZlUGR46CwpqGqRqwJpCHqtyrDid26vZR06YgepBM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(54906003)(81166007)(7696005)(186003)(356005)(8676002)(316002)(83380400001)(2906002)(6916009)(8936002)(82310400004)(40460700001)(4326008)(36860700001)(36756003)(86362001)(2616005)(70586007)(426003)(70206006)(26005)(508600001)(5660300002)(336012)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 01:42:48.1086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c223f05-2265-434f-1cfc-08d9d56cd685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1426
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>, Tao.Zhou1@amd.com,
 John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  |  3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c742d1aacf5a..8e0ea582b9c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1309,6 +1309,12 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
 		break;
 	case TA_RAS_STATUS__SUCCESS:
 		break;
+	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
+		if (ras_cmd->cmd_id == TA_RAS_COMMAND__TRIGGER_ERROR) {
+			dev_info(psp->adev->dev,
+					"RAS INFO: Inject error to critical region is not allowed\n");
+		}
+		break;
 	default:
 		dev_warn(psp->adev->dev,
 				"RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
@@ -1521,7 +1527,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	if (amdgpu_ras_intr_triggered())
 		return 0;
 
-	if (ras_cmd->ras_status)
+	if (ras_cmd->ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
+		return -EACCES;
+	else if (ras_cmd->ras_status)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e674dbed3615..8bdc2e85cb20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -449,7 +449,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 	}
 
 	if (ret)
-		return -EINVAL;
+		return ret;
 
 	return size;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 5093826a43d1..509d8a1945eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -64,7 +64,8 @@ enum ta_ras_status {
 	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            = 0xA016,
 	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             = 0xA017,
 	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          = 0xA018,
-	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019,
+	TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED          = 0xA01A
 };
 
 enum ta_ras_block {
-- 
2.17.1

