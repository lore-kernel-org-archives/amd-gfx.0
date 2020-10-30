Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62743C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7E22076D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JuBpbKvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7E22076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303FA6E14B;
	Fri, 30 Oct 2020 11:37:30 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700074.outbound.protection.outlook.com [40.107.70.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC466E14B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 11:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QETsoILz+mw673KVLomXX1wHJYJAU3MIWhsRCltEzMYgQesu+EA2UJkxe9zBc2dogL+Vf3ppDzlRnIhtIGwvGR1MvGdCiRzuqdwlzYZnhqzwcCJIK2W66Y3c8UV5nwaGjcW0zCQoI6EpH1pP3SNhc53LrujT2qC2Qxi8pDHmaus2VuM/dqGl3n0EF90WWStmC4TDrwqc2sc1VRz/ijc7CPLtyoYDNoJF37W4q1MzyHDe4P5CX3+MttQfe+7R1y+7KxsyfI4FZj5qAkjE1QtOjB4iontXDLHGWQt381OOR6UDCMATHyhl7l/OZ77mBRnWd6nqq5nnYXfiePXOUvxqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3EcBZrQQKaUvlI0j9mDVv0y2Rv45vwS/V+u4HfFSKE=;
 b=kaA5PcITsCaldipxh0AnYgYS9vWhkalIBXfQw4xbuO4DXWuSi76Z8U5ZZFk9qwIRgmsvBO6gvvXoGx/0jR2c2E2FzCuhpHLQxIO9j4sbIj8duzfH6d0t0N56eAs7Hrugfg3BUd7/1WUyfXsXh3DfJd1vtYIAS/nGTLl2XBQPb2r4+0QJBFy3Tgf+DNOj/0o8TTx3S7wVHPdl3MMA4fuAfHX13f0qmxLYPFL9921T/AQKn0QVd7MjI2uCxUx/feOfgdLSKtwHjfC7au/OPV86MBj2ztFYsr8SMLPxebr7+fcLzBPFYgsOUGn24LK9SuyemQxvbJTR1A/kV6D9as3WZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3EcBZrQQKaUvlI0j9mDVv0y2Rv45vwS/V+u4HfFSKE=;
 b=JuBpbKvlrN+PCc0PqWhBC573POMXK0RkfWxBIDqoB+9ehjpm+tTIIBzc+FFItvrAhWmda5Us+zp8/gNe4FHQz2q9UGKQIi5yGzo0A6E30KZ00RpySwvQ9YC/69kU4sosZrr1JpcMtfimmkIlIk6ol3MkPJhybIMZHFSJ6BvQP/U=
Received: from DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13)
 by BY5PR12MB4802.namprd12.prod.outlook.com (2603:10b6:a03:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 11:37:27 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::36) by DM5PR04CA0027.outlook.office365.com
 (2603:10b6:3:12b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 30 Oct 2020 11:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.17 via Frontend Transport; Fri, 30 Oct 2020 11:37:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 30 Oct
 2020 06:37:26 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 30 Oct
 2020 06:37:26 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 30 Oct 2020 06:37:24 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable gfxoff if VCN is busy
Date: Fri, 30 Oct 2020 19:37:10 +0800
Message-ID: <20201030113710.14291-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d327cf-2bd9-459c-1fbb-08d87cc82d6a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4802:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4802F0CFEAE7AF66882DBA3FEA150@BY5PR12MB4802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlUtHHkAvznDKnJmvYjP4ynNKapfE/WSV5LbR7iTjWmGGjacp+ou4NuGgAAKt1mLyWFP6D76cfexrCefVdYvbplsLSbN1wlSoa9UoC0cO7dHQ1uzwrGftz5/4yY0gehssXc2REZDegENgEKaIjqWg9R7IF2kfgw1eAazd3KahYKHT2/bZShJuxABBGBGwYse6Oq6dP9Lk+kNQhfbk4FxhAXWIF0AX6XU4YnBearxO+y/LUNLxZ9d98uyH08w2fZhj1qcNyFQ/T7jnDV1eTfYC4lcUt7ghJa8BAUkIQ7bxzf9+kpxpZdExoDquQVSxpRpX0rsURXEkxDUyTVWWQBQ7h0quFdUEO6ODYi5QLByFM0WiotmQgXa8BOGjEJsJ8BTFaZw1mgRWEJALsGXGzf0ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966005)(316002)(336012)(478600001)(186003)(356005)(426003)(2906002)(70206006)(70586007)(8936002)(2616005)(8676002)(6916009)(1076003)(6666004)(54906003)(4326008)(26005)(36756003)(5660300002)(7696005)(86362001)(81166007)(82740400003)(47076004)(83380400001)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 11:37:26.9208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d327cf-2bd9-459c-1fbb-08d87cc82d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4802
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
Cc: tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>, james.zhu@amd.com,
 leo.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Toggle on/off gfxoff during video playback to fix
gpu hang.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I5b938c446884268c2cda0801121a53da980e603a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 277a8435dd06..444b89413232 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	}
 
 	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 	} else {
@@ -368,13 +369,16 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	atomic_inc(&adev->vcn.total_submission_cnt);
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+	if (set_clocks) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+			AMD_PG_STATE_UNGATE);
+	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
