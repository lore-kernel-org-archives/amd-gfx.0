Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFABCC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Dec 2021 02:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DCA10E2B5;
	Sat, 11 Dec 2021 02:42:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4966310E2B5
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Dec 2021 02:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwcPgAJ1ocgVb4pGsjjYMcRHZVgKDxVue92k/KjCvJP4nzSWlceeF5hWD0r+cOUD4fIsC7UUTd1aVAfgEkTAzsrj2KGty0qNbraMcggbL/KKRek8LYco1XiHYkG4CDM3Qt4ZCjrmKcXUotYO+PZd1jSLlBLORgNlT+E5xJ8OTOT8/gkiICBFQYVEjgehhBJdgK1kqeoBFOWS6lD/YjEjvOk5TFJrSqrFX6uv0wRL9fK370amm6W16RWc/hPk6PMYZwlJYoCA6gbWi2ejflhXbS2R8kqReJzS2aBdzED/sM8AzXx2BF/MJ3H2FjN65yUzMzlHb6sMAvboX6AaiWKzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyuN1u6wmgpsKz7oFamhCwBRx5+xjMHRFDyUiiM2OgM=;
 b=cQKwK8SJ8FiFAHQQKPoHVGcSuWZylFVu09yto5zkUblZh57YbPXwaAmvq9oIg3k+Mbwnj1aWTi+tT/TPT6YF1H5fPxaQyIRk3DYe+WFc4XxCevn3S0fPX6o5KCFhLS2UwjA/qbFTA/6U2MUMVYGEm6KYpm4rSa+9QcH+2pSJWVjk6b9XDRH78acPe4XAq2xD7ppHGKp7XToTBu8JYjy9rUOBBLNGIM4CxnPVVViA13o5ZFUjO6hMqhMWwBwNYJSAv2IpmQHw32MhaWUGzIbX3mgyUpezr9oUgEqZOOXoIyOWym+2QZdA8JXRGveS9/VHLL7Jh70Yqij01jZcxwCOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyuN1u6wmgpsKz7oFamhCwBRx5+xjMHRFDyUiiM2OgM=;
 b=XhZnjb5p+ZAEo/26a4xY/KGweLPgpdjl46QAqd3KT6DRKNuggNPZr0owNUh8ID0a8LIcfv5dfOvvpDnQONfRDzFoVlmoF1IGy4C1LhctlywOpbnL9a8xcCHzeE6vrtT/XgYsnaIsU4SEHb8+0r4hchTYi4iMeeLBTcQx4paQfUc=
Received: from DM3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:0:50::13) by
 CY4PR1201MB0197.namprd12.prod.outlook.com (2603:10b6:910:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Sat, 11 Dec
 2021 02:42:55 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::3a) by DM3PR03CA0003.outlook.office365.com
 (2603:10b6:0:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Sat, 11 Dec 2021 02:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Sat, 11 Dec 2021 02:42:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 20:42:52 -0600
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 20:42:52 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.choi@amd.com>
Subject: [PATCH] drm/amd/display: Fix Compile Error for DCE
Date: Fri, 10 Dec 2021 21:42:27 -0500
Message-ID: <20211211024227.8323-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 163a6e69-c924-4a36-1117-08d9bc4feeec
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0197:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0197D8412F9FF7A9500663B5E5729@CY4PR1201MB0197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQ1M8geN70OZJKGaY68XgoVUvY8dssmIu+eJfkNmt42k3/xyNDG+CKEuYxLAFompLYQOZovyKiXF6rRaODIKEYepI3HNipwecS37H15VL8+Ad+sdhitzGErInIbKpDxLDGUnZVpaY7Ki4C0Ws2mjAdG60X/1WdlaY97u4bp6+8mVpJJtaJEcaKMTnMn9zt5YF/nA3tUtGXRWX+FRTKEkX2bOuYgCcFamVHksfntJYejDzUp/zQVDlihucumXoN9HVLSkjK0821rUUYXQKaYbmHrpuixM7TN8bwB9IALrD679NYNDx42T2Y63vUNIoVZ0GNlqHJGsaDXMfAoL2QgruuxB+WYYjZvVzOugpLz7HqBBJn6NBRh7H45Pocj7rfupajnXeNdH8QrPhwZJVt1lhZKTbfHRh6m7txVeavRzizB38Z1cSA9Gb7jawsn/1R3E9d3rWqFq2R3ycGe9LsDukYNmDOHNCyFScjzRmH6gMYi2Bp/tVOiU1PPHeIURAoqorIxAvm2jhaCjRILbPVc3oLeaDybv8kFUmt+iXr2l5OE9BwBo/UA5fInU5dfPuZJOkLtkB+BHSnnF+BMDGkqdcR6TdqJuPNQ0RFkSqnsydAm1ijBRQuzwOvjxoCYJPfv4j4z779ZzPCSOOEclw6s3rYgloe9tjOEQDdo5SnltY7D9itCgYTaTsxZJ+tROyKnc4+SvHeOt4zFem+4vAHJlfvwvCBChYmkdy6frLvMZCsIYwuOMzSf+bjiNtA7JvRB870MbLxlxzxxEYXg4NwwSX6gmb19U3lmXCemXxRRHY8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(36756003)(26005)(70586007)(4326008)(2906002)(426003)(8936002)(8676002)(36860700001)(40460700001)(110136005)(6636002)(6666004)(508600001)(82310400004)(81166007)(316002)(83380400001)(86362001)(5660300002)(2616005)(356005)(70206006)(1076003)(47076005)(7696005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2021 02:42:54.5454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 163a6e69-c924-4a36-1117-08d9bc4feeec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0197
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Follow-up fix for:
drm/amd/display: Add Debugfs Entry to Force in SST Sequence

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1779c7daaf72..dc55a736e198 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3237,8 +3237,9 @@ static int disable_hpd_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 			 disable_hpd_set, "%llu\n");
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 /*
- * Force sst sequence in mst capable receiver.
+ * Temporary w/a to force sst sequence in M42D DP2 mst receiver
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
  */
 static int dp_force_sst_set(void *data, u64 val)
@@ -3260,6 +3261,7 @@ static int dp_force_sst_get(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
 			 dp_force_sst_set, "%llu\n");
+#endif
 
 /*
  * Sets the DC visual confirm debug option from the given string.
@@ -3370,8 +3372,10 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 			    adev, &mst_topo_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
 				&dp_set_mst_en_for_sst_ops);
+#endif
 
 	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
 				   &visual_confirm_fops);
-- 
2.25.1

