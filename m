Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8079C388F2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 07:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B752071A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 07:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="edFXgUEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B752071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635D16E08A;
	Fri,  6 Nov 2020 07:37:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AA36E08A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 07:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCarnIHa91GiWG1isNsBKv/1tJvPWQ3E4ezVKfBnrwEqRF5QotGZ3uh4ud073OuVF5MqobQZqiMJXuo73hUvy6eL6hhBfa985oZvq/i8B7Gf6O4e2Y5HZ11ET8XUBCs+8Tqoso0dNbAGBMhad97md2so6vY0e2/Y8VxVE1lcMt92lsUdzZUHcmhhGbbq4cHKIuJbULkNdPa7XXakxiEylwE5xMGFd51U1ZCtq2npv0o5haNUhVgDrz/irZzohFPM0ZaGD5qwac+KmqYTRvB46swYYnasObhhWnDIxxnwq2NXFwYwi2LX78AhYNO+XcGIJGwdpp8ryJY2j1bX/aGs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln+cSqsPFiItEPwtm5cpx+Bit1XjBDLFwUpd1ZwFnlI=;
 b=cr55ukRLB8v0YXpCPod0f6vb+PVo6XHg9DYMK4F1AAjngWtukISigwgQ4rem17Og5V3XVj9Me4ixuTvQNVXvkTRHZoivel1enMNTOhEcvb/VHyd0eU26RY4PtCau3xr7Oc6ddLO0dsaY9k6ZXOZ9pSs0jL5EXPCBvipZVNTmQUox2MHXiOS8/bOAZoeWS8IIzR1qBoyGCD+QpvSphte4yqiBnWPtXREL+G1MwRvx18EgX4CmLJqcpiq8/mV/39RljNeyqBLze6Fclzj5aBT04OwPn+B97q7cr59E91QQpZpN4YvvMJ7NlhRiRmGuYZmWf83/BqBEZDW8TRN8yADaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln+cSqsPFiItEPwtm5cpx+Bit1XjBDLFwUpd1ZwFnlI=;
 b=edFXgUEjIYpSndeaVy0MToWn4WOui5dXWRKIEeGLjcbuGZK1c+DEEDzwKa4nRLYaSvYUOdWmzALDQyJEwzCHRFXXsAMZ9BGRNwIWsi40R0mZMu47IovJinOozw03gSPxIEtcZBYWNeuZhaNJ1ETOVg87jS89kdJTG/EA9bHSlCo=
Received: from DM5PR12CA0069.namprd12.prod.outlook.com (2603:10b6:3:103::31)
 by CY4PR12MB1430.namprd12.prod.outlook.com (2603:10b6:903:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 07:37:12 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::1e) by DM5PR12CA0069.outlook.office365.com
 (2603:10b6:3:103::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 07:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 07:37:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 01:37:09 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 6 Nov 2020 01:37:07 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable DCN for navi10 headless SKU
Date: Fri, 6 Nov 2020 15:36:59 +0800
Message-ID: <20201106073659.53993-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f648e52-beab-4ba4-2239-08d88226c64a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1430:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1430C3501CC30A823C17C46895ED0@CY4PR12MB1430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvyNqvCla4jEVLo+bFGlmwWS4wBC1HY5+4r19+uxgaebJ6ClqzZhg5s9Bk4HoOKlIwU4JihYgnKQjlLBlaYEQtPDhtvEH4nsi3moCUlAVkr5SrJ61QuNU6Su5BHa3bTNyrrR99ScMv8GxXaFkgnREMVwn6WLf1cVYV1SHfNh1pF6pnHzQKhHKcz6MLrPgLjGDd1K4OrN0ag+V+bM0MvFwmMIWynnTR6CVetmHJLKrrfeYRRhPBjCx4+miV31wnLJ6e/qhMFBnMsxFs19ErLkkZhXFmGCsLDOGokbFLswOuGpWkc7kxXlFK7lAvoyxmny68uYSYWmiNgLi2A78QOypaXaGjvfoeJUZxSuof12bvQBYbFUQRQ96Md5ix3P2+h690YhdAC+5TQg3Q2aQ3bKEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966005)(186003)(70206006)(83380400001)(82310400003)(6666004)(26005)(336012)(478600001)(356005)(7696005)(36756003)(70586007)(426003)(5660300002)(4326008)(44832011)(316002)(81166007)(8676002)(2616005)(86362001)(6916009)(54906003)(8936002)(2906002)(1076003)(82740400003)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 07:37:11.9061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f648e52-beab-4ba4-2239-08d88226c64a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1430
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

There is a NULL pointer crash when DCN disabled on headless SKU.
On normal SKU, the variable adev->ddev.mode_config.funcs is
initialized in dm_hw_init(), and it is fine to access it in
amdgpu_device_resume(). But on headless SKU, DCN is disabled,
the funcs variable is not initialized, then crash arises.
Enable DCN to fix this issue.

Change-Id: I33bc30210e3420e60ceb59175e39855d00b05b06
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e33d8022cc32..67375b2948f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -535,8 +535,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev) &&
-			 !nv_is_headless_sku(adev->pdev))
+		else if (amdgpu_device_has_dc_support(adev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
