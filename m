Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC21C48BCD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3484610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3484610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDFF6EC47;
	Tue,  8 Jun 2021 21:40:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AAE06EC47
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THY/Btkebee3fJ1h735mvVZO3PUvN1s+wQF9tUP/pSrC+9EuLxN6og66QRE27pa0WAZzHA4976mnvvD/sWOHRWgZ15CKBDaq5IS44w5xbHtdLhW5u+zzNjSJCTGGoPclsVPskw7WoDxtdTEKjytW+yokQ7VnUCMMzp0SZdPClHZQKxWzvJYSTw7DqwHtWPsf0xDDPYUe+bs5eYJ29keWe7AXkHdlCmTw56LbyJpUERFVpeom1OG+aOzxQruY8QYzIVT7gGpoQEF/YNPgA7KBFzsdZ59D+oP2XR6ErzjnBWzkwf9JaNkZiynq/e3saNxdtlsxKBaAvDJAtajMdeTp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81c9dx21NThnTDljqszKL6wz+SjldHylVuQL2mru+3o=;
 b=EKNtr+WIGLIFoveTSd87e4reWxy/Q1fNz9+1JtPD/xhKCeUZx+NDH4gnrKBLCZpwhu9PIQet9HOINgrnapqiIms8/o7Mpq39hvDH+Gt78y/Sm6KP05MWw9AGlhnDJuEWDAaH1pst0T8VbSMTNZ+tISnHv1Gs+1ZpO4OLdnciXleB6XVzvvn3gyzQXvwk48gqcCMPVsJGZgGjSsKYDipgoinm82HEx9p9fmlvap6szZT009JiWYJEG4dP7Jns8YQqyR1rLXd+thgViTFCy9lXBKv7PFlCu6iIQP2HDaOswZnIQh0QHCysbl7hoaEf6tWsJSV4hE11F364n7dlP+rSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81c9dx21NThnTDljqszKL6wz+SjldHylVuQL2mru+3o=;
 b=eynmx3gkzB0OkoWI/UYx3AFNGWotWImSlcVm/bl/NNwgu5DxJ19WkStdnjOeGDFaDJe7aNMHbgRjXHxqTYCPyskoGQVSkaQMJUizzPANYwGqTuta5GEej4OI6ymhbXs2tnt4HiahMN/88OoZaRRGf0/4w4sOPbGw3drWbSx3GFI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:31 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:31 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/40] drm/amdgpu: RAS and FRU now use 19-bit I2C address
