Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AC3CCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 21:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AF710E10E;
	Wed, 15 Oct 2025 21:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PlQAoSXO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0E610E10E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 21:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBQ7WtM84dLICpSUZr8YdaJtZ8WqZH/RL3s0lC6gG30WJUSOu9ATZtaD5Q46uAehPfdS6lLWP3EpOMK4aq9Dgg/pVicZ0MhnermWRF8cTFhDIFA8IS9xKDGvhG2hk0qDKCcO8t59uthspMfZEV4pmc6EPijl8L1Iw/BsItAi5StMfXbLu/HrPAVXFH3NXmIvFZWZOcUlpiVjKSYcaHO2vuUliwyfa7Z9Zd/KwA0wYJ/rsmL2a9rxxoZOXoW6C0FYT8KXshdG37iiEqLIlMqJZeVFHRh5wv9FAKHAHruVfEM2lYtcLprY6zYjOfuEnvE+Uvvpt1qG1oM/fDed+4TO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqSyqHtspSnelsh0N6OSqsYLeN6gt2FRup4ELrsZo70=;
 b=j7AACrgmrXurjxIhlBn99nOEK+9WYvqYIvR3NiitFB1jYqf6+UxELCEjz5Rx0HUgk3l3o3z8RiL45CRTFJPnmRCc895vS6duHn+DVg5ip45q4Oe/Iw3+y8p+KbYkUroTmSHg9PUjdS4Z7NYRHWxVRXZty/+xx9zfsv0ytUz4pUjXNXCjD/son1O4jfSypnYhhPS/DbI0TDDEihxfUX6N0g5jHDMr9fBQggAUMPWTWbAxKzvckoN7L9wcFlZiBVOmW82ctq5Xzzqd2hvjp8I8OZ8yKoTmBmhNsm5PAZautn4/bjpKUquBiac6bb8fE0YsvaW/U90o2nhwGLaDOxXQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqSyqHtspSnelsh0N6OSqsYLeN6gt2FRup4ELrsZo70=;
 b=PlQAoSXOEkR2IhF3dr9uehLQGJEJauXXMkY0MyZVyGvkDVkonhUiDc2+JYkSWzH71h6aAl6d8KvgwCuz4q83IvyhhJmbq8GBcOP1zRznelDMurhxGQ+Z1VU9AQFcjkTT018U5qJO8YcbpNYSkvAkPZcbwFmRSF3AvQhmZb3+Iig=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 21:49:01 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::3) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 21:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 21:49:00 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Oct 2025 14:49:00 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v5 3/6] drm/amdgpu: Introduce SRIOV critical regions v2 during
 VF init
