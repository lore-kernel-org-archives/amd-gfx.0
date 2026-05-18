Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF4CCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 06:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C0B10E687;
	Mon, 18 May 2026 06:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EwyNeNRB";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67D510E687
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 06:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvcz4Zhr7O/bphuMvsqMSsdNncpcjXRUCHNJWqzpHtY7piltIiFdr17hC4BPm7aaFc1IkIhip4CUw/9YZ30OLS34evwkov8fwDRd1M0yspV5ounujw47xnCrij/NgAm7uCyug+6B2I/UXphZvfoscS5u13pP6DXgENBbdiYRXZNDK6xQyFPgqA9OoxwQy2HqicQK/6V2l+58Pir9HWnHUA++PKyiod8RSuLLxkLX7F+53h2hv4xhv0ELLlRxkGT5E3I2kO+EZKaFeIhBFhcxGAhdKushaBpFUrc1k7N26mJAF+M29Ye9kBV5ijT/jwCE38a13mvZEi08DebtO/US9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETJI3+/0oo0sTS9LVWQhDOn9CkFDpyy7DxsknxAmHmY=;
 b=c9NmwHxlevla8Az2+LvdF7O3UDdi61jTpG7Z6USoGCmlqWfjF0sYHxi9g0uILd/aPDtjnP0xyesMdOV+/F9SUygKwJ+vvir6bMFHUfpmw1fCCZq+kOZ2UifJNTtSFS0F2XMhoaJvOShRm+VBA63kciDKXsBvFodUGMdZMOE4oGFvYO5pvZPJOgdQdWPo8Hv1ErmL4z5fMzomZbbLKy6GzB8QOgSiD4YFhGraVGFunpYE+dpQE5jOd6qm+KFy64n6lwlsH5ZuSJQKHfCDG6tKrp+gcUSlDm5b/m6/cEZuTii7EaGTZhYLRWm8mAML71wF9Vu1Df0NtqRQTq8D9BipZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETJI3+/0oo0sTS9LVWQhDOn9CkFDpyy7DxsknxAmHmY=;
 b=EwyNeNRBEnQEQGlQtexqhPm+PinVQYbryKEuszGuLLSiQId1c3dctYX2riJpLm5gPLarnUHteHFpsFbt2GZd8gvwqP0LEgg/keQmB5TlM6mqExh6zb/4rc+q+jnbYX3XXVZ6Gzs9+YSoMHXsqFJ4Mnd58JqVUM5YzkiahQ5ojqI=
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 06:50:58 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::8) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.12 via Frontend Transport; Mon, 18
 May 2026 06:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:50:58 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 01:50:56 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/3] drm/amd/ras: reset CPER ring on corrupt entry size
