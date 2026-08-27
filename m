Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82957C61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 19:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F226910F180;
	Thu, 27 Aug 2026 19:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="prMK8DpY";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCE610F180
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 19:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItbZc/jqrbTKLAZ1Xe3fvXKhQGJrkVQyoeX6WP9dxzlXZ0FPZyzaEyTqzAGkF5mxYeObASEzyyjMU+8tpdOJuS1yPAt29AuX5ncvy0yZ/eXZ/W02LTNVg3Xyc8kt0kycaQEuoxB00vdSgEhZGSKHWjrsfdWipdX24DwF9BiqVmbB64201s9+3bdjrA9iufP2qVgpkTQ3rHEBtQOwo13PK43XiH7Wlt7u299W8WjXwfzO/nLmoa2sbzeXXtg+zCI3G+wWRTcBqS+3XQHINj5qptcm4KThk8w1XIEIrUrVKznMc1+OHLOJA3Z+ScgSveM+TyUyoQl/o0Q3rpt2wNlD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PN7lK6PBaNCqLjNdb+sCMWqy1h1GIA5nHautIRgPjY=;
 b=Rsx+zcR8E0QdSjqoA8s+lwjEu7iLMjt6uDSV9FhFL3iwTmqY2TLYoCdXCoULc6W4L/GWDy76Q/gNtDr+JwaSaN/m3qO58NNfAdwZ9umpN+9xaxy85bKfQI0gJ7PYJJJw8WCik+i0XgjIeMLJNLt6rOmT+zaqWixi0ojRYVXuY91gXhJMvLdmQs2GdleSKBhhSC7GcnXTOFuk+VSKNCCmb09LFlRb/N9gQ3yi/yFtUn/MnsYU5hy8B2CtkQATTwComJA+qXPPGO4V3WKlDLCeIGkS+7APp14v885O0Ti3r/akmkadJkh3Cf0/5AT3d/eHj1HkbI+40zzZ3E3eQQbbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PN7lK6PBaNCqLjNdb+sCMWqy1h1GIA5nHautIRgPjY=;
 b=prMK8DpYgzOHeEb/PjwUjN9F7yvVK7KxeFtFez1l5ZpEX2+8FuEA06pPGkwdF3b83rx3s/eEErldd50yijTPd4MnuJY9kT7gMAKAfXn7DpiRuPXg80tFbyyPet4mr2jXLFaTzheWQ0N2tx2rpEUu5R8Volhu2l0Xb0Nq7bA/94Y=
Received: from BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27)
 by CH9PR12MB962943.namprd12.prod.outlook.com (2603:10b6:610:310::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Thu, 27 Aug
 2026 19:13:44 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1b) by BL1PR13CA0352.outlook.office365.com
 (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Thu, 27
 Aug 2026 19:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 19:13:43 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 14:13:43 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jesse.Zhang@amd.com>,
 <michael.chen@amd.com>, <shaoyun.liu@amd.com>
CC: Amber Lin <amber.lin@amd.com>
Subject: [PATCH] drm/amdgpu: Update queue reset support version
Date: Thu, 27 Aug 2026 15:13:22 -0400
Message-ID: <20260827191322.1295826-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|CH9PR12MB962943:EE_
X-MS-Office365-Filtering-Correlation-Id: 036ed8c8-2aae-44be-d468-08df046f4ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: +fjFN0Ua8a2DlKXTDLN6WQVVQQJiKRh6Kzuzoxs9+G65SDFk6iuttjR6wq4EthPHu4H3Vk1A3Hvb5wxx/wP1qDb1RgaHHznofMYZmQ7HxtGDCr1/DKEq8bC/PBlHSf4aReZeAwI+3B86x0o0RYc4WW+9lam89f0TEoPuBeEobO00GLD6lmNaT3XLj0Qk8mUbS61ilb0AVYRHYz2uyZbRgur5lCgXtfdp9BeMOdnbp0hMBGFOrbr+qF6u8BuX9tAsV1DbQQ2yRYFWGwM9LcGQKupm+EYVTgcLW0MKDbEQePLzBgN3ck9QTgZ3rauNn/Rc37U+77VxPmrTWiAXE63iqXE1r3wNZd3B/jUMoQwVpR0ns0Av1GTI26O/2cvFwqSgK3K2vvzzQtfACG0O92G9xIOjRMsu408drQVR6kGoMjvT4c3L/uemMLt+N22oUpKjrKvuRU0LH4WKVo7TP7SHCOO7YRETe479100zS3VyHqHDqp0jLql72DNNO0JXfa0k1fzbHr/TAu5b6VxOkvx5PbuqJFDHGBfCO51AdnVK0oG5mdZtLmEDmpTrNWEFLXHeo7VB1MRdDZR2JmhbNjZl5QQOnV8UcAvTcwUj/5LTbQqPGgE6drpNAzvdWuHu/kdTBhg/JyQICwXU29+kAiCo2EKftr6TEnjUs5mq7qSF6MAEWFtGq+rGQDzIN06iB+sRnskRTVtMPf6VlzMYV7mxCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vncXpL+YJL1He31xWCChLvcTdQeWv6RkmVPZoGU9HDhQgheFJasrdfncjhJzfCtqfoqDqNIVn/7IBevnbDnyW6xwQADEDFIvjQNlm+HKOURmkQiNfUbwtrkMnnJLo0JsWxVDDom5+oqdcki/aQWSn2Rt3ETiUAhVEShrnKLAs8CIoMhCZYA0XJNfE4HdTsvNdkDRqY+A5/FuGOYOz9mw3ezlqtHAV/anJdKqJPq1hMHWoCdAgmxvAmeQFW6fQHfjSM/69/svkSSWOCRBxz5C3Q/DcfrrJWVBIIjpcBGB6hV421t3qd74ninBP0KcBTljlD65wN2R8XePws0/dUXHJxp6G6HPa+go26R+f18Bf9rC/9CJ7HfzuseKWug+FNzQQPU7BQRv2lstYYowZHd8eidkIBdUc3wU2El0cl4VAg8bYp/j/+UC+bRej20Z8Ud3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 19:13:43.9036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036ed8c8-2aae-44be-d468-08df046f4ff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB962943
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

Update queue reset required MES version for MES 12.1 to 0x7b since we
change the implementation from detect-and-reset method to
per-queue-reset method.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e0e38d6bcafc..d88c95a8117c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -886,7 +886,7 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
 
 	return (ip_maj == 11 && mes_sched >= 0x8c) ||
 		((ip_maj == 12 && ip_min == 0) && mes_sched >= 0x8d) ||
-		((ip_maj == 12 && ip_min == 1) && mes_sched >= 0x73);
+		((ip_maj == 12 && ip_min == 1) && mes_sched >= 0x7b);
 }
 
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
-- 
2.43.0

