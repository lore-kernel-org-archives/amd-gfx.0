Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B59C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 04:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A1510E15C;
	Fri, 11 Feb 2022 04:30:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A145A10E15C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 04:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSAgnsJbpoX+GPxe2iYT3AkA8UAoe1gHna5K59piZ5retVt/+QtI9MgWI+wYikluUCLgAdj39ER6HI3g4ceqpeJwzzO3UeZ501/+grb9wW8R5FYadh/MZNZ3NBPCc6jfJPeYd6uCHfY/TKSMQeLT7Qtkgl6gIYBNd2UGpgS5GV+3retUhqcwrKPvEYP28+22+djXyA1oNRnxThr2rMmZIB0+5b1ZWjLnRckGkg21+l4yAS0FXKw1CBsz2B5Oso/WaeyTnKoHx7gKo6NJHgPIJ1w71byj3X05gRLs4uakyNPDgadW60trhMH34zIYUQu0kQ1hLGPiDUAnnNS6IRfSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Caq1UUyDLbpTB8ylXwM0V5W4Y9sPoZgs1P4Q1n59A=;
 b=TEEy5iAG2zH+GDK5UPiRagmHE5mP1zru4DO7usZt5PtidPEmT4P6sQPHjxjfXG98lCcfcT03j6DSF/yeg9rYDxfMuLR3ptbJFTsKSULShzqG5+0hdcebtHBAMROyDI1wS6dU+KzFdj5SXFvelDYsheu/oiCqU92xO4s4RAsPvXlz8XtnKIWaZm7D0NFVJ36ZuoYiuEH8tQi8RNzp2w1KwcGHI/IUwt3O8lI/WPCS8+mjWRlpNR+s/Ys1nFkQsRdqVGZbuTn0sKJkKf0A9lMNSinqR7GRfIRdZimeJ/zmu1dCirtgoFARArYbw6CadFwa6EzUg10hMvKj3YS3ug0uYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Caq1UUyDLbpTB8ylXwM0V5W4Y9sPoZgs1P4Q1n59A=;
 b=c3rY+6pp9tCLf9apgQBphWXvOm+jitmAZZS4ypqtFwI5Op4tr2H/aDiAMPOCue6F4LSHIxbqIVNbzP/9Ty2m/JZDi41nucj0hOT0NbhteTrLCI1MTb1NTmpr9l3du76VJ5x5lcdo9qvk4w4u+g8yvbO7Vse5tV3KWwD2bAK0Zlo=
Received: from DM5PR10CA0002.namprd10.prod.outlook.com (2603:10b6:4:2::12) by
 BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 04:30:50 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::ed) by DM5PR10CA0002.outlook.office365.com
 (2603:10b6:4:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Fri, 11 Feb 2022 04:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 04:30:49 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 22:30:47 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: CRIU fix extra whitespace and block comment
 warnings
Date: Thu, 10 Feb 2022 23:30:34 -0500
Message-ID: <20220211043035.13284-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85134c43-57be-4625-4cfb-08d9ed174818
X-MS-TrafficTypeDiagnostic: BY5PR12MB4162:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4162E4026859DE3CB993862BFE309@BY5PR12MB4162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nAiZn5BBps6v5kJFj5EJ0mu7/vMFCo70Dnycwfv8xa+X6BOA40TL7OfdCoYSNa7I49WKVE6n3vA7m+jQbsUoh7N6oNQq4oW5pXGnkjNNBoY6HW4EVJZCkObjklTRdCq0yJnpAD3o8pBV08NeKL3jrdyoRwDSCtirPoanyeVaPrpf6tD6qMVngh5CXfKKDc2vVLKNd8J53tPlkUYhzU8cZP4vCb/LyhP7Jcx8T91jhLFBfIV0Ut3AeTRmySn7bFO0Ld7qTVf00bnviieRchmRxGw2A9bugZ9/3SohuWEFUIk/lJOApaH5Qfztrdv3hMl+OsNVnXGXefdfFsY0XA0IonUh/ZksoMEp48kSm/Cn3s7LqbSgf13/ksK1s7zKlI0cjvyvDhI3QbLxdhsoa/aNxa9Wp4BvWIYf69jeIsucNkxo6sZMW0/ZPis4F4aT/9ZPvERAAXnbvWhYxlrLdF5TijPDncneBwHZsAPRx6YX/DYLgkxtfE4UUhNmUCA7/vhybGeFzQ1O3q2jgIWCqN0n203a5rVS6fJGRCaFoHabgl2/XNkwRW3mhNIvbztR3bCMz5nSQjYmk4LHXXVqikX/Psrim0kBAC2hoclLQHQniV3vBgj3q+7XZ0jsdGjzL+pGac3E+8lBR7+XOCvqD5etUj1JN+/PeC/2HRSzucxaQjKAiqrqG+UGLmoleTpmQdXmZ7sAkwWJPcNj7Y1a75uWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(70206006)(86362001)(40460700003)(336012)(44832011)(36860700001)(7696005)(8676002)(8936002)(6666004)(83380400001)(70586007)(508600001)(4326008)(47076005)(54906003)(316002)(5660300002)(1076003)(186003)(26005)(16526019)(2906002)(2616005)(6916009)(36756003)(82310400004)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 04:30:49.8125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85134c43-57be-4625-4cfb-08d9ed174818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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
Cc: felix.kuehling@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix checkpatch reported warning for a quoted line and block line
comments.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 783826640da9..b71d47afd243 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3514,7 +3514,7 @@ int kfd_criu_resume_svm(struct kfd_process *p)
 			 i, criu_svm_md->data.start_addr, criu_svm_md->data.size);
 
 		for (j = 0; j < num_attrs; j++) {
-			pr_debug("\ncriu_svm_md[%d]->attrs[%d].type : 0x%x \ncriu_svm_md[%d]->attrs[%d].value : 0x%x\n",
+			pr_debug("\ncriu_svm_md[%d]->attrs[%d].type : 0x%x\ncriu_svm_md[%d]->attrs[%d].value : 0x%x\n",
 				 i, j, criu_svm_md->data.attrs[j].type,
 				 i, j, criu_svm_md->data.attrs[j].value);
 			switch (criu_svm_md->data.attrs[j].type) {
@@ -3601,7 +3601,8 @@ int kfd_criu_restore_svm(struct kfd_process *p,
 	num_devices = p->n_pdds;
 	/* Handle one SVM range object at a time, also the number of gpus are
 	 * assumed to be same on the restore node, checking must be done while
-	 * evaluating the topology earlier */
+	 * evaluating the topology earlier
+	 */
 
 	svm_attrs_size = sizeof(struct kfd_ioctl_svm_attribute) *
 		(nattr_common + nattr_accessibility * num_devices);
-- 
2.17.1

