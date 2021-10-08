Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA2DC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 16:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8B961019
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 16:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D8B961019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07926F50D;
	Fri,  8 Oct 2021 16:10:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A956EB8D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 16:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Dd55i20o9gV08lsq27rUtbr2po45ST2aZxUycgGKfQYwMHtJ2POQT7F+pWWWd+/C7YL/yyw//SfQ4xepY7EQkw420fLzS/TWEwmgF2dWWOECTCg0kYgBzuOPabSe6LAfn1Ee9cXQspCQOuLZFlv4ML+BFOrBU8hdZdHZ9u0pZY9bz0NvTxw4QYEYmojU2xAo8gpIHK1PX20NdCQ0e5YS93uBfzyZifh9wg6PV23mp2cOxBISVYx1u2u/J0e3384zT6g3vb4B0C8JWSCmXE4334MH7Mmb+uhi+2SS8zuaMGvo0Nf46uexWnxK7F2afUaaUZ8a9Emufe523S4VQQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlae1oUD5vHjFOBS+X6QaTbBJ9U2m0s4uBn+F+asdVk=;
 b=BzhjJVklVlkQVnuVlQ08uS1iI/bGl5kuFdLimo9xrd0EyoVU/2D06IvcnTNj2wItqrh3h7ZfvqVB5ycZuW9EGf+4/lsIynqaIClcbUFzjCAeDInlE1T65iCl3R48WHXG1BpA5kkr8Cb2XAqbl/7Ogb9CMnVNkJu3VlwNKI9dHWiFeSxuNzaBis74iMnycJcVkiIC4NHzb+boGq3p0P06JodW36oUlowzwTm7/Qdnc0uA/0pVSN7lMSOQOWuAD9GLjRn0ixCDujjD/VE5rGq7+tWiaZi5pwp8ePyicxprFzGHyYYCbUAT9HZ7Wbq/rGJaGTdYUzAn1X1fTynYPIW9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlae1oUD5vHjFOBS+X6QaTbBJ9U2m0s4uBn+F+asdVk=;
 b=X/PYQPzxwg3ZlszvjEldImvSdj9JcL4Ne+LWgJTuK9Zf+2ezQpG5XZ3UM4+FidTC4YVQ75IMCThn4OhLGZiZMzUjTIwlCukwLxq5adIXut2JmkuuXNdMCf+1je1/8zrhxAcpvQdaTo1uj86lh2rdX6EFZ/aBJAHXzuOcnq7gJbY=
Received: from BN0PR04CA0143.namprd04.prod.outlook.com (2603:10b6:408:ed::28)
 by BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 8 Oct
 2021 16:10:34 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::82) by BN0PR04CA0143.outlook.office365.com
 (2603:10b6:408:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Fri, 8 Oct 2021 16:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 8 Oct 2021 16:10:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 11:10:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12
Date: Fri, 8 Oct 2021 12:10:20 -0400
Message-ID: <20211008161021.1922011-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8be64f1e-099b-4f60-b478-08d98a762863
X-MS-TrafficTypeDiagnostic: BL0PR12MB2514:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2514E32AF661B8F036F01EA8F7B29@BL0PR12MB2514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lln3yyH5t0uOxgy2lrStpsOLG7cojS/CbHFcvbDh9lXBBIT08IrgGCf1MaAKAUtVVeN19wAro2wn5uTCF+B78WsgdySUC91gqWZqn3tZFs5AKHRgsSVwbmQJVjQKa32Ri9vGwFjIYGaGFhCYPTiSQsVDtKFhBfF4zY0i2gpqljnlnOZ+vXry9W6CnOA3MO/nbi1K/O0+pnnwid2pSQvakqtztQcVk8il/yIoWgFYYtJkUQYcFBWyI/KEAI+XVUWEAwJSaHiKMSHCPd/Zf0Om1PIGI3b78ROrwFeSOfDop5niHc3bOpekyx6NAQN97TwOrfb3ZsRQDPKIgk6CUiAVZd+pYH0ARTqN+egjJdsjp9/d0cwKZL660qDsFuXfYPvN0b2eylUQMRIWVPW7692FQSZyfKFdRerdR8dn15pVWHn5/7EnxbLxVcswn0HjlgEP+Xzkh8x3FgwOuzaQ3+CfEvcKGtFjc5N6ERks1x+YCx38ioepje0muiDzb9xvJ33ljskciwk4bxHVBB0tDns2HspE8WtW+w6vXI1JfbotW/GNOtxaIhZJf0jvzI3Jyy3lqid+1f9eqiRvh/SxIOWaChyy9MXvsAeiOaeYQTk1HR71tbQCh/gOGnsAvOjkqi4O48HaArlQ3IuPz6sRj5H8rJM4IRcOtxZN0v+cq+JjTt2YtsQARQF7RDIJP6eMPheYLeohiLRQq+xILpCiFmzXMW7LZ9ooY+rS9cvHCoUzziw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(6916009)(426003)(316002)(8676002)(4326008)(356005)(8936002)(26005)(16526019)(508600001)(1076003)(5660300002)(6666004)(70206006)(70586007)(81166007)(186003)(7696005)(2906002)(86362001)(83380400001)(82310400003)(36860700001)(36756003)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 16:10:33.7612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be64f1e-099b-4f60-b478-08d98a762863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
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

It's used internally by firmware.  Using it in the driver
could conflict with firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 91b3afa946f5..3b7775d74bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -56,12 +56,15 @@
  * These are nbio v7_4_1 registers mask. Temporarily define these here since
  * nbio v7_4_1 header is incomplete.
  */
-#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK	0x00001000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK	0x00001000L /* Don't use.  Firmware uses this bit internally */
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK	0x00002000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK	0x00004000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK	0x00008000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK	0x00010000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK	0x00020000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK	0x00040000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK	0x00080000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK	0x00100000L
 
 #define mmBIF_MMSCH1_DOORBELL_RANGE                     0x01dc
 #define mmBIF_MMSCH1_DOORBELL_RANGE_BASE_IDX            2
@@ -332,14 +335,14 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg = {
 	.ref_and_mask_cp7 = GPU_HDP_FLUSH_DONE__CP7_MASK,
 	.ref_and_mask_cp8 = GPU_HDP_FLUSH_DONE__CP8_MASK,
 	.ref_and_mask_cp9 = GPU_HDP_FLUSH_DONE__CP9_MASK,
-	.ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__SDMA0_MASK,
-	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__SDMA1_MASK,
-	.ref_and_mask_sdma2 = GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK,
-	.ref_and_mask_sdma3 = GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
-	.ref_and_mask_sdma4 = GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
-	.ref_and_mask_sdma5 = GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
-	.ref_and_mask_sdma6 = GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
-	.ref_and_mask_sdma7 = GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
+	.ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
+	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
+	.ref_and_mask_sdma2 = GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
+	.ref_and_mask_sdma3 = GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
+	.ref_and_mask_sdma4 = GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
+	.ref_and_mask_sdma5 = GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK,
+	.ref_and_mask_sdma6 = GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK,
+	.ref_and_mask_sdma7 = GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK,
 };
 
 static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
-- 
2.31.1

