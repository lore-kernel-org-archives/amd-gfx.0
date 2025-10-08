Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6424ACAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 08:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B15810E1D8;
	Wed,  8 Oct 2025 08:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YRpFhON7";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF5110E109
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 08:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4ID4kc8TKfKpGBO0ajNgGA4FidREzZ0rAsxIkzFmbNbysP5ahVSlAUBl1946kM4edb69zPMtW+OFBTSIzF1uPgQocQJnNAB9b2hL06h7G2w/1qCeC0duMuxrivZ1iCZVqq9IvEpJp3WBOKL9y+fxg+g+UbVq7TgMVGa6yezrl/vqWTd0yKTI3qxocYIfgUL8hAmmVRThi9dYb0iKOq0kULN34kXtqqbS/isZglVqtZ3VAMikgZ0YkAe1+o4gFYxfLGHL56Q6oARd0CrfzL+KCcIlzqnIlew7D+x4F3GGFC+vOtYQs9PWAZkuy5WYfUcFFwBUVvPmzoErFkAUWfYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYoCKaeU5hG6X4expa2BYUDYMvJoZFZem6m0Niimpeg=;
 b=GbbbaX4wXCTfyc88lufYjNReETCBT4dR7+8lR024JRM6jQIRFO586kXKnoaLWyZFHPLuqHUca1H6XeBOztvrCy5g5nfVk585UYuxKHkTOMsCyfeiLXn5MGZgidPB846beiH2yzdPbHAQCmKlFo4MBKw860CsIylideE4Nuhn13+Qf115kJsjsZXR+eBwI+Pl5ZrqN5lcJ5QJsO+uUFnX8kxQ7dmJcm7mh052RMSCQkDnkciByU0GkiUqIwFw5lhwjf/LyE5kf8gBnVYQsteGndL6tj/sCNC1gax9UesFMyfWFcTyvMARpGGZzZ2IEI3CPY/2umxkSTfa69I03OoFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYoCKaeU5hG6X4expa2BYUDYMvJoZFZem6m0Niimpeg=;
 b=YRpFhON7nbMCWb0WexWREyfbGeOGJUqUcPL82CZtRn/VxdFGfVrykkIM+pZfVw2Gnw2m4X6WK82AHlx738eSnipb8pWkDMZ0AQx1ohcUCEipqWMshRUI5vqyM/2mLrsTAnZCwXAzTdWrPcX9uGgKreaMzmm++EYp0qyUeZsZ1t4=
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 08:10:38 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::b9) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 08:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 08:10:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 01:10:36 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Move reset-on-init sequence earlier
Date: Wed, 8 Oct 2025 13:40:15 +0530
Message-ID: <20251008081016.3411285-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251008081016.3411285-1-lijo.lazar@amd.com>
References: <20251008081016.3411285-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: f15322a6-f39b-43eb-c262-08de06422a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s89JL0W3dskThsl8vtTkHgmQTn1VSuWKB6gQZZQoxHBK5p2cvBYNXY2Hm5WQ?=
 =?us-ascii?Q?XlQd4qjThm4aVH10FblPxByukVuFl84hJxxZvZ8auV/FYNOZCpE04Q6vxmov?=
 =?us-ascii?Q?jOSlPFutKdBJRSGMTerKCLKzRbfLiQJx9kcRd6mRSegGfWVsqdrSyOAUhbMw?=
 =?us-ascii?Q?OMBTBCwgvV6CP5yOPuhC/noEff9jv5O2LkVYoTedmmFsHQDSYhBVTRjJ5gBs?=
 =?us-ascii?Q?A80dAPELpU20odf9j/QDnLlpTF6ycNWNOfrKM5KIM7kZRNMlIVZukz9fVJzH?=
 =?us-ascii?Q?w/S9CZa+VtJ59IrRtnN01rGagn/l/kfjS65PEA5e8xHKVBpXTZ6Z1zqwZt+3?=
 =?us-ascii?Q?eIfh08s/i7bOjEXNGS/sS8CXo0cFwDV+jQyGSiMCCtArAaZ5yLK2vibWw9h/?=
 =?us-ascii?Q?OPHJqjYwUWt0g0Ur10rhccVxXuHdVvHEEtxlh+oluaH8UnleKOLAG6eDMmWc?=
 =?us-ascii?Q?YDe7eLxPoQDbnxXDZToz4LOAwYutfk1Ks14q07MFHoLFZ+K/bG/cjU3V5pwQ?=
 =?us-ascii?Q?78ZQUBI/ymZl3JLnxp2wDMuu8xzT77+z5smVRzvnwSrtF7fm+ASEvtwJQJfU?=
 =?us-ascii?Q?96ptcgiP6xShfrIVR2wEYhLOHPEEtX+MwgqfdvxrtE+xPAw6I8K+JGFmwW0m?=
 =?us-ascii?Q?VNlM7YSDrCf3y7499PvfgBRfpnI3zziLnh8xee2/EPnqoUe2QszYW1GcIv1U?=
 =?us-ascii?Q?rJNhxyGAOUnsy2uEvmcA2cuegJG+b3r3p0klT93M47A2zelbpl//pe9fxjsp?=
 =?us-ascii?Q?taKlI2/FcB1XJcs+Gf/rFApbOP+vaPWfUZPq3vssipsVCI7lBXZhixmzTaBR?=
 =?us-ascii?Q?VpEyKKRLij8F3paKmPiND8qM4iHZY5OtUlzNTaMXg46AK2T8Rjsqv5iPLwyT?=
 =?us-ascii?Q?zG7ZBdDrhV5h5ZW/YBFinq7266BmNDRFGIOKo64xsgP7aTr9eouFJPDQ4KNB?=
 =?us-ascii?Q?8VgV20TCpSzNEFON0RjhZ4pir6c0JRC4xzu+q9VoB50ypcjNOK5e/ezSvxyL?=
 =?us-ascii?Q?RexjfgE9/bIxDAYGW0irRc4SUywpCP9r3VAIJh3jZMAc6NFk+1LoGlHkoFDi?=
 =?us-ascii?Q?M4wD7q9AtPRppcqQLKK1b11l+VEko2IZyl08S4Gh9xfcHM6pE7w2TT53Z5fx?=
 =?us-ascii?Q?dhdL9gYqL7CzQnVV1kyDFTLBIGUTnZaVmHIHDyyIeQuzrBOiYfjUkBJlsIyb?=
 =?us-ascii?Q?Sc+VxoI7Rm7LfdvqqLgS1QY6L+e1HaVNlT1I1Eqf1+2Mw1CRA9barha26w6n?=
 =?us-ascii?Q?diw/dE9BTfAgVYYYP5o73AWQI0ij4qKrm8ALTQ+d4vTWUOi544fPPQMc/Orh?=
 =?us-ascii?Q?7Z8h7fY4LD7coHcN3FMXUN3aOdDCwepBbdoIz+lMpPZeYCfm4z/iLfQsNQ7J?=
 =?us-ascii?Q?Ft5o7EJXFWO7vFW0T452GjQCqmUprstwJ4fB9VcUZUsPQ7L/AXelpo2iX+8u?=
 =?us-ascii?Q?0Vh9E1DwJg5ZOMD/RhsLOBnQfmhxa08mchj+qmYIR5QVrPNB1o6i4VH8rfDV?=
 =?us-ascii?Q?/v7DZCdtyMot6vMJtWgECuY9seLezHefyK79Q0OxJ6pUnmAy/ieNUIUftj/X?=
 =?us-ascii?Q?x3oDP/VNh3J8BU3hFK0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:10:38.1689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f15322a6-f39b-43eb-c262-08de06422a67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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

Complete reset-on-init sequence before sysfs interfaces are created.
Devices get properly initiaized only after reset, and then only sysfs
interfaces should be made available.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7e428e7bffd6..3bc2bc0d525d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4856,6 +4856,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 	}
 
+	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
+		amdgpu_xgmi_reset_on_init(adev);
 	/*
 	 * Place those sysfs registering after `late_init`. As some of those
 	 * operations performed in `late_init` might affect the sysfs
@@ -4889,9 +4891,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
-	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
-		amdgpu_xgmi_reset_on_init(adev);
-
 	amdgpu_device_check_iommu_direct_map(adev);
 
 	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
-- 
2.49.0

