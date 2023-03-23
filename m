Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4699AC6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 08:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC19A10E309;
	Thu, 23 Mar 2023 08:35:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4810F10E309
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 08:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCMPqnXOr04UQ/37HQdOOoquMEfglmWD8IiiZ1935X11Vmb4v3wL2QkBKo35raXk1kHACw5uC3g+G8FCsg88PfsCfSgsfyJKP2N1WMx5NN5FmoLLV9UigjHfPuEU+loOYm24cbHBmxmvdOqcf39kthWzMi7EPwjKOK79gvxVm9+Lpixuql1IhMEFHhZn52BpYX69d93AoCuBsrcG44rvZqU0WS5kemHrGs9ni6zeY3Yhv7wAeNyBw4Lx0+r7LEgtgQMTxcK7asgweoEmwgKjK4WJTNlaX33CvfsE5XYklrhJ0dT81JXBbBSCD27lOJYyNg1jaofRcYXq7Lko//Yv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYZCBTY8Qn46X6ruQ1SilRz0XGZqTp06sQPST9HFqkA=;
 b=RUcxJmUDG1UpnF3A/8wc/f4fQKTqLsXbSvclR8/zRgM2tP6laRGnhH7LqKrMgNQhMUSFazRhJo9RWFNTIfPnzbGUdmcSXmQvxQhsDZxPZo3Ka5Z0K9D6tZ8oSJy05rIW2Q2P3jLYVSneq0BChPgD/iU5kU/EOFx6QNbDKoNlmiXKD2nVsPg/w5sOukQDDWKMkUBncPDT37384QCRRspdWaK+cUFJlOJ0HR6b6uUS3RW1cZK+XDdrAAfrx3KUzI5T/CSaVTCopPOGadnXx9qvQXECg/zLF2S9waUdxthYnm36mZxwU64MsisX4GOF57qtTjpnwrfV7J3VLchu3/oY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYZCBTY8Qn46X6ruQ1SilRz0XGZqTp06sQPST9HFqkA=;
 b=PjnPNeD0gPmmnQLU9FAyMx5GtGFQVG1JW/0t7RcX+uqlhY6IW3kwtAjpF15vMwYMWyBqhlFjyz1ihERvm04NabVZUOQYqqh8dO795uYlxMi3KxDMIWP8IIs5WUNmTw9gGtAccFW78UUuzWiaXz1MFdrhD9xTidlmOBeGmudp2mo=
Received: from DS7PR03CA0246.namprd03.prod.outlook.com (2603:10b6:5:3b3::11)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:35:30 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::a2) by DS7PR03CA0246.outlook.office365.com
 (2603:10b6:5:3b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 08:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 08:35:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 03:35:28 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 23 Mar 2023 03:35:28 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: print ras drv fw debug info
Date: Thu, 23 Mar 2023 16:35:26 +0800
Message-ID: <20230323083526.32021-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab8efcd-368d-4f03-a77f-08db2b798f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsqsCBRmGqqFlnoTn0W3xFVHeuBLhG62HgOH4tPzy+scy2TYJcwQNcT3Ljm8H/hXHBjFzyPTfyCXLeh9THnKTMBl0lpAKzSXfggM7OkSm0D9jVitAxPD/c9FBRLHX0X2A4Of3lltF6AqXEjAznrg7F+S9V5VA5w7E1ZO2dEnlqtcHhpTyAWRxUVXqjk886mFIykVidf98BlU6eEQBMauGEJGABqN4acK+9QOhNgMrKSvBbsqWbyk6aCqlEaIyB2u7k71HvVo+v5TlS5EIVS54FrnPvQ9Qg2dIj+eUhFeYG6C9VRCoxArE/t2bLjWU9Usw1WadEYZWlU2D9oBvbvPgrbDSe9299xfyt0kheB20moRpLUIEw1hGj2NPUrwvUlAx6SAOk2S7iMmw88DnW/EgTrYZzTE281ECZaKqLdLaQzu0A/JF542PBaKoD+afXPNg7ziUeXo324E+S+xYYw9x6mft52qGhYj5w4p7/rTvj7t/UUOFhcQc3AWp+ffdiVJOGnE0xqi8AKwRWG+KmYKpbc4gdVQMt1M+mP6aDMse6782ZuLFP1EeIqd3WQR1ZY6k6AYQg7Okn9GJ27OYIHUzJRgdOb5XGiH+c4VFwpuNP6C2a3aYIvNzdSd+CSpdrVSNL7ouZ5dFgZRhhCAPnkAhNFd7v+JAAMXkv+pj+TZQHvHvGnxc9IlJRokWLEG0UhI7XtYLFNSAI4x0uNw5MSTaPIdhtZjsJSX+gJC+pf7pI4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(2906002)(2616005)(4744005)(5660300002)(36860700001)(356005)(36756003)(82740400003)(82310400005)(81166007)(86362001)(40480700001)(47076005)(336012)(426003)(40460700003)(186003)(6916009)(4326008)(8676002)(70586007)(70206006)(316002)(478600001)(8936002)(26005)(7696005)(41300700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:35:29.5552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab8efcd-368d-4f03-a77f-08db2b798f31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 6d2879ac585b..f76b1cb8baf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -459,6 +459,12 @@ void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr)
 				DRM_DEBUG("psp_dbg_drv_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
+			case PSP_FW_TYPE_PSP_RAS_DRV:
+				DRM_DEBUG("psp_ras_drv_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_ras_drv_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
 			default:
 				DRM_DEBUG("Unsupported PSP fw type: %d\n", desc->fw_type);
 				break;
-- 
2.17.1

