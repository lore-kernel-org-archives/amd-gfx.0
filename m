Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC527C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B761320733
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lx5wNPUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B761320733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A626E973;
	Tue, 17 Dec 2019 10:02:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1364E6E973
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 10:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgwLrYykkCP5gjlOPpIuemr7JjZWlh2+krO0ptT1wQSf1lOxNEV6dGTceeuZaVbts8YlZUGoILgzzDEk5B2sdXuJ3IZM2f/AIKir6Qp9QG5iXbd5sFBT1UTIXoklMvinS20s+hyPMvHh7Y1wCyzR3jHaaQsY91rxELPbYkyNiAcamIGjru2C3JbDJRsyWYdQhDL2SkfnAzeEfzXkCzikt4+t7+6SSdsBeVZvxqoK5HaEK7Z3WpbGKzkICdLH7CBM8oRePAX4dpQYn2Zt3M7RxQb0KgcGDycCLTbjEBPxN5mCyMTU3Xpu0ltLKbBFZF8XyH5wfpwimWFsJOIrB5DVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSaNuHk2VQzSzdf0V8roEbt62dC72OQ00mf1pA3HJRE=;
 b=fcBYkh/vVOiQP0wYO91gXhYZ4C0RFF/CjemlNVwoMGIWEvaNKcu1+opb26AOE4WZVX1Gdw+Vzp/j1Io017YQ9CpRblc4tDD2yZY83NTO29lo63XeLzOlnsuREaq7G9sp+zpN1o7HT3WGuibmUx3iVUOt0M3jGh22aiqP9L16c8AmErVkPzFje+xBejMGa61m9KL/8U4VLESSAY+MmcY2xmXxUOA+uxvK5Wj3LAAr6Z7bKXxNn1EZ5AQlGc+tCGxLtg/yXORyhhMWPfnrq6U17gV0/tpTY3gick+qle+iM8qmPqNOLLI6qH1A+vMY976T7Hjoke/yz/EIm4R6mZleiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSaNuHk2VQzSzdf0V8roEbt62dC72OQ00mf1pA3HJRE=;
 b=Lx5wNPUKDij+T35Xqi13ESSME4BAUIMv2OcZqyZpbOlQEdlMz8Rak7KCr5whrhMMYe9c/Kts3ufk6OC8eZw36gEU3GFd/z6fUSomVK3dwkWFY9hbyhCYuLu4p2GKGoMDT8qQDHKpU3KdNl5X8o93Do6ldsqYiDbJaKMFTdrTzME=
Received: from MWHPR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:301:4a::29) by BY5PR12MB3713.namprd12.prod.outlook.com
 (2603:10b6:a03:1a6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Tue, 17 Dec
 2019 10:02:26 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::207) by MWHPR1201CA0019.outlook.office365.com
 (2603:10b6:301:4a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Tue, 17 Dec 2019 10:02:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Tue, 17 Dec 2019 10:02:25 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 04:02:24 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 17 Dec 2019 04:02:23 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix KIQ ring test fail in TDR
Date: Tue, 17 Dec 2019 18:02:20 +0800
Message-ID: <1576576940-11235-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(428003)(189003)(199004)(2616005)(81166006)(7696005)(86362001)(81156014)(6916009)(336012)(478600001)(8936002)(8676002)(316002)(4326008)(70206006)(356004)(26005)(36756003)(426003)(5660300002)(70586007)(186003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3713; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4150369c-5032-421b-a459-08d782d83808
X-MS-TrafficTypeDiagnostic: BY5PR12MB3713:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37133DC936DAAEACCBA3ADE684500@BY5PR12MB3713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpEIZLkuKbDTnera2ZQPi+U37Qs8KiMieOw/HabAaXw/kWpP6+BNc+Nave5e5Za3qKT5DVOtVO/8u5YOmrw9BtU17PNWj4v1uZSQcJ+Dlmqqn5NVuiRLx1xSn99wsFdF+/5dxoALpNkaYClQ0oXqtJHNjeLaJqVq3Xz5uWJc/ZsmlWcLb4WE6TIUKHukOBTiK7xwrSyaNsxlwCeUc8RYWZRrrmuxxYpvFkZ13zUomO9DGKj2mDOc6zsiNtC67z5BsOn0ffNs0l68VOZ005LsUlB97TLheVDuYKqTjtQ/zbJZNqzZhxihWyReULzCXwhxXo6PNewHBVtn0Avw82dddFa0nfT4+t5M6/LUyFTOgZjg2AjrFF4hptfeakiukRZjzluDGM7qWxeb+q6VjXFW7jm5vvmCIpTi+IqSlbgyN+Zkw852HjBZxpgBIddXj3Jt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 10:02:25.6598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4150369c-5032-421b-a459-08d782d83808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3713
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

issues:
there are two issue may lead to TDR failure for SRIOV
1) gpu_recover() is re-entered by the mailbox interrupt
handler mxgpu_nv.c
2) MEC is ruined by the amdkfd_pre_reset after VF FLR done

fix:
for 1) we need to bypass the gpu_recover() invoke in mailbox
interrupt as long as the timeout is not infinite (thus the TDR
will be triggered automatically after time out, no need to invoke
gpu_recover() through mailbox interrupt.

for 2) amdkfd_pre_reset() would ruin MEC after hypervisor finished
the VF FLR, the correct sequence is do amdkfd_pre_reset before VF FLR
but there is a limitation to block this sequence:
if we do pre_reset() before VF FLR, it would go KIQ way to do register
access and stuck there, because KIQ probably won't work by that time
(e.g. you already made GFX hang)

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 605cef6..ae962b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3672,8 +3672,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	amdgpu_amdkfd_pre_reset(adev);
-
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 0d8767e..1c3a7d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -269,7 +269,11 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	}
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev))
+	if (amdgpu_device_should_recover_gpu(adev)
+		&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
