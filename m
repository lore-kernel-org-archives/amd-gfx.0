Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A69BD65C51
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B66010ECD9;
	Wed, 17 Dec 2025 13:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MFyVBWQf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968E810ECD7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3NNC8R3mMQNm5IBvWr9rqYkapXx+jSGa5g7G32a+7+DgPSuPHQ4nci3c0atEC4IjawVBcpeTXr4IM0qD8ejNBzpV0SfCDdDetIso+ICzkOb9RtTMBLhsIbbF7XzqUSNKrlgkm5G7O8H5tM4UUooNBbpWLo4gN77zzbIoN9uMpM5Dbk0SC8xqMSRNpU2S0Ezsh5VTQh7hhTrtgJYTPFcqrByPWTSiHPfJpqRTVeivPy9wc56OsF+i/zKQGzWgHpqVG6rG7ijnv9uhk6d4F578OXmd56kpmmz/9j/iqeBA4qggE9rqbrxhMGBi/RK0D6CBSviPP0lCEUOg8m3dAGDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsc9NYSRsTl/Sx3Vg/08immI7mAazSq+9T8npxvaKI4=;
 b=Kx7jjz94uZ+lFHEcwp9hYyAkVBxGrbtQdYSfpONrslSNDBs9DTS0XBjFqr/3e7WRkQD+w8f/n40p32vKMPYO8g3CcXAqX35rbnO8Kx2WrEuVWMa4Nqh+TY2rs6d3QK8TG6UIL04cIQX7uJkqBXKQqvAdiFRpDTMEbMA+r4pwoXRQCy7s3cC2gzVKsYEe35WTYzkuO5n4tYdLgktXdnG6TTFsfHbH0L4yz2G+PhCUd4CXE96fFhuebmYZzKGm+pf+1XgY0IbFD/F3f0HhTZUkzfINi7cczRh0oRBpdAZyEWakEqD8cu6Eb6OQxjBsKcLuMfTmH3aM53e32NUwEl7+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsc9NYSRsTl/Sx3Vg/08immI7mAazSq+9T8npxvaKI4=;
 b=MFyVBWQfImvoQr04XKd176vH8PaCH1B2r0LzG0QQk86kEqM9CkQU107bPoAod135c/+uTkYY29AZOgn6oLcuawsu2bkA7wSgGjX1hulqnxFtsf0sUTnGexM3l/xKYfLuvZE73iHHJYVsBIBLNJOT0MColX6+HzaD580hvxHBuAw=
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 13:55:09 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::c0) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 13:55:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:07 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 09/21] drm/amd/pm: Remove unused legacy message functions
Date: Wed, 17 Dec 2025 19:18:02 +0530
Message-ID: <20251217135431.2943441-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1de414-83a4-44fb-26a7-08de3d73e483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ptuO0gqqEfhJ0rQw7y3KIXOX/+udecg1drSJJx8aIpJ3TCsuYJDZiHyh6VGk?=
 =?us-ascii?Q?YEPX3LYMJw0EWtDL+asS1TCOE9tMPdT7HRRpEGEonicVTbRfnce2V2Sr08Fw?=
 =?us-ascii?Q?h25TyLY+Hc//D8a3hKfkJuz5p5PgnTCzQi0BqB0R8as5A3UAbIMjApI6DyQ5?=
 =?us-ascii?Q?8s+TJaBmn3sylCbO5Ibnmke/+UEQ4karnVH1RTHmGtajhKWT/YLJ3iNSG1IQ?=
 =?us-ascii?Q?veBHgTv6DnqCItHBQnp0ulDJBYzKMbwrH/z4Fg/6qJ96B0rBRy6GmrmqT4yK?=
 =?us-ascii?Q?Dh0VbH3b2KbxmBqhzQDwngr0fb3E9NC7Z6vZSRyR0tTLp2At4v9Ha9VEDCgi?=
 =?us-ascii?Q?Aa4F3vptr0UwplPlVD+5xb8a38ggmZxPnCadwYgGprJKg2sxaj1poxj2JPow?=
 =?us-ascii?Q?y/HDG0Gqt1f+d+WTgYvEyGw6ME8MDVupv3BNG8xwHPRzczW06eTl6AGCQZgW?=
 =?us-ascii?Q?svthv8V3eFEY+gkUwMjbMvjHwNNqA3OdHOa5LOA/rxJ6VcKHez//Z7wH/55Y?=
 =?us-ascii?Q?0pFG1ipl4y16UavXIA1t6LtNJheDU8Mhjs/PDSK4rthm7/L3kbjYIZs3sgHe?=
 =?us-ascii?Q?Gbl9JXbmOW7z6gJw19odPaMN6PiE7dm5ZocICYYNKerZZgezqDzcAXzBWrNT?=
 =?us-ascii?Q?hxwW6D7KuAOREHMBHxfEGWktD467/5DOdVI5DW1KQD8ZGTUp8Afxf3x7zKWl?=
 =?us-ascii?Q?u+F2GQCgbj4tjBqCMW89gWPeregTZrmXm6DNB0a58YkigNHLvm/1UWh6A6Nd?=
 =?us-ascii?Q?mlPOMn9CJTjMZ/ejCr+M323od/R+7iUMg5D6goHgeYqnwuzlDFFgeLyvYNoI?=
 =?us-ascii?Q?tGvjCSEIzI4P6fNEZw7YTLFoqq+aqXdi4VonxKpf31zLHYjd8K9OgUc/JPhY?=
 =?us-ascii?Q?oMWSAV8VVqxW0TEA6BxcdpYhEh3zt2k7yqczFvaR087ipIAySLR2tZ5ncGJ2?=
 =?us-ascii?Q?/ih8KTStw9cNElMytSgJ6RbskmXl3QwLJ3N9QN/PiwyF8hpZs9U5nWKpqULh?=
 =?us-ascii?Q?3nmTtTrDxtq5ztHliSy1UNFSi8yBFSzy7hwaWtybVVaZRegOFdAjXGPgPR0i?=
 =?us-ascii?Q?f97EFcvK9DBpvX3F4AZ4hdsiqMhuxB8KBeIn/WDEc1/MPKpQwy12FMxp0MHI?=
 =?us-ascii?Q?tVT+JcQ8HTfSHO6BP6sGFzwOHOotmH0vlM8XcYyONuEZRmawh748gTt+dREt?=
 =?us-ascii?Q?useqjwUZ2oiPpzmTmMIQDjiIAzRbpHtOzbpJspx2d9GuUkxVerarB5mSHCdw?=
 =?us-ascii?Q?LBmK6Hodj9aJ93EwzqkC6gEv9pCWlb4w2v8n6EDHqft5dU+f9FHsBk240ZSr?=
 =?us-ascii?Q?VeMusQn9LoHJ2KsuH4uE+nPq6S+aQcBp6DQJC8z6b+h52E9UqmVO99fzXBuO?=
 =?us-ascii?Q?R7cMpiL0VNlpiKV42+Af8dpyhidiWeppB3MwOI8BWXapRe750hvNIxdZ7keV?=
 =?us-ascii?Q?yWzvVhK7iCPI0WQifNLGpq2HjSHy1dVHnYrLfGF9MlpWWBvN7pi5eCcDx3wJ?=
 =?us-ascii?Q?wRHaOaUlnZa0SuSvHMMMnSV91L7If4AYaMHmEADxVQU7buGbJN+Ph+8Lre6P?=
 =?us-ascii?Q?wlWjM6B7cm58T8fwwcc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:09.6991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1de414-83a4-44fb-26a7-08de3d73e483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
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
index 3561b388de7b..355e5cf6bdb8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -62,14 +62,6 @@ static const char *smu_get_message_name(struct smu_context *smu,
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
@@ -87,215 +79,6 @@ static void smu_cmn_read_arg(struct smu_context *smu,
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
@@ -309,56 +92,6 @@ static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 
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
@@ -368,7 +101,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
  *
  * Return 0 on success, -errno on error, indicating the execution
  * status and result of the message being waited for. See
- * __smu_cmn_reg2errno() for details of the -errno.
+ * smu_msg_v1_decode_response() for details of the -errno.
  */
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
@@ -391,7 +124,7 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
  * message or receiving reply. If there is a PCI bus recovery or
  * the destination is a virtual GPU which does not allow this message
  * type, the message is simply dropped and success is also returned.
- * See __smu_cmn_reg2errno() for details of the -errno.
+ * See smu_msg_v1_decode_response() for details of the -errno.
  *
  * If we weren't able to send the message to the SMU, we also print
  * the error to the standard log.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index fba813e46f7b..d1fef25b8444 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -107,9 +107,6 @@ static inline int pcie_gen_to_speed(uint32_t gen)
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

