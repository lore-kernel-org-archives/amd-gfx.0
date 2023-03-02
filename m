Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20628C678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 06:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1904810E383;
	Thu,  2 Mar 2023 06:59:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4DA910E383
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 06:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeaVEaJ2B20nn0Wki1bW3ZjYtezK2nEhINqi6F9NBkqGRh1kfQ7yugFKN8JkzoyU5a9a08O3dhn6k4eJrAE8EL9CrUO+zmaCFrs2Fwczjhu1E9Lf8Q4v5b5Seib2llFipnt1ZUqj4mUfcS2i2GaJZJcv5LrEV5ufDwzOv5CseAFCAoPDyl5K30H/CEA67FxoWqdVwZpZkh5bonVCFrmoJ+5EmBsa/kyxArEtyrN6gx5sabpqDawqFWjAswqZRgHZsSyubtahTsRYGS38vpE72cI6LpMRQjGGumWz76SMJfczP/TKGKWrgoY7DGTAcbpkcVQJYF5Po+BAIY+6WgnWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9EvUiY2QepS2HQ7hEe3p/MjVmiMVzK+d2cuzIephh8=;
 b=BB8Is1DecYph51H/tKIGJT9yWaG9Wm6cqH8DPu8Ry3Lah9LxWqB0MxalNHlSdS/44c7yxCDRf5v1K9O2b+fihGF4Tm+NrjsEEfEHTdhMoqFscQb45mxa2uCdm6uvP2rVdxhDz8ln8dDe3tCR6UZXuP5ddDX+R07eiDm0rQvaBJVoPjCXseLGc48Pcb49PopaNF9S1YWTHHNOFLP4VfG/c0YRQD0BUc9RDVqcxgmlOHy8XpP3BKE+3jnMI0Wi/a1ezT2+DfKi/hMQyjv33KuIm2mMtfu8d8AhzTr5Dg2TKM2Cn/so5Ijuq/J8PlRc1B773p65v530fItbQAk5PQHD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9EvUiY2QepS2HQ7hEe3p/MjVmiMVzK+d2cuzIephh8=;
 b=cfciMNosEGwtYbkc7sVS3KQWYcUJEbfENjL07t6YApqxCb9Hf7ij10qjBmsFIPCTV1Ba4ptwimxkCzjAWL8bFbWArefacc/oMEaoQCGanAXGkSUVmA4OolZAl1KxJF8TApYN207gOrh0TJtpSJDL0LsbXLbiI+OLs2u3AA69q1w=
Received: from BN0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:408:e5::16)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 06:59:37 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::9b) by BN0PR02CA0041.outlook.office365.com
 (2603:10b6:408:e5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 06:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 06:59:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 00:59:34 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Date: Thu, 2 Mar 2023 14:58:35 +0800
Message-ID: <20230302065835.3905147-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 844e7dc7-e951-4be8-e0e2-08db1aebaf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QflzdyOof2TuOKDiJGoG8aKH0iF9h3TH1m4zTM7VFmBTR1yjpBLY2He+ChiMmGjHpWU3OPpNotlIeStAAaXQpD836RXzVpXNJ82HELCvDTfkdfBHk/lYPMcQyFtmO4qxbTVxNuhF+gsDcfGoeQT0zkefEFy+yiRcySf8NqVpdW7kSB2P5++0xtX2BaoYFc5COMSXRCT4A4Bn1x0UkDg3CgC11n2M4VETMV2Rb5zrNK3uew4JRkOD5Sujm6zSNUIQ2ExRjoddhHymdl5nBlVrieiR9aP7wUtHCTOptj0rj5Kr2RegF8o4zVSJZCcQCt1qjxS1xTjTtFqWIFXX65cO44pkVydNjz0ujqp68mXtEs1Hb2CZJSLalgBb8qK3qWKdboU9ZOoxGhAEPA3LP90eyI96tA/Hp758uW5r9sDk5MtIDdt4xZNWEputsRC0DT0M87amZRl9ZP7FBjREX8uM7jZGPciByLpn7vkAQHnfY1mCGl6G3stUS2xz6QSirpc+YEEa1Gh8JZ9VDlKo2fvZUHJ9x3Kpf536URIEp/wZIlMN2lnSH8BXbUXrDU/1vV5XtrFrURym9wDRNRN5jHTC6r6MwcO6zigJGdoPd5fX8TkfoKavjmCGu324+GJ7dsv3vtns1XxRWWWorq8vyMOeGaUoMo58wuUHFwAS21tumapsQsxoVhNSzEabvBl9s8KJHs7y1J0Ze5vWHnO3I29IKyqsmo+W3lM/krLu1/QRvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(86362001)(5660300002)(70206006)(8676002)(40480700001)(8936002)(4326008)(36756003)(41300700001)(2906002)(44832011)(36860700001)(81166007)(6916009)(356005)(82740400003)(7696005)(54906003)(478600001)(316002)(70586007)(82310400005)(40460700003)(426003)(47076005)(186003)(83380400001)(2616005)(336012)(26005)(1076003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:59:36.7339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844e7dc7-e951-4be8-e0e2-08db1aebaf8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gpu reset might be needed during driver reloading. To guard that(gpu
reset) work, df cstate needs to be disabled properly.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I5c074c265c0b08a67b6934ae1ad9aa3fed245461
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 51bbeaa1f311..3c854461ef32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2816,6 +2816,15 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
+	/*
+	 * Get df cstate disabled properly on driver unloading.
+	 * Since on the succeeding driver reloading, gpu reset might
+	 * be required. And cstate disabled is a prerequisite for
+	 * that(gpu reset).
+	 */
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+		dev_warn(adev->dev, "Failed to disallow df cstate");
+
 	amdgpu_amdkfd_suspend(adev, false);
 
 	/* Workaroud for ASICs need to disable SMC first */
-- 
2.34.1

