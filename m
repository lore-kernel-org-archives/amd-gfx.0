Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61A7CAC5B0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A05210E228;
	Mon, 29 Sep 2025 08:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NHSdF6K";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2753910E159
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqVVf1wFlY9m9hpoylrOlJcWCdRc7LoF2/FWHgtCXeL2o8gKfs8wRx5lzwI1A0UyiwXLSaLq1lRbZtmBHJNu/mWmqW4ljIxNo7i2ksFd+c7RCVLsHnaUNJQOLwHyQR2Abbf4nufdtCTEP21jSr2+RDtRsbHLf802ISMME0H5uFQRHHN2JSN5HIzBUSORU71JP+qHc7ShkCIPZBx5WKsqo0l60XUPVy7T6+UlpwOWHjig1xfmlmtij16DsIfNHKafPkmx2szKrxpulTsGf03woX5YT06sQDpfK7zdCqKOj9WNXN0AnV95P5JeIfc05lF9wjfXYYowwKpAjF+Pqan1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YoOzVd26EblY6jtG3Ay+TnMc5u1V7HSjnrPYeYEtNs=;
 b=kgOURYOP+3mal4ggpg80M0TrkkNRDa7HMzxWcJD0NSqcbr85Zc8l/Uw8tVx8vB+OJsG2cwDN7l/r7KAhlCAkDCAde0KiBAEoHqRd5MKGIq5biocOeHgOgRklsWv9tzeQfjG1EcckbpfCag+8dd9RDvfmZ4WVULBctDZgR17WudrCXMsyMrb0tjvqt5EBQZczKFm2QUk3QKqSZa/3tKDQg771lY98A9h/MqoPUrac5Qw7BKl1vtymh7vlcWDVe01zlDzovNMCBQVfq3SgpEANxCeHZlqbXYBPysjEN0pA8Y2bKuZFwUjvR/Iq7AwEcyPnBP9CHYSJ27Z5N6+hvLhnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YoOzVd26EblY6jtG3Ay+TnMc5u1V7HSjnrPYeYEtNs=;
 b=3NHSdF6KquKyUtOsxhRvHPMUBYzYUSlabSc9M3MAxtNW3L9HTpNpGGNuWYf/Xl67y6WJ/gvydLveh2CRKR30Og24uCWyCK5Hb2BZ+a0XVMYIdftDZ396ziJ5w66W8q5NXlEEJJAdYzfhcTJPKMqI8dOrnjhHLQfj7Nv68BEKn0E=
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 08:10:00 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::a) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Mon,
 29 Sep 2025 08:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 08:10:00 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 01:09:58 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 3/8] drm/amdgpu: track the userq bo va for its obj
 management
