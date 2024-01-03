Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAABC47077
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD5C10E24A;
	Wed,  3 Jan 2024 08:03:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFBE10E242
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5PduvzEoRXMmTsyCu2zvRGn5uAjakt03uRIcK7GyPnpJvoCeA1mQ+3oqot+OcfpAlUnD2+SbCrnec+A7csUaEyU0qbZz8AXdqBuF8JMyFII2NfxlnoJBkOgREhM6jjjkW1c0b4K2ZF0p5y8C87Hb1NlmN6PjLe/Q2hsMhXgDx5fUDUIcEh0ZR3dDiLdExmZAmjbKjscL/392++XHlUbcIaPdAfBrGFJ/MfdCXl32hjEV+VjWe8zzMuy777cUVyDbtIJKoc4iQdPDaRfKo1cCwgR9KyDpih56bFFS7BRKGNGJK3GYx8OWibWqCrshEwav+48HdfmUwYdc0RjqiSAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+RlFNhwOXYu5J75RKVxqAUYysiA2P/Zd+G7cSsK85c=;
 b=ahxSxP9pdjjB//FVpB1jdLUQ+vQb6Jex2yI4Mwsn72/JeVuXlOeBwiEfhczFBGuwEKUJ+3hH/K1kT2DB4xj29XSaftNRwiuMvJI22CVQgn6p8NYc2eXOIlFhjZ97PjMwaOnjxYFjbc5kEve8txVuH4knLLoJ+aee2xhR30jXp6GwJU7gKoU7tgMdWV7wqx0svQNqVbaVIPEjXEiIMvhkeaq5uMEJ/Xy4ttXUGFFX+jnzJIWADKaJy7LyBUy0kLMqdqCPlkSSodr71SkK6sURrnHb90XbHA5b/rjqISMOcu+JpIL2UMR/Ly/GAZY0wKIf/rv9SLIe7QmQkV8XOzhuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+RlFNhwOXYu5J75RKVxqAUYysiA2P/Zd+G7cSsK85c=;
 b=h9OM/8Hc8ZwCF6EvosCQTCxGLPLGSHOWunthYNcpaZrINCl9yUABquDdQ1PA5g3b4VE5tAQQtaq2+iY6qMeab8esiLcGRr79RrlDC2Blz3AzouJOdNMl9TO3hAF8K0MYrpiCIL+XPnOj5pwns8shnAzSEStzlZygFiuVDmFsyu4=
Received: from SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:03:52 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::28) by SJ0PR05CA0035.outlook.office365.com
 (2603:10b6:a03:33f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:51 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:49 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amdgpu: add aca sysfs support
Date: Wed, 3 Jan 2024 16:02:12 +0800
Message-ID: <20240103080220.2815115-7-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103080220.2815115-1-kevinyang.wang@amd.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f833e0-3fe6-4281-df57-08dc0c328632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwKQ6Ca1/arQM7j5eKNg9AogCtVXJsgw0n/8rK5CHC+VK846pkVYtdyyHhMNgdBAuO2E9aeg07qdU8Op1uF2kKzSRyYDTczv6r09C9j4ug5lYQkSAJo75yFe+Ec6aHjRKuXYHD8qkKr/nz/1IHigjjdUIuCweVy7EcEJoURf5+x518wldoDzLQ7gnnrSeCWTtRqDpOhkrFi2or2xzHLqEA9EHlh94I0e2NRl7IB3y+zLbe8iEhkSNIrbBSZQDJyJtwzZ+dDhx4pq0jUCvPulsTOLRZLeHMo3uiYvy0wnadgeoUJTJ1mkI9m7l3InlbBCU4IklbgdAAoBpgzJr/mWT0BWkqhqV9xJiShTGYDxeoLf/z0UmPYbqjzZSx3WQkd0+PIkozG9TyL7/XdmjLdxCOpNudiWe2i7KG+xbDHcq77zuzyJKjhqySd2n7D87MHXqw9yHrRy092c2osEeDAHZNLHQvr5qSy4Mo33a2bZ0pttc09YsUivRQrdAzmR/H/+aIYzTAOr+pW7cPvWK0PxIYIEyDqVyURzv7C63j5L6Nkgw1gtiQJ5PvbGSeaCoPyOiGHRt9OZ3l20k1ODfx2AdgI23snwqf0H69rYvxvISHBlicvDwKu7xA4o+LaGWqkyGu6EvD6+txIvi4hqO+V3jBjTHNn3/oLUWIOzhdeBBEK+tgbiKonIBlzKwoeMtAqvou2zQdgbm4Wom1p3i6vgTrTMv3OG40nEsocDxMv1CtC6rS8Y0GiKoAqhCUo//ZDx4+U0E02xg9VJEsUqlWfEgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(8676002)(8936002)(4326008)(6916009)(316002)(54906003)(478600001)(36756003)(86362001)(5660300002)(40480700001)(40460700003)(41300700001)(6666004)(7696005)(16526019)(1076003)(26005)(2616005)(426003)(336012)(356005)(81166007)(47076005)(83380400001)(70586007)(70206006)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:51.7896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f833e0-3fe6-4281-df57-08dc0c328632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 32 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 68b61aaac6d0..43a493b52ead 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -577,12 +577,42 @@ static int add_aca_handle(struct amdgpu_device *adev, struct aca_handle_manager
 	return 0;
 }
 
