Return-Path: <SRS0=fmWI=3S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DCCC33CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 06:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D745A20708
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 06:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LjDxIjNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D745A20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE086E1D6;
	Wed, 29 Jan 2020 06:46:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92706E1D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 06:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cprXuuNBG6tjSaNRX5yjbodA+OZnHOWWNx1lnO+y9DjGRZzPBut25yoG8/kB1jm/Qiq7mQ3gyGjrBnEMT1qE2A/0u/GiE3c5NAfig9UkcRa0FuytfCwVljBZtfqBBPA61Dj7lx0aNQ7W6IvYr3tThiJeUPU156jCwKOWLK0+FF2P1AOcoDVI4EwVfMeJwVV9fyPItDZThOKzfDm6CLGUh8tbSjcKBsS37VYdp3foL1OVyGKdFvjZ+P8ur+U6b7cRCZmJRgsQ/gbjPJ/njlkjucg9uALtuxTY70Rv1jrmMXkc+rAJMNJu9f0X7yJf8Ar/nHcoiU9rKIGM7i1JwXgamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1bJRCWNJt77ovbif6svpaPOzzRbTaxHfPRY7u6EaLw=;
 b=Y5ZFbAxWKeQna+suf3BOeqXEeEVUztuBKJeZNfN7a+iaQpGMcaovfiuBMkXHI192iDmKPBiGoQoGUZqYH5sIEFLTRSqE++9iuE4353v0qf+GW32C+XpgQr0h9kxuEs9Y1tGgGQVOMwp9jOKVP6kNEXryBBRYGW6i1OqUXTvWSUo5OwoYGYjTnUdnn/ml+/96ZMPGIrBv5f9pB5cxJ1ZY64R+FPlkx2Jszkb9XhKnUhAEB9PI91TmmfNPezu7tOpoLmzF/6gjqr40TzknO7/q1lcsAByZf1JkqCbR1SFiwUsfhg9wcmN00zNSGg4rMcvN1di7RLYSoMEEPnLJePf0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1bJRCWNJt77ovbif6svpaPOzzRbTaxHfPRY7u6EaLw=;
 b=LjDxIjNqUuhyUzGFT5F2CUKFgzpFfehn9pxNdtcJPODxbt5glOXhZmBwFy/xSf/LCLroli6GF6RtUkdAy6IPy4AgWt/wbnyMlm0Bd9NAfUxa4WbHb4s/s4vL6iEAe0mlLIVER/XMfuhnrZfjm18zEJg1KTI5mgeepKsgBy8s7Ng=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Wed, 29 Jan 2020 06:46:33 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend
 Transport; Wed, 29 Jan 2020 06:46:32 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2665.18 via Frontend Transport; Wed, 29 Jan 2020 06:46:32 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Jan
 2020 00:46:31 -0600
Received: from vbox-debug.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 29 Jan 2020 00:46:31 -0600
From: Frank.Min <Frank.Min@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move xgmi init/fini to xgmi_add/remove_device call
Date: Wed, 29 Jan 2020 14:42:49 +0800
Message-ID: <20200129064249.7108-1-Frank.Min@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(428003)(199004)(189003)(5660300002)(186003)(86362001)(6916009)(356004)(478600001)(2906002)(6666004)(426003)(2616005)(8676002)(4326008)(1076003)(36756003)(70206006)(8936002)(336012)(81156014)(81166006)(316002)(70586007)(7696005)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1248; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c592c2a7-4298-4da3-da04-08d7a486fa26
X-MS-TrafficTypeDiagnostic: MWHPR12MB1248:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1248A9448CA94EE421B49B9FE9050@MWHPR12MB1248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02973C87BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gx7PTx/Ew0Vdtj2UluPhbcixxjIuA/6F8L3MchofBDg5Jhlpy6iGTbS9RY8BmKGC6BONZB7aDXD/Jhr0tKWhOWkpeJVdh0Qirrau+5G/Z+hqVL8h5XHEuS8nduc5dMnIF1kzDYdDilkJcUdl1AQZdSAcdXCq0ddwQVfQipUVvbugXhuG4rwP57hdJ0ajC8mPFaCvRN1WPd17vfbshRfWd4Nn9gEnU5B/FJv9SHkZgMXfXDfxt7eZV727kTda9j1nSoM3FaXoiMytlNV1V5DT4/EBl/0wOpEbQTS5mdTTtAvEGExdsEcSXgt6aLQGI9kB+QsJhKTX3iraNuxRqIMRscIlLLl+9y8g5Q6yVeZQj75Uz/sKEVMJDYegYQ1ARhDT24Bw/AeY2DcLOIIfMLfLgX5OlKma/zA3/ZjX3VetqkhLutFYX9Tg+EkqXOjaiWVo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 06:46:32.5217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c592c2a7-4298-4da3-da04-08d7a486fa26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1248
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

