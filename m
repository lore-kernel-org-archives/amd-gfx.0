Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467F4C3ABB2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Sep 2024 20:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7CC10E3D5;
	Mon, 16 Sep 2024 20:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6QytyPp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A06410E3D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 20:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcR5bal+VN2jRuEZrhq+IIGmk0v1QPInc+rT08OCB1Ymk9M6PsxsHVkb4mS8SxirVTXJfToLiDTY5JmMTX3ksOxxAOQg4rt7/Siy8xf/iuX6DbscX7pNmNrnANX70xf7cv0f+zHAus6SgFL3s8A7F/BZspMbvM7ivjrbcYAyWlvrrLWiGAF5qFmpX4CxapCDtwFaP6RHuRrq6cjWxc8Rz2GLgD4B5PG0Xy7+zA9mEaVfWOIK7RTLjvQJmtcEebu2jJErZ3/QYIDvqdghIRgNi3wzJXKJI///kb3MZNklDr2hnuOUgKLMiOmwkTu3+GgpkXZpMEyghD/dlG5tb2UbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg3WFf5t0sshG/9cljXO5NuD+fJ5eHYkiYq1by5nySQ=;
 b=p3WhIyXYfQb1d5J7V00gmUUs5U/3Hz+m5mQw1cPHpfppy6ljmQHf/9KooetZKy1IQgTqUhxKviW/hxfxEqjRZFPFBRpllEzGMT2xCH1Ey6SuCVjRX/NeRDeQjbjjFfrZdJPtdN7CJIlnlz+NsBfWvUT7KMDww282EcDDNZ24MK2kFTgswp3eTBoi43Zy1xiWXij0zQ0ivCFAmy+zTMV0GGMsuTGRci+lcih37Q7Q0nTPA8+PEkOXZdNKWXyY6xwpKoieMSMt/RGOyvprVRVB0GTy71iZy26NJHQNFheu/z39h1yEsJlqlFfcBjkskOzMcblOWd/UQPoKOizvaEAzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg3WFf5t0sshG/9cljXO5NuD+fJ5eHYkiYq1by5nySQ=;
 b=b6QytyPpiUoo8RpFgCKskqtAng96tzLzjm+QXFfhuV69T67mg5Pz/ezuIuxWVKtR9PUdGq0lMZqMp0RHk8sld4FSwXrbRy6bx2ro3TJJCtHinAvtKXFDNLZVVty5aTOJp+/c7uE5aHJHhY0sIP+QyLy+1rfEnVCvZdp4RKfKgEE=
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 20:02:17 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ad) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 20:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 20:02:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 15:02:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/bios: split vbios fetching between APU and dGPU
Date: Mon, 16 Sep 2024 16:02:01 -0400
Message-ID: <20240916200201.1874797-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a3b6f6-d171-4ef4-1c71-08dcd68a76f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6i5Zd8H6LMNJIlhzfy6IvmNZpttz73BFkWGHdFVU1ZOwbEumLWtJerZQu5NM?=
 =?us-ascii?Q?eIbZEvPF1XyFT/tAhXhEHmihdPiO8kSqTkCOfweTw9p47Ln/83FEICLVEwvB?=
 =?us-ascii?Q?sd72N8OVcwFIORMpvg82EoL44xOCOoY47j98sGGjgBhN4x1Oq8udDxiZXL0y?=
 =?us-ascii?Q?KLC15c4aYb8UjX8r6XPi3VGfM3m5TzeDVwxGZxJD0V+bDyzMerTVG6P1IS1B?=
 =?us-ascii?Q?uwShpoyRxQAJ0ZU3QebIjMmW+QGS53+GYDauBX/tb1/psfVjIpbssEpfR6KB?=
 =?us-ascii?Q?0NFRf+jJ/LJ/7U8//VijU4/kWRE77/Q2Tur8L4SZ8oARFa3+Zwy8CSUVin4t?=
 =?us-ascii?Q?yngo3YnwAsDO5vPQULtG4stoo34y8wUQbSEZCsUbZKTWj4V6AB8K9T6qDEIR?=
 =?us-ascii?Q?Smck7Oq9iiqK9stz1wiKcFI6t8LYEd5PF98m6pzvh81sreQLWVqIk4lsqE5Y?=
 =?us-ascii?Q?lCzo+GCMvzJK7ZyPti4EBaMQhJcgriCp9LX1FotmPSEdBAXafd+1AiXv/efY?=
 =?us-ascii?Q?TRLWZVNllfvhobpCTuszAwMm1BQyiQUinXN1hlte4vSWGMCwFOXxMnLy2tOW?=
 =?us-ascii?Q?wnUyMp2bUo5Wi0+9yzhOeCaDt5SbVDuaEuwyf1A4Q3hDjT1sm1TMB9oiQnTe?=
 =?us-ascii?Q?+C5NJngqPVMxrhK/ztKsJOGCKACTRVvGtWcBzadFXdN8pH0Lw9arOJRlkWTm?=
 =?us-ascii?Q?AxcCP38IvGUghhqQzY5GrOxOcEuhbKhAzctxtFN1xFTrXUfJojodC79BfA0i?=
 =?us-ascii?Q?BYYUdhTdhA+OOsp368WVnNulECpYC8/B6OJIf2XZ2fezJf68WEY/CFbWLXjA?=
 =?us-ascii?Q?12mOLKDQ4t8kEqYBftIJkB5lUdhMpQ225yH+B9EMhzq4oC/V5zwD5+ysEYSU?=
 =?us-ascii?Q?ngDWh9LhyCn4RVn52UOH5hGtNWMWWM6ZH2oDP4Ytt31Dnbfrx8nj3PEK2Wsh?=
 =?us-ascii?Q?9oHvZ3SIcriupD/pDz33To9ODK+cm2xFVu7kki4j8NgBMOeHwISdQFT236rf?=
 =?us-ascii?Q?qB2a99TLElahseAXtqNuWZbZOFc1EjEnc9W/aYBnampY2bc1fT9BCTbkW9QW?=
 =?us-ascii?Q?Y9dP8K7PTrYVO1hhitA7O0hY/ed4nBe4MpYB46LmH41TgCdqTbxJ/T+wr3Ps?=
 =?us-ascii?Q?YMmYEfATYgz14TGag+w2K9Lp4IzNOYih+M3wlVRmMJ5RpxlKN8o3PsmFFH2c?=
 =?us-ascii?Q?YATqJEN7v3CkIS2yvZAodjW9tw9PLWQXSN3K7x3LsOyLrhZQ9xCTOjeOBrBT?=
 =?us-ascii?Q?bY+hTwW3zwCJe2QksxuMTh3nav3Zslarwh1SeL4RYLqU0sYV+ii1I4gph+oi?=
 =?us-ascii?Q?hy1kcx2qsBsz0P8NYE3ozDE0wUVay89h2FLAc9SDXUvANnCVSAgLY2DloErW?=
 =?us-ascii?Q?l5kxk03NYYNs6cPeJZpwdW6BI5Xph4/IrdVBztud89qdULC54mwLsqZMXH1w?=
 =?us-ascii?Q?w0YewOS83vsf8w1Cay8V8Tg6KDnybyZt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:02:16.5689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a3b6f6-d171-4ef4-1c71-08dcd68a76f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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

