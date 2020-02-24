Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936DCC35679
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 09:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6577620714
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 09:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d8dkd5Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6577620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1076E2CC;
	Mon, 24 Feb 2020 09:26:27 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CCE6E2CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 09:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvAkVZ8YVfXuE4ghSfMN2LLBokluSEZoCE1OilWObJWRKlTwWwqughCVrWwx43H0yDm2+t19KVqVTOZ+HziCtcWHA3WFmLweP2c5FjwdW5koKJWUj49BNFtM3c/eSrlO0LJE7evutQ32s68FW1VAzhLbuWc46wKLIKEMYG5wHctgEetosKFr5x7xbWcZOvrZ+FCjTtAcEpm45iDWAD8LHlygaQcI2+D5WGCpDLhZ4k1VQU6I+QcPXUtF55T9OhkKLN55zUY2xXweFItltbGYhQAy4gxh8aQIYmJyCpoKijY9/WeSpUzkA9kgQCvRvCrLnGcc/72nQVxOeb2WtxCMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr+LXnumiP9/sPE5+9sksrto0QSsMcKVmOsot97xNGQ=;
 b=Xfy2P6qL3fYS0oT0RraPYbEutU9e7wN3ye6NwqodMDjuopLlx++HfOq0HFTUWP+HHVTdAWWCWWdG0aNa2RbVnjlPHWjwPrZhd8ZYAE2z2+s1Rr92DTWr0xBRW/Ih6WaDjHsxLb+bxrB8gWBmcn3R7XqFcCeiIQye64pl74h1y4zwQa4zMgzqdELQ6wCTKKfTqyps69pD3SSOFLFrxxHfFGk+rywB1AA2A0sRPkzdNJWsvTArLtbW+Qs/8kZKnQE0VsNVne5FfyFUTZeVkk8Xbv/5L6DrbpShK0NTY0T7C1PvA8xL8WfA7fFlC5wAseAIdYAdQwam9ny3AWD1nvDrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr+LXnumiP9/sPE5+9sksrto0QSsMcKVmOsot97xNGQ=;
 b=d8dkd5CsBq3yk4rxGugAylFzoiJl6zcSwpcivgHn1UKmg8dxU373M84LZGlBaRZ98UU+vSEcNObgpoAISJHhKVbYU3FZZ+HoEapuWVQ0mTMvr9xaKT0Q36ZqsWMmZ/Q+w4CH0FIIJEWdtjaudUedq2ZrFS8GxKg3cmmFZux7mNQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3855.namprd12.prod.outlook.com (2603:10b6:208:167::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 09:26:23 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 09:26:23 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Date: Mon, 24 Feb 2020 17:24:17 +0800
Message-Id: <20200224092417.7589-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 09:26:20 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c62a162-fc71-4f24-f3b6-08d7b90b9ce4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3855:|MN2PR12MB3855:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB385575A633661268AAA66037E4EC0@MN2PR12MB3855.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(956004)(4326008)(8936002)(26005)(44832011)(81166006)(2906002)(2616005)(81156014)(8676002)(15650500001)(478600001)(66476007)(316002)(66556008)(16526019)(52116002)(6916009)(6486002)(36756003)(6666004)(7696005)(66946007)(186003)(5660300002)(1076003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3855;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oF4RJrzfGWeSteECYXKzl6vzfhUBznxB4sJ75gdq7RG2Eor0kJOPaBaYtJufZZefgFRvJYKqABd+Ud0T0vZ1IrWvR8871kf2d0J1FK4Ld0kV03/Kr5xhcdYr+/0uVRhHIWw8gJzG0jCUIpy4S/paNOUHzDBjc2MLM2tvFXKU2Bv1a0TCQc6DC9LdgDJJGC/XyFy6uyz4rflKejC7Vil0+N1pnaJnsjAONvpbEDSG/48VYkWBGCsBzOpu5y/hiUmZjYGEuaCj3R7T0OAsBkgwKQ0upt2pZSUR9vfTjWocnxudeVU5H8g0IToIxaZxUdcAXycuNPAIIKrhmvmGim9CyfXuHcRtrS3XAy91q12neW+KLLfrmR78P9TmUWCDCHzo9L/Inw017g7SKHGD2ziWJKXCQ8mxlaLvNddygam3SrnYe+oQQnrLedWdccRF+Fdz
X-MS-Exchange-AntiSpam-MessageData: fPParD2csoihPDE7nMga8VvvHmEYZgneYxXMykmdMSLIXvQlAiJrt95AvNs5YdH0/n+hVEOHstSYoREG/LWDQOcE2bYI6PVzMRLlzqDaUdvfmCSDwtSfqdcQZqNQDmmGJluqWp69n1Fn1LXZ0I1b+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c62a162-fc71-4f24-f3b6-08d7b90b9ce4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 09:26:23.2928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Pm2J7/NJ98XC/5sKu+v2bGzpM5EYK+Zn5YcA43QoH3xlJmp1Zgk5BGu1+0/CMF9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3855
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
Cc: Evan Quan <evan.quan@amd.com>, kenneth.feng@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For those ASICs with DF Cstate management centralized to PMFW,
TMR setup should be performed between pmfw loading and other
non-psp firmwares loading.

Change-Id: I8986ddb4d9ffe63ed0823d1dce8d9d52812a1240
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 61 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51839ab02b84..ef800ad68e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,6 +38,39 @@
 
 static void psp_set_funcs(struct amdgpu_device *adev);
 
+/*
+ * Due to DF Cstate management centralized to PMFW, the firmware
+ * loading sequence will be updated as below:
+ *   - Load KDB
+ *   - Load SYS_DRV
+ *   - Load tOS
+ *   - Load PMFW
+ *   - Setup TMR
+ *   - Load other non-psp fw
+ *   - Load ASD
+ *   - Load XGMI/RAS/HDCP/DTM TA if any
+ *
+ * This new sequence is required for
+ *   - Arcturus
+ *   - Navi12 and onwards
+ */
+static void psp_check_pmfw_centralized_cstate_management(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	psp->pmfw_centralized_cstate_management = false;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type >= CHIP_NAVI12))
+		psp->pmfw_centralized_cstate_management = true;
+}
+
 static int psp_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -75,6 +108,8 @@ static int psp_early_init(void *handle)
 
 	psp->adev = adev;
 
+	psp_check_pmfw_centralized_cstate_management(psp);
+
 	return 0;
 }
 
@@ -1116,10 +1151,17 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_tmr_load(psp);
-	if (ret) {
-		DRM_ERROR("PSP load tmr failed!\n");
-		return ret;
+	/*
+	 * For those ASICs with DF Cstate management centralized
+	 * to PMFW, TMR setup should be performed after PMFW
+	 * loaded and before other non-psp firmware loaded.
+	 */
+	if (!psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1316,7 +1358,8 @@ static int psp_np_fw_load(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_device* adev = psp->adev;
 
-	if (psp->autoload_supported) {
+	if (psp->autoload_supported ||
+	    psp->pmfw_centralized_cstate_management) {
 		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 		if (!ucode->fw || amdgpu_sriov_vf(adev))
 			goto out;
@@ -1326,6 +1369,14 @@ static int psp_np_fw_load(struct psp_context *psp)
 			return ret;
 	}
 
+	if (psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
+	}
+
 out:
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c77e1abb538a..37fa184f27f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -264,6 +264,8 @@ struct psp_context
 	atomic_t			fence_value;
 	/* flag to mark whether gfx fw autoload is supported or not */
 	bool				autoload_supported;
+	/* flag to mark whether df cstate management centralized to PMFW */
+	bool				pmfw_centralized_cstate_management;
 
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
