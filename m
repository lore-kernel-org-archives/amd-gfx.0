Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36651C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C056610E4E6;
	Tue, 26 Apr 2022 18:53:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1105010E4E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGbBDXnXsaAT7FhSfBX82/olQGUDBl0Khv27s5e3EInl+2T1czgr2FLqhUlU0Uvk1gl20PqwcoNsIUP/LMaEJP/F2KYNQ7cevGwPGTeT2y/eHDRd0043oKoQxmDdmlTeXtIg3gxd0MREcQFhhrA8wp6ycwaEbe5zyItlm2DgoxgU400K+EKgIU4U6LaA27NDRa4oMv/91ECZldRgqXPLQ+Kk6AuQG2dYC7vRPccAtZfxCJYZMuxZm35FNZpjPWQQdX2JxqChBdY+vnC8WuBXBEVt1+tDI3zxCB3qEVIasEPS30dHUDkV7JghyYhgpxuocNYBxTtOUBilb9BOGlKJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkPgYLIz1xN7krg4gt/SkavnTdigSE3aEH+1Ys/digM=;
 b=cUAz87hw9S9yZyi46n+GZCsapZe4VEug5Ws944ic9y3cg3q7hC31+bqshTdwq32GrIF+qAkhm+0Tjxy6CfY38NU2JhwHoj20BkBUzFrbeqHMC41ch9GD3/hcdonapsw9v/zy8Up055qPS+13nhyE50TZSpQhvzFUkbUBrGW1km+QiHop2kHUQLcGM/AOK/gLEhCOB4oFpxcQN0Y0LZuTEqi+s/tboILGoPXQBZBeDDfuRp39yIFYzxa0YSL9920GkXJXv17sDqIYGRy73LPjc+5vGSK8xmUQuTCefNZoxgWX8bXBe9rnPuZFrb9qmg1nKbp8nQBv1Q/8IJmT18s+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkPgYLIz1xN7krg4gt/SkavnTdigSE3aEH+1Ys/digM=;
 b=squSFUxyCQGJjA8b7SwqnNpW99IjtOdA9HrMoN0ZiUQ8Ef3lttnf4NnGXDEiHvc2E6ERErrzaD3/vnyQtnroIiZ1KsMNGL/XPKBk3drbWQggk5jSrDPVZH4N1Fkjz0umXfTip+oGf3B+HoQ4a1M3Bya2HS5Xq3k10WkSGPDYuAU=
Received: from DM6PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:100::44)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 26 Apr
 2022 18:53:11 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::81) by DM6PR03CA0067.outlook.office365.com
 (2603:10b6:5:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:53:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:53:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: add new write field for soc21
Date: Tue, 26 Apr 2022 14:52:54 -0400
Message-ID: <20220426185255.3039590-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426185255.3039590-1-alexander.deucher@amd.com>
References: <20220426185255.3039590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8427f8f4-7dad-49dc-5ed6-08da27b60314
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6169:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6169083C8FE73D487D2A138BF7FB9@SJ1PR12MB6169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfPvsTgGnX8GjmDdZCkiPrQRCvU7Gicff21d64Bas/DwwdKWijSnFZapNa3hTPhh4/f8amTdyPbW5VbmdlQAUYQPB2Tm6An86sdgNbh5sVPaDZ9s12/gTqm/9fIT/q+xp6aT8FQfk98ohE74FdVfUwECx5FaOau3Gku8WuqCq/jeiMIj4pe+m/tR4Mat5yCetJKSNlKtSAIhwLPzPvR7Ab7rOLV+KwxbXHmT3xq2EGEe9pluXL6do37lZgAz7s6Os6Z6/7XRTESTNePt110YPPrQ4CJAolJFziUEQnUxhJKpFn3709ofuqmgWVFwlXB5GoUKgkcZHUgZXbarerRpuLAxqTql0QMaqRldQC2o0esVY1zUUNOmvx7bSei6Ct4m3XJSXcPfDh7f3+Kx4/pYTGlADnXlqXAXxNYx7vRH27rgnbkgAJwCus5fi07CZks6s6nan8F2cyf6Eo7yH4Marm9Zn0881E5G1Xs+ONRG0PzD4NzCVibhDqabsZSbYmMcFXY4WU3A6HX+zFlvy7dwTuUNPSbxPvcGI08tkEm8+zVe6jJzmKU3s3xSdKJV+cASuKWlYdzJzo54Dv+auERYT4TK2HBvuS7RYyLIMhyUXYzYjSK+pR5nHhSXfK5x5uPpWsRGRLYtGJEMEdxI7AnXOTRR2Ty4sDMKs+vbD6qsNF7re4sLOMfbfbJHVwzmzuac1gwVI4PqJObPRcAsKzmqyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(40460700003)(86362001)(7696005)(6916009)(54906003)(8676002)(82310400005)(4326008)(36756003)(336012)(47076005)(426003)(16526019)(186003)(316002)(70586007)(2616005)(26005)(70206006)(81166007)(8936002)(2906002)(5660300002)(6666004)(508600001)(36860700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:53:11.4606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8427f8f4-7dad-49dc-5ed6-08da27b60314
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Stanley . Yang" <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

add new write field macro to handle soc21
registers with reg prefix

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index acce8c2e0328..9fefd403e14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -45,6 +45,14 @@
 				~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
 			      0, ip##_HWIP)
 
+#define WREG32_FIELD15_PREREG(ip, idx, reg_name, field, val)        \
+	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name,   \
+			(__RREG32_SOC15_RLC__( \
+					adev->reg_offset[ip##_HWIP][idx][reg##reg_name##_BASE_IDX] + reg##reg_name, \
+					0, ip##_HWIP) & \
+					~REG_FIELD_MASK(reg_name, field)) | (val) << REG_FIELD_SHIFT(reg_name, field), \
+			0, ip##_HWIP)
+
 #define RREG32_SOC15(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
 			 0, ip##_HWIP)
-- 
2.35.1

