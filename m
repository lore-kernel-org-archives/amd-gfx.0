Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC1FC8300F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF0F10E94B;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1y2GPf5";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B9B10E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9ze/torlBrVSD4+RdxKolIiVjcW+uhkbozSkmqwUy/6UbzPt8VkeB5fP42p129wBe5YEW/27nI8vS7v3N8cWe71O6nAkB1GkNmxbx9NVgg16Ew2gyZ/63gTjrCPVPlhHWH+hA4h4Vg7i8ioPXlewyST4HmCfv31Nt1e6mDXODVTmhwakZMkgFKtYl/1kuoi49aGYS2gU8dDPfu8qnHWobrTuw7RHFnURwcH3FPaEv8Vd7nZQfjlffIAqoRjTsve80uhGze2/9cNQHgADrUzuOImmcxwSczyCI2LgNgEPDtyEzl2UfHTb6+ProGUicIMBe28a0eAO21hmFYO8QlKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuuxQp4wlhePGcrzezl89et6gR5vKyp1HWv0A8c8vkk=;
 b=f95Ry27iunfbmtGhe8m/bHDrCrEEqfSjUuQSE7Q8zJeWy4nX/ISMD0mnjhV9JY07v3DAeFbCbW+cMh3+51F8Sdkw/aMHkML1lf+cYWZmL0xuytstSeqgf8UfnQoShlzzyxi2F10ry6JIZNNIorY2wF5IMAZgOK4+TdbIP/HF941CVH8prMJ3z8M8Z7jX8OBpr1t5ULErl+ryx1P4ljMQSOsCEj/LS+oGWACFRiXAie1VggzWsmsaE2Os4fI1B1iPn1xRcBv/skCppBtcPJkGZwkWDjvAqaO/s5p1/yG/kofherfHtmhryR2Vil18//Ryu9AIcBRVRY+jr/zRxk/nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuuxQp4wlhePGcrzezl89et6gR5vKyp1HWv0A8c8vkk=;
 b=v1y2GPf5vHmA2jRTg63NQroMKn504aebV3W7AH0ZpHubnF6QJwaXD3I3j551F8eOPzcNEE92Va9zoW47py1m0xb9Nzw5Fh47HmPf/t3i2BHcj/rAO+n1Ura0MisriAcqm5govfPtQFa6eTsqMYjE+h9dC9d+z82qjlivMxqHS+8=
Received: from BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Fri, 27 Jun
 2025 03:40:43 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::4f) by BL1PR13CA0197.outlook.office365.com
 (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.9 via Frontend Transport; Fri,
 27 Jun 2025 03:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 32/33] drm/amdgpu/vcn2.5: implement ring reset
Date: Thu, 26 Jun 2025 23:40:01 -0400
Message-ID: <20250627034002.5590-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e77ac6-1fca-4752-69cc-08ddb52c64d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fUln3l1+tU7zMTZfdrwqU6vwM4j3MEKG3FznFifYZBSLQR0jQb6K1LGnM40Z?=
 =?us-ascii?Q?4SJ0reTAxOpJ/VEd47KdHdQBPuoiWl0063GpdSm3zA/wkAOeVj3zrUjW+n3Q?=
 =?us-ascii?Q?HRF3pxuHhfjdVQxAQMqpsemiIu7j2Mumom13YOA3PVrlqHjLxacNixIaiBLV?=
 =?us-ascii?Q?XgkcywHuySWRL56KhL7kxYwB4VElPVpyKZqc0Bjp23NX8tbqR+2yY8E+cxR/?=
 =?us-ascii?Q?sIkorUd1gpRJZb0sOSCHBfxzJWiAyZgXDt410rz9NW5QR6Po9IlRSV28R9hJ?=
 =?us-ascii?Q?PJCAJH82AadI9psJvtr+bTLor2w15OkKBjyVGqe+ZAlFJu33cRHZ5836lvsL?=
 =?us-ascii?Q?/lY4LpYugnZfl8fs/pinbAhiWUOT3qrS6zU30J5AVLZQJZ3Zb4aXQetfwizT?=
 =?us-ascii?Q?hQ83/4U1MUDC/gIXVvt+P9v4pQalD/y3YrlFQQRBPQjv1sQ67BMkkArF7Cig?=
 =?us-ascii?Q?ytohYl9XFT2vWoexKw/b7pz+PUBmtPN8MBXNQshcchnk2B4NnJ6pbyEf+PcB?=
 =?us-ascii?Q?0gZqlYFKFez71FDCWSLD/n7/YmhXlFipcKGHogKrJ6mZT2UT3RlE+RfIKbn6?=
 =?us-ascii?Q?Def/FAmo22xlzthsxcfLrmwo9+CUt7tOXISWQGes53ssRNJvsQoH9lFoDzJ8?=
 =?us-ascii?Q?ec3GZhGjjxc9bHgfjRUUhCirkCGh9XPpsNkyOdvV/ZpE17jUWvIhA8oOBQdq?=
 =?us-ascii?Q?Qz/oAopAnVzaDFBc6olGkWQjtuptvVy8aQXpLl2bPfDeFTqfKpSvTkqeDBdS?=
 =?us-ascii?Q?6FQj6pqeRMZzsnSAMG62cvwa5mqFZITMLwrjwGKLsjLHvzTrt9sMxOeG8hjz?=
 =?us-ascii?Q?TVPohpVIAIvy9vr4gf2FjeSIPi4R4+mIK1kEeMTjg5eQj1EC/7LzQInxFCSx?=
 =?us-ascii?Q?vYAPaXE93HFMepLOAXoMcXzhCNi2u+CQLDWgqEhs1Tf6WZpUAS0vGIVyGAdK?=
 =?us-ascii?Q?Orsa3ht/J9zLEyoDb5/CdH5p1VumhNkQuqbkhqstE7d4nEk2B40qwUs5LL1m?=
 =?us-ascii?Q?ChzCF3BRU84+gr1vt3FBy6K4DvVoFzapNrPR+shK2biFW5SDJGIuwxCYDuao?=
 =?us-ascii?Q?Xcvfq/uwsICXQecC4X8TZ2JzT/Cv8HBebNvfQyWWCMd6wUI30PgltYmgzhKf?=
 =?us-ascii?Q?PUBaVwQDLfBV70JrAfqV7tz/CRxTSyd5olowv9EOCTNm6VGvIUDSzj//8MaZ?=
 =?us-ascii?Q?MD94BWtLZohr5SZS9oqCMK/wDSMttDPieUt1jgxG/PcxzABRSuavT3msywD9?=
 =?us-ascii?Q?NtJZTD/m/0kmo0toQebUDjfmlpJ4mBC3huERRWpFKD46DYxXk7ei/L4Hy0y9?=
 =?us-ascii?Q?QNpOEhkPcPX+qVRRqPHsbYayWIsg3jOUU9kP6gcC2qS4D8CO+vG901BqW+oC?=
 =?us-ascii?Q?cuHU19f6+2QdSai36bbZPY9pcCnQkJKhBHtIu1AMg58FHGQ+93eWZD3BDexI?=
 =?us-ascii?Q?lHmZs9Npu6HNaWfTHvvxU9lpWe0RyHTEq88EurhHqaSg+tEHBgzbM4rUpSjp?=
 =?us-ascii?Q?eStme3Ex8L3PQMAx66xfDwCVNiFK0ZJtVbuZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:43.0682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e77ac6-1fca-4752-69cc-08ddb52c64d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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
2.50.0

