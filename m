Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89231C46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 16:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B4910E262;
	Tue,  3 Jan 2023 16:27:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7A710E26D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 16:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T67EsVfB7DChR4OukkT5t3rhewR1qCKQmi4gJWECjfalUQCKq4aDcHYO6SvTK56GPq6j3yGzUuzjv3nCunI907hCmEUJBx2bmj4gZ5780Xr2BKjaD8Ftz1tCvC4AiGory46WxVmnNBjeLX3vMHuCSWd+cpT5A7J/aV+4pWDa9/K8jK3lRC+pCsM0zZTspM56v4LfP9m4+AYgrOFJ0R+xi8G9976TNl51jdrJ374IRdxiJslRmTdUa6+Mueq94JKp1CAkIQ7qluAsCZo/KoTaqU6Gmxe5GOoFE7gaIEiAPxzgid0u8+b/iJ5u3oYiyXYvxm2JRRbI1flIzlIB3tLpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=794uk+bq7qWofYaf8I4V7LJx6mBw9g1kdZZvwiWLgho=;
 b=e9yuru22E7fOSg3IEwCyKpzR5AlwlOfqgebgzYOqbx26K4u3G6ZfuIYbCkJb+OPh8LMR/aTOU0urQb1ann0ShGWa/CODW81gZD5wp63M59KvmfKUT0zr4k3AHYQMdtymzo8VeK70eJIl9oxRrfVmfTQHh/k5GAhIiUhPo7DRCtSQ29WycN4zgPo0VT35ke35knXlFRWm7nTl0Osxy0ib5vvlj8r7y91i0tI7zxaNo4YvuM6FMGnLblRLo8w8ZSlX1dGtGgFQ87KtfCZ3UQnh8ZCpvT9fQsRrJYFBdF4hrt1yw4Pw+CGWkry662s2xGdT/wdSTPXmLs3rlM8BVsW64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=794uk+bq7qWofYaf8I4V7LJx6mBw9g1kdZZvwiWLgho=;
 b=5UUjDwrRyF1iBT/PcEMVcGhvR0Q0/OcJB99NmsOh0Sve6BqTgiyAPxQVUS+d7ERIOcQzP8vXNinAbtFcV3BVYEO9ILiPvwakVQGq0tWDFzIzsk4tR68CGNyyKUE6jotTCHLDa5EqYzvTFnFmYxEFLFDQUVeI7l1fzwSl5lerBw4=
Received: from DS7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:3b8::19)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:27:08 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::e6) by DS7PR03CA0014.outlook.office365.com
 (2603:10b6:5:3b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 16:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.18 via Frontend Transport; Tue, 3 Jan 2023 16:27:07 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 10:27:05 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: allow query error counters for specific IP block
Date: Wed, 4 Jan 2023 00:24:47 +0800
Message-ID: <20230103162447.30017-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: e0daf0f3-245c-4bf4-ed0e-08daeda75b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFGhv0rjATvZWo2T8/pxD2B+G71QPa1kn1731fvYkoSoTOvnWDhvB71M0zX0JH9i5L6Ub52xvvhSKr6nHtN/CFFdn2O2E+cPbBoabL1VDpfW+coyZTbi8BFl41PDxme1M6bOHYG7L2bX+4Y2JOYUmeNFWL6NwraciKtd1KWaeRUNprImb9HATIUVJoU17SQYn+A3PqkYiHrPrQq8h5oQhbTw4OcZvbVTYaa+F+8F2YczdnTNKa92c3/rQCAfZc3Gt0nY8GQv22uFuIou5g00BDdDgKRTc1xebiRZZag21RKeVR6hS/ZE+tJi5YSz47oiQ7UEBuskpJhvK3Rik3tP9fw2hrlRrCJQ+0aBmYDYHLRGd7bAVCTGykwukRzdYXbLAoo8taAPe5N9qsS7kbCbaHdDv09dcDRffoRAfJQfnbwpTJZ5JxPGC47KRvODiB4GnEu+AzdBTzektI9abpRgokoFU6vlpbKN1lc4AC5eR3xrDfK6TdoH78nW5Ax94Rup3PgQt9JIEzVVbpDB4C8oG6ReN6hedcyil1aw4M9HlTj3e4W1uB3mu9eu98LAcesJgaHge3N7mQc3Q5SajLGB94n9DzE50F507KRMgEdgcvRjYfvuVyv6EVJ6sIVsoTKBMVMTquDp6C5ogk5qlnZVwXc8ARvOl/8uU8sZnv8GqpEDxD/jt6hc/XWNg6e9X9IAxNU/yiScGuh3p85Upf1VNhaotFxNEk2Nk+EpMSxu3QJHPNyJ011l1O6eBVbxOEoPSjU6aETub9nCRKniXbjsXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(70206006)(186003)(1076003)(110136005)(26005)(70586007)(2616005)(16526019)(4326008)(426003)(478600001)(41300700001)(47076005)(5660300002)(83380400001)(8936002)(8676002)(336012)(2906002)(36860700001)(356005)(81166007)(40480700001)(6636002)(7696005)(316002)(40460700003)(36756003)(82740400003)(82310400005)(86362001)(22166006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 16:27:07.5210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0daf0f3-245c-4bf4-ed0e-08daeda75b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_ras_block_late_init will be invoked in IP
specific ras_late_init call as a common helper for
all the IP blocks.

However, when amdgpu_ras_block_late_init call
amdgpu_ras_query_error_count to query ras error
counters, amdgpu_ras_query_error_count queries
all the IP blocks that support ras query interface.

This results to wrong error counters cached in
software copies when there are ras errors detected
at time zero or warm reset procedure. i.e., in
sdma_ras_late_init phase, it counts on sdma/mmhub
errors, while, in mmhub_ras_late_init phase, it
still counts on sdma/mmhub errors.

The change updates amdgpu_ras_query_error_count
interface to allow query specific ip error counter.
It introduces a new input parameter: query_info. if
query_info is NULL,  it means query all the IP blocks,
otherwise, only query the ip block specified by
query_info.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 89 +++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 +-
 2 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 35b9f2ed2838..7fed63dc09bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1130,11 +1130,54 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_ras_query_error_count -- Get error counts of all IPs
+ * amdgpu_ras_query_error_count_helper -- Get error counter for specific IP
+ * @adev: pointer to AMD GPU device
+ * @ce_count: pointer to an integer to be set to the count of correctible errors.
+ * @ue_count: pointer to an integer to be set to the count of uncorrectible errors.
+ * @query_info: pointer to ras_query_if
+ *
+ * Return 0 for query success or do nothing, otherwise return an error
+ * on failures
+ */
+static int amdgpu_ras_query_error_count_helper(struct amdgpu_device *adev,
+					       unsigned long *ce_count,
+					       unsigned long *ue_count,
+					       struct ras_query_if *query_info)
+{
+	int ret;
+
+	if (!query_info)
+		/* do nothing if query_info is not specified */
+		return 0;
+
+	ret = amdgpu_ras_query_error_status(adev, query_info);
+	if (ret)
+		return ret;
+
+	*ce_count += query_info->ce_count;
+	*ue_count += query_info->ue_count;
+
+	/* some hardware/IP supports read to clear
+	 * no need to explictly reset the err status after the query call */
+	if (adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 2) &&
+	    adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 4)) {
+		if (amdgpu_ras_reset_error_status(adev, query_info->head.block))
+			dev_warn(adev->dev,
+				 "Failed to reset error counter and error status\n");
+	}
+
+	return 0;
+}
+
+/**
+ * amdgpu_ras_query_error_count -- Get error counts of all IPs or specific IP
  * @adev: pointer to AMD GPU device
  * @ce_count: pointer to an integer to be set to the count of correctible errors.
  * @ue_count: pointer to an integer to be set to the count of uncorrectible
  * errors.
+ * @query_info: pointer to ras_query_if if the query request is only for
+ * specific ip block; if info is NULL, then the qurey request is for
+ * all the ip blocks that support query ras error counters/status
  *
  * If set, @ce_count or @ue_count, count and return the corresponding
  * error counts in those integer pointers. Return 0 if the device
@@ -1142,11 +1185,13 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
  */
 int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 				 unsigned long *ce_count,
