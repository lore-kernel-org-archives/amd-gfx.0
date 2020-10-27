Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BFEC4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2D3206DC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z3XdIv4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2D3206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33456EB34;
	Tue, 27 Oct 2020 09:05:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64FE6EB34
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqf4IwQXTayCEHTdNKGJgsu7t+BODrEZxtFIpUBIULll2EfvwjCHjEpPffdF7KOY0ItVE2US2P6z8WcVGe3Gi9MES5N/zicWT9+PdE+3aj98ZJrybK0VAAiwzxWeUm6YxwoFL/GummKV/wDWrwmvNN+9hxoeAH3slDuOvrvRt50A7+9zbuxIh4iT3EJ0tyO+eRdklVmRh+kSFyBX7wYlXme1oRo9WAFf2VP7hmbtqJcHu/4/1PVy4HNUHs9WYfZWHfDo/jMQdKeRP5N7DKZqXFy91TQihNzn/mxtl1KkOmLwuCWwA4KhV+nKXcDqjLMu0OZfX2sDlpVKjIkHoXt5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg7X4ePBqDoKsovSAb1AzWDq4PPuS2eQHUbW7BMHUZI=;
 b=lk24/tl7VTF7BsIPg+dYiQH5UkP23vm47Sa1BwYTPRpoXboZmdrdWaiqb14+9GkbdNDTu6uLw2t9JUlMy8/o2xDUQBVr/Hrdb18wtN2Cq9kLih/p+4ihhEuL2WMakp0cW+TIj4Uh50wRGkJnE6wv4dFg18f55ldpqwja1UmnvG2F6c/JmUAWrotCMmW0gw81JczdExqJmjOyvZMN6CXI9pet1v6/awLCkNbkUKCZtSq3pKAMBtcx9vNDFAb/TaDE7sYt2sCmvWUi33vKgtJ/u1X6bg3xCEIGPxUwjlmTrvCUKMD6pXpBvhfkXB+kuIv34fyQOKAT7OYLYY/z6D4a9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg7X4ePBqDoKsovSAb1AzWDq4PPuS2eQHUbW7BMHUZI=;
 b=z3XdIv4CDICuJQ3KxUdeWrFyzGdtJMkq+FGB4yOwrmkkoA3j+9FapHc781wGA31OwhKkSnAW3jupDvv7k7ySeW4fYC1JOOvdBHtB5R8F9d5JierqXJ3BMOfPfyC80NKHcnuHi7zWalq9/uclMq3Wmgh3zQkDc7zfqLgUEdOVKug=
