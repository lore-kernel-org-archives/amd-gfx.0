Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F96DC4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DF560F25
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37DF560F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972B96E193;
	Wed,  4 Aug 2021 15:55:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB3A6E193
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 15:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwnzudqR4GBvqALHok2CB01/WeKcK/5XDLAIsZasJK1VH+Xv1Vkyei+q5+PMvFiMEU1KHBtpQF1zbo4Z0pJaUoWgE6+unQojx/qgtSS3U1E45cAUj4dQcyWjLZeDFlSwBdYYzYPKDn8hVCS58+7YzKtnMUa/ngZBy+1p3PqIlBHUFyVCiLJngyGzJRUxOXe9UcOJLvU+XVR/kKbpiUnwFj+gK4/qTk56CSDJ/w8kL5d59R6ds7QYLuloH982W9kf7fI5/5csiKd1MZK2FVKnuw2dDbE6f1K7HhUA7VU584c/BLUDWOV0GAzWbG5Y27T7X3SM7OfzTbvK5OBGjidm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2QyWtsRiGVwFqERR4YzdL6he+lW4RqDvpV47sln3Fw=;
 b=fUqOT+redAVM14LltUi/dTP63mu3YD8ZJBLl1mDtI4QB5ZT8GmqhGOV12xX9OCn1gz3cLFuUUCKshLa6rlaZx3X+kWb4sUeo4grZ/1vyplEF2Etii6iMgdI6HFyW4zh5+i/adPqehzVdMywhFUtcCHTuTWX18glZVBaSfwvy17ref60OtfDirXCAFyCBDVM8jCnBUjxX8WiM7no/Kul1Y2JI/cEHVJ7WnkSVMKNCl/OlnkW2PTmzo/B5UO6uwjqALIjvoqTB7uA/lYob9JJ04MvyY7zydE8DKDNl9RltR1SYqV1CgNvzN41ThckQ5Y9wDHOz9OCIPnINNm0HcN1Ocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2QyWtsRiGVwFqERR4YzdL6he+lW4RqDvpV47sln3Fw=;
 b=AnugSM9hRUEHLfmrFhwFDvj9V86bVSgEQDmZaBmNgeYAKsEl7oTQQKrLAe+3Opdt2PvDl9bs80BQXSaEoCrgCpPNuDWKjnRnvAq1jePP9mIw5lxDouOkACZi4Lgv4xXzViFQADebf1Dy+kOTTwrzsSlAGv0YGdHhFeKeoRzs0ME=
Received: from MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9)
 by BN6PR12MB1937.namprd12.prod.outlook.com (2603:10b6:404:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Wed, 4 Aug
 2021 15:55:40 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::62) by MW4PR04CA0364.outlook.office365.com
 (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Wed, 4 Aug 2021 15:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Wed, 4 Aug 2021 15:55:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 4 Aug
 2021 10:55:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 4 Aug
 2021 10:55:38 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 4 Aug 2021 10:55:38 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Anson Jacob <Anson.Jacob@amd.com>
Subject: [PATCH] drm/vc4: hdmi: Fix build break caused by merge issue
Date: Wed, 4 Aug 2021 11:55:35 -0400
Message-ID: <20210804155535.967289-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e2b971-4b50-4a9b-f4ac-08d957604ecf
X-MS-TrafficTypeDiagnostic: BN6PR12MB1937:
X-Microsoft-Antispam-PRVS: <BN6PR12MB19371183C0F33BF45F8D2030EBF19@BN6PR12MB1937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfOrWYi8Z9yYHLyF7HvyXx0MSybaWhEeDNUjU+xSQJKJ8tWjM3aUkk4NJSsctuoTZv4m94gfZ+dP1OHRCCfsRKvO+qbOBiFRkIoQIW9tt94QPPHTYdtEORLnknWRJjNoZx+F93X9Ke39PpB8XvWOUkEF607lsX7ZoQy7DxjoNo2+BJnFlY0x8BbmYoesCCOxuql2hkwS5qVO7YlebFQqo+bWpMEwtzZcwEDeuglnJ3FBRRdw8OqMhFAOEDgXtZ6lzDIUsNzSoM9r//c68UacDw4INZ1+nWAGqpFO5Agdmye+CP/MrAwZTfDV+3DO8qikaLKL6RvDFoTIdRUXIpWHZdzEWdH8219aKC0K1CGYxVf/L8iwxZdJIldm3CMRn7n7KheUqlIF3AKB3EOm1YL5CK5Qiu+9oL7fj+aqhnvwtUnrNntt4Zf25yvb4i8MSvz1xmhsSmLPpWURsgHqPCRaB8kXnq1GNCW/Y2FbVRIrIwjibluoMZ1TIBNbx2QqClOdmoZVb3vRprPYzrzuz4OaViRlRLmk1lKYz4z5zaQt8AaunH2m9qWdYDnfYJ0XBKiv/t0zJe7dvYoFm6+MQ1R/56StFtL+Ctu4jkO5tAHE1ILfofowTZpMDF04Y+FfdEz/zGOhHZAWEIAt7cPfl2OEQEQXWJwrbGezN+etLz37rmxbIJdpBQNRGU5sdr+e7EZnxcgY7tTezEbKanR9nAmU3MRTLF3pYTO5sptgM3htcP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(2616005)(5660300002)(8676002)(6916009)(186003)(36860700001)(36756003)(82310400003)(26005)(426003)(316002)(4326008)(86362001)(70206006)(1076003)(70586007)(2906002)(6666004)(336012)(83380400001)(47076005)(356005)(508600001)(966005)(81166007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:55:39.8805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e2b971-4b50-4a9b-f4ac-08d957604ecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1937
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

Commit 6800234ceee0 ("drm/vc4: hdmi: Convert to gpiod")
was reverted partially by
Commit 0600a948942d ("Merge tag 'v5.13' into amd-staging-drm-next")
which caused build break when compiling 'make allmodconfig'

Original Patch: https://patchwork.freedesktop.org/patch/msgid/20210524131852.263883-2-maxime@cerno.tech
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index df65e0b6449b..aab1b36ceb3c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -168,10 +168,9 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
 	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
 
-	if (vc4_hdmi->hpd_gpio) {
-		if (gpio_get_value_cansleep(vc4_hdmi->hpd_gpio) ^
-		    vc4_hdmi->hpd_active_low)
-			connected = true;
+	if (vc4_hdmi->hpd_gpio &&
+	    gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio)) {
+		connected = true;
 	} else if (drm_probe_ddc(vc4_hdmi->ddc)) {
 		connected = true;
 	} else if (HDMI_READ(HDMI_HOTPLUG) & VC4_HDMI_HOTPLUG_CONNECTED) {
-- 
2.25.1

