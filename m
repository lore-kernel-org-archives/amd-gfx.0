Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46831C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 05:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BDE64E31
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 05:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BDE64E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFBF6E2A3;
	Tue, 23 Feb 2021 05:19:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC856E21C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 05:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+wj55dr4m6YGOYsbK6Wc3V3t/mCUIxFcYJ6lSQPvLNR+WT7yE4+JWkr3rzkZywOtI2zkTcamKlVWD0c0xqFsAenji66yqOrxDQXbTZZjcBJFpikAbeyNIBpM5JX98CMpKF8vahw2bpOn93Q7gBJbFH+guJt/knHZ+XMgxVcCWxRHxhxi81v9j44wKrvCqzYYxg041GCEIxZtM3Usuf+PrPPEXnFu/D62NO9ho/vquV1nPE8TZSmxzfJd+c0U/12GGYo50+81qjb+/xcMrMvLyC7webwspJgsNb+T8CEv27FEYjXl0Es/RFw5WzLqHmOvgbJYAWpwVWNLH7lbsoB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38K4psjN+fK4fzEiOdfkiGkHCOiYJgbKknlrmpcHvd4=;
 b=fSId4iQffLJeyf/L5nGeao3LFZdMVNoZCD0YIUDkRs0h/vPj1tQKj8FZUUaCh70Z0D/7pB6BwAaO3RkuRHG6aalQo/NoLfC0Q2VBY2eQrsqxbDwuVeT2CPNhwMOKr1uKHA0XjfRlm7rb4IRrLjShXHYiECJeDU3frpywZ4dCIIBH3gLqO7fytbIw+HePi2tkT1qlA4Dte+c7DpFMU5lKQz0rAFbJWCZhk6aJkh93L5nlPZPEQjbC844pIZ6RG/5ZQHjgMZhafYImTkEI8Wqssc7PtIglkvPOJhKO2qz6vYdaoJ03rCmRAzRug20RDm4B9OxNXHzWOIJmK1bWS0IX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38K4psjN+fK4fzEiOdfkiGkHCOiYJgbKknlrmpcHvd4=;
 b=oXCO7jB3BuGq3mC053c4txPhyCjcwzKiNAD6mxRMnJvLy5XFwco1NHScIXkyQmLK3Y8q4y2B0x4J9xg3KKmE2FafvO7MV2TO2noq9DXLY9dnEqZWV1KOz8VYi85LWilgxMjrMQsf+u1lRVYRi+w1YZSs38ppdJLQcxlZcjFFtx4=
