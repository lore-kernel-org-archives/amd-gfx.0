Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D721CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 14:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF37A10E082;
	Fri, 19 Jun 2026 14:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q0W9mI8D";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC8410E082
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 14:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mforktDgOE4M9IlLSwEkyhF5Z0zrA8WECm69M64WNbgqAWTYderQL6AbpJlOW6pe+L3F82N+QphBouUALQhQK9Z0VuEtl2zhJg7Gzh7Iz55Un3/3N429XRVtzeDbxCr0kZwcKjX7YCeWTqh4QAY/jDBPYWyP/f4y83Z8VKDkH5Lm0IfJCrsNfqhFrEL8MyNj/Kvdd46VM62M+2InvibYcgh5lFnS4Rhq6jJ0t9IFLWkwPFHyb4dHz63gV8LztSOsBSqVpz7WWXxQcIHbnE5XwkKbYRegCXowyPV0Z+RF3mFx8cyrYiZTNQ7BeDm7J+uHNS/FeG8H1LaQ1rHDogpvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTPhfRXf3wt2RbIPAbTadtXLwFMwtocRD93wOvxKTQg=;
 b=fDaiehp7KU/F2l7S4282serzN8oXSs24IxeAg7PkhkI69tLFckfSwKJhW88ZiU+QUXIBDby//2XeepboVHh1iNI4+mBxBZi9IPzmzG2YJ9lwHLgAhJh2WNODkQxuNoGNqCHgstvLMHKx+/UQIaVAidd5y2Xkz8/v1rrrEf+NGYT0py1sXl/Wjs4UfN5QqltAZSePz42RaB8p1VHgVvWFAlEDpa6Jc29JWfSo7Apj2iJPkMWurbYUk8xm5l0YkN/8ohXbCD5Lzte7k1tzGjRQeKf30PpCuEGyZNC7X5SThEOfsEHTzEsnau9ksZJqwsVlG7ZYGHuPBM+ARk3FJ3+e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTPhfRXf3wt2RbIPAbTadtXLwFMwtocRD93wOvxKTQg=;
 b=Q0W9mI8DytXZViai0uxdQdTW/Lj6DOFjAREDRSbFSBqwtmsObzeG8GbnDidyDpsHrIUPdvBqTarL+pcGla3UdBq6v1Kxy+YmoViRnscTX2f1P+aUonwYwYOgLiMyxU++daixiG6RRsVoFh8GcjCUwHOvS9ROeE8jqTE5VaNCUcU=
Received: from CYZPR14CA0029.namprd14.prod.outlook.com (2603:10b6:930:a0::23)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 14:12:29 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:930:a0:cafe::3e) by CYZPR14CA0029.outlook.office365.com
 (2603:10b6:930:a0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 14:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 14:12:28 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 19 Jun 2026 09:12:26 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <yangp@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: add sanity check in svm_range_is_valid
Date: Fri, 19 Jun 2026 10:12:09 -0400
Message-ID: <20260619141209.26057-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c67fa1-ca86-4d26-5bef-08dece0ccbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 1UHR7w8fvHX+RAow4mM0Q2Qr7WHdqT6dUHMb/eNG2gt2oqtFdlje0M26X5P7EVniprZ1Srijh8qvdC6vqk7oB8sQLb2daUjxluwtHoQAMNYYX2zl1wz0gzz2K0wIKDZM9FKVNNIwj2BMHL9uw/y3d4p6/rnkwClZrz4DE+9sf1hRpEphii8fvEiApZ6jDrAo2LioBBCpBNF44N8r0ul19X1pdsLGpwzxkQDyv4ni773IO9JLw2LF/lv+CNg29PItOBv8MGeUkoSosKH3gieuuzCrNANw08opHL8cXgRKubwPFfGxTbzh/9uRpPQxgXhsPEoVbCv4mRCVbWIaPJXX+KznmDKHDnSurNCQ74xgFOsubEJ3n9Mc9otC0DthlVMDBi8noT+DGQH0Y6ObNoP76cZY3AWKsqNmlgzoeuufkW+LRonxfjuNWPx1rlQihvtdxwl20aLknp04c5AnOstAkJjIKesd0DfNXN1M9geZYOfoMAnVjsQIti8+9GVuCZ3Mh8zxXbqInxR7mcSfZ1v8qQwsrmEXnjRU34gZ5YmqiIVo36A/TufMXZaM75uooKCbbx7yhuYyYXIZXLxcCUG1915R0W59JY2Vn2NxVz/AXIpld+k71qGnS/1P3dqrnlz/gzSqYyzdPJ+e9itsO1apsAoO8AQDbrba7quKxhUSonpfiS/vPoccLekedJqMh7e6Kk8uDll9MVYsw0AMkkmA0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y3yDe/tIRpiGulazLgH9ctzAPD2f5SrK4z6l2diMbpxGwK/lCg+ga2VR6LJgx/9DYy9FvtjWvgJx5EuI/p+WmEgePITGC9SGmqixGEKCnw3CfYTxIdI9UW6NbrOeOZq9GDopBdv48psjE0ue+DPAK+/gndZr0acSfTU45xFmwuRllzpp2fxXAM5JS6i8ibmq6EWx/M2oR9Rzna6p5QUbsLRcRShVfiQBWGuw0RIRVVuE9uV3WJs7qolsKejCfiN0egx7TEXkKhYxsz7MWIhMncuetJZ35iunA9qMRn9T+GwR3X0n5nY3uQ/irOo/WU9cKF9Xn0YIkcOupVtWpCuX3NlbL19/KeAvvfzfsajQll0+HROtu6hA9L3AGCKTkCv0xAvpvgFLzRuYY3K1rA7y2yYf4v5fdyBM4jIUuiCMK58yp4vCi/O8aw6PaTTHzD7O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:12:28.7577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c67fa1-ca86-4d26-5bef-08dece0ccbda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

to prevent svm range to be overflow or underflow.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ffecd818e611..37b79ccfc2ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3473,7 +3473,13 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 	unsigned long start_unchg = start;
 
 	start <<= PAGE_SHIFT;
-	end = start + (size << PAGE_SHIFT);
+
+	if (size == 0)
+		retrune -EINVAL;
+
+	if (check_add_overflow(start, size << PAGE_SHIFT, &end))
+		return -EOVERFLOW;
+
 	do {
 		vma = vma_lookup(p->mm, start);
 		if (!vma || (vma->vm_flags & device_vma))
-- 
2.34.1

