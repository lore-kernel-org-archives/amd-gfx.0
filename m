Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D10EE20A7
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D7610E057;
	Fri,  6 Feb 2026 13:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AcZVD6hj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFF810E788
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMdls3vIkuf2oWvx7eqewngwe/iEHlKuqKTxAaesWPUha3lk/RLqoXs2cqaT1RpEtXtrMNOKkRSvE9yof9YtPNUdjXAa/1tb7Ak8bpljJDXjFbS7aeys9nCTS/YtgXWZm9lBLEuHyO5xFvvJqkmwRMD0Q5/Sww2PPsGZwZq7blkejc+jxfsBsMSW8n9VIhkQtZ9s+coo03MD1IQbStRN6EfvMmNrYjYwoQA/Q0xLAA0H+EyrJrPHcUBxyVSugDk27VcSQ503szp3RycHX8qlhEACtjhfpIv+4NvzLyoU9rjOyOjciCqKN7dCi/X+hKchwd20fvGPgJGbF79DgDvt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2F/x58bIa5X3k+/NKCPW3gvDyfOXu2J3qyCk6eVZDwo=;
 b=DZlf8UrxA29s4eX7xvtmA37HwpyxgmnGUE+AsEof51t1ptDmrbYFkdz8ip8QZ+f3iSk10lbNrth6PqLlltSZXEDHzgrHwGA96bApnjnDG77244pmcmpUqqsCKwbdXDRTvB0OxgQ4I9cUynX41RSS8xYVj4/B0Rr0OTwOUBjcW6d+iCzFhUpr4pogrJFRgK0uKhTBnQv9THFBPzfVbAv5YX2PVORjxcK6j7J74LmkeRkFz9YyKcmdxIjSe+PwXusKBIL4meIOHE1r6bHgaUImdmRay5GJQr1lOfAincBWlRSkhCWDzZ8ZHRpAhLmBNywPYncvy9EYiej4noDduEw75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F/x58bIa5X3k+/NKCPW3gvDyfOXu2J3qyCk6eVZDwo=;
 b=AcZVD6hjz+LSiBPJiRhHD+mf3Xrrryzj9hS9hF5nQHj6r/QNgHdURv4jlcH+uMiF2lr9dMnlnEYjbYCJTC4GgF3yhGLkqSNQlyRCPks2OyF0j/BFCq/EfX2x+B+VwUSeU3MDBBrXinvzsH85yxgufJUK2bBVXXMShOaxA+tnpec=
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 13:56:19 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::9a) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:56:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:56:12 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <victor.skvortsov@amd.com>, <will.aitken@amd.com>,
 <Simon.Louis@amd.com>, Simon Louis <silouis@amd.com>, Simon Louis
 <simon.louis@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add xgmi link status for VFs
