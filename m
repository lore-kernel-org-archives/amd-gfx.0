Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65190C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E2110EDA1;
	Thu, 17 Sep 2026 11:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LaJxsxFu";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442CB10EDA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vF2M3yAdbBHNFj3/wvGxEkv3tsId0l0BL33n018c9pvTFA10VEK7sKhEf0dvmWcPFYQq5D0vsWCAtVO+iTKsSnT+K92DsjBO9n4K0QYpV7+q8HeMhVn/IghkUz3AVot1hKqNt48MFPHh7roNuagC+XTY7jIv3bPwGtJv7YqxutCf0FEpm42KnJ4oli7s2l/1345cMro3+EkQgdcoNCS56wr3goIklhDX7gdjErR8BLjWZF0o+GeYX+C4XMTCn58tFmRSVLDVTNRMEGtANpDJdU2MIqGaSwSJmTE07TswWz3iIiEpm4fe8mfg9rRP9IJqsIIA+uazuwpEF+wC9R0YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sIjYfvLJPwHYulEw+OUtpT6cxjvuRVfci12F4dZT20=;
 b=NLDuGkgymZ/HM7sNeitgeEMAaU5VjYqblfTxP6phSyhJdNwXX7p6CSQRB0gPgW0gEN94SsPqmv+AAtALGT5OO7lyiQz8LdIqZgucFydNrCAbBKV2kFhsZ3+LWv4jJ3E2rpzB6w35ACZRAoNZfyJkjevvJwlZ2xqmFc62RR6OTDG982s9J5huOhJyp4YaPSnF8ablVq/qVjzcowzzUcVKoqueWSBTR+iSWJnRW6TP9kHDi+ovsO+H9bwU9BZeE+R1UbnuVrQH5JLNeA3/NVhqyAynD3zF3Gy8xG5a9IHnuFsem0Z0UQHgafdTjXbCmfy+V6xc1qTeU8qxgTviPu0kvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sIjYfvLJPwHYulEw+OUtpT6cxjvuRVfci12F4dZT20=;
 b=LaJxsxFupf/hpUbUwGkgIpvwCTRMMrX4JrZ5WEKZTEfDR/kUasB4J+UN9FGAyDHQXH2S+G4vlpHihgbikxB1L/oGWVBClts9ZlhKkbfhAeEIfdYPdVQ1hYSGHaDGMtW5QKyWbwpQxIGNoAZ2QIZYI1tohUB/tEzeXrXFfn5elNQ=
Received: from SJ0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:a03:39c::6)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 11:03:05 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6c) by SJ0PR03CA0331.outlook.office365.com
 (2603:10b6:a03:39c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:03:04 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:03:01 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amdgpu: free PT when VM critical section cannot
 resume
Date: Thu, 17 Sep 2026 19:01:54 +0800
Message-ID: <20260917110158.296198-10-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: d774b627-9f98-4dc5-f3b3-08df14ab3f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: GM2BKBbfPW6hcmBz4Fy/W5YjMtdtFxLez9Fk6PQ1M/8sh5MfzX4lgRN21E0B7cYWiCwKK7Bse/MFbrbGct4QmlPqctnxKHAF7hjUhWAjylr2n080JuSE0j+NuyW3jswwn7y+dXJ9t2MYPU1q4K/vooq1wvhO0JMrJ6G/28vw5kAFDhthZM4fhd2w5FmEgOzdd/hchPrSILNA44yOxE0RF1BS51hr6gsCpzSpsrEvZuErVtE0SCYpm5UQiWu85xHeY3Wc032LJDDKxy9BpnwxAAzKSdGEk82Fkdy56SeB8gCEkdvEh+Hs6ijPTOyPIDyGk8O0SGQuG7oEx8SdyQIaYqzbdt56NYHu4sL2oUhIT31OLw05RFdi0tkS4JOK5TlgMDmP1ft0ncmmNhNgDii5EXyQTR6QtjOwmonycGkns1sCNQVK+Lk0nzh0hV7lwPe93jiI5zpYGNowdAZEAnBdVuAmumNhrk0hlduAOrGFF4rmzZB8Ta8vByNXuE5jGI7AaNRsAntxzW/sZ2lDnT77Sa2QDiMoRM1OtLYG5qMdaIrsY5Kzf+/BuWRrRfWMUeZAYYdUwjGo3/CbyxkS6jbfKtBg1KLwuccZ4LNk+GpPqK3IRF4y/GRhSHFvGgf5fxYffqNK/mGlx2p6D7QMFQXakpt41uWfKS32uaXpuILKY02MU+91SlRTSvMq/KjKVrOkOQkZT/0FDFZ7wLIKb6ds7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0XVbebMe2WBJeUFpAUQkWomRg8tuUx3OlpE8D/8WW2MQo8XdOFL77mozC5/dKJ8ZpHhhANAFaZl1NuvM14t8LCUUH2KI4khYWu4Cihmz5ER+FB1Wt6bKBnf0yJG5HiW4KQLhFYmTz/gIDB84+9STcfT1/x3BiGL9bdxelL6a3lragkjWnTTFhKhOinM1fEoNp5gAi/nJFl/UqAMggFr6A9EZlwfl1nBTym/xfhv9fswWOoCHRtQovAQr1+HaZuex+3tYaN5V6tvxB58UvpvPOEBcw0PMEgEsnQ5u1nJDDzwzWgm/R7nn3M6neZUSV1OhsB/KYQnACEyEQvN/9V4BC/0jq4PYFVYUEiKr7rwEkwt9+2xl8oEnQqdewm7aigmIN2njok0xY03j83pLLI+zfiJv4q0VZ33gUE5tiMep6Ml1DABq4OR+F7aLI/bTy4pI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:03:04.4740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d774b627-9f98-4dc5-f3b3-08df14ab3f64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
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

From: Yu Huang <Yu.Huang@amd.com>

amdgpu_vm_pt_alloc() drops the VM critical section while
allocating a page table. If allocation succeeds but re-entering the
critical section finds that the VM is evicting, the new page-table BO
is returned without being released.

Temporarily leave the failed critical section, release the
unpublished BO and re-enter it so that the caller still owns the
critical section on return and can run the normal cleanup path.

Fixes: 39061e38483a ("drm/amdgpu: rework eviction lock handling into critical section v2")
Signed-off-by: Yu Huang <Yu.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 5385f662d0ac..ec7bdec1a3a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -504,13 +504,17 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	r2 = amdgpu_vm_begin_critical(p);
 	if (r)
 		return r;
-	if (r2)
+	pt_bo = &pt->bo;
+	if (r2) {
+		amdgpu_vm_end_critical(p);
+		amdgpu_bo_unref(&pt_bo);
+		(void)amdgpu_vm_begin_critical(p);
 		return r2;
+	}
 
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
-	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
 	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt);
-- 
2.53.0

