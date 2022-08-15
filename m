Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527EDC00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 15:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5330BCC70D;
	Mon, 15 Aug 2022 15:37:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC281CC6DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 15:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gET/HcHUICAXUB873ZFiGPk+lahrtkGyU4w5T6uaRt2yvO60u6WLLFFATd8DmNBkkQkIZPT5xVsA3zZQe4tRrMILsRi7KX8JNFMFJPlSqzlbnJDreP+fyzvexhvJY1x1+fP5z7pwyb/eE1xc35+clYwjSeI/QrQG3Ifi9ABItvcyUS8CiC6NdjTuXNQXnnF7CtQqXNOP5UvJYtr81bj0jh/Tq8VWC3UWl3WgZyMuyJGwRpCYsvWLK41K9CC9cxc7PPCfStjp/s4si7WdMxrcPCigmBYP4QCuEx9MNUVKDSTyg8BfM+KroDUe2ATxtpFW567sVWPWrqjAjc22baaHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aTZBcOC+qPFoW0cUbhT+Ahg7fw1lfLdbm28VfzP7CI=;
 b=b3oTNFLtCCrf1iZXYA0sUvQlkebdovVWHtcpe2bZxcYrMHYqRSXpM+E1M9z/IYoiRZnBDgD8PLOa6kouhGuIYzTmd7n8/wfaml2sOtrfkveFfNXEbNB/QFiFUICPJsPYyZJaHb7+ZwE/H+sIwKfO9vEb3wMOtcWPDSRik93TOTOhAXsYu5iPq9a8oGkLCZDzCFvYQ8HJsodjWMFMUUFf06ziEj48w24CwHhqBZy9B9xNs/BmAg7HygdyiTcfxPEMgaBpgTohfIeHJFQ6WjTz+I9YNCq4n1bJ2ilyyTgkZXutuuuUgOsJ4K+/8iZMLmybw42OHLWpu/7zczhybEqoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aTZBcOC+qPFoW0cUbhT+Ahg7fw1lfLdbm28VfzP7CI=;
 b=n/Ab/i0av5IcznL6lO17PcDwjmyBQmb+JGHmI9cIj/a26zf97KDvk4Fj17n4lqOp5Csez7cHc6qYteBVF7Jfee8nt4HrkURXrShZiI9E7cvQbKcv/mcl4GMfuW9/Vjefn1zo5Arl3Dej4zqFWZat4d2XlRft/P1eySW3vc/8hAw=
Received: from BN9PR03CA0120.namprd03.prod.outlook.com (2603:10b6:408:fd::35)
 by BN6PR12MB1746.namprd12.prod.outlook.com (2603:10b6:404:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 15:36:51 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::b4) by BN9PR03CA0120.outlook.office365.com
 (2603:10b6:408:fd::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Mon, 15 Aug 2022 15:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 15:36:51 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 10:32:18 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Date: Mon, 15 Aug 2022 11:31:23 -0400
Message-ID: <20220815153123.138156-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51376ca4-d086-4aba-6a27-08da7ed3f9b0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1746:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNsLR8CiSHkBQkyV+NmiGoNIYydq/2g9tQLEkZE6fyebH/inlHyQrNOnXPlSoFjtB/yr6UvAYPc2DNsjaorK0mOUDf2sD31ksEeXQHGpp9EBPaq3tmf5Rkf0Ae09cXRDsD2J+1SkDfHwe/6k+Oujw68mGZMwtTZMrH8BQJeJ2bevC4yms3Hs2tZnqRlfrOk7SDkcJwnf7Wfbi1y3zJe8brtTLBnCXSC5FAi8ZPk5tcn0a7nyb/BhGrz1cYYFZCTX8sxT0Mmlnq8Jq5XXlU6jtrewsS62PHtWk0pj0g7iqhnaOzi3V9wL0BaojgiPFVAGdyC+r2mzAtvV73x/OBSBQrB7yis7K4uN4oxnJmrKPk3j63QLfLUkzjZvjmbnsTG6rTmxHewTDZ2fC6Fc7B+hONgcsJSXWGs46q+NQ2rQQSdNWlRGl5EwyARWd4jopR4RiJTU7ndyijfk3V57y2a0JeDHWOrq0gUBgk8kD4kHoI4BFAxlN+A2phDA26cFgQIxhIiS4nLiX+q07khYHOSjJw+HyKIYWhoMykfzgowKpaQKic1fU7XQyE78hdiwNIGVzimydzmiPCU8h3DvrmIrd/dnkGNExlms6LLsBzwCpCYcPYs8GEoEP8TXlstO6SCic73J/2zd6eYX0QB8efMilhuX+SjWATfoENJuMtnMU4j1NGI4y6iKaQNcCB8E5PdlkB4v10Y2Ua6jyt3zdYAvY3cHXrqShKo/J0XxUCOWFaSTICfyl/Fde+bGo6rbeer7IrfSIt8GP/Z+WdIihx7OH+en0aTTco3UE2I/ZFh+aeKlG2csMZ/Sfth3HIwed6JH8lEdC4gy056OVXZNPYP01A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(40470700004)(46966006)(36840700001)(81166007)(82310400005)(356005)(26005)(5660300002)(40460700003)(478600001)(7696005)(8936002)(86362001)(6666004)(83380400001)(41300700001)(40480700001)(8676002)(2906002)(4326008)(6916009)(44832011)(82740400003)(316002)(426003)(54906003)(70206006)(2616005)(47076005)(186003)(16526019)(36860700001)(36756003)(336012)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 15:36:51.6915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51376ca4-d086-4aba-6a27-08da7ed3f9b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1746
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
Cc: yazen.ghannam@amd.com, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If m is NULL, we will end up referencing a NULL pointer in the
subsequent m elements like extcpu, bank and status. Pull the NULL
check out and do it first before referencing m's elements.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ab9ba5a9c33d..028495fdfa62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2838,12 +2838,15 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	struct eeprom_table_record err_rec;
 	uint64_t retired_page;
 
+	if (!m)
+		return NOTIFY_DONE;
+
 	/*
 	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
 	 * and error occurred in DramECC (Extended error code = 0) then only
 	 * process the error, else bail out.
 	 */
-	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
+	if (!((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
 		    (XEC(m->status, 0x3f) == 0x0)))
 		return NOTIFY_DONE;
 
-- 
2.25.1

