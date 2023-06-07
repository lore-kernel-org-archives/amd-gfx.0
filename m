Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BBDC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 16:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B7710E536;
	Wed,  7 Jun 2023 16:46:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3415010E529
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 16:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWKskYEK5yx5gFonGlFH2FpyzdqyytaAzID1p0YNEEIe+LROZ7v8mURfFBHzg1ZGUgfW+WjAvHa0HoAe30iYdK94ZDP8HHf6LmD0Um9JoSFGWcBOrRoGtfWjBJtA7pZJ1mgyCEDIhYfAa9YaOeAGC9UyFYjNskBSibCJj+fQUMYX+Y5Mn7NfoWpB1aqXKNGjQHzDQ0DqsK97IB72NUxdMd1q3PIqhNAVbbvV6twJyv3Up+n2eJBLYYj+yqUZ4dwelSaUxsanIbY6nmEmkFY1WxUVX5YCIhhqZEUMytO7qs/L7S2/IXjSfIxgbmqKArftj/smR/3ESaQiTDJ1zQ+9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOTrEPuH+ovdpUYKpbQg+zUMl4tMaHf/bizXJDtyTUc=;
 b=htdqfQ2IPno3YbOS0l9dc5l4V6Z30snQQTHQMylLHxJ1j85xqu320KLYQU+auax6rGgNdSXtu/aq6q3xBRnRHlJ8YVFoPV2Fgrr7QPc1+6W9xwy12j+ljUCKsluHo+kCNfQenKdlciLOB4rqqEwSLvClgRSJt6BmOi2sGKA2g86Ni0nG//hNtAkCa2oKyD7foDf2VukRx0XTaHUCdYgOwMF2ADyWnvXlhoKpTiTUU5i599VdKk+3Y7ceqzdfjwIakOxwjKHpL55KFxy5c3hL3WtZqRqgwoYdhZ7f/uZvcAae93NrwVYHAFu9f3USka7UycjLdLRsTWOJP7XTpPMLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOTrEPuH+ovdpUYKpbQg+zUMl4tMaHf/bizXJDtyTUc=;
 b=jAMH8wIwPlln/jzgaHuJ+k/Mlks3QR5zl7FOJzXVNHi5FqSRTUgQ/pdI+/eFWgr+g38SDvp9JTqBqUcnvhEWUI+9rKoigw+1W429NK2wTZxLTiK+A6m7DJQLBWLm+u8fJM1kN/mYFgKKJuNCDfyQPmtKIaz+YDBLo+Prs4ZUHMk=
Received: from BN0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:408:e5::21)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:46:21 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::d7) by BN0PR02CA0046.outlook.office365.com
 (2603:10b6:408:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 16:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 16:46:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 11:46:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/atomfirmware: fix DDR5 width reporting
Date: Wed, 7 Jun 2023 12:46:04 -0400
Message-ID: <20230607164604.961913-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: e54c88c6-1082-4cc4-6198-08db6776b90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QqALY2TF3M4GZywpP70ORbpAIkPQUzaKBxkFIlTVQwouC45gOYSvtCzqtz1F4jrKYIhY5YWAmkNily9qrr1NJwdrhd0P5slVfNS5sXVOwqF9PoSRKm0vcMp268otK5M5FF/+fiYOoJbWWDeP/kOAh29o/+Ax3ZvBX28zTN9lDG1nFniv6Ry+jWej2wrQaex8Szb7QrEvMFBPemMMuGUmXRCeMHI+dEpGv0xOa+bVbWOIKJBfgwqdEhmSwWCmB18OQQRzBqr2qEGkm9YkkShJIceiGwOqxHYyyDhS6GMjW5YH+fcHoVJhXSB38PPxnwwvB4o8X7HkusVaP4qYrN4A6r3IwR/3z+iR6LYCxyJAuXxOusBKqFd/kR/niV4EYt9Jug1EOw/9oU4Z+e3mQeo5ZqMjYETxyjDYz+A6nSVfR0Kb6ygrO3Ep/xTNZagDJs2qLxpO+6bA6evp/3KZqS6wjYte+ZP4LF1WA/qE5mgNjiZQ5oQcHOIf6FPjRX8PDvmAzakyoc/0wrsbhv1AqjCOWF9gOT/UoL3ZU4TIj25A2SrjLNYhN33n5Mhc1heebaUmlhT6Z1QbMOS2roLjg3G5xkm6shXwr28xLzg5yfYwN11RuirSYx2cVy4xOOkI7kmiTOjkzvhX4bER/sRM5BDWgECCs3iAPD8sURTrzitKm61NRZPxo4kaNYI3udD0hMYVm8SDR7zFHgurAHhlUaHCNiDoFcMNR3ixIY/CdU1Zuw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(16526019)(26005)(1076003)(186003)(2616005)(966005)(426003)(336012)(83380400001)(47076005)(36756003)(2906002)(82310400005)(7696005)(36860700001)(8936002)(8676002)(6666004)(40480700001)(478600001)(86362001)(5660300002)(6916009)(82740400003)(40460700003)(41300700001)(70586007)(356005)(81166007)(70206006)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 16:46:21.0986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54c88c6-1082-4cc4-6198-08db6776b90c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DDR5 channels are 32 bit rather than 64, report the width properly
in the log.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2468
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index ef4b9a41f20a..6b3bdc27f778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -327,10 +327,14 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 					mem_channel_number = igp_info->v11.umachannelnumber;
 					if (!mem_channel_number)
 						mem_channel_number = 1;
-					/* channel width is 64 */
-					if (vram_width)
-						*vram_width = mem_channel_number * 64;
 					mem_type = igp_info->v11.memorytype;
+					if ((mem_type == Ddr5MemType) ||
+					    (mem_type == LpDdr5MemType))
+						mem_channel_width = 32;
+					else
+						mem_channel_width = 64;
+					if (vram_width)
+						*vram_width = mem_channel_number * mem_channel_width;
 					if (vram_type)
 						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
 					break;
@@ -345,10 +349,14 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 					mem_channel_number = igp_info->v21.umachannelnumber;
 					if (!mem_channel_number)
 						mem_channel_number = 1;
-					/* channel width is 64 */
-					if (vram_width)
-						*vram_width = mem_channel_number * 64;
 					mem_type = igp_info->v21.memorytype;
+					if ((mem_type == Ddr5MemType) ||
+					    (mem_type == LpDdr5MemType))
+						mem_channel_width = 32;
+					else
+						mem_channel_width = 64;
+					if (vram_width)
+						*vram_width = mem_channel_number * mem_channel_width;
 					if (vram_type)
 						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
 					break;
-- 
2.40.1

