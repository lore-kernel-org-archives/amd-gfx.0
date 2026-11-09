Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018A606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wMjAMcYm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6907310E591;
	Mon,  9 Nov 2026 06:21:45 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8206810E591
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 06:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGYkqM2ICRzvICPV8LP8OdTggcbGTD/kGYTgHt7qRf5c1MJ1uPP4KS+NzMF9mBOcfaX5XJvf3WO5jFEGQD8n6+jrCQ17MkIvZqmCaik+HiGAyhVVvtcrrXgr6JOt1a2sAR9QHkyr6WcASM9DV83KiWeacLdeGmBmDDMNyB/jO+5v+U9cExnuklNoTFjzKr5SfDoSF6umowXv7LkIxc8Xno5IZvUKVJRGcQJwp02X5LIU1n2YI5klO+m4KHwWDxXw0ryzJrgXQcTsdzC99FlOqum6i8c5ZIph+Kr0JqNZhMgOE3TjRVOftzySUX63GWDygw62s9SpK32WE27aWvpP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evejhU0oaXNGZ+qqg4zM1aF7nVqS8SQlcuwYH4mNQoY=;
 b=lfMVbVcoWDqTKoxUx9ZIcWtKWCUv9fRQgKjCq+t4wSePmnbf//qwoZ+JKJFzFlKXJVTbTd8pc08WUo8cMRxFvVvf0pNrbfv9Qa+KO/ky+P4iwGc9FMm0I56YY77sbaQIXss0dXZ4NWyCIuTaN6Bi+3/ysjVHvgD0pMb6QHb8kM/92N8BfFtfxasMv4UpFBUK10EZiXkAdrHKx5Lbv7bbUzV4rAtTb0GMNfP/qMkMLkNPjpzXUhD+OqXvubtlf6x43xdObS43/CMO9oEzUs5WcVE583iHYoh579SgwCzfkPpBS+Sh0nKQ02jvoXpGBZzhEkLnErB315fjCx4LBaL7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evejhU0oaXNGZ+qqg4zM1aF7nVqS8SQlcuwYH4mNQoY=;
 b=wMjAMcYmafgwZ/wCPv0hU1tOGab3GrBXsmFOzF9uo3hgOsGL9mtt0PXHpvaqSAefoStwvrMqVMaY2Af/scnkCleXGXJv8J16Y+67Hegx8232p3xSnJvNt07PxNGDKEbk4SQdeWT0tzDH/MYmWvkNWtOa4JVguQHPmplfyR3kh5c=
Received: from CY5PR15CA0226.namprd15.prod.outlook.com (2603:10b6:930:88::15)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 06:21:35 +0000
Received: from CY5PEPF00000E83.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::1d) by CY5PR15CA0226.outlook.office365.com
 (2603:10b6:930:88::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 06:21:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E83.mail.protection.outlook.com (10.167.247.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 06:21:34 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 00:21:32 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdkfd: fix units when unmapping a PROT_NONE VMA from GPUs
Date: Mon, 9 Nov 2026 14:21:20 +0800
Message-ID: <20261109062120.2302314-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E83:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 885a8114-7771-489d-cfc9-08df3e29b456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3RTjfOeBhqOuprzB0JxkLtNfNx6/EuLcBlobjR1Z+iKtWRcPRc0mmThGw75JrMiacrA/OIUvPEnQeC9eZSsynWId8XO5AE0KwcJ4075LX5pQQveUFFY4ujI3d66YRxyZhIxAXcRmbcqmcwIxFLWBs81VgE/La6lgUQUcq9XCo4XSRc9ffHaIuOE5pMLNdQ+bA/ghl8ZJqx8X2tKzOsLxZRPJgYv6vJpm49lW+9sIn0NZRuzMtGbjpSRRuErabYRPq5uDU4Q/T33Nfs8Sgkgd7dAlcEv3PHixLVsQPjcmMknVTpp39DXQ6pEP+YE7w9AwgGN2nAtl78/aa5ImveEPrpPICJn8lqBs/gu0gFJx94sUZAn8GKgqidfWgTF5m9ACWQWEaNTRQ+VcVnh2hajuaU2wcsnXP13PvtlXRCHRsdDeM7Vq15tszMkK2tNbFap/noca8gVGzu5CudwWbj5SUY4k7ztpeyHUs1xO/lw8CQJrCY7lJAi13pLKleMHVnBsgAqXPsAeq4HYxlQOA9kElyX3uCtOSvRD3oL2NuASbiii3mLDPUEn8isApPf0kPU4lDXRsGjasWy68m2PWO7bx9lgIUhscQTJS+hqUidl+gdsk7pXZP2cnzcxbvMMfKprjHPNXqfijt65iND0Hw7XHomEvto+3XqcD2HRTUuCllkjOwrXd6kA1mT4cq0oYFQbBfaZAQ3E3yhd0hT8w2JCiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mpf0eCQE1YcuVAvwC5hlcEmP3wQc98+RDl8knkwpNVjN/aA1wBesd0e/E9UucG/mqgexg5jP8e8jliRNcjpjiqTmQCvzfQ/Z/U9ZWrLMP8XTP7QotDF87PvoSasyKGders/QDOce5+QlBKo79HWDtkJC+c8L3pttJ3f5E23bS4X2E4juVcFARFP6C/x+9awl0nBqYdzzjTIZ5u+q7+aZYauRhNXl4uHESyeb1EYOt1txmfwHXeEBAcM5/xbdzvVQv8QF4xojfHuPYwl65QYG44M5VFxFaJ2ES8o5oyUZXxFvhW5u9RjfNibXDEPKsLAPHDYtumP8lF1Nmq5F+Z6BX3aSOoSCZG1fs5EezuOrkEvXg9dbOIF7diuKqEtyTP8tx3vNW3IHU/TOXenSQFiHF8mg7f1azZwccms8ZS5v0t1AatFZahApKo0fgxg2slgD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:21:34.9178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885a8114-7771-489d-cfc9-08df3e29b456
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E83.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In svm_range_validate_and_map(), start and end are byte addresses
while prange->start and prange->last are page numbers. Mixing them
makes e >= s false in practice, so a VMA without VM_READ is never
unmapped from the GPUs. The bounds also covered the whole request
instead of the current VMA.

Use the page numbers of the current VMA, [addr, next).

Fixes: 0ed704d058ce ("drm/amdkfd: Handle lack of READ permissions in SVM mapping")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 876476046926..968ad471ae85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1857,8 +1857,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				svm_range_lock(prange);
 				if (vma->vm_flags & VM_WRITE)
 					pr_debug("VM_WRITE without VM_READ is not supported");
-				s = max(start, prange->start);
-				e = min(end, prange->last);
+				s = max(addr >> PAGE_SHIFT, prange->start);
+				e = min((next >> PAGE_SHIFT) - 1, prange->last);
 				if (e >= s)
 					r = svm_range_unmap_from_gpus(prange, s, e,
 						       prange->bitmap_mapped,
-- 
2.34.1

