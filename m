Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F66C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F59A6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F59A6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C001A6E243;
	Mon, 21 Jun 2021 17:13:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E7A6E245
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0AGZTq0O+LVa8ZQe3Ax85HUkOavBO3qA/JBM1gUDJ03dsy7caBuV74aJlj8vWRihUfOb5I6DBnZcoZIpTmibLEh6DoLonIDSnGghGbVe6/qx0PohUu6S0+D7U7RjwnPqTSt8B5LGD1mtarGlytmzt/yuy2sCzh4sgxFrRLffwqEsGaPgJ96bOctkIBWqwdbzCB1MF30+DAuVQOuguK3xKcwPpcr3bRzVFIL0amr+/3TjZ4yp6blV0BIQiZF34X4sJktDFMGVv8HgIDLzUfzaNe4hJ4EsRNuWpMfwka3GeUWuxbug62ELAM+QNT5vWfW3CIAboVPFP6YmjOFyAQw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ssrUyPCcFmbN4ljQsq87W8kjtn/fxeH9UveSO7GnXE=;
 b=IZqq5P5cYfZhCcLbcgDvDuy/YsJW79xp6IM2yk64o6dCpRoikMrFklDeela/SnZrT79unzUs1vzh6+oj8E/QdErbOr6ySLJNuftpUbE4AUyoPZbUTYxgw1tzbf1WXdccE+Gdj/wiH4reOVg53i8eRKVbIKLKuuV7TudFDe8yOqVOJR99F/c7ZdN7XlJTMw3Sz4WQiDSWa0zjnsfMeBnFwXLwQxT98zS12mE58sPbIiCYvxOLjmoa691dvmELU2FL9GuzVHdMLTe0ankxQybpmQgXlw4INZoP7Zlqp2+CIxuhO4AgvUeWcfrvSBJlz7vgYBkCNwqU5T+bUdktVci98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ssrUyPCcFmbN4ljQsq87W8kjtn/fxeH9UveSO7GnXE=;
 b=uZd/l05yzGLoBJeAN0ib16AEAXVZAPqK73cT/1pEBUlfDcI5zCSQauRla7dhCGL3cOPftjfhzUB1YQOaf23GDHt+Lft85OUkaiFl+HYvqvOBEcc7lhxkupWEqyuJXfh5rD1sdtac2gLBcgdGOORcQtSgawS7krc2PtqskoZCSkU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:52 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:52 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/43] drm/amdgpu: RAS and FRU now use 19-bit I2C address
