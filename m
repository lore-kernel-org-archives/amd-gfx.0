Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6E7C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 22:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B05010E15E;
	Fri, 10 Nov 2023 22:00:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D2910E15E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 22:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=capUvXIl6vVZq2mNKX++Uiu2rFFtRxeAP6qZ5stnnXLbuqKQLl/CtIHHSR/BlvBOTqfSBU6NNRWu9jFgDBMonBiqAbLc+rOvDEi0p+AgIhSvfZhTz57KtHYFEgwuhTDXXrS3cnLhvi9msVR5zxQF2PS8MEvcX+zAERZo6YytV/zhZ7sOrCv1G7QGdLXYOapUqTJ5z1vnpxvzE9xwAEJlY0z3k/8jI5BX62XLrVJ4OHsT6bPMQFYt7emPx+k2yEHfNQXoKe97nIVyFeaq8tOQKkpG4/gH2KfTX8otyfsx8BGitg/BathxRLrj75F1xPbuK+syxpDufg7W+uTW4FW6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vHkQPUM6g4KpliOSWyNsqfKPvFlGGzZL66YlW76Iqw=;
 b=QEbQLeiQLlwm8lZfN4cy5c+VzzKUOxMoapZgj7z5tOw5P3cLNBCZYdaxd0xyYrdtasCerAxODU6TkurOhx4lYjawD5Bd3DTm0uqHVrxdJ2MQ0euzknbcGP2tCJwbGshkLSCRZNEysgHTwb5vsrEG+ZXTqsiKP954TEGUDo93SSXlISnH8+SW/vEjKAPt+RTflNRC2f7eTSCidN/+rSbqUNfScUq6aZrzKCICbB+agju/HW87K1fy0jRFsajh5XUZblWNFkODCzHgjlTOwfJRlA7UseGXgunuvMdQaGjZTnMxErEeDagAjITcViwu4Iglt7Z8aegx6xMOt+3hbLrcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vHkQPUM6g4KpliOSWyNsqfKPvFlGGzZL66YlW76Iqw=;
 b=uxcY/5A0SKLdqAaEEXHyVZjJSL/Nlhl1M61jKO4ASF0TKGLHR33db2yrv7eTYTXxi9OcpzvA8ClL4mQxhRb2LsP9zGFugaVvd052zkKLi/s57x/AXbdd4l/Zs+8rO9OA7H+VWWQpktFSYgrKm9j6D2yzf14fT5dMEyxrrFI2rEQ=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 21:59:59 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::c6) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Fri, 10 Nov 2023 21:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 21:59:58 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 15:59:56 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Do not program VF copy regs in mmhub v1.8
 under SRIOV (v2)
Date: Fri, 10 Nov 2023 16:59:34 -0500
Message-ID: <20231110215933.3265-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MW5PR12MB5600A804F2DC648D9BD863B5E6AEA@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <MW5PR12MB5600A804F2DC648D9BD863B5E6AEA@MW5PR12MB5600.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 177719f8-dc36-4efb-ba37-08dbe23861a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wg1vK+KAja3tPCIEWpHT6b8f8l9qt8tu7m0M/R1K89UP5YGllRmCyTQKRlKTCQazvD8JsoFky95KvEBGe0rglcaVXh8kTE3H0cj9M7XJk/4Ghwe3b+CBy7Fgh4Z95XaX1Cog6oTdaw9atQysl40Vbomr/Tv61mhYzdoRtcrVyaYf1zIzIJE9hXquEihJ2d1zDhrTpGVb6zyS8kMthC9aI89jEd2qLZeVNxnhW3MwEqtjM/9nt7nSmsN8R8k69WGZeXEiqalH3FjzLveC7/w+JnaIhVDVEMRH0cKI11RUBIsccw2M0U86GOF/kPqSgTgPJxg2QewZFOzvEPHcKTVVmRNtnwCvMQtJk3ZCi495tBzglvP1ZuNkIWsIgNYQGWUfC2KlKHG6QD8bEAP36vbpRXb4K/RicegucnATXcuSPSZ6EXghCv2cCefakwcT1zkHLtVJisJCzJN6d94FItLRbfuRlzch9BsBxiu0x6TraU4a40+CnnUYMS6fcWaZXfkxI7npsMRZCM11gzaXOWYMbSeG4Q6B7RhhP2u0yudKP+tPBPcrT3TXwaaRBvA5IIl5oaFLIhzliWm8kY6HPRre07INVrMkTTAGz9UwiIrhpioE2y7Z6vQM7RoBum/NmDkDC65mXT3XfMzhDvoaCinKorcR5T6QkMDEj0foG3gjxuOPKVayLgTtDZ4XmM/2SYAHCC8BCU4qETBtTF4nJbdpu4MGDL4IJ+DfU1z/td4t7j1Tlv6hJD78NrQGEdKd2QNblDi78H+fUV8puCmczjK4bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(36840700001)(46966006)(40470700004)(8936002)(83380400001)(8676002)(4326008)(7696005)(426003)(2616005)(316002)(47076005)(6666004)(26005)(70586007)(16526019)(6916009)(54906003)(1076003)(70206006)(336012)(478600001)(40480700001)(36860700001)(5660300002)(41300700001)(40460700003)(81166007)(356005)(82740400003)(2906002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 21:59:58.4057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177719f8-dc36-4efb-ba37-08dbe23861a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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

MC_VM_AGP_* registers should not be programmed by guest driver.

v2: move early return outside of loop

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index ea142611be1c..9b0146732e13 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -130,6 +130,9 @@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	int i;

+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	inst_mask = adev->aid_mask;
 	for_each_inst(i, inst_mask) {
 		/* Program the AGP BAR */
@@ -139,9 +142,6 @@ static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_SOC15(MMHUB, i, regMC_VM_AGP_TOP,
 			     adev->gmc.agp_end >> 24);

-		if (amdgpu_sriov_vf(adev))
-			return;
-
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
--
2.34.1

