Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E141C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E9C10E228;
	Fri, 14 Jan 2022 20:39:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0653210E221
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edMd+2wfH6/xSRcMDaEIxdCNLTxrfbbJOXAkMyG2AwKuxABB1/zH4lqy+X96/PqwO69s/WkRT9zolBh5BzDSxA8dixGa0lV0zMSVQbIk8TcgXYdQ7rbypuH1Wiy4T0zHvw56NVUQ7YC5n/mlP5emHbMZNlo49pbUIYRXVBcOtqxF4Nn/nwZKWhlAAhI609pHzisBepQCCzdRnrT9nJQ9oeNxiNVw4Nun+0vBmnBPg8Mi42uxtqavXvoObbT1b0hjqHwf9shhhRc77O+/vPpcC53DhqUyaRn3LLHAijYFrS7HwVmYymWln6C/nDeM9NyzO0wd6W9auiV2YdWAnGkRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0edJ8uUkfwuUr6oUNLu3Ln5mf9T6yxtoewq3XupaO8k=;
 b=mspZbPL5njOr8TV1blsHkon1y41rYvAMyOZ451yGD6luhAiDdth4hgksjxmsAlZHgXyasuQuruVz2gVvFnUhkSDqw49oHGIijNyx7pdS1DUy7Hgayqo+LarQsGycqudg+/hzN1NkF49IsKcHQl0UzRrE6kXVbSXQGAGAZ9PuvijRAlr8Ry4Lxsz8+0GlCbejmIZqndjPsHYhvdNJO8LzqX2TNpm/GRzBL1jRxo19Wql0XOBJqenMJ0oeSDHRBMwXon1DyKc+XW6ICkdZZf7NgfxK3wWsfl5v4liLP9vOVWJ9h1VMBY0+ccQ4pFYiSMcJLsojIHLeob7EpdYCbOk/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0edJ8uUkfwuUr6oUNLu3Ln5mf9T6yxtoewq3XupaO8k=;
 b=LaGkNLOb9GZiydG14n1yQ5TcvFWohxDu686S4rjLZJIJo7v6nJxZ2uE+ZlKBXjo+sJfaHQg4OdTtxcYmrE2RqYe0rUGtgZiPSAdy/iT2H9cY6T+/nLXHC24Hmyj+fvOdzqXl/gCBZIAX4BCC8nSPKCoYjT+za8mcMCTOyCPy6Ck=
Received: from DS7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::34) by
 MWHPR12MB1502.namprd12.prod.outlook.com (2603:10b6:301:10::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Fri, 14 Jan 2022 20:38:54 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::f2) by DS7P222CA0014.outlook.office365.com
 (2603:10b6:8:2e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 20:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:38:54 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:38:53 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdkfd: correct SMI event read size
Date: Fri, 14 Jan 2022 15:38:35 -0500
Message-ID: <20220114203839.21707-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220114203839.21707-1-Philip.Yang@amd.com>
References: <20220114203839.21707-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d90f45e-8975-4832-18e3-08d9d79de184
X-MS-TrafficTypeDiagnostic: MWHPR12MB1502:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1502EF68484A946259A0DF1FE6549@MWHPR12MB1502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IavZW/QFLviOI8HGXgOogiGdTiBc4te/0EgW6oC/un9Mn+D+OhpkcEdCj48xKRn6U49bvPUi6aq0jZIp3OAgkWfiE47Mce+7Ac3bg1JLxkVwOiX9Foh7Ip7fv/IPX3fqOhKzmwg+cgQqih47cdEU1SBWHMlMlnB76tsCL1lC+jnanJy89/knTL+wCRT4Sve6ZjQxA3P0GJJFd33jK2NWwEBASub0hhixYkLiis12RNLriB7cLKZZsEZlyz+H20hCWsQIp7WcUXsbxVTdJBOXgVW6G2cyYOLRGjbJ95O/wauONoiW01e1nFDMEj00DNC7ur9lvn2eV9RKBWSYyPdo7HMhMlV7TOEf3nXMvgD/Nb1F4Ngss+xOLKOYlnFaPguNeBMn5meKdXNq0IsNQ6AO1w3mJrCpQ/fB8aJUvlrk+4bvcQXg44BC2ypT+2r40Rt3D0OSCRvjquopaPLLZa2QdCFFmchhF6+WT065TSFyPe+jpLz/k4UchinSSEMY9H9qxzSgymX9xK++Tx2iRNJBz0PRc+x0hajSu1tJEFUjgwPTnOKFCdMX0tH8suukrTnz3JgYu/4TXYFWMK6MV0JuQljneqREzKHD8JFgQbw6Z75I1shoS2PKTbc4r3iu4dPx+rlhhmwgUIhO3sfgIVAillPLdutN4sbLv05FDMG09uzUkYBnabczYTaApDTKjMAzdNn74jn+2IWatDphxwHhvAweoxGArQ3NMncAda/Fy0trJqMTjwSRv3X1cQWvwLhLmvQWRLpy2qDjBiPyc01ZsgI18WPnPcdhQ17bGDPImG8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(70206006)(316002)(36860700001)(82310400004)(1076003)(70586007)(26005)(40460700001)(2616005)(54906003)(7696005)(508600001)(83380400001)(5660300002)(186003)(426003)(6666004)(4326008)(2906002)(6916009)(47076005)(336012)(81166007)(16526019)(86362001)(8936002)(356005)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:38:54.2222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d90f45e-8975-4832-18e3-08d9d79de184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1502
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

