Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBA8C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB5110E918;
	Thu, 30 Jan 2025 09:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P1tMlpWp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5457410E917
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUEJLzCmiY6XNx7Y6KGXYSot+HbO2gCAe+OIwpdAhHC9Cj7rysFr+CUS4iCpzbBrIT1ef667BDde8SJ5UKXiTi+ihRccAgn/uFv9cUm5OJgftf7IP1k0aeVv+5rCmVQt61gcfbzekguCqfXpAi9rB1S1dFqVLOr88iL3DyNc57v/0TNW9/0fSkx+WlkAdBI5NQs392UcHXpCpmpX/v3+ka+R+GH1zfuN9iz3xXzJj1ymVhlRjTxlia2pCBGRcpclTH6UayKFrZbVbKZdG3KUPgnjQlpuVpaGyGIfcbm5JcOeR9sInTIiH2IjkMnikleB7zA/d/g1V03UjEq+wRpvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJw7MOBdTh2jMNTuogM65PU+KmsoeTj5Ks27r04lXl4=;
 b=d6XZIU6PiOVyXMffji0zyxzUIdtvFHcOG5gXdSb0yOk0AYiRWqaZoXtPaV2SrGDsoMuJKdmjlF+hADq9UEBdbCCap7K6kdjQehV8MtzGw+uXKtEKv4/n3PFMOv8PenpcroALDEKBs+SULFiJUmefxwFmOQNS2yOixjI4oZ5FuLrSShfBt1gKkkb5D7rhUt7Jn+L0/beNid08hPl+35WAjCOj4BqkmgiCMwpAjN58ObcTmDNDcRYfZ0Qn8zHzLJNaPQk18SsGWz66SXNW6GnLSPanalpJOiV90lolOPZLyVZDoDLAk3V7+FjPuj1fj+GjPhv95E+hcQGfi0Ji6BgAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJw7MOBdTh2jMNTuogM65PU+KmsoeTj5Ks27r04lXl4=;
 b=P1tMlpWpjL8R+Vqp1HIp+9/Wg8UvVATSExbCk9rtH6n9eh5hg6/JRzWuo+ZmtQh8EdB5HWsw7gV96A+D/xCZ+XXaM8EMFnXonRcHaWU45+mATe63q5Ag0pMCEAvz5GoQje6Rt0T/4aGIY6bkZENpMC7jG/Y+9ilquOjhblfERVY=
Received: from MW4PR04CA0245.namprd04.prod.outlook.com (2603:10b6:303:88::10)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:52:11 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::ec) by MW4PR04CA0245.outlook.office365.com
 (2603:10b6:303:88::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 09:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:52:10 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:52:07 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v3 02/10] drm/amdgpu: Add helper funcs for jpeg devcoredump
