Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEE7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E8510E900;
	Fri, 25 Feb 2022 18:06:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D1610E900
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1fpjiyTtaOUnqkakXLf6kHSQ5aIfgUCWJl/7z5eqjRur+NsjH+qy/6Wm5Ec3TkEZ1b2dX7jHZslfZup1x9JMfd8Tq/U3zjEcq5ocRU2L4VlqY61mC71zZJXq87tWIOFCz7zZxAhlJFTacL99fzHfet2+doO6vWBXT1SXa5WqqzAQHxK7+GijpgBA65SI8Mgr0Sc26d5LvNx5C7Nw/906SAXnNauGCHDRwStvC/584YvIjEy56N/LL2PutcmX7VY1ShYkpgJ6zaQx7zoId0IbxD6TCCbjrmd6WU28XuDQCo07G5LAzP6M6eGfIE6/ZvCqOFb9XJr9SG8ezZlVMexbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY+/DgWr1B6w25S5DNh9Fn18JEmeXSws1CjjnJ0STh8=;
 b=giILP3fiKLFtTJ+ZLHVZ0OrEGlrUzo1xMXYXaA7mntQVC9r7dMBu3TL4nCQDGFUFrCE7fo6f58SF/PIXFFdfh3uQneYxtXIe4iRZsz4QeD/KuP3w8Nh8YDDMvXt28TcAAayk2u3Rii6/kHxTIITTLD8wfbsawQPiqoY5DAlj6llKH9u0EHCOAR0TdnXgLLT5xfG5nFscnnuDCPygyNCI5aYubv2yPhF451Nu4qKNA5GwecQh2l2pzG0XpEo58/1XsTBdIGjVx9QOi5OMulN6kiyfygn/EsIQ979spi7EwGS8L4BP1ycDI4hnNJajqNeqE7fozNlXH3XVWYVCMtFWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY+/DgWr1B6w25S5DNh9Fn18JEmeXSws1CjjnJ0STh8=;
 b=inzT2b/yDgkovimt5opNYNNi48UiFA79HiEjyr8USE1dR2JI3XPwlZV3EE7wddhSS6lLp3usyQ+bTK34Uasn4mlDNi80PQHTNN6LucvFSVpqVlX7XRKxpgLcMlYRDOwlYDa5o90aLkMeolhZrxfz4CkLvzwYiqC3PdhaCkPv0kY=
Received: from BN0PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:143::27)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 18:06:35 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::aa) by BN0PR10CA0008.outlook.office365.com
 (2603:10b6:408:143::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:06:35 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:06:33 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/9] drm/amdkfd: Correct SMI event read size
Date: Fri, 25 Feb 2022 13:06:11 -0500
Message-ID: <20220225180619.21732-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225180619.21732-1-Philip.Yang@amd.com>
References: <20220225180619.21732-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c144f5-7f9a-4c8a-3df2-08d9f8898fa4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2728874E367A033BA0313052E63E9@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRIa7Tini5An5MysCEN/l4QKVpDcePyHr8HdUNvlIFJIti32kFyxGIFuUT11m6mehFeyXdMj28pgJUpArEJAaq/AYhyl6cwNbgQi5zcioOv+wc9E0Paz9fWtO6tq2tdvaOMHjwOF6mvJtGNYMLIzi+Bc/cKsPBuu9EHthzHP+QeFKW60qXCiPkong995i5iUj/JMZrxqjUDl+RIuS5AIUe4XyAtWtA/cryR3vLWbYUzdSXWQ0Pp2DUUE7tRnB/u3SkBUFUZVCZS6whDAw7fefLLlOLNopYPX1T81B7cp0DxGKu19orx37Mndh22NGvNPULEUENYitNE6191vCcDY8j/taDGAArrMXRw/vA4SOFjRIpBQHhVDSdHBoe7RejfzwP7ceOX+jSEKiFsi6eezI0k/qjuWNgTKfbhVgDQEOA6sMqKbtcTxcWaw75j39soQFmywlH1xLdhsy7kt5wHfh8DLxoqdCT0CLmdlXeeNRyyQVqaHBz/4V4/e4cfnKRl0o/Y9JH5gYfD4t2O4Va6e4yNs8wk8FM5+pVoPuRlLY2+UOWCjdT+iR4K4dRTgsGauXosyE/3RFQhmY0spQrrTPeIfN+9bcdNAdNKBkWEt9frmbsf3iTgMYUmnORuEBATI044bkpvFAfo4/bYi57ZQ+yUj5GJBD70fi8Farf1Zn8ZZeadZx1WIBrjF23E8RsNPBxdGoqes+11xMsiYVJjVDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(40460700003)(70206006)(36860700001)(54906003)(86362001)(4326008)(5660300002)(8676002)(8936002)(81166007)(356005)(316002)(6916009)(82310400004)(16526019)(6666004)(7696005)(508600001)(47076005)(26005)(1076003)(36756003)(186003)(336012)(426003)(2616005)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:35.3124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c144f5-7f9a-4c8a-3df2-08d9f8898fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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

Use KFD_SMI_EVENT_MSG_SIZE to define msg size, the same size will be
used in user space to alloc the msg receive buffer.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index f9eafc796e70..ce78bbd360da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -82,7 +82,8 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	struct kfd_smi_client *client = filep->private_data;
 	unsigned char *buf;
 
-	buf = kmalloc_array(MAX_KFIFO_SIZE, sizeof(*buf), GFP_KERNEL);
+	size = min_t(size_t, size, MAX_KFIFO_SIZE);
+	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -96,7 +97,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 		ret = -EAGAIN;
 		goto ret_err;
 	}
-	to_copy = min3(size, sizeof(buf), to_copy);
+	to_copy = min(size, to_copy);
 	ret = kfifo_out(&client->fifo, buf, to_copy);
 	spin_unlock(&client->lock);
 	if (ret <= 0) {
@@ -183,7 +184,7 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 	 * 1 byte event + 1 byte space + 8 bytes seq num +
 	 * 1 byte \n + 1 byte \0 = 12
 	 */
-	char fifo_in[12];
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
 	unsigned int event;
 
@@ -215,7 +216,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
 	 * 1 byte \0 = 37
 	 */
-	char fifo_in[37];
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
 
 	if (list_empty(&dev->smi_clients))
@@ -235,7 +236,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	/* 1 byte event + 1 byte space + 25 bytes msg + 1 byte \n +
 	 * 1 byte \0 = 29
 	 */
-	char fifo_in[29];
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
 
 	if (list_empty(&dev->smi_clients))
-- 
2.17.1

