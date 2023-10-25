Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204C9C07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 20:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF61510E71A;
	Wed, 25 Oct 2023 20:53:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C660910E71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 20:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6D8jC8bJspx2Cjdqn9rZjKlLTlvfYia8uItQCpph97akkSn1skR6vHHiPqV9Ud2Hx/nwDgF7JsrbpvLDPdLhLEWj60VTUnaXCZKRhHdAA6//7phr87w5fbLzyc8Z+hlp1n+CXMddHcpTY9rS6Yu+KPFDDrC/YUTfc08jT+KOcg1pkt9HzVVwn/iiAT1/v7Vhx0U3ZY78hbJTXXkVohT493bV0AcPhzpugJZM9uzzzsi3n2mcvlRYnlc/xXjxrycl3MyAsenCe0R8tEKnL7DLTDP4CMVexP3ckzz5CRDskK+0y5GrpAahBmuJZxmeBcGZU0azFsHXbbkgXZF028t6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yo9pj6nOkUIzJgv9MULtr7y5fhhHTPBEY3Ng5iXpVq0=;
 b=Vzqvo111ZN2U/pV+tA6NbrIynY4DVRvJ1euvgCTRPRD20DE357/nMpNYQYmISQtiG8mpbHu272rc7riOEfcOhdj6AGQcCTlE3gELCD31GIUiGWMYeGhr5/TH9ESbEUbgvnxwmPNHX6ZfTYALZkfAJHoTjXoKnlXHlN2Zzuu33Y36eBAzqHjGQDDBnM4zj0aQGO0Rt+QJV73la/Dy0N4hEfEj28NHfPEQcZpainLOgP4dJ1VJ6FzWbwzvDsPzN9tn+fa0ccDhVei1XY9AUd9iqN0SAr18BizWEP0Ahj8KglBUarQHoL4Qh+T9NpbVJx0iPPN1Hpvy11mq6FdJqZlPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo9pj6nOkUIzJgv9MULtr7y5fhhHTPBEY3Ng5iXpVq0=;
 b=vrFvkOFahsFOFZg+U9J4SwQtXmF6a7nzlN0u1Ei+YwsTVCumtK9R4Q6nMItQglyF8vDtCkjWE+a2r1m4cPnjXSkKGnNSsp0po26S+VYY2FO3YeHtOOxNTcEvFIoJ/eE/xgq+U/N+2gWe8aAcksxv0ea9Ws82bLxl0QUweEw2cSc=
Received: from DM6PR10CA0002.namprd10.prod.outlook.com (2603:10b6:5:60::15) by
 SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 20:53:24 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::8e) by DM6PR10CA0002.outlook.office365.com
 (2603:10b6:5:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 20:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 20:53:24 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 15:53:23 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Add xcc instance parameter to
 *REG32_SOC15_IP_NO_KIQ (v2)
Date: Wed, 25 Oct 2023 16:52:39 -0400
Message-ID: <20231025205242.40490-2-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025205242.40490-1-victorchengchi.lu@amd.com>
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
 <20231025205242.40490-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 48728a11-2eda-4ffa-9a77-08dbd59c6e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Gh1BKrYDzD5sT89jDy9mdjbd8gOiDmC6x2BgRyORvtcNNe6jWJHUQyjlVcCSxQeuHHCJ+dUx0Mxrc4W5gAslqmKmZSe5DP+sRjQw5T+DXhP2Hf/F3IiryTvw/wW07ymhARxIZXk6LiDLyDVCRP4gdpwp3d4yaD6qQRnhhD8yoXw5PetfSqmkL+Zl/VW9Z83VtUCPWs8qGTOZMEJzKtWb63CyQ/WThF5xUSqqOjhDhwcEmCt7LkVDb1RO5Fgpu9yZHXeet1sj5gMhLrMqqzfk0qHg2j6f6L/j9xkGoTaoNQg6jl5ui5Bru7Uw1Re+LkAoCAek+PO4/4QzVd2PDc6cDMeoRWwf3MPV6HVCG5krPWH7apC8z0Rrnz/C9jWSi9k/G0u48pq/yDcHPPe5IgV7HCHj/lqUL8R5VzU6/K2JCXWuEz9v3h9cFENlKWeBZVcq5g1p6VZNC8Ps4sFDuICYsd4sdeZxoBF4lfCf+wmuv7zMW7OiRe7rtdENplA2CrlP9ok+RNfrrAbn0SdMmBOnVq6qTBaa92SYUaBNV253hSlgsEWwoyMyrSQNuRE8ZpV/QdK6bRhJMkz10uiNfinvkC5m9Gx1jJSb9hYPNFo5FnGqfWgP9RXrcQD8ZfAxqm7+wPAJBdPygSb1V0sNO4QbOKw/g/N529TG+AV7AQ11Ywp5VZP7qszitfxpNOsUNF5QsrNl4i6S9ahdDaToxlkbpWS4l+1pTtTsg8xv4NIja51tpebjg9VJJ+rnXqi2olKt1U72tG6da6OsSOfWPIbhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(1076003)(2616005)(82740400003)(40480700001)(70586007)(70206006)(81166007)(356005)(336012)(426003)(54906003)(16526019)(316002)(26005)(40460700003)(478600001)(7696005)(6666004)(6916009)(41300700001)(47076005)(36860700001)(86362001)(2906002)(5660300002)(36756003)(4326008)(83380400001)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:53:24.5256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48728a11-2eda-4ffa-9a77-08dbd59c6e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WREG32/RREG32_SOC15_IP_NO_KIQ call is using XCC0's RLCG interface
when programming other XCCs.

Add xcc instance parameter to them.

v2: rebase

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fee3141bb607..b7b1b04b66cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -856,9 +856,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, vmhub - AMDGPU_MMHUB(0));
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, vmhub);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -869,9 +869,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
-		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, vmhub - AMDGPU_MMHUB(0));
 	else
-		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to
@@ -884,9 +884,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	for (j = 0; j < adev->usec_timeout; j++) {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, vmhub - AMDGPU_MMHUB(0));
 		else
-			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, vmhub);
 		if (tmp & (1 << vmid))
 			break;
 		udelay(1);
@@ -899,9 +899,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, vmhub - AMDGPU_MMHUB(0));
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
+			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, vmhub);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index da683afa0222..c75e9cd5c98b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -69,7 +69,7 @@
 
 #define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP, 0)
 
-#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg, inst) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
@@ -86,8 +86,8 @@
 #define WREG32_SOC15_IP(ip, reg, value) \
 	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP, 0)
 
-#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
-	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
+#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value, inst) \
+	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
 
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
-- 
2.34.1

