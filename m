Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A56CC48BCD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5A261375
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5A261375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F65C6EC53;
	Tue,  8 Jun 2021 21:40:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9106EC50
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc6rNpfbt6l3GLBZCYeYQwZjrxeZXGoiAZp29ark4LEz20CKq0as7GhAvpydJeJlOYKC6HxaShRFRz2LBCozsKQM6mCqYWE7tMgOLGkJU2hMhGO/qPiSYQHCdigAt7anieqjFZScGmHjtBnMl27+C3SvtwifxsGEyyWYrujg30bMU04LjtUjRYasmE/SxwouC1Zefdud9BR3GJEAvwxgeGD3ZCCX7VU49pXLNeKLaMb9tiQunvXXuhhFjb9Iwc/ZFUYAiKokuT58viJUNoY4t89a5oLMeN6z4OT1tWZaGLF0tAUwuqq2v7uGD21g8d0S+AdZk0ISCiM+MduN45vg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6Ex1wSbZ46kPofNTgbPocFyuZcPEJUuWrJ0toMT7uU=;
 b=BKqjDGCMrbXzceshhmpfwsf8S3RlHcTbKzyC181gTXWl0YLd14wiHdK+eglgZPw8NHIIeXS3COvOF3tmECOrVfsYVaUkw/YpEHPalkpI1yD4Q2g7sC65JPf6wR4bA/jRW4uDVSfKLK8xXps6S7Y6CBavmg4dJ16gnUBFFrKbyTbvaV0dMLyNBhI5Y2dpiAEjaMtnvC+v2wJVQ203s5wm9qGpNJviRTm9ac6CfyKxrEQ5YY16Vdtpe5buzd07o5BCGjCORx+yl8ET4f6lNSIqLKuBoYZnP5c4EQEL7Cs3xf/WVB+k1SA0oHXHvr/3bGfUivLy6RFwzd3xKBzr7YMOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6Ex1wSbZ46kPofNTgbPocFyuZcPEJUuWrJ0toMT7uU=;
 b=jj7JFMP0Fqxsulnk5laU4JU/Oa0qsnjiFywu7kSRlNEBKNngGyJn6HO8qBaFLDJKVcH8P1fk2gLroHQGM6nmE83Qb/OthEr+9Vn9UbV70YT18AGwGWdY55caqqgNTyoXHhYmXamYFURVZzlP3xc9Lw+I/4n3NCuyiKGP61o+L8U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:37 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:37 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/40] drm/amdgpu: EEPROM: add explicit read and write
