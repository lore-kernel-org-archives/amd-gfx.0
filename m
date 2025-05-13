Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7235DC3ABD7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4616F10E375;
	Tue, 13 May 2025 11:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="31AomYTu";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9296410E37A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQWDXdqZXY0Zhftgfcf3ICShaxf0WZvIUW35Gw+C4zwe4vpQEfQdTBfhqJx/mb4x6tzxPCfLzlYnEgpdV4Kw2wJYaX7uk+Xgi46s9tWEwij5r621cbQNZyGCtM9+aQyfVF5iuSzDfG913XBu8CgiiQyJgDYvgu0WYebTZ2IoJJrpzIhCxE+mGBv3OQ38b5IDcmrynK4iAp8rqHADa/2n8mMho7vjX+7tV/LWxmtxTZVtbnvyszJLWAPM7viNSanIB/7NjOaRnARrOrb52DNCzepp5WsGqD1PcZzXnDxghKJ4JUlWv5t+/ZUx6Syet+Z4QjYiGUgx/hDYlXEFnFWVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSfl3uNO1mkXkQZHOU2MLIuffFvpjHVyHY/ESPoPfiE=;
 b=WxjAJ/vNjgNdMHikFUVU7NPWSvneyN36PJb6RJ5/QniMEZzXMh4R6cj/rAU3iFX99YVt7vPv7eWgqaNxXcRRxiTG6eINk4aXidU0qOncdXyftCSArCR5We93Y3LILyCLRk1vztFm7I/yICB6N6ftRy40sH1c4F7AuFvw90XcHowfBqjwuYbXAVwS/Da44Js9UO78tn1khmgXbCFa6rskGO+FU4OtKclow6WrdGL8u0jThXahTKv6OI/rV2+1Lpgs0pPCFqIfcodzy3FvP3YZmCWJzvg8vxNjtX7vQbMMuCRVoGkTAYfSTbXKGkY6bQMSxEjM3cdLlr/rIjR9kqaSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSfl3uNO1mkXkQZHOU2MLIuffFvpjHVyHY/ESPoPfiE=;
 b=31AomYTuvccmvVoaJsKIE0opRQ9R/yZfO3RRe/P6M3/0fkWZDLRaRknpVJxOpYBdrlpCbhB9HT/7/6wWAkydjlanajFNQ0HUvzQE0sCflY0JgW07AtaWmI4U+zw5O0EuidR0/yNsKz5834WJ4iN284Ut3GjTX+CsjE70xbjJKj8=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Tue, 13 May
 2025 11:22:03 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a2) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.6 via Frontend Transport; Tue,
 13 May 2025 11:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:22:02 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:21:59 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add pldm version reporting
