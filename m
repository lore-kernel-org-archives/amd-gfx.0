Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF7C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F9365273
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F9365273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F016E457;
	Tue,  9 Mar 2021 04:10:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595286E453
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP108o4Ik5CunyFTZ9sGFgYMeLMp3bVxFGlPS7gDbtZpJmJJ2FSnY1H6UnEt0L+ws2Ro5E9mloa/CbuQS6p56f+8m/Fm5HF8q01OnlTdRGoAtZPnJKM5mtMNrnoZWzUddQ11agb1vrmc84fITcud7fmdvFwtig5U08Y4sLKTST0nHo9zUlB7BpxZrYQAr5VhYmGh58r56UMPemftxqBei8ohJBq4hEf8BVqDI5/MpvefVK6RivD0x4+LifyS4SWHfCneqAsXVjT58vzJTGbe8cdYnGKjoAKh0B/VXIBWn+Z6DDuWGYnQiXsS8cWiTRizHTO490TgUhDcHXH7iH0z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyQsXc+MXALIikG34qGgkNrIz/dRRcA81MKzJrdyG0Y=;
 b=ZsqVrwga8fYQGdWduqkuOGL4Ouxd84jyBff+LkNW8501HlYCvk7iduEJ7EdhILVfCYaFtMf+XN2AnNqXgSmVimVRhFdkqhqBRBqDaeUmTej2EyMOVjTA/WNX2OKNk7AZN1lIN/z1fRkOSpX57K/Fxw9NzGz/8FNocpUve3lf0upXW7hS2yqpQBPkRFXvxBU3QiVMGeJtgDl8MVaxAzRNUNSdcKNsHUBWB8A/WQf9p8eQgiwsEWXci3y5Fa2x8JMWeU6XYd862kPsWmkVYkSNXrbdWww4F5qcWQG0Hz7Rj58I4qoAR1SsB1P37tUsinJAHsFUMu0pFTFPnzAZMYNOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyQsXc+MXALIikG34qGgkNrIz/dRRcA81MKzJrdyG0Y=;
 b=vyX7eNoFO+/9NVkV0VYinzRn68MPhAKR067NdHKkmrbOQjiiuIoimz0DCooUxgsM6ODyfh7N9RvhRDSBxTdONoIvcxF8K/Y3Du4ftR1te9TgXXeEgFmRHitxzYwgjIL1eB+2EJKVbEsM7H4rfPyKhoqJJrB+9CoYkZj+TakDNQU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 04:10:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 04:10:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: disentangle HG systems from vgaswitcheroo
