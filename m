Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E335AC77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B371710EFD9;
	Thu, 30 Mar 2023 19:32:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D299B10EFD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkdmAI/i8DYEuA/DEeC+zFgtWPUtlBKF0V3ZVz4AvGTljeVfI+jswEUvkbYMXhnnXh34ieuOqh/syLc98vc/1Ejwnf7APZcUl7dI/4oYKFAWZFUR0qFTDn4Le7iayLqJbXXulxf9aJEpMdnUIFSZfGziKdWsc0oUlTft3MrguiKIDJ32MFCb62E1mV6LPBJOD1ifiiew6Pu5mu4EgqfbfP9TIynFjSqaelD6iiX/FIm54NR5h41u70iiijpXV69uxbhAO5Zla3gVHp0u51Xfcr63tc49u96q8vCipMSQAwZiBE2IpeqPw36159inj3blZq9TzBmPVCXXrh7j3Lj/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBISa6EaZEUiGTFgkZBBFw16qRtLOzFh+/jdEdB1zWI=;
 b=Ul5/SxY2kClmyQLm56f0sJ1lDnl+M8qUOBmtesJhN9oKyLQIwGgDmoof64GrrvSn9Em1aYZCdBX1taLKigJobpWECqdsLPg41USfuYuBIrdjOBId1vWQKFUTKA5LkQ5oAt9gh5eYBY2Q0mTnVHRRzEMx9HxbM8xCU07kL0GxsgHVO9Oyxn8/+0yKQuSyc1lmPWyCvV2RWdmN2m9eu8nt/23jgyfymQSpaIly1Xq5BqRYMn1u0c2odhuhPdhFS8S3G53wNvNZa+akGrebcVZsD+2eDkBDZBe0QXxVpGiiBQl1qUQQtTAzIWHH9cSB8JBk/4zxsEe1jwkfmCQ4hEchCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBISa6EaZEUiGTFgkZBBFw16qRtLOzFh+/jdEdB1zWI=;
 b=2/kWKUpkF8kNkq4OJgtLZ9Ps0z3nrMVjnIWPITJhGT9Bp4Mb8HJkSPtYqKB/2gWieHhBampKSt9kYlgy0oP6qI6+xOEszJ1bTPbGXvPuRQ17tsjKFLHWxoClA4bvb2/jWzVEzvnJHK4JAQtnuvplrxSV9hPaZgxEeLsnweu++kg=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:32:24 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::12) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amdgpu: Add XCP functions for GFX v9.4.3
Date: Thu, 30 Mar 2023 15:31:57 -0400
Message-ID: <20230330193158.1134802-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bd0a65-9c53-4138-6d7b-08db31557d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKhhUnt3+ut6DRcU7SwDmZ0UURT1rvfmqqXXG2pC4ucJ7dZx4SQd3T6cEA+nvXsg9QEXkN9VkvCCaq9n46XnrPYt5WOFekeAOtJctye5Ifg8hbzPB+zyhglWFC4NRK6LnBTOPcH9+brjz36e59HleWg3qg9r1Ikkse/IO0k3+S+uxaqDur3A6HreHivFNSV0FuAraXLebXqld2uqXwuLvIZ0iHrjZ848v+k6BBDFaPjQgoN3/kdaGao7i34VhGW8vB05+P3/LWGWqpZdthXiJ/zpemdf9ht1shKqyJnEmM8CgltGQZ2Xics1NNKPqqE6s8HGUfcruoOLWjItXTQo8Zpf/JnDJ7lt9MQvoHHfBbXzlmiJjhyEiHsS5MF+s3M/r/SseBo9x4iz2qodoRqMBStReucy9rsLk+9pKkV8onIEBK36P5MmEqpEzHmdhfaQWb14Ov9vCLpRkTy2e2B961hzJIoWIwlHnnSu3ZJfWzKbR6ix4G+LOrgRpED6Dckvlsr65kku1Teh4EwcWJXSQCeg4LJiI0i8b5mLZ9pGD7Q//G+NsLyubNd1cR0Gu8S9/iDHM/irN+tjga6ruKgskGiiP8pxk0LSBofEZCsd0X+XF2+YFnVVrxgkGijjna2uhnpQNh800WkqTQKC7NuQszfyjGTPw3hZF5SQTEUjNSrS26CFVYJTkOw6tJlq9JcLZLKl9BHM4NW61hRBhey86ivC5iReHqNclVbFbwE4458=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(6916009)(478600001)(2616005)(83380400001)(426003)(336012)(40460700003)(8936002)(5660300002)(6666004)(54906003)(41300700001)(36756003)(70206006)(8676002)(4326008)(316002)(86362001)(70586007)(7696005)(81166007)(82310400005)(1076003)(356005)(40480700001)(47076005)(26005)(186003)(82740400003)(36860700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:24.5091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bd0a65-9c53-4138-6d7b-08db31557d33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add functions to suspend/resume GFX instances belonging to an XCP.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index eac6faf7e1da..3bda7470b7ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -23,6 +23,7 @@
 #include <linux/firmware.h>
 
 #include "amdgpu.h"
+#include "amdgpu_xcp.h"
 #include "amdgpu_gfx.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -3184,3 +3185,49 @@ const struct amdgpu_ip_block_version gfx_v9_4_3_ip_block =
 	.rev = 0,
 	.funcs = &gfx_v9_4_3_ip_funcs,
 };
+
+static int gfx_v9_4_3_xcp_resume(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t tmp_mask;
+	int i, r;
+
+	/* TODO : Initialize golden regs */
+	/* gfx_v9_4_3_init_golden_registers(adev); */
+
+	tmp_mask = inst_mask;
+	for_each_inst(i, tmp_mask)
+		gfx_v9_4_3_xcc_constants_init(adev, i);
+
+	tmp_mask = inst_mask;
+	for_each_inst(i, tmp_mask) {
+		r = gfx_v9_4_3_xcc_rlc_resume(adev, i);
+		if (r)
+			return r;
+	}
+
+	tmp_mask = inst_mask;
+	for_each_inst(i, tmp_mask) {
+		r = gfx_v9_4_3_xcc_cp_resume(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static int gfx_v9_4_3_xcp_suspend(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
+
+	for_each_inst(i, inst_mask)
+		gfx_v9_4_3_xcc_fini(adev, i);
+
+	return 0;
+}
+
+struct amdgpu_xcp_ip_funcs gfx_v9_4_3_xcp_funcs = {
+	.suspend = &gfx_v9_4_3_xcp_suspend,
+	.resume = &gfx_v9_4_3_xcp_resume
+};
-- 
2.39.2

