Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B27C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1D460F6F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE1D460F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014E16E8A5;
	Wed, 27 Oct 2021 14:26:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174256E8A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 14:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUpe3vAU5fBVofiM98Q52sqGPpbwdWP6ajpNx9X5lio1hpbXOydopb4K4eKMgEv3ty/Y1U4BMvCv8xh5xTei/b5BDRjDEaXP3qeq+A3D+iEZH+M3yD32wPl78VCqcfWfsACWTUCoe9f+u95Mvm2pQzSoRakEw7IkGz4MaifzHh0laEDFwNVdTynXsjyu5KRW55qiBOUvpCCvA88zzcbKgMFuEndhhgXu1mklacnjDKSUTBPYIKQdDskXm/JXmfF4WWuxWv4EFx2uJCQgAZJcYBXEalKG+8+a2jHp8iKZZR02/BMmxVPWWpA4rpNCO0a5+fa9CMOBvQ4mqZ5IS+9ZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA+B15mzZrQF5O9Y+K8tPcm9NWKtzPflJVn2z17lVCg=;
 b=CjDwF4+MDqLaSnUtGi41ku92WnIWZUNk30i/KkV0aGgpPCXuCQK6N39ABylAGPC8KdwrYXgirgWQ4PN6Tin/r7werDdiDC6G+7iqcntHWP+zKTE8H+5HzwTcHZm36KoHUq8fpkCq5ko1vq86cMviXISsSe0qh9JQxy3B5KC+elaZ0nq7OvFhW2K/aS8i+3wjcDGZSYhQIl7EOrxKTyOz/gJrQPp6E9UJFSpPjlEHh1ShzG0D25mhE90+tVyEzHVIAi5+dRWQCYZO8VlZO9CrY5r5KoYp6j4FYPCt/+CogFy0kUXsEbiIyUirEQb5Xg8zpZNreLqawNuX0GceH0Y1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA+B15mzZrQF5O9Y+K8tPcm9NWKtzPflJVn2z17lVCg=;
 b=3NS7Lhd07P0Mscg1H6XcUr38o4L+QNZ+Oq22rXZ7ayioc6hHaqt9p6CS0KmlpiKjhWpLMJL/xJzouaHWKTpLF2HlAmXXlxAffDCVkMW0yLdlpZE0UEVtgvfPMkJ/vdCkUzykyEfGBGapoarFWGZavZT4rN8RVqYzNJqXm03ySg4=
Received: from BN7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:408:34::16)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 27 Oct
 2021 14:26:42 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::b7) by BN7PR06CA0039.outlook.office365.com
 (2603:10b6:408:34::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Wed, 27 Oct 2021 14:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 14:26:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 09:26:41 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Wed, 27 Oct 2021 09:26:41 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <rodrigo.siqueira@amd.com>, <patrik.r.jakobsson@gmail.com>
CC: Patrik Jakobsson <pjakobsson@suse.de>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Fix even more out of bound writes from debugfs
Date: Wed, 27 Oct 2021 10:26:34 -0400
Message-ID: <20211027142635.9459-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211027142635.9459-1-harry.wentland@amd.com>
References: <20211027142635.9459-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac155854-3f6c-4c70-06c4-08d99955cbfa
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55214E232B9708479F029AAD8C859@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coBUnNKU2iXs/uPTdmZWQMgT1f/01vU7/hxyuEdgzBu1faGO3VgEWM8pq3lgVZkeD74f9RMLwsQa5GDXM6jM+zZ7PQS9bMe+U8f0RtgUQMDqqH2fPBxgqV3pjA9mTkj9zTJpNI/J6yG3HLAhFyNCx2ZpKyi5gMz+BbMlhKyQC3bRP3dWxIZAwbeagZzxK+V2BwAgNuM+P7O3hDEBwewUYClLpfyJi3s5uStK+GIN3DmECfyfgknrOl8Aq/Nhl/qpujvIkc88amHvldROjfzbsZ19V6eLdAEl4oWgk1rJ/nuqkYXy6TEfHemkfSRxK8vZ9cFUHtP7u9PsCYIMqOFGx02BBST8io1fwO5O8cf5r2zlSXdLjbL82aobYHIDcUFWRil3nEvL4NpacKaUZx9bgQSjfFiRwwEbhWhbcB0/QmaWNmE80UFIHiNP+zc2t9qyE2WGprJuehGAyLLyQKnfkRhJ11ig+hpUky/zYMApC1bkMXX81fB60SQrRVmpJR5wGYuYOdOM9tIh1syv8yNWmYf3vAjy5DlV8JBqlP5OPbGm98RMY4jv+6e5sn57Ngou8E6UAcJiPhic0RyQNf3EJ03KhQFHH8Rqpg3Rs1YoWmM41giiIoBmu7u97LSjBPrgggQXWmwjiURZYc0zOGNxtNeFxXP5WERjbbtDYSlQoRpSj8gPa0G8bNCN173Vp1jVEWog77Cz8a/zggRfhHssYoWVRDX2lM51rofnTXqhsKc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(186003)(426003)(356005)(8676002)(508600001)(6666004)(47076005)(82310400003)(86362001)(316002)(110136005)(26005)(54906003)(1076003)(7696005)(8936002)(70586007)(36756003)(4326008)(36860700001)(70206006)(81166007)(2906002)(44832011)(83380400001)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 14:26:42.2606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac155854-3f6c-4c70-06c4-08d99955cbfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
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

From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

CVE-2021-42327 was fixed by:

commit f23750b5b3d98653b31d4469592935ef6364ad67
Author: Thelford Williams <tdwilliamsiv@gmail.com>
Date:   Wed Oct 13 16:04:13 2021 -0400

    drm/amdgpu: fix out of bounds write

but amdgpu_dm_debugfs.c contains more of the same issue so fix the
remaining ones.

Fixes: 918698d5c2b5 ("drm/amd/display: Return the number of bytes parsed than allocated")
Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index b30307ccff12..be8ff7a05030 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -489,7 +489,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -641,7 +641,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -916,7 +916,7 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   &param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -1213,7 +1213,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 						(long *)param, buf,
 						max_param_num,
 						&param_nums)) {
@@ -1398,7 +1398,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1583,7 +1583,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1768,7 +1768,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1946,7 +1946,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
-- 
2.33.0

