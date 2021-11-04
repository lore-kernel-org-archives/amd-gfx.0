Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E082C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 16:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0BF6113B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 16:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C0BF6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B446F9AF;
	Thu,  4 Nov 2021 16:09:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1038E6F9AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 16:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgT5l4aWVJISMb4AUUXgXXHelvt0DTbZ1vKYidPP+IMOAoTb+kTmZ5U8n7Q4W+Bq6yaqC0pUyUDHa2BJMvVPLSz6+uRbO4O4VEyj9+Onl6AX7FWNuVBpngr0/hHwTX0lFUhKvS85HVe1sP/E3HzhErybqfwOBnknLv4V9OaU4/B+C3rrtBWUT/rEfcCCG0Sl/7nvrfklqKRel30uJ8qRAnUooNuduTnG6zTcJpPzwouKaDErNCLtmCa3XyAqcwbH/nV5ChMh6uZgCq7/IHfpvS5WeW/VOVXpVGfzo/NSV7ah3VbWrXBik5xQ4E2pMH72rAhzbBnsuMtm/dW0b7gqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MQXvHgvH+SDblaFkZ4K9LPhv8WXTCm1VRpz4gWK4+U=;
 b=L1JhLVIcwQFveZnGk1HenEF1rLexe7BSGWdLkUaoGAGcBlP/nM2adcJcMXfjBCAuYxd4FXqZdHOrNgbx59dQRV2qf1NkEkp8MEFycCbaimNFe2K57LA//H/HpiNpGxwfBhtxEoyOpOwUFwJ11O+q3CSjfZejv6N+npAjf0Wpqy4xQIoDoTbF9wGkSdBmaogdSWbyd4w6jhR/V8hCX7IJr3l4F6HINfzP5z8+t+nSZdxhvuorLEW3mu1KEE5tNNSOzBSBW3tpUi0KgWjGAPSmJNeEzOhZz8DB3NaUwGgXWmV+tsUTXoPEtQvn/22fVknCFq58rk9r1aiRZWzI5I0ukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MQXvHgvH+SDblaFkZ4K9LPhv8WXTCm1VRpz4gWK4+U=;
 b=T4LYtRjMTKU0XVrxY4en/jPIXZ1o/O7eJ8xOzWwocPdn3hjBWrVdH/Qdp9S952S/hC9FC5RTyfwSy/74QXjI/9xEyLl5RIzU10smzmyvbSrAwluSHEAP9BzKfHXwtwF9twrs88zohF66S4jNze+cv90uiS0ltuplqqkrvt+Wqyo=
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by MN2PR12MB3311.namprd12.prod.outlook.com (2603:10b6:208:100::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 4 Nov
 2021 16:09:12 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::3) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 4 Nov 2021 16:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 16:09:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 11:09:06 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Correct DPMS disable IP version check
Date: Thu, 4 Nov 2021 11:08:56 -0500
Message-ID: <20211104160856.26220-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d26ba835-2e04-4a7d-11e0-08d99fad7062
X-MS-TrafficTypeDiagnostic: MN2PR12MB3311:
X-Microsoft-Antispam-PRVS: <MN2PR12MB331186C9018D9849A8920CCDE28D9@MN2PR12MB3311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xAFkb1OMQgKv70qEdeYpkmuAvazNUcJ26pZH5MousrmYoaS+8rSXof5yoAnGd7Ss3JsNxjw+VLpo8A9tnh3z13tGHe4x7/Z5+MaVQyIn3rj6HizFpHvDI3c0xkTcecYCi1jBUOvqylEXCi2NXO1OvalDb4tkltC5pFFcsO1GfGtQBH1rnAXFrSi0oNm7PXfUKAUSxQMpbjv/BQXvl+9X0RE2C2qWZETsNvzbos4n3A7HXcngOGDFTU/bi8YTl6Du63uaM6xwaQakBHtTbykN/T3A68fKB0XpqF1rlj4PiO/JF9fmpnmeToAWSTmKipJ+IH+SsmugF5nnN2lJGIPpl8rhdZokjxRiyJxqcM4Oie17A0d8+KeYvzUQlCDqmL5BnJVFQDGPGRNMKXeoQIWVmlGqy0L/iQ7IUl5juEi4fUqu2DtQ+F1WPibQ67dRx9KGEBXIeXE5LoiPXm4tuMvRyaHL89YIpBs3HfWloCoIpKXIPXhK4YKov+ELxRlji6Jb+kuoo7Ot1I7tG4bjiE8t0836q23CMkV6g7NKL1DC50mJXDIEPD0RwLXtLQfVXm4fnx7PO042HckFInaxWkgFWYuE19AbGyKcsNBeB8fJTZzFl3u1Y3WE3olR7Y1dXvMUSTN/UZLw8b+BrcpbSeq3XcQQfcw3UsmZVdNF+gXAPzo5gDLCO0tlxmPxVJQ5bFw2KqnFVn73BpxzSIHe13A/XjL0jBOA3vK4k9lTA+3+vU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(1076003)(6666004)(7696005)(83380400001)(70586007)(186003)(8676002)(8936002)(356005)(81166007)(6916009)(508600001)(70206006)(16526019)(426003)(36860700001)(4326008)(26005)(36756003)(44832011)(2616005)(82310400003)(86362001)(336012)(5660300002)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 16:09:11.1660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26ba835-2e04-4a7d-11e0-08d99fad7062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3311
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previously there was a check based on chip # for chips that aligned to
>=CHIP_NAVI10 to have RLC stopped as part of DPMS check.  This was because
of gfxclk being controlled by RLC in the newer designs.

As part of IP version checking though, this got changed to match IP
version for SMU.  Because Renoir designs also include smu11 that meant
that even GFX9 started to stop RLC earlier.

Adjust to match GFX IP version instead of SMU IP version to restore the
previous behavior.

Fixes: a8967967f6a5 ("drm/amdgpu/amdgpu_smu: convert to IP version checking").
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 821ae6e78703..01168b8955bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1468,7 +1468,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 			dev_err(adev->dev, "Failed to disable smu features.\n");
 	}
 
-	if (adev->ip_versions[MP1_HWIP][0] >= IP_VERSION(11, 0, 0) &&
+	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0) &&
 	    adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
 
-- 
2.25.1

