Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6255C7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D4710E531;
	Wed, 10 May 2023 21:23:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C6910E531
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G18ZwZZqQOkdocXxR9jPXCy1asp9K5ohIn52ubHMD5c89oUWtTZUEHqpN5QE575ad5IwBvATfESte0lDZTUlem+yZ5pFJcwTW7jteECn9HmXmBL3YBnJnpxEn7pvt2DxhrRCch4H+m+kP9+hhspls0N9KbdTs8BW8zxMn0YljJAxqsgJO4Vtoy2NNLTn2bgBQudRwrnUR1njdAQ6WdfS7qsyPm9Gj4hGgf8f1pZRWznJGChdz7wlTSlcHqNb71LbcWMhzWzS859hoW195+Yyo8YOB5wzj3wNLlaR3ire1fJhD7xBMaPurDJ+/bXZZ952w0mkcvpKJWC7D17Bvc+8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJcxm1VOtXvfpMGTDUmmXrYHJPQkXlr3A/BB0eo6WQA=;
 b=RYUGYvb7KsLMyM53P++X4TW9xUHzyZ+QzNlWY5msSNWnmgx91IpFHm/hGf8ZoMv78RWTO08SKftFxjxKpdzmYxH3atM9XI/J8esRff3N0Kuomg4+X6sXxm/iEN3ASNsUPt1BVMjPbyuO9hVSpNgIQJx0Fwl6Z5JnB39SeZcCYHqvT6wcEA9FFZidLqlZfDTaNuNL+miSsjm54CF2JmjIpGToPzrvcvkACNymfGZ9oEcNXehYus4C84Y7m2/oJ6bj6MTcIxlngJe4e4gZsYbniMYo7YUDnE61LelU9PhsmO17lzAlIRUuzMF7hYbNGAHqn3KBPeSzB1Bh8ZL9mybUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJcxm1VOtXvfpMGTDUmmXrYHJPQkXlr3A/BB0eo6WQA=;
 b=jN8RNIJ4o/Eaf4eZ95+rvR2rPgjLhtgjoYd8ceXI4G786Dcxptqu7pamO2R2nR0A9vRPBrOJWq7r0J0Cp45OKsIcIe1o/FyfLsi6kgX8olbdh5eXh77JAu8nAeaEroJG6SO5X9LC4u4zr2tFp5xR9iBmfm3U3HBj7NTHfJUxbKc=
Received: from MW4PR03CA0069.namprd03.prod.outlook.com (2603:10b6:303:b6::14)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 21:23:54 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::d0) by MW4PR03CA0069.outlook.office365.com
 (2603:10b6:303:b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/29] drm/amdgpu: Add xcp manager num_xcp_per_mem_partition
Date: Wed, 10 May 2023 17:23:14 -0400
Message-ID: <20230510212333.2071373-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c991ad-2077-45f7-b67c-08db519cdbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: micbnyMst5txDb3p82Qv1XqDZaCM6jOmV+Eu0/xgQi6LK63PXuXqGxDSrL8Nhz6+xFmHgw6h6YU3Z1z6q1NfVPJHVRNq+PwaXEaOh0CVk8WOvEH9kArA0KQVu7Ks1dUjN+LWPzXOexwwKpksX0gCmRCU1aRKTFG0VXRdI0OB5ITluY4EQyEiMeX0oRhvZACHUjU5HXy8Rp+/Ve75rEuV++vKoJlAKe9tv2s870C3+davZBNcu2hGT2PAq7PY2OLdBDeH6XrLw9ZNTrgZm2M+YtriiAfn8VMujwSfAIEA1zNkQWvJPBARORIaGfjSFVHihXIxgxNB0WO9hyr/U1xRUTva9sSzkaHFQ/gRSk787VCfSdm230HzX0sflKHqRUuQEjVP9ikSt1ok/Nqt8OhVsv3jaGAsm7mZwK61WnF2lP4t1/nMKwzrkoTPoHtAkptnhO+Z1oU03ei7mIWkD8zr6jupjP9edOUpYreEknp5sz2L/zu3syKGrMh2az8JYzZM1NQbDzwmuTfl8CGo4SJrXOdvD84z6h8CoPAyXeRmqSIizTLatxi1bgu3LrHsJkAtIg58E6oclAL7wOLxn60W6J15vmqbyfTmjWMldNVX22RgL5kXrQuLhqc+41AUDqO7W7Ew71TqQL55xCmBu6wY07UL70VrDnmLbPGVJaVtE6Y0/ShLlIKYhe/rH4tOXdq15SkWPqmClUsctILfQknb+M7ZRJDzc97y6La+B/z/GQk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(1076003)(40480700001)(7696005)(26005)(336012)(36860700001)(426003)(2616005)(81166007)(86362001)(36756003)(82310400005)(186003)(82740400003)(40460700003)(47076005)(83380400001)(356005)(6916009)(16526019)(4326008)(70586007)(5660300002)(70206006)(478600001)(2906002)(54906003)(8936002)(8676002)(41300700001)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:54.5843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c991ad-2077-45f7-b67c-08db519cdbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Used by KFD to check memory limit accounting.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 9b960ba0b7ac..f2981d21d4e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -156,6 +156,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	xcp_mgr->num_xcps = num_xcps;
 	amdgpu_xcp_update_partition_sched_list(adev);
 
+	xcp_mgr->num_xcp_per_mem_partition = num_xcps / xcp_mgr->adev->gmc.num_mem_partitions;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 39aca87ce204..68b63b970ce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -83,6 +83,9 @@ struct amdgpu_xcp_mgr {
 	struct amdgpu_xcp xcp[MAX_XCP];
 	uint8_t num_xcps;
 	int8_t mode;
+
+	 /* Used to determine KFD memory size limits per XCP */
+	unsigned int num_xcp_per_mem_partition;
 };
 
 struct amdgpu_xcp_mgr_funcs {
-- 
2.40.1