Date: Tue,  8 Jun 2021 17:39:36 -0400
Message-Id: <20210608213954.5517-23-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e98a9fa7-ec32-447a-2776-08d92ac609f6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44352E338E260C94B1C91EA499379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNmbiWL8FG99cXfqNHwFyoNnnwibq/OtRtBq11fHl5F/hACMma5QE6MjgLtPQw+mL/QEsEsymXwlU1r2bI6QwAisvrKzUkoQcVAL8uD14i9JwvaPT565vnNwZbR4J2ap9K3VoHv8FMjdU/XeXssce6bXp6f54SxfIdokWCgU1c6Ot4xZPIDbtPVo2sJVBX3/D2tOhkRmI71ZVsw1JAam9l6Si9IyDrQeP/7MtDaTsIJFqIE+ejc5dzf2Mbw2Qqdvgqscu+aQ+m0LhxJmjpeOESum5gWY199PHtgkiQBTXJCB74aTQ/aUuMVlVt01bH9kFdzpp1y6PmSLLeXNcq42/w6x/kYoqQaR3OP0+lKxyHfzhV4TSywsRUXmefWfs0O2PGYLZXE6EmIaDzlnB9TY8+sO9f/SXdi7h7qR367BviqmBBCX/A8wKQTY8z/MCg7dlEU+EsccXYO9uo3vc++00VVm+WS/Xd1WeXOxI7m/KmISY0jTMzTC+GS2b/nuH0DfDv8pMRr6WXVkCgJq1Tl/RHiY0CbIN/Aa5F37hVNCcnf1uOWbI+7xYNPAfn/7NgqH8UuFg94PrOOwCHC/8IRI3V6CT/6dgUjtkqX0eSBXfPqJNbx7Aaa9/AythKSIAYvtcshCu8i53Cdm2Qdxrq7trx9oiOEx6wbtlw2ZGZBFJ82H9TOrkQcm+dhy895Ay1uLQ2EZ8TTnPJnal7IC9l5xKKXxOO8Ao9KKM6CQNA26T3pO296IAqeG+Ifau+D/kf+Jl8QiJ/6D397HVufUbGWu9HOD7Z8Ak8WtqBEXUXMMkSM0JKl2jbUNXk+tlw3JCa37
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(966005)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(30864003)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JJzDCrpYSk2gFmOGAkoi5IHWEYrgtl0LzsslBXE/L58Yndm6bETjRa6MZWm?=
 =?us-ascii?Q?a0cDO97oAC5Hm9WvGSBEEwbt26bQsykgMJi9eDQ8bjcygzonj43t9T3ogn2L?=
 =?us-ascii?Q?A55iAgFuVE06n7adkJjiC33z4oFLE1wMKW2Eaw3oMI9pIkxpt6w+6hviFI6Q?=
 =?us-ascii?Q?/o9/ULZKrDwtpjdFPlbVM8P8DiUr1XvI84IdP3PNDofTWxo3jRKMOLzt6dzc?=
 =?us-ascii?Q?dCMoqY2TWCCDJNQE9d4a/gEgj26ESbpAtaWyLju9IBPHc7RLUbF+eNtdtju4?=
 =?us-ascii?Q?ZVNnFHV8WWx9+aVnV50uUJBWwZ1hOtnGhKAVkCuRTr4P2n80H2J88cK24oC+?=
 =?us-ascii?Q?rS10xftTPlMoKprjPLFsYVFaSOhOieT1E2a2qD3/+cZLxenTQCupfT7uEO8u?=
 =?us-ascii?Q?Vt9xmHIuuaJf+a4RPzgh9It4iKX0lA6DHpFVFFeEDqpq7bhbbTOnXdblhM4a?=
 =?us-ascii?Q?awL8Xk+4myKuivX1k3IPdP2pwBftSn3k+8rBsru/+orIsLIJDi6EK1oVBi3B?=
 =?us-ascii?Q?fQce9ZARH1MYDAk4BWg6eDZqAvMTmDNzQbHedmUgipGiqoma0W/DiOhC3jTt?=
 =?us-ascii?Q?K/AIaJiRV5Bbi4jdxWnto6kKWcEdq+Hj0gtKiWRjMPRh9cF1Xr1ROt+82WWa?=
 =?us-ascii?Q?lK+F0sfokm99V+LKstFhhM4c772w3/sZOF398qhjobl5b+/64f20WIh4R/+L?=
 =?us-ascii?Q?OpTRsGA2X5Hk7EZIT9MSE1o1DoygFZ/Ev6BCiLOjw6+YMkKFC+afiKKgj/ti?=
 =?us-ascii?Q?gqKeBqu/fo7kH3Dbo/3+DlTLHwghQjSA0C9IrZD7kjJF6aMg6QTi0VaKiOXp?=
 =?us-ascii?Q?QSmHRSo1xqifmjQLEyqH48dW9PIGCf5vxn1rBq6RQfnAblJ5fitBoNrbkHPr?=
 =?us-ascii?Q?AR2xagFAehpH9Gj+jC1jm0syvEdQctrc2LtH/2I4q0m9EkSUMz52dENfGUwB?=
 =?us-ascii?Q?F5fAicjb5ERWxqQall8I2WApQAMk+ErEJT6hwXZ4TUhl9EfB0SD9peoImwam?=
 =?us-ascii?Q?RwXceBDxdQkwBqNwIUvk/rDU0CcfuSz2zOsenwLqNTTQAIW2cJeao9xFY+JX?=
 =?us-ascii?Q?JEfMoUbS4WVmSqjSyEmL9REKOG2OxiHbnTVnWofuT+nCFG1tsfT2s6PF0t1u?=
 =?us-ascii?Q?FgN9nCzSOHkHoWBZmZQJGU83bSymZoJMSb0c6RyryJOaMsarzBLDQiAK3CUv?=
 =?us-ascii?Q?CygTsWuH3I4h83LfUZNB/8QvPpUEZaeuJd5xc8iatYTvyK0RjTkDvgiJ4CtX?=
 =?us-ascii?Q?MmqqTcM86HLplVXOs6mEzo7PAZFeaJNVM97k356aXVZ5HJcwinxQppkeDP50?=
 =?us-ascii?Q?zdsZ1/5KPNgiME3ve1+9Td8R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98a9fa7-ec32-447a-2776-08d92ac609f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:31.0792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/Ts10l7mLFtLNJx/Cm5p1wTlVzU7zgTC9HNzzCtfru0X8IgsC8Ayec2oeT2SvB6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert RAS and FRU code to use the 19-bit I2C
