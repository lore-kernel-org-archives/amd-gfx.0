Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC95C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19EC361106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19EC361106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F6C73853;
	Thu,  4 Nov 2021 20:52:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374B27386F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/4mv4uHsfk+fV0yETJ5mM7CJjkc8UNp3XQzBIDc2NyUjhEyxIi/Irqeds81avujRtCmL6BhYlgLtzpJGQ6nVRnRM1KZnDJpJUiQUWv01frbITRkp0vanhoNzqtZucfY1yLYYXU0A00bd3wyTRWbXO5nC6vfmCju8nP7vQzR0dkpIkbY3yIsVWtlJ4nuJIljnj0iraupARiVGqnV8JdDfL7DGwdwcfU8YV3awN8lH1LdciL9DeF+WqFwRFbFjRgf/kL2HYJitXKgG32zT5F7BsSG3hBWngiueX+z+NrYa78wsFTgOLYyAXTmqA+sSpytJ/pN15cfoOIMchs3I5F36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLTGnbAL8pGFGiO4/ocBNzw0OYH+fnPVGqXqhtQcikw=;
 b=lqN5IjhLCrxzH3hV0nVhHcvvTco65WcTvT6Rig2zCXIFTiWSxPJiXC+i1+ErQFJvP4G2gwZPZdSX0RiGPwSEU/btHHgl31cxItuOWAduKqJcnQ0C2E+6MZeW7mkNHPSAeWpyFA8KMtzww9TNUhy+6Gx8cbUvY2FRLBPgFzDnaLoQ22PHHW4IPD6vbALIGaj7mGKl6O+/QVLMHnFB+Y3eOh/eeNvtLIFwsUMcd4UdGxsOfc3KM4JHm6tSe2Y2m/HyL6schBgKq2HwIS6ltHCI2wICjeEES5z72y78qf8pOjvxmNkVy2BjwbFD6mhz6sYuepBjA2HbUYm9NtXxpkdu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLTGnbAL8pGFGiO4/ocBNzw0OYH+fnPVGqXqhtQcikw=;
 b=damdbCBRjuqrI9R1vadRses4LZiD6w765O5cdxJaZg23vrsT2MXcwgoimrRWRFs01VCoAHJ9nFSMkuz4ECc71T5zPlVD7Q5+4jhXyZGRZ+OcniCzor4zaS8JRULCFGPV0Y50/djllUFyTJHuoYsUenP9x/oeHTy5lUwu/BM90TA=
Received: from DS7PR03CA0297.namprd03.prod.outlook.com (2603:10b6:5:3ad::32)
 by DM6PR12MB4027.namprd12.prod.outlook.com (2603:10b6:5:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 20:52:51 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::36) by DS7PR03CA0297.outlook.office365.com
 (2603:10b6:5:3ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:51 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:50 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:49 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/22] drm/amd/display: Adjust code indentation
Date: Thu, 4 Nov 2021 16:52:10 -0400
Message-ID: <20211104205215.1125899-18-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd326036-bb63-405d-3a0d-08d99fd51123
X-MS-TrafficTypeDiagnostic: DM6PR12MB4027:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40272B3F0FC47E50F536B069EB8D9@DM6PR12MB4027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3sFqBJkVxNoxzW87zozgWcrhYAwfN4FQR0a7/JyeVt39LiBKSM8f80ERsBORlPAuSXWnTv5083+6eNpuehgTWlzJLMK4KW7cGTtwl5BwCB35ectyTnIKVbLWpSj+IGYqcsozMnIwrelp0/+VbYGMq4DyPfD9KlQWdo6af7ZkAVvPT3PP23yO8ZtMMviNsBcmxTDSdjfXom5KIeAMfBtbykV2oz1T5mHn5ubwiKGvMErn/QPUJ6UxXWrJi4UjMvZMAvX42YaYxV4fW5xt4wHP8IxeqsGO1C8AZk5pwUYiTMc0KZjRQ8au61CR/pIxl0g45VyFWCmy9g5BMJFSWY/5rPWlDQ3WE2g3abbDjZgIjvYH+6pGR/Qn3v9AA20pcaoPZNi/OVlCtbpY4BpJRTUiGHG9nqxsZMWCf7emeixCiAoJZ3tmBQQ7yy1se7uTejTbOnHJadPVqj3jHJyrhg7yPHVNqNSNsC0+cSRNvTMpIOf6XsXuz0zihbbVg3KKoEfJ4mVlDIMjVN0dY+cnAkLqCFzfYP+YsHg3s+Fe5Yqkjty6rhwyXX6Z2cyT/y8fnCq0Ojgukuf09RWSGMCX72m5TzIAFBawcRAkD2IqLjPkjrMG3HYudOGiV2z5dC5olrxzpcywQWKkmROgcf3FgM80nQOka+tgFE2q7VsgJB0qcFa44zzAoIbuoEZQLd6OSTAbUpqapXFDzntCzwV7fDwZs/xRPPhFi/4tx6cI+HkIYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(70586007)(1076003)(2906002)(6916009)(70206006)(356005)(5660300002)(81166007)(83380400001)(7696005)(508600001)(47076005)(6666004)(8936002)(36756003)(4326008)(8676002)(2616005)(54906003)(4744005)(426003)(36860700001)(26005)(82310400003)(86362001)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:51.3138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd326036-bb63-405d-3a0d-08d99fd51123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4027
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
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Sung joon
 Kim <Sungjoon.Kim@amd.com>, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

Reviewed-by: Sung joon Kim <Sungjoon.Kim@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0ded4decee05..e76a2aa65a82 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -221,9 +221,9 @@ static bool create_links(
 		link = link_create(&link_init_params);
 
 		if (link) {
-				dc->links[dc->link_count] = link;
-				link->dc = dc;
-				++dc->link_count;
+			dc->links[dc->link_count] = link;
+			link->dc = dc;
+			++dc->link_count;
 		}
 	}
 
-- 
2.25.1

