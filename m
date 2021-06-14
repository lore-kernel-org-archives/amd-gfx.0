Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9869CC48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6799C60E09
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6799C60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0406E0F6;
	Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4DB6E103
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOHQ9eRmfR0Q097zJZskYbMPDt/3itU3cmQbyUcv8fT3zt8RSkGNTtXAnZyVifApGD3czf3k07RjIE/DZyjhSTvGLbBux/HvvvmYutPZvKeQ5LKBmnviRBPU4Pz7AhqdCOim8ntNyL/1Keb7TRcr9P81Skv9GTxgr5EViXwAsK96m1Ec6fsMQ2Wwu08yJJM1JgfUZYgNxwPJcqfR9tFvaDW2v1lD0dXU0DEvAMLhff/vTP/A6xDQ4psM3TOHpt5LPTRLuTonz6eLofNioiB7p+/hkhzJfrZMAt7O+jwrUJR6naq+hcXGLzH7wW3rxt2c0ItFsbnoQi+HiL46OxOkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avweyoaTiPgREd6AhzJcEeskT3LxmdIgjCWDP+Jr130=;
 b=PI8PB80UHQvEmXwM9HGHES8oKV74iQ/KghusiuBA6X1XiZj5oTtlGqEQ91EKIFJLl/C4Mj4MtK3T9IR4M/tmcgsGJ7gxbX7ZG34+Oh5CCfCdkYvXvlo+mcXH5kbch4YmB2pBSgTC59uv6WMlQFt+nTjwIEaKmEEO+DUSmkPa+t0P7Kd+Jx+kfsHl2gG61IzcktQFiLGyoSJRQwfLyhqNRWFbokUmDl/qf8clH8jtqj6Xtl6cFHxxQRolM6QTcfEu2LUcIlbHMGmPUmLnlUqL72LS300aQJOg7ZLaJs7E9Mo2RrmLkxr9AjutADZ4ID4V+aryuynLhFG+pFrM4GAzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avweyoaTiPgREd6AhzJcEeskT3LxmdIgjCWDP+Jr130=;
 b=L8f7aHpMypocKo44c5DBk4NUS/fZtgDcXFNhj9GhuwXptQUFB2Bi6xaDNrhaE/a98giz8GVe6KPGURLqInwB7gexTfSBWEGL8id3jpy+bI6VBUrJK9T9J3kcJbhF2LN/gqTeOSg6yrmaJcbLn3E5vUtehyqdjJLIVPkR/HaIbO4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:53 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:53 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/40] drm/amdgpu: i2c subsystem uses 7 bit addresses
