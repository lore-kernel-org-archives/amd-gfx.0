Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6DCC5DF9C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1CF10E5AD;
	Mon, 24 Aug 2026 22:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fdIV46hZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835FA10E5AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OphDYXC0PQ762YERWeJapO3D6/2ub25vJEsofCXVJcs4E1A0l0h1BYOkOLFuXAQjfGQr2febhKWY9E39dxlzkF/TrE3LqUMabfRAtgsI9Gaip6rBYBg9CUWptVSTMROvZNqn0R2juwXacL4xvUhda7u0pC1+R8JFPF2/YxP26pujqPs1XmleBokinbD/xSnn+s/aUncEoXEAaX7V65gnQpF55cUgwAkbCUMqTS8Q8ztrbqCo+QUID/kNLge/JwHg3fSRsAbz0QwBS3R9sAksywK/CXWG3lWQWcKjWFQSuStidOihn3ZXOlaFFtgZ0UGT5mAwCXwqpgtWndqlGakSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHSPlCKEF+sja88zj6Xv7Tuy58jWiRjAi4zKg46UUEM=;
 b=rK94Y/US7ZpKDDTdD0Cxv2xt/a6LzhHmkdPi56tAnPVSZ/bNETr+0bqqB/FhrmQQXJ5eNP62ZuyQbKPO1AYPE6CvhBxBQZfCOiBU9j8IohVaRMQ3GIx3uVkT3gOlCL/bPkemytiw8+wewn1JTB177cB/585GOb9AX7/sTtEnVms2nacErha+DWQSGJKFAEOm/ganL8/P/g97cgk25nRTP45kuwLetXQ+uES/568/mHYG7Pqc6LUOuQzdvyxYzbB9oL71CA3zul0yn8thhiqw2KANVaNq6SORoyAnAfAv/QZu2yEA0cW09p3WFdsc829oTkuN59wACy6aTbdBZYGxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHSPlCKEF+sja88zj6Xv7Tuy58jWiRjAi4zKg46UUEM=;
 b=fdIV46hZIL8Ok2fJm+4ofbcSbUKfc2Fff7gIyzbLigYkAcZwO9sSzQkqr2o/W1i+Lg4RtEvak300yUFsS02HqhmjQCpp07YuughkhyYCjmG9kGmvHoKXZy4Bwy4mU9qSmkYL/B6jU8cvT2MLoNG1Sp/dHHTtnGmGea+dqtQ0R4Y=
Received: from DS1PR03CA0018.namprd03.prod.outlook.com (2603:10b6:8:233::15)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:11 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:233:cafe::69) by DS1PR03CA0018.outlook.office365.com
 (2603:10b6:8:233::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/30] drm/amdgpu: add a buffer funcs callback for TLB
 invalidation
Date: Mon, 24 Aug 2026 18:13:32 -0400
Message-ID: <20260824221352.1793542-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 59534bed-7ed5-4b6b-46a2-08df022d062c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hMHnWw7W18LXl4g3anqQXP91uQHWRQYlZ6eCQWGezEJyJLvxqsoiHIwFdbSYMS7JQDxgLsTAPG3JE7mZNVktxPqSbk6NwU4XCZ+pfulEW6G0nvp8ZVaBfdSfgDmJN6NePaydUUxG7x4P5XX53RcQVGB/V3mq8s5+6oqM7c4ZBMdv5VpocpQjepwTqwkXcaE4xSyWSN/pcsBSQ8kqpEmMrUKK2+vTA2b5sgXnAO6XwFcw+Wc08JJoJaD3dr+3tCVzQaMdUSYRvuIQpiCPcmNbbegaeLg1ojSUG2IzTQSfWrEqdEx71RKFPAySBP4UwHf4mhmaruRWKzrAkfAh0cwZ7HpQvCvVAc/Lmj1cCF2V71VpAwqc3/cFJ/bPf6fetRQi0DALclK7gMSqF1nVqTlfTsrOhE1HISzMSoGeqlRjA1l6wBu0Ao53uep706CWkBTOKd3CO9PSiEm7b9w3X5wgZCkvC9wEBLdc0jJ4Wnkm7sjH80Ihi20AVMrsxOo97QD5yPduu6Q+mh3qWXOY08/QcgiGZ8CTX7KuHk6NiDocrHIPRa4V17eekdpaPWx5KrQkkK6lUSjZ8uCmvzRvSMLtZ3zXvRKLaR7f+KrRfaNlPoyMYeAkQPND51x+pPzk3Ijtql+jK0Rpjof+gFMQ7x2rlexdGKWZMczTETck7waehq8uKrE+EnwFsDFSP/7N4HJUyLOCZYa16boFhy1Ea0gJqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ae7ptb+vpowsS01o6zZqJ4MEiRFrOMIOJPxodFm/QgEotjVkTP1ybv3/iU/9H/S/+yXHHYLDTTDJe7oxtsbfFFX2laZjSQhx4wR/iS+jNOqH7ecEaCd12oLXK/17T4wxgEX6gB+KKEkO5jEs5tRxFD7+WMo7mLJM1xAey6yeVq71153bZWCTDHT30KM8ZvVrKU86b+PqMSNdcMt+KIZCpFIQ6NYSBT+1asxmMSofgPNW+DCMzUOynJUbRUtiCoug0DV7b6MuXht/kBywW0YjZKu6NRPW1ab6j/5RoSQeULV+s5uH0NFNoUPuB9ydWjKxw4iowysFq8bdAbR4pPg+xgsxdOtKwihw8bfPS+AVFGKGxFnqRnZeGldysbPvpdDdD7wpo+UiAStHt4ZyEzQ/dqOHfgjPaGmuq3X9u6MA7rB4Myy0HSKghc49DgVQ2Ea8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:10.9616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59534bed-7ed5-4b6b-46a2-08df022d062c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
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

Use this interface to issue TLB invalidations using
SDMA.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 4f4e56022c970..4ab92d287675a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
 				 uint64_t dst_offset,
 				 /* number of byte to fill */
 				 uint32_t byte_count);
+
+	/* number of dw to reserve per operation */
+	unsigned	tlb_inv_num_dw;
+
+	/* used for buffer clearing */
+	void (*emit_tlb_inv)(struct amdgpu_device *adev,
+			     struct amdgpu_ib *ib,
+			     /* vmid to target */
+			     unsigned int vmid,
+			     /* vmhub to target */
+			     u32 vmhub,
+			     /* inv eng to target */
+			     u32 eng,
+			     /* flush type */
+			     u32 flush_type,
+			     /* XCC to target */
+			     u32 xcc_inst);
 };
 
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
@@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
+#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.buffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
 
 struct amdgpu_sdma_instance *
 amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
-- 
2.55.0

