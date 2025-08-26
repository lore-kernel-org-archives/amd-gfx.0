Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88603C8303F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FC610E36B;
	Tue, 26 Aug 2025 01:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G3QO0tnB";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4CE10E36B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F42fsHXDvTcLX6JCyyN+OtZFZ9VONeUn7wCHJo8cmn0IGEBltFo0xeNAJRrFD6t91PTj3enVNrTBSf0I7PoH6UvnhBu/M928ypMCiCc2zgiiqo7ymF5YE1XQOM0qTTCgOdAPRq9xZluaFvaDZVntGNsU5yGjZ/+6vigw1E/fhliJYfHcuMYio/6sRCbfPUwhDd/hm20jnvpwdJef7TwlUxMDf3RFfqxO5lE3W7OefDItOLLJDEwewag8m4satfgrXLUzdSc1As1hkzLdv/LQKn+swDLFCuqheQCwNt4gD6m2GMe3KbLQ0+XewUBdqvGYtLYYDopoLQhOisO1cI4qxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=T99IOmf64hgAEDxos7MrkBo4gpx7RVxdmSFF0bOwiParDNrvEvN++rFMbY+h6pYDo9Tjjddh7s7AbPdhJm9cNM1/4nhUn2twsXuWns6JrMyzzU+zPZSPZZ1d5tVWFHs2nL3AuZhiC/oIkFexd1mvYDc5jW2138l/bb+uXo/OVJNWSM7f7Ip8M/DHjRhqA4Sm2eJuDFSVkoU7daYhL9/HfhfMiDsc/gMbirI1vqd33LCL1kPHq3ivO88HgW01vGEy/+sRPZ0xkZ97XJV2j7+xluc2bJ7O20w+gXfys7yEkeQ2xbaKRB+FPxmrBXaqUYVX4jAQeEpkAu8hNjN4N91HvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOT3Lj8+ZVsOax1f5Ac8mYogXc9wosKXCPRQFGo/u0=;
 b=G3QO0tnBseO1aMrghmjX1srZ2lxCxVzMxGIEVI/bHsTN0m36K1uFmVtp6mUFjibTfyuFUDcDB2MlM2ZglI7yjJUu3z740ooVp0+I5tazfIKwv//utNslkDxD7Hl18VwsQSFv0idDATbATfoll8zP5/SBK4SWl/FsDVzu5+anyP4=
Received: from CH0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::8)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 01:47:22 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::bd) by CH0P221CA0019.outlook.office365.com
 (2603:10b6:610:11c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 01:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:20 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:47:14 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v12 04/11] drm/amdgpu/mes: add front end for detect and reset hung
 queue
