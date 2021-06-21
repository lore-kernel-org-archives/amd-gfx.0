Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA1EC49EA5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD3D60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD3D60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707ED6E235;
	Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B576E21D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5oxxYuO8qBo05Wz/FLmjGc0dXSgqLymstT16VFBxHSG8nbJ8FAEEv63e73pw0qZCzUxngzzDW1Zd3NLWCj2o0+Ak4nzy0+5LgJn91pLdZd3xoCI78bV5+H3Qb7S2QXQ0tmpfmdVmUqisgSrKV2yrweC249QHY00PPt4tIVy97wxeB4YRP0rJVf5ll/3cGMkGIsXSoETLJFQksnJn4VEvMTdlcciHYMVlLdmAEtsbAjQdI1a/DOJtfrmvn/a/jfqNa3MXziKMlub0pmd5zCmwyVTsDXUb3dp0H/sFt6u+/nMu3RbrHbHwLpanJg7+/bGvwSXsb6Sz+b9kG4pFSSjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avweyoaTiPgREd6AhzJcEeskT3LxmdIgjCWDP+Jr130=;
 b=AnSo8dQdmH7F54jAAAShDMJf1sWHi9NzWNYSEpIT0k+sCpiKMtMfn7HqD5vb3mWOWKOWl7m6/3D8ZpkFN3pjyBOQ+6eoGCrjzS8lMI+PLbYo1lsyn7VjWU3BtHVrICAMXNOcBwp/kIztNM0Wsnektn3tEnTY23tYY4cepXlwKOA+63xdhgcWicG4O6QKOS73lR/aKfbVB2jDr93R7tTizD8dPuQborY+v/goOnArYNOE2HVw5xl9RndcnClj2Xvde1Wl1zzOUFCnlCR7TzqLyJ0+st7X/rMvHRuNTK6KdUuJgpIPa0Noqw2pG0BNtPGNjodP3yYQSViGuA4jhd/tjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avweyoaTiPgREd6AhzJcEeskT3LxmdIgjCWDP+Jr130=;
 b=it7prq78+t6ulDdpu3jXFIt/CawtoBzBAhLK/I58RX9yPrqQ+VajoBLF4MtxLtFi2lxEEN3rFGbzyEyHemGzVRL705sUpeZPbG3h6vBTF4P/iLmyGtgItSMdb/yD+l7WEFHgxeBOcnfvXeZCUBpshSoMw99tOy6QsydZiUleGro=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:42 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:42 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/43] drm/amdgpu: i2c subsystem uses 7 bit addresses
