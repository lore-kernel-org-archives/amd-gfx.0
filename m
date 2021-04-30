Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC5C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 06:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAE36140C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 06:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAE36140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D496E49D;
	Fri, 30 Apr 2021 06:52:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DC06E49A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 06:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxQo5rSvHY76dwET0TyrqvcIM3K7F2WL2qE1fxkAtnvPMf8KAxyf7PbNk6JYWakP+fM5EZBP6S9k6/KIjMA1l/SDvWizuwOg3uKU2DsBDvQ2y2L2L9iLPazskokPsofS6+llnNz39vYDZBeF/aYkd831Guu8rIyMmNpO5ttP4yWVHi3OIRF0Z/MinkaSFZap78zksEeWN0W0hfYC/gBgpFRKSkjeK+HU6Ua3nXXMQvIHnYmA9GV6woSHSf1ohe6Ep0tfnf8eB6lffzVDeMWRMk9bBUihhf2ZehZC07S/3V5xuQu0MLa+OanxxVasPe8zFRQomrKvRfxBJJR1Oy0UTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5pCEWc5eIJk18NDxiMXXezK/HaoVtA3l94WInBfyso=;
 b=gP6wdh6F1Up7HkaHu9S41Wcmpdul5sGenjatc5dwJUKkG/OzVDPbcDjEJEjbaNhKxlIxhV9Pg6rKiSwgVm070mxmkePFYDnGme79UNizWOvmKbimSWJEui03z0Bf49ogZou4iR/SeiP8cP8RJLd9Ye9vy5Z3rew96wHY8GoEZvS9xS1b32GhmtsEgPIwfe2UGZmStZU4XELhf55RzWga4UuCU33ppH8k1p56j3gcDCzUZAow6hKqcp7fiGDBZ74X6CyaAMqNdHyB1vaRMJhzvJ6XzEDxe7BpAjI5FCp2QJmff/4x9yjCYqO5v55kV9kvP5pnGHvC4zkmEF6+4C1JOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5pCEWc5eIJk18NDxiMXXezK/HaoVtA3l94WInBfyso=;
 b=eeTRRvdYt8vSIAPUdgyuvbYGXbWA7sQGq32Pw9rAfjOYvO6zI3kUToFjk+MSXTfekDsmDHrqbBssXfDZMbMvyLdrw2rnbBym8H9tZtWgUdSP4FZ8b6KZAhrMtCOPTYhiKqoVRmapieHgXQq6vrlNrmgHRyLfYStyUNzVxgJr8r8=
Received: from MWHPR21CA0069.namprd21.prod.outlook.com (2603:10b6:300:db::31)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 06:52:07 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::ad) by MWHPR21CA0069.outlook.office365.com
 (2603:10b6:300:db::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.1 via Frontend
 Transport; Fri, 30 Apr 2021 06:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 06:52:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 30 Apr
 2021 01:52:05 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 30 Apr 2021 01:52:04 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: force enable gfx ras for vega20 ws
Date: Fri, 30 Apr 2021 14:52:02 +0800
Message-ID: <20210430065202.18115-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ad68420-1647-46ad-d604-08d90ba4781a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4158:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4158D03BDC13399977F128859A5E9@MN2PR12MB4158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbbjy/57VJwnsZDqbF9zkVl/eUv5MWoZT/T57vYySBmKUmU89AHChOfWZdH8vTKgWNyqATG2BGBkzOzwyQPhUV2fCgNmIGFHHohYD1S9+mX1ZFnDG5lARaX5ouN3WhvxT8TaBedPh2fSA5Byko+JihXhbO1o2e3iNOYeHwouM0zt8XNtOY+jonzV5EiD2hhMubMNIBYiArjdQqeN/JI0ggT5oOhH268y1CG3Gnb603eosVYwf6VjoGL9BNkj4PBcW2kP0olDM2qqWr0iz4c7bEIpRd/p63K0dNyEl996vNYpOgWsQLnkRhuzFpRH3olKGE2zHSTmm/ORakjyXV8mnywD44IECyFNM71k/dF84Jg8mSfG8cscQYcxU38Dti7jNyNNelSAIUWemrEsPKxBwvuyy+GIhqwiZ+QIy2O6QvSisZzwNTCH+LNuFNMwdpT2537uUgUPD114JTaMY3f2pwhCpB4LcZg8JHgMc9PSqllpXx2vw/b4pq7Fi6nehzI9BkCPVkaIKSB7QvTgDGstw+CiOPSTqMn0sT3rDDzwdp5UzmCULMJSqRX9d+U8kC0qX6CsvIznqUppjeqWgN2hlRfVcuJ5XA01/8b7EWcSder6UXZZwekw64Q74T6sIk9IujKsJk3eEWdC5Gs6pOifnTvg6kbt+59ZG0BbWZIass1Gaj3ZrP+3umUm0ncfbnWG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(346002)(136003)(376002)(36840700001)(46966006)(316002)(26005)(426003)(2616005)(8936002)(336012)(110136005)(86362001)(36860700001)(186003)(1076003)(83380400001)(81166007)(47076005)(5660300002)(70586007)(2906002)(70206006)(6636002)(8676002)(82310400003)(4326008)(7696005)(36756003)(356005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 06:52:06.5543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad68420-1647-46ad-d604-08d90ba4781a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index daf63a4c1fff..dfeaa57dd7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -34,6 +34,7 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <asm/mce.h>
+#include "atom.h"
 
 static const char *RAS_FS_NAME = "ras";
 
@@ -2070,6 +2071,25 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		adev->asic_type == CHIP_SIENNA_CICHLID;
 }
 
+/*
+ * this is workaround for vega20 workstation sku,
+ * force enable gfx ras, ignore vbios gfx ras flag
+ * due to GC EDC can not write
+ */
+static void amdgpu_ras_get_quirks(struct amdgpu_device *adev,
+		uint32_t *hw_supported)
+{
+	struct atom_context *ctx = adev->mode_info.atom_context;
+
+	if (!ctx)
+		return;
+
+	if (adev->asic_type == CHIP_VEGA20 &&
+			strnstr(ctx->vbios_version, "D16406",
+					sizeof(ctx->vbios_version)))
+			*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX);
+}
+
 /*
  * check hardware's ras ability which will be saved in hw_supported.
  * if hardware does not support ras, we can skip some ras initializtion and
@@ -2112,6 +2132,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 				1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
+	amdgpu_ras_get_quirks(adev, hw_supported);
+
 	/* hw_supported needs to be aligned with RAS block mask. */
 	*hw_supported &= AMDGPU_RAS_BLOCK_MASK;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
