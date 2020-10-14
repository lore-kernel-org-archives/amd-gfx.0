Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45CFC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 17:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C3A2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 17:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xR36bcC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C3A2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9230F6EB0C;
	Wed, 14 Oct 2020 17:25:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE056EB0D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 17:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ywrw+fW5vbHJQz7yXTWGWMWn3sBtKVc0EtZIOWpxgWx/ukYa22LCECRMvM5kfzrtJa4hA3ARwbhI8AxGrqoEn1yHPnrT712vHoulbmBiBdWDRDXcPkquQ/GJvhYlIWtM2IJUORSdVrTGkg39HtuqR0AyKUxhHYLJ86NyQV/2rARXgSagxmSUjs50zORJLNFs8rx6NeaxJyaV0Yz2AzwiRraBwDSpE+O5CStKWzX1ZOgd9ZWCpZ6R/e+L+lcRTWxBUSVKxXpE69DZzNXaCjoOT26LhCGRIHcf/Ef/bN38RUaV5e3j77AITiNFVs2o/nCQylyRlNOIcc7IGvy52vJvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76vxPOaz+ssmSoVVlGA5En3rfkkZ5AkV7TH3vfbny38=;
 b=kKq7+VpDItiCMAi/kR6aCfPmoI3Xett1AHKC1XUw7pf9vF+aLmF9jeBA4whzfAXT4BupwlTq00PykNGiE0vnM+7yjXVPlpFSfyx3vt11th/e+SoVbFP7Au0li+lS1ibL46Zl3NZ75rQsB6Is3W4v/nO/XM1YNwg4jny+b7zXSCz8L0JJoMN7sqbOywk4wvx5tcXDCD2YyU3GAh4AfUS+UpFp1DQyqORBhcpcw7vhmWvrZO8tEe1TPxOSRpiC04n4x5bdelSaEEWS9un6IF0dsJquCRX4JskoQ2IA7j7j1n/avg21qL+wPsVGf/tI857IM46hWZ1Wce1+cF7FHjhSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76vxPOaz+ssmSoVVlGA5En3rfkkZ5AkV7TH3vfbny38=;
 b=xR36bcC1mivjFsGDxxG4fyvZDScGnP3Dpr3z4K9eHwae45EYolNaKYWuA7iRiGCNeN39ASUlzV/yw1Z/VCFN5ROTW3rE5ZkyhmE/nXL2XXoRkZrO1obfb3gHmiQ2giQ2fBoXLUC5AosCCnjT6xRi+XkTG9g5/A7kd+HOewqXXhk=
