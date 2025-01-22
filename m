Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234D8C0218C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 09:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C503F10E3A5;
	Wed, 22 Jan 2025 09:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HTYG6vTB";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3289610E6A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 09:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQFNRf6A+dwy4xno57zgdiB8kcLw9V1kYJjIp54riuBTubmuUyUnyw+ymLYIYAgmvM0p4dDun3SH8pa6AGCMCWceqdUdEEK9aSDwNOvhBkWe5TRFf5Fwgjs4gCbwlOONSTsYFjWDfWmJ7BdwBVZyAgyJ4bzTwvwmlQaHJQAJqKalxkNIKGDgQZm6bS7UtW8pIaqdVZLkrg18nqW8BzZYNakbXz+/4UwLZudj/rpuDzTtPF9BNsTO5c1fXW+58y/c9pIoY0dp78iL71kmuLPLCH/31XRO6wpfcB0CbaHfPg9ypF9FphjODDngjL8krKWQjjrFE9annlJGXAbF9FEh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuNCgHNVv0F5IyDAz4g6wcw9yidFFAqnIGCCp+am0YI=;
 b=kWYjrYB61s8wKVPyb+d3qyYd7g0y1W5zVHyW/E9xptI/G7PUayVqEblbzRNufRt43VeB6EBwSQwGs3CwrzzG4s5XcL8zPR1LwrASUs+KKKuIn9ODDljtyzhsw296rdBWSEjpef+TymboTX+/e27FpXx+GkgJ631zSXff94NhXvAYkS1PWv5HHGpRMPJW3l4w8CW4tPf93w+YtXOt2t8qwqqBGUrIaoH/ccxEMx2CtlWqcX4jQLoYQeV9cWnXud/NiY2C7Ks/mjBa08J3Ynsq2wbS2nTEp6S+GuuGZT4dnU5ql9z/LLjVzWrIlACYqsMMTBPAeIqirw4xU/wuCrfxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuNCgHNVv0F5IyDAz4g6wcw9yidFFAqnIGCCp+am0YI=;
 b=HTYG6vTBASF8f6gPaEKAFvCrznOg0hFjwuMDRH7i3LL/pCluI/ziFOBnD7vU4fhIry/4bvwU5GN4/mmz8ASE74gM5Yo5J4nELpp1AB2lOqQyFW6l06WvCv+8o0vmb6Be90R3jAkZ0VdPVG8y+mRbjOqhBHDAzd3e4BgcRa6Z27A=
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 09:56:17 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::f8) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 09:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 09:56:16 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 03:56:13 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 2/6] drm/amd/pm: Add metrics table header for smu_v13_0_12
Date: Wed, 22 Jan 2025 17:55:39 +0800
Message-ID: <20250122095543.148993-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250122095543.148993-1-asad.kamal@amd.com>
References: <20250122095543.148993-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b0d2aa-794a-4b47-80c1-08dd3acb03a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MgQ/61CmtXvrzWMP7iD7v/9wZeqge4UwCAORHhiabwR1+ReETX6bW7eFL8Iy?=
 =?us-ascii?Q?3jVnvan4rcCLhNnfRFCH/tn52kSBsfe9roxoj2rBvDIVXmq5mX65rzfIoi3G?=
 =?us-ascii?Q?H3nu6bATWF+EUwFwNUvxv/1D2vcsV3sT0WyzL/wD0SwszoNkfrkq+5b1NGIA?=
 =?us-ascii?Q?DxDhReydTZwLnHpwffgQxw4S/G1Y8LovuUzyczv1biPTEdfGP01RGNaLcJ+k?=
 =?us-ascii?Q?ZkVuO9PeJ1BAn2/67WuiRwccfnrHNgE7WwudZ/T5ABogL4Cxi5hDsTuLOAGK?=
 =?us-ascii?Q?g4TcM/NdmZbAtn5yS/Va5UwFQLSJhRkF+v2jSMd+x/cdCcqmyUhe3gAHuHm6?=
 =?us-ascii?Q?kvnXdoOijBU7vmmWnO5By6NUp6nhjZ8OYo1dEWflFsKY28bHFdw9fKW9jMe9?=
 =?us-ascii?Q?GMUyIQB7amYamNOzfMMIElwyABcL8FFV7sLu4lU59RT7+8TeKkjKTPVgyllw?=
 =?us-ascii?Q?xAukyCE8zC9vWaetzro/l5OSI9ozGMyp5MhTnm3ednLV1YVSvVuhvF6+Mlhy?=
 =?us-ascii?Q?fNUDN0LMjGzr/UrRE4cksaTwIwsnDVuAAyg5FFDaIYmDimWtfkA6xb37wilL?=
 =?us-ascii?Q?eBnMetrS3SoWGhGUX/4MsVRU4RQy46S4korn5DFD+RxeVcpFik2MJO0//TB1?=
 =?us-ascii?Q?UvVas0mEKFi6xj5Zd59Ph/h6vRzXiuIwFmJPMFntWx+fPOYfJzK2+3KMBGBM?=
 =?us-ascii?Q?ldfOD2zi+bZM4vcFxZYf5nXUfNH+we1cyulF6GqWj3RjaWZnIdCk+U2P/JKj?=
 =?us-ascii?Q?8H7HUqK2HKzCVCinCUIMRzNkse6EYCmwrQHmWqfTogRcYASjdadzWsJ3/N8D?=
 =?us-ascii?Q?QwlLKgBAi0+MJPhak2NqBdwDV9bflQVn75xRaca2/OFBAFpIWiuLEAjTD287?=
 =?us-ascii?Q?JVoCbHTI/sIIEhyiCF9RHdAuEEGcy7a0o+Fo4J2DpjonZhGu7tYieTZdzsCh?=
 =?us-ascii?Q?R4eO055KbWbM008Oo8nOCKUg1QfwKA4UigrXyzh9aKu2XpYyZtY4mmicx2ya?=
 =?us-ascii?Q?AU2qon8wH5xU8RejPOfSwf9iEkX/TanV2JIeadVzN1Cn1RZEiQz9PIkYqSES?=
 =?us-ascii?Q?rdPHaT3k+6+7ff784LQtIXz+kZymncTtRzIoV6R+o/3LVM9ka9KcfloICIJu?=
 =?us-ascii?Q?HeMyu4AZrTFNxHxN9kFjUFZj0lp+UNhMX/NrBdzCDJbl3+D3fF/M/8ED/riT?=
 =?us-ascii?Q?xly3Ra700GpbxV+Zx2ckDfARowXXAn3B+Nr+Rwwc/ER8jgnKlglx05N5cvaG?=
 =?us-ascii?Q?LRntorGQiy9v5aRJqiNLw/0ynboCYR4d0rewSq1le08fzlE7NDT4QJlOp9xu?=
 =?us-ascii?Q?pHtxGJUxnHltL7uY58Lp3Ox2CWa1tq4+nEUfjHQm21q+guScv+lVQTVB+csf?=
 =?us-ascii?Q?IKrqxKYp4G4W85E6/C+gY90vmtj/LAZklrHjJc9n+SdBQqsJMcYXDS0YdfHK?=
 =?us-ascii?Q?Pu8xip/xyo3QyzA11zrFywGuMwh5dPvKAUexxO5Tum29UvbFaa5QuYVLeKAD?=
 =?us-ascii?Q?qpq2dkiPjpttcq8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:56:16.9007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b0d2aa-794a-4b47-80c1-08dd3acb03a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076
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

