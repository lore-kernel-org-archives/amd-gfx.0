Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF673C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3AB10E540;
	Wed, 10 May 2023 21:24:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF84310E52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKZNZv+6b4Z1X1jZ9Mfq7TEGZkQIZ5dVdJfGqwVGiinEfVb24RJ+Z2K1GXH+XUBuV2E5gfr0tALW7zB7UUuxViT9PDjRXSYCUhTQx/flMTr8w/zmgLrqemLCadWny70ff+Xl4x3NGZBNSwgxrJEPeh2zlYg9QMOftCacmOzwyIRoTHOwhkmBVuLuMj6WSm99jiBJ15LLYkwfVKMBN5nxK+G7IN27srnQ+tNBWURbwPb83gPLHd8PjJf5h4gCQ9nJHGdQlq4vT6Sljy7O7sMHMTzhRnMQ6dumc4RAptSmuKTRHc2Y6ymMtnKl0lZuaMJhBmgKJrprAPaNvLKOtJ8fCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk5hUQBWBafdfcQhjK0WXmPf0rCdiAxi8pHK03NKoWI=;
 b=btspDhPGDde9gh4IUpqu9YZy3uM22gJFQYgxVS5r+lg0F8XNdJIwcIbqetcLR6CeNbERLmSa+EdQqggrS0n67XX97zaglcucvNcaZaSkBdv8ldPJHqJ6G7Iel70n86G/xwUR0ZUnvJzO15xXrY2Bv//16e5m7JFcrJqHI78PoyfV1u0JtIRbnqzv3tEye7YjTpBMW82NSxa69rLZBqzzb8vWCynPUm0wLLUctrgJJUJ9HGL0jknathEM+wbFCoHtWG6O3FqXGtWTig31n0YW1gwCOhJEjTLXJxyV1VXvBVNi5Qn52suuttH4SDBTeOc2QCGX0S+T4e7P9JrZpv31wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk5hUQBWBafdfcQhjK0WXmPf0rCdiAxi8pHK03NKoWI=;
 b=bnMMU6T0H9KnvQhmDlstlKFrRGBpJhuBaOWogwzlUV0GJV9YmUpSOwpAKf5vTlQe3q5ZEAmRGDz6gSfGJnvJNbCARhR4P420U3Z7nhVyl1Ak+bcnybS78at3nZjvDl0Q65efFmRmDcFjhve7XngodOeUVUqEr9ICe+cPY+SO/ek=
Received: from MW4PR03CA0195.namprd03.prod.outlook.com (2603:10b6:303:b8::20)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 21:23:59 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::66) by MW4PR03CA0195.outlook.office365.com
 (2603:10b6:303:b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/29] drm/amdkfd: SVM range allocation support memory
 partition
Date: Wed, 10 May 2023 17:23:20 -0400
Message-ID: <20230510212333.2071373-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 4958d389-55fe-45d3-8187-08db519cde52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7f5G/eee44GdsY4TXnrVO5XOGoOJDk/cJr+qWX4sPTxZjErvE+VibZgyQXkbJptQZ7j8f8dVDZ00asSISO5Abuuc86jkko9GmbSDrdeS2Z+v+R2w9NGpcJ7UoPsgyGfV8zowS1ThkJLA5q/ZrAufdCwwaL4RSXX03qLcxxPOv/NeM3QPzcl+aPxR2y6eP2HQL0IG69gW6T/pEeToWzkhWG+PSg4OOyQDsULcMcXSC+3ojRO+/89u5ih199ryIbdJVUvRL5jCZtz7LDX0SrowokU52jsl8PYPjWUs8Mqpm8Omgl7osl/doTq80GIw/FADinVDwK1maa6JO9WTPMwgq2qAMax2kUTKXmHfXDwNoCvyJVwsZQXSN85zx85gAnDBC8p4N67E7/0+AtRN/+TjmmJ7okXMRLQpgBXD+l2SnpKEmcHOAYy20W6l2EOxkz6jxk9Bx8Vyjm3AWq0T4N8QBskIHaX0RPmPoFj9V+DRvodPG3KyW5xUVqf40S55UEuATV5V5L2nKlqfAQ1fYeJs4aJjW8Vy2tILCt9oDAJzbHG/CPNc3E5u+eApyCim8VwdJpao7NAL0XKFroLwGoQLuUbRKMU+1Pe/5oXsZFS4PoI+xkzo85zPWPpu/KJN5aNR0EnHKeJrpD0wymmbjMFeI3HORLowmp4OWy8pHIApofhHDqxdWoO7Ed8wTDPJKqTz+jfVEvxZGB+zHY91w3ujNGmHDVIRiocKibImC3yijLA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(86362001)(4326008)(54906003)(316002)(6916009)(7696005)(70206006)(70586007)(478600001)(82310400005)(81166007)(40480700001)(5660300002)(8676002)(8936002)(41300700001)(356005)(186003)(2906002)(16526019)(82740400003)(2616005)(26005)(1076003)(36860700001)(426003)(336012)(47076005)(83380400001)(6666004)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:58.8191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4958d389-55fe-45d3-8187-08db519cde52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Pass kfd node->xcp->mem_id to amdgpu bo create parameter mem_id_plus1 to
allocate new svm_bo on the specified memory partition.

This is only for dGPU mode as we don't migrate with APU mode.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c5675c7e3b9e..f6a886d9e902 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -554,16 +554,20 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	bp.flags |= AMDGPU_GEM_CREATE_DISCARDABLE;
 	bp.type = ttm_bo_type_device;
 	bp.resv = NULL;
+	if (node->xcp)
+		bp.mem_id_plus1 = node->xcp->mem_id + 1;
 
-	/* TODO: Allocate memory from the right memory partition. We can sort
-	 * out the details later, once basic memory partitioning is working
-	 */
 	r = amdgpu_bo_create_user(node->adev, &bp, &ubo);
 	if (r) {
 		pr_debug("failed %d to create bo\n", r);
 		goto create_bo_failed;
 	}
 	bo = &ubo->bo;
+
+	pr_debug("alloc bo at offset 0x%lx size 0x%lx on partition %d\n",
+		 bo->tbo.resource->start << PAGE_SHIFT, bp.size,
+		 bp.mem_id_plus1 - 1);
+
 	r = amdgpu_bo_reserve(bo, true);
 	if (r) {
 		pr_debug("failed %d to reserve bo\n", r);
-- 
2.40.1

