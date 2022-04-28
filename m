Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECE7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0597910E890;
	Thu, 28 Apr 2022 21:30:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D29010E890
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNjtDTlR/h8nyZzePugARPrFuuxoAGwu1x8DorEdcqbn/YalNDvrH643yIXraPuVQH+VPh9hm8EWe0Z6+o39mQorTg38a/5bdoqpZGoCWTEdeqiGjmM0nFz77Q389JlGntpfw2Xxpz4z/irPJ/XTzCKWpILB156X6Kbef5UPQErEdyoR3Hh4i1AdL/sZPc5j0OSLGSCJ/FENGPRutuOxHCtO5TaLY8c0iriPtT1LWOK3idvuszcaDzAcn7eFgmxU29pQCsdaEY3SzZdTGH/06bi7e9ypOObcezWmfGcIivzDVxsZpdw4SwY/bwhCWuTuDT/m8tFTq6X7ADaYaqMsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI0a5EZXvgAAzKlBL8xyz6HiVUGBs+8ghsEqz7MnhUQ=;
 b=UQZ4lMh0RRO9XFZLAR7OX11AirBC90aZIQGjrVQ5Xz7BFj/OlL8vmxid/OVEpVGdLTe6pfQPKUefye10Kmycy+qJABfUPg6IxxKqHNKdnazuPMKwV2r3dvu/yfHYUoi4bQC+IO0noKRLp/fClf1A0FY/paeH3EodbNGhKaLkt6w05g1YOiWAOwSlIXfJclJBVoLWizxCQ8mrJ/VXwcPFHajN9xa5FtMxTCRWkK2f5yP0c84QcfU3qkalctStE44hC8pVfDcD30SRiv9UgQab6t5SjAplgWoxUd+fJG7KolBhyD3LmcIv8wONAUH62mg6nAczUW0+ygOESeglL7wUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI0a5EZXvgAAzKlBL8xyz6HiVUGBs+8ghsEqz7MnhUQ=;
 b=dQITSPwao8P25fl7NWWCayaHlBG4NixqrivF9HgioRdGxLCqu4fcmscc4lNoQvD3NPhvC+ZR41Fh0aV+F1n+QxjFrN9hLykwx2Syhh5eShnZCKwPW30wMgaI4WZ7prwUqaHkJFLl+VjHS0wyCoo1myXXGq+9r7qztNvaO4NNf7k=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by DM5PR12MB1387.namprd12.prod.outlook.com (2603:10b6:3:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 21:30:03 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::a1) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:29:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix NULL pointer issue of
 amdgpu_smu_stb_debug_fs_init
Date: Thu, 28 Apr 2022 17:29:39 -0400
Message-ID: <20220428212946.700296-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfbd0221-799c-4e76-1575-08da295e41bb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1387:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB138794F8F47845069AAFD86EF7FD9@DM5PR12MB1387.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xq4azsp3csE97oiH61+ucuQCON3o0DeCeeOymSRspie3npcUysfZkd1tO91gMb+QpyoebJUsEGrC9PAsXWKYkgHbQ1WrvPG8eSr2XV3JS5NP+jOCtS0m9hNrdXWXa0FenAsEJZy/fnFKiEZNBoPQHwibJVJpniPoqPdkzMvtRIaxsJ6wOdnJHYYpSCnWWigCeasvipC6tZwKSPkIfb1OeOYmbg/jRNMonuOq7Yzah0/9hj48h1MfktmIMpCaB3xyEHrhttEJNmBWDUs8haEyO2XOzLDTZWhYDD95bdvBrD2tQ3kNSzqzUm6e4yq4CmmdAk3GGAMXfsifLc1KMuZ1EliKhS3t2Qnz6dNgpcoKQja3Wf7VOWYQoeZjoD/BAXmXIVyaBOvgPoilXed+e2QrZzshuRdnS4HRjOHr8u11zR5/TNDhXQeQdDF3XqGFz2rSlCRMuu23dvBL7z1tmyxz3dnakYcGYB+3jkNvrFYA6px3H0MK8Yz58S5rvqcIinAkU84QGhqs3X4OTQlBwqiAOWBaJIXEfthWKuE5LFwuVdQezmq42q7nAxxKrzyQfwrsSyLtsnAq2xkIAR3Dd6EPHosaAJzwSZE6OeV4lCtDRqIsLX6xHjXX6PMRfKbSigbTBXDeT8VK0dibgT9RRYDSFk8T+sF8r9yOvUY3gewapgVmPoxGu2v6BMKV3UU1KNEB8rqFR4qeruQ+hJtBXLsABw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(7696005)(336012)(426003)(5660300002)(16526019)(2616005)(8936002)(186003)(36860700001)(1076003)(36756003)(4744005)(26005)(82310400005)(83380400001)(508600001)(4326008)(6666004)(47076005)(316002)(54906003)(6916009)(70206006)(356005)(70586007)(40460700003)(8676002)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:03.0916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbd0221-799c-4e76-1575-08da295e41bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1387
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Fix NULL pointer issue on amdgpu_smu_stb_debug_fs_init if SMU block not
enabled.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f1544755d8b4..904d516c040b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3031,7 +3031,7 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev)
 
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if (!smu->stb_context.stb_buf_size)
+	if (!smu || (!smu->stb_context.stb_buf_size))
 		return;
 
 	debugfs_create_file_size("amdgpu_smu_stb_dump",
-- 
2.35.1

