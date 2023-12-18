Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50005C46CD3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC6910E27E;
	Mon, 18 Dec 2023 18:21:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC37710E27E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:21:24 +0000 (UTC)
Received: from IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 by DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 18:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3Ja0wvcjSexR1P/avfjXGNyDsMDUDt4h3iBivwSKUc9lE8r1YZ0ZxAHiOmqEm4ZI9ls6AK4qxH0Cr6LUt0WqNXn1vkAz1ZLD37DCpOIV6yvMOUSFo/WmORG8QcnngzeWZVhZvJJIzUsJxiymNU1rVHNTOwH5XJT9AW5tft4vVZBIkLCPZwk7enLzpU0wBa/ItigWhXxCvwm+FWBU9W89NW4MwLbO9+vEnw5XbH0vUb3VHAqcb3yvoF4Fmsfl/5Q44phKg2Y4NDp0IQ2T97UQax3mYoy2+JNQMx2Y3UTiTuqqs+VsqxQsuAGPPwU24TgXk5yEuNssuvTHkAbrNpJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3FHtZgZavQl0dj+oaUhLZXDzPLwjzSRETH3zQFDths=;
 b=QD0dSVJJQbyuRXsvL9aKoqdF2H41P31gGumgNthueDhDwzCESj0NpJrPM+/E9/UcGHxdfZZx43wzVfNYy3vR+B6cMImt6DbfrKLO4RvVdRph2en/SMWVActB6tIp214vw63ZCwfrutb25QaWnZ+38bCRaFpJ4OWz0pv86Z/gB3vTGxdCFV2kBj3VHCq+ifHXVQfjsxcArIhNdIX9uJqTs6qmGicWmbvFuBgpqbTF6QUYDBrSdcTTw/569rsE2NcmTPZRGqi67AlxFVVEdQI3MR+LClv912v5VfeFd+yyEWv0c5SQ3lBXxMy8ENB//LwjBuzGd2759w8LMh8oM1qhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3FHtZgZavQl0dj+oaUhLZXDzPLwjzSRETH3zQFDths=;
 b=o0NTlvp6yHVq5kdi5e60mRzCgqijiZ6cVmX0ENTkM04rMx8iu6q5Um0mqywipQFsn8WTWu4v2cqumazQQFS5hMgsJzAB3TKXh5zJJ8ThzUzwgvggkqPjR8GF2/dzLHLzX+tgm1sWcS9gCQlbmSESh5KkESA7w9KYY9iLXSAYqlU=