Date: Mon,  8 Mar 2021 23:10:08 -0500
Message-Id: <20210309041012.23367-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309041012.23367-1-alexander.deucher@amd.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Tue, 9 Mar 2021 04:10:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcfbb659-c080-467f-44db-08d8e2b147f7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44864898441DE9F627BD4BA8F7929@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaPhH3eAl/435lYPgl7b2HuMBwROr1IgL/n75IB6KSOoxpCiOksW0t+ilgXXLZnjlaZlIKTaWqP6rOsFPf9FtDTV6sh8luym1gyHEaeKk4fO/t0v/1zfkCl3vYWVnkXwOma61UBxik+vXQZvNKIBRXs8pOaklmd/JOdhujp4f6PhzstMQxHYXHiW2yCfV2V56u9rF7SGjtpE0Gp9C8nbbR+6j2gLVtBKAg4BVYClY/fTr5lBJ2Ip4iYL5u0BtPgByvGhDa3q0+do1ekcquuB0fuzRlX8EAsn8bFcUNdcMjLnI+GANraWjT55uv0BLq2zZ3Wvp9lOuS2oHXYS0NU1kfC39yKuZNrQU1Ii0Z8xASTHcxQ3fmCEGx/R//1V24x/mH9ch6knC7LoQ8zfZCcDfoWVRrZsNw+YT3I6HUuqrHS0Kpj+mW8/GvEsshsKVkzlVnQBHfIjRo8i8zCo1YSyK+uIwBtbz5PdEGWEo34wEmaRbeOmYuYvMy8Yw6vyXpP7LruwUGVp36rRm1Z/xbD9hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(316002)(66476007)(5660300002)(16526019)(6916009)(8936002)(26005)(83380400001)(2616005)(8676002)(186003)(36756003)(66556008)(66946007)(956004)(86362001)(2906002)(4326008)(6486002)(1076003)(6666004)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m7Y5TQulg0tQNT8l78wdklUjwEqC+MJcJ9Rc8Ug5U/bsTD2A78IdIshYcHhe?=
 =?us-ascii?Q?CQLZUY1UgtNg2Hvpnm7rvJ3TSMUawuqraZiIZgK8LJJGP2bgSeGb2B3YYC8q?=
 =?us-ascii?Q?oULbNIAoCc5m9cR1ZCdC5wb9+2+n5amEJcKlFGzILrkcur9iadfPyqkyMwsj?=
 =?us-ascii?Q?6BIY0h2Nil6OhgwB+oOCyDiZDD+aQD1X35PRQuojo9bV4Ts+Brdl/SBJed6U?=
 =?us-ascii?Q?CSBHex1L98dnX8MjBha42EPjdWD0Wq7nqvLh21K2pqbInIMf7G4rGLmV2TeC?=
 =?us-ascii?Q?cXZO5yqG9UYERqALIZJTLOC1HOVGWMo3Od0AjGVvfcyDyLlxVBtttx6IO5Xb?=
 =?us-ascii?Q?YrbP44rOodz+qZ6bmElK863b1Vr6SlTwoRXX6glPd/2NgtEV4wCzR3/40pvV?=
 =?us-ascii?Q?BDd0CCYK8g96EE8mh9rdvlhSIGxWkdjPR8np/Q0PSIVQfoT8jLAMCt4Kz+aR?=
 =?us-ascii?Q?sfsH6BW3XUB/Z+Rbt5icYEYwz5m9tL7m/BUDGHnvbKQnjGwsgfaew6BAOm95?=
 =?us-ascii?Q?e3ZpyXFgBj2D4mDjh1NnPEp8BYPotC5AM5nLCEWGxfmk/fjovE1k4caNxRey?=
 =?us-ascii?Q?CwsbCHJQUbXtGe+DYMVDX7r/roO7G3k2JUVCipbcib/jjeSZ1dJVsc/vbTm/?=
 =?us-ascii?Q?wzZxXdoMvi0aLoy0+VfIyWgN8OmLFjjtBNVczrrA9taweZ4P8lX8l6irlWvk?=
 =?us-ascii?Q?SRH6W+NB3G0E0T/77J75n+oXnoNxaEX04i8Fj7/cL2hJaOp7ZzU8regw/mRw?=
 =?us-ascii?Q?Be78LlvNgk9G+Zo4Ce+q4U8s0Kpvzwdv6ppnA3bGxFy4ByRYyRDG30XdKMM5?=
 =?us-ascii?Q?fCfRdhA/0N4fpixmxkKkDQwpzS8VD1WKKc1BRMmbmiRHXXUCe1S4RLJBqpNn?=
 =?us-ascii?Q?+EFaqNPdWIabod4gFXBVh0ETyp7Tpgj4g8h7RSiyeTnpYiYuBtfth0iV2PiN?=
 =?us-ascii?Q?xy1hWT+j5D+gnwiNvRkG9Nae3PIYXWAAHIs/AjpA1PIfC3xCnLORwj1cl2DE?=
 =?us-ascii?Q?c0TfzGaDSK0+mRiCmSvWRnKbeHESSNcO8fwVd+9RlKSMUIKZGHVYt1LBHx4r?=
 =?us-ascii?Q?fGtNhl6V3KU0Acd+Oij7Jpsk0vLiGhVt5PQt8Lt8ZKa0sme7q0FnQEXEz12Q?=
 =?us-ascii?Q?2hGRWWhS5T745raUbMSy+oRxS3KmEQ1I9T2PLC273tglUPZo6Wj4pbZ3uUiG?=
 =?us-ascii?Q?BGPUfZujHfbSN2eByJ6Qv2H00SiLCBG3+Ff1pR7vifi3V4iNxiah1qxrwjHK?=
 =?us-ascii?Q?a/nKcd6lwYxFssa9RyU0UopMX8axgCEtibSgY8Y4wdrkBJYCacoaFiGv2Y5j?=
 =?us-ascii?Q?Bp90IwVINb805ZltgLVK/Usg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfbb659-c080-467f-44db-08d8e2b147f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 04:10:32.0975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toGFqks+moQ2krq45O9EvaYEW1Wa9MzSvj7Zg2Hh/D1IMsnrFxaqvQrLEoEDgE8N4uuQqDa0p0w5utQhHxwNxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There's no need to keep vgaswitcheroo around for HG
