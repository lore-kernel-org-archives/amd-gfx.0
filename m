Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A966C47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D74E10E4D3;
	Tue,  6 Jan 2026 10:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NErcItNb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013001.outbound.protection.outlook.com
 [40.107.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB5010E4D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8ijQuMWZkj1m4tz+ESE7Osb8i/3gxxk5HMR44sXltM334mdauGNTu8X+QIIe6ongQFs7aABy6dGCt+nCzmmsXvAvfcQv4PrSnqeyrdTCdYK707eMRb2MqxrIyz3OFtUpMLp3ZB43Rp5CeTTcq83LdJYftcc/px9C0h1qEz/v3hj3SQN1n6XlPnQTe2vBLxHUGFbh54Y30bpyBOmsmQlpZaWOEjurl7d0sgwjcTK+uS6YIWJJj59c5PxPQc/MlBwLOR01yFb2GVGpnOR9ToIM7BQsnil6Qnv/1x3TAlmuYgjA2jNF8lseT40QRgJ+SFbnT8fBaXRiyGq2HtNRLR6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrvnPXGbzeH7236epVt8RsfUaNfCgEub5E3tCTjUxoI=;
 b=rdexO/A2WHo6KNCjrtBt/IozOX6hvkXrY+84SB/XTeuzQIRtRTQS1fl+8jX26gbbdqaZChGnFr/MAAqSj+MgXaOPAnPONAt6XeT2B6vAtqw57P18CMP26OqQd7IjWSRZTbQv+3Vdy0DjSmWk9vwA5719ZudCFs5aZBJOjzFaYYdtPP46UFhMB9bzdTVWYdwW/gHbEwH8Iv4VaimUgBetMGEQH/PVauaFk08xzLHtTJf4O+TEtflHO4Xdqm+S0O7c12Qe29WXz7a3pFDefmtR038v9XbQhbPjQ2COlLRbWzEE83fZYfEwYVeuKs5wMic8wMZUcA5id9jXhd4Gtqd4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrvnPXGbzeH7236epVt8RsfUaNfCgEub5E3tCTjUxoI=;
 b=NErcItNb5aQUiATKzM/wfwM2KbyJaOQHhQ7Is2rZrtgatjQJPv03egU15WQ8go1ENgKMC6GhZJA4ILPNwRrap7DjTLOqTgyOb08Hg0wNdjCJIWkZTwGa8I8jCkRC6xrUjeLcJXHfwf9wBzQNpYEGdu55JfFGDOOrE87eXwDF2nI=
Received: from SA9PR13CA0091.namprd13.prod.outlook.com (2603:10b6:806:24::6)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:55 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::c4) by SA9PR13CA0091.outlook.office365.com
 (2603:10b6:806:24::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 10:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:53 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 09/21] drm/amd/pm: Remove unused legacy message functions
