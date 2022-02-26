Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C38C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ADE010E289;
	Sat, 26 Feb 2022 15:41:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD0610E289
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgtkghcJWtOfGQBjHC96y5+v8fE8M+3y5uicVRQ5q122ztK4w/PhccLVRaVgXTMa0CJKd6OdHjevCsDwUx7eywZZUUfMvvU9/7LwcXGl3cWxJK0a9womNLk/9eJjcVjot1vfxVRL0IvaV/TU3i68A0tOUlPKtMYqUkhF+a0tyL2yCYu8GB66Ed1K4tEHqCg4jxe2Hmwjts0eQgPxbrJz55AZ70GZNa1g89pyNw2b5DVL24ZB32eRfRDhfQSBnosGDVx7fkUjJ9DO/E6N0gWEVspM/JVa0p/1OjHruxPl8Z0oyiuR/NIoUl919DgaAaWtRW4fnXY/57ryoKJ6pBrdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUWySAoMum7nf3osY8G0rOupMLKyPridjVIa61X+8ak=;
 b=hkQY0eltbPiT0dyCPzweLSKSlDHx7dVtKgvHxnMVRzjycQiG/hrpUxv8wEx1Tsi3s2tAgsi2yF7Nnxl/EDVK/mUKcOyJLE7kRiP/MPA+xDP0wAwDoPrEkFJ4Nxcq367F50JX1ia4RZq61kQSQulsXq7Wuue4fdn5EjItAvIOju6kjMyBq6FrbfIda1OjDoEPwikDf6nOr3gfOfdN4uc2EhovQ/RoTV6uU6MfrfneIxsJySJAlz9KfcEJCnzioF3waFvIUSJ2Zk17mCyFmD8Xfi2HNAhKGxgnHHZdKtk2jIbs4+M7/a22glQpcKaJm2sGLyJ0DG0/WRjhhBkLfh19IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUWySAoMum7nf3osY8G0rOupMLKyPridjVIa61X+8ak=;
 b=3plWnH+uiyAN+qjgb1OuCpC+99dUv69cmmbmHANd5wjDIrq7mBLIwcCIKOapRzQqlePGIXIH8ar0qbhceyRI9yVvBn2yVk4dJluWm5AiY8fpeUsDEMGV0D132a6woP2Uz86eL/9gnE3qxrla+dJwAvM/okaTrqIzU8QpKt2fNpU=
Received: from DM5PR10CA0017.namprd10.prod.outlook.com (2603:10b6:4:2::27) by
 CY4PR12MB1911.namprd12.prod.outlook.com (2603:10b6:903:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 15:41:29 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::4b) by DM5PR10CA0017.outlook.office365.com
 (2603:10b6:4:2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Sat, 26 Feb 2022 15:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:41:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:41:28 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:41:24 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: Remove invalid RDPCS Programming in DAL
Date: Sun, 27 Feb 2022 07:41:04 +0800
Message-ID: <20220226234117.3328151-2-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d14022c1-14dc-4b5e-d23b-08d9f93e74e9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1911:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1911282D2ECDB404ECCBBA3DF53F9@CY4PR12MB1911.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ct8kk8K//udzKooHGU1lxbJGMmgad5fnduGXqCKBkBc0lgGXhuaKM5fLTkLUbP6+OKwHL7zMmoND+OM1GEe0xmJtR75dh9dzf8Cb7dLGpZjkDvHPnlz9GvW1KyDWLVmAmo8BMOHvNkzzbPP3wh9t2Qm/gWoOYGWi4UsYHz0SwW7FB03U2maEy8eHP3LdO3z1+XXuIrdGAiSNjsbWs1TZQAXo/M+vEArCkNv8a9QzP35APy5AocjN7HyydKU9qSP6JSnSeDFgY3dLK9EVqwH2GudKH6d9Q9ET4A2BOhP+YNm7IQyfjlHEfhimagw7H+neSfOLtZa/GanRDP953GcEhb4KTPEAQU1BHMklQu7gazhNRdeaHJBAGxUcwt0RRcwgrbcHmQ+v7t6Cat6PyZGAIVgXhNAKUE96mA4GZt7ODcD8dFgX2l7DkDPab/GxCNnCIC4NLH1mOwolsuhQ759828SUbBhzDyzTg8jIi9m7sLzL8eptG9LSG4PKNezTK6RyKeJYCyVaWTFII3RxLV0fHfLRUlWqLXm06jJgUoDG/oJ0PsK7KNft8yBVCPYTW+Vj/6p/cJxQjsOhtAeA2fXa/jgGRoPZVak2Up5+74N4V5q754UWh7i8BXvFuWQxRWJG9D9Q+tcr9UB0CBUHvnaxY/Yq4Ii3AuucbUmgVd92EZs2DHpafvupsdNdmeAptqLQO0a4R0Anolj2u/XWlXcLjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(36860700001)(508600001)(86362001)(2616005)(6666004)(5660300002)(47076005)(82310400004)(2906002)(186003)(7696005)(1076003)(26005)(426003)(8936002)(336012)(36756003)(4326008)(356005)(54906003)(40460700003)(6916009)(83380400001)(8676002)(70586007)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:41:29.3311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14022c1-14dc-4b5e-d23b-08d9f93e74e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1911
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Hansen Dsouza <Hansen.Dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

RDPCS programming is done in DMUB remove legacy invalid code

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c    | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 8b9b1a5309ba..d94fd1010deb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -240,18 +240,9 @@ static void enc31_hw_init(struct link_encoder *enc)
 	// 100MHz -> 0x32
 	// 48MHz -> 0x18
 
-#ifdef CLEANUP_FIXME
-	/*from display_init*/
-	REG_WRITE(RDPCSTX_DEBUG_CONFIG, 0);
-#endif
-
 	// Set TMDS_CTL0 to 1.  This is a legacy setting.
 	REG_UPDATE(TMDS_CTL_BITS, TMDS_CTL0, 1);
 
-	/*HW default is 5*/
-	REG_UPDATE(RDPCSTX_CNTL,
-			RDPCS_TX_FIFO_RD_START_DELAY, 4);
-
 	dcn10_aux_initialize(enc10);
 }
 
-- 
2.25.1

