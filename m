Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2A7C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B773B10EB56;
	Tue, 22 Sep 2026 09:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YNh+hUeL";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5894210E6AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgfQi3vn44/jdgIPwysqcScUbY97DXbtiGi+G/GRmvXA0ShrsAoZLVTV1unnqR5PZxTaa50LHCX3fqF/FRKCXamITBXl5rlPvbJu62nYIH63FIbybkt2wTgK6BqIV+PNH0YtrY+MEJp3H3En5kJAFqE8ibxbiRySJddq1lbB8JBv8LpOdZDsCZrBuhQOiivVJgLOpneL0nvWusOYOxiSdSS/3cjARJBFymUCpGFlv23Ha8VbGLrkYFAjIEZNiedhMoKg5kr0ObWJB55TazLV5T2+4h8wGEHR7UJJ6idgXcC3eya6qObh3bicwfY0OGxx+TCUC22UmqEiG7NXD9u7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FS+3K0mgOjFb7gpaPXhgC7hik1oOg6sXBo/BQOrcQg=;
 b=AImADNtKfxp/B0T3AOXk9O27UEWfyDQxZ1AP0MljKveHh8BF9CjM2io71NK2+SnNQPlBVwaqDkEJmZ3CfKEjtajSn4vpfOz9SosTKmMbHxb4QvmQfqBYW2CK/z5vfs+aL4bQ7ZoTlWCJcNOft6KyyGwfVXrDAk3G69usS/HEtlcmuL+Lws/mnR23ZosvXegzVMXGxbsI5qw8xjjxv1839vIbkB4cVDqQRGfN/zepoBvSBQCKVt1AjJuFRg0v+b72bZxHL93BbjzM6E/7Er4SMh07eNT+NtW1tla4hO2sX9yfwRN10OuuFg2HwhY/wqucYkGuthXOovzKckWmFSGs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FS+3K0mgOjFb7gpaPXhgC7hik1oOg6sXBo/BQOrcQg=;
 b=YNh+hUeL8l3fhLokwAlJp/+QCQz1t/nK76MJyeWLF+b9wtS8O8NH38xyK+odOfWc0lcqRG6/bkLuZNgvqCJA2NezpGPNcKUucxcU8biObcdDKLpTghrlsC5Az75m/Ku92WPUxF025iq8Igsyah/wUJ5XD0Gx/oGNmk5/QAvUlJM=
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:34:14 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::af) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 22 Sep 2026 09:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:14 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:12 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 03/10] drm/amdgpu: introduce PMC ioctl handler
Date: Tue, 22 Sep 2026 17:34:29 +0800
Message-ID: <20260922093436.596947-4-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f91f23-f6f1-4c0e-0a96-08df188caab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5ESl5shuCU3DdnAT0kxyB6ZCOojnsIcIrvomqOZg4fyUjB0BgE9WQS0bjq6SRt5X+ZkOLQ5/nxYmvseCld8NFsaoQKVDTZE2nV768GaT9FMo66E+wJYZo3rBHghjBTr63BdqFZ/G7XUxwS8kimld6y1GRew0AMhqrtHfily6LWUGpf9bHiKCsdlBDPrVezbJqyLeyu41GsXKXpZz+aPs04zerwYvducViTgVnyII8ImzsbxCEVXsHwz7BFx2QB8EuUNYqZXXEfEBEXEf1ESu88K1MB8tiQoGYO7UXv+Yo1CB7eSqEwsZGSCIE4IBTjSqurtpSCEwY793w6A7nAX26A/1l4DjFZ+JJW1ZFQzgYf4vcJC1uH/K45exx9E4ciJqXx0RCfFkccIRBQPmMFiXSiDArWUJrs36z+CsStnK8YPzbnCc9W/MZ8rqQ72cT65fd5KOqrD8bmXOYB0QducH8IL8qXfq4DoQAVumUK97gtJpN1+DdomH4CC2VLx/ISMDV+NpRkPq0Ckn2xPRqq0z6zhiqu1SK4QNf5an3phfsCC3eY+R+9G77ELJ9hwLMDfeJFWw977uGm7Fo2+z3kxJ1SyD2sVQBjpfk/1BWFaZyjQvTD3IvbI+/QiIM1hf0ZeLp7oF5VGhwTVZyjWwED9FlSER2EgQbmEIkdI7tQEkXdPTKIcmv0E5weXDhapzJKp+Otdsy2Z2Xo6FTt86l5iNhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CXe0pDm1ICsm7ibm4sGF8z9A+mdixEix5UynR+HXy3eaIJRlniFXECwbTXYmzjYGGhlaH54B2tLgOU47PUC6uyPqMa1Gf7kodDbQztsop+kL/sP5ewGXOAWOeXHI3Xk0BwXiaFLRNv5Y9f5Eolrbi2/wG8QVwABnV4yBn7R/qm1hZBRL+fsdUGGVi3P93575SSi/QfOUlnF+PEQDoi9IxCXpGp7ER/Yl+XndUcP+ibvzTby+uT6pUEqK8HPL83yyiO+Jo0NcbU9jtmX422e1MwkulzxkgUTNODJA/wXKS0JcU+z6Qaw+meSS+3KAY80+i3gLWKKCtPsdWlhgkwrs6E5ARnsoEfB5nPiHWCZZw7A6HTDp5CuG0/GV2Kvbw00MkksSNE6n+mrY19GXVdsMcQXl8T9ThEFvCth+GX32k2ejoXEs0ysf3JH8GNb+byf5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:14.7673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f91f23-f6f1-4c0e-0a96-08df188caab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit introduces ioctl handler for PMC.

In this commit, the handler only performs
basic checkings, including permission and whether
user queues are enabled.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
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
2.55.0

