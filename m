Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B956C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 05:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9FC210E157;
	Fri, 14 Jan 2022 05:34:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FCE10E157
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 05:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC2dTXHjvVYaS2mkra3BdnslEQhB6/hSZgVG2b6kfW8RAGBJhihuSNyCyg0YT1SE46TBtOZyV9lWszR6uvc3axEj86IZcIdmO+AIWjOQF+AsdjHxNV3jt8dy+JtMzjAWqmFzQz0RdiIJmXs4mrD2DjSIv+SlCv/fEvumNFXRfjem5fGKvMbGi2wzkebonw76wpgLXIeRLhwIObnwFmSv+ea8PB9v0v8Nih88nhATMpgE7rzEehYU+vHcwBtx3NF3TECi4LWq8VtmMNwqY8NgwG/BS5u2bmMfdO9tWpUugnpWti09oJFBxH+hfQ1jKHzxo9AS9PYhs08AZqbuPgFeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xRIc8goKafmds5PuNgBwOSVdzN9PwzlvIKcSUoxMCc=;
 b=ds3HtVDfT6EDtmeGjx/jXbeO6DS78rI8FrV/rl5epjl/fR4CdRtQ5mQUkknI1MufzNSGkyjpe0PswYiuA/cGM74Z/Dwrrv6LFXuw0Yn0d7KOMpCWM+qIZUXwQ5mAYIfesMbVog4KDS3CWTIs1vxs8RZbLcGEwuaxm5cN08T3kFg5jq0vrQyxQXEOvNCwYgpvq0nKFcrMoWKbaNZpU7XGflYl1FWDnLR63X/exZkbCw/DMAC2BHkoek3dQEI3v4MF4mm6ieBP0+/wMrIXRQHw5Bymbve5Zgbg0lfZUWEWBUCrV5wb49QqghVTNK7vvMZAhaHXT0168Gdax08+QrZW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xRIc8goKafmds5PuNgBwOSVdzN9PwzlvIKcSUoxMCc=;
 b=2dyqO9eJ/3hQ7y8DRmX+PdW8gSRrTlBBBtReNXEfG7hgV+lw3AkK13p2MhLNi+HpI/SOf8pX/jwopOFgO4S8vUDnPgcfTcoSJ+4+B6noGkufrOTnNfItSlrQFLWKqp6YdxM3D001Tq13swpH0BQpI4DrNZk4o2xGgyK7wq80LSA=
Received: from DM6PR11CA0058.namprd11.prod.outlook.com (2603:10b6:5:14c::35)
 by BN6PR12MB1635.namprd12.prod.outlook.com (2603:10b6:405:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 05:34:52 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::72) by DM6PR11CA0058.outlook.office365.com
 (2603:10b6:5:14c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 05:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 05:34:51 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 23:34:48 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/5] drm/amdgpu: Fix the code style warnings in amdgpu_ras
Date: Fri, 14 Jan 2022 13:34:03 +0800
Message-ID: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b9609ae-54a8-4317-9178-08d9d71f9679
X-MS-TrafficTypeDiagnostic: BN6PR12MB1635:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB163569D98E0AD64C9057D862FC549@BN6PR12MB1635.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSYYB+YZPSXXzeaebcXAygrToM0n+cNNDriZs3twnBaGBzDs/gTWgPmxq/Iu7cGDxDM3BSkyvEI1H4ihRkppPwqKmxOAgUv/FTfSk9GngOY3vn/19oncqN3UwxAGkBJSykgh8ECIr+vF9x1lkiScXloTuyjmWttzCwoFhuB5qYcNhmD7pl9NqayA/E3kUrd+nUuVIhIjQdjGtlI+yfpWq1STaqU1Hwy4hdWRfxnROcbFjbzX26yv5v3oaH8oSDQUO67ivI5jJbJrKNJtLC7aYnCH3eY5QgF/qOHU4yuqC2fpzOpPn/+fOFCQl/qPRPJ6V/dhSI0h7urQxknJnX3TLzWEzWTJ0B/OIQmsMlbbm776sTfdi36IAmyVQQGO320AEnosAZlPnyFaeupSnMb8bf1cmu0wktfhS9TDDwlMEX5ZXXRnYQonTQZAyZL/EuAF7Y9eM/0RkhxcqFGFNQi7PelAYUedIyu90lmch/o6ZiJHA7/MRtsZ/B40VZlOiFUsqID/X41ZI4Hdqtq+d7TIGD9n9RPGn3K6nSeD1VF2kmN/eJ6pTRYLdU1AZHRbVCZgGHvj0SmY/YaSgMAzsYPZF2XUzLF9DB7EowpGdQtvShpAN0j9noA+UZoJgnx342zxEIxapHTm1RhPyKEaYR0kjDhIHaOZAJBLZDCCkweC86EmoP74verr7RTLhTdhN8ypwTyUMilQUnZSyWveggtI58D13r+AA0c0OAtfv5ZvZY/0XXBr5JpYqViXi7Qy4iJFN1KUwO5AgYA7qMX4x0hm0LAePpQSWShF27XYtvzoF4+xirl9/68teF0QIUvJFwshlqHMyYtFsG7o10hwmaT0aKZKT5xZ24a/Hwe+eoKkE7I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(6916009)(83380400001)(16526019)(26005)(186003)(5660300002)(336012)(81166007)(316002)(7696005)(8676002)(82310400004)(36756003)(70586007)(1076003)(40460700001)(86362001)(8936002)(36860700001)(47076005)(6666004)(54906003)(2616005)(426003)(4326008)(356005)(2906002)(70206006)(508600001)(43062005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 05:34:51.7362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9609ae-54a8-4317-9178-08d9d71f9679
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1635
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

Fix the code style warnings in amdgpu_ras:
1. ERROR: space required before the open parenthesis '('.
2. WARNING: line length of xxx exceeds 100 columns.
3. ERROR: "foo* bar" should be "foo *bar".
4. WARNING: unnecessary whitespace before a quoted newline.
5. WARNING: space prohibited before semicolon.
6. WARNING: suspect code indent for conditional statements.
7. WARNING: braces {} are not necessary for single statement blocks.

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

