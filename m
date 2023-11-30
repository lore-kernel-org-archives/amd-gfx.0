Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A531C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 00:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED02210E69C;
	Thu, 30 Nov 2023 00:21:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893BD10E69C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 00:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfxO976ZdYoi0GClTdJXvIpp8MtdknQLUQ+FuT58Jv7roClWUpUAg3/Z1Xd0ljNTFxcN3nj+jpjLUeVk+JM7mqYvxVxOw+N91Ba1K52xxNdbnm5hnNu7wWp4muRvzBKsKCXs5EInopVL8lg7ctx20DznipV2OF6xUKT9FVim/Qpo2HgkakG1d0A8PfwzJtjZHCRpfWgB5UK/KXFCXLfnSawvJPLdPJ6Gri0Mm9yMAWcSL/jwB2wG7QjMhw2Lq1ozIh4wB31iA3F16c19dHllc7hZdzZ7fNVmLo9YeRQrgDuL2cG4ozvpw9BuaiVDe28RFfS+vbNB5EGplnmqJHS+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G42Cd/MORln2k/wc/+OKz67vKc44bmK3xtIo64yKuOQ=;
 b=DhckrBsjIfpppMrnRPqD7XTMFukMY70m41SasMM6V+iQ3lmAjGXDyQHdTlm4Cz9MOCqkEkS8GclAuLi6EiFYhVZVqfc3m1a5TwDuRneTyldY0QCyQMmTiBNndxxmF/UCc1y/YOwKsTurDafLVtwoXb9MymC9qqOImHBRu+fvcwnqeCRtKBZLWOq/CHca7bSomykEEBvpN268bPZgc5IrCjyJQgEy9mXUcxvY9GJC81ZA6/tGd5AS+YUHSNXIuTqweNtejJLo6IZUq0ErRw+GuZuVUMl5WSqD0/byX2FGqm/kbpagZ/yDLOwwk4zMBMc4Aul+5QKR+nx4QlBb3vnlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G42Cd/MORln2k/wc/+OKz67vKc44bmK3xtIo64yKuOQ=;
 b=v3ehppvjr1nMy9U+ShkM0jJjc1DcQmbffakEaPCWpLRD5EKM1oQ7QuhcxgWtfyqvI2e6Pkkvj5QaUw90DA5xTknklOamT/YnC9LVjFteWlExDhoPJDjqfyhvPctYC9B6gWjJDgh9m0Ihdej1GCqVtMeTEz/45ayj3PT/2xP8r7M=
Received: from BYAPR08CA0068.namprd08.prod.outlook.com (2603:10b6:a03:117::45)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 00:21:23 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::1) by BYAPR08CA0068.outlook.office365.com
 (2603:10b6:a03:117::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Thu, 30 Nov 2023 00:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 00:21:23 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 18:21:22 -0600
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd/amdgpu: SRIOV full reset issue with VCN
Date: Wed, 29 Nov 2023 19:21:01 -0500
Message-ID: <20231130002100.113028-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3776b5-3fe5-4c9b-52cd-08dbf13a48cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CL2Iu9mN036X6ad7COngCCHBxNigj0QVGY83qPEyM3WxleXhMJg1ynio1b4vzpHygQ7VUqZOSkk+mVWz2gRSxThfS90UWHkkbmFHqwgnJgbH/u9I32L1cqxN12G5xj/GAJMfFHl5dY4Nai81rgtBCFd1mOmlK9GttVKKYhiIymvQtq1Lk58WnzYX8LG+UdjamacTOW2k1dhdxH3dCCBa58MGLhf5gRdG2LoPe3wFAb7lqBAsyfDE1dHw68llYLUpwquQc2LTyw9UOO1whxicJzAg2/dtCeFhIusjyMkdOg9cYjnA8qrAa/RWd5kXcvTy4Q48HBebqAiUcvEaiN2CyEzM5nT632FpYj7NhBRpihgopIVDmF2UwYCsOI/0/MwyZEAtYa1tPkEAO0zmzUXae2Rqj5TGc0bCU7faQFG03TKoIhsjHjdDfNlNphCdbCqwj94ldSKO9L6eW/Ve+vSUzOVYTnYt5eJ9MNt8wgf+sysJa/VpuLZYUMktJ26647PGQXbearVBiaQlG2Ex82uF9MUpSYpeRYpi5KQJEV5VRbU12qo57eh1RJacf9IZh1HDaW9H9jn4Ug22TkzmF+8jMfzbihha+PZ8DFPdWSGbhh2aV3u+wlc4dAXpxeynjl91GTiGdGZO3204t3y51SocWcB7afQa6PFvRbhlcMLGUUxoVfc6sjwV3OdlRWR7JIYH5k2nJvyNR3ZqqO6gLTzr1W4CdwFaXvjBz5h1jLhTobCN9OfmdNMuVBr90R2GaaouyHJ92gP97vjssfWhCyrh26H1r1vHazdnsaZRG/La/UOCQJoaW7VmVYHKFIAzq7mH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(356005)(47076005)(81166007)(40460700003)(16526019)(26005)(2616005)(1076003)(70586007)(70206006)(54906003)(6916009)(316002)(4744005)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(44832011)(41300700001)(7696005)(6666004)(36756003)(478600001)(202311291699003)(82740400003)(426003)(336012)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 00:21:23.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3776b5-3fe5-4c9b-52cd-08dbf13a48cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- After a full reset, VF's FB will be cleaned. This
  includes the VCN's fw_shared memory.

  However, there is no suspend-resume routine for
  SRIOV VF. Therefore, the data in the fw_shared
  memory will be lost forever and it causes engine
  hang later on.

  We must repopulate the data in fw_shared during
  SRIOV hw_init

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 54b03df63a51..b71590b67e20 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1280,6 +1280,9 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
+		// Must re/init fw_shared at beginning
+		vcn_v4_0_fw_shared_init(adev, i);
+
 		table_size = 0;
 
 		MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, i,
-- 
2.34.1

