Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F291061B1F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 19:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A5E10E7A3;
	Mon, 30 Mar 2026 19:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="basYZJEW";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C47E10E7B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 19:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atplI2nhp7uox9m36f9XYPF4D2qJWtuu4c/qNxm/Wtm6QnsTTtM8TCpDLD7/esb7A8ofocEgnSB/b9ixJ7f+dNstVzu3gokgaB8gnz9I52BiAyQl2nFgPK9QYpdwWZexffVCKh2kq/v2+vy8iHyEnLgPxJsnsQqnvKzSSIxA6rF7cuv0BBCU7jSfqQ9R43mka5fh2ubFMDkZZMIqsEP0F9TuA0dtuKL/l8/liFVK/ljK35wAFDiX6Fgi+lCYE0g8IfuFrwkd1P1KF6sgpo3I3jFvcftBXhv0xahAyy+KEsKycLmJ4D4uWh4jnBP+drOP2NLYwbWpQOP9CzwIMG/WFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RFPvj6HK3As4PLshGZM16V8e7cI2J40nMqDU1ToNK0=;
 b=xwvjrFq6sQwWvq/wolzzbX75tHYi3HDHdBgypsLfFYfZLXopRq2kzJ3E6QSYx0Kc8CVPVLFvTA0Ki5bajr66+Bpop2QFDu3FgKy+oNtffYBI8EPH/49psJZQUzb1J9JHeVZselkXe+hxjU+ETDJ6aqKoozWVsuhea7qNyP4u9SG4U1u8CnyhNBI1D7l7esl611oCw36dO0G4uIYCgx4+sjS+J+pfSfmDXCTQvimCTsQb+ATvaXYHq8aQ4jMeYIJjTHJw1Oku6AQCPjPpEvzZaGbDkuT/sR9NkUFbPLQxmzfCWSucPj1FOaj2j/zPKX8KnpnLLZIJr0KdON00ueVZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RFPvj6HK3As4PLshGZM16V8e7cI2J40nMqDU1ToNK0=;
 b=basYZJEWgLqvIOhJ9HktObNRarJRrMl01DX91pgJeD5jnEpv1+1EQMlW5VtJ5rh6is6yeoa08fxNYWEE4MdiR2X17xTVrek4vLV27USzfmUtAGFT7mgIRPABHpoD0cKWSEcixbxm+JJfCAisB5Ni38bBnE+fhAGxJeiUShSr2yc=
Received: from DS7PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:2a::23) by
 CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 19:58:49 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::34) by DS7PR06CA0021.outlook.office365.com
 (2603:10b6:8:2a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:58:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 14:58:38 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 14:58:37 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v4 5/5] drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
Date: Mon, 30 Mar 2026 15:57:57 -0400
Message-ID: <20260330195757.901509-5-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330195757.901509-1-benjamin.cheng@amd.com>
References: <20260330195757.901509-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 281c7cee-b749-4a97-622b-08de8e96c271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CRIhH7v8oDglxMUwphzzDZBPPRXha74sQaDy7jtk8uG8CKeiO0xQFwJM5r/PPojB7OoLYccJQk3Ub+kehDHR3B3Kl7K4ADUPBLFKaH8TQrC/ru4ZgWXrPBzjrFeWc1X0Oel4LQ0Mj9/Vr6dn5YM6uBueorXO2pg4D4bGU275PZ4v7MbVqP0v3kOot3+rFD5CtWh6Az1q3dfplvbX4k4LM1/Gu0CKi+N2Y32AcuKlsQSQbeb99snOdvdWjZjEuZVCYbgwOCLKDiA4XEn8g9MeRbmm48fegTE3u2hoVjZKfG7m1E+4i/v2mvBiC/G9J+cz/v/R42miDXKeECZPe+nw14swccyO+hgX1QTLkbTu1/G4ciBk5i8M+925Jgp3B7LaROmm9xbPXu5gjOZkprb89W84aru52QfrTcQZ1iZ1AAUpy+qD1HfjSoS9ixhZGAod+/ylhhD8HVQTObOVXExNnmxY6rsgsa6vvzQY+t/iwqioyNjDiYX0CrhYf3EMPoOET+g0U71ceMFR6NG8LsgRFZi7cYkzWlEgC3HL4tCO5QTscesFpy78elf2ACVSplPfnEsVlIQSDxIDuFqbKUdMkaPSnsGxxeouIxWVPisQ3eRfU0Q/FZgd0nd0ZcW8voK1l11smnL9lx9qSLT87ajB65jPqa9vVFKXrwdpdnB+xO2igzpwK/vjh5jQfroOlwymbPmfhnEil6cJDjAQtJUgbn3zqq6vMDHw7hWJdmdNvR893AP7l9l9EGfProKnPrhLdgioVzs+6igOOgUvwHDWCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3AbMQLWfE0PYHMrfx7dN+4hvosMLLwQWWZkeO1L08akYLN7r9EY4nZ8XuecrcNw+RPEtV4hZHnB95E2c5vpdjzfs4XkgZ1K2KfbUYoIfFA5A0eag6IssfESNrUGk0F+zbpUat1kED6F8zI7xfx8UJMoi87ezRhz9gTgZzC+ralOL2lveRkwRntYqmvunN8TtAZmhbEHZd7DKbmxBiDQ65Mc6/0+Sajgecq8PXHtH37SXkSP+dP1ymhEgkmwhN7ZxBro2lyD+LvlsCfHxk/cARIhByO45ZEQDfc+uslhNU4cspMFSRo4ARFOFDjMqp8myujgqq/KsILVVVhDTWPsp0jBW/N75mdH65dPMajPOs4vaVrSWtDtu9QGo02Sbt0+zq8ky+tSmszslQ8hVpSEfKoM56shfkCSUzZRJuFTCKoRVMs0rpW1SAoNw1KTm5CUE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:58:49.0945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281c7cee-b749-4a97-622b-08de8e96c271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
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

