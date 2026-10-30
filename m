Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A609606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XRjVRyaA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF85910E83E;
	Fri, 30 Oct 2026 06:31:19 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C197B10E83E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrGScWwHwYGqPAGTPM1HEeQ7VNFNOvIx39SBtJpS8dYHvNwMAqNxzDV+ahy2gkuiBcZ94cfDveqYyGExOhdR2K6p3+V4CggYUBEx9lBXL06dxJNhMbfYPDiUGBCMvHEiNDrIWO6HqPYUu+XFSGS2G8vGgrTSjFEBsSI7UGCYf3Pq8uuGKNEy80aDyO7Nl+pAPl7cz8GBLgIpefjPtophcth0DfSQhCWkpLHRPB2Atbbn2yM7zrepz9Wf2R8sLenzlY3XKnneQc9hPZfimqHMqX5YWCFNBbIsnJY13rpZrO7rRFjPPoWyLkZXlpaVsnorWghIv7DWrSlmUV7tBrxxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdMEZzvC+8gB5ow9uZgsr6OlsudgG+yEbihcCqXxzyc=;
 b=nmbX4HTFXTDmOStN/EixzsRI1TTLklrgNvEO9ysYSEYuX1wn7ZHPifkYJFrrSwGi1u46imlOx0FNKkes1qNXLBKPvcPx/RC8o928q8tRqUO/UY3zMJ45r/HacflstWLmD1hGslplWl8V9ZpTHzOeU7KzG/UIcEVa3eX13dp6dCcSrkwsNafyZEuUuRog+/V6UWqkB661ZT1pWYOmjnQS98aY0T8NJLjX48ve1r5vQaf92SEbIk2I/Mam2zhksPXwztFoUt2FMPvR1NpCOgSdUxruzjdfao+zkFvHgfPEiXBVAgwTPlVQD5PPx9XfUz8cPRAQtNhuDYi8VkSKnhq8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdMEZzvC+8gB5ow9uZgsr6OlsudgG+yEbihcCqXxzyc=;
 b=XRjVRyaAL100Eprox9ZVAL10rrGhp9cRyD69kjrraoJtJ4xB1uinSewG+9I8xl0Y1xGN7dr5o3ZH3Q2ZOOk84HzPQa/QfzdpZ2pPLZ3gUyF6AH6OK/0o9ekbz36XtuzIFe0+DNAKjpdGILZUT63x4isdZ8bla5YYn0keyZZ1N7E=
Received: from SJ0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:a03:3a0::31)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:31:08 +0000
Received: from MWH0EPF000D894C.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::3d) by SJ0PR03CA0266.outlook.office365.com
 (2603:10b6:a03:3a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 06:31:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894C.mail.protection.outlook.com (10.167.249.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:07 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:04 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 03/13] drm/amdgpu: introduce PMC ioctl handler
Date: Fri, 30 Oct 2026 14:31:31 +0800
Message-ID: <20261030063141.2773032-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894C:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: ca840c6e-f445-4689-90af-08df364f6195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|22082099003|18002099003|11063799006|5023799004|56012099006|261009223027099003|261022075727099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: O9NzPd+0pDK4zXk6ttcRCesjIysx0Zptq9LkNRsz77PvbMRrq0+95ZFCh49+zbf2l4bcawv6TWrVBpQpIV7nUA/1oPxrMM4jBV7F8og5y4fI7Uh8lxUqysbR7ft4M9M37pdEqdCm6bAQNJUMGTijcLQy5bRmtv/emeh3WeRo5Iu98/Nb8VqmgNxmMwvyZIOUXgoxb5TsRzUDCrlJf1EyhzKwCmoPB49bhUrAEuQg4Ntpe4ZoMN+zrNIaGKQPZk6G3jqFF34yWld3Bfc+ieffPMtSLbDbnnaMWjKkf0R857Z9CfYvaHEFXf6VqEgrQIuMMpOnh8IvTRLxv61mw5Bl5aDOPDerUURQbksORK4YYY6tpT68Gt5p5Ub+TQdSlpshvxMINv56fSz/h8uB/Prhnr30S5VQgZtwvZtScvpM8eTV6Jw+0ZrYEhlQVyoCCHzIWWqJZUmeBKN97eoj6zI4mVQXwcKjdRQQihek3AY9xrSSFmQt48K9ShXw/VVnwI3qAfjM5jSFyfzoQxdkXBptVd5ceRD4Qo56s6l4FLeI48jXWY2J1YUnFcHgYSMEaXke3HzuGd1c5LY7qQXYL4fWZ96ZeaL47Tt1Kxi9NL7H8SN/wP0E8zjCnJ3lTB20ldo+jGLyxjz6VWFOWdrSivrFNqebCchz3Gj1/c5mepiLSD6KWBfRmawTw9Bu8m7R9Xouk5Gt8qL0DCvhXKw9RC8u5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xa8tJJygb+z4dDfNAvO/B+keR0dxiYXQnBdu3qNPAmnjR+MMiWl28O7Hv89K4YfY7+409VorWY537TfRYDFefeNwoiavdOqJTN3eRN+PRCQpqzU4vsIFOKVapatwMXk4RhCGfvbEMbsbEVQaEzdtI1g8vQwEm0DJb7EUEGgtbzj0N3dx34IKuCdBJCVT+ZOrwGLL8gW1gghbZIfLbZpvnvPqLdnpTktfUqW33ZIyqUZdHjAdgOs8VnIz/WZBISHCxsd5iXHPmhDLKj1ZJ6gsCl6LMvxJwx150xxMoxym0X1eVrWP6HuprZaAk5nQtVDOsFJZN5w2Dftr22uDypXbLVBiSFELHPBXIESPHUmK/HdxTGqquqzy4Px8IA0vO6O0k0xtS71CHNUvIg73+ar9OdMpN9l5xrNtKkf9ofCjM2BfCGap5P6/WAPFsI2vZrIY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:07.6067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca840c6e-f445-4689-90af-08df364f6195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 35 +++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 04902696adab..134660a4a4d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -23,9 +23,40 @@
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
+	struct amdgpu_device *adev;
+
+	adev = drm_to_adev(dev);
+	if (!adev->pmc_profiler.supported)
+		return -EOPNOTSUPP;
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
@@ -37,7 +68,9 @@ int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *f
 	case AMDGPU_PROFILER_OP_RESERVE:
 		return -EOPNOTSUPP;
 	case AMDGPU_PROFILER_OP_PMC:
-		return -EOPNOTSUPP;
+		if (args->perfcount_enable > 1)
+			return -EINVAL;
+		return amdgpu_profiler_pmc(dev, filp, args->perfcount_enable);
 	default:
 		return -EINVAL;
 	}
-- 
2.53.0

