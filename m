Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F0C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 17:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6982E24655
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 17:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kl05c/fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6982E24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8556E1B9;
	Tue, 17 Dec 2019 17:29:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4156E1BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 17:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQvXHvLRqdE2KPfcLOOJIjxjOh6OzsIBaKfB33RvpPLUsQk9e7tgo48HzNWSFR/s/Gi+NzL87Cf6Du8N7JToE2HutjuVU/fYbGiBAwHrM8hz1PV0OndrApw0D0vZRygPehi18qJdJvZNikp64ZIFMaeQgBEC7kXISXltdXSz45N4S8Uovtm/r9mZ2Vg5cJ8OrH7+q8YBPijmO2Hxsx9Qk1ZHYbPRsYq+k4OLor53gKfUQCAlT2wp/9U95phqHdjyLCCFLPGL+2Me99zsQiQdRMHJQqixc6xBTiLwpVEDQhWoI/bvaMxPhw2pUzwcbeA2ODj+fWDl2gWkn1K4WFMt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLmWbc2UVGDZDIkPwVb2tlusjuJ0PjiUAppV0SY/gC4=;
 b=WZ256n2NWu5DlFOP1pJynu6eI3k507DEYZm8BJeR8XhIt4CmKheyAhkxji4PN/lKV1B64tPWZy8fEfivexoc3sbbF+TnZkpb3v2hEgQtoYOle2wGhJBFP323gq90+7gBC8jHmkutATT7txpbujcUEzHVYUMn0UJD9yR+2KK/cWw+dDEPrNODW5m4YaLISski6KvovbKwwyT/GD0befcD8pQGy8YFpNntS/ALN3V08YPXZxzUprflERC3vtVmn+YLd1H9tqsgciCzkgkoB1szS3CjH+CIeJlIGOg7SGltW0h1lQSG9TXkN7h3y1hMMV2VPaSvzgdGMCOoiVUwj7R09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLmWbc2UVGDZDIkPwVb2tlusjuJ0PjiUAppV0SY/gC4=;
 b=Kl05c/fZ2qQ1VzTR7ovOEWn4219KqvchNhEkDtxGWqUUvWI30w5XzWElIT31/KVvJ39cfJlmFUWXkCMOwVxDmzca6gdNZGLuTC25z+T+MgIlgzOyRbHb+eZ28LuhjUigcsCeCdRlbC+4kirao8BkJoTCyMYxZvGedxiTH6gUWHg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
Received: from CH2PR12MB3831.namprd12.prod.outlook.com (52.132.245.141) by
 CH2PR12MB4296.namprd12.prod.outlook.com (20.180.16.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 17:28:59 +0000
Received: from CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::adcc:f57d:89f5:279f]) by CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::adcc:f57d:89f5:279f%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 17:28:59 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: attempt xgmi perfmon re-arm on failed arm
Date: Tue, 17 Dec 2019 12:28:12 -0500
Message-Id: <20191217172812.128736-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217172812.128736-1-jonathan.kim@amd.com>
References: <20191217172812.128736-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::45) To CH2PR12MB3831.namprd12.prod.outlook.com
 (2603:10b6:610:29::13)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3a7d48b-57dc-419e-e411-08d7831699cd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4296:|CH2PR12MB4296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4296C88942F0A096896624F785500@CH2PR12MB4296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(199004)(189003)(4326008)(6506007)(52116002)(66476007)(36756003)(478600001)(1076003)(6512007)(6486002)(186003)(2906002)(44832011)(2616005)(81156014)(81166006)(8676002)(8936002)(5660300002)(316002)(6666004)(66946007)(66556008)(54906003)(86362001)(26005)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4296;
 H:CH2PR12MB3831.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMolUVWaucYUgCO9lZKa1il9PulFW2OWbZLoyq5jFrkarfktqC2XKz0Hvye6tTocGBOR5Ghyt5FHsDdHBB8Hgw5CL5XnR+S8JcCnfMNtzAUFUAl6V53B7WlBagLQmVn7JAorgUj+UhNOTC+3dKsXPVHeFWf9BVfxU4eluYVHCY/sAASHy9j+Pr5+NAXufHX3cQTmpWm89zfPFbAujvhklI5TAkHzqjIpzQoy1RH8JKwQ+PZwjQ9cdQlgNoekzubb4XU6kSO8yBjkIbxxEK2pD+TdRyzcUZI8i2gpyPI4WkdNfaFtHmAMfD8Ognkel2fD2+THshZMUUN892n+lXMX2CMy5BUuiLycLG48tphPnT9foRci75RS6fz+MtmUPZS8fgLIc7YU1BE7ZQl3i1q4DQ6bZcR3ckKCI9Jc6kwDVZc+jK+Z/e0b1jbC/I/EXbeZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a7d48b-57dc-419e-e411-08d7831699cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 17:28:59.1349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBjO+k1Am5m24orIZnQzyb2GaqSGIE9RQwHgomZbsLWHoFmfy4j1hYySEGTpbHhC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The DF routines to arm xGMI performance will attempt to re-arm both on