Date: Tue, 6 Jan 2026 15:42:29 +0530
Message-ID: <20260106101317.3856153-10-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: dafc3bb2-6e0f-42f7-b111-08de4d0c4cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vYZRtk861JKlFzPn6/u21UQdAZnSNC7JzvW/RzONjyLJecCSiSqxQCvj3WCS?=
 =?us-ascii?Q?SyUKrQDFe9HomyDh0oQrUJIr535l98foQzXXq4UhMalq89GRVc7qRjokQ+g/?=
 =?us-ascii?Q?dX7qdQgIXED1WReFh66wcxGn92ndzS6V/aL9ETg+7VLyS1/hiAPzed5Er/F0?=
 =?us-ascii?Q?CjyPy62iDFRD5gC4y8ISpA7VcHcaFsuOreZdt8VUblUGLr2hVfDRWUtsdcUj?=
 =?us-ascii?Q?pHTQms1ggGaD3O75oiSLr7pfNVJLUDS9TACyn107LDVqD8Wj/H3ghRy2Dq1h?=
 =?us-ascii?Q?zNny/tl7aUPClxnwhhOq/a3+kBrvY7XmGFKhwCUZVNkxKheg+ImYGHEpzrEz?=
 =?us-ascii?Q?tBbXw87NcOMW4qw6y0pYPr1mxtgkdaAuMWQIHJfROUMqWDXih2uFIBfc4ygz?=
 =?us-ascii?Q?vLv8YnbMlVbxs1Dw3hMfTU9773rlGP7vwncaIlHOZQiA9Ge6YLolTuVDdmWU?=
 =?us-ascii?Q?kfHeHhE35aV08KzauiQQXprt68rfK/cWi9DQ5/YJks7JV45i+nfe4bIyYKHP?=
 =?us-ascii?Q?4xPrVGK0M0Nujc0UjU/3ong5QLJ97dWWYdjcrCy47tksWhZVp+wL9FGX90oo?=
 =?us-ascii?Q?MU7L9wwpg4zRTN8q3aurzb3epTFOLcAE3zw5lJZ9b3DXkb2gnOWv4DgVw+3p?=
 =?us-ascii?Q?lFIgj8Gaa+MDWlLARiJ8jfyoZMfBc8swncSXf93T/Wvw+vlvehe42uPkBPpe?=
 =?us-ascii?Q?4NMRSaHh7xYzdOfJPIGRhCnsk7SC6i7Dg6jhgoxFaVdPTZ1q+3kRrHILOIzo?=
 =?us-ascii?Q?Sz6A2xoWewcUhPVNNSi+jwWLfDCggLGsqibFpuGTa8iK75e3eBJjAu6LeS1t?=
 =?us-ascii?Q?5P2yuaPhlsHk/I+vNPvmWrvSHwP71C+wmVFGEgE7/wt4FqtyHTzBHOt04vgs?=
 =?us-ascii?Q?kFt5L8xdkl3yyXadnA/ol1cpQ9EAcAtbrSN0NMIMK4hXKoej1+1E12ogn6Wi?=
 =?us-ascii?Q?/y2ov9b0SqG1zOuahSEBAW4NW8Y9QrXPdRY8J9Z60y7tN5fw3lC4sdB+14uH?=
 =?us-ascii?Q?wR5pBMGbjkbhEJBlt4PFzB9aiyzGdJ33dYiMlIClbScxSl/iQ8dneIQ+xJwC?=
 =?us-ascii?Q?3Y9u/7UMzHlthhp0/cioppg5nkfwVV24HpwsQuVXZP+RZHw3FJmgzEQFehUl?=
 =?us-ascii?Q?dgnbs4k3/vWp3vk89lujL62BruIMVhCcZxyXyCzpRXbNKFJzetn19zGMZhmg?=
 =?us-ascii?Q?+V2ixQ654QPS500QooaAizyVTMxB+6dVBtZdWqDBmlavSnrsjm0V2fa3TE85?=
 =?us-ascii?Q?4iWy8nimn5IOe+uCu7r326jZorvmFrN/jNHqMTFM4NhQJ2k9NhEf0Fcdotgu?=
 =?us-ascii?Q?lj+lygfDCEsFMz8LMaI7XP5qjlofc9RxC6QheCiyUKq4SXV1KAUWJbsL3ZjJ?=
 =?us-ascii?Q?K/UF8Y6tMn7SotQvXwuqnMW6N74fv3pyXr2w/x2h3Fz7uCgIbzGrozIn9puS?=
 =?us-ascii?Q?BD6Z7Q3DC2AuksiWsWBP3u5rK/HuvJVVzfyemZxDodBsAHsXWxUhHPD56z95?=
 =?us-ascii?Q?NzWQnM5wG7ghk75AnwvUSrLlEHvMXT13N68nFZV1M5J5i7nYE2l/B/XddLhs?=
 =?us-ascii?Q?/Urd/NTO2AHr0k9RuVY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:55.6424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dafc3bb2-6e0f-42f7-b111-08de4d0c4cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 271 +------------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 -
 2 files changed, 2 insertions(+), 272 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 03cd724a0bf8..177643df1aab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -65,14 +65,6 @@ static const char *smu_get_message_name(struct smu_context *smu,
 	return __smu_message_names[type];
 }
 