Received: from MWHPR18CA0054.namprd18.prod.outlook.com (2603:10b6:300:39::16)
 by BN6PR1201MB0081.namprd12.prod.outlook.com (2603:10b6:405:4f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:05:21 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::4d) by MWHPR18CA0054.outlook.office365.com
 (2603:10b6:300:39::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Tue, 27 Oct 2020 09:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 09:05:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 27 Oct
 2020 04:05:19 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 27 Oct 2020 04:05:17 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix the issue of reserving bad pages failed
Date: Tue, 27 Oct 2020 17:05:09 +0800
Message-ID: <20201027090509.3653-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd29e487-56eb-493c-3743-08d87a576e72
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0081:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00811982BE5EE39B5EC8F118ED160@BN6PR1201MB0081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifuzRO4Oeok8+A8skj/cT6pXMViceZISMOpzjCIDdiDTB5BO9+sRG8p5Sbfd899AjhpZYyQdgRyJhM/ljk093DtYvH1B7EgJWplNHTRvrfdceZsHcdGpw9XTYuLowmmgVdty47f9rTrgYIDIpnKh22PA1AXkTgPiLADzQrv1kMkp6vB0orzvagL2WHpAA5ng7aQgQUHFS5g2M79vp2Jo/vU6IX/HtC5ZLmUkgSdreyEw4guVkmlDM+U4vzU0uWQ7yIlYA8+UIqvP6cmZ08chh944sUkkVq9sYxYCU9BSyjbqgUGPBB5rVltPUBr1SlXnK6qachKeCcQzwEkUq72l8MkrEyq78tT3UD/8cDdcj1N/P85KMR30DiATZU9xk44Ww76nuUr7GFQPqrRG4gjwKsblE7nAsyXZJGSWsa5J7jw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(478600001)(8936002)(356005)(54906003)(36756003)(336012)(426003)(82310400003)(7696005)(81166007)(2616005)(110136005)(6636002)(26005)(86362001)(8676002)(2906002)(6666004)(30864003)(83380400001)(186003)(5660300002)(82740400003)(316002)(4326008)(47076004)(1076003)(70586007)(70206006)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:05:20.5018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd29e487-56eb-493c-3743-08d87a576e72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0081
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdgpu_ras_reset_gpu, because bad pages may not be freed,
it has high probability to reserve bad pages failed.

Change to reserve bad pages when freeing VRAM.

v2:
1. avoid allocating the drm_mm node outside of amdgpu_vram_mgr.c
2. move bad page reserving into amdgpu_ras_add_bad_pages, if vram mgr
   reserve bad page failed, it will put it into pending list, otherwise
   put it into processed list;
3. remove amdgpu_ras_release_bad_pages, because retired page's info has
   been moved into amdgpu_vram_mgr

v3:
1. formate code style;
2. rename amdgpu_vram_reserve_scope as amdgpu_vram_reservation;
3. rename scope_pending as reservations_pending;
4. rename scope_processed as reserved_pages;
5. change to iterate over all the pending ones and try to insert them
   with drm_mm_reserve_node();

v4:
1. rename amdgpu_vram_mgr_reserve_scope as
amdgpu_vram_mgr_reserve_range;
2. remove unused include "amdgpu_ras.h";
3. rename amdgpu_vram_mgr_check_and_reserve as
amdgpu_vram_mgr_do_reserve;
4. refine amdgpu_vram_mgr_reserve_range to call
amdgpu_vram_mgr_do_reserve.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      | 150 +++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h      |   8 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 115 ++++++++++++++
 4 files changed, 158 insertions(+), 119 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0f57a0003df6..84bb55ab6ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -80,6 +80,8 @@ enum amdgpu_ras_retire_page_reservation {
 
 atomic_t amdgpu_ras_in_intr = ATOMIC_INIT(0);
 
+static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
+				uint64_t addr);
 static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr);
 
@@ -1573,10 +1575,12 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
-
-		if (data->last_reserved <= i)
+		ret = amdgpu_vram_mgr_query_page_status(
+				&adev->mman.bdev.man[TTM_PL_VRAM],
+				data->bps[i].retired_page);
+		if (ret == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
-		else if (data->bps_bo[i] == NULL)
+		else if (ret == -ENOENT)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_FAULT;
 	}
 
@@ -1628,12 +1632,9 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	unsigned int new_space = old_space + pages;
 	unsigned int align_space = ALIGN(new_space, 512);
 	void *bps = kmalloc(align_space * sizeof(*data->bps), GFP_KERNEL);
-	struct amdgpu_bo **bps_bo =
-			kmalloc(align_space * sizeof(*data->bps_bo), GFP_KERNEL);
 
-	if (!bps || !bps_bo) {
+	if (!bps) {
 		kfree(bps);
-		kfree(bps_bo);
 		return -ENOMEM;
 	}
 
@@ -1642,14 +1643,8 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 				data->count * sizeof(*data->bps));
 		kfree(data->bps);
 	}
-	if (data->bps_bo) {
-		memcpy(bps_bo, data->bps_bo,
-				data->count * sizeof(*data->bps_bo));
-		kfree(data->bps_bo);
-	}
 
 	data->bps = bps;
-	data->bps_bo = bps_bo;
 	data->space_left += align_space - old_space;
 	return 0;
 }
@@ -1661,6 +1656,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
 	int ret = 0;
