Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11404C00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F237B4B30;
	Sat, 13 Aug 2022 02:14:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BCAB4AF1
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1euJPkTM+Zg92rKziwb4VQDbRS1SnQwq5JAifSsH+Gh1KwPuBGxlpOgDcxkSr+5rAA+UpTWciyVwN1kYDlVO3SzPHeialI6fBsgg55M775Sdzc2wXHQo3A/cqDWgdgI9NaSxB+8jUz0q4C2c/DfsC0VViu7jZ0ByZXFTHDFcMnLm73YotdsDHuqX/ba7riKDdtHZtAI0h26Ci0y88+OfX1YtL8msCssRg8D9sRfzy/jnOK5bAIf9h4yzm0XN4RGiV7tWr27vBAxgaLTQNFXgeqwtoOjMiLEKfneX8Qz8G3WnECREY3cihWKmCsynouR9DNIPz8MuqdIX/b2TsX/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zgvXfUip0B5Lu1vWIJ8y4cfkBiFOAbl2cW46lt+OIY=;
 b=FW4OFYCgO9NWN+SZcGYTN6C8o4Jx0jCoF9AGtZXRYL99LU9xkCgrYtaX/U39PQr3eKWPVZMDglneydEQkcyVpXST79GPF7ijybDC+VNWUrJ4OkpHT6WB1R5rLoTJUAH6nTAbeIvy8o5D/MXskh5jkIXGDk1QdKE8hETAnqFbti5dywcGxzKf/DR6Em4Y6K1ZbYu369FifYVAUGOy6HHPqoQr3tS9Tk9s2BJGlnzeqPJNUB0YduroFDjFR0DEdSHvkgZcFOgqkub6rVyQDrSHfSMfBQ74ZcufLXNLfb7dgCSAiVb7NvfPSz6Y1E/kjVBoQoAoGfX8EV7bi5zdLhLJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zgvXfUip0B5Lu1vWIJ8y4cfkBiFOAbl2cW46lt+OIY=;
 b=iD2X8lPl9KS/BQGaWvEV85T/S0BQ2cGwW/5xxHth/khLEQwzZY7M33VVkb0B7CAisRWWoBnd5WS3xvAQgfSWyAOzelpEkz08eMYQPDsBtAI/fSqWdzT4pZ8zlgGZ9799xmX0/mzacE7dMv7wy1/ATMgp05c6RShq4vSqO8wwb7M=
Received: from DM6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:333::27)
 by DM5PR1201MB0236.namprd12.prod.outlook.com (2603:10b6:4:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sat, 13 Aug
 2022 02:14:03 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::2) by DM6PR03CA0094.outlook.office365.com
 (2603:10b6:5:333::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Sat, 13 Aug 2022 02:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:14:02 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:14:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:13:46 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:13:42
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: avoid doing vm_init multiple time
Date: Sat, 13 Aug 2022 06:12:22 +0800
Message-ID: <20220812221222.1700948-15-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4517692-95fc-425b-7939-08da7cd17e06
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0236:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GdsfUcu7cItUBgihITV1i/GFua1nUrcqPjAVoGMUOxfXbujdijVh5iQ3tJdz9cMNqtUvbjRjd++q6iIX9lnoYaQ8xTnbrTb+jPjcIDwSG5U3o3xeM56efFGuCkXHxS/FWkOaHKa/Y4qAt/i6GvQiwkIAMzLvC54hrIUDxR7h7S3SxcSMjmGH7n7HskQy9Bc14nO5aUrcDGaafBof2gNc/kXdvKJyTvEOeSzSiHRvcELj9jJsbL5Yc78estImRXQSTNYdl57Z7tfHA779cGA+lQqo11m+PYd96sHc/Z7ZdmxkYABWPYMiwfsi3KfbFMQx+U5mHVKp2ADnztccL4GhAvasCx+8teAMkLGSL0/2XTtpma+Gg9I3L6xYCzNQvjit1y4Mq1E6yl3FkXQ8n/ZNVKrdp2bXFS8lUsW101HPTYaESzQwtcT0mqmMyBXbp1ziiUqxdWKKl/o0j62/TlBDKe9hi5IaTDVm0COnFUXb6A8Wet/9vu6rrWYf+orL8r4gzuJpqGa+GfQQEEJoA3k5jiRX01pNffToJm075nsL1+wxfg8FXxuWc2HD1Nt5suSbLsBV0y1dIiQnSWtRZSde2+vuznWdISpnjQ2CRkOrU2aVKuoz6YbRb89+xkTD7vhjdlAZkWvG3WpPOBIv1FcOQ/tHuXEvZeosK5NAtMgQb0Pd/fh2i2cK/GkAZmRxLVrZY6YWhjPzoeAY1tfn5t0hZkOThptEKSaH1XEcAlLX9hJe+xvT3BuDNQLgc4hbyZ5tjdK3hsnRyy4a2cV8nnmXRf5q86shCXE4kx63RUhJCtQxyko8+W2iMk52fp9eWka+wJ7Ixqu2FQG7pFMcXIzpEkbVFchfSPyGwXAoTr4P78s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(82310400005)(82740400003)(8936002)(478600001)(36860700001)(47076005)(2616005)(336012)(1076003)(426003)(54906003)(186003)(5660300002)(40480700001)(316002)(40460700003)(6916009)(36756003)(81166007)(86362001)(2906002)(41300700001)(7696005)(356005)(83380400001)(70206006)(8676002)(70586007)(4326008)(6666004)(26005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:14:02.9615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4517692-95fc-425b-7939-08da7cd17e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0236
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
this is to ensure that driver will not reprogram hvm_prefetch_req again if
it is done.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index c5e200d09038..5752271f22df 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -67,9 +67,15 @@ static uint32_t convert_and_clamp(
 void dcn21_dchvm_init(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
-	uint32_t riommu_active;
+	uint32_t riommu_active, prefetch_done;
 	int i;
 
+	REG_GET(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, &prefetch_done);
+
+	if (prefetch_done) {
+		hubbub->riommu_active = true;
+		return;
+	}
 	//Init DCHVM block
 	REG_UPDATE(DCHVM_CTRL0, HOSTVM_INIT_REQ, 1);
 
-- 
2.25.1

