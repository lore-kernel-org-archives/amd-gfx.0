Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E199C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 03:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892E010E004;
	Tue, 13 Jun 2023 03:09:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4704210E004
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 03:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSv89Rh4o/DLcbXiN5KN+1wd8DuyPGv/DXCoQeLAKeMFJ2U5OrtsgauJX6C3hJ/p/ozVqVfM3O8WNSyqPlxEgpyPBEocWfMTRlznF7OdBGVWHMa833YZ3PxtVmTDfrUyTc91ZX3onGVR0/0T5GGZDo6Rb7ZAUge6wUaMvJdSw5lZYPOAy8Dg0wUqWzyhZIZdoVtX5tK/vOv9tbjQ8M9kQvwUZEqW2N2T+wCX9K4Y9lT7klx8tSAR2PkRYLYAI7FrJH3fvD7+LNlmnV8yiWlCFeFwRddZl8eJJHD9ygQu4yikwg6tmchyeCBWn6HaMdGE7Vt1C6ZUB9Y9fgEZEpRUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OTvJUmaIXIOG9FL3tkAA59VZ2ceDq369Nnguvu3XrU=;
 b=Cqli13OjxuTlkiIwhIfiM0lcgVXq1+YL/eJhBZiCZE+buoUcEtrzeX1b+z2JzH7RY/T8jUBhNd/rMYu/Y/vI5yh7n6Kz+m7bRwI7FLfBMRchDxFFYhhHfgCRyRn4qYgHS+HRUy/jeps9vhJ+dca08Fs8m5YidSQLpAbnGQcpKBeng856TPhrYQ2ZRtnyWEqZ+mbcKKHY1LywHgElEkqLdk3BQ1u+7KUePakOETjzfbLchiGoHqzXxHb0ZWXmCQjtYAi+cmQH090REAwz1Ki4SL9Y0l9MlzPUxSTUWD+KTWcea1wwLs+lDNUFQRtNq6DQylwMB4lZsdHYSXM97VUoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OTvJUmaIXIOG9FL3tkAA59VZ2ceDq369Nnguvu3XrU=;
 b=NMlHMvqQuuAUCf5lqNAq0CLBH9sBV/g1ZsbUcYhRJGRVGHYmK3p+q4YER8/nvvd4FNY54Lf2NfHCuyprzWk/vqluoPRDT58ZH7kH/XPEUHf+7xiyv1kQUmBIfyNcCRdozFuTNKkwmHYQCCARWhVf8W6g9/jp+0ZEXhUX+B9JW+E=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 03:09:46 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::e7) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 03:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 03:09:46 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 22:09:43 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update external rev_id for gc_11_0_1 and gc_11_0_4
Date: Tue, 13 Jun 2023 11:09:15 +0800
Message-ID: <20230613030915.485806-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e50a1b-af22-4741-a1fe-08db6bbba451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4/wk88fd2bWRX+VydJa1j6Ibvnk43fImPHDkLpu3T3lfbEd7RBqS/G9Rq7q6GDONelU4qiT0WX0vJLskHsm66GS0s5NeP9CXmPzBywT88DtTML5+9r7mP7iQ/0RhDhHlVq1uaW413xjv3Nv76lDvAtn1o0VwsXlMo5FHW7tE+p7PgRl/PT66XFjjhErQ8dCTqNpT/AHUuZolA/nreQPDoFdXu9GKC78CtnzEJSTEpqeb9Ze/FJfmGukv7wiWf+xHCUYN4+0ZgZ0+AeXBc9tdPpA8+I+l7J/lzX8rioDFsrPXt3dnZGD05tzhdlPaZy7RGilZE6xKcTMdGEyRCxYyw6VHDPgw+DAWw/qwbX0MYoMEtMLEJAkBby2HstttDHRj2l9Jfjam9wcsFfm25tPhHkzn1+JDs7ymPI6+pH+ls3bAc6aTDjj63cCMUdHe/sjvWrpZ7pIiM2T/UFBkNXP5FVmlC4Zo+OYjfOVTEgRC0hDMNV0igVg2dGd21N5GCo/ssyGWPv8svUriQztHOjI8ZaKgtMah0AaGU4YzaKPsyM4BKfw6OCIqEmyxMa7cKKHdY34BulJ2luIGRwGhgzEd//qIv71FZUhzyQag5aEaQhTas7UFw2R/uVMwxUkJ5/AZu91Ph5J3rs3qQBSU3IuT78ItOpI1g+KUDUzp1cBlA4AAqogubinTOzAiP/a2cI6Km5H1QDK+5K7/bMtZM9AFYghFuB1+RVW5eoDmzydC289ZdkaI1jK5YGSNcM4bDx7dFQBy2RQ1CFgIb8iEeI9dQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(7696005)(6666004)(36756003)(47076005)(36860700001)(426003)(83380400001)(336012)(2616005)(82310400005)(86362001)(81166007)(1076003)(26005)(356005)(82740400003)(40480700001)(16526019)(186003)(2906002)(5660300002)(54906003)(8676002)(44832011)(316002)(8936002)(41300700001)(6916009)(4326008)(70586007)(70206006)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 03:09:46.1364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e50a1b-af22-4741-a1fe-08db6bbba451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For gc_11_0_1, the external rev_id of A0/A1 series is 0x1,
the external rev_id of A2 is 0x10.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index e5e5d68a4d70..caaf9da4c1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -665,7 +665,10 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x1;
+		if (adev->rev_id < 0xA)
+			adev->external_rev_id = 0x1;
+		else
+			adev->external_rev_id = 0x10;
 		break;
 	case IP_VERSION(11, 0, 3):
 		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
@@ -705,7 +708,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x80;
+		adev->external_rev_id = 0x80;
 		break;
 
 	default:
-- 
2.39.0

