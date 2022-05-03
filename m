Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255ABC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A15610EA2F;
	Tue,  3 May 2022 20:09:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C2310EA1B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2l1CGweUYt1PrN8nMt0dkt4NmvPlPQ54rFO6mfNGfiN+jSGcl5ekk+2wDmP2WtLjENY+g5X7V+aAZ1lqdEXuA5X1z9H6bT0Dm1pIZ+iwVazGLniOmwooZYTZJraFcS16qLeMp49KrBNyuNTGRfxoWdWc20lIkXZTHIsrF78yJTwAc6vtX95fK1KHDpddJKa//2PHMtrbwBkN7+JQ+BuWziCC0h2Vv9p1dSWnFuBRktXdkSu/NRlH1PGh4u7+y1jrT8Izt5YSyPRO6QhNVWQJ2bQuLDtkcaJC1MvOI3uiXByLqGrsZRLeSpPEcFkHFuJ6z6ju50lhMrdSeizWCtL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvN/zu8jhKg8zsDYF8gB4QS4J3dgi8DL+wXxqRbTXbM=;
 b=k4VC5Nu8hKtbhXoIWUbaBFHjcbzhe7zXFtrAoRiFZX+MNGQKg6+Y7PqSAAvWxVTu3zApKAlPA8BBV2qxb/ZgssH9M2rvuT2MBfDT3VMvgvhZpA34TlYIsEwopjSZeavGliMSSnT4QN6bMbr/WTnhE3uqP0/QwK8e8m+YV7/uJQLhxedrD6VeUuGdrjQZb7OQLYPzD+4doI9NnAwNwBU0N7ulnNrZC1DTZzCwRbMp4z1gwQ9VMOvWCqY6ClymZLNjau4bIHAeIzJOFCxqSHW3f3lyBqF+0RSqpyReT7pz7rYno9oxmJK3LOlOB6PGjIgmakuidRnLrJsQZKq7in/giQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvN/zu8jhKg8zsDYF8gB4QS4J3dgi8DL+wXxqRbTXbM=;
 b=ut/isobi/IZHKuGvjvB/ZF6ELsQ3r4ON2PWDimvmKpFIlOrhTmKwiTfm9bk5jYIi0q/XIzaM+Xifd6NZKk2FLDbFvIvN+vvf8NBKfpJlPnJL+woPyzmveZfoyEUJIwqpLqrO6dicdDtlGVOBkjnFeBnJLqEqh0EDwf8SkX74Qiw=
Received: from DM6PR07CA0053.namprd07.prod.outlook.com (2603:10b6:5:74::30) by
 BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:09:20 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::d) by DM6PR07CA0053.outlook.office365.com
 (2603:10b6:5:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add ih6 support for IH 6.0.2
Date: Tue, 3 May 2022 16:08:51 -0400
Message-ID: <20220503200855.1163186-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a8d617a-202e-4300-2b82-08da2d40cf31
X-MS-TrafficTypeDiagnostic: BY5PR12MB4999:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4999CC1F9091EA24DB404DCFF7C09@BY5PR12MB4999.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+rmicx8/fA5JxsPx3s0GtywEP9kCpBm82bpqeoVJQb3uMwDp0rZTEhJo0d7PnjMY31g0vSIfYaYzbTi89hChhqDbWxvPP1sh4cvndYLhNBE3Nz4DnELyZkhjNGLLvoXLaTRPw3GUC1QYGEfIKRqGGjiS0YojveR0GgOzwFWQIe9jkSyYdBMEaa833tDVRHUHimYTFkghhrp6kwMuumVy8ovoQ17SX35oRpQEJb4nRiNAKcLkw617prsbqLIzGSE6RVSA888i5+m3RuZGRWWU3Ngie/vWtps+GYhYOlCHquvnm7oDnEOFyEGJBmlyQ6a+VRWaQ4uFmunF5ON8IAciVOXboTNLvCbTHKyzXpx70+rgysDqQGg7t11AiGjc6p74xHnKe99VTP2XRZ8VStzgsxCCfKM/VoFJ7yoJ5xKQtg7rdl0TaJ//xoRf4lttmeFElfMWXWHRe3teR1SmKyU2Y2xExsiVCnodcEbguVUNEkqauV5XY2wYgqkiv+lyM3/YW06AWVOwSmBRKZ0IrwSzDhxeuqM9vMv4wfKuXILzXVKp7AryVmIoBJfmFtsXempemf95n2xk9Ias9Xh3eqYXAvAm/EJFxwPbUTNrczLMsWm1vplTg3X/54Q1jP+ET5SsOu0VX7YmhXwKX+au5fzx6KO0OFo9xCDhxwTk+xfHrS7Kfwd/4mo6m17zcuBwpRJTiWxXOErTqk6niPg0SKtIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(336012)(1076003)(36860700001)(36756003)(83380400001)(16526019)(40460700003)(82310400005)(426003)(2616005)(186003)(2906002)(4744005)(8936002)(5660300002)(508600001)(316002)(54906003)(6666004)(356005)(6916009)(86362001)(81166007)(4326008)(7696005)(8676002)(70206006)(70586007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:20.2515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8d617a-202e-4300-2b82-08da2d40cf31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable Interrupt Handler v6 support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c8ce9588665d..fb30c31b5d92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1556,6 +1556,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
 		amdgpu_device_ip_block_add(adev, &ih_v6_0_ip_block);
 		break;
 	default:
-- 
2.35.1

