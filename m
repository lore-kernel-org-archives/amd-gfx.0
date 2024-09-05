Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7315BCE7AA1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 21:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8630510E958;
	Thu,  5 Sep 2024 21:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0sPbRBqe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C5B10E958
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 21:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUNR46Mlf+Afm89dLk5NvK2nc7TcXXQ0KnfRHkowXPLjGZQbFGhQ8fEbhBUeQUxlZvfVaapzgdM64SujQY/u2d67IHzNL8mjKYYIhHtXERskFOLnn5tDH1uOPqRlhWottjd2UbZmnbbDWPeU3/lOgYwQcQrWxC7Ay6QXq/i9HR0Y9dbTitblnfMgA8gqBKAL83Qb5YQanlU7gMlcpXYxThdDFWuQRwGraSoLMvuKk+Y3QUhI9zIofm12fc32PodaOhfvRhJozeeC4ZxvWSTAcnD7dpMHmkEaUa/MtTbN1hjxPSC3ZMh02eMB399d+njDgrMk7i/OdH2th9q+v9udCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74XwAfIdT2C/r7L84rue6KNqdZIfMHu/yEedsLSzs0c=;
 b=nYMevHxXZuIkF1gmku/2TBT04XAUBqPh2Cr0daeIkOUr3wNYOkLl+boa2532uVsEaUeLMCc3KvSZZN3O/tDMAfTyrwJscLDPJXOj0xPpMoxxAgxvWzt71i5hOMqPAJ8EhgEubeLBHg6RbmeLf9d1oglx88In2u2rldP62ZUA9XdUxCEHK4MQ+2Mfa03WeOTkBeMgQnKnNHd6LpM6is8gr+IgSYs1etqSnSJrb9X2g7TcNrJLYXULot/a+o/2L8lCRVPqkqsFj2R1l0HjvUy4pXL22uMuGO3MrYtCx892y8WMxqWM+sKlzcktTKPM0n4nG8ufVkRtJzKMWP2pDZt6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74XwAfIdT2C/r7L84rue6KNqdZIfMHu/yEedsLSzs0c=;
 b=0sPbRBqeVYYSA2hwfpd/TUqp1DNZ9/ojdhxY/to56YcBq3ycYZrMyQnNL07a4d4yzN1x54lheJWbd8iC5arX3eiLEteV8F+9gRkxxSL17AZsO1yHvbiTwNWP/EkIPaeIURGFpiJ1hF8APaiNo+fgq9Et2De6J3q9J1hgxKhd0dE=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 21:40:29 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::f) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Thu, 5 Sep 2024 21:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 21:40:29 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 16:40:27 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu: apply command submission parser for JPEG
 v1
Date: Thu, 5 Sep 2024 17:40:16 -0400
Message-ID: <20240905214016.501543-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905214016.501543-1-David.Wu3@amd.com>
References: <20240905214016.501543-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: fad3d327-a8fc-47a2-9c89-08dccdf35cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GL+n6LbDDxzFOXvypPdWPTaWxV6ErpXIhQF0yumeG20NVoyk5GwEUXE5zfjr?=
 =?us-ascii?Q?C196kXOwvJv5wRTFZcFCsG5IG24ITY/wgyYVdKRJw9hlrizjcFPFGLX8jdT1?=
 =?us-ascii?Q?lNUjUHkLi8UVYCzWWVsfT5l389kqt9DsX2p0a+lSJmHQR7MD6eJpCLZO/c4w?=
 =?us-ascii?Q?dWS/RAn7Jab9TnPouiV2kg/3EvBbxVA0Ufi9Psu6yzHe2aO0Cscx9+/aUiFN?=
 =?us-ascii?Q?Dqd/gEqBFgsH+ckX5URYJjNdXpg54JONZy4JZ092jBnl+LsTZneknKyNG1Pk?=
 =?us-ascii?Q?onHLQBUbupxV7lP4CxNcVMgUAWBjAFVjjPOms9IiTKKeR1tsWjMScCz6Bsti?=
 =?us-ascii?Q?Llvd/OVNT4RvZ5DiwUJBShf7N61AKNKLe1zwAaTUgwNWq6moGyPvuuVQcjHQ?=
 =?us-ascii?Q?U6MdwoTQLYBCAYUUP3bY1IYlwuOy8mFJBmKoNy9Jrx6D56Ep+y5f3+IfxIip?=
 =?us-ascii?Q?zL4JuILwRkBVOPsGl04K39I20PxOrStoSX16xZsG+Xmcr7adURokQhmfpUz6?=
 =?us-ascii?Q?AFEFlLNf0pu+be4tmlxfSvTAFDC6L2r329G41wEsW8C7uaR0x1VTAo8uremF?=
 =?us-ascii?Q?FDGClkjDlC5NXNckaoRFpKDliQip/DgF8lMt83pIau/hTKjzTawQE8aRrYBX?=
 =?us-ascii?Q?86JQyj6laEkpiFJv78EVrFr5TATotbD0dLk8CgPm7bWQsQxw7sdAUvPx6gGx?=
 =?us-ascii?Q?W9NCAVJH3au+78DgylW/MXCmlo9npCH0FY4FVz6FezJl20fRKM9GOZIC+enK?=
 =?us-ascii?Q?iLwIKg7oF34XM71WK60pYOLHJByOEuM0Ptt4rJfIXL8w/0ZYE7yyW8tyge+q?=
 =?us-ascii?Q?kh8FeCdUYM50CcbX/+xwJbDcxmaHyluQ0NrjCdtKSpkj9koujoyGR3c+xeJz?=
 =?us-ascii?Q?hGWml9NCATwdmEhQtkB2+a+YiJCZXa+K/pLcTc+TO+Vesndx2z+tFBFN/sdZ?=
 =?us-ascii?Q?F77kulJ8A+IfF9ARPl5k+3RYvmuT5D3RlFJ25ZMGAY/wyw7o1Qzvnr4cNDwB?=
 =?us-ascii?Q?03EKv1el64DStgxLxTjJ5VOTsPpzhULYRBTa8lEy5cVptsoqW4foTYGjJQ9E?=
 =?us-ascii?Q?92kDbY4MeQkp4HVxZNfFNPOFSIZ2scDzXS8sCMU9jixefFUFwW/NyHTTsLlH?=
 =?us-ascii?Q?64Vpu2XNvqNz1VAj2iOcCbzCxCXf/JyA/FYxX8YiDqe+7VmYNiEfpuiET+I2?=
 =?us-ascii?Q?UXRmovc0buHeirjcyjsamCP6eMSauyeal2oT5c5kjLuGW2xWl86qLmYzKdAJ?=
 =?us-ascii?Q?/Dibudg2A1MpxmMTNKpuLYkDJQsTfm6BGIW3HI/1iNY65SPQPPdFBatwRXvJ?=
 =?us-ascii?Q?KznMwjQthiMfVAcPkT9aoNJogMkZ4RjhHrDi8Uo4WBktQ5oUC8Q+8Io1yfeQ?=
 =?us-ascii?Q?MZ7V5fRECEL2iiiC/UPmZwTwQ3DQrCC4NixZQq+Ix1V6Dl3euGSz2DUOlR2B?=
 =?us-ascii?Q?JI/pcz7ZmX45dVTd88/m5i6ZVbOY0K1D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 21:40:29.4570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad3d327-a8fc-47a2-9c89-08dccdf35cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

