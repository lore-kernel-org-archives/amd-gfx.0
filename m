Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06075C369D3
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5A710E995;
	Fri, 25 Apr 2025 18:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BM5uh1Z2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7084210E98F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhtGrYNRKc4EHkSPzJn7as3/s5YUpwhN1a6d/ZywWAk/gvh+4bXqKqkT0iPbocZ93rouOJnNAtnNc6j8RXZL4Gs8/VI4XzhUfjhNthB2O+n9wbB3jJ7XA/FfA57JpGAQLLi+7ieXozndpBIspNGzli1yWQBr3Da3PMxmafJShSFZZZxpnOjuhdYEv+vlgOpf3ZAbYfHrbz+xR3iV1mM6pEhVkFmCzOYh4iJjSx2zwvgyGopK2Xl0akG9TPOjvnyeLENdPxWtbTTT/PzKGoFRY2hcTghym8gJu8W9HRUXLx4iuvoKHR42TDw3ptwicL4FgwFvY1wJdbBJFpYxw2iKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAMAz7CmXyTlfolXrYHF0v4wny9z4TVoIQ0m42sTK5E=;
 b=K7HDpNY9azyyZM4+CdDB3YMD4tYTEw0g48f/d6MlwjrUyGkn4r1kstr1xiDLncLgSbKznBno6OBQUWzcsaRl6VYPU8EUX2zL8rQ19vxANBWQ/tQrRjxHhsmRtn3aGFzDgj1KSZztFxVpNknNd26l5QMt5t0FQ/M5NdtP9h34gErwY335DL38wBTznUMR+nQ8n0IRf1j9sx775CpDpNJv6CVwMO63izfj8LfxHUDtAIo+TiehlWCDhpi2UZyxFbnCUVEKTxPkVMa9uitluV5A7l6kpQXJK6KIPHuwW/BplZjBsB5/J6Asuy/OF2oxdhfdnDujTg3MoiQA4/MOSVOOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAMAz7CmXyTlfolXrYHF0v4wny9z4TVoIQ0m42sTK5E=;
 b=BM5uh1Z2ZJ2IAV9VQUR9NsAg4RQoSNDG0dZ6ex8dHSD/+QqCTMKFPkrtm6FutkRuqaNadCo0dISPAUsCYOdqUsBH2PINdNKbvjZk3Ox7PqUv9It/Qc1zGjMt1iT1EOqhxDhPkArMKQRQo7QoQFDhFtVXXtB42wEZgF9vm9IKfrM=
Received: from DM6PR11CA0038.namprd11.prod.outlook.com (2603:10b6:5:14c::15)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Fri, 25 Apr
 2025 18:41:46 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::a9) by DM6PR11CA0038.outlook.office365.com
 (2603:10b6:5:14c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 18:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:41:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:41:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/8] drm/amdgpu/userq/mes: implement set gang submit
