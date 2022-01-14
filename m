Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2797C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0652910E155;
	Fri, 14 Jan 2022 03:36:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F0010E155
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9eSikqYRU0mRiaHSGiDeuIcOlpd/oE1fZ9KVSd9pw2i9rVDR8KWN/IV69t0Xr4NgIpruHxaw89VjQwe1zKaSPeTtqdXyvc1mXcXxi9Cv0II4axzPCAS327rn1N/qKfiTEBJJL2W5nvtROHNWKEWNIbLTfCVxXq7Pc7/6OsowpiuwbH1YAP28wb/BDoPvXUP4aOlwkv6XWz03e6xHXGxQD1ckCpLfQRQ3j+hwyxXnkbnGbhOuM//pfITIcnkC2KYN60bTg9BHdt9nrk/ewgA2AoKH7G5WklTZHxkwsNZW1odbF1Hf53VnvaRudHVqGzR0fWDwsxYkTvi3bayaO7SVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrJtvs1M7DbA6okK/MU7IQ97gzVKjtKjIjxsyMZ3dRo=;
 b=c89OaWLX/Z4/vDeYw9kJoN5Vgw8OAxVLw5nUl0WSNeh3rqkt2SmpuxY1Gp5cG5bakTUIhwWnHNc1sV5wLVarh5MWDPiJESjzpNDNrZujW97WJHXMnrr9vkU/GyRzNAWdRDXKnOFtea04OTUVt12C6TMkdzp3KWRrpiATxKmSQYzg+MgsDkcozCAU8XCirIG925uIyzIZXSyrqgkv+GAOWYLKvjyLYj9f4hyQeDk0fYwjvM3AcTzW3DqdQ7UY57kCDoX2BeV/3hIgxhMHvJP9MegCDQwHjbWztrI4PnES98FVgE2isbKTV3qHwds+DeVoSMRWSoAmKlEg1LCfav/oJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrJtvs1M7DbA6okK/MU7IQ97gzVKjtKjIjxsyMZ3dRo=;
 b=i+RP9I4EqdD1nwCEjaX45Ll6FR0En+EKiEEKpFR+AvY++6hmZTscYQWn7tA3EC/VQZ6mMaljlyD4vtVv2mCaCqiAT1r0/kwiG4QvwU7Y484mSvZ8Fz8ZiC5BIc6k+WlpdbWUsQ9RjdNZi+XnmaNZZAgaQJOuTRMnmdjsMSidLFk=
