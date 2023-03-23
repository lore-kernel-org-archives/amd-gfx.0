Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C73C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0954F10EB57;
	Thu, 23 Mar 2023 21:41:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14DAB891B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7xvJoFkW5zM4SPIX54UcvVi+rDvl9G8iHQU3s6YYamuJ5ZxZZhRnjYgFSCbEX0h+uskZfq7my54nJqNEZNzVk8qLAfSH7k1JkjoKIXc33pZ4uHMsaA2V90U2xAcxJGvNzKx+ULhyq16xiMlSsdLpfR+vUMOvvHSO4shxDiUC/Qt9B/8qBG5yBj6QJfXq25c6gnzXul96RZ/HDs8AwPF0pIA26eVrq0MGQoEUS43IiaVp2lkEGj75rfpSaaLRcEd17pNTzKujY3QYqK4sZ92sbVgL9PiYIs2oimP9DqxVKo+3SxJzSc2xzx25uEaRDK7W0I2graIi05d9OYm2I+zNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVGUi39F74g48J4e9V4sW6L9Vv8kIhxqCOd38a2eeG4=;
 b=I7MdU+FdAjpcr/it6QeyMlYElPudfYrkrfpUEqhddCp9krN//HrbfenAc1mhBjEr1LmuSoDr5744FyjVeSbXN844T3tQuqQK7zjJ3/BIGx/FzGTTIuGLRMCvaRQXNeiH2vN98myP7zqTHO5mjyPnzEJTjD28O1W+y8rBO4yG+GXDULCEGt6VDXgPzrANOdp8Q9yKsIy+y3HDsD/Ma0NH4V7X00nC1hwkoeFO5FiFxR/j34CK2M9RveDKK1wa2DODgA0ojMbZmViPZqtFJSIPe5GA/VjoJSEn2NHLGfaJm4KbcP3bbYOSzz0fuDbfu0dKNKY6fyNd3ZoSdSmrGMUN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVGUi39F74g48J4e9V4sW6L9Vv8kIhxqCOd38a2eeG4=;
 b=E+h9z41YIxjXN0Vc+hxMkgtQY7IcnBwcrSxLtdWC7Hj0ngqeP24jercmqqhRlCN42x+ETOGAMDhKGf1wzK6+T+ISt1e/IZy3V5pfg2EPOCECTGsf9Gqn1jynQifgKpgl/ZCDvy2rqyU7fEAZADh3+/sEtd5jHBtZdStkZQguz8k=
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 21:40:50 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::70) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amdgpu/gfx11: check the CP FW version CP GFX shadow
 support
Date: Thu, 23 Mar 2023 17:40:23 -0400
Message-ID: <20230323214034.1169310-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb3e34e-0b24-46bb-0d10-08db2be7452b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QR7KYDhJyEaUy29su57gFyqG8liijaqu9G4eicWD13ypSacIOtMyO4jcytcWXjLJY0PnqdBGw94+lOt/rQuLywds2TKC3llRFI7GJO0fdbNdcDQbKTu2jOYKpZUWLTBgqxIk4T0RZJvi+rkkprzkvHdG3uh4uxazkI41FRNyxXGawbmGyfknbzACDfotjOeWaySqbPzuK4CDae6W64afjkVQC5qDzXMrsC6e4eej5zCg52grdeKFwaFmwgxL18Pwp0QgyH2sPY+vuzSgr2AmpOy7bEujhopfTVte0kdLMjXBKTFj6YgevbUbQEP/JwsQi/HymtozksYQEqpr9NtQB2MOhwOsIrJSOhFFfq7v8CW7RqlqsL3s4OXqbS/vET+1imO/TbBM2xdJAeuTO/mbkWiS/QBCKc1XIyb2R/Dnp5M8aDw22NoV/tuH+nrBge6E00cMg6q3C5yWvo7D4R4RK/kLAyF3JunBWGiHqlFkmGk5BI1t3+CZ0neFlgTgVX6FnKH5GTeQJ6ahD/ss3XA7C2i70bEtcKO2sBqoNluQkg0Vx5+URfF+7KpDV1cpiVWkInsNjz/8hHFV4+VRZX3jBwCX+LXD8IeUZF5XoberwZ7wKYjPEbWsTcg/x7rekhokjuY42s17/8NVEkR8onqdtH8cxcxCaDiExIwHD8JXD42Of+ZBX2GPUbQ5f9IZDi90hbyQG/RUyEkjeedFyW7S3VnDF0cvArVsW6NBmTnnAbYjFegJ6xWGXYEiRZ9HoQu2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(186003)(36756003)(26005)(6666004)(1076003)(336012)(2616005)(40480700001)(70206006)(54906003)(41300700001)(16526019)(8676002)(6916009)(70586007)(4326008)(7696005)(8936002)(5660300002)(81166007)(82740400003)(478600001)(316002)(356005)(86362001)(40460700003)(47076005)(426003)(2906002)(82310400005)(36860700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:50.0164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb3e34e-0b24-46bb-0d10-08db2be7452b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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

