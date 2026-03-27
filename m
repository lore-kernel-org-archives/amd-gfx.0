Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C3410ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 13:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9769210EC7D;
	Fri, 27 Mar 2026 13:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QeXHOZCE";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A737410EC7D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 13:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEHcLBgJXPRxZgTO4xI6LNR2HucSuNZy2vJHjo1sjeKmNZZ6uXm31Q6sbsXJSoryLObzEy7XXEO49mwEsdOA+vTOrqymEVXBeii9pgBymenjjZKUDBcJbA470ewLj666DEA16fA1niuV7lbBsUeyTdU4iZSuMQeqjVJJuwNx2x0eMVENlE/Y/Mn1AtnOY+caa4OOhf+ZSGJzWzW1f/PyG4nKuGQAUbZzKaY+Ap4z173WAcd5qU8sGoZQ5uYlkI6x4L7LAuiEg7d0Yi1E1a7ke4sai/wnO6xRx2Q5WB/7RIqW+nGqpyiNMMUTzzyQSrREO6i3MScnGCYy0gUu5OyisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsSHRsPubG8iLDX5lVg2kofyClwyoN5RhqhGFVwaD+s=;
 b=EJuN8umpKwNedClPpXKuXH36BxDJ/CM/swzYvdDleT+0+DU0wLw7mLGmtl/+aEq6VOVmCUTA/31qzUxMT2apwX8CX9lS3+afUO+pMCg9tTdKewVZWjHEUioCSFiMMOBqx9hsAqQjBOoeSaoPkpmiDGJLYI0NYYADgp69Oqdeg/akzQWODehpyTVsug1HyOtgKn9lYDS962cC1k6gq1E/2fXEvkAE2MaIAFF4LN5dgH3wht1w31mVaTw8M58M+6rJZuI4oorujJiqRlbXmDzaexo3fTvTjHgUcMeEXfvIUbE+vlbCRVY+EVYicNWAZei8lKys4AYw/pW+vAI5B04SWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsSHRsPubG8iLDX5lVg2kofyClwyoN5RhqhGFVwaD+s=;
 b=QeXHOZCEm2FWd4XydCPZXJwOT1Ol23KzCYpI1gbks3xg1ek6xvnSZu9vUbfyscqwU1/qmfl1ogiIVLg6KJoThUr9THW1w+t4W9MtwwUwxVGqnVReJN+kHxowm/up1FoGtkdFSIAiLBcXgQxQFwi2gxWcTAL7nS44fA/Z06LcWU0=
Received: from BN9PR03CA0079.namprd03.prod.outlook.com (2603:10b6:408:fc::24)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 13:04:48 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::92) by BN9PR03CA0079.outlook.office365.com
 (2603:10b6:408:fc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 13:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 13:04:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Mar
 2026 08:04:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Mar
 2026 08:04:47 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 08:04:46 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v3 4/4] drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
