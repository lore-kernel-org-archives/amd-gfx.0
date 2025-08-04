Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802D6C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED16710E198;
	Mon,  4 Aug 2025 11:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5imtJkDH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2E410E2D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh/SwBwIv6y2Qo+Pdngu2SLz9v/MdvOSRsBXzy7ojIJCehjxVoO3kjpJhDCqZRBnQgy4j6bkOtDmC7Dv+nlrLV61l5rPALzniXKzeAmuh9YhvP5iJ8MPPRqACIexKvPsIN1aEXE4faBuHhbe7vPXUkgcME5CiNUOqbuX7eVUqIwu/iD0VCe2UL834SV0D6REdPq3y3jbCYnYlBbOHXXIXagEcNyciMfGjzyYzlvu9O6rlEQQbybvwLVYcE6A0DX9FHrpRGW6jl7geJed25+dgqrm3Qaqd/Wzaf3NEvFr9ct7IZhlMuNP8/8jDo8fjIEsPM6emT8MqDreiutA0Hd0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYcSdme0puJX7OmoZE8LZE0rlwMfWv+Z5t6DtycK5HU=;
 b=bKx1UiNAKdr8LjlqCSw2L7Ll0dxtM6msAxcJO65iqFUtT/U9RCUSWgpdnK0ZDjGqnrvTdg6ZoBaROXs4B0nnXRVjlZpfUiI4iPcTj4USu1mYAkD3IUnnhEZi3qeEBj6VG3AjxEnWWn7Wt0wI1YPq5ei8eaz+5EvdXLG0GYG/izGw2fhRhDIchM7nGO8OLfJ0UUk6+DGam/BQNR/Kmow8euByvKZbnVNeXYcRiv8zKZVVwXVDBkAQ2xIrA/VT429j+7DG9i/UjOo+Z0x7J0RrYX5fd8OmHaKSeC/cVf83eeAexwHvPjpiE4GSFFNGFX+eOaV28HIXVIgmZEKcNqQTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYcSdme0puJX7OmoZE8LZE0rlwMfWv+Z5t6DtycK5HU=;
 b=5imtJkDHPTnHb1V7ED0o2gzuMIbkdECsfBxQkLAAAiO8dSwa3pbchA1/CwJj7pyPM5aRM3oBXQxrrKHc6sMzNqFjfUtVqKBr/KX5ZAiiuEpJ4vKMxlpxn09K1np+pKSQ0giu0yLqh/tyRE0d4+q/2nTlPKtGltEqoFIGzxDHnE0=
Received: from BL6PEPF0001641E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:e) by CY8PR12MB7194.namprd12.prod.outlook.com
 (2603:10b6:930:5a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 11:58:31 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2a01:111:f403:c803::3) by BL6PEPF0001641E.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Mon,
 4 Aug 2025 11:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:58:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:58:29 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <jinhuieric.huang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add helpers to set/get unique ids
