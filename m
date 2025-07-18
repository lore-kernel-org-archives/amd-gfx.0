Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD6CC83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3BD10E9B1;
	Fri, 18 Jul 2025 13:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6xIWxjl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7FF10E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpGKuC9udmyMHjC28UT4jeGK0dZFSdwvxFe4b0nNIptWbB2WfQ8ig79Gxtm2VJVoCckZwvXbHQ9tqvppdeFILLtv6Xxdg0CYhcSVWtKbPOsiLPXAHGmzxvG7u+odVkfGy1mFONCx+AmmKDeSSXXihg7ORBdRdP4XmmKChheD+AhP13wpck8tmMhYzWeiAxJJZiVV5KFxVrKXBGV461QkvVWZBSHu72bpEf+/Y+yp4m4O2qSZtCdhsNfAGZ6VJOUQ1HYQ7OUh6ToEUnnsqLo/TsKkht2Y4So91FqJk8Swaq/VF+yKTuCLYNEEPgn5BzZOUZqk5Mu0osYL5AjNG0b2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1caFvewSLqMXRpRGyBe7OKVNPrecIDPqj+d/JRnqK2s=;
 b=JGlZ/ucMOzfqDj2yAnJBntYEsWRW+fxdKn8xFU3Bs6mXmKpMyTvkQfrsf+8erD/v5dc3bwPf7bOtS05PhvE2qYQMyvBSjLl6tTiZTKc0/oqWRh++Cot0pdNwvV89B1X8XigB1J5NZB/5lLBVA9m9psL2graWTdU+umwrcqd8GNxWbfPm5DqY7TXStpkMwW+1yjfY0KobzRmXZKehEyraV1dQT7691psrccIb0dgXs7jIKeycUklZ4KyF9Mt/MuuYcsCPRwlBMW8VDekJEGNnBsX2p9xmhlOSZIH+zxyrBRXg5n+dGxObPQEcUfoehvEpuh7B9RTCwka579YVEACp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1caFvewSLqMXRpRGyBe7OKVNPrecIDPqj+d/JRnqK2s=;
 b=m6xIWxjloMNcczr1Po3Tv1lAKo0Amo+rsP8dFYhVrPIAUIVILidYiaLlEpmtFl9BWcy/IaeLlGNHwskmsNs5xrZdQPsHLHIjP4aMwl9Ng2mAKMUms7j198rTENYqbs7gUsKtpwgGNNqvONrfaQ5FNEyEQoFG+Xj8WFrdc5nFj1c=
Received: from DSZP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::13) by
 DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Fri, 18 Jul 2025 13:46:23 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::a2) by DSZP220CA0003.outlook.office365.com
 (2603:10b6:5:280::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 13:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:46:23 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:46:20 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/8] drm/amdgpu/vcn: Add regdump helper functions
