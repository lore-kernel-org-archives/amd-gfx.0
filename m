Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E743C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2C0112915;
	Fri, 10 Jun 2022 20:53:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6F3112915
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqG/QgmNT+dS9W3/SKYNl0IFvIbjuFKu5WH+GZumxbHv9CI55VzJO/Nw5+lEJl4q+lAA/HjWS7f7JlCG4i+7scTEDiVgYMDiyklajn7NzXoGCG7g3Ulbvqr5ojtyF9TqYIr0DbuSAcFX5ckpBmV1PoLH7v/TNXWqT769bMMRPGRJpXKOGcfooDJKoVrZrG+LPGBgAbDf3Bp0CBAXvCz1yU80yFL8rgLDxbCmbLpnm95RNuRi/sXiVCxnVY0kCZC+P7+VSgpCjmk/+PGju07NRQgAB8X3knPYe5YTymMQ4INH5RdDRkxbJF/9ROsf+5wXuO5jeFSt2IHJ36ARh9Vcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzEvrCIX5wEPjb2P4m4r8J8BxYM/6W3ZFM+sU5NoW+Q=;
 b=Je7x+acBbt4pft1uhTjZEzR1yKAwQt6KfLmj76LLwsNhlAt1WEWUAaA54gFtjnk/KXlLFqGgZViz8huox5eYJiffH0bHd2PsloQMvkUZnsNCVdprGROyyr/GhVvYQ/0nIR3Bj08bXDUwru3Zq0G7VrMp9nD3CIb6xDHyLtoq40FgMSXN1ZRfdjmNXEQqMlsg6Os5YwqZR7DmDk8p+mT4Sm3PYL4DqHM06Jxu0x2+4Io6U/snZzH6amNIcBNDq4aJpe7TbyJvAb3vcQJB0WtxuHHkA99GFSzVr2iDNd3a66xdBocunvDsbFmWkZwAVQ/SyZZFWO00WokgybpDBjpqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzEvrCIX5wEPjb2P4m4r8J8BxYM/6W3ZFM+sU5NoW+Q=;
 b=utersYVNaX8JB5PB/KUTu6EGn5EPJ2tdbD826Hd7BY1XNZxpIVhxFhUwXkLtHFfTJIo8HaBCXXojrWNqpZGf9eU00PwPBF4ZZ7VAs66sBQEDvAc4nlLtY0tV0c8Jf6+5kLs2xDGFYLX1hyu101EYjrHW8NqN4FsBNJ1Do3NB0/4=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 20:53:35 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::84) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:35 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:31 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/23] drm/amd/display: Copy hfvsif_infopacket when stream
 update
Date: Fri, 10 Jun 2022 16:52:39 -0400
Message-ID: <20220610205245.174802-18-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6a5165-6366-47e0-a2b0-08da4b234995
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5405:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5405497488A53655497F9B9AF4A69@SJ0PR12MB5405.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9s1DctXFc0xi/E1zFpHcic6y8yuL1KWCJi2waZjNd0o41yOHwa4ZcEO3iBMSR8z6NaDLXQEVDClLyW5svoeofPF/RNQR4//UzxeefB/WN4gB4363WxQw3clf4veI6lEuSguOqXP7sWZ5x/b0E7XZYYUTWXht7YgcaTYTaF6aBEs8T1sIg3VFc2zd9374voJEXPKmu3zx/0o4kR6lIh7IQvzV+de0XratXEwCKqbiRMk2czD0izfJVtSrtLRtS20wyrB+d7NAM1C7TsYbOu7mXQmCmSVUeK06gsZxLTV7YeZKWiSWpx1YSe9bGAZhdgadi0kpypNRZe9R36/qE1Vw2lm5AHfLL2gIlfDJCFEdVHPkLwZKuZbuYXpQaEoO4PVzMzI64ibbzsjsMvbYAoAwunUufsz6/cKtty8ToaiTZbR9LD9SSHR28jCPaTEl/T5Cy/x6Rs+AAJZDLTX95vVriQrwkebyWse7RhPNiALJN3aaDnNqnuAtqPuDNNoOFDk9BO13AzEYEs1CU4Qoyh95t1B/zT2cateu3mhjJL62QC0fJqMkeNXKn/ZIbbSrPxXgBv1SLq82pJ6z+HbmN4FYXI+flzcrRfmjv4UP+uRXnNOpBcJ0d/9ODUEs3vQNYaZip7T0FIIdpcuYjPD/+s73ozBjJWfTi5O1XCa5fR5gUGChLRuDXKIoHMG0o9qoMpaUe9QlA15NOY0/aFdha+xtNAgdNThAS2vGjORyhw51YmiDa8EhSCgN5L3VNiwrmlyX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(26005)(16526019)(83380400001)(1076003)(2616005)(4744005)(44832011)(316002)(40460700003)(36756003)(82310400005)(5660300002)(336012)(47076005)(508600001)(86362001)(2906002)(426003)(81166007)(36860700001)(8936002)(70586007)(7696005)(15650500001)(70206006)(186003)(54906003)(6916009)(4326008)(8676002)(356005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:35.4953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6a5165-6366-47e0-a2b0-08da4b234995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Miss to copy hfvsif_infopacket when copying stream updates.
Check and copy it.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7d71fd61c0a5..400b37e393b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2658,6 +2658,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->dpms_off)
 		stream->dpms_off = *update->dpms_off;
 
+	if (update->hfvsif_infopacket)
+		stream->hfvsif_infopacket = *update->hfvsif_infopacket;
+
 	if (update->vsc_infopacket)
 		stream->vsc_infopacket = *update->vsc_infopacket;
 
-- 
2.36.1

