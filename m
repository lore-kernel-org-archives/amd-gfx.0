Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADE3C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 07:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC0F10E86D;
	Wed, 26 Feb 2025 07:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJPazKAX";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407CF10E86D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 07:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0+VNak0UNc+DU6Q01To3lZ5Y4yow8LNLb34eBg19MLiCCjXcyNoQpwnf3U9TwulYmNbs+t6sIRPF8FY4M+ibl/x4KRJ6aytegANDVxGniNXD0nrbNqI1K9Xe07M2pln+zu+2uWeTu6QRV8YkaeqFSsmKokJtjw5A0WeIoS2jTS9pJUqP3Firm54d1QvrhwQGl2Dk0On0CM3EuFGPjv7QikaVloYCvCkNjyZi2A0qG21ZSRg8+UJtR4KsSwM/4PK/H66BOm3+IOXcIPiuH8veMjrX0OPWCuDYldJROAxmAn5U6U6BqRsI2RdDUJ2bbSbQybUz7ORZyJ6prvBeMQ2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9cNjRrxD9Ot4qGRDiBx3QTYbBby7+eHFRjY+LjWyXY=;
 b=Ae4vvH8sh5vTcwOCu8QLyG5peiKCbYp5VnDaidZaYHjv3Vf1b7Cf5OmGmBR1vXbTciJ0+d8f0ilqEPzjpEJ3t8Y73NTNAcOrWR9k/EzpHapoTjJ9TgnbYiJWHdvLiB4iwKbZfKIb1G0/Flqw8L4ggtC8L29vMtdT6+ZQNukuFJNWdgcz5U3H8q1c12FtQwJeqnkz8H+cqjPWvmoxJRxWsMmJjoydCeTXd6amBc9Xm45wdnTdWfax0LA+zh0XJTSEetHGg2iA7k47H30cwUKwr78QmoVRGeEyIijj9zWSvAy8aRVAH2fXJJSESptCarl8lh2YkPsUFK4deI3SB5ROFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9cNjRrxD9Ot4qGRDiBx3QTYbBby7+eHFRjY+LjWyXY=;
 b=vJPazKAXXV+z/P6MO1teS2qh9NbWa/7Zq7KXZ6d8kZyO6T8EH5q8KtTYxqNMa2WgOFsl99oUrXUBREXTePr6q0iPTVBZwvwm4jhWHhvcK+2LTlMbFUJqs8AgjlC/wfVxVN+KoRpJPCAUmuzu+dPtp/froCqmGQz31yk8vdCXgzk=
