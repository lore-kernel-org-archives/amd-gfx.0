Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EBAC48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A1D6102A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A1D6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9416E223;
	Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFB06E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+v8kpGr03mFm/hM5/NO5skdkgDf9QtbQYdb9qkk8JktNUP9K+JxLWU4yTVY/7o05xKGkSNOaI7D9AWfI9q5XK3OPHefVlC+xLg2x3GynllFu8/noxE+mlfZz2rjTluAdXt7x/0b9hUejCv0Wcy2YAed1tK3cUF/xoCi9Bj2Kx/sq8Xe4OVNzpC+ssqp893jM4rSKOeNz0+47pGUn+wZc2Ovsw3v7Y9aVYXMaW/6qp2nIOLR9YMmOxi05/W0rmGUibPFmnIvAMm8V9LcSxObS8U5BN6Mt8TGdDUZp3icvqCg64IwF5IMOZ4hAE5KXQJISl/mFjcPTuNe22Tr8Rb22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ljTgQQAS6SaVRHc4TEudZIzLo9SEZPL2GLYmKwZHc=;
 b=Zk1sh3cuqRlbGUa0JQJx2skVqywGFGBsHBqQR251N92f4LJP6daMvLLfy9d+njVbdd69LL92qXu0LfceljY5yFvUaV3AoMMSnAtqm1u7sdDFOLPUT1UTZY+q2kbBDGB68n3f8Na+yfka/MKLca5/8IB/SKhD0IBIH//aPSy7LFDwsSd15N8/qBNC/BKaIVLCjryrvFPloOOgAsLs1Fs2+9gxmpHNU9bwT/Mh0x6LFyjF4ESJbEDBWq/rCui+er/gK0TVCLX66wlQxdvt2F0MlAKIhRu0zWt0MLAMnAHuQYJpD+x/auZj+lYoS6GqhoG6LBz9b23JCSoPKP/MD9NRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ljTgQQAS6SaVRHc4TEudZIzLo9SEZPL2GLYmKwZHc=;
 b=OEHKVKSEboupz+F66UeQItjLC6A0dmF16LdYo6UJEZZCSex6MjC00QE3QE4+8gIMpZXFSmmarBVrPSFbm3yEb7UiN6FFtar6R76bOwIIt37ZF/FCUg3hlYseUeUzaKgKjuig7J0h5zqIjRS6ALXfeZ1pwEJHyznmKp68PqPeb7I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:39 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:39 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/43] drm/amdgpu/ras: switch fru eeprom handling to use
 generic helper (v2)
