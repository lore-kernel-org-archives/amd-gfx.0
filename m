Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2B3C021A4
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 03:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DC610E1F0;
	Wed, 26 Feb 2025 03:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3koMUMp8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F50B10E1F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 03:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbi1aPI+ONL+ZxSeLshD3vriHBM5P3piYSoBX2CdN2aqsatk8OXtCTbB9Ugzw5p9za40U/2fsdKPS3Fniwu/7+sA9eayp0WRqjJvxK/nIQSHxCUo1Y5tl+dk4v6KZR8AdTN7q7QmTdjVPIkISGnxKy09EsFHujSSjg4ESZAIgIZ1+ph8rqigyv9K3BDsNlLOXLuSfmIrgqlFMAx1tTsgJT9/Z+MT/ZgGZMpxa7o8IGJaqYBjUA6Snxih3PgGZMWQiJGXD+tz5QL2YQeDLR0wVMQLM3CP/1ycKDWvNCW0dMLSccRSYAtPJ/XryT1iQHAFCJ+4x7Rn0AoZCD8jb0ItUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Zlc57EO7er3P8HjUHjzLfW6ocYdfStXJhaRMcXnNkI=;
 b=spCLvSYLi03+ExArcQtJnEwJEbpShJmEDm8SNHVpDUUiK6TnZGAtYWTA+H3z9GQHIYUpJ1IjKlvcsC50oiIrYIwY0nZkIf4u5jGmKDRuYDuZn+IPpuqhBDhD5ryrsKugPldNdgarOUGRqJ1K7DeWOgBan4DarW+GGJzS42g3TAfaHIT173Xgeym6AaqX2i14h8a0h/t7SVH6wwfDvtK+qAal5f07uG8nAK+U/GDWGRgKqVqwPqmh0lAMegBgpUMhF7tc0gr2pB28iIu42h1UGNmZhnINugqmglBiWsjDOpYtCyrjTnFspdJaQpms7VVmp5K/ep9z0lTR2qozlRUsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Zlc57EO7er3P8HjUHjzLfW6ocYdfStXJhaRMcXnNkI=;
 b=3koMUMp88ginWuE2waL71kpjcw8hMdd/o3FWd20kLED1zd8m3NujNze3l5as7ovhiumploX2HTuDWt5SFAqg5mVNRMPxXqfV9ePfYmJO305+EW4H+IgeHxMLcCg43qOS5GE+nEdIZ9kUmDRH+8Fuh6Qj2o+EMho5oZuT4UTUwe4=
