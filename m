Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0A2C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6041C10ECF7;
	Wed,  5 Aug 2026 06:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CEDZsKi7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD2010ECFA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGaoRoVa0U/4TibetauRtkcaqI2EdvggXT/r+CbbFvDdw9JQ4j/PIqsKM33wkTahQvxAr426/INtiaX6HJq/Lt4Z51O0iWkvmAdm2xJ3YW4/ufcg1+tZowbw5JehMPrhLdDBkX7zEjyW6f5QiU0Yl+vnAoWmBztGHJ8HGaIAc4IwOCmBcA3Hjwb3h1iQ8Epf5aebmFuqs7pGv0YOhbbm0c4DzLvMfO8yJEXp6yC6U77uDpRKw7xqtdy6wWibmgNe74X0e1gpVM/o1miC4PfQKwCH5DwAteZkxk9dhUiQMOVpO5zlq96dIVHeCCGLOCyeQyvmJ/HiGubAHuVrL877+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6wSvSUbltN1f8L3HXFrC/wUnstw5nR1l1x+7kPayoE=;
 b=sjG0+eVynTzPeJIMYmmdHZBSgZAVhqLVIMiMlAi7W778UW9betwEDM4keAtWZ0GfIvactVdlL9dG0r+gK6nmFlMokEISiLSjSGagQleipYSdSi+EIV/Cqcj0D8JQ9agOW7gi6vUYPFAtNrYnN82dV8+3wu0nwlc0K2ow866LNxVeDALictX3vkHOZp3AzQEU2ILUd4JcKOi3XxCN/igyccFWWh8v2rQJBvKZZAGz7MoNwAHDmz4ZsCrE67lcAog0/QrzKbmvyVLVpYuVDrlHhaK2ZreXDi7gMHpVcxy5b8tkrIuvVJSLe78Er5gWjgz3Rgsl1BV5C3pLYbu/5GKsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6wSvSUbltN1f8L3HXFrC/wUnstw5nR1l1x+7kPayoE=;
 b=CEDZsKi7y1TiD0GAdqMkz4uScQ1Jvbdo1sq/uOFxpkOXkBmhrr8s2Kb36wpXoqOPe5B/rUQWFnglRWOYggDXJ0/6xzbH1aEvJ6jcgOYqz4JKsZKsteuHBXR8xAX+1RyrrwLKvaQxcROMi5Zir8PavDQeuP6xEOsjEFYxbr3+h8U=
Received: from MN0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:52c::14)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:40:05 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:52c:cafe::83) by MN0PR05CA0023.outlook.office365.com
 (2603:10b6:208:52c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:04 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:00 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sridevi Arvindekar <sridevi.arvindekar@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 03/34] drm/amd/display: Fix audio test errors
Date: Wed, 5 Aug 2026 14:36:15 +0800
Message-ID: <20260805063937.2145774-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 291e5c37-b302-4246-e570-08def2bc627e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 73xSF/iFrOila+HZfon0/0km5VRR3ibaja47hMI3cCMc7aohwJ/mPNc8sUCJ6ECgQoRhPtkMllfR/Mu0Px5XA9kqHYVbBFm+V5Z0JG/Tlp8l7z4SNjwxsg8Y2UrjOt22Kpyt6Qlf0LI0YhjTl/L2CepuW0NflWn0CUd8J9grwjTMvIjzOAzsGx4siEGazGfGRER5EOtVSR16jjfzChMLVnaW5ExmvtsLX0N+jiAta/cO7b83dLcvqRjhEWJ5TrfQIq4ZsmtjzzVdPftpVBunZVerVhqVZxGnFgzLZgbHwK5D0UjOKV1K8EXC5jMEUGF04raPngBwcoCuGeT9NzPQgJuTr1wk9V2sSUHsgFDM8n6LEZq5nIMa/FJqzf9qfjBqnfW/6Ns01Ba0o5KXw08bAihpS52W450WuYYCsfyTm+2T5MhZol5ira2KlGoCUsIqJb7yrz0nljU7qV6FcUfjYYiglbO91jgpR7H3R4LDSYFEQk/8Yq8iMJmwoS2rC0PBHJUahPIWXJ0/RKmeMtZ8qE/ZzpLf5nD62U6VAkcnjsA1VtpSCV8XcGdkWYVJE5Cu3ELjJx9HrmTLiA9e6GGXA9Madm6hyFVDcw042qlzeC1lD6Ejm4ixCiEnYfFbJjJcv1AKafTilFakLamLz2qkw41aBWxwGliPwCVrMM6gcNgCOw7ldA+/aIfabxLCqe/MQaFg0DPs5tcshwOpwp9UXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j4wbvKT43HwGS3BvYXYMIMPoAOpcPLnh9fS22BMpMoN5JeCXX5u7izaKiAH+r1P7+gD5Zhzduoos9XbIuWCikDv0izN+56GCHI1bFrS/qukdF64aBUkvrCDer3tXeJLgXd+TDE560GiIDSv0dFRtR4sULZnCd7sgQPKiYhLx+j5KpXwplC82D3sDVqUsZq8yzykIAsdSHDTg2UrW6ckIuV/rq5OZ3dciXdanE6S/iV0yzXXHI/cmwC3QdbL1BuGJhqNnKR3yojpc/9ZJxSOUQ+9iPsrsG/9CTK9VNgqv6xyHmMGpjyfLN5Y2ebdF7RXV4+VYVrR/kQQ2IMNmOZ6InU0jV/9xFgsbcOvATWqLjfhs1R/req5yDjrRZ7F6I+S8QX529kRj+QDa4In8wJ/Ols7JWq+40WJYNvKy1ga6RWjE2MQgrDhFy+dfdQn3fV6y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:05.3092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291e5c37-b302-4246-e570-08def2bc627e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
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

From: Sridevi Arvindekar <sridevi.arvindekar@amd.com>

[Why/How]
Use appropriate audio register fields.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 4b7668abf4dc..1cbff128789d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -372,11 +372,11 @@ static const struct dcn30_hpo_frl_link_encoder_mask hpo_le_mask = {
 static struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_regs[4];
 
 static const struct dcn31_hpo_dp_stream_encoder_shift hpo_dp_se_shift = {
-	DCN3_1_HPO_DP_STREAM_ENC_MASK_SH_LIST(__SHIFT)
+	DCN4_2_HPO_DP_STREAM_ENC_MASK_SH_LIST(__SHIFT)
 };
 
 static const struct dcn31_hpo_dp_stream_encoder_mask hpo_dp_se_mask = {
-	DCN3_1_HPO_DP_STREAM_ENC_MASK_SH_LIST(_MASK)
+	DCN4_2_HPO_DP_STREAM_ENC_MASK_SH_LIST(_MASK)
 };
 
 #define hpo_dp_link_encoder_reg_init(id)\
-- 
2.43.0

