Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83005C47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FEE610A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FEE610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3DB6E105;
	Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D972E6E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS2rRmiZxZiJBkexAuI6Z5AqfXnBpIESJo0AVP1PgeZTQ1SXF+mbGLmpt3/4Z7DXbukjItVVOWeiKi2KP+8L1v6pOL+MAPKMPOwr4SoJRdHzaEPl7KNyCO43aKdpp4FYN9Vm3jNXtC/9lHjq7zcUX+Q6kdORq02pIyE+WpNlS4uQL/X+5OJO5o6SEc9j5mrjoUxon/IX1uRZxWTLiAwY60FP3U871oCpAbqVUZxi+xE2R/3jW6XXpnkQt5Dr13o+enqg+m5HiVaqzccHO2NXoJEg/37/qVj23QJWJFaXwUs7nC8ui5m5Hfq5a/lK5CXXSri8XooH681PGPUeF4xFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ljTgQQAS6SaVRHc4TEudZIzLo9SEZPL2GLYmKwZHc=;
 b=A/Ge/r+gMliQOqJfP1Qs7SPHzqee3NxFNQlzVUuG0qsu7MgGZBlIAe7iA0A6NS6FiAKvmwzZbdGjDhj4dXbfbDFIUe+t0xonK5f1N/8QzPHksqgf6XwQCRYC2XjUpxd+U2GNBPZnSEZyi9IyAgGiFOCkt/FnFOkuFZ6n6scuhC/wywAuYaNScOUdexH521FpSQOJ/QImXccKRw6fo3m6lrM+jyXar74Pk0w7FvSmsNR4rqbFW2Zt3jDcqe2xeDal4lFplTtpG1T4lXkZo8IY/l44tA0Z2qwY3uSzJPl4+Yl2hoSjq1QV9P8idjXbvlpGudAYVVrWPqLwM0WSNDUGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ljTgQQAS6SaVRHc4TEudZIzLo9SEZPL2GLYmKwZHc=;
 b=rxeFXB1O+x5OC2+Q20KTcibBFcbXhX9a/5ywwAQfO4n0MO00LYqNFob2avW3NFimGw3FGUXitRSdYwEmxTJN/SKaitXs7cOFx80Qx/hPolWkzoynnlzwpcxebmB1Vom9ZJOjB42ptOWhD8O6K++LcVQC+ijTPXDuay8bLT7v9Ec=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:52 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:52 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/40] drm/amdgpu/ras: switch fru eeprom handling to use
 generic helper (v2)
