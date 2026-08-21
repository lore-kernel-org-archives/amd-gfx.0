Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17D1C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F44110F383;
	Fri, 21 Aug 2026 16:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DlVGWRrJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BA010F383
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGITET5IhgmMoeQZCTa647QeI9bQEB4JU1MM0edIM0N01SIkBIc0cLQ71lCVQMcoObJiGJvTlYCb2sfYatXaeKEDvR+BEoafeJssl+9l6lKODsFN404LOpC+Gxc6t0VPiEvFcwART03303gW3EPhP2ALPaY8+LY/VhQhjGw5073cSXhZb0/CVpiSDKEhtxhUFlytMOUpXbLyTeLoN4Ow1vFDfWCNgHAIAor7gXQODUWq+ZbsaXAZ9iYgz1TcItYnVNt+5kAeSIWJ+YiFOIN8nHNWegiVym7zd90BiM2RdLJHYX8DYvxAkhTIFaYqzBebP1ZpZHluUsoxUo/wPv0/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1ynpjmKFCjcg4ZDs+2ol3Ycwr8xgIISOEfG2NO/Kx4=;
 b=xdsLyB4BJcUXJZvbGgO6t2HrRw4+vwwknpYJ/usUBAQQ9Z+p/iUsZSVrGXvNZE1rgEG+V+6wdICNzUMWKUk9r78WT009jboR+m+UMd3YIYQkho0/FI4H0tTbxMSoritFuUnayO+JYwbr14YNrSfOAoXVrLacFnfiN9SM0g97nR8kFi6YZEac2p6DIA2lUn0JhspAd+nWvN2lyrDqtGIfEdsMZykB0LC/JwpqbA5t2h1vnI0XgXb625+r6a/LazVG2Q3Bs6oQUUdosTRVml40u1BjIaakbIHWARprzDXpPtYnLl2Q99u0GzE4dig9wT0qTos+D/wsshhFV4RJ5F4maw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1ynpjmKFCjcg4ZDs+2ol3Ycwr8xgIISOEfG2NO/Kx4=;
 b=DlVGWRrJds0FmUL/vWSFSRAVAuFp5P16owtAVtvwS8Xr2q+ux7TcZcX0mTgku7JlzatJ51iN9yL3L6IUB+pfwXxwl8521PAZP1Q91dj3/WTZFDEMHUTG9zPUb/suqE1yyh4rKqYu4hiQO7n8g2jRKVzNYGMUNyXXrzQemV3vWU0=
Received: from BN9PR03CA0276.namprd03.prod.outlook.com (2603:10b6:408:f5::11)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:14:39 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::4c) by BN9PR03CA0276.outlook.office365.com
 (2603:10b6:408:f5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/14] drm/amdgpu: add mem_reserved_info sysfs attribute
Date: Fri, 21 Aug 2026 12:13:57 -0400
Message-ID: <20260821161401.754042-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e464a5-3401-4085-662f-08deff9f4d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: Y3fMn4TTi9WaHYxrnWpQz+hYvEdnoChofzEex/a2DWfK0PLtGuBEoFWqx90jaaLhKn+vpZf0piuiBUUQ1uo2CtRJzO06hk/F1310/p2ws1aE8W78W+bxegDEWQqj9+9PJ6EtiOujHk+nlly8MNhfLl0+aGrwHa3IF+lE1dEDim2289ZmAIOIaLAW3U1RQe5X3LFND/qclRTT/RzJjYtU/W+wGZLyGls0El/K3PQUG3p5kgcMhbfXb9OnRqlnfYGa+7IKWqwEmfwJZ78f+y/jHfLuv13bCn4KO62O0mJ2Y2SHXtJgHAXPfAbqH6T1S4jcn0fj93bWqQrfWtHJrB1D7VXZft36/wK5+tCuSjyrukXnh0c5Cp1PQqulGgIpj9hCjD63YQNbhh2LBi2HaDpZUCR8qCMlbxRN0eZJem4MsVcVPGIKXtPNc+9mhMIluRGjVv87n8sKpA9d55k/eQ1NkJVrx9wB37v5GTxRLxyNGBQaq7Rn6o48xqto8CNyrpPgXZDu8Rka+roDwnnNgKGMYbjB2WlmOqlPV2V3tYtF/Hh4tJq4N877C1V800cgVuWw5EiXQ1myBn1nEaDTC8tyBAIMjI6OE/sJ8/koOqscmgYmrhICNBgp9a/3oKwsdNTBPMHavMRkB8BRW9lTN27YnMfbF9gGfxAGeTIzj+tZheRACXqijrwjPLL5PPuMxS44khqPkVs7Vz5vAi/jbvSKKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qF11tcfQveKeYGL2Y50hs6dKJ5NaY8oN67EAftbYLgytNEUsaMMCu7ntLmhY+gicxuM6o8ItedXTiSBvOg/9apu8n+8JwKEVTL5qRWZafXVN41NKT5T+Zxvl49Klg4SapmS0dOZkOLrPHHencTSen3v5gOlB1dY9k65GzKNKOlJjweavkvzVSpIT0xVgHQPbCM+iu9svY1Z/EFcpbuDwB1zZsto4cxtXzO48kcW0DgJXn0AuCzzdElDHQMeUuLQke+MSUBK5A9pHrgqzwRCiFtofFiQ6l16aJXYpDqMdztSscTfX8BZZ2FuF6442WelMSDtRPl9x6zZpGfRczramKc4nm4TbR8Ci36q2IGw8o81mdrD6fKl80anIFXqz50embyjWgehHkddmqRK1dgs79qVUZgPeeUy/KB5A6AHSFytyY4m55Hi27AIUXG8UMEPe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:38.8820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e464a5-3401-4085-662f-08deff9f4d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
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

