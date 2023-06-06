Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA16BC7EE2F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9B110E2F0;
	Tue,  6 Jun 2023 09:17:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21D110E30C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxdaK8BlbAmx2ovVnDqlCz2BPVXoJkXtF5DZPtP8+lxpER5EuboziuRUbKB10dJxSBYvtrk03G8cCIi4NUckLL+6JSzHCE9adiBpnSahGyOcd5dCX6KNGL0ptqtgJ+UfdSyhNZwMQvV+5h/lDnGHrgX8rY9ntENoBtxD4Z/kyq7+R0Jx/uisK74Z7dLjC37v74k+jAQgx0d6unFKBhWNcDcuiqt+EGq7dbgyj2PKirHBoFd1bqEYwgLArXx5FL2PaSOz+QRHkWhH2WNfuDcOB19nVlwaUKlV7Y3W+hAcJ/cRIL1CVXOhS4vFT/QyC8yilUiG5cWtKiaZdIscBLGs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO8+qONjvFlPnm753zpPdq0lRXxEUk3r8A6aFb7KMas=;
 b=TKHAmYpkTRRc5niFi2ga7aA79NPdfDrhop8WMN4LMF79Pmv5a12FWyFwiwRvR0rjHvQ0aEoiRfGAqpJedPHzlVw10SVtNy5ctfya7vppGXjdO1fHtoN4zXa90NP+zACOcehp+Adiok4+yb7JUCWy6P7WjOXI03rX0HRjxayIplKH3JeTGTE6DLzd3pajgL1OnjxZSikV7ooP2Gks3zXdu7hXV/lWI3O2CXHT0+nXXfIFAxZ13pEPtIpWPqfKlSfC9AHgNX+Qo31VDInJ8lIavpFoE/ldl87DE01qL4GjsgibzYjVWfbjbkOCegGQWq82+2+MAwhynPsF179u8XcF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO8+qONjvFlPnm753zpPdq0lRXxEUk3r8A6aFb7KMas=;
 b=sAWP8JLkjJ0oYLZc1stin4VDDR2btlRV8j76KwZg/Mv5shA3n78/zoO8bywyUdJ/yQHjEVwYrK9Igpu6MSCkBiOc1x/OIrdMFUNMBchKi3io5xp05tAAa/hbdsG9zRQIhbzQEKjhRXe1y+iykT97qxLN9Ylw2eG4zQQ97ifNjtc=
Received: from MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::24)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:17:52 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::29) by MW4P221CA0019.outlook.office365.com
 (2603:10b6:303:8b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:51 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:50 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 07/17] gfx11: enable wave scanning
Date: Tue, 6 Jun 2023 11:17:15 +0200
Message-ID: <20230606091725.20080-8-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdd20e9-3b36-49a9-be01-08db666ee76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+Io955tPWAYHCLSqRkvj8j/9pA/l5LpFq2/c+SA/knCznTLhdMpOGxzSEMhckq3nFsKwKJmNlTGq9lh++BN+gSRsMlbee0tHYFpiqc/aJz85HHXiW5Xq8Epz6d3svlnNvVjLaOiRHgBLahAZdbbFakQit9jtWDMVAWAUhUSRFIKdHquyizZm8bFTdgna7Nej/zwSg/cOwIgI2ID9l2WSesm6ixPoNxaQhqNXscEM1+AMDEnCQidGFLSs7uja+bkKqjDR4u+3u0SJ3Ac4luR1xUpoMEX5YxpgbyAA/7awSfr2368Ef3G17z12h3Df/AwIHc4w8HWcPCNXN8zCixL70+7vWWdEO0rjm3QbmGUFaWXL8D1Dq0QG00ZYbd3LYXoIa4vO6XTERncQX5BucUpZuoGw8jXs5ZfnJy1YcrAyzevl0Hcf8K3IZLAV86ygfHN+eE03o468cf7dlvCFm5/UeJBYbUJXchte5CYvJ2xzDQtzvSpI8Pxi5y13s4L6Un2lSAhzgQXNntQg5Es5bxGxQb37Re5duDXI4Ow0ukGIbps7uZHH+u092vA9qUoymYC8t5IE/XnxnSI3PRLGszJl8vItaFF5ptroJ0szeY3kFNrbQHHSORVgVpDJvnapyJm/GUAJfU9adpRwWW++ZHqdSJZzuRlJ/KGOlg6A69GnK3LIiOmC2+YLiwy0IZeUG0WUqWAlztGeyaZQroVTG+AgliBfvrkw4oIa+ZT1gcPcw1zpZYdGMaalTUTpyEIUGqWNlmAy2mIpFExxTrFnydhyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(2616005)(41300700001)(36860700001)(6666004)(426003)(336012)(7696005)(47076005)(26005)(186003)(16526019)(83380400001)(40460700003)(478600001)(40480700001)(110136005)(4744005)(81166007)(6636002)(82310400005)(356005)(70586007)(82740400003)(70206006)(316002)(4326008)(5660300002)(8676002)(8936002)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:51.6684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdd20e9-3b36-49a9-be01-08db666ee76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/lib/lowlevel/linux/read_gprwave.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/lib/lowlevel/linux/read_gprwave.c b/src/lib/lowlevel/linux/read_gprwave.c
index 6d68b7e..d357896 100644
--- a/src/lib/lowlevel/linux/read_gprwave.c
+++ b/src/lib/lowlevel/linux/read_gprwave.c
@@ -425,14 +425,12 @@ int umr_get_wave_status(struct umr_asic *asic, unsigned se, unsigned sh, unsigne
 		}
 		fprintf(asic->options.test_log_fd, "}\n");
 	}
 
 
 	return umr_parse_wave_data_gfx(asic, ws, buf);
 }
 
 int umr_get_wave_sq_info(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, struct umr_wave_status *ws)
 {
-	if (asic->family <= FAMILY_NV)
-		return umr_get_wave_sq_info_vi(asic, se, sh, cu, ws);
-	return -1;
+	return umr_get_wave_sq_info_vi(asic, se, sh, cu, ws);
 }
-- 
2.40.0