Date: Mon, 21 Jun 2021 13:12:00 -0400
Message-Id: <20210621171221.5720-23-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec0274e-bc8d-4853-b5f4-08d934d7cda9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB386581FC960451E17B87AF17990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BYJF4vKxCinAXWE6UFQS+f327pJYO5VAdWYiV317mx7DYhNxFI1LMpkaXEVvkyY2DYx6fYIS1jWasVP34WZ1MQOA8aFRop+FgHNF3umpVcmjSfB6EXAEMU6cwa0Yryb94ZY/lGbTQHKfQkpSezIMuvCRE0rRhJlKA0AUQQxc8DhE6At0Ey7YF1xfHeBBZq78eYbVtmB8rGwDISzU8bTE5iewGSrhCUZwCUovVEIT7xC/YdxenZETqTA9hlbEfwAO8/m6ANmMicn81g9xg8Ff+8RSQOGxI7sbrq7+8iVdAaJuX5pI/LPubf0BenRsotxQdJWzv+m10fZXkuesZRjppiLXF0wpAoxi6A1H2Yt5zcjwEBZ8mRSwQisRXZ6JrLJcnQAZV+cICKWNLyyGhq6qe43jv44rnnatU2AW6n/y8eD+agO/z44wBCWFAX8WX4QqhRNAH2tG78yGxbby4Vl8h03qV1N9GVHXGBs6JvsnKcZ0rOvUGeLynKZEkatBF6FJ2btxofVWIqmPqDm5FSu9sBrH4S9oHrsIdJ5wbmSVD1usfLwEgMB+R3Zb0KCcWfjf/1RPvIuZZQM9s2tUXq1HVHoylsl69/7RCqk+4osyz1N6aM6ivvakgwG5l+abalPEjZL1CfPKFFSOIIEMaOWFQYR5f40C72/AUKcLz2BJhKKhX62OBuk7h9k70gNgZBJx7GEDkIwGBkDFC5fk6VlenQMEFVl5StcXU7r0wlYN0MGGlTsIkKUQ3+R+JPA+bkK3ftmziUtOWFSUCzt2Ocfq+mC5aDrcP0mEGK6H+rllPL15PyvMtRaOiWBAVuXQggf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(966005)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(30864003)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bt1BVsQmr8nxz8FLflc7b16ElKWAsfaWqPgkxFyTJumBouls8bIXPqytsnDF?=
 =?us-ascii?Q?tEGp8hOnAoJ5vXY7WC8Z541YFasjEI/RdcQj0OKDCi09lkdpZfwbe/qWocxe?=
 =?us-ascii?Q?Rl2QRu+1QlQ3tDKmbq7ydPTeCeLYGemorxcj+pFhfizSy2sfoZULOK4MSmhQ?=
 =?us-ascii?Q?Icx/5drbSdXE2RYGN3jatmdF/40HRAcwOFXUpKoGwq/ceKwp1QMMfo7kInoJ?=
 =?us-ascii?Q?yyLIAyP2Q8ECZcEw31SrWEbG0p9mNqNaOFVfdEt7J+vKo7BABYGmKtDbboK7?=
 =?us-ascii?Q?0ZkEV4SylZ2kifx34dCb8W/fjBpl5bw7G1WLiY6f6EhAlMNs1O/YOVDnv4Bz?=
 =?us-ascii?Q?0W5Ja4PJ8CGYwdINnfz8hzjdaBigsXn9w1hKbTNw10PhGOXZroQgl3N+Z1Rh?=
 =?us-ascii?Q?4tLBiqKd8roDOGd6spFUzX+3mNUYyRdw4n2T8Pp2x/x57eZd8Z3EcIXTGol5?=
 =?us-ascii?Q?qnbjpETeE2DPIKTmx03Al58ccBRNIXWFq9AJn5twN5PqvMS4r85fAFhx53+I?=
 =?us-ascii?Q?Txtkp+foT3W9pYIqTuk0euR+CCy7AkD1CmpspXqJlwJUAnCVT4WgogWJ4Mdv?=
 =?us-ascii?Q?Wz1nc4CYRQCpbxFQhfD6FLgG1ayQU3BaA3FP0lYWG0lBm1c/0mAH6ya7sXmx?=
 =?us-ascii?Q?VT2PB0ryKXApsKq/MAdnhn//EOcywIBRbhYtredBSpKKJeEnpHNG7JXrhcoX?=
 =?us-ascii?Q?kbrRD/vaOCQTCrARPanjaWNB8Jc4b2vYfhGSu/z+v49kugiBwtp0a64+o1uh?=
 =?us-ascii?Q?c08l5BOgL2MZO35cERgyT4mdW7exY7KpyhboGaA6uDLquh8V1OwweRPiFUJ6?=
 =?us-ascii?Q?JEOFV2gvLyyFxSGVRPugbZkpfGG0eVj7NezNQDUI7YVQXKruCepzQBDATtee?=
 =?us-ascii?Q?7Zc4T/BKWmT11hZ5RGYU0QXJdaAVONZGgofbMlmdFB/8gbiLHPMxdGZN0Mun?=
 =?us-ascii?Q?rXHm/Bt2BaZw5MaIpAHs+Kkh8ZVU7s9qaC2oig0A0Ie2Kbs2taaTDue1NERV?=
 =?us-ascii?Q?Ka/ezTA+nHoJo0ps2zqiwvcwu/I1E8yzmQWdwKeHU1+nkqNv3435rhaQ52wp?=
 =?us-ascii?Q?5KoVNWjov6XW0w4EQOKtPceuH9BTcR9X1ijo+hneIT4SRnaupkEvleMrL8h7?=
 =?us-ascii?Q?xf8ZS/dlsozleZVqNKMOTrgzN8g1HIA9Cdo0J+EoxUulKFZk7imW7RJR2Ow1?=
 =?us-ascii?Q?Ai5CFKQFhhBT3Uh3BO1wDPfXq/jSpCVfB/adEaJEAZq05u9yX7WK9+C7bSwr?=
 =?us-ascii?Q?bYoR1B3XnvPHafADaP4WIUjApIQ4h2p12R6/XYht1vDXZVj6CrxmC+iHQVYq?=
 =?us-ascii?Q?7koS6hRuDUYmn032vvzvGIa4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec0274e-bc8d-4853-b5f4-08d934d7cda9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:52.4529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYDotLAHzBY/UYViWoOfnb1OFRg3CQwm99M4rkE39ZV03fbQd0j3sG2CLABQGGSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
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