Date: Fri, 27 Mar 2026 09:04:25 -0400
Message-ID: <20260327130425.474166-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130425.474166-1-benjamin.cheng@amd.com>
References: <20260327130425.474166-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e56305-e979-46b3-ac1f-08de8c016d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: kU3RPnscqmm2T33rE6YJLeVx1qrPMzha9oxx/JAjjyghvz76fxV1pw6j0jZql+g+KS6s0+QoF49Lc8VF1145xbOb/fkJ4oUCx73bMTvkrK0PbSBpHAPifUmF2wgagTwH7w46KRZ7sf5KUPdIefPlGW311uQbsov/7nrSaLGQcjn/p5H9U9K+oqBhi4m7dFO/1kwcBOi8A8j29CMItCXXwBL/hNsEq0htwScKH4RKiFEr+sdQhYxWyBFQKOJ38f3P6miRONFQrp6FfIlQa+T32lo/fDvzp1nsn6MyYvvm0A9h6yG36uABKsiZ0USHGzj3UeeVEN0uQY8izwKJ7lMfDBhdtevztyK4tO8OnDRFGztYdMNsGgtRAwvJghJN04Een3gFrYomgywzqTbbFxelnPZrC2kwRz49rc0je6Y35Ajrx4jIzIVG7oT+/fMAqUWv1S7qfGDMAK5mQ/PUfXMPZ5XxGqJptJokhSwuAbXQKRSnyXnL5JDpOKFWfPOXyM+U/TXJQfKYws/PZuY1r9VnEm84tIadmyr1ie5xm4J2VgP2ACh/vcbiEOx2wEWVrd46mWaLzXhVHpFeH/5DiM3NPkKp2iExE+Wl4mlaEltfFNukKEDdTxeXYZ2C64uynZG5RPFF/Tc/dDHoJST/EslY6+9qu+Eihb9EEwao+n1q44x1kP94xHf52nJ4Muxsy3QbHNL4x2uJrHH0As3wZtY4td8kENIwWUyYG9GyRshSXWSc8Z/XT7nwfAWovtOLSMN1HgXwMsQXBQL4D3rsJM8Yww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rJW8t3DpkxjeFdPwDBoG4hTXFZ5rb9yGEJv9+wZAju7YZUam2XDTBJPZtirnUEzoF6EpkYbBpe7qZ+79KMoo4dL/UiakUXZa5pGH7fTVqrsVwytPb7suluBto9j/B9R8/CFWdyEzB5G3XeLxfMhUySqGgHBTOLCqeldLrwtCDhUiNyg4HtiW9eJzYvBmdvJV/UNGCa98Tr+O46qWzz2nPYiUdNGGkbjCyiCYXHiX20ueKiLkc1bZ6vQp2ChpU05CIhtYsf49LyrCw3Er7epmeoU98Lbaqu51YF2Ymqbal5LKksfLQVc3pkm+F3pruLWCg+O+iFJW6y8twGPD7u0oBHrjXIyacCXQyI5OiG4Dt1OqHcOmnotyi4UKgh0IXQ8lIPK0v6dF/Lk6wbcb2xSJpawspPYJHqmPLRU2Z6gKbl+ajMCyKQz3MQTtwz8x5cfO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:04:48.4480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e56305-e979-46b3-ac1f-08de8c016d17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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

Rewrite the IB parsing to use amdgpu_ib_get_value() which handles the
bounds checks.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v3: Declare the values read from IB as variables to clarify usage.

 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1a1cdc14841a..5dec92691f73 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1928,9 +1928,10 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int start)
 {
 	int i;
+	uint32_t len;
 
-	for (i = start; i < ib->length_dw && ib->ptr[i] >= 8; i += ib->ptr[i] / 4) {
-		if (ib->ptr[i + 1] == id)
+	for (i = start; (len = amdgpu_ib_get_value(ib, i)) >= 8; i += len / 4) {
+		if (amdgpu_ib_get_value(ib, i + 1) == id)
 			return i;
 	}
 	return -1;
@@ -1941,8 +1942,6 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_ib *ib)
 {
 	struct amdgpu_ring *ring = amdgpu_job_ring(job);
-	struct amdgpu_vcn_decode_buffer *decode_buffer;
-	uint64_t addr;
 	uint32_t val;
 	int idx = 0, sidx;
 
@@ -1953,20 +1952,22 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx)) >= 0) {
 		val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
 		if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
-			decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
+			uint32_t valid_buf_flag = amdgpu_ib_get_value(ib, idx + 6);
+			uint64_t msg_buffer_addr;
 
-			if (!(decode_buffer->valid_buf_flag & 0x1))
+			if (!(valid_buf_flag & 0x1))
 				return 0;
 
-			addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-				decode_buffer->msg_buffer_address_lo;
-			return vcn_v4_0_dec_msg(p, job, addr);
+			msg_buffer_addr = ((u64)amdgpu_ib_get_value(ib, idx + 7)) << 32 |
+				amdgpu_ib_get_value(ib, idx + 8);
+			return vcn_v4_0_dec_msg(p, job, msg_buffer_addr);
 		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
 			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
-			if (sidx >= 0 && ib->ptr[sidx + 2] == RENCODE_ENCODE_STANDARD_AV1)
+			if (sidx >= 0 &&
+			    amdgpu_ib_get_value(ib, sidx + 2) == RENCODE_ENCODE_STANDARD_AV1)
 				return vcn_v4_0_limit_sched(p, job);
 		}
-		idx += ib->ptr[idx] / 4;
+		idx += amdgpu_ib_get_value(ib, idx) / 4;
 	}
 	return 0;
 }
-- 
2.53.0

