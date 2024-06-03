Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9CBC25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 06:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39FB10E2D0;
	Mon,  3 Jun 2024 06:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFBhXxjZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2701810E2D0
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 06:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOmG76c/3zlPEiBDVdGW7zJWRPTmGhi9cQ8+Ytx8n+G2Ag1peSNEtfTZ8csLKpk/65QwUwAsbFqeLVWlxutK/QVfumn55NjJSC/c2DsDsNGhNkRuNv05O8Axt5MGpFmvNpql1f19uY/oMZc1cRrFS52V+1VFOTUqzZPamVn8pGQX10dq26swpGMmJGcxbseESXAIY4G191LQiMs0UaIMTycPVMxdX8EnP3bIsLSS8W6dT3P9oonNPAuAOhb9ZDoLb0P5S2vS9cCpYomtcXBd78hF4spM4L8K57a+WiGIdK/8v+0uA3Z0nmT4Zp1tC9MBPBjr+lbmaf3+YhazZ6aQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8EnFX9aKfGRL3ocZLXVxaq6A6bpbWPLkjoCRA0+Y5s=;
 b=HjohheBge7OlqWcUtttIZuIe7X7VJkRTnSYwihqE1P2R/aZwjM2djFqXj/hxk+k77nEzDVKkXO1ANty3LDf80btkyj6twJjvPliqEfJBicJrRH6l1xLQ+cIJcMHRSaSM0Ee088t6J5wTVa1B5hjFzozhtU81qJ5Qf9AXgCm7rgalXBdv2oz1Tk/PDWBDRp9RaO13TvjET5WdSGbXeXeAyFRQwSo4ITzR2wZblx6irKsrUNpvzBm2U171FsXfzgYYlvUvJRULy1Y9a00cy+0G0g55B1PgUsA4RoW7jkrx36oRn/Xb77R3dWE9JENTjwkVGlWjiWBPIKHYsHo/pN34zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8EnFX9aKfGRL3ocZLXVxaq6A6bpbWPLkjoCRA0+Y5s=;
 b=AFBhXxjZQwpaTIucCvA9USEaF3qn4XmlpAwUTkNT5iqkzMA1TTgFa1k3MZE5NfrRC11uVSKZZ5W9FLSN6BwChHVwCs6jTrNmdBfiDR7DTyw/vC8q/6ps4jgBBu83jxdbyieP6maYBF18Z7sPBoClUMV63Kz9bmqIXAfCtF6P4IU=
