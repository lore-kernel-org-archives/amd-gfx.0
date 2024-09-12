Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3E1EEB583
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 10:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C17310EB3E;
	Thu, 12 Sep 2024 10:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2xwJ19k4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE6B10EB3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 10:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnqFHMqou6h3EZ278Bef3gAd8/W+7ebvPbVvjBqhvdso6ZVjwriEdBeU/kgtXXIX7bxDlPEAj/WGg9drCoQNASXGyb1YCRaGN3TJRlrjPvE8H7ZYs5xy5Y8tgk8WlC6Bl27We+ibB7LQjQdo54NuS1fez17TcqUH/D9kLKgz9cqXR6TAMk5rL0numJ0crklRXvT+OIJ2KAQ+vtMO6q4g6vGjwct8aYW5RByGMj8Eme2z+FMGQcB0bSvi3CWbsnUrckTvZtLy2+54rbM6NTGP5z1rheDPxFf7effQOPoffX3FEsfEio0TVJq8B4AYEZqn7E7VszXUBMLmjDaHiwVs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ttb3J6oUncoA7LWFiLhyj6ONXgLh3Y8Aa8CTTmKVVsg=;
 b=wrTPid90VhanbEHWfKrXhJjgx88MjSJuQ0MgylZ7l1rctsW66mE7yuRxR/t7omhkWiqOQTopx2NXRPkd+Ssbqd5IAEddMSyjzNRyKrMOw4+kL6dkWFXH9cnl2Erji6FwhJ2x5+LLkshk8McOAD2ogDQAigZtcD5jOuNrLqQDn08SRUGxxv6juuM/rDiOOGo4muoKMKjux3H5b4aE4O1dfYJnqQI/sDtNmTDpQZQJsZQaRSwVt+kSquapf3cgo9/ySZYy5C6QZ8iykPaqkz/Azf7Jozxkv6DSTeEiptvf15NLNrj5X/Tm9wjntWuqVBKZEctTsVdGAWcPOhD3KsPMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ttb3J6oUncoA7LWFiLhyj6ONXgLh3Y8Aa8CTTmKVVsg=;
 b=2xwJ19k4CRWSKYae0VFaqnwM+mD04WBx9ihZxgqoW4xJMty9UgxD1elV+UxuXCVnKsITE2SbHH3dxuYKoOKTXFYGf7h2BKkOYsxTByqcDadJBrvQYbpADfz4N1kBxbafBBrrTNisPc75cVj/NgBpYLmud73UiYHdZNzPq6jXZmw=
