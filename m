Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D6AC54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 08:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CD010E075;
	Mon, 16 Jan 2023 08:21:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9E210E075
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 08:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo8Oko/MXDh92xFMouxXALxjxjZfw6voF7hbUgw/o3XSuVeZTOMUvmJRbsJ95r30LxlBwUDmnppsgIe8MNL7X+GRvmX8rnnyfN7ZQadl6f+3EDSBthPxJcAZBWtWO5oBsFOlwMl8G7EM8hdBiH+XK9m72eAugAYiYIVMoZXlxCUJ2JxrdIVirYFTIe6eTbykFw1i84sl1XQZrwnNAP6gflHsrP9RkD4qnod2QrMrtnxaLZSzZu6dUR2hNDpQNrwDUXJxWwQ6Xnivs2Vo0BRVeJL8Q3D5U526WmIK5CVcYNxPE4rRtfAMD6lUjha3DZEeY+VRxue1DrcNsNojg0G4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRaPMANqBHWVYsLBo6ns6nBUh9LuSDfvk3nC9TgRvhg=;
 b=KTB+AIbnAJIQ29cX3vSaVSIwwrt8QBizWiON6nFCoZrnpSeSxwcUcXVpG3s80CG0xNerRUr0RduQXLFnhB0jD2xSlX/+tmL9D8swft/Y0z9w7/MkFDnQc2t4g+ftkLff8bBx93NKBtwmLr131ZnQrG/i+F/J1AfW6uUUi301g5P9n04rsNyNVRkDi99Hcdwp9lgqqNqQdNuMVf1cjfN0O+0WbD94l2ATQpf8U2hIxarVDvyvRjeRpudOk0UV1SqRYMBRqPrVv81bJ1IO8oubXfTKQP3AXaMztlAdu1vOYYLVinwsRc1ZLPV1sEhVe6PxWxcEoBp+j/RGK62YgQZZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRaPMANqBHWVYsLBo6ns6nBUh9LuSDfvk3nC9TgRvhg=;
 b=fFcTmLvunipLR247IMLd0wbBlAK7kMnIVxIMxarQqrydTcnulh4K6lUbysV8zYa0MP0PCHuCc1Gcte7TN+N+TAyl7rJE20XO+DhGOLNu04qCX3kt8AtsCTK4UAxxhKyzPtiVxn6yqohsDEJJoJ12VKw+P1WZC/NKSnJsb5ihPPU=
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:431::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 08:21:04 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:5:134:cafe::36) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Mon, 16 Jan 2023 08:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Mon, 16 Jan 2023 08:21:03 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 02:21:01 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: allow multipipe policy on ASICs with one MEC
Date: Mon, 16 Jan 2023 16:20:24 +0800
Message-ID: <20230116082025.2188409-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: d139eeee-d83f-4206-7f07-08daf79a9bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+83WrcdqSn4O3XhFeWMNGm4tpGVbJYINMg/WH0HYzRmF2JrmhrLHT+rPEOk7GHIEpegXAHOyhl+BCW3ssOyFGEy28EgD1vJq5H8MuY7dFBgMXeQIRANgGeKcsQzufcwYceazmIdHBhK1y1goCzRvWSL0szq605yKO9qm0+qst+WsftajHeamHTGbpqXWmBHIRu7NUtCvOqlf1ux/MkyChXpoyEFaTl6tH5HOE9QexGpv42sk9fJVi4anyFltgeli2fzaU8i1O6a3SIpfiLLNuuHB47alDLHAy7A9YRH0EIaBQJ1n+HeGRVqyW44JkRvIv98NxsTI+/p7ZyZlpIHZK92kBLd5RUQb032pje51PoXe8xYM3aSukxKnU0a8wf3NnpumOxMUNp64XB5lzgoqUXMtydYpNY10DYUpNeYVEB28DrboTsbLy7/DoumtM3GT5nyML8sVdDte/XoNgMKSsp+kfKdVkrEBA7E64OMQFbsESZ4v7ce8n8rdFTBuZBV6Wc2UQfXAYN17lZkvxLVg4Yeiyyryx8vUSL0kly/INIcrPmdyQ59dq62YH67MtQXrcSVHuYyGfp0j2f6MAw4kLOeyLgoDNcjb6wPiWcBMd6dmZwrJaZbtAC8raHcntiUzVl4RgH8sNhiqasvD4BHZqjZNB8P50U/IBCiHcP6HEebZ7QVxIFQY+h/6uoEZdKI4mdL/u4aw86/gOUSClviqTmCLMrOi3Y/FECXpai5mjU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(36860700001)(81166007)(5660300002)(356005)(86362001)(4744005)(2906002)(8936002)(4326008)(70586007)(8676002)(70206006)(6916009)(41300700001)(82310400005)(40480700001)(16526019)(186003)(26005)(1076003)(336012)(2616005)(426003)(47076005)(316002)(6666004)(54906003)(478600001)(40460700003)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 08:21:03.9474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d139eeee-d83f-4206-7f07-08daf79a9bfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Always enable multipipe policy on ASICs with GC VERSION > 9.0.0
instead of MEC number > 1.

This will allow multipipe policy on ASICs with one MEC,
e.g., gfx11 APUs.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 42a939cd2eac..dfd8a0ccbc83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -156,6 +156,9 @@ static bool amdgpu_gfx_is_compute_multipipe_capable(struct amdgpu_device *adev)
 		return amdgpu_compute_multipipe == 1;
 	}
 
+	if (adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0))
+		return true;
+
 	/* FIXME: spreading the queues across pipes causes perf regressions
 	 * on POLARIS11 compute workloads */
 	if (adev->asic_type == CHIP_POLARIS11)
-- 
2.25.1