performance monitoring start and read on initial failure to arm.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 153 ++++++++++++++++++++-------
 1 file changed, 117 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 4043ebcea5de..af445054305f 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -162,25 +162,45 @@ static void df_v3_6_perfmon_rreg(struct amdgpu_device *adev,
 }
 
 /*
- * df_v3_6_perfmon_wreg - write to perfmon lo and hi
- *
- * required to be atomic.  no mmio method provided so subsequent reads after
- * data writes cannot occur to preserve data fabrics finite state machine.
+ * retry arming counters every 100 usecs within 1 millisecond interval.
+ * if retry fails after time out, return error.
  */
-static void df_v3_6_perfmon_wreg(struct amdgpu_device *adev, uint32_t lo_addr,
-			    uint32_t lo_val, uint32_t hi_addr, uint32_t hi_val)
+#define ARM_RETRY_USEC_TIMEOUT	1000
+#define ARM_RETRY_USEC_INTERVAL	100
+static int df_v3_6_perfmon_arm_with_retry(struct amdgpu_device *adev,
+					  uint32_t lo_addr, uint32_t lo_val,
+					  uint32_t hi_addr, uint32_t  hi_val)
 {
 	unsigned long flags, address, data;
+	uint32_t lo_val_rb, hi_val_rb;
+	int countdown = ARM_RETRY_USEC_TIMEOUT;
 
 	address = adev->nbio.funcs->get_pcie_index_offset(adev);
 	data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
 	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	WREG32(address, lo_addr);
-	WREG32(data, lo_val);
-	WREG32(address, hi_addr);
-	WREG32(data, hi_val);
+
+	while (countdown) {
+		WREG32(address, lo_addr);
+		WREG32(data, lo_val);
+		WREG32(address, hi_addr);
+		WREG32(data, hi_val);
+
+		WREG32(address, lo_addr);
+		lo_val_rb = RREG32(data);
+		WREG32(address, hi_addr);
+		hi_val_rb = RREG32(data);
+
+		if (lo_val == lo_val_rb && hi_val == hi_val_rb)
+			break;
+
+		countdown -= ARM_RETRY_USEC_INTERVAL;
+		udelay(ARM_RETRY_USEC_INTERVAL);
+	}
+
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	return countdown > 0 ? 0 : -ETIME;
 }
 
 /* get the number of df counters available */
@@ -334,20 +354,20 @@ static void df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
 	switch (target_cntr) {
 
 	case 0:
-		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo0 : smnPerfMonCtrLo0;
-		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi0 : smnPerfMonCtrHi0;
+		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo4 : smnPerfMonCtrLo4;
+		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi4 : smnPerfMonCtrHi4;
 		break;
 	case 1:
-		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo1 : smnPerfMonCtrLo1;
-		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi1 : smnPerfMonCtrHi1;
+		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo5 : smnPerfMonCtrLo5;
+		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi5 : smnPerfMonCtrHi5;
 		break;
 	case 2:
-		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo2 : smnPerfMonCtrLo2;
-		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi2 : smnPerfMonCtrHi2;
+		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo6 : smnPerfMonCtrLo6;
+		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi6 : smnPerfMonCtrHi6;
 		break;
 	case 3:
-		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo3 : smnPerfMonCtrLo3;
-		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi3 : smnPerfMonCtrHi3;
+		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo7 : smnPerfMonCtrLo7;
+		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi7 : smnPerfMonCtrHi7;
 		break;
 
 	}
@@ -422,6 +442,42 @@ static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
 	return -ENOSPC;
 }
 
