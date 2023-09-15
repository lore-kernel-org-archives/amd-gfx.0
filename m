Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F58CEE645C
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 13:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E383810E628;
	Fri, 15 Sep 2023 13:29:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F4710E628
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 13:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD5MWh0/ECqAdv4NKYi1g8UGxXDXyDlNHeojAXVRYfIgMTV8EILSjE+UvyN4XD+jseGrQPGcWyQqDRYJmcH/hPMFaE0cDRVlK9t/nJ1lQW0Z/co2vJqRxQ6AntQp+zklr6LgU8tSLZwPFykdHEK5LVoKOz2BeOdTdwmMjH0/5tE/3Q+Gi1+dOdtEesXpRDnZsQlJktEYEOgDxrK31vBuiNhACuXNHnD2rAskkMjXHwKt4aAUufWuTvWPKFZBE+jjxmtoVHV3k9cpPUUyU9yYtZuVIQfPZROr/hzWOSczbt0FbamabHOMkBf2XthRFziuJLWsnm2aoDgNCua6ciXuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qoyyq0EUzCT14X2ntYfTATBwBpI5vvsnoKJb/Br80f0=;
 b=iKPE5D3YVGtUmODKOp/GgJ4D67qFjRHHJEi5Y1YQP6Zd/xeuY96Kdi5PIpgz4EP2mxPg0AGptGuoWPPciacf5K1ysYpSv69j4/ZkJMjJDEU1bcmVUsJ8FCtPXEmuvAs46CY5Ri1+/59f8AKrwVAo2eKHjnSH2utSxNSZ5dZ9q0ZClrrPSsGNguLMoGqBzuFuBBdkUWeyfnEh8WhXjgmAjerU1tT6N2EklEm6htHkjrCa+6ZkNznvHGOV59UigKxeJ2YrrQzmP5X/XDfDS6Aq6k7n1iEVZy/XANZi+FBPJW8f3T4iHm33Rz9oss8Nl3khtkx2ufMqxEq5FDoSblSSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qoyyq0EUzCT14X2ntYfTATBwBpI5vvsnoKJb/Br80f0=;
 b=FEC1HFK3OyZKPjzM85PGaQo2ibk49QXnDZNmpPBd+SBOssisU6Lw8k4Oxph6a7vWNiFV4Yv4FZgkY2jg6QXhtKjrZSQstw/3H9Gw3x8dx8tkuDfKWrW8zxxmTA38q+6j2Dg9UbCttqhixnbuhDiTmBKEAOKaHZytGsvKheiHQuU=
