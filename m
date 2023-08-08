Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F51C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 19:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC5C10E0D1;
	Tue,  8 Aug 2023 19:32:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB2510E0D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 19:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wgw7iYwSibmcZ/dlClp4mzybgnzU41DQhGYA/NHGzlIVBtnL3PwjSfgJq6gwmpdxp/rraMVuzA5OkPhivnuBVa6PoIaJ/x+dYF5CQKddo3mS8+DrIEjixTxQV6xw2Wrhj0MTWtoW3flzGeGztpgAHHOaS9NvdNcMX6WXmPkg0cXtLqFRK82lAneIXBZNNE7c83ObUsjG8M+mUd8QuRtH+pOSHogYH0ZlwBj3vdNJDD7Q0Vjl6bEkc08fouLkvZBJBOW3qtPtnVpdNKO8q+nistR6gVEwXRJMnzts+odv4K7CJ0P/NeM7CicSGPhc1X63dLw7MgIE+ji9222L93w6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWBUiORxYChJdrk5tjgEesN3HOO0We0Vvzy7gYN2QS0=;
 b=Ft75uLlZgSOHwi3rzZZbuI+IXRPZ7+c51Q30aYF0HAAx8g23Nx2W1vtTuLMY8FEbKG6wRbSRzkkO11wYAYKJ4B3uSWsuH26mfKv8DKgd+AHaN+iFkJ47zZF3WAEfaT9AimXVdMnEkMJw6wZWxs/2jtqI1aYNJjXHfJTQLQgn5vWZIH/v8sykqOgKmxRP7oqas/R5UbkxSGUxl29RXQ6Kiq7gTAc9nFdMMjixiQzMkZL6+m05tv/aLIsYT7XdhHRw7x0mVStE39DcLpWIUtMhMYP12v3lfuwMK6lGiwIy8Y01AEl658l5ZGrgtFpwzk17ePNL4WWn95fCXUHH4pXawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWBUiORxYChJdrk5tjgEesN3HOO0We0Vvzy7gYN2QS0=;
 b=fD6bkcK2TMzXvAHblDlgwgv2WJmn8K/5D5nmSe/OoQYo1Gd9orzbETnp2jnNVuHo82gog6+IXkFg0GDQTCl+GntEaYYq4Qrv4e/iuCg6qx2Znk9+bzxi/Af2yuKOKniCHQh+wJ/jaxXj/LJTIuBsJ6G/DhwdwUQgSRQjbdHPABQ=
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 19:32:09 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::7) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 19:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 19:32:08 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 14:32:07 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add xcc instance parameter to
 *REG32_SOC15_IP_NO_KIQ
Date: Tue, 8 Aug 2023 15:31:47 -0400
Message-ID: <20230808193149.34505-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 279f9ca7-de15-48ee-5693-08db984627ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrjlzqEb15/CT3I0DOzHKtKjNN0nT+IEhr1cwauYaCpl5mtRbjWI0Yn0d61pLr8M3UPOUKamOcoUc3dtcYaNaEeJ3MnniliK03CxyH3SSAscSSXj7WTGIuu1nwz1Z0nBHEbqiTav7NTG2H2UNO0/rwCNNdcdemttl41NNY1MvZAl4MaZArESmO0X6DXU0gGlyymTyh6YSs5YQSJvlSWpIiotNSWq/dpf0Ku1JFhRY19Dnfy75gOtnX7MxQsz2IkIIWu9fj5xvWR5U1ePDN1HgoCoES7oHyl5S50LuGKnknwISshviro7xcUk7/LOeip8yH8RB897jfU0U8JbyZsNxRp0JdYlC5Q277krAkMEAyv73Bn+9sBrjlr8THlNyzt8x86ApLd7QPbcT216x6cULraOHqHna9CA6eFWwhAZ2RS0BTLZ8QLlnZJnLGPUtS+kz+G4uCF9gywQjBw42pDWYkwvrFZWhQRkrMR0UxotX9B+rkcPsBD/xx1dnN6KnTA8crQTLMnzNNF+VKOktL9QDkDNMc/5XBht37jOrBWZeNahv2i0QMLdUnmJ0BAFieWPkE5x9NeJ3v6dd8A/tFxnhx+6GBsaSH9DgDhmE/a9KuaMvn5ot60AXDBVO/r5tcKKoTm/G5bKdWOndSvxqSV3H0T0HbKBJRA5pHTCfszA6qbOeVxDe4PnH8aV4jcVT5fWJfGihyuZZOuHxvVHS6XniU6/YN6+Fy2XIEr7zRJUKEtDrjjnzkEP2BCAmeLCxYgA2opiPVYZHUM+0PKLVvOptw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(82310400008)(186006)(1800799003)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(426003)(36860700001)(47076005)(2616005)(40460700003)(40480700001)(2906002)(54906003)(6916009)(4326008)(316002)(8936002)(5660300002)(8676002)(336012)(70206006)(16526019)(70586007)(478600001)(82740400003)(81166007)(7696005)(6666004)(356005)(41300700001)(86362001)(1076003)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 19:32:08.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279f9ca7-de15-48ee-5693-08db984627ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
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
Cc: victor.skvortsov@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WREG32/RREG32_SOC15_IP_NO_KIQ call is using XCC0's RLCG interface
when programming other XCCs.

Add inst parameter to them.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 880460cd3239..11bad5475b31 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -870,9 +870,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, vmhub - AMDGPU_MMHUB0(0));
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, vmhub);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -884,9 +884,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	do {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, vmhub - AMDGPU_MMHUB0(0));
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, vmhub);
 
 		/*
 		 * Issue a dummy read to wait for the ACK register to
@@ -900,9 +900,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		for (j = 0; j < adev->usec_timeout; j++) {
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_ack + hub->eng_distance * eng, vmhub - AMDGPU_MMHUB0(0));
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng, vmhub);
 			if (tmp & (1 << vmid))
 				break;
 			udelay(1);
@@ -919,9 +919,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0, vmhub - AMDGPU_MMHUB0(0));
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0, vmhub);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index b99244a53d6d..148eb2603b9a 100644
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

