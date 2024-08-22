Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4764BC52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 02:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA72610E32C;
	Thu, 22 Aug 2024 02:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gdSGub9N";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F7610E32C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 02:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdBap3pmprVuJhfS0coBdG4TslOuCWzJkLj4xznSYCWpoFukEQhBkt7uKAMyB0mjX9Fs3mLH+RbykM2e7roq1+sYWuD0zSMMd0KaDsGEA0iBejOfsOUYaXVaPofAH1Ed0qzTtKCMja6HAJcOvSuaCGeYmr0VtV4LQDXzWqrlTVoyveuBqsQTfgrvZ+Naj8l7a7vVcOpubDPjZB2/NYqv8Ybi8PA5LPRiPlzAiES00s5xhBnjtnOAOA5i4rc4mSpjg9mvQ6cHnH+uZBZkuMn338EzeBN+V9dT+1/enklPwdcOq7cWGv3zpalRnPISNHsKcZ69YS3BomFjGdrY470C6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrprjSprRLtQi8lAEnRIt3RioUR2FkHuovHFWpNwl1Q=;
 b=R8LUCvLCaz5LlxA5a0gXpTx8ajDYADUEfdZVlyGQdEnY+If51XsQZQoiDD+mR/XDUMVhhJSa0HIU1P394K8g6i15ghgVGLkx/qFuwc2EkJoovu/9TkN2HQ77PVlpyXnwRhP+UKGAE1ml7bGIDPimAbu8Ub+qZcgRx/JwEU6i00IzZc0bSy1Z76+UEq/9bUYf45tSZ6iITg2PnyJKd6f3rzNPLDYATYqS3oxR9ucjTYk3wzYvr2kO2v1i7aOQ0yyyt3RIXLSrOfk0xwJ6vMoXoQbazFAuYJcXRfXeA+CVwaNiKxzSKE4VnO++QVbvg8Ab2RahAkUo1Ek4I0c5xHmLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrprjSprRLtQi8lAEnRIt3RioUR2FkHuovHFWpNwl1Q=;
 b=gdSGub9NPMeSo1tA3uJ26nQX5Q3SWsSw6NK9lhDXS/rVkIBMkc6n63p4IRpBATaRJgf51iD/2diTm96gvh+nC32H32DTjoCNNNYms1yi5/AHklodkldElTqOnCVYlp2hHEiQLV8Am1wLABfAZzzGfFPx+OZfX2ut/RjEHv2NdZ0=
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 02:12:51 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::25) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 02:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 02:12:50 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 21:12:49 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Drop unsupported features on smu v14_0_2
Date: Thu, 22 Aug 2024 10:12:35 +0800
Message-ID: <20240822021235.1699703-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: e65c39f2-785e-428f-585b-08dcc24fecb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PYJe2CaCe9e/stMoQgQv1OzSXC3ESL2dAlM/p64EiQxfJ1blbfdqqKN6uxQ/?=
 =?us-ascii?Q?0mda/qFzZaz8FCAXKqAXSe4Clf+eldKkigNFm4MHL7DzE+nrF6rFeMSvKbcx?=
 =?us-ascii?Q?sA76lyB3e/k/5ljDboKjZXj2LHPkmZMCgBbvjBDmzmcXke1nfVnKGwi5xFfu?=
 =?us-ascii?Q?L1aLLcFkqJVWJmNW1Nz4KYWYfmmqFjdSm44hEYIf4yqFMvn32GIAzwi6ZGP4?=
 =?us-ascii?Q?zn7v3O3PdpbIPfwrEDmRjKjx4MCzF7j7K/QdJ74zlQ5Stn93gNPvde73MjUW?=
 =?us-ascii?Q?2vaNg3SXcrViTAWrn/hMaDfMlnNcV98i4p78XmVpVjdgWW2FK8/X1oZIIjE2?=
 =?us-ascii?Q?TxgIPAmJ1BMkUWbRDQk8bdzruWRpxMUTabyqx8LyEIAziGfdvnmNNMkuCfYe?=
 =?us-ascii?Q?bBX8uTYbbZZx9iY0xmWHJ7ieeE02wj/QiHCCoJH18/2IvKah9strjeaSkc8v?=
 =?us-ascii?Q?YjrpYfQRXsKkKO9LmmI5ircS+0UJV0J5bbSM1XBVFT57OremDu1AVX4o9v25?=
 =?us-ascii?Q?JJBR7rQOWFvno2CJXKytMm0D5zAHVxbBW1FVEyU0Zpyoa1PjE33VFObQpwYT?=
 =?us-ascii?Q?Ba8zrlqiB1y1or5kEMjo/0aYuEuk3IC8Iauz0GE7rUipKtMy17tSE9Dss8y9?=
 =?us-ascii?Q?t7ejuRQS9XE+C5pzgRWhR/IwdzTEsC1fwZMOU9MO/qGTsFxNVnBhXZNeM8EG?=
 =?us-ascii?Q?eOKQHmvaq7rwVwROQhl1Z0J2YPn7/4IedO1rg0f2Y57RVL4i9MCSSioDVh/K?=
 =?us-ascii?Q?4QzUOJ33U09hR0ujsLKTAEadsTuh/L76+SFXtXpXnxzRHQNXZG+U0FPX2JIH?=
 =?us-ascii?Q?bf1Rlnv5kmyXpIt2sMTERZmGbz8sAkreAC+VeN0ogDBheWBu5I2uLpbAJjJ0?=
 =?us-ascii?Q?o4/g2p0etqGRaJpLUz9mCeZAmW9xvmvfFB2fv1hPakSUOZJxwPwRn1SD7iCk?=
 =?us-ascii?Q?ys3OBqw3R2nLvf20DgwGyhe575HhYanrbx2xsul+YlUbiUmvyXC/Enrm1hsh?=
 =?us-ascii?Q?yP9IGrh19bN0WBum2W9aHCtVD6jxBqv3RQgUBDgB1mpxje3c3tXW8SpYMKAT?=
 =?us-ascii?Q?xpumP0SZfOo3CyY5QAgguhoioDb1NzoHGjqSQ2JHlTz92lFAWirUQ7yQYNmr?=
 =?us-ascii?Q?connW1JHfZYkvry3e2K9RqfLWuiEGM2XATJ3EnQDm7SVE45XHWJWZMyDzZBi?=
 =?us-ascii?Q?9VFzEGftulrH8KXAfZ1lobGV7D9BPbjijbK+pWbxF7/Xz+bujvb79eKMhZzv?=
 =?us-ascii?Q?ctaui3VKtjY8jNGnRB4EDpLwnOhj1FPMjvQn8URAWrodpSnqBWgtjtX3hYNM?=
 =?us-ascii?Q?r2ZtDzblw/PKMSK0gVA+22uI5HaSF8iPXGnKYhM/v0L6nwF/A4dCn3w9vhzq?=
 =?us-ascii?Q?km5QcR0aaUxDiCREYYPYmv2bwT7de0hltNvuH1mes92FqB6w/8AjKHcV5BSX?=
 =?us-ascii?Q?EuYIcBzgeeIgIn5sG6hB8NMd9IgLJ52R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:12:50.7717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65c39f2-785e-428f-585b-08dcc24fecb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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

