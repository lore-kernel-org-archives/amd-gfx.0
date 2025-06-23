Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A451C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DDF10E41C;
	Mon, 23 Jun 2025 16:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G94oUKM4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A834310E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX/866aJfWvVKV2IqLWPOj1yQwe1RmvbB5IbY+mC9d7jIyINnsF3O/GhyduGESbCQMkiPAFc6/6hg8euMV+fqQa9B3fu7W4nb+wHw7VLEBgtQ1z6Lw+AqDxD18/xQ/eSCevvk3X0ZGwgfrxLqjUl7E2W7cDrAnNKvGy/DBvAGpUa/gPRZfcn7Xvg29Z/H2WQ4bg7pVW1wK8gyqK2yLHmIsgaoGVc9Tr/leKeRhilOD1+hQEtgfL+2qYkWytGV1+yqt4UGM2oSQdnhtEfTIAK0x+Xboq5XDXgfqmrM+yQ4LEGrAyrkSK/7sPdzWlPsX6ObB/PyiEPVYk1cTfHVLbwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgzoqQVv67+HNx9K21K5YqtjRUF9JP2h1kM14syhXig=;
 b=vc8OxPr2EOM4spJUwqcO4iWjp8KdQAMhx1rL2cZpQ7jMFHjIR/duXoTFE34cPEHH1NqRi0aiP57qxjzJAKWPa3e0g9XfbESLng2FvixCuG3gTRV2b7137hnuAfIDYc4JaMzfz266XpmZXMBLsH8YcZZvr5gsW9eTw8X4c/I3iKC8uCiek/CGC4RUKYgD6oEOTeFBQwAZ4MUMWc8Ir5DXU5zG9lEzB7hBzTa8LesIGGJp/61UFG51MXW2cnqU/x9STUKyBa4MsIBCXVpCqtF0SEUsEWooNQh6aM7GNmBGWEIZZmzVSc13Dx3Ne3k5tKpiB2jyI4feT70Aa0BSsio0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgzoqQVv67+HNx9K21K5YqtjRUF9JP2h1kM14syhXig=;
 b=G94oUKM4qnPzC+ZzhuqPCimzbEedqKgd+8b8vMV93p044nqsDgDvuddXtmzKzUWJt1j4NZlE9GmB73QCzaWmZDoxZEN+aYCIfBEh/uxCR9bb7d2dqu6hSeWJu+QHogwCYJFFQa93eW4STs1VClSRxnZi4IzOZruYNQvvo5lf+zw=
Received: from BN9PR03CA0940.namprd03.prod.outlook.com (2603:10b6:408:108::15)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 16:15:14 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::d7) by BN9PR03CA0940.outlook.office365.com
 (2603:10b6:408:108::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Mon,
 23 Jun 2025 16:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 30/31] drm/amdgpu/vcn2.5: implement ring reset
