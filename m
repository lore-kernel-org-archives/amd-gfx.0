Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29F7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A2373D9C;
	Mon,  6 Dec 2021 10:19:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32AD6E0DD
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 10:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPaAdQA/IsJHu+1uz4W+FvmfeWwfEs2ZnCTlibFFfodv5IyTUZFmyvPBCbpaT2Ji0ucTjwYDdlIT/pJiB8z2dw6Wg719v19d6OnjIQGTxbPz6evQV8jS8nuZCxIKvBntfibo5OLREhlZav4kv3uLBLUNGOkpIN926pKJBNUZS5uZfhkF2hPt/9DW9vZCmebFCihOCABcFuRwWR06ehtqzzbeI71M2Q5OUztw2o1LSIGKgUmf3/PKq8zLRDi4S1dQT1xDvL4OuqsuxpJc5fg9c9zx9/DPiHcRFd6zSY3H3gTB3TaNvg76VQ8mSp0JGVqe2A2/iHa71WIXR74CdoyhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmTkEPtsDVaSjebqBV2YicN01w6HPuJ2prY8k8JQDMQ=;
 b=cwMHCuIvTBnrjhqJ7L8z5NzC52B6FJ7giFWyfCzXCinV9ZqdGsYSQNRPuyxEID+0NNgRMm5IUVhugAIyQ7Dj5lv6H7KI6acOiTXt1/e6TPyq1AXJlRHS58kHMlX0fl8iFhEp0+AaWxjvaDsuyOvZz9YYz2C5CCc/PRkUpcRsIOwt395z1saxSXiqcMUo6Lso3mTSaEEWGENpQBsBrXoSIcvUM2wFoVsLqWya0MHtdg7v2hucjrTKA1cM/gsPls1lIeVAqpbZuWoppinNc3ypS/3i9BegsJF4v73BOHBTyhbxAUT3yIZyIJjTCA3WgOqZb/XGwOqQ1l2IYR9VExCiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmTkEPtsDVaSjebqBV2YicN01w6HPuJ2prY8k8JQDMQ=;
 b=HiUgyEVXknLHPTEOLNY0HS5WWN75KHqX/iy2/iAxSjUg7rckEcMsIuvjfaBBJ47L0e5Em88+QeFOKbBlYMwGf2d9/aIDxaW0VKu1oaShEorDQ6cqQZrH2H/r6oEmZSkriXSwj+WWscp3iRtpUV/0o9rgiV8lqwZiTHRe1tMcItw=
Received: from MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23)
 by BYAPR12MB4742.namprd12.prod.outlook.com (2603:10b6:a03:9f::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Sat, 4 Dec
 2021 10:20:54 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::ad) by MW4PR03CA0138.outlook.office365.com
 (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Sat, 4 Dec 2021 10:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 10:20:53 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 4 Dec 2021 04:20:52 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: add helper to verify ip discovery binary
 signature
Date: Sat, 4 Dec 2021 18:20:31 +0800
Message-ID: <20211204102032.3063-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211204102032.3063-1-Hawking.Zhang@amd.com>
References: <20211204102032.3063-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b07305b-cc44-4209-ad05-08d9b70fc116
X-MS-TrafficTypeDiagnostic: BYAPR12MB4742:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4742A41CBE763375E0FBC7A4FC6B9@BYAPR12MB4742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99fvT6CLZfG0SmKymey+W7uSYfz7gG9c6Capm8SOEhuHAPTCIR/ac5Yxidp+LS9aQd5AZUeuLiWOnuXPy1EFEgQ2GJgAfdhj7A5dUoqECEo3G4bT4JejIqy+VtRve1UvrVcFvfEtNDHTKjobvm2jADzbf5ybcaJDAj43Wpb7hHutskQhE885KfRS40zqbjuFS988dJN9JpXkSJtwafdM0ujBGT2Iodwy7MftvwlNa4BJO6bGz+xLqOLOdbO5D6Cs2OK7MCx2xgomNUOrf0SfifJ41D1fOJaScRHXd6eXEIDT/UqvyQVZ/PyaK2l31ejUUDpW5DxXaoB/dxxMlGDL1bPrz+KPlSdyHc4rvdqmu5x3fkCErvr+3vgcMLWXzceu1mRxnRK2uJfHl41tGW8tcbB/NkTyBTwFDgvYQYzkD6xXDQiX/cM69YbcPZMlBQfpqcvpvQbVLiSVuW37JVkoBb46CWVM/NlYgEJOUx+N0Hw1Kg2W3jpLEWeD8NpGFaNZhep2ihz/A6xe20v4aLcy9q9X2vKKAD8n52FQ2HhdZDl0zhE0/60LwP8yr8VUre8uI8vETUMSTCEAE71tAXVcNlR/dEfgZ0qIe6vPbbWeGCByUP0Xoo4U6X+B4OKiyd7nU2bVy5Yj1xrQ++mHupUJ7akYtDwD2pGTN/4+rgTUicjP7HToXLaiJluG/89Aj9Xh9hovAWAMXIKMFKknRhyrq+rA19o3K+UpMoPEAFxghUWSdoJD584F5WYnxLJzHkzkH2uxdjwMM6m0yAfA6wnagquDsocW2x7ap2t5nQ8Cy98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(1076003)(81166007)(336012)(7696005)(83380400001)(70206006)(70586007)(2906002)(2616005)(8936002)(508600001)(5660300002)(4326008)(186003)(356005)(40460700001)(86362001)(6916009)(426003)(82310400004)(36756003)(16526019)(36860700001)(47076005)(316002)(26005)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 10:20:53.9954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b07305b-cc44-4209-ad05-08d9b70fc116
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4742
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To be used to check ip discovery binary signature

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index cf9f09044eb5..f507cd70ab86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -233,6 +233,14 @@ static inline bool amdgpu_discovery_verify_checksum(uint8_t *data, uint32_t size
 	return !!(amdgpu_discovery_calculate_checksum(data, size) == expected);
 }
 
+static inline bool amdgpu_discovery_verify_binary_signature(uint8_t *binary)
+{
+	struct binary_header *bhdr;
+	bhdr = (struct binary_header *)binary;
+
+	return (le32_to_cpu(bhdr->binary_signature) == BINARY_SIGNATURE);
+}
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
-- 
2.17.1