Drop unsupported features on smu v14_0_2.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 47 -------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 5913f9c60fe002..391d06cc6e5816 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2115,50 +2115,6 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
 }
 
-static int smu_v14_0_2_smu_send_bad_mem_page_num(struct smu_context *smu,
-		uint32_t size)
-{
-	int ret = 0;
-
-	/* message SMU to update the bad page number on SMUBUS */
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetNumBadMemoryPagesRetired,
-					  size, NULL);
-	if (ret)
-		dev_err(smu->adev->dev,
-			  "[%s] failed to message SMU to update bad memory pages number\n",
-			  __func__);
-
-	return ret;
-}
-
-static int smu_v14_0_2_send_bad_mem_channel_flag(struct smu_context *smu,
-		uint32_t size)
-{
-	int ret = 0;
-
-	/* message SMU to update the bad channel info on SMUBUS */
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-				  SMU_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,
-				  size, NULL);
-	if (ret)
-		dev_err(smu->adev->dev,
-			  "[%s] failed to message SMU to update bad memory pages channel info\n",
-			  __func__);
-
-	return ret;
-}
-
-static ssize_t smu_v14_0_2_get_ecc_info(struct smu_context *smu,
-					void *table)
-{
-	int ret = 0;
-
-	// TODO
-
-	return ret;
-}
-
 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
@@ -2897,12 +2853,9 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.enable_gfx_features = smu_v14_0_2_enable_gfx_features,
 	.set_mp1_state = smu_v14_0_2_set_mp1_state,
 	.set_df_cstate = smu_v14_0_2_set_df_cstate,
-	.send_hbm_bad_pages_num = smu_v14_0_2_smu_send_bad_mem_page_num,
-	.send_hbm_bad_channel_flag = smu_v14_0_2_send_bad_mem_channel_flag,
 #if 0
 	.gpo_control = smu_v14_0_gpo_control,
 #endif
-	.get_ecc_info = smu_v14_0_2_get_ecc_info,
 };
 
 void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

