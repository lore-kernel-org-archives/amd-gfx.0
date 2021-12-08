Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61736C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 08:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A616E5CD;
	Wed,  8 Dec 2021 08:25:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 780C46E5CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 08:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czg0PX5Qqyp77tQfBCAOO8ChMTU7IgaGYLBfv4YUnG5eeY6WaZGwFealozyFZM1vql6EFM427SOZInV4j6xSD8uFYlfpgthXYgJM/Ip4gLMs7Zte9jGc3ePo57cLkvVaHH3jQV/jEq445KwWw8n0TV3vZnqySCPakDV+EtjHUaNRENxeV2eVp44GyloWOmD83U9BRZb/Gly0L4zuIqJBB+gmdVhhtya5sBrbTYf5WbcegzoA+XSwycLNGNfLe7XF2NPuIj3Em70yGkKlpdsehvQCz01jRLZTU9q21o2LmrCPZ8tTRTtaEWmBLm8+W+Ihn0cMKP25pp/kWfuiPSVQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8vN0a7k7aS/X4/bGm8As2F6pVP1oW7ZgqgXIivnyuY=;
 b=XGss+rNrg7JkymwZx9MJ+hSXNRwjEPRVViPAxHrbRBUtkfQERKj2t/VjsrwqIsnyeaiEXykXfGE/mVzdJmAvQKpMvjh6ZLB1QKi6zw6jyCUJRlwfz4V2OMsfTqwycUVvGEtY6ZCwPKkvoEa1rgiaHZYZLKaHVzDfywcY0hNl7l4JWcWW2VIMr+sHCa0g0omzd8GgTvfPr81y8po2ivNS5in6w533gvwk+gkY4jY/g1PTo0ipC70lm2Ul4Xc/uX+eml5o3qiU/SIHDWyhxrMntGPp5ebbu3+lI3b/pKAeD94/ovoeBPpArJojfzOwLEc6H5S3XhYq+gs2KNzE8nrOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8vN0a7k7aS/X4/bGm8As2F6pVP1oW7ZgqgXIivnyuY=;
 b=HLqD0Xw6cpmpxIKueIZxOE5y0gDGvXZpfu/i61JB3Os/OQqOqxJYeTO+VqPRf2l1i8xGvfpm+CRnDsf8sFCV9Xj0OpOgzSe10hRMlZnXdHIFCNNFpwn4L4Iw2OtKEg4Nk/N/eW4bJaDFjxVA3LW6AjEO4jpsUFesAPLS8ON+Cdc=
Received: from BN6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:405:2::17)
 by BN8PR12MB3489.namprd12.prod.outlook.com (2603:10b6:408:44::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 8 Dec
 2021 08:25:13 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::2c) by BN6PR11CA0007.outlook.office365.com
 (2603:10b6:405:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 08:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:25:13 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 02:25:12 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: Fix svm_range_is_same_attrs
Date: Wed, 8 Dec 2021 03:24:56 -0500
Message-ID: <20211208082457.918004-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208082457.918004-1-Felix.Kuehling@amd.com>
References: <20211208082457.918004-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7d14240-daa8-4aa9-83fa-08d9ba2441d0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3489:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34895FCB9050E209A6B90DC5926F9@BN8PR12MB3489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnM6wDoLWNkAyaiz0RZLZiTWi6TzF9eOIFj/2Qdo/HG8pVBjm1iEDwvjfetGSTaKM4RJf2FBAAJ0mEGLGi5u+87j2TTvnxWt9mtL75Bf3i7E7IKxbYm0YePmgtUkOzj5WFtj6VsLDzfVJhlNbt6fAJqtMzEELC+4YSAfQQDvyurjpLXDnWKSIEdQTHHX5M56HJfnVcgSPBFxiih4lHwGsiEMsbD1oEugHAt3xik+uEXHycmN6NdCfITxQz8o+/iD9n0/nVdC0J9IjzMBWLpvLfPCBY2E/OHMRCuf2Mdd1yNAhHSxSXwpuomHSZWp9o052cIw7iyHr99Vv0WuyX66EDqYFcM/LaRLZynum1YjK0Lc9eCx9qi9DyW4IVIpl+44qZ37QEUWfR57pNxvRFWy3dKrmFPelEm4XqQkrP9tAFRl4Znu84bqGI1zrn2HT/l/O4/3NM1zdbMtcIpu+32r2D8oL2ESXN/CHeUu1tWXTol5crbSww7F8b9VyIU0fd9gVBFxFbLtX4az81Yz4e84+U2JknapR/8xL2LtLuZTo+8EEOtiaMvo0JZSIfe/Dv4HcoK7j1XMh9P2UPTVhfFtWqH6JSbqhOOj2y0mx2I+FEuJuvoJnJ/u2giph5LAZyYiFo51W1Xv7YfAYYv3CedLJCgjUAxjor4CqT8QNEM4B8Nd9drqxeIiM7Q6wmgvye8cl8cV/f1M8lJogzwnH8nBLoLtmxhIJV3+Hmvny8yc61sUr/Q1VlSh6BnNN3rGWNM8tbGaOeaqG0AwrPiW3O7ILkx7O6UHP1963PB5SKHFDdc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(1076003)(7696005)(36756003)(70206006)(70586007)(6666004)(4326008)(8936002)(47076005)(2906002)(426003)(16526019)(2616005)(316002)(86362001)(8676002)(336012)(356005)(186003)(508600001)(6916009)(26005)(36860700001)(54906003)(81166007)(82310400004)(83380400001)(5660300002)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:25:13.5096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d14240-daa8-4aa9-83fa-08d9ba2441d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3489
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
Cc: alex.sierra@amd.com, philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The existing function doesn't compare the access bitmaps and flags.
This can result in failure to update those attributes in existing
ranges when all other attributes remained unchanged.

Because the access and flags attributes modify only some bits in the
respective bitmaps, we cannot compare them directly. Instead we need to
check whether applying the attributes to a particular range would
change the bitmaps.

A PREFETCH_LOC attribute must always trigger a migration, even if the
attribute value remains unchanged. E.g. if some pages were migrated due
to a CPU page fault, a prefetch must still be executed to migrate pages
back to VRAM.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 69 +++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed4430e31307..9ea3981545e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -704,6 +704,63 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 	}
 }
 
