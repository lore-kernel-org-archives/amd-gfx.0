Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659BCCD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5DB10FFF3;
	Wed, 10 Apr 2024 21:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJEoDrgZ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3915110F9CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c35y6HHSYuXCg1sNP0KYgolRMfQPwBYKFlIjQD9obgyT8GBSiZ0mQbOHatE6PV+6Wb9J07WRIcvRBmO1+XJtCMhqOkMsr/2oxtAFddTGpJwWjgxLZRBZ3b79LMni9f1RGS0LCGyWaTwN/LboUSEa0dI8gUUSaRPYsKtiVAt6fNZ5AmxThIP327g9pD3ThY1d99Y06+hhGv+Ka8W4ZzS+szMzlrB0Rc7EOi8Ydqav3qR53MEWm3b4V6yQirsoo6s0wZkJT3wfdldpfhHLFweqcKytx66gsTvbCnOEmmVraX7wmIY7NNgnoK7StLaDsmpPA67QuYEtWXjz++2fvuQTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUt13ILHGW4Yad5Dyu2ErhSr72DLBUJcZ4arTiY8zaw=;
 b=S27FtzqcndCT96jANgrIX03NFZBSDTDaaa3bLZOfzGtnpIfpynZl4zKH038n7dWnVeqcRTYYnCocE6vdflJihrodhRCw/ayLBGOUzfKyvb0gLs8K6aW+k1ujDAM1AeRig0gl+QeKyBU/WAZLtFh6XkNS3FONisBAN3c1K4qUk4MdbOQBnF7RMa7KA+pIcav359ZBK9IBKosyeESSDdIZpKPh3hBfvI+Cpo7wEgGWcox+P3glrI7r2w0POh0J1We789sKxK7dFv0BMffkag0hFzm46XI1TOJ+3AKweVQBLFsNzaXdDrSKsW2C7EaSb4no025+EbrHnv/DrKanv+wLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUt13ILHGW4Yad5Dyu2ErhSr72DLBUJcZ4arTiY8zaw=;
 b=zJEoDrgZsiN8cOEN2GZC2GurTPnckGR0eGMMPL7bUMVqchGj05+CVsUNecoQzmFtD5a6M58s5GzLzlIM5FwXd4BIFguwlrH/yUytJwwwPyxuQDrOD+FEg8W6Y7Qi5PQkq/+cVMX1nECX0lMGReRTSPsdE2B4k6dW0wUFr3/Dppg=
Received: from BN9PR03CA0142.namprd03.prod.outlook.com (2603:10b6:408:fe::27)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Wed, 10 Apr
 2024 21:28:28 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::b6) by BN9PR03CA0142.outlook.office365.com
 (2603:10b6:408:fe::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.38 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:28 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 24/25] drm/amd/display: Add missing replay field
Date: Wed, 10 Apr 2024 15:26:13 -0600
Message-ID: <20240410212726.1312989-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a59b6c-dd95-4c6b-0044-08dc59a529cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHcClhwy58Dli6OTZRPeoU1pk0EBYfdpPD/hdnKKxkG2zrwNTDqp+KhDghbQrquuaSH3fpQ9gxq/gmnXWOUOgknNfn8KQmtgkmNxVJzdMhSdbPS06E/w7cBMtDzKOKUFlC/aXNvf7vvXnch4ud/vvRPeh5b9hV+He6LcUThkpLH1aPIeC/UfYFLigvVdRTVrKrGYifsSqM0H/uEFDY1RkT+hhbMYPg1VQR7n/xcRVW845GDeJKEnG6aFf9Shj9NvC14z0hAgn3lEY8j8rR/V8gF5jnOy9wPd+ah9CRvTrgeCKUA+5lnWT55h1ikRTfIiXbbmbrw+VeQpMj2+oU6/l47TiP/mfXkv7F8O5c4k2YUdGTnh4QGWvB0LbQISRdOIk6BsMoeCNxX6vJhLEo1uyZ43OAw+B6jjt4WEvCcMXjnm5l9pwx01LQz/qIBKwDuBh/wSnvfXXUcsUzVMVFKGIw3EdFzkvthWEYAahxcoGl8AsWWeDhzpKqviiuxVYqQ/nN6WgnwrL0j4Z9F9mb2/a+yE0M0/VaBxg15SE01HvyVGciy6eqId4p2uOgHE5ud0RDPOCnAk0ES3VxeJiCjnhmm7tYlWWI17gYSVwPTgDjWBUQ5jQQIf9CcpnEj6RR1A9DbYX/LQ5tMWipSsxGaB8c+qJg0MINzqPubxlTg2f/bGPsgVKf/o6k8Y+M5NbCdDPUNQ4VN11kx2WVIS2+CMHBLrTh9H0WY/xnFLCNgxtWsXBUezCdDzFqmCAo7kXjUF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:28.4163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a59b6c-dd95-4c6b-0044-08dc59a529cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 614d7c27c759..0f66d00ef80f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1050,6 +1050,8 @@ union replay_error_status {
 struct replay_config {
 	/* Replay feature is supported */
 	bool replay_supported;
+	/* Replay caps support DPCD & EDID caps*/
+	bool replay_cap_support;
 	/* Power opt flags that are supported */
 	unsigned int replay_power_opt_supported;
 	/* SMU optimization is supported */
-- 
2.43.0

