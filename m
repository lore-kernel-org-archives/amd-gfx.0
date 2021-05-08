Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88510C433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B6261006
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B6261006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840976E1F1;
	Sat,  8 May 2021 11:51:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762826E1F1
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbc1MqERkt4QpMNJfa+HBgsFCt3GaJ0mWWpF9PESKkKyuyWk0tCa87E8l9HWqqm05oMgS9xzD6rX/DmhlF3Pp/eVi3QoFdB7D5zTveLW8JG9q/9hC7pYRiLKPvTl9DbdezSyG1lcxP+pkH1o/gm5YGvQo1G061HosyXBeB+CRikJ/M8JjxXLBsldhFBgz0cmExmcQvFKYJFBQD0tiuP6xxrEorBChGEkd9CApft7vM5L8zAGFqybRQUw9rY4Qq30yIhFUvIzxCyhjol2eIhuqYaRSFHcu4hxqdciVf/Wf+xF4QXLbi+/HMVBtJrTANAfb24R8wPHdyE0ZIg6nC8pIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3mlv8iFPRQMzk8MsXUIFZnXAXEzdQ/fc6Wq13JvMhk=;
 b=KuoiAEEXY07oE5lZruegW1wBZB3Rb3+OjImcu4SDMwsdFZhrCh3NVuygITZRxPFAyJ4RMSVNKOe96aULjiqQbEhcRA1IvqIDovGxpA1dmcI7X/OaBpZLAYcR+TscbZkMN7RtPF+gwwiBWNb7qyN9dwLJSms3f4F1qzXJYy12zyS9hlM1h0g/RnrUD7+PWV26c4AqK7rIqa4yjL7f62DxY/9UyXwSMH3/rpk4OiALtCp1J7TzN8I+jOGyWOWi1voOxet0XfZy52lK2zB80yd7cCI7aC3nYppu8+M/Pa95yU+4kvfxoX7zELwirKjVH4pHsJ8up0PCR8Ead8Wdh7OFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3mlv8iFPRQMzk8MsXUIFZnXAXEzdQ/fc6Wq13JvMhk=;
 b=BGiO43TqTTGpuytzF63Y0F72brQZzT7gKAlv23+Gow5pa+oODPkv3NrOEdB4d5HVImrNlC7eyTu36T4Bs7HPgnX8vePGhaUcRkkug3hl4zZuqg50hMYBD5gJXaapg2KDRmNwptGnBFpRUB6bhJYPrIWo/d70lp4u+uj9WpCpbzo=
Received: from BN8PR15CA0005.namprd15.prod.outlook.com (2603:10b6:408:c0::18)
 by DM5PR12MB1324.namprd12.prod.outlook.com (2603:10b6:3:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 11:51:55 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::50) by BN8PR15CA0005.outlook.office365.com
 (2603:10b6:408:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Sat, 8 May 2021 11:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:51:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:51:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:51:54 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:51:53 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 02/13] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file gfx_v10*
Date: Sat, 8 May 2021 19:51:34 +0800
Message-ID: <20210508115145.758-2-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c2a745e-a102-479a-ab11-08d91217ad80
X-MS-TrafficTypeDiagnostic: DM5PR12MB1324:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1324DDA705ED29D9C2ECA623F8569@DM5PR12MB1324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpQFpS/Oq1qx7u90pNwwoVppke1tmh174xm479Br2vAon2IE4SFZGYDjcT8+MVQl/mKovt3vHX5uvVF1CilTY/ac5YK9J2uEzHQqr3xqvEuBrOU/pMYkm99NO1sEiLJomibYQ3cb1VWPswLrQLVSgHiG5V1sc86AtXQC712aEIpwIoeJK9CnJvyPjIIzTseVxjxeW6JeXGvOxiulbS9UjD2HfdJvAY+3y3iugMH9kPsbIY8deYsj3rpWgr40bZerYALHfAmNqd+PU/CsXPvVZmYxEVG3VvP3ThPZf/5gt/+POrNO0LCNT5prA46qnh8b+bVqY4XqdPLvq7s4Aq0CPsQunsCHHhVXMUpZwDYSWBWilT6XdxSENXWLR80ZiJGlhLd8vEdBTfu1UzRDyotEJmw3dNN37J+88qo/e1yf6uweLVVkGrj+r0Soy4X7E1Dl7vIHljsmuNyGlxmVi/WTOFNBPhLhgan1RbCIdAQCtmftWcpkLWnErXMvWvRPlqFd0Um2B1Nowf95ik5XVzgPqJg5hx7UMRPCGuQLDdB+R15XqU5jIGaRPjbXxCOTOS39z9Cede+SOQGAlKgu5EWZuihy/K5UkBSOQSNLTKhFbDJNqdm8h2IsEfYgC+C8+IUT1yk58SjF99HuToCeI2Ln2rPiVFvXbFOckV5NkzmfWP6ZmuQZQqWC4fuyyd10es59
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(376002)(136003)(346002)(46966006)(36840700001)(426003)(8676002)(336012)(8936002)(316002)(26005)(186003)(6916009)(6666004)(83380400001)(356005)(36860700001)(36756003)(2906002)(82740400003)(47076005)(70586007)(70206006)(4326008)(1076003)(2616005)(86362001)(81166007)(478600001)(82310400003)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:51:55.3644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2a745e-a102-479a-ab11-08d91217ad80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6603cc3466b8..1bab22272e97 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5178,10 +5178,10 @@ static void gfx_v10_0_rlc_enable_srm(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	/* enable Save Restore Machine */
-	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL));
+	tmp = RREG32_SOC15(GC, 0, mmRLC_SRM_CNTL);
 	tmp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
 	tmp |= RLC_SRM_CNTL__SRM_ENABLE_MASK;
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL), tmp);
+	WREG32_SOC15(GC, 0, mmRLC_SRM_CNTL, tmp);
 }
 
 static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
@@ -7873,12 +7873,12 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 reg, data;
-
+	/* not for *_SOC15 */
 	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
-		data = RREG32(reg);
+		data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
@@ -8618,16 +8618,16 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		cp_int_cntl = RREG32(cp_int_cntl_reg);
+		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 0);
-		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		cp_int_cntl = RREG32(cp_int_cntl_reg);
+		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
 		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
 					    TIME_STAMP_INT_ENABLE, 1);
-		WREG32(cp_int_cntl_reg, cp_int_cntl);
+		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
 		break;
 	default:
 		break;
@@ -8671,16 +8671,16 @@ static void gfx_v10_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
 		break;
 	default:
 		break;
@@ -8876,20 +8876,20 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 					    GENERIC2_INT_ENABLE, 0);
 			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
 
-			tmp = RREG32(target);
+			tmp = RREG32_SOC15_IP(GC, target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 0);
-			WREG32(target, tmp);
+			WREG32_SOC15_IP(GC, target, tmp);
 		} else {
 			tmp = RREG32_SOC15(GC, 0, mmCPC_INT_CNTL);
 			tmp = REG_SET_FIELD(tmp, CPC_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
 			WREG32_SOC15(GC, 0, mmCPC_INT_CNTL, tmp);
 
-			tmp = RREG32(target);
+			tmp = RREG32_SOC15_IP(GC, target);
 			tmp = REG_SET_FIELD(tmp, CP_ME2_PIPE0_INT_CNTL,
 					    GENERIC2_INT_ENABLE, 1);
-			WREG32(target, tmp);
+			WREG32_SOC15_IP(GC, target, tmp);
 		}
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
