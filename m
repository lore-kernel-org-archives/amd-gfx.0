Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CA5EE2084
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C3E10E16F;
	Fri,  6 Feb 2026 11:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TUP4+Rzq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E0210E16F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6xkn+mogz+vvIwJVmHXIPNTPbHuQDRo2P0fIpmwP5ktBMQTEzqUoKmyU50CQ1qFIx1S5LExZxoCZUSbOAqiBcQFx8EAIp6NetKcfU1S6I6eblkFFXgwRNEq0PTjCT0AZe5IMhwXbjRE9sRCvYWTqOafKyBA4Bx6jLO9IRs/Sd6KnvQbJ5IO6sBtiSF4CT2l/GP198iRJlAe24fBLHHngjJZnRWeub9SV+gfim0q8SLP+2Oin5Vy0XCBF+3qBf0ywHZgtLuQQsDVFmmjjWRLaW9/gGPC/UCDjTpgEXQmtkZN4dH8SDL6iUAUMb4Igr+YT5xMDre0kb2OQiYiE9T+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZHejeezazSwzjun9Of5zeF9PxN/Mlpm8b5T9xswfH8=;
 b=S/iEfQJ6DvA4SMcm2OfGUpwf01OOHiXfOUA/DjyaRRFpLOx6oqoYGf7r0mZepuq3o/B7hbxfdTbEs1boXNEs4wXugyyY1P07ixn4LsGVwlRwykXorzo3grFX5NV9ew0e6I38d/F76maP4mNZrbvL2Bisa3Eg1Gn95l+EixpGW6bVUPLlYjYGkPBu07Fwm5H6+rgCSVHKLxc0gn8kXq7hL3KTokeJgA1FBfiqW6k2UUoYIEJVlAgBAEuI52QixDlW4q0B2zGldL+i4g2I1cYMnsSrRTQgX69I4yq/X25URUkpdCp6KYX2+uO2t+luYSniUOlQyR3YxkWM7lVfdKKZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZHejeezazSwzjun9Of5zeF9PxN/Mlpm8b5T9xswfH8=;
 b=TUP4+Rzqngo+2YfxgcabvI4Ua3+4TCuDBdh8KJcj3DFIJ7Ltc1XiqJ4z7JtONY/anKByhxbr2aOz1qT2CKbj1TsozNUuhkVixUFuri7fPryEBmuMjHKV9qxBZaU3Njj/LHKXmAYFvmOwInNKykMqpFJeoeTggvU9KGm2B76gwBY=
Received: from MN2PR06CA0004.namprd06.prod.outlook.com (2603:10b6:208:23d::9)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 11:25:13 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::1b) by MN2PR06CA0004.outlook.office365.com
 (2603:10b6:208:23d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 11:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:12 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:09 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v3 03/11] drm/amdgpu: Add support for update_table for SMU15
