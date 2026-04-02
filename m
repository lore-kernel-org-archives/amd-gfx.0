Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F235ED6AB17
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 21:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A1710F4B3;
	Thu,  2 Apr 2026 21:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NjwHNZky";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6D610F4B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 21:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzCW2AiamDxGdHcklcbLGd6C9YfWtMg4hoJJUbBXQUgIBGQwt39dvJWvm4fftuCUGrLUb83HjmxRcvPNHxqjgG1qqe7X6xpH5X2bVmd3UhsdNqbvekL0eKsSpJ8vBL6Gj4SttGTspVC6phXHM7H5lf8Q/C3/+zhKxXMfbvpHeXXW8o5q9qnxbj6cvJ06GBqMZ8/bAxxialtwQF4GnQUrrlh0wcSsWHV1grOx6F5tUdhYmxm+LBB7olWIrpi+no5Ng/idfGw7NzIatHAuqKrMDu8A5M22g6swl9EmN0zZKDmTA2x/SueDowp5fpWk1/K4tnGFegLOQQ3gORrRvZCqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TceVvs+ufEI6yPmXruogmZ6KC7ZD8jm35blU45pvMMg=;
 b=NGA18uf+/dPo7sr49ZB1eMKJVy2ZPYNLNF8iac7QMgJyr8TMlcIo44IAQBygo8kYCcy5yrhrtwIf3pB55HLLN/wpZS5ldZGDwKJkGr/JMPDNYjggFsqQjeTcuKv4Qdb2IVSi8SfxQipeZJID/wZB6erPT9Iaq3Tsp0RMzAxQmls3R0G5AIqZpsKIO/Ep2qnVw7+wtCQJSYu4ndiB1NckxkBV7ll3mmzv3LVuv7knwfB3ei4i5ZQfxALLqh2IG6WU/s7hiC/sErw+3O8YZBlPXsWOfun48z9EIsNncwnnztlrQ8NGL9eRoXqiDW1BqGZpSqZ+X/uR9UzvzKd+O1a9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TceVvs+ufEI6yPmXruogmZ6KC7ZD8jm35blU45pvMMg=;
 b=NjwHNZkylcruCfBVcDs2gJGo/AohIALLf0If8MMp1D0HtQuT3aWS3rKEK2xjnZuwuhz5bYS3nSMFsX+Y/u4fClWy260d/0X3ctD5bQjaS4mgmwCjCp6ISYpDIv7JEP8sjOppRmB4Z3TwofOFNoTrJkxlG97Sufn94s2eEz4xwQU=