Date: Mon, 4 Aug 2025 17:28:05 +0530
Message-ID: <20250804115808.1758735-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: f5593e77-5579-4533-af5b-08ddd34e3b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9vEkcR2A/48zciUJGognyxlalcQNBolLeFgx8znbg3z3na9b7JNBWxwBEN1G?=
 =?us-ascii?Q?E5UPBrgJ0Hg82GxiU/yYJvRdHE/1EYlQMGuhtapq1ebbvi7OHNlmMPTS256k?=
 =?us-ascii?Q?y/avJIwf8m3W7FqUDjLQBw2dRMNkq64vcq9kvuh91rD8yLMTC4SYpqWaKt9e?=
 =?us-ascii?Q?JIkKxXlqAHxZyhVUnSm3QTuSVvWkpLvsNVpQ43uwdpIk4TgNcs9746n7ZIWA?=
 =?us-ascii?Q?FSL1clgYdCtSnMnW2kYZAafuX3a44IE2ZUIB2T5V5biQft6PJp07lYdKQsVC?=
 =?us-ascii?Q?OpeeMcIVMFHozXxBvQWdxqqSz1Bwl5+xhja8df1gSbewuWs1MV/CsKPesKjN?=
 =?us-ascii?Q?xbykCAJwLZ5fTbJ4pV4aDhLCikrFoSQgB8eCHBk62xjzYxZxcplhn2D7Ro/A?=
 =?us-ascii?Q?eQ6/xwSnnGmGyH6/tRyIizgl+77lct3nTb6OokfybFNp5TShQ1RAq8T7Fheu?=
 =?us-ascii?Q?P/c1hQxF+SwalxPRtvgLfyMP5lbIIUuA4/Dry/JrgD2lJsZnvfc6LlCj16/L?=
 =?us-ascii?Q?95JPrEuvbz/7v4/miG+58q/n01Oi0fITjHqZSyfRNgveeSSDhGv9fFomuCQZ?=
 =?us-ascii?Q?gdTjfUjcadF4/TqxSLJlbdNXD0Z0hcUSBAyM8NAED1unZc9TibMMKCWIQbmH?=
 =?us-ascii?Q?RAiFzbpxEF5F3txm4EhHt11MEkLu0tcVu93vId9tOtJ8dC8MbFGtgZW/Gk5o?=
 =?us-ascii?Q?SnxpCN+wP1eNGskGM2OYOsst/rgo/eMI+7Xz4fyKPStiAgx2OErHko5OCjHP?=
 =?us-ascii?Q?u+NAkbhZTWITwWsD7f6ZZwIhv7VDRrjUbGcULUNOU78m9cGi/RAWkpkLaY8E?=
 =?us-ascii?Q?1rStBp1e09Awpu6gaGoUVn4PXjJx/0QfE2diMBcUURMFlog6cgiZFFr/GDlg?=
 =?us-ascii?Q?LdUBpxK3mLb7XeYbUAqCVGW/KNZ2DM8lj4emrJqYkgGIAriosfTGsQSgP4nm?=
 =?us-ascii?Q?ILaLSWwWDKJl4rC7ZonVNAZ8f8MX9+Vj2NXwAntSmS9ziyHL+/MKRVBT7b/x?=
 =?us-ascii?Q?JFeOVN1GjBGBgcMBj7f+euhn+xqU/ohTSEdziwiLbgAxYbrkVqlnaZAR0OJf?=
 =?us-ascii?Q?UT/kUkLYDJYltPPAOBqXcBIKzC50sdCymkvN7yPnHgur8HXPwDaF5lWrxMem?=
 =?us-ascii?Q?8QDI0Un3VPUAN+baduHIVQ20usWTYWfQAgi4XAriFBp9A6dUROicVqVjnegw?=
 =?us-ascii?Q?ca55ZUD5CqEAXGZTr5RMWc6eMI4OpqbhJgtG06zOVs04YHlnUj/3KrqUzJ8U?=
 =?us-ascii?Q?zEfZrhLnr2C3Bfp/DfTsvI0yIuyjtIPZgVIEzGkjJtc238GxZqiTN1iUbHOn?=
 =?us-ascii?Q?sT/xWtgZbXIGYQpCKkQW8vXYdcL/OxD6Yx88jBW2+w2KMh7uKJ/VWwFPia9T?=
 =?us-ascii?Q?MUPUnMLvrZbVbWmqC9+R+uV1L5bI4FucxiE2H52Py8b2HIRxuT9BzwQWHALP?=
 =?us-ascii?Q?ZhDqSSZUFhQqGzxMrZbrHQGHCw5+jsZrMObDdfYmXKUdQredw2o0k7/MCMny?=
 =?us-ascii?Q?li5iTvVDPceAmp+vOBQ6Gp5KiRHwXkLDwHx3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:58:31.1422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5593e77-5579-4533-af5b-08ddd34e3b46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194
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

