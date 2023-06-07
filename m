Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9970C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 06:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DBB10E43B;
	Wed,  7 Jun 2023 06:48:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA49D10E43B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 06:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YexXILMXyYqJLoqBgmYbzNEHZ6OPgRx4FQd04qJZCU+PG1vbCw/csMJmE1pnQu85F7/Ulz003838eQQ1a3DanDEN0S5xLY2eDFBKdCWF5TJjhayNpjXjsOUPZ8WBx5ZFBYPJNnAn+o2iJjRo6CdT5ibKz6Nr//r8Kz7EmHSgEBZjzy8cdHC8B4jb2J6YHVE7lA1liUZ3VoFY55kM+rhHjXORhFl1COSSvvTCWDqLimHOIFgU9vCnAFHfL9dkdRpOl7Y1mCSwQ7xytRxcGElXZT6qyz240X8vw1uWySZbipYds/SA70jKSigNk+OpIEMT92NKej3oSU4zUmQ5HmWs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETJ84dv3Vl1sLubdlQEwaEg2KS6Jat+J/mrZGAdgQJg=;
 b=PAFm5EYb/zynPFQpk8CfHsHSIJynvi0CaXvtGlJykCn7C2Pj9uoB/4AEiVX4bNWK3ROifBTZ0YvMju3ugSLRG/G4vyFlgnY9Ndv4L/iyv5bkigYPcWGXD4n6we96Wu+3nErIPj3ZS/tQpk0t0UWB0lALk1sZfqGWFCnzYFRW+TpZAArnZBVv1KzBajx6g1WuJ7ENjO0yMSRLeIJhhlO6Iqh1YqhWchSulptwcHWUP+1DHIu9U4eXq0Gv2IeDXKO+Qdgoc67tBmDzN5+Os25FC66Uvlgf7GDN58Jck6vTAdn4rLRK8Ny9ul3tfirY8TGziw3NYbLECWXbGLKKmB2VBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETJ84dv3Vl1sLubdlQEwaEg2KS6Jat+J/mrZGAdgQJg=;
 b=YC6ojFgbhNn8HKV+ADo7kHVqaU7YkbgW+sssH6n3kYW1OfShS2qQztAymjcjE83Btxsi/8ACmyPERtjR9T5p7kXRYkOUjQxQAg4KdOkUEKOKg7In9Dwyi4Qe153d/Ivsyw0IS6wcPkD7eO1zNGLBEAa6XewdqwG/xONflVE/N8M=
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 06:48:28 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::64) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 06:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 06:48:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:27 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:48:25 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 3/6] drm/amdgpu: Support setting EEPROM table version
Date: Wed, 7 Jun 2023 14:48:11 +0800
Message-ID: <20230607064814.27226-3-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607064814.27226-1-Stanley.Yang@amd.com>
References: <20230607064814.27226-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca91c74-0867-4ac6-65d2-08db672332f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LG801z1V8F5o6xJ8ryAW1Tj4ofPTmd+ShDrAoVjUHMJ9fpSkPEBxqiAgPjaePqIN3AOxt9Q/jEByVG2kNyGQo8V0jSgCHop8JYKBfzXntHJvr8D1VRcfLU+yyNHabAzWWzv/IeFEpmz6/rvDcsoGCf/VVaIG94OutDa6mgl/9k2zgIUf2TjnEMzPMNfBAdYLjR6cIdBJOOsuUNAmANj9bIcWyFA09822Y+gAFrF3gdylEpteB17jssZTJDPBOY9la+GMwXZWbpmpqbABeRYDTMETj5zRH2m5tlubPiMXSiI7ha40PRFbYLyEm2ovUWDfUzCuJmcrJrss9j8pf7qF8rwTcnvYK4ZqTfHpd6mHYgcLyGBj8w55oPtpvWbJwc9pVEeurhhrEo0JaoZUEh9iGCur/vIWhqkEcwaWmxn3fUfh8hdsKPH5SHujkbG2zSqvUdeE63o14XfobN01kFSOq8sIR8ZLMSwMejAIIVMuxYEvWiX/eh/DBoIM2ZYBx3mS30pKVbxYGPWbs/fsGY4qCM/G0fpOUpWAPIxFZYv21yOlSwFH4m0dWIfHMt0+LufjrA2pluBtWvY7FQamsOhjBCNCBbVIdRhiuvbppONbfRuCuhFb88DmlJlFl2qBfjuB7go7baamdf/uUs6O+oK+a+zby6St+83uOk0JIofydaiPpunVdl+kHPxOdWwPoDVPRoz9kh5BRDSx0Y45HxQGAjaooajFupLtQz8SUqAXiLw3uwMdeSAsFRHi2tp6Hh2dY1QzNrZLqUdIPHALXu/sQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(40460700003)(47076005)(336012)(426003)(2906002)(2616005)(36756003)(86362001)(82310400005)(356005)(81166007)(82740400003)(36860700001)(40480700001)(41300700001)(316002)(6666004)(5660300002)(8936002)(8676002)(7696005)(110136005)(478600001)(70586007)(70206006)(6636002)(4326008)(26005)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:48:27.9113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca91c74-0867-4ac6-65d2-08db672332f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add setting EEPROM table version interface for umcv8.10,
Add EEPROM table v2.1 to UMC v8.10.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 86133f77a9a4..43321f57f557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -59,6 +59,8 @@ struct amdgpu_umc_ras {
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
+	/* support different eeprom table version for different asic */
+	void (*set_eeprom_table_version)(struct amdgpu_ras_eeprom_table_header *hdr);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index d51ae0bc36f7..46bfdee79bfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -444,6 +444,11 @@ static void umc_v8_10_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 		umc_v8_10_ecc_info_query_error_address, ras_error_status);
 }
 
+static void umc_v8_10_set_eeprom_table_version(struct amdgpu_ras_eeprom_table_header *hdr)
+{
+	hdr->version = RAS_TABLE_VER_V2_1;
+}
+
 const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops = {
 	.query_ras_error_count = umc_v8_10_query_ras_error_count,
 	.query_ras_error_address = umc_v8_10_query_ras_error_address,
@@ -457,4 +462,5 @@ struct amdgpu_umc_ras umc_v8_10_ras = {
 	.query_ras_poison_mode = umc_v8_10_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v8_10_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v8_10_ecc_info_query_ras_error_address,
+	.set_eeprom_table_version = umc_v8_10_set_eeprom_table_version,
 };
-- 
2.17.1

