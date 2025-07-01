Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8010FC7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 09:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1770810E571;
	Tue,  1 Jul 2025 09:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vixi5QvL";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030F110E562
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 09:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAh4dPwRljTcejIf0cORudv+qXwStZ662hLuiWW/2/e7LY4WzSmdDNdeuSZf1+LUV0KGI8AYsHBD7IySr3YuwKP+gJ7qCAw2VBnhkoAIRQUuqDxZj7Y6Lcu2VV9BKKwVc4imARnRT2jj9cBGLEnvLVE+oDEy3gofy+U0JQJ8udW621YN8hiDLU6m5B5S1eqK+WJz2kWAOecTIpVnLVTyRv2ZRvJmJHZjwv7f4fLeGMH/1SJtsgMV4Cv0nfpNCFq19xkkxplzFVxnyRQcwni+qZ2VAdkyTarOkkzORzdySzmgVCvdVvlkvpACkYShhDNjVAXfjq5NcLU64erm45iYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRfiJkmybCKRRGjVHCJ2FqkR+y+g/CFTTZAoZieiZQ8=;
 b=XmSq6uWrz4yz5KKrMCuCJ3wfVbT3N4RaItQYVRTadkOMhjzMfQhE6YaIshEfdJLgmp6/1YjVMqKONF7gH8qC8GfT7iUHvN0Q4tBLhcNdRK/CRCAr5McmbtJtX2y2rYYDwEfqsXctVtYaNj6WECjZrV+xu3sGa3MPKTQoq9/K4OnbGM0dpnFMP85FvYEEXmQXh7WUKszmCLE0aEHhnvqyCJXWJ2ZWt8qOUHgJbVzGsPwX+6QhDJ39oRiPXH9i2kciSfG64zd525sSJrhphhpLzohz3/Ni3hZ4rs4t5eE/WSxY12r2vo9DJT+HD72KHJw5GDTJEGAOec0ZCux0RzBveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRfiJkmybCKRRGjVHCJ2FqkR+y+g/CFTTZAoZieiZQ8=;
 b=Vixi5QvLbAVep6Dd6QavQ6J771ECTO/Xvet4BPkO3dSTXzTJjXCTNXeI4Y6oUT9WEs6Qrudo55rx34ScjQOAf66bNb8HX8HI8fuTTxY87KAUCcT/iYoS7hLbTdUbE5KxPK9H7Vm+M0l7Z35fzTqAJg5vQqAJiHXMGondBnYk7KM=
