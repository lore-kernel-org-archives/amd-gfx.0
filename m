Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17460C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5D164ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5D164ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969AD6EB60;
	Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B266EB5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG5RQgiJ+QQKU1N4JZRU4D7XetzqmLJ903ejjSxnDPrRFZgQBxWJj0Dmcr7yvzghgoLT+FgkEpsH+CXDxJndwZeVdO2YzqqmgPi+Bdo7mhecMcDsNnTZd+HtvlbjzsOuTxhYovgCv2SikTT2+IiBYUNNzeP4Dx8sC3sbM83Jc64O35wLp1pz7SKnaI4T1vcc4Ig2Phwr5qL1Bfa+cICqZonDBxUpsDU0vqdPukXMkEZmNsRJjg41EL92dyeuuJhz/zkq9bl0REhEqjaW2ZjkgzNT1Nrl9bDellCQJVYqBdpfLzCBq7QCX4NidFLAjBQfGLOjvSXHwzdDwTM/ekKJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu5BEtvbsNLvCzPMxx2ohsGvgHKlzM4GADSTgMiKT9s=;
 b=TpaI+bwgybgtZbZrEQ+TR95bGnseogGhKbNChXYTEGY1JilR7yZd+NsniASJNcET4oshXpZEvcffeJAkEJyhcJVgEcq07aSQ9CQYHY4L2BE5jDuoXqLk3qGIoQdn/qUghccOIeY2SaKwvn6LAxis0eSk2xCvpEngnzkh4SuvfPvM7JkVh+L8DG+n1D4VRzkqrpqKYSqs4TXS8RaSxL7ZEoKVZR0SC7yn1WnMlO0k1bN1RWOTPvyLchTg1ssxHchaZm1HVr/+RMUAlUHEI0ypxSMdY5RDC8c73YrcOgRb+3b2olTuzNQnVij2qLJk+tMbvc8yIr2DZvAKl3IkmBAgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu5BEtvbsNLvCzPMxx2ohsGvgHKlzM4GADSTgMiKT9s=;
 b=iOiz0IDHEjsXFaBlsu0+BWWgjjkq8mFCF9zH0qq891ZtkfusefgZbhQOnI7oKYkv7TcGmxqS2q7LsM812VPiprevCw3zStomuYQ+TzbpjKpZu17mt5cZjeHJZq1ZNxZshO+UYbxFSNmcunsQl5OQFQv4/EH/IKQOkPOJL5ubE1c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 077/159] drm/amdgpu: add sdma ras error query callback for
 aldebaran
