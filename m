Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D22DC77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8AF10E8A1;
	Wed, 12 Apr 2023 16:26:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8A810E898
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB1FO06MCaTFEPLSdbZleba/YElwTfNS/ohaSL94Yys1w0CLK8WKNxC0KEsCiSXb4rnUssjgOjBiJkpEVpHKjx3MLbFB9sgK1KogsQTHMhkDwCH4f8g+lMY+dY0vDiLrZmtct9r04Q5VLkPppbksgUJoE5eoaukX5jPFF75J3PUxEvLsk5Mi9lMMTPxJrmw0x54W+dcpoyxmGxfWP5fCMlYEEoSDUjS7QKL2DrhxRCtRBzsBjFMuN7yRUmH6SRYn0ngG29aanqvGkJv5gn4DxKx+4807mcKD2PETdk3cKfiiC4VwG1Eqqy7MiEfBUaJ/Ma6bCtPwlYq1N6IsNhnu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lkdq0RF056j7QvebXQyj/flyrWqpxoNqnOksrVRuFk0=;
 b=lonxuvo9WuZwRjS3m3gwTmpPe7M8ze7TWAYmlOq7XfDJEQyoRZ/C0+Fip5GHYw26FkakoujHsdubfgTjvylAzv7te5pROqvbyzBrVYwGLDklsaHNFCsYMViCZnhUtPXiRWvuGQbtxcdlT6nDJplOs7zazmmVUBmrw8PfCQ+xdcIqMs0ZNpdVxI3+jnufDzlwDtoNtnypa5Xbv4F1qDfp0M9vVNwUVhjcaKl/AdbpKTNQAUftGq6lwZF318WVUryZJPKizM7NzkLZp5OEbem6yI417Ift3fAeFqwZLklUXlgaCi+Wu2AzFfVkUUb2XTxgSNP9VLeePB7Y1Li/Hx534A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lkdq0RF056j7QvebXQyj/flyrWqpxoNqnOksrVRuFk0=;
 b=XMI5iGFXRgqJheda7oGdtXY4JaxwdhdzxX1AE1hINOiKXBihUZeDkRuz1WmVFTRQM5GgCPY/xCJ1KrfBzxjkmRibI2jQe/0q/P3p9FNTVNUDYp4+lTSqTN2Ntf/8IWYH4VwMlBWm+o5fnqWD3Ij82dyeUdDTsyeP2xXGo6Y3aZk=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 16:26:02 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:32b::4) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:02 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:25:59 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 02/12] drm/amdgpu: don't modify num_doorbells for mes
Date: Wed, 12 Apr 2023 18:25:26 +0200
Message-ID: <20230412162537.1357-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 645c4612-6302-4713-7b89-08db3b729b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IlTnFwwZ3DbmOkxQ5jdz4tH29+DCfANUJPZR4Zb7JFmfTmY8HSj/RNUq/ugzFMhFNhU+BH9criU2Jp/umRcMfuUBP1e0QTUhOCFTu1OhSqJgs2uLwYED/jkPbP48/Trq9ksvFZ+py7AHLo2eOcWh8hUXaS7EUMi2xjEkLS1MFBJJs+9+Zub08hN7SCZ9FtQgneCNyGqst49XqbAP3iPfHLrRqtHJ+dopJ24oN0cjxSXN7IIyzVukawAz6e+ViNjqmOT1ebIUYNckBG3d0Ta2MbUqN74nfjD4fXLncmix3PLBwuMw7gu8pKmzBgW9jQCD7HgaGcOtfHP2HtuW111O0EaJdqIDkF0CQN8bX+cOnHrYCzoGOP/oyidXcNpqS8I9Y0NMjqJTAtyPZSP4jcz6VRJUjaVAqSEXf4uDv0a6GdZRsTxxRpSUOezzQY3+w+29BfSk/gzUqqZnfids+iPNfnl9sLwOGn11gPlc7Q6rfiwtlr7qJTR1Fl8+eM22iywsumanhZg6iwLr67/c5lxuJ+iQAO8/NMZ0sDK1xSOOCkSqnIUSfhheCrsL2lZLFkSsRV43nL2FmlyanOzgPPpv1a1TBCBcR163hovq6oGMRqKYOcdCXU/V1RzAKoeeb6hI5lsfSb2b+yvqBlAJO9hQ4tB0b1Y04eCRCDTK0xk5/+J1vJBQYUO8f2mr7UvwujQjmyl9ZGKJew9GG2+M1ad172B923XwkmRhWRbbIatC88=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(40460700003)(36756003)(5660300002)(2906002)(44832011)(316002)(86362001)(8936002)(40480700001)(8676002)(356005)(6916009)(81166007)(82310400005)(41300700001)(4326008)(82740400003)(83380400001)(70206006)(336012)(426003)(70586007)(47076005)(2616005)(26005)(54906003)(1076003)(7696005)(186003)(478600001)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:02.2870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 645c4612-6302-4713-7b89-08db3b729b72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch removes the check and change in num_kernel_doorbells
for MES, which is not being used anywhere by MES code.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 64fec954815d..4b934aadcce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -140,25 +140,21 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
 	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
 
-	if (adev->enable_mes) {
-		adev->doorbell.num_kernel_doorbells =
-			adev->doorbell.size / sizeof(u32);
-	} else {
-		adev->doorbell.num_kernel_doorbells =
-			min_t(u32, adev->doorbell.size / sizeof(u32),
-			      adev->doorbell_index.max_assignment+1);
-		if (adev->doorbell.num_kernel_doorbells == 0)
-			return -EINVAL;
-
-		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
-		 * paging queue doorbell use the second page. The
-		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
-		 * doorbells are in the first page. So with paging queue enabled,
-		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
-		 */
-		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_kernel_doorbells += 0x400;
-	}
+	adev->doorbell.num_kernel_doorbells =
+		min_t(u32, adev->doorbell.size / sizeof(u32),
+				adev->doorbell_index.max_assignment+1);
+	if (adev->doorbell.num_kernel_doorbells == 0)
+		return -EINVAL;
+
+	/*
+	 * For Vega, reserve and map two pages on doorbell BAR since SDMA
+	 * paging queue doorbell use the second page. The
+	 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
+	 * doorbells are in the first page. So with paging queue enabled,
+	 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
+	 */
+	if (adev->asic_type >= CHIP_VEGA10)
+		adev->doorbell.num_kernel_doorbells += 0x400;
 
 	adev->doorbell.ptr = ioremap(adev->doorbell.base,
 				     adev->doorbell.num_kernel_doorbells *
-- 
2.40.0

