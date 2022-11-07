Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F05C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 03:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8D210E07C;
	Mon,  7 Nov 2022 03:50:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542E710E07C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 03:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI0JRjNyH/8S177rkWnWyPM1vriJR64feeSFyzLcjZCH17AWPoXa64oHKZP7F6CrK5lV+nWurKvDs3XcWZwJtqrBWG0AT67uuyEuRZrfARGBU787SmoUaDVXO951i0UDptxd7HxIWW0/HMw244Tlk4GAsmilfs/3qpMAbTXGIdxlU5QQEdLZoonp9vf31lCDCSOQ4W0pcf6ubS+zdp+TwKznMLsARN0aXHuZcpovKM8NYS3Sf0EdlBNWHd0xNJ4FT1XdfrnPDcOBbNXLUuHWG+K+DN17JDEkSi07UzExOMhcADXJRdMHGA0LX/w49AHALzrJdgxf3WwULom8yMIE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7YFLE6ADt1/ccCm0v0QwW4CTnlkKXpuOHXpki54LuA=;
 b=IMotio99junROmANlAvB12TuBlRO9GVzkZWXnF5TKo0UlxN/yObOV5MYO9doDc9ngeXqK5kl1F6RBNZq0Hn99CcmFEklaPTK/NImMQu3Fo1BH1VnYUXPqJYl67FW5QFDwuNsJAr2VjiKlyItE8Pm68AqkOmSh76HJXsnPLSzRbeRAbp7s0sqlZNwCRuuPlVLd3fG45020YDD+XjW5Ea55sb+nysnPZCrL9HvyGLWbX36NQ3BzSn6F/9if+9Jf+VyuilFP7T6n4dtpO1Sr9OXzsBFI0uGMblx2UwrjPtQw+aUsrLPwJw/nJUP81ZS1xa7ab0lQe4mo901icx+G3q3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7YFLE6ADt1/ccCm0v0QwW4CTnlkKXpuOHXpki54LuA=;
 b=YXM/Cdwlv9ybtDRIvzKMCxi5HEi3vF+26LVoRBIAae8Iup+lYFMnmodX2ErmI+J9SX6Ut14WJJ2mc5aZd5ltAa0ZD+2jkZzumhZ6+b3fTNtnLoSOfd/fqPgMoJ4TUdG9937IsRi9kXnbhILoqOX9joVQGBaz+SGyV7oiat511no=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Mon, 7 Nov 2022 03:50:39 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::79) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 03:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 03:50:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 6 Nov
 2022 21:50:38 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Sun, 6 Nov 2022 21:50:37 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/amdgpu: Enable gfx pipe1 and fix related issues
Date: Mon, 7 Nov 2022 11:50:35 +0800
Message-ID: <20221107035035.308256-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|DM4PR12MB5230:EE_
X-MS-Office365-Filtering-Correlation-Id: 482c47ef-a788-447d-6eb7-08dac0733c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUdWJveXZespOpUE94E8EJDHKWCnZrIgtQm6yD576prCZEvRF/SIW0gLmirQwyLSPo0g7gPOEaF+LXXzLoNA/hROm0yxT5j/zBFRLlkO2LIdFtdB7Vp9Y7CRWmSwPZg5O1zbHuZRXoGunD9cEBGUj+FgdEVTkmsQeGwQ7UrJl6fFjt+IOnVVgKwaaab1hg48c5qUqwzGMEdjTxnlwMV3ZgPMoP9Ncd0JRMF5DEx+VIJPtuvrngAw8FYXOLQff0+s/hwFdWhHUOdNdPR3pLLd0oEkiydYslIy6sK6auCrjq7q6pX49EByCFJ3vgaB48Cbu8Lq1H+OWkL01gYw9YinDcPfRfnb6nsBEp3ro1Sjk+MkPnwvzke2Jb4IsWCEFcIIQ2nS4nJFsl4OOfp15BeHi8nXbo+3AVW3e0+7kVT3i+a5A2c2H/oMrGgIYi7TTFDllPz1LBB+RW2oRfK0h7jHVAd20ntKFyBisVGQdA0K+c2lk15/+ZAeQvrJGBgAHJHMg2Qnryvul9fbotXjUubo6CsLCCseSOvUjXduH7G2WFSm5il2I7V+QJ6RNk7mLL/v5wfi6kQ2GfGUsgJk/C3jYUqAc+MO/a4ajab9o1513huogzGm5YsVCxfPDBaZfZrUULeV2JxpxJkKwupnF+jSYPdSUA9QShmYXSROX/Xtm7Fum4KlOGGzKhIm2WozHa+Z349j74cX+5P+msb0r2pNcnW3QolQQz0XpgpKgahE4JDQjIrNA/9O7plUrEeCg1qNhYP8+SKaV5WlH7uPShzVWdlsJH2zy2F90cb9hKcxu0dFNIYha+FKBS1SLOPmoYHr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(36756003)(81166007)(6916009)(316002)(5660300002)(40480700001)(83380400001)(356005)(478600001)(4326008)(2906002)(41300700001)(8936002)(70206006)(70586007)(8676002)(2616005)(1076003)(186003)(47076005)(426003)(26005)(40460700003)(336012)(36860700001)(86362001)(82740400003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 03:50:39.2421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 482c47ef-a788-447d-6eb7-08dac0733c62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting from SIENNA CICHLID asic supports two gfx pipes, enabling
two graphics queues for performance concern.

v2: Don't change the entity number of AMDGPU_HW_IP_GFX

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 42 +++++++++++++-------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 49d34c7bbf20..bbf18060611e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4606,7 +4606,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -6008,6 +6008,24 @@ static int gfx_v10_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int gfx_v10_0_wait_for_idle(void *handle)
+{
+	unsigned i;
+	u32 tmp;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* read MC_STATUS */
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS) &
+			GRBM_STATUS__GUI_ACTIVE_MASK;
+
+		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
 static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
@@ -6069,7 +6087,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	amdgpu_ring_write(ring, 0x8000);
 
 	amdgpu_ring_commit(ring);
-
+	gfx_v10_0_wait_for_idle(adev);
 	/* submit cs packet to copy state 0 to next available state */
 	if (adev->gfx.num_gfx_rings > 1) {
 		/* maximum supported gfx ring is 2 */
@@ -7404,24 +7422,6 @@ static bool gfx_v10_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v10_0_wait_for_idle(void *handle)
-{
-	unsigned i;
-	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	for (i = 0; i < adev->usec_timeout; i++) {
-		/* read MC_STATUS */
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS) &
-			GRBM_STATUS__GUI_ACTIVE_MASK;
-
-		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
-}
-
 static int gfx_v10_0_soft_reset(void *handle)
 {
 	u32 grbm_soft_reset = 0;
@@ -8466,7 +8466,7 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 		}
 		reg_mem_engine = 0;
 	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
+		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
 		reg_mem_engine = 1; /* pfp */
 	}
 
-- 
2.36.1

