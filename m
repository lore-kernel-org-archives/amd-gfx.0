Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCDCC71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3505D10E485;
	Tue, 17 Jun 2025 03:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zzbHaN1A";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D116D10E486
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEzlf0uTXjYxIMSlnJhKZBw/UgLvF/aaYn/oIZW2pVUrZlCeFZkL3bNrqD49LfCzXWnBLME134ji4eDjGMcQ/vldXhtAVRA76SWsAOx2CSL0pQWS+hORqUMQebvHVtSDO026n1QtW+FBfqiWxb5C4ENxZte26WLW/nXuWxCTOvLXugY5BEq8r1pII3NVBLubxoHcH7QirO83Os3h3LdvQxRY9m3XloOQ+duyeOYdjju9FKwxheFnHX4jQHja8X/yLrGPI3S+gHXSCtcGHT4+7pQvrkdCgSW1sc34djTsEurvepzklQBuES6KODJ3+gIVzjoAZ4SAw+Z0ldUAfmesoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE/3NaocDg1zj39EkN/Hwtt2Ad5uUfPCbaqILGo3pzc=;
 b=Zi4PSHUozsjrBDELxUGZfVdkz0sjPBPhI2Mx5hu/O5m/va9N68vrDJPxF+zhTC4/2rGfb1AjLplRE6iydXNiapGVrE8oj4ill/mfNRNG3gqCBDOdIowSbkzvJ9waYBkoobvuW+8AWWnOKPCx7buaPQvhDD84G7Y91nQg/sAbZhB6EIB+n4amX3//xsXh2Jwlpc/qEAPESU2+RaCKpENqTWYuHEFUgPpIeXqgo6V9N7megvpmbua0VZO9HyG44w+wINACB+TzVeNceqjO80cfgmx0IUG4NEo2cUYPHZo30+JbhWuxQALs9gGUDYXxKy5QUO+6n8JbLofCI4pPANdIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE/3NaocDg1zj39EkN/Hwtt2Ad5uUfPCbaqILGo3pzc=;
 b=zzbHaN1A8Mg1TYwsyLrfAdz6uLZfPZl0zt87jdQxOB3Wqf7BOXTjCZ23jDTWPacbRH0OBoexTYgcH1CIRuXxEgSO72aEHyYtku3bieodw7qxqW7UmHlXf/9l+khZwPuU/9s7KQEA8yigwkYPiCbIAAIqzt5yBR4ym3qwQZ5ssuc=
Received: from SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 17 Jun
 2025 03:08:57 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::77) by SJ0PR13CA0013.outlook.office365.com
 (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 03:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/36] drm/amdgpu/vcn2.5: implement ring reset
