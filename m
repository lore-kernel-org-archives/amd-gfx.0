Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCBFC761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5270110F337;
	Fri, 31 Mar 2023 22:44:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BF410F339
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLtxcQkSJCS0K9IlH1xg7ZXk4xsgORWh2coKCl4gHsahg6Z/FrJn+lmLATwZNW0FUCLM+2d81DAdRHq5koBqvstcCaA4oL2Ng058o5UdfOHZHfVkBtiGNseoXAuKc1ponRdmaRpgTL+bnetPHct8q3qGLRkPJqY0IAgbTmhSN+WhXx5xtgKXxE593/Vjx85cuziWAXh0ZGwlyE3MGRjNL/saOYWOueX5Fq2pwaFsgoz9UA30jhvqnF9Mv/X/T4DND2GkAH8CwOUwjxgnTMKLMbk8zJ7SZ6eOqTi/2Vj7Eq83PjG+O8K5WC3MH5syo+TJrtOWvDNJ5NZ0ZIFNyuE76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GFzt//Th5ePpNJnhHItdjW/oiChfZlc/mp4vVjfvAo=;
 b=K3gO13kllsCtMewVJZWADhNfEByERZ2WoBf69bTEI/XshGYIxA6br0Ap/rKMj5CjnSh7JtuCDrZGWebA6iAK8q13YXt3sLLuZ781sokD9OqXuChua47sD5rCcRe4Gp80CIHpbZiG8l6TKpe8tWkhdi0NjigmWNtW2vjaP/ZlL3RS30eap1F+Y7HpJzZyG/tsvCIdZzfsuTk+e3mX5EehAdPQ4MeUL3lhfT3gAxJo+gvcHFIAlAgyWa2Jw/8qmyMwF32AkshmoO2UW6ElQSevwLs/1z9LzrF2xhdxGFZIQDXETme5AOykKVmhoRy7aoOBiyan9yx6AKoqO0E1KnDthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GFzt//Th5ePpNJnhHItdjW/oiChfZlc/mp4vVjfvAo=;
 b=MiMfHsozIG5WGrk5+R6PmTEqTDUN3aQ7b0gkQOvL+PQnsjCVSSFKarEpNIjF3CHfm0OsTTolH9zt4fFeQK8OrJKkceRkKsVml+rW+sJpWusgD6QHGWF58UnUs7XPnevx0sTs/Z/wr0SLbytU3E5TG/u4+9qP/Cv80KH+/1rEg38=
