Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32196C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 02:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C0810E29A;
	Thu, 10 Feb 2022 02:59:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F2710E251
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 02:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfolL9bZ3ar+up1aehJQR8nHwS0okdKYUARSC5+1u5dec2+mudP5wblgpfsaMTTOO2+SW9vwnFj6xU5CNPdH2Y2lhfT9xutRLoCXw1swqRc2kIWmuzFvwuw1DnmWB///30D9lx5TXHAni/STXJU7uG+OLVW8chR1WB2UDtLmrjBHQ95NExt+9oG1eHPc8VSD0mFreBz384XKVO6hdwEYAP9SBfuAFN785qS2aeODXYAvK8dcGiPZIs+U7qid+5KVrtsllyd/sUeWrJeLCnqX3oYdQgEk+pKhJu0iZlCIIFLniyCUCyM5Oy8gIN9USnTGevbXIlIEvca9KeonnxyqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1NvIEJZwdzhKDP22Fx9amKzD6rLN6PqvQdRGW8zb+o=;
 b=FlsExY2l3FNQxY9LVUvmSMIznwWkydoe65fu2jVY2orPV6MwnYSh4y/Z6VvNwJBQa+2hyBKe6YPW9ytqlzUyxhjeIE6M8r3+Zue7VzxshbVsoVF55BD9FHneEbW3lzeYiU5F3PTOAQble5lZ9Jcjpwzq7kCRkj2saxV5oPRjfSZEF1e0JipueTFZwrxX3nxWx3hKfy6p1XE5+Ucx8f/b/CiZzLiegqNBMs5qmjocePRuJ0qkIefxrtvIms0jF3EZH9kfQu5BONEjuIATCZoqoGMAxT2ppIRGhObWnsZzQVhHBQ646tg8qwNeBohxXg+W4yB762KrYJfEIuf1qirD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1NvIEJZwdzhKDP22Fx9amKzD6rLN6PqvQdRGW8zb+o=;
 b=oW6B+hNkP3MIy1TAUzeqgxcJvC309L5gbxWGoHUyGbtk3gaoCF4CC3JAFsgWI0M5gONMYkk08rByFhXU7L+/GDB0E6TTl7ArugnqvcMKv0PeNE45Ac9uhj69r/Xa8zmorn21EhPBiwNydZt2Tjahx33HqLfOu5lI/ndJ9nOnEqU=
Received: from BN9PR03CA0065.namprd03.prod.outlook.com (2603:10b6:408:fc::10)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 02:59:22 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::ed) by BN9PR03CA0065.outlook.office365.com
 (2603:10b6:408:fc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 02:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 02:59:22 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 20:59:19 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration
Date: Wed, 9 Feb 2022 20:59:02 -0600
Message-ID: <20220210025902.32514-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79bc056c-c385-4b6b-b2d3-08d9ec4156d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4074:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4074A66EAA8D4ADDDF788BBFFD2F9@DM6PR12MB4074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnixe5yWThKkhci18HQY+ME4m0txdi1jP0XryGyWDeYjTnNg5OltKuLovYYQxsmu+3YtJ1hbk0+vMFKkXpZB7ovUqeH5rDohvHL4xjBT3AyEDUaCTcHCukXbPWCnmxSlKD4kgJCZkaKth9PdPL5/caa8x0w/AwragoG2wcQnkUZ5R6UyYZfRjSkJ8tMWA6kDk20uUVeFan0x+zE5e7ohKghriFFmb51AxdGBjjzgD4C/uaWdXu9BNh+Jpg60zMyk2iSRPI5uiWGP6tZSCCyec7xqP8rKoTmqBsMRBf1Cvextzmrt6Clq45waCk4E7p3KLkul7IHRoRncwS68Hmiq+5sBlh6joMNCneisoReoXhEHX9jJNd4qwkYJvxVd5LLP7bkAz8Kz6BotrPu1XZcWhuVUamCFz/IJh1Yf1lZaSv+oGbwlaAnqL8Ls26XX2bk2cg75DIYFgyOahlw5vwUR+rydbklkxqg99rufQKp9f3FtJb6S+pGdQ69OHJaeHLo8x5nhLXQVD9VYJ0tZ7hIusi106+5nSTTwLenCxfk0LlFegJP1BWu3tEfXMUYxlbPgsVd19ufhfnq2ZoNp2K5qjhxm7qiNDWwrmiMGWnHTdo0n0dAsZrIgth/LpPJs+Li5ebZ/OgBqVWtT4lnNpNvGOMLACADV8PQ8KJk4ohQD1HOyFYtPfDekJVjoD3ROBvgVdHGaoPw1gipsTWYigWD8kQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(70206006)(40460700003)(5660300002)(4326008)(8676002)(4744005)(47076005)(36860700001)(44832011)(356005)(36756003)(336012)(426003)(2616005)(26005)(186003)(16526019)(1076003)(7696005)(316002)(508600001)(82310400004)(2906002)(8936002)(81166007)(86362001)(83380400001)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 02:59:22.2991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bc056c-c385-4b6b-b2d3-08d9ec4156d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid spam the kernel log on application memory allocation failures.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 88db82b3d443..f40092a17af8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -312,7 +312,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		dev_err(adev->dev, "fail %d to alloc vram\n", r);
+		pr_debug("fail %d to alloc vram\n", r);
 		goto out;
 	}
 
-- 
2.32.0

