Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1E8611C1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA1E8611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DA56E9A9;
	Fri, 10 Sep 2021 09:10:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727D06E9A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 09:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK4DBJ+wGeUqbBvkqjmBBfijWPRGTwI/fyCg4CqEZbpXYCpQ7lvzNbdJcsD9tiY8PLJRMJY7mTNxwaGeD82ly4Seu+NiIabGpxLAV637WTmFVszgsvyW15ott0bfqnn1DCql048Zmle6p6ikcbBOr/CPrlIZR1Ol0MdyzQGJk0DEkyYVFufzWkkLPI/SeRH1Nv1+S9u1RtR0XUAtP+zSXJcbJFoSSgsW6mREaDHR8HOD35OgkfoGVGWDN/F5d/XqGQrao0yDXqZXbd5sf9cEq1882YTfGnJUKYgX0H14su2obyEZLhwznk8jxlX3wgcS6mkrbOhQ1U53YtNNL9e53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GK0gq+DOtl+IXOCMG0442PSJOYavd5zEI2zxf4DjeAA=;
 b=WEkuGjOmOflQX/64sK+m//B4M7gd6E+vAFkbEDhrkhMlrF8QbAxjRLPOpXJbmJ2no4rpkIxGZmOJKw36gkFOXiGWmpnhSnWgdvdSIjRAMB5EVnIt38OiKqSmlBXPvap1v0a+g7LUMBThVGHeNazcnx5bi8tAWjFLCjhfD7UuYjSTJ9nBN8hMtM0QsjfZhgJwAezT25o5/LAMEbKUVnRcvZlIndMibaHWv8bdSvLzVFPIRU/zV6ETy0KlRj+ueaAVYayb5CxWgTxUf0d7fxttIcm8We82swaYF1yBPpGEvg3Gflq5bKFHVFKlv5B1LZAeTk1Dvy+b+sQKcl6VOU16bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK0gq+DOtl+IXOCMG0442PSJOYavd5zEI2zxf4DjeAA=;
 b=L4z3BKtjN4ky2sVFjKfbKHt0SBJo/pDqkYHC+vrHQdumyjBMDcXDXIO7ecctMIOwm8ad/vNHl0P4PQiz3FPa8KPturUtYyOlaea2rT7jZu7qoK4UCUPrJoah4BftjyKesjgoGkJ/uTQ1y4y6ctdFpMrYG9wmTpbgx2o/5713SA8=
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 09:10:07 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ac) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Fri, 10 Sep 2021 09:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 09:10:05 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 04:10:03 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: update SMU driver interface for cyan
 skilfish(v3)
