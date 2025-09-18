Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AC0CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BC410E66E;
	Thu, 18 Sep 2025 08:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bSmJ37rK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F0910E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khqyfi99vu1Hx99EizjIfWlMcIcyixEaILnG2YcJh9+1yvrQpgOvUHXByOaNYOfoCKn3rNd/223FB7OALKKmb9a6aHlaUxFHu6nTnD/JorqdvAigo6mB4NPwrDIPyhCiOG+2tNaHT6TVq5zNdcU1hEZgLsi0GlbVzItlg/o+WG6KNgFpX4A22C24X7XB3UkNirDYqkCA+W/MvtnAzrkerDkDmPJZqfV3JqcCAv8D0TJI5iWKh2rmALBE8YjsvhrMiEo0YwUXaZUCi+voXlR+UvE1R9wrSXbovZrTBVWZURd7gjgi9nIA1cmdrRV+bTXIBNgDsqMo6tEZUA28mYm5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vvXX0jl4zlJwmTc7HU/d6Eqjuy01NlDXm/K3WHMbSQ=;
 b=fbIU2TInUkxNJ1fQTD195ZIjK0Tz5/ecAG3DxJyHUFbeuLgqRhdezGnw3fa2igxaBz2xUetiO9ynCFUtWkzfGZiM7tLtDYshcJXntgPGDym0/k8wSzqtf5BYAgSpR2ibrKNLDRQndIQTIfm5iScH5MfEq7XWk3aXdrkUYzHbeIoXwB5BcKvd8XC43Jjbfm/iB8Tj2h+LUXhJC8AGl1se/bpMsLYQQ4abSQdcCoiWs3DShv9C4PeSfT9u1esZUzQv0q1kGenTs0FDWvMai5uPzR1wMAxuBJKeQZVS1jGNQByuC/yuihx1c1DgCBMNiDCwtqZX4xOOB2Vcpxyc+oZCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vvXX0jl4zlJwmTc7HU/d6Eqjuy01NlDXm/K3WHMbSQ=;
 b=bSmJ37rKzU9wxTJMEUC2zqGQ46nTew89vnu5c1YftItWScwk+3Tfciz7YMArfzBUXfiosuMHKF4AeBTPtZXxYQg2xTTFnNi5/ucK3PrhCy67j/yN4Qv+Wr4nM8r07JdTpLjpyWlcDFHYbZ3cGyBDqr6ajXD/UX17a4T2ktZWYMU=
Received: from MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 08:18:52 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::6a) by MW4PR03CA0242.outlook.office365.com
 (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 08:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:35 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 07/10] drm/amdgpu: track the userq bo va for its obj
 management
