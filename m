Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69A9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 13:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AF6B1EF4;
	Mon, 25 Jul 2022 13:09:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BF514A382
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 09:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHsC8AMgFlxl+9l8FwNISMLAn6iGxYQ2wwYU3Y7iK4Q+ZIpQ8T/nPVz2GBfLVxkJQWV/W++tfaa0na2zfSmNXC41RhR8l/F5fDoV1onhmSpoqohd+/bMuaMfzyAsADzY4c82U9W2q0p7eF0ITcCtPYOhm20iVLBMWon7em157O3t4XpfICeqDsE7XIoN8zOxzjTbvph/OQlJSOeVxEFrmQmAHweO7rnze2WYtJVS35D4tZSK1G2qAU1RwoyfFnoG/od7pZKz1N+V+yQGGkNWPibJlW+GW1B6Dm6plUNAQPy+HmrW81vFMlzaDQF+8vpj6ogsru+WpGZZOIPGaBHNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6HdarEyEq6f4GDYbMStrWKik1hv3aKo11JTNVpe0yM=;
 b=PoML3X92rFPEpoV18IyQDK/JWnLkMpQVw7ZSDHgP7wvHLw/+COWwgvFtAo2J0zYIEEJEPk64+LYSi0dnQSyViFT7XL37D/cPlmm96nDMwSDAE7EkABNf+hrahEBeOMoqHFFv0LPlaCjREky/CGAnv6CMp0wvq5CkbHPaqy052QLneJYGASusDlt15MSlxbQfRJIpS581de1NrCh86qmHPEswpR10q/IaQam8RO2Ai1Nb+c6fOtRkYlSQtUaDkZT14CZ+2bFIe8YhLcoFUjzv91mOGHM1u7gdEOzgvKYA+08bezcQhR8a5xS9ck/B/S1WBgghlL35iOsu1awmfStgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6HdarEyEq6f4GDYbMStrWKik1hv3aKo11JTNVpe0yM=;
 b=cFtwsqdJ5kSlLZW7tObKKpcrsOgdDdG7J9o1wQeNB9juWbtmtCWLDpNVsqO9c66WeHPexPncFGv3DcbRWIoeEGwT0PsIngjyF1NarMizJhkW8zMtI5++VXF3Kyc3zIDuqT5gWH1qXTp0VtZpbPti9r5+IanPSIeVxorkYhNZIu8=
Received: from BN0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:408:142::31)
 by MN2PR12MB3952.namprd12.prod.outlook.com (2603:10b6:208:164::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 09:05:42 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::c0) by BN0PR08CA0015.outlook.office365.com
 (2603:10b6:408:142::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Mon, 25 Jul 2022 09:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 09:05:42 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 04:05:20 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <shashank.sharma@amd.com>, <amaranath.somalapuram@amd.com>,
 <Luben.Tuikov@amd.com>, <Alexander.Deucher@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, <brahma_sw_dev@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] dma-buf: use struct_size helper instead of kzalloc
