Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6471BC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 04:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEA561279
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 04:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEA561279
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4D26E448;
	Thu, 15 Jul 2021 04:11:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86A96E4C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 04:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDUcYito+GadHA1fpdiENbPoA5WgcFho2YOgS4iNg/DvYNHzgrRpEHSvPVoEY+vSrVF26oLkD9MOm/0c6Zbk2FwPDoUcJQtltnKr1kBN704GxBCC7LMbDIEe5uLXIUUg/kUvCagu+kmS2vKt8BBsQu+HLX/MpJrgoU9UFz/tCz6o7xXClXC+5PHW6Q8jGAPOjIPoNpSDUCNQJcw7fUDMbYDqLSwOmEHuH5AhLOyzRJS4mK00eeKzh2BFs5ajzTuZEe4PLOaJ4FvKIrJ7wxTtYfqviEy3Eh6/7KE1EriTbeydpaL8pdQgdE0IAvpqrQnaj/1VUD78xUuN0jQ4rVbHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhz7F8doLIoCicrXoSNpsg+3+E/eUmqGjW4LPhLen58=;
 b=f0qhxjXf3SaduAFb6ltkC8CIwiFyQjnDy3E7r2cpUz/73nNC0/okf+0WlzmfSwGsWz9nyNlhNH8vaVWoWBBXigJIlBjSiBJS+h1/NAsH8j5Ect6dK/ogHjZUzO+ZHvnRtWuCFmIhnJ2kKGyE7q4LJlr/zsECsQjs6czdHjkogG3z4Pv+1HlESnR+Lr6PxjGBFoNjKQB3gDzkKWvPpTQsKOIMZy/jW4//AdAo5Co+OT0I1lB1fa3zLAK7Ir+D9L22taeOUH2E2yPlR3s40W2IZIZ3K/hcvWbAKioe9ZshK3OBR7kU+o3e+Buzv42Mwna4BsCpmr9L6m/STs0bTUGmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhz7F8doLIoCicrXoSNpsg+3+E/eUmqGjW4LPhLen58=;
 b=d+zHda19oUYfbQZ6zC6HAR//EY8+3DwOOs6i4vtSN4MpZg6wrn4X3D4PnUxWZLMVGh98Ws4Rau/9s/LouolJgMXGXhPWrF1TbMD5uF2C8fYRDLXsY3eaAVywlyuIo+QZnZ3wrB1Fb+o7WYQmzti56lHyVLZqj2tjCXO32+G1/tc=
Received: from MW4PR04CA0206.namprd04.prod.outlook.com (2603:10b6:303:86::31)
 by CH2PR12MB4840.namprd12.prod.outlook.com (2603:10b6:610:c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 04:11:56 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::1b) by MW4PR04CA0206.outlook.office365.com
 (2603:10b6:303:86::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Thu, 15 Jul 2021 04:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 04:11:55 +0000
Received: from lnx-glk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Jul
 2021 23:11:53 -0500
From: Likun Gao <likun.gao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Date: Thu, 15 Jul 2021 12:11:04 +0800
Message-ID: <20210715041104.1110022-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbb6a632-95e5-4733-fa7d-08d94746aed5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4840:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4840C3D54CF8AEB418C4FE83EF129@CH2PR12MB4840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qmR/craEz70KARfy6oDuWXqzMNZN1e4jS8/LqVAAwMZqdfX4AKF8xETlvQXilKEztmqG4F/nY2P90I7QXxmWCvsMdQy7vXjRU5okXUvCaAddwavoKjeXmc1wc515A8GeFWSnjPRgA4UnXTslMzib/8qgW8tIF+2yLNAkEyZQ6vtUqy4m2H/Nqt93q5OtPRzPIyQhszRu+3Ksa0BhePm4fTAClk62wjxkcuvBYwhpb8VlKrUNrXPMcZ9mtRdjmPLwQchpLTsTXK4qJEULo8RKHK+j0TPKkHOqqlxHrEwgOlmVAnk8dkzg6eoIHa5P1yP89qLgVMILvS1HhxGHwtgrd1MIJ1bcK9vjAgizurLVU/QU4j/zLjAjE0V6OQNg2EGA2UM4FWN9qkV8a/eh8NOxtsMMFcGGE+6z2HVydIfDxl6QAzB35y4UQnnec2g/ANZ0JEIxgUA9SAdeMcM+9hq3RmjQU6OopgIcbkEEzK6wNXFLd6beH6xsif5iqxbfFrLL7OjFO6isDYktkGVLI0Hr6Vilntca9FBX+4oCP3VKvhqHh2NPor0VOoQZu9KI50B5/t6+fL0RMcZyAI9fZ2ysZ0UHPlf+ecanZfNgq04BuXqKZwr2pn417GEm/+Xemn/pZonBj/eCgw8NSKrI79gx8Yu9hG3mWvuMjD6W/nAtpH+iNu7CDY99WMzXSWee6dQAV4fAd0AxD36BIxoRIHqee8SEh2MfU8MijPUbLDfpSY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(15650500001)(478600001)(70206006)(81166007)(26005)(82310400003)(86362001)(44832011)(70586007)(83380400001)(4326008)(54906003)(2616005)(2906002)(36756003)(186003)(356005)(6916009)(16526019)(6666004)(426003)(47076005)(8676002)(36860700001)(82740400003)(336012)(1076003)(5660300002)(7696005)(4744005)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 04:11:55.4508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb6a632-95e5-4733-fa7d-08d94746aed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4840
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
Cc: Likun Gao <Likun.Gao@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update GFX golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index cd8dcec7fdbb..7c08818fc142 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3308,6 +3308,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
