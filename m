Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857FCC48260
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 17:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F034510F705;
	Wed, 24 Jan 2024 17:09:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379A610E3AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 17:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGm3HjKbuNlUjGyN+hb9FJIjwfSndr+FE7gVYjC1Jk27V3ZOlmyP9aRLC/44SSU2tV8x+P+Mj02HbLcSeP4kha7aEfcjj31ztJGQP5v2QLXhHIZLiewgtOezlkGFfS8BTae9aZFflFUIfT6iUw5ydaIw1nNkfZOoaTz405QN81tSmSmu2RdPyU+0IdBh1ecYhQ9luCxz9j8el1bd9O35UaSIwzbH1YVaxBNyPF6XF864XtOqu4+Y57qaIG5fSJPnuFIAVBXNS+FtTqJ4TFOjWqoEV2pSIxZFp/hX0Vabj9QKs78YkVYrSJV/7bG97Ycc2WHmD0iy6z4ULfJ5q0JfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpixirp6ROWWrqq6PtrGabSKK5byw3dCWaE/WI85YW0=;
 b=GP9Z4qrMKSQZxZkzyUOi8/m5i8j7+CT12MHHHq06ciBbHe7pCSsANa5/sKwtZ6sBqPiFC5HgYQ4VxUA2K7rysPC1F+azRkxTeiJOBZr75ADe9gfwayERvL4P9vgkIUV1nOtUKHnZzf1kcU5Z5NYJJoKtH1urwMztGoe7Tap6SJgM6YmfCzRbpChNy24riXjTQE817zqoH6J3LKGGdHAU0wbm7YOWaL3E1lKrWhX2nIQGIVZU5xSEzt4FFnPfeP5GQ1mW9fmSXxY4yfYOxkNVd71Evf3LV5q+UiuyLmJguRXGRmX6xPcg8v71siVUo7YPp5o5k/JAJWBVgphl1cvKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpixirp6ROWWrqq6PtrGabSKK5byw3dCWaE/WI85YW0=;
 b=4IrEa99Zkxfoc7A3vmPdQQRrmC97dALTwPRYYnvluAXJmwY4F9/6TRoIcVu2X33EVKIfYGoLI6QmSw7kkOBu67EiByeSmKDWl4wpVAwjApmEiwG1UsmgiJRKulpVG6zox/UntDadjaMVcUtG+hssltJ8n2tv16FYkFTaX4yCjHQ=
Received: from BYAPR06CA0049.namprd06.prod.outlook.com (2603:10b6:a03:14b::26)
 by DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:09:22 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::17) by BYAPR06CA0049.outlook.office365.com
 (2603:10b6:a03:14b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38 via Frontend
 Transport; Wed, 24 Jan 2024 17:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 17:09:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 11:09:19 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 11:09:19 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 11:09:18 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <mario.limonciello@amd.com>, <Aurabindo.Pillai@amd.com>, <li.ma@amd.com>
Subject: [PATCH 2/3] drm/amd: Add a DC debug mask for IPS
Date: Wed, 24 Jan 2024 12:09:05 -0500
Message-ID: <20240124170906.901841-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124170906.901841-1-Roman.Li@amd.com>
References: <20240124170906.901841-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM6PR12MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 0644594f-b7cc-4689-7f16-08dc1cff359f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhgueVNVnG+dMl8omZEiWcC214kWAHxmB47ng8j8n3KgIzBcKbHAjhTvdqS/sN8twgBdrvj69nD56+8rQgdqUQwKXORcp/fdTlJxGhoeomLxpcL/0hogOLbZR0WUk1KxxFs8Q1GKPagXwHksH2moS7P4+sMbPc33JD4P8wgkfEgfnjerZB1/C16K3nKHXvim/p5SagVfXlUPTzpsJX+s2GlIX4HrLroXleoomvBT/O8sW3HEesHbT3TUfh88dFrBIVWpL8CDkJoWIl6sqhp5emh4Jp+ZNe4HVcXJc1++AGwrvbqRctE/J0933eFJ28to+jwZnQTASulmMdArHenyGZbizuWKoQTqHi8lQGwqTl/7Rk9E15zly7wMkzHfkCjh+QsnJRKXXueH58ShVjRFb/UOZK0gKKhR4FbMfsO3aJTkwX7vHlChsBvgSBP+43RoJuccKOssDqvsp3p3wjoBE6KtcIUfGZsTT74ItlSRfRsl3vP94p/JeU4NUDXuseGH7sTkfgmxfJOvPtQoVdG7gUYMPdSyqREr9VKacAEcXrAbb/FJbH/4zwUfdm6l4RcRZzirnCz1LMeBsiAPoUzDCVdYa9UojBjgeg0MO9Q04I1+RqJZxEyEFpCuAeRTlBq2x/MFvkJ6n2hubtksExThz9DwnZSXu3igB6i4zSXsB2veHr9Fzc449ZtjMHYLP4uJeQpThhwGJd2Kaoi7lwYWBtdNBi/dHxM88eaBC1cfxoxPmA48I7+llsBH/7ak1l0ee+vtqi7NdnprT4Vs2OWQPtntPKhPZMTyt4o3/M1WcOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(1076003)(47076005)(8676002)(26005)(4326008)(70206006)(110136005)(54906003)(356005)(5660300002)(316002)(6636002)(8936002)(86362001)(70586007)(478600001)(2876002)(81166007)(336012)(2906002)(4744005)(82740400003)(426003)(36860700001)(2616005)(41300700001)(7696005)(36756003)(6666004)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:09:22.0401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0644594f-b7cc-4689-7f16-08dc1cff359f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
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
Cc: Mark Broadworth <mark.broadworth@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 jerry.zuo@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

For debugging IPS-related issues, expose a new debug mask
that allows to disable IPS.
Usage:
amdgpu.dcdebugmask=0x800

Signed-off-by: Roman Li <Roman.Li@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index da9b670fec86..a89d93154ddb 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -259,6 +259,7 @@ enum DC_DEBUG_MASK {
 	DC_ENABLE_DML2 = 0x100,
 	DC_DISABLE_PSR_SU = 0x200,
 	DC_DISABLE_REPLAY = 0x400,
+	DC_DISABLE_IPS = 0x800,
 };
 
 enum amd_dpm_forced_level;
-- 
2.34.1

