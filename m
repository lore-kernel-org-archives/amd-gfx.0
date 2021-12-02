Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEE0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51126E992;
	Thu,  2 Dec 2021 03:10:36 +0000 (UTC)
X-Greylist: delayed 1366 seconds by postgrey-1.36 at gabe;
 Thu, 02 Dec 2021 03:10:35 UTC
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342136E96D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxsJHo/4MXmsE5pSrK2tbt09WTTYXue7yzZatvHWIdevYMePDGL6FN58S7P3swp0IpMEnPf+ANjhAR9kCf7k1qe8pBEAW+ccWjG5JaDeDgXwwPD/X4o5pmBh4yBPHrCh9JF67R1P+r2ZUYNHcbqY7DzQ5eGkno943rNhOS+XTvXFeDn5uTewUg1ACY2IAIZ+20obzFAKonNm/9oHb8D17tbBCUSSJ42ZVW6+6QrPnWpRikPeH62wmhrqsfOlJblJOSvGY2uEBR+jNlVHvJNOo/BSesa8seDXJUnUdr0zkTpKPREWd8IdIE3f2t92jQFrHY1rxlktcebo/WoV9yGL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pypR1+vuPSp42o3+eIHIcEbEAXWpRUWqFeHzvJV+XO0=;
 b=cECiQBuMJFjtSGOjfrYUSgg86lVzXi3qRM36XCv3o4cW/yOcZwYn9FODiNyN37Qmplr6jS3oTDUwRGXko5R6ukyxLmzLmuCtt3GtKv929sk1EjiaAcAq4QYDNAr8OBlp75iUWPMRvJN80muewYDfjUC12+Sk/isc7mSmSG/taVEn/IN4M7tGW+F1masjWJMbmINPsgLfJljbOuiTxn2m9/PVLw8EldSU4OSfNyhRNHMN+C2OVZEWvGHHGgDJZEvXq9X6w4WXJusKhky0liYcH9iSzgSd4Cmw1jwf6/FJRgnySSlkapV5Pxt+fhvOes46ETYG0VxxnSW+y75v/iG7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pypR1+vuPSp42o3+eIHIcEbEAXWpRUWqFeHzvJV+XO0=;
 b=IhYtcslv+MNCMtwTVEf4OMyJfRBn1wZBZ1x9GiBNzrG5OjSIF+9DcJScckNyEncEesTkEQ8dndaOkJ9aGSuc+Ygwt2/e2KV9heHM3pfncNQfOil0qBKm3mQOdQoFF7sfOpV28Z618Qp29BQkFNl37788Z9SU8wrs3vwp0ie5KkE=
Received: from DM6PR07CA0098.namprd07.prod.outlook.com (2603:10b6:5:337::31)
 by DM4PR12MB5280.namprd12.prod.outlook.com (2603:10b6:5:39d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Thu, 2 Dec
 2021 03:10:32 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::d3) by DM6PR07CA0098.outlook.office365.com
 (2603:10b6:5:337::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:30 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 15/17] drm/amd/pm: drop unnecessary gfxoff controls