memory address and remove all "slave_addr", as
this is now absolved into the 19-bit address.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: John Clements <john.clements@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 19 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 82 +++++++------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +-
 3 files changed, 39 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 2b854bc6ae34bb..69b9559f840ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -29,8 +29,8 @@
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_eeprom.h"
 
-#define I2C_PRODUCT_INFO_ADDR		0x56
-#define I2C_PRODUCT_INFO_OFFSET		0xC0
+#define FRU_EEPROM_MADDR        0x60000
+#define I2C_PRODUCT_INFO_OFFSET 0xC0
 
 static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
@@ -62,12 +62,11 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 }
 
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-			   unsigned char *buff)
+				  unsigned char *buff)
 {
 	int ret, size;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, I2C_PRODUCT_INFO_ADDR,
-				 addrptr, buff, 1, true);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr, buff, 1, true);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -78,8 +77,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	 */
 	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, I2C_PRODUCT_INFO_ADDR,
-				 addrptr + 1, buff, size, true);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr + 1, buff, size,
+				 true);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
@@ -91,8 +90,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
 	unsigned char buff[34];
-	int addrptr, size;
-	int len;
+	u32 addrptr;
+	int size, len;
 
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -115,7 +114,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
 	 * and the language field, so just start from 0xb, manufacturer size
 	 */
-	addrptr = 0xb;
+	addrptr = FRU_EEPROM_MADDR + 0xb;
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2b981e96ce5b9e..f316fb11b16d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -28,11 +28,11 @@
 #include "atom.h"
 #include "amdgpu_eeprom.h"
 
