Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBE0CCD183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 18:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD75C10E318;
	Thu, 16 Oct 2025 18:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PtfCpLP+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FA910E318
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 18:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXXDx8Ie87JMSVQevSGVI80XUEuItAuDyIK5EtcXSC1LqcqTBWt89uELGHn3GfdpT8WkFMTg9pyjg6osRGDYLbDFWiRChUbzC7yBgwyWkIkuo9xBxwtdPHGRpDKMeSfnyOpQjPsUoLmIbHemavLw2bq3lVpHcDamjNnir7p+89zDU0mRNFdgpjBd7Kk75/7H2Ieri2+ar5jQCGLiN1wHtW058SeYCM+vGJ/nSP++aHwOj2KKq6zBUpoQ5rwPRSC5fEjbRwmz6PHiFIn5WDUfA5fkRUs4dKR6TrzLoPZYi7Zc0iVL2CLyz/X4H+Sot1KMwpe/TQpb7SgNwheeQwj47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE7CVsINmnejy6V+lvq7sUefauUS5B3Dsa9FIlhb+xA=;
 b=OGwPIZ9cBtvs+qb3cUfh1zKktKc41tTA2nSMkjF2nBNGpVudEcUdo1kMQ3Kh/r1XlCGnT4ca8uQA2dVZxpykOZO+N+2LWRAz1w4yE65ux5MVskjuqWma/mR0HvWXuIpX6qbByGU7VuKiTrwpyLb44Lcw4zVJY0uFrDiTOxpTMDeMHMY68LTZGGus2ptBNb5v5k/FvbV8F2bj+BI0aK1gUcm3NR6z4MhfCco9dqnKlrENONGDxGJL9S6UiMCtKKj/evy1kt/wrnapLKZoBU0AO/JtOPfX01DG1Isq81bajt7xYhpFkHbmHKHH7fJOYP6KbYTpGotsr16xh34FTwJCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE7CVsINmnejy6V+lvq7sUefauUS5B3Dsa9FIlhb+xA=;
 b=PtfCpLP+vP4JmHh/EkTR+BZ1cgNGgFl6ZU3v4XeGZAX5JusFxVqCrwCzkKyQpv5g8MQvuoI7I/c+4I1vbC1GfDZOEc8rEygsCHA3b/SAcr0CMu4W1xVxIOTcpIs9uOpiNgoJbidZdC/+5IZtoer43LJqmg15RmLBX1aAeRwLlh8=
Received: from SA0PR11CA0025.namprd11.prod.outlook.com (2603:10b6:806:d3::30)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 18:02:36 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::4a) by SA0PR11CA0025.outlook.office365.com
 (2603:10b6:806:d3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 18:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 18:02:35 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Oct 2025 11:02:35 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v6 3/6] drm/amdgpu: Introduce SRIOV critical regions v2 during
 VF init
