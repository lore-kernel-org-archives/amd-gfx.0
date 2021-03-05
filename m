Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC54CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 09:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D8864F5B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 09:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D8864F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1B66EB1C;
	Fri,  5 Mar 2021 09:04:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDC16EB1C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 09:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSr3PA8a2yFR+GXr2K3d/zPodcSYGIVZaBptNHVyShd2p+lfk1oDe2r1RM0Uwz5qcK93TuB0DkA6bnJrFHekeMHyjHXo48gxo7re8e9iDEqecB9NougnOZwUPY+wm7BrB6pDtOxvVr4KZ5mmgoMYXdFRkj69tOPgpVbv7z+0f4qs3R0BrlbxemilrbxQtDUiUjffhWp5FPQMz9Y5WvLBneivSynwMyCCPLasVahy+sCdrrk/r5WlPmL8QPNSasIFb7jBJUTv+GWqvQgsZokCdyWOzF5RRAJtWucCWXSHOqXtY+GQjgX6fiZS87jl8tLRb9RbZ/wM7rogn1sL655m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DghuGGFXahFY6OrylaQC42+dhwdtAv5PbvLNOOa/ALA=;
 b=DTij72RLxYfX4Vg13i09ZoWU2PP985VrylVjpeFn5mfLvi0lqHlyi1j6f0/3BMN0L+CuBQPNWmdqul4vwxqKl+yGXU6P0JMH0T5asRCJ6iT7Go/hSB66HaptTUYUu1XWstzvK6dplqGHRf2XQfzXaDIzIQGoU2A6nT5+AY/H/RAR/oHqUvQrWTeUgE8LrVL/q3GYhJRZQWJd9FBrPAh/CeXyASQK/t4Kduj5QECYuBhRDaXZmgMcigWuYkVozZFserwLtcmYzeENr/kKH7EuZgpMXP8VOonXSfYdb6blZsfV+GLLwQiAqgYNmWHAdmetzp07P0HQO2To+FOQyvED9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DghuGGFXahFY6OrylaQC42+dhwdtAv5PbvLNOOa/ALA=;
 b=2NzcdshIzmH0qfpDnEnIH7myFvnkgYxWrfMH1+NtVCW+EiU8nvMjb6ahHRf7631+pXcYiHqoy/xhwHoH1Din+KZMo0qATpw2imC9Ps2yLodvLMA/lVzquHLaE66T0RsPqRE9/uGlRAZskKfNjHTB5kkQaip05yfThqyHWOAmS9s=
Received: from BN1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:408:e2::27)
 by MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 09:04:30 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::be) by BN1PR13CA0022.outlook.office365.com
 (2603:10b6:408:e2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Fri, 5 Mar 2021 09:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 09:04:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 03:04:28 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Mar 2021
 03:04:28 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 5 Mar 2021 03:04:27 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix some unload driver issues
Date: Fri, 5 Mar 2021 17:04:29 +0800
Message-ID: <20210305090429.452241-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3c7e58f-f366-4052-a6d5-08d8dfb5aed5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1453:
X-Microsoft-Antispam-PRVS: <MWHPR12MB145350259BBB963512A81D918F969@MWHPR12MB1453.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCwgsNauTDi6dPqd8tUGtcvd0vzmFiw05gvt9bEdo19knefR7NVMcRGNMwUXe32MA/OChFpZGgKElnh5mwsvdUCpS3wBAaYvkU24ZRHMhF47jQcLO1oC3P4wTdccOLtczWtD/ng/0MbkXAxrP1PDMFDGPTtVLCG/JGqhjWJ7ea+3Yxc3g0HT0ooWRaLxbGzMSbkRRmeAVVqbz3RM4008lXB7Un8hxg5ad1HhT2lV5l7wTffNiWt0NdXho6E8eZNXFVpaO8W3/kx/YlQ5qbXuAYDMXTmyQJhiF7z6Z9F6JuYt3gChOiwweXlIsFMZdVN1hVMImCGcT2Xidgwe1HZhgZW4MEhCS8b7VDj8LEKz3SXeXshc+20rZLCqy0EZMi6X16jh3TSi5tfGwPi7PGwlPYwWFYtBEElPXLUL97fN8KEA5qiBvTKXk9fDHBgUn5QP1Ftb7S4LM/sUPSD7EFHXEWJOGRop3CIWBrN6NlxFE7eqFRi+/oE5q4upwE34BYtczll6fwWuYPg2U/EoniW3xKmo6Dc5J0MrMij7R/fG1SZ5rRKxYMZdvITQ1SjCvxzGKhDPBBOtPoWWUC174MO3P3OWO/fKRS6jXWBv2GESIPPwmX3D9savpdw7t1bWzK4zKr3G11H+hEOLtje9tqzdaD1Dpx2bF3f2tied+MHXaIUqGAV+1zAKSQVhYGYjwXto
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(86362001)(336012)(82740400003)(356005)(70206006)(1076003)(2616005)(5660300002)(36860700001)(70586007)(4744005)(82310400003)(7696005)(8676002)(4326008)(316002)(81166007)(2906002)(6916009)(36756003)(478600001)(8936002)(26005)(186003)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 09:04:28.7787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c7e58f-f366-4052-a6d5-08d8dfb5aed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1453
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If have memory leak, maybe it will have issue in
ttm_bo_force_list_clean-> ttm_mem_evict_first.

Set adev->gart.ptr to null to avoid to call
amdgpu_gmc_set_pte_pde to cause ptr issue pointer when
calling amdgpu_gart_unbind in amdgpu_bo_fini which is after gart_fini.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 23823a57374f..f1ede4b43d07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -202,6 +202,7 @@ void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
 		return;
 	}
 	amdgpu_bo_unref(&adev->gart.bo);
+	adev->gart.ptr = NULL;
 }
 
 /*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
