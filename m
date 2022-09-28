Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC59C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 18:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C0710E628;
	Wed, 28 Sep 2022 18:22:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F327010E628
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 18:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgTvdRh7hTJEb4xAzZBnj2TOTSu/nwVaoBhoCy+Yy8bGwUmujj0VI59rE6JDqDIQHXWK8QQT4oHbRHXIs3hdvM/f4Sxd4f3kI1F80e6gIHH88ZIxc94O+Mvb+kEX2s8TypXgeAHG0ZejL7rHS5wPvUaZk2zteC3dV+zPCuDfwJ/9sK5W2rt3+6SbpYopoi6+HPlh4pE8uQu3WxoXSED5frjPVH4KnAk2sLnvCDD7fMop/7y3WZKTelhGF4yG2Cn/W7yNNDb7ur/fkk6a22jR7fvshLLAGcZ5bKOTkkEYMrdjxmr+fFmCWCaJ8VmZBw9ObVidBpeSfL01MQfIRBtM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO4jHFwOFCxexatdWQryyjdPXSnmC1evLfveccSjxRQ=;
 b=Q8FGASCK0flxQZQ5h6dg5JZPROpXI5xkSPe2bKwgzAdRs2MRTx6qvg8z6Gf7CN//WJH2jdXBqSM0yf0t4vbPbkz+2ZdTZRpm4EFyUufWsxPvMMu9YtvOmQHqVm/EIABHOnccohS/Lo1xdM66E9r1hDry0faiLxtiI+YoTPM/VVXe4vuJzfyYpC4xkgk4MI6Z7BqQNjtqHlFzbb8L9ggxNNwLprbhb91d2BD39wYW3yRtMSY4rDFFHHFsvX6BDvzP+bJFSRizcYWJpF1iqeF2jElgRdIUDlOV6FQ2tEKeOcRXgppE8vlZOJT+Zq4sMMMcsPCMElLnAasgmQUguxEG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO4jHFwOFCxexatdWQryyjdPXSnmC1evLfveccSjxRQ=;
 b=yH7L3y8W3oPPBhU5nJhZr+O8wNWBrt3LzONV24dutWMRSxYDQheParBanSD3Zn1dWC77su1arlsf3Wq9q8LGWwX9aB49Hr+TOWEFM3ebx/EiFfL7h22V7eL6wOwmsCXMK/GJ5IICAk0jWOYZQO8Y8As6/ohk+yTdKraTgsO9RZ4=
Received: from BN1PR14CA0016.namprd14.prod.outlook.com (2603:10b6:408:e3::21)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 18:22:25 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::e6) by BN1PR14CA0016.outlook.office365.com
 (2603:10b6:408:e3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 18:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 18:22:25 +0000
Received: from VC-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 13:22:25 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Date: Wed, 28 Sep 2022 14:22:29 -0400
Message-ID: <20220928182229.14683-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|BL0PR12MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d61b06-d4a1-44ce-74e1-08daa17e6503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgVkLQi1dETdPajaob+VexuZwgB5b9F/bQD1lQiZFGuPnsMH8Gyc3lDVYxj4jMiQmQ2jaQ2SdYMdNjeBUsGCEx4neZwk0nPm1FGzzYZ80Nn3AIaVy7aK68UUQWklxSGIs1SUVqYUhHsaskQMBNvBwl1GgPnDOQ6ZsOP3ovJsMOLSFmJp965v/MSlfeE/EGrJcI36gervf1vMR1TISpMJqlaZCO/1mrGvQb2+QU/jKkZghBUN/iLYSUf4jaA1grkJAQtmTlRxaA0PdStO6nAO026eOJjpGI8+nbI9OT+QTEodaDecNmu7nE54OI83agOSYg6cEUujIT5aJGOerCdcyvnzLuLTSSqLlFkmFMghZmkGPrQ3BHb2UHsBWyfYVVPBWgG8niJ4Jr7j0lQ10XAzU9W7nfkrVhoKQJqNTyRmts6pE/JUCyMvZmCNbw3Mg9XX0DUbOLxJCzUt2O4Kf2tWtPvWwL+WSFXaz0AL+LiXsafGU3OEDOk2+HrmGr8cH2I6idcwJ6bB8yR6iWgn6V3x8iAps+AlUgAktFwvKMBWMgwu5hnsgpBEk1rYBwjGKcQbvzLgi6X9XBkzMUm3KO4tgHQ/rA450ttY+JQoT/ekgm7aR7eO8YMwyt0Xd5S0ISZ50dffRkyrpeZOolLdkKHBjw4PzrWtRebBNAD4UiamHZ24NB09fbThl6ZE8w7EHNy/r1orT7KAXietR8fDGBqaTVC2er/dd+kV4HzzjJS0/4jVRJhbYTZUNBTubz3XXMh20vxYpOY6XzmsoPwnblYqgXH4jRVe1LEOGBh1PO8ZB+cq8DPwbIGI1Y2QnNFwosszP7xzj962X0ZJsX69Pb5lGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(47076005)(83380400001)(426003)(36756003)(40460700003)(26005)(2616005)(186003)(1076003)(6916009)(16526019)(8936002)(336012)(316002)(2906002)(70586007)(54906003)(4744005)(81166007)(82740400003)(86362001)(356005)(5660300002)(8676002)(70206006)(4326008)(41300700001)(40480700001)(36860700001)(82310400005)(478600001)(7696005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 18:22:25.8241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d61b06-d4a1-44ce-74e1-08daa17e6503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
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

For xgmi sriov, the reset is handled by host driver and hive->reset_domain
is not initialized so need to check if it exists before doing a put.
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

