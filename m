Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB9CC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 19:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CA12082E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 19:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KAKh93Bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CA12082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EEA89C82;
	Wed, 18 Dec 2019 19:05:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6F789C82
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 19:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwT1kJX855C4mxkeHUHvjwIzZhy2GTok9hVyPzDKaERMd8j4Iozvi8qunGZ5Qc2h5UxRfcqoHkK/mEASaZjhhKrC+OYlcf3t7HNQC4zXuhEha6c0LjRbTX9+MShzpkjdPcXY7r0GWC3Updj1/iVeu7ghd8fP+8MHyDYGU8JpwjpVkIEi253SwCZEkQMTjlBRyUiStSR1l/7W1pfTHjJx96JbIONso6sb7B6X6/MZKqKalpVZQY2DhaeE03JwTpZIYntUkx1nFcChPLwCO9pvNZ2+TLXeFQ/yfI+RRWPmnmF+abFjcLaIdE03VL0rY0hGWhXGk1rYCBezjLpILYVheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvhspRy80S0d2a/an8dpYRyYiZihyVivDmsMuof9Jic=;
 b=iU+Rd8w0pLJX7BdoM5+fM37uocP4cA9VXFj4fR71kxVElLyGXy/HWnIwI6aIFV0ni+0SDn7vmdMENlYyPv5DbU14/DMQDtzF5JEqbrGKJkX5Z3fi41dBYOemKi2srXM4nelmp6QsizWm9SdADh6EP0ZMbHbUc9jia+MZjC1wXh0by1X+3uUmDvzr+wBjXJkXbM9DdEjqIgXwoXsaRmy6SWbXQ+xeLZ6VfQrnIyPvRCba/njYDWZ2H4nYqitp6R+hoUN7UoFDfw4/DKuk7KINWl9FOXBYxeSN65U54Q8PfqwvL2B45+1l9v9CNjXHK0aj///HGEGuX9V+rR8E+1EsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvhspRy80S0d2a/an8dpYRyYiZihyVivDmsMuof9Jic=;
 b=KAKh93BsFWuC6TD+IaTw6VxeVWpRGgChyjA066CFJlbpMcyTi5SngbGaqk+U5CCEgiQNrQMWwbfk2deE2sw2vINi8H3zTqAiyRC8Yvwf+fdOcTSqMmKKYm7SYqMyrh2LDwXGMV0RnAk/MedKKodCvdqnzCVONR4gXNGYTeFAZOU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
Received: from CH2PR12MB3831.namprd12.prod.outlook.com (52.132.245.141) by
 CH2PR12MB4247.namprd12.prod.outlook.com (20.180.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 19:05:18 +0000
Received: from CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::adcc:f57d:89f5:279f]) by CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::adcc:f57d:89f5:279f%5]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 19:05:18 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: attempt xgmi perfmon re-arm on failed arm
Date: Wed, 18 Dec 2019 14:04:53 -0500
Message-Id: <20191218190453.55405-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::46) To CH2PR12MB3831.namprd12.prod.outlook.com
 (2603:10b6:610:29::13)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eae34183-5bb2-4ec0-d11f-08d783ed38ed
