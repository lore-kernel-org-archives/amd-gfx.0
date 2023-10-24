Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2CDC00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 02:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A1B10E072;
	Tue, 24 Oct 2023 02:33:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED15B10E072
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 02:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9VvRT0CVpl5kzE5wAPGtvgnmCLnvkH49dXbuf0jp57M5pLk3v1jJYSEP+7G1bnqXv19vCORYPhTRV/LicXO2kW7LrLhoKVOCtOtXjymDSU0AwKpSe+mTSbt5aiArh8fXtaFC1QfJe56uAgekSYsi4xGIfXL/5U+4u+0XuPsjRon5shyHwWkkuIKOyFhyBrB0QoVTQpggcrbVULu+Nl9q23YtC7lj7nHmFY+yVh18Sj1zz86n86E9ptep99cRqZ1CiEwyzFbOvSq7X/RDlaspa/NV2MxXAcVqYkBFRcpnw9oOuhP6uqh45N+9TRFBfA7cb3VhHbF5G0GdH3y44C46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM0Bf/Tiy++DiQl6xvUnFirn8zzIpguyDLmRyttTCOc=;
 b=lmG0rNU2xBaoXCtwCVliagb5bM3Zn0L+K9nJMkPot34emWaBYUUPAfZYcXhmlFpR+RU1AfIHu5hQLH5kZh9LDE02Y8BApxU8BVMKY+hAlO7Zw9kQAJfafIDsbpvPjB5NfxVnlb/UHfBznFgYSBxm/OaHb3vYCUa3Yv6GIDG7ZYKRWmZ9QwDG/oDO991IUocsqmcUVVIsPjvGXqXyIDSqb9EnyRMRm6Mp1vsCTzgqKY6COQ4lFpC9YXZTGhQyIQUkIO86e7TFluYK20J7yyunt2eVlYj6v33mS9hQveuFpT1I5LBh+EonMIQJkQb40npOzkuTnpEmSiyrMbkQXMV6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM0Bf/Tiy++DiQl6xvUnFirn8zzIpguyDLmRyttTCOc=;
 b=3cTtZhxOqVuZrHWWWgfcJ7IqSQoNE1Z2ze8F7cdwvLkg80669AMyi0ii3+9QYN/Mjn8zqXoSTmXVL5ggWK5VGEuUT5zHXOkGYMuA6IXxRITxFinYGgR38tTYKxoJ0pBmpDQ9A3SABCJvLula01YvKkKrjcvCLazwSvqkAxci2vg=
Received: from MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Tue, 24 Oct
 2023 02:33:33 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::20) by MN2PR22CA0019.outlook.office365.com
 (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 02:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 02:33:32 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 23 Oct 2023 21:33:30 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <yifan1.zhang@amd.com>, <kenneth.feng@amd.com>, <Mario.Limonciello@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend
Date: Tue, 24 Oct 2023 10:33:16 +0800
Message-ID: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: cae18bfd-a9e4-4067-e685-08dbd4399ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apNLGtWbnpgZsLizBVUmqSP4NLmJREKu64c+/2rmqxMfJrbWXhKn0OtAWZmkYXBuVK9tLxfiaaHt9XgSwkZqedJe078gVIybjZrVBHYArm35GEwheDMZZO7PwzZBZZG3VdQ/8wW4WD43poKvKxqizbsyNa5q+GTLMT8TIkkimdIwr6KGdALzSXiBWP59m0ee9hDvF3DR2gYSnxr75aSbDWPpxVS69+274s9d6dzh+c/1URqkKwrS2sjmlw0xm5/Q1ijp8sgXnbRG3l199BQxKAajY84wWY6LDFCorRv2PluapZKTqeDDP0ox2X1oCdgd6E3UizP65DWuvMbWjnZNU/weNm4SYIte6Z0snH7B1WR5VZ9Dvke4iwXdmY4SO4r7pI6N/tRJh7yuzk+svQ2foIPBHYAc7hibej+bka468BNt+cM3ocy4+YowlzeKI0GgcKi1c22Kudv9NlrUfD1K+N4Zq7Vv4uN0bavWJj10w7P6cGD2rvrFVKDETFC85ETMaF4nxJrLccVi6MkSZQ1KAXVnSq4rvtaq7nwywHfeEdSaUiSIFVBZ5aRmayI49eqXcMBLJeWrPkcbNKlVySHZEpx3zn0uF47QFmDr3ZpfoToX0BXWDzv+q5VxjKrY1HjIkgXxPyFnF8Xmghjqz6w0ib6kZ9czIFH5bzC2tzSYh4Pi6lUcS7s7gYNR0e4RZgU1/6cQMbdoCzD1ymFJuV0PLVfBpi00DhsP7lilsCLXdXMwEZY+FAfmIKKIb0myf2ZAJEYMiEpidEVU/+yz/lx9Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(46966006)(36840700001)(40470700004)(36860700001)(7696005)(336012)(8676002)(6636002)(5660300002)(54906003)(478600001)(70206006)(4326008)(110136005)(83380400001)(41300700001)(15650500001)(316002)(6666004)(44832011)(2906002)(40460700003)(70586007)(86362001)(40480700001)(16526019)(47076005)(82740400003)(426003)(8936002)(2616005)(81166007)(356005)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 02:33:32.9247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae18bfd-a9e4-4067-e685-08dbd4399ddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why] During suspend, if GFX DPM is enabled and GFXOFF feature is
enabled the system may get hung. So, it is suggested to disable
GFXOFF feature during suspend and enable it after resume.

[How] Update the code to disable GFXOFF feature during suspend and enable
it after resume.

[  311.396526] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
[  311.396530] amdgpu 0000:03:00.0: amdgpu: Fail to disable dpm features!
[  311.396531] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <smu> failed -62

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Kun Liu <kun.liu2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d9ccacd06fba..6399bc71c56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3498,6 +3498,8 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 					       unsigned int vmid);
 
+static int gfx_v10_0_set_powergating_state(void *handle,
+					  enum amd_powergating_state state);
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
@@ -7172,6 +7174,13 @@ static int gfx_v10_0_hw_fini(void *handle)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
+	/* WA added for Vangogh asic fixing the SMU suspend failure
+	 * It needs to set power gating again during gfxoff control
+	 * otherwise the gfxoff disallowing will be failed to set.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
+		gfx_v10_0_set_powergating_state(handle, AMD_PG_STATE_UNGATE);
+
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
-- 
2.34.1

