Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E234C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 20:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E041510E18D;
	Fri, 17 May 2024 20:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eVvX1G7l";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FBB10E18D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 20:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJvy1QMOY5ctwUKr5cybSCU098u4Q9EHJgX9xu28Imr+lVoP68EwQZykikJ02IiLM6/E2c8eluVfTFnR2IM/FrBRYUrqYxIMAfH1EMye3l3/t0bnKJn1maiAnX2H4wT37a9r64IXSSkY5zsj7y+8ovmNk52pIHSdV/3oa3yBZU9lqu/dXZtbKO5cbeMwzMiwYbMXMYjBw92GbE0hdbskpcYi+UG52F01fTB1VATowJra9c+cDigLIo8Lm5WPkn0oSch+v6eOfgZ2VO6/02f1FNiYQUhpXMMKcK7Om7l480hScqnPgBNyerLko1xKJmXdIDHbTGSygpZ8ZbhVHxaBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+mS88+FEj9nSG73w+8/dr5dtSNRFDhzFr8ZlslkqBw=;
 b=CNRQAGoXL8L04DGqTHqyIXZY7BNR0LMLtHtbDderPdCHqKt0L0zlpWs6OchbaIBomV8ortfG9FAgnYk/3uu5ZOlNzXc29U93g6ngeR7ygg4Qcl/WR5mMBLFhR9ioVCInQZO2CzGSM+gp2vyV4HCNy8bjVY+LU+UmrEh2e+bbJv/leOabmbOeoEDFfAfPYQFwjiIb4XirwuJ4KcvOGjxYXejwSa0Fqq+6ToaRQYsTo5BkI6etJRx1m6QfvgFQVFgltGh4RQSb65/QXA/MS/Wb6M7HO3OTKthYjajKECkh9UUNuQPX5jmWyJxNdFjRli38selwpqLM/8tPYSw5oJchUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+mS88+FEj9nSG73w+8/dr5dtSNRFDhzFr8ZlslkqBw=;
 b=eVvX1G7lup+ikkzssKEdhXc+ufigSx9ng+8FzSo3rNWJbz1eNqRAjWMuUi30JX9cUl0g+m2v4gpjGXZHXG2z8rj/eBZCxOiRJhMTU92Xw9H+P08YFwhmSV8/UxB9teoA1V66XdTwMTUo5sLTlPajvGbwnEiIMh0RS/cOvJ3TS+o=
