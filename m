Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505C0C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 16:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1673611CA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 16:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1673611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E616E120;
	Fri, 28 May 2021 16:51:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CAC6E120
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 16:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe4a/jGg3bJy5T8/rUV2fGxWXZ4RpbO9tMJ5T1j8AylEf8NV21l1mOsKSfLV5X3CH4zZGA5HReTCOxcp51mYpbsj9UfKRtP9/uUtj4jiGhi50STjLfkxDw4CU8nAqHOK0Zm9BUhF3/+EtB/g46CBFchONMCxXvI7/dBnGdGrnCAgIffcYmdjfV2KkA9hQ2Ma4cBtSes9N76VCSY53IfzlH/GtZFV6Chs7nYoM09uQnA5x8ve3YJoZK8R2svK+6/CBb+V0Z64gwfdSHEdtY04IPLC68IlSKX0Univ7XoOy62QtP0+qdYhgWxmlyyVai10zeCANh61SJG4FgKVv9jXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0cpGO4muwTUCpD+vTwsmNBF5RYshVoQ9LxHDMO7TcM=;
 b=MRyGGvyUavic619ubGmTL6e2/PEA/PJk8mcRpJaYDaTot6fiAhL66Sdv25yrSEGG6zSqqBR+3NUI4L5RgW9/kh1CZrnLOsFUGzgF/VNF6Ip50FuxkPSv62uDPEMd7yxZgPS0OffqC9k5i3qf8ZkOCPSGwgUhjaCQE4WLtMGKmJBgLLA/Tt9W/S4sM8JsYLX++yrvahxKyEgSap3JuzMKRkMceJ/6VlCRAuaMC6OU3lW8fgMtHPmyYTdRN1A2ERx3S5Qp0zpCgB/k55ymVmo8mfA5Tt0MeKDJqr3fbJ//4TuGZhscvjouZd25Pr7UTgTi0k799scCdh6i4VVeayluiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0cpGO4muwTUCpD+vTwsmNBF5RYshVoQ9LxHDMO7TcM=;
 b=fCJyV4eRE+rv6ZAhxI4ZXhz61+drGU/2h6kEndHsuLrdOISktMwfBaX9oEFBUWvk61Qudu3SkZamylHuoT/nFM3X8hqxHQ8WeNwQLQSLLKWLCPOwOcvDTYoRm35L6vP+9iGVhopXc2g06ofru2MIKoFjl96k7R/R41ybO8iKF8M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 16:51:23 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 16:51:23 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 1/1] drm/amdgpu: flush gart changes after all BO recovery
