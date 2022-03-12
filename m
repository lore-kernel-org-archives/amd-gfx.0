Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DF9C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Mar 2022 00:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C461310E070;
	Sat, 12 Mar 2022 00:52:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C71C10E070
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Mar 2022 00:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+t+MnhEfsUeW7FWOucpcdF0YknwN+IjwV/Xi/XwJrcJ58Vg4zKK+Yg5fmy6BH9Cd1TtEo58Z3NvT2kbD72gbTURT1aXCQrn2gVepVupp2wl7w7BfYzTfx8AjNm/v1Tg6Wl+E3owUfoE/GaQkuEx7OQIa712J99wmIiSCO44p9xYiPYKxfS/XuMM+HNzUrnO2Y5X+iws5z7WKO9k4lvkJ65b9SrqNjPYhMpEfHiSoGhf3saBfy3YeDe2R71KqLJeh01S0AlBniJHGYFVJNg+0C6OC0l7w4rJbyh/uWnRwcmyEHoFyOvb5Mvp0l+gdJ/1HZhJmDffazjk4O12mwx/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4HwgXdVwkZ18VjKssNAnrllBtmpoDD5s2Tuo3EKB0Y=;
 b=oJQLMdkYigUl5fAcCkkhSGt9r7GPMDYmXLUESrjkbExG1fUWt7e0bveyPk6+bcP39xugSaoe5UQ4v3bjdBDO7hVZg64kM0W+uxlDXpcguwCAb6Meenpfql4535dFez5ExFSmNoB/Hy2TGvJ4lz8yT/nVXGz08S+NKjQh+XcNdO4UlrJKGVIappqa49tS8pSOqUNPcbF/lBlgF0/PJ3ZD+hZlCBllEVDCRBOj2ajpbcRTd3nTbEpSZ/Ux1n4kzJ5vs0hJYKoIr8OeLrQYF8Qm4qUqW3ncfmJncLQt6BarDNY+nvHUqmDvRualKBVA9QXaNZRrgxlV3I0E2aHWVfg5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4HwgXdVwkZ18VjKssNAnrllBtmpoDD5s2Tuo3EKB0Y=;
 b=nRQr4luEvgMwOo8AJhaapga9sHTEfI8lauBEjrFhU97xObaF5dsY/+unnRfjVJxeTYuqW1YKvDLkpCnO/AxZV164eKS7HwyKpy4TPKjI9fYlpGRuhrLA1InJjwfh6pqenVqfdrYFlKJUyGNG+PAwbedN8u5bSJ89PtWtMtZbXEo=
Received: from DM5PR1401CA0004.namprd14.prod.outlook.com (2603:10b6:4:4a::14)
 by MN2PR12MB3230.namprd12.prod.outlook.com (2603:10b6:208:108::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Sat, 12 Mar
 2022 00:52:40 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::fd) by DM5PR1401CA0004.outlook.office365.com
 (2603:10b6:4:4a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Sat, 12 Mar 2022 00:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Sat, 12 Mar 2022 00:52:40 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 18:52:37 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 4/4] umr: Fix unhandled enumeration value in switch
Date: Fri, 11 Mar 2022 19:52:06 -0500
Message-ID: <20220312005206.26588-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
In-Reply-To: <20220312005206.26588-1-luben.tuikov@amd.com>
References: <20220312005206.26588-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2249da1c-c1fa-43e0-5256-08da03c29c16
X-MS-TrafficTypeDiagnostic: MN2PR12MB3230:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3230D6230D52B4A526BA63C0990D9@MN2PR12MB3230.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vij0KzNsgH4hNohe16frCIjhrZOhZQL+2XEB0uy7hInNtgKiKDF9F8q6kmO6gSpO7iJzIVtgDoOOwn3/9ZZFHHbjtl7BKECoKRTRqc2DF30JiIIgJ41a6RA3DTuIXmpvTWz01UPJVeydZMCIPOioF4OXTReVahCowZA8zFJJ2sD4NBRib7AZTapv1FJF3caVyqMDMOUsjpTHgijkXiVOnn4PmOovORjcqv6BZ2msu4TvOL775F3MXaqWtaiiIXes0WqH9mUcBNepnc83DXEgQC6m8CZqy0j71qlMgU9MT3Y7ySFx5R039cSm5qBLRo/9HF4lsGa7pV/tqAAhEJ5VkRd4Y6E3llww8QWynnrBmgVWhpr4s/G6WTZ79Hjuh12te19VCg+96aUW+pIu1X7US6ORioLy6fd4MCUxEcO2BJ9x2DOZgWw99iZf+kwe8DNt7fqG/War5apMdBw13K3KBRMVta5BzNLpSh37u8SOoVn83oR8d0d+nwaLDY1tcXWFcbur37GlQQdNNGnaumsb8nNUqII1oAFPrkk9nxWXs173r43IOYBPUW8ItH72pnHjCw384dnm/njUm4cBiCS/8XukIdh9o1z4K+wnOuAOvCrw4ad9T+B+Q9BKsSZB+LhB7NLi+ew3gRazHidb1rrntkbEfa2VCQEjvs5uzp0WR1QgNyRnbbciu8/lauBPaVaLjLDQRzIfxpwgB6NXFGh/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(83380400001)(54906003)(16526019)(186003)(426003)(336012)(356005)(81166007)(1076003)(2616005)(2906002)(36756003)(8936002)(316002)(82310400004)(36860700001)(47076005)(7696005)(70586007)(6666004)(70206006)(44832011)(5660300002)(86362001)(26005)(40460700003)(8676002)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2022 00:52:40.2500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2249da1c-c1fa-43e0-5256-08da03c29c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3230
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a default case in the switch, instead of the last unhandled value,
FAMILY_CONFIGURE. This solves the case when in the future other families
are not handled--they'll all fall into the default case.

Also, in the diagnostic print, print the value of the unhandled
enumeration--this could help debug easily, as opposed to having to
reproduce the issue locally.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Tom StDenis <tom.stdenis@amd.com>
---
 src/lib/ih_decode_vectors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/ih_decode_vectors.c b/src/lib/ih_decode_vectors.c
index ed5705059c542f..f2057df825f5c0 100644
--- a/src/lib/ih_decode_vectors.c
+++ b/src/lib/ih_decode_vectors.c
@@ -77,11 +77,11 @@ int umr_ih_decode_vectors(struct umr_asic *asic, struct umr_ih_decode_ui *ui, ui
 		}
 		return off / 8;
 
-	case FAMILY_CONFIGURE:
 	case FAMILY_SI:
 	case FAMILY_CIK:
 	case FAMILY_NPI:
-		asic->err_msg("[BUG]: unhandled family case in umr_ih_decode_vectors()\n");
+	default:
+		asic->err_msg("[BUG]: unhandled family case:%d in umr_ih_decode_vectors()\n", asic->family);
 		return -1;
 	}
 	return 0;
-- 
2.35.1.291.gdab1b7905d

