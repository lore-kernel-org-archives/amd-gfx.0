Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD8C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3571320768
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ha+ximBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3571320768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEC76E8A0;
	Wed, 12 Aug 2020 04:57:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B785D6E8A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 04:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keA8ySqKoSeujBZUhWaNKAJpUxsNrD7LQu/g16lEkhddpwekXztD/wDtohPRv2nsiAs1Q47JRQTRKlxr+JGKN1DRciMkZETC8PpiKUUZGVkzhxsEWZ7GzNfGFxh2n0PzSqd156jUV/8tt7k2FXlRFzZR4G7g/K9fIXlgjyJrNsjiX+g86RHbwPQHlhzCKY1TJFP+aV4rkq5vEGBJHxoP/fYl/ZwuS6jGmUBJNpbMESytvl6vPy1S7f+pDALdHM5kA8zNqwMeIhL+Jp33rTEzlkEjRU/xzyIsteLjjcr5mPQxhz2osj0E/n/20+3sJFSwkuzulW8ZwsGdRXlg0hqyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k/aNehzDHPRoDv4/y8mFn8LnP07KqSPjiPRkKu4j0Y=;
 b=hKauUSBXDEm3wWm6VnGZUEtlpEKSt7AlBfuPb5jJ7dXhLrPdoUzhfN7yGfqKLKUyCfI+42znBx+4oCQDJ4EuUVH+V1jYsImXOwUCGKX6ObTRPoDggUGWrc0hRyUlWctwnk1om4kOQ9tU71lUFkqKH2FXdiiEVmTZd/ezEI+XBi9IDj/kdgN+a0nr4aPzeKuEyG5ybEKF1rIqDdQyZzwPzofTh/To1LyJBjAhb5MKge/c28F4Oism87EXNpufhyF19fSWMkEyDLrXfxLpkdv7aU5ViJr82xutTM0VRB4+HCr+mKX0TGSnzEKKqUTtoHG67Ce8i2/MOUOYMa+Uql3i3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k/aNehzDHPRoDv4/y8mFn8LnP07KqSPjiPRkKu4j0Y=;
 b=Ha+ximBpeKUwZzQTeYfQtsnmswgN1J3KCAj0BxPk4WjOZqNzk1nGucjm1gTTH/zg62hcU32a2N+cPSdD+/fskQotkz61iRSL0ynD6KyOPkd0R0n/OvJEpwFeQkm7/R19a6bj9l1viH59483oxzVuHsb4ga5dZGhGWyTCyBMAnkc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.22; Wed, 12 Aug 2020 04:57:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 04:57:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/powerplay: optimize the interface for mgpu fan
 boost enablement
Date: Wed, 12 Aug 2020 12:56:44 +0800
Message-Id: <20200812045647.20541-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.2 via Frontend Transport; Wed, 12 Aug 2020 04:57:08 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ace83e99-79a2-45f9-d8fc-08d83e7c2bca
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502E9A867222A268702FFB4E4420@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3zykRNiUHICjRbQPggXcU8yCdVHTymr4cHv9a39+3mxHKn55T7oIco701MWl3jzfkrsTSeRcBs3FecvNvqm7G9gteUYNlrEmMl61H+aG91eIKQeXiUwHmaUhuXctNqtnEOfZZgY2Dhh2T3JGhEIHKjDg94QHrPKzrJ0OuSUmVJe+GOWy1R7dW8hZBJx6M7wYewflsdv4aH0BcXi1+VVyDID1QVLU6204rlCRXg7sZpOhJn3tVvD0WQNob4X4K0sZwPufxAijhRt2tf5N0DTrtg5kj2xsxfvrREIgMirDP72ZlvtrWk4f6PU7HnAfNPBOOF69jsNWrIyzIgLVybV7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(86362001)(66556008)(316002)(4326008)(1076003)(2906002)(66946007)(66476007)(5660300002)(6666004)(6486002)(8936002)(16526019)(478600001)(956004)(2616005)(8676002)(186003)(36756003)(83380400001)(6916009)(44832011)(52116002)(26005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oGQLFSmFwbRXldYKuNnwtXdjbmlFNy4i/a7VJAQXEaGPeZSk8Ho5aNJcEZQmtwAHwpnRefRcBBNGjml5+oaolMu7zK4ej2hQJ1aZbiBsRc0X5QhAPW8tM35eZmyUQ58Vce6tkR7XbWkqFvBOLMWeILB/r7SkdugPl5Gcwj+fGa9118G+zwXoN360xp37figtamPs60kLoEfPfXFmmv8Jj3aggxxG5+TO5U9kev+YD4StA7GYlDHyFcWOJqNh/LT3XhQiAdEyTYQ/E1qLRmOJpp79Hyon9qFIJVClB0cNTCkxrY9KUVZfN3KwJ2Y9kKHdqAYMHgzLZIKmOUwOrWn4yOJSvBEaiUixp9oWb7xbe9tRZCwx/Q5Lcjzvqv0OIzEgLvwEg9aMAWC76O8K+2p7gXILLHvMaAPrPQDt154vvKwixQG5fYp97Gz6iNilSuxmCXXwKKxUIKBlrDNzQXgDfdL8AvNF4ejwBJZoyCIE+Lmd04OwMXOAeTFmEPe0bc8J3+Uyp5G0Spuknvuf8FJNSorz7wWSvDNatqqBc4yq6mjU71Er+sVqvQK0HwEWUqjYBbgH23stpkNThkyulV3NS3aTu0o1tptN47ugkyA9xORqnVp4JJTMIgig8vxQFqbY1bBuAp/TsQReNxsJRxn9+g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace83e99-79a2-45f9-d8fc-08d83e7c2bca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 04:57:10.9942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gKlvqwH8LrU8B2zAWxWLtly0Fn59ZAqEB6Q6EHMtTxuFxVw63Vf/jq+jTjxG1CB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cover the implementation details from outside(of power). Also preparing
for expanding this to swSMU.

Change-Id: I60072318d18926d196095123638d263bd4534b52
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h    |  6 ++----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe8878761c29..bb7f0c8611f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2228,9 +2228,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(void)
 		gpu_ins = &(mgpu_info.gpu_ins[i]);
 		adev = gpu_ins->adev;
 		if (!(adev->flags & AMD_IS_APU) &&
-		    !gpu_ins->mgpu_fan_enabled &&
-		    adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->enable_mgpu_fan_boost) {
+		    !gpu_ins->mgpu_fan_enabled) {
 			ret = amdgpu_dpm_enable_mgpu_fan_boost(adev);
 			if (ret)
 				break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index d008ca95130c..9d80cdaf83f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1216,3 +1216,16 @@ int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en)
 
 	return 0;
 }
+
+int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
+{
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs =
+			adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost)
+		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index b190c0af7db1..cc16b5a3ac44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -357,10 +357,6 @@ enum amdgpu_pcie_gen {
 		((adev)->powerplay.pp_funcs->odn_edit_dpm_table(\
 			(adev)->powerplay.pp_handle, type, parameter, size))
 
-#define amdgpu_dpm_enable_mgpu_fan_boost(adev) \
-		((adev)->powerplay.pp_funcs->enable_mgpu_fan_boost(\
-			(adev)->powerplay.pp_handle))
-
 #define amdgpu_dpm_get_ppfeature_status(adev, buf) \
 		((adev)->powerplay.pp_funcs->get_ppfeature_status(\
 			(adev)->powerplay.pp_handle, (buf)))
@@ -548,4 +544,6 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 
 int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en);
 
+int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev);
+
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
