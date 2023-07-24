Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9128EEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA8810E2DD;
	Mon, 24 Jul 2023 19:44:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38ACB10E2DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkuKCdpIin52IN2G9+rwcJ+AmaO0RjtG50JQd11g6I6i9Z0m63MrDRC+Ysk2KA95c8QyC2zgI0hYjhgR9wI0CwQ9janyRWG+s4+xUpZ4WBSH31KPX83gFcvDpdHJgFFVEswBcqcNwvibudOaiGk7X6URo1ipPFh3g/hTt+e40llupi6m0VjJpI1IBxtmNNf82yAWSa69oiXWfOpzTm/J8HyreZQgLUYI1owDQBid7V7MfEuEcsaLegUfl2nFUMHrclTV0FX5WkW1y5sQOANBqBWhsVJ6xaZa7B4pXZFS87MiAMoonBwWmlA/3SserHAGiiBlcquYfi+IOPMe3Ebokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0tLGDGr5asB6vkAIVc7i9sOgDgdKwwQkraMPbS8htU=;
 b=jBkD/SFQey+3fvNHvZcXxvWIH14v9Gw8IwPiXVlmuyvOauHmDufDZUkyCOqb2HeekNRQWuIZ2oglY+oU/rhhewdKv4vMluOR8o8VJQefiKW0NAh8zIkeRwW1oMT8kGwx4OhTJ+jqJG+6WT/Td01GhDEW46iZntq7/mYCHfukeqAXbX25e6z4xya/jHllV95BcDibsJxBiwt8/LLDl4KlbSeHpM2kF4v6FtMAwhJs+GFvZa9+sn5bjw1lDvYCwHz9R2VHq7aiQv6mnxQMn/ggXDUbTJlEjVZ7U3aq6zewNc7g05iltGwQ8wdpOiF7oOrJfEtbNhM7Y1Sk71+4xBFlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0tLGDGr5asB6vkAIVc7i9sOgDgdKwwQkraMPbS8htU=;
 b=GurUKiPut2vgIPn44Y+9ZqqcQHTOrqc1vFgjqXUbWraiXUxGh4iWxKzBc8SDHFXX9nLwpDHydLc4TWX18DMEHCnonohgSuoKitUUKQ+T0kUBncSjdbzBArJRQxSWZtOK5CN7RxLvGBGBLpZ5CfPdnRHiVpV5/fzne/GozbytvoU=
Received: from BN1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:408:e2::21)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 19:44:04 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::93) by BN1PR13CA0016.outlook.office365.com
 (2603:10b6:408:e2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Mon, 24 Jul 2023 19:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:44:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 14:44:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add smuio 14.0.0 support
Date: Mon, 24 Jul 2023 15:43:29 -0400
Message-ID: <20230724194329.763836-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: bf790c31-7455-45e8-a630-08db8c7e55ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7m2JEE4OQ5XlpRXe/L/jFvi0/vRvtkpEsYz9GTObRfr8LybqBqxH906GIOStQT7WGDe57Zyef2p+4I0JvDUoKINix4jpbxZeSQKYJn8h2Kbjo75iG4SO8eTegghy5sGIt3D7vw09JPmcN/Cz9ibg6FQK1fgmoExEP+rmi5JJgzDwu0tgY0Qn0m4PnN6BLptRP1Y9YYD25U7ovQ1H406XWwAgmH7bmJX8VXqyO7HHeuA43RQRjfUCpcINR6OCa/Yjw0iVMfbW9qc5Mlrh6WK1Do5EDBMiLHcP/xGxojpSClzBDr0FTjOBO+IDxZ2X5E0qD4N+RJ/nMSxXnwsQIyeYNuDb4CS/y0wcQdj9e7Fr7dzu27YuL3bRNd6Sl+nSbjJx9dckY7yRKKYlA9eYIf8G9BTbW+yUTk8uHqWPLxSEED+qtwlwANroQytS2tQMo26LB37D5zkf3tekkcTfkHL0V8m5Sscncav02qVHXt9Yy3TTQtkSjmbpMKGW+zAWXhNWeYv4kUqLBhhGewP8J0FPAtaVFu0nWdC6WI2ISrQCQhq8Bt/ZzxI4EJf9/6mzs9T7cEmX392GdrjjiVN3KbenhAvrOMZxmxazZRofYwZSNZNv/lIVrhXKh2iafHHPLUoPzF+etSu6KDb2ar1qrB63qA4pfOb2BjyOfkOr7VPyqdX+AhdpCXK04Jga0gv63LVefgdVpRVss5FLkTxHaXb+jCUHJtNRCtJRjxfKe9wKqk+jYChxVqHGPrzJDtwf0TL5WRPOVExR7nrbACmdn0BhTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(26005)(186003)(336012)(40460700003)(1076003)(41300700001)(16526019)(478600001)(356005)(81166007)(86362001)(70206006)(36756003)(70586007)(6916009)(4326008)(316002)(82740400003)(40480700001)(7696005)(6666004)(54906003)(426003)(5660300002)(36860700001)(4744005)(2906002)(8676002)(8936002)(83380400001)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:44:03.9173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf790c31-7455-45e8-a630-08db8c7e55ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add to IP discovery table.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 13686f194d104..f2b95c38ac3d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2508,6 +2508,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 8):
+	case IP_VERSION(14, 0, 0):
 		adev->smuio.funcs = &smuio_v13_0_6_funcs;
 		break;
 	default:
-- 
2.41.0

