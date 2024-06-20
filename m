Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE43BC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 13:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FB710E9EC;
	Thu, 20 Jun 2024 13:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NiW36YQL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B142F10E9EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 13:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bryoEd7drL3qMl8QsttFBWE4J+Mhx/UJ4mJhohdJbjIpllndAqUxeYcWRJYtOBQJ6tvfmQGnW/HUFKYPFSlX4H9Y3tpMxd1ukH0RvRNjDTEKfqaB1jgZYAzsJxGVCA0WeLP0iN/AB4xQCjH4Hp1WMNO2mQ5Tj0Bkag/Y2CvB1ThBI/vSesxi0niBNErj/GglGh1iMewAl/BF982jKqqHvi7wTJA/h9oTRy/NwDIcqQYKpryAgMVYHzEu1gabwHFaltbPyJGgLRxFxT8MQ37CE9oWQLWO62BqZ/EMcCAucaUtPHDr49CVN+PRhMrFscO1Mr5G2whshdgnNfDiSGsNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vptk9YT5aRPr3IU00JQg9A7+UCZUN0tXmf+iZtKvwg=;
 b=X8OJ4lND1uYoCKy0HztVNlDQUmY8Dtx+wzk4LWJVS9bhScS1GA03FdBDuKzDmANRI2gg6/CEzosvDD3HDpokFMsTIQkl2wHpKuG/KsGSjIDshQ005Y86/b4Cj36PjAcvRe9tEJLl2Mur9jXjVeJn9Jp0oJJcHcPy2X/YU6rgNiovvyJ3vtcptHua3Z/zPey6gdI0SKwAJc110BUACfC6GwNHGcHKdI3noSzGZWDLm6wb9UfIiHBeIW6pQXJJNd4kyuxdwWZ1zUr3JU9vny8aGHbQseqeAkpDFvTuzVUJXR54+yCLqoIFBJzYqebD2TS+yQvA1sozfU/HotfE/PwuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vptk9YT5aRPr3IU00JQg9A7+UCZUN0tXmf+iZtKvwg=;
 b=NiW36YQL/r9YQ29fHBrzphgGpuq/+C5LM9hI7mzVFqlru61N8xPvXthx+dtbbzDh+qqu88LDUFtxSNLLcp/w2DqRwrwOf17PpMqYxNM5cbHnlzPjIlDIimtulfNXwgHCJqG8kfr7l/TzfEx7PK9Eh1j9mZ2VSKPatVixl34ViHI=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:41:35 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::c7) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 13:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 13:41:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:41:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 08:41:34 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 08:41:32 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write
 under sriov in TLB flush