systems.  They don't use muxes and their power control
is handled via ACPI.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 34 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 ++---
 4 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b5310b35721c..d47626ce9bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1260,7 +1260,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 					     const u32 *registers,
 					     const u32 array_size);
 
-bool amdgpu_device_supports_atpx(struct drm_device *dev);
+bool amdgpu_device_supports_px(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
 bool amdgpu_device_supports_baco(struct drm_device *dev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6eb3b4d2c9b2..ac5f7837285b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -211,18 +211,18 @@ static DEVICE_ATTR(serial_number, S_IRUGO,
 		amdgpu_device_get_serial_number, NULL);
 
 /**
- * amdgpu_device_supports_atpx - Is the device a dGPU with HG/PX power control
+ * amdgpu_device_supports_px - Is the device a dGPU with ATPX power control
  *
  * @dev: drm_device pointer
  *
- * Returns true if the device is a dGPU with HG/PX power control,
+ * Returns true if the device is a dGPU with ATPX power control,
  * otherwise return false.
  */
-bool amdgpu_device_supports_atpx(struct drm_device *dev)
+bool amdgpu_device_supports_px(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	if (adev->flags & AMD_IS_PX)
+	if ((adev->flags & AMD_IS_PX) && !amdgpu_is_atpx_hybrid())
 		return true;
 	return false;
 }
@@ -232,14 +232,15 @@ bool amdgpu_device_supports_atpx(struct drm_device *dev)
  *
  * @dev: drm_device pointer
  *
- * Returns true if the device is a dGPU with HG/PX power control,
+ * Returns true if the device is a dGPU with ACPI power control,
  * otherwise return false.
  */
 bool amdgpu_device_supports_boco(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	if (adev->has_pr3)
+	if (adev->has_pr3 ||
+	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
 		return true;
 	return false;
 }
@@ -1429,7 +1430,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	int r;
 
-	if (amdgpu_device_supports_atpx(dev) && state == VGA_SWITCHEROO_OFF)
+	if (amdgpu_device_supports_px(dev) && state == VGA_SWITCHEROO_OFF)
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
@@ -3213,7 +3214,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
-	bool atpx = false;
+	bool px = false;
 	u32 max_MBps;
 
 	adev->shutdown = false;
@@ -3385,16 +3386,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_atpx(ddev))
-		atpx = true;
-	if (amdgpu_has_atpx() &&
-	    (amdgpu_is_atpx_hybrid() ||
-	     amdgpu_has_atpx_dgpu_power_cntl()) &&
-	    !pci_is_thunderbolt_attached(adev->pdev))
+	if (amdgpu_device_supports_px(ddev)) {
+		px = true;
 		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, atpx);
-	if (atpx)
+					       &amdgpu_switcheroo_ops, px);
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
+	}
 
 	if (amdgpu_emu_mode == 1) {
 		/* post the asic on emulation mode */
@@ -3576,7 +3573,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 failed:
 	amdgpu_vf_error_trans_all(adev);
-	if (atpx)
+	if (px)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 
 failed_unmap:
@@ -3636,13 +3633,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (amdgpu_has_atpx() &&
-	    (amdgpu_is_atpx_hybrid() ||
-	     amdgpu_has_atpx_dgpu_power_cntl()) &&
-	    !pci_is_thunderbolt_attached(adev->pdev))
+	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
 		vga_switcheroo_unregister_client(adev->pdev);
-	if (amdgpu_device_supports_atpx(adev_to_drm(adev)))
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
+	}
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, NULL, NULL, NULL);
 	if (adev->rio_mem)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8d4fbee01011..3e6bb7d79652 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1301,9 +1301,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if ((amdgpu_device_supports_atpx(drm_dev) &&
-	    amdgpu_is_atpx_hybrid()) ||
-	    amdgpu_device_supports_boco(drm_dev))
+	if (amdgpu_device_supports_boco(drm_dev))
 		return pm_runtime_suspended(dev) &&
 			pm_suspend_via_firmware();
 
