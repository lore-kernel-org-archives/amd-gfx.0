Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261C7D38FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88DD10E638;
	Wed, 14 Jan 2026 16:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RY7sb7o9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2591D10E62A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHr/XvCcYeZZMKOnz20i8nwwCJuEYQIDkDJaGBHNLeIjyf2EIjoXvvpxYobScboPXvkK0MhwoLGLfAJQrV10gSfswRIcc5XPYPoZgHLvmaGOZxENdsq+cMK3ltir/n+XvSsn6h//Ovfa7b8Irnw4/as1cXbpC1CAaktOcqPhjqtI5P8S/EvTwvqv8mrqDjFVEGXg5DO0qhJ3rmUgMgaDsfr6BtFtH7UjBP3OmS4/gxzQeWCSK97Kopgr/qqL7EqTbTG88FKZkEwPv98WNv1sbPyPMhATqyh8nSyfNr/MABT9vz2o2HmcMYYtK+X1avCBnCe3/5PG58NTPZBhLHUAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FavRQ46zQE/WaERTejoN0/xIdjfT4SBsn6aYqPekttE=;
 b=O2UJ1Mq8IKhjwjpT1QZB+uU8r57pm23bjSVCMgmie4dPbM9ONSIHXs4ABBRQ4vCSHUslRDH0JVa9/eXdJZfmN8eJ2uisFXjPTv1cwZTFjNSl2LilvBdL0wg3VT2noMSHlrPEmAYAjTgNlghZcUaRfft1MGj7F+bZ3sgYku6dSLcAPYT4qx4qNU6EgROaSlFj8++KZX5GFgedGU5z8CzfvFgYrXAQ/2QE8ql8doySrMT1eSl0cxu6fgu/cO1JD3qiMoGyCUGhkRR0OcwlIFSWnZdRrIURlUsISv1v3RvZrSIH8RjtZJYNlVGrco4prmlxLwkPXthVHAgkIsRuLzjrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FavRQ46zQE/WaERTejoN0/xIdjfT4SBsn6aYqPekttE=;
 b=RY7sb7o9Rm6U6G6jZf+kbgMcjQH7i+GX7neYKHWgAw5zF4VW6DDca1pS29GAj9a+CTvqAVn542jjhjfAfG08zuwyjjiMdTQ9YnIpuruAGvb365RNnK0rvoZI3ZRe7XbuERivnZxAQqAQPsVj73YiM+iKTePCUl90Bgq9o6pYDhU=
Received: from PH8P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::31)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:47:42 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::9b) by PH8P221CA0003.outlook.office365.com
 (2603:10b6:510:2d8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:38 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/42] drm/amdgpu/gfx7: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:49 -0500
