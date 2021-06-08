Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC7C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60803610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60803610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3586E59B;
	Tue,  8 Jun 2021 21:40:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054096E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KauPYo30mtT+2anNpZkHbUNMNpPCMWfri4TjEsw20i2Txwsu4DAUpCSoKs9xlUENZw85Cy5c/jNfo7KPIRYm73AYEPH1S0BQThLmBkX7YFsSpFtHQR4x2b7Hz2j8X/oDALZOJO4OMmEi7mY9XqPscbqK/L9Ei/yVqKQDikx4CgZxTOXiESQItIkW0SR6KVWjawuQyh1fOUYwvZ0Hiw4VtaofDDEy61YJ/aCS1/p2oClz33XCzX/Cpil+UoYAX2RFyMQuwIaG9T2zJ+ptxCw2uheGR1gXh/zHonPu+5tFBNFCaNoi6hVzRPGeCnP/RWNimrYRQkZXzxnFV5+8lu4dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ljTgQQAS6SaVRHc4TEudZIzLo9SEZPL2GLYmKwZHc=;
 b=IFtJFmgFphK3MoXdbkgPIdqjckey6aDzyWo7q3RF1fTprbGqjk36mT9hkEsRU0Fs+x2T/69IilHZlMJE4aY6dZtwjQ9VrQ5AX39prkNZOeEBUPxB5C2NSpYsTbZCo61uWx2spQVwaZ/40DnFK+uPX5EITpbTqWAZIR80L9cH8iMQE/3g40pTjRchnY3Y1LSM3Yk7EBpaA9ejviNzcjD5/+Bhsp45NKt1lpnBo43cBtZhioX6GZcZZwmkFzszfxhofXS9Bo/a7hntc+53sCO+CUwb+wR9VYfu+nZmFsI5NNlIk+axkXtsNa7JnjuOih2mmu+I/XR6djH1MorQe3BWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ljTgQQAS6SaVRHc4TEudZIzLo9SEZPL2GLYmKwZHc=;
 b=KaGQ+rI+y7LOpEzFTNHUKCL850pGNUa2ECMyBRiwaBQNM5JpgXGeRj9uDq3ZE+UATGswINusvOrPrDh5lqj9dodD+3gKrX+Dx56fwb+EBrGMQumf4luk/0Nt2uv0caK6qpOLADth34Rxp9So3DiWXAs3buGd0ARTWrx0Pd9VX0w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:18 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:18 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/40] drm/amdgpu/ras: switch fru eeprom handling to use
 generic helper (v2)
