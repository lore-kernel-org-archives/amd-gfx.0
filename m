Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E086E10ED676
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 13:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA1810EC3E;
	Fri, 27 Mar 2026 13:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sMOt+QGx";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA95F10EC3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 13:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDmmIRbTNeveJdYuS/B8R1zFUTXzfup/iZwONxRqRS3jhvKR6GzzuPVBNMn4tUU6ajkkM7RQ6hSScv8WlMFgYViw9crjWrQqz3lAWDOK3MtGyf0iW21/oVD/MZuBwtzQThYSjYc3dMxNPpThXDrq3VAtclGKg8vea3SYB4TPOVQYWG5teXpetEis/1B4ot6zoaUDFkvpXOc+rMsAzwiG6a1AkLWuXcIhupUAEtXeguo0RckGe2p4mjtCnyG3ZxAmsFlCrRguqwY2oSDiUqARUk2ganS39UxhvS+VdIKENklYK8PosgtLcCzXAVOjlzoQS1Obt8zh2EygbB91Q6E07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxGFhCvS6YEd99xlJyVqHG2E9uMPb0KVvHsDyv0fP5U=;
 b=fUKeK489OA61lndMHRvOu5Vern7sJpJJFzwAZV81Is78lu/lNjS0rZcBbIpgZjWnc4XmAh5OdWPOXOWhxB2uY/tnLxZrMs3kgfpze/y0VaSunlV9w3YS0y3AkdROGEsKk+4oAY8O5PwmVUnWn4LsOvWHyPccDkxyFp+snKVc+pUHQVD4uH97UkedtWp4qUb5VRdRS8rl4G1p/XjGif0ENLNnmD117bokSfAeEE2ce1DBgwtGzKMP/15obcupDZg0fSYMt9+ktFNubz7knfJkn77vffs2dIwOGpZyEivsn2nsLjLtck7fwGYD3gQPWPvw5L+7QbwkQF6geHzJ5J+j1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxGFhCvS6YEd99xlJyVqHG2E9uMPb0KVvHsDyv0fP5U=;
 b=sMOt+QGxcDdJjkFeMpzKOnU2JqNerI/4ATJXfYOPRtYJYpjPja4XRq3ATCCIqqyuyxZnXUW8kj6Po8+QqghfgV3xeva403ItoyhPPzfTy9LZcA3Vxl/161iMHdxzIZPR0jlzfTAd4cWLPQrcIfgvkTvf+ja0m5aFE9mcx4U2cSc=
Received: from BY5PR17CA0055.namprd17.prod.outlook.com (2603:10b6:a03:167::32)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 13:04:43 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::fb) by BY5PR17CA0055.outlook.office365.com
 (2603:10b6:a03:167::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 13:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 13:04:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Mar
 2026 08:04:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Mar
 2026 08:04:42 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 08:04:41 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: Add bounds checking to ib_{get,set}_value
Date: Fri, 27 Mar 2026 09:04:22 -0400
Message-ID: <20260327130425.474166-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd66b51-bb6e-4e4e-8653-08de8c016a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: jfNKWl5cplxelbgHXVvukjcP+X2T6CRWmSzAYveFMKf1YrcCdG8R/C54LZZ/lCnRMcQzG/DfFg3/DcMubSRLvDI+iEkwSBOJJLLypUXhX4o4tXC/gHyAuTavQ8pLK/62wkAjZDAvQrPvmJ7pI/4Jfo903q1ZL3KPjeyXL0ANAntvD+Tx49+NQbv4B2fEq2OA7PRkqmX32FIZJJNon7gM3u3vG1lfoNnOYThTbSf4C2TW5psCmApoqtbKWUmy5a4pZyEJ9Iv4rgvlXEd272eqpxv+EfMqiNjFaPVjdR/DpXaTFhd4PgCHvytnkX1NhBI0DjfSZ4EewnJFU3cjg/4K9iiP4MdjsMNQy715wJReY/Q42k5nTuq2rmLsz34O+9J0MseKjzPsTzB5gqoaf/b1YuWqRxgBWiJoRSniCkagGs+R21zkNic0kWCX1E4wKUb5JzHnPFSP0uneDB2BdiRPIPO4JmzL05aqoqgWhhwU+PDDbEdCb/akyJUfQMwiFg0onMjD6m0MkUzRXuSq1VSdRAQAjV8IkyqgUNJ7nGZhxxGtWxdMAhzRKcXQR6MTsfVuPt6aGChsp0GBcZGIspFP4MeyJfzVAz6HdQEWn4M0R1Jt3izSapaX4n9dy4rBO29fX38dMce3qSlovZy7xlH1ykzXL1elWABnfzR1ntBL630NpDK0bwmoord7SwHzrJ1t5jsFI+wtBdtg6KFJeguIpUWUtQ4Ad4AR8iVqtcjNH/vzoslf7sqWFSiNQ1WitrIu3f3F++lreWCkzepO703dLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 87IJYC2HKfDi88TplL86Tm2i88C63sNC1WzM4o91ZrmyInsmA8RJjmbYeAA5agJVKo7Pq5gVo1X4h7SICD3ge/FzjYXYWPEvQc3nMfHlP5k62qQ2rAubISbXJL5J1Fvn402mEdOsqYGDSSE6XfVcfcbhXJFlYex/tkhc0rvl3Rpo9bNNbZsABu/HmOAfat1/MlPUyliPo7C0xze/UmV81JLa1ghIIzPLZjDhOkVrbKlNJ7gVAPw247637+YA/nIXUtOBObmvmYtUZ8r0L4REI5Y19F7SJn5efymemEuATNR7VR5ynOglIpvN79zCk7FziLmi8LGj7DeFSlOPRT1Qca+DCdr0IBdxBkTkyKK8hEd7Zh5MQY3VJldz7WarC0ALwTg1JMRJUqpTw3mjNo+zuEOKrc9Tq7kpMf4TSRkEySr9ZwQGvoyJ2dvwIMWTitOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:04:43.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd66b51-bb6e-4e4e-8653-08de8c016a2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
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

The uvd/vce/vcn code accesses the IB at predefined offsets without
checking that the IB is large enough. Check the bounds here. The caller
is responsible for making sure it can handle arbitrary return values.

Also make the idx a uint32_t to prevent overflows causing the condition
to fail.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce5af137ee40..715c9e43e13a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -559,15 +559,18 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 
 int amdgpu_ring_init_mqd(struct amdgpu_ring *ring);
 
-static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, int idx)
+static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, uint32_t idx)
 {
-	return ib->ptr[idx];
+	if (idx < ib->length_dw)
+		return ib->ptr[idx];
+	return 0;
 }
 
-static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, int idx,
+static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, uint32_t idx,
 				       uint32_t value)
 {
-	ib->ptr[idx] = value;
+	if (idx < ib->length_dw)
+		ib->ptr[idx] = value;
 }
 
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.53.0

