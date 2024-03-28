Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E5C47DD9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 02:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B781122BC;
	Thu, 28 Mar 2024 02:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LsA9r5KW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9983E1122BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 02:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9NhvQr8r1AiAELivnNPKa/Ctk5j9cnDlPFTyfWJM/kxSUTmq8aIsHqeK0cne8DUss1f29kYIF3NOhHq9EK3dI8XYOiCFhnBG2fXUD8jIwD9AFZUTHzmzTV+etAoM5+007X6FBKXF4hGhnww6rSbYW5le+QULwWxIFfFQ1Lfk3erUJFY0NxxdmWNZzBR2XgKnIqXGfP9LG6obgIOTdbo7qMk67Rbilc9dIQ+NynBEgt61JYMpVPsdvxTsaGLsC/W9BqJNq4LdQhk5yQhRNZ3cz9R+aPrnN3HqveMeWQmi/RGg88hfYFlHnRnf/qflsq4Hq6K5PCvymIl890KGwI4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyoHCq23cfFBA8qrOpzBpmMLVCBIzwXUYgiSf+gpNSs=;
 b=kbQyF5Ozs8kciEaiaydg0szJW157EU3ApsaDigwIZZE3dvV8O3F5EQJqkf4F65Wu0vWig8yDDOpejQiJpPa4jCdbIXDn5BWvX9bYF6vqx03yFZlyT4dtptADN9Slt8qlzThBWzvy34ISiq9XtnT2e6WmGvih7Uc3Yaf2vbeJQpo2FtfpRtb0rhj0fKrO5ytPR0SpSbnkzqrHz+0FWwGHLH5+2INGFmU3p3w+SFV8yqCa9gjbkDAoLBg3gyi/lhL1WjJjolj/InIGVJ606cHbW5x2GFizHxeUyy1S6Hpnam5anFYhoK9uHUJUd6YdYNiqFaJTlupUC+sYDMlAEFb0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyoHCq23cfFBA8qrOpzBpmMLVCBIzwXUYgiSf+gpNSs=;
 b=LsA9r5KWdBSUHNXg2t7WOtBMudU54H0mSQDb5Q97Uc09AUc6VymDb4F0jWGFL6tSkVRcB9ianQtiunzbU2qXNAm2tFMFGOJJvEy1CbfuMJwS+Crfib4vuTwclxBRFMe3BCBX20SWumlDjJaWfaftGhF7B9hhTgcvGzidFKLWtTc=
Received: from BN1PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:e0::33)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 02:36:14 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::e6) by BN1PR10CA0028.outlook.office365.com
 (2603:10b6:408:e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 02:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 02:36:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 21:36:05 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH v2 3/4] drm/amd/pm: Add special handling for RAS messages
Date: Thu, 28 Mar 2024 08:05:43 +0530
Message-ID: <20240328023544.820248-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328023544.820248-1-lijo.lazar@amd.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: e3856752-d755-42d2-25aa-08dc4ecfd56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i94plDMM75TgJYm30MxFGUQozdGtY7r7oOCSlm/GBtfatCjr4+kPZk4+9uX0anfp/yFMaf6xq1TsHqnMl2kP09VdOpCC70RLe9stjEnv0pZCtq1CpyA4Y/xURd7ufPu1XuWX3K3P8K4EOsAye4PV+XBnV3eR6DT9X5BreyJO1KzmyirhKTPwX4SRgED0fPg+zv21Ad1sWEzF/dafGjR5LMuXQRb/PVIr30zKHCpl1ka66stgOVqYz66Xv9z6NaCt9t52meR+2k+ldHYWI5Y50pEQSPUnLCStqOsO6dxycRrh2o+oOHKgaRbyILGQ/pS3K/btqR6NFT8fSiMq0IDbWfXkboexbvVuYO546GFfTDFHK0jI0uRuBLVfaN6Sxdhja9THjUrcAb3kJ7R0lA5FvFHeBnoafw/dvkhkfiV95Kqntyfces/y9GQI1iFwFQ9jkio7HKI+i4sy5VJjIYE03+H0crFhpoGgfvhpWSztEp7G5LZxSkMUSpvBEw/gr8+i2WS77DZnbyGZnyP2TSeB3MNOEUDXpX7cuwxuoXltNYX6+PUu61OUgkptT6Nf3X44omvDEbV1s2awdfDCIht2Uxgok1USNvzcbTqSRU0ZgDn+cXfIV379kPxNQNlhQ6LVgsZz3nUwSxdmAQSoG0RE59RVoXZ/9BJTbBrJkNDbVt9o4ew3qcCVuri5gsQFXZ7DXBQuTbUWVg6ox8LXDoFRnWL6JSL4GLM8yDP3te9vkyOnG4ad8mhsGQORtO2EWDwr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 02:36:12.4974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3856752-d755-42d2-25aa-08dc4ecfd56c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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