Date: Wed, 15 Oct 2025 16:48:45 -0500
Message-ID: <20251015214848.11580-2-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015214848.11580-1-yunru.pan@amd.com>
References: <20251015214848.11580-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e83c373-8cd7-480d-d7e8-08de0c34a6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bP2kiWuVULsU7Qdv8NQErbB7Dg+xfYEHGvZVmKqkqgXWX4MvCg2P4sn7mVw7?=
 =?us-ascii?Q?Rom1AlZk7obdDtmsabJuA/4+QaBDifFtj3D/j1CxElCL5He5KccfethSYq7G?=
 =?us-ascii?Q?oCrDt98OLFTKdknZZc60sCsvHSMMkpi6NuGYIacDsKRsSU3Ho54di05t9Fja?=
 =?us-ascii?Q?q6iw9HXJP3sWSZE4rHVzeS2b+bczeAKmnbhP8iGOgGONrbp/iNbXC3/0x6LM?=
 =?us-ascii?Q?+8snhDHwIsti6PN0gfjpk1xHw2z3SXafZJGlOqTcutpPWHLjVkip2POAdZOo?=
 =?us-ascii?Q?MxZk9B2tEEyk02Hw5DPoHZ0/WKeZW0JXYA3iSZMfxe6FwT5Q1PkFHh7XanVH?=
 =?us-ascii?Q?MIJN2cEQ/0CvC8lnQy5Lh4khPomcfGrrjYbiJHhkHsAB4mWH8scbMZZIoEOA?=
 =?us-ascii?Q?ISOxkuRJa02l+lASvUY7FHBySrAdAoau32Ow3EC8etc25/occjcWVid0hTbw?=
 =?us-ascii?Q?KCzad1U8ZAlYUhL/2az7Mzc7BPv9pFDlENY6Ot7rcuqVCe5yrv04u8pn276Q?=
 =?us-ascii?Q?+sYoBvgj9/sN0qwOeV3acyl7dE7igsEhuuQLznrdYZQ87ozK1t5HS3gdSPh9?=
 =?us-ascii?Q?rM/Y/CE2V74Vn982OdDCnICZlGwMGNaWdg2j8Uvil9mdIvJ7YHdVHr1+cRd5?=
 =?us-ascii?Q?nPlJIWLI8jyYWGrDjHJOW2zWHrTqCGx9QFtyDWFv1n9cvghi2N0af7ecEY2a?=
 =?us-ascii?Q?3zPiwEffFNug6xCYVJS09kXKk4esroMGjRDIq7Oals2dbj7IAshdm8FFGk8Z?=
 =?us-ascii?Q?zR9ed3mmzppbxohScqu3GEtmez+JyqqJrXcCT4fX6jzuTAawoN4cTkbYCktL?=
 =?us-ascii?Q?NjusKMbvRO6NzroEu8XRjkdi7Xxj9LDSa1rjt/9VuKITslzJT41WVLnhh0FS?=
 =?us-ascii?Q?2v1JMyUh9e76V/iwBpOQXS3hZLnGj9N8P9uk3kyDxkkFM3NeAjtkNsuwBAvs?=
 =?us-ascii?Q?f/1gSIxmb9cuk5RmlcMYAkUK+w7voqhxd2LGfRivfAFAlF5y1jz3E2WgkgMY?=
 =?us-ascii?Q?PgBoCOcJ2bZ4XyujTlsH3+JeBXOXS+Uo1qvwe0PTDc7UGYutL9j0uA6oeaSs?=
 =?us-ascii?Q?U7nSmOmzlhKBlwYqP6Cd2ylnC7Ofm10+BCu7juVaEIpzF5iTOtlmptg7UgCK?=
 =?us-ascii?Q?7dB+AwT0imsqo69NdOb0UiTJIXbPAjJJBRxmlYRM7rqVLG/SMcMhXfVdC3Px?=
 =?us-ascii?Q?bAr5YVHuacSmz8j6Yufcent2mdMMuCrFPSXJf6XR1uuGvu+POVhLjQyqpjMj?=
 =?us-ascii?Q?eYLXx3mZNh0Q1z8F/OOFyHFqy1wokkljAKZ5TZPiXpfeUSn3Jyq5iB8Cc+ET?=
 =?us-ascii?Q?cUe2MXOdDm8fx45L5hVpzl9erMe95BvEYnthyRt68uMaNi7oMGh1EGDEoj3Y?=
 =?us-ascii?Q?hY7Q3VWRcLtKCIBtfbFmiMqfJi8oA1PagnSOX8JedG+9vz2wOhU+/FK7uHQj?=
 =?us-ascii?Q?mjwlRFJ/ucpYQcqn9HBOXc0918hnBWAkLPyGUxn9j0l89MYlWSjaIKWCrVjg?=
 =?us-ascii?Q?e7ELGMQIRfxFAXoYhHpnoXC93qnUx7QLkG8BvhVdo5S3PtGZ+rfHBJHyioRa?=
 =?us-ascii?Q?lUzmSb546w2Fqjbd9SA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:49:00.8710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e83c373-8cd7-480d-d7e8-08de0c34a6c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
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

    1. Introduced amdgpu_virt_init_critical_region during VF init.
     - VFs use init_data_header_offset and init_data_header_size_kb
            transmitted via PF2VF mailbox to fetch the offset of
            critical regions' offsets/sizes in VRAM and save to
            adev->virt.crit_region_offsets and adev->virt.crit_region_sizes_kb.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 165 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++
 4 files changed, 211 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a99185ed0642..3ffb9bb1ec0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2782,6 +2782,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return r;
+
+		r = amdgpu_virt_init_critical_region(adev);
+		if (r)
+			return r;
 	}
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 56573fb27f63..805ecc69a8b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -44,6 +44,18 @@
 		vf2pf_info->ucode_info[ucode].version = ver; \
 	} while (0)
 
+#define mmRCC_CONFIG_MEMSIZE    0xde3
+
+const char *amdgpu_virt_dynamic_crit_table_name[] = {
+	"IP DISCOVERY",
+	"VBIOS IMG",
+	"RAS TELEMETRY",
+	"DATA EXCHANGE",
+	"BAD PAGE INFO",
+	"INIT HEADER",
+	"LAST",
+};
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
 	/* By now all MMIO pages except mailbox are blocked */
@@ -843,6 +855,159 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
 	adev->virt.ras.cper_rptr = 0;
 }
 