Date: Tue, 26 Aug 2025 09:42:14 +0800
Message-ID: <20250826014648.1711926-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: a325341a-ae85-45a8-7c2e-08dde4427f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VI7zVbL6GpeV/M1fZgO9dyz4tIjA6GytiFzOt4psNKynQS2JTge+v7TJdQb5?=
 =?us-ascii?Q?+/Cn4GvtDPWB1YCe1uE7FsmMNeODhUmMa4ftgL4/669Rp9H34IU++w5CBTha?=
 =?us-ascii?Q?gd5cDMFkBfJTRAyMRSZSbfRH2JzpklLFuQKA5jp5IJ7ZuQuA51xSmU2BqfQK?=
 =?us-ascii?Q?q2CjF1fwNnk66cdAJi86qqs7oO+30kKYPgBPLfJfOky2X4h2LTFDSyXv0Xcv?=
 =?us-ascii?Q?O66ux2j7PdD2wXOpdW+zDoDXMkW6GhdJiizEyj+cL6mN6kF0/3p0TCVGrFX3?=
 =?us-ascii?Q?qdpE6kXeEfM/WEcGCowQLsCjedvH7ddRcLx7mdR5Wxpu00U4Mk0y8+2PCz6m?=
 =?us-ascii?Q?UAbJPG1h7H5dtbIOsfS9xuKHldAAcgIHojU6uA7b66QaYlLRQukOC+ZLRsJg?=
 =?us-ascii?Q?W3frDiIP8V2d+L4pocmgNdhkdn6+O7wv0VCGf/sroKrg77Cyf8sBqKxnPXuE?=
 =?us-ascii?Q?OWGYK1WEM+CV+dDGgpZWVryrgdJYOH1Kcrj41DA4lalCYl73E9Xk20U5Nrhh?=
 =?us-ascii?Q?w6ULcNrY7xHghTtYF12wUx1FqWbujHY028jq6tDSbDWJK+yjLVaKxrYiBriz?=
 =?us-ascii?Q?HylV5JzL5rbPlY3KONkJbcMNSDQ40KaZm/QUrXTMwO9nz68VjLrT5YRoCLlm?=
 =?us-ascii?Q?gA9qXZZPRoMmdZWs02FCiaBCRYmSLTgGKX0AFKgYczRuzRRTmUbZJSb9VDuU?=
 =?us-ascii?Q?eZ+X3F53MmmYp3D64vXhzC21zI/NMdNmRv0CyJ5oOrYR9JhOCbc2JW9MSdHt?=
 =?us-ascii?Q?MDkulZP4UbWoCvjnius9Zs/lgwhdtece5t95LiHL8zB7DlIVY3aWtrw1c3Vv?=
 =?us-ascii?Q?ftChq0apP2GI3o2n2C2eVdt5ftAbqKfVQzGaHZtdX6uWy7wtTqm4r9O/TpwP?=
 =?us-ascii?Q?IaEf1/4yakp2gPMhL8lfHHc8RhLWvxO3CFCrVSCR8HXZlmuXD3ikEuzA2zLN?=
 =?us-ascii?Q?9ta98+ysZ2Q3KzzIAwPH2Zj/+tPqyQU93WBcEbVYzw+qPMbpsO24xzwRI4cx?=
 =?us-ascii?Q?1t1TpTY1RyfWHWXlvYeN58rphy494SIRoRwue9Xe6PwnEejr/3PBNupR3mFK?=
 =?us-ascii?Q?p41fKpclqBXUBjQwtjA1+CgECi7B6jvuZd4pf/5Kxxxl2rpp/nYJeQ69885m?=
 =?us-ascii?Q?NWYOc+R6YU/rJk4c+85z+gg8luBVam/oReu/jbZ1NThJwOHyUuKKPjghsCXZ?=
 =?us-ascii?Q?bXZ+ECFnBf2bSlwhnG+Od1YkonitIaN2E0KsekjZqNmkCX/suo8OifUHiDZV?=
 =?us-ascii?Q?VxYSjR51zYjlXTDZVjR7f5FQ3/2Z+9zjJaZxldiitQ8eUTmNX26XRi5jD6Va?=
 =?us-ascii?Q?zVnRwSSYEAbct5pEddvEvVG7kWhgZX7u4ZBjb8p68xdmahA8Bq5z/KYrYTNE?=
 =?us-ascii?Q?bQhohGEHxqLF7pc6eMcbzwq0J3XeNwUI1EMmxEzLVyQC1hc9yt+wNeJRL9Wo?=
 =?us-ascii?Q?F8cOpoGQ1iJFPbf5h9y9+Ayr+tEc1Y32k6olHGQNiRnf5UKA15gwgMcOhIuK?=
 =?us-ascii?Q?ayijiOr8qtEGE3e1Ny9U8fLbf3hFtbIdfHYP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:21.5277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a325341a-ae85-45a8-7c2e-08dde4427f93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

From: Alex Deucher <alexander.deucher@amd.com>

Helper function to detect and reset hung queues.  MES will
return an array of doorbell indices of which queues are hung
and were optionally reset.

v2:  Clear the doorbell array before detection

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 65 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 ++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 135598502c8d..5bf9be073cdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -191,6 +191,20 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error_doorbell;
 
