Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33E9C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB5310F2BF;
	Mon,  2 May 2022 19:08:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E18B10F231
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH0+XLpIs0yxyNQ5bx0tUz1y6+aHgoxVGjHiVYMRNbIK2GJidXGd/WlFpPrkHA2Qf0JOQC1A3y997LcjejfD7ebiAV7Y5Y5AS5pFRY9WsxAzshRkldJHu0AbmpbuA73ffzGBbXgZ0kXuJDh9RiGgace8vK08FQxneIeP/l1nj29K77X15LWfpfu3TinRu+ZEEKnLtPo6Qwe9EUA1Qsn9ZWrO0QmUBJ9qUDgi+8r2SFptXLPZ9odo5Od/4KeX9d3fNxVGyOfsH+sjzwKcRLkgtxQYpq5IlHp17rilcw0ePOGfWcW6Ad1vttYIiLs+DgLi2MfgMcd/D42xZ8dglIDjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fINs/5MssDwk0Ev+Y1nybshXCs0mb3UERmf1atVK3QI=;
 b=QI/hRkt6FU/luntXztr6OZg8kKic/mlFGk1yO61x/V//tyslXKOph0SZ5fW3GAuXgd5qdqj1mIbXiubARxQPFYWFn1qaFZHqL45N5ItYwjIzZ1BwNz946vf54llLOFsKPGoSgUOcIgFAZEO5hlCNwKHZsSh4J3iqTxLhaBo1sFmNtl6yf+JuAz+62tfXpyA7Sc3iSY8uOq40DtWep+h6dmOTgz9W5/6dyYFpSurVq/3Wz6FYwd5uyTf7fy3kurfyCAR2muZQPIEfduPyYMK5664OpdCpS98BrJbbUUVqtwwiLqKp3KkOW1KbMOHPV7ry8vItz4FuQhL/codLyxcALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fINs/5MssDwk0Ev+Y1nybshXCs0mb3UERmf1atVK3QI=;
 b=yHF0akVMuL6JpcmZ52WkXJ206DwW8zRgWrQW+NVAZBihQjXVp1vqNH3wAXPAXb21Uj4ZoAR9FVVze3lZkg9CX786gak3SS2q6HojORKllRbzFtFM7hoRFZra3IPE7D8nb97Kc5Hd+xBiRLGK89YrxlZmPKmJtByI7aLCdAxFCmo=
Received: from MW4PR03CA0038.namprd03.prod.outlook.com (2603:10b6:303:8e::13)
 by DM6PR12MB3228.namprd12.prod.outlook.com (2603:10b6:5:18c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 19:08:25 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::38) by MW4PR03CA0038.outlook.office365.com
 (2603:10b6:303:8e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 19:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amdgpu/discovery: add VCN 4.0 Support
Date: Mon, 2 May 2022 15:08:04 -0400
Message-ID: <20220502190804.784271-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190804.784271-1-alexander.deucher@amd.com>
References: <20220502190804.784271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d449ae33-636d-4135-b56d-08da2c6f222c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3228:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3228B6574B6695A96CDD0558F7C19@DM6PR12MB3228.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYhtZFCZH6X/jt670KNq3uG3D771d8liv9jlCmvJumDjnG2cC+fOqMro7q19nowHV1lcyEytGj0jNO4aMW4kQAWNMaS1GQDs6EDbBNN9s8wG87wnUG9hp6LMOi6I55e30EwONNO/Xet6grRdBkR9PElF1v/IVKfUm8LE8KxMDfbO2Ew7TVlmhCcDeQ4WDEvfEyTi+nNnroTcuuGK4YqKJqvDvSk+5CEWj2ASnF/DcOg7ZHCmuqc1XUzBGvbn8Z8PwQzan/rrn9L4wCnKwonY54CtlwazpHwoC83sdbCcYM4VCIFvw+xKiDgj6Qy1shGTeqBHJZwUwugv/hvMAqdDLOFGnYTBLEZ2d1QF62ksu55JZrdvf8WrG5NyLkFmLnqJR8GwP+xdRmGaTuNkinHbZlXr4TK+FwXU5n7zzlP/jkfsGGVV3ceKcFtKLgALf6TBe2sgjMseJCOmwfx9P+6/b78xYLX3wGsCViKBGfXyRvDKGUbabGJqjTA1NsNGygTk/iMbx/6po9yq0FrNwtcyhp5si/XYf8KYOSP3QCrlAcke6upYkLfCYGdWJA/3A9MKiYIbtJ6TKZuNpldO4b7QvDXrlHdouMnlIKtMTK8rDrasDg8Fm8GnM8RvpRYy4BK54HnyGHN+otAJxpZVRBYnbujHoop2TplXuMb0RzOvNGnHtI46SsmRp/fK8LWxu3Q3hZvxrTCE24Y/K1L3Ar6mLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(81166007)(4326008)(83380400001)(8676002)(70206006)(70586007)(82310400005)(508600001)(336012)(47076005)(16526019)(186003)(426003)(26005)(2616005)(7696005)(1076003)(316002)(36756003)(86362001)(6666004)(40460700003)(2906002)(5660300002)(54906003)(6916009)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:25.0819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d449ae33-636d-4135-b56d-08da2c6f222c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3228
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable VCN 4.0 on asics where it is present.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index aa5f31ad8bc7..0e0382a82b22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -68,6 +68,8 @@
 #include "jpeg_v2_0.h"
 #include "vcn_v3_0.h"
 #include "jpeg_v3_0.h"
+#include "vcn_v4_0.h"
+#include "jpeg_v4_0.h"
 #include "amdgpu_vkms.h"
 #include "mes_v10_1.h"
 #include "mes_v11_0.h"
@@ -1853,6 +1855,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 33):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			break;
+		case IP_VERSION(4, 0, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
+			break;
 		default:
 			dev_err(adev->dev,
 				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
-- 
2.35.1

