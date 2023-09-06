Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2204EB8FAF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 11:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B74810E057;
	Wed,  6 Sep 2023 11:26:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCEC10E057
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 11:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnrYjy7mHq1Zrvq/ZNEfus1W0QzsRZwL3jGykkXb/WfO/4EGO0NF7yxXIjdJjnZFXqex4aZUQ+oZ8F/QLvCjdDvZTZqU4eNf+V3RDUtNrvTvIa2dxq1aRe+mYUcybobFpQensMMTHMLzTk4zlq+G2eltXen8WcwvBl1K8JMtAIPSg2wxau2JDesmP9mPGXQW24HGM0wjTt1dmUFK9Wl45A+iWEmJDKjdd3+A692HUcz9ZFGMI8tTJ42KZmARpdGusSxpTtP6VbL/8UruMMlYUVrJXqemMRJBm4aUw/8NMrfDrsuBTaUs+sfkzAqx7RhdqyVSXSjh1zkrYwZzoOzCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfCe4GyUwbY7IEkFYxQfDYw9LxyTo4NBjKvvjgTz0ok=;
 b=lDG5aTFnrcATg+EIQTwI24v+dDt9lYxckoXkspm+dLbkgxRgBkI1+bPmQoKSrXsxloVRK6F2zUYLxjzvIcIzNCtbnO6aTiJF04aHQYG2ZtY5K9p3cIinyR5BKIXdvLLL5c/F0BtZ1zPZ+UXAO5PRYV4BkGrkllCmIXPnz/MHf2RVhcI7xIsCmGUfxm9KaQewI7uthhDerhz7yyiMLYNMJMHlJ0MQOlb3fd5D3REuM7dBlz1jOevas7gHrfZOwkScw5dQffwaP0LSQqcUp7sS2NjnCMQMIxaPFfzmSf+8kN98pkxZVWxuH4aSUWlLDBIimZ9MI3jYYp4J6Wq1ALYBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfCe4GyUwbY7IEkFYxQfDYw9LxyTo4NBjKvvjgTz0ok=;
 b=DEVbDgpOYCUhIngBPYRIwN8NMkkOK1T6YOcgnscy5j+YqX7thUR5OHFxwrGs2tFb4aN1gtUriQld/sdstumLnxZ/STjLojsJiVMk8zONU3kIMGbv0+rxuGOb+fqaEVHzau+/BW1h0QbS4rK2q75vd4H/5X5mJBzs9/VmyEZLKqI=
Received: from MW4PR03CA0112.namprd03.prod.outlook.com (2603:10b6:303:b7::27)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:26:31 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::7) by MW4PR03CA0112.outlook.office365.com
 (2603:10b6:303:b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 11:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.6 via Frontend Transport; Wed, 6 Sep 2023 11:26:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 06:26:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use default reset method handler
Date: Wed, 6 Sep 2023 16:56:11 +0530
Message-ID: <20230906112611.966038-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM4PR12MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b1c698-352b-428c-db57-08dbaecc1e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JIBQWqonRuvgFudLpXG9IEz5tKUB2S2/2F7FCgABwOZWeDz8BU7imgklNgh655CEUnMvshk+fw5x9UbgoAiTn78+snTMeLlaQhrgcPWAwgpvRSQF0Rbb8og3iJX+U0YE/f+o0cVxb03NnzGGg7v25chNfRmQviUHuMO7SXkA7ke09NzeyR9mMYhKKm/vQnC8i4wAExBsUyvHRGMA6WZJJcwl8rIvhnt8YkfUGmuYBto7O3mnFskVbI17wmGVZvReE7EJek9Ll6QiR5uCOsgAKHmTpptwcUXjnaGJc4EcIPHjfItU7fjvN7dEJ3iTV0alqb0sJAKS8DjTff9aqu+sCS3JzEwi8BNnkPEEprgmUh1hGz5G/ZZ3geRvanpreNPHNdTENusGGq65M9wJ3s9q7bRrC0aJeSRQP1tTGF0toocM6awwF2IgTi8HenCkwtP2jNMbccn2RBVCHQYIXXZ1taST2KfOXMFd2EnmXdN7pu0eWdnt+Vb9oVXoM1jUHykJcrYh/ctwQe6SdPQzvvL5Q0RRG/nhMh/5P4gsrJd0SN8bgxdb+1H04/pao+vNRvMjQIjCY4oqSkP4uPuICr5d+Hjn+cCNJpstN7jl3G7GM/sOHNPxbpyEo8DXpB/4C5UjvBRU8+pf81sXRm2lL+/QC7Rg6ozOREsfI4t2HWZZgP4JHZTP4G9wFq1PdD0x0+i8FJcPdl1BVtuxvZC1fnYPWpscKQon5Ou7U1V0IrHFTnfaywlVR/6RpTpN+Gpx5APClZ7C/Xvf8wui/rrkGx8Iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(8936002)(4326008)(8676002)(478600001)(44832011)(70206006)(70586007)(5660300002)(40480700001)(83380400001)(2906002)(6666004)(41300700001)(54906003)(86362001)(316002)(6916009)(7696005)(40460700003)(82740400003)(2616005)(1076003)(356005)(81166007)(26005)(16526019)(336012)(426003)(47076005)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:26:30.8400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b1c698-352b-428c-db57-08dbaecc1e68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When reset method is not passed in reset context, look for the handler
for default reset method. On Aldebaran, default reset method for SOCs
connected to CPU over XGMI is MODE2.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 82e1c83a7ccc..5d2516210a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -50,6 +50,13 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
 	int i;
 
+	if (reset_context->method == AMD_RESET_METHOD_NONE) {
+		if (aldebaran_is_mode2_default(reset_ctl))
+			reset_context->method = AMD_RESET_METHOD_MODE2;
+		else
+			reset_context->method = amdgpu_asic_reset_method(adev);
+	}
+
 	if (reset_context->method != AMD_RESET_METHOD_NONE) {
 		dev_dbg(adev->dev, "Getting reset handler for method %d\n",
 			reset_context->method);
@@ -59,15 +66,6 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 		}
 	}
 
-	if (aldebaran_is_mode2_default(reset_ctl)) {
-		for_each_handler(i, handler, reset_ctl)	{
-			if (handler->reset_method == AMD_RESET_METHOD_MODE2) {
-				reset_context->method = AMD_RESET_METHOD_MODE2;
-				return handler;
-			}
-		}
-	}
-
 	dev_dbg(adev->dev, "Reset handler not found!\n");
 
 	return NULL;
-- 
2.25.1

