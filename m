Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1689FA1FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3489D10EA50;
	Wed, 22 Apr 2026 21:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qQVBPhvG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416E910EA50
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd827lkEwWH7q+hHpOBgInZHRx9FhAdFfoWLI1FNUEDWFqSJG2jw9gp9ljfzYy4xyLJ6tVgaym3WFlb8JhmOrdtWMFxgRTYXVQKuzR86oOTW99p5xN1VbUNpB6wgKCSKmGWOAmk6HII26lXznAhKcENyXyLy5Fv39G5IGqRatNUsWwHt8RXiqgUey9grsijZD22rJ4AVMfjubLeQGo54b8mXdT0FvBT7T4WHn1WHIlZw/Cbhsmh8O/Osp3Lu4fKpZVekJm5xDoXrIr3E8ynbTkSixA7NuhbU2fitRSZDshokwStJbUSE9N6Ff0B1VN4ZNjXOJKww7xPIcg/Bj+PnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h92w6BsiD/ZUB+oJMANAnwFlkgUm2y8WC0eUjKnr8z8=;
 b=dKkt5gEKd7BH9QXoSUXkVBo7cRw3+y9sVUQGzDNx7jzktR9ojoxEuY6SG4dZkmC6j00Qa8VxBoAdyeQtcMa/xLTY55Y0I8hyHKO3eH1Cmha5ZprttEr8LFWnekgrQiUNB62tLKRDV1h61Qc06z0bOQkgh0+YAyQskOnChuxtHkfpsOj74ASzqlS2RkK5tMAzdvhHi8ZAobxDKMRm6mH0cmlu3fEPlAOYIbC2aWA4BsKXW1+7XTCaRuPlT1xA1rdjpaL5XWSCn33T7S89xljAuC4Ad2J1KlZ2IbJr/efDu0RC9ZuDtX0J2CSFCInBTDIzcE0EAAfPM7mf0tGk6Q1Oow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h92w6BsiD/ZUB+oJMANAnwFlkgUm2y8WC0eUjKnr8z8=;
 b=qQVBPhvGrHa8Vr+s8TBtffREh54BG8FoUBpgV07Xd6aZ2/fkzsW+wQdp64heuyb+htM0DO4vghrJ/jbSCyELpkGb8SnSxUZFxE/FTGSfBJExtovXF5KHlWL1BCK3uMy2KgC78fZfpRaKaYUIFrwY8KQU63VRnzmFwudNqkcrWvU=
Received: from BL1PR13CA0302.namprd13.prod.outlook.com (2603:10b6:208:2c1::7)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 21:42:24 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a9) by BL1PR13CA0302.outlook.office365.com
 (2603:10b6:208:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Wed,
 22 Apr 2026 21:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:42:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:42:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:42:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:42:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: support nbio v6_3_2
Date: Wed, 22 Apr 2026 17:42:07 -0400
Message-ID: <20260422214207.2241171-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422214207.2241171-1-alexander.deucher@amd.com>
References: <20260422214207.2241171-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e32fab6-eff5-4b76-fbb8-08dea0b80a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PjNAicJmVpsNbMlsP1l3XmDeIx2g83iVw8RNIx2H89fY11bcpqXAuz1M4UE8pbm9L8GSHIHm1wvMN+iXAo5o8dCAwL+4XCNEXNbEnGCpm1jU8wECzCzPv4vP98+Cawv8V6eTlq0Bj5CEPQ5owdN1YwUbh8ikT3UWc5k31fnR9+DU9882Nyeeh3VeCsAsUecNUkIFEww/KZpnVTqa+5SAdP2GcqWFWpA61vOJucoB7LerjO1PyaXJQ9dO61DbMIVpszVncRzaFrljidgaRXQijFLzpQiR9OQKJY+AdBxzZ5f2WoVPUqiG0hUJkMvYDSROkR0V3y9kF7dFOm2ayEq2JhQCWZ3QV9Hm2FYYaApP+X23ZuRCnXsCGNl4SkCoZV2xkmE0qcqOskAjxyepyc3FNCbLjv03NpCr/fqHeT9WQJqokpfUwO79PT4dmRKhVrFd+vLEBq9rKrm+0Koip9n7bbcXiMRUeNcp1trh0uSc9dyLDChUgDcfQ1PugpiExMPEbzlra0gVwY2k/uFGG7dDsVxBE+RlEPm46yHMGC76j5DRzEUU38GhvdB7GjrCOT4DljrMeVb4bRIpTfbVBw2NIJI3k2C05MuSyYssR8fZ4OLS99j3uM7nCcl2MLtnYsKGHMYpukuIIQ3mVluw1NMAf0jk6Juxv2EdSIqyE+8rmEHdEAqLGki74DCFd+hAWFfgloZWrolfIojqASeEiLwS/zAqnlLWYtSGDfz7GLtuk5rXXEEnmCoFmEVMvvkkmwkhuvtQtHfzu9qx5WKo3zwBvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UZ5MWmYIobWz/TeXvEpzrCmAf3d3Q0QPrzdVlVmxyyJ/WNENdDVfeZEEYWcBxjaf6isgWreB7cunnHhBl2c7boZvNSZySjoNihzaf6Yi9UdkyC5jhtxQBejRzzR1LZlnFCoMHXtTz0dlyvY+UR82BgB2f4dk39TuR+Bkkoq84KZ7SNKr9dZeZ68HuwvbsrC4gsoIFrtySVVLMlcmMLzKehPad85hqfALctPwR091OWfcsdJFJqRZiJY4+mQ1GbYddCKZNzJFQlkM7DKvrxrZRaSdQ1nBTlt5lf4nGZg8yyW3heMwM0TyXwiwboUDRmFqAFCoSiWJe0bCGqAK+zml3/IJOz7vOG9rrSdha4+zcriuvKrfaeQmRC6q3ymkah0wZn/CYFeSNP0K9X1unz1lnTlP53ffjlyVstVlOID2ApyQCGJk7tweIkFceaACEJvS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:42:23.6257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e32fab6-eff5-4b76-fbb8-08dea0b80a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
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

From: Likun Gao <Likun.Gao@amd.com>

Support NBIO version 6.3.2 related function.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 31d85606d31b5..193091583847b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -64,6 +64,7 @@
 #include "nbio_v7_2.h"
 #include "nbio_v7_7.h"
 #include "nbif_v6_3_1.h"
+#include "nbio_v6_3_2.h"
 #include "hdp_v5_0.h"
 #include "hdp_v5_2.h"
 #include "hdp_v6_0.h"
@@ -3196,6 +3197,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbif_v6_3_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbif_v6_3_1_hdp_flush_reg;
 		break;
+	case IP_VERSION(6, 3, 2):
+		adev->nbio.funcs = &nbio_v6_3_2_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.53.0