Message-ID: <20260114164727.15367-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c71c1e1-32a7-4682-a6ca-08de538ca29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T69OcDQFgi9MW4iyv+4EXsyDco/WtAVQ7RRZR0E8ph4+3gqwpXSn6NrA/5sg?=
 =?us-ascii?Q?qhHnTQxKdjJnmrN7nMI9/YFQqyKLoiLgvlmtupAMW8iT6vXKKKZh13J/4nGw?=
 =?us-ascii?Q?uWs4w0PBovBjZuTY85xLj6j8Y+dwWp/wRwSIHlgMf12f1cRc/5ddPWiM5zl3?=
 =?us-ascii?Q?lWYZGIdIw71d8uLX4xucfABLLj1WHqgtAUHzsre2FZI+08waRMyjDBpOTLl2?=
 =?us-ascii?Q?EqRPRm210HSOp0bf3w6CTUTPXSh4Zo9VBpCEfvKVq7NNLdcB5JVVL2ZihZeR?=
 =?us-ascii?Q?mmW+JW8NPwQy//AhTti6lkqXbPBV/1osYeTIhrizqkVdZ92PMeP0Urm/VlAO?=
 =?us-ascii?Q?+vgUGzGBC48Vpv/0fbfUKp2AUH5T3+xgjsZuQ9YpZoXnWlfmH4foPaJcgjJY?=
 =?us-ascii?Q?PKXSiGA/NgqiZoMiH14g5mi+GlkQnyecbPNIyFgOaInIWShu06y2BRYIpXFQ?=
 =?us-ascii?Q?iHdB1VPtQUL22lJnWDwbAtPFTHbEmx0H/7/rpFDWvTk8NqxVAHMbDmMJk9qv?=
 =?us-ascii?Q?CXpFmDLFpYe/yS0CmutSbyPsG4AA1xXWhy3Rcbg6q9COnPD595Oa+5kEVQog?=
 =?us-ascii?Q?j4ywB0IpZIjZsGIW98yKOvQi2oAUfW2gK/PElUxYsJFyfnJydQxe9t/8OUho?=
 =?us-ascii?Q?ddILtG3zzeHYbMfT2n/9/hvXnOBf3MZ/g33P0xnhcuU1hIWdpWUjJOc/voVG?=
 =?us-ascii?Q?2rVmjGlXUFnNljXNak5a8S9Uo4ooIzbEeAdQGd/vx1RBkcTuG7odSPaxFRC7?=
 =?us-ascii?Q?E9Hll93xGZv55z3Ya+9pW6YXiD4oKXG5xSJK7H1suhZcxntXQPPaTotjWL+h?=
 =?us-ascii?Q?5XcHUQRbO6SIxqBqyVSTAT2xS+5AXaC88qRw/7APnDsEhwLEM4DOzxj/P1ey?=
 =?us-ascii?Q?0GjKK3LkAncicQangieuijMXlPrcG+0XY01G7UIMNzB++LIhYhWX582xMTkW?=
 =?us-ascii?Q?8Mu4p9oxtgdiKuGxL2RuvMnOV47QZXXPKb+thIRdQzHcoCc3wjZwi32e5W6G?=
 =?us-ascii?Q?Dx4nWPi94qJKQC4Xvzr9pWhiZSp/z+Zm9Q2bwRtO7/lYj84xK4nu/n/FMgyB?=
 =?us-ascii?Q?/pOzCTmEtvUSZFn1VNtlguVg7u3AC4TXir7Ze2+vLAqODzwA2UY/BMI4hztQ?=
 =?us-ascii?Q?PnVZghwaQfqeDRDs86ZdM/XdO0sWd8cZAeDxdgHnsW4wunORzHy3dQtaT1gW?=
 =?us-ascii?Q?ikqdfNuFwP+vyi1P7SWxq3Ed5+o4Pz2Kdvtv3bzt0ljU/rdIjT5DOFXAJKoY?=
 =?us-ascii?Q?tedstqG6n/KlcwIqcdEnuIPgrYRya/rZyOlUSa5hICOJte19MGRi8/Pk5UBp?=
 =?us-ascii?Q?XSQCbIWmQB3N5W5ZjdQg6Wtwtfo1jACTdk6M6rKTxAkBrHS3hV022rCQ0szt?=
 =?us-ascii?Q?RMIWkYiEXGdaRujT/iIIie3Eyilnl69WvgLhbDjKbtBU5CZQdAjgWMFCWIAi?=
 =?us-ascii?Q?DHX+DK7wR/IEag9xB+YzuMYVYhuOMQpxhJix0xtm41dVaDGNXn0j0u+WzZIW?=
 =?us-ascii?Q?JiwxKVtcriziWvMMqAQ12NoHtPXS5rVFfpTnzt/Piu8GB/LpZo+HR3R5tnmO?=
 =?us-ascii?Q?/fenZwoxLD8UbhFQUpPcad9vU5HRRUkQsJGtaUmC1sqkgUV0w2GzthzwnNub?=
 =?us-ascii?Q?KEB4wu3WKN3wD7d9ogIvnGgo3nOqQG2aBmQggeAGSnOtBxWcAkHd4EXQPjlR?=
 =?us-ascii?Q?9ZjJCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:42.1224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c71c1e1-32a7-4682-a6ca-08de538ca29f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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

Switch to using a job structure for IBs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2b691452775bc..fa235b981c2e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2291,25 +2291,31 @@ static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t tmp = 0;
 	long r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		return r;
 
-	ib.ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
-	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
-	ib.ptr[2] = 0xDEADBEEF;
-	ib.length_dw = 3;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
+	ib->ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
+	ib->ptr[2] = 0xDEADBEEF;
+	ib->length_dw = 3;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto error;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -2325,7 +2331,6 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
-- 
2.52.0

