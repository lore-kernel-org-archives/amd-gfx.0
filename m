Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8900EC47077
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30DC310E44E;
	Thu,  4 Jan 2024 11:49:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A1F10E44E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiRnbKKZ72bJcSV1MJa6ybWCmMLMzymsXNX0hZqKXg0bgCZkBs1x6jb1uQDCcm0ld1GkT/AzvL2MEKAZ9l1m4Vh2BL2PO8exQfx4l1JFV/FFTlRChqSdSrzTUgX1hM1E1vcf58C/ZS15HD80Ie4oNPPovN364tlLd5hdvVVz7DIuQ58PVh2iWVrQu5JzhsRuX8HPSeBMAsFUj75uLLxrpX3Kp1hoXVvdLpoSxVR5Z7DT3DgILwUR4Jst8dbKR+c+DoFfOeSDbtnjXw2b6syHcl4tqJugWiDx8jajJEfSIq4OCdQ1ebKEv5RMgnirf5XDC6ad8/Xfk2Va/8Yo+tOXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2bof9AR/W051aIWli93pPIFSnOwhhqI/1/ABXUa2Tg=;
 b=Sl9Jpow2YNBz8l52c9WlSpQP7HxVrEntBDLUtWoNKIsOePqptWALmahVeR7w+2bk/fTUZoiee3EnKn2274uNfSSWWaTOG33UYVe58ZNMHlPTbJQrtmdOm8rQihAIW+Ej76CqLUJ6E4+rDLbBhuEABBYa8rgWMfG3BYzLdE/Hnn+Ad34W6Fq5txFSC7b5rgCTWthXb9kp47VAXixmHnh1Qyin8cKz8R6jIGyHE7olarODZ9MwCTpyDoTLq8jjZmcakjNK99gYZSxEJS7wvlB3stfZO8Vk9vRB4CHCR+5AYNkK/9+9Lm/sW6GKgIFyCkNZx6gvUc/J2raxupMUL7WCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2bof9AR/W051aIWli93pPIFSnOwhhqI/1/ABXUa2Tg=;
 b=mruAXoUTu4kqs8J4HCxjxvNeOUyb6KdLbwT6DS/GZbhvv5FW4JUT9xllGGtePbGZ8mY2QCzdBfQEgl8tNR+lnPzUamGevE4HHOk4P7CQZdysYdgsSK/ugH0Ss6v8NR50LyfJS7cq6ZAl6kauZ3uPRJBvnHzeTSb2qqcyuslo4Kg=
Received: from SJ0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:2c0::17)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 11:49:30 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::4d) by SJ0PR13CA0012.outlook.office365.com
 (2603:10b6:a03:2c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:30 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:28 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 05/12] drm/amdgpu: add aca sysfs support
Date: Thu, 4 Jan 2024 19:48:51 +0800
Message-ID: <20240104114858.3475783-6-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104114858.3475783-1-kevinyang.wang@amd.com>
References: <20240104114858.3475783-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 36202991-a337-446a-e8b0-08dc0d1b365e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVUylq5i+LqrkBYli0yboR9RFxo/CIX9WnOO4VWBasPuPQipKcdgmomws1QwUK5ygeBV1mjPLSVAn5oG+dB0l1BzjKP0V7gkkA9LDaVxyKg4nvgk+GMC+UtFQqFI3qvqCYAl3htv/GhZ7jK2tss8GCYvUPqrMAgIeFLDs6q3T2+/vztCsx9Dji4Ooj7zyuvadfc0MaaqbqYew5v6dSV/GlCIqxmVB/1QQcMhyiVxeT5zqjHSDF59d82FI0JPIzeL9HCHOhFvSqfbcvyzLU/WjM5B5xSuG9yKmKEt/7bp4Q+XIMI4hz7SEWMOvJQRfnoHcO5pushCghXnJGxOk9TMVl5wOmQhkSjeb07UBqEFUybrScCaS6zYZuXcZ8BmxAMRCg4GW+h+naxjck7FCZMW357/uuOevzqeo8z/XvKo1YttyHSs4KYUhAUZ7PxAcwJEhL+QOvVLBqVyqUL0D0rx/Blo/xLfAQZ6YxkrgmqbSEIXlUbMRsg4Wh8lejdE3iXC5LsuP8V2FKJDYX5O/QzHJLzmHr4B0qpFsFwAPcyL6jMO3qwrDD77dSOAEkwgHCCdL2zNA7msEOMwMFQa4HnNMhdMBQLq+neR+B7L5FCojt/LLxbEYjnZKWsCe5hFTXSg+rhSGiqMAYmqa+FniW24NEUxHwoFO6DbzbO+5Ek+6Me4bj/cjU4d2sY5ihu4ReFUe0m/MeM2tDGAirjdtRu/F0VHWIsqgoZ2EJdPAL81/FX2qPnFJ+D1qIozAKLd/ytONsj1bCB/kua/G5ZyJpaOzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(40460700003)(81166007)(6916009)(70206006)(86362001)(83380400001)(82740400003)(16526019)(356005)(1076003)(70586007)(41300700001)(47076005)(2616005)(26005)(478600001)(2906002)(336012)(426003)(4326008)(5660300002)(7696005)(8936002)(36860700001)(316002)(6666004)(54906003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:30.5829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36202991-a337-446a-e8b0-08dc0d1b365e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 +++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c447064fcaec..a460cde20cf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -563,12 +563,42 @@ static int add_aca_handle(struct amdgpu_device *adev, struct aca_handle_manager
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
index 747150c02609..bb0a3be72cc8 100644
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
index dc11cc98c673..7048bf853cf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1168,6 +1168,21 @@ static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
 	}
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
 static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 						struct ras_query_if *info,
 						struct ras_err_data *err_data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 408e21c3cc88..8c487f3bfbf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -821,4 +821,7 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
 		struct amdgpu_smuio_mcm_config_info *mcm_info,
 		struct ras_err_addr *err_addr, u64 count);
 
+ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
+				  struct aca_handle *handle, char *buf, void *data);
+
 #endif
-- 
2.34.1