-#define EEPROM_I2C_TARGET_ADDR_VEGA20		0x50
-#define EEPROM_I2C_TARGET_ADDR_ARCTURUS		0x54
-#define EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342	0x50
-#define EEPROM_I2C_TARGET_ADDR_SIENNA_CICHLID   0x50
-#define EEPROM_I2C_TARGET_ADDR_ALDEBARAN        0x50	       
+#define EEPROM_I2C_MADDR_VEGA20         0x0
+#define EEPROM_I2C_MADDR_ARCTURUS       0x40000
+#define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
+#define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
+#define EEPROM_I2C_MADDR_ALDEBARAN      0x0
 
 /*
  * The 2 macros bellow represent the actual size in bytes that
@@ -58,7 +58,6 @@
 #define EEPROM_HDR_START 0
 #define EEPROM_RECORD_START (EEPROM_HDR_START + EEPROM_TABLE_HEADER_SIZE)
 #define EEPROM_MAX_RECORD_NUM ((EEPROM_SIZE_BYTES - EEPROM_TABLE_HEADER_SIZE) / EEPROM_TABLE_RECORD_SIZE)
-#define EEPROM_ADDR_MSB_MASK GENMASK(17, 8)
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
 
@@ -74,43 +73,43 @@ static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 }
 
 static bool __get_eeprom_i2c_addr_arct(struct amdgpu_device *adev,
-				       uint16_t *i2c_addr)
+				       struct amdgpu_ras_eeprom_control *control)
 {
 	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 
-	if (!i2c_addr || !atom_ctx)
+	if (!control || !atom_ctx)
 		return false;
 
 	if (strnstr(atom_ctx->vbios_version,
 	            "D342",
 		    sizeof(atom_ctx->vbios_version)))
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342;
+		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS_D342;
 	else
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_ARCTURUS;
+		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
 
 	return true;
 }
 
 static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
-				  uint16_t *i2c_addr)
+				  struct amdgpu_ras_eeprom_control *control)
 {
-	if (!i2c_addr)
+	if (!control)
 		return false;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_VEGA20;
+		control->i2c_address = EEPROM_I2C_MADDR_VEGA20;
 		break;
 
 	case CHIP_ARCTURUS:
-		return __get_eeprom_i2c_addr_arct(adev, i2c_addr);
+		return __get_eeprom_i2c_addr_arct(adev, control);
 
 	case CHIP_SIENNA_CICHLID:
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_SIENNA_CICHLID;
+		control->i2c_address = EEPROM_I2C_MADDR_SIENNA_CICHLID;
 		break;
 
 	case CHIP_ALDEBARAN:
-		*i2c_addr = EEPROM_I2C_TARGET_ADDR_ALDEBARAN;
+		control->i2c_address = EEPROM_I2C_MADDR_ALDEBARAN;
 		break;
 
 	default:
@@ -154,8 +153,9 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, control->i2c_address,
-				 EEPROM_HDR_START, buff, EEPROM_TABLE_HEADER_SIZE, false);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+				 control->i2c_address + EEPROM_HDR_START,
+				 buff, EEPROM_TABLE_HEADER_SIZE, false);
 	up_read(&adev->reset_sem);
 
 	if (ret < 1)
@@ -277,7 +277,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 }
 
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
-			bool *exceed_err_limit)
+			   bool *exceed_err_limit)
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -294,14 +294,15 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	if (!adev->pm.smu_i2c.algo)
 		return -ENOENT;
 
-	if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
+	if (!__get_eeprom_i2c_addr(adev, control))
 		return -EINVAL;
 
 	mutex_init(&control->tbl_mutex);
 
 	/* Read/Create table header from EEPROM address 0 */
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, control->i2c_address,
-				 EEPROM_HDR_START, buff, EEPROM_TABLE_HEADER_SIZE, true);
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+				 control->i2c_address + EEPROM_HDR_START,
+				 buff, EEPROM_TABLE_HEADER_SIZE, true);
 	if (ret < 1) {
 		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
 		return ret;
@@ -395,8 +396,6 @@ static void __decode_table_record_from_buff(struct amdgpu_ras_eeprom_control *co
 
 /*
  * When reaching end of EEPROM memory jump back to 0 record address
- * When next record access will go beyond EEPROM page boundary modify bits A17/A8
- * in I2C selector to go to next page
  */
 static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 {
@@ -409,20 +408,6 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 		return EEPROM_RECORD_START;
 	}
 
-	/*
-	 * To check if we overflow page boundary  compare next address with
-	 * current and see if bits 17/8 of the EEPROM address will change
-	 * If they do start from the next 256b page
-	 *
-	 * https://www.st.com/resource/en/datasheet/m24m02-dr.pdf sec. 5.1.2
-	 */
-	if ((curr_address & EEPROM_ADDR_MSB_MASK) != (next_address & EEPROM_ADDR_MSB_MASK)) {
-		DRM_DEBUG_DRIVER("Reached end of EEPROM memory page, jumping to next: %lx",
-				(next_address & EEPROM_ADDR_MSB_MASK));
-
-		return  (next_address & EEPROM_ADDR_MSB_MASK);
-	}
-
 	return curr_address;
 }
 
@@ -452,22 +437,20 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 }
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-					    struct eeprom_table_record *records,
-					    bool write,
-					    int num)
+				     struct eeprom_table_record *records,
+				     bool write, int num)
 {
 	int i, ret = 0;
 	unsigned char *buffs, *buff;
 	struct eeprom_table_record *record;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	u16 slave_addr;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
 	buffs = kcalloc(num, EEPROM_ADDRESS_SIZE + EEPROM_TABLE_RECORD_SIZE,
-			 GFP_KERNEL);
+			GFP_KERNEL);
 	if (!buffs)
 		return -ENOMEM;
 
@@ -507,22 +490,15 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 
 		control->next_addr = __correct_eeprom_dest_address(control->next_addr);
 
-		/*
-		 * Update bits 16,17 of EEPROM address in I2C address by setting them
-		 * to bits 1,2 of Device address byte
-		 */
-		slave_addr = control->i2c_address |
-			((control->next_addr & EEPROM_ADDR_MSB_MASK) >> 15);
-
 		/* EEPROM table content is stored in LE format */
 		if (write)
 			__encode_table_record_to_buff(control, record, buff);
 
 		/* i2c may be unstable in gpu reset */
 		down_read(&adev->reset_sem);
-		ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, slave_addr,
-					 control->next_addr, buff,
-					 EEPROM_TABLE_RECORD_SIZE, write ? false : true);
+		ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+					 control->i2c_address + control->next_addr,
+					 buff, EEPROM_TABLE_RECORD_SIZE, !write);
 		up_read(&adev->reset_sem);
 
 		if (ret < 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 17872117097455..4c4c3d840a35c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -44,11 +44,11 @@ struct amdgpu_ras_eeprom_table_header {
 
 struct amdgpu_ras_eeprom_control {
 	struct amdgpu_ras_eeprom_table_header tbl_hdr;
+	u32 i2c_address; /* Base I2C 19-bit memory address */
 	uint32_t next_addr;
 	unsigned int num_recs;
 	struct mutex tbl_mutex;
 	uint32_t tbl_byte_sum;
-	uint16_t i2c_address; // 8-bit represented address
 };
 
 /*
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
