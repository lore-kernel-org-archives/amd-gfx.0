Return-Path: <SRS0=L2kD=ME=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDC2C07E99
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 15:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E468B60FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 15:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E468B60FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996A389C16;
	Mon, 12 Jul 2021 15:31:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141F389C16
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jul 2021 15:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYGKN9b+SihFer73/psq6jEuI6cv0OPa+5eGb0DEK+VRbzZzT7s6wWbwShMSfIRG8Yhxt/W4qoqMBK9rJE+qUc13ob61iNjBt+IIfMVJKVuvek2x8erNaUfyVdVgqm6K6x+auzZmS8bSEtdLBXgEzr6TCg2mduRJsxYAqAixprm6het1BeJsYNItLTfzIXWCVex0PD7LOBJYzW5UI6u55lTPjHElu149gcFwSHCIeKhp/CNxtTxBA9rbG3eq1mOGCMT/UatJEVTgg3H18QLbGbSN5vUIZYwcWmq+ftIxWY3TA2MjRFTMjfYniVldDHA6vSWQcSdxd5hEW8O0XIUCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn41ZhtZwo3A4BEaPtDjJljTojvLGFE2nG0GAjx57Uw=;
 b=GVj6ITRnpaitrT8BRboXSrAZwLeHMzytCqFFHB5nTwytY936Hn00dGwVsHRRvt4MSQouOXuCvwduNDd+0UW2LmLfvWMHLgTuRowGhFyobQPJZsmEZLUI6NpZgXlg5q3RgkqVOzcEEaQhSEsMYtq7oO/mlUBQa0H42QBMy6VIk1QJeMWU4pmJVINVslc0XNP3YjmfW1+DA7WwUKOqOHYuqCh1LUz1waGlMhIQB9pjJ9oo7bF+rU0bBdTF6zkJUPs2nKgZZlcoxnUTkJY8vSi3PnOXDWEzqJRbRLzIAWCJFRAejH7P1/JmZ+MPrL6x5MZxW8b18sgGMVfYD5ScPxuh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn41ZhtZwo3A4BEaPtDjJljTojvLGFE2nG0GAjx57Uw=;
 b=l20CIGIRTpMvhMznucL36a0GpjpnRy/njq4hckG4Gp6IAZ9BzgbYSIAoN0yRjdUFExupdowqeo/uknghfZRIswMxFQMX/IhbXrB6sBRT4Oog2IHXf04/LePLc7vX5vinLa9owUL3ZSvxPLeNho0+JMngHXN+XII1jCli+IZ0v+U=
