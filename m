Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B37F417F3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C4010E521;
	Mon,  9 Mar 2026 14:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dM5wKDCM";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5515110E51E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boyVHYSY09AHeZaXQkw/HlvcyDndwHzA54xesE4HI2S6gKh+VSxVbCV986c/gRS748xTQv5vlvXPDqPC8W8o9Vpuy++2uXveXcdqErdWE0NzXmnsLkmcpMxtGlgOtuO6ExZHzhny1VsgNlvOazaGdgtx93Cp8F/GchgTWXHX8OMtlvn65Ber3bNCqvRFSTblPgyEXZhPW573s/tyTCEnUvYwatQaG61RWf1vf2AVAdXb4VB4P1UHfBPrUUeFs6hi6+6AmsLVN9TcAlBPEmoKPFa/b7JlzXS7SlhqSNc24SWC4h4UFQmSojCPQRYtImsa5RBqUZ9mP5mKyySqtN8oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okvk2hh67qHoQVQavWh25SUI7gY0vNS7MlYiioXNHVs=;
 b=DL1FWlriZCboGbGjN5cYmjN2jjP8hAdpUn9P9N8x1NTfop/jfUyHqirEnA+00vJeVLBS0G+62Z1qIbNpQdpWy1YVWpUlxsTUdueD/12zksqOOHbZYIA6ZrpbLbizOb8EwFLaDsmkw93saVVEMAEueSQ7JMHMkILRQ7N/UiMlVg0xZ3ayMNR28NJw9mvL9bP4HIAEJkqnlS6+q+ZRJRKfOTM2/PXDgkfHmhjPQANCPjKxl0u5idOV17GZLykACLXa+pYpKwIrY+qii3KS8p5Uq57sxeUBkiezOtobLo2f2Hh2dT5RCKj23EIMBulOflHtD0oJDNArIcpSJWTmqJq10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okvk2hh67qHoQVQavWh25SUI7gY0vNS7MlYiioXNHVs=;
 b=dM5wKDCMZEu/rNYTPgPwAZ8iIzMjMJhWb8yTAwmk8sbZh7aHPiBq6C9GZ14aY+0+Nft3Y0SWXRkmSEY6FocjZ4ZmXnXahdtxRu/n29oHoYyavKj5pFza/6pw30/uZZfCPggido9JpPGuVx8YcVSr0ttYO/hyB0PjtjmZMyLONSM=
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Mon, 9 Mar
 2026 14:57:01 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f9) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Query xgmi info from mmhub if available
Date: Mon, 9 Mar 2026 10:56:22 -0400
Message-ID: <20260309145629.2844495-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a63a732-53e8-4b9f-7c47-08de7dec1d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: AMQOcrud/1aNLr4Ps/V8Van1iRjq1KdFe3GIKXoAEE6uhLSteTUq0anR8/4dpNk+l9idqxswiC4CnJbidZRJkkrp5w/xE/whowskOBa80J7roIBWVePfiWqwJdhhSMVnkFdXWiQU0QsLQ6O9cbs7fiW51MmQHZnAZemxLqn5E747rqPcLaMrMcWynuWgH5Z+zFGrM7MsIvPkmL97noybLDVpCYjVpOQuGeDq39f7Zhg5AbfeTMYBIDufIG81DeAVAgnOaGFDAoab04ZdMdCqfMWu1Q/i8JyMe1sctMJ36h4OpwZ1hpKZemvrw6bhl57v6pKzeX9JDyHBlIhPZmNe8UGq7wngkj/E0RlUiX9JIeEABrGLPzhh3+iHbCir8XqaMKTMjQ/rdxUAO2iak/tVJFSh5qc97QdCSxbKcGn3YvimWAEUCRbGz+uLH9xvaCyTqVhCC9/5bejAVlshaW3BH5sh4f3TGVG10mx/cHMwcZU+zcLzPNVLtafbnFUIp5s5Rjm/Ydp1jMSblghLtuBPPh2xa5oXzzIF3kv7DWo684a2eWoYkQo0CeLpZQa6BATPhqCNez0lsuqw4GJbFhpYk/NQUWFuz4Mq2/w3pyTmRQ4vXBD52swYzDw/xqI/fuK/t4zS+6jSaTBMhNoJ+jS+nkSVDKwM588fY/O8BtsFDjoTkE+hLrgt4Zm2oaMNZ4xVJzaX6F8tbFO+uk8RH+zb9Yk/hvO2cdocah2Hzr+6LE6PwRGmv7TVpAV7oC6fcpCl6Xw+4flG+fERNFByGcUyPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NxhpNhCPqxCWDLspxpctV8VBpn3UcnCFfaasn70yVAyEZAoAo+1lewdmbmdnXZAjqCzRgoc6jIaN2u/6E+tDQmcatKK4gsFs6nqrDiTIxzip9LC6JTWGuD/kzGtiTxf4Movy6H9Efl00/f0K+l03mKOw8ymAe+PGjvOQajrYTpVDmpdhJ4kj4hRJ4XvZdqcGwQnWiRg+c3moVM77DGoR9X60BCECtv+jtBc04pJE/e7J5FCrZCGBQVvb+xdJ0VahFzJmM1tFpWHqApZhUpDj5gXZkXoQwH8h/3hswRXFm7g6ZZ+LSGSO/q1uA7vSrIk0fEPNi2pnOXGrPXOe89du4RAfXdlAVajyfOp+9mv7VZLjFaurGrtBDA64TMTGQW3AR7zvA0RMoM3tq2E6x7B0rwnJw94Sb58UmojR9wTlUaPNsa7+42ezXQwGi0qptr+/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:58.7651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a63a732-53e8-4b9f-7c47-08de7dec1d35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Query xgmi info from mmhub if available

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8c0d54796155a..97a51429ab771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3876,9 +3876,21 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	amdgpu_gmc_noretry_set(adev);
 	/* Need to get xgmi info early to decide the reset behavior*/
 	if (adev->gmc.xgmi.supported) {
-		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
-			return r;
+		if (adev->gfxhub.funcs &&
+		    adev->gfxhub.funcs->get_xgmi_info) {
+			r = adev->gfxhub.funcs->get_xgmi_info(adev);
+			if (r)
+				return r;
+		}
+	}
+
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		if (adev->mmhub.funcs &&
+		    adev->mmhub.funcs->get_xgmi_info) {
+			r = adev->mmhub.funcs->get_xgmi_info(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	/* enable PCIE atomic ops */
-- 
2.53.0

