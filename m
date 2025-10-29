Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C69CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A3910E786;
	Wed, 29 Oct 2025 10:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u9KGzKa0";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C31610E786
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiI+m0y5Lw+RGDX7F9a6yebJY5iw9uML/bj0+ox0QPj00dTR14nh4wg5RSwHnGKYMjMv5bIyJYlRr0k6IAILCyMToRRnNT94hX6jWyrFGvnmC79IbQzUsMw5hTcU+Xhr0n257Xk6GG7M05bmYYJSYfcOCbK3eIQk1SFlkKUZWupPli4R7CuiHnM1ngrStyN0I3emBrNIVbHZo9Ylely97SfNbn00+xRAIUfI8vYXIqLgh6/e6HvUcpap9p4nbzODJxs65ce3BSnt1cJjlInCkJIpXS3Q2V3E2NDyFzChgx+Aulnwys6RQTiEBDImNVD+IRaEUIgdGOy8dqxlfauvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4VEw3BViBKOjk+0f0XAMPIja+6Sg55lIdictckc07M=;
 b=qtKjHwAQbrCJw8QfA8LjwwKzv8VdNXeI4sifzjP3Ws5bAJDU0Gn1H74fj2r11Frk8Cgio2bGQUGWzN+3ZTk7CEDNLZyOqps7nhDfVGf73gT6qcqBu+lgK8GyZ8A5Sw+LIVvmVHdpv/bwmIG2sh0yCGRO6e3w+cQAJuddq4YY0cC+pqD0NBx+LrUBYtwFQpk5PO3jsl44ixjIc0WWjuo1x3Ew/EqlxMWIeadHFh0U3kThbY1DAG4UKMK+VhZFp3BAnhzldMlJ2urMA2ql0i4D9PW1lFec2NU+K/cHmZrRWeqq4YJx9KuFVOPiXSXmMlHyzDQ9RkWJf3fPDPO+rPvJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4VEw3BViBKOjk+0f0XAMPIja+6Sg55lIdictckc07M=;
 b=u9KGzKa0ySNDyw1Ae5K5ARW15RC9aIHyXY15FmeFFMgKgBaVmNLHU2mETPQ8Ec/EX6PfIZABZPrNkDgTl7wI8TJoxAuwjup6ZQ7/cKx7nlZHp1vjbScGOvHUCQ3vSUF904607+1L+LP0/qPNYnqf3+W35dVzuneLpRkE7EEJSO0=
