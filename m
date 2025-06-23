Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ACCC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878CF10E420;
	Mon, 23 Jun 2025 16:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DYlO8TK3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4178510E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f30/v1P+DesFDi0o8fi6TkNPYbprJVo4Hl50pgZR/S/QFRCtoKEq5KQCXV7ozjiadNVenurb1N00dwMk+RwqT35YS1vzxZhxXnokoDDAcTji0JsgWTklE5FmSgQ0KvrY6mhNPxfigGv1G6f9h3PJryEJBS8jUisWmdvjcdAujG8rT/0G8kitOYr5HpKpNm1K4xl/Vep1AICSoEqG7PSfwKQQtQa7BxKb+UXEtHXLedGvl4MJZOO/nxZX/skMoKt35tWj7pYioSwD847vi09LzUwPGq5hgy85dkXCXh8bSN47WeRAE0m6eKJNiDUq9BjW2j9sYjtm322R556Dq2jslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOb3uVRhPiQEkJpmVJdYKGYKptQ8Axhxcd9eot1hLF4=;
 b=bFClGo8tkO+oY0kYTr8ptzrQ5/WuP/Eeiinf9gJxOUkCbtVDlQBbAglsozliio4MBjHd379s5BFXRB80CUB3dgJSiP0lE5ojsxS7evPxXBmlkbvB/+mcXP+vNnkKlVcs3badD6DLo1LeNOtj5/FSArp/38ptb8daDyEs05f4YmKl1ZvhJv/qftdBgVRb3YSrBoUAnaqOkDKp0PDAghTpfKkGZKmxsAk8akcbpjluz5NWJTZxouW7wx2qFlXFREOpGgSYJUTrYI6QshiULbzKq+2EpDt9s5XNx8gTpenoURU3HQHsXkOsWyfiy3zsDjqCr/CXK0grxpDLBm5he61AWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOb3uVRhPiQEkJpmVJdYKGYKptQ8Axhxcd9eot1hLF4=;
 b=DYlO8TK3cfGm4nuw+CGyLMOBfVDnQfnOtTe0yl+3FYR1b2qoj9+pzMIC3/5Zaa6Y5gHDDrYnoVI/xng+BDZvOGlFUDZjrmh5qeH1vGOAUDYcR5Y3NACg4PKf1LMkPTyNPFPQDkIoFLFI/YtXxJeXlFk0s8hA/uGPdOSPGIeYYRI=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:15:13 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::37) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.19 via Frontend Transport; Mon,
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
 2025 11:15:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 29/31] drm/amdgpu/vcn2: implement ring reset
