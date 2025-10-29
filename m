Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247B5CCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 01:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69ECB10E078;
	Wed, 29 Oct 2025 01:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yziaPaAk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8231F10E078
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 01:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXZ40jYxXrFjMznGDNpc5EjXBhb0CBev/UFjqaSeHgPvdgpeqGC6hW6zECQot0V3qfwFY2XUpo00HQP4dBcDJlhWE9r0BdJxLMJ6PTYSsK692q8J8wwaQtRr/8FLD88Yb/hWpYOe6dtq9Ty4DQIwbzD+EqnoYTPnx3Dq1Fe11s3XW5yb1H7xZeVpYC+prkTozw0+8yVbnI3KRKBsx1QkkjeP0NGaR8TAk6Zf3mMxYsDLsnjB6v8470M+0roXLDG192EEqp7yNJO6Hbm2j+jlCLJYDl4XybTcnTf7ELq+F/salqZwYRFn/NOXwvs1RKtuSCEoE0dMAcLTKmKFBDkviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuC7G7KTtPU5YpgZlpY87EZ6lXFGYWULS9XPRPYCCKo=;
 b=xvpRgWmKikYuKLd9OZNW1pnWzJdcraHHA57SJDXb60snyFi3nTFCb5XdlNHgWmQ9+tl5IYgbTGo3Z05DBdmAjASNT2/tJ/B9JSWh9aco3bJ/6LJM8xjRnxyj70rfde/Ym7z0G88ftERdXD9fldIckLjEShWOsLuExMyHMkGycgx8BklqVP6tZ5ih+bgud2p8UKPhpUNrnRTUqEThlSipTNMZvOUl5W61OnaadcrSAltgs4gezXk8J8OsnbtjBqAVpQDJIgYsSqE8qaNkGaMu1Yt+pIl4QiEUGk/EvR9RPxCiV7ee/iIh8VnAP24kLIkYM7b2k5AS+pT3PkZ5H2ic8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuC7G7KTtPU5YpgZlpY87EZ6lXFGYWULS9XPRPYCCKo=;
 b=yziaPaAkrhZK2Z03IiN1pOEdhD6lwZW/uFc5fwZ66ZmOOix2t8I5cZx2QWAv3T/3iau07Q5d1VZVPt9bYUppFYcoDw3i+LxHseeAbv4utQbSbsaaVxGpuz0u3dNhPRdhwzmpKFG/84N+0KN1/HDkKbI4BLljb0XKBYdiHOy1Fqw=
