Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A92CD98DE
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD4C10EC1D;
	Thu, 18 Jun 2026 05:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fdm6lAbv";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A5210EC1D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sy0PpOCg/Dr+7348MPGWem6H2+2n3ocbG0muBjSuvbeKSJBY2XNws30cMrFbmGugspn84mJ521s42nIZy00f6ESovSaTC1sqTtyONpw4C7QfPd8exjT0pSDI5wpcK8siEI/XgLA8pI2d+AD9MF3KMiHZyEw+fo7wetxO0zMxzGoiR4uU1epFhB1++z5pjlbZx2y8XiyQ4fx0CTB537zGditNNp0XtVhsavdGy8u9k5f6Dh6T8HkOnd7HRw2hmyJRQtY6MntkabRuj4uI0EyauhOLR70Nn28QuMkm3UCCO19PrwcWSSioyanDlf6UO8I7a2fF7Hf/WBWG4KHlKYXyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xadR7MzOP4fpmz8P/5mwZUug2/Na61fSpLhIen9wOkA=;
 b=cU4743YFreGc6WCaEK6N8nPIBwQyM4YrV2xeq0lUmnJ0od3hUiOvvUVIyjEluu57G5kMnP6pXyYHcnM2bSw2eyYyFqOdyXiPRW5l4hhd289UD5JuCO5J7ftrA8B4lFPo+5/6nPdzZLQdQ6XngHhGQBTcXk4nz4wHjF5drZ3cE8zVTfvjJ+MV3ILHV1Jk0zuGuxXyukiBRcGLOdW/cRGyr1p5ZMsR8jmFtkljcti6wAEZRWYqxD1wkvL5j/NH/rCzLtCzKIldZtRdplzLjOhiGLGZD8fEC2ERougdfYx6Cc0ftHJSxaX9tJzBhk9WC+cGkiC6j7zdMs06RkIn8bJyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xadR7MzOP4fpmz8P/5mwZUug2/Na61fSpLhIen9wOkA=;
 b=fdm6lAbvm7V6SFH+nWkQPSwzavlxgQpR1AmOMwA0L76DaFQp0cDjwDbJs1sFAj8cznnnyHZah33BHXvh7S4WM+6WEaeDqA+kUeOeugU7Z0tos7Zlzg12B0/6F3GNBGigVw/5nHgz005jGs05ah23+xzB6XeERSbBRk2lnAcgRC8=
Received: from BN8PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:d4::24)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 05:16:30 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::1) by BN8PR04CA0050.outlook.office365.com
 (2603:10b6:408:d4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 05:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Thu, 18 Jun 2026 05:16:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 00:16:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: bounds check xcp ip block index
Date: Thu, 18 Jun 2026 10:46:11 +0530
Message-ID: <20260618051611.931328-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: bd68e020-7ec4-4716-3c66-08deccf8c10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: bfgK0230FC0ypaz5AUcrCK0OrlniIX38JMZtyn+JjisPtr78xTtCDMSN+MVwdc7OSYKV4FmubM1EP+3DF9DNqDnaIioW+dXqIT6gfh0Gzl2hz63HwUI1ltvUEGjS41qInpMtnkHcFEkYTrukwAQN2ffjCUWxInQptsMbpXNqpeGW9/4xIHrUzvz6fIFGgUXSIc/9+6xykbMHDz0qnRDzp9tT1v+jRnu1bDb9gHottJSoOppbq6vJEGZcgA9Bh7nyvBI88gecOI2y25PMCFHalvPYXcW1B2hC3yF6n75/jfXJ0igkKPf8ufRGlelT4mCu0CaiwBQ4tOCKgJxBZOkpA78IHZNyolUy0duH9bZuNEmQseEsic9UQ/Zf5+Mz+uDU4eKL8zNnmq9aqD8y5UCbKEUwbbfIz8TX3o/FrZ6UnRcf6swQS2wN/ssBkak9HTTObpF4V/bdVjoMEoiT0SWQ7QOS5YKI4QI50umsV5ckYRwB1fRFKQDtdC0HCr362QpRE3r8QaQekyikRYFLv6aGJzLcr3zzrSdURxkfqeOQLQgL1d+LHNdnFYoFG3CMCbyBfmcjGjeHCiCnrMRMGFRfwD+QEZlkTv53MWQb6zc2Zmq9T5Zwg+NMAn9XqlkQ6tj5h3bGqU+WwWn04iMs2Z5QpuNAtmcp/GpuwukN+7NU08t1gFF2IXMiQwziEs2IY8gr99xVpMLWTCArl7ucDLZmQN8xSsH2QyoN/xu0GZ7nfFU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zX9iZjXwTggNxDb1JE4bFbc1bav2A0kATVT57Bf/1/RX0EmmgTwRILjbXMpUNGOVXV11agduWgeP6FDnH2AwjcEf8kD+iYfeuOMzq+oFzRAYKtFv678eFm9CH2PeFJqtl2Glw68Dq4iPVzihUKBsDu4TpU01ckJ7SfTQQ17BQnah6kvI1iojYo50EwB1rquHTzSC9KT9BkssqwkUejfVCYs+7BQjCDRHjqJXmg9BfwS1UDiWcjnrADaAhXa2xy6LitMWTpa0uGXSTVBOtfXk427wDdYbK/yEuGg7mHcEZc4I7JXErjuWctGiAhiMpkJ9ssCYgG8eEGEu8QEQsVVUoIMNoZff+T6WoSseE1gQvqWbws9OG7yUJJUJv8gyhrtv8rCp5ybDWXC7TxhC7yO0O1zis3bi1wlEa9iDhnMGXrtu9q4idwMmEAJPabrwUGND
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:16:29.5527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd68e020-7ec4-4716-3c66-08deccf8c10c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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

Check out of range values for ip block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index d0d494e00cfe..88e6eab91bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -381,7 +381,8 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
 				enum AMDGPU_XCP_IP_BLOCK ip,
 				uint32_t *inst_mask)
 {
-	if (!xcp->valid || !inst_mask || !(xcp->ip[ip].valid))
+	if (!xcp->valid || !inst_mask || ip >= AMDGPU_XCP_MAX_BLOCKS ||
+	    !(xcp->ip[ip].valid))
 		return -EINVAL;
 
 	*inst_mask = xcp->ip[ip].inst_mask;
-- 
2.49.0

