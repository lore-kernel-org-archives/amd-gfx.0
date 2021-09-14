Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14857C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 14:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAC06103B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 14:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCAC06103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD696E4D2;
	Tue, 14 Sep 2021 14:59:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F266E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 14:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKy7JVor1iT5BPbVOHv3JvhhzG3EXm6gzWD2FPLdl73YVunFeynfS44lk9mryu3JR8iEWRdmqAi2B4SHSiIz6A8rcMVczVqVUvGqiSo/k/f2j2KQ3nhpy0jQxgC4v7m6QTd+WSiJ19Wu85KjvNLW5gHnqkrpZHhT5zSJ2lEV/r4Ow3Htd/0ssTsSf4/2rk6SpgcGP2JV75riXnVjACy7I5IyUMC7h9bTOdKk/ALctjrptGBSXeNlqzkueTSIxkg7q17j6AYRrwG1OeMTvd8mwPoe5EY0zWlswYk6jYTkCbDUP7BMF30UeC6IsEg9CRA4x/8qGcbv9iAf5JQY+kKwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NmXLAjlL815ZooiS4FjahSdW0UQfetvlHDuzhpjlC1k=;
 b=U++u1UwwRYSKiQWUO95ZvPy1bLKvjQGzpgYu2hFrjzeKkHJMdG3046iusXw6P66Qr0UGq9f5FZQ47grcjF6WlR7scRakUkPJNEK/J54+MO7ROMB/47HIp90/OqkeG/WOeIneY2abXhxvcWhBLiHB8G7+XnE78UrX3QVe8m2BL9nsGJuH7ypL3cTooAf/ZMdgEoN5TI1p8Tvu3w3e9pe5nPXuz22Q+3OWqMfwpOKm15X+EokcT/NO6/TyWly4QhFqEw81n2Q1LyFACD79zUjJGcYep5SdrM7ll/JGFsaMIvY2/mSu88h7aZaHkhOvwziSxNK7ME6waw7f7+7eH5knGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmXLAjlL815ZooiS4FjahSdW0UQfetvlHDuzhpjlC1k=;
 b=Th04W9QXImlsMS+SbAACkcNfm+swGX7/KEjwwwwYTN44aDPIxfBOyWAXz7QvRy8bOeJAPvB94Yvoah0yg0gwFZMUbz4p8rpbdIT2TU6tcwOrvxQuV0OPtK9xorfbIwVJ6S8vmu91C0KijmxLm6Z4NJJLTMULPA8dUmVLG8jnQqQ=
Received: from BN8PR03CA0006.namprd03.prod.outlook.com (2603:10b6:408:94::19)
 by BY5PR12MB3793.namprd12.prod.outlook.com (2603:10b6:a03:1ad::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 14:59:32 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::64) by BN8PR03CA0006.outlook.office365.com
 (2603:10b6:408:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 14 Sep 2021 14:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 14:59:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 09:59:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/display: add a proper license to dc_link_dp.c
Date: Tue, 14 Sep 2021 10:59:12 -0400
Message-ID: <20210914145912.1569716-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210914145912.1569716-1-alexander.deucher@amd.com>
References: <20210914145912.1569716-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8fec585-ed61-42f7-22c9-08d977904261
X-MS-TrafficTypeDiagnostic: BY5PR12MB3793:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3793AA3FE7E03B396E24572FF7DA9@BY5PR12MB3793.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOwOSCtqf5sczi3Hlth1zrWJJNMuyAWu7UliVcYiF1m0RMJrkSY0UM9XdYXd9eV7JSZZcxV9tn4qi+JrhwHzEAvsSggsuKkEEnT7y2y3tB+dPg4i2+z1WthnnHjMxyt7r874m2h2Pqu+JHLQsfycDe721LUPZ6mehC0oHAm0+2/NLSKFT9FoEl0qRBZ+uSo3icgXeBLnGM+mHwup2gSm9w3EDUST5fH2zvTU9ortX53Tlqr7lYhx82ubb7Bs1kDV4HV8umG2H2d2cSXWCJgXwyHvYjMiDdBjVydWGKqleuCNLKnOzukRu+IPhXHnJ/I4qL+i85MXWqVAQQ1fvFhVvVxkXFzrUxJG1Sx+Nl1XlwdgYKO9ybsKe+aNBDhhYtb9b8WuNy2EO562S+waga8+nSK4ev3wFy2u/iqsIdPaPLahCeJ6Yj1mS1Mar5ILpH4lGMy2vH5p2vJrwo8vQfs1qjKFblXWqGim5e//fE3lSEQHna3rS81KSSuc1StHWU6u9pgrHpJuontWTaW90xzDCPyvRzJw4nO98M1I8n1l13vGEwZMZycIVirBIuXKYEWNBX4zvLV3nTUfGVANTYKw6h2dB1jejlFV75kNEboSFcSXnLZyhNF0N5Yi1srh5bRo/8eTVzHRLo3P32jvj/svryQytCRsbPIzXZy2Nhyl8abZCpiJzc8CiW52nBukAjOYoIryDwhK+AK9rL3m4hs3fEui3oQmSrvo+ufx0oKVjbQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(6666004)(36756003)(6916009)(47076005)(81166007)(2616005)(508600001)(2906002)(336012)(8936002)(426003)(70586007)(70206006)(82310400003)(36860700001)(16526019)(1076003)(86362001)(26005)(83380400001)(8676002)(356005)(316002)(7696005)(5660300002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 14:59:32.1854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fec585-ed61-42f7-22c9-08d977904261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3793
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

Was missing.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6663cfc4eb71..7ea505109340 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1,4 +1,26 @@
-/* Copyright 2015 Advanced Micro Devices, Inc. */
+/*
+ * Copyright 2015 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ */
 #include "dm_services.h"
 #include "dc.h"
 #include "dc_link_dp.h"
-- 
2.31.1

