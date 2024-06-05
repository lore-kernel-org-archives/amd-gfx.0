Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86873C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 08:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008E210E386;
	Wed,  5 Jun 2024 08:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fF8VNbfs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DE0110E386
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 08:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoCKP7LM4Ys41/UK9ly+NnLRzsOo1C05wGU3XaEamWLe54XvSk5mWbjcGWacOXxrF7itK+ZO+HwtiwU8/+5E6WBOVLZxsDNpkseqMYMwOADmlGJJVBiyPycopSKz7042cHLm8Q0MmWtLLsGagPKObJhyB0BQq5Ra/BJlpmH/AU9imHPuBZbjIDDQY5sOBUpXMI0YFM+KK4uPMHblzc9aMWXVlpv5tUZiySEOutzdmyZapRRwCDB8bU+ewGm2M30Kt6PK9dqrHkEjYv+oIgA1OEZF358j9mmhob2u7lqfzZsbIS9DHhpdF1d3sCVObzohMv36JQMs0jYM5U0qnDj1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnXzUGa7EZEyXPuZNvxVrI1kjM6fznO0spnOIwts3/Q=;
 b=nO0qcGj3Owm5C/6QKo4MGbzwCCHOVXYa3CWsSuLRtfDsWusc86Z9ysooONHapCUNvHB/j8uxSBqoliVTX738A3WLp81CVhxZReZG56n8yk7Wzyn6PqiIhsQhOoQSE3rCM+b+2YT+7Xd2IlxAUTmgPqVNHggM8K/KWiGAW1muVdhGBGsP3bC9EuZ/tFG6M7ZCYS2obrKQ4pPiVl2xVODXM8L9HCZf3SLmAT81jslyCAg12b/5qHNM+b2OpWt97GuDxi8k+0m3IJU4vAXozG9Zxa429bLXfGrJ+eT0mqrS70oixjYoiNTstYl1JxJrmI5cKtckGi50DE/T6dW7ixD9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnXzUGa7EZEyXPuZNvxVrI1kjM6fznO0spnOIwts3/Q=;
 b=fF8VNbfs7NRBe/ftIUwFBrzOnd6GzYAgqUcChj2k6pQ9BaoLeNcSOrG+025VhUAD2lQEzpyCjuWN/Av91jLrjPE+38Nk0bZ6MDydz8HM+adLZKuUZEQBFs7X00Xik3gDxEFlpKX7D6EmuygF9WhlbQJn++NjuCqVAcBePjkc8WQ=
Received: from SA0PR11CA0034.namprd11.prod.outlook.com (2603:10b6:806:d0::9)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Wed, 5 Jun 2024 08:34:33 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::fb) by SA0PR11CA0034.outlook.office365.com
 (2603:10b6:806:d0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 5 Jun 2024 08:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 08:34:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 03:34:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 03:34:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 03:34:25 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 4/12 V2] drm/amdgpu: remove dead code in atom_get_src_int