Date: Tue,  8 Jun 2021 17:39:21 -0400
Message-Id: <20210608213954.5517-8-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba921408-272b-4ec5-1294-08d92ac6023a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435560883DC83AD0CE54128399379@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DpOtHhqq5hel+UslAOrxBFzBvjAR4fK5JkMajoFxZ9aST9mSmuTQwPOlwJc/CbuHX/u2CGXID+3QTwQee09CU9t+4YrjQe0DXyIa3CAc8vNkvmYCvMNaB3HPm+QAylvCXqvawFYTypb1HGUvIJBJ+ufvVPiDDx/23BFcEQmf0g/Yl+Tv7tfjOFvD4i/Q6o5SGcXmn3KMfQF/XaPUUsHzb0MHWQiDI4u+co5w7aMqACTVZQenVM9YxbEh4c/xB5vk40Tgdf84cs/d77yHK6qqE0rRrdpLnbPrzrbXTvSCmYOG5uJ588LMj02QDELBV7n15HdWJsdOY6tWGKH0HRBv1lJVCBR0jyIlL4TN0VovIr/tkBKEad6h2isr194NRwGaKU1gqsBvIqYeK0MphlyeheK/CR6h0lJTsToOXB+FZPfETR2Rr6zX/Kc+0hgb+0OMVKZZNA4SvBY6RT3qR+3dgMmQ7b/fs2q6vG5M94xKCGZR4Iff7l3Xsu09NrMMpFIPiFF8JdLcZXRyZ2H9tES0HBy6NK9w57zka50y+RlOksr0KH+PNyDnAy8yYD8i0r9IjbDejq5lOb/IhV2WId3MPJllW3ivYRxlVFclsM/hxFWY3PjyLJuP/qQtuE2Cv6uIQPY/J1pnnboOdG7T3RRibmlIpUUUWdZnFavuvn5Mzvh8+Mu7g0JM4mPcOV7EwLrxKMoL1tSpSRSkAFUJkwtFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(44832011)(6512007)(66556008)(66476007)(5660300002)(38100700002)(956004)(38350700002)(6506007)(478600001)(66946007)(8936002)(36756003)(55236004)(2906002)(16526019)(6916009)(186003)(54906003)(86362001)(316002)(6666004)(6486002)(83380400001)(4326008)(26005)(8676002)(2616005)(52116002)(1076003)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WBSKy8WamzC/6mRxWkh82fwk3F4rikg3dYDqe2BgWRDPlHzaRi0xYfn+6lBa?=
 =?us-ascii?Q?hMpzcnrNje2v9ZoRX+32Dxwqo7WVPCj40KbZK7Ky0AgsqRiayfoNs4R94wWg?=
 =?us-ascii?Q?b8XJYWSOepH5b68f334xtuQAw91zagze6i0EnPFxp8p5NkdUuAQ7s3tu65vO?=
 =?us-ascii?Q?IzAgp1RJa8nnAujxSna5DHzk2tWU21Qnpc4mmapRFKggMMfZWOlzoiuvOk1u?=
 =?us-ascii?Q?RULEr7BaMbr1T0D/LK+corWv6oZoU4iG08+2AG5CXMkE7E5M//ApjD2f/kUQ?=
 =?us-ascii?Q?JpQ9stFMYo9UTzAFnxKtyy6pUcEdu4aDx1UzzRU7H7hOubadPanfmt7Dv+/Q?=
 =?us-ascii?Q?Xa24d5X+oxOrwOPv10Cj14TbiHqCkOqA6CfadBOt6SHhkj4SgpULzttJhMkE?=
 =?us-ascii?Q?6pnCA8yC4RnE8qDPCAF05mE7GzI54+AkqdegtuNX7a54pozzoTSWrLMC0mC8?=
 =?us-ascii?Q?KOU3Vo5hlr8q6D6IN3vgg3UwK1h/1IbyfTui3X4CRVCzYbDA8yym/9PZ5yS6?=
 =?us-ascii?Q?/0C4859cfYFJlj0MPQwoIvZ3eFUg70sZY+F6uV1C5qYKrP8Av76/EscRY5lv?=
 =?us-ascii?Q?6gnBWKnGqdzGX9zFQdsIrffe4iZQgVGHW13W0yKMx3sXLdBYu5M3H4nDvX6O?=
 =?us-ascii?Q?+aty/2JByVyHp+ZCJHZYcTwU++l46DS6SFDcYt6CQJHCfka/mLBN0uFajybP?=
 =?us-ascii?Q?+x9FaHddpSOXx796wkSAQgDRMoJHP+drb24/tMWXhgmZcM4tq2bp4ppOVMiY?=
 =?us-ascii?Q?QZw+PSajrGuggYrzYrqKnQPLB9oUwLcruTQ7zXvDEhXMQD8YXMmc8CTFkAqW?=
 =?us-ascii?Q?ObeOhJYuidrvhh4h6N5xOVXPhr84GzzeqGM/eAMOnHW2XLJU9JUgMDb+/8Om?=
 =?us-ascii?Q?InjTfDHV9iuuBsYvxIWhd3XYzVVrhMduKE6+RKpKaTFLuqDHM9la8cKNEStQ?=
 =?us-ascii?Q?A38Uca9pToeKY2EzxRmJeO8X7CiuUAdTDhNC8XxRz07wXbAe8NgHvPpIHlSK?=
 =?us-ascii?Q?zAKehZbZLGt5bXZZp9QE1C3uda8uNdYT9UVRBjIluGlcC/bhoNXcQooPa3dF?=
 =?us-ascii?Q?41WstwmbY2rfWTY95jvGWg5rM2Z1D9lGJDc6xVtvqGqrURHdpRpVHOotxPTY?=
 =?us-ascii?Q?NQwHvKdSmSafPLKmH2nF0jbh/CuVxvsxXBsCe0aeBEr7ZwgRaQotTQbWuqFs?=
 =?us-ascii?Q?7Qobbmn3bD6nHAQUWvRyH1v8uGRByr0KANWwz+7PFHHv84Pjro6Q3NX3wryJ?=
 =?us-ascii?Q?7aKDwstAGCw4V6ZwfS/daAyZ/V2WWhpZ950S4JB8SU4+f/EKtsSKonxYwb/Y?=
 =?us-ascii?Q?J4ILSha0ZXLu6mYaPmvw9cQB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba921408-272b-4ec5-1294-08d92ac6023a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:18.0216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+Jb3SSj7d7wvjsjhvRlQqCPIzQ0dzA8TEgNbhau9fTOaBT32ZTSk2QexL+37d0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Use the new helper rather than doing i2c transfers directly.

v2: fix typo

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 39b6c6bfab4533..224da573ba1b59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -27,9 +27,9 @@
 #include "smu_v11_0_i2c.h"
 #include "atom.h"
 #include "amdgpu_fru_eeprom.h"
+#include "amdgpu_eeprom.h"
 
 #define I2C_PRODUCT_INFO_ADDR		0xAC
-#define I2C_PRODUCT_INFO_ADDR_SIZE	0x2
 #define I2C_PRODUCT_INFO_OFFSET		0xC0
 
 static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
@@ -65,16 +65,9 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 			   unsigned char *buff)
 {
 	int ret, size;
-	struct i2c_msg msg = {
-			.addr   = I2C_PRODUCT_INFO_ADDR,
-			.flags  = I2C_M_RD,
-			.buf    = buff,
-	};
-	buff[0] = 0;
-	buff[1] = addrptr;
-	msg.len = I2C_PRODUCT_INFO_ADDR_SIZE + 1;
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
 
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, I2C_PRODUCT_INFO_ADDR,
+				 addrptr, buff, 1, true);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -83,13 +76,10 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	/* The size returned by the i2c requires subtraction of 0xC0 since the
 	 * size apparently always reports as 0xC0+actual size.
 	 */
-	size = buff[2] - I2C_PRODUCT_INFO_OFFSET;
-	/* Add 1 since address field was 1 byte */
-	buff[1] = addrptr + 1;
-
-	msg.len = I2C_PRODUCT_INFO_ADDR_SIZE + size;
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
+	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
 
+	ret = amdgpu_eeprom_xfer(&adev->pm.smu_i2c, I2C_PRODUCT_INFO_ADDR,
+				 addrptr + 1, buff, size, true);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
