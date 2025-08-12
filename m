Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9483FC87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 07:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE5B10E5B1;
	Tue, 12 Aug 2025 07:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z9hVIdkU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6D510E5B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 07:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZOjCPVt46gJunHFvdkcSAM9QzWDU84hZODkLk5rebCFbwhf4sAek7xkJZyc+TVsTe4edwP67XD9I3mWFjrZaZFYlp5ZsbFMfqy4ieQcPnaRyQgyBcAtEcVCyo9QWvTIQ2TaJAOTFsuVMrB0QBvXfe9tPzCUg0ZaINMj4yxkA0n+5LEQqCdZm1B+45Mifj2+sTyuhpuMjU+Pu6Q/hSZvBa53jf43LC54Nk8MOqjF18wHKVAQqK74qnZaHJbJ3dmm1i4yGIQ0J3PNmjhq4S8yAMtmd7pTpkbaIpNEqe99OHdhUgJBqecBTX0qT14/s2PrjwNsMEQ9w3sjCGGZaOahSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnUt17K96B4gCjQElqiTu9DWy7uXHwuB8C0V8+1dOvw=;
 b=G54J/n48QklZIvb+uEgdDsoCEetzwkediHPUilsm/WWD+XOkutnqcKUsyHXei8JyDkBA+lMPYHeufCKcO4lqpFWfr+0ydmvD3WkQ0n0/eLkBMRswX/C1ZyZkBr6F+9CgPUwtFpw8/vs0znI+TABvEXiQJ9bUTlJCjAgX0APlNe0ni7MjpdfwXXx+ZHyOqpeGQMAvYY9CCM4CWb+lndiy8GZdEIGWgn4aSC+0KhazmFRmsEHnKLNFCjJz7aRjLYjZ1gG+pDVk06o+NIsE0BOvQcbiJgluPBoip7I0T4R4IAdcWrIHpMsDvjGSTJp4Tkf+9Vq49ezss8Wr9jWrJWrWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnUt17K96B4gCjQElqiTu9DWy7uXHwuB8C0V8+1dOvw=;
 b=Z9hVIdkUhAWEDd4UwksTlfR7/TJnZnZwVObXw0yXcjqgl8qM7ZKzydsUCXPGLtD6bDK++sD/1QBtjKu/zQ0B64CnMd4siBeFsfYGNt4CLn0Q6VUGx2OYM8c5zkeWOBtcr6JxH0kHV7/oxFRjUkPI5BzY5EjvFfiYrxrqWhd5iqw=
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 07:34:46 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::59) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 07:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 07:34:45 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 02:34:41 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>,
 Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add functions to get/clear bank count
