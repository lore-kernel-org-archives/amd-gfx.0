Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBDCC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 06:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8128110E53B;
	Thu, 17 Nov 2022 06:09:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC2E10E53D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 06:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsGuR4DPcUAG7djqaL6r5nMtzHgjInD6xqfdBEz45kNZ5myVLhafvYMZ5rdq/mmukRD7A9Eg3bBeLaQueGm4EOoTfXMpmgA+vF0oyLj45nBCgxsOaFB8azv1zoBhwJcwJeT+tJgqRgcuoLW+dxqjhViWcweS8jPFHTQltjOukt5DyJyMPrsKcD2xl+hgOWtQIdXiblssOduGBVQ15ci8hKX/ko7h4L5D+dcHyHsrPpDVT7/pwKXELz4hLonGsacwP5Ibkaf22HIO55y4Ps2jNFNk3t+63mnPmXRRWNiQron0CmEMmqbyx1wT98vqFoDggy5++0eMIfEVy8bdCm9+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOO2mqwfH0XgfwaWbo2nOKumbz83PSMtdrETrP1D5SY=;
 b=ZYAeuxyhU/D2E8Rjarmnw7cIW94rMfdqyTm+p3/vIWQTgN9RKEoHBO2oWdAerb4WAP0BcVIc4qtW2ldAIi5ZWVIQmZvawb27WG2TK3kAjRqtbu1Nh/fzO/kyGZxaNl/+dwUeXzo82XnGrg4zNKZLCAQ0bJWVLwFLZiBgQadKLFfv+3VBWeL7j3lqi4nXsa/8Fjir2EgZGBkPAL6VTRvp0DZ17y6Yzle9K6lS9Sk+qC0SVTEH2yqmKDFGDI+o0S1V9I7G/0o8ZA9PIABKvhmB6dxGT/MCgaxZv2QBkQN7/QC6QoLh7Le+s9Y1vpmAQjvgIpQ/i6AMLLIttDE9F2CAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOO2mqwfH0XgfwaWbo2nOKumbz83PSMtdrETrP1D5SY=;
 b=HkexQdf8rit93gpwUEKXqNdmgsbrlpxL10OiyqC5hnNNY1Ua2AXFrEnIZ+p6fgbTwR1oZwRFoCkQRQUR9pAKDze8XFYmPS42GlHECl1nG73yhkmnLQdkrmRU+jnq0gvjBwAPkCs8MTchpRPu+dU1x3ltcpHeJ+ZW+4zcOLLDFEY=
Received: from BN6PR17CA0058.namprd17.prod.outlook.com (2603:10b6:405:75::47)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 06:09:38 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::9c) by BN6PR17CA0058.outlook.office365.com
 (2603:10b6:405:75::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Thu, 17 Nov 2022 06:09:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 06:09:38 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 00:09:35 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: add JPEG 4.0 RAS poison consumption handling
Date: Thu, 17 Nov 2022 14:07:55 +0800
Message-ID: <20221117060755.13655-8-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117060755.13655-1-tao.zhou1@amd.com>
References: <20221117060755.13655-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da9261a-afb6-403a-b7bc-08dac8624f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2gQ2vTKhuOSwqaMf5FsvbolFRNrdopGQ1nT1R6KjxIXb/SWg3NpDBMIJtfruYGflpel/qBgjrS4aB6KUJwn/cf7ld8BzW0IZhoxvcZS+/HzmXOm1UY+ZmcZE8axHeoCR5xfUDDcAidcla2ej6LKDmLvqIgkrVZ7SVEzmsIhY7JfoYyjGYoeoeD8I64QvfyuSSusJsKA8uZN+31024agL3sesrdZqNzztTe4Xx6hNIU6JCHFSYmJFJ871tBACrQsIm1+yP8X1oHiCD0BVy6M2LzmwjxzzevJwdGP89SKBjrg/tr9F9j/ZmHuaY/tCjFrQAQZzdC54nIbAEqMfPlGDWzrX6ZAXXs86XUpyRY+hqC0iu0WhHcprT/Fc+Z1YBd3Q5oI2E/vzVAr9zH61Q12qOVj1im4HFMNJpXscL/EFFMdVuogyyM9pWEwQ42YURTpth5yyAoeCVtob7TOofyCmqZ8/N4AV3L9C0hrBsgO3qzvJU5+5jGFrpBJs4XJfGnf7fIGQ8NrumpLqYDLVgTenRvFCmDirNHLuURiLuJJ8XlYybu0LHTiIQZuVQa6Mcr2bHZ/UfkYDmxchwuf90ETJrIHsFZgDZtkdglu+PhCLktjq5SvSMgG9etuxgFeZVq+4o0KtKJUXaF25Wen/OZkFMbxP4dDy1yu+cNSGHh2QGLg42yboWjdQCIHaP+60g1uwiBN8Sx3M7EtTWPvutQINH/189lTlv5aMMlJfEKSVrw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(8936002)(2906002)(4326008)(1076003)(186003)(2616005)(8676002)(426003)(41300700001)(336012)(5660300002)(86362001)(40460700003)(47076005)(40480700001)(36756003)(82310400005)(82740400003)(36860700001)(316002)(7696005)(6666004)(6636002)(54906003)(26005)(110136005)(70586007)(70206006)(16526019)(478600001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:09:38.5056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da9261a-afb6-403a-b7bc-08dac8624f21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Register related irq handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index aa5323c9f481..3beb731b2ce5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -81,6 +81,18 @@ static int jpeg_v4_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* JPEG DJPEG POISON EVENT */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->irq);
+	if (r)
+		return r;
+
+	/* JPEG EJPEG POISON EVENT */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->irq);
+	if (r)
+		return r;
+
 	r = amdgpu_jpeg_sw_init(adev);
 	if (r)
 		return r;
@@ -170,6 +182,8 @@ static int jpeg_v4_0_hw_fini(void *handle)
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
 		jpeg_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
+	amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);
+
 	return 0;
 }
 
@@ -527,6 +541,10 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	case VCN_4_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
 		break;
+	case VCN_4_0__SRCID_DJPEG0_POISON:
+	case VCN_4_0__SRCID_EJPEG0_POISON:
+		amdgpu_jpeg_process_poison_irq(adev, source, entry);
+		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
-- 
2.35.1

