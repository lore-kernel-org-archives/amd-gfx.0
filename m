Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51766C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F1720773
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 02:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SYg20eF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F1720773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64916E891;
	Tue, 14 Jul 2020 02:29:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4856E88D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3iSDJ0da1GzNMF2bb3PgXeVAEc1Hlv6BCBxLSbAQXvsndno/ShcTupbs5jkFEeorZwnWEek7YuYRTyVmR3bb2YLE2OkdLudTEqHnjEvoMtsL7/Mig4HQf8rbWnU+p42Tm4eyU+lGiy7EQAeKE6SOm6gKEGmiaYnRJtiFmIU0Lf8Ydouc5gNk/HpXa5fW4uDo46pomg4/XoafE9arhUfgRDSvOFUo/O09MVasuUH+3U30F4K2v49crOo/ld3RuSVLBsmlpc3utckfrVuXXBHh0fzlYnldFUAOhNOCgW7dmktXDX6pP0t1insxP1co+8z+2XMYOIgqfl3xEXLek5SNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoqXQqMe6c6BbVri3s/uZuEQDRLL5l/zsOArBubxb7w=;
 b=XmY+CyXZZ5IVrVxl63DPJyxlbHV81d5UOaIXIm9h6DIImjC+4SwQECg0gWDXIAzst9lMUc61xvHyv7uW+MBOsCSxoLQmn+ntEZPk18E32j70kcYffMKBoQKSKh3RehXknVUGYb8cABR5eX6RAfbwkKRs2eRe9mkByGW8IKEDnlFnFDiaa+B3ALL7X8GeioxCnR8UE1OMIYV8Kyx/8HdXvL0cfKybz5AlVLWv+Gsmig3KsSReAxz0wr/++C2hZpFBT26lmK6+jj3Vqy026tHgB7ZzVUdKCn0sAWXbIvzxVM+0o5y8JStcvcmRp80bLfGoZ1551N8k1eKGBFpdFFKVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoqXQqMe6c6BbVri3s/uZuEQDRLL5l/zsOArBubxb7w=;
 b=SYg20eF6w+YYDPrbvdMkSQVmqLNa1zt19VoOnCw0GaN5fJGlFlJceS+QFA9/g1p3IFU7Wn8RYSATN7VbVXHT1GZP5RKVh5vvCS/go0ABolYoRyLLaJK81QWmujhvPSgOYwNUNArA4vmuF5Dgiiqd7h9/p2pAHHUknVusnoNqFOA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 02:29:27 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 02:29:27 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: RAS emergency restart logic refine
