Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C0C60E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9C0C60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818D66E1CF;
	Wed,  8 Sep 2021 14:54:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6F76E1CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKruR+dpJgV+fuRbl334v2HoakqTGfDeY6kxYiHSB5EHJc3Y1W0W8Ne0O59j6owWKEbjujMMtRaeHT+xlcw1pTmhRZOss9R4xPm0MlXb9sQkeqMM9lRckdVxtOtBi4tzlyLUjnlKGQy7aUg5sNHpYLukouNRaElgOBhRxIsAI/juWPhmqmiQYxU862+YgAxqLHbbP5GD6Tl1jVuDImEpGqEoy+GOnkNkNHMUmTsMeNT0OAEjKBavQyF71AuQGsE/BoA7umgMWof2SHyTdJ51zpvS5O9Y5sbN/eHoBESfp+AByObGPVv+Fvz33Ny2VHX73IALEC/XQcfec3tMpLLw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHjKJ6e71uM8E3PLkM2Cn1E0H0XV/5E2kwfgkna2yGM=;
 b=GDAH16XXOr/5HKFDd1wXUye3ZRViTdtBqDdU/qzkUhAAxDaySuzfLvIbG7M1OlSs7rYU1alkA8l/Bu3PH5+Lp1dMRt+/u8vvzzwUj3hXRgyc9q3xgNjMCTkT3qokQQxcM71du9RnPOo902ZitLTk0kKs3QXmfMO0/dvX6koQqW99MvEiAxdQS2Dw/uX6E0LaiX4IrNaMPP8Zq0YuBrlI+iNDbq9IiIKjFGX/Q5K1ABc8x69z61a0Yzrv+OQhNMiKidetwUifqQxzO+2oFElxs7SKA5AmFuCBVW4xat47S8pGUWuraGmtUudjGCPdd1OYloX2DM5FnxmJjpdBKpvcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHjKJ6e71uM8E3PLkM2Cn1E0H0XV/5E2kwfgkna2yGM=;
 b=SFSBS28N3zbCSnOlBiAYV5StPbL5CMSsnp9GVINz9WXupGGSkQb0mZEZcYHvhfrDr+9Fu+mFegS0gR9Gsqs+hM8bvlMNqAGncphI+oVMXxZg8SLCdIPUONoGosLfB0tbjW2a4o6I95dBtnadZboAgAXrrMHzxRPpxguoo5XBjW8=
Received: from DM5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:3:23::19) by
 BYAPR12MB2614.namprd12.prod.outlook.com (2603:10b6:a03:6b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.24; Wed, 8 Sep 2021 14:54:56 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::f2) by DM5PR13CA0009.outlook.office365.com
 (2603:10b6:3:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:56 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:51 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 14/33] drm/amd/display: 3.2.151
Date: Wed, 8 Sep 2021 10:54:05 -0400
Message-ID: <20210908145424.3311-15-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93c3ba4e-0545-4546-6a63-08d972d89f98
X-MS-TrafficTypeDiagnostic: BYAPR12MB2614:
X-Microsoft-Antispam-PRVS: <BYAPR12MB261489BF5A1F13B1E5BDB0DAE4D49@BYAPR12MB2614.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvYJPHKZqNiNRUkxO18q6pqs3i1naTJIPGfqgcq+GPfVbgJm6rmb4pGEOz+hXeLccV9muaqspQbXq4o/y5oWtw8OgrSXwqNiNcQj/itn/g6oxlJE4BcHzd4D3uu7JsWJGuto78/QKh8xS2Z5MvVD2Ur3LRZhu+M9HkSntu5pqjMGz7a9ctgIAVw436clQh+WzP2txcES1tPtAF9DwU2P2cFd0vEzeRoYWqji30CWvkfQdnn4PXmx3DPIhqsjduSEnlDbuzd+lO+0LZWOc60FhXXjDpwwLBz5fS1G4VPieoLnwNAuLii17/6lBDwaL56RJa7iyxtpWqOnSc+U2zVOZpB94LnB9zv7F5eHzE20ChRR7DVTyjLZh+gA7KJpOuuFOOvSUVcqan0Puczn12AUflwQssJL10z/Q0G9Uq/MDBOicqymAmSg1vIbbKGVMpGwAK3bHH/f9w2gq8/Ujxpsw302HyH2mzAfgnpzAX11mW7m2T4EMkjSTiwfiozVQJEV7CX4SvRlQ3xFkFNKMg1WZTdjwfStt01459a67hpsf/gbC7nyonOu6k/YWQRY4Eae4A17Q4lSpqX1AaA9wm/Q3fchsyELJPm+VoR/yqfvOBVTplLV6lWVKzQjup8Jv1925Dsy/gVYGrmril2YKBDu5ChUxlxQ2y+pSXCB8AwqbJnfZ8cGls6eHMpaPmYJTqRSJHxTs+bcwO5BkkcPFCmni+msLlyft/ChpIaGwFreWUI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(83380400001)(426003)(6916009)(54906003)(81166007)(5660300002)(356005)(2616005)(8936002)(478600001)(4326008)(44832011)(70586007)(8676002)(70206006)(2906002)(82740400003)(82310400003)(26005)(186003)(16526019)(4744005)(47076005)(1076003)(86362001)(36756003)(336012)(36860700001)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:56.4794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c3ba4e-0545-4546-6a63-08d972d89f98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2614
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

From: Aric Cyr <aric.cyr@amd.com>

* coverity kernel memory leak fixes
* NULL pointer dereference fixes
* Add periodic detection when zstate is enabled
* Fork thread to offload work of hpd_rx_irq

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bcae2250a574..ece44796a74f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.150"
+#define DC_VER "3.2.151"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