+static bool
+svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
+			uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
+{
+	uint32_t i;
+	int gpuidx;
+
+	for (i = 0; i < nattr; i++) {
+		switch (attrs[i].type) {
+		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
+			if (prange->preferred_loc != attrs[i].value)
+				return false;
+			break;
+		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
+			/* Prefetch should always trigger a migration even
+			 * if the value of the attribute didn't change.
+			 */
+			return false;
+		case KFD_IOCTL_SVM_ATTR_ACCESS:
+		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
+		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
+			gpuidx = kfd_process_gpuidx_from_gpuid(p,
+							       attrs[i].value);
+			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
+				if (test_bit(gpuidx, prange->bitmap_access) ||
+				    test_bit(gpuidx, prange->bitmap_aip))
+					return false;
+			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
+				if (!test_bit(gpuidx, prange->bitmap_access) ||
+				    test_bit(gpuidx, prange->bitmap_aip))
+					return false;
+			} else {
+				if (test_bit(gpuidx, prange->bitmap_access) ||
+				    !test_bit(gpuidx, prange->bitmap_aip))
+					return false;
+			}
+			break;
+		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
+			if ((prange->flags & attrs[i].value) != attrs[i].value)
+				return false;
+			break;
+		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
+			if ((prange->flags & attrs[i].value) != 0)
+				return false;
+			break;
+		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
+			if (prange->granularity != attrs[i].value)
+				return false;
+			break;
+		default:
+			WARN_ONCE(1, "svm_range_check_attrs wasn't called?");
+		}
+	}
+
+	return true;
+}
+
 /**
  * svm_range_debug_dump - print all range information from svms
  * @svms: svm range list header
@@ -741,14 +798,6 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
 	}
 }
 
-static bool
-svm_range_is_same_attrs(struct svm_range *old, struct svm_range *new)
-{
-	return (old->prefetch_loc == new->prefetch_loc &&
-		old->flags == new->flags &&
-		old->granularity == new->granularity);
-}
-
 static int
 svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		      uint64_t old_start, uint64_t old_n,
@@ -1791,7 +1840,6 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	unsigned long last = start + size - 1UL;
 	struct svm_range_list *svms = &p->svms;
 	struct interval_tree_node *node;
-	struct svm_range new = {0};
 	struct svm_range *prange;
 	struct svm_range *tmp;
 	int r = 0;
@@ -1801,7 +1849,6 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
-	svm_range_apply_attrs(p, &new, nattr, attrs);
 
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	while (node) {
@@ -1848,7 +1895,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			prange = old;
 		}
 
-		if (!svm_range_is_same_attrs(prange, &new))
+		if (!svm_range_is_same_attrs(p, prange, nattr, attrs))
 			list_add(&prange->update_list, update_list);
 
 		/* insert a new node if needed */
-- 
2.32.0

