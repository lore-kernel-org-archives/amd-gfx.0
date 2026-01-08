Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA0AD14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C8D10E682;
	Thu,  8 Jan 2026 04:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="La9UE1CK";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B37F10E681
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMrehn10PCihEAe0b88lhWk2TNeyFd3lVqq/4osM+B/SFmcvkAQeucOjAEUnwsomyrtXuxdR876/5fDeBqxwely/AlokgkUWLeig3tuZPHaVPs5jmIWfSsvxSPs0+o60wna66P5X1ulqvW9eCTIqG44qfhPnV+Q7nUf4V0d9bqRDq5A/DFuSv64JNyEwLiRR2ihQk7tNxEnQ2uyw68dDzHpphnUto9J5qMiD1VeErAXwZGTN2ouJCXRS2/3YfZ9vXQa7QYC1sZ814MA82ZKFvtRrvNvJ9UxUWcaPtaLgMgxO8L/HPw9/2pCfkrA9TWxgJVRIgm/u0bneRhvQbW7H8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+IvWjncejgw3MrVKK2RMt6MHH2ELq/SOh2A36IV9Xw=;
 b=qQqFfK7YasuwRBuUp5iELNCYgqTCIRJ6oeuGbo3vXMLJ6uHhNx7BXByqBINYm6EkHUDWx/Whi6S4lplDRDsxacmj/dH5EtPdt/J7gJOZV2YyAwrW/8O7FwubDzOwrO3VKjA4TRvhViqbD0O+erFftthKnTI3GvF8XmboBQpXTkG0GyPj7VVDh1O5HRE9mzdj6NI0YPCOU/334Artme+7PcbHgA31/2/CofBifUjeCfrqnsfmEcK6aQvHolyGnkvJlFDL2bF2N0mE5rEY/XykvN/Gp7Uflvf9OwlgSWZEx3R9LJT1i9ERz9ODeKNuDU1HmTLUJ/btu/l8dDl2KC3+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+IvWjncejgw3MrVKK2RMt6MHH2ELq/SOh2A36IV9Xw=;
 b=La9UE1CKHmrm9InROBsMwSyt6ILYdvczSGjJJ8duw0EwLK5Kq48Wgy3r7NbI4rVXsVh84EM0Z5hrPjpLLJaD0Nz7B+wzuJ8bWHaQOzlJEviF2i4xQtE/j637deS/0nMC83hYyL0tjX7y6UK8+aayTHkP0YeSAAMssDtya/QZTKw=
Received: from DM6PR11CA0009.namprd11.prod.outlook.com (2603:10b6:5:190::22)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:36 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::21) by DM6PR11CA0009.outlook.office365.com
 (2603:10b6:5:190::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:33 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 10/24] drm/amd/pm: Remove unused legacy message functions