Received: from SJ0PR13CA0197.namprd13.prod.outlook.com (2603:10b6:a03:2c3::22)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 09:24:29 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::62) by SJ0PR13CA0197.outlook.office365.com
 (2603:10b6:a03:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.17 via Frontend Transport; Tue,
 1 Jul 2025 09:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 09:24:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 04:24:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Vojislav.Tomasevic@amd.com>
Subject: [PATCH] drm/amdgpu: Add a noverbose flag to psp_wait_for
Date: Tue, 1 Jul 2025 14:54:09 +0530
Message-ID: <20250701092409.1303971-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc2cbec-9030-4140-b2be-08ddb88114a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H6MO7AdjmlSoykJ20adOp0gKs5zPql+aURHf8VNXvDi3BLdgCuNpfUjC2XLJ?=
 =?us-ascii?Q?g9p8Pz8zjA28/pX4s0OJAKZ4OEawlp23yz1Spds3xUQifH5E1NBBhHK/tzSH?=
 =?us-ascii?Q?T7somf6qJ6hmrnCzXPw+X9r1EpTBJ3/iNF23TgZ8HXGIx+feU0VcplXliYEP?=
 =?us-ascii?Q?qOAJLbqaoaDEaaDPCIgCK9Vm8KVfg9H4iQltF+NClqMsZxQ/Isd3/GnBBbUc?=
 =?us-ascii?Q?+NsdZWy9Vc3Y5k8+s/Z6dGwnZ3oi7tfsnA9T2qHh9uHtjhENl7W8Vt9dVarf?=
 =?us-ascii?Q?dKCKmKj/GEDM3FLF7VIqRWqzlTGGPto0GxmrxBdLJrnxYpVuAK5wOAWeQ6nq?=
 =?us-ascii?Q?WcLzsHdUC9e43v+TwN9brxVy1xh1fiDar335uZjAHDWGVsm+vjikh9ZSu4n4?=
 =?us-ascii?Q?JHdqMu/hz3Idj+X85hpbjub6Cc+URm7SIiESk6aKmpRjSEjVCqmRV4LdVmRy?=
 =?us-ascii?Q?Uvx2XLQFh3cTv2vd3/xSL6UnosUnEgiWF4dpEZhTOkJjOvoEJZcZ5pGRzn2O?=
 =?us-ascii?Q?QDqMZlocicwI4zPpqoLWYrSoE1PXyyd/DNKaZEl51WUBpQjS7/ZqHqIbPKnn?=
 =?us-ascii?Q?Bfx/WcD+8QPi6+tEjqC65uDfRFVokxGj3N8USNTimatDDNBQh3g+CqWP8mjf?=
 =?us-ascii?Q?VvJEVo90pHEfVYX0NHuSdt9R1GTQB62z6GFwp3PXkC7DRg8lK/k2VpVlgg4O?=
 =?us-ascii?Q?RxM4xilxwdwGBpe66hpaT4bW44vWKARFbHOsuo36dkACq7jTVzIPoaS/SGIY?=
 =?us-ascii?Q?VzvAGYCElHy9UmiXUiW40raFV+roPvEpy+qCH7Bci5gEP745F5g2bvcTGmge?=
 =?us-ascii?Q?IvXHeXYaT6HbxNtp2BpxZPwkaK3ydlA8NpKi1sVFOSSdpIAMW3a7G+/yuytD?=
 =?us-ascii?Q?dGtLgvnTR1jaX5fcnDD326Yx8clhfqb8AIMGd5RaMjm2SPQ1Te0yecji71i+?=
 =?us-ascii?Q?wm2CyxhKpaNFg2VfrrWpd84iJ4gL65lDwS8IgYHdqPyv5ul8VaumexGhQcHL?=
 =?us-ascii?Q?uApUBdp2FzGtuI1gcJPwRLOog1gD3j5meHEYtn0ijYXW5YY72Xkuyy9T9t3H?=
 =?us-ascii?Q?JXCJwzWZ5HxueMhn6puKPi/nuyG8lQIWsVnuNsScH1ojoiGZ5h51VPdWpKjS?=
 =?us-ascii?Q?8gvsJcwNyn1OxA6QAksSQMv+E38nnlKNRp1GOKjVYJ3GqWmHUgk/Gabv9u1G?=
 =?us-ascii?Q?xnuHb622dCFQF1SoG8Ugv2mSEuguL/kxnZjX0iZ54rRqRk2/k7Ya3VvTrEvu?=
 =?us-ascii?Q?2nbdOGFjxBdMP8/z5RIZvQgTnAhooW0/uoJg/pcLgn5SUQXkTU3DECOFjzHu?=
 =?us-ascii?Q?e/wBX+IKWFF8fTb2mupvhWbVxoWu+hfIgeb8WL49djKbtPNDMqjqrkm/eMJW?=
 =?us-ascii?Q?mrQo3Omv9E9lc73SYw/R54pMy6uPyN45tkKwjI3uDW+tqn7Chk2zQxHNx8t8?=
 =?us-ascii?Q?i7WU0603UWVf0HFil/RCM2CBk1H8Kx/8NWLG3Lk6PwN1Pp8WlRmqsw160yZc?=
 =?us-ascii?Q?WZkZ9fNDlEl12o5/fui79qB9JpSsUOKSvY8i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 09:24:29.1503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc2cbec-9030-4140-b2be-08ddb88114a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564
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

For extended wait with retries on a PSP register value, add a noverbose
flag to avoid excessive error messages on each timeout.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 13 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  7 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   | 35 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c | 10 ++---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   | 20 ++++-----
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 41 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 22 +++++-----
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c   | 55 +++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c    | 41 +++++++++---------
 10 files changed, 130 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04dedf38eb0d..25aa35de1e41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -575,9 +575,11 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
-		 uint32_t reg_val, uint32_t mask, bool check_changed)
+int psp_wait_for(struct psp_context *psp, uint32_t reg_index, uint32_t reg_val,
+		 uint32_t mask, uint32_t flags)
 {
+	bool check_changed = flags & PSP_WAITREG_CHANGED;
+	bool verbose = !(flags & PSP_WAITREG_NOVERBOSE);
 	uint32_t val;
 	int i;
 	struct amdgpu_device *adev = psp->adev;
@@ -597,9 +599,10 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 		udelay(1);
 	}
 
