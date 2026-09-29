Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07421CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 02:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3E410E4A9;
	Tue, 29 Sep 2026 02:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F9F48fuU";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E1610E4A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 02:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKzMUJ2f2nrnmqLpxodJd0AQ6ggZD5ssMv02RhBY8+en1xWKqQgu069xxVnebEXW+6+qEfIWPxM7DhSvT325imkAmRKGWZ9ULL1AV3bxPFSZrhKVvdHYrXn+Fc/PREziaRK6R1ZvljnaAsMuoy/ifs7T5ad0Pyfn857Kl0k0yIyljMVzeF0F7W0scbo1k21KhS42//5rkSO27hAEcCHbf3LZC5gtOxZLy04ehdi/LHWp+12EU9iahA1209vKI9uWDa2TYmkH89zh9vqi7VgHIf7wV23YU9foVZUm9xTen9CzXHYvdQc4Rv324bSCo+5NZLqmtToYOB5sMVtl66tLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db5f1lBqJapPUCAu2cC5OkNIwqUKCi2EcGleuNf7w88=;
 b=vDd20FMWx0YsOjGH0WFS/5Am2kKebLl5r1gTSPZ9fTYAtqzswn6eo5P6vErF1oo9rwKgXkssjDS+qcZT9M6pS7GdoqrfdHyhWEBy7aVic6OW1Php6AZs0RcXg2z1JCa+Z/cNuJROyrxyFE8w4kNiLeNT7E+TNGxV/d8gZhF+dVFuM1nwG/bHyMk0BRucweJh2pWUdnAHJrm+dp+HPcxfDZpeDXRNcCi3HRbUX7GMdCKTnPcjurXNnKw1xlMSRAWulUq5OnZoDLKbxF30+AQOW4GWaJatoKtA6Cu6gDOmbEVLsk81XWvBcCWh2IyHtnzq26AP836KGyZ4VNsaySSwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db5f1lBqJapPUCAu2cC5OkNIwqUKCi2EcGleuNf7w88=;
 b=F9F48fuUy3V9hvOqQmsR9eVHmKlVvMm/OTUu/X56bvOeRVXQc5BvwYpqg/XbSBzavodXPNH1sCq7dKvF486fph5Im0N3V5TIJ8kz/1wLUgRpdGT3E2usauLXazbxNDW9udY7RLo52gqkIPZfCdSQVIED9tUS1XRAhjIHaQTAaFg=
Received: from BN9P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::20)
 by IA5PR12MB999277.namprd12.prod.outlook.com (2603:10b6:208:608::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 02:26:02 +0000
Received: from BN3PEPF00022BCD.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::19) by BN9P222CA0015.outlook.office365.com
 (2603:10b6:408:10c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Tue,
 29 Sep 2026 02:26:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCD.mail.protection.outlook.com (10.167.248.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 02:26:01 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 21:25:59 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
Date: Tue, 29 Sep 2026 10:25:40 +0800
Message-ID: <20260929022540.122318-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCD:EE_|IA5PR12MB999277:EE_
X-MS-Office365-Filtering-Correlation-Id: 29068eff-2b26-4f16-dadb-08df1dd10161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 2GU8XVMY2Ozm6Z74cYaKqq/N3fbkvYlJ0AJqSjKrOYGkwiB9//y1UBf3ktvTPCVoCpSb1EFIwiIxnG50pN+aDeLGV+eTo0QP4Y2BpUy7siH+EZLMVE4WlupNSdOMOZsJO3GkBuQ2Xjv3PYcGVQhqpimDuuaIMa7iQzjGiPVmiNpZL3QurDS1ZicsMF8bphfVQ+DNcnEB1yxJU/EsBBTwcqedGWVYqG3ZVedx2X+oit3nKB39Aho1i4+zIiaGiVg/7e2S1YnnVbwXdfobinCqVPrGuI5nSSLnsijz1USIow7SWT26Wb3l8obXk83aLKgshudib92gZWSSOyKDhFvDgUqGEEZsTug+RSAfmYf9/hwh2fDQmQGoIPs7WZMkanhzGWjC4RPnwWgx/hX1KmLuvpfyLl/vcBsnE6xiIVXvD5YYQVa2dZP9WeF4Sm9M2sDFmLecFDhiW6K1FhKBSWYCLm6dd+cuFycN1vHBJh1d3Xg/yC35v4KrF9ghUKgBrzbir8OlgzmsIQVdkuRhqI9Lb+k0SR3XxB12DtN8pSVuvUInH/OOKRINZnffBz64B2NIhJACz03zsbIUL83OUGCUC5Y8qfVZrpGjZO5JFDern23ODmevOPQCZhconAlJ6ThPW1vubLWlIm6gqhwN0OMWiWDBkqO9Nh6IFv5G3bjTYu3jCg4vkoeyT5oWE21OkEqkFjXKqhklUGQscFz2v3RyDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dzMSmFnh52JfecJA9z6fiofAvzrKZQVUQ3BPkvBB4gVcuWXJsHh0AUIJJ/N6bvr5kqOa6/50Ls4aHNNmqPA5hTgIIZWwO1tbreMUkSfyQd0yjQbUuHBmkJIrM+950LUMnXuAHRKkiRei6icdEIppnrGyxO/z7gieD6FsI5a6JLS904hMBBmpqggTrlmt5HkJGdOgDxk58uUjorMwKLEBQHjIBWBvSEk1GPWW5/TfMDId4G5KscKJGFhPHGOM9UxtzwCea3z235RzrKhA3uCDKyjIVFdSxFJBKNpqyMeceCcKZ2eul5yaBUlTzbMRITHYLG8XjT7cNjnijpUMWKpSAZHC4ozWNEVrhaqR4Uz9Q63EbDsSBj51U9zhZLOWxJEupdarbese2tS81rm0utDZpuFAZsPObi/P5z+2JB4aVpZ0IJQ7fxkfFT5qQi5Nv6vH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:26:01.8038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29068eff-2b26-4f16-dadb-08df1dd10161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999277
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

block GPU PCI bar access during mode1 reset on gfx12, to resolve
the random mode1 reset hang issue.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29 ++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 072d9c4e202d..25b9085ead71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct smu_context *smu,
 
 static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+	u16 saved_cmd, cmd;
 	int ret = 0;
 
 	ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
-	if (!ret) {
-		if (amdgpu_emu_mode == 1) {
-			msleep(50000);
-		} else {
-			/* disable mmio access while doing mode 1 reset*/
-			smu->adev->no_hw_access = true;
-			/* ensure no_hw_access is globally visible before any MMIO */
-			smp_mb();
-			msleep(1000);
-		}
+	if (ret)
+		return ret;
+
+	pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
+	cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
+	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
+
+	if (amdgpu_emu_mode == 1) {
+		msleep(50000);
+	} else {
+		/* disable mmio access while doing mode 1 reset*/
+		smu->adev->no_hw_access = true;
+		/* ensure no_hw_access is globally visible before any MMIO */
+		smp_mb();
+		msleep(1000);
 	}
 
+	pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
+
 	return ret;
 }
 
-- 
2.43.0

