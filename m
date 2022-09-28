Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9597C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DEF10E9AF;
	Wed, 28 Sep 2022 19:41:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4935210E9AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG30NouSYJM95rxDL41bQGU4mvRU87tKm6XL3V5TLJx3JeCAhgVsB9g0v94UXuP2awW8hxNEPYg2SQuhmEq2P0wxtQSBsS3uegQxRLSsP+RkCNUdeUJ16okMA6hn+dexPjGPDpnYIYqH+Ps9lwwkmRlK2GfXSvU8oEVc2fNkRZni2tRBUEVQ+aqqWNE5phLtFifY07ituZPaW58GYsNlw5qKZXyQVzG6vGgc08cZvxnuzFZjUUsjbNYTMGz6qML42+lfIXsKyP2iKZJJnZntWSC1UsTTYR91dyMHwyfh0VStKpDBMjdo+kLQ60KTA4MjT3cCIL3xfOkChJcAfTeknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7ku33vjjX4TWyN5cMjp7tvPgMSZ/EYmDC3wcKGmOLk=;
 b=dXFoxffGKK+WedYCgU06SbIQDSLMRJSUm5Uxofy++sc5FDEPoxg9DUaXUkruKcLbNMfQsEJRNZpUZtjFbTEHz96h2/nZBAWdceM02RHgetUDcaR0aYqcx7GiDYo7u7/mSGMnAi523XWUHt0PV9Loxn4geC91XTUjDdkk8HVd8LGhAjfYr2PLl1SeVjJwn5kQdi9hx3udRvkD4qb1Su8Y/W2SP8XYaylCSqqeJ0BUcsGe9h7ZgiZrZBVUCXgj2soz0jL3kdfprBB6C39hShYxap6duLwoxQ9LwIQ58N951EZP9FRUiZr9ItBFaiyRWQliDQFYs2tr5IlN7Y246EkcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7ku33vjjX4TWyN5cMjp7tvPgMSZ/EYmDC3wcKGmOLk=;
 b=n4VK2XxaXzqvbRaeHkh37KlMqC/Eqb8CZOltDqYWD9QUi9qdO9hfoPbicvi748YRbVMVYyE68+PBCPg0S5Zmq5z2VB5TtPUapok+iOhZEAN3DtpCl2VZH6itzGmnc7mHGR7aI3gU2rA/Pv+Y2A2OWfn0gIyw+jSp6Bs/PpJMrkA=
Received: from BN9PR03CA0510.namprd03.prod.outlook.com (2603:10b6:408:130::35)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:40:54 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::11) by BN9PR03CA0510.outlook.office365.com
 (2603:10b6:408:130::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.27 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:54 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:52 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/36] drm/amd/display: Allow PSR exit when panel is
 disconnected
Date: Wed, 28 Sep 2022 15:39:58 -0400
Message-ID: <20220928194028.144879-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba784ad-3cb5-4802-cea3-08daa1895b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hufpiSBU7EUbTO5LjAg9IeIQIcxlYoJA+xx2a3G6mshhdmePMyQX8OAbMZ18aatmjS3uqp9312rml8ZAqUfRBUweCKqkxrFmw6xcMeYWgjvBU7oiWDHoj+73czquQWRU3TluKC+U5bnALaQ6XovpNzUp6JKkFTIyIcad0Gqe/NEbEveSu3KKkH3gvTvaq6ndJzVLmxLhCUrb3E9rGt9Dz0hLfy8jcwsnlIONdCPrLq+klfmf83x5B7rUteh/0zA6XkQrC93phy7ZzWLfFIIp6Lt7TUsbMO6Gobi65/FKiyFxVnAB5mNizjFoU0IcKPyeXc4JtnObZoF7pmXkUSHQ+tE9qSV1LTP8fG28IejSH8VO1SknNzI8DiZFGRJ0vFO2+7I/OTP3firteK0MM2+2sih5MYQu9FqniNIjqvwjvB8oM7qun2EAhA/Pa/+oeFKZ2JmVL/GJrnrisj7UriQdj0Ch9rmU7q9ebx1OVZmwP7uVk/8i7dR7IJRDCyMs+QTtMovnWcEF19771+3/9AGvB0aEyg5mkQh2LvtxEiqVccDaqy6jQsDgOKScucjcrCmnqABsjd6CZ/Dobb+5mX4K+xv8kMaJv0WEsETn1nlZjbH2OmIRaFM4rTcmAR666WqaERQcRhI/2cmQAdnQ4rCcmaOGNqPWAEy4HLNls3/5f5clHYzbtMGcG/WCZxn4cfmL9d6/jiI9RYHf9hC99NSpZH+y5+P4YBrc+9pRYapPcG583Z1P6P2pzhXkzeSDUtA2ICSllsk+q9QwkTVkgHSX7H2NBhC681waNzDLrvHZ9G76wtVafbubOdL0zArIqYhHCj+qfzWHsOVGTiA+hxLolg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(86362001)(36756003)(36860700001)(356005)(336012)(82310400005)(186003)(16526019)(1076003)(5660300002)(44832011)(26005)(40460700003)(2616005)(40480700001)(478600001)(7696005)(41300700001)(426003)(83380400001)(316002)(47076005)(8676002)(2906002)(54906003)(6916009)(4326008)(70586007)(8936002)(70206006)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:54.5291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba784ad-3cb5-4802-cea3-08daa1895b9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
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
Cc: stylon.wang@amd.com, Jayendran Ramani <Jayendran.Ramani@amd.com>,
 Iswara Nagulendran <Iswara.Nagulendran@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <Iswara.Nagulendran@amd.com>

[HOW&WHY]
Fixed check to only avoid PSR entry when panel
is disconnected. PSR exit can be permitted to restore
the HW to it's non-PSR state.

Reviewed-by: Jayendran Ramani <Jayendran.Ramani@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Iswara Nagulendran <Iswara.Nagulendran@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3529be5888c8..f9479c3ace97 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3143,7 +3143,7 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
-	if (allow_active && link->type == dc_connection_none) {
+	if ((allow_active != NULL) && (*allow_active == true) && (link->type == dc_connection_none)) {
 		// Don't enter PSR if panel is not connected
 		return false;
 	}
-- 
2.37.2