Date: Mon, 16 Jun 2025 23:08:14 -0400
Message-ID: <20250617030815.5785-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd09a38-11b5-4ba4-2904-08ddad4c4c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JfTWyFI8WDeUNzqsipIw/ljHsoizt7AKr5N6Gocix7+Aooj4L/wN4Jf3cVZh?=
 =?us-ascii?Q?5Fusf6qVHxkrFXcPjZNIw/5bLAS43rZAZ1a+Pep+On5Oe9Idsak8cEvhAVo7?=
 =?us-ascii?Q?F1n1/dgM/e+DSJ0NxvGnZa2yzOhGZ4zzc7pTss1EDn+yvfcZXNCyphdrura9?=
 =?us-ascii?Q?P0Ti/G9YEg8UwAVDqHuL3oT9bpKQ+do5jp0mSz6mrLEYUhnmQ3Eb5vm5ExxX?=
 =?us-ascii?Q?sP54wIhx8CLtjKj2zj6k/7A2WlmOwmPkkmhpSbu0S7tzLtyX9DW5pDs3MWk0?=
 =?us-ascii?Q?a+A3hWtbfzc+aZmkNGULDJWLHk/Kne+dqZiAlrZ0RI/qbpNyyL/1XGUZodPc?=
 =?us-ascii?Q?IjcskJkmc2BtELLxS51extGHGQ+r8g3fNCClIrtIDjdFIVFi1BNKnJysVPaj?=
 =?us-ascii?Q?f994LcRcguiRfci27hshEAo7fGNNBxEteqj+LTUohuS3RgLD3VEpagaK7byW?=
 =?us-ascii?Q?pB9/h77xFe7nxfZXPEZQneeKNJTjfS1EPWzubtSZv2xNXIw4B7n7QI7Wf6/A?=
 =?us-ascii?Q?Cn2WPk8bhyLlwP9ZtwIVQcaQhyrO5q/5+MpASNpJAsP9ZB25hqKu7RKrNu6X?=
 =?us-ascii?Q?EFQ1ctnds1GWUcd4ewmVClwQha7LaYZ7jAJ3xGaPP27sdPjMlmRiybaO1EB0?=
 =?us-ascii?Q?5tFPgV1gGKI/NaXwj3DQU7a+dCAD7Hv3GpA2pk41N0GwFcXSjOR6E2um/AZw?=
 =?us-ascii?Q?ifdemWWQ6bfdUWCQNeO18MQMzFl4/wmfq3Zgq6r+aeyOHeJR08qAScORCj31?=
 =?us-ascii?Q?MYfS3XDf0PxLf/Q4LdBAZLGN+V/9x9X9OfIHakh7iw+th2gMMaLK1g8OCoGX?=
 =?us-ascii?Q?5Kji+cpfGppgY2lmfS1q8a/8gMzTa9vLs6UZrczlfhe97W5b7L8FPJZp9TRa?=
 =?us-ascii?Q?ucgLf5EAra30qvyXS3W+TgJ4jUCIp9FfXnfCpe+aeksZrR6KXQOQ0AIw95HD?=
 =?us-ascii?Q?PDwFt15gHoWorSg3jlE3DWP/6Ok8Abk35YybKRNOf66agfBk6FxWT6qQIID2?=
 =?us-ascii?Q?bnzk3pYtmadSUEY1Swy5RzloZE61M/fkxJkLxmUA7XVYna6NVT+fxOAfx2Zt?=
 =?us-ascii?Q?ULlMGZTlsEiYm0ROvYZrux0OxfFTCyW4Mzhge17whxjGs0FS/Tedu/1Tttoa?=
 =?us-ascii?Q?5fSzxED/5DXic54rr6VqBRVo13VE6JlRNAMZhx5EeHjV9GwzAs99kcsiEAKu?=
 =?us-ascii?Q?pOuqwiKhe3pf/zkSnH/5Osg/oyRJTt3uLGziKttegWzRYsyCXz5Hduvkr1p0?=
 =?us-ascii?Q?qQCnqVZtQmvelA0cdH9T33Fy4J8x4eOhk1AbiXWdlNtQylCAV0VwkknNuofs?=
 =?us-ascii?Q?j46v13TKdRP7ZvxAzSYrqoIwWn8k2rbLVYF/xzH/n6Bi03k/KORYp/9hjYbt?=
 =?us-ascii?Q?7ddQLo7IUql+RUfzaa5wyWvlulPQOw2Kyqw9aOXvfID9VnNNgQ75in/tNOPN?=
 =?us-ascii?Q?o9MWumg+Aqi1S4pPOVZpop110bEklXk9OU7My/JJysJAsWOXmht1OFQmyQtV?=
 =?us-ascii?Q?75vtPn9fRnfYssBhZcosaobn7oBc0U7mcr4D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:56.4773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd09a38-11b5-4ba4-2904-08ddad4c4c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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

Use the new helpers to handle engine resets for VCN.

Untested.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 58b527a6b795f..9bc82ba3537dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -102,6 +102,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
 static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst);
 
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -404,6 +405,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[j].pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
+		adev->vcn.inst[j].reset = vcn_v2_5_reset;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -1816,6 +1818,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -1914,6 +1917,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -1942,6 +1946,26 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int i, r;
+
+	vcn_v2_5_stop(vinst);
+	vcn_v2_5_start(vinst);
+	r = amdgpu_ring_test_ring(&vinst->ring_dec);
+	if (r)
+		return r;
+	for (i = 0; i < vinst->num_enc_rings; i++) {
+		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
+		if (r)
+			return r;
+	}
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	for (i = 0; i < vinst->num_enc_rings; i++)
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+	return 0;
+}
+
 static bool vcn_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.49.0

