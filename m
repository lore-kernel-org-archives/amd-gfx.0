Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4951C3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CA520732
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fWXYB9Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CA520732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739986E424;
	Mon, 24 Feb 2020 10:36:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361396E424
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+T9Y49q8+tJG6sJyuI2mt/b+X1h8cbSvHiJYK7vJzz7Ewn9zWFwQG8Oy1pvpJ2ZALaD2fPR0S9Fscs0rIgjoSxxOE/fuQYqs9SMVFEs7UcjwCvPhRrczKP7vSkqbo04rRO4rODGORmJxC9aOBK0r8X3pdPpQtGObRJTw37QAPTlxCIicApqognPK7n/1/ir4n1xDNcilaA2Qg9/LRicIKd9w2jwkvSU7Xf/yNelpFJCibw+nBrSf7/Xznx/BZzrI5/14kY6LKWH46FygvgYEP3y3/5R3hEzYReD3RJQ66/v3tBx4fitg811OYqTQJZr46lEiGsbUnCpPanraaxxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek7MQ6spuz4GFALi4qjX8tbEYgNYof4Gr2+/j6sYg5w=;
 b=T+b17N53OinuXcC9/9XbUZ3wjlrHFFNi1lRz2xJPilRlR/Rimn2L/E63ZIpH1mWEuaxAAICw7IORfyXWJqt5gq7/HUBBOcBcBfqvuwRqQRM5TLvhkecDD8WYs4o4sggOATcrIf2TXksMK8zseIAEDqXmkF0p+AB3yetmcq4ROZWwybzWIQAWQfAfhvgEotM2KI5YpugZecUkW2oG5P8OxPFyMIjj69itWyg0S6bYCd/RDWC6LRhi/ACK89jKlf/MyjetEjS5uTSWPDmpJQMzBgKPPgCU5Yh7KdvXIcbUeTDJfmtOiu0l+slLInYQhIqClU/cF6hNt2dT9Xvroth3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek7MQ6spuz4GFALi4qjX8tbEYgNYof4Gr2+/j6sYg5w=;
 b=fWXYB9AiFu9N4A67ZLHqjJb2/WKA1JFTd65pVD1Ab31BdyjxkIBZjr6o5EKnUSEP9zjAA7V/n2Q0gB9C5+srRq9ZV6Hi5I9eky98yIqgVxXdoOcm+wxmYZJVOX3mE1vnD8kCAie6LyJVLK8sECa7W5QxClflcdCMPUoEd8wPt/U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 10:36:50 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:36:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2
Date: Mon, 24 Feb 2020 18:36:29 +0800
Message-Id: <20200224103629.9344-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0197.apcprd02.prod.outlook.com (2603:1096:201:21::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 10:36:48 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63ae748d-e364-4b77-c38b-08d7b915749d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:|MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174FD6CC1B4EFB59E030293E4EC0@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(316002)(6916009)(52116002)(7696005)(2616005)(956004)(26005)(44832011)(8676002)(81156014)(81166006)(8936002)(4326008)(1076003)(36756003)(15650500001)(6486002)(5660300002)(186003)(478600001)(86362001)(6666004)(66556008)(2906002)(16526019)(66476007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4174;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1wd1qVDaVn2RhpAxsXVHs8H3HwrwYlfAc0fQa2v8M5MCWjDOY2HZPoZ3AP9T7/hvp71cCnVbanpQWps8V1DdSAD8VVkahS+jMd/2KQKCIIJbaYVcQ8C0Ve4NBdO2+Ch91CJPQ1p0QfHXRxeOkmBIEQBh9JnaLcsWsC/VeR9Bwolb7apK3bvWHoS+TOUXCfSaTsTVgdrsaJoXbKg7Jaxnfe8RpcNaoUM79vAP1fFjsiU4hxqP2/F5TZPjowpF2FXnsuMo1WtU0tM7tLrioIeckj9T5AGz0qV60NhcK1/oz2SQ/qd2IceTO8uZFuLYdHAnEmS3o0hChO4JvyQaRBHtCRQeDzFLUZwFKhe24iUBezyOA18Q8/6q1Y1+3c9rnNF3aae6QeQIOjvqNFc+hapGKihaiLWO6THDSB9DxmPiz6UmgxsXj9hgGAXfh+1/ia+
X-MS-Exchange-AntiSpam-MessageData: XfCQ2HBABjH0ZbWvJncd5he0y5TM9w34d2quab2M6tlFvrF5BDoqshtSbe2z8bx+EcQooMRSr1P8S7q4qILv61cQY4THY/y0ovYwvMI140jwksyMN1WONWJu0FZvFk5WEbapEiDvjML32Mt4u4c/EA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ae748d-e364-4b77-c38b-08d7b915749d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 10:36:50.0171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 676FqjfTjhDCKiqV2oAHgxqeR4JDYXSI4AAa7PF++ZYtE465Ctt2n/3GMvJrf2mP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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

V2: skip possible SMU firmware reloading

Change-Id: I8986ddb4d9ffe63ed0823d1dce8d9d52812a1240
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 65 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51839ab02b84..d33f74100094 100644
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
@@ -1333,7 +1384,9 @@ static int psp_np_fw_load(struct psp_context *psp)
 			continue;
 
 		if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
-		    (psp_smu_reload_quirk(psp) || psp->autoload_supported))
+		    (psp_smu_reload_quirk(psp) ||
+		     psp->autoload_supported ||
+		     psp->pmfw_centralized_cstate_management))
 			continue;
 
 		if (amdgpu_sriov_vf(adev) &&
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
