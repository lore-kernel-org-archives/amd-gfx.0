Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E1C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3718260F92
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3718260F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFD16E9BA;
	Fri, 27 Aug 2021 20:29:27 +0000 (UTC)
X-Greylist: delayed 6331 seconds by postgrey-1.36 at gabe;
 Fri, 27 Aug 2021 20:29:27 UTC
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (unknown
 [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318F26E9BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRg1ItXKhQuIxfjOOKOGvDH1JyhhiEON4s5RDj7z3KfJ+03PegLK6mhLcC0qa8rfPtmXOTRmXYRyizKCwdIp/NIyCwmFh4XWCEBROpb2DDoNplGXBvxi5eXXbFgT73Q2ZXRHOtoO5P1srMBX1ufr9lisjh8XKTPZNfQbtP7S8G6AZTyzojh5N4zd7z7ONiFis0j298n7Psj0dFNrCXIREUXE0uhTmdzSj2RNxdZsynyhTYbDvb15JVC7eL7jMdjc+7o24oYAf6D96BitiOhZZmisbQV4+ahryYlLg/RwgnP8x4AcFK/n2dfBoio+ep1Sgtglf/vDnrU6h9l8bJUhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pRVOh45do1j+nZSqbKnExLJNF+cCtyZRE8EyG3LS00=;
 b=LzJqfIhYbQwsZ615sbIKu4kDYa0Uv+ZkpQw4Em/F2RiCyXKIYnuWBQfCLnSGa7HpBw7Rj51EnFRbdngsdrl1+32zNEqqL0M9wbYcYTAnVOS58S9ou0LLuOf2dfPcXRb0rgr7R5ZgadTH2JXUenc/34UlHYTrLSV0m+bzTZWypZ7fzKUIxU5EK8KPGupSSZCh2Gs31JE5j0Q4sIQJvQcKDGWqh5HqRG0qLz4kZnIYNQ1xCxL17R4zMawejf3ymw+xQlPiEeUPU03OCmddZPyvtzMHNvBJCguKpT0CDvaJhCdDJYHBotWixGrQdps2wz/OOD1N9Y7gqL8nAaJ6ftsKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pRVOh45do1j+nZSqbKnExLJNF+cCtyZRE8EyG3LS00=;
 b=DLg4Xo74yAaamOjClTeYbAsIaBDqFatjTu578fJxwkv74rjpAcrNW4F0wh76f8uHsNwUS922rkCTlS5ldVTlNE2WYAxKhusPftBJVte1IV1qCYVvaF0YzJDmLGy1eHUyD8aGULMTwehmw9YKLmjEXBKGRCxCaMtehaJAjh4EQso=
Received: from MWHPR11CA0003.namprd11.prod.outlook.com (2603:10b6:301:1::13)
 by SN1PR12MB2526.namprd12.prod.outlook.com (2603:10b6:802:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 20:29:25 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::ab) by MWHPR11CA0003.outlook.office365.com
 (2603:10b6:301:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:24 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:22 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Angus Wang <angus.wang@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 01/19] drm/amd/display: cleanup idents after a revert
Date: Fri, 27 Aug 2021 16:28:52 -0400
Message-ID: <20210827202910.20864-2-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d3c3472-0d10-4869-71e3-08d969995c38
X-MS-TrafficTypeDiagnostic: SN1PR12MB2526:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25260C4F9214EB914FC8D192E4C89@SN1PR12MB2526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0DV4x3YljCA1v7WEu+4NkPpP9XIESDGulH/Y8AsC6tz4j4LYyWw7pnbDPP/JCOl8ba9x4ZfeEwkpB9HJbl55dfc/2gRXA/AKAiNdv9jhI3h5Zq+O8LYqXFglzg3Pz7ljRGT3HvnBy/CSiobJ+Pq4DS2NY0ttM/q5cMV8oj2jylnCFIlVNLo8nkiABwECLQg/GmqPKgBI3XJjocr/k9oFDwp5752LrWRMQUyiIMbqMs4siwYQuUDIgvuQmJzvsqfi+dTKsiakvzh1yyoubnWhbmdhs41GXsizCZHGJJ6cM7wUoIge6F+Cypzq8+vCt3lDXH/iRCICYZhaifsvFXlpjayLa5cd0GSyxMWzBMG5GWh/sKolhibzdooMpYLqS/czLRYEDqXlFXijBJodnSw9IYcf/3+aZWz0Zhxrw9d/yhs+hGQfxhTjEoOulT/Zq/JjLtiA59J4DDOvJHlFAvsIKWXnmR9uhqkrRQddDEE2OAgdlrhn4rbzg81tzkWh8ndlCleOQQyO6pwq8kPjMrG2jVYVC9QI7K9MCQIV5RaAbJJAG9R5uuO+lRvqhaVzyIc/brL0H52P9hLMW2erX3UPjMXNbUtAoESvZlo6Om7+9NXkv3MWOlmVW6Hlz2sp11U0069mas9t3ZY/TKSn+31P+ocWJkiGo15CgrfrOAE/Ljpq66IkF82Tfek437gOSceWVhtjhrejBCZX/h/lYUv8kItnogXxLE9u4fpjcS0C7g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(426003)(70586007)(36756003)(47076005)(26005)(16526019)(44832011)(6666004)(2616005)(336012)(186003)(70206006)(316002)(8936002)(8676002)(82310400003)(36860700001)(83380400001)(2906002)(356005)(4326008)(508600001)(5660300002)(54906003)(81166007)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:24.6182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3c3472-0d10-4869-71e3-08d969995c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2526
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Angus Wang <angus.wang@amd.com>

[WHY]
The change has caused high idle memory clock speed and power
consumption at some resolutions and frame rates for Navi10

[HOW]
Reverted change "drm/amd/display: Fixed Intermittent blue
screen on OLED panel"

Reviewed-by: Aric Cyr  <aric.cyr@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Angus Wang <angus.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index fbed5304692d..63bbdf8b8678 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2641,7 +2641,7 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
 			if (mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
 				if (mode_lib->vba.DRAMClockChangeWatermark >
-				dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
+					dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
 					mode_lib->vba.MinTTUVBlank[k] += 25;
 			}
 		}
-- 
2.25.1

