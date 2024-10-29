Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5A9D3A678
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F82510E3A4;
	Tue, 29 Oct 2024 17:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PYs8YDu7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8333F10E397
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDjGCtxuy3PhnSAsCguxKsAtuUbkynEiuBemz/h1wk5HNPEiIKE9K9vwUH1/yAdEPWp2RAuuDB73S0xk7PSXdUizFQkf18il1dPOurDDYLlMioTi8FSWvn0B3Cnk8L1L242WhYrG7no6x5ukZzpEG4YXn9/Gp7ErqQbNcsLbHoK70ocYzhk8g2MbpZ47JRBVRPZh1j7KeV84E1cLn6pDwOX5G7gusOeQObIbXkpKCQJibe7BF4lVBiqKLlo4XHARHdez7sdci87DytasSYEo2wJ+SndrTpE8vW/4qqpUoQHOeo481Ogq51eg6QbO7cQPgntdt+dHOVw/qScpGwJwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOOn+0r7tCbfVuydrhEy/4SuJNoj6NkV9j7+epcK6Os=;
 b=iwV6zTzDO7uemF4eFhl2eRm/3F9Q9QwCvODU73obqQGPK8dkdafYMtAx18zCSOHwkNgluxvVlfBrKcfFJ9ryosYszEq/DkWKD8fev8cu6di9CrcKJOOJYbqfktcsce0oddqXMcSf90/prJOQ6JIAmLTXNFQXQOEDJVYgikJzpom3O9MMnJQvqJiqzxt7rxpbEVP/sKhY37Vi0nhfCV5CbaZAxbg6tyxsIoyb1VjB31BVkE5Legq5gi92cCVv5KE+IVKwJZOKghA9iYS0w5Q6xkQ9nQdIm8bTppcWN1ELCE3Zoy+sQTl4/oenKMXT1b7h9XmSdpyzv4ECq6AAX0hW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOOn+0r7tCbfVuydrhEy/4SuJNoj6NkV9j7+epcK6Os=;
 b=PYs8YDu7QIogeyMJWiQFOH48JY54EJU6o7mepV0jILLSLVjjuF5raYq9JN2xfWo6VFcm65dQlY/vr0X3hAUtqsa2CVPFYGp+INqVOlMh++exHUJJKkfZO8GaeHSQIPRgYOd99NjZPDEfG5nVDHDzAEzhVVJ3w5wa8AuVRUzf3sE=
Received: from SN6PR16CA0070.namprd16.prod.outlook.com (2603:10b6:805:ca::47)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:43:03 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::45) by SN6PR16CA0070.outlook.office365.com
 (2603:10b6:805:ca::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:02 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:56 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 09/29] drm/amdgpu: track instances of the same IP block
