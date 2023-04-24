Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A1FC6FD18
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 01:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E705810E1B5;
	Mon, 24 Apr 2023 01:58:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786FC10E061
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 01:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW6yoDAL3jlNHgfWQtfUhstfk+JEEIGIsrkMlCUoACkFckuqXWSE1wKL4vzzsxLZwrMG87zqUiY00wArSD0ORNpmPt7BGbOZ7j5QXWswzAuZ2+gjIwSYQTNUl344LCZ9Qd+7Q5SPsBDn7Lxy48acuHTYHHIqwgRBX6/zzrODHo1XxafI3yp6eiy0c3gbSU7rSrnVf0/G+F63RL+U3SA92uEF4p35OsVXQsLxoBjhIjmOjD0RP/cRaWJvJbavOfteTztNIMgqawECnsYathSha32L5lcdqnGRhVApfTSGmz3CbyIIC/0QUmCDZ93iABUtN3wx8jNHwQBl53RUxxvLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyJp9eJk119/mKw6m4iST+trVBCaGy4uItw/flPovLA=;
 b=BIhYTxTlI1sxKQK+7y/Q3xqovvj5J/qcjUQTJwI9DXVPgn1T6B3cuJDi8LVFwhYPPdXzadVBxoK6EeLiUNHbS8bdK/GAaMi4gi74gyeYS0mv3HsJ75AZp//hjejQpKl5Yj6pOAY971bBpdebFr8cd1dR9v111tX0ZSYfG5MZi/FsxAzvJs+xhULMbbNfmWQE0m1IjYulAhXd1Xjla8tm/hxRgDGclcg+Ygap5vhyURBymdWDa38baalrNyQMjMBPJr+3FtkHQTe7ekYK6OSEADw5qG65Vc4p+pyJtlQA69lT5VX3URc5usowDr5g1MkdQn/gI02x3OqT9m0CGGebTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyJp9eJk119/mKw6m4iST+trVBCaGy4uItw/flPovLA=;
 b=Ah7kU/obIGdAkaDuX3nrXzgWvzTYg5Uu+QlnqalovHLXJ7Vejnu5VOF/LFdb6aqE1quTz/xRjHufxYaGfku1WGUGmYQNPqqn6i9HyA9E1NtsEmX7z96m4EDDKPFit7xsFnOVuzXJunzQ9ETz1o8a0HBRjGhN/rTdaUZAatem0vQ=
