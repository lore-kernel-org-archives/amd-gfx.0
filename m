Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9C4C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 21:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B1310F508;
	Fri, 15 Mar 2024 21:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KaeL6idk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8EF10F21D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 21:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrOce4wNsz1WSl1TeybCdS2QKYz0IPMAqFE+p+P9OhQTlkUA4sNjEedNPNzzW16wASAppd/P9ve7k1zT1SJf/6srNjn5AlpUKDpgU+vGyIWc+VDxPTNqfb3niC9x4I8+8j583WZmPH++x7Zc18YiXoK7/I5BggcTTftzyYGREV2zWZ4fU5ixQmbMqjhA8uX35y39vu6Yu2uqilrAUt+hwUczzHkk6QH1l6x3eN9jZiYSYO0pWwC1WZa6GBQaRZhosA6SS4hlvVkA9rw1f6R8lNXcGJLkeEDvbi4HMa4Fm6gxcptUMVbO6bt4BZaDIc2K3HOs9LYeVgQM1JfHqq5Vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkcsI+np0kgAqEbpatS+YVEYlen/DJL43rd7Qyoz+JE=;
 b=FLsYRFFVs1c4hVwTV4cQPo6gaaNhPWW81zbZqxlIhfgNZm323sWh9YZCgL24Ug0mud30m6+5kTXuZ4L9y5o1cah3ptZqgedlfQeH8V5OjEZT5aX5ryX3GsicpoDHOwDqnX8EjIS1VKYHtQHWmns/k2eb+F5xfe9OqbQwoszlSLMVrXGCxbi053eOSoXm1DiRKYku406ixJTchbQAYsmW2ReSiiPThgQjJl0hc02m1olitzAGzFbFl2UxZ/MgX36hAZjKyijvWbeiU7UeMRo4DdmpS29wgK5LxIQDazQQ+MZc6D6KbPybZ1o8qv7oHi8xeNz4j9+sq5mJR0Y7WAGoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkcsI+np0kgAqEbpatS+YVEYlen/DJL43rd7Qyoz+JE=;
 b=KaeL6idkVV+ilbSEpq9V9wVcZNNyuMS76BSFV3x2v7LYgGcDXIzEUaxZxSlaQNVcrRSY42Se+AinGkGprakvPVJKAJVlVNTnHBYzOKhM/pOcv0t0DAQQEUuq/5H/hqCqN/JXdN5yiZiLRYmEgfQX/mnBeii02U7aR3XO9bncZ3U=
Received: from SJ0PR03CA0136.namprd03.prod.outlook.com (2603:10b6:a03:33c::21)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 21:11:36 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::4a) by SJ0PR03CA0136.outlook.office365.com
 (2603:10b6:a03:33c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Fri, 15 Mar 2024 21:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 21:11:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 16:11:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add support for atom fw version v3_5
Date: Fri, 15 Mar 2024 17:11:18 -0400
Message-ID: <20240315211118.3764274-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eae6864-9457-4964-e163-08dc45347f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o08OCtvaTdYju4+XfJPD/9cudbfMCt+sv/xxeE7L/5IXxu+sjgHvf8yNmU8vu/J6nLNBpTCG9jPhNhO9DDtOkil0Qi8IZQGgib62oIHodzrYt7Hng43KDp6ckQDLmdxjvUssGK2LpHvFIhnReZ0ZJY0JhNyQBsJIx72+SQwW7XUqaMgAA2kHn4bIrlufkJBdjyMCDyZ76XEK0al2yOB8u8ObqMKi3Gs/we/2s+pT2ioxPaBSFlUbUsCLlKoa3sNax9+z8ogsiOs0CczFFoLdOBz/yRqrUYpoTPifxZBE5ZuuhehHtJ/RiEAy6ZJx4qjzj4uMVQIQ848uQxM4LED1T35P+Rfv7kqII/UnM94im832+bTb6WZ3cinZM1tFJ0oFHKZ5IviXKZdqTdY2NVIdfVbHDWZodwqOHQYZu9yaiRq5kwxyERwo9CQ12sM0ylMZsigfTpzuzJCgfF2r1SWgs2kT4cgLijot793k/JqO4LEE7Vjznp3xtDpoJ05nL/JwHCU/sboveJQhkk8y3a7FLdnAsVhoVo987FLqArnDopd1Q8RtuluhPyVRpnz62vxlHxhxJ2Y6AnboU7g86egWwFz/tHcb9KI1XGrrcaVp4fmnkg7v1v94p5spBQ4fm1BEX0c/j0FmnOPpR9l3ZyHkmrSaBL87ZM4+ddxshKk2Q2Fky3kKBuTOk8KzCy2YzOl2n0HFF/wIJjHqmCNtSog8LoLa6nkNOQXqpctB4IG+ugVaFS26Gm+Z7At/KICWyuqv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 21:11:35.9950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eae6864-9457-4964-e163-08dc45347f97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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

From: Likun Gao <Likun.Gao@amd.com>

Support for atom_firmware_info_v3_5.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 6857c586ded7..a6d64bdbbb14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -34,6 +34,7 @@ union firmware_info {
 	struct atom_firmware_info_v3_2 v32;
 	struct atom_firmware_info_v3_3 v33;
 	struct atom_firmware_info_v3_4 v34;
+	struct atom_firmware_info_v3_5 v35;
 };
 
 /*
@@ -872,6 +873,10 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 		fw_reserved_fb_size =
 			(firmware_info->v34.fw_reserved_size_in_kb << 10);
 		break;
+	case 5:
+		fw_reserved_fb_size =
+			(firmware_info->v35.fw_reserved_size_in_kb << 10);
+		break;
 	default:
 		fw_reserved_fb_size = 0;
 		break;
-- 
2.44.0

