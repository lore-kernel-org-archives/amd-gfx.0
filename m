Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9280CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC8D10E552;
	Fri, 22 Apr 2022 16:47:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEE510E552
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fje1LHeznrs8ap7h/iFlL9cPAawOCmpgMwOVvWUHE8QoQRLlr94KhqzfmNlFTXaRBFpvYj1qZtaOXrQyul/KFFUUk1sYt/Zf8PszufF4/E3D0Y3r3vVy5uL0DaUP/pWFlrhBrtC5LgOgR+4PTojHN3AG9TYUAbjTmRB9Bvol/dFezryiyIU06ViqlxD1Hok7aQfeyrY5dS1cNsGepg1hjZpmTw8PzMcLjOt6gc5XH855ICA9izFtqOGhBElx3Ht69PTpdTFw7bo2VtkK/zD/0NLzN9KLfIs1IidhEwV1Gjm6KtGDGfvSOLr0pq4JoPUAGL0OOUBo/fNtIDI7vATocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/yJZSIPZ9gML6UiG046a937hT7Qx6xj9rfm9y06WAc=;
 b=kB/101owp4260eRWB0xXoeKFLG1gXfSNxIL7Nt+AtL/Gjb17Q55mXjegPhiLiRjNPgCMTMNt0j+0hXY16aD6jo9FCxQBdi+ibsXjcxsFEOFwK+t8O3Of5XrHAvptbVRwJUEdN69o2BIsO/cLdQlYgH/42um5/ye8VWnpr/1PUta4TYu6E5iDvrWE+aYJDbuJ5GJ5C3SI5W4bVCA4p/YtmD/nZZMEUwVhbO4btQH9Uhik2oMlOFeLUDh2wCHK2CJySpWuZScphVKEklGIiHRXBEjnbeso0wFuo/lRFTr+iPuqOYaVFt1DPw6lN8ByKbJrV1PYL9fddXKE51w8QnPIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/yJZSIPZ9gML6UiG046a937hT7Qx6xj9rfm9y06WAc=;
 b=bB3VbPyasJ53cpHm76eoQzNos3mbxrEPw4fafL42pJCQdSlPbqKTzvBcGiCj2wPi8i+YKQHiogqdzJLKD1jXxLM31g1dmZuDM/wt8xUo6BwiWzPEuKgyeWrSedKXtXFOE8uZL3LmGqX2ZBvgI1mFRAASuEOt+XZVadg2ntlSRpo=
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by BYAPR12MB3446.namprd12.prod.outlook.com (2603:10b6:a03:d7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 16:47:36 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ba) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 16:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:47:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:47:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 09:47:35 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:47:31 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amd/display: 3.2.183
Date: Sat, 23 Apr 2022 00:44:57 +0800
Message-ID: <20220422164457.1755751-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae35a02d-6f77-40b0-c69d-08da247fce2e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3446:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34462CF59B646B5BE4FD1A17E6F79@BYAPR12MB3446.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Vn9jxSK4HNYpE4ixEFQatvs4E9O9OFIkpGHtfC+t3PIzGPwsOKfYSDAvIVi25tlhxoQJg3NcyP4d4FuGj4y1bEtp37YiZ52JDypm9MuhH722rVKDiIm34h97xXtMu4kEIIxrgi+rCJAJXvTM0TNv6b34ryQBWXnoQ5bTwaDl5M193as9u7giDykvEczRiabAaaKbxia/B3/cEiaen5wBe/rGdTRkEDEGnqHXunHGlCGGY1xYcUF8Icvi0i5cLDpZpvRV2fft+DKDxfiuc4tZ1peVYoQjh40hdEe1FXmaHKQLfU7wPoKeiHl7XoBYcxf8c8+T8ufp0eODlu3tCmLovTrSKwHufv4I2HD/qSEtGMMEew0fGsB8F/0MsiyrW3kC3u1TVrvCwL9XkNumZdo0gtT+QNcSCNyBqZU2ndlV1NNJgAoVYEURPqUIHaaVOBD9MU051QY39B9UFSefnVbeerbildQGAzQEzpg30b4Yc7ul/a63m+r1oQqnSAswpwFjUKI10CBR7ulvgTU/pKuSqJmvlNebZIi8BbmSLP2pvmpmHEApn+8g5mi4yE366PT1he/K4LYi96ahXrNLeBxLLp6rhKJynpEI5jVR6hPbBmGDxTKAEBhpre+ztdeSXvQltT+JNj/uTE85J3LsEP182VyHFA8BXKWlDo0f42CjikfTO8y/+Sb85L1PwsDudZt4cb+nMiXmZ0CFin/SyyErg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(508600001)(6666004)(83380400001)(316002)(70586007)(356005)(8676002)(2616005)(6916009)(4326008)(70206006)(86362001)(36756003)(7696005)(54906003)(40460700003)(8936002)(426003)(47076005)(82310400005)(81166007)(36860700001)(5660300002)(1076003)(336012)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:47:36.2933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae35a02d-6f77-40b0-c69d-08da247fce2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3446
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
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Keep tracking of DSC packed PPS for future use
- Maintain current link settings in link loss interrupt
- Remove DDC write and read size check
- Read PSR-SU cap DPCD for specific panel
- Don't pass HostVM by default on DCN3.1
- Reset cached PSR parameters after hibernate
- Add audio readback registers
- Update dcn315 clk table read

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 47b56d2a6125..a649aec78868 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.182"
+#define DC_VER "3.2.183"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

