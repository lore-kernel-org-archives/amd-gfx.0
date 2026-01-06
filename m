Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DBFC47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4461310E395;
	Tue,  6 Jan 2026 10:13:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R4Rh6K6/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4893410E4BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZeJ1Y1WuLD6923LKu3hPefCEzbroLy/BN3H7hH0g76U7qddHOu8Ma2TChNxIJWfkDz4ftsGwYK2PADCzm2rafFoA55I8TnRoZgjDpnLaqsJ3RxeGqMCf+c0wzS2oQHc3YNLQi71IozRvNI9dtuBZ8e04m0ZnhiROlF3EUGPjm0tsxZ9QiYhzs7bGMWm8K8ClKAwsLA+AdcgbyaDV5Lz4HEB+I0gYq+608cP6sZ9tXyYayM9kC1aXIuSub1+CKLBp21dRaPR8koKhwWCkFa444xxEIUARQc2cAp/19+7v7hPPAq6sqEyl5ahJzB0c4rb+JPOzUxvTe7ACLYt4yz94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hz/DuYsTU6QiDupvaC4I5i840ihcxFRLT7Zr5k3A7Zo=;
 b=m5rpjW6Co93DeJnDPVQV7KIYJOd81MsRePlxy5RB9mgHtmcrp+LevRCeb9Y2UfBJkoYXiVmiyekWH7f05NZ2C49D1Pklk8fFhdbqoDyJSfAb754g2umBze/qd+p7g4ogfY28mAtHBCZ6e+9iwEIVmPu+3F42bKqhnBFf2D+kjmXtSbg1E2pVbf2//kZf/N5CFYaaQ/29fFm0KKyl9sKn9Qb046OKoOBzDdPJxbQnPg2U0kXUJ/UhRZ7FtCPEMdBzWrkBqHlSyKh2hFW7+MxVq2dgK4YWF5OQC0Bjtekb9YWHtbbeNydN28jHfd3t5Zx2FP55UbTOvRuqMc2dgIrMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz/DuYsTU6QiDupvaC4I5i840ihcxFRLT7Zr5k3A7Zo=;
 b=R4Rh6K6/rMaTHkuucRiEgYFie74dgQHVb5Ru/4qghW9SdQ3vud6Zq7YNDYbmwhoBQIDEzXjtN+dy4W1KkdUNGvD01IX0Y7Sr7drDneotVFvaU+QxAcODu/bsjePLrrR4zrnz8AqhmqClRmxbUc6zVfHNMIE6iVGAAxHd3gXXK9I=
Received: from SN7PR18CA0001.namprd18.prod.outlook.com (2603:10b6:806:f3::15)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:50 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::20) by SN7PR18CA0001.outlook.office365.com
 (2603:10b6:806:f3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 06/21] drm/amd/pm: Use message control in messaging
Date: Tue, 6 Jan 2026 15:42:26 +0530
Message-ID: <20260106101317.3856153-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c3d0ad-30f1-4579-c6d9-08de4d0c4966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kaeha1w6YAJ88CZLLmyAS+4t1DeEFMFyWNrHQyspiV8vj7jYgVsc1QuZg/YJ?=
 =?us-ascii?Q?+LXX2BfJ1KgKsW1BXVmqX+DBXWJ7Q5tber33b3FCJTtynNfU6IEf8U+kJo+A?=
 =?us-ascii?Q?9q/s+Bw2x1Jt+7NoQ+dMIS+kur8AiAPtwzr4KqfsBgOw7EngDRvDYcgslAbV?=
 =?us-ascii?Q?rbkA1hknaDIh0SlucCKGoPOE0F5rE4Mh/X9kwJpiNiUIp9cjfD0oiTpm4wKj?=
 =?us-ascii?Q?mXg0RFSUzxYjtSA15czzG8aX6rAJHEOFzWhNxwBfIcBbGkZxK680DErB/1GB?=
 =?us-ascii?Q?L3KLxEpNPgYPUWqpUHqJSTKgiHNo3D08QT4Dya7tJEBmmyQFMAvOnEEsQDqT?=
 =?us-ascii?Q?KtgkbyNR1tSJHq1RiSG2Lw/ZEOsz0xYX4FbrRCcYVLWpgfiV5vWKhE6y994n?=
 =?us-ascii?Q?1vZge9o6VQpsy3KS8iXKUixms0AR5AG/mDmLXhnqwMuJTCN9VhWJSMIVb4SQ?=
 =?us-ascii?Q?ymM3YDDLAmPu3otZfrtVUKys6uWO3XoELpu53RYADYRMRzRcO3ffDabd0Dc2?=
 =?us-ascii?Q?2ZcXJd2e3UJv+cUH4t6OJCDAb2ngtekw7DrfVBZXZBX5Q5ne99EWpc6/d9Dc?=
 =?us-ascii?Q?dohUroOFfpNk0RhTHndmxKMUUeUfgCagxuuMRxQhN2uqndomKfUcl34VZK3C?=
 =?us-ascii?Q?+9wGcvL3Y5HnyYPif6xpGo4q/heFLbiskiLztpfhzGHk8yeuUby1GBNtfRJm?=
 =?us-ascii?Q?0W784q+5mKoCLsseX2BzwtgWdXRJry08G7lM3xN70HGNMRdwVV0C6tvhGHkv?=
 =?us-ascii?Q?V2OIHuoTmrtFGhgLIiZGyrHWc3isNwVnQq1o3/VKVDOiNw/T+PysSePm6rPZ?=
 =?us-ascii?Q?ydAu+fVppQrUV5mmy7NpZTMBoLH5TZL7wxV8VyhTHqgkVH9coS79PpL0fEl1?=
 =?us-ascii?Q?Hj5Wxq34z8wSbLh0rJo1dXBsUb+R0GXDlUTb+wfIK6MD3ELJtKUY4mIrtE1z?=
 =?us-ascii?Q?efuYXPAC5Dcbq1VQuWeDn/csdtOs68qWOrd8GAKuqCBWXAW8eiaSWrfG8z0p?=
 =?us-ascii?Q?Vj9bbrSgbeLZDCz/pAaYd7LvJMXogjizwPCUYshJzrzHY2rlIWA4XPI9w4Ws?=
 =?us-ascii?Q?1pXgHEeeCRJigv+j0c+XwF7YMvZ1uYXR2wyw9OY4zEKUPOoXmXb3kfe1OuKP?=
 =?us-ascii?Q?j4rCRUF101KVNBXFWfgmI39BbD8d9u+WnnEgMNTRtoRL2PLUqB9IrSDg5RK/?=
 =?us-ascii?Q?tiiCuB91qLdKQqJTS++JVGrUmisyu01HHgBndbh9AAfrtnm+xzD9eu57QZZP?=
 =?us-ascii?Q?E0y2xij7d5x2Xt/DcwZHigr0fwqDrSyDtMn+XwCJZUBD+ntTeOvvHauXZtfJ?=
 =?us-ascii?Q?raDsXnuqYcUk31Rk14GYv9ZQDOqPr/KC8T5rBg/RzeEv7lUXC49IHpF99aNC?=
 =?us-ascii?Q?Bx72LaZmO5rFgGfffQCKOsBkhTyV0XaBexXCJDkP1CjiLjlqzhogvLUysrRP?=
 =?us-ascii?Q?CRMFnQM6XB7MEHXW9NB8sZrs7zIe4OEvUz4HiEdiipjtwRAV9IO8RL9JNmb/?=
 =?us-ascii?Q?5+eLJw3KMVVj3hpEQV/TFTfi89xYNca8+5m9MokwQJl0jigruoFLE2h3Vr2V?=
 =?us-ascii?Q?hS4qtOCwVO2FZhAUkck=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:49.8938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c3d0ad-30f1-4579-c6d9-08de4d0c4966
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
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