Date: Fri, 25 Apr 2025 14:41:24 -0400
Message-ID: <20250425184125.166270-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425184125.166270-1-alexander.deucher@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9e3b3f-b9a3-48e4-26a2-08dd8428d4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QHFCxEtqimAr6UJt2CGnpAY/HwFS7i5CidYHxQzPgt63RPzntpFi31FK9+H+?=
 =?us-ascii?Q?Kn3zLLzTSg3MTOyeh66RZl3PMxQlQW9qrJd6MzC5j3y//Etv8LnKMecH8BD3?=
 =?us-ascii?Q?vvv7uygHrRFL9s2+NCX1RPs5cBpUzm4udCrZwDV0loQQEAslhjzJMCKswrlW?=
 =?us-ascii?Q?N50IsDqW5CmYXSB37oNqPJCa1wXWBxI0TkrL3Mri4JXPfZRzzliTpiWPCTMg?=
 =?us-ascii?Q?NaQiMcbDC6wTbdH5nhbYnQ9GWiO280iTnE/5CVm63hfRpj8+xwNxMdJU5GJh?=
 =?us-ascii?Q?Prx6EVagn7+5QoeSx9jtfQPvb1h0u9RHfZkBfh+sWf8Kc1FbSt33dL3WIysR?=
 =?us-ascii?Q?adI4mpIdT4Ql+jzwndeUjmANOPqOciXNnV6pB+k4K5IMcfG23Wqm6vQ0UIHX?=
 =?us-ascii?Q?AjgMEQ8wXC7ecRxH7vF1rtYQKtWMR4VvMv+sNbFWuBvMX3aRsg+8+w1TRjzG?=
 =?us-ascii?Q?a7/nNrjgSvqj+Cfpgu9KjDUCbF7ajOBKxObgR9r1ujH1uPsHIGD/cz0w+0aC?=
 =?us-ascii?Q?BNzzt4fcls1KWrOfY50bzBPivi2FnVDbjPc5GXhUNvqaZy5cX0+sy+Opsw7x?=
 =?us-ascii?Q?koHal8Fml+ovE3HIagKOq5kU/iBIx9bfGn0hEwUYEpemwLaKd8Um+5bRINDr?=
 =?us-ascii?Q?bBwJY0ouHOEdnzBrlFTRDjTXSyEDLmWuD4H17mObUaTdd6C9bXDN3u60y2op?=
 =?us-ascii?Q?TxwYvqRCOxVqaz2Z38L2I465HSsYBxWOL9aSudXrZ/COnxIyEgFtEg4n7+5D?=
 =?us-ascii?Q?wC1iRab0PeTDTHCLTTfT7iWAP6Jz6fLcbl7c51hejBmtDL6emTZKLATMs/ry?=
 =?us-ascii?Q?5/LUjG/hXXcX1ytJzn5tf06SVtoH7W3D0ADaYu2HZQS5jfnfsb5D6m1Etn5y?=
 =?us-ascii?Q?gQmQz+x6IGA1F8dPE0uUg3uoSmVfpo1n0hg1LdeHxBqU1mt3CPFdnCfzTXtE?=
 =?us-ascii?Q?9tJJjb+aPP61QBJu6I8DGIj99UP97SnGX/bZKxarOlnP/WhzMLM5rwPXHNmZ?=
 =?us-ascii?Q?YbV220ym4s1Q6uwpgt7nbjFW2IrNtvOKSGju8ddM/266PMl5iD98QZ2I6KOM?=
 =?us-ascii?Q?E3ScTxfUXUBontxi+xqfhP2PFqHZRLPR78qLkk7S1jllNFZ5UZ9zGDeMJGid?=
 =?us-ascii?Q?ywsxsSqxWVKae3cATGYh2eRzba4m0KF2c/oG7cGkbNSbD//g7bPDRLYIgQNk?=
 =?us-ascii?Q?m2n4gMERhFfW1CbmlkLo8P6LsGWwN1jjGZyncLMxOP9O1nw918bkV0CiErdu?=
 =?us-ascii?Q?PtavuLojcufeoGT4bcXsxc26b1xM8s/0JEL042PeN79uGOjfTrKDwBoSy6cd?=
 =?us-ascii?Q?NP4huyMbDr0HS130wrd2BEGM3lYAD6AJcW91LagcYoYCXKPu8aHe/t+3fiI1?=
 =?us-ascii?Q?ti5wcTmMUNVZ8t4Vv5SxG++ujLe1coQ9ILquzzHsmSOaDbje4U16zbxor10O?=
 =?us-ascii?Q?O8HCbO1ozRlKPWnkgaB2WKlMMh7HBbbNYHnJ3oHeXu3f1hfTFM6dZVJtcwVG?=
 =?us-ascii?Q?Gc8i/2ihbQRqWz3QqdJIBdN1M7sRX6cQhiif?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:41:45.8855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9e3b3f-b9a3-48e4-26a2-08dd8428d4c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
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

Enable the userq callback for setting up gang submission.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 650fdb68db127..98d08bda5dbc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -367,10 +367,36 @@ static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
+static int mes_set_gang(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *primary_queue,
+			struct amdgpu_usermode_queue *secondary_queue)
+{
+	struct amdgpu_userq_obj *primary_ctx = &primary_queue->fw_obj;
+	struct amdgpu_userq_obj *secondary_ctx = &secondary_queue->fw_obj;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_set_gang_submit_input input;
+	int r;
+
+	memset(&input, 0x0, sizeof(struct mes_set_gang_submit_input));
+
+	input.primary_gang_context_addr =
+		primary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	input.secondary_gang_context_addr =
+		secondary_ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->set_gang_submit(&adev->mes, &input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to set gang submit, err (%d)\n", r);
+	return r;
+}
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
 	.reset = mes_userq_reset,
+	.set_gang = mes_set_gang,
 };
-- 
2.49.0

