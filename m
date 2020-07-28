Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD3DC433F4
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A1120714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1QqMTy2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A1120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A896E21D;
	Tue, 28 Jul 2020 07:50:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956596E219
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRELOUA87coTb+uqbOgi1pQ5cAQdTwOlDXiJquAOvllMq58cgYCwfNuySRtz8L3r7Fcx4LjVJxE15NlqlhJNpBzThco43YwoiaojmN5TyED+DUhL35oUUlCsI0nWplJeOlh3hiBnVyX3EvhY0rIUBmft6ICtMKNbeRRFRoFBF/jz85rDL5C/YWs8CaLXe3EW6pA+3cMALqahoVAnKcJH08htlKJ38jBpt7EkBedbNTSqmA6oJAXsAfpibh7f9yqqwapoMgQmAys226kmCINgaF+VzJ0Q84vwP9yATS3SKb0kPaM9qz+Dso4b3tFg4hnZIvDwLfecr3yog6WFf0Aw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84xX7YtHIxWEXoqHKPAPSRPTV5Ru0/EvyIwIl/vQxDY=;
 b=RrAGgrv7nbXa6H3BHrpbY//dcQ+plpVetpqTwEyAS9zr9vn1OciqX7Gzeof4lOC8kqLkz5k9Z7AmcaWKMnmiZ701Da0yzi5UUVs/YfjDQ0KKw6FxPE8VTnhyloOC5XrKxLgcW262bCIbkKqabbFqtdEMCEMAq7FY14QIBsV8pV9ZvW5F/xy8JINF8bcOeqNGU2nL4gcsx3RcvIA8CedvZzIEYxLw4dPNai33Fj4617Rf1wVE6AkYyiT0CQMCB25tUTrZVU9z1zxe9xSWqWqnbpC8pw9HApQrCKJZeZJMHNwfFJaDD8zsOJCj0Oiy62/8PfFI1l0BgQ9nU4lChEPSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84xX7YtHIxWEXoqHKPAPSRPTV5Ru0/EvyIwIl/vQxDY=;
 b=1QqMTy2g/w841jwAQvJrmWFG8A/2LADH5zJNv9q/+sshKes8aOe+B+s13KZO32JBZ1DmukAwqGp7xYtQv4pMDcfJjdsp1qSz61z/AV3dtZwAB6NaR5u6hkqHZwn/NZLMuHuDHtG5YtNM1ptoC9uq71BeMpzE+foBjTpdMe0HCEU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:11 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:11 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 05/12] drm/amdgpu: skip bad page reservation once issuing from
 eeprom write
Date: Tue, 28 Jul 2020 15:49:27 +0800
Message-Id: <20200728074934.12490-6-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074934.12490-1-guchun.chen@amd.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 525683c6-ed9a-4889-3ffa-08d832cadb12
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB175219E53108CD65A36482BDF1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sP3YrAwjsWhfvtUFcYRsKjCVVOsL4Hmpdkm4PlQ3a1FVjX1HB+JIfQAazKe4IbbDo/NEHyEagoEw8r0v2tXW+detezZNQTwec8/Uc88bdfv26Vg9fCgM2JGwUicyODhoLx49A7uYz8hdZ+FNCdAVT8oXqUbT9giUE3cQoAVdeeQGUq81FKArIDHvIYOYIfJ8c+cQzeLxKR4OosTsSOker0PNTMIK3oCJqIAnxovwpFrvKQnuvBl3jRuoNnvQO+CYOhvCx8VKjf6cz3qOOFJejDZUSHGKaGpZs2BwPyZxyYrknRrWq4+yQKfmEnAITgzABg1+8QpBF9Aot30blvpJLxg1deGEM7LloR4LpxFsSNdCApZOXEAa8NzFHa63meZK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 27lMrIq2wveFbGNt2ePhhKFtGLscH+TadMBrGU0mx9EEF/xPoPuGkbmnKxatsvUHPKZPkyStLvl2CPcf9rKN1OOtw/2QngqfrST+DeepMeFJnulEqAMs7ZDzRvRHmvFN0VjmfbHk2D4wKl0Z4r30QQVNd83dLU8L2Tk6Bo/PJ32SQb/TQ9KQvys/DVa11IJQXpSiaeoAR95pnc2emm+aszkvVcbmL/pG9IDERvuXNbR2KGouUlSHg/auohdnE/xXJm+sekesjRDmqDM8GXERnc2EdOmaY21t5COdOs/vD1/NpCvxZcFVYQLLYE0U4DJEmQN0yEU7NZAy2Yy5Bzqc+1qfsd2Y0Ktf8Djbu44JcoF09yzVdcgDKaUGP0AB9UzHmyskdXZKotxQ223R9CJLEjEdhYoNoz1O+b7aJPOnvNomSUeOvVYVYluM1waiikSM4NZpTOW2EEDhFxrRRRWGHU2HXTH8OS/n8D8PyTT4YYND4N6CGSW9qvXXzqdxWjVY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525683c6-ed9a-4889-3ffa-08d832cadb12
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:11.5023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvbee3pefaUlioQFfpotxhdLEQDrKIEB7W1Yyxn2CF3h8KvWAV9Ph1ayFjmUa1DN40MW6/7SWrm5JXwXRA9haQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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

Once the ras recovery is issued from eeprom write itself,
bad page reservation should be ignored, otherwise, recursive
calling of writting to eeprom would happen.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 14 +++++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 56e1aeba2d64..3c4b9127660d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -62,8 +62,6 @@ const char *ras_block_string[] = {
 #define ras_err_str(i) (ras_error_string[ffs(i)])
 #define ras_block_str(i) (ras_block_string[i])
 
-#define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		1
-#define AMDGPU_RAS_FLAG_INIT_NEED_RESET		2
 #define RAS_DEFAULT_FLAGS (AMDGPU_RAS_FLAG_INIT_BY_VBIOS)
 
 /* inject address is 52 bits */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 4672649a9293..cf9f60202334 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -31,6 +31,10 @@
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 
+#define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
+#define AMDGPU_RAS_FLAG_INIT_NEED_RESET		(0x1 << 1)
+#define AMDGPU_RAS_FLAG_SKIP_BAD_PAGE_RESV	(0x1 << 2)
+
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
 	AMDGPU_RAS_BLOCK__SDMA,
@@ -503,10 +507,14 @@ static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	/* save bad page to eeprom before gpu reset,
-	 * i2c may be unstable in gpu reset
+	/*
+	 * Save bad page to eeprom before gpu reset, i2c may be unstable
+	 * in gpu reset.
+	 *
+	 * Also, exclude the case when ras recovery issuer is
+	 * eeprom page write itself.
 	 */
-	if (in_task())
+	if (!(ras->flags & AMDGPU_RAS_FLAG_SKIP_BAD_PAGE_RESV) && in_task())
 		amdgpu_ras_reserve_bad_pages(adev);
 
 	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
