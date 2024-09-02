Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3935DCD342C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D916510E221;
	Mon,  2 Sep 2024 07:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRkJ0hbF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA3610E220
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgG9zoaoklEPwtnMS/ekMx+/dbcR8IgZNcsEU3w0Daf7144IHJK7bIa8pYNROMgM9szBCxr54XK276blvLZHbZ+2PoybdLqrGLsZ+y3fXyVgbUHdrxtw6AFVoETpErw1ZevrsNmLIlPRSP24z5hxWZQEiGXDpWA6sgn+udjci6vJNVjXcwoWFgADH5xGY4WI59DZW84/6YuFm6Rq6XmvpjLVebX/AW2108dpgOkGA0PzWUgIX6PBewARsPhBY0Kttyw7ts7PNvp3leOoZ0vEGGJ7dS5SY/Kna1iz3Gv8EE1hluucLKoDsjNQ6t3dg84uhxdepQZf8f42LoCeDKtSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6bE0xCLqtBZNfG7J6pJStmW6WR0nfyodld0AT3cTvs=;
 b=RzuH2js/r8h/QadVbg3vYiXb2G1/OftTU6sHPmAncOcWQkdpsDTYhh2dxQh9EpnZUBv7dh5zsdZIaWdWYyuUbZ035zu/k1isDZmdqYaOm4lZtqf7bszETlk5ziQ0fbHW9miWZ2YN97hL0EeBSnHZ9lOfrOEs9+7ah72LD72wByjxg+7pQYCj3EO8XAcy6xOR5TYbMIfF9dOvaSXPRzlcNgMWH6bkmfAcBiYvxxlp+d5x08ZHs+WNuTmZcq7DQJxUptzWf8IKkVr7dpodEUB5rlTq0jTfa7Sr7Uatf2X8lsyQfr82nq5caomEwsjUTiEppjRPetTyRJvo/ziyKnewWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6bE0xCLqtBZNfG7J6pJStmW6WR0nfyodld0AT3cTvs=;
 b=CRkJ0hbFojwOYS/py4I6Hkp1rkWYjxZIq8ep/T5hQRV2jhI6SSWIoUVbPY6gJdHpg9bk0jbRf8j73iFrXQ8P1UFR0wlSkbxke8zUS50uSK8TcjkmOCUVOat5zoj5JdwzNVCblldTZSsspMSpjPAPF0JND2nBWMDtNBm9gpiDqLA=
