Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8747AC5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22EC510E91C;
	Tue,  4 Aug 2026 09:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I+Ks2Ki9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5648510E91C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPjTFR6/c17I+mPLSK9bouFV8BbVsXuSCYtdoyL9f/F8zc+4VlBtJih8hZRv1G9qKyeFu97/D6JMahMIBUqT7miuxEZxrUDtXapuynA2LtU//8T5t6AZLjlcC4Kq/XbO25OqMA5OzbIPXX5qiB9FeqzF3RI9jjbKSZ/q0ZAMJ4Lc1DwQ5njJFQH7jW4paOIShEpE8b1JMO1YwK+fi18cuC4801OZ8n84GROUJ40DgNpyC/bh//2IxUDmj+y5IkV5YeKTDDMT0SAje4dPRxuZPzxImTnvfnu/3RWoKrcB5k2/UiP42/fdqS+4BnuiVu33yca0dN0wjcPG3B8ixTw8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAmbOliEqX74abmIK8o5dVWL0yNY6wIug2Pfs5fPufE=;
 b=vi95nD+4oM+hgBzYHj2/GwGXa+1rzEbSOGsR9sTMGqYJht3523KjCmzpxDskFsMF2ZNiWXdUTzyhniSAJDS97ZvmX7OWikSReWesFO2h/LY17YTBWGH5wHLETV18K5tF3t1GK+D5uF3foAB0UG+w2U/2JU9SW4cSfHjB3Gs05kdjSZLtJKDtc8UDaebzHtZxXjimaTa9WPAUTkirsxSC0hmt9ig4D9IfkxRq9LaripmHZ3mDsb464Q9mzQA7vmJ9dekPxr3iPnb3LEKxSOmCk5Xd28hRpOAPq5LkM5ph55QAuH5RgzkytG/mD26Em/65wXZuUf2hpx1celWyCkJf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAmbOliEqX74abmIK8o5dVWL0yNY6wIug2Pfs5fPufE=;
 b=I+Ks2Ki96U6GTo/zTMsn5ez65uoOpD57TigzqJ1IPwBZhMdd7Rm6d/NPER/bI+tSy4AryQL5CyrKVKk/gumTvQ+tsFyZ0YU3Oyn77hCWaGXO629ENn1dM4RqyfnMsqoURQ2h9NewmF7YhDY3RphuGE9Y0ENX4MdKd6Zc7Ft7ry8=
