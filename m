Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C3ACCD183
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41AEB10E0B7;
	Sat, 11 Oct 2025 07:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZMq/vic";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD59010E0B7
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkvO8+Z0ZIxZ+hO/rdO/CS+v+622LPtoP0V61pRqoT2PN40FcmZiWIq+Vuoo8q4eycSBOf9QLv0hHdOd0RgKUDYxysLmlZqN37hKkRKHI8eImQJ1QOqnz2czInz4JeNZYhCW4BxDXJz5aGfYLYIG56AA/5csnUHpf8z4jafpTLcJupOmKoa/O3/jofbZg9HI2bOqyuCWp+ZplY/XlkonhyZatYLpJQgmaIdeM048o2UsEsIdX3tdT2yhe21tkoNquduhTfkatrNQogMFQumPs+T6fcfey6u67Y3tmry1VwIVBJgCXPIje4pzlgm0zyIRLaSFbgkMTELz48k+CXfmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9tbveFplkQpuZrzDxNspn2cu536+R+fspHpXwwE1Pc=;
 b=L+9th9movAFMUUhiN/Iyeunx2HqmfymaoZpIfw8XyzTL22fh1Tcw0ZAVcAwbDF0T3NvOCv9hPqt8+zN1ADBKIYtBjufnKUJKBX/+9NS/pKLXL5u2xA+t01nJXEZHYEvv7Y+0KvF/gSScLLsWvCT0dQwmcNhgl+GcCy0+fqX4sm0LyoXHDfztHwozNV7k2Yu2d5Bau73U2Nz0dCzsUVnQP4xTpTrKP8OUshzCaogjSR90qiiLn8PUpAQUzP1xuo9JFiYT796pgVEOWFObOAdy1ss0U8NcJAI0r3qGuazYFGPifxtDGJorruDvvVnciwO3LgLqR3oqkRvqPNjuODbD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9tbveFplkQpuZrzDxNspn2cu536+R+fspHpXwwE1Pc=;
 b=YZMq/vicRi9gF0s/roWU0QnQPgxtD/eI+DTelv/3QkaEn1U80QdWesubhg3detnKwq1CpT1mDXEHIF31Y6GKaobZugycP31ihlVLtxiyXzD1kljiTCPX+n98UkHzRSrBvUIYyL/Fh+wAyliXA1qOB46oNaZfdksXMBJTIh7+PAE=
