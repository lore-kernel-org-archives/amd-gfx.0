Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED277C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 03:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9123110E4AC;
	Wed, 15 Jan 2025 03:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vzCEqma4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0F010E4AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 03:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrausWIf78Ql0lqKZDfg0OJnDFrxFYaB6Tf74sQB8eqFNdF9Ev0cLizJbTuvGmOac/yehwpzKBaI13UdLATnm0aS88mS3cwAdpmuYVgk22+YDxKDFPkZ2VJRTEmuxokILqsXaIJ8iDgOA1DW1N1FIKdEZOk2tWf9PjW3Mf+e4YYY9rVeEb8xtbMpj7TdB6+TQbVoss+1sGk+THdoO7BKGmVUZWNfTp7L6mj2LCXm2rmNnhkpUHOkWYrSwz5cv427MUs+vupbeprp1ut3ketDFX9FcI7XNnEBUU1U4gFhtCHNPo4gk1B6u2d34UBSSazGxvc4tBdS1exzLgk68fnzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH8ZPY/O4uirENaXoX0I5WRcU3Zp6E0HzWfSzN4xIys=;
 b=ikmyie4W7Y9+Dr7DhGIRC+DAc9b8s/ZUTrYN/Lb4HKWyJBmWBZjmhwFO8Zusc3gyY7gfxp2FvLo87PMOlJuEnHuh0e4v3h08uPFIrdZdRwnif/rNt1lpFxaa548cmYXqyKqEnGweRn2KOAOS/317U+Y4dj7DSiC1QAPonOEy3vU55lSfv8PsqrZdgbqBR5i2QwnK2bKcbfVWMIky8foNQc6MIcyzmKUw+eC0RkrPIlixL0/MzdlU07gNwmS1+GuamKkEi8a3tAJvGYhCs/lEIN9Epdh0NtsFwYMVGZrZ8BF/R3F3v8IomUHrgj7oSfhhu5azBNcPPVOOcLuvywNofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH8ZPY/O4uirENaXoX0I5WRcU3Zp6E0HzWfSzN4xIys=;
 b=vzCEqma4wGT7Lz611/FzkFlvfuxTHwhy1x3AP2EqVYdcH8PcDdIgjUv0Qiyf965oRBJu28on/n+T56v214PZlie8tIcMdZ3Bd4n5s2RKikH6SNGt1SaKy8PqXqy/nU7KC0zEyYlTQWcHMwb8dXMqHkWKSwPhf+sffpScKRRd6fY=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 03:51:34 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::1e) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 03:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 03:51:33 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 21:51:00 -0600
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Enable scratch data dump for mes 12
Date: Tue, 14 Jan 2025 22:50:22 -0500
Message-ID: <20250115035022.531358-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 017c9bdf-51b4-4dc9-1800-08dd3517e73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MJYjCnF3j7FA+tuT0QYUVq4edMpG8hTYQxnX73TU9P2v4XJvWRyEC1mjDYP5?=
 =?us-ascii?Q?SzsBKw0L7IcJi7ljUQeMiYU2XHAzlmYfoZLlBOj61zXSbannTXmkXYt4pXs4?=
 =?us-ascii?Q?vh4TkOfvpDSJeXlHOTbIrCEtkCcuKx3u3x4DniiIjHrkdrSaHHg2w3hO9d6L?=
 =?us-ascii?Q?/elcg2W7sHfuQwoCvC2r7s8My9ZrFvrkOqnferTkiZ70l3R1Nu3hVPfT9o5b?=
 =?us-ascii?Q?zbIEg3tpfD59Xl3y7pdmLjzd8BbGdpet1/B4sJ6kzl1Zen4he19IEzqHqy7h?=
 =?us-ascii?Q?OkLcrNKkPyvShqAK89OC9Qc8/xH7ObNz1LSctHvLj3TUvkLzRHWoITjEEinn?=
 =?us-ascii?Q?+NiofB+2vRqgJ5/DjUkss0nwL0g8PBgvcHV5ZbO4N7Q+Y9UP2wieeOWuS0Yd?=
 =?us-ascii?Q?XLSTrqqnrmS624abego07DUBPs7GmupCQMJQqvJFs/lUClxVphmhUMNLBHuV?=
 =?us-ascii?Q?PNyDpcpFJ3oylzrUCSnIaa0l6rqe/w3QeU/B0biWjwQWmvezNxFpGzfGY+xs?=
 =?us-ascii?Q?9pDnVMYdGwo/kmEPLMSUMAIEy6eYf0zAJeL+FZovT3mMEFDqaNWWLe45+HGu?=
 =?us-ascii?Q?TbT1IUF46D/cE6CxRs2m30KcViUEkuj3iPUGcYqRZYu4Ts92ZnlIayOTxBH4?=
 =?us-ascii?Q?YKAB63ehF4dMkZ6tY/d+Osml17skLWr2QwVBkHW1whNc3Fx/Ys/AYRuxlMpO?=
 =?us-ascii?Q?jVVx3YDfU2n5s9iUtd2BOAWXU7zw46tH7uRyxrz4aOE+CogwcXCy3H1E64uo?=
 =?us-ascii?Q?vAX+DJBGUjaWUU2TojrYMxiqMlpxPDmN9x89R6KufFhtVvkYfCQRoEz9wdD/?=
 =?us-ascii?Q?tJFrDdRQ3yKSwGas+INxP/ujfbFgE3YjIJi3Aw/b6ugNgk0sb8XaMYu29gFt?=
 =?us-ascii?Q?hEIGTLHOH7kKzZ2HMlnxJ1SFvRhIHCG2pr/CBN/MH32Fw6eK9pwQSrORf29k?=
 =?us-ascii?Q?7Wp/dELwgaR092O1/KLQppMSIk5z63WnDW7lWvgrpYHT1SwPaYDGZvztzGGh?=
 =?us-ascii?Q?EBjpIL5Mc5NUmbm9ZnkE60+QliN2mzIiG4zJC+mTChEtJkIK7yiHD29YUE2r?=
 =?us-ascii?Q?Cl8dWFcGsXmS4LQMmqFUSGsAtev64iHZaG24m0C5G2vm3M0p/ORXuDt1/bCl?=
 =?us-ascii?Q?EfKv/kXBdSJOzroUC8z7qPG5e7UKcCFkWbsSERDAJVjejbkMEvDBjxDhoj/o?=
 =?us-ascii?Q?m9G2jLzMtsX+nGxaS+w/pPH8HtJmXtu9daaJ3HF+ryZ6HIw9pfojjJTpa2Jz?=
 =?us-ascii?Q?Muhac9r+ZHtNQKOEx9FvJsujxWhSG1g5gpeXqE5N83tiiw5cgnHa1L5VzegS?=
 =?us-ascii?Q?DicUGmX4Es5c20arkCizA55Uelk50hxJQFsArvCmYO4qFwiR/w5KO24ubhi7?=
 =?us-ascii?Q?3XvCU/1TJcp/mj5FOPgBsridueODDhQDvAxEInIt8452rijQ2Xkv3qCAkQde?=
 =?us-ascii?Q?U4iSDneAgYz03Ve3FRT2T1d2fKD631XaT3Ukfi1ZrLDe/BoiBy0oheEArtCl?=
 =?us-ascii?Q?Qr1ADzOC0bRn25A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 03:51:33.4623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017c9bdf-51b4-4dc9-1800-08dd3517e73a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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