Date: Mon, 25 Jul 2022 14:34:59 +0530
Message-ID: <20220725090459.585573-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28069861-41c4-4e76-b71e-08da6e1cda35
X-MS-TrafficTypeDiagnostic: MN2PR12MB3952:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nltbL+WY98viATvaYxnT5AFyoS3vJ4LJaykHes4Rj/sK1B0ltDDXFWJ+LfCzxJhnmhGL737Cd5VFr4MxGTwZHRTvAE/jjoRriJojpXpsj/OpKp2jsMMWqYt1VUxoWnn80XO0YSDuP81DSzgM8Ypq+LL0+FWbYGBrKL4XnGLteDXHakFI8BGG09f39/STJOfGjkhZjR3ElEGtuYc7hc+gmW/yvER1Zf4yfQfN3Dl0qRTb8d8vMOhHz1IA6LBSHj9FtJOn2AT5SVnICeDsbD+O3pfbCmZU/ryUyCvtSgPeKGdeVz9Uh9tRqDEUSQTm28CiOStOYpghrQKvU/lmxmR3Asw4PkwBnHR1YdWFWmGvR4Th/pIMkFnqzdUWkYJ57VTW6bMm7c0WEOGe3Q960hhCRSn+geCp+CEpuRZiODuICgQLkqK6HsIlhYjY6a4riZAfBG/4x/sAYpdlP3vmRsAKbVPji1HHFaOy+fbT8Jg9jSbzu2E4DGiQp/0fCwdz1vPpa8XiDT+p+ncyJC+rOhRIQz6hjUr+qu33Pk4kYS4i9gt4ZAQTcpQDqo+QDhaff3rmJQcr/v8hbYXK/XeeOp1YLmGc8Mt9CIywYEWKqljPveyJmrOAhh99xdhiFecs7KZw5Q0B0g4Low+5bbAD2d48kuqmW+qw+Uak1D2WBQa7j5chGmYT64zfajGjA2eCFOICU8hO5lunoF9VXBt8KyT72+CXYNwqzP1NvvomY+c82EF28LNZtxtTxxjXIhIP0DTZ0OHjsVeX6an6ubBLS6a4cVCHM7pa6hMBl55bUmGlbVKqNkKr3ffq/NdddwHY8CnvX76NoPmfAzxgtMSrTyaqFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(40470700004)(46966006)(36840700001)(83380400001)(81166007)(82740400003)(356005)(2906002)(36860700001)(70206006)(40460700003)(70586007)(5660300002)(110136005)(8676002)(4326008)(41300700001)(16526019)(8936002)(316002)(47076005)(26005)(2616005)(426003)(336012)(1076003)(478600001)(186003)(6666004)(7696005)(82310400005)(40480700001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:05:42.4658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28069861-41c4-4e76-b71e-08da6e1cda35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3952
X-Mailman-Approved-At: Mon, 25 Jul 2022 13:09:24 +0000
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
Cc: Arvind Yadav <Arvind.Yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace zero-length array allocation with flexible-array member
because Dynamic calculations should not be performed for memory
allocator due to the risk of them overflowing. So using struct_size()
helper instead of an open-coded version in order to avoid any potential
type mistakes.

Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/dma-buf/dma-fence-array.c | 6 ++----
 include/linux/dma-fence-array.h   | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
index 5c8a7084577b..3ebb6c5fa287 100644
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -70,7 +70,7 @@ static void dma_fence_array_cb_func(struct dma_fence *f,
 static bool dma_fence_array_enable_signaling(struct dma_fence *fence)
 {
 	struct dma_fence_array *array = to_dma_fence_array(fence);
-	struct dma_fence_array_cb *cb = (void *)(&array[1]);
+	struct dma_fence_array_cb *cb = array->array_cb;
 	unsigned i;
 
 	for (i = 0; i < array->num_fences; ++i) {
@@ -157,13 +157,11 @@ struct dma_fence_array *dma_fence_array_create(int num_fences,
 					       bool signal_on_any)
 {
 	struct dma_fence_array *array;
-	size_t size = sizeof(*array);
 
 	WARN_ON(!num_fences || !fences);
 
 	/* Allocate the callback structures behind the array. */
-	size += num_fences * sizeof(struct dma_fence_array_cb);
-	array = kzalloc(size, GFP_KERNEL);
+	array = kzalloc(struct_size(array, array_cb, num_fences), GFP_KERNEL);
 	if (!array)
 		return NULL;
 
diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index ec7f25def392..bd2d2db55840 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -33,6 +33,7 @@ struct dma_fence_array_cb {
  * @num_pending: fences in the array still pending
  * @fences: array of the fences
  * @work: internal irq_work function
+ * @array_cb: callback helper for fence array
  */
 struct dma_fence_array {
 	struct dma_fence base;
@@ -43,6 +44,7 @@ struct dma_fence_array {
 	struct dma_fence **fences;
 
 	struct irq_work work;
+	struct dma_fence_array_cb array_cb[];
 };
 
 /**
-- 
2.25.1

