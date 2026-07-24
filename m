Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF537C531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 02:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A3B810E628;
	Fri, 24 Jul 2026 02:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1E4OLky6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296B610E628
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 02:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrM2JAniiktBDayx/wITKthAxBPwJTaS8RaLILjcvDOVMD3q3dvs50J0jFUJuSBLqAVp5wrr8ekr8MMK1pcneC0F//qLxpV3rbgp0dRFW0C26GDGvEzwl/99meonePqGAuBBDRR6RZ7dF0REmniXJfVhRNFU0ScaG/pdbrSSIuMCSne0YFqQecz4KX9cKr80+oSwcaHxT9fkO8mtdSxermxvWpDwJni5gHfUOXABqBNJxBSPrAb/9mXfzWOz3cqvoVIpkBodWSnIs/2fgy8hLiYTkDIBCSlqzOobsY/4rZ9ku1oGVxBQ9+qY/rDVcmtM7sTlT9X4PjoOhtH77Qo0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyPyqHm9z3smVhr5HTp1+fYq5kSJr2n7qNZEDh+PpHs=;
 b=yzLspReX4DrMLPPrgmqNnoZcAaIM+gbIFQ35k6eyzI6jYALt6FmlAnNtRmZRKcwftoO7Cn5LfzGP+0Q7OEzP1c14bGImziSHHdQiPPSwLr4NIhiGQFOWFL4SvHD0WQJD5R+TOPyAX6s0Wup1Bkn8/nwT0cvu+9mgLJo3YcmeiYps9T3iXGSWdCINhnsuhSRmXC+Gpkz9Q6/42Uw01OqTdP+MuXudk796icjp138igR0YHPnZwrHNXNWSRG9pRCuFNePLt2/bYzMxhkiXG8E6dWtrYfzkvmqg91Y/4HlW161gDldoEKbbL1Bs7suznSZhbIuhE+o7mMUbBzAy6yTYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyPyqHm9z3smVhr5HTp1+fYq5kSJr2n7qNZEDh+PpHs=;
 b=1E4OLky6uLUsFG1JNeJLAYGfBKPwEroYSFl4lrSX9K5hnvfp+3tgn7XWcSvUHMwH0ecR+dTDhKgXaPCT9WB5Ifz05vy/SAADVAEQeZ2tQ9vFlW/jy1ua6PQcDoM7eO94yes5cmz1Pfir76t0zJi3ZlwFFtcQisPX0T9g3yBzS1U=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:53:24 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::7f) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 02:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 02:53:23 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 21:53:21 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 2/2 v2] drm/amdgpu: normalize error return of RAS command
 wrapper functions
Date: Fri, 24 Jul 2026 10:53:12 +0800
Message-ID: <20260724025312.1091525-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: f831ad97-7538-4e22-0c95-08dee92eba80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2Ir3+bKcTOB3lbHkmyy7LlELFvtN19hp0z2qFfdZaaN0hiMwF3qneC5L6c0fuqnkLTvyJ5QSlM/O3zyLo0lUZGfDEvVHW1WWGX2uW8zZBLyvgWkcdFq29CLFzec0THSkeshcMWGpC7nF7G1kD6w/halg+xTVuJKSLZNJtWM8Ym+MVR4OBiUZgG34LQf8ykwIYgByZno51qsQhzpOdaiX91ajEvAlXhZVXrPyul2NXGakp7noNYF9dO6xYSKQ1SrAl2qc7kXJaJVWkqcN4XAHWZ1t/szFYPXQPeJlGV1tXEhINP2N2j61YsWGie/jgRuYHDgMY6jKy/BoTccPYsyZn2Xi3PuL/88Qh9YKCuxO+pu+9voFPFPk+CJa13mevGqqIohC5Ty110/iOcDxkckvKZime+82keHAiPEy0GTg0ali4HBEBRYLtcsCS+hjBQrcoPpuH0UmOljeTXZqbd3ol3OeoRVI6gTW2ookdSlQdlbJXvKkQDL9dnmdji11Ci/sRYbLaIzsDMQKAz8afljsm3z6fRj2F1seTYRsDc0fdSi4oNVgSoHgoh8HrbNYwrp5BdahvrxSa8237ntrzXGMn17NbyqLEnPEhVdgNSCM0VJiJXyHORjNHiP6pqGKhrKhT4DQyBeUhzw/PrjqR0QuN5IwUE5sFNc1P9KyeVMtrVbJVoi99fMxYN8sEAF+be9OCleJMh9CxUeqowuqR9/zUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WJ/lK/oJohuMdsELIvjdg+SnDzKCvoNUI4ZbZR81skeo9t8NycuyiaFGfOpwj8EKdnuTgDvytYNYB4/xTmzeTvhv3fkh7WiR8EmXaUqMnupAzgsl9MufTneYntqFUZNIO3bkUlc9Kpvur3IZ+QnrWgiC1jTT4wPlYEeCUpQQeQrQJcm2WE06ol0vUlN+WmQzYQQe68z1eI2H+4KH9SiyZyHboB2DyI0UHlSJ0za8YEIy9ldIwrkROCcxQsISmzf1nCWO90kzDxY89ntpJQpS9V7xxjZi892VJZuKYOh9wWBXCmsKjo1eb94gzYsh8rgZAFy1zn5sgM+gQcDShylyF5XI0GrNFlsjHH7MOyFY7/iQFqFPuA8jqR45qW8Sj+nmk+wM++GO8muCMjtgNkk3EjV8cLxME7ADh7rXCcPiX7YXlx02AQTm7EAaPo5UD8ku
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:53:23.8550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f831ad97-7538-4e22-0c95-08dee92eba80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

normalize error return of RAS command wrapper functions

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 24fd24e8d874..bbe8952ac3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1436,7 +1436,7 @@ static int amdgpu_uniras_clear_badpages_info(struct amdgpu_device *adev)
 				&req, sizeof(req), NULL, 0);
 	if (ret) {
 		dev_err(adev->dev, "Failed to clear bad pages info, ret: %d\n", ret);
-		return ret;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1457,6 +1457,7 @@ static int amdgpu_uniras_query_block_ecc(struct amdgpu_device *adev,
 
 	ret = amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_BLOCK_ECC_STATUS,
 				&req, sizeof(req), &rsp, sizeof(rsp));
+
 	if (!ret) {
 		info->ce_count = rsp.ce_count;
 		info->ue_count = rsp.ue_count;
@@ -1536,7 +1537,7 @@ static int amdgpu_uniras_error_inject(struct amdgpu_device *adev,
 	inject_req.method = info->value;
 
 	return amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__INJECT_ERROR,
-			&inject_req, sizeof(inject_req), &rsp, sizeof(rsp));
+	       &inject_req, sizeof(inject_req), &rsp, sizeof(rsp)) ? -EINVAL : 0;
 }
 
 /* wrapper of psp_ras_trigger_error */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 0d34f0eca991..686c92e96025 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -526,7 +526,7 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 					  snapshot_req, sizeof(struct ras_cmd_cper_snapshot_req),
 					  snapshot_rsp, sizeof(struct ras_cmd_cper_snapshot_rsp));
 	if (r)
-		return r;
+		return -EINVAL;
 
 	if (!snapshot_rsp->total_cper_num) {
 		if (!read_header)
@@ -568,7 +568,7 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 						  record_rsp,
 						  sizeof(struct ras_cmd_cper_record_rsp));
 		if (r)
-			return r;
+			return -EINVAL;
 
 		if (!record_rsp->real_data_size || !record_rsp->real_cper_num)
 			break;
-- 
2.34.1