Date: Mon, 29 Sep 2025 16:09:39 +0800
Message-ID: <20250929080944.2892809-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929080944.2892809-1-Prike.Liang@amd.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 859dab39-056f-41d9-52ad-08ddff2f9659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?buJx64Sq2Yj1KPHHbnrNUlYv73l3FD3CnbZusWFzvZCSV+UaEZy1lpYvA5Yu?=
 =?us-ascii?Q?PhvOU0zcUhmJijBaBkdkwSemgIqsogLVi6PR9e1Wl/T/pzitRvycWa/tTI2U?=
 =?us-ascii?Q?bxnMFTeWmPvi0BxUBCy46yuw+V3FBc6/coon6Ye5NH0BQenmoaGzwjTVgfYx?=
 =?us-ascii?Q?6XEc1ePLJ2u05E+3TSOFqwqH1mJ4H+ISSjU8HxfI30Oe9YHnwoX+MhGrpvbb?=
 =?us-ascii?Q?zxkxWCdb++/slAzp9d8ILigeXChmx7jWa3y+IWTO5WULZakw5uHxEu6ue8Qk?=
 =?us-ascii?Q?8uYk6BqW78t9jnogPH8T0pIqzFv0X20SJKfmjvksRvcDfW2ot76wP4zBFCMX?=
 =?us-ascii?Q?RJfJdPs9f9J0LXX8GZe0J1bZh7I+4DFbQAFMPMDyPQaBzeBJKcDBKrky245D?=
 =?us-ascii?Q?c6/4b8jdik8o+3t7Og0o+2pQ+fYANLpRLiI3HzS/XI5U6jmtkwd9JqW+pEup?=
 =?us-ascii?Q?VOxIAERa0coqCbnjCVh6pK0/3jVsovthxOJiuTD0c2k9EwV3eNzB/XRuLdGQ?=
 =?us-ascii?Q?xObGFq/qIb7Haz3CHwmV+Kz6f1DnC4+CW4E6pcoDtct7H7Ns+aQ6yyOj0Nqt?=
 =?us-ascii?Q?0WDf8nrwt0Em4crT8BzMuie//k6owaJ3UaRV9fhH/FoMQK3moI66dEJeOH9i?=
 =?us-ascii?Q?aym8jvWUle95e2o1VHfgIyLpAa+fC8mZDki0/H24r3aV930rQ6lbcRi5+PEl?=
 =?us-ascii?Q?re7RENBAutZMUQxo4FoaSHCNpT8S5pBklVlEsLe5EHOpynctLSGQBH6UvdAf?=
 =?us-ascii?Q?BmjIZMN1YWyYE+gngNiHI1fjsvPsPFkPAnRhW2xoWWpN3ANYICzR6W5cxqoD?=
 =?us-ascii?Q?xZIGD3qGPVAtJ5yQubUJKpcKcvwCgN7hVFfU515CI3NXVGYKnL0Fslz7ukZz?=
 =?us-ascii?Q?KqZxAlAGOBc3j2BULVBNvCIY07uNVI76uwol2Vi9DiP7NXgswL/71+W4j0oW?=
 =?us-ascii?Q?nIyNpePVRjCULtZtu+eR8EzFBvZtIk1O643tzvD/BxlXTL17l6lgqQp9oVPZ?=
 =?us-ascii?Q?hpmL11k8CshD+0YrEV03E/SMV8+nR6nicgsbnaxXBXEWpULFClcYawmNpa7C?=
 =?us-ascii?Q?Mn7NkR99MI1EH2mmKDDraBA2BXBX8fVYahmmjJ5QJbgMuPcdyBw2EVXTqiv1?=
 =?us-ascii?Q?nbaeAtwPl/nPbbqYcufD6L1iEtnqQMRrxIwtyQjBcjGZF1MLG5aTPIbKtNV5?=
 =?us-ascii?Q?do88IB1FtG9yx0Jj6MleEWVLawDk0OcrO2CaZF01aSrey8ZY2Q7G38O3MH9t?=
 =?us-ascii?Q?+nBXEbzvgx5GItDDJ3v8rLHqN0Gp6Diy6rsRa+BubDOsUpGSsUKrtFj+CgaA?=
 =?us-ascii?Q?CEi3wzLIMwMRXFoOi18LKJMKhpvGBWf7x0AlKBNdQyNwab9isvtleEZdujQI?=
 =?us-ascii?Q?ucCO36AloFS6qQvHfeWrYOUDnhNLRaePbmtq0X6Nydne+DDAIhHAmIZRLZ83?=
 =?us-ascii?Q?d/MG3TqDhIj/X/6gCPKUQXJcZE8JDrHWkUktHuOB3wGE829OBtUO9jssqXtU?=
 =?us-ascii?Q?I4FU9A5LK4AXbuSdPTUZwLGUKQOgRdiHFAWjCd1lHOUiyveQVc1wwDL2CE/D?=
 =?us-ascii?Q?Wte89gPm3jbQEPr8i9Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:10:00.6115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859dab39-056f-41d9-52ad-08ddff2f9659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a9ac2efcd37b..a82b8d30228d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -124,6 +124,32 @@ static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping
 	kfree(va_cursor);
 }
 
+static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
+						struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	struct amdgpu_bo_va_mapping *mapping;
+	int r;
+
+	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+	if (r)
+		return r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
+		if (!mapping) {
+			r = -EINVAL;
+			goto err;
+		}
+		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
+		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
+			queue, va_cursor->gpu_addr);
+	}
+err:
+	amdgpu_bo_unreserve(queue->vm->root.bo);
+	return r;
+}
+
 static int
 amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -229,6 +255,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Drop the userq reference. */
+	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
-- 
2.34.1

