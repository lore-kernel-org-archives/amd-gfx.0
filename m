Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D112C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 09:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5842063A
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 09:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UezV6rpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5842063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C0D6EA25;
	Thu,  2 Apr 2020 09:15:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2506EA25
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 09:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC1Pxoje+StP2ni73v0xrV5dQizUAD8Lh/BBR2ajLQaStZ96UpIfYBrTHil97piqePWLXPfnQmOmLhhLzYMXs0RV2NBdzV+Uxv8NWzNnfMzsKUiE+iu2vuS8GQ9oATNMQeU331yMtV9pTCoxI8qNyYDKYm6VIgCXpA1SPrvjT3a7w1/YlmJdy301TDBiccl5JiIu3GpSLOdCsFg39ZhF/X75sp25cHReqlV0zdZtoJKhk3L3fAx4vsVPgjywElKNZAzCN4/q9ek6tYA7S6iSPWYG4rYJUdQzJ6v8aNGlS2R4BeZteOy4qwS9lApGzjoYNlCugPBRSY/ziQt1KXx/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZyuK93Pf0U3rW4BMVK5580bjAwhzw5UxfypN4MrDl0=;
 b=GoYdux6EsYZm7OaHP8ohu1FegbHLpTC40zYZhfW0HmzHUyt53E7G1snnvZpcsmX+OeF43PALok0OortBxlqbpBSalCSeILscFRBMXDhSz1HFAqafkW58aFls/O0j861Ua7KIjkCYM5Vxxi8vRKfZBeTP22hJSAM8bH7nmuLMJP/9B0VFoSopKWGidOhUv+tv2rVZw4ODMlR9YDwolsjgkQsJ48+4pOYd4I1wpTQo41JIkV9yl9kU59sR9fml9WNH+yO2e//9QsD4JmrCGpUFyTBPnHXDsOAALJkyCyQlhaZNq1L18TxOM1XwFocMBuU+67I+qQHQh7Ct+Tbqvm9LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZyuK93Pf0U3rW4BMVK5580bjAwhzw5UxfypN4MrDl0=;
 b=UezV6rpzggByXC80u5CDX4mb0gi8uYAwvXdZQrekS83myPT+Q6jMzzfjlLZFroevRPMSfugU9COlVWvYreD6rNEDf+75qMqpICxXE25/lhBVfIiYIMgM/3dXFsVi0TBxo+ZPaMrFMdVWzoxVcm+3wIDurHbW4H5RqspBTMw8lKc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
Received: from CH2PR12MB3941.namprd12.prod.outlook.com (2603:10b6:610:28::14)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 2 Apr
 2020 09:15:37 +0000
