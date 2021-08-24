Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C2C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8287561163
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8287561163
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4346E0BE;
	Tue, 24 Aug 2021 19:22:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (unknown
 [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F0C6E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvHxmv632FIctj38PekAlkaP3TuwEppOrM3KwXGu+XKzTYPSWvwCMkrFQJh+/pTHndkcFaxsKoSUwyX3Yt3J2170IlK5Pz90QPD0GTzdLk2cN/1SGU4toQZnAXb28l32lv1pBNa/351GgRtzb4h2qNagxauSvXgyTcMX3gn6T53kNtc3df3QeygRToSslI6i1BK+ZC6HgjUoqLsc4lVfuLFlrC/LeQUmCnWOjz1EHmW82l2etRc63Ow76c1GdZlBvCIZzxvWhLyEeJXGpN52wv5gv1bWX9zLZ7BZ30LhQAlMEFnbkLYwxaFdxs2GOjqZzZwel8M1awHx5tKTemTU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edOHqBVPFA1gFtidl0BQjYfK8LsLkvFrxJcVFMyX10Y=;
 b=XLZqQknO9C64MXVfMzGwA6Qa8xiKOaumWnzCrK6B18vRh8PFW9IvQxXbabu9D4GqVhfvQull5cuTMylOrF0WhH0GeZ9GRFzB/kfzxX4iBaHrUnn0lXWiq9z6pnY6Qp1VEZZlN0ir5IK6+9Oj4MsbH7qdpHe9fHYk+RJT2PYaI3QyVRkeLM7re9795qrkOrqdQ0YhSYeAuezz29oEUOmfbrRnfczBCs66nev9IZ33VtkjhPHIMteywxdsIa47t9fm6VCZTXTj1vz3hmFa1EbRUNIeBkQKD57UVpzQERj8J77FImJBUOrHC/Zj9O0fJXg1JrP++c2i0/GY9i8M1psovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edOHqBVPFA1gFtidl0BQjYfK8LsLkvFrxJcVFMyX10Y=;
 b=KzqA8Icl9chYMTFwM61hyhO4wGuvKfKM30OefY7olX6nCPF5gnJTqPnFqwfC2Niv4g1O13uM6iHiLjiv/yl9c/Y/bRkGveHt7pJOHAjxPqnRAbmaln2orMmgC2uMPzawwdOJzMZCsgh8gq3GuprjRUlvz3IT28Q2m09STFMCnUY=
Received: from DM6PR13CA0025.namprd13.prod.outlook.com (2603:10b6:5:bc::38) by
 MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Tue, 24 Aug 2021 19:07:42 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::71) by DM6PR13CA0025.outlook.office365.com
 (2603:10b6:5:bc::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:42 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:37 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 17/18] Revert "drm/amdgpu: Remove verify_access shortcut
 for KFD BOs"
Date: Tue, 24 Aug 2021 15:06:38 -0400
Message-ID: <20210824190639.6288-18-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824190639.6288-1-david.yatsin@amd.com>
References: <20210824190639.6288-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3d306f0-34c9-4aaf-9cac-08d9673272e5
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4508D5624384AF436DD8B8E695C59@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4h69RWRomHQV1MhUwytAM7ABnQmBWcNDKMwma5UIWdFz9HZF0AWCtyVXe6iubNSCEOsXrN+JoWWGKTEjlz1bJtnCoP28iat1pFuVIXNLcuQw5gceEIoEfj5F/owU/JdY2tVuvstb+bxeZHEjaTa0TX/8Ifn52barYjfiRwlrkqErAFC/AmmQ9gOUAjeWBL+5nRNQ/jhu7IqumIqz1NVu+FGRCgFOesCtnT3MCgIpyRHVDGdcIrnQlQ8XC8PzRTMhu8l1K6UEgBd8Dhz+LG0vLkpek8Xz2nWWOf7pZ5njMwNBz3aP8QSPkvLKSG3Lew6Bq5hwao4Lsk5irpFXHk0Rb9QsFBI8S2j80SfuN05ambtGpYfqHkrlaI1bzEyJEKk+8Yy9JH5a0rWtCQsPNUeM524mu2g0RM3CODNuSTLB3urs6w8vmORKCRi0nVeAtX5dlNXugePH/MOIJcnfEAYVjqxBEro95iSy+YJYfFgnloStw4CLzE4+MFUu6yxhHJP2XW6ahY4w5QUeotiQ/lIKazfF04R4NvTd467SwjSV0XKMDnQeVQGuieZFXl9OkwRhrVGIWD5EhRz13Xzn1TRD759bD1OyL7c9GwfHQi82+U3jyNe6LEmdhWsGwMoxogUjoQkWBLvG0nMXLXHh/EKI5u1o+1ifpjG0pqi4gGK9TW1Q1ldOgGLx+YPdHXs2m/abusuCURlt+OHQlE8OqZjMwLfDWPSiw8cMQJYQlaMVX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(8676002)(4326008)(47076005)(5660300002)(6916009)(70586007)(186003)(426003)(36860700001)(70206006)(82310400003)(356005)(8936002)(2906002)(16526019)(7696005)(82740400003)(81166007)(54906003)(26005)(15650500001)(478600001)(316002)(1076003)(2616005)(36756003)(86362001)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:42.2252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d306f0-34c9-4aaf-9cac-08d9673272e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This reverts commit 12ebe2b9df192a2a8580cd9ee3e9940c116913c8.

This is just a temporary work around and will be dropped later.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 99ea29fd12bd..be7eb85af066 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -178,6 +178,13 @@ static int amdgpu_verify_access(struct ttm_buffer_object *bo, struct file *filp)
 {
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 
+	/*
+	 * Don't verify access for KFD BOs. They don't have a GEM
+	 * object associated with them.
+	 */
+	if (abo->kfd_bo)
+		return 0;
+
 	if (amdgpu_ttm_tt_get_usermm(bo->ttm))
 		return -EPERM;
 	return drm_vma_node_verify_access(&abo->tbo.base.vma_node,
-- 
2.17.1