Received: from BN6PR16CA0012.namprd16.prod.outlook.com (2603:10b6:404:f5::22)
 by BYAPR12MB3271.namprd12.prod.outlook.com (2603:10b6:a03:138::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Tue, 23 Feb
 2021 05:19:35 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::9f) by BN6PR16CA0012.outlook.office365.com
 (2603:10b6:404:f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Tue, 23 Feb 2021 05:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 05:19:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 23:19:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 23:19:32 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 22 Feb 2021 23:19:31 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Guchun.Chen@amd.com>,
 <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: reserve backup pages for bad page retirment
Date: Tue, 23 Feb 2021 13:19:20 +0800
Message-ID: <20210223051920.11945-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a6e5790-a6d8-4aeb-2829-08d8d7ba9b31
X-MS-TrafficTypeDiagnostic: BYAPR12MB3271:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3271655B42DA41176C962781ED809@BYAPR12MB3271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2D/5z5VmiAY6r7LcsNRVpmAfzFs3nRLx3TV7k/sMKg8QblXCaTLAxGTSA6cDmSbYUMMnWn8ikK5b5fBvadTUDfzOh+tKuOjcz3GjdxERLdFX8ik6WuwXJXujJPWJgSk4NfpawrHcHoCLG+NOkVI3WyLQlx0ToewQ8YwFaI8HnD8fgiKA7JDqySFhd1DENyDTttjt8yNaMX70GDq4OB/aJTDuxlfsuPysU92HSajxXPFl0A9XGtZCfru2pwMPPrPQwpo6SC/m30KGdxigGQfgPjpjBvdXmwzSaNQ7zbKcamQ8XmI+sP678NN3Oo043dmwQOpxRWrMTv1xFugcWtDsRZFtnW9y+I1wxqogzaR652Z0uI5tgehrvYZM9jx48Bcn0qupW/FhxmEIXBkgDhZV21UWLy4frDLb+K4pVQrfe4V5nanngz7YdevQZ1QPLlUvFVduu48I2EuPypOPCzrlyGcINYopO2HigzhqSs1lkFiJoXF+p5ZkTGRyWfjuTblOHcb3BScrQoRvyhwjsv+FEJwfAJYRZGgSKjMh6A0DmCtPdIe4K0sTNX23yVFCwpq9QH0r7hm2bvFjq9bK3/15Fc0Ta9q0UALEtc6q/Ado3lEJCqk63WFXSoJ+0muhPgIQABlJvj/emblGIaW5gMDV02iix4JsGhhtx2ksKfEoL9DO9eifogR0o0v212dJAWeD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(478600001)(2906002)(4326008)(6636002)(36860700001)(2616005)(336012)(186003)(26005)(70586007)(36756003)(70206006)(47076005)(426003)(7696005)(316002)(110136005)(81166007)(83380400001)(8936002)(356005)(8676002)(5660300002)(1076003)(82740400003)(6666004)(86362001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 05:19:34.0064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6e5790-a6d8-4aeb-2829-08d8d7ba9b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3271
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

it's not user friendly that users' visiable unused memories are
decreased when bad pages are retired. Therefore reserve limit backup
pages when init, and return ones when bad pages retired, to keep no
change of unused memory size.

v2: refine codes to calculate badpags threshold

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b7ee587484b2..ff4387bbfb1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -170,7 +170,7 @@ struct amdgpu_mgpu_info mgpu_info = {
 };
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
-int amdgpu_bad_page_threshold = -1;
+int amdgpu_bad_page_threshold = 100;
 
 /**
  * DOC: vramlimit (int)
@@ -804,7 +804,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
  * faulty pages by ECC exceed threshold value and leave it for user's further
  * check.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto, 0 = disable bad page retirement, 100 = default value");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 93699ea4860c..09546dec40ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1747,13 +1747,14 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
-					uint32_t max_length)
+static uint32_t
+amdgpu_ras_calculate_badpags_threshold(struct amdgpu_device *adev)
 {
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int tmp_threshold = amdgpu_bad_page_threshold;
 	u64 val;
+	uint32_t max_length = 0;
 
+	max_length = amdgpu_ras_eeprom_get_record_max_length();
 	/*
 	 * Justification of value bad_page_cnt_threshold in ras structure
 	 *
@@ -1779,20 +1780,18 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 		tmp_threshold = max_length;
 
 	if (tmp_threshold == -1) {
-		val = adev->gmc.mc_vram_size;
+		val = adev->gmc.real_vram_size;
 		do_div(val, RAS_BAD_PAGE_RATE);
-		con->bad_page_cnt_threshold = min(lower_32_bits(val),
-						max_length);
-	} else {
-		con->bad_page_cnt_threshold = tmp_threshold;
+		tmp_threshold = min(lower_32_bits(val), max_length);
 	}
+
+	return tmp_threshold;
 }
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
-	uint32_t max_eeprom_records_len = 0;
 	bool exc_err_limit = false;
 	int ret;
 
@@ -1812,8 +1811,16 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	atomic_set(&con->in_recovery, 0);
 	con->adev = adev;
 
-	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
-	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
+	if (!con->bad_page_cnt_threshold) {
+		con->bad_page_cnt_threshold =
+			amdgpu_ras_calculate_badpags_threshold(adev);
+
+		ret = amdgpu_vram_mgr_reserve_backup_pages(
+			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+			con->bad_page_cnt_threshold);
+		if (ret)
+			goto out;
+	}
 
 	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 69ba8dd4f3ee..927d33d75c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -52,6 +52,8 @@ struct amdgpu_vram_mgr {
 	spinlock_t lock;
 	struct list_head reservations_pending;
 	struct list_head reserved_pages;
+	struct list_head backup_pages;
+	uint32_t num_backup_pages;
 	atomic64_t usage;
 	atomic64_t vis_usage;
 };
@@ -127,6 +129,8 @@ uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
 uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man);
 int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 				  uint64_t start, uint64_t size);
+int amdgpu_vram_mgr_reserve_backup_pages(struct ttm_resource_manager *man,
+					 uint32_t num_pages);
 int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
 				      uint64_t start);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 21d18efca277..b325b067926b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -28,6 +28,9 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+static int amdgpu_vram_mgr_free_backup_pages(struct amdgpu_vram_mgr *mgr,
+					     uint32_t num_pages);
+
 static inline struct amdgpu_vram_mgr *to_vram_mgr(struct ttm_resource_manager *man)
 {
 	return container_of(man, struct amdgpu_vram_mgr, manager);
@@ -189,6 +192,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	spin_lock_init(&mgr->lock);
 	INIT_LIST_HEAD(&mgr->reservations_pending);
 	INIT_LIST_HEAD(&mgr->reserved_pages);
+	INIT_LIST_HEAD(&mgr->backup_pages);
 
 	/* Add the two VRAM-related sysfs files */
 	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
@@ -229,6 +233,11 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 		drm_mm_remove_node(&rsv->mm_node);
 		kfree(rsv);
 	}
+
+	list_for_each_entry_safe(rsv, temp, &mgr->backup_pages, node) {
+		drm_mm_remove_node(&rsv->mm_node);
+		kfree(rsv);
+	}
 	drm_mm_takedown(&mgr->mm);
 	spin_unlock(&mgr->lock);
 
@@ -300,12 +309,14 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 			continue;
 
 		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
-			rsv->mm_node.start, rsv->mm_node.size);
+			rsv->mm_node.start << PAGE_SHIFT, rsv->mm_node.size);
 
 		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
 		atomic64_add(vis_usage, &mgr->vis_usage);
 		atomic64_add(rsv->mm_node.size << PAGE_SHIFT, &mgr->usage);
 		list_move(&rsv->node, &mgr->reserved_pages);
