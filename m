Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DADC54FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 12:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85C5206D4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 12:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UBrPNASY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85C5206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4276E923;
	Tue, 21 Apr 2020 12:00:39 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680085.outbound.protection.outlook.com [40.107.68.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457BF6E923
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 12:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivx21x3aAhQ55dE4RkoQZ4MYoWyPrb3sGcJ2U5amBI1wx04WB5VJlu53pwvtTBChB34hi4hELJNRoz4HCL4wuoXLKzz9dDjJiVSNQIClNr8AlVLfzW5jnEZxIRH6HxwiJxw0EYrzprxGGYSyNTT1HeM9EJ9UqFcltN31U5BPyY8XbgzS7GzVHwOWvlN4Ih23LNsQ9kVJKfTmUbBe5j6pT7XcxRW1F5Qyrmtz18Kxddls6R+tDmK6UbL2sU1fyhBSf+KoeZaptTuKyEzyeq28eE13jyae/VHyW67K+VxRgMuHvjEvxBhQHlvfviwH7odarjXhGz2X2zyHH1SBTOLQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0b7obXSD7pc4RIBkwY3t1DSnI5vpemG+kaad73E5yU=;
 b=Ue0nSibnjKe6qkZNuDt18bvZ7+kP40Beuj/X3mqvDV3XDGztTsg31irzH6QpMlG9q+gh87M4izoguCWiuSm+abxUgW07FBElF7iLF+hat3Ot+Srfil4SETOIiUElLYa5TcSLI4VhuGBy+LbCY40kAuu1o7SnfvX/XRA7oXfbQbX1Z4UdJxQiOj999tUJWmd1tf10Ue3kCouiAd+CNOKoWkF5LiTlQ3LRDTbz16XkRSJhblNmE/Epu21c9pR6S/wkOeP0Arcx+/oNG4dG8vLdu9YBrZx2Wlvxq7gR7ScJiD49xgWzrxWia5sjyf1Q96liPp7xCEi/61ywheUsaSo1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0b7obXSD7pc4RIBkwY3t1DSnI5vpemG+kaad73E5yU=;
 b=UBrPNASY2miRN7YYNRajYw3BtgkgABo5oVheILXVvoYUkSqd2BcTnMsC+1IS//gfenBb28n9vhB39Cs1m2bumoad0E/EGnuiy1aNeNyGui7jybSVEthqnjES6BQo5N566+apAtXneDiiaVlP7yEJJFA2Qsf1XDDNji/2qtdGrhY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 12:00:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:00:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: put the audio codec into suspend state before gpu
 reset
Date: Tue, 21 Apr 2020 20:00:18 +0800
Message-Id: <20200421120018.11399-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 12:00:34 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e805ac0-43d7-4d8f-1e35-08d7e5eb99f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:|DM6PR12MB3081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB308102BF9D3EAB3450D78654E4D50@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(86362001)(7696005)(52116002)(16526019)(186003)(956004)(2616005)(6916009)(8676002)(6666004)(44832011)(66946007)(26005)(66556008)(66476007)(5660300002)(1076003)(36756003)(4326008)(478600001)(15650500001)(2906002)(316002)(81156014)(8936002)(6486002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2C/alOBhNd80LT5YeMwhZP9SyDYr1HlHsa6lWtmoOYZ2jVIhbONCe0VffeXvLzPWTJM1gY2cNcWyEexcrNmTSJRaaYXiYECWOKVbQGGtt/s8J6Vo0Au5mdyIydLvUuq+DEDDrCZxXPV4RgvdGOi1rbVDQyiTrmlzgKjSdgIZ+sRt+1fw4SweU9WizPZsAi/fLNCUkrjvPKqEsxNS61BrrJ3v7pqipPsODifTqNkElcUwmN+JLYftYfXSp/UAv6FsTY7GIEx5CBxfBQVIJCJHRW19MgeGe1GajgSeVBLEnbZBRU5Pmu6V1j7mtdhSXw8pgY7VP+4Z9p1Xi/C3lnH5UjIHUBxCmhz+mxJJ24jeowecrvw/kzTdyCvmCOogn4OyIYU1zUDfyuD1eJ/znnfz/5PCOKuLFVrdPNdqK3pU34s0rJGytOnqSym32eTvadhc
X-MS-Exchange-AntiSpam-MessageData: x6NJI/FRRARNmir2AZlKY1nLAh99xnLCMypd5m+HkpYG3rJ0QTXM3v42RMypZQar1sVNXH2S/ssWRIr0VlR+rH6zyJQN35B4kpu+hXNeaemIs+fLHXkSNo2Kn8tP/KqsgO6yGpgTK8EF+39yC18kkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e805ac0-43d7-4d8f-1e35-08d7e5eb99f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:00:36.1935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ln8pBYq9Q63OrbOF336zcpD+v0b4gcK1Hds2KwQGVEPuJpz4DzjgVDpsbna33ia
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

At default, the autosuspend delay of audio controller is 3S. If the
gpu reset is triggered within 3S(after audio controller idle),
the audio controller may be unable into suspended state. Then
the sudden gpu reset will cause some audio errors. The change
here is targeted to resolve this.

However if the audio controller is in use when the gpu reset
triggered, this change may be still not enough to put the
audio controller into suspend state. Under this case, the
gpu reset will still proceed but there will be a warning
message printed("failed to suspend display audio").

Change-Id: I33d85e6fcad1882eb33f9cde8916d57be8d5a87a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2d4b78d96426..983e294d0300 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -69,6 +69,7 @@
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
+#include <linux/pm_runtime.h>
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -4146,6 +4147,49 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
 	mutex_unlock(&adev->lock_reset);
 }
 
+static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
+{
+	struct pci_dev *p = NULL;
+
+	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+			adev->pdev->bus->number, 1);
+	if (p) {
+		pm_runtime_enable(&(p->dev));
+		pm_runtime_resume(&(p->dev));
+	}
+}
+
+static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
+{
+	struct pci_dev *p = NULL;
+	unsigned long end_jiffies;
+
+	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+			adev->pdev->bus->number, 1);
+	if (!p)
+		return -ENODEV;
+
+	/*
+	 * 3S is the audio controller default autosuspend delay setting.
+	 * 4S used here is guaranteed to cover that.
+	 */
+	end_jiffies = msecs_to_jiffies(4000) + jiffies;
+	while (!pm_runtime_status_suspended(&(p->dev))) {
+		if (!pm_runtime_suspend(&(p->dev)))
+			break;
+
+		if (time_after(jiffies, end_jiffies)) {
+			dev_warn(adev->dev, "failed to suspend display audio\n");
+			/* TODO: abort the succeeding gpu reset? */
+			return -ETIMEDOUT;
+		}
+	}
+
+	pm_runtime_disable(&(p->dev));
+
+	return 0;
+}
+
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
@@ -4170,6 +4214,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool use_baco =
 		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
 		true : false;
+	bool audio_suspended = false;
 
 	/*
 	 * Flush RAM to disk so that after reboot
@@ -4227,6 +4272,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			return 0;
 		}
 
+		/*
+		 * Try to put the audio codec into suspend state
+		 * before gpu reset started.
+		 *
+		 * Due to the power domain of the graphics device
+		 * is shared with AZ power domain. Without this,
+		 * we may change the audio hardware from behind
+		 * the audio driver's back. That will trigger
+		 * some audio codec errors.
+		 */
+		if (!amdgpu_device_suspend_display_audio(tmp_adev))
+			audio_suspended = true;
+
 		amdgpu_ras_set_error_query_ready(tmp_adev, false);
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
@@ -4339,6 +4397,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		/*unlock kfd: SRIOV would do it separately */
 		if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
+		if (audio_suspended)
+			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
 	}
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
