Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2F5C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 22:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E2D10E36A;
	Wed, 20 Mar 2024 22:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LewLjcDD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E435610ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 22:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2U2IHFS8mm0aleo4kn6TuP1v0s3sD7pOK97KKrqLN54ocWrVl2kUxCjsIv29hHDKrbpekU/4f3G/LNSnEzDlv4vaFVwiYaYV4+eOBya9Ij9ijtLX3LEXKJ4pPkG/b3yaWGFQcNO+kg3nndk9kCrHlo5W9Ga2O7M46YlpQysJTnfuaoz4W+s7jR0+ijhF7eZ2sbfGc6GTyc9wh/AG+7q6oRU+4QR+AJ9qMUyFOGZwlsSs/Q5jFTsPSE1QIlU9f2Ldh+i6iqWd22lpTTlUK1h+Nj9tl5kB3Kg1TOMMRYZLlx0uiD8Uo7IiLA5mix6rnOc8+hUG1esFXmcbQ/RpaclMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2ojJRLh94iNNKupBmIFatSUIG76tWI1vd7ASf27W6g=;
 b=KOn8dUvPiAcuXVUyQA8mv2SRfx2ZipV56dPeVEITs2/0+11nFJ6oqHUDXPsCaPRE7GBV1+noYN+srZBz4umeDddpTcoZtB0qvKK1Mxup1ugQDV3I2EbbmVg740mH4eaEPV5HviohBIwCckShc7/NnSCsZWq/uW/5ZbuKKKcl0kK9xZe1voL9Qv0biPUfkgiLDM4tuhuJJyHXZgnJHQpl1j6iqNnGHHPr15fhcL/WPTLeLWyMt6/a0go3tISNGYYt60Zcb2Q4FzDPSTVbav78dsKmDqSYxBx2mbMbNA7olBUCePspd4f9tq4FTJoensO+zyMzmuXEoKgnrVXGEZv22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2ojJRLh94iNNKupBmIFatSUIG76tWI1vd7ASf27W6g=;
 b=LewLjcDDrJFaUcIhFj0oo09wn0qiEqS5g2ZToYQ+7KAcFJ5a3m/RU8sGfnjdBepo/s9277u10SiKHWevFAGvk47s0ZEtJce6Kv7CUza3wscPS9p5ucEkkmz6/XR9KKwPg+t2vDcdbTES2QiJRd59/KOlh9diFsn6cHs26GV32JM=
Received: from DM6PR07CA0069.namprd07.prod.outlook.com (2603:10b6:5:74::46) by
 PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.27; Wed, 20 Mar 2024 22:53:00 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::6f) by DM6PR07CA0069.outlook.office365.com
 (2603:10b6:5:74::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 22:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 22:53:00 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 17:52:59 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: Cleanup workqueue during module unload
Date: Wed, 20 Mar 2024 18:52:48 -0400
Message-ID: <20240320225248.754671-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: de2a52b3-d5ef-42ad-6869-08dc49307e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NidbK+SoG8nbxsSOzS7MhhRBHSRj5U7iiBLyZYaIEKQn+i34UDUKIAZpD7pZB4YB0wRgwZKhJTQX5W6ruM1k+YVcbo5jjzzyOSiPP1pzhGQxbIFGUkwZQuSJOGGdExaFX8K7WGMxyJs/Rul6rylraJl46nWzPk99zTrW/upzmAlGcg4rWfZGu+Z6vdwht7Enf9SYYK4Wzf/VyBfPtPuAja+vCU89ZAAtZH6FjcaG31xpbURLW148H0mnGjqYQiJLW9Z4X5g16PM9yzFmZ+H/Z7wLX802deFKdZ/uhVLN4ADQpG/BLm0SJZQ3Iq+Wrmi0qmkViicGVuBBgOA+1uqMgZtMcptCrZs0ShVZ/gwb/hiA0T7zajsXWn5N9Cz15rB6m5hCXWZihNxZ4TNbCer+JgRQn+CXySD5bV0fJtuII/mHd+HXZTJd/weKr0fbaBalunnCfFZAWOKhalwMC3ZKQwiDL0eTXDip0L4DUMsGTPfqxcc0fZykezTvOOjRn0HSYFJ/+2jSR5wRXHQKQ+qbdd8+ZqMC/alxLf/6SK/e7ca2zfqDzy33DE/iZQX0x7AEnZ32V9a+tBKI92arCyyloQiX7TryTlM1Ab1GyNoq7jknpstrt4uAWi18IQsxK7JEYdt0da0kpfcrNmpFVT4KQFBD8RFCv9bzd7hRKw7WLfuD4TqrVhtdkGAFXVqMnVTwJZ3+3EMPqZzCspeX/0F5myhqzgeYbCNvjAL05f+8vj+dCezfgcT5ditIWqFqjUIk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 22:53:00.3149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2a52b3-d5ef-42ad-6869-08dc49307e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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

Destroy the high priority workqueue that handles interrupts
during KFD node cleanup.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index dd3c43c1ad70..9b6b6e882593 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -104,6 +104,8 @@ void kfd_interrupt_exit(struct kfd_node *node)
 	 */
 	flush_workqueue(node->ih_wq);
 
+	destroy_workqueue(node->ih_wq);
+
 	kfifo_free(&node->ih_fifo);
 }
 
-- 
2.35.1

