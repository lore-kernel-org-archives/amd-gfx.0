Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D7C3F68F
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 09:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0182192A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 09:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jpm4xUH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0182192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AD86F4DF;
	Wed,  5 Feb 2020 09:18:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770079.outbound.protection.outlook.com [40.107.77.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFE06F4DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 09:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFA6f7T+9tRuMAOMeZKNK/Top8kcQNetsBsHB+0SloOhU5tZHYzHhYo5DfUHA4KIt1T32knOm6SVvM9KTM1APNhUbJss6d8Vl6gBoI35WToehZR0V1w+KyhJntMtzU50St6qSJBUefotHi7OK9++7N/eniGyD6MKbLfY2KE919BZLcuuwo+FTnJ1wWMdsMlfhldAvcEPTS7VGRmOLfe6jgB1zEMboXyjhtTQy4ZC8l6bMml6ZPct88GXWJkATE/1m68AYNPLlFHwTGu6LAz25esKjSI8cC1turTa58Kp3jmWWY/4yJ47pdX2/iI52Hpv50YOiElPwJhelOSIh2nKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9Yc0Cvj5qD5eOELuoMIEI5b8u455n2XZxurmTf79Uw=;
 b=jPT9IrSC6E9EStsAf4eM2q+QjSQ+m/bqoZCi25DdMGa2/LMDCZaVk/V4GTNyUVYh0t/aJWtz9Mx30Pumz0uCkv71NC41LIyGDcBML56dNGvuhWJ/EhniNwbhYyxasrUTTne1h9g8Oa6uytlfBUJZAq9NrTqEMQz6mRYFb0iTHNJ6/rt/h2DF3OFn8G4YgWlPBq6eE/y/F79Iu8LL+InX4VzBOd3SxKg7Xbs1QB6Y1BhdW656JS6qwxAyzOwyj/9f4vdUGZGwZjAcPsru9/o3pmzo5zxSAIbBGbGODR45/Y9xN0kUsuVCt44dbD51XRJgX4pvMuVcZhPMjj8/vRJkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9Yc0Cvj5qD5eOELuoMIEI5b8u455n2XZxurmTf79Uw=;
 b=Jpm4xUH5WmK6NUxg0g2EtCVqOTbftptOwGMZ1tOK3cNHGGG2hpq5yXkIXldL+IOLdfpe5QbNBGw/k9f3YeSMNMS6MWQtE7pDOUNWSzh4gGFzDdtAT1FKc6EiFLQ5njHZurV3VifowPufM8XFkqmj+xyGlpB1FCzYHcwyZ7XncoA=
Received: from DM3PR12CA0122.namprd12.prod.outlook.com (2603:10b6:0:51::18) by
 BY5PR12MB3651.namprd12.prod.outlook.com (2603:10b6:a03:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Wed, 5 Feb
 2020 09:18:20 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM3PR12CA0122.outlook.office365.com
 (2603:10b6:0:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Wed, 5 Feb 2020 09:18:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Wed, 5 Feb 2020 09:18:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Feb 2020
 03:18:19 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Feb 2020
 03:18:18 -0600
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Feb 2020 03:18:18 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov Don't send msg when smu suspend
Date: Wed, 5 Feb 2020 17:18:14 +0800
Message-ID: <1580894294-3573-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(428003)(199004)(189003)(7696005)(316002)(36756003)(478600001)(70206006)(5660300002)(70586007)(6916009)(186003)(336012)(6666004)(426003)(356004)(15650500001)(26005)(8676002)(2616005)(86362001)(81156014)(81166006)(4326008)(2906002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3651; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84250636-c085-4bcb-1cc8-08d7aa1c575e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3651:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3651071692E2C80088776E25BB020@BY5PR12MB3651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0304E36CA3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOMjE64GUawcDwiXo8aMgYWYL3Lxv3F6V7zeYjElrBrzcRCR9cnLXeDLlfgaVAtLkEL/VYQ7U8p5X9UzunmgX2VUTZrWO3eZRhZDbw1g4UhFTPHiX68Cp2ArJdGepj2Em99PUx2uWVb3+6iuQLj4UovvURunHhywjOscGn3vBUhoeAhkWnp5LQcUvHwYhAxWLIOnxMkUTEDMk0Nmjz7B20/2CAru5+0vrTsEo9T/MCkm5g0hN5NFUWdzM1c3c45VF9zjZln+bHms+Gpd8ncDe6WJHAlYM8vgAF3KuuBzrsLI8TAYdC9Qhs2OIdnGFI7K8J23H2pcqgGT+YoEfkjgH/K7THohkOYNl7qGaBP3q6EbO+xsKtusySF1tP/6UCRMVevSl6icFv3udv3qsv0xgVm7h9WAYugZvcJyvnVdiB6Jw/4gPgGeSInlXNEulP4L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 09:18:19.6635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84250636-c085-4bcb-1cc8-08d7aa1c575e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3651
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sriov and pp_onevf_mode, do not send message to set smu
status, becasue smu doesn't support these messages under VF.

Besides, it should skip smu_suspend when pp_onevf_mode is disabled.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++-------
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 21 +++++++++++++--------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4ff7ce3..2d1f8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2353,15 +2353,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
-			r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
-			if (r) {
-				DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
-					  adev->mp1_state, r);
-				return r;
+		if(!amdgpu_sriov_vf(adev)){
+			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
+				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
+				if (r) {
+					DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
+							adev->mp1_state, r);
+					return r;
+				}
 			}
 		}
-
 		adev->ip_blocks[i].status.hw = false;
 	}
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 99ad4dd..a6d7b5f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1461,21 +1461,26 @@ static int smu_suspend(void *handle)
 	struct smu_context *smu = &adev->smu;
 	bool baco_feature_is_enabled = false;
 
+	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (!smu->pm_enabled)
 		return 0;
 
 	if(!smu->is_apu)
 		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
 
-	ret = smu_system_features_control(smu, false);
-	if (ret)
-		return ret;
-
-	if (baco_feature_is_enabled) {
-		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
-		if (ret) {
-			pr_warn("set BACO feature enabled failed, return %d\n", ret);
+	if(!amdgpu_sriov_vf(adev)) {
+		ret = smu_system_features_control(smu, false);
+		if (ret)
 			return ret;
+
+		if (baco_feature_is_enabled) {
+			ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
+			if (ret) {
+				pr_warn("set BACO feature enabled failed, return %d\n", ret);
+				return ret;
+			}
 		}
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
