Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A02C2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 02:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD653206F4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 02:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lHGmYUDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD653206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFB66E413;
	Wed, 22 Apr 2020 02:42:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571126E413
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 02:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW8QfUvw5/l9qQf0QROPACYE+vIht4DdyYdfcBGEIeoDJGB7ENp8dnOh+7RbsOBEiW5BXgVVhbfBB6r+JFGjv8ehmkmt/ezvdYyZA0BBZ38CEDo2UoHfzyW9535L3mDMbgUwwWTL7GjXDswc0FSMe+u4Z0LHp6NSWF7fg5H7OZpDYjDaW898YXt7M1nhgsp2Dp+W4mqE2DYrNfJvathdSwvk1DgPO9OOJYQaTYf6q6EHH0Fq2zXiKKTFgP1WMl3P04/nbvAjAyrhedv19lLjJPjhIroucX3K4mLR8XfoPzAaKvyZtXE1Djk5fNawK3vLfAauY3jfpf934ERrrROY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP+o0h5RfABe4HauyiYCyDdUkRgk28GjrX1dTVfHgwI=;
 b=D8xZ2gkILFQC8VeGyVQbnDd0iJ7Rv8pGJvBz0OPX9ucVWbyV5Zfh1nhWoAwmdv0gMUt7g421rTGd0IDzX+ABWt1bHsIX2I+cwQg+kNDciM1ZwRTc8ZGAZCGEF0OvDlJmRdk/2rvuwOfbPYRioGLyvQ6BrOWtPan7JyomFof82sFEX7due0UZfZ19m7PQYOtNQKWtfuljEf6sMpnHJvCvbozyTe3ue9Aqv0l+dcU/xKC9dU30frvU3+06b1PmcFLX4YRLORc70woDySUswRYZFPxerC7dsaAtBWRCaOffwX64LnXJH7d5cH8BrVznnC2pZDvzzgcosX9ylA6/7fqdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP+o0h5RfABe4HauyiYCyDdUkRgk28GjrX1dTVfHgwI=;
 b=lHGmYUDUgwx5id+CYUBcgS2hNc246IM9AxhHUZMNBRhccRs+VmWxoDVfAIRvt1XFhQ4Z4I/l3z29b97O0lDI4yz9X1hH8UJSFsUyOALorkQ88OA/9aDHJpBIVWsaZ8kqkPh2kekK8NPA+6o+c0dp3oQRo5m9b8l8hxkIGtmLZ8k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2764.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Wed, 22 Apr 2020 02:42:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Wed, 22 Apr 2020
 02:42:41 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: put the audio codec into suspend state before gpu
 reset V2
Date: Wed, 22 Apr 2020 10:42:21 +0800
Message-Id: <20200422024221.16914-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Wed, 22 Apr 2020 02:42:39 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2b70b39-caa8-4f37-b21d-08d7e666d389
X-MS-TrafficTypeDiagnostic: DM6PR12MB2764:|DM6PR12MB2764:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB276445CE26027AA1C74AA76CE4D20@DM6PR12MB2764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(16526019)(1076003)(2616005)(36756003)(316002)(86362001)(186003)(66946007)(8676002)(81156014)(52116002)(26005)(7696005)(8936002)(6916009)(6486002)(478600001)(5660300002)(66556008)(66476007)(4326008)(956004)(15650500001)(6666004)(2906002)(44832011);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzqiyQdOmfU256+XsYFGxcd2Yz+nSOWIOvUlSFCuYAbjQsu1EvD/hSdijlpMSAVAVyBulqIrpXWrFfL+66o7j4w3saVZNf7pUVYF93+eQZFwv3izhomvljlNcwLxI1a5ej1g8aDshNspLMV5b7alO0Gj0m4IMkAV/5l20yLdvVJ/q8Q2yWSQUCxCqlDlMe8Kwwvvqc4x/ohfHi2hIejXSmyvOOnFNldz2QhGOrVIRllsDqmAP6yaAMsCVVRTGuZ55kzVrcyDz85zDokmFoEj7FxsHcq4cVT+uV80Tl0koN522m085dx7vsw0YxwJq4wY/1cV2ZIb7/NY78qsGJp2T7xLHgL83YWi7esOaD1kw0yKfckRqzSeshGE3W90pWDqEuD2mmWFDTW0KFrYLahns6TsMOsADI9kVYwbNZUF/mn9ICIkW+vbi8ueHKOfMldC
X-MS-Exchange-AntiSpam-MessageData: nbByzlohgI3xqafFz4k2iSxRYS9QurHpDNXdjaFkJHN4McnbdnfVwRxcBKISTYiBsg4V7FtPLsbubVBPKP9oPDqeiZ344Fa55NJhBeC6fu3V2DAfQFpa2ZhGZ6/G4GcwA2ZvK827eRhDbpbLazIMgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b70b39-caa8-4f37-b21d-08d7e666d389
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 02:42:40.8982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoSuKVwIupBGW+zmsaKMIR424EzpmIhcR6RyyXfSMpEAO8k7Bz1GMB17j9aERjT5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2764
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

V2: limit this for BACO and mode1 reset only

Change-Id: I33d85e6fcad1882eb33f9cde8916d57be8d5a87a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2d4b78d96426..70f43b1aed78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -69,6 +69,7 @@
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
+#include <linux/pm_runtime.h>
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -4146,6 +4147,59 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
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
+	enum amd_reset_method reset_method;
+	struct pci_dev *p = NULL;
+	unsigned long end_jiffies;
+
+	/*
+	 * For now, only BACO and mode1 reset are confirmed
+	 * to suffer the audio issue without proper suspended.
+	 */
+	reset_method = amdgpu_asic_reset_method(adev);
+	if ((reset_method != AMD_RESET_METHOD_BACO) &&
+	     (reset_method != AMD_RESET_METHOD_MODE1))
+		return -EINVAL;
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
@@ -4170,6 +4224,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool use_baco =
 		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
 		true : false;
+	bool audio_suspended = false;
 
 	/*
 	 * Flush RAM to disk so that after reboot
@@ -4227,6 +4282,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
@@ -4339,6 +4407,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
