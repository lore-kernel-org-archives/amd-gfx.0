Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0EFCCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 07:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC89D10EB3B;
	Fri, 17 Oct 2025 07:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SY5Qk+Bx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010064.outbound.protection.outlook.com
 [40.93.198.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EADC10EB3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 07:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAlIKl6AorVwqJzIW8eKKgb/0Hqtwe6Uoyyr7KMycm69UZsuOSNWwfPp0hiZbh7VaXitjkXrerNa5a33IkMltSfPZcAJwmpgi6w+L1yT3roiOkJ/I3Gl+jNhER7QC3XWx1AiY11moYLHhu3jHIGbaDOm54skED8J8Hj1H6YJRmyBapMAN+Y5pCwGfhD0WUibG7uDRUlL2jsr6GeXUBCtuOkCy3+PwunAdwPg3Rbh1bIKeaYbYBZo8MUNBXEs8HRl8jx4z1+3F0/zRA8Rvjc3tV6q4mz2RwFg50TfQFH5vF9CoLUyqPYFiXZ4P0e57jmAFYbYSjvjF/nuO3+7seSYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41tVih78X8jInz+oTcY5IDHmjLQNtj+90yux5IlBKU0=;
 b=iuU0EOfU2d5BcjgwYWNqcTvfOeALDV9qOzQitK4/+kcvlwMGpEaJLwXbauxiW3zlKruprq/FVfOIquL2YuvkTtMjvWrbz2Q6e2R2FBj2ME0JX/Jq61zl8nxq8a+KvkevLmc+PwiLRIprTPLqCSZ+oWOqqBJOsOdDsIz+Zi3doTOwy8w5gjWIb8rgtG70QKZt6d9Dvem8VH57hwACOLt8M8Rr57tUwwltR/oAGJBvO622nKJrk/4n5mbYUHjTGrw/wkP5KNeZnNBza6GA6QID5QFkgpalmCyhdPX/J7zsdACdKj949OSnIveRCgXPmgQyoXj1wtmbMmNEdwty1dMb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41tVih78X8jInz+oTcY5IDHmjLQNtj+90yux5IlBKU0=;
 b=SY5Qk+BxA8bXNLBtrdHykvNOdbmvYeUJpzY/+ZrWTU0i1xAhoy5ljpbRVMxV/jwz1CEqYHizrHWCmn9QHgyvndOWe2xdkn9ZX4wWd4yE4xa0jUV8ffWpOfRyAL3XDkXwxOtvvyIe1nXi877kzvoCL/261Qf5YqjU4NNwsulYA1c=
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 17 Oct
 2025 07:52:47 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::96) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 07:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 07:52:46 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 00:52:43 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: query bad page info of ras module