We need some different logic for dGPUs and the APU path
can be simplified because there are some methods which
are never used on APUs.  This also fixes a regression
on some older APUs causing the the driver to fetch
the unpatched ROM image rather than the patched image.

Fixes: 9c081c11c621 ("drm/amdgpu: Reorder to read EFI exported ROM first")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 47 +++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 42e64bce661e..e8f62d718167 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -414,7 +414,36 @@ static inline bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 }
 #endif
 
-bool amdgpu_get_bios(struct amdgpu_device *adev)
+static bool amdgpu_get_bios_apu(struct amdgpu_device *adev)
+{
+	if (amdgpu_acpi_vfct_bios(adev)) {
+		dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
+		goto success;
+	}
+
+	if (igp_read_bios_from_vram(adev)) {
+		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
+		goto success;
+	}
+
+	if (amdgpu_read_bios(adev)) {
+		dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
+		goto success;
+	}
+
+	if (amdgpu_read_platform_bios(adev)) {
+		dev_info(adev->dev, "Fetched VBIOS from platform\n");
+		goto success;
+	}
+
+	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
+	return false;
+
+success:
+	return true;
+}
+
+static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
 {
 	if (amdgpu_atrm_get_bios(adev)) {
 		dev_info(adev->dev, "Fetched VBIOS from ATRM\n");
@@ -455,10 +484,24 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
 	return false;
 
 success:
-	adev->is_atom_fw = adev->asic_type >= CHIP_VEGA10;
 	return true;
 }
 
+bool amdgpu_get_bios(struct amdgpu_device *adev)
+{
+	bool found;
+
+	if (adev->flags & AMD_IS_APU)
+		found = amdgpu_get_bios_apu(adev);
+	else
+		found = amdgpu_get_bios_dgpu(adev);
+
+	if (found)
+		adev->is_atom_fw = adev->asic_type >= CHIP_VEGA10;
+
+	return found;
+}
+
 /* helper function for soc15 and onwards to read bios from rom */
 bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
 				     u8 *bios, u32 length_bytes)
-- 
2.46.0

