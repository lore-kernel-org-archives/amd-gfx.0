Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DCAC77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3138C10EFB5;
	Thu, 30 Mar 2023 19:18:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABF010EFB5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIx4zBHSI0mm6rLoDFJ1p7X3hJCguecYDYyckUDdCySbup83KwpZLB8pE5Acw73bJyOh1atOQ5cglQ/VyhTKa4em79SyAM7HCsWnq6u5fqVeMFVW1SH4dc7k9AfYOcn2sqXDKgjd81IFzSaVgvWxD+dCf1uVM9/twN+NWsL1MJ+LnUpZ3d31EMd3bIYU5XuR3x5LLLsvCsrJQF+puNAdcaaau1yLifpmuKtYKkof/GcSp0JEzAUMU4tmuRDRFyt1lQVT2wWDgGgrp30+3aHIaLkCn5UMd+cOM/mYLhGaNld3KbGFHYajsR2eBMpH8yfExXa0G0zSOXevw3ZSeWgh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVGUi39F74g48J4e9V4sW6L9Vv8kIhxqCOd38a2eeG4=;
 b=k1eRD1xbUIMWRsmojaM/s2lsGC0X3Q1tMtPV+nGFXMKk/EYYQ9SN3oItcl+LbjI4wHEm1LKLfRs7RKloAOSHhijf6+v8NSMPB6O+W1LKM4mGtySTpHB69fXKCnZOt8AecKD2SeFdh/Iv4thzKkbVJfIeN+tu9oviMn/NS5yer3V4162P9cNKJzub00PAeQGL2Pi56XZl08cYurTEC735FWvqCvDdYdlE3Utlkpb9iE8XOMNs9ckZhThOBben1N1aCuAt8T79TWtdTjQSOQQVisEyE2DXn8Eoxu5hQwLgqg4mdEUjBlcJetkRL6ZlU6PR9Tu3bk4daMtM2pBg7eJUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVGUi39F74g48J4e9V4sW6L9Vv8kIhxqCOd38a2eeG4=;
 b=2eiAi2HGsvD8VatAgpvlZ9atO9a0kAsDkSNS7/vRQWjKqtm8LBqdDffszIgoFiqqaOzzC68oZaiS7AixA34qm8CF7TpkzvXF4YTZ4xu+BPqGD1WxyUW0hbAdI+sAzqouDM7CuwAsCsCDsarSO6Dt8gX7ID3AAm3/IarqWBS6evc=
Received: from BN6PR17CA0039.namprd17.prod.outlook.com (2603:10b6:405:75::28)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:18:04 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::89) by BN6PR17CA0039.outlook.office365.com
 (2603:10b6:405:75::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amdgpu/gfx11: check the CP FW version CP GFX shadow
 support
Date: Thu, 30 Mar 2023 15:17:39 -0400
Message-ID: <20230330191750.1134210-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: bf656924-469a-4b12-087c-08db31537c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHDXIfN0pLo2xyIaQpoLZZlMHOlrFRzHz1cDwfdnUBfvOYZ7C/vJ3/KhH6oVWh13LBZezqSeeH63CfJKN5VyACeXQEA7idzIKho4zOrO3MADFOZX1ogXZswOMxQl4TV6Qyl2gMwJQmrUK5C0bFqxOnOhmKIXsnoS14MtUjJyr2ogc284p+L9N3xcoL7hoIOKPWWR29cL+E+JvhAQJJlKjR95/algBzHhKwr4oZQMpAMyf4CMAsmxRfA2N8BpokAncJruIarVBwGhLfTp9vSdXSuiDEFXQ5Kd6/WMvreiVcC7aORsMfHElFRRtnrY6XhajLbb3jGQBaRXiDNAJgFDhyiJfDB3vCbzw6bp7U0ghMR/H6+GVXHbB5S8c85AZJgy9jWahoRZbxfIHN3D2MBC+tbccUBUWLPJRx1ZD63vbV+toNWQL2Mvg5htrf+aQNFaOD0yfUxYExfSAzK9nyZCT7GFBLDUtOdvBFOxmHUX6h9u0bJCaHql5HBPQ2fw/T1lZQ70HImKDM4MBDiho/waxUjHttA0mB9yj8d1nbSXEVHNhfM+6i+i0HKb+eqC72sgerFwlYts5SbrHWZdoTfxTJNNTLrjgweRgb4rlwSpoqkVHx+p6QJJYS6//rDCzPLvM2rzw/PYFm0/JIIGA1XKaq7OWXfvOkZjGJ1yCCZOq88LGHsEtQAk3CQALYmusIvbSMVHRCbkvwCzJgU+7jouBldcpcXM7iKVEN0Q3a/tyzpxOo1JRT5FGl1m41DRbjjO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(7696005)(54906003)(336012)(478600001)(316002)(41300700001)(36860700001)(8936002)(4326008)(356005)(70586007)(5660300002)(81166007)(6666004)(2906002)(2616005)(426003)(82740400003)(86362001)(47076005)(6916009)(8676002)(36756003)(70206006)(82310400005)(40480700001)(1076003)(26005)(40460700003)(186003)(16526019)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:04.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf656924-469a-4b12-087c-08db31537c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only set the supported flag if we have new enough CP FW.

XXX: don't commit this until the CP FW versions are finalized!

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a0d830dc0d01..4a50d0fbcdcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -469,6 +469,15 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+		/* XXX fix me! */
+		if ((adev->gfx.me_fw_version >= 1498) &&
+		    (adev->gfx.me_feature_version >= 29) &&
+		    (adev->gfx.pfp_fw_version >= 1541) &&
+		    (adev->gfx.pfp_feature_version >= 29) &&
+		    (adev->gfx.mec_fw_version >= 507) &&
+		    (adev->gfx.mec_feature_version >= 29))
+			adev->gfx.cp_gfx_shadow = true;
+		break;
 	default:
 		adev->gfx.cp_gfx_shadow = false;
 		break;
-- 
2.39.2