Date: Tue, 14 Jul 2020 10:29:09 +0800
Message-Id: <20200714022911.3006-2-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714022911.3006-1-Wenhui.Sheng@amd.com>
References: <20200714022911.3006-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HKAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:c8::12) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HKAPR03CA0007.apcprd03.prod.outlook.com (2603:1096:203:c8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Tue, 14 Jul 2020 02:29:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94cefa4f-9664-4d30-aa21-08d8279dbae1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4232C0E747A3D2A6DF7BEA258C610@CH2PR12MB4232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYo3Q/4JlXWCocb6Zg3WKHmEHKbz5oNQXix1a7FQ/o/8dbxrUKwACBlFwumUuh31rXPXltYdhAYAvDBtTxVeVSD/dVzFLpbRG0ZZ9Fbci0Xx6Ocm/dM3Kfw1cA80SuwM2UDFB18nAUJkHejIHcoAvDqpWchr6tEv1DmFcy4+vbpT3aPJN9BWNQk/juRzBBMsQRYcQOLIR2YHxvEKVe+jneFpcLX18faABUZbk4CqQrqDwFWMqYsB8fzXvIxB/nBWDde8CtnY51PxJtqKR4xxqoFefKA47oRrz9fXpdugMjfaQNfGnZMs+hTWUD5VYyu9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(16526019)(2616005)(2906002)(5660300002)(52116002)(26005)(54906003)(478600001)(8676002)(186003)(956004)(6666004)(1076003)(6486002)(66946007)(66476007)(66556008)(316002)(4326008)(7696005)(83380400001)(8936002)(86362001)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mwvxEbBgM0hvrTjUc/B3QvWtLGrUYP8sNNqUoMMw7Bam4kes/gFt7aJFXjmyPOAA0qK7R57UwEH6orOGdByRUGavuasj+lZPBYxRVlrAdtqB41+sJi6kDhlk+fanmlR+8s5DPMjWa72GkE6nLt90dlEyn8/oCm2SdXVP5ZIYo8aZ0Tlps3ZDnC1y3Q6Tgbp0OgTPedoOgLQlu1MObEDr1beyljOReShO3KGV2fi95p2s+2BZo+i+ygUL/WQOsrLZl/bSF2WPd+/JsMRCh+7CIXmIajfb7XKBZ4nc9Xg1f8u0HzDvLQwAyWhXUX+io5l2vJLNINt2l4hdAriLI9NCYFAU94Dt77PTY5DKa4Rr48FAj/NbX1S/gi5zYLJ0s4SbPnSOM2HubW4b/9lQmAfid2ZIm2lPmitC7IBHiorg6JUFnf6DARF1eEcpCTx8iOPoInF0gPyzpZdrCH5NeElFyg2S0uqG2av3S77kuWjI9+21ylWHlSNx8I2hoJuCfzVj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cefa4f-9664-4d30-aa21-08d8279dbae1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 02:29:27.3138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5o3zXmH/twdLNDlNRPm+IygsiQecD5I2MXyXx0/lTb25woevrbJWVsHgJIfESFWELjtXLsuJWOVrdqSideZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Cc: Likun Gao <Likun.Gao@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If we are in RAS triggered situation and
BACO isn't support, emergency restart is needed,
and this code is only needed for some specific
cases(vega20 with given smu fw version).

After we add smu mode1 reset for sienna cichlid, we
need to share AMD_RESET_METHOD_MODE1 with psp mode1 reset,
so in amdgpu_device_gpu_recover, we need differentiate
which mode1 reset we are using, then decide if it's
a full reset and then decide if emergency restart is needed,
the logic will become much more complex.

After discussion with Hawking, move emergency restart logic
to an independent function.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  1 +
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9a0319605489..e0e7da8573b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4275,18 +4275,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
-	bool in_ras_intr = amdgpu_ras_intr_triggered();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
+	bool need_emergency_restart = false;
 	bool audio_suspended = false;
 
+	/**
+	 * Special case: RAS triggered and full reset isn't supported
+	 */
+	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
+
 	/*
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (in_ras_intr && !use_baco && amdgpu_ras_get_context(adev)->reboot) {
-
+	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
 		DRM_WARN("Emergency reboot.");
 
 		ksys_sync_helper();
@@ -4294,7 +4295,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	dev_info(adev->dev, "GPU %s begin!\n",
-		(in_ras_intr && !use_baco) ? "jobs stop":"reset");
+		need_emergency_restart ? "jobs stop":"reset");
 
 	/*
 	 * Here we trylock to avoid chain of resets executing from
@@ -4366,7 +4367,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_fbdev_set_suspend(tmp_adev, 1);
 
 		/* disable ras on ALL IPs */
-		if (!(in_ras_intr && !use_baco) &&
+		if (!need_emergency_restart &&
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
@@ -4378,12 +4379,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
 
-			if (in_ras_intr && !use_baco)
+			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
 		}
 	}
 
-	if (in_ras_intr && !use_baco)
+	if (need_emergency_restart)
 		goto skip_sched_resume;
 
 	/*
@@ -4460,7 +4461,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		/*unlock kfd: SRIOV would do it separately */
-		if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
+		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3a3fa8567c94..6f06e1214622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2135,3 +2135,14 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 		amdgpu_ras_reset_gpu(adev);
 	}
 }
+
+bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
+{
+	if (adev->asic_type == CHIP_VEGA20 &&
+	    adev->pm.fw_version <= 0x283400) {
+		return !(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
+				amdgpu_ras_intr_triggered();
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e7df5d8429f8..b2667342cf67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -633,4 +633,5 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
+bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