Received: from BN9PR03CA0615.namprd03.prod.outlook.com (2603:10b6:408:106::20)
 by BN6PR1201MB0259.namprd12.prod.outlook.com (2603:10b6:405:58::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 15:31:08 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::79) by BN9PR03CA0615.outlook.office365.com
 (2603:10b6:408:106::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Mon, 12 Jul 2021 15:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 15:31:08 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 12 Jul
 2021 10:31:07 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
Date: Mon, 12 Jul 2021 11:30:51 -0400
Message-ID: <20210712153051.4029-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f982553-501e-42cc-ff9d-08d9454a124c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0259:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0259375AB4099C053ECAEF9D99159@BN6PR1201MB0259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYqYA/3j+4bB5Q3OEJi1Dz5BEb1g93bZ/97pTFuzi/LuIHIlQWQASWERFWihMXq+cgQp9zqgQmdNUI+JLQJYng3CBbh+ALYQ/EWvtogkmdCir38Vfz4cSMiMkTp8afel04JbMj3oy14jsUckfYe9UMduSvc4HojqHMnklyGeYs7qSwp9AeWw38QOozGc5Fc2R6919WClO/e7MS8bcR+h3q0I7b41HXqNlYSBrUHVhpV6865DvIZ2G+UQWr6OLzyoxDy5e6VDr+0vbTik8C4asHV7t6lRubESkxAJSdBILAdf09sMV3bwKOCpWHynR0Hj5SfpOxekdBLDNKd+ecjLU0aXJZw5MUXP63vKoLxHdDBCOtQOVkXSngZJOK9910buIA4Bcvbk4tYMwzPMjt0GImNOjW9BH1TrsRGB/Mw7lXmsvXEKX3GrWbGDIB4AaJoR82KweBB4d/7Uwx0yQVwczGkzzCLsR7ED6oyjrvCfo/6pdxcvvJPpq6bh3rV8+FvKWy3KtMhQ/x4YVblYxYbN77Bw63hX/+EAWzKuW9mUQ13hQS+YxZxi24paRX5VZPo6zowEpWi1Pg8ZwRDfRqvXTyMnRwHnxdcm0zmnPO+F53YG4T2LxS03BWdzmh8miHRUTuQ2KckQKZBLqCug12WFqD02safNrFaAGsqBTQPRBCTPdaiYGXvf+tvS08Y5nSx7ecwclXkAC1M26opgKeAcjNOzshtDIpah+Iko84V41IQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(86362001)(316002)(8676002)(426003)(70206006)(82310400003)(356005)(2906002)(336012)(6916009)(70586007)(47076005)(4326008)(7696005)(478600001)(83380400001)(54906003)(1076003)(2616005)(81166007)(44832011)(36756003)(26005)(8936002)(6666004)(5660300002)(16526019)(36860700001)(82740400003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 15:31:08.6018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f982553-501e-42cc-ff9d-08d9454a124c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0259
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes a bug which if we probe a non-existing
I2C device, and the SMU returns 0xFF, from then on
we can never communicate with the SMU, because the
code before this patch reads and interprets 0xFF
as a terminal error, and thus we never write 0
into register 90 to clear the status (and
subsequently send a new command to the SMU.)

It is not an error that the SMU returns status
0xFF. This means that the SMU executed the last
command successfully (execution status), but the
command result is an error of some sort (execution
result), depending on what the command was.

When doing a status check of the SMU, before we
send a new command, the only status which
precludes us from sending a new command is 0--the
SMU hasn't finished executing a previous command,
and 0xFC--the SMU is busy.

This bug was seen as the following line in the
kernel log,

amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!

when subsequent SMU commands, not necessarily
related to I2C, were sent to the SMU.

This patch fixes this bug.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Evan Quan <evan.quan@amd.com>
Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196 +++++++++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
 2 files changed, 152 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c902fdf322c1be..775eb50a2e49a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -55,7 +55,7 @@
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	#type
-static const char* __smu_message_names[] = {
+static const char * const __smu_message_names[] = {
 	SMU_MESSAGE_TYPES
 };
 
@@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }
 
-int smu_cmn_wait_for_response(struct smu_context *smu)
+/**
+ * __smu_cmn_poll_stat -- poll for a status from the SMU
+ * smu: a pointer to SMU context
+ *
+ * Returns the status of the SMU, which could be,
+ * 0, the SMU is busy with your previous command;
+ * 1,    execution status: success, execution result: success;
+ * 0xFF, execution status: success, execution result: failure;
+ * 0xFE, unknown command;
+ * 0xFD, valid command, but bad (command) prerequisites;
+ * 0xFC, the command was rejected as the SMU is busy;
+ * 0xFB, "SMC_Result_DebugDataDumpEnd".
+ */
+static u32 __smu_cmn_poll_stat(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
+	int timeout = adev->usec_timeout * 20;
+	u32 reg;
 
-	for (i = 0; i < timeout; i++) {
-		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
-		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
-			return cur_value;
+	for ( ; timeout > 0; timeout--) {
+		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
+			break;
 
 		udelay(1);
 	}
 
-	/* timeout means wrong logic */
-	if (i == timeout)
-		return -ETIME;
-
-	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	return reg;
 }
 
-int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-				     uint16_t msg, uint32_t param)
+static void __smu_cmn_reg_print_error(struct smu_context *smu,
+				      u32 reg_c2pmsg_90,
+				      int msg_index,
+				      u32 param,
+				      enum smu_message_type msg)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int ret;
+	const char *message = smu_get_message_name(smu, msg);
 
-	ret = smu_cmn_wait_for_response(smu);
-	if (ret != 0x1) {
-		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and "
-		       "SMU may be not in the right state!\n", ret);
-		if (ret != -ETIME)
-			ret = -EIO;
-		return ret;
+	switch (reg_c2pmsg_90) {
+	case 0:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: I'm not done with your previous command!");
+		break;
+	case 1:
+		/* The SMU executed the command. It completed with a
+		 * successful result.
+		 */
+		break;
+	case 0xFF:
+		/* The SMU executed the command. It completed with a
+		 * unsuccessful result.
+		 */
+		break;
+	case 0xFE:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: unknown command: index:%d param:0x%08X message:%s",
+				    msg_index, param, message);
+		break;
+	case 0xFD:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
+				    msg_index, param, message);
+		break;
+	case 0xFC:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
+				    msg_index, param, message);
+		break;
+	case 0xFB:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: I'm debugging!");
+		break;
+	default:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
+				    reg_c2pmsg_90, msg_index, param, message);
+		break;
+	}
+}
+
+static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
+{
+	int res;
+
+	switch (reg_c2pmsg_90) {
+	case 0:
+		res = -ETIME;
+		break;
+	case 1:
+		res = 0;
+		break;
+	case 0xFF:
+		res = -EIO;
+		break;
+	case 0xFE:
+		res = -EOPNOTSUPP;
+		break;
+	case 0xFD:
+		res = -EIO;
+		break;
+	case 0xFC:
+		res = -EBUSY;
+		break;
+	case 0xFB:
+		res = -EIO;
+		break;
+	default:
+		res = -EIO;
+		break;
 	}
 
+	return res;
+}
+
+static void __smu_cmn_send_msg(struct smu_context *smu,
+			       u16 msg,
+			       u32 param)
+{
+	struct amdgpu_device *adev = smu->adev;
+
 	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
 	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
 	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+}
 