Received: from SA0PR11CA0157.namprd11.prod.outlook.com (2603:10b6:806:1bb::12)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 07:10:28 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::c5) by SA0PR11CA0157.outlook.office365.com
 (2603:10b6:806:1bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 07:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 07:10:27 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 01:10:24 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: MCA supports recording umc address information
Date: Mon, 18 Dec 2023 15:09:29 +0800
Message-ID: <20231218070932.2307244-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PR12MB7774:EE_|DM6PR12MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db2e5a7-97a5-46b1-0747-08dbff9869b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p90pn0Sw26DZhEmyn0IFoXEfzfUCUJb213EtY3oKyYZIBx8ZguDp6hwthROhzEApIew09Tdemrwbq7IHlVsXSb8gf7P1vmpJrliCGqxi4+gEd+5AZd73Vj0ceqBEXdIiVsKj7k2E38t4DUTNWSCKjOD7JOlhgyRTV0BcXXzgMQm4u7dmxthMf8EVuQFXbciKWpxHVK+3Ig7bFCyJ9n27b5ZGPKFYyMZziKDc1yapWEny+ePssBzJL1ccH0w1AXd6lNnTBRpd2mM5t1uEBfmVCliKOm0H1OuMMGgoOVppzGlbek1mG9kFiGU/WvvAtwJTi+IaF4FaLI8H47zCcCMKBdYz6PnUg7e4llfJNGChZROiKaYXa7Wl+g6mYQahnohDdx7JJwGGOj1SraT7zrLbFVW/ohR8B1UobPhl1YRGE2VtXu57yvv4OrfPF1RtV8IOBuvBongisx5lDm4olitaW7n9VzioTI48B2kiNKIRP2JmWaBo3a1/eUUIul8WMJ+l8/CkTfv+Wxwcs5CIjnjTLbZwXE8yl3lCePGGngl2Wkvv6f3i4vINXSQS7pCBOr3+4y0XkkxhSXzM/7yiH5SxnkbhGoqSsYsCZ9irlWMRpnbBuvj2E9iop3EoSCJy0tQhxHoBKrhUQvHEZbu8PdDZ+Q2McczlnCiStTDCCWIaEWe0r5MSJW7mFjgc/CsYQ+t7sv4cJn8GCen5IF3bxqZeJFVJwIRl/rDRchfbuHC5x3Pv3CBaOh8eil+F2mX4KX+HZU9cOxy5XFzoNG/tZe7JgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(5660300002)(36860700001)(83380400001)(478600001)(86362001)(356005)(47076005)(81166007)(41300700001)(8936002)(8676002)(4326008)(70206006)(2616005)(70586007)(82740400003)(6916009)(316002)(54906003)(36756003)(336012)(426003)(16526019)(2906002)(26005)(1076003)(7696005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:10:27.5687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db2e5a7-97a5-46b1-0747-08dbff9869b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
X-OriginatorOrg: amd.com
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MCA supports recording umc address information.

V2:
  Move err_addr variable from struct ras_err_node to
struct ras_err_info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c  | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 22 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   |  4 ++--
 8 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 210aea590a52..8911310f98df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -218,6 +218,7 @@ static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, st
 int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_data)
 {
 	struct amdgpu_smuio_mcm_config_info mcm_info;
+	struct ras_err_addr err_addr = {0};
 	struct mca_bank_set mca_set;
 	struct mca_bank_node *node;
 	struct mca_bank_entry *entry;
@@ -246,10 +247,18 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 		mcm_info.socket_id = entry->info.socket_id;
 		mcm_info.die_id = entry->info.aid;
 
+		if (blk == AMDGPU_RAS_BLOCK__UMC) {
+			err_addr.err_status = entry->regs[MCA_REG_IDX_STATUS];
+			err_addr.err_ipid = entry->regs[MCA_REG_IDX_IPID];
+			err_addr.err_addr = entry->regs[MCA_REG_IDX_ADDR];
+		}
+
 		if (type == AMDGPU_MCA_ERROR_TYPE_UE)
-			amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, (uint64_t)count);
+			amdgpu_ras_error_statistic_ue_count(err_data,
+				&mcm_info, &err_addr, (uint64_t)count);
 		else
-			amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, (uint64_t)count);
+			amdgpu_ras_error_statistic_ce_count(err_data,
+				&mcm_info, &err_addr, (uint64_t)count);
 	}
 
 out_mca_release:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bacb59d8b701..bad62141f708 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1156,8 +1156,10 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 		for_each_ras_error(err_node, err_data) {
 			err_info = &err_node->err_info;
 
-			amdgpu_ras_error_statistic_ce_count(&obj->err_data, &err_info->mcm_info, err_info->ce_count);
-			amdgpu_ras_error_statistic_ue_count(&obj->err_data, &err_info->mcm_info, err_info->ue_count);
+			amdgpu_ras_error_statistic_ce_count(&obj->err_data,
+					&err_info->mcm_info, NULL, err_info->ce_count);
+			amdgpu_ras_error_statistic_ue_count(&obj->err_data,
+					&err_info->mcm_info, NULL, err_info->ue_count);
 		}
 	} else {
 		/* for legacy asic path which doesn't has error source info */
@@ -3691,7 +3693,8 @@ static int ras_err_info_cmp(void *priv, const struct list_head *a, const struct
 }
 
 static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_data,
-						      struct amdgpu_smuio_mcm_config_info *mcm_info)
+				struct amdgpu_smuio_mcm_config_info *mcm_info,
+				struct ras_err_addr *err_addr)
 {
 	struct ras_err_node *err_node;
 
@@ -3705,6 +3708,9 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 
 	memcpy(&err_node->err_info.mcm_info, mcm_info, sizeof(*mcm_info));
 
+	if (err_addr)
+		memcpy(&err_node->err_info.err_addr, err_addr, sizeof(*err_addr));
+
 	err_data->err_list_count++;
 	list_add_tail(&err_node->node, &err_data->err_node_list);
 	list_sort(NULL, &err_data->err_node_list, ras_err_info_cmp);
@@ -3713,7 +3719,8 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 }
 
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
-					struct amdgpu_smuio_mcm_config_info *mcm_info, u64 count)
+		struct amdgpu_smuio_mcm_config_info *mcm_info,
+		struct ras_err_addr *err_addr, u64 count)
 {
 	struct ras_err_info *err_info;
 
@@ -3723,7 +3730,7 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 	if (!count)
 		return 0;
 
-	err_info = amdgpu_ras_error_get_info(err_data, mcm_info);
+	err_info = amdgpu_ras_error_get_info(err_data, mcm_info, err_addr);
 	if (!err_info)
 		return -EINVAL;
 
@@ -3734,7 +3741,8 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 }
 
 int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