Received: from BL0PR0102CA0018.prod.exchangelabs.com (2603:10b6:207:18::31) by
 BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Wed, 29 Oct 2025 01:31:20 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::db) by BL0PR0102CA0018.outlook.office365.com
 (2603:10b6:207:18::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 01:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 01:31:20 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 28 Oct 2025 18:31:19 -0700
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix GPU mappings for APU after prefetch
Date: Tue, 28 Oct 2025 21:31:04 -0400
Message-ID: <20251029013104.4034287-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: aab3f03c-b9dd-4426-3c58-08de168add06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vLxCntZ2XlsTTiOQnF4nsqovvbmL/hfPpPuJU7P4e0swuLLIN7k9Ql0xxUQ3?=
 =?us-ascii?Q?jtktfPYB24xvykZINOs3oiw2Nlan4qiZFUEvFJP4CDQhVLruQDvsGBiJ5pLh?=
 =?us-ascii?Q?g7n2cUfw3E46BaTMHJ0oh4F2zi9x7oxMA+IFp1yaE6ODFvZrTa3+A7vMUDAA?=
 =?us-ascii?Q?ftDwH9ezQRwqFzoaE9KDIdWmH2iaVemmLrdrqzXS0qYkJE4Dgs+fBF0E2YDV?=
 =?us-ascii?Q?veZrWyGEQe78WOvsOFgs2GsUhqTOA7GtrgvweqxDQ4EpvVXp2k4LzDOpgRTf?=
 =?us-ascii?Q?YEem2FfEfIesBvcn2PP2Kp4qyLSazPfXPhvBkrIWtGb31KVzzcap9K/Xlhkz?=
 =?us-ascii?Q?ut5/AK14WRiAyBm9W8AUM+X68L6UwaCUJj1pVEgwk1ZNYKIk82KZ3b5+0bXW?=
 =?us-ascii?Q?t6ZjtZ31+bZ6yWjZgJ+Pym+Y+eODmTeBrTaqNK6EtszNFBo0pyJAA2gHsvyG?=
 =?us-ascii?Q?oeTd/Gxud1T95zJuFk8ILDibyJ1Diu2AvuEhbR9OuJQWhxOIs2gJj5etYVGo?=
 =?us-ascii?Q?u+ogmvIh2Y0GRhHxg2attqRSqOB6BF3picak0UK92UTCg/Ez84wjyNPrlL1z?=
 =?us-ascii?Q?Sl65L0dnRXz3x0cEivkbKCLHelFyI65dw9TH/SkExtwFazWqGxqB2DrMW9Ej?=
 =?us-ascii?Q?6QVezDyqOhRbJu2vc32/iE7YkY6Xuq2+4Esg21oQOTYrnUjPK427AbmB+9US?=
 =?us-ascii?Q?DyvaJ6TkE5LvTR6jV/YbCqZ5zZZHnWanSMFUtoYTsm+B9ketqI7x2U+VxGWx?=
 =?us-ascii?Q?26QcjLXOOlx43u50rDK7yDc44wXHmou/sNQ+Ogaaiturvp+5c6HPfdoRHJL9?=
 =?us-ascii?Q?2kxka+speiv0c/w0Acw/8PeDuUqxBjCEUyxxHzeg1LvdZUtJSn7yK+1LDovv?=
 =?us-ascii?Q?xwl6RkyTjpilY5wly+csbngqkTOpUwu1g/14gY3CMwiTabWZtd/w7rjwH6UM?=
 =?us-ascii?Q?8QPWvyDl+6pnpRQ7KVAQ5z0mmnZNd+QSvvb1BlhPLbBxfrYV3qWsKmO8lxkq?=
 =?us-ascii?Q?mAFMUL+hmZX6z8Ws5ag9erf94bloq2Arnn2QDBJTX1yHHRmCNL9446ZZKrsV?=
 =?us-ascii?Q?1G84QODinTJG64Rr/S9mj4/gbj321smdfFcApmznkY1qiTo0mJhh5TY77FEO?=
 =?us-ascii?Q?Jv5MHML5R4XD6kSSZ6KrisYFhmenkcjYvAwWgvsxnz0A/I8fdvzE1iloKpJi?=
 =?us-ascii?Q?A1ZLOTv6bZttJk3F9KwpZLd82BMDoAUdkzLuGt9uIuKHg1u5bqYEwGtQO3ov?=
 =?us-ascii?Q?XcGWbsRbZKY/3Lrc6jASnbRRh74mSMTBMTRh1S5g+5jhCxzYsFD78qLYNnoq?=
 =?us-ascii?Q?InXqqucm9qfQOmG3CcHF8bnPJHcSatvXU6ljYJZspIgWbMfjqKp6Eccvcm4p?=
 =?us-ascii?Q?pY9RxSWTwkLKm7EFcxjVh7riGzeLw4XXuHOh2R3COt5usgvMBi5p8FQSPT1W?=
 =?us-ascii?Q?mpQTrCe7m63nmb+GXKJZvnSvgwMZCEWXDrKvFKj2gPlYLy5NeXK9VdDZqP+a?=
 =?us-ascii?Q?JvL5MLySkdmPEJ9kwX/a2iyRiu7qKHDnK14Y50vefcPJOJb3LPk7kNNhthlJ?=
 =?us-ascii?Q?cZInxssoma6/guPyWoc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 01:31:20.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab3f03c-b9dd-4426-3c58-08de168add06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

Fix the following corner case:-
 Consider a 2M huge page SVM allocation, followed by prefetch call for
the first 4K page. The whole range is initially mapped with single PTE.
After the prefetch, this range gets split to first page + rest of the
pages. Currently, the first page mapping is not updated on MI300A (APU)
since page hasn't migrated. However, after range split PTE mapping it not
valid.

Fix this by forcing page table update for the whole range when prefetch
is called.  Calling prefetch on APU doesn't improve performance. If all
it deteriotes. However, functionality has to be supported.

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c30dfb8ec236..d3d4f0d01653 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 {
 	uint32_t i;
 	int gpuidx;
+	struct kfd_node *node;
 
 	for (i = 0; i < nattr; i++) {
 		switch (attrs[i].type) {
 		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
 			prange->preferred_loc = attrs[i].value;
+			node = svm_range_get_node_by_id(prange, attrs[i].value);
+			if (node && node->adev->flags & AMD_IS_APU && !p->xnack_enabled)
+				*update_mapping = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
 			prange->prefetch_loc = attrs[i].value;
+			node = svm_range_get_node_by_id(prange, attrs[i].value);
+			if (node && node->adev->flags & AMD_IS_APU && !p->xnack_enabled)
+				*update_mapping = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
-- 
2.34.1