Date: Thu, 2 Dec 2021 11:09:28 +0800
Message-ID: <20211202030930.1681278-16-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd5da80e-c199-49a4-7c0a-08d9b5414d8a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5280:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5280D990E32F19BC062EE344E4699@DM4PR12MB5280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4g+73ySuyGNO7jVesgzd4gluHKgcMJGX2RBPSsle3mhq4vFoKoepOg6wTQ2yjYKbN5Wx2qN/xVNz/TbY0CR7Z0K2jCvfQgov7EH/f+EaOeUaqM+yXrqzjhG+DRi81qph+3PDNqutfEtvwQjZnc0xFkqsfo+P/kZrA8q8Uh3PVHRCWPnQiYXqBfY1drep8fk9F3NIr9Y3E+rlrbB+KX/skB84gUODHB6FGWf6CzOav8QlHmGx/QHhC/8nLJ938LaOjjOE3FIeFGyiPNlXbJAQe19cBqhKKUcZqy86LWPg9BZr3ghOwy38btir0ACXX/24gAA6JtIF9G1MaMb+2YWl6/vMSVjEzSIdftVaTtFNlFq6ETT4KFiNfTYbiyo4yHiSwMdxrYNOc9Homc7b2x0pBXe2hXk8IGG/yWA9EitjYNMbJchrnOb3UEkJkh5QXH50sxoKY04RhUpiPYRJ/sXavUIj+/IIWKwDlnnvH2zvACnm5BNXGdob6tt60cGU6Vlg+De0h0Mcb+B3q4iIqUwDFEXcW0WmbSy87eXRxPb2eqJnS5ls5yZLT+UdRzsKCpbjoJ1zUhAkPnJj3xc8Tq8r4lX3t0+eHC6tl9xLA4Zro6HhYAFv+fjg25BsaWnz4OlU3tGxIgv3Xw9rJa6TwQSwcLhNgOat4fodLrD8IrUmxZWTpN3VvMfuLipf1AiG39T7WV76ZPcGEEAeh5nc5Qzmymv186fuQJmcC4sCSIvdfDUGewFav5VRn/vPjDMXq47hNuhQa8j30uZldzt1GUf8Fz1Wwr4NJKiB+Z+/NwKqi1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(86362001)(47076005)(70206006)(70586007)(16526019)(54906003)(26005)(508600001)(186003)(1076003)(7696005)(6916009)(4326008)(44832011)(426003)(8936002)(316002)(36756003)(336012)(2616005)(82310400004)(8676002)(81166007)(5660300002)(40460700001)(356005)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:32.7080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5da80e-c199-49a4-7c0a-08d9b5414d8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5280
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those gfxoff controls added for some specific ASICs are unnecessary.
The functionalities are not affected without them. Also to align with
other ASICs, they should also be dropped.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia8475ef9e97635441aca5e0a7693e2a515498523
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +------------------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  7 ------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  7 ------
 4 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 70fc6bb00d1f..1edc71dde3e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1541,8 +1541,6 @@ static int smu_reset(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
-	amdgpu_gfx_off_ctrl(smu->adev, false);
-
 	ret = smu_hw_fini(adev);
 	if (ret)
 		return ret;
@@ -1555,8 +1553,6 @@ static int smu_reset(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	amdgpu_gfx_off_ctrl(smu->adev, true);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6a5064f4ea86..9766870987db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1036,10 +1036,6 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		/* no need to disable gfxoff when retrieving the current gfxclk */
-		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-			amdgpu_gfx_off_ctrl(adev, false);
-
 		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			goto print_clk_out;
@@ -1168,25 +1164,18 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	}
 
 print_clk_out:
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return size;
 }
 
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type, uint32_t mask)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint32_t soft_min_level = 0, soft_max_level = 0, min_freq = 0, max_freq = 0;
 
 	soft_min_level = mask ? (ffs(mask) - 1) : 0;
 	soft_max_level = mask ? (fls(mask) - 1) : 0;
 
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -1220,9 +1209,6 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	}
 
 forec_level_out:
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return 0;
 }
 
@@ -1865,16 +1851,7 @@ static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 				enum smu_clk_type clk_type,
 				uint32_t *min, uint32_t *max)
 {
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-	ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	return ret;
+	return smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
 }
 
 static void sienna_cichlid_dump_od_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 2a53b5b1d261..fd188ee3ab54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1798,7 +1798,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  uint32_t min,
 					  uint32_t max)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
@@ -1811,9 +1810,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	if (clk_id < 0)
 		return clk_id;
 
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
@@ -1831,9 +1827,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 out:
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4ed01e9d88fb..1635916be851 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1528,7 +1528,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  uint32_t min,
 					  uint32_t max)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
@@ -1541,9 +1540,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 	if (clk_id < 0)
 		return clk_id;
 
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
@@ -1561,9 +1557,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 out:
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return ret;
 }
 
-- 
2.29.0

