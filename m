Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE98ECDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 07:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD7710E42C;
	Thu, 12 Oct 2023 07:35:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5397310E429
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 07:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/cdtgbbpnhqgNA82//gp9ZSYZxt2h5x58W1lTtaVjLtyxlt7mWIY8BDW9ujNxZUaPmM1fUkz4F0Ky/M6L6UtldWjgh77rKODH/JVUfC5mEjiYPfOLJbkYFBBwcA8aNFD/FZ7Lr6C936Dz2jjkaKZ+KSc7W9a3+docah8iHHjuSnLEP/mutiMh48Jwxn3c/7O6Arew6td3EYKDAj9Ejw/M+1dfGBDS1fffg/Nc2AjBipiBjH1kyopGArDSekm3pCLmYqyXgRYwJkzGfaiagesKfQU51StM1S3SW18QphDue1naiQuhkw7c/L2Xk/eZ4qj2Wh0v3CnYUE3Ev8mx28JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4lQNACN4Hj6LtbfZVv2iHp3Xe38i5fXSmIkRDuBCtc=;
 b=GuVgo+LcqJp3sOoY/RmMPj9Ut7V7M7LA/J2YkFcL+9h1mDKI2WJN0UdcTH7st82/pluyGl/Af+ShUoSUvH4TAPpy/eMHnKZft5/LtQ829X4ExbhqB/WZZgmy2fOLgzEUx4MHdz+68lREncC8rhJK6gtLNY1A48NGo4iw9Iyfzcyjyy2881yxsQD2T8ZSHtrVuzGcNqfwLo06Uw0+uN+PopfqmYGEGHucdyGXDeCaMITwPtX5FedQNFx7cgkXg5P+3WbWIxucA89OTSSVjzDKzmTOGJvDezdxcUcEt8HPHoVfbDmdXvyyDRsRvJZBefSvq8OOJSRWKD1Hbq43QXJ4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4lQNACN4Hj6LtbfZVv2iHp3Xe38i5fXSmIkRDuBCtc=;
 b=NEeWqQyj+5NKb4fjmAuKtiXbM0gF6R9ktfWPlVpTmqIaIAdwsvr5vpVHXZxUiDZo2BBBgVB3VI1I8wqGMZGVtOA77NUWz8nOiYTJwzL7pMXM59kT9sCzRFTXsd9goSfGcz7XVXOQSVmHru/qOIWTYGd7GSvlRAtCvIXYlLXgaVA=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 07:35:23 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::8a) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 07:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 07:35:22 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 02:35:20 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/umsch: fix missing stuff during rebase
Date: Thu, 12 Oct 2023 15:35:06 +0800
Message-ID: <20231012073506.1076224-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012073506.1076224-1-Lang.Yu@amd.com>
References: <20231012073506.1076224-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b73a5a-4bc2-42be-91fb-08dbcaf5cb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fJmBFhMn4n+jP9kzL+0JqG3GgRbKbA+n7bxrGOqMqVmKzJLcKdzo9BPtcbv/758LaFfPNmU78W34SOKU7T8evSQJrxr8UnE8KDxi/sYmw7nSU87QU6ETMScQSZgUqMedsWxN0xnZ50BKdG46rXyfCpPIHYBNHn32ghpTRy01Q50Nqoy1YIlbbqBSqUJwkOhdjRoOUDN/6NDnDY4R6jDoGNUOf7/64/MkeI13+FGbcp3m6/QP9/jL69CT78khbxdy6cmKN+ZcRZFGW81JpLcN/C2m6Vn7u+ba6ZiZB7NxWt1zOf9cB/a2we7G8xDI72CVV81w39UsWmDUBR5SiLJdQhbsO1XepAMLa3tDuVynK9x2KkMC5pn8D+Qo2ke7AJCy58YFhyxPUIZ+3E1nAU8F/8jbgHCgdk4CIQHpRp2mDXDZYu9Th+EtfZ6Cdt2MbHQHK4arNRwgqVm5T7hIROhgiaRdgWep7OsAoYFXnEJ7Bs89Ej0U7DCRlJfiKKHnmI4tEJSvgV/BhtrrH3R+5VaO5hQZ4Zan2mwc7GbmhscT/GdN6eOtndTKlRhezlpFVrA9f8PIDGvLU0ZyFhnCBldP5rz8lp4IrymCaZ6CCm90uZi6jej26pD6BvsJ7aRG8LDHC9yHtOHiVmhE7cLQWsR0paLzUMsYu/PNfxjy8HhAi7Q7wEqdgM4huPn0/JAMEQH08NBY495qIOP8QEtbgdxcctCqui/BnDvNFyVNIE2cX8OMwZfs2he4KaMX8RhnQzjWuF3VF5oQboK/X1LxrBheQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(40460700003)(86362001)(81166007)(36756003)(82740400003)(36860700001)(2616005)(8676002)(336012)(47076005)(6666004)(356005)(426003)(7696005)(478600001)(6916009)(8936002)(4326008)(16526019)(26005)(316002)(41300700001)(2906002)(70206006)(5660300002)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:35:22.5116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b73a5a-4bc2-42be-91fb-08dbcaf5cb0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These are missed during rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 771ef8017a98..3713d0749813 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -674,6 +674,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "UMSCH_MM_UCODE";
 	case AMDGPU_UCODE_ID_UMSCH_MM_DATA:
 		return "UMSCH_MM_DATA";
+	case AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER:
+		return "UMSCH_MM_CMD_BUFFER";
 	default:
 		return "UNKNOWN UCODE";
 	}
@@ -806,6 +808,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	sdma_hdr = (const struct sdma_firmware_header_v2_0 *)ucode->fw->data;
 	imu_hdr = (const struct imu_firmware_header_v1_0 *)ucode->fw->data;
 	vpe_hdr = (const struct vpe_firmware_header_v1_0 *)ucode->fw->data;
+	umsch_mm_hdr = (const struct umsch_mm_firmware_header_v1_0 *)ucode->fw->data;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		switch (ucode->ucode_id) {
-- 
2.25.1

