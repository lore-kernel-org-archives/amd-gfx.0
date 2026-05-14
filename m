Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EB8CD4851
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 11:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849F010E3A2;
	Thu, 14 May 2026 11:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRk3ik7c";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD20210E3A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 11:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9w2rYWVLuHExUBeeqUMY2KzY8cDtsjqQNFafoVxmJOh7+RjZcC6LPqjS3p+x/uK8xpLHjNekJj3vYRh/zt3sA0EIeocLfIqHtpLm9rpUw7onLJK80f6eVWvrsB5IvSAuep13hWZc1+5anGmMIXSrpU0ejEuTbZRQ30uskpucG1gOsuomcfJaaSr8okXDOsRUtYCBaRmGGhO7lzBiF+i7eRakLzFgeNEA7nzVxJpcjFYmMiO74cueSNoMEhsnBJtXt+6eJBskiZOtxXGu8eg6rgNxLuo80mMDQL8LbS1ihLEtzREj/JUAzyxuTfjDMZxJByBX1mZeXQVpkaCX+RB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6YMw7D4/7wZBnZozZSjJcMbPRIZopLc+gKGR9sx6Hw=;
 b=X/09yLTmXd0rqstcGM23Bohi6jh1YQjpWwyo6AIFt7QxNWybtLDd41QzLhVOgE4EVzNXOfrWIbJX9wpfOF3YRE6vWvsQhDKc1matBqBY0FfTJdOq78lYZZFTNGxOA8F5M2C0CSfrwu/jStiMPuLoZYWfEIvAXABa08+Y18J6rzpIN52SJqyCIQ0PShO8EC8N+xShRC0lV1IULnLLMPINDdMgNR1s5PsxfBkjw9m5js27subN1k0paQok4XLqKWhjPnbylsvBdV5VyA1bUHJZfnAIiGXVF5/AmRx4jsGPL2A8tn2f44y+qaHGdAEwRvGWeR8zwOjEzn8vJNxLMaaRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6YMw7D4/7wZBnZozZSjJcMbPRIZopLc+gKGR9sx6Hw=;
 b=CRk3ik7cEL/vQOr8LrdTTMu9vspEDNyXrAdrY+vZRyv7UZMhwXP1mhf+L1mM+y/ZuzjnOD7Hw8WgqWxvY2UyMwxCtOyG90rNO+oAGRDF1CNe+5XGZv5y6NZz+BdDXaTjQ+6fjIQRtKW0Qv3kPiwY3fzC5rNyG+MfoEUM+QA7zh4=
Received: from MN2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:208:239::25)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 11:36:09 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::c1) by MN2PR08CA0020.outlook.office365.com
 (2603:10b6:208:239::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Thu, 14
 May 2026 11:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 11:36:09 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 14 May 2026 06:36:07 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>
Subject: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified ring
Date: Thu, 14 May 2026 17:05:58 +0530
Message-ID: <20260514113558.1160387-1-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a25693-6dcb-491c-d16a-08deb1acfe6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1fGKe5Ty/Ag62Fyc+KMg9bLNgpABuVRoePCegrZ+iBgXY5wHHz9kDJ23e0s4p1F3Jraxcmxlv9KPcI5TuGHllvJvXZSxTBRufpk5YerQQhidTZvfU8Y2Jkecq0pnxByV9SizsVPbvuvILEDqGqL0LdGqPYZU7mhR7JhQwExjavgR9RRy5Vr2HDdLMlKuMDOPD1Rp8jh3BtpIxDP+750zNz0G+tcNOvRXSyOsiwYAgjuaF/5o+q9mRyknIxl6aBj7L6zpE1A1xiNmUW99YDBeRtnCA1wnckOY6QlxVJl/SZmU1koq13GTLYIjBPWHcYMAoZYaC3eVxgD1xahL7S1YWpK8husi25mEyRsskyDqntERzZIlm9akOQZSe67JyNNpoFy21Dw2pQJYXIfTJ7Ak7cgFytkBIz5Q6lNWfteziZOSlKzdyuYT/pL0ySvcgJFc8u9BwCPk1PBniryK0QJxFACQLE93cnXu4zAng2Qa031B0GaRtplBMvvGLSTEVnEl4VbJ9zqoVKdoD07mz4z6pNDPUd1N1FQM3MfMRhsAsfHXmWOVLtEqy+/V5T+WvsAlvTuWUdZ/TcBrPIzOY7qV+QaNgOs2Z+30HMadxO0taO9W2h8T6nQtJqD2f557XtBucGTCVrs26V/2BzIaKEgEJsNYIRrikcpoLe2T3frHVBiMc7NUkBiDHcft3pCrtLEN2ctFxFMkyBPcHOKnYqRo/W4f0lltw4Rx60IBeQOaUhs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CPzIHsyC60MAodOJRX/BHlSddo0URN5Jc/eifXUIiKxxnZbwyFgqAyIskFL9XUl5NvYtHM2hvcY5W68THmSkW0ddhjvFxX1xDYyLqBCv4HYhBq7GElLkxFf9OR7jRZ8zIK42YJ8/tVbummXmrPw/6fhkpHhLEwJuVPJW0umQXTRdBKzgewpdQG5teuvYWR3vyAiW0bU0ZqYupG5IvcSO3NN0TGRA9IuSg6t8xn1TN6vgbYbAb2Hks9zx+JbpbMEiattBHO5q3Cpbl8+rOzBUiSW+ona6ADcZQ4Q+z8vkhbm4mdhkvQxL1YhWhwhOk0Zt7htEyqVMnhiVxNqIKwUjT69WP5h0bNinUMlLgCUOhBH/cMjdccLdRr6m0LwaEXxdzLJbtKTczxzQL3xpZCjnn52eEZQwKHpvFLStatmSCGibjyoVvZjy2BJvbhSGrJY1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:36:09.3642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a25693-6dcb-491c-d16a-08deb1acfe6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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

From: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>

---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d5f49fa33bee..f875dbcd4f6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1207,6 +1207,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.secure_submission_supported = true,
 	.no_user_fence = true,
 	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
-- 
2.43.0

