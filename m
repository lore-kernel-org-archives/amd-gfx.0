Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F05C43217
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC23E600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC23E600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8EC6E115;
	Sun, 24 Oct 2021 13:32:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F3F6E115
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYzdwaLN7pm+T9o4AIS4fR7tc/EVsbMb1c6pMldwU7+JUaCi9ydKNOSDLlZGuSgcxDT1c+wq86VZSi4NeeN2i9lWuhkNUmlbD/Ab1oOxyj6nw5FUJ53DjXeOd8ZgCtILFdLl3xxxZSI02g6W3PLxUmjEIn8LbY4vC3YXcP4qQtCpc2FqAHQB3nCGvacvrVnMO8GFqAa/6w8bZt6m5WRRJLYBi0cmZBAdeLMNxKRiSB9MZEKJCCpUAUgwlOXrf0t58paLSMmrxcpneP/z2VGjMnKuY840yG+mFiC3OL/rLs+eOflRzBMAaM+soiAMrimiUKqCcP7/EbRzyLMLlab6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKSx0wELOXl1t6ZMVAQotfR/0Rfb6wutkDOeXAFoOIs=;
 b=Dpa3xS4LUZG81HJH0y6Cp54MjC8ESEQtmc8vvZOOX+PCsAnN/Z+Z65SYTlOVS7sW/IrLosnQ+Szs+d8HZg/WIEtbdN29D9CSDXSdUWaFv27xn/JuWEHkRl9qTzAFMJlKz96OG7gY6vuYHRdNi9aQzFj79BqDkn4PSGbdOrOMROPVMNyu6PS23gCJfcfO2bCZcCtilFASre/Nwyes65PZ+TGjSYl6aV7Q9NHTadAKP6j8j7Cg3BOz2Mg6+toPNrhW2EprJy7UbicOdqBf4acx7oV4VNEKEy1n6PpwggtZ+OW8Wc68IzVzfAWQVO6YK5Xv7RHe/SMRe+3cl1SmpnX8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKSx0wELOXl1t6ZMVAQotfR/0Rfb6wutkDOeXAFoOIs=;
 b=HomGzJmjdUtfvNQ9fq7ONmVVkjosFVAIzEuocl63vcmV3lgYpaDpcdGoWzcbdAoWzekHI1Ia6xD5GfFj5tSKj66jE02bw/htwSxoijk3pZqpz87my+lWpjSPJ1xgfxpqlO+9H61JJKggMSVFi19Ot9x/EGXSyklHLEVXhazHczw=
Received: from MW4PR04CA0070.namprd04.prod.outlook.com (2603:10b6:303:6b::15)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Sun, 24 Oct
 2021 13:32:33 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::75) by MW4PR04CA0070.outlook.office365.com
 (2603:10b6:303:6b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:33 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:31 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 21/33] drm/amd/display: [FW Promotion] Release 0.0.90
Date: Sun, 24 Oct 2021 09:31:29 -0400
Message-ID: <20211024133141.239861-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db4e6629-6377-4795-08af-08d996f2bc18
X-MS-TrafficTypeDiagnostic: BL1PR12MB5352:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5352C46B2AEC0A8E5740359998829@BL1PR12MB5352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mbvixE1sjzAGRWHM83gqO+g2Jx3SWkB+x8gKfA5kKrOpbg1m495w5CeK8k0bDyInWAPsLes3ocC7xw0DVYJnRS94IjMiQBRsXa3E2Lxfk4NSinTK4rPvNJa6hqcKbZodFAuDjwe6GktRn72zkAKtgnFdAed/gQ95eeqi4CuE8kkysBFHLiKvTQNl6xJ6Pn7yjueteWhmv0QR7uoUgoGk9cn9ZvcnU/pDWB9Ox2TUHrtl5G7ynFoZv4G9kVf/WvkZlgVd1JZHK8bAHTelwa5x0w3MQBzHq4ux5s9lhrbqz/CAG7We7x1wInax+4SdPMRZySca8kSafbZ8tBliuUhcMd1lJ5Udtaj0lF7dPj+jTmdad+lXuMiZ568fZrM5rd0H0W5bsccVOmHO6j+RjGRpPNEudJy+VMYcoAEY1EO9w9TL5YZH3jZdVcHk3llPWxf3/6nNBr4FORID8GVeOEDEgp3Pt0ATqEr8D9yizNhfj+ic+Uud3Z9+4bceJxKwCLS9XUqv3A4qFYBSbBVkLPCZY960/MvnQuiBLm9aHgEOBUv6YD9yZFH4J3xIyfzWXv6d785PldDMsMAawvJPG3QmcJBaP4zxrDimWhdCA9inrNoBAkxnL4W8J+AljUB3X1MPPAyAQ5S6J0/5dlaNp4ieRttfZBHWV7PLu+FGWitdogmb5NPIhKwJsE8k42RZSf7dUj4ebVZ3Yn8VwVP2AGDOXD1ze1kfxDWdQOcmfY8xIU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(2616005)(8676002)(36860700001)(47076005)(4744005)(83380400001)(426003)(70586007)(70206006)(316002)(2906002)(54906003)(36756003)(508600001)(16526019)(6916009)(356005)(186003)(26005)(82310400003)(8936002)(4326008)(5660300002)(1076003)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:33.0030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4e6629-6377-4795-08af-08d996f2bc18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 9e8ffbf47e63..e0bbfd1b7a2d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xdd808d7b
+#define DMUB_FW_VERSION_GIT_HASH 0x9525efb5
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 89
+#define DMUB_FW_VERSION_REVISION 90
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

