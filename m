Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6F1C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FE310E406;
	Tue,  9 May 2023 22:10:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562E110E401
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXnOC0WiQBMPIcVQllRJXueD0+W0icjJZv3kuTxk9pA0UkJ0P6cymcqvNS65PBJUkTzCCPE0KkYdG5m6SSHzh7Y4/nSsnbRJIWp/iqmJ3CZDNU19TrILd9K0gbAKsiHP1HqZmKrfx+xb5cNDqCzqfQDeyU6/7z2S19q5tpRkBP5gWmsd5irSEsSdPiKlurBbVHKCiPwnP6ScK6ljv59aDszS/1+rgvzTYSZNU/bnGlX9oHmCqjxF3mo8w+2aAZwMYBL8pWjCeRAFG9Q3vvLrvgqEanzkzyXT0Mo1jf1OUWjWzEX6mwjYpYjLfplTAK3juwL2/bQugw3ueSaEVnXaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osVnPplmN4GgpqlhCmkMACiQ1US7drrRLj6dXMBcDp0=;
 b=i+15bjdBRTmH1wUqE76c4/61Wltczx01O67hS4VDpCsPWiJdYUBacq9aIrhgLrko0CZlhIaBXPSnMGbcDPVaTqb+xF1Sc7WWqrzpL/ZZkBVNyGSQEDiCZVKma1MQFWA/IuNhUIA4j4yelUQHTL2UhSqUYQEAYz2cps7yScuOuyzHYtdKc6keaMHgqbrN7Q9JTBNoQku7PPjWqH47HmB6MIKzkutWiPzStPIjzzmq6KbYbAGUF4OklKWuV4Nkrw526CCWFCVohqOsFcoPtD+eijVLQWE413TSmJVrP4TtdOOj2sOG5GmaaOkH+Lb8JSYsylvlVExqMp5WIKlcBDti+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osVnPplmN4GgpqlhCmkMACiQ1US7drrRLj6dXMBcDp0=;
 b=av3HDKUm8TqrCm+A0407/fHnKq8rn1yzc1rcGhsEzL3f5WtKQFmk/118aogCNkyACNOaxr1Oyzz+R93ofvpYofYnvFmIRfrrLoBJ7rOs74mtneUahIqm0IeKIcGO/h1V/nMujT/mGWzVtpinp94KiQ3Si+yDnmohW3LklMGmQFE=
