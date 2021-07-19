Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E86C07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 23:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A59160FE9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 23:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A59160FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01196E053;
	Mon, 19 Jul 2021 23:18:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8856E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 23:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOis2nHikE5oye+LOI1KY/iRLvdAROTU19vYa52qbjho8foVoJFIbLyN/tFuYS7ZTvbqoCZYF+VpDJLIxaTHN9Frjw7Aq3KWf9wUXEx2OtY5hLSKIfHcJzKIzwM8nFJV/EoSODhFOGnIxrTquXV02l362wSQX+41fRsNQyoCHV29UabYqh4a3x8Hb+xo86sqbGlrt75rUoJvU3tFYgLez/jvJp6JFf9jWHp97Qj0XmqTLhgjG8ozfPG9V2+M/K9eBfklG9iZzyNoIKwyzdZbBff9lwU1ZLPjvWL7cLyrDBmXWFnjdTdEGdyYQVwS1qiarzlocyhUK0vahXQE8TXk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISAdK+KimwEeW/S6dRtS1wESpDKvLCCWRHN5KurnBOg=;
 b=KzcwbDa7PocdGKLKTmpzNjdtRHE4VV74uty08HnWVoDEkx2bbkuF9zc0OsnL1OLKphSL56HzBIq8VO9D4kMsq4HV1btAQnp4LQ+KkVOdoEzfGWyE/VppdfX7CtGISS6pmzujYidTIJeyQ3RJ84+kyGVbZEZeDWLJuOQPTfHvV77Pqa+WOZeShoOwMaw6PDxjRsre3tiWWD7syUDKVZluUrfFvJ6bgUUMrQytFU3iYTjivKBbX+Fm7/DM/7uv5PeCCAdeUewxLOPjG5Fa83k7/PdjhRR+Jf75QOjVBaf852sATlpwzlN0ddPJ4aL+3KuBAWQ2yKQDVnpOltHE06eg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISAdK+KimwEeW/S6dRtS1wESpDKvLCCWRHN5KurnBOg=;
 b=uUYMA5hzJVvX5ejqPBqTNHwO+a/m3p/Tq/SJgSDdU5dH7dsMLJ+jW+wsxYfW0NMPt1pYbEaPMZNBH/bw1KIZfDbZO25gRMWWw5ONx1SZxZPC0XvmQPKmB6Be3cxhCSxEKuff8muOHEcYpmYcHm1nFzeJ2rYEedtw+VaQ9aDYbyI=
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 23:18:26 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::9e) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Mon, 19 Jul 2021 23:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 23:18:26 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 19 Jul 2021 18:18:25 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU (v5)
Date: Mon, 19 Jul 2021 19:18:13 -0400
Message-ID: <20210719231813.16524-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2adc4f65-397a-47d7-38e6-08d94b0b82d1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3827:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38279DA3033C12BA3ED9DFA499E19@BY5PR12MB3827.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTuw1TE1TYWq0c9XlZp4IJmsK7HSes2IrBebDLQtPfCW/6QqKdGBvsjFZ59JtWppolmWmoVI3auL4nkjxI+0G0OlVnc3cWPVZ+XI24owM63B2QS02I+0OD+ZjIQLoDEUyKyD18+3cWlUYgu5m8OIy4jZ8SDKQDE+MdN38Kimut/jaNHGExSNTVMBRPDSXBCalRZRlkfdIclAkA6jJGs8YX3dTNjgAYS3lf9R9k7r/D0oy5iXFIHLrSEgfnVuP6RelFM2AnhmndHebrPYbC+4WPNg4ZAM7pCPBbj0MHwy047MyEc48jNZM9qiVgQ4qsbA7ubJCuKz4kbawEWoP0mpcnf/HQ2UWiuV/H3bbY5LI6ETBH1PoNzSyCg37puKlZy+9pPPCFHeQWMGDsj3QboYJbj8/QaPlq8O0AbLVdghgpBSlJMJIq4Eyuh5GJYIMGU6CNNr2+ODT/zTbSjyvxn6LKsa6S+zpea5+B2bpIej6SYmaLmM8gxxpTAHrH51LldFwgn9MubulmVixwrKU8/5iRE1F/04se3k8nYBBvR0BBd0ZxKbbM+WvoidY+ev1S2HHE+J3x3Z+dhY6QupuNPq7N5s0TijYlfG9qjAlPyoGreg4XuY5GdtB/JUZysvaNBD5SyF5zYzc0jLjpSp/b/ovxnYdbdUxeBlBoDIhEtd7UXzOFFgnnXgQ846PX5DKRsJNLGklFJLL5C/JyewV2VSaMPo6g1jIgiEC4ZCqIBYoCU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(82740400003)(30864003)(6916009)(82310400003)(5660300002)(70206006)(336012)(36756003)(54906003)(478600001)(356005)(36860700001)(81166007)(4326008)(7696005)(2616005)(70586007)(47076005)(1076003)(83380400001)(86362001)(316002)(2906002)(186003)(8936002)(6666004)(426003)(44832011)(26005)(16526019)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 23:18:26.0579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adc4f65-397a-47d7-38e6-08d94b0b82d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3827
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>,
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

