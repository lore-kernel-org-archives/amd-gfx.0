Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66378C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBFF10F47D;
	Fri, 21 Aug 2026 19:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rATWfGES";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22AD110F47B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu+ibKuT8GuYteX83YGgMCRhwPdzArboTwa4DdenPffi5ZFzDSmvgiUhRug8X9bzGTe2vrRs2QU+ng5fXXBtpwbGbjcWH8FOGaNaiCjbcQLZKiZzIZE+c+FsVF1bQr9A2HEhS49EdlZJXMMXqqV2/KvSEH/L1QH+PCZZVnOZi1RlmGJAB8wjMu242AGAW9wzQ4vRnuusSvcoMgO/x3FKTd5Ihl9FXpkLBTb2/SoWINO7TOsl36N7/v+c+k11A3ELW0VtAIp1BgNxZ34hG/WRfUR/nmMiWYlP5hXyaLuXPoDpnTSCBVSynGW8tZ+IprHq1iIuJZh03iz76S4jm79HOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbRigKiBU0IfwCSBuYdpKxYPvIkZ/TNKXAUIyE5MEYQ=;
 b=a0BQl5zy7cIoPv2Cq/PJCsY9tNfcYvqgccP/bPVSDKHYBKGWyGNNnL457EWsPjY44biG7y2/daGSJFzDZqPC6acIHBZxt6OzDnM+R6AHxR7UeeT6kItgYKgdNx0MHX30NAi+kxD9ZFnOEAtTRBibCrESjvAJk2XIqXJAw8JpiEGS7fEnZ7ntzFkQ0HQN2jXN86KGBzEAyJzt6mbdENvAl2EZTo5hAfcdywcyuawDs43tzUTnmnAcuLF8UWnzXngADR/jD0Usv5tu34xsws9guW6sguy3GxOHuobeEm5MWslYnHn9O1fpbQgw2hsVWWkSdmEGSr4yirCyUcmPGhT95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbRigKiBU0IfwCSBuYdpKxYPvIkZ/TNKXAUIyE5MEYQ=;
 b=rATWfGESTlI8SQXGXD3gyBe8X28Eha+92IYiLSFgaxUO1LVnLPbFMD5BUS/nNwH0xY8plYgHBLixDXRMpPIcRR8tS3p64h9jYwcuZHpiFiUwyr9YlNk6vhJ0aJEHIWnWT/mgQ67QRd0EceZ51P70H3LaJ4RTKHjWKUdtpB1zD8w=
Received: from CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::6)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:29 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::31) by CH5P222CA0014.outlook.office365.com
 (2603:10b6:610:1ee::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 21/95] drm/amdgpu: extend PSP command polling sleep range
Date: Fri, 21 Aug 2026 15:33:44 -0400
Message-ID: <20260821193458.808626-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a394705-8970-4f07-5409-08deffbb5ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: leq8SDyBWetjcUQZCU78G6Fjz4D/I7LkhG3Bv0OUrwdf92Jhb5QmqHXCxmpUkzi1YY4WZ9RyQW7I/ijk0EnCivjdMSHp1JTw73h79isgOzWhWn4G06HR2OwkPhUGOpx7HYEkWMXkKy/dmkSx4YUSvYbSfH/c3lOmMlicepCnlwoV5WBtm2MC5eDcH50DJ8v5nQas6N87UZA+kKaga41AorVkcsSZlZEvy3tEBs1NVHjZjBgJsM0nNaDMEs/ILFbDnmzOeJCMdmh1wdyLsECaK0rOb1ZqX71QMAWPIHrRq8byGaWwDekQk6dHFAnxTa6YXnPGeaXbfVvUCDYVa6kCgp8p+RvoEMOtU9dK6qY6mHiOTe9plbQWiIR3LmxHPoPyF2ak/pRsOYC4TS/mUyyJYSP3W8/SAIMpX27mfGEs4u8b7MP+KRBEZQ8EdddzxPDTs1EU10skRwLO0ycmgNjXN7R5fPQK74xwdqLQZlXIBoDz3sOjWbGorgNX9TrBfMb5OIFfo3Tqus2cpXhJHZqzZlRagUNHdpPt/kQiDRwxUcUVEroXe1HXjTHic+EWotBKyyPIMkVO4WJHgpNHZU5c9iVUEGYqwjEPYpwKiKjBRlNSmfUA4oEKzNTQSIj/4ac087VDs6Ig2D+zzNc1KaT972CQ5ziTUr5YqCkRq49+SJhOc9HB/sYCR9uaXNjh8mp0A9O/VoJ/i9V3rU984XYMTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4/10XJYwEgOMQn1MItOJrQtEzBUJETnO1dVSzwJ5A2bZ57ZCJ7/DGON5Yg6XUmsoYLtgwRIyMrb+T8Magb4UU4pDfUo0lLyEj3/Dq8HcNRM6ZgT3de+6/jq58gO8W2JyZN5j1w6eIwvqh0G2TfzUQgTv3TpGVq2fHFKralu5AI/Qd7RpPIU+ocygCCvizmTCNcHkDwBGbn20D/d3rdiCftg2IctcTuOKy0dYwB+lk+EVtUDeRBJF49ObMBFdosLhL5i6SRrVJ8hkaXtAmJxagaWFE+X1z58ApypR8n1mBtXFmjkFAhsrOGjfnCBlBlsMOy85ILVcvrl9uvnppZckKTVH1/fb40G1OTB8dPEoDXRoA65zdbMz5Qw+As0ioUwZJQ7x5/52kMx4NwJP80cr3YC2APjxJpRTOBiAUguQAYgJLx+/gX6dqow7YK3qFCQb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:29.4365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a394705-8970-4f07-5409-08deffbb5ba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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

From: Le Ma <le.ma@amd.com>

Increase the upper bound of the PSP command polling sleep range to allow
more time for commands such as UAL_SET_STATION_CONFIG to complete before
the next status check.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6a66a90c8e5b3..b8def8b7e1426 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -895,7 +895,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		ras_intr = amdgpu_ras_intr_triggered();
 		if (ras_intr)
 			break;
-		usleep_range(60, 100);
+		usleep_range(60, 150);
 		amdgpu_device_invalidate_hdp(psp->adev, NULL);
 	}
 
-- 
2.55.0

