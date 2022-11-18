Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FEDC43217
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 08:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB8310E1FF;
	Fri, 18 Nov 2022 08:50:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3121310E1ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 08:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivmk3pmigaxPardgo6cETa+j6SXZDRbMILC8GqNEVf74QdW2kskBKynRlcpgvy4GkGeChE04XR3yHKUiVfzV+wx9aOEgPURcWXqgi+qeO0cVGMD5dkzgnC7I+S91wIFhGOJKErwfKffCV+1NRBZbhmkuZzuLP8zIqe5C9C7TfxT8opEXvnWbM4+wPj1mI0O5sdyKyfBbiBlfe/l9vmsbbAD1VmQD9cDHToU921WAceNS0HPrumXFbG2FvC5feBj9sTuHmj6T1lAwZkTxiS5CtVck5i844jS+JzauAOD6Bbbs5uFB+R9EskUgoWx98HYeNB/qqVEZYV6sZHilWBDIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj/sZbWK3eyEHpph6heyUAOLYxAoItrh4pWLj2fmHKk=;
 b=Ep3jqKTO5rvdRadKVUy81NDs5ovJISu6IAsb3Ev0CZ0T6uBilC8MQHVdwwsZ9pxutSFkfHElkc0Qulc+C2CkYDI830MWSwOLjEbs59tsB85ujsz6EHudyHaYeDJIuYUXcfs7nUmPlgGB4c08bEqib3vsqm5oHOhRoP+C85hBFH7Y/ua8Jmu9o7IZFTibi0r/SXxR7OMCnAXWjMVme+avB0Xgl9Q24wPp9M9LjAhMlW7wlN6D87UroInx+1l4Pg508MWqEcvsMCzkvPT1hDp+xwG9XhfcHcDZ3/jwoxgm1NShCD22NT+DJhiTRbfquJanQTYapruwOKq42LlZzyAckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj/sZbWK3eyEHpph6heyUAOLYxAoItrh4pWLj2fmHKk=;
 b=OHBLCAaiTx2ytlc/JCh2rP6vicmfMz52tfwwJ0aNvJlklJvmbXnKI05THIwfCNgM12EikwGcN19ViHNU8IMuwQzEXBBGWdkXry6JUYxt0jLZmgj0HD66/AEuPw2iD3zI1DCsLBBOAnHhA9g25F0DuTZ4AdHVjZrjliYLd3E7cKU=
Received: from BL1PR13CA0154.namprd13.prod.outlook.com (2603:10b6:208:2bd::9)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 08:50:38 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::fe) by BL1PR13CA0154.outlook.office365.com
 (2603:10b6:208:2bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 08:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.9 via Frontend Transport; Fri, 18 Nov 2022 08:50:38 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 02:49:40 -0600
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update documentation of parameter amdgpu_gtt_size
Date: Fri, 18 Nov 2022 16:49:31 +0800
Message-ID: <20221118084931.1381499-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|BN9PR12MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb78703-d119-4ab5-97b4-08dac941f73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwRlS5zFXYYoYJ2JPvUECm956D4vHnBKD0Z8bEyVTC8RLsFIChFKUYyigUZVVYVweNrTtlKcpGVGJ1KdQl8sSFGcmDG3YoQs6e8SBEPr6cTXikTqXKsiY/dwNvNxLT4qbS9Njo/gwblZZEJEe7Fx/DJFAsHVkvg/HZLrBHmh49Yktv/imyOwnMHf4J/tW5SbvQd2f7NCHpsJKZH2z0yaC/Cgfnbg6FUh8+IPjTLu2zjxDXPh0AUGA/gwup9D/ssJzr5RX/HYaznfxtFP5XhQa3vum9R/Nu8AxUoGNfM+HBtcEIENhG2jm1RvvHGAKV9TdmwTwkVwbljapajtgehRzowCfvRlEZW26+qzBig7YXVz3z1EUDkRxIxccO5j7ZUmY6AzbjsvBhi2lRsROx44qOPDRunsrpI92/kjYYxiPW/qeC4LnSFJgFHLewv+igCOVkCz8DiLn1M6p3LYldV2a/KdhxUG4URfQbj5ZVqe5PDGoI7EofzDLetJUaxvO4ctkx/bMQog6/oUDxazXIneVurLQR9SO+zVKsW53w2vjXWf+tGBXNo/4WZu1jB2BwUaoQN1NvaJEHF/z6nN2duqsAl58khch5wrqFO1W2k/yraCzrNCongdWSoOSE8LnfuiRa0FqLTz69uTkeu0CI0Tf6Wfz2BfZtJfGEiMiBOyTYxrNZvpX0TAhEYEcrgdfRFZNa06BzWEU8x6iOW5ypQNbFst+3YrmDfhwbNqja8OyZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(86362001)(40480700001)(36756003)(82740400003)(40460700003)(356005)(81166007)(82310400005)(6666004)(26005)(54906003)(6916009)(2906002)(7696005)(316002)(478600001)(336012)(4744005)(426003)(47076005)(83380400001)(41300700001)(2616005)(4326008)(8676002)(70586007)(70206006)(16526019)(1076003)(186003)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 08:50:38.3877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb78703-d119-4ab5-97b4-08dac941f73c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
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
Cc: alexander.deucher@amd.com, ZhenGuo Yin <zhenguo.yin@amd.com>,
 jingwen.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: f7ba887f606b ("drm/amdgpu: Adjust logic around GTT size (v3)")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 72b77b3ac4fb..987914532104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -237,8 +237,7 @@ module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
 
 /**
  * DOC: gttsize (int)
- * Restrict the size of GTT domain in MiB for testing. The default is -1 (It's VRAM size if 3GB < VRAM < 3/4 RAM,
- * otherwise 3/4 RAM size).
+ * Restrict the size of GTT domain in MiB for testing. The default is -1 (Use 1/2 RAM, minimum value is 3GB).
  */
 MODULE_PARM_DESC(gttsize, "Size of the GTT domain in megabytes (-1 = auto)");
 module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
-- 
2.35.1

