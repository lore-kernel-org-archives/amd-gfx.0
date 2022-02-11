Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523F0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAC810EB4A;
	Fri, 11 Feb 2022 21:52:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92AF10EB4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc3DHxgKSUzd4q3HU3u4jdld1Bg0uOby5+92T1dFT3c30hpPrrKEk4j/ywkA4ldLhYLgifBt3jJMXJvcpP1vyURz7uEgkL/Sf7kxLmALdhMjEIldTmRWwwefYOEqlSDzYgvuRGe00OmZdJ++FyVShfqZZOR/0ntF2kzN7PX6B16qeSywX3X/6wsipuuw3ERn9KwF33Ue+wlgSA4AImwigMEWu5cfDHyTkyzNWwerP5I4p3NMxX6i54ugjxoEjeLlTxUwW03GXnEFwIJyYk1BU9BWa2V3rD+me7K+63DKpjfyAa0rkgXCswA+NdTAAo/5M4QEqcuARWte2ULe+MZpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj04KJicHlQaVMoOCkCN8gCmyQ+oGA119+OcyelYWiw=;
 b=nZIcLQp+ubDxkFPeSVm9PM5/D6Xo+sPQr6mUMpTz6VU7dA16JSTHVkmdx/mB7Izh4GmrjFeOzZHjxBvSDuESQ57OZUyoAyKWiPucVbWsj57rYfYB5DQ05fuxdSY5wlNJmhR4Hjkl2VZJXwNGfs5TUSgAVcYezEOnM1yjyMlXZpBX7OfaDOjeQyL22QJ1tMXgKOo/1Tbna8UH578de1AKwvZzD98VYiZZP2VoU8QisAo3obdewlQlRsdvYbnpxUfqJc8M/78bLpeALr2NpUpm+JGIT49aXeJpSrlynroS25s7D1FjkDJ0Gr/celHdMnli4bjq/aAERSspKlz4WIF0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj04KJicHlQaVMoOCkCN8gCmyQ+oGA119+OcyelYWiw=;
 b=Vwf+iGWHJC0oBvy7K4hz+Sl49DcrqNDu6XY8A44ZTakcNo7rBv02ON6/CNzOacjsgy+3tKoTbmpyxNtNlzJQlXNOnKDpwoRbkNlahEswcMOX4IYuwnXicFsD28AQC+Yjq60l+RJ9j0vv3s4ktRyaXU9XqWoFqmSrqDVjhHY96pA=
Received: from MWHPR14CA0004.namprd14.prod.outlook.com (2603:10b6:300:ae::14)
 by BYAPR12MB4598.namprd12.prod.outlook.com (2603:10b6:a03:10d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 21:52:13 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::97) by MWHPR14CA0004.outlook.office365.com
 (2603:10b6:300:ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:12 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:52:10 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/11] drm/amd/display: 3.2.173
Date: Fri, 11 Feb 2022 16:51:39 -0500
Message-ID: <20220211215142.94169-9-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aac749f-12ec-4c9e-622a-08d9eda8c2e6
X-MS-TrafficTypeDiagnostic: BYAPR12MB4598:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB459893BD127195EEB2951993FB309@BYAPR12MB4598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fw1AviHcKuML4kFU52p124r1o4y94LUYP4PbVkIhHyQjIKmAf+re7OWoE8YtoEj+7Rg1JOrgttlVDvRTAQrucdgvmMLDDVOnBzDeKhY/VU49gM72hU4bcqfh9yA6G+8cXED/NSSWthAUQNARnru0Q61UIkFOGhobFQ9k0LP46bjaPVlnHUXbgQhGX8L1TvBiVSM5qiTZ/fxQT9ozFU/R/x8V401QbaQbcUWs/Zkz0IJpEuP/VeDrL0W1JrrqcMLyKgP4cNpuhKVo3sUFYxBh3wDwX+z7h9sbfBshJ5lmq9PYE1Y/7PWEpm49vAx6cXEMiR34Nqi08YJ8fYIlLhJ/LN2lVc46rhl1oGGniVVNZ9fdLX7tFFexrIovFoPQuNckkywu1NuzqwkK3jn4ROU8NR51gLcEI+DdPV5/f8wIFjPtoraCcTjrTGFhYgPZrcyazeTdyYMFjQ6IWmg3cu1EVCdIEbMoeWl0NpRrkKGvM4z4bFIQapeSrno3U6mAw0mQw/vEjZxR4b4SmDr4H/h9DOjUe5xihVTD8bTnzWXtOUX/pICqjzkL29SQCL7r2dgg3xQVBsZsbBFP2GNyrOZX0m5hIWsMleVGcBOPLgROmySk0C3K+Tcpaeb30BHCba1faMhNVDmmf+LTlVP5ZazcGfeD9wNh1YDo5iRTsdTsVhXhPL/cqK0LaKHzJ8dy2geP0kHtNiPr7VhahFyhJxOP5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(6916009)(508600001)(81166007)(356005)(54906003)(5660300002)(47076005)(316002)(6666004)(36860700001)(8936002)(4744005)(336012)(40460700003)(26005)(70586007)(70206006)(83380400001)(1076003)(8676002)(186003)(426003)(2616005)(2906002)(16526019)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:12.7927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aac749f-12ec-4c9e-622a-08d9eda8c2e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4598
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following fixes:
-Fixes bugs for dsc mst hub
-Enables 29 denial itnerface by default
-Fixes dmub outbox notificatoin

Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2957758a7abd..e2b3ad70635b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.172"
+#define DC_VER "3.2.173"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

