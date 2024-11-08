Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92D6D5E15F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C99810E962;
	Fri,  8 Nov 2024 11:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OW7mq0UY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E9510E962
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LabyLfUt+5JQwsTho0OIGPoU8c1vY1NR87rn1hjRPHP5I0ZD0EO6cCWmGFrJfJlUX1F4NWdowus0NKI0qT0p5R2OoKZ1lYiqo5C9CML+Lly+lLaRrc8Nr18p757Xih12kT0vES2JCODULCipVg7O1eAyW5wScJWVvC1+ItMnYvGyUOfDQyrwLVMKJBAimC+Om3hs7zpQKzNYcexSdMAGlqV1iHCWn7eqv6w9jUROsiDunwSn/xrqjC1jrD05EmGhEMbmggKWfLOtcccDL/8hdAMO3xpHtNPTSW0knNby3dhte8AA4lAiqC2HfsyHCA6O/kaN9Ww5ffYOyJTgZlW6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK1XTX2d2cxNpRTk4cJbS+PUQyIrFWTXbcb2wUhEG10=;
 b=h/R/25JhNZ1n/nPyXtranVVHhJXArVNShEEiQMxDkAwmoyQvOUZ+K3zERegYCDfJUJQWlZt1Exa6NLjvHZORnoSgMbzinf1osYn6U6j7bvKRntmRmxcxdaPPnSi5udBhhXlo8uMVmDboVeZqbysFVhRRN/5vnDvsDigRblWqgJxN96sWDbRyWGJOhoytff+/U2OyEQcXqjtz0ItSjQ573MQ59sRBWyi1KKrvC9FC9jQ+9BpYAxNzFZz/V/ie0HBfV2AnUYO5BxOh2IQjVuvWrm3Ne7JhrFDMZ4TBU48uUtDW4lpO710S4EQsLfg7CRZ30UppyVV6vbFSnreN/zLf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK1XTX2d2cxNpRTk4cJbS+PUQyIrFWTXbcb2wUhEG10=;
 b=OW7mq0UYagxuMCb2pZ3OucgtczM9QDqVB5JAjCpJFK/NXIVHsycdQIKRrKIa9RfE/9B8EtQ0VITM/MdEZC/a7nIRqujn+y8KPpWgB7erPba6LLS5z7cPVIWz/IUI4howBZUPP8yahh8gwzAUv787Xpcc7k+nBs4tGoNb7o37yKg=
Received: from BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 11:14:45 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::c) by BL1P222CA0013.outlook.office365.com
 (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:45 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:43 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 11/23] drm/amdgpu: do RAS MCA2PA conversion in initial phase
Date: Fri, 8 Nov 2024 19:14:11 +0800
Message-ID: <20241108111423.60169-11-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: 476d2565-e832-45b6-9dea-08dcffe68d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hZGrkENCVWvPHlpv21nbPBbsjAAhDGijko/bUnXIUmewQr4DkpRiFUuwe4Bg?=
 =?us-ascii?Q?8L2hqWCVRYtx5smgTgJE/ibL0WXm6InG+phMKc0TzzGGOqMemDut5ZbUhhPh?=
 =?us-ascii?Q?nbQUHeR9tsUipF9Mcp3Iqtp5kDh8gjbNWhT6nYKk+z3eGFswqA06GFf07USk?=
 =?us-ascii?Q?YTGZg9uMFlGyu/rE58IhXJA3LNxSu2ZzRiF7KAbwngwFR/0GgWC51GuLaGvy?=
 =?us-ascii?Q?qm7LATgmUA5Ggjdp7u8IwHCxDdyhlWYpAT6xyFIKC9/s8ooCwoe4WT4/EGBu?=
 =?us-ascii?Q?kHdTJ89zG6VcsSp8kBje7kJ9Hl4fB4f0Ehr5E1HjlLw6mFHqN81/VT3dPEpK?=
 =?us-ascii?Q?duNRlKd7wWYhLjPNlSdv3IoitnhZ09ZkBYHuYwftZv1451kkVoTdLa/PFTmU?=
 =?us-ascii?Q?n15qZupuLtTPeT+e3mgho4W/fz1dxASmpgZP7jIFbQXM1gKSS2XaQa9rAXTA?=
 =?us-ascii?Q?z/TB318d9uZJ3e2T4j69uSTIECsPVAFaZpOXfpkmV9KTv/3HGOrht0jpSRFu?=
 =?us-ascii?Q?fxc1FNw5WMciY7jIC4Dkpcv7NzAXt9HmWzbs/RUGWBRdcMXQFFgPrOZ5z9kr?=
 =?us-ascii?Q?A+VaKY8yuD2AQ4S83RRi3UrLHJR/3IBxcG8plb1XYZqobn++F9O+/I5mnyjU?=
 =?us-ascii?Q?OL6LP/n35T7RcMNf+kFeK7gX6wonPjQKI1djBylOO97gj+oJphGk2HbCEbGF?=
 =?us-ascii?Q?zdxps9dkBMPyBpCkuAYhHlT2ZQfZi4KC0BKmeF5A31iJGhXrTfeRM+pMrRgU?=
 =?us-ascii?Q?ttGa3ycl9duF19n3giTll8CdUvpvRX3vGtgun0nX5NjTMsM/gI/VdI5IlC5z?=
 =?us-ascii?Q?bDFnalzfi91uK0GhKleC4aDRo/qrlgEjq/86KyM17wFq1usIlbSSALT9Tawl?=
 =?us-ascii?Q?NlpjE9gjC6FYLe0PYjSd+PxlRNM5rVci34Ofw/AqVnS5dtVy3Tjq46hoXAqP?=
 =?us-ascii?Q?KNRjBKgUTzfnEiFpVVjkFZ315NtuQohx80VyHudjpH91ExlGfuJ94nkkEAbU?=
 =?us-ascii?Q?vtADPBU6J2e0n6FrJPBPd4zAW/RKe1S0HKVwuwb+4WFR8GnY0fc0D+kC7+xl?=
 =?us-ascii?Q?rRRKLuU7ykAzfoYwM37ieCKsGYyGgDstaCrgn2RagNlTtUOPzioI+dWM+AGB?=
 =?us-ascii?Q?QPCpp9cIP/0Rfufn7kp0R7rDH64AHrK1HOfFCQgLBIqbplfQqsThPjayxQg+?=
 =?us-ascii?Q?bSCLoP9OCBLpndMLldgSZ9iRPbR9vRV3c2CoFtVn6uKReyBDL7oAFuapT5fB?=
 =?us-ascii?Q?ZjMsDfX5xqXNEd6HB0F03loI1yVcMZI5EUAUwdckcJxFdZmBHqB35rjZ+UmA?=
 =?us-ascii?Q?a/FZ8yLS/augw7vE6qkDQ8UZIAeGGb0R5NGXhNj80YlDuFraWS5n4T0yQI2L?=
 =?us-ascii?Q?8h0O6ccFA1wdQj2sE5pVoWWMcPcek/yHti8pmqHhrAaKOk9uXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:45.4142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476d2565-e832-45b6-9dea-08dcffe68d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