Received: from PH7P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::31)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 3 Jun
 2024 06:58:41 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::83) by PH7P220CA0032.outlook.office365.com
 (2603:10b6:510:32b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 06:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 06:58:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 01:58:38 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Don't show false warning for reg list
Date: Mon, 3 Jun 2024 12:28:21 +0530
Message-ID: <20240603065821.992954-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: fba6dfbd-1ce2-4783-8adb-08dc839a999a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AX8hwqhl05y8D4sT+wH5toK8dPBsTX1hIC1uL4rS1nMHUiFIrNcRVCxkk05w?=
 =?us-ascii?Q?Ef3zxv0Yf53ktdZYXSisRPp2ZLXi8zMQAqlMKslLTmkYxx4G5PEeuwlzSnng?=
 =?us-ascii?Q?ZcO3NlN5RQlZpahufveI/e17DVBmiY57Y7c0jZs6q/f3lAGkBJqa0YtkY6mq?=
 =?us-ascii?Q?fG2Q0BgziQOdkZI+jDR47xKBHJugkKipvDt5mBuO1O5zuwNv9Qfj/aD15O62?=
 =?us-ascii?Q?YNYAzUk0+U7YfDM1bb9QAKkj72KGHFNj1QCCa7wCH5v4R7s7WaclQr1oaK6v?=
 =?us-ascii?Q?Kr220LSzwnXIuUr6BCZWmVArFP9F5vwkaYk9AWCm0b7gaNMVNU9SbE10zrUx?=
 =?us-ascii?Q?+O3XXfA9wQbZZooDzapW+KPr0qwLK2yM/l6YsTj6z2hI5/ZdxV0r4XJVBbpc?=
 =?us-ascii?Q?+uEezjjIHguBWJDQdJ6/hqGZQGF+aIqIOt5UDeIPLQKyYMLUkXK/kegl/Niw?=
 =?us-ascii?Q?PAJDiDShNpenCrkJfxDIoqP2vGMG1W4abzRR2iePintXKmg8JNR4AJmHCqRO?=
 =?us-ascii?Q?95n+Ok5c5l4BTyQqcf3H5Vayb0BtUnXmLNFm/HJ/B8lJBpfxQK5uVXBOdYQW?=
 =?us-ascii?Q?+PC6773OiIlwGPQEY2gr/6CRhMkbQI3OQc9wYdOUYTuyFsukCkBW5fXQ7OLv?=
 =?us-ascii?Q?qGg3iGP5eKeh0dHwlLjiacwNkcG96+0fBCHQhTKfDyHv1P/LlytEBNEppVjl?=
 =?us-ascii?Q?bQf5Lgy6i7d2QffOWLWVh6GTkjij8b9uEBlBemUSWepDFtmUdKTMZAenrZFi?=
 =?us-ascii?Q?UHECS4LsbP6tPpDmJwZLSI6eL3X0caqm3Mb30KuphkvfC8xad/6Vq/Uk56BT?=
 =?us-ascii?Q?msd4CYBxq0u3Oc8tgJAyU0jOVctiLLtrDL4FuMPJ0tz+zUxeKwltszIqu0z5?=
 =?us-ascii?Q?eQFhdaiw99K8Qpuk3X49Z0vcOz2sky8WRkgW3Jm5+RmV5t8O0iLnxzHVpVRj?=
 =?us-ascii?Q?CwO2olct28m/vYd2gvrG9DVV2J67xBwI0l/n8mqFEugSYWyZEAAXS99PBpco?=
 =?us-ascii?Q?rDb5NnXGH2HlV24VI0Lb9xhdJ7EX76AAqI+PY5SOgvv2pKa6nnQHIPaP8UwS?=
 =?us-ascii?Q?c5zC1JGkXCtQ/vqx1q6BX2pvF6097dMsjrKTXxYUnxewaNYol+ZdfWYyMWwE?=
 =?us-ascii?Q?62ILV49HGi5XskDcUQtRoUOJd/WadXsqR6rMPG3a2uqTI9ZjDpXo5YJjrFbc?=
 =?us-ascii?Q?le0tTgRcOxJ15pqiCg1cQ6wvjZ6zIDO1RppGIXiNXdP5/oqf/3FrRgdGIHxH?=
 =?us-ascii?Q?3N3sNvkOKw+rMhedNuV6CYSFXL3ZZJFhLVuDmEnz4yjcQYNDgUrOmnlLSKPf?=
 =?us-ascii?Q?Mrkb0EZJO9uqFQqah4xcipsiUoI2WNnNc4F9mcL0y7GN5lyGsBs39mfUFzbF?=
 =?us-ascii?Q?Uo+7YOK73FZnzXkDtXog/nWTWnDl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 06:58:40.3918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba6dfbd-1ce2-4783-8adb-08dc839a999a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
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

If reg list is already loaded on PSP 13.0.2 SOCs, psp will give
TEE_ERR_CANCEL response on second time load. Avoid printing warn
message for it.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 25 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  5 +++--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6d1911773043..079feb139b16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -643,6 +643,20 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 	}
 }
 
+static bool psp_err_warn(struct psp_context *psp)
+{
+	struct psp_gfx_cmd_resp *cmd = psp->cmd_buf_mem;
+
+	/* This response indicates reg list is already loaded */
+	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 2) &&
+	    cmd->cmd_id == GFX_CMD_ID_LOAD_IP_FW &&
+	    cmd->cmd.cmd_load_ip_fw.fw_type == GFX_FW_TYPE_REG_LIST &&
+	    cmd->resp.status == TEE_ERROR_CANCEL)
+		return false;
+
+	return true;
+}
+
 static int
 psp_cmd_submit_buf(struct psp_context *psp,
 		   struct amdgpu_firmware_info *ucode,
@@ -702,10 +716,13 @@ psp_cmd_submit_buf(struct psp_context *psp,
 			dev_warn(psp->adev->dev,
 				 "failed to load ucode %s(0x%X) ",
 				 amdgpu_ucode_name(ucode->ucode_id), ucode->ucode_id);
-		dev_warn(psp->adev->dev,
-			 "psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
-			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id), psp->cmd_buf_mem->cmd_id,
-			 psp->cmd_buf_mem->resp.status);
+		if (psp_err_warn(psp))
+			dev_warn(
+				psp->adev->dev,
+				"psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
+				psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
+				psp->cmd_buf_mem->cmd_id,
+				psp->cmd_buf_mem->resp.status);
 		/* If any firmware (including CAP) load fails under SRIOV, it should
 		 * return failure to stop the VF from initializing.
 		 * Also return failure in case of timeout
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 7566973ed8f5..37b5ddd6f13b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -464,8 +464,9 @@ struct psp_gfx_rb_frame
 #define PSP_ERR_UNKNOWN_COMMAND 0x00000100
 
 enum tee_error_code {
-    TEE_SUCCESS                         = 0x00000000,
-    TEE_ERROR_NOT_SUPPORTED             = 0xFFFF000A,
+	TEE_SUCCESS			= 0x00000000,
+	TEE_ERROR_CANCEL		= 0xFFFF0002,
+	TEE_ERROR_NOT_SUPPORTED		= 0xFFFF000A,
 };
 
 #endif /* _PSP_TEE_GFX_IF_H_ */
-- 
2.25.1