Received: from BL0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:2d::30)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Fri, 15 Sep
 2023 13:29:14 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::ab) by BL0PR03CA0017.outlook.office365.com
 (2603:10b6:208:2d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 13:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 13:29:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 08:29:12 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: handle errors from svm validate and map
Date: Fri, 15 Sep 2023 09:28:04 -0400
Message-ID: <20230915132804.20813-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230913151617.18894-1-Philip.Yang@amd.com>
References: <20230913151617.18894-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 374a8f96-fc88-4e27-e219-08dbb5efc0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rN3dGJUXGC/B7/o9LtPl2+kI5JnJGlVcmzV3l4FBawy71fMOqJ8Hisb5YlZI5RX0JNDOgOzR3toQ3DKOrZLOo2dfMw0x34S39Ys0ClGjBZcHKu0ykgdrTCqMZhaJybcnVlu0WQ28LeDlPJTPBYjqgJAOeSm22Z92JPk38y+asx2v4cey1qQnILk7BrfRNhztEEnxZBCa9cTHIvXEt0qX7Um+0Ry8Fwpfxx0743lpvyrJRUGkbCqJX+q94O+lGt+xeE3vzXvYEQRtlMq0EuH9AS8yDtigiEZvjhyBvfsbLK5onu6kGXsZfJ2tVAjGe4HuUd27PtPlfpmpp+oreYnbGIoja70IAiDTR0s4YMgVknQvG/l5EGlSKsdPR73u30jqY7BC6X2oylNv3MRg/yXRc7kDTU+yaikhsXZm9YztfBUdZlwMEN5ekhI+w0UDD5mXr8ZOnWfDiZURyVMlfJFID2Hq/tr+67GXdoZzxCNWjYcRwq3b+9hRiItnE9J68rHUUN2V8NeNkuESi3OmnE6ekkq/Dxh2DS7vCewJMJvKYbACIQkd+Pomy5/RmGm1pYkHLn1HudiKKSJhPGMeK9wAFJGtosg85K2mU4e1eavfJsBSphc87huYMtrMh4GDUg4S9NcmfFk+dITZurVbS2l/45/HIfbQ+LDNKmQ+vwQ/XJaEbGCUKBnMZ6UesF08QkPYkTc1UfFZQz25aEVQVgQnK9ZZK3o7zZ+8AtO6oaQGRBtzKR8lMNPZDHv7cyqanu4pqgHNXIxSDCVkEYL/V/wgbIngUtuNIuZdbxo2xEirfY8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(47076005)(426003)(83380400001)(26005)(336012)(1076003)(16526019)(15650500001)(2616005)(70206006)(4326008)(6916009)(7696005)(54906003)(316002)(8936002)(8676002)(70586007)(36860700001)(41300700001)(6666004)(5660300002)(478600001)(82740400003)(356005)(81166007)(2906002)(36756003)(40480700001)(86362001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:29:13.7176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374a8f96-fc88-4e27-e219-08dbb5efc0ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If new range is splited to multiple pranges with max_svm_range_pages
alignment and added to update_list, svm validate and map should keep
going after error to make sure maps_to_gpu flag is up to date for the
whole range.

svm validate and map update set prange->mapped_to_gpu after mapping to
GPUs successfully, otherwise clear prange->mapped_to_gpu flag (for
update mapping case) instead of setting error flag, we can remove
the redundant error flag to simpliy code.

Update prange->mapped_to_gpu flag inside svm_range_lock, to guarant we
always set prange invalid flag to evict queues or unmap from GPUs before
the system memory is moved.

After svm validate and map return error, the caller retry will update
the mapping for the whole range.

Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from svm validate and map")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5d7ba7dbf6ce..26018b1d6138 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
 		}
 	}
 
-	return !prange->is_error_flag;
+	return true;
 }
 
 /**
@@ -1724,20 +1724,17 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 					  ctx->bitmap, wait, flush_tlb);
 
 unlock_out:
+		prange->mapped_to_gpu = !r;
 		svm_range_unlock(prange);
 
 		addr = next;
 	}
 
-	if (addr == end) {
+	if (addr == end)
 		prange->validated_once = true;
-		prange->mapped_to_gpu = true;
-	}
 
 unreserve_out:
 	svm_range_unreserve_bos(ctx);
-
-	prange->is_error_flag = !!r;
 	if (!r)
 		prange->validate_timestamp = ktime_get_boottime();
 
@@ -2106,7 +2103,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next = interval_tree_iter_next(node, start, last);
 		next_start = min(node->last, last) + 1;
 
-		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
+		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
+		    prange->mapped_to_gpu) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -3519,7 +3517,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct svm_range *next;
 	bool update_mapping = false;
 	bool flush_tlb;
-	int r = 0;
+	int r, ret = 0;
 
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
 		 p->pasid, &p->svms, start, start + size - 1, size);
@@ -3607,7 +3605,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 out_unlock_range:
 		mutex_unlock(&prange->migrate_mutex);
 		if (r)
-			break;
+			ret = r;
 	}
 
 	dynamic_svm_range_dump(svms);
@@ -3620,7 +3618,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
 		 &p->svms, start, start + size - 1, r);
 
-	return r;
+	return ret ? ret : r;
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 9e668eeefb32..91715bf3233c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -134,7 +134,6 @@ struct svm_range {
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
 	bool				validated_once;
 	bool				mapped_to_gpu;
-	bool				is_error_flag;
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
-- 
2.35.1

