Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFE710A3D8C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8B310E381;
	Thu, 26 Mar 2026 12:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GD0+ug/K";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F40510E04F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scKQW9YqcpE9pAou8YLRogzJG1OSY/Dt/FR3nThrORqPBkFxjJ9sG0HPaCvXo3jd7NZwdZ+J7BssVowvtrBHVF6lkV7ljzAkSyQxh44qYVKvfpHPmNiB6SQrmiYwRGwriSKJu+qbNjzD2V44V3gj2JwgChzjV0GW5ynxcBFZT5bYqoasE7ZTgz0ySkBzgVDbpGj/hv7RUXl6TOliGMJO3/5nEw8glqLAq4bePHMSYatbap7h8LxBko3LswEePyZLPs70AnoJzXp1hSvW+UrPEYkOKokLEX8AKTaxoechww6ITkgt1nNnySyESzguBJQLVJVZ8a6LNM2HygKMubBRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ66/gAWFDr0l3jRnnCA97r8KJ9i3zQhnlrp3olT8yk=;
 b=twlIN5dJcqB2xME+HdSfBW1tn0EZdAf36Td1pCJN9p4GvQmh9DAfvh1dhUcPQHx9JLgprwXKUJ2dFrLV5hVh99WRpIPfLGW4FEuyCiU/GcngjGxffyf+cmZOQbEamzgOWVpkMFWv2dKxGloyAtAjVb+eUDIHDz3Ny1qzFS52Et8s4Q9aRlm7GafUG8USEdCOIRLd5/eFJHuYAsmFbwHrn8eOrf+2RuQNAYfgBSTjocm1co7OMfyDKZO1cfJWYnRCUb7y1oziYj3/WkwAZ6+by5k5LacR5ebBEjaCsKeu5dsODEbKNAjCSB5MC0cM4gWQ4RhV/srA2enRg/1IAQhWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ66/gAWFDr0l3jRnnCA97r8KJ9i3zQhnlrp3olT8yk=;
 b=GD0+ug/KQNyH/GTSagz0WA5SJyc1ISGBGw+FiwrLKSKOWu/HZ/mV9A+Svton9zYbszquZArKunN52buX3ZmQEfFUqqY/bA0ZTrFpwtzIzHDgUJTxhzQh4tRGH0sJo7Xu5XhSX4eCKBIg8GpeNZraskj1rKHN1z1gd5nhhua/H+U=
Received: from BYAPR02CA0042.namprd02.prod.outlook.com (2603:10b6:a03:54::19)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 12:29:47 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::e6) by BYAPR02CA0042.outlook.office365.com
 (2603:10b6:a03:54::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 12:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 12:29:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 07:29:45 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 07:29:44 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 (Ming Qiang) Wu" <David.Wu3@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
Date: Thu, 26 Mar 2026 08:29:20 -0400
Message-ID: <20260326122918.3486416-6-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326122918.3486416-2-benjamin.cheng@amd.com>
References: <20260326122918.3486416-2-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0fc108-a676-4aad-f016-08de8b335df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ue0xs6sq1ygvioZOJE7ywxQqcyLT9VsKUrQXp9CbNNb4bOw9HuVj4JisYbgUJJ7XsoiZMjGQHbMWDbl571Eefzh2MkjAXkIKqTi81C4oBhItUg7hfZa+hWVFbJ4j+Qiqx8AGlOUDjslvp2eQTvjxuyN/3x/2JLdBE+8EEy1swbkjAFQnUyIZa6FfCgPj2sQYA/V38FpQx1Ps0OclNvYensMsquus3SME9K+hW1RtYwX8zKz5/eaRXgz0VYDtymspPxNWcQtsDDtERGJhjSJL/DwQEDW42NVf9uqM/BaRUNaimJSlOhhXcFtP9FRdFT6OCEfn1mC1ahQHAuy8U19aUGZw4zwxFhs09y/ScE0ii18Cuuk05O22CW+tNdby/G6Pg9iLf0GHSgLeh5UU4IzLHdZ9MRksncDvy1TdgXyhVsBBNylgE4XFyvqHKLOsacjxu2z+2pZmqRzTMVJpzGFAzTvspzkA9Ty5WapFPHMgzoMFTigIkBs5EG66BWjD077+9dRL2MecOBBlqdsozvBEe+pHJT4EZWazWRo+HWTJkRr1a9ITaS5jlr3nEM7hXt/t2dv4jOs2By/smnGoE/1NONSmxj6ucJ1oKF93+G1NSrCvYPSBEHoclnmR1+0OPadnHC3a2f1WipwhklmyKHUw6TU4HTrMn3imopC+IirxvByxeNZdFsq6OAPOMlvMafJEh2P3gfLYGNxNabiYbwfqctTqgidx8wvJb4BM1k+8rtGYwHPiC4t5BD0lomAbb45aSZIdVNRY2z5823jVW13E6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DiZ87SOgCBtw0H2lxD2TYvCbKaRSnUbzNOBatb9Yv3SCJeFTQQeDOExXIyvYt75taB7LPhuj06HTGl1ww98ENHaBZVrLnuxwrhlkf/+yvna2EFvyoiZom8uQ/bmKd9ZKpiEbsk0SnXVOl4FU9iNZeGuQU7Z+zBKvNAhIiw7D9T06cuPKOQSESUVHNG7g7md4waNu/rYMvBDsd307JI6wW3MgPFyPY0c6OCdvMRZvwwr9nCYJb1TCF8AIFFgMvEivOkRSXjk86mPn3GG4Zp5Pt9A78piZcWhDACaMbezh5vWczGSlFh/+eVsVPGvsuUOLGm9CHr9SXsMkQeC/L0seKdl0mK+ZVkLCb3h4xyT5NW+GGXDD9yPs7YxKbPiGwhQoMcl2TUCjmA+XSY9/pEqFhDKqXnJMEtBYFhAJ6jT5bM7dXYoQrYpYBC/Y75LDilv7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:29:46.7640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0fc108-a676-4aad-f016-08de8b335df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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
v2: Rewrote using ib_get as suggested by Christian.

 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1a1cdc14841a..35c014861df2 100644
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
@@ -1941,7 +1942,6 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_ib *ib)
 {
 	struct amdgpu_ring *ring = amdgpu_job_ring(job);
-	struct amdgpu_vcn_decode_buffer *decode_buffer;
 	uint64_t addr;
 	uint32_t val;
 	int idx = 0, sidx;
@@ -1953,20 +1953,19 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx)) >= 0) {
 		val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
 		if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
-			decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
-
-			if (!(decode_buffer->valid_buf_flag & 0x1))
+			if (!(amdgpu_ib_get_value(ib, idx + 6) & 0x1))
 				return 0;
 
-			addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-				decode_buffer->msg_buffer_address_lo;
+			addr = ((u64)amdgpu_ib_get_value(ib, idx + 7)) << 32 |
+				amdgpu_ib_get_value(ib, idx + 8);
 			return vcn_v4_0_dec_msg(p, job, addr);
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