-	dev_err(adev->dev,
-		"psp reg (0x%x) wait timed out, mask: %x, read: %x exp: %x",
-		reg_index, mask, val, reg_val);
+	if (verbose)
+		dev_err(adev->dev,
+			"psp reg (0x%x) wait timed out, mask: %x, read: %x exp: %x",
+			reg_index, mask, val, reg_val);
 
 	return -ETIME;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 4bc0ec49d2e9..35888f1937bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -134,6 +134,9 @@ enum psp_reg_prog_id {
 	PSP_REG_LAST
 };
 
+#define PSP_WAITREG_CHANGED (1U << 0) /* check if the value has changed */
+#define PSP_WAITREG_NOVERBOSE (1U << 1) /* No error verbose */
+
 struct psp_funcs {
 	int (*init_microcode)(struct psp_context *psp);
 	int (*wait_for_bootloader)(struct psp_context *psp);
@@ -532,8 +535,8 @@ extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_4_ip_block;
 extern const struct amdgpu_ip_block_version psp_v14_0_ip_block;
 
-extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
-			uint32_t field_val, uint32_t mask, bool check_changed);
+int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
+		 uint32_t field_val, uint32_t mask, uint32_t flags);
 extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_index,
 			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 2c4ebd98927f..3584b8c18fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -94,7 +94,7 @@ static int psp_v10_0_ring_create(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	return ret;
 }
@@ -115,7 +115,7 @@ static int psp_v10_0_ring_stop(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1a4a26e6ffd2..6cc05d36e359 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -152,11 +152,9 @@ static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
 	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
 		/* Wait for bootloader to signify that is
 		    ready having bit 31 of C2PMSG_35 set to 1 */
-		ret = psp_wait_for(psp,
-				   SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-				   0x80000000,
-				   0x80000000,
-				   false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+			0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
 
 		if (ret == 0)
 			return 0;
@@ -252,8 +250,8 @@ static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
 	/* there might be handshake issue with hardware which needs delay */
 	mdelay(20);
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_81),
-			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
-			   0, true);
+			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81), 0,
+			   PSP_WAITREG_CHANGED);
 
 	return ret;
 }
@@ -279,11 +277,11 @@ static int psp_v11_0_ring_stop(struct psp_context *psp,
 	if (amdgpu_sriov_vf(adev))
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	else
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	return ret;
 }