Date: Wed, 5 Jun 2024 16:34:19 +0800
Message-ID: <20240605083419.3216905-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: a20eebcd-5fbe-4ba7-ff95-08dc853a5369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qZdcd3JmY+y+Nt6qwbiVHQX5Zm+/BOyK4oeejvWyqkBv9/pdv1kDrboa26Ds?=
 =?us-ascii?Q?ehCpwGe4WiwSNTOSzjTLFp2O1Pffc0ixGhmEK7G2yiTsO+c3YEqA51fNrYEV?=
 =?us-ascii?Q?aWnIQ3XG8qeP+3Cyp69/vC9j8afHZjNoTqCrSt/sxHLMEQOdN2+F23TCUf+J?=
 =?us-ascii?Q?AzzB8MMUsHl70U5D1NBfo32llnyPKSqtf/HMWGEUReEwNCzm3tksOhp+rteB?=
 =?us-ascii?Q?m1mPzNYlGyMU7qwlhOBxzdI6dzLDNbrlyRtNcSz0Hokmyx5ULRQ9gm3wzuR/?=
 =?us-ascii?Q?Q2/qbdb6in1LDVC2nhjkZau3KORKxR16FmWVcZ3nBy+Ci9764mvqVK2H0+qa?=
 =?us-ascii?Q?tkzEZgjBcPl4AeBbIXOgwQ1sQDJFBR+6WxC4jN/v8d6kPAgnTvTEPMGvJrZD?=
 =?us-ascii?Q?U5Qsthww64ms/fBaGOPA3u1NGkO9+4dEHX4HAM0kpkirspo/fjxQaXNjxKLK?=
 =?us-ascii?Q?OcKPUO2Ct3JjEUnlX/xaTykrpyuzwleohhMZOu/3g7mxpcYhEEdUDOwmU6D8?=
 =?us-ascii?Q?pLKPjHDNezO7ZciSN2NuchLdqcHD+znczebqrCzETwT71VZb3+NK+WtG57NQ?=
 =?us-ascii?Q?y6k4lz8vdk3FcLIcXpa8kgMRbNvU0wXvkK/Uej5G3kkS3bIxLI1QeRiZfN9W?=
 =?us-ascii?Q?/ESAkRn8wR2wXBMTwJyuKq7vmTi5AqO12b0bLLj90RR8sWQ1PGVA++y1qEW+?=
 =?us-ascii?Q?8jwRq0cetB5jhAc+h506coGvZgv6fCCyRQlzfL6qvU6ALocmHtcXGf21auLZ?=
 =?us-ascii?Q?w5S8I1rtTWZgx/o+jE82EaqLnA87N4WTkYrMVVj+UqHFIuJU+NyC1eay74Qd?=
 =?us-ascii?Q?TfzeU/p7y/SyxqrBBGv3EXQylowGhUfffTq3Yjz6CMZAsrux+7NOFgNCEM+O?=
 =?us-ascii?Q?RvxPzpILKBQAIcQCQ30m+wFOINjKPBloI1pRs8znRjjcBF6YZV9+XP7P5OME?=
 =?us-ascii?Q?VnHUBl28SR2Lf+E1Nw9rrhFwKA7crnI56LNW9C464Q7v6zTm1eBe8yklOcLu?=
 =?us-ascii?Q?uMUMkkQa8M/r8uLmuHpsvY3x5VnKKG8njnEvEPQKSHtAy934+zo1QBnp/Pfu?=
 =?us-ascii?Q?JQL9kOdxpjuH8KPCYi/S97NmgxAZWJtfJ13c0uJJngd38MbVkfoTFF0thCvV?=
 =?us-ascii?Q?D/gMkJ2i8QGfr83J3tRpb58vpld6IsMi9cT37YfaxVDh5NQqcCh/6sakaC3c?=
 =?us-ascii?Q?ey6Tudm/ntzIk1G3BSXoUenCMm4oIYbBdDtbuwuy/x7+6nOhJOorKjrovVvp?=
 =?us-ascii?Q?xznl/4f3J2mZuhqLel53sBnhamJ+z/B0pZ3YuzLu10LlBW7at78zErgMTZMp?=
 =?us-ascii?Q?aaomw1Gylg8Aac5ZcumWo7U/o/A0b6Bwpqg+TirAMYq4o1qgZoQ/JBqwR0tP?=
 =?us-ascii?Q?rxio3wcDMXHRYq3j2aPOA2UpwQ1kdxGoS8/f9PE/dj4RgWrQyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 08:34:33.2727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20eebcd-5fbe-4ba7-ff95-08dc853a5369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

Since the range of align is 0~7, the expression is: align = (attr >> 3) & 7.
In the case of ATOM_ARG_IMM, the code cannot reach the default case.
So there is no need for "break".

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index d552e013354c..09715b506468 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -301,7 +301,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 			(*ptr) += 4;
 			if (print)
 				DEBUG("IMM 0x%08X\n", val);
-			return val;
+			break;
 		case ATOM_SRC_WORD0:
 		case ATOM_SRC_WORD8:
 		case ATOM_SRC_WORD16:
@@ -309,7 +309,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 			(*ptr) += 2;
 			if (print)
 				DEBUG("IMM 0x%04X\n", val);
-			return val;
+			break;
 		case ATOM_SRC_BYTE0:
 		case ATOM_SRC_BYTE8:
 		case ATOM_SRC_BYTE16:
@@ -318,9 +318,9 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 			(*ptr)++;
 			if (print)
 				DEBUG("IMM 0x%02X\n", val);
-			return val;
+			break;
 		}
-		break;
+		return val;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
-- 
2.25.1

