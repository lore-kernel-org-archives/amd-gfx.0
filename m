Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B20C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Mar 2022 10:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C9610E340;
	Sun, 27 Mar 2022 10:42:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84E610E337
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Mar 2022 10:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrKPVWAhUoz8RDHmp3diR/ZzH79Vbp9r9YhvY0CLHhbeIHJLqQEihfGjQjDzEy4aMNiE1SvIn94GDhmp2d750bgnmWNZ32oKIM76tbIGsTZLDWtbBRnX7KOaKBIDZfnsub6A0CiTFqvd8H40EZQs6K7HHvw0FFP5LYd9qP2rWdBSEi38fm7BDPQTt6oaIH35kaXBdroZgvzI/KW/RIU+X6dRwFPbOgOfK2SzAI3yxNMEp15q14rXEm6BP1AFNXUc71VHVKx7fiSR1QAdBq9V9x+rb/eSQ6OKuabiT+vRJ7mtrfjulUmjETAfSCSVPFLRHQbBSN3gzhmEtpUkx91sXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYuugCKFJHf1mnWvRiX/k1rL5JHQYlISfKnT7i4L8Jc=;
 b=Toszbghl9KM7P5YB0n+CGXZ9UltBY4bwdfVJknp/lY4KHTrH7/4+SIuZiU7Gxhqagqz20evZMsKsX9uKasJKYUqCYOBNRa2uLYw6wdlh1yfDfok+MwOUJOmqHHKkY71n3XAuzkJwS1jsoiuH4hod9PeA9d8qbMmb8iGxc2XZ8D5CtJvwQuwM80jE60l7YEd8YYhdSIWKyLsKGjJ0TP4ZqaA/xrsisS4kZEYX7YLRJ0IDvuSEsRu/3mX6wJmA6I3RmfJnsZ0nUawD08018mYAJKXzYg9/9YZbaflwPYPvXnZutqGMTlMCOFPGS7TIuyOpFVISpDYVnMmlV0yO1MjMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYuugCKFJHf1mnWvRiX/k1rL5JHQYlISfKnT7i4L8Jc=;
 b=UCoePZn1lbc5HbV+OoCJg9VMbO0dspbyDC5M/+ytv9ROPGRWTd9LS/vmPuDwLXsZciI1sy7ETzuy43WDmnQW9zukkZh7eCXgkamQfH0dwZQPwbTeCrxbbdtRdTBUeEeEh/mUDc/klTsGVaE2tBLHYBDV9VOmaaup0rNs/z/Bx34=
Received: from DS7PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:3bb::35)
 by DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sun, 27 Mar
 2022 10:42:32 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::9f) by DS7PR03CA0090.outlook.office365.com
 (2603:10b6:5:3bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.26 via Frontend
 Transport; Sun, 27 Mar 2022 10:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Sun, 27 Mar 2022 10:42:31 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 27 Mar
 2022 05:42:30 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] umr: Add support for "--ppt-read"
Date: Sun, 27 Mar 2022 06:42:10 -0400
Message-ID: <20220327104214.106340-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 159e874e-2937-41cd-a479-08da0fde7f5d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1259:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1259B83B355043FE2CC0FB73991C9@DM5PR12MB1259.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5VY6twt83hCLC0RDx7BKTorxIZs068mmQ5X3Sg7vVVMMjhv88iLfp/nxPbTA0o+jahzmtUEBKgggsXqsQI53IaXoI55GKX6WLkK1+UsdYshEoGACLwBlk9yNHh+SxAYInleoO3fj8697Xpx0toyZirfC6jbANImHTgtr81kNLrRhVwiuMLkYfQm/3rFRFwEReZAiJj1ddlvYA5sA+lxdA7pl6wIYq1Rymnu+pnzIjArircat7YDzUApqHQaQGF6HaUSjeB/0jjeite4juqfyRfRKm1Wpr4ASstRtznUpBlkWtM3Jf0tfmvsXAGSFDxglJ63GPztML5pF3YCzEhArfwh29qu1qXHo8bbLqT0dryNKkIBmNO4fzWhRKXwiNtEP8wJcStKKRs7AdwFappIp93g99v5pKSgmKffEbEX9dwrNpT6shyizUKu7H0g2rXiFKVUJDq4x2fkVEbzXKozVdE6aBmFiASOggfuuEk31H/UT60KWFLVxNXJ7TSbYSoxP3d0cWI6ee9IPzNqfTmFK0vIvswy4H4yh9z/jkqP8DMGwvGZBPUW9/9HsmRyN5wVSWQVUxhUn4IL/UusdvD3AP5zb361Givb8VuJ0ibBKsu0t9CMGVZZ7TC0h1CJyN1Dju5o90r4TGj97pp/NONv7Idyv6KiysN/tK4Nr0IFjduxUokZfW9nJqUQrdlS94uedi7+lw8frBLDtnBiA+DJZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(44832011)(186003)(316002)(16526019)(6666004)(54906003)(336012)(86362001)(83380400001)(5660300002)(8936002)(6916009)(356005)(36756003)(40460700003)(47076005)(1076003)(508600001)(82310400004)(2616005)(81166007)(70206006)(4326008)(8676002)(70586007)(2906002)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 10:42:31.9252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159e874e-2937-41cd-a479-08da0fde7f5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
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
Cc: Tom StDenis <tom.stdenis@amd.com>, "Jinzhou . Su" <Jinzhou.Su@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for "--ppt-read" to fall in line with the way rest of the
command line options are formatted. The old "--ppt_read" is still
supported.

Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Jinzhou.Su <Jinzhou.Su@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/app/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/app/main.c b/src/app/main.c
index 2f9d6aadd7ff46..62ea2f42145f60 100644
--- a/src/app/main.c
+++ b/src/app/main.c
@@ -848,7 +848,9 @@ int main(int argc, char **argv)
 			umr_set_clock_performance(asic, "auto");
 			if (umr_check_clock_performance(asic, clockperformance, sizeof(clockperformance)) != 0)
 				printf("power_dpm_force_performance_level: %s", clockperformance);
-		} else if (!strcmp(argv[i], "--ppt_read") || !strcmp(argv[i], "-pptr")) {
+		} else if (!strcmp(argv[i], "--ppt-read") ||
+			   !strcmp(argv[i], "--ppt_read") ||
+			   !strcmp(argv[i], "-pptr")) {
 			if (!asic)
 				asic = get_asic();
 			if (i + 1 < argc) {

base-commit: decd91d8eae42d63eda4f6b7c97159b9cc343c26
-- 
2.35.1.607.gf01e51a7cf