v2: Add a comment to the description of
__smu_cmn_poll_stat() to explain why we're NOT
defining the SMU FW return codes as macros, but
are instead hard-coding them. Such a change, can
be followed up by a subsequent patch.

v3: The changes are,
a) Add comments to break labels in
   __smu_cmn_reg2errno().

b) When an unknown/unspecified/undefined result is
   returned back from the SMU, map that to
   -EREMOTEIO, to distinguish failure at the SMU
   FW.

c) Add kernel-doc to
   smu_cmn_send_msg_without_waiting(),
   smu_cmn_wait_for_response(),
   smu_cmn_send_smc_msg_with_param().

d) In smu_cmn_send_smc_msg_with_param(), since we
   wait for completion of the command, if the
   result of the completion is
   undefined/unknown/unspecified, we print that to
   the kernel log.

v4: a) Add macros as requested, though redundant, to
    be removed when SMU consolidates for all
    ASICs--see comment in code.
    b) Get out if the SMU code is unknown.

v5: Rename the macro names.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Evan Quan <evan.quan@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 288 +++++++++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
 2 files changed, 244 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index c902fdf322c1be..baf26d5bfb8ff4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -55,7 +55,7 @@
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	#type
-static const char* __smu_message_names[] = {
+static const char * const __smu_message_names[] = {
 	SMU_MESSAGE_TYPES
 };
 
@@ -76,55 +76,258 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }
 
-int smu_cmn_wait_for_response(struct smu_context *smu)
+/* Redefine the SMU error codes here.
+ *
+ * Note that these definitions are redundant and should be removed
+ * when the SMU has exported a unified header file containing these
+ * macros, which header file we can just include and use the SMU's
+ * macros. At the moment, these error codes are defined by the SMU
+ * per-ASIC unfortunately, yet we're a one driver for all ASICs.
+ */
+#define SMU_RESP_NONE           0
+#define SMU_RESP_OK             1
+#define SMU_RESP_CMD_FAIL       0xFF
+#define SMU_RESP_CMD_UNKNOWN    0xFE
+#define SMU_RESP_CMD_BAD_PREREQ 0xFD
+#define SMU_RESP_BUSY_OTHER     0xFC
+#define SMU_RESP_DEBUG_END      0xFB
+
+/**
+ * __smu_cmn_poll_stat -- poll for a status from the SMU
+ * smu: a pointer to SMU context
+ *
+ * Returns the status of the SMU, which could be,
+ *    0, the SMU is busy with your previous command;
+ *    1, execution status: success, execution result: success;
+ * 0xFF, execution status: success, execution result: failure;
+ * 0xFE, unknown command;
+ * 0xFD, valid command, but bad (command) prerequisites;
+ * 0xFC, the command was rejected as the SMU is busy;
+ * 0xFB, "SMC_Result_DebugDataDumpEnd".
+ *
+ * The values here are not defined by macros, because I'd rather we
+ * include a single header file which defines them, which is
+ * maintained by the SMU FW team, so that we're impervious to firmware
+ * changes. At the moment those values are defined in various header
+ * files, one for each ASIC, yet here we're a single ASIC-agnostic
+ * interface. Such a change can be followed-up by a subsequent patch.
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
+	case SMU_RESP_NONE:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: I'm not done with your previous command!");
+		break;
+	case SMU_RESP_OK:
+		/* The SMU executed the command. It completed with a
+		 * successful result.
+		 */
+		break;
+	case SMU_RESP_CMD_FAIL:
+		/* The SMU executed the command. It completed with an
+		 * unsuccessful result.
+		 */
+		break;
+	case SMU_RESP_CMD_UNKNOWN:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: unknown command: index:%d param:0x%08X message:%s",
+				    msg_index, param, message);
+		break;
+	case SMU_RESP_CMD_BAD_PREREQ:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
+				    msg_index, param, message);
+		break;
+	case SMU_RESP_BUSY_OTHER:
+		dev_err_ratelimited(adev->dev,
+				    "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
+				    msg_index, param, message);
+		break;
+	case SMU_RESP_DEBUG_END:
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
+	case SMU_RESP_NONE:
+		/* The SMU is busy--still executing your command.
+		 */
+		res = -ETIME;
+		break;
+	case SMU_RESP_OK:
+		res = 0;
+		break;
+	case SMU_RESP_CMD_FAIL:
+		/* Command completed successfully, but the command
+		 * status was failure.
+		 */
+		res = -EIO;
+		break;
+	case SMU_RESP_CMD_UNKNOWN:
+		/* Unknown command--ignored by the SMU.
+		 */
+		res = -EOPNOTSUPP;
+		break;
+	case SMU_RESP_CMD_BAD_PREREQ:
+		/* Valid command--bad prerequisites.
+		 */
+		res = -EINVAL;
+		break;
+	case SMU_RESP_BUSY_OTHER:
+		/* The SMU is busy with other commands. The client
+		 * should retry in 10 us.
+		 */
+		res = -EBUSY;
+		break;
+	default:
+		/* Unknown or debug response from the SMU.
+		 */
+		res = -EREMOTEIO;
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
+/**
+ * smu_cmn_send_msg_without_waiting -- send the message; don't wait for status
+ * @smu: pointer to an SMU context
+ * @msg_index: message index
+ * @param: message parameter to send to the SMU
+ *
+ * Send a message to the SMU with the parameter passed. Do not wait
+ * for status/result of the message, thus the "without_waiting".
+ *
+ * Return 0 on success, -errno on error if we weren't able to _send_
+ * the message for some reason. See __smu_cmn_reg2errno() for details
+ * of the -errno.
+ */
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
+	res = __smu_cmn_reg2errno(smu, reg);
+	if (reg == SMU_RESP_NONE ||
+	    reg == SMU_RESP_BUSY_OTHER ||
+	    res == -EREMOTEIO)
+		goto Out;
+	__smu_cmn_send_msg(smu, msg_index, param);
+	res = 0;
+Out:
+	mutex_unlock(&smu->message_lock);
+	return res;
 }
 