X-MS-TrafficTypeDiagnostic: CH2PR12MB4247:|CH2PR12MB4247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42472F9A21504A23B353927F85530@CH2PR12MB4247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(2616005)(66556008)(316002)(8676002)(66476007)(8936002)(54906003)(26005)(6506007)(2906002)(66946007)(81156014)(81166006)(5660300002)(478600001)(6916009)(36756003)(6666004)(86362001)(186003)(6512007)(4326008)(44832011)(6486002)(1076003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4247;
 H:CH2PR12MB3831.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qa2BJQc4AetFnbpvL13ZRLpJTemL5k1FgH61fMTOf0KYRHktEuaBH3vPUGqE9fqUWDQ31p+bl+QiaORt+53Tj9NVAXBxZ382UObS8Y3giAv9Tq8+ecw5Gha+SfT5TIw5ZTuZBVudLAmBd49zsq+K77EUoKhunti+SKbX/m89vSfiVg+x32UbJNMM82irBK6ussXoQxCCQHl6UmZudWs3zUIDsoCVsD2cZYd/mQoQx9uHoLRdVgarLRuRszY7q9DJXrZFQz7KbH145XrS0M+a7JAS7EnDvc++SIlW631DrKGJ3H5dF6ug+jK7/nKWZEtnGGyBfcWKr/WE94x7VSjEh2jH+rkXPHzRfs25VYOJZFXHKDb9mgAx3pwN6aLhEIG6tXJIMZ3Ir4CeuIFbi6N6O5K2qaV1TFFBNp5DN4r49VD/Jj2aTwfAn56jsYqbmCJK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae34183-5bb2-4ec0-d11f-08d783ed38ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 19:05:18.5000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPdJV2GQhMjfvXj82RKMsj9JDM8R2lO15IR2Eq31RQSAe8keO4YE/ph+MjGm155X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The DF routines to arm xGMI performance will attempt to re-arm both on
performance monitoring start and read on initial failure to arm.

v2: Roll back reset_perfmon_cntr to void return since new perfmon
counters are now safe to write to during DF C-States.  Do single perfmon
controller re-arm when counter is deferred in pmc_count versus multiple
perfmon controller re-arms that could last 1 millisecond. Avoid holding
spin lock during sleep in perfmon_arm_with_retry.  Rename counter arm
defer function to be less confusing.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 149 +++++++++++++++++++++++----
 1 file changed, 127 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 4043ebcea5de..56dead3a9718 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -183,6 +183,61 @@ static void df_v3_6_perfmon_wreg(struct amdgpu_device *adev, uint32_t lo_addr,
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
 
+/* same as perfmon arm but return status on write value check */
+static int df_v3_6_perfmon_arm_with_status(struct amdgpu_device *adev,
+					  uint32_t lo_addr, uint32_t lo_val,
+					  uint32_t hi_addr, uint32_t  hi_val)
+{
+	unsigned long flags, address, data;
+	uint32_t lo_val_rb, hi_val_rb;
+
+	address = adev->nbio.funcs->get_pcie_index_offset(adev);
+	data = adev->nbio.funcs->get_pcie_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	WREG32(address, lo_addr);
+	WREG32(data, lo_val);
+	WREG32(address, hi_addr);
+	WREG32(data, hi_val);
+
+	WREG32(address, lo_addr);
+	lo_val_rb = RREG32(data);
+	WREG32(address, hi_addr);
+	hi_val_rb = RREG32(data);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	if (!(lo_val == lo_val_rb && hi_val == hi_val_rb))
+		return -EBUSY;
+
+	return 0;
+}
+
+
+/*
+ * retry arming counters every 100 usecs within 1 millisecond interval.
+ * if retry fails after time out, return error.
+ */
+#define ARM_RETRY_USEC_TIMEOUT	1000
+#define ARM_RETRY_USEC_INTERVAL	100
+static int df_v3_6_perfmon_arm_with_retry(struct amdgpu_device *adev,
+					  uint32_t lo_addr, uint32_t lo_val,
+					  uint32_t hi_addr, uint32_t  hi_val)
+{
+	int countdown = ARM_RETRY_USEC_TIMEOUT;
+
+	while (countdown) {
+
+		if (!df_v3_6_perfmon_arm_with_status(adev, lo_addr, lo_val,
+						     hi_addr, hi_val))
+			break;
+
+		countdown -= ARM_RETRY_USEC_INTERVAL;
+		udelay(ARM_RETRY_USEC_INTERVAL);
+	}
+
+	return countdown > 0 ? 0 : -ETIME;
+}
+
 /* get the number of df counters available */
 static ssize_t df_v3_6_get_df_cntr_avail(struct device *dev,
 		struct device_attribute *attr,
@@ -334,20 +389,20 @@ static void df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
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
@@ -422,6 +477,42 @@ static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
 	return -ENOSPC;
 }
 
+#define DEFERRED_ARM_MASK	(1 << 31)
+static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
+				    uint64_t config, bool is_deferred)
+{
+	int target_cntr;
+
+	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
+
+	if (target_cntr < 0)
+		return -EINVAL;
+
+	if (is_deferred)
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
@@ -451,29 +542,33 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 			     int is_enable)
 {
 	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
-	int ret = 0;
+	int err = 0, ret = 0;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+		if (is_enable)
+			return df_v3_6_pmc_add_cntr(adev, config);
 
 		df_v3_6_reset_perfmon_cntr(adev, config);
 
-		if (is_enable) {
-			ret = df_v3_6_pmc_add_cntr(adev, config);
-		} else {
-			ret = df_v3_6_pmc_get_ctrl_settings(adev,
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
+		err = df_v3_6_perfmon_arm_with_retry(adev,
+						     lo_base_addr,
+						     lo_val,
+						     hi_base_addr,
+						     hi_val);
+
+		if (err)
+			ret = df_v3_6_pmc_set_deferred(adev, config, 1);
 
 		break;
 	default:
@@ -501,7 +596,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 		if (ret)
 			return ret;
 
-		df_v3_6_perfmon_wreg(adev, lo_base_addr, 0, hi_base_addr, 0);
+		df_v3_6_reset_perfmon_cntr(adev, config);
 
 		if (is_disable)
 			df_v3_6_pmc_release_cntr(adev, config);
@@ -518,18 +613,29 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 				  uint64_t config,
 				  uint64_t *count)
 {
-	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
+	uint32_t lo_base_addr, hi_base_addr, lo_val = 0, hi_val = 0;
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
+			int rearm_err = df_v3_6_perfmon_arm_with_status(adev,
+							lo_base_addr, lo_val,
+							hi_base_addr, hi_val);
+
+			if (!rearm_err)
+				df_v3_6_pmc_set_deferred(adev, config, 0);
+			else
+				return;
+		}
+
 		df_v3_6_perfmon_rreg(adev, lo_base_addr, &lo_val,
 				hi_base_addr, &hi_val);
 
@@ -542,7 +648,6 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
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
