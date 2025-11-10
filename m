Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEDDCCFA13
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 20:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7C810E380;
	Mon, 10 Nov 2025 20:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="onk9KYNS";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CE610E380
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 20:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZibELAGTpP01SBDzNbeV4b74UdzCP1AdHpG0NmmQ/Fwxqj8ZVv3bHWFPdofuUrtwfEw+yhdjIzms8jqvx0ILHRngVyeK2xTPRxGZcCK9Pvdn82clnBIfbaUoy2uKmM6Px9kTf6C8ijWLyKoxM/UeK6egcZ0BdP+KyZ5JeWRrRrsKZujORcVY8zi/sTwlvOvoXVMQcQsFc+lw651NOZfrNErTOOEjySZKFBx/0/WDIup8SAwLDwHs2VYKCuX7CRQXdeBjoWqOIFaY9QaFu3LjbgeNOc4UzElaLKh2rpKAtiwZqfC1eVob56u4/Ij4hQR1GqrJskYrjK8i3llxXaufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gqZYB7hZtqItrtcOPjM/DTmXLE4ZX9HS6U03SYBDxE=;
 b=wpjfdw6uDClV8Wbk/kKn4GySo54waWFlOSw77VtNbj+Vtxhb9JplcRUwrwnZqt+plW2Pl7VCExCY02Vw/V2APxL67j37fYv92YQa63rGmKrvopvL2bftbG/DhOJuNxK7Ph5kObSW0JccTOzktaztoZeyqL2ZSqsn3p4+Uxm2xF+XQg+jMk7ZyX/lRG9/94/1UzdBwN7MB6PuJpaAOchQuWXZsuYaU4p24nqc6ozKjRd0Pmd6O1hp2zOeTmk7zDFf/kzfI2X2NJJiWOD6ytsdzJhPP99scX5IXieo6ZAnAPNGdkj02TXPOiPvljpa+yqOs/wDtxEzs1dcXyVUnZbQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gqZYB7hZtqItrtcOPjM/DTmXLE4ZX9HS6U03SYBDxE=;
 b=onk9KYNSSwVtrsZgRNQDc5Hv2EBg5h1/FN9KkG5kcrEnjJwzwq3JM4uuYzSf9r3li7sIYr9KXUgdYX8NZdMpC82dS/bvCv5RerBHGnnaGPI/chNHwnLzwYMBlZveN3ENc2nd0nSZXP1HCPHWIaKjxr43AyrN+l85OzusFquG3cU=
