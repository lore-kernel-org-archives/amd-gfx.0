Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4D1C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AC110EDFA;
	Fri, 14 Apr 2023 15:55:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F73C10EE0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQCH1w825j6NUIk4C89pfypRokxWqbtoeiz2fQT4dreLxKq+OZ5tTB8UrCTXzsG/+6wLq8yKaW2d2GlLRFSyDOiN5yHI28J4K0SMEPX1utF8jyIhP55d/AZVsm6NjpLKW+eLIl9QfthbOF2CKV6MyHjLHCL3HRLeYNU3FoU08UuonD8+3Yg3YbwNTER+GsOUjIUPn0yloonRPwkaOAzGamFIRjGtWlZkJUmxLWQs18EMKKKwalVWwm6xjTTZXZggaa29Ct1dzH3rWBhfOIVJK1NLdBQ1XzDIYw1+LkKVzvWTg/tkJsNz7Di+yPZ3V8kmWRFHtzPdlJVF2eHYidpjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idFkFb1CpYMgSRqHJ9EhX1M63a19shNY4xLN2Gr4FvE=;
 b=F9yAddKEqo4RGnwd5JdmTQMjaqacpOtHcRtfM3TKXBHFvJqxiFchQJ1RmGXziyyIIyKMn9uYzFcPKp9QAGM9taiUn8v/VaVa5ZaKCXubDy1cG7AZOWHuVTpOczsBAii1Kmol1dhb359ulIHEXProji1yv2tXAgIy1oAqEqTKL5uaZxqlL+HjhGc9JVJ/+W2wawPevNyRs+urtGNqhpLX6vRHCPZQgwoiDSs373YCAZ3I3RNHcAuphmrwjj0CBxEbwNmL+e/wLH6E81zKzFrq7BID24zF1cBROcuZRnxwzGagc2eQ4kBk197xrCEIk08O1qF34SEXiL1dvnMYtiwu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idFkFb1CpYMgSRqHJ9EhX1M63a19shNY4xLN2Gr4FvE=;
 b=VSQB4NmdlUgYkAcqf0ayxL3jV6l/MwqCFfOW7ZmbllYZuYdIGxvtEyIXfXAO2GsAWBj5l4qylr2bx9r/g+SD04KLtNV9WGCYCSPdqYoHRO+P0RhDTdKEpvP6oR+0OlMVX6HcxxNnE+042wDqUYpi9wooJAnjG9tVaMLGdqK39bA=
Received: from BN9PR03CA0184.namprd03.prod.outlook.com (2603:10b6:408:f9::9)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 14 Apr
 2023 15:55:26 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::66) by BN9PR03CA0184.outlook.office365.com
 (2603:10b6:408:f9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:26 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:24 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 66/66] drm/amd/display: 3.2.231
Date: Fri, 14 Apr 2023 11:53:30 -0400
Message-ID: <20230414155330.5215-67-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6ab072-77ca-46ec-7a22-08db3d00aa0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GhBH4Zu1z7Km9CRriAZIEpfLvr4nJw+B/6SYseAFwLafVGnWLVWAjiXEmEzdU6HS3ZPHg2mtT1CR8K8K5kWeINLRu0ZcdKyEqD93KJewBKSbjjt+VXZzkkG4oR6Nu3QaNDnZscT0xd00lnkgDDzqOA56OEzBk+iES58/qYNxiSlrZZ/fNp/HYTGuoG/o6YodzgGA4uAJwuzopzS3PqViAG8VEHigfOjNGrUTk3fBg/DaHGvCXYa13in4NmYdSbPwnip2sOwy6SKrH/Kchy6fe+HROzGtiPYZLoKeuCj5fK8C7Kfp9HP4lmkQZZpxePtRwGXv6OHR+RqDd/TweRbpcUO3AQ983QpjDx/mh3fP7mvIWrkWFmQzYltfDuKKbOuC0Fmy/5H3OBP/4NeUBoM+nFh55PXe8x+0rqDXyjNO1cRrGBOisqNIUosPz6qWnYXRuF8rOshGDDzoZ8nlkQuIvwaSbimHtdAG9lPIGeYlogsstXuDE8278TcHSfHX+D2KXV7ON/VTxL8quct2EPxKMzkjB1mKlKWv2QSZZXVv6FHte0ybuMdiDqonW2jC7E9W6PLVN4sptal7ypcEoPxbFFsgwzWCLX1qnU1Q3zwK39H1dtmcNdjQGacQc+oUCHwQaxmJ9Ck3RtVfCQ/hixnAf51zU2o1RetKCBm0rZYxFFHdVNeI/RITAUDlpuG16zLoZkZW2kKap/974hvG9ybXHdE8oUeLsaZTibMwNhVmZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(426003)(336012)(40460700003)(83380400001)(2616005)(16526019)(2906002)(186003)(356005)(40480700001)(36756003)(81166007)(82310400005)(36860700001)(86362001)(82740400003)(47076005)(316002)(8936002)(41300700001)(4744005)(5660300002)(54906003)(478600001)(6916009)(4326008)(70586007)(70206006)(1076003)(8676002)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:26.5023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6ab072-77ca-46ec-7a22-08db3d00aa0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC version brings along:
- FW Release 0.0.162.0
- Enable FPO+Vactivate
- Support for VESA SCR on OLED
- Refactor DMUB commands
- Fixes in secure display, modeset, memleak and more
- Picked up missed patches in history

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3b53f36029d0..a1b2f70e2eac 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.230"
+#define DC_VER "3.2.231"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

