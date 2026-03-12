Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3751C105A591
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 13:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60BA10E0EE;
	Thu, 12 Mar 2026 13:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NE5WpfoP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F33D10E0EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 13:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3ncd8JwD+U3+UXxhEYlVR8TkDck/agc+mvL+fTXa6J0vMn+l8zoTUofIYdij6RSWNZRu5rINUQf2+g8uABjVTO++D703diYSdd9sDmWRImEKk7uAIn+oS3c6L73NVZBEHhgQnoNlbIZdKG20nKfpAJzMBag2daONheA+MxaKBAWvE7hpWKUQRyY1zOyDZgde7Ht22QNvx3dRccwfoB6ueue5TF3k3dcgZiMyl3VrMALzJr4brrVF//Oz1C1qp/Thu/M7bYCf5VdKEPVgwGmX8O5hrVRcCc3o2lkeqXkxevWanu7Qhju4Lq8vdfpHPFU8SexYW+1p9uZ5YK/0NqJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evrm9tpB7UlzIJ1teBB/31fAPtX7uhUZavNJ3ZGWA+U=;
 b=KL42gvCaCmU0UlS+iPR0+bqRfsaa7eyEveBefG4jj3ojI0KoOGvSYfEPU4ZKjl50xYXxHliw9GMwoUMNPJu0LVmsp7OonKQ8vA740pqILAjLN5g1xrzbIKaZxBf3KbgUMXoDaiFrap06rl+sVa8zqdcEpBNJTF3kd/FWw1btagfsxDK1qPGsk+MyCM45BS0san0O2KZ9UU3NHNvbSV/5rIt1BKZ8z/PexV6Y/GVUsAJkCanGsCbtBFCHQQRk9f2m4EAL4Nwj+m65YBhBhYwz6ckt5HYVJexAo9bSRnaRld0uKalfNVaDyCLw0QVtKMXZ7Q5khmHI6xnkf4yKNgnemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evrm9tpB7UlzIJ1teBB/31fAPtX7uhUZavNJ3ZGWA+U=;
 b=NE5WpfoPcNTM5Eo5lz/vIYKKc9ao2Z9fjmhzq08gvd5ETyePA+wHdoWHYriyeiKQgTLCR3pu8rShayFPCL16JQA3S40JqY24Zy8wEr5Re2wQfROzdQ681IU3FFdfhmD6vxoK2IXtccvZz+Sz+ChdYxwdXywhn2py06In87MzoxQ=
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 13:16:54 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::6b) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 13:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 13:16:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 12 Mar 2026 08:16:51 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix error handling in amdgpu_vmid_alloc_reserved()
Date: Thu, 12 Mar 2026 18:46:25 +0530
Message-ID: <20260312131625.1839044-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: b551da99-5bc7-4c42-341e-08de8039a0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Egb4XgLMmRaAgddOkMzjZcHJfJ6PMWskwUaAT2Pmwnq8tSK7CYD+VoZ76k5Db7EN3x7XOo6WrtXeDEroFaXwE6WIp/NO1CBPV9Rwsz4QGHmxtozFbIqBoeAAMooZmAactajHdCJJ86dV5k9fpWaKHx+UN20y5W1VllLlHOeurfeR3FqpU9PM5JlJP9zFaFkaydhY1TH/UhDfe3RCbZT0HiPE6QGkIKFTzOXw2dBjg7W36MeVzABTNHae2Uq2NTKeCW+VoIxhEFJBiwPAglrB+gkS7O9axXa5l47yCEk7KgpEfgt78l7OQDE/uqalolYd8mOIZ1KY+nQMNkVB6X42pH3feKVdlOB+zCO+IULcNtXNFgCMwURyQJf/hjbFamR5oQHnIAtSCJpOy2SWNCL6IPa8itG6fLlmb3wyUWKR08le1+Rlp5nTZmDMSYHjPNTs+LUByNYXctUnrd1O8GgGfg/l5TitIoRVO4QlWf/KKkTn/2p/WLnWU0VtzjJjZr5tedIudpA/KPLYpH3vFSZi/oL6YJnI8B07SqiFk7DsUGsnbpMQOpUe/RPrOWYHNRp6OmHDa7cvhAl2xv31TdHWzT6WYBiD0ObuHnZsWic6CueP+seN90s9KpySsk/697b+HV6xgS+0MI22pagRCR6dKlk00DyR5XSDYapKyH4Lhttz/i0A8PgcvGcvWIV466wzviuwN//SSV46Nj87EbrFm35QPk418cuz/SBcvzYP1UGuV3te/fF4dmp1ABkHPATap6WlRzSDm0edK4aqEmz2/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Koja5n0ZHOAVmcJDd/534BHO9TkO+tV/ZDjTX3BbgYKH5RckCxVMADNXOX5frZc6dcvyOhN7tN4PqhFeV22p6CaTgQEMCqlzUmCxiucNYsvxUQo9OsPVagM9PIFhGShnWe+eESSrm7jK/dYvBgOtvZR5PkCB+iXZOsTxuLpff6PrNbwjpuYCSvjVvSZ3vHVDVu+TxnUhivt3PwWNys3LEssdPyHrBbjFRkkKMO3ISOWrgpZeb43eunICI3ikjksTVlqJAcokg6WNNYUNCT8g2lYpHwVjAQOi2YiKW9LenvhvsN0adPIkwJzFcyD4Hu0btdmbKdbWpKY0r4/sVAQPRWvWqam7Mn8V7p82GT9+CybRCA/46VdGJhuzqPQzXqgdYvMtJqJgALuRQGZlNHA2RPWmQTKa8kr/yLmRXhWY21EXIGDwZ5fB4jWSoRvkENO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 13:16:53.3046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b551da99-5bc7-4c42-341e-08de8039a0ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

amdgpu_vmid_alloc_reserved() returns success when the VM already has a
reserved VMID, but returns -ENOENT when the manager already has one
reserved.

Both cases indicate that a reserved VMID already exists and the
reservation cannot proceed.

Return -ENOENT in both cases for consistent behavior and to fix the
Smatch about a missing error code.

drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c:471 amdgpu_vmid_alloc_reserved() warn: missing error code 'r'

Fixes: 90e09ea4cfd4 ("drm/amdgpu: revert "rework reserved VMID handling" v2")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9cab36322c16..d0dedac630b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -467,8 +467,10 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r = 0;
 
 	mutex_lock(&id_mgr->lock);
-	if (vm->reserved_vmid[vmhub])
+	if (vm->reserved_vmid[vmhub]) {
+		r = -ENOENT;
 		goto unlock;
+	}
 	if (id_mgr->reserved_vmid) {
 		r = -ENOENT;
 		goto unlock;
-- 
2.34.1