Received: from DM6PR21CA0028.namprd21.prod.outlook.com (2603:10b6:5:174::38)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:00:19 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::4c) by DM6PR21CA0028.outlook.office365.com
 (2603:10b6:5:174::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.3 via Frontend Transport; Tue, 4
 Aug 2026 09:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:00:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:00:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Simplify SoC power printing in debugfs
Date: Tue, 4 Aug 2026 14:29:51 +0530
Message-ID: <20260804085953.2947798-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b05003f-356e-4cf9-bc6e-08def206ceb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: CMBfvlydulRi/yll83UfNZdO9CYIXmJd9qtvRlhWcmuKNT2rtdU31PpNxq8eZMOB8trQNYenkO1scZwB0Gwn+FbfAvVF6ikJ3T0J611AWmBopLXXLBi0+ZFRbyqmFJmRsyJkyJNTM5CxMmyVfOijNv/c5RnBpMThCtDSaFFo5gTO4QZSQQagXwSY1Mg7z/5VDxN7lJ9bQlFCyvtw56at3bS2RTcKDf9scKad7vQ7/DWOzIqw0OrsJWtXTXdxM0uKe2banjfGsmsV9iRKBF+G/OI1o7/GSj0ECNgchFLvzYkVuAiHRIT41FKsm8UZzNpVMTxUUo94C9uJzR3eIgse32lDjNYayeUCy3MjbtVB2oY7kw1qhRIkYjQPm2s4OYpiz7WKCMpmDE+9XhoS1vzRPvxUAVsa6Pdj1Td/zFzp/WOWzISo6u2tfatpy90U1vg/DqnVkHXNwzocalnZevHebR6zifrToicgionGDNmxRV9EJ45yZ4TOUYik2R/B0P7ZlQt6olCrUoyv1QU+g3AKpV4+N/VhQUoHKx2dGuaRrnATHWSLZYhsM321VCoD/m5k5Xoc8CmPAvPHfGla4m0EAnMv1yGM/6tfpOCUdNqbvrGuTAexy902d0U4I66mjxzfuIPtZuc5J1R5Luzminy4oCyYPN0T24hBWvHlCSDmruNNfmml2yS994TetrMbJis5byR5ZX3eY+yJkCdmuRxfGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OpktXPBzPurKiW1jwneTDvaW/YNLNXsK29C/+H19PNdmfMBplAg8tFdzIIV1yNLXTuFAgSuSG5YapI9bmuPvTe/SbShWTqXkJcRmOgEFaj+nDojadej/YnExONG9rmkxixyuKb+nw2OhAYBD5qUsb2XsRT5ylunpGOR4O18SUXLNHROF7vaQHtZBhm0ZltCABiEWNGrcGZ5zn0s0hGNkLFK7/raId3TJDFlw7OjhANKK9xd3tH0zCKpgt9epgcentH4AmbYJOXhBKuD/SUu3CcnBGmvJQgpWpLH3eJXvmnKL/s7yH7sI2+3Zkm8qeSNmv4S4P+zL5V8n5/JOgAme7IJJu/sBs0LhAQDeDnNwLnaZRCUYZ59xYNcrjK1ERea58Y0H5Cl18I3wfAm2bAvpEQR7Tw9jnlTbhEcPsMWrLfLHExL9WKr++DM9uGEOuf0f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:00:18.4142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b05003f-356e-4cf9-bc6e-08def206ceb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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

Convert SoC power directly from milliwatts using MILLIWATT_PER_WATT and
remove redundant variables.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 15b2923d5378..c0e677328af5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -34,6 +34,7 @@
 #include <linux/nospec.h>
 #include <linux/pm_runtime.h>
 #include <linux/string_choices.h>
+#include <linux/units.h>
 #include <asm/processor.h>
 
 #define MAX_NUM_OF_FEATURES_PER_SUBSET		8
@@ -4876,9 +4877,8 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 {
 	uint32_t mp1_ver = amdgpu_ip_version(adev, MP1_HWIP, 0);
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
-	uint32_t value, mwatt, centiwatt;
 	uint64_t value64 = 0;
-	uint32_t query = 0;
+	uint32_t value;
 	int size;
 
 	/* GPU Clocks */
@@ -4899,25 +4899,22 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 		seq_printf(m, "\t%u mV (VDDGFX)\n", value);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)&value, &size))
 		seq_printf(m, "\t%u mV (VDDNB)\n", value);
-	size = sizeof(uint32_t);
-	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size)) {
-		mwatt = query;
-		centiwatt = DIV_ROUND_CLOSEST(mwatt, 10);
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&value, &size)) {
 		if (adev->flags & AMD_IS_APU)
-			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", centiwatt / 100, centiwatt % 100);
+			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n",
+				   (u32)(value / MILLIWATT_PER_WATT), (u32)(value % MILLIWATT_PER_WATT) / 10);
 		else
-			seq_printf(m, "\t%u.%02u W (average SoC)\n", centiwatt / 100, centiwatt % 100);
+			seq_printf(m, "\t%u.%02u W (average SoC)\n",
+				   (u32)(value / MILLIWATT_PER_WATT), (u32)(value % MILLIWATT_PER_WATT) / 10);
 	}
-	size = sizeof(uint32_t);
-	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size)) {
-		mwatt = query;
-		centiwatt = DIV_ROUND_CLOSEST(mwatt, 10);
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&value, &size)) {
 		if (adev->flags & AMD_IS_APU)
-			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", centiwatt / 100, centiwatt % 100);
+			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n",
+				   (u32)(value / MILLIWATT_PER_WATT), (u32)(value % MILLIWATT_PER_WATT) / 10);
 		else
-			seq_printf(m, "\t%u.%02u W (current SoC)\n", centiwatt / 100, centiwatt % 100);
+			seq_printf(m, "\t%u.%02u W (current SoC)\n",
+				   (u32)(value / MILLIWATT_PER_WATT), (u32)(value % MILLIWATT_PER_WATT) / 10);
 	}
-	size = sizeof(value);
 	seq_printf(m, "\n");
 
 	/* GPU Temp */
-- 
2.49.0