Date: Mon, 14 Jun 2021 13:45:59 -0400
Message-Id: <20210614174632.20818-8-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931cd342-2083-4650-19c8-08d92f5c64b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47486A5F32B8F6680686596E99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gc5XaCfZFXkiYcZj6OL71WpbQvC7poe3md+gY8SMzBPfWLhfrVwWaSvdUoJVRnIA6kVy7yIs1s//BG26p4Eyx4dgompY1b2nSTyI8bC9M5HdDrzhkbkYnKeV7sJfKtNX+IF4Qiu+FJj+VqTDWs5sTgHXEPjjr9qvCGLqXX7iUGRZUQ7v87VZKeb7ShI9Ora9ExGIwyTKZf3z4vUA+aEr7Xl4m2XmMOVbDp61fVdF9wIsUfCcNs0UwQotumcQOcfMBQEfd+m95lm7LY8LMCfeO64l3beK4qoggERTg2aMTOfzCemNAsJ69luPEW+N6R3tkj2nl2OVNIe2C/x3CjMCtw1Nqkr32lS1VDvOHnPtvqA2Cz79HVzMmAQ8uu5Pb79SJ5BELF8qs/4YmcDsdMLx5G9dMsH7fi27Fy06Smf8X1wnfY+A4hw7na6hLSr3a5xcWcwQ3SxUM+MgW/8Ndamv9cmJVxro+Sbyy+gFY9pJn59LxrK6pklBXrxXCPk6Of21FQ7hlO3XIcO4bsST/dNcKgctkQC+6BNnaIBqTCrerlZ7NxPyHDtDRgTAZaPe0q/ENLVkOFmU31h042eQ/X6mX+rTElyGwKetjnWFqiRFvTIPjCVUGU7cwOj/hpJDwHrZx2IPmUGEKEZD1auyPTySMi+mSlQVC+fMcHbalOC+77L/afnTqMDDrCYZrBfaUaoQ/1rrqGH5MBfNldbvP5hlhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U1Ve8EfimSVpmUIpkYjr3j27E+Ktso1TivRmPKLAS1xAZDhPkHGGayMup5/w?=
 =?us-ascii?Q?nBoC/cA5RwD7yeQE2qggAfEg3QE54te2quF3oA30DcVTdt3zUUs7S24suV7M?=
 =?us-ascii?Q?N9tfhItbTwzRoz6K5L5mt9FHmsZpnMNwmI67MH8uq10fPoPJyjSzWbx7qXdC?=
 =?us-ascii?Q?8eiT9q7FkHA0kRCzdZcmsv1Eo2ABCQhSwEuBVfo85kjHV8Kn+gTyhFvcoIoV?=
 =?us-ascii?Q?b6EmwsQwbfQglEcUbnMCk2AXHeALtxIYb/XF67FAYIcJyTJu4CfiBXZsXWZx?=
 =?us-ascii?Q?meYZky/K6PokAeb2uK7Z9fi89LmiUllrDHVzpoz12JFS5Dp+kRkqc/W4JsO6?=
 =?us-ascii?Q?n3mGu8IK3JGDkA9eV39gqOU4TxSeqze1IwLfObZOKcE7k3twAYcZ0WtDQELZ?=
 =?us-ascii?Q?8639Wl7g1vC4LGQHjc5zc9gnceBV5668OABGfVQ6KVaNN5aHkmFvk4sEjAr7?=
 =?us-ascii?Q?uqR5r6RFdoDHAQqAXEHOKr84hG6mRgF00BOjt3QJhX/Q8f8zXVnaBroyZ7NG?=
 =?us-ascii?Q?v87SGwYPKc8vFdC61KUE4ajLYGi7xL621UO3VIG66qBqs1fH6qXw/ebX5xzS?=
 =?us-ascii?Q?2HeDRdp/bxWJmWRbEWjjq4dOUecw4TW94FHkvJpktz1K30mZOZ/GuPSuD7lF?=
 =?us-ascii?Q?707jCpbgq1X6NsyaUgAnEhW86YNJBlD6oLw7EtEuHG0WcdwOFXopUsNd29Zo?=
 =?us-ascii?Q?0xQlE1Rgm2Gd2XRg25BcjHAy8bj4JnB+DIW+LYvjjDBVJW2eiKhO7q80DCLb?=
 =?us-ascii?Q?sEHHIFJse8xet0vEVJRkRuSZJQeCUKoBzt6wpK/FlRJ7rUVUcqkqgkPNxzR8?=
 =?us-ascii?Q?DPtEwVI8saH5+RjXfbSpKUIalS9Df/1ouPvPekYadyRZ/YTvYmljPsf65gUs?=
 =?us-ascii?Q?sbsYKXAhFG6P1x82DsxYQnWlfgRJ/+dv+Wh0aSWSDY9EtVwBYk2c0YhSXY5p?=
 =?us-ascii?Q?BGzkYhRPb/+aWczI/dfn/YP3TLDvayf9uhwl9sW6DEOFlsD0FOXnCldqUAAF?=
 =?us-ascii?Q?v7sW07crr2QsH9flhiOzvt1GPvlBFqcoPiJ7Ptub+z/m6Xk+/0a86ZOAza/Q?=
 =?us-ascii?Q?1qmGMfVkwxdKMGQ7HpTX3ibWBKx2Bhbttb6ixrAZO/C6Jr8tg42JJzD/TrIk?=
 =?us-ascii?Q?JgMkKXaFrA7cQww2n1xgKSjdZRCrNbnMFl+gBFlmZHGrUKvPYsWQsELh484V?=
 =?us-ascii?Q?if0mNku+SGWV6ztaNYuOc1vImtGnbFH8wTrRwLP/KNGnGctrklr/DNpjFR1z?=
 =?us-ascii?Q?a0AstE16GGOZ934QY4RVNeVAjSZ/p0gaViDkQp2o5fMc9EZH9pODtlNm4lvB?=
 =?us-ascii?Q?B0JWWZc8gaJ1qwbP6OlEU9W7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931cd342-2083-4650-19c8-08d92f5c64b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:52.3837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iHa1Qs5BaFy2m6HKLoacGXlIFBoZrsK0vxsy/krf4q83BEKzSXtHCznyjgleXTg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
