Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FC020801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E4OXbb2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FC020801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297B96E47A;
	Mon,  8 Jun 2020 04:59:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F986E48E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAzUdd9CRf40xuwaADtZFANgcGnrehCWh9EbiBUtFhwfRf/R3C3edCq2I7AD9q4+scNOUfCj7cnbbm6ZM1PGhr6qrOLKerE46I1RC75OGaUqn4H5ByBLSlejF4LY7CW9Tqsvazpb1bNbe6ctiP0zZXjlURFevi5E0msnOKCgZ1F2Bkj90+t9DGSX801RkVB7Zs2uvFwJT7TJ3DLWdIQ0qctDFpV69ZseDpcr/tvJKz5meDLhPpPCvuMeH8U1rGUXMmPvaNdY4LHxD5fUKK9JNw7krjVbZa5Eca6rWCgKvBD7aMZoSxMuTNQTxrKr1TiyTfasVbE6royLdJNTXAEG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU2PI40Mgwvy0IS0SgVkTB+DTnHZw07Qt/qljMnR9XM=;
 b=ipOZWKPJiRmLw1F/VZWOFkGyMR3w7tc4bKUqdkLsRn8X7BE8br6iiIIcacZGq2U0IvnzV2VI/itwPkM+LqPuV4RXwsrMf89vt0aZE++BIYm8AXSSzGs4bmV6R8GFQVS67CGAbWkmK0Pfy0zg9R6gVAgI1nMGLdMybQkeuQt4ltaHvmkIVsZ6l9br6KUJp4Za1g98sBkPnt2aPpmTcz/H/wCcCJ7pm36FMWn+LV3Zfe9hQ2yPPOxmyo9U2v1QH2wnRtLEk323y/9xEsjaC6GHfMWRr9A0DFNSvFRw2AmMx3YKm/oTnFCzOu+aUg6ZITtXQxGr+3I9Ix+VtuHkPtgF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU2PI40Mgwvy0IS0SgVkTB+DTnHZw07Qt/qljMnR9XM=;
 b=E4OXbb2sLx+s9853lBiDOPZ0JuW8awvzS9JaNFQMHTeXYI0NKuZBZ64YihL2u2tE8W1puuRD6UiZMGqiIK4snMqeOgje/wEsSjbBkLdoTnmCeDX3cKE0sJCnxls9rZnPfUEkLLD8ciixLHOOCX8bZudnKnwHRrYZDmGT8YywhXU=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by BY5PR12MB3924.namprd12.prod.outlook.com (2603:10b6:a03:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:46 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::19) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:45 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:45 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:40 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/28] drm/amd/display: Enable use of dmub iff dmcu is disabled
Date: Mon, 8 Jun 2020 00:59:19 -0400
Message-ID: <20200608045926.17197-22-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(5660300002)(70206006)(70586007)(86362001)(4744005)(26005)(83380400001)(36756003)(6666004)(186003)(2906002)(4326008)(1076003)(8676002)(54906003)(8936002)(47076004)(478600001)(426003)(336012)(81166007)(82310400002)(356005)(44832011)(6916009)(316002)(2616005)(82740400003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaf38a0c-f857-4aa8-5333-08d80b68c3e2
X-MS-TrafficTypeDiagnostic: BY5PR12MB3924:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3924058841642952ED913EE3FB850@BY5PR12MB3924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7irvqkzaFfhfS/D/PoDsca1uUvwI6vhIj+T0DnNG4GUX6ruZvnkoV/fhnX/uCFN9JufiOr7f2NoCgb8+Uq2zJ17HbjcfnjsZ+Pn6DLqvKeR5vwIItJUF1LCsU1e3d1GF4rCSSs9DGrcrOXmaHrOTp/Ix9qnQF6z2DvcVG5rpwu7YsdiYF176A+Ewd+ikVoRwyVTbCASPWFu4uiNy0H6T++7F162uWwhC6VRjwJxLUzSZpSqvZBWq5CKwXxG4oXLOk6b32s2NZxpQf6qOXnrH36tmSHT2zbbCo5yt+0rbVwH7+XALHUkaHd9c8CAkRSu2pcuONxzVqXcOH7uwDVpsnCe80RBo/18cxwwETOs6gltIJrDPh0M856skxkgZvtxa3PDkr0NTCSqHag61YvJLA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:46.2989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf38a0c-f857-4aa8-5333-08d80b68c3e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why & How]
DMUB command table should be allowed to be used
only if dmcu is explicitly disabled.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 7a37065c55d1..7a038eef8902 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1906,6 +1906,8 @@ static bool dcn21_resource_construct(
 			BREAK_TO_DEBUGGER();
 			goto create_fail;
 		}
+
+		dc->debug.dmub_command_table = false;
 	}
 
 	if (dc->config.disable_dmcu) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
