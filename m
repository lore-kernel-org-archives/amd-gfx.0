Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC4BC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8509522275
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xc8MQx1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8509522275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378AE6E0A5;
	Tue,  3 Nov 2020 08:08:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895AB6E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 08:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRsE91yKVMBV3hlCyoKfHYk3CEdf/AxBF6vjC31CnZn4txXPsRFqLowTmvAvFWTi7boNh51SNc3XPZRdriZZsfDCaKos5bPjOORbh7JxGUrAVXx/hiVkQXdL/vGy94lzpEe9D5lIGOqsUtz3rLddtTKiQuCNYqHMOXHcwHanQ7/tW3vmxS5StE5LQLoMSIaLkqNbPvA27h2ga0EfzgIfBN0d4z84a0peIIdoZVbMvgMAsfdUARca/5naWaz1lWNMwWpq4tlXGcf/6n2hVi4AY21GvOslLoB8tmzcCEj1pnEGM5xCzAe4YEjMSy+88kJjPuVttH6s5/7hofrR6fK6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlYWxRuvkmZcVh/mJuuw9fzwefe2IazvGNYXyfPjSgk=;
 b=Kj91cNM7K+x3PenNGhrhUZLwKQtVn7DBsGoYufHccDPbuprOkIo4yai3qemZUxJItVewLST6hOu5cF8OFExudQTDHHjTXdmt2tRSjy49+sbtgfYqx2m9Pi0dE9lIBo+KZegOD3bAjz2Y7DR1siqqrj/x3DilY99eQ4C+vSGb2Xt8/4AA8k4Z6QAzPw3yOu/p89zgLdbu192YGaHBBjBlQWPuWN7sChqqr6Zxqbjg+N12Yx+aw7p/nI6r61cBHNKkvI9zcK1c18pqMZTX3LksGj8nyRYb+5EapIlIDkpZlI6S0MeR9krxYg6r8rBcfdmW7zyMdRDt+IlI9CHReG7b1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlYWxRuvkmZcVh/mJuuw9fzwefe2IazvGNYXyfPjSgk=;
 b=Xc8MQx1RlV8RqeSbn9mRGmIP/qIdvONeS5DvXRFqZ1ZEfb/sKzlLyiLdn1DmYHvq3iF/zL8jHQ/57C8SJaoXI08SaXf6pVd7aM95PF4C6458Upz/d8RqFc1dzAgbwSVVF8wjNwP3C+EZtvzH+GQoI9HytXjHzCra6jYY2nvlrVo=
Received: from DM5PR18CA0053.namprd18.prod.outlook.com (2603:10b6:3:22::15) by
 MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 3 Nov 2020 08:08:06 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::4) by DM5PR18CA0053.outlook.office365.com
 (2603:10b6:3:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 08:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.17 via Frontend Transport; Tue, 3 Nov 2020 08:08:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 3 Nov 2020
 02:08:04 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 3 Nov 2020
 02:08:04 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 3 Nov 2020 02:08:03 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: specify the power strategy for vcn use
Date: Tue, 3 Nov 2020 16:07:49 +0800
Message-ID: <20201103080749.14197-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3cd4825-47a1-43fc-d5c7-08d87fcf9806
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24589C6C0CAED5176FE0273D8E110@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqbyIHd36aLzsdrYvfluSUu9wtJYyA/TfE2UUB5C20JVhtfmOuMGzI6c0fXK80ss5NBHb2dO6DsiY4kEdSZsAhr1ag9DVeD+z0M0d7ACDWy8XKbU93oiE4vp9dk84ByUuBSJk0CcUnTcYH0Giuux1W5JLMLG7PGFaPV+xF9ThlloJX24k5OVNpeWFLFl1nRyv5dpPxwrDH5qpjiRLfLgic92OGh3Su3Tz2k3iRPIXvVBPj7c1Ms/9Mw+vATVJRjE0m53jzmML9czWJNAYWN8T8bqbT97HYybFwcqaoWGrZ4bYxPauR52Js01TNxyza11pnI77cGN307uOl1ktq1LqvzQoQmuM0ckk3llo0ZhG9YlYZ4Egz6ug2vAdGLSDAKqgDTtHtUjbA/Kht0QRtcr3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966005)(186003)(426003)(2906002)(83380400001)(82740400003)(36756003)(7696005)(82310400003)(336012)(8936002)(44832011)(356005)(81166007)(8676002)(5660300002)(2616005)(47076004)(6666004)(70206006)(478600001)(1076003)(86362001)(6916009)(4326008)(316002)(26005)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 08:08:05.7488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cd4825-47a1-43fc-d5c7-08d87fcf9806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The power/performance control strategy is specific for vcn use case.
Then this can optimize the power/performance when the workload is on vcn.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 0145504e408b..2c3e111bab43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -361,6 +361,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
+		amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+				false);
 	} else {
 		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -372,8 +374,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&adev->vcn.total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.idle_work))
+	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
 		amdgpu_gfx_off_ctrl(adev, false);
+		amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+				true);
+	}
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
