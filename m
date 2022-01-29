Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7759C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 12:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A461122CA;
	Sat, 29 Jan 2022 12:34:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2311122CA
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 12:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auzr1IohSYb1zkRn4tg23cTs5P+nnRB2iERC1ruYov0+lPEf9V4CiNU7y3gwApnjjCwSyWKZjDdJ8lA9xOC7P1uoBBS/wEhvOz0EnoLpNn5+exp83AS1qF/+hMJox8bP56G8iEBH+fZ/93FpDIwl4rTrDfuglC+1JjDAkgsS5+sdKiKr7Ck/a57wvaCU+LKn9Uku1VXYTEQRajXjrQpaf/fSfxj2P1X6GhzrvKJYXa2LQpGF5JO7R3NxBqFOw1wxNsJTrxBMj1KrtK6mGFDRY1YKVyW+5guIChe4UueWmU0IlrgBZjmAB2wrHEGJo8/5dWq4bZRdgb14BzbeZr2vXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnv5cLLmnfDJZAGW8l9P/DX9b3SznWGkF7/sJTxiJkg=;
 b=Rf6kc9KQfQNe5fhhiBIilREUiz+CHQtpf8pWvbGl598T1QBDi/hdXVEvqbNKtD+tQTJyYSL/9Kpo8aOGZzuR/7S64BhddOGjvL5gnsaKvuhvZHN2I0+wtDeNQXuWwPFc2T2SWqY9RlEapfWUy6fERNnVrxM5ujNRpSx8n33Mu/onp6QzZ0nb8FEHizuWxx5wufdq/ORE8gshSH4V2Zn1m+nhL0kWlASlJGM5+VOeAgUZ+0VnAmDkjS3SbkJrVuulpNH+I5iYdLxQmOeMNB6kqWfq2SiIVt7LmkaWr+3nYd3jZJtvr7wfmeVu7nV0fRR27MaTdZ4YElBSDE8uFgMwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnv5cLLmnfDJZAGW8l9P/DX9b3SznWGkF7/sJTxiJkg=;
 b=zCk15Bel22XPGR3bn+g87humLuqtFtz9Iau9E+z5iBjBt28vyU13pg41kfYpIztz5+4B6pA0ZKEqa+2AB8odyRhi0QqUp5LMS1vbO1tz4i5n0w9Ii0ngNpGbVhPuj1OLqiXUKQrwyWTHmNcHRV9mFGK5rlOtrD1XJ4AEcHva1HM=
Received: from DM5PR18CA0092.namprd18.prod.outlook.com (2603:10b6:3:3::30) by
 DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Sat, 29 Jan 2022 12:34:36 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::a1) by DM5PR18CA0092.outlook.office365.com
 (2603:10b6:3:3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20 via Frontend
 Transport; Sat, 29 Jan 2022 12:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Sat, 29 Jan 2022 12:34:36 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 29 Jan
 2022 06:34:34 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] Revert "drm/amdgpu: Add judgement to avoid infinite loop"
Date: Sat, 29 Jan 2022 20:33:52 +0800
Message-ID: <20220129123352.3765260-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129123352.3765260-1-YiPeng.Chai@amd.com>
References: <20220129123352.3765260-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c9449c1-79a0-40c0-9baa-08d9e323b5de
X-MS-TrafficTypeDiagnostic: DM6PR12MB3721:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB37214227C960BB0A83312270FC239@DM6PR12MB3721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjqtrgkkuu5IU5EzD59zTzUO3lie3+uDG+NvGmX3kUQjJES2+xrE/xG41nQOL9MS/tkyYX8FXG8Zy8yywDzyPdFVqj2mszu1IIBw1O8osHcKSIYZL19k4ZkwFG3rgWrWFkX03MU+ra5ncmN1E0ZfNEg6nMY8DYZOw9wAbaRyS8/qR7pP9S0yF38x6f1gwAng3pH6YCUAZiIWRU9QQKlhuxnSmqIE0N7U8YVVaBNVrwd3eWBMozhRjQZLIMQOrx2862KmSdMXWhSArlb3/7ag2wRsu3sKE1cuF9R/144UNPuI2Pi7J6fzK8HjJ/NIKiG4cxaUI9ukVpSlnqatNYWE8cxZ7OzfNMI5Aq4IYlwX6OVuS3mD5MAXi/RHHJMdTkSMDz/GR3FqfLyvRiz6bqRF6+NrzT+5kba0ltXpv/5zC1ivgmWKKwdCCex91mD9F1Te+4usSTmBUbAf4a3xw0hFlIvGcm3uGQunLHsp1dRzTwiIXHbZ20HSgfauZZCGeg8hJmiecZNO+XMe+dgV8a8W1os23U2AGlfe49ItIHTpIf4Z0SYXwqwcqnw+rk6CK9+MYzamND66otbVC4lHJYJpW4ctmqrhPlMay/PmnVC7Y/Ko6FJ+zfBiWJLYKVlHvGkDYWUSp7hNZWPl+N4PqfBJB+2YczmFQ50kz4xo27wOTllGcuaozPr/X8pFWqQbG3KUoY2T1LjEy6LuH+S1vvCf6z+VSyxn5W5lgpfYPWCJFig=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(6916009)(54906003)(316002)(16526019)(1076003)(186003)(26005)(426003)(336012)(36756003)(2616005)(2906002)(47076005)(40460700003)(8936002)(70586007)(82310400004)(4326008)(5660300002)(7696005)(508600001)(81166007)(356005)(6666004)(8676002)(70206006)(86362001)(43062005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 12:34:36.3167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9449c1-79a0-40c0-9baa-08d9e323b5de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3721
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The commit 8583c8983f1b ("drm/amdgpu: Fixed the defect of
soft lock caused by infinite loop") had fixed this defect.

Revert workaround commit 76641cbbf196 ("drm/amdgpu: Add
judgement to avoid infinite loop").

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b0aa67308c31..5a43a220e9fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -886,7 +886,6 @@ static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object *block_
 static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
-	int loop_cnt = 0;
 	struct amdgpu_ras_block_list *node, *tmp;
 	struct amdgpu_ras_block_object *obj;
 
@@ -910,9 +909,6 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_de
 			if (amdgpu_ras_block_match_default(obj, block) == 0)
 				return obj;
 		}
-
-		if (++loop_cnt >= AMDGPU_RAS_BLOCK__LAST)
-			break;
 	}
 
 	return NULL;
-- 
2.25.1

