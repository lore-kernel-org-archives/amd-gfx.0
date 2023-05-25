Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAA5C7EE2C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 18:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137B210E72C;
	Thu, 25 May 2023 18:03:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AB710E72C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 18:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3B5TTNxXKjMbrVuSqG8IWVV/o2M/vipG3AiYcEFwhlYR85HmotHDuAcPlfdii+acNkKdg+G1r4fnNjc9OnAk30sMAuh7NIZ5aQWd9RaihLSkj7lmwHuvDXiyDW8Da3Q7oB7Cq3+hjkcqClEuxOUz0PCWd7S1oB2ZHM1AGdEq1gqbwlrUfJ5EB0xH3UaXrPSdzlqiHqLxfsNi9+rlOu3O/rfCyj4+Xuw9m6OBKZIlwUMKSzWBz2dsedPAOKjmImetbNbM72W7Lg0/Md3PqVVZYaHKxpxw+3OUFYVVVCPuASV3GVO5E+cNHCqQ8LTR8Qu1X38l51gLtkYOe1hYmo4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuLPRGJzCBTFFmIPqVt0q6cSeiN0d9bEC6S5NMt3X7c=;
 b=mxCNOrgk2uTjkloU9WB3is2IwEz20xqOK4J0wyHuDqT5vMaWWZkvN1/LivBBQaWfqWetkKj+a9qwsRxobhyQPs7TobMmdZcC4SURrGQjTKrteJ6VF/X9x8xynqMusPAqiiAkXJhNgB+vNGGdSrpvKpzaSTyTpiD5ivFAtMCCi6r9yauD8ms9wyOVU8B8eYIz9sUE1C+gTPWB+/3PHkrdjiPusOozYy4C9KAr+lvdGcBu9pUIYNaMgSTq9r1xBsIZrkTvHxkc8obPDh6k0ua1Za2Bd+sQjdiQnJj1lglyb3qbliKtHrPhIfj73XrCDedFIICgnd5p9ZZlvkevt912mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuLPRGJzCBTFFmIPqVt0q6cSeiN0d9bEC6S5NMt3X7c=;
 b=YcA9oitcZu60dZgS3/VnFd6knXcfaUYiPH5qddF0kQW0c3AIusmg1DKcprhBM1tvuLw72l8YI6S1frapXc0j7v4/2z8BT4O4mtvUOetObC8QmCRUzVG2JowfQlkU+gm8rBZqul+czlEEKBqGRhEBwD4EjhAYO3JUIbw9V43FYk8=
Received: from MW4PR04CA0204.namprd04.prod.outlook.com (2603:10b6:303:86::29)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 18:03:23 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::4d) by MW4PR04CA0204.outlook.office365.com
 (2603:10b6:303:86::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Thu, 25 May 2023 18:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.18 via Frontend Transport; Thu, 25 May 2023 18:03:21 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 13:03:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix up kdoc in amdgpu_acpi.c
Date: Thu, 25 May 2023 23:32:53 +0530
Message-ID: <20230525180253.831726-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: f07302d3-2cac-40b3-889a-08db5d4a53e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUrlCLr6nZ59sI522PHQoJ/UwF9i5E37OT0WGAXqQ09077ghaD64+SP4vDQfg61sfuh0045L7ennq6X8dX7Mau6U9aYlSnPRjilAusfAJjXlcaQr08oHpIRFu1EoCfUdPkK/fW6KiEv6rRsCYRe3lQrpWJs1XjP67VKPkjzku6+Z/Y9CKDe2JVyu9n8LN91mCgbWxGSBtsePslmrnsVSIMWayS8KvzxY2It9y6lyp7sDKwcHOkzGbDIYx1U4626Gg69vyJyz95IILk9m3nmJfE+iPVFVKKQJnJC4uoyiK+KCWIbxh1CAKHvTl7f340BJn5ZuuUvH/1COgJUpmJj6uW5hXO7EvLSEwJIDpRMBM03OypiySHte+ItMZ8iaEHB+zk+Cd5Lqr7y9RjVMuvwFNqSRiWNK8yV/frONFaed7+TYP06aUnIHwYZuG3BfORwaMWTRpyuBlnZPKhdR8wvj+E0yXgCxzsn5VD9+KY+5ZGVmQ8JjjTZlW6Le1hiTE0B9skv8jwSn7S2ncG57W+g0LbKsX0vRj0jsFmeXnJloALlDvWe7Y/yY/BqaiIZTsvg8F5jYLd4GOPcbgWNsEx/DhZ5WLnnfQViEKOtRPvb0Mn9k4SCmrbxTmkUGy3qUgsJ/dTHb3ChQ85EW52woruUoHIveYgFS89GUoRQ98rb8gH6M2GsnCuvMlaA52mXvWTYhbr7GS3tvjOKenzdZLGscX0trc2owltp9TPqOFGSdgoeunVe/fE83u38sa5Jsg+u+UZ12JHJrObGlr/ebhJmNFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(82310400005)(2906002)(44832011)(8936002)(316002)(8676002)(6636002)(70206006)(4326008)(70586007)(54906003)(478600001)(426003)(110136005)(2616005)(47076005)(83380400001)(40460700003)(66574015)(6666004)(186003)(16526019)(36756003)(26005)(1076003)(41300700001)(86362001)(40480700001)(36860700001)(336012)(82740400003)(7696005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 18:03:21.8165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07302d3-2cac-40b3-889a-08db5d4a53e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix these warnings by adding & deleting the deviant arguments.

gcc with W=1
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:906: warning: Function parameter or member 'numa_info' not described in 'amdgpu_acpi_get_node_id'
drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:906: warning: Excess function parameter 'nid' description in 'amdgpu_acpi_get_node_id'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b050d462b2f3..3a6b2e2089f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -894,7 +894,7 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
  * acpi device handle
  *
  * @handle: acpi handle
- * @nid: NUMA Node id returned by the platform firmware
+ * @numa_info: amdgpu_numa_info structure holding numa information
  *
  * Queries the ACPI interface to fetch the corresponding NUMA Node ID for a
  * given amdgpu acpi device.
-- 
2.25.1

