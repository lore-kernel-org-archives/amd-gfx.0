Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E7BD12680
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 10:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D21810E55B;
	Tue,  5 Nov 2024 10:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VeG0ioVb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E9110E55B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 10:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jltk1Lokr7GCKRKtdFhehu5KP8RZ7vfwtDon14aoKiAj8kNCX6mpvElO5kMVIry9f/rjgJx5oyL3awr0wmUhA8nLR1bhe4bfWrTRH2vwxkMGbtX9WG1LjtkiAHfIKLzJZnUY1hRblXzo2DFQzf8U1fV1zA6FGGpYhd/pddeNgwwFpahMQPazSNeOq5U/EOamBwmLVjB0R3YX9ascpj4Rf7X96RgH/623PELcQqVwwuRVdZ9Hygym9ZKVMXk6EMTcc83TD+QskJuZSMrX+EDTMvFvC1+g8BL/iSJZxPrJxe9xUnb0HDbUOUIwGEpw9d/Hk6LBT/DozbV5VWABlPbHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8T7qw1kBPFrEFxAOzw7qVq4ijreBjsyOXAaqk5Dvtk=;
 b=N+BtbwuStJMw/coSFiLklvasc4/or8QhNi0em4HhFPquMS9DEkV77vM0Qc0zdzFHXMJ5jJEWJAqrHSCJtFP76jWCLHmVJlinQ8cuMiZD1AwYLqHD1DVa5xSmO3mnV3Sq21+s6Ry0NUo1hOioy+OEcm85fhIUvZiMPYOrmnQlKx+PfYN0j4ZSsImvoxp4J1ccjo1TpKk4iaqHwjU2d/42mq7eIjukD6PJXW69jJhuJOpsYkzJ8SCbml0cBQ0LCEkE5vo7a5/iebRZPSnlDgYEsKmcgiaNlWAAHPQgmhY/f0VEgRZHobIKWmHT1WHN44foTWUGiFyuEn6EA5dZ61rfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8T7qw1kBPFrEFxAOzw7qVq4ijreBjsyOXAaqk5Dvtk=;
 b=VeG0ioVbuNCkz9O7U0f0lrn4Vld4ZVc3G1UQukNXK3bZQOmhmgywTbLFNeFVrMH6Ok0gqdMkB3ogP45cVL5h3kA05xvRRXlK6sdtQ87fOu+N8USKN80DxoeOfFNEUdVHeunSqB33rCE8RYlIU+4jwZMoiozajKfpptayFWBgQtk=
