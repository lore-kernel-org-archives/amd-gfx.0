Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FFBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8913310E20A;
	Fri, 14 Jan 2022 20:33:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E584D10E207
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTYBcfAFeCk/Yw33kkOaqAw/BEhO7JF7OtsQXPQe/T93WWNU4WpWf23JIT5zr2BkojeIjmOn53d9+zk1OhGsChIR9xKDaaiYYAyGtp24z57n9cv2NTLSnPeG8Fnr210Uyt1s3+u76uEUouHm26SvXtWucvNrK9qzwB3lCIT0cGL5w1m6P/6A8h4CJm964lPimmBHJzAAIvtvlAcZq6ZhbjjLsIRQa5CVIFbrtNleb72aGGHQdVhmiC9IpEE1H9zEgyrdKVI+lC3+WuSSHzgM7FNDp93Y65/EUGh5bAS8+kC7iPzzct8gKWmNfghWIXidPepol+t4mWGjMPpRFJ7Igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0edJ8uUkfwuUr6oUNLu3Ln5mf9T6yxtoewq3XupaO8k=;
 b=HWQJLjGg7naZjuCUYczve53Rj2AcNzWAtBxOUTjqZMJyeqjSOAkTIqj7fHu0eHwed7ZEK6UqrIqam3PgQSl5Ivl/UWFlo7rUpunknI1zCkvKyH8FUC1SJtBBn3G6qkdEr4SgeQDXChuJG5ZHhVkFpUdZ17F6YtjY1mBQ03WO+Mlk3Hvc6ZgEW0EKZHKvUSuA0NRHoCTKu5JskRQLvyc+O7TkHw9LxtWF/6Wg4TyYLTEB7CpL0UFj8yMpx9Lb9okoFFDULAfQ504yfOhH9O0VEJvwZhsX+G3PsLw0Cqaei68GNak7VUCmyPkAIu6Of681mwEQPoay4cA5vbvjRVzJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0edJ8uUkfwuUr6oUNLu3Ln5mf9T6yxtoewq3XupaO8k=;
 b=sxoAXlLXtHT9GIBL8GhdykYMwD+F00Lkj7GPzImU3qZRrR2649weixBAYjXgfsnBb2KSEyncxwVPtuhBADjGY/acUp7nedz3u3IMdLJdLRrzDD0A8B6JTdLDT88gJ3226WCnD0pae5O1Pxfnz8ehpUcKGfRKQZC+3jH1qLJqa6A=
Received: from BN9PR03CA0848.namprd03.prod.outlook.com (2603:10b6:408:13d::13)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 20:33:22 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::5e) by BN9PR03CA0848.outlook.office365.com
 (2603:10b6:408:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 20:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:33:22 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:33:13 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdkfd: correct SMI event read size
Date: Fri, 14 Jan 2022 15:32:53 -0500
Message-ID: <20220114203256.19821-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220114203256.19821-1-Philip.Yang@amd.com>
References: <20220114203256.19821-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5e69883-ae80-461b-b2b1-08d9d79d1baf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41927BE931D17452C3EA1DEAE6549@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQCtEP1vi4KbXIxeuW23xDxztEe7pHM0qM9v+Bi2/hE6vvFSvQSukFj5OHPT7bGv2ulDOctDI49MJ+Sfgrps+RQKBGehqmZ4f+iNs4HsSEPIoTsv15fgWCZoe3szuoN1t2vQjWjv8sQrEis1kICBXyuq2iLG5nJDzD86UVTlq7gyN7z+N2NSlJxLPBLBKe/7HbgEZs2WFejNbZPW0avlMIpZQPZgRQBGC0BLOAMpFGBpodca44nXxHiau+KQN0w6uX7oroO1fVgla3wcpEPKgiLYnW9ACkWirSmzX2jO+HOOTgoX9zeQ2x2eehgwZT5+EJWlHnQj0kKf4DOMrgDvoUgpImVvGiIAI4cxfd9qaJhDYUaNJp/XA01TdtCPzT3NOLS802mWvqyRaDI4P+L6kuPP2oXnbr1CMULfmw3oT2SCGJwTa7GZLWWL5B5wJxIKtS/N/A7WcutopDFex7IRDU4cwhm7OnBBrrnk42zxRil1f//nf+4sGkDjpbY2bcomGanlEt2dpNpox6uhtF+c8LoMtNdcBPD9neMsQymL+YUEB1vkeeWdlf0KWHuczsHlvdri2Ot+njzYreWAgaIqLeN+5ihaBZuOqkjHkKHQC8hEbB4la1bCW1xpWFY12sFcoogBsOrmei6qUyE78rPEO4GP+7yD6LChNFaCtW06cm1OP7x0SKjaaM0EbJZHBbHQurgK6oxqeOb7vUyqqfBlcHOk1hsQ0MbbwjF9Z9oLFYx2dP6EPZcMVJGfc3T2vdi2RR8TCscf2di03iWCeK/RM/ZsxsVxySPrHklec82Eql0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(36860700001)(40460700001)(186003)(6666004)(2616005)(16526019)(7696005)(2906002)(5660300002)(508600001)(82310400004)(26005)(426003)(83380400001)(86362001)(1076003)(8676002)(70206006)(6916009)(8936002)(36756003)(70586007)(4326008)(54906003)(316002)(356005)(81166007)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:33:22.3503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e69883-ae80-461b-b2b1-08d9d79d1baf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sizeof(buf) is 8 bytes because it is defined as unsigned char *buf,
each SMI event read only copy max 8 bytes to user buffer. Correct this
by using the buf allocate size.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 329a4c89f1e6..7023fa21a0a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -81,7 +81,8 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	struct kfd_smi_client *client = filep->private_data;
 	unsigned char *buf;
 
-	buf = kmalloc_array(MAX_KFIFO_SIZE, sizeof(*buf), GFP_KERNEL);
+	size = min(size, (size_t)MAX_KFIFO_SIZE);
+	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -95,7 +96,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 		ret = -EAGAIN;
 		goto ret_err;
 	}
-	to_copy = min3(size, sizeof(buf), to_copy);
+	to_copy = min(size, to_copy);
 	ret = kfifo_out(&client->fifo, buf, to_copy);
 	spin_unlock(&client->lock);
 	if (ret <= 0) {
-- 
2.17.1

