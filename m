Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA57AC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 08:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5580E10E440;
	Tue, 16 Jan 2024 08:21:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4123410E446
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 08:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7AM1YUPb/BJDTXaMphtK+5Svl5JhwoLBbtJoAUAI+c3CBEttObtAStgdVBhATP8cAkkSvKwd7XCi6cNewwPVhgeeh/LGIxZIAuN4u6kPyT/oOTlGs3gwiLzNo8E/2LR3h2oWOffIfkbQeNFQQm5izNz9aPiA9cRe32R/m1PlG7Bi6PUnp6nuSTkukMxX/JiNwk1UqkMc9UHbvqDyV4mZRJ9cElZW5nLd2G0oeOqvrNNmzSD5uR1V6iQvpEGTMLrzwI8OHq+1NvuVUnJdBQQutMXb4P72oaBRhJsU9dKMwx9m3IbFVKyLQCTBNmWauFkqsxUN/U8t+l7IXNU1DDqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UULkAtEge4+uj83JzvIFdcZmw7bq0Wzu/JgiqNnMhNI=;
 b=WBu9eq/XEkLp6bxXPYpCbgWakFhYIfjihRUpi4Z9G++6ifzDSm9pPFeW59Atn2GCGRA1hu+LYjkgkdH1idifS7uVWW64h8QvXgAD+Xv8qEd5LzAjMHFdm5mU4U2dAzr47wDYIDYIL0JkCPvnwm6cGGEbzZDzwZ/CM4QRbsii291oP2yWLlHsnnRRHY8zrPknD/skg9sxA1z0scPHCLzVsscExedm+0WYkYSy/PwCaLFawj6aklbJS+jf/eYfRimXtSURA/gEBQUnmx6y0NpXCYenMGV+xP5hTMI0N/KMEexQExMaJXAMpapx6wCUQuemABE8WQelVreQ0A6VhZEhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UULkAtEge4+uj83JzvIFdcZmw7bq0Wzu/JgiqNnMhNI=;
 b=0f+EJtsCPppjGHIS2lIz6urN3jsFPXNxwuk3/uw8u4UWrCbbL1DsoeNR/64r5OZP4dgzKO+8C+iJ1S+QFAA9aXXkbVn4KIeY8xlu/qvSS2hTW6wgKWTU+ImUCkhMyIhU+wTIqAYmOM58fEqOPMOCNzevMwh9O/ezxKxgReIZbog=
