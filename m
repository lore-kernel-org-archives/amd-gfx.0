Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E325C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 08:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7398B10E0D2;
	Mon,  7 Nov 2022 08:05:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518F810E0D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 08:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXlV0lIpG+7up+jnCQSBSr0NKnK7hVk3fjORFw0LrW6S0YPcDKYXmiYVmeSYRJLFYZkGBdpwThKfynWgNQopo1Om2QbpTUtGT3EcZnyKzf0GWx20IvcVrEBlbhp6GcuC3sCMF98P5XoUEawnZF/4lOzIr8BP9mOlg3l3VYkgA98LYPDW/z26nadY5IrB5IN/aShHiUoeYGUEM1V4BB4SxzpdDaVmvx2HFIHv+e8hVQKnToyRmUuNdRAX0/6KaQnPrJT5yOwidBmUeYOR9b5KdRGKsxqmUyVedrNdUEqWjbfz2W6FeN2lrGjz+N9IGAor+88DwVVsBdNUnB3mbdYKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLFB4MKrZ05ZEA0yg0cPzK8UXckDBkutwRJCQ1c/rhY=;
 b=HIhPLPdhX77sx+SaBIMtIwVUWQpb4gsEHz27A9QE+ksu2CkB7wWwiNPR+7YRgckH//jcysjvDjuBRuHTuRn1S0w6MRqaxww6DpNF3CPbCSszBAo6WykIaqm6t9OiSclxZsmK+W9mMxt+1JM9uZpNgY0EFRgvYNG2lqSijDfTnFyeEItZKG6wZOSQCk0fKKnxJQjGsNT1p0Pr9BXYUU/iCEKDsN5K0lVtnlZ0et6MYpjBWElyjCSt3cJ2UBACa3s34pE+y4ZLENSbtv1nFQ3j7gfXSYBs8q5ybEX1ZlBIDsHqZW6hxwmic2BNvBUUyTWQFkUyPX9shu9/P+OsgRyyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLFB4MKrZ05ZEA0yg0cPzK8UXckDBkutwRJCQ1c/rhY=;
 b=uPR4i4/JdlTcrJsSwOSgiNYq+AYGoaEf8w38aSoWS5unyIG0Ixx9kTrRmsqxWQUv31kRQtFI+yH9zbn2g1cXfVAwqG5W7zP+Xlz8ddj+Kvr1myl+lTtCnbZjjriHzmCymLwzRaec7qLRGmnu33FapkJGGOyhM1vECaDZVwdKiyY=
Received: from MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::14)
 by DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 08:05:41 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::15) by MW4P220CA0009.outlook.office365.com
 (2603:10b6:303:115::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 08:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 08:05:40 +0000
Received: from ETHANOL-3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 02:05:20 -0600
From: Krunal Patel <krunalkumarmukeshkumar.patel@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.2.7
Date: Mon, 7 Nov 2022 00:05:01 -0800
Message-ID: <20221107080501.3205127-1-krunalkumarmukeshkumar.patel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|DM6PR12MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: 69baca2d-9a5a-4954-fcfc-08dac096dcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24rRi/Ad8QkcILdVLnGtahoJGH3KJWwi16bQ0KVf08/M7yCmL8Ls8NAyl7bEHpOHglhhYNcjBHfux8m0KvgUZU82JWLPGrdcaKVez+hBbZIIOpD/ep7DYIo8HsH38vNvH4Cp2CK0D3ZkgQDmgTz/hPmnNa5ELlnd0plPz7CTDa7SUsqJXMUumYekDZ+LlFASwlLbGllpIC+gofZBzQNbYFaTD26dox51TnCa6+ryNQM83CGhTdeYLNOXXdB8NJ9lt/ToelaBi6IgTBQqaUR1bwBgFKBQJa8P2/hx2zYA8YsC4D4Im0wVRk/UM+P57/3Bz5MrgisHtINSML0fqB7NzIGN5I+FhHge6euWch3uSly+whM4ft6rckKALZDrM+p8NznIlskUOb/8/CuanM5yK1CmW95588o+PnXcoAxRUA5ckkdqtMPomnOAzgGXtAqSGeEj/vgqm97lcHJELsoA/GhoV9jKstkn91ihMr0Aj+H2iF+TZShs2pYb5Ix5tE7GdBo4H5bPlqMJzaz/JkzRRvWHN01B42chmF3Px9bNd9BW+XZrhpau/hSOvWJO8INrPWiYm8VAe3e28bXAWDOwuZI7X6OwbPh576Vgl6+Cng0MtfYQJcx+sLxxDtMmJ7WnXv679yx35D9WWtP0WqEZRgGUy4Qa9tj39m8ynq9g5/G5L2EJnx2ek2mZUoO9HJGClBWowBsAxOicA1Y4sYnv8VlRS0a9PmyJk+2Ma1vy2HYu6CQK6TWd49nayxKfBzJ5+UlINsKTY7hRCHzUoRL56+cbylFiy8OWkJZVqia6cGP7DdAq0Ly/e4o+ubag7Tcs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(86362001)(356005)(81166007)(82740400003)(40460700003)(40480700001)(2906002)(426003)(26005)(16526019)(2616005)(186003)(1076003)(6666004)(336012)(47076005)(83380400001)(7696005)(36860700001)(70206006)(316002)(6636002)(54906003)(478600001)(82310400005)(8676002)(110136005)(8936002)(4326008)(70586007)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 08:05:40.5341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69baca2d-9a5a-4954-fcfc-08dac096dcba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
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
Cc: Krunal
 Patel <krunalkumarmukeshkumar.patel@amd.com>, amd-gfx@lists.freedesktop.org,
 Shirish S <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With this change it will add support for clock gating for sdma 5.2.7

- Additional changes are to re-arrange the chip version sequentially.

Signed-off-by: Krunal Patel <krunalkumarmukeshkumar.patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 809eca54fc61..404b255cb4e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1647,12 +1647,13 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 
 	switch (adev->ip_versions[SDMA0_HWIP][0]) {
 	case IP_VERSION(5, 2, 0):
-	case IP_VERSION(5, 2, 2):
 	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 3):
 	case IP_VERSION(5, 2, 4):
 	case IP_VERSION(5, 2, 5):
 	case IP_VERSION(5, 2, 6):
-	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 7):
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.25.1

