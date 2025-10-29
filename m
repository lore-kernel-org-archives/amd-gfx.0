Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA22CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3792110E74F;
	Wed, 29 Oct 2025 08:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZPnKbr8W";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA4910E74F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYebrM+Bxb2sQM0TLIHI5ifVq4Up4Bd/jwVgDu8cIHMyeaLsPKTHzZ7J0KeFdefRo6ja4x7A6HzxEPuiVNbA8rp9oUuaqjkeJVf7glkU3hUtJFuB3EzSG1Vx/k48vgUjezONIsnGBeJb/heXIn7IPYcpTD/OvkM/c4VmINxW4mMGNgn8eKs7xI29V0IydgAjfCWLZv4pwJeawonORKDSQNT61rJNzrOmWbSsGgydgVuUe+YBss8Qtihz/Jztx4vvsz2v47djmgKGREnCj+6XT6UKCj6MZX2qSe1k7mqPv5E1wWViiXwCos31YKWd91cXuED5JlzSwwKYsCO3itKLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD/m55G22LguoOMq6ceE69xktcNeYkIuPZi6sZEEu78=;
 b=J1uhpmOSIrLqN6bUSSgSyk3dIHN8GQR2+2UVj/5Z1vUmKiCb21bb8NXJMCckocaJyo359U+z7N8wgKpuMe02P4SiNhBCW5mt3L5XmjA2v/cbzaJXUadFlZo0oPURNcl0dLJ0+XcTu/d7p69Rdd7XRNu9tvvlEVFSZ6rCUhSACOAK+JCe8sxC+q+gxbud6aWvM+J+7O+jdm4U4U12TWABwrbdb8YmtyizaQeBWoCSSWChXBnA0z5FT8WOXLF8SFlFF4cMfx1opCu2ntfnIMEnIvPzNPHkKQuTxl7qhgNag1f4Qo9C/4ZLDOCZA2ymboZI0DCv9iKY/szZYs74u2xrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD/m55G22LguoOMq6ceE69xktcNeYkIuPZi6sZEEu78=;
 b=ZPnKbr8WT0XLEkP5akqafXM2CkoZiC6NtOp+nc0c+7UHVUQb77D1pMPBydws2MGF/gV1xT+sg3uobiKL3b5+bT1tfoqWwpseMDmAm6N9KnLQm2MwALAtcLIuAZMASdROm+drFpdGICmCwNBkNmvLn9tfqlVU6DXPmdoZ78Eut9Q=
Received: from BN9PR03CA0678.namprd03.prod.outlook.com (2603:10b6:408:10e::23)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:48:12 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::4a) by BN9PR03CA0678.outlook.office365.com
 (2603:10b6:408:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:11 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:07 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 01/10] drm/amd/pm: add new message definitions for pmfw eeprom
 interface
Date: Wed, 29 Oct 2025 16:47:42 +0800
Message-ID: <20251029084751.1701305-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: da5e15dd-ccae-46b1-b509-08de16c7e475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mfhnu7BTvIK3Nubg3rsG0CtWxwjSpkU/dx8wppK/IRNI3a4UwriNSSCeMoPL?=
 =?us-ascii?Q?5j9kQhl2FlwC3zxoTo22fB0nepQUMrniALdRt80oSyL2ANBPpj7AFdy5Zwko?=
 =?us-ascii?Q?ltHC1ZgT1oPiK0YUTG1sq2M+LH127wQHsFM2JFWJ12MqD3e5dX0o4CKbNRee?=
 =?us-ascii?Q?jQ/OW+7NFUtN8rxj0JnMQ3+aFGjk0Kkwn3KXDeCG9g3HqTEDcIE9gGOONIOa?=
 =?us-ascii?Q?ptM++c1oV9OIcHxSYsJAUJwZ1lDLCwSdEPRvyptnbrLOQdVMU6pkO+T/vpts?=
 =?us-ascii?Q?euYyc5WD8q43ZT1Ji1BYVVNeywtlTFACkKnzfIzrbNvS0q7oUZN6NiPa6aLi?=
 =?us-ascii?Q?kNcV7lUdeJRfxjKJysIrRBOQIUFXOiGjq+rC00LGRZLA6s0OZNY/KHLWdQSH?=
 =?us-ascii?Q?C28jTswZUWtfQ/u536tncKeV1dSt9cf3XVeSBSpCgOkwVq3b8BFFb77gGzia?=
 =?us-ascii?Q?c7VYeXhiSnf8J+xj5cyU5TJjAOdU/+0SG+h3arP2OTQIU/pyy4fTOlsgDnd1?=
 =?us-ascii?Q?iQxIc601m5Zk6GnaURLdpRSw5uaEptpPLd8BUAIMnAu14UInftH2v/mDN1vH?=
 =?us-ascii?Q?InuPJ/hxP2uFQaT18HZSyoWPPCPEMNhSt76XWcxC4rxhEgZgeofE1KGYi0s0?=
 =?us-ascii?Q?miE4h6kF4+LZykY0BY0ODhe1aB5wXnOpxy8gurXDwnHNOhl1tZfd/sVNZai+?=
 =?us-ascii?Q?aOhndHjt3328S9dk8bsO2ikYst2vCTEQOCsG8um0rpnxmffnkyFHJiQVxOPp?=
 =?us-ascii?Q?kYNd0JwbpHR0GTDV5qfcpwdqDI7UcXpYbc5XYC4Z5sGGlE8HZ03WQjPrdtpc?=
 =?us-ascii?Q?SmMFINevvXSh5kO5jXy+mLft9ksdg3/t9VQfo/rZejsg9I04aN1FV7VPNqtF?=
 =?us-ascii?Q?z5hEN8DDbQIwvRvHxXEybWxEyyOsTf2i5KNCRSzER0BfRgC44FWR5qc6+P7p?=
 =?us-ascii?Q?6KeuUe3QzPYvdR1Ahs2q2i/DO0gdiBkQsGAlLNysQJs2ODicoKMis4oVVlRn?=
 =?us-ascii?Q?vnU0M9NRPf3h31w/KPPsZaK0C2gkD5fkZQ+pS/G6IdYIGVOzngxDpyRevNwb?=
 =?us-ascii?Q?35ejk6bYFNygfiT7zUTgqfpixdUibAkI45ohsv78TJ0hIlNpHxCdGaGWZ5LU?=
 =?us-ascii?Q?ie33wGjvlGU232UWFACID7X4bdvHvSmu0y1Rq4c0ziR17il9r4V/TQQmVr3w?=
 =?us-ascii?Q?6UQ3M/nmLbZ7UhkPLjPK25HpSPeByHw8Iu602krUwG2VHT3bzACGoQv4DnnR?=
 =?us-ascii?Q?YN5R8h65IIpMFmQla7TX6ZOV5pPlbqhMWwJBlTXY0kXXqVdYilADt0nBND2D?=
 =?us-ascii?Q?0Hvh8spBCo21o+gaVe9hTi0QOgCqFAAKX31Ud5fYVlaMckCH+bItD4UmvLwG?=
 =?us-ascii?Q?GHmphoLEreM5CzI9KFNpnmt+reMEiW4Z22nG5P2jYY94X3maBJ3359C28SrL?=
 =?us-ascii?Q?Sn14vcat64NPnfQMOQwevsapAYQNKwvQrJYCpSVl+vZ8NbjS9xngGX9o6qk/?=
 =?us-ascii?Q?uqYylSvdRg/O6xxdBHQWybfpydod6gs6TsyJ74QSrqp3oB5C894daZz3doAK?=
 =?us-ascii?Q?6MvXA4JBy8aLYBnOlHM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:11.9993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5e15dd-ccae-46b1-b509-08de16c7e475
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
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

