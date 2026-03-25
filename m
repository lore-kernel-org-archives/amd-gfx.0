Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED54D109C04D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 17:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C1910E7E1;
	Wed, 25 Mar 2026 17:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ef95NISc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013030.outbound.protection.outlook.com
 [40.93.196.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03E610E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 17:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRiHIZ5pzZhCXGX4tDC/fKMH6dasXB2nBX4WtrIBaLfDeebkkK/OjsZL8NR+u4dhFYiy+5QA+SwP9D5CdnkrQ90ZJdvTjNeKqKCtBeo/C+JZ31CpUwp4AwXn6sV8r4jcHApnIIZTWPOTVHRu5Pp3/s+zl7cJVeo+VgMWpwSXJb6Lf9WP+CuSLzlLZNFoY0TP/C+X/BNx2qJpXgQm4dz4PxltN5h2XxUFX+kNjyy+yURPn1jojyRvfzKFDABR0Uo6BQU009VGr2PRwWk02A0JaEyXy1rJO9S03WqXTJ/7foz8NUvLA1F3r85QUiEg3Xr0ezIj6zp3CAtIGMu35NPW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItbHfK00ivJfoBzSMv7NdyfQpajh36aYebJ+UFO09mg=;
 b=mxcov434MhtKnEmpkCSI7IKrUnsvrUDwSZGRR47x5T6us9Ns/x+r7Np6D9yxCozGa8YFBKuJxpu1Jbzj+cz+JEA5Dq4G0demZGp+nvAJYtVCljjSKVAx6KJdV0XvRLDLQH0t7ahm2Lk4f0twgr8ivvAMRhrEW+5HdUJMMCVv5qfJFtZxL7ZH1KAOfEQn3mMdlR7lGmUo9ci3LHF4yPbCxvQXazCL/Ew7LI5rREwJjGCpiQ8ykQpedo0gCnFifu5zSjZzRSlK5Roixpobqk25IFvjRxV3mgVhLjJr5NGN5c7H84lo1EUodbBSEB2uzo7EQwZOCC339F054ewa9CQSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItbHfK00ivJfoBzSMv7NdyfQpajh36aYebJ+UFO09mg=;
 b=Ef95NISc1iK/oLsbOVaQ2K9eeYJluiKDPx1YvcBy76hwgeZd4IeW3uouFyWgsOWADDycU147mDN6340oBAneD5od7kdU9fzajVgGorw2+gPaxo483P+TberqsCRcIfA7+IQvWXNI5VXtVAVQNu0x1GHSnKGljCgToPNuz+B+h88=
Received: from BLAPR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:335::6)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 17:52:16 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::35) by BLAPR05CA0025.outlook.office365.com
 (2603:10b6:208:335::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Wed,
 25 Mar 2026 17:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 17:52:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 12:52:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 10:52:14 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 12:52:14 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 (Ming Qiang) Wu" <David.Wu3@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
Date: Wed, 25 Mar 2026 13:51:33 -0400
Message-ID: <20260325175135.3326685-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325175135.3326685-1-benjamin.cheng@amd.com>
References: <20260325175135.3326685-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: be77317d-7fbe-4969-fe1c-08de8a97405d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /pnEE6OVCl9R3zlsxN2ihMqmiRo7ePdQkRtcg4E/RThLDT7pwfhxcjjBr9AqaU04lzYOgHNwB0pfUTsV/uARdg5cp9xZYZhExPsSAJYME+USZk0uUYxl+1fIgpow9Jya6MwdS7fevwMmuJEkZBzJ/mn7EWRTJIHIwmTC98k5aySOYJSjY1ySch7RZIE9+rjV0gxsPBlR4IMgcmxcLjWXDJo+ktun0fZ7V78ewdD/3koXW8QrIKd91axQPMvhpCbzbIcLrjo/J7f4mRw9/DwD/BHZNXJKl1mHWletrnAGE8MW8u3SOu1ZpaXhOHiqQVPFhClOhX9iUgRc4N18iHaOLTwzCWBARrctl0iTVdLEbmPwKvs3GKFHOC6Nb/d789dR3q+FzEKeXtBOZJ8UZYnMAHXopau2bS/ZNMOHQE4eIw2FNlCROz/jvrtiwA7/YFiBD9XBmHRoVaee3NAO+oK/jz18FVZ4KyHus7tXqipgJQTsuAGzCeM5cISdxITxwQRLZ9MA3nb6YDZV7hLOqsH7s/RQgWR659ytNCQdTWmNUzPvkCqZC7DwUe3GPm+SsusrDwJuixhAv9KYQ/vpyR4yTM4Dz1k0FJQu+NoPj/yvy60kdEljjEz2VU0l6+4Qkw20YxFZA2YZzSINxlVnKyk8JCUb76iM4qkA4qDT7nAi7V7xeQ/4DTFyu1jUsALf3fOxzvt+x78aR4QryDpIf2TIa8ktGxZacNgrpCCkWw2fOSZeWFIDn5/kK6fniBLohduunwGh6ud4flj9WP6EIhM9cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 05G04i/lAGxMgkjR6pp7A8pDG+r19ea0BmEwCtNXPRuh5MyPpBv/3xMYMoo0rsIg0oH2xCrsKE4sWEuenPZOxUFPyS9Trli+mb8ZolINNOHQSbLpCuaJLtE5h7OYKo91uaQsGd/8kOtBKFzIe3oqiqzrnNHqgGxT9rVxMj8BF4z9/2rWngaHa5U1Tlr41CnO9j35BInFForGlknUBwiVZgz1SmsFA5h6ddKE88gn2duPI124gvnR3B2YMd4sJmq1pkzLhSHaUNCrncVIL4TsD5YYBJ61oFarluq2gRnigw9a4h0maMe/ha4sYavRsz0eF9myO68tEaQxnPfp7tsc2vRBh3pqbVK1ZeN5zNH+ZbHM/o3NLQW0qY3v3dGg74yETVOBS/N1wIEIw0hhqtg2C/uf/eCEtfGfMsgFsCuNqHW+hURUFE8PeQnLmbCV69j4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 17:52:15.7416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be77317d-7fbe-4969-fe1c-08de8a97405d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 02d5c5af65f2..500a337e8987 100644
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
@@ -1946,6 +1946,12 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
+	/* Make sure there's at least 4 DWORDs accessible */
+	if (end - addr < 16) {
+		r = -EINVAL;
+		goto out;
+	}
+
 	/* Check length */
 	if (msg[1] > end - addr) {
 		r = -EINVAL;
@@ -1955,7 +1961,15 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
@@ -1965,14 +1979,14 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || offset + size > end - addr) {
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

