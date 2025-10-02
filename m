Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924B3CAC5B8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6CF10E1D2;
	Thu,  2 Oct 2025 17:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r4twdf/2";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675B510E1D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p34Q3/lY1FKh0oyUfe2MJLTHV5DT7DhaRnhNKLtbvXT/hELFS8YBxNjdoo2f9k3eglOOkhSthyxnMi5MIXujedl1Ro8em5jtorV7JTDFE1LQGstGjLhwCSPkbaK63oaykXGHXjLvsOm/v+SgViXOve2PqzHJyslNFyPmLv56KQHKR0Exy01ncw5vVRkgXVPXyu6mQAEz+DHa/AiiVjr/4n54h2RVUbLvI/dZPhE+WTwE37zUDg2MmQYO2FAYo1oQ/QtJruZYtTMyFq8FB8pqhKt5LWMacas3Fnz1mLa1I/LE155C1daLBAc1rPGXVZef+4724UmIw+QWjlu/L1e7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVkg8eyi+LC9dXl/v8vP3azC+PBmiH8SLgatipDZ92I=;
 b=OBljljW5eAuQUy3zHU9ZhWVWpJ/CcyvlCPzlUO+1rjkyC/mVZJAmL2lI8SdtRhYp6uin7loXq8t5/RRH2B2qlxdQ+JopYyN2YmB9uwRVFumFc2a+DPdbavRDbNVTAk0P7bdvrfdGSzXTZ13up4tdp4CIg7D/+X+N5cvmmsOq9a8tBvVnq4opT2pCNJJq002GZHF//ZJFX7heCL2G9R/a0R/a2a4+j0PC18+BRzP0ezpUSK0piKMotwQHyGsj/pcDU29XzsOclXbgKoepg+6l4thTnW55/GRya2TMsXLIuZ/Bj63mgrzQLFPFYMQW8i+HIYSrosMUREHRlmH62qYk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVkg8eyi+LC9dXl/v8vP3azC+PBmiH8SLgatipDZ92I=;
 b=r4twdf/28l7EHPZg02w54d6eim8wfF5eJcbbeS5rXoFT6bNnS4DsOHUCvHo5Ym7WHAjx6bo/cqY+QQxtGc8X505sGUOkwjpibkKJl9zJh/sAEEHsEGII/uqdblUmQpSYgWl3uc+kWqAYFhRjK+3jh1zJ/EDYrbVpJGMSP3gNYvU=