When a RAS fatal error is detected, PMFW will only process priority
messages. Other messages won't be taken up for processing and therefore
won't get any response in such a state.

Add logic to filter out non-priority messages when RAS error is
detected. Also, don't poll response response status register before
sending priority messages. Use firmware capability flag to determine
whether to filter priority messages.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 65 +++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3227e514e8ae..6d1c3af927ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -235,6 +235,50 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
 	WREG32(smu->msg_reg, msg);
 }
 
+static inline uint32_t __smu_cmn_get_msg_flags(struct smu_context *smu,
+					       enum smu_message_type msg)
+{
+	return smu->message_map[msg].flags;
+}
+
+static int __smu_cmn_ras_filter_msg(struct smu_context *smu,
+				    enum smu_message_type msg, bool *poll)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t flags, resp;
+	bool fed_status;
+
+	flags = __smu_cmn_get_msg_flags(smu, msg);
+	*poll = true;
+
+	/* When there is RAS fatal error, FW won't process non-RAS priority
+	 * messages. Don't allow any messages other than RAS priority messages.
+	 */
+	fed_status = amdgpu_ras_get_fed_status(adev);
+	if (fed_status) {
+		if (!(flags & SMU_MSG_RAS_PRI)) {
+			dev_dbg(adev->dev,
+				"RAS error detected, skip sending %s",
+				smu_get_message_name(smu, msg));
+			return -EACCES;
+		}
+
+		/* FW will ignore non-priority messages when a RAS fatal error
+		 * is detected. Hence it is possible that a previous message
+		 * wouldn't have got response. Allow to continue without polling
+		 * for response status for priority messages.
+		 */
+		resp = RREG32(smu->resp_reg);
+		dev_dbg(adev->dev,
+			"Sending RAS priority message %s response status: %x",
+			smu_get_message_name(smu, msg), resp);
+		if (resp == 0)
+			*poll = false;
+	}
+
+	return 0;
+}
+
 static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 			       u32 msg,
 			       u32 param)
@@ -354,6 +398,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	int res, index;
+	bool poll = true;
 	u32 reg;
 
 	if (adev->no_hw_access)
@@ -366,12 +411,20 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 		return index == -EACCES ? 0 : index;
 
 	mutex_lock(&smu->message_lock);
-	reg = __smu_cmn_poll_stat(smu);
-	res = __smu_cmn_reg2errno(smu, reg);
-	if (reg == SMU_RESP_NONE ||
-	    res == -EREMOTEIO) {
-		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-		goto Out;
+
+	if (smu->smc_fw_caps & SMU_FW_CAP_RAS_PRI) {
+		res = __smu_cmn_ras_filter_msg(smu, msg, &poll);
+		if (res)
+			goto Out;
+	}
+
+	if (poll) {
+		reg = __smu_cmn_poll_stat(smu);
+		res = __smu_cmn_reg2errno(smu, reg);
+		if (reg == SMU_RESP_NONE || res == -EREMOTEIO) {
+			__smu_cmn_reg_print_error(smu, reg, index, param, msg);
+			goto Out;
+		}
 	}
 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
 	reg = __smu_cmn_poll_stat(smu);
-- 
2.25.1