+	uint32_t i;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
@@ -1670,16 +1666,26 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	if (!data)
 		goto out;
 
-	if (data->space_left <= pages)
-		if (amdgpu_ras_realloc_eh_data_space(adev, data, pages)) {
+	for (i = 0; i < pages; i++) {
+		if (amdgpu_ras_check_bad_page_unlock(con,
+			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+			continue;
+
+		if (!data->space_left &&
+			amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
 			ret = -ENOMEM;
 			goto out;
 		}
 
-	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
-	data->count += pages;
-	data->space_left -= pages;
+		amdgpu_vram_mgr_reserve_range(
+			&adev->mman.bdev.man[TTM_PL_VRAM],
+			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
+			AMDGPU_GPU_PAGE_SIZE);
 
+		memcpy(&data->bps[data->count], &bps[i], sizeof(*data->bps));
+		data->count++;
+		data->space_left--;
+	}
 out:
 	mutex_unlock(&con->recovery_lock);
 
@@ -1752,6 +1758,20 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	return ret;
 }
 
+static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
+				uint64_t addr)
+{
+	struct ras_err_handler_data *data = con->eh_data;
+	int i;
+
+	addr >>= AMDGPU_GPU_PAGE_SHIFT;
+	for (i = 0; i < data->count; i++)
+		if (addr == data->bps[i].retired_page)
+			return true;
+
+	return false;
+}
+
 /*
  * check if an address belongs to bad page
  *
@@ -1761,26 +1781,13 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_err_handler_data *data;
-	int i;
 	bool ret = false;
 
 	if (!con || !con->eh_data)
 		return ret;
 
 	mutex_lock(&con->recovery_lock);
-	data = con->eh_data;
-	if (!data)
-		goto out;
-
-	addr >>= AMDGPU_GPU_PAGE_SHIFT;
-	for (i = 0; i < data->count; i++)
-		if (addr == data->bps[i].retired_page) {
-			ret = true;
-			goto out;
-		}
-
-out:
+	ret = amdgpu_ras_check_bad_page_unlock(con, addr);
 	mutex_unlock(&con->recovery_lock);
 	return ret;
 }
@@ -1826,77 +1833,6 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	}
 }
 
-/* called in gpu recovery/init */
-int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_err_handler_data *data;
-	uint64_t bp;
-	struct amdgpu_bo *bo = NULL;
-	int i, ret = 0;
-
-	/* Not reserve bad page when amdgpu_bad_page_threshold == 0. */
-	if (!con || !con->eh_data || (amdgpu_bad_page_threshold == 0))
-		return 0;
-
-	mutex_lock(&con->recovery_lock);
-	data = con->eh_data;
-	if (!data)
-		goto out;
-	/* reserve vram at driver post stage. */
-	for (i = data->last_reserved; i < data->count; i++) {
-		bp = data->bps[i].retired_page;
-
-		/* There are two cases of reserve error should be ignored:
-		 * 1) a ras bad page has been allocated (used by someone);
-		 * 2) a ras bad page has been reserved (duplicate error injection
-		 *    for one page);
-		 */
-		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
-					       AMDGPU_GPU_PAGE_SIZE,
-					       AMDGPU_GEM_DOMAIN_VRAM,
-					       &bo, NULL))
-			dev_warn(adev->dev, "RAS WARN: reserve vram for "
-					"retired page %llx fail\n", bp);
-
-		data->bps_bo[i] = bo;
-		data->last_reserved = i + 1;
-		bo = NULL;
-	}
-out:
-	mutex_unlock(&con->recovery_lock);
-	return ret;
-}
-
-/* called when driver unload */
-static int amdgpu_ras_release_bad_pages(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_err_handler_data *data;
-	struct amdgpu_bo *bo;
-	int i;
-
-	if (!con || !con->eh_data)
-		return 0;
-
-	mutex_lock(&con->recovery_lock);
-	data = con->eh_data;
-	if (!data)
-		goto out;
-
-	for (i = data->last_reserved - 1; i >= 0; i--) {
-		bo = data->bps_bo[i];
-
-		amdgpu_bo_free_kernel(&bo, NULL, NULL);
-
-		data->bps_bo[i] = bo;
-		data->last_reserved = i;
-	}
-out:
-	mutex_unlock(&con->recovery_lock);
-	return 0;
-}
-
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1936,18 +1872,12 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret)
 			goto free;
