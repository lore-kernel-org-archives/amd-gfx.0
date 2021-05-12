Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E22CC4361A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B37613E9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B37613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7BA6EC8B;
	Wed, 12 May 2021 17:32:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D9F26EC82
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH7xyR+EpAFnNbi7/BULXPBmzaUsS7LVsxScc0CN0x2N+1itHnAtPcB8C5LiXEr20viqQD2RYdYNrVM5apTwtw63yEpN/s0vzZP/ivvemanK+t8ethan9lX+jxu/Nxdi/9wLMFfhad5/rJYzJKSbpHOF5+w5SMji5S7ssJLQLGt0JFAh4iK7kUmaXhrJHjYhwHy9sASz99Raanov18s7tFTCfqWlxSHJzS3SJQTZFxPIEPdGRfawjk22VAu2UW3z5rk+lLiNdnYVl6n4+pUz1Paj5z5bKX4DyaozGFRv60tW6Vyzx8BdshIAOl0bLcIImPRMdZIKqEj6Kf1w6pXDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OXU5ibSLJ0DCv8ltzbWpMz4rMBJoBmCmKrHHw85CAk=;
 b=Qh7qTTmTXeYlLlsaV4tiSOb83dC6IBlQ9m5INwSKaKN5+VQgEXCGXTlqRj/T1hol86if34fRfTyJ5QpGc51eO1msmKjSyXu3ItRDrpJ5c1bk3R3crMnRsIWo94FNJ2O8YK6DbcaSluyrys6jHzJ/li8fSD3OQE+6T0BZyEU72GUMBKIiHtJS6El+ZZemphxhWFZC6eQW/APsFnDefUhmY9yiHgwF5WEcP4sIl8HIkk0uIMGJyCqzx88xF/Op8x5Cll/X3MZg6obnaFCWGjeEGlZdmaU8/irpmfF1qRmAhG0AdGL6PIWXzHKVVw0uz2k65dXseela3PV6wBfW2Be9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OXU5ibSLJ0DCv8ltzbWpMz4rMBJoBmCmKrHHw85CAk=;
 b=a83u7ABmkREd9xYNP3Cmxj+K4N7VU3a3Cfn+5RPP06xuVwjE7ewHSsWIg/rBOj2p/FBgoWLRQYZzvRdrRDbm173CQ6XTYbG36inJe3pz7QNvMA0q8KmVuL+cQ43je3SCPPeqMpHl9lw6gaOY1ufyEw0G4dMvOc0nFhQbaCNvLAw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Wed, 12 May
 2021 17:32:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:11 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 43/49] drm/amd/display: Edit license info for beige goby DC
 files