Received: from MWHPR22CA0052.namprd22.prod.outlook.com (2603:10b6:300:12a::14)
 by DM5PR12MB2375.namprd12.prod.outlook.com (2603:10b6:4:b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 17:24:59 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::7a) by MWHPR22CA0052.outlook.office365.com
 (2603:10b6:300:12a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30 via Frontend
 Transport; Wed, 14 Oct 2020 17:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 17:24:59 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 14 Oct
 2020 12:24:58 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 14 Oct 2020 12:24:57 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Revert "drm/amd/display: Fix a list
 corruption"
Date: Wed, 14 Oct 2020 13:24:53 -0400
Message-ID: <1602696294-5611-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12eb6be5-e4cb-432a-2387-08d8706613ba
X-MS-TrafficTypeDiagnostic: DM5PR12MB2375:
X-Microsoft-Antispam-PRVS: <DM5PR12MB237505E753CF93F441F5247CEA050@DM5PR12MB2375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Htmw7A8727TeWe4pxZo1+Pwf0XpPNsatGRQ8kZxcLDJrDphtLG/EC4463WgxKTNp7P9JWaka2bjgOq18PQGkmD3u1XP6nPZ45M0xG207bFEb4zP67k+STBoTnxOGeroL5nwNP6+Uv6xSc4m9ZCij26ZP5uvYgB6zijwq3FXD8yEBPS1pHtYqfL0MSWjgu7X+e2keQITIRrzUtej2vL9hQPWqJ0U30E21CcYxE3Ai3w9Q0jQggYYIf2YZPi3Uim2qjVXGyDtvDq1nggZgHGMkFnbRYiuBGd5qtPo4mM/rx40PvRFm0RiCEd8XVZYkjjtfDGpqmqfM2u2sNuO/U8tBXHwTtZ8YSz6hNCAzLYeq5tpFxLGyg4xfq26SMw6RHJs1c1N9tRXxQdL/dYtawTmC0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(478600001)(356005)(82310400003)(316002)(54906003)(36756003)(4326008)(47076004)(6666004)(81166007)(83380400001)(82740400003)(26005)(8936002)(70586007)(8676002)(70206006)(86362001)(336012)(2906002)(5660300002)(7696005)(2616005)(186003)(6916009)(44832011)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 17:24:59.1037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12eb6be5-e4cb-432a-2387-08d8706613ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2375
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, xinhui.pan@amd.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes regression on device unplug and/or driver unload.

[   65.681501 <    0.000004>] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   65.681504 <    0.000003>] #PF: supervisor write access in kernel mode
[   65.681506 <    0.000002>] #PF: error_code(0x0002) - not-present page
[   65.681507 <    0.000001>] PGD 7c9437067 P4D 7c9437067 PUD 7c9db7067 PMD 0
[   65.681511 <    0.000004>] Oops: 0002 [#1] SMP NOPTI
[   65.681512 <    0.000001>] CPU: 8 PID: 127 Comm: kworker/8:1 Tainted: G        W  O      5.9.0-rc2-dev+ #59
[   65.681514 <    0.000002>] Hardware name: System manufacturer System Product Name/PRIME X470-PRO, BIOS 4406 02/28/2019
[   65.681525 <    0.000011>] Workqueue: events drm_connector_free_work_fn [drm]
[   65.681535 <    0.000010>] RIP: 0010:drm_atomic_private_obj_fini+0x11/0x60 [drm]
[   65.681537 <    0.000002>] Code: de 4c 89 e7 e8 70 f2 ba f8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 90 0f 1f 44 00 00 48 8b 47 08 48 8b 17 55 48 89 e5 53 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 fb 48 89
[   65.681541 <    0.000004>] RSP: 0018:ffffa5fa805efdd8 EFLAGS: 00010246
[   65.681542 <    0.000001>] RAX: 0000000000000000 RBX: ffff9a4b094654d8 RCX: 0000000000000000
[   65.681544 <    0.000002>] RDX: 0000000000000000 RSI: ffffffffba197bc2 RDI: ffff9a4b094654d8
[   65.681545 <    0.000001>] RBP: ffffa5fa805efde0 R08: ffffffffba197b82 R09: 0000000000000040
[   65.681547 <    0.000002>] R10: ffffa5fa805efdc8 R11: 000000000000007f R12: ffff9a4b09465888
[   65.681549 <    0.000002>] R13: ffff9a4b36f20010 R14: ffff9a4b36f20290 R15: ffff9a4b3a692840
[   65.681551 <    0.000002>] FS:  0000000000000000(0000) GS:ffff9a4b3ea00000(0000) knlGS:0000000000000000
[   65.681553 <    0.000002>] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.681554 <    0.000001>] CR2: 0000000000000008 CR3: 00000007c9c82000 CR4: 00000000003506e0
[   65.681556 <    0.000002>] Call Trace:
[   65.681561 <    0.000005>]  drm_dp_mst_topology_mgr_destroy+0xc4/0xe0 [drm_kms_helper]
[   65.681612 <    0.000051>]  amdgpu_dm_connector_destroy+0x3d/0x110 [amdgpu]
[   65.681622 <    0.000010>]  drm_connector_free_work_fn+0x78/0x90 [drm]
[   65.681624 <    0.000002>]  process_one_work+0x164/0x410
[   65.681626 <    0.000002>]  worker_thread+0x4d/0x450
[   65.681628 <    0.000002>]  ? rescuer_thread+0x390/0x390
[   65.681630 <    0.000002>]  kthread+0x10a/0x140
[   65.681632 <    0.000002>]  ? kthread_unpark+0x70/0x70
[   65.681634 <    0.000002>]  ret_from_fork+0x22/0x30

This reverts commit 44ad232df00683c3da75baf02c311a4fe97c4732.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index aae5358..a72447d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5170,7 +5170,6 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 
-	drm_atomic_private_obj_fini(&aconnector->mst_mgr.base);
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
