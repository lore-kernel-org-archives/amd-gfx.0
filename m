Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A027DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7062760E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7062760E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3456E1F5;
	Wed,  8 Sep 2021 14:55:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3AD6E1EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBoUctMfGBCTWPl1bUorQw8RLPw9l03gizZTrn0nyUKWZiW/AXJkufS3dUPeJbkAZARMToTeZ+Chlkt2tHOYrl5chuNBe096GrXaPfFU0yaKTjVpeyXepsARLnCN8d1ttFu1cCjK4tEDTBBjZMfeKzoGnc3jtzcoAFgcYP1OdgHdMZMRJtoNQ9nhsZ4LzjWEX02kPUNL6lsyGG3ph9LF5ajDNgEUYSi47txAhVlYGR1Cqk63ZaESOKaUpKJqIZx4JN5UjwWbSLAlLXWdfioRozSGhfdiPtYHYZdE4exqItnz5CQEop9S5T3dYwkk9ecLIzGHqvcOb5c7jUliqsLp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=zPntxlWXtR4myosS3ZPKzEP7qX2axmsdt/qop66afCU=;
 b=LnQG3C7bGgRAV+98lBaPnz3FIx3gURBhhdyweDJLi3XXeE5q+Zvow8EFbrM+PbYhKrGEw8qLxnPI3n30WRaFIG9SWpKVQ909V0r27Eg6NwszEM/Fq045ytQloMrQrro778Tj3ag+O/BnbwJPO/v2AmSWuE4lzieHtMnAcvma+p3Bb2WQxZfO6BJGoFn3O4MnAE/0rgRCY5Vx2fp5FOhtmpDB2xR1eqssPFUFDK/el7PqNQvuT2AmFnamVqIiXARENh1wdXBg/DkmCAMiwFMiWl/ZX8WtSL6pjK0uYQrfwFypSiLpPQe6XKKHnfelRVtaqcLo3XV62JUpgk7UNbv6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPntxlWXtR4myosS3ZPKzEP7qX2axmsdt/qop66afCU=;
 b=YtV/ttzD7p7hz1ahZRvHPv3DR7gKtSRXSLPl2yPRzsYGQzY7EQ2mR1k7qGoiGAnYRzqqqHM4hS17umcKoF8ATPQiL/fA54QNrKrSuFiYNYzTA/mS/ijC16FmUlqVFgAtVgSktxfckj0lRVW3gbQEDqy0fAPRRjCF+lS4h/6LMM8=
Received: from DM6PR02CA0111.namprd02.prod.outlook.com (2603:10b6:5:1b4::13)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 14:55:08 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::ba) by DM6PR02CA0111.outlook.office365.com
 (2603:10b6:5:1b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:08 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:07 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 27/33] drm/amd/display: 3.2.152
Date: Wed, 8 Sep 2021 10:54:18 -0400
Message-ID: <20210908145424.3311-28-mikita.lipski@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 197c403b-19ad-45b5-1f75-08d972d8a6f5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5108:
X-Microsoft-Antispam-PRVS: <CH0PR12MB51082CF2AB65D1E35177FB89E4D49@CH0PR12MB5108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Km4YyLhWbVDjsYGsDGv7gLp3Ca+nnE+sAafZFK8Vx3wBh6t0GKlTiCZhyLZPbZoCTM+29OxzxhY1TzqvG30oFR5QxEeopIW3d8n8Ct3vmhBj8qXkNZ7aFaexRy1HnAT1PZ0U6hx7F4kR9SDl8dgdxs1caxGB3fYDhIQ8KLPZi0Or5su+pCGYXbDTdpguya5W5rNkaVjvxRMRdsiDWUkFt5huNu8M1MENlvL8HBn0WvTCIiPXylV6Mj3rq3fwka7YBlqULg9DdRmcMXPDXv7RiGo4bI1jW1qGIz9NTVRmiG3URjrg4NeV1J7HZ7JYC2rpAf14Ibb7yx3oygRNvAyO3RR467EIrVqjIELQUD4QxB5G8zfGIP8V2onPJ+1xNvXkozTfEyP1J88UrE8mpgDTFnUItBbUbGMMNmp3hkKG2YOtrT9pXmytZdVgh67tHu6QLJ6xxDKvw5EPdG/J749au0+/RCfmDe7nw0gkzAvc0cq4SctxqkgOuU+J2xx0YH5+8E98xp1X5s5fYZ5UMxBvRsYATv09ApPzVizuxRHsHnY0V0cOyjy66Yy5a+TTlKYuVJelQSC3ON0MYVbCvGbUyHlkJ/cu3UDaKVL5tCsUMIynflbjpe03YUEmvbq9Yd18CBARhrvnAZu+m0+hMsem5uHKvHNN33HVWVLSth6UJUBjH9B/sj31vyKpEB/daWrd8mECNBfB8yBTbmO8vxqpciII+YYE03/E7lJPZYM0HgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(70206006)(2906002)(82740400003)(2616005)(4744005)(36860700001)(83380400001)(4326008)(82310400003)(6666004)(47076005)(70586007)(316002)(426003)(186003)(1076003)(44832011)(8936002)(336012)(5660300002)(356005)(36756003)(478600001)(26005)(54906003)(86362001)(81166007)(6916009)(8676002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:08.8300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197c403b-19ad-45b5-1f75-08d972d8a6f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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

* Correct degamma coefficients
* Optimize bandwidth on following fast update
* Fix multiple memory leaks reported by coverity
* Get backlight from PWM if DMCU is not initialized

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 134faa7a1937..442605354430 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.151"
+#define DC_VER "3.2.152"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

