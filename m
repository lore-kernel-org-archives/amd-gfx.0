Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A011C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9DE10E1E6;
	Tue, 14 May 2024 06:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FEL6GhDu";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E4E10E1E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyAkuGZJ/P8r70xAU8ZiqFWpXq/xGrrEw5PUiSVI9wjFq2PXofBb5zQrzXJJFC9n9HaZ903FopmCDrl82cz/AKvGi92iZ/VNDmtGUoDqnF7+GNRNBYkQIG99fT3v5V+3ly4PkHpzTODzflGMWzrxRq0MF7arMRENM5RL/panv/oF4wq2WAneNR/TAUX0j+vFNoVm055il7KDureWOzkjymTjfJqKyf7sdBx09aolJsgBV+z6WO9mKABjpRXKsZUtwXfqHcluXaE3fhUoe4EdpHoTzCm3wzy1rAJn+NpPlWfctf9/ba/XFRk+9suIpjC/+lhut8UaRyR29+qO9xxkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5TOz4Rprz1kLqkemo0YlepbxkMmUjDIly7+PXEqPvQ=;
 b=YllNO5vpLQAAu2oMxjhPMBSgk2mwlBk+uJthN6PjUrnz78H2vuLTRjyPAkVqNwWWxGV5HtCBjQX2G+Kjwx9YrpZIAGVnJGoOryE1I5to2gwzAMFVDkP/s4xChSximlBR6jTuF3OLHrO5xHK0qAVh6mEzdLEDpn7arDC7D1baN9eWEkx6zQ0jP8YaXNOcG+HsMf1/MgbMOxKyGtQtipJD6bCg7rnSdYSXQzJbU/52eU2HAyjiVS2Pf9w3WtKJ96Z7B9h2S316qM5ZwCvKZ0H0rLCqlRkIhq9XN75u/um/+SikK0TiVQhwyWKtR4pd2PlHP1pRtw61dytxq/diIs5nJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5TOz4Rprz1kLqkemo0YlepbxkMmUjDIly7+PXEqPvQ=;
 b=FEL6GhDuOFv9T2Q016YaVVIG2lAhxTogkp3BI+eLlUqtTm0Y4uuJO0HA7f2fOiZUokQlVW9W8zkLJMxvjPT+9R8+Q9QKqbxQG7QzV3EDWT9hEQiaXrnvQ8DdttTCqSkJqgYM4N2b4pgRrSrsiB7UMMtBteSU+GMeiR5MLnFlB64=