-				 unsigned long *ue_count)
+				 unsigned long *ue_count,
+				 struct ras_query_if *query_info)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 	unsigned long ce, ue;
+	int ret;
 
 	if (!adev->ras_enabled || !con)
 		return -EOPNOTSUPP;
@@ -1158,26 +1203,23 @@ int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 
 	ce = 0;
 	ue = 0;
-	list_for_each_entry(obj, &con->head, node) {
-		struct ras_query_if info = {
-			.head = obj->head,
-		};
-		int res;
-
-		res = amdgpu_ras_query_error_status(adev, &info);
-		if (res)
-			return res;
+	if (!query_info) {
+		/* query all the ip blocks that support ras query interface */
+		list_for_each_entry(obj, &con->head, node) {
+			struct ras_query_if info = {
+				.head = obj->head,
+			};
 
-		if (adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 2) &&
-		    adev->ip_versions[MP0_HWIP][0] != IP_VERSION(11, 0, 4)) {
-			if (amdgpu_ras_reset_error_status(adev, info.head.block))
-				dev_warn(adev->dev, "Failed to reset error counter and error status");
+			ret = amdgpu_ras_query_error_count_helper(adev, &ce, &ue, &info);
 		}
-
-		ce += info.ce_count;
-		ue += info.ue_count;
+	} else {
+		/* query specific ip block */
+		ret = amdgpu_ras_query_error_count_helper(adev, &ce, &ue, query_info);
 	}
 
+	if (ret)
+		return ret;
+
 	if (ce_count)
 		*ce_count = ce;
 
@@ -2408,7 +2450,7 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
 
 	/* Cache new values.
 	 */
-	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count) == 0) {
+	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, NULL) == 0) {
 		atomic_set(&con->ras_ce_count, ce_count);
 		atomic_set(&con->ras_ue_count, ue_count);
 	}
@@ -2589,6 +2631,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras_block_object *ras_obj = NULL;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_query_if *query_info;
 	unsigned long ue_count, ce_count;
 	int r;
 
@@ -2630,11 +2673,17 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 
 	/* Those are the cached values at init.
 	 */
-	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count) == 0) {
+	query_info = kzalloc(sizeof(struct ras_query_if), GFP_KERNEL);
+	if (!query_info)
+		return -ENOMEM;
+	memcpy(&query_info->head, ras_block, sizeof(struct ras_common_if));
+
+	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, query_info) == 0) {
 		atomic_set(&con->ras_ce_count, ce_count);
 		atomic_set(&con->ras_ue_count, ue_count);
 	}
 
+	kfree(query_info);
 	return 0;
 
 interrupt:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bf5a95104ec1..f2ad999993f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -540,7 +540,8 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev);
 
 int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 				 unsigned long *ce_count,
-				 unsigned long *ue_count);
+				 unsigned long *ue_count,
+				 struct ras_query_if *query_info);
 
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-- 
2.17.1