Date: Thu, 8 Jan 2026 10:17:26 +0530
Message-ID: <20260108044839.4084279-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: dadd80cc-55f0-4fb2-93c8-08de4e7152c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1NANtnxEnZgoMXb/ntsstjtUiicqhf+8M8HqgBLOjA5OUTKyQu0u5lIq90Yq?=
 =?us-ascii?Q?rNFdCtj/PnAjglcPSaoGtdwKQbsrdvpH2wTwayQQbZ7lIA7phmii89ORCjju?=
 =?us-ascii?Q?qecAEo7niS+iqla5fdlUzK7LoCUzcM2+DMI5L0bGbmr5UFthr3DEw1tekCOQ?=
 =?us-ascii?Q?NpksYBqZCPPy3F5iptpg+krRc8MbrWVUQYvbbGEsm9N5TwvUZic9RVa0oazr?=
 =?us-ascii?Q?LzzN4ptg2ju2sHYyZZ5wgxCHFi6g9BrZOXxiVqmYjRgcH2bepQqSRG4B0e9b?=
 =?us-ascii?Q?+ziQ2pH7rHceRYSLgpAZasx6LMakSS1Za3Dnrzg2IW7iQdcGKEUrJFAp7kWy?=
 =?us-ascii?Q?NeTpJYFhfZetwENYPdcbTmBVAUGHz2Rh2YnEVshjEK36BW6WsWuFx+uVUFZf?=
 =?us-ascii?Q?MK4dvj+8G1xz9uakryTX8DoKYVZIbqS67/vSBxTd3Upg4qedjD5aEC2dmgCj?=
 =?us-ascii?Q?+70VsSE62EYWl8rpwV62RRC81qXouH+Hag6Vvnh/aZD8TDhZmrxQprVY05Fy?=
 =?us-ascii?Q?NDtHEjJNGlQ2p5c1MXlwxEamV7vVVicCXPbAyFrcgkO6ydPnPMNcEDMaFCcf?=
 =?us-ascii?Q?VuUYKMnB+N7kSKSyOYVdBRStQIQnpM9Ar399rGU7jIp/TPXb5dCx9JGMWiNh?=
 =?us-ascii?Q?o1TuI8BJvst8PegWHSl0mQTJw0j6gQjpXJE+oCffVCrCoM15dUxtZliDelmR?=
 =?us-ascii?Q?nBFtpRIqbzTwxlXS7FBuhexDKltmYHwb/VkiG1AZhIANOrIYTZ+dvrULEglw?=
 =?us-ascii?Q?EMAgQzYAfVU64vSjD0PbhbUZOYhrDbgjVpymw6q7g7k+CU7X4jHdA9ORJ9ql?=
 =?us-ascii?Q?rTyv4rm1V4c1Fve3pAGbM6omkJASY5prYfgSEXT0PDEgfsBco83eZhwdVmF/?=
 =?us-ascii?Q?u2eaer6RNDTXUoUrZLZmKzKgkJ43PE2GaERV2leXJ0dFdEMkSrgPebaLJwJF?=
 =?us-ascii?Q?CGEQ5e9pU3iFN74SNP57AnsGRzUOT3V+XSlSE7b9aFkA247k1GSd0VIeINO7?=
 =?us-ascii?Q?OvL2CShhbd1A6pppePQE30LvWn4OJmVBV30O82Evo/b+EcamKZIE+FlVDPQb?=
 =?us-ascii?Q?5zvVl41JrlP/GciSyDFnlFPB4XmdNzXKNLawy7Tby8/EkznfDJKrQ5i7QU/w?=
 =?us-ascii?Q?/w6VM6eYgTlUzX9eRcFPJybNuKJN7WctYlrCYNLH9Mkxd5Pl8erO0pxIDn+i?=
 =?us-ascii?Q?+KxpWSGQDhNlCypNtA5Kp6uQZ0VmtTw0G1pMk01EyhsoZ9cFldDK8izpbXit?=
 =?us-ascii?Q?EVQcAfACf1t2x0HnrQIGoGx3XK5yRkSG4YiDNLv+6l9h73kOs83Sy+rz+uhT?=
 =?us-ascii?Q?86cHrYUiNOEY0t0wMkLeVYQANYyBab4+mIr86KGnIqggZs2u0RsOIApWgTw/?=
 =?us-ascii?Q?ie0W4W5HiRTaPYRgW0ogB2Y1cDv9QdGo/AwkBGbcIeaVK5VA6fPXta1CXO8p?=
 =?us-ascii?Q?6aomLiY+/CKltfgsyK5KgPbRxQigGHdlmNkMWPhjN5u2klwWi17IJDWRBmXT?=
 =?us-ascii?Q?J/8ZLljMLigJjmJ+24o6IwRve2Ht4JmFnBgZs8IRs3saspd4LtGi/v9gUeGE?=
 =?us-ascii?Q?8NUdlmsOcS7eOfCOjbA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:35.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadd80cc-55f0-4fb2-93c8-08de4e7152c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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

