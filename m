Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52149CD3445
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 18:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF6810F598;
	Fri,  8 May 2026 18:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IW6E6KNO";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF8F10F598
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 18:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0eFzQeAJefkp+HXQFAHPVKjvhmOFhzPBf61ZW4IZNEGKuIqd7BpOOEXOPu0oc5VhQTuxi1aSeHfFHPWXZg2r14Cakx5r59MffNCKBI+USrqSJqVKDtJO7ILTzGJt0NA/VzrC0hgs5wgs3eXLfj9vqmDZ6GnrpPn6ocOue2B/eLd2TFI2ZnROemQeCRiTYm1apmwXckM2sopK8IkVmYKF5Fq3moAcf9iWCFHW92uNcFsxeKF+Vtr4abiwGtqZQWiKFmpde1+9b7n8iyBtF6ZA4DL7dJq8JqqVA6axDx95v0fl2Bru0EVqD9R7wUFpwBLaiOG5KLvMouxijkddEJZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHsWVHEYvvYT9RuSgPcnkC7/E43Vxu3JlE6pmukpc7U=;
 b=QzUz6uNNcgbqRv5za3zyq7hH5/bGvv4E5PfLHGnIl8OMXjHnS8OBG6IP7iYXvps0fLvq14wgM+5SBj0kKfkw54+qiQBRaVJ25LVlfkE5YfFuO3zd8menkFc35U8m2Xh9BKrlNqoTyA8HP5Be0Ltelikao2XD3eFzeieQe48ld2YOH6KaG9TiBFXwKTTS/crr1rEZ7dk8KHEzCMM2JtGghjYoeRcPiKEGVpN0vf9Zv0utdMZOnrUeXXcfiA4VkBtWVY09sOVngBBoouqOjdVq1Pq89Ik1+kM50z6lBcsI9hbIOh4JujVyf0v4wbRlbvYbR1v2e+2t4+BDt4U6ymwt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHsWVHEYvvYT9RuSgPcnkC7/E43Vxu3JlE6pmukpc7U=;
 b=IW6E6KNO/aJ2Bio6q3h03MXomq0Xi+thLQ3cYowjfutXk51E3fxiyXS0bzU9eJzLAMUDmNEpXhsV7bDs0DACdo21uBj2c6STNCnGqHfMTh+HVjQBNz54vM3Uf/O9HSz1gJ+2b6lPhUrzcFeWmtonYwlAARci9VVO60kP/46bwdA=