From: Feifei Xu <Feifei.Xu@amd.com>

Expose the cached MEM_RESERVED_INFO discovery table via a per-device
sysfs file:

    /sys/class/drm/cardX/device/mem_reserved_info

The file is read-only and dumps every region as:

    list_num=<N>
    [<i>] id=<id> (<name>) size=0x<size> start=0x<start>

Only created when the table was successfully resolved at discovery
init time.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 56 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  3 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 36cc11ff3dd4c..2c3180dfd26d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -247,6 +247,9 @@ static int amdgpu_device_attr_sysfs_init(struct amdgpu_device *adev)
 		ret = sysfs_create_file(&adev->dev->kobj,
 					&dev_attr_pcie_replay_count.attr);
 
+	if (!ret)
+		ret = amdgpu_discovery_mem_reserved_info_sysfs_init(adev);
+
 	return ret;
 }
 
@@ -255,6 +258,8 @@ static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)
 	if (amdgpu_nbio_is_replay_cnt_supported(adev))
 		sysfs_remove_file(&adev->dev->kobj,
 				  &dev_attr_pcie_replay_count.attr);
+
+	amdgpu_discovery_mem_reserved_info_sysfs_fini(adev);
 }
 
 static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject *kobj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7ab32e62c8a98..9bbdb9cba5018 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2433,6 +2433,62 @@ static void amdgpu_discovery_dump_mem_reserved_info_table(struct amdgpu_device *
 	}
 }
 
+/**
+ * Add READ-ONLY mem_reserved_info sysfs entry.
+ * MEM_RESERVED_INFO table is parsed from the IP discovery binary.
+ * The file mem_reserved_info dumps every entry as:
+ *   list_num=<N>
+ *   [<i>] id=<id> (<name>) size=<size> start=<start>
+ */
+static ssize_t mem_reserved_info_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct mem_reserved_info_table_v1_0 *table;
+	u32 list_num, id, i;
+	ssize_t len = 0;
+
+	if (amdgpu_discovery_get_mem_reserved_info_table(adev))
+		return sysfs_emit(buf, "MEM_RESERVED_INFO table not available\n");
+
+	table = adev->discovery.mem_reserved_table;
+	list_num = min_t(u32, le32_to_cpu(table->list_num), MAX_MEM_REGION_NUM);
+
+	len += sysfs_emit_at(buf, len, "list_num=%u\n", list_num);
+	for (i = 0; i < list_num; i++) {
+		id = le32_to_cpu(table->list[i].reserved_region_id);
+		len += sysfs_emit_at(buf, len,
+			"[%u] id=%u (%s) size=0x%llx start=0x%llx\n",
+			i, id,
+			amdgpu_discovery_mem_reserved_region_name(id),
+			le64_to_cpu(table->list[i].reserved_region_size),
+			le64_to_cpu(table->list[i].reserved_region_start));
+	}
+
+	return len;
+}
+
+static DEVICE_ATTR_RO(mem_reserved_info);
+
+int amdgpu_discovery_mem_reserved_info_sysfs_init(struct amdgpu_device *adev)
+{
+	if (!adev->discovery.mem_reserved_table)
+		return 0;
+
+	return sysfs_create_file(&adev->dev->kobj,
+				 &dev_attr_mem_reserved_info.attr);
+}
+
+void amdgpu_discovery_mem_reserved_info_sysfs_fini(struct amdgpu_device *adev)
+{
+	if (!adev->discovery.mem_reserved_table)
+		return;
+
+	sysfs_remove_file(&adev->dev->kobj,
+			  &dev_attr_mem_reserved_info.attr);
+}
+
 /*
  * Resolve the MEM_RESERVED_INFO table from the IP discovery binary and
  * cache it in adev->discovery.mem_reserved_table.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 2cd00cc4ed363..997ba1717e744 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -67,4 +67,7 @@ int amdgpu_discovery_get_mem_reserved_region_by_id(struct amdgpu_device *adev,
 						   u32 reserved_region_id,
 						   struct mem_reserved_info *info);
 
+int amdgpu_discovery_mem_reserved_info_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_discovery_mem_reserved_info_sysfs_fini(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_DISCOVERY__ */
-- 
2.55.0

