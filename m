Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F46DC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 09:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C4861262
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 09:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67C4861262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DED89C52;
	Mon, 23 Aug 2021 09:08:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E990D89C52
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 09:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWNjZ/Wso64F7N6N5ff0gZoQlM+eH7bF5M19WCwio5itlDhujXovUkmUWH/QaWb6Tarcno3ZBZ+kh9qff2oRNuiNff7DefV9xJnHDUGxeEB6ZPdXneQi8KSrhrEX+cz2jlpo0+YjqSn9RQAxwDz5I8OgcvRidKyr0OcUFamX4QXCM4F5l+9QZYheUzgwpzSQbsOY6iRcAcGs1hsi53DpEQYR3OpYBB+j78fSp42zs+i2vUx/rY/JA4Aou6R0Q1q/y1HmsOVXJ4yR6ZDJKTQM5aKWbYGL3VzKoAoTFn8fc64xBFiQVP+ysNeE9CfyRicX2te/eu9YxX4nh3Ssj0dCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRXu8VXf6whNA+WsZlq2LuWWYpuiu+KSP0laC7ybvWk=;
 b=QsfKvTzqBqlwsKCTuegjnRupUNCAmPr4f45pk1FTAShTu7i6MJZR8LdHo5HBEK1f6pIO7ogHhzqae7aoBjO/eCJniXJi6XAceUVmaf4GEfUZS/HcVPK/Grtas/KWSkEIyW6Y1IFWybYaxEI02Kq8/Tvg8bqv6dCDZAgKW+I1JRnl2KqTMfnd+fFguVSh7kDesrRTN1s9YjzjHpOd74k5fgfToFzvlXQmbuVSMyUDvcmSbdxFubXNDPpYdxQMgVEDeMf0WwVFnf/CFMk8QUdZ5QixMlwdp95MPwcl1E/6qhj76ZzQ8OE5Frfgkwch+5fy2gJDXxt6uFJUSqaqONYLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRXu8VXf6whNA+WsZlq2LuWWYpuiu+KSP0laC7ybvWk=;
 b=p/Ngb8NesJNq2+eHxHYlfzdtktuksM2lLS5CrK1SPByN/msE2fqb3z0sdozHS4FTKOOS+OXWpL3ELQZhgB+hhX76Gq+XhQvUnkG/UYnHL14A8XqFt/7SjhAtCj35FzWinbjT7TRc8e8UPvS9SQPhBQFzZRiPcrXo2CHCojszXGA=
Received: from MWHPR15CA0061.namprd15.prod.outlook.com (2603:10b6:301:4c::23)
 by SN6PR12MB4735.namprd12.prod.outlook.com (2603:10b6:805:e5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Mon, 23 Aug
 2021 08:35:25 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::3b) by MWHPR15CA0061.outlook.office365.com
 (2603:10b6:301:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 08:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 08:35:24 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 03:35:21 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 <James.Zhu@amd.com>, <Leo.Liu@amd.com>, Evan Quan <evan.quan@amd.com>,
 "xinhui pan" <xinhui.pan@amd.com>
Subject: [PATCH V2 1/3] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE
 on suspend
Date: Mon, 23 Aug 2021 16:35:03 +0800
Message-ID: <20210823083505.53711-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b612b0f9-a191-4111-1c8c-08d96610f3f0
X-MS-TrafficTypeDiagnostic: SN6PR12MB4735:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4735A05AB552E53808D71E1FE4C49@SN6PR12MB4735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JH8F0QFv/FoCJlX5LgP1DO4G1I5M7qyMvJ1xYgpt1nzZRbXVcOCGWgkEPC+1DCaKTbDEhmf6y2d6/C5eqOUDBPaLeDHH2PAGb1G027lIDG+PQTxWKalSjuQzxI8khEyB+gwhsxBs7Vtg4uW5ZxxPqOIPfG6mWAkF3n2rhFFOSkPxqw101Nzv6YH7IOIKhyCcFPEAgSnXxOzZ584zImDnsWN8QgbT0sCez5K46gTwryBQN/CDO2Vr02OWHwL0Y2kS1c+ed5kbMhz4vgEJH/lbebI4aNkHvnDgYBqcX0qGxtFd7FUjF2CeXMgQEV/cPDMbIOD22efUNJqGWBtj4AtEyXU9c9MfE9RPgeOM2I0s/em2RYhnc4rC1ti18q/I8boXcUaWJRKM5lFE6z3gnSJF+JB2L7MUy5FI+0XmHjs+zqlBDRlRC36vmRNIIpkaVlLbm+Ac8ngzMq12YinGi1ehzCKUFok9wqV1aEgcghWTHZZkMOFT2kfEZQK7VDRQQFzEV24XPaEoWJXvgkipoP5eIPXByyR5Y+yG9WQayiLgphQMVLG7p4br5CC2DykoyeAIAFlcCPmyeNdJfMokE1DdTLUZK+u5ATAdWLVhNcgsOJlikFcUDyK1dePrdC5gpTAVd5MkaFXZssmmJR3fU2R3TfoRiDqvk8EhYl3YbjY2dnqkI51HynCLJw0S/e2yFw5mihhm2WsZwLG4+tP1KeJF8lmxeSR9LvXTOE8sdXwNeCZc5E6gARLTMs8TC//y1x5v4YfV9EaE/V85t06Lw3rqIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(82740400003)(478600001)(70206006)(36860700001)(70586007)(336012)(86362001)(5660300002)(186003)(16526019)(6666004)(83380400001)(8936002)(36756003)(15650500001)(81166007)(2616005)(2906002)(44832011)(7696005)(4326008)(54906003)(1076003)(426003)(26005)(316002)(6916009)(8676002)(356005)(47076005)(82310400003)(34020700004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:35:24.6116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b612b0f9-a191-4111-1c8c-08d96610f3f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4735
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

