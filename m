Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EFBC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3998010F391;
	Tue,  3 May 2022 20:29:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E7510F3A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIoRq2JJQvbQ86nSF9DJWHQk1fKL6dsjeeio/aGduP9s/uhOxc/8fcj703Y1ZeZH9CrVduNhKcxI+vSUSu0U+i46mA8NH1DTVKj4c/YGoC9zmtie5aLBwAfqX7fU55XhiR7hcEefNN4V0QTQ/QT+2oRXPHTC/G/Q5Sa1XU8ZlWwN86k3TXJJotIC+HtIzBx0+amGM9WMqoGh0z1xfraKEJ+xsePC8eLKLyZwMD1kFEY8M1wbhrktDmalSGX0ye5QGc0XsNInHicfh1S7sEEic31d13SSHKsRqiLiTnNAxfukDhIb+x8FzpEVLmWwCb1HQR0v3xaKtmbn0YwWLcaASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agr45P4aLCoa/eSizXPzkPU8a13NA+PWwwmu3uUVsHQ=;
 b=LsvqEg6/QF2pDAIXCA9VhD5gJFCjKH2aoG2aLcQa1mh1jD7EYRgck/Pw5e9vkcbo03Lr6gm7xF9qSdcbPYJxycmlpH5qXk0yOojpSqyHzZ3tAq8svtc2uzMy6cizMbc9aPr7LTM5rDnR4ArDZV3t8JZzF0/n25I8EBnriP8ma9m4RlRPXg0AFfgiN9vkS3aUrW+ygoRfsiMM3trw188LVcccTXJnLr/MX9ee6KKU3Gqlyuxpb2QMACwW10MWrrARUif92Emi8Eckyr0rTaXnXtPn9d7iZ/+Outw3gGe2xUOUALFuoHiSNL+6MuKncnjVRQdnMQkBc260Zvc0xjXEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agr45P4aLCoa/eSizXPzkPU8a13NA+PWwwmu3uUVsHQ=;
 b=Z14+kqvibjmtZ2Z2YPefdPRo+Z+R+dnXlNjsOBM0pq1abbMu3hShU9AUDl7zNkfU4DnTwkDVw0deGO4D7uxhnFpaxuLT0X4fWIpz5XDVrifw4nNetw+YHw+6vmQ26OwZq08XLTUQJqn4Swdgkn+8zrFfVxXHwy+S1b3ZHowoda0=
Received: from DM6PR02CA0149.namprd02.prod.outlook.com (2603:10b6:5:332::16)
 by CY4PR1201MB0022.namprd12.prod.outlook.com (2603:10b6:910:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:29:40 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::f5) by DM6PR02CA0149.outlook.office365.com
 (2603:10b6:5:332::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:29:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable cgcg and cgls for GC 11_0_2
Date: Tue, 3 May 2022 16:29:12 -0400
Message-ID: <20220503202912.1211009-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06c78d34-1dc8-4b2c-a8d8-08da2d43a69e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0022:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00222E65E21D318F423C5C37F7C09@CY4PR1201MB0022.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wqi2Ct1f1c7FfAKPH4p05T4amCaT8cbfw5L8wn+tPfVgJsXYVZ81hVkn+7LpBc1iN8mYtr72xOr5OfVnmHiI763uaOgLp9sYavBFbHNO0JXqtXeXjSPH55WAMvTMMiOHJ677u4NmzsdjJXOsPimdSBn440pnXMtWhsOj0ioxAa/ctae9V12+yd1IU0Ghy9xzPZxC8/3VYlmbuYIlCuJ13M3+O8a7Pw1Sm78kfZ2lAOfxjASDuNiuDR1vbqCpAWRYS2y47vVB7UXrp/a7Co5s4Dw2LOGcUcd1u5zZ86UUAgnH4XmTfqpjwoXzKZIP92QrzYhWM2aUY9XbORjXsMFGP6AY6MmTYbKS31Ta4J1eimUnhKtQlbcqgsFcYTiQjLxKlQBAlQnxicQGFyW7oMKQLm6cgA8jy6dADPD/+LwraR3niBIAuFyAZHK9S9l+J+HGmvheAG0MilnOatGG86VqRNNH0vdr35JTIvQArG4gaWufVGPozCsaz8238HCwUSn/P/G9FldsWSUKb3EOyWvsQgzPtt3Ua2wOPxhX1eF8JKNbIavNL+eD73iQKdrmWFByQIDRfnHXIFcMmzaa8y6KyJ7sRhNxW14NBxT9EhooKswUZsaxMjs+plLWGrRuX0xIWjh0Ec3qMeEee0Q20LCEdrc7J6ZE+ejTZbAgqu9YCwW+A3AGD1QXr7LIt7BaOljvMPfaS3kI9bmTnaDtxkKIjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(36860700001)(4326008)(5660300002)(8936002)(36756003)(70206006)(2616005)(6666004)(70586007)(6916009)(8676002)(2906002)(508600001)(54906003)(47076005)(40460700003)(26005)(356005)(7696005)(426003)(81166007)(336012)(186003)(82310400005)(4744005)(16526019)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:40.6883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c78d34-1dc8-4b2c-a8d8-08da2d43a69e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0022
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable GFX CGCG and CGLS for GFX v11_0_2.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 7bafc146aa55..5d359b768c57 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -549,6 +549,8 @@ static int soc21_common_early_init(void *handle)
 		break;
 	case IP_VERSION(11, 0, 2):
 		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
-- 
2.35.1