Date: Wed, 12 May 2021 13:30:47 -0400
Message-Id: <20210512173053.2347842-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca8a37eb-5ff7-4810-dee1-08d9156bcd6e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4567D862585E1DEA4403525EF7529@MN2PR12MB4567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RB+/30cQ10/shhE9/xo2iJ5X92MNq98pLySwWHOFTSEVlzXDCsZ9EG1g2Qlbl0pY0Al9Yp/+A/g+PKCaAChQnA2llngrszfHznm7dOmY/sX9SCOh/jHqLM70lX0aVs2CZn2NKeQBKKhqIqRAoSzdzZjxeVJBIpPm3mRyIKCOBzICmVLIzQI3fQdRi1gfdaQzwHehcD8wYxZlJkljg80V0B2orji51Ix+V/ktujRfBges8w1RjIVSw6nco3hU82ZNUdR6wmWl5DnGanZoiaeDWK/Gjhtq5iBQMqg5SPNzDivtDk4sBtGvwIqq9eUi493T3oWGOdY+SLiQdcJRTPqUFB//YOVhQrJ9m64FMlZisUZi7sk3xq970bIs8Y1qyzdbLysVmvLlc2Lota12EfV85oKDVMXr3L21ctEvyNZrlZxN+4w4iRGRoD6ob+vnuBmlF4qGRmKgL/ufH552UooC5n34oLHSzQgUQgl8eTRL+hfXkGhUL9I8QAbf6mwexiuRQt2OnpHLP74t0c5f3FMOB6xS6Pq3HRYUEt7r0PIzkCBU2UsM9BwZUWpJJ/aGuV1n+RBVYvbU47foo5RS6VO05+NYUrxkSTTy+tca9CaiNL/wUnX4+276u2d05pc6Rlb4wlYDvusmlJprhe9BQsoFa+moTxyzqPys+0awb0lrG8XY77TQYtCq2kdHzpluQKwv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(4326008)(66946007)(16526019)(54906003)(36756003)(5660300002)(26005)(6486002)(186003)(38350700002)(66556008)(66476007)(38100700002)(86362001)(6916009)(478600001)(956004)(2616005)(52116002)(6506007)(1076003)(83380400001)(6512007)(2906002)(8936002)(30864003)(8676002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AwdRbN6GLtQ5+zNAOMVyymEGQO8lKMabNWMiR/KzbTQaozzp6dwKcsliuAJB?=
 =?us-ascii?Q?Zl7P+9MeCx/AXbMtGnfC6XuuknQfLsALrwbNr0v5bXZ5NoRJkfNvp69t9zkR?=
 =?us-ascii?Q?4I7irGHZLc2mvgnI0C4+eXKdpTpEaVI1HIpepuSSHwQ3PJHF9aqubbF8CUZu?=
 =?us-ascii?Q?L5+4T8YB4V60avE2Im9qOZnhfQKd+wStZafE2JQPIEohxo/j43W1yzWSJx0z?=
 =?us-ascii?Q?/SYm9Np5aipleqIUYR9q26E3paLf1ig39eI+9iGh8W38eRV98rZ4njcxz6zK?=
 =?us-ascii?Q?TPNdpQnsoYMrjCPA7NFZtIZNweCb5RlWP8QkY5LJMAb6zpihwKsM7DtITT/j?=
 =?us-ascii?Q?h484Qj8Tt+UgC7PcdddmgUahXmJ+NPE4hTByOpzy8UAhEssSK2WTtCBao1HS?=
 =?us-ascii?Q?MhOiWcWF52ku7HeiypIFre57+qgK2xPzARt97nO9NMpUpyRteHg+bV9GT3bH?=
 =?us-ascii?Q?73zBQmrvlMDiPh9xK2CRO9/O12U/Jh0mNbgW96m2CGAxMSgvGdE4kTnI7aEf?=
 =?us-ascii?Q?zxe5jV0yzOVvTDrv0iN6uV9rvw77Wc7dNgp4j7vl9p7zG23ffBAWlpPHfrMH?=
 =?us-ascii?Q?9V8hm6wpMaFqfYARXV7R3M6fOGaiZds6w9Nn6U5Ya0BdYIyqmxLlCHi2Qxja?=
 =?us-ascii?Q?xFoA/XeaCjFjWXdreNgKjFymYDgkgkmBhA29WZBIVxhPbKoIIaVIABSKQlBn?=
 =?us-ascii?Q?wQEupDxlXm1JpdwfY3C1fu9ea9IR2He79bfAvNiA0JFkTLANs3PxZEOuic06?=
 =?us-ascii?Q?77G8ssX41cfdlcN5cEvNlG6UUSEpkIa6qeCNwOX/bbw4uCZsog23kGAu154r?=
 =?us-ascii?Q?W9AEuMsOehrJVSdunxxcIpgO1XHn+tWmmb3EEyeBqmmN82M101d08CznAoQO?=
 =?us-ascii?Q?uK4lNKT61QvlLb3o56P4I8vVr8eKs7TeYo2jVoMLw/C0/VfJYh+Lr5wOob2I?=
 =?us-ascii?Q?n380EpD1xjqva4g08Mq9os9A0HBtJQWu4uGJOeKagWFOrrg68R8ARtCw0Ibs?=
 =?us-ascii?Q?AdACWkoJOaMLnnzP0plTDYs6ZJVc6gRgSamSjODbYnZOxUE4H5s8ppIeEeLQ?=
 =?us-ascii?Q?tSJ4bLLvRYnZjsEd+hYkfxRibfFx97S5v1uVhWxmfAoif/ws3uov6aPDDdqv?=
 =?us-ascii?Q?Kw35zijMpZUcLXYSlBDTC8wlhMQnVbT4Q63shVnobodd4wSONPOw3CwvjVva?=
 =?us-ascii?Q?YJn2JtBVwbQCt+YkUZA/468cXoJwKWAN9sgQ1sKjKIl5entdvrYk68mWmRyX?=
 =?us-ascii?Q?wPguXFj2733JzhOCaLQOlo4VN4HmllCm3Tyb0AuJYwcCNLOWMl9IUgj+nVdv?=
 =?us-ascii?Q?aPRJ1SAn070/PeGQEnPmvBOK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8a37eb-5ff7-4810-dee1-08d9156bcd6e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:40.3886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJOWZOIbY5gI21+L6n/02f1HMOOI7dnYfN8Lb72lYfOY/twfPPjeMfHhiPRcNfd0tk0E2nqMrFNZEgHolCHw5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[How]