Date: Fri, 17 Oct 2025 15:51:30 +0800
Message-ID: <20251017075131.23939-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017075131.23939-1-YiPeng.Chai@amd.com>
References: <20251017075131.23939-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 913c8622-8f94-4f48-6fba-08de0d522941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PfmD7RBYKR8R1MJUfyWnV3BRGdCCCqxdV6KFS2EeGmyY/2hrSHrNCWuXCH37?=
 =?us-ascii?Q?CSQqYdHjUgX0QMe8pJJkZ5vKC8x0zXAaFg0PQ6btfAgfCf1/GJFfIyOEaRhj?=
 =?us-ascii?Q?Tc4zWbVxRep3OF+YjdIckor4j+iSRTAt1e8AtLuzHURFRsa8k9VqpsN4zdLj?=
 =?us-ascii?Q?j3NaCLfTnCcoAr8XAq3dPUaugiQZpKllH7nR8ZQnifRL/ZHGRx3aFoCAo7Cu?=
 =?us-ascii?Q?ejC2zpsyX7tKtJ2rmoKYItgH+lhEcumd4Kd9UQaznVpRwY4z0060lcVKbg3j?=
 =?us-ascii?Q?AmLueSMTfqgnbWm90RlhOPqJyV6ijy2IKEQK3atCFUTRlWK7NlQWR+vt1A5S?=
 =?us-ascii?Q?55XJ2P8IFZaq4hbm3ltNotjr0Ls/cFcZ4fjdZWyPpGXIKrUhBKTbQKR0CX2X?=
 =?us-ascii?Q?yCTtQ/42czjW8QwnDmrhObmeLJYi2/lwhZPwKThw8nL5os98RbJk1NV2W8mj?=
 =?us-ascii?Q?a3D8N4x2cSmwZRwBhwcB2gLtwc7anbya5kS1eq5Wv5RYPmUR6sEsrsfn4WG9?=
 =?us-ascii?Q?CzgvrajMmLN9mIhMZeFcHzCLPiLV8qu+CtymSEEUAKBSY3FIOvAFL56u9k38?=
 =?us-ascii?Q?p18JRphFiiIipmKc7WRonhyPlDUBJHZcZ0DJqLdnXDHINEWk+NguqGgPrwrL?=
 =?us-ascii?Q?L0Xaa1SMdkZmWEXZ5J2P/EqIBzaHPLJGufFgBOy4ou1+DuRgob7eZnqHzVlY?=
 =?us-ascii?Q?/Xu2IPJ5XlRpv8ty40JAV97sLMVM5B9NS8qybAuTTuAUloLu+75D+2yM+phL?=
 =?us-ascii?Q?fRmtoRK3beJKQhMVCed5nV6ywWBSbRXnyKObukc4zdybOWvnC/EgPMTas/cz?=
 =?us-ascii?Q?MKs+xwEj5v9vkf+Wl/iI0wmPQLtL2cbYWI+qfyjx5XCdcWsaz04o+l2cJWtG?=
 =?us-ascii?Q?WE8d2F+G/FB9AiU/0AHMBULy+yj8jCP7wjRvx/afxdyZQUyjYZ2NG/QVHzZG?=
 =?us-ascii?Q?+CzI29vgQ2SPUMpIYa/swwBKSMmpg3bamsqep1roGptWF0EnR69mHT3NoDJJ?=
 =?us-ascii?Q?aP1rcZdcJYDvE2Va0Z8oRdMm8XUCCBcWXsXQL9vLJYUydM7zjXM/0LZd5KDo?=
 =?us-ascii?Q?S4mrZg5A+KA0oBCpYaaui6aCEb324B3uWbzv8ilade0gcofHoQXUaMqxkfMg?=
 =?us-ascii?Q?S+aYJ39LahfLmSYj3PGsN4TB7Q6Og5gqixwiDk/fuTx8cCS2//W9jquNM+aG?=
 =?us-ascii?Q?+WdAgjW94zNtHLblW+0/d5fcZ1N6bWw90g7hgw7QEmpMCZAt/MmKBJENhs6N?=
 =?us-ascii?Q?YN34sGTwh1lWtrAvt/oxTSAdgvpPJMfSEor/1+h+lL4Rm7lFO6N649/zpR1D?=
 =?us-ascii?Q?4Pv4wYZHUOOJquU905yjtZ+pZk4mv0pkioUpyywdyGDgnFGhGWX8iBfOIJA8?=
 =?us-ascii?Q?eS5YHblivNPVfLY0K3WxdpdGGvTnLzBhQQ2bgeNmNbitpMj/6TZuNtJO6LjQ?=
 =?us-ascii?Q?Eakd22je8yrT2H6sl7Zs25g4DTIwbn03CkzCh2oi11Rrb2mSMbujqrpLA+vD?=
 =?us-ascii?Q?KvjA4Uc44x8z/b2uf0APikADP0OhreBAkGUArUsP0VWh1L1lsc9+074Hj3ns?=
 =?us-ascii?Q?J+BkuFYHLcIhHNh/XQw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 07:52:46.3377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913c8622-8f94-4f48-6fba-08de0d522941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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

Query bad page info of ras module.

V2:
  Update code to reuse bad page output code.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 142 ++++++++++++++++--------
 1 file changed, 98 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 566143ff9ccd..5d5e1c0154b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1782,7 +1782,9 @@ int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 /* sysfs begin */
 
 static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
-		struct ras_badpage **bps, unsigned int *count);
+		struct ras_badpage *bps, uint32_t count, uint32_t start);
+static int amdgpu_uniras_badpages_read(struct amdgpu_device *adev,
+		struct ras_badpage *bps, uint32_t count, uint32_t start);
 
 static char *amdgpu_ras_badpage_flags_str(unsigned int flags)
 {
@@ -1840,19 +1842,50 @@ static ssize_t amdgpu_ras_sysfs_badpages_read(struct file *f,
 	unsigned int end = div64_ul(ppos + count - 1, element_size);
 	ssize_t s = 0;
 	struct ras_badpage *bps = NULL;
-	unsigned int bps_count = 0;
+	int bps_count = 0, i, status;
+	uint64_t address;
 
 	memset(buf, 0, count);
 
-	if (amdgpu_ras_badpages_read(adev, &bps, &bps_count))
+	bps_count = end - start;
+	bps = kmalloc_array(bps_count, sizeof(*bps), GFP_KERNEL);
+	if (!bps)
+		return 0;
+
+	memset(bps, 0, sizeof(*bps) * bps_count);
+
+	if (amdgpu_uniras_enabled(adev))
+		bps_count = amdgpu_uniras_badpages_read(adev, bps, bps_count, start);
+	else
+		bps_count = amdgpu_ras_badpages_read(adev, bps, bps_count, start);
+
+	if (bps_count <= 0) {
+		kfree(bps);
 		return 0;
+	}
+
+	for (i = 0; i < bps_count; i++) {
+		address = ((uint64_t)bps[i].bp) << AMDGPU_GPU_PAGE_SHIFT;
+		if (amdgpu_ras_check_critical_address(adev, address))
+			continue;
+
+		bps[i].size = AMDGPU_GPU_PAGE_SIZE;
+
+		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
+					address);
+		if (status == -EBUSY)
+			bps[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
+		else if (status == -ENOENT)
+			bps[i].flags = AMDGPU_RAS_RETIRE_PAGE_FAULT;
+		else
+			bps[i].flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED;
 
-	for (; start < end && start < bps_count; start++)
 		s += scnprintf(&buf[s], element_size + 1,
 				"0x%08x : 0x%08x : %1s\n",
-				bps[start].bp,
-				bps[start].size,
-				amdgpu_ras_badpage_flags_str(bps[start].flags));
+				bps[i].bp,
+				bps[i].size,
+				amdgpu_ras_badpage_flags_str(bps[i].flags));
+	}
 
 	kfree(bps);
 
@@ -2645,62 +2678,83 @@ static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
 	}
 }
 
