Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B8CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44863207BB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VZAEp24n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44863207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27B989C03;
	Thu, 23 Jul 2020 08:35:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388A989C03
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imqPzGTWLfgkUIV72vBY4K9Sh4NdT0MwjOWrZwrQiQ4WgELRYTfZKqd2lJP7uCBcNfIVGwiRrl90SKtODp22dwVnvK2CDuR7+Rkmm8NZxjIEc0Qm2gvel4V7Fwx3IgnEWaIUJXlWAznHXyEVsnpTfL08b1GWo3NVe80Jiz2G1anKBsr0b52qtUJYR72OesJC8D5HnbnJoBPaz/KAs/kBY9STXYr5cBKcx3SMYWK4gVN0EQW87DlDG6gx4kYPreHVpoP+ymw/IVnsGElmVCS4r6i4/f22FUKWgS3JsaJ/CzvQJC3UW8gSDE2zYCqmMMlTcwhSpTic7iy29om6SNqbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3e/Cx4wWbFmITPyLruM8dt2x8td9W4pIMDZGDhTfbM=;
 b=TXKljRATLg3sxK0sA+IGy5hnMgapxqiT58OiTZGLuIox27mTk/ikzKBWZugqoqlt/TgIgI+y+iisSSrCPm+dL2Rst/Riq86WEUOwt+a8vWA2N/9r0PORj0L7XFl/hZn3Jh3kny0Ra9bHB1t11znHHmvg54MQBCV8Rw6vfE3BWWZ0taVTXvA66XOVgMmDoGnQHn73AfeoNEMNZO9gPk0wqY7KQSB5bsUctlT+t3xZm79VCgtC5vZsJVI12s26BzGvS08XrH+njG0E5dRdB+JdOy4+7S6+lsZtJb3bNYeHgNTnfbPYfrL7xapQSGM3eVOZ6FlCKY40xwRXyHEfWOgBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3e/Cx4wWbFmITPyLruM8dt2x8td9W4pIMDZGDhTfbM=;
 b=VZAEp24nZp0ki08hZePHrKi6suaMz9RquHOKDbXRRIZUzIFXsK5terhgX3OpJAqMYWTt2MEkLTSMUMVHoGON6+PjPJlgbGQAWIxxrQTzzGhwzWoyXNS0nT8BVnn7VdUwgVZCCSl5zLsMPOVG9f23fzln2itvEM9wxKgblmS0Z+M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 08:34:23 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:23 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 5/9] drm/amdgpu: skip bad page reservation once issuing from
 eeprom write
Date: Thu, 23 Jul 2020 16:33:42 +0800
Message-Id: <20200723083346.8743-6-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723083346.8743-1-guchun.chen@amd.com>
References: <20200723083346.8743-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d54f3c8f-9c62-463c-aec4-08d82ee33330
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0005600EF2A632E90E898004F1760@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydqG4OGotUoWDA+L1P0Xi62vnfnSACNjMw2G5FpO6JtzUNZyAt4A3jye9kTCZPhCLw0KRfzSOexArKU/Jp+fmLj3s4gTOqZi+O5CqRzf313jZR4cT58Z91eVlIeYiRY5nmFHtEBVw1ub7EQqj+r0EAg2mofVZtf0pEt0lbQJldSGT10bKgPQhe73jNIzlAjjm/NAgVLwF3hesSJHywHDGWUKLjjgKj1ZJW+VJ5u4ztAWzqfUOeQU5JSMF2RBBr6U9QRAMX/IB71+WpplgTGjHJToA3aS4Uc00TFOn1TFAzfFnQHlpS69SZeCDcy3xsTTVMhHkv3TU3CxM3le/MMlkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(8936002)(316002)(2616005)(36756003)(2906002)(16526019)(186003)(8676002)(6486002)(44832011)(4326008)(956004)(26005)(7696005)(478600001)(52116002)(5660300002)(66476007)(66556008)(66946007)(83380400001)(1076003)(6636002)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gXDdCFO3e63gHftjG5eHl/zPaH2tpJmqskI0fjPtr16mOTO7Y+ly1mnKEHYMfvR86Vy9EocCNcgx9izM4yE3FvnUHtBi4vNiw+dmSz5Dq535N0vQzApRJ5YORRDow+r1GZzmH8i+d4g/bxITy53QBmxqtRadxwiS42YwiK9v9yL+OO0nJMpOtdqmpR5u6csA3UdRR4FK4WlA2Whk81FAPbS8Qe5dPwSTMphE62joZANJJ92uwZlJt+yhBhb641st4FrXYHPNK0K4BN43+1R9YWBw1vVtEn7iBqz2c+vWvtuw6xcQtXnLkoWQOIvpDON6sCXCwlBP1Tz5ROc6n74RNtLtv6oByN0cLzuJEeo3QeOAKy+Cd78ApR6BvOnW/C0k/dUXfMyKqzk1jgCGBK8GnRuX6TwtTncxpxVj4RCYkrGmWyhl02LqBQrv7B/7I2ysHQQXL5CQwzqc6Ck6/LAK4rFp2yplfu7IaCnyo3IW4rymTTsj0BgJrS2pfRNsQG0p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54f3c8f-9c62-463c-aec4-08d82ee33330
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:22.8945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQNNSyRtAekins7+Sw4HaOQ0tdmOfdZExQtBuVd17S+H7PeG+7vnpO/H3+leBhVvhfwxnNe3EmelUwWGlUQvKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
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
index 06db2f0b78d7..4c86c7a64bcc 100644
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
