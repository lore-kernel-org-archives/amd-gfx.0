Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5752FC71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 11:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED91710E989;
	Fri, 13 Jun 2025 11:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iq9FcCKM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1562210E989
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 11:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7JmoAnQ2AHy5Glc5oe26wPnzHmFHb9YHiWcafLDhUKFPahfW0eHu1jhao3P+G1oVJ32MmgzkhuuuS8fBzdAmsNiQkcEw8v8fteMZzdKo0ThzpUFPX+t/mLwnHPo1EZG9dOL2D26iuj7u05rmMCgOBdtDVD8eVIjQF1DR0QHY8OCqE0P70EsipfpRzVdqA+3kr9Oe60I+CaJb+e9v+W6wlE4RURDll2rFCCklXUFhhKu5CRamBA57vBWexnV0eZshgu8QdkA3wcvNuAdFHwP0jJUg92xfpoYW4sc9vJK3zBtxzKkW9CaP/RLxiMteAQMO1EUsMZ9OGsYT9OujoQq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FONLk86NziN7ShSsPo121sFYVydk1kCjIzp0aS9fepo=;
 b=UDj/blUmG+OwhOtwgkZsLZvBd/Pwq5NwQ20KIu5IDIX2fsHCr9ujeuEyaapV3NsW8USeCW+8Cmx4LhKtnqhV4+FR6pEZb7R2DVK4BSKH0TjIe1Q1n5FezAIglcOLfR7lAD/8K2Nfmk9eN1tV7w8TShsNNiexklYl+NT5Uw6FO4VpZpTvBe7mlZ8F/gW2fk0YPhIVjcj7uJ2j4ANIq9aREFKzuDT9hGveVV3GPKpVLngthgG45FQ1hB6k3SkurkugZfEZnqKUI7xPahHrBcADr9tlDlZUGpP4KwIjirNJGrASMV2SOSK2BwlWSdRZlE9vT+eyC+BmQmRnp51lxRbEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FONLk86NziN7ShSsPo121sFYVydk1kCjIzp0aS9fepo=;
 b=Iq9FcCKMnsgUB4t96mKwa6mng3NpuowNXOeDtVVhm5cb+Oo6zbJqy2c7fSGWyJoMWmDVqIn2816AnEFPu6ADccs1wwiHBUQ2dDojKyPoTJiVF4C9bXTJQGZR1sLh5SQYWn7kx5fZt2i1F/vmIMbRXzy0RC/VDUwQi/lR70OWLf0=
