Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4534DC3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14C710E5EA;
	Thu, 24 Aug 2023 21:59:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4321810E5DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYckxY4/qeGMFK/c0H7ecOkJWKd2cw6xUrVw3uFod/D6QhZ0PAVq5TQfolZFRpdHSwxJdFDRJzMh8dWojdUCYDvAon2dHvTvxHbPEffLAEF4j0TEhM0UbRWVev0IoEdd5ragCnfJ4TXNH87tKfBMg1wYmoo1NdpPGq73z7tbRnBXuyR5Nwm/WmTN/VGBNT22TATfZbo+Ig4PCUhRE6WDX1vl91lPA3K3N+dd9QP+6S6hUP4Rq3B9CH12EuX2SrAc/zV/fjJTa7kBgDBI9X88TBri5u3gounZyKLC/dlXcZXhNIGor7fhZZhF3JysCQHDlscu7LfGSGUrQR+SPv435Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csr//uCl6ZAWSEy6wvMSROM8wU125yp9H7PysexPhew=;
 b=DvmipIn+CbkjJOFFTSbwj8/RsDOUPhuemIn4urP1Nfo6TlQ0oglc6e9qPRuxEZmxMDM529IxE+aj99O8WmtLWVGMWa5G7u3kD0jR0SLHQMV88G/dDE12qL93UZOG0v6SxVTDRSJ9l+EzsDiZkMxoF2W5B1HENwCXjW4xcrMt31PTkyzoEUBnfd3KgTstDffv+jtnOv666NQ2ZrRkErfg+9kcDmCwBJDpby6EqaKdHA6KeOcVdHGnEx03F/hc9+anRlwG1cXsrJV+AG0DPmtR50+HEwASQJtI1EHyHN4qD6OLjB1IgTpehgpDTRjhQvNGA0MFOggoQ37iHsXuN6Uwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csr//uCl6ZAWSEy6wvMSROM8wU125yp9H7PysexPhew=;
 b=CKsP5f3yV8jedIzeHlAWko6IkraajONikRPKnbfGdRxadl2P3RG2GPIcAeXoNhKWl2QcWS9Qe5EXO+dC0/oIGuHVw6r6BjE02q2f94M69Zi8TfsL4/30jycCsv6LuE/kwhTQ/RvfhRiAGnhWiWV4IjLcZpKbDDCK9Pt9h0R5Qcw=
Received: from DS0PR17CA0003.namprd17.prod.outlook.com (2603:10b6:8:191::17)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Thu, 24 Aug
 2023 21:58:58 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::78) by DS0PR17CA0003.outlook.office365.com
 (2603:10b6:8:191::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amdgpu: add amdgpu_umsch_mm module parameter
Date: Thu, 24 Aug 2023 17:58:34 -0400
Message-ID: <20230824215835.2740115-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 748e407d-ecc0-4f92-2ef7-08dba4ed516c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQBSVAgxE3akIAnUXRyXBoui6dBC4Iku/RphCS5Yvx/AVP/BeRjUPL96ByL0NmDNwDLduRVMSJ0cLM2NA+ZPWHIrwC32YJcy5EWMl4/tzQUiHVhfOBV/GxE84EQVYC4y3+eztmXa5ma8xyozWq9Fz43j4JBCY1DcgPUfNYrQCdfOLiIpy0CwQoLoSa+0iU2rnpoF9dxv51E5ZZ7DHrWvfSg30W0L8ALE00jrHivk5ycHkdrQnJ7llKq0sw16ZDpxSa0GArBMLF05kAWwu8WXUfkgzsDxl+wwgNa4iwDcb7dupMNf+r92MdKdkajXFs+F69MNnCU6yAuq0PZr7pX+ExGAXNswFikNOy+33/0EH/K7NgUW29Mo6U8/6y6y5THaAUXK+qYizkjhlHuXXOTwhchSShNHQ/ua6autV4ZcjPaZOhQ+BNN43XTqyX5OxjOn3dz7noJ2cf8VOJIc9SX4kLuRbEEvei8uCPFATmmlx+BvxIZnvLSxCAzF0hLFSuMmjm9OqRDSf3UdB6mVZcFqAmgi0oi3pp5uelfoAfaGGuS+q31lgbiaQDmzMsI5kWL9cdvazEgtdm+mfrF+XtzR49knO5z6/0T0vyrvzIMpt5EkpCm6T5HyKgzAcFench9cn7V8HvO4AwC5/tcJo3o0AED4Yo3nM2EYKsvq34Yd/ScTpYeywbSIxa+qkvscOeVSXSjuqrgvWPUnR38MBbQtl27zll69C4AfztypqZlcMc4zRr1XPA90rT2wLoGR6394n/gWgP8sW6E4d/n7J3ENvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(41300700001)(86362001)(5660300002)(70586007)(54906003)(2616005)(2906002)(316002)(6916009)(70206006)(478600001)(8936002)(8676002)(4326008)(7696005)(6666004)(83380400001)(356005)(36756003)(82740400003)(40460700003)(426003)(81166007)(26005)(47076005)(16526019)(336012)(36860700001)(1076003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:58.2368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 748e407d-ecc0-4f92-2ef7-08dba4ed516c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Enable Multi Media User Mode Scheduler
(0 = disabled (default), 1 = enabled).

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 10 ++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 17dd20bc6910..1f846650cc8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -245,6 +245,7 @@ extern int amdgpu_num_kcq;
 #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
+extern int amdgpu_umsch_mm;
 
 extern int amdgpu_user_partt_mode;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 783f8d50e499..3abbf596a2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2163,8 +2163,10 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[VCN_HWIP][0]) {
 	case IP_VERSION(4, 0, 5):
-		amdgpu_device_ip_block_add(adev, &umsch_mm_v4_0_ip_block);
-		adev->enable_umsch_mm = true;
+		if (amdgpu_umsch_mm & 0x1) {
+			amdgpu_device_ip_block_add(adev, &umsch_mm_v4_0_ip_block);
+			adev->enable_umsch_mm = true;
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f5856b82605e..ef713806dd60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -194,6 +194,7 @@ int amdgpu_use_xgmi_p2p = 1;
 int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
 int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
+int amdgpu_umsch_mm;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -907,6 +908,15 @@ module_param_named(vcnfw_log, amdgpu_vcnfw_log, int, 0444);
 MODULE_PARM_DESC(sg_display, "S/G Display (-1 = auto (default), 0 = disable)");
 module_param_named(sg_display, amdgpu_sg_display, int, 0444);
 
+/**
+ * DOC: umsch_mm (int)
+ * Enable Multi Media User Mode Scheduler. This is a HW scheduling engine for VCN and VPE.
+ * (0 = disabled (default), 1 = enabled)
+ */
+MODULE_PARM_DESC(umsch_mm,
+	"Enable Multi Media User Mode Scheduler (0 = disabled (default), 1 = enabled)");
+module_param_named(umsch_mm, amdgpu_umsch_mm, int, 0444);
+
 /**
  * DOC: smu_pptable_id (int)
  * Used to override pptable id. id = 0 use VBIOS pptable.
-- 
2.41.0

