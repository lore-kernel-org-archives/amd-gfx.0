Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0580DCD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 10:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B5B11261D;
	Wed,  3 Apr 2024 10:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CmHXd4Uu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C5511261D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 10:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvqfduaTqBGF+6RXdXC07c+zx6dKBYZYoZ3a/8K8mcm10jVt8jt1H+6TVofv8HWXuSkAQUkpgJmxgdon5H7Wnyuj91nlvRO1ItQZiTcUcMK+VXrmgp2rY47lDeITtd5huHUC7qc4OL/LEV3OgVeGEVgLJRKhnBfAULDQqYbOvhH/IXW6wlnraT8a++H9YnICmT+QZaVP6SwsWHCLDROt/c3427kx9fyiH0otoNy4bBuiuhQMDC7rVc/DqnIEV/SXdOrTo/w/MWsjdJmJS0xLtpjonbACs85oYxDGNKM8d/V7OusTexc5m2Uamvh4GsVhqHU/gakngHIsV6VcKDD9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGszFZsckHYog5M3SXgsoUXJ9aPV383WF0WhVm5QohE=;
 b=GyRQMO1EmZ/wp3lkudCWquLcUje/CIJQYHLc+fawSCcUSooG5BoiA0bi/n+OGpvSDY1WboVnr08I20LLlQ8TC3EF18AqekWw4W4IX8845+9cSeqyi9i8h4AodyA5E7mkKDyfYLAFRXpooyw08hDTSLv9cFd/8aAj2yqO0o3paphLdJomsAnB+NfFcBCVyt+du+mhCbZwOQxsnPs93szPXQpyQ2RC3ZgIQYw815tByP0j+yy6E8xBhTKOieeSGLZcXDKCfkUEpxIftObmYILMb7Nll+XDAIlKwCZYhY4dsWRnR5+h8VGKxdHz0+92cJU31aLBgDwag8k0+2sNRqyloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGszFZsckHYog5M3SXgsoUXJ9aPV383WF0WhVm5QohE=;
 b=CmHXd4UuMs/gYs3u3gpoGQnlDnpun+BPhRU7F3QglN9okp+/gayEp09kw/d6voPYtVf2Kb6lzhIzQKj8ZO8kjDjQ9VstE0LVmztlelo6OcaJn921SntV1X3SwYcKoCfMqqLtsvUHvbtLFAYF82cysX3xMfbzApmGymK/a4F8A10=
Received: from SA0PR11CA0051.namprd11.prod.outlook.com (2603:10b6:806:d0::26)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:19:39 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::c4) by SA0PR11CA0051.outlook.office365.com
 (2603:10b6:806:d0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 10:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 10:19:38 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 05:19:35 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Hawking.Zhang@amd.com>, Tim Huang <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect number of active RBs for gfx11
Date: Wed, 3 Apr 2024 18:17:47 +0800
Message-ID: <20240403101747.420602-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe2bde6-73c9-47f1-3550-08dc53c791dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0VygTLZaPsdsnlfhpk08WIoFns0BmgW2aeugPl1qyLcs7riG0h899JA2bdVivNrigsfu1HM2mFs3H/CZXznaPIEzGEosIq+6/7oUWFA5sUatgeOMmB9FcCPmBQbJCK63J2w4XSOpUK2vtd5/m5O0C7raywhnP40eBBiy7fq0kp4/Xx7jcZrb2An6CyXsiaQZRaT+Shsjzb9xdflXjdZN11vdvb1Ns/w/EbGPyA5/UFXssaopTg1osAU6xaLflCheNx5xoBDzllEBlhS2UOgUpRyr317u7u51450wfH9fuZAF2Ll04ul9QHsrxP3zU5nHp16jT8SIrpeTaAjMF/tzHWHsR1pTf5JGVt46hL+QdN5cQwvpCwX+vkUZnhFT6qqr2F5Qc2OQMEYfOuCvIwHf8wGtG6/VGbPbFZ3/PjIPc1JRyAxK58QCe/+Mn+uZE0Cnu0SUFbAXPPkKkjR3GMTf4VjKSQUABBVrO4ps2ScmX2PeejJpPSEBwpi0AvyumeqqT8rLF2dMZSD4XeV2VI+bDGftkHHTIDczAI+G0hGDZPq+ijS8UOrI5n4P9dKCKoR/wGR0r+GJxR9L2v01cXgKlItBXLeFVGCLnyzoMUsEMDqe6gP+Of+79ignMfmFkvBwa+r1zk7v9tQFKRHupWnOFfhMEN5/MGui/rMssmh3zposC8X4MITkfAUqHYvB9CAQVUa92rKlb0NCGiSsmtdHKQhNZ6/Pc9GIxygJdJQZv4F46hUyXTmm1Lz59OpmkxM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:19:38.8058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe2bde6-73c9-47f1-3550-08dc53c791dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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

From: Tim Huang <Tim.Huang@amd.com>

The RB bitmap should be global active RB bitmap &
active RB bitmap based on active SA.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7a906318e451..07cdeef9d44a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1635,7 +1635,7 @@ static void gfx_v11_0_setup_rb(struct amdgpu_device *adev)
 			active_rb_bitmap |= (0x3 << (i * rb_bitmap_width_per_sa));
 	}
 
-	active_rb_bitmap |= global_active_rb_bitmap;
+	active_rb_bitmap &= global_active_rb_bitmap;
 	adev->gfx.config.backend_enable_mask = active_rb_bitmap;
 	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
 }
-- 
2.39.2

