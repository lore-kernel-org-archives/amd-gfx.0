Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271FDC4829A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 18:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F4810E1A4;
	Tue, 13 Feb 2024 18:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbKhKnh4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388C710E1A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 18:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDzo3T3BK8vtaXBHJ7G51yauHJXUazWxINkdCkSfRIX88BSNQrc4c4AcuGAZvlQXJZuSC1/EpiReUa4uDT/FCrRD6CeN8Z5wY+WnLsa672mHq2Xh00bros6hOMthvq4s7vqXz9U8KilaQZBIALd+C5Sm9r2umgQ/A9Gu1H8woIkR5g6mQBA/kBl8zRlXuOcwonL9yLOOm4oEcWk2Tv9p6uxKaRkyUDUqajl2NoV3BdS7WwMmcJw7OeKbpxMDSmJu4dYNX1BGYRi1D/T/3LjApf3ekV6vOPyiGT5Q1SwWaW30wDOqOHx9HJ1tRzWJZIqWhl7/SDaWGfFRRm8f4s+wcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyHW7zJOIkuSBsif5uXzrVoL1fdTHjbGVbDdG1F6bAE=;
 b=OnFV5g3y3HeimRIiQL9hDtD7wGNZpX4HdoADacJ1DyuFuPMj4lwLufv4OzKOoyi34ZXjRuufqPDLVgLS+/QieVD1wHVzaVAzWY07G3xhEfmnwGMEoGodsvtJgR3ofKnn8phHet4B15N/ajjsjxS1/N/HK9ik8+p9YybIrCmlltJOTLY0xjje1E/wt/aSpfQoBasuOZ2cXx/8h7pY0azWhLL3h7e7H2C7b+C424h18S+Mmj3eRVjrnx2BTu7W+BB+htyDNL8YmwTCx0zDC+mbMM4yuGhEat4ePin5dWOkItf+X7kd6LIllFfPZwMQa8TC4EJG/HvptKH949C0StJB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyHW7zJOIkuSBsif5uXzrVoL1fdTHjbGVbDdG1F6bAE=;
 b=wbKhKnh4JlBzqzV2CSC8+jT4kqel9tA4sJtk3qOPmT9gsDx6szI0aXdxaeVyIRzsB2b8ehrrQbLambc0T6tdUPiiwEyaASuXH3iaAZo5CvZxsaBDOyEcRYMXxVekvAldUd4Na/UzjMov1uHceCERf4iQCwJmTN6YPY9KnRoBbiY=
Received: from DM6PR06CA0082.namprd06.prod.outlook.com (2603:10b6:5:336::15)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Tue, 13 Feb
 2024 18:56:02 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com (2603:10b6:5:336::4)
 by DM6PR06CA0082.outlook.office365.com (2603:10b6:5:336::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.40 via Frontend Transport; Tue, 13 Feb 2024 18:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 18:56:01 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 12:56:00 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, Victor Lu <victorchengchi.lu@amd.com>
Subject: [PATCH] drm/amdgpu: Improve error checking in amdgpu_virt_rlcg_reg_rw
 (v2)
Date: Tue, 13 Feb 2024 13:55:50 -0500
Message-ID: <20240213185550.2215-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102173013.5543-1-victorchengchi.lu@amd.com>
References: <20240102173013.5543-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0abc0f-bf99-4312-319b-08dc2cc56c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1EBrNbYoQIjPjqRdBRM7KtSJldDyMyI2jWFukXbt+Vgx/0GNa0V7kL1Qko5zijq5X8Q8lwawouA7aAAtrr34dDNtlLp3wFSO3dYyMQZE+BYZ1RT7Fw8o6MOf9+vn/gy/rllfgUG8M1mseIv0CCTxuz6EPqU99qQAbISqTZzHM2Cn3czTAHIKBIE2uk2aYVkgQBfmYqSiR24FleVEa2cyqpG3DDWySuz9MmuJS3q5c5I1y0hDEHWH100Y/1FNlTshT7gXoZq7uqClSnPW9UymGhH9CzYG07HSZrvdtAeDc5n/5DZGLZfcs4bDDxLo0PyZxPapXgTcZLIK5n8R7i5p8OxXhYm9UGJ/mHvduf2IUVc3D/4xDrX2kyLeclTIwkxvS3VrKE7Ltht2z/1OA8prAtlj60WIrOLG4agSIFJSiWfdNrtmCahQgmNoudr1023XAJiCWMorP43xXq5uo9qE7bfJFbF2cVugQ4NJXT0Ar41bGTsOg3LhDSHuFkA5iKC0Y5AzqqoD9azNHxXPoTjKtOfM7q9KDR4USRIi32gMBpuRr8n43r2VVf36psVxa+H/7Fn6LkYWxpHfy40wctAzA6PkrO+zqofZTP4FTpv7mmU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(84040400005)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(356005)(16526019)(41300700001)(86362001)(83380400001)(2906002)(70206006)(4326008)(5660300002)(336012)(70586007)(426003)(8936002)(8676002)(54906003)(36756003)(6916009)(1076003)(6666004)(316002)(2616005)(26005)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 18:56:01.8195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0abc0f-bf99-4312-319b-08dc2cc56c6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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

The current error detection only looks for a timeout.
This should be changed to also check scratch_reg1 for any errors
returned from RLCG.

v2: remove new error value

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6ff7d3fb2008..7a4eae36778a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -979,7 +979,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 		 * SCRATCH_REG0 	= read/write value
 		 * SCRATCH_REG1[30:28]	= command
 		 * SCRATCH_REG1[19:0]	= address in dword
-		 * SCRATCH_REG1[26:24]	= Error reporting
+		 * SCRATCH_REG1[27:24]	= Error reporting
 		 */
 		writel(v, scratch_reg0);
 		writel((offset | flag), scratch_reg1);
@@ -993,7 +993,8 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 			udelay(10);
 		}
 
-		if (i >= timeout) {
+		tmp = readl(scratch_reg1);
+		if (i >= timeout || (tmp & AMDGPU_RLCG_SCRATCH1_ERROR_MASK) != 0) {
 			if (amdgpu_sriov_rlcg_error_report_enabled(adev)) {
 				if (tmp & AMDGPU_RLCG_VFGATE_DISABLED) {
 					dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index fa7be5f277b9..3f59b7b5523f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -45,6 +45,7 @@
 #define AMDGPU_RLCG_REG_NOT_IN_RANGE		0x1000000
 
 #define AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK	0xFFFFF
+#define AMDGPU_RLCG_SCRATCH1_ERROR_MASK	0xF000000
 
 /* all asic after AI use this offset */
 #define mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
-- 
2.34.1

