Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD768CF8855
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6A310EA88;
	Fri,  4 Oct 2024 18:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AeTjPCwq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5214B10EA88
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUou+RLssGuTFyszHYZF0giaLLEy6azRQn1IOnhKluPKlGX0sz/OsxOPChmgldcx0PUOKn9QdejWEPE8Oea1NtnrxA+3GSOyAYryEJX9XLbZ9vqJdzzo2UQsYpjuCz34eaA1sglOvnP1iit6lWYg/dxJS8n0pohaPrJGDS0MpqgzqsKW0K1cnl/BHd9jRnd0K5y1alS0jmcrlJsAIcm+8oH18L4UFV5jzwL/X4A27NvQnDJQOB2TOg/L+jYK539VyAZOnikY2i9JxRLZ9Yuteq3PLlRmoMpKiLCrZgu7tpfSRVvuw81eg6JSUanGjMFEg8QQmHPmBJl83slHX1XWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhcWnecBlmj964294o/JvsXnlCWBBelfU60D00ROb14=;
 b=EVSlFj17fW4yNJqP54QWFa5zCNrKBZPhNNOGzsltGpzHKN5BjCvDMqmYaKa/XlgzzbzzKOWYq6NICcNf+ZTb+/VO4EeqXE5vxAvQbp5RAGtT5icmPFHoM9MU52VuT5Aew2eN5P4oN4cJ6L2GDsCr2n5FLx60BopC7wZ5B9ETruSGxPbseozE9p8vcYmT2mMzoQBiJRwQmGFMWyxzL6EHzCqy0qioRCdV/o5wjFZzp1w7mQsLVvLT5hvwE0c658qz/YgoaYArCzW9ll5fKLmaTa7N5oHNw4baur0OqefklwjaCXdzvtYSkd8FR5GpfiLYBggJzp+7z5N7H8DdGK75+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhcWnecBlmj964294o/JvsXnlCWBBelfU60D00ROb14=;
 b=AeTjPCwqMR2oPScSktnTxreil7I1oHQGC+eh8yUMEXhESJKUpR30EuAZWIzrBmlNDbiuopOch1lLgxecRJtogi8BCEuT4ps20GHnfMZRgsaZWps7+jq1CSUWFJuQmkpJ0YnjXN28dDbgvi63mXPtiEXKynO+yFvSqPdWbzjGGtU=
Received: from MN0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::13)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:45:06 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::82) by MN0P220CA0015.outlook.office365.com
 (2603:10b6:208:52e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:06 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:03 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 08/18] drm/amdgpu: track instances of the same IP block
