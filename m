Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05487C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 12:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8139510E51D;
	Thu, 18 May 2023 12:21:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFAF10E51C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 12:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY9KoJ4yLYU2ijpXxXXMbYDSUGYF6wTQnTWp0tox0VXHohtsbU3poHhjFrxUPnatX5SeEmFArvx9jv4nRsZ0JnBrO0h0t53x04iCACDhFaA2zU9x4hp7a4w2hhJf0VDGegRLVjf4sstc3ml9bV1eE6iISPbtihQD4z8FNN4e9KzkgSZWwk8Yhb3zH2GZeLwL8ch91EMIX8VPQE1nhzgRVF6p7IUGhW5R/vil86atidu4IYcYXDpT/bgYxSh5zXcci2JQrTmAqgNDQJb1JBF54iRv+YoVJhCLvKt4IHTZtjFb0WEjCcvA2yoljpxob54i2XWKxnXU8abOeZWdYWnN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFCtfsA0Ox2JXLudLbfvyLhwzd1OoGOPnmoyT8oBt6E=;
 b=BBd+Vu6ukNCP48OND4zOtv/LNkiXuQaTn1doEfltm5pWzCfeo0lMBiu6psuPZ8YEH/F7ggSZm3jFCtL0QiaG/Z3tTk/wm+6raOKkLeKjhyh+Xeq2qZzsb4PfAAIJMQR19MwkGUpcJSDm6UykjxVoiPfhtbzI50UWoeJozs/j2GD2UIdgN2EsYqWRwg4ulZVeqHFojOBp9tcULKI8WFTRWIwZKXm8VY3G8INehUNm0NXLId0QD6mulHKZj73H+RWQM8UU0eucKzrVMIm77j/JiE04h3rbpp3QfY7rl3SaM+EZbXExIGndiGhvl2fBnF18f3RdGgZ01eqSBebbXEthyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFCtfsA0Ox2JXLudLbfvyLhwzd1OoGOPnmoyT8oBt6E=;
 b=d2pphrIFt0k8mW/7RW0vGfEGwSkEwzMMSbLDgBjsOjpZzZM3FsoQYGm2wNwZsFXtoAza98VRrrOJnylmfH9YUz5aROFYoeJ8lcHo6VSuB4xzs1LvA6jt6yZ9+u7cRapOgzvzRKklSaRW5NPN+dxRunhZInPRlvK9GJXg13siEJY=
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 12:21:50 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::20) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 12:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 12:21:50 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 07:21:48 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/6] drm/amdgpu: complement the 4, 6 and 8 XCC cases
Date: Thu, 18 May 2023 20:20:59 +0800
Message-ID: <20230518122059.28815-7-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518122059.28815-1-shiwu.zhang@amd.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 288cc019-a5ef-4260-bcc9-08db579a751e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlJIf9nVAb16Jss/+0MkO1I985Uv6jkBFvVANJMorm9IqTCk4VpDRfaYBL8NB7cxidEfOa/4QQNPWI2KZMNyymhjBLkvCwSYvL4i2YVNvBB+FatPzLwMYIIbUKlYKc1f5N+9nvx78a+72wshsN14inllEhHla31iSFpzi9HON3y0e+B2YGRD6ArpDH7C1aKMWJTjVus3lTLC9btnLdwANYfFabOgX4KJZxt84s6NZfNaQs5BNP2EEEt51ajWeYfaPFwWGHoEFg+kxBSTmlSPj4583Zypr+WS2Xr+Z1rEji5nWaXp5sa1fGpmVKMf+iGLn7AvFzsnkzfwjU+kdhkCUdwGC1bwjd2LIPzHeL3JbUjP8cJxMWrwtXWbIXzwFH1PGz44jyPHMG6YaXZFTpdeuQc6zp+ELmiO0tIAfLA2rtbdnocsX+0Djy7pIrQlZlvVDJbDqNr96fFvKRkMu1Ctarfc/dvAreumTCBZUkmps2/iOcJNQe6J0onKAnRL3PZl4A9DXt0js5ffJueYs6j25Zbqc5HWCVSVH9/0o6ybjNVQ0Cfy6ha9iyJFkDgav9XFNxm2Cbr98T4jiiM+WtBqDCKn5udwKcW5DZV7rjPKdMJj7a/VQ3vUF6j+YCKxN5+C9JaB4epRkvrS+vY7a4bP2bcnvDjcPmC5zs6QkrJKltIeIpG7OrLI9B6n4kZtlg0ZMPUAGLgPL6I9ItZrZMQwY3to3/FYxCx3776km67rNyB18OtRj+QmEFSxlop6uIvgnsMSSckxkNJZ8bGH21nEfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(26005)(1076003)(7696005)(36756003)(36860700001)(40480700001)(2616005)(86362001)(356005)(426003)(336012)(82310400005)(47076005)(82740400003)(16526019)(186003)(81166007)(2906002)(4744005)(8936002)(478600001)(316002)(44832011)(8676002)(5660300002)(70586007)(70206006)(6666004)(41300700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 12:21:50.3179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288cc019-a5ef-4260-bcc9-08db579a751e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
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

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e5cfb3adb3b3..97f6f854d077 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1031,6 +1031,9 @@ static void gfx_v9_4_3_xcc_program_xcc_id(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, 0x8);
 		break;
 	case 2:
+	case 4:
+	case 6:
+	case 8:
 		tmp = (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
 		tmp = tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, tmp);
-- 
2.17.1

