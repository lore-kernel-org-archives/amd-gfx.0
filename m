Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671CAC61D96
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 07:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BB710E5BB;
	Wed, 22 Nov 2023 07:00:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 934B010E127
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 07:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkqeVSw2+O8H3aDBvXU40LROTIvdrBqo9UlufMLnUJ51DBrIEiV6cGVP2Q61z1Ioz6dlopVsImc86n/yZUkIpP778B3VVO/VmC2r+VTQ8AXgXiTrovL6HS+HiDARM+S0czdD5uGBT0koTlwRS+k5EiruYRD9f7ePiEOxNs3QFnisyvpMgHUNRO0XD7WWsnrjID5ELn+dZedSCKSLsZNJibnzjVNz5BIChwSpDvuIfG0TqAIvfjSrhTDwxE/vqaOzQGg7rpHsGnbfB9VksbnqvONxNexUgKLO4GBi6P8E/ybj0jueVMLQRo9gg1iHNdD2oj5SMEQMybSGUM65nmjeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxMOS4nAwSyxCj40sYS3qre8yCxKuUmgMLN8wVIyPrg=;
 b=MbveaXYAQM2+GgxjwY8jlvwPdzZLPB2Fm5V+x4PGOEsgVdeW/dXyaQ7PD5olcOwQLJKeaU2hS8qGB68BH1W9KsAIqonPIW5y9QFvl5skVrkxBYziNBVMQhoDivwLdoL3Kn1eBAuAwJnObcBBZfkv/ShNfcuxZf2mK6Tvw93q7cJfgMZrkr/v+06PPVPX064IiPzmW7i6RtlwLq7XjpxIGesnCcalTBXuu/44/S7zKsl6v6RF1fm1PpEJN7SWm1n5p/r5xCLV/6rbrl6+1I3h2A4TwOzjHbqP2IP/SWuJsF1nnhT98Iidfa8b3stOmLvylavG09l9vZERbdguu9DCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxMOS4nAwSyxCj40sYS3qre8yCxKuUmgMLN8wVIyPrg=;
 b=1zVFhPn5B1Hr8qwfwO9fE/tRMAf6971F12x8oqLR+W4NFvZErm8+RH5cJvCBVJiTgDuoT9SQtm6YppJu0eNx9OWxWzrx8QHdCLDKSHKoEvCnADvtCg0pbisjoGQSdh1gpa/1v30SKd+BtWnp/gxM4a87vKftBUmdEf9o5zOTETc=
Received: from CY8PR10CA0029.namprd10.prod.outlook.com (2603:10b6:930:4b::10)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 07:00:00 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::b4) by CY8PR10CA0029.outlook.office365.com
 (2603:10b6:930:4b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 07:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 07:00:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:59 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 00:59:53 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amd/display: Promote DAL to 3.2.262
Date: Wed, 22 Nov 2023 14:58:41 +0800
Message-ID: <20231122065841.2267110-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
References: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b51b2e6-d777-415f-a6c1-08dbeb28a51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j14vw5YeQYXzOGp0Q8S/4UcAjTv4+rHIJ01+yqvgUc9W/m4JKNNEyrzTnLE3SIszs1BdZet0e0JEgahvAGGB1IHUgerUV7597RFkY5RyTc6Fi6QGudM3yyq6trmVTcKyS6kXcAIWhDsk1yaEXiwqqkqiVssPNwU/mjBEGPvMnnsugKSoWSZtlnyLnWNoauuaoLYS6vJp/EwXOp4SvhvPVJdZjZ0hDA1fWHSufSNpWbnz1bF24sUHt+FAoTVdQa7vM/1QDSYuuid3NEailpinTXGHuf2v2o3buFFp3063v1pCKyjagcUD2tR/k5nfafmO056OvoXDEHgUE4vTzJY9O1qVJLtQDf/cOLb2i2hgCFbjK8hIRVGCc/tKJ+lgLP+l6PSMgc8jxjh/HC2CgeIejIFMaLhsewPVKPOLXLQpYBueYZSjxzFLWbiHPfdcNbvj9Gx+oqiboPQ7wniRA+LXyfDOutKL58qmvt84Ek2awQrvvepPQ0o7inmO2jW3/V7aY2niXuf1n1ams0iAypJJ/Dcjn01Fdu7gk3O/EK4FmSxnMC8CIkKhTLxCdoXVnFWBCzV11LyPWWpsBooNO8bDZgoDWMP1+IB8mGxD6KNQpnq9CjE5U6Kt87bJQn9e36vmK0au2B+n5IdBpGRomhqWeu8xU7X/NkPQmkF4sAKP1IRRlj8vzPa97NqSz8fnnCxy10ygXMH3ZgFC4CPj4VQ993S3VlklkApdxYuBgPO0ajfIsOrQ7HrKU3VceVvKVvDyTE0U3gcbKs0CEoGe0QBeEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(316002)(6916009)(478600001)(6666004)(83380400001)(4326008)(7696005)(26005)(8676002)(8936002)(54906003)(336012)(70206006)(70586007)(4744005)(47076005)(426003)(2906002)(36860700001)(41300700001)(81166007)(356005)(86362001)(36756003)(82740400003)(40480700001)(40460700003)(2616005)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 07:00:00.3300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b51b2e6-d777-415f-a6c1-08dbeb28a51c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
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
Cc: stylon.wang@amd.com, Aric
 Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Add DSC granular throughput adjustment
- Allow DTBCLK disable for DCN35
- Update Fixed VS/PE Retimer Sequence
- Block dcn315 dynamic crb allocation when unintended
- Update dcn315 lpddr pstate latency

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f3c3e0935ad0..cf7f88b80390 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.261"
+#define DC_VER "3.2.262"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

