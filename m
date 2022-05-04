Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383FEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 13:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C639810EA54;
	Wed,  4 May 2022 13:23:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A742410EA54
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 13:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHe/lx/nLxbgLKRLBCEvgA3Zjy8neQEAEtSwGKwGn1qv5yaH/i8i7aCa+hY7j35V1ZdofKYcWc4Tna03h16mCs9q1WfVhD8a5POO2QlIiuFsO+mhzVYQxmy6ARUcKPIDY7juf08/ABCXhwU3G7DnN13p7vGcOmeVJnADKctWhAq7IITL9fDQccaMfsX9PWpFt2Uy4LloL1N3Zbs1JshG5sl36En+32AFK+kKxNM2EtUQglirih8IaTzpdN2YY1DkUXMkk64QSWsOyDbN0+EeYHlwKEyZuD1V0U+4qfh2yoyvtL+ZJZLbTUjpuwYdawwQVn0qV/iWS3avhTElnPm6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D3ApcEhLk05EhJIp5q5TVaAz6/rd1Pmk53wA1hqUjQ=;
 b=Kfh3IT2v6HXN1Qi2AkF8im9DtPAcGQrDvXGlCIGEMbT5rWqj2VzRd080BDkCZ6DynxzriS3sh7p/5PQiuqCU1Vo2SNZoHMjDSyQzgWU4F25xqEo5UedtSo4uUWcs3gGlmX9ke4V2d2tag0CbdhcKgnL7KpD7rKxTiN0BRbS4IJqsK2yuu0QnrLQuSfSlOaK+SQdAhGKiBBjTTU/tdNBJbjJ3MurLp0xgCRz/BOEsq1S6R0nJ/Ld+iZZS97k2GHNMxKYr/JZdJAq4xb2T1yIOTjbwQ7lZPzV4juz0fwRjD0RxUjRjOi6x09nl5OdtLYNtCSf3mm+iAmh3QMQxNJsWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D3ApcEhLk05EhJIp5q5TVaAz6/rd1Pmk53wA1hqUjQ=;
 b=FC+kVgvFmBig4kyUEHbYHEYIEzYt4dG7osNBFnyDVGv3LYE269Vtqwg3a4Qt8l8bOaFItF8QW9HDiEY4I912cIh8VXCadcDru6/fDbE6SIXfF9hnP+SlCf6GNEgoFHz0cTKihEym8/X4KhQSJ78OhcyTENl47MsstKdHJNHGtLc=
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by BY5PR12MB4804.namprd12.prod.outlook.com (2603:10b6:a03:1b6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 13:23:44 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::1f) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Wed, 4 May 2022 13:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:23:44 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 08:23:41 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/vcn4: replace ip based software ring decode
 with common vcn software ring decode
Date: Wed, 4 May 2022 09:23:26 -0400
Message-ID: <20220504132326.629117-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504132326.629117-1-James.Zhu@amd.com>
References: <20220504132326.629117-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 255c7d62-d9ac-412b-4307-08da2dd15063
X-MS-TrafficTypeDiagnostic: BY5PR12MB4804:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48042C47145CA92E91D505E1E4C39@BY5PR12MB4804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkWFcQ2yOShhh6hYRgmgKyKfV/2gex8keLKWQ500mBdFWpTgrwhSS87X5+G5Y6cnMlz/qlmR9L0ZKyw52M/rPU1GKkoLvavMyA7w+h7SdOx1OxQszDFr/Jrh94cictlVx1+eDWBLCTkSgxG3FHxUigoS0i6tUKtgimU9wkW/Pm+2Lo22gxzTO5hEq0KxQefo/nMWdMb/ToV/dIV8oLKN3YFhYGDt294CT8aVy6mlUyy4G9J2FrfpKWHISgbwJZQTNYVS01YMjirhxmgrnsDdi1n08d2OiPa4C62cyrafBpQMNZW45hLnWYdibnk+azQ6B7TnTuXoHBVO72z2vD7L2t5ryLUIlExgT41sm7UuoBD9b2YZ/0WHWOynwWvlFGay4Knj+d29xYZYazB1UACVIK6I6Cq69UTPn/2xj/PtgJ7b9VVBIGqEgd2RXhc2rrvvPZw2x769rELqAwivrSnz4otvucVxYEBTr5fmDBt7jXFX2mOc/Q/i7rbB9lpsGlV8PWo9+8avsrQLVZ4ZuD5LKYL0RewvORk3dKtZ19vos509Cqgbd4bYQ+wSWWFd2lJTZAvuVKSa3DH3azJw7uy8TjODPTscp/6jg2RENtorRHvFHCdiRdGY2Ry922f5LexVr3tpOVKtLrl+JiQMFrqyL+eJQuPlW60ogLCvMceC+Drf5AzxvOOwYgXxNfixuDoAXTwwr+EZcj0okJjHwGxUPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(6916009)(36860700001)(2616005)(7696005)(83380400001)(426003)(186003)(16526019)(336012)(1076003)(47076005)(82310400005)(86362001)(70206006)(70586007)(8676002)(36756003)(2906002)(8936002)(40460700003)(5660300002)(81166007)(356005)(316002)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:23:44.4725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255c7d62-d9ac-412b-4307-08da2dd15063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4804
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

Replace ip based software ring decode with common vcn software ring decode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 652f8b4c0b09..27ff4deff4a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -29,7 +29,7 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
-#include "vcn_v3_0.h"
+#include "vcn_sw_ring.h"
 
 #include "vcn/vcn_4_0_0_offset.h"
 #include "vcn/vcn_4_0_0_sh_mask.h"
@@ -1490,22 +1490,22 @@ static const struct amdgpu_ring_funcs vcn_v4_0_dec_sw_ring_vm_funcs = {
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-		4 + /* vcn_v3_0_dec_sw_ring_emit_vm_flush */
-		5 + 5 + /* vcn_v3_0_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
-		1, /* vcn_v3_0_dec_sw_ring_insert_end */
-	.emit_ib_size = 5, /* vcn_v3_0_dec_sw_ring_emit_ib */
-	.emit_ib = vcn_v3_0_dec_sw_ring_emit_ib,
-	.emit_fence = vcn_v3_0_dec_sw_ring_emit_fence,
-	.emit_vm_flush = vcn_v3_0_dec_sw_ring_emit_vm_flush,
+		4 + /* vcn_dec_sw_ring_emit_vm_flush */
+		5 + 5 + /* vcn_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
+		1, /* vcn_dec_sw_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_dec_sw_ring_emit_ib */
+	.emit_ib = vcn_dec_sw_ring_emit_ib,
+	.emit_fence = vcn_dec_sw_ring_emit_fence,
+	.emit_vm_flush = vcn_dec_sw_ring_emit_vm_flush,
 	.test_ring = amdgpu_vcn_dec_sw_ring_test_ring,
 	.test_ib = amdgpu_vcn_dec_sw_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-	.insert_end = vcn_v3_0_dec_sw_ring_insert_end,
+	.insert_end = vcn_dec_sw_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v3_0_dec_sw_ring_emit_wreg,
-	.emit_reg_wait = vcn_v3_0_dec_sw_ring_emit_reg_wait,
+	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
+	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-- 
2.25.1