Received: from BN9PR03CA0263.namprd03.prod.outlook.com (2603:10b6:408:ff::28)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:10:17 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::d2) by BN9PR03CA0263.outlook.office365.com
 (2603:10b6:408:ff::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:10:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:10:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: Add parsing of acpi xcc objects
Date: Tue, 9 May 2023 18:09:57 -0400
Message-ID: <20230509221003.475858-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 885194f0-7d73-4810-e806-08db50da2bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tXwWvHbY+/xM1Fefd2ZzVzpMIzBVu0IlVpoGPCWFLXhXRELQbSGRFQbdoHUJAhmZP+BCuBPT+bQUcQUFFOpcoZcfx32kqFH4aYGaL4ed6BSu9yab7xOzk0QIU5uK5bfR+HTYYc3qdIATTfUspZhlrzipELYs+vI8Q2/6M5W1ec1rbGfSyqP4QPiqhWxvEgVha3IYTLpA8A9+Sla9UvaJP5KRXXS2QE+btTcf6vNW7gLPwTRfKa753hUD0U6Jr2uVoKMnd+o5lFv7VRbcNF1uCXJSuN0EDbLkFV36WlQBkiOhhrHUPRb7VAFNFcVtxMZzguQkspeT1rnujrC7mnbYfNciaxYl6JP8tDaF9RabqENVOihiv0lG/+i8TFe8oLi4VnUPAHD0l8dSv0nANcfz4ZBMwkPcGLm9Bj0/gkBiqSYkBkKNFRypJQxZEXOeOGHA+4v18uZU5NaFcsCvhxTsXmHgJaHU63VtqQFm6UHXeZjxEjqpoEESDGQPpI5udd3qu/vUImmOUi+1+WWZhaD22uNNVTkzOt7iRvWdpG5htu61FJOaiQWb8/LI3WWov+D99nY8bKej8TOl5UaB2kK9vhQInWG/XNQDhrXJpw12qnGLwSn3NBX5J/JJaqbshlLNhWPLKT5h7k8vZFzpfxwtUrf2mo6yygPs6M1KAYNgplrgmmTMSqISRDXhQZVj9kAr0J35zXolNTMa4MbicNRUclqqAMDn1rPWsNjA0NfhwI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(6666004)(36756003)(54906003)(4326008)(478600001)(7696005)(6916009)(70586007)(316002)(70206006)(82310400005)(40480700001)(8936002)(5660300002)(41300700001)(2906002)(8676002)(81166007)(47076005)(186003)(356005)(16526019)(82740400003)(26005)(1076003)(36860700001)(336012)(83380400001)(2616005)(426003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:10:17.0399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885194f0-7d73-4810-e806-08db50da2bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add parsing of ACPI xcc objects and fill in relevant info from them by
invoking the DSM methods.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 294 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   1 +
 3 files changed, 297 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 743fc5f137b0..196c2a8a6b48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1425,11 +1425,13 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
+void amdgpu_acpi_release(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
 static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
+static inline void amdgpu_acpi_release(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
 static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 						  u8 dev_state, bool drv_state) { return 0; }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index edaf3ded4a04..d9cc07e01293 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -38,6 +38,43 @@
 #include "amd_acpi.h"
 #include "atom.h"
 
+/* Declare GUID for AMD _DSM method for XCCs */
+static const guid_t amd_xcc_dsm_guid = GUID_INIT(0x8267f5d5, 0xa556, 0x44f2,
+						 0xb8, 0xb4, 0x45, 0x56, 0x2e,
+						 0x8c, 0x5b, 0xec);
+
+#define AMD_XCC_HID_START 3000
+#define AMD_XCC_DSM_GET_NUM_FUNCS 0
+#define AMD_XCC_DSM_GET_SUPP_MODE 1
+#define AMD_XCC_DSM_GET_XCP_MODE 2
+#define AMD_XCC_DSM_GET_VF_XCC_MAPPING 4
+#define AMD_XCC_DSM_GET_TMR_INFO 5
+#define AMD_XCC_DSM_NUM_FUNCS 5
+
+#define AMD_XCC_MAX_HID 24
+
+/* Encapsulates the XCD acpi object information */
+struct amdgpu_acpi_xcc_info {
+	struct list_head list;
+	int mem_node;
+	uint8_t xcp_node;
+	uint8_t phy_id;
+	acpi_handle handle;
+};
+
+struct amdgpu_acpi_dev_info {
+	struct list_head list;
+	struct list_head xcc_list;
+	uint16_t bdf;
+	uint16_t supp_xcp_mode;
+	uint16_t xcp_mode;
+	uint16_t mem_mode;
+	uint64_t tmr_base;
+	uint64_t tmr_size;
+};
+
+struct list_head amdgpu_acpi_dev_list;
+
 struct amdgpu_atif_notification_cfg {
 	bool enabled;
 	int command_code;
@@ -801,6 +838,240 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
 	return r;
 }
 
+/**
+ * amdgpu_acpi_get_node_id - obtain the NUMA node id for corresponding amdgpu
+ * acpi device handle
+ *
+ * @handle: acpi handle
+ * @nid: NUMA Node id returned by the platform firmware
+ *
+ * Queries the ACPI interface to fetch the corresponding NUMA Node ID for a
+ * given amdgpu acpi device.
+ *
+ * Returns ACPI STATUS OK with Node ID on success or the corresponding failure reason
+ */
+acpi_status amdgpu_acpi_get_node_id(acpi_handle handle, int *nid)
+{
+#ifdef CONFIG_ACPI_NUMA
+	u64 pxm;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, "_PXM", NULL, &pxm);
+
+	if (ACPI_FAILURE(status))
+		return status;
+
+	*nid = pxm_to_node(pxm);
+
+	return_ACPI_STATUS(AE_OK);
+#else
+	return_ACPI_STATUS(AE_NOT_EXIST);
+#endif
+}
+
+struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
+{
+	struct amdgpu_acpi_dev_info *acpi_dev;
+
+	if (list_empty(&amdgpu_acpi_dev_list))
+		return NULL;
+
+	list_for_each_entry(acpi_dev, &amdgpu_acpi_dev_list, list)
+		if (acpi_dev->bdf == bdf)
+			return acpi_dev;
+
+	return NULL;
+}
+
+static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_info,
+				struct amdgpu_acpi_xcc_info *xcc_info, u16 bdf)
+{
+	struct amdgpu_acpi_dev_info *tmp;
+	union acpi_object *obj;
+	int ret = -ENOENT;
+
+	*dev_info = NULL;
+	tmp = kzalloc(sizeof(struct amdgpu_acpi_dev_info), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&tmp->xcc_list);
+	INIT_LIST_HEAD(&tmp->list);
+	tmp->bdf = bdf;
+
+	obj = acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_guid, 0,
+				      AMD_XCC_DSM_GET_SUPP_MODE, NULL,
+				      ACPI_TYPE_INTEGER);
+
+	if (!obj) {
+		acpi_handle_debug(xcc_info->handle,
+				  "_DSM function %d evaluation failed",
+				  AMD_XCC_DSM_GET_SUPP_MODE);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	tmp->supp_xcp_mode = obj->integer.value & 0xFFFF;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_guid, 0,
+				      AMD_XCC_DSM_GET_XCP_MODE, NULL,
+				      ACPI_TYPE_INTEGER);
+
+	if (!obj) {
+		acpi_handle_debug(xcc_info->handle,
+				  "_DSM function %d evaluation failed",
+				  AMD_XCC_DSM_GET_XCP_MODE);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	tmp->xcp_mode = obj->integer.value & 0xFFFF;
+	tmp->mem_mode = (obj->integer.value >> 32) & 0xFFFF;
+	ACPI_FREE(obj);
+
+	/* Evaluate DSMs and fill XCC information */
+	obj = acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_guid, 0,
+				      AMD_XCC_DSM_GET_TMR_INFO, NULL,
+				      ACPI_TYPE_PACKAGE);
+
+	if (!obj || obj->package.count < 2) {
+		acpi_handle_debug(xcc_info->handle,
+				  "_DSM function %d evaluation failed",
+				  AMD_XCC_DSM_GET_TMR_INFO);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	tmp->tmr_base = obj->package.elements[0].integer.value;
+	tmp->tmr_size = obj->package.elements[1].integer.value;
+	ACPI_FREE(obj);
+
+	DRM_DEBUG_DRIVER(
+		"New dev(%x): Supported xcp mode: %x curr xcp_mode : %x mem mode : %x, tmr base: %llx tmr size: %llx  ",
+		tmp->bdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mode,
+		tmp->tmr_base, tmp->tmr_size);
+	list_add_tail(&tmp->list, &amdgpu_acpi_dev_list);
+	*dev_info = tmp;
+
+	return 0;
+
+out:
+	if (obj)
+		ACPI_FREE(obj);
+	kfree(tmp);
+
+	return ret;
+}
+
+static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_info,
+				    u16 *bdf)
+{
+	union acpi_object *obj;
+	acpi_status status;
+	int ret = -ENOENT;
+
+	obj = acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_guid, 0,
+				      AMD_XCC_DSM_GET_NUM_FUNCS, NULL,
+				      ACPI_TYPE_INTEGER);
+
+	if (!obj || obj->integer.value != AMD_XCC_DSM_NUM_FUNCS)
+		goto out;
+	ACPI_FREE(obj);
+
+	/* Evaluate DSMs and fill XCC information */
+	obj = acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_guid, 0,
+				      AMD_XCC_DSM_GET_VF_XCC_MAPPING, NULL,
+				      ACPI_TYPE_INTEGER);
+
+	if (!obj) {
+		acpi_handle_debug(xcc_info->handle,
+				  "_DSM function %d evaluation failed",
+				  AMD_XCC_DSM_GET_VF_XCC_MAPPING);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* PF xcc id [39:32] */
+	xcc_info->phy_id = (obj->integer.value >> 32) & 0xFF;
+	/* xcp node of this xcc [47:40] */
+	xcc_info->xcp_node = (obj->integer.value >> 40) & 0xFF;
+	/* PF bus/dev/fn of this xcc [63:48] */
+	*bdf = (obj->integer.value >> 48) & 0xFFFF;
+	ACPI_FREE(obj);
+	obj = NULL;
+
+	status = amdgpu_acpi_get_node_id(xcc_info->handle, &xcc_info->mem_node);
+
+	/* TODO: check if this check is required */
+	if (ACPI_SUCCESS(status))
+		ret = 0;
+out:
+	if (obj)
+		ACPI_FREE(obj);
+
+	return ret;
+}
+
+static int amdgpu_acpi_enumerate_xcc(void)
+{
+	struct amdgpu_acpi_dev_info *dev_info = NULL;
+	struct amdgpu_acpi_xcc_info *xcc_info;
+	struct acpi_device *acpi_dev;
+	char hid[ACPI_ID_LEN];
+	int ret, id;
+	u16 bdf;
+
+	INIT_LIST_HEAD(&amdgpu_acpi_dev_list);
+
+	for (id = 0; id < AMD_XCC_MAX_HID; id++) {
+		sprintf(hid, "%s%d", "AMD", AMD_XCC_HID_START + id);
+		acpi_dev = acpi_dev_get_first_match_dev(hid, NULL, -1);
+		/* These ACPI objects are expected to be in sequential order. If
+		 * one is not found, no need to check the rest.
+		 */
+		if (!acpi_dev) {
+			DRM_DEBUG_DRIVER("No matching acpi device found for %s",
+					 hid);
+			break;
+		}
+
+		xcc_info = kzalloc(sizeof(struct amdgpu_acpi_xcc_info),
+				   GFP_KERNEL);
+		if (!xcc_info) {
+			DRM_ERROR("Failed to allocate memory for xcc info\n");
+			return -ENOMEM;
+		}
+
+		INIT_LIST_HEAD(&xcc_info->list);
+		xcc_info->handle = acpi_device_handle(acpi_dev);
+		acpi_dev_put(acpi_dev);
+
+		ret = amdgpu_acpi_get_xcc_info(xcc_info, &bdf);
+		if (ret) {
+			kfree(xcc_info);
+			continue;
+		}
+
+		dev_info = amdgpu_acpi_get_dev(bdf);
+
+		if (!dev_info)
+			ret = amdgpu_acpi_dev_init(&dev_info, xcc_info, bdf);
+
+		if (ret == -ENOMEM)
+			return ret;
+
+		if (!dev_info) {
+			kfree(xcc_info);
+			continue;
+		}
+
+		list_add_tail(&xcc_info->list, &dev_info->xcc_list);
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_acpi_event - handle notify events
  *
@@ -1054,6 +1325,29 @@ void amdgpu_acpi_detect(void)
 	} else {
 		atif->backlight_caps.caps_valid = false;
 	}
+
+	amdgpu_acpi_enumerate_xcc();
+}
+
+void amdgpu_acpi_release(void)
+{
+	struct amdgpu_acpi_dev_info *dev_info, *dev_tmp;
+	struct amdgpu_acpi_xcc_info *xcc_info, *xcc_tmp;
+
+	if (list_empty(&amdgpu_acpi_dev_list))
+		return;
+
+	list_for_each_entry_safe(dev_info, dev_tmp, &amdgpu_acpi_dev_list,
+				 list) {
+		list_for_each_entry_safe(xcc_info, xcc_tmp, &dev_info->xcc_list,
+					 list) {
+			list_del(&xcc_info->list);
+			kfree(xcc_info);
+		}
+
+		list_del(&dev_info->list);
+		kfree(dev_info);
+	}
 }
 
 #if IS_ENABLED(CONFIG_SUSPEND)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 445a223f08d9..39975724be73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2907,6 +2907,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_amdkfd_fini();
 	pci_unregister_driver(&amdgpu_kms_pci_driver);
 	amdgpu_unregister_atpx_handler();
+	amdgpu_acpi_release();
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
 	mmu_notifier_synchronize();
-- 
2.40.1