Date: Mon, 14 Jun 2021 13:46:00 -0400
Message-Id: <20210614174632.20818-9-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8252190e-ca81-4961-9581-08d92f5c6513
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748EA940F66BAD32D30AB6E99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COG5a5dpsdfD1FhojrhSWA3T0Nz1kORL8/a7lTeNl/Np/QIIsuQcgEwlz50KXPRNr0aDdWDJAl9qvfozyx2NV/rvWNfYOeLuZTNCSp1U87RxxBK1qTmQ3IeEdv5EzznlmoyPhzZsrZQlaZ50sCw0Q0hg/vQgDj/DCyoWFUQE15z5LDcjEK9/HXP2Ysor6IYHmTaAGsnX1tuGzvNOyB/AfGNxb9xJ2jNKh1s5rJiqA4BiAAD1dJ5wuNM4szV8ftjvl0WERduZFyfbXQS3OCUpUGo/Zf61GNHEpf3sQXedMdL3K2Oao2gd9ZsnQP04orDYiwDZ1PbQ7clihoE+cgcWiDX4fCXMWtR9Io2RYfqU/5nZIFWOuPEx9CI5sjhRbluiYeBZni/soktnsnRO0NtNq8XS+luro77ZOz2H+jVjlUd/VDBCDar7FItb7upQpCNXKVkwxOzp3GTq0e9RA8q2CvNhZvRBOb/Z9jlt/Q+546kZ6kVkEht6ZoNJlZRWGMLj8/VbrLsVN0nyGvMUjfWsEhRdeDORoGP+4gjkugMOkcki0o8I6npzXdoS7Q2Fxq7QekCyYiabJkF47Vw8dO5mNSykg83a8Aohl5VS+jYsLxTUGb/ZULe0iG/lr6W8PeWDxBDutt0ulf/X4E17t5rJw/GdGUw1pnTrEofuA7LoGAzWRTmDvzt7SItGR/BuYLvt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qD6ujdAp5MH+wk2i7TOp0JfMni68We6Yh2Z7QpK/hBAla1mCf3i510LjyZfI?=
 =?us-ascii?Q?rJCaLq0N331GgwOxHN1zUgN9sLDiGcicV0NHGe9PYQzjnzxf8/uR8cuJpJcw?=
 =?us-ascii?Q?0ZbqPppHk8gtS4n+jjpZDIKGp6jAUjhtsFyNGUom8ivEgiP6ZR/bbhi4dJuG?=
 =?us-ascii?Q?GyS11Ks33bvvCFk7ysfN8QqRF1YVrtLrqRGol1YpXsqBlNbbC9QnjwzZTtRJ?=
 =?us-ascii?Q?p9jbKmjaZa9PRBsVceZ4ShEdRovPLxHyPrODWUm5DbPtKNO/UXcnw8BDgN2J?=
 =?us-ascii?Q?9/u5eEl6e+XGDMVzYbCvvx9bB8umw/d5y5i45V3fI+H+yVKvL2LLLEpL4ohd?=
 =?us-ascii?Q?UQAEXpbL9rKIegPFm826idkG1vk/b5mkGQijBBHli5xlant98SftXW+VYxtK?=
 =?us-ascii?Q?m17kWZTe+cGYWfRb4L/3R3eH/PfAvrPHt8JcKXAH9KswDH6v5iN1Dd8s2ptP?=
 =?us-ascii?Q?zH5y/dTsBOCWY6W3k8w2LKKOig7BKKjqYHtkRSI4rri6E7aktWWTg0mv34y2?=
 =?us-ascii?Q?btqAIZqn5napTaklCHwYOQd2BJImGALVeLx1Pake7Yz/DjEML8iZvNe1SIsS?=
 =?us-ascii?Q?6xVGGQbDEr20yQ7r+gpS1LhAOIKVr9gAZ27KcVg62i1liWawAEt+fhCMig8Z?=
 =?us-ascii?Q?rpPHv1KvaPvgjw6qyoLvsHlM3Cynm/TawwrLrir/xRnM9Qh+ec5eURInITJ+?=
 =?us-ascii?Q?92xjoeW0yt8gRcK6C1VtomZKX5KWeXIDnd7mgoQnxTykibtD4UZ0X+gshWJ7?=
 =?us-ascii?Q?OY0WLRSL+Yh8nLHAFFVW/C+8PQL54FmMlHcU9+7UK01HzpvYjrQa9HTjfu+E?=
 =?us-ascii?Q?ipA9Oskeei9Ii7/piAlU1bv2MO2qnE/uNG2QVVX1Cw7Q2st6fa+3J7kbnp20?=
 =?us-ascii?Q?wAtU6hPVCYUv8+AKgDHJLgpUqWBj6yycXx1QCWs5twNc+4CN9robKE+y0n4g?=
 =?us-ascii?Q?XnfXhmy4YM6mXDLJDEP0ePEJhdKqroeP4YLDCPsHBl+JEP0O+SHc1kmIAa5U?=
 =?us-ascii?Q?kH3HeVtniW9Z/yTQoq9eJg7TQztveSyE3si4CrwxIwH1HJLwEzUl2sSW7mBQ?=
 =?us-ascii?Q?E08irqdWSPYCastY1EunqWqA7+XRGJpDKAiOuNWqAJmAlwyTGSCHAnqESSNp?=
 =?us-ascii?Q?R38M36lSb4rXvjsn+cIo6s55V2iNSVH8azEl3C9pU1vCq4G2dFjipagXTTa6?=
 =?us-ascii?Q?fkmPhTq91DC65udTDN/uWwkLaVk/zvxT+78tQu+w+1dR46N4folX7SJFnUze?=
 =?us-ascii?Q?+XXk1lZW/eLr8ldZx/mLiHby6F7RNB5j9Ewz8/LRNcS0eOlgVXCumue5l954?=
 =?us-ascii?Q?Hbp6ZsHlnWRG3riXVmMfF7cs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8252190e-ca81-4961-9581-08d92f5c6513
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:53.0174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaYD5mCo7+zA8Gjj3ig1HUWQYy1jSviOuMDV7/kRVcrBioi5v6sdvcTcD3mQRbMA
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