+/**
+ * smu_cmn_wait_for_response -- wait for response from the SMU
+ * @smu: pointer to an SMU context
+ *
+ * Wait for status from the SMU.
+ *
+ * Return 0 on success, -errno on error, indicating the execution
+ * status and result of the message being waited for. See
+ * __smu_cmn_reg2errno() for details of the -errno.
+ */
+int smu_cmn_wait_for_response(struct smu_context *smu)
+{
+	u32 reg;
+
+	reg = __smu_cmn_poll_stat(smu);
+	return __smu_cmn_reg2errno(smu, reg);
+}
+
+/**
+ * smu_cmn_send_smc_msg_with_param -- send a message with parameter
+ * @smu: pointer to an SMU context
+ * @msg: message to send
+ * @param: parameter to send to the SMU
+ * @read_arg: pointer to u32 to return a value from the SMU back
+ *            to the caller
+ *
+ * Send the message @msg with parameter @param to the SMU, wait for
+ * completion of the command, and return back a value from the SMU in
+ * @read_arg pointer.
+ *
+ * Return 0 on success, -errno on error, if we weren't able to send
+ * the message or if the message completed with some kind of
+ * error. See __smu_cmn_reg2errno() for details of the -errno.
+ *
+ * If we weren't able to send the message to the SMU, we also print
+ * the error to the standard log.
+ *
+ * Command completion status is printed only if the -errno is
+ * -EREMOTEIO, indicating that the SMU returned back an
+ * undefined/unknown/unspecified result. All other cases are
+ * well-defined, not printed, but instead given back to the client to
+ * decide what further to do.
+ *
+ * The return value, @read_arg is read back regardless, to give back
+ * more information to the client, which on error would most likely be
+ * @param, but we can't assume that. This also eliminates more
+ * conditionals.
+ */
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, index = 0;
+	int res, index;
+	u32 reg;
 
 	if (smu->adev->in_pci_err_recovery)
 		return 0;
@@ -136,31 +339,24 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
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
+	res = __smu_cmn_reg2errno(smu, reg);
+	if (reg == SMU_RESP_NONE ||
+	    reg == SMU_RESP_BUSY_OTHER ||
+	    res == -EREMOTEIO) {
+		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
+		goto Out;
 	}
-
+	__smu_cmn_send_msg(smu, (uint16_t) index, param);
+	reg = __smu_cmn_poll_stat(smu);
+	res = __smu_cmn_reg2errno(smu, reg);
+	if (res == -EREMOTEIO)
+		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
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