-static void smu_cmn_read_arg(struct smu_context *smu,
-			     uint32_t *arg)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	*arg = RREG32(smu->param_reg);
-}
-
 /* Redefine the SMU error codes here.
  *
  * Note that these definitions are redundant and should be removed
@@ -90,215 +82,6 @@ static void smu_cmn_read_arg(struct smu_context *smu,
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
-static void __smu_cmn_reg_print_error(struct smu_context *smu,
-				      u32 reg_c2pmsg_90,
-				      int msg_index,
-				      u32 param,
-				      enum smu_message_type msg)
-{
-	struct amdgpu_device *adev = smu->adev;
-	const char *message = smu_get_message_name(smu, msg);
-	u32 msg_idx, prm;
-
-	switch (reg_c2pmsg_90) {
-	case SMU_RESP_NONE: {
-		msg_idx = RREG32(smu->msg_reg);
-		prm     = RREG32(smu->param_reg);
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
-				    msg_idx, prm);
-		}
-		break;
-	case SMU_RESP_OK:
-		/* The SMU executed the command. It completed with a
-		 * successful result.
-		 */
-		break;
-	case SMU_RESP_CMD_FAIL:
-		/* The SMU executed the command. It completed with an
-		 * unsuccessful result.
-		 */
-		break;
-	case SMU_RESP_CMD_UNKNOWN:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: unknown command: index:%d param:0x%08X message:%s",
-				    msg_index, param, message);
-		break;
-	case SMU_RESP_CMD_BAD_PREREQ:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
-				    msg_index, param, message);
-		break;
-	case SMU_RESP_BUSY_OTHER:
-		/* It is normal for SMU_MSG_GetBadPageCount to return busy
-		 * so don't print error at this case.
-		 */
-		if (msg != SMU_MSG_GetBadPageCount)
-			dev_err_ratelimited(adev->dev,
-						"SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
-						msg_index, param, message);
-		break;
-	case SMU_RESP_DEBUG_END:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm debugging!");
-		break;
-	case SMU_RESP_UNEXP:
-		if (amdgpu_device_bus_status_check(smu->adev)) {
-			/* print error immediately if device is off the bus */
-			dev_err(adev->dev,
-				"SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
-				reg_c2pmsg_90, msg_index, param, message);
-			break;
-		}
-		fallthrough;
-	default:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
-				    reg_c2pmsg_90, msg_index, param, message);
-		break;
-	}
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
-
-static inline uint32_t __smu_cmn_get_msg_flags(struct smu_context *smu,
-					       enum smu_message_type msg)
-{
-	return smu->message_map[msg].flags;
-}
-
-static int __smu_cmn_ras_filter_msg(struct smu_context *smu,
-				    enum smu_message_type msg, bool *poll)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t flags, resp;
-	bool fed_status, pri;
-
-	flags = __smu_cmn_get_msg_flags(smu, msg);
-	*poll = true;
-
-	pri = !!(flags & SMU_MSG_NO_PRECHECK);
-	/* When there is RAS fatal error, FW won't process non-RAS priority
-	 * messages. Don't allow any messages other than RAS priority messages.
-	 */
-	fed_status = amdgpu_ras_get_fed_status(adev);
-	if (fed_status) {
-		if (!(flags & SMU_MSG_RAS_PRI)) {
-			dev_dbg(adev->dev,
-				"RAS error detected, skip sending %s",
-				smu_get_message_name(smu, msg));
-			return -EACCES;
-		}
-	}
-
-	if (pri || fed_status) {
-		/* FW will ignore non-priority messages when a RAS fatal error
-		 * or reset condition is detected. Hence it is possible that a
-		 * previous message wouldn't have got response. Allow to
-		 * continue without polling for response status for priority
-		 * messages.
-		 */
-		resp = RREG32(smu->resp_reg);
-		dev_dbg(adev->dev,
-			"Sending priority message %s response status: %x",
-			smu_get_message_name(smu, msg), resp);
-		if (resp == 0)
-			*poll = false;
-	}
-
-	return 0;
-}
 
 static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 			       u32 msg,
@@ -312,56 +95,6 @@ static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 
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
@@ -371,7 +104,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
  *
  * Return 0 on success, -errno on error, indicating the execution
  * status and result of the message being waited for. See
- * __smu_cmn_reg2errno() for details of the -errno.
+ * smu_msg_v1_decode_response() for details of the -errno.
  */
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
@@ -394,7 +127,7 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
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

