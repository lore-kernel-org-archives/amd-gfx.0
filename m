Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12E3C5DF85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAD410F04E;
	Thu, 20 Aug 2026 14:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VeoqbE8k";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381E110F04E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 14:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBFBd5gkMWVFOHGa7J8xFiJjebFN9+mFvaXf7OOwaPMZs0GoVGBBcQSvM9J9TGrz5onsuloblYYL2TT/U3WL3YPWzhFYlZHRMhArOlCg7PrdMhJn7wWOLN2Oi8qxoUwe/AY5gCDnPJKCtnygblpPCNhnNRaw8SwKmALjF59yh1MrnsL/Thw7THXgmBUYIDcUvXctN6jHf+qhp5Cg5nEaYLQ+yJMIi4Ij+UiJVTSxEaRPKMd482RZ2AtLfz/pn0kAOC/SNDTGINOlDPIe8sl5RIItamkrFSILPGRNbiUmVqDcIE4VEdCX0Rqnh/2TIxaYffBuHXW1aSWW8mlskzIyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l+1Ae8/eMWQeGm8bL0SmvOVIGGNrdl/ykssd9xyqOQ=;
 b=dV02/nD1bAJRrHOea/HYIWhQVCkK1E8itNIRRE/S3P7c6fGMi8Ht6YhnyhSxGMa85KkPXJlUFZrFOWS92urY59a6c7uWRfggaZoER7qw4Fnyy7oyNMs8MqWDDwyGvGULld0TCzWc1pfg8stqkvu/tDFG4NENx2VN0xrK2/CLC95clcNhAR6oz6CsAtICOWp/bYNGqco4TtNB7H40EDwWDc+AZ8/rdCuQfu2i18b0psgWs9j4TdaF2Puk6JND8hzmXEXEz2Zgz6hWRmXnwTNt9iOk4eB+vojdjWsVS9H6oTcFmbkLNn6Nz1HAjmqckTPbpRiiMZ8TebwBX71c5w4N9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l+1Ae8/eMWQeGm8bL0SmvOVIGGNrdl/ykssd9xyqOQ=;
 b=VeoqbE8kf7Lf0PfNdcC72CYJTvSprDeuFwLG2H4scEVJJA3l0kw6LBC4U5aGVWHrke/NiaarkoID+MRkGu4ITdhgYKBCNTBZyzJ/Mm/KLClupihtxvjsxoev6irGie6MbC17VYBhDmUGdwyCj2bTPNtUsvSlrRI7rwHLglzOE7U=
Received: from MN2PR22CA0015.namprd22.prod.outlook.com (2603:10b6:208:238::20)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 20 Aug
 2026 14:05:22 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::42) by MN2PR22CA0015.outlook.office365.com
 (2603:10b6:208:238::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 14:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 14:05:21 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 09:05:19 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 3/3] drm/amd/ras: keep reporting the socket id in the RAS
 feature mask