Received: from BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21) by
 PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 13 Jun
 2025 11:06:51 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::9c) by BYAPR01CA0044.outlook.office365.com
 (2603:10b6:a03:94::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 11:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 11:06:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 06:06:46 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Extend bus status check to more cases
Date: Fri, 13 Jun 2025 16:36:30 +0530
Message-ID: <20250613110630.837166-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7755ef-b91c-4637-2428-08ddaa6a65fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NbiPbsm24cI0nGD7Ie+/AMUwJoTYLvNzS+VOeH2PV+WgtWK3lcqcCWr0mLM8?=
 =?us-ascii?Q?BbZcoXxI8u86TseQCQp9K4qVrB7izCHfVfwHu7FA6iTN3iWjs6R24ahwYmk9?=
 =?us-ascii?Q?B0syu/mfZgY+HDKC07QA/bk9dJACWSX20pJIIdtYGYKH+hN9gE1CdGjaCiph?=
 =?us-ascii?Q?7URSDVelLtJIqhYpb9jfRJXKOWz2iRdFxgKr5LT1xT7r8/ulLd/nYfWaV+qj?=
 =?us-ascii?Q?qYjy/A54s+06IoN9sbiGu8Ky2Hn9/yS17cOyradEHY05AkAKY425zAmqc4Jt?=
 =?us-ascii?Q?n1Ncv+8AEefKm17vTNlAlrEqjurD93QtqvMPT4zZQn+Ce6cpv9wCt5Z52vm5?=
 =?us-ascii?Q?OoWKN4VX06zJx4GORjIVvmSj1Hr8a2vo3iQdCCk58hP8clNvhAUhOkI3WNvT?=
 =?us-ascii?Q?2auTSaw3nulc0sC3Mu00cGYkacqAYgqkIlyQeSMJDTZMc4VQSj+Hk3H2Xpvv?=
 =?us-ascii?Q?lt1fBhFly8miJ7EFFb/Ndvp1NS/nVhpYd3YHohbv3YjP/p47/8NlYeQ71I8s?=
 =?us-ascii?Q?gLHTlUGnCnzz0G15aWXzwVXCv/4Qt6Bud2qF7kDgS4QQpR0ZgOkfnugiCB19?=
 =?us-ascii?Q?Rq2uE4O8ZbIha9NJWQBYBJ3HCYwNOglwSgUZYmJgqhg9hikU55BVP04nTJVu?=
 =?us-ascii?Q?oKN+MXbYTEPJkF1Vz8ObV5M7qUexTD3NQj91o+LRomgG95boVLl5lDhJH5MH?=
 =?us-ascii?Q?Vcq4iWldgu9sV79rsS2wjgs14Y+HfamnXUbGg+NK1T4VmlRA++dhfD99hHE1?=
 =?us-ascii?Q?XdWOwvBa53siDue2Cz4aPagrNYaMnI9Y17PoqcNiFT4gEjS6M7ep+CJ+dKVL?=
 =?us-ascii?Q?QP1Fy1pVfJ2EooxBGepTxDWSsHeteZ4td37N8GsWqKalOnNrVEPTmPnX+w2U?=
 =?us-ascii?Q?r1q9bu44Tx/u/sxFYO+uN3basCnlGAkwP5+kbUSvN4UxRDdEMntMrCNDS7nz?=
 =?us-ascii?Q?oHvna/buqWA6RI5GsflrldGR8QVd03mkXSamHV5TCcuhKNPq4KxN1hvw7JEL?=
 =?us-ascii?Q?CO6/+OX7ttqzAA3fBpua6Xf93V9gfR3fVbOD74Jp9O+sDNy0VvtbE9n4IDug?=
 =?us-ascii?Q?/MITnDSnBF8HrOd+jwBG6OTqPonAboRyeVydpnvB3MYx+z2RKHhUrEPOGFHd?=
 =?us-ascii?Q?i0g6v2BjOfAn94TApaY0yxzR+Pp4KEGthBPmu0QWsV0XvXWbyS0B1EwDgInR?=
 =?us-ascii?Q?kG2z2HlZ5+ITvv1itgPz5X+BN+1Ucw8QKP9Vsv5lHkZJiEP8f6sMHbQw8aOG?=
 =?us-ascii?Q?wK+1UUhtUikWZfkV1bl/fDBl5dByNcxV5tlh8qk0Eh8mXFuaEZJdbrT8eIo8?=
 =?us-ascii?Q?douY96sSaBikJNB9pY9S9hR1N3nxIYQyuvMsRRINyfNVrM04DXIr6fffvO29?=
 =?us-ascii?Q?cIfCS4ONgs70it6RwyrokBg5YlNy3jl7cchjftcfRL4lVvC5QiGEH3RPL3Rz?=
 =?us-ascii?Q?ORJ8XK+Mo+rH7DJ1yMnlMP2lLCfZokqUjDeWhFdHbSGggfMtIgn/HhuLRZCw?=
 =?us-ascii?Q?l1tmaLMw8s8sa08yRla7gINCGXOnVun1tV4y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 11:06:50.9354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7755ef-b91c-4637-2428-08ddaa6a65fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

In case of unexpected errors, check if device is alive on the bus.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +------
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     | 10 ++++++++++
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ea9206ab3ed1..928d28d100f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1780,4 +1780,19 @@ extern const struct attribute_group amdgpu_flash_attr_group;
 
 void amdgpu_set_init_level(struct amdgpu_device *adev,
 			   enum amdgpu_init_lvl_id lvl);
+
+static inline int amdgpu_device_bus_status_check(struct amdgpu_device *adev)
+{
+       u32 status;
+       int r;
+
+       r = pci_read_config_dword(adev->pdev, PCI_COMMAND, &status);
+       if (r || PCI_POSSIBLE_ERROR(status)) {
+		dev_err(adev->dev, "device lost from bus!");
+		return -ENODEV;
+       }
+
+       return 0;
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2795a34563f4..a968a9cab27e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6066,14 +6066,9 @@ static int amdgpu_device_health_check(struct list_head *device_list_handle)
 {
 	struct amdgpu_device *tmp_adev;
 	int ret = 0;
-	u32 status;
 
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		pci_read_config_dword(tmp_adev->pdev, PCI_COMMAND, &status);
-		if (PCI_POSSIBLE_ERROR(status)) {
-			dev_err(tmp_adev->dev, "device lost from bus!");
-			ret = -ENODEV;
-		}
+		ret |= amdgpu_device_bus_status_check(tmp_adev);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 1c083304ae77..41acc1ce0b3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -353,11 +353,14 @@ static int aqua_vanjaram_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 
 	if (adev->nbio.funcs->get_compute_partition_mode) {
 		mode = adev->nbio.funcs->get_compute_partition_mode(adev);
-		if (mode != derv_mode)
+		if (mode != derv_mode) {
 			dev_warn(
 				adev->dev,
 				"Mismatch in compute partition mode - reported : %d derived : %d",
 				mode, derv_mode);
+			if (derv_mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+				amdgpu_device_bus_status_check(adev);
+		}
 	}
 
 	return mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 7eaf58fd7f9a..59f9abd0f7b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -86,6 +86,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
 #define SMU_RESP_BUSY_OTHER     0xFC
 #define SMU_RESP_DEBUG_END      0xFB
 
+#define SMU_RESP_UNEXP (~0U)
 /**
  * __smu_cmn_poll_stat -- poll for a status from the SMU
  * @smu: a pointer to SMU context
@@ -171,6 +172,15 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 		dev_err_ratelimited(adev->dev,
 				    "SMU: I'm debugging!");
 		break;
+	case SMU_RESP_UNEXP:
+		if (amdgpu_device_bus_status_check(smu->adev)) {
+			/* print error immediately if device is off the bus */
+			dev_err(adev->dev,
+				"SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
+				reg_c2pmsg_90, msg_index, param, message);
+			break;
+		}
+		fallthrough;
 	default:
 		dev_err_ratelimited(adev->dev,
 				    "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
-- 
2.25.1