Received: from PH7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:510:339::10)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 18:07:12 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::6d) by PH7PR03CA0014.outlook.office365.com
 (2603:10b6:510:339::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 18:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 18:07:12 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 13:07:11 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <yipeng.chai@amd.com>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>
Subject: [PATCH v2] drm/amdgpu: grow SR-IOV RAS bad-page tables dynamically
 The VF RAS error handler stored bad pages in fixed-size arrays. If the PF2VF
 block described more entries than fit,
 amdgpu_virt_ras_add_bps() could memcpy past the end of those arrays.
Date: Fri, 8 May 2026 14:07:05 -0400
Message-ID: <20260508180705.217683-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BN9PR12MB5306BE73CDDAAEDA37B3A0F1FC3D2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <BN9PR12MB5306BE73CDDAAEDA37B3A0F1FC3D2@BN9PR12MB5306.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 05838cad-7f05-4e23-d05e-08dead2ca0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mjXqrEEMtQicMBX6ndYj8xDQ91YyGzXDtFJijjzp4bdzymM3J7niOlfQl22MkVwauA+cF/173fal7drt9R0+SgUwEaCPA8omrTRYQG3G6eKrlAjx0gD95/TDzRC3y8Hab1hqRJgc+DPI9Xd8S2baY+CA2JDIjux4PaEpHq+gv53FSzsrABj7DFN/6mvhgWfCtExxPb3n6Wv0t8p3N8UGCMKf+rPVplmPglYZXqeG51XBEPXEfKAm7rCV/yvDi/MKV6DINdzvtrGERKu6uxBSElCwj8wj8mx79RYAK8xc2/+WHipaofu4NiPrXvVuU6H1bkO0xn5sfaq7hXWfDv94keV1rgVaQOQfNKwGMDff8dmCVHE7+dzUQSX2XmuYLXtmRoNVZEVUFKWeCenrfp49ozLhqOrrQFN4oYGE/eaJ8tWqrRQLKF5delevEBVj6XxdEmciX4xDTuGmrg32fM0MERGl4kmJ/P0ZEwuqYA4wzH6PLhhlAPajzTw0UDFY1qw+VOz/gmnRckwAFRuNAa81AVN0Mx+kwktt2Cij/xj0FBoPJ3WvFMbz89h9BkeM8C16LaGnL2SsGsvvvSToGQfL6b0mReyVDCafjAQZGol6ijk8s+emV7QnIIV7vTpjNNSKUNODZYUO1mDBtJMg7wxgJ+79EPOzb+l0G+OYr++EjvlCxi4GXE7Jb+xNTQFBxWlJpdCAT5WlhvOFKgznvFqGPt+5ivnQVZQrzBeGqtfVAbM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LkNTj33DFGdewud9SCHpdjdFeUsbM+FTMY3BSKezgLJOBwhiaTvDfAjmS0YS3VNZYvIn6pCD4rpHtaq1JfFASp9gDesC268TuaaZNZFxCEz+R1xwF2EILT2AS2mCekeIHgzp8A8u1gXKXCQakQGSVbAtxq8qKP11G/lwoEkSC0uYRHSu3AvN4FCBbWE1JZvkVyr34UrDIUjdGzt09ZrhvBkqQvABPvG4FCuQ26vqZ0d1nmEFULKrVE/ZZIA0Dyrazeyw3+s4utgpwtvT5Bw9yz+PpAVtvjGpg5vDiLuUFDwss890UZMK9VYoTam9kBwyxh/fFUSJxP7kAo3lo4WDswVGq7l7dEQKjWqmf2gE0EDdt3f0Kc/AgooXUM7q/yT2GG8Hn+kEPDPBHC0Y4ByIpkBN1QTQXyydRHBaMzTl1n5WbhqNufjgLRoVYHPv1i0d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:07:12.1584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05838cad-7f05-4e23-d05e-08dead2ca0dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

Track table length in a capacity field, allocate a small initial table,
and grow bps / bps_bo together when count + pages would exceed capacity.
Keep amdgpu_virt_ras_add_bps() as the single append path: validate the
addition, grow if needed, then memcpy and bump count.

On allocation failure the existing tables are left unchanged and the
caller stops ingesting more bad pages from the message.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I924d2b5e369bef007eb1577f287a2274ec83d5a9
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 114 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |   2 +
 2 files changed, 95 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..8d4f30e3be212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,68 @@ unsigned int amd_sriov_msg_checksum(void *obj,
 	return ret;
 }
 
+#define AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY	16
+
+/**
+ * amdgpu_virt_ras_grow_bad_page_table - grow bad-page arrays if needed
+ * @adev: amdgpu device
+ * @eh: RAS error handler data for the VF
+ * @min_capacity: minimum number of bad-page slots required (bps[] / bps_bo[] length)
+ *
+ * Returns 0 if @eh already has room for @min_capacity slots or growth succeeded.
+ * Returns -ENOMEM if allocation failed (existing tables are left unchanged).
+ */
+static int amdgpu_virt_ras_grow_bad_page_table(struct amdgpu_device *adev,
+		struct amdgpu_virt_ras_err_handler_data *eh,
+		int min_capacity)
+{
+	struct eeprom_table_record *new_bps;
+	struct amdgpu_bo **new_bo;
+	int new_capacity;
+	unsigned long doubled;
+
+	if (min_capacity <= eh->capacity)
+		return 0;
+
+	new_capacity = eh->capacity ? eh->capacity : AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY;
+	while (new_capacity < min_capacity) {
+		doubled = (unsigned long)new_capacity * 2UL;
+		if (doubled < (unsigned long)new_capacity || doubled > INT_MAX) {
+			new_capacity = min_capacity;
+			break;
+		}
+		new_capacity = (int)doubled;
+	}
+	if (new_capacity < min_capacity)
+		new_capacity = min_capacity;
+
+	new_bps = kmalloc_array(new_capacity, sizeof(*eh->bps), GFP_KERNEL);
+	new_bo = kcalloc(new_capacity, sizeof(*eh->bps_bo), GFP_KERNEL);
+	if (!new_bps || !new_bo) {
+		kfree(new_bps);
+		kfree(new_bo);
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: failed to grow bad page table to %d slots\n",
+				     new_capacity);
+		return -ENOMEM;
+	}
+
+	memcpy(new_bps, eh->bps, eh->count * sizeof(*eh->bps));
+	memcpy(new_bo, eh->bps_bo, eh->count * sizeof(*eh->bps_bo));
+
+	kfree(eh->bps);
+	kfree(eh->bps_bo);
+	eh->bps = new_bps;
+	eh->bps_bo = new_bo;
+	eh->capacity = new_capacity;
+
+	return 0;
+}
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data **data = &virt->virt_eh_data;
-	/* GPU will be marked bad on host if bp count more then 10,
-	 * so alloc 512 is enough.
-	 */
-	unsigned int align_space = 512;
 	void *bps = NULL;
 	struct amdgpu_bo **bps_bo = NULL;
 