Date: Mon, 18 May 2026 14:50:29 +0800
Message-ID: <20260518065030.2311-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518065030.2311-1-xiang.liu@amd.com>
References: <20260518065030.2311-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 615b8e43-0ebb-4159-6144-08deb4a9d105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PrW4rSJCl3RpMhnuYKEL7XpziUhz4mx6GFRYv1sWGJJVDZ0RlluwclqrL6lxGxfPFqL3GeUsSKDPi7VBUBSPmvOU9MB7SMnumMNRcGsX7yzX9D8emM71txr09HrWZoyTE/pxtXM4tltupL6Fro7hJy5rJB0vasIy/cHjbdwgDsjmRMk6/JCBBvAORpYe4docnWMY2OWAeyIUioexPirR1XtcWX+ZJnOihgKewsOjcYcqAn2IhLXJyykON7heV7bFy4uUvJPPWVycHT+8iaa3tBuZ2Olk9RXeSWvCRDsXy0cv4Xykxqcj/K+1MU4nnkgoqmydlxv8HtInx9MRicpd6JBTbXWEHVUIDjHRaZFE/R/5EWbCg1TRJn7zuj4s5RxlEWxbKc+UR6MYUoru5ggFXPy+nJwpbp5NUhhBZydjid7BmEKAUlyUC0C+EJKgJpzgUN6AhLMFsy2o9jvT2DDLnIesU/wPbjcA+7kaF0n8+/oV/rQPaHZhikJTfrjychMP3ZqfFLT3KzfzQPFubgxuqt1eNp7yIapSw/bSO0n7HWDFnFxXlYs1Yao/+5Lop2vYPyr2L/NLjWE62YxJfwX/Pfdfd97Rk4LgTQoAxdLXUd7jAmtBmqfJCo/Z1vuyVO9/P7sSlUFgHnmKLoK5McqoD8/R2d/BkisDDFyuffl0SYlRPRoM3AMmHzFzfiJ/DHLe3QCiWRSlv8y5NUYVJsKghHDp60RRzW+OAo0mGKHAIis=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OWCgdwe4gZLWKrJnXDnauk72xezrPhmjPHd2fzbmY0FcjwTYEAOsl64IlSR/JaIohkXvBkjFZNYtpCtU7tJzgQhDFh5UjhMAvEuqj7juaYvToaR4q029SvSBMR7Y/Nsl4sTHzcYSNq8utMHwjoZ3BjBEW5Beb2mQ1mlU9/o8/+k1cXdNnyThYmhuxykmmSztP+rWDy7p/XCLqnM7KD9oRKftpjbIMfOgoCYNPZfNzKhLV/tgwzacPlh2J/uyQP88xgMKBjxmgOyDhJELhN68lMBPzNk6nKZrki7agzxMLIvteiYog0eE/3YRYLCkLE7SQn7LSyezksUX2gcRycjySHqyvhkZwknt/Xu1mlnUk9ir61ynCkgqed+vC5ZGZON54gfIAhMLhPQL+MyEq0EFRzKC3MaTxpTMvG2/A7KjwUNkOu4fmlzMDOzDn2feIcek
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:50:58.1157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615b8e43-0ebb-4159-6144-08deb4a9d105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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

When CPER ring overflow handling advances the read pointer, it trusts the
parsed entry size from the current ring contents. Corrupt CPER data can
produce an entry size that does not advance rptr after dword conversion
and pointer masking.

In that case the recovery loop keeps testing the same location while
holding the CPER ring mutex. This can hang the worker that is writing the
next CPER record.

Detect a no-progress rptr update and reset the CPER ring to an empty
state instead. This drops the corrupt contents and lets the writer leave
the recovery path without spinning.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 004edc28d0cc..d5e59c24d907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -484,7 +484,7 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring, u64 pos)
 
 void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 {
-	u64 pos, wptr_old, rptr;
+	u64 pos, wptr_old, rptr, next_rptr;
 	int rec_cnt_dw = count >> 2;
 	u32 chunk, ent_sz;
 	u8 *s = (u8 *)src;
@@ -525,9 +525,19 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 
 		do {
 			ent_sz = amdgpu_cper_ring_get_ent_sz(ring, pos);
-
-			rptr += (ent_sz >> 2);
-			rptr &= ring->ptr_mask;
+			next_rptr = rptr;
+			if (ent_sz >= sizeof(u32))
+				next_rptr = (rptr + (ent_sz >> 2)) & ring->ptr_mask;
+
+			if (next_rptr == rptr) {
+				/* Corrupt entry size, reset the ring to avoid an infinite loop. */
+				rptr = ring->wptr;
+				*ring->rptr_cpu_addr = rptr;
+				ring->count_dw = (ring->ring_size - 4) >> 2;
+				goto out_unlock;
+			}
+
+			rptr = next_rptr;
 			*ring->rptr_cpu_addr = rptr;
 
 			pos = rptr;
@@ -536,6 +546,8 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 
 	if (ring->count_dw >= rec_cnt_dw)
 		ring->count_dw -= rec_cnt_dw;
+
+out_unlock:
 	mutex_unlock(&ring->adev->cper.ring_lock);
 }
 
-- 
2.54.0