Received: from CH0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:610:e4::8)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 10:02:06 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:e4:cafe::f3) by CH0PR03CA0183.outlook.office365.com
 (2603:10b6:610:e4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 10:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Thu, 12 Sep 2024 10:02:05 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 05:02:03 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, Le Ma
 <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add psp funcs callback to check if aux fw is
 needed
Date: Thu, 12 Sep 2024 18:01:41 +0800
Message-ID: <20240912100142.599746-1-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ea0843-25ec-4220-2b5b-08dcd311f52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?55pLEFV6d/rRBRr3vOl7AxxFi3znwNKLP+RA6/woXRWFZK7pr7QPkxQvTOdf?=
 =?us-ascii?Q?FNeCS2BdztPWmTakdMbxjA3IRqstjtWGfHsb/ssohj8I4ASoyDBsNR4hMKgS?=
 =?us-ascii?Q?bA6KqGRb3bKCdg40HbnPZhPKjw9vuIO6qThQBJEG85d9x+txYS/D0yNoADf5?=
 =?us-ascii?Q?ciYHnIQ00lxNSv/a01VtizthN/qi7IEy20L5VSpM4Nr3Q6kenYkXsHUJSm0Z?=
 =?us-ascii?Q?PRxfI2qskjSk1f/tQU2AApxTNEPjfbLeyei3QX+ILSWk5BTLD8NZL6v1fLgu?=
 =?us-ascii?Q?xpA7QFxw1nhDIPKLwRqIzCwV1N/yUwmDZFkg5EU5q1I6SxGMrGzWtQoBSENt?=
 =?us-ascii?Q?gvAd4hqV5IXrOPVMMy2b2JJEMF+TvnIfYKYAp3rs9O8WitgDssORh7fg2amJ?=
 =?us-ascii?Q?PMDoIoLLHmGbgh+lh4PmkwJ5ms3WjDzX8F7GmW/IElVx/mpFouAdPNQb/Iod?=
 =?us-ascii?Q?4TpKeB8nWmvn7hdh1tjXV0Lcj4cetX1Je7yTLHZa0Vl5ncET//J0fo+RRTZW?=
 =?us-ascii?Q?t8Xm967sMAyomdAD3QNHjKEAXK1n9LBf+Tn+ZAJARyxdTghmoJ1dGrCEtz6t?=
 =?us-ascii?Q?1twdOCY+Qo+7zdPlrGvW8M9FgSoCECgCLkb+pcHA6Rw7W79Wn++3GI9qKN2T?=
 =?us-ascii?Q?SyAGmmtfbp+g4JFrGztPbMLSQBjpyiHOlmtPVEn59li1VeeJX5hoJ9Zegxmj?=
 =?us-ascii?Q?RIrF//toW4faW4Sbg8wVxFhsqh3JX3ZEblvNYqLn9fCD2QDPTPtTmKttLSYn?=
 =?us-ascii?Q?KwR5LPnNRFz9zz9sjB99UEFuMxBi4/GAKYd4nhEICEvFyjDxOqlzvF1yDQ39?=
 =?us-ascii?Q?BBkCt9TXPcKuk7tzbZFMGm+QR6lUzI9KgCJ8g3CAViSP8WaHyQIZTixRJ39r?=
 =?us-ascii?Q?KGVElF8pmrl6dgZVS0tR+HAYH5iAxCkKrlOGRrcuKeFtMXGKjq+ER/YaL+Ww?=
 =?us-ascii?Q?AqHI7FhaofwokbfkBEtoQombmAymx1/b81l8qoTQWvdi+79JSnKC6nx1EpHf?=
 =?us-ascii?Q?VkkTjdclMliFChPhxN5wfQgydV6JIrXNRxouw3oWrh0keuoafj/i4iHfrmXF?=
 =?us-ascii?Q?QsfzxPPf3aloiaxAJxoigoVHHNGX84hIsNK0FcmzFmXOUor+7+b2P1BKSpon?=
 =?us-ascii?Q?ns5HlwWEVLqoZHHHuoJfz0uHXAejWsv1v6MGsjvDVATC5uYANVRZZSaWH3pb?=
 =?us-ascii?Q?YKy+tSeIDBrcwlHkxCReG0dm0njVLlVjAjFsUeuApKFZEVUi18jv9SQulPcq?=
 =?us-ascii?Q?VNGKIZiduAYRig69ovt64xRS9/mJ/06F/Gda6HMmsQlCc5Rv6iHipc07iX0+?=
 =?us-ascii?Q?GNxQc/iqX7yWrIKbe0yGuUdCOKy9u0DnpX6i18fVcgqA3QDQpqNRDBtkS7zp?=
 =?us-ascii?Q?n5QZDLXff9Jqi9M+wH/S7vVw5ytp+YgjjYQiYk1jV03zGUgnOQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 10:02:05.9916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ea0843-25ec-4220-2b5b-08dcd311f52a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
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

Query pmfw version to determine if aux sos fw needs to be loaded in psp v13.0.

v2: refine callback to check if aux_fw loading is needed instead of
    getting pmfw version barely
v3: return the comparison directly

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 74a96516c913..e8abbbcb4326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -138,6 +138,7 @@ struct psp_funcs {
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
 	bool (*get_ras_capability)(struct psp_context *psp);
+	bool (*is_aux_sos_load_required)(struct psp_context *psp);
 };
 
 struct ta_funcs {
@@ -464,6 +465,9 @@ struct amdgpu_psp_funcs {
 	((psp)->funcs->fatal_error_recovery_quirk ? \
 	(psp)->funcs->fatal_error_recovery_quirk((psp)) : 0)
 
+#define psp_is_aux_sos_load_required(psp) \
+	((psp)->funcs->is_aux_sos_load_required ? (psp)->funcs->is_aux_sos_load_required((psp)) : 0)
+
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 1251ee38a676..51e470e8d67d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -81,6 +81,8 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
 /* memory training timeout define */
 #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
 
+#define regMP1_PUB_SCRATCH0	0x3b10090
+
 static int psp_v13_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -807,6 +809,20 @@ static bool psp_v13_0_get_ras_capability(struct psp_context *psp)
 	}
 }
 
+static bool psp_v13_0_is_aux_sos_load_required(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	u32 pmfw_ver;
+
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6))
+		return false;
+
+	/* load 4e version of sos if pmfw version less than 85.115.0 */
+	pmfw_ver = RREG32(regMP1_PUB_SCRATCH0 / 4);
+
+	return (pmfw_ver < 0x557300);
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
@@ -830,6 +846,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
 	.get_ras_capability = psp_v13_0_get_ras_capability,
+	.is_aux_sos_load_required = psp_v13_0_is_aux_sos_load_required,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.43.2

