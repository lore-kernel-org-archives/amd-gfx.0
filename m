Return-Path: <SRS0=jcLq=QA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F1C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Nov 2021 00:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C508C60E9B
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Nov 2021 00:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C508C60E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53AB089FF6;
	Sat, 13 Nov 2021 00:05:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5066289FF6
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Nov 2021 00:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9lCmzvzJFfnEKT+JZOBG4pY8nE9b5MXw5l9dK5i/6R/vd3q9rIu/Ikdtnsl+0fuC1ryFAs6c8Kldj0HgQ0ROStFAV1nawI8FTacr456iJTB+Xvf7fejEher9vzfqtEnipxf1Tz8FoBQYdbVPU8PZ6DcWthgz4NuA1UYbhfVvb+aqx5g7f2Kj50/c24zMMYTi8ID4DLD8x6mEbtlvnfjCwAgoMaGqH7RWcQ+vjVS7I3quT1osnZF+qkhRo4f0xPtRmMBAfmyJEce6k7SoaWSNd5epOkoL6jGJL8i2ytqkYLevxcfpnzkPqaqmNm0ZFj3jwEGnGOXKhyujmcDJ0Yzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vkdx8nrEuMv/earoEFnrQlmI27a/KbFkbXk0Z5RbdfE=;
 b=EHc/JbWVdck1U6uUyhJvm0078v0hNeQQtYD9Wj6HfGYnIHfDgrOYiOlCk311ZGvZ2LOZ2/pRx5Qwu0r8im+kxiblAmDmveCchpEurItpyAWkGkoayPr9s0iT08rC7iNMExeO00iEn1aNWI7NEgEpdpbwpLGgU5qZjP2SkOaD60TlJGYB/hU3wQ2Qe/OaZjM0IsO8wlqKQor0UdsI6hKE02kpfssaKCBAYFAuKKNxFvZd2/837FyKIcSTHXowDOYXBgs9ktUDXRLAHksLOiNKS2Q0PhWRK71G7SrQoL98CJdZWXA50InAtEAsrDRHYNkQfKEQEBSkIwtGjNwsu0x1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vkdx8nrEuMv/earoEFnrQlmI27a/KbFkbXk0Z5RbdfE=;
 b=bap8GaaVsbSSwNKM8M4m1qZcsN3rin83q4Cx4N3Wc99IPdfVziFmcyH6nPEo+GlAM6Ibn6JzJgTf0PMWX3z/OULNofySVGZPzQv6CCum3M3C21NrgGUs2mWP62BdKu5jsUCc/DqLkULqGG6zBcROmQ+hznc4nQAriivgufjgW7k=
