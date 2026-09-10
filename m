Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE602C79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 07:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2212E10F32B;
	Thu, 10 Sep 2026 07:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qhi+3XAT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D5E10F32B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 07:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkoCNvAUSuenau4YAG5XM+8nI/PspoWWv8nSq+PfqGfHjoXG5dhReGIcpKhx/lIYHAUuPpSTH/os9q6h6snIfxBwEUu+I1sp0hBdU738+mCaFZYnPkm/uqmGvos7cYtkmjJgGkSZflTV/orTLYz/aS7IGjNOE3wjdYdlekKyrToFSAd1vQCy6l7VcFhdh5+0MOAqMOPoA6d192NDxkJ3P8BSf+FMM8fEFLMOTVbWbwug4VXWtG92xC1w/AbECKPkBF3qLGUcYMYQGfzt9h77T+PN0cQRL2Z1wLzhyxlnrZSREVF6XbEKGgJePI8dVxJ9pFrsxnXlaeBCRaFqe6Hxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utUvEg/kUgWHCh3X3mQUKZEgpjQTnMTO2XSsIkFRG+Y=;
 b=aTlzFc4r6U9C/yjkyKaK2lkSzzRW7/oPqPyb0kZJLDm12hgnuSYKvA+9g0E+pM1/hss9UvHzJq6PZiN77HO+97tkWx0iRHSOqixf4S25Yr5ufmQ0028/d8LQdZSRFm2Eq0O0DqcD+mfotDFr0nSjGRLLaH7Q+4+xJCfrWpWvTIuFoXwBz1uBmKHr+CGyCnrJFcjl7i9gN7KLVpZD+K9BczqBp69VIVrr6ZVwlIdugFP0PBgjWxr7HLd/QIYehximGG131IQs40fOZCSDnDRVOmbDQK6+d3E7z2jjBjkRPiXWpTuCa/ZxdgxJbOxLPr8C4I90+uQa1zSoxPJunfyBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utUvEg/kUgWHCh3X3mQUKZEgpjQTnMTO2XSsIkFRG+Y=;
 b=qhi+3XATdqrZnKjPDzp0NT5kC+xLpCZiMmagfBLhR0RkyJUjVO85C5OJj32P22Ztm3vFq+Rs9LqEmkzHmh2YI6NiHqzwEueiDuPrrAcyUaWMi1GScqG6hw6TWeSw7trt3GijhaUr13OQ6djyxRtatR8GLzh4jxTCSlZKISw3tpo=
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by DS5PPFC9877909A.namprd12.prod.outlook.com (2603:10b6:f:fc00::661)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 10 Sep
 2026 07:15:47 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::6e) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Thu, 10
 Sep 2026 07:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 07:15:46 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 02:15:40 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>, Gjorgji Rosikopulos <grosikop@amd.com>, Bin Du
 <bin.du@amd.com>, Huang Rui <ray.huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/isp: don't fail suspend/resume when hw
 callbacks are absent
