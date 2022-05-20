Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E3BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 06:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAC011B4B4;
	Fri, 20 May 2022 06:16:05 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1B711B4B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 06:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di3Zlp4eR8ZU0wLLIliPKRdVHapc9TEQfUKGjv4JPTGTco0pTazv9k3COZaaI9A3kixl0UztX566ahMyKN3mis29pY4XN4lbcMDgpMWtbxxkcmlTjEXDU4qMelV82eJlxhdndxk7kL1ZjD7/UDPBpiIbgJb02BasAtfc5Td23fGbrOLobA1Ke73AG6lHw6f3pi6mz05rCGon5vJJnWMAbDh4Q8TWERDeamoysdrSWId1bkWoot28H4gWoCxJO8lzhHvseoapAORYYgj82oiBulqgm9I6wKOO/PRcYLjCrdJc55EeA8vcVE67cqPgzUipQjqV+lPuvVYzXrU4b8EEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNFbWXfHDEP4SG77hraXQUIn0qoSwEr7P/Bt4/NyEXw=;
 b=gxSLjw93eiiHNQCTBbRu2yIEcYmmB/RB2YEUuIOmuMZdoIWH6q4jaTHFZoMiwYuTNsu+dt424nW3MKe++5WZ7jXLFr/roRNlEndJFVG7pA8F9xEDOFosArW11a0yRfEe4p7zAqrYhDAVLWNkp/54U13NHNlxZw1zvDyJHe8JoQnP+2/YnKoVzsZnoIXJQFS5ox85BzVugFD4S5P3tFBeSupbKydScL8wLop8TXDjRz8Xpbolmw2g7c7l8DgdNC0cRGMTfWMUIMzz0KkK1krNAv8wOuetmxKino0XKmvvncsx84nMBcxDdKUxlFshFWxm8Q4MNJJY706+jbp7Ed0+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNFbWXfHDEP4SG77hraXQUIn0qoSwEr7P/Bt4/NyEXw=;
 b=1u5q4KOK4cOEJEhKdEO/lPJzW9PvB5a3q6br4t9oNeR+DM2Ygrnx9scLa+VqzX7+DEOO3TERTVT463jxkIIUGjyvdcCqDxyImcDc9OU/yaDU5/UM/E/vgMaoYaZ7QhIMzmJuPS728aIW3MfxbreSGJIjoGc2HQmaAYGbDPDDXbE=
Received: from DM5PR18CA0088.namprd18.prod.outlook.com (2603:10b6:3:3::26) by
 BN6PR12MB1666.namprd12.prod.outlook.com (2603:10b6:405:3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 06:16:00 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::df) by DM5PR18CA0088.outlook.office365.com
 (2603:10b6:3:3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Fri, 20 May 2022 06:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 06:16:00 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 01:15:51 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: clean up asd on the ta_firmware_header_v2_0
Date: Fri, 20 May 2022 14:11:50 +0800
Message-ID: <1653027110-15667-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 198c45b9-641d-428d-1f96-08da3a2835c6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1666:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1666EADC6F806B2D66A51780FBD39@BN6PR12MB1666.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9WCtbk+8akjuGPQecBXhQMiWbw/E13PygZn3ko5l4Xm4oBUe+GlKu2gq1WeWJ5EhmlkL5qpNsCz5gb/nEa1OPdiX7ir7j4TVPMsG2YWiLMj+9YL+dGvnnp8IljaeaSFDpM8nJzc5nB8Vp63KjCsXCcsnUJR/6GFDhUrSzc2Nq822SQ0+jVRjrdSzRUxXQVRRQg7pAqN6hGcGEVDI1mYDWaILqGUOHXMJE80Ut8/WlqpVhEDKk+MRZHo4Ez9R7LAFQUnX9u589WOlvgNOSDg9QZJ9wDr8BpCyhPAhqi4pFbGp4rISFgMaH5WpptcAaLDhMYlN0H0bd5lU6euKkYJZ4bqZIZu+dSGadkOPOi1XCoVLaJvYpTZj4IOOmmdPWC/tv+p+urqlGOMhKRk4YwjTN4zJF2LoJSokRkXj47Lx31gpiUk6rA5IPsDegSvw8LtmO3sAbKojT+OhxDDXSFaGY8sMhjUe3N5axiSL6xQsUkgBsfdlR5+E+o1tcQ7l39T5gnCadPQoNlerwJgqC+GuOy0ytYjYEhyp907+HOQ/E9dP+ysGOIYALrjNLuMRJP4qoE4mUq3R980Pq2aqP74S353zQ20UyfsOLJEO6u8Yd+PqXG6BAMLy6sYta/S2yLvXlbA5WB3A6a2pQiSUsbbUQ8V9QYuoayJePkWAXIkFIVPU+vf4dhD9hIyWw4ptAqslhuM9hhWbnm86dFoW9HNiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(70206006)(4326008)(8676002)(70586007)(47076005)(316002)(7696005)(508600001)(82310400005)(6916009)(54906003)(40460700003)(86362001)(426003)(336012)(36860700001)(83380400001)(2616005)(356005)(16526019)(5660300002)(81166007)(8936002)(36756003)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 06:16:00.0688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198c45b9-641d-428d-1f96-08da3a2835c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1666
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
Cc: Alexander.Deucher@amd.com, Yifan1.Zhang@amd.com,
 Prike Liang <Prike.Liang@amd.com>, ray.huang@amd.com, Aaron.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On the psp13 series use ta_firmware_header_v2_0 and the asd firmware
was buildin ta, so needn't request asd firmware separately.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index d6d79e97def9..f2e3b6ede77b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -32,13 +32,10 @@
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
-MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
-MODULE_FIRMWARE("amdgpu/psp_13_0_5_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_5_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
-MODULE_FIRMWARE("amdgpu/psp_13_0_8_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
@@ -93,9 +90,6 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
-		err = psp_init_asd_microcode(psp, chip_name);
-		if (err)
-			return err;
 		err = psp_init_toc_microcode(psp, chip_name);
 		if (err)
 			return err;
-- 
2.25.1

