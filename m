Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5B2C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD0A210E3E2;
	Tue,  9 May 2023 22:14:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF17210E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6bSxjw06ONzadZjQsTxtSsnahI1JdXy/nPn1nEQ1629Nx0Jb6lP0pxpQL1WNCRTl2p1R1ToYwxI9vcEP1EHY+CuG/fIDxJxIyW1IbEeeMEaMGeLCsnlaSHQ7FBRqOG9SZqgA/2VqV2cz0MdtjdL9DgaCUtuVuoxInxdSsjr3Lz+1hNkCB0ZPJki8QB+Z89NtngIKhgsQdZZf2MUs8eu+VhDTHwiLfT1Rs+5oWVQNoeysldakpEbaF80DGTsNpWfyFQo4G/jWYHN359V2X+bz3THuSCUEht2Bg4BTpnXYGmdgapwHEogXsycCBCd6VQ1otj+cFL+yv9jDDpPkwikPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+NXLKJ6jymEej91jIJbUZyy8/PM3qa8DsIPhTgesR8=;
 b=A95yIDbQgiZLQH09wSvxR8w3EtijBXWrmDu2szFFA7/3AGbzG/dTi+nVn2gQALGtJ5DDrcbiRXOpxRJ/uRsSQjNcnOBprCqozJsCQM3v5ea8SFAuIwfxODSszSicvBriNB+U5u19Sqyw9ceNN3N4YbsB5iSFyYOrrwmOB0jPnXAw748lYMsMjdC/7rif0eJz+vRCeYGhXnBT/HlZAQttVWjTaWFk8KCC7YE9j2J7Gdk2k9gDGzZUMmtgiktD5z8rUTqfeLy3He4sR3wMUmmdB+xM7KW8l1LUbwVARKwsmUVgiMlHPmkbgFh/uKlpn0+x1bYtmzEOa5B9xmf9bzsqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+NXLKJ6jymEej91jIJbUZyy8/PM3qa8DsIPhTgesR8=;
 b=KIDUtVMv8Rhcg4ouflQos6eMxW9CrtkVtY6zr815bL4EbXNbcqZfNjI9+RLI77GLB7DK5lzFFfx1H2kzTD9vHUI0RWvulr97WvP9ggnV93+TG3vo58EuAnj8zFXb/WFK5hybNPsv7w7IHKfNv4MdSElnsR72qJ2AL1aoOu9lWr4=
