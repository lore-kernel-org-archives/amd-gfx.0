Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0D606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=I0FcTxsD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899F910E2CF;
	Wed, 21 Oct 2026 11:09:43 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E769510E2CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1FSm/RvOzD540jygee8xc4YMo+mTkFsrK8nVyUvVPXq5gKoVI7V5AgbMKAiMqf3iWUjouDPLcKMSbXHxMgmr9rO1pCC3ZSiu8hvgN45MyVAT6qPWAzjge4d/2NJhKVVjjUGnpYwCW2e4DeYdT5Xgy6Kq+I0nifM+GVEL/HXwTErXPT3xIbMQcjcMldmNgtVR4bfAIgdQe78Jd0mWZqat6LZxPYqsRZYMhEUOOjh8yaoxHAD9TSfWoeZleddEG91AZxVYV6K+kbgbiYWSsrSCjaMoZEIBXar7dofYJrkKD55dI/3jnG3gKntgxit89bjgs0PwpyGjkImmgxp7ttMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/Uq/6jOPfNbrEpy9XhAjFOUNZDaQ3yOv2q35BSoC1M=;
 b=sc7zDezPgendaeHbs7/oj5vPxOfTR5Sk2oBrVwLPORmJRrCKz7B0/NSD3j119cv0EMWbqyVTECQnrdKLwWf0HDIC/W/g/1pGp4PHjCtF249LbcMepLrTElTE71o3PQ/QyRiWniOvRjeoQI3JcMvmj9v3hCoRuwuFoEFNl0GokovahHvbsbJltF1ysLi03NOazfbytfJQsrG5dtpQkaqTcUXdRDLnf85wzCbL42yiONg1vclLv2YH8NU/jQUNO/b5iXudolx46tW85jCOo/bbSaRxfUyVO6ipvf8g6BCrIjqudWewUYbRzcOO7NiAEDtYUUoNvK3o1XDHr5k9riodZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/Uq/6jOPfNbrEpy9XhAjFOUNZDaQ3yOv2q35BSoC1M=;
 b=I0FcTxsDcYHvsoySfXMlqH52KXegLlz4wX3aIQOBFWSp5a0s8UsgWiF9R4sQ1yaNqREYwlDDHlc7RkHhqayWl2/38HkC8tkMFOVuxPaZB5sVLb4jjL5Ql+UUiAfKSPW48KCKWNLCQrhHMV0/n3pPS/eraNXlli7LPLyFf8UvAn0=
Received: from BN9PR03CA0531.namprd03.prod.outlook.com (2603:10b6:408:131::26)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 11:09:34 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::aa) by BN9PR03CA0531.outlook.office365.com
 (2603:10b6:408:131::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 11:09:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:32 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:30 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 05/12] drm/amdgpu: introduce PMC ioctl handler
Date: Wed, 21 Oct 2026 19:09:56 +0800
Message-ID: <20261021111003.3371005-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e9b759-7eb8-43eb-6d85-08df2f63c8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 26qX8BsI0zTNmROMwId5zk1SCXCxglG6Jb0B7pFNs9MLFr/6ycDBufQEINt6VzppLcAc6DPJc6t/elMDiyK4aWHKKfB5Z0JaV9YWkyrgkwdRwW5Svd7+A6HaoT0/W0C3wIN7gn6kohxzGV1bpG/n11Ra30ZZ4dVbr3puBxGdfU9wHX/CVfR+2SgX5tX2pgz77iB4F8CHIz8hzBFnuoqN0cTA1oE8k8Yr1DKSamiM9Xgs/eKrhMSzFGK+4DqYWDY8cdpXliLPoZpdpVfNoAkmPFwbefg+QtK7+ZmqgP6kpCJ7OKlWL8V3rQ0RM0LP64X8wR3oxrkNurelUNYRL9cAn7LECOfLAku+6lwVdyDGUsH9E7OJjPe1RTLlyLPIZnDuhZRWxUPee1YWZy06AhRNBuLUSv+UFqRikK4F9umL8B3VGwFyjVI2O8+p6GTOaERU5rv6wCdg+k+XBCw+DJ3uBjvQQcsYmdG0Wv1M3rZj8l9kKEGhlgI/s5g9kO7j+3lYDlMOF7oijHu35l1viy2OnFPNRrKEAgwbo8cpjhiCQgbHsuIzaIZ+L9CVyXhXCzeI3rtkrB03UMQRATLJ25znW+fjx1w+1Rxa3+IbSZNU+kB7D2kNIdrBBZ9E4zmggDRabYMf1Gv85PN2VkQ+r0Ln7H8NT2oYHBN0zvrvtmTAjiZPP5QXsbl2Av72QIHxNl4m5wMBDzanIc8JR+zs663OeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LUe/CmnXbA7J6yjEE1fOrmMPWOKzDx5yiaIw8L4bp1gSG9FY0FuKUlX6IFJfHTbPN1bXpuhZi6+aVyaAf3edjSZg7Y7x6CPAw480CdhacEedbOZZ6Nv+RyLfnPGJVeUCxzDdfyA4Xqyj7NOHvjAINEr0jf5SF34nwUd/O39AmWw4Uaz6r5A+hIxo9UIbBRPVa4qyfNWGrZeQAZJd82oeDmAuzi8+CpcjdHnPXpTXCfqMSeLaXqrGbH4EbVhLlC4uwu4BmycqBUyjWQvAPiY+R9OKYdVrUptpd2NBt+wBYcOX0ZAZD4NYv7nTHzD+Q51dBxfAApKzSlMRwXU2lWq7e69J8C5Mx8qhgcAMhFWF2PmXG5Bdb5c7DIcUXxciUMc2zxaLtahZtWOpAPUSVwY3TVCerB3o7WC37bTfq+nvaSm3lHgWh9fb+PT9+7zrJ3Qw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:32.5925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e9b759-7eb8-43eb-6d85-08df2f63c8c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit introduces ioctl handler for PMC.

In this commit, the handler only performs
basic checkings, including permission and whether
user queues are enabled.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 28 +++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 04902696adab..feff37279575 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -23,9 +23,35 @@
  */
 
 #include <linux/errno.h>
+#include <linux/capability.h>
 #include <drm/amdgpu_drm.h>
+#include "amdgpu.h"
+#include "amdgpu_userq.h"
 #include "amdgpu_profiler.h"
 
+static int amdgpu_profiler_check_access(struct drm_device *dev)
+{
+	if (!perfmon_capable())
+		return -EPERM;
+
+	if (!amdgpu_userq_enabled(dev))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
+			       bool enable)
+{
+	int ret;
+
+	ret = amdgpu_profiler_check_access(dev);
+	if (ret)
+		return ret;
+
+	return -EOPNOTSUPP;
+}
+
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct drm_amdgpu_profiler_args *args = data;
@@ -37,7 +63,7 @@ int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *f
 	case AMDGPU_PROFILER_OP_RESERVE:
 		return -EOPNOTSUPP;
 	case AMDGPU_PROFILER_OP_PMC:
-		return -EOPNOTSUPP;
+		return amdgpu_profiler_pmc(dev, filp, args->perfcount_enable);
 	default:
 		return -EINVAL;
 	}
-- 
2.53.0