+
+		amdgpu_vram_mgr_free_backup_pages(mgr, rsv->mm_node.size);
 	}
 }
 
@@ -322,6 +333,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 				  uint64_t start, uint64_t size)
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 	struct amdgpu_vram_reservation *rsv;
 
 	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
@@ -332,14 +344,94 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 	rsv->mm_node.start = start >> PAGE_SHIFT;
 	rsv->mm_node.size = size >> PAGE_SHIFT;
 
+	dev_dbg(adev->dev, "Pending Reservation: 0x%llx\n", start);
+
 	spin_lock(&mgr->lock);
-	list_add_tail(&mgr->reservations_pending, &rsv->node);
+	list_add_tail(&rsv->node, &mgr->reservations_pending);
 	amdgpu_vram_mgr_do_reserve(man);
 	spin_unlock(&mgr->lock);
 
 	return 0;
 }
 
+static int amdgpu_vram_mgr_free_backup_pages(struct amdgpu_vram_mgr *mgr,
+					     uint32_t num_pages)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
+	struct amdgpu_vram_reservation *rsv;
+	uint32_t i;
+	uint64_t vis_usage = 0, total_usage = 0;
+
+	if (num_pages > mgr->num_backup_pages) {
+		dev_warn(adev->dev, "No enough backup pages\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_pages; i++) {
+		rsv = list_first_entry(&mgr->backup_pages,
+				       struct amdgpu_vram_reservation, node);
+		vis_usage += amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
+		total_usage += (rsv->mm_node.size << PAGE_SHIFT);
+		drm_mm_remove_node(&rsv->mm_node);
+		list_del(&rsv->node);
+		kfree(rsv);
+		mgr->num_backup_pages--;
+	}
+
+	atomic64_sub(total_usage, &mgr->usage);
+	atomic64_sub(vis_usage, &mgr->vis_usage);
+
+	return 0;
+}
+
+int amdgpu_vram_mgr_reserve_backup_pages(struct ttm_resource_manager *man,
+					 uint32_t num_pages)
+{
+	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
+	struct amdgpu_vram_reservation *rsv;
+	struct drm_mm *mm = &mgr->mm;
+	uint32_t i;
+	int ret = 0;
+	uint64_t vis_usage, total_usage;
+
+	for (i = 0; i < num_pages; i++) {
+		rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
+		if (!rsv) {
+			ret = -ENOMEM;
+			goto pro_end;
+		}
+
+		INIT_LIST_HEAD(&rsv->node);
+
+		ret = drm_mm_insert_node(mm, &rsv->mm_node, 1);
+		if (ret) {
+			dev_err(adev->dev, "failed to reserve backup page %d, ret 0x%x\n", i, ret);
+			kfree(rsv);
+			goto pro_end;
+		}
+
+		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
+		total_usage = (rsv->mm_node.size << PAGE_SHIFT);
+
+		spin_lock(&mgr->lock);
+		atomic64_add(vis_usage, &mgr->vis_usage);
+		atomic64_add(total_usage, &mgr->usage);
+		list_add_tail(&rsv->node, &mgr->backup_pages);
+		mgr->num_backup_pages++;
+		spin_unlock(&mgr->lock);
+	}
+
+pro_end:
+	if (ret) {
+		spin_lock(&mgr->lock);
+		amdgpu_vram_mgr_free_backup_pages(mgr, mgr->num_backup_pages);
+		spin_unlock(&mgr->lock);
+	}
+
+	return ret;
+}
+
 /**
  * amdgpu_vram_mgr_query_page_status - query the reservation status
  *
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
