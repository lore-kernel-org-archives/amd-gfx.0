Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E94C3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 09:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C9120732
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 09:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WBN7B44Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C9120732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED49D6EAF8;
	Wed,  4 Mar 2020 09:26:59 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750081.outbound.protection.outlook.com [40.107.75.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63AE6EAF8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 09:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKb0dEGkoET5ptFTsdSmcG6PROoNBc2tSitZS8QoxOH+v8UqFnxdJxceTgc1AgKCC9rCKMsTW7bOQjCB8zh6oqz5UlXyt8H0H3zdpK4gsvTTqbLFy7fbVis9UY6dbJb/6LB82R2rk9QOarv1HcrI4R3zN4U/jn5BUsp4OQEZTR054nW1IWISDfsugu3eIIUWSxyCxpTpmQmG0bmPpuzGEstPKA1IWKU0mZE+wuKtBGwqETM0xwxs8Lih1gf/dpTHTwHYZG+4S8GCO9p0/uvqbyxxhh5LBm8nNy4ZEEeBSUNh/Mj8HkaJU4gbn4r+IdEMgn9Gl/aw/hwEnY0dHZmp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSd2kYCdsxMglYa6GkDsWqgTRWWlzmKYTN612BPjMlg=;
 b=MWk2TPwqht6uyiOSadmaTeA34h/r+bOLqzGyO2zs4QAwDpMP/x1G343h7Fns48CnIPxewSRjzP69INjmGnVR/V+sr6fLs7ff7oj7OP10b/0VqMwKbT3mq/vJBKi2Pxgux96T04V0soSvWvcVYp32+SmY363sxJiuZ1gg5Fwgw5jbwKcw8cnfM2zW2TU/3R1u7JRQ9j8AT9RAgUUsPjogbLVWSnPFpFucthj8tktrKanKW3sQqS3M8RBqWYn39Ha5R04zEfVgAg2PI+ATVPUoM31z7GbMqXedZwP8EVGxj+8ggFlDZfqxbsJJtSvsJepg/OUpIudACuD0zkxB01LUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSd2kYCdsxMglYa6GkDsWqgTRWWlzmKYTN612BPjMlg=;
 b=WBN7B44QJ9lukEOjEFXVOjCUaLTfNGttb9LWvMReQ9gguwU3dZ8dh2guGdpVSkDrivHFHeP4e3I/rwpX+jFMaiA86HVbgtM+DDTyy5E6d4nED7fmlYH6f4H0gEmb86UYUlU9nX7ZlYBUSLjpCP5tZWxMzbxdz99ZLOlTgDbtwV4=
Received: from DM3PR08CA0024.namprd08.prod.outlook.com (2603:10b6:0:52::34) by
 BN8PR12MB3154.namprd12.prod.outlook.com (2603:10b6:408:6d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 09:26:56 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::aa) by DM3PR08CA0024.outlook.office365.com
 (2603:10b6:0:52::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Wed, 4 Mar 2020 09:26:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 09:26:55 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 03:26:54 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 03:26:53 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20
Date: Wed, 4 Mar 2020 17:26:49 +0800
Message-ID: <20200304092649.6109-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(428003)(199004)(189003)(316002)(1076003)(426003)(2616005)(70206006)(110136005)(70586007)(6636002)(2906002)(5660300002)(81166006)(4326008)(36756003)(8676002)(478600001)(336012)(26005)(8936002)(356004)(6666004)(86362001)(7696005)(81156014)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3154; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c7826d4-23d6-45f1-a450-08d7c01e2e74
X-MS-TrafficTypeDiagnostic: BN8PR12MB3154:
X-Microsoft-Antispam-PRVS: <BN8PR12MB315403831BA5DFB1BD096085FCE50@BN8PR12MB3154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tp1TaE3Vd4a+xZuHUQC2yxY4YI2nKLBVZNYOyX152lK54voSQOz/38SmeXR1lZw4+/djyjwY1UxexhKzjXnuW9LMx6RHidyR7LF7+sPh5d9aNaXz9zBz7TFtzcC7jL7jXl1v9BPHN7XNNh749n6/yEVJrLyImd/fXhWksZinMYe7WCK5h81961obxczrVU2XOEYLETMayq12fMvjvpaQyoqerE4aaQUiTGQ87Lpp68mrY7HOhKKyhCUwU/3fzF511FSDndSPGDBLHpDfyBHz96Qg8bJ6O6QbghPBn5I2oLyt2e8jalNOdS7oDEAicPUv6A21S/pedrpnJJs85g/5msm+pmNwsVufhqmtKGEqQZcBO8vG7KJ7PKVrkHL/ZPfEUeKKuUwcDDxtdR9atg5Z8PAlBPY2Z0Z78OX24OZrY2/3GsOwuqIa+o0C0VyWvCWX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 09:26:55.6263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7826d4-23d6-45f1-a450-08d7c01e2e74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3154
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The ROMC_INDEX/DATA offset was changed to e4/e5 since
from smuio_v11 (vega20/arcturus).

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 6b717691d554..f5e11a56158a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -89,6 +89,13 @@
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK	0x00010000L
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK		0x00020000L
 #define mmHDP_MEM_POWER_CTRL_BASE_IDX	0
+
+/* for Vega20/arcturus regiter offset change */
+#define	mmROM_INDEX_VG20				0x00e4
+#define	mmROM_INDEX_VG20_BASE_IDX			0
+#define	mmROM_DATA_VG20					0x00e5
+#define	mmROM_DATA_VG20_BASE_IDX			0
+
 /*
  * Indirect registers accessor
  */
@@ -304,6 +311,8 @@ static bool soc15_read_bios_from_rom(struct amdgpu_device *adev,
 {
 	u32 *dw_ptr;
 	u32 i, length_dw;
+	uint32_t rom_index_offset;
+	uint32_t rom_data_offset;
 
 	if (bios == NULL)
 		return false;
@@ -316,11 +325,23 @@ static bool soc15_read_bios_from_rom(struct amdgpu_device *adev,
 	dw_ptr = (u32 *)bios;
 	length_dw = ALIGN(length_bytes, 4) / 4;
 
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+		rom_index_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX_VG20);
+		rom_data_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA_VG20);
+		break;
+	default:
+		rom_index_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX);
+		rom_data_offset = SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);
+		break;
+	}
+
 	/* set rom index to 0 */
-	WREG32(SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX), 0);
+	WREG32(rom_index_offset, 0);
 	/* read out the rom data */
 	for (i = 0; i < length_dw; i++)
-		dw_ptr[i] = RREG32(SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA));
+		dw_ptr[i] = RREG32(rom_data_offset);
 
 	return true;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