Similar to jpeg_v2_dec_ring_parse_cs() but it has different
register ranges and a few other registers access.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 76 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h | 11 ++++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 71f43a5c7f72..e8c0bd228ec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "vcn_v1_0.h"
@@ -34,6 +35,9 @@
 static void jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring);
+static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				     struct amdgpu_job *job,
+				     struct amdgpu_ib *ib);
 
 static void jpeg_v1_0_decode_ring_patch_wreg(struct amdgpu_ring *ring, uint32_t *ptr, uint32_t reg_offset, uint32_t val)
 {
@@ -300,7 +304,10 @@ static void jpeg_v1_0_decode_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring,
 		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JRBC_IB_VMID), 0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	if (ring->funcs->parse_cs)
+		amdgpu_ring_write(ring, 0);
+	else
+		amdgpu_ring_write(ring, (vmid | (vmid << 4)));
 
 	amdgpu_ring_write(ring,
 		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JPEG_VMID), 0, 0, PACKETJ_TYPE0));
@@ -554,6 +561,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
 	.get_rptr = jpeg_v1_0_decode_ring_get_rptr,
 	.get_wptr = jpeg_v1_0_decode_ring_get_wptr,
 	.set_wptr = jpeg_v1_0_decode_ring_set_wptr,
+	.parse_cs = jpeg_v1_dec_ring_parse_cs,
 	.emit_frame_size =
 		6 + 6 + /* hdp invalidate / flush */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
@@ -611,3 +619,69 @@ static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 
 	vcn_v1_0_set_pg_for_begin_use(ring, set_clocks);
 }
+
+/**
+ * jpeg_v1_dec_ring_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				     struct amdgpu_job *job,
+				     struct amdgpu_ib *ib)
+{
+	uint32_t i, reg, res, cond, type;
+	int32_t ret = 0;
+	struct amdgpu_device *adev = parser->adev;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if (res || cond != PACKETJ_CONDITION_CHECK0) /* only allow 0 for now */
+			return -EINVAL;
+
+		if (reg >= JPEG_V1_REG_RANGE_START && reg <= JPEG_V1_REG_RANGE_END)
+			continue;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (reg != JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_HIGH &&
+			    reg != JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_LOW &&
+			    reg != JPEG_V1_LMI_JPEG_READ_64BIT_BAR_HIGH &&
+			    reg != JPEG_V1_LMI_JPEG_READ_64BIT_BAR_LOW &&
+			    reg != JPEG_V1_REG_CTX_INDEX &&
+			    reg != JPEG_V1_REG_CTX_DATA) {
+				ret = -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE1:
+			if (reg != JPEG_V1_REG_CTX_DATA)
+				ret = -EINVAL;
+			break;
+		case PACKETJ_TYPE3:
+			if (reg != JPEG_V1_REG_SOFT_RESET)
+				ret = -EINVAL;
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] != CP_PACKETJ_NOP)
+				ret = -EINVAL;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+
+		if (ret) {
+			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
index bbf33a6a3972..9654d22e0376 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
@@ -29,4 +29,15 @@ int jpeg_v1_0_sw_init(void *handle);
 void jpeg_v1_0_sw_fini(void *handle);
 void jpeg_v1_0_start(struct amdgpu_device *adev, int mode);
 
+#define JPEG_V1_REG_RANGE_START	0x8000
+#define JPEG_V1_REG_RANGE_END	0x803f
+
+#define JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_HIGH	0x8238
+#define JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_LOW	0x8239
+#define JPEG_V1_LMI_JPEG_READ_64BIT_BAR_HIGH	0x825a
+#define JPEG_V1_LMI_JPEG_READ_64BIT_BAR_LOW	0x825b
+#define JPEG_V1_REG_CTX_INDEX			0x8328
+#define JPEG_V1_REG_CTX_DATA			0x8329
+#define JPEG_V1_REG_SOFT_RESET			0x83a0
+
 #endif /*__JPEG_V1_0_H__*/
-- 
2.34.1