Received: from BN0PR04CA0126.namprd04.prod.outlook.com (2603:10b6:408:ed::11)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 01:58:19 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::ed) by BN0PR04CA0126.outlook.office365.com
 (2603:10b6:408:ed::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 01:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 01:58:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 23 Apr
 2023 20:58:18 -0500
Received: from lyndon-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sun, 23 Apr 2023 20:58:08 -0500
From: lyndonli <Lyndon.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Use the default reset when loading amdgpu
 driver
Date: Mon, 24 Apr 2023 09:58:05 +0800
Message-ID: <20230424015805.78747-2-Lyndon.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424015805.78747-1-Lyndon.Li@amd.com>
References: <20230424015805.78747-1-Lyndon.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fd0047-ba4f-474b-894e-08db44676078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51yr3bVAeBu8iv29ydKyg+Y1+CsN4PxFsz4i28oNroLMJ0EBPu5aNEC+HOdtI08N989W2gEPHwbBn0N3RvviOYl0xugEO9BgQy3ZCs9/2tv6RI7FVJXSsLx4kUMdaK6KnZTu8Obl+JsMOER0Ap5xImTtr0sK6NB4US6PYHic33RQsSFLZ+kKuQTSs2ir6qrBsG46l9u6E9UWn7Wc/ZhuAmvUJh/E7zpruv/lIi2y0irnfBoRTkYMPZ+26dfG6heTm7M8PY/+ZnHkl+FMXR/vTUt+38LqEVhjUawiHV5+XMTS6JUCvTtbPBaPaquoAHFb0lWmIRAZTtOIZYLpNLUP57OuunOqquV2MaEu64g84fHG+qW7ZJxlxJeZF0aE5XkJ/jEOaHiphHg5pIiYJzphcBd3PtKfeCY8F7WFJJ1fjw0tkvgRfsMXWq4icFmeg5AF5t+OHofwk4keZtVx5OnnYjsnf5gFEn+9oa1g9bWYgWegKWk1BhFXmS+91XKDdI8RWGegEHbbXa4Av4Ilg/lej3VOfQyEnuFQKsIER9lKKwmOGeV+iAWXsG8YSViGkRcC222NLXFpb9ar0aVhb9v9qxsRTsGNY6rV+6SLpgSHaW3C2t2wq6MCuyJx06UCYAi10kI+MrxTXhp9Cc/e3iNzl3XjHABl5hYdID4qcTz0DuXHnoADFVadIJfDZDciC+RRZuT+pLxsvEOQUDE61KRARylcCw+WZju/4GVLrbGT4hbf7JdIdCLBCOoNsbqfLzi7Z8qNUtg7igQjp50EzQ1eig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(40480700001)(336012)(426003)(2616005)(36756003)(36860700001)(47076005)(186003)(40460700003)(356005)(82740400003)(81166007)(70206006)(70586007)(478600001)(86362001)(6916009)(8936002)(8676002)(54906003)(5660300002)(7696005)(41300700001)(2906002)(82310400005)(4326008)(6666004)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 01:58:19.3420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fd0047-ba4f-474b-894e-08db44676078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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
Cc: feifei.xu@amd.com, Victor.Zhao@amd.com, Yunxiang.Li@amd.com,
 lyndonli <Lyndon.Li@amd.com>, kenneth.feng@amd.com, shaoyun.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Below call trace and errors are observed when reloading
amdgpu driver with the module parameter reset_method=3.

It should do a mode1 reset when loading the driver.

[  +2.180243] [drm] psp gfx command ID_LOAD_TOC(0x20) failed
and response status is (0x0)
[  +0.000011] [drm:psp_hw_start [amdgpu]] *ERROR* Failed to load toc
[  +0.000890] [drm:psp_hw_start [amdgpu]] *ERROR* PSP tmr init failed!
[  +0.020683] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to
clear memory with ring turned off.
[  +0.000003] RIP: 0010:amdgpu_bo_release_notify+0x1ef/0x210 [amdgpu]
[  +0.000004] Call Trace:
[  +0.000003]  <TASK>
[  +0.000008]  ttm_bo_release+0x2c4/0x330 [amdttm]
[  +0.000026]  amdttm_bo_put+0x3c/0x70 [amdttm]
[  +0.000020]  amdgpu_bo_free_kernel+0xe6/0x140 [amdgpu]
[  +0.000728]  psp_v11_0_ring_destroy+0x34/0x60 [amdgpu]
[  +0.000826]  psp_hw_init+0xe7/0x2f0 [amdgpu]
[  +0.000813]  amdgpu_device_fw_loading+0x1ad/0x2d0 [amdgpu]
[  +0.000731]  amdgpu_device_init.cold+0x108e/0x2002 [amdgpu]
[  +0.001071]  ? do_pci_enable_device+0xe1/0x110
[  +0.000011]  amdgpu_driver_load_kms+0x1a/0x160 [amdgpu]
[  +0.000729]  amdgpu_pci_probe+0x179/0x3a0 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e536886f6d42..9738e3660cf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3578,6 +3578,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	int r, i;
 	bool px = false;
 	u32 max_MBps;
+	int tmp;
 
 	adev->shutdown = false;
 	adev->flags = flags;
@@ -3799,7 +3800,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				}
 			}
 		} else {
+			tmp = amdgpu_reset_method;
+			amdgpu_reset_method = AMD_RESET_METHOD_NONE;
 			r = amdgpu_asic_reset(adev);
+			amdgpu_reset_method = tmp;
 			if (r) {
 				dev_err(adev->dev, "asic reset on init failed\n");
 				goto failed;
-- 
2.34.1

