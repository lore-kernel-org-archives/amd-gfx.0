Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3965BC3601B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3782310E824;
	Wed,  2 Apr 2025 16:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qt676clP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4906810E829
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+RvHk6oBzlBX6XNd2Ry/ZLBXtNzxjGRZ9tBr1ZNutA5HPtZwPoiPQA1K5hgF9taElXghRRFXg6wpGRr3LLC9XgliVf4QXvPotrKVPAq62kBtNDBO3iY8XGf8nuMECvqvju54zwXqrk9xtJ842i1c7iGyI/VOdyZ8vgB42wPU6z6WUSRgf/cuAqmwEzqzB0LcrXZULHDTRc1GkFysa3PjWpCgngzS7DMUNxGADmfexX/rRneq7pQ8VxK0zQH5AUiOrhWjAMJ0M2WYWonxg69CLPZBvY5PLybbkVjQe7zOP6KXC/uqxr8n0gzUuA/F1HaWmb1XAmFPUUiv9o/UFQ1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0+kOrDCqLWTz1nKOXE6CXV5aOe8/p4ISvOrW4X9b08=;
 b=mL2M2jiAkg9eGmQwQkLKvfXLjFIqMXfwiA1OVAurYD2vIEmC7/cZqtVJ5NNhKn/6R8MQMtcPttcj+AgrPhVUBdaQ3om62MuVesXSSsEBlFTN78xJbilnGLQltiUvl7X54ANGSZbENuav336Z/9IVU6PQIOUhasm17xdApKail7WF16Glsa8zJp5FO/jobRhdIBBdPLn0bwEyQPKd5U98lnutbmYoL9dLZQKnsIX55uwTAJ+LIMy7KkanNzkV7AQ9veIv10bFRwDBgw4dr+uMTQldse4ctdqKT9rsqW/v6DnliO39CTKiMSrLCF/Nc8ERq7azDMgEZuJ0dUXAZ8LgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0+kOrDCqLWTz1nKOXE6CXV5aOe8/p4ISvOrW4X9b08=;
 b=qt676clPcZZ7V+82k1eqZjeIcFjG+75qibJRosvvhxXWN9YkoD4tiuByGSq7Zu7SSkYdM46Gy7WjnhiByKMiSfn9AAJCiICnKNgW+H9JliA9tpeg0VhiFDOm/LngxWTlVeAQlxy9SQ0WOUcYncFyhv2HpigD2PrRofHCh6+ww5U=
