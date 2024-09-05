Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6C6CE7A9F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 21:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED56010E957;
	Thu,  5 Sep 2024 21:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AA4obxmZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D4210E957
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 21:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am9HmrV9ogQLL8q80dGkvZkBKd9CfBjBXWifItFbLplbn4r9gBsNPRTveJPywIpAZxNAbgM0oL90T2Yrn7vx+XSJQfxkHnI657mgoUD9YKeozUY2EJbuLJ/LkS5z1kmOjd6mlCPAqW75A+S2RkBnOo159VMgsLnOdSHGBMdnOQEME2a5DjIIjwoezK7Gvqg85glN+sajZBIf1qigD5vmirbVOhIypr9lUNy943JjYV84sqO4Q1p1zqTt20SvLN7chv4kzeLAf+rUU4kNm5osm2DcqZm1XLX29t1R4Ln4jsTKDjFkSL+wwLDSZEmyxG4WPvpM2UyeTRETwlUgvJE3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkDpCm1ssyMAv08gCVGMw1+a/M3Z/8BvqMvOGa39bV8=;
 b=Wvdq0nDyLHHBxCDvCQOpqcibTpUNv82b4wchS00ttHM8vOTM63M7Cl/joznHeFCTy09NHHy38fRwhWfDAvQPP6qRu+/k/2H2kWlrCiU9HFBZwCnJ7NCbORPdLerIyzXt+9oE500FXq5NRMylk36MvoKi1rUlBfBdc/nqyXdNOq0K094bJ/Zs+FZRwcQFwBX9VuarWuXADLyJRfhSCVryAL/1fGDI8bEydJ/zvn3y8/1gJmaZBS2lOwDXjUMugkmZajEHzpj9WWH/TJYi6O0ZoKmLHGAxV6n7qzSKvZYfaWeX7sWLnh9jX6U3fEywPzehJEJtxXvOibT1iNbDcrqu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkDpCm1ssyMAv08gCVGMw1+a/M3Z/8BvqMvOGa39bV8=;
 b=AA4obxmZtTIgsddiZSb3nRnMT7mTmWWo3hYGid/XWdPLDMithfzZIFWe9KENl1pOMMzRJxO1nPWq+JpycKuEuv839QeFGPHog0N0OxlKC4Usx9h/fTggbcHyVRUvJudJgKizd3kRRiMsb6ewCeJ22v49+gpbusuGULmV7XZkBw0=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 21:40:28 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::31) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 21:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 21:40:28 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 16:40:27 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: apply command submission parser for JPEG
 v2+
Date: Thu, 5 Sep 2024 17:40:15 -0400
Message-ID: <20240905214016.501543-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 470a1540-bf68-4662-4144-08dccdf35c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZLvYjRay172fW6qO5jikZ/F0+s/kN/bEO8YMUv4eaFUoexBXZnpc1bcLCzw0?=
 =?us-ascii?Q?R/rZdbFw+ntE8noDgZUrclKwxhV4MlzmropDQeSyT7TuQETj+I8qsed3JcpV?=
 =?us-ascii?Q?1mwuBXFhQT+2RvrZcDZgmhwsHeMjC9DkU+eSjZ8PEAcO7LIh/eTYwzn8frMN?=
 =?us-ascii?Q?61pxFrRvIqYMZFLHcHbv5fsj7EpoLoQ2TI8dreuOF0d1bhC9/MYglGsEY6cJ?=
 =?us-ascii?Q?9DduRNA8xG2ghnvf4pjy0KK/reuWpRQSwDrZlug3c5ORGti728O1vfgGPTR2?=
 =?us-ascii?Q?+o0+3DN6plm3uFuKrb0Yn9cpBXSNaLsMLzdUw6XztgiZTiiuOZDclShKCwRl?=
 =?us-ascii?Q?M7J89dnWlUBLi9XbLcm0xf5KZ43TXyS79v1iVW3zLmpo7nwLMAHdy8+LOfVV?=
 =?us-ascii?Q?KsnxLcgpSauJsAB18D52Ic/dJodZiwlxalnzLyfvhBU7DuPlh1nduztxLAPe?=
 =?us-ascii?Q?95Hw4BtVnq8UYlZQ8UtK1DZ+USUuff0G/NKfZW8Y+MrXy3E9dFg4DXh2ZBGL?=
 =?us-ascii?Q?VFJhkuBwd5bS9aIavEMoNvFnF7MIM9bdWEilaZ9z91IY0ARmv78yQZwQT4Ua?=
 =?us-ascii?Q?5PyNzYvbqmlK7K+gWiOTwIVxpneexxwiMWJnxKXS4P8F0oycYjr/JuZ4M4ik?=
 =?us-ascii?Q?O3r/remhgX0f/rhypZKkzyMg1Az8pyzLw9jPcEnOfa6zYsIpwG/lfyM7Lg7B?=
 =?us-ascii?Q?/dvROyHZhjCC9EvJGn+BObu0XPOj66ofLh9B2xdcSlW0xHJtSFPADRtgMtLP?=
 =?us-ascii?Q?NlL0qQDBCCmGDNYTdbOjiBh6/bM1w0eGuTIZeXrLUsKtlrNIWxT3DAaZZd/L?=
 =?us-ascii?Q?v8Xc2GgWtQmDrHYAUpJ7iR7/jUD+HJ1Yi4L3M/R9ldRwoKBCsocG9B69iJPx?=
 =?us-ascii?Q?qHN3a4T4885XLsdD0G5vQKDSIN+kCxsS/MM08QWQavUDzHIL2x8HDTSeYzEP?=
 =?us-ascii?Q?Zin4tIHIgBwtb/zV5fu1PS8w9N5KcTI7Phqb8k2ZIow5ALmbtJnxLPB6uoJt?=
 =?us-ascii?Q?k9teIFPPCzh36ZAZvqdDHP5B3d56/p+P5pThQDYL66fl4d21qvnjCcTNR8xl?=
 =?us-ascii?Q?YWfHdRKdXiHggLYM+7lTQbYnaFFbcB0vR/pwxNqLSaJrJG5ynMQBvKo4STZW?=
 =?us-ascii?Q?3Jwy3K42VsNjWe3Nv6B0DKBJ6ji1lkqwmZgNcO3mtbk4iSUT/ZpUCoM9BpH8?=
 =?us-ascii?Q?cjyOjmINSjPmZ1WNwSdWXnLWDpKJbNG0SBwMFOj6ThnxDZxgl599Q1PjDR88?=
 =?us-ascii?Q?hLufdixxUUERWTlToO6fI4pj3LGdh2iL3EsWgsBk40z7OwQiaYupRDfDxOD7?=
 =?us-ascii?Q?cioXoIgYCB+Xtiy23VUP98o0dxMVpMfBG8/tOLSn9sPdL4JinPEc8Th3E8I0?=
 =?us-ascii?Q?pVSjUm9tqxvCu7k/L/Mra7BBrqAi8JmCeJ40lLEDGsc8VwJOHbh2Sidnq6Jq?=
 =?us-ascii?Q?EWe0s3Xq5jpG0DSMCV875I8Xn/WN/Uiu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 21:40:28.4257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470a1540-bf68-4662-4144-08dccdf35c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221
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

