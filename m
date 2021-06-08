Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1053FC4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA50610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA50610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FC76E5CD;
	Tue,  8 Jun 2021 21:40:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2626E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO5tyjkEkHdVvUeS7D9dTuK+9wjr7mchdVgRV7b0pWT/imMl++jQDfOKxnhbrIt/yCRVcZRjq2ga7yHzWZXS8hzELxE7e38SxdAjZIHU9EGG1J/kqf1lSqmwlrnR7Ugt0fJcsilJQSsGNnDW5InokKUBvt9F2MozbeGn1dlfWDEvnaNMudtGwVWQrbbn0c6nxXjnUkb+kdPYwycSQ8xuctv2k6CmPboOike1N6UIQBDg6oqQJwIqLGA0CSKdsptKHdg8LtdzC2NdofB8Uwp4LfRXJPl5xYFTWjoPwI3idS+4vAEIZKqdkzxnMuAPD6Ra3vw6C7LrkrRBHU6AczWD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avweyoaTiPgREd6AhzJcEeskT3LxmdIgjCWDP+Jr130=;
 b=E8UHJ3VtrGXxS9IJv2NTR89XH75LIxxkIRBWV23KUZv//8yaNd632mu0oDVG0SDkyJSsa28r7TzPwfwjaN30taxwmafAxR+X5dnlekM1DOoLukKfSH8igKnIriAOy0erGW9Ln3DzMRX6AXhg3tQyghFVMCUn8MIX1saQEizJEc0DufUfptppRkBHHdBXih/dfFlAZ53M6/3g/g1EaU8AESvXOFVPIf+1a5F+UVyd84/QeP5sfi/aC3l/NSgufj0IEzIGDaYn96zeVyv4wJT8qxPEY6lx1OZ5TkhWh0mW7SGEJDt34aWOHzIxGStOdWpl5L2NzS249aTSCDKiT37APA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avweyoaTiPgREd6AhzJcEeskT3LxmdIgjCWDP+Jr130=;
 b=4iKS1f5Bb79gU/QYjDfNaTpDIN6m0lN3yK8wEbIkqRt4mWFNsDWDIE3LWQEmav0L6dUC+H1GYQ37a/ZS0d1ksas9XdS0PdN2Lm+9FeVxmXJ2VnQfl0Eh04L2eEjEI5jNKtIvDKFZ03vQlWqehUIpB/Xp26I3+bIiqZCQ8W7amek=
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
Subject: [PATCH 08/40] drm/amdgpu: i2c subsystem uses 7 bit addresses
Date: Tue,  8 Jun 2021 17:39:22 -0400
Message-Id: <20210608213954.5517-9-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d8f37f-3bf3-4669-69e9-08d92ac602b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435561D53F635783B0CBC10D99379@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlbA88Q1OefxbU11NP94PJn/l+/X0lqJuj56ADTLa7Xb0gEYppno1OEbX8ACh6YWPhUfO8whjWGsxga4HI1WYEGBPpHq5LUFmzeKR8EC+/Er8CEsCVEzHDmyit6qo+orv9Ol237oAQ2VDTfQlMY3dbWU3bYlxXJvgrv7kxY40zYcI0kBoHRPahjBMcqyR9RC4AyKDc2yS13+awj9LD+BfPkvnUzoRc3TS30cmdsEP2N9UlRNglj1oNUI7Q2wKuwIlknX3ecgGh1gOAKD8QM6QzR0YpqPsMemdcV6s+/9EiECNRJOApFVCYqFFLuWxmWK+5AyInP81HWAfLEhV4o+XF197W+g0DwBnysqweIhVFSOaXzzkU2KNKxL4y3UikvsR+HpsqiCSDuCVy2GVJFI2V8XsBnzGRNkuari8R9n8l91mwfJ3aQDPCjbYsnCxG22eJvTEdGACK1pO1Iupe+LJrycsfAaDPkpc/9xeNPDsoyJSh/1qb2qetuEspCS3l3cPuyUgxE8v8D8g4QrmJsQua2MJF0P9KIc8kbJtai2DPT0jXm5N9dsRTwLjbrMBD0zv08W6TY9U5+Hlh9BhS9LKUMPYSKjsqAm1GpUF9B5lApeAQ0L8RsfF+FuB42fSqFw6UYugAiojq/ZPt0cH7yZ8zTRyyg+rX+hPgA5EpiA50XgjY0hbMaK1qC1oCoTsYzM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(44832011)(6512007)(66556008)(66476007)(5660300002)(38100700002)(956004)(38350700002)(6506007)(478600001)(66946007)(8936002)(36756003)(55236004)(2906002)(16526019)(6916009)(186003)(54906003)(86362001)(316002)(6666004)(6486002)(83380400001)(4326008)(26005)(8676002)(2616005)(52116002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D53C3J7udI9Dn3UlugHFsWDz3s+W1lGcDXkCiILZrZu/crX5e9XdYOFWi5sg?=
 =?us-ascii?Q?sD0fAEEKW3CGbS6zd9iX/eu+BA6VMNclBPTepXxSQW5Qfaii7WlJE03gNdjp?=
 =?us-ascii?Q?3bcWfHEvnO3DJFl2pehpBOfLxV6ivPjqHDbhbeaz4/dAxhJLHryx3KMjad7D?=
 =?us-ascii?Q?WYr3fhlgTYPvwGp+GO4yfuMhLuuAsO9RVJ45u9mI500KtWHnmSL1tx5cgB4J?=
 =?us-ascii?Q?DUnVdrWH59VnAFlj9JqDpA/N9gJ2m+TFb5VfN/R7IwVvpPJ79aGVY3xmlROO?=
 =?us-ascii?Q?IYBKtAA632xrlpg1XjMaA34sPDCf2+umyfIl6gupnaLeKiC2dal9KpKqFsis?=
 =?us-ascii?Q?HqPtz+Qk42VXOvOvw67UF7pnOz6urc8q3nAUMOQU4bUfe9p9/rmWlTq7r6bc?=
 =?us-ascii?Q?qy9i9VR9MRkrjeFqg1DqySvL03BpqH8dqMgpQ9WZNHBS6VOFEBN9BxnV0awB?=
 =?us-ascii?Q?1Tgk8/9mIwof5liOpuTj3rRmkZk56POjHv8gwLRYXz1hJJXpq26RXSOaaGlP?=
 =?us-ascii?Q?iirFqRM95wYLkFMqs0JLfAQrkPiBSQs5wUf2sXHnWrAINA02wNbhx9HznZs9?=
 =?us-ascii?Q?IwG7WV5b+8Ih0OU2DeZkZYdDseQZ8VVxZju+e4ijNDE7VA8+Wn5jLr/vDebj?=
 =?us-ascii?Q?fhWBQloig7P3W+dah6zumKfahoYW1zP2mhlEx5g3ChK+CvcTpsnFcXx4lFXm?=
 =?us-ascii?Q?99U9k2prpOGKm9fX13M4ocZXfV3F1ycYxNmmp4Jy0KaSELHzqU2FrQmP7bQl?=
 =?us-ascii?Q?RtnGCvoyf7e2447p7P4YBTtz6bMc5JxH3IqVGag1oUZDrqx7HzoHRAJ4FV66?=
 =?us-ascii?Q?C9NiqJuEMSzJRTnzqYJCw0BLURGxSexA+AW5hGg6qeh5M973hX6FjCDrEBJg?=
 =?us-ascii?Q?RcSxN+oTt+ldAPY48/UtTDjUHckt6PmJsTEAp6fqGl5FX74Zv2CdjZ7RPBD0?=
 =?us-ascii?Q?oOw0J62Ed7nSIMNF0DsnHIq9Iifi1Nd7ewjoJcZPB0ZSA32aujDNIMszs8ZH?=
 =?us-ascii?Q?KlkvnLS4UU+r/TmAWCytvQcMtPwrS5IRxvEjQERwcFBNd9DeM1SbeR21n+9v?=
 =?us-ascii?Q?afTg9YgC6GSiog/SH8VT0axrs168WJA47K4s3x6ZhHUtsb+Yb/oVddL2EXQG?=
 =?us-ascii?Q?53PNyzD38Z5kbWfpfThfx/GP0GXEFMckwezJpsJ3GVBcnoYbbcBMEIWOu8iq?=
 =?us-ascii?Q?dBLwS1Z2oFf+AefjbK+HKie+1tTtnbiF6BavprR3PfQz3UCBNOJ2fwaZS4M0?=
 =?us-ascii?Q?mdbWJtAvMxY7QRxRYZU1OhHOGFo63BmKGaOXHvHtNhR/Z3mZ9Xw1fMQyuph3?=
 =?us-ascii?Q?BpJ2tfu4m7F3BzdUOct7o5c2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d8f37f-3bf3-4669-69e9-08d92ac602b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:18.7872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwoIP4YUOc5UlZ/55esQe9XxOo/FC70CR626MhVA8GN76htXpymL47aV9LQaZDCv
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
