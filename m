Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2111FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C754D61212
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C754D61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E5C6E0B8;
	Tue, 19 Oct 2021 21:49:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC966E0B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxECKNdfXCjANqG9czAMKHUlshoysv83tf1/OpfvaWyUKdu7o81170/H7NTmGdD1OE7svye88tLEKXJjHZtJKdLQVrcK1via+pWz5EX8oyxa0hcpiw94Vxk/XJvLpVMcj+x2aIRz3CNAJl4XtPzZlrZmSCDe8BZnX6mWbt2guu+2HH51BXCJdg0iJKQGwVOktRYdCgbeTfna7nlrLidBA5E5Q7MVgynrE1kaA48DRS1f4gw0+Lskj0QX0EFbw3qb96mlWkdyMKpBYuMfpYCikxRsbd5grBp6wlCNG1oWGERzvLmGrympZX9YwqK8yekMM5iGH/J3tEUA6lWtFOQdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb7MaNhIj7D3oHrW+4/gU6lt9rXvAdGLxKs0AsWYZJA=;
 b=ZYOig5wvESMlGS1LvD3pXN4yXiJeyphZ+Mx57dXrUysR7h//ZYzlMb0xU1XKijQLHHqX6XqrP1F1APDIXJTdBoSpkCgjTPQgDyDIuIh1DzOHpdSISlGMPsWRXPuG4Tn25U4d/BR/Yr14rrKsGoZDq+wSsculkWUBPXo/HWqBr5nncWS3ejeGx1q7jbpq+0Hoy5+d77++96ZDeZI0WNZD156kG/7tMnN6tDVf7CkUkuNnn/3QgHCBA8uvZx0JdzUHgPe/+OUMRDXg7ZWSp1ojh9t53vWVwZ366N6LnqFtHslPJU9XsU0nsd4j5eTCgKm4sc4Mk1WUhSmXd5n7fEtb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb7MaNhIj7D3oHrW+4/gU6lt9rXvAdGLxKs0AsWYZJA=;
 b=GrqeDqSgAVYA37WK28qtGkU6/Rav+CLgtBBshg/P6KiavsRX6DNMCzCUPr0tXoQck8m/CdgegIUg5AI2q9RbcmUXyueRWk1yRCT90zG0kolQpLXxRs8YXfRcRbxB9i+S1KVSiOfaw9L3GFrLyNbJANOoczR/mmUw1AOQkKmrg64=
Received: from CO2PR04CA0090.namprd04.prod.outlook.com (2603:10b6:104:6::16)
 by DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 21:49:38 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::58) by CO2PR04CA0090.outlook.office365.com
 (2603:10b6:104:6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 21:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:49:37 +0000
Received: from VC-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:49:35 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <David.Nieto@amd.com>, Vignesh Chander
 <Vignesh.Chander@amd.com>
Subject: [PATCH] drm/amd/pm: Enable GPU metrics for One VF mode
Date: Tue, 19 Oct 2021 17:49:34 -0400
Message-ID: <20211019214934.4088-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db55180-61a8-47e1-f1be-08d9934a590c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4911:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB491141CF50487CA9053CFA48ECBD9@DM6PR12MB4911.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kv6IqOUTvolJB0hWHarhZ2COaJmSbAtrUrJKFULtIBLWNXM7s5lGDlFMUk4Ur60jJx7S6JyVYyT78YOrjzaxMB4jG23p10spFCXcBLnZTjVjoKKnMvN7xmCR4TsjDCzfg8alCxVNmnYdOnlEv4BaUGwGhQXXWi0Dro5HBIxouPi4ehuaSECpdKSyoWYYwkRxmDVfQK6meaOtDqtZCwSAyRpaMYvCAGIOrqqoMDw9XUgRmnXz6Z4ns5Yr8Eir1cYaKRjH9PIDgvJyx41jE8xa3LDiaxlBA3pCpRZKkmzyIxidCNVOZ+ZRSI7HNa1IXU2ICKHP+fqSVVXbtsj6Hp5ca5pLoMibDRPtB/PkF+TZjVNtnRyKzIwwp0LFtfjq/qu/qfbRKcY4lrlZmufosDNPM5QzdT+wRcQCw0LNTKoDQ6yDowzBqoCUG9fYPYodf/zWb2s0FBAnvph5plfNHZ1ezh0p/wB+qBMcxygoPkg4d6Ed2LmUc9fJUU8MSGCcvhM1FSe8vDhr8GwHcQkSRXZr+Juh4P09iQNlTfpAtcYkd37vRgaXplBXYehpeWoJdxFbRI/JqkOqICkIYHkuHlrewlqaLKe/YbZNLc4wtLci2kgWlKD1+O1zn5FwO+D48H4tYnFi/QfwkD8VxSAaKIEDzuHqILgz1jXN+v2Mh1F7jGZrYX7qjlGBpg2SoawCt2m217Ryi5e51FckCT4uobSH74mbLytJe1mFcNeskTlsvq2wfDRqrv4aLtnGq9aAYYrxsgYOtQuUgeZhO5ahBOj00g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(36860700001)(82310400003)(186003)(16526019)(7696005)(6916009)(316002)(70206006)(5660300002)(70586007)(86362001)(4326008)(54906003)(2906002)(508600001)(426003)(8676002)(81166007)(2616005)(83380400001)(8936002)(47076005)(356005)(336012)(1076003)(36756003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:49:37.9000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db55180-61a8-47e1-f1be-08d9934a590c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
Change-Id: I14a5c4d6b9d790b7f298b67cece2c501a003e2a7
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c255b4b8e685..01cca08a774f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2019,15 +2019,15 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,			ATTR_FLAG_BASIC,
 			      .attr_update = ss_power_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,			ATTR_FLAG_BASIC,
-- 
2.25.1