Use message control block operations in common message functions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 92 +++++---------------------
 1 file changed, 15 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index de4b7f423a76..3c06ac5d23fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -375,22 +375,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
  */
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
-	u32 reg;
-	int res;
-
-	reg = __smu_cmn_poll_stat(smu);
-	res = __smu_cmn_reg2errno(smu, reg);
-
-	if (res == -EREMOTEIO)
-		smu->smc_fw_state = SMU_FW_HANG;
-
-	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
-	    res && (res != -ETIME)) {
-		amdgpu_device_halt(smu->adev);
-		WARN_ON(1);
-	}
-
-	return res;
+	return smu_msg_wait_response(&smu->msg_ctl, 0);
 }
 
 /**
@@ -430,70 +415,23 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
-	struct amdgpu_device *adev = smu->adev;
-	int res, index;
-	bool poll = true;
-	u32 reg;
-
-	if (adev->no_hw_access)
-		return 0;
-
-	index = smu_cmn_to_asic_specific_index(smu,
-					       CMN2ASIC_MAPPING_MSG,
-					       msg);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
-
-	mutex_lock(&smu->message_lock);
-
-	if (smu->smc_fw_caps & SMU_FW_CAP_RAS_PRI) {
-		res = __smu_cmn_ras_filter_msg(smu, msg, &poll);
-		if (res)
-			goto Out;
-	}
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {
+		.msg = msg,
+		.args[0] = param,
+		.num_args = 1,
+		.num_out_args = read_arg ? 1 : 0,
+		.flags = 0,
+		.timeout = 0,
+	};
+	int ret;
 
-	if (smu->smc_fw_state == SMU_FW_HANG) {
-		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
-		res = -EREMOTEIO;
-		goto Out;
-	} else if (smu->smc_fw_state == SMU_FW_INIT) {
-		/* Ignore initial smu response register value */
-		poll = false;
-		smu->smc_fw_state = SMU_FW_RUNTIME;
-	}
+	ret = ctl->ops->send_msg(ctl, &args);
 
-	if (poll) {
-		reg = __smu_cmn_poll_stat(smu);
-		res = __smu_cmn_reg2errno(smu, reg);
-		if (reg == SMU_RESP_NONE || res == -EREMOTEIO) {
-			__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-			goto Out;
-		}
-	}
-	__smu_cmn_send_msg(smu, (uint16_t) index, param);
-	reg = __smu_cmn_poll_stat(smu);
-	res = __smu_cmn_reg2errno(smu, reg);
-	if (res != 0) {
-		if (res == -EREMOTEIO)
-			smu->smc_fw_state = SMU_FW_HANG;
-		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-	}
-	if (read_arg) {
-		smu_cmn_read_arg(smu, read_arg);
-		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x, readval: 0x%08x\n",
-			smu_get_message_name(smu, msg), index, param, reg, *read_arg);
-	} else {
-		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x\n",
-			smu_get_message_name(smu, msg), index, param, reg);
-	}
-Out:
-	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
-		amdgpu_device_halt(adev);
-		WARN_ON(1);
-	}
+	if (read_arg)
+		*read_arg = args.out_args[0];
 
-	mutex_unlock(&smu->message_lock);
-	return res;
+	return ret;
 }
 
 int smu_cmn_send_smc_msg(struct smu_context *smu,
-- 
2.49.0

