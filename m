Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F9DCDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 10:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317F210E2B8;
	Tue, 17 Oct 2023 10:09:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36DD10E2B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 10:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMu/N90vcy8ly54VreR6uynQsHl8JgAtQNc1nn8ScQEtesngwXscN71jHVQaKTcDpYP+BOK0VnCVRAR29uMr7o5FpIwosRcxdnHpIX8+xRpUGWZcQY/1cgwhr7spfpNX2uX93Sj1W00l7h4+XGPIc1iZYb4OT/jY+gxeNGn92QE47x6IaZ25fHRT6ZSPsrXwMeGRsC4TFW+G4FDdTM0xTA9gsIe9gMcHAtF2lOJ5+SXkuxk4YZiJL+zsk/jmydWHPAOr1FqeqiUjZN1fFjStuU21xtVHgmAnh/RZ/oITwA5FPTDyTbwKEmE1EbMRREb6cA2IUMF4F8nfbRdm+5XCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gYEHlVv6FhVSMuv9BHUNuWO1OGllVzkJVB5E6A71z4=;
 b=Ytw87OJ1SRbPiqU3RmTzRHyTptq2jKGtkMDRaPzGhFrVlF9os38k0X0Ipjerwt9+pUWH27EYzf+m5Y3QCCeCl6wAJvQHCFvD4QuusZBg+i6nfXUCwXtrCIVJlVwRJw6MxsBblzRWhfaTNwhrfn9YsF4V9hKdAqy3QoQDgyjhfgsfUHtlIVdErawhxfMg9TMzEC2ZboyK9ARJut5B0NcWUE/+alEPbcaV7rVgeHrjNSDzclEsKkUA3rvARW8hyLvKE+mE5lKbLazZ+kljFmFgYoBV82FWp2OdvFgkQc9GbFhsA71sSvj535ctTrWFsbtku1gOOLqq7WKGNu1v1R1OYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gYEHlVv6FhVSMuv9BHUNuWO1OGllVzkJVB5E6A71z4=;
 b=atiCtdxUj0HLVrRynYifX1ktyISnEOUCeLYVmD0nKebVvwDrRXRQcFbgiKgjqZW/C0AFxwORr7FDZABuZoSUGrJN4pYXec0gJ/AmgslQt+nBjfHGiPVhMDcnWp6BdvsDzYzvbu+G/wxDVMrgDoUoy3uSYZqwuwDGVo46TrmyArs=
Received: from PH0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::20)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 10:09:10 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::a3) by PH0P220CA0010.outlook.office365.com
 (2603:10b6:510:d3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 10:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 10:09:09 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 05:09:06 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add clockgating support for NBIO v7.7.1
Date: Tue, 17 Oct 2023 18:08:57 +0800
Message-ID: <20231017100857.2419826-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: eda2f26e-e5df-496e-1dd3-08dbcef91afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ilRcjzkEOQFN+yWjEcbY4nJp6LzZo+/rbC/0WSFv4KCbsC19sVxcuVMXyrf0dvPt1g+os34hueYC4FETQ9m4fosrpgZhNFES+qXcwbHuuPCyEtwj8elw7mwUlGnfe2zpskkJdViXOPQ3Y6cZthvpjWmdlGYe+K01w2fDwK4e2vrulPiN6jNBkOJcaRzMEawZOy48JX44ecK6XMvkeW2oVgqjgMNA35In6YQMHzhOW04mTDrQZe/Gq1YzY1Mv+ZXvPOWiDdhKbBQiam0uF6gB9iKe1rkq9e2NieMORbirJiyrwz0oT9b80/uLmN3e7uY1h7U0zM8IWyT8ekGgx8hhOTHVlMxhYmG90rHUgEnV5ggq0CzJIoUbkQkcf5XYEwbc00eWhLZgD3VbGKvaFGjKKLIME9+ypYUgUdrNMJl8tY+3RmhPpkaJfshNvIZugQCDemNLslCxO2cOWgZ1XmMFyefEyDezOtadexUaqeIVx5PIY0z8dTkr/7VGS/00Dg8pxMO4RWT916QokB4Y9QxKx1ahlLm4PcuR0yJjQ+2zmCl2XLW/L/If8TYVCqS1L1j//9fmxQoAlk9GDVgiEFh39ZXhYwZ4JWL+xJctQIkCDPzouVEM4LoYA5hVPt2tybQqht5+EEJOYW9UabBzCWscAdQYMGea9NPFQp+15IZEggayrbeTpjFSIKU9dPG38fch9ORw8XY8Rl+hAkvsi4TbKsFMThdTwGZnDAPyv6r9Cp7ebcTsivIYp4EeNdWeWowPrUXJtB2TGExduaMWe+tlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(478600001)(54906003)(70586007)(70206006)(6916009)(6666004)(47076005)(36860700001)(83380400001)(86362001)(82740400003)(356005)(1076003)(16526019)(336012)(26005)(41300700001)(7696005)(2616005)(426003)(5660300002)(4326008)(44832011)(81166007)(316002)(36756003)(8676002)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:09:09.7275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda2f26e-e5df-496e-1dd3-08dbcef91afb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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
Cc: yifan1.zhang@amd.com, Li Ma <li.ma@amd.com>, tim.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add clockgating support for NBIO ip 7.7.1 and modify if condition.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index def89379b51a..4df1055e640a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -254,7 +254,7 @@ static void nbio_v7_7_update_medium_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
-	if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
 		return;
 
 	def = data = RREG32_SOC15(NBIO, 0, regBIF0_CPM_CONTROL);
@@ -283,7 +283,7 @@ static void nbio_v7_7_update_medium_grain_light_sleep(struct amdgpu_device *adev
 {
 	uint32_t def, data;
 
-	if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
 		return;
 
 	def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_CNTL2);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index df7462cec6ab..3ab188067d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -863,6 +863,7 @@ static int soc21_common_set_clockgating_state(void *handle,
 	case IP_VERSION(4, 3, 0):
 	case IP_VERSION(4, 3, 1):
 	case IP_VERSION(7, 7, 0):
+	case IP_VERSION(7, 7, 1):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-- 
2.25.1