Received: from BN8PR04CA0051.namprd04.prod.outlook.com (2603:10b6:408:d4::25)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:33:13 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::c6) by BN8PR04CA0051.outlook.office365.com
 (2603:10b6:408:d4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 20:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Mon, 10 Nov 2025 20:33:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 12:33:10 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 12:33:10 -0800
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 10 Nov 2025 12:33:10 -0800
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Use huge page size to check split svm range
 alignment
Date: Mon, 10 Nov 2025 14:30:07 -0600
Message-ID: <20251110203007.246736-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 440b84a3-eb4c-4c71-1338-08de20985da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rz6+vibrLeaHxpVroNd8EMGOPU1RY9OCgiuPOsi+xFZuqqM/Q6imfwA/JCP+?=
 =?us-ascii?Q?yqnKifNcaCjXeyzvGLXnZGU1gOvf4aDSeKx5VFgPmEza+aVBzFNdHFogkZJZ?=
 =?us-ascii?Q?76hyeoQB4a1XBkHBMppvf6F6nVMsVuzO1m8sqDn0UP69buByU+50mFElaaaX?=
 =?us-ascii?Q?Kjz+KE4q2LyY9hG28ZeVjuVpJWhdIh7WjAzyabn41sQj277Fo5r2HST54HmR?=
 =?us-ascii?Q?C+2onrUHPgjrkM0DcgIts9VyzB1xEfdI337nQeWthyjeDz2uL2/7BVqVg27H?=
 =?us-ascii?Q?c+VdNvrWiEX97PSv389jgRDCjktbgAXtSlgtFGo3LRFyIazNDH1/M65Si58r?=
 =?us-ascii?Q?F9DfXzfTUUS61pz7RZxo7t1E+1RIxR8Q6Em9qt1Wt/bI5DanXJ8UY3+t62mA?=
 =?us-ascii?Q?G4Uq7Ayqh9aWoWsMXiLGffezET3FvlFSK9V+h3CF5sFRckxLC9wuCjUGNgJT?=
 =?us-ascii?Q?owcHUEFZHmGWyIlgHo3la/w4N4H06ih1hGGZIY0hV3t7u7eXpY+9nxQTYvIx?=
 =?us-ascii?Q?QZHKSEhEB1pqTg79N2XZsvgHHoidY6YL6ceEW/lq8Dc1Uog4jfUFGONPhzjU?=
 =?us-ascii?Q?lT6Hk1+M8EPtrA+6DeltMO7n97O+UoI1uRA9vWl9S3mR1hXKL0EC97L7UU5V?=
 =?us-ascii?Q?KI8uNg6eFb22FNESF6L8N0hytUkwESt39j9BkAhp7+NnTsG1BW+OtNTA2OWr?=
 =?us-ascii?Q?G8aFRWJkwd48W8XUHS8xcArP+a+BJwXIMcGR05t7US/NfG79pFCkUMGFjIfe?=
 =?us-ascii?Q?1qUX8n8Z6AVNBzKTPHDOVyCGhZSTTUKcj+pftZztF2HZr+twU6PQiZic3BCf?=
 =?us-ascii?Q?YjpcwNa79BspT5x7o1S6i3tq/Bk2/hj7f1ayy2g6zXeybQXU90MSEideq6NB?=
 =?us-ascii?Q?VSKgXdndWM5BAP04TPmeTbavixRZwmRgGb33Vah0Na6sqNSOpi1YK5FB3fOi?=
 =?us-ascii?Q?eTIIZ830UQX3KO8TCqZOfVD+9KoneN6oFfWHm2kWhCpCmQ8cPmsIcctjrWQf?=
 =?us-ascii?Q?v/ZWjc/+O4t76XuOmkaresQRcXfXW8nZmHxDakr4YV7RQP5u8WWnEBfta39p?=
 =?us-ascii?Q?b6TXFYmHQAv8E+ubIhLae5mYja9qEv5f5zijZV1Uu8FWE73/hDW8TfpJJ2cX?=
 =?us-ascii?Q?zwC5fIxawH2bYfhy347honzCzxrFrHFM5LnePpZnBNkHVwt2hQmoFsJXieWn?=
 =?us-ascii?Q?p2RdOoGrDWZ8xALjztwYMOqY4wtrQQYOyX1r57hy/75ICZTpQBVOW58lGw0s?=
 =?us-ascii?Q?hjTq+0Iqrp1NuZ+b9g/7TIhIrE/BM934ukeQ91NumjZ04zJnBBR+obFB/otm?=
 =?us-ascii?Q?Z1GzNxXhaYEBEz7DNJzOYIcQKGVGp80bPcjs2tXQELHnL5V3tUot81Onbvhu?=
 =?us-ascii?Q?C29CXSHD42ZiNZWsqzLbyB6Kr57jfZbLND9QITegqdQ9gkm9I9HHQnUL3GbT?=
 =?us-ascii?Q?QoXTPTEEd9xbasPe8J1MSX33a7iI+s3qOOHl0YjnTi6Y4cJFthgm6kmUM9GH?=
 =?us-ascii?Q?7oWlKo1ZY+VVlKw0YCi/eo8EE4wcYX0KFDFHvLburUXuPps3dE+CffILDs+Y?=
 =?us-ascii?Q?DRdV0EHQe/xBXkDxyfU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:33:11.0725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 440b84a3-eb4c-4c71-1338-08de20985da1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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

Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have split)

When split svm ranges that have been mapped using huge page should use huge
page size(2MB) to check split range alignment, not prange->granularity that
means migration granularity.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 521c14c7a789..3af85c232659 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1149,7 +1149,7 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 
 	if (!r) {
 		list_add(&tail->list, insert_list);
-		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
+		if (!IS_ALIGNED(new_last + 1, 512))
 			list_add(&tail->update_list, remap_list);
 	}
 	return r;
@@ -1164,7 +1164,7 @@ svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 
 	if (!r) {
 		list_add(&head->list, insert_list);
-		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
+		if (!IS_ALIGNED(new_start, 512))
 			list_add(&head->update_list, remap_list);
 	}
 	return r;
-- 
2.34.1