Add metrics table header for smu_v13_0_12 as metrics version V2

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h   | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index ff9f7d4e11df..f8ed45857878 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -337,6 +337,115 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint32_t JpegBusy[32];
 } MetricsTableV1_t;
 
+// Metrics table for smu_v13_0_12
+typedef struct __attribute__((packed, aligned(4))) {
+  uint64_t AccumulationCounter;
+
+  //TEMPERATURE
+  uint32_t MaxSocketTemperature;
+  uint32_t MaxVrTemperature;
+  uint32_t MaxHbmTemperature;
+  uint64_t MaxSocketTemperatureAcc;
+  uint64_t MaxVrTemperatureAcc;
+  uint64_t MaxHbmTemperatureAcc;
+
+  //POWER
+  uint32_t SocketPowerLimit;
+  uint32_t MaxSocketPowerLimit;
+  uint32_t SocketPower;
+
+  //ENERGY
+  uint64_t Timestamp;
+  uint64_t SocketEnergyAcc;
+  uint64_t CcdEnergyAcc;
+  uint64_t XcdEnergyAcc;
+  uint64_t AidEnergyAcc;
+  uint64_t HbmEnergyAcc;
+
+  //FREQUENCY
+  uint32_t GfxclkFrequencyLimit;
+  uint32_t FclkFrequency;
+  uint32_t UclkFrequency;
+  uint32_t SocclkFrequency[4];
+  uint32_t VclkFrequency[4];
+  uint32_t DclkFrequency[4];
+  uint32_t LclkFrequency[4];
+  uint64_t GfxclkFrequencyAcc[8];
+
+  //FREQUENCY RANGE
+  uint32_t MaxGfxclkFrequency;
+  uint32_t MinGfxclkFrequency;
+  uint32_t FclkFrequencyTable[4];
+  uint32_t UclkFrequencyTable[4];
+  uint32_t SocclkFrequencyTable[4];
+  uint32_t VclkFrequencyTable[4];
+  uint32_t DclkFrequencyTable[4];
+  uint32_t LclkFrequencyTable[4];
+  uint32_t MaxLclkDpmRange;
+  uint32_t MinLclkDpmRange;
+
+  //XGMI
+  uint32_t XgmiWidth;
+  uint32_t XgmiBitrate;
+  uint64_t XgmiReadBandwidthAcc[8];
+  uint64_t XgmiWriteBandwidthAcc[8];
+
+  //ACTIVITY
+  uint32_t SocketGfxBusy;
+  uint32_t DramBandwidthUtilization;
+  uint64_t SocketC0ResidencyAcc;
+  uint64_t SocketGfxBusyAcc;
+  uint64_t DramBandwidthAcc;
+  uint32_t MaxDramBandwidth;
+  uint64_t DramBandwidthUtilizationAcc;
+  uint64_t PcieBandwidthAcc[4];
+
+  //THROTTLERS
+  uint32_t ProchotResidencyAcc;
+  uint32_t PptResidencyAcc;
+  uint32_t SocketThmResidencyAcc;
+  uint32_t VrThmResidencyAcc;
+  uint32_t HbmThmResidencyAcc;
+  uint32_t GfxLockXCDMak;
+
+  // New Items at end to maintain driver compatibility
+  uint32_t GfxclkFrequency[8];
+
+  //PSNs
+  uint64_t PublicSerialNumber_AID[4];
+  uint64_t PublicSerialNumber_XCD[8];
+
+  //XGMI Data tranfser size
+  uint64_t XgmiReadDataSizeAcc[8];//in KByte
+  uint64_t XgmiWriteDataSizeAcc[8];//in KByte
+
+  //PCIE BW Data and error count
+  uint32_t PcieBandwidth[4];
+  uint32_t PCIeL0ToRecoveryCountAcc;      // The Pcie counter itself is accumulated
+  uint32_t PCIenReplayAAcc;               // The Pcie counter itself is accumulated
+  uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is accumulated
+  uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is accumulated
+  uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is accumulated
+
+  // VCN/JPEG ACTIVITY
+  uint32_t VcnBusy[4];
+  uint32_t JpegBusy[32];
+
+  // PCIE LINK Speed and width
+  uint32_t PCIeLinkSpeed;
+  uint32_t PCIeLinkWidth;
+
+  // PER XCD ACTIVITY
+  uint32_t GfxBusy[8];
+  uint64_t GfxBusyAcc[8];
+
+  //PCIE BW Data and error count
+  uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is accumulated
+
+  //Total App Clock Counter
+  uint64_t GfxclkBelowHostLimitAcc[8];
+} MetricsTableV2_t;
+
 #define SMU_VF_METRICS_TABLE_VERSION 0x5
 
 typedef struct __attribute__((packed, aligned(4))) {
-- 
2.46.0

