Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4425606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pNUhHIZU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD7A10EAE3;
	Mon, 19 Oct 2026 19:07:19 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B6F10EA94
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 19:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpVgG8/8qE96ow60uYULTyvugoFQGhT7N/EkNNLEXFCmgMXJwpjrSfk+pY6sYrxRhTqHPwNHJNHRZ8mSzgjtqX/eUExvYjECzVEFYbqDcilxhqwnmEeGC2wojqI2kKquj2qVFPZIO/3h0SDB2rnSqOlUKG2cpCSxyd9r1Kefx2kZB+dCprJI10R5+NCpMLkqOmKANE7oIHCb+cuE+SCEVhIY42MP+N8ibyRpOfcxAk2CkU9I9lcYppmN0aaSZjLGLOOkKtJeIShrc38LKoqnw9zy1eqzwhpkVTZwdrcbrd/nLnpKoeRro+RtbvbqHK3MrDOWXX8J72LhDPbj5qFpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RBzb+Vw/ZvjXg3ciUUnn/a9wGfLq11+wk6M0rnLsfA=;
 b=heSMS2FIA1s97eDgIM1SOVRZ/N9IHzKB8D0pJvjlWlHCQ8COiSuOlh4+RLdEvrVDa98yu59j8vg4uSVP1ENmAOtej9CwIciTvxTqgmDtYcYOgt0ZB+cfD6bJqpjiQwOrTLi9NQYnoc1eGwOcyxpBquFssYF4bilp4BR307B1bKwLj4fglu8gMDCasBuNfFT088G1c/so/gNDh8jVeuCdcfRRLsXbst/8uAd2rIngCsjGHH2rr/otWNJxmNboTpd4kGFl4JjUPERaw+I8v9uTsozKMrwZmmG2bAp4Fi+LX8A3GsBdzU1MGm3ZEWOYJG6qJr0+1K6MtFh9jp/3fQCv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RBzb+Vw/ZvjXg3ciUUnn/a9wGfLq11+wk6M0rnLsfA=;
 b=pNUhHIZU4Tl+GdUWDjU6im8r9R48YfGWLoU03VCmEoVfFSOc3BNkiH1LO5+FFmJ5LdUMia2zD95/l6CnGCF8OPs6jmGmnLjBtERHEkeFAmhC2/yI1HCef7o25CqGqshTX7cFlwcDzPgB/2JPxQSdg1De42T9P0Uc+25n8SqsSx8=