MES internal will check CP_MES_MSCRATCH_LO/HI register to set scratch data location
during ucode start, driver side need to start the MES one by one with different
setting for each pipe

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 43 +++++++++++++++++++-------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index d24a0e7fff15..f79edff19333 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -992,29 +992,47 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 	uint32_t pipe, data = 0;
 
 	if (enable) {
-		data = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
-		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
-		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET, 1);
-		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
-
 		mutex_lock(&adev->srbm_mutex);
 		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 			soc21_grbm_select(adev, 3, pipe, 0, 0);
+			if (amdgpu_mes_log_enable) {
+				uint32_t log_size = AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE;
+				/* In case uni mes is not enabled, only program for pipe 0 */
+				if (adev->mes.event_log_size >= (pipe + 1) * log_size) {
+					WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO,
+						lower_32_bits(adev->mes.event_log_gpu_addr + pipe * log_size + AMDGPU_MES_LOG_BUFFER_SIZE));
+					WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI,
+						upper_32_bits(adev->mes.event_log_gpu_addr + pipe * log_size + AMDGPU_MES_LOG_BUFFER_SIZE));
+					dev_info(adev->dev, "Setup CP MES MSCRATCH address : 0x%x. 0x%x\n",
+						RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),
+						RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO));
+				}
+			}
+
+			data = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
+			if (pipe == 0)
+				data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
+			else
+				data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET, 1);
+			WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 
 			ucode_addr = adev->mes.uc_start_addr[pipe] >> 2;
 			WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START,
 				     lower_32_bits(ucode_addr));
 			WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START_HI,
 				     upper_32_bits(ucode_addr));
+
+			/* unhalt MES and activate one pipe each loop */
+			if (pipe == 0)
+				data = REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE, 1);
+			else
+				data = REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE1_ACTIVE, 1);
+			WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
+
 		}
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
-		/* unhalt MES and activate pipe0 */
-		data = REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE, 1);
-		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE, 1);
-		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
-
 		if (amdgpu_emu_mode)
 			msleep(100);
 		else if (adev->enable_uni_mes)
@@ -1488,8 +1506,9 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.kiq_hw_fini = &mes_v12_0_kiq_hw_fini;
 	adev->mes.enable_legacy_queue_map = true;
 
-	adev->mes.event_log_size = adev->enable_uni_mes ? (AMDGPU_MAX_MES_PIPES * AMDGPU_MES_LOG_BUFFER_SIZE) : AMDGPU_MES_LOG_BUFFER_SIZE;
-
+	adev->mes.event_log_size = adev->enable_uni_mes ?
+		(AMDGPU_MAX_MES_PIPES * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE)) :
+		(AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE);
 	r = amdgpu_mes_init(adev);
 	if (r)
 		return r;
-- 
2.34.1