+#define DEFERRED_ARM_MASK	(1 << 31)
+static int df_v3_6_pmc_defer_cntr(struct amdgpu_device *adev,
+				  uint64_t config, int err)
+{
+	int target_cntr;
+
+	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
+
+	if (target_cntr < 0)
+		return -EINVAL;
+
+	if (err)
+		adev->df_perfmon_config_assign_mask[target_cntr] |=
+							DEFERRED_ARM_MASK;
+	else
+		adev->df_perfmon_config_assign_mask[target_cntr] &=
+							~DEFERRED_ARM_MASK;
+
+	return 0;
+}
+
+static bool df_v3_6_pmc_is_deferred(struct amdgpu_device *adev,
+				    uint64_t config)
+{
+	int target_cntr;
+
+	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
+
+	if (target_cntr < 0)
+		return -EINVAL;
+
+	return (adev->df_perfmon_config_assign_mask[target_cntr]
+							& DEFERRED_ARM_MASK);
+
+}
+
 /* release performance counter */
 static void df_v3_6_pmc_release_cntr(struct amdgpu_device *adev,
 				     uint64_t config)
@@ -433,7 +489,7 @@ static void df_v3_6_pmc_release_cntr(struct amdgpu_device *adev,
 }
 
 
-static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
+static int df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
 					 uint64_t config)
 {
 	uint32_t lo_base_addr, hi_base_addr;
@@ -442,38 +498,54 @@ static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
 				      &hi_base_addr);
 
 	if ((lo_base_addr == 0) || (hi_base_addr == 0))
-		return;
+		return -EINVAL;
 
-	df_v3_6_perfmon_wreg(adev, lo_base_addr, 0, hi_base_addr, 0);
+	return df_v3_6_perfmon_arm_with_retry(adev, lo_base_addr, 0,
+					      hi_base_addr, 0);
 }
 
 static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 			     int is_enable)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
-	int ret = 0;
+	int err = 0, ret = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-
-		df_v3_6_reset_perfmon_cntr(adev, config);
-
 		if (is_enable) {
 			ret = df_v3_6_pmc_add_cntr(adev, config);
-		} else {
-			ret = df_v3_6_pmc_get_ctrl_settings(adev,
+			return ret;
+		}
+
+		err = df_v3_6_reset_perfmon_cntr(adev, config);
+
+		ret = df_v3_6_pmc_defer_cntr(adev, config, err);
+
+		if (err || ret)
+			return ret;
+
+		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 					config,
 					&lo_base_addr,
 					&hi_base_addr,
 					&lo_val,
 					&hi_val);
 
-			if (ret)
-				return ret;
+		if (ret)
+			return ret;
 
-			df_v3_6_perfmon_wreg(adev, lo_base_addr, lo_val,
-					hi_base_addr, hi_val);
-		}
+		/*
+		 * if arm with retries fail, mark reserved counter high bit to
+		 * indicate that event arm has failed.  retry will occur
+		 * during pmc_count in this case.
+		 */
+		err = df_v3_6_perfmon_arm_with_retry(adev,
+						     lo_base_addr,
+						     lo_val,
+						     hi_base_addr,
+						     hi_val);
+
+		ret = df_v3_6_pmc_defer_cntr(adev, config, err);
 
 		break;
 	default:
@@ -501,7 +573,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 		if (ret)
 			return ret;
 
-		df_v3_6_perfmon_wreg(adev, lo_base_addr, 0, hi_base_addr, 0);
+		df_v3_6_reset_perfmon_cntr(adev, config);
 
 		if (is_disable)
 			df_v3_6_pmc_release_cntr(adev, config);
@@ -518,18 +590,28 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 				  uint64_t config,
 				  uint64_t *count)
 {
-	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
+	uint32_t lo_base_addr, hi_base_addr, lo_val = 0, hi_val = 0;
+	int rearm_err = 0;
 	*count = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-
 		df_v3_6_pmc_get_read_settings(adev, config, &lo_base_addr,
 				      &hi_base_addr);
 
 		if ((lo_base_addr == 0) || (hi_base_addr == 0))
 			return;
 
+		/* rearm the counter or throw away count value on failure */
+		if (df_v3_6_pmc_is_deferred(adev, config)) {
+			rearm_err = df_v3_6_perfmon_arm_with_retry(
+						adev, lo_base_addr, lo_val,
+						hi_base_addr, hi_val);
+		}
+
+		if (rearm_err)
+			return;
+
 		df_v3_6_perfmon_rreg(adev, lo_base_addr, &lo_val,
 				hi_base_addr, &hi_val);
 
@@ -542,7 +624,6 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 			 config, lo_base_addr, hi_base_addr, lo_val, hi_val);
 
 		break;
-
 	default:
 		break;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