Date: Mon, 23 Jun 2025 12:14:35 -0400
Message-ID: <20250623161438.124020-30-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: bf638c60-b2a5-46fc-7bdf-08ddb271226f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?859ibMb/v2ezxXOnEPwvg8yLP/tl79HAakk412qMHMWVXQNs2MIM3wxFUkXm?=
 =?us-ascii?Q?H+9H4O8B0x3d7Mn+ZSzLbRo66f3qKx5TXUmpTXB2hHeogcyzTzeJQ/FqPgBX?=
 =?us-ascii?Q?Mlfrr2U9Px2KaEOtx+Ti2YQOAt+q7Ywt+d+RBeBoucg9nANO6JubMwTvE448?=
 =?us-ascii?Q?bDu45yK35GPuKGIoWrWa02KaykJY+guC6OaZlohoMlkKEVphfY4KQd35AwQO?=
 =?us-ascii?Q?k/712RYpmlzJ47X2i8JqQcJH0GkQoVYUDeKHj+3+0TrCjhn7NjpjqXHCv2ds?=
 =?us-ascii?Q?0iERCKthUsFBveeRZ1aOfGa1qrCdeKJL88gHzULWMUqiOCwBgMgGnqNgZ5pz?=
 =?us-ascii?Q?t9xW0sMHUj2d5BJ7tfd+SxjipzZmeifO5SQ8HdhxgXN1vz701TsOKZQEPDct?=
 =?us-ascii?Q?PzrLE+K2T5k3SciLxZgdwkcQ2aoa4u238ZP8T88QjNMM9nKhlazxloielfL6?=
 =?us-ascii?Q?Mz8O9z0YnadaOr51pUnrEr2W1yTnYlfLSWv4csBEsiMr4PnivNMUieesH2BN?=
 =?us-ascii?Q?RDjVyuhr4F4Nb75wXR1GYaav8+SxyiUZldhwh08z8csjxiMzBABpxvxlMXCn?=
 =?us-ascii?Q?xTClRN7Qc2pnTHjJHD11wGWD0R+X4qLA+tkHRtzaiBT9UUb/e85r7CruYcQG?=
 =?us-ascii?Q?iAWenE+haW4PQHEEoEPkB0NUgxdwIGscW0zBYtnIRdd3/dCx8dSuwcAb8MMs?=
 =?us-ascii?Q?VK+p3ZiepF8/6VZJUvNUON1asIrO3tP71szaH2voDQUx73Jn3z6RJXHGp2xO?=
 =?us-ascii?Q?1UnIAyIHA8GuwJgFH0tYnAqFn6HuR6OGhe93p2a+9Opjtl0Drg6jtMDLfTCl?=
 =?us-ascii?Q?nrB9Nj+1NkS8NnuPqAkBPf31CASXLh1egdy542qX/RqkPT1kP9Hhjqbl1KMB?=
 =?us-ascii?Q?f1h0oGv8fU5SdEpD+NEKkaNBkAYHrIxQgPfkPts7iCVfGaig8exKs21eSNqZ?=
 =?us-ascii?Q?Ml/fX+5S+VgKCPBFugs31m+C83GDfN98nXPgkMX9UPl/+ix5itFmCImdTq87?=
 =?us-ascii?Q?7jMyrKFoqaOkZDqSVJgFIcrw7qT1Frerc2zYvjHkxm6KJR4OatU8i/G6z6kz?=
 =?us-ascii?Q?4uZBAxS6IbI6y4B++hYqK4yLWnlkH+eFokMq1YrzZSagFdCr1lj4LdvpDQry?=
 =?us-ascii?Q?67S34yn60vYEcrEpy4VIUh1mTbDFygT1qFzKzTLJ2X2Qq3sBWfl5zhwUIaxk?=
 =?us-ascii?Q?oeMXCrPkDB6BGRRMs6f43B50YB5xQTPc7y6mOfk2XSPNUTz8luDWRzanxAJl?=
 =?us-ascii?Q?gI5467RZvbf2KqF+Tn86OT9Y2DV74ETioVf+AX4uibhZKqu5+Ym/VcQPD3d+?=
 =?us-ascii?Q?6UQYhFHZxhLJuNeahS4Xf5iYvppx2FE4gqzuSICyjkSjeEexd7Yk7M9ft/59?=
 =?us-ascii?Q?EcN/M0rBmxhvvJpBkXXIRu+BYtNUmiqgzP4Zd65+VEReTjRtezGy7FBl/ySF?=
 =?us-ascii?Q?p9AormJe1WbJfldrmihro+46Q+rs6yIogK26IhIWikehwU/1rFGArWuSs0dY?=
 =?us-ascii?Q?YCCGCaIqwGI+VU1URO0PO3juNhrJzl3tMZ6Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:13.4868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf638c60-b2a5-46fc-7bdf-08ddb271226f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 148b651be7ca7..33d210a61483f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -98,6 +98,8 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst);
+
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
  *
@@ -213,6 +215,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->vcn.inst[0].pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
+	adev->vcn.inst[0].reset = vcn_v2_0_reset;
 
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
@@ -1355,6 +1358,13 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+static int vcn_v2_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v2_0_stop(vinst);
+	vcn_v2_0_start(vinst);
+	return 0;
+}
+
 static bool vcn_v2_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2176,6 +2186,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
@@ -2205,6 +2216,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.49.0