Date: Tue,  8 Jun 2021 17:39:42 -0400
Message-Id: <20210608213954.5517-29-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f377809d-c265-4a4c-644a-08d92ac60dac
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB443524B33C5C5CBFF4A5C34799379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeBdoeeREqMugX/UoyEPUTCs1urrf5g98xbV8eg0pEw6fHaEE3+2fK0FDxKczUj+suA4T8XpJTS1i/sjJZbpTRM9qI0YjMC5IGNJGHtl32b+fblJJoLpjfLaXmOEiC5nz0x3rZe5sEWZ55tQjt8odtahG3lzRG28i5RnPJ7L8LN4/UE3GSbvLruBnJJ8r7ic4ytrITY5oDAepqerPn8MQZQYDS/OidLA1iUhQCLE4PVggvy3pZGTbNIdfnp7J9hF4wr00ojvtydb5hjehZgJ+FACZItZvtsDLEPc6OIHn4AGJsE7AnL+yn9Fxa/2Pt4VgUhZTYECG9SXwW8B5d3J3GyBxv30pNJEsGDp9akB2H203pJXRoHby/AG3nm1uVtVTL79ccP1JE5XzumQkunuqlO1y43YF6knO6bmpec1ZXEWGmL5Alt1qezzOCyPOIJkPPBcgMD5bM80USihDnHhfCBFpNmLBL3+Nd888iAfCl1vCksSr1gSs5mxTSEa/Vair4/sBAk0Bmx83Hmo0YlfIGQgfEhvUlI4yj3HQYx48de9qGs4EDyNys5xRK9SWwm88kTpEZx8+HM3a52fuR4nV/9sO9pKa2OFGcaKjgWMbX3EPoecQ/v8YfH/30eodnzpgow+UPslICab49R07HXuhptq9OWExPqCFh8WbC/rHWmnp+afjjdfqb/7UPcsyObg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FeW80b35awDNM7CSsfJUaUBG7txvx+EYl6O1RoYjMpUCxJX5aZgbrpb8ZGFT?=
 =?us-ascii?Q?Ri5oq+psPZ1zHF4y1stFKchNqyV/E46W9tKa4A747vor+yozwf+i4Ps7Qf7n?=
 =?us-ascii?Q?bUmYmyoNySCVe1pggsjuwOEwAuIpXDll/Ms5IQ2IJJfLCho2DB5QkT4rPgxg?=
 =?us-ascii?Q?X+Y61eUQMFLzE1J2m6bKehH9BQc5Yl7J6sdXtkMcdWo9WtcGwTQWSonBnWqB?=
 =?us-ascii?Q?rIkO9B2+21x7kgu9DV1pZIgK3kxoclicZ3pogTJjyoFDruByoYsWSnkWMO47?=
 =?us-ascii?Q?ViimR/41PoTguLBsIW7xP0Jw30gyNIaVHO+rhehoGdkIn/5l77j3DUU2FInA?=
 =?us-ascii?Q?aoJXQj5wY08AaVE7C4epw+mhMAa1EnpZxkM4L6IQwiXKqIIxVDXdDandImlZ?=
 =?us-ascii?Q?FO2Lfz0IpGe/FWrdFIR7ALm4jcitkn++fEvREarv6Ukz9A53BCqUHUSwwBA8?=
 =?us-ascii?Q?6f/NWiHp8D/oZ8RB1R99Ok4ikQktD/zBFpMASL0O+BXg1I7qg6gvJkCED6cy?=
 =?us-ascii?Q?SqMBh4WKBNKorkdOQpLYtkSV5Nidr1rIgvcdfR/ymYWY29tO51RNgvPuyvCp?=
 =?us-ascii?Q?nLcz8XLN+n+YuzdDmR5/ilJO7F5agfu2aw+MMHfx0e8X1rh3ngKToafFuV77?=
 =?us-ascii?Q?YGoAeeKOpLFkrYkOX847jYsRsvtA9mrinR4bU6MFivEqLjF7w5BcZhT+yBrF?=
 =?us-ascii?Q?7EBgXdD9HBNhL50cyQ0rUw3uhHTxpKqgS0pMSzICvv/NgLjhYhRiSyvmkbQG?=
 =?us-ascii?Q?hQwgXY5n6A/iCTaGgG9hsqiu7Zkri15vX3RcKWjAsVfy75730NP+mxw2YfBC?=
 =?us-ascii?Q?yjHfsd/0VnLIkkdFsd0l+8MO0w8uGkq/+jWkY6ethfAsr83D2Bhm3rAlcKY8?=
 =?us-ascii?Q?Bb8IPj2dHIppx4BGA5SgJlK0DQGiORMYdPdqwSTf30jo4KtjTTOxpeFAst/T?=
 =?us-ascii?Q?MxiEPrbvxmR9oYFFey+d7flTZvSM+hFZVQ77G5DdqNZKT5VWX8L4w548ACfb?=
 =?us-ascii?Q?qAafnn8VGWk8ceuGNg+Vi/tpKJ5GOFKU7sAlCC0sbFlxksFSPkj/PoPd/2HP?=
 =?us-ascii?Q?8l1qUSDYhRnRq+4EA474pkHyBgnYSzmCY/fRhXK9uhdFzxOw9o98E5tAfd0N?=
 =?us-ascii?Q?xtBOfRBwVb/0EvTJB5YFryHL9s2OqII9pOtk4oC2Ao2H+iZ0/PHaex+7sBl6?=
 =?us-ascii?Q?VEppwRHLX6CuSMvPlPogEBDiBaPR3PrCckUSkCy4pdMEoXte9kIgyD3i5pGy?=
 =?us-ascii?Q?4fD4+tjJTAVp0Dey8TrrVwfjcT2QvSss9ZbMqtHJ8e1XvSTnEQh9bUQ19fJI?=
 =?us-ascii?Q?xOCcgSABf1SjHHn97dhnTmfV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f377809d-c265-4a4c-644a-08d92ac60dac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:37.2437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h053yaFD/pxgIpz/3Utgem3TCLYs0cBJLGyizTbPu0mONjaEkHZbqiiYpb07XJ44
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
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add explicit amdgpu_eeprom_read() and
amdgpu_eeprom_write() for clarity.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h     | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c |  5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
index 417472be2712e6..966b434f0de2b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -29,4 +29,20 @@
 int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 		       u8 *eeprom_buf, u16 bytes, bool read);
 
+static inline int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
+				     u32 eeprom_addr, u8 *eeprom_buf,
+				     u16 bytes)
+{
+	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+				  true);
+}
+
+static inline int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
+				      u32 eeprom_addr, u8 *eeprom_buf,
+				      u16 bytes)
+{
+	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+				  false);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 69b9559f840ac3..7709caeb233d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -66,7 +66,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 {
 	int ret, size;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr, buff, 1, true);
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr, buff, 1);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -77,8 +77,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	 */
 	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
 
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, addrptr + 1, buff, size,
-				 true);
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr + 1, buff, size);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 550a31953d2da1..17cea35275e46c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -151,9 +151,9 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
-				 control->i2c_address + RAS_HDR_START,
-				 buff, RAS_TABLE_HEADER_SIZE, false);
+	ret = amdgpu_eeprom_write(&adev->pm.smu_i2c,
+				  control->i2c_address + RAS_HDR_START,
+				  buff, RAS_TABLE_HEADER_SIZE);
 	up_read(&adev->reset_sem);
 
 	if (ret < 1)
@@ -298,9 +298,9 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	mutex_init(&control->tbl_mutex);
 
 	/* Read/Create table header from EEPROM address 0 */
-	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c,
+	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c,
 				 control->i2c_address + RAS_HDR_START,
-				 buff, RAS_TABLE_HEADER_SIZE, true);
+				 buff, RAS_TABLE_HEADER_SIZE);
 	if (ret < 1) {
 		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
 		return ret;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
