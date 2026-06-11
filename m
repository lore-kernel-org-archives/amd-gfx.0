Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE74CD98CE
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 05:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A19710ECC3;
	Thu, 11 Jun 2026 05:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eCmWQxyu";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9FE10E230
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 05:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoSj7wQCETAFD1kkLSIqZYTiJ8fqBEZeaYhCTzAiSoyPCZwEa7dZhodnwEW7h/j9JY7MJ7GMiTjDYi3ACHkAJ6kh0QgmenTWHw2ahG8TKObS1DnZkX7Y6slA7DF1apz8/9u+igG3kmNqxG8N/6tTjlUOuxX8JvwkRUmikKZvfb4gzEE9qoRzxSrasFH6nC/4vxkdz04K2qEOaYLSe95ckwygu7IuXULoFVw8yr9mtl1srUIyG5WZXjgt8AmUE6fo3tt0w5HKE+NGngCHDoGKWldiPxcRWN9rFnkxUFO0uYOE+GbrmeBgpGYBGAuNv4kz27llyiW+6xSw7WIK1Pyaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZAxnH9VVpACzlToDRv0wzOY+v9tXodGH4n1VqYPVHc=;
 b=yu8WfyYwySrmWPLftk0eDkmKYeE7qk2zZwxsM8axlpk21oCE9CFkKJxxlR7sHdVBCulPzZO/NByoJSC2ksavgjHsXh7pPRlURClI9I3xgE5iqZymYkbUDc9e/rkMUwb7pa/ExRMRPcs3IWTHEoxTMu3PIITZPFun58o2SOySKirxIq+pc6IAgUsDiGiD5qE1MkPa33XPKHKEe1wWTiFoO5LJCYCLsY8okW2jBS8L+xKn5hQAlOdDkb9xPTGvRv85DJCd0yrS+lE9332gE/FpCWV0yTmzCaHjEsSRbrEpPKqYCwI1O+Zya+5ykj/18ELsFBzxbF4dkP6n8lJCh1Dgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZAxnH9VVpACzlToDRv0wzOY+v9tXodGH4n1VqYPVHc=;
 b=eCmWQxyuvg+b31EcMNEstAOl3wuwiqDgsJNS/kWRLwCCI+/nGoeo0gHwCggTeJCw8AHzM6535LvWBgiHTCKdYbh3cRTvKg7H/daorURle8zgYpjTWq+33EPle4WkE2Piklfy3t1KvXXTotbppbPXxk28DVRRJc3wS9DRG33dKbQ=
