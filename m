Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E9C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803FB2081E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wCP9Zo+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803FB2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FED56E8B9;
	Wed, 15 Jan 2020 09:21:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2784C6E8B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCWNcbCfTTFjzy8qoxlp3or3SXcxpnB1Y+Sz2OkY6JkOAbk6nCe4WcXJvA/8GEwGtrQmvKl2I71F4eF3C7cILZAyWQNWcRbUFV6ymcCJxcufkt83id/zyIPhyuhBL4LmzhPf3t5AAjXNrJQM2YQda/tfAkcs5sKxzHY2IZC3H3yoer8Vgi1Mz+bfS+GDhEl45rzd180VQyOXh7xqrWiJkJUZLHDD0T3VZocZM+6L7d+HYN2ulSHXOJbtiC1FJGy5j0FpuEA8Yn+r0PXF3oQ1pXOOdN7pHl2fFACfHg2Irj7uFd3nNZ3r6Oldl5ter9lbuGbT568foJKpG7kNVLAt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqUiSyenykQYkYutzY5NbDgeAjP+5PpidRwVPS2TlhA=;
 b=UuvbeoezJrJRQC0axsW0aQ2MlhgsIYQmHwYfhsYbPhQ7d58IBozU59luRkbEXXFbtCjXLlFN7+f+g961bHxgZVX1BnELcmzBEy4uz2BwhY656UgKzMe+dz/ztwxfsRvq4vFUCXwW0IkkKjvfTUE9rgsjGjwQleEOz2HAGemnrl6rLCr0QpDE4MTkdagjr3s2gRQs+RNd7NMB9JQLjfSMY+KIBlSMUZpWAnHTfLrel7N1MR5WbaQtVwYNoZJZZNK/dCSrLjyKK2l8HSe84IuVvKOfjV9Z30ydNnqgHCrpBxXn6ImWwOQiThbxxPMwHZbH1BZjSAT0S1mveHMPRl01Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqUiSyenykQYkYutzY5NbDgeAjP+5PpidRwVPS2TlhA=;
 b=wCP9Zo+rP8t8516mhU83GDmHImVRa1HW3Vfsm3yEzNrD9yHbi9I1OFzqKTcLQot+j3vjQ16sFjWk/kK4w+ffO7HQpFDromsycuBr5VPtIFUdGVZjHJdE7mjAvcALqFMP5Ar+GXp5EiITKsUfCG109wT7NkkYaqTEaAgwU5OAGUs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3807.namprd12.prod.outlook.com (10.255.238.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Wed, 15 Jan 2020 09:21:16 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 09:21:16 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: a quick fix for the deadlock issue below
Date: Wed, 15 Jan 2020 17:20:54 +0800
Message-Id: <20200115092054.13453-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HK2PR02CA0165.apcprd02.prod.outlook.com
 (2603:1096:201:1f::25) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0165.apcprd02.prod.outlook.com (2603:1096:201:1f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10 via Frontend Transport; Wed, 15 Jan 2020 09:21:14 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48bfdc27-9080-46f1-e3d2-08d7999c4584
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:|MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807CCEA2A3307AEC2F2B02DE4370@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(478600001)(52116002)(2616005)(7696005)(956004)(6666004)(81156014)(186003)(26005)(8676002)(16526019)(81166006)(36756003)(316002)(66946007)(86362001)(5660300002)(66556008)(2906002)(1076003)(8936002)(6916009)(6486002)(44832011)(4326008)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3807;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vdb73qeNbWihVGZqOqFkRfFNb+eAASLzLvhWAVntGKMbVI9l8swD/Oe1A5AF9HTQ/daratNGV7tLbvKVD2bW2lXxyid/Wi4FRvkBGyIw38wZRz9VhjpyCepLOVMii1xwmKQXEEotYXr2N18NapkD3yVTuycxpdW2PKm/AJ7NIwQ//O7Qf86j+hNbuKSi6BxJAcKQ5NxZYY6h9cL/bNZLVQvCWkqFxW7xVjad3V26dzjezf9/f6BAPTnD25eU33gHLGfszno1rB9U0F3EbLTQARj8bbAAzOL37Q0Fi9rhU3xbZRHtjeB5vIuakn0nYXHe000gEE/thBFfNzGaLMzOhogQVOcqYZGOzysToXM5HzZiVgjOgjKIwYVvnh6/k/JQ35z+hBviw4Bg7lJ9V2/mTyymh5vMr6H3bxtePNaB9JehobL2NiH8STClmtH3NGsR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bfdc27-9080-46f1-e3d2-08d7999c4584
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 09:21:16.2046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3ChNWukOmBBWyNBUrV5Sa40muiLaedAHQQ6myxL806BWsVeXnsfZ+8n4FBnAAl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Evan Quan <evan.quan@amd.com>, Rui.Teng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

NFO: task ocltst:2028 blocked for more than 120 seconds.
     Tainted: G           OE     5.0.0-37-generic #40~18.04.1-Ubuntu
echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
cltst          D    0  2028   2026 0x00000000
all Trace:
__schedule+0x2c0/0x870
schedule+0x2c/0x70
schedule_preempt_disabled+0xe/0x10
__mutex_lock.isra.9+0x26d/0x4e0
__mutex_lock_slowpath+0x13/0x20
? __mutex_lock_slowpath+0x13/0x20
mutex_lock+0x2f/0x40
amdgpu_dpm_set_powergating_by_smu+0x64/0xe0 [amdgpu]
gfx_v8_0_enable_gfx_static_mg_power_gating+0x3c/0x70 [amdgpu]
gfx_v8_0_set_powergating_state+0x66/0x260 [amdgpu]
amdgpu_device_ip_set_powergating_state+0x62/0xb0 [amdgpu]
pp_dpm_force_performance_level+0xe7/0x100 [amdgpu]
amdgpu_set_dpm_forced_performance_level+0x129/0x330 [amdgpu]

This was introduced by "drm/amd/powerplay: cleanup the interfaces for
powergate setting through SMU".

Change-Id: I6ae2ed89d40a9475ae37b58e22108f4d6da974bb
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Rui Teng <Rui.Teng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 40 +++++++++++++++----------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index 6c7dca1da992..19a042cf673c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -946,23 +946,36 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	bool swsmu = is_support_sw_smu(adev);
 
 	switch (block_type) {
-	case AMD_IP_BLOCK_TYPE_GFX:
 	case AMD_IP_BLOCK_TYPE_UVD:
-	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_VCE:
-	case AMD_IP_BLOCK_TYPE_SDMA:
 		if (swsmu) {
 			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		} else {
-			if (adev->powerplay.pp_funcs &&
-			    adev->powerplay.pp_funcs->set_powergating_by_smu) {
-				mutex_lock(&adev->pm.mutex);
-				ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
-					(adev)->powerplay.pp_handle, block_type, gate));
-				mutex_unlock(&adev->pm.mutex);
-			}
+		} else if (adev->powerplay.pp_funcs &&
+			   adev->powerplay.pp_funcs->set_powergating_by_smu) {
+			/*
+			 * TODO: need a better lock mechanism
+			 *
+			 * Here adev->pm.mutex lock protection is enforced on
+			 * UVD and VCE cases only. Since for other cases, there
+			 * may be already lock protection in amdgpu_pm.c.
+			 * This is a quick fix for the deadlock issue.
+			 */
+			mutex_lock(&adev->pm.mutex);
+			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+				(adev)->powerplay.pp_handle, block_type, gate));
+			mutex_unlock(&adev->pm.mutex);
 		}
 		break;
+	case AMD_IP_BLOCK_TYPE_GFX:
+	case AMD_IP_BLOCK_TYPE_VCN:
+	case AMD_IP_BLOCK_TYPE_SDMA:
+		if (swsmu)
+			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
+		else if (adev->powerplay.pp_funcs &&
+			 adev->powerplay.pp_funcs->set_powergating_by_smu)
+			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+				(adev)->powerplay.pp_handle, block_type, gate));
+		break;
 	case AMD_IP_BLOCK_TYPE_JPEG:
 		if (swsmu)
 			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
@@ -970,12 +983,9 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
 		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->set_powergating_by_smu) {
-			mutex_lock(&adev->pm.mutex);
+		    adev->powerplay.pp_funcs->set_powergating_by_smu)
 			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
-			mutex_unlock(&adev->pm.mutex);
-		}
 		break;
 	default:
 		break;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