Received: from MW4PR04CA0369.namprd04.prod.outlook.com (2603:10b6:303:81::14)
 by BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Fri, 31 Mar
 2023 22:44:41 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::e0) by MW4PR04CA0369.outlook.office365.com
 (2603:10b6:303:81::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amdgpu: Add common helper to query ras error (v2)
Date: Fri, 31 Mar 2023 18:44:15 -0400
Message-ID: <20230331224425.8755-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|BL0PR12MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 87764192-aee8-4451-6ba2-08db323983cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REUhWWDo+S77vKvaA0Z4MH7I1sKm1IABddrYUY8mVN3kl4oCBbVFYYp5WKtCuMbHzFQ1TLovFsymgxzbE69mBTXki3fNDDEGk9/ErcOwfEEQKZOkfWZ3KW8PwpJBzsJlfqAYDuz/qvpkC4vV6g1VYtl78P2irsALQAYM9s9heUXiDMUBKWPrMnM/TlBzuwwVU2+czuLrC2nq7vFNin1EqDLkQ+MjIBnFLLTjORfYc5LR3xxCV8kDyOAAgjbDJHd/qN0zFocFJ3r6dk4dC5BpghgiPWM10fn+Wwhdgd7gJWe6eu0NXXZtIdZx04dkJO6SVH6tajTeq8qAGsn543Q6TCfxPEGgiql4aaATe9m5oB3bHUJ4x7zmB9eqqAv7/iFMzTXtc4EIpjUnsFvreXgXeEYrJ7wqpQWBdhU/krp6quM4nTThvefsS+UZlVbC/MiP37a3foBZ757NOsbGYc3S8iBkAJYG3i6KXACojcBueV7q8PlgB/CBi7WGlZKeEh7z51KDys8Nhf+GnblDc6HxgzrAPe0PTsQO+GVhfzr0jZCGmZKFhyGtGihucMRkubwo70U63GtAImyzc05p+qkEwULVdBOuaOScebkAlrmKtItQRCdxHVN7TiJOmnPZeil1AmzvRYuf8bmOjdcVyFRW2Uo2+i/NRPDYpRELuqDsiQ+0tv0jlsb4Z3LK4KtG6iB89PPDLSlRpoOPZU22pCD40snGXDyWSRNKv3W86Y4xqOY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(70586007)(83380400001)(70206006)(36756003)(4326008)(426003)(47076005)(2616005)(336012)(186003)(316002)(6666004)(478600001)(26005)(1076003)(54906003)(2906002)(16526019)(7696005)(5660300002)(82310400005)(40460700003)(8936002)(6916009)(356005)(81166007)(82740400003)(8676002)(40480700001)(41300700001)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:40.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87764192-aee8-4451-6ba2-08db323983cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add common helper to query ras error status and
log error information, including memory block id
and erorr count. The helpers are applicable to IP
blocks that follow the new ras error logging design.
For IP blocks that don't support the new design,
please still implement ip specific helper to query
ras error.

v2: optimize struct amdgpu_ras_err_status_reg_entry
and the implementaion in helper (Lijo/Tao)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 119 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  54 +++++++++++
 2 files changed, 173 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index fac45f98145d..3baf5d1bc08b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3098,3 +3098,122 @@ int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+void amdgpu_ras_get_error_type_name(uint32_t err_type, char *err_type_name)
+{
+	if (!err_type_name)
+		return;
+
+	switch (err_type) {
+	case AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE:
+		sprintf(err_type_name, "correctable");
+		break;
+	case AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE:
+		sprintf(err_type_name, "uncorrectable");
+		break;
+	default:
+		sprintf(err_type_name, "unknown");
+		break;
+	}
+}
+
+bool amdgpu_ras_inst_get_memory_id_field(struct amdgpu_device *adev,
+					 const struct amdgpu_ras_err_status_reg_entry *reg_entry,
+					 uint32_t instance,
+					 uint32_t *memory_id)
+{
+	uint32_t err_status_lo_data, err_status_lo_offset;
+
+	if (!reg_entry)
+		return false;
+
+	err_status_lo_offset =
+		AMDGPU_RAS_REG_ENTRY_OFFSET(reg_entry->hwip, instance,
+					    reg_entry->seg_lo, reg_entry->reg_lo);
+	err_status_lo_data = RREG32(err_status_lo_offset);
+
+	if ((reg_entry->flags & AMDGPU_RAS_ERR_STATUS_VALID) &&
+	    !REG_GET_FIELD(err_status_lo_data, ERR_STATUS_LO, ERR_STATUS_VALID_FLAG))
+		return false;
+
+	*memory_id = REG_GET_FIELD(err_status_lo_data, ERR_STATUS_LO, MEMORY_ID);
+
+	return true;
+}
+
+bool amdgpu_ras_inst_get_err_cnt_field(struct amdgpu_device *adev,
+				       const struct amdgpu_ras_err_status_reg_entry *reg_entry,
+				       uint32_t instance,
+				       unsigned long *err_cnt)
+{
+	uint32_t err_status_hi_data, err_status_hi_offset;
+
+	if (!reg_entry)
+		return false;
+
+	err_status_hi_offset =
+		AMDGPU_RAS_REG_ENTRY_OFFSET(reg_entry->hwip, instance,
+					    reg_entry->seg_hi, reg_entry->reg_hi);
+	err_status_hi_data = RREG32(err_status_hi_offset);
+
+	if ((reg_entry->flags & AMDGPU_RAS_ERR_INFO_VALID) &&
+	    !REG_GET_FIELD(err_status_hi_data, ERR_STATUS_HI, ERR_INFO_VALID_FLAG))
+		return false;
+
+	/* read err count */
+	*err_cnt = REG_GET_FIELD(err_status_hi_data, ERR_STATUS, ERR_CNT);
+
+	return true;
+}
+
+void amdgpu_ras_inst_query_ras_error_count(struct amdgpu_device *adev,
+					   const struct amdgpu_ras_err_status_reg_entry *reg_list,
+					   uint32_t reg_list_size,
+					   const struct amdgpu_ras_memory_id_entry *mem_list,
+					   uint32_t mem_list_size,
+					   uint32_t instance,
+					   uint32_t err_type,
+					   unsigned long *err_count)
+{
+	uint32_t memory_id;
+	unsigned long err_cnt;
+	char err_type_name[16];
+	uint32_t i, j;
+
+	for (i = 0; i < reg_list_size; i++) {
+		/* query err_cnt from err_status_hi */
+		if (!amdgpu_ras_inst_get_err_cnt_field(adev, &reg_list[i],
+						       instance, &err_cnt) ||
+		    !err_cnt)
+			continue;
+
+		/* query memory_id from err_status_lo */
+		if (!amdgpu_ras_inst_get_memory_id_field(adev, &reg_list[i],
+							 instance, &memory_id))
+			continue;
+
+		*err_count += err_cnt;
+
+		/* log the errors */
+		amdgpu_ras_get_error_type_name(err_type, err_type_name);
+		if (!mem_list) {
+			/* memory_list is not supported */
+			dev_info(adev->dev,
+				 "%ld %s hardware errors detected in %s, instance: %d, memory_id: %d\n",
+				 err_cnt, err_type_name,
+				 reg_list[i].block_name,
+				 instance, memory_id);
+		} else {
+			for (j = 0; j < mem_list_size; j++) {
+				if (memory_id == mem_list[j].memory_id) {
+					dev_info(adev->dev,
+						 "%ld %s hardware errors detected in %s, instance: %d, memory block: %s\n",
+						 err_cnt, err_type_name,
+						 reg_list[i].block_name,
+						 instance, mem_list[j].name);
+					break;
+				}
+			}
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ef38f4c93df0..2ee51ec44211 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -314,6 +314,43 @@ enum amdgpu_ras_ret {
 	AMDGPU_RAS_PT,
 };
 
+/* ras error status reisger fields */
+#define ERR_STATUS_LO__ERR_STATUS_VALID_FLAG__SHIFT	0x0
+#define ERR_STATUS_LO__ERR_STATUS_VALID_FLAG_MASK	0x00000001L
+#define ERR_STATUS_LO__MEMORY_ID__SHIFT			0x18
+#define ERR_STATUS_LO__MEMORY_ID_MASK			0xFF000000L
+#define ERR_STATUS_HI__ERR_INFO_VALID_FLAG__SHIFT	0x2
+#define ERR_STATUS_HI__ERR_INFO_VALID_FLAG_MASK		0x00000004L
+#define ERR_STATUS__ERR_CNT__SHIFT			0x17
+#define ERR_STATUS__ERR_CNT_MASK			0x03800000L
+
+#define AMDGPU_RAS_REG_ENTRY(ip, inst, reg_lo, reg_hi) \
+	ip##_HWIP, inst, reg_lo##_BASE_IDX, reg_lo, reg_hi##_BASE_IDX, reg_hi
+
+#define AMDGPU_RAS_REG_ENTRY_OFFSET(hwip, ip_inst, segment, reg) \
+	(adev->reg_offset[hwip][ip_inst][segment] + (reg))
+
+#define AMDGPU_RAS_ERR_INFO_VALID	(1 << 0)
+#define AMDGPU_RAS_ERR_STATUS_VALID	(1 << 1)
+#define AMDGPU_RAS_ERR_ADDRESS_VALID	(1 << 2)
+
+struct amdgpu_ras_err_status_reg_entry {
+	uint32_t hwip;
+	uint32_t ip_inst;
+	uint32_t seg_lo;
+	uint32_t reg_lo;
+	uint32_t seg_hi;
+	uint32_t reg_hi;
+	uint32_t reg_inst;
+	uint32_t flags;
+	const char *block_name;
+};
+
+struct amdgpu_ras_memory_id_entry {
+	uint32_t memory_id;
+	const char *name;
+};
+
 struct ras_common_if {
 	enum amdgpu_ras_block block;
 	enum amdgpu_ras_error_type type;
@@ -692,4 +729,21 @@ int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_co
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 				struct amdgpu_ras_block_object *ras_block_obj);
 void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev);
+void amdgpu_ras_get_error_type_name(uint32_t err_type, char *err_type_name);
+bool amdgpu_ras_inst_get_memory_id_field(struct amdgpu_device *adev,
+					 const struct amdgpu_ras_err_status_reg_entry *reg_entry,
+					 uint32_t instance,
+					 uint32_t *memory_id);
+bool amdgpu_ras_inst_get_err_cnt_field(struct amdgpu_device *adev,
+				       const struct amdgpu_ras_err_status_reg_entry *reg_entry,
+				       uint32_t instance,
+				       unsigned long *err_cnt);
+void amdgpu_ras_inst_query_ras_error_count(struct amdgpu_device *adev,
+					   const struct amdgpu_ras_err_status_reg_entry *reg_list,
+					   uint32_t reg_list_size,
+					   const struct amdgpu_ras_memory_id_entry *mem_list,
+					   uint32_t mem_list_size,
+					   uint32_t instance,
+					   uint32_t err_type,
+					   unsigned long *err_count);
 #endif
-- 
2.39.2

