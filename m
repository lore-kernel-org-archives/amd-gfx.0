Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C3DC61DD8
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDCD2085B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AOX2aqRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDCD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE4B6E118;
	Thu, 12 Nov 2020 07:06:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0616E118
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 07:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxW/u+yu/GPfazCGeYJERJnM/L2M2RUDYrQZTHoA47GC5r7nLJ8zOsawIOjvKTAAO9q4QSvYDkX/nTcbfPJIJxoo8mcCkl2JjDKTRKP2bXeGjvSvPozJ2XcEM78PioC/6SLKP3ZtaSzjt4CsaWML5aXAvfjiJCF/tgzSqr6kUGpQNUpgRRbX1q2VYMsVDxeuTEIlESLtw9BdreyrarTAnTuT7zq1pp0NbiJFz7Ne6JpMnQV0iReuzFBV9WqVfuTqUdgNnJG5oF1K1FHkniHjMsoE5V0gpJFjjqLb/gi/MwHsL2AXlMt2SbofoEQDlX6g7J3x6dSmH2zIsQiYDfXXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zyYRFC91fcEJUCap9wzehie1GVRr0fHxLJTQ1xMfMA=;
 b=YF3EXKm8Vn8Hujj459wKn7thNzjJNv2jCGUR5fVji594e3rp9CF1k2+1pgCwN02RNkNBMKXbPMx3olXtl4FnnKEEeK8srBr4czPM1aVW7GyBKFE4UpgyfPhXPzQJ3lEQqk0FyeraPjBsWNyW4yR791JAGlzay9uRz8s5xMgSI8VuBtXbm2uQ9FqNU/jF9kMis43vH3Zz5yi/YKvIZrWJixU/CZn17aWroE5aQrletPRDJf0PG+EDlSVQfAg5ubTDzSZ2icJ0VB9FZlX0/Db7b0Ikj16k+4XOMegjS6MDzHc1SKrZUKnugaemjLQIw4NBExxSFNNIdp0/D+eW/Ft6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zyYRFC91fcEJUCap9wzehie1GVRr0fHxLJTQ1xMfMA=;
 b=AOX2aqRHtF25HBpdUEZ53aQuz65gu1KrQiChDGXVJ1zDPcChgnaMfjC2Y91ibEK9WuskwolpPTlIKlGpsJLsPaRZ2t52CPbpUEIjcxsZacbFWPB3q42sIjkyPaL7BW+Y4tHoHqI1Y+8NgZylvdo/Vi/zcc1y2YUVnxm2fde+sOU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 07:06:47 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 07:06:47 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: update amdgpu device suspend/resume sequence
 for s0i3 support
Date: Thu, 12 Nov 2020 15:06:34 +0800
Message-Id: <1605164796-22215-3-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
References: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 07:06:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 536d2840-a616-4c0d-7889-08d886d98510
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB478953A18D291EC34B436C5CFBE70@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnDXSxm5irFoM80ONlDFFQgX2FnJFqxu5RFA6u9ZzWsvLMq1HtODshfr/eR0k1eQ4otrcGBzrPMmV623Caci+WIsDywpNMOr1ky/hWU2RCQuWEISCCHgOwld0U0DbfvTlbdO1zysdi51mT4yhp6xGWrzgrRTsCVh+uehuhyC51EhUm/GfsUeh2vbn+c/YlQDP+Ow/SEZNCNJi1nr8pIu6nkD9jmh3gsTk3mU+D3V1lImMe6tB0JABF3OfVHD7syHJ7rjrQ7ROi9pli8KXS1BJEK1PTd/2ylWQkMTZwrVWOJ3fmgWr0NtpUto3/TAIZgvPqDx7yEYprLgHsCJJpM4TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(7696005)(478600001)(316002)(86362001)(6916009)(6486002)(66476007)(4326008)(66946007)(66556008)(5660300002)(52116002)(15650500001)(83380400001)(36756003)(2616005)(2906002)(6666004)(8676002)(16526019)(186003)(956004)(8936002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NOAo/pxPf8EvAgpmY+bzjCcc8w4uFn0W8brEx/Sqh/BUbLogNvW6z6LNzhURD1SW559+cv8BOeyNWqY1BZL1fS9TVdoQiqQVKTZskOL1Q4kDtpRlPZb7UfVtQJL6RJ1uoOis+9m2ekUCoYbhiK0EJrD7qyipda/oTvanooydepUZJ3ZjAv3c/wEzWqcmlUDTyQjhJCsiX0fWapthmVnPgn6kVYmGROfQGV3kuo82fHUqNKYqnXcxd2Q3DbdMYZj29npwfq28m3k4+rWCEwy+vpsDq1lu4ZK+HveMLD1rz4syXI0uFewdHmiRZ3aMusyDubMFn+smmvl3XR4FmteLhVIhTrq8wYy58SyH7+2ABzO4K9Ld0f5npV596V4+XDPLHVQZkL3L6Zi1xTyNIThDkk7GEFnvbuU1ygOi9dNGlx2KtAYprdfva1dHXyOQ3tj+nzRRm97g/mJZp6UmcZHY9ptLtddUqQ6HoY3alS7KdQ+HxJxDxeb+HhCUbTZUNmpCp7CXDBjBGVH5vNoa4y2QMkitsMDmfM1umBikq43/dtrgW70HTFDS4esoi+Euo7MPBFx6ZC0gRbw5ANDheSlUgMJvib0Jmn88Q4tGQ+L1WslK2tyBnyP9PJXeJSXGrL6NljoFcftuXCW9KhLi20McX5wLik+Rcf9z/qhOzn5NpG6LnfWVVswf+JTLRLJ8e4rCwhyBhLw5rO0LHHnpfj3DikQbXT98E0R+JIjW6J1k8OCv0VFBWTqZbA9UqvkYd8nzlGmuuWvFYKVM4x9iuCbxvixNxlcDB6FPTHA+SXEYKIunGSenOQana18HefYWuHkUReoGVRFNVgQuhV1CJNGmN3rBuT5+PFj3Stddg0T10QexVEMCs5QkpTm+CXFtCLSf4LKQF+gDwaVEj5ANBuoAuw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536d2840-a616-4c0d-7889-08d886d98510
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 07:06:47.2938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxNotuWF7zckuTgniPkE98HGvel+ScH71vLN8+23UCKitpB0FFvud/XlcCOv/HVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Need skip the RLC/CP/GFX disable for let GFXOFF enter during suspend period.
- For s0i3 suspend only need suspend DCE and each IP interrupt.
- Before VBIOS POSTed check and atom HW INT need set the GPU power status change
  to D0 in the resume period, otherwise the HW will be mess up and see the SDMA hang.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f78aace..cf6a1b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2650,8 +2650,10 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+	if (!amdgpu_acpi_is_s0ix_supported()) {
+		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+	}
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -3706,8 +3708,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	r = amdgpu_device_ip_suspend_phase2(adev);
-
+	if (!amdgpu_acpi_is_s0ix_supported())
+		r = amdgpu_device_ip_suspend_phase2(adev);
+	else
+		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
 	/* evict remaining vram memory
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
@@ -3738,6 +3742,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
+	if (amdgpu_acpi_is_s0ix_supported())
+		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
+
 	/* post card */
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_device_asic_init(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
