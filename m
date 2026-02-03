Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B642BE83050
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525F110E4FA;
	Tue,  3 Feb 2026 04:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u6dy8uVD";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D75810E4FA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2ADmhmedVIcdP/PiaS1zSSjjy8Uz2J1dYGFU89BOQAJB10qVPSvhLmBs6TUCdTRrhxcw1qx08HCSfCqqsnvggyV0ZXFL9Z4Mp1U5NL6tkThom6wMM5dPkD8crOBIGFKOnQxy0m2yT/TImCgtVBuNum7dG9+dIUXz6/FEc01YyEmvDjaAwqfG254CGhUa9jmRvqFwfoJwSmnonsNf6sTxhxLaQ4hTbm5JgGkYKigUa9zFxymLLM+OangbIalfNxOaVwPPyBpIt6LmsC64e3ppyfYVMeeknbUhwkJY889BN5JppEJTNUVfnf25BQXV3X5j2+wLDiTAWGzu8RAj7Evtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2uwOMIh8Tf1yfjzZqV4kzSCoItnDo5mfD84ofoucZY=;
 b=naR7sLULWirVYekWroGuIxNvEeWsAKDqkO2YaWCmenBCp1R8N7RA48i0nHzgYSJJuAKwpSwgY7QsRANLi+08oAtKRT7T1/5WVEgxhAY+MOfpAxTiYPJr3Yp6phw4R0LDSJZg4Uxs40zZQdrn3UP/8itMDeP473l1PO/w5wJg2/a4dYKPnd/aFcNtIDhn8HRnqYSImmyTOhxrkNE6IGnbXvFgAOyC9gb4knaoBHeiY8iYFpbn9vYlxTnATaB0/lqF8csAN+V/6huX/prATKcDDqRFV9KMmGsn60cb69VybNro6DMWN1d442J25UPrUzN//BOxHk0WSrhY99F55ZVssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2uwOMIh8Tf1yfjzZqV4kzSCoItnDo5mfD84ofoucZY=;
 b=u6dy8uVDMtxAUNR0r47uZ3kFQTBPZUQOD7Ffo/W0vWzsFYMatXToXzrPCyCQutMNhq18pns1pofU7m9NFQt4LYY1rk2r7VPy4eSuExTF1C4gN/KTACrrLfSKUyx/oyl/iGrLKUigpRitIIM4DQ9dmZnb1/Zvw93Sc+BbiRmp/NI=
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:13:06 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::e2) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:13:06 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:13:04 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 12/14] drm/amd/ras: add initialization func for pmfw eeprom
Date: Tue, 3 Feb 2026 12:12:04 +0800
Message-ID: <20260203041206.1299104-12-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cfc659-de38-4e28-cb56-08de62da883c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?06SLoqQ72Xav989TOVimMJxYGV25vIvkfAxqzxsiT39iNwrEU+AkGu9nhqgA?=
 =?us-ascii?Q?PSUoud9RZoeyuPAyhU5Rtw1OmbBHz8mlGYpMAET3B3na+t01iEyBudRk5uS8?=
 =?us-ascii?Q?u5KG4biVF/T1655qzsn+Fd6Kl5gJE1bMLGphLLw9111nplQq3vnW2RZ2Ww4P?=
 =?us-ascii?Q?oUf98iRvUQ/az//SzcOD79QP6CEJ24AKNdu46e8M3bmOdF+FhHeP+c10e3Q0?=
 =?us-ascii?Q?swA7agHsrZy048GEK3CidQZQDGc28HHNUNATuXOk0DR91yOkFqtzTQ68cwtn?=
 =?us-ascii?Q?B4vDoT5/zHF5UtT5R4pEJSxgvtGx0APnHu7QyI+hyqg3tS9IZgSVWJQ7mZVC?=
 =?us-ascii?Q?x4JOV49eOua/bYmQu0G/xy8fnCNcVxQwhva7xwLQf30CfwQMM7ujzR7KRFxt?=
 =?us-ascii?Q?bke6l3lDXficTuTPKvvH0qoPDXSmT2Q3AWr9TFcww0NIzPzjcSCJrTs0i9ef?=
 =?us-ascii?Q?KCUAntMOOFG2/qPaNgPeivUV+v2cTSlZqwrQtMvlSSDO8FQbwxjG0f42urFW?=
 =?us-ascii?Q?OM0wgK9NhpNbKT8VvCnEeGx3Nj6Rf5MzpTQXJzGokjPJcoyIgXB0KPwOXr70?=
 =?us-ascii?Q?TA5/E0pvFGyXkClDDSl+3PJauYUteBdQNlbxY3/lQlhNvOP4Bn4UvpsE+xit?=
 =?us-ascii?Q?CB27N0fJSXhuX0A33HjPRslB/1jhaNPsxihXqlOoRaESQyzOVDZFwLqdt4r7?=
 =?us-ascii?Q?42PmMHzxzMlhcNUNG1mo+o2l7YHYy+/4XEJ4RkmH9l0eAsYPVHziqmAYKusS?=
 =?us-ascii?Q?iOneqLDcegDpVO+JwJ7kQfRj/q3NZP46R3g5cGCeoEtNYmeSiDP5KABd6Wj8?=
 =?us-ascii?Q?WgzE9bx6ddXKt0njF2bXa0h5cjWyKb0nnZvZYnn1r1cxVildEjnKO5ju5QUj?=
 =?us-ascii?Q?n3fA6mpAaSACM0KFPrZpeagwwhm57VTdDylvTgXXTGH5W1sNbnNPKbQHaK0H?=
 =?us-ascii?Q?AXMmxbvy8p9cLuQ05cmNgn98diEyFnsxtmpdMfPchXlPWx9FfTTdcnshV9JK?=
 =?us-ascii?Q?7YITH/osRZhwFut+UOR0bUpm4ES+ctakJ42EtUUjxYqhOcAWmVEbh7uX9mdn?=
 =?us-ascii?Q?gpeWucGy7LqcfEi9/Qm7XUSKAEOC+hTKMtvmKB3nu6qYl2sxdOQJFelO789F?=
 =?us-ascii?Q?B/6MerLp3/4p+h3V2kpZZqmeolXx/fRLYmlV0T8YSXznLnMjJzyPIgn83LXp?=
 =?us-ascii?Q?UU671ilS6StPW227X49naJ46OOpef0+YaGhbkmKo63XDsxX2K2dATbZ3z8YF?=
 =?us-ascii?Q?mpGXjSEHeuVi8+Pzq7RQANOMM/i4d3VGU73RJnUE0GhB9McAJH06qKhf99NL?=
 =?us-ascii?Q?cmhFdp0agqAcqTBngf4LsW2ZW3HROB1ePlln9Id/m1Ay1jjk2Kg1ekvn9Dku?=
 =?us-ascii?Q?tozHit6shVuWl0A0oXYtYdnu2WfRdI/SYM4SMGLFsuxAb7+u9MUrTL/s9NQQ?=
 =?us-ascii?Q?sZIJdyDWEGf4Zw1LfIThfIT7SVe52QrITU9BSTNFDNACj9sJRIdL1KerV6xo?=
 =?us-ascii?Q?VyLZE8VdFcsptOwrOCWSx8OrFQ2EwiLLFVsUFqORmSeE2sdpjmK7kCMy7rZV?=
 =?us-ascii?Q?QEde1Ztv3UoPk327aK3OB6+FI9Gd2x5qtyK86Vtx5Fyl0/IzBcGzYhPEU7N5?=
 =?us-ascii?Q?Tm/zq7CFxSnuF2jl0183Fh+ew0FUKkzKVZTfggyaQR/p2UxI3UuehfNWGcSa?=
 =?us-ascii?Q?2sWBHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h1vwfh1Gu9p1i8Hy/F9xlRlRgj6CWVWA9yTHAXUwm1Mtz6zKrjTb2GMOwGKRhonzQCcLNHWD6TpGNEUkSPRlywFo0b/3LS2/LeSebSK8W8VvOyMaFUufuQ0Lw6bJbmQm70V9Dfbj3F/pLxO2J6r6REkbINpdzEQjTY4WbexLC2/EqPlxXQHUTbINEhYF+K16o9a08opMXm0TfgvhnGJxX+x4L4Ybdcifilp7JZTmxM1XJkMPItONE9Zh/U/Yt0aRRYVlpTHqma4IfUny8Dg2erC3/75M0gb1dkXYgpyoVBOsEoXq56bJuqCkU7Cwv7mSu+E1q7xdT4ARF98jnRv/mZxp9zxsgs7fn9uBdOSlsJUd9lAC77WBeUYf870GkFWTlj8CdPwu92qIhdVYugeheWjEWNzAvYcFPf0Fk5HyPo2Z84hmW+M6qfEt1zBKr87P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:13:06.0845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cfc659-de38-4e28-cb56-08de62da883c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704
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

