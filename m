Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8FAC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 14:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB6F10E6BF;
	Tue, 18 Jun 2024 14:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nhf6Pfj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE66810E6BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 14:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjFdfwZVoH6E9R8Dl+Qozgdj94FiKEYkY1IGhRfbyitLQOyT+rIHH0mY/ufBTuAu5WCPKpLUIgcu70n8JBujxzQrnvG0BMUGpTc7agaMsJdldb/7UqOLOkC7upM7JSdKIcxkXNy9pX1PFHjJxQp8VoPBWo17Sap+uWN51Tu7OyLEacoLYYS0rF4fW8Y2/JhoK3xlvEF6PBMn0syuEb79rmFyg1CqLRHZvedo42Wr7LWnz5PxilE/R1mVHEjyT9MRpgEcL5uP98hEx7nV6QtvBvNrlwOmuSAwnleRd79tsqeQUkAOglpIdC034FP8PV/jYoI48kv2MhqIx7lmyTwz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noL5AchmtQkdXwCuL+vo5bi+R6NAfe/Uss6z3CHaTa4=;
 b=GdK04J3VReXFOUBr9Z7IiiD62oFqoxwvhVZqHUBxX126xktnJdBHtidemfDzzBiw6lFceGeJr6nnHshByoTK5/UIlOlvtRIxE1IVQ1Px6PoaXs9l7nuNkA+MAYI2bgyxqjLrxtaXGdiEwyReQktRc12Hb9juYM25SeXpyBT63JQ/JwlVrmtkvkVHqMDLMsY2jSzYiGKr/7iDVUfa+NdTYa+zSINSgw/E+K9voiwIby3k0oQ3KLvFy/Cpz5dlWmaeIX7dpXAR1XxvOnWUdTPAJlRat96WBwDlMMdahfOgCXCTw1RrrU/n6Tjo202MFbWxmaB+EhzkPBSzPBFXqz615g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noL5AchmtQkdXwCuL+vo5bi+R6NAfe/Uss6z3CHaTa4=;
 b=3nhf6PfjRqSo5rXWm+AKa0p7hS3fwshrTVSgYkAXI8GvZl8UM0pZUGk1wFqnT5oUAp5BIhGJlGv64PYPd/MMORY8yh3v/57Ll9u0a3RgUWMTQoMFSKSN+jOGjs4Bor3blShkfn5OSG7iC+7/MPGXdCImsdUhVf6Z6IuOmOkkVII=