Received: from CO1PR15CA0106.namprd15.prod.outlook.com (2603:10b6:101:21::26)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.15; Sat, 13 Nov 2021 00:05:25 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::e0) by CO1PR15CA0106.outlook.office365.com
 (2603:10b6:101:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Sat, 13 Nov 2021 00:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Sat, 13 Nov 2021 00:05:25 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 18:05:24 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: handle IH ring1 overflow
Date: Fri, 12 Nov 2021 19:05:09 -0500
Message-ID: <20211113000509.21407-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211113000509.21407-1-Philip.Yang@amd.com>
References: <20211113000509.21407-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8944e404-a84f-4b9a-fab3-08d9a6394b2a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548669DB87CF37CD7D498A8E6969@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ObABa9s9r5eOlNRbdpC7XrkTL6tsZHVw09KfV1b6mhJZy2YFrkkNJN2rw9ji+cyr+m45O/IvQDJZJUTpQm9AJFPsCI+wjUqZcEJ2W7Fjbrnd7xa0JEGsa+W8dBiebWztgEHk8jE1mq3PGiRaR0OTqDg4tkT3XPvxERK1mRGMYArYL+c1r2WuiNZCGelJjFte7Wx7kO+MeJMUpQ3MgI/BlmBusc/0ZXLc8L29S4rqf3CbyGeQB6gQiIdGJf3UvoAuGXQ6lrBjEj1sJOZgGAuMZD3ncD0Fuey9xnuRZt/iQHYYMKbbAa3AhT5vLN8yYtY26c3/2P9FLsAsYgwgwkpj7A6pNWrW1f2Woy7tqPoxZGK8Ph7eU0XqBrj5e6usmj4T+V8oN24soed3BB1HBRU7XpjmxYMAdiHFrhiC1kVD5pwctJO73E4gFSuPtli63LnknYkt9yFFOf4+DlNpYsTLdt71B7V9fTuYGkMpkUu6xzxr6oAfzkXD+g5LjECsNT6teeNu3dp4umla5mouNUtm5iS4h/Cu4Bn2pS88M7S2GyPmRkloArCij92WqDfphm/Zu5gCEiX/uYC5ItVrFOTMxAJLHWouAGfI3B6HExzbBn/9qohotS2GbGlMeMSD1BySEC9KVsJuWZQbdZD/xqALoby0kA+9gwoIrMQ38px34xISkwOLmBanE8nyZWqn/krjqzk0hEXSOEzKlty3oCS5W4XePh/iAV8y15rYj5BsfM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(26005)(2906002)(336012)(7696005)(316002)(16526019)(47076005)(356005)(81166007)(186003)(6916009)(4326008)(36756003)(426003)(36860700001)(2616005)(508600001)(83380400001)(5660300002)(86362001)(70206006)(70586007)(8936002)(1076003)(82310400003)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2021 00:05:25.2391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8944e404-a84f-4b9a-fab3-08d9a6394b2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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
Cc: ckoenig.leichtzumerken@gmail.com, Felix.Kuehling@amd.com,
 Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IH ring1 is used to process GPU retry fault, overflow is enabled to
drain retry fault because we want receive other interrupts while
handling retry fault to recover range. There is no overflow flag set
when wptr pass rptr, so amdgpu_ih_process check rptr equals to the wptr
and exit, this can not process all faults if ring1 overflows.

Check ring1 overflows if timestamp of prev rptr IV is larger than
timestamp of current rptr IV, set rptr to wptr+32 to try catchup and
continue to process all faults.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 30 ++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 0c7963dfacad..5f12df80cd35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -178,8 +178,7 @@ static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
 	*prev_rptr = cur_rptr;
 
 	/* check ring is empty to workaround missing wptr overflow flag */
-	return cur_rptr >= checkpoint_wptr ||
-	       (cur_rptr & ih->ptr_mask) == amdgpu_ih_get_wptr(adev, ih);
+	return cur_rptr >= checkpoint_wptr;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index a9ca6988009e..32b3d171427a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -317,6 +317,29 @@ static void vega10_ih_irq_disable(struct amdgpu_device *adev)
 	mdelay(1);
 }
 
+static bool vega10_ih_ring_overflow(struct amdgpu_ih_ring *ih, u32 wptr)
+{
+	unsigned pre_index, cur_index;
+	uint64_t pre_ts, ts;
+	uint32_t dw1, dw2;
+
+	if (ih->rptr >= wptr)
+		return false;
+
+	cur_index = ih->rptr >> 2;
+	pre_index = ((ih->rptr - 32) & ih->ptr_mask) >> 2;
+	
+	dw1 = le32_to_cpu(ih->ring[pre_index + 1]);
+	dw2 = le32_to_cpu(ih->ring[pre_index + 2]);
+	pre_ts = dw1 | ((u64)(dw2 & 0xffff) << 32);
+
+	dw1 = le32_to_cpu(ih->ring[cur_index + 1]);
+	dw2 = le32_to_cpu(ih->ring[cur_index + 2]);
+	ts = dw1 | ((u64)(dw2 & 0xffff) << 32);
+
+	return pre_ts > ts;
+}
+
 /**
  * vega10_ih_get_wptr - get the IH ring buffer wptr
  *
@@ -348,7 +371,10 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 
 	/* Double check that the overflow wasn't already cleared. */
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
-	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+	if (ih == &adev->irq.ih && !REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+
+	if (ih == &adev->irq.ih1 && !vega10_ih_ring_overflow(ih, wptr))
 		goto out;
 
 	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
@@ -358,7 +384,7 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catchup.
 	 */
 	tmp = (wptr + 32) & ih->ptr_mask;
-	dev_warn(adev->dev, "IH ring buffer overflow "
+	DRM_DEV_DEBUG(adev->dev, "IH ring buffer overflow "
 		 "(0x%08X, 0x%08X, 0x%08X)\n",
 		 wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
-- 
2.17.1