Date: Thu, 30 Jan 2025 15:21:05 +0530
Message-ID: <20250130095113.534630-3-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: db4d8491-f668-4192-f521-08dd4113c41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVpVSlAxVS9HL2wydFJHNlZtemVEVVpsWmdkSFh0dXZFSEFPN3Nsd0ZqWXFS?=
 =?utf-8?B?U25ENmZjZlhDR3Q0NGpIMzBJQ1ZwUHpublI0K2craDIwTjFBYjNTanhhM3Fm?=
 =?utf-8?B?TUM2QnovYVQ0K1ZnL3RPanZWMy9rUXhRUDNLT1pKSE5iMU5rekk5clNwRjRq?=
 =?utf-8?B?dTN2ek83K3c0cG9VRVdCVlY2Um5NWTdGS2F5RVVPRmZQaHBrYzh2NjR3K1Vy?=
 =?utf-8?B?SUxITG93QWVDdTJlVmdrNEpCZWF3SEhObE9EMzc5ckpFcDJBYnR4Y1ArVTF2?=
 =?utf-8?B?dk1GK2diNk4xYzJ1SGc3Q0E5M29ReW5QQXIraDFCNnpweWhCak9QOE5lTmsz?=
 =?utf-8?B?YlVET0luVW8xTmg4NzZVT3Y0REhXdlF4c3hqdmcvakwveXEzRUlvYXFyaHB3?=
 =?utf-8?B?ZkRkNEh6dm9DKzZma0pObFpwVk90dDNiVGNvelBuU1lMcDh3R1VlbmJDdXlX?=
 =?utf-8?B?dDNoVGhnd09CaVZadmxWNkdxa000bVJFTS93bzJpZDJ0dXJPMWpLck9aWXJj?=
 =?utf-8?B?ajZqQzFMS2gyTngyY3ZobnZxR2g4djZla05acTNyRHB5aTlzMXZUejlucTQ4?=
 =?utf-8?B?KzViakZKTk5nN0duNmRzR1RNU1hRZkZ5QU9mdnJGdkdqWlJrR0tWQXhpampE?=
 =?utf-8?B?SE5qd2l3WUdYNTdsWitkaHE2VTV2NDQydXdIV2hlZklYV2liTlBkdW9MS2cy?=
 =?utf-8?B?MTdHaUpteTJUTUxEMUdMYTQ1cGEyendvRHozY0JpNHFOMzNiaHAwRGN6TkI0?=
 =?utf-8?B?N3hjWThQNUU5OHozdE5CS2cxSDdLamtJRE1OUklsY0wvdHJvMmxWNXJOOUNv?=
 =?utf-8?B?OGtUSlZLb0RuN3c0RHdwTk01TTY5RXZMN0RXR3lSaTQxUjBqdm5SYXd3Z2Y2?=
 =?utf-8?B?YlR0R25NL01aY0lTY3FmdFVjc2VIb1p4R3h5QUdXaDcxUzFWMWxiVEZvUXRC?=
 =?utf-8?B?UFpVUHZPbDdNR25WRUtZdmgrNThSbSswaUQwVko3ZzhubFRMVjV3cUVuak1J?=
 =?utf-8?B?LzhGYmZ6SW8yR2JXRW9oYXQ1OEwxTlROczQvVnhMZ3d5QkxFMUwrMEFuVi83?=
 =?utf-8?B?aTMyaXdKQkFFZmZSQ3VYbXNBSldBN2E5VThFN0N2bnM3SFBhOWV0eWxPcTFw?=
 =?utf-8?B?NnBRNFMwOWdhODVIZXV6ODdvNGs4emRURUJNbjNyeVNFMEpLYW4zeXFoUStE?=
 =?utf-8?B?alc3SkF3Q3lZYzRlN2FhUUN5RU93eHQwR2ZyVC9nUXZiTVZ4eUkzUXcxWjB3?=
 =?utf-8?B?bzhqOWJMQkx5cjVMWFV0dm84am9kWTV6Q1JEMER1amxwRnBjbHZjallpd0VL?=
 =?utf-8?B?c1U5V0phaXBuQ0VMRE9SU0FrYVNZZEpoT0pUMHB5Wm9qVGszcGlRbGdSWk1E?=
 =?utf-8?B?NCs5R2Mvcm1oYzI2OEdoUEJnUjhCV21QUXRrd1M4emVOaEZIcURYNWVxQkRM?=
 =?utf-8?B?V1JMeDJnRFZLeEE5TjZqRDhER3JYYlY1SFVUYy9TUnptckpsL3FjNWZXcm05?=
 =?utf-8?B?eEkwMG1aOTN1V3ZSRnV5V1FEQ0JUdFZHY1c4OW1YbUwyMHloVGk1Sk9UZk9H?=
 =?utf-8?B?SUVzK2tycWhOS2VvYlpOcG4xa3kwNWh4OVM4YkZPNm5jZzFhRFY3eURMdTIx?=
 =?utf-8?B?SXVIaEtmL1J3UjkxNENEUGY2bUFhTkhRVHh0aE1YY0pkUlBrNy9JSHlBRi9v?=
 =?utf-8?B?Zkx1TzF1M2Zhem8vVWFGQUpwUERKZlJvSW5LQVdBK3VuZjBwK1krN2REVDZQ?=
 =?utf-8?B?Vmw2Y3l0Uzgzd05lZmVwM01naEVGRnBYcG4yc0hpc0hWaUwzbHVObTRHaC90?=
 =?utf-8?B?WWFTbGVienFNU1JzZ05KbUhOSTZNQ2kwOVJ4SUlGWEZWTWNhaUppd3ZsVC9Q?=
 =?utf-8?B?U2gyRVRoUlpmRSsvVXE1blNPcTVtbFNyYzZvMllRcFJYNGh6cFVjWWMxWG1H?=
 =?utf-8?B?eXdQKzlpQmkzY0NVRWRMRzlOMENzeWNoQnM0V2E1bUhaZ2gzK2JwQnpCS1Rj?=
 =?utf-8?Q?YHFjkJD1JLAM3tf6cGszsNWz/VqXY4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:52:10.5397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4d8491-f668-4192-f521-08dd4113c41d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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