Received: from MW4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:303:8f::15)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 10:52:51 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::d6) by MW4PR03CA0010.outlook.office365.com
 (2603:10b6:303:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 10:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 10:52:50 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 04:52:47 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <hawking.zhang@amd.com>
CC: <le.ma@amd.com>, <shiwu.zhang@amd.com>, <Asad.Kamal@amd.com>,
 <charis.poag@amd.com>, <donald.cheung@amd.com>, <sepehr.khatir@amd.com>,
 <daniel.oliveira@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add supported NPS modes node
Date: Tue, 5 Nov 2024 18:52:29 +0800
Message-ID: <20241105105229.863776-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a604bd-312d-43c8-7c00-08dcfd87fe5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jV9icJCngK7T3I3gI1OFmP0C5j/y6iYzYT61W5QVAW9q89GEFxbo4Iuz7u/m?=
 =?us-ascii?Q?Opr5g7hQR4gEHeS3D/etcpQIcQz16CIcHBn0uxyGBs3jm2GIqe4TwT727j+3?=
 =?us-ascii?Q?O+Mw/64pcYQgPBbARuVvxiZlW1FSpXyw1Z6fJcUpcqmtD24r6eFUgYJG8aPk?=
 =?us-ascii?Q?6hVQq5jo1cgYTiNaosCXewa6j3D2y88ojse7US0BJcitAEhZRcrWwZShFb6M?=
 =?us-ascii?Q?ofJiPuHb6+gEkDu2kI21Q3FmYTdT7CfLy4Hl7+Yit9IMGPojlfGJMGbctw93?=
 =?us-ascii?Q?qV6zsQea7s3K1te1SvWVj7OZJUYlT6OEUPsoCPfCRT80+x+IThJmqloA1HSQ?=
 =?us-ascii?Q?Tm1kPqTeHJUDh9BWHMOtmbVh/C0e/hypBHw6Kq8DVwniJ5UIzBnl0W39EseH?=
 =?us-ascii?Q?EmSosrORtfXm6oc31gHDE902+KYAn6jeRm1NP18FjKHaxmfAYHyOE9Lv73H9?=
 =?us-ascii?Q?k/4Z5AudRiK9znpLlleFEqUvSLV059vRNkQZJEW7wHHzsMvj7+zQnLu6n3De?=
 =?us-ascii?Q?XhsBSUgUVgAr+JbpDW+8MSZnfmhzV1QoJd1wV5o4PXhTSiU7B9OB+e8qPcz/?=
 =?us-ascii?Q?f8B4LJ/bcK8EWx3hm43PIVNUNI8zkIFjajT+hXZdSGPtvvdFwIgTsOpbe0eE?=
 =?us-ascii?Q?VytBklSvO3bE9YamzagmEpABHXzLbb96708DIewEhihu1UCPRVC4tKTKzhVU?=
 =?us-ascii?Q?D6xs6i5/f9GGFlub+5pnRxpBvfRnwqpX7A/DSjb34//I+wjzr5Zbvd6t3poR?=
 =?us-ascii?Q?o1/OT0zzNumcP5OnUv8x8O3iZxKpr4+X8EaZLjqEmDnzXv8z/ErRkDTuhvLX?=
 =?us-ascii?Q?6rQKLTN/aFQ0jFpO3U1Ss4dwbB2Sv2pCnVwMiyw3MDEjzNOfDRo0bJOjVDoQ?=
 =?us-ascii?Q?aGROsLq28AimxPRQLEvEFssFYp9L1pYQRpcY7rBKwwBrSqmkF93vGHZ1cq/k?=
 =?us-ascii?Q?c102lR1iFKXcIXEPwAp2RL08OoKJSvQ4QjfyUx/aioIWJk/nhICllx7E3Z6v?=
 =?us-ascii?Q?CkoP1/GCvdjnSVcR1oVxZWYLhAsbn5tiXPTc6GThDTfPsbBTGAs26KbnHNCL?=
 =?us-ascii?Q?YbYdmW0DWFZMftn/bpYED1PhxxBWXHoW0BatRThQOmcQXEgc0ElllV81ko9K?=
 =?us-ascii?Q?A+bOC/78ZqSDY7ixoO+cMCmSae8eu14iaJgodyRziNQLUDTi/D5/FEszQdT9?=
 =?us-ascii?Q?20p9KqCxz6hM9Zo7arOQVo0J+/i00BzT8pXzJMfPY5q+JJg0CMiLujvj1u57?=
 =?us-ascii?Q?K05zVmh1FTBCd8cRknxtJ6qSFBjO7vTKM+Grb4DvtdCJHAddWel0yLS03nEm?=
 =?us-ascii?Q?7LSO/Jz4NTPpvZSr5FJn/MkEnPjirlt7s9vx8VyPbz1ooffpgEYj4uwyGwJv?=
 =?us-ascii?Q?JzkOi3WnQQyt0yAR0MTJSWp+bjlKqzj9d6ifCnAofXYGz+usCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 10:52:50.8716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a604bd-312d-43c8-7c00-08dcfd87fe5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

Add sysfs node to show supported NPS mode for the
partition configuration selected using xcp_config

v2: Hide node if dynamic nps switch not supported

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 83a16918ea76..964667125be0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -471,6 +471,16 @@ static const char *xcp_desc[] = {
 	[AMDGPU_CPX_PARTITION_MODE] = "CPX",
 };
 
+static const char *nps_desc[] = {
+	[UNKNOWN_MEMORY_PARTITION_MODE] = "UNKNOWN",
+	[AMDGPU_NPS1_PARTITION_MODE] = "NPS1",
+	[AMDGPU_NPS2_PARTITION_MODE] = "NPS2",
+	[AMDGPU_NPS3_PARTITION_MODE] = "NPS3",
+	[AMDGPU_NPS4_PARTITION_MODE] = "NPS4",
+	[AMDGPU_NPS6_PARTITION_MODE] = "NPS6",
+	[AMDGPU_NPS8_PARTITION_MODE] = "NPS8",
+};
+
 ATTRIBUTE_GROUPS(xcp_cfg_res_sysfs);
 
 #define to_xcp_attr(x) \
@@ -540,6 +550,26 @@ static ssize_t supported_xcp_configs_show(struct kobject *kobj,
 	return size;
 }
 
+static ssize_t supported_nps_configs_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	struct amdgpu_xcp_cfg *xcp_cfg = to_xcp_cfg(kobj);
+	int size = 0, mode;
+	char *sep = "";
+
+	if (!xcp_cfg || !xcp_cfg->compatible_nps_modes)
+		return sysfs_emit(buf, "Not supported\n");
+
+	for_each_inst(mode, xcp_cfg->compatible_nps_modes) {
+		size += sysfs_emit_at(buf, size, "%s%s", sep, nps_desc[mode]);
+		sep = ", ";
+	}
+
+	size += sysfs_emit_at(buf, size, "\n");
+
+	return size;
+}
+
 static ssize_t xcp_config_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
 {
@@ -596,6 +626,9 @@ static const struct kobj_type xcp_cfg_sysfs_ktype = {
 static struct kobj_attribute supp_part_sysfs_mode =
 	__ATTR_RO(supported_xcp_configs);
 
+static struct kobj_attribute supp_nps_sysfs_mode =
+	__ATTR_RO(supported_nps_configs);
+
 static const struct attribute *xcp_attrs[] = {
 	&supp_part_sysfs_mode.attr,
 	&xcp_cfg_sysfs_mode.attr,
@@ -625,6 +658,12 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 	if (r)
 		goto err1;
 
+	if (adev->gmc.supported_nps_modes != 0) {
+		r = sysfs_create_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
+		if (r)
+			goto err1;
+	}
+
 	mode = (xcp_cfg->xcp_mgr->mode ==
 		AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
 		       AMDGPU_SPX_PARTITION_MODE :
@@ -673,6 +712,8 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
 		kobject_put(&xcp_res->kobj);
 	}
 
+	if (adev->gmc.supported_nps_modes != 0)
+		sysfs_remove_file(&xcp_cfg->kobj, &supp_nps_sysfs_mode.attr);
 	sysfs_remove_files(&xcp_cfg->kobj, xcp_attrs);
 	kobject_put(&xcp_cfg->kobj);
 }
-- 
2.46.0

