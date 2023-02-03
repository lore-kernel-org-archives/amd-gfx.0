Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADAEC61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 09:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3D910E202;
	Fri,  3 Feb 2023 09:41:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536E610E202
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 09:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH3/CQh9zJaK029yX3Fny8uGuMec9m3uCp1bA8fgF+vhSrH3keIwBe6QXEaM2At/SbYFnwWyoClF7sbXBr3hzlZLh7W72TFrEOqZqbF+775VdD5vzUF10K/e2iKDV7rHPW3BEaGZYF1PmN7LklRVxOmLZYABq+tdzJEMcFBmekUBg3UOuH0y6qQbb/giv4FPV3OS9ja7CRfu4MFDKHx4A+vZFmoTrOAaDPx6D1oYMTgF0OT3zHQb9fWkjWwYS1RVjaLiNMUg843m0avgPVGu0QPEZhFy7H/020wF5qRxyL9VsQDpjAOUJk/x68u8C019GuTqZ2i4dTqHpdan3uG7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljj3bJ/g6ozEp6j8cuZVu1vmXTd4mGZesPhqk3r5WQ4=;
 b=Fm2qqp+LQAM5jGcF4h82Y2fX2pffmimE7NzH5MXMgA6J//yfXTZGMYn3ppnffWW0fTJ+uRUO+h5FNvM049+QQYnEKuJitM77p9ii3f2H8ZrACPVqjDCeSbcJTGkqa/UECp1GtZAf/gm/yw0RbNVgJtfDwmv2C6u0TvyMRYqRbXEQytr7blDGjGhHVHVqjyouTk+RxmAk5VWgEuKAZDUn6R6xfGFR+4OGQHvLDV96rvM7RlciSE8kaZ/rE9MVj2lBsWTdNUSJW36dPyLwYRAWDg5i6YN4C/Hbztq9IIQ8HsE8bj29xIErVd9P3rgOGORu7vgxqe49dCE4reYVl2rcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljj3bJ/g6ozEp6j8cuZVu1vmXTd4mGZesPhqk3r5WQ4=;
 b=2ikYEoiGkwbk2hTL8Kg2RrHWkT27xJaf4EQlaOB8+UlJ8hXSKcoVcVN3a14mAMShQVZxVlznlQVpwY0eQw1YcWTNZKG6rX6VGGLipg+o3BoDVjw7VHUPhANZklFgBAdiajyuApQ15zu6YrBVUO6mOfHlc5yGQnwmwySwYxBIgUI=
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 09:41:00 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::b2) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 09:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 09:41:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 03:40:58 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add SMU 13.0.7 missing GetPptLimit message mapping
Date: Fri, 3 Feb 2023 17:39:28 +0800
Message-ID: <20230203093928.3445781-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2be0b8-b30b-4af2-d5c5-08db05cac259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNu80qkUQQpb1XuoT/5IW6SxKJ/vAuvzOTB3ox15rAoZ+4zILeadQpOXzmlH2BzS8z7soXpCGh4sgeoNDMNDC6+jt6N8vhLbqSWOGC0c1MLreU60kFf4orjcd0nuL0y+aYfWJtvAAoda39pKuaFUvHIg9XdzZsqVeaRvPkblEvsEQcULOq9Y81O/nRFI4Bod68wlAlxHmYACd8qjrCVxjvjXe3QORQDXWqVaSmKiRvs8G8bH2AH9Ak9wsl85wLgcRw/Hc5huL6FT3OkGPe5c39BdenPeUiWWluF/1t1BuDrbQht+5tKwvQfW+z5aAkR0iqGslUF9KC0KY2D7HK1L5XSreF/Vsi16hRtjaTNC70Lvpblt9h9InFLcP2LqtP62NuwvWXuIZSm4nHQNIuWjXrDTuZKoT5qWTd5pdCFVoij386iHIJMSwFWvgEAIdA7DuSsGHzZdSz24EXanQrhv9stgviweKQSR7o7S5m82FA2bXZbuZdUfnJtLAi1Zm7HO9Vkt+5Ap7CcaOiE5tgKPg2xJ5IHylknsZexnsPkhyN71rr36IG1N58zyMK49JTJgyALLICf3iwkOhi8LLHblXkYBs8eAB9/27AMDqngJ/p7F0FlB6uIwmTeNOI/wEMDUdlXM4dszUAwZeMrD32nOjTKOZRY5rOicdKnjY9pXv7UyOND0g4yrC81Ydm7rIOGR0hyQ8yM7AtvIpwzH0fdkDkMh6rc2fnN3on2GebKU1PQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(36756003)(2906002)(15650500001)(4744005)(44832011)(26005)(40460700003)(186003)(16526019)(36860700001)(1076003)(82740400003)(47076005)(2616005)(426003)(83380400001)(4326008)(6916009)(70586007)(70206006)(40480700001)(316002)(8676002)(86362001)(5660300002)(54906003)(41300700001)(478600001)(356005)(81166007)(8936002)(6666004)(7696005)(82310400005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 09:41:00.4475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2be0b8-b30b-4af2-d5c5-08db05cac259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing GetPptLimit message mapping.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ic4edfa3153988721a6ee66dd69a1d4ca8a5ea45c
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 02ee248899c0..6a882c4f7cee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -124,6 +124,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
-- 
2.34.1