Date: Thu, 20 Aug 2026 22:04:54 +0800
Message-ID: <20260820140454.1340848-3-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820140454.1340848-1-xiang.liu@amd.com>
References: <20260820140454.1340848-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abccb20-14bc-4ecd-3f35-08defec41304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DunX1QGuUi6HNhOyhOULIl7/RZuy0njT6gswZ/8GxFxRHTBWnAfvHcqSmSX/rSCyfc9A8dsmYc+kSKqKPRYoLM6waO6jbzlj3LhaBYvpXKaxe2o3HTJ6PzUfYNvpmCqdnQTuSbZfQHafwS3hV9Unudq0Dn0sXjBxj8awKjsdCDqOWUsS3E0dejs/HecMyHM7FtvxbNEEenc5PItQKMNTLCkQjy1teeA++tHcOjCPnKpBYt+zOM5h1eoXA/TUslVxUPD5iR2p1GputRnE5shDBxfn2s17t1xuGSIXE9e2IFK+SfxW8rCnAYycYhSfKgAodU4KMG3hpIAUY5gipxOkgrH03A2k8Z1lkXwSGoL/7mk2m1vrcZBOXW+9J2p/8o0D8ve3NwzFGIw0FspSAEEVOYGNlflItqz3brBr2bdhrVJUJMDwbMrrRb7rRZxI4RZKYTHloS6cFaJhT4xWcsieWksQki3PcCEl5FH5/SuFg7l9xbaHgZbxVJTv0QUjy9gHWsHEhhxOdXArovJR777I4mUx2nsixDqilzsbpYuMAnlfCNxPeF+LkLCbAyPgwqh+9R1TZQ5P54+ni9d5+4M6+VUw5dJxDPcWqd/C3E1k+y3KZ0NOrOOJlilYuC6GFVeWxHS960NiSQVBXPoB/TgxdYlzn4IOkAeSDmLqJUv6jU5pi1bZsisYELSOu+eCVnPtrM2YtGaHFXJSpbalXqLySg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dgD5h8YNXYUtO+O2jZ8LTfAvdpKDqkebVAcH1PNv02F5EEZV2oVpcXdw+0BpzYZJ/cgGyKzZQi8+yTMcFw4Bzu4/ohMfdh2z0UKI4GENBYdO1tonMjSKdrTXRuGqydnK8Z9hlSIZSIb5gFu8H5B+IewEO7p+MyKqAuRktFpXW3bg2OLhrmOKq5eSeEAplPHnreug9QXf8NNrEPTdo808DYC8rEa5Ng3A1yiLSaggJxP5Nt8mFS2ijwbIsEthVDX6QRsGJh5YRqZw8pI7QsZ8DHP/Ol4l53oeJTq81mDIQLP9qjVd6ekpIqeOkqWQHVInH+MfdwN4lbR47nLksch6u+s+gyCP3PB48w5qBRzG4+mHU0MQCk+LChXgHYUZRDpKHbvIzaEQaED0D/CgXSP8Chw8nFdb4MGHHtlUD5qNAV+4bOUefJuI5h6svjJ+5ygQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:05:21.8847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abccb20-14bc-4ecd-3f35-08defec41304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
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

The socket id of a device is exported through the ras "features" sysfs
node, where con->features carries it in bits[31:29].

Reporting the RAS capability mask there instead changes that layout: it
spends bits[55:0] on block bits and so carries the socket id in
bits[62:60]. Tools that decode bits[31:29] then read block capability
bits, which are identical on every device of a hive.

XGMI error injection depends on this. The tool resolves a WAFL sub block
to its destination socket, looks up the device carrying that socket id
and injects there. Once every device claims the same socket id the
lookup silently falls back to the first device and to instance mask 0,
so the injection lands on the wrong device and the RAS TA rejects it
with RAS_TA_STATUS__ERROR_PCS_STATE_HANG.

Only report the capability mask on parts whose tools decode the wider
layout, and keep reporting con->features on the others.

Fixes: 6ae383bdf282 ("drm/amdgpu: Support obtaining ras capabilities")
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d168e5d54d87..0dec6da3f1d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1845,10 +1845,19 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 {
 	struct amdgpu_ras *con =
 		container_of(attr, struct amdgpu_ras, features_attr);
+	struct amdgpu_device *adev = con->adev;
 	u64 ras_features;
 
-	ras_features = amdgpu_uniras_enabled(con->adev) ?
-		amdgpu_uniras_get_ras_caps(con->adev) : con->features;
+	/* The wide capability mask needs bits[31:29] for block bits and so
+	 * reports the socket id in bits[62:60] instead. Only newer parts may
+	 * use it: on older ones tools still decode bits[31:29], and without a
+	 * socket id there they cannot tell the devices of a hive apart.
+	 */
+	if (amdgpu_uniras_enabled(adev) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 1, 0))
+		ras_features = amdgpu_uniras_get_ras_caps(adev);
+	else
+		ras_features = con->features;
 
 	return sysfs_emit(buf, "feature mask: 0x%llx\n", ras_features);
 }
-- 
2.34.1