Received: from PH8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:510:2d2::9)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 20:44:40 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::64) by PH8PR15CA0024.outlook.office365.com
 (2603:10b6:510:2d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31 via Frontend
 Transport; Fri, 17 May 2024 20:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 20:44:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 15:44:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: update driver-if interface
Date: Fri, 17 May 2024 16:44:11 -0400
Message-ID: <20240517204411.436257-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c964ce3-e14a-47d1-201f-08dc76b22c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TWBhxk8/iEXnKFtWB26B56fURbYVf/S2CmQxJfWxwYdguC6xayzbXy3Z3LRY?=
 =?us-ascii?Q?+OlHNjQ9pGAzomSbWK8m+w7UKQxzH8KP9tBqrpWwUYFXDoNKNeZErjeKGbY/?=
 =?us-ascii?Q?ifVNpc/yP/x9V13be6C2ds/wrYbMtXgpcba9GWXUMPVysrCPEl5bxqaWnySB?=
 =?us-ascii?Q?3RlTdrexdDIJZjoeFsN+B3Kp6detM63aqgUlfd1/Rigi5qPFBlmURhDV2inU?=
 =?us-ascii?Q?Kj1eAN1eQB9IeM8tJnxmtkF8EJqApN4Sa1SkggPo2zMK3iXmewcCzJS2XxK5?=
 =?us-ascii?Q?yYXzfvNWUFlKzr5cm3Xthcum64oWWgzHTZ/NkkFlqLgDsFxzmM89QUJJxdv7?=
 =?us-ascii?Q?9rGRJzDsCtc8pM7sfv/GJ/WMC1SFPIXMyg9U4HpK60fyBhdlaqi4AAsrJTX0?=
 =?us-ascii?Q?yzNdkCMbsYTh+7rmph7Ua8GD9743fCk70bgwq36/MhSN3Efr/kGH5PkASbR/?=
 =?us-ascii?Q?aeXusuggdUXCki9hJOExZNuAAV2BxaIzJd/5ilP1WWiYPRZrBpsENCFJ1piW?=
 =?us-ascii?Q?iptxeDgzS3NMyV9YalGSGsfN5IlEvRBZMbcXCOo7sJelIDRCL3/xY9n/CFMB?=
 =?us-ascii?Q?+qs07L6GsrwVmsGIYhYvmd79P18FvVwXBSUgYqihMhTJSV3UjzNtkxca5jVd?=
 =?us-ascii?Q?GwXELAoO5WOzKce2lERJbbklYdFC/bMor1CyGiJTiMFlXolQ/zMguyBQr8P7?=
 =?us-ascii?Q?YoIpsEid4XEtpuUd6koXcJQ+r/iIfKm4Y+/b3p1G+lQE9fV48vINSB6LFyK9?=
 =?us-ascii?Q?kOoWgYecM0C7gAG0M+smjE172g2sOv+EisXtumBEC41Ul63d/H3hizkzgMmN?=
 =?us-ascii?Q?uIeKdrqVuv+63YARsRJ03wCEypBcDiD1u+ObYUtKA2gSDFh6YWuv7+FwgdM/?=
 =?us-ascii?Q?+9FEOUrBQ9PhOcei0OJyrj7Y5plv9qZtrqZMShEgPM3Bcs4HKSqtlJ27WwVd?=
 =?us-ascii?Q?aD3odNw2EGPXBBBthdLtxXCjazkMzKeF7tr3M+GnriHYJ2DbBmT0x2oyCC3B?=
 =?us-ascii?Q?K+yVXGuzxNXbvgdtv/+kKaXInH4OkMRMokE0R49yMHGdZZjbyXqDPcCyPkUr?=
 =?us-ascii?Q?U4bOjnVmAHUssO4xY7LksU20ltTQdJNqU8/UOjlkbK4/jMypznymGEBL2aHk?=
 =?us-ascii?Q?lU0tHXoS8D/urxAd4Z5lK+HEoLqQ3g41efX54hMX6XmDhrtfCWSaDDakVJhE?=
 =?us-ascii?Q?8nkpKguWP/Db+QeMO2JncHRO1Tw39pI0X7gP5FNxhpM7+M+tfReHm8TuZUQR?=
 =?us-ascii?Q?9oOBT+8MbJQghnj80XU2fl0uZPUsL5cnMoQPB2MdZrZ7u6bQWqBnecCYccN2?=
 =?us-ascii?Q?RE8XNv7mFUZs1VPiHMPReTjzx/woehSDN0ysOS1EKMpr0wDDxm55QSXrIam+?=
 =?us-ascii?Q?L3ySycQ7B5c/RsJmvIRCLMNuQDUp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 20:44:39.3741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c964ce3-e14a-47d1-201f-08dc76b22c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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

From: Kenneth Feng <kenneth.feng@amd.com>

update driver-if interface for smu 14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h | 21 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
index 97a29b80fb133..ee457a6f08130 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
@@ -1641,6 +1641,23 @@ typedef struct {
   uint16_t dGPU_W_MAX             ;
   uint16_t padding                ;
 
+  uint16_t MovingAverageGfxclkFrequencyTarget;
+  uint16_t MovingAverageGfxclkFrequencyPreDs;
+  uint16_t MovingAverageGfxclkFrequencyPostDs;
+  uint16_t MovingAverageFclkFrequencyPreDs;
+  uint16_t MovingAverageFclkFrequencyPostDs;
+  uint16_t MovingAverageMemclkFrequencyPreDs;
+  uint16_t MovingAverageMemclkFrequencyPostDs;
+  uint16_t MovingAverageVclk0Frequency;
+  uint16_t MovingAverageDclk0Frequency;
+  uint16_t MovingAverageGfxActivity;
+  uint16_t MovingAverageUclkActivity;
+  uint16_t MovingAverageVcn0ActivityPercentage;
+  uint16_t MovingAveragePCIeBusy;
+  uint16_t MovingAverageUclkActivity_MAX;
+  uint16_t MovingAverageSocketPower;
+  uint16_t MovingAveragePadding;
+
   uint32_t MetricsCounter         ;
 
   uint16_t AvgVoltage[SVI_PLANE_COUNT];
@@ -1653,7 +1670,7 @@ typedef struct {
 
   uint32_t EnergyAccumulator;
   uint16_t AverageSocketPower;
-  uint16_t AverageTotalBoardPower;
+  uint16_t MovingAverageTotalBoardPower;
 
   uint16_t AvgTemperature[TEMP_COUNT];
   uint16_t AvgTemperatureFanIntake;
@@ -1676,7 +1693,7 @@ typedef struct {
 
   uint16_t ApuSTAPMSmartShiftLimit;
   uint16_t ApuSTAPMLimit;
-  uint16_t AvgApuSocketPower;
+  uint16_t MovingAvgApuSocketPower;
 
   uint16_t AverageUclkActivity_MAX;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 3d34b3869df69..e6531c30c3ebd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -28,7 +28,7 @@
 #define SMU14_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x7
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_1 0x6
-#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x25
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x26
 
 #define FEATURE_MASK(feature) (1ULL << feature)
 
-- 
2.45.0