Date: Tue, 12 Aug 2025 15:34:24 +0800
Message-ID: <20250812073424.257893-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 3976a117-33cf-4acc-e66c-08ddd972b5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cJ+dz+H1P0eK0heg1WMi1EriRW7q6poowPwOMvCSZqHDvDx3SF35IQ9bKnkV?=
 =?us-ascii?Q?ZzlB4pTh+SHXr34Ve71PO+twCjTaowdx6Y/2U6oN6Us9ku+bSccpi0dYdXiD?=
 =?us-ascii?Q?7yjJGXH6//vo+ruWyjOzDHW35RBGV/tdkLE6Lp0CU5IKpG+yPy/7eulewlDm?=
 =?us-ascii?Q?njhUlrvJ6XfR1Vr30/pSleGdk7veBsto9YYWAFSHIdLVjYlk4EX5SLeMcpu/?=
 =?us-ascii?Q?1Mi2HVlswzoq5XckHWoulB9GB6fQDHCHw3nEcivYSFr7ATxHJXpXek6q1+ic?=
 =?us-ascii?Q?ixcnKTBNY5g4AKOytNMuOm358z9RlEz5N9ncQYM9XFQ8WqLUTKymD9k7qakS?=
 =?us-ascii?Q?dHL2VJco3kKgllE31l7uBsjmWIVpgMKxVEczS/9zvZZBuhiuSzyP5Gb+X1Mx?=
 =?us-ascii?Q?58XiJ8SgsErF7ycYE9jePzYUEhgFBsygG8LnP8fKBJdBhv6xonHQH/Uh7n9Q?=
 =?us-ascii?Q?QByxGxcbPTJ64bx4HiyHK8QdI5LtlqHYFV56aQ5BMqqjLhqpBG8h4mNlA6jF?=
 =?us-ascii?Q?VLBFiTsZvK4MO+fa+itDC7XSglP/a5JYWezL7YxnArTAgKklFu8zCdonrNDC?=
 =?us-ascii?Q?HoBmCVMenMnF8S3+uUJrn5dL3iExRCXNDErx1cxyigdCggO5hqxWGwFJ9eHr?=
 =?us-ascii?Q?eSetq5aATOV1chNf+NZDl/gE931JoKxm7I9EecJbACrbRIFN05LAKL0PRTAl?=
 =?us-ascii?Q?c9bGEVDyXAFKt6mkKPTrZu8XDwNDuhhbvQgQHgbPSGDNJVGKFJfS6BJdg8bT?=
 =?us-ascii?Q?ks5SZiTJr2bY6hDZmROOUNzWUa9wXglAt9le3Wy1ghtML5XFGbxw9MMuWnH+?=
 =?us-ascii?Q?142ur1LXMTFALyTuOb/8wC8+LL0fOeznGN0/1QgNvJzVSB4Gti7dM/sPkUSy?=
 =?us-ascii?Q?IyCh7n1VX4FLOVYKJCMEwZ2JgPNs7RyZcwacUVpojpszozx4e1t/vNWXHKsK?=
 =?us-ascii?Q?vSQXh62A0ACT1LUU3Rn0fPFzmBeYP3kbBszbl3Mc3PRx+OD56kM8NXWix31A?=
 =?us-ascii?Q?FNDOX4oBYCOWOw0JekTcRck3wW6wRdw0YpqYcCU+HcgBa/m+ev4MgZszueqv?=
 =?us-ascii?Q?cwQdKaq1cjgCYPQG00pp9qy7mx1TzmENF9v2LnFGl9VDTHU1dcNzr3eit/vN?=
 =?us-ascii?Q?1XBk1V4hbQTqTPLPdU5vDm+BBRUPov2XYFVIcMP1Wy0rCuKiutSaZpnvU28m?=
 =?us-ascii?Q?YT14Iw37L8Q4epduLzio+gt/rjVQ/5t+3K0B1pdo8daTpQjyy4lXJA/kpcEh?=
 =?us-ascii?Q?Clhah2qaedsWYQfSMHfmWfI55GcfeW425ERRyFgfcGroGC2y4ro2RpS91/jw?=
 =?us-ascii?Q?k7Sjv7OXp1vQ839yGRKBzLhJ3Vtb0w0q87BfiMURNgTlk71q5gKwzzeP/FFA?=
 =?us-ascii?Q?51lKrHiqP7531XnrK9BmvTbOM/CzWOhpO1e0iVRxtQ/ty3AeYvAlaeen4E96?=
 =?us-ascii?Q?bx2s076jUFXZgb+2xM2NH8/ABcXsTXpmvWTF1HjLwqwJ0bIgXnMqfswahO05?=
 =?us-ascii?Q?v9QMDiwa0VDXYgBYqjQ7RALsyLtfyld1LxYY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 07:34:45.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3976a117-33cf-4acc-e66c-08ddd972b5f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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

Add the amdgpu_aca_get_bank_count/amdgpu_aca_clear_bank_count interface

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index d14dee8d6632..d3c25028aecf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -490,6 +490,8 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 		goto err_release_banks;
 	}
 
+	atomic64_add(banks.nr_banks, &aca->bank_count);
+
 	ret = aca_dispatch_banks(&aca->mgr, &banks, type,
 				 handler, data);
 	if (ret)
@@ -776,6 +778,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
 	int ret;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	ret = aca_manager_init(&aca->mgr);
 	if (ret)
@@ -791,6 +794,7 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
 	aca_manager_fini(&aca->mgr);
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 }
 
 int amdgpu_aca_reset(struct amdgpu_device *adev)
@@ -798,6 +802,7 @@ int amdgpu_aca_reset(struct amdgpu_device *adev)
 	struct amdgpu_aca *aca = &adev->aca;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	return 0;
 }
@@ -875,6 +880,15 @@ int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en)
 	return smu_funcs->set_debug_mode(adev, en);
 }
 
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev)
+{
+	return atomic64_read(&adev->aca.bank_count);
+}
+
+void amdgpu_aca_clear_bank_count(struct amdgpu_device *adev)
+{
+	atomic64_set(&adev->aca.bank_count, 0);
+}
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 38c88897e1ec..e9acfbf57a44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,6 +202,7 @@ struct amdgpu_aca {
 	const struct aca_smu_funcs *smu_funcs;
 	atomic_t ue_update_flag;
 	bool is_enabled;
+	atomic64_t bank_count;
 };
 
 struct aca_info {
@@ -225,6 +226,8 @@ void amdgpu_aca_remove_handle(struct aca_handle *handle);
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
 			      enum aca_error_type type, struct ras_err_data *err_data,
 			      struct ras_query_context *qctx);
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev);
+void amdgpu_aca_clear_bank_count(struct amdgpu_device *adev);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
-- 
2.34.1