* Add MIT license to all new files as SPDX tag.
* Fix copyright year

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |  8 ++-----
 .../drm/amd/display/dc/dcn303/dcn303_dccg.h   | 22 ++-----------------
 .../drm/amd/display/dc/dcn303/dcn303_hwseq.c  | 22 ++-----------------
 .../drm/amd/display/dc/dcn303/dcn303_hwseq.h  | 22 ++-----------------
 .../drm/amd/display/dc/dcn303/dcn303_init.c   | 22 ++-----------------
 .../drm/amd/display/dc/dcn303/dcn303_init.h   | 22 ++-----------------
 .../amd/display/dc/dcn303/dcn303_resource.c   | 22 ++-----------------
 .../amd/display/dc/dcn303/dcn303_resource.h   | 22 ++-----------------
 .../dc/irq/dcn303/irq_service_dcn303.c        | 22 ++-----------------
 .../dc/irq/dcn303/irq_service_dcn303.h        | 22 ++-----------------
 .../drm/amd/display/dmub/src/dmub_dcn303.c    | 22 ++-----------------
 .../drm/amd/display/dmub/src/dmub_dcn303.h    | 22 ++-----------------
 .../include/asic_reg/dcn/dcn_3_0_3_offset.h   | 21 +-----------------
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  | 20 +++--------------
 .../include/asic_reg/dcn/dpcs_3_0_3_offset.h  |  7 ++++++
 .../include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h |  7 ++++++
 16 files changed, 42 insertions(+), 263 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
index 14729424231a..6f7a1f2b49f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
@@ -1,10 +1,6 @@
+# SPDX-License-Identifier: MIT
 #
-# (c) Copyright 2021 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
+# Copyright (C) 2021 Advanced Micro Devices, Inc. All the rights reserved
 #
 #  Authors: AMD
 #
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
index bce3be1ae380..a79c54bbc899 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_dccg.h
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #ifndef __DCN303_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
index 36a953624a09..dc33ec8b7bdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #include "dcn303_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
index b25342cc30f3..fc6cab720b6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #ifndef __DC_HWSS_DCN303_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
index 792515f853ca..86d4b303d02f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #include "dcn303_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h
index 62014267380d..66b1e3604f07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #ifndef __DC_DCN303_INIT_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index c2528f0e0804..3d6259d0d392 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #include "dcn303_init.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
index 44a3166f86c8..5b590c169763 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #ifndef _DCN303_RESOURCE_H_
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
index 68d3f61f0656..66e60762388e 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #include "dm_services.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h
index 76c7d9bcbc67..fd64e3848ff3 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.h
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #ifndef __DAL_IRQ_SERVICE_DCN303_H__
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
index bd7a4adf0ed4..9331e1719901 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #include "../dmub_srv.h"
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h
index 719b0959c494..84141d450256 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.h
@@ -1,26 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright 2020 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #ifndef _DMUB_DCN303_H_
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
index da98eb1cb556..daa8130636f0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
@@ -1,27 +1,8 @@
 // SPDX-License-Identifier: MIT
 /*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Authors: AMD
- *
  */
 
 #ifndef _dcn_3_0_3_OFFSET_HEADER
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
index 11696f7c2f3b..e8f4ad05932b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: MIT
 /*
- * Copyright (C) 2020  Advanced Micro Devices, Inc.
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
- * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ * Authors: AMD
  */
 
 #ifndef _dcn_3_0_3_SH_MASK_HEADER
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h
index d4ce3f141af7..6d6db95a391f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Authors: AMD
+ */
+
 #ifndef _dpcs_3_0_3_OFFSET_HEADER
 #define _dpcs_3_0_3_OFFSET_HEADER
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h
index e2cc1747c646..55743d06f728 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Authors: AMD
+ */
+
 #ifndef _dpcs_3_0_3_SH_MASK_HEADER
 #define _dpcs_3_0_3_SH_MASK_HEADER
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
