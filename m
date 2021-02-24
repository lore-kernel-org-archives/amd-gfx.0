Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE734C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736F264E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736F264E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CFC6EBC4;
	Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C36756EBB5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3UN7n8g5gTzTZuwYqpw3L1kUWruIlopZ8cAs3ol1qCXK719vvmwzIYsE4J9fs/KXYQZKcAv2Ah0IwsGeJNDP4mUceIL7e+02f8hifhbq2978D48tzjp244c95p+u/F2gasDdJKc8KSmXxx3kt6aH1ehDbrNamEc53T3JAND31UmQb17AtA2f2N5rTxE7CDUvVDuqMkezu5p3Dw3al0sPCS05GXPP/Zu/XxBv6nxh4qTu+AZRWQtZiUSU+B7++mJGAVrHyqgTT86Ee5Vn0LbNduS0+XW2Z8OGDs+La05pHVmZzfo49xZBr6pjU7ScvThO5QB23FqLj33Lzt8srhbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7UdnRHZCD11PI9WKNN0YrUvbF7wsRbHSN27jFtbzeQ=;
 b=oEvi8/YBlTyjt19rWci7CAvDbD0/3QXvf+lBAJsLscj/TpvvHKeXz2nwTKAtPSkrpF9N+4x6Dv7cXPy4cEI6ef/qOequiUdNAVWNFhELFhET/zLdI9hDb5pp9ySMtrEQ8mzkhtMtzfnC1udnwa4Qn/LBax08NXSXAVeNWZkzn52tGzcTj3W6cbJL9mzgAj2yJqmtGkVzZIfIPoaBjLiMeiba9jP1WK4z1kBTzyTX3LoIhy/9aDwHIJGZjfGWCxip779g/O8kY1FsBtvcozPPOgvjybwzFIDW0hUnj57FnmyH/RSCza9xZhIY4dW3S49tcvhcgAwAvIl7WDqyYkWaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7UdnRHZCD11PI9WKNN0YrUvbF7wsRbHSN27jFtbzeQ=;
 b=TPTCEL5BXFx+ePx5z6DbAMId1jnME4JUbvPAyJR0DknIbAHkccidjvK2CB++LzOoYrXtMwFlgddoGX6YLm53HnnAAbzLKUR0V45o/Z5murOZ9LdQC42ykvQ732T1DOgWkyiOqqnIeKbkizXjg+oNb35GimV0QONohthWcDvMm30=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:38 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:38 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 151/159] drm/amdgpu: add gc powerbrake support (v2)
