Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97E606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gnmEeFlD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A0B10E3FC;
	Tue, 27 Oct 2026 08:30:52 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4848010E3FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 08:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3IH1MCRxa5G3C/UijTgxq7jGKD7mblUxEyqNU6y45dfjfAw89NX4Q/zPnqyhC7fWAC7kI6V2Vu/vBFzuXY6jBESJas1yaYWyWhMScY0SyRVdUwhQhj3VfnmLL44kBwVcZrnwGt8unPyaaKfGrU3RRVnC5U6c2O0spKRCH2IW5Uem1xZu9nNZqEd6QARP0XbhJIn0UVwhKh20OV7u8eor6VUS9JtbyzxqduFHVq9xzatoWoXDTznd4v1aX79CheT+AHV1THZGPyxjvZBcpQSUzqsPw1/QDHfR3wqaFMACtDGNfUkmqA6eUHBdxOmraDu9VXcW5SLkd99x2DzHHRYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvX9g2ZT4qY/McsEBF2895MvC7pH1xBoaRRgs8J9DcA=;
 b=qBnrQRh1RGijr1WvXY5XPVoZKqiueM0kbikPsa9Yc5IXWLZKQTZsqsAN4p66iROg5NaBrQw3p5VkYndXwtAQgzBPVIpKxAWb4bFJKzwEUC7BTkV1vQwuryvJpNbK71YKmZFPo7uTgoU4V/hSfSRFeGyxXW6SDJTM8HwbcX6vkMiMMyeD2hQOwxCgNOd4KHGHskUIvX7Fnu6F/2nwveJVhQEYfksbl6u7h+2FMGW8ZMnOGu5mfKXoBVaV9uB93aNuKKsfwsK0kGOTgFzzNhCmk0txLaHPJnD2VNWDyb/zjGARtifyWfgLR4IW1Sepe3pSOMJ3sTGNtEOs8SSZZSRfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvX9g2ZT4qY/McsEBF2895MvC7pH1xBoaRRgs8J9DcA=;
 b=gnmEeFlDEteBjk3YGqtg8PK/NEimF+pxccQ8DMeNnJ5uMhSXkBG0NqBGJPy0TbLXMafT9ZccA3/SDL4dsULQz2bqnbYZ09plOBbGZqbcoj3lgEF1D57zwEZtI431Py3PQFwS8T04LQDyApVl/GrC3vShoRAo+F1+RKS3KoeZp2Y=
Received: from BN0PR08CA0007.namprd08.prod.outlook.com (2603:10b6:408:142::32)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:30:40 +0000
Received: from BL6PEPF0006C3DA.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::49) by BN0PR08CA0007.outlook.office365.com
 (2603:10b6:408:142::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 08:30:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DA.mail.protection.outlook.com (10.167.249.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 08:30:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 03:30:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 03:30:37 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/userq: pass the drm_exec ticket to
 amdgpu_vm_handle_moved()
Date: Tue, 27 Oct 2026 16:28:43 +0800
Message-ID: <20261027083027.2776591-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261027083027.2776591-1-Jesse.Zhang@amd.com>
References: <20261027083027.2776591-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DA:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: f1efd510-a43c-455e-1539-08df34049552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: 3gYXBEn3Q5otT/nrwe6BAgbRqmiFjrla1teXvK72V46WOyy2lSdDGFFjLl4RPdQAIMDLamziPM3/5S/82UYlNae/8+bkdaLoibZ3VCgUwhaNKKSkYE6DqK7fabzHIDoc7aTNg5ztTVUSzayMEsvn37w9YdWYIW2S2wbPZGTmEy5cfRKd2Uv9LIxYLu4/1yYQH9sJntIMryldFk5vMWAOONI2RUfav7MOqVzWXS3Vez6VkgUyMN0yGXRr06pceKW24ONIUMwJHWidqQiezmswWvS3SNX0CjTv7X8vgaI33znZe6MxtehY+XEoFb6xIec7JTU5LnmHI2ZPvrHS+skBZrrDXk91f4gKXAY4tOJEcf+G8ZuvWHL3/k03u+/+3WXX4MduzBI/uSRJcNFa3vSXu9MgzVB5AH7dQ+LeBB/RwUebz8e1fxe2Pbcx8CrXJnDmaepV+tu07g/fNFMYs1pt6h34i8CZhPImt5hKas3xSwKV24TYyh/xIBf/ZvmfWAV5vMn+kb28UiWDLqvYqHAPstyNcI7oAdZuZE5qOs4nwXj9Q+4GM0sSYv2FCL4hQAZXbIU7bHRWWsVLqSG8h50PvhnTlbSIMCN0apob4qo6mgYtu8KDpC6URvEGY8qRW+4hn7BnZx/UBa9Vg5GR6fX59McRKPGUtUbmJFW6p+EujkxWS52Og/wLOfZIdLli+eSQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SbVfitucDvIxoFqck5TLPNmpcbN0xjKk/BRoR5PiLJxxQyjYIEtFSznr7d8XatsJoVAyn+ZjOWTQtS6+U07lzX53UhwkESJKV+Y2cGV/XBIRZdw/RMmqne0RS+2Lhu+dyEL3bt2wel3kviMbWCae6Hs4TVxxLGBa29KLZfMfUea90KV99bd//sLdFbtR3aKjGjRIWJ/6EZd5n/SK6+QNR7/feUCE0Y83MdiL6RuldWiv1nla4vHT5YxdSq4DXY5tjZaNlZNKmB1eq6tkMaScxXK8qZ8Rn+r73jKe5MkHXk/zTrMhe2NCgZcOt8mG4nIZIXpV/bLEwbZusyiAdziGtwvejppQd4q0aWQcLN03wB0y5wxyaH7zWp7t0ypEpioFOd+CvzMJEfcgptSbb0Y/9jgvUVH/1AHu3UAGo4vlxBnRJGrmH2khxl/B/WdTtdNz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:30:39.9160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1efd510-a43c-455e-1539-08df34049552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The user queue restore locks the VM BOs and, since commit 67376cbe8853
("drm/amdgpu/userq: lock and validate wptr BOs before reading their GPU
offset on restore"), the WPTR BOs in its drm_exec context and validates
them. A WPTR BO which was evicted is moved back by that validation and is
then on the needs_update list. amdgpu_vm_handle_moved() is called without
a ticket, so it can't tell that the restore holds the BO itself: the
trylock fails and the BO's PTEs are cleared instead of updated. The queue
is mapped right after that and the MES faults on reading the WPTR.

On navi48, with an SDMA user queue whose BOs are evicted from GTT
(debugfs amdgpu_evict_gtt):

  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:8 vmid:8 pasid:9)
  amdgpu 0000:03:00.0:   in page starting at address 0x0000000100100000 from client 10
  amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: CPC (0x5)
  amdgpu 0000:03:00.0: MES(0) failed to respond to msg=REMOVE_QUEUE fence_wait_ret=0 status=0x0_0
  amdgpu 0000:03:00.0: GPU reset begin!. Source:  6

where 0x100100000 is the WPTR. Pass the ticket like the CS does.

Fixes: 67376cbe8853 ("drm/amdgpu/userq: lock and validate wptr BOs before reading their GPU offset on restore")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 15efe71594cd..43c83aa038bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1137,7 +1137,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		invalidated = false;
 	}
 
-	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
+	ret = amdgpu_vm_handle_moved(adev, vm, &exec.ticket);
 	if (ret)
 		goto unlock_all;
 
-- 
2.50.1

