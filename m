Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79A6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 19:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891B810E3C3;
	Mon, 21 Feb 2022 19:54:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3068210E3C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 19:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7FKcCGO/zG2HoSWkpi0B/U/ZV5R8bY2lHnORapJYFCX6XNzRJXitlJGUzDEdK7x+02Z4WaYUQf8wRCDEK/s42FS6pcdAxjQgnNicDCizKix/qJA/t14rA3aGXZXhNNqfBWO1bqhHn6CyIRxLrQwgQ9Po4we9+Sk86vsZofwNlgBAm4C8N3xQc/305CqDyU847x5Kz4vcpY+SJzmbWTacWZ4/YVfjA9/3MibUJVVom0LGcGW+dI279ZqitAHpDIiTNgb4Zt/LWedc/R4eDTWokzhwlnvF3heVG5v6kqE8YIBLNSd7OBSvT++juHficnVW1jIsVs2hsH6zgWzt4H7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bU/wFypLKB7eBymgTfvepY5L+d43WgwzZazZPAzh65o=;
 b=LeJdSOW27DppxBwPxMwrzq4ifQgPIXvYxZn1ikm+0nZ3AlttwN8GCA11km9AnrKpRtEF59EUGdj/pHlujuh47lFgHbaqHZYi/nP+rPNNmEobwZNUeTc125WePjA8p1OnO311vN8z+6SMqFLYIy3iARA6hHbBIL5FJIoY9OXmDBd5+6Qu7aYSCck+BaJE1GFZttLdktRfvHQDaKHzdxJUnliS2QWokQYyYbpgafUh3MQrhXvDKstMV79ASDWyMV8hKuy0S1hK9w6Xv+/IxxVG2fPuq5Yr882L/Zy6CC5a3EQckqWO69RU6NhCzDEp5sW4+GxJ92+lDY/RIrllPbT7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bU/wFypLKB7eBymgTfvepY5L+d43WgwzZazZPAzh65o=;
 b=Tvsf/IHauVIKZHfo16W7DmN1MoFDUdmCyiUIP2x5DLY3mxCoDWTUzn7bmygXcC6V5GpA3Vg2o9cOXnbQ1B6vsGdWp0pdHPptQVw1D0xJERR5CDTnYIjulH3xYOGiEk1xWePpgi4pgAQnQoBTUnYCa0F1caPMtALDcNdclaU+9CY=
Received: from DM5PR1401CA0010.namprd14.prod.outlook.com (2603:10b6:4:4a::20)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 19:54:18 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::3e) by DM5PR1401CA0010.outlook.office365.com
 (2603:10b6:4:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Mon, 21 Feb 2022 19:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 19:54:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 13:54:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: derive GTT display support from DM
Date: Mon, 21 Feb 2022 14:53:55 -0500
Message-ID: <20220221195355.135192-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221195355.135192-1-alexander.deucher@amd.com>
References: <20220221195355.135192-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53828108-4053-4d6b-5d7d-08d9f573f244
X-MS-TrafficTypeDiagnostic: DM4PR12MB5844:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5844F201B26356FC51C3254FF73A9@DM4PR12MB5844.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1760JDX20Zx+KzGNGqiE8CuEwlMqEKVWov54D8MSxn5ISBMZDaPnpMRbSYuXomWNpgszqMIGvWbcsjpeXCIXeNs8VN3CmmHmYgD6NTOucRoih4Yxm8HVRP9l+Q+VdNOnf8dJ+5asIMMsR0HtxV9DwjzjAubF4+ue32K0b1GgoNFQJma4H8uIvHlv5jyAYuXOZ+3gIYNgNKbHYib3USu3l6F3K7WbfAwCpsP8cGVUhcOYkOH95E07u4badKenhALx2qQHnJwiKHe9VmhYkKYblVK/tTLBUtkCpo3VTCdWGKr8YEi9UcvCt+FdgyfEDo8hjtb5pHju6RjAU7GwmUBQ3f3KFUPoMHm7WuvDuBFngluAzWf75qgCHCOsJ7Za20nLDT80av2FA3a3dGrzCA5Go1/Od9iZ/x/Lcv+UAMeT252yagEfh3H3bpqKhh9PO2xI8Pt0HO0bx4I/HjX52ztxk+c/lcIt3OMBKi8JQpUD+6Gc0CvbRjvhlAxgJeB+pmfaii14Rq0EvozSNUq3iX5lfkzn8kaBcaPIohnl8zj0Jk6byK2bBrFXqYkPaN+/D7N/GPDgeiuxfUnTqrWUR0dCXInu6IonSEn8UZ8ix+6rhdEuz3VrLALlxguR6ubejEbwJ5qN6KPXsffY4+NBVoJGLG6Z3PdDrw3ZSxAeqRDYf4efSgNF9HBZE+74whdtAkueQzTnGV1Sjz8sTHhzcnEOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(47076005)(83380400001)(7696005)(8936002)(6916009)(70586007)(86362001)(40460700003)(36756003)(70206006)(36860700001)(8676002)(4326008)(1076003)(2906002)(336012)(426003)(508600001)(2616005)(186003)(26005)(356005)(81166007)(316002)(82310400004)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 19:54:18.3152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53828108-4053-4d6b-5d7d-08d9f573f244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
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

Rather than duplicating the logic in two places,
consolidate the logic in the display manager.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 30 ++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +++++
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index ec4c9ef5f795..1847cb92a98c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -506,33 +506,9 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type)) {
-		switch (adev->asic_type) {
-		case CHIP_CARRIZO:
-		case CHIP_STONEY:
-			domain |= AMDGPU_GEM_DOMAIN_GTT;
-			break;
-		default:
-			switch (adev->ip_versions[DCE_HWIP][0]) {
-			case IP_VERSION(1, 0, 0):
-			case IP_VERSION(1, 0, 1):
-				/* enable S/G on PCO and RV2 */
-				if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
-				    (adev->apu_flags & AMD_APU_IS_PICASSO))
-					domain |= AMDGPU_GEM_DOMAIN_GTT;
-				break;
-			case IP_VERSION(2, 1, 0):
-			case IP_VERSION(3, 0, 1):
-			case IP_VERSION(3, 1, 2):
-			case IP_VERSION(3, 1, 3):
-				domain |= AMDGPU_GEM_DOMAIN_GTT;
-				break;
-			default:
-				break;
-			}
-			break;
-		}
-	}
+	    amdgpu_device_asic_has_dc_support(adev->asic_type) &&
+	    adev->mode_info.gpu_vm_support)
+		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
 
 	return domain;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 902235fae4cd..a546cb3cfa18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -341,6 +341,7 @@ struct amdgpu_mode_info {
 	int			num_crtc; /* number of crtcs */
 	int			num_hpd; /* number of hpd pins */
 	int			num_dig; /* number of dig blocks */
+	bool			gpu_vm_support; /* supports display from GTT */
 	int			disp_priority;
 	const struct amdgpu_display_funcs *funcs;
 	const enum drm_plane_type *plane_type;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 306b321bb70d..d73ec30c5bb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1471,6 +1471,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
+			/* enable S/G on PCO and RV2 */
+			if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
+			    (adev->apu_flags & AMD_APU_IS_PICASSO))
+				init_data.flags.gpu_vm_support = true;
+			break;
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
@@ -1484,6 +1489,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	if (init_data.flags.gpu_vm_support)
+		adev->mode_info.gpu_vm_support = true;
+
 	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
 		init_data.flags.fbc_support = true;
 
-- 
2.35.1