Received: from BN0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:408:e5::12)
 by BY5PR12MB5527.namprd12.prod.outlook.com (2603:10b6:a03:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 03:36:36 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::65) by BN0PR02CA0037.outlook.office365.com
 (2603:10b6:408:e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 03:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 03:36:35 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 21:36:33 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: Fix the code style warnings in amdgpu_ras
Date: Fri, 14 Jan 2022 11:35:55 +0800
Message-ID: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25777ba7-ba55-4333-ec35-08d9d70f1110
X-MS-TrafficTypeDiagnostic: BY5PR12MB5527:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5527DB95F8A22B3A3FDC5EBAFC549@BY5PR12MB5527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+1YSGiKQFX/IfnBZzw71y88JfSt90xI6dbjbDRmRlLWsuCNdYVai5Kb+LuJlhTwBgNsiqMTmmZvjMNER0Z4XFzfHgmQYBXzXPgcJ3y9yNqe/acEiNXw1EhDI9YoGbXAl+v1O2qwVwWarwwdkuNs+OnhFqEnpP75qrBGMlMVaDkvkxh+iSMFZb2GkSwuaMimQhHpYGbCr7o7hZUBMn6Ho7L3w2ck5+cwGYtTBGk37Tk2xPkdis2F9GWm1FIiw1kIHTs14B5AfMpVXmUA8yLpHLDYGU35wrwJxQmRA++jBxurk4+yJvLfDPiMMCpPNX1PByHiDGviRnG4SAgbI52zD5FnADGQMy9arP+j2YW6IAYf2N0C9dzQ+XqVDaELqtGHfIQ7Va6CJwKIvD25SRuuJRFymicFilJj2cmMAHQbgO7AQnpKo3s6BuO6dnkkx1U/cLs3g4JH1wOAScfNuYbJeLZXbtXMn7R9h8P1NOytvPra+rMA7hwIs94AQ/lUJzml0tDdODTX65SNc0/9RmM6H/I+hQs3Hsxvysa15TZp1lCjmsqgQwvG7upxYVit6fmKm3kUvcClbseO1aX0qEKQZn4+WnMm708ZLjE+MC306ZcraqHdeJrrnMcTi98cdd+4/Pp6zUm4fB7cTOQ3ItMWrE3lpSh+TCjyLRBPYiqxb1Cd0zZoZai469lOwu1b6o9QucnT+5jnrAMKRYzwGCrOEMyt5x+SilsaMih49vq0D6LDiwjAyFIQZvyFH+NSIyfy+T6OF3TF5Hmtcr408C/PhgC+QpQPzC+ShwZH1wze2zknwhZi0cx+dTKll/oZ2MGY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(316002)(54906003)(47076005)(508600001)(5660300002)(2906002)(7696005)(6666004)(36860700001)(426003)(70206006)(70586007)(356005)(2616005)(81166007)(6916009)(16526019)(40460700001)(1076003)(336012)(8936002)(186003)(8676002)(86362001)(83380400001)(82310400004)(4326008)(26005)(36756003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 03:36:35.9970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25777ba7-ba55-4333-ec35-08d9d70f1110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5527
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the code style warnings in amdgpu_ras.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 +++---
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0bb6b5354802..23502b2b0770 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -872,7 +872,7 @@ static int amdgpu_ras_enable_all_features(struct amdgpu_device *adev,
 static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object *block_obj,
 		enum amdgpu_ras_block block)
 {
-	if(!block_obj)
+	if (!block_obj)
 		return -EINVAL;
 
 	if (block_obj->block == block)
@@ -881,7 +881,7 @@ static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object *block_
 	return -EINVAL;
 }
 
-static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
+static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
 	struct amdgpu_ras_block_object *obj, *tmp;
@@ -941,7 +941,7 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 				  struct ras_query_if *info)
 {
-	struct amdgpu_ras_block_object* block_obj = NULL;
+	struct amdgpu_ras_block_object *block_obj = NULL;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 
@@ -953,7 +953,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	} else {
 		block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
 		if (!block_obj || !block_obj->hw_ops)   {
-			dev_info(adev->dev, "%s doesn't config ras function \n",
+			dev_info(adev->dev, "%s doesn't config ras function.\n",
 					get_ras_block_str(&info->head));
 			return -EINVAL;
 		}
@@ -1023,13 +1023,14 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
-	struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 
 	if (!amdgpu_ras_is_supported(adev, block))
 		return -EINVAL;
 
 	if (!block_obj || !block_obj->hw_ops)   {
-		dev_info(adev->dev, "%s doesn't config ras function \n", ras_block_str(block));
+		dev_info(adev->dev, "%s doesn't config ras function.\n",
+				ras_block_str(block));
 		return -EINVAL;
 	}
 
@@ -1066,7 +1067,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	if (!block_obj || !block_obj->hw_ops)	{
-		dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
+		dev_info(adev->dev, "%s doesn't config ras function.\n",
+					get_ras_block_str(&info->head));
 		return -EINVAL;
 	}
 
@@ -1702,19 +1704,25 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 					  struct ras_query_if *info)
 {
-	struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
+	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev,
+									info->head.block,
+									info->head.sub_block_index);
 	/*
 	 * Only two block need to query read/write
 	 * RspStatus at current state
 	 */
 	if ((info->head.block != AMDGPU_RAS_BLOCK__GFX) &&
 		(info->head.block != AMDGPU_RAS_BLOCK__MMHUB))
-		return ;
+		return;
+
+	block_obj = amdgpu_ras_get_ras_block(adev,
+					info->head.block,
+					info->head.sub_block_index);
 
-	block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
 	if (!block_obj || !block_obj->hw_ops) {
-		dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
-		return ;
+		dev_info(adev->dev, "%s doesn't config ras function.\n",
+			get_ras_block_str(&info->head));
+		return;
 	}
 
 	if (block_obj->hw_ops->query_ras_error_status)
@@ -2715,7 +2723,7 @@ static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)
 }
 #endif
 
-struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
+struct amdgpu_ras *amdgpu_ras_get_context(struct amdgpu_device *adev)
 {
 	if (!adev)
 		return NULL;
@@ -2723,7 +2731,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
 	return adev->psp.ras_context.ras;
 }
 
-int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras* ras_con)
+int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con)
 {
 	if (!adev)
 		return -EINVAL;
@@ -2755,7 +2763,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 
 /* Register each ip ras block into amdgpu ras */
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
-		struct amdgpu_ras_block_object* ras_block_obj)
+		struct amdgpu_ras_block_object *ras_block_obj)
 {
 	struct amdgpu_ras_block_object *obj, *tmp;
 	if (!adev || !ras_block_obj)
@@ -2766,9 +2774,8 @@ int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 
 	/* If the ras object is in ras_list, don't add it again */
 	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
-		if (obj == ras_block_obj) {
+		if (obj == ras_block_obj)
 			return 0;
-		}
 	}
 
 	INIT_LIST_HEAD(&ras_block_obj->node);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7a4d82378205..a51a281bd91a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -496,7 +496,8 @@ struct amdgpu_ras_block_object {
 	/* ras block link */
 	struct list_head node;
 
-	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index);
+	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
+				enum amdgpu_ras_block block, uint32_t sub_block_index);
 	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
 	void (*ras_fini)(struct amdgpu_device *adev);
 	const struct amdgpu_ras_block_hw_ops *hw_ops;
@@ -504,7 +505,7 @@ struct amdgpu_ras_block_object {
 
 struct amdgpu_ras_block_hw_ops {
 	int  (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,void *ras_error_status);
+	void (*query_ras_error_count)(struct amdgpu_device *adev, void *ras_error_status);
 	void (*query_ras_error_status)(struct amdgpu_device *adev);
 	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_error_status);
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
@@ -678,7 +679,8 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
 
 struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 
-int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras* ras_con);
+int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
-int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct amdgpu_ras_block_object* ras_block_obj);
+int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
+				struct amdgpu_ras_block_object *ras_block_obj);
 #endif
-- 
2.25.1

