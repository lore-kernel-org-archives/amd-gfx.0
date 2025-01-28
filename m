Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C6BC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9561210E60A;
	Tue, 28 Jan 2025 09:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lXqtpf29";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB03910E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVnjY2Diw4LxlY8QGHAFArgOI9Opql2iQKY4fP4tBwndh0FNPQ5MOBHLx4WrjUylyYZmxxRcbbBwArD+pmHoPM2RYKmgZzOvDyXJRBsJ373OxHL6+WDt2TznqJOmXUGAhfNXbuD813PZfug+i8rEBrBSEm0Z/2hiY5F8KqaiG1LYt2DEVnpHHfwkoxOtlm09s/I3UhGmApe485ivi3GzPNAxI7PEANe6Tuy7W8dKXcPYIdzPSRvLWM/WxpIIt6H5/LEAsGQSYu/rcJ5R+GTNLdg2cUaUPKLty8i5V/SKTFYGhoSMF6L5uPWP8TqSOf7ghHHUA+RIqTC/93s4uwrl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU8fuKyG6XWqro1cMDZK2UPnMweCW5oXN2I+VFnsS+4=;
 b=xFaDKsB57pHU1hGtbO4sTSSi/kNjHc3mHSnjKd3cP5TiSmZSO7UEPHjKmylRwBZEkY0gP2Cysf272AIVxVndV1k/B5oOPzYXABpY6wVpbqEYU/DRD2snyHMc+aL4K96pZsdWpBlSDaNPnEFVkJbh4l6F19J5BlupEdXJMJaIEX2kVyWrau5gmrxRlVkoYQF3WWop1yqTolZMiy+JqQJWebeyy+aVeONIh7zWgTnLMP0UofWU2h3PEbalemGBQ7Ntj10XQ2OhC9QWtb+cmfaoKdR22W/aCLtwHDeIknep/+I/TTuBO6IB9hq/I9T63Nv5p5di/ylzJmWRSMiUrJyfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU8fuKyG6XWqro1cMDZK2UPnMweCW5oXN2I+VFnsS+4=;
 b=lXqtpf29Oh8TPS+Tya8qEq5ooBBi2hRi38WEv4bGo6yVb5XyQlTUuS+9/S6YSteYH9UtIyzH9y1R8k5T0Tb9PP82MKfCsn7JIrax3Rzm6GIPLH8MCcu5BEqyPidcOm2s59X/cbMDXI4DcA3UDSD9xgCbvend1tkhuPPaMaR+Q/o=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 09:12:18 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::2b) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 09:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:12:18 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:12:13 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: Enable devcoredump for JPEG3_0_0
