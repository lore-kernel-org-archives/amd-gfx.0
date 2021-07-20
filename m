Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B8C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 16:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D066960C41
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 16:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D066960C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C346E461;
	Tue, 20 Jul 2021 16:18:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13046E461
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 16:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MILWAy6IGjrMefwrMGxc8rxWdlFlvSZkdUePBLHQstucbDEJ7ugs1JbgdhauNVkTwxoNMkVugoghtrB5YydLz2+j79zuEf3nV4cVRhFJ/6phfTtbl4w2kAmNhIP6CO4mx0AQSx9EbZS4EVi6smxCWocGEqeffAPRFOZR4G/sGlw9ovaYFT5HBSVfc9reOa4McZFxXHpbtg2bx3bkMEqgfj6NzY6MNzOjcid3eu1qU/FiUS+D0fAjMF2PfUc36v/OFC4Jm64vD4mK+KUD//AcwnK1pERjCKAB/pYWSYjpWKXxRvIWLyr6TbG3f5sKseBXtj4MOuCnoSWGG31gvrxDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu0FIrXgGPRUD9WLJkOdcqbTg9/p9PVor2+4Jz79+MI=;
 b=nPsRErSHji66vN/iq5yQALjIdY46+zxXiLPL1NZCZX2+2ylmBfCWwb6AudbwdHZPKDfl/3qBPpgWLWLQYZi6wOuQ3G+D40hhra1hvmGlMrQYl3x4CLrR7mLeL1RJADSj+tHr7JRYrnoVQTCerJTdwDyR+PXIBaaV4oDNdXW5XPEw82ORCkqDnECeeV6QbfEklJ5HK7vyfjrPYCL+YL10Z4VHNWST46doWuQGyjFVXk8VXbzfhHpcAA/72+yQF0A43ZKC9fyX39f3q9ZIK9T2Up3Y9HTrPtDdSQ4hsMO9zC13MfUIJkiQw9BGyT9kfVczOfxnRB3enaxRJ6y12ZYnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu0FIrXgGPRUD9WLJkOdcqbTg9/p9PVor2+4Jz79+MI=;
 b=Api/uywZHV6/jkPJLL/QXUQy1svaNTgnYjRoP2mIifCjXyQ5l8vQxs7ss4EIBJHEgF9B8W+fCm/bEm0nIWCBOVU9rKtYwjP/GprSy/+mf+0DAnH2r4JJsWObcRyiWtJ3scbVSF0ZN3ThsPQgUO4i/X0MisX7OfKa58hBPP5YR1Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 16:18:10 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 16:18:10 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: Add information about SMU11 firmware version
