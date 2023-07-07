Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3337AEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 13:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE07110E589;
	Fri,  7 Jul 2023 13:39:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89F110E589
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 13:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex5fvQ/Yv4soqA510o1rOJ1lCiEL/zTpCRjmRpO0e2XDGTMlV0AQ0mvmj1xhf/Q/IicGPAnOBueh6XikKOWeLHPyGjMH56290y9VyrkAGBa1mXNW+iWX6r61ZSIRYisctVbQT1xd1m4R8MgaZfmSmblvv5ZCqvD2rFSSHN2ia/0NY+iYJkwUYPjcsemjtIO4+W/q7QwEbCe5ryvnCQSr4zNVbeH8CuUBjRrgU7GifERZywM/p+wsAmxnfAN4EKaktqqvfCOsVuThVKuBc/F0KCnU64QFBu/XzuvBl4+y/ZIZMSnvE1xXvADW331z4XDTdi6boP2ygpZc6+4gU74dvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn0iYPNYasQmsiCEV7pOsRPU9SaxW4caXSStLlhMbWI=;
 b=ClOhkIczV3MoubFbNfO+PmwF85JpjIG1RzK/YYKWFq7qw6InO6HIcwEfWmbaUJmn8F2jnHWwyK8EhDhrQThTpeOqVVjqZ0YWzrq/YHnpEWXStF56qFbX16aslNVwXPIpN6HAcC/cDon7tBdhLFlbmd5G+h8q4i32jgJWJQoQ6yIlM13NnJrkeSu7hhkm+GT2aTHj0vNZdjXUbC/HcqacgVtmOc/a0LykVxz0f3Ey2rgh9XjBK+Zeku9h0VdryxKfNxh43ynBqxQ+Tg9oZOhQ29cy2KqvtqdVNMVyv7LjVy0jYWFiUybntEYMIljLJ2G7Z1HGOAY5exIWIVy+Pb+NxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn0iYPNYasQmsiCEV7pOsRPU9SaxW4caXSStLlhMbWI=;
 b=gmA/QlyXm4to2suW5WSditwBMyBEcqjB3bFTqJ+uSTA9ILam/ydrqwayCWEqoeaB+l/BnBnyll9zQiCfIXWU3Hghzcn8ORD/X3exmp7MBrScveRYlB245sgWalyK3TzlxeZ9DJ3W1hoRS8m2j0QmhRDr4Ed7C1gQPpcVoBT2c1k=