Received: from CH0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:610:cd::29)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 16:13:45 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::b8) by CH0PR03CA0114.outlook.office365.com
 (2603:10b6:610:cd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 16:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:44 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:44 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Kevin Gao <kevin.gao3@amd.com>, "Agustin
 Gutierrez" <agustin.gutierrez2@amd.com>
Subject: [PATCH 11/16] drm/amd/display: Add DCN301 specific hubbub init
 function
Date: Wed, 2 Apr 2025 12:13:15 -0400
Message-ID: <20250402161320.983072-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dde808-3332-4e66-ced5-08dd720157eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dPK74np2anzhf2WrGmFI0trC7eAR7QQLSWS/zNAv76mxejp1CjkfmW2rdisX?=
 =?us-ascii?Q?TwdxTwCtQdG6B3/zsHKCb2Ltecs5GF4jAx34Qaj12Rb1rF+suPVUylxW0DF8?=
 =?us-ascii?Q?rj0oLIq/PiqwGjq4JgPZezvKEe6dAUtcJNBJS+yiBH8U6L1dhxQsIDWQPRio?=
 =?us-ascii?Q?Z/Uel5CN86YnLju2K6iJq0ngrBu+IYAs77Z/dNz3b7WgVheIHm5lCeK68Qnb?=
 =?us-ascii?Q?AYzeeOceAFRSTs3HfviXhfmbwtYVrht7VeZuRB2VZkAXG9AfeoNanmsdUTEV?=
 =?us-ascii?Q?lOo8tmZ94POCPy6JmnXIn+tcOpFfYTGtfNp4XQZRyiQevyetSy6v+n4/CuuG?=
 =?us-ascii?Q?8f0hgvqCVlv2tq4svTgOaa3bH/ltMN51txQkN9ShYwFHnxKIZMa7zie28YrU?=
 =?us-ascii?Q?EHd1aHevSo24tD0XtzBJDLBKQVFf7anZLqZ6G4AY4NsrfheYCoIdeAX99zKH?=
 =?us-ascii?Q?jMrWhhZIPFt+fgXlqCIwx6F36yvVBSp1cENjqFzXp2PeXk4p6DHkCOzwviQn?=
 =?us-ascii?Q?Ets6G2YT5MU+OkenhILAQMgvMav3lWXQk+NSYz/2sg5MYfMAnrrs43DOZssg?=
 =?us-ascii?Q?sq/+pYzwsxDjEBMoeRu3W8YNJDg8O9ADXGK0RPiTRukZzsnqSb/jpum90PnS?=
 =?us-ascii?Q?vlS0QzekMh8TaD58ZWPbX4GGQmiS5tgagVKokhJgr5d5bvWsfYCPRF+FHLQN?=
 =?us-ascii?Q?30d4v9zRLBJR0M9jYtJ9d2HBS8raMeuGw2HIsYDAM7rbX5j1+iW1RYH8gLeK?=
 =?us-ascii?Q?aRWzWvwJ21hA283Ky9u2Xxgetu47b75MzlcFuDCW7acrupc6Ezr5Mfbaa8SN?=
 =?us-ascii?Q?NfBM1vyGJWN4BAbTvywem3O0MX06HCh4A6XScLQ7t5EFUzuXX66J78PsnTfe?=
 =?us-ascii?Q?doJ4J3Zk15dBOseGgXjAO3tVPJSpzh547OdeAoHDO7ZB6Cpz8r/tdkigByK2?=
 =?us-ascii?Q?XVG9fOMCaoZwjlIIwt1e6N+ikXaY3Fpt/37NEn7/zRa9SvGLHp2UD5dC8vW4?=
 =?us-ascii?Q?C77qP4MsLpHYhakoS9NY0s2ZTZiqxotbeBeNOZ4gyns8oldwsJvvm1CwTnba?=
 =?us-ascii?Q?7M01Jsb5BoRVGTMo0JeHozzXIN8m8RlB/rqeXaKCTkGdABkVDnJnq8F//uXo?=
 =?us-ascii?Q?VSSpcgF6+3D4vkk6ZVrFNdcbMurJn+FCQAFp1dElSN0wWQC24y0YOdYA+OUv?=
 =?us-ascii?Q?FsggbXPPXUstO6NwqWMSCWGUF0FtpTjrF2vBDeT81DkPTVmbYtAxuwkIZygF?=
 =?us-ascii?Q?08hgFq9wolcNFaf23EctytFlhlMpPj6HvJmDIWTj9DucjftZSEv9GW/dyvu3?=
 =?us-ascii?Q?yste66K+PBYxZDxMPZc+irme4XvEAeAcy7VYUC6y1X/RIR9ze2sb+38brOKo?=
 =?us-ascii?Q?u1ekNNVHO+5xN8RbGNwYGLnNIU9+Q8PZouyvwWaUsMCcmgCysXVSqKoRO7Wb?=
 =?us-ascii?Q?rdi5rJNfjAAwshE+69YiwIAN1Gubkk+x9xJaEWpy+oIFr2FrBja7tt0Kd9sQ?=
 =?us-ascii?Q?aDdGIn9T6qXD3tM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:45.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dde808-3332-4e66-ced5-08dd720157eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
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

From: Kevin Gao <kevin.gao3@amd.com>

[Why] DCN301 needs specific functionality
[How] Add it

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Agustin Gutierrez <agustin.gutierrez2@amd.com>
Signed-off-by: Kevin Gao <kevin.gao3@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/dc/hubbub/dcn301/dcn301_hubbub.c  | 34 ++++++++++++++++++-
 .../display/dc/hubbub/dcn301/dcn301_hubbub.h  |  3 ++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c
index c1959672df50..95cf0ff43a83 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c
@@ -47,10 +47,42 @@
 #define FN(reg_name, field_name) \
 	hubbub1->shifts->field_name, hubbub1->masks->field_name
 
+int hubbub301_init_dchub(struct hubbub *hubbub,
+		struct dcn_hubbub_phys_addr_config *pa_config)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	struct dcn_vmid_page_table_config phys_config;
+
+	REG_SET(DCN_VM_FB_LOCATION_BASE, 0,
+			FB_BASE, pa_config->system_aperture.fb_base >> 24);
+	REG_SET(DCN_VM_FB_LOCATION_TOP, 0,
+			FB_TOP, pa_config->system_aperture.fb_top >> 24);
+	REG_SET(DCN_VM_FB_OFFSET, 0,
+			FB_OFFSET, pa_config->system_aperture.fb_offset >> 24);
+	REG_SET(DCN_VM_AGP_BOT, 0,
+			AGP_BOT, pa_config->system_aperture.agp_bot >> 24);
+	REG_SET(DCN_VM_AGP_TOP, 0,
+			AGP_TOP, pa_config->system_aperture.agp_top >> 24);
+	REG_SET(DCN_VM_AGP_BASE, 0,
+			AGP_BASE, pa_config->system_aperture.agp_base >> 24);
+
+	if (pa_config->gart_config.page_table_start_addr != pa_config->gart_config.page_table_end_addr) {
+		phys_config.page_table_start_addr = pa_config->gart_config.page_table_start_addr >> 12;
+		phys_config.page_table_end_addr = pa_config->gart_config.page_table_end_addr >> 12;
+		phys_config.page_table_base_addr = pa_config->gart_config.page_table_base_addr | 1; //Note: hack
+		phys_config.depth = 0;
+		phys_config.block_size = 0;
+		// Init VMID 0 based on PA config
+		dcn20_vmid_setup(&hubbub1->vmid[0], &phys_config);
+	}
+
+	dcn21_dchvm_init(hubbub);
+	return hubbub1->num_vmid;
+}
 
 static const struct hubbub_funcs hubbub301_funcs = {
 	.update_dchub = hubbub2_update_dchub,
-	.init_dchub_sys_ctx = hubbub21_init_dchub,
+	.init_dchub_sys_ctx = hubbub301_init_dchub,
 	.init_vm_ctx = hubbub2_init_vm_ctx,
 	.dcc_support_swizzle = hubbub3_dcc_support_swizzle,
 	.dcc_support_pixel_format = hubbub2_dcc_support_pixel_format,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.h
index b599f4475479..e30573e1ecfd 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.h
@@ -50,6 +50,9 @@
 	HUBBUB_SF(DCHVM_RIOMMU_STAT0, RIOMMU_ACTIVE, mask_sh), \
 	HUBBUB_SF(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, mask_sh)
 
+int hubbub301_init_dchub(struct hubbub *hubbub,
+		struct dcn_hubbub_phys_addr_config *pa_config);
+
 void hubbub301_construct(struct dcn20_hubbub *hubbub3,
 	struct dc_context *ctx,
 	const struct dcn_hubbub_registers *hubbub_regs,
-- 
2.34.1