Messaging functions are now moved to message control block. Remove
unused legacy functions around messaging.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 146 +------------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 -
 2 files changed, 2 insertions(+), 147 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index ce2986276a81..177643df1aab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -82,98 +82,6 @@ static const char *smu_get_message_name(struct smu_context *smu,
 #define SMU_RESP_DEBUG_END      0xFB
 
 #define SMU_RESP_UNEXP (~0U)
-/**
- * __smu_cmn_poll_stat -- poll for a status from the SMU
- * @smu: a pointer to SMU context
- *
- * Returns the status of the SMU, which could be,
- *    0, the SMU is busy with your command;
- *    1, execution status: success, execution result: success;
- * 0xFF, execution status: success, execution result: failure;
- * 0xFE, unknown command;
- * 0xFD, valid command, but bad (command) prerequisites;
- * 0xFC, the command was rejected as the SMU is busy;
- * 0xFB, "SMC_Result_DebugDataDumpEnd".
- *
- * The values here are not defined by macros, because I'd rather we
- * include a single header file which defines them, which is
- * maintained by the SMU FW team, so that we're impervious to firmware
- * changes. At the moment those values are defined in various header
- * files, one for each ASIC, yet here we're a single ASIC-agnostic
- * interface. Such a change can be followed-up by a subsequent patch.
- */
-static u32 __smu_cmn_poll_stat(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int timeout = adev->usec_timeout * 20;
-	u32 reg;
-
-	for ( ; timeout > 0; timeout--) {
-		reg = RREG32(smu->resp_reg);
-		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
-			break;
-
-		udelay(1);
-	}
-
-	return reg;
-}
-
-static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
-{
-	int res;
-
-	switch (reg_c2pmsg_90) {
-	case SMU_RESP_NONE:
-		/* The SMU is busy--still executing your command.
-		 */
-		res = -ETIME;
-		break;
-	case SMU_RESP_OK:
-		res = 0;
-		break;
-	case SMU_RESP_CMD_FAIL:
-		/* Command completed successfully, but the command
-		 * status was failure.
-		 */
-		res = -EIO;
-		break;
-	case SMU_RESP_CMD_UNKNOWN:
-		/* Unknown command--ignored by the SMU.
-		 */
-		res = -EOPNOTSUPP;
-		break;
-	case SMU_RESP_CMD_BAD_PREREQ:
-		/* Valid command--bad prerequisites.
-		 */
-		res = -EINVAL;
-		break;
-	case SMU_RESP_BUSY_OTHER:
-		/* The SMU is busy with other commands. The client
-		 * should retry in 10 us.
-		 */
-		res = -EBUSY;
-		break;
-	default:
-		/* Unknown or debug response from the SMU.
-		 */
-		res = -EREMOTEIO;
-		break;
-	}
-
-	return res;
-}
-
-static void __smu_cmn_send_msg(struct smu_context *smu,
-			       u16 msg,
-			       u32 param)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	WREG32(smu->resp_reg, 0);
-	WREG32(smu->param_reg, param);
-	WREG32(smu->msg_reg, msg);
-}
 
 static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 			       u32 msg,
@@ -187,56 +95,6 @@ static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 
 	return 0;
 }
-/**
- * smu_cmn_send_msg_without_waiting -- send the message; don't wait for status
- * @smu: pointer to an SMU context
- * @msg_index: message index
- * @param: message parameter to send to the SMU
- *
- * Send a message to the SMU with the parameter passed. Do not wait
- * for status/result of the message, thus the "without_waiting".
- *
- * Return 0 on success, -errno on error if we weren't able to _send_
- * the message for some reason. See __smu_cmn_reg2errno() for details
- * of the -errno.
- */
-int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-				     uint16_t msg_index,
-				     uint32_t param)
-{
-	struct amdgpu_device *adev = smu->adev;
-	u32 reg;
-	int res;
-
-	if (adev->no_hw_access)
-		return 0;
-
-	if (smu->smc_fw_state == SMU_FW_HANG) {
-		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
-		res = -EREMOTEIO;
-		goto Out;
-	}
-
-	if (smu->smc_fw_state == SMU_FW_INIT) {
-		smu->smc_fw_state = SMU_FW_RUNTIME;
-	} else {
-		reg = __smu_cmn_poll_stat(smu);
-		res = __smu_cmn_reg2errno(smu, reg);
-		if (reg == SMU_RESP_NONE || res == -EREMOTEIO)
-			goto Out;
-	}
-
-	__smu_cmn_send_msg(smu, msg_index, param);
-	res = 0;
-Out:
-	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
-	    res && (res != -ETIME)) {
-		amdgpu_device_halt(adev);
-		WARN_ON(1);
-	}
-
-	return res;
-}
 
 /**
  * smu_cmn_wait_for_response -- wait for response from the SMU
@@ -246,7 +104,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
  *
  * Return 0 on success, -errno on error, indicating the execution
  * status and result of the message being waited for. See
- * __smu_cmn_reg2errno() for details of the -errno.
+ * smu_msg_v1_decode_response() for details of the -errno.
  */
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
@@ -269,7 +127,7 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
  * message or receiving reply. If there is a PCI bus recovery or
  * the destination is a virtual GPU which does not allow this message
  * type, the message is simply dropped and success is also returned.
- * See __smu_cmn_reg2errno() for details of the -errno.
+ * See smu_msg_v1_decode_response() for details of the -errno.
  *
  * If we weren't able to send the message to the SMU, we also print
  * the error to the standard log.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 13a5c1320874..4af587b42dda 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -110,9 +110,6 @@ static inline int pcie_gen_to_speed(uint32_t gen)
 	return ((gen == 0) ? link_speed[0] : link_speed[gen - 1]);
 }
 
-int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-				     uint16_t msg_index,
-				     uint32_t param);
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
-- 
2.49.0