Date: Fri, 4 Oct 2024 14:44:34 -0400
Message-ID: <20241004184444.435356-9-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: e8be3318-4dc1-45b7-115a-08dce4a4aa49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFFOajlNQlgvZ3pVNENHZG5FbGJ3QVNNaEtWMFFqYzI3c0Y5Nm9jcDB3ZGtQ?=
 =?utf-8?B?OTEwQnpaUUxLRVNuY1dZNC9Zazh4OTJVRktzTXZKWUswU0YyVVdrRlZQY0xv?=
 =?utf-8?B?VkNlQ29GYU1zYi9rbE5DTnZ5NUc1cTgxRjdTTXJqbmtubG0wWGZQYUhmM1di?=
 =?utf-8?B?Q3pKbzJIMG9sRURKU04xaFF4Y2hGWG9MSnZ0SjhuSUdwT0E5MGhnN2VZN2px?=
 =?utf-8?B?RjFLUlJ5VE01Tzg2cUVoYk1BaEJmK1R1UDI5NEYzbjNLSlhDQXJTUERueHRt?=
 =?utf-8?B?MkMvM1c4cjErcGtWODMvNFdhelB1VEUzNENBMnUzVktidUhnWFBUQnFUV0ZB?=
 =?utf-8?B?VWdUOFB6ZFJnME1zVU0wdjdleEZyeGh5ZUljdldoT0dVNkp6emhvTGVzNDY3?=
 =?utf-8?B?L3AxUkFnK2ZXenU1TlVqd2ljcitON3ZwQmN3eHZPblM1NC9RRnJUekR1VnJq?=
 =?utf-8?B?NnBjT2ordHl5dGhsSGdlZ3BJTnBjbThRRXNIMlVxcC9mYkxtZGdISFVwSnR5?=
 =?utf-8?B?eDlZYkNNV2ZMUi9iOFpFSXVUaXIzRjd3MU4wekxUSlFYdDhJQW90MzVZVXNY?=
 =?utf-8?B?enVxWEtsRkViTEkyS3hINzdzQjBBZWJGL2lUQ2dDSGJ1anlvRWVOUGZIK0hv?=
 =?utf-8?B?WldicWQ4NFVhUmxuTHZGa3ZNRVFTY2U0cG4yWmM2TTNiUUI4ZUxuR2VjdVRY?=
 =?utf-8?B?b0VOMWdxU0ZiaXN1dVlHTVY1Sk5PalNBQk1EeW1KZll0b0tOYXhiWTltVVlX?=
 =?utf-8?B?NmRrVFVTSG80aTZuTHJVNzBmK01zWFdBRjhUQXJPL2YvOXZRVXp0cWVnWUtB?=
 =?utf-8?B?bHVFQkcvbE5oK2R3amptblg0a1JVMzdmWHVVN2NSNnk5Ky81L203MGh6VG1X?=
 =?utf-8?B?bUZHSUdLeStOODV2Kzk4WmdxUVdTcVJueUhnM2dJQXRoV3F4VVZNaE5PTndO?=
 =?utf-8?B?bFZudHFXSk1MUkx0SDlUUHZ2aTdEVUJpZTRSV3dQYURwdnpxa1dZeitaTlli?=
 =?utf-8?B?L0YxODQ5T1ZoclhYSzN1Wnc4eUM5cVEyR1BqREl0aHYzb2lrc3Fjb041L3d3?=
 =?utf-8?B?VjVvUGpESm94TEpRaUxaQ043eDFYQkQrNUQxM3pYNHRELzdFZnNJTTdrNnps?=
 =?utf-8?B?Q3FuaHhaQksvcmE0TWRXN2Y1SnRvL25lZ1Z5MFgwdXAzbVlhd1dhSzJ4Zzlm?=
 =?utf-8?B?d0tpME1aWGNKSzYzdndQR1RZWTgyL1lnRW95WVcvNlNiQUwwU0tYbGRyQUFM?=
 =?utf-8?B?ck5Od2ZkTG5sZGY1cHN1Y0dxK0puNTRqb3hGUnVOWVl5QWpkNFEvNEFsbEFK?=
 =?utf-8?B?K3Q1WnRlZzU1T3YwaktrbHY1cURQVHlwYTdXdmVwZnk3dDd2MmlzRUVKRmlH?=
 =?utf-8?B?RSszTmw5VXVTSS9XV2dyOUFkZ20vYjdncm9LU21BLytQVml5N2xhakttVTN0?=
 =?utf-8?B?SVJjcEo0VDJRM3FtUnYwdzI4SEU2RkZsTVcwTTNyZ1hRdlZBVnRjOVdMQ2Zh?=
 =?utf-8?B?Q2RqcGhpRGpwRFFOZE5OU0Nac2ozTFZUaUJXakpkYjdjKzZ0VDZscW9wUUhL?=
 =?utf-8?B?R1pkb1BkOWk2dml0MENxak1EdERNUzQxSFAzSU9CYVdtOEpSVHlCakNHSjhS?=
 =?utf-8?B?bStIZzFTcU5YLy82cDhjYzIycXZnNUpVSWJOL3JGaG9SSHFxY1R6LzYrQk13?=
 =?utf-8?B?eWVxUkpZVDY3Y25TU3JTQUxsOTZFRTBKMklGNTFteXZJUTlYMHpINityc3BR?=
 =?utf-8?B?SmxaV1NaV2tyajkvUDdjSTVhSDF1VlBRS3RCSnl0K2FjTjVCQW1idG1ZMlZI?=
 =?utf-8?B?VTkzdUFXYUN4cGY0K2NlMFlrV0dLTWlzaTdCcXMyTFM5UDFhamZwT2xQUWM4?=
 =?utf-8?Q?rV03gVl/1D/hi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:06.1046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8be3318-4dc1-45b7-115a-08dce4a4aa49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..3442564fe174 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -387,6 +387,7 @@ struct amdgpu_ip_block {
 	struct amdgpu_ip_block_status status;
 	const struct amdgpu_ip_block_version *version;
 	struct amdgpu_device *adev;
+	unsigned int instance;
 };
 
 int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe5de35eef64..35a3e71a5a84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2283,6 +2283,28 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
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
@@ -2315,7 +2337,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 		  ip_block_version->funcs->name);
 
 	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
-
+	adev->ip_blocks[adev->num_ip_blocks].instance =
+		amdgpu_device_ip_get_num_instances(adev, ip_block_version->type);
 	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
 
 	return 0;
-- 
2.34.1