Received: from MN2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:208:178::17)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Tue, 16 Jan
 2024 08:21:21 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::4b) by MN2PR19CA0004.outlook.office365.com
 (2603:10b6:208:178::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Tue, 16 Jan 2024 08:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 08:21:21 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 02:21:18 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu:Support retiring multiple MCA error address
 pages
Date: Tue, 16 Jan 2024 16:20:34 +0800
Message-ID: <20240116082034.1739848-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 589440bb-c094-43a4-fdc3-08dc166c1f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wgZoWu7wid5SbN8W41BMO6XCIXXqGQPpEIq4f4ZTxvV8AhF3cuBtilCMASXeB5nyprD/A5r8rxhKSxMKSDaZEUqavq2oIf6JzFXrQwJiQBUlcNeStjJ387WS6SJnB6r5H44grv7TpVNjHv+CetmPjaDw+Ydxr/qqWy8yQJoq1DletWjfdWE5nl6WC8A6/bfle/DpqS88ngEg/WvEEUcczAPTTy53KY4fpDdkKcY9ynRjiMS+NGyxAEH7Bn28MKJIKVTtI1vh+Uc6oqFhcwVV9Au0+YEHh6jQfArKupRboghkRoHYwT2D39QvPf0LBmxHMkxqGxHfl471qZ/LiH5Dgkp6Ko4qu35kQHJ68wULr0vxtOMw8c+Ii65kHxJJp1btRIeTnuJr155OIBn6AAuyCcMYhenODKHhRAJ9XF1pOwhPqp2QmkB3w+xWU13FEW/fmHoffpqqqTZ7tK+IbtYHtpxxFKwNpWmt2wf+SyEga7aStcPeMm9a8f1M/EzWhRvEemr8jL01xIbTPjHIbmqgnMTx6JlJgtEYIo+fhdLwvCZIePWceahfKVJGWj3tSmtcfFSXGjL9zcvrqGkekpcN5sIT2SeLhNlGth6EYfbzRAjfBk9EzEDGNjqd3T9+umSbB6DQEAHsvPdhU7nPTuKt+oAxJzzsjTXqF2kv6QbUmtKHZqb3ZbfUORjvHmrpEJ8l43XOJlZnPRzzgKdaF8ZmOJl1JA4bSF70/h79Q93pQtKS63VDPVlw+j9y9rRsNcRm7ezPfEqehsR63C0MsiZSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(36860700001)(1076003)(26005)(2616005)(7696005)(336012)(426003)(5660300002)(316002)(70206006)(8676002)(54906003)(8936002)(70586007)(36756003)(16526019)(6916009)(4326008)(6666004)(2906002)(478600001)(47076005)(83380400001)(41300700001)(356005)(82740400003)(86362001)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 08:21:21.2457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589440bb-c094-43a4-fdc3-08dc166c1f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support retiring multiple MCA error address pages in
one in-band query for umc v12_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 ++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 66 +++++++++++++------------
 3 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 44929281840e..75962f4dfbcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3909,8 +3909,7 @@ static int ras_err_info_cmp(void *priv, struct list_head *a, struct list_head *b
 }
 
 static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_data,
-				struct amdgpu_smuio_mcm_config_info *mcm_info,
-				struct ras_err_addr *err_addr)
+				struct amdgpu_smuio_mcm_config_info *mcm_info)
 {
 	struct ras_err_node *err_node;
 
@@ -3922,10 +3921,9 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 	if (!err_node)
 		return NULL;
 
-	memcpy(&err_node->err_info.mcm_info, mcm_info, sizeof(*mcm_info));
+	INIT_LIST_HEAD(&err_node->err_info.err_addr_list);
 
-	if (err_addr)
-		memcpy(&err_node->err_info.err_addr, err_addr, sizeof(*err_addr));
+	memcpy(&err_node->err_info.mcm_info, mcm_info, sizeof(*mcm_info));
 
 	err_data->err_list_count++;
 	list_add_tail(&err_node->node, &err_data->err_node_list);
@@ -3934,6 +3932,29 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data *err_d
 	return &err_node->err_info;
 }
 
+void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info, struct ras_err_addr *err_addr)
+{
+	struct ras_err_addr *mca_err_addr;
+
+	mca_err_addr = kzalloc(sizeof(*mca_err_addr), GFP_KERNEL);
+	if (!mca_err_addr)
+		return;
+
+	INIT_LIST_HEAD(&mca_err_addr->node);
+
+	mca_err_addr->err_status = err_addr->err_status;
+	mca_err_addr->err_ipid = err_addr->err_ipid;
+	mca_err_addr->err_addr = err_addr->err_addr;
+
+	list_add_tail(&mca_err_addr->node, &err_info->err_addr_list);
+}
+
+void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info, struct ras_err_addr *mca_err_addr)
+{
+	list_del(&mca_err_addr->node);
+	kfree(mca_err_addr);
+}
+
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 		struct amdgpu_smuio_mcm_config_info *mcm_info,
 		struct ras_err_addr *err_addr, u64 count)
@@ -3946,10 +3967,13 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 	if (!count)
 		return 0;
 
-	err_info = amdgpu_ras_error_get_info(err_data, mcm_info, err_addr);
+	err_info = amdgpu_ras_error_get_info(err_data, mcm_info);
 	if (!err_info)
 		return -EINVAL;
 
+	if (err_addr && err_addr->err_status)
+		amdgpu_ras_add_mca_err_addr(err_info, err_addr);
+
 	err_info->ue_count += count;
 	err_data->ue_count += count;
 
@@ -3968,7 +3992,7 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
 	if (!count)
 		return 0;
 
-	err_info = amdgpu_ras_error_get_info(err_data, mcm_info, err_addr);
+	err_info = amdgpu_ras_error_get_info(err_data, mcm_info);
 	if (!err_info)
 		return -EINVAL;
 
@@ -3990,10 +4014,13 @@ int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
 	if (!count)
 		return 0;
 
-	err_info = amdgpu_ras_error_get_info(err_data, mcm_info, err_addr);
+	err_info = amdgpu_ras_error_get_info(err_data, mcm_info);
 	if (!err_info)
 		return -EINVAL;
 