Date: Wed, 24 Feb 2021 17:18:51 -0500
Message-Id: <20210224221859.3068810-144-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9d9d8f0-650c-4787-6daa-08d8d912793e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB472269B5A722BDBBCB0326E9F79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5R+bZsmrD2BKRwKKhXmPO+3qIhuCbRKDDWHan+2gqzYxlCEC5QVlxPrW3GwfvJFYIgVulI/k+0zgUN21ehopvqGr1wOrQNAh0kx4sj8l2+XKs/WLyNwp6T09vK/vYxot0wVcpC+Fg2OG7bie4gfZZH7vaBMxS1jeLxYWP2ofwKyL9G7TtbuOC+4ajIB3F8J7bBrZPM2GEPBnCcSb5KHK/SpRnecGatmbZueRPN1SX/vCNnSAfS/YvUYkid97qdPqEnyHsWWuqd34qvY5ZdZALORZzssfWHlWKDW7b+4nxLgA6FGQMmGiqmWIRBC49XVwWJO8Iyyd33SMC9EL1MHJQiKAAsK/TMeWAH8G7oBBzii6HiaE34GtlvW7mYD3EO1U0G25Urlke0h4PEavAse5pMoLMsahbAgqrh68EM4UldPDvJDm1glNzpFRC7qdxm8niybf9p6uSY0G5/bcE5Rm+4LEh6ojdqs+bOK+bV4HfnUxDhgOhZ6jIU9so3tYyrYKZegeiAPe/NKo9WSgDeD32+SW8uzs5n2mpDDvpebn1Q3AGJksPUYB/YQzQLMc7ZHt9JbyPckQDmlO3mrkTJPDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(69590400012)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Artc6OmtI0A28S0y5ZpNGXRabg7Rqt/6XZyVzUh6JQDl5d7+dRgLeoshhzwy?=
 =?us-ascii?Q?vDmAHjiU39Xm+xsQfdJYhYre1wrlCkl6KpQnY+4fNN8hR7tlCPK37gW9CQXL?=
 =?us-ascii?Q?OH3n1k6KR6zvhGrvI+OZv7IT/fbTdy4bv3pZ5UZDelbD03Edtc5Er0RX22EU?=
 =?us-ascii?Q?pbJDfmVPGmTcrH/rvqSM2qwDhbZOIS2CS0Lks3wlBy2jKUUCbmRpDkYQX5tR?=
 =?us-ascii?Q?rwMSr6tLf88RIWmsg5DtPWkH5W2YTkz3abvqjfgtk1D6quR/IztvDIKI1qCp?=
 =?us-ascii?Q?p4hqIYgDZhkz0jFr9jIdrkgRe6UTKL+Sx6dGCk08TWoW+8/kCA7FCF1Pv4fc?=
 =?us-ascii?Q?Ikh5CcSjDbpxQEnQaGEh/Sb5OvxoY/usufJl0suLMmHlywzW/Yj+MrPHAKar?=
 =?us-ascii?Q?i4+ceHE9xGIEV3DHV9vCTtfxQC0V5XIC4B/MsJ6ddeL5aoBM2MWmS3PIEq8u?=
 =?us-ascii?Q?0e9T5/mMBiux927UzESkBP0pqupaHrntNPqemyU4eFQi7rkmPxxkZeLWWxUz?=
 =?us-ascii?Q?/b9Ury4EO84NEN44GyNA4XyX6XnSZx7YulZpe7Kn+MCPKH8/eF/dJjB7iloz?=
 =?us-ascii?Q?SjbnDvWXdnFcl5w+MY4sMV6AVo5WawEt3IBVC2tScSYgZwMk/8m2c4prh32J?=
 =?us-ascii?Q?fZtyoiJUA61KUFEZILQJyRZ45UETcc1I+UOWRWc/mt1ULFoCz5vPGXdlGk3y?=
 =?us-ascii?Q?amTdbRbpfoLnilR6cDpfDkrsmopbTzbW6teHcmhGHK3sFs4RB9XGnJFGNHMu?=
 =?us-ascii?Q?o5bONyis5N8LnSzKzXKCjDqb8Vn1Gm2M3v7vkTipdWlhdKISiGzKELVo9f0i?=
 =?us-ascii?Q?nsNZcFvbNgIJDZQJA6qUPYh7F4/DxVpjrqE/cgqfWhHJpaPu0pWsnS7YV5Jb?=
 =?us-ascii?Q?33Ia4WJFn96K2KthmCGQf1g5IRyU137mMlN0tc8lL+Z4m4/osOdJOitQhtFf?=
 =?us-ascii?Q?FHsik11h5Mo3JTXpxwYpRNeGK/faS1zzGXMV7c1eNJdQUSMIHsAvB6zO3VcW?=
 =?us-ascii?Q?2WDZgUerntnpM7JxJtTjmtmn6YJEDs0Dw7nUF9IGucEyO5r+EMuYKdIr7hQN?=
 =?us-ascii?Q?sMRLt0ouq/3w4A2XtqLKTXLsL2yqt24IS+NP1pmz5w9dTH7YqMp5kF8g2bPj?=
 =?us-ascii?Q?8ezETMwPyjCtmu5Gh7F1L4LQ+fES4itouXdE/IQvnFT6sUMl1nTXqQeN58h+?=
 =?us-ascii?Q?NfTLOCtsBZM3uuCu7n41a//iyYHSbK9VbzdHAFj5DCBFmP0MAXJ4X125haZJ?=
 =?us-ascii?Q?1K4vnYRg0/vqHk2fX0Fgrjn0B+8bZ0u8st2lhrdCA8AetUH9l8K/SpWY0pPy?=
 =?us-ascii?Q?y454TBVnjdas8qF/CCNOKU5r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d9d8f0-650c-4787-6daa-08d8d912793e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:04.1500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hA+WC34kHlX7fuFuI77v59hNZv7xFJ986h7cAQ9Y62UFDoSMUJcjhSXXEks4iIouTNJovUeVLv8tWuUrywLkMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

add GC power brake feature support for Aldebaran.

v2: squash in fixes (Alex)

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 26 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7fa1660fd751..3097c9855a5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3948,6 +3948,9 @@ static int gfx_v9_0_hw_init(void *handle)
 	if (r)
 		return r;
 
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		gfx_v9_4_2_set_power_brake_sequence(adev);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index c9b532373cad..e034ab11fdae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -25,6 +25,7 @@
 
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
+#include "gfx_v9_0.h"
 
 static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde_die_0[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_0, 0x3fffffff, 0x141dc920),
@@ -102,3 +103,28 @@ void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 	soc15_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 }
+
+void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+
+	tmp = 0;
+	tmp = REG_SET_FIELD(tmp, GC_THROTTLE_CTRL, PATTERN_MODE, 1);
+	WREG32_SOC15(GC, 0, regGC_THROTTLE_CTRL, tmp);
+
+	tmp = 0;
+	tmp = REG_SET_FIELD(tmp, GC_THROTTLE_CTRL1, PWRBRK_STALL_EN, 1);
+	WREG32_SOC15(GC, 0, regGC_THROTTLE_CTRL1, tmp);
+
+	WREG32_SOC15(GC, 0, regDIDT_IND_INDEX, ixDIDT_SQ_THROTTLE_CTRL);
+	tmp = 0;
+	tmp = REG_SET_FIELD(tmp, DIDT_SQ_THROTTLE_CTRL, PWRBRK_STALL_EN, 1);
+	WREG32_SOC15(GC, 0, regDIDT_IND_DATA, tmp);
+
+	WREG32_SOC15(GC, 0, regGC_CAC_IND_INDEX, ixPWRBRK_STALL_PATTERN_CTRL);
+	tmp = 0;
+	tmp = REG_SET_FIELD(tmp, PWRBRK_STALL_PATTERN_CTRL, PWRBRK_END_STEP, 0x12);
+	WREG32_SOC15(GC, 0, regGC_CAC_IND_DATA, tmp);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index 0fa4cd423384..c113f0db8fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -28,4 +28,5 @@ void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 				uint32_t first_vmid, uint32_t last_vmid);
 void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
+void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
 #endif /* __GFX_V9_4_2_H__ */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
