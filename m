Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C9FC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 06:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A6460E90
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 06:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2A6460E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B106E990;
	Fri, 23 Jul 2021 06:11:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC416E990
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 06:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnEz3P+SQkIksdUaJmNsj9yZKXcfWiY//ZYrXfne15+fn7TVv4syZzu82KljY5KqvOxiqWakrnX2LiucDh2GSPE2/leKYlb20OKbWo8rDphJ5iWeLhqoBTrfVh2YkHxJQ3J9iRDkYMoVEkw1oRZUXlwV3nfPOhpPtwSJXhvp3F2N0QjB0KSbenbf8EYfzHclWdyvbR7USTZSPj3xshF9pdtfRAGE+nm20LBfbmdeQDBPk5y4v4q6kLBLI0iCwrj+ham6yU/3TwuRrDANUMW9tV1VBkmcuaVd0u9LfFrBbt9VLI4wF7WxuEly3XI65I/37kg9vO2yZ1mnqCNOgQi5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhPjmBJKfKIeb8+sUm+5T7hpNizQkoXCLpdXc2hRP+o=;
 b=oRE1TjWHdNmK1ihxpOi9FaHB3FmP/FMcvdM1S69TbksPh598DntgwSPyxzkWD9HjYw0ynld3mBOje/w/bgZKZDyGn7SYZJbPC5hPoWeDJ5wBgPaCURAyxY67k6GU/TcxMsGdPSOzs8gC/Xbk0XQxZMJ0GEfflNmE+JfOXpNhn07JHRe5StqP8Q8aPX1m9KCc+MkPk9f7W+OZS2PGIUeSZX7fy9QN4Ynx7ZI4NTiERIcgai5ZkbaXBLlkCPYSSlEOa6pIb5Xq/WyrGjn2OYLI0LQhJnIv28QYO3Fiu6c+qSOMJwtixmbHwzTY+fUcMEljFeESPG3dFtTZAlzpC3yIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhPjmBJKfKIeb8+sUm+5T7hpNizQkoXCLpdXc2hRP+o=;
 b=ym4R8vHI0F3t301lQjeKJRCbsBBiMCWZll8SEz+uRvv+XTPIIDofSDbqInvWB/r85ZsNXmSPdJ0PKZN+aIZpx/8Dp3EMm+2GJR4Xg4eX0x2XfwplUXUh398oaRWS1Gw82M9P3zqY/LEPkoHn49tWGhKi6uDA8EFWz5vH7gGD/nc=
Received: from DM5PR05CA0015.namprd05.prod.outlook.com (2603:10b6:3:d4::25) by
 BN8PR12MB3636.namprd12.prod.outlook.com (2603:10b6:408:4a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.26; Fri, 23 Jul 2021 06:11:19 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::2e) by DM5PR05CA0015.outlook.office365.com
 (2603:10b6:3:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend
 Transport; Fri, 23 Jul 2021 06:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 06:11:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 01:11:18 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 23 Jul 2021 01:11:17 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: retire sdma v5_2 golden settings from driver
Date: Fri, 23 Jul 2021 14:11:14 +0800
Message-ID: <1627020674-2338-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66fe118e-a12b-41d8-60cf-08d94da0b01c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3636:
X-Microsoft-Antispam-PRVS: <BN8PR12MB363661EF3DFA284D166009EDFCE59@BN8PR12MB3636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 026I0lQ2uIEnmkSk/gN9mIMWwGtg9KfCr9g11v1PEQVhBmwN736bV8/wlJhwzPh6WCXqiPwCibPZaAHiyNTdz5e9ttpJsTAA3lOsaNcoxRMVXW77L0pJ9cjlW7tAYpu20mzfcpu7REu5qEy7H7YGeZWYLrRteuYdz8MEvZZST+hzGje6ZgL0/worFnpe1cvuhs3PSUnyFOmKR+MtV0qLV/FAGr197Rl+R2fcqVW/bBz2czyzDcVpvopBWamwjdWPQB75BqIrPlRZv0fGvNKJLHeXJ2QwRdJtdfJ61NKIF4xFAw4TKWjfh/+/iAR488LqxT+LNQgmDJ1orrn54usOvvWe9mtxEb7HXoT2dFWh1v/VO7e5mHcbaVO0+N9IJpU2QiaTCeinDMurUnzTLC245NnFHGlMftBc5KesIyALi15lZkRINfal3TuEN6M4gxB3lZhfJ0EiTAw4jNiJOIeydnhxN+8Yq2k2q8CwOc6UgcVAzHUbVo9ytenRVOBtwa6EaVVL3GhItTNdMfRJDBOzx/TE1RPQvQSFw6MV77pdMIdyEHVfinf18jC/rJH6PtBSRUgKqhcU8kpe01ASg4K37zZEPP7q6tp/0d31c9dBnH5f1ZvdxnY+ND2clkUxulH3hI65+RcZg3OO7wGeXIsy/Siij2MeQWzcycVY/+pPHOOy82VH2wnzggxIAw4UdJxyjcTFIi+jUeM5ZZwUhCoyj/ufFQXXOap2MwQrhlacwNI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(82740400003)(4326008)(2906002)(8936002)(478600001)(47076005)(82310400003)(426003)(2616005)(5660300002)(36756003)(6636002)(336012)(36860700001)(316002)(70586007)(356005)(26005)(6666004)(8676002)(83380400001)(86362001)(110136005)(81166007)(186003)(70206006)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 06:11:19.3302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fe118e-a12b-41d8-60cf-08d94da0b01c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3636
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

They are initalized by hardware during power up phase,
starting from sdma v5_2 generation

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 7486e53..779f5c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -87,21 +87,6 @@ static u32 sdma_v5_2_get_reg_offset(struct amdgpu_device *adev, u32 instance, u3
 	return base + internal_offset;
 }
 
-static void sdma_v5_2_init_golden_registers(struct amdgpu_device *adev)
-{
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-		break;
-	default:
-		break;
-	}
-}
-
 static int sdma_v5_2_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)
 {
 	int err = 0;
@@ -1345,8 +1330,6 @@ static int sdma_v5_2_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	sdma_v5_2_init_golden_registers(adev);
-
 	r = sdma_v5_2_start(adev);
 
 	return r;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
