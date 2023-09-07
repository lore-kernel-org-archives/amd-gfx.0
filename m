Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3128EC8758
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 19:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1CD10E0A7;
	Thu,  7 Sep 2023 19:47:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D343610E0A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 19:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6RmCmEvEvFgCzLi/jPKlvfJkSEPvqETHZ7xvuiv10d46gZ9YH7kZZioMcktcj+EU1E4j60ajaFKp6pF1MDQZw9arWLtvJs30pRsdJkpkiXbVw+nh+IIbMtCgItJ6dZS5T6wU7vvzbwuF8fgnr7WtxN6wU/CJUeEJFiXnCnTtR5HiWlVPTSwsF1L8pSKc7gy27nRHGnCfX/QzH0o5g+8kA9qMgwyx27CxHUK5oTu9LgWUFHT4Q38dp3yBXKRVEAlHSC75FaG7kAGtD6JQ+t1TftQlh8FQp3+8Fk3Sw2wYoVfbimQxsswgI6gUoqZHay+w5aimjcgSo6CKPeF0MNNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gj7fVwb6RNnor2ocNrIDRp35f4uuyvu/IHws3XzyEZg=;
 b=TCiYYKf93+wbqqbGZbimR/78wok0LZejroxZHEySOO2VhccI4Xs5XJYILo1Co+T4jOnHvnxQSb5FHj2CIBwXY+gYkyR3HYE7uDSAvKLjmXuSTSuteAacIV3zcwGIu0zimxAJSv7SVIaMqTHGoszREVV7yolkqEXHcZwuRlQuQOB9aErhjJwoNpSuPU8KSCoS70tudtnExV9fkNicn8eZ+TCKQasVFgK/8+cxB/5NiXAFgY1QsMf//5rx1aL58u7XXxsEch7CvL0rYCc0rpAUxs0ao/3oel1p1MlkXJG1xutm1K6hzwStc2y7SAit6u6Ml+CtdAcsUgrOGE8kEayy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gj7fVwb6RNnor2ocNrIDRp35f4uuyvu/IHws3XzyEZg=;
 b=KujqPKdT1+c5UHW4YKn9GGI7UTj7j5gdT1DzOWh+WRAhZLI/QZaOnFIh+QualjeFTrGhAaAJD7Wo6TMx7GzxfHHaEBx7plI5fEk9XHfSvainK5/kScDroNOrwmfSo/XkKDwGWGJTL7ReFuD08ioD4FPL/nwX+VLTURZzLEln1D4=
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Thu, 7 Sep 2023 19:47:35 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::12) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 19:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.30 via Frontend Transport; Thu, 7 Sep 2023 19:47:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 14:47:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for
 SR-IOV
Date: Thu, 7 Sep 2023 15:47:12 -0400
Message-ID: <20230907194712.501666-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a0a68c-bc5c-4d58-406d-08dbafdb4886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlGMPx2UFkX65c/RX+mfzCgZSVx6Mh+RUMmuREvjtiYxHlkS1eeLNmoEoid/upTmHYidJwF7qYuE9KYBIJ2j5yoPTrVBOzw/2YvsPd9ZAlQpGRUawc3s7G6jeqY8Iy0tHU4XVguPHOguBx/oYm+5PO7mkQgf0ASneFU466+EvREp63w62LXIc4kF/GdIxKGuM4JoOR1JY1br3gL/+QdvIdjYMz2M1dVP5BWgTo+/q+r+labqLhqwlrvvwJN+1LcVqR2AFduVMfWpIoNr6PtPv6Z9WfewnHZ4++GMBEc/mzSQwj58H6Dj5NUkoVSKAGF99ODlh3EKh/PjkDPe/mM/mI27m31p0W/1xf2IBC+v/SRTtJRfopgTlzZGwipQo02uNXhKPSCA1l9PfNllXhfXyWmW1OV72vfzLyBpHH06pHE3DPYGo1uDcPq7OOiOVkH79y8qh/v1KW2xrsqnv1q50V8XTveWPNbgcLvHrsCas71IDf/BAK9UEHHYfKEHTRwOs932I7wX9jqVFPDvhCICUJ6uP7ATV10bgHh1DIleAEnw9PH/n8dXnOQ3pLyCOExM15mdZJeIPMWAqAK5kpVeuwarbF2hWzTLDCUCBSSOydTpkLOJuBwebk8wdVJ2fTwpTW5isAthTBsukI3yogGGvM1rR681BVjtJmoVDfsRSn6BsmnGEBZNoY+xxGPBhE96bDn6lEBX89e4FYS+8Fqwk/Rb6YZ5BKQHu5D1M35hhoBXcTpf9bFr6HkrSAYZMkkHls86q1c/8Wgx3uNoG8Ho7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(4326008)(5660300002)(8676002)(8936002)(40480700001)(41300700001)(4744005)(70206006)(70586007)(316002)(6916009)(2906002)(40460700003)(356005)(81166007)(47076005)(36860700001)(82740400003)(1076003)(2616005)(16526019)(26005)(426003)(336012)(86362001)(36756003)(478600001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 19:47:35.1732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a0a68c-bc5c-4d58-406d-08dbafdb4886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Needed for HDP flush to work correctly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index d5ed9e0e1a5f..e5b5b0f4940f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -345,6 +345,9 @@ static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
 		data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
 	}
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
 static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
-- 
2.41.0

