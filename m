Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC5CC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769CC10E617;
	Mon, 20 Mar 2023 17:38:40 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987D410E614
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGqUY6TC9PVlQ7V7bp74TBLXAUOe/0VuT3pj6Plv08jeh9WInf85E8swSYI0rmlvMzKzJ1i/8563PhPQfB+vge/JZPrr3pKAZZkS5sOtBVDb5+b4dB8Az1oWlJ3rNHRPn2If5kU4Ld1EaUOjKmWBSxKf/Gy0A66k0xx3VvLIhq7aEO7Ib6Tz6Jg4ZZ4VYtX9D0CB5VuCtzvgkUxkR2yc2ZlKcnhHY0ZSkhjZWaPKpJKC3D0L4L46P1bInF7MYNJBsrnBK4Fz3r5hY23dyXqzrZWk3Elj3/El7zKMcwTaq1v/DX0DcVMneVriU9CqfZEnjOPdgtn/mOBG/O6WuXjzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiecf0ieeLB6MgnuvqtOnObemJOmV5IS3xJvaSoCyHc=;
 b=VUhk/uV71hGuxNt7GJ9zwnJx3NPyCbTkoGeU6IUoV/7999urDfVkObc6NkYVWexlbDBq69KAFZgH3Z+fXuufzvUHq+Sc4iaNhD/rdNrD986TKt2QB+EvZsPaVemDogrAUBPuFn/vphz3S3Y0Pq2Jrd2hAXjXiUXCE1zSpdVZQHC2ftDCi33kyZd+Ml7hErQVB1Gz672MZgvqGxvzTBakLvkj7JLZh6AZ1oGyFt0I4dTU9jhycTsH/sTEuHE3vNr4RKjXk3UchuX0GnbBUrKXVQdAuhQWVtQ2zsINLfu7yw2sZZnpYnY4ApDbdvqvDS/OkpPKkT6BmAFNzJgwsrVsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiecf0ieeLB6MgnuvqtOnObemJOmV5IS3xJvaSoCyHc=;
 b=oTflcxzCB+udS1TGHauHkKZOscN6e0jHg2K5IQ1GwS2c7jYlADlPsY+wlpkisnZJ+mDfBHn6BDJ/xxJybxELq/liCsvrs0HSOL6XiSA7JajIH6y8MkoKtJ8IpCMa4xGlfjH0C+q+aUqT45YDmxHZqhGXPLaqQESFHWgpDyKXSfU=
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 17:38:33 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::af) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amdgpu: add get_gfx_shadow_info callback for gfx11
Date: Mon, 20 Mar 2023 13:38:08 -0400
Message-ID: <20230320173810.250835-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ccfafd-3796-41bb-e32f-08db2969ed78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCQGg0uMyazcX71Dlyxfb3OgkPo8QTaZX46wY/WysT8aYoAk95YEEpY3GI6fAuYWQ4Il4PYZTWYNJwN+2U6C9TglS3TuYmWz7VBIdCn4Vo5WGwda2nNBpNQG6QcyPuLv2ApDNH3g00e0cc4UWIOJJBS6Ga/44wjgJR1+Si3zIKGasLYpwj37FnAk7GRwXrR915A0CCdnkxl3tj5WAHMPwz0fOnWe9BA0d409bNHI/34q3pAcu+E1ffVpK57vTjUeVwLgJPaXtVVdudlto2DH3tbYZk91RKBnSm89qWm8pepE6diJf1OeTWDPtiOo7blyQCsAnoyILQvK1nvlyYy/SR8jWhNtvuvzCufcz01XtD91pyYRWoofJqU9k7j0Z3DRe/KjnfSTlPcSjZwjXXOdvbYpeTjBHmTaN6A5D/CQueumlOFIxAJ6BowIOz48Y/A1iNjBFN0LKuvGVcYaCJpQHCtZuIol/lQDZdyvNLRsREYITV/yZmcsnmTQdHppQIGPbVlaDNEPSf9pWfO0XVmPAo9WaEjfo+OnvZ0aqMbKInS4RhKzovVBw7Ic4AeuFN8wqx20D9QpDjEiZRRNDlg8Dvz2Hlene4/3R+3a+VzQR76BfoupPU03Ixv5+d+lC0cIjnRD+54ifZULLsx3YXfwgqnHVr/WKAuIHLj/3qiQDUV6yye++uIS2C6rv9TZN0nYYSN+/ZovZY1lLK7DEXNKBNR1zsR2I+/R7knuFCqk5FU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(8676002)(36756003)(6916009)(82740400003)(4326008)(8936002)(2906002)(70586007)(1076003)(70206006)(5660300002)(36860700001)(86362001)(356005)(81166007)(26005)(6666004)(478600001)(316002)(40480700001)(7696005)(82310400005)(41300700001)(83380400001)(336012)(47076005)(40460700003)(426003)(2616005)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:33.3922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ccfafd-3796-41bb-e32f-08db2969ed78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used to get the size and alignment requirements for
the gfx shadow buffer for preemption.

v2: use FW version check to determine whether to
    return a valid size here
    return an error if not supported (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1fc1e941f7df..d6aeaf530fe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -822,6 +822,32 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc21_grbm_select(adev, me, pipe, q, vm);
 }
 
+/* all sizes are in bytes */
+#define MQD_SHADOW_BASE_SIZE      73728
+#define MQD_SHADOW_BASE_ALIGNMENT 256
+#define MQD_FWWORKAREA_SIZE       484
+#define MQD_FWWORKAREA_ALIGNMENT  256
+
+static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+					 struct amdgpu_gfx_shadow_info *shadow_info)
+{
+	if (shadow_info) {
+		if (adev->gfx.cp_gfx_shadow) {
+			shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
+			shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
+			shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
+			shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+			shadow_info->gds_size = 0x1000;
+			shadow_info->gds_alignment = 256;
+			return 0;
+		} else {
+			memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+			return -ENOTSUPP;
+		}
+	}
+	return -EINVAL;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
@@ -830,6 +856,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
+	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.39.2