@@ -321,13 +319,13 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
 		if (ret) {
 			DRM_ERROR("Failed to wait for sOS ready for ring creation\n");
 			return ret;
@@ -353,7 +351,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
@@ -387,7 +385,7 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
 
 	ret = psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
-			   MBOX_TOS_READY_MASK, false);
+			   MBOX_TOS_READY_MASK, 0);
 
 	if (ret) {
 		DRM_INFO("psp is not working correctly before mode1 reset!\n");
@@ -402,7 +400,7 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
 
 	ret = psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
-			   false);
+			   0);
 
 	if (ret) {
 		DRM_INFO("psp mode 1 reset failed!\n");
@@ -428,8 +426,9 @@ static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
 
 	max_wait = MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
 	for (i = 0; i < max_wait; i++) {
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
+			0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
 		if (ret == 0)
 			break;
 	}
@@ -608,7 +607,7 @@ static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			     0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 	if (ret)
 		return ret;
 
@@ -645,7 +644,7 @@ static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-				     0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 	if (!ret)
 		*fw_ver = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
index 338d015c0f2e..93787a90d598 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
@@ -43,7 +43,7 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
 		/* Wait for response flag (bit 31) */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
@@ -53,7 +53,7 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
 		/* Wait for response flag (bit 31) */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
@@ -91,13 +91,13 @@ static int psp_v11_0_8_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -123,7 +123,7 @@ static int psp_v11_0_8_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index d54b3e0fabaf..4c6450d62299 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -82,7 +82,7 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_context *psp)
 
 	/* Wait for bootloader to signify that is ready having bit 31 of C2PMSG_35 set to 1 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			   0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 	if (ret)
 		return ret;
 
@@ -97,7 +97,7 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_context *psp)
 	       psp_gfxdrv_command_reg);
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			   0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 
 	return ret;
 }
@@ -118,7 +118,7 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
 
 	/* Wait for bootloader to signify that is ready having bit 31 of C2PMSG_35 set to 1 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			   0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 	if (ret)
 		return ret;
 
@@ -133,8 +133,8 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
 	       psp_gfxdrv_command_reg);
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_81),
-			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
-			   0, true);
+			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81), 0,
+			   PSP_WAITREG_CHANGED);
 
 	return ret;
 }
@@ -163,7 +163,7 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	return ret;
 }
@@ -186,11 +186,11 @@ static int psp_v12_0_ring_stop(struct psp_context *psp,
 	if (amdgpu_sriov_vf(adev))
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	else
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	return ret;
 }
@@ -222,7 +222,7 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
 
 	ret = psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
-			   MBOX_TOS_READY_MASK, false);
+			   MBOX_TOS_READY_MASK, 0);
 
 	if (ret) {
 		DRM_INFO("psp is not working correctly before mode1 reset!\n");
@@ -237,7 +237,7 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
 
 	ret = psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
-			   false);
+			   0);
 
 	if (ret) {
 		DRM_INFO("psp mode 1 reset failed!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 58b6b64dcd68..af4a7d7c4abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -182,7 +182,7 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
 		   ready having bit 31 of C2PMSG_33 set to 1 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_33),
-			0x80000000, 0xffffffff, false);
+			0x80000000, 0xffffffff, PSP_WAITREG_NOVERBOSE);
 
 		if (ret == 0)
 			break;
@@ -213,7 +213,7 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	for (retry_loop = 0; retry_loop < retry_cnt; retry_loop++) {
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-			0x80000000, 0xffffffff, false);
+			0x80000000, 0xffffffff, PSP_WAITREG_NOVERBOSE);
 
 		if (ret == 0)
 			return 0;
@@ -362,8 +362,8 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 	/* there might be handshake issue with hardware which needs delay */
 	mdelay(20);
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_81),
-			   RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81),
-			   0, true);
+			   RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81), 0,
+			   PSP_WAITREG_CHANGED);
 
 	if (!ret)
 		psp_v13_0_init_sos_version(psp);
@@ -386,7 +386,7 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
 		/* Wait for response flag (bit 31) */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64,
@@ -396,7 +396,7 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
 		/* Wait for response flag (bit 31) */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
@@ -434,13 +434,13 @@ static int psp_v13_0_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -466,7 +466,7 @@ static int psp_v13_0_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
@@ -529,8 +529,9 @@ static int psp_v13_0_memory_training_send_msg(struct psp_context *psp, int msg)
 
 	max_wait = MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
 	for (i = 0; i < max_wait; i++) {
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+			0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
 		if (ret == 0)
 			break;
 	}
@@ -682,7 +683,7 @@ static int psp_v13_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-			     0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 	if (ret)
 		return ret;
 
@@ -719,7 +720,7 @@ static int psp_v13_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
 	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-				     0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 	if (!ret)
 		*fw_ver = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36);
 