Received: from BYAPR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:40::34)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 2 Oct
 2025 17:43:37 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::55) by BYAPR04CA0021.outlook.office365.com
 (2603:10b6:a03:40::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Thu,
 2 Oct 2025 17:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:36 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 10:43:31 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <harish.kasiviswanathan@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: svm check hmm range kzalloc return NULL
Date: Thu, 2 Oct 2025 13:43:05 -0400
Message-ID: <20251002174307.10583-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcc5519-6cdf-4212-3704-08de01db36ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+y1Avi3yulA+cOaCFfGWpsPhMoJDZsFef8N8vpXLC4KzcKT4DT7xwCmbD0i?=
 =?us-ascii?Q?P0Vvpm/VXJvESXZ4Y+5CMhnV3FUa39GNtIffFhCAsnG7GFurCp+IBt8otGAA?=
 =?us-ascii?Q?K0CKeeHMoR4vhdu+znbRjY5hjzivUQtJnL3cZZofXwAJZWzgUMZoycYE0LSX?=
 =?us-ascii?Q?gdoHGPoOpwSd3Af1FWfAQYbCAtY5JAm5hVGAOSKCn+pDYM6Lqe1i8Mroa/Tq?=
 =?us-ascii?Q?oFhT+5EHCo8yPS9dSSkGXsua8gaCUAUPLOPsLPKU7sQeEEUChcyvtJq13kuZ?=
 =?us-ascii?Q?qb+nui4VAKUcS1guSIv1eIUzeiyDXVdjxzNvGc+KNzMJnEy/34hLbxnX+r/K?=
 =?us-ascii?Q?iDsPerip601hwgsallkQIgs++fDALGoDDKAIgYBaqSly72bVEA5ofw09j2UM?=
 =?us-ascii?Q?kHi8IOIPBHA1U2mk/3MiJv58dRQ+vnOS3/ImrPL7lK6CD8f8EB66KGGE4+ci?=
 =?us-ascii?Q?7xvO8gnzt6QtOKCn52ofan11Q07OZlJwbO7V13z3rBAwRyPyjpqkPqZUqzNQ?=
 =?us-ascii?Q?ENwSeEwqHuhfNlXiCC4pn3SG94iJmFBgliOjfuwttz9nPs1suwrbPxgJunrT?=
 =?us-ascii?Q?npRSGRXCDHYkDHZdqbAgEW2uROhR2iffQOo4avLx2d7xjqQ5WuUV/PBSCiQn?=
 =?us-ascii?Q?1O0ImtdeUkcWm4WUgPart3CS3m3Scxu7kZatngf4IUy9XwzmhgyLCfyK+YkN?=
 =?us-ascii?Q?y/8EPrLNRQeBiF5xDENnkKd4Hwxt1FS9i5X0CW4JWXelZpl2I3jH9L0PXo9u?=
 =?us-ascii?Q?xKfNubcmtWJFAImNrfi6w/wOT4BB6OvoxruFfO+fW/56+5lRwlPIT5NatUDT?=
 =?us-ascii?Q?ZXR3tBJeTlcMp7vF5WQ/rGS39yZm/obkA5sexnAMqmWKEzDZYT8yPblA9ljU?=
 =?us-ascii?Q?q0dpgnnT/o1NSPmrFsIvHXQtLTU1VUBLByxWZzmXZLta5sGjr6UdKh7B647R?=
 =?us-ascii?Q?FSZMyr7s89b4KBpaOY8Evp8iTfifaWMqYS38PJeE4b+8oqMIQvFvwLV3Qmwl?=
 =?us-ascii?Q?srm5+JrihhOpfjHrqYJJzVwU8TlBUFvDMwXXq9X1KDD4vLij3E1mQr9xbw99?=
 =?us-ascii?Q?aISzLS4EMkydHSNrC3nbaaChaot3QSRZylphrUuta2pigMI5lgys334HFf02?=
 =?us-ascii?Q?UPPynkix8xn4WboluybrmPu8Xgpf/b2ApwoDgrFs04qB9R7VrMTRxsW29CY2?=
 =?us-ascii?Q?BNSEWPu9mxyUiV/bPESZmGCnFPXSHjX4ipnIH1ReSw1FKEwsNT6Yy9ocr2s3?=
 =?us-ascii?Q?QqSdD56HDvS0lhMmOYQNRZaQ91TwpIY28iuoP4EZugXVI62hrYt9+8H9TbpW?=
 =?us-ascii?Q?N8sJDNWWOmJ9Yiv4i7Zegq7TMMRvMjrMCk/LhFKxcPkYCGbl5YEuKXcouqMa?=
 =?us-ascii?Q?vPG9HN2mhv3cTaCkfdPD+MIf8vkZGsyyaM+cx58IJAvSzrBQXoLpvEXyT4iO?=
 =?us-ascii?Q?I7BONcHKxif+dsiAReQhP2LceT9MSqlvtu0xxwa2U+tkf+Dh4tSsW45hcqDI?=
 =?us-ascii?Q?LPQMiJt4ukVvU2ZGeniKAW6lf11+8YkEA5uWlVYZ90FpfQIgbUAoTY8AjQVk?=
 =?us-ascii?Q?IjAnBCU9zzsAlCnXYus=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:36.2802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcc5519-6cdf-4212-3704-08de01db36ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5
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

Add hmm_range kzalloc return NULL error check. In case the get_pages
return failed, free and set hmm_range to NULL, to avoid double free in
get_pages_done.

Fixes: 29e6f5716115 ("drm/amdgpu: use user provided hmm_range buffer in amdgpu_ttm_tt_get_user_pages")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8c3787b00f36..e8a15751c125 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1736,15 +1736,20 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				continue;
 			}
 
-			WRITE_ONCE(p->svms.faulting_task, current);
 			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
-			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
-						       readonly, owner,
-						       hmm_range);
-			WRITE_ONCE(p->svms.faulting_task, NULL);
-			if (r) {
-				kfree(hmm_range);
-				pr_debug("failed %d to get svm range pages\n", r);
+			if (unlikely(!hmm_range)) {
+				r = -ENOMEM;
+			} else {
+				WRITE_ONCE(p->svms.faulting_task, current);
+				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
+							       readonly, owner,
+							       hmm_range);
+				WRITE_ONCE(p->svms.faulting_task, NULL);
+				if (r) {
+					kfree(hmm_range);
+					hmm_range = NULL;
+					pr_debug("failed %d to get svm range pages\n", r);
+				}
 			}
 		} else {
 			r = -EFAULT;
-- 
2.49.0