Date: Tue, 28 Jan 2025 14:39:48 +0530
Message-ID: <20250128090950.461291-8-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: e998308c-25ca-4565-f338-08dd3f7bdd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXRTVTd3MWU2NmVkcW5PODdMYjBhUlYyQ3lEeHhoKzBnTkRuTFVkYUxTZEtL?=
 =?utf-8?B?UDcxY05UcmFvZElST2RzSTFsOTRlMjRNc1Z6RHFidnZrV2NSZ205YjNPeTgx?=
 =?utf-8?B?R0xtUm5lSHJOdlIvOVdQZDVrOVJlcUNSOXhLb1ZseGtKR2tqMGJDeEVXN1NB?=
 =?utf-8?B?anRVMnhTbGJqTmdMTGRQblZCaVNBSkc2eE5VSnNoOE4xcktZSXBCbEU0bHoy?=
 =?utf-8?B?dC9uOUtVeG9IM3dJQi9RcEJUMFlwbS9sdFlBS21GU3BRNlFkVk9HWkdrR3hm?=
 =?utf-8?B?K3hzRFY0VjRFaGpWQlg3MWpXRFlYcGFCVDNtOHBNRFdCWElqZENGTnozUUZv?=
 =?utf-8?B?bGdodWFVb3ZRVU9sYmJjTUJ3d05ySHFBbEZHMW5DVWg2VElUOXRXdWxwdXVy?=
 =?utf-8?B?R3h6WXpGOWFqVjZsQTBQaWZKdWtuTFNsMUU0eWV1bW9iUmg5WXNpaFdBOG84?=
 =?utf-8?B?WVlGV1VrL1JJVVlOZSt4L1JQRStmdGFiVjdNclZ2TDAxVCt0dlZZSEF6bmVM?=
 =?utf-8?B?dXV2R3FEN2hLclYzaURWdjhQeTFqaVhmdXB1UFNRWmV0SXpYNm01M1ZGQzRQ?=
 =?utf-8?B?VXZmb1VIdTlreCtWVDBjZks5MU5TQXBpcS9ObTFvQTJBcW5rNnJ1SkhHUVZs?=
 =?utf-8?B?Y1NKZWQwSEFQR3RWZVJTRzhwWWNwcHVIN0N6Y1lnSnlIVDZBZkcrd2tybG53?=
 =?utf-8?B?M0owT3lFMHpXTHRsL2hpQlRhQlpML1lrS1FTLzhYRHptQWs5bUdYZ3o3ZjBR?=
 =?utf-8?B?d3QwdzE4WnR0SVF6OW9lY2dYWU1NZmlMQjFkcXdmWml1dHVqWlVIVUR5UHdx?=
 =?utf-8?B?a2ZHcGRjR2dMb2FGYTdFVm5TcDNmRzlxYjR4WTVCQ1BCdDVVUlV1cTczeFNP?=
 =?utf-8?B?eE5LdHBjUlFYUmJqV3RQQlZXdEhtUFJJd2R3Vit4MHFiTTJQYXlyRi85MHAv?=
 =?utf-8?B?K3JHMThoZDZwd0F5UW56RDBlWllicEVYYWdsdGcyeG9CSUxrRng3NjFHcEhU?=
 =?utf-8?B?TUN6Nm1zcDJGakNLcCtXMVJyeldrVDNNYksvRG5qemxvRWVFRlFwMnF1a0JP?=
 =?utf-8?B?Mk9hQ0JiV1VWU0tMcVc3U0pCTmY0dGRGSzM0V2xlaTluaDhCbkEycEdHYjdk?=
 =?utf-8?B?elNodmRiSExmSERyMW9iOWpjSU5sa2t3V3lhcDg0QVhUK01zVkUxeXRyYzBH?=
 =?utf-8?B?dkhZSk5KZUNxd0xNVkx2WCtpNGdEb0VDZHdYNURLbGMvTXVIU2Z6NWVxbjFv?=
 =?utf-8?B?WTlpK29zeEI2RWxwa3JydmdQWW5zc3QxSXBwYTJNTkhjM2VDRFRjSG9oWXl5?=
 =?utf-8?B?SkNjdW1NdlZUZWtCR2VGb05UbnBCWkJ2T083a2w1VFY2VTU2dVBITnVzdXNH?=
 =?utf-8?B?NFVZWVJ4Q2lEWWtzSVVJRzBRZFdKYmRwdTF1VUVPdlhZSEN2dmJRZVBBaFJH?=
 =?utf-8?B?dkVKWXV4Ymd2Zm1CajdQR2FmOWVSUllTM3g0YVZzNzhmQmxrVFhYdktuT2ty?=
 =?utf-8?B?RTdMeFdhRFBlNE40WG5YYlJBSEpSVzBPZjR2amRHQU9vbGUyb1phbFRlcWJR?=
 =?utf-8?B?K1lQYXJnVUFydEhKTkF2eWQvU3Q3aUZZeDRURVYvektmbE94L01lbmVTdERE?=
 =?utf-8?B?cWNad2xmd1d2eXFURG1vVW4zQjRwbTRlZUNWbmgwSWZaYXZYQjRlSlo1QTU1?=
 =?utf-8?B?Si9lRElkZmgrY3NPVU1VdHM5WnZsUE9UbWlVS2dPcC90bGRSYVJ2N3l3aGwx?=
 =?utf-8?B?UVhKcVh2NDhkd0ZiL2hEYjgreU5TNkl4NUZycUdrbU82aEpJajljOEF3Rzls?=
 =?utf-8?B?T09Xd3BrTUNCUE80bVk0bGxYY2lPY3dFcnYwaXA5S0FCNDd0aXRmT0dZVGs2?=
 =?utf-8?B?bm5weDl4NW00NHFDcnVEM3JmV280UnMwZnltcUpXWmZvZlVxbUxwbG1kNUhx?=
 =?utf-8?B?K1I1WG91NVl3ZUNvbzFvSGlYYkRJbm1KMXRLTjRWUUZRSlVsTEJ0bG1SOElG?=
 =?utf-8?B?VjlRY0hkOWJRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:12:18.1523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e998308c-25ca-4565-f338-08dd3f7bdd49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
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

Add register list and enable devcoredump for JPEG3_0_0

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 4eca65ea9053..d95b62204745 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -34,10 +34,28 @@
 
 #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET	0x401f
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_3_0[] = {
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_UV_PITCH),
+};
+
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
+static void jpeg_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block);
+static void jpeg_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 
 /**
  * jpeg_v3_0_early_init - set function pointers
@@ -112,6 +130,12 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_3_0),
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump)
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+
+
 	return 0;
 }
 
@@ -133,6 +157,8 @@ static int jpeg_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	kfree(adev->jpeg.ip_dump);
+
 	return r;
 }
 
@@ -530,6 +556,17 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_3_0, ARRAY_SIZE(jpeg_reg_list_3_0));
+}
+
+static void jpeg_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_3_0,
+				   ARRAY_SIZE(jpeg_reg_list_3_0));
+}
+
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.name = "jpeg_v3_0",
 	.early_init = jpeg_v3_0_early_init,
@@ -543,6 +580,8 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.wait_for_idle = jpeg_v3_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v3_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v3_0_set_powergating_state,
+	.dump_ip_state = jpeg_v3_0_dump_ip_state,
+	.print_ip_state = jpeg_v3_0_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
-- 
2.25.1

