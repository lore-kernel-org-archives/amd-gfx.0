Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E824C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B03E10E6D0;
	Wed, 13 Dec 2023 06:13:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54C410E245
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH1CeMkKmNYPCbzX6/pPDPm7vDzK6TOkaOAxdkvMrqJm7slC+nw/lZCAxhVEfaghtHWe7WT7bZVKJZlH+KHdSXohZy3K3K9kRG6oJYVEboOfC6fvkIjS/8gsHQ1uW73UtO0qFddlGd8cCy9Ki6IaoVqv2pTG7hlFcC+6m7fjDNePItuP+Ju7YmTq9+r5yiIfFhd8jb8ZpJQBXM4rYiU1xBZY6HJDMWdBnS9PsmmCDzsRzLJUOk8n6qhmfErhQomYxWYgoakq+/l2zrM3g6fx8ByWk+HAJotrZth585Ip9iXHdkxrnFRnfutzB6EXTrFf9Kyy4KPiPTJYwuLXWbF6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xAS7pGUygoGwwQ3qPZXPTdUkLFbQpvdyJGaPw3T09E=;
 b=gqurWU1SG/FVVismz2sFdC2iIALd27XulaSHmGOgLSbWPvoKZrfa5BE30syPAhHO3W5uFbk7w0LNk0nPrlMN9aBImDuQBlbhY47lT9mR/IMDOBcto4p0Dmfnc91dJ4ItR5/EQFvhG8IOFLJ0Ia50hkf3lsy9qLyezLpa6Y89IVzts7ft2FnjGX+2W5Bu1l8XszqdZ1Ytusa6webUdLB2L9amBfPqNmgVBGrU3Xtxq6i/shZVvvlPn36CbcEGzKTmvXqwQhC5Y/wCntgPW/pO52zS5k0BZ2zIkUBW9QkasOF3vWKg4HLOONdH0eI9MBlOIzKzOLEb5WjBwM7li2NEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xAS7pGUygoGwwQ3qPZXPTdUkLFbQpvdyJGaPw3T09E=;
 b=5Z/thzYMjpywmaKPWyuFGGDu+Srapdpui9wNMrgeot0Sp/5neKqSpLhTJaR3j08KR0yal2lxpQevelhNarl3mQH6yFiwwWy8bC1n6viAAk3SAcHeNKgcDnyAHNEzoNQzU8fYo/h9nemQGoVNqza68ife44+bH0MzEEeZAnq7kF8=
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:13:04 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:81:cafe::27) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Wed, 13 Dec 2023 06:13:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:03 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:12:58 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/25] drm/amd/display: remove HPO PG in driver side
Date: Wed, 13 Dec 2023 14:12:04 +0800
Message-ID: <20231213061227.1750663-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: ce698cfc-ea7e-484c-a6c0-08dbfba29134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byxsPdVVIxVFyT7V9heX1VL3uVqVjaIr67VblZcWwJzVHqyWYQ6mwyT67nIbNDMuCtuJb8Xx+Da3o9xUHz9dcGdkEdDoSDtFisW3gpCrcLCs+lyc+KYbJF/Sg3RzG7heIf8MF5kuLucS6DuyEO+feYhkLsuRzDb+XAADypqmNd/lCrEBf9BbcFt6XrEvUB5DOGbik99FsHJf5SKWTIeM9PRLseM1SamznRMhn1kQr5+txMeC07EJ5ng9au/ELVM7Qida6ixTUsp8aS6XeI9YJttuyHXUDPBZcBjjV/C9C80FWYqRmzQgzXodf4yuogqh/jN2BcAa/gGyilz+P2w5uA0zABAJRTcJl3ZyMI86V6EPRxeOHdKugM6rdy0Pqy5c6diev40O0t5+4KPf2wdIvGl8kl3rqrbV+bgU6BbgkYl9UKkfiAiBQFhs8SVlnupncTQLSgaV41gi4OOsXxdKszCMYzpu5390XeAQ6n2NtRcN8qCDYvn8rbb7om7rBgD/mcR64J/sfHxas4KfMQ1jDFKuCm9Miqv99TV6Dt89Us5lN80WIw4GKoLjHNcIP6CDcTOazF4xAY3NgBZF/jKQPz82QSFVKd02uWdnNifOd3r0QKp9yfkBVXnLfIDzbeVwZx2/5eP/SQ2rVUSiL9Z0niL+9YVNrDyy+od8GvdKvM+SVC25DuVcxH//rIVVwk8Xb1oP4xMajBkXBsqUzUhJtyNhqwLGNBL/J0NA72E7m9w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(40480700001)(36860700001)(5660300002)(7696005)(40460700003)(4326008)(41300700001)(47076005)(8936002)(81166007)(82740400003)(36756003)(356005)(2906002)(86362001)(426003)(83380400001)(336012)(8676002)(70586007)(70206006)(1076003)(6916009)(26005)(2616005)(478600001)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:04.1071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce698cfc-ea7e-484c-a6c0-08dbfba29134
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[why & how]
Add config to make HPO PG handled in dmubfw ips entry/exit

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 4eb744f1bc9f..4e1db842b98c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -718,6 +718,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
 	.disable_optc_power_gate = true, /*should the same as above two*/
+	.disable_hpo_power_gate = true, /*dmubfw force domain25 on*/
 	.disable_clock_gate = false,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
-- 
2.37.3