@@ -744,8 +745,9 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
 						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
 	else
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
-				   MBOX_READY_FLAG, MBOX_READY_MASK, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
+			MBOX_READY_FLAG, MBOX_READY_MASK, 0);
 	if (ret) {
 		dev_err(adev->dev, "SPI cmd %x timed out, ret = %d", cmd, ret);
 		return ret;
@@ -769,7 +771,7 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
 
 	/* Confirm PSP is ready to start */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
-			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
+			   MBOX_READY_FLAG, MBOX_READY_MASK, 0);
 	if (ret) {
 		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
 		return ret;
@@ -804,7 +806,7 @@ static int psp_v13_0_dump_spirom(struct psp_context *psp,
 
 	/* Confirm PSP is ready to start */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
-			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
+			   MBOX_READY_FLAG, MBOX_READY_MASK, 0);
 	if (ret) {
 		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
 		return ret;
@@ -931,8 +933,9 @@ static int psp_v13_0_reg_program_no_ring(struct psp_context *psp, uint32_t val,
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_102, id);
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_103, val);
 
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+			0x80000000, 0x80000000, 0);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
index f65af52c1c19..5f39a2edcc95 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -76,11 +76,9 @@ static int psp_v13_0_4_wait_for_bootloader(struct psp_context *psp)
 	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
 		/* Wait for bootloader to signify that is
 		    ready having bit 31 of C2PMSG_35 set to 1 */
-		ret = psp_wait_for(psp,
-				   SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-				   0x80000000,
-				   0x80000000,
-				   false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+			0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
 
 		if (ret == 0)
 			return 0;
@@ -185,8 +183,8 @@ static int psp_v13_0_4_bootloader_load_sos(struct psp_context *psp)
 	/* there might be handshake issue with hardware which needs delay */
 	mdelay(20);
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_81),
-			   RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81),
-			   0, true);
+			   RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81), 0,
+			   PSP_WAITREG_CHANGED);
 
 	return ret;
 }
@@ -206,7 +204,7 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
 		/* Wait for response flag (bit 31) */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64,
@@ -216,7 +214,7 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
 		/* Wait for response flag (bit 31) */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
@@ -254,13 +252,13 @@ static int psp_v13_0_4_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -286,7 +284,7 @@ static int psp_v13_0_4_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index ffa47c7d24c9..36ef4a72ad1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -109,11 +109,9 @@ static int psp_v14_0_wait_for_bootloader(struct psp_context *psp)
 	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
 		/* Wait for bootloader to signify that is
 		    ready having bit 31 of C2PMSG_35 set to 1 */
-		ret = psp_wait_for(psp,
-				   SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
-				   0x80000000,
-				   0x80000000,
-				   false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
+			0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
 
 		if (ret == 0)
 			return 0;
@@ -228,9 +226,10 @@ static int psp_v14_0_bootloader_load_sos(struct psp_context *psp)
 
 	/* there might be handshake issue with hardware which needs delay */
 	mdelay(20);
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_81),
-			   RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81),
-			   0, true);
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_81),
+			   RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81), 0,
+			   PSP_WAITREG_CHANGED);
 
 	return ret;
 }
@@ -250,7 +249,7 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
 		/* Wait for response flag (bit 31) */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
@@ -260,7 +259,7 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
 		/* Wait for response flag (bit 31) */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
@@ -298,13 +297,13 @@ static int psp_v14_0_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -330,7 +329,7 @@ static int psp_v14_0_ring_create(struct psp_context *psp,
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, 0);
 	}
 
 	return ret;
@@ -393,8 +392,9 @@ static int psp_v14_0_memory_training_send_msg(struct psp_context *psp, int msg)
 
 	max_wait = MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
 	for (i = 0; i < max_wait; i++) {
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
+			0x80000000, 0x80000000, PSP_WAITREG_NOVERBOSE);
 		if (ret == 0)
 			break;
 	}
@@ -545,8 +545,9 @@ static int psp_v14_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc
 	 */
 	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20));
 
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
-			     0x80000000, 0x80000000, false);
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
+			   0x80000000, 0x80000000, 0);
 	if (ret)
 		return ret;
 
