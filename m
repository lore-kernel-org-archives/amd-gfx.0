Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2684C624D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 02:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FAA910E41F;
	Wed,  2 Sep 2026 02:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kx31xUhd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E390E10E41F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 02:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjdpLL0s7GgUALUyJYFjtC+nzKYtCZZltmiUZVioiy7At6tVMK7OKssEXjwMkdkUijgi5MHI9C+vC/SvCkC+Sj3OWW7dE/UCd//AUqkuoQiXYWinIDdhSDDnAWBnDGC5WKhJhtmH3Ur4JukHc64MTk3d1K/TPelqARFh9ehcL3WDSA/M5xYLvh2rD4ZviC0z47sYSgMI3w44Z4RBXAnU3iWoMLm4JQvUJ0koTrvSoLTVygJJQat4nW+JPvJ79/VXTcCe0TuNrsTQMHS0CxfCoWH0u7lTtdFZ1rhGH3x4MKHOTBhQk2ICV3yUYHrRKc4IYPChpwecizqlOmXxrbxriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfkT+iZFPy6SithgCekb1JWFrGbSvSt3fgjnLOdz16w=;
 b=GpqfSFtNPGOX6Y8VED7s9TQIPwj/cqt1wkTMvxhLSxJDXZXIVcXHGK4eXM53KLcJeFE/aUHgUGj0UIOXOXU6GqGZh+JfKJTl5SQrGH5lXv6lmj+w2jmmNtuwx1vOsVjMW3Z3RbRteuYac28xrPKzlg3+Ms9GOnO19Hf/gqRp8OYqD8r/wcuvkj9yzfFxkHLL905NZIW8VXKDUlddgHypY01iVwEoSuTr0EXNKvUWkhCHMiiEJuP93lx3mtyUZnG331EfKxac1o01Ja9Lan8EIqPCe9NguhgNo6JnG4MpK119aouvePJpMe+zhN+XfFwRauQrq60qz5kxONg5il8AgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfkT+iZFPy6SithgCekb1JWFrGbSvSt3fgjnLOdz16w=;
 b=kx31xUhdFg5lLl53tRi96N7l0JRi1yT2XJot2qJiFIHc6RNdVqlB932QIKHH4ovp4apU5KrOez8pVNqBkEHQjUwkT4wwiW0fH6wfCQFY3ItbRvsbfDaCvnKioutbiPhaYUi2Ec7g0B3RdBrV7/wSYkuVPJ8926NhRZw7Wt2o/jA=
Received: from BN0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:141::20)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 2 Sep
 2026 02:17:51 +0000
Received: from BN5PEPF0004698D.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::61) by BN0PR07CA0005.outlook.office365.com
 (2603:10b6:408:141::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 02:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF0004698D.mail.protection.outlook.com (10.167.245.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 02:17:47 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 21:17:45 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: reprogram MCA settings after reset
Date: Wed, 2 Sep 2026 10:16:43 +0800
Message-ID: <20260902021643.323037-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698D:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e8a8a0-5612-4cc2-57e8-08df089861ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|6133799003|10086099003|10067099003|56012099006|11063799006|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info: TvySGTVlnG35utixdF9PyQdvOAZqU1HfU/DnCFmWDZUaESdXaPva7IInQoN5x+BQUVmd8S8K5dCiPCA2x6aHdVYQz5JHkj5dlGZlXrtXZfAg27S4YzTbFhqLlAMxW6kSqdvg1wbE/pKk8pB/PIK6YXGa9rYdAu70FpUGWLMSz/4O6G8umKTwigDa+kKpTWLIavyKUw3bwCbj5mJZTEv/CPnWjAacXgFyXKRTM+TV/wpTqWlug2UmFu5+NfudMdqYWUKzkd/KyVveOi/shn3+kPbd9bEXFH35Wl9B7xPPH40WGQdHF1W0nIMjk4dnDbc1+KIH7y4aTHFv9OVACCtHkjnSce/7tHQm9TKYGG7dCOCBC74LqXdHuANyo+I0ujk7Oc+JGuX9hHqwoCoEuMtkkHoqsRRGFFgYHL8O/0xgp6QNI6vO+ChpLHcV9FWk9Rn7R9UX1DDludb+HvNQORZuSJXVf2zTESP2mnByi/IuyGc9JwmtrMJPfxtyNHSvm2fY4SgNAFQoFKfBbN8iBJzwmpXi2BUtAPU63Qg6YEKBrjj2AV/73IwiRI9qgcDZelSAvKV45SDCK5epeO/E0l8Yz/c1920tqbemvXVM9LaLgu84tLU901eipS1rhoRFV+M1ejjtpAjX8vWCLaat3gTZsE0TVyhWUFS90Rxbk5F40o2LNjf70Y/FTkvjK4Y5JN3GExt3a9hn97jm8zFbjpV1IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(10086099003)(10067099003)(56012099006)(11063799006)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yjEhQE+ZiboTvTUUTqagJ+s+8LSUC3mjOgwZveL+EnQKJaloZum9oNmlN12E7JnC0RlRK5c5/7SVUz/3AATUWy0ZN4Zt9W4g1CuMQHqt7lkb1/u07fdDuxggH0atxKW2zt3KpZBAALvn9K7o0o55BUkkyBMMjerPYOT4P0WMq92HQkRHEr4AGu44EPYyf2gGaVoWDGEIybakddJXzYOQYLT4E0BZSl11IM67vORqswcJgW5XEFZxZrbSW4LOrrASb9+LjGg9DdO7RI/W/lVI2ZoVGGW4ZtPzbAuUdIa9RO+SyyxGwUwkrnkdzSbOI/GT89P8p0jkMi6PFwzBWMBF3PGWOBlw4739C5p5S4KsGLBBHUom7SFWANevjRNdhRZkvMcSq0Pz3/nP2YtaTQRpe8CKlrjgS4WcA0dJyEZavVqh6FlMw81Ky66CagGVJwxt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:17:47.6210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e8a8a0-5612-4cc2-57e8-08df089861ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

When the driver is loaded on a device that still needs a hive reset,
the RAS IP hw_init is deferred to amdgpu_ras_mgr_resume_after_reset().
The MCA configuration is sent to PMFW from amdgpu_ras_late_init(),
which runs during the reset while RAS is not ready yet, so the request
is dropped and CE polling stays disabled. Correctable errors are then
never harvested and only show up on the next driver load.

Re-apply the current debug mode once hw_init has completed.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..f550e83f2b96 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -483,6 +483,7 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	struct amdgpu_ip_block *ip_block;
+	int ret;
 
 	if (!con || !con->uniras_enabled)
 		return 0;
@@ -497,7 +498,12 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev)
 	if (!ip_block)
 		return -EINVAL;
 
-	return amdgpu_ras_mgr_hw_init(ip_block);
+	ret = amdgpu_ras_mgr_hw_init(ip_block);
+	if (ret)
+		return ret;
+
+	/* amdgpu_ras_late_init() runs before RAS is ready on this path */
+	return amdgpu_ras_mgr_set_debug_mode(adev, ras_mgr->is_debug_mode);
 }
 
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)
-- 
2.34.1