Received: from SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39) by
 SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Thu, 2 Apr
 2026 21:43:45 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::77) by SN6PR01CA0026.outlook.office365.com
 (2603:10b6:805:b6::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 21:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 21:43:44 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Apr 2026 16:43:44 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Lijo.Lazar@amd.com>
CC: <leo.liu@amd.com>
Subject: [PATCH V4] amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0 and
 5_0_2
Date: Thu, 2 Apr 2026 17:43:31 -0400
Message-ID: <20260402214331.2430926-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c25f57-6f93-4b7e-6c41-08de9100ea2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: MxOaILQahFCpD7ylbEstFcZouwXsPlZ8TBo96wrEFoCs9BClhM0A7a2Sy46uhPkOX3gmDvurAGKkoM50XO7nTa1j5tchZ11vEmgrlx1otnkgP5A/TQjwCeXr72KN3NvcW1tNUwwv3k/CYBIbsbCSzq7XcyiiwdKACPXWlJzoMAsozE/s5tyPjCeNuJ4WnHUlS1xyrusxfqBby30ahcbTJVuOJLbbcUUTHiOASVDfiucpBLQYPHugxQN5WpIhGGdYJm+hiMwN9pWNg/FnS6s73rtpkHLchHcmyV6b/dxLAqmLUQ2wkSA9h2ktCYphNJ2mi8N46pCad0Wkf03jdgbk3dO84s741HTMBICOjDDpibjaESrGf078USAqEPLzWuxg2h1lhweJkz9b14/6y0n88dpzNxEWfsoq3xNW3rv7CS7K8vYBKOerk0zIy75E2VWID9LiJIfhPDFANQmznEFLu0cov1GgGc+HGAqMkIPzcWTFulYWlzN53XEPTUiP8jj3RxJDu668vbg2A0rgVsXpY18GeGmoT/ojdjp+u6ubM2SDfyRqxbeXTNC/Wn2Bx3CVl9nDwWYZ9MWLCq1N2tptq7Mkj8ZUj992/jQL2k7/ea6U5/1LyRoXUsb1/ElaX7jM6sj8VxPFAzLnNg8AJKGTFGMqYoZidprLF+zdHRrExzOSlqvRkh2soTD+VuvVcAcGP32vHZluJiHEEgaJXv14TmetNQSAHqV758lI/WRv1nsTVB5VBZGERElsFVVXZBsi8l7wQVn0hrUeTJkSNuedyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4F2VmfMgW09QXRV47voouGBH7pMR5+O2fAINFzyK1ZqUdLIqsotmaF9Nk87PZRD7SfKSPYNEYiKLnLWeXCK8a7e8qmqFFCIhDPz1E2JrZ9KVuWgBI/iSTy6EIqmQxruEFBhTtG+fXXg69xIUG5jSyzM8YKq3kMLU+socmHAVAZPDqX+jTGk63GHv9uEkNdEqR/VBK5wZsBKrpEr11UitlyWxwYqBDRgDm+LR0Kst/6WI+gWmSQv9dYNVVYRbryvUHTnm6fLPO4R8eUQlLUqVFHegGoII8ZUer3tBL1/v8v/889lOGPgEZIm2uBXdiB0WrrVVd6xSFNFEUdgd/XqLya1Lj1zeEopWc+sT1/8NErwBTK7HZrD9oI+T3D5Cv5V6LL/sLJ4shL5bXJ/wavNPfckwvclr0Lhc+NQLovwabsnEi8KD6Z48anHZfZ4xpaqp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:43:44.7407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c25f57-6f93-4b7e-6c41-08de9100ea2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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

PCTL0__MMHUB_DEEPSLEEP_IB is 0x69004 on MMHUB 4,1,0 and
and 0x60804 on MMHUB 4,2,0. 0x62a04 is on MMHUB 1,8,0/1.

The DS bits are adjusted to cover more JPEG engines and MMHUB
version.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 52 +++++++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 4b4aa9553624..82abe181c730 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -736,15 +736,35 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
  */
 void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
 {
-	if (!amdgpu_sriov_vf(ring->adev)) {
+	struct amdgpu_device *adev = ring->adev;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		int jpeg_inst = GET_INST(JPEG, ring->me);
+		uint32_t value = 0x80004000; /* default DS14 */
+
 		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 			0, 0, PACKETJ_TYPE0));
-		amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
+
+		/* PCTL0__MMHUB_DEEPSLEEP_IB could be different on different mmhub version */
+		switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+		case IP_VERSION(4, 1, 0):
+			amdgpu_ring_write(ring, 0x69004);
+			value = 0x80010000;
+			break;
+		case IP_VERSION(4, 2, 0):
+			amdgpu_ring_write(ring, 0x60804);
+			if (jpeg_inst & 1)
+				value = 0x80010000;
+			break;
+		default:
+			amdgpu_ring_write(ring, 0x62a04);
+			break;
+		}
 
 		amdgpu_ring_write(ring,
 				  PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
 					  0, PACKETJ_TYPE0));
-		amdgpu_ring_write(ring, 0x80004000);
+		amdgpu_ring_write(ring, value);
 	}
 }
 
@@ -757,15 +777,35 @@ void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
  */
 void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)
 {
-	if (!amdgpu_sriov_vf(ring->adev)) {
+	struct amdgpu_device *adev = ring->adev;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		int jpeg_inst = GET_INST(JPEG, ring->me);
+		uint32_t value = 0x00004000; /* default DS14 */
+
 		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 			0, 0, PACKETJ_TYPE0));
-		amdgpu_ring_write(ring, 0x62a04);
+
+		/* PCTL0__MMHUB_DEEPSLEEP_IB could be different on different mmhub version */
+		switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+		case IP_VERSION(4, 1, 0):
+			amdgpu_ring_write(ring, 0x69004);
+			value = 0x00010000;
+			break;
+		case IP_VERSION(4, 2, 0):
+			amdgpu_ring_write(ring, 0x60804);
+			if (jpeg_inst & 1)
+				value = 0x00010000;
+			break;
+		default:
+			amdgpu_ring_write(ring, 0x62a04);
+			break;
+		}
 
 		amdgpu_ring_write(ring,
 				  PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR, 0,
 					  0, PACKETJ_TYPE0));
-		amdgpu_ring_write(ring, 0x00004000);
+		amdgpu_ring_write(ring, value);
 	}
 }
 
-- 
2.43.0