Received: from CH2PR12MB3941.namprd12.prod.outlook.com
 ([fe80::98e6:cf91:dc50:625e]) by CH2PR12MB3941.namprd12.prod.outlook.com
 ([fe80::98e6:cf91:dc50:625e%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 09:15:37 +0000
From: Shirish S <shirish.s@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: re-order asic declarations
Date: Thu,  2 Apr 2020 14:45:15 +0530
Message-Id: <20200402091515.121824-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: MA1PR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::23) To CH2PR12MB3941.namprd12.prod.outlook.com
 (2603:10b6:610:28::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amd-WhiteHaven.amd.com (165.204.156.251) by
 MA1PR0101CA0061.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 09:15:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3f97e03-e1a5-4acf-8783-08d7d6e667ff
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:|CH2PR12MB4262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4262CA184F16B7469E0D6FB2F2C60@CH2PR12MB4262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(52116002)(7696005)(5660300002)(6666004)(81166006)(8936002)(8676002)(6636002)(2906002)(86362001)(110136005)(36756003)(316002)(4326008)(66556008)(66946007)(6486002)(956004)(66476007)(2616005)(1076003)(81156014)(478600001)(26005)(16526019)(186003)(169823001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sv+NkhiTNA+un8Kzcsyayj+zCCXqk1gClKsRWA19chSuwk47o64M6z3SqO3pJHsbfUR46+uN/cQfon6Evd1FMN84GG20DumqyMVdJf+2onaVdmgb492UCCuNr1q+r9OB7VPcvsm60wr0pKr+gHx6tq3cGezSsXf73kD5n7FWgOogPQNZXFmfOySIy5cSNjlW9ftyF430oDhdl7mR6/TatwSHP99wSsQEZFYQMqMPqWFihJ3UUWuYmPxy2y9i6ufaW2cIyllWlEaXCcYCUVqMPCzOCUBo5WvQkKQ4/LlC+uGpMcuOF2T28dMep0GZFcrPHqXTTfnAoTf9Cv+o1nm+oLxGIBGjva4BqYYG5xk0edLxpr5BgFwehIh84QBOI/K3ILY3/PmPQE2NeuF0WBgRyIRG6LKcfWrv+KYaJhKIUdgkKgN8XwRtzyguq5xRfnZX2x4ko+9rMmi6npmKEYdZu9ODhHnVuzTUho6x094R6Y7kfmcaNUV5pH8sFqO1uRwo
X-MS-Exchange-AntiSpam-MessageData: yQT1UT+npZlox1qWVn/gf3rvR3pwIkTRWxq+SSW863Zbib1TEMpbLERncDGnqdXAG9dyrrNPXEGwzc8J8AzAA+ZBmFJk+2bQhpY+KhL4oHSB7T2MsDOSUlofU77tEudwJ33Jf2M9iLXqUDNUEjoDFQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f97e03-e1a5-4acf-8783-08d7d6e667ff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 09:15:37.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEN9FNU0LLvpINoQp7RV0k6EYrgpsPCLByzTEs4RLH7nnBrqBmQCH9550tMd7W0eO+qQCgg+FJRv00+7apC4CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

"1382d6409891 drm/amd/display: Fix RV2 Variant Detection"
introduces build error of:
"use of undeclared identifier 'RENOIR_A0'"

To fix the same, this patch re-orders the
ASIC declarations accordingly.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 8a87d0ed90ae..2359e88d6029 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -136,6 +136,7 @@
 #define RAVEN2_A0 0x81
 #define RAVEN1_F0 0xF0
 #define RAVEN_UNKNOWN 0xFF
+#define RENOIR_A0 0x91
 #ifndef ASICREV_IS_RAVEN
 #define ASICREV_IS_RAVEN(eChipRev) ((eChipRev >= RAVEN_A0) && eChipRev < RAVEN_UNKNOWN)
 #endif
@@ -171,8 +172,6 @@ enum {
 #define ASICREV_IS_NAVI10_P(eChipRev)        (eChipRev < NV_NAVI12_P_A0)
 #define ASICREV_IS_NAVI12_P(eChipRev)        ((eChipRev >= NV_NAVI12_P_A0) && (eChipRev < NV_NAVI14_M_A0))
 #define ASICREV_IS_NAVI14_M(eChipRev)        ((eChipRev >= NV_NAVI14_M_A0) && (eChipRev < NV_UNKNOWN))
-#define RENOIR_A0 0x91
-#define DEVICE_ID_RENOIR_1636 0x1636   // Renoir
 #define ASICREV_IS_RENOIR(eChipRev) ((eChipRev >= RENOIR_A0) && (eChipRev < RAVEN1_F0))
 
 /*
@@ -183,6 +182,9 @@ enum {
 #define DEVICE_ID_TEMASH_9839 0x9839
 #define DEVICE_ID_TEMASH_983D 0x983D
 
+/* RENOIR */
+#define DEVICE_ID_RENOIR_1636 0x1636
+
 /* Asic Family IDs for different asic family. */
 #define FAMILY_CI 120 /* Sea Islands: Hawaii (P), Bonaire (M) */
 #define FAMILY_KV 125 /* Fusion => Kaveri: Spectre, Spooky; Kabini: Kalindi */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
