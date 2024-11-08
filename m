Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D28D5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0D310E96F;
	Fri,  8 Nov 2024 11:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMbj8DOr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4306A10E96C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfirXVF6efgnVI4i2gpMr59b5UWpIAtYrxd7DUPjsTd+AXVeQnm7pF92v3uCpNGqXKe6VtG8W+NOVhbx5SibIPyCAs9YrYY9YO75DeuGMB0PZ9fMcQDpHM4KwfSgdtHMXNYUowjEOvqktG/hsQUHfahNK1gjbv++z8rwaXtr+TV8lFqN765VVmd/nC59nRw4Tyc5ec/tQZq7xGQMgyenDzNQYlBk+z0mhOJn/z0VVeBHDi3im9/ODxFYYtqg0wY2MK4oLVPJ8kLe+ATSjNBVK16dzeiguPSQ0SDqBEOmKO1dUmWj5IlAmGnPF5n8qcHBjpJricTE9brMIjxPUCihqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHeXxzwEeJiDjM4fvRuESJWiHRY87lm8bRSerRqUTIk=;
 b=Ta80GWCTE4QQT6x0+PMiO23UobUE6r8hoH93RI7HopjsLGSJtgAinmTIf5ytnTTvWJ8rsQhRWCiJTY+7z84KVfGfl5mHzp8nf14Vzl4hPh2FW6tcbQGlMgcc97fQYsr5xuTuP5OYRyQhPg/LMUIKsaw379HvfAtMoRCL9IyBhRfG4V0ghPGqG4IObJuQ8mxh5fFNs/B1PPes3tbj5qHxPhM/j2Ed0jN61ukZ6u4k/XBjQdCuFzSg0QJh77nqIzSXzrV5DUTBPfhzawGUyEEITvcT1GX5SBQH9Re4PtiBslZNdFUyGuTKvvxm3GZdl9YhZsSZiFtqWut8MTh0vHeKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHeXxzwEeJiDjM4fvRuESJWiHRY87lm8bRSerRqUTIk=;
 b=jMbj8DOr5uUZMOKmqQ14HxTn9d1xZN+799chYk2YzbK0g7SgkiWRtT8qfUD8hgMrmIGS+ksn819qYKwZRt+Bk/rvjToVQBwKurZVaNblLNszAgcoflrwU335k9SgVQ93Bws+3E66p2yDokr83TLsK/eO5z2mEqmcsTKlyyq1YP4=
Received: from BN9PR03CA0253.namprd03.prod.outlook.com (2603:10b6:408:ff::18)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Fri, 8 Nov 2024 11:14:54 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::97) by BN9PR03CA0253.outlook.office365.com
 (2603:10b6:408:ff::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:54 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:52 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 18/23] drm/amdgpu: add interface to get die id from memory
 address