Date: Thu, 18 Sep 2025 16:18:12 +0800
Message-ID: <20250918081815.2755437-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 34660e90-a54b-43a9-6861-08ddf68bfefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NsPCjfN/LhzQh62k1RqsvDsb2gQE0xzF3rdA2E7bC66GjSQeM3Ff5+NudUER?=
 =?us-ascii?Q?6vFQnS4HH0xCcbDRl6L/mqjkfYuydzGXVXyNUHB6KeUqDfLlEVSjb91CpzYB?=
 =?us-ascii?Q?dKRS0NTr15PbpHbpi1/Z4mGG/Jyt6sxbGagKTUtHlsj8oSJ9eNPeTc1WnVxF?=
 =?us-ascii?Q?UN/x/k6C2+gy38fFXpuLcpM+XH97V/NWSuaDW+zVEdLc8IWc9x+9lwa8+kAQ?=
 =?us-ascii?Q?p3aXuGfwxi/0NQTsPZLk9HjPbmpK6VtumqQKRcZedgNEzimjbB5BmU6WOKa7?=
 =?us-ascii?Q?zIVtZUMW21ziXZggdhdX8DHMpq/ZIOcIcKfrF6KdN5UHOo+12HSvkKN1cba6?=
 =?us-ascii?Q?QzPawen8blBJf3DyZA8RGtbPF0nNhESxNvkfeOiRM5geLGBo55K7/C4XgN+F?=
 =?us-ascii?Q?pRJj//C3wEvqvMqahBBCjA6/79fPo1U29cwTTcPjzHJzGsirDva3pwL92j/8?=
 =?us-ascii?Q?uc/VxPUonmtV7fUQyybXPuNFa9HNY2I+eCPRuyu74wq6pxWrb9c+qDSzDt9t?=
 =?us-ascii?Q?XeRje0xgUBcH9Rz3mbxrFgC+YlSpDImgmlZqsxmpo4fpvjwzU1JiCr3Bl8mL?=
 =?us-ascii?Q?TNNZ6ud6q7+L6XT22JrqkwIwR3RjsXgfJSY2qxD0R5HoCZBD2vfbw05gDijT?=
 =?us-ascii?Q?wcTlJFUIhO0q3rSdUBUWKwtamattcqMT8FWQfJr/cqtz1ftH1Kc63SzLCXLw?=
 =?us-ascii?Q?IihN0Pc7eT6bs19pEy5yFFStL2Z1IiEuNUBWr59aWtTlNdIecEn1W2RjJL9p?=
 =?us-ascii?Q?pQ12C6K/R02LBl8fOXsXM4vsZe6vw7C67038atW115Pe6zJoz1NbzfWAKXD/?=
 =?us-ascii?Q?C5ytvlWiMcMSkq7sxZRLFiycs8GTASRNSty6Hu5aDJH24BkqCoyZWJKknk80?=
 =?us-ascii?Q?NWbvge7PJd02ipKPieEp9JivFSJXLNSD2LFHd/Qk3Y8u9O/DusPZU4YzH+bA?=
 =?us-ascii?Q?UM+cla7eJFnDvVgSL84rc1ZpbbXvJrQZSSc3a2v/jxAahZcaNJhCnKg1dK2e?=
 =?us-ascii?Q?baJuhYcbFYmgdJOAlSi5dzyQlyqHG4hM2XazDd16eRW2X1FnCLWcU/zml6SI?=
 =?us-ascii?Q?KTBrljcnxWnSYKbZtsWCNeI75AYo2fYo7DsSPmfGS4yGk3y2RGP9PWjUPX9Y?=
 =?us-ascii?Q?lAdGR7Waf2s2MhqfJZqpnOpNkR8cHbBtcE+L7OeBZ/vuMjj9eBbXkNVydb8h?=
 =?us-ascii?Q?V2IE5rSo0ovDI9ldz83nsdoIgzGyI+yOrm1aZZkjtWoqMf55R1iWHEmJVkdq?=
 =?us-ascii?Q?r9yTEo0UrOgmoVlV93fnfZU4cUzlDfyf5ZBuLqW23D5Jp9HykyPGKGf8y1nJ?=
 =?us-ascii?Q?VJCFURRyR6geC9NIm1Mmr3czrFSVq4lXtEFFA23kHLW7X0tuzaJ+69NBUEWT?=
 =?us-ascii?Q?NJwW/x6dsDlRchE0GHxp4k2IEHgTyTeJ7lIEGDT8Ksi1YCBCss2IQkteP2TM?=
 =?us-ascii?Q?I7++8Ia/3+WAs/cH4bWSEeTHf11ulB/rPpp3Mt+CUWov6SSX1820qjwgu4mN?=
 =?us-ascii?Q?6eyhzB9U+0iXh+L5v72DUTIflZF7qUNNPQw1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:49.3842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34660e90-a54b-43a9-6861-08ddf68bfefa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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

Track the userq obj for its life time, and reference and
dereference the buffer flag at its creating and destroying
period.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 71cac54791c9..3c8f05a9e82d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -138,6 +138,22 @@ int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm *vm,
 	return -EINVAL;
 }
 
+static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
+			        struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	int r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		r += amdgpu_userq_buffer_va_list_del(queue->vm, va_cursor->gpu_addr);
+		dev_dbg(adev->dev, "delete the userq:%p va:%llx r:%d\n",
+			queue, va_cursor->gpu_addr, r);
+		list_del(&va_cursor->list);
+		kfree(va_cursor);
+	}
+	return r;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -200,6 +216,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Drop the userq reference. */
+	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
-- 
2.34.1