Date: Fri, 6 Feb 2026 19:25:39 +0530
Message-ID: <20260206135539.3843805-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260206135539.3843805-1-lijo.lazar@amd.com>
References: <20260206135539.3843805-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c335ac4-b48b-4e11-1420-08de65878093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0lCj9uSmd8seD1+964UrV+sgAcqpRiUtxDKVUi8BNRyF+DXT/9Jhi7usbc3p?=
 =?us-ascii?Q?sdC7+vf5aIhRCbau5XajDLvH/IyoeTwVthJQPVX00BEttgjLhs170NBYa5ev?=
 =?us-ascii?Q?N5J3hANY9K/Oaajt8uAJm6A/LqB7TcX9i/XTX5G/K9wqvnOmC8HEm1qtxLEj?=
 =?us-ascii?Q?g8eocS21QuU2sXchQhoWnahB6VN3tuxgNUeloEemec8gxFiYhQfO9jc5B/22?=
 =?us-ascii?Q?eaNJiu8DT2+jpEbr6eNTLsKmacurDnaPbhqUye1SVzkOyj5lh/NcnFJ0p7N0?=
 =?us-ascii?Q?HhOqalBJRclyChRs91/h0xdO+RISYa2hJwRNTd+oSTu6wnQ8iUvLlzGk9rFX?=
 =?us-ascii?Q?yeXV+7qsIci4/0xxCsgYEQqjJ/qYGnV/suhEeEQQYwkeCi8vi0P580EM88pz?=
 =?us-ascii?Q?YJFh/uzdNoc2/R43xCF6wdYtjQs8OB9tp/5+iS62PZARzCIAKJDZ9/aeiq6B?=
 =?us-ascii?Q?rpI/cTfro3AYcgSVQ44aVYHRyFpmH5mmYCJKrx3rAvO/xOyZvZAH2SR6IgjC?=
 =?us-ascii?Q?G2xGl8zz0c+ZRuRIYybcNw3EX8/fMfrKr4SIHn5EiaDAc+5gvc4R8KyR7ppV?=
 =?us-ascii?Q?tAUt0KA8S+ihZGfrySjUFTWaKyVE/3rNCJNck6HRLvJJQlDKlpV1VLgZkL8Z?=
 =?us-ascii?Q?p97VEZhpgysSwBa8cIvkGbf0pqK8/uaFI8WOt66CJ09vT57fUVdBKT7+71lB?=
 =?us-ascii?Q?AdiHQCU8no20AJ/jRyH2Hc8Wifi+WetunyXFg9dz2dCILoK/Fpa2KPHBr0tq?=
 =?us-ascii?Q?i5EzDtz3WyyYrQ3XwMKMpKYj02W161b7ybehj6/q6y+7OdDPknq96OqVAxqJ?=
 =?us-ascii?Q?nd6PBp0hJh0NPNSTkJxamlcFv5ZEJeirZVgaZ33ETQlvV8bMkf9sommnrNYV?=
 =?us-ascii?Q?ShoqO7KGXaK5che8q3L16QlsAalZkWbXVzwuXCnYm2bYSfDvFo7mJVsxDWYB?=
 =?us-ascii?Q?0PdDkGZs7y3wO1tdSqhaBVRB2M/4f2rrlFsg2nST2oxUv8HRva+aVkPCg1Fi?=
 =?us-ascii?Q?Pw9E2D4GKofTMPhlYWEwmNGKj4oFhUDSt245wUeHt1rFJp8r/iinMRoEhB8c?=
 =?us-ascii?Q?WD4yVXf6zSyZuuEQ6f49au5UVPLtOIoCUGihzyKmCIH4l8LIXwjkXHJ+nUA1?=
 =?us-ascii?Q?olGIxXk/xkMpLlfiV5Wh5qayY89A8bc51Yga2v7ctExy5BHKVXIj6e/oA+Bn?=
 =?us-ascii?Q?7XoaR8atOeHoxKtBrBCbA309SgHIwcE7PywTvHkJ6IZ18SGrM92o7u6dK1i5?=
 =?us-ascii?Q?tZq6Lyci/lOwYW6BkZIvMOxGJLsHt1Xo1J1Fe4AB5WIGFmrtiC71p6Nwim0P?=
 =?us-ascii?Q?pF4firw+gaxlnB0AIYGL6RQUXuMfHk/8eAANoWrQbjXBrXvbzmNtT7PLPaiO?=
 =?us-ascii?Q?Fwz+E+X3AS2bTllfQGw4LQzIU+rbckZB7rZ3CwM/yd2qwwbYPRw89cJMOXDt?=
 =?us-ascii?Q?6DhfBWNZEu9B2OBvB0ouZf6TkND5cUfJJBEhetpNaU/jMGfmIQendZ3Yvwrh?=
 =?us-ascii?Q?CXFOBogGMKOjNmsucOcT25DWug9PmvLowcfpJNA3mLQMEOgEVg7aEaaViBic?=
 =?us-ascii?Q?73nkY8izDhB6ln/6nvFORB15uhoY0i7aXabDV2JoLiVNtjVfL7H7Zb6piG5d?=
 =?us-ascii?Q?U+whyIBgNBivxvW2npXTD3i25soMGSiCgaja55ukCIRMqRlizPr96Uzpg+4h?=
 =?us-ascii?Q?OzpY3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IJq4Xx3eYfdFk0eKmle4ZWF2QdFUnaNK5fM7wCJOBctzGN5S7HDNWLZpqMaeXpqCDoKWNiouFJuFVbJj4ASsryUIo38bLTS6we+IN03dV0hIcjB+j0pBv3SI7oAo/VOWSm/aODfOJ0/3qFWauucMq3LvWvNNK7DbQn+6jzjqkWBnHLYjLVrA1Ut1Dk3Xzv7BaynjDFfQNYAvbyMHx9ktjtvryLNia5ajvbBmwas2kiFelgUXbwg0IZxFiD23VH2i7wnB48UYR43yPT8uXKs85EIEN04VLwbGU23yjWjAInRN+B0II7rrQFnS1YDSiKws9673jJf+B6g9ifk1PzYmykloQGi/BJejAcwQ442HB6exyiag32de+44j3JTd7D6J9eJJwroUbRSzQreVTHZ89VMtia9R2WSuBHqYXefpCTekzvYhmyb16PNI95VK9cGS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:56:18.3960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c335ac4-b48b-4e11-1420-08de65878093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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

From: Simon Louis <silouis@amd.com>

Xgmi link status is unavailable in guest. This patch returns
AMDGPU_XGMI_LINK_NA for VFs.

Signed-off-by: Simon Louis <simon.louis@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c       | 3 +++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 0ca6fa40a87c..08731d4be177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -347,6 +347,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev, int global_link_num)
 {
 	u32 xgmi_state_reg_val;
 
+	if (amdgpu_sriov_vf(adev))
+		return AMDGPU_XGMI_LINK_NA;
+
 	if (adev->gmc.xgmi.num_physical_nodes <= 1)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 6683ffd6aa68..bdf8e6ff556c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1832,6 +1832,8 @@ struct amdgpu_partition_metrics_v1_1 {
 enum amdgpu_xgmi_link_status {
 	AMDGPU_XGMI_LINK_INACTIVE = 0,
 	AMDGPU_XGMI_LINK_ACTIVE = 1,
+	/* Status not available */
+	AMDGPU_XGMI_LINK_NA = 2,
 };
 
 #endif
-- 
2.49.0