Date: Fri, 8 Nov 2024 19:14:18 +0800
Message-ID: <20241108111423.60169-18-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: c0478de6-bbbc-42da-3271-08dcffe6925d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OUxJsQQwfzsPqy2BYoG1wdm9l4ASPNGsHxkRzAkQ7pkXOYx8/Op/Lwe4V1gM?=
 =?us-ascii?Q?B9lf9SsWKM93x5TdH2+v4QnFfEVR80AaOdavpVXHtJmHjQgAE9zEFCZn++QH?=
 =?us-ascii?Q?AHjVFsVcAOuluZyOiI7BfN2F0wayrpbCi9rzHfnmljEoV5TVyCcC5SOSkf4k?=
 =?us-ascii?Q?j1WlRo/btrm43fyIK9Q3I8UW7gZC94ZMyV2TIhXpdEG5vQWuJDAElf6gnDK2?=
 =?us-ascii?Q?xfYFdJdrYFnMT7K4pEVipuazCnMuig4SZAMuAMq4aCEWb+u4FExSJmFYLjox?=
 =?us-ascii?Q?JuGQ8ljia5HqoWpcO04V+BaEtp5Iw6uboV84kRyI1i6DdcqWOxPC/ZC91lMX?=
 =?us-ascii?Q?rtDocPDWqOqLrW8weiqPdcjpk68Hr7N380cPR+nMe+wZFPBftj6w6psRolfs?=
 =?us-ascii?Q?ZdMl9jtECffRIusErXC0u3pd1oV/rtgsFLv0iXF24jpjQY+jAZKktxGTNmdI?=
 =?us-ascii?Q?EIV3tsKdYSzTGSnVg9g2IEUYgRGDaKh0silRPt4CAE4mcyfJKQszxgrJRkBK?=
 =?us-ascii?Q?q+4voZlZ4/8xSE7KtGh8CIvvnGnUvh9v8WDwuehRMPNPxhSgB0fxnX9AWzpu?=
 =?us-ascii?Q?2mgmsmhfTUxoo0SpbttxHEegHN64TYYpMwguetMegTayfTGmfMpv04WCXz3J?=
 =?us-ascii?Q?4yYOhTh/dYTDVw47BG60GusR5gjsGW8+wpkiSNVS4mFiDMgxQDJC153omjFg?=
 =?us-ascii?Q?Wo05fFoHz2uznx0ppP3ireG4iiuNGgRladcEXuuwZqzcG20omIHODVwUWx+g?=
 =?us-ascii?Q?+w8ceE+igUVSh/MOh5ZZ4Nd0eZ28VSC2rKGGHNFtT8bF0nE8udCH27Gf3wnz?=
 =?us-ascii?Q?lujcd4ee1qqmTDC9QEea/FFrUGsaeeKUJMQvnm+ru8RnbBoETdYIMxFp1A78?=
 =?us-ascii?Q?hqTkNtH2J+30iKYJpKxs09dOC6nQFuWswUlDLAPEZWzJQ+aIqe9DVHkO0NbB?=
 =?us-ascii?Q?UoIoXHi0ylxo2cyx15y/Vg8qGfCjkmJUfvjhwVmmwTP01XlTeQc6qAPnN9VK?=
 =?us-ascii?Q?mhUJgbYkDFb1KqhxFvuGLlF9IQ1Zr+NK7GGbDl5ufZEzvqXmllmXq3HYniv0?=
 =?us-ascii?Q?plOMbcNXb4jvbhWOzMDxgnYcsE734QQHIERUFh3DpSF2py9EGxWreV0YYJ/X?=
 =?us-ascii?Q?GcyrqYDkReXwvUF+yAZ6sVh4RP4gs7WgMLVrH1RtLj/LwV0TiLw3vp4umSp1?=
 =?us-ascii?Q?sZxXBEYw4IXmeH/9IUhtbjGjk407lXQjKST9g4q2Q9RDZ2sdL+KERRT632ps?=
 =?us-ascii?Q?2jM+NEIZvLLtNvulwB3pHYIMopvtOlBQ8qXgEzyx2IrvmLoe+EaxLLD6o5CZ?=
 =?us-ascii?Q?pdqr8Mo2L8fMpYosc9ww7kuuX7gVSpDBzLmIKOb7fi7hAT4Dd/+k+MuFzIQC?=
 =?us-ascii?Q?mbpMJTE5iLnw4ylG6G1HWuFjsWjZivLQTkF2SlHm5lsfrko9YQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:54.2128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0478de6-bbbc-42da-3271-08dcffe6925d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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

And implement it for UMC v12_0. The die id calculated from IPID
register in bad page retirement, but we don't store it on eeprom
and it can be also gotten from physical address.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |  7 +++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index f97c45b4eeb8..c4e3062008b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -91,6 +91,8 @@ struct amdgpu_umc_ras {
 			struct ta_ras_query_address_input *addr_in,
 			struct ta_ras_query_address_output *addr_out,
 			bool dump_addr);
+	uint32_t (*get_die_id_from_pa)(struct amdgpu_device *adev,
+			uint64_t retired_page);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index cce93b4ffb58..bcce7a304d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -619,6 +619,27 @@ static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
 	mutex_unlock(&con->umc_ecc_log.lock);
 }
 
+static uint32_t umc_v12_0_get_die_id(struct amdgpu_device *adev,
+		uint64_t retired_page)
+{
+	uint32_t die = 0;
+
+	/* we only calculate die id for nps1 mode right now */
+	die += ((((retired_page >> 12) & 0x1ULL)^
+	    (((retired_page >> 20) & 0x1ULL) & HashIntlvCtl64K) ^
+	    (((retired_page >> 27) & 0x1ULL) & HashIntlvCtl2M) ^
+	    (((retired_page >> 34) & 0x1ULL) & HashIntlvCtl1G) ^
+	    (((retired_page >> 41) & 0x1ULL) & HashIntlvCtl1T)) << 0);
+	die += ((((retired_page >> 13) & 0x1ULL) ^
+	    (((retired_page >> 21) & 0x1ULL) & HashIntlvCtl64K) ^
+	    (((retired_page >> 28) & 0x1ULL) & HashIntlvCtl2M) ^
+	    (((retired_page >> 35) & 0x1ULL) & HashIntlvCtl1G) ^
+	    (((retired_page >> 42) & 0x1ULL) & HashIntlvCtl1T)) << 1);
+	die &= 3;
+
+	return die;
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
@@ -630,5 +651,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.update_ecc_status = umc_v12_0_update_ecc_status,
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
+	.get_die_id_from_pa = umc_v12_0_get_die_id,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 9298018d938f..8154a5d6bfaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -77,6 +77,13 @@
 #define MCA_UMC_HWID_V12_0     0x96
 #define MCA_UMC_MCATYPE_V12_0  0x0
 
+/* interleave setting */
+#define HashIntlvCtl4K 0
+#define HashIntlvCtl64K 1
+#define HashIntlvCtl2M 1
+#define HashIntlvCtl1G 1
+#define HashIntlvCtl1T 1
+
 #define MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) >> 20) & 0x1) * 4) + \
 			(((_ipid_lo) >> 12) & 0xF))
 #define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
-- 
2.34.1