Date: Thu, 20 Jun 2024 21:41:32 +0800
Message-ID: <20240620134132.1736532-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e5a594-f28a-431c-4d24-08dc912eb3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gRzX6FNh+njw0yWswrLK7cA2Swhf6SI70j99N/uNvpGu4sOZbEPPusDIuC1n?=
 =?us-ascii?Q?GhDlT1QNtHZEpa3jyXICVUQS0vb19WlYjoYc3UsJmpMs/RyJnJkQEZtdbs6Z?=
 =?us-ascii?Q?tTS/IL+Kj6Gbu+MeNR9S4cdCuiENHbLxww7r1af1NpVbybSVzztJNWmJsX0r?=
 =?us-ascii?Q?nhS6KUh5+IQQwuCbata7D+HpV1iSQi0zWUwoeNdr6QjwVyFTtvf006A4MD0Y?=
 =?us-ascii?Q?Hn4XuvATHoddo87iEn7mld8lBcvDQTOqf80yXiGj9iWHfPzjIit/lBzwHBJB?=
 =?us-ascii?Q?T5kSs1ivHVcQxBw/0eR6qEQOZ+de3caDkctlO1AtR4JAiqxldBZwFdpMwBGE?=
 =?us-ascii?Q?tqUUo1KmPfFUqWhgxLgVOQ4nvyaAUAjsL2C9PY9kwc8HKqm+vXiomFuCwOJz?=
 =?us-ascii?Q?KFt1g7f5qwudoIze2ViePe8YpzJFrdSzAwtUSgXp+2i09GIKHah0jPGl9f78?=
 =?us-ascii?Q?DI4ytZGadzKHhLZd/8qRR8IMnwpLwn5Um6rzU6i7nwocurUXBHI2zHeKhhwV?=
 =?us-ascii?Q?oSIk6PjKJ/7wxQV28aZJnqJ8OnMFmWmbBI6Ci+SWaqs9L2UdcLdjqTqTAH0N?=
 =?us-ascii?Q?lXwrR4vPT25Awn0DrhdiQdiXpK5Y4pOIHhBenaqY51IJzjQKDpvSn7Uh6TA1?=
 =?us-ascii?Q?MPneUOBfnhWALZCiYfxvpVfxPm4zQ/2vLt3jn6YCOBsLHvUE7Q58EWxS2rPH?=
 =?us-ascii?Q?frEe+q4KY8FqrIqWwugF3sOcuWCoplsYV9KSGPq2pX69/eohSy2NCn06BgkD?=
 =?us-ascii?Q?4wLSbQNHIOP6pVyP4rs3uP12yeXJBnnnG48McIcAJklYk6HnaJsx1gtdqKFP?=
 =?us-ascii?Q?5PmQS7SZtiLRfNTjjCgYxLBLEAB8S19iQZC9ZhLRtT/B/FKOQhRMjaQOTjtJ?=
 =?us-ascii?Q?PKWac6rL1haf5ub7zIA/ZPYsJqx5N5fqaI/7uVmxZqH72dBJbfNRrxaOc24+?=
 =?us-ascii?Q?c3rqp2SFm9O+r2ZQMeUcmIr7GUiFm3KuHTVdCqUxrUp7zuFMG8T+WxnOTHfK?=
 =?us-ascii?Q?I8MfnRYHC5g6TjiQbSDo0K93d+1taXqLHqtFSZ2g2Pkdv1yDshkhOqUGpzfy?=
 =?us-ascii?Q?/eaBq1SAzPXbQr7P94jHgnUjGYhJixvlBul2HwlXnVNIvTJpLns6c8OCVyRo?=
 =?us-ascii?Q?K5xJJrY9UN2BHZgRbTF1ph+/WOg8eXmL8ZhoBUEY036N1KU2/sVTrmEWFzUV?=
 =?us-ascii?Q?JwG/SUqHVdK3ljjJeshI7g9frMOeR66Macv/duwVKpAkICJsOnYkCPfvEnlI?=
 =?us-ascii?Q?0vAaEAbswh07sd37pZgqI1GG2NQNfIqwuq21JZ6P12NsdWgzJBEJBcc97Tio?=
 =?us-ascii?Q?JCfN8eXp7pD0W1FAQM7s7dOuKwHMRbX77iDNTGTD3zWg2iC7GTzT5glX4fov?=
 =?us-ascii?Q?HbdbIMZzKdnv/iOt52r47UEcluaELYNpPNB1GY7wayOoKTEYRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:41:35.1855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5a594-f28a-431c-4d24-08dc912eb3e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
RLCG will mask xcd out and always assume it's accessing its own xcd

[TODO]
later will add the normalization in sriovw/rreg after fixing bugs

v2
rename the normalized macro, add ip block type for further use
move asics func declaration after ip block type since new func
refers ip block type

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 amdgpu.h        | 112 +++++++++++----------
 aqua_vanjaram.c |  16 +++
 gmc_v9_0.c      |   8 +-
 soc15.c         |   1 +
 soc15.h         |   1 +
 soc15_common.h  |   5 +-
 6 files changed, 85 insertions(+), 58 deletions(-)

diff --git a/amdgpu.h b/amdgpu.h
index 083f353cff6e..070fd9e601fe 100644
--- a/amdgpu.h
+++ b/amdgpu.h
@@ -583,61 +583,6 @@ struct amdgpu_video_codecs {
 	const struct amdgpu_video_codec_info *codec_array;
 };
 
-/*
- * ASIC specific functions.
- */
-struct amdgpu_asic_funcs {
-	bool (*read_disabled_bios)(struct amdgpu_device *adev);
-	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
-				   u8 *bios, u32 length_bytes);
-	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
-			     u32 sh_num, u32 reg_offset, u32 *value);
-	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
-	int (*reset)(struct amdgpu_device *adev);
-	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
-	/* get the reference clock */
-	u32 (*get_xclk)(struct amdgpu_device *adev);
-	/* MM block clocks */
-	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
-	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
-	/* static power management */
-	int (*get_pcie_lanes)(struct amdgpu_device *adev);
-	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
-	/* get config memsize register */
-	u32 (*get_config_memsize)(struct amdgpu_device *adev);
-	/* flush hdp write queue */
-	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
-	/* invalidate hdp read cache */
-	void (*invalidate_hdp)(struct amdgpu_device *adev,
-			       struct amdgpu_ring *ring);
-	/* check if the asic needs a full reset of if soft reset will work */
-	bool (*need_full_reset)(struct amdgpu_device *adev);
-	/* initialize doorbell layout for specific asic*/
-	void (*init_doorbell_index)(struct amdgpu_device *adev);
-	/* PCIe bandwidth usage */
-	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
-			       uint64_t *count1);
-	/* do we need to reset the asic at init time (e.g., kexec) */
-	bool (*need_reset_on_init)(struct amdgpu_device *adev);
-	/* PCIe replay counter */
-	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
-	/* device supports BACO */
-	int (*supports_baco)(struct amdgpu_device *adev);
-	/* pre asic_init quirks */
-	void (*pre_asic_init)(struct amdgpu_device *adev);
-	/* enter/exit umd stable pstate */
-	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
-	/* query video codecs */
-	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
-				  const struct amdgpu_video_codecs **codecs);
-	/* encode "> 32bits" smn addressing */
-	u64 (*encode_ext_smn_addressing)(int ext_id);
-
-	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
-				 enum amdgpu_reg_state reg_state, void *buf,
-				 size_t max_size);
-};
-
 /*
  * IOCTL.
  */