Received: from SJ0PR03CA0365.namprd03.prod.outlook.com (2603:10b6:a03:3a1::10)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 14:51:08 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::44) by SJ0PR03CA0365.outlook.office365.com
 (2603:10b6:a03:3a1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 14:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 14:51:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 09:51:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 09:51:07 -0500
Received: from sriov-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 18 Jun 2024 09:51:06 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Danijel Slivka <danijel.slivka@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>, pengzhou <PengJu.Zhou@amd.com>
Subject: [PATCH] drm/amd/pm: check whether smu is idle in sriov case
Date: Tue, 18 Jun 2024 16:59:44 +0200
Message-ID: <20240618145944.95640-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: danijel.slivka@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 60737315-3ce2-4464-5aaa-08dc8fa6169c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|36860700010|82310400023|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E6/E53BxxVma60hp5BrLyk1CVuLINSmgHneDRiYa1nQOA9Fr12myLsmqyJ7t?=
 =?us-ascii?Q?WIcxDT2Vgbk1/lBvNNlFekIc8jCcp0mRgxLD4P9xcNrSX2LEpF/vDUS8EJiQ?=
 =?us-ascii?Q?hg1f3cFeopODJ79aMRdtJBUcctO2zkpsOpAST+bFFOhZEDa3I2OTGKYlyOx6?=
 =?us-ascii?Q?qQ/iOn8bEYmGIHcHY6dhjb90S7PPF44Fwu1RLARi6DiXLfFCOwSM070Fs/HE?=
 =?us-ascii?Q?cCfw72UNw/F1SPOeeE1cYwP0cEowUT0D+yhWbNTkg3ESAj5c0PaF1pFPQQed?=
 =?us-ascii?Q?sFd8qmCdrJ2DFTjVE9HZ+brKQ4QkdTzorcatvwuGQVYtnphW8rAEX9ey2Uo+?=
 =?us-ascii?Q?f7OeoDwyc3yqcseAsF1K4D5tgMpw9+5MUMjaZaULpjAp+RraSsvNA2QyeMhA?=
 =?us-ascii?Q?k8NJaY2BNSUF1y/r7L118F9uJ6AUFnH+opVIsFYKK3Bp7xtMDivhYXM6Pch8?=
 =?us-ascii?Q?UIh4DQMsqh4s+4GBgDjnwYWLyn43f182IDBphnJIZ828JMw5yCAX1MeqGiWp?=
 =?us-ascii?Q?cpbgNwOXggG611yQf868vnAa5cOZeHBTohsjDMEEyO/fKceTikN44zeOT4Je?=
 =?us-ascii?Q?0fm6vQtj3Cw430eRlIylBw+iTq8JWrAYDxI9cGJYpn0KTwzgCSMbUfswmf72?=
 =?us-ascii?Q?njLyxfFpybFnQa+atSRjuJtBUxyaLfl1NpYhgyi9xO7+Vhq6FIjH/Uv6M9Ym?=
 =?us-ascii?Q?QlZZezewzJMLmqxvyEKqBAQ+PlydYZ8/QYC0olp3a0yh2JEq1zdNuwOBc0CK?=
 =?us-ascii?Q?KR6x1hGbyUqCaX5ibHXdFvt16so/rLeItbRx2w2U5pFTBvz4s9fgCFFt0WOw?=
 =?us-ascii?Q?AsbDSCjpac2BF0/ztV5lgD0iw5gxvOeJYDiUEIBz8iuj62FDIf9/maSuDG8N?=
 =?us-ascii?Q?p6rDIYPBXgPhsvAU4Oc/BDJAbrC/pp32rsY0lmAxfm/dsYkHXuqQXMiFxRE9?=
 =?us-ascii?Q?NhS8e3tXBJJzW1qDHs8+h51AmigV22mGvPCugtjpQrK1iWcGF7niy9CWjLab?=
 =?us-ascii?Q?cGDr8SQLrCcFJ3iNVP33GXk6B9xdrPwDLX6eBCv/5OWbl1+nnrtVzo60ho50?=
 =?us-ascii?Q?9YwGXDBhf6E97GX3C38j/QKf9kLDwTxmYe/YExANq+5w40YoEfQlKND9ebS3?=
 =?us-ascii?Q?DmqTVBj77kzsUy6Li1E0PKpEJIsb4EkZpCM7AbBbpHvCzAbdrcSHxmOs9075?=
 =?us-ascii?Q?4qErhrhgZiMAmC9oydzGGHyE6cOtT789AewSOqJry62+eF38AgU199AySI0m?=
 =?us-ascii?Q?8EbczZElQiO/HMZcwnt2mGY7fNgiTjjFR4qFItYdqlVfEEbvQGzA/9iwp914?=
 =?us-ascii?Q?X99KHOwmdAljkVyOuixJE9aKEnojnN+03FCaLROA7QiqbuFnYdID807vXldC?=
 =?us-ascii?Q?kN1eVN9si1CSuUR6b7BtweSSiHbO04AHgaPDAN+yzu6vn3RKAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(36860700010)(82310400023)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 14:51:08.4894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60737315-3ce2-4464-5aaa-08dc8fa6169c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
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

Why:
If the reg mmMP1_SMN_C2PMSG_90 is being written to before or during
amdgpu driver load or driver unload in sriov case, subsequent amdgpu
driver load will fail at smu hw_init.
The default of mmMP1_SMN_C2PMSG_90 register at a clean environment is 0x1,
and if value differs from 0x1, amdgpu driver load will fail.

How to fix:
This patch is to check whether smu is idle by sending a test
message to smu. If smu is idle, it will respond.
This will avoid errors in case mmMP1_SMN_C2PMSG_90 is not 0x1 eventhough
smu is idle.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 17 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 42 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e17466cc1952..dafd91b352ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -231,6 +231,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t mp1_fw_flags;
+	int ret = 0;
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 4):
@@ -244,11 +245,19 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 		break;
 	}
 
-	if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
-	    MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
-		return 0;
+	if (!((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
+	    MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT))
+		return -EIO;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = smu_cmn_wait_smu_idle(smu);
+		if (ret) {
+			dev_err(adev->dev, "SMU is not idle\n");
+			return ret;
+		}
+	}
 
-	return -EIO;
+	return 0;
 }
 
 int smu_v13_0_check_fw_version(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 5592fd825aa3..de431c31ca7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -359,6 +359,48 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
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
+	if (index < 0)
+		return index == -EACCES ? 0 : index;
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
 /**
  * smu_cmn_send_smc_msg_with_param -- send a message with parameter
  * @smu: pointer to an SMU context
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 1de685defe85..486acfc956a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -51,6 +51,9 @@ static inline int pcie_gen_to_speed(uint32_t gen)
 int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 				     uint16_t msg_index,
 				     uint32_t param);
+
+int smu_cmn_wait_smu_idle(struct smu_context *smu);
+
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
-- 
2.34.1

