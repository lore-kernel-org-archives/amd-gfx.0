Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A5C5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309A810E3C9;
	Tue, 27 Aug 2024 17:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hKoP0iBd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B0410E3C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 17:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qfa4lcHZmfircNSXYqYJMdozLZ1jD03D/+vEh0qzr99xvHfmbzdQAOgzXrNCgt/4xOwkvgT3diH/SZT394OBsyCs7bSECKH4HG3CW1FKNj2+qefJXWEW/GS26GJBLgvGMnj0Hfs02TPYqogJ2WqzcvQeL4V42Jx/3sLGXu+45uAFpcjYqIaB3EFZWqnYtVAp7JEXLEVkKh58ig1O+EPhpcmUqPiwAPaUZoURlF9h8IK1JwLSpfLYZSxkRil9dZc0lUSg/ItPolwdCNKy/YVWDkUG9VQb1n7OhBR3atsSjYenBFajkjIYWE0BVqciCtwBcCCWcOIchyZF9svMCVoiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImnxtrA7hwMNwjwJSrwH+kFQAIxRK8uV1WZFx5Rlzp8=;
 b=j6ue5XPWG5xv2M1VEWoK5TdGcvqwlKcRPfvY2pvuselLFIcMafkhnLr5C1CJdzirNUsuOktGBP9NqkJXfWl0ibRy5JLSjqIe2/AwTn1p/sELy9P0ljKrf3ZKmQbJ1a7iCz77bWEMp6B0zr5kTwkiCbfKHiqRdwH0aIdRrlKuZUdEiWvLp82rZyZ4HwOxgdLPUhPiNE/b0try1eLvUEo7+ZUrvkIC1jcCeYsYgynQ/YI+XqWFaQw0wnBdUHrgwmWNmcgzH1/nc4fBJ5xtuM3IvP6lQupWcAJaVaH3qzCVrVXU9aCD4Cc4LnDr/uQuyQTEooHm5Byd0rsS3LK5vVrl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImnxtrA7hwMNwjwJSrwH+kFQAIxRK8uV1WZFx5Rlzp8=;
 b=hKoP0iBdwE5P56Svb7RT0rC3rz+wTvvwy69k1BWzM/9J4XfOMuKV58ZFfGomhg9jbDVYPBhJ1vTrLBwtcoS+BCHXWIfFe0yzYH4922S25RwcwITb6BNC2yqAVIBTAzun+QNeBFHnT+7zh9zC4Rqik6oQA+tk8ZtCjOn8UkXEqS0=
Received: from BY5PR20CA0007.namprd20.prod.outlook.com (2603:10b6:a03:1f4::20)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:11:30 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::ce) by BY5PR20CA0007.outlook.office365.com
 (2603:10b6:a03:1f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 17:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:11:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 12:11:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jamesz@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v3 3/4] drm/amdkfd: Increase SMI event fifo size
