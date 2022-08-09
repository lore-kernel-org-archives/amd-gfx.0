Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3153CC00140
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 03:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15989C01E2;
	Tue,  9 Aug 2022 03:21:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B164AC01CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 03:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOASzlXLAlRmNilNU7vcUUVXfllMKWBjUniqhcFUF27rLDgrrwRz8j+94jFXulpt5R/xuN55/F86B282n7ou2uyjbggK18/I4AEQKnne9i/VeEcj2yyXUsVmLgLL8Tl9PUSpGVwVWVXgofyjnKDrHCd4qHSoJOoaQRwoLk7icHYWx+7HillUjZBcIW+ptmA2lwcx6bBPKlsWOqUm4caQtB7johwHXvi6iN0nQ2qlI/Ogc6xwhpOtYb9B+LphuUiRa6VfKPFZFH7rn1u+yXcLX1p4GC+lOhYHv/upTJapheBT1e++vZj9tBr9DftZIa4LIlvXC74nfWA9cXXGMoCK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VljGI0bhNE+zYBWCs1bhe2ZxuPMQ0ZBoBYVfSBhgPNo=;
 b=ZkTNKqiVspCpp2BFuUm2Yr+kTK83XGI3nZnGnd1ett9lyr9PqwcgmXCK79ZmdIwXbFJvSrDMmo6ucFc5mOjzQ7TClVAhTuTn+jWmxJ3hqxDi9GkLCQ+O5P2I6CqHOaS9DPC/fJi0mf56t5svir/vEGfhUfM8sXsUfhMsHVzJQKKgU4wCyLbVAGu7N41dnr2OnONQemp5JP85FAuHNZKH7gtXsL95ljeTfcNtx62+j4PKr7h6BPgn1LKydmB2e2WYIbfDektxnMeK4PLeIF7cJI/3aLoW4R7sjiGhxPytLpfxQaOKd8toHikh8ryC/Fg6x/p7mDfHV3XCVDJfDjXtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VljGI0bhNE+zYBWCs1bhe2ZxuPMQ0ZBoBYVfSBhgPNo=;
 b=SsjSEAyMzW/r4+Su95f1D7D1Pja1eSK/sVCe2uKvv1HHcQPssN2jLiGDb+DzLJuteSwzPKUPOIkvhNqEm3i+BIxSFdm8V0xZ2acyni4fuIwiuN05D34wLHqOzFOwoujSsCaRds/JQmFnR+utOoftYSsrjJz6KOSR98eQ6kQ1OwM=
Received: from DM6PR06CA0020.namprd06.prod.outlook.com (2603:10b6:5:120::33)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 03:21:12 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::5d) by DM6PR06CA0020.outlook.office365.com
 (2603:10b6:5:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Tue, 9 Aug 2022 03:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 03:21:12 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 22:20:42 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: add GFX Power Gating support for GC IP
 v11.0.1
Date: Tue, 9 Aug 2022 11:19:56 +0800
Message-ID: <20220809031956.3162090-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809031956.3162090-1-tim.huang@amd.com>
References: <20220809031956.3162090-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc839ab1-d4cc-4908-f972-08da79b63601
X-MS-TrafficTypeDiagnostic: IA1PR12MB6356:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPaKX796LxHGmfQg4Ceu1Nb8b4KTi8VqFvC8y69JJbTsMefbxQ4sUp5hI0FFR15Ll6Q+UeV+7NsBrooSFCsv/FESa6hKseF5bLWXy/o2vP0HPfb1FChBNeTVUNmG9Zm4QApkgNPf6KCap/TshP0AHB4PZi6R/LCQ0aFvv33PgImOKf1ttKe2qheDbiep5CEeJI5HvCGVAJj6mDWA/4wq8AH2EVp27QnnEdAJ2bwN6dkN5791EWwDjjTsJb9k54Tzmui+YcbXr2b1Fh+JSlwTFGsJJKYT/HYFTjwraCpD5bCWeIuEzZO+3QZ8K89LJYtHyNLCSOXu8f/TXOsX49NuDMXk/zf2Xnn8y3uA76n3wJp79S7v67fVaUBC9+Rf8LLnUaAOmhhqPNtRqw++3RjRkZR6Ru9fbgEvqUUGiAeXuUqZ2pxEonPDJCcWYc8J5bjF3rqzTAx2BcWPb08W++E6/QWu5UgBTHDByFF8OilCfj5fHqTSV8adiMHlgWFE4UxGbKAw0oC4Dbm0HHTy0561Y0bUxKLsmlw1fOj3Z06KEcZdH9CUBWjRnNMChrYLcVDYZIYDIb6iGCPuhJfA4EuIpc0Aq7u733uOO1mCLEvroGTJtYpVXib+9syYf39pb7nqevuIK9YQQzAchZvkrUCmunMM6bH6FdT7rOQNehQ3OGLnety+ZOq7T6lk9F5XRKGCygIbaSgX5A3o1SlC93TSqtedueplUhmOleanovHGF+X8Y8BukLH07wrKe5jjfSsWyjIIvGG03JZXGtAOOJhAHY8dPagzjhGuiplvBS3XEzj+Nv22WWCcXlwfzZThG+Z8vfgl5/ze/VjMiBjBQo5eJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(40470700004)(46966006)(478600001)(6666004)(41300700001)(26005)(4744005)(82310400005)(40480700001)(54906003)(7696005)(2906002)(44832011)(86362001)(316002)(40460700003)(6916009)(36756003)(2616005)(16526019)(336012)(81166007)(356005)(82740400003)(70206006)(5660300002)(36860700001)(1076003)(8936002)(4326008)(70586007)(8676002)(186003)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 03:21:12.2360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc839ab1-d4cc-4908-f972-08da79b63601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add AMD_PG_SUPPORT_GFX_PG support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index b700c6cb14b4..bbbf760f8ad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -595,6 +595,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
+			AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
-- 
2.25.1

