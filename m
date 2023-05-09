Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A45AC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 828DC10E3F4;
	Tue,  9 May 2023 22:07:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F3F10E3F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiGRLeBwg+MfbbTAul9DKNghxFJGY8ALux4fSziw3PyCHID9RR92yThVWWS0lcvgP3mS65ZwkGC/9d6DFs8ie09/4tOSyAV0uB2m8L4VO3MZioBSf6YOaqE9vmrSbZQaDpKxwDbkqOtrf3N5LLEpjLoFv4KqhMmkDv+exF3aMpRF5CKwDMRYMpSLRxQLlhJZMLdOEh/xZNu+5tdBxczkx3Q9os352Jg6XQ2vRckH1aLbFMvGnRgYOhfOJLYgoMkpGfOPymjI0dgm6qXSxS71B/hqXvHoVXga8uxx1IDcncj/zt2uXjLt0vXQ1QnpehIygt6oTwgBfukCcTQUmL2FMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNx8Zw6Waw1gSyq5d355pwHVY0aNwmBzxJAwJYTXQdA=;
 b=SX51VJY6E0GHv+fst6+M/JqNgiX3QDS/waKc4abMgLE51UO6J2NRZnfp2v7SHx5rMgkiqw6UT7ijvt5sOUIoT9+dTEPeCmu+BQJgMcWx3scqjegv6gGYWewsqt3MwUgnnwprHnQOkv4fMH31XpV1ZRvvCOqoN0f5JUoBZhSsYa3aRuBLzegPYnz+jjsuZDgxE0/AqUWpmNNG6QfDNp2IbtP1eNwoTYdFGxwYnxbKb2bDTaoRwYz4QluCSrCabhl1e9KHfKHtaghbe75g9OlZoIXoqXmyeX0Dnh2kdjPzu/kB19auaAw1FwnK2ZM/UdEKrX+4q4bCDzJKTq79/lux+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNx8Zw6Waw1gSyq5d355pwHVY0aNwmBzxJAwJYTXQdA=;
 b=q2b0dJHSo9pfQb/JBupS+ALjjRkoJBqoykFDpXdWZcFADe9drNBJ4SmH14ll27Tf5TOdOSQQeU834a59dCdLP5RVP+g7f3wF0ArKCgWDw+cJ8khtI/+lMSR+ItiragCtJnTJtk/OTkalx1u6qNn2GYCGBT2T3pBVz92GQpo8wJc=
Received: from BN9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::8)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:07:27 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::1b) by BN9P223CA0003.outlook.office365.com
 (2603:10b6:408:10b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 22:07:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/pm: Update pmfw header files for SMU v13.0.6
Date: Tue, 9 May 2023 18:07:03 -0400
Message-ID: <20230509220714.475369-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ad58ee-f839-4abb-0d2a-08db50d9c6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFbzbhFfKXzFEAKRJ7m7oRuprG2t6rxOPX5A8uaOpsdQE6XceCHgzzDiSMnnmbPfeUX77M+BfLMFLniW1cISLktFQaClyougaanbzJxNJwHIbFLunGtSsrgOkjdRqa/jumE40sp6zPMn8LfKTQ19/L89vwUtwi1/UbXFniTA0gP7m2/aRCQkjm+rYgnRESFWtQReIEWTRuaHdH2whJOHwheK8921PHsjhYZsVaOfpf6LJDS21xTWCYJzSxoctUnqO/BghKbhe2lPRnvZ4SlQbR/VmtcuW8YFgtkMeRAKs6IZifsUn0Fgz12wIN9koHgKE74tvafLtP+UBFqoVYmaVztvgTbCc8/8hTxTObdh+OYtOcfK6b5CubgYYuaG8rIVaV2OwmS6UqsdvmQSHjweTAqxlA++DIJBOw5G4hqxUo9gpmCOoelcCMKGZqbzBbhzlvyjXXHydP5Jht4uV5+jgG+s6J0oinLqzaI1mIvWqHGSRqZBiFtImyeudEpmuizLhBeq80IZ9djdOdEMo+rKlcdZkHar8/nTCRgEIx/xh4IqQo0/Mg2v1nuqhPVB92AIyKtLN2xnD+mbNub0AsFHEPPfBnjOwz3RhhPofqOM7fzIp4Ha1iwikVR4X6//XiDG+rRzsYcexi+Iuya858qBjLPdADlbeYWZJ+Y9JNWQafisapL8qDeLbPX38W5RLyjjeAbE/gUtZytwEs62cFlUWo6HXvoPeH271v7JJyXVsdo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(4326008)(6916009)(478600001)(70206006)(316002)(7696005)(70586007)(54906003)(86362001)(36756003)(83380400001)(336012)(47076005)(26005)(36860700001)(1076003)(6666004)(2616005)(186003)(8936002)(41300700001)(2906002)(8676002)(15650500001)(426003)(40480700001)(82310400005)(5660300002)(81166007)(16526019)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:27.3288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ad58ee-f839-4abb-0d2a-08db50d9c6a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad kamal <asad.kamal@amd.com>

Update driver metrics table for SMU v13.0.6 to be
compatible with PMFW v85.47 version

Signed-off-by: Asad kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h  | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
index be596777cd2c..370c6125d718 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -26,7 +26,7 @@
 // *** IMPORTANT ***
 // PMFW TEAM: Always increment the interface version if
 // anything is changed in this file
-#define SMU13_0_6_DRIVER_IF_VERSION 0x08042022
+#define SMU13_0_6_DRIVER_IF_VERSION 0x08042023
 
 //I2C Interface
 #define NUM_I2C_CONTROLLERS                8
@@ -106,7 +106,7 @@ typedef enum {
 } UCLK_DPM_MODE_e;
 
 typedef struct {
-  //0-26 SOC, 27-29 SOCIO
+  //0-23 SOC, 24-26 SOCIO, 27-29 SOC
   uint16_t avgPsmCount[30];
   uint16_t minPsmCount[30];
   float    avgPsmVoltage[30];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index bdccbb4a6276..3fe403615d86 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x1
+#define SMU_METRICS_TABLE_VERSION 0x3
 
 typedef struct {
   uint32_t AccumulationCounter;
@@ -198,6 +198,10 @@ typedef struct {
   uint32_t SocketThmResidencyAcc;
   uint32_t VrThmResidencyAcc;
   uint32_t HbmThmResidencyAcc;
+  uint32_t spare;
+
+  // New Items at end to maintain driver compatibility
+  uint32_t GfxclkFrequency[8];
 } MetricsTable_t;
 
 #define SMU_VF_METRICS_TABLE_VERSION 0x1
-- 
2.40.1