Date: Mon, 23 Jun 2025 12:14:36 -0400
Message-ID: <20250623161438.124020-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d241984-3acc-4ab0-8e39-08ddb2712291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eVUI4WNIPe5n+1B665aGGEd7cuN+uVFCY9/tXGXsD/08eyVUmzW6kKovBOYS?=
 =?us-ascii?Q?QmNMHdtHo1si5OVNklf3C3rul1aOQmwy6AN0FZGx8dCMrQlbRpx0PT7o+Ez5?=
 =?us-ascii?Q?wmWzqoXTlPBYqAaXVGDJM/lD2VbC2Y2gdb1jpcm12b89+GCF1mvc/lyRkrMh?=
 =?us-ascii?Q?dpWX/XvT+vbo3MCtXnZWtUkUzDhBOiSXjHawwodtchG/Tg61+i8tiTIWZJNQ?=
 =?us-ascii?Q?d9Jnc+yjVeIDRKLm2oGnaNo6JPN46p4B1E9qjkTX/MjV35BUBDH9qOSIMBhe?=
 =?us-ascii?Q?eLwR/6gV+q/k06ZjJ0DFvwqFRYHvpiqxaVsHSWtuAC8Y+wFOtoj9CmZ5FgaD?=
 =?us-ascii?Q?7Mzq/cB+FxlAsE5fW0qCZ7uzDa4Agt4L4IBs/Pw7YlyYqQDkKw9SapIs8iD+?=
 =?us-ascii?Q?yrKPqZ70hNVLzaR0WWYI9wsqNSX2LJd8y/YvjfrNUvj+dW1lwgzZ5pa9BBAg?=
 =?us-ascii?Q?d6vi/nwzxjGeKArZB7scpZxnMbVUQC3PTHCkPX/yUzaUzJZm2dZG5EFpRJSC?=
 =?us-ascii?Q?aKKpUy+GlHHbkVx2boFEG/FjvnXu++MQFLe+DiAitMhvKftwbIevqYqMKreU?=
 =?us-ascii?Q?fnXQPPgt7P1T42a30mi+WL/y+USr/1eKNwp16AZZyR6eCRdP1JUKT0K3WQ/H?=
 =?us-ascii?Q?6Jy6stHYLGn4cvmLkJZtbpHfIbMUpm6BFB8mwapCdN4DoD25Qb1519x+NACX?=
 =?us-ascii?Q?J4IbS9KSPhEmM7xJkNeRSmAx4mR6xQ+HBJcezEwbQ+JcyGLKWGGBkqIAPVQB?=
 =?us-ascii?Q?vQxaD7C0LlILpKUn+3qqg2jnC9zIqFdao5agHap4orpKtn3XbWfJrbUsVGLu?=
 =?us-ascii?Q?FSgFjsj45g2MwT7hEk2fmvtFkY9Pls3JyEs5x+wN0FcvcoPrYhh7MjUNDW6G?=
 =?us-ascii?Q?rzNJEIYoJmp1eo4EHaLn4rpUvlmsUXeqp2K/AzOhu7wVufpHiUkN5pGZwhrw?=
 =?us-ascii?Q?PRI2X3t715hgJhKNoYS5B2j8pDme+u9w4kvuyyoMwStVmono5mlTbPHM7+Gq?=
 =?us-ascii?Q?Q4s1g559HujPjn+whnY7oP+pKl93Z4gsR2FOuecAerrilkVmd3pSilIKWxAr?=
 =?us-ascii?Q?n5XPp+mZWZZ+nUvmGaap1lUrQ2h9UGnJodDDESuu9ibTPj4rBH9bpxm6dglA?=
 =?us-ascii?Q?K+U1/wFipywynELSsa3mv+8LAkuQIMYMge2RxMJ3wQKkN68HcHRwUNMSZfdV?=
 =?us-ascii?Q?Hc0wdyFdhG1ZrlkyvNBI0i/i0pONkovmCyi7dE+birn4oojqgRshaKpZ7Ze0?=
 =?us-ascii?Q?zo3KKZQ+RXF14dFFhlPA3spQPun2oDIGWq9otxpIPKl4hlnxcZh4FyFYSP6L?=
 =?us-ascii?Q?TF3rEFuhM+1TyV1BkI1Jv0Jo42gWiaa/+6diQa7Llmj/gSK7/HCF41wpab6c?=
 =?us-ascii?Q?ujMr868jrJwgCMQEv9I1fDc21UkSFxmwOxabObwmDRwBF+prFZesd4W9F0QQ?=
 =?us-ascii?Q?8xqhgdoU9uzVRTfWw8W2wmtvg8ye9LDDtyw02Au6zqcccuoIjtfvnHPx8/eU?=
 =?us-ascii?Q?t+beuA6m6SuzNxqc0lARg76oYldWYbZt7Mr+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:13.7072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d241984-3acc-4ab0-8e39-08ddb2712291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 58b527a6b795f..49ec4a7775f90 100644
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
@@ -1942,6 +1946,13 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v2_5_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v2_5_stop(vinst);
+	vcn_v2_5_start(vinst);
+	return 0;
+}
+
 static bool vcn_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.49.0

