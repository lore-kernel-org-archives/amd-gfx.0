Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B6FC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 13:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB13410ED1C;
	Tue,  7 Jul 2026 13:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJQ01t1X";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013049.outbound.protection.outlook.com
 [40.107.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E5710ED1C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 13:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTGp8/aOTwhSfhFrwmVTEbIA9sV/uNS7dat+QETTOW7K7azxPsxP3EYKeXoN+Gsuqiq2XSYLqtr7dweKvXHiEURyacejb0zi/j2vv3Xjvd49bbzY+tUOMJE2lJVyFtcbEEvMsO6ZFFBkvhsYOZVUdnOLxAv5e+GY7xQ/puuPs4iWQfVxdBvbO922ZoGugvKsKYQ0D5IBk0DHPJkxEflsJhg8mic48BAfo5geddAtHeDNKROiga+W06FTTzoq+5Nes//87RJZ/QXCWG56RDNvDkA0Bt3dXLKjkcpsCe1UoisMtT0Nco3dDOQ3BdTxiobwGjgriz8A/snQhB52BqVL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfQRqaTqRA8mTGiTWBQteCqRRyE+4BXpNGf/UpugrXY=;
 b=YoldIJ4hSzZpOFWh1Rdlu2u86AJZ6hHruaYGCfJA8k9limDGYJ71b5wNh95WkZkppi/i0KsKFJYEf1CH07cak8cN+9LZJN83NdC3tthrLmAuqnDxjbkRQCJuqxMSi9nYia6nQgyCXKcfbX/uRU+oL1zORl3KXoBaugtUmvN9fwXp3PbeP26Pk6bsWy08Ats+SdqL1+uvvaqsepa9SlZFjq0RSLC0eOQ8dgRAxj5BH1HgdVl7RjBfLbXuTh65M8gkoQQvDsC6NR/GdHKcYms3pachDn61SQZUkZYC0Rc7tnEG9QHwwipLtOTkin2QjlmULvRY7b8XZyA7Dslyd37wyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfQRqaTqRA8mTGiTWBQteCqRRyE+4BXpNGf/UpugrXY=;
 b=bJQ01t1XcbcQD60ecyKzxzKZYT0guGTnWZYHKXwKxQLnEwfxtGzqQByJsIIk4B+omhhd/Hj8AZSZ6NPc8kyNCgoDUgVgi9WFvKiNy7BUBm8uBjyBAKJSsE37yAf3jsKYTs4jLP/SRE4OtxuiiOaTUBGUzgH8JH1UwHC4dWtFM+c=
Received: from DM6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:333::34)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:58:28 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::67) by DM6PR03CA0101.outlook.office365.com
 (2603:10b6:5:333::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:58:27 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:58:24 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: move uniras IP version check to
 amdgpu_ras_init
Date: Tue, 7 Jul 2026 21:58:15 +0800
Message-ID: <20260707135815.1028182-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: e6904db6-2766-41a9-0ce2-08dedc2fd1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: frdT+elV0FfRywOsUorK+gBPLN+tGHmf6xaAHr/ILayhetWNWVIRny47V8t73xx+Xp5hYng/ww/7EE6JWIlAG3PhxtaJ9k1i2tC5I/SCnmLYr0w1F9cMnx4e+Lgb7PTWdkDWbkfTdX+XpALavqRelDZ8zyUt1LtkHY8y0uMOx5XKBdCizv/bvvxiqsIgeaavY6uMu4IuQpuPBHFNmyCIx8i6T5k2rp+IAdTDdXgmqoaIbs+V3g4CEt2zXZ0VZyRcywimDG79/aYFPUaYa+FRVmIKH6tFpW93HfpDx/m6aRETTqYhvo1EjeuwKnk7dQDyV2o7kQ6syvZTs0hvahIdfurGVlOgnIr5XNx9h5wzVDT95cnubxwnkz2E9/J9lwOrW67VblFSNrOcSGe2NOxVIB0NPRbHv/n+a658DW4TcyP4PCYOdBePzRRrvXCM5YAjPJgZyJwORg2v6dAXhuAwXwEPZqZRhAyen6IainI6LElCra9jxpfSL8LVKnbJX8kTeTNTU0FKRM8cez1A7oqqiIFXw6R4dgWvYUmgcV2cgFcnofrzSE3tXnvMww0svkn/NinfU9daXzF7P5y206SGr3PtaFU56Fz+VwfsTotV+Sb0NCA0iGg8DnOHT46XxCV13vCUcQHlqp7VZNrBeJneJeZ2qnpIXH1J2c5o6J/GWp3QbgaYJn8RNXOzPNKasFdL8gPv4Tw+6mwOjO8JwM/8KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2P7KtxmmSxO03RbsZd9WphIET4brwWkpJESDGH0CTqTdbYyN45A6zUrCVUGXV+bzaAUfrvmMQo28vs8ijeFoZ+LRkeLo4CDv+BGPQRs2k0guUXp1DuuUOFQHWNCvcOnJK9EaBamGLzTX/mEbIYU9Fi6U4CL4L1JsId+1pO8jmSeAMd0eICyzNj6YrwqZi1jpCMcaiMSDhnWlVHCw37JU+cjyDZLFEZOv0ZFP9xZ1YeUX6ebEKADVxOqfCFGccHUsrbZvt9mIlfpc44VDvQZgc06UV0km1m5wpeHniY1wFR0EXrzwKvdUwwPDoLv3hmRoo70bxUZoVilDtNJLGLP4JdKOUp991RsFgkyZptbyXfQKdIPVZkNBo+RlLd9QBzlW7mKWdf+OZVASzUOU8/gUNJ+un98+8k97MrFIMSQiSNeavyZG0ePo2c5FGLUJSQ+J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:58:27.3102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6904db6-2766-41a9-0ce2-08dedc2fd1c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808
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

Late uniras enable in amdgpu_ras_mgr_sw_init leads to xxx_err_count
sysfs node creation failure during NPS mode switching. Move the uniras
IP version check into amdgpu_ras_init to set uniras_enabled ahead
of sysfs node creation

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 11 +++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 10 +---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e300d951898d..8ade3da6f132 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3595,6 +3595,17 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		goto release_con;
 	}
 
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 6):
+		con->uniras_enabled = true;
+		break;
+	default:
+		con->uniras_enabled = false;
+		break;
+	}
+
 	con->update_channel_flag = false;
 	con->features = 0;
 	con->schema = 0;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index b8b831a91bc7..6224c4921a42 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -327,15 +327,7 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ras_mgr *ras_mgr;
 	int ret = 0;
 
-	/* Disabled by default */
-	con->uniras_enabled = false;
-
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
-	    adev->debug_enable_ras_aca)
-		con->uniras_enabled = true;
-	else
+	if (!con->uniras_enabled)
 		return 0;
 
 	ras_mgr = kzalloc(sizeof(*ras_mgr), GFP_KERNEL);
-- 
2.34.1

