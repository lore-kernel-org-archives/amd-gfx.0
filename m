Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834BC07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 06:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DA661945
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 06:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DA661945
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71DD897FB;
	Tue,  6 Jul 2021 06:46:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88C4897F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 06:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV5I7zxlQ3fwc4BP01e7omYBF4bP90ahjpk0zGuZG6qe3DrlrLHJJA09oVgbb6bdxYP4IN2n/mRq+SKQl4LB1Bfu5otxj/PvFPwJS5t/4+oFYZoO9YxM3R99/WfLcKkzLo9wc7ykIC6+RvAFTP742CImgGYkalSMtkI8IU6hD43JKe5wTbyBp/Z8IXH9PPVCxMFeAsoBUoJYje/ftqJFYbh/ZABs6MD5EggMh/7dTVjqregy7Yn+CoCXuwt85e9DzjyXO/BPnaem4vmBmfz8C+Vl3oAkSNcJvkSnJ2K7vyHDQZgNofC9NJiNmUYvrciJnW5llue4c0dB3OCzxkfZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAAZ1jfOqlLga0M4FNAayuphdwYaquVIZ8oRode/8dE=;
 b=YB8PP0pEeVzAfBxLGyhO22lxRrm+HuLpYmP5OSZzETFQVPLgePTH5tG2uriLyl9/kvw4w38/GJcINh0z8vrWnKYhRUlndlNvJldnxicni8r3C7+IYkpL2V3Py2Raj//OaQjqRnrqNgdVEP9KDQsJKCNhZz6oSzWJjV45xSPshQlB7kkJmX5YfLLPWZi0UmIGvzhUpOXK0MLt0maqCvPcwGnwWPg5aG6mETGlZobxLupdwTWAC7LCvQ0f3MYEA8k6U9rICunV1+ny7mJ58yfe4oA6jjI2F/zQmXDqq5nWycu54ieFp2pVW0ceqlGcgUKcmuGSOKz0U9qI94wBEUd9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAAZ1jfOqlLga0M4FNAayuphdwYaquVIZ8oRode/8dE=;
 b=wKWtd6Lh9jasytJ8N0/7MpsfrNLKvBABpoav9DwiSesyh2IUFNUVIYoIAc1FYatuYg44F4mICe0lxtpTi6lqXh+3hgT7leaOpZNM95vnV6i7GH/BN79RPwEnmlLdiCp2k5rBaFUY/5He1sV0TD243BqaoNkFRzgmEnA4bV218j4=
Received: from DM5PR07CA0081.namprd07.prod.outlook.com (2603:10b6:4:ad::46) by
 SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22; Tue, 6 Jul 2021 06:45:57 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::f2) by DM5PR07CA0081.outlook.office365.com
 (2603:10b6:4:ad::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Tue, 6 Jul 2021 06:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 06:45:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 01:45:55 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/3] drm/amd/pm: new SmuMetrics data structure for Sienna
 Cichlid
Date: Tue, 6 Jul 2021 14:45:34 +0800
Message-ID: <20210706064536.123524-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb01756-c52d-4e5a-fc43-08d94049b586
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24484613F062273E0E73C968E41B9@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZQUycYskiBl/cqM+941Uk3hmDxq9vq4adifeJGEeDXcOMNhBjJMC6lrm+NN6TJWcjPWOT7tgxzGiyjqFtihARqSHb0866rZccrST6liV8UQZC4SLf6j9Qtq50DomMMOpRIy56FDkjfgq3WLzGX8iMQthpsIUIEO6u+b20904o3pJxFcYp3tvRuZd4PUY5cwh709dw3ZXZzyIh5OIF6QR2jTtYsK/J483QjG2KvjVWKKo2af1BhTLDBZUXioQX0dJ9OSrfsZxc04FWYFBE7iyY+3E7aQDi8rNd+kyYMK4cYPEcZ6HF+w3QHELnNeF83kqUI5Sd43GEYdnk6qIiyc27b7e4AFKFxQTh8o1jI1NVgZ6mASjE7B4mSG2OA91ej1wzkFOswb70/okjt9XpQ1l7CvH9vQohPfE2f0/bVi8HJrkVkwEZz4doQIkpDtMUkz6uzQGVP7me/evRKkzPAcKO3OlGIeEKc095BNZotckfyHzKqPpNb1fhHtL1IfbRdlPoZ0qOlIDUOmngWB/wk2nHNHMSNzWnwIjtY+uN2n116s8WpUg+nCe292JMqCRVRnQdpULubxMMPIEOKnj+o+9RMQl71+pdz8d+ssEvYxofx3boBUT10ALlnw7SrjX1DDypxp/eavqbu6c254WTyvWJEWWFB1KY3iVphjDISm+7Je1VitD+F8DO+KmBKDmDRS0Q9V9eEKIeBJhX3w3cHEjYHaKCpVkQB1kjs3eDMBgp4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(81166007)(26005)(478600001)(86362001)(6916009)(356005)(82740400003)(16526019)(70206006)(5660300002)(1076003)(8676002)(186003)(83380400001)(2906002)(4326008)(8936002)(19627235002)(6666004)(7696005)(36860700001)(47076005)(54906003)(426003)(82310400003)(336012)(36756003)(316002)(44832011)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 06:45:57.0909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb01756-c52d-4e5a-fc43-08d94049b586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".