For sriov, psp ip block has to be initialized before
ih block for the dynamic register programming interface
that needed for vf ih ring buffer. On the other hand,
current psp ip block hw_init function will initialize
xgmi session which actaully depends on interrupt to
return session context. This results an empty xgmi ta
session id and later failures on all the xgmi ta cmd
invoked from vf. xgmi ta session initialization has to
be done after ih ip block hw_init call.

to unify xgmi session init/fini for both bare-metal
sriov virtualization use scenario, move xgmi ta init
to xgmi_add_device call, and accordingly terminate xgmi
ta session in xgmi_remove_device call.

The existing suspend/resume sequence will not be changed.

Change-Id: I40776af28e45d2d5ed9f87b28983069c746f2f2e
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 18 ++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  2 +-
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3a1570dafe34..939a114605c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -558,7 +558,7 @@ int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	return psp_ta_invoke(psp, ta_cmd_id, psp->xgmi_context.session_id);
 }
 
-static int psp_xgmi_terminate(struct psp_context *psp)
+int psp_xgmi_terminate(struct psp_context *psp)
 {
 	int ret;
 
@@ -579,7 +579,7 @@ static int psp_xgmi_terminate(struct psp_context *psp)
 	return 0;
 }
 
-static int psp_xgmi_initialize(struct psp_context *psp)
+int psp_xgmi_initialize(struct psp_context *psp)
 {
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	int ret;
@@ -1420,16 +1420,6 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		return ret;
 	}
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
-		ret = psp_xgmi_initialize(psp);
-		/* Warning the XGMI seesion initialize failure
-		 * Instead of stop driver initialization
-		 */
-		if (ret)
-			dev_err(psp->adev->dev,
-				"XGMI: Failed to initialize XGMI session\n");
-	}
-
 	if (psp->adev->psp.ta_fw) {
 		ret = psp_ras_initialize(psp);
 		if (ret)
@@ -1494,10 +1484,6 @@ static int psp_hw_fini(void *handle)
 	void *tmr_buf;
 	void **pptr;
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1 &&
-	    psp->xgmi_context.initialized == 1)
-                psp_xgmi_terminate(psp);
-
 	if (psp->adev->psp.ta_fw) {
 		psp_ras_terminate(psp);
 		psp_dtm_terminate(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 611021514c52..c77e1abb538a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -362,6 +362,8 @@ int psp_gpu_reset(struct amdgpu_device *adev);
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size);
 
+int psp_xgmi_initialize(struct psp_context *psp);
+int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index a97af422575a..78989e9560d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -365,6 +365,13 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		return 0;
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+		ret = psp_xgmi_initialize(&adev->psp);
+		if (ret) {
+			dev_err(adev->dev,
+				"XGMI: Failed to initialize xgmi session\n");
+			return ret;
+		}
+
 		ret = psp_xgmi_get_hive_id(&adev->psp, &adev->gmc.xgmi.hive_id);
 		if (ret) {
 			dev_err(adev->dev,
@@ -451,7 +458,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	return ret;
 }
 
-void amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
+int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 {
 	struct amdgpu_hive_info *hive;
 
@@ -471,6 +478,8 @@ void amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 		amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
 		mutex_unlock(&hive->hive_lock);
 	}
+
+	return psp_xgmi_terminate(&adev->psp);
 }
 
 int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 74011fbc2251..c62a4acf4c14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -40,7 +40,7 @@ struct amdgpu_hive_info {
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
-void amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
+int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
 int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