Add new message definitions for pmfw eeprom interface

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h    | 16 ++++++----------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h     |  9 ++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c    |  7 +++++++
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index 4b066c42e0ec..fe1b3ac50a75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -105,19 +105,15 @@
 #define PPSMC_MSG_UpdatePccWaitDecMaxStr            0x4C
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_MSG_GetRasTableVersion                0x4E
-#define PPSMC_MSG_GetRmaStatus                      0x4F
-#define PPSMC_MSG_GetErrorCount                     0x50
-#define PPSMC_MSG_GetBadPageCount                   0x51
-#define PPSMC_MSG_GetBadPageInfo                    0x52
-#define PPSMC_MSG_GetBadPagePaAddrLoHi              0x53
-#define PPSMC_MSG_SetTimestampLoHi                  0x54
-#define PPSMC_MSG_GetTimestampLoHi                  0x55
-#define PPSMC_MSG_GetRasPolicy                      0x56
-#define PPSMC_MSG_DumpErrorRecord                   0x57
+#define PPSMC_MSG_GetBadPageCount                   0x50
+#define PPSMC_MSG_GetBadPageMcaAddress              0x51
+#define PPSMC_MSG_SetTimestamp                      0x53
+#define PPSMC_MSG_SetTimestampHi                    0x54
+#define PPSMC_MSG_GetTimestamp                      0x55
+#define PPSMC_MSG_GetBadPageIpIdLoHi                0x57
 #define PPSMC_MSG_EraseRasTable                     0x58
 #define PPSMC_MSG_GetStaticMetricsTable             0x59
 #define PPSMC_MSG_ResetVfArbitersByIndex            0x5A
-#define PPSMC_MSG_GetBadPageSeverity                0x5B
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
 #define PPSMC_MSG_ResetVCN                          0x5E
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 2256c77da636..9315ce49b396 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -279,7 +279,14 @@
 	__SMU_DUMMY_MAP(ResetSDMA), \
 	__SMU_DUMMY_MAP(ResetVCN), \
 	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
-	__SMU_DUMMY_MAP(GetSystemMetricsTable),
+	__SMU_DUMMY_MAP(GetSystemMetricsTable), \
+	__SMU_DUMMY_MAP(GetRASTableVersion), \
+	__SMU_DUMMY_MAP(GetBadPageCount), \
+	__SMU_DUMMY_MAP(GetBadPageMcaAddr), \
+	__SMU_DUMMY_MAP(SetTimestamp), \
+	__SMU_DUMMY_MAP(GetTimestamp), \
+	__SMU_DUMMY_MAP(GetBadPageIpid), \
+	__SMU_DUMMY_MAP(EraseRasTable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index cb3fea9e8cf3..27b950c126ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -139,6 +139,13 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
+	MSG_MAP(GetRASTableVersion,                  PPSMC_MSG_GetRasTableVersion,              0),
+	MSG_MAP(GetBadPageCount,                     PPSMC_MSG_GetBadPageCount,                 0),
+	MSG_MAP(GetBadPageMcaAddr,                   PPSMC_MSG_GetBadPageMcaAddress,            0),
+	MSG_MAP(SetTimestamp,                        PPSMC_MSG_SetTimestamp,                    0),
+	MSG_MAP(GetTimestamp,                        PPSMC_MSG_GetTimestamp,                    0),
+	MSG_MAP(GetBadPageIpid,                      PPSMC_MSG_GetBadPageIpIdLoHi,              0),
+	MSG_MAP(EraseRasTable,                       PPSMC_MSG_EraseRasTable,                   0),
 };
 
 int smu_v13_0_12_tables_init(struct smu_context *smu)
-- 
2.34.1