Date: Fri, 18 Jul 2025 19:15:37 +0530
Message-ID: <20250718134544.2594829-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250718134544.2594829-1-sathishkumar.sundararaju@amd.com>
References: <20250718134544.2594829-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 60067063-3652-40e7-900e-08ddc6017bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDM3STZRWHZycXFsUDNMR042Z1lEbnJoc0JsN3FJY2pOTS9LZUJmNGxBVVZq?=
 =?utf-8?B?bVI2SC9DTXZVSGVqNGpBUTBYa3hOeHNUQXZjU2crdTF3MHg1Znc1MjBGd2ZF?=
 =?utf-8?B?OWE1T0RrMmVwZmRVVHBuamhYWERGOXhWUWRtR3VtVHZJMEpNWEdETnhpM1ZD?=
 =?utf-8?B?bitwUnFsT2doU3RGTEtyN2wvc283ak41bUJIcFZYcTJXRTJsTG1yWGNvK0dt?=
 =?utf-8?B?clZHYWxpY1NBaWR6dHN1RmVGS1ZUKzBqOCtZRWNnNDA2NjZHSEVLdGs1SG9Y?=
 =?utf-8?B?WlBRSXRwK3dMVDM4KzhFbXBrWDB6b1hneXZmNWZGbUZuOW84KzhyTUlvaUFU?=
 =?utf-8?B?Y2VPSENQMmxMeVBkbGFBL2lUVVErd25wRldJZ0RUL3Q5QmhlSlUrQ2dtcGc1?=
 =?utf-8?B?OXJSeWlOQnhxVHdVNUYwN2pNekV3QWJvM0p3V3doYjhnR0ZERlNaQ3ZKbmJP?=
 =?utf-8?B?eUVMbEEzRlgxT0RFVlB5T1Uwa1FxRGhHU1dVeXRLVHdXR0xYRUd1bDBVSTJD?=
 =?utf-8?B?S1BtaVI4cWh2a3lPUEE1RUprK3lXbm1NTTA5UWRIUzcwNlNVcnBwNFVEd3Zp?=
 =?utf-8?B?WnNuQ3hjV0pldlRYTE9wK1FMSTZGdnFkQkQwTWpHZzVuaHNPdWthUjZOSHlN?=
 =?utf-8?B?aHoyQkt1REdQM3ZhMWV5YkpMTU4rVldMU0NDMTJHSWFJNlFiZXRxWVI1NVFq?=
 =?utf-8?B?M201RlpQcldVSlR1MVp3bUhIMEV5TlYzLzU2OXZWRkpIZWYzU0tNR3o5RmVo?=
 =?utf-8?B?NDROcm5yWVdBMEl6SDdMU1RJZFU3SmJnOXNGU3NWbjRpcStCcG1xLzI4b3dX?=
 =?utf-8?B?NzBIVllJZEJEcWNORjd2eFNhMVB1eEhSZnZJSkJRaExmU3hGd3JFd2RWUGE3?=
 =?utf-8?B?RXBMQ00zYUZuRW9sRnBlcVA0UDg4Y3dQYXdHN0dtWFVTNVZLYlNTcnUvR1V4?=
 =?utf-8?B?T1JsOGM3U3dWM2tqMVlzaTE1SS9ocUszSzEwNzdwcXFnZC9xRWhlK0pubmdh?=
 =?utf-8?B?REFVMWcvQkVTUjdTMGJtZzF5RG94QmtqUFA3Qm1QMVNJc0xuenhBak01S2VO?=
 =?utf-8?B?OHVyTkhFWEQ4VldBNjJsU0xPUjFIQjVnMDNuTFNOWjQvMUVLenNHS3VoSW02?=
 =?utf-8?B?M1phb0Jvem92dnl1ZDNIZjg0RzNRUnBoK2swbUQ3c1RYWVgwbDBMK1d0TUdy?=
 =?utf-8?B?TWh4ek9FbzVKemkzaHFSNzF4c0hJUk82bXhGUlVLNGhJdGFCRjcyMytFVXBQ?=
 =?utf-8?B?V01pSTdaM0pmendqd1BsRXZ4eXpwY3M3QzA4NDJkbHpONS8wdEhkY2E4Qlcy?=
 =?utf-8?B?RFljSWhpNGE0Slk1U0YzWU1qTUxmdStPNTBPNG1ta3cyMU9DTFFzRjhGdU1I?=
 =?utf-8?B?V1pNSXZocHBUL0NFSzc0Rmw4WVZ2MjRXNGplVGRrRWNYNFZ5Nlp3c25Bb2Ev?=
 =?utf-8?B?eFg0QVpXMDg5NzNLcVBvTlIxTXBTaGRZQzI1dTJwRlVxYXFaZmNlV1N2d1Jz?=
 =?utf-8?B?OWNVdWpFNnQ4M2JmN010dmw0NXlQb0k4eGVXMEltTitPaWhQZEZUUHlXOUUv?=
 =?utf-8?B?Z0hEbEFmaGtacFpUa2ZWbzJjUVBCaUhvOEEzVVVWZ0pJby9sd1E3Nm9Wbzcw?=
 =?utf-8?B?alcwK2lSV0JyMXBaOXpHNTFBZnRaUXd1SGdkSmZqdWZBNWE0cmo1c09OQTR6?=
 =?utf-8?B?VTZPVndNUXFIbGJoNG1PTUwvSTdlNGI3YWk5bDNOL0xTNnM2SXVCendXcEh3?=
 =?utf-8?B?dC9UWWwvRVFUa0F4NjJwdm5Jb3A3V0FTRWdzSForWWdISWlJeHFpNTlPcFpB?=
 =?utf-8?B?azdVUzBkN1A0WHZuNjNudmF1WXozeWxpRFFxSlNrZVJzVHVsZjNFS0E0LytW?=
 =?utf-8?B?UDBxeDhBR1hWWVpzRWg5S1pibHVkVXdYVEVlR2F4QUhlZnFNOWp2eFV6YWpl?=
 =?utf-8?B?Vm9XRnp1VXc4YmVEOFIrU3NjdXhvelhzeE02b1NVejZZVzNuWW1VYjRHSFZC?=
 =?utf-8?B?WjBDR0t0Z3lnSUpKQWtLMy9YOHdORjY1eURXZXpnMUl6S2ZYR1BRS21LWUhy?=
 =?utf-8?Q?O8JRQC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:46:23.2431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60067063-3652-40e7-900e-08ddc6017bf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