Date: Fri, 6 Feb 2026 11:24:41 +0000
Message-ID: <20260206112449.45381-3-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6ba5c8-50c9-4951-60b9-08de657264f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lGJA6XDUn6w6t3uZkOc1XHXauJvMnlSpIWBwRZ3zpdlvgVjUj4+ymmTZGaBt?=
 =?us-ascii?Q?uAkKdWRUYksqsacb+iDO0eAN67nkxR9ZNw5xOlIZyCxXFsdBh9XMzrDnubKp?=
 =?us-ascii?Q?7A6XfQ1JPhgq1wOPOZ/SaLqLnVw5yfxdM+9blz8b7I3voFv29yYT6OtvmDVD?=
 =?us-ascii?Q?tHsQ/c4zrxPRTZ2V4Z4m8gN2pPqVsK1xlu60+Cve46omo9t5bOc2FKF9afRv?=
 =?us-ascii?Q?imRtJCWdpnpIOI+mUyUzXFiIfpr1zqLf17GEqx+GCjbxfs/i/MBT+4Mut6xN?=
 =?us-ascii?Q?hoOSOUuUVMNbXy82vdHulGbd0/qhpJlrrA8S3Wdgbn34vFxctTyB9G75qfpB?=
 =?us-ascii?Q?VeA1wt5YPiJb53iyVa2vV6o/h0GDtSBNMweD6jeTJrWXQ3lPfSWz5jL9KMAl?=
 =?us-ascii?Q?g5ri/sH6tXrvbBuPuch9O2Ih7kh8mOGtwmSEM0/GKqlpNO7hg7eAqsOgyUML?=
 =?us-ascii?Q?b9Gzb64o6HOc+2zZrTLzYvSM/yoBrbMwrCJLpWYejNpy7xXU9dgPth9CK6O9?=
 =?us-ascii?Q?FQxYKlvHOwN1byLVrOTleJ8crxKkGZFxNt3uw4k3Fz6nPQHyTmzoJG2AfReb?=
 =?us-ascii?Q?Nj+xfUjBhtQAjBZpbvyeTl2MoBBGh9I05pi8aifSdT/PoOARjb8NXaxy8cKt?=
 =?us-ascii?Q?xgC1TAqVmHQrKcj1VbkNG79360fV4p73yrpXVMJvV3fRTEY9Rf920GPSdB4q?=
 =?us-ascii?Q?KwOdkBnxdEY610cLuy8klEkypV0ErY2by7iwMCyMlVUfeVwy+bLkXaW/oPKP?=
 =?us-ascii?Q?k17c9W+VCiTo0OjKIWxv3z36f9MnrFhuWCnvS2MpyhwoZmSgEB+BzKfE3pPs?=
 =?us-ascii?Q?TK9gusLvU8275Jk6H1Rk87RCGgKkAOSH2z7amEhL91J/qWYXiYZKLtqAxqRZ?=
 =?us-ascii?Q?C3KVsId8C/f5Wc1mEJJ6nIKEmpSVHiDHqoINjOtn9LI+kSaMsKVLAcCmQKVu?=
 =?us-ascii?Q?OIxZOxpNrIMHAUxh9nN/djG0vspbq+2NL0CVMgcWkf7mnpJf6eBdv4yj73xk?=
 =?us-ascii?Q?QsT2tm1tOj7C5vXOih8Al+vBOt5M2MTWn1/w8AuyQTFrT9IUKKAPmsvolzth?=
 =?us-ascii?Q?YDWBT9+uTJhgrhSCGS/RauVkiaKuBzb0DVjfTVBJPsaZ9EiFc05TtcSKxBAm?=
 =?us-ascii?Q?pQRnr/ahoRrWtXeW2a6Efo0OG2gE7hKdvxHsKw2Gim7rOZULiwaJykrBhcJf?=
 =?us-ascii?Q?Jq5exCRRfLsbQnkgysVh2AnO0UJ5RKqErb75CSuixrjtzBUmpvp94kMBnmV2?=
 =?us-ascii?Q?9TdBXrxzFOIuyYCC7aipH2Wudu+ELOVR2pfss87Gt86fTn+NNjMr1VY39gPB?=
 =?us-ascii?Q?CvJZ+pc5JK1HfYjpkDmrZ3Qa+aEpgjkVWY4lQQzpiNRVtYEIpNbq/cNvFnkv?=
 =?us-ascii?Q?V8DNXqak5h1t6fu92m8kdogWFqEc3JQM2M9AscE9i7AegE2PSalzenQ0kxVD?=
 =?us-ascii?Q?jK3HVCn3zkHiR5anMyRUoCJaeNQoZ1ejU7Gsihy0Y3ZqXvgYw3mGB9bN/Cqt?=
 =?us-ascii?Q?Sg52+kb66w5dmzM8ZvgBS8KXePlIZzAFI+iFAGIr3e0de43buYIh2PKBQEvr?=
 =?us-ascii?Q?U3dbsU/Z45T9U/tEZpzMor126hxBXFuNzqEpVwpbKfnauzr28FkhQMqnPDWk?=
 =?us-ascii?Q?q2qH4DRYD3MbMl/axfA8p+P9AtJ+GbOq5fuQPIUr3Stv++esWIvEEdhDRk3I?=
 =?us-ascii?Q?eaDWlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xj7mvyI1cjdFqysx1VuoUcIimxXkgF4t9dZlc506MXlxy096/VFPHbtcDdGH5TtncDzlqxJIUxpxKJFjjBTE/cie4HcBDwQd/mSXshTgo/G9nEIPu1Ti5E3x/tkdEcBgVHiwu17pUxJIrCvkoUbth4ucHQy97mrKAVXPbP35Xfii+oU8yCBgtid2+8GD8mceHG2WUkhbv9/0+UgA6l1ExTMZ0qCLQFzxHZMQRxzjHFhhGZO5szszc4wPZT8+OTduyLx7FgZwh1CkW5gw1hZUdscYkT+tDdOdEWVYskNdgFMDRAAPL6uZW2VKwSu9+Wh57MnAr66iGtjqYccox+4tw0m/+jBNtoWhnSwRLOOxNTmGsfgwBk9rkmOTVyN7rGBoKgaEh9rvA6pXbKp628AaisJuAuFZ6WSABkjYFaUhSenL4mfk2R9Js15jfD6pmV3d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:12.6979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6ba5c8-50c9-4951-60b9-08de657264f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
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

Add update_table for SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  5 ++
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 64 +++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index 14e8d8c7a80a..af87c31ca9a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -241,5 +241,10 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
 
 int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
 
+int smu_v15_0_0_update_table(struct smu_context *smu,
+			 enum smu_table_id table_index,
+			 int argument, void *table_data,
+			 bool drv2smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index a2854d528bab..22d0a543a0e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1726,6 +1726,70 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 	return ret;
 }
 
+int smu_v15_0_0_update_table(struct smu_context *smu,
+			 enum smu_table_id table_index,
+			 int argument,
+			 void *table_data,
+			 bool drv2smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table *table = &smu_table->driver_table;
+	int table_id = smu_cmn_to_asic_specific_index(smu,
+						      CMN2ASIC_MAPPING_TABLE,
+						      table_index);
+	struct smu_table *memory_pool = &smu_table->memory_pool;
+	uint64_t address;
+	uint32_t table_size;
+	int ret = 0;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
+		return -EINVAL;
+
+	table_size = smu_table->tables[table_index].size;
+
+	if (drv2smu) {
+		memcpy(table->cpu_addr, table_data, table_size);
+		/*
+		 * Flush hdp cache: to guard the content seen by
+		 * GPU is consitent with CPU.
+		 */
+		amdgpu_hdp_flush(adev, NULL);
+	}
+
+	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
+		return ret;
+
+	address = smu_table->tables[table_index].mc_address;
+
+	struct smu_msg_args args = {
+		.msg = drv2smu ?
+				SMU_MSG_TransferTableDram2Smu :
+				SMU_MSG_TransferTableSmu2Dram,
+		.num_args = 3,
+		.num_out_args = 0,
+		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,
+		.timeout = 0,
+	};
+
+	args.args[0] = table_id;
+	args.args[1] = (uint32_t)lower_32_bits(address);
+	args.args[2] = (uint32_t)upper_32_bits(address);
+
+	ctl->ops->send_msg(ctl, &args);
+
+	if (ret)
+		return ret;
+
+	if (!drv2smu) {
+		amdgpu_hdp_invalidate(adev, NULL);
+		memcpy(table_data, table->cpu_addr, table_size);
+	}
+
+	return 0;
+}
+
 int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-- 
2.43.0

