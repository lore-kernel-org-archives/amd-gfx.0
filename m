Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCD7C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F74810E1C0;
	Mon, 21 Sep 2026 07:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMGvCLkX";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842EE10E1C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHEnJ0Cg6d/DdM91SU2ToyX04SBoO+j4cCR+RAhi3EMMASjdlIGac9Rn6PNDC+NUN/4fdLAAG2Z8l0QDrbCDzfzf0Z+kxI7cB36RzLIpGCqJ/KUPumOFyKW1Nq/kBHERBl6P/UmWd5wLBZrt2hzwC91CGOhrccrIFUvQpBfo87G7c8YumkY1vGLqx9VYsx78PMNGFH1UHYUeA0ZdB3sS0i6P8gIyk6TDnthp7px7LwnRMU5vkW72bnS5Z3h4pUGlnCZYq11f+bKPgpPD+sioNIt8Q1sYODwTs8AV9e/TQZbsdN+pcvyJ+8sSqHWGfFHLcHJlJcXyG5x0V7UIla5WkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ksxx1tFY1wD+U3mzvPc7swdDrakgXFP9/IFksIM1XVw=;
 b=VUND50h4V4SatmMYrtMe+9L53JqMwvYn0XR6C+h9XLmVCYefCy3KmH5/IQrsbAhx7jUOjgaxxxbQngZ352wva+IonbBo0zaBaEwbKbnFQVqqX8Zc+gqlOy70nxZs3+iZShlULCbWjPm9BBiXGesQZrQ0qsqQIbk78Kk3TOBfQiA5oJR9z+lH9uhSPjL+Vl0JFU26Jp9Je71nMP62U9SeEZmBbs+c9WIS+3ZIxCx5zbV2Ylah9D5/52C3nbHAnAJWU/wB9ffdBKME/3NfU7ir0po+CoaWJCxVjVZNhOy71CPhs9/VpTg5/eb6kmP44jttvX7xybAuwNlTbDsZWHKx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ksxx1tFY1wD+U3mzvPc7swdDrakgXFP9/IFksIM1XVw=;
 b=KMGvCLkXbupaAiUcfSd5RiXu4ewD4L/sV3gLd82h/QHfxdT36xm0FMyIV1erxPXHFlwcmBMSouQ0SZClddExJMPpNPvZnKg2iOdDFq/BP0IQ5li+dIFs6Ivhb/9UdqePEUR2i22/q8hsJ7IkWIdNfD+oGSz1gScrxaTI49+glhQ=
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:33 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::3d) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:31 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 02/21] drm/amdgpu/gfx12: implement detect_hung_queue
Date: Mon, 21 Sep 2026 15:51:09 +0800
Message-ID: <20260921075326.2409021-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 355bc08a-64f8-4443-436e-08df17b56ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HL5SHj5eXGejPydXhKmUYK+n5e2OsmYqWvCqi2MKIHXpLsqEY9+QzJtCqTzffSPPq+x5dOIWfmYN2IwPGqsY4GIDnr5D5p/TFb/zTrvdCiFDVzvJVdGEBhyTYS7/tl9nfPwp7HPuvMGd78umFchvp4FUkX2DjokveFVlgeVmghsgqk6WiI0eGNCdL8Q7lvFEn9rv1rnVIoR7KK/HMibEGX+gy8J6oPbJM2w5ntWe+vlWdyBlnwzlL6tOlpzoHD7jkSyv5WaOUhkbawCf3x0I8Ya3MyjoWm1C75d31la5r5Hi/z+MaUXQjRKCBvVRJ459cAIDGPPynuztgOyJmqxDW01M50ezONFsTB9xXdndq41PQuP82HCF+RMMxVNC9Me13Yz2kWBwF4nKQo47MP+lfZft+cywJDZafJATqjfbgPj3HN5113dJlqE+H1VTmwi/hzKECcL5VXhiMJgrGu7T0OB8ApoIQFu3YJ8I+lCjl2bMf8oADrXBUI5cukvzZPEO5BmyDZrFAK7CSfKdKXpul4V+UYNtP8/mFcpQw02TG1TKsSxLc579WUzGGu4lhCmux5QeI45ak9UBXMYk4WupinjrhpXL+LDYZiW47Ld4d3ggUxu9DsztXILZr5V6/N6XY3Rl6fSjBdvKPtP1o1486AU7mJWbH6d9Gfn3qpFP+KKMUUUovYPwUqxCS4S82C3oNNeQj/uDsGk+4ABlc60zsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fFNQycAq6GsrfUkjPyW6lDGexaMD0Y50Bp1hWmiFQGpnSxdOn8zYI551PWS2VPq8Bf1qcBAted0PW3AksMGxfotn0PX5S49LwkghYpl30G4TwTBwXeEE8YhkUj3UCgnKkQTgg3ppaaEJn37VjOO8gHWMUZFitd7I0lN4XXIW1NELPlGybzBDY0fRrM0BkBugtkYaJ752af0jDl/CWPVanX7QUcq67zcFiyIinH/UZfrUd2pM6RhaoytfflN7N+X5wnTr4debpy2FoybKCws8KBjq0HdmcWaVEpKZDLvCcfV3xA7aTApyt8nG7oR9hjlAAQobEATwivhh2KjnHGpNNCBjlpmjBXLKiEYRZT+BjCkru4wZWWctXEFvjxQW0Ex3sBPGWobtVHNR6aqbYAkt2T9fuhSrvdDc+8W7rnb7dBU5AMmh3VJcq8h1L9ECqjk/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:32.4609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355bc08a-64f8-4443-436e-08df17b56ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
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

Implement detect_hung_queue() by matching enabled HQD doorbells over
MMIO, allowing GFX reset to locate the queue without a MES request.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ec1e142549c5..96aacaf2fc27 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -912,6 +912,10 @@ static void gfx_v12_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc24_grbm_select(adev, me, pipe, q, vm);
 }
 
+static bool gfx_v12_0_detect_hung_queue(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					u32 *me, u32 *pipe, u32 *queue);
+
 /* all sizes are in bytes */
 #define MQD_SHADOW_BASE_SIZE      73728
 #define MQD_SHADOW_BASE_ALIGNMENT 256
@@ -951,6 +955,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.read_wave_sgprs = &gfx_v12_0_read_wave_sgprs,
 	.read_wave_vgprs = &gfx_v12_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
+	.detect_hung_queue = &gfx_v12_0_detect_hung_queue,
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
@@ -5046,6 +5051,43 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool gfx_v12_0_detect_hung_queue(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					u32 *me, u32 *pipe, u32 *queue)
+{
+	u32 i, k, p, db_ctrl, dboff;
+	bool found = false;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.me.num_me && !found; i++) {
+		for (p = 0; p < adev->gfx.me.num_pipe_per_me && !found; p++) {
+			for (k = 0; k < adev->gfx.me.num_queue_per_pipe; k++) {
+				soc24_grbm_select(adev, i, p, k, 0);
+				db_ctrl = RREG32_SOC15(GC, 0,
+						       regCP_RB_DOORBELL_CONTROL);
+				if (!(db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_EN_MASK))
+					continue;
+				dboff = (db_ctrl &
+					 CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+					CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+				if (dboff == doorbell_index) {
+					*me = i;
+					*pipe = p;
+					*queue = k;
+					found = true;
+					break;
+				}
+			}
+		}
+	}
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	return found;
+}
+
 /*
  * A gfx exception IV carries no doorbell. For each faulted slot, read the
  * doorbell back from the HQD (left in place by the fatal fault), look up the
-- 
2.49.0

