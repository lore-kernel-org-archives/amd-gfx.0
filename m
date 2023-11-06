Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B01BC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 04:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DD010E099;
	Mon,  6 Nov 2023 04:21:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8933010E099
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 04:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWoIWksNdul2BY89Oily0/zZG/2RHs28rOZwRB2BjjpbcfvweDlof7jOi+2krt/8svHrqr5lmcwH1EFu6WsOFHkjnIviG9IIXo1+LzTrRCSTy6p/0Gt34aV+mvCoy4IPchRL0It+Sy+RDmO7E6ulZtM8Pd/HOPY+yf6KRqyENSAcWhJCG1ZboaJQ6i6d5pnWRYS9957MJBaX/Xfw/+HCaIdVgeyXwWczXsUb2UtJPyF6HrSVA0FsiEnDi0DPMcKsx7LAASoBr0GM7Q4h2u+f/l4NdWbkUDCWZcLog3ne+vMO5VjsyO/S8Qv2HqlVPPh3W4454+opU9hT3VSLl2tdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ugOwLTeUkKnF6SPLc66iOdOLbfVr5QcedgQj8Rf1Hw=;
 b=Q4fLboJ2U7d2XrBS3ZAchgVTXRS3QZnsYWYW6SGf2hqB1i1vVciglUXsUFOo1XT/XUupZovvpOho84RM239lSIejfIhiZjL4U5vsO+Fwwfhw4siocBN4eT6SciuVDZBOTsTBeC3ZCD+Z7ngp8eVkoGTVJsw5ecI1Ax4bjdU3aF0i85tfX+AmnzOA82N+qrEuHilxrCvERfmAB56Xza0par/O9+88gV5UBfSHorlCDEFGJBLXpAKJ7PTaoqGPUItnrgdPV8pjlZE9aVsYWx56E2A/JXSKIRHY4ViyryRhnk33VPT6vEHQVIBTjmBQdeK/cfKGnB04ZqVpXzJJyyq2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ugOwLTeUkKnF6SPLc66iOdOLbfVr5QcedgQj8Rf1Hw=;
 b=xLJK/pwiVXddRI8H7MOCbGmRW/40h5nmCTnIk5FmWe7bIRPsw6R10hHmVobF3lC8vWa5SWk02RZlOIpLoC0K5es/uVgdAjAAef86paPJlXzmim360G+GKJY9EDcvMBRQ9Srrp1Ow1DKnuwBR0JifVVbS0w+9ICDUF5S6ShSI2cM=
Received: from CYXPR02CA0079.namprd02.prod.outlook.com (2603:10b6:930:ce::27)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 04:21:18 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::74) by CYXPR02CA0079.outlook.office365.com
 (2603:10b6:930:ce::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 04:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 04:21:17 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 5 Nov
 2023 22:21:15 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix sdma 4.4.2 doorbell rptr/wptr init
Date: Mon, 6 Nov 2023 09:50:54 +0530
Message-ID: <20231106042054.512499-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 211abc8d-ad93-462b-e059-08dbde7fd28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rp8190XraApWdPh0Eo4AGcEPlmpHeasKqWE/LEFhac31qtmq4CLDG2VybX2kufqjCqSyygJAsI1aka6LaW0aaegyTdE7mSeVOoc8GGjtJhi4o9QW1fDllJxBAPewYQQlqKmRbotayvILwbaYuXslR+ioEW8MU+jdYTpnzQqs4KV7UJsmUo0+1mxHY0RSQCvtU/CgfGNwSR+uSsgqspg59JVYZwSHof+fAqgVDKKgAxvtdZ0jGSxew3+QeFuNyXpaAbIxuReDRuQTZojVN8IZSTxF9GW0rXN/KLkzNOwzijTWJW6RHsE91kV+V4k7yLIpxLxNSxl6/w/p4fPhoBtqxGmaDRexaNu/7U3CzlbOlJhSTCBhhoAb9hmOI3VMfLOKlVnw/PcXg8AjFpc8X8ybV7s/F/Ob7GR14V4W2x/Hj01plqj/S0JCr+bzUhRFSR7yX1mx/p/DyMho/Ls9SEAffmjpAz8AjkvdZ9qiNagzMZVqCegr5SVDywKva/7k8V+oYe36aBvPHKN5edBxgMkGCSY0F8SByAkx4mM+9t2XDWYzD8TWoVRu+C0zZeLcVjSpl20BiAmjeTFe6RK2ULk4AV8nIBasVzkpIiDzxIuxuP4F2AxdezvioGTOfjMahGZfIYCUq4P+iCMNtmXZos98p8NV4lilzhoiiJB6lWUj0MWAapfSbHs+Yct28Jx1oxkuMrajCzksM4QhPGQfBn0ah3qe3Hhlq5fZKhuAS4fdG4huk8jgVmHPfLCiEw1VR2Wx3/0v+Yy8OmetkjAEITfIbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(8676002)(8936002)(4326008)(40480700001)(40460700003)(5660300002)(44832011)(41300700001)(7696005)(6666004)(316002)(6916009)(70206006)(70586007)(54906003)(82740400003)(36860700001)(83380400001)(86362001)(356005)(81166007)(47076005)(2906002)(16526019)(426003)(2616005)(478600001)(36756003)(1076003)(336012)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 04:21:17.6402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211abc8d-ad93-462b-e059-08dbde7fd28b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Doorbell rptr/wptr can be set through multiple ways including direct
register initialization. Disable doorbell during hw_fini once the ring
is disabled so that during next module reload direct initialization
takes effect. Also, move the direct initialization after minor update is
set to 1 since rptr/wptr are reinitialized back to 0 which could be
lower than the previous doorbell value (ex: cases like module reload).

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 25 ++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c46bc6aa4f48..bd65a62f8903 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -427,6 +427,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 				      uint32_t inst_mask)
 {
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
+	u32 doorbell_offset, doorbell;
 	u32 rb_cntl, ib_cntl;
 	int i, unset = 0;
 
@@ -444,6 +445,18 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 		ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
 		WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
+
+		if (sdma[i]->use_doorbell) {
+			doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
+			doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
+
+			doorbell = REG_SET_FIELD(doorbell, SDMA_GFX_DOORBELL, ENABLE, 0);
+			doorbell_offset = REG_SET_FIELD(doorbell_offset,
+					SDMA_GFX_DOORBELL_OFFSET,
+					OFFSET, 0);
+			WREG32_SDMA(i, regSDMA_GFX_DOORBELL, doorbell);
+			WREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET, doorbell_offset);
+		}
 	}
 }
 
@@ -631,12 +644,6 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 	rb_cntl = sdma_v4_4_2_rb_cntl(ring, rb_cntl);
 	WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl);
 
-	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
-
 	/* set the wb address whether it's enabled or not */
 	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_ADDR_HI,
 	       upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
@@ -654,6 +661,12 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
 
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
+	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
+	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
+	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
+
 	doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
 	doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
 
-- 
2.25.1