Received: from DM6PR18CA0034.namprd18.prod.outlook.com (2603:10b6:5:15b::47)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:55:14 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::aa) by DM6PR18CA0034.outlook.office365.com
 (2603:10b6:5:15b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 06:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 06:55:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:55:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:55:14 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 01:55:12 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: 
Date: Tue, 14 May 2024 14:55:11 +0800
Message-ID: <20240514065511.3651706-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee76096-9f5d-478d-8dab-08dc73e2ceb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kjK9vcWgvUhleTEzcYjgE9+77R39MZl9ecUpDRB8WDeW97FWZ07+wIuh8dzZ?=
 =?us-ascii?Q?ksYY9Jk2OW+7NgPFb47lI/jchYJK/yBMNywORWvXP/L58QxA+aY+blh1qd4Q?=
 =?us-ascii?Q?HR98tJi0aBfK28B8AvuljjdWloWH9/przR9tXHM2a7Sn2g++jDa1FdaXeifg?=
 =?us-ascii?Q?0j1JaKyVlsL3QPN1ef8/o/pWMPeMDWjXkG0YEHR7PYt9gKnVWzpxu9I1de97?=
 =?us-ascii?Q?d6w8Kijl0u0ObbQ+vYtSpNuK3IdZiCCf5bAWBKEfl7UEVWdBCAFP/5E4BXT2?=
 =?us-ascii?Q?XGQNuIR3wboGt6Imer0so/200oHfzIo5uJezDphVfCnNhUYbZQ/CdeF6hyvl?=
 =?us-ascii?Q?9KsuStyBdcyJpEPHBAANzkPwnY+48f0pXWURArzJF2IkIBGhFa+xFPTE6EPs?=
 =?us-ascii?Q?2ufrD26hiNbcekK3zsx7y4Qg1SbfeW4Mgvkn4BdQpf3iDm+aep0tzs8SI0v0?=
 =?us-ascii?Q?7bc6bCAoQhI6/BaSwiix1BysPfbvNaloTebW17bmK8q7eLkeGXvC+NQ3Fzo2?=
 =?us-ascii?Q?5rqMtQ9w7ZMizEfwnB3WWgfPEqN8OTZGX8YC9TqCSdaxztSOxeU5W+xLpCC+?=
 =?us-ascii?Q?pY8EyjXAAAW1DBpVbqH+N4UDkl5XSkLD4cPgj0UIVYlI25hnv2TsrCpa9Z5J?=
 =?us-ascii?Q?WDxiqX5KesQIc4lgV02LfmDx+le+U9zvKS+rg0K1zasMLNYULLyLx0WzOsbq?=
 =?us-ascii?Q?R+FevCH7NHFwqrbuuSYMSsXrjaQyf27zhab5JZDP6iOBkczeUHeHDeZyeKVY?=
 =?us-ascii?Q?qIFxllrr4m3LX8JWJyS6PLZAJk4Xa/WTmONwduhhoPCuY98mLsPX/UlRUIC9?=
 =?us-ascii?Q?MIdW4Z7whhEhDqdRvl+C/M1vjOtEp8IKJenzY2ZPF/iktgZ6w58XEfyvih6w?=
 =?us-ascii?Q?Y96Y3wXFXJYfW7CpvdK3iE8onDiWPwaMGbFUVS/c4N+Nnqz68DYR6raB+B/p?=
 =?us-ascii?Q?cAIfLBPwu0wrJPTtJnE8xLqsmBGgZ6oS0yd+pVFXuZFomkEl5OtTCqVcuZbh?=
 =?us-ascii?Q?rbxQerc/pyBT2LakVV47NXkpHwQVchlAVEQOdgakQCj2FIGcth+SGVQ5R1wu?=
 =?us-ascii?Q?5dZWJA5wvH8NimJlU3P6B/5PlB4j+lVSOalooXQCEyIDugROK+FYWcTbCye1?=
 =?us-ascii?Q?nRFdU6h4vLfV/LhOA5gfnqGYeAEBtWUmMmI1QXVNdBoro+1hmGgTG925jsLJ?=
 =?us-ascii?Q?S5S6OCp9LgjCjbfwOAYp93StfgqRYAs5J1fK0vtSj02yEJmkvqeAFSjFTQ88?=
 =?us-ascii?Q?XCiUFkDz04H0d3SlG/ODeAV6Vx2aMpo+dmfzaYybLR3aKJftPpk6Jypg7F3r?=
 =?us-ascii?Q?kRZ+579mnnkxLDmSQZCyELwJET0qrzcHOkhmassVXFhhfU1vdrBvx1Fo0KpD?=
 =?us-ascii?Q?XwtxVrZiU58F7ghvb/mKP8eBdw+i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:55:14.5594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee76096-9f5d-478d-8dab-08dc73e2ceb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

From 3348a4bb465834b165de80dc42d11630ac5c6a83 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <jesse.zhang@amd.com>
Date: Tue, 14 May 2024 13:59:18 +0800
Subject: [PATCH 2/2 v2] drm/amd/pm: check specific index for aldebaran

To avoid warning problems, drop index and
use PPSMC_MSG_GfxDriverReset instead of index for aldebaran.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a22eb6bbb05e..d671314c46c8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1880,17 +1880,18 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0 )
-		return -EINVAL;
 	mutex_lock(&smu->message_lock);
 	if (smu->smc_fw_version >= 0x00441400) {
-		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
+		ret = smu_cmn_send_smc_msg_with_param(smu, PPSMC_MSG_GfxDriverReset,
+								SMU_RESET_MODE_2, NULL);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
+			goto out;
+		}
 		/* This is similar to FLR, wait till max FLR timeout */
 		msleep(100);
 		dev_dbg(smu->adev->dev, "restore config space...\n");
-- 
2.25.1