@@ -582,8 +583,9 @@ static int psp_v14_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
 
 	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_FW_VER);
 
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
-				     0x80000000, 0x80000000, false);
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_35),
+			   0x80000000, 0x80000000, 0);
 	if (!ret)
 		*fw_ver = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36);
 
@@ -607,11 +609,13 @@ static int psp_v14_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
 						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
 	else
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
-				   MBOX_READY_FLAG, MBOX_READY_MASK, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
+			MBOX_READY_FLAG, MBOX_READY_MASK, 0);
 
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
-				MBOX_READY_FLAG, MBOX_READY_MASK, false);
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
+			   MBOX_READY_FLAG, MBOX_READY_MASK, 0);
 	if (ret) {
 		dev_err(adev->dev, "SPI cmd %x timed out, ret = %d", cmd, ret);
 		return ret;
@@ -634,8 +638,9 @@ static int psp_v14_0_update_spirom(struct psp_context *psp,
 	int ret;
 
 	/* Confirm PSP is ready to start */
-	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
-			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
+	ret = psp_wait_for(psp,
+			   SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
+			   MBOX_READY_FLAG, MBOX_READY_MASK, 0);
 	if (ret) {
 		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f6b75e3e47ff..833830bc3e2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -91,7 +91,7 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_context *psp)
 
 	/* Wait for bootloader to signify that is ready having bit 31 of C2PMSG_35 set to 1 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			   0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 	if (ret)
 		return ret;
 
@@ -109,7 +109,7 @@ static int psp_v3_1_bootloader_load_sysdrv(struct psp_context *psp)
 	mdelay(20);
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			   0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 
 	return ret;
 }
@@ -130,7 +130,7 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
 
 	/* Wait for bootloader to signify that is ready having bit 31 of C2PMSG_35 set to 1 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
-			   0x80000000, 0x80000000, false);
+			   0x80000000, 0x80000000, 0);
 	if (ret)
 		return ret;
 
@@ -147,8 +147,8 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context *psp)
 	/* there might be handshake issue with hardware which needs delay */
 	mdelay(20);
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_81),
-			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
-			   0, true);
+			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81), 0,
+			   PSP_WAITREG_CHANGED);
 	return ret;
 }
 
@@ -168,7 +168,7 @@ static void psp_v3_1_reroute_ih(struct psp_context *psp)
 
 	mdelay(20);
 	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-		     0x80000000, 0x8000FFFF, false);
+		     0x80000000, 0x8000FFFF, 0);
 
 	/* Change IH ring for UMC */
 	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1216b);
@@ -180,7 +180,7 @@ static void psp_v3_1_reroute_ih(struct psp_context *psp)
 
 	mdelay(20);
 	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-		     0x80000000, 0x8000FFFF, false);
+		     0x80000000, 0x8000FFFF, 0);
 }
 
 static int psp_v3_1_ring_create(struct psp_context *psp,
@@ -217,9 +217,9 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
-					mmMP0_SMN_C2PMSG_101), 0x80000000,
-					0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+			0x80000000, 0x8000FFFF, 0);
 	} else {
 
 		/* Write low address of the ring to C2PMSG_69 */
@@ -240,10 +240,9 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
-					mmMP0_SMN_C2PMSG_64), 0x80000000,
-					0x8000FFFF, false);
-
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			0x80000000, 0x8000FFFF, 0);
 	}
 	return ret;
 }
@@ -267,11 +266,13 @@ static int psp_v3_1_ring_stop(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) */
 	if (amdgpu_sriov_vf(adev))
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+			0x80000000, 0x80000000, 0);
 	else
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			0x80000000, 0x80000000, 0);
 
 	return ret;
 }
@@ -311,7 +312,7 @@ static int psp_v3_1_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
 
-	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
+	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, 0);
 
 	if (ret) {
 		DRM_INFO("psp is not working correctly before mode1 reset!\n");
@@ -325,7 +326,7 @@ static int psp_v3_1_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
 
-	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
+	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, 0);
 
 	if (ret) {
 		DRM_INFO("psp mode 1 reset failed!\n");
-- 
2.49.0