Date: Mon, 21 Jun 2021 13:11:46 -0400
Message-Id: <20210621171221.5720-9-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 62d98f54-794f-4ff0-8bd6-08d934d7c67a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38652E28AC67960E02AF4E13990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dogtpZzQan3A4768hPwwjZItYGRwp53l5VQnXOMEd6m9BM7NTYGtU3yOCKU60w8KVcOr7kFHBYzAoTGeZn+BKUA/IjQ139kct47a9GYET6ZF6pitFvn7oSdzUf4INIwvGmO1xK0Byt9GmHoGB+Kxa9KhrQL76IW1XdF72M27zrl47+c60DxbpqyYbTelP8os/VqhqPVZXD9niGqDRq+NRSgDfDZWwe3yVME7VGk/TBqpXV84HdhpMBAnCd8UFa7qYjw+p78bIjFEvaeRtE9XcKi+jeNjfjF4YJbeWGZsIWLd5WwWvDsLw+RStrnp1cSBeovuoNi8htMdNZgdMU4AGBAkF5BmkF96b9SgRwbiZZZLyteicnDq32FhUzW0JnAQu7gMd0aniWX+0DTu/uxwPD75rIvmKrfm+hWnFeTazJKZwjI+DO2FXM9izrQbNVW7OhTrQIjrkEjjjHhZas9FIWMeSCIckszB0/YzPLAM/6NX9qyW09QGTjxqEYiLrQUTJ/QHeGHN4jM5JsavoRsEwYDJY1cWIjx27a0xHRd4B+kfjMrPjuUu5UbGiDp/7MuntEzcV7DfEQbfCTdV7KvN8fZIjeJ50+iNiCb3z6p2QEgNhBcqlF3iDxFQsyWlIEWmLLu3TLehuGTaMgMwICvhlOFO6GhYZhtDNK13PyUaFM8Ws8/PVgDKM7YpSjqp+hw5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m18kio89zq3v9DRCyEqm1d3d5Ha/n7TV2q/BSBlLZfMqOReC6xkE31xnaBiM?=
 =?us-ascii?Q?InbVgxyLhgbaqA3IMbZNBz4X5DBpwlhF7xMbSZoRgBZAr3Z1zyzo7LpDOZNp?=
 =?us-ascii?Q?sxWhoAfKLeshGBFCY0RJL6yojZNFk78P/per6tcGB2R51b7tmtVwCY6coS0g?=
 =?us-ascii?Q?6pWDTPmPLtSZTd4UjcC1FrqEUToWdNw1ZtUlnKQPpuREQ7Cmtw0OutclROxE?=
 =?us-ascii?Q?iX5pzFj2axLeEiLycjqTubqu3RUyrnun6+5rJGq+vhBKj/MDofjFaw+Fmfcs?=
 =?us-ascii?Q?3Rh9W7X+YgdafOkzfiODWYx/ULwyOt2HGTZFKXQa138X/tSaP0HpRobD+bAc?=
 =?us-ascii?Q?T6vf3CgNEJC1SfjDGjmZYkt+lNwMWU9+VP4ZW8+2Ggo2YUEcvMCFkWxNkc/2?=
 =?us-ascii?Q?esZgrVCib1tgB6qKDvaGL1ECCY8//jUpzYawxnPVYVVQ0RsOX+cUJhVPE6Hk?=
 =?us-ascii?Q?PQoabJtTwS0U8i8DdEigjeY8W9YBR2l6HQb0pdo8HOHXi7hUYmWpMd2voiRZ?=
 =?us-ascii?Q?fq5zIZxg+OnW0SkR2tqRoS/uHQIHKT/dW7cLgqOz5boP9280lqJjWUSeXHxW?=
 =?us-ascii?Q?7FhOQ/4WszUga2MQKqz0cNdZzKVEbh3PdcMnGBPTg4wIKCqvG4droZJn0lub?=
 =?us-ascii?Q?Kt5NddyEwGJc3fXfjuMa0N9pQa6E/QqkbrXXCRmCmdSWXFeljwWjvaqMYmiO?=
 =?us-ascii?Q?IVR1WjRuJL8bya/Z5JXgmJaBGn4lOazZvQsKkUL5LEKnQbITonumVSgCYdMw?=
 =?us-ascii?Q?H+iUUQeOMyvfx64T1g6znfXVl5lbYUylhor4i0OPA92UkyNBVL/5WY5lMHPH?=
 =?us-ascii?Q?GYH5m9mE/8tn22zMATwQaKOpAnioUUK+ohiIIr8/KsNi6Z937wTK6bkm6+TW?=
 =?us-ascii?Q?EVK1L5iABCpgUu8GsJGy8iX2KlKAHIV2GV7WOVBrEzkMR/lehD7xgov3jqMb?=
 =?us-ascii?Q?c+Bp7J2iFB7UQx0Q0kMNS53jyAk3vWVSeiUJkzs1sXGNxLaPTeWNlGWoWrmt?=
 =?us-ascii?Q?WhDDo0RslnNpT2mNYvP228ogNtal2WLGQkS1CsCv8YqN+8FDiPqjwI/W4KE2?=
 =?us-ascii?Q?HeJ/kCO2RgQ7Q37VdYyXtO52RQwvv0KeSLrsbZ7R1iEXUlwNOD0Et0e50zBt?=
 =?us-ascii?Q?mPyTQ2N5AND8oof5tQDu2dQlukBek2Wa3Enpf04M19ESSYffyqyVmv2URWjm?=
 =?us-ascii?Q?DoS0tpXw+O3yBn9hPzWYWiXS0V5JwKnOxu40pSERHjjNMg0NkcjdKPIOp2D2?=
 =?us-ascii?Q?ijyc3O97aotU501izMBKLVqjxHCLm5Drkb2qc+Kg138NXdnMLKYEKX+RRgk1?=
 =?us-ascii?Q?hcr73VSNJCbSHTkF3Iu6f78M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d98f54-794f-4ff0-8bd6-08d934d7c67a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:40.2878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swNRoBN/4UBDOjJXx5ioc7fXi1OPLtnMGHAiV35fUygRKcKFdXor7RiwPV0YS/I7
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

Convert from 8 bit to 7 bit.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 224da573ba1b59..2b854bc6ae34bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -29,7 +29,7 @@
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_eeprom.h"
 
-#define I2C_PRODUCT_INFO_ADDR		0xAC
+#define I2C_PRODUCT_INFO_ADDR		0x56
 #define I2C_PRODUCT_INFO_OFFSET		0xC0
 
 static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index e22a0b45f70108..2b981e96ce5b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -28,11 +28,11 @@
 #include "atom.h"
 #include "amdgpu_eeprom.h"
 
-#define EEPROM_I2C_TARGET_ADDR_VEGA20		0xA0
-#define EEPROM_I2C_TARGET_ADDR_ARCTURUS		0xA8
-#define EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342	0xA0
-#define EEPROM_I2C_TARGET_ADDR_SIENNA_CICHLID   0xA0
-#define EEPROM_I2C_TARGET_ADDR_ALDEBARAN        0xA0
+#define EEPROM_I2C_TARGET_ADDR_VEGA20		0x50
+#define EEPROM_I2C_TARGET_ADDR_ARCTURUS		0x54
+#define EEPROM_I2C_TARGET_ADDR_ARCTURUS_D342	0x50
+#define EEPROM_I2C_TARGET_ADDR_SIENNA_CICHLID   0x50
+#define EEPROM_I2C_TARGET_ADDR_ALDEBARAN        0x50	       
 
 /*
  * The 2 macros bellow represent the actual size in bytes that
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