Date: Fri, 28 May 2021 18:51:05 +0200
Message-Id: <20210528165105.96761-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR3P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::31) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR3P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 16:51:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7782412-b5ac-4f56-7f1a-08d921f8d378
X-MS-TrafficTypeDiagnostic: DM4PR12MB5103:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB510382DC54F0FFF481B435CB8B229@DM4PR12MB5103.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3/DIYdZUrdob+pus/t7wnv8uQyF87wBBel8EcsWEF0LCYJSIm/6U1hx38bSHzpHug7L87A8ghWPZkDskck5MUNhdrNHoJXYWECLC/A9HBh2yN03QaQG0QLJsc8h8An3QyqqQgrBKpnFGOszEcEcikFVOS05ZUJLLRzQxFuO32YJE7ht1fMINwCcsvu5wh9kfBEfl2NIJqH8dT/6UzQ32qMZI3EYvkT8e2uos9r2u8E7MI5cDbXoVV0z2sCTe/0P4K8Wnz4o30ybNHNVJum3s2VpJEKat/CiU6Ql0VVucRqrrwn9qtp3AnoigRLT08GSbpHmLhPXd6MZKMMTaBWSwT0bXe9jLci48Wir3G6Pda1yt1o5UWSDedhIftizKD0D7qi2avMx4b6qIPboc+JP7g6R4CnMFDyLqXe20evesQexQFxZbEybn0F5AC2PgZEIo+lPyUpQ0GrqB8KB2STJkGUG9lQjhH+0oxM/hCLgxzQWFnR3y93AI4sj84pEJLsfMAv2tMvwy190tXT5WQUdy39tERnr1ztmulqLsQ9UL8M3XGR1bpK7ONiaGWXK9kuUXppiya2yLDZkNQf3OmUhuJVwM4UKyDHoa6lMd9iLN0e80i/L5tg0McwZ4lzjN2RYHucjN2lposPJz5kI2q8JZ521raUlknsMgsG5lHopHtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(396003)(136003)(346002)(376002)(186003)(16526019)(8676002)(6916009)(44832011)(6506007)(26005)(38350700002)(36756003)(52116002)(8936002)(38100700002)(6666004)(86362001)(66556008)(66476007)(2616005)(956004)(2906002)(478600001)(66946007)(316002)(83380400001)(4326008)(6512007)(5660300002)(1076003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u4KauhlX0iuNFFpLfgmYaInW3YDlToyO30KPAvaD4vJXcwDsYBjs7QeepFwu?=
 =?us-ascii?Q?W3g9KUdsE74eAeJEt1X5YrFIHnLz4qXTyDhRJU62QwNM/b13XWWpV2R2pCEm?=
 =?us-ascii?Q?+Y+C+YRdDNiEhMxR265l/atwArYei9sXtLmvE2NE+4zloXnKw59ivcB6/PrJ?=
 =?us-ascii?Q?cirewZkT6srJdF1UNxUpg/40P3E6Q+2su0u4BZcnubFWPIrik4D5dprMS1l0?=
 =?us-ascii?Q?dkjPowyMPCkaRuxT5+vdUzkZk7aimZh4crdcLRizxLkaJYv1okLPQlyVHL0N?=
 =?us-ascii?Q?wOxYk18TO4o85/oezSBJ2PaPJziv9DBQc+cDDPhOlsYlHJNnRDOP+OhDzjTx?=
 =?us-ascii?Q?eGO/G9wWkhGtbTKlHi2tVYv0o32E88Hy1PSOxHzS1zvRvtbgNNpOc8cUVPS/?=
 =?us-ascii?Q?TTkYmm9xYB2OFL4e62wvTNel/dQtvPE/NCT1SAN0RNMrm8gjWAxTgmdat8uO?=
 =?us-ascii?Q?tibKKTE4fZBhW9tvPEnv374EupuJNpaTTJUTsTe/7sCvJSaUuh+veQxQjljS?=
 =?us-ascii?Q?bef3BvNBAYEJMGcmHHugfhkR69DQMyJBq5fHotdys7AUawSoiz0+w+DE2bTF?=
 =?us-ascii?Q?sN1yaTap0OCBpEnnRakllCUg/by8ICkHZE7UBFDdDgvTYbX586oo56tgGI9E?=
 =?us-ascii?Q?DBFTl/IuEutstwU+cTFo+wVJGVqNgfTbLnwqG4FWw2ijY3WE6dchzMnYdOo5?=
 =?us-ascii?Q?thQ14AaEQ9/lPOFTy1zOeTWRvB7WGA1CdRcf4yQmj/65vhyDAZBtrHo6ZPI8?=
 =?us-ascii?Q?3nJ9IQHwBk9ttZrE+cOLSUdBQ/rr4VLigYYcxLWtyTcwOs5r4pwVP9Nh/On/?=
 =?us-ascii?Q?7xyab9aLEBeLGnnKC4CIjjmZqebDJ3LWcznMci5exwBg35bc7hGQQX/6ad5b?=
 =?us-ascii?Q?oif15+iM/voWIiI9VpqAIiAeRf71LyME0Zzk7KHQMGrtldj+jWEAd6lP6CH5?=
 =?us-ascii?Q?34H6dKola6zWE7FF8TvhImyUgXh7gXa200JS1tJ2Jpmow6Pf8ggNdBOUtzzS?=
 =?us-ascii?Q?1V4XYq6rWpM50A7orHUh0PWeykz2JTya7inYtqe8HApbROeqLdfKxVcN+tAC?=
 =?us-ascii?Q?tcZI8oIX7fIEzXdThtpoeTMNNJrOXNSWBhF21vVrHVDIgcCKO2Xcl/qB2vyi?=
 =?us-ascii?Q?aOzcRizto6Xa9k4XeFuWELGrh30agWeSSQOs9uNjUlLt2ii86DTYrl1SbQBf?=
 =?us-ascii?Q?FCHLAN++9Nyzg065DuXdDm7qHSzag1HRnBaz2M3r5WxIywSOZDKRedVbYDT/?=
 =?us-ascii?Q?Nofc02VMfKkkBlDa2FLZa2jiUzu1rJXvqBBTcD6K5aOwZZhAfzp5jzk7wCMM?=
 =?us-ascii?Q?iSeBD/CBA+k4vkrh9BXJR7uG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7782412-b5ac-4f56-7f1a-08d921f8d378
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:51:23.4106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzJ40ZImwfGL8ov3M0GbLCsWER94fl9TlFWRmA+tb1GTfHxvkuHYV8FRYU4ED7P00gnrVNvIvUdj3cxBCzNsiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't flush gart changes after recovering each BO instead
do it after recovering all the BOs. Flishing gart also needed
for amdgpu_ttm_alloc_gart().

v4: use container_of to retrieve adev struct.
v3: rename amdgpu_gart_tlb_flush() -> amdgpu_gart_invalidate_tlb().
v2: abstract out gart tlb flushing logic to amdgpu_gart.c

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 22 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 5562b5c90c03..35cc8009ac7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -312,8 +312,6 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, struct page **pagelist, dma_addr_t *dma_addr,
 		     uint64_t flags)
 {
-	int r, i;
-
 	if (!adev->gart.ready) {
 		WARN(1, "trying to bind memory to uninitialized GART !\n");
 		return -EINVAL;
@@ -322,16 +320,26 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 	if (!adev->gart.ptr)
 		return 0;

-	r = amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
-		    adev->gart.ptr);
-	if (r)
-		return r;
+	return amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
+			       adev->gart.ptr);
+}
+
+/**
+ * amdgpu_gart_invalidate_tlb - invalidate gart TLB
+ *
+ * @adev: amdgpu device driver pointer
+ *
+ * Invalidate gart TLB which can be use as a way to flush gart changes
+ *
+ */
+void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
+{
+	int i;

 	mb();
 	amdgpu_asic_flush_hdp(adev, NULL);
 	for (i = 0; i < adev->num_vmhubs; i++)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
-	return 0;
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index a25fe97b0196..e104022197ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -66,5 +66,5 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, struct page **pagelist,
 		     dma_addr_t *dma_addr, uint64_t flags);
-
+void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 8860545344c7..a1cd775fd61c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -206,10 +206,12 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
 int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
 {
 	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
+	struct amdgpu_device *adev;
 	struct amdgpu_gtt_node *node;
 	struct drm_mm_node *mm_node;
 	int r = 0;

+	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
 	spin_lock(&mgr->lock);
 	drm_mm_for_each_node(mm_node, &mgr->mm) {
 		node = container_of(mm_node, struct amdgpu_gtt_node, node);
@@ -219,6 +221,8 @@ int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
 	}
 	spin_unlock(&mgr->lock);

+	amdgpu_gart_invalidate_tlb(adev);
+
 	return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c0aef327292a..786650a4a493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1014,6 +1014,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 			return r;
 		}

+		amdgpu_gart_invalidate_tlb(adev);
 		ttm_resource_free(bo, &bo->mem);
 		bo->mem = tmp;
 	}
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