This patch extends the same cs parser from JPEG v4.0.3 to
other JPEG versions (v2 and above).

Rename to more common name as jpeg_v2_dec_ring_parse_cs()
from jpeg_v4_0_3_dec_ring_parse_cs().

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 63 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  6 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h   |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 56 +--------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  5 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 10 files changed, 79 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 98aa3ccd0d20..9f1fce7a1717 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_cs.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -538,7 +539,11 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
+
+	if (ring->funcs->parse_cs)
+		amdgpu_ring_write(ring, 0);
+	else
+		amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
@@ -764,6 +769,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -810,3 +816,58 @@ const struct amdgpu_ip_block_version jpeg_v2_0_ip_block = {
 		.rev = 0,
 		.funcs = &jpeg_v2_0_ip_funcs,
 };
+
+/**
+ * jpeg_v2_dec_ring_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib)
+{
+	uint32_t i, reg, res, cond, type;
+	struct amdgpu_device *adev = parser->adev;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if (res) /* only support 0 at the moment */
+			return -EINVAL;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START ||
+			    reg > JPEG_REG_RANGE_END) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE3:
+			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START ||
+			    reg > JPEG_REG_RANGE_END) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] == CP_PACKETJ_NOP)
+				continue;
+			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			return -EINVAL;
+		default:
+			dev_err(adev->dev, "Unknown packet type %d !\n", type);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 654e43e83e2c..31476951e2c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -45,6 +45,9 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
+#define JPEG_REG_RANGE_START						0x4000
+#define JPEG_REG_RANGE_END						0x41c2
+
 void jpeg_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
@@ -57,6 +60,9 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned vmid, uint64_t pd_addr);
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
+int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				  struct amdgpu_job *job,
+				  struct amdgpu_ib *ib);
 
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index d8ef95c847c2..eedb9a829d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -662,6 +662,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -691,6 +692,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 31cfa3ce6528..b1e7fd25afbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -560,6 +560,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3dac8f259d7f..6c5c1a68a9b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -727,6 +727,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
index 07d36c2abd6b..2922c2dfed9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
@@ -32,5 +32,7 @@ enum amdgpu_jpeg_v4_0_sub_block {
 };
 
 extern const struct amdgpu_ip_block_version jpeg_v4_0_ip_block;
-
+extern int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				  struct amdgpu_job *job,
+				  struct amdgpu_ib *ib);
 #endif /* __JPEG_V4_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index a4ebceaaa09c..0c5b2ca36f9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -23,7 +23,6 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
-#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "jpeg_v4_0_3.h"
@@ -1083,7 +1082,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
-	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -1248,56 +1247,3 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.ras = &jpeg_v4_0_3_ras;
 }
-
-/**
- * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
- *
- * @parser: Command submission parser context
- * @job: the job to parse
- * @ib: the IB to parse
- *
- * Parse the command stream, return -EINVAL for invalid packet,
- * 0 otherwise
- */
-int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
-			     struct amdgpu_job *job,
-			     struct amdgpu_ib *ib)
-{
-	uint32_t i, reg, res, cond, type;
-	struct amdgpu_device *adev = parser->adev;
-
-	for (i = 0; i < ib->length_dw ; i += 2) {
-		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
-		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
-		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
-		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
-
-		if (res) /* only support 0 at the moment */
-			return -EINVAL;
-
-		switch (type) {
-		case PACKETJ_TYPE0:
-			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE3:
-			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE6:
-			if (ib->ptr[i] == CP_PACKETJ_NOP)
-				continue;
-			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-			return -EINVAL;
-		default:
-			dev_err(adev->dev, "Unknown packet type %d !\n", type);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 71c54b294e15..e3b2fc9d5879 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -46,9 +46,6 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
-#define JPEG_REG_RANGE_START						0x4000
-#define JPEG_REG_RANGE_END						0x41c2
-
 extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
 
 void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
@@ -65,7 +62,7 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 					uint32_t val, uint32_t mask);
-int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+extern int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
 				  struct amdgpu_job *job,
 				  struct amdgpu_ib *ib);
 #endif /* __JPEG_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index f96ac6bce526..44eeed445ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -768,6 +768,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index f4daff90c770..1bdcce8d21ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -646,7 +646,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
-- 
2.34.1

