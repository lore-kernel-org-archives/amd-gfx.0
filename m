Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37C0C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410B310E405;
	Tue,  9 May 2023 22:20:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1C910E405
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRbP2Um4z5OoReNY3Gaxpg/iyUKrPUXcyiQBVLxtKPUEsGZDnWgWG9aRlUEdoUwUoZsOb5OPj54eQtanDkXh++9GvycDA8EOcK194HInAeRrGvRfZmzpO5wxYWcquPZmfYaMeSsAyMFmqrYWYASyrbRGqN9z8/MjxfgTaSacgvQ7E2i4WKW37/fLVMacELtvjis2ETAi5Td57CuaKk2E6aC63fvY7GZX9TYyTRBCHGxRLsOLHhsWAO9LIXtCO/sjm/Y1jAK6i17l1Gi6Slzf9eRoerRVjv/OGyd7Icz2Zl4zqy3c5sfIBd31FKuO+UPUYRbqYq7TwNQE8nVfS6iO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DlJsneYGWExtHmpJpoyLuB3aNTwFPLTaNcTAN9grd0=;
 b=h0yM32+T1hvXDeObnuafQLDhN6WCX8OHl+zLy3fhBQS8xCvBbFKWafd3oT6auTIXmJsu0J3IPR/yRLY7DYKvuFmeLkt4SuR6CSkqT3aMb1caVXLjJYyUAl5BA9dtVZLoAibjnz2AZ3V7h9pd2gHDxCPRSoI8BuBp9ioEQK4cxtpgR5l/EZcIZekC6g5oBU3DJfqUYV+ZOJFGsJTkg8Qxe0aFUc2lKOlPwA/TmullV8QZJP3lvyMlghuDgBjN+npfZwECf3nPRG8WkNoNFXOQaZ4Su/Y9EHa/XjN4jqI8S0IW2bekmQo6Jzfi2BZtWtkz6NGq68eNzTnOQMMoOgoykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DlJsneYGWExtHmpJpoyLuB3aNTwFPLTaNcTAN9grd0=;
 b=l5KDxRSQMhcilS9fAboxczYLC1Fr0bR+mCU5uHcTRgPCCk4sSMeR+V1LGfioG3hJ3JdZjC2hzyKZeJ4SLR8blMRrVM1P5s2lhtYWsb5ygDzTxUjPB5p16RGKfp49cOd177rPYhyH14Tu7dd8A+lnWPhS8GYTS0EQHQx7TFM+pRo=
Received: from MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32) by
 DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Tue, 9 May 2023 22:20:29 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::28) by MW2PR16CA0019.outlook.office365.com
 (2603:10b6:907::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Tue, 9 May 2023 22:20:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:20:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Skip using MC FB Offset when APU flag is set
 for SRIOV.
Date: Tue, 9 May 2023 18:20:09 -0400
Message-ID: <20230509222011.477547-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222011.477547-1-alexander.deucher@amd.com>
References: <20230509222011.477547-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 389ca096-874a-42cb-4007-08db50db98ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qHs8NONEW0c7p++3gNc44NajgB6HnEtvuzenrfSZCRVri2FPCpHK/Q65M6P3DKBe3w595+Ns49kZJES8zsq5xuC36JfVreYVKSCbVsbG8L9fYuxTiZnBaNpl4svW3mg1lO0hxls8u+NdpOSTtVZuNlfqXnkEVZarfQlQmRQrVQWnaG5HXIu9iQCB6qKnBtXIXQ6F1ykwSNdzZUnXjh8dzA0tmhZc9RQKF+J7ik2AKmyZhzLG68UOXNpklMZILUmRkqyQfawAIsNMnn6P1tASTcpKBb549zN6SZWIWcRM9BiaUW3DKY68o5JH+4O5EZspdcpEXlk5H7e21GC8+0L7UThGBO7rH6zOxzs0jQ0+Tyw76IeWXwQpG2GC0ymb3eS0sdNlqhbiDW7QhHEZyPbedU8uuhLJqYM8lgVgwFT1OcPThIC//TVUSiaq/wNOYDSw5UVJOM9ZXsKSNHgRw68oS7B1nr+TvKsRz69zeoA15OgDBS5BsAUrzAY3gppCv1g8NRjYtEHvVg9VuMaBDz3wuhYO+FcVUQHPgMdBPEorir3yX5wqJXVsRBHKAibO0+o23krf7N8bAhrs1QTYorSNrpqH3CFDJV6kdIIpkvac9LDKhe52sgWgHI033L4iz5nm1B9soZXWNpWoyyc3Y6/kTy9ZbHdPEGq82pWPtLiAyWMs3bceuWcGtJqvq17/8MG3ABnlUhAIMGMqZwXegKV0HuS/hAggp2eJbNidFs+LMM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(2616005)(2906002)(186003)(36860700001)(336012)(86362001)(6916009)(4326008)(41300700001)(36756003)(16526019)(70206006)(70586007)(47076005)(1076003)(83380400001)(426003)(26005)(5660300002)(40460700003)(7696005)(82310400005)(6666004)(82740400003)(81166007)(54906003)(40480700001)(356005)(316002)(8936002)(8676002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:20:29.5330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 389ca096-874a-42cb-4007-08db50db98ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Gavin Wan <Gavin.Wan@amd.com>,
 Zhigang Luo <zhigang.luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gavin Wan <Gavin.Wan@amd.com>

The MC_VM_FB_OFFSET is PF only register. It cannot be read on VF.
So, the driver should not use MC_VM_FB_OFFSET address to set the
address of dev->gmc.aper_base.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 393e90d8b27f..394644d9d559 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1644,7 +1644,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	 */
 
 	/* check whether both host-gpu and gpu-gpu xgmi links exist */
-	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
+	if ((!amdgpu_sriov_vf(adev) &&
+		(adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
 	    (adev->gmc.xgmi.supported &&
 	     adev->gmc.xgmi.connected_to_cpu)) {
 		adev->gmc.aper_base =
-- 
2.40.1

