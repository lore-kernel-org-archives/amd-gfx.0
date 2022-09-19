Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B10BC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5925310E43D;
	Mon, 19 Sep 2022 02:03:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CE310E43D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRX0/osD85zYl47djv4ERH73DiCe4ypVEV8eZV2k26GuB8GHb11KhsIalUXV+eqLNGQvEdQd2L9EEZWQekVRo+Zuz5Qbc7sotAjiwMhG1AgSvJVxwg234kqoyBCTKFSo4m+gYw/Qw5+8Wu8seMb6FeslLAy5nJ+NjniXA+t2kxiV36RqJC2Prp598v1/inQxgo2cyEy0A9/nuvBBoOwEId23KRahLcaSDmqAip31TON00U+lYYF47RT0IpkUTv9FhDOeQeuDmaXny+e2P9UuDRdf0pJgKmrmyE28Qlp0mk+iTCN0/nM4A3E5Y1rf+f2RfVvRlSk9Ngncf8WokeCy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPdxZ5NUFqeLbo5BVUNyxzxIbBKrxzYxr3lBbPcVcoA=;
 b=FGb1ZeF0dCoYDYiob1VqKHEgjz3C52Hz9wsD2KzZCMLYXO4WUCATHLSbrHfKuBRNHEoPTeD5UCNXRLgqOE7LG3XwMKn6yQNnOXU3xswKCP5iZDmxyO6VkVwXABC6QyeYx+1Z/RHHDuY8fs9iGZO0M0qou0USu/ex8xHulCR8PrqlGGpWdFGxxMJ01NSFlGZFcDiWMAoyH+C9dg4ISP/BDSkhdq1rZsy4eYu1ZFBQOOSHzUNF3kZnbXhik5a0ctdnRGnHOA8RcAzl5FtJ59ePOd/drnYdud0pLk0OEeHj4bYcaqRaLXApMyJqX2m/3T8F6aG1/C8qQtgyBaHIuT5vSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPdxZ5NUFqeLbo5BVUNyxzxIbBKrxzYxr3lBbPcVcoA=;
 b=EqmD8M+bqC3OgQBcMvWzorhmB1qfLuNtZkvwjonKBHbkvEWNXoKrhNS9reCoQ32kRcoYks4LtYzTCnMO8mRDcMF+mSiNeyVLW86L8PIKT1xfDpH7+5u/GrQgyRHi9BXxduW0la9aIswu2Oj5I7R/0V4MmxeQyYRLtHeLPDv6HXU=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Mon, 19 Sep
 2022 02:03:31 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::b7) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19 via Frontend
 Transport; Mon, 19 Sep 2022 02:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 02:03:30 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 18 Sep
 2022 21:03:27 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/7] drm/amd/pm: revise the implementations for pptable
 retrieving
Date: Mon, 19 Sep 2022 10:02:47 +0800
Message-ID: <20220919020251.7048-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919020251.7048-1-evan.quan@amd.com>
References: <20220919020251.7048-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: d80b51b4-7494-4b44-2e9a-08da99e3264c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8W7jZydUPC0nkqFSzZATjUPdm4/iQ7WjldD7YWTgtgh281TdhcvSO/prnTkH1rxsc/bZYP+yLqbp5U+ZgBWLcHL1cGvFyf+9h4uCFmYD6awYo656UjNZayhLEZzCp5bsbhTNJzGrY1EE/WXw/W6RF84seAcEast6M703ufcCEcRe8UX5N9QpDpvbOVfjLrhC9sF7oZ4LBX6o/vnWhj4OMuyi4Uit9bDmPMf7JvZBD/nNQi8FFXxdC2vNLxS0e0CcVcSt8dz4PLpAFh5SCYJSLQ/mzqeh0hdJvjJeRpNhOdUArERnHjjfQYFZ/f1fPuS0O6DsQliWbU1PEsW8sqch5GdB5LNCa4f1aQ13a577qluwwZNVzGM/8Az4GvH2HEnnTEEQvXujffhWT/wGLDMI8Aasg3SuI9pibQSBjSSA4CEcpiPDORDmOC4izjtHhi5Q60Pua767xr9OaveRKL+YwQIeSc17W4aF83yoPACYLYMiPb879ed3nAoU3ey1BSZCShb38kKbhX7+kak6992bAVRZRAX/zMPb5n93EP7znuR6Vaj1Sxb4nzd5TFPdX2McaymRhFYfwt/SPnVtKT8BCPtJZIxTRdpMCYD4d4wYkEotg83T3B69ojlEX6QHSFtj1YQrn0myOuLXweCgQTlgiAXZAI2yNWcURarMBRhvC8t/LCW4PFCqeHXZ+Xguz5pbYaIk6tzYaShgsmr5IbkeHwA62zjoItWPa2xbd0X6RJ3AQjXSe18ymcpdycZltzALwqv268J7KE2pa5DKqXJZg3qmynaIAaVvtKPoAtp8RVYkgjXUtz4BNyqCgKVkhQT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(6916009)(316002)(8676002)(4326008)(40460700003)(70206006)(5660300002)(8936002)(356005)(81166007)(40480700001)(36756003)(44832011)(86362001)(70586007)(2906002)(426003)(1076003)(336012)(478600001)(2616005)(41300700001)(186003)(16526019)(82310400005)(26005)(6666004)(36860700001)(54906003)(7696005)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 02:03:30.3624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80b51b4-7494-4b44-2e9a-08da99e3264c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a new member to flag where to get the pptable. So that,
we can separate those ASIC specific ones from common helpers.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I814db70b5cedc225578bcb4988663de7dcf535af
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 31 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 14 ++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 48 ++++++-------------
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 13c5c7f1ecb9..610f9b68ef73 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1024,6 +1024,35 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 		smu->ppt_funcs->interrupt_work(smu);
 }
 
