Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE63210A3D8B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3148110E303;
	Thu, 26 Mar 2026 12:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMlkAbdx";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013068.outbound.protection.outlook.com
 [40.93.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EBA710E04F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf0lKAbG+461P2C/ZtPpK8lbaBx9gfMFzgrn4+mdvi3YM3Q20hxKRY+T2eLlKDJYVVDe0NKL75top3Im8Xk2aCAV8+e8pRvPLZ+gCphjNbL7pOmN7ybXyEL8/5OAa3n8z4BDCrWrciD6tYa59ioTPMIsxuRZr0g4Vx9rh2/IjT30PgsbLyjBg7vCLm3Vil29nYBR5g8GlVW6bpGiqQ/dsZc5MkmfOm7BBDcjZ/P/s5bzh7IJyu2+q2DHkrV0OGReHb/UJ2edyVeir6CNupKMJw3Ot25HRNebsPyjH+yYqLR8rtd6oPN/0ITjXT0J0nnK5p4a7Kqm+VyN+J19RiUv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq7gAY6/7hzy8Yw1LLpU9OCF7s5/2zkSHHmLWYy5rKY=;
 b=XH5BE9P5RICI/YYSvjojaYWxulvzYsRVrjmUie6EnlsGyVYWUyNm4UshY0ME7qhT9puOU9H9DNL2EzQGT+GaBQMVoJpRp0DNMIENkAaPlUJ5D9KMjFOzE/zCdpo5HGwq+1CgjqpqN/FmW0jcZCgTfL0GUj/eI086mm+72vhYLZhhGR01RV17GMo+INQ5dx9IeZ3qEzsFlMwgUReuNsMJwZ1HSYQHg9HGBgXvvDNVaqzjC6Vz+zy1/zL/wS6NeQ0n2gsf2SllUim6wEI2e40iAW3yoPbTRqJhrj6zbGrLAeyCpDxlgeprhkUtvVom4nX3Bz9e47RTeqkS1fCxChSjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq7gAY6/7hzy8Yw1LLpU9OCF7s5/2zkSHHmLWYy5rKY=;
 b=QMlkAbdx9r5JXZJr6ohhlDE5kfrjzTVs+zaH39TLINqBH1R9xrXr4HwOFCZVLIuJVUqXtWtsV2fZ5uRM8RDLI9FbefMD600mzabXglfcSyjoQeb1o68Hd1H8ma9eO5xPmv1GIp3zsZie/0MOokANV7j+Rsvaxn5gG2o1nqDMgIQ=
Received: from MN0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::32)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 12:29:45 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::d) by MN0P223CA0011.outlook.office365.com
 (2603:10b6:208:52b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 12:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 12:29:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 07:29:43 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 07:29:43 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 (Ming Qiang) Wu" <David.Wu3@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
Date: Thu, 26 Mar 2026 08:29:18 -0400
Message-ID: <20260326122918.3486416-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326122918.3486416-2-benjamin.cheng@amd.com>
References: <20260326122918.3486416-2-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f0ff8e-7486-471e-cf47-08de8b335c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hTQ6ZPBJSu/B/eKe1tL+0vAuXWz3QDKQ3IUV5Op68Hl8DTPgJOUC3RkibsSkC5hOgYYhvianihzUFPbTfhCCTi5Abba/ORBZaBNOT2qRKoGucsr5LyI2jcYq41YFyUSm/5tT78SHqANrXvIP2VGBHiK3sx/LSnK0OJwVNJmQIN3ArSU5p573bUgscN9e1D9egz0sXznd5Xm2zuuRwAXj4NM3XYEQV8b9IQqrK3DayT+bP+7EVUVW+04AcOd1l5J8DW9rRCJY4r3VtfEGlq8j1yJkJGtriUtCvdcmw/jzDSTnaXsdOu7VLEekBY2ysX9KDpYUwFjWy5LHTCl/Lpf8KJ0jU3eMug43gidozebBR0RPc7YAP2UkE5+v+iK4LX44/fwGgrlsjt2j5G2DHnI+VlmGlSI8f3dD8cJpqJJ8LHLsJ0nQ5zQkA7PipSkig9Ukaxq46NlWhTpJTsNk8JJNcdAhphD1kc049cA/b4MOdw/tbWMfAAv9ZUQeMPCKev5DC6RhfajnLTD0bbJcB36tzHk7PZpzM7Cd++2U5Ll9iIow0/NErkb3UikGvCqckeNuhxRIw77zQfqaLdLW73+sviWodY501IkiKj2p39e/6Q4hZyZz9xK7/Un3V7dSNHFkDVgSfTRfU5WWUFHwKavCGWjRIyFrv+qTwKgWxsXPshUZEDum+sf/ORZQ4nogR3YXdxzPbRifD5FdECEoX8ldNFxlXYLcsKvdeT0dEF3za3VZOP6fDQCIHsHpfJ7oo2nB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rmlBUMNPc0xs6Li1vHqsNda6nKzZTinSdA8Hp0M+AYHHqBGmetv+5N7K1EdwSpfXuI0r4JRSzjJGdSWRbnl5YjVdib/rfVxGqhJzGppuhOMU9Ek4GPRbtDmpWIO4vjWQBTo8USJYfAb+NLip0Lk74+PalbOfzMH0Nr9/K3hIKioc2zZsjAtFE0uDtbuNP94WLRDPs7VOvO3tVZv1iL9reqHBgGhHZZ2RZyeubnkG6lPORQZ4QHRn894wE7GOF6u5fHPHuLvJcvzInoJfRRZF/UwseaAVuBl6IPYk8qqPSKrLHWLhrHkQ6ri8sgVe6jMiYeE6DG4ZG70J8wYYx09Zjg7ZP074pJc1YBVkJ5gsgVLKnv34xKNfZ0gz++Qovc038mbJyTkc4pyBrNPNo0l5/eXfmpmcGfWQXmyUNEdG4uVoKeNW82CSCGJdbKSRbDxj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:29:44.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f0ff8e-7486-471e-cf47-08de8b335c4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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

Check bounds against the end of the BO whenever we access the msg.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v2: Moved 4 DWORD check earlier and added more DRM_ERROR logs.

 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 02d5c5af65f2..6fb4fcdbba4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1909,7 +1909,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
+	uint32_t *msg, num_buffers, len_dw;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1930,6 +1930,11 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		return -EINVAL;
 	}
 
+	if (end - addr < 16) {
+		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+		return -EINVAL;
+	}
+
 	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -1946,8 +1951,8 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
-	/* Check length */
 	if (msg[1] > end - addr) {
+		DRM_ERROR("VCN message header does not fit in BO!\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -1955,7 +1960,16 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		DRM_ERROR("VCN message has too many buffers!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
@@ -1965,14 +1979,15 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || offset + size > end - addr) {
+			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		create = ptr + addr + offset - start;
 
-		/* H246, HEVC and VP9 can run on any instance */
+		/* H264, HEVC and VP9 can run on any instance */
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-- 
2.53.0