+static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
+{
+	uint32_t sum = 0;
+
+	if (buf_start >= buf_end)
+		return 0;
+
+	for (; buf_start < buf_end; buf_start++)
+		sum += buf_start[0];
+
+	return 0xffffffff - sum;
+}
+
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
+	uint32_t init_hdr_offset = adev->virt.init_data_header.offset;
+	uint32_t init_hdr_size = adev->virt.init_data_header.size_kb << 10;
+	uint64_t vram_size;
+	int r = 0;
+	uint8_t checksum = 0;
+
+	/* Skip below init if critical region version != v2 */
+	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
+		return 0;
+
+	if (init_hdr_offset < 0) {
+		dev_err(adev->dev, "Invalid init header offset\n");
+		return -EINVAL;
+	}
+
+	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+	if (!vram_size || vram_size == U32_MAX)
+		return -EINVAL;
+	vram_size <<= 20;
+
+	if ((init_hdr_offset + init_hdr_size) > vram_size) {
+		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
+		return -EINVAL;
+	}
+
+	/* Allocate for init_data_hdr */
+	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
+	if (!init_data_hdr)
+		return -ENOMEM;
+
+	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
+					sizeof(struct amd_sriov_msg_init_data_header), false);
+
+	/* Table validation */
+	if (strncmp(init_data_hdr->signature,
+				AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
+				AMDGPU_SRIOV_CRIT_DATA_SIG_LEN) != 0) {
+		dev_err(adev->dev, "Invalid init data signature: %.4s\n",
+			init_data_hdr->signature);
+		r = -EINVAL;
+		goto out;
+	}
+
+	checksum = amdgpu_virt_crit_region_calc_checksum(
+			(uint8_t *)&init_data_hdr->initdata_offset,
+			(uint8_t *)init_data_hdr +
+			sizeof(struct amd_sriov_msg_init_data_header));
+	if (checksum != init_data_hdr->checksum) {
+		dev_err(adev->dev, "Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
+				checksum, init_data_hdr->checksum);
+		r = -EINVAL;
+		goto out;
+	}
+
+	memset(&adev->virt.crit_regn, 0, sizeof(adev->virt.crit_regn));
+	memset(adev->virt.crit_regn_tbl, 0, sizeof(adev->virt.crit_regn_tbl));
+
+	adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
+	adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
+
+	/* Validation and initialization for each table entry */
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_IPD_TABLE_ID)) {
+		if (init_data_hdr->ip_discovery_size_in_kb > DISCOVERY_TMR_SIZE) {
+			dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
+					init_data_hdr->ip_discovery_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
+			init_data_hdr->ip_discovery_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
+			init_data_hdr->ip_discovery_size_in_kb;
+	} else {
+		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
+			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID]);
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID)) {
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
+			init_data_hdr->vbios_img_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
+			init_data_hdr->vbios_img_size_in_kb;
+	} else {
+		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
+			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID]);
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID)) {
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
+			init_data_hdr->ras_tele_info_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
+			init_data_hdr->ras_tele_info_size_in_kb;
+	} else {
+		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
+			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID]);
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID)) {
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
+			init_data_hdr->dataexchange_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
+			init_data_hdr->dataexchange_size_in_kb;
+	} else {
+		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
+			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID]);
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID)) {
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
+			init_data_hdr->bad_page_info_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
+			init_data_hdr->bad_page_size_in_kb;
+	} else {
+		dev_err(adev->dev, "Missing dynamic %s info from critical region v2.\n",
+			amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID]);
+		r = -EINVAL;
+		goto out;
+	}
+
+	adev->virt.is_dynamic_crit_regn_enabled = true;
+
+out:
+	kfree(init_data_hdr);
+	init_data_hdr = NULL;
+
+	return r;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 36247a160aa6..8d03a8620de9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -54,6 +54,12 @@
 
 #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
 
+/* Signature used to validate the SR-IOV dynamic critical region init data header ("INDA") */
+#define AMDGPU_SRIOV_CRIT_DATA_SIGNATURE "INDA"
+#define AMDGPU_SRIOV_CRIT_DATA_SIG_LEN   4
+
+#define IS_SRIOV_CRIT_REGN_ENTRY_VALID(hdr, id) ((hdr)->valid_tables & (1 << (id)))
+
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
 	SRIOV_VF_MODE_ONE_VF,
@@ -296,6 +302,9 @@ struct amdgpu_virt {
 
 	/* dynamic(v2) critical regions */
 	struct amdgpu_virt_region init_data_header;
+	struct amdgpu_virt_region crit_regn;
+	struct amdgpu_virt_region crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
+	bool is_dynamic_crit_regn_enabled;
 
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
@@ -432,6 +441,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
 void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 9228fd2c6dfd..1cee083fb6bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -71,6 +71,37 @@ enum amd_sriov_crit_region_version {
 	GPU_CRIT_REGION_V2 = 2,
 };
 
+/* v2 layout offset enum (in order of allocation) */
+enum amd_sriov_msg_table_id_enum {
+	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
+	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
+	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
+	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
+	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
+	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
+	AMD_SRIOV_MSG_MAX_TABLE_ID,
+};
+
+struct amd_sriov_msg_init_data_header {
+	char     signature[4];  /* "INDA"  */
+	uint32_t version;
+	uint32_t checksum;
+	uint32_t initdata_offset; /* 0 */
+	uint32_t initdata_size_in_kb; /* 5MB */
+	uint32_t valid_tables;
+	uint32_t vbios_img_offset;
+	uint32_t vbios_img_size_in_kb;
+	uint32_t dataexchange_offset;
+	uint32_t dataexchange_size_in_kb;
+	uint32_t ras_tele_info_offset;
+	uint32_t ras_tele_info_size_in_kb;
+	uint32_t ip_discovery_offset;
+	uint32_t ip_discovery_size_in_kb;
+	uint32_t bad_page_info_offset;
+	uint32_t bad_page_size_in_kb;
+	uint32_t reserved[8];
+};
+
 /*
  * PF2VF history log:
  * v1 defined in amdgim
-- 
2.34.1

