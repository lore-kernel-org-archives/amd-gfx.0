Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FBCC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 21:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E742910E331;
	Tue, 28 Nov 2023 21:25:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6753910E32A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 21:25:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFn3Bkk21JMYALJuc1ex4/M3cDJcA1FscDuvjZaHoTHw6PEa9BWCdZXU6fVUpQiDyipquzswAkSTJvpj4jL9nIHU89SEXu/IzUN2vxz9ugCcUZwg6wqFIX+INxrOmtq5NKdjS2yDR3udDE2HbVGkM98pkW2SREuBeiXICV+p89GM0qFww98pVunt+qhg8YeEd4QxvyOveEMRZrOl+hrYnR5rmunAIKSelbeGirYmdz2I4dPU+TjyqW+SoqZU8j9ca5cjChNHq95uATqKzhEsmDGT5heg2r5KwFrMNyvElGpPmYtdeoZMgNZsRwlW03uAXYKyql/NOzJc/xpjdrHfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojkMAQ/q+NOTGKVRNOZ/No0d5COWLpweIOB1JyioyQ0=;
 b=FElOtq2v0Zv06GuG16bPncXfd2Xe4eTrbLPgB8R4LiA8AP9yMwGJulr/BpKJLGmNvZ2N0WdSKinRMIv/CBsxUP0K9K6u1m/cmQNaOk0+pmMTAbn9rmKADLRCkZWjivhftK6p+lN7ZLLhgLpNNRjSX6/Negi4VA9XEmHJHPINF3qclvg90A1kqt9xp9HDuCvNQHccnpkpTNA937TD78XTDsFdIkno2azEvH346+hhyzG+BzCqTsUoCUdcfFygnvqwBQ+19bO3cYP4sxHFoKarxc9J3LEJ2AxZQ74laf+KEiGOOaNqRDYZf/l/TMtGUz2t0fXirhaS6ykrWH29OmEXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojkMAQ/q+NOTGKVRNOZ/No0d5COWLpweIOB1JyioyQ0=;
 b=mS1iSOTeMndwOLvDxbSD5MhTDgFVDfZVO4ee55ODjUisjfOYQ14bcgYTylO5vxEzSy6WUz7q64BUQ5H9MA5C8T8dNErJpDgNxWuaMzpQe9hKGbsG7H0inpkTY5Z4xJxr7mbplU+nseLw5HjZLjXLw2PGM3c8JNKq1eJT9DC8NpU=