Date: Wed, 24 Feb 2021 17:17:37 -0500
Message-Id: <20210224221859.3068810-70-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85a5b3a4-3884-4967-65c7-08d8d9125ad5
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24979AA0E72BFDE091C9CD81F79F9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AV2A0+GBex/pwXxbor8oqu7OdoHkYJ/tAKnTe6+vA1Cp/yhEev/BuhvSJh5OndegBuYfbQEwDIgEUMOzm5p2a7J+v4Klk64+E3a4P3m+w0c/pjMye0IGr2q1pGQ2sw4nmEBLjcsNobTG/hgdzwrOFSQCbh5WthISVq3xxIs2OMWmf1U449xzOtBtujsnSf2ytx2tTwa3kRftt7N6/NDzdnm44a1AVevTi78ZXIhNTzJUq8FvEJS17ukm0a8NsCt9SeqRQeQBX/ma173/hYgU86uSI/wYVNW9mmWQcTuL0tQD6APAejOs9XgDzAFSWCmVW8v6+HSmb2LHT/+L0lG94os3vGa4lWX58nbd0QwRhbGkFCEETX/D6c87jcD+VYWiMRdxxRVZTEPdeeYPl4GWz+gr6pNQmh3W6L3Q1e4DS0oSs86/8eVX5fYNHuNwRv5MpiEYCkrc3XTyXePUi6impi5iTKXdf382jjk4dE+5Ar2UrLDOov8cp6K38Dd6a2ALzdhrKvnSOqBqebnH1XGBsBWrqhnURr5HX71ZOZBCaZdoX/w66tOQPULXeHM/BoaBgYI5eOjOFQ4ti2oXcboafQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(69590400012)(8936002)(6512007)(54906003)(6916009)(26005)(956004)(6486002)(316002)(2616005)(52116002)(8676002)(6506007)(2906002)(86362001)(186003)(16526019)(36756003)(6666004)(478600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+n7lkKVj6wdQjfhNtjvGZA806nkaAN8aI4nZLHb5/uSXQH+KX4M5FGrlkQsj?=
 =?us-ascii?Q?8P/ifxkI6jsIb44yqv6jdoH+nwCohfx+JokPNtee/qPrOWJl4JEzyAUiOAjs?=
 =?us-ascii?Q?+Oc0a61PxxPQRzCmCSZ06RTaVOefcUY1vgd8ZGRmOlh9TDVn4CXucc0D2A3+?=
 =?us-ascii?Q?g/TZnm1J0q+3gfpceJfHJalCgi4MeL8CbK4NpHplpbGIZEJGIMbp10ys4Ru1?=
 =?us-ascii?Q?pHeBa//UhgNwJgygtO2V+6mHyZKcaEVTNTSG6yWwWK8PbpmW0Rlbtk5LSnUZ?=
 =?us-ascii?Q?LR3rsl5y5B+Q/WD0M6eXiccv8zqkVJkwQej2zZvuciywtQQ2ll/pmkF6pWBf?=
 =?us-ascii?Q?2xPwgRP8bbAIFu+YWFItibGmEq8KczsFvAAV1uo3/5gLLF0iE1odD8hi3VUm?=
 =?us-ascii?Q?GSb/EZIuy2hCYHHpyXYsGK6Tuf5u9prfnG7oL1hTHyVc8J5yWQuGVvsMNq5L?=
 =?us-ascii?Q?olBDanJiyBKxIskgK5dgUBlyviOl/FHntvy0tTpKiKmEQmRwl+4LTiwIBdea?=
 =?us-ascii?Q?EGGWboLqkEvbK+Dtx+O+BOKqEICcNesTFIEnxGmy64YizLj5QlE1sm2zMmWn?=
 =?us-ascii?Q?EfNexgTy9+UJfp9A+XDdexlCPDNWsw3E0/kSpM10UQOXjV6xTIDa/1fE+7TV?=
 =?us-ascii?Q?E1TbNem0f0MfCD4UmfZGSdSOEAMxmFYizmdBa1++FLzUL4ncDKH6d46klU72?=
 =?us-ascii?Q?yUlIB6HZHzR7h87O+lRAoflAp4gB6NCQKc1Y43aC+9rftMjp/10lqPbJT+m+?=
 =?us-ascii?Q?nOC/xAwyWlEn1HYDp2i2WbLnwnLFZD3EvXazacB4HO46DqsYu7ZvyewHUt19?=
 =?us-ascii?Q?mCRcwxgqvUVHWIxcuA4x2lbhjQ1bN7Psdu30ZHyTOkaJJHPasAjy4j6AmdO5?=
 =?us-ascii?Q?mWwQ0pmY/2NCteaIrLeuyjhwYtc5fqlVAQxZV2k01a/tUm0iscqySrKgEx6R?=
 =?us-ascii?Q?aHr7tz5iUZfB3fUP4awri3u9k3CSvQy6aS4XKwpVQychxHcv7/8XocDu7O0l?=
 =?us-ascii?Q?4JTmHeHlHIsH/KKchC3Vk/lWbTgCRmhqEdwtq6qyVym1g5kRhlwJE/K/+fR7?=
 =?us-ascii?Q?8KSkN6ZnGUpx/yDtDoSJfaMUuUFD8go1XyilDnR8kf5COeNCrMdETCnr9vd2?=
 =?us-ascii?Q?G1FQTL+Xahok7Yu+dHJSqAEQSc0GPRBbLRUb9M1sLIQofKQe6UT/KA/bIM8T?=
 =?us-ascii?Q?TGMfGUHBNbsRzrMLSe+2C0Z66xjsCkaUb7UPuRZRWKk5wNDrgKa9P8jbDh4J?=
 =?us-ascii?Q?FRC2T4P60ejDhfZWKvyEDVlfnol2NA6SgSQzfie6jIeU3Px4dbidCglZOMna?=
 =?us-ascii?Q?84Rc0BEKx6WkFaTEldmwSD9i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a5b3a4-3884-4967-65c7-08d8d9125ad5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:13.1390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LVZQzHQSiQm6UsgI57bF/O/w05sV4Vu4uh8aVCjK9sutB//7oVclT+2irLZaqO/gi+TrzfKhmp/1ANv9r70vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

The callback will be invoked to harvest all kinds
of sdma ras error

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Dennis Li<Dennis.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c | 187 +++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index 8f5bbc0d6630..3a5d0a6bc578 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -21,8 +21,195 @@
  *
  */
 #include "amdgpu.h"
+#include "sdma/sdma_4_4_0_offset.h"
+#include "sdma/sdma_4_4_0_sh_mask.h"
+#include "soc15.h"
+#include "amdgpu_ras.h"
+
+#define SDMA1_REG_OFFSET 0x600
+#define SDMA2_REG_OFFSET 0x1cda0
+#define SDMA3_REG_OFFSET 0x1d1a0
+#define SDMA4_REG_OFFSET 0x1d5a0
+
+/* helper function that allow only use sdma0 register offset
+ * to calculate register offset for all the sdma instances */
+static uint32_t sdma_v4_4_get_reg_offset(struct amdgpu_device *adev,
+					 uint32_t instance,
+					 uint32_t offset)
+{
+	uint32_t sdma_base = adev->reg_offset[SDMA0_HWIP][0][0];
+
+	switch (instance) {
+	case 0:
+		return (sdma_base + offset);
+	case 1:
+		return (sdma_base + SDMA1_REG_OFFSET + offset);
+	case 2:
+		return (sdma_base + SDMA2_REG_OFFSET + offset);
+	case 3:
+		return (sdma_base + SDMA3_REG_OFFSET + offset);
+	case 4:
+		return (sdma_base + SDMA4_REG_OFFSET + offset);
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct soc15_ras_field_entry sdma_v4_4_ras_fields[] = {
+	{ "SDMA_MBANK_DATA_BUF0_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF0_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF1_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF1_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF2_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF2_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF3_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF3_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF4_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF4_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF5_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF5_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF6_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF6_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF7_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF7_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF8_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF8_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF9_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF9_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF10_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF10_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF11_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF11_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF12_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF12_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF13_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF13_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF14_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF14_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF15_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF15_SED),
+	0, 0,
+	},
+	{ "SDMA_UCODE_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_UCODE_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_RB_CMD_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_RB_CMD_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_IB_CMD_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_IB_CMD_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_UTCL1_RD_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_UTCL1_RD_FIFO_SED),
+	0, 0,
+	},
+	{ "SDMA_UTCL1_RDBST_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_UTCL1_RDBST_FIFO_SED),
+	0, 0,
+	},
+	{ "SDMA_DATA_LUT_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_DATA_LUT_FIFO_SED),
+	0, 0,
+	},
+	{ "SDMA_SPLIT_DATA_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_SPLIT_DATA_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_MC_WR_ADDR_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_MC_WR_ADDR_FIFO_SED),
+	0, 0,
+	},
+	{ "SDMA_MC_RDRET_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_MC_WR_ADDR_FIFO_SED),
+	0, 0,
+	},
+};
+
+static void sdma_v4_4_get_ras_error_count(struct amdgpu_device *adev,
+					  uint32_t value,
+					  uint32_t instance,
+					  uint32_t *sec_count)
+{
+	uint32_t i;
+	uint32_t sec_cnt;
+
+	/* double bits error (multiple bits) error detection is not supported */
+	for (i = 0; i < ARRAY_SIZE(sdma_v4_4_ras_fields); i++) {
+		/* the SDMA_EDC_COUNTER register in each sdma instance
+		 * shares the same sed shift_mask
+		 * */
+		sec_cnt = (value &
+			sdma_v4_4_ras_fields[i].sec_count_mask) >>
+			sdma_v4_4_ras_fields[i].sec_count_shift;
+		if (sec_cnt) {
+			dev_info(adev->dev, "Detected %s in SDMA%d, SED %d\n",
+				 sdma_v4_4_ras_fields[i].name,
+				 instance, sec_cnt);
+			*sec_count += sec_cnt;
+		}
+	}
+}
+
+static int sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,
+					   uint32_t instance,
+					   void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	uint32_t sec_count = 0;
+	uint32_t reg_value = 0;
+	uint32_t reg_offset = 0;
+
+	reg_offset = sdma_v4_4_get_reg_offset(adev, instance, regSDMA0_EDC_COUNTER);
+	reg_value = RREG32(reg_offset);
+	/* double bit error is not supported */
+	if (reg_value)
+		sdma_v4_4_get_ras_error_count(adev, reg_value, instance, &sec_count);
+	/* err_data->ce_count should be initialized to 0
+	 * before calling into this function */
+	err_data->ce_count += sec_count;
+	/* double bit error is not supported
+	 * set ue count to 0 */
+	err_data->ue_count = 0;
+
+	return 0;
+};
 
 const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs = {
 	.ras_late_init = amdgpu_sdma_ras_late_init,
 	.ras_fini = amdgpu_sdma_ras_fini,
+	.query_ras_error_count = sdma_v4_4_query_ras_error_count,
 };
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