@@ -728,6 +673,63 @@ enum amd_hw_ip_block_type {
 	MAX_HWIP
 };
 
+/*
+ * ASIC specific functions.
+ */
+struct amdgpu_asic_funcs {
+	bool (*read_disabled_bios)(struct amdgpu_device *adev);
+	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
+				   u8 *bios, u32 length_bytes);
+	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
+			     u32 sh_num, u32 reg_offset, u32 *value);
+	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
+	int (*reset)(struct amdgpu_device *adev);
+	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
+	/* get the reference clock */
+	u32 (*get_xclk)(struct amdgpu_device *adev);
+	/* MM block clocks */
+	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
+	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
+	/* static power management */
+	int (*get_pcie_lanes)(struct amdgpu_device *adev);
+	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
+	/* get config memsize register */
+	u32 (*get_config_memsize)(struct amdgpu_device *adev);
+	/* flush hdp write queue */
+	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
+	/* invalidate hdp read cache */
+	void (*invalidate_hdp)(struct amdgpu_device *adev,
+			       struct amdgpu_ring *ring);
+	/* check if the asic needs a full reset of if soft reset will work */
+	bool (*need_full_reset)(struct amdgpu_device *adev);
+	/* initialize doorbell layout for specific asic*/
+	void (*init_doorbell_index)(struct amdgpu_device *adev);
+	/* PCIe bandwidth usage */
+	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
+			       uint64_t *count1);
+	/* do we need to reset the asic at init time (e.g., kexec) */
+	bool (*need_reset_on_init)(struct amdgpu_device *adev);
+	/* PCIe replay counter */
+	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
+	/* device supports BACO */
+	int (*supports_baco)(struct amdgpu_device *adev);
+	/* pre asic_init quirks */
+	void (*pre_asic_init)(struct amdgpu_device *adev);
+	/* enter/exit umd stable pstate */
+	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
+	/* query video codecs */
+	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs);
+	/* encode "> 32bits" smn addressing */
+	u64 (*encode_ext_smn_addressing)(int ext_id);
+
+	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
+				 enum amdgpu_reg_state reg_state, void *buf,
+				 size_t max_size);
+	/* normalize offset to keep in lower 16-bit */
+	u32 (*normalize_reg_offset)(enum amd_hw_ip_block_type hwip, u32 offset);
+};
+
 #define HWIP_MAX_INSTANCE	44
 
 #define HW_ID_MAX		300
diff --git a/aqua_vanjaram.c b/aqua_vanjaram.c
index 2c9a0aa41e2d..98b00c0e522f 100644
--- a/aqua_vanjaram.c
+++ b/aqua_vanjaram.c
@@ -1085,3 +1085,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 
 	return size;
 }
+
+u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type hwip, u32 offset)
+{
+	u32 normalized_offset;
+
+	switch (hwip) {
+	case GC_HWIP:
+		normalized_offset = offset & 0xffff;
+		break;
+	default:
+		normalized_offset = offset;
+		break;
+	}
+
+	return normalized_offset;
+}
diff --git a/gmc_v9_0.c b/gmc_v9_0.c
index 88b4644f8e96..66fd229c196a 100644
--- a/gmc_v9_0.c
+++ b/gmc_v9_0.c
@@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* Select lower 16 bits to write in local xcc */
+		if (AMDGPU_IS_GFXHUB(vmhub)) {
+			req = NORMALIZE_XCC_REG_OFFSET(GC, req);
+			ack = NORMALIZE_XCC_REG_OFFSET(GC, ack);
+		}
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
diff --git a/soc15.c b/soc15.c
index 8d16dacdc172..e6e61fc77080 100644
--- a/soc15.c
+++ b/soc15.c
@@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
+	.normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/soc15.h b/soc15.h
index 282584a48be0..f1e974604e3e 100644
--- a/soc15.h
+++ b/soc15.h
@@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
+u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset);
 #endif
diff --git a/soc15_common.h b/soc15_common.h
index 242b24f73c17..ddf0aad51821 100644
--- a/soc15_common.h
+++ b/soc15_common.h
@@ -210,4 +210,7 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
 	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
 
-#endif
+#define NORMALIZE_XCC_REG_OFFSET(ip, offset) \
+	((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
+	adev->asic_funcs->normalize_reg_offset(ip##_HWIP, offset) : offset)
+#endif
\ No newline at end of file
-- 
2.34.1

