Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E4AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 19:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E445389FD3;
	Tue, 15 Feb 2022 19:24:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC4289FD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 19:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I508m7LCEDZk7E1D3eemj5IyeoE5Kw6Kj2468RrrQSeh+M3sJlopEqNmYg0N04/YMPtbXOT4sE33mbz5qsj1aCeHEUFvObHyCMJA+wKIvyBCvg9Ln3cS2iLjUeLW0Wjr2Q48LGFhfXC+G/gJIME2N5gHUrAzOP6Yr2PufKMWyPSIamok4WxHy6kzFxGJ7YU+wWi6gB9Hic5EARq2BhtCEDDD/UfGvAVHiVVpfml8ffjruryK3DsKVhiq8O+rkhuwCeEqxC4wpJ4qgJD/CfGCyqmexUWmq8fY0M2q58COQpmAnYw8+AXqEtG/YZdtlQsVZLDEG1qgG3vY89hPMb++5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLuOLNa065pw2APVZ435YwkWK04gYp0vIcSf2C8cWjs=;
 b=lwF8s2hR+N3XZXYN3/rn0su3lJ1YTc9yL185P4wura1BYnGg5GpToR/ykoDp2Ejs0vD8zh/+h8P0mCSvTJr6qPuOs3hIe7s/z1MctFRM/pwJ1F+cP4Edui2AYMp3Po+K9T2HxCUw79C8MtIoydDTzGDFuuGyZGeJZgRmRFXGcur011ibEJHLc5i/XOK4/Lc5ULYt1TXCiaALH6ZB0iqhUVGJDszppt6zbIPlzXrr9eTJtp7lA1FexZkseB0W5AJjUY46vK9DNsw1iyexEbm1pm9fIxba27i5gHNx7OR5bFYAYWcDm/Rd03HAQTOuahqoRCUEEGshYZx20lU99NhPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLuOLNa065pw2APVZ435YwkWK04gYp0vIcSf2C8cWjs=;
 b=q1hcDMu1wuqt0FS9lacz2YUr3jUasu88YjKrgtVJkl/7ujTz33LAUhiUywxDPazJwywfMQphiXlmES1fQPiveIhaIsH+QWw8GGAJ4D4DCLGvD4dT687LM1gwIQX+llzMq8uJxX/HpREVmFqrddlUPfHL7jFmBWjpJ+1YxRlHlRY=
Received: from MWHPR19CA0008.namprd19.prod.outlook.com (2603:10b6:300:d4::18)
 by DM5PR12MB2565.namprd12.prod.outlook.com (2603:10b6:4:b8::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 19:24:06 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::2a) by MWHPR19CA0008.outlook.office365.com
 (2603:10b6:300:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19 via Frontend
 Transport; Tue, 15 Feb 2022 19:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 19:24:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 13:24:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sdma5.2: add support for SDMA 5.2.7
Date: Tue, 15 Feb 2022 14:23:53 -0500
Message-ID: <20220215192353.2232387-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a8f4e9a-4d50-492b-10a6-08d9f0b8bbd6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2565:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2565172E8377FEF0DEC2D291F7349@DM5PR12MB2565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pz94GT/uA+vWkt/QXl1RUTWFBcl2IGacXBEB90vRgZDrKvxDT9GDCO6NAEymAklP14PLHkg04QqKDSQRc4NPm2SKPMOcjpAFtC2Iy1D0Yu9lZdFGssSQhKcvZKg+eKc0XeINMDnc7SdZ4j7sJFdTtzvHA+hjZP9VS1b2szcdqoixecAWmtKyfV2/Ucn8GbzsgvnzqIc4uSb7VOdECQ1mVXKifCbWvb5SLTS/AAdaomI/sxrCYJSH5D+SUtj3UZk6nML12bpml8Z9BkLSCmZ+O3TtW/xFnb+dURaftCHrHpZbJxTVsi8PvmDd8Qtfan1Nqe1xJfrGWLtMQQTi18HWVjhkmLAhTsDy3XAk3GQ+BtZ+lANVwm4k+Yu1cs7WVn09SZy7mSoNZax8weX0Hlup5vE9c3aLu/PTZeOfwnzgDipdG0nVuzs5giiMxON+k7rhRA7EPxneP9F2BL5KYc0E21kwYAqGMbmYdFdK1N9DQBas5pIrhjhB3l+ZOnFL+0wy5lVqRVPTUIwv7RLzAEZRCR2FvdlzCbNvu1RkBKMRfZVVYZ3Ni8y+JWziQJewqKJ4If8tU3V9TEyHr0JSLfVBmZQJQ70jlc+DGZW2mQwIwhRNPzJ6d4tJT/lE9DrmXdgnxawCY2RIzB+dSW5XQ/OiJOsPFDcVQNinc12O6DVI4FrIHxgCfbwUVc/9glut30IZdpCkQuFD2tHis/nVj9A/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(7696005)(508600001)(2616005)(54906003)(186003)(36756003)(1076003)(26005)(2906002)(47076005)(5660300002)(36860700001)(336012)(8936002)(70586007)(82310400004)(316002)(86362001)(83380400001)(426003)(356005)(6916009)(6666004)(16526019)(4326008)(81166007)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 19:24:06.4246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8f4e9a-4d50-492b-10a6-08d9f0b8bbd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2565
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Initialize SDMA engine firmware loading.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f09056ee48dd..d8a5f892fd60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1452,6 +1452,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(5, 2, 5):
 	case IP_VERSION(5, 2, 3):
 	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 7):
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 2c0f1e84a563..0ca365006399 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -51,6 +51,7 @@ MODULE_FIRMWARE("amdgpu/beige_goby_sdma.bin");
 
 MODULE_FIRMWARE("amdgpu/vangogh_sdma.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_sdma.bin");
+MODULE_FIRMWARE("amdgpu/sdma_5_2_7.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA3_REG_OFFSET 0x400
@@ -155,6 +156,10 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(5, 2, 3):
 		chip_name = "yellow_carp_sdma";
 		break;
+	case IP_VERSION(5, 2, 7):
+		chip_name = "sdma_5_2_7";
+		break;
+
 	default:
 		BUG();
 	}
-- 
2.34.1

