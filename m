Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F1DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 18:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC5060F6F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 18:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FC5060F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D8B89BAB;
	Mon, 25 Oct 2021 18:52:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512C089B9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 18:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM2V2sqm7XwpGrhv9+gHFogbiyoqOt5Jn5o5SW3fY0yWDfsOXDs/p0xwhqsHXPI39nDO6qBi4qq3gE++3wx2jvc+cs0YEDdhtwatQOLpBj2BQhckIOoJ/XmkI8BmCZ/wDxiJqofcUtuBNQVc7iFpXZF+rDYBcctGKL6Jfk8Ds/tk7a03p4mejPJGRVsoN+MI0mPUNkmPGC+kx8I1gzDg3NObtg35f21ol556T9tI6c4ZykdyFo0M2RlkJqgVoVNXTIUIXByREZqx3e1ZwJK/nQCW35zCxYQP/Avp8jhZQXeu3Mxa6TRPVDo6wyEmZ4pbzMiZXBMLZdzqBDEQppchDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSIxE9ADBrAMwrnLWfu23HygYtF+V0hjZCQ7/2OoKFY=;
 b=CeqGmxFtOxfiinutYcctLbaZObpCtS34tdezVz8c2qWCIXYfhdUR8Q2p0k/eYcxJiVIpQYbibNxDs9NSUSOz2j/pHHxJNW4ERqjV1SuLZkh2nS5xCwrNIwGqIA8EKLjQUvA/r4u4PfeEeKmXZS+SoY2poW0RUxc5CNvQW9CaL08gqcodtRzDpmTR8ZkjNlxFuWlqHYVSASSqo88WqrMIrXSuHqUVixb1KzGLcOjI7J19nLTbrnAKh/rnBjhCrX0sIEy5ZNHSFYCRMBRYQxJ8mpYx7BfWLIQ+9qOlAoOAlBIGciz6CAe+5k4IvlJRxVgJLOlRNWzDzACZ2FcZ+Sms3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSIxE9ADBrAMwrnLWfu23HygYtF+V0hjZCQ7/2OoKFY=;
 b=3mJNco/lTjbKnkHZ8ypxBtEkbVkPtwxhSWqwv/NdPuAAwsGdAxII3KgSQOmJ3+XnejfKwkwUxR1RU9Et64v+E7wbF46G1rec0falsSUjcqln/el/ev+vluSWFT26J8wAjQuPA0wSPAMl/OmAQkcYIAl2yM+5HU3xofbrVlVsJQE=
Received: from MWHPR21CA0044.namprd21.prod.outlook.com (2603:10b6:300:129::30)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 18:52:35 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::fd) by MWHPR21CA0044.outlook.office365.com
 (2603:10b6:300:129::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend
 Transport; Mon, 25 Oct 2021 18:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 18:52:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 13:52:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: add quirk handling for stutter mode
Date: Mon, 25 Oct 2021 14:52:17 -0400
Message-ID: <20211025185217.97006-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b458ffb6-fc65-473b-7b04-08d997e89b96
X-MS-TrafficTypeDiagnostic: BL1PR12MB5335:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53355383E3C3556B0BDDA454F7839@BL1PR12MB5335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDLy8TJq2Y3jHEZld9IaeN0AUuR16c/wShrev0qbn3cub1euCnANp95oCgas2JeEkwSGXC9uuTtMGMpRNQaLev8wPbp+L4Y1wykWym+btjaAWHNcEoU2O5+509KkfkfwhpyZYhLUgNoJNmfj96+WPctvGZzCLTmHJ3GBqHCNDmmYhoIgbAkEkGH8b6gow50lAbDLdMNvo90Q/IRb7WewPmRRmLRizYIgMkOIslfH1gpl63T0VkZDx97hBNAWWOba/5ura4+eZaOzAnA28ghC5vlpt4DJuwr+tlkf36T7ZNwVkxBZPLy3KmeTuQbc98Q+0n0EozzmdrWFCUlOSH+fp0u8s4+EmJA2HecsiZS2Msqrp00SzXb9nlClYd/UuHK9keUQlpHVb2xdQncE1zvDhXcN+Z0MVZTDLaeO7bkwFDLmE/VeJD28czrDHYoMLhKjinfPx6Nu4ZN5WW6I/xWvbJyRCBJ/I5uQYuOCLhSM+JHZ6xVYV8Qyk9LCTAQta6yYbJrTJTkOerjSoSoFbN3NTCara6CqOp0yvA2x7EuL15r2aVewYB8LPJnbMnilvIJGqMCdTUHhmfrOsM05vfC+iMmamiBvjHSYV6DJFyxVATPs+p4pvYL2HNecpk437hPFvwKW9acwwXZrhLRHvGGlZFZ2X/v70lZRJpIK+t0Mtx4Bq5rkbZiOhZsCBA+W6G4NSeD/LG8iCl1+iWP2yriCQ+OB5XhXm0I5KpUja9iN8f0jovtFCHOUPj77O3az621VRsQs0wuF+xlk1lUx4QBO0XVbX09fP/eePsCtS2OvSXvpFXjvTzhbo6nX94rxMrNG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(70586007)(1076003)(5660300002)(8936002)(316002)(336012)(426003)(7696005)(2906002)(82310400003)(6666004)(70206006)(81166007)(356005)(8676002)(6916009)(47076005)(186003)(2616005)(16526019)(36860700001)(966005)(26005)(4326008)(86362001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 18:52:34.6593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b458ffb6-fc65-473b-7b04-08d997e89b96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
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

Stutter mode is a power saving feature on GPUs, however at
least one early raven system exhibits stability issues with
it.  Add a quirk to disable it for that system.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=214417
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b8d1635da5c..b635b893837b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1295,6 +1295,37 @@ static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct
 	return hpd_rx_offload_wq;
 }
 
+struct amdgpu_stutter_quirk {
+	u16 chip_vendor;
+	u16 chip_device;
+	u16 subsys_vendor;
+	u16 subsys_device;
+	u8 revision;
+};
+
+static const struct amdgpu_stutter_quirk amdgpu_stutter_quirk_list[] = {
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=214417 */
+	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
+	{ 0, 0, 0, 0, 0 },
+};
+
+static bool dm_should_disable_stutter(struct pci_dev *pdev)
+{
+	const struct amdgpu_stutter_quirk *p = amdgpu_stutter_quirk_list;
+
+	while (p && p->chip_device != 0) {
+		if (pdev->vendor == p->chip_vendor &&
+		    pdev->device == p->chip_device &&
+		    pdev->subsystem_vendor == p->subsys_vendor &&
+		    pdev->subsystem_device == p->subsys_device &&
+		    pdev->revision == p->revision) {
+			return true;
+		}
+		++p;
+	}
+	return false;
+}
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -1406,6 +1437,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (adev->asic_type != CHIP_CARRIZO && adev->asic_type != CHIP_STONEY)
 		adev->dm.dc->debug.disable_stutter = amdgpu_pp_feature_mask & PP_STUTTER_MODE ? false : true;
+	if (dm_should_disable_stutter(adev->pdev))
+		adev->dm.dc->debug.disable_stutter = true;
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
 		adev->dm.dc->debug.disable_stutter = true;
-- 
2.31.1

