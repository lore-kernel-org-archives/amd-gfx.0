Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F80CC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1188461248
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1188461248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870DE89C1E;
	Mon, 23 Aug 2021 08:35:36 +0000 (UTC)
X-Greylist: delayed 15444 seconds by postgrey-1.36 at gabe;
 Mon, 23 Aug 2021 08:35:35 UTC
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A6189C1E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 08:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmyNBVQkE4r7w0dUznKiNaKjSDcp10BksO2+EqtTGj4bXGYEUubKYcrSOLKnZz6riYk3wumU3dNUWNnIsVDzFQSvgluSJef1Fp8kBi8UfopuWbjShfkyrf96pAnPtyJLGkdEz2oUy26NptBvpjwx/y9tmNA5pLiewrSFlJGn8vTMMdHlJqvvXZMp4Vihxy4Og0+XVPG28od9LqTW/s+GNBqUMRORzUZwgODG9M+YvJz34AfH4nvOjvodDrTsRgBhVzYvfJEzvZ3kv2E1skK1gkRi++9Rz29ojgLj5H0hQZ1z5F2QXzm1oznFs5CLgFbbpQ1PjLwd3IGXq2h9EJpiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysOj/Aj1YAbDKqUOE7EtsBvAKreml8ArsGz3ZIEvjcs=;
 b=ixgmV4OeEnAS/cQVjYYIaTXm/2gnXqFu3fERYxjqMZhpnZDwWky9BeSBxhP/z/aUZ1dkOo/E9ciyBCDpvPn9dtdDLN8F1ee+2wc7ZE9QCGFkn+aCF4MqjHPBvr+1jqfE6c0VivnIQdZAVocQGT0p7bpkBcPxte7xB+0aQVlK6+jgoKG6EgjUvQKfp03tyjM4F2F4t7MajRrR9JHhuoh4eJNzxmdpjpvI1dneCOSSzRhjWqI2mmJO34sBggYM8fn2kQ8jjdRNXTimmXB38Y+nYtu7iu2BpWAb3k9bcwH226dP+OxLyzweErMUni3DKaf0k61Jval51qIaFb2FYFERVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysOj/Aj1YAbDKqUOE7EtsBvAKreml8ArsGz3ZIEvjcs=;
 b=fWw7PBH53eME8MsDFD0nnzGF4OhqAH8Qd7XLmAprP8fGhvmi1DXIol/iVJx/KQYESUVuCLIJY7AN97mTYvHspx0dxOTxeq29nnmdRpDcXsWwK6ySFVoG+s3DXuekUjV6B1fGgOC6cyG/24aQLDW4JGttGeksJl0au/7OifINvko=