Date: Thu, 10 Sep 2026 15:15:26 +0800
Message-ID: <20260910071526.419494-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS5PPFC9877909A:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f090cda-23a2-4ca3-ff94-08df0f0b55ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|5023799004|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: sNlzl6nbRSz3GVEIIdKJDcAnE4o3p79rEMkjyz+aLpanGJO14lCOMD/trB3enVzgAvyx8Ry9nJH9R/zPCByaDpG9lQvlINxIlAj3OiMOMRtu4JMCEuLKe/nIAgpE4at2+6Gzy/CtFPzJhZXzqpuVV/tZHH9DxS2tAI93mPNpo3xwb/q6SjHcXXz55w0duYZWy9IE+hiMmSQvTPxq15OsHobPRbmtycB6zGv4q+7e5tX5nGfT59mSuBYC8p+ynZR1ADesA2ycGf60FZr040byQlVKggjHLhCroLqXgAQgmHXZpkiJzJFjTqe3Ppr3Vg0sozgXU+jScdadEkEPWdtMenkt/vYT3QG8jdy+LiOlkl+f5+2LRIOlztmt/YeNHPtZ3lIZ/oHLrOq0gbb/acslDeReX1Q9tQP3wgp5FeIu+XdlwO9l25fthegh/kWu5yLtcoMjyfZac8sCDXdu+i188DKK//kW8BE/1p/bpb8QZUYKh955JjfqIh++ofGqRxc7zXVwU1r6u2eKNderaat2sbtq+Y341Y/ARt0Wu5zPTolshKv+/uMriKq17Os9HAQ7JEcgzVQbm6ZDEI1wD8SY2f8t1VOreFUKWvnOUIiQxCzmbjYjtg0OFqFsvRW4T1b1FaEmvQO7QPDYJcTl4+s8VVOUC8nQCyXUHZA3n+2SsIWBU6WCu03qDr1GVedI/cvq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(5023799004)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NEwwC2CFq/nn2seBpuHa+nauN6zp/hTIAu0rvhfcFvcRPzi+FmH9OX6dTJC8AKt+vHLk0ud6A8PA60BQpYOC9unc7iGPTE5Pv2E9STauhy9iQZp/rr++OXVQA2YwInjDeGy42YBbvw6S05dL8LIUUnaZNI9B86gYwR2RXY4k+grSwi0GD0PZ9hUI/7qeifm3haX7Z1erP40e++KwMKRrZcV231xxjO7F0cebI8pklSGNW9o+KH6kOJAqZ4Ha70R8/eUxnIkNJme6DuNs1VWWHUyoS2DXBaU0ScUJKpXxGirRvrw5h4Bak1aaW6x2v2BEs38D7Ij2oHe1nuH7Dr1FmvOIZUgySFAj+2MaiUjX1X+LM/Oo9SeYphC8PZK5PdA2vff3jzUSDiqg0KsTjCVQqGIP7I1VjyII43VUbGn38itzr0kGbb+N3q8OTprqf9OR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:15:46.9789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f090cda-23a2-4ca3-ff94-08df0f0b55ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFC9877909A
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

isp_suspend() and isp_resume() return -ENODEV when the ISP version does
not implement the optional hw_suspend()/hw_resume() callbacks. Only
isp_v4_1_1_funcs provides them, isp_v4_1_0_funcs defines just hw_init and
hw_fini, so on ISP v4.1.0 both callbacks are NULL and every system
suspend and resume fails.

amdgpu_ip_block_suspend() and amdgpu_ip_block_resume() treat an error
returned by the IP block as fatal, so this aborts the whole amdgpu
suspend/resume, for example:

  amdgpu 0000:c5:00.0: amdgpu: resume of IP block <isp_ip> failed -19

Because amdgpu_ip_block_resume() bails out before updating the state,
ip_block->status.hw is left stale and the GPU is only partially resumed,
which also breaks subsequent suspend cycles.

An absent callback means there is nothing to do, not an error. This is
how the IP block core itself treats a NULL amd_ip_funcs entry, it skips
the call and reports success. Return 0 in that case so ISP versions
without suspend/resume callbacks no longer break device suspend/resume.

Fixes: 7ed51e3a1381 ("drm/amd/amdgpu: Fix SMU warning during isp suspend-resume")
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 976b65f90bc1..ad667b9fde84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -321,7 +321,7 @@ static int isp_resume(struct amdgpu_ip_block *ip_block)
 	if (isp->funcs->hw_resume)
 		return isp->funcs->hw_resume(isp);
 
-	return -ENODEV;
+	return 0;
 }
 
 static int isp_suspend(struct amdgpu_ip_block *ip_block)
@@ -332,7 +332,7 @@ static int isp_suspend(struct amdgpu_ip_block *ip_block)
 	if (isp->funcs->hw_suspend)
 		return isp->funcs->hw_suspend(isp);
 
-	return -ENODEV;
+	return 0;
 }
 
 static const struct amd_ip_funcs isp_ip_funcs = {
-- 
2.39.5

