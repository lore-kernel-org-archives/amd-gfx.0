Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA573C4167E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098CF10E44C;
	Thu,  9 Dec 2021 16:52:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A5E389ABE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 05:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6Do3Kpmn3U1f09J70+c4tIpe5d7g8lTEn+GJCkDgRQBECqeSrd4k6+bN8BWwa14UxlslFFz9tdZH/xA6v3d/F8mjm0oDD+eNuRQXvFrf+csQ+O6Me2LAFHJ5w7y/I+88F/DFSlpuHfKityocfvRwbA7FqtBkJwL6cVUUFt8e2uoqy076t4hJv6UoTUczwbMRihsRm3vuUCG0Siqcp1bdsmkh2eraxvIohMc8l4Jef0Fhk2zhkIMcGjIMSrQmXV5CPNuGIdqCBX+GR6YDEhzL0NCScr26f8NN7/Rb1IFI2/1heAfX4nseWbITABjFMWWlOXreYKjcNM7dfAPISv5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l87zjR/DuaDtn/GjHD3PdTEmcuALqbRM/uJqtUoxCU=;
 b=G6RfixMkG+mVcqzLiFwgRJSaXw4AkChvX8GzORwRovqWHHQ182eU+wE9jgcOaG5i6sB42KN6TL3n1IvqZuNFEQKzKCMg0x9FGVrw/wnWCZ2CtIAmK10uqxSuTYA42dOTVhDfTl4F2O3cIfUlp8mj3H9NduVmWJLG3yFrzvAA7hovj/2duAXzwbTsVZF+njpXKNqYj/78fcCNt09PWYOxgCCde2f4dOAEmlT+uMXvg6x4CyDxDcmLEUcxJ6kvU4MRXQGK9IZLNp//DcBJafE8aT8g+++thoTxXtHeWHzNazJwnofHawlR5x0dOuGzsm93HcttozZqA5H8qeLCxznqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l87zjR/DuaDtn/GjHD3PdTEmcuALqbRM/uJqtUoxCU=;
 b=4qV5d/3U2gnYlznQuE9NHSbtUj30uF/7+dWvYTQijdqfIEPSbJSSW25+w10Hjvx7wOHBM2/sG7Cx4XpVhUv/xlwC8pLiWxHFHwaeMW1Bbn7hU0ZATqCBRq2aRbviLnKDGB+1Yk01EeQ0S1BbPTM9c+CnzlSvcjmoio5NZDurJ/U=
Received: from MWHPR08CA0057.namprd08.prod.outlook.com (2603:10b6:300:c0::31)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Thu, 9 Dec
 2021 00:04:16 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::bf) by MWHPR08CA0057.outlook.office365.com
 (2603:10b6:300:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 00:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 00:04:16 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 18:04:07 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Use prange->update_list head for remove_list
Date: Wed, 8 Dec 2021 19:03:40 -0500
Message-ID: <20211209000340.974954-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211209000340.974954-1-Felix.Kuehling@amd.com>
References: <20211209000340.974954-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd1081c6-f326-433a-96ed-08d9baa770ba
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB312710BB40C048437B63C55C92709@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3+sb1aOsIZpFJyk4Z1W6udmuyiCXCifMkNhc61iztFHAHfzAasRGgsfV3+xOuz6xbMzPwLwNAPmq+L2TCCKcdrj2dtisFilAOwuE1YbVCagLYcl5RejRQrODz035inn7FLXfMPgSutWhlPUPWWqZmqxv3LZeGSBBMfIOpvI2elVckWbF7i5MXpKs1T8LgxYdT+hhy97Zo87onfGD40iM1XyUuITKsYc9o96kMfuIOTdoWkbxOSqP50KjpKMeSnpfjFUSESiw5sXhim1ZWyQFWmZ7qz3mGLAsYhIJXmZABl9MvQ+wb2zH1k0IWm37sMqkTLJfkenAuUYqD1I+Tbb2hyMUOoa6W3+PFM3aG23GsurUjmLEaBkl10IOOz2Z3ZQ0eOslU/emttnx7m2hTFR8d0HkaE+bAqnjnRhTI2hP/CZ4xdT/pGzg4ujyrCD3vl0M9etg0TTWbVP8HzSQRmizXSlyvi/lU7X1f3M+vZNvWMhJyErfI8Rlwt0pThHGb1wPyvOcXATe2m1stxXVNPPquMf3tL0dawa8Zv1qSr7IbrNcMjRnNVsIrg6s9cZcsEz26wkp1bdknikIBQOcQjMTXzpqN70wWynWbwoJm5l2jb09t2kBVzqoZdnTAaPswDsw+zzhJvxH1SH7F4wEbxH/RxIzD3wS/jNk8wcpNBx6pR4Th67Enf+2pKYIjTJrct9hFAodEwcvH6psKoHqSi4xKR+mak7AUJ57CsWGaK/DUZsewmkjGnidSSd38s9YrrGy/uXE3W79MZZu+fQE4OIl/ntmhqxfR0pfjfVEGvyxdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(54906003)(26005)(8676002)(5660300002)(16526019)(2616005)(508600001)(336012)(426003)(186003)(6666004)(6916009)(86362001)(36860700001)(83380400001)(47076005)(356005)(36756003)(82310400004)(70206006)(4326008)(81166007)(40460700001)(7696005)(1076003)(15650500001)(70586007)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 00:04:16.1555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1081c6-f326-433a-96ed-08d9baa770ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
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

The remove_list head was only used for keeping track of existing ranges
that are to be removed from the svms->list. The update_list was used for
new or existing ranges that need updated attributes. These two cases are
mutually exclusive (i.e. the same range will never be on both lists).
Therefore we can use the update_list head to track the remove_list and
save another 16 bytes in the svm_range struct.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index dea7c6236be5..ee7e1eb7394a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -295,7 +295,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	prange->last = last;
 	INIT_LIST_HEAD(&prange->list);
 	INIT_LIST_HEAD(&prange->update_list);
-	INIT_LIST_HEAD(&prange->remove_list);
 	INIT_LIST_HEAD(&prange->svm_bo_list);
 	INIT_LIST_HEAD(&prange->deferred_list);
 	INIT_LIST_HEAD(&prange->child_list);
@@ -1878,7 +1877,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 				goto out;
 			}
 
-			list_add(&old->remove_list, remove_list);
+			list_add(&old->update_list, remove_list);
 			list_add(&prange->list, insert_list);
 			list_add(&prange->update_list, update_list);
 
@@ -3225,7 +3224,7 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		/* TODO: unmap ranges from GPU that lost access */
 	}
 	list_for_each_entry_safe(prange, next, &remove_list,
-				remove_list) {
+				update_list) {
 		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 prange->svms, prange, prange->start,
 			 prange->last);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c3738bd35a3e..5edbd7dccad0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -75,7 +75,6 @@ struct svm_work_list_item {
  *              aligned, page size is (last - start + 1)
  * @list:       link list node, used to scan all ranges of svms
  * @update_list:link list node used to add to update_list
- * @remove_list:link list node used to add to remove list
  * @mapping:    bo_va mapping structure to create and update GPU page table
  * @npages:     number of pages
  * @dma_addr:   dma mapping address on each GPU for system memory physical page
@@ -111,7 +110,6 @@ struct svm_range {
 	struct interval_tree_node	it_node;
 	struct list_head		list;
 	struct list_head		update_list;
-	struct list_head		remove_list;
 	uint64_t			npages;
 	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
 	struct ttm_resource		*ttm_res;
-- 
2.32.0

