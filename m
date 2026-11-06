Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22D606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NtEj78U9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF1F10E3D8;
	Fri,  6 Nov 2026 09:52:12 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8327D10E9E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 09:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj700xVC4Gc7kSV04JJi12tyZLBasLIjiRRLpTDusUssYpgtHQNWzB93N/2j1FIwC/XTOMSPDJazsuVw4ABXNlkDcse08GkUQsUuFGwvLvUoXFxEysXqrwt6tU55HR0QXtwSZxxxi+/HcV+GToSAOCtycxZH9uHYTgU2U6IoqYNY0PC/8cJku4te0YwjTTtSnevE6DFo57X32M4Tg4/RdbC1esbTda9cbK3/jR8CuOORhabDyJaRNw0xGLX+OnjmvaU7A6QxKk7igp0rBYmuKVrbbnczhZT7NF0ZHjQvxyDH9fqR7H5oruurq3sHRVWZCvc2DWFRTvzY/6zCEwaMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I6Udv/m044HLXxmkp+mngk8cInGahgdA0i9CGJmdFo=;
 b=m8697twjKkm8QCY7dGp9TuI4aOSXy27DzWwfNmwDYz4h1RbWM+Wg7R80Z8KpD43vKc1j0/lFT4jjDY0L7eDedFH4hnQnZkgZ9JAkiyHZcGAB5E2El1DfC9C3i1fSpSbl3iVWWM24zWDGWXgYsHBvQB9o7UK5xvYHZx8dOcNJfa4vODiGhS/1ujpwu3d5wN5jNCc/73iHPsU+lPHIOx77oIQEJoh18TcAw8F5iSi8s180YuGZYPD4OYDdkwqWd09zGfbbWjy6aR3mwrsZexTj2UmtJ6+RPs6p4bwqv/RriTozbKaePZ24AKmL/LSlZqnvJJ1Uqxc9ElDdDe6/dctIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I6Udv/m044HLXxmkp+mngk8cInGahgdA0i9CGJmdFo=;
 b=NtEj78U9nGY9jUh5USJv3AHWJKZV5qPP9nS9HN96rVfRWUn7n6zG1SAWD7KwR/3J3p+IMbBZ6pWVx+czkS87bt/QHlkwpnvXk9rjoYBPMO58YZad7O9OWh8TIrOamOzhuZb09zSufMQbV0JfO5sord7qCmkcVuhbbkCGvMiiJcU=
Received: from SJ0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:2c0::21)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 09:52:03 +0000
Received: from CO1PEPF00018863.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a) by SJ0PR13CA0016.outlook.office365.com
 (2603:10b6:a03:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 09:52:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018863.mail.protection.outlook.com (10.167.249.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 09:52:02 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 03:51:59 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fetch TOS version in PSP v15.0.8
Date: Fri, 6 Nov 2026 15:20:30 +0530
Message-ID: <20261106095139.1328806-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018863:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: cb68cd8b-ec2d-4e92-389a-08df3beb9b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|10067099003|56012099006|11063799006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: yctUq/+G92ApZKn74MfZOgGnZdobe8hk6+Ke8MMcJ05G8kTjbBiAg6Eda7xh2QGDQ4vpp3KyCP4+XbHLgi7J/g4d1nPxZYWo+ZUZskwKL4ABHqFCFSjGCtfImvkpsWj34iCzBE0ibT+pntHqwLRCq22anejR+hlYvA2Ie7Wgfv8oCrnhda5JkBKbspoqSkNAdWogvMpt6jgUBBOkZ7jVidRiNi6Ci0YyGl2VVrB6HSFSiNiVtqgzOIqUY4uSJ5YryFScyKFml6GvPT8DDH9TcXLCI9TFfrrSJVlsqz/f3JfabhTKwlsLKlygP0vqLjeKeWeF72RDAgHN6fKQfPfYBtt0fEzMtOFC9oJe3Ji3uejYPPAnGNUdVPKdL30x9vGWsfcU/LErmkcApM9F/UfB1kkM9KAIstmO2SS3OozMTJP8sCshalgMUm11xG3ySBa1++QSjbpAXWC30TMdo+gC7p0iP0sLpBHj8PPG8XKKT3sZ0ptXs9GDnqjrmrPKp4dTD43RlTuFQXCOPyxvkDvcydPG9RowCRCxGaVLFRiP+8siUtmZiAyxAOu2WtKYG1bGcTSor0XLvBYBs7zjmqiJ8sGt96YaPmA0srzedVFfIH9YqZRgUw/HKCKvgkdnysxiXp/FgZdi0Lu6aru7cpqYzbDRLVJbeHTGWL48iZ6jVtvYpt1lTFIBh13FZ0O2OxHTJnS9SV3xWGM2r8L2WagqUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(10067099003)(56012099006)(11063799006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Ivz/b2GexkQ3albeFjUvmOB0v73e56yEX35VuLZT4bf3lmLpalxRJ1bC/Bry/lEvK3mrEU1BDXrgE8lNKl9l1R4F+MwSWzTaEjQ+K+oibGq4rAx5XI7KqxNtjpt9Hf+OAKymMXhf/JT56XFA5ZhHWz4Ti39sOd0j0Ol/yebDRPRWKZx+rR9vqfnRJLzFEC6U7pSKm3cd07syyytTZeXbExHHvDM8/UKZi79t9x2Sl6ma4vMa8orFSmJIGz8F64t6xCFl6hsk/S0zN6WFmjqLY5dGIV3XJqfcAUMEm9XKZyEQhoD7EoPeGXU7hbry/EezUIIBjQCmecyLRvvkUj70FNjeDon46XlfXeqwlfEN385pRr6K+J2oT1q4RSwwHXFJnoMAhCTr1+WP97eLVNuo5tdpOvlvd1tI7G1+arv0tmNMi5IMMZ+twAaeEBdqF8m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:52:02.2201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb68cd8b-ec2d-4e92-389a-08df3beb9b96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018863.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For PSP v15.0.8, PSP is initialized along with VBIOS. Query and keep the
version during early init.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

On VF this register read doesn't work, skip reading it for VF (Asad)

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  3 +--
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c0ed3e24b684..548e017311d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -191,6 +191,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 
 	psp->autoload_supported = true;
 	psp->boot_time_tmr = true;
+	psp->adev = adev;
 
 	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 	case IP_VERSION(9, 0, 0):
@@ -298,8 +299,6 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		return -EINVAL;
 	}
 
-	psp->adev = adev;
-
 	adev->psp_timeout = 20000;
 
 	psp_check_pmfw_centralized_cstate_management(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
index dcfc9be269b0..d64a32565d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -36,6 +36,14 @@ MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc_1.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_rl.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_ta.bin");
 
+static void psp_v15_0_8_init_sos_version(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	if (!amdgpu_sriov_vf(adev))
+		psp->sos.fw_version =
+			RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_58);
+}
+
 static int psp_v15_0_8_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -507,4 +515,7 @@ static const struct psp_funcs psp_v15_0_8_funcs = {
 void psp_v15_0_8_set_psp_funcs(struct psp_context *psp)
 {
 	psp->funcs = &psp_v15_0_8_funcs;
+
+	/* Initialize SOS version as well */
+	psp_v15_0_8_init_sos_version(psp);
 }
-- 
2.49.0

