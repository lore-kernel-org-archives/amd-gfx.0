Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04BFC54F2E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8AFB10E72A;
	Wed, 21 May 2025 20:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lj+CFUhu";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D46610E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epypjxNgZhDZfPPZpqPlKrl+z73xQLogg7eZhLQDah8bDCfDRsM2Xvw9M86rkNPZgBDDn1fVWAioH922r6/pPpfbhRo0walnJjncB74zdmyK70ZwA2vaXfoENMR7N9uOslykxd3F1ksD9atQNKD8c7T1NWgx6Z6jdkKePqRy+k0+1mvv0IuhtKwIuSQo4YSU/1POtQNxgL9HsQ4+CybYmkOoOEZUj4z+dBi7Zxzd4UC+HX+FfZFjufmnEk3EQnZl+E1C+l8XYzydCeezmF9pvfXNjN3O7thn4CBWbBsqjfniMhMzS8UDaTt6xHqXoBC+pTn+dEIr0bOuHhyv6gZj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87gJutJcKdXNHuUMFRxt3uEHHKKzoYHIEGZLuhsS41A=;
 b=bHQMC8JcN0ttrZFsQ/IC7aOOg1O6Q+2sxGGQ/3PsLnw/21DAVERuIlMsDZaIgoGzx1c033d9qAtcE/LCDlDP37/tOZMhlMasA2P7LWdQGqBd7OYJ+m60JnQe0UPOUe02nzKcPNXBpn1zzkb4OYtEHyYIUdBniJra4FgGS7R7wf4k6Dy4LO/jmixW/Bbe7AUCGT2WZiNYtLvAzf4QiWvpQmI4ZNdTy4wyIJe0NNqa3FAnwozcAPQGZ3jH1pHjHvMRo/RPwNbevfeiclxrEJ975NENfVFZ8CUtRA9H8FOEKW5DpbXuJvSrrG/n00Y2uMXM9N9hN2FlJxxSuxfHgYL9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87gJutJcKdXNHuUMFRxt3uEHHKKzoYHIEGZLuhsS41A=;
 b=Lj+CFUhugWgKaEI8yM0HgJyWRkRVTcFjQR33K7Me9j673AgfuzKG8rnZQ22qDaIYbKxsOjSKxylCGTGcgJ5afdfbYK8VuKPe907J6KcocTBcBDHoPts5kKkobK7AyDf1MtcOxKN392Hxfgaf26IQpEDROzn1PDiM/ZxDUUAulqs=
