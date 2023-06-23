Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BB9C001DD
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 19:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32AD10E6A5;
	Fri, 23 Jun 2023 19:41:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E872C10E69F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 19:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2oZQkj7eVAQurjHwTjGgG5CHYxBmFGWZHhXk1Bc93hSjEvaK3KvcYjFpiWl8Eg+qqStJFWf47mDp+cE4jSsu/LTK6B2jV4BOFgmthejlPeqaKS1qr/PJXgbhHxYIZC2EyHS9pBeTSdQ+qVapELQEYzrdcb938I5LtsOPfoTF+kLIqkGQz9PZlSvoC+qzMK3CucxjWxhy3uLQ/1Y5OoyK2NySS2C5CTcUUH1XlODb8w0kWmAHdPvsAi1Oc0CRuGEs8yOhi80zHZNRh5shtxI1z7HU4WmYaFlKP/vv/yHrJwdjEL4wlLMoBIUj7aIF52dB5tUcOdOczLLdqdW5yw3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leH0VZRBh/Nh5BZoJJibybM681JFVVhNF15dpUVOQ1Q=;
 b=noGbeNovreotY2hrIhZj5Vt/frR4d2013rP6ilyJ+W7bDS9F13d8fDnyaGN7iJH7Y96aidxtE0bizY4/i4zrsNUk5KMOX0XZ8HiMW3HdCCaE8HyivYEiBjYTvCz1TH4wsBVZc89lNRXXUa/P/J4YkFdnKUUGAXT13QWN0xorQzNKvfH2KRekfYZkFNHGHvpxR/4GyLd9Lh4KEP017eLpAuJ7+o1b7dncMj1hbGTrteAa7SHbJ/ElxyvZG1BnJqvJc0iDo3y7/CqpQgpLnzHQDeZaaPkZ3KgUzkvrp/Y2igLrODGVSpYpZRORX9QHzYlmI0nA+jKoErGfn7FU/5dgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leH0VZRBh/Nh5BZoJJibybM681JFVVhNF15dpUVOQ1Q=;
 b=el0jnmQt14tdW2nsfRg4RoRL5gsHzGUlEfjb+qPyYgWy0zt9cBOmwqkUp6487UyBtBhMX2aYZGVSFbpXAnYe6YuhbeCUVh7txbK7ALmfq3zXlFeUiu9r1vyoI0xOIMSI++5l1mY+p7rY3Ngg0L04rVL14h/5g2amB1HIbvStC5c=
Received: from SA0PR12CA0008.namprd12.prod.outlook.com (2603:10b6:806:6f::13)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 19:41:03 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::95) by SA0PR12CA0008.outlook.office365.com
 (2603:10b6:806:6f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 19:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 19:41:03 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 14:41:02 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/4] drm/amd/display: Correct `DMUB_FW_VERSION` macro
Date: Fri, 23 Jun 2023 10:05:19 -0500
Message-ID: <20230623150522.32494-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623150522.32494-1-mario.limonciello@amd.com>
References: <20230623150522.32494-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: f1117aff-5599-4850-3b32-08db7421c75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyzLlI4GfDliBVwXmOfMJ/9SEMg6tQPs5Pxnn0sckssZltD2SHVUPX1e82XJdkcx/H1TSrgLw+o1+/GfO6+S0Rr+PbKPG4TAd+V88CCu3k37fVSR+a0rnyaqsTC+2s+ZzIS8bV9U3LazfgtxEN4RoNnxD2GLy0JAitT5QfDPZ72aMj+wEKk2DyRsVfypPtbgcgmAyowBl3gZbwaM9V+9bjjGvPL/SumCGBdF5OzeIw8FxiKMXpGlV/UDncsQTplCvuHZclvIl0m55Hr0NTLQrBwL5Lv7gW9EyTQBpaa6Zt4FvI6qBExCmfXAuMOfJr63b93nH+qg48rf+wh109YsFiDSwYNqhin0EdbIXzWKKLnB+24xOYcSTO0RhNrnlOl5mOiWI9dgrjjCbKSSpBmDC545sj7qdgZlrhnBefJZgCcv8gS0LRILT6PdG/TnZQ9l3/d6OLSxHRchhrjvE2vIDyMKuRaJG+IzVIJBsVsjiTHZ7bCR5CI5mwXeoocubkizKwO16bPiocmZtjfayMhsESXiOgSNBmNEJ+9T84HeM1FkZ0W1NOp1dH28vXdmkIywwFnO3pnvqpBcFzTE5YwCeTpSuP97K6lyZh5u9PtBmEXoaUhXjT5LpTqJnnRAvTLuxv5HI1KjAe6Pg6WHeZwn6VwFEK2CnMoZbY1elEzuSJopPzeKXL0MeoBxUCJiyhqhK1UkXZMdaTjj2R7likLCDp9asxTKrB+j8MtdGzJj7JQrJJq83zRWK+LxIawKGUU0HTBOItFJ3vevASvzi7hDLKfJQqRe7DJ8lWtFhn3Asy0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(1076003)(6666004)(7696005)(82310400005)(83380400001)(81166007)(356005)(40480700001)(36756003)(16526019)(2616005)(47076005)(336012)(426003)(36860700001)(40460700003)(186003)(316002)(4326008)(70586007)(70206006)(6916009)(2906002)(26005)(8676002)(8936002)(86362001)(44832011)(54906003)(5660300002)(41300700001)(82740400003)(478600001)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:41:03.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1117aff-5599-4850-3b32-08db7421c75f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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
Cc: Leo Li <sunpeng.li@amd.com>, Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The `DMUB_FW_VERSION` macro has a mistake in that the revision field
is off by one byte. The last byte is typically used for other purposes
and not a revision.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 7c9a2b34bd05..2a66a305679a 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -492,7 +492,7 @@ struct dmub_notification {
  * of a firmware to know if feature or functionality is supported or present.
  */
 #define DMUB_FW_VERSION(major, minor, revision) \
-	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | ((revision) & 0xFFFF))
+	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | (((revision) & 0xFF) << 8))
 
 /**
  * dmub_srv_create() - creates the DMUB service.
-- 
2.34.1

