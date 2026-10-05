Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4063DCA5FF5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 20:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D3610E154;
	Mon,  5 Oct 2026 20:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sd8ReTGT";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7782F10E154
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 20:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srIiWAK4qu9d0XukycvEw+Hl1UvvR6gEQ63yUFsBEjeCQeCGGFhuBBSYRbTvkfPuG6Jsiyi4PPn7mBNGkrWvgHXyLEnQW9i/b1KKq4SYpMrq0CjbES8HcG3+TiaqCo4N1DsERHnBt0SAfO3+WN7eQCAE1s1jZmLY1mjGEC7uf7+htxro+fgYAD07ckR9+x2wArwcwTYerKIESdZ+AT4qqA5OITiBpPKwFsneC12Ocf1xZHNP2vCxL5lwPKSbYnFGosXwWQO9yznbK+XQCN/Noj5XYxxyF+KXGHMKSvtgV7GNrIf5oJjl3sccnvPP3buP1nmp46eLXpyxSMHPNCNojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xv4GxGHSPiyj1UbSuxPPOaMgYVEihO8D2PX5S7wdYQ=;
 b=KmLSJUhzEmP275zog6JbriELLah5NtFeCXry/3nXxHj0W7anTd+vxL5iHOJTbO8TMU23YjyNWB1Ob0V5Q70t+pdSQoK2BM659SP202P0yomT0uqZ7w5hri56oDP8yxv2H1o5dZ7m2vliQlSU0q2FXWOnoi52t2c3cEXzi9DkSIxycTNqxNuNAfkVTSotLsqapvbnFzP2zYjXJpaZXuGch2EDLWR8p87f83mbhuUOsYnj+NYBuxBDnXfwtfHwb4SI38zxsReom4inTt2HXDCg4bxIwJ32zTKmU77501iAY/wiUueXn8BV6WrORoMSVDyBKcB4vxhP0eAi6QSUIss6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xv4GxGHSPiyj1UbSuxPPOaMgYVEihO8D2PX5S7wdYQ=;
 b=sd8ReTGTN449ZdootOm2QW8fG9iUTSwXh9evqlv9xrFyvvxtJbamAz7vm98hjAf3LhF/0z2k3JRJufHpOgTzoMSlFVdy9leYH9Cns5tOgSb+uo1kxPL8fW0pUlRLeEG4NHcuxDrup7kWXN78KhcRYktGUVp1Dl7UF/P9ofCueno=
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Mon, 5 Oct 2026 20:33:01 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::64) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 5
 Oct 2026 20:33:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 20:33:01 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 15:32:57 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix svm_bo use after free in svm_range_clone
Date: Mon, 5 Oct 2026 16:32:47 -0400
Message-ID: <20261005203247.1363226-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: bf08d1de-1c69-4efc-c88c-08df231fd9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: azQuRxqsiVrKJ8C83/Q2+lt0Td7wZR8zW9TaAszZFO7qAWBHBcPJAH1UBM1wkPMmWIr+vNg6hv29Q02baie01/m9sfn0jENvkhPV2STCrZuHv5FlmpRIvq3L61K8MSBCWzG3i4X6qok5Rt8P8VHuh6m0yjgSwLguXTSWMemP3eqLBqaqyyy+LHwHEKXp0xmggPpsJ1nysfpwZeGKCTlRJU+iPS6dRBniy7WMyM2Ad2XRUnw62UJ515zMfl94WV2chdUCVljqCT4N0r0kEwJYbLqXwbo/4YhDn+shsuzvT8rNxCpE/i55zA25PdUm8AP3X2gsVp/qu1g82H9G5LIhhV6pNjrw221P7q5Y7L9chQ2s3btyNXeukDMexzNXO86uNwEAai2AjBd6bA5bN0HgWvML/vGhCFVAsYfiHSUPvZ/Oybrlhucm9sdxT2rMupocVHhS6/26KZ8rMmt5O2AbLCne1i6/LrtB4Kj0k5UrBgsHR2r7qQi4sGYfbSIkf7UPRp3Ar4kY7npfZS2ImykQX2wxlawpCCXg3IbLdNn2DVzriHRAm7heI3N21y0uL4XfMQQhrZPE/sQ7FHV3AHSlgCw/4WezcMvq55DAOqzIPZHuM/clI84w63lmMdEVq17I3767wklA33LMRljHMo31qmU29nD4Gu73rcpmVKx1o69m5n2EtZaLkggU94o3+roSvfHTAdlv2YqJKWDhfUis7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jK9iGXOlgySNBe5/ehg05RmKmzaJ61Z/1tarMYkeFfkm0YSpxTO35vHX5H++mRXd/FV+OYVnbE7cVZ594YknJL7Hk2487XxnoV9ewgYMGnc7gu1Xuha1/vDCBnd3WJv7jMzM9lDk6isKnBwAwSOo6DfuMFk8TSFSUCevYK1qczleXU4tmkM3SbRrazOajLlYuEyapey3Te+PtpzQGJQEYw0bOrj0MlHOAurFPL6oR40VZc2po8SHF11YJx7ZoGxGjSwq/Lw9lGdyZ8Vs+sM1vAaqWLnAij6xJENqGjoEdzAXdPkiCl08vBIYvSi+Pp1kVr90FklUEUZUI2ActWtJ3tALbOigWQM2+1c1+smN1AkYoAPEqp4BIYcD3EUu9yEFYn12up76mL3Xqi/i7U9BIvyllPF380FZo/xqBFAMwvRi+2xb+sZDHV1otPJfXYS0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 20:33:01.1884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf08d1de-1c69-4efc-c88c-08df231fd9b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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

prange->svm_bo stays set after the range drops its reference in
svm_range_vram_node_free(), it is only cleared later by
svm_range_bo_release(). Taking a new reference based on old->svm_bo can
therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
pending, leaving the clone with a freed svm_bo.

Use svm_bo_ref_unless_zero() under old->lock to only share the svm_bo if
it is still alive, same as svm_range_validate_svm_bo() does.

v2: use svm_bo_ref_unless_zero instead of checking old->ttm_res, to keep
    sharing the svm_bo when the range dropped its own reference (Felix).

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cfb428c72686..7ffc31df3b87 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2158,14 +2158,19 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 		svm_range_free(new, false);
 		return NULL;
 	}
-	if (old->svm_bo) {
+
+	/* old->lock keeps old->svm_bo alive while taking the reference */
+	mutex_lock(&old->lock);
+	if (svm_bo_ref_unless_zero(old->svm_bo)) {
 		new->ttm_res = old->ttm_res;
 		new->offset = old->offset;
-		new->svm_bo = svm_range_bo_ref(old->svm_bo);
+		new->svm_bo = old->svm_bo;
 		spin_lock(&new->svm_bo->list_lock);
 		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
 		spin_unlock(&new->svm_bo->list_lock);
 	}
+	mutex_unlock(&old->lock);
+
 	new->flags = old->flags;
 	new->preferred_loc = old->preferred_loc;
 	new->prefetch_loc = old->prefetch_loc;
-- 
2.50.1