Received: from CH2PR07CA0043.namprd07.prod.outlook.com (2603:10b6:610:5b::17)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 07:49:55 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::28) by CH2PR07CA0043.outlook.office365.com
 (2603:10b6:610:5b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Sat,
 11 Oct 2025 07:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:49:54 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:49:51 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Tao
 Zhou" <tao.zhou1@amd.com>
Subject: [PATCH 1/9] drm/amd/pm: export a function amdgpu_smu_ras_send_msg to
 allow send msg directly
Date: Sat, 11 Oct 2025 15:48:03 +0800
Message-ID: <20251011074811.533871-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb0f439-44cd-4ed1-3c1c-08de089ac481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sR69n2HhS7qPVmClOpLG/KqOBPD8uCv8GYpz2CF8AeoDO0SCSP9KGKzFcJKa?=
 =?us-ascii?Q?25OLMSaIxy5oYsZIZx4KqbX30qQdbkHRkRQG0Wh/fSxK4+ab4V8a7gR5g89w?=
 =?us-ascii?Q?pr2v3dtnsnaWLZzTkmie5uOVqQ8wwD+bZzH+PClta4cNhnK6lo/mkCl8fH5d?=
 =?us-ascii?Q?QohQZHt438Ppf0tgb3mG1N9mHrpzJDkbrDcXrR3EWyD4fUUXxAy7jc92/k+w?=
 =?us-ascii?Q?tCXxRZsenjdNl+R7TRm9JOFgDCumgZwWbMQoZHBvKu+5JFctuIrIGf3Ywyee?=
 =?us-ascii?Q?yDhoK44++5sQzbsID+JX+gm8YjwEiAcjsY9OEs6rdviR58snOnqjZQFGSs10?=
 =?us-ascii?Q?K4wT5wN4rbGwZdta8TzKEkJ/pYihEttupV3X7jYucdn1qYEqOkKQ2CI3PCFS?=
 =?us-ascii?Q?SAn+wYETSRmR0Nx84DDIVOEkkkxtT8Xygaa+cIqPfxHM8x4adByzMIDvb4S/?=
 =?us-ascii?Q?UnZTrIB58AsU6SLhvAHFPGfv6YAhT9z0iFBtUremIzMuneQF52Ls0ZavBUpK?=
 =?us-ascii?Q?j+Pz3JjoK+Q0t5A6O/3sejnFBHiQHUQu9GHFm8Av/z2K9pSS+8FkXLCUornf?=
 =?us-ascii?Q?o854/1KSwv9wwljU0ziiBV4lKg91pZvp2biV5gOIkwZOQBdve9bz+bzGRq1+?=
 =?us-ascii?Q?uyJGZtvNnPz9yEUaoKcW4VWQszxEumggxYVP3AzA1ViYBbA2BOMG0dlZ49kV?=
 =?us-ascii?Q?+dyhtuQhsp9WCUvmIDi9h35FNsnhaDm4gQupG4JcchRIynsYnxBVOqbaFtDj?=
 =?us-ascii?Q?+omE6KwdQ+/Fkc+1BorkhTvv+oE1bUYr0R6CTrDD0z/HBDn3cp+T69/gIi4O?=
 =?us-ascii?Q?PlOLhWwdN9AsuOzzZUAlenkSbslBlWooqNX5yZDMLJd4rZAn/DnGniojw2BA?=
 =?us-ascii?Q?7eNaZi6kCFgjmboIcaZPhDgGtJFIAkSe95MCZhUuxGMVNgxx4V+TnHCAg27F?=
 =?us-ascii?Q?DVVK3Oj8VPkXO+kyubCUQ86tRznzbuA9Wi84h1oLYBa0w33ycdx/683+lFGv?=
 =?us-ascii?Q?BjE3RPxInfg0ZjAluEJg+EXucPnMJ5dQqODVQMZ3s9zt/BVIEgV9Tw/SySWt?=
 =?us-ascii?Q?PIoKalSUrstv6OYZDz24IfbamPul6twS2l7NWFhIUbqW98nYWbptT2l30q8C?=
 =?us-ascii?Q?rTp6A3CmMVG6akyEHKq65id9Dad8qFzixS6IZuajn+qAY5+EgkuCcBwRqco2?=
 =?us-ascii?Q?iYBs/Xb1zwuAecUhHG0xvjXFwroFvTmojtPkFft93oUkHmjO+XzUAkAESSl9?=
 =?us-ascii?Q?6kEb6M3CrKoC3WpwEJPXOcM3edPnB7Ir39IIcqdOEcRvCf8yBLgVcPFANSkK?=
 =?us-ascii?Q?wVAW3pDpDGDclJb/8gHTTnGj6gfplbptOv0lYYHhVCW1dHQO/oNgUf1zhPHa?=
 =?us-ascii?Q?px3amliN3dpAPkVF+xb/kubhKhY9tjP3Z+7J3r3LNLOPU6kEJ0j+8SJimQP2?=
 =?us-ascii?Q?7p/pUxns1f00uGDp5Or3LvaiJgxbgwVxuNdBFyM/lLevqO+uhW0A7cPDoevr?=
 =?us-ascii?Q?UqEe32Rty++qAcxH9z4QXDz3yfZm7xP9ggTZy49y5E1PAN+9qiEH0AqOx7qQ?=
 =?us-ascii?Q?nEoDbbVrpa2l0/av2dQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:49:54.7439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb0f439-44cd-4ed1-3c1c-08de089ac481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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

provide a interface that allows ras client send msg to smu/pmfw directly.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 11 +++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ea27c087ecf1..3f14fdaed332 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -612,6 +612,17 @@ bool is_support_cclk_dpm(struct amdgpu_device *adev)
 	return true;
 }
 
+int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
+			    uint32_t param, uint32_t *read_arg)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret = -EOPNOTSUPP;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->ras_send_msg)
+		ret = smu->ppt_funcs->ras_send_msg(smu, msg, param, read_arg);
+
+	return ret;
+}
 
 static int smu_sys_get_pp_table(void *handle,
 				char **table)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 32387e8c138b..c48028abc8c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1522,6 +1522,15 @@ struct pptable_funcs {
 	 */
 	ssize_t (*get_xcp_metrics)(struct smu_context *smu, int xcp_id,
 				   void *table);
+	/**
+	 * @ras_send_msg: Send a message with a parameter from Ras
+	 * &msg: Type of message.
+	 * &param: Message parameter.
+	 * &read_arg: SMU response (optional).
+	 */
+	int (*ras_send_msg)(struct smu_context *smu,
+			    enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
+
 };
 
 typedef enum {
@@ -1787,6 +1796,8 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 			       enum pp_pm_policy p_type, char *sysbuf);
 
+int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
+			    uint32_t param, uint32_t *readarg);
 #endif
 
 void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id fea_id);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 285cf7979693..5d4315c4aa27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3226,6 +3226,24 @@ static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_type msg, uint32_t param, uint32_t *read_arg)
+{
+	int ret;
+
+	switch (msg) {
+	case SMU_MSG_QueryValidMcaCount:
+	case SMU_MSG_QueryValidMcaCeCount:
+	case SMU_MSG_McaBankDumpDW:
+	case SMU_MSG_McaBankCeDumpDW:
+	case SMU_MSG_ClearMcaOnRead:
+		ret = smu_cmn_send_smc_msg_with_param(smu, msg, param, read_arg);
+		break;
+	default:
+		ret = -EPERM;
+	}
+
+	return ret;
+}
 
 static int smu_v13_0_6_post_init(struct smu_context *smu)
 {
@@ -3921,6 +3939,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.reset_sdma = smu_v13_0_6_reset_sdma,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 	.post_init = smu_v13_0_6_post_init,
+	.ras_send_msg = smu_v13_0_6_ras_send_msg,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