Received: from BLAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:36e::8)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 03:49:53 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::38) by BLAPR05CA0004.outlook.office365.com
 (2603:10b6:208:36e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Wed,
 26 Feb 2025 03:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 03:49:52 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 21:49:50 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in aca bank parser
Date: Wed, 26 Feb 2025 11:49:29 +0800
Message-ID: <20250226034929.48207-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d568714-7470-412d-f295-08dd5618a06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bdIx0V8ar02EY5YFKD5ifxQs5Qipcnffj47WfptjHtmrEldXKfXa6Ly7YO/u?=
 =?us-ascii?Q?H7I2BZEdEnF0e3V1ODTf/nF5a0amtQuILC99WC/uzAx6eWSyQt9GObUPgB1t?=
 =?us-ascii?Q?GLJi4VmOcj98g8jdk0CQO63YxKYhkptytfqxf9EMxuuSEtqI0DBwAaa8glNV?=
 =?us-ascii?Q?SYuRWDG9lGOB4kDY5uXygTbpKsiaK9CT5sXarqEQ/7FNq/YJ2q8HDID3Ycjj?=
 =?us-ascii?Q?ek6iLh967BTHzItX2Y7loqrX3Nanl3YQ7tvE8M4BK3OOlIQ7tcvEAgP+AbY3?=
 =?us-ascii?Q?0ScFolYftXbSysAKOzBPO7h1eZp8y4m3nJMRv7xR2Rufavno3FFXhQ47DLL+?=
 =?us-ascii?Q?OWPb7+zZg5dxh5fLe0RPz1IjV2zxtwJeinFeLmn+fKriiqSR9CLQyDDcVIdK?=
 =?us-ascii?Q?KEFpdpAqwiOk7Pg6HpNoi0xkbb2cb5fVHTqS1Kf+9kofG1PSl9lB2fXiE58N?=
 =?us-ascii?Q?VAJeb0a9oC09vBH9/UXosW6G6zWyUI6d3IBNlpFH+fGT9Z6mKfazAzlV9q88?=
 =?us-ascii?Q?/NAsZeyZvOnkBJAbtWwBFMSzM41Ig/wzDAqvy05lvlVSMdbxV6bYmrou8WCh?=
 =?us-ascii?Q?CnAZSIikAah6IhUzVfAtkjKAbgSrmOatOL0U71/vno6U6vh8RE5mYggMTC7u?=
 =?us-ascii?Q?/W27de88hskygId1yXvfjBH5g0bYEqSY+Nb39dY/O2VfEo0m5ou8EBSqy8No?=
 =?us-ascii?Q?RUKU0q4dOuD4oG99pPEciYjSG9e+Xi6/k7WMhiCw6n9FhMEsr6QmWChis9od?=
 =?us-ascii?Q?9Uhrf5eh/2o52MWkLklsloKyrYB/1VQhyDOgqVhVjUFmThf4qf873Pgy78c+?=
 =?us-ascii?Q?Vio1zEpbj2vABFCtHpITtWnYb61TTsbxL/RbVYg5TZU9SHr+46jYEyVevD80?=
 =?us-ascii?Q?z58L8JjO+ymwmOqfzpZDBv+7UL5YjqnqXSIaF0mlEvFrJ2hCX/3sLUNfr0ll?=
 =?us-ascii?Q?xZ9lmgrJTLhmKaMqNG1TSrjARK6Ahc+pNg6Hj5St+63gyxbfP6aUGQjs3mbG?=
 =?us-ascii?Q?AztjA8yhaMpvLq+r6AJ/jkWISXnN9JXaRqjR3RCZrsLrPZfVo1+ksxe4bkcD?=
 =?us-ascii?Q?1ABHei1QgpEk8PdIXB1o6pLi41gd9Jff5ldVRrrl7vGZk2unushtUtFy5Qbf?=
 =?us-ascii?Q?SbrNTs29CqhZJdaIG+UW4Tz9XgTHCjdvQEcK06FGIC/+mCQs+P2Ps+s2OZvX?=
 =?us-ascii?Q?+iwhat9Zs/QPzEhwltGLMAyj9/mZ4s3U45CEKDmv/C814IrG4O2hKKDFOBui?=
 =?us-ascii?Q?9LcnUJ6ePmbGdkBFyMg8Nikf9fIFEXPEw77XC/FRWpZnp8uHqwGNCL+v955L?=
 =?us-ascii?Q?PLiwhMcPSxmIpoGOfVYOfZ7Y17O33MPa6TxQMK70FywhuCTvaGKV9G45vE8L?=
 =?us-ascii?Q?yJ0gkEc+kpvzbjZU247uvQJnt2qBfKrcURYcxTlKBcSDZjPRpvfiiya/h+Gb?=
 =?us-ascii?Q?S3XlCWBJS18KNV70DbWE22o8pQjrhWK4liJtivqDppK3ZsQXEvmupSzxvzmt?=
 =?us-ascii?Q?/3QYnTGAweSBt3U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 03:49:52.6577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d568714-7470-412d-f295-08dd5618a06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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

In the case of poison consumption's inband log, the error type need
to be specified by checking the poison bit of status register.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h  | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 ++--
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index b84a3489b116..a8c8457e4160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -76,6 +76,11 @@ struct ras_query_context;
 #define mmSMNAID_XCD1_MCA_SMU		0x38430400	/* SMN AID XCD1 */
 #define mmSMNXCD_XCD0_MCA_SMU		0x40430400	/* SMN XCD XCD0 */
 
+#define ACA_BANK_ERR_CE_DE_DECODE(bank)                              \
+	(ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) ? \
+		ACA_ERROR_TYPE_DEFERRED :                            \
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
index 4fa688e00f5e..d5d3298adfb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2494,8 +2494,8 @@ static int sdma_v4_4_2_aca_bank_parser(struct aca_handle *handle, struct aca_ban
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
index dda5ee187948..5971715495a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1930,8 +1930,8 @@ static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank
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

