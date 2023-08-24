Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9365BC27C40
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 01:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C891210E4BF;
	Thu, 24 Aug 2023 01:48:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E4110E4BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 01:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnD8IA5QvnsICAbaVBBqjc/7dmHfXgnpE5dGCQEy+NUxP0Jf9LJG+gk+9RtmTsEARTO8x7FBTgDuYCVy7Zi9jbbKUwQkyFsIH+zzrrtzCtMqc/vHS0C33ll8jAPTZSd+RWlg6DZSDe/SCeomxAZ9W7WM1z00epU6Cs8St89249ge7p5wdxXRilDTcNkAGD13BwC53AgvzpmojnLib0/sdEx7t6oU8Ge3rJ/mdtqbb1hrB4rQ+fNxQFT1mRzBmJq8bh59UUsGI6v7Dxqo1sD7soI6LWq9jqCqkqpaFG6BriE1s0wwcEiLgZJe+/TEm/ZR9v2MAiXOYtI+U3TiBLEApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOp984AYSNfrmlCCgMt5I09LARqvk2Y8WSdcviqvqQM=;
 b=V5F5zEbusEDF5XGBfMCSp2b2KSJ6RLGjpgigOqkdce5S/6dNLX5hYokN0vCiGDXCKLzC+qNArjmx0v2fWD3mqZxVnTyH6+zXTJSFjruVOmKwMBCbxkLrQIEInfNNfEDrLf4v6q+s7yo8A3WaEgDtAvaE9uiO9QE1BpnmiHpuFl8DYngVuhVs9XeeKHgJ5rtCqoaqkddmtWydqldryvq7BX6/lMajuUl3iWVDFqdkzhn3E6nv15Pcz/QaaNjy/zHWpsw9WmhgpP3FRR5ZatuHXB5NY8/Mvw2s2K/Su93EXi6gh+IgCtQZWFLwdA93jmazOTL3xTj1TlTv00Lki9kLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOp984AYSNfrmlCCgMt5I09LARqvk2Y8WSdcviqvqQM=;
 b=I3+sHLaYP4ztd/H1kfhVSrwj6XC+3LoMHUUf/Ug9mB19kQ0teUIylx3eprcHknnYh7VBxXisXJjKtVWQRnIxYQPZxBz/3bz7HAlNYnmdhL/F7R5x5xhIOGr2yr5Uy3a+nEZPEcQVIpnI8mHXmcVENCvcHw7pHlAnhGZcKXX84rI=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.26; Thu, 24 Aug 2023 01:48:43 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::bf) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 01:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 01:48:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 20:48:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 18:48:41 -0700
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 20:48:39
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>, "Tao
 Zhou" <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Allow issue disable gfx ras cmd to firmware
Date: Thu, 24 Aug 2023 09:48:36 +0800
Message-ID: <20230824014836.1404-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 890d9689-a5a4-400c-950d-08dba4443ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBhZVjIS4jP5P4ojnIeLVGVVAS0TERHtOiSdWJ5gIakQLDloWB1R1xSzosxwMWs8hlLq5+jYWkdiHO3h3S71YALCfihwG+MAqDcdJ87p3KrNZVHxoRmM2nUX/w3jkyGAb1ohosAzZCjTwLWiwHdy5zR5t8b2N0IOuSsjKiLSlC6P7VmyZ9Wn7FJ7XENc598mdI92TQC06pUw8jThtuInDnvdAzkqP/a+E7cWw7p1o5dQGUxAj9agKNElI6jJP6S7abb0XEu4WEzzqEeKw+A39N+rAvQANvCtm4c+uTMYrdL73qoBFZewC/KebWC22QfBtgNi7P+3RRfPw45/SHwjGY+xhzH+Ay7tgmUZYCYpfzUF4IM4OrRIJODVO+IRfxNjPrW1f1Ah44p9a/k1ZVbJQmC7j2ImjYYsgi2/Q0lvmTsy1n87roRU2GB9wcf4Rsi7w5M1qVioql/UT/0gmy0SLJ2ULKJ4LKpGlL7uBMMP6oleNnaxBCBSiT/x1jL2P4ck4RvafPrIHH6lStzi0I4JqNFKODNOi+IcVEzEhAXFOPQsKLZAg+C1pnXdlXkElzZS4fr4C/d+ENJqAk8fK2wPwntAlQ5EOM4fDcM8OnMM7PMnD5vugc+Lyc+kwJ287Y2PUaQsCujwZAKrT+N1yGfswN4XXcF9bHzhISmT0e6iaXFK5zXt7TV5pVtw91VrGVc8K2VM07h2lzVsHh8X+LG7P4e4KX1s4euZTr1jcfe136ZSdohU0muaqRll3b4PMZTT0WkBqGdN9rcA6+FRMxmW/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(70586007)(70206006)(110136005)(5660300002)(2616005)(41300700001)(6636002)(316002)(4744005)(2906002)(478600001)(86362001)(8936002)(8676002)(4326008)(81166007)(6666004)(40460700003)(356005)(82740400003)(7696005)(426003)(336012)(1076003)(36756003)(83380400001)(36860700001)(40480700001)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 01:48:42.2180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 890d9689-a5a4-400c-950d-08dba4443ef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable gfx ras command is needed in some use cases
like live migration.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 378478cf9c21..7db6baa16236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -769,9 +769,10 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	if (!con)
 		return -EINVAL;
 
-	/* Do not enable ras feature if it is not allowed */
-	if (enable &&
-	    head->block != AMDGPU_RAS_BLOCK__GFX &&
+	/* For non-gfx ip, do not enable ras feature if it is not allowed.
+	 * For gfx ip, regardless of feature support status,
+	 * force issue enable or disable ras feature commands */
+	if (head->block != AMDGPU_RAS_BLOCK__GFX &&
 	    !amdgpu_ras_is_feature_allowed(adev, head))
 		goto out;
 
-- 
2.17.1

