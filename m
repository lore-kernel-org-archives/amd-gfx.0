Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAACCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3946210E5CB;
	Tue,  2 Sep 2025 08:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0efnrYiz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0E610E5CA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnaKnsPP+GfW45FQ0givZni0I4urKLnD/HiR8EmebLmkFbj9JOHgZYnKGam+0k3Eh7Xg/VvxDTb7P6Qd25n57JOyKVNx3na0Lffmb7lMfzrUk+A5CBrVoouImVOBK815Cs6QsNSrzd7XBqG5U1HXTBjc9zYu2Q/QtEfRYxKPKkIiAUddO2X/6D1BSgPJY+pbBy7eMbPTeMPBlq+dulcrEZu89jmCYRFKLGlHC0M6upEQ7mt7WwCdPfmk/3vjj24b5TFpJ6Y7rYCoLG4lMT75kESDFrNMl6QttfihcvgzdBEm6BxRMIp01z6Walyy2JSsm79EE33Itoca2IrUxVC+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=a9qK0twQBXJNsItvPRg0IH39gDgz5GT81ludT1LFCPPSHElc8rsYuyA4ntI4Ql91+wsxuPCdpyG7ZNZ8BSIApxWn27K6wqnwatKSTmfr4rFi56Rp2xbpWwZchB4ou2tPsd7gaKG3Ec0GBheTOd8t4gEAC7MaMwukgnX3txKPT6wLidIaLi3eBddZOeLPUTNWexKvmwQtEIoiMPn+sU9lvlkl81g9RlDFItl0yMQuiQmZuMNDUREI0OGe/q7KUZW+NAUtbwc+mqJ4Lcc8gzFX8x/4fDXPeMl8wQYhUYupaqcxFOLX6Kl1Ypx92nk3UNVrpwKmoHSx7nN89Va8ttU/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=0efnrYizo6cqg6N5/3oTnZ/N7S19wE3EmZJ8KfIqd7G6uxoQv8oUdUEtKvl/cvQXphfmpQdrgnU/VBD+dxyllODlCVqt636bw23zxV7OuzLfmGE7RhsReAjREqiTbJLIUGNuqDHn4EIINBhGMogy9Jpo1sjWY9OpxOfw3Ws5lMk=
Received: from BN6PR17CA0046.namprd17.prod.outlook.com (2603:10b6:405:75::35)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:07:41 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::8a) by BN6PR17CA0046.outlook.office365.com
 (2603:10b6:405:75::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:07:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:07:40 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:07:33 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v13 04/11] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Tue, 2 Sep 2025 16:04:05 +0800
Message-ID: <20250902080712.2515811-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9383e3eb-2d0e-484a-795a-08dde9f7c9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bUgmOYkvJnaoQcTAW7PBJ0qVNZcd8MhOVnoQwZ7g6K40YzOnLHtNTPpWN7f+?=
 =?us-ascii?Q?CPLUPVKrPb+2Jn7eRXUJyvE1BnYtD4+lvPTnq1T3n9Y4CZf/5I3yV9VrmUqD?=
 =?us-ascii?Q?tmJfz60QxcGss93Zr1E/Y5R2vzlqlPUxNKyRxNPhiBG6W7uXtiwlGDrJLGky?=
 =?us-ascii?Q?3Dz0G64q9Aud9vXh6KZJKaezp2pLuxbkZb4wv3z3cbz4mgavOW/yb6cjPb+N?=
 =?us-ascii?Q?vMuOb+ypq79SO00jOxgB+Awfo3jEoORNpUzNit93TTXWEvRFdlH4B1ua7K2T?=
 =?us-ascii?Q?wU5efwrZYYWgyrUerKu9Gtfp8QaLmxVY5/DyUte8h4pWXSCTbZoX2LW/mD+k?=
 =?us-ascii?Q?9xaLNwnrLVkJZpnedLYEdYlSJi1tR0jfpPC8y6jaQAihtlIIRY9OfBpd4eea?=
 =?us-ascii?Q?dX8AyT9qoSuaqqPfyrYwlIt8YKS15eZB85W7s3hSPQgBWRVqp5xWW8B3DQ/r?=
 =?us-ascii?Q?TUk/WExZA63XNUNs7XlEpk1AVK9Thp9hFMb22YOjYjncMNaCrXO1ZToUfFO8?=
 =?us-ascii?Q?ppHuzdUhVUCbhMdxeuo44WLNnRXf4KITFVA8hQ3rNtRkJxwyDlj63cSSImWI?=
 =?us-ascii?Q?i76YyeC5khPYYJMJEVCpQIGbteNp2IDEwFAXkuc50XDGWCgjqHIwthAQMfLz?=
 =?us-ascii?Q?lf1TzB3iq9gxt+extzzIi9sQZ77RB8qycqWe9TbJCDTqPvzz0//aywgIKLRX?=
 =?us-ascii?Q?cqJmc8azg31YrvXk4jrq9/zKooGI+kIM5HJsIxPwJnuvupdTY6QRHpxpkUjf?=
 =?us-ascii?Q?f7W3XzH2NgI1OUK/JWWvX95CmR9KvujsdLVab5Bys9ojKtZC+G8RTIG9TITi?=
 =?us-ascii?Q?2VgsDtZOwyUfCwxHchz8zR0a/UkR6qtFIhnfuaOIcjPqnYLQrmSJ5v8R6UjH?=
 =?us-ascii?Q?rvPiPmOe3AwFANvCkhrYWdbyCH0VKM+bVnKmUsQptko84kYgkC0R927mTcmj?=
 =?us-ascii?Q?AYk2yQWQDJOE1tJfHxRDskziNDWJw1Unneewc6CCh+OR6oOoVRZR7COd8crl?=
 =?us-ascii?Q?DxtIv8glqBS1EOgLXZXAzigJd6l3xjwAjZF+PBdSrzCIQrx4+nP/PoLWpJ50?=
 =?us-ascii?Q?9343IFbGU1/bWgPec23Bd/JCx6/NeN4eJZj6zvZGa0ONP6mBaIKp57NeqLzV?=
 =?us-ascii?Q?xlcjtwpZhztGduDtg8cUDGhCE8bZyfRKyocQYarUdvqIij1ED/DO11+laVlx?=
 =?us-ascii?Q?Fikhbuu52ddtw/zg16j4111JvSM11GAo8t2LxdJb+EbHJ2DRT4G5UhHKWZOT?=
 =?us-ascii?Q?hpcPtTRrOQyQb1agMtgsR83NODG7MolzBhwDYS7he7baluW27O1SYMnEBo1J?=
 =?us-ascii?Q?xNiqENiRXFVfajje3xo6legFva81BV2uI2Ojy++TBRqoqXrTFurEbBxWgFGC?=
 =?us-ascii?Q?dpnGzVXbMnmgz2m/5tiMRkTwdpp0lmDb4w2WywJz01oUZQZk/Ow6SHYeSALA?=
 =?us-ascii?Q?peZg0yY+uZdSmkE4PpHJJpnYjIBugqRSsgNS2DW2jxb5XyR4OnF9jfabcbkF?=
 =?us-ascii?Q?p7E6BrFpI8M1qgbzmPBF5CjEGlF/LqZFbXWS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:07:40.9959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9383e3eb-2d0e-484a-795a-08dde9f7c9ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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

