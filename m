Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08985C28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D38210E51A;
	Wed, 26 Jan 2022 04:55:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFE810E51B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPK2iKVp7hx7dA6Zed12QTGUv+Lgb/ihns4vpk2ohTOYWrpqhYQ1d+Smy+FrITEuXy1ffxcGd7nTSR9E8UdMiledxQ09vlm43sDV0w0s4azhWk1ykkrgQQxdaVEIfrzpMhJBaEZ39Ja+SL25IRXimHHQIjDNhAJFbMkUNtAim5RJuR/2pR6lxkK06w0r/Fw/uVh/iAPNuajKwuQwxocLOAMoKsms+t9Rv0uN6hmuzdb6bE8nO3qb1cpS9ttoo3KLVKInPxfQsFYIjqt550UtTrllLeyM2ht+hkl7L1m0A07u9Y1TEd96rO2+Uuq15Wjo5RQSYnQMxdpPjaohfbujjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyq6reLPfq4oVlb/WMeiVbPNiZUf1tXFAx/MaZlsGKk=;
 b=V75FhveAGh2aTD78MrjuewX5QERLlZ0F+UUJBuN4lmFa7DkZJizZDHqzyNIQGaV8xtAgogbLRalBuEs1BFaAt65BA56tL6yLMyqsX778KQgYw1yFb19NtpdHXv/EwJo9kqxyLCkSdvsR0zwTEPaxMoJeNR7Blm4QopaaHzycfViWVMSOMeZW+e0EYpokXpcLlXUEOfEPtDAFTmI7S75CO4fXitZGHy0hq81Ou9BvRqK1yl4U3apRxo6LKdfRkE6QE82JaiYFtVNMo9JzHbMArFRraXmbQtWt895IDVMrGTZQdYkMoyxV+saz+p9Sb+Gkn6RWRABM8cGfgVxz0RS6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyq6reLPfq4oVlb/WMeiVbPNiZUf1tXFAx/MaZlsGKk=;
 b=xcUbTbd7eQRJiEyah9T9z/f5/s+NN3CeVSBHlcsOKiyIf0EK0NHrVHS0mxl+S8lY6C7mw35zSGt6dxcaxJXHNU+Jv3p5i1z/VZDvF1N0+vZRX1jgpWMCfgRsU2ca2vH+q3f2YkNyasdls/zv/WvbzsC20Ggu3VdHIAbX31X2eYw=
Received: from MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 04:55:04 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::23) by MW4PR04CA0183.outlook.office365.com
 (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Wed, 26 Jan 2022 04:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 04:55:03 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 25 Jan 2022 22:54:58 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] amdgpu/pm: Linked emit_clock_levels to use cases
 amdgpu_get_pp_{dpm_clock, od_clk_voltage}
Date: Tue, 25 Jan 2022 23:54:41 -0500
Message-ID: <20220126045441.3891-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126045441.3891-1-darren.powell@amd.com>
References: <20220126045441.3891-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47556fa8-5144-45f0-a65f-08d9e088042a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4392:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43924EAFE567449A2320797DF0209@MN2PR12MB4392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jC3iF5ki7sR9BzEtVwaR3jlfgF147xy4gOXo/xNYokEvKS1jPOtBE9tpOuj7dIpz2jr5CU4UxWcs9EPmZC0CiWxHIu5XZeUfBSsZniiBozHS/DFKBL6T5JbcC7O7LlcBLKbcV8JI5aCp8yu9d49SVlkPewPU5Jb+T1U3eQKlq2fLvDX6DJcu9NJRFIOym80L040eZ7ZkD0tqZFz3TSKNa0B0qhwOvJ+N2TnQw/3nrIbZdrzZb5PNjHLYHrwC/41z17jzNej/PTu1mtnvCEYwgq8Lt5C+z5qLxRU0NODennOeJagL7iqVjRZzv6QMcZu5ki8YtYVF4/GURT1iDkrvqvAEtxaZwwRVdExsxUcwlSW1wvuDt3IrbIaPph1UtH9MNd/etorhKU6L0XAH28DVEf2bQ9jtBfS52XZ0zj1IZLEUWlpV7rI1f11ksDJTSvCJ/0/n9PxX2MfN2sKaT2/Nm0KUZFJINL3QIYMn0U4EzzaXLd6LHXXZ4labCwh/DikIqZL44Mi/RegEC2rkAwaKO0A8NgpxQGhry70BgNCVqeZBd9mfv4MlQ4viZl6UEtKcQjmOaQjf6CjP+V6URZzOVvhdj0nPdBgK6OuXUZGpC9mm5RSN44bGbP9nVg9fbDyefahgFEXJK/wXhDUCyN3lPsDj9LmF2KJ28bQeGXIZF4Bp1gwtBi1OKbe3nVDuBAK+YQCW2lVBTaGNzxTdR++3AQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(316002)(8936002)(8676002)(4326008)(47076005)(83380400001)(16526019)(1076003)(186003)(26005)(6916009)(336012)(426003)(82310400004)(86362001)(81166007)(356005)(70586007)(70206006)(2906002)(36860700001)(44832011)(36756003)(5660300002)(7696005)(508600001)(6666004)(2616005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:55:03.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47556fa8-5144-45f0-a65f-08d9e088042a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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
Cc: Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

   (v3)
     Rewrote patchset to order patches as (API, hw impl, usecase)

     - modified amdgpu_get_pp_od_clk_voltage to try amdgpu_dpm_emit_clock_levels and
       fallback to amdgpu_dpm_print_clock_levels if emit is not implemented.
     - modified amdgpu_get_pp_dpm_clock to try amdgpu_dpm_emit_clock_levels and
       fallback to amdgpu_dpm_print_clock_levels if emit is not implemented.
     - Newline is printed to buf if no output produced

 == Test ==
 LOGFILE=pp_clk.test.log
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display"  > $LOGFILE
 FILES="pp_od_clk_voltage
 pp_dpm_sclk
 pp_dpm_mclk
 pp_dpm_pcie
 pp_dpm_socclk
 pp_dpm_fclk
 pp_dpm_dcefclk
 pp_dpm_vclk
 pp_dpm_dclk "

 for f in $FILES
 do
   echo === $f === >> $LOGFILE
   cat $HWMON_DIR/device/$f >> $LOGFILE
 done
 cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 49 +++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d2823aaeca09..a11def0ee761 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -832,8 +832,17 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
+	int size = 0;
 	int ret;
+	enum pp_clock_type od_clocks[6] = {
+		OD_SCLK,
+		OD_MCLK,
+		OD_VDDC_CURVE,
+		OD_RANGE,
+		OD_VDDGFX_OFFSET,
+		OD_CCLK,
+	};
+	uint clk_index;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -846,16 +855,25 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
-	if (size > 0) {
-		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf+size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf+size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf+size);
-	} else {
-		size = sysfs_emit(buf, "\n");
+	for(clk_index = 0 ; clk_index < 6 ; clk_index++) {
+		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
+		if (ret)
+			break;
+	}
+	if (ret == -ENOENT) {
+		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
+		if (size > 0) {
+			size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf+size);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf+size);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf+size);
+		}
 	}
+
+	if (size == 0)
+		size = sysfs_emit(buf, "\n");
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -980,8 +998,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
+	int size = 0;
+	int ret = 0;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -994,8 +1012,11 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 		return ret;
 	}
 
-	size = amdgpu_dpm_print_clock_levels(adev, type, buf);
-	if (size <= 0)
+	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
+	if (ret == -ENOENT)
+		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
+
+	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
 	pm_runtime_mark_last_busy(ddev->dev);
-- 
2.34.1

