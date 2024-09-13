Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A8FFA372E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 08:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB4A10ECD1;
	Fri, 13 Sep 2024 08:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lOF66gzq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE70A10ECD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 08:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OB4f2Dz2lY5RbfXZCiZ6C5cEd4WJNKi+s8fpkmxK2C3le0EVcfffY0hStujNJGoE2otv5SMxjc/8A+blJU5og5g4NqgweOybaNLR0Dz42nctjwTHpaDtpfaSFIrADGNifhx8+O8L9k5JXXWunKXpHqVzaAFmB9U9P+bYOs9jYPtdAyeasuez97mw8tSxUGQtrfypqP1fqAUcgt9KT1+hW7bqvmT4A278zKuhTdJQTiW1hkVwTxinnpDw76iVnmvuf+TR0rybzfuA/ao8c2rOpzUVnv0QfWvBlAGQl4C9MfehCpGHOA80EeW/odq9x25vg3YxGeEUbbbn7POd40Kj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDvdVkrh/fOeKkSxOWMa4OzVvxUYJ2+ZKi8NXX1P4bQ=;
 b=sI7QApWxBqhFQdWMlCxmLZ19DoLs6G8aBI8g2E2uJeI1I6iBVpPsBWqOqUdppgZsUKvcZrpZCfLV7W+CvjHxEq8ttDpa457YZS6c0b9AqWHA9ujMr2XXeJUa1+i2hgbibvgwzsANKfTWeKOu8HewawXJbfaml0U9qSSTEaNN7E79Vgb5lYnWymhSnMoYFyG3ltzOwU7mpnAbfU65+HDVeaZsMLlvAFT6gofJhDS/YDoIPFWjkvyPavtobSMqlcC5VoiuJ8g63/R16ltAGtrYrCvKc5o1mwIXCf6o/Egm5tbEcZG12J1I3bfucu8UMQ8z6P7fF0S3kBMDeUOkYNXXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDvdVkrh/fOeKkSxOWMa4OzVvxUYJ2+ZKi8NXX1P4bQ=;
 b=lOF66gzq82KVDZm/RsOwudq87Y8FZvfdjmNGRlXzA7T9bc7j85FtMRwJpa31h2yXZi9QbJgdYZsvrV0fl149cXw5KyjpYtWCLpDmgrJpHe55ukc/fkESwWJG2Ueo8D+ScjH+56GPKOTutMaK3ZyGjRyn/T8EGsPZYghH63052Is=