+static ssize_t aca_sysfs_read(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct aca_handle *handle = container_of(attr, struct aca_handle, aca_attr);
+
+	/* NOTE: the aca cache will be auto cleared once read,
+	 * So the driver should unify the query entry point, forward request to ras query interface directly */
+	return amdgpu_ras_aca_sysfs_read(dev, attr, handle, buf, handle->data);
+}
+
+static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
+{
+	struct device_attribute *aca_attr = &handle->aca_attr;
+
+	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
+	aca_attr->show = aca_sysfs_read;
+	aca_attr->attr.name = handle->attr_name;
+	aca_attr->attr.mode = S_IRUGO;
+	sysfs_attr_init(&aca_attr->attr);
+
+	return sysfs_add_file_to_group(&adev->dev->kobj,
+				       &aca_attr->attr,
+				       "ras");
+}
+
 int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
 			  const char *name, const struct aca_info *ras_info, void *data)
 {
 	struct amdgpu_aca *aca = &adev->aca;
+	int ret;
+
+	ret = add_aca_handle(adev, &aca->mgr, handle, name, ras_info, data);
+	if (ret)
+		return ret;
 
-	return add_aca_handle(adev, &aca->mgr, handle, name, ras_info, data);
+	return add_aca_sysfs(adev, handle);
 }
 
 static void remove_aca(struct aca_handle *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 961fad87281f..85ef2baad33f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -150,6 +150,8 @@ struct aca_handle {
 	struct aca_handle_manager *mgr;
 	struct aca_error_cache error_cache;
 	const struct aca_bank_ops *bank_ops;
+	struct device_attribute aca_attr;
+	char attr_name[64];
 	const char *name;
 	u32 mask;
 	void *data;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bbae41f86e00..7a5ba67c9884 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1203,6 +1203,21 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 	return 0;
 }
 
+ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
+				  struct aca_handle *handle, char *buf, void *data)
+{
+	struct ras_manager *obj = container_of(handle, struct ras_manager, aca_handle);
+	struct ras_query_if info = {
+		.head = obj->head,
+	};
+
+	if (amdgpu_ras_query_error_status(obj->adev, &info))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s: %lu\n%s: %lu\n", "ue", info.ue_count,
+			  "ce", info.ce_count);
+}
+
 static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 					 enum aca_error_type type, struct ras_err_data *err_data)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 2afac9aa381a..5c7212b1255f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -826,5 +826,7 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 			       const struct aca_info *aca_info, void *data);
 int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk);
+ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
+				  struct aca_handle *handle, char *buf, void *data);
 
 #endif
-- 
2.34.1