@@ -1392,7 +1390,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
-	if (amdgpu_device_supports_atpx(drm_dev))
+	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 	ret = amdgpu_device_suspend(drm_dev, false);
@@ -1401,16 +1399,14 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		return ret;
 	}
 
-	if (amdgpu_device_supports_atpx(drm_dev)) {
+	if (amdgpu_device_supports_px(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
-		if (!amdgpu_is_atpx_hybrid()) {
-			amdgpu_device_cache_pci_state(pdev);
-			pci_disable_device(pdev);
-			pci_ignore_hotplug(pdev);
-			pci_set_power_state(pdev, PCI_D3cold);
-		}
+		amdgpu_device_cache_pci_state(pdev);
+		pci_disable_device(pdev);
+		pci_ignore_hotplug(pdev);
+		pci_set_power_state(pdev, PCI_D3cold);
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
 	} else if (amdgpu_device_supports_baco(drm_dev)) {
 		amdgpu_device_baco_enter(drm_dev);
@@ -1429,19 +1425,17 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!adev->runpm)
 		return -EINVAL;
 
-	if (amdgpu_device_supports_atpx(drm_dev)) {
+	if (amdgpu_device_supports_px(drm_dev)) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
-		if (!amdgpu_is_atpx_hybrid()) {
-			pci_set_power_state(pdev, PCI_D0);
-			amdgpu_device_load_pci_state(pdev);
-			ret = pci_enable_device(pdev);
-			if (ret)
-				return ret;
-		}
+		pci_set_power_state(pdev, PCI_D0);
+		amdgpu_device_load_pci_state(pdev);
+		ret = pci_enable_device(pdev);
+		if (ret)
+			return ret;
 		pci_set_master(pdev);
 	} else if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
@@ -1452,7 +1446,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
-	if (amdgpu_device_supports_atpx(drm_dev))
+	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8e6ef4d8b7ee..86eeeb4f3513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -161,7 +161,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		goto out;
 	}
 
-	if (amdgpu_device_supports_atpx(dev) &&
+	if (amdgpu_device_supports_px(dev) &&
 	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
 		adev->runpm = true;
 		dev_info(adev->dev, "Using ATPX for runtime pm\n");
@@ -202,13 +202,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 
 	if (adev->runpm) {
 		/* only need to skip on ATPX */
-		if (amdgpu_device_supports_atpx(dev) &&
-		    !amdgpu_is_atpx_hybrid())
+		if (amdgpu_device_supports_px(dev))
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		/* we want direct complete for BOCO */
-		if ((amdgpu_device_supports_atpx(dev) &&
-		    amdgpu_is_atpx_hybrid()) ||
-		    amdgpu_device_supports_boco(dev))
+		if (amdgpu_device_supports_boco(dev))
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