Received: from BYAPR06CA0063.namprd06.prod.outlook.com (2603:10b6:a03:14b::40)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 21:25:32 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::bc) by BYAPR06CA0063.outlook.office365.com
 (2603:10b6:a03:14b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 21:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 21:25:31 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 15:25:30 -0600
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Clean up VCN fw_shared and set flag bits
 during hw_init
Date: Tue, 28 Nov 2023 16:25:17 -0500
Message-ID: <20231128212517.3183-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d3de75-1d77-4a44-697f-08dbf0588d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7+7rP7TOi/alQtP5EWx/f2bt7TAPuNe0bjJzgBeqkP/AMvn9FO5u1OQqFwD2tXXMc/X9w37yzxflqV9Y1xtJkfW9H3n6mpOVJB2IRBPHWB2Ef4hJiUDNOzWt2qfCKVq3b+1uiT7dUTzX1R+ABFv6DU0+8/yLomoNCoZ64rXH0TAAlyZApvBI55t8r4QjLralNcW246tkKryDSorT0tt+g2tF7P9Lk7S6g8xyGFflkq8KHkvn2jrIIxAI2xyUdbyr3b450fX9pyZ+zMF77QxEtP1XEWKOlqQBUQ/0/Imr04Be4a7fbEAvviYN7yzCk0iIHIRDmP+4ndeCqKR2L8SGXcYCcUfI2Bm9GkNgUwvQXVqYbU1Q0NpsrF6xFSUed7/G3cKqRlitYfGKn65Z5+nh4obl+zyaoTgjLhHC5wNW77MX0mTqDqjdaY/m2AcoarOP4XzB0CES6x3Y2RwprXnQNLnjl7BrDB5NU5r4vJ2OxrvX6siXD5dp9NfbNTCaIiygKXTGrfByNyhzHqHVCxJKNm1HdPcTSbsPZQxgXMlyX4impp0Gu4ZDUKVOplyUQpviEr2hUP/W+/3CD4oZ1T2On11cKYqSCDUPnTx3ZadqmvRrzL1Y5e+rHGQwEYBYSqgXuL2jCiZ/l26HrBzUjHEfkpynQ6GKYjk02iZFJUBZ6QO9+U8vXYFf3BCNjhl7Ji5orY2csP7rrZzsMEfkwEqWfhwfn7zMXX1BDAfypH0AM1iewcLFqOvUrrS6xpkpzkwrAO269mM7QqTBORRoCcCiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(6666004)(8936002)(4326008)(8676002)(7696005)(70586007)(70206006)(316002)(6916009)(478600001)(40460700003)(81166007)(356005)(47076005)(36756003)(41300700001)(1076003)(86362001)(26005)(16526019)(2906002)(44832011)(2616005)(40480700001)(36860700001)(5660300002)(83380400001)(426003)(82740400003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 21:25:31.8829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d3de75-1d77-4a44-697f-08dbf0588d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
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
Cc: Bokun Zhang <bokun.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- After whole GPU reset, the VCN fw_shared data is cleaned up.
  This seems like a new behavior and it is considered safer since
  we do not want to keep the residual data

- However, the existing driver code still assumes the residual data.
  For example, in sw_init, we will set the UNIFIED_QUEUE flag bit.
  This flag bit is never set anywhere else.

  Then if a WGR happens, sw_init will not be called and therefore,
  we will lose this bit and it leads to a crash in VCN FW.

- A proper fix is that we explicitly set the flag bit in hw_init
  every time and the data is repopulated after a WGR instead of
  assuming the data can survive the WGR.

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
Change-Id: I783ff826f12e12eaf48d046ff9f1cef65558c7b9
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 45 +++++++++++++++++----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index bf07aa200030..0cf3e639c480 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -111,6 +111,7 @@ static int vcn_v4_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	int i, r;
 
 	r = amdgpu_vcn_sw_init(adev);
@@ -124,11 +125,12 @@ static int vcn_v4_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		memset(fw_shared, 0, sizeof(struct amdgpu_vcn4_fw_shared));
+
 		/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
 		if (i == 0)
 			atomic_set(&adev->vcn.inst[i].sched_score, 1);
@@ -161,21 +163,6 @@ static int vcn_v4_0_sw_init(void *handle)
 		if (r)
 			return r;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = 1;
-
-		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
-		fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
-			AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
-
-		if (amdgpu_ip_version(adev, VCN_HWIP, 0) ==
-		    IP_VERSION(4, 0, 2)) {
-			fw_shared->present_flag_0 |= AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;
-			fw_shared->drm_key_wa.method =
-				AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING;
-		}
-
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
@@ -245,9 +232,33 @@ static int vcn_v4_0_sw_fini(void *handle)
 static int vcn_v4_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	int i, r;
 
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+		fw_shared->sq.is_enabled = 1;
+
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
+		fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
+			AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
+
+		if (amdgpu_ip_version(adev, VCN_HWIP, 0) ==
+		    IP_VERSION(4, 0, 2)) {
+			fw_shared->present_flag_0 |= AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;
+			fw_shared->drm_key_wa.method =
+				AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING;
+		}
+
+		if (amdgpu_vcnfw_log)
+			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_FW_LOGGING_FLAG);
+	}
+
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v4_0_start_sriov(adev);
 		if (r)
-- 
2.34.1