-	return 0;
+int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
+				     uint16_t msg_index,
+				     uint32_t param)
+{
+	u32 reg;
+	int res;
+
+	if (smu->adev->in_pci_err_recovery)
+		return 0;
+
+	mutex_lock(&smu->message_lock);
+	reg = __smu_cmn_poll_stat(smu);
+	if (reg == 0 || reg == 0xFC) {
+		res = __smu_cmn_reg2errno(smu, reg);
+		goto Out;
+	}
+	__smu_cmn_send_msg(smu, msg_index, param);
+	res = 0;
+Out:
+	mutex_unlock(&smu->message_lock);
+	return res;
+}
+
+int smu_cmn_wait_for_response(struct smu_context *smu)
+{
+	u32 reg;
+
+	reg = __smu_cmn_poll_stat(smu);
+	return __smu_cmn_reg2errno(smu, reg);
 }
 
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
@@ -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, index = 0;
+	int res, index;
+	u32 reg;
 
 	if (smu->adev->in_pci_err_recovery)
 		return 0;
@@ -136,31 +251,20 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 		return index == -EACCES ? 0 : index;
 
 	mutex_lock(&smu->message_lock);
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
-	if (ret)
-		goto out;
-
-	ret = smu_cmn_wait_for_response(smu);
-	if (ret != 0x1) {
-		if (ret == -ETIME) {
-			dev_err(adev->dev, "message: %15s (%d) \tparam: 0x%08x is timeout (no response)\n",
-				smu_get_message_name(smu, msg), index, param);
-		} else {
-			dev_err(adev->dev, "failed send message: %15s (%d) \tparam: 0x%08x response %#x\n",
-				smu_get_message_name(smu, msg), index, param,
-				ret);
-			ret = -EIO;
-		}
-		goto out;
+	reg = __smu_cmn_poll_stat(smu);
+	if (reg == 0 || reg == 0xFC) {
+		res = __smu_cmn_reg2errno(smu, reg);
+		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
+		goto Out;
 	}
-
+	__smu_cmn_send_msg(smu, (uint16_t) index, param);
+	reg = __smu_cmn_poll_stat(smu);
+	res = __smu_cmn_reg2errno(smu, reg);
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
-
-	ret = 0; /* 0 as driver return value */
-out:
+Out:
 	mutex_unlock(&smu->message_lock);
-	return ret;
+	return res;
 }
 
 int smu_cmn_send_smc_msg(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 9add5f16ff562a..16993daa2ae042 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -27,7 +27,8 @@
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-				     uint16_t msg, uint32_t param);
+				     uint16_t msg_index,
+				     uint32_t param);
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
