Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323B9C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 10:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC3C910E02B;
	Fri,  8 Jul 2022 10:17:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98D910E02F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 10:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxWHUbZ+qBB5AsDBq5uOhFx4tC1X2kxlImQZSevQ2R32ADyyhSprh0MEESFESCuDpF1/KRQbSQUuJe130P2PxqkVyrJD1NIkHe1h6uf3tHDdVp8vmX1V9DtaFO5Wee8XXK5B/FMZ17BNMpJ9IBHwdy4FaEP09kqk8FWS1YqQKo6YmwF1Xn9ZbGeL7UJ13DtJI1iu/1lS19e148ERUxzdPAp+UznoJJZp1zIXlE95b2CmTrP/cVgm9JELnPY1cT6Y0+zjG7d1+YCeab5tisV3hO85NFaIV9drhG5J7QC4qXLSoO7xMvqUZUNNQAOhZ6K+kdyxPIHSxXUrWXYA3WU2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ2OixqSWGH69q2BFSKLP557CGWLFxb+QzFRkZ4TykE=;
 b=HG1eu0xdSTFs5pDNUDnljWnvh+Xg1qfj720WlTqTm//387cq2fUN3Wkhrzpha66J88DjDiuI+4uo5TeYlBOwFhdmI8zumxC+jr/Nj8Ts5YjNLe6nh6cE8n0ypqzVzraivWXz3lNYO9PSzWe9GRKwoaF6k3siUSUfnF95LDfQyIXC1i9v8LrANJ96c/zG0CqJU6SxRuDnneDqU+pSiNBOZaNnNsfb0R/naTdVJhVhrHu9y+xMvMbq81doDgvZiNA7+n7k9SiuBsF+BNfN8tYHfTQyPg+2nQ1QBUUMh2VMMQDHajUVVMsrl+CpZuowmQMUgtaseu4hTJu9SnNj2aNkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ2OixqSWGH69q2BFSKLP557CGWLFxb+QzFRkZ4TykE=;
 b=4iEmq+2M1Uabq+Zr0KhpFTfnfEV0Gd8NeCDPolK8OZHAUbTPixwtv8zyUTAo3xZ89W30CVYs10V2dePIvnD0C759M0pHXXJpyZnqQD0u38wdqEGcMx5eCUf9nmE5WRjg53/n3JgotmrOs+a/BbLEdIqoxwQNFHFCTiXgnSbMT+8=
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 10:17:42 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::7) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 8 Jul 2022 10:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 10:17:41 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 05:17:39 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct psp version number
Date: Fri, 8 Jul 2022 18:10:49 +0800
Message-ID: <20220708101049.550317-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c2222fe-e21d-4b20-f3c5-08da60cb17d0
X-MS-TrafficTypeDiagnostic: DS0PR12MB6557:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVis1rI8gbaBJmQZcV7tBXxJOsZYTclwihmXXMTnYZSFsQUvp6wFJSwr5UHAMvno41sl2gesCpcMz0JCGJIjQGSa/JkFB7RE4Dgyj2cX+PKKmuoSxLsqUhMVSyzhUPWGF1a97qOYRLGiRzhd8CdKDDsjUDQKhLSnVi0HW0O3hizfbjETzMIzlitwL15yaZaHr9yMhxrs2Rh7LqYeMFIJvXTw2CW8k+/AsF9JxnR3XUJzWdC3GsKn98iQePK6Vl+A4ccmVack2o/hRoj7Y2+9WniKCnVX7nUG23sE6HrbdZq2+TFy9+75Mfkw3zHoT0c5I70beVDskn4JRXAySzu+12thxT6SuHjbY1nSBQw9Zkvu7j80o+mcVNq5F+/eBAuBejRuz1cyi4ek3zIW5KRh4flq+r1G5E/maFWrZ8UPuNNJ9QQnrz0ExRShJDV39psXV9dm1RalnW7YS1nJkQr5TJWR9LLoUf2he4b4JluibsTy/gZd65K6paf9ExVUMHCmIG523AlBmgHTY+OX6o1n+BA6/SDmIllLRa4M/wPEkFm4qtvufsbqufb9quF7BNciiMnsy6xapeffTZtKL+MFmEzZ9C30ljt2DUNa8jPrhAXB3+nADb+db7RvwVE3om8NmIAccT2dIbyB5a9GDw6EVlx1rowYorYYb7Eau2w0Rm/q7EobvHPSatc+9V55XZlA5DshVp0i1NpNgEm0/PjmxkQfzhEGAbSRX41EzA6Cybo9OnuoyJHFaNJlKtvXEmwjqpfz+cxt+8Q041aX9j9Mwzrr1nUDjMt33V4nYq+ymCKjlgs4qGST5/g+W0+yFXjfcF8ZGF0xwI/7T8lkzwGmLT1l99+3lTeTCP2wEBfo3wT6VHA4mG369Z+XOtIOtlUd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(40470700004)(46966006)(36840700001)(82740400003)(426003)(6916009)(82310400005)(356005)(336012)(316002)(54906003)(81166007)(8936002)(83380400001)(70206006)(36860700001)(47076005)(5660300002)(4326008)(40460700003)(26005)(86362001)(70586007)(8676002)(186003)(16526019)(1076003)(34020700004)(40480700001)(7696005)(478600001)(6666004)(2616005)(2906002)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 10:17:41.9919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2222fe-e21d-4b20-f3c5-08da60cb17d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Ray.Huang@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

it should be 13.0.4 rather than 13.0.5

Fixes: a9cf7e4bd3f4b896c38848106ab3fb3f2c2dfe4b

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 6 +++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 37234c2998d7..74060de9cc19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1631,7 +1631,6 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 4):
-	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9411c28d88b..520609d12d32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -135,7 +135,7 @@ static int psp_early_init(void *handle)
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
-	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 8):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 30386d34d0d6..56e2fd5d4a4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -34,8 +34,8 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
-MODULE_FIRMWARE("amdgpu/psp_13_0_5_toc.bin");
-MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_4_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_4_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
@@ -93,7 +93,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
-	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 8):
 		err = psp_init_toc_microcode(psp, chip_name);
 		if (err)
-- 
2.35.1