add initialization func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 15 +++-
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 84 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
 3 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index fe188a5304d9..1eba279a020b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -387,7 +387,10 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 
 	ras_fw_init_feature_flags(ras_core);
 
-	ret = ras_eeprom_hw_init(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ret = ras_fw_eeprom_hw_init(ras_core);
+	else
+		ret = ras_eeprom_hw_init(ras_core);
 	if (ret)
 		goto init_err6;
 
@@ -411,7 +414,10 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	return 0;
 
 init_err7:
-	ras_eeprom_hw_fini(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_hw_fini(ras_core);
+	else
+		ras_eeprom_hw_fini(ras_core);
 init_err6:
 	ras_gfx_hw_fini(ras_core);
 init_err5:
@@ -432,7 +438,10 @@ int ras_core_hw_fini(struct ras_core_context *ras_core)
 	ras_core->is_initialized = false;
 
 	ras_process_fini(ras_core);
-	ras_eeprom_hw_fini(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_hw_fini(ras_core);
+	else
+		ras_eeprom_hw_fini(ras_core);
 	ras_gfx_hw_fini(ras_core);
 	ras_nbio_hw_fini(ras_core);
 	ras_umc_hw_fini(ras_core);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 4a1b966d22fa..4362b8a0f3c4 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -369,3 +369,87 @@ int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
 
 	return ret;
 }
+
+static int __check_ras_fw_table_status(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	uint64_t local_time;
+	int res;
+
+	mutex_init(&control->ras_tbl_mutex);
+
+	res = ras_fw_get_table_version(ras_core, &(control->version));
+	if (res)
+		return res;
+
+	res = ras_fw_get_badpage_count(ras_core, &(control->ras_num_recs), 100);
+	if (res)
+		return res;
+
+	local_time = (uint64_t)ktime_get_real_seconds();
+	res = ras_fw_set_timestamp(ras_core, local_time);
+	if (res)
+		return res;
+
+	control->ras_max_record_count = 4000;
+
+
+	if (control->ras_num_recs > control->ras_max_record_count) {
+		RAS_DEV_ERR(ras_core->dev,
+			"RAS header invalid, records in header: %u max allowed :%u",
+			control->ras_num_recs, control->ras_max_record_count);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+	struct ras_eeprom_config *eeprom_cfg;
+	struct ras_mp1 *mp1;
+	const struct ras_mp1_sys_func *sys_func;
+
+	if (!ras_core)
+		return -EINVAL;
+
+	mp1 = &ras_core->ras_mp1;
+	sys_func = mp1->sys_func;
+
+	if (!sys_func || !sys_func->mp1_send_eeprom_msg)
+		return -EINVAL;
+
+	ras_core->is_rma = false;
+
+	control = &ras_core->ras_fw_eeprom;
+
+	memset(control, 0, sizeof(*control));
+
+	eeprom_cfg = &ras_core->config->eeprom_cfg;
+	control->record_threshold_config =
+		eeprom_cfg->eeprom_record_threshold_config;
+
+	control->record_threshold_count = 4000;
+	if (eeprom_cfg->eeprom_record_threshold_count <
+		control->record_threshold_count)
+		control->record_threshold_count =
+			eeprom_cfg->eeprom_record_threshold_count;
+
+	control->update_channel_flag = false;
+
+	return __check_ras_fw_table_status(ras_core);
+}
+
+int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+
+	if (!ras_core)
+		return -EINVAL;
+
+	control = &ras_core->ras_fw_eeprom;
+	mutex_destroy(&control->ras_tbl_mutex);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 18d6548e2151..cb92e6a63cf5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -77,5 +77,7 @@ int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
 uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
 int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
 				struct ras_bank_ecc *ras_ecc);
+int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core);
+int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

