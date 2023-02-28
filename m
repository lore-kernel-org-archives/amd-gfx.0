Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB32C6FA8E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 04:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DA510E495;
	Tue, 28 Feb 2023 04:43:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F16010E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 04:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjsjkCZimaVY8XURBd2TSUPYQBa82xNBO5NVtB1xI+mxPxXS7Sc1aWXph8YmJsbTr+LGHdgTIONelCOrpqa7Uulr4nb+wB58BiZd/rdCPpvLraIiSTOs4luP222BLuQU/QwQToPESKzHihR/XB7NGaHJ7YuGJscuQ6+zTDOMyPvhk1hfRdetA7/3Wzi07pR9u0wTZpzR717AfDB6ENamGm8SG1iOk7NiVAfaGIjg7oXCKxtSp/yWZRseSOkhdzUwqPEzspwDMR2pSWYQ1NhMAgA08bG2DYRUnhYg/N0ZjgAI6FGJYb11uohalhZdDuus5Y+6uErhYLaMz5p2/bdfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFY5Ulf/2B6HCaFbeqQeyEpdEDX9xkgtz3nF88oUgPc=;
 b=hMwirZvJc0E1vAnEXGNbiUolVJdLXeTroonh0NPvpuqkLBNvUMclBjKIAjf5bHiV81dk55ui6xbPTHD5mlydDuxI+fH4GMnumd6RVTnsEJ3s1R0Vc4v92O2ix+ky2uSPhFcj5/EN9Wa0prrtGG0aKyfmAY7jKU8FYRTm5z2/yOjz9FXaidH9gyXla9LqE5G3dTIglJBzP2fj2nh0hTT3+18I8zNYagruiYjrAmxLtWM6xHi8mK1J6UBcZvNGsZtiyXHGNbD/9E8Agr3750TdxZyTb0CwYsLICU7uGdpHdxz0dWlaT/fSfofOQEPCAfuG1yK08X9CcPdv1Ygnmm94vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFY5Ulf/2B6HCaFbeqQeyEpdEDX9xkgtz3nF88oUgPc=;
 b=hT3eOz21EjFGfkcCuk2ScqJCSNZxay5QQ9kP6edvSj06LOlPSKw2TgM+8tykrBt0/QzlhfkUMMMS/apwp7HKY1EIuWC5WusQ5wVX0eQf0YbZRFnevFuyHP8zgrcwM0AnH7zB6ZrG0VUagcgD0o/CKvg9vtnfYeAD4dYEq+Br/1M=
Received: from BN9PR03CA0414.namprd03.prod.outlook.com (2603:10b6:408:111::29)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 04:43:28 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::93) by BN9PR03CA0414.outlook.office365.com
 (2603:10b6:408:111::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Tue, 28 Feb 2023 04:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.14 via Frontend Transport; Tue, 28 Feb 2023 04:43:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:43:24 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amd: Don't always set s3 for dGPUs in all sleep
 modes
Date: Mon, 27 Feb 2023 22:43:03 -0600
Message-ID: <20230228044304.27940-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228044304.27940-1-mario.limonciello@amd.com>
References: <20230228044304.27940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1a1b59-51d2-45ac-a81b-08db19465594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRed18j9SrPVfVs37J2mEu3WI32gBoJRXjICxAXl08CzYBGaz2Ea83pYRYo9/IOwaOlMsFGzizKZ0Gg+H4pVwNIbOHF2nUGahlPrr0nEEb9kuuu42HH+BVOX2fyrfUbYbbwSN38RSzumDlNwcTp9Dx1quyI/GH/ZetcxgsXTSWVz3nLklzeLuVI95q10e4tmSy5Wvxkwc1bpTO8XOujpo7YnZiYKHbonEZuUN7lQHan3DAKUO9YnrbwQsyhK84hBrvAkji5/iXZVWQhBUh0RU/kQt6GeuVqLpv2F/6MIHRtZVfnlQ+Xp7UdTtt/BirrF5j+ceqFaLtHYBsRRU2iJeY258bX/PYIhteZBRa1tmzYVEO5xjROqn2vg7/+H9wUk7mCQP3oG0LVryCi9pt4KMM350HYz+vXrKD5hp2nT4dNcT8GL50oISwnu8vdvS/Ssa0seSw5S7sIl/0Dp3OHcu3T19UYi3BlyD2G78q5t109npP/FSj3oI1xHs6HUbmCdEVYG/NJrRDvh0KoZin0bt3qRpmmDvYAgdir1+bLni6FyaFpj/ki6YgTxCKVve9GsVQ6cY+IUXzndwQnjl9D9m5hJvk43UkCYxCqqwVKdEJxx6rJbGO7bpQ/FQAzFTIUi52XNrbXcgP8hssqQS8JviNgLlyIoYy2QXKtUPqtncOoITIgSfuLI5+K28RYmflu474q5yC2Q7MAqd73mTvQ1MzPwF8qweuVCfYz63BqzpZ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(478600001)(8676002)(70586007)(70206006)(1076003)(2616005)(356005)(41300700001)(6916009)(4326008)(82310400005)(86362001)(40460700003)(36756003)(40480700001)(7696005)(8936002)(6666004)(47076005)(16526019)(82740400003)(81166007)(26005)(336012)(426003)(44832011)(2906002)(5660300002)(54906003)(316002)(4744005)(83380400001)(186003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:43:27.6799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1a1b59-51d2-45ac-a81b-08db19465594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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
Cc: Peter Kopec <pekopec@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dGPUs that will be using BACO or BOCO shouldn't be put into S3
when the system is being put into s2idle.

Cc: Peter Kopec <pekopec@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Whitespace
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 25e902077caf..711f2a1bf525 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1038,8 +1038,12 @@ void amdgpu_acpi_detect(void)
  */
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
 {
-	return !(adev->flags & AMD_IS_APU) ||
-		(pm_suspend_target_state == PM_SUSPEND_MEM);
+	if (pm_suspend_target_state == PM_SUSPEND_MEM)
+		return true;
+	if (adev->flags & AMD_IS_APU)
+		return false;
+	return !amdgpu_device_supports_baco(&adev->ddev) &&
+		!amdgpu_device_supports_boco(&adev->ddev);
 }
 
 /**
-- 
2.34.1

