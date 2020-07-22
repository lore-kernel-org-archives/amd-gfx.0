Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494A5C433E4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E052207CD
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WHq7Tw9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E052207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE7B6E321;
	Wed, 22 Jul 2020 03:14:58 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961966E320
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 03:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU9HQsIOER46v0W19b2eHt3bT9yO8j/sx413xyYSMm0dMcvb5set5DHocxW+gcBiBlCEfFFsh5ss+G9vUkOenEErazhZ7HLHMRT+DR7rB/mFhpMkybS0aa61fC4jse5Ts/cLztfRvgQ4djPsz3ONxEkK9IUyAIRARn+LIoyrlSu2+NqbWinAP/yUZG+BZxFNVZ3slVvDRPGOh+yezvr12qNrJ7gU3ftiYB6IwU1CDvdqMDbEAh6C3UPSHm9FxocP6vXYZAtf5c0k3BLe91iQgXHlXAiqd0wnR8umjxKpw1JpPI2Wdv4ksih35cThaKnyht2BKAz8gbDEkfJCbKj4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJHxgsqIJ1wkHw3wipA9iHZG5sEjXdLab+QrrALsIJE=;
 b=n/FwM0UOPQSvsSXNwWz9I28QyO83SSMb6QLq+gt698T3u1vU3zyfzNr+Ym1O8wpQCkWj1tbXZP6qgRqEqXlFYMJwA18QdtDFTr/+GMp5FMmL3HnCmH13J4BR2aDweS676riw555AyDgYAihAfFfZnJqLkF+ArDOLKaK80WvhqG5UnKZv2jfZfcEBmY9dVc2BScwYv1cMBtJqY3lDWcIs/qpyjA/yZwM2zLsTXMzcq07Ij2C4do/HVpxsuPILYRKwcJ2RcLN6hDTLtf+CfHGGKeLaDXnbnZ8G+2bL3CvZn2Zqy18CoHZPYWq0NXKZBldWz3X2NiJ7D+sT8eGnbOxi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJHxgsqIJ1wkHw3wipA9iHZG5sEjXdLab+QrrALsIJE=;
 b=WHq7Tw9D7U6hxS9SGkQXALsffGrhBlX0hEgPDZmqg61dd6m25EoLY2fL077gjowop+iYL5wBOE1Hmy5bxd3PsPY2pzhEbI82m4XdBq2tSU0YQgcMDrYtAZ6mtECBHIr6m9+/lYorYlKRue28PbZgSXWJ5RmYpcxfGysB+bEP8To=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 03:14:56 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3195.025; Wed, 22 Jul
 2020 03:14:56 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 5/5] drm/amdgpu: calculate actual size instead of hardcode size
Date: Wed, 22 Jul 2020 11:14:15 +0800
Message-Id: <20200722031415.4792-6-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722031415.4792-1-guchun.chen@amd.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Wed, 22 Jul 2020 03:14:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 962510c6-299e-469b-f934-08d82ded68b9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1909AC9EC1D02A749C3ECA20F1790@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Cl+7ZdwlCmJGYIBwEmhC13Tt706XvsU4RFQgensFYZZeOpXTS4NvfMXgOY+wyGzbtTybyyRK2qToIU16MOOeISOylZTjM9T/kGRhAlEmNh6vpvV8L4Yqorm9uOBRDGcG9dRHC2nTjbnrc6VXB77rjSQ9l6Ea3uJeCm1Vs3bIpns/oqoT5iP5dDzxPOz0GQxU4OUKm8Xc9Lehxa72b5D4BxMgzcBUhNdsIFTvcFEVf8ZfIBfKwuZ6tK3iuQbcKwSofLA1ixrPBWlzIqCGJG2AcsOZ03YnyTtXoEE7QcGGdLf2t/As6XWm31eA7TfhK6BnfbVFPnsRZ9NIrhhygAugA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(36756003)(1076003)(52116002)(7696005)(2906002)(66946007)(8936002)(8676002)(6636002)(66556008)(66476007)(5660300002)(26005)(6666004)(6486002)(83380400001)(44832011)(2616005)(86362001)(956004)(4744005)(186003)(498600001)(16526019)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iSOAk2njiMNt3nka46F1Ich3oYwxxv3u1d90R9SZloEGNwJimcdEiaRq2M2dr9Lk1NqI0/yIKESb4OTZPL0Cf+TXGYeBgN+DCT0NDEF+vvka0UiLJb5xyg8GjmJx59iwxBEqOZtCq2S0/OuiSbRQVIH92w2NuMz7G4FKvGRMYznqWp08Qq4f9dkf+ebYLYqmbx86w5LkZz5m6Xl35EVfIYVC830pCWQnIRzcSvX9cFF5gIzyjhhKegSi7PKi+NpmqM7WTZQInLWcyhGA/cDs9jW8des23kLpvDpJ/ONZJjMnMsyturCFEQtATryQFTGiF6r3hPm5JsMs9WWFZkw/mJ3dqOwmfz3MT+FGgR8fr1ajPs1yaW6CkHjAXnNEnCttBQL577XE6rYAkCwd32VryrY0AqCkjIR3veWP811VTEFBbaxvvndyvwulyfM84gxIZ6hw9aKt4xVpKXwc63ai6arKb7K4iLBHWHqS/JFoPbg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962510c6-299e-469b-f934-08d82ded68b9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 03:14:56.5170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q5d6fhBwmYkBVWoO9yA9DZlxPtEauTLdlNvTNT8O2cpevbQisP4RWPDvH2zUPwj/9L/MK6L3I8lDXuFjRBFYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use sizeof to get actual size.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 96b63c026bad..a5da108e43c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -34,11 +34,9 @@
 /*
  * The 2 macros bellow represent the actual size in bytes that
  * those entities occupy in the EEPROM memory.
- * EEPROM_TABLE_RECORD_SIZE is different than sizeof(eeprom_table_record) which
- * uses uint64 to store 6b fields such as retired_page.
  */
-#define EEPROM_TABLE_HEADER_SIZE 20
-#define EEPROM_TABLE_RECORD_SIZE 24
+#define EEPROM_TABLE_HEADER_SIZE (sizeof(struct amdgpu_ras_eeprom_table_header))
+#define EEPROM_TABLE_RECORD_SIZE (sizeof(struct eeprom_table_record))
 
 #define EEPROM_ADDRESS_SIZE 0x2
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
