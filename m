Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014D3C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 03:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1AA610E6
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 03:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F1AA610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018786E9F5;
	Fri, 20 Aug 2021 03:54:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3560A6E9F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 03:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgcyGhSu6UyTGYExApa7/oMQMnNUXIJ2lRN7ny7fR8s3vNFNfD48dhIV6GNeuEEKkYLh0YY7yY70N6urZhNG+bLyOEHd+L4zzz1fALuL5emMlpghj9al6WDUOTCrQ2X13kpRKuLauNXE2kCkGWBxdMiCO3ckdDAOs3O8y9ZKGKpRDdNz8LEwpa5LF5JACnj64XeE5h4nUlisbz8opjA0StBmeXsqOeroUzaqvumTk/8Wo63Ox1/CBGH4HjBrdHQKSaQJdLu62x22fJCbbo7L08niytVuHIk+qcxUQCLqRDzBZCZmo5HjWXhh8+s7xgiNZVwM6jihBmHwfJx2reu5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRXu8VXf6whNA+WsZlq2LuWWYpuiu+KSP0laC7ybvWk=;
 b=BfDTH10m3C29EoVGQaH/bbSVlfoMYEIFqglr8RpyVBHZH7tw5UhkJUyaOuJ6+rBmbkjrymMZTjSohNWZ0zJOP3lBJbIHo61gAU7G3DA4/sagFvOWrCN/yR524bODw2HYcKDsQ0WtF10ie2ZvN9a+6ll7p4ZzDzdbpN7RlrNpn04gtKNQRTNI58Ott93goLNE8FTTzvTCOQ5jmtFhm3R1YGb8dM/BylsjErfxuHpV7zDvdXAWwR33Nup1LjeCtVcAejykTKoVyXQ6HmO33LF22DxyS3Oj8mAjTYGLQw5UqhJzLRfNcUZVt8V+g6Sgt5TCYc5OE4010MSgXqwgYDaZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRXu8VXf6whNA+WsZlq2LuWWYpuiu+KSP0laC7ybvWk=;
 b=mXgaDbSP0AQYJkMWYUeSgMHEPLLqZZD8MuImsrjTga1p4Q0SC60Qxgu9Lmd+PVv16uOEI79JAjvvLnyKqOTWs3IXYaWT732S6htQweKoPVr18cvtX0cDkW6YVAkUDEi2X6+IfM8UVQk8T3hlAvMa/YNsR8Xu5OFtvpDX+CviGmg=
Received: from MWHPR14CA0051.namprd14.prod.outlook.com (2603:10b6:300:81::13)
 by MWHPR12MB1759.namprd12.prod.outlook.com (2603:10b6:300:113::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 03:54:13 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::77) by MWHPR14CA0051.outlook.office365.com
 (2603:10b6:300:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 03:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 03:54:13 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 22:54:10 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 <James.Zhu@amd.com>, Evan Quan <evan.quan@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH V2] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
Date: Fri, 20 Aug 2021 11:53:54 +0800
Message-ID: <20210820035354.1486912-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11d4f52f-0bc2-49cb-a45f-08d9638e2ca6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1759:
X-Microsoft-Antispam-PRVS: <MWHPR12MB17591280DD80B0BB7C860698E4C19@MWHPR12MB1759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ug10lAp2gdsl/+QMaVxYiaw03wB/LAHcfy1alsP40frr33iLT7nJfYYYx43QjfqoTpUrmEGWtTYBfVf4ZllPM3U+tLwxzdLHELX76NaoIRX33+yJOZJpq1e+Nn02J34+NQpccIjcrOwI1nPBvdl39Q6wAaKRBJnQbiuoqn/DREZUR3ZLQZ9Pbmh8TxPJ72wJMJrs7ddaAaJIHnVeMMBE/hu4J7WrvbtWNv+55pS0wjEyl9MCuixLOT3i60dniEsgushjf7/xqpHrrgy+HzL3s0QvKwhHCOc8c0Is156E3hSF73KibmgvdfLOcv54qzKq6mN9a2DLvvVf14I/sdw3wyy3qL48k3KVBwqW0xkHKItbvZbP6VDgtRvM/T4VYlTpCR9rnYbNoHiiaRcNM2x3tALR7c/YeqmeBWD1NGLjc+szwDmEj+U7natjPvp0v2uPt05DSQ5q2sCy+GihItiEQHSzidEvUDJxU2/Z1XhT2I93sf0QsjxN4I1DbSvEEONX412QZRBH0g2SzKxmYKRjepXE8L/5ajffbVzV69nly6osOnod+HUGT94Bwq+pWQoXC5B5mUaDlo57w6YtOT+y13j+VgSjwvArfnemGfXI9icH8VG/uH7NAGDEMlbYNPzSpV8nadDp/JOsa+tommRWk9BglJ3YMCcKw61QeqMGCF645U0HSFgU+AkDV7btZ8tKKd2zZUp5LqFeDUTGnk0M7UGyris7i8BthT/TjT2OhQyHjZ4F41Kd9DxxMjxwsqFJ8/j6XCezaGMfPd7twKeANw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(82740400003)(336012)(426003)(34020700004)(86362001)(47076005)(186003)(70586007)(6666004)(83380400001)(8936002)(36860700001)(16526019)(6916009)(70206006)(2616005)(478600001)(8676002)(82310400003)(26005)(316002)(15650500001)(36756003)(54906003)(2906002)(44832011)(5660300002)(7696005)(4326008)(81166007)(1076003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 03:54:13.3061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d4f52f-0bc2-49cb-a45f-08d9638e2ca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1759
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

Perform proper cleanups on UVD/VCE suspend: powergate enablement,
clockgating enablement and dpm disablement. This can fix some hangs
observed on suspending when UVD/VCE still using(e.g. issue
"pm-suspend" when video is still playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
--
v1->v2:
  - move the changes to ->hw_fini() (James Zhu)
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 4eebf973a065..c238aa2014fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -543,6 +543,30 @@ static int uvd_v6_0_hw_fini(void *handle)
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
 		uvd_v6_0_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6d9108fa22e0..e99877c13d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -490,6 +490,29 @@ static int vce_v3_0_hw_fini(void *handle)
 	int r;
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
 	r = vce_v3_0_wait_for_idle(handle);
 	if (r)
 		return r;
-- 
2.29.0