Date: Mon, 21 Jun 2021 13:11:45 -0400
Message-Id: <20210621171221.5720-8-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89cb9569-c481-4284-2afa-08d934d7c611
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38657E84CA551FFDA03DB2B8990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3h6j1t3npZ4qcd7+ln7LxbggKNj1bib9I28DRC5MOSrKuvVGS7wgRG4vskLLyg0UBzsIK1vJMfURhGB7/jStmIxdQ4c7zdA+qaKcSmFB6AyynGjaWQvUjxF+Oqic77EHVmjqyoptrBFaQmxgHK/oKzNwHLEyHVdlYGTrrovIjyt1RKV781MfjuIWaoy5pAeLsjvOzg+VJ+Y3fQ6L0K9cX6uixmUntq5UY02jU7MQbhBuyVE9L8F8HsavpnYimwp2I92HOsGU60xKGeEynOKbLTPPygAE+6sNaxY2ycRMkuqRaTNhDKuUYWLEcS2Bc+x40vuz6oUjqtuSGDxsQ/RED+1cu/QzM3pjHmrB8FcSh+hVuc7XUyuyGJHDNugDgCOWsDEE+DI/DOR5ppFSgR+hrkSWk1Jetf5+dSTjzQ1DTdjzWP+DrpIiOpPPxZJR/SVTROWp6pxJoo34+fUsnCQCt8erjg3oA5lLmKqfPJH8e0a4gF48EZRxD+DAozi0PFVUxg7WmLEsMmzLamp86VQv5PRdP6MW2mJKQIKI8U/0hxXQtPfiA3qxr1cp+dvHe9eB62aCi1IpjEZunBOMofvD2BME/mJMYvT9RBRxo2rdJUDN24Gh/wZvT/kygXfHOl9AQAWAETCNh83RG+GmJ7chMUVb3uUw6A0UqX9Xj3Koe3SY+v6wYNRdR8fSiciCTHd4y+3t0/YH5iTe4xF7uGCYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xg3kL0E1OexB3Cktgf3aKOzWCdf/vK5MALjvLC9/3j5DTXrsymFXZ0bHN/iN?=
 =?us-ascii?Q?Hbr4iSjrjXUEAcHN8NgiV6vMv/SeQ9hzHyl2QZZpp/nb2/QnNoJbszp9hok/?=
 =?us-ascii?Q?O1ZjjXhGNJ3BnqUPRIeI6qGyL4D/Mby3Yl89XcGqYQugXRUHPq1bDxgrCEWo?=
 =?us-ascii?Q?lUtZq7x7+Ud25/tflQGVJZ86uLOJzADrwUMgP6hLlZ30wdFh+t/BL7dlYIyn?=
 =?us-ascii?Q?eCY79iD5iQMkFwN/JOA4oKmiD4fhS2J+LUBc384wQcJ/l9GhKYQdYQ5xfuzr?=
 =?us-ascii?Q?qlC3mElm3GEShvRktdXPrrFiLeyf5Xys9NSj/KsttXHu24421+SBHye7BB+W?=
 =?us-ascii?Q?TZzCJ6d3IW94cMgRJ6pVem6uo3uClrytLZ6TJBUtRDCv+SO/CSIxA3C1cN+y?=
 =?us-ascii?Q?X276d4w0pNi9uzgOjc62N4odj2bki0L11Cx/F82HYUMF0ILo78VZlif//2f1?=
 =?us-ascii?Q?WDfFeLfdBfqDnRfIqGbAaQsjRa88W6ioUILSQxTpvbPOCIpv9TrahF6Yboa3?=
 =?us-ascii?Q?DBXy2sDUm4u332wrXnFz4rwjVZu/DSfOk2xjmf20S01mXzcjTrqOnDsOWMjR?=
 =?us-ascii?Q?Y2hdyAmJ5KgoDYZ1m5WguFOk3jBaS28MunaCYhUJdYGcpUogg9GnW8lTwGZz?=
 =?us-ascii?Q?gckeWVupcPJpRhGobmGDtjUcyuB+pDc6JC3Ky9bq+0L0e6+458l20geX19IO?=
 =?us-ascii?Q?YK1R00LYEuxwKgkNaSsWCswSyn/vquN7CX+UiuhXV05eHloF5PstyBg1kT/c?=
 =?us-ascii?Q?U20g73OlAmK/YrAN93ZOsHz8GyphleY4tabTQUDAo7CP6jE6KpY8QUH3mKlq?=
 =?us-ascii?Q?zCkrGYikjqkdPYN6eOQtCfyGeAwyPm4PYn8wS3tUQQ4ZihjPaUvQi5EMbOBX?=
 =?us-ascii?Q?eeVgYmFhmPE8kTdIpLXZJaD1yIQNIenyfSc+DXEsF5cSnrvbaERxc549341y?=
 =?us-ascii?Q?qFwZd7oQsXCcB8VsU9Zr9PmPnQ+xlIj6mugikMR/XvUcVSCpz4pOAyxEEofN?=
 =?us-ascii?Q?Z4IEa8sFRrLNRGMy8ev2s0PL7rNNCq9LpW1/+M8/n9wFnJgWBeN+KlXqTx0O?=
 =?us-ascii?Q?z/dR70V9/KmO4B2AYQtzO7ygf+L+vs1XwMN+KHxbGvHgkJgzGAnn0YZqM1bD?=
 =?us-ascii?Q?eTIy+ZicNR82L3bxO0kCa9iNPFf/b1MR9kCmB9rPq3iYAFucSOFJWMltIEZ+?=
 =?us-ascii?Q?2AVbEiIgNTRWfRkviFjp6PxwKxLXUmK7FvqV9yWMAhu5xmJ+fU8h1JOdPjfc?=
 =?us-ascii?Q?AwiEfoP3MxjJAqrhBLhmCEniiJCMhUZFkOnzcrDF2+9wNwPhDL95UTkv/RO2?=
 =?us-ascii?Q?VyHqFqbxbgFvXj6LS4QY9KxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cb9569-c481-4284-2afa-08d934d7c611
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:39.6911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwfZoseW2c1qko8tOHWpDudIcLNeVlZp80jXNaEvUqb89rqSKWCUFAlEJkAEIi4/
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