Add a struct to store unique id information for each type. Add helper
to fetch the unique id.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 20 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 71 ++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ef3af170dda4..c2771e32d0bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -819,6 +819,20 @@ struct amdgpu_ip_map_info {
 					uint32_t mask);
 };
 
+enum amdgpu_uid_type {
+	AMDGPU_UID_TYPE_XCD,
+	AMDGPU_UID_TYPE_AID,
+	AMDGPU_UID_TYPE_SOC,
+	AMDGPU_UID_TYPE_MAX
+};
+
+#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID type */
+
+struct amdgpu_uid {
+	uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
+	struct amdgpu_device *adev;
+};
+
 struct amd_powerplay {
 	void *pp_handle;
 	const struct amd_pm_funcs *pp_funcs;
@@ -1302,6 +1316,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct amdgpu_uid *uid_info;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
@@ -1785,4 +1800,9 @@ static inline int amdgpu_device_bus_status_check(struct amdgpu_device *adev)
        return 0;
 }
 
+void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
+			   enum amdgpu_uid_type type, uint8_t inst,
+			   uint64_t uid);
+uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
+			       enum amdgpu_uid_type type, uint8_t inst);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 370c8daada8c..9eee1d4e1eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2675,6 +2675,24 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	return err;
 }
 
+static void amdgpu_uid_init(struct amdgpu_device *adev)
+{
+	/* Initialize the UID for the device */
+	adev->uid_info = kzalloc(sizeof(struct amdgpu_uid), GFP_KERNEL);
+	if (!adev->uid_info) {
+		dev_warn(adev->dev, "Failed to allocate memory for UID\n");
+		return;
+	}
+	adev->uid_info->adev = adev;
+}
+
+static void amdgpu_uid_fini(struct amdgpu_device *adev)
+{
+	/* Free the UID memory */
+	kfree(adev->uid_info);
+	adev->uid_info = NULL;
+}
+
 /**
  * amdgpu_device_ip_early_init - run early init for hardware IPs
  *
@@ -2858,6 +2876,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.supported)
 		amdgpu_xgmi_early_init(adev);
 
+	if (amdgpu_is_multi_aid(adev))
+		amdgpu_uid_init(adev);
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
 	if (ip_block->status.valid != false)
 		amdgpu_amdkfd_device_probe(adev);
@@ -3648,6 +3668,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	}
 
 	amdgpu_ras_fini(adev);
+	amdgpu_uid_fini(adev);
 
 	return 0;
 }
@@ -7467,3 +7488,53 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
 	size += sysfs_emit_at(buf, size, "\n");
 	return size;
 }
+
+void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
+			   enum amdgpu_uid_type type, uint8_t inst,
+			   uint64_t uid)
+{
+	if (!uid_info)
+		return;
+
+	if (type >= AMDGPU_UID_TYPE_MAX) {
+		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
+			     type);
+		return;
+	}
+
+	if (inst >= AMDGPU_UID_INST_MAX) {
+		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
+			     inst);
+		return;
+	}
+
+	if (uid_info->uid[type][inst] != 0) {
+		dev_warn_once(
+			uid_info->adev->dev,
+			"Overwriting existing UID %llu for type %d instance %d\n",
+			uid_info->uid[type][inst], type, inst);
+	}
+
+	uid_info->uid[type][inst] = uid;
+}
+
+u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
+			  enum amdgpu_uid_type type, uint8_t inst)
+{
+	if (!uid_info)
+		return 0;
+
+	if (type >= AMDGPU_UID_TYPE_MAX) {
+		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
+			     type);
+		return 0;
+	}
+
+	if (inst >= AMDGPU_UID_INST_MAX) {
+		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
+			     inst);
+		return 0;
+	}
+
+	return uid_info->uid[type][inst];
+}
\ No newline at end of file
-- 
2.49.0

