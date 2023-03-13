Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DF8C6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D4410E46A;
	Mon, 13 Mar 2023 01:45:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7ADF10E46A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRnQifdou+C9ac9vDv7FgafsuJrER3dEvY2duJLFpcsqacAOdFxYMHgdxK2ISOicQD3LhEI1TjmTKCQNlZz0TXVVDuN2CvzreOiLHqz4i/mOdBTnDZuUX71LxStOchLm4biAxtLRRr03hUcdK3a5xAEDGhipPx4tQlm4aOrOpX+NW5deZjKlqvcZpWodzM6q4XqpUmRNCt89U516KVuwLC8T5T2Ptb9Jsm+vdtLX9djskB8irTLwGHBRzIhk1KvGnfOJhaajx3n+giBD4qK4ZqMgehr/nr+1JESXhXDhE+Zwz0/O/aDKU5kgSEzTdN80CSCBwQa53+mkFlBTatgOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTWAbGxaMUZQiM+42vQVEJqp1NJkyI/UxnjFxUqIuJ0=;
 b=WcI/cCDklyySLSzOl0Fyt2Jgur0R6DcvvS94WYIkN1smEDDS7IvNoW9OzXfW8rDl2jkPXj8UEX0Nwo3uMRx0I4VTyCk8JeZs0anBBZ+RC+eppwqI5KxpMfRR7sT+E478HMHPHUitwZY25qdT5+LildAVzM2iOabcT/h1HyfNTP3XuVtJu9+MkGsECeCI5OSE4JIaC1TJLsD4NwfOLp6KdbQ16DlOwMkJmC7rXF+ot08xVEztq9hnx25EQPL9U4Pr/Oz9C5ZopNxOgsXsYIVa7/UcA6PJK2hfSIZyEqN0mgHw9srReEsiDsI0RvBRsUwJDE7gvLKKrBnsgtzHzd5qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTWAbGxaMUZQiM+42vQVEJqp1NJkyI/UxnjFxUqIuJ0=;
 b=C/r8EDl9yyWnMLe8IB+KEvWzqQuBRlXEmmRyX0ulcRD5j9UpBKG2WLfbp41YGT4mg8OH3ItuLprscO9bXtSIkpNK0OI1zv16df7lJccVDKKil5lPc67Ycq0SvftEfew9Zp8L8g+Iy7oiooUJalrN+aUTN2jexPhw2sfnLJvhsq4=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 01:44:59 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::32) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:59 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:56 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 10/10] drm/amdgpu: drop ras check at asic level for new blocks
Date: Mon, 13 Mar 2023 09:44:03 +0800
Message-ID: <20230313014403.21903-11-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313014403.21903-1-Hawking.Zhang@amd.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5958cb-6ec2-48a1-b2e7-08db23648e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaU4koWP84y1wfzwUI6giZVN+tmJOziRbYs9BO7675Oy29Kszu5NuXlV1dkSnporDW6OC6nXgwlSrX8CHNZWQCwu3sY07c2gVkfResVUejbP31mw2cO9FIGWJwgQ7foK4KM6f/WxnxLpq/riV9SRCCV3SGZrYg5GgUpENZx+3YVKw6Fk/vmCbcLGmVkzgvMVm8hP5hDf0aUu3RhLtvLVk/UCmCEP7ORhMOCcNWO5UduareojSt3ENJfX9cP/ZElX0l2W65n+/XuL/hWhOE7SFMkuwX3yGxIzorF6zsmIpuQBbkcDUH7il5Ff5cAidb0YylUDThMKdIUmZ4lwVqAVWIClqRqDOALYxnul6dnt/bMLNFAW4W8bDpahDbBW+ZqRbniTYgsOwu0UTgB/IQUjDyWLtcUlkoyxp6GTBOIRUE+u8TWquDC9admEtlm5vYiJQ+7SEOhNbz7UteTLM/TM05Mb9bNPQHb3k9IrB8WmYAx41elNqkrKnPCWPbskvnGB7eJ99cJKEOZOsVG1FlNbJTNs7a3FvwhCSgCJhBHnu0VpERAk87hu4PIaTBPluNQkMOKgrCPVGHhqJAS065JNJvtC4j6OvVjJv1Mti1nUtvsDa8XQfmnMusL4ow+KVWGhYNRjs3ZdG2W+gsAEW6EFfY2MAdiM4TRkjTE4GEC8Uwc8plgE/UIZ3BwPGbRwwZ9tOtS2N8JY1rjwbfrONf13R9lCdUBNsIDvURx+UqUtkzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39850400004)(451199018)(46966006)(40470700004)(36840700001)(336012)(4326008)(40460700003)(5660300002)(8936002)(2616005)(41300700001)(186003)(16526019)(26005)(1076003)(82310400005)(36756003)(86362001)(36860700001)(47076005)(83380400001)(2906002)(426003)(4744005)(70206006)(6666004)(70586007)(8676002)(40480700001)(7696005)(6636002)(110136005)(316002)(478600001)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:59.1977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5958cb-6ec2-48a1-b2e7-08db23648e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_ras_register_ras_block should always be invoked
by ras_sw_init, where driver needs to check ras caps
at ip level, instead of asic level.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 834092099bff..c34f51be793c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3076,9 +3076,6 @@ int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 	if (!adev || !ras_block_obj)
 		return -EINVAL;
 
-	if (!amdgpu_ras_asic_supported(adev))
-		return 0;
-
 	ras_node = kzalloc(sizeof(*ras_node), GFP_KERNEL);
 	if (!ras_node)
 		return -ENOMEM;
-- 
2.17.1

