Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD85C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 15:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A79961038
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 15:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A79961038
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6A589FD7;
	Mon, 16 Aug 2021 15:04:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B30F6E02E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 15:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtwZmbgGDIYaLmry8Y5SlzEyP9NHcTm3ckMzLA48pCGfhHjNSJGqb5CveGRT9D2U/vH1WJxDCHa0gSx9Rb7dbmFJ8DEwWj7diIfFfQOLPb7WEY4qOZ+EtcOZXBtSG7thqwbkWer92bZaSP7VN7Zw1Lv1RB3fMhMfjf1XJfBo23nBOVBhPabjJe+haIOwAcEsaneka1xVPKaiTf/vIrclW8P6OJpnb9Szy2BLyAOTezniI5VI+UwsqWwYTDkTN5ip1iVw5jCjcRPv+NzQ2VvzR1yTBjbEBsqJVRlx5Y7RdK9eZ5RvKjzAsZhJfXdYdkzzHoY8vKYZ9B3tqOGoiSnkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lRxDOj8wkOkviQSuO+lqobGvikxvW+E54HGhradcV8=;
 b=U28Zq+/hTj/4zclc2l/h4389g9ChRqTay3iJ5QZ6YJtrNsGL4C1zNaKWkk99EA+Ks9kfEk3rvL+fobq86plTT8HPjysJU6lrbeykAzQutbsrb1upIxQe/Arj++BYX61TTAEWEDfdqsDbyVTVyJeEiVXWOKkRygtqKDOrE+QaqRq3/hpU9ai7IUod7E2Wwctgcw7PAJYfgrBG0lZ7zwjnOUdgF+h2nSBPgSz04dFWW8zBZoG7savnZVrN+FGeMH7cSFTwtdzz8e1RhZ+VKKFxhQpmeXhXy+MJss7FL4yK7cUdt3wCV7Fdsz4za/GWUHyZDDPyvqsXdJKZWypyYvJYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lRxDOj8wkOkviQSuO+lqobGvikxvW+E54HGhradcV8=;
 b=F4lci4r5XQ1i2g12UEnNm13w6LaVR8EML3uK9SsD7J1UWm0Y1UffxV+3qyOCNVaiD/8n/5ZurIOCCSIHlh2MW1CQ+74KLNKzMhvzvcErOMXUEFdBzd2aBQde8d3dm+Y92mCM1Xja4epyQMUZQPXajEu6BmvgRleF9dYDCL/jx5g=
Received: from MW4PR04CA0199.namprd04.prod.outlook.com (2603:10b6:303:86::24)
 by DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 15:04:14 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::a1) by MW4PR04CA0199.outlook.office365.com
 (2603:10b6:303:86::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Mon, 16 Aug 2021 15:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 15:04:13 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 10:04:12 -0500
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH] drm/amdgpu: correct MMSCH 1.0 version
Date: Mon, 16 Aug 2021 11:03:58 -0400
Message-ID: <20210816150358.26105-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fce6cc1-58e4-4fe5-7834-08d960c71c5a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00092042FF5842397E1ABA71F1FD9@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZ0DppiM6F+Qq/4iuKVC2GHqb+cmTItaT6iPDjHK1EPcA2HdtgXfu6tsrCy2761WhA6jF6NKwbVKJ2L6AyYpfkxq/8vq0krMn8jE1Y9NVKm17GQgYDNDPZd7sxvnnMcpAfjeTe4w/plZJUXHxI3agQH60G0l/IU7ZIsNZUCrwb0KJDt4mSi1HBhGqC8P0x7MGeiT8XmVUxO5jnmkHJk8b8E0lU/iOiBH4zKuPQgb9uzJCh0shhkqH1+EdrYAo+yFGQFW+kn8opcxfXc7cwedZhtX1xKoI5Vp6dS2mZuILgu2n6DuN9zr2KGu80+UQP4ROmAcqKaQwtR1WyGqgA6LquajcUPpvzwSYzFt2XiezFVgKNmEbmIdVVaAHB1QRjEOzp9xz9wmtNx0qpnZ/9FxLo15WL0wIo2uzF9xXwJUt0+hTGOg5xJ0+LCLZRhz9LiAbefs2oZr2wo/FIytrBYgE3L9Z29ru+D4J1NSO+RrXncnW84pJXvgZzhumca/HGdWf2OUMxSABvEg/NSzg4TlVVG2WYVZcLuUUMVNRE1cEA+x8hXyUf886XHdCN+B2IyRJ9T4tcYLT320pZxmeDadnZ0i9LsD/XqyiFxcYubtKj/rirJnU7LQeZlt/bZKxdnwgkxCq4UmCV0vgWijOQn377cdGtGlxBt06LzpvG3esbeq9KvB6fsi7M3nbQ5pQ+GGmaNtMqyDu8pR+qrzS0c3r7dWtDW5adX0YqvqR2yoQ7LRtn7bch1zqGsTdlbzKPycitkXCoA405D1bgheiTithg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(4744005)(1076003)(34020700004)(70206006)(7696005)(70586007)(316002)(356005)(478600001)(5660300002)(82310400003)(6666004)(36756003)(2616005)(44832011)(8936002)(6916009)(4326008)(36860700001)(86362001)(16526019)(26005)(426003)(186003)(81166007)(47076005)(83380400001)(8676002)(2906002)(82740400003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 15:04:13.8506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fce6cc1-58e4-4fe5-7834-08d960c71c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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

MMSCH 1.0 doesn't have major/minor version, only verison.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
index 20958639b601..2cdab8062c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
@@ -24,9 +24,7 @@
 #ifndef __MMSCH_V1_0_H__
 #define __MMSCH_V1_0_H__
 
-#define MMSCH_VERSION_MAJOR	1
-#define MMSCH_VERSION_MINOR	0
-#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+#define MMSCH_VERSION	0x1
 
 enum mmsch_v1_0_command_type {
 	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
-- 
2.17.1

