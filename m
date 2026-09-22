Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90995C982FF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2284410EC1D;
	Tue, 22 Sep 2026 09:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2D+x3Jrt";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980B610EC1D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2AsO49fd2+lOujm0ZlLfqEiOj2qCvoxI5gLEurMUIyXgl1WYjjo5G6No5MnrixVtsyC6IdFv1z7AggJDfzXJ+AgEQlaca4/e+HjlwUGByfLzkLpW8VjVcQRG1PnbpnS+WuDgt/pbTi22KfjfzJnc/KTk+anuWl/E8j5VxsgsEJrKyQiH2Lx1ZK2BhWrUgRXS8SSflnQbfoE02PjBhPXowmZWvx+DQXFlFM+hu/Xlq+L8DF4xkNjw3ZHTMYav/Pjw74L66yI3pAaJyOxOscfyPuDvxlL1wX7mQZb7jgja/FC66tw5wqH6yWSbNSip+9fl6XYGRDyqybz1TKdH/qXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8i4s87OGahbWZ8Oau3BEV5wSQXchJgHyQnwVlnhYig=;
 b=nefEv41kaXY4KhJMYg/Kr3W0L3aU7Q1U2zM30j2VNRBF/stJqxo0oDDjjK5y7RvR5/aADgdpzzeWdEWHd2OoKfz3G1Jd9Dsx5Nwxo3PatzgmQVrU8447S00UVj03txys7lSinS4IbNK7CehTyifgcd6QTgCIC2yAhPo7uL22rtFXttRL3gOue8xHT22LWYeLhcPUdTM7vWzU+iv7JnTpHmkmfSLCfWqn5ROcWs1cWkLEozw2T62VbgX/JcKSa22abeXKM0WsN7B8VsN80OOS0Tzk0lYGhdQ5aqPAe8we2GdUjTgZqE6A8yYCVlnXSPlGqIIOPFjBsGHYGZw1C+YPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8i4s87OGahbWZ8Oau3BEV5wSQXchJgHyQnwVlnhYig=;
 b=2D+x3JrtqWPFog/Z790bLefqS2UKtqgrYXgsIDqYasJ4uUBFOVyE/ked6ONZ0AnwbYo53xTRoZ6QSKkA1SYUw7H6tOqi2ebmkknb7TtB3xsLHJDsKRpv4+p4j6ZoY2NCDKKF4Mw6j51pww0kLLwvInkJhurYaigM8RrTKJbMjuI=
Received: from BN0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:e4::25)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 09:34:24 +0000
Received: from BN7PEPF00000096.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::53) by BN0PR02CA0020.outlook.office365.com
 (2603:10b6:408:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 09:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000096.mail.protection.outlook.com (10.167.245.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:23 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:21 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 08/10] drm/amdgpu: GFX12.1: set mqd->perfcount from mqd_prop
Date: Tue, 22 Sep 2026 17:34:34 +0800
Message-ID: <20260922093436.596947-9-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000096:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d7fcd7-812f-43ae-2183-08df188cb01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: H4QPpc3xwGFY25TaVE+3YLTBcmZzB65WkZ2AHg7B/w/TSvkFtpb8pe04EXC5cB9vXy6IPDru3ZxXdtgzVUGmFzAPkV0CWq/4KYjTdcn0+vGYjDce0s/17cEMW0I5sQnciQONVOCoHLBzKpEdYN0DqtP1LOgRO0/inGkw01TtXQUldc+lMmqITa56B/bq1/3RxN4FPwLo7YIT6UbeyR3NjTHOCxp1zO7isgf8pmQgATRw8L9ZFSrQPPkmqw5aNK3WC7dg042QNYJ18Ar//x/2Ld7X2azQNL2eQzMZ1QmVHDpURcyeZ2msQIPdnv/+MSX0URDHOxIA4bNdI+tnulpIWPpddoP57G/wtPabOq4Fa5BVfAMbA/bbd9mdcikI7a4/ReMkbpayH/BMQiLb/dMQR4P0cdiXw9N8ZBhVB8nDptoQRZ4dtNF60RplUJQFo4Xmtb1909iKg/n8AYz4+EMvnSrrvdfoJDVORuwefOWk78d5yGM8RMcrRiB/IvafkNs+9x9I+TEuzwfK4bH1FKWXLWTZDZbacRrF5AHBnTXpBcsBwNeLSSeApP3C9Gx4htaIdJLFPSmp48D+gGdswUcSvJFCr+BJLUxeuhhxNI260xt1f3ayBtoGkixz5bi7FiXbKJ9Ba9b8TiCbcUKW4yuWpUgzHe963GG2UojIUXQe+9HNBFMXT+xv8wsN+9vZypgu4zLA+JLNyYpoQxG/xMQ+Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o08GRXk/S9WHRt17FwbxWNu/2uPPkMZFB0tmhD8AJpGBYhznZ5Cs2R45XBV4K87hzHYyTk4hkrV2W3MUx0e5mg7PlIGNo4GVzI3a9pPEv7Dw5Qj4WUo8IQy1tx7C9zxBBdlSv5Sq/MnI4DgiEEpCDxcTigbaEbTtATJFSmTFfnuJOE0FbtOmMJeVv7lH9rlkP3rOSXBHS5E2sj/lioABrlEwsdkn48264TJPanQAdJNVWnTlygSRpErSC+E/CDL1JWUk2i8Lk7w0GO2iRZKvniiRShwsUbmlWPhLTv3nKDH0ZNW3pMSVBPPo27/rWokoE9h3Cj6UuZPBCVlKRkXVV2u/JmJ061pdwlTnZs4Th4650249xtXhSejkl8Fb+TLjk1wlt+lhqfsFNZedpNQCUTMmnIi3lXmZb0IZQe49EqO5L8b1nu/QespXZUo6vmAj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:23.8500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d7fcd7-812f-43ae-2183-08df188cb01a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000096.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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

This commit implements amdgpu_mqd->set_mqd_perfcount
for GFX12.1, which helps setting mqd->compute_perfcount_enable
from amdgpu_mqd_prop->perfcount_enable.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b19a4956c222..ab70a77cfffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2170,6 +2170,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
@@ -2298,6 +2299,14 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static void gfx_v12_1_compute_mqd_set_perfcount(void *m,
+						struct amdgpu_mqd_prop *prop)
+{
+	struct v12_1_compute_mqd *mqd = m;
+
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
+}
+
 static int gfx_v12_1_xcc_kiq_init_register(struct amdgpu_ring *ring,
 					   int xcc_id)
 {
@@ -4041,6 +4050,8 @@ static void gfx_v12_1_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_1_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_1_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =
+		gfx_v12_1_compute_mqd_set_perfcount;
 }
 
 static void gfx_v12_1_set_user_cu_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.55.0

