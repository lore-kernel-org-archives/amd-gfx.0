Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8237606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ev6wnPqG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFA010E284;
	Wed, 25 Nov 2026 07:44:30 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EBB10E284
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 07:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6VcM8aWEndcJ7MBjmgH7KZh2cAD9sZTI9MUCXKrTzjwQtUanSuwAZZy4YQSL/TQcHRGzN7sagQOeIvKwNW1+3JK8HyXjHvk6AMRT15oOs8/707s49fsdv6Bvj9Iy1dNC2wNXTQwobdpfYfUjctIitYQxJV13bFiLP7zAR2SwSmMWYKBuuylTdI6ONgQY+P/kcjR1/Aeqxu43MfQZSPe37mZVET6gaWOKH5uVXNS2NzjLmyE4NBvbyPJdGxHMRizMrhXd5t5Rl9QzY8D06gBg1i+Hq23W04Ayye9tE7t+6bfo6coT5u25XZhIgd2dCVGHDdgB2nuMb10tFiJMz140g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnfhQumQxVWsappEwAmlsxvFo9AgQasgA1OTmT5lzZY=;
 b=EtYFHo/FYjjR7ZKEbCtAlvNLxpT598ute+ZdeO6jYay5DpIKEUzrLJpQXCKQ2oohy5J7AjRz/O6ytHUCi1WMyOt0WIfrKBLERh00Icrnj7hI1JfX6luX9B4kn4vudqg3NZFK0oqpH4r4TKhrmBK8gWAlRHWJv7dbzwMXODjAIbDl/lJVGFRLf3JJcP567BU2+XMnRLlPI1Q/P+eRdCykUcVdOpKP2o1JSSyt2SECzt/gahDoiafwkARFgaIqF6IiM/MoG2ndXlbXhTHP4MFrwI7fjhtgylt+2MSgHJ5n0IcUbevyCYExBD4jLpZ+nZ092bt2JiechyHVqxF2w+/HBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnfhQumQxVWsappEwAmlsxvFo9AgQasgA1OTmT5lzZY=;
 b=ev6wnPqGIWcm3zFMUTi306qczhmRisv2NV5E6qtx92FMvwy88990tHzjCoSJ78U1ufodH/NVpZzXeS/5k76N3Ulg4lg1WQTXXJq8QtnKpQFczyOiNcIr/jZvWvs513Dsru2uF1uAeavsuVF7UTZQcEqiG1wE7V4AZOqk4bEETOU=
