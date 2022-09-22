Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BF2C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 19:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A362E10E033;
	Thu, 22 Sep 2022 19:31:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542C010E033
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 19:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbW2cvD1dRTbLWThRbOjXLEk2pFyTkkwzV9w3ov0iClh97n8jCsV5go1zy8xWBcB/4XSPHQf9Fwz5BGXZ0JPbiWEuNoWjwAiUc1cygpL0J52+l+LbpikQEpixKrzHIMJs91S4unZybnI9C8peFVyJ+h9ao0oJztFrOB8b6FZ3eKqUzDyWuTDTIc8gHSm/8OpvYZX7H8p+LRIxDrK7lUw8EHq0YGYzRE8AtcI0s1l6zrdgnOx8S0UAf88rog4KQyFwfUWrC2184Bqo/oGMEGRTyQThmaxsADNnXmZZSDX09tMx31d8lp6tMUuolpwk2+NslX3kTRL83CEVnGvqH/kjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u67pTDomEVVnyPF6Y9KAJeq0k7/kuAet+CuuUicTkcY=;
 b=jv+iPz5OyMi4UjA/atlumkgXnZYmPTOMrsZ8nwP2zZ/ikZDAr9hNaVNZtIDm8CzqrSk+5crW+o0GKdouwJMmvyNSelavAZ/1Ayi9yHN/nXN8a8Qeic4ccKRbqVYgzT6ixX+21HYU2nnBO483FXWaTZ8V84ppLOzYhP8AcltKjWk4zaJ7vRPQ8HJUexjltxzeftIjZ9YtmsEgI/a9QdskP3kotrnrRlNWAyRQXlOQixTUnhmgWXBic0XKO0FAUQITqUMv8stEwd8t5naNoLOigOiSWmwsstqqi0vtmcFEsqp3olRyB/LquNfrbbTso7NAUyZnU+rwN/P98ChBkMU21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u67pTDomEVVnyPF6Y9KAJeq0k7/kuAet+CuuUicTkcY=;
 b=Xa8tQyex/nhnbBodQMC2jCzepu+KjMczG9OPnci9Frk47sfPHdVIPtL3TpEgUMrAUPCZl9fp+c+sbxIcv1xuM4SAhXpfSxXHrVpH9P0pbJ7hN04fq0zAGKQuiBTun9Snim0J+eAwFQ4+nRpNmgq8Oc4CClrkpSwvZQD/oKwRu3Q=
Received: from DM6PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:100::39)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 19:31:00 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::da) by DM6PR03CA0062.outlook.office365.com
 (2603:10b6:5:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Thu, 22 Sep 2022 19:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 19:31:00 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 22 Sep 2022 14:30:58 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <james.zhu@amd.com>, <boyuan.zhang@amd.com>,
 <sonny.jiang@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: update vcn4 fw shared data structure
Date: Thu, 22 Sep 2022 15:30:42 -0400
Message-ID: <20220922193042.35427-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e900af-77cb-4916-dd84-08da9cd0fad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nhI4AB3ecvub6cot8nynZaf4d+4ocsBSrT9+6aO9jGQh39Dwxg5S+2Ngt6Jr87ikSmSD4uqnMvPtdbxSYeM2rjuMmz48DsRIGxm/I9bhZbQTKzwGArXb4IPWHgctZx9fj3XpNrt3Q5Qv/rgu5Vng7sI+HgDF5PrynkeuYOaJaCWAwtyTB7V9UoWzxbAdyCsM5nK2kU78d/jVOR4n9REcvBEj3E5D7tvXjLgVagFVUkIA+ZWF3Xy07hFsMJ4ZjsuGBFDcP3kVIyhwZNIP/gw0nUm++QzJHvsuFQe1i3IL2P1snNgtKRRecazEax+6DFrJFhCKQDWtb7McnKe5xRZxclUsLC9Iz/SRInIguSY2dTUzA6T13MipQNQP1LpJMfp8LpIuy2Vea8aufGqNwp3rCQnksR8eH+eAXgt2fukydBv/AT9dFWpfXLHjNyxRELs1bGn/QoMAhg7CziSjivPUrrVja5ILKApbZHbkgq/Vb+OTnT0xWGK4huChp+0Uh5yBat1HIfD/Op9PZah7WRsbaDQjRHqZCDRvj1+XrgqQm5zCjnvSbCbG2F+KakpfEcE3Eqnz5o0yuTwV2HedVULoCiz2MjGLynh7VbY21wFT3WeY87lDoSvm7KBWziuPSeAx2awffYyfOKPOLtbbKKBbWl/l4EKjlke71/UQDMmE5wPkqSR37445jq2+5dm7sy+RfPZEvwQDbrzYPp0xN5XjpnN6vi/jji/lr+80lcFA5N7PGZ9OQH8fxicjBWQEVP8OCjDZyxkqmg4ogC8i5x8qUiCAPEqpDQG9U3KzjXwEm0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(6666004)(356005)(82740400003)(7696005)(81166007)(36756003)(26005)(47076005)(86362001)(2906002)(186003)(316002)(16526019)(40480700001)(2616005)(336012)(70206006)(54906003)(4326008)(36860700001)(426003)(70586007)(8676002)(110136005)(83380400001)(15650500001)(1076003)(82310400005)(41300700001)(8936002)(44832011)(40460700003)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 19:31:00.0899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e900af-77cb-4916-dd84-08da9cd0fad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
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
Cc: Alexander.Deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update VF_RB_SETUP_FLAG, add SMU_DPM_INTERFACE_FLAG,
and corresponding change in VCN4.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 80b7a6cfd026..253ea6b159df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -161,7 +161,8 @@
 #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
 #define AMDGPU_VCN_FW_LOGGING_FLAG	(1 << 10)
 #define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
-#define AMDGPU_VCN_VF_RB_SETUP_FLAG (1 << 12)
+#define AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG (1 << 11)
+#define AMDGPU_VCN_VF_RB_SETUP_FLAG (1 << 14)
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
@@ -171,6 +172,9 @@
 #define VCN_CODEC_DISABLE_MASK_HEVC (1 << 2)
 #define VCN_CODEC_DISABLE_MASK_H264 (1 << 3)
 
+#define AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU (0)
+#define AMDGPU_VCN_SMU_DPM_INTERFACE_APU (1)
+
 enum fw_queue_mode {
 	FW_QUEUE_RING_RESET = 1,
 	FW_QUEUE_DPG_HOLD_OFF = 2,
@@ -335,7 +339,9 @@ struct amdgpu_vcn4_fw_shared {
 	struct amdgpu_fw_shared_unified_queue_struct sq;
 	uint8_t pad1[8];
 	struct amdgpu_fw_shared_fw_logging fw_log;
+	uint8_t pad2[20];
 	struct amdgpu_fw_shared_rb_setup rb_setup;
+	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
 };
 
 struct amdgpu_vcn_fwlog {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b6f73b87c47e..897a5ce9c9da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -150,6 +150,10 @@ static int vcn_v4_0_sw_init(void *handle)
 		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
 		fw_shared->sq.is_enabled = 1;
 
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
+		fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
+			AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
+
 		if (amdgpu_sriov_vf(adev))
 			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
 
-- 
2.25.1