Received: from MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:38:13 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:237::4) by MN2PR15CA0049.outlook.office365.com
 (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 10:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:38:11 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:38:10 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: make MCA IPID parse global
Date: Wed, 29 Oct 2025 18:37:55 +0800
Message-ID: <20251029103802.1402199-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: e79199fa-6b15-479a-206d-08de16d74240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?isYmOGJt9jcLVuTxQkDrf83uatSCYcFa/ALIldY+KVH7vSlqjV0pWYGQqkaB?=
 =?us-ascii?Q?m2e6CsoFYIsNzDRcN1Wn5pglr7UzH5/lwRB0HMMblAStSPOdLi5X4mqUj50m?=
 =?us-ascii?Q?AHhQsPQmngdDH8xlj8mCHsy3Suq/GCpurxC3CYwQ1V89v3LpsodCBhhd3JF7?=
 =?us-ascii?Q?yF1/ky5r03QsO+ihXz+vKRXMybTU+baeMtLIj2dMqtmtnqQndckqEw5RjUb6?=
 =?us-ascii?Q?oaYsBoHxlLsM89YKGTfzYMdDUEq47JNc6sVMfd33AYS2yt8JidqqIvewwXxF?=
 =?us-ascii?Q?/NJsKAfUIAquXPQoiDR2t/gS9JKnWCu4oABG9QauOLzFH91THj+KAcwJ2x8u?=
 =?us-ascii?Q?FZf+s/cNqr+WlkPiV19vfcPYzNbnU8581Xd57udxdUcV1WK/qgKwQgzG5/1Y?=
 =?us-ascii?Q?WCWYei+VuT4FS+GLUwQFcwuxo14MH5L3QlmEWqh0+ssHy8+P/F/kqo/0CjjN?=
 =?us-ascii?Q?rN1lCdpA/Y0zjtHFq/LPD5K5aXGLUa7SlwzbPbjSQ6KOqoXa95JNoJQCcJoe?=
 =?us-ascii?Q?1c76xJLGaQgbLvrol8mtTuL7DXv0WFXUjOeHKBjmaaSqLLBkdkVdRN726DZP?=
 =?us-ascii?Q?s3F1iy7tnxrTeXMPlXFsfI0P95uBQmBX0KUH6nUovQET/v5jMifXp+KCLsgR?=
 =?us-ascii?Q?B0a5HdhNYvydMA0W5iQO+PdtnvM8aMpjrSqJHc5Qfo445nU03VyCG/SEtGBj?=
 =?us-ascii?Q?i7S7i+jRvFuwa7P0sk5BqR3YFeaYjf0ug3RL+78zf3pvxMUSpLKIM32tNRqY?=
 =?us-ascii?Q?r5MHRreC+V6Duvwtjr9IYP/tiB/89wxkZvQWZ1+SL30VnOSEJR1+Kbxpnv+V?=
 =?us-ascii?Q?mKoN7HC8MiXJjSl1YOJhsUwSBeX8la0wFU8XAPQPd9T3l9E3tmXiasv5zW4/?=
 =?us-ascii?Q?NzQ6cpklZRCSr6gI9FKEoRWyKW5hjKtvlJvbgR4igZaCGIqRuQt3ZYD0n59m?=
 =?us-ascii?Q?JGXPBG5HcgD6jREMZpf0BNYeJloFTozR4/mfEfntjpuaxKkG3uYxSamFqgau?=
 =?us-ascii?Q?hv4DIhKI9vT3c0AD/TvkqORqF+cgAcZr52emjkOCW/FnUz2pvvaYX3NYemUS?=
 =?us-ascii?Q?RGtXZPjMsPzq1I8aujJ7zcAyw290gplBnOhWO5tyDECOFqUU7M5Ocmwhi7iv?=
 =?us-ascii?Q?LShhFNiyP3g3ya50TMBihB55gr9Y4F652AP4I2/7SKIT6wU/jtsI5qeOGdSs?=
 =?us-ascii?Q?0KxlKvK7CZwX/AiSHYeFtJs9KAeGfxAzZEAGwWwObvpUfJ8742EMxSOulfUV?=
 =?us-ascii?Q?VCW6aNWo34afOhoe9kq1wZxTVZGUvAWQoTQP0Z14NaY9ZB70NnQN3vgQO2Zg?=
 =?us-ascii?Q?m5dxh1XqWXtc29SY8LKzZ+GG0OqG24UClc7HxHCvD+ClUg+STBSmUjsuMf0P?=
 =?us-ascii?Q?XjVIMHtGuwdYlwks1YwLF+aSboO4DgGDK8Ty5rwkTW9i0KF1gk1+d89VU+YL?=
 =?us-ascii?Q?AsG39DkwDhmUajIwjdqv7CZAObiogz0sm0Is3Rzg4vTlUP8V+qvGImKuad11?=
 =?us-ascii?Q?xzjhEpV2kGIlsqn498hpdcucNwpI48ToULJqsWIRZFNa4os56OzrQSnv7EE/?=
 =?us-ascii?Q?6mvvL9e40D0Redw66aM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:38:11.8045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79199fa-6b15-479a-206d-08de16d74240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707
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

So we can call it in other blocks.

v2: add a new IPID parse interface for umc and we can
    implement it for each ASIC.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ec203f9e5ffa..28dff750c47e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -113,6 +113,8 @@ struct amdgpu_umc_ras {
 	uint32_t (*get_die_id_from_pa)(struct amdgpu_device *adev,
 			uint64_t mca_addr, uint64_t retired_page);
 	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
+	void (*mca_ipid_parse)(struct amdgpu_device *adev, uint64_t ipid,
+			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 8dc32787d625..0f5b1719fda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -711,6 +711,19 @@ static uint32_t umc_v12_0_get_die_id(struct amdgpu_device *adev,
 	return die;
 }
 
+static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
+		uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid)
+{
+	if (did)
+		*did = MCA_IPID_2_DIE_ID(ipid);
+	if (ch)
+		*ch = MCA_IPID_2_UMC_CH(ipid);
+	if (umc_inst)
+		*umc_inst = MCA_IPID_2_UMC_INST(ipid);
+	if (sid)
+		*sid = MCA_IPID_2_SOCKET_ID(ipid);
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
@@ -724,5 +737,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 	.get_die_id_from_pa = umc_v12_0_get_die_id,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
+	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 };
 
-- 
2.34.1