Add devcoredump helper functions that can be reused for all jpeg versions.

V2: (Lijo)
 - add amdgpu_jpeg_reg_dump_init() and amdgpu_jpeg_reg_dump_fini()
 - use reg_list and reg_count from init() to dump and print registers
 - memory allocation and freeing is moved to the init() and fini()

V3: (Lijo)
 - move amdgpu_jpeg_reg_dump_fini() to sw_fini()

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 84 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  9 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index b6d2eb049f54..dda29132dfb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -33,6 +33,7 @@
 #define JPEG_IDLE_TIMEOUT	msecs_to_jiffies(1000)
 
 static void amdgpu_jpeg_idle_work_handler(struct work_struct *work);
+static void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev);
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
 {
@@ -85,6 +86,9 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 			amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec[j]);
 	}
 
+	if (adev->jpeg.reg_list)
+		amdgpu_jpeg_reg_dump_fini(adev);
+
 	mutex_destroy(&adev->jpeg.jpeg_pg_lock);
 
 	return 0;
@@ -452,3 +456,83 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
 	}
 }
+
+int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
+			       const struct amdgpu_hwip_reg_entry *reg, u32 count)
+{
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump) {
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+		return -ENOMEM;
+	}
+	adev->jpeg.reg_list = reg;
+	adev->jpeg.reg_count = count;
+
+	return 0;
+}
+
+static void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev)
+{
+	kfree(adev->jpeg.ip_dump);
+	adev->jpeg.reg_list = NULL;
+	adev->jpeg.reg_count = 0;
+}
+
+void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	u32 inst_off, inst_id, is_powered;
+	int i, j;
+
+	if (!adev->jpeg.ip_dump)
+		return;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		inst_id = GET_INST(JPEG, i);
+		inst_off = i * adev->jpeg.reg_count;
+		/* check power status from UVD_JPEG_POWER_STATUS */
+		adev->jpeg.ip_dump[inst_off] =
+			RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[0],
+							   inst_id));
+		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
+
+		if (is_powered)
+			for (j = 1; j < adev->jpeg.reg_count; j++)
+				adev->jpeg.ip_dump[inst_off + j] =
+					RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[j],
+									   inst_id));
+	}
+}
+
+void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	u32 inst_off, is_powered;
+	int i, j;
+
+	if (!adev->jpeg.ip_dump)
+		return;
+
+	drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		if (adev->jpeg.harvest_config & (1 << i)) {
+			drm_printf(p, "\nHarvested Instance:JPEG%d Skipping dump\n", i);
+			continue;
+		}
+
+		inst_off = i * adev->jpeg.reg_count;
+		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
+
+		if (is_powered) {
+			drm_printf(p, "Active Instance:JPEG%d\n", i);
+			for (j = 0; j < adev->jpeg.reg_count; j++)
+				drm_printf(p, "%-50s \t 0x%08x\n", adev->jpeg.reg_list[j].reg_name,
+					   adev->jpeg.ip_dump[inst_off + j]);
+		} else
+			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index eb2096dcf1a6..4f0775e39b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -92,6 +92,8 @@
 		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
 	} while (0)
 
+struct amdgpu_hwip_reg_entry;
+
 enum amdgpu_jpeg_caps {
 	AMDGPU_JPEG_RRMT_ENABLED,
 };
@@ -137,6 +139,9 @@ struct amdgpu_jpeg {
 	bool	indirect_sram;
 	uint32_t supported_reset;
 	uint32_t caps;
+	u32 *ip_dump;
+	u32 reg_count;
+	const struct amdgpu_hwip_reg_entry *reg_list;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
@@ -161,5 +166,9 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
+			       const struct amdgpu_hwip_reg_entry *reg, u32 count);
+void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
+void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 
 #endif /*__AMDGPU_JPEG_H__*/
-- 
2.25.1