Date: Tue, 27 Aug 2024 13:10:24 -0400
Message-ID: <20240827171027.12910-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240827171027.12910-1-Philip.Yang@amd.com>
References: <20240827171027.12910-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 5448ef6b-2c72-4510-2c5b-08dcc6bb4b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n8ef+4UlZ9aD6zzHVtQNR+DnGa9rPIF6gZ0C6XgiR1ChFKTsCJKpBEJiHlom?=
 =?us-ascii?Q?PiD6cT4dsty4vLioBFhNtT1298SScpaH7Sm1/QJ0Yc+MsKuU4IiSuXwkWZ2U?=
 =?us-ascii?Q?3y+v8oIPSBSsFXD9SEM5LDXxH/NLSh8ym3kCTxYh+CwIgFclqS48NNcrtoLp?=
 =?us-ascii?Q?0gfyyjOKc03WrFKmgeDN41pZPOg1+IvcW3FG2AHbeXtyjUgpf3PlV0Iv/cPV?=
 =?us-ascii?Q?vlb7nlXFSfuXGYKjSsimHMaPFUoLmn7buxg9uw0hC2Nt/tfKcBPxVwmY1Wy/?=
 =?us-ascii?Q?MfMCgOH9SHgmPQ7pXtNYARl4MXItn4jfiEUeEARWV7eaeNYshTevqN/3w8Hi?=
 =?us-ascii?Q?kNU71xwQ5rb+w3aTSjHXacFCCDXpl1Vpb1JenPqJSZzJfwyvTtKALd9xob1P?=
 =?us-ascii?Q?AV+xwXNjwQn27GQUiKgL5l+L9midIllUrHuITbTmiEZkubBI+ctmlKQqNzyw?=
 =?us-ascii?Q?4dz8/8dcBiVkmC/xNgfNwRdAH3vdGd6cpRYoiGgRMP/cTG/dskuszf8OjJ9e?=
 =?us-ascii?Q?MpxytEBGixFTxoNb1okOUNIkYiG7WzvhuJdCXdkOrBo578nSZERA/ij4YUq4?=
 =?us-ascii?Q?uRhGP2hIXuki1VFFUyfotxZ6OeL3m1n8AnR5kWyoCCjvP1MuAexB9QIoFup4?=
 =?us-ascii?Q?qYQpilzTVcb8hTNCadSXIrREthJnN+xWZ1FufdoLOQQuAEXwmxTmbM7rD57X?=
 =?us-ascii?Q?kMbKlg4eOqlveJLqIBXvIOC2i58NAo54oaPhbpiP8vd56LCR8/FfG950jBMA?=
 =?us-ascii?Q?ydvUzqkW0Z4yiJDOoMF7UiwLwS/P0oOXn6gug8wIURNKJ5EyLTSCveYwxWJt?=
 =?us-ascii?Q?ng/F1BOfjJRiHplRkFJ8ff2ZLWuUD+z8wRJYE0NaLe1dGE+CswY2YwPPdhaF?=
 =?us-ascii?Q?S7wjfIT/vzQdAkdtifQoC3RXBWr1KpZJfwRhCeaU/ME23497apd3epk82iBM?=
 =?us-ascii?Q?2sT/YQuHh+tIQlAfAFMpSvpRLgNdfxLkF3db/rYH7uSN9bG1YPOLhakexncv?=
 =?us-ascii?Q?MBH54prUzW+DN1/bfE2SkbVKb+Wo2pyj3t8PxKcGAB12vWzhw4aiX92MBren?=
 =?us-ascii?Q?ED+ENZZlM7cERstFCprLZLvH/T7SWTjPvknIXCkJ+vq7ow765mpQz2qYg7ch?=
 =?us-ascii?Q?Xbj2Igo6I54zqgKHQ0kLZAhy1XpDYqIE7wgSJutT0xd96AwckvpZPogMdjtY?=
 =?us-ascii?Q?qF1TSaA86dRWcadFFJFpFPEbS8tdclPxqj/rFLdb0kwnn14RpqLOP150zr/f?=
 =?us-ascii?Q?HCU4Yf0dbFIfGqVAEgNWQzRdxUqqqsV1MBYbtU2DLkqJ0Svl5aDfbBwCXJso?=
 =?us-ascii?Q?IyrxG/h1C64xTcqfVXSZhtdXiu7f6K1/wWhRskqTr+3B9jdn7h0+mSwic2OA?=
 =?us-ascii?Q?RWAz6jdQSwCynOb38BYzGfTvglGfSyMRLMMeUb1iOyBXl6jSZ5r7rm9EHKIm?=
 =?us-ascii?Q?YtVck4N3PJYw9y02h/JZ5gwO9aATMqdO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:11:30.2213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5448ef6b-2c72-4510-2c5b-08dcc6bb4b45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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

SMI event fifo size 1KB was enough to report GPU vm fault or reset
event, but could drop the more frequent SVM migration events. Increase
kfifo size to 8KB to store about 100 migrate events, less chance to drop
the migrate events if lots of migration happened in the short period of
time. Add KFD prefix to the macro name.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 1d94b445a060..9b8169761ec5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -44,7 +44,7 @@ struct kfd_smi_client {
 	bool suser;
 };
 
-#define MAX_KFIFO_SIZE	1024
+#define KFD_MAX_KFIFO_SIZE	8192
 
 static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
 static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
@@ -86,7 +86,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	struct kfd_smi_client *client = filep->private_data;
 	unsigned char *buf;
 
-	size = min_t(size_t, size, MAX_KFIFO_SIZE);
+	size = min_t(size_t, size, KFD_MAX_KFIFO_SIZE);
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -355,7 +355,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
 		return -ENOMEM;
 	INIT_LIST_HEAD(&client->list);
 
-	ret = kfifo_alloc(&client->fifo, MAX_KFIFO_SIZE, GFP_KERNEL);
+	ret = kfifo_alloc(&client->fifo, KFD_MAX_KFIFO_SIZE, GFP_KERNEL);
 	if (ret) {
 		kfree(client);
 		return ret;
-- 
2.43.2