Received: from DM6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:5:174::17)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 13:38:59 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::ce) by DM6PR21CA0007.outlook.office365.com
 (2603:10b6:5:174::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13 via Frontend
 Transport; Fri, 7 Jul 2023 13:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 13:38:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 08:38:56 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 7 Jul 2023 08:38:55 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: check whether smu is idle in sriov case
Date: Fri, 7 Jul 2023 15:38:38 +0200
Message-ID: <20230707133838.2182653-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f76a35-8754-4cf5-3f08-08db7eef84c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hXfKvtJpuMAB1b+h8WJCVbCLVRHDpBfWq5KGC6o4eyXFgsDpKPh5WT/siAX9MR/bkLJ+nMfgPH6qBFR56uIjJQ+PB1+3ZU+dwE+MDNQgXKnz6iNKUjgcLboC4tjXbtXWtfch5quJI18K0tix4B+ULioBGqIebm1Qnf24q16X5LOPAYFliSPDGYcuBDSh2IcrpFxtpZE+2N8o4Cn2UTI634iJjuQB+5NKgi3L+0CG4oYvin21uRgPf61Mk5PAH24L/tBAa+6sZDNlaD1EgtqbF7kD4Lz+ZkAV/QhAAZHdmACNvAytKcWw+gs+yoemoG6NGwJFmsCWdXxDSL2ueCV7uuaBj4xIkIN7ES/htUc2pNnpN2fIgvpR5tkdA/gT15DM0YFNFBB/Lh3yO6gUiY5HM7llE3n0Ynt3FDkRXy6I6Kg0TgtH27KfhF39qv9f1vobSwA9s3R9+dAwI1J5v1x2+Vl74pnTTZIz9XIFAi24RbKbNyB7xwn2TZXTxKCMPT3wdHiZrGvCWpMARJca/x4DGzBTSoJdsr1JlvEEMdcHFEBMouZgu3bB7VcA12DaJufesL0Rk0GT7VYgRPeSP3WVpiAxnfCFkEjWB6/q8qHf3tVtBBTMXerJ/7+iZdVwZPSvWjR2BV3J6hYe7ppBi7dUafbXMdA64MKduiHlJeP3psC/CW/4SZq6hy1GRy+he0xoyur+Qa4djdtkfNtPRH2mXToChumyvUnA1r4hUF511rXaTj+BXrnmABy6OLxMYEpiEweVg390y03caLh1esFEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(336012)(26005)(1076003)(186003)(6666004)(426003)(7696005)(81166007)(54906003)(47076005)(82740400003)(356005)(478600001)(2616005)(36860700001)(316002)(8676002)(41300700001)(5660300002)(40460700003)(70586007)(44832011)(70206006)(4326008)(6916009)(40480700001)(8936002)(2906002)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 13:38:59.2013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f76a35-8754-4cf5-3f08-08db7eef84c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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
Cc: Danijel Slivka <danijel.slivka@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Nikola Prica <nikola.prica@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Why:
If the reg mmMP1_SMN_C2PMSG_90 is being programed to 0x0 before
guest initialization, then modprobe amdgpu will fail at smu hw_init.
(the default mmMP1_SMN_C2PMSG_90 at a clean guest environment is 0x1).

How to fix:
this patch is to check whether smu is idle by sending a test
message to smu. If smu is idle, it will respond.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
Signed-off-by: Nikola Prica <nikola.prica@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 40 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 3 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index aa4a5498a12f..1568b9958150 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -184,6 +184,15 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t mp1_fw_flags;
+	int ret = 0;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = smu_cmn_wait_smu_idle(smu);
+		if (ret) {
+			dev_err(adev->dev, "SMU is not idle\n");
+			return ret;
+		}
+	}
 
 	mp1_fw_flags = RREG32_PCIE(MP1_Public |
 				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3ecb900e6ecd..e3c972984b2b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -313,6 +313,46 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	return res;
 }
 
+/**
+ * smu_cmn_wait_smu_idle -- wait for smu to become idle
+ * @smu: pointer to an SMU context
+ *
+ * Send SMU_MSG_TestMessage to check whether SMU is idle.
+ * If SMU is idle, it will respond.
+ * The returned parameter will be the param you pass + 1.
+ *
+ * Return 0 on success, -errno on error, indicating the execution
+ * status and result of the message being waited for. See
+ * __smu_cmn_reg2errno() for details of the -errno.
+ */
+int smu_cmn_wait_smu_idle(struct smu_context *smu)
+{
+	u32 reg;
+	u32 param = 0xff00011;
+	uint32_t read_arg;
+	int res, index;
+
+	index = smu_cmn_to_asic_specific_index(smu,
+					       CMN2ASIC_MAPPING_MSG,
+					       SMU_MSG_TestMessage);
+
+	__smu_cmn_send_msg(smu, index, param);
+	reg = __smu_cmn_poll_stat(smu);
+	res = __smu_cmn_reg2errno(smu, reg);
+
+	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	    res && (res != -ETIME)) {
+		amdgpu_device_halt(smu->adev);
+		WARN_ON(1);
+	}
+
+	smu_cmn_read_arg(smu, &read_arg);
+	if (read_arg == param + 1)
+		return 0;
+	return res;
+}
+
+
 /**
  * smu_cmn_send_smc_msg_with_param -- send a message with parameter
  * @smu: pointer to an SMU context
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d7cd358a53bd..65da886d6a8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -50,6 +50,8 @@ int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
 
 int smu_cmn_wait_for_response(struct smu_context *smu);
 
+int smu_cmn_wait_smu_idle(struct smu_context *smu);
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index);
-- 
2.25.1