Received: from CH2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:610:51::11)
 by DS5PR12MB741834.namprd12.prod.outlook.com (2603:10b6:8:47c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:07:08 +0000
Received: from BL2PEPF000352D1.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::17) by CH2PR15CA0001.outlook.office365.com
 (2603:10b6:610:51::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 19:07:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL2PEPF000352D1.mail.protection.outlook.com (10.167.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:07:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:07:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 14:07:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/sdma5.2: don't access registers in MQD setup
Date: Mon, 19 Oct 2026 15:06:56 -0400
Message-ID: <20261019190659.2773961-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019190659.2773961-1-alexander.deucher@amd.com>
References: <20261019190659.2773961-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D1:EE_|DS5PR12MB741834:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8452ed-a75a-4fcd-e3ec-08df2e142bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: Z1lVIS1ssWiI7BZCFW9lqWw17OlpBWeGgYqb/hXvine8+MOfDQwBnEO9ADwvLrebQIh/yC7RCE3HLvp4Qx0Of7qSzlsrVuZh26zocAAxRZOBhkk4P9WN//z1RnT5oBHAfaAabgc/fw2ijILakLuPhsnCYKw2M01EoKkFpEFxbD/iBiZvMe3il8F70dCRmlU7RXjDMzfDg2MT+wPOOsbsYYgFbS4os2n8A4dglbpo1smXXn5FGY4Ze53T9HAyn/+3PkEcYrdYT30+tCoz1Y9I3bbp7LxM9wh34jJ71hIwBKdYE413z6/ZQpUSfWSJICpD1fjChaf01U0SnUf5g20fyBVVvirWL6Zk97clPAAO2rYSTPz+7Y6fmZyEDp9zy+fVhYxmfai3gTtr4Nh2GH5bCcGyJGp8R2j+PN4299I690b/zbogTk+RtgHzAUpUQcQw4V+q/Iig4EckYtZkswvVTAuvEVUr5gmht+qdDj09oAWEjo6Lst1swzsJmLZDgFTfk0YHc2wxMyZPjljlGELaYPYqtngZGUoXQg89VCnVmz3OSAkUHUL23yb3eKzq140RW4gKcvC41FLmOYKGCtG+k7mBiLq56lDnQstSAX+QMJy+cF1k6iZNkhQCsdtJXOlVEbQzq15DbW+SiXp4TznIa0ftEnY6ONHQ0pH8ljREiOv9qii1t/nD9d7CMSLKUfBH3zmeThzO8A4GK/bhUBdNLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UC+QwytlRT4BJwumEy7D+98NllamrJ1han7Bk4ugwtkYn/N2j/r0bhusIcnNlCx81az+Nd+j0s2/tleHEUrHRq7O3BJjdNk3J3GOmIBmiqP2JmIb762oKUi49AhsyIU8IivPLJs2eeIa8rRL65lPcv0OHQJclbGKVL+xgcf6VzmHrg9PY+LMEN3LZ8AbllaP173wSlwB6eAq2GmQpQEVNwSOzNU3JOhPg96Vsw1afj0RpLZ4GHuoA9lC41Bm8lygoYKrKVBI+GYhnv4jfAaWDm/4/KvMKyvf4o+K/enbR+Rwk/NKa0qCYPtnD3z79P9xpCwNB2LqSrM7SMWyHrcnLQ2ljkWeQJEql05QU/1MKdzf8tTE515Y6+pqs6gm67AXs13pM71pwCCRwZ+lS31u4ZoRYvSBa67MjW/m43wAurAvmv4kJ+EV+hfEk/DewL0O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:07:07.9241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8452ed-a75a-4fcd-e3ec-08df2e142bd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB741834
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No need to read the register state from the hardware, just
program the settings explicitly.  This could also cause
problems when gfx is powered off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b3692d22fb6ad..43a8f0a85cca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -832,6 +832,7 @@ static int sdma_v5_2_mqd_init(struct amdgpu_device *adev, void *mqd,
 {
 	struct v10_sdma_mqd *m = mqd;
 	uint64_t wb_gpu_addr;
+	u32 tmp;
 
 	m->sdmax_rlcx_rb_cntl =
 		order_base_2(prop->queue_size / 4) << SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
@@ -842,8 +843,9 @@ static int sdma_v5_2_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
 	m->sdmax_rlcx_rb_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
 
-	m->sdmax_rlcx_rb_wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, 0,
-						  mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+	tmp = REG_SET_FIELD(0, SDMA0_RLC0_RB_WPTR_POLL_CNTL, FREQUENCY, 0x100);
+	tmp = REG_SET_FIELD(tmp, SDMA0_RLC0_RB_WPTR_POLL_CNTL, IDLE_POLL_COUNT, 0x40);
+	m->sdmax_rlcx_rb_wptr_poll_cntl = tmp;
 
 	wb_gpu_addr = prop->wptr_gpu_addr;
 	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits(wb_gpu_addr);
@@ -853,8 +855,9 @@ static int sdma_v5_2_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, 0,
-							mmSDMA0_GFX_IB_CNTL));
+	tmp = REG_SET_FIELD(0, SDMA0_RLC0_IB_CNTL, IB_ENABLE, 1);
+	tmp = REG_SET_FIELD(tmp, SDMA0_RLC0_IB_CNTL, SWITCH_INSIDE_IB, 1);
+	m->sdmax_rlcx_ib_cntl = tmp;
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_RLC0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.56.0