+	if (adev->mes.hung_queue_db_array_size) {
+		r = amdgpu_bo_create_kernel(adev,
+					    adev->mes.hung_queue_db_array_size * sizeof(u32),
+					    PAGE_SIZE,
+					    AMDGPU_GEM_DOMAIN_GTT,
+					    &adev->mes.hung_queue_db_array_gpu_obj,
+					    &adev->mes.hung_queue_db_array_gpu_addr,
+					    &adev->mes.hung_queue_db_array_cpu_addr);
+		if (r) {
+			dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
+			goto error_doorbell;
+		}
+	}
+
 	return 0;
 
 error_doorbell:
@@ -216,6 +230,10 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
 	int i;
 
+	amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
+			      &adev->mes.hung_queue_db_array_gpu_addr,
+			      &adev->mes.hung_queue_db_array_cpu_addr);
+
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
 			      &adev->mes.event_log_gpu_addr,
 			      &adev->mes.event_log_cpu_addr);
@@ -366,6 +384,53 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev)
+{
+	return adev->mes.hung_queue_db_array_size;
+}
+
+int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
+					    int queue_type,
+					    bool detect_only,
+					    unsigned int *hung_db_num,
+					    u32 *hung_db_array)
+
+{
+	struct mes_detect_and_reset_queue_input input;
+	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
+	int r, i;
+
+	if (!hung_db_num || !hung_db_array)
+		return -EINVAL;
+
+	if ((queue_type != AMDGPU_RING_TYPE_GFX) &&
+	    (queue_type != AMDGPU_RING_TYPE_COMPUTE) &&
+	    (queue_type != AMDGPU_RING_TYPE_SDMA))
+		return -EINVAL;
+
+	/* Clear the doorbell array before detection */
+	memset(adev->mes.hung_queue_db_array_cpu_addr, 0,
+		adev->mes.hung_queue_db_array_size * sizeof(u32));
+	input.queue_type = queue_type;
+	input.detect_only = detect_only;
+
+	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
+							  &input);
+	if (r) {
+		dev_err(adev->dev, "failed to detect and reset\n");
+	} else {
+		*hung_db_num = 0;
+		for (i = 0; i < adev->mes.hung_queue_db_array_size; i++) {
+			if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
+				hung_db_array[i] = db_array[i];
+				*hung_db_num += 1;
+			}
+		}
+	}
+
+	return r;
+}
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
 	struct mes_misc_op_input op_input;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..2c4568951edb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -41,6 +41,7 @@
 #define AMDGPU_MES_API_VERSION_MASK	0x00fff000
 #define AMDGPU_MES_FEAT_VERSION_MASK	0xff000000
 #define AMDGPU_MES_MSCRATCH_SIZE	0x40000
+#define AMDGPU_MES_INVALID_DB_OFFSET	0xffffffff
 
 enum amdgpu_mes_priority_level {
 	AMDGPU_MES_PRIORITY_LEVEL_LOW       = 0,
@@ -147,6 +148,10 @@ struct amdgpu_mes {
 	uint64_t            resource_1_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	void                *resource_1_addr[AMDGPU_MAX_MES_PIPES];
 
+	int				hung_queue_db_array_size;
+	struct amdgpu_bo		*hung_queue_db_array_gpu_obj;
+	uint64_t			hung_queue_db_array_gpu_addr;
+	void				*hung_queue_db_array_cpu_addr;
 };
 
 struct amdgpu_mes_gang {
@@ -280,6 +285,11 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+struct mes_detect_and_reset_queue_input {
+	uint32_t                           queue_type;
+	bool                               detect_only;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -367,6 +377,8 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+	int (*detect_and_reset_hung_queues)(struct amdgpu_mes *mes,
+					    struct mes_detect_and_reset_queue_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -390,6 +402,13 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio);
 
+int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev);
+int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
+					    int queue_type,
+					    bool detect_only,
+					    unsigned int *hung_db_num,
+					    u32 *hung_db_array);
+
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		    uint32_t reg, uint32_t val);
-- 
2.49.0

