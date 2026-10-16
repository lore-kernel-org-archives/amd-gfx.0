Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71572CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 13:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF306112813;
	Fri, 16 Oct 2026 13:16:26 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010068.outbound.protection.outlook.com
 [52.101.193.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DC2112810
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 13:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTPt6h4rhZESIABLOYj/KU8omcSkIDpFyHpuaRqlF2OtzHL1go3zTLENiEBNRjvXNOKWKfP2NaeMzFhny9ycffThz0I92q4x/moBpzZPeBWgUBvggbyLGvQJ5mhZtwvyCYZbeXuq1H1sSeroROrwoqh1Uxx2+FvpuLBRuRYyVZWk4E4ojbnMrQHTl1ODpe4qR3FFBHuaXD+babXNr3lm9iiW++nTgy5tWQIq/xruldoTUWg+qGdhfKF6rknX3OgeMdNsutXJW7HsumgmCuRBZtfOHLy1GvvHsOE17ORhyRxA6zMZ+n5CvmR8aHB4g812zmA3Urh5H6iTC8GQHBX+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKs/r2F46miJCNoJ3rXD095PPzvWW4yDjbR29oSxZzI=;
 b=ilr69EXcFFpC8RzQpecMQYwF758tqJ2ECtlt78k0W3z5DnB6OL9czhn8Y102cjUooz0Tc1ixdwVwrFLmgjsRFaVSlGlffCLgqrTRtRJ/ZL3s8HJ9BffxmNDhcZQqlDVGzysC74mWG4kQDS6lXBlzxjUgnmp4ZIyTpdAJU18jhxIso9ZQX0TiRQ77+ASizUMJW/LWTfB8IGyylB7Z/2Ne/2nfUQ15Ub/K4d4IWOj/I6nYiIvWjlJL0O1ZfQIfZUy/JnYB4kvANhvR1beGrW6LHsZCo0Gp/+q2WAbw4+0Y3tekK9eJOxMfKdLVQm32UJ3zqX/dJBnL2NA12OtyM8cFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKs/r2F46miJCNoJ3rXD095PPzvWW4yDjbR29oSxZzI=;
 b=sjy+CQe+M3CD8R8k3IjBjaqwidFGRmbP8RRJJpZ+5llWro1Jow14ppiVEuwRkA5h0DqyS06t0yy03M/IXxqNRJeUXPH5+mPcIr8ihFDqqdSNCtrqCFyMjzjfuFwCJpW3j2GyOPcYvkZdMqeZMcg+FioWwVmLwrSNG1SnWOQYySw=
Received: from PH7PR02CA0018.namprd02.prod.outlook.com (2603:10b6:510:33d::19)
 by CH4PR12MB078048.namprd12.prod.outlook.com (2603:10b6:610:50b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 13:16:15 +0000
Received: from PH7PEPF00000008.namprd04.prod.outlook.com
 (2603:10b6:510:33d:cafe::7a) by PH7PR02CA0018.outlook.office365.com
 (2603:10b6:510:33d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 13:16:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000008.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 13:16:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 08:16:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 08:16:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 08:16:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Jakub=20Oko=C5=84ski?=
 <jakub@okonski.org>
Subject: [PATCH 1/2] drm/amdgpu: allow dispatch tunneling on GFX12
Date: Fri, 16 Oct 2026 09:16:03 -0400
Message-ID: <20261016131604.2198664-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000008:EE_|CH4PR12MB078048:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd6711a-0e27-4ced-5575-08df2b87a82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|261009223027099003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: kyLQog4xc3OkYVJ1yH5LY9sEbuxJkX5s1O8RyHVfSXU7Uq18DYaSovUnB/aO7bgSvYy3iNmtisL9QnvMHPpzQYqTtF96CAboPtU+0U7bv1BhqEJ83t5qSKXdGxyHm2BR/5td/E7QHXPAHZkWr1x/1tidTLt5xgYZCNhXrwlQ9Biv+mqeIRKV3Ljgi7woQtS8vcoEM+ggLM23EEMAixkAITAXM8pKg9nsqE476vkwtu6XzaDzVcmjOwqFq/C7jEjgs4TItcc5BXDcVIteL9g+RNe7Aq4XAnaU0jChX1GjBpUNo03gAuIiVKm291RSgV7lCdVUGlAgMqcS81jysMU5EX2jMIawLZnQm6y4o72bKA5G+foZjNsz2++s+y35oPEUZ9MdMocSDlU0d1IUt/tEtwjgBBPHjfogQzunMBof2F9X1qnOW6g3B03CAHUqn+XxyOS8hvdlQWuRkyX90VYnfsqzqNp6iTSNtEJ9UQY4ANN1e18oF3zcqpC3AxZYflZ2oiPbMUm14epOG/wVB3sqoQrW1z6UZ4WwZdZsjRq44GJcJU/z6PAtvHawDSFyI1eSme83cG/9SOnomlPVvEN0zvseWOevkBj+dBtEIlhwWrC7JGuLiU1awph4mWLXTuHw6lMS9gAvhCUz2TxgGjFgDAmrZ2Vapbrkc9UApBocdBeS/b1LCgt6ccjwxW8xp+xPziDWPaU0jcRaZ9e6Ciky+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 49WuyIUathEQJ/f7dWwxlzo//tUmXqpKGuCoefVGQNEqLzp36DDAqSptE0VPnULdxLM3YYXXp40mDKS1Z3NThISrYXaXCbgCYgDfNZJw8gGDBlH829NNsw6QEgPe5+jl64CvjJ4r99MN+Wn5Rpkzsd3B67wl5yNx8Z2AzeoKJExQUdC9AS+rXbepWuOkY0NuNzNHlg2tP5tL2YODUb9xTOv3gO4u63nsQPs23RlBtukhFb1cqJARneyamjxJ9TK5RQ0vHdLhtsng7PBwr9vyLQ2q4L0Vf0jw9AQklQqE3wMA+la49INexUEdJIpG3hTwTCUVN0NRugExlt1BhLVxJATJ0G9ust2iyv9dEwYsv+DuBoqdZf4NlMtjC9vhbWSeHunogqsni8EqnHzhCiFYvrCB02dWplWriJ4FCMKedvHAVyNHXWu3CaXZRnhqdQc5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:16:15.1391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd6711a-0e27-4ced-5575-08df2b87a82d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000008.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB078048
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

Was implemented for older gfx generations, but got missed
on gfx12.

Suggested-by: Jakub Okoński <jakub@okonski.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1ac0d33e62e26..c9e091ea8c5e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3168,7 +3168,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
+			    prop->allow_tunneling);
 	if (prop->kernel_queue) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
-- 
2.56.0