Received: from BN1PR12CA0022.namprd12.prod.outlook.com (2603:10b6:408:e1::27)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:14:24 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::3d) by BN1PR12CA0022.outlook.office365.com
 (2603:10b6:408:e1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amdgpu: Store additional numa node information
Date: Tue, 9 May 2023 18:13:58 -0400
Message-ID: <20230509221408.476829-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 643c3ef2-47f9-4963-8a62-08db50dabf4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zS/6N/FXvEff86cz4h0Vt6WPV0M9YysXqLn6NDgYDsyTgHuF4k25ffRyp1c5z6Pqva6pNoDc7XyBfI+F078L0tmtDxXTVMysZaEDB1LadR4jupXQSL646TgKXUs7v7ex24ARTBNiATUxxvDCba10b6mfojhIaZfbiaTcg329JtK+gmX6WZnes2MgYVtDijgBPKgCAP9WHe/dgtlJgMd5LBD4E3Mj+b62HFnMCmK8vuak54Knr6bOMP0mS+Ix/rUnIYxk3lAyrtSLlBdTlWyYVZT/2Y78+e7I21VgPL11Ogdn5F4xA2GoLmrVjqNkrdCG5Z5jbaOayZ2q+Nv4Cey1ZcsAOA90jPzNXnMwRc8W4DXXIGYr8aEfv/apLvVaBWwE8uZ458i2Juy40+qugPiOGuorjyzK2Qvn7LGvqRqlNQtRKBs50f8avinhua0SJP4VG4X4bzjO8C4KYn2XpPuhIM2M9Wq0imkQrRcVOOZVxod4vJKtsCDsF1HccuZvl/iZyIRQrSB38sqZEMX75VnY2QuhlueZYu430efO3vMLKiql3Y0Tm1PqFWEzWvKQm8Yhmy7qy3r7FZEVNzXDasHiOAaLgk4lDvWU/jyql/hpJuaHIVtZRkYQo/RdmtvsVU2YxALCLBBAKAqkVx3zJ6kU3LGSaLVcvnWcKRNm9rJ74c8zZ4MAONWzN+awWmL6AmQwwzv6k3gnoBRrfdBc2lej2hpD+APz+ZK6vV7B3VZ0IpkJqPil18RLMfI9PmzFm/SYZagMMnvAU+gVzcBefoBroQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(336012)(426003)(47076005)(16526019)(186003)(2616005)(2906002)(83380400001)(36756003)(86362001)(82310400005)(81166007)(82740400003)(356005)(36860700001)(40480700001)(5660300002)(8676002)(8936002)(70586007)(70206006)(4326008)(6916009)(41300700001)(6666004)(7696005)(478600001)(316002)(54906003)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:24.5432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643c3ef2-47f9-4963-8a62-08db50dabf4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use a struct to store additional numa node information including size
and base address. Add numa_info pointer to xcc object to point to the
relevant structure based on its proximity domain.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 79 ++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 52c16b041193..26efca660f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
+#include <linux/xarray.h>
 #include <linux/power_supply.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
@@ -53,10 +54,18 @@ static const guid_t amd_xcc_dsm_guid = GUID_INIT(0x8267f5d5, 0xa556, 0x44f2,
 
 #define AMD_XCC_MAX_HID 24
 
+struct amdgpu_numa_info {
+	uint64_t size;
+	int pxm;
+	int nid;
+};
+
+struct xarray numa_info_xa;
+
 /* Encapsulates the XCD acpi object information */
 struct amdgpu_acpi_xcc_info {
 	struct list_head list;
-	int mem_node;
+	struct amdgpu_numa_info *numa_info;
 	uint8_t xcp_node;
 	uint8_t phy_id;
 	acpi_handle handle;
@@ -838,6 +847,52 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
 	return r;
 }
 
+static inline uint64_t amdgpu_acpi_get_numa_size(int nid)
+{
+	/* This is directly using si_meminfo_node implementation as the
+	 * function is not exported.
+	 */
+	int zone_type;
+	uint64_t managed_pages = 0;
+
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
+		managed_pages +=
+			zone_managed_pages(&pgdat->node_zones[zone_type]);
+	return managed_pages * PAGE_SIZE;
+}
+
+static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
+{
+	struct amdgpu_numa_info *numa_info;
+	int nid;
+
+	numa_info = xa_load(&numa_info_xa, pxm);
+
+	if (!numa_info) {
+		struct sysinfo info;
+
+		numa_info = kzalloc(sizeof *numa_info, GFP_KERNEL);
+		if (!numa_info)
+			return NULL;
+
+		nid = pxm_to_node(pxm);
+		numa_info->pxm = pxm;
+		numa_info->nid = nid;
+
+		if (numa_info->nid == NUMA_NO_NODE) {
+			si_meminfo(&info);
+			numa_info->size = info.totalram * info.mem_unit;
+		} else {
+			numa_info->size = amdgpu_acpi_get_numa_size(nid);
+		}
+		xa_store(&numa_info_xa, numa_info->pxm, numa_info, GFP_KERNEL);
+	}
+
+	return numa_info;
+}
+
 /**
  * amdgpu_acpi_get_node_id - obtain the NUMA node id for corresponding amdgpu
  * acpi device handle
@@ -850,18 +905,25 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
  *
  * Returns ACPI STATUS OK with Node ID on success or the corresponding failure reason
  */
-acpi_status amdgpu_acpi_get_node_id(acpi_handle handle, int *nid)
+acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
+				    struct amdgpu_numa_info **numa_info)
 {
 #ifdef CONFIG_ACPI_NUMA
 	u64 pxm;
 	acpi_status status;
 
+	if (!numa_info)
+		return_ACPI_STATUS(AE_ERROR);
+
 	status = acpi_evaluate_integer(handle, "_PXM", NULL, &pxm);
 
 	if (ACPI_FAILURE(status))
 		return status;
 
-	*nid = pxm_to_node(pxm);
+	*numa_info = amdgpu_acpi_get_numa_info(pxm);
+
+	if (!*numa_info)
+		return_ACPI_STATUS(AE_ERROR);
 
 	return_ACPI_STATUS(AE_OK);
 #else
@@ -1001,7 +1063,8 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_info,
 	ACPI_FREE(obj);
 	obj = NULL;
 
-	status = amdgpu_acpi_get_node_id(xcc_info->handle, &xcc_info->mem_node);
+	status =
+		amdgpu_acpi_get_node_id(xcc_info->handle, &xcc_info->numa_info);
 
 	/* TODO: check if this check is required */
 	if (ACPI_SUCCESS(status))
@@ -1023,6 +1086,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
 	u16 bdf;
 
 	INIT_LIST_HEAD(&amdgpu_acpi_dev_list);
+	xa_init(&numa_info_xa);
 
 	for (id = 0; id < AMD_XCC_MAX_HID; id++) {
 		sprintf(hid, "%s%d", "AMD", AMD_XCC_HID_START + id);
@@ -1353,6 +1417,13 @@ void amdgpu_acpi_release(void)
 {
 	struct amdgpu_acpi_dev_info *dev_info, *dev_tmp;
 	struct amdgpu_acpi_xcc_info *xcc_info, *xcc_tmp;
+	struct amdgpu_numa_info *numa_info;
+	unsigned long index;
+
+	xa_for_each(&numa_info_xa, index, numa_info) {
+		kfree(numa_info);
+		xa_erase(&numa_info_xa, index);
+	}
 
 	if (list_empty(&amdgpu_acpi_dev_list))
 		return;
-- 
2.40.1