Date: Thu, 16 Oct 2025 13:02:18 -0500
Message-ID: <20251016180219.15879-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 107ff7d9-cba0-401e-ec97-08de0cde2fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UdzB688fP+55ThSsonGhrQErRLpZ5Q9XTtZH24aNM7QVaqTUpralkmS8y0Er?=
 =?us-ascii?Q?AzSUBj6YoQNZt725DWMFQpBsv8tjkHZ0c1kjVpgokFfsNvrRwRcW+WZov+7d?=
 =?us-ascii?Q?pdO9qzjwDdu6dcpY+4iYRAQbgpaK83o2UWennp4+mVV7IacMYEZb7R8S1nKJ?=
 =?us-ascii?Q?xorVGNsxQsjdnLko9XfTGEw19k1YLi9Wol92Tp2Qy2CymvLL+XHNK6CaeRoc?=
 =?us-ascii?Q?/NhTwvmLOZLHkXS96ruqU9RDuVKxe0O7+w6wwwQM1dR7sZ6AgVlKsti9k7dj?=
 =?us-ascii?Q?xUAFcd5NYlZYPbWRRM1ioaIsaBofXf/LWD62EljPQuaIEJUzOIt6+utG+/3t?=
 =?us-ascii?Q?y+zgDUqoQMtcp4p6E85qjzrweRcYo9ZzqAqYsqng3mVnn9xoQjaW9kv3z2nR?=
 =?us-ascii?Q?dTIkV0zuC5Y53WhQnpF4udc+T2/KmLreLW/QZhWYkx4qtMmxuhUY6u5PT7VJ?=
 =?us-ascii?Q?8TXMMOo0D531jQhMNRHRckgbrr0uka2TEPSgL8AFO4RYNI/I9Fjkd8dDhZJb?=
 =?us-ascii?Q?dEA+LMeewtf04YnWdhwYekJdrW03dzkueYV4wKlicDFH/Z8vdcUBzalVd2KT?=
 =?us-ascii?Q?0cCeViUv3ECaWGnSAwmYe5Ro9QLHzv5auN9r1IIYBIUhQVn5SA8+uUEmL/pG?=
 =?us-ascii?Q?qbNXGVUBQebuXTBiwKGykbTKCBN5D3t6///JH1p8pIWEzHTTap5/M8NtneeG?=
 =?us-ascii?Q?Q6f4yP+92Zwl5FZbnOofExLn5qOF/c2DWyTuU5QMbzv+KjwwyYOsCGYEIeuZ?=
 =?us-ascii?Q?/ojM0YwDg9WI2FpRdTGB5FrDp4MiDj84oulLHVBdlN2Leg83I+ZpUlSa/r6y?=
 =?us-ascii?Q?HrVDUjQ70rOju0ATfrWhZe9XfRgCtzDYwhKmYyJbC0tlgw9DOrdwd3hR84/9?=
 =?us-ascii?Q?6xcxAOogpFhkXz2uVIpYgJOnOK7MAmeJpO2kXw69/m5ZwasSUWVXZqkljET0?=
 =?us-ascii?Q?2wwzwVDht84hD/rCD0rXIND0kpC/xhMxKjIypnXSE/RBv8HSTyJLeKVFJ72I?=
 =?us-ascii?Q?YQLlDGJN8KohmxntX9vU9gLlHqYOTqQI2MZu0lKKG3XR7qEn5vnUm8DQ8aX8?=
 =?us-ascii?Q?Er683biohZT+cw06uTCh//UjJBNNnF5B++AxD4pP/zg0lJZsMwIimhJKOdMb?=
 =?us-ascii?Q?8wMM/wEwLxYFH6dmAaocslBuise/xgc6UT9ecwtOw0o9VVcQ0EJYQhAqfP25?=
 =?us-ascii?Q?CY81HUMvmjDQywBrR5faurLpjMR7voG94W//3o0dLgX1vhsPBoLPREXEona3?=
 =?us-ascii?Q?R8zGrzr7gmmLLxAU4o4zIQpp/nriNoefkXmxGt0WCKYg7kIYNyasSyDaexdZ?=
 =?us-ascii?Q?tv4AXdlelEF95J5XYi9HHNOce0pMN4bXmZgjwBzrKDui+u/1Mry23iYY+1Oj?=
 =?us-ascii?Q?c3nG9FmFkGOhS72smb93J+QVyzp9/d4wQzeq6muo+mHmFjYxNBNXE+GOaMDn?=
 =?us-ascii?Q?7zeYRUx0pi4A9BIg9mZRvEM9q6hKDAT++S+UEeXmFe4j9ZmxBieRmi+7PF94?=
 =?us-ascii?Q?t0y+OlRzfJTcgXtKnpgoNB00Krf67Kx003IAA/wGsnsEfc9DSWGLLvK5MsAk?=
 =?us-ascii?Q?HJuW/Su4e4GMNPTb/Xk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:02:35.6959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107ff7d9-cba0-401e-ec97-08de0cde2fcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 174 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++
 4 files changed, 220 insertions(+)

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
index 56573fb27f63..1779b1ac30d2 100644
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
@@ -843,6 +855,168 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
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
+		if (!init_data_hdr->ip_discovery_size_in_kb ||
+				init_data_hdr->ip_discovery_size_in_kb > DISCOVERY_TMR_SIZE) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID],
+				init_data_hdr->ip_discovery_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
+			init_data_hdr->ip_discovery_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
+			init_data_hdr->ip_discovery_size_in_kb;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID)) {
+		if (!init_data_hdr->vbios_img_size_in_kb) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID],
+				init_data_hdr->vbios_img_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
+			init_data_hdr->vbios_img_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
+			init_data_hdr->vbios_img_size_in_kb;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID)) {
+		if (!init_data_hdr->ras_tele_info_size_in_kb) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID],
+				init_data_hdr->ras_tele_info_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
+			init_data_hdr->ras_tele_info_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
+			init_data_hdr->ras_tele_info_size_in_kb;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID)) {
+		if (!init_data_hdr->dataexchange_size_in_kb) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID],
+				init_data_hdr->dataexchange_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
+			init_data_hdr->dataexchange_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
+			init_data_hdr->dataexchange_size_in_kb;
+	}
+
+	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID)) {
+		if (!init_data_hdr->bad_page_size_in_kb) {
+			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
+				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID],
+				init_data_hdr->bad_page_size_in_kb);
+			r = -EINVAL;
+			goto out;
+		}
+
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
+			init_data_hdr->bad_page_info_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
+			init_data_hdr->bad_page_size_in_kb;
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