-/* recovery begin */
-
-/* return 0 on success.
- * caller need free bps.
- */
 static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
-		struct ras_badpage **bps, unsigned int *count)
+		struct ras_badpage *bps, uint32_t count, uint32_t start)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
-	int i = 0;
-	int ret = 0, status;
+	int r = 0;
+	uint32_t i;
 
 	if (!con || !con->eh_data || !bps || !count)
 		return -EINVAL;
 
 	mutex_lock(&con->recovery_lock);
 	data = con->eh_data;
-	if (!data || data->count == 0) {
-		*bps = NULL;
-		ret = -EINVAL;
-		goto out;
+	if (start < data->count) {
+		for (i = start; i < data->count; i++) {
+			if (!data->bps[i].ts)
+				continue;
+
+			bps[r].bp = data->bps[i].retired_page;
+			r++;
+			if (r >= count)
+				break;
+		}
 	}
+	mutex_unlock(&con->recovery_lock);
 
-	*bps = kmalloc_array(data->count, sizeof(struct ras_badpage), GFP_KERNEL);
-	if (!*bps) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	return r;
+}
 
-	for (; i < data->count; i++) {
-		if (!data->bps[i].ts)
-			continue;
+static int amdgpu_uniras_badpages_read(struct amdgpu_device *adev,
+		struct ras_badpage *bps, uint32_t count, uint32_t start)
+{
+	struct ras_cmd_bad_pages_info_req cmd_input;
+	struct ras_cmd_bad_pages_info_rsp *output;
+	uint32_t group, start_group, end_group;
+	uint32_t pos, pos_in_group;
+	int r = 0, i;
 
-		(*bps)[i] = (struct ras_badpage){
-			.bp = data->bps[i].retired_page,
-			.size = AMDGPU_GPU_PAGE_SIZE,
-			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
-		};
+	if (!bps || !count)
+		return -EINVAL;
 
-		if (amdgpu_ras_check_critical_address(adev,
-			data->bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
-			continue;
+	output = kmalloc(sizeof(*output), GFP_KERNEL);
+	if (!output)
+		return -ENOMEM;
 
-		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
-				data->bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT);
-		if (status == -EBUSY)
-			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
-		else if (status == -ENOENT)
-			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_FAULT;
+	memset(&cmd_input, 0, sizeof(cmd_input));
+
+	start_group = start / RAS_CMD_MAX_BAD_PAGES_PER_GROUP;
+	end_group = (start + count + RAS_CMD_MAX_BAD_PAGES_PER_GROUP - 1) /
+				RAS_CMD_MAX_BAD_PAGES_PER_GROUP;
+
+	pos = start;
+	for (group = start_group; group < end_group; group++) {
+		memset(output, 0, sizeof(*output));
+		cmd_input.group_index = group;
+		if (amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_BAD_PAGES,
+			&cmd_input, sizeof(cmd_input), output, sizeof(*output)))
+			goto out;
+
+		if (pos >= output->bp_total_cnt)
+			goto out;
+
+		pos_in_group = pos - group * RAS_CMD_MAX_BAD_PAGES_PER_GROUP;
+		for (i = pos_in_group; i < output->bp_in_group; i++, pos++) {
+			if (!output->records[i].ts)
+				continue;
+
+			bps[r].bp = output->records[i].retired_page;
+			r++;
+			if (r >= count)
+				goto out;
+		}
 	}
 
-	*count = con->bad_page_num;
 out:
-	mutex_unlock(&con->recovery_lock);
-	return ret;
+	kfree(output);
+	return r;
 }
 
 static void amdgpu_ras_set_fed_all(struct amdgpu_device *adev,
-- 
2.34.1

