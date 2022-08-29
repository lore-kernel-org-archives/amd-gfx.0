Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872B1ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B249610F362;
	Mon, 29 Aug 2022 15:01:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A3810F362
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 15:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnhDmqN20wbJfHyu7xroo8ACl5PYy58gH+XVgVI3/57udXXO5f8ADNgWxpvnROd9sdRRRblKEMrRM6ZIcbcBQ6DyZIAWGdlg+AKZl3OVoKjSlpyy+e2UR9AIxtQ11aS/wo2tOAry7ncfyhfvBsTKe4gnmg7Fiz3U9E4Rbp8w50JLSKnFrOQDQM0jE+S9NWlL6OnD2OvwaGUi+pdAksTJcvRU4gjAR9JydOwdIkZ2xicrJ0JRt3+rFVVR0/T02uYirTzwvoSTGPclJaBZnkjVo1rt4PdISDPFyeUOdmOwF0Rl0yPhpCdnC9mftdmFxk9fy+09EPjwKV3O+FHAnuLbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gxfg8NWyAayTOwFxXDoLM1kgGarTWlboxvfS7S6GGA=;
 b=Ko+gXViNEAotB/bVd13u/RMIBycIpn7u/6feEHH89bJevyqGXUaiyMsvVsy1JcgmEnc2nagE7RlPfd9HYx7r3zVImEWIZ0UNxeWLaZAxcDco7PngCR4DTQR/TZbb2pE2mpF74J0emQdHGNcXr7h6jFiQJqFcIuv25KEWNWmJIs2LLituIF2DJJmtJrUzWBUq5jl2E0tZnj2Ywjbj8EJ+54cHu+Y3rWLUtXiPXulhZ51uhnx4I8yixfPGw+l1YE6Bs3b2qnbqDBr5v5wc+lxnH7su9AsvPspFIR/IJFz2J1zxCpYaH5HQ4M4iAyapjD/KFnpcwMZygIHAYaoJgKs3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gxfg8NWyAayTOwFxXDoLM1kgGarTWlboxvfS7S6GGA=;
 b=P94BpuxD7fWe11bapUmnTU9gilgVAjEB6xcmH/KwoxeVCgKDIuQHrV6bIQdLcOQ61SD/ehctpv9Nybor6UU7hz8BgSoEmZkRvEnjhvr6HS6D+TOQmN+L40I/jcalO93fSEKbCmH/oizMN2QSURjoY3OsVIbZntRaEqkkVrYV/oc=
Received: from DM6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:5:bc::19) by
 MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Mon, 29 Aug 2022 15:01:32 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::e3) by DM6PR13CA0006.outlook.office365.com
 (2603:10b6:5:bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Mon, 29 Aug 2022 15:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 15:01:31 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 10:01:30 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: ensure no PCIe peer access for CPU XGMI iolinks
Date: Mon, 29 Aug 2022 10:00:52 -0500
Message-ID: <20220829150052.5913-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c04efe15-b5d0-44c4-eb7f-08da89cf5bc8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mv3PvNYpeeOl8TJoCTPN/Jxb1+bXKF/BXqIMp8XVWoD96N9BHZsldRtv+Fq6PjNUoqYoB0zjtEaYXwNvAhNWZ5zzakg+J4N/uLFTzfinD4PPNYiCTkW8B84Aurfov9R1grmYVseEWB0tP9PJmr+fOh/C+KPA/lXYzDSKcTUtbr5uoP4bcekZCGeQsgH5WNF2b5lJ3BTCCPT4EgOUik92tLEgeQ+Szh0ciFDKWbu4dN+syFhehaXaHIiDcXFY6r5f5pd9+8M1WfYAlqppzWgCMCvbJ7oz5m+ztYrFf1FuYasHjAONbKQ2un5+mNxRskBY2gwYUPwewCGxo5X/BtQrzb43Gu29wuGIo1vbj/a3CVSVdrqL9tkiZ24m9UgQqJQV7StaZKXEabyeWky1re+VNWX82/fjYzUaHZEDsWCRluGTGTF9z48VLmw7xY8qW62AJfWqlpq8ZGzDk0szU9Q7LjAJ3agsBIDRLu+mhZenqouHsaQ7J9kvzC3SH7+wlBW4E2bpYSqOHGWoy2FFGEYuwHQX6SSXicBgjeNjtItdc2N5nbxbqyVXhrXmpVve5Ptq/egoFRmkBKElztKumXCi/XPUz8m1c9pCXHKevf7488p5laMn8C9mfe1vSOouH+YEUSkcZ0ijrDL1+Xcz0xyozGp3aAFYtaEa8k6feA+zGOlqLEEBV9KygbjIHQa//O2ySsVu4FDXBC+okHGTeN50e+E6CZDCGza+ugbuZJTAkiqX8D2obs1EL1clcPEbFU9i8HkGbaWYNhWRZNLKppJ1kfOs7jCS7tpADcDDa7Dt1EwNII+V0mIrtKqa/cgur5vB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(82310400005)(40480700001)(36860700001)(356005)(86362001)(40460700003)(82740400003)(70206006)(81166007)(4326008)(70586007)(8676002)(41300700001)(8936002)(5660300002)(478600001)(54906003)(316002)(6916009)(47076005)(1076003)(186003)(16526019)(2616005)(2906002)(6666004)(7696005)(44832011)(83380400001)(4744005)(426003)(336012)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 15:01:31.6538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04efe15-b5d0-44c4-eb7f-08da89cf5bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
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
Cc: Alex Sierra <alex.sierra@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why] Devices with CPU XGMI iolink do not support PCIe peer access.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ce7d117efdb5..afaa1056e039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5532,7 +5532,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
 	resource_size_t aper_limit =
 		adev->gmc.aper_base + adev->gmc.aper_size - 1;
-	bool p2p_access = !(pci_p2pdma_distance_many(adev->pdev,
+	bool p2p_access = !adev->gmc.xgmi.connected_to_cpu &&
+			  !(pci_p2pdma_distance_many(adev->pdev,
 					&peer_adev->dev, 1, true) < 0);
 
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
-- 
2.32.0

