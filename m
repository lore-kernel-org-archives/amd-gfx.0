Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C18C4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7AE610E413;
	Wed, 30 Nov 2022 06:41:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CFF10E413
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvKGJS/CkLQUoIq63mdKz5iASUH6Wd9zzwxHIfm/GmT78vfXAWqNDacHy5lQ0eL1K3uowCmg3vWNCzRL25JFdcYdXqj3JcePPDYGO4wva8FKLOzJtBH8B4fubjsgxlqg/P3Ovue8+iiOoWKyW+q65tDafjt8SKJON9T0lGA8PoR6kvFYN8jowumakQwJngUM4iN3Hmzxmn38iMpisfQ3N1IljDmBSVNagTbKYm0gLMJP2RstMJeMZqNCh7Ga1mPL+5F3AF4AphDyX8MfrfBnLXoPDh7fQNCexyeS9ev4WSZBUDsXbMn23zNbuOP6FIbd669ao00r4nztroZKHhr47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP3Zv8GsRVKSmt95Dwqy0c9f4JBbdg4oGuNmoEo2Ysc=;
 b=himoE/+vv7dv9N32bonAaxYtg5NpStqCZP0Agdn3cyy2RgUGHQ8u51b9gphcgvkERGokuBGNY8V3+ex9yJfDdco87LsmEdJK3CM4P6DSRZ964+iUeboO8uU2+vqjgb+WIvKi5lNVr/dgHfzl34Cs+e4cQzrHtCalok8drnovoD301utqgvomkItD39URzlwud5QxP7O5iDR86l28QLfzJ5HwZR+vr177NXEaG0IJjSjqm7cS3JV7K40fkAU4aSfrlu8EOxpurpCTnPQqRePPEx6J8R3JEc3CQZbFfIJIDsI06cFF33X8+TVEp8vKsMFtV8Yr6vfPGD/cHLFIcVl/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP3Zv8GsRVKSmt95Dwqy0c9f4JBbdg4oGuNmoEo2Ysc=;
 b=b/hnciFEiQ3bNNc2S3hdQ+zlgOroPlCMhOqsWbBfpQY2p7vO8bmNMaz0wnaQM1VXEYJhGcymBHnGBZs2sfu1cR9XQ1M1YTBleyCsFXQhREEneEDDltb29cqdflYOpE3T9tXUBu/pXRe75BLiJH20OX6K7yTVa9wLEj4I+KqCGO4=
Received: from BN9PR03CA0148.namprd03.prod.outlook.com (2603:10b6:408:fe::33)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:40:54 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::27) by BN9PR03CA0148.outlook.office365.com
 (2603:10b6:408:fe::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.23 via Frontend Transport; Wed, 30 Nov 2022 06:40:53 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:40:50 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: 3.2.215
Date: Wed, 30 Nov 2022 14:36:27 +0800
Message-ID: <20221130063627.2398341-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 64305d5d-e28f-423c-2a45-08dad29dd437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQrgqxr5kK1lMgKwHzVTbM9cUQaPR8wmTL3NIhdWmD3fhEPj0zjr6awcqwHVCGNE810ApHsNymDHxCtqI82beqRr4zPq7DWgSlTmV3ZqhT+94TH5JevpWNs0frQtc2z8rX2x8LAq4HjJ/g179f9oMvMoJcYZaF8LpIq+ld1pJLTDkRvpidXJVcbKgutc3qEjIry5rY4cLlFPpwaZ3vxZ1P99MaVn5bV1PHoFPUuLaH/FabJKxcy0KrglgBzsC2Q82fj/lsDsbnz8WBQPqsM5cRrGds4wXmSiRrEIuNc/5jEi8KqFpQdeyihboYZu9/tR8VgPEzVPAamaJDv2zxUYawEmzzadwf8QVXoZe8lTZwVdHk+aULDqeS2aQb3UWta38U1p1DdMeKFMUUUvlmHNHLkDAfXGY0BltMKFOD+H9qOO6YUbmSbwNxLwyP6rKoxyk/V3VdCqd+e230px8EwndT/UosLK0ltahUl2yWZbaowysdFTTN1Q/Pyyy2VSBt1N0Ba1pnddL1TUPL6gljFww1AIm+89LSerG2aCykB+luwZlTZnADbiocQNeofHGmqsZI7iV/YREuXtLYeVJByD6dVKpWQTuWdeMUYm0UhNLKDzDJeHdaNK36RGmeSbRXekn6ErNpHl2nXqe5bZFU/FNcjcE7X4OLeCvccSPePI9pMObWTleOb2Cmm0HR5MSDn1bmFJgVWDGk6L4Dit77k4O651Lux7qv+E7YYu1or2C54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(36860700001)(6666004)(36756003)(5660300002)(2906002)(82740400003)(70586007)(70206006)(8936002)(86362001)(8676002)(40460700003)(4326008)(356005)(81166007)(6916009)(54906003)(40480700001)(316002)(83380400001)(2616005)(4744005)(44832011)(41300700001)(426003)(186003)(16526019)(47076005)(336012)(1076003)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:40:53.7961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64305d5d-e28f-423c-2a45-08dad29dd437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3cb8cf065204..85ebeaa2de18 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.214"
+#define DC_VER "3.2.215"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

