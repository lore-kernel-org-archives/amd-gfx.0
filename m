Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B86C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E614310EA57;
	Mon, 31 Aug 2026 18:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yPXI/eos";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA2E410EA45
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSjiT3P1VzoxmzrmZ3LtR1NmqjuzgLntrfK23bFcOm8ldrqQKF7W6idneQmYsbvmBWBU78Y/oyc8dq63rKBGA0PCNGMuSirLrvbQSi0CTGhkA6R8luBUx7LZp7ik7UJAtUmib5qGbIwC4xdgS4yjR8mTqzsoTbN7ygLVTxtMr0fBL9ko4Vb9Gmway4yMIH/7cXWYmQt0ecw4Q0EapdYSm6ba7S6TUV3tC2AZCFceBJSHSSFm17KMm2GAFgJvKHWZwhDrHQILfYqEdNf70hg9Gsi1FakVVBEXuu72Qvv+YQ7xNmzWXEsWvtTmsXepwzC2EfRFdVArSLMqnZ5oN4nG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfBE6e2oA4TN8+Tc33ikk/nbjHJXDQLDX5pNSDkNlbY=;
 b=ZBJ9YOEHQ9YBoI3XPm4+t2BqRCitaqoBJTbUkQ88yliaRcnkSI/7lbG8vmFcR700G2DT7rDXYhmnLw85ymWCLC/RsOWqiWVQCJtZkm6UoFnkXnDc5CddQ3X8JRb7aXgQdd4mp/LIji5fV77PHbrlaQfuiyuRKNc29JFr1uFtMPj1Ggs4J4NGQe6ZxYWJ5oud2KLCWYNnwriSyK7inBvTS+EsMfNZ/x4D7G68CuS8sFoDOI3zZu1/RpnGhac2SjAeCbXYo5IthhQAkQuVhT/AJfpynJEOkhWIW2asBGFgTxH223g1hQz8/6jHyvUWWiuT+d37Tswzp0jm/Zp6pKuZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfBE6e2oA4TN8+Tc33ikk/nbjHJXDQLDX5pNSDkNlbY=;
 b=yPXI/eos3rLFiezYyXjQiI0kFQoYN0lvjksRnWp9V2XhxeZe2F74jvvNqQ2dHG9mTssB1YhRUMbsRcNKP6jhCoeFZYvrxDeG6iXIp40Y06FmTVQQ3c8+PAx8NnfhuOEcOV5cniCL8tidmk4afH0DoTii6TbZF/5UzSJq4p3G7Qw=
Received: from BN1PR14CA0030.namprd14.prod.outlook.com (2603:10b6:408:e3::35)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 18:28:29 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::54) by BN1PR14CA0030.outlook.office365.com
 (2603:10b6:408:e3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/95] drm/amdgpu: Set UALink station config to PSP
Date: Mon, 31 Aug 2026 14:26:34 -0400
Message-ID: <20260831182754.1089811-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: fc84b0c5-5af1-48f7-1aff-08df078da771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hhdmLIbQY9hZzXvpC8ytJw10RTI42L0GiNCvPe5Lb0auZbvptesHYZI8sqBLwvBX+OZX2KAVXT3vYiPRc0LV4OoNkUmLakBRCKKaKs2SHy8d+dg1ZqMtLL3BEgiHgW8Q8fyPQC6MCmMCV12cb3n2/cmcoXZS0SFoBwajiMPU9YnWyvmChhymPeU7iHdXPE/h7sf/Ccv0dHnJgZbPhogmo/JB+Y9rELs6LhZb4I48AVgcudvHi+QvmCEMZasoFt3U1m9MQHfzrvPXGdAsBYJJsyJWAdFIooMQD+wP259qxv0XBDX7i80uINmHyAroSfydid1RiITjD10gm50Zb6PhG+jySpEKq2JXmAAGg10sepFE0ML0TetDGSH4M9Pv6+8C8tbRY2DaZ4k8m7BOF+IhK3vrv6kbR773hiTD8u8RIGaRkt2khqa21a/jAZGEwSBmb0Ug/8rRWePRxmgvo5GDx5fLKOtRNdmz/FrFXyu8n8giOhommT2L+EfOpmAcNDHVNlHnylGYwrbpGcdNuNMFGWuC6RDqKdTttrEzImkAUZA9CHYbM1mQQXT1+TLKaHdBuOFQzlgeSOYgrlpJpqi8bOU5VwlFnjQu9L7KnoI2tyAXBxbqKl5qnFPMP65lzs+PA7R9E5b8YpFHM4E0TcIXHfPxQPvAg6qS1XK429Ayr0iGZ6x/09Ds7jgIIvC5Rh2C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KbGwcy8qCOtzf2KPYnKNV95T4mYgF4W4aJyBDPHHfaY1wWsmGWi7AfgUMSB+w8zvrqWBzczynOeQ/lZXEpTiyZrPdy7OmB+TqKEgakpCq4OK2FEPvQyFy6yvI606s6E6kMnKz5JPVLSLrk0lyOroFH2+OEaaPeuiHcnsjG5e03qNqCQDi4H1AywjkxVaguQYQMrfq6J7I0qgV4SdsuovvU2GOcN1LGWZsOuz//XHbeQT3vfSIwMxoGks6EkLTHf6sh5C9bFk4CK0HfTpBvR6bhGMa5669ZmHkRKgf+/7uFjZm8o3UK8YolRtd85S3V1dqOjLFKkSdGchXZ9IpqqCWoTtOAUATwUvt5R0bNq4FQWerVlhp87+HUa0vfIDOHdj2MLnktPDDyVN15fohwsUGz6jrL02XoSTDBvU+MQjdzg1hc3eC4MKGy7RnCUo8rRp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:29.0456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc84b0c5-5af1-48f7-1aff-08df078da771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813
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

From: Felix Kuehling <felix.kuehling@amd.com>

Set the UALink station configuration to PSP in the commit store
callback.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 657323427f0ee..ce73657a363f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -856,15 +856,19 @@ static ssize_t ualink_station_config_commit_store(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(info->kobj.parent);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int r;
 
 	/* DF reconfiguration does not interact with accelerator state */
 
 	if (!sysfs_streq(buf, "true"))
 		return -EINVAL;
 
-	/* TODO: Send configuration to ASP */
-	(void)adev;
-	(void)stations;
+	r = psp_ual_set_station_config(&adev->psp, adev->ualink.psp_if_ver, stations);
+	if (r)
+		return r;
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info);
+	if (r)
+		return r;
 
 	return count;
 }
-- 
2.55.0

