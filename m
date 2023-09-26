Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD85EE7F13D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0092C10E449;
	Tue, 26 Sep 2023 21:54:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA4D10E43E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edGKjEqJDwSXLvxaKaqqJqV1zU48sG1Kl8v820Df8RLV2eNxq13CQBICbHYND2cThi4xqyg81/KzFMl9CQ16ahRPRHAci1CiEk4oGUg83gTQnJiOqlyLPpZ2L2TBXaGZ2Ho3ztXPYiNPCWMC65SPeGl1hrvWc9SnFxEz0InkPXmc4F6RDsNFa8KQuknB84wTctMbvcXF1n2Y4e51Qc3PleWCKDYNedyUvCGXzY+BVV57PzFSViDZbYUx1HNGxqV/gAkh91bZT8P5yw12wUA8tCv8hSb+nE6Y5695aQRuFpqEwru3Dj/8H3N39fmK2iCMl4iaxmBh2BqbGe6fVC6i/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfRj/YN+q2gQf1hzAigANh5y+SVzkJHkKO0fqbaukbQ=;
 b=dD/Jj8IsxFRORbyWKQeez1dA9025SODNEHnhxEeMpF9L3x5q7BpyhKGBAz5Q06hOaXxyPGS/SomcomtyY83CmqVUW5+wtOhlQeeJxz85NAZ6o4wUQHYrICtPGD1RkrIAbyf1WqYI71P1g45h5ZN1lRpBXXEoFF7EcOv2IgqFjsE1G5ZUGBckqQCKMA4kWBg6XD1NaynRHFSIQzCxQlBfLcJzHK/e7lVjtDfm4S0cIXQA9ItRORl8hY7vVnEsADoCJhokVyLqH8USaQUJxT2JDVr95s1hjh9bXwjdTgfNi++nnM9NzPHLJsmDtbaRDqiTIXawRsK+87sZ6pzXSY1+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfRj/YN+q2gQf1hzAigANh5y+SVzkJHkKO0fqbaukbQ=;
 b=bdyOAvt8xs/bpc3hX18EfyRAEs9hS7pKxBYBqZd5wb5OMzOn3LRgAaP6BDpwoFhhu518Q3rg9ksl2xKevvfSzuCcRVoZbSGPIxgjZr5NUv5wZfZ/f9I58IAx2cr3htVDC+e4Nrzv/FfgNelPjd45AGnYIb/0puwHr7nLMdUjfIc=
Received: from DM6PR07CA0069.namprd07.prod.outlook.com (2603:10b6:5:74::46) by
 DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Tue, 26 Sep 2023 21:53:51 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::ee) by DM6PR07CA0069.outlook.office365.com
 (2603:10b6:5:74::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:50 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:49 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: Clean up code warnings
Date: Tue, 26 Sep 2023 17:46:59 -0400
Message-ID: <20230926215335.200765-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ccc057-2124-4fea-db7a-08dbbedb1234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsNvBHYzSI78jFhLvGciHhitMvjc1twWFGJuTCAMnppj66v+hYmP6vVVkk49sTzmxuoyP+mPHQ3YZGigQGyRrHnwkfTE9qewnWA+n8CW7xvVqkBcWws0wIv6CbzbnfHTinP6V/hDXx10N+T42s8J6aZhWq1/XzxZI5zEtpRB5FacD6ttTOa8n6/4ACfsEtuQLGtejzBv+IwOO23I1feDjcD9DsaIsppg86qmF5YICN9TnOCKziTvLUm5a5WYJgBZ9OMeMMLygvDrXzym5kxLbAfsnu2pStAUbuStaBWE3fIA18Ki46lJQyYNB5ggEpMl8tXKIG02r6Cu0LhUemrVa5sk6ysxtj6+eBiYGfmwer76WbUu5+9fBK4G5TymKDZ5a2fcYIY+wGwgd6JDjvyIWA9ocIDd7KMxFvMlwtwFFaUoyCWnlCOXmNhR4lUNEtdEGgOvU7w5swQa5F22dD5tABSRgg3rYM2ZN0tfMoKcpasGkzz37ePZjiOEnzPGZ2yyQvFDcx4b6OMG6Wxb2yxeEyq639N0L2Ly8KKCRyecufhvx9iM0WBvXBKyvhTa0kcVZ93sKRs0KVPBW2K5cc7eV0L9o1pxJOeRIf96Fzkp7yAWchCbrXOlEcQoPPRa9Vs2F4OpvoOptDJWiJX9+LtPAX9eZjrKOs7UxfYcnJI40XmBG9uOxgnvdm4InOvDCQl1RGez96CxvoEuVac69A/hT8iahLhiRz86tWjcy8c9U6QlIlhd5raSXQcr9uNfq3S0dksBKwiXBDmHVMTY7v68PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(44832011)(6916009)(1076003)(41300700001)(316002)(70206006)(8936002)(8676002)(70586007)(54906003)(86362001)(478600001)(4326008)(6666004)(7696005)(26005)(356005)(81166007)(82740400003)(40460700003)(2616005)(426003)(83380400001)(40480700001)(336012)(36860700001)(36756003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:51.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ccc057-2124-4fea-db7a-08dbbedb1234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

- Fix constness of string parameters
- Fix zero-initialization of structs which cannot take a 0 literal as the
  first field, for example enums

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
index 4220fd8fdd60..5960dd760e91 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
@@ -53,7 +53,7 @@ void mod_stats_dump(struct mod_stats *mod_stats);
 void mod_stats_reset_data(struct mod_stats *mod_stats);
 
 void mod_stats_update_event(struct mod_stats *mod_stats,
-		char *event_string,
+		const char *event_string,
 		unsigned int length);
 
 void mod_stats_update_flip(struct mod_stats *mod_stats,
-- 
2.42.0

