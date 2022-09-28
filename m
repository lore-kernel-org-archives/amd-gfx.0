Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E8AC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC7610E505;
	Wed, 28 Sep 2022 17:37:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475CC10E505
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duMhytTSMG3sZP0a+64lkdGrwGnSPmgkfMVix3B4ZzGA1cMbxAl8zBLFKvfE/cCm/4AOGRje2nJvmqhv8ZjHOlah2+RvGILI9dQa3R2bJ915IVWicWOqTgnkzy9WYDf8Wf9je2qYvflrRS03HU+2ngFUJH+ZtOdqXVBG0USqlhicb3eJwdL3DmSZ08mvrYh9mhLjplQZ+rS6554eG6ikl0yN6aJZdWiJDPjq4TgVTJND9AnRL0hZKM32YPhT4jj+/ye1e9+mQfUlrZ9zgpBEIYvo6jJnhIwJg0qoZnrwPRIiB+624HUIMGM5Gg0YY92KBEaDnM1g/EO2fwKYg2TrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lb7+Tqtrd3Q2+M0JFTo3dbIJjplOvBMeqCvzgXGkcc=;
 b=Hv02OdveIIdUl+rMDzK9hQLs7I46V/em1cJubWIpZV6vGjV6CTuZM7PJP02x6HN6rMuawYqqwJADcpONTf1FcIPGvyR4ik+/nuaJOGj2NT4nWYEJ+tM07h4FK0crTHhE49GBfgzEljLKevQcrRxtAH+C+589U03GzLnQQZg6uszm3C1p1dKtOpCMnUGZ4FTFZZtEWsPGdAtR2Q94az1K3FPpmtIKXLAsJwALVYXXbUeE4syTlD3g+eLK4LfWjUYtZtadyZREpzBRmaJhyPHkTITK8vJ/HcF4rnMFQFKbuWVKFQaTTyxIbnM8sDI7n9jI4VzPUUMdq7HI7i0mnDyoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lb7+Tqtrd3Q2+M0JFTo3dbIJjplOvBMeqCvzgXGkcc=;
 b=oJX3r2YE2l9FMXJ1EfB+IZ4ExGYpMIRjB84zbciTUeLSUHBm0jiHttFwhisD6so54Lf2eHDKf3y+h+aW9uIXjpZfxQV1ENFfOSr+1ttDbY0sk9hEKR0d2K1HLCgaiHyxutg2fazc7k/lOuTeIAxMDHFOD6LxSqIqcHjtv6vHwdo=
Received: from DS7PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:3af::6) by
 MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 17:37:32 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::30) by DS7PR07CA0024.outlook.office365.com
 (2603:10b6:5:3af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 17:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 17:37:32 +0000
Received: from VC-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 12:37:31 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Date: Wed, 28 Sep 2022 13:37:33 -0400
Message-ID: <20220928173733.12457-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: ba159c81-4ae4-4444-ca68-08daa1781fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htMIe8JQ/HfguGI4pQ7f0A2M5o4Z7ChgMKSE9aIiiXN/VcFfCZjbByl+BRCBCFrrQyl+mY0BFk9WeppJoGk4ljYO3Bd9M1wY4iKz1OpwPgl+6oDzf5Bbu6bt5mAbbu1JymhEj2ILVkEMchRfZYZrcKh67MmOwyy07CeTN8op0ibg47hrzz7Va52vDephnPuMeskH4bFtq8YqC48VJX/4dWfwWmMW6Ald/QV9lnaiiiTKcPkqHeMHU+mNd+v84/8P1FNnpGy9XBqbzk8LP4O2JutA4iR37bz8g4ChBsWOwSRWLA45HekXVQ6qGcl/zSpubNWe+jWBLUu18RAXNIDt6tYQ/TEcDMgf9q1RNHWQ7E+7zjQ0AeiO24D/OA2E3bWw2nQ5lqSqi6/vtpdKMqN7d/1jEVL8fJ9lVPvq3jJVNdB3U965C1o3lsqDobEQc+dZj2Y19mZZlnh3+b2Fn3btLFpPWKrii2kvjHKRzepDLJAXshsaepERLSRDVS5i00mhysmCz+em1w3+NKpE5HCmFWQmXA4Fy8Tb4JvgD/na5Ur29gxzWy3tY0hqZUamgkPDYwx+Ys21/v8/dPLAvovq0JMWZPRWLffZSulsd0Ps4i1Gy9XyUswNPpnFHzuXAGzgUJ4XSrCCu2zmWlidETGdYuhmpzJwOoZ8UZyj9KOPsQORSQssryF2v/tgKZGvDF/JTxq97eEWkzMSNXOZSpNdZIRKFm/AoALgNRHDi9257QnGdoV/qOBYCOKA6n1JHbblg3Ir6+bIKKzGmklQ0MS1HAJggRm0u97gUIUjNjoZWTS4xwZmCiMazVn3xiQ+cwRK9aLv6l/bTLj6bUJdlCcfkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(336012)(316002)(7696005)(426003)(16526019)(54906003)(82740400003)(6916009)(8676002)(26005)(1076003)(186003)(2616005)(36860700001)(86362001)(8936002)(40480700001)(70586007)(41300700001)(2906002)(83380400001)(47076005)(4326008)(81166007)(70206006)(4744005)(478600001)(40460700003)(82310400005)(356005)(5660300002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 17:37:32.4187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba159c81-4ae4-4444-ca68-08daa1781fa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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
Cc: Vignesh Chander <Vignesh.Chander@amd.com>, Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: Ifd6121fb94db3fadaa1dee61d35699abe1259409
Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 47159e9a0884..80fb6ef929e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -217,7 +217,8 @@ static void amdgpu_xgmi_hive_release(struct kobject *kobj)
 	struct amdgpu_hive_info *hive = container_of(
 		kobj, struct amdgpu_hive_info, kobj);
 
-	amdgpu_reset_put_reset_domain(hive->reset_domain);
+	if (hive->reset_domain)
+		amdgpu_reset_put_reset_domain(hive->reset_domain);
 	hive->reset_domain = NULL;
 
 	mutex_destroy(&hive->hive_lock);
-- 
2.25.1