Date: Tue, 29 Oct 2024 13:42:20 -0400
Message-ID: <20241029174240.682928-10-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cbd241-1770-4fff-9dca-08dcf84122f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG1LSlMrbkpiaDdqbWN3MmFmSzVqS2JsKzFJdFNXZStQak5HMWRqeTVoMzBI?=
 =?utf-8?B?QlFLRHRpTE5KeDRta0hWbGt4L3JXVWU3M1RWYkdCVTV6NDRyT0NPL21Fa3J1?=
 =?utf-8?B?TGZOUlh6V293SXRGelRmNzNoSk5hRG52Smt6TDMrSDFkRk11b2F5dHlZdW1S?=
 =?utf-8?B?cEYxdlFnZDNJR1RRMnNsRGljMGZqZUNCMEJpQ2FoUGFGSzlXcjJ5K2tvZWFC?=
 =?utf-8?B?WGpGY1lLNG9uclRvSXVjOHltY2s3QjhYOTFVbVBMUmY2Q1NYb2hRWW1pYzJ5?=
 =?utf-8?B?a3lGaGNRWDIwYU5CZFRIR210VmJlS3FGaGZNaG9UYWwzR29YZng1MjJra25F?=
 =?utf-8?B?MWpXbTFBMFNsSHdTakgwRGR1R0xpazMzaHNQTFhPNHBVMTZPRFFPLzZmUzFp?=
 =?utf-8?B?OVNzWWJ6OXlqZXpma1VkZm9pTWpqb0ZMN01DQnRGSGJYRUs0UGtvNityVVdP?=
 =?utf-8?B?aGJxbkZPM0xSQXNBWTJURDlxd2hnakkvOHZjQVhjL0xJbVpwb256WDJkNVc3?=
 =?utf-8?B?VWFvNXY3amFtT3ZieC8xdkVtRk5uVkN4VThSLzBqc2J2Q0VBMkZkM21XUXNC?=
 =?utf-8?B?L3MxL25yZm1KZURiWGZqbHJ5UXpwZE5qcnkzY3BwdUdXQkpyMVhyRUVRRDZF?=
 =?utf-8?B?MUI3NVIwd3NCZThMYUZTWWQzd1pMMEcwWEJDWTY0ck1XTFpTemNtL1IveVpS?=
 =?utf-8?B?T2NvNnJYWkJhQ3pzejZQZlB0TFhtSGM3RE1NblU5UUdWNmVIR2EyZXM1RTNt?=
 =?utf-8?B?b3Rjbkl3cTBBdVgvQVF3QnZvUFIrc0hsTUxzTHh1NXhJbWE3SCtPR1FmU2da?=
 =?utf-8?B?OXZUalduVUoveHZUajIycXp3SXZ6RjBJYkRUSW9oNzNEYzkxeHdNNy9vamo5?=
 =?utf-8?B?WEJKeVBFekNSa2g3RHlmaWh2T24wNDVqQ24rWDQrbHVsa2h2Y0hzTHJMZzNR?=
 =?utf-8?B?Tk5OR0JnRXNzZld4Y083WHJUMGQ5Yi9XSGcweUVCeVFqNit1OFEwZWdHTmxD?=
 =?utf-8?B?Z0EzT0h2NFlvZy9zWk5GdUdaMFc0Q054R0JNazRYejRJQkNVWGlSOVpMZmtQ?=
 =?utf-8?B?SXl1alY5SHlSRkxMS3huVFBiL01zVW82dDJNa29oeHg3ZFlmTmtDWDBLaFQ2?=
 =?utf-8?B?WEg5dVVFZjdpa0tudTZqRWlxT1dSRkZPNXc0RTEzUzJTcGJXMURpVHVuTVY5?=
 =?utf-8?B?TnlVTmwvazBML3R2eHNrTjBUZFlUYlNwaHJQN2hGRitaczNvTGpWcytENEV3?=
 =?utf-8?B?QzNFVS9DalBFa2lmZFI3akJJaFVNK0ZpU2tmcnMxNERSdFhXZ29iQUxUMFE1?=
 =?utf-8?B?aU1seWJLTklEbWxjYmtYS0hTU040V0RSYTdaTENldTZ0UTZUZUFlcGNsQitN?=
 =?utf-8?B?R0lZOE1iTFVJd01BcXZiUGN4WFp6ejl6ZnRPOWdBT1Y0NFNHcFlGbEZtVU1H?=
 =?utf-8?B?ZHBtZ1czRElPT0ExV3Y2UG4xbk0vTjF6YS94ZmRRbFdURnpsQlNrSVRQZEFJ?=
 =?utf-8?B?c25JdjhycEVoWW9JNXNZOXkzQm1sWUNyV2lzYTYwUVIxSndjKzQ3ZVljMzRo?=
 =?utf-8?B?Vml4WWNlWit5K3VrL3Q0bTBURVBSQkJ5WHdmWndMUkNkRy82RUlia0xRc2ZO?=
 =?utf-8?B?S1RuR1B1Z0puM0FRYWxqUDNOay94T0VBQXh2UzlCZGxrdlhpa085NVcrM2Qr?=
 =?utf-8?B?WFkxRHB2MGhZcDB3VmxvVnJ5b2hnMklzclUzVGY3K1R6S2Vwa3h2R2RBNGUy?=
 =?utf-8?B?dG84TTJJWENJUVZHYms3ZEZ6b0tXRlFOOWo1bEVXZVlsWjBoUE1yYWJ0QWdF?=
 =?utf-8?B?WXJNRmwwMkpBZjVONXNUTzhJcmJYYjEyY2hVZzBXNXVuOHFLNkJya0ppbS9v?=
 =?utf-8?B?NGJKY1l5M0l1UTE4SlJiMm1rUGdQQXExa3p6SkVmN1dNenc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:02.2136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cbd241-1770-4fff-9dca-08dcf84122f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add a new function to count the number of instance of the same IP block
in the current ip_block list, then use the returned count value to set
the newly defined instance variable in ip_block, to track the instance
number of each ip_block.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 93c352b08969..a7cb1d2d6e74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -390,6 +390,7 @@ struct amdgpu_ip_block {
 	struct amdgpu_ip_block_status status;
 	const struct amdgpu_ip_block_version *version;
 	struct amdgpu_device *adev;
+	unsigned int instance;
 };
 
 int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 74711e6ba88b..78b0a162cc7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2322,6 +2322,28 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
 	return 1;
 }
 
+/**
+ * amdgpu_device_ip_get_num_instances - get number of instances of an IP block
+ *
+ * @adev: amdgpu_device pointer
+ * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Returns the count of the hardware IP blocks structure for that type.
+ */
+static unsigned int
+amdgpu_device_ip_get_num_instances(struct amdgpu_device *adev,
+				    enum amd_ip_block_type type)
+{
+	unsigned int i, count = 0;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == type)
+			count++;
+	}
+
+	return count;
+}
+
 /**
  * amdgpu_device_ip_block_add
  *
@@ -2354,7 +2376,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 		  ip_block_version->funcs->name);
 
 	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
-
+	adev->ip_blocks[adev->num_ip_blocks].instance =
+		amdgpu_device_ip_get_num_instances(adev, ip_block_version->type);
 	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
 
 	return 0;
-- 
2.34.1