-					struct amdgpu_smuio_mcm_config_info *mcm_info, u64 count)
+		struct amdgpu_smuio_mcm_config_info *mcm_info,
+		struct ras_err_addr *err_addr, u64 count)
 {
 	struct ras_err_info *err_info;
 
@@ -3744,7 +3752,7 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 	if (!count)
 		return 0;
 
-	err_info = amdgpu_ras_error_get_info(err_data, mcm_info);
+	err_info = amdgpu_ras_error_get_info(err_data, mcm_info, err_addr);
 	if (!err_info)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6a941eb8fb8f..76fb85628716 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -452,10 +452,17 @@ struct ras_fs_data {
 	char debugfs_name[32];
 };
 
+struct ras_err_addr {
+	uint64_t err_status;
+	uint64_t err_ipid;
+	uint64_t err_addr;
+};
+
 struct ras_err_info {
 	struct amdgpu_smuio_mcm_config_info mcm_info;
 	u64 ce_count;
 	u64 ue_count;
+	struct ras_err_addr err_addr;
 };
 
 struct ras_err_node {
@@ -806,8 +813,10 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_device *adev,
 int amdgpu_ras_error_data_init(struct ras_err_data *err_data);
 void amdgpu_ras_error_data_fini(struct ras_err_data *err_data);
 int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
-					struct amdgpu_smuio_mcm_config_info *mcm_info, u64 count);
+		struct amdgpu_smuio_mcm_config_info *mcm_info,
+		struct ras_err_addr *err_addr, u64 count);
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
-					struct amdgpu_smuio_mcm_config_info *mcm_info, u64 count);
+		struct amdgpu_smuio_mcm_config_info *mcm_info,
+		struct ras_err_addr *err_addr, u64 count);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 9a95b9f226b8..a6c88f2fe6e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1313,10 +1313,10 @@ static void __xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, struct a
 
 	switch (xgmi_v6_4_0_pcs_mca_get_error_type(adev, status)) {
 	case AMDGPU_MCA_ERROR_TYPE_UE:
-		amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, 1ULL);
+		amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, NULL, 1ULL);
 		break;
 	case AMDGPU_MCA_ERROR_TYPE_CE:
-		amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, 1ULL);
+		amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, NULL, 1ULL);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 00b21ece081f..131cddbdda0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3828,8 +3828,8 @@ static void gfx_v9_4_3_inst_query_ras_err_count(struct amdgpu_device *adev,
 	/* the caller should make sure initialize value of
 	 * err_data->ue_count and err_data->ce_count
 	 */
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
-	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_count);
 }
 
 static void gfx_v9_4_3_inst_reset_ras_err_count(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 9b0146732e13..fb53aacdcba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -652,8 +652,8 @@ static void mmhub_v1_8_inst_query_ras_error_count(struct amdgpu_device *adev,
 					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 					&ue_count);
 
-	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
 }
 
 static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0f24af6f2810..2d688dca26be 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2156,7 +2156,7 @@ static void sdma_v4_4_2_inst_query_ras_error_count(struct amdgpu_device *adev,
 					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 					&ue_count);
 
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
 }
 
 static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index e9c2ff74f0bc..8d60c39ae1c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -166,8 +166,8 @@ static int umc_v12_0_query_error_count(struct amdgpu_device *adev,
 	umc_v12_0_query_correctable_error_count(adev, umc_reg_offset, &ce_count);
 	umc_v12_0_query_uncorrectable_error_count(adev, umc_reg_offset, &ue_count);
 
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
-	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
+	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, NULL, ue_count);
+	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, NULL, ce_count);
 
 	return 0;
 }
-- 
2.34.1

