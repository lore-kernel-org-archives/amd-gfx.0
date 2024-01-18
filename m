Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37627C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 06:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC24E10E148;
	Thu, 18 Jan 2024 06:44:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC4610E145
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 06:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKhoLGE7kjl1PEQ0PLgSu8Lz/FOMnorNszkf4s/ZsQLIzzz16u6gsYZ1SBYzqqzY2bc3XTVPVeQK2bZGIn8eQNzOGI1uAS7bzmpFSVSEKG2GstRtp1aB6OrLYFHzysmkjEQvTYihsSSCkITdEeixTxFHE77Mm3gMY7kwehJ4s4rN2VVrISiZYnj9OvsHdGChQdSCoySdZE3rgxT+1VRdN5ApANe+/t1dnm9hIkgE3r8nitCpYwu5TCi8ttwagxF7+8OCy2D0RyfENHVKVaPyYkUShsoXi8aiyhXpnwP6QoqV6RxQIACaHpfl3ZS04bhVqiwOAWtXfJKaQvrCNAb6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2Xn9FRydGiel3UHjzJTjRtEw59243jQniTKRxerRZI=;
 b=PnnkKvwKB51rvI2NUl1mM+XBFwrDzTHLNgBmWNqOJZmEfsmUp8vwI0bpn28M/naGxP1LZtYHjWp1M3ijj6LII9j5KyzNc516ztIHKVer5mLMccsrKa9pIbRUx0rBN4EcE0+j325b5QmdPNiniq6FpKIAsG3Wv+XWFxy4fUhOyD7AIb3I62sqiS45WLSsQEvjNM3KxwHuWdb7IvlEgQY16dnAJDyWxIFA5O9GhyDDpj9PzgJmXORINjLIX6FWUPkyuExT8+YoPKNeJMpYsdCA6/TgHkP4gesg418Mct98VyjVMFyNzEJIlXOeAFPYQHdrckbLsxBYc7Z2zM+KgKtmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2Xn9FRydGiel3UHjzJTjRtEw59243jQniTKRxerRZI=;
 b=Mx4dtp0UX0HcjQk1foW2XHYOmzcxQDCf0sYfGrPNPPw+uoLv3nN1TPXimEwmI95gUpsZe+xT1EYRPTO5TsGH6OHTXjdwzsxFHUnSSErFg885ghThkkccOUGVrG4w3V1uQun+dxAcNMcWhWvqtaY4Di51wwLEUC2oL+oB9+DnfpA=
Received: from SN1PR12CA0058.namprd12.prod.outlook.com (2603:10b6:802:20::29)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 06:44:02 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::db) by SN1PR12CA0058.outlook.office365.com
 (2603:10b6:802:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 06:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 06:44:02 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 00:43:59 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/5] drm/amdgpu:Support retiring multiple MCA error address
 pages
Date: Thu, 18 Jan 2024 14:42:57 +0800
Message-ID: <20240118064257.1951585-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
References: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: ef276f5e-4362-40d8-fc5d-08dc17f0dbbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIiTFgDrOXyEohORirG6kqp4iTIsIi9nUGJ44fTCr5QuJdJRz8Av+5GVdcvKOc5Ny7arcfy17S8GzHzc6X2m3Fdb5GF3EAHLorKeG4aKFDIL8AzV51QgphTv8KzKMlqpCXN8IjDZWU6IvrrlQcbBpSbU1R7sTf2BfM9bWKd12A1MW4wfJ7SB6iAkUKcy5T7iBBTXzCh5IV8f0ophCY6RJ7HLJjLtl4UryLgt8jNxcseT23psmEPqGEE3BcSKMYu449tHW5+7liKiTA+WxrKin9SdZHZ2a5A79qC7yn+H/hIXGLMYbVr/fZ11DuVai8B/vRJ2waS/+Zufm0ebvjiW0/3o9LUjwHQjVRHCpOMRCOxU708zJaHxtO5Ou/y1552LcUAf4X39JERj4m2/3bgRxZLpHZ/iQvi9FidkRT5Oi5djBjqsRu3evwwhUROJGARfVenfmLF9Ppbeqp0QlUIXCdM+KqnAK+pXqFUlBtAokpbR+iFII6XQohFeggrciAeacvvimJ5BWzUkIVEttAb50Muzn15AG27aSr/o/Bz61UIM6GOEgnghZEdQQHyBDdGSCvYjqqUqRARyczyVeLBHKjCoAyIxQo1mAl14R8Z833hHtKQ2AoV4LtL/Z/e6DZuEOhE+FYt/Gsf4MJaiBP4+8w0AHeQQcqBGfHsANgFtkN6USt65YDTxe6qGNPxJsgyzgyu0V5GdoodqAAmrahaD/7kBh6f3l8FecpWAhMZcmDq12Ptk1fm2hZmmaKq9jzFpoIjdAp5oqEEPLiV0Waz4SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(4326008)(26005)(426003)(5660300002)(2906002)(336012)(7696005)(16526019)(2616005)(6916009)(316002)(70586007)(70206006)(8936002)(1076003)(8676002)(41300700001)(86362001)(478600001)(36756003)(36860700001)(82740400003)(356005)(47076005)(83380400001)(81166007)(54906003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:44:02.5524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef276f5e-4362-40d8-fc5d-08dc17f0dbbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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
index 61a02dbac087..879e1e59ac76 100644
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

