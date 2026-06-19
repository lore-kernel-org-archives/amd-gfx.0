Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F73CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 15:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9303D10F656;
	Fri, 19 Jun 2026 15:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="17LwL/M1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F6310F656
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 15:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDk9l1LqPnIaoiiYLb+P0/UIH4nq1bKWZLyzvjYbRUAoLsxq69HuTs3dPX/riIs5tTbf72ieqDeJ8CyZtZwPB1By6LZDfc9OZwr8Ua/8jG7sHYSCHTPS0F3btB6mQPWJTpmOhxuEW22CQrd9oMLZUtj4J/HUpsbBfGSO6PyBgpIe/V0keZVOSZOA7w9NrKcifvCJjqybr9B92treOhs+QM79bGOu/dBusq9Z2pqf66m4+TdIIVOFA4CDKqBzFmvuIiUjvKgfxZsYZyAxqIHsMXX/6oNYdiQjgYUaoLYDLL5CkTXwwpxNwtIqqOHmCE6DpgYusNrErzWTGtBDHQv+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQAQda2X1G3gIOWcMdB3nkHThRqF09bYXGX8acT7k64=;
 b=DMEFzmXedbOUY01hPA+QaK31Rq3+D1/dD0Qg86XNW7hWokNC3yYQF7HEymLK8dGIEVHSEGPDhTFNHxDsmcl6WPxEXsPx2jWc08Y9RM48xT605hx6z6XKXHCdFXW5vKcIEfSnicjQZ0qSDgwNaXTJ3MPWJfGWu3ljirxUlSA/+zODLzH2eJHbyX9MazAgNV0ei1jriO7awJR6m4Jser09QT8u3FDEVDUqLE73u94kVszuWSNVRvyIbB8DR5hnYAPiyqAtvDuL5p+AZ1lGsKABiQSUxwuBIPC+ui13T5GzbcVhdYl7U7QuwSo6idBfvjib6QP3wDBULq+j7I4NV9U5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQAQda2X1G3gIOWcMdB3nkHThRqF09bYXGX8acT7k64=;
 b=17LwL/M1+qz8CIcNq3Sg0QHllIM2Uerv/okzPupYrfTHlxly9XGqWltKiOmDa2YOsr1NT5yP9A0GcNYshKZ82C+zM8cgVJOnSAVHOc8y0TPjgkFTC70gS80DWHWFV2xMFQ2KCqNQ+P3qwwvc97y0kIqcHjQy/RuQ2sRHQ/KxZKM=
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Fri, 19 Jun
 2026 15:41:32 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::35) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 15:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Fri, 19 Jun 2026 15:41:31 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 19 Jun 2026 10:41:29 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <yangp@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: add sanity check in svm_range_is_valid
Date: Fri, 19 Jun 2026 11:41:15 -0400
Message-ID: <20260619154115.65247-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 662bc6e4-d8e8-464c-fc55-08dece193c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Kiv76vW4VMQ5aRxuLn2BYFm/LLjLuLxFBbi9egVPVPWUXBfwhUFlEA38A6AuUTf4Ougw5r1keJOEz0nXRpvKbLhujQ5FVpdV4FWVlrhA+hcPj31XPjlzG/usrYxc7X/Bx33z1XV4UupKGRdHhlpYCwbzO2xEWaa8pIAUnYOaxwYnZHOJNWBep6uRmwlrPEQP+Ry8w5mf8dRTXn5FPplU7kLBjC0ovzhGwJLpxKKsxaI4gnheRGaTkdygziMiBwfKcJ0g10s8fe/u3+CMHa9Ixlry+pZuJToAG/PUr6HHttFkvvJ8HYDXmm1Ah8fWzyqq/mQXMrdmSpC5R4bgb+TG1VNBtcgP+PWHVPUnRlkZCzKanSa2cPBlQWYDLGlveLvrKPib6BeTPQ+4f/G3wwBTGwe9VUWV1HD76DITTjiIc0rkllQTmT/sk9SWvmcU9ALprjH0X2MJ/41zZpNCVzVMqkO3fntRsZXnngkfnbGy5qq97VQNGNZDdzvTlqYUFF0+gAWSxNq7skPaoUYJ3sR3LUYSsCwJUh9q11xzjSSXBa4IHjb1USeVt/cjs/LabkitOAH4VGIt76JlctbpJvEsy3sW3JqrlAAqBVgF309GuGy10SSqaeto8OREPvzbQz+GTTdwCwLhmBdmPGhMD0B4n3EEjCfDtBMmU0SGhSMRZ1Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vnR8hgkWpgJptEQfbhYnzKjEYXT1KMtj1CZcdHDYsS0goDUMKVF8rdhSev61TGuxDqxo/1+lV9QFOkHAJqc4eBZTroArOFz/JrG+eVSQlkbC3lAOAxIUdK/axe4+BIOx5Wu9shMF5FTQZzG3sn5mmeNz7eJAPpQWowNTd+cSR6taSgo/TvYGLkxjrKtFJ/9ZSxuDepiDcOuZF5bjWHpB9L7yDGyulxaw+1anipl+W4ut3TB+qWbi8/q11a5Ze4LPWlelCY9ThEzb6JuyI0pv5PfiY0LNhcoJMpSbg4yx7EdsPQmbwTpPVBBJPaJjI0qAr4i37eXhF8eJp86KENSVowEbuW7RVoVmD+ShjEAOptuwGOUpeqXhLGtbuZMZ+Bkq1LxJ8/ytbQisgbDq4ma+j9TZGwkWfFw1X0cpzlPFpZU8GDCjZLcD5nZO4BhQ8sb5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 15:41:31.7102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662bc6e4-d8e8-464c-fc55-08dece193c7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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

to prevent svm range to be overflow or underflow.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ffecd818e611..0df6851420e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3473,7 +3473,13 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 	unsigned long start_unchg = start;
 
 	start <<= PAGE_SHIFT;
-	end = start + (size << PAGE_SHIFT);
+
+	if (size == 0)
+		return -EINVAL;
+
+	if (check_add_overflow(start, size << PAGE_SHIFT, &end))
+		return -EOVERFLOW;
+
 	do {
 		vma = vma_lookup(p->mm, start);
 		if (!vma || (vma->vm_flags & device_vma))
-- 
2.34.1

