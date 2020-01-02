Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2CC2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 05:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D21F206E6
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 05:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sGoRBYXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D21F206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12B68972B;
	Thu,  2 Jan 2020 05:51:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233AD89715
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 05:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arJXaZXktpdmPqe8+oZfMfpcMfkLXfzRf59CK2/edn/QK71MtvGUizNm+tPLBVuDIg3cWsMFjeNaunGc9WVYomCxxrjf2/rEcOWoXUjZrZohWFzxO7J8QQsh2FKg9Bx8C4rF3ZyTnzo5waPnavItaUFOdBJ5gdqUlBmeu8mZpmJWCEzzFMYWaZN154AcSqMeA7ceNyu6pUXD7G6WnP6698e6IkfW606+1bWK2MmLycYQYPpCOyL3jcDazEJ28cIz98clF/ifjbPSYPumWygGRoeCpFjP6tsEVlykaFaYU2ixoXj0X0GW4c4N3xFPw887LQbRC0BU/QOudwDZb/N7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgsDVGnSh/5/MtClDCyRflA/pT+s3ZHGa8GX6D8fGOU=;
 b=K6QLylReXoypD3bf7YXdto7cT0eWlU1SLg4XMmww++k5hz86H9p5dwbdVjZ7KbnEYT3VVR7zKKVT+Jq72Qr/8F0OFdMPKw4d85xnBW/b5qY9WATIob2ItE98AR/+KPjn1WOT4TCzgngG7bdjPintkSzmP72mvy8Bj+cRF84LToI6KKsB7br3gPs3ScJ4U4rGw4HqvSIB6i6xrpyS4w5Iu/5+XrPlCOB/ztKfeU10nOQotByfSUdFDJHykVp8yUWZ2LG8g1o0gM4K1p0RG2numIeA+93UvK2cqaJxk3acjUBrHxxFYTo7drmmwBYORBdAK41AJzR9xeD3Tl/Nd+G3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgsDVGnSh/5/MtClDCyRflA/pT+s3ZHGa8GX6D8fGOU=;
 b=sGoRBYXOTmooz6FWmt6JHMt1pmLqRODNCjsCjZfpWE+GRZh2kGXx436NewcLUp5kH+ErmnXzdGcl/9NONwPC5sfubIXtrkf1E9T1GSaOWqnCFks9UjfLqYNqrviLdsCrcG6DdMGlKaRQhUeJichE8I+hAbCY0YBtl9I24brTnew=
Received: from DM3PR12CA0090.namprd12.prod.outlook.com (2603:10b6:0:57::34) by
 BN8PR12MB3441.namprd12.prod.outlook.com (2603:10b6:408:49::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Thu, 2 Jan 2020 05:51:17 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by DM3PR12CA0090.outlook.office365.com
 (2603:10b6:0:57::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Thu, 2 Jan 2020 05:51:17 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Thu, 2 Jan 2020 05:51:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Jan 2020
 23:51:16 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Jan 2020
 23:51:15 -0600
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Jan 2020 23:51:15 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] amd/amdgpu/sriov tdr enablement with pp_onevf_mode
Date: Thu, 2 Jan 2020 13:51:13 +0800
Message-ID: <1577944273-32245-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(428003)(199004)(189003)(316002)(7696005)(2616005)(26005)(478600001)(70586007)(8936002)(81156014)(8676002)(81166006)(336012)(426003)(5660300002)(186003)(36756003)(356004)(70206006)(86362001)(2906002)(4326008)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3441; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a218c6c-cbbe-4e1a-fee0-08d78f47c8ec
X-MS-TrafficTypeDiagnostic: BN8PR12MB3441:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34414F9428EED04E45232C76BB200@BN8PR12MB3441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-Forefront-PRVS: 0270ED2845
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTv4oZfhtQ2iL3dCCPzSOvb6kPlRj7W8OxXPN9aqFoe1/QCs5bcpzXy0R0hi0HX63cGI0hla30P/LiJ25dB4tq/8lj4LxZHxzj66Xz06CxIu5vthAGcPCLMvobVaN/TdHiV4+Tzi84VHWy5BAHKYzdOhrcVnfOnn9Fvy7aLDxtvz4V3zS3s5qAXcwtevRFcmfnXWyrLnEktUKsRbwcnL6psJ3EhWf5uOXZvN/Sm0mdZoctPlLMEHsEnudYopgxSx7zARX74KShHTl5WQl7wWE/aIyaLhIL0ciJQ1Z5f/zUkE426tkFPQ77dAQKC2NXVco0cvs8nO1YPh0J4qENRmAjrvnl8D4HepI54WXtYyZBn/8mDUZGpHznrIK4ymvF6Fc13INkz1t7geVxy9vPImrqxlZ72fXiV+vPWToAc6BvsuDUMgfqWJ88NWRHJD9r+c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 05:51:17.1028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a218c6c-cbbe-4e1a-fee0-08d78f47c8ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3441
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
Cc: Jack.Zhang1@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under sriov and pp_onevf mode,
1.take resume instead of hw_init for smc recover to avoid
potential memory leak.

2.add return condition inside smc resume function for
sriov_pp_onevf_mode and pm_enabled param.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bdd9502..f003e9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2462,7 +2462,11 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 				block->status.hw)
 				continue;
 
-			r = block->version->funcs->hw_init(adev);
+			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
+				r = block->version->funcs->resume(adev);
+			else
+				r = block->version->funcs->hw_init(adev);
+
 			DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
 			if (r)
 				return r;
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fa17265..2e4a8d2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1420,6 +1420,12 @@ static int smu_resume(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 
+	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
+	if (!smu->pm_enabled)
+		return 0;
+
 	pr_info("SMU is resuming...\n");
 
 	ret = smu_start_smc_engine(smu);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