Received: from PH8PR21CA0010.namprd21.prod.outlook.com (2603:10b6:510:2ce::10)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 07:49:40 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::43) by PH8PR21CA0010.outlook.office365.com
 (2603:10b6:510:2ce::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.4 via Frontend Transport; Wed,
 26 Feb 2025 07:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 07:49:39 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 01:49:37 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in aca bank parser
Date: Wed, 26 Feb 2025 15:49:13 +0800
Message-ID: <20250226074913.59576-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1e9f62-c16e-4d42-9a96-08dd563a1fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qN4P8gWDOzOf5UOYgfDi/0dmQ/BfnQ1SBqU9XincZZDxkS0X3t8G1+GcuBrz?=
 =?us-ascii?Q?NtRBzPGpXuLO3A6qoTrYFZSPOPRqOf8Wpbw02iPE18yErPGD8e/ArXorrwhe?=
 =?us-ascii?Q?alD0WeWn1j0KStWa64LIdMdQ/L3URHnwEUN8zlQQzSODakl7DpNimFewm9wA?=
 =?us-ascii?Q?kLYFfytVTKjflc+WLBNXpnaxHiScj6zp4lv/P124L17+MqkXJx2qZvkpZe8o?=
 =?us-ascii?Q?p1P9cMcSr4BOPr29y5DbNk5FeyKMLx24FUfSDWSNLSiMrjiSr8k+0xno8JC+?=
 =?us-ascii?Q?5PqAI5KXu8eJdz8LdbrVltZSyFY9oBOeup0qe1qxqkzYFQLzh63T4nA6xVSC?=
 =?us-ascii?Q?fUMP8WZ1ljfzI/VCoBbUExDwLc7XwqkU7FxDRDuKivUPsmhcjPpjTRzva21d?=
 =?us-ascii?Q?RWGIbT3x+/oRlOvuryla8rAVacSOYD17mIFVhfkT7Au4uSZPpTLChHMZWXKv?=
 =?us-ascii?Q?yNn20ihCJBHr5l/JZfm/RCZ7w79BY7DfiATzbSzUV3Y5PjJp2yFhofnL+QAY?=
 =?us-ascii?Q?xgu+HLke3B4muT5CM3P7Mksh+xoIj9NHWqccplS/huwHDU2t8x/xQgDCqcFL?=
 =?us-ascii?Q?+RqO5zuSHoA8R7IsbriEAjEqIpvno1qIVWDSRHayUhFNcSJOYvyKVvgF07XE?=
 =?us-ascii?Q?2KZPh6XeA1aaqm8IA8MZKaTLcSDeAiwp/RIvJxvpk5xTer4WRYd29nNsJ+On?=
 =?us-ascii?Q?jGSxW4sxMe3P8bQ/sw4YPyKqzEKALnvuIVZSC0UENEJ1Tm5Bs5cBGlu+An1s?=
 =?us-ascii?Q?WvDvZzPAf8OJGGwV6XyEYen4tezF5ET0BWEjhcQtC7w5+C2asgYjU2a1PqAq?=
 =?us-ascii?Q?6qNNmBovWYdwmSWntTZ77qYb2dq2hiXDoV/QUJRQ1rf0uA+/Vntx7CVR8Nzi?=
 =?us-ascii?Q?KGHS1Q8JR6TIsLRtG3r9dRBZHkgUkcyKO4+jjYMm6z+M5/ibKjFrq7xZ8IFg?=
 =?us-ascii?Q?FHpOwoeytILebjLasiJKlmeh5zpVM3xXCtLFzQsaMgwKnAcQ9o05mWKD4R1D?=
 =?us-ascii?Q?VKnxLJEhHRP3l8H26LbhC5sQUXsQU+U2vI695mnVhCcBZi57yMUlC41BrhZJ?=
 =?us-ascii?Q?rNFL161m5sRN3dOiX+1sjUgrUpe656x0fJszZKVGgspUQq0a3PDRbCaq4WAO?=
 =?us-ascii?Q?+7xOOTtzvr1WEC5WJ02NU0a791EVn814W3H+577yth/QrBGtny4BcLEnEVuM?=
 =?us-ascii?Q?WC4FibM0qUtcIMMxx70cOBJSLbgdR06iSmfwS469/U3iOYOaimEsGkI/oWjs?=
 =?us-ascii?Q?spQe7RIyAoVH3IT1LTZiEaHY/ppUswT0MKPRuD66vcq1wde2g5TNIxOwFaRW?=
 =?us-ascii?Q?m4n5DDPqM0eSgYBWqfP4EvU39qxK0PP3gErgdxhAeimndfUAW2y1XrmfUF7T?=
 =?us-ascii?Q?e8LQ6CV46YEX1lKSL27Gup3pMUq4b27GWdapyN/kkzkpmAoE988n+I2Y31j2?=
 =?us-ascii?Q?05SP+b5Dm6MRTANY4L0llGfYg2b6aRDfuGIwMOLNE5y8/i75CVfWeMbGYOld?=
 =?us-ascii?Q?KhSAtWolJVu4BIg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:49:39.6807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1e9f62-c16e-4d42-9a96-08dd563a1fc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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

In the case of poison inband log, the error type need to be specified
by checking the deferred or poison bit of status register.

v2: check both deferred and poison bit

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 ++--
 7 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index b84a3489b116..6f62e5d80ed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -76,6 +76,12 @@ struct ras_query_context;
 #define mmSMNAID_XCD1_MCA_SMU		0x38430400	/* SMN AID XCD1 */
 #define mmSMNXCD_XCD0_MCA_SMU		0x40430400	/* SMN XCD XCD0 */
 
+#define ACA_BANK_ERR_CE_DE_DECODE(bank)                                  \
+	((ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) ||   \
+	  ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS])) ? \
+		ACA_ERROR_TYPE_DEFERRED :                                \
+		ACA_ERROR_TYPE_CE)
+
 enum aca_reg_idx {
 	ACA_REG_IDX_CTL			= 0,
 	ACA_REG_IDX_STATUS		= 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 49da137d42c9..c313c2cf6969 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1169,8 +1169,8 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 		break;
 	case ACA_SMU_TYPE_CE:
 		count = ext_error_code == 6 ? count : 0ULL;
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE, count);
+		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type, count);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 50eb856249d5..87add6274b98 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -883,9 +883,10 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 						     ACA_ERROR_TYPE_UE, 1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
+		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
 		ret = aca_error_cache_log_bank_error(handle, &info,
-						     ACA_ERROR_TYPE_CE, ACA_REG__MISC0__ERRCNT(misc0));
+						     bank->aca_err_type,
+						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index b8f06e9c9e62..1fcab0ef21c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1332,8 +1332,8 @@ static int jpeg_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
+		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 58d22f0d5a68..a54e7b929295 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -751,8 +751,8 @@ static int mmhub_v1_8_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
+		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index ba43c8f46f45..5636f473c3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2529,8 +2529,8 @@ static int sdma_v4_4_2_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
+		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 2681c40704a1..20f6bd9255db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1963,8 +1963,8 @@ static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
+		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
 	default:
-- 
2.34.1

