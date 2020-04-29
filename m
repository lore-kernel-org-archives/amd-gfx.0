Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD926C83001
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 02:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CADC20737
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 02:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TzEGH/y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CADC20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC4A6E0D8;
	Wed, 29 Apr 2020 02:57:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDE36E0D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 02:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8Pd9pbChAl9fs76Qil9QDMRsQHyzKpdpeq+GoZIOvgypiw4bOPCYHBNOXwlIERfR7yDP25coQp+gZqpXkGtjP564gHeAOVVoBo3Z6QDrHnt0Jcld0DX8NKaa8dOghvdn4WnYrMph09liauHmKQ1tBWqz9OJUBGyBvD9fsB4F20/ZeJ7JfjWL54dV40Lf0HuuzOm3Fyc0FDf9R7IlC0jjjSx+TNNzfYfVMLbJK6dc3ZQmBKhLxUED1vi3qP3DKvU8vfrMzeJWcuw/uHXxKscLPI1j4SXM4hAfN8b/6sNIGc8gx/NoQKaGJaJ/sg9eZ+hMKgquxLW2ASud4LkZfR2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxr+qRm4Y4foypWpOgtY0DHCRjNE/rKVoIDl5qAc3Dc=;
 b=BmMUZw0UfrDzsN5OWmxiKWNDQK3kOmmvNHhP5YhUPOXub6d43H/xZNtfzA5GTxCoWbGWmGx2UxGLsP1skZ4bOnoXA2DyH0gRlEbkuLNJ8VXg/W/bBCRCMlgEU2KvzsaRfqPbMDOaEfvT7lHBqV+AkNdznnNhI4vXZrF3ljaeSpGpeQDHlDl57qnHvdfKPIaN4M0duSJAH2KtRYXUTPp8Y+BRJ61rS+/90GiN1GvBD1QpQpFAj51hn8yddOokx+Oypgz88LGgaBrz40SDyJZqKj+gbuGt81OR0wXWTH1rNPYfJvvJ7YAYp/YdRyYNFo0zU2bSgeK14lsUHsX+n9eUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxr+qRm4Y4foypWpOgtY0DHCRjNE/rKVoIDl5qAc3Dc=;
 b=TzEGH/y31FBJiMk1sw8sdr6Y75ABVKWRl9vJhQk10wDgLA6sdi6fq6pOPtzPn8UY160yo7cKku+S0km8RSE/BA3188gVKDvgEyCXohrRwNCB3VPRsuwOvsCoPw4ZYo0tMP5PNe0nU5B+05+2QQbR7tEu7FfILkU6ZU30I+8yU7s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3162.namprd12.prod.outlook.com (2603:10b6:5:15c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Wed, 29 Apr 2020 02:57:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 02:57:30 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: put the audio codec into suspend state before gpu
 reset V3
Date: Wed, 29 Apr 2020 10:57:07 +0800
Message-Id: <20200429025707.2752-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0135.apcprd02.prod.outlook.com (2603:1096:202:16::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 02:57:28 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20328a69-a281-4089-2aa7-08d7ebe90e1d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3162:|DM6PR12MB3162:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3162014D8EFA8EF3DA2511BBE4AD0@DM6PR12MB3162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(478600001)(26005)(7696005)(52116002)(5660300002)(86362001)(8676002)(54906003)(6486002)(4326008)(316002)(6666004)(66476007)(66946007)(66556008)(2906002)(2616005)(956004)(44832011)(16526019)(186003)(15650500001)(1076003)(6916009)(8936002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5V/RaEtxMZ/WTib8yMKa7HePP9xZvP6Sr84e9CElEh6nzD3TrnVAzKbrIFSQ1OZSxzZZ+x8IVUEHvcnAEDTM8qX4w9RSx6a0AWeKxULMXwKfXVKDb+sQ5MlpzKCSNlqoYLmnoYQwHuUsb8ejcXd9pOamutV4mEqGcnIzscuqcdMJBX0ANeKBeFw7IRVpfbiSEYFhJi4FQgP/VBpRmiWZTfnk2QSTeNHWgWo41MddVAI3AAMMLB9vayKV8WZY74lqmmIpurWKZ60NY2r9Vzrh++n2eq04l1YeQhzilbaBBjpqkLadxY2U7+pK0qaEr4J3y8V6eoLh8brunW4celG7VRBTMVPAVXOHT9a04LiIOHGd4WtRNe910kM0uMtXjLlkhXBp7OKrUrR49torDjvcNLnCUWSTtfPz+8BF03KjYE1uUialwM6lJABCZHa+eeX
X-MS-Exchange-AntiSpam-MessageData: NJZFLFfDbAWcLSGHW0Zurn8Ij5b5QEn4RNW26gzynPqXRIEv+HQqlb/LqkrxIKXPLiBQfXJr2MJXjQRQF90KLKArc1PWUue6L1kcbHK7Ufs+DryxartYNnVm6DhljjmCDRGdmqB2UQLw6S5mxi/DCvlKxxpry4a9FyBsSXVW1Thv76LyvLkm/bcyan88W9vJn7UE3Bl6kY7Xnf69Tf0YB/uX+wS0sfmVs228Na64gHtxtMKy83HADy7yUBaWcchjVrmNOT+AEEe4z6ofjhjIIvzRMQtq54AEPy3CK3yTJwHKqy5tYIO9NM4RhQuAd3bJTd6LhaVP1dFl8zIdzw+bH2SDVzdEPn0g7oi05IOLcnsTpOVv730ipxJficz8gE4lDgM5ztEKI4iHG2Lq8b+ysIDaX5D+iNhZ+CGQ4PnfiWBj2iiDPZOewOl6nLiGPthKpezC0N0i1+DuYwvX7Vtsc0I1MvcypnIVU/VCFnyJNuh8UGktdK39VUk9BGx+26V4Gm1/fh5FsoXG6HuyvGiemXT9H2f/32Z+JKGTTn1lSvsZCrchhW0g/xyjpwAsNKEsvGT2pgDfG9nayosTPhxiCbHp4WtTjEeCeM3vjP972iSwSFd5LA4hegO/bFIOqOie75i36iuWJuP9yP5I+U2oJhSw5oAF5eB2sNtswuDXSMUvcjHdTyNAh9kBE28X6t+e9TnehpLfcEnJatExo32ODFOU8CXbknzxQbAPZT4Ake2t0LGb2GFEa1eNgPQqUFLkYcEPwTbKtOU2LCjA80c2DiTrWaHWT5obhgxuSu3fwTI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20328a69-a281-4089-2aa7-08d7ebe90e1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 02:57:29.9616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlWMFcLmk+cIZiA1b2+w6o9y3+S7P1v1uWzirsyPZVG6Gblq0LpRQi0ulW1BlQzq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
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
V3: try 1st to use pm_runtime_autosuspend_expiration() to
    query how much time is left. Use default setting on
    failure

Change-Id: I33d85e6fcad1882eb33f9cde8916d57be8d5a87a
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fb4ed0284f12..0a47e60e3c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -69,6 +69,7 @@
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
+#include <linux/pm_runtime.h>
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -4145,6 +4146,64 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
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
+	u64 expires;
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
+	expires = pm_runtime_autosuspend_expiration(&(p->dev));
+	if (!expires)
+		/*
+		 * If we cannot get the audio device autosuspend delay,
+		 * a fixed 4S interval will be used. Considering 3S is
+		 * the audio controller default autosuspend delay setting.
+		 * 4S used here is guaranteed to cover that.
+		 */
+		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
+
+	while (!pm_runtime_status_suspended(&(p->dev))) {
+		if (!pm_runtime_suspend(&(p->dev)))
+			break;
+
+		if (expires < ktime_get_mono_fast_ns()) {
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
@@ -4169,6 +4228,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool use_baco =
 		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
 		true : false;
+	bool audio_suspended = false;
 
 	/*
 	 * Flush RAM to disk so that after reboot
@@ -4226,6 +4286,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
@@ -4338,6 +4411,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