From: Alex Deucher <alexander.deucher@amd.com>

Helper function to detect and reset hung queues.  MES will
return an array of doorbell indices of which queues are hung
and were optionally reset.

v2:  Clear the doorbell array before detection

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 65 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 ++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 135598502c8d..5bf9be073cdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -191,6 +191,20 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error_doorbell;
 
+	if (adev->mes.hung_queue_db_array_size) {
+		r = amdgpu_bo_create_kernel(adev,
+					    adev->mes.hung_queue_db_array_size * sizeof(u32),
+					    PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_GTT,
+					    &adev->mes.hung_queue_db_array_gpu_obj,
+					    &adev->mes.hung_queue_db_array_gpu_addr,
+					    &adev->mes.hung_queue_db_array_cpu_addr);
+		if (r) {
+			dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
+			goto error_doorbell;
+		}
+	}
+
 	return 0;
 
 error_doorbell:
@@ -216,6 +230,10 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
 	int i;
 
+	amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
+			      &adev->mes.hung_queue_db_array_gpu_addr,
+			      &adev->mes.hung_queue_db_array_cpu_addr);
+
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
 			      &adev->mes.event_log_gpu_addr,
 			      &adev->mes.event_log_cpu_addr);
@@ -366,6 +384,53 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev)
+{
+	return adev->mes.hung_queue_db_array_size;
+}
+
+int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
+					    int queue_type,
+					    bool detect_only,
+					    unsigned int *hung_db_num,
+					    u32 *hung_db_array)
+
+{
+	struct mes_detect_and_reset_queue_input input;
+	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
+	int r, i;
+
+	if (!hung_db_num || !hung_db_array)
+		return -EINVAL;
+
+	if ((queue_type != AMDGPU_RING_TYPE_GFX) &&
+	    (queue_type != AMDGPU_RING_TYPE_COMPUTE) &&
+	    (queue_type != AMDGPU_RING_TYPE_SDMA))
+		return -EINVAL;
+
+	/* Clear the doorbell array before detection */
+	memset(adev->mes.hung_queue_db_array_cpu_addr, 0,
+		adev->mes.hung_queue_db_array_size * sizeof(u32));
+	input.queue_type = queue_type;
+	input.detect_only = detect_only;
+
+	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
+							  &input);
+	if (r) {
+		dev_err(adev->dev, "failed to detect and reset\n");
+	} else {
+		*hung_db_num = 0;
+		for (i = 0; i < adev->mes.hung_queue_db_array_size; i++) {
+			if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
+				hung_db_array[i] = db_array[i];
+				*hung_db_num += 1;
+			}
+		}
+	}
+
+	return r;
+}
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..2c4568951edb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -41,6 +41,7 @@
 #define AMDGPU_MES_API_VERSION_MASK	0x00fff000
 #define AMDGPU_MES_FEAT_VERSION_MASK	0xff000000
 #define AMDGPU_MES_MSCRATCH_SIZE	0x40000
+#define AMDGPU_MES_INVALID_DB_OFFSET	0xffffffff
 
 enum amdgpu_mes_priority_level {
 	AMDGPU_MES_PRIORITY_LEVEL_LOW       = 0,
@@ -147,6 +148,10 @@ struct amdgpu_mes {
 	uint64_t            resource_1_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
 
+	int				hung_queue_db_array_size;
+	struct amdgpu_bo		*hung_queue_db_array_gpu_obj;
+	uint64_t			hung_queue_db_array_gpu_addr;
+	void				*hung_queue_db_array_cpu_addr;
 };
 
 struct amdgpu_mes_gang {
@@ -280,6 +285,11 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+struct mes_detect_and_reset_queue_input {
+	uint32_t                           queue_type;
+	bool                               detect_only;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -367,6 +377,8 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+	int (*detect_and_reset_hung_queues)(struct amdgpu_mes *mes,
+					    struct mes_detect_and_reset_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -390,6 +402,13 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio);
 
+int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev);
+int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
+					    int queue_type,
+					    bool detect_only,
+					    unsigned int *hung_db_num,
+					    u32 *hung_db_array);
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		    uint32_t reg, uint32_t val);
-- 
2.49.0

