Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B13C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 07:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9891923329
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 07:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T+iIvcsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9891923329
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B3F89D99;
	Mon, 29 Jun 2020 07:11:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964A089D99
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 07:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCvAk2QHtv4T7dkbu5Tm9BXcjOx04TTPs8Dgs50Z3se9TZrIHJGz/zsvjl3yfBixvmkMZ7MBbADcTStemgg0UOjk3OVyDgQDRD6zWWjGgv3aXOOpcWhoq4/+KNegwQjZKFtRLGQ4bqYfhd0QTWSf5dA0OjlJ7vy70qDkd9Uglqz4vQJQ6BPwFLxkFFcqVMaJogE+Wpea9qCqGwztKtAihXK0YCu7oe7WMdf6JqrEh44FyhFrL1sX1LbjrZLdrVyOYMUsCCbgLKqNJqdhYRn/gMXXnxFXRxPM8uQnVQhohgTl1rwA6TvX/q7rbAWV78Saa9d9fainboOu5Iz3aj4RuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z+EbET31TaJ64sosUycR7kkYc4JJw5CNrYCuggzPbk=;
 b=n+tlIo2PErN4rZx9BToZf59a+0uNHfJ/mPLs9Z8zYFM+JX1K4ZtMX/ARsA/XHkIzxTQZshgzyYVt2+5ZurjODR7ObwgT42RVzxuieStkFS0m2S94GHN2jIZN9JCehOGgUy89TYovbhUSxihrH5sjdbHybqcyUqUToI7mUAPlA68rTQMzIyF46sfPMQSevKfNmtciuMWK1VK8wzxMrhDFIRfwa3l5uxdbQhpC4+0H5sma5BigpzFbtzuzVxNEBCQ/ukNX65bJs8ms+d3oQ/9AgKYl86I0mN18EoJp/UAxghSWAN0/Hq5C+epEMhYbvHVoUPcDn2vQQwKD7MV7NyF23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z+EbET31TaJ64sosUycR7kkYc4JJw5CNrYCuggzPbk=;
 b=T+iIvcsxL51icHve/WycDhfv3WpWJ56c8bsskCLXevJn9McAqOObL+d0xBl8MFq2cLxhqc2qpBjWQLV7P1mPYDLnbPStiGT0QposUYnAnWT/tSarShSAFAvAqqb/z1nKjGLaAv3pNdRKbu6miIPgPSRJM5pV5osYhbYsmqnu0q8=
Received: from BN6PR04CA0098.namprd04.prod.outlook.com (2603:10b6:404:c9::24)
 by MN2PR12MB3632.namprd12.prod.outlook.com (2603:10b6:208:c1::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 07:11:33 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::be) by BN6PR04CA0098.outlook.office365.com
 (2603:10b6:404:c9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 07:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 07:11:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 29 Jun
 2020 02:11:32 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 29 Jun
 2020 02:11:32 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 29 Jun 2020 02:11:31 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: make IB test synchronize with init for SRIOV
Date: Mon, 29 Jun 2020 15:11:29 +0800
Message-ID: <1593414689-17565-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(36756003)(86362001)(2616005)(5660300002)(26005)(4326008)(83380400001)(7696005)(2906002)(47076004)(82740400003)(478600001)(54906003)(70206006)(81166007)(356005)(426003)(8936002)(316002)(70586007)(336012)(186003)(6916009)(82310400002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9675a197-d9d8-49f3-badc-08d81bfba754
X-MS-TrafficTypeDiagnostic: MN2PR12MB3632:
X-Microsoft-Antispam-PRVS: <MN2PR12MB363280DC05CB696335F25687846E0@MN2PR12MB3632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lq+h+HL2yftaNRthnPKVJk9JLvADLrJHB00O/uesfx4+3rfVXEshrsIa43SGLS0sDlIgq+4RJSVGNWm4esCc6WTY2DKo0bHu4BqWsLCmUB1widSWxnVJRt1c5UdROK4YzEkxSsOAaR/zHTD1antp8iOyGqwGn4ldHplQCqL++vg+/VzDyBpPyijMCiucTkF76QeM+JDdWYoeIVAH4BZYj9rWFV6doY1RmJCOUD2yq80bcp+zw/VmKwyWd2REM+PG/cVpfSZUAylfc1tZdhtijtTaC1r+6CzcTTldS/hry2GhIlbVJ5h3ni8AL7GGJlXPTx4qW1Ond3AgXKEZYTXKwS7PI14wEK7hkG1AmdA7lDpBLgZflvp2tR2UN6tsL+o1QKRivst6lUW9gfr19vL0Pg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 07:11:33.0564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9675a197-d9d8-49f3-badc-08d81bfba754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3632
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

From: pengzhou <PengJu.Zhou@amd.com>

issue:
originally we kickoff IB test asynchronously with driver's init, thus
the IB test may still running when the driver loading done (modprobe amdgpu done).
if we shutdown VM immediately after amdgpu driver loaded then GPU may
hang because the IB test is still running

fix:
make IB test synchronize with driver init thus it won't still running
when we shutdown the VM.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 457f5d2..4f54660 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3292,8 +3292,16 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* must succeed. */
 	amdgpu_ras_resume(adev);
 
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_ib_ring_tests(adev);
+		if (r) {
+			DRM_ERROR("ib ring test failed (%d).\n", r);
+			return r;
+		}
+	} else {
+		queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
+	}
 
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r) {
@@ -3329,7 +3337,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	int r;
 
 	DRM_INFO("amdgpu: finishing device.\n");
-	flush_delayed_work(&adev->delayed_init_work);
+	if (!amdgpu_sriov_vf(adev))
+		flush_delayed_work(&adev->delayed_init_work);
 	adev->shutdown = true;
 
 	/* make sure IB test finished before entering exclusive mode
@@ -3425,7 +3434,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (fbcon)
 		amdgpu_fbdev_set_suspend(adev, 1);
 
-	cancel_delayed_work_sync(&adev->delayed_init_work);
+	if (!amdgpu_sriov_vf(adev))
+		cancel_delayed_work_sync(&adev->delayed_init_work);
 
 	if (!amdgpu_device_has_dc_support(adev)) {
 		/* turn off display hw */
@@ -3528,8 +3538,16 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (r)
 		return r;
 
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_ib_ring_tests(adev);
+		if (r) {
+			DRM_ERROR("ib ring test failed (%d).\n", r);
+			return r;
+		}
+	} else {
+		queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
+	}
 
 	if (!amdgpu_device_has_dc_support(adev)) {
 		/* pin cursors */
@@ -3554,7 +3572,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 		return r;
 
 	/* Make sure IB tests flushed */
-	flush_delayed_work(&adev->delayed_init_work);
+	if (!amdgpu_sriov_vf(adev))
+		flush_delayed_work(&adev->delayed_init_work);
 
 	/* blat the mode back in */
 	if (fbcon) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
