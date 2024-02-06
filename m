Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A609C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC621112717;
	Tue,  6 Feb 2024 15:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="srUYdrvp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DE810FC5E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ1alXQXrt2pT79uxbI+3l69/l0MHXv6AJ64RTLpmM4g8G44JIHUD8wfnE+u7J7n00+XS4ViN0M3M+2rl0D/u9TXZHOIUiNMBwscFqaOClHWzppETVW+FNXmUllN+uddHA4FcaS85LBNfuLxoGTBvh1iSD6NS3Jkd0Zxu1BQMfmKmkK9GwMJFGvoUAU+sDK9vy8E5TcmgPsqvIEewuJmTQMzq0rRAvHnd3RspNr3hXNDD+tXjeAEzKnKc0AtEfYPHF2XO6DyjzWFB7LM1nt3d66UHi1tnVOibCc0hHuuMBxVRS98YQoutK46ft5oe9TlkP/YvmchGLWjXPzPU5OCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zac8FbfW3/wzZdtzRJ8l/aZJr4iomuKGuo0F3yRIXkQ=;
 b=Tn2nO5ya5xT7R/GEYEV9UrawCJ/px563GlLIjBR9G8n+M3PUtmeqyMusBZgInKcTAN0bb8Fpvr1G2wU5HUrW1dix/JfOpQSFeFZ+jOBc02heS4xI1tbeTPErP+2s7p4IPk92K6f1Skhg5t3qe8cH1nHNo1W5Xw81ZXLyP8i7Fa6uL4GnpKeDf1IDlReWoeLf/ttEo7XHUY58kzOMRnmhycJG/TS5BioTyRWYS/u3lbrFpgUH6Ww8wz2VxCmHbqRd1H3ZIh0QZmU9hOBfekdA8z6aU2nrrqwcIXOCJik7VX4TfK2cYjm9SfBrRw/sCYr5hWnJCvr2Vb59MHO3Ekorsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zac8FbfW3/wzZdtzRJ8l/aZJr4iomuKGuo0F3yRIXkQ=;
 b=srUYdrvp1o9FEdEBWzzLKLvhNa6mNFuCTg2PozZPha/ge3tWwaByE80NUKzHio239+hzO6pCf7u+G13jj9eBji/5lJiP/X8S34ig7ZtYLjtq5JcuMWHWln4CyKptwowdPrVB/U03q0f6QIU0g27/pumivcRw9XRwKXTd6qRgsMQ=
Received: from BY3PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:217::8)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 15:59:39 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::9e) by BY3PR04CA0003.outlook.office365.com
 (2603:10b6:a03:217::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:39 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:35 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 08/24] drm/amdkfd: enable pc sampling destroy
Date: Tue, 6 Feb 2024 10:59:04 -0500
Message-ID: <20240206155920.3171418-9-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: c5767639-6a7c-47f7-44ca-08dc272c9ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMpclEEcXOlyX2L0WBxrGTxiO70E78Ftu3BsNtynzAFCVL/NyalnwSvm4+yc3dvqsGKxualPpmfPvFpC1131LjJrUbDMBQI9YSw2L0XChSLNr/C3gl+YEMnBxKHhuG/dxJvLO9tTnUVuMweB8SS8q6D0yTKIAGUsCWvq9RhdeUtLYPjNIvrKprviXcEWA+HIIiwTbrn9/wlyz/lz+kYVW/2HEYnUVWDV1X3JlmUNYyDu9WI8y4ZQ1C54dDDQM7rl3NA/NiN6ge/gf1ay+g8hN8pW4leqtBZ+c9IQFN4FFnTuusedKYscOm6rYHasaakvMe501WV6q8S6lyD3VkTajO66qUb7Mcfi82MmO3jYNYKJmn6l/rRFGx+8rhLg/DogyyldKx39L3/OShby1kX7vMwfyobJRP9e5iPFQ5yL27L2sfC/iEBP7JR8pCUyZSnoITuzECUlaxKqz5J8YjQ/tTvVCZxQIto/CqdE49Thj2a2P31SSkYF/iqipk9HdpBdj7Xv/4WXMq2jqNM6FUSVEatoIalb39F6Oi+s9VsfGRESIkMbxEmMAWwmnOnhZP9xwMvrbyh/bVuYB+IqnNzDKfxkxwogMZuBRFp8ly28sVBNxAu7hkqMV1WFZZxyTgchQxp6kQdl8pht4D3MD9ZoyLT5wVIeGxHKl4Ylq3YTWxOqu+w0BHmgCQqFDsk1ZH5paosf8aDy0sumHm2J2YJMhQH+z8QVCRaL4giH1xZo7LJVp2Lf88y5ZhHbJVMNKM9s5erj5EvpcHC/UxvXmWtj5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(2616005)(36756003)(7696005)(1076003)(6666004)(41300700001)(86362001)(82740400003)(81166007)(83380400001)(426003)(26005)(16526019)(36860700001)(356005)(336012)(47076005)(478600001)(70206006)(8676002)(8936002)(4326008)(2906002)(5660300002)(54906003)(70586007)(316002)(6916009)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:39.3860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5767639-6a7c-47f7-44ca-08dc272c9ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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

Enable pc sampling destroy.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 72c66d4bd24f..b46caa52fbe8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -186,10 +186,24 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id)
+static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	pr_debug("free pcs_entry = %p, trace_id = 0x%x on gpu 0x%x",
+		pcs_entry, trace_id, pdd->dev->id);
+
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	pdd->dev->pcs_data.hosttrap_entry.base.use_count--;
+	idr_remove(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, trace_id);
 
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
+		memset(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info, 0x0,
+			sizeof(struct kfd_pc_sample_info));
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	kfree(pcs_entry);
+
+	return 0;
 }
 
 int kfd_pc_sample(struct kfd_process_device *pdd,
@@ -224,7 +238,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (pcs_entry->enabled)
 			return -EBUSY;
 		else
-			return kfd_pc_sample_destroy(pdd, args->trace_id);
+			return kfd_pc_sample_destroy(pdd, args->trace_id, pcs_entry);
 
 	case KFD_IOCTL_PCS_OP_START:
 		if (pcs_entry->enabled)
-- 
2.25.1