+static void smu_pptable_source_init(struct smu_context *smu)
+{
+	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+	case IP_VERSION(13, 0, 7):
+		smu->pptable_source = PPTABLE_SOURCE_PMFW;
+		smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
+		break;
+	case IP_VERSION(13, 0, 10):
+		smu->pptable_source = PPTABLE_SOURCE_INTERNAL_HARDCOPY;
+		smu->pptable_id = 6666;
+		break;
+	default:
+		smu->pptable_source = PPTABLE_SOURCE_VBIOS;
+		smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
+		break;
+	}
+
+	if (smu->ppt_funcs && smu->ppt_funcs->pptable_source_init)
+		smu->ppt_funcs->pptable_source_init(smu);
+
+	/* override pptable_id from driver parameter */
+	if (amdgpu_smu_pptable_id >= 0) {
+		dev_info(smu->adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
+		smu->pptable_id = amdgpu_smu_pptable_id;
+		smu->pptable_source = PPTABLE_SOURCE_INTERNAL_HARDCOPY;
+	}
+}
+
 static int smu_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1085,6 +1114,8 @@ static int smu_sw_init(void *handle)
 		return ret;
 	}
 
+	smu_pptable_source_init(smu);
+
 	ret = smu_init_pptable_microcode(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to setup pptable firmware!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index e2fa3b066b96..daa6be72bf00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -477,6 +477,12 @@ struct stb_context {
 
 #define WORKLOAD_POLICY_MAX 7
 
+enum smu_pptable_source {
+	PPTABLE_SOURCE_VBIOS,
+	PPTABLE_SOURCE_PMFW,
+	PPTABLE_SOURCE_INTERNAL_HARDCOPY,
+};
+
 struct smu_context
 {
 	struct amdgpu_device            *adev;
@@ -568,6 +574,9 @@ struct smu_context
 	u32 param_reg;
 	u32 msg_reg;
 	u32 resp_reg;
+
+	enum smu_pptable_source pptable_source;
+	int pptable_id;
 };
 
 struct i2c_adapter;
@@ -1335,6 +1344,11 @@ struct pptable_funcs {
 	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
 	 */
 	int (*init_pptable_microcode)(struct smu_context *smu);
+
+	/**
+	 * @pptable_source_init: Get the smu->pptable_source/pptable_id settings
+	 */
+	void (*pptable_source_init)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 53d26bca524a..e5d742c85416 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -196,7 +196,7 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	struct amdgpu_firmware_info *ucode = NULL;
-	uint32_t size = 0, pptable_id = 0;
+	uint32_t size = 0;
 	int ret = 0;
 	void *table;
 
@@ -210,23 +210,10 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 	if (!adev->scpm_enabled)
 		return 0;
 
-	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7)) ||
-	    (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)))
+	if (smu->pptable_source != PPTABLE_SOURCE_INTERNAL_HARDCOPY)
 		return 0;
 
-	/* override pptable_id from driver parameter */
-	if (amdgpu_smu_pptable_id >= 0) {
-		pptable_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
-	} else {
-		pptable_id = smu->smu_table.boot_values.pp_table_id;
-	}
-
-	/* "pptable_id == 0" means vbios carries the pptable. */
-	if (!pptable_id)
-		return 0;
-
-	ret = smu_v13_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+	ret = smu_v13_0_get_pptable_from_firmware(smu, &table, &size, smu->pptable_id);
 	if (ret)
 		return ret;
 
@@ -443,28 +430,23 @@ int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
 
 int smu_v13_0_setup_pptable(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t size = 0, pptable_id = 0;
+	uint32_t pptable_id = smu->pptable_id;
+	uint32_t size = 0;
 	void *table;
 	int ret = 0;
 
-	/* override pptable_id from driver parameter */
-	if (amdgpu_smu_pptable_id >= 0) {
-		pptable_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
-	} else {
-		pptable_id = smu->smu_table.boot_values.pp_table_id;
-
-		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
-			pptable_id = 6666;
-	}
-
-	/* force using vbios pptable in sriov mode */
-	if ((amdgpu_sriov_vf(adev) || !pptable_id) && (amdgpu_emu_mode != 1))
+	switch (smu->pptable_source) {
+	case PPTABLE_SOURCE_VBIOS:
 		ret = smu_v13_0_get_pptable_from_vbios(smu, &table, &size);
-	else
+		break;
+	case PPTABLE_SOURCE_INTERNAL_HARDCOPY:
 		ret = smu_v13_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
-
+		break;
+	case PPTABLE_SOURCE_PMFW:
+	default:
+		ret = -EINVAL;
+		break;
+	}
 	if (ret)
 		return ret;
 
-- 
2.34.1