Received: from MWHPR19CA0007.namprd19.prod.outlook.com (2603:10b6:300:d4::17)
 by MWHPR1201MB0190.namprd12.prod.outlook.com (2603:10b6:301:55::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 08:35:32 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::6b) by MWHPR19CA0007.outlook.office365.com
 (2603:10b6:300:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 08:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 08:35:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 03:35:28 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 <James.Zhu@amd.com>, <Leo.Liu@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [PATCH V2 2/3] drm/amdgpu: add missing cleanups for more ASICs on
 UVD/VCE suspend
Date: Mon, 23 Aug 2021 16:35:04 +0800
Message-ID: <20210823083505.53711-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210823083505.53711-1-evan.quan@amd.com>
References: <20210823083505.53711-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78f352ea-b439-4cac-4a93-08d96610f862
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0190:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB019064F04AD26727D37D3DF9E4C49@MWHPR1201MB0190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:76;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hut/oN9sITHNZtUUiT4n4IF6tB6ShfAp22m3/yakSOcqovYzpETSBbIJeGoa843UbA4Ghqr20Xuwsh6CRcGAuMnokje9sRBJ2HLkeLUzQxvkQw7ibR1BUhS0OS7vq93ab36fvas63JuVYYuTx5sW7gRts4K96YF3kIn9lGe1VFcRyHKH5N6O17OHViH6JhBNi96sWMzt6viygISNIcTbYN7UXJePPq5eMrE6JVrTOXU0qkzD0dq/IYPMI6ZpFo5NKypaN6YZfH8aE0BZEOKncIXeRqKZgOI1R9QLphw0QkEw2RChNhbLjHqtz7YayQN3RRE0zH8Gdgzs4KY+VWzuk28DvOpyDPVpkEyMCDZ+yn+gqRjuhvkBDNeDZDmoZ9e+2losi5xwUcfNFy4gMn9uImtbq7noJkbNG5Ovsp5syrNV8Y3Whtne6yH/GYThap6GhKmWLA8J2wug/SsKuiyXOA2sVmNLMm3nooOQ5HDl/fua9rhiwol3dKpJWqnwg/nCF7XcnSi1lx9Ci5WMpWaNM9OtbRg0rcJt8r53tlhyivKmNAl4Cw4qstjE8eWGF8jbMYtgiLtrnSVEbOZAdnFybqtpbjV9SVY5ZO+mMIZjO9HF1S/T7V17bHgUYvR1Y55aFMVZUMVowGswA+8mwz7H8eq/G47zNEEbeBPQrA5p9LnCfncezpfoqoKttYHZsPYD4zqW4RI411wrhRqxE4w4wKcvIaii/7Izy+uWk1EhPCIXDjCImklTDpQEpBjSFH42I8IsAC0Le4urGKlM8VZjIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(2906002)(15650500001)(34020700004)(1076003)(4326008)(5660300002)(86362001)(8676002)(8936002)(356005)(82310400003)(36756003)(47076005)(16526019)(81166007)(70206006)(70586007)(82740400003)(478600001)(186003)(316002)(26005)(6666004)(2616005)(426003)(44832011)(54906003)(36860700001)(336012)(83380400001)(6916009)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:35:32.0627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f352ea-b439-4cac-4a93-08d96610f862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0190
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

This is a supplement for commit below:
"drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend".

Change-Id: I7ff5692fd0c3e880ec8e55a7329469a67e5a1363
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 25 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 23 +++++++++++++++++++++++
 6 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 3c725de9df95..bc6b670c8639 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -698,6 +698,30 @@ static int uvd_v3_1_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+	}
+
 	if (RREG32(mmUVD_STATUS) != 0)
 		uvd_v3_1_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index a70d2a0de316..77a85e754653 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -212,6 +212,30 @@ static int uvd_v4_2_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+	}
+
 	if (RREG32(mmUVD_STATUS) != 0)
 		uvd_v4_2_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index f3b0a927101b..8a27b3036d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -210,6 +210,30 @@ static int uvd_v5_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+	}
+
 	if (RREG32(mmUVD_STATUS) != 0)
 		uvd_v5_0_stop(adev);
 
@@ -224,7 +248,6 @@ static int uvd_v5_0_suspend(void *handle)
 	r = uvd_v5_0_hw_fini(adev);
 	if (r)
 		return r;
-	uvd_v5_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
 
 	return amdgpu_uvd_suspend(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 7cd67cb2ac5f..a3cdef7e6fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -605,6 +605,30 @@ static int uvd_v7_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+	}
+
 	if (!amdgpu_sriov_vf(adev))
 		uvd_v7_0_stop(adev);
 	else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 0e2945baf0f1..dc9485f7b78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -478,6 +478,31 @@ static int vce_v2_0_hw_init(void *handle)
 
 static int vce_v2_0_hw_fini(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 37fa163393fd..205aa3c1f091 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -541,6 +541,29 @@ static int vce_v4_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+	}
+
 	if (!amdgpu_sriov_vf(adev)) {
 		/* vce_v4_0_wait_for_idle(handle); */
 		vce_v4_0_stop(adev);
-- 
2.29.0

