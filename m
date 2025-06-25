Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77270C7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9FF10E813;
	Wed, 25 Jun 2025 21:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hlE5tbyw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B68B10E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7hUoAVO+OMgSPAIdT0oD/xMZ1866QHeJpYuhr5cYS9M24VKiiMRG8iUfvMRYZB7HTcwePtVMm/w0h2wfCbwM6BnnbGxdfs+iSybpllF+boa53HCDZkmNdOjVG7dOGzi3VZRWeXpI4SnTJiG+VbD15+77QyaE/bZhh6I0uv9fzrh66kN4RMctD5ptBY7cFJcD7WvovPfcclsSTON+zlRvVx9lnG5gjo52U1LT3r8da10Zq6hqVhAGEwUgUwY5dGcviTMoEMEAQ6fmEpkzPLT3BSNOlL22E+3+1ZqbIs+v6puNL6/+oxiho2/QZlAomPoAAA6LH3fKyXJottA8zmF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuuxQp4wlhePGcrzezl89et6gR5vKyp1HWv0A8c8vkk=;
 b=msOnoaDSTXUHyb4bd9i+eUxFEcTa1k0Wzy9quRIvbZ0Zjp7JEIFV8mY8W2CuNCKS9raQrBYUclPqgTs61wSvzjBqkvDBB9di7pturcq4jy5D1KbfLuUbpeULngHgmbVaDmMoFGr+l25fERNiTsCw5ZyYPeJGEG0uRNCdJpBuHwdPYXoyz9lNhlExfLyYTZ1Wa/nD+Heu+aKeZ6VMJ9aDk8lSfGLeNaTXrgOHUUakSOhgGIZy8ogJPURkmAc8jRUi1Mxx7iA4Iam9ZgsndJ2xflcT687JPxGLocy9GsvfxGho9Xsm7K3Wl+obmIp3vZ5iIhNKE8WBk2sknVj8d8o/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuuxQp4wlhePGcrzezl89et6gR5vKyp1HWv0A8c8vkk=;
 b=hlE5tbywDxbXe1n9dBZI/ZJCoBEnNHqIWn0XOd029gTc35FNgp/cqIW3pxHykDllfaZj0nHQyVEqnJOboUOP9baIOvDcXkHg2liVLSGJjmHoeguOELHJDp+XV6t498izpebMtYMxztphcy0FZTYmz/Fp3D3sRvTjzBSll5kKgsI=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 21:07:13 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::29) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 29/30] drm/amdgpu/vcn2.5: implement ring reset
Date: Wed, 25 Jun 2025 17:06:37 -0400
Message-ID: <20250625210638.422479-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH1PPFF5B95D789:EE_
X-MS-Office365-Filtering-Correlation-Id: b7433376-9ab5-4a30-8dca-08ddb42c41d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Djw7s6M3Q/ixw/eyw1zm8Lc+Slhl+bwWlE/QB4Qd4o/4zXKRHfWSIKBDe5yH?=
 =?us-ascii?Q?Sv54GgWbwitw6s2WxooIkoHwtsqx6ezVSh4DsCrEHrgrHKUy7fPHTZNbU1Zx?=
 =?us-ascii?Q?M69CjiHAuVrmXAUyv0jIvEg54W59fLrilxCgguOA0fble6RaPrHMkKV2ptg2?=
 =?us-ascii?Q?BSUUjZPHvcSVuzvKwuJ6jdR+pJP2yj7ene0Qq5JMQdNToDYNavZtEr6+H+NE?=
 =?us-ascii?Q?f8CI48NWH6Mf+mXHMFRVS2jZ/BrqZ7Zk19+4VmilegAQ8s3p9NZPiMOUVCzO?=
 =?us-ascii?Q?M+5RP8UhhY+wTzOmk8uc/8FAzGwuF6wW2PNM0Uv1QTwngqk+JKOSPW8Mkr2g?=
 =?us-ascii?Q?ijzpKFP/BasgSWIpSIpfUFG1xJ86HCfdeyeOpS/c9q8k/jDBCxXi3FbBPrc4?=
 =?us-ascii?Q?ItOka3mamfr57CkRWPyq14O3dCDw3fTZg79CGZgV5cJylR2i1Aoww9Fy++59?=
 =?us-ascii?Q?hpvxXqxKMU1ifc/i2zuAccmHoSHtoy8DNZrubSzX5gM8Fcgl4bN/dvGrGbRN?=
 =?us-ascii?Q?vXEnOliAHSrK1FNRAIgjxW0/dJT8GeP7pcRkBfmsI9VF9lR1zeiwJHLONEyz?=
 =?us-ascii?Q?rTT7zzesl6RFreDuxh+10EJXEQkdzatNmtc40C0/trwEsb8Bw34gLiqKiSkF?=
 =?us-ascii?Q?IOpLbkC/yowB0Rb+kl52R+A6EIbWHQwy8euMbbtyt4I95JeduyPvsbk0k2L7?=
 =?us-ascii?Q?Locf1K/3rCbzw72r8Mt5/q4Q9VDCHCnYts1caE7btp/Y6rL8PjLpN3Hyf1To?=
 =?us-ascii?Q?9b2gjytD/TXgQ71TJE0kGA+LFUXz5mSWeSSR4Yh9FyuhSXtVVknatpRDqDqz?=
 =?us-ascii?Q?MbFIjmrZcyATcMhTg1+AiJgW18neC10JQkIPWbYnkiKe7ZymveoDIJf1GPmL?=
 =?us-ascii?Q?5JxIYLEFlQZBhHZ7s6NotlnLfMZAH5nB6RnRFRgzuNM6kZ08rRTQrfk2L7pN?=
 =?us-ascii?Q?Dpv2Tk0fhnABddg7a5UFdSgZXztKNP2IuB1f04UvW0d/Y9ykvl7e7G7lL5Ff?=
 =?us-ascii?Q?aDVGbauRNhzdclzRy2/dbhWUaGX+jOulo2dFqcfLJiC7fClERyDBCyxPg/6R?=
 =?us-ascii?Q?lMDwOUdLpAVDVTN1rHUPPGeiedVoV5eh0sazTx3Rk4V8FH7Uwz1CPCgesoU4?=
 =?us-ascii?Q?gDHWmKf/+BZFqto2dFvo/d+woaFDFiqvEpLlGVb3EQ0XGfMfnO2AaiKbENSD?=
 =?us-ascii?Q?cI4BiKjGuMVSFEtKWx0Vu6+pzHONW2MxW1b1SgJiuJviM6/Q9fqwT8U2NTYt?=
 =?us-ascii?Q?vnceAtKcMOrtU9AkLhCKRgEptfMx8wWiBcl2X9l8/69+GInkPHNUlvHtTbuE?=
 =?us-ascii?Q?4LA2RGKXSm+iv6Av/cG74bSHai3YIhU1FXWIkEZqwjbwqMz0yUPR0wD7jUrb?=
 =?us-ascii?Q?zRqv2qMf4taXmJtiy8bG5sK2DTOjgj9MlPmPeOnJPKy0PtHdD/D5mnLuHqZ7?=
 =?us-ascii?Q?rn7Y2DgMCvqEeIFuynjoKcqZV7aTvxRIdfdGdhjLprfKmNq+7TnljAo0kQ9s?=
 =?us-ascii?Q?mtXkuGZLF0UFbAudlIllaNtFwxk0U9plWYee?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:13.0877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7433376-9ab5-4a30-8dca-08ddb42c41d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789
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

