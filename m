Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C851C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEC510E9DF;
	Wed, 28 Sep 2022 19:42:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E5910E9BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmgcGvhcCtydF0P/1ga528aeu8PSd7Iz0kJZiK00EZdgi4tZZO8DpCxTqzrS6w9NnoTXxqAoYUHzor+DSsJ+GpTLRIIeWe8Psbskc8UM7H6KpeoUhgd+eeCY6AqC5ue1GoSj4q4jnhAgVfwNJ8tbd78WdW0L/6nsM6cEi/J+LRd/9YxpjcXC91p25EYA4yjM5O9+eNd/v5UecDDml929+R88muBXbZT3ODpGt0GubGyYkvtHzECoQ0jnabIYKb6XWIJVJCGL66zd9ouiaM4tBeazTb/dCfvL8eDOqP/c+ZNr+B9P7YI7H+LsdWit1icZ/jwNLZ7AAJYeEab/g4sacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGc+IGAejQqoyFfg10bDZimazsmz+57+Q6nIIvE19Vs=;
 b=fH6Q1bU2Db4f+za8zdtysD1I58e2GRfOHCGU22foMZW88/i211Bf3pIFEiay3B+pwAA7ivkuKYzevvxRjAxpn7KP6uhX1KIWn/wZ2N0Er7Nt1clgyS3VOy0dYxprI71M7XaxscYYujZZacczO7vyYav41MB2rmn6hBO/AmySSZ5s7i8tOjKd2dJDGJ0OKUvryR+0rQDfwpd2DaDyok8WjKq9kaVuduQyh3RVaFvqfvrIBJXRsSKmp/h5JIFgG3GqeQ+C5oFkphsG2SROgAQFjgGY4ZWflHzWh/h/zG3GaomMMlq1QIXoU7FoplmfNcp1e+VN1Mb5oHqme0hcLciDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGc+IGAejQqoyFfg10bDZimazsmz+57+Q6nIIvE19Vs=;
 b=lUWDLAejCjAKZoN7mMDfyK3rmLQP9yGQucGmFikelSEDiUt7PoEQlNT2mU86oN3yhwY12HKI/qXmN4K3Ad5csIz6WeFj7AKyn0ay4DMdLtctw5xBXJGUt95KsHquGpiaDpp5tf9hIi68moHgKsJhoE3NbhDg5viAlHiHqeg11/8=
Received: from BN9PR03CA0678.namprd03.prod.outlook.com (2603:10b6:408:10e::23)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 19:41:51 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::4) by BN9PR03CA0678.outlook.office365.com
 (2603:10b6:408:10e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:51 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:47 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 36/36] drm/amd/display: Minor code style change
Date: Wed, 28 Sep 2022 15:40:28 -0400
Message-ID: <20220928194028.144879-37-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfc37bf-deac-4219-89dd-08daa1897d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ipY72zCW6wWBKdifr8EnY2f0yXJuvqhfC2cU5woPSCuJm9IW5pbg+GLnnx+vBoZVbZy3l+x1d4Zo/WS+noPgkxdt9ud3PEv5NUMJpPpS/kFrdEES1WMAKQzZh3htY77Yp33XLnz7a2hXAiB4x9owJqm+NGwBadL1qJ9UHXgBK7HwR6BRWRAa6WkVtL+R7qnp9doLZTDQLAvtRO0sOaO3n0gK/xh+gDksR0EKyKSQi4L6/vP2bvkk3iyQwXVwIKtVMf382bKNN1yJbaa7ir3orXWBUfCkExJFTWKHWrpISpX8QCOCfntom47IYjIn40JhsEtR7sU/lpDPz96aDAGrH2taP7D1thtgWmThlDOtu4HtUWfOv0ZLGxsAqwVvpmoQP6YDFwa7tBuJP8jSMGDNM1Y6lcpdlLGt5l6UcUz2AWfFWj3Mx22zbTljZttofqIdUvnQp3A/8rY+gaoEeXvXYaZJBHtIvS0AwbSnT/HrKg+6StE+A6wDJbvt4VqMJHAvLcWNoPgav6f8OST1Ewph2/+7FUqoEL+J0CiegvYLbf1PdwzLV3/tleJ0Ev1ZYsnIZo8SW82Vc7pvTBXGDzQXHSBSHaAWOJ/vUZd7LtOfrTl42TnvMUFMNjhgVflymyD2yGMpSDWehodAvOAZPtoZvngVhGVXKcrzF5Y9+vYWT39iADqvEsyC9LRtkxI5/ny1S+r4W3zua0mm5+j0ELmEw6R4PMFodWys4jKDqe5XREInL6MfU3J3/r9+I7k+3CSDFxxFe5xhaWgNlsLCBovjLKnhxdYHrh0ZIt7YSTvZSRHnq2AokVUWoG/iFW4d/vgbS7ep0j/Bsj9zWJV578Ftg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(81166007)(82310400005)(356005)(82740400003)(478600001)(40480700001)(36860700001)(6916009)(54906003)(36756003)(5660300002)(44832011)(86362001)(26005)(8936002)(316002)(1076003)(186003)(7696005)(336012)(2616005)(70586007)(70206006)(41300700001)(40460700003)(47076005)(4326008)(8676002)(16526019)(83380400001)(426003)(6666004)(2906002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:51.2316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfc37bf-deac-4219-89dd-08daa1897d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit adds some minor code style changes just to reduce the merge
conflicts we have when we upstream some of the VBA code.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c   | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 8316b1b914c6..11d5750e15af 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2476,8 +2476,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.PixelClock[k], mode_lib->vba.PixelClockBackEnd[k]);
 		}
 
-		m = 0;
-
 		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 			for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
 				for (j = 0; j <= mode_lib->vba.NumberOfActiveSurfaces - 1; j++) {
@@ -2854,8 +2852,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	m = 0;
-
 	//Calculate Return BW
 	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
@@ -3616,11 +3612,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.ModeIsSupported = mode_lib->vba.ModeSupport[i][0] == true
 					|| mode_lib->vba.ModeSupport[i][1] == true;
 
-			if (mode_lib->vba.ModeSupport[i][0] == true) {
+			if (mode_lib->vba.ModeSupport[i][0] == true)
 				MaximumMPCCombine = 0;
-			} else {
+			else
 				MaximumMPCCombine = 1;
-			}
 		}
 	}
 
-- 
2.37.2