Date: Fri, 10 Sep 2021 17:09:45 +0800
Message-ID: <20210910090946.969839-2-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910090946.969839-1-lang.yu@amd.com>
References: <20210910090946.969839-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2e4e75-3b20-49f2-4a87-08d9743ac7fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595995CEB16243619082DB7FBD69@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDTlIxk9HHvxZlBHpX1A1pLTT5YSF9annbal0euwEeufHK2H2xMc40drPaLq2tq7rh5gz0JbmEjIgmbm+aL6tUmIxnkWdG5UGXo16k+y9hlYi0RivB+YW4QKne8HXwpprs79h6BSi/wHMycy9Dc6WnX4c7rZlBzdHz8X/PlXBoqNnuOMRTXruaSFTGwZ7kC2KSqe8ltba3IxXCXboHBEdamLl5LCpaDgEts4f7mVINwAsNADFWgy5rJlf5zWgA5IiGiEkGSPypMiJtGKVmLJfvXcdY0XwUFhChQqAOJPYzPABoy7Zaq2brv4Zi74OpbVfmzln3VPrpPGxHlSKaU/AIe7I0F+K8vlEKQfswEipgTZgfK2jXPxpS4eIlZSToH+YE0r2cquqbj9S5m6HRFrR4R62ZoWny02GaYhqQyJAJ/jI3SOnePEMdlZO5tuCOaV6E/QqWQ0Cdg/auI4Xqz5vA7S7jyVmRsYnu9yA5PKpHRmwHiD5LBfS2CKAIzCcSHq3uJBA/uxWO2h9cMRpNh0JKUZ3RbFuKBDSQXIdmGc8DiRVQoAgFFa2NPxr+aqa1Nf88t5bc/NObgoiaZVf5sMyRwOb7WKBqwoZr8SWcQJTLg38Eos/rRobyWFQq2Hkdawf02E8NVGzHzKP2yYBOJ/wxB9T07UdXTH280fEUhmuAp1frYbU4yb8B3liS/cnad5V5KNea5E51gAQA9VWI9P2wW8ftrADEDvsovsbp7GyKw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(6666004)(2906002)(86362001)(186003)(36756003)(8676002)(15650500001)(54906003)(70586007)(16526019)(316002)(70206006)(426003)(336012)(4326008)(2616005)(6916009)(26005)(8936002)(81166007)(44832011)(47076005)(36860700001)(508600001)(83380400001)(1076003)(356005)(7696005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 09:10:05.9946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2e4e75-3b20-49f2-4a87-08d9743ac7fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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

Add SmuMetrics_t definition for cyan skilfish.

v2: update SmuMetrics_t definition.
v3: cleanup and rearrange the order of fields.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 .../pm/inc/smu11_driver_if_cyan_skillfish.h   | 86 ++++++++-----------
 1 file changed, 35 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
index 8a08ecc34c69..4884a4e1f261 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
@@ -33,63 +33,47 @@
 #define TABLE_PMSTATUSLOG        3 // Called by Tools for Agm logging
 #define TABLE_DPMCLOCKS          4 // Called by Driver; defined here, but not used, for backward compatible
 #define TABLE_MOMENTARY_PM       5 // Called by Tools; defined here, but not used, for backward compatible
-#define TABLE_COUNT              6
+#define TABLE_SMU_METRICS        6 // Called by Driver
+#define TABLE_COUNT              7
 
-#define NUM_DSPCLK_LEVELS		8
-#define NUM_SOCCLK_DPM_LEVELS	8
-#define NUM_DCEFCLK_DPM_LEVELS	4
-#define NUM_FCLK_DPM_LEVELS		4
-#define NUM_MEMCLK_DPM_LEVELS	4
+typedef struct SmuMetricsTable_t {
+	//CPU status
+	uint16_t CoreFrequency[6];              //[MHz]
+	uint32_t CorePower[6];                  //[mW]
+	uint16_t CoreTemperature[6];            //[centi-Celsius]
+	uint16_t L3Frequency[2];                //[MHz]
+	uint16_t L3Temperature[2];              //[centi-Celsius]
+	uint16_t C0Residency[6];                //Percentage
 
-#define NUMBER_OF_PSTATES		8
-#define NUMBER_OF_CORES			8
+	// GFX status
+	uint16_t GfxclkFrequency;               //[MHz]
+	uint16_t GfxTemperature;                //[centi-Celsius]
 
-typedef enum {
-	S3_TYPE_ENTRY,
-	S5_TYPE_ENTRY,
-} Sleep_Type_e;
+	// SOC IP info
+	uint16_t SocclkFrequency;               //[MHz]
+	uint16_t VclkFrequency;                 //[MHz]
+	uint16_t DclkFrequency;                 //[MHz]
+	uint16_t MemclkFrequency;               //[MHz]
 
-typedef enum {
-	GFX_OFF = 0,
-	GFX_ON  = 1,
-} GFX_Mode_e;
+	// power, VF info for CPU/GFX telemetry rails, and then socket power total
+	uint32_t Voltage[2];                    //[mV] indices: VDDCR_VDD, VDDCR_GFX
+	uint32_t Current[2];                    //[mA] indices: VDDCR_VDD, VDDCR_GFX
+	uint32_t Power[2];                      //[mW] indices: VDDCR_VDD, VDDCR_GFX
+	uint32_t CurrentSocketPower;            //[mW]
 
-typedef enum {
-	CPU_P0 = 0,
-	CPU_P1,
-	CPU_P2,
-	CPU_P3,
-	CPU_P4,
-	CPU_P5,
-	CPU_P6,
-	CPU_P7
-} CPU_PState_e;
+	uint16_t SocTemperature;                //[centi-Celsius]
+	uint16_t EdgeTemperature;
+	uint16_t ThrottlerStatus;
+	uint16_t Spare;
 
-typedef enum {
-	CPU_CORE0 = 0,
-	CPU_CORE1,
-	CPU_CORE2,
-	CPU_CORE3,
-	CPU_CORE4,
-	CPU_CORE5,
-	CPU_CORE6,
-	CPU_CORE7
-} CORE_ID_e;
+} SmuMetricsTable_t;
 
-typedef enum {
-	DF_DPM0 = 0,
-	DF_DPM1,
-	DF_DPM2,
-	DF_DPM3,
-	DF_PState_Count
-} DF_PState_e;
-
-typedef enum {
-	GFX_DPM0 = 0,
-	GFX_DPM1,
-	GFX_DPM2,
-	GFX_DPM3,
-	GFX_PState_Count
-} GFX_PState_e;
+typedef struct SmuMetrics_t {
+	SmuMetricsTable_t Current;
+	SmuMetricsTable_t Average;
+	uint32_t SampleStartTime;
+	uint32_t SampleStopTime;
+	uint32_t Accnt;
+} SmuMetrics_t;
 
 #endif
-- 
2.25.1