Received: from SA9PR03CA0019.namprd03.prod.outlook.com (2603:10b6:806:20::24)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 20:24:31 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::1a) by SA9PR03CA0019.outlook.office365.com
 (2603:10b6:806:20::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 21 May 2025 20:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:31 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:28 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 5/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:10 -0400
Message-ID: <20250521202414.18251-5-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521202414.18251-1-David.Wu3@amd.com>
References: <20250521202414.18251-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 96996cea-09b4-4340-8781-08dd98a57e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tzK+s15/m17i6EzUPX5od6GbLTfxtPRKgtquIQGbcpG0mBG5j0a1SEnQ615B?=
 =?us-ascii?Q?52xx+Ozh+tdrNOMVaH+rOnN5xbQFA0Q8fBdU+gr6cCJ73wIpVTOhpNvFB+sh?=
 =?us-ascii?Q?SPcVAJ/Ht1h+9K0nR5MVzc7Ymw7vIpfEMOlO2IxKgCSRt+7X5SgDkUVco0j0?=
 =?us-ascii?Q?RmXgoIU744kYtyo+d/D0+7fpyx+TJ0aHjlp8+U2DTLY4H84qusmOJyiMNCxr?=
 =?us-ascii?Q?dKGoe1DIephbrzVmhj0CSPsLpRuuxWeMVgrAFdhZGDjQV8uHUEohYWHKViGa?=
 =?us-ascii?Q?+4bHSXQHpTMb4r/UAeKQC0LgZ+tf2HcoIyfPM5UgHty15siawf/aMOc7SlvU?=
 =?us-ascii?Q?vj9awvMOp3PHWVX3TuzOElk9o1PAKLpJcK7iYlvf/S0Passah9QPLsWuyflS?=
 =?us-ascii?Q?WVcilDLS/IGkaAvGWFFFGrW6iJP15WHLeQcyWvQv6AVAnDgD2/8KltxVjjqQ?=
 =?us-ascii?Q?not1R9L5ecOpZpKbh5gRBr8YyVdzwkN1U4JV/beomdWJcL4SZ2p2BWX2Etug?=
 =?us-ascii?Q?JI82/cm70JXN2i7Mc2IxXlvLh0FV5CsPpn4xC1+wmm4boi8if2lPm7632Beh?=
 =?us-ascii?Q?E8X2DRZG4GTyGQqX0Isfyd39GjIrjxi/rF0SFNa/RP5pi5sG845qD/GgV+j3?=
 =?us-ascii?Q?plzjDdrQpMN8T0mVFf8Rfj4Up5KLTkuJagkusEKykG7cRR4LgbKxIRj+rJ97?=
 =?us-ascii?Q?8Jc6YSkpzv7DAPYBhwKGwhTbWNkIMNHoeRLQtTrUuLP70oc4dGMxEH9o93ol?=
 =?us-ascii?Q?sq8rUzTxvWHcvhopUojBS5j98HAuUabKDFa3ioqOdchwy7JbD7RP1yZBcqyC?=
 =?us-ascii?Q?PNLYWU5nX2KuCcKJ9FHxSAR1i0qN77nc8FbMzESnJc5cCL6W0l/kL+kMh8TW?=
 =?us-ascii?Q?zrF3GdwRcNo4BGCqivD4EOhdUYJdcFttoIYYcO5ZAAigoEERQgkQ7d9yMeMq?=
 =?us-ascii?Q?cpBVpJStTZ8eC9jb16A64xnGz1TtzIXJMQsH9hFVzJJ96C8NPIx9LZ+zFC/6?=
 =?us-ascii?Q?xNwkjwBF1cWlyOPlPZwfyrV3OgozxmyBVsySP1MMQiG6J/zqGsLUUNMA9+xb?=
 =?us-ascii?Q?OTwOBKI4w1LaHP5dSEwzJZF5vhQwC8q+q9NwB7VvGFzUHGvKz6qirIOuQAbu?=
 =?us-ascii?Q?ESU9BgGvh6cEE4LUH4VaWtY0ZHTa0MGGCTfal9/oNeoab/+hOd/+6WK3bplk?=
 =?us-ascii?Q?GHEpwQx48iZBeYD/DBxIoSpBwmYmD+2ar64Yd6Nh7RrNVpfOtUKK2uJrvBte?=
 =?us-ascii?Q?nZmezErwnRnAM+u5npD6tn9pvd4sAbeZuDwjv5J8xqsNTDOPw8lJz/cYdV2k?=
 =?us-ascii?Q?vSYpNnT+KT0TxSztXEvZHEf+WBcA7PWg812cPuKeCJXCwTmPybWlCndP4cRD?=
 =?us-ascii?Q?QMzAdKNn71rgZ9N/F1B2IOqAOXRNc6FP5H8hGpYMaM3ZhOL1pEImRst8hEdr?=
 =?us-ascii?Q?w/c0Jbq/0LOgEhO0cfb7UYIJbWh5oqPAQ7nnORzMKnXerD3jsXb9JneRKfVR?=
 =?us-ascii?Q?mhXdFhk2Bxs6FwZdWwhnZoGh705SlyjU8umU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:31.1058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96996cea-09b4-4340-8781-08dd98a57e42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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

The addition of register read-back in VCN v4.0.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8fff470bce873..b5071f77f78d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1122,6 +1122,11 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -1303,6 +1308,11 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -1583,6 +1593,11 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
 }
 
 /**
@@ -1666,6 +1681,11 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
 	/* enable VCN power gating */
 	vcn_v4_0_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.34.1

