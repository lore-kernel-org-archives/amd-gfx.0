Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A6606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o6gKP/ze
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499C310F465;
	Tue, 27 Oct 2026 12:56:58 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D7510F465
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWhWqN614dwAcrt3zNuNqK38qLxSAc9dirHvSiMKfAwc4DGYdocuqLG/fwN1htLZGPqccVX+3BYvjq24BMUVYFOmpXq7a+iawvENtX5B42rPSpcJ0DekplvR4WwfFaB0SQHfi7e78+9jhrTLnZsywZvYc0ApIqNULxyNtN6DWP/OyzK+PfH8pnoWdfPA1jf5aToV9A+kvry4Mob3bZo1V0FuO0xTHSffJOSvBJJlqro2v6QIHN8q8/8nbHtaU3wQS5oMgUxdqXYwXxOWOTwAbxsS8HUGAw519oTo/EcAL0s1fmg32bnVws+xPl9szlwkgbJQaK4NkG8M6uqoL56WRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FRljXSNysoYwjRpUpByA5pmgs+ePb2bG8S5OYVD5Rk=;
 b=XBiyir/Kqq/3zGdcj2m+yCcrkac9PKCBRTMfxJrfWocrh1cUwhlTK7FoDORBxRin61j4SjfWA2N1CW9FyDMTSbDeOgt7xIi62LdthxobFgntus3tCESRGUYFv0kR2kp+2qgcvPH98EcJEI+lhyT2NDNQx2EKaZ4JkQloMzl83fvxezbMFsBIrHoYMDQXVAblUVn/nAvr4zKCSzuHRp69EQk7a2SrObU6U7AIlYcOS7DV0sBS9FDZMMT6IDPwlvKzam0ht7FswChrJ2XlRuIzmwqEkUFO7ezPwheE3olY/QHA5CUzqu9X47CaZARaGnmfO0kYV6m6gRNxyksQen92tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FRljXSNysoYwjRpUpByA5pmgs+ePb2bG8S5OYVD5Rk=;
 b=o6gKP/zeQn3n7bsxAKixU3yX1zz1l/BB7WJybzOO0OUq9kM3Q+03foLwiYuBilW8MBFCEtMnQMY5bJk+2ALhoAff8riVPyQVKbPKByxkm0Zv/b/0cFy5vzoYP9E51k+c360ihGNJm8la6JSxtpCAGtAyJSjxZ1ttZkHGFOMlnfg=
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:56:45 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::89) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 12:56:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 12:56:45 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 07:56:41 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: Add virt GPU_CRIT_REGION_V3 definition
Date: Tue, 27 Oct 2026 08:56:11 -0400
Message-ID: <20261027125613.6549-6-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027125613.6549-1-victor.skvortsov@amd.com>
References: <20261027125613.6549-1-victor.skvortsov@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec44e67-50b8-4fed-a8ed-08df3429c191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|261021121427099003|261022105027099003|10067099003|56012099006|261026140227099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: QkxuFDcx0AHF/c8ZBwxqX25rPWm4E44Vg5QySk1VIa/Tfku6oGRDWOKkzXWT5SFsVLaNB/5T5B1ptcl2vMSVNcPSOEvX+pYWJkiNSm9WAanTRKnZqNwcKyd+upd4A6Na36Sw2VQrssYrfqg3ZI/IDcUI34pBUKr5wPLG8BlVsPchn82RA5wvM6PMlqb5VbpB8A2uFK40/qo/FTZT6uGjBfye2dH4WfE2G9fO2Ifkt/e7GNPqALDalbgTwvR1fUFs4OT7Bt+ZxfVg9Fd4a8Xysi9W54jqDz+Hfc5HycQVFgZqdOBNSPT1VKK31hAZ3fDH+GxTdWNMYCKjrP6tbyFC1Gn33cAskaVWmeRtkhkIk7BoyhL8LPPp0ctqYBQazmoHOWGgUdU1jC/6wExainGBN/t07Epn65BnvCTntdEZM0583k1VcwU5wCVD7FNgIR1zdv0oulCu0JtJAw0woHSAacvwP4E7GQrmW0LmfAinTFRrBNVmncoCbssvnwNWVtPalL0iBU6jCTj1u65KF/TShfQFubFbHDX6SNd7A6uQbG4gfqG4+WapY1obeyZG0vFplzTUYKgsf2U0KY/T3zfm7VeADmxEYkDwonK8S5ynkDYlVThsu898HGe0F1Yp7izU5N56OgGJTu6zTGWmf6Zw7QAPREd7Qy4Hl8FQNkjt3/z59EJVfonx/0Vd/lI8ESzYokx8q63SV3M1IX8+Lp23qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j3y6tGOUPl/5i3rbqduCl8NkayQTF4tceVQaNxcrqOwdXfKxgs3DsLsmwnjgOhAcHEioBrjNs7SDvJF0sSgg1hFO3DqUl2YSKNsglNYCUYirgt5KvmBgE0N/E2Lm80NvuEIb7PRX1cP1qmT8AmVEJPM2sjqrCvyGUFGj/Ypw14Pf/3Q3kRO0vfJj1QLDXOBlYER0Msk/mjQmLBG+DMHZSPIi8nXE2XPHbdIcZqq+k7gC2kX3KRHMmt5mKgx3Y74VZrR8//z5IkxaFA+wLsciCAg7CE4Impc0TCwhmKNS6L7nZdeBJO3yx/V4WpnuDt+LWv7yG2r1jPyvhSOCpwmKsfQEUYF6unS9mDXFqHjoASvG+WC04tkyo5PGdyDEq823OWNhGDYnEWrgFwTwbZbf2uGIXIocD3Z7w0tB37DIDdzGTeMlPM4a5TqHl7NSORKM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:56:45.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec44e67-50b8-4fed-a8ed-08df3429c191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

