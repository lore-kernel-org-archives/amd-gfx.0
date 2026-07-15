Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B11AC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 07:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028EA10EF04;
	Wed, 15 Jul 2026 07:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D+dTcitx";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0121010E13A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 07:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDzZpLhP2OgOM4JbXNQqDGVPoaE9nCJ8CIPKawciRGrlqn2f4q407jnFfrCavrZNHdy7UpZVDlSnPV5gF5S49zAWbc7ZsM4y4+kfPHtCU4e/nzJRRVriG7qyQD7Ctfp6eNwJj4FWieYz9mrJ4QnYIewdjGDYR9YYngiL0Jfd7bozcuBZYvHvQlqQ2tUsyuTYPZm/U92C2YnM+tPNdswMLbuL5ZxCe2oy3JViOfeYuI8TSxCJDB3u1gvzO36XCr375UqEmFBUB2tqxH3vJagI5I3rB2zt2FExWykJ0Z08dQk3a7sAFhRK61i3O1YEBgD2Kh4gODSudU7QXdUdNMjRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pdgr6lEvbzAjIkBhIRT2VbSwYzb1cBD6uUjOZGmfBM=;
 b=fYziHpdesCeZXOB20C9cjSKNb5ms2LOadvW+OQYcXl5rKRlVZXnHRdnvTuK/1OEkGcWRHVvXB5M7e36arSIdsvO1sCi0tE3Rck2Pe8kNiyPh9hH7aH29VKYlk7Q7O/xQRWfIK5XTyAXaqQzLGuFD2GcgII+NXNpxmLX9Vf243pVLJRytybuZjfDnK+gJK3FxfRyG76ndV9afVVZf4jLt0evri8yHjRcZyOPOS3VLMrDgKYESXKP1zNBx+hjaDK91O8FaBvLPmpKZk9GnsNIyP1JDdhEbKFyMmfeiKhHy3DnXppXYLj9rhQd5oOyh1qIvUshL4is2a7EedAZJrgSCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pdgr6lEvbzAjIkBhIRT2VbSwYzb1cBD6uUjOZGmfBM=;
 b=D+dTcitxra0Y/S0Jnb5sOA6RdfZitAH9rQCEzcDZ/wugupFLcJx2V8dAV5g/0azqZNm4jnMtUVCAydUQ1guBB1s/oqBwNOER/DF0y8r5HdczKOyd2LaV3oaZs49Z9i28o6xS+y1D75vtwyBJtyzX/WMGr4fULl4NwvruL1h8lq0=
Received: from SJ0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:2c0::16)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 07:45:26 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::92) by SJ0PR13CA0011.outlook.office365.com
 (2603:10b6:a03:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 07:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 07:45:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:45:25 -0500
Received: from dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 02:45:24 -0500
From: Bob Zhou <bobzhou2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Bob Zhou <bobzhou2@amd.com>
Subject: [PATCH] drm/amdgpu: skip clearing empty freed VM list on GEM close
Date: Wed, 15 Jul 2026 15:45:23 +0800
Message-ID: <20260715074523.988105-1-bobzhou2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f59888-acf7-45dd-1189-08dee24508d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: X48ySHVqeCxfZ5NRyPkqysRn+sdImTLkNRM8SY820hzEvYVESo8Iav8UI+2n/LvoDUytpH65Nb+l7LdyOov3WbN6OH/Xj+4t5E1IxwUW05A4I7ypSbAN/v2JFrKtzthZmYBbad6mhNyqr8hd2hK6m8w8LjF37R2KEWarIt66fiDcqvocwpwXRQVMRUuBcycfemyXX2//CAkg5VC9L7Fu0pmMTL3YxpM/oDdKGaxdN184YVWzNuTFNZtDI81GtR52Y/RucxNjrXeVz20kjJZGi3CUeVy4vn3+8V6LrNJrg06K2RhDGTo/08P0in2BgORW7ZEmfP2/LmK5bacH220yocdTOWIpBqmPf2e89N5iryeKf89RlmJoCScHpedHxDJadn079A1MZCLmGhU5VZroeYxra7wuxonKDPlNbK9b/I1fqP9n4DSLCS2HAZz+AgJDbswMgEUA1NsFsVIxvOmO37WwFk0gBpZ5R339ALeXEYyIGkPQQYcxHuiRLbkbkrcgdRXb4ilOhPbJC80lnAX06t7n2WTY5MOunh7wnEoKqI90jO7flhpl0A80oA+tBbMQfq2LUwv0Qnd6OOpHMbYgXxB7AMj0OWX8L9CWNQm/8mBw82d3KqUSm94GTJjWmTYhXGlKR1LPxRWN7HKUzLbWYCtw+ortS5y/9EOlfWgKeIAOfYjrc4Q/LT6Jtw4AA34+RDRcxr5VxaeAMueRnj9Emg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hjzkkvg3AgVGvNKB8vQ0BttLsIKIrvzHM5i0P8BD8HbHtZ83NsiG3ggXWe6aAqEpBWldv8YnQbTHriC1JIZsTBgWG6egTiPiOJd9BMv+knTyAR5L3eOs4VrVgSAQy5kTgep38E5FS2KomcDVTm5xZhRB0oOpda/6ZcSjmnlh8dFFBe9k531WE7QYU36Ti8w5I/HPeqqKCi3EZJn25DpK1uU13lPC3srleakJzvH35tIu/YNEg0DY7O+rSMMUrpyImTGMNmJDC6s1VWZLAFVrDErFj60hAexbtXCx+tzxaWrX8BrPuNnpUqIx66HjfXeo3G2ACtjNOl5PKjws3/fVajK6D+bvCzy1VfzA79S/M5B92O4JAzL7TvccoCFdg1VdeQ2OQWRm0LexThUn4EwM+au7fwrgxM1FDCSHRz3Mp32SSiow8RXQc0EYpclT1OwZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:45:26.0447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f59888-acf7-45dd-1189-08dee24508d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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

amdgpu_gem_object_close() calls amdgpu_vm_clear_freed() after deleting a BO VA. If vm->freed is empty, that call is a no-op but still allocates sync state and walks reservation fences before returning.

Check vm->freed first to avoid the overhead on the GEM close hot path. This does not change behavior because the empty-list path leaves the fence unset and returns success.

Signed-off-by: Bob Zhou <bobzhou2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6a0699746fbcd..72811f6963a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -348,6 +348,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	amdgpu_vm_bo_update_shared(bo);
 	if (!amdgpu_vm_ready(vm))
 		goto out_unlock;
+	if (list_empty(&vm->freed))
+		goto out_unlock;
 
 	r = amdgpu_vm_clear_freed(adev, vm, &fence);
 	if (unlikely(r < 0) && !drm_dev_is_unplugged(adev_to_drm(adev)))
-- 
2.34.1