Change-Id: Ia62195857c5b377e8c95f76de0ec08e8674f04da
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 61c87c39be80..0b916a1933df 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -211,6 +211,7 @@ typedef enum {
 #define THROTTLER_FIT_BIT          17
 #define THROTTLER_PPM_BIT          18
 #define THROTTLER_APCC_BIT         19
+#define THROTTLER_COUNT            20
 
 // FW DState Features Control Bits
 // FW DState Features Control Bits
@@ -1406,7 +1407,67 @@ typedef struct {
 } SmuMetrics_t;
 
 typedef struct {
-  SmuMetrics_t SmuMetrics;
+  uint32_t CurrClock[PPCLK_COUNT];
+
+  uint16_t AverageGfxclkFrequencyPreDs;
+  uint16_t AverageGfxclkFrequencyPostDs;
+  uint16_t AverageFclkFrequencyPreDs;
+  uint16_t AverageFclkFrequencyPostDs;
+  uint16_t AverageUclkFrequencyPreDs  ;
+  uint16_t AverageUclkFrequencyPostDs  ;
+
+
+  uint16_t AverageGfxActivity    ;
+  uint16_t AverageUclkActivity   ;
+  uint8_t  CurrSocVoltageOffset  ;
+  uint8_t  CurrGfxVoltageOffset  ;
+  uint8_t  CurrMemVidOffset      ;
+  uint8_t  Padding8        ;
+  uint16_t AverageSocketPower    ;
+  uint16_t TemperatureEdge       ;
+  uint16_t TemperatureHotspot    ;
+  uint16_t TemperatureMem        ;
+  uint16_t TemperatureVrGfx      ;
+  uint16_t TemperatureVrMem0     ;
+  uint16_t TemperatureVrMem1     ;
+  uint16_t TemperatureVrSoc      ;
+  uint16_t TemperatureLiquid0    ;
+  uint16_t TemperatureLiquid1    ;
+  uint16_t TemperaturePlx        ;
+  uint16_t Padding16             ;
+  uint32_t AccCnt                ;
+  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
+
+
+  uint8_t  LinkDpmLevel;
+  uint8_t  CurrFanPwm;
+  uint16_t CurrFanSpeed;
+
+  //BACO metrics, PMFW-1721
+  //metrics for D3hot entry/exit and driver ARM msgs
+  uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
+  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
+  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
+
+  //PMFW-4362
+  uint32_t EnergyAccumulator;
+  uint16_t AverageVclk0Frequency  ;
+  uint16_t AverageDclk0Frequency  ;
+  uint16_t AverageVclk1Frequency  ;
+  uint16_t AverageDclk1Frequency  ;
+  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full sequence
+  uint8_t  PcieRate               ;
+  uint8_t  PcieWidth              ;
+  uint16_t AverageGfxclkFrequencyTarget;
+  uint16_t Padding16_2;
+
+} SmuMetrics_V2_t;
+
+typedef struct {
+  union {
+    SmuMetrics_t SmuMetrics;
+    SmuMetrics_V2_t SmuMetrics_V2;
+  };
   uint32_t Spare[1];
 
   // Padding - ignore
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