V3 allows the guest driver to choose the base location of the
PF-VF exchange region in VF SPM.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h       | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 5a253d50faa7..5fb6acb279d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -69,6 +69,7 @@
 enum amd_sriov_crit_region_version {
 	GPU_CRIT_REGION_V1 = 1,
 	GPU_CRIT_REGION_V2 = 2,
+	GPU_CRIT_REGION_V3 = 3,
 };
 
 /* v2 layout offset enum (in order of allocation) */
@@ -418,6 +419,7 @@ enum amd_sriov_mailbox_request_message {
 	MB_REQ_MSG_REQ_GPU_RESET_ACCESS,
 	MB_REQ_MSG_REQ_GPU_INIT_DATA,
 	MB_REQ_MSG_PSP_VF_CMD_RELAY,
+	MB_REQ_MSG_REQ_GPU_INIT_XCHG_REGION = 8,
 
 	MB_REQ_MSG_LOG_VF_ERROR = 200,
 	MB_REQ_MSG_READY_TO_RESET = 201,
@@ -451,6 +453,8 @@ enum amd_sriov_mailbox_response_message {
 	MB_RES_RAS_CHK_CRITI_READY		= 18,
 	MB_RES_RAS_REMOTE_CMD_READY		= 19,
 	MB_RES_MSG_PTL_UPDATE_READY		= 20,
+	MB_RES_MSG_REQ_GPU_INIT_XCHG_REGION_READY = 21,
+
 	MB_RES_MSG_TEXT_MESSAGE			= 255
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 5023113e7600..39a0284c3c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -37,6 +37,8 @@ enum idh_request {
 	IDH_REQ_GPU_RESET_ACCESS,
 	IDH_REQ_GPU_INIT_DATA,
 
+	IDH_REQ_GPU_INIT_XCHG_REGION = 8,
+
 	IDH_LOG_VF_ERROR	= 200,
 	IDH_READY_TO_RESET 	= 201,
 	IDH_RAS_POISON	= 202,
@@ -68,6 +70,7 @@ enum idh_event {
 	IDH_REQ_RAS_CHK_CRITI_READY = 18,
 	IDH_REQ_RAS_REMOTE_CMD_READY = 19,
 	IDH_PTL_UPDATE_READY = 20,
+	IDH_REQ_GPU_INIT_XCHG_REGION_READY = 21,
 
 	IDH_TEXT_MESSAGE = 255,
 };
-- 
2.34.1

