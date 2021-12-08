Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40228C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 06:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67CE6E956;
	Wed,  8 Dec 2021 06:37:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DE16E956
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 06:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs/XbbussSk4B52f62SKn+x4e8nVoxEqdBED/r0j7Lbtb6YguFCaXDcvdgIk/1v0l/9FJeKyhuHtzXhyyktNhz8hIyqwUJeJEOc4pfvIYeKg0bqjbhHL7eSiWRZMMqHk3NpdMnqof+iSHZeYyXiT6tkao93GosWIWaFI+1lON5hhUqxspoTUta73wD0KTljLh3+rcDP4bvpyMbWLwJ4+A6flZwfLihtZNUW4LdGhIPDlHP0mRHDTn9cFZGX8Y1y2WrKN6YIy7TgoSWwVYc4pfAkNbXNxD40cNHm45vFfwlw7R5UO6Z/yNcTXAkRBtezSENLWttvSrFD1LtwsxNLAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86HNwC7IIEj02JuLg6k3fl7gvvjuT/hKqQsz3fS7XOE=;
 b=COa+t6J4SCDNmsYLpPqNKX02hVc3FgXsadn7Fj0mnTmBPadfU2zHUybR59xtO2kPBhLGoIM+vTFkbAbnRjvmR1Y+H1KyOuhwJKhWS5V0aQoztwJ+vZ++BWEMa16lxckZp3d2lEKTyBzmgnAPDt6v2MKZhHo+aIQVxbUzp4FrsH3gGKMk1EFjqz197jzKG7NBlIV8eHzTdO6CZMh4qmMHmtFjH0vwBErUAKqaO9AH4SmNxa/6B0GqhN7Pp9zn+TZ2vrvMxs8fgCfDCeQpuLnIwu5JIZLDmAGqX0DsbptyObVo8IV2ByCsyMDYIlAFUY9B5Wae6cx/+3kVisdwhLt15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86HNwC7IIEj02JuLg6k3fl7gvvjuT/hKqQsz3fS7XOE=;
 b=0SK5e9RGOChwUJDrsimj1089EagUPkWX5N9NM/L5+1ar1HSX/TRl0gKwa5JGovwHO50i33Xw7NAZwUUQUqcV0rr/tWgnn4EMWoeL9mO0FJ4bd0nYoJegiSIPbC6UBcq2ibWV3hHo8GjWNTBG5lsbmBToO9kWAZkV2w/L+/q9yVw=
Received: from DM6PR21CA0009.namprd21.prod.outlook.com (2603:10b6:5:174::19)
 by CH2PR12MB4007.namprd12.prod.outlook.com (2603:10b6:610:14::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 8 Dec
 2021 06:37:02 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::94) by DM6PR21CA0009.outlook.office365.com
 (2603:10b6:5:174::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.2 via Frontend
 Transport; Wed, 8 Dec 2021 06:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 06:37:02 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 00:37:00 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] amdgpu/pm: insert attempt to call emit_clock_levels into
 amdgpu_get_pp_od_clk_voltage
Date: Wed, 8 Dec 2021 01:36:08 -0500
Message-ID: <20211208063609.5593-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208063609.5593-1-darren.powell@amd.com>
References: <20211208063609.5593-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ea49d7-666c-4b0a-a3a3-08d9ba15249e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4007:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB400788426B2879DF8D419C01F06F9@CH2PR12MB4007.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaEPEUTAK4W/r+YSOrH4G17/MJIKKODWtamacr2mYXznbhubU+1Ci0xxpUwqpEPWM0Rw/2P+XqvDcbAcvyI4ILQCO9d+XxFva4pBee/M4Iur/u8uGdsDlXTPfnRpnsOApMmEAshQLm/7kVIuiQn9tpcjsjyMBPMYPa45+MY96N25c/tBjhbtviouDxu38IqWVi6uxL8tllRvU0uuTyazonVBfZnlJq/M5rRqY7OWK4aky3VVqxJAA1FiW8iwpOds5rgT/gc+TXJkvy5B5pYkkItL/Wz/EO6tAlChdmVUsq8f/UhBYKewPDvPLu+JnwH7Wj142h18UmVXXn+T0U2Npf+Zw47xI8MiI9IzkkLIzEiji0CLE4IoVKQeZImA9sO0Q21CKKo8114KdVFMsu0AF0dYA3qRVRAIUy3gyvFyiFBhDq/bovgHkODs32EwDkR+tLkgl+SadRKMq+L/egS0M3FQ/naPRO/GyS9TIRMySPlwrYii93p0448n8zwTW3d65YMlFWV531eiGIFeX91u/4rnNbETORNAXBakyZm9ReJ59xZcI3RSRNJTJHJ714NeOsaNmwfbq2/t8SMDPe0RzeRRkRVZwgMoZrOGsC4oHaWBPdW2dL7IlWl9qKm/d7uI9iceNQTq6zGNx/eKAIglhtYIt1I198p9AvCV3xx27or+l2Bn1LCC/MTxYF3gfMzUCwg4uGF9Jp8jXotuu1XiDppxQuHp4OVLiJURhLVCVpNWJlyn9OU84IvOCyxDd2Zll/7zs256qlhBYhQol/VRxAuWErL8NnPby4491QwCE0c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(2906002)(81166007)(83380400001)(86362001)(16526019)(6916009)(44832011)(186003)(508600001)(5660300002)(7696005)(70586007)(70206006)(356005)(4326008)(316002)(1076003)(40460700001)(8936002)(82310400004)(36860700001)(8676002)(426003)(336012)(36756003)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 06:37:02.0310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ea49d7-666c-4b0a-a3a3-08d9ba15249e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4007
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

  Use new API function emit_clock_levels to display to overclocking values, with a fallback
  to the print_clock_levels if the first call fails.

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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 46 ++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a1169a2397ca..04992a3bc1d2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -904,8 +904,17 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
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
@@ -918,16 +927,29 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	if (adev->powerplay.pp_funcs->print_clock_levels) {
-		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf+size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf+size);
-		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf+size);
-	} else {
-		size = sysfs_emit(buf, "\n");
+	ret = -EOPNOTSUPP;
+	if (adev->powerplay.pp_funcs->emit_clock_levels) {
+		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[0], buf, &size);
+	}
+
+	if (ret > 0) {
+		/* Proceed with emit for other od clocks if the first call succeeds */
+		for(clk_index = 1 ; clk_index < 6 ; clk_index++)
+			amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
 	}
+	else {
+		if (adev->powerplay.pp_funcs->print_clock_levels) {
+			size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf+size);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf+size);
+			size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf+size);
+		} else {
+			size = sysfs_emit(buf, "\n");
+		}
+	}
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -2075,8 +2097,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
 		*states = ATTR_STATE_UNSUPPORTED;
 		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
-		    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
-			(!is_support_sw_smu(adev) && hwmgr->od_enabled))
+		    (is_support_sw_smu(adev) && adev->smu.is_apu)     ||
+		    (!is_support_sw_smu(adev) && hwmgr->od_enabled)      )
 			*states = ATTR_STATE_SUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
-- 
2.34.1

