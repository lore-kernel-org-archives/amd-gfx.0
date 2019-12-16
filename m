Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D787AC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 09:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95541207FF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 09:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PeS6Vtcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95541207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47449895C3;
	Mon, 16 Dec 2019 09:17:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8CFE895C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 09:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1draaVQfKsZOpY3GzcCJJ+XhQRROfIUMybGVt3ACYQ7K6kRVehTB/uGB5SB4O0fjMRV9f5zUHGxkIV7+A7LGLVi95bbdthZurWEO7Cf5tdmUOn5gfMyI7P1uxBGAlMQOESVp6N7nurEV4itwW+Ri1VT+U5lqAxQv8YrU37ClKXxdXnswf3Gd+Y72wSGA6gPI8QoyKdwkdeOgn5+aXh/tJVXFzh+OQ8tWDfhPsYxg68KVMR9szRbJRev6Jr/7JnTwd/370FB2kdAa5P2FAJGpIZZKbNn98vUBg5QqmavSwEwHxu5UEJMxlTGBlKEV8vWMtB20WoUgonYBNB2FHgBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbJBnYoCH8Jzi2HOk/NUURzPVH5/3+UgegzRLA//V9w=;
 b=I5mPhSqM63A1mypeH7zupvsFtv+L1DZWoOjEuItbSA+nqy5fYSVvW5nmMqUXRnPtXoWGnD3XkjBNhF5jcP/Y3iwnkpmcKILdBBf6qVDJRsIv4tbJTVk6FiUbEdXX8yUYZcq6l2sz+en/FOKS8GLYp6p9pd3dk3oPl/0vqNS6VPUnOMYyMo91pthGsiRpdVufA+2v2F/gFupfyQhfj3YBkAxBGnCTOyBzLNAHDa0tfTjDBToQhP0Nmt98DRQOFBbysRTHuYcS7rcC106nNCla92rJrdY7dm2qyfMn2IQGzmFQoh4E80H5eCXrbvutVZE/aF6Vu7GlXVbmVO2wpLtOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbJBnYoCH8Jzi2HOk/NUURzPVH5/3+UgegzRLA//V9w=;
 b=PeS6Vtcgv9ECrnqKAOHdVSmvNBkBLY/xi+px4xFZo28HBs3uG++WY2gnqFlGu7/bzx4o9NgIS42SDziCHA5JOzun7f00F43NgP2WdH7KLGZne05nj4VIp3w9wahQDQLALmzMrEzOMzcu+HG/MZGGWdZtxAohY+fqhqeQTjHL56c=
Received: from DM5PR12CA0059.namprd12.prod.outlook.com (2603:10b6:3:103::21)
 by DM5PR12MB1129.namprd12.prod.outlook.com (2603:10b6:3:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 09:17:17 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::204) by DM5PR12CA0059.outlook.office365.com
 (2603:10b6:3:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Mon, 16 Dec 2019 09:17:17 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Mon, 16 Dec 2019 09:17:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 03:17:16 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 03:17:16 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 16 Dec 2019 03:17:15 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: Tonga sriov also need load firmware with smu
Date: Mon, 16 Dec 2019 17:17:02 +0800
Message-ID: <1576487822-3881-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(428003)(189003)(199004)(70206006)(70586007)(81166006)(81156014)(8936002)(8676002)(186003)(36756003)(4326008)(5660300002)(86362001)(2906002)(2616005)(336012)(6916009)(7696005)(356004)(6666004)(478600001)(26005)(426003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1129; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 482b3891-e30b-495c-b66e-08d78208bf01
X-MS-TrafficTypeDiagnostic: DM5PR12MB1129:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1129DD5FDB1B305B0009B2ED8F510@DM5PR12MB1129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 02530BD3AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPnl4KHUc34d6cdLOxnxn0V8TfG8JccJXMYcqv7vHdZU4q1Umx+o3WzPmVkxjGYeU2C7oghiapO2S7YbxnIg3fLr1daC+JTFjmg1gu91oS0t87jb1tZUFhJEK4AgSexk10+3wsB8veEFhJVDhmzgT1lzJlnbl6XBo434egjT0fu6o7EWt1qeRaVgav1ywrWoJ+QKFQrbhq99Oi0dBRL2zA7Ndif6gf08xfastx3lmBcC9qE7C/znWaSSondJ33VlbCTiXHcgnpvxc9TvpqBuZgC4BOsywyVbf80FmTx6bwwQ1/bUJJZeNSu9Ds/4Ky2qS5MpO9XzKGcl8BhtYu1tcJCYeNiIOOXbrIiwgeJqaC3aM7EF3KQD28cboowceS6Y6aP21d0yljoejTASMmstvGJMVWxszIsnSzwMrf2Z30NGLZWuQmGc10zvyucTcakn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 09:17:17.1233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 482b3891-e30b-495c-b66e-08d78208bf01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1129
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix Tonga sriov load driver fail issue.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 3 ++-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 26d1a4c..52d3f66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1818,7 +1818,8 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 		}
 	}
 
-	r = amdgpu_pm_load_smu_firmware(adev, &smu_version);
+	if (!amdgpu_sriov_vf(adev) || adev->asic_type == CHIP_TONGA)
+		r = amdgpu_pm_load_smu_firmware(adev, &smu_version);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 5087d6b..7293763 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -275,9 +275,6 @@ static int pp_dpm_load_fw(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr->not_vf)
-		return 0;
-
 	if (!hwmgr || !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->start_smu)
 		return -EINVAL;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
