Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6032BC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B608C10E4C2;
	Thu, 20 Oct 2022 15:50:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF1910E4EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmZij8wM0iCfCDruJIqW1Tcin1eRy/BIULySd34g5gABYQDsgf7a30YIfaOkgZnoN7JSaCwxsquo36aMKoitrYhVtjSmsPtPAmubPLte4ilFxTocKkIqLWKcAhId3BDEmlfnKbSzhLNcjYotxx+ramb40c8YX68yBmdOiwJSOYngZyVI1enakPYDDZ33tMRs7AkeAZY0EpQy5L0ESEV5ZtuojduCukvGuy5ZFzu8en1n4gNv2fhRYgYGztkU2JQJ5CISKtSJt0Y34N2QWVOmpkGFt7FQn0e7fSCmjYJrh4Iyz6vKjkbPOnfZ5pAnyhqUYPYl3124o6Q1o5eqq9rfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf5r4b/oOwfAKHoJdYzcdYZ31iZLJAcJjOC0iz4RpXI=;
 b=ZCKzhUi4f88gBA6CnQQTL3MeXHaazBfqp/rYNDLZj+dd3kZXVDgDT8KErOfkqeRedGjyY8536mVwdhRtXkqa8dxpbwM8eK7y9fQESLYv2X8TMRK8WDR4ZpFBVP9acMA2rECGEpQiUjouWAXhytp3+WGjCqBYpJio8tA0EdHxc3TJVlky2ixZU6UuxI3IsWKLYY+DCrORmes6TWCwHEekiv09Z5VsY7vJ+uzDHV7hf1vbMQF1grUcuooOCbBB1iMg9sFqBRE241ZprV/tKRLrwccnTeUthI3bKd5lyZ0lxNeFkMCHcSVLhscbZ4LtZx1yoPxJJPAqnZ4Lq/i010k03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf5r4b/oOwfAKHoJdYzcdYZ31iZLJAcJjOC0iz4RpXI=;
 b=2TsfYRg1HzCRzsJs13KTbwuFSUvkgPeEIn5JzifidmJH7QM8PpJYumLQwSS+pAq0Vfr/k/kfXfLxVuRnxewSHDQqgSMiSUSa+0bcB7eLAIlRRy4rUWE4J2pVTcU1Y6jedXtN6G/DyOsv28NS6sCsvBkuDoEj4bcqJrWb3lQVDlc=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 15:48:21 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::6f) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:21 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/33] drm/amd/display: 3.2.209
Date: Thu, 20 Oct 2022 11:47:02 -0400
Message-ID: <20221020154702.503934-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 572c4258-7eb7-41e3-2c15-08dab2b28438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oOq+ndQAQVVwUWAzQ42BSi9tuePLWAZAf+G0CSBJCVDJsV/yRgh3Km2+mxcxd3EQn40kOgZGPXqTGCyshvAw6G199d0e3EGXiWYYKPNKsK5wwjM+LbMKm8yxeh2eht4SjK5OspcuYTcKsgkV7uTRBQyO3Z9csYoCg/3kDmJyR1prmqE+iJl6Iwx3UhX+d9fLB0cuglYXUzdTNDbVi6Z4dE2re9lSzk+RoTgxTg34pQ5CUUI4V4ZQDvKrjX+Fo1C97iXr4ppxb2GNsrL2ytbmTSs7t1kdwNPfwoaY0fZ363wkdIsTJVKn+1L6Xg/tliaOrkPyKHM+Khp55tg956TsP3DoVFpuGcAlVHOqPoSk3fY4WZ6B4EhyZMJFe7bWrXbGQ/h+plWhd4Vq+6b+Pb12Tkto26sOo6wi+uNOyET6GMj0lTiNByg16BNZMD54WFuxU/UXmIJYTNF0OIX8zqQks9pRH4aockjMt41auMuzuETzsP7XJ1E7BJrjFU2yEB4hOyIyp2qCCIm4J/LZg/HKQZ8ZxIxVd3SWQ3MeSgOkpsHVNN4PHxC1eNsGpDq+oyXSWb1SVeIGbrWuUcFnOMf56feksVWHg/zFVz5OPffI5ATJZQ0a8wkMMc5Jp2pTgGl/oRr7ijn/cjZZAU3qrUH5zDbyLJCiYTO5wq1NuYkdjEVc7XzGdFYjNfFu+hpUp1bLSV8TZjvBDNktsoqJgI4kIxAjS8grEQWwNPq4sqEFp4TbRKIBrmwPDEeJZwu3RdEoQtWB5eSDzR5pMT+utsVm5WsC8xzsAjQlh6zLOYEH/RO5YHnX1RHYoCQch4fJREZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(356005)(82740400003)(81166007)(2906002)(40480700001)(16526019)(1076003)(336012)(47076005)(40460700003)(5660300002)(4744005)(26005)(36860700001)(86362001)(2616005)(83380400001)(7696005)(186003)(6666004)(426003)(316002)(8936002)(54906003)(6916009)(82310400005)(4326008)(70206006)(478600001)(41300700001)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:21.7918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 572c4258-7eb7-41e3-2c15-08dab2b28438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <Aric.Cyr@amd.com>

DC version 3.2.209 brings along the following:

* Improve color manipulation
* Add corrections to DML and some flag configuration
* Updates for DCN32x
* Expand kernel-doc

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 80ce42b167b6..0757ca449290 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.208"
+#define DC_VER "3.2.209"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.35.1