Date: Tue, 13 May 2025 19:21:37 +0800
Message-ID: <20250513112139.88355-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 062288a1-1c30-4664-a246-08dd921062a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c2lT0OJHzHU5HtJhHnBeWrUIXgSeIw4DA8R9S4HbjjLE9/RK8fsDn+Y/sPOQ?=
 =?us-ascii?Q?UONHAq25DdA9O/uQnNeD189PBvVUp8rqUHVQCKBh+ulamP+NMWkVn/mciZ6z?=
 =?us-ascii?Q?7Xnvzm7WP5vVGkt17+R/qnOlhY7+iCAC7h6wKMra7sofyN3CgKgUDpHpMU9P?=
 =?us-ascii?Q?YMrrkeoQPOfqVUndToTmkrezcNrDuSkEAPt51JCbUZZxFEHiinceNyMPXkSV?=
 =?us-ascii?Q?end3+uSa2WzAqvA0q3EblNWtI95VJE3pMt01D5FomLK8tXY5JyPj0xOrhDtF?=
 =?us-ascii?Q?3Kbz6YW/teB+MdKQ/KfSpSXKS6d4NeUL88GZillajrg9+8RYEqIl5WTQ4/cG?=
 =?us-ascii?Q?YrD/3/caQ+j149YUocSkmFWGQRNDiUv66YWBua9WcN0aM9JkrgazNuIXEEeJ?=
 =?us-ascii?Q?IITTvjHJzzMRA3a6PmTlHb9pMxdKfABPflHoCobb74QOFbRE2uZPazDuKvaW?=
 =?us-ascii?Q?WT/tVrt1SfIVv3ShO+Nw3nWE3LuiRO9Od7CbARwkNSTv5VI+HhSa9wZ+BMjH?=
 =?us-ascii?Q?zTyutIiTXzUHf1xg3rTyYrpB8AtS0NGioOL3D6uQ0cadH4LReo7PqqnuCWiZ?=
 =?us-ascii?Q?Lsd9gOF1Jyai2BNwA/RP9B+Vuc4Eh6rrT1a4af5bq5gFsDjnprvi8ECV+jED?=
 =?us-ascii?Q?ihM5Ek0WOW9GJMDNXs6SIjBchBH7g7VyAFjDLmEXPXXE3Xnw4f3a1jugHJY/?=
 =?us-ascii?Q?LxbUb9HBbyOgIITfhhp19MlGNVY1cYEmCDHCrblpCkJLd/MqjIiL4Sb8hNcu?=
 =?us-ascii?Q?VzU4Ivru7bLohOoqgVLtBxtHj2oYDo2zgQVWSiB8GeYuVxFAaX9p645QDmBj?=
 =?us-ascii?Q?ZPrC3k3ygWtaq8pshEGyiEq3Hljj/owkhmmCweQiKGLL320F761EByTgB1Br?=
 =?us-ascii?Q?NY81aojrJOIiwG9cyfp3xfUbWZBOB7JUhtet/P5Mf3aV7XeqMmHmHSDq/mKv?=
 =?us-ascii?Q?/n0adNJQjH4cjrENGkY2Ckkfmk+FKYgRUgQ/Pyqhh7kLssKpaCar2iG2iZFP?=
 =?us-ascii?Q?rtw/1plA5m+3Q75z2I2JuPvdau1Ns1Vt10GpP+0vf4ZK8VT1V2UENS64dh4a?=
 =?us-ascii?Q?Lvp1TS0aDh5Vy/M0z46k8DUW030a+VpUy0khGtUFMMtluGHnb3IyqNEUlXLq?=
 =?us-ascii?Q?JJFzjvDE6vdgO21sV5ivDYg1DSKiHvlDS+qNdBaTcujCKMqLh5sIEr7MEeYc?=
 =?us-ascii?Q?D1LIwdv2nZ0VSw13nxZ1WVXrw5ZAPAxinkB2AfEfLTri/ZW9qv+PF59dZ4P2?=
 =?us-ascii?Q?8gixDE4cqh/Ccom7bIPaXlKH3l+5oiZ7Q7q7IiuFZrM0KIJQ8n5TH064e298?=
 =?us-ascii?Q?WuauoUBx12SpLfyktNWWA/h08tMyeVntwULQcJpB72vRTARmR/dg3s9KE23U?=
 =?us-ascii?Q?iQO3hQY3XgYugcUtRDJO104/FOlduKEzbZFrm1mhbJaSFiDM7pbqSEJDfuwS?=
 =?us-ascii?Q?zPbW21bNNimieX5rA53QNTt/Kl7koABIbU7Vzr4Oz8IxWybK8Vd6HjQTv68d?=
 =?us-ascii?Q?drnGgJ0kMKGAJaNTNFCUDRDKADsqSKjIsl8o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:22:02.7121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062288a1-1c30-4664-a246-08dd921062a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
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

Add pldm version reporting through sysfs node

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 3d9e9fdc10b4..4a72c2bbd49e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -767,6 +767,7 @@ FW_VERSION_ATTR(vcn_fw_version, 0444, vcn.fw_version);
 FW_VERSION_ATTR(dmcu_fw_version, 0444, dm.dmcu_fw_version);
 FW_VERSION_ATTR(mes_fw_version, 0444, mes.sched_version & AMDGPU_MES_VERSION_MASK);
 FW_VERSION_ATTR(mes_kiq_fw_version, 0444, mes.kiq_version & AMDGPU_MES_VERSION_MASK);
+FW_VERSION_ATTR(pldm_fw_version, 0444, firmware.pldm_version);
 
 static struct attribute *fw_attrs[] = {
 	&dev_attr_vce_fw_version.attr, &dev_attr_uvd_fw_version.attr,
@@ -781,7 +782,7 @@ static struct attribute *fw_attrs[] = {
 	&dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
 	&dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
 	&dev_attr_mes_fw_version.attr, &dev_attr_mes_kiq_fw_version.attr,
-	NULL
+	&dev_attr_pldm_fw_version.attr, NULL
 };
 
 #define to_dev_attr(x) container_of(x, struct device_attribute, attr)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 06fe21e15ed6..9e89c3487be5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -602,6 +602,7 @@ struct amdgpu_firmware {
 
 	void *fw_buf_ptr;
 	uint64_t fw_buf_mc;
+	uint32_t pldm_version;
 };
 
 void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr);
-- 
2.46.0