Received: from BN9PR03CA0871.namprd03.prod.outlook.com (2603:10b6:408:13c::6)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:34:51 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::2) by BN9PR03CA0871.outlook.office365.com
 (2603:10b6:408:13c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: Add interface for TOS reload cases
Date: Mon, 2 Sep 2024 13:04:16 +0530
Message-ID: <20240902073417.2025971-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: c454325c-a97f-4f8f-2700-08dccb21bb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?10V5XaG5c7Hurb3tqRfTggfwDcFdH+tuuQJcGn6vSW4/G3iG0I0Pqv8HfOQ4?=
 =?us-ascii?Q?ifa5OfP5S3LMVCbehyIYZM0koA9yp42kAR85YeIfMS3+BhcL+geiWqWcxXma?=
 =?us-ascii?Q?C3T+ZNjDleONB1c7eaQBcp6UzF5AGsqQiHuFm0K3zgD8y3uRgeNd12OHJyft?=
 =?us-ascii?Q?yFtAYlSs6loWKoVrUxGZy9qbDVE9RLbq5yykobhYI+8dSoZWU8On1LqS0rhC?=
 =?us-ascii?Q?NcHJEvceRxCQQs9300JgB6yDMki125wpov3j934MJGZd1Bc8WnSJ5lwmh4mH?=
 =?us-ascii?Q?0gQSH56uwnRcvTBUguBA2jqxdgYQ6E3rKbLPuBOuDWLYXtQVc6PaoIqDtxa8?=
 =?us-ascii?Q?NXVD4wATgBPJ1jTPkoVmYUgsmZmEb9cBUBsloNifXBJtkRosBl4Nzv0lDgKa?=
 =?us-ascii?Q?RSJk2Bhs5qPEPKHTIpVd7a8JBU/57l/CV3lArtxDG2tHIY2sB1oQEPTA/Za+?=
 =?us-ascii?Q?6IXzqg3zzU4boBL7kHFZ/hYKatlSAFIyz3mj2G7MTOFzC1t3I7RcgMadpJG/?=
 =?us-ascii?Q?zg6WjLWeki+B+T2ArRzqzmr4D9hDeIA1GzUrBnVf88Mn2nJuQUrzfcZsnGdK?=
 =?us-ascii?Q?ILOomXdemeIxlTdpsM1ytgufgDENyS1Ug+5dOKxnlU3QdDVcvsaAyMzWpqmT?=
 =?us-ascii?Q?RNQxnri3JtONRAk8iAD+bjReEnKBnzYS7Mmb6fMTRtKdAhxLM9pubN5GjaNw?=
 =?us-ascii?Q?8oDEBQ09hJFM5oQcfE/ZY6U1WaY9uXzZ9KMKMEh04jpezUr+8R91iLczQmKP?=
 =?us-ascii?Q?u58UymqECRX79qrBfxWf97sffoWyobFUC417r3TB1/C0Adacc0T4NU75Opb3?=
 =?us-ascii?Q?fk/kuuo7LZDhpJmdkO/rFl0shxe7qQj/N2aYMkm1N8rZ4UVFBqo4XmzOGu42?=
 =?us-ascii?Q?rzj472GZNXySdMdinB0Mg/BcdvZCodtXopcHL2YgvhFNiuGb/eZ5WB83bPoe?=
 =?us-ascii?Q?M0g/XBmNyecWGbeTvaHdm3ZSA7QZ1wJzs8Yf6OfMa8h6PTHIhMIo/mCeFD6w?=
 =?us-ascii?Q?U8NSNRf6CBbYmrsOXdH7Qs6446u0rf9wUWrRDGzSSkxD688Nj30PG55R1Cat?=
 =?us-ascii?Q?cZ85WX5hRMLiyNFM56mBwMjpxuxiq3aEJjmG2UqmxVUHqG/fgRkE31WziWjx?=
 =?us-ascii?Q?Llb2XPK25b6iX5gn0JQqLPZdHX9NrPVP7LaifQW42+FlPm/v4r4Qv43Myd/v?=
 =?us-ascii?Q?KBLzqD1F2UffcQzPmh+fxrKr5YbCtehnghF0KHzkd9Cm44hDZCAYGhZjAt6A?=
 =?us-ascii?Q?0T2lQH/m4RpCXkrKhxATCBpCeXCKi9YbgKQGpZNiS3N2ESvrP87U/N4UU5pd?=
 =?us-ascii?Q?qNXgpTYibNMwOP7qf3MrvZ4llvaYbT8YQ3bvX0lZxJUQhM6wJKyM+Hj04+S4?=
 =?us-ascii?Q?+5qzwNOEYpDE7eaxlUtNvSI91fjTei+uTGVI5E7AyJbo80u6YXDMoV/Q5CN2?=
 =?us-ascii?Q?W/gqYEPU0T2X4qDaAKj+EAkgWcNA6wbe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:51.5217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c454325c-a97f-4f8f-2700-08dccb21bb45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
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

Add interface to check if a different TOS needs to be loaded than the
one which is which is already active on the SOC. Presently the interface
is restricted to specific variants of PSPv13.0.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 25 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 189574d53ebd..3623bea2b1e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2264,6 +2264,19 @@ bool amdgpu_psp_get_ras_capability(struct psp_context *psp)
 	}
 }
 
+bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
+{
+	struct psp_context *psp = &adev->psp;
+
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+	if (psp->funcs && psp->funcs->is_reload_needed)
+		return psp->funcs->is_reload_needed(psp);
+
+	return false;
+}
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 74a96516c913..23581c44e625 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -138,6 +138,7 @@ struct psp_funcs {
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
 	bool (*get_ras_capability)(struct psp_context *psp);
+	bool (*is_reload_needed)(struct psp_context *psp);
 };
 
 struct ta_funcs {
@@ -553,4 +554,6 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
 bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
+bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 1251ee38a676..035e0ceda4c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -807,6 +807,30 @@ static bool psp_v13_0_get_ras_capability(struct psp_context *psp)
 	}
 }
 
+static bool psp_v13_0_is_reload_needed(struct psp_context *psp)
+{
+	uint32_t ucode_ver;
+
+	if (!psp_v13_0_is_sos_alive(psp))
+		return false;
+
+	/* Restrict reload support only to specific IP versions */
+	switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
+		/* TOS version read from microcode header */
+		ucode_ver = psp->sos.fw_version;
+		/* Read TOS version from hardware */
+		psp_v13_0_init_sos_version(psp);
+		return (ucode_ver != psp->sos.fw_version);
+	default:
+		return false;
+	}
+
+	return false;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
@@ -830,6 +854,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
 	.get_ras_capability = psp_v13_0_get_ras_capability,
+	.is_reload_needed = psp_v13_0_is_reload_needed,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.25.1