NPS mode is introduced, the value of memory physical address (PA)
related to a MCA address varies per nps mode. We need to rely on
MCA address and convert it into PA accroding to nps mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 97 ++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 77cb2d7bb0a0..f31085c3a12d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2665,40 +2665,113 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
+			struct eeprom_table_record *bps,
+			struct ras_err_data *err_data)
+{
+	struct ta_ras_query_address_input addr_in;
+	uint32_t socket = 0;
+	int ret = 0;
+
+	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
+		socket = adev->smuio.funcs->get_socket_id(adev);
+
+	/* reinit err_data */
+	err_data->err_addr_cnt = 0;
+	err_data->err_addr_len = adev->umc.retire_unit;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	addr_in.ma.err_addr = bps->address;
+	addr_in.ma.socket_id = socket;
+	addr_in.ma.ch_inst = bps->mem_channel;
+	/* tell RAS TA the node instance is not used */
+	addr_in.ma.node_inst = TA_RAS_INV_NODE;
+
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		ret = adev->umc.ras->convert_ras_err_addr(adev, err_data,
+				&addr_in, NULL, false);
+
+	return ret;
+}
+
 /* it deal with vram only. */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
+	struct ras_err_data err_data;
+	struct eeprom_table_record *err_rec;
+	struct amdgpu_ras_eeprom_control *control =
+		&adev->psp.ras_context.ras->eeprom_control;
 	int ret = 0;
-	uint32_t i;
+	uint32_t i, j, loop_cnt = 1;
+	bool is_mca_add = true;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
 
+	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr) {
+		is_mca_add = false;
+	} else {
+		if ((pages > 1) &&
+		    (bps[0].address == bps[1].address) &&
+		    (bps[0].mem_channel == bps[1].mem_channel))
+			is_mca_add = false;
+	}
+
 	mutex_lock(&con->recovery_lock);
 	data = con->eh_data;
 	if (!data)
 		goto out;
 
-	for (i = 0; i < pages; i++) {
-		if (amdgpu_ras_check_bad_page_unlock(con,
-			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
-			continue;
-
-		if (!data->space_left &&
-			amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
+	if (is_mca_add) {
+		err_data.err_addr =
+			kcalloc(adev->umc.retire_unit,
+				sizeof(struct eeprom_table_record), GFP_KERNEL);
+		if(!err_data.err_addr) {
+			dev_warn(adev->dev, "Failed to alloc UMC error address record in "
+					"mca2pa conversion!\n");
 			ret = -ENOMEM;
 			goto out;
 		}
 
-		amdgpu_ras_reserve_page(adev, bps[i].retired_page);
+		loop_cnt = adev->umc.retire_unit;
+	}
+
+	for (i = 0; i < pages; i++) {
+		if (is_mca_add) {
+			if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data))
+				goto free;
+
+			err_rec = err_data.err_addr;
+		} else {
+			err_rec = &bps[i];
+		}
+
+		for (j = 0; j < loop_cnt; j++) {
+			if (amdgpu_ras_check_bad_page_unlock(con,
+				err_rec[j].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+				continue;
+
+			if (!data->space_left &&
+			    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
+				ret = -ENOMEM;
+				goto free;
+			}
+
+			amdgpu_ras_reserve_page(adev, err_rec[j].retired_page);
 
-		memcpy(&data->bps[data->count], &bps[i], sizeof(*data->bps));
-		data->count++;
-		data->space_left--;
+			memcpy(&data->bps[data->count], &(err_rec[j]),
+					sizeof(struct eeprom_table_record));
+			data->count++;
+			data->space_left--;
+		}
 	}
+
+free:
+	if (is_mca_add)
+		kfree(err_data.err_addr);
 out:
 	mutex_unlock(&con->recovery_lock);
 
-- 
2.34.1

