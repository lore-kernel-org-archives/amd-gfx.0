Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979FCC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 08:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279D66E1EE;
	Mon, 29 Nov 2021 08:12:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5876E1EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 08:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFXqEjC2pp/R0952lb1Z79eUN4P4qNWQmC0OP+hGvjfAD7d3kcxBQYW7HE/k0OmzR7f/mSN6Xel/axrX4WWrp33zoib2NJAH61QFiNtoplEz/BABqZlfGpqWU/L5yNJbh65DzO0JINtdhL6YNT16RXisj3RXe1cgtIfHf/mn+O76ylHCyYJtG1UTR18IXuUomaKUuYuZZtGAdiqTl35aNoD8MWNazat7qqQgcHBMRRQDatrngMZ9PdApSB5GRItMp7llTVAz63CcJY/GNErQ3oY3ixVM/xhz+ZszXapZkyB1FrVJEgzTJJD6TvDYmX2FlWBn8SLDe1d48AXN/jStmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ5e8OclcbnJxfF7Zy2Ozq/CZ0wBymBDtZ6gJYa+hSA=;
 b=iet1tyQqu18OiqkXS+Q/MPIqKJ4H1rZbGX9rv0r3SKAxrVdbvwa0REyeQK6ZCX4q5lGNcz3m06zkAKPmMM1hjS6XrPUkAmQwtxepU3J3tvVhgc8m7EkWkTXP6P88XQOeekIxmohpJ6UDEFBveFjsGqvKrddR7E9Wvej6V6q2B3EXRTu7jjajgCNpB6ozUhbatJTePFhaaCBIwlGKTLoizfzZ/Y/ANRns0v3ux1fjnwJLA7mvqQ+EKqzDJF+EOKcevHgUuhBU7zNkx50/eB/3e3/TYqUWHJ6c8v24y38palNhskZZIqXn6cZx8d5gUn3ucOoySpYbej2XTxIcCtqnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ5e8OclcbnJxfF7Zy2Ozq/CZ0wBymBDtZ6gJYa+hSA=;
 b=u5TVHii89IDKvMYzOEeaykGnhTQVVxJE+t0BH9gFt4V7c/5im+KH+VtYslKsXdym5/7iZx8KdPwi009QldOLLwvd0On7bRRQB0aGbGsnEqZgqNesgAE+CByKo2P+WWB3xrMU26m5/8SaP8daZWPKtorvsEqNbWoHm/ec1DQURuc=
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 08:12:44 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::c2) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Mon, 29 Nov 2021 08:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 08:12:44 +0000
Received: from lijo-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 02:12:40 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Don't halt RLC on GFX suspend
Date: Mon, 29 Nov 2021 16:12:24 +0800
Message-ID: <20211129081224.156654-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3db158f4-c02c-4d6f-fe58-08d9b3100575
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53601B869EE5E5A0B3CFA10A97669@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:31;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akj7eERXxZl5Ig074A/GnJ462cAlrE7MJasi7aCIShBKXJOSvVCMzGw4YC/YcTOCyzQ21YV9uqXR3Kl0FD5futfszS8D6AhvO4kPO4mWq4A8DGwBuBgrri6vJimQOCfVXA5YUa7V4S9tx0m+Fydl0B5YkIBDPHqJ3SLmDYBTVrmwpHP/iDNXM/w3PUhdj91ciqtGsKIkG2D1U0J0muVA5Rdj7Kxif9EKEj+iH5MTm5ehjOjLd6rR2b8bNVZlebc6DZktFLFiqzgshnYPWay+PW3kg78H00MtOvoM8USndJ+Cv8ALhGKVlsIjDp4bYwgyNbLL2RHDbrJOOFA8ZAsIMlTpep8pXaTHg1STAH0NuMI5yqjWsJKBTDcKiEgVEeoO+txVz/ggkMszgvs1QGFhb8rRzUwCxdaIcoVFV2cRQb7bNBGzpoB0Pfi80XDRnRN79vnkMjtRnzrWy1fJrKf0SbzCTU5NFFQdi2/9AJMKCzjN8tW6FnYWVwp7MYd3EKc6P6gd9CKF1hthkzPX3VMFyzedpwrGiso+n9Lm7Z6jc7bwuu2+E5DtmMfDdYCuJRB+X7vtK03DMaen93w5vR7lJ0msHEt1HjJxqt+xfSxgrnbiJq4tuZ9xPOsWI+NqieowKUj3PqSWyJt4TRHYIo+BkeqiByWWVJ2CYNP7MD48B0yQAB2DhYvCKLYpf4TKg/wp/FkWG+/QHOTapR/yX9dWjxCdxqs4qvf62lDWvFbqu70=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(70206006)(54906003)(508600001)(316002)(6916009)(5660300002)(81166007)(83380400001)(86362001)(2906002)(70586007)(8936002)(44832011)(82310400004)(356005)(2616005)(36756003)(47076005)(15650500001)(186003)(7696005)(16526019)(1076003)(6666004)(26005)(426003)(336012)(36860700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:12:44.0356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db158f4-c02c-4d6f-fe58-08d9b3100575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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
Cc: Alexander.Deucher@amd.com, John.Clements@amd.com, Tao.Zhou1@amd.com,
 Stanley.Yang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On aldebaran, RLC also controls GFXCLK. Skip halting RLC during GFX IP suspend
and keep it running till PMFW disables all DPMs.

    [  578.019986] amdgpu 0000:23:00.0: amdgpu: GPU reset begin!
    [  583.245566] amdgpu 0000:23:00.0: amdgpu: Failed to disable smu features.
    [  583.245621] amdgpu 0000:23:00.0: amdgpu: Fail to disable dpm features!
    [  583.245639] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <smu> failed -62
    [  583.248504] [drm] free PSP TMR buffer

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 34478bcc4d09..b305fd39874f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4060,9 +4060,10 @@ static int gfx_v9_0_hw_fini(void *handle)
 
 	gfx_v9_0_cp_enable(adev, false);
 
-	/* Skip suspend with A+A reset */
-	if (adev->gmc.xgmi.connected_to_cpu && amdgpu_in_reset(adev)) {
-		dev_dbg(adev->dev, "Device in reset. Skipping RLC halt\n");
+	/* Skip stopping RLC with A+A reset or when RLC controls GFX clock */
+	if ((adev->gmc.xgmi.connected_to_cpu && amdgpu_in_reset(adev)) ||
+	    (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 4, 2))) {
+		dev_dbg(adev->dev, "Skipping RLC halt\n");
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ea99afb38d2b..5839918cb574 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1474,7 +1474,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 			dev_err(adev->dev, "Failed to disable smu features.\n");
 	}
 
-	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0) &&
+	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 4, 2) &&
 	    adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
 
-- 
2.25.1