Add generic helper functions for vcn devcoredump support
which can be re-used for all vcn versions.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 86 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  8 +++
 2 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d799bc74936c..54d8d48fe733 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -92,6 +92,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
+static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i)
 {
@@ -285,6 +286,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 		amdgpu_ucode_release(&adev->vcn.inst[0].fw);
 		adev->vcn.inst[i].fw = NULL;
 	}
+
+	if (adev->vcn.reg_list)
+		amdgpu_vcn_reg_dump_fini(adev);
+
 	mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
 	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 
@@ -1530,3 +1535,84 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 
 	return amdgpu_vcn_reset_engine(adev, ring->me);
 }
+
+int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
+			     const struct amdgpu_hwip_reg_entry *reg, u32 count)
+{
+	adev->vcn.ip_dump = kcalloc(adev->vcn.num_vcn_inst * count,
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->vcn.ip_dump)
+		return -ENOMEM;
+	adev->vcn.reg_list = reg;
+	adev->vcn.reg_count = count;
+
+	return 0;
+}
+
+static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev)
+{
+	kfree(adev->vcn.ip_dump);
+	adev->vcn.reg_list = NULL;
+	adev->vcn.reg_count = 0;
+}
+
+void amdgpu_vcn_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, j;
+	bool is_powered;
+	uint32_t inst_off;
+
+	if (!adev->vcn.ip_dump)
+		return;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		inst_off = i * adev->vcn.reg_count;
+		/* mmUVD_POWER_STATUS is always readable and is the first in reg_list */
+		adev->vcn.ip_dump[inst_off] =
+			RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->vcn.reg_list[0], i));
+		is_powered = (adev->vcn.ip_dump[inst_off] &
+			      UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF) !=
+			      UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF;
+
+		if (is_powered)
+			for (j = 1; j < adev->vcn.reg_count; j++)
+				adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->vcn.reg_list[j], i));
+	}
+}
+
+void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, j;
+	uint32_t inst_off, is_powered;
+
+	if (!adev->vcn.ip_dump)
+		return;
+
+	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i)) {
+			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
+			continue;
+		}
+
+		inst_off = i * adev->vcn.reg_count;
+		is_powered = (adev->vcn.ip_dump[inst_off] &
+			      UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF) !=
+			      UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF;
+
+		if (is_powered) {
+			drm_printf(p, "\nActive Instance:VCN%d\n", i);
+			for (j = 0; j < adev->vcn.reg_count; j++)
+				drm_printf(p, "%-50s \t 0x%08x\n", adev->vcn.reg_list[j].reg_name,
+					   adev->vcn.ip_dump[inst_off + j]);
+		} else {
+			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 0bc0a94d7cf0..b3fb1d0e43fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -237,6 +237,8 @@
 
 #define AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING 2
 
+struct amdgpu_hwip_reg_entry;
+
 enum amdgpu_vcn_caps {
 	AMDGPU_VCN_RRMT_ENABLED,
 };
@@ -362,6 +364,8 @@ struct amdgpu_vcn {
 
 	bool			workload_profile_active;
 	struct mutex            workload_profile_mutex;
+	u32 reg_count;
+	const struct amdgpu_hwip_reg_entry *reg_list;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
@@ -557,4 +561,8 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 			  unsigned int vmid,
 			  struct amdgpu_fence *guilty_fence);
+int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
+			     const struct amdgpu_hwip_reg_entry *reg, u32 count);
+void amdgpu_vcn_dump_ip_state(struct amdgpu_ip_block *ip_block);
+void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 #endif
-- 
2.48.1

