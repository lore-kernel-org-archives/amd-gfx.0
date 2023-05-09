Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE59DC7EE26
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B43B10E3E4;
	Tue,  9 May 2023 22:14:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10D610E1D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srrz4pg07bJUTse/0tUVEpgbUXf1kG5OajZwSSaThDSU1jOk88Nkne21mSLXk02/rPf2hw4543H5lexm3J5MDw+WxQtpXR3xtgNAHwZEtQF5KYZ/vQBbwsWiANyQH6r9AbFBLx/T9Tbcxd7MC+KFjiilfH5vAGcVOaERGJzQU/NQtsCYnObvXuukP4sKKBRRpvsIGEtw2X8YX5MAF01uH2tOpHP9QkjdRuH5cPmQJvn/z6l7tTxzBL1+wP8B3aS9vOOBK/dN2+c/jHfxrHZcUZuQTEkm75EnMiWSfQJ6+lkt5H3MnjpbrykSKnpg+AVhiiF40APrjkPrTQJSUg+0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYtPt5i4NPLLF4Kn39TGzK0cbFTzRF4/+oM7TNXorE4=;
 b=ZUSbhGGGXXMmjCtcuOxI8yxHBvgFfWkUUWeVu7zGzdbu1fHyV+mIRC/k7yefPACXT9dwGC8vLFNYa/gt5yjM3Gi3yQuEf5o05s1uWBvDPAvUL9RiUfj1nklkYkqGtPh1ZP546HL7zqSHxTK4G3ZKioWBkYky4Lt+uXJgV1qFZITCBDSGZCdpKowMpa0saYAEQjMDAHcb9x7mtrTueiXrP01zzzH1+X6GvnrN+ux2FEfZ9cpVmd6SqmdlCEbrGmkoPOITKQd/QjDiUtftOpzXno9C1UFg/UxuihjB9Khy1bWfPhpmGxjTCMStyyhQSCeFETRaeHUXiLQ0ow63WV+vrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYtPt5i4NPLLF4Kn39TGzK0cbFTzRF4/+oM7TNXorE4=;
 b=jbA+oJoYUr0q7rbvXrQ3MIgWponElepNmo1J7CoelvSsxpvR5gcUlpep4A/MgydnZ3F7NT1Btg7uqDRM0Cybas2cYXpMR+HBXGmJiFIOl+mZ1Jgh1fFwWbmugrQaVKA7q6J5v1UtOpknJ+2d03d6tkwvmT3cXB5ppitlu4jZZfI=
Received: from BN9PR03CA0584.namprd03.prod.outlook.com (2603:10b6:408:10d::19)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:25 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::82) by BN9PR03CA0584.outlook.office365.com
 (2603:10b6:408:10d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amdgpu: Add memory partitions to gmc
Date: Tue, 9 May 2023 18:14:00 -0400
Message-ID: <20230509221408.476829-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|BN9PR12MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 55038727-bad9-4be4-8816-08db50dabffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghFOgX5a9wso4ci9qWCQ7lQLQMtmgZbmCB1G2DPWfmLuLsTFaIecz53xLBAQU0XX8pDfWV6AgDsv02wY8BZg+BbEILYDv+311ijIjBKac/+VJ2o1lLIGuhMAl6UT2Xb4SO0sPhqTuFT7ngXbwRBYzOZL/O7kMXG5t0Vzfhy8yajywIGklrj7Rvp/fpx4J9e1YCMiLKs+7zk7dH/PzhwXSTdVAUO/W64JtPEGCNmVJNv/aLhja1BWgsL3WgDBOWQ701PR0Im9ORCkrsdsfciqx4xEp8t/D+LuRV1uOt1NkRvk84EyvHf3EBTWPXA6iMuz7xKJ4IRKmgXoX91X1TlKyfKfmITMtXFCq4+yl6VCFkEbj7jbIifLeuBCkirwnJjWfw5/0SSvIb9Z78jf74VJ8Cjm1g85TN2hQqRBZqbft0adBC6geTmR7/ozXy+fstYv9rV71I3FqbXsZ5+UAk4mmrpYXrNT4MJUXmnEM2iGpz45EDdlVackwyi1P0pDdSTbsWKm7h6zYPeMTAPNu7Yy6bAAuLnaAssdmrZbyL3oAAMZTLabjP5BjUHk97KhwGpRc0Ys/11+SPxXRV22Ek+sCWGYF8WWzCWFz/4P8zjXjJluZ4pNTBCwV2IwHusZteb6mFF8ngx1t2H2Xn/y7tWFotZF2IIPuj7/bnMsV6d+72vPiCcoMVsMnaFpBKoMkirEWEXkb20cH21xBh0k24kLEtEonEPY44uraRsDRvtqhog=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(6916009)(478600001)(4326008)(70586007)(7696005)(70206006)(54906003)(316002)(86362001)(36756003)(336012)(1076003)(36860700001)(26005)(2616005)(426003)(8676002)(8936002)(356005)(41300700001)(2906002)(47076005)(40480700001)(82310400005)(5660300002)(82740400003)(81166007)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:25.6613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55038727-bad9-4be4-8816-08db50dabffb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Some ASICs have the device memory divided into multiple partitions. The
parititions could be denoted by a numa node or by a range of pages.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 2bd3b9665ebf..43357d699e6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -178,6 +178,21 @@ struct amdgpu_xgmi {
 	struct amdgpu_xgmi_ras *ras;
 };
 
+struct amdgpu_mem_partition_info {
+	union {
+		struct {
+			uint32_t fpfn;
+			uint32_t lpfn;
+		} range;
+		struct {
+			int node;
+		} numa;
+	};
+	uint64_t size;
+};
+
+#define INVALID_PFN    -1
+
 struct amdgpu_gmc {
 	/* FB's physical address in MMIO space (for CPU to
 	 * map FB). This is different compared to the agp/
@@ -266,6 +281,8 @@ struct amdgpu_gmc {
 	bool tmz_enabled;
 	bool is_app_apu;
 
+	struct amdgpu_mem_partition_info *mem_partitions;
+	uint8_t num_mem_partitions;
 	const struct amdgpu_gmc_funcs	*gmc_funcs;
 
 	struct amdgpu_xgmi xgmi;
-- 
2.40.1