Received: from MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 05:57:36 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::6a) by MN2PR11CA0030.outlook.office365.com
 (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 05:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 05:57:35 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 00:57:33 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Huang Rui <ray.huang@amd.com>,
 Huang Trigger <Trigger.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PATCH v2 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
Date: Thu, 11 Jun 2026 13:57:15 +0800
Message-ID: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dd9127-1e56-48d1-540b-08dec77e563a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: h41A6cth/sNs9vOWoAalN8++dYkFDJmzV2sldkqlQZKF8gPH34miFn8mbcg0hb/Sz9KWlQlcOCRYqgdvWcZPGLlc3QppqQQsKtfeqjDAOJiPMGImPR8nwLIixx8TZHmdTFgE9623J2Mwk0pxdxTpuB1wuU1X1l9t5R+hJsslXSjNxrAlhCpJGAJAwnu7gtiyldm1t5ZAhe4I/QoZHpnVV5eCMQfN/lN/8Jg+3+8fG1czcWvX3KwJn4qVi3o2JeES8Jmk6CBfd7nKB1OWCEG9AzGjDoV2oICo7c3J8EYSGHOdIWQ/APHrxq84yFhGXL7ebPMRby9j2kL20MI1fM7a1PCbOyGX0MFz0rHWfhoSbfATQIsasdfFlDvE4b2WKXib3aYRDleU0LPSJpo3CiT39ZW+yLOBrX9jdTCt2Kf7avE1i+S/QX1GVmpQh7eGsLbtcPUyRn/lUiBBkDT7URcWHLYhAk58jVp751MHujLveMQRZq3h9/+n9vNnk29HXCBDvgno5U33NhSVbiaPxNAOY+n1N3YvwMqZS7FGyFyQkxVS6n4HMFUzfj2ZtKq4rXZHYfGbxr3v+VkS3FNLENI30mciwPmCQl8sAtKU7TGvjc5Oi1ViOUKP6zU2OkYVhb1J8vSNxTziWxQMYyf/ITH+3aN+J39nqyfCBRPWobRFk86msRY5DKWvcR2V/cyN6wt2eD4nb86nZjg8Lj42UvVnIb8MoUjw7oVwVJ+U99kljeA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2XZA9i8V1Oe7Q8oFk1rKILklVSQ7FghBKHGWSLaK6s0FZ/C8i1fCEcCSw6Glqabdx786ykg/vAESULuC75RctHe1oBgpufKLSVkvS8S4bx0iE3tL1YjjOrq7O/bC/CgYPLzm3kzAR6YFuMCpqLR2j9AXn/ozPsqTTrIu0pXJUYmRCaLpIiPKh8JasvzBkreB5WsSDRs9Hi06dPo62qp2M048kya0x5Su8JoTeLx1TBvyJLtNFls6diELbsDqhRw8WU2o19dlTRXQvHaRi5XxHxO/DenGPRspMNWmDvrM4WBliD6VNW6ne7ufyT8jfBmZGH6/0G3dJ3ud/9bAYy04rdNh9Nj0PiCvAF5VtfFvUnm2yLKMzz8H7TR1ZvvG6jY1C0udS6GxgtEFKG5jZ2Fe/qfH7DP47MJSXs27qsLS5lwFd8hi9zIg8h8AEDfyeKk/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 05:57:35.9217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dd9127-1e56-48d1-540b-08dec77e563a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Renior APU with gfx9, in some test scenarios with disabling
ring_reset, like accessing an unmapped invalid address, it can
trigger a gpu job timeout event, then driver uses Mode2 reset
to reset GPU, but after Mode2 compute Ring test and IB test fail
randomly. It because the CPC and CPF are still stuck after Mode2,
that causes compute Ring test fail. What's more, the HQDs of
MECs are still active, that causes MECs use stale HQDs when MECs
are unhalted before driver restore MQDs, then causes compute IB
tests fail.

So, add sequences to reset CPC and CPF after Mode2, and de-active
HQDs of MECs before unhalting MECs.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
v1->v2 changes:
* Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
* Add reset Mode2 method check to the if condition that call my sequences

v1:
Hi all,

My board is Renior APU with gfx9, smu12. I run a testcase that
accesses an invalid address to trigger a amdgpu_job_timedout()
with disabling ring_reset, so that driver will call mode2 reset
directly. After mode2 reset I found compute Ring tests and compute
IB tests fail randomly on random compute ring.

We checked the scan dump of GPU, we can see the CPC and CPF are
still stuck, that caused Compute Ring tests fail.

I added printings in driver codes (gfx_v9_0_cp_resume), and found
the HQDs of MECs are still active, that may cause MECs use stale
HQDs when MECs are unhalted before mapping compute queues (restoring
MQDs to HQDs).

So, I send this patch to fix above problems.
There are two main changes of my patch:
One is to reset CPC and CPF before resuming KCQ.
Another is to disable HQDs beofre unhalting MECs.
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 47721d0c3781..d3ef45aa299a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3942,6 +3942,46 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
 	return amdgpu_gfx_enable_kcq(adev, 0);
 }
 
+static void gfx_v9_0_cp_mode2_clear_state(struct amdgpu_device *adev)
+{
+	u32 tmp;
+	int i, j, k;
+
+	/*
+	 * CPC and CPF are still stuck after Mode2 reset, that causes later
+	 * compute ring test fail and then loop Mode2 reset infinitely
+	 */
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	udelay(50);
+
+	tmp &= ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
+			GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	udelay(50);
+
+	/*
+	 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
+	 * prevent MEC use stale HQD when MEC unhalted before restoring MQD.
+	 * Otherwise, later compute IB test may fail
+	 */
+	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+				mutex_lock(&adev->srbm_mutex);
+				soc15_grbm_select(adev, i + 1, j, k, 0, 0);
+				WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
+				soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+				mutex_unlock(&adev->srbm_mutex);
+			}
+		}
+	}
+}
+
 static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -3967,6 +4007,10 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 		gfx_v9_0_cp_gfx_enable(adev, false);
 	gfx_v9_0_cp_compute_enable(adev, false);
 
+	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
+		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
+		gfx_v9_0_cp_mode2_clear_state(adev);
+
 	r = gfx_v9_0_kiq_resume(adev);
 	if (r)
 		return r;
-- 
2.39.5