+	if (err_addr && err_addr->err_status)
+		amdgpu_ras_add_mca_err_addr(err_info, err_addr);
+
 	err_info->de_count += count;
 	err_data->de_count += count;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 9c3df9985fad..a25aea6ae230 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -474,6 +474,7 @@ struct ras_fs_data {
 };
 
 struct ras_err_addr {
+	struct list_head node;
 	uint64_t err_status;
 	uint64_t err_ipid;
 	uint64_t err_addr;
@@ -484,7 +485,7 @@ struct ras_err_info {
 	u64 ce_count;
 	u64 ue_count;
 	u64 de_count;
-	struct ras_err_addr err_addr;
+	struct list_head err_addr_list;
 };
 
 struct ras_err_node {
@@ -856,4 +857,9 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
 				  struct aca_handle *handle, char *buf, void *data);
 
+void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info,
+			struct ras_err_addr *err_addr);
+
+void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info,
+		struct ras_err_addr *mca_err_addr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 1e8e97d72f1e..f9dc1855ac4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -385,42 +385,46 @@ static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 {
 	struct ras_err_node *err_node;
 	uint64_t mc_umc_status;
+	struct ras_err_info *err_info;
+	struct ras_err_addr *mca_err_addr, *tmp;
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 
 	for_each_ras_error(err_node, err_data) {
-		mc_umc_status = err_node->err_info.err_addr.err_status;
-		if (!mc_umc_status)
+		err_info = &err_node->err_info;
+		if (list_empty(&err_info->err_addr_list))
 			continue;
 
-		if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status) ||
-		    umc_v12_0_is_deferred_error(adev, mc_umc_status)) {
-			uint64_t mca_addr, err_addr, mca_ipid;
-			uint32_t InstanceIdLo;
-			struct amdgpu_smuio_mcm_config_info *mcm_info;
-
-			mcm_info = &err_node->err_info.mcm_info;
-			mca_addr = err_node->err_info.err_addr.err_addr;
-			mca_ipid = err_node->err_info.err_addr.err_ipid;
-
-			err_addr =  REG_GET_FIELD(mca_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
-			InstanceIdLo = REG_GET_FIELD(mca_ipid, MCMP1_IPIDT0, InstanceIdLo);
-
-			dev_info(adev->dev, "UMC:IPID:0x%llx, aid:%d, inst:%d, ch:%d, err_addr:0x%llx\n",
-				mca_ipid,
-				mcm_info->die_id,
-				MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
-				MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
-				err_addr);
-
-			umc_v12_0_convert_error_address(adev,
-				err_data, err_addr,
-				MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
-				MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
-				mcm_info->die_id);
-
-			/* Clear umc error address content */
-			memset(&err_node->err_info.err_addr,
-				0, sizeof(err_node->err_info.err_addr));
+		list_for_each_entry_safe(mca_err_addr, tmp, &err_info->err_addr_list, node) {
+			mc_umc_status = mca_err_addr->err_status;
+			if (mc_umc_status &&
+				(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status) ||
+				 umc_v12_0_is_deferred_error(adev, mc_umc_status))) {
+				uint64_t mca_addr, err_addr, mca_ipid;
+				uint32_t InstanceIdLo;
+
+				mca_addr = mca_err_addr->err_addr;
+				mca_ipid = mca_err_addr->err_ipid;
+
+				err_addr = REG_GET_FIELD(mca_addr,
+							MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+				InstanceIdLo = REG_GET_FIELD(mca_ipid, MCMP1_IPIDT0, InstanceIdLo);
+
+				dev_info(adev->dev, "UMC:IPID:0x%llx, aid:%d, inst:%d, ch:%d, err_addr:0x%llx\n",
+					mca_ipid,
+					err_info->mcm_info.die_id,
+					MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
+					MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
+					err_addr);
+
+				umc_v12_0_convert_error_address(adev,
+					err_data, err_addr,
+					MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
+					MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
+					err_info->mcm_info.die_id);
+			}
+
+			/* Delete error address node from list and free memory */
+			amdgpu_ras_del_mca_err_addr(err_info, mca_err_addr);
 		}
 	}
 }
-- 
2.34.1

