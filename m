Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8609C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 09:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8F261C2C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 09:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8F261C2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044D16F3A0;
	Thu, 20 May 2021 09:50:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309F36F3A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 09:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnP4uTeuYjAYZlAjT3Hapy5PAkGb8qc4I4YaLnRUPGF8683ZiFnYWipC/erC9B8JMkTp+WpvEpxRNFteTBbEDxkMfDJ3b6DgXT+v7W7kLcOJVRUcvz2AqABA3OyxpH8rwD5CDruxJRxFXoFVx2ThGfY3dmboM97pTJqdUXSCa/2KUwRQiMUOFdK855mfTixNFKl8TuXwyLDzHFBRntbP6XF4LPjB2J0Qxb6E3bxvhl3guCAgtHCXccwPb6wT5G26UdKCpeuY2B/ZIVBIxYuiIQy7FsZR/olADOauG/yW8cy/yEXMyrPUGjqWx3hOvDZFBHvtreLTN1qwhsBlJRevpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXqkv9Ngu7+kjCSXrDxG3q+mILPDbC10EV+P7VBo1qY=;
 b=PT83uyvgNe7t7kP/F+zkhF/DjOwloYnRgSTYJhE60T1ns97m/1P/avP8+AOsTYHE43n7AoIvWPkEhUuEKb99dAznqMswHpFlPdL7o50+GUgJXqgQFnFcU5etSVX99JXD4e8kmXWJ82fCqvPc5zguwbh3x3sv0wHjxzmsE79MYG+HSiBIFum4S9uvjDHqA+30gEJfFniRn3aigxuurkeJqmkfMrETv+tn0ZyiXjmnqNTw/5EX2Mc5wByOh12no7f22xqNAIizWAAB6sC0AmlzEpZC1Pr2iWuSB+KDuk1NcebPvtShAlCMIVtbmpwo7utmIEQUF1am6fJxZfKdRykSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXqkv9Ngu7+kjCSXrDxG3q+mILPDbC10EV+P7VBo1qY=;
 b=J26ReZadU98GWpAwXQ5pWLh7toWr/r3Z3HPVsOwoPhrxIhV9kTMSpIVKqQwdMeEF2qAOxldvAALz7k5tevWYz6YRksGW9JPs/9Gw0Kf4JTsJKyo42pr0R5YfQRCe57a5Xns92W9uuiBcOQXK3OI2XEYyRAUX1wUad0UaV9r2KI0=
Received: from MWHPR20CA0034.namprd20.prod.outlook.com (2603:10b6:300:ed::20)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.31; Thu, 20 May
 2021 09:50:43 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::23) by MWHPR20CA0034.outlook.office365.com
 (2603:10b6:300:ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Thu, 20 May 2021 09:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Thu, 20 May 2021 09:50:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 20 May
 2021 04:50:41 -0500
Received: from fc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 20 May 2021 04:50:41 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix return value in aldebaran_set_mp1_state()
Date: Thu, 20 May 2021 17:50:38 +0800
Message-ID: <20210520095038.3684183-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40bbdae2-2b8f-4313-51ea-08d91b74bbd2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4135:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41359212B967AFE8BA6C3117FE2A9@CH2PR12MB4135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwHXuyObM1p76TqQcEBItuEWr7B51/eUKIl8yjafUT1gR/KexXOpPFrS1IGvXfz5skPm17aDiICz0FpdKLlW8lZyMocKi6cVXi/xibh31RN0PQ4XFFfmeZgh1wkUYLW7ouk3Zdgl9Zya7jYsXKER9S2aUZgNDXojEbqY8FhLtqF6hAc7mETurwgPGRCqrZaEM3uGtGxqXGDnieL+Rp70vuItqE3IrVG2aa0yuSN9NLjpBYs4ZW9BKkRMUrAP/zcldfAP6qIZHK6qeWGiIJFD7vLGeM1PLPcLcC1XhRKAV1svW3HNqG9s7owdpYspr6anW2AH+QzpPdZ77QgLyB/s+5Mi0mLSJXM6pQffbDfFnbVv5QZ4uVXY3zliuJymtRzFpyA0A6i+MKbQmasNkNGDZsGSHHAsMOJyoPcMFIOTl7yZ62VoXmXxjB5wLz5AIXb95XaH7yFBZtN2K5b/NOWSUCaeDKQG4xyRJn6v7wymYS0Pu6r/EO7f7or7PZ2ovV2qNgXny7nFsEPSMRYH/loTTkY7Zs2XyFUEnUz2+gSuN0d3b9q/LU+iGz6HBrfjSontczX+xNoKldzVnkjT99g8li0gSbfAs7DSuWh/ZLKOUV2Kps4wubtt+LWmoTuly+C57hjwAyUjAtIixyPs4t9mJo2LfYPkSD3WhkAzfPG8vpoJeopZ0aKuXZXY5/GUevXC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(82740400003)(70206006)(70586007)(356005)(47076005)(7696005)(83380400001)(81166007)(8676002)(86362001)(6916009)(5660300002)(2616005)(4326008)(336012)(36756003)(186003)(26005)(1076003)(2906002)(426003)(6666004)(316002)(82310400003)(36860700001)(8936002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 09:50:42.9325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bbdae2-2b8f-4313-51ea-08d91b74bbd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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
Cc: Feifei Xu <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We should just return error in invalid case. For valid but not
implemented one, do nothing and return 0. Otherwise resume will
abort because of the wrong return value.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 5d04a1dfdfd8..5fcfd8e1a548 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1781,13 +1781,15 @@ static int aldebaran_set_mp1_state(struct smu_context *smu,
 				   enum pp_mp1_state mp1_state)
 {
 	switch (mp1_state) {
+	case PP_MP1_STATE_NONE:
+	case PP_MP1_STATE_RESET:
+	case PP_MP1_STATE_SHUTDOWN:
+		return 0;
 	case PP_MP1_STATE_UNLOAD:
 		return smu_cmn_set_mp1_state(smu, mp1_state);
 	default:
 		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static const struct pptable_funcs aldebaran_ppt_funcs = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