-		ret = amdgpu_ras_reserve_bad_pages(adev);
-		if (ret)
-			goto release;
 	}
 
 	return 0;
 
-release:
-	amdgpu_ras_release_bad_pages(adev);
 free:
 	kfree((*data)->bps);
-	kfree((*data)->bps_bo);
 	kfree(*data);
 	con->eh_data = NULL;
 out:
@@ -1975,12 +1905,10 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 		return 0;
 
 	cancel_work_sync(&con->recovery_work);
-	amdgpu_ras_release_bad_pages(adev);
 
 	mutex_lock(&con->recovery_lock);
 	con->eh_data = NULL;
 	kfree(data->bps);
-	kfree(data->bps_bo);
 	kfree(data);
 	mutex_unlock(&con->recovery_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7c39d706e6d1..4667cce38582 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -362,14 +362,10 @@ struct ras_err_data {
 struct ras_err_handler_data {
 	/* point to bad page records array */
 	struct eeprom_table_record *bps;
-	/* point to reserved bo array */
-	struct amdgpu_bo **bps_bo;
 	/* the count of entries */
 	int count;
 	/* the space can place new entries */
 	int space_left;
-	/* last reserved entry's index + 1 */
-	int last_reserved;
 };
 
 typedef int (*ras_ih_cb)(struct amdgpu_device *adev,
@@ -506,15 +502,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages);
 
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
-int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev);
 
 static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	if (in_task())
-		amdgpu_ras_reserve_bad_pages(adev);
-
 	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
 		schedule_work(&ras->recovery_work);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index de37ceff0e56..90a3ed682466 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -103,6 +103,10 @@ void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
 			      struct sg_table *sgt);
 uint64_t amdgpu_vram_mgr_usage(struct ttm_mem_type_manager *man);
 uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_mem_type_manager *man);
+int amdgpu_vram_mgr_reserve_range(struct ttm_mem_type_manager *man,
+				  uint64_t start, uint64_t size);
+int amdgpu_vram_mgr_query_page_status(struct ttm_mem_type_manager *man,
+				      uint64_t start);
 
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 91098a385ed6..db573e77e216 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -28,9 +28,16 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+struct amdgpu_vram_reservation {
+	struct list_head node;
+	struct drm_mm_node mm_node;
+};
+
 struct amdgpu_vram_mgr {
 	struct drm_mm mm;
 	spinlock_t lock;
+	struct list_head reservations_pending;
+	struct list_head reserved_pages;
 	atomic64_t usage;
 	atomic64_t vis_usage;
 };
@@ -179,6 +186,8 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
 
 	drm_mm_init(&mgr->mm, 0, p_size);
 	spin_lock_init(&mgr->lock);
+	INIT_LIST_HEAD(&mgr->reservations_pending);
+	INIT_LIST_HEAD(&mgr->reserved_pages);
 	man->priv = mgr;
 
 	/* Add the two VRAM-related sysfs files */
@@ -201,8 +210,18 @@ static int amdgpu_vram_mgr_fini(struct ttm_mem_type_manager *man)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(man->bdev);
 	struct amdgpu_vram_mgr *mgr = man->priv;
+	struct amdgpu_vram_reservation *rsv, *temp;
 
 	spin_lock(&mgr->lock);
+
+	list_for_each_entry_safe(rsv, temp, &mgr->reservations_pending, node)
+		kfree(rsv);
+
+	list_for_each_entry_safe(rsv, temp, &mgr->reserved_pages, node) {
+		drm_mm_remove_node(&rsv->mm_node);
+		kfree(rsv);
+	}
+
 	drm_mm_takedown(&mgr->mm);
 	spin_unlock(&mgr->lock);
 	kfree(mgr);
