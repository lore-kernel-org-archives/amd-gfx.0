Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246C2C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 19:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD0710E0E3;
	Tue,  7 Nov 2023 19:32:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC5310E66C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 19:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwselxCM2DqbIYbZr1z1l6kE5lP+jP6cFeXVGROZ9g0NCidUzF+15L/xpPwFLZ0l0fZ/r4syq5j7nIcq0dpDA2PTCxkhFBTS+xYdtDXlS9CVELqnQDwYcL5VFhHvmE1w3Qn6NeO5sSUnDJQ2PkFl8apFpefb32CRZZdb2dFk9kgZmd6DbaAZ6cdpa5QqeBushHN4fANSmDiWwpIHM06UsaqT5XEDEWPb97E+QeiBt1naZcOMZGBeUFK1GVY4k48gw62db6QKDdlii8AAHcpq4kDZZAGvsJ8qIFNc6GUgiCU4+koQ8VoiKmgr7SZ1XYwCi+ope8ImLUlnUMZBJoe4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5eTv1rzFrARGIK9PiAx6pMG/R+Jy4ZW1AJP03pXGME=;
 b=OvOtxh7f2i3K4rQvybM7l59LeS4mTTWkAGaGLdETP8Uv9ePSNdUdJnWFQWev0Td7sdDlr9h9y6aUIiJBfhe9VQQpkoYC4Ptsi+PWYGxtbkiyzIx/dth1sLpf7R2HDcGgbNFtnTIe+0HkqNfIdxGxynJOU9P+M4MTkJXEaSVwu3lfSayk1wgiVuJDB26g5FrLR9lOKg5v7+BFoPmrvaJ4ShOUxdaOZS2R5RSXv2/Kgj48oXCfODuRaE2q2YIW+L9LYTWONPVeFpYL2kbUSLwaktfLhV0Gdja15KQTqzrzoYymi8Daoyvk2G/17xif7J30kdckRTDDXCfQePOsN0564g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5eTv1rzFrARGIK9PiAx6pMG/R+Jy4ZW1AJP03pXGME=;
 b=46zPCcZ/Y0HVpjybfu8LLz6cVRG9QNMtFeyu/h/RfPMVacK96Ftq7HlmxoH7LjnAK2H6fyvae8mrQv/pnI8CDOiIt9FXnoNfbovFiRhQXofYz3+pepjqFyjcsRu5YxyfifPLt4eJFDwQVopB4K3NXpgnmb7SHBSHZJw8oilJ+WI=
Received: from DM6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:5:134::22)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:32:46 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:134:cafe::85) by DM6PR13CA0045.outlook.office365.com
 (2603:10b6:5:134::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Tue, 7 Nov 2023 19:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 19:32:45 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 13:32:45 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Do not program HDP_MISC_CNTL in hdp_v4_0.c under
 SRIOV
Date: Tue, 7 Nov 2023 14:32:10 -0500
Message-ID: <20231107193210.2375-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: eddaf880-434d-4970-c513-08dbdfc851a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NH9QwREUCDskWQDD6NIg43g8Cl+d3QZtWUItdGX4cINc6Gx/DC9dze6N2bF7sIMuoSykOAaRRSNpt0ExRmHor2HZSx4oCr/eqrzfkL3sHEV3FWOPVT5xE7sZB790bIL7UBSz5kMJJHl4DmZUU4T+9UU78VVvlp7PnBd+iKCJnx/vUSVpJewixmcsocpQag4zuE2jfYwxCgozreaOWoFT30FuT0NJsmTKHBvocKBU4p4A0x0VNWzOeoUtTc31SUMU9gOXHyxY6YgYiUll96HsahNZP5Elr3bg7jt1+ya/uM5M2WO7tOP7qjLOcdioKuYfs4G3NI9r6li3rUXm7I2FF1xbYYVCFl+jlA1Mo0b6pzymwhz+DfnHjcmmf6ZfdXWMXg/pDXOONSlaa7F2UT5iq8CnOSNZapPrS3R90fSpuzVbjN/JZP3z7lvNOpyaWb7mVu2g6lvkkjutLtYfUFawNqtPpaY9IvFtyhba0a5JYfh2ynnbYDKUr/vkXyBnuH2stNVB061LwDNVqqMc0j+F5l23IskvgF8m6Kujs7fcTETTb+F1l8TvJnlAe8eZzYlu5IRfYMmJ0+4AMv4JONte5SUwibTVwPlpuAMCyRZ3COIvTbtm1fC85/Nq4lFCZiFmPG8aVQIQpNyG/tJouNMtz2o5Y/YQqk4ShDutdWsjy3UqG0hI+RxEWuEp6jXhvJxxaqAfh8ZBHmj14EtPmTdlQb8MaJp/gNkABTV60rRNgfOBsmJIv56stF6ceooU81uoRMJc976oeGld6sRn7h5pIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(36756003)(4326008)(426003)(336012)(8676002)(8936002)(83380400001)(26005)(6916009)(70586007)(54906003)(70206006)(16526019)(1076003)(5660300002)(316002)(36860700001)(4744005)(2906002)(41300700001)(47076005)(478600001)(2616005)(6666004)(7696005)(86362001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:32:45.8613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddaf880-434d-4970-c513-08dbdfc851a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
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
Cc: samir.dhume@amd.com, Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This register is blocked for VF access.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 3f3a6445c006..bf3bdf67abb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -145,6 +145,11 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 		break;
 	}
 
+	/* Do not program registers if VF */
+	if (amdgpu_sriov_vf(adev)) {
+		return;
+	}
+
 	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
 
 	if (amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 0))
-- 
2.34.1