Received: from CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::19)
 by IA3PR12MB920111.namprd12.prod.outlook.com (2603:10b6:208:711::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 07:44:22 +0000
Received: from DS8PEPF000000E1.namprd05.prod.outlook.com
 (2603:10b6:610:1ef:cafe::32) by CH5P220CA0021.outlook.office365.com
 (2603:10b6:610:1ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Wed,
 25 Nov 2026 07:44:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E1.mail.protection.outlook.com (10.167.23.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 07:44:21 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 01:44:17 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Avoid MCU_CNTL access in SDMA v7.1
Date: Wed, 25 Nov 2026 13:13:58 +0530
Message-ID: <20261125074359.3144477-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E1:EE_|IA3PR12MB920111:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ef86e7-d9fe-44b8-eec5-08df4ac7eb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|261021123027099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wh4/Q3uqajGL/6wq3+dGOWtPY4ZdsfyNsx/kQo1Zqz14ERgHrRM5wiswIyBHGJH0xYGUs0fWQvKm5vhaEMhxXOKfuq1PHW1oDDSSZUPHoANHcGkCOnUHlBylOpAXnOWTU6AnQ1qDLAR4tn5NEI/2DiO+w1MGPAP8hYvFc34yjmYZwhjhlIPBDbJARLG2BmLYBOGh2Nuvy/8fWbdqWyq9T2mPesrv4w5Lm7JnGjzcKnv4uIbAdIXgQms13tncONyQgyYDHlgXbwxuS0UEztAQ7XaTqbIjGdQ4WcgxMIrxS0ymDauwquZp12mW8pVuYRVPu+tNDy8AeUcOG5qk3YcXKl3W0tfwvy42RvHyZyMLEUUzMq/a0z2UK4evrYBf/NqZkTYMYNehWSu1TeXJNs2JCc25YJU+78W/rRSPC/Q9G9RB4zprPqEWZx2u6WTDCo5pgfJfVN3fKPt//qK8Vilg+nrSBVHQOhbYZrxCpaKP+qMXqG2IIYpJeKMz83m4p4Nf9ZwQkbaKPe9FL9w415IrGlHeiZgytcOfi0DeLKLAlDvXV30bY5xTKjeWoSzBeE8GJerUgiKheqW/OVXUyGS1PqvWTy70wnJX/b7D9bbuhlW2xOYG/Cjhg8zdB2O+OUrV1XzMDX3G5e7cc4v8yrxV6OEjs+kBYqoTK/U1qlR5cMqwYXcYP5Ag3jYIYli8PiwWXzTINktWfwXDEZsYU8CLZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7D6C5+LtpD5kH1cpst5gzRbkn9a1h/TGjpN3sbAtl8lZfuoQQ2/QJwDwZSFhqHCCA1paXmHbrwVlDEo4SDUAQ0HA/gU+rBxhGW2e38dgb9vMMVZbBYW/a57C5hk+tYn9boKdlE0Ecl6sxJ9UR8y52FJ3E+l2oDCemumEoNduKYVInruAx7VkFNJMLDVP7009ddODz3fx7C7lApIKdNu3pjtLi7G78zNExEksi3YbJ1+N72vbyilRSBEwJTKClNRvjbrog0sORMFtiqx2nr/zBtWwJ3BTK7V76OEqxHWelyf1PbL2UPCVXKEq6K1WD2s0eAWsiNG4Cya5JPtitS7Wwi6LlNKPrnyB7PGx2+tnL4w4bXsepZ2ZRY0cuNCNFPwxZ8L1dSkmrh1E9VUs8QQzgL700HQ6oGFZKSouyotsgepbDOPfye3euegpkspg30vh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:44:21.1941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ef86e7-d9fe-44b8-eec5-08df4ac7eb0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB920111
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

SDMA_MCU_CNTL is write protected, avoid access.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 33 --------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index c6b2c46db4c4..3e8facc0358d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -436,27 +436,10 @@ static void sdma_v7_1_inst_ctx_switch_enable(struct amdgpu_device *adev,
 static void sdma_v7_1_inst_enable(struct amdgpu_device *adev,
 				  bool enable, uint32_t inst_mask)
 {
-	u32 mcu_cntl;
-	u32 xcc_id;
-	int i;
-
 	if (!enable) {
 		sdma_v7_1_inst_gfx_stop(adev, inst_mask);
 		sdma_v7_1_inst_rlc_stop(adev, inst_mask);
 	}
-
-	if (amdgpu_sriov_vf(adev))
-		return;
-
-	for_each_inst(i, inst_mask) {
-		xcc_id = adev->sdma.instance[i].xcc_id;
-
-		mcu_cntl = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-					       SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL));
-		mcu_cntl = REG_SET_FIELD(mcu_cntl, SDMA0_SDMA_MCU_CNTL, HALT, enable ? 0 : 1);
-		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL), mcu_cntl);
-	}
 }
 
 /**
@@ -631,16 +614,6 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_PAGE,
 			    SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_PAGE), temp);
 
-	if (!amdgpu_sriov_vf(adev)) {
-		/* unhalt engine */
-		temp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-					   SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_SDMA_MCU_CNTL, HALT, 0);
-		temp = REG_SET_FIELD(temp, SDMA0_SDMA_MCU_CNTL, RESET, 0);
-		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL), temp);
-	}
-
 	/* enable DMA RB */
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_ENABLE, 1);
 	WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL,
@@ -831,12 +804,6 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_block)
 		//tmp |= SDMA0_SDMA_FREEZE__FREEZE_MASK;
 		//WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FREEZE,
 		//		      SDMA_INST_OFFSET(i, regSDMA0_SDMA_FREEZE), tmp);
-		tmp = RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-					  SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL));
-		tmp |= SDMA0_SDMA_MCU_CNTL__HALT_MASK;
-		tmp |= SDMA0_SDMA_MCU_CNTL__RESET_MASK;
-		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_CNTL), tmp);
 
 		WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_PREEMPT,
 				    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE0_PREEMPT), 0);
-- 
2.49.0