@@ -260,6 +279,101 @@ u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo)
 	return usage;
 }
 
+static void amdgpu_vram_mgr_do_reserve(struct ttm_mem_type_manager *man)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(man->bdev);
+	struct amdgpu_vram_mgr *mgr = man->priv;
+	struct drm_mm *mm = &mgr->mm;
+	struct amdgpu_vram_reservation *rsv, *temp;
+	uint64_t vis_usage;
+
+	list_for_each_entry_safe(rsv, temp, &mgr->reservations_pending, node) {
+		if (drm_mm_reserve_node(mm, &rsv->mm_node))
+			continue;
+
+		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Successed\n",
+			rsv->mm_node.start, rsv->mm_node.size);
+
+		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
+		atomic64_add(vis_usage, &mgr->vis_usage);
+		atomic64_add(rsv->mm_node.size << PAGE_SHIFT, &mgr->usage);
+		list_move(&rsv->node, &mgr->reserved_pages);
+	}
+}
+
+/**
+ * amdgpu_vram_mgr_reserve_range - Reserve a range from VRAM
+ *
+ * @man: TTM memory type manager
+ * @start: start address of the range in VRAM
+ * @size: size of the range
+ *
+ * Reserve memory from start addess with the specified size in VRAM
+ */
+int amdgpu_vram_mgr_reserve_range(struct ttm_mem_type_manager *man,
+				  uint64_t start, uint64_t size)
+{
+	struct amdgpu_vram_mgr *mgr = man->priv;
+	struct amdgpu_vram_reservation *rsv;
+
+	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
+	if (!rsv)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&rsv->node);
+	rsv->mm_node.start = start >> PAGE_SHIFT;
+	rsv->mm_node.size = size >> PAGE_SHIFT;
+
+	spin_lock(&mgr->lock);
+	list_add_tail(&mgr->reservations_pending, &rsv->node);
+	amdgpu_vram_mgr_do_reserve(man);
+	spin_unlock(&mgr->lock);
+
+	return 0;
+}
+
+/**
+ * amdgpu_vram_mgr_query_page_status - query the reservation status
+ *
+ * @man: TTM memory type manager
+ * @start: start address of a page in VRAM
+ *
+ * Returns:
+ *	-EBUSY: the page is still hold and in pending list
+ *	0: the page has been reserved
+ *	-ENOENT: the input page is not a reservation
+ */
+int amdgpu_vram_mgr_query_page_status(struct ttm_mem_type_manager *man,
+				      uint64_t start)
+{
+	struct amdgpu_vram_mgr *mgr = man->priv;
+	struct amdgpu_vram_reservation *rsv;
+	int ret;
+
+	spin_lock(&mgr->lock);
+
+	list_for_each_entry(rsv, &mgr->reservations_pending, node) {
+		if ((rsv->mm_node.start <= start) &&
+		    (start < (rsv->mm_node.start + rsv->mm_node.size))) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
+	list_for_each_entry(rsv, &mgr->reserved_pages, node) {
+		if ((rsv->mm_node.start <= start) &&
+		    (start < (rsv->mm_node.start + rsv->mm_node.size))) {
+			ret = 0;
+			goto out;
+		}
+	}
+
+	ret = -ENOENT;
+out:
+	spin_unlock(&mgr->lock);
+	return ret;
+}
+
 /**
  * amdgpu_vram_mgr_virt_start - update virtual start address
  *
@@ -430,6 +544,7 @@ static void amdgpu_vram_mgr_del(struct ttm_mem_type_manager *man,
 		vis_usage += amdgpu_vram_mgr_vis_size(adev, nodes);
 		++nodes;
 	}
+	amdgpu_vram_mgr_do_reserve(man);
 	spin_unlock(&mgr->lock);
 
 	atomic64_sub(usage, &mgr->usage);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
