Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B608FC4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Jan 2022 03:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9AB210E4D8;
	Sat, 22 Jan 2022 03:47:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595CB10E389
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jan 2022 03:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd1olujlgUlHr3dqcnh1Za5ywmobPYoGQ09SitVTVgbyqS7gUHi7n8pZCv/A1+0C5Cw0YEr9owvTEmpr9aC5ZzfZ2lAzPDtNv2VFbp3R66paN/h+UTiy5S7dF1rD3N0w3yeHS9XQFuYd7niiEOUiIkWnt+jvT+8+igswhjXSzc8h0RHAx1w1XIwyYC7fbpv9YPFlnmb4VxIm1g2wHd3S9McAJ6R+MKCCqOk6ZRhIvHJofOUgTnGO0PFTwlEtylIAnLRfsIhCNpF2dlxN0VVKtgjQ6oIk464w/jvEthJeSh4IyKmRAh15CG2rkD9xdASztFOZVD/D12K1nsITM+neIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lywc1F0rPGRvt5rceE7Xz4Q9H9M7aQ+UyzWGXo8J0vg=;
 b=W6fLSnhduOOe6pQcrxKIyeBJp4stNl/CZ41FZzuB/cn8U1zF9IC3iF6pFpfWRw+3fgGofOAJvtmH1wdEgNQAv6jQucPAOkDFMsSTO/bG4I2RoOJKzUj0abz8zbTwsXSuzr90/2wHzWGLee7Q2HQd+0I0S9Z3K5E1qvpTXlVqkZBAqnyTQOZPVpxeU746Li2B3eNylOT8fXSyKtu7UkmUkmmCV/bzGhGSAWebqCX8gaABT2OC3u6WZUNXvPNzRzdLAQXd7GpnxVOHKrEX9OdjqkdpOS5txuK7yJpIFr1xgFZRNRiKTu9gRX2jQl+UdewgagAJld63HvWGlmTszMKldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lywc1F0rPGRvt5rceE7Xz4Q9H9M7aQ+UyzWGXo8J0vg=;
 b=eQ8cV/ECwm5XrBXKzsvRmuWKUv4qMhjRqNzhjHskvUqUehdMOwPA4qutcr4iCl5gaA4SnNoWnD/xs6txPjskALNKch0ednIBqwrqOVvjTcl1q0lWuvrY+e2bHxW/vc+cvCb/oMijScdSTk7fCuon7nsgz8X/oeTe8Iswa1Jf3DI=
Received: from BN9PR03CA0883.namprd03.prod.outlook.com (2603:10b6:408:13c::18)
 by BN8PR12MB3345.namprd12.prod.outlook.com (2603:10b6:408:64::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 03:47:14 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::d4) by BN9PR03CA0883.outlook.office365.com
 (2603:10b6:408:13c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Sat, 22 Jan 2022 03:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sat, 22 Jan 2022 03:47:14 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 21:47:13 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] amdgpu/pm: insert attempt to call emit_clock_levels into
 amdgpu_get_pp_od_clk_voltage
Date: Fri, 21 Jan 2022 22:46:46 -0500
Message-ID: <20220122034647.67925-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220122034647.67925-1-darren.powell@amd.com>
References: <20220122034647.67925-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd888d80-f3ee-41c2-b3b8-08d9dd59e0d8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3345:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB334580B85ADF3916730FB990F05C9@BN8PR12MB3345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XLEjBrsr0TtaS7Ug5JoR0VouQ0Z/btzPHijq8pQ9mJQiS5qmp9lw1nNouJp3qbMEsYlb6zC6YdkCUpRB5+W5sOw6cRW68HWrHPAVkbNB5UnBacmWw6ni7Aykln2ekYpPGEmilI1kMzijHJOPq5BWQwtQXyiIqWwOaHU25Kv+KTtjM1uDVqECBeUHKhIrVB7w4XteHYGlJqmRbjEYPHHQp0R0DMcoaKNG6UmNH0RzYG/JKwAWvLjDm/pcxOU2AeTIyLpgSao/K8K3xdOB7sV0C5QdVjvqpBk2k5J+BibWYSUCaIl4ilmxAiM4PUy4MjdzvjoQnkxvt5VYvXDu1ZqMiHE3/MCerYM16pgdXkIGQ91ail3ThxzzL/25xbALdaDx6NYt10qa3+5QAjl7zL3HZOtUqFOqG3yaJ8w+KDC4YJym0Vz81I115AZ1a3Tha4vfYfcPXfz6uOfuOle1dJi8mka5PqihFNOc5VU0hYV6qYVuTbEqx9IxT1+8b8o8ubR+0g/1RDV1QJNJdqmT0uMe2DKLefkxeN6iCx8IJ3WVRtIzvmkzqMa8ZvhtqeHwn0jENpWS6tgnIIhMappbxA0N2nuxKy7WStXSLLZwRFeVuJ0p6ilreq63Pu6CPqmL353lxayk54mL1TpTbyWMA2rq8fUl5H1gXzylmm0crmoHel9r6V12cgBvbdOhE1nqVBAEsOFzaoHdlQa6klVV12YcPipCbCzhqyE2+KuKN7CjJrpd4TS9Xognes3p+VDjvqeuoBlSrnDQYO2uhCcQNTwSAFPTVtECASzJkYrSuvZ25c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(6666004)(8936002)(70206006)(336012)(2616005)(426003)(6916009)(316002)(82310400004)(44832011)(1076003)(8676002)(40460700003)(7696005)(16526019)(83380400001)(36860700001)(508600001)(186003)(47076005)(5660300002)(81166007)(4326008)(70586007)(2906002)(26005)(36756003)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 03:47:14.3293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd888d80-f3ee-41c2-b3b8-08d9dd59e0d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3345
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

  (v1)
    Use new API function emit_clock_levels to display to overclocking values, with a fallback
    to the print_clock_levels if the first call fails.

  (v2)
    Update to apply on commit 801771de03
    adjust printing of empty carriage return only if size == 0

 == Test ==
 LOGFILE=pp_clk.test.log
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display"  > $LOGFILE
 FILES="pp_od_clk_voltage"

 for f in $FILES
 do
   echo === $f === >> $LOGFILE
   cat $HWMON_DIR/device/$f >> $LOGFILE
 done
 cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 39 ++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ec2729b3930e..97a8dcbe6eaf 100644
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
@@ -846,16 +855,26 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
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
+	ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[0], buf, &size);
+	if (ret >= 0) {
+		/* Proceed with emit for other od clocks if the first call succeeds */
+		for(clk_index = 1 ; clk_index < 6 ; clk_index++)
+			amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
+	}
+	else {
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
 
-- 
2.34.1

