Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F1606A320
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EDmFRkSB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050A810EA90;
	Mon, 19 Oct 2026 19:07:31 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 424D410EACB
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 19:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDYPcooL8eiXDYCj/Q8j6nozADMWg22vm9mV/F9Vyp2JLrrWwSoDzsEbjUU9pMevoG+1OtGGxUqFrWcHBHsYXgjj8TZgUnmlBrrSWHHii0HBYKH+grXudHMmr1fl257NjZYzqhMoz+rKRy/whaPpTE7glxDxkiKr8WpSG7hsVzdWClDy3fn0l/6yFwLt/yV9haGaH7buQ6P1M3N81FPTb8yLKCjfhcTJxtao73k8/MIdDnaCF+C448fgXWrirjQdZsH0drEejrgyfAObSCS9RfnBxOVV6z1XCpXfeZ/kTXQSjRRg6U3fPj9mA/byPHjJrlhvhTYTmhORirBsu/DWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awcMSfJtKdPdolOmnP2ZdUDqoB7282jmUkO4E4T12uU=;
 b=smQv+DoMdn/HKR2fEi5u2MfdyYhHZD0N8HhBUylCc+IewDphOOLrtHgL/xub6PF5ylWmyECSiVkTNDHOTnCOPAA8IwEy/+2ZSu3GdL+g0261V8ELKLo8MxhZCSjMQbF0vipihHzyXG4Yj24PqiVPwv3bHWYCBgda9kO7Qp5+YD4knWIPaw7w39nHknuUguy6XPBCmh8dd2QjjN8Czxd5IIOyw8SRiGZf2FmuZLoKSyn3tJfi7HsQmKNbb1Sd/x93PNwJmN49A2+bWTIDwN0Vt8jKW5f9xfhMFaVm3JKwgBTfwDMJNzp07RLhAoGmBxwmtW0QEVqJ5D6xgkh1uUjRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awcMSfJtKdPdolOmnP2ZdUDqoB7282jmUkO4E4T12uU=;
 b=EDmFRkSBp9FNGTvsOABAGT95CC9XMA8W3Hleuq3q5awXmDTupNk9krDoLDRlvI1vIweOBrGqX91ertNePIw/9u6en1tXVpNCbe+MGGcRF2sswKDcja4jXWlEZngsQ8AqKM8mKzI5x9Kyk4sChkBrAeFpyhq5om3cRGRd6UcpwZ4=
Received: from CH2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:610:51::17)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 19:07:10 +0000
Received: from BL2PEPF000352D1.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::6e) by CH2PR15CA0007.outlook.office365.com
 (2603:10b6:610:51::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 19:07:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL2PEPF000352D1.mail.protection.outlook.com (10.167.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:07:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:07:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 14:07:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/sdma7: don't access registers in MQD setup
Date: Mon, 19 Oct 2026 15:06:58 -0400
Message-ID: <20261019190659.2773961-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019190659.2773961-1-alexander.deucher@amd.com>
References: <20261019190659.2773961-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D1:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd2f502-90f1-4edb-41cf-08df2e142d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|56012099006|261009223027099003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 09KZf30gbqkCmC8rkUDyRBV3ILjdqF9kIYxd/ywwIBNhLmV2d0PYRIdIdnWt5Il7jtSRmZbhEmcVcjZsHfFwbzHk7F8EI780wGESesG6xgcKswDUMPCSVIoWkqXj8Dj+fqiDOuAo7aRiUXIAgw/yrMG686s2v4WS2ywGUatp3RfCyowoc1pJ/s/R4VcoLD8P9i+mBUjEiIBQFGdGAIs/y2T+klMMJPc+EegeLkkwPioG6uLIC+j7pqjtpGzkDffYlonGfHHtQdBiniHUw9GzURtxDAyfBKXFHkI7QZ7vU8uo+eaJ5eFHmw1B1LNM3ZNkO9Wp0QB1IHYsR3oGiNwUxfsmxZe5n9gyRXHs5ZJ8qKM6XMmv2QSXZQdWVnnyS8+1VDlt+ABoYu96NliL3HjtTGRkSBU5ybtDyQRT/ZO4ZDiImTb4Zux+VJwpUHoZim/LwB3GWdHjWy0EFC0gEX4X/R5QsoyBQ7ObzzM4nIpaFshKDhUSkL+uVeGg47swy+Hi6pBRgikJigdQBWKMLKzS4NaxShTxBqktTVuQzijVRj7IQvp1U2V+YL4Zn6k5k2mdE7MhFQqFEyNEYyu/TMvQ+Jxd23sYupJVouVlK6po+9DuPCEPDSkKLVrlgMDN+ExasL5WJSAQXAn8Dn7C4gEAJpRSib0YcAUTB9sRdK6YoYqwdqoIcjMYvG73F/0MSI12Mo7PK7JDQUmsExbRawXbYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(56012099006)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YqL0Sqtd/KJkjRWZc16N+Hts63vTtnhnirnwHUal8q9ChEwer+MX5N+CxnBSwsaWj4p3W2iZn4WbqX05uQ2fyYlTfa43H20Fc0sBxmglfqAtNEUMA2pjobagT7niQEJHv8Zw7wgL80SUfFLNo8RVPxsBGTp7XJ3+YdhKJcS7Wl7DM1ADbqKN5srXp36rsYqrmZDY7692BeLXvncc12tw9/KJ5Iey647vdaIK1pHayJdWX4/f+HKpO+adJZ3bD8vnqjsMyVroSXx97zRlXfj45Gv4+jrF8wE3illQI7oNuUbiGNEm1S6RVzh7udH5cx3r+UTiiCdHV6SZHrwWAB5G7qL76/IzzpgQ2kXvUtG02xu0CGqjOPE208IzyKH1mPYSVhn5sTsyRSzXhxA/JPVOY9mokD+18AkzlDFaOUWs5aqqkw14GMXGUUuss5owZ5xe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:07:09.9799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd2f502-90f1-4edb-41cf-08df2e142d11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No need to read the register state from the hardware, just
program the settings explicitly.  This could also cause
problems when gfx is powered off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 62d432b23cbc6..2c61ab015982f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -867,6 +867,7 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 {
 	struct v12_sdma_mqd *m = mqd;
 	uint64_t wb_gpu_addr;
+	u32 tmp;
 
 	m->sdmax_rlcx_rb_cntl =
 		order_base_2(prop->queue_size / 4) << SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
@@ -885,8 +886,9 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, 0,
-							regSDMA0_QUEUE0_IB_CNTL));
+	tmp = REG_SET_FIELD(0, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	tmp = REG_SET_FIELD(tmp, SDMA0_QUEUE0_IB_CNTL, SWITCH_INSIDE_IB, 1);
+	m->sdmax_rlcx_ib_cntl = tmp;
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.56.0

