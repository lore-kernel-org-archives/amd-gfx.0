Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64532C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE16E10E7FF;
	Fri,  3 Feb 2023 15:25:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F5810E7FC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQygcNanXkkrNtaVJWRQKQtGvfTYEcJl36hi88xCCsxdNeH+/vAj4awrFdd+E327PP1Tp7DxWabK+cBWJshYVr+6vXFqo4JbSxMxTfWqs/fiVRonY3PfBLC6jH2t4qRljrFG+qwlQ/AAZQn8fmYtgVQJDqT7ExEeSPFkPyhYgWuQY8jJvgdquYLiCaWJx1SzgD7JfhPDRDXmiLxDOiV1obEl1jzp1BDn6AhWXkL48i9M4iH9B2CW33rQuyP1mW7YGnERz+gCaHiZKUaUQyjFl9eQhf/zvS+32U328Z7EJHbYx6IsC1HbNwiQ+K87UyalP8RvVZNItGBsuZf8cLSeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ6qzpaMQN4fll9W85ysxI8PYTS1Frr+87ut6EZwZ40=;
 b=Gnd2+9axVlY4glCRtRVPzhRpe/nGpHk2bjNbAx+rhK7NykXboYPNqJRQisnNwYLbPMCX907I8mqeFM+URUJrLGSZL3e8CNcfd94CnKhc1z+rXmipditoYa+oWl7URG3A8eg25I3HgTPGiYSaXAqcQs/atfJythCrQ7w8ajJDSaJG3TTLaPYSG529eGMkQGvJhScnGPl0XfV5hsyibjeYfPckSESPLzz61txgB4WoEfZSpjP4jTrNtmPtAbsFByWRUeityyvxGYKAtUfjKanhnU1ScDE6LmHHvfcHsmjwsbhxJB/1j7QMzG/eN48ShYmWcWU2Ltl4C+VTwB3swVHxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ6qzpaMQN4fll9W85ysxI8PYTS1Frr+87ut6EZwZ40=;
 b=dBlrWH0dl4kCmEtKtfN9whNbOes0frRm0+fLB0COqluzS2m7rMXuTpPhAePgagyiWGfcx3r47nG6NH2ZGE/gOI4tLw/QtforqRUWlpNPz4eSusazUEh2rmIfP27dGN3+XlWGeIE0fsSrNEYhnEm2135mq/erL+/gvxS4XFOWfz0=
Received: from MN2PR15CA0050.namprd15.prod.outlook.com (2603:10b6:208:237::19)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Fri, 3 Feb
 2023 15:25:41 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::1b) by MN2PR15CA0050.outlook.office365.com
 (2603:10b6:208:237::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:36 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: 3.2.222
Date: Fri, 3 Feb 2023 10:24:52 -0500
Message-ID: <20230203152452.1441747-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f00701-ac91-4a9c-0daf-08db05fae822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdM7o7rV7T0XRRUea7F3nuvYxioBQUBYTGMTm9EfdF39hfNJSAX4YJRU5Z3E77FcQ6JvETvpQsF8I9C3ZXqCuj69LuH3L1nWe5dKCGq+TYoiNRW/fpQxf/u5GMm0EtPMCBKHW2+JgiZ08rldFniHefS5UYyCOfBLIG/Ax9SEqcK3RbjTy3Yv5LBRvletY5Kgt0C1rsqvtCWm0+N6WjW5cAAfwhH3OjdH6qBtribazCL7ctg0p69KgZpziB/Cb3n/4oMhcgvIZLjmUJWvMv0e4OewXK1PAcegrLr2t80PAgZvLN91YFuluffYKOyVmvfDy0mcGHfGQZBa9+LbeQ+jnvWKEFpkg/Bkw2+yMsMxJb3r39jLIVwtLvnIhaKFZ2JCPqiUq5IpI9aCcMZOoB1rXE2wgpB9k+aS6fyWKKdPArDPZ2YRVdRMK6SE2yhUtc4USYmonXO2uGgse7ItfcEejQ5v5ZHNt2LxD/VAk0DZw14FKhFqrL2aXzXCBXtyA8Dz4nR8uVry901qQePvl/w/4vOGk2Q84gLhQmWAr2SNEALTnMuhQE5GS1TW+jq8OvEJ3hdg2k/zl6b48Fzvi3Hno62pZ9hlrWEWGaS6djqUV9rFxcnLlhQdOHf8QpDg2bh6SSKyb4Ch/wlvPxyUz+r0fh+ehBZJjueGgoaiPtISHr2JBIRHOWgGju4UsuEgMcUhWwaa2Sb6GEEkpWKUE3J26IA6vkjbJC9j7dN/efIqyEE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(4326008)(70586007)(6916009)(40460700003)(44832011)(8676002)(41300700001)(36860700001)(8936002)(70206006)(47076005)(316002)(2906002)(83380400001)(54906003)(5660300002)(40480700001)(4744005)(336012)(426003)(36756003)(2616005)(82740400003)(478600001)(86362001)(356005)(186003)(82310400005)(26005)(6666004)(16526019)(81166007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:39.6315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f00701-ac91-4a9c-0daf-08db05fae822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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

This version brings along the following:
- FW 0.0.153.0
- Code re-organize for dc_link.c
- Bug fixes on rotation, DRR and more
- DCN314 domain power control moved to dmcub

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cbb94c8ba9de..cec3154009c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.221"
+#define DC_VER "3.2.222"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