Received: from BN9PR03CA0384.namprd03.prod.outlook.com (2603:10b6:408:f7::29)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Fri, 13 Sep
 2024 08:32:51 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::cd) by BN9PR03CA0384.outlook.office365.com
 (2603:10b6:408:f7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 08:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Fri, 13 Sep 2024 08:32:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:32:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:32:50 -0500
Received: from fc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 03:32:49 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Lijo
 Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amdkfd:Add kfd function to config sq perfmon
Date: Fri, 13 Sep 2024 16:32:34 +0800
Message-ID: <20240913083234.54001-2-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913083234.54001-1-Feifei.Xu@amd.com>
References: <20240913083234.54001-1-Feifei.Xu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: dddb34e9-f1bf-45c2-3a12-08dcd3cea7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YyO0wARxjL/nvDkJL+LiySAO0imIJ/13+6W6G8ylpZu2FvTPmJohAphoO5UY?=
 =?us-ascii?Q?4IRM7IW5DRNkLYxPMAXO1xLa98Ihm1KcJ8NQJipcxikmRcD56bzo+/0GP4/B?=
 =?us-ascii?Q?rUAsyE+oUyo631XEuh4UloKpdSdqsdCceOaNyTHR9bH3Mq2LLTLVdKlDGQR1?=
 =?us-ascii?Q?DP8U+DZj4B5J0N4qB6Cc8olFJj6lw68ajwpd83uAbyPGX/9pjG/VePqewv14?=
 =?us-ascii?Q?9DoFlQouNIUIC2i6ZUAGlDfK3LY284Duswc8SvhjLsfcvwb70OhqjUf8SBFE?=
 =?us-ascii?Q?pUOT8z9q/GO025N6oymL1yGKA3615pDRKdYoq8vlz/FKsTG9I1JREe8RNOAj?=
 =?us-ascii?Q?ccW+Zk8sk32xpBbfaJDBwMw6n5zbnWIpedOcOTOl0djR4oQLTKuXgsspSgdy?=
 =?us-ascii?Q?9u8isN4JL8lQUyXrtxomGIZthqcVzWKcTCVxZL4jusG7X/ALUqBh0StUuOM3?=
 =?us-ascii?Q?X6gzoIEmg8Iyrr87jUi1oDtcLwXfN9lCVfFALLlxODi2TQU8kAYcQZrw7NOb?=
 =?us-ascii?Q?lxM6rHknfOskPqroYddT3poAYJSkomU/HG95OOyhkg6B5gUCeLGG5fR+qzTi?=
 =?us-ascii?Q?85vToyazgtnsrstKUF6FHNbnRB70BeXr+CbUjlJMsZMwVdACESQUgqCJretc?=
 =?us-ascii?Q?Hy8v5SP3X5exwcks2SmTYauPh0cYl/E2UhNszBdFhd1kedcMZOdWTnamHFWu?=
 =?us-ascii?Q?FNs+WMetOnO4f5S5Dp1tvZXNgxgEq5UxQnXjV3YHqCCBjbn4DD4pBLZMXwsU?=
 =?us-ascii?Q?op8w3jdJp7NfgDDSQGhmiAy/NQnKuDYLybt7BYBqyUCeqy7X0lAQt4OYpyWV?=
 =?us-ascii?Q?/rnJehDftlwP5TIH1TC3CNRDTGV9aIXv8OjoP9fVEGEuhotP8mWu7Mxi6z3B?=
 =?us-ascii?Q?/PDQ+FvdIKy2mNFDAwqE/5kFcdnutvnEzgLgJrFoDUYt333LRTlV5mK/z4cS?=
 =?us-ascii?Q?YBlZV5K9RCyuoyoEsGlJHkgKgv8yMgznksnPF8jce2XkdcymqznLKoLcHita?=
 =?us-ascii?Q?uegS1RDfI9TL1eScrYuPudIWEfN+T4G9Efd8zZEALZQnQteS/1eRnZWdlDTY?=
 =?us-ascii?Q?wIRcSH2xBk0On20YuVcjX6SXKwRBRM6ko3mx3DkLKAXHqrlRLsKRCRkWyojn?=
 =?us-ascii?Q?NHKMBL3KgHT8mHXIIFFgCUJcM0n33ztO1pS27WdMlg6MADW1ZlS/vVZMiU6l?=
 =?us-ascii?Q?CW4+9ZEBHgxm47kGoZCjhb99YP2Wc7/+qXGXVD9Ed5+IfQpYYiOCSGugBCPd?=
 =?us-ascii?Q?CrC/LDgH/R6BeCnOuGYA0qXP6IeNxGFUbP4a2zvUaJbJDDOSxMtL9a370WmE?=
 =?us-ascii?Q?5na3E3E/JW1Ir1RAjtrEN8705iHoRJWupOoHuSTg50jqFtGCLgynJpewFoAQ?=
 =?us-ascii?Q?OG1LIodbUFIs4AMVbGJKRHoGqUC9j+wqtaeCwDAj2cHv2K8FcqAQ6dhQmpPc?=
 =?us-ascii?Q?/maiDyxdZSE9JyxsYumNWyv+UdXeY+rs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 08:32:50.9906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dddb34e9-f1bf-45c2-3a12-08dcd3cea7bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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

Expose the interface for kfd to config sq perfmon.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4f08b153cb66..203e669fce5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -889,3 +889,18 @@ int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id)
 
 	return kgd2kfd_start_sched(adev->kfd.dev, node_id);
 }
+
+/* Config CGTT_SQ_CLK_CTRL */
+int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
+	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable)
+{
+	int r;
+
+	if (!adev->kfd.init_complete)
+		return 0;
+
+	 r = psp_config_sq_perfmon(&adev->psp, xcp_id, core_override_enable,
+					reg_override_enable, perfmon_override_enable);
+
+	 return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f9d119448442..7e0a22072536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -266,6 +266,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 				u32 inst);
 int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id);
 int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
+int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
+	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
+
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
-- 
2.34.1

