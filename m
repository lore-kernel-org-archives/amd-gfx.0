Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F05CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 15:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2898210EC53;
	Tue, 16 Jun 2026 15:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RE5FYIjP";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440F910EC5E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 15:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLDcaCpSinBIRyKHCOi5W4Ow5Aafk2qXJlqmXQrcOCkxTbQFpvVpaNXUiDx4lH57FApNNXoM2jIuF+714cj28yFYoNtY9SD53WfEHkf2mHd3XlfD0ve2PzzwCK6Ap/Lokw7HpD4cblTVRB56GjLu0kxgpTamIG6B1/Ceu3BvED0X2GZ++cyGRtn8YTnl+4E5Wd4AEkWk+nfkQK4/UrZBrh3vGz9xY7ZoJfH3YXy98dT6bLkSJA2TsY0N2McfqNT1yPRpB5eeVRFQw7g0ucpDMIPNKeSNaHMGG8uKVpuHObVU98lBdapfDaweRkAMPopGoECdXuXsa93mrD+kVo4Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pNcbmb82qzJGR3B0mGE6je5JnAFuVgbv+8Wn4grb5Q=;
 b=NtDXfPShbCD5SWLU6t5TtuzNz2aKT8iI4KBhZXxhFRcFLnivbn46AC/rkSbQLNZNyuAj8sUYW0rp6ySDYLsndUI56qWtdQZEenZsUTQgcI19EsbQfYUiicLJ6VBDuXSMsHlBWRB2LFItr4lT3aIeJAgl92fhNyMqXNZNic7tB6QJkDZCRR4dzL+I4PDEpEx+P4aQ+gL7dF3Zz1xLOpLlA1Uj0crOOxuY54lVnrljwx2RJdZJxNxrC0sdq2KTJo8ESNmTwPuTRMOSm+wGtETPJ8IxPv1Yhf+AhFOJz4aLmON+4z88xOBtuuKUM0tTLAQnUV224KsXHdBH0hRmX4CZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pNcbmb82qzJGR3B0mGE6je5JnAFuVgbv+8Wn4grb5Q=;
 b=RE5FYIjPF5H2c8Scacmz4SRYV8hETDUHy8YPUZCH70P+BnO74x9m4QqO6amB69qAkKyzd87z4VuC7Q726z2yTjP+wE0vaxIuHbkweVMbHWAo+V/NlN7VB4OZMxzucRCN3++upPYMJh4Zjg/IW+zxkeU85d2rh900yUS8tI6qCdU=
Received: from PH7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::33)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:13:26 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::62) by PH7P220CA0071.outlook.office365.com
 (2603:10b6:510:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 15:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 15:13:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 10:13:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 10:13:15 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 16 Jun 2026 10:13:14 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Philip.Yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Gerhard Schwanzer <geschw@pm.me>
Subject: [PATCH] drm/amdkfd: Use last + 1 of vm range to check 2MB huge page
 alignment
Date: Tue, 16 Jun 2026 10:12:53 -0500
Message-ID: <20260616151253.303003-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: ca11e9cd-537d-4f0e-8cd4-08decbb9cdfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Zo1hoYB8ERvrDlDa4oqxMtpkMSN7M+RlyNwXwsVbNaaFShbuXqyhkVHzcyXfCeEtl4eXqIOZYK1F7IWtpyojosk7J3uG3VG2MGMHCIT8D3XZOPJy4SX1LmLfZo0hOUVMUEbrWw2I26yH2uo+LGXr/Wd/6OD6+fsFK+HBYsBObuMkP0uEHF5l07dnztJZAIvqnskCXlg/32mwzG4Y9ZpdzvcfeBGQ4B6XOkzyesJfpt/YuclszZSbk6YGz4qB8nYBDa8yHh2K7h5TQIkjqU1ESsZrp7Mwe6RktSMwohKDejdXOzRbSZkyxTcXcn4OBHQVDf+ZNd7wwXwb0mKktbVDgQ25acrfpjjx0XSX93xKoG0C/+2DEy24RKdkbc0GxDvnN8oTUFX/xLM+ojsQsjCJx/3fZg7iXu+Po22ofrpcUOw/jpVU9cx6DmarVlmquJcVRf8L1Cxa3RN97wwUe4doXJ9jbE9X85wWnU1ZmwFRs0TZF82An2coRprFNJ2wKGivKukNAYBypHrkEYh0WdpRR0IdCpuMpy3gjVnNaEntClZpB63NgzR90MdEJ5GtCevg4TG1NCCTwDVYiuhJB6maVJGnVjv4gnrQk1OMkZlGB2n3eKys0hL5qPU8Ch29wa6G6gTc/rEH2zHIElfv2mnmlZXLP+Uf8799Odq/OEXTmOru2T4myqTlIIKpho+UVKrQJ6FOHqxYMrsNuSHRG6VYW5JNIKtRo9sYAfxPr05osE4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CHy1Xo05PIMZ4b3Z6nKv1LfDeeNjY0ecITdSO1huQZ7WCoQZ/Qfwg+frV6z69nASUpy5IJVwbUbffBUgJQnY/HEcRlcOaaFHJdJ+JCGiR4h1XM9x0i8RCrwG00UC2i0PcnEz8hUZO7+ra0cObJkqLwQgIULUVtjxF6ItS0iM+B3NJPBaXlgKK30Eztsm9xZJoPAnerzV8kMsTrX+uMNwWpTdZMQ+vg77le7qfHUj1133KVnoGOpedDfbUAJ6GkiH9w8pcmUDbxnR+DOGyuO7AgMm7QppPJ7jyb7awFjg5m74VZPp/oalGpAMzsi1fSqLiWHKyEgDfQkGts6Zv7opZ8nxdw+oCe51B8BUdqx2SdnxmWqCH7mYaD9NE4IzEl/7SAe5jeq14H6mtXQev21rwtVK18eda3MkI7s7o0/Pj4QNLkDfIgvmSB4D4qgu0nN3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:13:21.7660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca11e9cd-537d-4f0e-8cd4-08decbb9cdfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

The last byte of svm range is included. Should use last + 1 to check
2MB alignment for possible huge page mapping.

Fixes: 448ee45353ef("drm/amdkfd: Use huge page size to check split svm
range alignment")

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
Tested-by: Gerhard Schwanzer <geschw@pm.me>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 25b3ecf85f30..20ccdc4dde6b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1144,7 +1144,7 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
+	unsigned long last_align_down = ALIGN_DOWN(prange->last + 1, 512);
 	unsigned long start_align = ALIGN(prange->start, 512);
 	bool huge_page_mapping = last_align_down > start_align;
 	struct svm_range *tail = NULL;
@@ -1168,7 +1168,7 @@ static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
+	unsigned long last_align_down = ALIGN_DOWN(prange->last + 1, 512);
 	unsigned long start_align = ALIGN(prange->start, 512);
 	bool huge_page_mapping = last_align_down > start_align;
 	struct svm_range *head = NULL;
@@ -1181,8 +1181,8 @@ svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 
 	list_add(&head->list, insert_list);
 
-	if (huge_page_mapping && head->last + 1 > start_align &&
-	    head->last + 1 < last_align_down && (!IS_ALIGNED(head->last, 512)))
+	if (huge_page_mapping && head->last > start_align &&
+	    head->last < last_align_down && (!IS_ALIGNED(head->last, 512)))
 		list_add(&head->update_list, remap_list);
 
 	return 0;
-- 
2.34.1

