Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668E3C61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 04:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2EE10E147;
	Tue, 21 Feb 2023 04:43:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A1810E147
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 04:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHeHNbQQ9xx5KPKFvTzKed85rMoMMID62+Cjp3VTvI/mN/BfLIFZAZg8D/6x0u6qO/BKMuOaXY1siaMeZpam3LXUdlUb/131DPdBYckogsXYWWAXjPn7joS+dcAbOnU2tE7Xx9qT+9TgeyfZZEXitadZuSK9+fJwQPtV0eihmvwRpGQToQbcekJLFCpJlZQQOYUOQNHaD62g/2LLyV0RBpUEL0eqyBT0H9la/Myyku5LHs9XaHc8jaSy+JiS8llbS7Zmc9wnzW1B/PxxtNnl+j+7c55NouEDcfnhSvZS08Eg3zoxwrL6lJ9Uxc7cxB+2zXjONx2hkEVWWcgifcCvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdgVBLvjWgY2fUwfkAYgnHAK/rPKkkKP225hGQ2+HyI=;
 b=O2bIGH8QtB2rr93PbwwLKaMxaNHQkvQRpAoUBPWbb7OZIm27a6Kb4EW4A1tN/zGynGYpgek08kFiIDUKPQRHSmCcvOQwrNdFIlFgGGFtQVJ6UlX5gBG3gxgFJkcev+uk6AWB85itXBXPU1ypd4Kk1qxZcc8kXqMHOINNnu4pCFklsT63zVx8CK2aKk9ylOnioKZVxiMu4hNONynEkwI0AH0a+H2liv/nlKrBofD5DtW2OT8Swagrpuhp3wTD0Y2j4mJBx/bm1maPFWV1GDvYc8txLJ2+NklaSSWtj21jSshhr1UzUnfhnRMjmJoJ/lJCwQFgCxheeipdtPD13Wc/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdgVBLvjWgY2fUwfkAYgnHAK/rPKkkKP225hGQ2+HyI=;
 b=EZKkiLASMBiNqpspP+9j4VgAJbArEKpm1l6Te+eTRVObyK6t0MzCz+p2FJYCZwZH3ZOBIOstEJ7g7upIuKI2i1LZfuZD44yfu1LmRUecfYtPH+zo2YUODNMnkqD6J0A9NUV6DMhQOVuAOz4lvMOnVysSF5msDD3S7ye7wIy/aCE=
Received: from DM6PR06CA0091.namprd06.prod.outlook.com (2603:10b6:5:336::24)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 04:43:01 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::b2) by DM6PR06CA0091.outlook.office365.com
 (2603:10b6:5:336::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 04:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Tue, 21 Feb 2023 04:43:00 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 20 Feb 2023 22:42:58 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: downgrade log level upon SMU IF version mismatch
Date: Tue, 21 Feb 2023 12:42:41 +0800
Message-ID: <20230221044241.4167588-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bfc6f3-e0c2-45c2-9f83-08db13c61cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Xs/tjZ7L/kIvvKWffl0BOv53xQF0yeRCOI/geqUUbkR5WRyM53V1zXFr3tK6OF2hMmDGgOaNlTOahZ6yKWyKrvTNF/folyw/nt5Ly8Cy2ZWKUahHQGNDlM6C0Vpsl3JaaFnrl1L0N7v9021otpxjL4q5c+COJ51PPBsjLEWfMPEki8mUTmcLAPNjyMELvafGYCw7U96YdIDneUZCZLzgF5a+gq8t9bREpRYmfE7xtMcQF26AhqCEaf9t1+L2D4PDhfDKjs6+DcsJafs45eFaME0lYFDALwqiRm8ve0ZBQ6Q5swnMoSZdjhR6ixBPxWE64cQgvHFpLFATtp10e4XPNqlGRK2zEr9pGxrjJi3jFB1fFfWAUxneTxH7F6oPbOvPdYZiRuSmYFBffUTDgUYmt9lN9ZVIUyzCvMuh3bpWrAAU4Y174Ww1t6W7ALQ1f+2L3iM9hSg81fRSzTQ25D1UjpID6WAH2A9avOaTwXvsKy+dHNWDY9EzhfcozrJMHEmpHntlWlx6Oa0hS/ZXNjfdn3rqotHCX6TC56Atm5JygqxRcBLcW4ojhx9qP3QImInwYfkCbZ7VnnTbDaPjiGvcbLqRWZuZpPuVxAjCEBQAmJLK0cWx0/Kj0rm1JPv36eCt8Ew2GO4GZtBhJH2+RWMV38IBbCJ38M6aOqRqUzC+tvqacF6cBpasqbH0yZ1UtbuUV7vbBnFk47W+w8Yg6OvqkLCQM9f2mJ2iTRNw6mqrN1DEefZanh4VOpcewUA+bxw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(16526019)(82740400003)(186003)(26005)(2906002)(41300700001)(356005)(81166007)(44832011)(1076003)(6666004)(5660300002)(2616005)(36860700001)(8936002)(478600001)(316002)(40460700003)(70206006)(70586007)(8676002)(336012)(86362001)(4326008)(82310400005)(7696005)(426003)(47076005)(40480700001)(36756003)(83380400001)(110136005)(6636002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 04:43:00.7868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bfc6f3-e0c2-45c2-9f83-08db13c61cad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU IF version mismatch as a warning message exists widely
after asic production, however, due to this log level setting,
such mismatch warning will be caught by automation test like
IGT and reported as a fake error after checking. As such mismatch
does not break anything, to reduce confusion, downgrade it from
dev_warn to dev_info.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 6492d69e2e60..e1ef88ee1ed3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -256,7 +256,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	 * to be backward compatible.
 	 * 2. New fw usually brings some optimizations. But that's visible
 	 * only on the paired driver.
-	 * Considering above, we just leave user a warning message instead
+	 * Considering above, we just leave user a verbal message instead
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
@@ -264,7 +264,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 			"smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 56a02bc60cee..c788aa7a99a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -93,7 +93,7 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 	 * to be backward compatible.
 	 * 2. New fw usually brings some optimizations. But that's visible
 	 * only on the paired driver.
-	 * Considering above, we just leave user a warning message instead
+	 * Considering above, we just leave user a verbal message instead
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
@@ -101,7 +101,7 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
 			"smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 78945e79dbee..25f336829840 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -311,7 +311,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	 * to be backward compatible.
 	 * 2. New fw usually brings some optimizations. But that's visible
 	 * only on the paired driver.
-	 * Considering above, we just leave user a warning message instead
+	 * Considering above, we just leave user a verbal message instead
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
@@ -319,7 +319,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(adev->dev, "SMU driver if version not matched\n");
+		dev_info(adev->dev, "SMU driver if version not matched\n");
 	}
 
 	return ret;
-- 
2.25.1