@@ -298,16 +352,17 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!*data)
 		goto data_failure;
 
-	bps = kmalloc_array(align_space, sizeof(*(*data)->bps), GFP_KERNEL);
+	bps = kmalloc_array(AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY, sizeof(*(*data)->bps), GFP_KERNEL);
 	if (!bps)
 		goto bps_failure;
 
-	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
+	bps_bo = kcalloc(AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY, sizeof(*(*data)->bps_bo), GFP_KERNEL);
 	if (!bps_bo)
 		goto bps_bo_failure;
 
 	(*data)->bps = bps;
 	(*data)->bps_bo = bps_bo;
+	(*data)->capacity = AMDGPU_VIRT_RAS_BAD_PAGE_TABLE_INIT_CAPACITY;
 	(*data)->count = 0;
 	(*data)->last_reserved = 0;
 
@@ -361,17 +416,32 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
 	virt->virt_eh_data = NULL;
 }
 
-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+		const struct eeprom_table_record *bps, int pages)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+	int need;
 
-	if (!data)
-		return;
+	if (!data || pages <= 0)
+		return false;
+
+	if (pages > INT_MAX - data->count) {
+		dev_warn_ratelimited(adev->dev,
+				     "RAS WARN: bad page table size overflow (count=%d pages=%d)\n",
+				     data->count, pages);
+		return false;
+	}
+
+	need = data->count + pages;
+	if (need > data->capacity &&
+	    amdgpu_virt_ras_grow_bad_page_table(adev, data, need))
+		return false;
 
 	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
 	data->count += pages;
+
+	return true;
 }
 
 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
@@ -443,20 +513,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 
 	memset(&bp, 0, sizeof(bp));
 
-	if (bp_block_size) {
-		bp_cnt = bp_block_size / sizeof(uint64_t);
-		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-			retired_page = *(uint64_t *)(vram_usage_va +
-					bp_block_offset + bp_idx * sizeof(uint64_t));
-			bp.retired_page = retired_page;
+	if (!bp_block_size)
+		return;
 
-			if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
-				continue;
+	bp_cnt = bp_block_size / sizeof(uint64_t);
+	for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
+		retired_page = *(uint64_t *)(vram_usage_va +
+				bp_block_offset + bp_idx * sizeof(uint64_t));
+		bp.retired_page = retired_page;
 
-			amdgpu_virt_ras_add_bps(adev, &bp, 1);
+		if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+			continue;
 
-			amdgpu_virt_ras_reserve_bps(adev);
-		}
+		if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+			break;
+
+		amdgpu_virt_ras_reserve_bps(adev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9da0c6e9b8695..af2acf8eee6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -263,6 +263,8 @@ struct amdgpu_virt_ras_err_handler_data {
 	struct eeprom_table_record *bps;
 	/* point to reserved bo array */
 	struct amdgpu_bo **bps_bo;
+	/* number of slots in bps[] / bps_bo[] (always >= count) */
+	int capacity;
 	/* the count of entries */
 	int count;
 	/* last reserved entry's index + 1 */
-- 
2.34.1