Date: Tue, 20 Jul 2021 11:18:07 -0500
Message-Id: <20210720161808.18690-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.77.11) by
 SN4PR0701CA0008.namprd07.prod.outlook.com (2603:10b6:803:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 16:18:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52671664-0225-4ba7-6aef-08d94b99f736
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44326673B003B6F6E14835B2E2E29@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ti6FyDfm1PBi1UKRlWvPPafB2biEYix7mAQOtkymZujMK7M0z6L+YoFY6caF6RGUFE3k4jsEKNir8ADtEP51xLvRYeCG2rQc34tkBOBRyly/mV8bydx5AzQtNi3sqMKaAziFatxS9rue5vYIozXIUD4dlczGBqtXRCL82KMSzZFH10hJtqTgf8FXUyP1SPk9tA4fAD5qDHUJBHgPhUdiALQIswQuPTf/qHm2QOvgcJoX8eXBVbRGJks44gEdAYYbuxXOe5p7KCJ1rMZInnsr3+XpJrzE6SFY5wsRW5CwwNRgySszjP5U4QigzcQI/5z3cGtgMTZd3MaS71qFAqaE3lmgxpaMJgLekivWGxQIQwJMF+02aAT/3SlGgdwJCE7Gx6z6Pm2if06i94y0yJOSPMWYeHKo50Rk0v7KLjaNSige+GBsImF9MWVFT/zJ8WnN1Mxe2o5uA2QbsLkkIBdEmqhC4dlBxpKKybfSUtdlgnXA13/nww9/dbsJNcEdrqMx/D6ew3s9jqud5Hp9OnlemBu2nJl+VdpxB17rEM8P7YX+MKkfjp1Ksz7u6nw+Om8+nVd6KjwhGT5ohZhy7FvTHUroFOAxCia4J7AtM1QOddxDGS783e+OcXBIuPRNdicKpg2RznWZX3B0b9qLPAKUZJkYmPgTfjMF38G3rzVAbsep+lUIKjqUa2EgQlMxlrRMoGoP9PVnYzD6f/aJ4yG26Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(186003)(38350700002)(66946007)(6486002)(1076003)(7696005)(6916009)(36756003)(316002)(4326008)(86362001)(66476007)(478600001)(38100700002)(5660300002)(44832011)(26005)(66556008)(4744005)(2906002)(8936002)(8676002)(2616005)(956004)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTFNHDi4/aN0CE00ZUHkVUXIayjU7+IeFtq3rArKhZnsX1a8+c0HUglyLxmV?=
 =?us-ascii?Q?epN9pqb/7muKL0vqzPYlAxnnDqGiAC04+eIIx0P6AviAd8uAAl9ibs4hP0O9?=
 =?us-ascii?Q?jncXZk1DNj2njzgMO0MVzXl3upI6pGFYLADfdgCW+JqvdD6LiCw5n/XXwpGD?=
 =?us-ascii?Q?OkwcCVzYfCCgch1dBdGthctRNjT3wa/JKqUmqNiUujXldlnN8TfNqGsZwubI?=
 =?us-ascii?Q?PxyLpsElUTvEniaV4/tfLqx49UfefrEmKpR0myY1LdVqMR0jBUJ137+9KNT9?=
 =?us-ascii?Q?rxMiKyuUkjjkNGjJDBFe/HS3U5nXMH+N7BrV2dpw9qrMI3hZgaocuqo71hrI?=
 =?us-ascii?Q?tRDOw69IYtn+BEe7xw3Arzp5y1yydXDK0gkMmaQwPaFPmyD19T04YA5Iqygn?=
 =?us-ascii?Q?xMDRySgjwHikreWu63yi+4iT35e+F6SnquRNi/dB8fL9t9Yr5bhcowPIyheu?=
 =?us-ascii?Q?twALI12ZojFjlMIMx2MwmDDqTC7kHmMly2z6/N7ZRBBLKetdqNRMCxHCXeMp?=
 =?us-ascii?Q?2A9XQnGKbUjVIb+alvs1pFFAYbn6gr3s5pLlL+zhLKfT95cJ5eWAmKZVQ/xG?=
 =?us-ascii?Q?qQzXk31pAeqssn3yFKZHpMJcU1VUghx1bG0J7RAu8bK7a2GEzHxMCYa1hvSh?=
 =?us-ascii?Q?KT1A73mxp3TAsHeOThzTmH1nAu27wcEcFRbazDpJ8JKfldjsXOxsPS3MPlte?=
 =?us-ascii?Q?QquCv91E3N07EOkHMr7DSRdpHvGUQbPCRHlMicM6Bh5yd0Gm7KwNKuCEQCot?=
 =?us-ascii?Q?oxSGRbFI4MeYwgms8QwUzTj9ac+2zJXCkXg5h4AGWdZ6aX/xSTLb3C0vbxWm?=
 =?us-ascii?Q?2vMI21DAcPAMg0nX40O/WutJsinqth/8pSkYsXT/osUny9sKYDf24c9z/Sjf?=
 =?us-ascii?Q?B4mGZh7mFeuEvF5V+Gm7ysWAJzxwqtBfEkHE+C2OefiWjpKxuRx3HskG8CtU?=
 =?us-ascii?Q?fKjdQ0uNhdJKeafk6gZBceuFUS+aIo7aTnwtNZvgEWowZm2NVCiYmzRyMoUR?=
 =?us-ascii?Q?Z0GYZT3Or8tLUxQ1l4bdKL8QZ16VqC9nU3r5NHqW62ZnuWe1Xv+6BjHsVVU9?=
 =?us-ascii?Q?zSWjF6XPFEQMDw4fG7LZOcwIG7oJ+2mWkD7ao9KBa/xGr0SM0m5f9UibT1Us?=
 =?us-ascii?Q?2dRSglKLIJQ3vhkOVF9Up3a+oMqn9X2xIXgPFRyJhylmYmp5tzDjAw5q7UUG?=
 =?us-ascii?Q?WEA9yAtLOtGDdZjpeHYH88HLWvVRmBAXfYjvoFXMm68uZqycvO5PJms3aJsA?=
 =?us-ascii?Q?aSbqe9tXdm60IQmkRJbCP9wDMc8I3EYhENElttpkGtTwLIvw8KXn8Jegr2FF?=
 =?us-ascii?Q?qaTnmQFtJWzuw8c/uowApFRY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52671664-0225-4ba7-6aef-08d94b99f736
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 16:18:10.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nGqmgKtoJeDWmgbR09SyAhWVXAd5tFB87LEquatkPaeLUozmUE7ip2QIPCfvrnFoGFIap3mcusx2Vozw18iLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This information is useful for root causing issues with S0ix.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 0a5d46ac9ccd..626d7c2bdf66 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -272,6 +272,9 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 		break;
 	}
 
+	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
+			 smu_version, smu_major, smu_minor, smu_debug);
+
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
 	 * to be backward compatible.
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
