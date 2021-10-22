Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91878619E2
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 91878619E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E05736E59B;
	Fri, 22 Oct 2021 03:34:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33DFA6E59B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 03:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4uddAlIwpLHe2sUG/izBfDFhXLxA5f69un1Ty5LDv2TaMaLRAK6eUopB54VnKkZ6J7E5q7HC265kJp1H8+kxkWwbBGH4UsEQqh4oElbZ0H8CzvwdH9ARkNVzkPMIrdqiJZkvL8ZjJ3WYyX0Di5VJddy5HCZb+HCf9t6IV26LIAdrSo56wdCE5w6LLIr1Or3wsYjmyU6P04o37jk8C6W2z86P2oZ5fk6hcGG19fF6j/7wI7rCxdL4vvi0Bbz2VnD3OY7IPlaz5HvtNEnjuWhjJLwpgZlQfkO9h20f59qWUOYOt1OKDdfp7eButwc4xUhHRdRUz/yskfTs/Foy+exJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNxppcg45VdydZdDwSGx7jUkJZGsnUYowTsBCANHj8c=;
 b=WWn+0gm16kLkr5WZLA+nhg0fNWHUjDDYKiGr3bNi2FzhqvVPkGasYX57vfRF96srgPDmr+Fpnhe5wRimdya53/RPRViXOWwZk1nO9oAO6Ue36q/m8f3ETlBSkyC6wqLJUFkavGBx7b9ACNIui3fiSI6CMu1at1gnGhtwY4dEknLa7NaStCAY3tILSChRkj0hVAK57IDC2uaMexAA4cdmp+wLLjfgfmZOOq/PJUt30R5wMNwWE3S1uawa22YvlwM4YBvPjwiNkRh/pdwuQCA3nOd6j3N0dQVd1JtQNQVflrJe+xcdgrR4wa66WbiNGoqGLLCWvHUAuM8f7ul0DDF6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNxppcg45VdydZdDwSGx7jUkJZGsnUYowTsBCANHj8c=;
 b=g1JfuKj4l+2Jb+ol9a6DdwuutCY2SuU3wYnoduKeqLN6Dvn7nGZB22rQNNGfyiloSn0+rrU+kai1Vc5SKfxYu6P9csQO850XqS7bh4iui3aBA4UltNG/mR4PmO1mZF3W6hPMqR2Ta8wpVnSoWk4bOoPCBdsdmlxFBBg6NS/BULU=
Received: from DM5PR19CA0040.namprd19.prod.outlook.com (2603:10b6:3:9a::26) by
 CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Fri, 22 Oct 2021 03:34:41 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::bf) by DM5PR19CA0040.outlook.office365.com
 (2603:10b6:3:9a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 03:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 03:34:41 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 22:34:38 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <horace.chen@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
Date: Fri, 22 Oct 2021 11:33:55 +0800
Message-ID: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b748e01c-d322-44fe-e384-08d9950ce1ec
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4277D299FC70B9B637D01319B7809@CH2PR12MB4277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KZOPgWSS4SiqDSBksnpUjWPU2LIJwJ3JgACG9b65hOc5xa7jBbY7hn8nI+mrysHZeS5ijTBq/pBwiyZOVe8nBTHL+c9QK5/aohAjBflNp6KHLU11jz2RnsPiKLOwB6lYNgN46I0Cjel7WxAb3F3vKxfoD0g+BCm8qh+RXSHyrUpzNrLeYRoWEYd+O88ipXt5/bnCUy1Mu8MUcqJuFys+tkyLpko/0entTHGrW91C20aQ1yolZhe2R6WILV1U2AgNU0OSOsmhHh01b6powqglH8E5gvQA4zv2Dms2teJR11MTB1eTmn5YCTvP59tdZIYJueRtGUpW/6N3q8xfDY+RlfBlzgc5jFAUPFQzo9BPN639HDfColxGY9ZlOy+2ITeR+PtHisdHCT93jYqALJf6uwiSLnJeC7CU+4cTaGdWG5btoOQKF6lOV4JgXD72nmDUqoHqrFdCkoe5nwQD5+RCi7WfYuTT3M6dUroomh6sg5xQ2OgvT2KB9/Op5ivteuj0HNjr1ez/D7TaHe7MigSRHyOWA2WA5SUHJi6EFtkXcT6Dt2d7M3NxdKBkykbyfUB5BMRNvuuQ6fmwTEFZhiioBEae/UmmWwDKcOOehWJH94QxK94lHxLks88GWstYoJRhLuGIyUtau2HS0bB8FC+JrttVhhGiJfFwaMe074RQ3QCj1cIYCLNmNwmI9tF/x5sRelomUYTmvvaShPP32uVPN7XfONR0bXWKvYBICrHkdA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(8676002)(426003)(8936002)(2906002)(82310400003)(336012)(508600001)(81166007)(86362001)(36756003)(16526019)(186003)(47076005)(1076003)(2616005)(36860700001)(7696005)(316002)(5660300002)(54906003)(70586007)(4326008)(6666004)(356005)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 03:34:41.1091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b748e01c-d322-44fe-e384-08d9950ce1ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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

[Why]
In advance tdr mode, the real bad job will be resubmitted twice, while
in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
is put one more time than other jobs.

[How]
Adding dma_fence_get before resbumit job in
amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 41ce86244144..975f069f6fe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
 
 		/* clear job's guilty and depend the folowing step to decide the real one */
 		drm_sched_reset_karma(s_job);
+		/* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
+		 * to make sure fence is balanced */
+		dma_fence_get(s_job->s_fence->parent);
 		drm_sched_resubmit_jobs_ext(&ring->sched, 1);
 
 		ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
@@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
 
 		/* got the hw fence, signal finished fence */
 		atomic_dec(ring->sched.score);
+		dma_fence_put(s_job->s_fence->parent);
 		dma_fence_get(&s_job->s_fence->finished);
 		dma_fence_signal(&s_job->s_fence->finished);
 		dma_fence_put(&s_job->s_fence->finished);
-- 
2.30.2

